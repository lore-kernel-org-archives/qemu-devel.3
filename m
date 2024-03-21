Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CCECD11BF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 23:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnS5C-0007Oh-14; Thu, 21 Mar 2024 19:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnS5A-0007OA-EE
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 19:44:24 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnS58-0007iR-AQ
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 19:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711064663; x=1742600663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XHxenZTiVD2BMTHBPjnXxu1VWCcBYKNP5NgVKpP821k=;
 b=UKHtQ5+EGv/Ey7IQ42jzRL70w/ah3twt8xrOv2vY0DEVsfh/PQLKWycE
 ++5oiQw4i9TmcfAWphjZr7pOz5n0RniQP4P/w7bOPbuMSrKKxDAqAkpE2
 hhKfeWVYaX41Fgz1subKJqjjo1APc2sz59GvZ/8aagC3EbKA/VV81JNsM
 uL3Zkao92lse1qq+q2p+wnriYW2dgyWTIIX+bGQNmRXFvl5FLCPZOcCdb
 g+2laKpDLwxDMZ39LIDc4zinYYgsN7trwDdlOyt1GKwcYI/z4grZEJ725
 NIhdNGUb1z02G9TrFYMGsJUYyCRdn4v4ytiid8mEREXZIIzENZj2nMjQ7 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6217231"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="6217231"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2024 16:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; d="scan'208";a="14743277"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa006.fm.intel.com with ESMTP; 21 Mar 2024 16:44:13 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	marcandre.lureau@redhat.com
Subject: [PATCH v4 3/3] ui/console: Introduce dpy_gl_create_dmabuf() helper
Date: Thu, 21 Mar 2024 16:42:36 -0700
Message-Id: <20240321234236.3476163-4-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321234236.3476163-1-dongwon.kim@intel.com>
References: <20240321234236.3476163-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

dpy_gl_create_dmabuf() allocates QemuDmaBuf and initialize fields.
hw/display modules, hw/vfio and ui/dbus-listener now use this method
to create QemuDmaBuf instead of declaring and initializing it on their
own.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/hw/vfio/vfio-common.h   |  2 +-
 include/hw/virtio/virtio-gpu.h  |  4 ++--
 include/ui/console.h            |  6 ++++++
 hw/display/vhost-user-gpu.c     | 33 ++++++++++++++++++---------------
 hw/display/virtio-gpu-udmabuf.c | 23 ++++++++---------------
 hw/vfio/display.c               | 26 +++++++++++---------------
 ui/console.c                    | 28 ++++++++++++++++++++++++++++
 ui/dbus-listener.c              | 28 ++++++++++++----------------
 8 files changed, 86 insertions(+), 64 deletions(-)

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
index ed44cdad6b..56d6e821bf 100644
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
@@ -238,7 +238,7 @@ struct VhostUserGPU {
     VhostUserBackend *vhost;
     int vhost_gpu_fd; /* closed by the chardev */
     CharBackend vhost_chr;
-    QemuDmaBuf dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
+    QemuDmaBuf *dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
     bool backend_blocked;
 };
 
diff --git a/include/ui/console.h b/include/ui/console.h
index d5334a806c..01e998264b 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -358,6 +358,12 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
                           bool have_hot, uint32_t hot_x, uint32_t hot_y);
 void dpy_gl_cursor_position(QemuConsole *con,
                             uint32_t pos_x, uint32_t pos_y);
+QemuDmaBuf *dpy_gl_create_dmabuf(uint32_t width, uint32_t height,
+                                 uint32_t stride, uint32_t x,
+                                 uint32_t y, uint32_t backing_width,
+                                 uint32_t backing_height, uint32_t fourcc,
+                                 uint64_t modifier, uint32_t dmabuf_fd,
+                                 bool allow_fences, bool y0_top);
 uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
 uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
 int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf);
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 709c8a02a1..0e49a934ed 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -249,6 +249,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
     case VHOST_USER_GPU_DMABUF_SCANOUT: {
         VhostUserGpuDMABUFScanout *m = &msg->payload.dmabuf_scanout;
         int fd = qemu_chr_fe_get_msgfd(&g->vhost_chr);
+        uint64_t modifier = 0;
         QemuDmaBuf *dmabuf;
 
         if (m->scanout_id >= g->parent_obj.conf.max_outputs) {
@@ -261,30 +262,32 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
 
         g->parent_obj.enable = 1;
         con = g->parent_obj.scanout[m->scanout_id].con;
-        dmabuf = &g->dmabuf[m->scanout_id];
-        if (dmabuf->fd >= 0) {
-            close(dmabuf->fd);
-            dmabuf->fd = -1;
+        dmabuf = g->dmabuf[m->scanout_id];
+        if (dmabuf) {
+            int dmabuf_fd = dpy_gl_dmabuf_get_fd(dmabuf);
+            if (dmabuf_fd >= 0) {
+                close(dmabuf_fd);
+            }
+            dpy_gl_release_dmabuf(con, dmabuf);
         }
-        dpy_gl_release_dmabuf(con, dmabuf);
+
         if (fd == -1) {
             dpy_gl_scanout_disable(con);
             break;
         }
-        *dmabuf = (QemuDmaBuf) {
-            .fd = fd,
-            .width = m->fd_width,
-            .height = m->fd_height,
-            .stride = m->fd_stride,
-            .fourcc = m->fd_drm_fourcc,
-            .y0_top = m->fd_flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
-        };
+
         if (msg->request == VHOST_USER_GPU_DMABUF_SCANOUT2) {
             VhostUserGpuDMABUFScanout2 *m2 = &msg->payload.dmabuf_scanout2;
-            dmabuf->modifier = m2->modifier;
+            modifier = m2->modifier;
         }
 
-        dpy_gl_scanout_dmabuf(con, dmabuf);
+        dmabuf = dpy_gl_create_dmabuf(m->fd_width, m->fd_height, m->fd_stride,
+                                      0, 0, 0, 0, m->fd_drm_fourcc, modifier,
+                                      fd, false, m->fd_flags &
+                                      VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
+
+        dpy_gl_scanout_dmabuf(con, g->dmabuf[m->scanout_id]);
+        g->dmabuf[m->scanout_id] = dmabuf;
         break;
     }
     case VHOST_USER_GPU_DMABUF_UPDATE: {
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index a4ebf828ec..2bc8697d86 100644
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
+                                       0, res->dmabuf_fd, false, 0);
     dmabuf->scanout_id = scanout_id;
     QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
 
@@ -217,11 +210,11 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
         old_primary = g->dmabuf.primary[scanout_id];
     }
 
-    width = dpy_gl_dmabuf_get_width(&new_primary->buf);
-    height = dpy_gl_dmabuf_get_height(&new_primary->buf);
+    width = dpy_gl_dmabuf_get_width(new_primary->buf);
+    height = dpy_gl_dmabuf_get_height(new_primary->buf);
     g->dmabuf.primary[scanout_id] = new_primary;
     qemu_console_resize(scanout->con, width, height);
-    dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
+    dpy_gl_scanout_dmabuf(scanout->con, new_primary->buf);
 
     if (old_primary) {
         virtio_gpu_free_dmabuf(g, old_primary);
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 676b2fc5f3..62f5db2d54 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -240,15 +240,11 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
     }
 
     dmabuf = g_new0(VFIODMABuf, 1);
-    dmabuf->dmabuf_id  = plane.dmabuf_id;
-    dmabuf->buf.width  = plane.width;
-    dmabuf->buf.height = plane.height;
-    dmabuf->buf.backing_width = plane.width;
-    dmabuf->buf.backing_height = plane.height;
-    dmabuf->buf.stride = plane.stride;
-    dmabuf->buf.fourcc = plane.drm_format;
-    dmabuf->buf.modifier = plane.drm_format_mod;
-    dmabuf->buf.fd     = fd;
+    dmabuf->dmabuf_id = plane.dmabuf_id;
+    dmabuf->buf = dpy_gl_create_dmabuf(plane.width, plane.height, plane.stride,
+                                       0, 0, plane.width, plane.height,
+                                       plane.drm_format, plane.drm_format_mod,
+                                       fd, false, 0);
     if (plane_type == DRM_PLANE_TYPE_CURSOR) {
         vfio_display_update_cursor(dmabuf, &plane);
     }
@@ -262,12 +258,12 @@ static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
     int fd;
 
     QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
-    fd = dpy_gl_dmabuf_get_fd(&dmabuf->buf);
+    fd = dpy_gl_dmabuf_get_fd(dmabuf->buf);
     if (fd > -1) {
         close(fd);
     }
 
-    dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
+    dpy_gl_release_dmabuf(dpy->con, dmabuf->buf);
     g_free(dmabuf);
 }
 
@@ -303,13 +299,13 @@ static void vfio_display_dmabuf_update(void *opaque)
         return;
     }
 
-    width = dpy_gl_dmabuf_get_width(&primary->buf);
-    height = dpy_gl_dmabuf_get_height(&primary->buf);
+    width = dpy_gl_dmabuf_get_width(primary->buf);
+    height = dpy_gl_dmabuf_get_height(primary->buf);
 
     if (dpy->dmabuf.primary != primary) {
         dpy->dmabuf.primary = primary;
         qemu_console_resize(dpy->con, width, height);
-        dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
+        dpy_gl_scanout_dmabuf(dpy->con, primary->buf);
         free_bufs = true;
     }
 
@@ -323,7 +319,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     if (cursor && (new_cursor || cursor->hot_updates)) {
         bool have_hot = (cursor->hot_x != 0xffffffff &&
                          cursor->hot_y != 0xffffffff);
-        dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
+        dpy_gl_cursor_dmabuf(dpy->con, cursor->buf, have_hot,
                              cursor->hot_x, cursor->hot_y);
         cursor->hot_updates = 0;
     } else if (!cursor && new_cursor) {
diff --git a/ui/console.c b/ui/console.c
index 69560aac7e..f3920e7713 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1132,6 +1132,33 @@ void dpy_gl_cursor_position(QemuConsole *con,
     }
 }
 
+QemuDmaBuf *dpy_gl_create_dmabuf(uint32_t width, uint32_t height,
+                                 uint32_t stride, uint32_t x,
+                                 uint32_t y, uint32_t backing_width,
+                                 uint32_t backing_height, uint32_t fourcc,
+                                 uint64_t modifier, uint32_t dmabuf_fd,
+                                 bool allow_fences, bool y0_top) {
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
+    dmabuf->y0_top = y0_top;
+    dmabuf->fence_fd = -1;
+
+    return dmabuf;
+}
+
 uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf)
 {
     if (dmabuf) {
@@ -1164,6 +1191,7 @@ void dpy_gl_release_dmabuf(QemuConsole *con,
             dcl->ops->dpy_gl_release_dmabuf(dcl, dmabuf);
         }
     }
+    g_free(dmabuf);
 }
 
 void dpy_gl_update(QemuConsole *con,
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 4a0a5d78f9..a2145704cc 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -438,28 +438,24 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
     trace_dbus_scanout_texture(tex_id, backing_y_0_top,
                                backing_width, backing_height, x, y, w, h);
 #ifdef CONFIG_GBM
-    QemuDmaBuf dmabuf = {
-        .width = w,
-        .height = h,
-        .y0_top = backing_y_0_top,
-        .x = x,
-        .y = y,
-        .backing_width = backing_width,
-        .backing_height = backing_height,
-    };
+    int32_t fd;
+    uint32_t stride, fourcc;
+    uint64_t modifier;
+    QemuDmaBuf *dmabuf;
 
     assert(tex_id);
-    dmabuf.fd = egl_get_fd_for_texture(
-        tex_id, (EGLint *)&dmabuf.stride,
-        (EGLint *)&dmabuf.fourcc,
-        &dmabuf.modifier);
-    if (dmabuf.fd < 0) {
+    fd = egl_get_fd_for_texture(tex_id, (EGLint *)&stride, (EGLint *)&fourcc,
+                                &modifier);
+    if (fd < 0) {
         error_report("%s: failed to get fd for texture", __func__);
         return;
     }
+    dmabuf = dpy_gl_create_dmabuf(w, h, stride, x, y, backing_width,
+                                  backing_height, fourcc, modifier, fd,
+                                  false, backing_y_0_top);
 
-    dbus_scanout_dmabuf(dcl, &dmabuf);
-    close(dmabuf.fd);
+    dbus_scanout_dmabuf(dcl, dmabuf);
+    close(fd);
 #endif
 
 #ifdef WIN32
-- 
2.34.1


