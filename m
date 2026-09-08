Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B820C79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3p5D-00022e-9w; Tue, 08 Sep 2026 02:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p5A-00021n-HW; Tue, 08 Sep 2026 02:13:24 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p57-0000ji-Rp; Tue, 08 Sep 2026 02:13:24 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886CG96048190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:12:28 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ftqi5/exqak3alZXQilj9pL5HUmF/GvgeL67yI9LGWc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1788847949; v=1;
 b=NdlSy4IM4nxe1AdOAWLRN6M/Sq1FQaijSuumU4RgZxXubjmyzCQruM38QERnAwNK
 PwvgxJ7zLF2K00oZ1W4hb5UE9YeXJjmU2P20cI2zGNl61K8R0tiRmESt1laSm2mO
 iOCiT3iuO7P7IhjfAZLsCXAo9UMY6Ut8dG6kH/uHUsnn/kZCEJ3wtg+94OuP0r8j
 pzL8i2dlt1cLQ+dqzpv6ie98BN37nuZHImKiKyh9Sy3zSi2OWRRJaB4nX+wtW+16
 UfUx/yP6ZbdAu8iBeg57zDifModr3HS0r2PNSO4GdxF4AxeqNOOF3On5FxXxS8cy
 fhEIiOx1lK85gu1WNOYX9A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 08 Sep 2026 15:11:26 +0900
Subject: [PATCH v3 9/9] hw/display/virtio-gpu: Handle virtqueue reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gpu-v3-9-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2642;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=cOjBW9QwEYk/FNbZy1ZAFXuqOxeSrdgahD/9GOGbRaM=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b85R6uG71f3fx3wPeF3PXvTT6HVsYuVtcTl0n9fuHn2
 5o1kSYNHaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABPZ7cPIsKBp3n/Lw2+39EXp
 ZYmsrC4vZGqeov9v+V39bYtCZcUKfzP84Zs8KcpJsGh7QcH0yvrXEXJpSUw7py74vV84/bhi28N
 ljAA=
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

Implement the missing logic to reset the state specific to virtio-gpu
associated with the command queue for virtqueue reset.

Fixes: 69e1c14aa222 ("virtio: core: vq reset feature negotation support")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index dd6c09d1ddcf..a4b722d7f139 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1750,6 +1750,31 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
     virtio_gpu_base_device_unrealize(qdev);
 }
 
+static void virtio_gpu_queue_reset(VirtIODevice *vdev, uint32_t queue_index)
+{
+    VirtIOGPU *g = VIRTIO_GPU(vdev);
+    struct virtio_gpu_ctrl_command *cmd;
+
+    if (queue_index) {
+        return;
+    }
+
+    while (!QTAILQ_EMPTY(&g->cmdq)) {
+        cmd = QTAILQ_FIRST(&g->cmdq);
+        QTAILQ_REMOVE(&g->cmdq, cmd, next);
+        virtqueue_detach_element(cmd->vq, &cmd->elem, 0);
+        g_free(cmd);
+    }
+
+    while (!QTAILQ_EMPTY(&g->fenceq)) {
+        cmd = QTAILQ_FIRST(&g->fenceq);
+        QTAILQ_REMOVE(&g->fenceq, cmd, next);
+        virtqueue_detach_element(cmd->vq, &cmd->elem, 0);
+        g->inflight--;
+        g_free(cmd);
+    }
+}
+
 static void virtio_gpu_reset_bh(VirtIOGPU *g)
 {
     VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
@@ -1816,23 +1841,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
 
 void virtio_gpu_complete_reset(VirtIOGPU *g)
 {
-    struct virtio_gpu_ctrl_command *cmd;
-
-    while (!QTAILQ_EMPTY(&g->cmdq)) {
-        cmd = QTAILQ_FIRST(&g->cmdq);
-        QTAILQ_REMOVE(&g->cmdq, cmd, next);
-        virtqueue_detach_element(cmd->vq, &cmd->elem, 0);
-        g_free(cmd);
-    }
-
-    while (!QTAILQ_EMPTY(&g->fenceq)) {
-        cmd = QTAILQ_FIRST(&g->fenceq);
-        QTAILQ_REMOVE(&g->fenceq, cmd, next);
-        virtqueue_detach_element(cmd->vq, &cmd->elem, 0);
-        g->inflight--;
-        g_free(cmd);
-    }
-
+    virtio_gpu_queue_reset(VIRTIO_DEVICE(g), 0);
     virtio_gpu_base_reset(VIRTIO_GPU_BASE(g));
 }
 
@@ -1940,6 +1949,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, const void *data)
     vdc->realize = virtio_gpu_device_realize;
     vdc->unrealize = virtio_gpu_device_unrealize;
     vdc->reset = virtio_gpu_reset;
+    vdc->queue_reset = virtio_gpu_queue_reset;
     vdc->get_config = virtio_gpu_get_config;
     vdc->set_config = virtio_gpu_set_config;
 

-- 
2.55.0


