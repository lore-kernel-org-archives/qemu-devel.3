Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A08C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4esK-0004Qy-5t; Thu, 10 Sep 2026 09:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esH-0004Dt-8m
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4esE-0003iq-Pe
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rz3cRjEGnveKnwufJJi2+HGkcMFpRaSK4bgbFJpIYJA=;
 b=YEGwzxxG0/rXUe3lNRvs2+YzHd5E3Nxxf2zMlKR0oNhxaX1WZ3aexG+vKhmavSy5V0OJDF
 OiKznTjjpZcAXncJS0qAOk/U2jV25IhDlBKyqsVWbjeUZN05SZ0FhaeeECClJc9MPYb7cc
 6NJ6jO4aSrAXbEN12ce1/69XGT5k77U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-k-YEAbyXPluGAm71tkJkfw-1; Thu,
 10 Sep 2026 09:31:23 -0400
X-MC-Unique: k-YEAbyXPluGAm71tkJkfw-1
X-Mimecast-MFC-AGG-ID: k-YEAbyXPluGAm71tkJkfw_1789047082
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B24C1956072; Thu, 10 Sep 2026 13:31:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFDB118004D4; Thu, 10 Sep 2026 13:31:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:08 +0400
Subject: [GIT PULL 13/24] ui: make GL context current in display backend
 callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-13-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11389;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1N0CPgj7fFx3zSyApzb8lq0OZjP8DnXs/DzRZkuaWoM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDceWapbGNaQzpMySmq0LlyH587XTDKH1+ZN
 xJWiaTpcMCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3AAKCRDa6OEJdZac
 5VqnD/4uJMk4XDMuFjbbZTVjTYtkfgWrmObRlJlpFZ1u2yPgiO4VM8d5sXAAQ0yC5Ttwr53UuN9
 Uk3wvhiHH9YwUcUVwQLdRTRFLEwfWapyglsZfxsEgfg0M+V/3vpEckJAiAECG+V16Vdjp2IE95O
 FexL6wF3MZ81v/7CwBRIc00wPZrrw2PAOf2BhmhM8NyFxCVeJWebWli7xvt19JFZlyn2Z3/0oO8
 42UCnmJ1nCEt7SnHCXzoyirkzAYAchKnzayWqjFse/JLiHiT3x4dovtDHvSLMpL/1SVhIFZfOcr
 Y0Am2MUlL39NKGYgtdISuUL5Txmzzrgp4dfDbOHXiQE4sl2gpi3pMF8cOg32cmgM6bVjtb/PIMK
 BQU1I3RkDQPTU3AAZBRrfFiNxl8utEM7HG/QTvlDruid5GZJh4UnvOyG+oGHVX54KRaagf+TLqU
 WlQSfj2nPMQ3TS9sPHhgiSEEfhsQ3r9/VsHLazVqAMbDkQoKqwD6XljFNuveBrNLRR16yPcx92p
 wnBviVLE0Chh7mcc8DQDznDMCDrKKv5XucdDXriP6NQu9fjmJpp/vH3Yi+VhOwq7I6p26LOOXxc
 +rLaeYYu+BBD5DS7slrsgkCQep5gz0kx35ykgIKkMGnweLJgrWNYaSir2xvEieckrMVYy0m6RMg
 oGNmtr018ZpF5yA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Display backend GL callbacks (scanout, flush, release, etc.) may be
invoked from a different GL context, like virgl. Since framebuffer
objects are per-context and textures require a valid context for
deletion, each callback must ensure the correct context is active before
performing GL operations.

Make each backend's own GL context current at the entry of every
callback that performs GL work.

For GTK, the previously shared gd_gl_release_dmabuf is split into
backend-specific gd_egl_release_dmabuf and gd_gl_area_release_dmabuf,
matching the existing pattern where each backend manages its own
context.

On the virgl side, restore ctx0 with virgl_renderer_force_ctx_0()
after SET_SCANOUT, RESOURCE_FLUSH, and SET_SCANOUT_BLOB command
handlers, since their display callbacks may have changed the current
GL context.

Note: restoring virgl ctx0 current is not necessarily correct,
fences may not work. We will follow-up with a complementary fix.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c |  4 ++++
 include/ui/gtk.h              |  5 +++++
 ui/egl-headless.c             | 17 +++++++++++++++++
 ui/gtk-egl.c                  | 12 ++++++++++++
 ui/gtk-gl-area.c              | 11 +++++++++++
 ui/gtk.c                      | 13 ++++---------
 ui/sdl2-gl.c                  |  2 ++
 ui/spice-display.c            |  2 ++
 8 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 7f1d1e0c3276..0e43eacca406 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1091,9 +1091,12 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         break;
     case VIRTIO_GPU_CMD_SET_SCANOUT:
         virgl_cmd_set_scanout(g, cmd);
+        /* Display callbacks may change the current GL context. */
+        virgl_renderer_force_ctx_0();
         break;
     case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
         virgl_cmd_resource_flush(g, cmd);
+        virgl_renderer_force_ctx_0();
         break;
     case VIRTIO_GPU_CMD_RESOURCE_UNREF:
         virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
@@ -1130,6 +1133,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         break;
     case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
         virgl_cmd_set_scanout_blob(g, cmd);
+        virgl_renderer_force_ctx_0();
         break;
 #endif
     default:
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index b66b9ca5c519..6b62e9758813 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -163,6 +163,7 @@ extern bool gtk_use_gl_area;
 void gd_update_windowsize(VirtualConsole *vc);
 void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *widget);
 void gd_gl_wait_sync(VirtualConsole *vc, void *sync);
+void gd_release_dmabuf(VirtualConsole *vc, QemuDmaBuf *dmabuf);
 
 /* ui/gtk-egl.c */
 void gd_egl_init(VirtualConsole *vc);
@@ -190,6 +191,8 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
                           uint32_t hot_x, uint32_t hot_y);
 void gd_egl_cursor_position(DisplayChangeListener *dcl,
                             uint32_t pos_x, uint32_t pos_y);
+void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf);
 void gd_egl_flush(DisplayChangeListener *dcl,
                   uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 void *gd_egl_scanout_flush(DisplayChangeListener *dcl,
@@ -221,6 +224,8 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
                                 uint32_t x, uint32_t y,
                                 uint32_t w, uint32_t h,
                                 void *d3d_tex2d);
+void gd_gl_area_release_dmabuf(DisplayChangeListener *dcl,
+                               QemuDmaBuf *dmabuf);
 void gd_gl_area_scanout_disable(DisplayChangeListener *dcl);
 void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
                               uint32_t x, uint32_t y, uint32_t w, uint32_t h);
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index ba27efcf4c3e..c3f319c0960b 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -52,6 +52,8 @@ static void egl_scanout_disable(DisplayChangeListener *dcl)
 {
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
 
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
     egl_fb_destroy(&edpy->guest_fb);
     egl_fb_destroy(&edpy->blit_fb);
 }
@@ -69,6 +71,9 @@ static void egl_scanout_texture(DisplayChangeListener *dcl,
 
     edpy->y_0_top = backing_y_0_top;
 
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
+
     /* source framebuffer */
     egl_fb_setup_for_tex(&edpy->guest_fb,
                          backing_width, backing_height, backing_id, false);
@@ -88,6 +93,8 @@ static void egl_scanout_dmabuf(DisplayChangeListener *dcl,
 {
     uint32_t width, height, texture;
 
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
     egl_dmabuf_import_texture(dmabuf);
     texture = qemu_dmabuf_get_texture(dmabuf);
     if (!texture) {
@@ -108,6 +115,8 @@ static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
     uint32_t width, height, texture;
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
 
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
     if (dmabuf) {
         egl_dmabuf_import_texture(dmabuf);
         texture = qemu_dmabuf_get_texture(dmabuf);
@@ -126,6 +135,8 @@ static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
 static void egl_release_dmabuf(DisplayChangeListener *dcl,
                                QemuDmaBuf *dmabuf)
 {
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
     egl_dmabuf_release_texture(dmabuf);
 }
 
@@ -151,6 +162,8 @@ static void egl_scanout_flush(DisplayChangeListener *dcl,
     }
     assert(surface_format(edpy->ds) == PIXMAN_x8r8g8b8);
 
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
     if (edpy->cursor_fb.texture) {
         /* have cursor -> render using textures */
         egl_texture_blit(edpy->gls, &edpy->blit_fb, &edpy->guest_fb,
@@ -225,6 +238,8 @@ static void egl_headless_init(DisplayState *ds, DisplayOptions *opts)
 
     egl_dpys = g_ptr_array_new();
 
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
     for (idx = 0;; idx++) {
         DisplayGLCtx *ctx;
 
@@ -250,6 +265,8 @@ static void egl_headless_cleanup(void)
         return;
     }
 
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
     for (guint i = 0; i < egl_dpys->len; i++) {
         egl_dpy *edpy = g_ptr_array_index(egl_dpys, i);
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 8623181336e9..d595916476d9 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -426,6 +426,18 @@ void gtk_egl_init(DisplayGLMode mode)
     display_opengl = 1;
 }
 
+void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf)
+{
+#ifdef CONFIG_GBM
+    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
+
+    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                   vc->gfx.esurface, vc->gfx.ectx);
+    gd_release_dmabuf(vc, dmabuf);
+#endif
+}
+
 int gd_egl_make_current(DisplayGLCtx *dgc,
                         QEMUGLContext ctx)
 {
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 45c0c8c81a11..effd88f28721 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -360,6 +360,17 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 #endif
 }
 
+void gd_gl_area_release_dmabuf(DisplayChangeListener *dcl,
+                               QemuDmaBuf *dmabuf)
+{
+#ifdef CONFIG_GBM
+    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
+
+    gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
+    gd_release_dmabuf(vc, dmabuf);
+#endif
+}
+
 void gtk_gl_area_init(void)
 {
     display_opengl = 1;
diff --git a/ui/gtk.c b/ui/gtk.c
index 55e45e8445bc..c615d35451b6 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -584,21 +584,16 @@ static bool gd_has_dmabuf(DisplayChangeListener *dcl)
     return vc->gfx.has_dmabuf;
 }
 
-static void gd_gl_release_dmabuf(DisplayChangeListener *dcl,
-                                 QemuDmaBuf *dmabuf)
-{
 #ifdef CONFIG_GBM
-    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
-
+void gd_release_dmabuf(VirtualConsole *vc, QemuDmaBuf *dmabuf)
+{
     egl_dmabuf_release_texture(dmabuf);
     if (vc->gfx.guest_fb.dmabuf == dmabuf) {
         vc->gfx.guest_fb.dmabuf = NULL;
         vc->gfx.draw_submitted = false;
     }
-#endif
 }
 
-#ifdef CONFIG_GBM
 static void gd_gl_fence_cb(void *vcon)
 {
     VirtualConsole *vc = vcon;
@@ -639,7 +634,7 @@ static const DisplayChangeListenerOps dcl_gl_area_ops = {
     .dpy_gl_scanout_disable  = gd_gl_area_scanout_disable,
     .dpy_gl_update           = gd_gl_area_scanout_flush,
     .dpy_gl_scanout_dmabuf   = gd_gl_area_scanout_dmabuf,
-    .dpy_gl_release_dmabuf   = gd_gl_release_dmabuf,
+    .dpy_gl_release_dmabuf   = gd_gl_area_release_dmabuf,
     .dpy_has_dmabuf          = gd_has_dmabuf,
 };
 
@@ -673,7 +668,7 @@ static const DisplayChangeListenerOps dcl_egl_ops = {
     .dpy_gl_cursor_dmabuf    = gd_egl_cursor_dmabuf,
     .dpy_gl_cursor_position  = gd_egl_cursor_position,
     .dpy_gl_update           = gd_egl_flush,
-    .dpy_gl_release_dmabuf   = gd_gl_release_dmabuf,
+    .dpy_gl_release_dmabuf   = gd_egl_release_dmabuf,
     .dpy_has_dmabuf          = gd_has_dmabuf,
 };
 
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 46eff768c968..f41fc8bb9634 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -200,6 +200,7 @@ void sdl2_gl_scanout_disable(DisplayChangeListener *dcl)
     struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
 
     assert(scon->opengl);
+    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
     scon->w = 0;
     scon->h = 0;
     sdl2_set_scanout_mode(scon, false);
@@ -288,6 +289,7 @@ void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
 {
     struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
 
+    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
     egl_dmabuf_release_texture(dmabuf);
     if (scon->guest_fb.dmabuf == dmabuf) {
         scon->guest_fb.dmabuf = NULL;
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 75c7df7bb5e0..22cd1e266caa 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1176,6 +1176,8 @@ static void qemu_spice_gl_release_dmabuf(DisplayChangeListener *dcl,
         ssd->guest_dmabuf = NULL;
         ssd->guest_dmabuf_refresh = false;
     }
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
     egl_dmabuf_release_texture(dmabuf);
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


