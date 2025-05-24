Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74E2C5B541
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsne-0002Qa-I7; Sat, 24 May 2025 13:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsnP-0001V3-N3
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsnN-0000mG-KJ
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4k5+NTFiMxqkyu2x9DOplosPFgVjD9e9EjTHIrElbs8=;
 b=EXNRGO0hBiU2KJq9BUWuKo49/KLFDHJjsPQpCNKkSI2/joALumXgoNX40pKBEFqsaWQ3iD
 rIgfcxW+CnHUG+B+y7fqKCSHLr4SF21uMAqZpyHEye6VA76EyWKEp0iR4RaCyXW+98KQFb
 UpSCMMHLA8iMBPGG1cuNqZx+JAXqo+8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-yd8LuReMMaKhg641XXD6HA-1; Sat,
 24 May 2025 13:36:24 -0400
X-MC-Unique: yd8LuReMMaKhg641XXD6HA-1
X-Mimecast-MFC-AGG-ID: yd8LuReMMaKhg641XXD6HA_1748108183
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56061195608A; Sat, 24 May 2025 17:36:23 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 157DA195608D; Sat, 24 May 2025 17:36:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com, Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PULL 19/19] ui/gtk-egl: Render guest content with padding in
 fixed-scale mode
Date: Sat, 24 May 2025 19:35:12 +0200
Message-ID: <20250524173514.317886-20-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Scaling was not respected when rendering frames in gtk-egl.c (used if
gl=on and X11 mode). To fix this, add fields x and y to struct egl_fb
for x offset and y offset so we can add padding to window.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Message-ID: <20250511073337.876650-10-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/egl-helpers.h |  4 +++-
 ui/egl-helpers.c         | 10 ++++++++--
 ui/gtk-egl.c             | 36 +++++++++++++++++++++++++++++++-----
 ui/sdl2-gl.c             |  2 +-
 4 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index fb80e15142..acf993fcf5 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -17,6 +17,8 @@ extern bool qemu_egl_angle_d3d;
 typedef struct egl_fb {
     int width;
     int height;
+    int x;
+    int y;
     GLuint texture;
     GLuint framebuffer;
     bool delete_texture;
@@ -26,7 +28,7 @@ typedef struct egl_fb {
 #define EGL_FB_INIT { 0, }
 
 void egl_fb_destroy(egl_fb *fb);
-void egl_fb_setup_default(egl_fb *fb, int width, int height);
+void egl_fb_setup_default(egl_fb *fb, int width, int height, int x, int y);
 void egl_fb_setup_for_tex(egl_fb *fb, int width, int height,
                           GLuint texture, bool delete);
 void egl_fb_setup_new_tex(egl_fb *fb, int width, int height);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 9cda2bbbee..5503a795e4 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -93,14 +93,18 @@ void egl_fb_destroy(egl_fb *fb)
 
     fb->width = 0;
     fb->height = 0;
+    fb->x = 0;
+    fb->y = 0;
     fb->texture = 0;
     fb->framebuffer = 0;
 }
 
-void egl_fb_setup_default(egl_fb *fb, int width, int height)
+void egl_fb_setup_default(egl_fb *fb, int width, int height, int x, int y)
 {
     fb->width = width;
     fb->height = height;
+    fb->x = x;
+    fb->y = y;
     fb->framebuffer = 0; /* default framebuffer */
 }
 
@@ -145,6 +149,7 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
     glBindFramebuffer(GL_READ_FRAMEBUFFER, src->framebuffer);
     glBindFramebuffer(GL_DRAW_FRAMEBUFFER, dst->framebuffer);
     glViewport(0, 0, dst->width, dst->height);
+    glClear(GL_COLOR_BUFFER_BIT);
 
     if (src->dmabuf) {
         x1 = qemu_dmabuf_get_x(src->dmabuf);
@@ -161,7 +166,8 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
     x2 = x1 + w;
 
     glBlitFramebuffer(x1, y1, x2, y2,
-                      0, 0, dst->width, dst->height,
+                      dst->x, dst->y,
+                      dst->x + dst->width, dst->y + dst->height,
                       GL_COLOR_BUFFER_BIT, GL_LINEAR);
 }
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index f8e4f4bc70..0b787bea25 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -340,7 +340,11 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GdkWindow *window;
-    int ww, wh, ws;
+    int px_offset, py_offset;
+    int gs;
+    int pw_widget, ph_widget, pw_surface, ph_surface;
+    int ww_widget, wh_widget, ww_surface, wh_surface;
+    int fbw, fbh;
 
     if (!vc->gfx.scanout_mode) {
         return;
@@ -353,10 +357,32 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                    vc->gfx.esurface, vc->gfx.ectx);
 
     window = gtk_widget_get_window(vc->gfx.drawing_area);
-    ws = gdk_window_get_scale_factor(window);
-    ww = gdk_window_get_width(window) * ws;
-    wh = gdk_window_get_height(window) * ws;
-    egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
+    gs = gdk_window_get_scale_factor(window);
+    ww_widget = gdk_window_get_width(window);
+    wh_widget = gdk_window_get_height(window);
+    fbw = surface_width(vc->gfx.ds);
+    fbh = surface_height(vc->gfx.ds);
+
+    gd_update_scale(vc, ww_widget, wh_widget, fbw, fbh);
+
+    ww_surface = fbw * vc->gfx.scale_x;
+    wh_surface = fbh * vc->gfx.scale_y;
+    pw_widget = ww_widget * gs;
+    ph_widget = wh_widget * gs;
+    pw_surface = ww_surface * gs;
+    ph_surface = wh_surface * gs;
+
+    px_offset = 0;
+    py_offset = 0;
+    if (pw_widget > pw_surface) {
+        px_offset = (pw_widget - pw_surface) / 2;
+    }
+    if (ph_widget > ph_surface) {
+        py_offset = (ph_widget - ph_surface) / 2;
+    }
+
+    egl_fb_setup_default(&vc->gfx.win_fb, pw_surface, ph_surface,
+                         px_offset, py_offset);
     if (vc->gfx.cursor_fb.texture) {
         egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb,
                          vc->gfx.y0_top);
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index e01d9ab0c7..3be17d1079 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -241,7 +241,7 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
     SDL_GetWindowSize(scon->real_window, &ww, &wh);
-    egl_fb_setup_default(&scon->win_fb, ww, wh);
+    egl_fb_setup_default(&scon->win_fb, ww, wh, 0, 0);
     egl_fb_blit(&scon->win_fb, &scon->guest_fb, !scon->y0_top);
 
     SDL_GL_SwapWindow(scon->real_window);
-- 
2.49.0


