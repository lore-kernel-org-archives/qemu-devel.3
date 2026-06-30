Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B16C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 01:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weNAW-0000u3-V6; Mon, 29 Jun 2026 21:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1weNAS-0000tu-EW
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 21:21:40 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1weNAM-0007OR-QC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 21:21:39 -0400
X-UUID: 01212c32742211f1aa26b74ffac11d73-20260630
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:13b1aa37-ff7a-4759-a567-4f7233c5c9be, IP:15,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:40
X-CID-INFO: VERSION:1.3.12, REQID:13b1aa37-ff7a-4759-a567-4f7233c5c9be, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:40
X-CID-META: VersionHash:e7bac3a, CLOUDID:0b0032a8e339a78aa6512e5fa7714d9c,
 BulkI
 D:2606300921250HX4UFHC,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|101|102|
 123|127|136|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:n
 il,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
 ,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 01212c32742211f1aa26b74ffac11d73-20260630
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 13041911; Tue, 30 Jun 2026 09:21:22 +0800
From: zhaoguohan@kylinos.cn
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 2/2] vhost-user-base: clean up vhost_dev on realize failure
Date: Tue, 30 Jun 2026 09:20:58 +0800
Message-ID: <20260630012058.2663259-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629092619.2607275-2-zhaoguohan@kylinos.cn>
References: <20260629092619.2607275-1-zhaoguohan@kylinos.cn>
 <20260629092619.2607275-2-zhaoguohan@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Failures after vhost_dev_init() currently skip vhost_dev_cleanup(),
leaking initialized vhost_dev state.

Add a separate unwind label for those paths. Keep a copy of
vhost_dev.vqs so the array can still be freed after vhost_dev_cleanup()
clears struct vhost_dev.

Fixes: 6608dca74ecf (vhost-user-device: Add shared memory BAR)
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
v2:
- Use a separate error label instead of a bool.

 hw/virtio/vhost-user-base.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 39b5e637fc37..62a139ebbdfe 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -283,6 +283,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(dev);
     uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
+    struct vhost_virtqueue *vhost_vqs = NULL;
     int i, ret, nregions, regions_processed = 0;
 
     if (!vub->chardev.chr) {
@@ -334,6 +335,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 
     vub->vhost_dev.nvqs = vub->num_vqs;
     vub->vhost_dev.vqs = g_new0(struct vhost_virtqueue, vub->vhost_dev.nvqs);
+    vhost_vqs = vub->vhost_dev.vqs;
 
     /* connect to backend */
     ret = vhost_dev_init(&vub->vhost_dev, &vub->vhost_user,
@@ -349,7 +351,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
                                                            errp);
 
     if (ret < 0) {
-        goto err;
+        goto err_vhost_dev;
     }
 
     for (i = 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processed < nregions; i++) {
@@ -364,14 +366,14 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
                     errp);
 
                 if (ret < 0) {
-                    goto err;
+                    goto err_vhost_dev;
                 }
             }
 
             if (memory_sizes[i] % qemu_real_host_page_size() != 0) {
                 error_setg(errp, "Shared memory %d size must be a multiple of "
                                  "the host page size", i);
-                goto err;
+                goto err_vhost_dev;
             }
 
             virtio_new_shmem_region(vdev, i, memory_sizes[i]);
@@ -381,7 +383,10 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
     qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
                              dev, NULL, true);
     return;
+err_vhost_dev:
+    vhost_dev_cleanup(&vub->vhost_dev);
 err:
+    g_free(vhost_vqs);
     do_vhost_user_cleanup(vdev, vub);
 }
 
-- 
2.43.0

