Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A6EC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm4n-00069g-3x; Wed, 07 May 2025 17:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4j-00068T-Aw
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4g-0006Bi-4l
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:09 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so342769b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652385; x=1747257185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGHtEcgIPxqigs8PswZSigZ3ehlSQMqegpHt8avA52c=;
 b=VeD9TezcD6whETfmU+3Ij1XsRSVNes5kuwvCl8s1DPeMQ4vxNW4A/EPs+nkNJq3HN1
 lBakGTSHu7RoHvF7HvJilX1NhvhYA/RS2lfCjr+dNPF/DLBxMR2Wwy6XN1p4oPgQ7DlD
 AkHlTQm6bVzvwum+0R3K3Iu/DI66PDnwOf3pUvzBXdXTgC36IoKAnBAea1LgUfjuJeqg
 TBvALh7YdrapRnGIVXiPPOrtMdSa13HZQaBlrcYxZC67DhP74IhzUwi2rg44aKJCjyhN
 MSvK8GLhjG84/PS1dlb88PlqZ1kCsT1aUFHYXprCVe8BX4YE9T3YpYVH4PF7uOCy3KFg
 5D7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652385; x=1747257185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JGHtEcgIPxqigs8PswZSigZ3ehlSQMqegpHt8avA52c=;
 b=YVWfXAGB0q/Fiube4E7g/6Y5so0QlXJTAjr3NbBrMIGa+eOZdO+bSdywcAO+OhG9Rz
 VfpWl3jiiaDouj+tsHxcdKkWD/NP430lp9g4chGZL4U9J8H/XxyqyDcy4Rq1EsGEnDg6
 g6RT6yFvxjtEvHZIsfXI/et3k7ZhuJSZe6r8Ai6tk4IHfPoboQvrd+5ncpp07uLWep44
 I1AsLFFHY1EJqsh6jP7ZgB+yXbb3oIeXozxaurLm1zRWljMTDGQYQcIwesc12ZbKkSLp
 LMEVgYH8oDV6fgJPYaob4GGSHw7ZVb2B9scFvDA/i9BE5JNoGHu34EYnd56OMhJeRA0Q
 ktxQ==
X-Gm-Message-State: AOJu0YxpfFwvp2ZwEuYywbVGHVKK+BRnFm08uN7Txa71Hmv7GnpRZmzl
 FQG3hQzImQPZ00uWwyWl4MipKiSXkr1NXEz44/JrIcyeKzr+iO5am1+jizChz7Waw9JtI4zxw7g
 D
X-Gm-Gg: ASbGncvaWSDRj9/C4WCvFVE1gLn6NCQjdRhlV1kPbMEaPRnbN2pF/FO/b5DgSf+qa0G
 c/ospEOqCerOnvTgDpuu1XIH7dP+XVr7jtQhFKWvLhXdttMoXfVaBJrmQn5ojLh5WxGZlY1G9NW
 B4Ulg5Dw7z67LVsGO2w0jddi99WGYi+YamciAF6qd9EYO9JCjP9IN101ysqNvURVbwarYTprTbQ
 06mBHGUa3QAu0j49BH7qOKSc7FLzPL9aiv0qdcChg9lZ8DBGSdTc4jmZ15QcJcdVJkgSumi2hpp
 0WadQ9aVWr+4PNjBehHkAHEKMsaTpIml94GUOhxdXubdP0ko0cGQ3bb2MpK8iiFSck+mLMYv7LI
 =
X-Google-Smtp-Source: AGHT+IFsM4cCDA1A2cMvaSQXYcH1A74wgYqa5w6Dh4vHxTqQdKY4DBhg9vaXSWDlRPFMGvQ+1IASuQ==
X-Received: by 2002:a05:6a00:3406:b0:736:450c:fa54 with SMTP id
 d2e1a72fcca58-740a99a988dmr1176395b3a.6.1746652384551; 
 Wed, 07 May 2025 14:13:04 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v5 03/24] target/m68k: Keep FPSR up-to-date
Date: Wed,  7 May 2025 14:12:38 -0700
Message-ID: <20250507211300.9735-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Since most of the FPSR must be updated on every insn, handle this
from the existing helper_ftst and helper_fcmp functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h        |  2 -
 target/m68k/helper.h     |  2 -
 target/m68k/cpu.c        | 10 -----
 target/m68k/fpu_helper.c | 94 +++++++++++-----------------------------
 target/m68k/helper.c     |  4 +-
 target/m68k/translate.c  |  4 +-
 6 files changed, 30 insertions(+), 86 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 035034772b..0630eb26c2 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -201,8 +201,6 @@ void cpu_m68k_set_ccr(CPUM68KState *env, uint32_t);
 void cpu_m68k_set_sr(CPUM68KState *env, uint32_t);
 void cpu_m68k_restore_fp_status(CPUM68KState *env);
 void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val);
-uint32_t cpu_m68k_get_fpsr(CPUM68KState *env);
-void cpu_m68k_set_fpsr(CPUM68KState *env, uint32_t val);
 
 /*
  * Instead of computing the condition codes after each m68k instruction,
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 95aa5e53bb..2bbe0dc032 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -54,8 +54,6 @@ DEF_HELPER_4(fsdiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fddiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fsgldiv, void, env, fp, fp, fp)
 DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
-DEF_HELPER_2(set_fpsr, void, env, i32)
-DEF_HELPER_1(get_fpsr, i32, env)
 DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
 DEF_HELPER_3(fconst, void, env, fp, i32)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 724138b302..e898156403 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -468,20 +468,11 @@ static const VMStateDescription vmstate_freg = {
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
 
@@ -490,7 +481,6 @@ const VMStateDescription vmmstate_fpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fpu_needed,
-    .pre_save = fpu_pre_save,
     .post_load = fpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.fpcr, M68kCPU),
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 3e35c20be3..195281f118 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -163,76 +163,34 @@ void HELPER(set_fpcr)(CPUM68KState *env, uint32_t val)
     cpu_m68k_set_fpcr(env, val);
 }
 
-/* Convert host exception flags to cpu_m68k form.  */
-static int cpu_m68k_exceptbits_from_host(int host_bits)
+static void update_fpsr(CPUM68KState *env, int cc)
 {
-    int target_bits = 0;
+    uint32_t fpsr = env->fpsr;
+    int flags = get_float_exception_flags(&env->fp_status);
 
-    if (host_bits & float_flag_invalid) {
-        target_bits |= FPSR_AEXP_IOP;
-    }
-    if (host_bits & float_flag_overflow) {
-        target_bits |= FPSR_AEXP_OVFL;
-    }
-    if (host_bits & (float_flag_underflow | float_flag_output_denormal_flushed)) {
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
+    fpsr |= cc;
 
-/* Convert cpu_m68k exception flags to target form.  */
-static int cpu_m68k_exceptbits_to_host(int target_bits)
-{
-    int host_bits = 0;
+    if (flags) {
+        set_float_exception_flags(0, &env->fp_status);
 
-    if (target_bits & FPSR_AEXP_IOP) {
-        host_bits |= float_flag_invalid;
+        if (flags & float_flag_invalid) {
+            fpsr |= FPSR_AEXP_IOP;
+        }
+        if (flags & float_flag_overflow) {
+            fpsr |= FPSR_AEXP_OVFL;
+        }
+        if (flags & (float_flag_underflow | float_flag_output_denormal_flushed)) {
+            fpsr |= FPSR_AEXP_UNFL;
+        }
+        if (flags & float_flag_divbyzero) {
+            fpsr |= FPSR_AEXP_DZ;
+        }
+        if (flags & float_flag_inexact) {
+            fpsr |= FPSR_AEXC_INEX;
+        }
     }
-    if (target_bits & FPSR_AEXP_OVFL) {
-        host_bits |= float_flag_overflow;
-    }
-    if (target_bits & FPSR_AEXP_UNFL) {
-        host_bits |= float_flag_underflow;
-    }
-    if (target_bits & FPSR_AEXP_DZ) {
-        host_bits |= float_flag_divbyzero;
-    }
-    if (target_bits & FPSR_AEXC_INEX) {
-        host_bits |= float_flag_inexact;
-    }
-    return host_bits;
-}
-
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
@@ -441,12 +399,12 @@ void HELPER(fcmp)(CPUM68KState *env, FPReg *val0, FPReg *val1)
     FloatRelation float_compare;
 
     float_compare = floatx80_compare(val1->d, val0->d, &env->fp_status);
-    env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | float_comp_to_cc(float_compare);
+    update_fpsr(env, float_comp_to_cc(float_compare));
 }
 
 void HELPER(ftst)(CPUM68KState *env, FPReg *val)
 {
-    uint32_t cc = 0;
+    int cc = 0;
 
     if (floatx80_is_neg(val->d)) {
         cc |= FPSR_CC_N;
@@ -459,7 +417,7 @@ void HELPER(ftst)(CPUM68KState *env, FPReg *val)
     } else if (floatx80_is_zero(val->d)) {
         cc |= FPSR_CC_Z;
     }
-    env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | cc;
+    update_fpsr(env, cc);
 }
 
 void HELPER(fconst)(CPUM68KState *env, FPReg *val, uint32_t offset)
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 15f110fa7a..b50ef6dec3 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -92,7 +92,7 @@ static int m68k_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
     case 8: /* fpcontrol */
         return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
-        return gdb_get_reg32(mem_buf, cpu_m68k_get_fpsr(env));
+        return gdb_get_reg32(mem_buf, env->fpsr);
     case 10: /* fpiar, not implemented */
         return gdb_get_reg32(mem_buf, 0);
     }
@@ -114,7 +114,7 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
         cpu_m68k_set_fpcr(env, ldl_be_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
-        cpu_m68k_set_fpsr(env, ldl_be_p(mem_buf));
+        env->fpsr = ldl_be_p(mem_buf);
         return 4;
     case 10: /* fpiar, not implemented */
         return 4;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 97afceb129..340d72bc4f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4733,7 +4733,7 @@ static void gen_load_fcr(DisasContext *s, TCGv res, int reg)
         tcg_gen_movi_i32(res, 0);
         break;
     case M68K_FPSR:
-        gen_helper_get_fpsr(res, tcg_env);
+        tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpsr));
         break;
     case M68K_FPCR:
         tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpcr));
@@ -4747,7 +4747,7 @@ static void gen_store_fcr(DisasContext *s, TCGv val, int reg)
     case M68K_FPIAR:
         break;
     case M68K_FPSR:
-        gen_helper_set_fpsr(tcg_env, val);
+        tcg_gen_st_i32(val, tcg_env, offsetof(CPUM68KState, fpsr));
         break;
     case M68K_FPCR:
         gen_helper_set_fpcr(tcg_env, val);
-- 
2.43.0


