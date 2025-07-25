Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08ADC83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 01:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf7PU-00022I-T7; Thu, 24 Jul 2025 21:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uf7Nh-0000kF-5a
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:37:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uf7Nd-0002b4-0H
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:37:52 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx22ro34JojpAxAQ--.65177S3;
 Fri, 25 Jul 2025 09:37:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxdOTk34Joz5wlAA--.62171S10;
 Fri, 25 Jul 2025 09:37:43 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 08/17] target/loongarch: Add parameter mmu_context with
 loongarch_map_tlb_entry
Date: Fri, 25 Jul 2025 09:37:30 +0800
Message-Id: <20250725013739.994437-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250725013739.994437-1-maobibo@loongson.cn>
References: <20250725013739.994437-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOTk34Joz5wlAA--.62171S10
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

With function loongarch_map_tlb_entry(), parameter mmu_context is added
and remove parameter physical and prot.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index dd99a063cc..460e7c00c5 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -648,30 +648,22 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
 }
 
-static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
-                                   int *prot, target_ulong address,
+static int loongarch_map_tlb_entry(CPULoongArchState *env, mmu_context *context,
                                    int access_type, int index, int mmu_idx)
 {
     LoongArchTLB *tlb = &env->tlb[index];
     uint64_t tlb_entry;
     uint8_t tlb_ps, n;
-    mmu_context context;
-    int ret;
+    target_ulong address;
 
+    address = context->vaddr;
     tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     n = (address >> tlb_ps) & 0x1;/* Odd or even */
 
     tlb_entry = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
-    context.vaddr = address;
-    context.ps = tlb_ps;
-    context.pte  = tlb_entry;
-    ret = loongarch_check_pte(env, &context, access_type, mmu_idx);
-    if (ret == TLBRET_MATCH) {
-        *physical = context.physical;
-        *prot = context.prot;
-    }
-
-    return ret;
+    context->ps = tlb_ps;
+    context->pte  = tlb_entry;
+    return loongarch_check_pte(env, context, access_type, mmu_idx);
 }
 
 int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
@@ -679,11 +671,18 @@ int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
                                 MMUAccessType access_type, int mmu_idx)
 {
     int index, match;
+    mmu_context context;
 
+    context.vaddr = address;
     match = loongarch_tlb_search(env, address, &index);
     if (match) {
-        return loongarch_map_tlb_entry(env, physical, prot,
-                                       address, access_type, index, mmu_idx);
+        match = loongarch_map_tlb_entry(env, &context,
+                                        access_type, index, mmu_idx);
+        if (match == TLBRET_MATCH) {
+            *physical = context.physical;
+            *prot = context.prot;
+        }
+        return match;
     }
 
     return TLBRET_NOMATCH;
-- 
2.39.3


