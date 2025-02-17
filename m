Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28699C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0b5-0001h6-0m; Mon, 17 Feb 2025 07:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0ac-0001cU-FG
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0aY-0002Fp-8p
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:10 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4395f66a639so25706225e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739796663; x=1740401463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdTvCPTgQi9AfOqQ9ImRmmOJs3p65Zqm7Exvby9osFQ=;
 b=OM70bmfqL3Rt5R9xGjqKNWbwpBIE2j6ezqKK245ND7hNDk7+yCHepmd3DFkyYvjgS+
 ryE90I1jV6eHibgGN2VkSFDbGfd1Ln5KEGYJAy3OVvRS52eI7HtllIx6X68d77XI1d4V
 GEIGjQLIWxSvbIdDMhwxyv4LT15zWubO0EhjEsdd1aCKhZO2zxFwyTUJ4EyoKFa7CdOs
 ZQZfWwwLDicd1mdx47XheL8+InA4auDNCjYLwnYanO7gHah7C4v8J34FmKuT4PlyU+s7
 7Aa7VWoj8GNmrurDBepFmbiQqY9GrhrOx9cmfc7JLHTBVBQQw+1K9bscxlsYUK5k4ZM5
 Es1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796663; x=1740401463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DdTvCPTgQi9AfOqQ9ImRmmOJs3p65Zqm7Exvby9osFQ=;
 b=TBFFupJPwninjwmo3n1NB0Qxv37rpK9vlOcAQMLlvz5+3nur/L/h3C7kz0BMo0wb9+
 qDm0yXqHuOmYGHDYhx3awWHO5eHT02wyXbVMikirCIePIukl8AyS+MyrtR65suR7fyk4
 QgFE/WYuI3wOwFMPxV5yCnglyUo6WEz6+ftGkr67tto+V1RzbrbCaHW373yMIxQ5e+NS
 qylsB4XrVEhA/x60+I/UXGKJTF5hm038hB7grJxUnar1VEQrMRq1W36yhAr+yGhJHNWb
 KKrSDLZKLqHufYxW/SLa+NOgPW5yt0hLdNZPl9c99EisznEOY0L0vEPGGF6njZBDNsRp
 eAeQ==
X-Gm-Message-State: AOJu0YzAuuggtF+xKvPolSutResuhFfDUCvxt+BmwRQN3qLQczWcsvle
 O+regVmyqtIBYz9figFcbs8r+w0Cs70XhpfQfZR+QdRcbQuXkhd9hkcg753sQQAHx2CvcUnFjx6
 Y
X-Gm-Gg: ASbGncvBsjCKNomUTwiiYWW8WXKxGXT9D+SBXFuPct/5lYGoOE1nk0uY68ooG2cwqvx
 Bsxn3Ryf/MKIYn/QRai5L45UEXzTZf1wzpbnuGhGwYJ5zhI34eZL3sE5lmcNXWxhBa2mJXJck9u
 ZRwSNS+5ooluQvaOQqWMWQkCh8bpezE59W1i+jQg2l6qozUaS6hNjNCQAkXX/Qj0ddxHWDouoiz
 TEJJHZ/yvYfBC5YqaXcPnZArQlmpyEUZsGD0aA6inTms8xAY6vTENknYAVCz8zLumkuKEf1BjzM
 i2aBDKitEnbuxCUj9hhpKw==
X-Google-Smtp-Source: AGHT+IFKFtATw7+13t+zhoD3vtUQT+hdKO3zjJDTqMWh7ko4o0/ICoyKJKB5a9qrgy+aRQniu1AuOA==
X-Received: by 2002:a05:600c:1c97:b0:439:403a:6b77 with SMTP id
 5b1f17b1804b1-4396e6c944dmr91966725e9.10.1739796662969; 
 Mon, 17 Feb 2025 04:51:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm3562455e9.10.2025.02.17.04.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:51:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 05/10] fpu: Make floatx80 invalid encoding settable at runtime
Date: Mon, 17 Feb 2025 12:50:50 +0000
Message-ID: <20250217125055.160887-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Because floatx80 has an explicit integer bit, this permits some
odd encodings where the integer bit is not set correctly for the
floating point value type. In In Intel terminology the
 categories are:
  exp == 0, int = 0, mantissa == 0 : zeroes
  exp == 0, int = 0, mantissa != 0 : denormals
  exp == 0, int = 1 : pseudo-denormals
  0 < exp < 0x7fff, int = 0 : unnormals
  0 < exp < 0x7fff, int = 1 : normals
  exp == 0x7fff, int = 0, mantissa == 0 : pseudo-infinities
  exp == 0x7fff, int = 1, mantissa == 0 : infinities
  exp == 0x7fff, int = 0, mantissa != 0 : pseudo-NaNs
  exp == 0x7fff, int = 1, mantissa == 0 : NaNs

The usual IEEE cases of zero, denormal, normal, inf and NaN are always valid.
x87 permits as input also pseudo-denormals.
m68k permits all those and also pseudo-infinities, pseudo-NaNs and unnormals.

Currently we have an ifdef in floatx80_invalid_encoding() to select
the x86 vs m68k behaviour.  Add new floatx80_behaviour flags to
select whether pseudo-NaN and unnormal are valid, and use these
(plus the existing pseudo_inf_valid flag) to decide whether these
encodings are invalid at runtime.

We leave pseudo-denormals as always-valid, since both x86 and m68k
accept them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat-types.h | 14 +++++++
 include/fpu/softfloat.h       | 70 ++++++++++++++++++-----------------
 fpu/softfloat.c               |  2 +-
 target/i386/tcg/fpu_helper.c  | 24 ++++++------
 target/m68k/cpu.c             | 28 +++++++++++++-
 5 files changed, 92 insertions(+), 46 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index e1732beba4f..b1941384aef 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -333,8 +333,22 @@ typedef enum __attribute__((__packed__)) {
     /*
      * Are Pseudo-infinities (Inf with the Integer bit zero) valid?
      * If so, floatx80_is_infinity() will return true for them.
+     * If not, floatx80_invalid_encoding will return false for them,
+     * and using them as inputs to a float op will raise Invalid.
      */
     floatx80_pseudo_inf_valid = 2,
+    /*
+     * Are Pseudo-NaNs (NaNs where the Integer bit is zero) valid?
+     * If not, floatx80_invalid_encoding() will return false for them,
+     * and using them as inputs to a float op will raise Invalid.
+     */
+    floatx80_pseudo_nan_valid = 4,
+    /*
+     * Are Unnormals (0 < exp < 0x7fff, Integer bit zero) valid?
+     * If not, floatx80_invalid_encoding() will return false for them,
+     * and using them as inputs to a float op will raise Invalid.
+     */
+    floatx80_unnormal_valid = 8,
 } FloatX80Behaviour;
 
 /*
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 07259c59303..c18ab2cb609 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -1073,41 +1073,45 @@ static inline bool floatx80_unordered_quiet(floatx80 a, floatx80 b,
 
 /*----------------------------------------------------------------------------
 | Return whether the given value is an invalid floatx80 encoding.
-| Invalid floatx80 encodings arise when the integer bit is not set, but
-| the exponent is not zero. The only times the integer bit is permitted to
-| be zero is in subnormal numbers and the value zero.
-| This includes what the Intel software developer's manual calls pseudo-NaNs,
-| pseudo-infinities and un-normal numbers. It does not include
-| pseudo-denormals, which must still be correctly handled as inputs even
-| if they are never generated as outputs.
+| Invalid floatx80 encodings may arise when the integer bit is not set
+| correctly; this is target-specific. In Intel terminology the
+| categories are:
+|  exp == 0, int = 0, mantissa == 0 : zeroes
+|  exp == 0, int = 0, mantissa != 0 : denormals
+|  exp == 0, int = 1 : pseudo-denormals
+|  0 < exp < 0x7fff, int = 0 : unnormals
+|  0 < exp < 0x7fff, int = 1 : normals
+|  exp == 0x7fff, int = 0, mantissa == 0 : pseudo-infinities
+|  exp == 0x7fff, int = 1, mantissa == 0 : infinities
+|  exp == 0x7fff, int = 0, mantissa != 0 : pseudo-NaNs
+|  exp == 0x7fff, int = 1, mantissa == 0 : NaNs
+|
+| The usual IEEE cases of zero, denormal, normal, inf and NaN are always valid.
+| x87 permits as input also pseudo-denormals.
+| m68k permits all those and also pseudo-infinities, pseudo-NaNs and unnormals.
+|
+| Since we don't have a target that handles floatx80 but prohibits
+| pseudo-denormals in input, we don't currently have a floatx80_behaviour
+| flag for that case, but instead always accept it. Conveniently this
+| means that all cases with either exponent 0 or the integer bit set are
+| valid for all targets.
 *----------------------------------------------------------------------------*/
-static inline bool floatx80_invalid_encoding(floatx80 a)
+static inline bool floatx80_invalid_encoding(floatx80 a, float_status *s)
 {
-#if defined(TARGET_M68K)
-    /*-------------------------------------------------------------------------
-    | With m68k, the explicit integer bit can be zero in the case of:
-    | - zeros                (exp == 0, mantissa == 0)
-    | - denormalized numbers (exp == 0, mantissa != 0)
-    | - unnormalized numbers (exp != 0, exp < 0x7FFF)
-    | - infinities           (exp == 0x7FFF, mantissa == 0)
-    | - not-a-numbers        (exp == 0x7FFF, mantissa != 0)
-    |
-    | For infinities and NaNs, the explicit integer bit can be either one or
-    | zero.
-    |
-    | The IEEE 754 standard does not define a zero integer bit. Such a number
-    | is an unnormalized number. Hardware does not directly support
-    | denormalized and unnormalized numbers, but implicitly supports them by
-    | trapping them as unimplemented data types, allowing efficient conversion
-    | in software.
-    |
-    | See "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL",
-    |     "1.6 FLOATING-POINT DATA TYPES"
-    *------------------------------------------------------------------------*/
-    return false;
-#else
-    return (a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0;
-#endif
+    if ((a.low >> 63) || (a.high & 0x7fff) == 0) {
+        /* Anything with the Integer bit set or the exponent 0 is valid */
+        return false;
+    }
+
+    if ((a.high & 0x7fff) == 0x7fff) {
+        if (a.low) {
+            return !(s->floatx80_behaviour & floatx80_pseudo_nan_valid);
+        } else {
+            return !(s->floatx80_behaviour & floatx80_pseudo_inf_valid);
+        }
+    } else {
+        return !(s->floatx80_behaviour & floatx80_unnormal_valid);
+    }
 }
 
 #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b12ad2b42a9..2a20ae871eb 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1810,7 +1810,7 @@ static bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f,
         g_assert_not_reached();
     }
 
-    if (unlikely(floatx80_invalid_encoding(f))) {
+    if (unlikely(floatx80_invalid_encoding(f, s))) {
         float_raise(float_flag_invalid, s);
         return false;
     }
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 3b79bc049d1..4858ae9a5fb 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1141,7 +1141,7 @@ void helper_f2xm1(CPUX86State *env)
     int32_t exp = extractFloatx80Exp(ST0);
     bool sign = extractFloatx80Sign(ST0);
 
-    if (floatx80_invalid_encoding(ST0)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST0 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
@@ -1383,8 +1383,8 @@ void helper_fpatan(CPUX86State *env)
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0) ||
-               floatx80_invalid_encoding(ST1)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+               floatx80_invalid_encoding(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
@@ -1819,7 +1819,7 @@ void helper_fxtract(CPUX86State *env)
                            &env->fp_status);
         fpush(env);
         ST0 = temp.d;
-    } else if (floatx80_invalid_encoding(ST0)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST0 = floatx80_default_nan(&env->fp_status);
         fpush(env);
@@ -1870,7 +1870,8 @@ static void helper_fprem_common(CPUX86State *env, bool mod)
     env->fpus &= ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
     if (floatx80_is_zero(ST0) || floatx80_is_zero(ST1) ||
         exp0 == 0x7fff || exp1 == 0x7fff ||
-        floatx80_invalid_encoding(ST0) || floatx80_invalid_encoding(ST1)) {
+        floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
         ST0 = floatx80_modrem(ST0, ST1, mod, &quotient, &env->fp_status);
     } else {
         if (exp0 == 0) {
@@ -2066,8 +2067,8 @@ void helper_fyl2xp1(CPUX86State *env)
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0) ||
-               floatx80_invalid_encoding(ST1)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+               floatx80_invalid_encoding(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
@@ -2164,8 +2165,8 @@ void helper_fyl2x(CPUX86State *env)
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0) ||
-               floatx80_invalid_encoding(ST1)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+               floatx80_invalid_encoding(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
@@ -2331,7 +2332,8 @@ void helper_frndint(CPUX86State *env)
 void helper_fscale(CPUX86State *env)
 {
     uint8_t old_flags = save_exception_flags(env);
-    if (floatx80_invalid_encoding(ST1) || floatx80_invalid_encoding(ST0)) {
+    if (floatx80_invalid_encoding(ST1, &env->fp_status) ||
+        floatx80_invalid_encoding(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST0 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST1)) {
@@ -2344,7 +2346,7 @@ void helper_fscale(CPUX86State *env)
             ST0 = floatx80_silence_nan(ST0, &env->fp_status);
         }
     } else if (floatx80_is_infinity(ST1, &env->fp_status) &&
-               !floatx80_invalid_encoding(ST0) &&
+               !floatx80_invalid_encoding(ST0, &env->fp_status) &&
                !floatx80_is_any_nan(ST0)) {
         if (floatx80_is_neg(ST1)) {
             if (floatx80_is_infinity(ST0, &env->fp_status)) {
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 56b23de21fe..505fa97a53f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -111,9 +111,35 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
      * m68k-specific floatx80 behaviour:
      *  * default Infinity values have a zero Integer bit
      *  * input Infinities may have the Integer bit either 0 or 1
+     *  * pseudo-denormals supported for input and output
+     *  * don't raise Invalid for pseudo-NaN/pseudo-Inf/Unnormal
+     *
+     * With m68k, the explicit integer bit can be zero in the case of:
+     * - zeros                (exp == 0, mantissa == 0)
+     * - denormalized numbers (exp == 0, mantissa != 0)
+     * - unnormalized numbers (exp != 0, exp < 0x7FFF)
+     * - infinities           (exp == 0x7FFF, mantissa == 0)
+     * - not-a-numbers        (exp == 0x7FFF, mantissa != 0)
+     *
+     * For infinities and NaNs, the explicit integer bit can be either one or
+     * zero.
+     *
+     * The IEEE 754 standard does not define a zero integer bit. Such a number
+     * is an unnormalized number. Hardware does not directly support
+     * denormalized and unnormalized numbers, but implicitly supports them by
+     * trapping them as unimplemented data types, allowing efficient conversion
+     * in software.
+     *
+     * See "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL",
+     *     "1.6 FLOATING-POINT DATA TYPES"
+     *
+     * Note though that QEMU's fp emulation does directly handle both
+     * denormal and unnormal values, and does not trap to guest software.
      */
     set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero |
-                           floatx80_pseudo_inf_valid,
+                           floatx80_pseudo_inf_valid |
+                           floatx80_pseudo_nan_valid |
+                           floatx80_unnormal_valid,
                            &env->fp_status);
 
     nan = floatx80_default_nan(&env->fp_status);
-- 
2.43.0


