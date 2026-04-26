Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18615FF8864
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpY-00089L-JY; Sun, 26 Apr 2026 09:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoH-0005wS-1T
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoD-0001YN-GB
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:08 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso58486395ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211163; x=1777815963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbVuK9RdGSnecOOwaf1HA58zPz8tW1paOnqbUnPnZMw=;
 b=YYsWuKbhF0Gr005oAvQOFRhDBir1kzv8UY3Fyq6XLTta/NuJ5r51YFnt/BhvdJ8r4S
 zalwSB+juQj9IwE0GF2Xi2Dq1Phgygn4GeI724IpVgF5apm5PnfLrjl3M3TOSvE4APpB
 iw/ZUEBD5/WVn28RjFRau+9kja1F6/JMM2XfrYGOkfIGc65t7w6fo4ZIw+mpqgYTbygV
 tM5uZoC2fshNw5kK2Qmg2aFD29GGSaglB5uS/fcbabvxp75Em1Sc+eGKxsJrVwpxCTvL
 OuXIbOLJLzttldEflYT0sP9UcDWSZ5AQPlkQhL4afNHWvuGfTBUTyRGJJS2AhQ11mJKZ
 1rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211163; x=1777815963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jbVuK9RdGSnecOOwaf1HA58zPz8tW1paOnqbUnPnZMw=;
 b=E//Fshd88R/4EuY/ukmPAugwAW70R1IiENnQKKwXnSBvVAl+HH9Z7XAUjiLKXjVW+z
 PP4LzpYUNsZ+4kIAfmfVm/6fqtbQu6U2AUBC4SR/4ykyOo7CFbdIBASvjvT6b7aNJU2j
 VIvfS121qRcluexTpWerlOW4XIa5kzecnFencmv/0at54c4I++izGU3pif2+w6WtCZvu
 JzozTtre/wafzXRc4JcOavVPo/IL1or2HjwDO/Mg3Hv836U+lxbWgVWVEpF7DkFvKdEl
 2FRe6uZS4haU20AQESQw7cv6Tv5r5lWdOK3EfEoYcgOrAY/prjgZXg6k5eZKDOfP8/YK
 OJWA==
X-Gm-Message-State: AOJu0YyaCYW4TecsbkqnzbcCfJSEMFGqWqaPW8gZOSjc6fPh4mXvw1fz
 JR1FcLuW5nbR8quzGj47YyF//GVspdAUbMGlwdouWEdJ722SVLa20Av9ELoTyxc+R7L/7+Xvfhe
 QxD0DhNg=
X-Gm-Gg: AeBDieskGv0PbXYeuy9Kksb1trhAlvO2JxhY/AYGxFg6eCmu59mH0wbjaNiXgky8ozY
 noZMNCi/tyqxt0I/zid1u3rRL5Oy1kQYAm8x275PhEgi69Q9Xf3vmAWyhKezT6TQQkwvkLOserV
 Cn1YcLz7ZzvXPlhD6TsjhVut2gLzNEOlQHS3PabVvpoObz6rIZnuUvVje0AY2/t4piwuJUroo/U
 6B0/HdglvZ8oLYOFaHlIVGFHgJaV1607luo7um0P54voSlLkpaS+4oL476trnUWDdvelecRoq0r
 qacJRuD1TTjRxBRNmZCoZoMuOSnz4xGHBdn2HMhaymrpRxHHgtwWrxTLOF1AFIOs83YzF7igeTB
 MNdn5EImHJtwC/bpsHy6J26oiLWXpJ/NIB9T+7sTNKWUL5HCTsTHGBxorwKZ8qJN6IzFFG+q2Bn
 W1vetKSi3eXNRrrQVcXRrP6kfUVJS+2QWktme6Cg7u
X-Received: by 2002:a17:903:240e:b0:2b9:41ac:d07 with SMTP id
 d9443c01a7336-2b941ac0eccmr66858975ad.14.1777211163031; 
 Sun, 26 Apr 2026 06:46:03 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:46:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 64/84] fpu: Return struct from parts{64,128}_pick_nan
Date: Sun, 26 Apr 2026 23:39:41 +1000
Message-ID: <20260426134002.865628-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           |  8 ++++----
 fpu/softfloat-parts.c.inc | 28 ++++++++++++++++------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b7d461bca4..246209072e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4765,15 +4765,15 @@ void normalizeFloatx80Subnormal(uint64_t aSig, int32_t *zExpPtr,
 
 floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
+    FloatParts128 pa, pb;
 
     if (!floatx80_unpack_canonical(&pa, a, status) ||
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
 
-    pr = parts128_pick_nan(&pa, &pb, status);
-    return floatx80_round_pack_canonical(pr, status);
+    pa = parts128_pick_nan(&pa, &pb, status);
+    return floatx80_round_pack_canonical(&pa, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -5120,7 +5120,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
 {
     /* POp table "Results: DIVIDE TO INTEGER (Part 1 of 2)" */
     if ((float_cmask(a->cls) | float_cmask(b->cls)) & float_cmask_anynan) {
-        *r = *parts64_pick_nan(a, b, status);
+        *r = parts64_pick_nan(a, b, status);
         *n = *r;
         *cc = 1;
     } else if (a->cls == float_class_inf || b->cls == float_class_zero) {
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index ef46dd740c..40ea7e3a39 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -37,11 +37,11 @@ static FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
     return *a;
 }
 
-static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
-                                     float_status *s)
+static FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
+                                    float_status *s)
 {
     bool have_snan = false;
-    FloatPartsN *ret;
+    const FloatPartsN *ret;
     int cmp;
 
     if (is_snan(a->cls) || is_snan(b->cls)) {
@@ -50,8 +50,7 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (s->default_nan_mode) {
-        *a = partsN(default_nan)(s);
-        return a;
+        return partsN(default_nan)(s);
     }
 
     switch (s->float_2nan_prop_rule) {
@@ -110,9 +109,9 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        *ret = partsN(silence_nan)(ret, s);
+        return partsN(silence_nan)(ret, s);
     }
-    return ret;
+    return *ret;
 }
 
 static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
@@ -605,7 +604,8 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     return b;
 
  p_nan:
-    return partsN(pick_nan)(a, b, s);
+    *a = partsN(pick_nan)(a, b, s);
+    return a;
 }
 
 /*
@@ -647,7 +647,8 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+	return a;
     }
 
     /* Multiply by 0 or Inf */
@@ -833,7 +834,8 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+	return a;
     }
 
     if ((ab_mask & float_cmask_denormal) && b->cls != float_class_zero) {
@@ -891,7 +893,8 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+        return a;
     }
 
     /* Inf % N; N % 0 */
@@ -1514,7 +1517,8 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
             return is_nan(a->cls) ? b : a;
         }
 
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+        return a;
     }
 
     if (ab_mask & float_cmask_denormal) {
-- 
2.43.0


