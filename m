Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3F2C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofk1-000093-0R; Tue, 28 Jul 2026 07:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wofjx-00008c-NU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:12:53 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wofjv-0004IL-Qs
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:12:53 -0400
X-UUID: 3fce034c8a7511f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:09624de6-19f5-4dd3-ba27-2b3746b8b743, IP:15,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:15
X-CID-INFO: VERSION:1.3.12, REQID:09624de6-19f5-4dd3-ba27-2b3746b8b743, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:15
X-CID-META: VersionHash:e7bac3a, CLOUDID:6fbf01e76d8c4ec4d043735d61c231f1,
 BulkI
 D:260728191245IY5W75BC,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|136|86
 5|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
 S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
 ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3fce034c8a7511f1aa26b74ffac11d73-20260728
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 498631248; Tue, 28 Jul 2026 19:12:41 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-crypto: clean up every data queue
Date: Tue, 28 Jul 2026 19:12:17 +0800
Message-ID: <20260728111217.573046-1-zhaoguohan@kylinos.cn>
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

realize() creates max_queues data queues and one BH for each of them.
unrealize() decides how many to tear down from multiqueue, but nothing ever
sets that field, so it only deletes the first queue and BH.

It does not matter how many queues the guest used here.  unrealize() must
undo all the allocations made by realize(), so loop over max_queues.

Fixes: 20cb2ffd5ff3 ("virtio-crypto: using bh to handle dataq's requests")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/virtio/virtio-crypto.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 79e2acb56cc4..85c7279aae27 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1114,10 +1114,9 @@ static void virtio_crypto_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
     VirtIOCryptoQueue *q;
-    int i, max_queues;
+    int i;
 
-    max_queues = vcrypto->multiqueue ? vcrypto->max_queues : 1;
-    for (i = 0; i < max_queues; i++) {
+    for (i = 0; i < vcrypto->max_queues; i++) {
         virtio_delete_queue(vcrypto->vqs[i].dataq);
         q = &vcrypto->vqs[i];
         qemu_bh_delete(q->dataq_bh);
-- 
2.43.0


