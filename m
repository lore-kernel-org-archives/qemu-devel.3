Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E323CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 08:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQL0h-00064Z-Ov; Fri, 22 May 2026 04:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wQL0b-00063l-V8
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:13:29 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wQL0V-0005jI-Gb
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:13:27 -0400
X-UUID: 122e014255b611f1aa26b74ffac11d73-20260522
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:8a508aa3-1c24-4352-8bd0-ed917b7f74a3, IP:20,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:20
X-CID-INFO: VERSION:1.3.12, REQID:8a508aa3-1c24-4352-8bd0-ed917b7f74a3, IP:20,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:20
X-CID-META: VersionHash:e7bac3a, CLOUDID:f9f8c24b126e15ad7de8a2e83116bb69,
 BulkI
 D:26052216131237XZNB4Y,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|123|127
 |865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
 l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
 :0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 122e014255b611f1aa26b74ffac11d73-20260522
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(120.228.139.200)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1648049946; Fri, 22 May 2026 16:13:10 +0800
From: zhaoguohan@kylinos.cn
To: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/2] vfio-user: reject zero DMA page size capability
Date: Fri, 22 May 2026 16:13:05 +0800
Message-ID: <20260522081306.4186242-1-zhaoguohan@kylinos.cn>
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

check_pgsizes() validates that no page-size bits smaller than
VFIO_USER_DEF_PGSIZE are set, but it still accepts pgsizes=0. This lets a
malformed server overwrite the default page-size mask with zero.

Later vfio_user_setup() asserts that proxy->dma_pgsizes is non-zero, so device
realization aborts instead of reporting a version capability error. Reject a
zero DMA page-size mask during version capability parsing.

Fixes: 36227628d824 (vfio-user: implement message send infrastructure)
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/vfio-user/proxy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 8b7cc36231ab..7c3036ec83c5 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -1155,9 +1155,11 @@ static bool check_pgsizes(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
         return false;
     }
 
-    /* must be larger than default */
-    if (pgsizes & (VFIO_USER_DEF_PGSIZE - 1)) {
-        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsizes);
+    /* must not be zero or smaller than default */
+    if (pgsizes < VFIO_USER_DEF_PGSIZE ||
+        (pgsizes & (VFIO_USER_DEF_PGSIZE - 1))) {
+        error_setg(errp, "%s 0x%"PRIx64" too small",
+                   VFIO_USER_CAP_PGSIZES, pgsizes);
         return false;
     }
 
-- 
2.43.0


