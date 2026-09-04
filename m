Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5259EC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Th5-0004Fe-Rn; Fri, 04 Sep 2026 09:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Th3-0003yZ-IX
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Th1-00054R-Qu
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYNeeKF2BPMfRyEfJxs+uLie4EshM8A1v8S4Pu7JIYI=;
 b=aEcXHhractwm6XqQOrrICR6+4gHqkkLhbjTGd+F7iQrwaVjbkFoymfXRpUjMWk6YlgBJjL
 iI+vx93d01SbzTN1nRDluO8knJL1ZAXm3OFWhpYhAK1WwqZ0ueGguxGGexcx3ctmljhBBa
 iL8/QeoEQKpz2z+iP+ye6D3UX1cxqoM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-PXXIljyZPgq5_rZgP5vjhg-1; Fri,
 04 Sep 2026 09:10:52 -0400
X-MC-Unique: PXXIljyZPgq5_rZgP5vjhg-1
X-Mimecast-MFC-AGG-ID: PXXIljyZPgq5_rZgP5vjhg_1788527450
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA7E01954B37; Fri,  4 Sep 2026 13:10:50 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7E197DA; Fri,  4 Sep 2026 13:10:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:13 +0400
Subject: [PATCH v2 09/25] virtio-gpu: store the scanout DMABUF in
 virtio_gpu_scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-9-15b5ae6b0023@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6536;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OMFUNGS+YCS3LMpFoua2CDGBKOeqOyOR1f1IIsw8EUQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMvdpj5HABmKtq+Nv4Fn8VWs5FrmamQZ+8hK
 8TXUkO3+R+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDLwAKCRDa6OEJdZac
 5T2wD/9ngjf820E/V1+slyhv4MQuVh5QzXSpDe6sdE2HcJtMW74/KUfLLu0YIB0SBlm/p9/Dhgb
 nQ7Z67ErKBlFLjbl+0hOAY3Ljnu6xmH2wub3C/lMbiaFucJKE4mvig+kqJr930iT/l7DkCb2++2
 mwM2rPbHD1EAqdCb0dyWYkZmiTCaUzSH92AmEXc8ta+7pObnq7/PdiGtf9J+7IBzEWozeFY6Y2Z
 y6ktmDDYfRFHrJKQKFAuXumXRYQZuHT3wTQ8kFZkfEvV8kjIapENYduDCgIVioXPHPFCJTdnc5C
 z5x2H99ORqblOwkJWlrt6gofltbHlLLzgWeRsyK7w9KXSIDwRifDtzya/JND+hHJrgtFA8s+1bn
 iWXHHsKo16/MvewkEy/p7nDxH3Go9Cir1G5LSNl+3rQLGPMbk/eTy4IO17VPD68NV8aGhBNleo1
 lWoSb85TdRllnyk3FUXenRWFEQBmqzFi/6Yv5yVLElNTZjuggXXIv97vwWhWW/cshq3QdjOWKnh
 nuZSnyK31od7HwFE9luZnbO5NBhT/skYDVN+0zeCxsgxrBJx6noibtXw1BukNzHdQdET9bGwcAL
 NdwwcUEtakVCQL41AaVrs7DS57cyfexhz/F3CZpmaU3dK4Y++DRq06lOgLKlGwbXmJRYl+ebdO7
 hPIfGbiHuRn2aSw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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


