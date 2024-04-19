Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F50C071FD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 19:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxtX7-0005uf-CY; Fri, 19 Apr 2024 15:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxtX4-0005tO-AQ
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 15:04:22 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxtX0-0004E7-FI
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 15:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713553458; x=1745089458;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J5wMjdZAV9y5LkDR9fEtCnh+qRnNfQQ5G1PJk9EMPR4=;
 b=F/jbB49SM1/kgbukia/Bq3EfGSMKXT/Fhyjtx8cTQrq4C5jqIVXelkgY
 fYR6DjiLfuarEz20EhwW50k+VfBk6xY/GTAmC1/Ga0VF7T34dZ/YFwPBP
 UY73o9EPkpI5Y4jq7R8e895j8iYJUiqJVtflGSNMGrVhR21Kul98uuemU
 ezC200WeEYEyCMSvdkI5fs+x+d54yAsq+MlqvLThz/0RrEN5hNPOww0bP
 irJmC4yywxnflOHTp7HZyr1oUr2M6E83HLnHGDMCwRETjDyQj0l5kYSim
 I9Lm74auM78zb0J4ZyCwVma7AhdHo4vnWOUGVAMU6FjGknc5m149fT1t8 A==;
X-CSE-ConnectionGUID: QQAFrbjNR9CNS/I2m9qOdg==
X-CSE-MsgGUID: 20igW323S2iJDxTMdzGyRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20565000"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; d="scan'208";a="20565000"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2024 12:04:08 -0700
X-CSE-ConnectionGUID: YJX17AxqTBOJbIokJekROQ==
X-CSE-MsgGUID: re7z3vFzSPi7GE8SOY+hfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; d="scan'208";a="54346790"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa002.jf.intel.com with ESMTP; 19 Apr 2024 12:04:08 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH v8 5/6] ui/console: Use qemu_dmabuf_new() and free() helpers
 instead
Date: Fri, 19 Apr 2024 11:59:51 -0700
Message-Id: <20240419185952.991930-6-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419185952.991930-1-dongwon.kim@intel.com>
References: <20240419185952.991930-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
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

This commit introduces utility functions for the creation and deallocation
of QemuDmaBuf instances. Additionally, it updates all relevant sections
of the codebase to utilize these new utility functions.

v7: remove prefix, "dpy_gl_" from all helpers
    qemu_dmabuf_free() returns without doing anything if input is null
    (Daniel P. Berrangé <berrange@redhat.com>)
    call G_DEFINE_AUTOPTR_CLEANUP_FUNC for qemu_dmabuf_free()
    (Daniel P. Berrangé <berrange@redhat.com>)

v8: Introduction of helpers was removed as those were already added
    by the previous commit

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/hw/vfio/vfio-common.h   |  2 +-
 include/hw/virtio/virtio-gpu.h  |  4 ++--
 hw/display/vhost-user-gpu.c     | 32 ++++++++++++++++++--------------
 hw/display/virtio-gpu-udmabuf.c | 24 +++++++++---------------
 hw/vfio/display.c               | 26 ++++++++++++--------------
 ui/dbus-listener.c              | 28 ++++++++++++----------------
 6 files changed, 54 insertions(+), 62 deletions(-)

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
 
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index ea9a6c5d10..7f8cf38647 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -250,6 +250,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         VhostUserGpuDMABUFScanout *m = &msg->payload.dmabuf_scanout;
         int fd = qemu_chr_fe_get_msgfd(&g->vhost_chr);
         int old_fd;
+        uint64_t modifier = 0;
         QemuDmaBuf *dmabuf;
 
         if (m->scanout_id >= g->parent_obj.conf.max_outputs) {
@@ -262,31 +263,34 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
 
         g->parent_obj.enable = 1;
         con = g->parent_obj.scanout[m->scanout_id].con;
-        dmabuf = &g->dmabuf[m->scanout_id];
-        old_fd = qemu_dmabuf_get_fd(dmabuf);
-        if (old_fd >= 0) {
-            close(old_fd);
-            dmabuf->fd = -1;
+        dmabuf = g->dmabuf[m->scanout_id];
+        if (dmabuf) {
+            old_fd = qemu_dmabuf_get_fd(dmabuf);
+            if (old_fd >= 0) {
+                close(old_fd);
+                qemu_dmabuf_set_fd(dmabuf, -1);
+            }
         }
         dpy_gl_release_dmabuf(con, dmabuf);
+        g_clear_pointer(&dmabuf, qemu_dmabuf_free);
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
 
+        dmabuf = qemu_dmabuf_new(m->fd_width, m->fd_height,
+                                        m->fd_stride, 0, 0, 0, 0,
+                                        m->fd_drm_fourcc, modifier,
+                                        fd, false, m->fd_flags &
+                                        VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
+
         dpy_gl_scanout_dmabuf(con, dmabuf);
+        g->dmabuf[m->scanout_id] = dmabuf;
         break;
     }
     case VHOST_USER_GPU_DMABUF_UPDATE: {
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index c90eba281e..edd7886cf2 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -162,7 +162,8 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
     struct virtio_gpu_scanout *scanout;
 
     scanout = &g->parent_obj.scanout[dmabuf->scanout_id];
-    dpy_gl_release_dmabuf(scanout->con, &dmabuf->buf);
+    dpy_gl_release_dmabuf(scanout->con, dmabuf->buf);
+    g_clear_pointer(&dmabuf->buf, qemu_dmabuf_free);
     QTAILQ_REMOVE(&g->dmabuf.bufs, dmabuf, next);
     g_free(dmabuf);
 }
@@ -181,17 +182,10 @@ static VGPUDMABuf
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
+    dmabuf->buf = qemu_dmabuf_new(r->width, r->height, fb->stride,
+                                         r->x, r->y, fb->width, fb->height,
+                                         qemu_pixman_to_drm_format(fb->format),
+                                         0, res->dmabuf_fd, false, 0);
     dmabuf->scanout_id = scanout_id;
     QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
 
@@ -217,11 +211,11 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
         old_primary = g->dmabuf.primary[scanout_id];
     }
 
-    width = qemu_dmabuf_get_width(&new_primary->buf);
-    height = qemu_dmabuf_get_height(&new_primary->buf);
+    width = qemu_dmabuf_get_width(new_primary->buf);
+    height = qemu_dmabuf_get_height(new_primary->buf);
     g->dmabuf.primary[scanout_id] = new_primary;
     qemu_console_resize(scanout->con, width, height);
-    dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
+    dpy_gl_scanout_dmabuf(scanout->con, new_primary->buf);
 
     if (old_primary) {
         virtio_gpu_free_dmabuf(g, old_primary);
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 4861c8161d..ad15b383f5 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -241,14 +241,11 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
 
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
+    dmabuf->buf = qemu_dmabuf_new(plane.width, plane.height,
+                                         plane.stride, 0, 0, plane.width,
+                                         plane.height, plane.drm_format,
+                                         plane.drm_format_mod, fd, false, 0);
+
     if (plane_type == DRM_PLANE_TYPE_CURSOR) {
         vfio_display_update_cursor(dmabuf, &plane);
     }
@@ -263,8 +260,9 @@ static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
 
     QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
 
-    fd = qemu_dmabuf_get_fd(&dmabuf->buf);
-    dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
+    fd = qemu_dmabuf_get_fd(dmabuf->buf);
+    dpy_gl_release_dmabuf(dpy->con, dmabuf->buf);
+    g_clear_pointer(&dmabuf->buf, qemu_dmabuf_free);
     close(fd);
     g_free(dmabuf);
 }
@@ -301,13 +299,13 @@ static void vfio_display_dmabuf_update(void *opaque)
         return;
     }
 
-    width = qemu_dmabuf_get_width(&primary->buf);
-    height = qemu_dmabuf_get_height(&primary->buf);
+    width = qemu_dmabuf_get_width(primary->buf);
+    height = qemu_dmabuf_get_height(primary->buf);
 
     if (dpy->dmabuf.primary != primary) {
         dpy->dmabuf.primary = primary;
         qemu_console_resize(dpy->con, width, height);
-        dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
+        dpy_gl_scanout_dmabuf(dpy->con, primary->buf);
         free_bufs = true;
     }
 
@@ -321,7 +319,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     if (cursor && (new_cursor || cursor->hot_updates)) {
         bool have_hot = (cursor->hot_x != 0xffffffff &&
                          cursor->hot_y != 0xffffffff);
-        dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
+        dpy_gl_cursor_dmabuf(dpy->con, cursor->buf, have_hot,
                              cursor->hot_x, cursor->hot_y);
         cursor->hot_updates = 0;
     } else if (!cursor && new_cursor) {
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 62d1e2d3f9..f1775a0a39 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -442,28 +442,24 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
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
+    dmabuf = qemu_dmabuf_new(w, h, stride, x, y, backing_width,
+                                    backing_height, fourcc, modifier, fd,
+                                    false, backing_y_0_top);
 
-    dbus_scanout_dmabuf(dcl, &dmabuf);
-    close(dmabuf.fd);
+    dbus_scanout_dmabuf(dcl, dmabuf);
+    close(fd);
 #endif
 
 #ifdef WIN32
-- 
2.34.1


