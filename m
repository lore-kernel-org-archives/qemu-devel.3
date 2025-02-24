Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A60C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWR2-0005n5-By; Mon, 24 Feb 2025 06:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWQx-0005lH-W5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:36 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWQw-00017C-0v
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4398ec2abc2so37231415e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740395732; x=1741000532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAfkc5L9phFc4GuGJcjEeCq2ljrLeE9IXM1AAE+CUQ4=;
 b=nINMGQsqopHQwGq102mHWfJ/y7t3kgSv7wEn4jEREBSxlvuX2eNlop/7/VSdAEq5cA
 l0SK/77JrdV/x30wOQeYfbE6dVIWotcCCZBP1b/X5+yWguyaYsYcmVJqvKcxJkKs/nyP
 4SI/dznoHfwIY31tOaOXnm31W0Upv+F6y3LitfXuJapsHmaHOrN/klwigMcE78Eo/Ohe
 wofTE23KYDH+T4GLH2hU1pTYknzjXuKFUhnSzw8j/FONm68TFmCJinKQEQk84RWrVQ2/
 kKLA7lO2tIAOU5lYTRkT4Y2vZRwlkn+HxvDJ29s+rxmB0x33ITxdWjPWBnEbrALmVXzq
 0sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395732; x=1741000532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UAfkc5L9phFc4GuGJcjEeCq2ljrLeE9IXM1AAE+CUQ4=;
 b=Mo0zUKZCBHj6T9RpE9HRQ5QXzefdAS6pzYiD9XejLjwpaBjzHrA/raUQtfjHcuQwmy
 jIVOpy1Rw+PVGkEa9WUTsLKKlo+tGJ1+TBr8POaEJER5cQs1vdD6TompMC1pkPmAVjWE
 hTwlIfxtFOyI0UpH5yAVYfil4WJ4RVErAt1STKyuNoLZD6c4zJ4OboD51rvYm05YZAkn
 xHlW4sdfj3QgZxvvA3rK5K9qPwU5Y1jHh8tk0jwk6AC58YdaPgPsy5qdKCbOLrqcBUBG
 sqq4GvW875PU/WOX54dBneRyGyCOOR7+chINQ2bl2uT3l3rqODaL2DohVI0CpSRr92Kj
 W1XQ==
X-Gm-Message-State: AOJu0Yyz8BikTanbdMu44FEMVsGTbgwx+Gdxy4Bv8XS9H/+q5w89PolS
 NkWhUqxufevH+rweJIB6R8qU5IiTB3uZnnmPbIE49lj0MKdcaFkKUq/obdCGAVAchIEUQTkVGfk
 l
X-Gm-Gg: ASbGnct/PL+JLwAoeXGBGQgi1eI/gAXYQHxMeFXfvd93Q5isB8hXcrU90IBsa4/PJ3N
 KIDpMo/obvREPzIaCN+llC1SC8BLhE/vMcIkk+2bYKiRkcLnxyju4/W7jy6+BZGkwe1/G3Hno9K
 FkUg62zsUrdtW+BfsqXFhFHNIzfSIsaeTptL6hcZEwocpv9zS2ResWveajeVrL8ctRSgLsDSEAR
 QCRmC7TVzU8SfPubuO9GPCS7n+fZolMmqiCoHBnWXbxtNiDIxlkpNjbfYW85fmrRTiv+R1W1Bx4
 nzypYMgC/X3ZNge0+gr9+GSU4Kv6hIVv
X-Google-Smtp-Source: AGHT+IG04jQnVU67aSrrf9WAiusmPeaa8yIHqvAHB0cvQut7NYCEOl+FY8aasrW4pTNPV2qTfjBaIg==
X-Received: by 2002:a05:600c:4e8c:b0:439:6712:643d with SMTP id
 5b1f17b1804b1-439ae1e6c15mr90435965e9.9.1740395732095; 
 Mon, 24 Feb 2025 03:15:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b037214asm101447705e9.38.2025.02.24.03.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:15:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/12] fpu: Pass float_status to floatx80_is_infinity()
Date: Mon, 24 Feb 2025 11:15:16 +0000
Message-ID: <20250224111524.1101196-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224111524.1101196-1-peter.maydell@linaro.org>
References: <20250224111524.1101196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Unlike the other float formats, whether a floatx80 value is
considered to be an Infinity is target-dependent.  (On x86 if the
explicit integer bit is clear this is a "pseudo-infinity" and not a
valid infinity; m68k does not care about the value of the integer
bit.)

Currently we select this target-specific logic at compile time with
an ifdef.  We're going to want to do this at runtime, so change the
floatx80_is_infinity() function to take a float_status.

This commit doesn't change any logic; we'll do that in the
next commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/fpu/softfloat.h      |  2 +-
 target/i386/tcg/fpu_helper.c | 20 +++++++++++---------
 target/m68k/fpu_helper.c     |  2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index afae3906024..3c83d703baf 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -996,7 +996,7 @@ static inline floatx80 floatx80_chs(floatx80 a)
     return a;
 }
 
-static inline bool floatx80_is_infinity(floatx80 a)
+static inline bool floatx80_is_infinity(floatx80 a, float_status *status)
 {
 #if defined(TARGET_M68K)
     return (a.high & 0x7fff) == floatx80_infinity.high && !(a.low << 1);
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
-- 
2.43.0


