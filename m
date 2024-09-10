Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5E0EDE99A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so41l-0007Bg-E8; Tue, 10 Sep 2024 12:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41b-0006rx-IN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41V-0007Ze-Sr
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7TEeDRNI4nlkcZXLYiB+Dgz0gXilxg9iKvDeu32MDsY=;
 b=fh7zL30DNWYqR25sjpIB435rC9mH4FE8bKqaFgoRWeQwvzc9VJ7JW+0XHrP5tGPrU2b3xc
 IZC79qfO68a7iwJmJBPRz9DuVUWmEgEjKefnzSLRpkSoFAHORZwFDDr9T49lQhM/rAZCSr
 t8bDa467IVAYLHsSD/KVtXN7qosUw50=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-2WZ-qFHXPZqIwOPrBQeUtg-1; Tue,
 10 Sep 2024 12:47:20 -0400
X-MC-Unique: 2WZ-qFHXPZqIwOPrBQeUtg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B52E919560AB; Tue, 10 Sep 2024 16:47:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D4CF3001476; Tue, 10 Sep 2024 16:47:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8BF7B21E68BD; Tue, 10 Sep 2024 18:47:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 08/19] qapi/ui: Drop temporary 'prefix'
Date: Tue, 10 Sep 2024 18:47:03 +0200
Message-ID: <20240910164714.1993531-9-armbru@redhat.com>
In-Reply-To: <20240910164714.1993531-1-armbru@redhat.com>
References: <20240910164714.1993531-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Recent commit "qapi: Smarter camel_to_upper() to reduce need for
'prefix'" added a temporary 'prefix' to delay changing the generated
code.

Revert it.  This improves DisplayGLMode's generated enumeration
constant prefix from DISPLAYGL_MODE to DISPLAY_GL_MODE.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240904111836.3273842-9-armbru@redhat.com>
---
 qapi/ui.json      |  1 -
 system/vl.c       |  2 +-
 ui/dbus.c         |  8 ++++----
 ui/egl-context.c  |  2 +-
 ui/egl-headless.c |  2 +-
 ui/egl-helpers.c  | 12 ++++++------
 ui/gtk.c          |  4 ++--
 ui/sdl2-gl.c      |  8 ++++----
 ui/sdl2.c         |  2 +-
 ui/spice-core.c   |  2 +-
 10 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index f61a2b6b65..460a26b981 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1397,7 +1397,6 @@
 # Since: 3.0
 ##
 { 'enum'    : 'DisplayGLMode',
-  'prefix'  : 'DISPLAYGL_MODE', # TODO drop
   'data'    : [ 'off', 'on', 'core', 'es' ] }
 
 ##
diff --git a/system/vl.c b/system/vl.c
index 01b8b8e77a..fe547ca47c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1971,7 +1971,7 @@ static void qemu_create_early_backends(void)
 
     qemu_console_early_init();
 
-    if (dpy.has_gl && dpy.gl != DISPLAYGL_MODE_OFF && display_opengl == 0) {
+    if (dpy.has_gl && dpy.gl != DISPLAY_GL_MODE_OFF && display_opengl == 0) {
 #if defined(CONFIG_OPENGL)
         error_report("OpenGL is not supported by display backend '%s'",
                      DisplayType_str(dpy.type));
diff --git a/ui/dbus.c b/ui/dbus.c
index e08b5de064..7ecd39e784 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -176,7 +176,7 @@ dbus_display_add_console(DBusDisplay *dd, int idx, Error **errp)
     assert(con);
 
     if (qemu_console_is_graphic(con) &&
-        dd->gl_mode != DISPLAYGL_MODE_OFF) {
+        dd->gl_mode != DISPLAY_GL_MODE_OFF) {
         qemu_console_set_display_gl_ctx(con, &dd->glctx);
     }
 
@@ -466,9 +466,9 @@ static const TypeInfo dbus_vc_type_info = {
 static void
 early_dbus_init(DisplayOptions *opts)
 {
-    DisplayGLMode mode = opts->has_gl ? opts->gl : DISPLAYGL_MODE_OFF;
+    DisplayGLMode mode = opts->has_gl ? opts->gl : DISPLAY_GL_MODE_OFF;
 
-    if (mode != DISPLAYGL_MODE_OFF) {
+    if (mode != DISPLAY_GL_MODE_OFF) {
 #ifdef CONFIG_OPENGL
         egl_init(opts->u.dbus.rendernode, mode, &error_fatal);
 #else
@@ -482,7 +482,7 @@ early_dbus_init(DisplayOptions *opts)
 static void
 dbus_init(DisplayState *ds, DisplayOptions *opts)
 {
-    DisplayGLMode mode = opts->has_gl ? opts->gl : DISPLAYGL_MODE_OFF;
+    DisplayGLMode mode = opts->has_gl ? opts->gl : DISPLAY_GL_MODE_OFF;
 
     if (opts->u.dbus.addr && opts->u.dbus.p2p) {
         error_report("dbus: can't accept both addr=X and p2p=yes options");
diff --git a/ui/egl-context.c b/ui/egl-context.c
index 9e0df466f3..aed3e3ba1f 100644
--- a/ui/egl-context.c
+++ b/ui/egl-context.c
@@ -17,7 +17,7 @@ QEMUGLContext qemu_egl_create_context(DisplayGLCtx *dgc,
        EGL_CONTEXT_MINOR_VERSION_KHR, params->minor_ver,
        EGL_NONE
    };
-   bool gles = (qemu_egl_mode == DISPLAYGL_MODE_ES);
+   bool gles = (qemu_egl_mode == DISPLAY_GL_MODE_ES);
 
    ctx = eglCreateContext(qemu_egl_display, qemu_egl_config,
                           eglGetCurrentContext(),
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 6187249c73..1f6b845500 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -207,7 +207,7 @@ static const DisplayGLCtxOps eglctx_ops = {
 
 static void early_egl_headless_init(DisplayOptions *opts)
 {
-    DisplayGLMode mode = DISPLAYGL_MODE_ON;
+    DisplayGLMode mode = DISPLAY_GL_MODE_ON;
 
     if (opts->has_gl) {
         mode = opts->gl;
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 99b2ebbe23..81a57fa975 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -503,7 +503,7 @@ static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
     EGLint major, minor;
     EGLBoolean b;
     EGLint n;
-    bool gles = (mode == DISPLAYGL_MODE_ES);
+    bool gles = (mode == DISPLAY_GL_MODE_ES);
 
     qemu_egl_display = qemu_egl_get_display(dpy, platform);
     if (qemu_egl_display == EGL_NO_DISPLAY) {
@@ -533,7 +533,7 @@ static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
         return -1;
     }
 
-    qemu_egl_mode = gles ? DISPLAYGL_MODE_ES : DISPLAYGL_MODE_CORE;
+    qemu_egl_mode = gles ? DISPLAY_GL_MODE_ES : DISPLAY_GL_MODE_CORE;
     return 0;
 }
 
@@ -564,8 +564,8 @@ int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy, DisplayGLMode mode)
 int qemu_egl_init_dpy_win32(EGLNativeDisplayType dpy, DisplayGLMode mode)
 {
     /* prefer GL ES, as that's what ANGLE supports */
-    if (mode == DISPLAYGL_MODE_ON) {
-        mode = DISPLAYGL_MODE_ES;
+    if (mode == DISPLAY_GL_MODE_ON) {
+        mode = DISPLAY_GL_MODE_ES;
     }
 
     if (qemu_egl_init_dpy(dpy, 0, mode) < 0) {
@@ -618,7 +618,7 @@ EGLContext qemu_egl_init_ctx(void)
         EGL_CONTEXT_CLIENT_VERSION, 2,
         EGL_NONE
     };
-    bool gles = (qemu_egl_mode == DISPLAYGL_MODE_ES);
+    bool gles = (qemu_egl_mode == DISPLAY_GL_MODE_ES);
     EGLContext ectx;
     EGLBoolean b;
 
@@ -642,7 +642,7 @@ bool egl_init(const char *rendernode, DisplayGLMode mode, Error **errp)
 {
     ERRP_GUARD();
 
-    if (mode == DISPLAYGL_MODE_OFF) {
+    if (mode == DISPLAY_GL_MODE_OFF) {
         error_setg(errp, "egl: turning off GL doesn't make sense");
         return false;
     }
diff --git a/ui/gtk.c b/ui/gtk.c
index 8e14c2ac81..bf9d3dd679 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2514,7 +2514,7 @@ static void early_gtk_display_init(DisplayOptions *opts)
     }
 
     assert(opts->type == DISPLAY_TYPE_GTK);
-    if (opts->has_gl && opts->gl != DISPLAYGL_MODE_OFF) {
+    if (opts->has_gl && opts->gl != DISPLAY_GL_MODE_OFF) {
 #if defined(CONFIG_OPENGL)
 #if defined(GDK_WINDOWING_WAYLAND)
         if (GDK_IS_WAYLAND_DISPLAY(gdk_display_get_default())) {
@@ -2530,7 +2530,7 @@ static void early_gtk_display_init(DisplayOptions *opts)
 #endif
         {
 #ifdef CONFIG_X11
-            DisplayGLMode mode = opts->has_gl ? opts->gl : DISPLAYGL_MODE_ON;
+            DisplayGLMode mode = opts->has_gl ? opts->gl : DISPLAY_GL_MODE_ON;
             gtk_egl_init(mode);
 #endif
         }
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 91b7ee2419..e01d9ab0c7 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -147,11 +147,11 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx *dgc,
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
     SDL_GL_SetAttribute(SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1);
-    if (scon->opts->gl == DISPLAYGL_MODE_ON ||
-        scon->opts->gl == DISPLAYGL_MODE_CORE) {
+    if (scon->opts->gl == DISPLAY_GL_MODE_ON ||
+        scon->opts->gl == DISPLAY_GL_MODE_CORE) {
         SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
                             SDL_GL_CONTEXT_PROFILE_CORE);
-    } else if (scon->opts->gl == DISPLAYGL_MODE_ES) {
+    } else if (scon->opts->gl == DISPLAY_GL_MODE_ES) {
         SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
                             SDL_GL_CONTEXT_PROFILE_ES);
     }
@@ -163,7 +163,7 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx *dgc,
     /* If SDL fail to create a GL context and we use the "on" flag,
      * then try to fallback to GLES.
      */
-    if (!ctx && scon->opts->gl == DISPLAYGL_MODE_ON) {
+    if (!ctx && scon->opts->gl == DISPLAY_GL_MODE_ON) {
         SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
                             SDL_GL_CONTEXT_PROFILE_ES);
         ctx = SDL_GL_CreateContext(scon->real_window);
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 98ed974371..251ce97796 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -107,7 +107,7 @@ void sdl2_window_create(struct sdl2_console *scon)
     if (scon->opengl) {
         const char *driver = "opengl";
 
-        if (scon->opts->gl == DISPLAYGL_MODE_ES) {
+        if (scon->opts->gl == DISPLAY_GL_MODE_ES) {
             driver = "opengles2";
         }
 
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 15be640286..bd9dbe03f1 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -840,7 +840,7 @@ static void qemu_spice_init(void)
                          "incompatible with -spice port/tls-port");
             exit(1);
         }
-        egl_init(qemu_opt_get(opts, "rendernode"), DISPLAYGL_MODE_ON, &error_fatal);
+        egl_init(qemu_opt_get(opts, "rendernode"), DISPLAY_GL_MODE_ON, &error_fatal);
         spice_opengl = 1;
     }
 #endif
-- 
2.46.0


