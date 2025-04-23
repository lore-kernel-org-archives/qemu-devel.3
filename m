Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A997AC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XWR-000441-NC; Wed, 23 Apr 2025 06:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1u7XWN-00042G-MW; Wed, 23 Apr 2025 06:40:03 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1u7XWK-0006Le-8n; Wed, 23 Apr 2025 06:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AXkYTgLNvB2ITnefZruKnNcrIkKF8x7tCBcAQG+5aEE=; b=nJ1INe7FwbcHuae1f27R1hOgzJ
 ZikhRA+2gtr10/hKydION2YokCmpl0A9yEjXR1E9F3dH9uTe20EX3b8jLj20m8qweir3utFk7qRsp
 zKZ4zN42kp/ajll4Ilv33fZeVde0tsOiesd/amnflB+IbFSKkot97fbZTAaoWR8FEu0zlQu6TH4Lw
 8V2T1nR/Fh4Dbgl7GzAFdZz2O0gGsTlS5ZXnBN92Ij8AGEC8h6R2DjyjevUNPhLzk3jsouWv7v0XR
 nkh4VxHAK4c36BVQuWKP+Y8rNykteBdujYrTwI+0I0XY6qsArJ1ZOIJFxb52vzEiaGdf7bilKiKOH
 1B+dXOqA==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1u7X3A-006eze-OA; Wed, 23 Apr 2025 11:09:52 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1u7X3A-00000008aYw-1uFj;
 Wed, 23 Apr 2025 11:09:52 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: ben.dooks@codethink.co.uk, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, mrolnik@gmail.com,
 brian.cain@oss.qualcomm.com, deller@gmx.de, zhao1.liu@intel.com,
 gaosong@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com,
 philmd@linaro.org, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 arikalo@gmail.com, shorne@gmail.com, npiggin@gmail.com,
 danielhb413@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 ysato@users.sourceforge.jp, david@redhat.com, iii@linux.ibm.com,
 thuth@redhat.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [RFC PATCH] tcg: allow tb_flags to be larger than 32bit
Date: Wed, 23 Apr 2025 11:09:49 +0100
Message-Id: <20250423100949.2047161-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=srv_ts003@codethink.com; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In adding a new feature to the riscv target, it turns out the tb_flags
had already got to the 32-bit limit. Everyone other target has been
fine with uint32_t (except perhaps arm which does somethng strange to
extend tb_flags, I think).

To allow extending of tb_flags to be bigger, change the uint32_t to
a tb_flags_t which a target can define to be bigger (and do this for
riscv as having tb_flags_t be uint64_t somewhere is necessary to pick
out bugs in this translation).

This method of extension also stops having to go through each arch
fixing field usage and anything else that may arise, and given this
is currently only affecting the tcg, it can be done per target arch.

Note, target/riscv does not currently use any of the other flag bits
yet. The work is done as we would like to try the big-endian riscv
again and someone has already taken the last bit we where using at
(target/riscv/cpu.h#L666 adding PM_SIGNEXTEND where we had BE_DATA)

Q: Do the cpu_get_tb_state calls need uint32_t changing to the
tb_flag_t as part of this?

Q: As part of this, should we also define a FLAG_DP_TB or similar
wrapper for the relevant change?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 accel/tcg/cpu-exec.c      | 10 +++++-----
 accel/tcg/translate-all.c |  2 +-
 target/alpha/cpu.h        |  3 ++-
 target/arm/cpu.h          |  1 +
 target/avr/cpu.h          |  1 +
 target/hexagon/cpu.h      |  1 +
 target/hppa/cpu.h         |  1 +
 target/i386/cpu.h         |  1 +
 target/loongarch/cpu.h    |  1 +
 target/m68k/cpu.h         |  1 +
 target/microblaze/cpu.h   |  1 +
 target/mips/cpu.h         |  1 +
 target/openrisc/cpu.h     |  1 +
 target/ppc/cpu.h          |  1 +
 target/riscv/cpu.h        |  3 ++-
 target/riscv/cpu_helper.c | 40 +++++++++++++++++++--------------------
 target/rx/cpu.h           |  1 +
 target/s390x/cpu.h        |  1 +
 target/sh4/cpu.h          |  1 +
 target/sparc/cpu.h        |  1 +
 target/tricore/cpu.h      |  1 +
 target/xtensa/cpu.h       |  1 +
 22 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ef3d967e3a..2610ecd40e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -302,7 +302,7 @@ static void log_cpu_exec(vaddr pc, CPUState *cpu,
 }
 
 static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
-                                       uint32_t *cflags)
+                                       tb_flags_t *cflags)
 {
     CPUBreakpoint *bp;
     bool match_page = false;
@@ -368,7 +368,7 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
 }
 
 static inline bool check_for_breakpoints(CPUState *cpu, vaddr pc,
-                                         uint32_t *cflags)
+                                         tb_flags_t *cflags)
 {
     return unlikely(!QTAILQ_EMPTY(&cpu->breakpoints)) &&
         check_for_breakpoints_slow(cpu, pc, cflags);
@@ -388,7 +388,7 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     TranslationBlock *tb;
     vaddr pc;
     uint64_t cs_base;
-    uint32_t flags, cflags;
+    tb_flags_t flags, cflags;
 
     /*
      * By definition we've just finished a TB, so I/O is OK.
@@ -565,7 +565,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
     TranslationBlock *tb;
     vaddr pc;
     uint64_t cs_base;
-    uint32_t flags, cflags;
+    tb_flags_t flags, cflags;
     int tb_exit;
 
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
@@ -956,7 +956,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
             TranslationBlock *tb;
             vaddr pc;
             uint64_t cs_base;
-            uint32_t flags, cflags;
+            tb_flags_t flags, cflags;
 
             cpu_get_tb_cpu_state(cpu_env(cpu), &pc, &cs_base, &flags);
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 82bc16bd53..ec90a9a9b0 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -594,7 +594,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
         vaddr pc;
         uint64_t cs_base;
         tb_page_addr_t addr;
-        uint32_t flags;
+        tb_flags_t flags;
 
         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
         addr = get_page_addr_code(env, pc);
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 80562adfb5..25694ede9d 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -464,8 +464,9 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      MemTxResult response, uintptr_t retaddr);
 #endif
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
+                                        uint64_t *cs_base, tb_flags_t *pflags)
 {
     *pc = env->pc;
     *cs_base = 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8177c6c2e..fd32e8d22c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3151,6 +3151,7 @@ static inline bool bswap_code(bool sctlr_b)
 #endif
 }
 
+typedef uint32_t tb_flags_t;
 void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *flags);
 
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 06f5ae4d1b..1a3f31b779 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -193,6 +193,7 @@ enum {
     TB_FLAGS_SKIP = 2,
 };
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPUAVRState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *pflags)
 {
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index f78c8f9c2a..c924aa7e91 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -136,6 +136,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uint32_t exception,
                                             uintptr_t pc);
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8b36642b59..e56f327737 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -352,6 +352,7 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 #define CS_BASE_DIFFPAGE    (1 << 12)
 #define CS_BASE_DIFFSPACE   (1 << 13)
 
+typedef uint32_t tb_flags_t;
 void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags);
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a5..4283f71d45 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2612,6 +2612,7 @@ int cpu_mmu_index_kernel(CPUX86State *env);
 #include "hw/i386/apic.h"
 #endif
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 254e4fbdcd..48252678c8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -490,6 +490,7 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index ddb0f29f4a..9787a0611a 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -607,6 +607,7 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_TRACE          16
 #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index e44ddd5307..8b8e312a4f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -421,6 +421,7 @@ static inline bool mb_cpu_is_big_endian(CPUState *cs)
     return !cpu->cfg.endi;
 }
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f6877ece8b..e2a6b944ed 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1368,6 +1368,7 @@ void cpu_mips_clock_init(MIPSCPU *cpu);
 /* helper.c */
 target_ulong exception_resume_pc(CPUMIPSState *env);
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b97d2ffdd2..cc923629d4 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -351,6 +351,7 @@ static inline void cpu_set_gpr(CPUOpenRISCState *env, int i, uint32_t val)
     env->shadow_gpr[0][i] = val;
 }
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3ee83517dc..1575e8584b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2755,6 +2755,7 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer);
  */
 #define is_book3s_arch2x(ctx) (!!((ctx)->insns_flags & PPC_SEGMENT_64B))
 
+typedef uint32_t tb_flags_t;
 #ifdef CONFIG_DEBUG_TCG
 void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *flags);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 51e49e03de..5ffa6e6f79 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -808,8 +808,9 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
     return vlen >> (vsew + 3 - lmul);
 }
 
+typedef uint64_t tb_flags_t;
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags);
+                          uint64_t *cs_base, tb_flags_t *pflags);
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6c4391d96b..7d6878fbc3 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -135,7 +135,7 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
 }
 
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags)
+                          uint64_t *cs_base, tb_flags_t *pflags)
 {
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
@@ -162,18 +162,18 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
         uint32_t maxsz = vlmax << vsew;
         bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) &&
                            (maxsz >= 8);
-        flags = FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
-        flags = FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
-        flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
+        flags = FIELD_DP64(flags, TB_FLAGS, VILL, env->vill);
+        flags = FIELD_DP64(flags, TB_FLAGS, SEW, vsew);
+        flags = FIELD_DP64(flags, TB_FLAGS, LMUL,
                            FIELD_EX64(env->vtype, VTYPE, VLMUL));
-        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
-        flags = FIELD_DP32(flags, TB_FLAGS, VTA,
+        flags = FIELD_DP64(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
+        flags = FIELD_DP64(flags, TB_FLAGS, VTA,
                            FIELD_EX64(env->vtype, VTYPE, VTA));
-        flags = FIELD_DP32(flags, TB_FLAGS, VMA,
+        flags = FIELD_DP64(flags, TB_FLAGS, VMA,
                            FIELD_EX64(env->vtype, VTYPE, VMA));
-        flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
+        flags = FIELD_DP64(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
     } else {
-        flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
+        flags = FIELD_DP64(flags, TB_FLAGS, VILL, 1);
     }
 
     if (cpu_get_fcfien(env)) {
@@ -182,26 +182,26 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
          * the start of the block is tracked via env->elp. env->elp
          * is turned on during jalr translation.
          */
-        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp);
-        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
+        flags = FIELD_DP64(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp);
+        flags = FIELD_DP64(flags, TB_FLAGS, FCFI_ENABLED, 1);
     }
 
     if (cpu_get_bcfien(env)) {
-        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
+        flags = FIELD_DP64(flags, TB_FLAGS, BCFI_ENABLED, 1);
     }
 
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
 #else
-    flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
+    flags = FIELD_DP64(flags, TB_FLAGS, PRIV, env->priv);
 
     flags |= riscv_env_mmu_index(env, 0);
     fs = get_field(env->mstatus, MSTATUS_FS);
     vs = get_field(env->mstatus, MSTATUS_VS);
 
     if (env->virt_enabled) {
-        flags = FIELD_DP32(flags, TB_FLAGS, VIRT_ENABLED, 1);
+        flags = FIELD_DP64(flags, TB_FLAGS, VIRT_ENABLED, 1);
         /*
          * Merge DISABLED and !DIRTY states using MIN.
          * We will set both fields when dirtying.
@@ -221,12 +221,12 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     }
 #endif
 
-    flags = FIELD_DP32(flags, TB_FLAGS, FS, fs);
-    flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
-    flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
-    flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
-    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
-    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
+    flags = FIELD_DP64(flags, TB_FLAGS, FS, fs);
+    flags = FIELD_DP64(flags, TB_FLAGS, VS, vs);
+    flags = FIELD_DP64(flags, TB_FLAGS, XL, env->xl);
+    flags = FIELD_DP64(flags, TB_FLAGS, AXL, cpu_address_xl(env));
+    flags = FIELD_DP64(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
+    flags = FIELD_DP64(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
     *pflags = flags;
 }
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 349d61c4e4..ad4247deec 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -153,6 +153,7 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
 #define RX_CPU_IRQ 0
 #define RX_CPU_FIR 1
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5b7992deda..a42d412fe6 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -417,6 +417,7 @@ static inline int s390x_env_mmu_index(CPUS390XState *env, bool ifetch)
 
 #include "tcg/tcg_s390x.h"
 
+typedef uint32_t tb_flags_t;
 void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *flags);
 
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index d536d5d715..b10698f1a9 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -382,6 +382,7 @@ static inline void cpu_write_sr(CPUSH4State *env, target_ulong sr)
     env->sr = sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
 }
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 68f8c21e7c..bc876becc9 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -745,6 +745,7 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_FSR_QNE      (1 << 8)
 #define TB_FLAG_ASI_SHIFT    24
 
+typedef uint32_t tb_flags_t;
 void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags);
 
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index cf9dbc6df8..917cd9ab5d 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -259,6 +259,7 @@ void tricore_tcg_init(void);
 void tricore_translate_code(CPUState *cs, TranslationBlock *tb,
                             int *max_insns, vaddr pc, void *host_pc);
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 8d70bfc0cd..856f794342 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -733,6 +733,7 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 
 #include "exec/cpu-all.h"
 
+typedef uint32_t tb_flags_t;
 static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
-- 
2.37.2.352.g3c44437643


