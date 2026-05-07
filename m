Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C06BCD37AA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72O-0000u4-IC; Thu, 07 May 2026 18:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72N-0000tm-Lw
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:43 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72K-0003Fe-Ir
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:43 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-435428c81a3so468273fac.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192258; x=1778797058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xPhav+rZ0D3mHeKIb/ZgfInrRVs0ZlagVufHC+pW9rQ=;
 b=kWZwj28SodhextP1iahfB57oEMOJM4DYreYMIR3wiJxzSENvlOnfPXyomrb3g3ukWf
 MUUpr4lTNG3SSwTrMpws8nt2s2n0l8B9I7/Gil/AwkhBmdkYl2d/DaGyzBNpCXy4/SLV
 G82YfbfqdhBQlLxmREA3T2oJr+bRv8Or5Va8heItGFwpppJg7K9LpZR3EoQBHHb4+2uE
 sLcjqvH3uSsWJC/OlQkSd4ksKdCPQND91orDkza75j94veAv6G+x3pUOnxGgkqDQnb8F
 ZXo9PWQXbpXSmADCr/w79wLLF+aBweHeYp1ErEeGVp85CbHoChDJV2LyC6m2S8KjVfPV
 yXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192258; x=1778797058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xPhav+rZ0D3mHeKIb/ZgfInrRVs0ZlagVufHC+pW9rQ=;
 b=B8Eb/0JWDUGx/5lCgk26xMcM5XNEINKOz7H/zGzEZUTdQhJzfSHpSXDNzfCnC7JLQ9
 N9BR421UjiKMexobbBUtjRvLWUtXLBCAIGu76eBHluRGORR5AEQjDBcF0tXfyeaeFmCV
 xZy8bLBtG0sYk18PKHlHO5AYVPDycgiVO4v3DvgJsTD2jouJo1TlAMUAlE9ch8bm0ez2
 yxEdaXQAD3+kVUGxJMrdPO8Zfuq0Esfj6y6nplN3hegOXBrVuWf0hdwPaReteRbH2tRj
 QOoV3CPb2R38Dj7UBEGij4QCQ8InW2Uz6nsecavEps9nZsAKEqAl4YqVlmRht35eUYYQ
 21Dw==
X-Gm-Message-State: AOJu0YzHu/jnjKsqwXOmbQtY4Ve/0jSlALy9s75gukSZvJjIWDzLPFOu
 gXsADq8LXKJU0n9/lr+w8o7V+eesbo8KgymirqSLR+j2q7goFrOOdXZRtZUZkLi+EH6X/p1zUjx
 EdRVg
X-Gm-Gg: Acq92OGkgA8SPaACMmlKezN7aOoUS0/XvbIYD0PCoUuBUMaDGpcwFU2p9jaTyogzrfr
 4UMLxPr/DymCuFbfzkjUGR7/QRv403qBtYhZGVZKOdP7EmGIZtpzKUUqFvJ6STL9edS6ngRl0Fa
 LS4BpgdnPw7nrKVYexJ3g+raJ5zuKpmhg9yzk75u+ngmKX4pvEB5/ktS4HYXhZQBvhDXqmS4++J
 QOcBDEIOO9IX7r5ECX/nfSnxcZYn4yxFn68BWaYdcgqzgpmjcH052M1N1K50Vch66aUeBKyiEYx
 hfXAnwi4jgEcS782woHgAZrHye8tC0F+kIJbZGhLhvHcfa6uEfKMonf13Aq6Te1ncCfLoJieYpi
 WVinUVph81FF9vdwIfvFu9kIa5dYLs6gUzrM+XtYNCEBYvHTIXTxBKLe2a3e7CXY7sTHhT9HDcH
 QVZBiVZ7pXjHThfiqZSTqtM7y4mNvd/pSUYNi0dt21V50vPo246Z7oMA9o
X-Received: by 2002:a05:6870:2315:b0:42f:dd2e:e41e with SMTP id
 586e51a60fabf-43556d0d6f1mr118670fac.17.1778192258336; 
 Thu, 07 May 2026 15:17:38 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/18] fpu: Use get_default_nan_mode everywhere
Date: Thu,  7 May 2026 17:17:14 -0500
Message-ID: <20260507221717.486023-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 12 ++++++------
 target/arm/tcg/vfp_helper.c | 24 ++++++++++++------------
 target/m68k/softfloat.c     |  2 +-
 fpu/softfloat-parts.c.inc   |  8 ++++----
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index dd1f9c6dc6..6505ee3c94 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -273,11 +273,11 @@ uint32_t HELPER(frecpx_f16)(uint32_t a, float_status *fpst)
         float16 nan = a;
         if (float16_is_signaling_nan(a, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            if (!fpst->default_nan_mode) {
+            if (!get_default_nan_mode(fpst)) {
                 nan = float16_silence_nan(a, fpst);
             }
         }
-        if (fpst->default_nan_mode) {
+        if (get_default_nan_mode(fpst)) {
             nan = float16_default_nan(fpst);
         }
         return nan;
@@ -305,11 +305,11 @@ float32 HELPER(frecpx_f32)(float32 a, float_status *fpst)
         float32 nan = a;
         if (float32_is_signaling_nan(a, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            if (!fpst->default_nan_mode) {
+            if (!get_default_nan_mode(fpst)) {
                 nan = float32_silence_nan(a, fpst);
             }
         }
-        if (fpst->default_nan_mode) {
+        if (get_default_nan_mode(fpst)) {
             nan = float32_default_nan(fpst);
         }
         return nan;
@@ -337,11 +337,11 @@ float64 HELPER(frecpx_f64)(float64 a, float_status *fpst)
         float64 nan = a;
         if (float64_is_signaling_nan(a, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            if (!fpst->default_nan_mode) {
+            if (!get_default_nan_mode(fpst)) {
                 nan = float64_silence_nan(a, fpst);
             }
         }
-        if (fpst->default_nan_mode) {
+        if (get_default_nan_mode(fpst)) {
             nan = float64_default_nan(fpst);
         }
         return nan;
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index 495ce8a329..8d3f6e3a2e 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -690,11 +690,11 @@ uint32_t HELPER(recpe_f16)(uint32_t input, float_status *fpst)
         float16 nan = f16;
         if (float16_is_signaling_nan(f16, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            if (!fpst->default_nan_mode) {
+            if (!get_default_nan_mode(fpst)) {
                 nan = float16_silence_nan(f16, fpst);
             }
         }
-        if (fpst->default_nan_mode) {
+        if (get_default_nan_mode(fpst)) {
             nan =  float16_default_nan(fpst);
         }
         return nan;
@@ -743,11 +743,11 @@ static float32 do_recpe_f32(float32 input, float_status *fpst, bool rpres)
         float32 nan = f32;
         if (float32_is_signaling_nan(f32, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            if (!fpst->default_nan_mode) {
+            if (!get_default_nan_mode(fpst)) {
                 nan = float32_silence_nan(f32, fpst);
             }
         }
-        if (fpst->default_nan_mode) {
+        if (get_default_nan_mode(fpst)) {
             nan =  float32_default_nan(fpst);
         }
         return nan;
@@ -802,11 +802,11 @@ float64 HELPER(recpe_f64)(float64 input, float_status *fpst)
         float64 nan = f64;
         if (float64_is_signaling_nan(f64, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            if (!fpst->default_nan_mode) {
+            if (!get_default_nan_mode(fpst)) {
                 nan = float64_silence_nan(f64, fpst);
             }
         }
-        if (fpst->default_nan_mode) {
+        if (get_default_nan_mode(fpst)) {
             nan =  float64_default_nan(fpst);
         }
         return nan;
@@ -945,11 +945,11 @@ uint32_t HELPER(rsqrte_f16)(uint32_t input, float_status *s)
         float16 nan = f16;
         if (float16_is_signaling_nan(f16, s)) {
             float_raise(float_flag_invalid, s);
-            if (!s->default_nan_mode) {
+            if (!get_default_nan_mode(s)) {
                 nan = float16_silence_nan(f16, s);
             }
         }
-        if (s->default_nan_mode) {
+        if (get_default_nan_mode(s)) {
             nan =  float16_default_nan(s);
         }
         return nan;
@@ -994,11 +994,11 @@ static float32 do_rsqrte_f32(float32 input, float_status *s, bool rpres)
         float32 nan = f32;
         if (float32_is_signaling_nan(f32, s)) {
             float_raise(float_flag_invalid, s);
-            if (!s->default_nan_mode) {
+            if (!get_default_nan_mode(s)) {
                 nan = float32_silence_nan(f32, s);
             }
         }
-        if (s->default_nan_mode) {
+        if (get_default_nan_mode(s)) {
             nan =  float32_default_nan(s);
         }
         return nan;
@@ -1056,11 +1056,11 @@ float64 HELPER(rsqrte_f64)(float64 input, float_status *s)
         float64 nan = f64;
         if (float64_is_signaling_nan(f64, s)) {
             float_raise(float_flag_invalid, s);
-            if (!s->default_nan_mode) {
+            if (!get_default_nan_mode(s)) {
                 nan = float64_silence_nan(f64, s);
             }
         }
-        if (s->default_nan_mode) {
+        if (get_default_nan_mode(s)) {
             nan =  float64_default_nan(s);
         }
         return nan;
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index f5d683bcc5..99c2dcbe8c 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -35,7 +35,7 @@ static floatx80 propagateFloatx80NaNOneArg(floatx80 a, float_status *status)
         a = floatx80_silence_nan(a, status);
     }
 
-    if (status->default_nan_mode) {
+    if (get_default_nan_mode(status)) {
         return floatx80_default_nan(status);
     }
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index c6a3ba9a22..5598c8b44a 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -20,14 +20,14 @@ FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
     switch (a->cls) {
     case float_class_snan:
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
-        if (s->default_nan_mode) {
+        if (get_default_nan_mode(s)) {
             return partsN(default_nan)(s);
         } else {
             return partsN(silence_nan)(a, s);
         }
         break;
     case float_class_qnan:
-        if (s->default_nan_mode) {
+        if (get_default_nan_mode(s)) {
             return partsN(default_nan)(s);
         }
         break;
@@ -49,7 +49,7 @@ FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
         have_snan = true;
     }
 
-    if (s->default_nan_mode) {
+    if (get_default_nan_mode(s)) {
         return partsN(default_nan)(s);
     }
 
@@ -134,7 +134,7 @@ static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
     }
 
-    if (s->default_nan_mode) {
+    if (get_default_nan_mode(s)) {
         /*
          * We guarantee not to require the target to tell us how to
          * pick a NaN if we're always returning the default NaN.
-- 
2.43.0


