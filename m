Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574CEC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcoF1-0005NM-Iy; Tue, 28 Jan 2025 11:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcoEy-0005Jy-Kd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:15:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcoEu-0002cb-Rv
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:15:04 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6D6935C606A;
 Tue, 28 Jan 2025 16:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8D6C4CED3;
 Tue, 28 Jan 2025 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738080898;
 bh=CBzHx4+oEw39j3XiP2C3P2o+NN58sL6gTPu1OQ12FQY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Icv17MhgZQUuRiaFmtcSnasO4IrQSir/hGcCm11iduufTpzKHU63Sw4UiCIIaW2+O
 U7PntP3ZoazexPOOrvHpcXbTBeie0tdsMTvDykRSKIwl4xXWBVC830AKo2yGAYBaYw
 ZKWtJbp6vXQzJDV/7sOef5VvO2SZ4BpTWUzH7la4OyoZrxIR4PP0Ir2e2PJC1hSMmM
 EuucRk6GjmY9eFdNhPHuNR7Za5UzTrZkSn8ct3NUvi40xZWRJkKywqx0Ky5sKPjbKA
 dtgNXzOpr/wvNRuZwYgWF2RdzOTyyavCqjyZ1cr4reEA3yj8EcUrm1N0WqeYjCriLp
 tcB6Zngt18QmQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/5] target/hppa: Implement CPU diagnose registers for 64-bit
 HP-UX
Date: Tue, 28 Jan 2025 17:14:48 +0100
Message-ID: <20250128161450.12975-4-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250128161450.12975-1-deller@kernel.org>
References: <20250128161450.12975-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

PA-RISC CPUs have diagnose registers (%dr). Those are mostly
undocumented and control cache behaviour, memory behaviour, reset button
management and many other related internal CPU things.

The Linux kernel turns space-register hashing off unconditionally at
bootup.  That code was provided by HP at the beginning of the PA-RISC
Linux porting effort, and I don't know why it was decided then why Linux
should not use space register hashing.
32-bit HP-UX versions seem to not use space register hashing either.
But for 64-bit HP-UX versions, Sven Schnelle noticed that space register
hashing needs to be enabled and is required, otherwise the HP-UX kernel
will crash badly.

On 64-bit CPUs space register hashing is controlled by a bit in diagnose
register %dr2.  Since we want to support Linux and 32- and 64-bit HP-UX,
we need to fully emulate the diagnose registers and handle specifically
the content of %dr2.

Furthermore it turned out that commit 3bdf20819e68 seems wrong and
conflicts with the general space register diagnose register, so it is
partly reverted here.

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Sven Schnelle <svens@stackframe.org>
Fixes: 3bdf20819e68 ("target/hppa: Add diag instructions to set/restore shadow registers")
---
 hw/hppa/machine.c        |  5 +++++
 target/hppa/cpu.c        |  3 ++-
 target/hppa/cpu.h        | 24 ++++++++++++++++--------
 target/hppa/helper.c     |  4 ++--
 target/hppa/insns.decode |  6 ++++--
 target/hppa/int_helper.c |  6 +++---
 target/hppa/machine.c    |  5 +++--
 target/hppa/sys_helper.c |  2 +-
 target/hppa/translate.c  | 24 +++++++++++++++++-------
 9 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 0dd1908214..d5de793b62 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -662,6 +662,11 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
         cpu_set_pc(cs, firmware_entry);
         cpu[i]->env.psw = PSW_Q;
         cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
+
+        /* 64-bit machines start with space-register hashing enabled in %dr2 */
+        if (hppa_is_pa20(&cpu[0]->env)) {
+            cpu[i]->env.dr[2] = HPPA64_DIAG_SPHASH_ENABLE; /* (bit 54) */
+        }
     }
 
     cpu[0]->env.gr[26] = ms->ram_size;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index b0bc9d35e4..9a83910cae 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -44,7 +44,8 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
 {
     CPUHPPAState *env = cpu_env(cs);
 
-    return hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
+    return hppa_form_gva_psw(env, env->psw,
+                            (env->psw & PSW_C ? env->iasq_f : 0),
                              env->iaoq_f & -4);
 }
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index beea42d105..64e60a3980 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -25,6 +25,7 @@
 #include "qemu/cpu-float.h"
 #include "qemu/interval-tree.h"
 #include "hw/registerfields.h"
+#include "hw/hppa/hppa_hardware.h"
 
 #define MMU_ABS_W_IDX     6
 #define MMU_ABS_IDX       7
@@ -232,6 +233,7 @@ typedef struct CPUArchState {
     target_ulong cr[32];     /* control registers */
     target_ulong cr_back[2]; /* back of cr17/cr18 */
     target_ulong shadow[7];  /* shadow registers */
+    target_ulong dr[32];     /* diagnose registers */
 
     /*
      * During unwind of a memory insn, the base register of the address.
@@ -319,27 +321,33 @@ void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
-static inline uint64_t gva_offset_mask(target_ulong psw)
+static inline uint64_t gva_offset_mask(CPUHPPAState *env, target_ulong psw)
 {
-    return (psw & PSW_W
-            ? MAKE_64BIT_MASK(0, 62)
-            : MAKE_64BIT_MASK(0, 32));
+    if (psw & PSW_W) {
+        return (env->dr[2] & HPPA64_DIAG_SPHASH_ENABLE)
+            ? MAKE_64BIT_MASK(0, 62) &
+                ~((uint64_t)HPPA64_PDC_CACHE_RET_SPID_VAL << 48)
+            : MAKE_64BIT_MASK(0, 62);
+    } else {
+        return MAKE_64BIT_MASK(0, 32);
+    }
 }
 
-static inline target_ulong hppa_form_gva_psw(target_ulong psw, uint64_t spc,
-                                             target_ulong off)
+static inline target_ulong hppa_form_gva_psw(CPUHPPAState *env,
+                                             target_ulong psw,
+                                             uint64_t spc, target_ulong off)
 {
 #ifdef CONFIG_USER_ONLY
     return off & gva_offset_mask(psw);
 #else
-    return spc | (off & gva_offset_mask(psw));
+    return spc | (off & gva_offset_mask(env, psw));
 #endif
 }
 
 static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
                                          target_ulong off)
 {
-    return hppa_form_gva_psw(env->psw, spc, off);
+    return hppa_form_gva_psw(env, env->psw, spc, off);
 }
 
 hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr);
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index d4b1a3cd5a..cd7eeb5dfa 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -133,9 +133,9 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "IA_F %08" PRIx64 ":%0*" PRIx64 " (" TARGET_FMT_lx ")\n"
                     "IA_B %08" PRIx64 ":%0*" PRIx64 " (" TARGET_FMT_lx ")\n",
                  env->iasq_f >> 32, w, m & env->iaoq_f,
-                 hppa_form_gva_psw(psw, env->iasq_f, env->iaoq_f),
+                 hppa_form_gva_psw(env, psw, env->iasq_f, env->iaoq_f),
                  env->iasq_b >> 32, w, m & env->iaoq_b,
-                 hppa_form_gva_psw(psw, env->iasq_b, env->iaoq_b));
+                 hppa_form_gva_psw(env, psw, env->iasq_b, env->iaoq_b));
 
     psw_c[0]  = (psw & PSW_W ? 'W' : '-');
     psw_c[1]  = (psw & PSW_E ? 'E' : '-');
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 71074a64c1..4eaac750ea 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -644,10 +644,12 @@ xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
     # For 32-bit PA-7300LC (PCX-L2)
     diag_getshadowregs_pa1  000101 00 0000 0000 0001 1010 0000 0000
     diag_putshadowregs_pa1  000101 00 0000 0000 0001 1010 0100 0000
+    diag_mfdiag             000101 dr:5  rt:5   0000 0110 0000 0000
+    diag_mtdiag             000101 dr:5  r1:5   0001 0110 0000 0000
 
     # For 64-bit PA8700 (PCX-W2)
-    diag_getshadowregs_pa2  000101 00 0111 1000 0001 1000 0100 0000
-    diag_putshadowregs_pa2  000101 00 0111 0000 0001 1000 0100 0000
+    diag_mfdiag             000101 dr:5  0 0000 0000 1000 101  rt:5
+    diag_mtdiag             000101 dr:5  r1:5   0001 1000 0100 0000
   ]
   diag_unimp                000101 i:26
 }
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 58695def82..5aefb3ade4 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -112,9 +112,9 @@ void hppa_cpu_do_interrupt(CPUState *cs)
      */
     if (old_psw & PSW_C) {
         env->cr[CR_IIASQ] =
-            hppa_form_gva_psw(old_psw, env->iasq_f, env->iaoq_f) >> 32;
+            hppa_form_gva_psw(env, old_psw, env->iasq_f, env->iaoq_f) >> 32;
         env->cr_back[0] =
-            hppa_form_gva_psw(old_psw, env->iasq_b, env->iaoq_b) >> 32;
+            hppa_form_gva_psw(env, old_psw, env->iasq_b, env->iaoq_b) >> 32;
     } else {
         env->cr[CR_IIASQ] = 0;
         env->cr_back[0] = 0;
@@ -165,7 +165,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                 if (old_psw & PSW_C) {
                     int prot, t;
 
-                    vaddr = hppa_form_gva_psw(old_psw, env->iasq_f, vaddr);
+                    vaddr = hppa_form_gva_psw(env, old_psw, env->iasq_f, vaddr);
                     t = hppa_get_physical_address(env, vaddr, MMU_KERNEL_IDX,
                                                   0, 0, &paddr, &prot);
                     if (t >= 0) {
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 211bfcf640..bb47a2e689 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -198,6 +198,7 @@ static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINT64(iasq_b, CPUHPPAState),
 
     VMSTATE_UINT32(fr0_shadow, CPUHPPAState),
+    VMSTATE_UINT64_ARRAY(dr, CPUHPPAState, 32),
     VMSTATE_END_OF_LIST()
 };
 
@@ -208,8 +209,8 @@ static const VMStateDescription * const vmstate_env_subsections[] = {
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .fields = vmstate_env_fields,
     .subsections = vmstate_env_subsections,
 };
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index da5b569de8..72bb9ea7b5 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -88,7 +88,7 @@ void HELPER(rfi)(CPUHPPAState *env)
      * To recreate the space identifier, remove the offset bits.
      * For pa1.x, the mask reduces to no change to space.
      */
-    mask = gva_offset_mask(env->psw);
+    mask = gva_offset_mask(env, env->psw);
 
     env->iaoq_f = env->cr[CR_IIAOQ];
     env->iaoq_b = env->cr_back[1];
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index dc04f9f3c0..45a40d2c5e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1577,7 +1577,7 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
     *pofs = ofs;
     *pgva = addr = tcg_temp_new_i64();
     tcg_gen_andi_i64(addr, modify <= 0 ? ofs : base,
-                     gva_offset_mask(ctx->tb_flags));
+                     gva_offset_mask(cpu_env(ctx->cs), ctx->tb_flags));
 #ifndef CONFIG_USER_ONLY
     if (!is_phys) {
         tcg_gen_or_i64(addr, addr, space_select(ctx, sp, base));
@@ -4593,19 +4593,29 @@ static bool trans_diag_getshadowregs_pa1(DisasContext *ctx, arg_empty *a)
     return !ctx->is_pa20 && do_getshadowregs(ctx);
 }
 
-static bool trans_diag_getshadowregs_pa2(DisasContext *ctx, arg_empty *a)
+static bool trans_diag_putshadowregs_pa1(DisasContext *ctx, arg_empty *a)
 {
-    return ctx->is_pa20 && do_getshadowregs(ctx);
+    return !ctx->is_pa20 && do_putshadowregs(ctx);
 }
 
-static bool trans_diag_putshadowregs_pa1(DisasContext *ctx, arg_empty *a)
+static bool trans_diag_mfdiag(DisasContext *ctx, arg_diag_mfdiag *a)
 {
-    return !ctx->is_pa20 && do_putshadowregs(ctx);
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+    TCGv_i64 dest = dest_gpr(ctx, a->rt);
+    tcg_gen_ld_i64(dest, tcg_env,
+                       offsetof(CPUHPPAState, dr[a->dr]));
+    save_gpr(ctx, a->rt, dest);
+    return nullify_end(ctx);
 }
 
-static bool trans_diag_putshadowregs_pa2(DisasContext *ctx, arg_empty *a)
+static bool trans_diag_mtdiag(DisasContext *ctx, arg_diag_mtdiag *a)
 {
-    return ctx->is_pa20 && do_putshadowregs(ctx);
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+    tcg_gen_st_i64(load_gpr(ctx, a->r1), tcg_env,
+                        offsetof(CPUHPPAState, dr[a->dr]));
+    return nullify_end(ctx);
 }
 
 static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
-- 
2.47.0


