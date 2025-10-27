Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77613CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMNp-0007zg-Ly; Mon, 27 Oct 2025 08:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1vDMNa-0007vd-IY; Mon, 27 Oct 2025 08:31:19 -0400
Received: from forward100d.mail.yandex.net ([178.154.239.211])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1vDMNN-0005GV-QQ; Mon, 27 Oct 2025 08:31:18 -0400
Received: from mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:2dcb:0:640:715b:0])
 by forward100d.mail.yandex.net (Yandex) with ESMTPS id 88BF2C0078;
 Mon, 27 Oct 2025 15:30:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id nUbd1g4LwiE0-Yf4yUAVy; 
 Mon, 27 Oct 2025 15:30:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1761568253; bh=0ruCynER2fx+XzDv67JuBfRifuqQ4/5gf7ZRpqK95WE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LwM0z8pLumISlAmS/6kKhEC6dLT3H/AmNxNuN5YWc78t2GGlhQhWkGp0G2F9zIIGR
 EjA157F6ie1li04ZKQ+RAj2OitpkfUWYVP+yebVcolYIzKsNMW+OB+CBcFjeIu+KFL
 nK0HO2L3Z6OyoAIiUkS+7qpN7rCrYm9youehxwcg=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Danila Zhebryakov <d.zhebryakov@yandex.ru>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Chinmay Rath <rathc@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Danila Zhebryakov <d.zhebryakov@yandex.ru>
Subject: [PATCH v4 2/4] target/ppc: refactor MMU helpers
Date: Mon, 27 Oct 2025 15:30:46 +0300
Message-ID: <20251027123049.32038-3-d.zhebryakov@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027123049.32038-1-d.zhebryakov@yandex.ru>
References: <20251027123049.32038-1-d.zhebryakov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.211;
 envelope-from=d.zhebryakov@yandex.ru; helo=forward100d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Changed most of the PPC MMU helpers to take CPUTLBEntryFull* instead of pointers to real address, prot and size.
This is needed at least for booke206 MMU to support LE bits (which need to set TLB_BSWAP in tlb_fill_flags), but also seems reasonable to do to other MMUs for consistency.
This should not change any behavior at all.

Signed-off-by: Danila Zhebryakov <d.zhebryakov@yandex.ru>
---
 (In case the previous letter gets lost or unnoticed: 'full' was chosen as a variable name for consistency with other places, such as cputlb.c, where 'full' is the name of all variables with meaning "THE CPUTLBEntryFull in question") 

 target/ppc/internal.h    |  3 +-
 target/ppc/mmu-booke.c   | 63 +++++++++++++++++----------------
 target/ppc/mmu-booke.h   |  2 +-
 target/ppc/mmu-hash32.c  | 30 +++++++++-------
 target/ppc/mmu-hash32.h  |  3 +-
 target/ppc/mmu-hash64.c  | 14 ++++----
 target/ppc/mmu-hash64.h  |  2 +-
 target/ppc/mmu-radix64.c | 20 +++++++----
 target/ppc/mmu-radix64.h |  2 +-
 target/ppc/mmu_common.c  | 75 ++++++++++++++++++++--------------------
 target/ppc/mmu_helper.c  | 15 ++++----
 11 files changed, 121 insertions(+), 108 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 7723350227..81f9a9f2cf 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -246,8 +246,7 @@ static inline int check_prot_access_type(int prot, MMUAccessType access_type)
 /* PowerPC MMU emulation */
 
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
-                      hwaddr *raddrp, int *psizep, int *protp,
-                      int mmu_idx, bool guest_visible);
+               CPUTLBEntryFull *full, int mmu_idx, bool guest_visible);
 
 /* Software driven TLB helpers */
 int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
index 55e5dd7c6b..10ba8052d4 100644
--- a/target/ppc/mmu-booke.c
+++ b/target/ppc/mmu-booke.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "mmu-booke.h"
+#include "exec/tlb-flags.h"
 
 /* Generic TLB check function for embedded PowerPC implementations */
 static bool ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
@@ -155,10 +156,10 @@ static bool mmubooke_check_pid(CPUPPCState *env, ppcemb_tlb_t *tlb,
 }
 
 static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
-                              hwaddr *raddr, int *prot, target_ulong address,
+                              CPUTLBEntryFull *full, target_ulong address,
                               MMUAccessType access_type, int i)
 {
-    if (!mmubooke_check_pid(env, tlb, raddr, address, i)) {
+    if (!mmubooke_check_pid(env, tlb, &(full->phys_addr), address, i)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__);
         return -1;
     }
@@ -172,21 +173,22 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     }
 
     if (FIELD_EX64(env->msr, MSR, PR)) {
-        *prot = tlb->prot & 0xF;
+        full->prot = tlb->prot & 0xF;
     } else {
-        *prot = (tlb->prot >> 4) & 0xF;
+        full->prot = (tlb->prot >> 4) & 0xF;
     }
-    if (check_prot_access_type(*prot, access_type)) {
+    if (check_prot_access_type(full->prot, access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
         return 0;
     }
 
-    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *prot);
+    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, full->prot);
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
-static int mmubooke_get_physical_address(CPUPPCState *env, hwaddr *raddr,
-                                         int *prot, target_ulong address,
+static int mmubooke_get_physical_address(CPUPPCState *env,
+                                         CPUTLBEntryFull *full,
+                                         target_ulong address,
                                          MMUAccessType access_type)
 {
     ppcemb_tlb_t *tlb;
@@ -194,7 +196,7 @@ static int mmubooke_get_physical_address(CPUPPCState *env, hwaddr *raddr,
 
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
-        ret = mmubooke_check_tlb(env, tlb, raddr, prot, address,
+        ret = mmubooke_check_tlb(env, tlb, full, address,
                                  access_type, i);
         if (ret != -1) {
             break;
@@ -203,7 +205,8 @@ static int mmubooke_get_physical_address(CPUPPCState *env, hwaddr *raddr,
     qemu_log_mask(CPU_LOG_MMU,
                   "%s: access %s " TARGET_FMT_lx " => " HWADDR_FMT_plx
                   " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
-                  address, ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
+                  address, ret < 0 ? -1 : full->phys_addr,
+                  ret == -1 ? 0 : full->prot, ret);
     return ret;
 }
 
@@ -307,8 +310,7 @@ static bool mmubooke206_get_as(CPUPPCState *env,
 
 /* Check if the tlb found by hashing really matches */
 static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
-                                 hwaddr *raddr, int *prot,
-                                 target_ulong address,
+                                 CPUTLBEntryFull *full, target_ulong address,
                                  MMUAccessType access_type, int mmu_idx)
 {
     uint32_t epid;
@@ -316,24 +318,25 @@ static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
     bool use_epid = mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
 
     if (!use_epid) {
-        if (ppcmas_tlb_check(env, tlb, raddr, address,
+        if (ppcmas_tlb_check(env, tlb, &(full->phys_addr), address,
                              env->spr[SPR_BOOKE_PID]) >= 0) {
             goto found_tlb;
         }
 
         if (env->spr[SPR_BOOKE_PID1] &&
-            ppcmas_tlb_check(env, tlb, raddr, address,
+            ppcmas_tlb_check(env, tlb, &(full->phys_addr), address,
                              env->spr[SPR_BOOKE_PID1]) >= 0) {
             goto found_tlb;
         }
 
         if (env->spr[SPR_BOOKE_PID2] &&
-            ppcmas_tlb_check(env, tlb, raddr, address,
+            ppcmas_tlb_check(env, tlb, &(full->phys_addr), address,
                              env->spr[SPR_BOOKE_PID2]) >= 0) {
             goto found_tlb;
         }
     } else {
-        if (ppcmas_tlb_check(env, tlb, raddr, address, epid) >= 0) {
+        if (ppcmas_tlb_check(env, tlb, &(full->phys_addr),
+                             address, epid) >= 0) {
             goto found_tlb;
         }
     }
@@ -356,7 +359,9 @@ found_tlb:
         return -1;
     }
 
+    uint8_t *prot = &(full->prot);
     *prot = 0;
+
     if (pr) {
         if (tlb->mas7_3 & MAS3_UR) {
             *prot |= PAGE_READ;
@@ -387,8 +392,9 @@ found_tlb:
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
-static int mmubooke206_get_physical_address(CPUPPCState *env, hwaddr *raddr,
-                                            int *prot, target_ulong address,
+static int mmubooke206_get_physical_address(CPUPPCState *env,
+                                            CPUTLBEntryFull *full,
+                                            target_ulong address,
                                             MMUAccessType access_type,
                                             int mmu_idx)
 {
@@ -402,7 +408,7 @@ static int mmubooke206_get_physical_address(CPUPPCState *env, hwaddr *raddr,
             if (!tlb) {
                 continue;
             }
-            ret = mmubooke206_check_tlb(env, tlb, raddr, prot, address,
+            ret = mmubooke206_check_tlb(env, tlb, full, address,
                                         access_type, mmu_idx);
             if (ret != -1) {
                 goto found_tlb;
@@ -415,7 +421,8 @@ found_tlb:
     qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
                   HWADDR_FMT_plx " %d %d\n", __func__,
                   ret < 0 ? "refused" : "granted", address,
-                  ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
+                  ret < 0 ? -1 : full->phys_addr,
+                  ret == -1 ? 0 : full->prot, ret);
     return ret;
 }
 
@@ -474,27 +481,25 @@ static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
 }
 
 bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
-                     hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
+                     CPUTLBEntryFull *full, int mmu_idx,
                      bool guest_visible)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    hwaddr raddr;
-    int prot, ret;
+    int ret;
 
     if (env->mmu_model == POWERPC_MMU_BOOKE206) {
-        ret = mmubooke206_get_physical_address(env, &raddr, &prot, eaddr,
+        ret = mmubooke206_get_physical_address(env, full, eaddr,
                                                access_type, mmu_idx);
     } else {
-        ret = mmubooke_get_physical_address(env, &raddr, &prot, eaddr,
-                                            access_type);
+        ret = mmubooke_get_physical_address(env, full, eaddr, access_type);
     }
     if (ret == 0) {
-        *raddrp = raddr;
-        *protp = prot;
-        *psizep = TARGET_PAGE_BITS;
+        full->lg_page_size = TARGET_PAGE_BITS;
         return true;
     } else if (!guest_visible) {
+        full->prot = 0;
+        full->phys_addr = 0;
         return false;
     }
 
diff --git a/target/ppc/mmu-booke.h b/target/ppc/mmu-booke.h
index f972843bbb..4d15ddd176 100644
--- a/target/ppc/mmu-booke.h
+++ b/target/ppc/mmu-booke.h
@@ -11,7 +11,7 @@ hwaddr booke206_tlb_to_page_size(CPUPPCState *env, ppcmas_tlb_t *tlb);
 int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
                      target_ulong address, uint32_t pid);
 bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
-                     hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
+                     CPUTLBEntryFull *full, int mmu_idx,
                      bool guest_visible);
 
 #endif
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 8b980a5aa9..469ebbc883 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -292,7 +292,7 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
 }
 
 bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
-                      hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
+                      CPUTLBEntryFull *full, int mmu_idx,
                       bool guest_visible)
 {
     CPUState *cs = CPU(cpu);
@@ -301,24 +301,26 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     hwaddr pte_offset, raddr;
     ppc_hash_pte32_t pte;
     bool key;
-    int prot;
+    int prot = 0;
 
     /* There are no hash32 large pages. */
-    *psizep = TARGET_PAGE_BITS;
+    full->lg_page_size = TARGET_PAGE_BITS;
 
     /* 1. Handle real mode accesses */
     if (mmuidx_real(mmu_idx)) {
         /* Translation is off */
-        *raddrp = eaddr;
-        *protp = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        full->phys_addr = eaddr;
+        full->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         return true;
     }
 
     /* 2. Check Block Address Translation entries (BATs) */
     if (env->nb_BATs != 0) {
-        raddr = ppc_hash32_bat_lookup(cpu, eaddr, access_type, protp, mmu_idx);
+        raddr = ppc_hash32_bat_lookup(cpu, eaddr, access_type, &prot, mmu_idx);
+        full->prot = prot;
+
         if (raddr != -1) {
-            if (!check_prot_access_type(*protp, access_type)) {
+            if (!check_prot_access_type(full->prot, access_type)) {
                 if (guest_visible) {
                     if (access_type == MMU_INST_FETCH) {
                         cs->exception_index = POWERPC_EXCP_ISI;
@@ -336,7 +338,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                 }
                 return false;
             }
-            *raddrp = raddr;
+            full->phys_addr = raddr;
             return true;
         }
     }
@@ -347,7 +349,9 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     /* 4. Handle direct store segments */
     if (sr & SR32_T) {
         return ppc_hash32_direct_store(cpu, sr, eaddr, access_type,
-                                       raddrp, protp, mmu_idx, guest_visible);
+                                       &(full->phys_addr), &prot, mmu_idx,
+                                       guest_visible);
+        full->prot = prot;
     }
 
     /* 5. Check for segment level no-execute violation */
@@ -425,11 +429,11 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
             prot &= ~PAGE_WRITE;
         }
     }
-    *protp = prot;
+    full->prot = prot;
 
     /* 9. Determine the real address from the PTE */
-    *raddrp = pte.pte1 & HPTE32_R_RPN;
-    *raddrp &= TARGET_PAGE_MASK;
-    *raddrp |= eaddr & ~TARGET_PAGE_MASK;
+    full->phys_addr = pte.pte1 & HPTE32_R_RPN;
+    full->phys_addr &= TARGET_PAGE_MASK;
+    full->phys_addr |= eaddr & ~TARGET_PAGE_MASK;
     return true;
 }
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 04c23ea75e..dd9da7729b 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -6,8 +6,7 @@
 #include "system/memory.h"
 
 bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
-                      hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
-                      bool guest_visible);
+                      CPUTLBEntryFull *full, int mmu_idx, bool guest_visible);
 
 /*
  * Segment register definitions
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index dd337558aa..2927be8144 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -980,7 +980,7 @@ static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
 }
 
 bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
-                      hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
+                      CPUTLBEntryFull *full, int mmu_idx,
                       bool guest_visible)
 {
     CPUState *cs = CPU(cpu);
@@ -1063,9 +1063,9 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
             raddr |= env->spr[SPR_RMOR];
         }
 
-        *raddrp = raddr;
-        *protp = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        *psizep = TARGET_PAGE_BITS;
+        full->phys_addr = raddr;
+        full->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        full->lg_page_size = TARGET_PAGE_BITS;
         return true;
     }
 
@@ -1201,9 +1201,9 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 
     /* 7. Determine the real address from the PTE */
 
-    *raddrp = deposit64(pte.pte1 & HPTE64_R_RPN, 0, apshift, eaddr);
-    *protp = prot;
-    *psizep = apshift;
+    full->phys_addr = deposit64(pte.pte1 & HPTE64_R_RPN, 0, apshift, eaddr);
+    full->prot = prot;
+    full->lg_page_size = apshift;
     return true;
 }
 
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index ae8d4b37ae..8e51b220a8 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -8,7 +8,7 @@ void dump_slb(PowerPCCPU *cpu);
 int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
                   target_ulong esid, target_ulong vsid);
 bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
-                      hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
+                      CPUTLBEntryFull *full, int mmu_idx,
                       bool guest_visible);
 void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
                                target_ulong pte_index,
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 33ac341290..b358f724e3 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -820,20 +820,26 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, vaddr eaddr,
 }
 
 bool ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
-                       hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
+                       CPUTLBEntryFull *full, int mmu_idx,
                        bool guest_visible)
 {
-    bool ret = ppc_radix64_xlate_impl(cpu, eaddr, access_type, raddrp,
-                                      psizep, protp, mmu_idx, guest_visible);
+    int prot = 0, psize = 0;
+    hwaddr raddr = 0;
+    bool ret = ppc_radix64_xlate_impl(cpu, eaddr, access_type, &raddr,
+                                      &psize, &prot, mmu_idx, guest_visible);
+
+    full->phys_addr = raddr;
+    full->prot = prot;
+    full->lg_page_size = psize;
 
     qemu_log_mask(CPU_LOG_MMU, "%s for %s @0x%"VADDR_PRIx
                   " mmu_idx %u (prot %c%c%c) -> 0x%"HWADDR_PRIx"\n",
                   __func__, access_str(access_type),
                   eaddr, mmu_idx,
-                  *protp & PAGE_READ ? 'r' : '-',
-                  *protp & PAGE_WRITE ? 'w' : '-',
-                  *protp & PAGE_EXEC ? 'x' : '-',
-                  *raddrp);
+                  prot & PAGE_READ ? 'r' : '-',
+                  prot & PAGE_WRITE ? 'w' : '-',
+                  prot & PAGE_EXEC ? 'x' : '-',
+                  raddr);
 
     return ret;
 }
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
index 6620b3d648..ef7a125efe 100644
--- a/target/ppc/mmu-radix64.h
+++ b/target/ppc/mmu-radix64.h
@@ -15,7 +15,7 @@
 #define R_EADDR_QUADRANT3       0xC000000000000000
 
 bool ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
-                       hwaddr *raddr, int *psizep, int *protp, int mmu_idx,
+                       CPUTLBEntryFull *full, int mmu_idx,
                        bool guest_visible);
 
 #endif /* TARGET_PPC64 */
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 52d48615ac..3edee61b3b 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -85,7 +85,7 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
 
 /* Software driven TLB helpers */
 
-static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, int *prot,
+static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, uint8_t *prot,
                             target_ulong eaddr, MMUAccessType access_type,
                             target_ulong ptem, bool key, bool nx)
 {
@@ -187,7 +187,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, int *prot,
     return ret;
 }
 
-static int get_bat_6xx_tlb(CPUPPCState *env, hwaddr *raddr, int *prot,
+static int get_bat_6xx_tlb(CPUPPCState *env, hwaddr *raddr, uint8_t *prot,
                            target_ulong eaddr, MMUAccessType access_type,
                            bool pr)
 {
@@ -259,7 +259,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, hwaddr *raddr, int *prot,
 }
 
 static int mmu6xx_get_physical_address(CPUPPCState *env, hwaddr *raddr,
-                                       int *prot, target_ulong eaddr,
+                                       uint8_t *prot, target_ulong eaddr,
                                        hwaddr *hashp, bool *keyp,
                                        MMUAccessType access_type, int type)
 {
@@ -583,15 +583,15 @@ void dump_mmu(CPUPPCState *env)
 
 static bool ppc_real_mode_xlate(PowerPCCPU *cpu, vaddr eaddr,
                                 MMUAccessType access_type,
-                                hwaddr *raddrp, int *psizep, int *protp)
+                                CPUTLBEntryFull *full)
 {
     CPUPPCState *env = &cpu->env;
 
     if (access_type == MMU_INST_FETCH ? !FIELD_EX64(env->msr, MSR, IR)
                                       : !FIELD_EX64(env->msr, MSR, DR)) {
-        *raddrp = eaddr;
-        *protp = PAGE_RWX;
-        *psizep = TARGET_PAGE_BITS;
+        full->phys_addr = eaddr;
+        full->prot = PAGE_RWX;
+        full->lg_page_size = TARGET_PAGE_BITS;
         return true;
     } else if (env->mmu_model == POWERPC_MMU_REAL) {
         cpu_abort(CPU(cpu), "PowerPC in real mode shold not do translation\n");
@@ -600,21 +600,24 @@ static bool ppc_real_mode_xlate(PowerPCCPU *cpu, vaddr eaddr,
 }
 
 static bool ppc_40x_xlate(PowerPCCPU *cpu, vaddr eaddr,
-                          MMUAccessType access_type,
-                          hwaddr *raddrp, int *psizep, int *protp,
+                          MMUAccessType access_type, CPUTLBEntryFull *full,
                           int mmu_idx, bool guest_visible)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     int ret;
 
-    if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
+    if (ppc_real_mode_xlate(cpu, eaddr, access_type, full)) {
         return true;
     }
 
-    ret = mmu40x_get_physical_address(env, raddrp, protp, eaddr, access_type);
+    int prot = 0;
+    ret = mmu40x_get_physical_address(env, &(full->phys_addr), &prot,
+                                      eaddr, access_type);
+    full->prot = prot;
+
     if (ret == 0) {
-        *psizep = TARGET_PAGE_BITS;
+        full->lg_page_size = TARGET_PAGE_BITS;
         return true;
     } else if (!guest_visible) {
         return false;
@@ -668,8 +671,7 @@ static bool ppc_40x_xlate(PowerPCCPU *cpu, vaddr eaddr,
 }
 
 static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
-                          MMUAccessType access_type,
-                          hwaddr *raddrp, int *psizep, int *protp,
+                          MMUAccessType access_type, CPUTLBEntryFull *full,
                           int mmu_idx, bool guest_visible)
 {
     CPUState *cs = CPU(cpu);
@@ -678,7 +680,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
     bool key;
     int type, ret;
 
-    if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
+    if (ppc_real_mode_xlate(cpu, eaddr, access_type, full)) {
         return true;
     }
 
@@ -692,10 +694,10 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
         type = ACCESS_INT;
     }
 
-    ret = mmu6xx_get_physical_address(env, raddrp, protp, eaddr, &hash, &key,
-                                      access_type, type);
+    ret = mmu6xx_get_physical_address(env, &(full->phys_addr), &(full->prot),
+                                      eaddr, &hash, &key, access_type, type);
     if (ret == 0) {
-        *psizep = TARGET_PAGE_BITS;
+        full->lg_page_size = TARGET_PAGE_BITS;
         return true;
     } else if (!guest_visible) {
         return false;
@@ -806,15 +808,14 @@ tlb_miss:
 /*****************************************************************************/
 
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
-                      hwaddr *raddrp, int *psizep, int *protp,
-                      int mmu_idx, bool guest_visible)
+               CPUTLBEntryFull *full, int mmu_idx, bool guest_visible)
 {
     switch (cpu->env.mmu_model) {
 #if defined(TARGET_PPC64)
     case POWERPC_MMU_3_00:
         if (ppc64_v3_radix(cpu)) {
-            return ppc_radix64_xlate(cpu, eaddr, access_type, raddrp,
-                                     psizep, protp, mmu_idx, guest_visible);
+            return ppc_radix64_xlate(cpu, eaddr, access_type,
+                                     full, mmu_idx, guest_visible);
         }
         /* fall through */
     case POWERPC_MMU_64B:
@@ -822,25 +823,24 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_2_06:
     case POWERPC_MMU_2_07:
         return ppc_hash64_xlate(cpu, eaddr, access_type,
-                                raddrp, psizep, protp, mmu_idx, guest_visible);
+                                full, mmu_idx, guest_visible);
 #endif
 
     case POWERPC_MMU_32B:
-        return ppc_hash32_xlate(cpu, eaddr, access_type, raddrp,
-                               psizep, protp, mmu_idx, guest_visible);
+        return ppc_hash32_xlate(cpu, eaddr, access_type, full,
+                                mmu_idx, guest_visible);
     case POWERPC_MMU_BOOKE:
     case POWERPC_MMU_BOOKE206:
-        return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
-                               psizep, protp, mmu_idx, guest_visible);
+        return ppc_booke_xlate(cpu, eaddr, access_type,
+                               full, mmu_idx, guest_visible);
     case POWERPC_MMU_SOFT_4xx:
-        return ppc_40x_xlate(cpu, eaddr, access_type, raddrp,
-                             psizep, protp, mmu_idx, guest_visible);
+        return ppc_40x_xlate(cpu, eaddr, access_type,
+                             full, mmu_idx, guest_visible);
     case POWERPC_MMU_SOFT_6xx:
-        return ppc_6xx_xlate(cpu, eaddr, access_type, raddrp,
-                             psizep, protp, mmu_idx, guest_visible);
+        return ppc_6xx_xlate(cpu, eaddr, access_type,
+                             full, mmu_idx, guest_visible);
     case POWERPC_MMU_REAL:
-        return ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep,
-                                   protp);
+        return ppc_real_mode_xlate(cpu, eaddr, access_type, full);
     case POWERPC_MMU_MPC8xx:
         cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implemented\n");
     default:
@@ -851,19 +851,18 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-    hwaddr raddr;
-    int s, p;
+    CPUTLBEntryFull full = {};
 
     /*
      * Some MMUs have separate TLBs for code and data. If we only
      * try an MMU_DATA_LOAD, we may not be able to read instructions
      * mapped by code TLBs, so we also try a MMU_INST_FETCH.
      */
-    if (ppc_xlate(cpu, addr, MMU_DATA_LOAD, &raddr, &s, &p,
+    if (ppc_xlate(cpu, addr, MMU_DATA_LOAD, &full,
                   ppc_env_mmu_index(&cpu->env, false), false) ||
-        ppc_xlate(cpu, addr, MMU_INST_FETCH, &raddr, &s, &p,
+        ppc_xlate(cpu, addr, MMU_INST_FETCH, &full,
                   ppc_env_mmu_index(&cpu->env, true), false)) {
-        return raddr & TARGET_PAGE_MASK;
+        return full.phys_addr & TARGET_PAGE_MASK;
     }
     return -1;
 }
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index ac60705402..85815196eb 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1363,13 +1363,14 @@ bool ppc_cpu_tlb_fill(CPUState *cs, vaddr eaddr, int size,
                       bool probe, uintptr_t retaddr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-    hwaddr raddr;
-    int page_size, prot;
-
-    if (ppc_xlate(cpu, eaddr, access_type, &raddr,
-                  &page_size, &prot, mmu_idx, !probe)) {
-        tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
-                     prot, mmu_idx, 1UL << page_size);
+    CPUTLBEntryFull full = {
+        .attrs = MEMTXATTRS_UNSPECIFIED
+    };
+
+    if (ppc_xlate(cpu, eaddr, access_type,
+                  &full, mmu_idx, !probe)) {
+        full.phys_addr &= TARGET_PAGE_MASK;
+        tlb_set_page_full(cs, mmu_idx, eaddr & TARGET_PAGE_MASK, &full);
         return true;
     }
     if (probe) {
-- 
2.47.3


