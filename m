Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB1AFED3CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGHBb-0002ZO-36; Fri, 24 Apr 2026 10:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGHBZ-0002Yx-Rm
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:07:13 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGHBU-0007Ob-Vg
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:07:13 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63OE6rPc008037
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Apr 2026 23:06:55 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=CI8Wwu42TZO2W6YwUFoTsN1IVWVdvPURG6kNvALL5RY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1777039615; v=1;
 b=wHjbxLHKjEfPiFEXXZJTHsVXbJ2bTrWviJVyXfnEX/zSwMSD+9+ahNR5P9tkn1Gx
 bt7WgOjIiELg1d6iDab8fhTw8uPebT/6xxTDTFY3jnE7AMf536YsgY/L/7sA3HgD
 eeUS/QhtUB3jdcA8FH3K8nOf+T71Sl7dSMcgfaYjYJNm9UuDkGHghWqIxWdt23s3
 VBnc+Rca/Ii+ZH0MkpJwfZxtysi/6CPWsS5drGF3BfwAJwyMWso76cirltn39XHa
 1XGoP0+6Hx2FT8zAQSzIod0wLK+CaSfYW3uFdbTep5+F7HBgvd60XJgHcisyZUZS
 71sME0mII+AfPFvlEppDoA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 24 Apr 2026 23:06:42 +0900
Subject: [PATCH v2 2/2] virtio-gpu: Do not wait for the main thread during
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-gpu-v2-2-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
References: <20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

virtio-gpu waits for the main thread to destroy resources and replace
surfaces, but it occasionally results in deadlock, so remove the code
to wait.

In particular, when running a test case[1] the main thread may wait for
the vCPUs to pause during shut down while a vCPU may be concurrently
resetting virtio-gpu.

vCPU actually does not need to perform resource destruction and surface
replacement synchronously, but it only needs to ensure correct ordering
among virtio-gpu operations. virtio-gpu-gl already exploits this fact to
ensure that virglrenderer is reset on the main thread; instead of
synchronously resetting virglrenderer when the device is being reset,
it resets virglrenderer just before processing the first command after
the device reset arrives.

Take advantage of this fact by removing synchronization between the main
thread and the resetting vCPU thread. The ordering with the control and
cursor queues is enforced by running the reset operation before
processing their commands as virtio-gpu-gl does.

[1] https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.bennee@linaro.org/

Fixes: a41e2d97f92b ("virtio-gpu: reset gfx resources in main thread")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/virtio/virtio-gpu.h |  4 +---
 hw/display/virtio-gpu.c        | 28 +++++++++++++---------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index f69fc1946273..48fb54aa4605 100644
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
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index d514b548efd9..4c053e9a2f75 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -40,7 +40,7 @@ virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
                                bool require_backing,
                                const char *caller, uint32_t *error);
 
-static void virtio_gpu_reset_bh(void *opaque);
+static void virtio_gpu_reset_bh(VirtIOGPU *g);
 
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
@@ -1138,6 +1138,7 @@ static void virtio_gpu_ctrl_bh(void *opaque)
     VirtIOGPU *g = opaque;
     VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
 
+    virtio_gpu_reset_bh(g);
     vgc->handle_ctrl(VIRTIO_DEVICE(g), g->ctrl_vq);
 }
 
@@ -1176,6 +1177,7 @@ static void virtio_gpu_handle_cursor(VirtIODevice *vdev, VirtQueue *vq)
 static void virtio_gpu_cursor_bh(void *opaque)
 {
     VirtIOGPU *g = opaque;
+    virtio_gpu_reset_bh(g);
     virtio_gpu_handle_cursor(&g->parent_obj.parent_obj, g->cursor_vq);
 }
 
@@ -1560,8 +1562,6 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     g->cursor_vq = virtio_get_queue(vdev, 1);
     g->ctrl_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
     g->cursor_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_cursor_bh, g);
-    g->reset_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_reset_bh, g);
-    qemu_cond_init(&g->reset_cond);
     QTAILQ_INIT(&g->reslist);
     QTAILQ_INIT(&g->cmdq);
     QTAILQ_INIT(&g->fenceq);
@@ -1573,14 +1573,11 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
 
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
     struct virtio_gpu_ctrl_command *cmd;
     struct virtio_gpu_simple_resource *res, *tmp;
@@ -1588,6 +1585,10 @@ static void virtio_gpu_reset_bh(void *opaque)
     Error *local_err = NULL;
     int i = 0;
 
+    if (!g->reset_pending) {
+        return;
+    }
+
     QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
         resource_id = res->resource_id;
         vgc->resource_destroy(g, res, &local_err);
@@ -1621,22 +1622,19 @@ static void virtio_gpu_reset_bh(void *opaque)
 
     virtio_gpu_base_reset(VIRTIO_GPU_BASE(g));
 
-    g->reset_finished = true;
-    qemu_cond_signal(&g->reset_cond);
+    g->reset_pending = false;
 }
 
 void virtio_gpu_reset(VirtIODevice *vdev)
 {
     VirtIOGPU *g = VIRTIO_GPU(vdev);
 
+    g->reset_pending = true;
+
     if (qemu_in_vcpu_thread()) {
-        g->reset_finished = false;
-        qemu_bh_schedule(g->reset_bh);
-        while (!g->reset_finished) {
-            qemu_cond_wait_bql(&g->reset_cond);
-        }
+        qemu_bh_schedule(g->ctrl_bh);
     } else {
-        aio_bh_call(g->reset_bh);
+        virtio_gpu_reset_bh(g);
     }
 }
 

-- 
2.53.0


