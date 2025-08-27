Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12383C8303F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urBEP-0000wn-AF; Wed, 27 Aug 2025 04:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urBE2-0000bL-Jh
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:09:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urBDy-0004BK-Tb
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:09:46 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxXNI6va5obrADAA--.7285S3;
 Wed, 27 Aug 2025 16:09:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxXME4va5oWKVrAA--.18662S6;
 Wed, 27 Aug 2025 16:09:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 04/12] target/loongarch: Add function sptw_prepare_tlb
 before adding tlb entry
Date: Wed, 27 Aug 2025 16:09:19 +0800
Message-Id: <20250827080927.1644016-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250827080927.1644016-1-maobibo@loongson.cn>
References: <20250827080927.1644016-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxXME4va5oWKVrAA--.18662S6
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

With software page table walker, tlb entry comes from CSR registers.
however with hardware page table walker, tlb entry comes from page
table entry information directly, TLB CSR registers are not necessary.

Here add function sptw_prepare_context(), get tlb entry information
from TLB CSR registers.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-mmu.h        |  1 +
 target/loongarch/tcg/tlb_helper.c | 37 ++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index e4f3199f44..c3e869234a 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -27,6 +27,7 @@ typedef struct MMUContext {
     int           prot;
     int           tlb_index;
     int           mmu_index;
+    uint64_t      pte_buddy[2];
 } MMUContext;
 
 static inline bool cpu_has_ptw(CPULoongArchState *env)
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 10c01ead3f..fa216b92fd 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -174,42 +174,53 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
 }
 
-static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb)
+/* Prepare tlb entry information in software PTW mode */
+static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
 {
-    uint64_t lo0, lo1, csr_vppn;
-    uint16_t csr_asid;
-    uint8_t csr_ps;
+    uint64_t csr_vppn;
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        csr_ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+        context->ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
         if (is_la64(env)) {
             csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, VPPN);
         } else {
             csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_32, VPPN);
         }
-        lo0 = env->CSR_TLBRELO0;
-        lo1 = env->CSR_TLBRELO1;
+        context->pte_buddy[0] = env->CSR_TLBRELO0;
+        context->pte_buddy[1] = env->CSR_TLBRELO1;
     } else {
-        csr_ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+        context->ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
         if (is_la64(env)) {
             csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
         } else {
             csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_32, VPPN);
         }
-        lo0 = env->CSR_TLBELO0;
-        lo1 = env->CSR_TLBELO1;
+        context->pte_buddy[0] = env->CSR_TLBELO0;
+        context->pte_buddy[1] = env->CSR_TLBELO1;
     }
 
+    context->addr  = csr_vppn << R_TLB_MISC_VPPN_SHIFT;
+}
+
+static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb)
+{
+    uint64_t csr_vppn;
+    uint16_t csr_asid;
+    MMUContext context;
+
+    sptw_prepare_context(env, &context);
+    csr_vppn = context.addr >> R_TLB_MISC_VPPN_SHIFT;
+
     /* Store page size in field PS */
     tlb->tlb_misc = 0;
-    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
+    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, context.ps);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
     csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, ASID, csr_asid);
 
-    tlb->tlb_entry0 = lo0;
-    tlb->tlb_entry1 = lo1;
+    tlb->tlb_entry0 = context.pte_buddy[0];
+    tlb->tlb_entry1 = context.pte_buddy[1];
 }
 
 /* Return an random value between low and high */
-- 
2.39.3


