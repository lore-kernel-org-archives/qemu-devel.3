Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4F1C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb76-0007I3-IQ; Mon, 29 Jan 2024 18:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6n-0006R1-83
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:32:14 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6k-0005Bx-1T
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:32:08 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d8f3966982so6566005ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571124; x=1707175924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRFiIFFXsXgZu5z5Pbd1LGjtyQm58p6bIAWrhZNFn9w=;
 b=OGTJxR6EX+Bl7OXPCJBdYJN+otmzRPAS/lyhhBtI6e/iRNQ9jDEHX+Pt/jvI5BftLy
 UJZMutzVn1P6+uKSO0KqUm51ObZ/7jjAkCptZ3HlCCevqgTmhEkL3o0f2YHEC2Ry/s/7
 S9LJ8QE9nMdXRa1ATX82pOyPMIeYF8Hqf8C0R8HJzpSx51SsrRYFqKLOCSvT+vEC7BlA
 XIh3PZJRsNK7Kzs/yEgLXCTwDqtLdemANEieZPwBlKx9spuF02Lznkq0QStb4LsWNieP
 beHGm4OBM+03Qdt2FVoNJa1dbuC3otC2VwiN+vFsvTJ1Ss1jq8WAVcqXdbxnarmLW9fX
 eCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571124; x=1707175924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRFiIFFXsXgZu5z5Pbd1LGjtyQm58p6bIAWrhZNFn9w=;
 b=AuEDKAP2OgQAKOpSU7WkBgij5exMjZ76o3OkQYQYN61f7B8DF2AvOWqtzXfEgqN06F
 pnYSbUcAGBlm4S651OU9MQD06DNWV0yHuhNd9ICTph/wo+JILCsA4NkUlkO6pwBpvmw8
 9/Smgg2J9ovDvva+CMcOYRTdUT9ggD+iTDXWrGbLHxuvw4ntapug9DXnOZnl4nEKZtA0
 exEGTOL4y+q3aLAE0NiiKdiVaks/YHMxo9qElfOETvtAi7svR6JTsqKLDed9mKqMGa0s
 QcyjTKenUciJjaW7Z7izXN7pmKJcqpPYPrlzVOEzqAzq7M7Q5PcpmaypIgIcpDW42BUv
 7AIA==
X-Gm-Message-State: AOJu0YwMQeCZwm5l2jsoIXJbi1ySuNgfPxzg+OLPMH2ZPUl+jotc/1fZ
 yfTpSdmwQ4G+d9WvidxZs381KJj2sOzUszVmZWNclxhZ9oGVcYE0Cit8TwjPbmBS834EaAuyhAe
 m3lw=
X-Google-Smtp-Source: AGHT+IHwC6w7mMRAUzpw+v1+wZc+zh8bdqc5yMG8LVMZY+Z0UgYt9BCPVviVhZ1l8XlVo7o7V5J3Og==
X-Received: by 2002:a17:903:181:b0:1d8:dcd2:663 with SMTP id
 z1-20020a170903018100b001d8dcd20663mr3106421plg.19.1706571123815; 
 Mon, 29 Jan 2024 15:32:03 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:32:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 33/33] include/exec: Change cpu_mmu_index argument to CPUState
Date: Tue, 30 Jan 2024 09:30:43 +1000
Message-Id: <20240129233043.34558-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h            |  2 +-
 include/exec/cpu-common.h         |  3 +--
 target/sparc/cpu.h                |  2 +-
 accel/tcg/cputlb.c                | 22 +++++++++-------
 semihosting/uaccess.c             |  2 +-
 target/cris/translate.c           |  2 +-
 target/hppa/mem_helper.c          |  2 +-
 target/hppa/op_helper.c           |  8 +++---
 target/i386/tcg/translate.c       |  2 +-
 target/loongarch/tcg/tlb_helper.c |  4 +--
 target/m68k/op_helper.c           |  2 +-
 target/microblaze/helper.c        |  3 +--
 target/microblaze/mmu.c           |  2 +-
 target/microblaze/translate.c     |  2 +-
 target/nios2/translate.c          |  2 +-
 target/openrisc/translate.c       |  2 +-
 target/sparc/ldst_helper.c        |  2 +-
 target/sparc/mmu_helper.c         |  2 +-
 target/tricore/helper.c           |  2 +-
 target/tricore/translate.c        |  2 +-
 target/xtensa/mmu_helper.c        |  2 +-
 accel/tcg/ldst_common.c.inc       | 42 ++++++++++++++++++++-----------
 22 files changed, 65 insertions(+), 49 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 80c0d0699b..bc05dce7ab 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -311,7 +311,7 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
 #define TLB_WATCHPOINT      0
 
-static inline int cpu_mmu_index(CPUArchState *env, bool ifetch)
+static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     return MMU_USER_IDX;
 }
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 5a4a36a7d8..532663e81d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -274,9 +274,8 @@ static inline CPUState *env_cpu(CPUArchState *env)
  * The user-only version of this function is inline in cpu-all.h,
  * where it always returns MMU_USER_IDX.
  */
-static inline int cpu_mmu_index(CPUArchState *env, bool ifetch)
+static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 {
-    CPUState *cs = env_cpu(env);
     return cs->cc->mmu_index(cs, ifetch);
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 51856152fa..1e076f6355 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -755,7 +755,7 @@ static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
     uint32_t flags;
     *pc = env->pc;
     *cs_base = env->npc;
-    flags = cpu_mmu_index(env, false);
+    flags = cpu_mmu_index(env_cpu(env), false);
 #ifndef CONFIG_USER_ONLY
     if (cpu_supervisor_mode(env)) {
         flags |= TB_FLAG_SUPER;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3facfcbb24..047cd2cc0a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1601,7 +1601,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     void *p;
 
     (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
-                                cpu_mmu_index(env, true), false,
+                                cpu_mmu_index(env_cpu(env), true), false,
                                 &p, &full, 0, false);
     if (p == NULL) {
         return -1;
@@ -2959,26 +2959,30 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
 
 uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
 {
-    MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(env, true));
-    return do_ld1_mmu(env_cpu(env), addr, oi, 0, MMU_INST_FETCH);
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
+    return do_ld1_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
 }
 
 uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
 {
-    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(env, true));
-    return do_ld2_mmu(env_cpu(env), addr, oi, 0, MMU_INST_FETCH);
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
+    return do_ld2_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
 }
 
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
 {
-    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(env, true));
-    return do_ld4_mmu(env_cpu(env), addr, oi, 0, MMU_INST_FETCH);
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
+    return do_ld4_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
 }
 
 uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
 {
-    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(env, true));
-    return do_ld8_mmu(env_cpu(env), addr, oi, 0, MMU_INST_FETCH);
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
+    return do_ld8_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
 }
 
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 5d889f9263..dc587d73bc 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -26,7 +26,7 @@ void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
 
 ssize_t uaccess_strlen_user(CPUArchState *env, target_ulong addr)
 {
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
     size_t len = 0;
 
     while (1) {
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 7acea29a01..8f74b6c53f 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -2966,7 +2966,7 @@ static void cris_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->cpu = env_archcpu(env);
     dc->ppc = pc_start;
     dc->pc = pc_start;
-    dc->mem_index = cpu_mmu_index(env, false);
+    dc->mem_index = cpu_mmu_index(cs, false);
     dc->flags_uptodate = 1;
     dc->flags_x = tb_flags & X_FLAG;
     dc->cc_x_uptodate = 0;
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 4fcc612754..629a9d90ef 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -646,7 +646,7 @@ int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr)
 void HELPER(diag_btlb)(CPUHPPAState *env)
 {
     unsigned int phys_page, len, slot;
-    int mmu_idx = cpu_mmu_index(env, 0);
+    int mmu_idx = cpu_mmu_index(env_cpu(env), 0);
     uintptr_t ra = GETPC();
     HPPATLBEntry *btlb;
     uint64_t virt_page;
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index ce15469465..b1f24a5aad 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -59,7 +59,7 @@ void HELPER(tcond)(CPUHPPAState *env, target_ulong cond)
 static void atomic_store_mask32(CPUHPPAState *env, target_ulong addr,
                                 uint32_t val, uint32_t mask, uintptr_t ra)
 {
-    int mmu_idx = cpu_mmu_index(env, 0);
+    int mmu_idx = cpu_mmu_index(env_cpu(env), 0);
     uint32_t old, new, cmp, *haddr;
     void *vaddr;
 
@@ -86,7 +86,7 @@ static void atomic_store_mask64(CPUHPPAState *env, target_ulong addr,
                                 int size, uintptr_t ra)
 {
 #ifdef CONFIG_ATOMIC64
-    int mmu_idx = cpu_mmu_index(env, 0);
+    int mmu_idx = cpu_mmu_index(env_cpu(env), 0);
     uint64_t old, new, cmp, *haddr;
     void *vaddr;
 
@@ -235,7 +235,7 @@ static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ulong val,
     default:
         /* Nothing is stored, but protection is checked and the
            cacheline is marked dirty.  */
-        probe_write(env, addr, 0, cpu_mmu_index(env, 0), ra);
+        probe_write(env, addr, 0, cpu_mmu_index(env_cpu(env), 0), ra);
         break;
     }
 }
@@ -296,7 +296,7 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
     default:
         /* Nothing is stored, but protection is checked and the
            cacheline is marked dirty.  */
-        probe_write(env, addr, 0, cpu_mmu_index(env, 0), ra);
+        probe_write(env, addr, 0, cpu_mmu_index(env_cpu(env), 0), ra);
         break;
     }
 }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2808903661..10cba16256 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6955,7 +6955,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cc_op_dirty = false;
     dc->popl_esp_hack = 0;
     /* select memory access functions */
-    dc->mem_index = cpu_mmu_index(env, false);
+    dc->mem_index = cpu_mmu_index(cpu, false);
     dc->cpuid_features = env->features[FEAT_1_EDX];
     dc->cpuid_ext_features = env->features[FEAT_1_ECX];
     dc->cpuid_ext2_features = env->features[FEAT_8000_0001_EDX];
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 65ffbef08e..9e2a44c119 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -241,7 +241,7 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
 
     if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
-                             cpu_mmu_index(env, false)) != 0) {
+                             cpu_mmu_index(cs, false)) != 0) {
         return -1;
     }
     return phys_addr;
@@ -320,7 +320,7 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     uint8_t tlb_ps;
     LoongArchTLB *tlb = &env->tlb[index];
 
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
     uint8_t tlb_v0 = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, V);
     uint8_t tlb_v1 = FIELD_EX64(tlb->tlb_entry1, TLBENTRY, V);
     uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 1ce850bbc5..47b4173bb9 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -811,7 +811,7 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
     uint32_t l1, l2;
     uintptr_t ra = GETPC();
 #if defined(CONFIG_ATOMIC64)
-    int mmu_idx = cpu_mmu_index(env, 0);
+    int mmu_idx = cpu_mmu_index(env_cpu(env), 0);
     MemOpIdx oi = make_memop_idx(MO_BEUQ, mmu_idx);
 #endif
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 98bdb82de8..460eee0cf5 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -228,10 +228,9 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                         MemTxAttrs *attrs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
     target_ulong vaddr, paddr = 0;
     MicroBlazeMMULookup lu;
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = cpu_mmu_index(cs, false);
     unsigned int hit;
 
     /* Caller doesn't initialize */
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 75651979a9..234006634e 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -305,7 +305,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
             }
 
             hit = mmu_translate(cpu, &lu, v & TLB_EPN_MASK,
-                                0, cpu_mmu_index(env, false));
+                                0, cpu_mmu_index(env_cpu(env), false));
             if (hit) {
                 env->mmu.regs[MMU_R_TLBX] = lu.idx;
             } else {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 2e628647d1..a465c2d245 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1607,7 +1607,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->ext_imm = dc->base.tb->cs_base;
     dc->r0 = NULL;
     dc->r0_set = false;
-    dc->mem_index = cpu_mmu_index(&cpu->env, false);
+    dc->mem_index = cpu_mmu_index(cs, false);
     dc->jmp_cond = dc->tb_flags & D_FLAG ? TCG_COND_ALWAYS : TCG_COND_NEVER;
     dc->jmp_dest = -1;
 
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 3078372b36..612556b297 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -948,7 +948,7 @@ static void nios2_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     Nios2CPU *cpu = env_archcpu(env);
     int page_insns;
 
-    dc->mem_idx = cpu_mmu_index(env, false);
+    dc->mem_idx = cpu_mmu_index(cs, false);
     dc->cr_state = cpu->cr_state;
     dc->tb_flags = dc->base.tb->flags;
     dc->eic_present = cpu->eic_present;
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index d4cbc5eaea..785bcb6552 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1528,7 +1528,7 @@ static void openrisc_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     CPUOpenRISCState *env = cpu_env(cs);
     int bound;
 
-    dc->mem_idx = cpu_mmu_index(env, false);
+    dc->mem_idx = cpu_mmu_index(cs, false);
     dc->tb_flags = dc->base.tb->flags;
     dc->delayed_branch = (dc->tb_flags & TB_FLAGS_DFLAG) != 0;
     dc->cpucfgr = env->cpucfgr;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 09066d5487..52aa6c631b 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -690,7 +690,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_M_IODIAG:  /* Turbosparc IOTLB Diagnostic */
         break;
     case ASI_KERNELTXT: /* Supervisor code access */
-        oi = make_memop_idx(memop, cpu_mmu_index(env, true));
+        oi = make_memop_idx(memop, cpu_mmu_index(env_cpu(env), true));
         switch (size) {
         case 1:
             ret = cpu_ldb_code_mmu(env, addr, oi, GETPC());
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 453498c670..5170a668bb 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -901,7 +901,7 @@ hwaddr sparc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
     hwaddr phys_addr;
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = cpu_mmu_index(cs, false);
 
     if (cpu_sparc_get_phys_page(env, &phys_addr, addr, 2, mmu_idx) != 0) {
         if (cpu_sparc_get_phys_page(env, &phys_addr, addr, 0, mmu_idx) != 0) {
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 174f666e1e..649373a9cb 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -48,7 +48,7 @@ hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     TriCoreCPU *cpu = TRICORE_CPU(cs);
     hwaddr phys_addr;
     int prot;
-    int mmu_idx = cpu_mmu_index(&cpu->env, false);
+    int mmu_idx = cpu_mmu_index(cs, false);
 
     if (get_physical_address(&cpu->env, &phys_addr, &prot, addr,
                              MMU_DATA_LOAD, mmu_idx)) {
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index f1156c39e7..278c514ab0 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8355,7 +8355,7 @@ static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUTriCoreState *env = cpu_env(cs);
-    ctx->mem_idx = cpu_mmu_index(env, false);
+    ctx->mem_idx = cpu_mmu_index(cs, false);
 
     uint32_t tb_flags = (uint32_t)ctx->base.tb->flags;
     ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 2fda4e887c..47063b0a57 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -66,7 +66,7 @@ void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
      * only the side-effects (ie any MMU or other exception)
      */
     probe_access(env, vaddr, 1, MMU_INST_FETCH,
-                 cpu_mmu_index(env, true), GETPC());
+                 cpu_mmu_index(env_cpu(env), true), GETPC());
 }
 
 void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t v)
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 44833513fb..c82048e377 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -354,7 +354,8 @@ void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
 
 uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
 {
-    return cpu_ldub_mmuidx_ra(env, addr, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldub_mmuidx_ra(env, addr, mmu_index, ra);
 }
 
 int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
@@ -364,7 +365,8 @@ int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
 
 uint32_t cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
 {
-    return cpu_lduw_be_mmuidx_ra(env, addr, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_lduw_be_mmuidx_ra(env, addr, mmu_index, ra);
 }
 
 int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
@@ -374,17 +376,20 @@ int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
 
 uint32_t cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
 {
-    return cpu_ldl_be_mmuidx_ra(env, addr, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldl_be_mmuidx_ra(env, addr, mmu_index, ra);
 }
 
 uint64_t cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
 {
-    return cpu_ldq_be_mmuidx_ra(env, addr, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldq_be_mmuidx_ra(env, addr, mmu_index, ra);
 }
 
 uint32_t cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
 {
-    return cpu_lduw_le_mmuidx_ra(env, addr, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_lduw_le_mmuidx_ra(env, addr, mmu_index, ra);
 }
 
 int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
@@ -394,54 +399,63 @@ int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
 
 uint32_t cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
 {
-    return cpu_ldl_le_mmuidx_ra(env, addr, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldl_le_mmuidx_ra(env, addr, mmu_index, ra);
 }
 
 uint64_t cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
 {
-    return cpu_ldq_le_mmuidx_ra(env, addr, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldq_le_mmuidx_ra(env, addr, mmu_index, ra);
 }
 
 void cpu_stb_data_ra(CPUArchState *env, abi_ptr addr,
                      uint32_t val, uintptr_t ra)
 {
-    cpu_stb_mmuidx_ra(env, addr, val, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stb_mmuidx_ra(env, addr, val, mmu_index, ra);
 }
 
 void cpu_stw_be_data_ra(CPUArchState *env, abi_ptr addr,
                         uint32_t val, uintptr_t ra)
 {
-    cpu_stw_be_mmuidx_ra(env, addr, val, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stw_be_mmuidx_ra(env, addr, val, mmu_index, ra);
 }
 
 void cpu_stl_be_data_ra(CPUArchState *env, abi_ptr addr,
                         uint32_t val, uintptr_t ra)
 {
-    cpu_stl_be_mmuidx_ra(env, addr, val, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stl_be_mmuidx_ra(env, addr, val, mmu_index, ra);
 }
 
 void cpu_stq_be_data_ra(CPUArchState *env, abi_ptr addr,
                         uint64_t val, uintptr_t ra)
 {
-    cpu_stq_be_mmuidx_ra(env, addr, val, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stq_be_mmuidx_ra(env, addr, val, mmu_index, ra);
 }
 
 void cpu_stw_le_data_ra(CPUArchState *env, abi_ptr addr,
                         uint32_t val, uintptr_t ra)
 {
-    cpu_stw_le_mmuidx_ra(env, addr, val, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stw_le_mmuidx_ra(env, addr, val, mmu_index, ra);
 }
 
 void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr addr,
                         uint32_t val, uintptr_t ra)
 {
-    cpu_stl_le_mmuidx_ra(env, addr, val, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stl_le_mmuidx_ra(env, addr, val, mmu_index, ra);
 }
 
 void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr,
                         uint64_t val, uintptr_t ra)
 {
-    cpu_stq_le_mmuidx_ra(env, addr, val, cpu_mmu_index(env, false), ra);
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
 }
 
 /*--------------------------*/
-- 
2.34.1


