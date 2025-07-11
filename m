Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B47C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua94C-0006VW-Bc; Fri, 11 Jul 2025 04:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xQ-0004Md-Vs; Fri, 11 Jul 2025 04:18:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xO-0003zL-9W; Fri, 11 Jul 2025 04:18:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5D35E1356CF;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 513E023FA44;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Weifeng Liu <weifeng.liu.z@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 04/39] ui/gtk: Use consistent naming for variables in
 different coordinates
Date: Fri, 11 Jul 2025 11:16:00 +0300
Message-ID: <20250711081745.1785806-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Weifeng Liu <weifeng.liu.z@gmail.com>

Now that we've documented definitions and presentation of various
coordinates, let's enforce the rules.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Message-ID: <20250511073337.876650-3-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 3a6b314409b42fe7c46c2bd80cfc2a6744d414fe)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index f7a428c86a..947c99334b 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -70,16 +70,18 @@ void gd_egl_draw(VirtualConsole *vc)
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
     int fence_fd;
 #endif
-    int ww, wh, ws;
+    int ww, wh, pw, ph, gs;
 
     if (!vc->gfx.gls) {
         return;
     }
 
     window = gtk_widget_get_window(vc->gfx.drawing_area);
-    ws = gdk_window_get_scale_factor(window);
-    ww = gdk_window_get_width(window) * ws;
-    wh = gdk_window_get_height(window) * ws;
+    gs = gdk_window_get_scale_factor(window);
+    ww = gdk_window_get_width(window);
+    wh = gdk_window_get_height(window);
+    pw = ww * gs;
+    ph = wh * gs;
 
     if (vc->gfx.scanout_mode) {
 #ifdef CONFIG_GBM
@@ -115,7 +117,7 @@ void gd_egl_draw(VirtualConsole *vc)
         eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                        vc->gfx.esurface, vc->gfx.ectx);
 
-        surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, ww, wh);
+        surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, pw, ph);
         surface_gl_render_texture(vc->gfx.gls, vc->gfx.ds);
 
         eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 2c9a0db425..ba9fbec432 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -42,16 +42,16 @@ void gd_gl_area_draw(VirtualConsole *vc)
 #ifdef CONFIG_GBM
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 #endif
-    int ww, wh, ws, y1, y2;
+    int pw, ph, gs, y1, y2;
 
     if (!vc->gfx.gls) {
         return;
     }
 
     gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
-    ws = gdk_window_get_scale_factor(gtk_widget_get_window(vc->gfx.drawing_area));
-    ww = gtk_widget_get_allocated_width(vc->gfx.drawing_area) * ws;
-    wh = gtk_widget_get_allocated_height(vc->gfx.drawing_area) * ws;
+    gs = gdk_window_get_scale_factor(gtk_widget_get_window(vc->gfx.drawing_area));
+    pw = gtk_widget_get_allocated_width(vc->gfx.drawing_area) * gs;
+    ph = gtk_widget_get_allocated_height(vc->gfx.drawing_area) * gs;
 
     if (vc->gfx.scanout_mode) {
         if (!vc->gfx.guest_fb.framebuffer) {
@@ -71,11 +71,11 @@ void gd_gl_area_draw(VirtualConsole *vc)
         glBindFramebuffer(GL_READ_FRAMEBUFFER, vc->gfx.guest_fb.framebuffer);
         /* GtkGLArea sets GL_DRAW_FRAMEBUFFER for us */
 
-        glViewport(0, 0, ww, wh);
+        glViewport(0, 0, pw, ph);
         y1 = vc->gfx.y0_top ? 0 : vc->gfx.h;
         y2 = vc->gfx.y0_top ? vc->gfx.h : 0;
         glBlitFramebuffer(0, y1, vc->gfx.w, y2,
-                          0, 0, ww, wh,
+                          0, 0, pw, ph,
                           GL_COLOR_BUFFER_BIT, GL_NEAREST);
 #ifdef CONFIG_GBM
         if (dmabuf) {
@@ -101,7 +101,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
         }
         gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
 
-        surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, ww, wh);
+        surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, pw, ph);
         surface_gl_render_texture(vc->gfx.gls, vc->gfx.ds);
     }
 }
diff --git a/ui/gtk.c b/ui/gtk.c
index 582841e031..956d4ab9d1 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -387,16 +387,16 @@ static void *gd_win32_get_hwnd(VirtualConsole *vc)
 /** DisplayState Callbacks **/
 
 static void gd_update(DisplayChangeListener *dcl,
-                      int x, int y, int w, int h)
+                      int fbx, int fby, int fbw, int fbh)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GdkWindow *win;
-    int x1, x2, y1, y2;
-    int mx, my;
-    int fbw, fbh;
-    int ww, wh;
+    int wx1, wx2, wy1, wy2;
+    int wx_offset, wy_offset;
+    int ww_surface, wh_surface;
+    int ww_widget, wh_widget;
 
-    trace_gd_update(vc->label, x, y, w, h);
+    trace_gd_update(vc->label, fbx, fby, fbw, fbh);
 
     if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
         return;
@@ -405,35 +405,36 @@ static void gd_update(DisplayChangeListener *dcl,
     if (vc->gfx.convert) {
         pixman_image_composite(PIXMAN_OP_SRC, vc->gfx.ds->image,
                                NULL, vc->gfx.convert,
-                               x, y, 0, 0, x, y, w, h);
+                               fbx, fby, 0, 0, fbx, fby, fbw, fbh);
     }
 
-    x1 = floor(x * vc->gfx.scale_x);
-    y1 = floor(y * vc->gfx.scale_y);
+    wx1 = floor(fbx * vc->gfx.scale_x);
+    wy1 = floor(fby * vc->gfx.scale_y);
 
-    x2 = ceil(x * vc->gfx.scale_x + w * vc->gfx.scale_x);
-    y2 = ceil(y * vc->gfx.scale_y + h * vc->gfx.scale_y);
+    wx2 = ceil(fbx * vc->gfx.scale_x + fbw * vc->gfx.scale_x);
+    wy2 = ceil(fby * vc->gfx.scale_y + fbh * vc->gfx.scale_y);
 
-    fbw = surface_width(vc->gfx.ds) * vc->gfx.scale_x;
-    fbh = surface_height(vc->gfx.ds) * vc->gfx.scale_y;
+    ww_surface = surface_width(vc->gfx.ds) * vc->gfx.scale_x;
+    wh_surface = surface_height(vc->gfx.ds) * vc->gfx.scale_y;
 
     win = gtk_widget_get_window(vc->gfx.drawing_area);
     if (!win) {
         return;
     }
-    ww = gdk_window_get_width(win);
-    wh = gdk_window_get_height(win);
+    ww_widget = gdk_window_get_width(win);
+    wh_widget = gdk_window_get_height(win);
 
-    mx = my = 0;
-    if (ww > fbw) {
-        mx = (ww - fbw) / 2;
+    wx_offset = wy_offset = 0;
+    if (ww_widget > ww_surface) {
+        wx_offset = (ww_widget - ww_surface) / 2;
     }
-    if (wh > fbh) {
-        my = (wh - fbh) / 2;
+    if (wh_widget > wh_surface) {
+        wy_offset = (wh_widget - wh_surface) / 2;
     }
 
     gtk_widget_queue_draw_area(vc->gfx.drawing_area,
-                               mx + x1, my + y1, (x2 - x1), (y2 - y1));
+                               wx_offset + wx1, wy_offset + wy1,
+                               (wx2 - wx1), (wy2 - wy1));
 }
 
 static void gd_refresh(DisplayChangeListener *dcl)
@@ -869,8 +870,8 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
 {
     VirtualConsole *vc = opaque;
     GtkDisplayState *s = vc->s;
-    int mx, my;
-    int ww, wh;
+    int wx_offset, wy_offset;
+    int ww_widget, wh_widget, ww_surface, wh_surface;
     int fbw, fbh;
 
 #if defined(CONFIG_OPENGL)
@@ -904,46 +905,47 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
     fbw = surface_width(vc->gfx.ds);
     fbh = surface_height(vc->gfx.ds);
 
-    ww = gdk_window_get_width(gtk_widget_get_window(widget));
-    wh = gdk_window_get_height(gtk_widget_get_window(widget));
+    ww_widget = gdk_window_get_width(gtk_widget_get_window(widget));
+    wh_widget = gdk_window_get_height(gtk_widget_get_window(widget));
 
     if (s->full_screen) {
-        vc->gfx.scale_x = (double)ww / fbw;
-        vc->gfx.scale_y = (double)wh / fbh;
+        vc->gfx.scale_x = (double)ww_widget / fbw;
+        vc->gfx.scale_y = (double)wh_widget / fbh;
     } else if (s->free_scale) {
         double sx, sy;
 
-        sx = (double)ww / fbw;
-        sy = (double)wh / fbh;
+        sx = (double)ww_widget / fbw;
+        sy = (double)wh_widget / fbh;
 
         vc->gfx.scale_x = vc->gfx.scale_y = MIN(sx, sy);
     }
 
-    fbw *= vc->gfx.scale_x;
-    fbh *= vc->gfx.scale_y;
+    ww_surface = fbw * vc->gfx.scale_x;
+    wh_surface = fbh * vc->gfx.scale_y;
 
-    mx = my = 0;
-    if (ww > fbw) {
-        mx = (ww - fbw) / 2;
+    wx_offset = wy_offset = 0;
+    if (ww_widget > ww_surface) {
+        wx_offset = (ww_widget - ww_surface) / 2;
     }
-    if (wh > fbh) {
-        my = (wh - fbh) / 2;
+    if (wh_widget > wh_surface) {
+        wy_offset = (wh_widget - wh_surface) / 2;
     }
 
-    cairo_rectangle(cr, 0, 0, ww, wh);
+    cairo_rectangle(cr, 0, 0, ww_widget, wh_widget);
 
     /* Optionally cut out the inner area where the pixmap
        will be drawn. This avoids 'flashing' since we're
        not double-buffering. Note we're using the undocumented
        behaviour of drawing the rectangle from right to left
        to cut out the whole */
-    cairo_rectangle(cr, mx + fbw, my,
-                    -1 * fbw, fbh);
+    cairo_rectangle(cr, wx_offset + ww_surface, wy_offset,
+                    -1 * ww_surface, wh_surface);
     cairo_fill(cr);
 
     cairo_scale(cr, vc->gfx.scale_x, vc->gfx.scale_y);
     cairo_set_source_surface(cr, vc->gfx.surface,
-                             mx / vc->gfx.scale_x, my / vc->gfx.scale_y);
+                             wx_offset / vc->gfx.scale_x,
+                             wy_offset / vc->gfx.scale_y);
     cairo_paint(cr);
 
     return TRUE;
@@ -954,19 +956,19 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
 {
     VirtualConsole *vc = opaque;
     GtkDisplayState *s = vc->s;
-    int x, y;
-    int mx, my;
-    int fbh, fbw;
-    int ww, wh;
+    int fbx, fby;
+    int wx_offset, wy_offset;
+    int wh_surface, ww_surface;
+    int ww_widget, wh_widget;
 
     if (!vc->gfx.ds) {
         return TRUE;
     }
 
-    fbw = surface_width(vc->gfx.ds) * vc->gfx.scale_x;
-    fbh = surface_height(vc->gfx.ds) * vc->gfx.scale_y;
-    ww = gtk_widget_get_allocated_width(widget);
-    wh = gtk_widget_get_allocated_height(widget);
+    ww_surface = surface_width(vc->gfx.ds) * vc->gfx.scale_x;
+    wh_surface = surface_height(vc->gfx.ds) * vc->gfx.scale_y;
+    ww_widget = gtk_widget_get_allocated_width(widget);
+    wh_widget = gtk_widget_get_allocated_height(widget);
 
     /*
      * `widget` may not have the same size with the frame buffer.
@@ -974,41 +976,42 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
      * To achieve that, `vc` will be displayed at (mx, my)
      * so that it is displayed at the center of the widget.
      */
-    mx = my = 0;
-    if (ww > fbw) {
-        mx = (ww - fbw) / 2;
+    wx_offset = wy_offset = 0;
+    if (ww_widget > ww_surface) {
+        wx_offset = (ww_widget - ww_surface) / 2;
     }
-    if (wh > fbh) {
-        my = (wh - fbh) / 2;
+    if (wh_widget > wh_surface) {
+        wy_offset = (wh_widget - wh_surface) / 2;
     }
 
     /*
      * `motion` is reported in `widget` coordinates
      * so translating it to the coordinates in `vc`.
      */
-    x = (motion->x - mx) / vc->gfx.scale_x;
-    y = (motion->y - my) / vc->gfx.scale_y;
+    fbx = (motion->x - wx_offset) / vc->gfx.scale_x;
+    fby = (motion->y - wy_offset) / vc->gfx.scale_y;
 
-    trace_gd_motion_event(ww, wh, gtk_widget_get_scale_factor(widget), x, y);
+    trace_gd_motion_event(ww_widget, wh_widget,
+                          gtk_widget_get_scale_factor(widget), fbx, fby);
 
     if (qemu_input_is_absolute(vc->gfx.dcl.con)) {
-        if (x < 0 || y < 0 ||
-            x >= surface_width(vc->gfx.ds) ||
-            y >= surface_height(vc->gfx.ds)) {
+        if (fbx < 0 || fby < 0 ||
+            fbx >= surface_width(vc->gfx.ds) ||
+            fby >= surface_height(vc->gfx.ds)) {
             return TRUE;
         }
-        qemu_input_queue_abs(vc->gfx.dcl.con, INPUT_AXIS_X, x,
+        qemu_input_queue_abs(vc->gfx.dcl.con, INPUT_AXIS_X, fbx,
                              0, surface_width(vc->gfx.ds));
-        qemu_input_queue_abs(vc->gfx.dcl.con, INPUT_AXIS_Y, y,
+        qemu_input_queue_abs(vc->gfx.dcl.con, INPUT_AXIS_Y, fby,
                              0, surface_height(vc->gfx.ds));
         qemu_input_event_sync();
     } else if (s->last_set && s->ptr_owner == vc) {
-        qemu_input_queue_rel(vc->gfx.dcl.con, INPUT_AXIS_X, x - s->last_x);
-        qemu_input_queue_rel(vc->gfx.dcl.con, INPUT_AXIS_Y, y - s->last_y);
+        qemu_input_queue_rel(vc->gfx.dcl.con, INPUT_AXIS_X, fbx - s->last_x);
+        qemu_input_queue_rel(vc->gfx.dcl.con, INPUT_AXIS_Y, fby - s->last_y);
         qemu_input_event_sync();
     }
-    s->last_x = x;
-    s->last_y = y;
+    s->last_x = fbx;
+    s->last_y = fby;
     s->last_set = TRUE;
 
     if (!qemu_input_is_absolute(vc->gfx.dcl.con) && s->ptr_owner == vc) {
-- 
2.47.2


