Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8E6CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RT8-0003UE-Ui; Mon, 29 Sep 2025 23:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v3RT7-0003SY-Dp
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:56:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v3RSw-0002ps-Cn
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:56:01 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cx5tBAVNtoymsQAA--.34559S3;
 Tue, 30 Sep 2025 11:53:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8E8VNtoak+_AA--.40492S8;
 Tue, 30 Sep 2025 11:53:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 06/13] target/loongarch: Add MMUContext parameter in
 fill_tlb_entry()
Date: Tue, 30 Sep 2025 11:53:25 +0800
Message-Id: <20250930035332.2609520-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250930035332.2609520-1-maobibo@loongson.cn>
References: <20250930035332.2609520-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8E8VNtoak+_AA--.40492S8
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

Function fill_tlb_entry() can be used with hardware PTW in future,
here add input parameter MMUContext in fill_tlb_entry().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index c062efc7b8..465d2885e1 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -189,18 +189,17 @@ static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
     context->pte_buddy[1] = lo1;
 }
 
-static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb)
+static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
+                           MMUContext *context)
 {
     uint64_t lo0, lo1, csr_vppn;
     uint16_t csr_asid;
     uint8_t csr_ps;
-    MMUContext context;
 
-    sptw_prepare_context(env, &context);
-    csr_vppn = context.addr >> R_TLB_MISC_VPPN_SHIFT;
-    csr_ps   = context.ps;
-    lo0      = context.pte_buddy[0];
-    lo1      = context.pte_buddy[1];
+    csr_vppn = context->addr >> R_TLB_MISC_VPPN_SHIFT;
+    csr_ps   = context->ps;
+    lo0      = context->pte_buddy[0];
+    lo1      = context->pte_buddy[1];
 
     /* Store page size in field PS */
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
@@ -354,6 +353,7 @@ void helper_tlbwr(CPULoongArchState *env)
     int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     LoongArchTLB *old, new = {};
     bool skip_inv = false, tlb_v0, tlb_v1;
+    MMUContext context;
 
     old = env->tlb + index;
     if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
@@ -361,7 +361,8 @@ void helper_tlbwr(CPULoongArchState *env)
         return;
     }
 
-    fill_tlb_entry(env, &new);
+    sptw_prepare_context(env, &context);
+    fill_tlb_entry(env, &new, &context);
     /* Check whether ASID/VPPN is the same */
     if (old->tlb_misc == new.tlb_misc) {
         /* Check whether both even/odd pages is the same or invalid */
@@ -448,6 +449,7 @@ void helper_tlbfill(CPULoongArchState *env)
 {
     vaddr entryhi;
     int index, pagesize;
+    MMUContext context;
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         entryhi = env->CSR_TLBREHI;
@@ -459,9 +461,10 @@ void helper_tlbfill(CPULoongArchState *env)
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


