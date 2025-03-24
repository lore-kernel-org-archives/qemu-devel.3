Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D08C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 08:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twd2B-0005x6-Et; Mon, 24 Mar 2025 04:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd27-0005wF-NE
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:44 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd24-0008U3-I1
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:42 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224191d92e4so74492675ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742804378; x=1743409178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=euNdCVq4nnuvJitoikcBPMwBYVw2NPIet0QQQCOfFzo=;
 b=PB/CkLQLtuxXoQP2fLzvF7iNR14OwmQqgum9qeEW+00tMF4DLub7BSzTvG3Z/eQYvK
 IqNV4hZvv1/ImJ2Uug213meNa06KDk/jh1T/H59pQceM5KkBOnpozSqZqTiRZvV2hRQG
 oqQq2vyJV/90jbvRfBovFtFnNxH9H4xKkW6lzfxrVz/GKLOHd6xPwCMFuQch750u7ilg
 zJ6/VacCF0rjBrrPJVnPUIb7m+ueIee8TgR7l2C7BlhxpKE74c8c0LAyJH/zIzkphfZ9
 aDbZCmodW3UD/zEqGoRx5G6s+snWXCOX9+UXN8i+4B9kJ6/vtKz89/mvRXYfz+k2AEFA
 42VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742804378; x=1743409178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=euNdCVq4nnuvJitoikcBPMwBYVw2NPIet0QQQCOfFzo=;
 b=VPcIPyEhGPUas2vKynfoDS2xxGXklneK4pbtoVO2pHrx1zf/SF9hTKMbqGHAMayc2i
 pU4tQpQaJJWS5wwxJ9G02yBg77MqYmAJz2z8U62/dgC6PnBRHKZSxMeVgPc9F5pzqdTp
 4u9QyrTDbhGHBX9oNt7vAxQXfbBbCUAnl/ECwFBNLpX4Ojp83SKJFPinyxjG0mlb5bnb
 OGHYkmjhxJmd56CuMcmqqs7EldJF3HO90q17Fbn20h1aoNciNhS2tQzAL0K1jJrF1A8X
 Y7e3DNm7YymPMUNgivoQJbVSMlZg6fm4311ql1+lQzQE+xILPk6uuZZD8v8i0uhOw396
 A4Cw==
X-Gm-Message-State: AOJu0YyIKyCFSW5vW4IGWZ6e4sMwhoIPtoKmu51OEwsks+x6Qq7sPsiQ
 KDAe8Ab00dGO0Paqey1Zt2BllYBlxcugJQpeVr45qkVsG9nu9fLnUpE+t6wF
X-Gm-Gg: ASbGnct1AX7eMW1moEyKC93P3RItKMgVX6N3PkgRyUAIJIuZuP56+X7WPVEQI74aXwn
 DxZ37HVD5XdeDdvUxiE12KD6IL+wB/pzXwtawCt3/9BC6XFy9kwqvzmVWhO8WRdjRk+l7AKAY+A
 Eht2nXUKn4OOBPR2asQkI78wRUDZwhJd05rQEGmU+Aw1/fBnLJ9+DSrVRRbk7Ek7zVJsOR1AvzM
 XEGmC/ah//UnokzXC25QspEPvJFWoroCQDTjLYEBppL82+V5Nq+6OMVTD+Xz/i96wJrkNkxFngd
 N15zyCnbrxGeuxDsv7GX4ieTXyJCNyV4drOPd0bEuDKQKQ8avh9m4tTZMRM/872jmZpcuKaw5IW
 thqhuAxu/+NjfAZpK8mLo
X-Google-Smtp-Source: AGHT+IG+Mnv8Q/E6f2slG1au3MDOsIr5i9HLgjzwrKRCkJLnKT0+1WgHnzKLr6ztDqm/oo19rTq91Q==
X-Received: by 2002:a17:903:230d:b0:21f:4b01:b978 with SMTP id
 d9443c01a7336-22780e3fd0amr199069715ad.36.1742804377836; 
 Mon, 24 Mar 2025 01:19:37 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2278120a5b6sm64717685ad.252.2025.03.24.01.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 01:19:36 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 1/6] ui/dmabuf: extend QemuDmaBuf to support multi-plane
Date: Mon, 24 Mar 2025 16:19:16 +0800
Message-ID: <20250324081922.359369-2-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324081922.359369-1-yuq825@gmail.com>
References: <20250324081922.359369-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Qiang Yu <yuq825@gmail.com>

mesa/radeonsi is going to support explicit midifier which
may export a multi-plane texture. For example, texture with
DCC enabled (a compressed format) has two planes, one with
compressed data, the other with meta data for compression.

Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 hw/display/vhost-user-gpu.c     |  6 ++-
 hw/display/virtio-gpu-udmabuf.c |  6 ++-
 hw/vfio/display.c               |  7 ++--
 include/ui/dmabuf.h             | 20 ++++++----
 ui/dbus-listener.c              | 10 ++---
 ui/dmabuf.c                     | 67 +++++++++++++++++++++------------
 ui/egl-helpers.c                |  4 +-
 ui/spice-display.c              |  4 +-
 8 files changed, 76 insertions(+), 48 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 2aed6243f6..a7949c7078 100644
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
index 85ca23cb32..34fbe05b7a 100644
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
index ea87830fe0..9d882235fb 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -214,6 +214,7 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
     struct vfio_device_gfx_plane_info plane;
     VFIODMABuf *dmabuf;
     int fd, ret;
+    uint32_t offset = 0;
 
     memset(&plane, 0, sizeof(plane));
     plane.argsz = sizeof(plane);
@@ -246,10 +247,10 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
 
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
diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
index dc74ba895a..407fb2274e 100644
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
+const int *qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
+void qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf, int *fd);
 void qemu_dmabuf_close(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
-uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
+const uint32_t *qemu_dmabuf_get_offset(QemuDmaBuf *dmabuf);
+const uint32_t *qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
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
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 51244c9240..3b39a23846 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -299,7 +299,7 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
     uint64_t modifier;
     bool y0_top;
 
-    fd = qemu_dmabuf_get_fd(dmabuf);
+    fd = qemu_dmabuf_get_fd(dmabuf)[0];
     fd_list = g_unix_fd_list_new();
     if (g_unix_fd_list_append(fd_list, fd, &err) != 0) {
         error_report("Failed to setup dmabuf fdlist: %s", err->message);
@@ -310,7 +310,7 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
 
     width = qemu_dmabuf_get_width(dmabuf);
     height = qemu_dmabuf_get_height(dmabuf);
-    stride = qemu_dmabuf_get_stride(dmabuf);
+    stride = qemu_dmabuf_get_stride(dmabuf)[0];
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
index df7a09703f..c4eb307042 100644
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
@@ -65,31 +72,35 @@ void qemu_dmabuf_free(QemuDmaBuf *dmabuf)
     g_free(dmabuf);
 }
 
-int qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
+const int *qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
 {
     assert(dmabuf != NULL);
 
     return dmabuf->fd;
 }
 
-int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf)
+void qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf, int *fd)
 {
+    int i;
+
     assert(dmabuf != NULL);
 
-    if (dmabuf->fd >= 0) {
-        return dup(dmabuf->fd);
-    } else {
-        return -1;
+    for (i = 0; i < dmabuf->num_planes; i++) {
+        fd[i] = dmabuf->fd[i] >= 0 ? dup(dmabuf->fd[i]) : -1;
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
 
@@ -107,13 +118,27 @@ uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf)
     return dmabuf->height;
 }
 
-uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf)
+const uint32_t *qemu_dmabuf_get_offset(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->offset;
+}
+
+const uint32_t *qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf)
 {
     assert(dmabuf != NULL);
 
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
@@ -221,9 +246,3 @@ void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted)
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
index d591159480..72a1405782 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -323,9 +323,9 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
     attrs[i++] = qemu_dmabuf_get_fourcc(dmabuf);
 
     attrs[i++] = EGL_DMA_BUF_PLANE0_FD_EXT;
-    attrs[i++] = qemu_dmabuf_get_fd(dmabuf);
+    attrs[i++] = qemu_dmabuf_get_fd(dmabuf)[0];
     attrs[i++] = EGL_DMA_BUF_PLANE0_PITCH_EXT;
-    attrs[i++] = qemu_dmabuf_get_stride(dmabuf);
+    attrs[i++] = qemu_dmabuf_get_stride(dmabuf)[0];
     attrs[i++] = EGL_DMA_BUF_PLANE0_OFFSET_EXT;
     attrs[i++] = 0;
 #ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
diff --git a/ui/spice-display.c b/ui/spice-display.c
index c794ae0649..82598fe9e8 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1075,10 +1075,10 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                      stride, fourcc, false);
             }
         } else {
-            stride = qemu_dmabuf_get_stride(dmabuf);
+            stride = qemu_dmabuf_get_stride(dmabuf)[0];
             fourcc = qemu_dmabuf_get_fourcc(dmabuf);
             y_0_top = qemu_dmabuf_get_y0_top(dmabuf);
-            fd = qemu_dmabuf_dup_fd(dmabuf);
+            qemu_dmabuf_dup_fd(dmabuf, &fd);
 
             trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, height);
             /* note: spice server will close the fd, so hand over a dup */
-- 
2.43.0


