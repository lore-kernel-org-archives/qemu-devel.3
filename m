Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9B6CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RR2-0000wk-RT; Mon, 29 Sep 2025 23:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v3RR0-0000w0-Qi
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:53:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v3RQr-0001ql-4S
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:53:50 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx3tI_VNtoxGsQAA--.34469S3;
 Tue, 30 Sep 2025 11:53:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8E8VNtoak+_AA--.40492S6;
 Tue, 30 Sep 2025 11:53:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 04/13] target/loongarch: Add function sptw_prepare_tlb
 before adding tlb entry
Date: Tue, 30 Sep 2025 11:53:23 +0800
Message-Id: <20250930035332.2609520-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250930035332.2609520-1-maobibo@loongson.cn>
References: <20250930035332.2609520-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8E8VNtoak+_AA--.40492S6
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
 target/loongarch/tcg/tlb_helper.c | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index bc3700f93d..865800fc0a 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -25,6 +25,7 @@ typedef struct MMUContext {
     hwaddr        physical;
     int           ps;  /* page size shift */
     int           prot;
+    uint64_t      pte_buddy[2];
 } MMUContext;
 
 static inline bool cpu_has_ptw(CPULoongArchState *env)
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index b1092d3aff..01ade068ab 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -157,10 +157,10 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
     invalidate_tlb_entry(env, index);
 }
 
-static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb)
+/* Prepare tlb entry information in software PTW mode */
+static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
 {
     uint64_t lo0, lo1, csr_vppn;
-    uint16_t csr_asid;
     uint8_t csr_ps;
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
@@ -183,6 +183,25 @@ static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb)
         lo1 = env->CSR_TLBELO1;
     }
 
+    context->ps = csr_ps;
+    context->addr = csr_vppn << R_TLB_MISC_VPPN_SHIFT;
+    context->pte_buddy[0] = lo0;
+    context->pte_buddy[1] = lo1;
+}
+
+static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb)
+{
+    uint64_t lo0, lo1, csr_vppn;
+    uint16_t csr_asid;
+    uint8_t csr_ps;
+    MMUContext context;
+
+    sptw_prepare_context(env, &context);
+    csr_vppn = context.addr >> R_TLB_MISC_VPPN_SHIFT;
+    csr_ps   = context.ps;
+    lo0      = context.pte_buddy[0];
+    lo1      = context.pte_buddy[1];
+
     /* Store page size in field PS */
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
-- 
2.39.3


