Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02406C531F9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnWbq-0002QS-8l; Sat, 25 Jul 2026 03:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnWbp-0002QJ-Cv
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 03:15:45 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnWbn-0002c2-LI
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 03:15:45 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66P7FXhs073576
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 25 Jul 2026 16:15:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4aLEExcc6yK+XaErgg6fexWkIdPrOKquOnl9wE+gv1w=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784963738; v=1;
 b=jUBjOzamIHZn9mfIEOM49uIFeBSNhlsG5Tm3L/13mfxeDe2gocwjSm7II9zQzGTw
 HKUbDCVUlG07eDsCPKpsUrhxJoD7/iKxVv5gpnHsZKwXTLsygMqaKMkj7MI0Ma5R
 I4FoabsECVG9hU3/3fAq8VIGMq6VJmkWqTyNzBfuP06GAqI0NU4gqYlBsgtEDleB
 8rs0RbW9d6v3+Zjlx5R73yvxmLZXCrl1LJi2CGoCBR2i/AZuPrJru+9LEPWJp/Hf
 ZgabSvdXcjXK2wwnoxGyZZOGVYBUVw/t4DOSIZO7SxzDwNqkQiZgESFYCT6+b+Q5
 jRIzFdqIpMHCq5YUiibHGQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 25 Jul 2026 16:15:32 +0900
Subject: [PATCH] hw/display/virtio-gpu: Block Rutabaga migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-rutabaga-v1-1-4832b56e679d@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDVpGxRXEYvBYCyQFpE0vbti+
 SX/ex4cWSYHdeLB0sWOtzVCpQn0M64TCR6iQUtdSKNzYc8DO5xQyErikCmjS2Ug5rulke/vqml
 /u7NbqD/ePYTwAGBIb7RsAAAA
X-Change-ID: 20260725-rutabaga-090ad4172817
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2277;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=UFlRF7PzOF1AQspXs/Q2Y6Ym9dmaDSrRI3UWfK5XTFQ=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1ZK0sz3uYErI/fbOmeLTLf/8PFLsVpJ8JH8nduffdtYf
 OzhpbuWHaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABOxXsTw3/W34U4zPo+G63Pv
 xM68nLd8ZoOBau2GWqnf9r7MSi9zrjH8Tzo/Nzn62W52Nd9rDd1ijzNtb8xWy5vZvv6vHcP8Qxd
 /cQEA
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

The migration stream encoding is not defined for Rutabaga yet.

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-rutabaga.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 4d7d7b245929..ad5cfabf4ee9 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -9,6 +9,7 @@
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "migration/blocker.h"
 
 #include <glib/gmem.h>
 #include <rutabaga_gfx/rutabaga_gfx_ffi.h>
@@ -1078,6 +1079,7 @@ static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
 static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
 {
+    ERRP_GUARD();
     uint32_t num_capsets;
     VirtIOGPUBase *bdev = VIRTIO_GPU_BASE(qdev);
     VirtIOGPU *gpudev = VIRTIO_GPU(qdev);
@@ -1087,12 +1089,17 @@ static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
     return;
 #endif
 
-    if (!virtio_gpu_rutabaga_init(gpudev, errp)) {
+    error_setg(&bdev->migration_blocker, "rutabaga is not yet migratable");
+    if (migrate_add_blocker(&bdev->migration_blocker, errp) < 0) {
         return;
     }
 
+    if (!virtio_gpu_rutabaga_init(gpudev, errp)) {
+        goto fail;
+    }
+
     if (!virtio_gpu_rutabaga_get_num_capsets(gpudev, &num_capsets, errp)) {
-        return;
+        goto fail;
     }
 
     bdev->conf.flags |= (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED);
@@ -1101,6 +1108,12 @@ static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
 
     bdev->virtio_config.num_capsets = num_capsets;
     virtio_gpu_device_realize(qdev, errp);
+    if (!*errp) {
+        return;
+    }
+
+fail:
+    migrate_del_blocker(&bdev->migration_blocker);
 }
 
 static const Property virtio_gpu_rutabaga_properties[] = {

---
base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
change-id: 20260725-rutabaga-090ad4172817

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


