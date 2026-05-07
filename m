Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5E8CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1ES-0004aZ-Iz; Thu, 07 May 2026 12:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EN-0004X5-9G
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:43 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EH-0006mT-Te
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:42 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso877057a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169932; x=1778774732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGLTypvdlUPkhnyOeCnxkdCtqhINZkOd8mxyDTn1/Y8=;
 b=IazzhCGOulTXSynaTlhlDME8KylmD6GVVYVoQhR2uFMzr6KDGo71mcj6FGxYyCFfvP
 J0i5UuEM7OAcsXgZfgi5IMsM7WDYKy30bIT6tkANtHu595mGPr8et/2e6471oW/wsYNF
 HnR8n1UF4LdE24DwBGpexwegs3Nct5AFAREwsyx2Ua0SUdoTGXecyJ2fM6lqDk41h8+W
 bGCKKmPLWOv+gU06mHKouVqf011V+xDH1zKhNH0uaW/vK81PVIIAjU4wFNkvG2af/YaA
 bDx9SyqQsatBZgR0DyWqL/m1p08APciYliU9DCYM3ZT0/5ek1H8UrNR3TWSH+r8rlAUT
 u8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169932; x=1778774732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WGLTypvdlUPkhnyOeCnxkdCtqhINZkOd8mxyDTn1/Y8=;
 b=nzgDHjVaxD1TnK0IJnpKAnUEN64M9LNtNNfOZPj0eA5lA5CX5frJHhqXO58sDVElcC
 C02UI1SU9ucLluweQ4ozGo5xfoRTpiVtp/hkrgWnZRm0f5gB7J9R3PSbAFjv3UGx34Ps
 LjpGTzXijNirWiwWtRoWjvHFXSJuxqVzcYCcFobbk4r1ZswtSpg1MKKfDxHwwP7CNPlm
 jana/b6fHxOvWlk6nMKuFNMRHuKMurdx+I7Xi+sJr3h31VGvtddymo6VrNONx5i1QKrC
 ncE9ZkMbHkfQ374BhJ5O8yB/kY8OQgZL9q1Pase36dKk7ZCq4/RdCU62mnLHuOjr6SR3
 Hj0A==
X-Gm-Message-State: AOJu0YxUYxjcfxhCn9MEKaJ/gV5pHtEgC5FCdSWlyys/bJ9P1PlNPLU9
 FLJc7hzSH2G8iyo7uOL7rX4hfC48IvaF7lveZzq8XYDM+zzQ1KuxQ94r1hzwDOE6VKEqnWQzEUF
 Fb/fS
X-Gm-Gg: AeBDievHX1zrv2g/uiOUhDFRSWKmq3srRKD9/Ws3yc6e8tGdTMTwZ//hnGSeKEHyjhu
 QgZhc7A9UYNwqQyZgHa70WHZTo/3MdIEsg5MKYFdVBKwgJvNheSd0gT25n9mIPjuTa6dd3kId0n
 cgHNtAL+21OMTnXszOOvngjzACf6HjeziYMdIN+PLtz3kWuv28qvypickk/tPcYZmzS0knsf8IW
 k9brK++yaVEut3O6dQ01yTgJax6iXIMoB0nhznFB/7JgdKHGRh81UZ+kpaPCPiruJWC2g/aN3EB
 kPgDgOh335Y/wf8nH7zGoOr/AEwfzsYWcgrj4VtNKgeLfBKcLY9ucw1J4RuAalQrEpWF6956xFs
 2xys8KJqWSHZrC6GpF1cDglTyh4qiSXaX2gjgsDDFVbufltZzDehjziiwRfHOLSfG8nB209KQ3+
 9p7BtM8P1I+abw4ydCTDo2l1qijNGu8YkuyeIM1xs22jwH/mqGzFAryAcA
X-Received: by 2002:a05:6830:210c:b0:7dc:cbe1:119c with SMTP id
 46e09a7af769-7e1fd20bacbmr2283253a34.10.1778169932174; 
 Thu, 07 May 2026 09:05:32 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/29] fpu: Export FloatFmt structures
Date: Thu,  7 May 2026 11:04:58 -0500
Message-ID: <20260507160518.444797-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Export most of the FloatFmt structures.
Skip float16_params_ahp and the floatx80 precisions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h | 48 ++++++++++++++++++++++++++++++
 fpu/softfloat.c               | 55 +++++------------------------------
 2 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 13c1f3d2d6..a3ae12bb45 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -18,6 +18,54 @@
 #ifndef SOFTFLOAT_PARTS_H
 #define SOFTFLOAT_PARTS_H
 
+/* Format-specific handling of exp == exp_max */
+typedef enum __attribute__((__packed__)) {
+    /* exp==max, frac==0 ? infinity : nan; this is ieee standard. */
+    float_expmax_ieee,
+    /* exp==max is a normal number; no infinity or nan representation. */
+    float_expmax_normal,
+    /* exp==max, frac==max ? nan : normal; no infinity representation. */
+    float_expmax_e4m3,
+} FloatFmtExpMaxKind;
+
+/*
+ * Structure holding all of the relevant parameters for a format.
+ *   exp_size: the size of the exponent field
+ *   exp_bias: the offset applied to the exponent field
+ *   exp_max: the maximum normalised exponent
+ *   frac_size: the size of the fraction field
+ *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINARY_POINT
+ * The following are computed based the size of fraction
+ *   round_mask: bits below lsb which must be rounded
+ * The following optional modifiers are available:
+ *   exp_max_kind: affects how exp == exp_max is interpreted
+ *   has_explicit_bit: has an explicit integer bit; this affects whether
+ *       the float_status floatx80_behaviour handling applies
+ *   overflow_raises_invalid: for float_expmax_normal, raise invalid
+ *       instead of overflow.
+ */
+typedef struct {
+    int exp_size;
+    int exp_bias;
+    int exp_re_bias;
+    int exp_max;
+    int frac_size;
+    int frac_shift;
+    FloatFmtExpMaxKind exp_max_kind;
+    bool has_explicit_bit;
+    bool overflow_raises_invalid;
+    uint64_t round_mask;
+} FloatFmt;
+
+extern const FloatFmt float4_e2m1_params;
+extern const FloatFmt float8_e4m3_params;
+extern const FloatFmt float8_e5m2_params;
+extern const FloatFmt float16_params;
+extern const FloatFmt bfloat16_params;
+extern const FloatFmt float32_params;
+extern const FloatFmt float64_params;
+extern const FloatFmt float128_params;
+
 /*
  * Classify a floating point number. Everything above float_class_qnan
  * is a NaN so cls >= float_class_qnan is any NaN.
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index cd75df3160..d3277e3f60 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -457,45 +457,6 @@ typedef struct {
 #define DECOMPOSED_BINARY_POINT    63
 #define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
 
-/* Format-specific handling of exp == exp_max */
-typedef enum __attribute__((__packed__)) {
-    /* exp==max, frac==0 ? infinity : nan; this is ieee standard. */
-    float_expmax_ieee,
-    /* exp==max is a normal number; no infinity or nan representation. */
-    float_expmax_normal,
-    /* exp==max, frac==max ? nan : normal; no infinity representation. */
-    float_expmax_e4m3,
-} FloatFmtExpMaxKind;
-
-/*
- * Structure holding all of the relevant parameters for a format.
- *   exp_size: the size of the exponent field
- *   exp_bias: the offset applied to the exponent field
- *   exp_max: the maximum normalised exponent
- *   frac_size: the size of the fraction field
- *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINARY_POINT
- * The following are computed based the size of fraction
- *   round_mask: bits below lsb which must be rounded
- * The following optional modifiers are available:
- *   exp_max_kind: affects how exp == exp_max is interpreted
- *   has_explicit_bit: has an explicit integer bit; this affects whether
- *       the float_status floatx80_behaviour handling applies
- *   overflow_raises_invalid: for float_expmax_normal, raise invalid
- *       instead of overflow.
- */
-typedef struct {
-    int exp_size;
-    int exp_bias;
-    int exp_re_bias;
-    int exp_max;
-    int frac_size;
-    int frac_shift;
-    FloatFmtExpMaxKind exp_max_kind;
-    bool has_explicit_bit;
-    bool overflow_raises_invalid;
-    uint64_t round_mask;
-} FloatFmt;
-
 /* Expand fields based on the size of exponent and fraction */
 #define FLOAT_PARAMS_(E)                                \
     .exp_size       = E,                                \
@@ -509,12 +470,12 @@ typedef struct {
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
-static const FloatFmt float4_e2m1_params = {
+const FloatFmt float4_e2m1_params = {
     FLOAT_PARAMS(2, 1),
     .exp_max_kind = float_expmax_normal,
 };
 
-static const FloatFmt float8_e4m3_params = {
+const FloatFmt float8_e4m3_params = {
     FLOAT_PARAMS(4, 3),
     .exp_max_kind = float_expmax_e4m3
 };
@@ -522,11 +483,11 @@ static const FloatFmt float8_e4m3_params = {
 /* 110 << frac_shift, with the implicit bit set */
 #define E4M3_NORMAL_FRAC_MAX  0xe000000000000000ull
 
-static const FloatFmt float8_e5m2_params = {
+const FloatFmt float8_e5m2_params = {
     FLOAT_PARAMS(5, 2)
 };
 
-static const FloatFmt float16_params = {
+const FloatFmt float16_params = {
     FLOAT_PARAMS(5, 10)
 };
 
@@ -536,19 +497,19 @@ static const FloatFmt float16_params_ahp = {
     .overflow_raises_invalid = true,
 };
 
-static const FloatFmt bfloat16_params = {
+const FloatFmt bfloat16_params = {
     FLOAT_PARAMS(8, 7)
 };
 
-static const FloatFmt float32_params = {
+const FloatFmt float32_params = {
     FLOAT_PARAMS(8, 23)
 };
 
-static const FloatFmt float64_params = {
+const FloatFmt float64_params = {
     FLOAT_PARAMS(11, 52)
 };
 
-static const FloatFmt float128_params = {
+const FloatFmt float128_params = {
     FLOAT_PARAMS(15, 112)
 };
 
-- 
2.43.0


