classdef PTKToolCallback < handle
    % PTKToolCallback. 
    %
    %
    %
    %     Licence
    %     -------
    %     Part of the TD Pulmonary Toolkit. https://github.com/tomdoel/pulmonarytoolkit
    %     Author: Tom Doel, 2014.  www.tomdoel.com
    %     Distributed under the GNU GPL v3 licence. Please see website for details.
    %
    
    properties (Access = private)
        Axes
        ImageDisplayParameters
        Reporting
        ViewerPanel
    end
    
    methods
        
        function obj = PTKToolCallback(viewing_panel, image_display_parameters, reporting)
            obj.ImageDisplayParameters = image_display_parameters;
            obj.ViewerPanel = viewing_panel;
            obj.Reporting = reporting;
        end

        function SetAxes(obj, axes)
            if isempty(axes)
                obj.Reporting.Error('PTKToolCallback:AxesDoNotExist', 'SetAxes() was called with empty axes');
            end
            obj.Axes = axes;
        end

        function EnablePan(obj, enabled)
            obj.GetAxes.EnablePan(enabled);
        end        
        
        function EnableZoom(obj, enabled)
            obj.GetAxes.EnableZoom(enabled);
        end
        
        function [min_coords, max_coords] = GetImageLimits(obj)
            % Gets the current limits of the visible image axes
 
            [min_coords, max_coords] = obj.GetAxes.GetImageLimits;
        end
        
        function SetImageLimits(obj, min_coords, max_coords)
            % Adjusts the image axes to make the image visible between the specified
            % coordinates
            
            x_lim = [min_coords(1), max_coords(1)];
            y_lim = [min_coords(2), max_coords(2)];
            obj.GetAxes.SetLimits(x_lim, y_lim);
        end
        
        function SetWindowWithinLimits(obj, window)
            % Sets the window subject to the current constraints
            
            window_limits = obj.ViewerPanel.WindowLimits;
            if ~isempty(window_limits)
                window = max(window, window_limits(1));
                window = min(window, window_limits(2));
                obj.ImageDisplayParameters.Window = window;
            end
        end

        function SetLevelWithinLimits(obj, level)
            % Sets the level subject to the current constraints
            
            level_limits = obj.ViewerPanel.LevelLimits;
            if ~isempty(level_limits)
                level = max(level, level_limits(1));
                level = min(level, level_limits(2));
                obj.ImageDisplayParameters.Level = level;
            end
        end

        function axes_handle = GetAxes(obj)
            axes_handle = obj.Axes;
            if isempty(axes_handle)
                obj.Reporting.Error('PTKToolCallback:AxesDoNotExist', 'Axes have not been created');
            end
        end
        
        function axes_handle = GetAxesHandle(obj)
            axes_handle = obj.GetAxes.GetContainerHandle;
        end
        
    end
end

