Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AADFCA0EE3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 07:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umSW2-0006wi-VH; Thu, 14 Aug 2025 03:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1umSVt-0006uF-Fi
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:36:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1umSVq-0004S1-0c
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:36:40 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxTOL6kZ1oDqs_AQ--.14533S3;
 Thu, 14 Aug 2025 15:36:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxM+T4kZ1oM9xKAA--.22944S9;
 Thu, 14 Aug 2025 15:36:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 7/9] target/loongarch: Add basic hardware PTW support
Date: Thu, 14 Aug 2025 15:36:22 +0800
Message-Id: <20250814073624.430928-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250814073624.430928-1-maobibo@loongson.cn>
References: <20250814073624.430928-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+T4kZ1oM9xKAA--.22944S9
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

With software PTW, there is TLB refill exception if there is TLB miss.

However with hardware PTW supported, hardware will search page table
with TLB miss. Also if Present bit is not set, hardware PTW will take,
it is used in odd/even TLB entry. For example in the first time odd TLB
entry is valid and even TLB entry is 0. When software accesses with
address from even page, there is no TLB miss only that TLB entry is 0.
In this condition, hardwre PTW will take also.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-mmu.h        |  3 +++
 target/loongarch/cpu_helper.c     | 17 ++++++++++++++---
 target/loongarch/tcg/tlb_helper.c | 26 ++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index c3e869234a..2e63324abe 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -67,6 +67,9 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
 TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug);
+TLBRet loongarch_page_table_walker(CPULoongArchState *env,
+                                   MMUContext *context,
+                                   int access_type, int mmu_idx);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                                uint64_t *dir_width, target_ulong level);
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 2e07049425..79c994255f 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -106,9 +106,9 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
     return TLBRET_MATCH;
 }
 
-static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
-                                          MMUContext *context,
-                                          int access_type, int mmu_idx)
+TLBRet loongarch_page_table_walker(CPULoongArchState *env,
+                                   MMUContext *context,
+                                   int access_type, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
     target_ulong index, phys;
@@ -151,12 +151,23 @@ static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
             base = FIELD_DP64(base, TLBENTRY, HGLOBAL, 0);
             base = FIELD_DP64(base, TLBENTRY, G, 1);
         }
+
+        dir_base -= 1;
+        context->pte_buddy[0] = base;
+        context->pte_buddy[1] = base + BIT_ULL(dir_base);
+        base += (BIT_ULL(dir_base) & address);
     } else {
         /* Normal Page. base points to pte */
         get_dir_base_width(env, &dir_base, &dir_width, 0);
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
         base = ldq_phys(cs->as, phys);
+        if (cpu_has_ptw(env)) {
+            index &= 1;
+            context->pte_buddy[index] = base;
+            context->pte_buddy[1 - index] = ldq_phys(cs->as,
+                                            phys + 8 * (1 - 2 * index));
+        }
     }
 
     context->ps = dir_base;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 50c7583c6c..7fdac475b3 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -621,6 +621,20 @@ static inline void tlb_set_accessed(CPULoongArchState *env, vaddr address,
     tlb->tlb_misc |= TLB_MISC_KM_PTE(n);
 }
 
+static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context)
+{
+    int index;
+    bool match;
+
+    match = loongarch_tlb_search(env, context->addr, &index);
+    if (!match) {
+        index = get_tlb_random_index(env, context->addr, context->ps);
+    }
+
+    invalidate_tlb(env, index);
+    fill_tlb_entry(env, env->tlb + index, context);
+}
+
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr)
@@ -634,6 +648,18 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     /* Data access */
     context.addr = address;
     ret = get_physical_address(env, &context, access_type, mmu_idx, 0);
+    if (ret != TLBRET_MATCH && cpu_has_ptw(env)) {
+        /* Take HW PTW if TLB missed or bit P is zero */
+        if (ret == TLBRET_NOMATCH || ret == TLBRET_INVALID) {
+            ret = loongarch_page_table_walker(env, &context, access_type, mmu_idx);
+            if (ret == TLBRET_MATCH) {
+                ptw_update_tlb(env, &context);
+            }
+        } else {
+            invalidate_tlb(env, context.tlb_index);
+        }
+    }
+
     if (ret == TLBRET_MATCH) {
         physical = context.physical;
         prot = context.prot;
-- 
2.39.3


