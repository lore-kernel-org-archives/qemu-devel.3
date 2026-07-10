Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4BCC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi76W-000646-RW; Fri, 10 Jul 2026 05:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wi76U-00060T-Ah
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:01:02 -0400
Received: from [2400:e920:0:e::2c] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wi76M-0004C0-NW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:01:01 -0400
Received: from yuno-loong (unknown [IPv6:2400:e920:0:e::2c])
 by krgm.moe (Postfix) with ESMTPSA id 6679C241FC96;
 Fri, 10 Jul 2026 17:00:40 +0800 (CST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 7/8] target/loongarch: Add LVZ MMU and PTW support
Date: Fri, 10 Jul 2026 17:00:16 +0800
Message-ID: <90f253fe51aa2dda2b481859eb9b459b03c50498.1783673526.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1783673526.git.prcups@krgm.moe>
References: <cover.1783673526.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2400:e920:0:e::2c (failed)
Received-SPF: pass client-ip=2400:e920:0:e::2c; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_SBL_CSS=3.335,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Implement LVZ address translation with separate host and guest TLB banks,
GID matching, guest TLB helpers, LVZ-aware INVT LB handling, two-stage
translation and guest-mode hardware PTW updates through the host mapping.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-mmu.h                    |  39 +-
 target/loongarch/cpu_helper.c                 |  87 ++-
 target/loongarch/tcg/helper.h                 |  17 +-
 .../tcg/insn_trans/trans_privileged.c.inc     |  64 +-
 target/loongarch/tcg/tcg_loongarch.h          |   3 +-
 target/loongarch/tcg/tlb_helper.c             | 577 +++++++++++++-----
 6 files changed, 563 insertions(+), 224 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 54fb732d62..bc1816cd28 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -17,6 +17,14 @@ typedef enum TLBRet {
     TLBRET_RI,
     TLBRET_XI,
     TLBRET_PE,
+    TLBRET_HOST_MATCH,
+    TLBRET_HOST_BADADDR,
+    TLBRET_HOST_NOMATCH,
+    TLBRET_HOST_INVALID,
+    TLBRET_HOST_DIRTY,
+    TLBRET_HOST_RI,
+    TLBRET_HOST_XI,
+    TLBRET_HOST_PE,
 } TLBRet;
 
 typedef struct MMUContext {
@@ -30,18 +38,20 @@ typedef struct MMUContext {
     uint64_t      pte_buddy[2];
 } MMUContext;
 
-static inline bool cpu_has_ptw(CPULoongArchState *env)
+static inline bool cpu_has_ptw(CPULoongArchState *env, bool guest)
 {
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
 
     return !!FIELD_EX64(sys->CSR_PWCH, CSR_PWCH, HPTW_EN);
 }
 
-static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
+static inline bool pte_present(CPULoongArchState *env, uint64_t entry,
+                               bool guest)
 {
     uint8_t present;
 
-    if (cpu_has_ptw(env)) {
+    if (cpu_has_ptw(env, guest)) {
         present = FIELD_EX64(entry, TLBENTRY, P);
     } else {
         present = FIELD_EX64(entry, TLBENTRY, V);
@@ -50,11 +60,12 @@ static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
     return !!present;
 }
 
-static inline bool pte_write(CPULoongArchState *env, uint64_t entry)
+static inline bool pte_write(CPULoongArchState *env, uint64_t entry,
+                             bool guest)
 {
     uint8_t writable;
 
-    if (cpu_has_ptw(env)) {
+    if (cpu_has_ptw(env, guest)) {
         writable = FIELD_EX64(entry, TLBENTRY, W);
     } else {
         writable = FIELD_EX64(entry, TLBENTRY, D);
@@ -91,14 +102,22 @@ static inline bool pte_dirty(uint64_t entry)
 
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
-                           MMUAccessType access_type, int mmu_idx);
+                           MMUAccessType access_type, int mmu_idx, bool guest);
 TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
-                            int is_debug);
+                            int is_debug, uintptr_t retaddr);
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
-                     int access_type, int mmu_idx, int debug);
+                     int access_type, int mmu_idx, int debug, bool guest,
+                     uintptr_t retaddr);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                        uint64_t *dir_width, unsigned int level);
+                        uint64_t *dir_width, unsigned int level, bool guest);
+hwaddr loongarch_get_host_address(CPULoongArchState *env, hwaddr gpa,
+                                  uintptr_t retaddr);
+TLBRet loongarch_map_host_address(CPULoongArchState *env, MMUContext *context,
+                                  MMUAccessType access_type, uintptr_t retaddr);
+TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
+                             MMUAccessType access_type, int mmu_idx,
+                             int is_debug, bool guest, uintptr_t retaddr);
 hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 uint64_t loongarch_palen_mask(CPULoongArchState *env);
 
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 123cad3d93..4da5cfbb85 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -18,10 +18,12 @@
 #include "cpu-mmu.h"
 #include "tcg/tcg_loongarch.h"
 
-void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                        uint64_t *dir_width, unsigned int level)
+static void get_dir_base_width_csr(CPULoongArchState *env, uint64_t *dir_base,
+                                   uint64_t *dir_width, unsigned int level,
+                                   bool guest)
 {
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
 
     switch (level) {
     case 1:
@@ -48,18 +50,24 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
     }
 }
 
+void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
+                        uint64_t *dir_width, unsigned int level, bool guest)
+{
+    get_dir_base_width_csr(env, dir_base, dir_width, level, guest);
+}
+
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
-                           MMUAccessType access_type, int mmu_idx)
+                           MMUAccessType access_type, int mmu_idx, bool guest)
 {
-    uint64_t plv = mmu_idx;
+    uint64_t plv = mmu_idx_to_plv(mmu_idx);
     uint64_t tlb_entry, tlb_ppn;
     uint8_t tlb_ps, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
     bool tlb_v, tlb_d;
 
     tlb_entry = context->pte;
     tlb_ps = context->ps;
-    tlb_v = pte_present(env, tlb_entry);
-    tlb_d = pte_write(env, tlb_entry);
+    tlb_v = pte_present(env, tlb_entry, guest);
+    tlb_d = pte_write(env, tlb_entry, guest);
     tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
     if (is_la64(env)) {
         tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
@@ -101,7 +109,7 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
     context->physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
                         (context->addr & MAKE_64BIT_MASK(0, tlb_ps));
     context->prot = PAGE_READ;
-    context->mmu_index = tlb_plv;
+    context->mmu_index = mmu_idx;
     if (tlb_d) {
         context->prot |= PAGE_WRITE;
     }
@@ -147,7 +155,8 @@ static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
 }
 
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
-                     int access_type, int mmu_idx, int debug)
+                     int access_type, int mmu_idx, int debug, bool guest,
+                     uintptr_t retaddr)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     CPUState *cs = env_cpu(env);
@@ -159,7 +168,8 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
     vaddr address;
     TLBRet ret;
     MemTxResult ret1;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
 
     address = context->addr;
     if ((address >> 63) & 0x1) {
@@ -170,7 +180,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
     base &= palen_mask;
 
     for (level = 4; level >= 0; level--) {
-        get_dir_base_width(env, &dir_base, &dir_width, level);
+        get_dir_base_width(env, &dir_base, &dir_width, level, guest);
 
         if (dir_width == 0) {
             continue;
@@ -179,7 +189,10 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
         /* get next level page directory */
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
-        base = address_space_ldq_le(cs->as, phys, attrs, NULL);
+        base = address_space_ldq_le(
+            cs->as,
+            guest ? loongarch_get_host_address(env, phys, retaddr) : phys,
+            attrs, NULL);
         if (level) {
             if (FIELD_EX64(base, TLBENTRY, HUGE)) {
                 /* base is a huge pte */
@@ -208,19 +221,22 @@ restart:
         context->pte_buddy[index] = base;
         context->pte_buddy[1 - index] = base + BIT_ULL(dir_base);
         base += (BIT_ULL(dir_base) & address);
-    } else if (cpu_has_ptw(env)) {
+    } else if (cpu_has_ptw(env, guest)) {
         uint64_t val;
 
         index &= 1;
         context->pte_buddy[index] = base;
-        val = address_space_ldq_le(cs->as, phys + 8 * (1 - 2 * index),
-                                   attrs, NULL);
+        val = address_space_ldq_le(
+            cs->as,
+            (guest ? loongarch_get_host_address(env, phys, retaddr) : phys) +
+                8 * (1 - 2 * index),
+            attrs, NULL);
         context->pte_buddy[1 - index] = val;
     }
 
     context->ps = dir_base;
     context->pte = base;
-    ret = loongarch_check_pte(env, context, access_type, mmu_idx);
+    ret = loongarch_check_pte(env, context, access_type, mmu_idx, guest);
     if (debug) {
         return ret;
     }
@@ -231,7 +247,7 @@ restart:
      * Need atomic compchxg operation with pte update, other vCPUs may
      * update pte at the same time.
      */
-    if (ret == TLBRET_MATCH && cpu_has_ptw(env)) {
+    if (ret == TLBRET_MATCH && cpu_has_ptw(env, guest)) {
         if (access_type == MMU_DATA_STORE && pte_dirty(base)) {
             return ret;
         }
@@ -244,10 +260,15 @@ restart:
         if (access_type == MMU_DATA_STORE) {
             base = pte_mkdirty(base);
         }
-        ret1 = loongarch_cmpxchg_phys(cs, phys, pte, base);
+        ret1 = loongarch_cmpxchg_phys(
+            cs, guest ? loongarch_get_host_address(env, phys, retaddr) : phys,
+            pte, base);
         /* PTE updated by other CPU, reload PTE entry */
         if (ret1 == MEMTX_DECODE_ERROR) {
-            base = address_space_ldq_le(cs->as, phys, attrs, NULL);
+            base = address_space_ldq_le(
+                cs->as,
+                guest ? loongarch_get_host_address(env, phys, retaddr) : phys,
+                attrs, NULL);
             goto restart;
         }
 
@@ -273,15 +294,15 @@ restart:
     return ret;
 }
 
-static TLBRet loongarch_map_address(CPULoongArchState *env,
-                                    MMUContext *context,
-                                    MMUAccessType access_type, int mmu_idx,
-                                    int is_debug)
+TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
+                             MMUAccessType access_type, int mmu_idx,
+                             int is_debug, bool guest, uintptr_t retaddr)
 {
     TLBRet ret;
 
     if (tcg_enabled()) {
-        ret = loongarch_get_addr_from_tlb(env, context, access_type, mmu_idx);
+        ret = loongarch_get_addr_from_tlb(env, context, access_type, mmu_idx,
+                                          guest);
         if (ret != TLBRET_NOMATCH) {
             return ret;
         }
@@ -293,7 +314,8 @@ static TLBRet loongarch_map_address(CPULoongArchState *env,
          * legal mapping, even if the mapping is not yet in TLB. return 0 if
          * there is a valid map, else none zero.
          */
-        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug);
+        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug,
+                             guest, retaddr);
     }
 
     return TLBRET_NOMATCH;
@@ -312,13 +334,15 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, uint64_t dmw)
 
 TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
-                            int is_debug)
+                            int is_debug, uintptr_t retaddr)
 {
-    int user_mode = mmu_idx == MMU_USER_IDX;
-    int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
+    bool guest = env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST;
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
+    int user_mode = mmu_idx_to_plv(mmu_idx) == MMU_USER_IDX;
+    int kernel_mode = mmu_idx_to_plv(mmu_idx) == MMU_KERNEL_IDX;
     uint32_t plv, base_c, base_v;
     int64_t addr_high;
-    CPUSysState *sys = env_sys(env);
     uint8_t da = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, DA);
     uint8_t pg = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG);
     vaddr address;
@@ -360,7 +384,8 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     }
 
     /* Mapped address */
-    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug);
+    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug,
+                                 guest, retaddr);
 }
 
 hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
@@ -370,7 +395,7 @@ hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     context.addr = addr;
     if (get_physical_address(env, &context, MMU_DATA_LOAD,
-                             cpu_mmu_index(cs, false), 1) != TLBRET_MATCH) {
+                             cpu_mmu_index(cs, false), 1, 0) != TLBRET_MATCH) {
         return -1;
     }
     return context.physical;
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 69f6cb352a..648328a7ef 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -133,11 +133,18 @@ DEF_HELPER_1(tlbsrch, void, env)
 DEF_HELPER_1(tlbrd, void, env)
 DEF_HELPER_1(tlbclr, void, env)
 DEF_HELPER_1(tlbflush, void, env)
-DEF_HELPER_1(invtlb_all, void, env)
-DEF_HELPER_2(invtlb_all_g, void, env, i32)
-DEF_HELPER_2(invtlb_all_asid, void, env, tl)
-DEF_HELPER_3(invtlb_page_asid, void, env, tl, tl)
-DEF_HELPER_3(invtlb_page_asid_or_g, void, env, tl, tl)
+DEF_HELPER_4(invtlb_all, void, env, tl, i32, i32)
+DEF_HELPER_4(invtlb_all_g, void, env, tl, i32, i32)
+DEF_HELPER_3(invtlb_all_asid, void, env, tl, i32)
+DEF_HELPER_4(invtlb_page_asid, void, env, tl, tl, i32)
+DEF_HELPER_4(invtlb_page_asid_or_g, void, env, tl, tl, i32)
+
+DEF_HELPER_1(gtlbwr, void, env)
+DEF_HELPER_1(gtlbfill, void, env)
+DEF_HELPER_1(gtlbsrch, void, env)
+DEF_HELPER_1(gtlbrd, void, env)
+DEF_HELPER_1(gtlbclr, void, env)
+DEF_HELPER_1(gtlbflush, void, env)
 
 DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
 DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 2094d182ac..48a42779d3 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -316,25 +316,63 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
         return false;
     }
 
+    if (!avail_LVZ(ctx) && a->imm > 0x6) {
+        return false;
+    }
+
     switch (a->imm) {
-    case 0:
-    case 1:
-        gen_helper_invtlb_all(tcg_env);
+    case 0x0:
+    case 0x1:
+        gen_helper_invtlb_all(tcg_env, rj, tcg_constant_i32(a->imm),
+                              tcg_constant_i32(0));
+        break;
+    case 0x2:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(1),
+                                tcg_constant_i32(0));
+        break;
+    case 0x3:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(0),
+                                tcg_constant_i32(0));
+        break;
+    case 0x4:
+        gen_helper_invtlb_all_asid(tcg_env, rj, tcg_constant_i32(0));
+        break;
+    case 0x5:
+        gen_helper_invtlb_page_asid(tcg_env, rj, rk, tcg_constant_i32(0));
+        break;
+    case 0x6:
+        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk,
+                                         tcg_constant_i32(0));
+        break;
+    case 0x9:
+    case 0x10:
+    case 0x11:
+    case 0x12:
+    case 0x13:
+    case 0x14:
+    case 0x15:
+    case 0x16:
+        //TODO: refine 0x9-0x16
+        gen_helper_invtlb_all(tcg_env, rj, tcg_constant_i32(0),
+                              tcg_constant_i32(0));
         break;
-    case 2:
-        gen_helper_invtlb_all_g(tcg_env, tcg_constant_i32(1));
+    case 0xa:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(1),
+                                tcg_constant_i32(1));
         break;
-    case 3:
-        gen_helper_invtlb_all_g(tcg_env, tcg_constant_i32(0));
+    case 0xb:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(0),
+                                tcg_constant_i32(1));
         break;
-    case 4:
-        gen_helper_invtlb_all_asid(tcg_env, rj);
+    case 0xc:
+        gen_helper_invtlb_all_asid(tcg_env, rj, tcg_constant_i32(1));
         break;
-    case 5:
-        gen_helper_invtlb_page_asid(tcg_env, rj, rk);
+    case 0xd:
+        gen_helper_invtlb_page_asid(tcg_env, rj, rk, tcg_constant_i32(1));
         break;
-    case 6:
-        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk);
+    case 0xe:
+        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk,
+                                         tcg_constant_i32(1));
         break;
     default:
         return false;
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index 7fb627f2d6..5acaf49d47 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -18,6 +18,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
 TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
                                    MMUContext *context,
-                                   MMUAccessType access_type, int mmu_idx);
+                                   MMUAccessType access_type, int mmu_idx,
+                                   bool guest);
 
 #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a4b90beca6..ddd152a6b6 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/guest-random.h"
-
 #include "cpu.h"
 #include "cpu-mmu.h"
 #include "internals.h"
@@ -18,6 +17,8 @@
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-loop.h"
+#include "accel/tcg/probe.h"
+#include "exec/tlb-flags.h"
 #include "exec/log.h"
 #include "cpu-csr.h"
 #include "tcg/tcg_loongarch.h"
@@ -35,29 +36,49 @@ static bool tlb_match_asid(bool global, int asid, int tlb_asid)
     return !global && tlb_asid == asid;
 }
 
+static inline bool tlb_entry_matches_gid(LoongArchTLB *tlb, uint8_t gid)
+{
+    return FIELD_EX64(tlb->tlb_misc, TLB_MISC, GID) == gid;
+}
+
+static inline LoongArchTLB *tlb_bank(CPULoongArchState *env, bool guest)
+{
+    return sys_state_if(env, guest)->tlb;
+}
+
 bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
 {
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
 
     if (tlb_ps >= 64) {
         return false;
     }
-    return BIT_ULL(tlb_ps) & (sys->CSR_PRCFG2);
+    return BIT_ULL(tlb_ps) & (host->CSR_PRCFG2);
 }
 
 static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
                                 MMUAccessType access_type, TLBRet tlb_error)
 {
     CPUState *cs = env_cpu(env);
-    CPUSysState *sys = env_sys(env);
+    bool real_guest;
+
+    if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST &&
+        tlb_error > TLBRET_HOST_MATCH) {
+        trigger_vm_exit(env);
+    }
+
+    real_guest = !env->vm_exit && env_vm_level(env);
+    CPUSysState *sys = &env->sys_states[real_guest];
 
     switch (tlb_error) {
     default:
     case TLBRET_BADADDR:
+    case TLBRET_HOST_BADADDR:
         cs->exception_index = access_type == MMU_INST_FETCH
                               ? EXCCODE_ADEF : EXCCODE_ADEM;
         break;
     case TLBRET_NOMATCH:
+    case TLBRET_HOST_NOMATCH:
         /* No TLB match for a mapped address */
         if (access_type == MMU_DATA_LOAD) {
             cs->exception_index = EXCCODE_PIL;
@@ -69,6 +90,7 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
         sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
         break;
     case TLBRET_INVALID:
+    case TLBRET_HOST_INVALID:
         /* TLB match with no valid bit */
         if (access_type == MMU_DATA_LOAD) {
             cs->exception_index = EXCCODE_PIL;
@@ -79,24 +101,28 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
         }
         break;
     case TLBRET_DIRTY:
+    case TLBRET_HOST_DIRTY:
         /* TLB match but 'D' bit is cleared */
         cs->exception_index = EXCCODE_PME;
         break;
     case TLBRET_XI:
+    case TLBRET_HOST_XI:
         /* Execute-Inhibit Exception */
         cs->exception_index = EXCCODE_PNX;
         break;
     case TLBRET_RI:
+    case TLBRET_HOST_RI:
         /* Read-Inhibit Exception */
         cs->exception_index = EXCCODE_PNR;
         break;
     case TLBRET_PE:
+    case TLBRET_HOST_PE:
         /* Privileged Exception */
         cs->exception_index = EXCCODE_PPI;
         break;
     }
 
-    if (tlb_error == TLBRET_NOMATCH) {
+    if (tlb_error == TLBRET_NOMATCH || tlb_error == TLBRET_HOST_NOMATCH) {
         sys->CSR_TLBRBADV = address;
         if (is_la64(env)) {
             sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI_64,
@@ -110,15 +136,19 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
             sys->CSR_BADV = address;
         }
         sys->CSR_TLBEHI = address & (TARGET_PAGE_MASK << 1);
-   }
+    }
 }
 
-static void invalidate_tlb_entry(CPULoongArchState *env, int index)
+static void invalidate_tlb_entry(CPULoongArchState *env, int index, bool guest)
 {
     target_ulong addr, mask, pagesize;
     uint8_t tlb_ps;
-    LoongArchTLB *tlb = &env->tlb[index];
-    int idxmap = BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX);
+    LoongArchTLB *tlb = &tlb_bank(env, guest)[index];
+    int idxmap = guest ? (BIT(MMU_GUEST_IDX) | BIT(MMU_GUEST_IDX + 1) |
+                          BIT(MMU_GUEST_IDX + 2) | BIT(MMU_GUEST_IDX + 3) |
+                          BIT(MMU_GUEST_DA_IDX)) :
+                         (BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX) |
+                          BIT(MMU_DA_IDX));
     uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
     bool tlb_v;
 
@@ -128,28 +158,28 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & ~mask;
     addr = sextract64(addr, 0, TARGET_VIRT_ADDR_SPACE_BITS);
 
-    tlb_v = pte_present(env, tlb->tlb_entry0);
+    tlb_v = pte_present(env, tlb->tlb_entry0, guest);
     if (tlb_v) {
         tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
                                   idxmap, TARGET_LONG_BITS);
     }
 
-    tlb_v = pte_present(env, tlb->tlb_entry1);
+    tlb_v = pte_present(env, tlb->tlb_entry1, guest);
     if (tlb_v) {
         tlb_flush_range_by_mmuidx(env_cpu(env), addr + pagesize, pagesize,
                                   idxmap, TARGET_LONG_BITS);
     }
 }
 
-static void invalidate_tlb(CPULoongArchState *env, int index)
+static void invalidate_tlb(CPULoongArchState *env, int index, bool guest)
 {
-    LoongArchTLB *tlb;
+    LoongArchTLB *tlb = &tlb_bank(env, guest)[index];
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
     uint16_t csr_asid, tlb_asid, tlb_g;
     uint8_t tlb_e;
-    CPUSysState *sys = env_sys(env);
 
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
-    tlb = &env->tlb[index];
     tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
     if (!tlb_e) {
         return;
@@ -158,19 +188,20 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
     tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
     tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-    /* QEMU TLB is flushed when asid is changed */
     if (tlb_g == 0 && tlb_asid != csr_asid) {
         return;
     }
-    invalidate_tlb_entry(env, index);
+    invalidate_tlb_entry(env, index, guest);
 }
 
 /* Prepare tlb entry information in software PTW mode */
-static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
+static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context,
+                                 bool guest)
 {
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
     uint64_t lo0, lo1, csr_vppn;
     uint8_t csr_ps;
-    CPUSysState *sys = env_sys(env);
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         csr_ps = FIELD_EX64(sys->CSR_TLBREHI, CSR_TLBREHI, PS);
@@ -199,24 +230,25 @@ static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
 }
 
 static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
-                           MMUContext *context)
+                           MMUContext *context, bool guest)
 {
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
     uint64_t lo0, lo1, csr_vppn;
     uint16_t csr_asid;
     uint8_t csr_ps;
-    CPUSysState *sys = env_sys(env);
 
     csr_vppn = context->addr >> R_TLB_MISC_VPPN_SHIFT;
     csr_ps   = context->ps;
     lo0      = context->pte_buddy[0];
     lo1      = context->pte_buddy[1];
 
-    /* Store page size in field PS */
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, ASID, csr_asid);
+    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, GID, get_tgid(env));
 
     tlb->tlb_entry0 = lo0;
     tlb->tlb_entry1 = lo1;
@@ -240,24 +272,25 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
  */
 static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
                                              vaddr vaddr, int csr_asid,
-                                             tlb_match func)
+                                             tlb_match func, bool guest,
+                                             uint8_t gid)
 {
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
     LoongArchTLB *tlb;
     uint16_t tlb_asid, stlb_idx;
     uint8_t tlb_e, tlb_ps, stlb_ps;
     bool tlb_g;
     int i, compare_shift;
     uint64_t vpn, tlb_vppn;
-    CPUSysState *sys = env_sys(env);
 
     stlb_ps = FIELD_EX64(sys->CSR_STLBPS, CSR_STLBPS, PS);
     vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
-    stlb_idx = vpn & 0xff; /* VA[25:15] <==> TLBIDX.index for 16KiB Page */
+    stlb_idx = vpn & 0xff;
     compare_shift = stlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
 
-    /* Search STLB */
     for (i = 0; i < 8; ++i) {
-        tlb = &env->tlb[i * 256 + stlb_idx];
+        tlb = &tlb_bank(env, guest)[i * 256 + stlb_idx];
         tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
         if (tlb_e) {
             tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
@@ -265,15 +298,15 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
             tlb_g = !!FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
 
             if (func(tlb_g, csr_asid, tlb_asid) &&
+                tlb_entry_matches_gid(tlb, gid) &&
                 (vpn == (tlb_vppn >> compare_shift))) {
                 return tlb;
             }
         }
     }
 
-    /* Search MTLB */
     for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; ++i) {
-        tlb = &env->tlb[i];
+        tlb = &tlb_bank(env, guest)[i];
         tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
         if (tlb_e) {
             tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
@@ -283,6 +316,7 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
             compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
             vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
             if (func(tlb_g, csr_asid, tlb_asid) &&
+                tlb_entry_matches_gid(tlb, gid) &&
                 (vpn == (tlb_vppn >> compare_shift))) {
                 return tlb;
             }
@@ -292,18 +326,17 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
 }
 
 static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
-                                 int *index)
+                                 int *index, bool guest, uint8_t gid)
 {
-    int csr_asid;
-    tlb_match func;
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
     LoongArchTLB *tlb;
-    CPUSysState *sys = env_sys(env);
 
-    func = tlb_match_any;
-    csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
-    tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func);
+    tlb = loongarch_tlb_search_cb(env, vaddr,
+                                  FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID),
+                                  tlb_match_any, guest, gid);
     if (tlb) {
-        *index = tlb - env->tlb;
+        *index = tlb - tlb_bank(env, guest);
         return true;
     }
 
@@ -312,15 +345,18 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
 
 void helper_tlbsrch(CPULoongArchState *env)
 {
-    int index, match;
     CPUSysState *sys = env_sys(env);
+    bool guest = env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST;
+    int index, match;
+    vaddr search_ehi;
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        match = loongarch_tlb_search(env, sys->CSR_TLBREHI, &index);
+        search_ehi = sys->CSR_TLBREHI;
     } else {
-        match = loongarch_tlb_search(env, sys->CSR_TLBEHI, &index);
+        search_ehi = sys->CSR_TLBEHI;
     }
 
+    match = loongarch_tlb_search(env, search_ehi, &index, guest, get_tgid(env));
     if (match) {
         sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX, index);
         sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, NE, 0);
@@ -330,20 +366,20 @@ void helper_tlbsrch(CPULoongArchState *env)
     sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
 }
 
-void helper_tlbrd(CPULoongArchState *env)
+static void read_tlb(CPULoongArchState *env, bool guest)
 {
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
     LoongArchTLB *tlb;
     int index;
     uint8_t tlb_ps, tlb_e;
-    CPUSysState *sys = env_sys(env);
 
     index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
-    tlb = &env->tlb[index];
+    tlb = &tlb_bank(env, guest)[index];
     tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
 
     if (!tlb_e) {
-        /* Invalid TLB entry */
         sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
         sys->CSR_ASID  = FIELD_DP64(sys->CSR_ASID, CSR_ASID, ASID, 0);
         sys->CSR_TLBEHI = 0;
@@ -351,39 +387,67 @@ void helper_tlbrd(CPULoongArchState *env)
         sys->CSR_TLBELO1 = 0;
         sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, PS, 0);
     } else {
-        /* Valid TLB entry */
         sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, NE, 0);
         sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX,
-                                     PS, (tlb_ps & 0x3f));
+                                     PS, tlb_ps & 0x3f);
         sys->CSR_TLBEHI = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN) <<
-                                     R_TLB_MISC_VPPN_SHIFT;
+                          R_TLB_MISC_VPPN_SHIFT;
         sys->CSR_TLBELO0 = tlb->tlb_entry0;
         sys->CSR_TLBELO1 = tlb->tlb_entry1;
     }
 }
 
+void helper_tlbrd(CPULoongArchState *env)
+{
+    read_tlb(env, env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST);
+}
+
+void helper_gtlbsrch(CPULoongArchState *env)
+{
+    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
+    int index, match;
+    vaddr search_ehi;
+
+    if (FIELD_EX64(guest->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        search_ehi = guest->CSR_TLBREHI;
+    } else {
+        search_ehi = guest->CSR_TLBEHI;
+    }
+
+    match = loongarch_tlb_search(env, search_ehi, &index, true, get_tgid(env));
+    if (match) {
+        guest->CSR_TLBIDX = FIELD_DP64(guest->CSR_TLBIDX, CSR_TLBIDX, INDEX,
+                                       index);
+        guest->CSR_TLBIDX = FIELD_DP64(guest->CSR_TLBIDX, CSR_TLBIDX, NE, 0);
+        return;
+    }
+    guest->CSR_TLBIDX = FIELD_DP64(guest->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
+}
+
+void helper_gtlbrd(CPULoongArchState *env)
+{
+    read_tlb(env, true);
+}
+
 static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
-                             int index)
+                             int index, bool guest)
 {
     LoongArchTLB *old, new = {};
     bool skip_inv = false, tlb_v0, tlb_v1;
 
-    old = env->tlb + index;
-    fill_tlb_entry(env, &new, context);
-    /* Check whether ASID/VPPN is the same */
+    old = tlb_bank(env, guest) + index;
+    fill_tlb_entry(env, &new, context, guest);
     if (old->tlb_misc == new.tlb_misc) {
-        /* Check whether both even/odd pages is the same or invalid */
-        tlb_v0 = pte_present(env, old->tlb_entry0);
-        tlb_v1 = pte_present(env, old->tlb_entry1);
+        tlb_v0 = pte_present(env, old->tlb_entry0, guest);
+        tlb_v1 = pte_present(env, old->tlb_entry1, guest);
         if ((!tlb_v0 || new.tlb_entry0 == old->tlb_entry0) &&
             (!tlb_v1 || new.tlb_entry1 == old->tlb_entry1)) {
             skip_inv = true;
         }
     }
 
-    /* flush tlb before updating the entry */
     if (!skip_inv) {
-        invalidate_tlb(env, index);
+        invalidate_tlb(env, index, guest);
     }
 
     *old = new;
@@ -392,38 +456,53 @@ static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
 void helper_tlbwr(CPULoongArchState *env)
 {
     CPUSysState *sys = env_sys(env);
+    bool guest = env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST;
     int index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     MMUContext context;
 
     if (FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, NE)) {
-        invalidate_tlb(env, index);
+        invalidate_tlb(env, index, guest);
         return;
     }
 
-    sptw_prepare_context(env, &context);
-    update_tlb_index(env, &context, index);
+    sptw_prepare_context(env, &context, guest);
+    update_tlb_index(env, &context, index, guest);
+}
+
+void helper_gtlbwr(CPULoongArchState *env)
+{
+    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
+    int index = FIELD_EX64(guest->CSR_TLBIDX, CSR_TLBIDX, INDEX);
+    MMUContext context;
+
+    if (FIELD_EX64(guest->CSR_TLBIDX, CSR_TLBIDX, NE)) {
+        invalidate_tlb(env, index, true);
+        return;
+    }
+
+    sptw_prepare_context(env, &context, true);
+    update_tlb_index(env, &context, index, true);
 }
 
 static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
-                                int pagesize)
+                                int pagesize, bool guest)
 {
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
     uint64_t address;
     int index, set, i, stlb_idx;
     uint16_t asid, tlb_asid, stlb_ps;
     LoongArchTLB *tlb;
     uint8_t tlb_e, tlb_g;
-    CPUSysState *sys = env_sys(env);
 
-    /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
     stlb_ps = FIELD_EX64(sys->CSR_STLBPS, CSR_STLBPS, PS);
     asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     if (pagesize == stlb_ps) {
-        /* Only write into STLB bits [47:13] */
         address = addr & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
         set = -1;
-        stlb_idx = (address >> (stlb_ps + 1)) & 0xff; /* [0,255] */
+        stlb_idx = (address >> (stlb_ps + 1)) & 0xff;
         for (i = 0; i < 8; ++i) {
-            tlb = &env->tlb[i * 256 + stlb_idx];
+            tlb = &tlb_bank(env, guest)[i * 256 + stlb_idx];
             tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
             if (!tlb_e) {
                 set = i;
@@ -432,21 +511,20 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
 
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (tlb_g == 0 && asid != tlb_asid) {
+            if (tlb_g == 0 && asid != tlb_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 set = i;
             }
         }
 
-        /* Choose one set randomly */
         if (set < 0) {
             set = get_random_tlb(0, 7);
         }
         index = set * 256 + stlb_idx;
     } else {
-        /* Only write into MTLB */
         index = -1;
         for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
-            tlb = &env->tlb[i];
+            tlb = &tlb_bank(env, guest)[i];
             tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
 
             if (!tlb_e) {
@@ -456,7 +534,8 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
 
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (tlb_g == 0 && asid != tlb_asid) {
+            if (tlb_g == 0 && asid != tlb_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 index = i;
             }
         }
@@ -471,54 +550,75 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
 
 void helper_tlbfill(CPULoongArchState *env)
 {
+    CPUSysState *sys = env_sys(env);
+    bool guest = env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST;
     vaddr entryhi;
     int index, pagesize;
     MMUContext context;
-    CPUSysState *sys = env_sys(env);
 
     if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         entryhi = sys->CSR_TLBREHI;
-        /* Validity of pagesize is checked in helper_ldpte() */
         pagesize = FIELD_EX64(sys->CSR_TLBREHI, CSR_TLBREHI, PS);
     } else {
         entryhi = sys->CSR_TLBEHI;
-        /* Validity of pagesize is checked in helper_tlbrd() */
         pagesize = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, PS);
     }
 
-    sptw_prepare_context(env, &context);
-    index = get_tlb_random_index(env, entryhi, pagesize);
-    invalidate_tlb(env, index);
-    fill_tlb_entry(env, env->tlb + index, &context);
+    sptw_prepare_context(env, &context, guest);
+    index = get_tlb_random_index(env, entryhi, pagesize, guest);
+    invalidate_tlb(env, index, guest);
+    fill_tlb_entry(env, tlb_bank(env, guest) + index, &context, guest);
 }
 
-void helper_tlbclr(CPULoongArchState *env)
+void helper_gtlbfill(CPULoongArchState *env)
 {
+    CPUSysState *guest = &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
+    vaddr entryhi;
+    int index, pagesize;
+    MMUContext context;
+
+    if (FIELD_EX64(guest->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        entryhi = guest->CSR_TLBREHI;
+        pagesize = FIELD_EX64(guest->CSR_TLBREHI, CSR_TLBREHI, PS);
+    } else {
+        entryhi = guest->CSR_TLBEHI;
+        pagesize = FIELD_EX64(guest->CSR_TLBIDX, CSR_TLBIDX, PS);
+    }
+
+    sptw_prepare_context(env, &context, true);
+    index = get_tlb_random_index(env, entryhi, pagesize, true);
+    invalidate_tlb(env, index, true);
+    fill_tlb_entry(env, tlb_bank(env, true) + index, &context, true);
+}
+
+static void clear_tlb_by_index(CPULoongArchState *env, bool guest)
+{
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
     LoongArchTLB *tlb;
     int i, index;
     uint16_t csr_asid, tlb_asid, tlb_g;
-    CPUSysState *sys = env_sys(env);
 
     csr_asid = FIELD_EX64(sys->CSR_ASID, CSR_ASID, ASID);
     index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
 
     if (index < LOONGARCH_STLB) {
-        /* STLB. One line per operation */
         for (i = 0; i < 8; i++) {
-            tlb = &env->tlb[i * 256 + (index % 256)];
+            tlb = &tlb_bank(env, guest)[i * 256 + (index % 256)];
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (!tlb_g && tlb_asid == csr_asid) {
+            if (!tlb_g && tlb_asid == csr_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
             }
         }
     } else if (index < LOONGARCH_TLB_MAX) {
-        /* All MTLB entries */
         for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
-            tlb = &env->tlb[i];
+            tlb = &tlb_bank(env, guest)[i];
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-            if (!tlb_g && tlb_asid == csr_asid) {
+            if (!tlb_g && tlb_asid == csr_asid &&
+                tlb_entry_matches_gid(tlb, get_tgid(env))) {
                 tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
             }
         }
@@ -527,63 +627,118 @@ void helper_tlbclr(CPULoongArchState *env)
     tlb_flush(env_cpu(env));
 }
 
-void helper_tlbflush(CPULoongArchState *env)
+void helper_tlbclr(CPULoongArchState *env)
+{
+    clear_tlb_by_index(env, env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST);
+}
+
+void helper_gtlbclr(CPULoongArchState *env)
 {
+    clear_tlb_by_index(env, true);
+}
+
+static void flush_tlb_by_index(CPULoongArchState *env, bool guest)
+{
+    CPUSysState *sys = &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                               LOONGARCH_VM_LEVEL_HOST];
     int i, index;
-    CPUSysState *sys = env_sys(env);
 
     index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
 
     if (index < LOONGARCH_STLB) {
-        /* STLB. One line per operation */
         for (i = 0; i < 8; i++) {
             int s_idx = i * 256 + (index % 256);
-            env->tlb[s_idx].tlb_misc = FIELD_DP64(env->tlb[s_idx].tlb_misc,
-                                                  TLB_MISC, E, 0);
+            LoongArchTLB *tlb = &tlb_bank(env, guest)[s_idx];
+
+            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     } else if (index < LOONGARCH_TLB_MAX) {
-        /* All MTLB entries */
         for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
-            env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
-                                              TLB_MISC, E, 0);
+            LoongArchTLB *tlb = &tlb_bank(env, guest)[i];
+
+            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     }
 
     tlb_flush(env_cpu(env));
 }
 
-void helper_invtlb_all(CPULoongArchState *env)
+void helper_tlbflush(CPULoongArchState *env)
+{
+    flush_tlb_by_index(env, env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST);
+}
+
+void helper_gtlbflush(CPULoongArchState *env)
 {
+    flush_tlb_by_index(env, true);
+}
+
+void helper_invtlb_all(CPULoongArchState *env, target_ulong info, uint32_t op,
+                       uint32_t to_guest)
+{
+    uint16_t gid = to_guest ? (info & 0xff) : get_tgid(env);
+
+    if (to_guest && env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    to_guest |= env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST;
+
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
-        env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
-                                          TLB_MISC, E, 0);
+        LoongArchTLB *tlb = &tlb_bank(env, false)[i];
+        LoongArchTLB *gtlb = &tlb_bank(env, true)[i];
+
+        if (!to_guest && (op == 0 || tlb_entry_matches_gid(tlb, 0))) {
+            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
+        }
+        if ((!to_guest && op == 0) ||
+            (to_guest && tlb_entry_matches_gid(gtlb, gid))) {
+            gtlb->tlb_misc = FIELD_DP64(gtlb->tlb_misc, TLB_MISC, E, 0);
+        }
     }
     tlb_flush(env_cpu(env));
 }
 
-void helper_invtlb_all_g(CPULoongArchState *env, uint32_t g)
+void helper_invtlb_all_g(CPULoongArchState *env, target_ulong info, uint32_t g,
+                         uint32_t to_guest)
 {
+    uint16_t gid = to_guest ? (info & 0xff) : get_tgid(env);
+
+    if (to_guest && env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    to_guest |= env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST;
+
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
-        LoongArchTLB *tlb = &env->tlb[i];
+        LoongArchTLB *tlb = &tlb_bank(env, to_guest)[i];
         uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
 
-        if (tlb_g == g) {
+        if (tlb_g == g && tlb_entry_matches_gid(tlb, gid)) {
             tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     }
     tlb_flush(env_cpu(env));
 }
 
-void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
+void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info,
+                            uint32_t to_guest)
 {
     uint16_t asid = info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
+
+    if (to_guest && env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    to_guest |= env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST;
 
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
-        LoongArchTLB *tlb = &env->tlb[i];
+        LoongArchTLB *tlb = &tlb_bank(env, to_guest)[i];
         uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
         uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
 
-        if (!tlb_g && (tlb_asid == asid)) {
+        if (!tlb_g && tlb_asid == asid && tlb_entry_matches_gid(tlb, gid)) {
             tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     }
@@ -591,105 +746,159 @@ void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
 }
 
 void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
-                             target_ulong addr)
+                             target_ulong addr, uint32_t to_guest)
 {
-    int asid = info & 0x3ff;
+    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
     LoongArchTLB *tlb;
-    tlb_match func;
+    int index;
 
-    func = tlb_match_asid;
-    tlb = loongarch_tlb_search_cb(env, addr, asid, func);
+    if (to_guest && env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+    to_guest |= env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST;
+
+    tlb = loongarch_tlb_search_cb(env, addr, asid, tlb_match_asid,
+                                  to_guest, gid);
     if (tlb) {
-        invalidate_tlb(env, tlb - env->tlb);
+        index = tlb - tlb_bank(env, to_guest);
+        invalidate_tlb(env, index, to_guest);
     }
 }
 
-void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
-                                  target_ulong info, target_ulong addr)
+void helper_invtlb_page_asid_or_g(CPULoongArchState *env, target_ulong info,
+                                  target_ulong addr, uint32_t to_guest)
 {
-    int asid = info & 0x3ff;
+    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
     LoongArchTLB *tlb;
-    tlb_match func;
+    int index;
 
-    func = tlb_match_any;
-    tlb = loongarch_tlb_search_cb(env, addr, asid, func);
+    if (to_guest && env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    to_guest |= env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST;
+
+    tlb = loongarch_tlb_search_cb(env, addr, asid, tlb_match_any,
+                                  to_guest, gid);
     if (tlb) {
-        invalidate_tlb(env, tlb - env->tlb);
+        index = tlb - tlb_bank(env, to_guest);
+        invalidate_tlb(env, index, to_guest);
     }
 }
 
-static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context)
+static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context,
+                           bool guest)
 {
     int index;
 
     index = context->tlb_index;
     if (index < 0) {
-        index = get_tlb_random_index(env, context->addr, context->ps);
+        index = get_tlb_random_index(env, context->addr, context->ps, guest);
     }
 
-    update_tlb_index(env, context, index);
+    update_tlb_index(env, context, index, guest);
 }
 
-bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                            MMUAccessType access_type, int mmu_idx,
-                            bool probe, uintptr_t retaddr)
+TLBRet loongarch_map_host_address(CPULoongArchState *env, MMUContext *context,
+                                  MMUAccessType access_type, uintptr_t retaddr)
 {
-    CPULoongArchState *env = cpu_env(cs);
-    hwaddr physical;
-    int prot;
-    MMUContext context;
     TLBRet ret;
 
-    /* Data access */
-    context.addr = address;
-    context.tlb_index = -1;
-    ret = get_physical_address(env, &context, access_type, mmu_idx, 0);
-    if (ret == TLBRET_MATCH && context.mmu_index != MMU_DA_IDX
-        && cpu_has_ptw(env)) {
+    ret = loongarch_map_address(env, context, access_type, MMU_KERNEL_IDX,
+                                false, false, retaddr);
+    return TLBRET_HOST_MATCH + ret;
+}
+
+static void loongarch_try_ptw(CPULoongArchState *env, MMUContext *context,
+                              MMUAccessType access_type, int mmu_index,
+                              TLBRet *status, bool guest, uintptr_t retaddr)
+{
+    if ((*status == TLBRET_MATCH || *status == TLBRET_HOST_MATCH) &&
+        context->mmu_index != MMU_DA_IDX &&
+        context->mmu_index != MMU_GUEST_DA_IDX && cpu_has_ptw(env, guest)) {
         bool need_update = true;
 
-        if (access_type == MMU_DATA_STORE && pte_dirty(context.pte)) {
+        if (access_type == MMU_DATA_STORE && pte_dirty(context->pte)) {
             need_update = false;
-        } else if (access_type != MMU_DATA_STORE && pte_access(context.pte)) {
+        } else if (access_type != MMU_DATA_STORE && pte_access(context->pte)) {
             need_update = false;
-
-            /*
-             * FIXME: should context.prot be set without PAGE_WRITE with
-             * pte_write(context.pte) && !pte_dirty(context.pte)??
-             *
-             * Otherwise there will be no loongarch_cpu_tlb_fill() function call
-             * for MMU_DATA_STORE access_type in future since QEMU TLB with
-             * prot PAGE_WRITE is added already
-             */
         }
 
         if (need_update) {
-            /* Need update bit A/D in PTE entry, take PTW again */
-            ret = TLBRET_NOMATCH;
+            *status = (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST &&
+                       !guest) ?
+                      TLBRET_HOST_NOMATCH : TLBRET_NOMATCH;
         }
     }
 
-    if (ret != TLBRET_MATCH && cpu_has_ptw(env)) {
-        /* Take HW PTW if TLB missed or bit P is zero */
-        if (ret == TLBRET_NOMATCH || ret == TLBRET_INVALID) {
-            ret = loongarch_ptw(env, &context, access_type, mmu_idx, 0);
-            if (ret == TLBRET_MATCH) {
-                ptw_update_tlb(env, &context);
+    if (*status != TLBRET_MATCH && *status != TLBRET_HOST_MATCH &&
+        cpu_has_ptw(env, guest)) {
+        if (*status == TLBRET_NOMATCH || *status == TLBRET_INVALID ||
+            *status == TLBRET_HOST_NOMATCH || *status == TLBRET_HOST_INVALID) {
+            *status = ((env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST &&
+                        !guest) ?
+                       TLBRET_HOST_MATCH : TLBRET_MATCH) +
+                      loongarch_ptw(env, context, access_type, mmu_index, 0,
+                                    guest, retaddr);
+            if (*status == TLBRET_MATCH || *status == TLBRET_HOST_MATCH) {
+                ptw_update_tlb(env, context, guest);
             }
-        } else if (context.tlb_index >= 0) {
-            invalidate_tlb(env, context.tlb_index);
+        } else if (context->tlb_index >= 0) {
+            invalidate_tlb(env, context->tlb_index, guest);
         }
     }
+}
+
+bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                            MMUAccessType access_type, int mmu_idx,
+                            bool probe, uintptr_t retaddr)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    bool guest = env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST;
+    MMUContext host_context;
+    hwaddr physical;
+    int prot, host_prot;
+    MMUContext context;
+    TLBRet ret;
+
+    /* Data access */
+    context.addr = address;
+    context.tlb_index = -1;
+    ret = get_physical_address(env, &context, access_type, mmu_idx, 0, retaddr);
+    loongarch_try_ptw(env, &context, access_type, mmu_idx, &ret, guest,
+                      retaddr);
 
     if (ret == TLBRET_MATCH) {
         physical = context.physical;
         prot = context.prot;
+        if (guest) {
+            host_context.addr = physical;
+            host_context.tlb_index = -1;
+            ret = loongarch_map_host_address(env, &host_context, access_type,
+                                             retaddr);
+            loongarch_try_ptw(env, &host_context, access_type, MMU_KERNEL_IDX,
+                              &ret, false, retaddr);
+            if (ret != TLBRET_HOST_MATCH) {
+                if (probe) {
+                    return false;
+                }
+                raise_mmu_exception(env, physical, access_type, ret);
+                cpu_loop_exit_restore(cs, retaddr);
+                return false;
+            }
+            physical = host_context.physical;
+            host_prot = host_context.prot;
+            prot &= host_prot;
+        }
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot,
                      mmu_idx, TARGET_PAGE_SIZE);
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " physical " HWADDR_FMT_plx
-                      " prot %d\n", __func__, address, physical, prot);
+                      " prot %d guest %d\n", __func__, address, physical,
+                      prot, is_guest_mmu_idx(mmu_idx));
         return true;
     } else {
         qemu_log_mask(CPU_LOG_MMU,
@@ -718,6 +927,33 @@ static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
     return (pte & ~ppn_mask) | ((pte & ppn_mask) & palen_mask);
 }
 
+hwaddr loongarch_get_host_address(CPULoongArchState *env, hwaddr gpa,
+                                  uintptr_t retaddr)
+{
+    MMUContext host_context;
+    TLBRet ret;
+    CPUTLBEntryFull *full;
+    int flags = probe_access_full_mmu(env, gpa, 1, MMU_DATA_LOAD,
+                                      MMU_KERNEL_IDX + MMU_GUEST_IDX, NULL, &full);
+    if (!(flags & TLB_INVALID_MASK)) {
+        return (full->phys_addr & TARGET_PAGE_MASK) | (gpa & ~TARGET_PAGE_MASK);
+    }
+
+    host_context.addr = gpa;
+    host_context.tlb_index = -1;
+    ret = loongarch_map_host_address(env, &host_context, MMU_DATA_LOAD,
+                                     retaddr);
+    loongarch_try_ptw(env, &host_context, MMU_DATA_LOAD, MMU_KERNEL_IDX,
+                      &ret, false, retaddr);
+
+    if (ret != TLBRET_HOST_MATCH) {
+        raise_mmu_exception(env, gpa, MMU_DATA_LOAD, ret);
+        cpu_loop_exit_restore(env_cpu(env), retaddr);
+    }
+
+    return host_context.physical;
+}
+
 target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                           uint32_t level, uint32_t mem_idx)
 {
@@ -751,10 +987,16 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 
     badvaddr = sys->CSR_TLBRBADV;
     base = base & palen_mask;
-    get_dir_base_width(env, &dir_base, &dir_width, level);
+    get_dir_base_width(env, &dir_base, &dir_width, level,
+                       env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    val = address_space_ldq_le(cs->as, phys, MEMTXATTRS_UNSPECIFIED, NULL);
+    val = address_space_ldq_le(
+        cs->as,
+        env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST ?
+        loongarch_get_host_address(env, phys, GETPC()) :
+                            phys,
+        MEMTXATTRS_UNSPECIFIED, NULL);
 
     return val & palen_mask;
 }
@@ -789,7 +1031,8 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
          * Move HGLOBAL bit to GLOBAL bit.
          */
         get_dir_base_width(env, &dir_base, &dir_width,
-                           FIELD_EX64(base, TLBENTRY, LEVEL));
+                           FIELD_EX64(base, TLBENTRY, LEVEL),
+                           env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST);
 
         base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
         base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
@@ -823,8 +1066,12 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        pte_raw = address_space_ldq_le(cs->as, phys,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
+        pte_raw = address_space_ldq_le(
+            cs->as,
+            env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST ?
+            loongarch_get_host_address(env, phys, GETPC()) :
+                                phys,
+            MEMTXATTRS_UNSPECIFIED, NULL);
         tmp0 = loongarch_sanitize_hw_pte(env, pte_raw);
         ps = ptbase;
     }
@@ -840,9 +1087,9 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
 static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
                                       MMUContext *context,
                                       MMUAccessType access_type, int index,
-                                      int mmu_idx)
+                                      int mmu_idx, bool guest)
 {
-    LoongArchTLB *tlb = &env->tlb[index];
+    LoongArchTLB *tlb = &tlb_bank(env, guest)[index];
     uint8_t tlb_ps, n;
 
     tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
@@ -850,19 +1097,21 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
     context->pte = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
     context->ps = tlb_ps;
     context->tlb_index = index;
-    return loongarch_check_pte(env, context, access_type, mmu_idx);
+    return loongarch_check_pte(env, context, access_type, mmu_idx, guest);
 }
 
 TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
                                    MMUContext *context,
-                                   MMUAccessType access_type, int mmu_idx)
+                                   MMUAccessType access_type, int mmu_idx,
+                                   bool guest)
 {
     int index, match;
 
-    match = loongarch_tlb_search(env, context->addr, &index);
+    match = loongarch_tlb_search(env, context->addr, &index,
+                                 guest, get_tgid(env));
     if (match) {
         return loongarch_map_tlb_entry(env, context, access_type, index,
-                                       mmu_idx);
+                                       mmu_idx, guest);
     }
 
     return TLBRET_NOMATCH;
-- 
2.52.0


