Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC22C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 15:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdA1e-0005fN-0z; Wed, 29 Jan 2025 10:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdA1b-0005fA-T5
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 10:30:44 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdA1Z-0008AF-KN
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 10:30:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 73402A41A34;
 Wed, 29 Jan 2025 15:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4C4C4CED1;
 Wed, 29 Jan 2025 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738164636;
 bh=Y/FrHxK1iRmeMBbpIL3JaxY1nYdi7SCgQmZ6Rumw0UA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AnQXfChv6o4ARG72FgfkBB2rKLDGrwiaAKQJu/XaXX+CcAfA8O+ULSp7c7Tkiye1h
 gIwlxDZJaLGYdB1dfU55Hypt9FNPUxCaKLG68h2g1Vo+7qUxcTjxUu0VMLLUiu7un4
 aURu9Wb4Gf/yrSl0niyVjIW8NUdkSnJytPfEctDeXAIit+snOyuruG7s3LJqeFCeQO
 xMr3pOWe2XZeVlihfhQQwkFLuAkhmyZ+rGQSpCzGBgCKIGC+7XRR+pTgUgj9mOLv+2
 flpwGf//ypvz+m8Ioxh1sPVsEOhoa2LiTV79jSEm3mxwXHJZTmx9dyHQKr7Ebvj2CQ
 duNwjap3txsbg==
Date: Wed, 29 Jan 2025 16:30:33 +0100
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH 4/4] target/hppa: Implement space register hashing for
 64-bit HP-UX
Message-ID: <Z5pJmQGsteQhMQtI@p100>
References: <20250128224817.24715-1-deller@kernel.org>
 <20250128224817.24715-5-deller@kernel.org>
 <34f4e42f-b08a-42dd-ad11-f720f6d8a440@linaro.org>
 <6f445eb1-2626-4a08-abbb-580cdd7fe682@linaro.org>
 <Z5mph0gdQHbCsKit@p100>
 <ccbf7be1-db49-4eb6-8ccb-32bcfd3b380a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccbf7be1-db49-4eb6-8ccb-32bcfd3b380a@linaro.org>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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


Richard, thanks for your feedback!
Can you please review the updated patch below which includes your
suggestions.
Additionally I've successfully tested it.

Thanks in advance,
Helge

-------------

Subject: [PATCH] target/hppa: Implement space register hashing for 64-bit HP-UX

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
the bit in %dr2.

This patch adds the code to calculate the gva memory mask based on the
space-register hashing bit in %dr2 and the PSW_W (64-bit) flag.
The value is cached in the gva_offset_mask variable in CPUArchState
and recalculated at every modification of the CPU PSW or %dr2.

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Sven Schnelle <svens@stackframe.org>

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c86f9190d2..5655677431 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -45,8 +45,9 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
 {
     CPUHPPAState *env = cpu_env(cs);
 
-    return hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
-                             env->iaoq_f & -4);
+    return hppa_form_gva_mask(env->gva_offset_mask,
+                         (env->psw & PSW_C ? env->iasq_f : 0),
+                         env->iaoq_f & -4);
 }
 
 void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
@@ -91,6 +92,10 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
         & (env->sr[4] == env->sr[7])) {
         flags |= TB_FLAG_SR_SAME;
     }
+    if ((env->psw & PSW_W) &&
+        (env->dr[2] & HPPA64_DIAG_SPHASH_ENABLE)) {
+        flags |= TB_FLAG_SPHASH;
+    }
 #endif
 
     *pcsbase = cs_base;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index b858986c41..7be4a1d380 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -223,6 +223,7 @@ typedef struct CPUArchState {
     target_ulong psw_cb;     /* in least significant bit of next nibble */
     target_ulong psw_cb_msb; /* boolean */
 
+    uint64_t gva_offset_mask; /* cached address mask based on PSW and %dr2 */
     uint64_t iasq_f;
     uint64_t iasq_b;
 
@@ -320,27 +321,20 @@ void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
-static inline uint64_t gva_offset_mask(target_ulong psw)
-{
-    return (psw & PSW_W
-            ? MAKE_64BIT_MASK(0, 62)
-            : MAKE_64BIT_MASK(0, 32));
-}
-
-static inline target_ulong hppa_form_gva_psw(target_ulong psw, uint64_t spc,
-                                             target_ulong off)
+static inline target_ulong hppa_form_gva_mask(uint64_t gva_offset_mask,
+                                        uint64_t spc, target_ulong off)
 {
 #ifdef CONFIG_USER_ONLY
-    return off & gva_offset_mask(psw);
+    return off & gva_offset_mask;
 #else
-    return spc | (off & gva_offset_mask(psw));
+    return spc | (off & gva_offset_mask);
 #endif
 }
 
 static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
                                          target_ulong off)
 {
-    return hppa_form_gva_psw(env->psw, spc, off);
+    return hppa_form_gva_mask(env->gva_offset_mask, spc, off);
 }
 
 hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr);
@@ -354,6 +348,7 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 #define TB_FLAG_SR_SAME     PSW_I
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
+#define TB_FLAG_SPHASH      0x800
 #define CS_BASE_DIFFPAGE    (1 << 12)
 #define CS_BASE_DIFFSPACE   (1 << 13)
 
@@ -362,6 +357,7 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
 
 target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong);
+void update_gva_offset_mask(CPUHPPAState *env);
 void cpu_hppa_loaded_fr0(CPUHPPAState *env);
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index d4b1a3cd5a..ac7f58f0af 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
+#include "hw/hppa/hppa_hardware.h"
 
 target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
 {
@@ -59,6 +60,22 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
     return psw;
 }
 
+void update_gva_offset_mask(CPUHPPAState *env)
+{
+    uint64_t gom;
+
+    if (env->psw & PSW_W) {
+        gom = (env->dr[2] & HPPA64_DIAG_SPHASH_ENABLE)
+            ? MAKE_64BIT_MASK(0, 62) &
+                ~((uint64_t)HPPA64_PDC_CACHE_RET_SPID_VAL << 48)
+            : MAKE_64BIT_MASK(0, 62);
+    } else {
+        gom = MAKE_64BIT_MASK(0, 32);
+    }
+
+    env->gva_offset_mask = gom;
+}
+
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
 {
     uint64_t reserved;
@@ -98,6 +115,8 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
     cb |= ((psw >>  9) & 1) <<  8;
     cb |= ((psw >>  8) & 1) <<  4;
     env->psw_cb = cb;
+
+    update_gva_offset_mask(env);
 }
 
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
@@ -133,9 +152,11 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "IA_F %08" PRIx64 ":%0*" PRIx64 " (" TARGET_FMT_lx ")\n"
                     "IA_B %08" PRIx64 ":%0*" PRIx64 " (" TARGET_FMT_lx ")\n",
                  env->iasq_f >> 32, w, m & env->iaoq_f,
-                 hppa_form_gva_psw(psw, env->iasq_f, env->iaoq_f),
+                 hppa_form_gva_mask(env->gva_offset_mask, env->iasq_f,
+				    env->iaoq_f),
                  env->iasq_b >> 32, w, m & env->iaoq_b,
-                 hppa_form_gva_psw(psw, env->iasq_b, env->iaoq_b));
+                 hppa_form_gva_mask(env->gva_offset_mask, env->iasq_b,
+				    env->iaoq_b));
 
     psw_c[0]  = (psw & PSW_W ? 'W' : '-');
     psw_c[1]  = (psw & PSW_E ? 'E' : '-');
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index de411923d9..8369855d78 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -99,6 +99,7 @@ DEF_HELPER_FLAGS_2(ptlb_l, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(ptlbe, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(lpa, TCG_CALL_NO_WG, tl, env, tl)
 DEF_HELPER_FLAGS_1(change_prot_id, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_FLAGS_1(update_gva_offset_mask, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_1(diag_btlb, void, env)
 DEF_HELPER_1(diag_console_output, void, env)
 #endif
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 58695def82..7d48643bb6 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -94,11 +94,12 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
     int i = cs->exception_index;
-    uint64_t old_psw;
+    uint64_t old_psw, old_gva_offset_mask;
 
     /* As documented in pa2.0 -- interruption handling.  */
     /* step 1 */
     env->cr[CR_IPSW] = old_psw = cpu_hppa_get_psw(env);
+    old_gva_offset_mask = env->gva_offset_mask;
 
     /* step 2 -- Note PSW_W is masked out again for pa1.x */
     cpu_hppa_put_psw(env,
@@ -112,9 +113,9 @@ void hppa_cpu_do_interrupt(CPUState *cs)
      */
     if (old_psw & PSW_C) {
         env->cr[CR_IIASQ] =
-            hppa_form_gva_psw(old_psw, env->iasq_f, env->iaoq_f) >> 32;
+            hppa_form_gva_mask(old_gva_offset_mask, env->iasq_f, env->iaoq_f) >> 32;
         env->cr_back[0] =
-            hppa_form_gva_psw(old_psw, env->iasq_b, env->iaoq_b) >> 32;
+            hppa_form_gva_mask(old_gva_offset_mask, env->iasq_b, env->iaoq_b) >> 32;
     } else {
         env->cr[CR_IIASQ] = 0;
         env->cr_back[0] = 0;
@@ -165,7 +166,8 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                 if (old_psw & PSW_C) {
                     int prot, t;
 
-                    vaddr = hppa_form_gva_psw(old_psw, env->iasq_f, vaddr);
+                    vaddr = hppa_form_gva_mask(old_gva_offset_mask,
+					       env->iasq_f, vaddr);
                     t = hppa_get_physical_address(env, vaddr, MMU_KERNEL_IDX,
                                                   0, 0, &paddr, &prot);
                     if (t >= 0) {
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index b8c3e55170..304f0b61e2 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -824,3 +824,8 @@ uint64_t HELPER(b_gate_priv)(CPUHPPAState *env, uint64_t iaoq_f)
     }
     return iaoq_f;
 }
+
+void HELPER(update_gva_offset_mask)(CPUHPPAState *env)
+{
+    update_gva_offset_mask(env);
+}
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index da5b569de8..052a6a88a2 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -73,7 +73,7 @@ target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
      * machines set the Q bit from 0 to 1 without an exception,
      * so let this go without comment.
      */
-    env->psw = (psw & ~PSW_SM) | (nsm & PSW_SM);
+    cpu_hppa_put_psw(env, (psw & ~PSW_SM) | (nsm & PSW_SM));
     return psw & PSW_SM;
 }
 
@@ -88,7 +88,7 @@ void HELPER(rfi)(CPUHPPAState *env)
      * To recreate the space identifier, remove the offset bits.
      * For pa1.x, the mask reduces to no change to space.
      */
-    mask = gva_offset_mask(env->psw);
+    mask = env->gva_offset_mask;
 
     env->iaoq_f = env->cr[CR_IIAOQ];
     env->iaoq_b = env->cr_back[1];
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7b9d3deb39..e9ef171418 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -73,6 +73,7 @@ typedef struct DisasContext {
 
     /* IAOQ_Front at entry to TB. */
     uint64_t iaoq_first;
+    uint64_t gva_offset_mask;
 
     DisasCond null_cond;
     TCGLabel *null_lab;
@@ -1577,7 +1578,7 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
     *pofs = ofs;
     *pgva = addr = tcg_temp_new_i64();
     tcg_gen_andi_i64(addr, modify <= 0 ? ofs : base,
-                     gva_offset_mask(ctx->tb_flags));
+                     ctx->gva_offset_mask);
 #ifndef CONFIG_USER_ONLY
     if (!is_phys) {
         tcg_gen_or_i64(addr, addr, space_select(ctx, sp, base));
@@ -4615,6 +4616,12 @@ static bool trans_diag_mtdiag(DisasContext *ctx, arg_diag_mtdiag *a)
     nullify_over(ctx);
     tcg_gen_st_i64(load_gpr(ctx, a->r1), tcg_env,
                         offsetof(CPUHPPAState, dr[a->dr]));
+    if (ctx->is_pa20 && (a->dr == 2)) {
+        /* Update gva_offset_mask from the new value of %dr2 */
+        gen_helper_update_gva_offset_mask(tcg_env);
+        /* Exit to capture the new value for the next TB. */
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
+    }
     return nullify_end(ctx);
 }
 
@@ -4635,6 +4642,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->tb_flags = ctx->base.tb->flags;
     ctx->is_pa20 = hppa_is_pa20(cpu_env(cs));
     ctx->psw_xb = ctx->tb_flags & (PSW_X | PSW_B);
+    ctx->gva_offset_mask = cpu_env(cs)->gva_offset_mask;
 
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = PRIV_USER;

