Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D4CC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we8GW-0002Ch-JI; Mon, 29 Jun 2026 05:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1we8GT-0002C7-K8
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:26:53 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1we8GO-0001gq-G7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:26:53 -0400
X-UUID: 9e0786bc739c11f1aa26b74ffac11d73-20260629
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:dc5156c5-e120-4ead-939f-9cf669e94592, IP:15,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:15
X-CID-INFO: VERSION:1.3.12, REQID:dc5156c5-e120-4ead-939f-9cf669e94592, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:15
X-CID-META: VersionHash:e7bac3a, CLOUDID:00f4e3e7127f01c50693a9479d7f8b9a,
 BulkI
 D:26062917263380OG06EC,BulkQuantity:0,Recheck:0,SF:10|66|78|102|123|127|86
 5|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
 S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
 ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9e0786bc739c11f1aa26b74ffac11d73-20260629
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1844128057; Mon, 29 Jun 2026 17:26:32 +0800
From: zhaoguohan@kylinos.cn
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/2] vhost-user-base: free virtqueue array during cleanup
Date: Mon, 29 Jun 2026 17:26:18 +0800
Message-ID: <20260629092619.2607275-1-zhaoguohan@kylinos.cn>
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

vhost-user-base stores the VirtQueue pointers in a GPtrArray, but its
cleanup helper only deletes the VirtQueues and leaves the array itself
allocated.

Free the GPtrArray after deleting the queues and clear the pointer so
cleanup remains safe if the error path reaches it with no queues to
release.

Fixes: 6275989647ef (virtio: split into vhost-user-base and vhost-user-device)
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/virtio/vhost-user-base.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 39b5e637fc37..6ac523f9ebef 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -193,9 +193,13 @@ static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserBase *vub)
 {
     vhost_user_cleanup(&vub->vhost_user);
 
-    for (int i = 0; i < vub->num_vqs; i++) {
-        VirtQueue *vq = g_ptr_array_index(vub->vqs, i);
-        virtio_delete_queue(vq);
+    if (vub->vqs) {
+        for (int i = 0; i < vub->num_vqs; i++) {
+            VirtQueue *vq = g_ptr_array_index(vub->vqs, i);
+            virtio_delete_queue(vq);
+        }
+        g_ptr_array_free(vub->vqs, true);
+        vub->vqs = NULL;
     }
 
     virtio_cleanup(vdev);
-- 
2.43.0


