Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D962C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWR1-0005le-Ci; Mon, 24 Feb 2025 06:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWQw-0005kU-OW
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:34 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWQu-00016T-IV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:34 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4397e5d5d99so25587055e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740395731; x=1741000531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQQOJkRUKcXKg+lYwbMPTfL+5pbfMb4jgTyc1o/Pekg=;
 b=wfb9VwSTLT1S6WJyRl96MWRVjrY1osZH5TaRd5o8XJPvn2v1LUpfKilGmtNhkU8DOU
 +2kxU4eHFx72r56P+WHsj7VshzD6PpeqpsdYE/G0SNaCctJWpAG8jEmTsgDpwC7mq8Y2
 IisKSQGEI2US+BMekd8opLKyvbgTJlgdh+Nl9L5wpMNJ4j1rpPkODuT0P6x9kgwGj2cv
 qxwfQRXOs91gYpFPJDl+HNirwHtmPet7QGJA9Awuu3X7c+9xIrKHGVXTJ8VRuIyjRu1+
 6rtOWd7XVCXa65MqLFoGSJwMr9ESqMzDPa1p+oNpqAJGUx/kvGlyBHuAQJA06UszfEl5
 ztTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395731; x=1741000531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQQOJkRUKcXKg+lYwbMPTfL+5pbfMb4jgTyc1o/Pekg=;
 b=I1xjZbWhEvAKNIrSLsegp4MnMB9x5lISMb1uTNcqdavezdz8z6e3iLyeUSlrt/ADmA
 xGt3NfQR9gVfDpnwC/fMChmeUnx5/9dHknTqeaHKj1oDFlXursjxty4Vk1woAFEoVnKX
 RzwybFwZccYgxSGVjmx+pFuE3NZCXZLZ8VMUeYRAt/4pxrJPzAFhszOmBrGQzVIrKrt4
 Id/CN0hoXnIAsg4zbf5g02FwrPD1B+za83xIjbM3ct5TGqRZ4l+WmHKS2DPo2zeetkYL
 o+FaQ4BoorAfktK0ayJvmGW1K56k1klwFeWJSJ9mA62xngUPCySLKoI8VuYwIVJe7Dly
 Rjug==
X-Gm-Message-State: AOJu0YwaudKT3pUmyWjVNcyEWUzb/PRPSXMWJfwLQ6nKakI8bkKLYh+k
 WWfWRr3I2B+LX2cjeeNQTB16uOdbouHwbEwPO5s2zZ16fTr+5h8lDAOQcLld0ISsJ8T1iSbjM0C
 0
X-Gm-Gg: ASbGncsTURkvRgylLrdKNfS2xqbJzJzuReAjyBS1OeAzsqfbIJWr8QnbJiMGETkwzVE
 MoDKZ4HgWzus5S/0n/byg7vpvC6JF0eKSM2SMIwYP9jm215AMcbXNcVZ3/QWqseMQ95k8Qi+JoY
 0ZVe/G+fzSx0bztUVA+uONt2iZScXxgLkDAyhrc51sDsVOgAjmZtnrFAhHj2DH/kuMTZjYa7SJr
 6aSMR0hmR0GxkBFS/KrFk0GHRyVagPIM6CNqMZDwStM9GCM9LQZbVQU6HT8r1tm2aP/kd5HVYfl
 Paqahzolo6wgBgAlH/ymJivGd4vV56An
X-Google-Smtp-Source: AGHT+IGpI9FhhRyXvGbb/DLnbHbcLRtd+7sIr/hM5hfPWVeY0JCBenbyh8nlhnjl20Hi4xIjG1dzGg==
X-Received: by 2002:a05:600c:4f02:b0:439:9828:c425 with SMTP id
 5b1f17b1804b1-439ae1e5b56mr101768765e9.7.1740395730219; 
 Mon, 24 Feb 2025 03:15:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b037214asm101447705e9.38.2025.02.24.03.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:15:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/12] target/m68k: Avoid using floatx80_infinity global
 const
Date: Mon, 24 Feb 2025 11:15:14 +0000
Message-ID: <20250224111524.1101196-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224111524.1101196-1-peter.maydell@linaro.org>
References: <20250224111524.1101196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The global const floatx80_infinity is (unlike all the other
float*_infinity values) target-specific, because whether the explicit
Integer bit is set or not varies between m68k and i386.  We want to
be able to compile softfloat once for multiple targets, so we can't
continue to use a single global whose value needs to be different
between targets.

Replace the direct uses of floatx80_infinity in target/m68k with
calls to the new floatx80_default_inf() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250217125055.160887-3-peter.maydell@linaro.org
---
 target/m68k/softfloat.c | 47 ++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 02dcc03d15d..d1f150e641f 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -142,8 +142,7 @@ floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status)
         if ((uint64_t) (aSig << 1)) {
             return propagateFloatx80NaN(a, b, status);
         }
-        return packFloatx80(aSign, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(aSign, status);
     }
     if (aExp == 0) {
         if (aSig == 0) {
@@ -245,7 +244,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
             float_raise(float_flag_invalid, status);
             return floatx80_default_nan(status);
         }
-        return packFloatx80(0, floatx80_infinity.high, floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
     }
 
     if (aExp == 0 && aSig == 0) {
@@ -255,8 +254,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
     if (aSign && aExp >= one_exp) {
         if (aExp == one_exp && aSig == one_sig) {
             float_raise(float_flag_divbyzero, status);
-            return packFloatx80(aSign, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(aSign, status);
         }
         float_raise(float_flag_invalid, status);
         return floatx80_default_nan(status);
@@ -442,8 +440,7 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
             propagateFloatx80NaNOneArg(a, status);
         }
         if (aSign == 0) {
-            return packFloatx80(0, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(0, status);
         }
     }
 
@@ -452,8 +449,7 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
     if (aExp == 0) {
         if (aSig == 0) { /* zero */
             float_raise(float_flag_divbyzero, status);
-            return packFloatx80(1, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(1, status);
         }
         if ((aSig & one_sig) == 0) { /* denormal */
             normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
@@ -610,15 +606,13 @@ floatx80 floatx80_log10(floatx80 a, float_status *status)
             propagateFloatx80NaNOneArg(a, status);
         }
         if (aSign == 0) {
-            return packFloatx80(0, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(0, status);
         }
     }
 
     if (aExp == 0 && aSig == 0) {
         float_raise(float_flag_divbyzero, status);
-        return packFloatx80(1, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(1, status);
     }
 
     if (aSign) {
@@ -668,16 +662,14 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
             propagateFloatx80NaNOneArg(a, status);
         }
         if (aSign == 0) {
-            return packFloatx80(0, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(0, status);
         }
     }
 
     if (aExp == 0) {
         if (aSig == 0) {
             float_raise(float_flag_divbyzero, status);
-            return packFloatx80(1, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(1, status);
         }
         normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
     }
@@ -740,8 +732,7 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
         if (aSign) {
             return packFloatx80(0, 0, 0);
         }
-        return packFloatx80(0, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
     }
 
     if (aExp == 0 && aSig == 0) {
@@ -924,8 +915,7 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
         if (aSign) {
             return packFloatx80(0, 0, 0);
         }
-        return packFloatx80(0, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
     }
 
     if (aExp == 0 && aSig == 0) {
@@ -1075,8 +1065,7 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
         if (aSign) {
             return packFloatx80(0, 0, 0);
         }
-        return packFloatx80(0, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
     }
 
     if (aExp == 0 && aSig == 0) {
@@ -2260,8 +2249,7 @@ floatx80 floatx80_atanh(floatx80 a, float_status *status)
     if (compact >= 0x3FFF8000) { /* |X| >= 1 */
         if (aExp == one_exp && aSig == one_sig) { /* |X| == 1 */
             float_raise(float_flag_divbyzero, status);
-            return packFloatx80(aSign, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(aSign, status);
         } else { /* |X| > 1 */
             float_raise(float_flag_invalid, status);
             return floatx80_default_nan(status);
@@ -2320,8 +2308,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
         if (aSign) {
             return packFloatx80(aSign, one_exp, one_sig);
         }
-        return packFloatx80(0, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
     }
 
     if (aExp == 0 && aSig == 0) {
@@ -2687,8 +2674,7 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
         if ((uint64_t) (aSig << 1)) {
             return propagateFloatx80NaNOneArg(a, status);
         }
-        return packFloatx80(aSign, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(aSign, status);
     }
 
     if (aExp == 0 && aSig == 0) {
@@ -2774,8 +2760,7 @@ floatx80 floatx80_cosh(floatx80 a, float_status *status)
         if ((uint64_t) (aSig << 1)) {
             return propagateFloatx80NaNOneArg(a, status);
         }
-        return packFloatx80(0, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
     }
 
     if (aExp == 0 && aSig == 0) {
-- 
2.43.0


