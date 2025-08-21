Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F235ECA0EE6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 03:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uovjq-0000xO-QD; Wed, 20 Aug 2025 23:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uovjk-0000vb-8K
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 23:13:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uovje-0003YV-6N
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 23:13:11 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx+tG7jqZoszoBAA--.2327S3;
 Thu, 21 Aug 2025 11:12:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxrcG4jqZodY5cAA--.63748S8;
 Thu, 21 Aug 2025 11:12:59 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 06/10] target/loongarch: Add MMUContext parameter in
 fill_tlb_entry()
Date: Thu, 21 Aug 2025 11:12:52 +0800
Message-Id: <20250821031256.3451168-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250821031256.3451168-1-maobibo@loongson.cn>
References: <20250821031256.3451168-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxrcG4jqZodY5cAA--.63748S8
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Function fill_tlb_entry() can be used with hardware PTW in future,
here add input parameter MMUContext in fill_tlb_entry().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 67b8f95849..50c7583c6c 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -202,25 +202,24 @@ static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
     context->addr  = csr_vppn << R_TLB_MISC_VPPN_SHIFT;
 }
 
-static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb)
+static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
+                           MMUContext *context)
 {
     uint64_t csr_vppn;
     uint16_t csr_asid;
-    MMUContext context;
 
-    sptw_prepare_context(env, &context);
-    csr_vppn = context.addr >> R_TLB_MISC_VPPN_SHIFT;
+    csr_vppn = context->addr >> R_TLB_MISC_VPPN_SHIFT;
 
     /* Store page size in field PS */
     tlb->tlb_misc = 0;
-    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, context.ps);
+    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, context->ps);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
     csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, ASID, csr_asid);
 
-    tlb->tlb_entry0 = context.pte_buddy[0];
-    tlb->tlb_entry1 = context.pte_buddy[1];
+    tlb->tlb_entry0 = context->pte_buddy[0];
+    tlb->tlb_entry1 = context->pte_buddy[1];
 }
 
 /* Return an random value between low and high */
@@ -359,6 +358,7 @@ void helper_tlbwr(CPULoongArchState *env)
     LoongArchTLB *old, new;
     bool skip_inv = false;
     uint8_t tlb_v0, tlb_v1;
+    MMUContext context;
 
     old = env->tlb + index;
     if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
@@ -366,10 +366,11 @@ void helper_tlbwr(CPULoongArchState *env)
         return;
     }
 
+    sptw_prepare_context(env, &context);
     new.tlb_misc = 0;
     new.tlb_entry0 = 0;
     new.tlb_entry1 = 0;
-    fill_tlb_entry(env, &new);
+    fill_tlb_entry(env, &new, &context);
     /* Check whether ASID/VPPN is the same */
     if (old->tlb_misc == new.tlb_misc) {
         /* Check whether pte is the same or invalid */
@@ -456,6 +457,7 @@ void helper_tlbfill(CPULoongArchState *env)
 {
     uint64_t entryhi;
     int index, pagesize;
+    MMUContext context;
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         entryhi = env->CSR_TLBREHI;
@@ -467,9 +469,10 @@ void helper_tlbfill(CPULoongArchState *env)
         pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
     }
 
+    sptw_prepare_context(env, &context);
     index = get_tlb_random_index(env, entryhi, pagesize);
     invalidate_tlb(env, index);
-    fill_tlb_entry(env, env->tlb + index);
+    fill_tlb_entry(env, env->tlb + index, &context);
 }
 
 void helper_tlbclr(CPULoongArchState *env)
-- 
2.39.3


