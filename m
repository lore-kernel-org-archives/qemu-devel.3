Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A94CFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLH-00006N-7m; Wed, 29 Apr 2026 18:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLC-0008W9-Jr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:10 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLA-0004ec-18
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:10 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso152447a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501506; x=1778106306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OuF50DyS/2sUvgsZRavLu0Xyfa3XUA6eWQvmnwMMmBM=;
 b=JMqGh4ybfs/gdruAel6Slw+B5GpuBjz0+8r5kJ6orkExpi0Tq8oOGp2U9C65lAJyO/
 ITAaj9ju1N+NZMAeHBVr5Z3cIjmzt+1K2ub5siUlDMbP+gEOK8D2OYGFxkDGqDfhuwG+
 HDuP5IV7NTwcBb8nrtH3KR7tJo3MONM99CPGlTi9Hl6bhoS6ifBn3LdWRhZou/gM8Mom
 rdgwQL9zMLRd/RfIINyvahnMZYxe1YAGcQHU2THEPakmPwWOap1gYkmGuPainr8+zxoX
 WgJzVMCl7IqnMIiOyxZiBHmH84WN4KcY4ry7y1ZaBvEEEa1CFGC70dLpkSgB59EnqnNz
 a1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501506; x=1778106306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OuF50DyS/2sUvgsZRavLu0Xyfa3XUA6eWQvmnwMMmBM=;
 b=TjrNofQqUn/y0ktcJlGbk7m8KhX8kvqn/FS/vC+GXlnoDjRnNxUQoaezt8asIK3k7O
 0Y2xvfJtSlepYhhcQc1RnsnPVp1WgdWSSh77H8pg8zx6agOISIV3ywR3Q9ZpdV9g9eqU
 b/KtlJqIXzszbLZWpQEcLuNlayqm76AASKJM/YRmaPdd7nySsPBe7g3DIC9oIqkRAFSK
 732yPn0WEWJu9RV6SlxowzwADDiL2v8vkDUbs26El2w4p7S+vk4ZHkXLMpPZAkLFFXmE
 SNO8QT02eUKi/0YuMzPKiVP++ulJe6Y/plfCpKKaGejZIp9NO3lmyzuOiGz3+eL7F0Im
 /gqw==
X-Gm-Message-State: AOJu0YyMY9ZYwGX48V8uEh2x9GPv966yoON2BDCtl6voWgTriI9L0V8b
 v7bQqkuoYWblTtai+zFL3toJ10y749cNKJdRv1Aow7vHB3kOkkNqhj8R/wzGMWtwYIIc+EytY8C
 Kvi08gCQ=
X-Gm-Gg: AeBDieuj00XQRHpkFscTuoWc3w0DtnGj0KydaYCBufDM75yY9a85mwb0lK1fJX2t6Bj
 HJjGCTtKm7SenqyG50idLAUbTf52wXlOtevDtTS8nIS+E2FrVrv0IR8tzuMMUIp1YJiy4GnXCCu
 qmWQmBrhHskpmUL2siaY5qWIO/h6nKNGioavnD+Vrmvx3EHYQ4o5uYCvtIUYI6DEkQYdmnJvGiy
 fGzNkNMuOLvPlrU/J1XFKdlYUaRcaShh6ewRTZE/I63mT1WQGxFV0GUnweOqJ+3mbejEZbvfrjp
 /OJ/PB0bKjIGpQJEZd3Axvrv7oNfhwjvmHY4NX6nSlu5o4DPudwguyXC0FYGnJH2bFaoXkISSMq
 Yzq3F6N4fnb/UJ2cYIoHJmIB6DyFwcutxq/jousSqP+qbAwhusyu2Ix9MDg4oVbqn+D5jPOnn3i
 p7U1SFVx0xY+R31aYkw5RZF+Bzp0aOeWHe6j+g0+Rl
X-Received: by 2002:a17:90b:3505:b0:35b:e690:c5ad with SMTP id
 98e67ed59e1d1-364c310b735mr154365a91.25.1777501506505; 
 Wed, 29 Apr 2026 15:25:06 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/48] fpu: Drop parts_return_nan
Date: Thu, 30 Apr 2026 08:24:03 +1000
Message-ID: <20260429222445.26301-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
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

Use parts{64,128}_return_nan at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 17 ++++++-----------
 fpu/softfloat-parts.c.inc |  8 ++++----
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 571b5f09f3..50a625fd0a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,11 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static void parts64_return_nan(FloatParts64 *a, float_status *s);
-static void parts128_return_nan(FloatParts128 *a, float_status *s);
-
-#define parts_return_nan(P, S)     PARTS_GENERIC_64_128(return_nan, P)(P, S)
-
 static FloatParts64 *parts64_pick_nan(FloatParts64 *a, FloatParts64 *b,
                                       float_status *s);
 static FloatParts128 *parts128_pick_nan(FloatParts128 *a, FloatParts128 *b,
@@ -2831,7 +2826,7 @@ static void parts_float_to_e5m2(FloatParts64 *a, float_status *s, bool saturate)
     switch (a->cls) {
     case float_class_snan:
     case float_class_qnan:
-        parts_return_nan(a, s);
+        parts64_return_nan(a, s);
         break;
 
     case float_class_inf:
@@ -2858,7 +2853,7 @@ static void parts_float_to_e5m2(FloatParts64 *a, float_status *s, bool saturate)
 static void parts64_float_to_float(FloatParts64 *a, float_status *s)
 {
     if (is_nan(a->cls)) {
-        parts_return_nan(a, s);
+        parts64_return_nan(a, s);
     }
     if (a->cls == float_class_denormal) {
         float_raise(float_flag_input_denormal_used, s);
@@ -2868,7 +2863,7 @@ static void parts64_float_to_float(FloatParts64 *a, float_status *s)
 static void parts128_float_to_float(FloatParts128 *a, float_status *s)
 {
     if (is_nan(a->cls)) {
-        parts_return_nan(a, s);
+        parts128_return_nan(a, s);
     }
     if (a->cls == float_class_denormal) {
         float_raise(float_flag_input_denormal_used, s);
@@ -2896,7 +2891,7 @@ static void parts_float_to_float_narrow(FloatParts64 *a, FloatParts128 *b,
     case float_class_qnan:
         /* Discard the low bits of the NaN. */
         a->frac = b->frac_hi;
-        parts_return_nan(a, s);
+        parts64_return_nan(a, s);
         break;
     default:
         break;
@@ -2912,7 +2907,7 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     frac_widen(a, b);
 
     if (is_nan(a->cls)) {
-        parts_return_nan(a, s);
+        parts128_return_nan(a, s);
     }
     if (a->cls == float_class_denormal) {
         float_raise(float_flag_input_denormal_used, s);
@@ -5474,7 +5469,7 @@ float32 float32_exp2(float32 a, float_status *status)
             break;
         case float_class_snan:
         case float_class_qnan:
-            parts_return_nan(&xp, status);
+            parts64_return_nan(&xp, status);
             return float32_round_pack_canonical(&xp, status);
         case float_class_inf:
             return xp.sign ? float32_zero : a;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 0d4a63fbff..3bde254bfe 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -941,7 +941,7 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
             break;
         case float_class_snan:
         case float_class_qnan:
-            parts_return_nan(a, status);
+            partsN(return_nan)(a, status);
             return;
         case float_class_zero:
             return;
@@ -1263,7 +1263,7 @@ static void partsN(round_to_int)(FloatPartsN *a, FloatRoundMode rmode,
     switch (a->cls) {
     case float_class_qnan:
     case float_class_snan:
-        parts_return_nan(a, s);
+        partsN(return_nan)(a, s);
         break;
     case float_class_zero:
     case float_class_inf:
@@ -1735,7 +1735,7 @@ static void partsN(scalbn)(FloatPartsN *a, int n, float_status *s)
     switch (a->cls) {
     case float_class_snan:
     case float_class_qnan:
-        parts_return_nan(a, s);
+        partsN(return_nan)(a, s);
         break;
     case float_class_zero:
     case float_class_inf:
@@ -1770,7 +1770,7 @@ static void partsN(log2)(FloatPartsN *a, float_status *s, const FloatFmt *fmt)
             break;
         case float_class_snan:
         case float_class_qnan:
-            parts_return_nan(a, s);
+            partsN(return_nan)(a, s);
             return;
         case float_class_zero:
             float_raise(float_flag_divbyzero, s);
-- 
2.43.0


