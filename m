Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A3DFED3CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGHBb-0002Ze-Ko; Fri, 24 Apr 2026 10:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGHBZ-0002Yo-BG
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:07:13 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGHBU-0007OZ-RW
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:07:13 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63OE6rPb008037
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Apr 2026 23:06:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=3PTC2WsTND6RCdsl4wWJ5P+BEs7aCKUgDSNSWQzTsg0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1777039614; v=1;
 b=iKjWpbs58fhJZtKgFUahjFl//B4Zjdu/HFXfrZeL0bKOArFo4/RDFjW3vTh7qUik
 zqyXqxLPysdbhXr90zViIWGqZXsR34UlOjX8y56xSW/BbX20ZyjKnq3sR+Mc7Cnn
 dQiOAd8Q9HguIQuzn4EuVunjR5nfpsgIzMK/fbsg/DY7P028hIyO9syWY7GYycvl
 C6lnbbA4eOPK+V3hftrw5aEC/TVbK8K0+83FHP7bSUC0sUNu1889V8zpPHezQ2c2
 lqpz7S1M4vHVCr9EuAbQyUV6AtEf1aLBjKKlDmopQiDa8QRMKibmm7Tw/Kd2rePB
 M5ojADkC/x3X1dtZYjJhNA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 24 Apr 2026 23:06:41 +0900
Subject: [PATCH v2 1/2] virtio-gpu: Run reset cleanup in the same BH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-gpu-v2-1-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
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

Commit a41e2d97f92b ("virtio-gpu: reset gfx resources in main thread")
made resource destruction run in the main thread, but left command and
fence queue cleanup in virtio_gpu_reset(). When reset is initiated from
a vCPU thread, virtio_gpu_reset() schedules reset_bh and then waits with
qemu_cond_wait_bql(), which releases the BQL while the BH is running.

That split leaves a window after reset_bh has destroyed resources and
before virtio_gpu_reset() drains cmdq/fenceq. Other virtio-gpu BHs can
run in that window, so commands may be observed on the wrong side of the
reset boundary:

1.  vCPU thread A: Enter virtio_gpu_reset()
2.  vCPU thread A: Schedule reset_bh
3.  vCPU thread A: Wait in qemu_cond_wait_bql(&g->reset_cond)
4.  vCPU thread A: Drop the BQL while waiting
5.  vCPU thread B: Take the BQL
6.  vCPU thread B: Queue a command
7.  vCPU thread B: Drop the BQL
8.  Main thread:   Take the BQL
9.  Main thread:   Run virtio_gpu_reset_bh()
10. Main thread:   Destroy resources
11. Main thread:   Signal g->reset_cond
12. Main thread:   Process the queued command
13. Main thread:   Drop the BQL
14. vCPU thread B: Take the BQL
15. vCPU thread B: Queue another command
16. vCPU thread B: Drop the BQL
17. vCPU thread A: Take the BQL
18. vCPU thread A: Leave qemu_cond_wait_bql(&g->reset_cond)
19. vCPU thread A: Delete the second command from cmdq

The first command is processed as if it happened after reset, while the
second command is discarded as if it happened before reset.

Move cmdq/fenceq cleanup and virtio_gpu_base_reset() into reset_bh so
all virtio-gpu reset state is updated in the same main-thread callback.
This keeps command processing from interleaving with a partially
completed reset.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b998ce8324d6..d514b548efd9 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1582,6 +1582,7 @@ static void virtio_gpu_reset_bh(void *opaque)
 {
     VirtIOGPU *g = VIRTIO_GPU(opaque);
     VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
+    struct virtio_gpu_ctrl_command *cmd;
     struct virtio_gpu_simple_resource *res, *tmp;
     uint32_t resource_id;
     Error *local_err = NULL;
@@ -1601,10 +1602,25 @@ static void virtio_gpu_reset_bh(void *opaque)
         }
     }
 
+    while (!QTAILQ_EMPTY(&g->cmdq)) {
+        cmd = QTAILQ_FIRST(&g->cmdq);
+        QTAILQ_REMOVE(&g->cmdq, cmd, next);
+        g_free(cmd);
+    }
+
+    while (!QTAILQ_EMPTY(&g->fenceq)) {
+        cmd = QTAILQ_FIRST(&g->fenceq);
+        QTAILQ_REMOVE(&g->fenceq, cmd, next);
+        g->inflight--;
+        g_free(cmd);
+    }
+
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
         dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
     }
 
+    virtio_gpu_base_reset(VIRTIO_GPU_BASE(g));
+
     g->reset_finished = true;
     qemu_cond_signal(&g->reset_cond);
 }
@@ -1612,7 +1628,6 @@ static void virtio_gpu_reset_bh(void *opaque)
 void virtio_gpu_reset(VirtIODevice *vdev)
 {
     VirtIOGPU *g = VIRTIO_GPU(vdev);
-    struct virtio_gpu_ctrl_command *cmd;
 
     if (qemu_in_vcpu_thread()) {
         g->reset_finished = false;
@@ -1623,21 +1638,6 @@ void virtio_gpu_reset(VirtIODevice *vdev)
     } else {
         aio_bh_call(g->reset_bh);
     }
-
-    while (!QTAILQ_EMPTY(&g->cmdq)) {
-        cmd = QTAILQ_FIRST(&g->cmdq);
-        QTAILQ_REMOVE(&g->cmdq, cmd, next);
-        g_free(cmd);
-    }
-
-    while (!QTAILQ_EMPTY(&g->fenceq)) {
-        cmd = QTAILQ_FIRST(&g->fenceq);
-        QTAILQ_REMOVE(&g->fenceq, cmd, next);
-        g->inflight--;
-        g_free(cmd);
-    }
-
-    virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
 }
 
 static void

-- 
2.53.0


