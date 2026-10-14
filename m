Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF061CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGplR-0003wu-4a; Tue, 13 Oct 2026 23:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <malike@kylinos.cn>) id 1xGplN-0003wl-Ue
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:34:45 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <malike@kylinos.cn>) id 1xGplL-0000vR-2v
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:34:45 -0400
X-UUID: 25c182a6c78011f19a56ed5b684f684d-20261014
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
 IP_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
 DKIM_NOPASS, DMARC_NOPASS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:458edf85-01a5-4584-bb83-677169858944, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.19, REQID:458edf85-01a5-4584-bb83-677169858944, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:7db8b62, CLOUDID:4b452597ac3a90e3e317a4d0a9d4b065,
 BulkI
 D:261014113426HQO3MATH,BulkQuantity:0,SF:19|66|72|78|102|127|850|865|898,T
 C:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
 l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
 0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 25c182a6c78011f19a56ed5b684f684d-20261014
X-User: malike@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <malike@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1275887748; Wed, 14 Oct 2026 11:34:22 +0800
From: malike <malike@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 malike <malike@kylinos.cn>
Subject: [PATCH] block/bochs: validate bitmap size and compute extent_blocks
 after validation
Date: Wed, 14 Oct 2026 11:34:19 +0800
Message-Id: <20261014033419.236057-1-malike@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=malike@kylinos.cn;
 helo=mailgw.kylinos.cn
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

bochs_open() computes bitmap_blocks using the formula
"1 + (le32_to_cpu(bochs.bitmap) - 1) / 512".  le32_to_cpu() returns
uint32_t, so when bochs.bitmap is zero the subtraction wraps to
UINT32_MAX (0xFFFFFFFF) in unsigned arithmetic, yielding
bitmap_blocks = 8388608 instead of 1.

The bitmap field is read directly from the on-disk image header and was
never validated.  The overflowed bitmap_blocks propagates into
seek_to_sector()'s bitmap_offset calculation, causing reads to target
wrong offsets and return I/O errors or incorrect data.

Add an explicit zero check for bochs.bitmap before the formula.

Also move the extent_blocks calculation to after the existing
extent_size validation.  The same "1 + (x - 1) / 512" pattern applies
to extent, but extent==0 is already caught by the "extent_size <
BDRV_SECTOR_SIZE" check; the calculation is moved after that check for
clarity and robustness, and uses the already-validated s->extent_size
instead of re-reading the header field.

Fixes: a8753c3466dc ("Bochs disk image support")
Signed-off-by: malike <malike@kylinos.cn>
---
 block/bochs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/bochs.c b/block/bochs.c
index bfda88017d..7a8091d47d 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -167,8 +167,13 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->data_offset = le32_to_cpu(bochs.header) + (s->catalog_size * 4);
 
+    if (le32_to_cpu(bochs.bitmap) == 0) {
+        error_setg(errp, "Bitmap size must not be zero");
+        ret = -EINVAL;
+        goto fail;
+    }
+
     s->bitmap_blocks = 1 + (le32_to_cpu(bochs.bitmap) - 1) / 512;
-    s->extent_blocks = 1 + (le32_to_cpu(bochs.extent) - 1) / 512;
 
     s->extent_size = le32_to_cpu(bochs.extent);
     if (s->extent_size < BDRV_SECTOR_SIZE) {
@@ -188,6 +193,8 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    s->extent_blocks = 1 + (s->extent_size - 1) / 512;
+
     if (s->catalog_size < DIV_ROUND_UP(bs->total_sectors,
                                        s->extent_size / BDRV_SECTOR_SIZE))
     {
-- 
2.25.1


