Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28004C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3p5R-0002Cl-IP; Tue, 08 Sep 2026 02:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p5P-0002C2-VD; Tue, 08 Sep 2026 02:13:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p5M-0000lB-Ly; Tue, 08 Sep 2026 02:13:39 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886CG92048190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:12:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=mjWKhr72OVctLNAq2RCmCS97RB7rCSbZXd64lMjjfHU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1788847947; v=1;
 b=PwZLYUn2xiHkvCCVtbHc80K42+VqWJyNb5nCHEBFZI5dZ/CQgrwff9BzMvEG6elm
 vhsBgYtFHSix1kcImfLUROR5bVMQC16haTExpzduNdy0XeOSreZBVj2ohtIGmLXC
 U9mzXWlYsUso0QMAA2F5NONCCABHuDSsuPRxFtl/JTRAkDsjvflKcAjcmR2JaDFq
 bp2Cz2fpE5mV5wh50htZcKJZtAs7OomPaVw5v2wsL+LFsRA/ZPQ39FJy0KHdihmV
 LH9XCuB6SuwSOf7hXcDLTJo4ig9/xAkhRoLb4pqaFAb8X7XuCheT3Alq2HhEHUn5
 fpa51L80KChtILqZ8WcVdQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 08 Sep 2026 15:11:22 +0900
Subject: [PATCH v3 5/9] virtio-gpu: Do not wait for the main thread during
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gpu-v3-5-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
References: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 David Hildenbrand <david@kernel.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-block@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=14828;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=k2FUWEP1QZ4HEbg9LB+25hwcqZ4icriYfnm72Xw0LRs=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b85a7sG6aFT9DxDShc2SxsLnsm6Kvsyud91Qt0JJMvm
 Kv0Ox/pKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmEh+NiPD3RfpVudeLL7hwLKy
 wfH+2+zjma4TNuntPvKtr2TRk8ypnAz/K9U6OO18t/QJH1fkfdDkPGGJZKT0O4aaQFvuMyvfLA/
 lBAA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

virtio-gpu waits for the main thread to destroy resources and replace
surfaces, but it occasionally results in deadlock, so remove the code
to wait.

In particular, when running a test case[1] the main thread may wait for
the vCPUs to pause during shut down while a vCPU may be concurrently
resetting virtio-gpu.

That split also leaves a window after reset_bh has destroyed resources
and before virtio_gpu_reset() drains the queues. Other virtio-gpu BHs
can run in that window, so commands may be observed on the wrong side of
the reset boundary:

1.  vCPU thread B: Take the BQL
2.  vCPU thread B: Queue a command
3.  vCPU thread B: Drop the BQL
4.  vCPU thread A: Take the BQL
5.  vCPU thread A: Enter virtio_gpu_reset()
6.  vCPU thread A: Schedule reset_bh
7.  vCPU thread A: Wait in qemu_cond_wait_bql(&g->reset_cond)
8.  vCPU thread A: Drop the BQL while waiting
9.  Main thread:   Take the BQL
10. Main thread:   Run virtio_gpu_reset_bh()
11. Main thread:   Destroy resources
12. Main thread:   Signal g->reset_cond
13. Main thread:   Process the queued command
14. Main thread:   Drop the BQL
15. vCPU thread B: Take the BQL
16. vCPU thread B: Queue another command
17. vCPU thread B: Drop the BQL
18. vCPU thread A: Take the BQL
19. vCPU thread A: Leave qemu_cond_wait_bql(&g->reset_cond)
20. vCPU thread A: Discard the second command in the virtqueue

The first command is processed as if it happened after reset, while the
second command is discarded as if it happened before reset.

vCPU actually does not need to perform resource destruction and surface
replacement synchronously, but it only needs to ensure correct ordering
among virtio-gpu operations and migration stream consistency.
virtio-gpu-gl already exploits this fact to ensure that virglrenderer is
reset on the main thread; instead of synchronously resetting
virglrenderer when the device is being reset, it resets virglrenderer
just before processing the first command after the device reset arrives.

Take advantage of this fact by removing synchronization between the main
thread and the resetting vCPU thread. This also fixes the race condition
described above by avoiding unlocking the BQL inside
qemu_cond_wait_bql(&g->reset_cond).

The ordering with the control and cursor queues will be kept enforced by
running the reset operation before processing their commands as
virtio-gpu-gl does.

Migration requires its own treatment and virtio-gpu-gl does not provide
one since it doesn't support migration. For migration consistency,
synchronously clear the device-internal scanout state and also omit
resources from the migration stream if reset is pending. Note that the
cleared scanout will be asynchronously reflected to the UI.

Rutabaga also needs special care. Since it may write guest memory for
the cross-domain feature, we delay reset completion until Rutabaga has
been reset. This makes it incompatible with virtio-mmio-bus.

[1] https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.bennee@linaro.org/

Fixes: a41e2d97f92b ("virtio-gpu: reset gfx resources in main thread")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/virtio/virtio-gpu.h   |   5 +-
 hw/display/virtio-gpu-rutabaga.c |   2 +
 hw/display/virtio-gpu.c          | 133 ++++++++++++++++++++++++---------------
 system/qdev-monitor.c            |   2 -
 4 files changed, 88 insertions(+), 54 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index acae2b4778b3..9404e488208a 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -195,9 +195,7 @@ struct VirtIOGPU {
 
     QEMUBH *ctrl_bh;
     QEMUBH *cursor_bh;
-    QEMUBH *reset_bh;
-    QemuCond reset_cond;
-    bool reset_finished;
+    bool reset_pending;
 
     QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
     QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
@@ -362,6 +360,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
 void virtio_gpu_process_cmdq(VirtIOGPU *g);
 void virtio_gpu_device_realize(DeviceState *qdev, Error **errp);
 void virtio_gpu_reset(VirtIODevice *vdev);
+void virtio_gpu_complete_reset(VirtIOGPU *g);
 void virtio_gpu_simple_process_cmd(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd);
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 7bdeeeb5c023..f28daa844328 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1087,6 +1087,8 @@ static void virtio_gpu_rutabaga_reset(VirtIOGPU *g)
         virtio_error(VIRTIO_DEVICE(g), "%s", error_get_pretty(local_err));
         error_free(local_err);
     }
+
+    virtio_gpu_complete_reset(g);
 }
 
 static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b57f07bd26c8..d520f69e6453 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-mmio.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/memfd.h"
@@ -39,7 +40,7 @@ static struct virtio_gpu_simple_resource *
 virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
                                const char *caller, uint32_t *error);
 
-static void virtio_gpu_reset_bh(void *opaque);
+static void virtio_gpu_reset_bh(VirtIOGPU *g);
 
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
@@ -380,6 +381,14 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
+static void virtio_gpu_clear_scanout(struct virtio_gpu_scanout *scanout)
+{
+    scanout->resource_id = 0;
+    scanout->ds = NULL;
+    scanout->width = 0;
+    scanout->height = 0;
+}
+
 void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
@@ -395,10 +404,7 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
     }
 
     qemu_console_set_surface(scanout->con, NULL);
-    scanout->resource_id = 0;
-    scanout->ds = NULL;
-    scanout->width = 0;
-    scanout->height = 0;
+    virtio_gpu_clear_scanout(scanout);
 }
 
 static void virtio_gpu_resource_destroy(VirtIOGPU *g,
@@ -1267,6 +1273,7 @@ static void virtio_gpu_ctrl_bh(void *opaque)
     VirtIOGPU *g = opaque;
     VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
 
+    virtio_gpu_reset_bh(g);
     vgc->handle_ctrl(VIRTIO_DEVICE(g), g->ctrl_vq);
 }
 
@@ -1305,6 +1312,8 @@ static void virtio_gpu_handle_cursor(VirtIODevice *vdev, VirtQueue *vq)
 static void virtio_gpu_cursor_bh(void *opaque)
 {
     VirtIOGPU *g = opaque;
+
+    virtio_gpu_reset_bh(g);
     virtio_gpu_handle_cursor(&g->parent_obj.parent_obj, g->cursor_vq);
 }
 
@@ -1371,21 +1380,23 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     /* in 2d mode we should never find unprocessed commands here */
     assert(QTAILQ_EMPTY(&g->cmdq));
 
-    QTAILQ_FOREACH(res, &g->reslist, next) {
-        if (!res->image) {
-            continue;
-        }
-        qemu_put_be32(f, res->resource_id);
-        qemu_put_be32(f, res->width);
-        qemu_put_be32(f, res->height);
-        qemu_put_be32(f, res->format);
-        qemu_put_be32(f, res->iov_cnt);
-        for (i = 0; i < res->iov_cnt; i++) {
-            qemu_put_be64(f, res->addrs[i]);
-            qemu_put_be32(f, res->iov[i].iov_len);
+    if (!g->reset_pending) {
+        QTAILQ_FOREACH(res, &g->reslist, next) {
+            if (!res->image) {
+                continue;
+            }
+            qemu_put_be32(f, res->resource_id);
+            qemu_put_be32(f, res->width);
+            qemu_put_be32(f, res->height);
+            qemu_put_be32(f, res->format);
+            qemu_put_be32(f, res->iov_cnt);
+            for (i = 0; i < res->iov_cnt; i++) {
+                qemu_put_be64(f, res->addrs[i]);
+                qemu_put_be32(f, res->iov[i].iov_len);
+            }
+            qemu_put_buffer(f, (void *)pixman_image_get_data(res->image),
+                            pixman_image_get_stride(res->image) * res->height);
         }
-        qemu_put_buffer(f, (void *)pixman_image_get_data(res->image),
-                        pixman_image_get_stride(res->image) * res->height);
     }
     qemu_put_be32(f, 0); /* end of list */
 
@@ -1522,17 +1533,19 @@ static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
     /* in 2d mode we should never find unprocessed commands here */
     assert(QTAILQ_EMPTY(&g->cmdq));
 
-    QTAILQ_FOREACH(res, &g->reslist, next) {
-        if (res->image) {
-            continue;
-        }
-        assert(!res->image);
-        qemu_put_be32(f, res->resource_id);
-        qemu_put_be32(f, res->blob_size);
-        qemu_put_be32(f, res->iov_cnt);
-        for (i = 0; i < res->iov_cnt; i++) {
-            qemu_put_be64(f, res->addrs[i]);
-            qemu_put_be32(f, res->iov[i].iov_len);
+    if (!g->reset_pending) {
+        QTAILQ_FOREACH(res, &g->reslist, next) {
+            if (res->image) {
+                continue;
+            }
+            assert(!res->image);
+            qemu_put_be32(f, res->resource_id);
+            qemu_put_be32(f, res->blob_size);
+            qemu_put_be32(f, res->iov_cnt);
+            for (i = 0; i < res->iov_cnt; i++) {
+                qemu_put_be64(f, res->addrs[i]);
+                qemu_put_be32(f, res->iov[i].iov_len);
+            }
         }
     }
     qemu_put_be32(f, 0); /* end of list */
@@ -1654,8 +1667,16 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
 
 void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 {
+    BusState *qbus = qdev_get_parent_bus(qdev);
     VirtIODevice *vdev = VIRTIO_DEVICE(qdev);
     VirtIOGPU *g = VIRTIO_GPU(qdev);
+    VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
+
+    /* virtio-mmio-bus does not support asynchronous reset completion. */
+    if (vgc->reset && object_dynamic_cast(OBJECT(qbus), TYPE_VIRTIO_MMIO_BUS)) {
+        error_setg(errp, "MMIO bus is not supported");
+        return;
+    }
 
     if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
         if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
@@ -1716,8 +1737,6 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     g->cursor_vq = virtio_get_queue(vdev, 1);
     g->ctrl_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
     g->cursor_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_cursor_bh, g);
-    g->reset_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_reset_bh, g);
-    qemu_cond_init(&g->reset_cond);
     QTAILQ_INIT(&g->reslist);
     QTAILQ_INIT(&g->cmdq);
     QTAILQ_INIT(&g->fenceq);
@@ -1729,20 +1748,25 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
 
     g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
     g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
-    g_clear_pointer(&g->reset_bh, qemu_bh_delete);
-    qemu_cond_destroy(&g->reset_cond);
     virtio_gpu_base_device_unrealize(qdev);
 }
 
-static void virtio_gpu_reset_bh(void *opaque)
+static void virtio_gpu_reset_bh(VirtIOGPU *g)
 {
-    VirtIOGPU *g = VIRTIO_GPU(opaque);
     VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
     struct virtio_gpu_simple_resource *res, *tmp;
     uint32_t resource_id;
     Error *local_err = NULL;
     int i = 0;
 
+    if (!g->reset_pending) {
+        return;
+    }
+
+    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
+    }
+
     QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
         resource_id = res->resource_id;
         vgc->resource_destroy(g, res, &local_err);
@@ -1757,32 +1781,43 @@ static void virtio_gpu_reset_bh(void *opaque)
         }
     }
 
-    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-        qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
-    }
-
     if (vgc->reset) {
         vgc->reset(g);
     }
 
-    g->reset_finished = true;
-    qemu_cond_signal(&g->reset_cond);
+    g->reset_pending = false;
 }
 
 void virtio_gpu_reset(VirtIODevice *vdev)
 {
     VirtIOGPU *g = VIRTIO_GPU(vdev);
-    struct virtio_gpu_ctrl_command *cmd;
+    VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
+    int i;
+
+    g->reset_pending = true;
 
     if (qemu_in_vcpu_thread()) {
-        g->reset_finished = false;
-        qemu_bh_schedule(g->reset_bh);
-        while (!g->reset_finished) {
-            qemu_cond_wait_bql(&g->reset_cond);
+        /*
+         * Clear scanouts synchronously so that they are properly migrated
+         * after resetting and before reaching virtio_gpu_reset_bh().
+         */
+        for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+            virtio_gpu_clear_scanout(&g->parent_obj.scanout[i]);
         }
+
+        qemu_bh_schedule(g->ctrl_bh);
     } else {
-        aio_bh_call(g->reset_bh);
+        virtio_gpu_reset_bh(g);
+    }
+
+    if (!vgc->reset) {
+        virtio_gpu_complete_reset(g);
     }
+}
+
+void virtio_gpu_complete_reset(VirtIOGPU *g)
+{
+    struct virtio_gpu_ctrl_command *cmd;
 
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd = QTAILQ_FIRST(&g->cmdq);
@@ -1799,7 +1834,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
         g_free(cmd);
     }
 
-    virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
+    virtio_gpu_base_reset(VIRTIO_GPU_BASE(g));
 }
 
 static void
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 00fed791cce1..19c89a5ad11c 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -94,8 +94,6 @@ static const QDevAlias qdev_alias_table[] = {
     { "virtio-gpu-pci", "virtio-gpu", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-gpu-gl-device", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-gpu-gl-pci", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_PCI },
-    { "virtio-gpu-rutabaga-device", "virtio-gpu-rutabaga",
-      QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-gpu-rutabaga-pci", "virtio-gpu-rutabaga", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-input-host-device", "virtio-input-host", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_VIRTIO_CCW },

-- 
2.55.0


