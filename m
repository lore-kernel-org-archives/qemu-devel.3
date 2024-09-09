Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3771ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBq-0004Js-Fx; Mon, 09 Sep 2024 13:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBm-00044Y-3j
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:34 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBk-00060d-3N
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:33 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-201d5af11a4so47860365ad.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902909; x=1726507709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U4SoTa6waRKndQzDjp6ShU+7i7VkqI25qSoJgeLwLDo=;
 b=e20uUfA04Jb0I1h5/6+YMCSTKr+bMoTxllXwwrVypcI4aIM4Gc88+ktvV2SHoAPtXW
 Q5a1Mbr2ewodqk38H3zyu/3vCCKsoUhpRqOl8rRo5aluP/x8NAShKbrAEUHohCvq63Lj
 neI3sXHD8mVM00mScukALG8WP29QE00z6HfKh0nffxWsFdMA25E3/cyHYg3vBBxXRGlQ
 OFSx2H8zK09AEoWA+XZEAP/iRgV4C5MWSZZJbqkQJwm4jodJU3l1R/+lVraG4UF7VGwn
 hjtXtinilr/WdFBpGlC/sbxJMV1uTObuxzSLdVapDrTvqveF5PlZpIOM/qGnCfEucNJX
 1YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902909; x=1726507709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U4SoTa6waRKndQzDjp6ShU+7i7VkqI25qSoJgeLwLDo=;
 b=ftadOAxls1ikMtOotjCcXyx1Fj5h+pimFg88sE9Pmh/DxB85cwOAcxh1Cg7TW+IlLr
 m9C+MV55Pf0ZMFs7eLL2nNpoRB9+R2hBCxdd2aVbfcHZ3PlnWjfZtOyPvYvc5bg2ShXC
 1pNfN/YwHJRma77zpxMDz7GlYssLWV6f/v5mY99j8JfcsHhCBIrN7Qyy3zrD7wDTOidX
 wdVnbhgdxjvtOK2gMgEqQcubtjzAiv7FAwNYOMg2DbqH7DoP8xVOVXQEIOpGtMhGivo5
 Bc5mh21JQM1peinDPtEumRK9MRWy81u2lCydevHQDVnqrbIYb3EvZP6gc0wmfMC19X1Y
 NUoQ==
X-Gm-Message-State: AOJu0YzbS81JR5trQvl9pCNl4FQZGveH7r+pxMyWNC8Ci0FqFUeyRwJU
 LjM76gMh9dvZnHBgfOenaDxKFF1aXrhse13Afd/zcdWFwDgOy0c65W6UCCnEAsjoZbf2ciSxeuP
 5
X-Google-Smtp-Source: AGHT+IHVSaR2Y+Ig+FjhSCPRVvT25Z9MWHwRFrxBL4LwX3vCR+2/+/IHAR0rjuxB3qlyMbPrx1q1/Q==
X-Received: by 2002:a17:903:191:b0:202:435b:211a with SMTP id
 d9443c01a7336-206f04c9a14mr215233345ad.12.1725902909143; 
 Mon, 09 Sep 2024 10:28:29 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 04/26] target/m68k: Keep FPSR up-to-date
Date: Mon,  9 Sep 2024 10:28:01 -0700
Message-ID: <20240909172823.649837-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Proper support for m68k exceptions will require testing the FPCR vs
the FPSR for every instruction.  As a step, do not keep FPSR bits in
fp_status, but copy them back to the FPSR in every instruction.

Since most of the FPSR must be updated on every insn, combine this
with the existing helper_ftst function to create helper_update_fpsr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h        |   2 -
 target/m68k/helper.h     |   4 +-
 target/m68k/cpu.c        |  10 ----
 target/m68k/fpu_helper.c | 115 ++++++++++++---------------------------
 target/m68k/helper.c     |   4 +-
 target/m68k/translate.c  |  10 ++--
 6 files changed, 42 insertions(+), 103 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index e8dd75d242..389cd1f364 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -199,8 +199,6 @@ void cpu_m68k_set_ccr(CPUM68KState *env, uint32_t);
 void cpu_m68k_set_sr(CPUM68KState *env, uint32_t);
 void cpu_m68k_restore_fp_status(CPUM68KState *env);
 void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val);
-uint32_t cpu_m68k_get_fpsr(CPUM68KState *env);
-void cpu_m68k_set_fpsr(CPUM68KState *env, uint32_t val);
 
 /*
  * Instead of computing the condition codes after each m68k instruction,
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 95aa5e53bb..97a0b22ffb 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -54,10 +54,8 @@ DEF_HELPER_4(fsdiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fddiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fsgldiv, void, env, fp, fp, fp)
 DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
-DEF_HELPER_2(set_fpsr, void, env, i32)
-DEF_HELPER_1(get_fpsr, i32, env)
 DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
-DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
+DEF_HELPER_FLAGS_2(update_fpsr, TCG_CALL_NO_WG, void, env, fp)
 DEF_HELPER_3(fconst, void, env, fp, i32)
 DEF_HELPER_3(fmovemx_st_predec, i32, env, i32, i32)
 DEF_HELPER_3(fmovemx_st_postinc, i32, env, i32, i32)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 4d70cd50b4..8c28db2e95 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -390,20 +390,11 @@ static const VMStateDescription vmstate_freg = {
     }
 };
 
-static int fpu_pre_save(void *opaque)
-{
-    M68kCPU *s = opaque;
-
-    s->env.fpsr = cpu_m68k_get_fpsr(&s->env);
-    return 0;
-}
-
 static int fpu_post_load(void *opaque, int version)
 {
     M68kCPU *s = opaque;
 
     cpu_m68k_set_fpcr(&s->env, s->env.fpcr);
-    cpu_m68k_set_fpsr(&s->env, s->env.fpsr);
     return 0;
 }
 
@@ -412,7 +403,6 @@ const VMStateDescription vmmstate_fpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fpu_needed,
-    .pre_save = fpu_pre_save,
     .post_load = fpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.fpcr, M68kCPU),
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index c6d93b56a0..56694418f2 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -164,76 +164,47 @@ void HELPER(set_fpcr)(CPUM68KState *env, uint32_t val)
     cpu_m68k_set_fpcr(env, val);
 }
 
-/* Convert host exception flags to cpu_m68k form.  */
-static int cpu_m68k_exceptbits_from_host(int host_bits)
+void HELPER(update_fpsr)(CPUM68KState *env, FPReg *pval)
 {
-    int target_bits = 0;
+    uint32_t fpsr = env->fpsr;
+    floatx80 val = pval->d;
+    int soft;
 
-    if (host_bits & float_flag_invalid) {
-        target_bits |= FPSR_AEXP_IOP;
-    }
-    if (host_bits & float_flag_overflow) {
-        target_bits |= FPSR_AEXP_OVFL;
-    }
-    if (host_bits & (float_flag_underflow | float_flag_output_denormal)) {
-        target_bits |= FPSR_AEXP_UNFL;
-    }
-    if (host_bits & float_flag_divbyzero) {
-        target_bits |= FPSR_AEXP_DZ;
-    }
-    if (host_bits & float_flag_inexact) {
-        target_bits |= FPSR_AEXC_INEX;
-    }
-    return target_bits;
-}
+    fpsr &= ~FPSR_CC_MASK;
 
-/* Convert cpu_m68k exception flags to target form.  */
-static int cpu_m68k_exceptbits_to_host(int target_bits)
-{
-    int host_bits = 0;
-
-    if (target_bits & FPSR_AEXP_IOP) {
-        host_bits |= float_flag_invalid;
+    if (floatx80_is_neg(val)) {
+        fpsr |= FPSR_CC_N;
     }
-    if (target_bits & FPSR_AEXP_OVFL) {
-        host_bits |= float_flag_overflow;
+    if (floatx80_is_any_nan(val)) {
+        fpsr |= FPSR_CC_A;
+    } else if (floatx80_is_infinity(val)) {
+        fpsr |= FPSR_CC_I;
+    } else if (floatx80_is_zero(val)) {
+        fpsr |= FPSR_CC_Z;
     }
-    if (target_bits & FPSR_AEXP_UNFL) {
-        host_bits |= float_flag_underflow;
+
+    soft = get_float_exception_flags(&env->fp_status);
+    if (soft) {
+        set_float_exception_flags(0, &env->fp_status);
+
+        if (soft & float_flag_invalid) {
+            fpsr |= FPSR_AEXP_IOP;
+        }
+        if (soft & float_flag_overflow) {
+            fpsr |= FPSR_AEXP_OVFL;
+        }
+        if (soft & (float_flag_underflow | float_flag_output_denormal)) {
+            fpsr |= FPSR_AEXP_UNFL;
+        }
+        if (soft & float_flag_divbyzero) {
+            fpsr |= FPSR_AEXP_DZ;
+        }
+        if (soft & float_flag_inexact) {
+            fpsr |= FPSR_AEXC_INEX;
+        }
     }
-    if (target_bits & FPSR_AEXP_DZ) {
-        host_bits |= float_flag_divbyzero;
-    }
-    if (target_bits & FPSR_AEXC_INEX) {
-        host_bits |= float_flag_inexact;
-    }
-    return host_bits;
-}
 
-uint32_t cpu_m68k_get_fpsr(CPUM68KState *env)
-{
-    int host_flags = get_float_exception_flags(&env->fp_status);
-    int target_flags = cpu_m68k_exceptbits_from_host(host_flags);
-    int except = (env->fpsr & ~FPSR_AEXC_MASK) | target_flags;
-    return except;
-}
-
-uint32_t HELPER(get_fpsr)(CPUM68KState *env)
-{
-    return cpu_m68k_get_fpsr(env);
-}
-
-void cpu_m68k_set_fpsr(CPUM68KState *env, uint32_t val)
-{
-    env->fpsr = val;
-
-    int host_flags = cpu_m68k_exceptbits_to_host((int) env->fpsr);
-    set_float_exception_flags(host_flags, &env->fp_status);
-}
-
-void HELPER(set_fpsr)(CPUM68KState *env, uint32_t val)
-{
-    cpu_m68k_set_fpsr(env, val);
+    env->fpsr = fpsr;
 }
 
 #define PREC_BEGIN(prec)                                        \
@@ -445,24 +416,6 @@ void HELPER(fcmp)(CPUM68KState *env, FPReg *val0, FPReg *val1)
     env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | float_comp_to_cc(float_compare);
 }
 
-void HELPER(ftst)(CPUM68KState *env, FPReg *val)
-{
-    uint32_t cc = 0;
-
-    if (floatx80_is_neg(val->d)) {
-        cc |= FPSR_CC_N;
-    }
-
-    if (floatx80_is_any_nan(val->d)) {
-        cc |= FPSR_CC_A;
-    } else if (floatx80_is_infinity(val->d)) {
-        cc |= FPSR_CC_I;
-    } else if (floatx80_is_zero(val->d)) {
-        cc |= FPSR_CC_Z;
-    }
-    env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | cc;
-}
-
 void HELPER(fconst)(CPUM68KState *env, FPReg *val, uint32_t offset)
 {
     val->d = fpu_rom[offset];
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 4c85badd5d..6fc5afd296 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -88,7 +88,7 @@ static int m68k_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
     case 8: /* fpcontrol */
         return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
-        return gdb_get_reg32(mem_buf, cpu_m68k_get_fpsr(env));
+        return gdb_get_reg32(mem_buf, env->fpsr);
     case 10: /* fpiar, not implemented */
         return gdb_get_reg32(mem_buf, 0);
     }
@@ -110,7 +110,7 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
         cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
-        cpu_m68k_set_fpsr(env, ldl_p(mem_buf));
+        env->fpsr = ldl_p(mem_buf);
         return 4;
     case 10: /* fpiar, not implemented */
         return 4;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ad3ce34501..423c663607 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4732,7 +4732,7 @@ static void gen_load_fcr(DisasContext *s, TCGv res, int reg)
         tcg_gen_movi_i32(res, 0);
         break;
     case M68K_FPSR:
-        gen_helper_get_fpsr(res, tcg_env);
+        tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpsr));
         break;
     case M68K_FPCR:
         tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpcr));
@@ -4746,7 +4746,7 @@ static void gen_store_fcr(DisasContext *s, TCGv val, int reg)
     case M68K_FPIAR:
         break;
     case M68K_FPSR:
-        gen_helper_set_fpsr(tcg_env, val);
+        tcg_gen_st_i32(val, tcg_env, offsetof(CPUM68KState, fpsr));
         break;
     case M68K_FPCR:
         gen_helper_set_fpcr(tcg_env, val);
@@ -4965,7 +4965,7 @@ DISAS_INSN(fpu)
                       EA_STORE, IS_USER(s)) == -1) {
             gen_addr_fault(s);
         }
-        gen_helper_ftst(tcg_env, cpu_src);
+        gen_helper_update_fpsr(tcg_env, cpu_src);
         return;
     case 4: /* fmove to control register.  */
     case 5: /* fmove from control register.  */
@@ -5159,12 +5159,12 @@ DISAS_INSN(fpu)
         gen_helper_fcmp(tcg_env, cpu_src, cpu_dest);
         return;
     case 0x3a: /* ftst */
-        gen_helper_ftst(tcg_env, cpu_src);
+        gen_helper_update_fpsr(tcg_env, cpu_src);
         return;
     default:
         goto undef;
     }
-    gen_helper_ftst(tcg_env, cpu_dest);
+    gen_helper_update_fpsr(tcg_env, cpu_dest);
     return;
 undef:
     /* FIXME: Is this right for offset addressing modes?  */
-- 
2.43.0


