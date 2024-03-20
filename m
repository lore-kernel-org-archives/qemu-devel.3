Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6E5C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 03:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmms7-0006oM-IT; Tue, 19 Mar 2024 23:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rmms5-0006ny-WE
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:44:10 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rmms3-0003Hk-Ix
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710906247; x=1742442247;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MpapFjGFrONzrS7LJyLdyOHEjYZgtXkLbRb1i7AG8a8=;
 b=CB0YnthqiZFrXT+mBGKQEDlOYcgduIllBAvF8zJGddHcOHFoBeOoNzaE
 l9q3+Z47Wf2SgR7lafCKL7oIx/pHhEHWP2p7fU9AcsYsOYTQ9S2to7ULX
 fpA+j74krggSE3RYZlWmx+Wa5TSjZGDc4z1ztkkc1kuuhs3E5bo84GaEm
 ZOu7i5Xpxc5qgea3r/w6YqxiLsmrfvlwDxKeMppLdOOnOeDhUBotxd1eU
 l34JTs22zaKtf6tC2Dh/Z9eoCc0W7oRJnl1TqTbf9zJGJU6iq/pJt6saU
 Hs79CuR28otc8KzqgrUpgPWA1h1K/Nn6DHiXByuMok2sRDdOd+H204pHL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="16456551"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; d="scan'208";a="16456551"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2024 20:44:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; d="scan'208";a="18477406"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa005.fm.intel.com with ESMTP; 19 Mar 2024 20:44:03 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/console: initialize QemuDmaBuf from ui/console.
Date: Tue, 19 Mar 2024 20:42:29 -0700
Message-Id: <20240320034229.3347130-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It is safer to create, initialize, and access all the parameters
in QemuDmaBuf from a central location, ui/console, instead of
hw/virtio-gpu or hw/vfio modules.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu-udmabuf.c | 27 +++++++---------
 hw/vfio/display.c               | 35 ++++++++++++---------
 include/hw/vfio/vfio-common.h   |  2 +-
 include/hw/virtio/virtio-gpu.h  |  2 +-
 include/ui/console.h            | 10 ++++++
 ui/console.c                    | 55 +++++++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+), 33 deletions(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d51184d658..dde6c8e9d9 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -162,7 +162,7 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
     struct virtio_gpu_scanout *scanout;
 
     scanout = &g->parent_obj.scanout[dmabuf->scanout_id];
-    dpy_gl_release_dmabuf(scanout->con, &dmabuf->buf);
+    dpy_gl_release_dmabuf(scanout->con, dmabuf->buf);
     QTAILQ_REMOVE(&g->dmabuf.bufs, dmabuf, next);
     g_free(dmabuf);
 }
@@ -181,17 +181,10 @@ static VGPUDMABuf
     }
 
     dmabuf = g_new0(VGPUDMABuf, 1);
-    dmabuf->buf.width = r->width;
-    dmabuf->buf.height = r->height;
-    dmabuf->buf.stride = fb->stride;
-    dmabuf->buf.x = r->x;
-    dmabuf->buf.y = r->y;
-    dmabuf->buf.backing_width = fb->width;
-    dmabuf->buf.backing_height = fb->height;
-    dmabuf->buf.fourcc = qemu_pixman_to_drm_format(fb->format);
-    dmabuf->buf.fd = res->dmabuf_fd;
-    dmabuf->buf.allow_fences = true;
-    dmabuf->buf.draw_submitted = false;
+    dmabuf->buf = dpy_gl_create_dmabuf(r->width, r->height, fb->stride,
+                                       r->x, r->y, fb->width, fb->height,
+                                       qemu_pixman_to_drm_format(fb->format),
+                                       0, res->dmabuf_fd, false);
     dmabuf->scanout_id = scanout_id;
     QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
 
@@ -206,21 +199,23 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     VGPUDMABuf *new_primary, *old_primary = NULL;
+    uint32_t width, height;
 
     new_primary = virtio_gpu_create_dmabuf(g, scanout_id, res, fb, r);
     if (!new_primary) {
         return -EINVAL;
     }
 
+    width = dpy_gl_dmabuf_get_width(new_primary->buf);
+    height = dpy_gl_dmabuf_get_height(new_primary->buf);
+
     if (g->dmabuf.primary[scanout_id]) {
         old_primary = g->dmabuf.primary[scanout_id];
     }
 
     g->dmabuf.primary[scanout_id] = new_primary;
-    qemu_console_resize(scanout->con,
-                        new_primary->buf.width,
-                        new_primary->buf.height);
-    dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
+    qemu_console_resize(scanout->con, width, height);
+    dpy_gl_scanout_dmabuf(scanout->con, new_primary->buf);
 
     if (old_primary) {
         virtio_gpu_free_dmabuf(g, old_primary);
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 1aa440c663..a3bdb01789 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -241,14 +241,10 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
 
     dmabuf = g_new0(VFIODMABuf, 1);
     dmabuf->dmabuf_id  = plane.dmabuf_id;
-    dmabuf->buf.width  = plane.width;
-    dmabuf->buf.height = plane.height;
-    dmabuf->buf.backing_width = plane.width;
-    dmabuf->buf.backing_height = plane.height;
-    dmabuf->buf.stride = plane.stride;
-    dmabuf->buf.fourcc = plane.drm_format;
-    dmabuf->buf.modifier = plane.drm_format_mod;
-    dmabuf->buf.fd     = fd;
+    dmabuf->buf = dpy_gl_create_dmabuf(plane.width, plane.height, plane.stride,
+                                       0, 0, plane.width, plane.height,
+                                       plane.drm_format, plane.drm_format_mod,
+                                       fd, false);
     if (plane_type == DRM_PLANE_TYPE_CURSOR) {
         vfio_display_update_cursor(dmabuf, &plane);
     }
@@ -259,9 +255,15 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
 
 static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
 {
+    int fd;
+
     QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
-    dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
-    close(dmabuf->buf.fd);
+    fd = dpy_gl_dmabuf_get_fd(dmabuf->buf);
+    if (fd > -1) {
+        close(fd);
+    }
+
+    dpy_gl_release_dmabuf(dpy->con, dmabuf->buf);
     g_free(dmabuf);
 }
 
@@ -286,6 +288,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     VFIOPCIDevice *vdev = opaque;
     VFIODisplay *dpy = vdev->dpy;
     VFIODMABuf *primary, *cursor;
+    uint32_t width, height;
     bool free_bufs = false, new_cursor = false;
 
     primary = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
@@ -296,11 +299,13 @@ static void vfio_display_dmabuf_update(void *opaque)
         return;
     }
 
+    width = dpy_gl_dmabuf_get_width(primary->buf);
+    height = dpy_gl_dmabuf_get_height(primary->buf);
+
     if (dpy->dmabuf.primary != primary) {
         dpy->dmabuf.primary = primary;
-        qemu_console_resize(dpy->con,
-                            primary->buf.width, primary->buf.height);
-        dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
+        qemu_console_resize(dpy->con, width, height);
+        dpy_gl_scanout_dmabuf(dpy->con, primary->buf);
         free_bufs = true;
     }
 
@@ -314,7 +319,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     if (cursor && (new_cursor || cursor->hot_updates)) {
         bool have_hot = (cursor->hot_x != 0xffffffff &&
                          cursor->hot_y != 0xffffffff);
-        dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
+        dpy_gl_cursor_dmabuf(dpy->con, cursor->buf, have_hot,
                              cursor->hot_x, cursor->hot_y);
         cursor->hot_updates = 0;
     } else if (!cursor && new_cursor) {
@@ -328,7 +333,7 @@ static void vfio_display_dmabuf_update(void *opaque)
         cursor->pos_updates = 0;
     }
 
-    dpy_gl_update(dpy->con, 0, 0, primary->buf.width, primary->buf.height);
+    dpy_gl_update(dpy->con, 0, 0, width, height);
 
     if (free_bufs) {
         vfio_display_free_dmabufs(vdev);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9da6c08ef..d66e27db02 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -148,7 +148,7 @@ typedef struct VFIOGroup {
 } VFIOGroup;
 
 typedef struct VFIODMABuf {
-    QemuDmaBuf buf;
+    QemuDmaBuf *buf;
     uint32_t pos_x, pos_y, pos_updates;
     uint32_t hot_x, hot_y, hot_updates;
     int dmabuf_id;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index ed44cdad6b..010083e8e3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -169,7 +169,7 @@ struct VirtIOGPUBaseClass {
     DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
 
 typedef struct VGPUDMABuf {
-    QemuDmaBuf buf;
+    QemuDmaBuf *buf;
     uint32_t scanout_id;
     QTAILQ_ENTRY(VGPUDMABuf) next;
 } VGPUDMABuf;
diff --git a/include/ui/console.h b/include/ui/console.h
index a4a49ffc64..0b823efb2e 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -279,6 +279,7 @@ typedef struct DisplayChangeListenerOps {
     /* optional */
     void (*dpy_gl_cursor_position)(DisplayChangeListener *dcl,
                                    uint32_t pos_x, uint32_t pos_y);
+
     /* optional */
     void (*dpy_gl_release_dmabuf)(DisplayChangeListener *dcl,
                                   QemuDmaBuf *dmabuf);
@@ -358,6 +359,15 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
                           bool have_hot, uint32_t hot_x, uint32_t hot_y);
 void dpy_gl_cursor_position(QemuConsole *con,
                             uint32_t pos_x, uint32_t pos_y);
+QemuDmaBuf *dpy_gl_create_dmabuf(uint32_t width, uint32_t height,
+                                 uint32_t stride, uint32_t x,
+                                 uint32_t y, uint32_t backing_width,
+                                 uint32_t backing_height, uint32_t fourcc,
+                                 uint32_t modifier, uint32_t dmabuf_fd,
+                                 bool allow_fences);
+uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
+uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
+int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf);
 void dpy_gl_release_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_update(QemuConsole *con,
diff --git a/ui/console.c b/ui/console.c
index 832055675c..616d636912 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1190,6 +1190,60 @@ void dpy_gl_cursor_position(QemuConsole *con,
     }
 }
 
+QemuDmaBuf *dpy_gl_create_dmabuf(uint32_t width, uint32_t height,
+                                 uint32_t stride, uint32_t x,
+                                 uint32_t y, uint32_t backing_width,
+                                 uint32_t backing_height, uint32_t fourcc,
+                                 uint32_t modifier, uint32_t dmabuf_fd,
+                                 bool allow_fences)
+{
+    QemuDmaBuf *dmabuf;
+
+    dmabuf = g_new0(QemuDmaBuf, 1);
+
+    dmabuf->width = width;
+    dmabuf->height = height;
+    dmabuf->stride = stride;
+    dmabuf->x = x;
+    dmabuf->y = y;
+    dmabuf->backing_width = backing_width;
+    dmabuf->backing_height = backing_height;
+    dmabuf->fourcc = fourcc;
+    dmabuf->modifier = modifier;
+    dmabuf->fd = dmabuf_fd;
+    dmabuf->allow_fences = allow_fences;
+    dmabuf->fence_fd = -1;
+
+    return dmabuf;
+}
+
+uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->width;
+    }
+
+    return 0;
+}
+
+uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->height;
+    }
+
+    return 0;
+}
+
+int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->fd;
+    }
+
+    return -1;
+}
+
 void dpy_gl_release_dmabuf(QemuConsole *con,
                           QemuDmaBuf *dmabuf)
 {
@@ -1203,6 +1257,7 @@ void dpy_gl_release_dmabuf(QemuConsole *con,
         if (dcl->ops->dpy_gl_release_dmabuf) {
             dcl->ops->dpy_gl_release_dmabuf(dcl, dmabuf);
         }
+        g_free(dmabuf);
     }
 }
 
-- 
2.34.1


