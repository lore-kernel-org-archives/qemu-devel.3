Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A0CC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ZzL-0003Kg-Ak; Thu, 10 Sep 2026 04:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4ZzJ-0003KH-OZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4ZzH-0004u5-Vj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eKUMoZq5XV11is/tjts9lB3sVWqkFifCCJ5vtFi2hw=;
 b=P/La/y/T1NBdseHOrRi55nh0woEHrIxrq6k9ZRrPoNJWsqyJsZeE/46K35lDEttyab7iFD
 AyeeSurSOhW6JRPp5dpt9/g3yMMxqmx4DqUzURlG2+67ByC5i9wZXvwIMZcWoHXiFS7igh
 7h8kw8rSzBiUE0thQqbHb0Uv/fs65Pc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-qV7JrOvpN56Wp48LPNEvKA-1; Thu,
 10 Sep 2026 04:18:25 -0400
X-MC-Unique: qV7JrOvpN56Wp48LPNEvKA-1
X-Mimecast-MFC-AGG-ID: qV7JrOvpN56Wp48LPNEvKA_1789028304
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57EBF180049D; Thu, 10 Sep 2026 08:18:24 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82977195608B; Thu, 10 Sep 2026 08:18:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:37 +0400
Subject: [PATCH v4 09/24] virtio-gpu: store the scanout DMABUF in
 virtio_gpu_scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-9-7d623714bd71@redhat.com>
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeowLROBw+D7grh0rPWPR5kjfTERv6HLUOIr
 9NqrwBQRn+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5S79D/9stlc/6c4gyYm7kcrkVTHAIdwCo4PUpGiP2gvsegvzr+8b8LWbLtPm9C5pqQ2D37k0i7O
 yAtW32OF5qlVk5kPcckuwyaVw+BQUoU+bZOiZ7h1fpyf7OaDSD+/mHzVqHO2sov3DFaCZZLLeMl
 gX6daOcv/FGMV7Y1S+Zs0WVuZE6p8z6MaHSEuBlxTJ8YA689b8gsvw94wqGsGBvB1SCUEKdfBJi
 2JVYuO5+Wcvf/BVfsUMg+JgCciX+vOmWteZyusu/fEvXYiPB9XD/b17GXObNcoveNpIEqQeOXF+
 isS4OGmpGaoqCXw18bOLjRu5Gdb3/BbHn5CjFNuyHhqBsT8uvLiPj4gnOA8x6fjA2BrEDfCD8PZ
 wbbzCchTUJwVgriAeZ4vudlMqbnSG9lCgKM9iQZg8eoSRFQdQW2PN18Vt+IeSATQCvCJSwjMdq2
 Ar53Cai221ZJZad1e9WRLGIp9W38TuPSnjq7Oj4ybx51nMPufKknRKlO9d4W6Kiw1I1H5HxBBtm
 Bc/lhN78r0j5EQh7A1+VJa8vkj2ULDd7U68qrkvPzfr7Qe7ZR0iwa8wTzz6IEgJbOW4lLh4OeKy
 y8nRoCYkhLoHjjMxEn/25881BKjSretSoaMsX62dGx+ajyE1v/0GiAREnMU1U4076ZAKh0KhjUF
 Vks7DK+Whd2A7uw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


