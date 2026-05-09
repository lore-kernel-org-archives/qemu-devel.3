Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7E4CD37AF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlIQ-0000Mo-8L; Sat, 09 May 2026 13:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlIB-00004w-J7
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlI7-0005KZ-Ey
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778346998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+c4BIrOH8DkncyyrvHy+6mRNt8eywsptgQTzkEOG+U=;
 b=dYtMOe4469AWJRRMMEOon9mBn5aXRV5il8fFqy02Jn5A1ZwhgG5WhaYi/aW9rIY88eQHGE
 PmnfkHhTwM/QL59zwo+Qmi+iP2TZEGYZTsgEgMIgslx5nhzoraaX3LLd2sx5LXsuMOXLaT
 g7uwYsxJgvGTnGvtTGX+0TAU+hFhjNI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-BvnryurSMzCnQOPU4uqJ4A-1; Sat,
 09 May 2026 13:16:36 -0400
X-MC-Unique: BvnryurSMzCnQOPU4uqJ4A-1
X-Mimecast-MFC-AGG-ID: BvnryurSMzCnQOPU4uqJ4A_1778346995
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E66E195605F; Sat,  9 May 2026 17:16:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 294781800352; Sat,  9 May 2026 17:16:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL v2 26/33] ui/console: simplify registering display/console
 change listener
Date: Sat,  9 May 2026 21:13:47 +0400
Message-ID: <20260509171356.1157879-27-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Introduce qemu_console_register_listener() which combines setting
dcl->con, dcl->ops and calling register_displaychangelistener() into a
single call. This removes repetitive boilerplate across all display
backends and makes it harder to forget setting one of the fields.

Also move the early-return check in unregister_displaychangelistener()
before the trace call, so that unregistering a never-registered listener
(e.g. on error paths) does not dereference a NULL ops pointer.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  6 ++++--
 hw/display/qxl.c     |  4 +---
 ui/console.c         | 11 ++++++++---
 ui/curses.c          |  9 +++------
 ui/dbus-console.c    |  6 ++----
 ui/dbus-listener.c   | 27 ++++++++-------------------
 ui/egl-headless.c    |  4 +---
 ui/gtk.c             | 10 ++++------
 ui/sdl2.c            |  8 +++-----
 ui/spice-display.c   |  8 +++-----
 ui/vnc.c             | 11 ++++-------
 ui/cocoa.m           | 13 ++++---------
 12 files changed, 45 insertions(+), 72 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 89fb4c1942a..69ac7b01b33 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -291,10 +291,12 @@ struct DisplayGLCtx {
 
 DisplayState *init_displaystate(void);
 
-void register_displaychangelistener(DisplayChangeListener *dcl);
+void qemu_console_register_listener(QemuConsole *con,
+                                    DisplayChangeListener *dcl,
+                                    const DisplayChangeListenerOps *ops);
 void update_displaychangelistener(DisplayChangeListener *dcl,
                                   uint64_t interval);
-void unregister_displaychangelistener(DisplayChangeListener *dcl);
+void qemu_console_unregister_listener(DisplayChangeListener *dcl);
 
 bool dpy_ui_info_supported(const QemuConsole *con);
 const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con);
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 0a3c42c8ec2..4244ebe51d2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2251,9 +2251,7 @@ static void qxl_realize_primary(PCIDevice *dev, Error **errp)
         return;
     }
 
-    qxl->ssd.dcl.ops = &display_listener_ops;
-    qxl->ssd.dcl.con = vga->con;
-    register_displaychangelistener(&qxl->ssd.dcl);
+    qemu_console_register_listener(vga->con, &qxl->ssd.dcl, &display_listener_ops);
 }
 
 static void qxl_realize_secondary(PCIDevice *dev, Error **errp)
diff --git a/ui/console.c b/ui/console.c
index b837ce1c9fc..4f3b4394268 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -572,10 +572,15 @@ dcl_set_graphic_cursor(DisplayChangeListener *dcl, QemuGraphicConsole *con)
     }
 }
 
-void register_displaychangelistener(DisplayChangeListener *dcl)
+void qemu_console_register_listener(QemuConsole *con,
+                                    DisplayChangeListener *dcl,
+                                    const DisplayChangeListenerOps *ops)
 {
     assert(!dcl->ds);
 
+    dcl->con = con;
+    dcl->ops = ops;
+
     trace_displaychangelistener_register(dcl, dcl->ops->dpy_name);
     dcl->ds = get_alloc_displaystate();
     QLIST_INSERT_HEAD(&dcl->ds->listeners, dcl, next);
@@ -600,10 +605,10 @@ void update_displaychangelistener(DisplayChangeListener *dcl,
     }
 }
 
-void unregister_displaychangelistener(DisplayChangeListener *dcl)
+void qemu_console_unregister_listener(DisplayChangeListener *dcl)
 {
     DisplayState *ds = dcl->ds;
-    trace_displaychangelistener_unregister(dcl, dcl->ops->dpy_name);
+    trace_displaychangelistener_unregister(dcl, dcl->ops ? dcl->ops->dpy_name : NULL);
     if (!ds) {
         return;
     }
diff --git a/ui/curses.c b/ui/curses.c
index 96427aa6bb9..dbb5992981c 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -324,9 +324,8 @@ static void curses_refresh(DisplayChangeListener *dcl)
                         if (con) {
                             erase();
                             wnoutrefresh(stdscr);
-                            unregister_displaychangelistener(dcl);
-                            dcl->con = con;
-                            register_displaychangelistener(dcl);
+                            qemu_console_unregister_listener(dcl);
+                            qemu_console_register_listener(con, dcl, dcl->ops);
 
                             invalidate = 1;
                         }
@@ -805,9 +804,7 @@ static void curses_display_init(DisplayState *ds, DisplayOptions *opts)
     curses_winch_init();
 
     dcl = g_new0(DisplayChangeListener, 1);
-    dcl->con = qemu_console_lookup_default();
-    dcl->ops = &dcl_ops;
-    register_displaychangelistener(dcl);
+    qemu_console_register_listener(qemu_console_lookup_default(), dcl, &dcl_ops);
 
     invalidate = 1;
 }
diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 564f004bd86..23f547a673d 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -143,7 +143,6 @@ dbus_display_console_init(DBusDisplayConsole *object)
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
     ddc->listeners = g_ptr_array_new_with_free_func(g_object_unref);
-    ddc->dcl.ops = &dbus_console_dcl_ops;
 }
 
 static void
@@ -151,7 +150,7 @@ dbus_display_console_dispose(GObject *object)
 {
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
-    unregister_displaychangelistener(&ddc->dcl);
+    qemu_console_unregister_listener(&ddc->dcl);
     g_clear_object(&ddc->iface_touch);
     g_clear_object(&ddc->iface_mouse);
     g_clear_object(&ddc->iface_kbd);
@@ -553,7 +552,6 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
                         "g-object-path", path,
                         NULL);
     ddc->display = display;
-    ddc->dcl.con = con;
     /* handle errors, and skip non graphics? */
     qemu_console_fill_device_address(
         con, device_addr, sizeof(device_addr), NULL);
@@ -611,7 +609,7 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
         slot->tracking_id = -1;
     }
 
-    register_displaychangelistener(&ddc->dcl);
+    qemu_console_register_listener(con, &ddc->dcl, &dbus_console_dcl_ops);
     ddc->mouse_mode_notifier.notify = dbus_mouse_mode_change;
     qemu_add_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
     dbus_mouse_update_is_absolute(ddc);
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index e5ce92d1257..cc2c969686e 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -957,7 +957,7 @@ dbus_display_listener_dispose(GObject *object)
 {
     DBusDisplayListener *ddl = DBUS_DISPLAY_LISTENER(object);
 
-    unregister_displaychangelistener(&ddl->dcl);
+    qemu_console_unregister_listener(&ddl->dcl);
     g_clear_object(&ddl->conn);
     g_clear_pointer(&ddl->bus_name, g_free);
     g_clear_object(&ddl->proxy);
@@ -978,28 +978,12 @@ dbus_display_listener_dispose(GObject *object)
     G_OBJECT_CLASS(dbus_display_listener_parent_class)->dispose(object);
 }
 
-static void
-dbus_display_listener_constructed(GObject *object)
-{
-    DBusDisplayListener *ddl = DBUS_DISPLAY_LISTENER(object);
-
-    ddl->dcl.ops = &dbus_dcl_ops;
-#ifdef CONFIG_OPENGL
-    if (display_opengl) {
-        ddl->dcl.ops = &dbus_gl_dcl_ops;
-    }
-#endif
-
-    G_OBJECT_CLASS(dbus_display_listener_parent_class)->constructed(object);
-}
-
 static void
 dbus_display_listener_class_init(DBusDisplayListenerClass *klass)
 {
     GObjectClass *object_class = G_OBJECT_CLASS(klass);
 
     object_class->dispose = dbus_display_listener_dispose;
-    object_class->constructed = dbus_display_listener_constructed;
 }
 
 static void
@@ -1258,6 +1242,7 @@ dbus_display_listener_new(const char *bus_name,
                           GDBusConnection *conn,
                           DBusDisplayConsole *console)
 {
+    const DisplayChangeListenerOps *ops = &dbus_dcl_ops;
     DBusDisplayListener *ddl;
     QemuConsole *con;
     g_autoptr(GError) err = NULL;
@@ -1290,8 +1275,12 @@ dbus_display_listener_new(const char *bus_name,
 
     con = qemu_console_lookup_by_index(dbus_display_console_get_index(console));
     assert(con);
-    ddl->dcl.con = con;
-    register_displaychangelistener(&ddl->dcl);
+#ifdef CONFIG_OPENGL
+    if (display_opengl) {
+        ops = &dbus_gl_dcl_ops;
+    }
+#endif
+    qemu_console_register_listener(con, &ddl->dcl, ops);
 
     return ddl;
 }
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 352b30b43fb..4f046c975a9 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -229,13 +229,11 @@ static void egl_headless_init(DisplayState *ds, DisplayOptions *opts)
         }
 
         edpy = g_new0(egl_dpy, 1);
-        edpy->dcl.con = con;
-        edpy->dcl.ops = &egl_ops;
         edpy->gls = qemu_gl_init_shader();
         ctx = g_new0(DisplayGLCtx, 1);
         ctx->ops = &eglctx_ops;
         qemu_console_set_display_gl_ctx(con, ctx);
-        register_displaychangelistener(&edpy->dcl);
+        qemu_console_register_listener(con, &edpy->dcl, &egl_ops);
     }
 }
 
diff --git a/ui/gtk.c b/ui/gtk.c
index ec95f0f294a..ef3707b3634 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2251,6 +2251,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               QemuConsole *con, int idx,
                               GSList *group, GtkWidget *view_menu)
 {
+    const DisplayChangeListenerOps *ops = &dcl_ops;
     bool zoom_to_fit = false;
     int i;
 
@@ -2275,7 +2276,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
             vc->gfx.drawing_area = gtk_gl_area_new();
             g_signal_connect(vc->gfx.drawing_area, "realize",
                              G_CALLBACK(gl_area_realize), vc);
-            vc->gfx.dcl.ops = &dcl_gl_area_ops;
+            ops = &dcl_gl_area_ops;
             vc->gfx.dgc.ops = &gl_area_ctx_ops;
         } else {
 #ifdef CONFIG_X11
@@ -2290,7 +2291,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
             gtk_widget_set_double_buffered(vc->gfx.drawing_area, FALSE);
 #pragma GCC diagnostic pop
-            vc->gfx.dcl.ops = &dcl_egl_ops;
+            ops = &dcl_egl_ops;
             vc->gfx.dgc.ops = &egl_ctx_ops;
             vc->gfx.has_dmabuf = qemu_egl_has_dmabuf();
 #else
@@ -2301,7 +2302,6 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
 #endif
     {
         vc->gfx.drawing_area = gtk_drawing_area_new();
-        vc->gfx.dcl.ops = &dcl_ops;
     }
 
 
@@ -2325,12 +2325,10 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                              vc->tab_item, gtk_label_new(vc->label));
 
     vc->gfx.kbd = qkbd_state_init(con);
-    vc->gfx.dcl.con = con;
-
     if (display_opengl) {
         qemu_console_set_display_gl_ctx(con, &vc->gfx.dgc);
     }
-    register_displaychangelistener(&vc->gfx.dcl);
+    qemu_console_register_listener(con, &vc->gfx.dcl, ops);
 
     gd_connect_vc_gfx_signals(vc);
     group = gd_vc_menu_init(s, vc, idx, group, view_menu);
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 5dd612d9a6a..89516f95c41 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -934,6 +934,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     sdl2_console = g_new0(struct sdl2_console, sdl2_num_outputs);
     for (i = 0; i < sdl2_num_outputs; i++) {
         QemuConsole *con = qemu_console_lookup_by_index(i);
+        const DisplayChangeListenerOps *ops = &dcl_2d_ops;
         assert(con != NULL);
         if (!qemu_console_is_graphic(con) &&
             qemu_console_get_index(con) != 0) {
@@ -943,13 +944,11 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         sdl2_console[i].opts = o;
 #ifdef CONFIG_OPENGL
         sdl2_console[i].opengl = display_opengl;
-        sdl2_console[i].dcl.ops = display_opengl ? &dcl_gl_ops : &dcl_2d_ops;
         sdl2_console[i].dgc.ops = display_opengl ? &gl_ctx_ops : NULL;
+        ops = display_opengl ? &dcl_gl_ops : &dcl_2d_ops;
 #else
         sdl2_console[i].opengl = 0;
-        sdl2_console[i].dcl.ops = &dcl_2d_ops;
 #endif
-        sdl2_console[i].dcl.con = con;
         sdl2_console[i].kbd = qkbd_state_init(con);
 #ifdef CONFIG_OPENGL
         if (display_opengl) {
@@ -957,8 +956,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
             sdl2_gl_console_init(&sdl2_console[i]);
         }
 #endif
-        register_displaychangelistener(&sdl2_console[i].dcl);
-
+        qemu_console_register_listener(con, &sdl2_console[i].dcl, ops);
 #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
         if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
 #if defined(SDL_VIDEO_DRIVER_WINDOWS)
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 87cc193cdee..56d8140fad8 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1387,13 +1387,13 @@ static void qemu_spice_display_init_one(QemuConsole *con)
     SimpleSpiceDisplay *ssd = g_new0(SimpleSpiceDisplay, 1);
     Error *err = NULL;
     char device_address[256] = "";
+    const DisplayChangeListenerOps *ops = &display_listener_ops;
 
     qemu_spice_display_init_common(ssd);
 
-    ssd->dcl.ops = &display_listener_ops;
 #ifdef HAVE_SPICE_GL
     if (spice_opengl) {
-        ssd->dcl.ops = &display_listener_gl_ops;
+        ops = &display_listener_gl_ops;
         ssd->dgc.ops = &gl_ctx_ops;
         ssd->gl_unblock_bh = qemu_bh_new(qemu_spice_gl_unblock_bh, ssd);
         ssd->gl_unblock_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
@@ -1403,8 +1403,6 @@ static void qemu_spice_display_init_one(QemuConsole *con)
         ssd->have_scanout = false;
     }
 #endif
-    ssd->dcl.con = con;
-
     ssd->qxl.base.sif = &dpy_interface.base;
     qemu_spice_add_display_interface(&ssd->qxl, con);
 
@@ -1422,7 +1420,7 @@ static void qemu_spice_display_init_one(QemuConsole *con)
     if (spice_opengl) {
         qemu_console_set_display_gl_ctx(con, &ssd->dgc);
     }
-    register_displaychangelistener(&ssd->dcl);
+    qemu_console_register_listener(con, &ssd->dcl, ops);
 }
 
 void qemu_spice_display_init(void)
diff --git a/ui/vnc.c b/ui/vnc.c
index 154b07e2e4e..e8c8773a36e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1860,10 +1860,9 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
             qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_ALT)) {
             QemuConsole *con = qemu_console_lookup_by_index(qcode - Q_KEY_CODE_1);
             if (con) {
-                unregister_displaychangelistener(&vs->vd->dcl);
+                qemu_console_unregister_listener(&vs->vd->dcl);
                 qkbd_state_switch_console(vs->vd->kbd, con);
-                vs->vd->dcl.con = con;
-                register_displaychangelistener(&vs->vd->dcl);
+                qemu_console_register_listener(con, &vs->vd->dcl, vs->vd->dcl.ops);
             }
             return;
         }
@@ -3434,7 +3433,6 @@ VncDisplay *vnc_display_new(const char *id, Error **errp)
     vd = g_new0(VncDisplay, 1);
     qemu_mutex_init(&vd->mutex);
     vd->id = g_strdup(id);
-    vd->dcl.ops = &dcl_ops;
 
     QTAILQ_INIT(&vd->clients);
     vd->expires = TIME_MAX;
@@ -3524,7 +3522,7 @@ void vnc_display_free(VncDisplay *vd)
     }
 
     vnc_stop_worker_thread(vd);
-    unregister_displaychangelistener(&vd->dcl);
+    qemu_console_unregister_listener(&vd->dcl);
     qkbd_state_free(vd->kbd);
     qemu_del_vm_change_state_handler(vd->vmstate_handler_entry);
     kbd_layout_free(vd->kbd_layout);
@@ -4267,8 +4265,7 @@ static bool vnc_display_open(VncDisplay *vd, Error **errp)
         con = qemu_console_lookup_default();
     }
 
-    vd->dcl.con = con;
-    register_displaychangelistener(&vd->dcl);
+    qemu_console_register_listener(con, &vd->dcl, &dcl_ops);
     vd->kbd = qkbd_state_init(vd->dcl.con);
     qkbd_state_set_delay(vd->kbd, key_delay_ms);
 
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 9093d1e408f..aaf82421589 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -93,9 +93,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
     .dpy_mouse_set = cocoa_mouse_set,
     .dpy_cursor_define = cocoa_cursor_define,
 };
-static DisplayChangeListener dcl = {
-    .ops = &dcl_ops,
-};
+static DisplayChangeListener dcl;
 static QKbdState *kbd;
 static int cursor_hide = 1;
 static int left_command_key_enabled = 1;
@@ -425,8 +423,7 @@ - (void) selectConsoleLocked:(unsigned int)index
 
     unregister_displaychangelistener(&dcl);
     qkbd_state_switch_console(kbd, con);
-    dcl.con = con;
-    register_displaychangelistener(&dcl);
+    qemu_console_register_listener(con, &dcl, &dcl_ops);
     [self notifyMouseModeChange];
     [self updateUIInfo];
 }
@@ -2145,11 +2142,9 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     add_console_menu_entries();
     addRemovableDevicesMenuItems();
 
-    dcl.con = qemu_console_lookup_default();
+    qemu_console_register_listener(qemu_console_lookup_default(),
+                                   &dcl, &dcl_ops);
     kbd = qkbd_state_init(dcl.con);
-
-    // register vga output callbacks
-    register_displaychangelistener(&dcl);
     qemu_add_mouse_mode_change_notifier(&mouse_mode_change_notifier);
     [cocoaView notifyMouseModeChange];
     [cocoaView updateUIInfo];
-- 
2.54.0


