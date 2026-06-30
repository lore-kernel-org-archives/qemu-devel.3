Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEE0C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weSt7-0004ch-FZ; Tue, 30 Jun 2026 03:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1weSt3-0004cX-VE
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 03:28:05 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1weSsz-0007Q6-13
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 03:28:05 -0400
X-UUID: 30c23a84745511f1aa26b74ffac11d73-20260630
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:5411dd52-bae3-4e73-9143-09255a079eef, IP:15,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:40
X-CID-INFO: VERSION:1.3.12, REQID:5411dd52-bae3-4e73-9143-09255a079eef, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:40
X-CID-META: VersionHash:e7bac3a, CLOUDID:75d53c3867f9ec77ee233a54da5cf661,
 BulkI
 D:260630152749V5UYUQA6,BulkQuantity:0,Recheck:0,SF:10|66|78|102|123|127|86
 5|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
 :nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
 RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 30c23a84745511f1aa26b74ffac11d73-20260630
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1732110104; Tue, 30 Jun 2026 15:27:46 +0800
From: zhaoguohan@kylinos.cn
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>
Subject: [PATCH] vhost-user-scmi: free vhost virtqueue array on cleanup
Date: Tue, 30 Jun 2026 15:27:28 +0800
Message-ID: <20260630072728.3025097-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
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

vhost-user-scmi allocates vhost_dev.vqs during realize, but the
cleanup helper frees scmi->vhost_dev.vqs after vhost_dev_cleanup() has
cleared struct vhost_dev. This turns the free into g_free(NULL), leaking
the allocated vhost virtqueue array.

Keep a copy of the vhost_dev.vqs pointer across vhost_dev_cleanup() and
free that saved pointer from the common cleanup helper.

Fixes: a5dab090e142 (hw/virtio: Add boilerplate for vhost-user-scmi device)
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/virtio/vhost-user-scmi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 9470f68c1f3c..02dc088ea982 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -220,11 +220,12 @@ static void vu_scmi_event(void *opaque, QEMUChrEvent event)
     }
 }
 
-static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserSCMI *scmi)
+static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserSCMI *scmi,
+                                  struct vhost_virtqueue *vhost_vqs)
 {
     virtio_delete_queue(scmi->cmd_vq);
     virtio_delete_queue(scmi->event_vq);
-    g_free(scmi->vhost_dev.vqs);
+    g_free(vhost_vqs);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&scmi->vhost_user);
 }
@@ -233,6 +234,7 @@ static void vu_scmi_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserSCMI *scmi = VHOST_USER_SCMI(dev);
+    struct vhost_virtqueue *vhost_vqs;
     int ret;
 
     if (!scmi->chardev.chr) {
@@ -252,13 +254,14 @@ static void vu_scmi_device_realize(DeviceState *dev, Error **errp)
     scmi->event_vq = virtio_add_queue(vdev, 256, vu_scmi_handle_output);
     scmi->vhost_dev.nvqs = 2;
     scmi->vhost_dev.vqs = g_new0(struct vhost_virtqueue, scmi->vhost_dev.nvqs);
+    vhost_vqs = scmi->vhost_dev.vqs;
 
     ret = vhost_dev_init(&scmi->vhost_dev, &scmi->vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0, errp);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
                          "vhost-user-scmi: vhost_dev_init() failed");
-        do_vhost_user_cleanup(vdev, scmi);
+        do_vhost_user_cleanup(vdev, scmi, vhost_vqs);
         return;
     }
 
@@ -270,10 +273,11 @@ static void vu_scmi_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserSCMI *scmi = VHOST_USER_SCMI(dev);
+    struct vhost_virtqueue *vhost_vqs = scmi->vhost_dev.vqs;
 
     vu_scmi_set_status(vdev, 0);
     vhost_dev_cleanup(&scmi->vhost_dev);
-    do_vhost_user_cleanup(vdev, scmi);
+    do_vhost_user_cleanup(vdev, scmi, vhost_vqs);
 }
 
 static const VMStateDescription vu_scmi_vmstate = {
-- 
2.43.0


