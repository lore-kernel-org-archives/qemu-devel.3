Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103C9C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXa8-0002mp-60; Wed, 07 May 2025 01:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uCXa5-0002it-CJ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uCXa3-0004IK-3P
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746596670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CYWcUpcRYkQvycyZBe4Ragw7BTNTeMZAdQ3Jj5b/xPQ=;
 b=anr5XK4E4WVbK0dRlsYJxSm8fjQM69SeQD8bQwPD5gHc4qGfh7e2Eh36Q3Ft2KX4kkp67v
 YFUZOs0V39LN+/5EZRt7wy0WvKZFfLT5tZ1R4sUtVScPj/eB7+L4syWFnvG0lHV6aEJkGz
 pDml/7XApxlhHrxbP2YTdjmIP5lHkBU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-dtM5hOY4OyaDNkvXZ8-nnA-1; Wed,
 07 May 2025 01:44:28 -0400
X-MC-Unique: dtM5hOY4OyaDNkvXZ8-nnA-1
X-Mimecast-MFC-AGG-ID: dtM5hOY4OyaDNkvXZ8-nnA_1746596667
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80C721801A12; Wed,  7 May 2025 05:44:27 +0000 (UTC)
Received: from localhost (unknown [10.45.242.19])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 310631953B82; Wed,  7 May 2025 05:44:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PULL 1/6] ui/dmabuf: extend QemuDmaBuf to support multi-plane
Date: Wed,  7 May 2025 09:44:09 +0400
Message-ID: <20250507054414.2284129-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250507054414.2284129-1-marcandre.lureau@redhat.com>
References: <20250507054414.2284129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Qiang Yu <yuq825@gmail.com>

mesa/radeonsi is going to support explicit modifier which
may export a multi-plane texture. For example, texture with
DCC enabled (a compressed format) has two planes, one with
compressed data, the other with meta data for compression.

v2:
  * change API qemu_dmabuf_get_fd/offset/stride to
    qemu_dmabuf_get_fds/offsets/strides.
  * change API qemu_dmabuf_dup_fd to qemu_dmabuf_dup_fds.
  * add an extra arg to these API for the length of the
    array.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
[ Fix style ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250327025848.46962-2-yuq825@gmail.com>
---
 include/ui/dmabuf.h             | 20 +++++----
 hw/display/vhost-user-gpu.c     |  6 ++-
 hw/display/virtio-gpu-udmabuf.c |  6 ++-
 hw/vfio/display.c               |  7 +--
 ui/dbus-listener.c              | 10 ++---
 ui/dmabuf.c                     | 80 +++++++++++++++++++++++----------
 ui/egl-helpers.c                |  4 +-
 ui/spice-display.c              |  4 +-
 8 files changed, 89 insertions(+), 48 deletions(-)

diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
index dc74ba895a..3decdca497 100644
--- a/include/ui/dmabuf.h
+++ b/include/ui/dmabuf.h
@@ -10,24 +10,29 @@
 #ifndef DMABUF_H
 #define DMABUF_H
 
+#define DMABUF_MAX_PLANES 4
+
 typedef struct QemuDmaBuf QemuDmaBuf;
 
 QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
-                            uint32_t stride, uint32_t x,
-                            uint32_t y, uint32_t backing_width,
-                            uint32_t backing_height, uint32_t fourcc,
-                            uint64_t modifier, int dmabuf_fd,
+                            const uint32_t *offset, const uint32_t *stride,
+                            uint32_t x, uint32_t y,
+                            uint32_t backing_width, uint32_t backing_height,
+                            uint32_t fourcc, uint64_t modifier,
+                            const int32_t *dmabuf_fd, uint32_t num_planes,
                             bool allow_fences, bool y0_top);
 void qemu_dmabuf_free(QemuDmaBuf *dmabuf);
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuDmaBuf, qemu_dmabuf_free);
 
-int qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
-int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf);
+const int *qemu_dmabuf_get_fds(QemuDmaBuf *dmabuf, int *nfds);
+void qemu_dmabuf_dup_fds(QemuDmaBuf *dmabuf, int *fds, int nfds);
 void qemu_dmabuf_close(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
-uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
+const uint32_t *qemu_dmabuf_get_offsets(QemuDmaBuf *dmabuf, int *noffsets);
+const uint32_t *qemu_dmabuf_get_strides(QemuDmaBuf *dmabuf, int *nstrides);
+uint32_t qemu_dmabuf_get_num_planes(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf);
 uint64_t qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf);
@@ -44,6 +49,5 @@ void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
 void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd);
 void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync);
 void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted);
-void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd);
 
 #endif
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 06c4e7e190..a367daac82 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -249,6 +249,8 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
     case VHOST_USER_GPU_DMABUF_SCANOUT: {
         VhostUserGpuDMABUFScanout *m = &msg->payload.dmabuf_scanout;
         int fd = qemu_chr_fe_get_msgfd(&g->vhost_chr);
+        uint32_t offset = 0;
+        uint32_t stride = m->fd_stride;
         uint64_t modifier = 0;
         QemuDmaBuf *dmabuf;
 
@@ -282,10 +284,10 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         }
 
         dmabuf = qemu_dmabuf_new(m->width, m->height,
-                                 m->fd_stride, 0, 0,
+                                 &offset, &stride, 0, 0,
                                  m->fd_width, m->fd_height,
                                  m->fd_drm_fourcc, modifier,
-                                 fd, false, m->fd_flags &
+                                 &fd, 1, false, m->fd_flags &
                                  VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
 
         dpy_gl_scanout_dmabuf(con, dmabuf);
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 0510577475..01b0024ead 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -176,16 +176,18 @@ static VGPUDMABuf
                           struct virtio_gpu_rect *r)
 {
     VGPUDMABuf *dmabuf;
+    uint32_t offset = 0;
 
     if (res->dmabuf_fd < 0) {
         return NULL;
     }
 
     dmabuf = g_new0(VGPUDMABuf, 1);
-    dmabuf->buf = qemu_dmabuf_new(r->width, r->height, fb->stride,
+    dmabuf->buf = qemu_dmabuf_new(r->width, r->height,
+                                  &offset, &fb->stride,
                                   r->x, r->y, fb->width, fb->height,
                                   qemu_pixman_to_drm_format(fb->format),
-                                  0, res->dmabuf_fd, true, false);
+                                  0, &res->dmabuf_fd, 1, true, false);
     dmabuf->scanout_id = scanout_id;
     QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
 
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index f3e6581f15..9c6f5aa265 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -213,6 +213,7 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
     struct vfio_device_gfx_plane_info plane;
     VFIODMABuf *dmabuf;
     int fd, ret;
+    uint32_t offset = 0;
 
     memset(&plane, 0, sizeof(plane));
     plane.argsz = sizeof(plane);
@@ -245,10 +246,10 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
 
     dmabuf = g_new0(VFIODMABuf, 1);
     dmabuf->dmabuf_id  = plane.dmabuf_id;
-    dmabuf->buf = qemu_dmabuf_new(plane.width, plane.height,
-                                  plane.stride, 0, 0, plane.width,
+    dmabuf->buf = qemu_dmabuf_new(plane.width, plane.height, &offset,
+                                  &plane.stride, 0, 0, plane.width,
                                   plane.height, plane.drm_format,
-                                  plane.drm_format_mod, fd, false, false);
+                                  plane.drm_format_mod, &fd, 1, false, false);
 
     if (plane_type == DRM_PLANE_TYPE_CURSOR) {
         vfio_display_update_cursor(dmabuf, &plane);
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 51244c9240..65373d519c 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -299,7 +299,7 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
     uint64_t modifier;
     bool y0_top;
 
-    fd = qemu_dmabuf_get_fd(dmabuf);
+    fd = qemu_dmabuf_get_fds(dmabuf, NULL)[0];
     fd_list = g_unix_fd_list_new();
     if (g_unix_fd_list_append(fd_list, fd, &err) != 0) {
         error_report("Failed to setup dmabuf fdlist: %s", err->message);
@@ -310,7 +310,7 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
 
     width = qemu_dmabuf_get_width(dmabuf);
     height = qemu_dmabuf_get_height(dmabuf);
-    stride = qemu_dmabuf_get_stride(dmabuf);
+    stride = qemu_dmabuf_get_strides(dmabuf, NULL)[0];
     fourcc = qemu_dmabuf_get_fourcc(dmabuf);
     modifier = qemu_dmabuf_get_modifier(dmabuf);
     y0_top = qemu_dmabuf_get_y0_top(dmabuf);
@@ -505,7 +505,7 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
 #ifdef CONFIG_GBM
     g_autoptr(QemuDmaBuf) dmabuf = NULL;
     int fd;
-    uint32_t stride, fourcc;
+    uint32_t offset = 0, stride, fourcc;
     uint64_t modifier;
 
     assert(tex_id);
@@ -515,8 +515,8 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
         error_report("%s: failed to get fd for texture", __func__);
         return;
     }
-    dmabuf = qemu_dmabuf_new(w, h, stride, x, y, backing_width,
-                             backing_height, fourcc, modifier, fd,
+    dmabuf = qemu_dmabuf_new(w, h, &offset, &stride, x, y, backing_width,
+                             backing_height, fourcc, modifier, &fd, 1,
                              false, backing_y_0_top);
 
     dbus_scanout_dmabuf(dcl, dmabuf);
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
index df7a09703f..7433a268f0 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -11,10 +11,12 @@
 #include "ui/dmabuf.h"
 
 struct QemuDmaBuf {
-    int       fd;
+    int       fd[DMABUF_MAX_PLANES];
     uint32_t  width;
     uint32_t  height;
-    uint32_t  stride;
+    uint32_t  offset[DMABUF_MAX_PLANES];
+    uint32_t  stride[DMABUF_MAX_PLANES];
+    uint32_t  num_planes;
     uint32_t  fourcc;
     uint64_t  modifier;
     uint32_t  texture;
@@ -30,28 +32,33 @@ struct QemuDmaBuf {
 };
 
 QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
-                            uint32_t stride, uint32_t x,
-                            uint32_t y, uint32_t backing_width,
-                            uint32_t backing_height, uint32_t fourcc,
-                            uint64_t modifier, int32_t dmabuf_fd,
+                            const uint32_t *offset, const uint32_t *stride,
+                            uint32_t x, uint32_t y,
+                            uint32_t backing_width, uint32_t backing_height,
+                            uint32_t fourcc, uint64_t modifier,
+                            const int32_t *dmabuf_fd, uint32_t num_planes,
                             bool allow_fences, bool y0_top) {
     QemuDmaBuf *dmabuf;
 
+    assert(num_planes > 0 && num_planes <= DMABUF_MAX_PLANES);
+
     dmabuf = g_new0(QemuDmaBuf, 1);
 
     dmabuf->width = width;
     dmabuf->height = height;
-    dmabuf->stride = stride;
+    memcpy(dmabuf->offset, offset, num_planes * sizeof(*offset));
+    memcpy(dmabuf->stride, stride, num_planes * sizeof(*stride));
     dmabuf->x = x;
     dmabuf->y = y;
     dmabuf->backing_width = backing_width;
     dmabuf->backing_height = backing_height;
     dmabuf->fourcc = fourcc;
     dmabuf->modifier = modifier;
-    dmabuf->fd = dmabuf_fd;
+    memcpy(dmabuf->fd, dmabuf_fd, num_planes * sizeof(*dmabuf_fd));
     dmabuf->allow_fences = allow_fences;
     dmabuf->y0_top = y0_top;
     dmabuf->fence_fd = -1;
+    dmabuf->num_planes = num_planes;
 
     return dmabuf;
 }
@@ -65,31 +72,40 @@ void qemu_dmabuf_free(QemuDmaBuf *dmabuf)
     g_free(dmabuf);
 }
 
-int qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
+const int *qemu_dmabuf_get_fds(QemuDmaBuf *dmabuf, int *nfds)
 {
     assert(dmabuf != NULL);
 
+    if (nfds) {
+        *nfds = ARRAY_SIZE(dmabuf->fd);
+    }
+
     return dmabuf->fd;
 }
 
-int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf)
+void qemu_dmabuf_dup_fds(QemuDmaBuf *dmabuf, int *fds, int nfds)
 {
+    int i;
+
     assert(dmabuf != NULL);
+    assert(nfds >= dmabuf->num_planes);
 
-    if (dmabuf->fd >= 0) {
-        return dup(dmabuf->fd);
-    } else {
-        return -1;
+    for (i = 0; i < dmabuf->num_planes; i++) {
+        fds[i] = dmabuf->fd[i] >= 0 ? dup(dmabuf->fd[i]) : -1;
     }
 }
 
 void qemu_dmabuf_close(QemuDmaBuf *dmabuf)
 {
+    int i;
+
     assert(dmabuf != NULL);
 
-    if (dmabuf->fd >= 0) {
-        close(dmabuf->fd);
-        dmabuf->fd = -1;
+    for (i = 0; i < dmabuf->num_planes; i++) {
+        if (dmabuf->fd[i] >= 0) {
+            close(dmabuf->fd[i]);
+            dmabuf->fd[i] = -1;
+        }
     }
 }
 
@@ -107,13 +123,35 @@ uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf)
     return dmabuf->height;
 }
 
-uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf)
+const uint32_t *qemu_dmabuf_get_offsets(QemuDmaBuf *dmabuf, int *noffsets)
+{
+    assert(dmabuf != NULL);
+
+    if (noffsets) {
+        *noffsets = ARRAY_SIZE(dmabuf->offset);
+    }
+
+    return dmabuf->offset;
+}
+
+const uint32_t *qemu_dmabuf_get_strides(QemuDmaBuf *dmabuf, int *nstrides)
 {
     assert(dmabuf != NULL);
 
+    if (nstrides) {
+        *nstrides = ARRAY_SIZE(dmabuf->stride);
+    }
+
     return dmabuf->stride;
 }
 
+uint32_t qemu_dmabuf_get_num_planes(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->num_planes;
+}
+
 uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf)
 {
     assert(dmabuf != NULL);
@@ -221,9 +259,3 @@ void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted)
     assert(dmabuf != NULL);
     dmabuf->draw_submitted = draw_submitted;
 }
-
-void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd)
-{
-    assert(dmabuf != NULL);
-    dmabuf->fd = fd;
-}
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index d591159480..d194d004b7 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -323,9 +323,9 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
     attrs[i++] = qemu_dmabuf_get_fourcc(dmabuf);
 
     attrs[i++] = EGL_DMA_BUF_PLANE0_FD_EXT;
-    attrs[i++] = qemu_dmabuf_get_fd(dmabuf);
+    attrs[i++] = qemu_dmabuf_get_fds(dmabuf, NULL)[0];
     attrs[i++] = EGL_DMA_BUF_PLANE0_PITCH_EXT;
-    attrs[i++] = qemu_dmabuf_get_stride(dmabuf);
+    attrs[i++] = qemu_dmabuf_get_strides(dmabuf, NULL)[0];
     attrs[i++] = EGL_DMA_BUF_PLANE0_OFFSET_EXT;
     attrs[i++] = 0;
 #ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
diff --git a/ui/spice-display.c b/ui/spice-display.c
index c794ae0649..40547edb5e 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1075,10 +1075,10 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                      stride, fourcc, false);
             }
         } else {
-            stride = qemu_dmabuf_get_stride(dmabuf);
+            stride = qemu_dmabuf_get_strides(dmabuf, NULL)[0];
             fourcc = qemu_dmabuf_get_fourcc(dmabuf);
             y_0_top = qemu_dmabuf_get_y0_top(dmabuf);
-            fd = qemu_dmabuf_dup_fd(dmabuf);
+            qemu_dmabuf_dup_fds(dmabuf, &fd, 1);
 
             trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, height);
             /* note: spice server will close the fd, so hand over a dup */
-- 
2.49.0


