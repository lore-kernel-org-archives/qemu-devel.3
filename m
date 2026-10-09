Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26C8CA6018
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0wf-0005Ho-EU; Thu, 08 Oct 2026 23:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vw-0004hD-5p
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:09 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vs-0005nI-Gp
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:07 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 92EEADFC1;
 Fri, 09 Oct 2026 08:35:51 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 16/23] target/loongarch: add LVZ to ptw
Date: Fri,  9 Oct 2026 11:05:12 +0800
Message-ID: <f9a04abe5b4eb0dd5b8590fe7fb16cf7f2444b45.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add function loongarch_try_ptw() and use it in both vm level 0 and 1 address
mapping.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-mmu.h        |  2 +-
 target/loongarch/cpu_helper.c     | 23 ++++++---
 target/loongarch/tcg/tlb_helper.c | 82 +++++++++++++++++--------------
 3 files changed, 64 insertions(+), 43 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 29b0c109fb..bad05a5a9c 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -40,7 +40,7 @@ typedef struct MMUContext {
 
 static inline bool cpu_has_ptw(CPULoongArchState *env, int vm_level)
 {
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     return !!FIELD_EX64(sys->CSR_PWCH, CSR_PWCH, HPTW_EN);
 }
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 23d26385c6..4ba991aaff 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -160,7 +160,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
     vaddr address;
     TLBRet ret;
     MemTxResult ret1;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     address = context->addr;
     if ((address >> 63) & 0x1) {
@@ -180,7 +180,10 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
         /* get next level page directory */
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
-        base = address_space_ldq_le(cs->as, phys, attrs, NULL);
+        base = address_space_ldq_le(
+            cs->as,
+            vm_level ? loongarch_get_host_address(env, phys, retaddr) : phys,
+            attrs, NULL);
         if (level) {
             if (FIELD_EX64(base, TLBENTRY, HUGE)) {
                 /* base is a huge pte */
@@ -214,8 +217,11 @@ restart:
 
         index &= 1;
         context->pte_buddy[index] = base;
-        val = address_space_ldq_le(cs->as, phys + 8 * (1 - 2 * index),
-                                   attrs, NULL);
+        val = address_space_ldq_le(
+            cs->as,
+            (vm_level ? loongarch_get_host_address(env, phys, retaddr) : phys) +
+                8 * (1 - 2 * index),
+            attrs, NULL);
         context->pte_buddy[1 - index] = val;
     }
 
@@ -245,10 +251,15 @@ restart:
         if (access_type == MMU_DATA_STORE) {
             base = pte_mkdirty(base);
         }
-        ret1 = loongarch_cmpxchg_phys(cs, phys, pte, base);
+        ret1 = loongarch_cmpxchg_phys(
+            cs, vm_level ? loongarch_get_host_address(env, phys, retaddr) : phys,
+            pte, base);
         /* PTE updated by other CPU, reload PTE entry */
         if (ret1 == MEMTX_DECODE_ERROR) {
-            base = address_space_ldq_le(cs->as, phys, attrs, NULL);
+            base = address_space_ldq_le(
+                cs->as,
+                vm_level ? loongarch_get_host_address(env, phys, retaddr) : phys,
+                attrs, NULL);
             goto restart;
         }
 
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index c02b7c2472..41d6138828 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -724,6 +724,46 @@ static TLBRet loongarch_map_host_address(CPULoongArchState *env, MMUContext *con
     return TLBRET_HOST_MATCH + ret;
 }
 
+static void loongarch_try_ptw(CPULoongArchState *env, MMUContext *context,
+                              MMUAccessType access_type, int mmu_index,
+                              TLBRet *status, bool guest, uintptr_t retaddr)
+{
+    if ((*status == TLBRET_MATCH || *status == TLBRET_HOST_MATCH) &&
+        context->mmu_index != MMU_DA_IDX &&
+        context->mmu_index != MMU_GUEST_DA_IDX && cpu_has_ptw(env, guest)) {
+        bool need_update = true;
+
+        if (access_type == MMU_DATA_STORE && pte_dirty(context->pte)) {
+            need_update = false;
+        } else if (access_type != MMU_DATA_STORE && pte_access(context->pte)) {
+            need_update = false;
+        }
+
+        if (need_update) {
+            *status = (env_vm_level(env) == VM_LEVEL1 &&
+                       !guest) ?
+                      TLBRET_HOST_NOMATCH : TLBRET_NOMATCH;
+        }
+    }
+
+    if (*status != TLBRET_MATCH && *status != TLBRET_HOST_MATCH &&
+        cpu_has_ptw(env, guest)) {
+        if (*status == TLBRET_NOMATCH || *status == TLBRET_INVALID ||
+            *status == TLBRET_HOST_NOMATCH || *status == TLBRET_HOST_INVALID) {
+            *status = ((env_vm_level(env) == VM_LEVEL1 &&
+                        !guest) ?
+                       TLBRET_HOST_MATCH : TLBRET_MATCH) +
+                      loongarch_ptw(env, context, access_type, mmu_index, 0,
+                                    guest, retaddr);
+            if (*status == TLBRET_MATCH || *status == TLBRET_HOST_MATCH) {
+                ptw_update_tlb(env, context, guest);
+            }
+        } else if (context->tlb_index >= 0) {
+            invalidate_tlb(env, context->tlb_index, guest);
+        }
+    }
+}
+
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr)
@@ -739,42 +779,8 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     context.addr = address;
     context.tlb_index = -1;
     ret = get_physical_address(env, &context, access_type, mmu_idx, 0, retaddr);
-    if (ret == TLBRET_MATCH && context.mmu_index != MMU_DA_IDX
-        && cpu_has_ptw(env, vm_level)) {
-        bool need_update = true;
-
-        if (access_type == MMU_DATA_STORE && pte_dirty(context.pte)) {
-            need_update = false;
-        } else if (access_type != MMU_DATA_STORE && pte_access(context.pte)) {
-            need_update = false;
-
-            /*
-             * FIXME: should context.prot be set without PAGE_WRITE with
-             * pte_write(context.pte) && !pte_dirty(context.pte)??
-             *
-             * Otherwise there will be no loongarch_cpu_tlb_fill() function call
-             * for MMU_DATA_STORE access_type in future since QEMU TLB with
-             * prot PAGE_WRITE is added already
-             */
-        }
-
-        if (need_update) {
-            /* Need update bit A/D in PTE entry, take PTW again */
-            ret = TLBRET_NOMATCH;
-        }
-    }
-
-    if (ret != TLBRET_MATCH && cpu_has_ptw(env, vm_level)) {
-        /* Take HW PTW if TLB missed or bit P is zero */
-        if (ret == TLBRET_NOMATCH || ret == TLBRET_INVALID) {
-            ret = loongarch_ptw(env, &context, access_type, mmu_idx, 0, vm_level, retaddr);
-            if (ret == TLBRET_MATCH) {
-                ptw_update_tlb(env, &context, vm_level);
-            }
-        } else if (context.tlb_index >= 0) {
-            invalidate_tlb(env, context.tlb_index, vm_level);
-        }
-    }
+    loongarch_try_ptw(env, &context, access_type, mmu_idx, &ret, vm_level,
+                      retaddr);
 
     if (ret == TLBRET_MATCH) {
         physical = context.physical;
@@ -784,6 +790,8 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             host_context.tlb_index = -1;
             ret = loongarch_map_host_address(env, &host_context, access_type,
                                              retaddr);
+            loongarch_try_ptw(env, &host_context, access_type, MMU_KERNEL_IDX,
+                              &ret, false, retaddr);
             if (ret != TLBRET_HOST_MATCH) {
                 if (probe) {
                     return false;
@@ -847,6 +855,8 @@ hwaddr loongarch_get_host_address(CPULoongArchState *env, hwaddr gpa,
     host_context.tlb_index = -1;
     ret = loongarch_map_host_address(env, &host_context, MMU_DATA_LOAD,
                                      retaddr);
+    loongarch_try_ptw(env, &host_context, MMU_DATA_LOAD, MMU_KERNEL_IDX,
+                      &ret, false, retaddr);
 
     if (ret != TLBRET_HOST_MATCH) {
         raise_mmu_exception(env, gpa, MMU_DATA_LOAD, ret);
-- 
2.55.0


