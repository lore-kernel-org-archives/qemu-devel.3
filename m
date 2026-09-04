Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8184CC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2ThO-0004lJ-Ef; Fri, 04 Sep 2026 09:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2ThM-0004bO-Bh
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2ThJ-00056y-I3
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCXucoL8Mp5Xawf0NyQ8CctTkqOhSXlAR32lSlOVTKM=;
 b=VMwsilzosFd86Ihbv1IKdeLg2duU72DTGjd2l7gXEdHH2/AuyTgnjInkCB7aQShYCitt7w
 wq3vWAA28h28+sKfyHN88TZudhwFtHVDEkFNem1YhzQ01lcTbrzVhL+MtzhQaiKWNsefSa
 86lmhZE8biGhpITKiQbbrEN5BSSwILk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-hj8x8K7RMguAjjHwYM08Lg-1; Fri,
 04 Sep 2026 09:11:09 -0400
X-MC-Unique: hj8x8K7RMguAjjHwYM08Lg-1
X-Mimecast-MFC-AGG-ID: hj8x8K7RMguAjjHwYM08Lg_1788527468
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7533F1886982; Fri,  4 Sep 2026 13:11:08 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00A13427; Fri,  4 Sep 2026 13:11:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:17 +0400
Subject: [PATCH v2 13/25] ui: make GL context current before releasing
 DMA-BUF textures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-13-15b5ae6b0023@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7561;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=T5midtH6nj5RLjRDE79ajOg0zyaO3Y/HJs9rjpCqG3c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMwdvWFsBSUuyaohx6UrgNFr22mCnK/jXLTQ
 +2U5xqE5/2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDMAAKCRDa6OEJdZac
 5e88D/9m1rzk9rjfWf18S7QgoGNn5hZNrXvOgdirYeFfJ0/y0K2A++NBUIsGE6X7oS0UjIZnD8j
 la+nCLQvek4oLl7u/04K6JjUfjZvySifR81JXH4Y03SevuNClB37G2ADpacLRfFJi4DbO257bqD
 Fyl7XypRBxHgtgp0+M6REop8B5uPo357eCMtTuxr+cgQ5gsU4tV/DiYDE60+ePIQSrvQhJu3v9+
 uAzL/DphBDHpMcDCRgHckjGzfGNY/01F+i0CMu6aTJIzlG/d9FGymVFSLckHgWZpBilw7esi01i
 7G1v0m1Z0Vs3gZI+BvaUtdtr+3efoSIx+WAhRUcW8z3vD9Q3Zhgxvzl5BWIK7JJq1FovUHEDhhE
 OOqBwy0Gk2z1kdpHI8+lW515v8Xm0u7FxP2RQ8ot5+Snxv7dPVwbzBI/M0pZ42wpwHjg0c2fhbL
 lWuprP6YpAUpGU04F3yf2Ez8vcnbwf0mpRRpcg1/6y9yd6ISsCRezIMtxzSk9iySAMW99Lk4Z4Y
 AdSCbnJISFemIT0VrBbM1yUoDwuzGvcrimNOgbwpw1D0QCk+ABbzWmXVbuzHOGUEQPRTV5te0+N
 mPjS8WjFW2FZKjuhjtoiAQOyAhlbZJcTsBcoGUYh3UAGwn7rgjxvxy9LmUF4Kb3xO7WXQY6b2MK
 SzVUY9kJX8cPUJQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The dpy_gl_release_dmabuf callbacks in the GTK, SDL, egl-headless,
and spice backends call egl_dmabuf_release_texture(), which calls
glDeleteTextures(), without first making the owning GL context
current. This is reachable after another console's surface update
leaves EGL_NO_CONTEXT current (e.g. gd_egl_update clears the context
on return). The deletion then silently fails, leaking the GL texture
and its backing storage. With an unshared context current, a
coincident texture name could even be deleted from the wrong context.

Fix by making the appropriate GL context current in each backend's
release callback before calling egl_dmabuf_release_texture():

- GTK EGL: eglMakeCurrent with the VC's EGL context
- GTK GL Area: gtk_gl_area_make_current
- SDL: SDL_GL_MakeCurrent with the console's window context
- egl-headless: eglMakeCurrent with the render-node context
- spice: eglMakeCurrent with the render-node context

For GTK, the previously shared gd_gl_release_dmabuf is split into
backend-specific gd_egl_release_dmabuf and gd_gl_area_release_dmabuf,
matching the existing pattern where each backend manages its own
context.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/gtk.h   |  5 +++++
 ui/egl-headless.c  |  2 ++
 ui/gtk-egl.c       | 12 ++++++++++++
 ui/gtk-gl-area.c   | 11 +++++++++++
 ui/gtk.c           | 13 ++++---------
 ui/sdl2-gl.c       |  1 +
 ui/spice-display.c |  2 ++
 7 files changed, 37 insertions(+), 9 deletions(-)

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
index ba27efcf4c3e..ffe7b30f919b 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -126,6 +126,8 @@ static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
 static void egl_release_dmabuf(DisplayChangeListener *dcl,
                                QemuDmaBuf *dmabuf)
 {
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
     egl_dmabuf_release_texture(dmabuf);
 }
 
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
index 46eff768c968..3a5aa09618ca 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -288,6 +288,7 @@ void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
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


