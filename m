Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A60C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 18:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lZW-0005sz-VL; Wed, 08 May 2024 13:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4lZU-0005rx-CC
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:59:16 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4lZR-0002rt-4H
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715191154; x=1746727154;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=11pN+4SeL3X5Jx2qJlXWtWn1YTK9gf8IMCiG9pd+k2A=;
 b=mgYQg7ReHyhlMnHMPH7pdSErua5uNtg/OJXmyVLSABfXItqlX1pcEuz4
 w/9O0N53GF6Vbqev9BiqLheqhhqjsTeSQ9lfuaGh1J5CIyR/CX8VxxMUD
 Dxj4rxHchwtOWZdsYykRYUNnB5h13sd0P3Tf3VkSFlmI+jnw+EFtxZL7a
 QlxYT359uaWuow8SD2ryVMve99mNioEI0tL+/qoRKQiia8Kr5jXGh1hhq
 NqZcUrdxAKe+i9qZbWf5F5FzgeDmZAOoC6EUtRcN0qUvZbO7bQQ/GO1kL
 WC8UiGAm0ImHw4Hp20ckClmu2gLUSxxZCuy7FzFVeOTZmEpi89C9WkKVt A==;
X-CSE-ConnectionGUID: 2++sl4/8TNi354Y2NJ7/1Q==
X-CSE-MsgGUID: rJxjemhhREOMvZPOj0V2Jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14887682"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; d="scan'208";a="14887682"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 10:59:03 -0700
X-CSE-ConnectionGUID: lYcc4zfCT0y+yeFaV7CrZQ==
X-CSE-MsgGUID: jAAbI/2cSB+6lpIFG4GQFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; d="scan'208";a="29541307"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa008.jf.intel.com with ESMTP; 08 May 2024 10:59:02 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v14 3/6] ui/console: Use qemu_dmabuf_get_..() helpers instead
Date: Wed,  8 May 2024 10:54:00 -0700
Message-Id: <20240508175403.3399895-4-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508175403.3399895-1-dongwon.kim@intel.com>
References: <20240508175403.3399895-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

This commit updates all instances where fields within the QemuDmaBuf
struct are directly accessed, replacing them with calls to these new
helper functions.

v6: fix typos in helper names in ui/spice-display.c

v7: removed prefix, "dpy_gl_" from all helpers

v8: Introduction of helpers was removed as those were already added
    by the previous commit

v11: -- Use new qemu_dmabuf_close() instead of close(qemu_dmabuf_get_fd()).
        (Daniel P. Berrangé <berrange@redhat.com>)
     -- Use new qemu_dmabuf_dup_fd() instead of dup(qemu_dmabuf_get_fd()).
        (Daniel P. Berrangé <berrange@redhat.com>)

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/vhost-user-gpu.c     |  5 +---
 hw/display/virtio-gpu-udmabuf.c |  7 +++--
 hw/vfio/display.c               | 12 +++++---
 ui/console.c                    |  4 +--
 ui/dbus-console.c               |  9 ++++--
 ui/dbus-listener.c              | 43 +++++++++++++++++-----------
 ui/egl-headless.c               | 23 ++++++++++-----
 ui/egl-helpers.c                | 47 ++++++++++++++++++-------------
 ui/gtk-egl.c                    | 48 ++++++++++++++++++++-----------
 ui/gtk-gl-area.c                | 37 ++++++++++++++++--------
 ui/gtk.c                        |  6 ++--
 ui/spice-display.c              | 50 +++++++++++++++++++--------------
 12 files changed, 181 insertions(+), 110 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 709c8a02a1..454e5afcff 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -262,10 +262,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         g->parent_obj.enable = 1;
         con = g->parent_obj.scanout[m->scanout_id].con;
         dmabuf = &g->dmabuf[m->scanout_id];
-        if (dmabuf->fd >= 0) {
-            close(dmabuf->fd);
-            dmabuf->fd = -1;
-        }
+        qemu_dmabuf_close(dmabuf);
         dpy_gl_release_dmabuf(con, dmabuf);
         if (fd == -1) {
             dpy_gl_scanout_disable(con);
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d51184d658..c90eba281e 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -206,6 +206,7 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     VGPUDMABuf *new_primary, *old_primary = NULL;
+    uint32_t width, height;
 
     new_primary = virtio_gpu_create_dmabuf(g, scanout_id, res, fb, r);
     if (!new_primary) {
@@ -216,10 +217,10 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
         old_primary = g->dmabuf.primary[scanout_id];
     }
 
+    width = qemu_dmabuf_get_width(&new_primary->buf);
+    height = qemu_dmabuf_get_height(&new_primary->buf);
     g->dmabuf.primary[scanout_id] = new_primary;
-    qemu_console_resize(scanout->con,
-                        new_primary->buf.width,
-                        new_primary->buf.height);
+    qemu_console_resize(scanout->con, width, height);
     dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
 
     if (old_primary) {
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 1aa440c663..7784502b53 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -260,8 +260,9 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
 static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
 {
     QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
+
+    qemu_dmabuf_close(&dmabuf->buf);
     dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
-    close(dmabuf->buf.fd);
     g_free(dmabuf);
 }
 
@@ -286,6 +287,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     VFIOPCIDevice *vdev = opaque;
     VFIODisplay *dpy = vdev->dpy;
     VFIODMABuf *primary, *cursor;
+    uint32_t width, height;
     bool free_bufs = false, new_cursor = false;
 
     primary = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
@@ -296,10 +298,12 @@ static void vfio_display_dmabuf_update(void *opaque)
         return;
     }
 
+    width = qemu_dmabuf_get_width(&primary->buf);
+    height = qemu_dmabuf_get_height(&primary->buf);
+
     if (dpy->dmabuf.primary != primary) {
         dpy->dmabuf.primary = primary;
-        qemu_console_resize(dpy->con,
-                            primary->buf.width, primary->buf.height);
+        qemu_console_resize(dpy->con, width, height);
         dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
         free_bufs = true;
     }
@@ -328,7 +332,7 @@ static void vfio_display_dmabuf_update(void *opaque)
         cursor->pos_updates = 0;
     }
 
-    dpy_gl_update(dpy->con, 0, 0, primary->buf.width, primary->buf.height);
+    dpy_gl_update(dpy->con, 0, 0, width, height);
 
     if (free_bufs) {
         vfio_display_free_dmabufs(vdev);
diff --git a/ui/console.c b/ui/console.c
index 43226c5c14..1b2cd0c736 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1459,7 +1459,7 @@ int qemu_console_get_width(QemuConsole *con, int fallback)
     }
     switch (con->scanout.kind) {
     case SCANOUT_DMABUF:
-        return con->scanout.dmabuf->width;
+        return qemu_dmabuf_get_width(con->scanout.dmabuf);
     case SCANOUT_TEXTURE:
         return con->scanout.texture.width;
     case SCANOUT_SURFACE:
@@ -1476,7 +1476,7 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
     }
     switch (con->scanout.kind) {
     case SCANOUT_DMABUF:
-        return con->scanout.dmabuf->height;
+        return qemu_dmabuf_get_height(con->scanout.dmabuf);
     case SCANOUT_TEXTURE:
         return con->scanout.texture.height;
     case SCANOUT_SURFACE:
diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 49da9ccc83..578b67f62b 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -110,11 +110,14 @@ static void
 dbus_gl_scanout_dmabuf(DisplayChangeListener *dcl,
                        QemuDmaBuf *dmabuf)
 {
+    uint32_t width, height;
+
     DBusDisplayConsole *ddc = container_of(dcl, DBusDisplayConsole, dcl);
 
-    dbus_display_console_set_size(ddc,
-                                  dmabuf->width,
-                                  dmabuf->height);
+    width = qemu_dmabuf_get_width(dmabuf);
+    height = qemu_dmabuf_get_height(dmabuf);
+
+    dbus_display_console_set_size(ddc, width, height);
 }
 
 static void
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 4a0a5d78f9..62d1e2d3f9 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -278,29 +278,33 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
     g_autoptr(GError) err = NULL;
     g_autoptr(GUnixFDList) fd_list = NULL;
+    int fd;
+    uint32_t width, height, stride, fourcc;
+    uint64_t modifier;
+    bool y0_top;
 
+    fd = qemu_dmabuf_get_fd(dmabuf);
     fd_list = g_unix_fd_list_new();
-    if (g_unix_fd_list_append(fd_list, dmabuf->fd, &err) != 0) {
+    if (g_unix_fd_list_append(fd_list, fd, &err) != 0) {
         error_report("Failed to setup dmabuf fdlist: %s", err->message);
         return;
     }
 
     ddl_discard_pending_messages(ddl);
 
+    width = qemu_dmabuf_get_width(dmabuf);
+    height = qemu_dmabuf_get_height(dmabuf);
+    stride = qemu_dmabuf_get_stride(dmabuf);
+    fourcc = qemu_dmabuf_get_fourcc(dmabuf);
+    modifier = qemu_dmabuf_get_modifier(dmabuf);
+    y0_top = qemu_dmabuf_get_y0_top(dmabuf);
+
     /* FIXME: add missing x/y/w/h support */
     qemu_dbus_display1_listener_call_scanout_dmabuf(
-        ddl->proxy,
-        g_variant_new_handle(0),
-        dmabuf->width,
-        dmabuf->height,
-        dmabuf->stride,
-        dmabuf->fourcc,
-        dmabuf->modifier,
-        dmabuf->y0_top,
-        G_DBUS_CALL_FLAGS_NONE,
-        -1,
-        fd_list,
-        NULL, NULL, NULL);
+        ddl->proxy, g_variant_new_handle(0),
+        width, height, stride, fourcc, modifier,
+        y0_top, G_DBUS_CALL_FLAGS_NONE,
+        -1, fd_list, NULL, NULL, NULL);
 }
 #endif /* GBM */
 #endif /* OPENGL */
@@ -488,6 +492,7 @@ static void dbus_cursor_dmabuf(DisplayChangeListener *dcl,
     DisplaySurface *ds;
     GVariant *v_data = NULL;
     egl_fb cursor_fb = EGL_FB_INIT;
+    uint32_t width, height, texture;
 
     if (!dmabuf) {
         qemu_dbus_display1_listener_call_mouse_set(
@@ -497,12 +502,16 @@ static void dbus_cursor_dmabuf(DisplayChangeListener *dcl,
     }
 
     egl_dmabuf_import_texture(dmabuf);
-    if (!dmabuf->texture) {
+    texture = qemu_dmabuf_get_texture(dmabuf);
+    if (!texture) {
         return;
     }
-    egl_fb_setup_for_tex(&cursor_fb, dmabuf->width, dmabuf->height,
-                         dmabuf->texture, false);
-    ds = qemu_create_displaysurface(dmabuf->width, dmabuf->height);
+
+    width = qemu_dmabuf_get_width(dmabuf);
+    height = qemu_dmabuf_get_height(dmabuf);
+
+    egl_fb_setup_for_tex(&cursor_fb, width, height, texture, false);
+    ds = qemu_create_displaysurface(width, height);
     egl_fb_read(ds, &cursor_fb);
 
     v_data = g_variant_new_from_data(
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index d5637dadb2..6187249c73 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -85,29 +85,38 @@ static void egl_scanout_texture(DisplayChangeListener *dcl,
 static void egl_scanout_dmabuf(DisplayChangeListener *dcl,
                                QemuDmaBuf *dmabuf)
 {
+    uint32_t width, height, texture;
+
     egl_dmabuf_import_texture(dmabuf);
-    if (!dmabuf->texture) {
+    texture = qemu_dmabuf_get_texture(dmabuf);
+    if (!texture) {
         return;
     }
 
-    egl_scanout_texture(dcl, dmabuf->texture,
-                        false, dmabuf->width, dmabuf->height,
-                        0, 0, dmabuf->width, dmabuf->height, NULL);
+    width = qemu_dmabuf_get_width(dmabuf);
+    height = qemu_dmabuf_get_height(dmabuf);
+
+    egl_scanout_texture(dcl, texture, false, width, height, 0, 0,
+                        width, height, NULL);
 }
 
 static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
                               QemuDmaBuf *dmabuf, bool have_hot,
                               uint32_t hot_x, uint32_t hot_y)
 {
+    uint32_t width, height, texture;
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
 
     if (dmabuf) {
         egl_dmabuf_import_texture(dmabuf);
-        if (!dmabuf->texture) {
+        texture = qemu_dmabuf_get_texture(dmabuf);
+        if (!texture) {
             return;
         }
-        egl_fb_setup_for_tex(&edpy->cursor_fb, dmabuf->width, dmabuf->height,
-                             dmabuf->texture, false);
+
+        width = qemu_dmabuf_get_width(dmabuf);
+        height = qemu_dmabuf_get_height(dmabuf);
+        egl_fb_setup_for_tex(&edpy->cursor_fb, width, height, texture, false);
     } else {
         egl_fb_destroy(&edpy->cursor_fb);
     }
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 3d19dbe382..3f96e63d25 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -146,10 +146,10 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
     glViewport(0, 0, dst->width, dst->height);
 
     if (src->dmabuf) {
-        x1 = src->dmabuf->x;
-        y1 = src->dmabuf->y;
-        w = src->dmabuf->width;
-        h = src->dmabuf->height;
+        x1 = qemu_dmabuf_get_x(src->dmabuf);
+        y1 = qemu_dmabuf_get_y(src->dmabuf);
+        w = qemu_dmabuf_get_width(src->dmabuf);
+        h = qemu_dmabuf_get_height(src->dmabuf);
     }
 
     w = (x1 + w) > src->width ? src->width - x1 : w;
@@ -308,30 +308,33 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
     EGLImageKHR image = EGL_NO_IMAGE_KHR;
     EGLint attrs[64];
     int i = 0;
+    uint64_t modifier;
+    uint32_t texture = qemu_dmabuf_get_texture(dmabuf);
 
-    if (dmabuf->texture != 0) {
+    if (texture != 0) {
         return;
     }
 
     attrs[i++] = EGL_WIDTH;
-    attrs[i++] = dmabuf->backing_width;
+    attrs[i++] = qemu_dmabuf_get_backing_width(dmabuf);
     attrs[i++] = EGL_HEIGHT;
-    attrs[i++] = dmabuf->backing_height;
+    attrs[i++] = qemu_dmabuf_get_backing_height(dmabuf);
     attrs[i++] = EGL_LINUX_DRM_FOURCC_EXT;
-    attrs[i++] = dmabuf->fourcc;
+    attrs[i++] = qemu_dmabuf_get_fourcc(dmabuf);
 
     attrs[i++] = EGL_DMA_BUF_PLANE0_FD_EXT;
-    attrs[i++] = dmabuf->fd;
+    attrs[i++] = qemu_dmabuf_get_fd(dmabuf);
     attrs[i++] = EGL_DMA_BUF_PLANE0_PITCH_EXT;
-    attrs[i++] = dmabuf->stride;
+    attrs[i++] = qemu_dmabuf_get_stride(dmabuf);
     attrs[i++] = EGL_DMA_BUF_PLANE0_OFFSET_EXT;
     attrs[i++] = 0;
 #ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
-    if (dmabuf->modifier) {
+    modifier = qemu_dmabuf_get_modifier(dmabuf);
+    if (modifier) {
         attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
-        attrs[i++] = (dmabuf->modifier >>  0) & 0xffffffff;
+        attrs[i++] = (modifier >>  0) & 0xffffffff;
         attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
-        attrs[i++] = (dmabuf->modifier >> 32) & 0xffffffff;
+        attrs[i++] = (modifier >> 32) & 0xffffffff;
     }
 #endif
     attrs[i++] = EGL_NONE;
@@ -346,7 +349,8 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
     }
 
     glGenTextures(1, &dmabuf->texture);
-    glBindTexture(GL_TEXTURE_2D, dmabuf->texture);
+    texture = qemu_dmabuf_get_texture(dmabuf);
+    glBindTexture(GL_TEXTURE_2D, texture);
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
 
@@ -356,11 +360,14 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
 
 void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
 {
-    if (dmabuf->texture == 0) {
+    uint32_t texture;
+
+    texture = qemu_dmabuf_get_texture(dmabuf);
+    if (texture == 0) {
         return;
     }
 
-    glDeleteTextures(1, &dmabuf->texture);
+    glDeleteTextures(1, &texture);
     dmabuf->texture = 0;
 }
 
@@ -382,10 +389,12 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
 
 void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
 {
-    if (dmabuf->sync) {
+    void *sync = qemu_dmabuf_get_sync(dmabuf);
+
+    if (sync) {
         dmabuf->fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
-                                                      dmabuf->sync);
-        eglDestroySyncKHR(qemu_egl_display, dmabuf->sync);
+                                                      sync);
+        eglDestroySyncKHR(qemu_egl_display, sync);
         dmabuf->sync = NULL;
     }
 }
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 955234429d..7a45daefa1 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -70,6 +70,7 @@ void gd_egl_draw(VirtualConsole *vc)
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 #endif
     int ww, wh, ws;
+    int fence_fd;
 
     if (!vc->gfx.gls) {
         return;
@@ -83,7 +84,7 @@ void gd_egl_draw(VirtualConsole *vc)
     if (vc->gfx.scanout_mode) {
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            if (!dmabuf->draw_submitted) {
+            if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
                 return;
             } else {
                 dmabuf->draw_submitted = false;
@@ -99,8 +100,9 @@ void gd_egl_draw(VirtualConsole *vc)
 #ifdef CONFIG_GBM
         if (dmabuf) {
             egl_dmabuf_create_fence(dmabuf);
-            if (dmabuf->fence_fd >= 0) {
-                qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, NULL, vc);
+            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+            if (fence_fd >= 0) {
+                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
                 return;
             }
             graphic_hw_gl_block(vc->gfx.dcl.con, false);
@@ -149,7 +151,8 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
     gd_update_monitor_refresh_rate(
             vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
-    if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+    if (vc->gfx.guest_fb.dmabuf &&
+        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
         return;
     }
 
@@ -264,22 +267,30 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
 {
 #ifdef CONFIG_GBM
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
+    uint32_t x, y, width, height, backing_width, backing_height, texture;
+    bool y0_top;
 
     eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                    vc->gfx.esurface, vc->gfx.ectx);
 
     egl_dmabuf_import_texture(dmabuf);
-    if (!dmabuf->texture) {
+    texture = qemu_dmabuf_get_texture(dmabuf);
+    if (!texture) {
         return;
     }
 
-    gd_egl_scanout_texture(dcl, dmabuf->texture,
-                           dmabuf->y0_top,
-                           dmabuf->backing_width, dmabuf->backing_height,
-                           dmabuf->x, dmabuf->y, dmabuf->width,
-                           dmabuf->height, NULL);
+    x = qemu_dmabuf_get_x(dmabuf);
+    y = qemu_dmabuf_get_y(dmabuf);
+    width = qemu_dmabuf_get_width(dmabuf);
+    height = qemu_dmabuf_get_height(dmabuf);
+    backing_width = qemu_dmabuf_get_backing_width(dmabuf);
+    backing_height = qemu_dmabuf_get_backing_height(dmabuf);
+    y0_top = qemu_dmabuf_get_y0_top(dmabuf);
 
-    if (dmabuf->allow_fences) {
+    gd_egl_scanout_texture(dcl, texture, y0_top, backing_width, backing_height,
+                           x, y, width, height, NULL);
+
+    if (qemu_dmabuf_get_allow_fences(dmabuf)) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
     }
 #endif
@@ -291,15 +302,19 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
 {
 #ifdef CONFIG_GBM
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
+    uint32_t backing_width, backing_height, texture;
 
     if (dmabuf) {
         egl_dmabuf_import_texture(dmabuf);
-        if (!dmabuf->texture) {
+        texture = qemu_dmabuf_get_texture(dmabuf);
+        if (!texture) {
             return;
         }
-        egl_fb_setup_for_tex(&vc->gfx.cursor_fb,
-                             dmabuf->backing_width, dmabuf->backing_height,
-                             dmabuf->texture, false);
+
+        backing_width = qemu_dmabuf_get_backing_width(dmabuf);
+        backing_height = qemu_dmabuf_get_backing_height(dmabuf);
+        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, backing_width, backing_height,
+                             texture, false);
     } else {
         egl_fb_destroy(&vc->gfx.cursor_fb);
     }
@@ -363,7 +378,8 @@ void gd_egl_flush(DisplayChangeListener *dcl,
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GtkWidget *area = vc->gfx.drawing_area;
 
-    if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
+    if (vc->gfx.guest_fb.dmabuf &&
+        !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
         vc->gfx.guest_fb.dmabuf->draw_submitted = true;
         gtk_egl_set_scanout_mode(vc, true);
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 7fffd0544e..2d70280803 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -60,7 +60,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
 
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            if (!dmabuf->draw_submitted) {
+            if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
                 return;
             } else {
                 dmabuf->draw_submitted = false;
@@ -85,9 +85,11 @@ void gd_gl_area_draw(VirtualConsole *vc)
         glFlush();
 #ifdef CONFIG_GBM
         if (dmabuf) {
+            int fence_fd;
             egl_dmabuf_create_fence(dmabuf);
-            if (dmabuf->fence_fd >= 0) {
-                qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, NULL, vc);
+            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+            if (fence_fd >= 0) {
+                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
                 return;
             }
             graphic_hw_gl_block(vc->gfx.dcl.con, false);
@@ -125,7 +127,8 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
-    if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+    if (vc->gfx.guest_fb.dmabuf &&
+        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
         return;
     }
 
@@ -285,7 +288,8 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
-    if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
+    if (vc->gfx.guest_fb.dmabuf &&
+        !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
         vc->gfx.guest_fb.dmabuf->draw_submitted = true;
         gtk_gl_area_set_scanout_mode(vc, true);
@@ -298,20 +302,29 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 {
 #ifdef CONFIG_GBM
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
+    uint32_t x, y, width, height, backing_width, backing_height, texture;
+    bool y0_top;
 
     gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
     egl_dmabuf_import_texture(dmabuf);
-    if (!dmabuf->texture) {
+    texture = qemu_dmabuf_get_texture(dmabuf);
+    if (!texture) {
         return;
     }
 
-    gd_gl_area_scanout_texture(dcl, dmabuf->texture,
-                               dmabuf->y0_top,
-                               dmabuf->backing_width, dmabuf->backing_height,
-                               dmabuf->x, dmabuf->y, dmabuf->width,
-                               dmabuf->height, NULL);
+    x = qemu_dmabuf_get_x(dmabuf);
+    y = qemu_dmabuf_get_y(dmabuf);
+    width = qemu_dmabuf_get_width(dmabuf);
+    height = qemu_dmabuf_get_height(dmabuf);
+    backing_width = qemu_dmabuf_get_backing_width(dmabuf);
+    backing_height = qemu_dmabuf_get_backing_height(dmabuf);
+    y0_top = qemu_dmabuf_get_y0_top(dmabuf);
 
-    if (dmabuf->allow_fences) {
+    gd_gl_area_scanout_texture(dcl, texture, y0_top,
+                               backing_width, backing_height,
+                               x, y, width, height, NULL);
+
+    if (qemu_dmabuf_get_allow_fences(dmabuf)) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
     }
 #endif
diff --git a/ui/gtk.c b/ui/gtk.c
index 7819a86321..237c913b26 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -596,10 +596,12 @@ void gd_hw_gl_flushed(void *vcon)
 {
     VirtualConsole *vc = vcon;
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
+    int fence_fd;
 
     if (dmabuf->fence_fd >= 0) {
-        qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
-        close(dmabuf->fence_fd);
+        fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+        qemu_set_fd_handler(fence_fd, NULL, NULL, NULL);
+        close(fence_fd);
         dmabuf->fence_fd = -1;
         graphic_hw_gl_block(vc->gfx.dcl.con, false);
     }
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 6eb98a5a5c..8a8472d029 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -976,6 +976,7 @@ static void qemu_spice_gl_cursor_dmabuf(DisplayChangeListener *dcl,
                                         uint32_t hot_x, uint32_t hot_y)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
+    uint32_t width, height, texture;
 
     ssd->have_hot = have_hot;
     ssd->hot_x = hot_x;
@@ -984,11 +985,13 @@ static void qemu_spice_gl_cursor_dmabuf(DisplayChangeListener *dcl,
     trace_qemu_spice_gl_cursor(ssd->qxl.id, dmabuf != NULL, have_hot);
     if (dmabuf) {
         egl_dmabuf_import_texture(dmabuf);
-        if (!dmabuf->texture) {
+        texture = qemu_dmabuf_get_texture(dmabuf);
+        if (!texture) {
             return;
         }
-        egl_fb_setup_for_tex(&ssd->cursor_fb, dmabuf->width, dmabuf->height,
-                             dmabuf->texture, false);
+        width = qemu_dmabuf_get_width(dmabuf);
+        height = qemu_dmabuf_get_height(dmabuf);
+        egl_fb_setup_for_tex(&ssd->cursor_fb, width, height, texture, false);
     } else {
         egl_fb_destroy(&ssd->cursor_fb);
     }
@@ -1026,6 +1029,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     bool y_0_top = false; /* FIXME */
     uint64_t cookie;
     int fd;
+    uint32_t width, height, texture;
 
     if (!ssd->have_scanout) {
         return;
@@ -1042,41 +1046,45 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
 
     if (ssd->guest_dmabuf_refresh) {
         QemuDmaBuf *dmabuf = ssd->guest_dmabuf;
+        width = qemu_dmabuf_get_width(dmabuf);
+        height = qemu_dmabuf_get_height(dmabuf);
+
         if (render_cursor) {
             egl_dmabuf_import_texture(dmabuf);
-            if (!dmabuf->texture) {
+            texture = qemu_dmabuf_get_texture(dmabuf);
+            if (!texture) {
                 return;
             }
 
             /* source framebuffer */
-            egl_fb_setup_for_tex(&ssd->guest_fb,
-                                 dmabuf->width, dmabuf->height,
-                                 dmabuf->texture, false);
+            egl_fb_setup_for_tex(&ssd->guest_fb, width, height,
+                                 texture, false);
 
             /* dest framebuffer */
-            if (ssd->blit_fb.width  != dmabuf->width ||
-                ssd->blit_fb.height != dmabuf->height) {
-                trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, dmabuf->width,
-                                                  dmabuf->height);
+            if (ssd->blit_fb.width  != width ||
+                ssd->blit_fb.height != height) {
+                trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, width,
+                                                  height);
                 egl_fb_destroy(&ssd->blit_fb);
                 egl_fb_setup_new_tex(&ssd->blit_fb,
-                                     dmabuf->width, dmabuf->height);
+                                     width, height);
                 fd = egl_get_fd_for_texture(ssd->blit_fb.texture,
                                             &stride, &fourcc, NULL);
-                spice_qxl_gl_scanout(&ssd->qxl, fd,
-                                     dmabuf->width, dmabuf->height,
+                spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
                                      stride, fourcc, false);
             }
         } else {
-            trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id,
-                                               dmabuf->width, dmabuf->height);
+            stride = qemu_dmabuf_get_stride(dmabuf);
+            fourcc = qemu_dmabuf_get_fourcc(dmabuf);
+            y_0_top = qemu_dmabuf_get_y0_top(dmabuf);
+            fd = qemu_dmabuf_dup_fd(dmabuf);
+
+            trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, height);
             /* note: spice server will close the fd, so hand over a dup */
-            spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
-                                 dmabuf->width, dmabuf->height,
-                                 dmabuf->stride, dmabuf->fourcc,
-                                 dmabuf->y0_top);
+            spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
+                                 stride, fourcc, y_0_top);
         }
-        qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->height);
+        qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
         ssd->guest_dmabuf_refresh = false;
     }
 
-- 
2.34.1


