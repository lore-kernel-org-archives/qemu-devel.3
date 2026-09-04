Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10060C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tgw-0003er-E7; Fri, 04 Sep 2026 09:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tgt-0003WV-CU
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tgq-00052c-D0
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aez3Vzz2L5nNo9zPUx7UDK6Ucvaer7z6LWfJn8lF/kg=;
 b=SkJ48s1/cRAQAPkoR1DSCccDToUGHqLvG4We5LYVCs6MeBmvrATIFpGr0vF4ic0GrInf8R
 uWEaCGj3a/sUGM6sLL6PLYK43IEx0p202qZakHkfl9Dbg1aF+9tkaTNhUyD8EwZuNA3+b/
 bummDFal7tPgMInDx54XgHFptgPJCR4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-Buy428M9Os-Ghc6nTCTKJg-1; Fri,
 04 Sep 2026 09:10:39 -0400
X-MC-Unique: Buy428M9Os-Ghc6nTCTKJg-1
X-Mimecast-MFC-AGG-ID: Buy428M9Os-Ghc6nTCTKJg_1788527438
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CD471880937; Fri,  4 Sep 2026 13:10:38 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F350918005AD; Fri,  4 Sep 2026 13:10:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:10 +0400
Subject: [PATCH v2 06/25] ui/gtk: move GL fence tracking from QemuDmaBuf to
 VirtualGfxConsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-6-15b5ae6b0023@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12691;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RToXP8fzo2M51qblwEyDyuaS9Jg+gjoS+E36wu9O4DM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMv08BPWZSSdsuiwMUdEkrM5NavLgzLDsZYH
 bIK0y6BbV2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDLwAKCRDa6OEJdZac
 5fQAD/9212BLB17SMO2jytr6vg08dza+2WWfmV0CHDRKXB8sBDKzUwIQNPjcvS2l0/+/xTekOnU
 siGvkrc2LTkmuZTe8LlmDvIqHYGp7Q84wHGhK75i8OuXazGhzAHF7kGp8iaJEKMGWGegq6LM8dJ
 d4x92kIPA6a4Z2CoaQowIbshWozKjO++okaPe3mWSyIzjHAhDZadsS78RT8I0RarMn09f+bfBZN
 PDNd0ZdXzn2cVjEwFk5r1EUyzF4E8KSBsKIpmMYYYWyCtLIw23j2HEzdpD/ZKH75HQji1U4OOjg
 w3A7Vdg4vH9753EL7+5ro8c4M8Mpt65V1VHpnZ7fFoNS87jMHATfV6jPjFVQug39NNUlwR81ScF
 WCzRnr2OVWgyZaMaWbSOPu12a8EdlhumjOXDG7WbA39I255mNPtmXJwX+JJkFUMee2bKXWe3q/W
 sleJyXjtUOnRA5zqyj9a8zubpFREBAM4SddI+59ZsG33xsfIU1mPfbSRmRQQKDy9ce/agXfNRFX
 vVetyvaOLR204sGlg9Az6F5w+j2Bf4/e+J6nox75MX0RjHebeYspfM4dvMG+Cr537XWssHusDSp
 fQP+GBBskiDK6YVN6ZKT/oLV2vSZsNuaRzQXitaNvaDndPe7msd1keA40eEx6h8H1CpAC7aq2el
 sM2qKxdYBtR9pDg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The sync and fence_fd fields on QemuDmaBuf are only used by the GTK
display backend for GPU fence synchronization during draw. They are not
intrinsic properties of the DMA-BUF itself but transient GL state tied
to the display listener.

Move fence_fd to VirtualGfxConsole and keep the EGL sync local to the
draw operation. Change egl_dmabuf_create_sync() and
egl_dmabuf_create_fence() to return values instead of storing them on the
dmabuf. This makes the fence lifecycle independent of the dmabuf
lifetime.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/dmabuf.h      |  4 ----
 include/ui/egl-helpers.h |  4 ++--
 include/ui/gtk.h         |  8 +++++---
 ui/dmabuf.c              | 29 -----------------------------
 ui/egl-helpers.c         | 15 ++++++++-------
 ui/gtk-egl.c             | 30 ++++++++++++++++--------------
 ui/gtk-gl-area.c         | 12 +++---------
 ui/gtk.c                 | 31 +++++++++++++++++++++++--------
 8 files changed, 57 insertions(+), 76 deletions(-)

diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
index 3decdca4979c..381583bd536c 100644
--- a/include/ui/dmabuf.h
+++ b/include/ui/dmabuf.h
@@ -41,13 +41,9 @@ uint32_t qemu_dmabuf_get_y(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf);
-void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf);
-int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
 void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
-void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd);
-void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync);
 void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted);
 
 #endif
diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 679c79eacd54..533d9afc37ba 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -54,8 +54,8 @@ bool egl_dmabuf_export_texture(uint32_t tex_id, int *fd, EGLint *offset,
 
 void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
 void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
-void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf);
-void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
+EGLSyncKHR egl_create_sync(void);
+int egl_create_fence(EGLSyncKHR sync);
 
 #endif
 
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 5c9c34a069ea..4b4ef50e3701 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -58,6 +58,7 @@ typedef struct VirtualGfxConsole {
     bool y0_top;
     bool scanout_mode;
     bool has_dmabuf;
+    int gl_fence_fd;
 #endif
 } VirtualGfxConsole;
 
@@ -160,7 +161,7 @@ extern bool gtk_use_gl_area;
 /* ui/gtk.c */
 void gd_update_windowsize(VirtualConsole *vc);
 void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *widget);
-void gd_hw_gl_flushed(void *vc);
+void gd_gl_wait_sync(VirtualConsole *vc, void *sync);
 
 /* ui/gtk-egl.c */
 void gd_egl_init(VirtualConsole *vc);
@@ -190,8 +191,9 @@ void gd_egl_cursor_position(DisplayChangeListener *dcl,
                             uint32_t pos_x, uint32_t pos_y);
 void gd_egl_flush(DisplayChangeListener *dcl,
                   uint32_t x, uint32_t y, uint32_t w, uint32_t h);
-void gd_egl_scanout_flush(DisplayChangeListener *dcl,
-                          uint32_t x, uint32_t y, uint32_t w, uint32_t h);
+void *gd_egl_scanout_flush(DisplayChangeListener *dcl,
+                           uint32_t x, uint32_t y,
+                           uint32_t w, uint32_t h);
 void gtk_egl_init(DisplayGLMode mode);
 int gd_egl_make_current(DisplayGLCtx *dgc,
                         QEMUGLContext ctx);
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
index 7433a268f0df..b61dc7ad2783 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -25,8 +25,6 @@ struct QemuDmaBuf {
     uint32_t  backing_width;
     uint32_t  backing_height;
     bool      y0_top;
-    void      *sync;
-    int       fence_fd;
     bool      allow_fences;
     bool      draw_submitted;
 };
@@ -57,7 +55,6 @@ QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
     memcpy(dmabuf->fd, dmabuf_fd, num_planes * sizeof(*dmabuf_fd));
     dmabuf->allow_fences = allow_fences;
     dmabuf->y0_top = y0_top;
-    dmabuf->fence_fd = -1;
     dmabuf->num_planes = num_planes;
 
     return dmabuf;
@@ -208,20 +205,6 @@ bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf)
     return dmabuf->y0_top;
 }
 
-void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->sync;
-}
-
-int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->fence_fd;
-}
-
 bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf)
 {
     assert(dmabuf != NULL);
@@ -242,18 +225,6 @@ void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture)
     dmabuf->texture = texture;
 }
 
-void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd)
-{
-    assert(dmabuf != NULL);
-    dmabuf->fence_fd = fence_fd;
-}
-
-void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync)
-{
-    assert(dmabuf != NULL);
-    dmabuf->sync = sync;
-}
-
 void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted)
 {
     assert(dmabuf != NULL);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 8e3729a54d15..cb9c1e839cf9 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -432,7 +432,7 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
     qemu_dmabuf_set_texture(dmabuf, 0);
 }
 
-void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
+EGLSyncKHR egl_create_sync(void)
 {
     EGLSyncKHR sync;
 
@@ -443,23 +443,24 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
         sync = eglCreateSyncKHR(qemu_egl_display,
                                 EGL_SYNC_NATIVE_FENCE_ANDROID, NULL);
         if (sync != EGL_NO_SYNC_KHR) {
-            qemu_dmabuf_set_sync(dmabuf, sync);
+            return sync;
         }
     }
+
+    return NULL;
 }
 
-void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
+int egl_create_fence(EGLSyncKHR sync)
 {
-    void *sync = qemu_dmabuf_get_sync(dmabuf);
-    int fence_fd;
+    int fence_fd = -1;
 
     if (sync) {
         fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
                                               sync);
-        qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
         eglDestroySyncKHR(qemu_egl_display, sync);
-        qemu_dmabuf_set_sync(dmabuf, NULL);
     }
+
+    return fence_fd;
 }
 
 #endif /* CONFIG_GBM */
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index adc81f34b1c8..c671aabd11b3 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -68,7 +68,7 @@ void gd_egl_draw(VirtualConsole *vc)
     GdkWindow *window;
 #ifdef CONFIG_GBM
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
-    int fence_fd;
+    EGLSyncKHR sync;
 #endif
     int ww, wh, pw, ph, gs;
 
@@ -94,7 +94,11 @@ void gd_egl_draw(VirtualConsole *vc)
             qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
         }
 #endif
-        gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
+#ifdef CONFIG_GBM
+        sync =
+#endif
+            gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0,
+                                 vc->gfx.w, vc->gfx.h);
 
         gd_update_scale(vc, ww, wh,
                         surface_width(vc->gfx.ds),
@@ -103,13 +107,7 @@ void gd_egl_draw(VirtualConsole *vc)
         glFlush();
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            egl_dmabuf_create_fence(dmabuf);
-            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
-            if (fence_fd >= 0) {
-                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
-                return;
-            }
-            qemu_console_hw_gl_block(vc->gfx.dcl.con, false);
+            gd_gl_wait_sync(vc, sync);
         }
 #endif
     } else {
@@ -330,10 +328,12 @@ void gd_egl_cursor_position(DisplayChangeListener *dcl,
     vc->gfx.cursor_y = pos_y * vc->gfx.scale_y;
 }
 
-void gd_egl_scanout_flush(DisplayChangeListener *dcl,
-                          uint32_t x, uint32_t y, uint32_t w, uint32_t h)
+EGLSyncKHR gd_egl_scanout_flush(DisplayChangeListener *dcl,
+                                uint32_t x, uint32_t y,
+                                uint32_t w, uint32_t h)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
+    EGLSyncKHR sync = EGL_NO_SYNC_KHR;
     GdkWindow *window;
     int px_offset, py_offset;
     int gs;
@@ -342,10 +342,10 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
     int fbw, fbh;
 
     if (!vc->gfx.scanout_mode) {
-        return;
+        return sync;
     }
     if (!vc->gfx.guest_fb.framebuffer) {
-        return;
+        return sync;
     }
 
     eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
@@ -391,11 +391,13 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
 
 #ifdef CONFIG_GBM
     if (vc->gfx.guest_fb.dmabuf) {
-        egl_dmabuf_create_sync(vc->gfx.guest_fb.dmabuf);
+        sync = egl_create_sync();
     }
 #endif
 
     eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
+
+    return sync;
 }
 
 void gd_egl_flush(DisplayChangeListener *dcl,
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 29497019ee46..29d1b1e4116f 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -41,6 +41,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
 {
 #ifdef CONFIG_GBM
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
+    EGLSyncKHR sync = EGL_NO_SYNC_KHR;
 #endif
     int pw, ph, gs, y1, y2;
     int ww, wh;
@@ -119,20 +120,13 @@ void gd_gl_area_draw(VirtualConsole *vc)
                           GL_COLOR_BUFFER_BIT, GL_NEAREST);
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            egl_dmabuf_create_sync(dmabuf);
+            sync = egl_create_sync();
         }
 #endif
         glFlush();
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            int fence_fd;
-            egl_dmabuf_create_fence(dmabuf);
-            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
-            if (fence_fd >= 0) {
-                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
-                return;
-            }
-            qemu_console_hw_gl_block(vc->gfx.dcl.con, false);
+            gd_gl_wait_sync(vc, sync);
         }
 #endif
     } else {
diff --git a/ui/gtk.c b/ui/gtk.c
index 7078d89d6797..1c75b9ea3c4d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -597,21 +597,32 @@ static void gd_gl_release_dmabuf(DisplayChangeListener *dcl,
 #endif
 }
 
-void gd_hw_gl_flushed(void *vcon)
+#ifdef CONFIG_GBM
+static void gd_gl_fence_cb(void *vcon)
 {
     VirtualConsole *vc = vcon;
-    QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
-    int fence_fd;
 
-    fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
-    if (fence_fd >= 0) {
-        qemu_set_fd_handler(fence_fd, NULL, NULL, NULL);
-        close(fence_fd);
-        qemu_dmabuf_set_fence_fd(dmabuf, -1);
+    if (vc->gfx.gl_fence_fd >= 0) {
+        qemu_set_fd_handler(vc->gfx.gl_fence_fd, NULL, NULL, NULL);
+        g_clear_fd(&vc->gfx.gl_fence_fd, NULL);
         qemu_console_hw_gl_block(vc->gfx.dcl.con, false);
     }
 }
 
+void gd_gl_wait_sync(VirtualConsole *vc, EGLSyncKHR sync)
+{
+    assert(vc->gfx.gl_fence_fd < 0);
+
+    vc->gfx.gl_fence_fd = egl_create_fence(sync);
+    if (vc->gfx.gl_fence_fd >= 0) {
+        qemu_set_fd_handler(vc->gfx.gl_fence_fd,
+                            gd_gl_fence_cb, NULL, vc);
+    } else {
+        qemu_console_hw_gl_block(vc->gfx.dcl.con, false);
+    }
+}
+#endif
+
 /** DisplayState Callbacks (opengl version) **/
 
 static const DisplayChangeListenerOps dcl_gl_area_ops = {
@@ -2355,6 +2366,7 @@ add_gfx_console(GtkDisplayState *s, QemuConsole *con)
     vc->gfx.scale_y = vc->gfx.preferred_scale;
 
 #if defined(CONFIG_OPENGL)
+    vc->gfx.gl_fence_fd = -1;
     if (display_opengl) {
         if (gtk_use_gl_area) {
             vc->gfx.drawing_area = gtk_gl_area_new();
@@ -2647,6 +2659,9 @@ static void gd_vc_free(void *p)
 
     switch (vc->type) {
     case GD_VC_GFX:
+#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
+        gd_gl_fence_cb(vc);
+#endif
         qemu_console_unregister_listener(&vc->gfx.dcl);
 #if defined(CONFIG_OPENGL)
         if (display_opengl) {

-- 
2.55.0.543.g5ebe2ebe4ea8


