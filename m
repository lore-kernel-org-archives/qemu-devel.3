Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08070FB5EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 04:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3RiL-0007p3-AH; Fri, 20 Mar 2026 00:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanlonglong@kylinos.cn>)
 id 1w3PIH-0007xm-RX
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 22:08:57 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanlonglong@kylinos.cn>)
 id 1w3PIC-0004C3-JH
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 22:08:57 -0400
X-UUID: b4698b34240111f1a21c59e7364eecb8-20260320
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
 IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
 SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
 CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
 AMN_GOOD, ABX_MISS_RDNS
X-CID-UNFAMILIAR: 1
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_HamU
X-CID-O-INFO: VERSION:1.3.11, REQID:447a7293-2f6d-4f21-a9b1-1e9f9e167a2d, IP:10,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:18,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:53
X-CID-INFO: VERSION:1.3.11, REQID:447a7293-2f6d-4f21-a9b1-1e9f9e167a2d, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:18,FILE:0,BULK:0,RULE:Release_HamU,ACTIO
 N:release,TS:53
X-CID-META: VersionHash:89c9d04, CLOUDID:887320a2dffeb850f766de65d9567a56,
 BulkI
 D:2603201008373NC7UOW7,BulkQuantity:0,Recheck:0,SF:16|19|66|78|102|127|850
 |898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
 nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b4698b34240111f1a21c59e7364eecb8-20260320
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
 (envelope-from <yanlonglong@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 183532542; Fri, 20 Mar 2026 10:08:36 +0800
From: yanlonglong <yanlonglong@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: yanlonglong <yanlonglong@kylinos.cn>
Subject: [PATCH] hw/ide: resolve core crash caused by optical drive pop-up
 during virtual machine startup
Date: Fri, 20 Mar 2026 10:07:24 +0800
Message-Id: <20260320020724.8714-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=yanlonglong@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:43:57 -0400
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

Signed-off-by: yanlonglong <yanlonglong@kylinos.cn>
---
 hw/ide/atapi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index a42b748521..d14feed45b 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -153,6 +153,11 @@ static void cd_read_sector_cb(void *opaque, int ret)
 static int cd_read_sector(IDEState *s)
 {
     void *buf;
+    
+    //resolve core crash caused by optical drive pop-up during virtual machine startup
+    if (!blk_is_available(s->blk)) {
+        return -ENOMEDIUM;
+    }
 
     if (s->cd_sector_size != 2048 && s->cd_sector_size != 2352) {
         block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
-- 
2.43.0


