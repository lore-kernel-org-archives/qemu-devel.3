Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E132CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUbE-0005OX-Cn; Fri, 22 May 2026 14:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbA-0005Cy-I7
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb8-0005UX-Io
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b4650d5f5cso31744935ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474469; x=1780079269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUC9cAbO+O9/DBX4sEI5SDbdyF9kYUZGrauZeyxTeRs=;
 b=S77U0SCEJ2Icc8VRJY85T76lzBBmNpKJzmRm4m0dQw7kd8gtnklbB57b1IRJTe0kgK
 /p2a7zh1ACKHIEJJlrLBsLJHw3VG4yHBftgOhcjONcRqL2c7pN04UZ1iZZdqu0GvVBJM
 y8iNOhxdn0xXK9wWs0QXTBXK7/cTGoYPIZGoKr1+UKNxthZFZXDFt1EcFjfj1Tn8iVKL
 wgTGlm7ejBkzrBUkjGa9dMiX0psA+Y6qic9/W0KayXNjPheG7UPrjnse2IZK4zZ0tamp
 tytLziOr79hWXziQdbOTmFs3TCOeCttn/qoVoXo8syvTxEUbKtjuiffrFS8tpnZ2jtnW
 MpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474469; x=1780079269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vUC9cAbO+O9/DBX4sEI5SDbdyF9kYUZGrauZeyxTeRs=;
 b=EJrsvq8VMvAoSvSdGSWiunpGJWDnQB0VaimJz/S0EgSaJqZ8VoTZj1rphBVULw/XcG
 eS/0BjEMTIdBY4HYlPL2rWmmtQkuhr1wKlW8FcSJBrKJ09g9lB7Lq7ZqmsDvwZbdV/Px
 fsWmPriy/5rrg2+wtflD8X6i3cpckHY9/pNtR1td0LAv0f3n1vxIJqSPuiTrAaQUDnZA
 qObLwG9ShTd/QaM77IVDbw2v5wqKWCIgQNM08eeCQ5lfVK6BBuNa+mPmFsrUbZLq5AsD
 eh2SbNHM1F0UpV/xtPs9XYTWkBhEGySqUMVFbXIl3x3IzQY0cxjc9R8n7us/slpKhURL
 6+LA==
X-Gm-Message-State: AOJu0Yx1BQBTPgW1ZocoOA4MpDGVKrthrz+vzQCyNgrRQ3ulcyBrRSgz
 9FEszI34gdVB40q6VjGKf3sqoCBjK91D6T5sYEnhjoWes0UWFpIjMaQ8dKqWwOSON6Ic28VnsKJ
 i26G/
X-Gm-Gg: Acq92OEp/gR3UZ0tW7POqVSTmiEwK5T2i0QBbw+0KdIC/WVpaymBO6gzMw6J4XBVNsM
 rsxHIAo5ROkWrYuu2lCefxf6s1yRYy65O/Nq+7RPKn+uiahSL7FzLIcotOGRTRvcCwZSVKPFBTs
 DkFhgUVuR+8KT2eR2twQS53Gj1P7dhld/xJ4mE3OyzLDQp+R4LePHnG/sF3ntLuo52/NRkJH82v
 JCk4dWQvZI5oLCAlFqp9KabnbYReRPG2VIbCy1bm3lCsKgyKzN8em5kvwK2YkIm2ikXRyxTozjg
 j3IudjTshaFCnLlRxRsj/2Wnmi4+n8eeXnrSsUJ7VuLiqLeRfESLT/YMrZ/4ilIrgH41y9tUdSh
 Kck5RuuFt5KNeQRuhTVrJvkv2T7+ce/siqKi8C8vfYPf4QfDXs6WCA7b35KVtzbYnxeMjCFJiCG
 1KxZh8RQCsyTa9Xslx8K/uY390+MUu
X-Received: by 2002:a17:903:28d:b0:2b9:f55e:1c1b with SMTP id
 d9443c01a7336-2beb036aa31mr48518835ad.5.1779474468739; 
 Fri, 22 May 2026 11:27:48 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/30] fpu: Use get_default_nan_mode everywhere
Date: Fri, 22 May 2026 11:26:52 -0700
Message-ID: <20260522182658.184604-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 6a67e6af2c..bef47a932d 100644
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


