Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA066CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZ8-0001TR-JO; Wed, 20 May 2026 13:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ6-0001QI-5o
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:40 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ0-0001x4-TV
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:39 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-366375c4076so1991966a91.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297513; x=1779902313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dIEeehv80CK8xO9ylejpJt2WMFMMHvjzFTzV0srVG0=;
 b=Nelbznqs6D8CT5xGHK+7YBj+EHzZEfglRKTpzkTsGqfze2OFCiq8SZ5mmNyj4MxSn+
 zrMld+QXiAM87kop0n9t6iyORLXZDeJQ1cW6P4QPyWOZXBCRBD4p2OmUNBtfyrxWSkXp
 LiEzC5DTbTHhzmE2AtWVdZY0rNs/G679yKYXZlYeNerasohBjkiWjrx8Qs/JdEJW29ix
 0r7jzO7j1txRhTqZGpuGwlE5hnb9d9OvSbZi/HShRbVYVrkxFpNdFddx8FcD0ZpuqkXS
 UtMLEkyVwL6DflsH5zqd1IjIo/az+BNo57zz+At6CvFrtMYM5l+76o4l60Vq+lLhXc5s
 AoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297513; x=1779902313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+dIEeehv80CK8xO9ylejpJt2WMFMMHvjzFTzV0srVG0=;
 b=KGypLz3VkwUyqy++ivk0cg9SRuLoHAtDqd6UgxhdwW9xB2ADFXiJMo2Wnx2y+epIpX
 NQeaSxOnT8sa4Dgi2S0RTQMNjfWhloheNa08koylMMgJm9QJMo+4HcgzAdvEwa57zYRs
 23sWqmPakgMzQ3AwxbFVp3Tq2eS1e3jOMNAwuAPH8UQ6SGK9ZrjHb+RpScbrmZItf5mn
 nhwJgX6Ijm+bHhHi1f5F5ysg9hoYSBGlZwRdj8y/4vMq2jfr2o7OE5M+eDlx1vHlf4Ev
 a9olCR3pto8x32QkcMc7NXCkKPZNYESbMXFuMizDCZTgTd5VTRsMGdusfzSBBjd8VFfQ
 ZfAA==
X-Gm-Message-State: AOJu0YwiTZPu/rQ30qeTjtRYTw/8PBPDw4BgWEaTXlTXUm7qpQ+7pVHA
 OMcE7NMj+I1K5j/jKux3WLSYZwwDQcDD+PV61IZxFiDPVuIZWASkgLVpGToABBjMo1ZhpDOz421
 H1hzCoMc=
X-Gm-Gg: Acq92OGHwe5/QpIrg/5KG0g5mPDBsHGLT57hcgzp+Oj0QSl6wQxQAhZZSmjAOHRlmVS
 4xt+RaRjKCn5Rm07JjQjVH6ZpQknn/0lPtMsM1/OSJvfe4zMmfGtZ9DNkSzuxVicqwgpUXCPRIs
 Ga/ig2NLXNDLuQz37Dqgvwvkwu41pM8IjLG1PEFRJj4Y8IwTodRxEdzZUgZa9JKJNlGBaGM+gh8
 ofUlhbWCOKSvWHWBOhifw2OiE8I8PmatLJW9uW5/gh0K2SbYi4alyzyot+wk/51B/DVnrczACzM
 AhTph84A68tllsRBdJjYzdF4siVT6jwp7MmshcgtqwWkd1ei+eMkojdZM2VFnq9Pp6WxluqyFVg
 27+g6KyOG+49s5XspvoEMtvBV33elwKRib0jXB81zpao68PZ8NxRvIAE0Drb1okWBPGC/1oCV68
 RAJietF8u8cDmm9qQOmAC+5cgo6xC8LTFMD0D81YM=
X-Received: by 2002:a17:90b:4c49:b0:369:bddb:79bd with SMTP id
 98e67ed59e1d1-369bddb8547mr13771020a91.25.1779297513151; 
 Wed, 20 May 2026 10:18:33 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 15/30] fpu: Use of {get,
 set}_floatx80_rounding_precision everywhere
Date: Wed, 20 May 2026 10:18:05 -0700
Message-ID: <20260520171820.848839-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c              |  10 +-
 target/i386/tcg/fpu_helper.c |  37 ++++---
 target/m68k/softfloat.c      | 208 ++++++++++++++++++-----------------
 tests/fp/fp-test.c           |   2 +-
 4 files changed, 130 insertions(+), 127 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d99543cc60..d2a9f97089 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1515,7 +1515,7 @@ float128 float128_round_pack_canonical(FloatParts128 *p, float_status *s)
 bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f, float_status *s)
 {
     /* Ensure rounding precision is set before beginning. */
-    switch (s->floatx80_rounding_precision) {
+    switch (get_floatx80_rounding_precision(s)) {
     case floatx80_precision_x:
     case floatx80_precision_d:
     case floatx80_precision_s:
@@ -1550,14 +1550,14 @@ bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f, float_status *s)
 
 floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s)
 {
-    const FloatFmt *fmt = &floatx80_params[s->floatx80_rounding_precision];
+    const FloatFmt *fmt = &floatx80_params[get_floatx80_rounding_precision(s)];
     uint64_t frac;
     int exp;
 
     switch (p->cls) {
     case float_class_normal:
     case float_class_denormal:
-        if (s->floatx80_rounding_precision == floatx80_precision_x) {
+        if (get_floatx80_rounding_precision(s) == floatx80_precision_x) {
             parts128_uncanon_normal(p, s, fmt, false);
             frac = p->frac_hi;
             exp = p->exp;
@@ -2853,7 +2853,7 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
     }
 
     p = parts128_round_to_int(&p, get_float_rounding_mode(status), 0, status,
-                              &floatx80_params[status->floatx80_rounding_precision]);
+                              &floatx80_params[get_floatx80_rounding_precision(status)]);
     return floatx80_round_pack_canonical(&p, status);
 }
 
@@ -4503,7 +4503,7 @@ floatx80 floatx80_sqrt(floatx80 a, float_status *s)
     if (!floatx80_unpack_canonical(&p, a, s)) {
         return floatx80_default_nan(s);
     }
-    parts128_sqrt(&p, s, &floatx80_params[s->floatx80_rounding_precision]);
+    parts128_sqrt(&p, s, &floatx80_params[get_floatx80_rounding_precision(s)]);
     return floatx80_round_pack_canonical(&p, s);
 }
 
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 7b0b0dd520..978eb1411b 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1185,9 +1185,9 @@ void helper_f2xm1(CPUX86State *env)
         uint64_t asig0, asig1, asig2, bsig0, bsig1;
         FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
         FloatX80RoundPrec save_prec =
-            env->fp_status.floatx80_rounding_precision;
+            get_floatx80_rounding_precision(&env->fp_status);
         set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+        set_floatx80_rounding_precision(floatx80_precision_x, &env->fp_status);
 
         /* Find the nearest multiple of 1/32 to the argument.  */
         tmp = floatx80_scalbn(ST0, 5, &env->fp_status);
@@ -1290,7 +1290,7 @@ void helper_f2xm1(CPUX86State *env)
                                                 &env->fp_status);
         }
 
-        env->fp_status.floatx80_rounding_precision = save_prec;
+        set_floatx80_rounding_precision(save_prec, &env->fp_status);
     }
     merge_exception_flags(env, old_flags);
 }
@@ -1406,10 +1406,10 @@ void helper_fpatan(CPUX86State *env)
          * (and underflowing where appropriate).
          */
         FloatX80RoundPrec save_prec =
-            env->fp_status.floatx80_rounding_precision;
-        env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+            get_floatx80_rounding_precision(&env->fp_status);
+        set_floatx80_rounding_precision(floatx80_precision_x, &env->fp_status);
         ST1 = floatx80_div(ST1, ST0, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = save_prec;
+        set_floatx80_rounding_precision(save_prec, &env->fp_status);
         if (!floatx80_is_zero(ST1) &&
             !(get_float_exception_flags(&env->fp_status) &
               float_flag_inexact)) {
@@ -1485,9 +1485,10 @@ void helper_fpatan(CPUX86State *env)
             floatx80 x8;
             FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
             FloatX80RoundPrec save_prec =
-                env->fp_status.floatx80_rounding_precision;
+                get_floatx80_rounding_precision(&env->fp_status);
             set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-            env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+            set_floatx80_rounding_precision(floatx80_precision_x,
+                                            &env->fp_status);
 
             if (arg0_exp == 0) {
                 normalizeFloatx80Subnormal(arg0_sig, &arg0_exp, &arg0_sig);
@@ -1794,7 +1795,7 @@ void helper_fpatan(CPUX86State *env)
             }
 
             set_float_rounding_mode(save_mode, &env->fp_status);
-            env->fp_status.floatx80_rounding_precision = save_prec;
+            set_floatx80_rounding_precision(save_prec, &env->fp_status);
         }
         /* This result is inexact.  */
         rsig1 |= 1;
@@ -2123,9 +2124,9 @@ void helper_fyl2xp1(CPUX86State *env)
         uint64_t asig0, asig1, asig2;
         FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
         FloatX80RoundPrec save_prec =
-            env->fp_status.floatx80_rounding_precision;
+            get_floatx80_rounding_precision(&env->fp_status);
         set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+        set_floatx80_rounding_precision(floatx80_precision_x, &env->fp_status);
 
         helper_fyl2x_common(env, ST0, &aexp, &asig0, &asig1);
         /*
@@ -2143,7 +2144,7 @@ void helper_fyl2xp1(CPUX86State *env)
         ST1 = normalizeRoundAndPackFloatx80(floatx80_precision_x,
                                             arg0_sign ^ arg1_sign, aexp,
                                             asig0, asig1, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = save_prec;
+        set_floatx80_rounding_precision(save_prec, &env->fp_status);
     }
     fpop(env);
     merge_exception_flags(env, old_flags);
@@ -2226,9 +2227,9 @@ void helper_fyl2x(CPUX86State *env)
         floatx80 arg0_m1;
         FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
         FloatX80RoundPrec save_prec =
-            env->fp_status.floatx80_rounding_precision;
+            get_floatx80_rounding_precision(&env->fp_status);
         set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+        set_floatx80_rounding_precision(floatx80_precision_x, &env->fp_status);
 
         if (arg0_exp == 0) {
             normalizeFloatx80Subnormal(arg0_sig, &arg0_exp, &arg0_sig);
@@ -2290,7 +2291,7 @@ void helper_fyl2x(CPUX86State *env)
                                                 asig0, asig1, &env->fp_status);
         }
 
-        env->fp_status.floatx80_rounding_precision = save_prec;
+        set_floatx80_rounding_precision(save_prec, &env->fp_status);
     }
     fpop(env);
     merge_exception_flags(env, old_flags);
@@ -2368,14 +2369,14 @@ void helper_fscale(CPUX86State *env)
         }
     } else {
         int n;
-        FloatX80RoundPrec save = env->fp_status.floatx80_rounding_precision;
+        FloatX80RoundPrec save = get_floatx80_rounding_precision(&env->fp_status);
         int save_flags = get_float_exception_flags(&env->fp_status);
         set_float_exception_flags(0, &env->fp_status);
         n = floatx80_to_int32_round_to_zero(ST1, &env->fp_status);
         set_float_exception_flags(save_flags, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
+        set_floatx80_rounding_precision(floatx80_precision_x, &env->fp_status);
         ST0 = floatx80_scalbn(ST0, n, &env->fp_status);
-        env->fp_status.floatx80_rounding_precision = save;
+        set_floatx80_rounding_precision(save, &env->fp_status);
     }
     merge_exception_flags(env, old_flags);
 }
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 51706f6db8..f5d683bcc5 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -72,7 +72,8 @@ floatx80 floatx80_getman(floatx80 a, float_status *status)
         normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
     }
 
-    return roundAndPackFloatx80(status->floatx80_rounding_precision, aSign,
+    return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                aSign,
                                 0x3FFF, aSig, 0, status);
 }
 
@@ -160,7 +161,7 @@ floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status)
 
     if (0x400F < bExp) {
         aExp = bSign ? -0x6001 : 0xE000;
-        return roundAndPackFloatx80(status->floatx80_rounding_precision,
+        return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                     aSign, aExp, aSig, 0, status);
     }
 
@@ -168,7 +169,7 @@ floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status)
     bSig >>= shiftCount;
     aExp = bSign ? (aExp - bSig) : (aExp + bSig);
 
-    return roundAndPackFloatx80(status->floatx80_rounding_precision,
+    return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                 aSign, aExp, aSig, 0, status);
 }
 
@@ -192,10 +193,11 @@ floatx80 floatx80_move(floatx80 a, float_status *status)
         if (aSig == 0) {
             return a;
         }
-        normalizeRoundAndPackFloatx80(status->floatx80_rounding_precision,
+        normalizeRoundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                       aSign, aExp, aSig, 0, status);
     }
-    return roundAndPackFloatx80(status->floatx80_rounding_precision, aSign,
+    return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                aSign,
                                 aExp, aSig, 0, status);
 }
 
@@ -267,9 +269,9 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -337,7 +339,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fp1, status); /* FP0 IS LOG(F) + LOG(1+U) */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(fp0, klog2, status);
 
@@ -403,7 +405,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
                            status); /* U*V*([B1+W*(B3+W*B5)] + [V*(B2+W*B4)]) */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(fp0, saveu, status);
 
@@ -465,9 +467,9 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -524,7 +526,7 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fp1, status); /* FP0 IS LOG(F) + LOG(1+U) */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(fp0, klog2, status);
 
@@ -570,7 +572,7 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
                            status); /* U*V*([B1+W*(B3+W*B5)] + [V*(B2+W*B4)]) */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(fp0, saveu, status);
 
@@ -621,15 +623,15 @@ floatx80 floatx80_log10(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     fp0 = floatx80_logn(a, status);
     fp1 = packFloatx80(0, 0x3FFD, UINT64_C(0xDE5BD8A937287195)); /* INV_L10 */
 
     set_float_rounding_mode(user_rnd_mode, status);
-    status->floatx80_rounding_precision = user_rnd_prec;
+    set_floatx80_rounding_precision(user_rnd_prec, status);
 
     a = floatx80_mul(fp0, fp1, status); /* LOGN(X)*INV_L10 */
 
@@ -680,13 +682,13 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     if (aSig == one_sig) { /* X is 2^k */
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = int32_to_floatx80(aExp - 0x3FFF, status);
     } else {
@@ -694,7 +696,7 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
         fp1 = packFloatx80(0, 0x3FFF, UINT64_C(0xB8AA3B295C17F0BC)); /* INV_L2 */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_mul(fp0, fp1, status); /* LOGN(X)*INV_L2 */
     }
@@ -740,9 +742,9 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     adjflag = 0;
 
@@ -818,7 +820,7 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
             }
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_mul(fp0, scale, status);
 
@@ -828,15 +830,13 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
         } else { /* |X| >= 16380 log2 */
             if (compact > 0x400CB27C) { /* |X| >= 16480 log2 */
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
                 if (aSign) {
-                    a = roundAndPackFloatx80(
-                                           status->floatx80_rounding_precision,
-                                           0, -0x1000, aSig, 0, status);
+                    a = roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                             0, -0x1000, aSig, 0, status);
                 } else {
-                    a = roundAndPackFloatx80(
-                                           status->floatx80_rounding_precision,
-                                           0, 0x8000, aSig, 0, status);
+                    a = roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                             0, 0x8000, aSig, 0, status);
                 }
                 float_raise(float_flag_inexact, status);
 
@@ -877,7 +877,7 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
         }
     } else { /* |X| < 2^(-65) */
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(a, float32_to_floatx80(make_float32(0x3F800000),
                          status), status); /* 1 + X */
@@ -923,9 +923,9 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     fp0 = a;
 
@@ -935,18 +935,18 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
         /* |X| > 16480 or |X| < 2^(-70) */
         if (compact > 0x3FFF8000) { /* |X| > 16480 */
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             if (aSign) {
-                return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                             0, -0x1000, aSig, 0, status);
             } else {
-                return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                             0, 0x8000, aSig, 0, status);
             }
         } else { /* |X| < 2^(-70) */
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, float32_to_floatx80(
                              make_float32(0x3F800000), status),
@@ -1028,7 +1028,7 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fact1, status);
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_mul(fp0, adjfact, status);
 
@@ -1073,9 +1073,9 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     fp0 = a;
 
@@ -1085,18 +1085,18 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
         /* |X| > 16480 LOG2/LOG10 or |X| < 2^(-70) */
         if (compact > 0x3FFF8000) { /* |X| > 16480 */
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             if (aSign) {
-                return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                             0, -0x1000, aSig, 0, status);
             } else {
-                return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                             0, 0x8000, aSig, 0, status);
             }
         } else { /* |X| < 2^(-70) */
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, float32_to_floatx80(
                              make_float32(0x3F800000), status),
@@ -1183,7 +1183,7 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fact1, status);
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_mul(fp0, adjfact, status);
 
@@ -1228,9 +1228,9 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -1295,7 +1295,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
             goto loop;
         } else {
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_move(a, status);
 
@@ -1355,7 +1355,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
             fp1 = packFloatx80(xSign, xExp, xSig);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_div(fp0, fp1, status);
 
@@ -1393,7 +1393,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
                                status); /* 1+S(Q1+S(Q2+S(Q3+SQ4))) */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_div(fp0, fp1, status);
 
@@ -1439,9 +1439,9 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -1510,7 +1510,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
                                       status); /* 1 */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             /* SINTINY */
             a = floatx80_move(a, status);
@@ -1583,7 +1583,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, x, status);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, float32_to_floatx80(posneg1, status), status);
 
@@ -1633,7 +1633,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, fp1, status); /* SIN(R')-R' */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, x, status);
 
@@ -1679,9 +1679,9 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -1749,7 +1749,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             fp0 = float32_to_floatx80(make_float32(0x3F800000), status); /* 1 */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             /* COSTINY */
             a = floatx80_sub(fp0, float32_to_floatx80(
@@ -1823,7 +1823,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, x, status);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, float32_to_floatx80(posneg1, status), status);
 
@@ -1871,7 +1871,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, fp1, status); /* SIN(R')-R' */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, x, status);
 
@@ -1918,9 +1918,9 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
     compact = floatx80_make_compact(aExp, aSig);
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     if (compact < 0x3FFB8000 || compact > 0x4002FFFF) {
         /* |X| >= 16 or |X| < 1/16 */
@@ -1930,7 +1930,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
                 fp1 = packFloatx80(aSign, 0x0001, one_sig);
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_sub(fp0, fp1, status);
 
@@ -1970,7 +1970,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
                 fp1 = packFloatx80(aSign, piby2_exp, pi_sig);
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp0, fp1, status);
 
@@ -1981,7 +1981,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
         } else { /* |X| < 1/16 */
             if (compact < 0x3FD78000) { /* |X| < 2^(-40) */
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_move(a, status);
 
@@ -2021,7 +2021,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
                 fp0 = floatx80_mul(fp0, fp1, status);
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp0, xsave, status);
 
@@ -2070,7 +2070,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fp1, status); /* ATAN(U) */
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_add(fp0, fp3, status); /* ATAN(X) */
 
@@ -2123,9 +2123,9 @@ floatx80 floatx80_asin(floatx80 a, float_status *status)
     } /* |X| < 1 */
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     one = packFloatx80(0, one_exp, one_sig);
     fp0 = a;
@@ -2137,7 +2137,7 @@ floatx80 floatx80_asin(floatx80 a, float_status *status)
     fp0 = floatx80_div(fp0, fp1, status);   /* X/SQRT((1+X)*(1-X)) */
 
     set_float_rounding_mode(user_rnd_mode, status);
-    status->floatx80_rounding_precision = user_rnd_prec;
+    set_floatx80_rounding_precision(user_rnd_prec, status);
 
     a = floatx80_atan(fp0, status);         /* ATAN(X/SQRT((1+X)*(1-X))) */
 
@@ -2171,7 +2171,8 @@ floatx80 floatx80_acos(floatx80 a, float_status *status)
     }
     if (aExp == 0 && aSig == 0) {
         float_raise(float_flag_inexact, status);
-        return roundAndPackFloatx80(status->floatx80_rounding_precision, 0,
+        return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                    0,
                                     piby2_exp, pi_sig, 0, status);
     }
 
@@ -2193,9 +2194,9 @@ floatx80 floatx80_acos(floatx80 a, float_status *status)
     } /* |X| < 1 */
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     one = packFloatx80(0, one_exp, one_sig);
     fp0 = a;
@@ -2207,7 +2208,7 @@ floatx80 floatx80_acos(floatx80 a, float_status *status)
     fp0 = floatx80_atan(fp0, status);       /* ATAN(SQRT((1-X)/(1+X))) */
 
     set_float_rounding_mode(user_rnd_mode, status);
-    status->floatx80_rounding_precision = user_rnd_prec;
+    set_floatx80_rounding_precision(user_rnd_prec, status);
 
     a = floatx80_add(fp0, fp0, status);     /* 2 * ATAN(SQRT((1-X)/(1+X))) */
 
@@ -2257,9 +2258,9 @@ floatx80 floatx80_atanh(floatx80 a, float_status *status)
     } /* |X| < 1 */
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     one = packFloatx80(0, one_exp, one_sig);
     fp2 = packFloatx80(aSign, 0x3FFE, one_sig); /* SIGN(X) * (1/2) */
@@ -2271,7 +2272,7 @@ floatx80 floatx80_atanh(floatx80 a, float_status *status)
     fp0 = floatx80_lognp1(fp0, status); /* LOG1P(Z) */
 
     set_float_rounding_mode(user_rnd_mode, status);
-    status->floatx80_rounding_precision = user_rnd_prec;
+    set_floatx80_rounding_precision(user_rnd_prec, status);
 
     a = floatx80_mul(fp0, fp2,
                      status); /* ATANH(X) = SIGN(X) * (1/2) * LOG1P(Z) */
@@ -2316,9 +2317,9 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     if (aExp >= 0x3FFD) { /* |X| >= 1/4 */
         compact = floatx80_make_compact(aExp, aSig);
@@ -2411,7 +2412,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
             sc = packFloatx80(0, m + 0x3FFF, one_sig);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_mul(fp0, sc, status);
 
@@ -2424,7 +2425,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
                       status); /* -1 */
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp0, float32_to_floatx80(
                                  make_float32(0x00800000), status),
@@ -2435,7 +2436,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
                 return a;
             } else {
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 return floatx80_etox(a, status);
             }
@@ -2496,7 +2497,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
             fp0 = floatx80_add(fp0, fp1, status); /* S*B1+Q */
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_add(fp0, a, status);
 
@@ -2514,14 +2515,14 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
                 fp0 = floatx80_add(fp0, sc, status);
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_mul(fp0, float64_to_floatx80(
                                  make_float64(0x3730000000000000), status),
                                  status);
             } else {
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp0, sc, status);
             }
@@ -2566,9 +2567,9 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -2577,7 +2578,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
         if (compact < 0x3FFF8000) {
             /* TANHSM */
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_move(a, status);
 
@@ -2594,7 +2595,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
                 sign ^= 0x80800000; /* -SIGN(X)*EPS */
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp0, float32_to_floatx80(make_float32(sign),
                                  status), status);
@@ -2616,7 +2617,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
                                           status); /* SIGN */
 
                 set_float_rounding_mode(user_rnd_mode, status);
-                status->floatx80_rounding_precision = user_rnd_prec;
+                set_floatx80_rounding_precision(user_rnd_prec, status);
 
                 a = floatx80_add(fp1, fp0, status);
 
@@ -2639,7 +2640,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
         fp1 = packFloatx80(vSign ^ aSign, vExp, vSig);
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_div(fp0, fp1, status);
 
@@ -2682,9 +2683,9 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
@@ -2692,9 +2693,9 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
         /* SINHBIG */
         if (compact > 0x400CB2B3) {
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
-            return roundAndPackFloatx80(status->floatx80_rounding_precision,
+            return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
                                         aSign, 0x8000, aSig, 0, status);
         } else {
             fp0 = floatx80_abs(a); /* Y = |X| */
@@ -2708,7 +2709,7 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
             fp2 = packFloatx80(aSign, 0x7FFB, one_sig);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_mul(fp0, fp2, status);
 
@@ -2728,7 +2729,7 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
         fact = packFloat32(aSign, 0x7E, 0);
 
         set_float_rounding_mode(user_rnd_mode, status);
-        status->floatx80_rounding_precision = user_rnd_prec;
+        set_floatx80_rounding_precision(user_rnd_prec, status);
 
         a = floatx80_mul(fp0, float32_to_floatx80(fact, status), status);
 
@@ -2768,17 +2769,18 @@ floatx80 floatx80_cosh(floatx80 a, float_status *status)
     }
 
     user_rnd_mode = get_float_rounding_mode(status);
-    user_rnd_prec = status->floatx80_rounding_precision;
+    user_rnd_prec = get_floatx80_rounding_precision(status);
     set_float_rounding_mode(float_round_nearest_even, status);
-    status->floatx80_rounding_precision = floatx80_precision_x;
+    set_floatx80_rounding_precision(floatx80_precision_x, status);
 
     compact = floatx80_make_compact(aExp, aSig);
 
     if (compact > 0x400CB167) {
         if (compact > 0x400CB2B3) {
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
-            return roundAndPackFloatx80(status->floatx80_rounding_precision, 0,
+            set_floatx80_rounding_precision(user_rnd_prec, status);
+            return roundAndPackFloatx80(get_floatx80_rounding_precision(status),
+                                        0,
                                         0x8000, one_sig, 0, status);
         } else {
             fp0 = packFloatx80(0, aExp, aSig);
@@ -2792,7 +2794,7 @@ floatx80 floatx80_cosh(floatx80 a, float_status *status)
             fp1 = packFloatx80(0, 0x7FFB, one_sig);
 
             set_float_rounding_mode(user_rnd_mode, status);
-            status->floatx80_rounding_precision = user_rnd_prec;
+            set_floatx80_rounding_precision(user_rnd_prec, status);
 
             a = floatx80_mul(fp0, fp1, status);
 
@@ -2810,7 +2812,7 @@ floatx80 floatx80_cosh(floatx80 a, float_status *status)
     fp1 = floatx80_div(fp1, fp0, status); /* 1/(2*EXP(|X|)) */
 
     set_float_rounding_mode(user_rnd_mode, status);
-    status->floatx80_rounding_precision = user_rnd_prec;
+    set_floatx80_rounding_precision(user_rnd_prec, status);
 
     a = floatx80_add(fp0, fp1, status);
 
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index fdb0cccf14..326a1201f3 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -996,7 +996,7 @@ void run_test(void)
 
                 verCases_roundingPrecision = 0;
                 slow_extF80_roundingPrecision = prec80;
-                qsf.floatx80_rounding_precision = qsf_prec80;
+                set_floatx80_rounding_precision(qsf_prec80, &qsf);
 
                 if (attrs & FUNC_EFF_ROUNDINGPRECISION) {
                     verCases_roundingPrecision = prec80;
-- 
2.43.0


