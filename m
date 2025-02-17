Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0406AC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0b6-0001i0-7S; Mon, 17 Feb 2025 07:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0ac-0001cT-Fk
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:16 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0aV-0002F7-3E
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:07 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43964e79314so38596315e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739796660; x=1740401460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AU+2tCNu3akZDepHPqncf6ZMUhVIfAv/JNg+9Si1I98=;
 b=e9yVSPDc7gQa3R3CFrEAgnowub4h1Ibmid2Y2iUIxCALzwi48VeTmHBHFZL08g7k1F
 uRk9o/+uDLzjOGND3ijvVWV2cHuGjvx+TqxSB1edwipQlbdMFavieuN+UG8pAx2jpnrP
 2BIWW4Q//ub+u8TFCm/IqhZmFWpeIOHA10bDbOzh9/1J3fyOcuwd6A+hn/9zX//tsQ8L
 XOho7hJEZcVocn7CKQsRrhADfVon1EsWwqM/8JSJDq5+pcdQ5wAdGysgquBMTQASnr8X
 H32jbLTENGtxI5zwWZxEK2a0M3HfxeDEnm+3OaB7kxAemESBH1hvs8iZXfaV+gWb+h9s
 vMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796661; x=1740401461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AU+2tCNu3akZDepHPqncf6ZMUhVIfAv/JNg+9Si1I98=;
 b=QBQQcZF607uspinYInMrrFxTtxQp82ydeUiT/gEsF2daBbcCMXDIXqWrUs68ktjass
 m9UFRygri/Ug3euZee4aY2Mic2G0A5cBfQwcZdOAMUVGWEvEfzVe/IzxxSwYRkWj46ID
 SA0AQd7Bqi9Ew8D5M/csZ0eSqbPCOMZ45S780mcnaZ1BngBOcTTMySI8qWR3l6A4Qszw
 F4iubiRtaeLdIZ/6osoOtIgI5XPXmWBN6l9GcIU+NEj9Bnyi9x8tMYsfa7emSuKtkNvr
 UNSo0vVgxiATm0V0TxlLjY6bk5NDbyULwmA+ewyNrbQmPUEu+aK/yxFY6i5sz+KOv0Vu
 P6ig==
X-Gm-Message-State: AOJu0Yx8D0Ng5Vk0nDRFq+vTq/Qa7IHWNTAmYtDFhT1StblLow6qFLKj
 E6IG6TZDuJl/UGRM5rWg0VJOmbBbqboLPLJViPeyu6lx4yXODamp/E2wm2yLsr9oUCO2ela1ElU
 u
X-Gm-Gg: ASbGncsTG/cm6PRAXDXxumzIdin7biEHXgGOR4tEX+HdprU+miAE0sDWceJEkTXCEoy
 6vXetPG5XCD8rsdZYQrIJd/PXgGeu2JfLxNbI5x4zIR6VEUjxcuLa61p7FUoh5ir+Mk1EL7+l7X
 6VXtlXJzQVqj9X4c/er63Q70GBN6FbB1nn7NP6885Xn8ARxWBJSeVg47thJI+NbrUD054Mehq2y
 CuQP4osANmrC33mK5C2JBEOwMkgEVjJ3/wE/adVE/iaXC0OuBoWz75MuKRpa9XeiRUqHOGkC0QK
 NUbGoE4EkoqbiHSln+/Rcg==
X-Google-Smtp-Source: AGHT+IE0g7+qkgKP1R7BgCFxtX6P7OWtU1zWjoRt1hP5KSEr/DAHqgVVJarMKcTlDxYqr/fctsNLaw==
X-Received: by 2002:a05:600c:444c:b0:439:6925:4d28 with SMTP id
 5b1f17b1804b1-4396e6d8176mr91363115e9.4.1739796660028; 
 Mon, 17 Feb 2025 04:51:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm3562455e9.10.2025.02.17.04.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:50:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 02/10] target/m68k: Avoid using floatx80_infinity global const
Date: Mon, 17 Feb 2025 12:50:47 +0000
Message-ID: <20250217125055.160887-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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


