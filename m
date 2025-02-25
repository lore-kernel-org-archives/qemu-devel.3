Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5313AC021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzL3-0002QY-KH; Tue, 25 Feb 2025 13:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJE-0008Mu-ED
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ9-0002DT-FR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:30 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4399deda4bfso41030165e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506724; x=1741111524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sF2iTBSB9udDdHFGKwWu1r3tpgd/tit84mrcKjGT1yo=;
 b=Q5arw1QayYFb07WeXkME2mgz3VVh6/eeq4BIbDFimANtlnwjtaboVTzEqaITTyd/lm
 F1BuGb680GYImiykK5VxMKN46t9FkFBgLSFRtQX1oNw/qHwQBHkbFzWFaSEPQPf1dYQJ
 Yny0sofdWZy3lQ8ynOda5rStuSB1gbFd5sbyA3PEe2aI4ctmaAXGpX4KU4uCqN9PGEXg
 vpPpNI+4akGZTdtPP8+Ps5lAsJjxNmlHbT2ltIqSHhjMUiUK49+Dea4Y0bMd+LRoGryz
 TaXLOmgMlakqZjC9jyzoglihpL0ZeQ4hDuo1/Ohw2D1q62t9NFGhhCkGIrvaSIAWoJ0j
 lMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506724; x=1741111524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sF2iTBSB9udDdHFGKwWu1r3tpgd/tit84mrcKjGT1yo=;
 b=KUVUvPlLomceJLf90h8jkCRrxILE6dOp3xY/tv7I7PiVp6MNlMJeD7EWplj7hRA0OX
 lwK4gNLbEJJTnu8jDSl9YjHgF1eocmO4Oz3QvETyxcCeSww3JV3a30KOgDY6yslE+P9b
 S+8rrylFFMbfdqs9XZVvBkbjnx4+tm2+htizfqSE2i5et4FitYsjfL5wIeF5fPkmnFRN
 N/U9KG4V/34uSeOXcx1mi2pzxFn0DVGrD5kBB49zXEQPqEI8QOrs4Wft/8lQq9hnHrxi
 STaaRPr7yMxoG+oeD+64eh6UMKXOFBCp2ZTp/gteZ8B5z0+iJUPyBoLwhrH1X0KPY4OF
 zeMg==
X-Gm-Message-State: AOJu0Yy4862ApdwnxvP8wt0B+sIBVh0jCr3adLOpK1P5GHeqlMXt1iQT
 GJpZ+m1Ki2DasqcpQjbKErzxypNGlsCGhUsm7Z8OtHpaYdPIYABZ5JUSIUNgb9v9EYwiEKsYCvI
 J
X-Gm-Gg: ASbGncu05mSZge59nUzDKr4kaRCKXLm5rJG6hAW/zH7rr6jrPy75QWgJRMl6tsNTgK+
 ZmVBe9rXixCyBQE8aGls1Z31ZOxnV6XPSuQJsu3JpycIUD5ueytzZPevrVepJ7rm9Ox1qojOAJo
 D81Ca91rZvjTpHntKSVQfLs1PkMoOL42U6HSAJ6QXtMS+jykaQSCtw2kOGQiVMw5yW5y66iYu+i
 c+NIApTkNhZ42DiOOH7feBVPoDdYeyNpS3YND4FIPVSdCJYPVXZb4936YwPRRkMZDw9Kh+gosIW
 hxloJkAqLIEDpFIQbURHkjVCna7h5GFD
X-Google-Smtp-Source: AGHT+IFzEygZ4UUVoljzEFTjTxSn7GITlI+vFiPuduDuES8vtjLkCg9VLNwWqMY+XN7+slNH0HdSRw==
X-Received: by 2002:a05:600c:1e23:b0:439:987c:2309 with SMTP id
 5b1f17b1804b1-439ae221d7dmr149077815e9.27.1740506724508; 
 Tue, 25 Feb 2025 10:05:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/43] target/m68k: Avoid using floatx80_infinity global const
Date: Tue, 25 Feb 2025 18:04:36 +0000
Message-ID: <20250225180510.1318207-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-id: 20250224111524.1101196-3-peter.maydell@linaro.org
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


