Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A98EC2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 23:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKR3A-0003yO-Rf; Thu, 20 Jun 2024 19:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sKR38-0003xs-Tf
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:18:38 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sKR36-0001h8-Tl
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718925517; x=1750461517;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Uy2QvbxUULiz3fn2/7fgNVsnfpiCA62ovUKrEgHURiQ=;
 b=FORfuAFhhtnlE+U8TGpEVoyMJ52LegZqsWNecc1QqyoiDqgtLrk5uGNn
 Nb+QOFW0AokC31l4uW/WNHPU65je56xoMSuMZeMy79Q2dNcDCk7sPYHqF
 TZy4OALUUAUz+6d5POwTEGrvMBNTTqVtAAGY4xYH2IKaB5uWsTW23psDa
 SGAg8WgRUxHmaQ91YOzBH1lBD2YmhjFGE3xnqUadrOtVqFHjn46ZKv7pn
 YBBCwdbXb3r1vsFk0sraXnjshhM2lMLOgQ6XC8It5ShNX4TOCHhYv2VLy
 pj5hjEpdZm05/CtY29wf50TUj/9HYx5920QP2qG2hejf38H8SRvrslZ31 w==;
X-CSE-ConnectionGUID: PWMIqBZnS76eVaxwtizO9w==
X-CSE-MsgGUID: BG/7mYiZQMClHxISRyK/JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33482965"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="33482965"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2024 16:18:29 -0700
X-CSE-ConnectionGUID: qhAzCFMjTlmY8g3K0+6x3g==
X-CSE-MsgGUID: y3JbNpFPTpaaHlD2pdHLFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="42359630"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa008.fm.intel.com with ESMTP; 20 Jun 2024 16:18:28 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/4] hw/display/virtio-gpu: Introducing render_sync param
Date: Thu, 20 Jun 2024 16:17:24 -0700
Message-Id: <20240620231727.235841-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620231727.235841-1-dongwon.kim@intel.com>
References: <20240620231727.235841-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Introducing new virtio-gpu param, 'render_sync' when guest scanout blob
is used (blob=true). The new param is used to specify when to start
rendering a guest scanout frame.

By default (and so far) rendering of the guest frame is started in
the draw event to make sure guest display update is sychronized with
host's vsync. But this method inevitably brings some extra wait because
most of time, the draw event is not happening right after the guest
scanout frame is flushed.

This delay often makes the guest stuck at certain frame for too long and
causes general performance degradation of graphic workloads on the guest's
side especially when the display update rate is high. This unwanted perf
drop can be reduced if the guest scanout frame is rendered as soon as it is
flushed through 'VIRTIO_GPU_CMD_RESOURCE_FLUSH' msg. The gl display
pipeline can be unblocked a lot earlier in this case so that guest can
move to the next display frame right away.

However, this "asynchrounous" render mode may cause some waste of resources
as the guest could produce more frames than what are actually displayed
on the host display. This is similar as running rendering apps with no vblank
or vsync option. This is why this feature should stay as optional.

The param 'render_sync' is set to 'true' by default and this is in line
with traditional way while setting it to 'false' is basically enabling
this asynchronouse mode.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/hw/virtio/virtio-gpu.h  |  3 +++
 include/ui/dmabuf.h             |  4 +++-
 hw/display/vhost-user-gpu.c     |  3 ++-
 hw/display/virtio-gpu-udmabuf.c |  3 ++-
 hw/display/virtio-gpu.c         |  2 ++
 hw/vfio/display.c               |  3 ++-
 ui/dbus-listener.c              |  2 +-
 ui/dmabuf.c                     | 11 ++++++++++-
 8 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7a59379f5a..9bcc572eab 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -97,6 +97,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_EDID_ENABLED,
     VIRTIO_GPU_FLAG_DMABUF_ENABLED,
     VIRTIO_GPU_FLAG_BLOB_ENABLED,
+    VIRTIO_GPU_FLAG_RENDER_SYNC_ENABLED,
     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
 };
@@ -111,6 +112,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DMABUF_ENABLED))
 #define virtio_gpu_blob_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED))
+#define virtio_gpu_render_sync_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RENDER_SYNC_ENABLED))
 #define virtio_gpu_context_init_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
 #define virtio_gpu_rutabaga_enabled(_cfg) \
diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
index dc74ba895a..45384e32e3 100644
--- a/include/ui/dmabuf.h
+++ b/include/ui/dmabuf.h
@@ -17,7 +17,8 @@ QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
                             uint32_t y, uint32_t backing_width,
                             uint32_t backing_height, uint32_t fourcc,
                             uint64_t modifier, int dmabuf_fd,
-                            bool allow_fences, bool y0_top);
+                            bool allow_fences, bool y0_top,
+                            bool render_sync);
 void qemu_dmabuf_free(QemuDmaBuf *dmabuf);
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuDmaBuf, qemu_dmabuf_free);
@@ -40,6 +41,7 @@ void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf);
 int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
+bool qemu_dmabuf_get_render_sync(QemuDmaBuf *dmabuf);
 void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
 void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd);
 void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync);
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index e4b398d26c..69fa722c88 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -285,7 +285,8 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
                                  m->fd_stride, 0, 0, 0, 0,
                                  m->fd_drm_fourcc, modifier,
                                  fd, false, m->fd_flags &
-                                 VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
+                                 VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
+                                 false);
 
         dpy_gl_scanout_dmabuf(con, dmabuf);
         g->dmabuf[m->scanout_id] = dmabuf;
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index c02ec6d37d..8fcc0c3055 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -176,6 +176,7 @@ static VGPUDMABuf
                           struct virtio_gpu_rect *r)
 {
     VGPUDMABuf *dmabuf;
+    bool render_sync = virtio_gpu_render_sync_enabled(g->parent_obj.conf);
 
     if (res->dmabuf_fd < 0) {
         return NULL;
@@ -185,7 +186,7 @@ static VGPUDMABuf
     dmabuf->buf = qemu_dmabuf_new(r->width, r->height, fb->stride,
                                   r->x, r->y, fb->width, fb->height,
                                   qemu_pixman_to_drm_format(fb->format),
-                                  0, res->dmabuf_fd, true, false);
+                                  0, res->dmabuf_fd, true, false, render_sync);
     dmabuf->scanout_id = scanout_id;
     QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index d60b1b2973..b6b82de306 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1671,6 +1671,8 @@ static Property virtio_gpu_properties[] = {
                      256 * MiB),
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
+    DEFINE_PROP_BIT("render_sync", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_RENDER_SYNC_ENABLED, true),
     DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
     DEFINE_PROP_UINT8("x-scanout-vmstate-version", VirtIOGPU, scanout_vmstate_version, 2),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 661e921616..202ba78288 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -244,7 +244,8 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
     dmabuf->buf = qemu_dmabuf_new(plane.width, plane.height,
                                   plane.stride, 0, 0, plane.width,
                                   plane.height, plane.drm_format,
-                                  plane.drm_format_mod, fd, false, false);
+                                  plane.drm_format_mod, fd, false,
+                                  false, false);
 
     if (plane_type == DRM_PLANE_TYPE_CURSOR) {
         vfio_display_update_cursor(dmabuf, &plane);
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 5490088043..7547b0e248 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -456,7 +456,7 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
     }
     dmabuf = qemu_dmabuf_new(w, h, stride, x, y, backing_width,
                              backing_height, fourcc, modifier, fd,
-                             false, backing_y_0_top);
+                             false, backing_y_0_top, false);
 
     dbus_scanout_dmabuf(dcl, dmabuf);
     qemu_dmabuf_close(dmabuf);
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
index df7a09703f..193097f9a2 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -26,6 +26,7 @@ struct QemuDmaBuf {
     void      *sync;
     int       fence_fd;
     bool      allow_fences;
+    bool      render_sync;
     bool      draw_submitted;
 };
 
@@ -34,7 +35,7 @@ QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
                             uint32_t y, uint32_t backing_width,
                             uint32_t backing_height, uint32_t fourcc,
                             uint64_t modifier, int32_t dmabuf_fd,
-                            bool allow_fences, bool y0_top) {
+                            bool allow_fences, bool y0_top, bool render_sync) {
     QemuDmaBuf *dmabuf;
 
     dmabuf = g_new0(QemuDmaBuf, 1);
@@ -51,6 +52,7 @@ QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
     dmabuf->fd = dmabuf_fd;
     dmabuf->allow_fences = allow_fences;
     dmabuf->y0_top = y0_top;
+    dmabuf->render_sync = render_sync;
     dmabuf->fence_fd = -1;
 
     return dmabuf;
@@ -198,6 +200,13 @@ bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf)
     return dmabuf->draw_submitted;
 }
 
+bool qemu_dmabuf_get_render_sync(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->render_sync;
+}
+
 void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture)
 {
     assert(dmabuf != NULL);
-- 
2.34.1


