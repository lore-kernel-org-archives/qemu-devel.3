Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4676EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFwE-0007S4-TO; Mon, 13 Jul 2026 08:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <malike@kylinos.cn>)
 id 1wj7Bb-0007qm-Io; Sun, 12 Jul 2026 23:18:27 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <malike@kylinos.cn>)
 id 1wj7BW-0005bT-9C; Sun, 12 Jul 2026 23:18:27 -0400
X-UUID: 7701369e7e6911f1aa26b74ffac11d73-20260713
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
 IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
 SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
 UD_TRUSTED
X-CID-UNFAMILIAR: 1
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:2b7b3e3f-594f-492a-9985-67708dece52c, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.12, REQID:2b7b3e3f-594f-492a-9985-67708dece52c, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:e7bac3a, CLOUDID:24c7b349e53b990c872a94f265e46534,
 BulkI
 D:260713111806Z3Y4OGOL,BulkQuantity:0,Recheck:0,SF:16|19|66|78|102|127|850
 |865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:ni
 l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
 :0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7701369e7e6911f1aa26b74ffac11d73-20260713
X-User: malike@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <malike@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1769151953; Mon, 13 Jul 2026 11:18:05 +0800
From: malike <malike@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, malike <malike@kylinos.cn>
Subject: [PATCH] block/cloop: fix integer overflow in total_sectors calculation
Date: Mon, 13 Jul 2026 11:17:50 +0800
Message-Id: <20260713031750.58448-1-malike@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=malike@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Jul 2026 08:39:04 -0400
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

The total_sectors is computed as n_blocks * sectors_per_block where
both operands are uint32_t. The multiplication is performed in 32-bit
arithmetic and can overflow when the product exceeds UINT32_MAX,
producing a value much smaller than the true image size. The result
is assigned to int64_t total_sectors but the 32-bit multiplication
has already wrapped around, and the zero-extension to 64-bit does
not recover the correct value.

This causes the block layer to reject valid I/O requests (DoS) when
the reported total_sectors is smaller than the actual image.

Use 64-bit arithmetic by casting one operand to uint64_t so the
multiplication is performed in 64-bit precision.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3972
Signed-off-by: Ma Like <malike@kylinos.cn>
---
 block/cloop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/cloop.c b/block/cloop.c
index 443af1444e..a16f08e6ef 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -202,7 +202,8 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
     s->current_block = s->n_blocks;
 
     s->sectors_per_block = s->block_size/512;
-    bs->total_sectors = s->n_blocks * s->sectors_per_block;
+    /* Cast to uint64_t to prevent uint32_t overflow */
+    bs->total_sectors = (uint64_t)s->n_blocks * s->sectors_per_block;
     qemu_co_mutex_init(&s->lock);
     return 0;
 
-- 
2.25.1


