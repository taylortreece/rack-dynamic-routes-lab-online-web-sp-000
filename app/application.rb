require 'pry'
class Application
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)

            item_name = req.path.split("/items/").last
            available_item = @@items.find {|item| item.name == item_name}
            if available_item
              resp.write available_item.price
            else
                resp.status = 400
                resp.write "Item not found"
            end
        else
            resp.status = 404
            resp.write "Route not found"
        end

        resp.finish
    end
end

Application.new