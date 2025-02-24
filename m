Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D84C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWRO-0005qb-PL; Mon, 24 Feb 2025 06:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWR1-0005ly-06
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:39 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWQy-00018B-Nn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:38 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso3252346f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740395735; x=1741000535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ajZ80sJdOGH3k+29+o4N7kSCTpNRDBlyRWkxI9EVY8=;
 b=wEgDikF73w5EJcaQLy9bLuUiiGqBFm1TqaIL7n4Y5VpjLHtye3Irwh3IOpkC3c7IFU
 gbLpUjB6aC1o4JzNzYQPuJGsalXLuAnbiS/jSzPqDJ51RS6LN0Jcs+Ioydc8AOC2NjqR
 ByXi04dBVU083IU98xn2IO0Jq6Lesxp+Bx72Tbg7b4g3ZziZhBQtQ79iWGBF9LwKI5VI
 RYMp9X6ziIrW4DvEf0PDTl1t7ZF0aIN3Wq3+Rn3jREyYuJIDPWe0+c60XD/T0UV/UGWY
 jPnHw2ngoZsACG7b0KFy/dPCaIzXSHmsu+ESkNNDNKglQaQUF3v7w/zRQS7N9DcEhnrD
 zgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395735; x=1741000535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ajZ80sJdOGH3k+29+o4N7kSCTpNRDBlyRWkxI9EVY8=;
 b=Kw5zB5DslTBzkTKRJaaCGbzkFDIkLyUs5Q7IrK5siNdsQDucRebwRzKnSXgkSRJpop
 iZtCGG9+n+GVXPkBc7icXWAsLO/EDaFM/4hkXI9aiMzJOc8Wvp/0uMgezaSTHz2HDAnM
 30BToOufG3VQqObXwiwm8X19dPSufAJiajuI51dYKJeZBEquuoLjKHDx3W38Fs418bb4
 2TvqLBLNhzTuiGq2n8b7DfL7ZAFihtErpUEI3y3SpvwP4mXZS4IqqxHncIc8DAsmlRGk
 0FIJyEN8gqHgXM/SHqNgvlx+M+7cVdofWZU7cxGHxginUeeTPtvWYjMGtN4iMiLjvcHn
 kDGA==
X-Gm-Message-State: AOJu0YwS9lrupj4XiYvhi5LCSfKW7Nn4cLXep+3e8FPXmW+K3Uu+UeIW
 tnX/5Nk6rPb+2l6U5MCD2dphprBmAeJXYa/WYbEF3fqslNrW9sUuFWI5sfJQh8meBYz1OhPT3bq
 9
X-Gm-Gg: ASbGnctZekquSGXFvdIGqsItAJ0Hic6TEuUxpnkaCDSEb/DVjVLTB8vr4otf0X7ItOY
 OqHVoOHGDvAyJ7FMv3rQ4XIA+3rYjqBU4xVXSWgLIpVct1LvS7OPKp6lrN8Bh7HoQ7nFvfnULw2
 f1W178NnukvG5xc0x8u6CQH2p1/i2WzNK9bEX6W94/PUz69/MqNUiiVW7jIflqoV8Za8ktG5l/v
 ih4fCIQmxfaJwjaeTa0NOcGW2A6yXzhAj8EcT+eIGYryY4L4fBFqBpL6jrFoRw0LLPyFa9RHCqX
 aTTGQ7/tzndOA7I6HBmUnN8232fK/+9J
X-Google-Smtp-Source: AGHT+IFGMc01xXSWKVFevOmmgMnodERzFMICfmYep/ekALoZhOueFgQywCVVrGnQMpB7TiPwTl+Xbg==
X-Received: by 2002:a05:6000:4712:b0:38f:32d5:3a92 with SMTP id
 ffacd0b85a97d-38f614b827bmr14284352f8f.12.1740395735039; 
 Mon, 24 Feb 2025 03:15:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b037214asm101447705e9.38.2025.02.24.03.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:15:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/12] fpu: Make floatx80 invalid encoding settable at
 runtime
Date: Mon, 24 Feb 2025 11:15:19 +0000
Message-ID: <20250224111524.1101196-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224111524.1101196-1-peter.maydell@linaro.org>
References: <20250224111524.1101196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250217125055.160887-6-peter.maydell@linaro.org
---
 include/fpu/softfloat-types.h | 14 ++++++++
 include/fpu/softfloat.h       | 68 ++++++++++++++++++-----------------
 target/m68k/cpu.c             | 28 ++++++++++++++-
 3 files changed, 77 insertions(+), 33 deletions(-)

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
index 1c8f3cbb78d..c18ab2cb609 100644
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
 static inline bool floatx80_invalid_encoding(floatx80 a, float_status *s)
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


