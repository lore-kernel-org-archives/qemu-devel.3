Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5BDC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 06:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toz9U-00017I-9e; Mon, 03 Mar 2025 01:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1toz8r-00012p-86
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 01:19:05 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1toz8n-0002W6-D0
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 01:19:05 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axz3PRScVnMeuIAA--.37161S3;
 Mon, 03 Mar 2025 14:18:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMDxu8TJScVnNEMzAA--.56344S3;
 Mon, 03 Mar 2025 14:18:56 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org,
	maobibo@loongson.cn
Cc: richard.henderson@linaro.org, yangxiaojuan@loongson.cn,
 wangliupu@loongson.cn
Subject: [PATCH v6 1/2] target/loongarch: fix 'make check-functional' failed
Date: Mon,  3 Mar 2025 13:57:20 +0800
Message-Id: <20250303055721.3236502-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250303055721.3236502-1-gaosong@loongson.cn>
References: <20250303055721.3236502-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxu8TJScVnNEMzAA--.56344S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

 some tlb instructions get  the tlb_ps from tlb->misc but the
 value may has been initialized to 0,just check the tlb_ps skip
 the function and write a log.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a323606e5a..112556301f 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -427,7 +427,11 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
         uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
         uint64_t vpn, tlb_vppn;
         uint8_t tlb_ps, compare_shift;
+        uint8_t tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
 
+        if (!tlb_e) {
+            continue;
+        }
         if (i >= LOONGARCH_STLB) {
             tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
         } else {
@@ -456,7 +460,11 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
         uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
         uint64_t vpn, tlb_vppn;
         uint8_t tlb_ps, compare_shift;
+        uint8_t tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
 
+        if (!tlb_e) {
+            continue;
+        }
         if (i >= LOONGARCH_STLB) {
             tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
         } else {
-- 
2.34.1


