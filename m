Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D845C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0b7-0001ij-1S; Mon, 17 Feb 2025 07:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0ac-0001cS-Ex
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:15 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0aW-0002Fb-6N
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:07 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so1685475f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739796662; x=1740401462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/heIiNNTuheTaur5LJRO3LHgfxf70HHYVHslo3rSRJU=;
 b=X8nN6a6+vfgKhBsd0iOhHqQ/Bwev2M1sHoBicYgK+A9EVs8ZKYC1vGP24b6fno4Rog
 q7OF/ldJ7c8bBOMgFKipWj7jsraB3gx+AiXH1XGbZQ6+kx7IeeFAOjQorhhoHE49jQ0m
 dofhSP2QnBHxzzJVFCHEAvT0DXK586WJT4nn0JdS/mZKjC0EKCTTys+IqM3Gs3QMEpAO
 HTjsCcKflAjd+svAGnaod1aR1UG/rpu0UxFuX65XL2WYg4UFnGVjImovbClH+bwIJ2I3
 e9hplS4yIW5JY9Bw8WZ7r6k6K6mDO4oQ+Sqv13iuD1LaZ4d1RL0nvlxJ8pAElIDutymO
 Sh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796662; x=1740401462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/heIiNNTuheTaur5LJRO3LHgfxf70HHYVHslo3rSRJU=;
 b=pbDWsAeh8eyU6sABUlnNSz2XlXGxdOAg0sA5p/2xjORbmYjWGx+7qOuEI9Bzz2w3n9
 SSUN0ZkykAARZj/6aM3jo54jov9ZtkRumqnEAmj+kosdYLX/1ORvPOfkPr7ll+tCyRwE
 rUR8R0fr2YP0cIVOvToSQKCsh4Z1Sk9QQlwjgbVeOmFlYTN9IxEoMW2rrKDIFdpfGLs2
 GlG0xS8lR8s3mPM0Aa1heIjqeg8i2MdAbLY/5r1pWABO+mD9U1rttzx6sa9RY57/8EiF
 0+Wg3eyBX56GdblfZSRWy036x7vjyx7+iG7YXpfo/Mdwzzc5v3VdmrKPPfzc540LLO0f
 nFjA==
X-Gm-Message-State: AOJu0YxDoMW4+vGELgE9WAAUMki5bxN3lE/bO0ifDPrnxz5q6DQlvwER
 iGbe8qfLMOU2ZfIrwX5U2uRj8ewwbrMoqZU5xu+2YBTk+71JtR1Qr4PrmLtIO6DxwjLPhuEYfAO
 +
X-Gm-Gg: ASbGncu6LkD1plWCsEKihpq6oPzyL+zCY8it1aUwq5Eqc+3k1aJtOu3rE/iHLO2zqyR
 Pk53sqojjWRJkxv7P+LTy7kwtFeD1PSlnJ/QAvbwr+K1X6qlcaQ33O42q1EX5lPW43O6dNMhAGH
 HpzZYePABooPssXD0G1uKLGlOYjy+725wZooZhTR5HXp/lhlXsCJKUUvIpKD+C3MZPJ09jF5fsb
 zfwSw8lAiZxD1onsu/d6glSSSyYowPVC+e92gMr1LawJRX89sxGaB2lynPF0e2Y5b8/OxVMtd6R
 QHsNgyscCkmnD1T1KyjzLA==
X-Google-Smtp-Source: AGHT+IGWGH3x8YozdAkVJZpdELHOmrASByj5nmPjLaK6O0F2wvdZYS1VdE7pT+yQ4hVGbT+V92T7uA==
X-Received: by 2002:adf:eacb:0:b0:38f:278f:58e4 with SMTP id
 ffacd0b85a97d-38f33f2861amr5927397f8f.12.1739796661987; 
 Mon, 17 Feb 2025 04:51:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm3562455e9.10.2025.02.17.04.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:51:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 04/10] fpu: Make targets specify whether floatx80 Inf can have
 Int bit clear
Date: Mon, 17 Feb 2025 12:50:49 +0000
Message-ID: <20250217125055.160887-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

In Intel terminology, a floatx80 Infinity with the explicit integer
bit clear is a "pseudo-infinity"; for x86 these are not valid
infinity values.  m68k is looser and does not care whether the
Integer bit is set or clear in an infinity.

Move this setting to runtime rather than using an ifdef in
floatx80_is_infinity().  (This requires us to pass in the
float_status to that function now.)

Since this was the last use of the floatx80_infinity global constant,
we remove it and its definition here.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat-types.h  |  5 +++++
 include/fpu/softfloat.h        | 20 ++++++++++++--------
 target/i386/tcg/fpu_helper.c   | 20 +++++++++++---------
 target/m68k/cpu.c              |  4 +++-
 target/m68k/fpu_helper.c       |  2 +-
 fpu/softfloat-specialize.c.inc | 10 ----------
 6 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index dd22ecdbe60..e1732beba4f 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -330,6 +330,11 @@ typedef enum __attribute__((__packed__)) {
 typedef enum __attribute__((__packed__)) {
     /* In the default Infinity value, is the Integer bit 0 ? */
     floatx80_default_inf_int_bit_is_zero = 1,
+    /*
+     * Are Pseudo-infinities (Inf with the Integer bit zero) valid?
+     * If so, floatx80_is_infinity() will return true for them.
+     */
+    floatx80_pseudo_inf_valid = 2,
 } FloatX80Behaviour;
 
 /*
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index afae3906024..07259c59303 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -960,7 +960,6 @@ float128 floatx80_to_float128(floatx80, float_status *status);
 /*----------------------------------------------------------------------------
 | The pattern for an extended double-precision inf.
 *----------------------------------------------------------------------------*/
-extern const floatx80 floatx80_infinity;
 floatx80 floatx80_default_inf(bool zSign, float_status *status);
 
 /*----------------------------------------------------------------------------
@@ -996,14 +995,19 @@ static inline floatx80 floatx80_chs(floatx80 a)
     return a;
 }
 
-static inline bool floatx80_is_infinity(floatx80 a)
+static inline bool floatx80_is_infinity(floatx80 a, float_status *status)
 {
-#if defined(TARGET_M68K)
-    return (a.high & 0x7fff) == floatx80_infinity.high && !(a.low << 1);
-#else
-    return (a.high & 0x7fff) == floatx80_infinity.high &&
-                       a.low == floatx80_infinity.low;
-#endif
+    /*
+     * It's target-specific whether the Integer bit is permitted
+     * to be 0 in a valid Infinity value. (x86 says no, m68k says yes).
+     */
+    bool intbit = a.low >> 63;
+
+    if (!intbit &&
+        !(status->floatx80_behaviour & floatx80_pseudo_inf_valid)) {
+        return false;
+    }
+    return (a.high & 0x7fff) == 0x7fff && !(a.low << 1);
 }
 
 static inline bool floatx80_is_neg(floatx80 a)
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 741af09f908..3b79bc049d1 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1393,7 +1393,8 @@ void helper_fpatan(CPUX86State *env)
         /* Pass this NaN through.  */
     } else if (floatx80_is_zero(ST1) && !arg0_sign) {
         /* Pass this zero through.  */
-    } else if (((floatx80_is_infinity(ST0) && !floatx80_is_infinity(ST1)) ||
+    } else if (((floatx80_is_infinity(ST0, &env->fp_status) &&
+                 !floatx80_is_infinity(ST1, &env->fp_status)) ||
                  arg0_exp - arg1_exp >= 80) &&
                !arg0_sign) {
         /*
@@ -1442,8 +1443,8 @@ void helper_fpatan(CPUX86State *env)
             rexp = pi_exp;
             rsig0 = pi_sig_high;
             rsig1 = pi_sig_low;
-        } else if (floatx80_is_infinity(ST1)) {
-            if (floatx80_is_infinity(ST0)) {
+        } else if (floatx80_is_infinity(ST1, &env->fp_status)) {
+            if (floatx80_is_infinity(ST0, &env->fp_status)) {
                 if (arg0_sign) {
                     rexp = pi_34_exp;
                     rsig0 = pi_34_sig_high;
@@ -1462,7 +1463,8 @@ void helper_fpatan(CPUX86State *env)
             rexp = pi_2_exp;
             rsig0 = pi_2_sig_high;
             rsig1 = pi_2_sig_low;
-        } else if (floatx80_is_infinity(ST0) || arg0_exp - arg1_exp >= 80) {
+        } else if (floatx80_is_infinity(ST0, &env->fp_status) ||
+                   arg0_exp - arg1_exp >= 80) {
             /* ST0 is negative.  */
             rexp = pi_exp;
             rsig0 = pi_sig_high;
@@ -1829,7 +1831,7 @@ void helper_fxtract(CPUX86State *env)
         }
         fpush(env);
         ST0 = ST1;
-    } else if (floatx80_is_infinity(ST0)) {
+    } else if (floatx80_is_infinity(ST0, &env->fp_status)) {
         fpush(env);
         ST0 = ST1;
         ST1 = floatx80_default_inf(0, &env->fp_status);
@@ -2173,7 +2175,7 @@ void helper_fyl2x(CPUX86State *env)
     } else if (arg0_sign && !floatx80_is_zero(ST0)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_default_nan(&env->fp_status);
-    } else if (floatx80_is_infinity(ST1)) {
+    } else if (floatx80_is_infinity(ST1, &env->fp_status)) {
         FloatRelation cmp = floatx80_compare(ST0, floatx80_one,
                                              &env->fp_status);
         switch (cmp) {
@@ -2188,7 +2190,7 @@ void helper_fyl2x(CPUX86State *env)
             ST1 = floatx80_default_nan(&env->fp_status);
             break;
         }
-    } else if (floatx80_is_infinity(ST0)) {
+    } else if (floatx80_is_infinity(ST0, &env->fp_status)) {
         if (floatx80_is_zero(ST1)) {
             float_raise(float_flag_invalid, &env->fp_status);
             ST1 = floatx80_default_nan(&env->fp_status);
@@ -2341,11 +2343,11 @@ void helper_fscale(CPUX86State *env)
             float_raise(float_flag_invalid, &env->fp_status);
             ST0 = floatx80_silence_nan(ST0, &env->fp_status);
         }
-    } else if (floatx80_is_infinity(ST1) &&
+    } else if (floatx80_is_infinity(ST1, &env->fp_status) &&
                !floatx80_invalid_encoding(ST0) &&
                !floatx80_is_any_nan(ST0)) {
         if (floatx80_is_neg(ST1)) {
-            if (floatx80_is_infinity(ST0)) {
+            if (floatx80_is_infinity(ST0, &env->fp_status)) {
                 float_raise(float_flag_invalid, &env->fp_status);
                 ST0 = floatx80_default_nan(&env->fp_status);
             } else {
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index df66e8ba22a..56b23de21fe 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -110,8 +110,10 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
     /*
      * m68k-specific floatx80 behaviour:
      *  * default Infinity values have a zero Integer bit
+     *  * input Infinities may have the Integer bit either 0 or 1
      */
-    set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero,
+    set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero |
+                           floatx80_pseudo_inf_valid,
                            &env->fp_status);
 
     nan = floatx80_default_nan(&env->fp_status);
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 339b73ad7dc..eb1cb8c6872 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -455,7 +455,7 @@ void HELPER(ftst)(CPUM68KState *env, FPReg *val)
 
     if (floatx80_is_any_nan(val->d)) {
         cc |= FPSR_CC_A;
-    } else if (floatx80_is_infinity(val->d)) {
+    } else if (floatx80_is_infinity(val->d, &env->fp_status)) {
         cc |= FPSR_CC_I;
     } else if (floatx80_is_zero(val->d)) {
         cc |= FPSR_CC_Z;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 73789e97d77..8327f727861 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -237,16 +237,6 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
     return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
 }
 
-#define floatx80_infinity_high 0x7FFF
-#if defined(TARGET_M68K)
-#define floatx80_infinity_low  UINT64_C(0x0000000000000000)
-#else
-#define floatx80_infinity_low  UINT64_C(0x8000000000000000)
-#endif
-
-const floatx80 floatx80_infinity
-    = make_floatx80_init(floatx80_infinity_high, floatx80_infinity_low);
-
 /*----------------------------------------------------------------------------
 | Returns 1 if the half-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
-- 
2.43.0


