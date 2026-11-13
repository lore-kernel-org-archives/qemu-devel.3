Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB835606A894
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmx1-00047I-OW; Fri, 13 Nov 2026 03:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvf-0002z0-28
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:39 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvd-0007Qv-6u
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:38 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id A331C1DD;
 Fri, 13 Nov 2026 14:16:35 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 18/26] target/loongarch: add LVZ to ptw
Date: Fri, 13 Nov 2026 16:45:33 +0800
Message-ID: <71aaa6db9eaaf8cd07e483dc0a0d5eef9fb721bb.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add function loongarch_try_ptw() and use it in both vm level 0 and 1 address
mapping.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-mmu.h        |  2 +-
 target/loongarch/cpu_helper.c     |  6 +--
 target/loongarch/tcg/tlb_helper.c | 64 +++++++++++++++++--------------
 3 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 20fe1cd836..9c65d790b5 100644
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
index 245bb24b35..80ee656d0e 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -124,11 +124,11 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
     uint64_t dir_base, dir_width;
     uint64_t base, pte, old;
     int vm_level = mmu_idx_vm_level(mmu_idx);
-    int level, ptw_idx = MMU_DA_IDX;
+    int level, ptw_idx = vm_level ? MMU_GUEST_DA_IDX : MMU_DA_IDX;
     vaddr address;
     TLBRet ret;
-    CPUSysState *sys = env_sys(env);
     MemOpIdx oi;
+    CPUSysState *sys = get_sys(env, vm_level);
 
     address = context->addr;
     if ((address >> 63) & 0x1) {
@@ -148,7 +148,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
         /* get next level page directory */
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
-        base = cpu_ldq_le_mmuidx_ra(env, phys, ptw_idx, GETPC());
+		base = cpu_ldq_le_mmuidx_ra(env, phys, ptw_idx, GETPC());
         if (level) {
             if (FIELD_EX64(base, TLBENTRY, HUGE)) {
                 /* base is a huge pte */
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 1248b44a46..fd3041a877 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -717,6 +717,40 @@ static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context,
     update_tlb_index(env, context, index, vm_level);
 }
 
+static void loongarch_try_ptw(CPULoongArchState *env, MMUContext *context,
+                              MMUAccessType access_type, int mmu_index,
+                              TLBRet *status, uintptr_t retaddr)
+{
+    int vm_level = mmu_idx_vm_level(mmu_index);
+
+    if (*status == TLBRET_MATCH && context->mmu_index != MMU_DA_IDX
+        && cpu_has_ptw(env, vm_level)) {
+        bool need_update = true;
+
+        if (access_type == MMU_DATA_STORE && pte_dirty(context->pte)) {
+            need_update = false;
+        } else if (access_type != MMU_DATA_STORE && pte_access(context->pte)) {
+            need_update = false;
+        }
+
+        if (need_update) {
+            *status = TLBRET_NOMATCH;
+        }
+    }
+
+    if (*status != TLBRET_MATCH && cpu_has_ptw(env, vm_level)) {
+        if (*status == TLBRET_NOMATCH || *status == TLBRET_INVALID) {
+            *status = loongarch_ptw(env, context, access_type, mmu_index, 0,
+                                    retaddr);
+            if (*status == TLBRET_MATCH) {
+                ptw_update_tlb(env, context, vm_level);
+            }
+        } else if (context->tlb_index >= 0) {
+            invalidate_tlb(env, context->tlb_index, vm_level);
+        }
+    }
+}
+
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr)
@@ -732,11 +766,11 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     context.tlb_index = -1;
     context.prot = PAGE_RWX;
     int curr_mmu_idx = mmu_idx;
-
     while (1) {
         prot = context.prot;
         ret = get_physical_address(env, &context, access_type, curr_mmu_idx, 0,
                                    retaddr);
+        loongarch_try_ptw(env, &context, access_type, curr_mmu_idx, &ret, retaddr);
         if (ret != TLBRET_MATCH) {
             address = context.addr;
             ret += TLBRET_HOST_MATCH *
@@ -766,34 +800,6 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     }
 
-    if (ret == TLBRET_MATCH && context.mmu_index != MMU_DA_IDX
-        && cpu_has_ptw(env, env_vm_level(env))) {
-        bool need_update = true;
-
-        if (access_type == MMU_DATA_STORE && pte_dirty(context.pte)) {
-            need_update = false;
-        } else if (access_type != MMU_DATA_STORE && pte_access(context.pte)) {
-            need_update = false;
-        }
-
-        if (need_update) {
-            /* Need update bit A/D in PTE entry, take PTW again */
-            ret = TLBRET_NOMATCH;
-        }
-    }
-
-    if (ret != TLBRET_MATCH && cpu_has_ptw(env, env_vm_level(env))) {
-        /* Take HW PTW if TLB missed or bit P is zero */
-        if (ret == TLBRET_NOMATCH || ret == TLBRET_INVALID) {
-            ret = loongarch_ptw(env, &context, access_type, mmu_idx, 0, retaddr);
-            if (ret == TLBRET_MATCH) {
-                ptw_update_tlb(env, &context, env_vm_level(env));
-            }
-        } else if (context.tlb_index >= 0) {
-            invalidate_tlb(env, context.tlb_index, env_vm_level(env));
-        }
-    }
-
     if (ret == TLBRET_MATCH) {
         physical = context.physical;
         prot = context.prot;
-- 
2.56.0


