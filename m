Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74779C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6s2s-0004fP-Gi; Tue, 14 May 2024 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2l-0004XV-QC
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2i-0002KJ-Kk
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715692686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sy5f4PQZOBVxPANYLm3i4BKeZcSjWyaDNzcaEV1n7CU=;
 b=N1yV6x59oVdLVcFuYfVrB14wgw3pXgjkQjPu5XtBtc6rEienEY3VOaDL2dExjBy24rXPKm
 OqQfkU+RHz1EroPzsVNAIWeSFDJGRlWUIqdu/ApQWVi6uqCVXoSL8VBbL/Wj2zvEkn9rQ1
 IOveD86L8oGsoXjX5/wVOo3atwWwSVo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-uotD9peqPSy-8gKDcPfdtA-1; Tue,
 14 May 2024 09:18:03 -0400
X-MC-Unique: uotD9peqPSy-8gKDcPfdtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56D6E1C01500;
 Tue, 14 May 2024 13:18:03 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB18A3C27;
 Tue, 14 May 2024 13:18:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/11] ui/console: Use qemu_dmabuf_new() and free() helpers
 instead
Date: Tue, 14 May 2024 17:17:21 +0400
Message-ID: <20240514131725.931234-8-marcandre.lureau@redhat.com>
In-Reply-To: <20240514131725.931234-1-marcandre.lureau@redhat.com>
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v9: set dmabuf->allow_fences to 'true' when dmabuf is created in
    virtio_gpu_create_dmabuf()/virtio-gpu-udmabuf.c

    removed unnecessary spaces were accidently added in the patch,
    'ui/console: Use qemu_dmabuf_new() a...'

v11: Calling qemu_dmabuf_close was removed as closing dmabuf->fd will be
     done in qemu_dmabuf_free anyway.
     (Daniel P. Berrangé <berrange@redhat.com>)

v12: --- Calling qemu_dmabuf_close separately as qemu_dmabuf_free doesn't
         do it.

     --- 'dmabuf' is now allocated space so it should be freed at the end of
         dbus_scanout_texture

v13: --- Immediately free dmabuf after it is released to prevent possible
         leaking of the ptr
         (Marc-André Lureau <marcandre.lureau@redhat.com>)

     --- Use g_autoptr macro to define *dmabuf for auto clean up instead of
         calling qemu_dmabuf_free
         (Marc-André Lureau <marcandre.lureau@redhat.com>)

v14: --- (vhost-user-gpu) Change qemu_dmabuf_free back to g_clear_pointer
         as it was done because of some misunderstanding (v13).

     --- (vhost-user-gpu) g->dmabuf[m->scanout_id] needs to be set to NULL
         to prevent freed dmabuf to be accessed again in case if(fd==-1)break;
         happens (before new dmabuf is allocated). Otherwise, it would cause
         invalid memory access when the same function is executed. Also NULL
         check should be done before qemu_dmabuf_close (it asserts dmabuf!=NULL.).
         (Marc-André Lureau <marcandre.lureau@redhat.com>)

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-Id: <20240508175403.3399895-6-dongwon.kim@intel.com>
---
 include/hw/vfio/vfio-common.h   |  2 +-
 include/hw/virtio/virtio-gpu.h  |  4 ++--
 hw/display/vhost-user-gpu.c     | 31 +++++++++++++++++++------------
 hw/display/virtio-gpu-udmabuf.c | 24 +++++++++---------------
 hw/vfio/display.c               | 26 ++++++++++++--------------
 ui/dbus-listener.c              | 28 ++++++++++++----------------
 6 files changed, 55 insertions(+), 60 deletions(-)

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
index 454e5afcff..e4b398d26c 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -249,6 +249,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
     case VHOST_USER_GPU_DMABUF_SCANOUT: {
         VhostUserGpuDMABUFScanout *m = &msg->payload.dmabuf_scanout;
         int fd = qemu_chr_fe_get_msgfd(&g->vhost_chr);
+        uint64_t modifier = 0;
         QemuDmaBuf *dmabuf;
 
         if (m->scanout_id >= g->parent_obj.conf.max_outputs) {
@@ -261,27 +262,33 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
 
         g->parent_obj.enable = 1;
         con = g->parent_obj.scanout[m->scanout_id].con;
-        dmabuf = &g->dmabuf[m->scanout_id];
-        qemu_dmabuf_close(dmabuf);
-        dpy_gl_release_dmabuf(con, dmabuf);
+        dmabuf = g->dmabuf[m->scanout_id];
+
+        if (dmabuf) {
+            qemu_dmabuf_close(dmabuf);
+            dpy_gl_release_dmabuf(con, dmabuf);
+            g_clear_pointer(&dmabuf, qemu_dmabuf_free);
+        }
+
         if (fd == -1) {
             dpy_gl_scanout_disable(con);
+            g->dmabuf[m->scanout_id] = NULL;
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
+                                 m->fd_stride, 0, 0, 0, 0,
+                                 m->fd_drm_fourcc, modifier,
+                                 fd, false, m->fd_flags &
+                                 VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
+
         dpy_gl_scanout_dmabuf(con, dmabuf);
+        g->dmabuf[m->scanout_id] = dmabuf;
         break;
     }
     case VHOST_USER_GPU_DMABUF_UPDATE: {
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index c90eba281e..c02ec6d37d 100644
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
+                                  r->x, r->y, fb->width, fb->height,
+                                  qemu_pixman_to_drm_format(fb->format),
+                                  0, res->dmabuf_fd, true, false);
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
index 7784502b53..fe624a6c9b 100644
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
+                                  plane.stride, 0, 0, plane.width,
+                                  plane.height, plane.drm_format,
+                                  plane.drm_format_mod, fd, false, false);
+
     if (plane_type == DRM_PLANE_TYPE_CURSOR) {
         vfio_display_update_cursor(dmabuf, &plane);
     }
@@ -261,8 +258,9 @@ static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
 {
     QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
 
-    qemu_dmabuf_close(&dmabuf->buf);
-    dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
+    qemu_dmabuf_close(dmabuf->buf);
+    dpy_gl_release_dmabuf(dpy->con, dmabuf->buf);
+    g_clear_pointer(&dmabuf->buf, qemu_dmabuf_free);
     g_free(dmabuf);
 }
 
@@ -298,13 +296,13 @@ static void vfio_display_dmabuf_update(void *opaque)
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
 
@@ -318,7 +316,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     if (cursor && (new_cursor || cursor->hot_updates)) {
         bool have_hot = (cursor->hot_x != 0xffffffff &&
                          cursor->hot_y != 0xffffffff);
-        dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
+        dpy_gl_cursor_dmabuf(dpy->con, cursor->buf, have_hot,
                              cursor->hot_x, cursor->hot_y);
         cursor->hot_updates = 0;
     } else if (!cursor && new_cursor) {
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 62d1e2d3f9..5490088043 100644
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
+    g_autoptr(QemuDmaBuf) dmabuf = NULL;
+    int fd;
+    uint32_t stride, fourcc;
+    uint64_t modifier;
 
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
+                             backing_height, fourcc, modifier, fd,
+                             false, backing_y_0_top);
 
-    dbus_scanout_dmabuf(dcl, &dmabuf);
-    close(dmabuf.fd);
+    dbus_scanout_dmabuf(dcl, dmabuf);
+    qemu_dmabuf_close(dmabuf);
 #endif
 
 #ifdef WIN32
-- 
2.41.0.28.gd7d8841f67


