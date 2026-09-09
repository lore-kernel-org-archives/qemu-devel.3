Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BE5C79FB9
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G64-00032J-Av; Wed, 09 Sep 2026 07:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G62-0002sx-Av
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G60-0005G3-Fc
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eKUMoZq5XV11is/tjts9lB3sVWqkFifCCJ5vtFi2hw=;
 b=bPKmKHZIdGRCo/o0oypI9whxcef4zper/k+OVfeWs721fEjNS4/s1KLt1Iy+H6A6uoCfXZ
 dH0zGJ4iY43TRr/VPNT3yFrLdGF4gQWX4FVnsftcMubXOYXb31eVZxxaF+CjFHb4CZZaCr
 SPV1FDKIfWNbj3CXxzACSon2Khu2TQI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-w26csPBjNGOyF4dYTjsrgQ-1; Wed,
 09 Sep 2026 07:04:00 -0400
X-MC-Unique: w26csPBjNGOyF4dYTjsrgQ-1
X-Mimecast-MFC-AGG-ID: w26csPBjNGOyF4dYTjsrgQ_1788951839
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 592B9195419E; Wed,  9 Sep 2026 11:03:59 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AB7430001BB; Wed,  9 Sep 2026 11:03:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:14 +0400
Subject: [PATCH v3 09/24] virtio-gpu: store the scanout DMABUF in
 virtio_gpu_scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-9-99266590e79d@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6595;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uctf6lHwlbTWsPKln7Zc5X4gjngr0Ppzs4eUPV26194=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzyjC1UokPdMLeJMN9Irkaoy2vNAAbeYcz+3
 IAsLdevE9aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88gAKCRDa6OEJdZac
 5XXnD/sHgvjuBiulGKebxu7E/8qycFTgr5oZ/spzoVPWG7u7AzT8vGRl12KPc6wRVj0VSOzODoP
 fId+WC+8ENkU3HvuITt9s+jOoQFka+3gw188oFhjXmrcfHHpi/H04EwouscdQ4I7viqaH3bzTdC
 yUnFF6jz3mFijFPSA/fXxcfquj2cDVXPKmNgaC78LuS3IGYsnUlw4kNtsZaYTSURdNssgd38vlr
 8fQZQkHkKZqrq07YlhvSrHlU1+fE6lID33gJw0W4Mm158+v+G7pa7cC7MEXK/35nCQT3usW6Rr+
 ymalfPx7ziK6gzq0GGCxXdeM5bUBJ0Bzl340yY5gK+HEbM61HnQlYebP7MlsCwZGuUZnYKgn9lu
 PxhFcC7Y+qKSH34sxD3bnDzRj64aXw9CQQi7sc6mgjxHanD3kMbSj323hSAlLRiwZ6Iclh5cA10
 ttSqzOWHJcnGrIzU/N61azE4ZWXTLUiMtnorJm/2zbUJ/SnkdCXJ/yGK8t5OrP8eS2d/iI4mAZJ
 AM8LRHo0TycmdOcaVPjAIOojnJtJ2Tuc/lfF6vo5W6azrFO3NvVsE4acpcwi4gHi3jDG7qddQ8s
 nJqnseDfQMVtkS0vpgdSL2vJFWhixKkrT9JOYQPM4p/myLGG34ypAP/vRFoZoAdcKfRCjQnG45o
 waWhb2ijsBe7zuA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

VirtIOGPU tracks presented dmabufs both through a per-scanout primary
pointer and a device-wide list of VGPUDMABuf wrappers. Only the current
DMA-BUF for a scanout can ever be presented, so the list and the wrapper
struct are redundant bookkeeping.

Store the QemuDmaBuf directly in virtio_gpu_scanout and drop VGPUDMABuf
and the device-wide list. The wrapper only carried the buffer and its
scanout id; the id is now implicit in the owning scanout.

No functional change intended.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-udmabuf.c | 68 +++++++++++++++--------------------------
 include/hw/virtio/virtio-gpu.h  | 12 +-------
 2 files changed, 25 insertions(+), 55 deletions(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index fc63f2c4ec21..a38afb24c71f 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -160,30 +160,19 @@ bool virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     return true;
 }
 
-static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
-{
-    struct virtio_gpu_scanout *scanout;
-
-    scanout = &g->parent_obj.scanout[dmabuf->scanout_id];
-    qemu_console_gl_release_dmabuf(scanout->con, dmabuf->buf);
-    g_clear_pointer(&dmabuf->buf, qemu_dmabuf_free);
-    QTAILQ_REMOVE(&g->dmabuf.bufs, dmabuf, next);
-    g_free(dmabuf);
-}
-
 void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *res)
 {
     int max_outputs = g->parent_obj.conf.max_outputs;
     int i;
 
     for (i = 0; i < max_outputs; i++) {
-        VGPUDMABuf *dmabuf = g->dmabuf.primary[i];
+        struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[i];
 
-        if (dmabuf &&
-            qemu_dmabuf_get_num_planes(dmabuf->buf) > 0 &&
-            qemu_dmabuf_get_fds(dmabuf->buf, NULL)[0] == res->dmabuf_fd &&
+        if (scanout->dmabuf &&
+            qemu_dmabuf_get_num_planes(scanout->dmabuf) > 0 &&
+            qemu_dmabuf_get_fds(scanout->dmabuf, NULL)[0] == res->dmabuf_fd &&
             res->dmabuf_fd != -1) {
-            qemu_dmabuf_close(dmabuf->buf);
+            qemu_dmabuf_close(scanout->dmabuf);
             res->dmabuf_fd = -1;
             res->share_handle = SHAREABLE_NONE;
         }
@@ -192,31 +181,23 @@ void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *re
     virtio_gpu_destroy_udmabuf(res);
 }
 
-static VGPUDMABuf
-*virtio_gpu_create_dmabuf(VirtIOGPU *g,
-                          uint32_t scanout_id,
-                          struct virtio_gpu_simple_resource *res,
-                          struct virtio_gpu_framebuffer *fb,
-                          struct virtio_gpu_rect *r)
+static QemuDmaBuf *
+virtio_gpu_create_dmabuf(struct virtio_gpu_simple_resource *res,
+                         struct virtio_gpu_framebuffer *fb,
+                         struct virtio_gpu_rect *r)
 {
-    VGPUDMABuf *dmabuf;
     uint32_t offset = 0;
 
     if (res->dmabuf_fd < 0) {
         return NULL;
     }
 
-    dmabuf = g_new0(VGPUDMABuf, 1);
-    dmabuf->buf = qemu_dmabuf_new(r->width, r->height,
-                                  &offset, &fb->stride,
-                                  r->x, r->y, fb->width, fb->height,
-                                  qemu_pixman_to_drm_format(fb->format),
-                                  DRM_FORMAT_MOD_INVALID, &res->dmabuf_fd,
-                                  1, true, false);
-    dmabuf->scanout_id = scanout_id;
-    QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
-
-    return dmabuf;
+    return qemu_dmabuf_new(r->width, r->height,
+                           &offset, &fb->stride,
+                           r->x, r->y, fb->width, fb->height,
+                           qemu_pixman_to_drm_format(fb->format),
+                           DRM_FORMAT_MOD_INVALID, &res->dmabuf_fd,
+                           1, true, false);
 }
 
 int virtio_gpu_update_dmabuf(VirtIOGPU *g,
@@ -226,26 +207,25 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
                              struct virtio_gpu_rect *r)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
-    VGPUDMABuf *new_primary, *old_primary = NULL;
+    QemuDmaBuf *new_primary, *old_primary;
     uint32_t width, height;
 
-    new_primary = virtio_gpu_create_dmabuf(g, scanout_id, res, fb, r);
+    new_primary = virtio_gpu_create_dmabuf(res, fb, r);
     if (!new_primary) {
         return -EINVAL;
     }
 
-    if (g->dmabuf.primary[scanout_id]) {
-        old_primary = g->dmabuf.primary[scanout_id];
-    }
+    old_primary = scanout->dmabuf;
 
-    width = qemu_dmabuf_get_width(new_primary->buf);
-    height = qemu_dmabuf_get_height(new_primary->buf);
-    g->dmabuf.primary[scanout_id] = new_primary;
+    width = qemu_dmabuf_get_width(new_primary);
+    height = qemu_dmabuf_get_height(new_primary);
+    scanout->dmabuf = new_primary;
     qemu_console_resize(scanout->con, width, height);
-    qemu_console_gl_scanout_dmabuf(scanout->con, new_primary->buf);
+    qemu_console_gl_scanout_dmabuf(scanout->con, new_primary);
 
     if (old_primary) {
-        virtio_gpu_free_dmabuf(g, old_primary);
+        qemu_console_gl_release_dmabuf(scanout->con, old_primary);
+        qemu_dmabuf_free(old_primary);
     }
 
     return 0;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 8c0df60b3b7e..ee5f6f2f2375 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -85,6 +85,7 @@ struct virtio_gpu_framebuffer {
 struct virtio_gpu_scanout {
     QemuConsole *con;
     DisplaySurface *ds;
+    QemuDmaBuf *dmabuf;
     uint32_t width, height;
     int x, y;
     int invalidate;
@@ -189,12 +190,6 @@ struct VirtIOGPUBaseClass {
     DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1280), \
     DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
 
-typedef struct VGPUDMABuf {
-    QemuDmaBuf *buf;
-    uint32_t scanout_id;
-    QTAILQ_ENTRY(VGPUDMABuf) next;
-} VGPUDMABuf;
-
 struct VirtIOGPU {
     VirtIOGPUBase parent_obj;
 
@@ -226,11 +221,6 @@ struct VirtIOGPU {
         uint32_t bytes_3d;
     } stats;
 
-    struct {
-        QTAILQ_HEAD(, VGPUDMABuf) bufs;
-        VGPUDMABuf *primary[VIRTIO_GPU_MAX_SCANOUTS];
-    } dmabuf;
-
     GArray *capset_ids;
 };
 

-- 
2.55.0.543.g5ebe2ebe4ea8


