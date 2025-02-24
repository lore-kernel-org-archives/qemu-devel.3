Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645EAC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWR1-0005mC-E4; Mon, 24 Feb 2025 06:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWQz-0005lZ-Kx
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:38 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWQx-00017q-Pd
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:37 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4398e3dfc66so37346785e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740395734; x=1741000534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38r/ruH5r/FXqSo0EoeLtJC+So+c2+K0n3Kb1+Fekw8=;
 b=ndWEUvNZZnpVByRf2Yp46OzJSRhxY41qDdfgNW1IaZZjGASEEe5QysizClb7YPxDLU
 Q7QqqWrH6W/NPWWXO20QKVCiVi1SueC4Wg0oZ8b06/G3pdLuHkioPGxIjohsq32OjrIu
 4dWLk6wLhNB8CzkvEGMp/b9USe22yV2vrfwEWxfjVxJW2reO3N/y+o6Z36bnag6x0nX5
 BDfWJM9PEb6DdUcEPF8iGd/l38zseGQRowaOGW4NoHwV25/sotpUxfO/nHvDgPSRKeyp
 S8Ef2tMdpjkfu2wiTJSIw+A9Soa4/Lh0tbUYpRniyrLXupxWSfjpL5gzwfgSfqphF/e0
 24mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395734; x=1741000534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38r/ruH5r/FXqSo0EoeLtJC+So+c2+K0n3Kb1+Fekw8=;
 b=Q0HbypAyfKVEwdGp4My8J9CC247i33VGSUgj8dxgaR3oPI2YY/a3KFd/p7EviGbxAM
 l9JyKrGRBRm/gr9i4FC58eNWOG4FdYVl/kOsUSlog1YVsuvLDT/sfYxkIVM1UrTKoeOx
 oYUaUKk6M2Gy4iGzrn5eLxPD2h+6wEjMU1DIdUtJjsMs6DPLMonlAbGv4YILOIiDlqNv
 d6kXDC+qdApOdTlVm946cH+hKeD9w0PJmiX+OJ6pleNASPDAsxwDkDSt/oyvisQmzt5n
 wUN1yrnM6U87FW4F6baHdK6H5VQMN1bIAaUCakG2RTW4bJeOkbxO41Q2kMPBkg/fDAdr
 E7xA==
X-Gm-Message-State: AOJu0YyuX2zaUJo0kEA0bCK4TibInKQ6M9BO6e7Yx9wPAw0hcUlBLDep
 YVMXoTiBALfAA6HasmYe71nVIe7WJbUHCSkY3Fw3POl0TvTIlVCqwEF2lbaRkE+FtkWIp1JDRUx
 A
X-Gm-Gg: ASbGncv21LURdenpJvv9Q2+eifZW1A/hOtirOorYxjpcA3TRoNC5nVoJdfc0Dn0MJtu
 NMZddA7851to1xgQEbjsVvRS7ib0qNX9IpVquea5BP6b1youGG0CfWW6opR7hJpRpoQD8yrzW5K
 sEzd/tXLX9hP3bCzsri1TFZdIfLoy8fUQnRrHperXSwt/MsJ/3CxdjLbpW4oeYSyo7WhWk4BxVt
 EQ70dQiOUYNgX1TXL53F7hHMFm/W/Sn3EK2PAPGDyfIrRXp9lWyM0VC+4IehHJYNRAepdPutYLV
 v5h+ft+NUea/aypgcb3A5lo6XTdK+z+p
X-Google-Smtp-Source: AGHT+IHWo/gU9Cj/o0eSoZsSuN2l1N9VJL8TqcL5/EqJ+BufcOl7Qt16DH1o4Fcrtfk+YeKN2rQC7g==
X-Received: by 2002:a05:600c:1390:b0:439:8bc3:a697 with SMTP id
 5b1f17b1804b1-439ae1d7e97mr107091045e9.4.1740395733983; 
 Mon, 24 Feb 2025 03:15:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b037214asm101447705e9.38.2025.02.24.03.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:15:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/12] fpu: Pass float_status to floatx80_invalid_encoding()
Date: Mon, 24 Feb 2025 11:15:18 +0000
Message-ID: <20250224111524.1101196-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224111524.1101196-1-peter.maydell@linaro.org>
References: <20250224111524.1101196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The definition of which floatx80 encodings are invalid is
target-specific.  Currently we handle this with an ifdef, but we
would like to defer this decision to runtime.  In preparation, pass a
float_status argument to floatx80_invalid_encoding().

We will change the implementation from ifdef to looking at
the status argument in the following commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/fpu/softfloat.h      |  2 +-
 fpu/softfloat.c              |  2 +-
 target/i386/tcg/fpu_helper.c | 24 +++++++++++++-----------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 07259c59303..1c8f3cbb78d 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -1081,7 +1081,7 @@ static inline bool floatx80_unordered_quiet(floatx80 a, floatx80 b,
 | pseudo-denormals, which must still be correctly handled as inputs even
 | if they are never generated as outputs.
 *----------------------------------------------------------------------------*/
-static inline bool floatx80_invalid_encoding(floatx80 a)
+static inline bool floatx80_invalid_encoding(floatx80 a, float_status *s)
 {
 #if defined(TARGET_M68K)
     /*-------------------------------------------------------------------------
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
-- 
2.43.0


