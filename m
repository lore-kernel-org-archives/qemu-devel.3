Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F83DEC1E9E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxMV-00050D-4h; Thu, 05 Feb 2026 06:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLp-0004lU-6x
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:45 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLl-0003ng-84
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:42 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so9200615ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770290198; x=1770894998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMibsSFmr8930GLdEf6auOmzhfpvG0IZCKbbW9pih4Q=;
 b=s9aw9fbdMircau///uh6Kpg1Z8oK+Pz56gahtP0B1GRUU47sivLL2oa08T23GyNbE0
 OCR572u64Q6MPLEHfxaw/1sBsbdu691pJcFN2mvYJHwB5/v5dLh+kTqXVVaMvog/iuHA
 ICzKVQFimKyJSjqVYgGh4INiMB635eC7tFTqCOorNnIcKqqfdeR6WFRFqywvM2JMYTN8
 DRXYGjQaUgNLMxMrQBFCwr3u6GISZrYOfX8wmq2D+tRPqRatdv9hQIQlWNtqPCz7IjeE
 2HrmZ0Km/NJkzLPWGHZcNSPBCpfjVn1kTECvu6BWEr/T0MB8iA6nspXtQjy8ta5Ooef9
 DFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770290198; x=1770894998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gMibsSFmr8930GLdEf6auOmzhfpvG0IZCKbbW9pih4Q=;
 b=wQjMHWb3pOQjdDnTvIxviI1bai9xkXGyu6Y1tGrlqFiys+CFZ9VPGqEQPhccu9XnRj
 HoR1o3AHvllF72Y8Q9+k1JWdCPA2VHcux4RgW/7UAGUcFXiCwCKS9VZ/PDqF00SgWV6Q
 2KRQ5hjO/7/9ih1Dsnu/kjJupoednZRPk/3719D4L8zk7qN1/GIB/Ho7N7sn2jQuC4hH
 Rd4feF7Td1zidl6wYhihIhYb6DQH9j5mygfuQt+0XAPDpIY9oPUj2xtdRnID1LcbLsFS
 HJ5G2ArLjv5xZPjgs6ll9nLc+YDodO9AkoLisuNhaNWY3w1o12645haqwPcNOFZelnVt
 NfqQ==
X-Gm-Message-State: AOJu0Yy3RHJAeBSvK5rnjaP07HWA49dU44E7yddOyxctac2TPs25eMuU
 dlviqn/5d0YUHDAjOw4yFV/+NxHkM8w6fv1CPf/Np8Nt6pCkQ35I2h3glAmZ3Rg8Nu+80PZglol
 fnJOplkk5xw==
X-Gm-Gg: AZuq6aJzhfYkXljMHm2b/f/fHCfuCSicQAPB31q9hdN7svB0JdHMJ09HIfj5JwVscss
 Qp0uS0WCvE3Bsb7Sjr6Wa7CGx4iO2FZlG29J9FvMzP0ykhP0yDH7BW3how0SQlj9OYwnH+hpFjL
 5QcM0XH7JwuyQ9j+YeC5KO/EFbluiC3vg4oV5M/hLkLeOXaZGBLaV1DlWcS7vUzyOkiNvFQoa2/
 8f2yiN2o7hMtjf/wbd/mkmsDSTTcS7Xd9fvP0/l9fyV5FVNiFAkFVazZw68jsDgQiB6vGLnYMdD
 X6z1duRF6OiP5FfpdYTp1jPrswhm+5w5uBHKUuFj9w+XeWxEESkSfLE9mifxfd75MwYHBsYHmsA
 Cr07utmMD9qmNq04LD5n0lnFWECwqzAbjvztwqQoWxp8NhvpgPjxYmaOGRJELz3Qjo/bCbSy+2e
 r4BgOOMkEZrhtfOnPqFwBB
X-Received: by 2002:a17:902:cecc:b0:2a1:3cd9:a737 with SMTP id
 d9443c01a7336-2a933eaa8d3mr64698475ad.36.1770290197820; 
 Thu, 05 Feb 2026 03:16:37 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933851685sm51088435ad.13.2026.02.05.03.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 03:16:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com
Subject: [PATCH v4 4/9] fpu: Introduce FloatFmtExpMaxKind
Date: Thu,  5 Feb 2026 21:16:17 +1000
Message-ID: <20260205111622.461497-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205111622.461497-1-richard.henderson@linaro.org>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Generalize arm_althp to indicate how exp==max should
be handled for the format.  Reorganize canonicalize
and uncanon_normal to use a switch statement, allowing
more cases to be added trivially.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 17 ++++++--
 fpu/softfloat-parts.c.inc | 92 ++++++++++++++++++++++++---------------
 2 files changed, 69 insertions(+), 40 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8094358c2e..18098c4cdd 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -522,7 +522,16 @@ typedef struct {
 #define DECOMPOSED_BINARY_POINT    63
 #define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
 
-/* Structure holding all of the relevant parameters for a format.
+/* Format-specific handling of exp == exp_max */
+typedef enum __attribute__((__packed__)) {
+    /* exp==max, frac==0 ? infinity : nan; this is ieee standard. */
+    float_expmax_ieee,
+    /* exp==max is a normal number; no infinity or nan representation. */
+    float_expmax_normal,
+} FloatFmtExpMaxKind;
+
+/*
+ * Structure holding all of the relevant parameters for a format.
  *   exp_size: the size of the exponent field
  *   exp_bias: the offset applied to the exponent field
  *   exp_max: the maximum normalised exponent
@@ -531,7 +540,7 @@ typedef struct {
  * The following are computed based the size of fraction
  *   round_mask: bits below lsb which must be rounded
  * The following optional modifiers are available:
- *   arm_althp: handle ARM Alternative Half Precision
+ *   exp_max_kind: affects how exp == exp_max is interpreted
  *   has_explicit_bit: has an explicit integer bit; this affects whether
  *   the float_status floatx80_behaviour handling applies
  */
@@ -542,7 +551,7 @@ typedef struct {
     int exp_max;
     int frac_size;
     int frac_shift;
-    bool arm_althp;
+    FloatFmtExpMaxKind exp_max_kind;
     bool has_explicit_bit;
     uint64_t round_mask;
 } FloatFmt;
@@ -566,7 +575,7 @@ static const FloatFmt float16_params = {
 
 static const FloatFmt float16_params_ahp = {
     FLOAT_PARAMS(5, 10),
-    .arm_althp = true
+    .exp_max_kind = float_expmax_normal,
 };
 
 static const FloatFmt bfloat16_params = {
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5e0438fc0b..d3c9c7a913 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -227,18 +227,30 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
             p->exp = fmt->frac_shift - fmt->exp_bias
                    - shift + !has_pseudo_denormals;
         }
-    } else if (likely(p->exp < fmt->exp_max) || fmt->arm_althp) {
-        p->cls = float_class_normal;
-        p->exp -= fmt->exp_bias;
-        frac_shl(p, fmt->frac_shift);
-        p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
-    } else if (likely(frac_eqz(p))) {
-        p->cls = float_class_inf;
-    } else {
-        frac_shl(p, fmt->frac_shift);
-        p->cls = (parts_is_snan_frac(p->frac_hi, status)
-                  ? float_class_snan : float_class_qnan);
+        return;
     }
+    if (unlikely(p->exp == fmt->exp_max)) {
+        switch (fmt->exp_max_kind) {
+        case float_expmax_ieee:
+            if (likely(frac_eqz(p))) {
+                p->cls = float_class_inf;
+            } else {
+                frac_shl(p, fmt->frac_shift);
+                p->cls = (parts_is_snan_frac(p->frac_hi, status)
+                          ? float_class_snan : float_class_qnan);
+            }
+            return;
+        case float_expmax_normal:
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    p->cls = float_class_normal;
+    p->exp -= fmt->exp_bias;
+    frac_shl(p, fmt->frac_shift);
+    p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
 }
 
 /*
@@ -314,29 +326,37 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             p->frac_lo &= ~round_mask;
         }
 
-        if (fmt->arm_althp) {
-            /* ARM Alt HP eschews Inf and NaN for a wider exponent.  */
-            if (unlikely(exp > exp_max)) {
-                /* Overflow.  Return the maximum normal.  */
-                flags = float_flag_invalid;
-                exp = exp_max;
-                frac_allones(p);
-                p->frac_lo &= ~round_mask;
-            }
-        } else if (unlikely(exp >= exp_max)) {
-            flags |= float_flag_overflow;
-            if (s->rebias_overflow) {
-                exp -= fmt->exp_re_bias;
-            } else if (overflow_norm) {
-                flags |= float_flag_inexact;
-                exp = exp_max - 1;
-                frac_allones(p);
-                p->frac_lo &= ~round_mask;
-            } else {
-                flags |= float_flag_inexact;
-                p->cls = float_class_inf;
-                exp = exp_max;
-                frac_clear(p);
+        if (unlikely(exp >= exp_max)) {
+            switch (fmt->exp_max_kind) {
+            case float_expmax_ieee:
+                flags |= float_flag_overflow;
+                if (s->rebias_overflow) {
+                    exp -= fmt->exp_re_bias;
+                } else if (overflow_norm) {
+                    flags |= float_flag_inexact;
+                    exp = exp_max - 1;
+                    frac_allones(p);
+                    p->frac_lo &= ~round_mask;
+                } else {
+                    flags |= float_flag_inexact;
+                    p->cls = float_class_inf;
+                    exp = exp_max;
+                    frac_clear(p);
+                }
+                break;
+
+            case float_expmax_normal:
+                if (unlikely(exp > exp_max)) {
+                    /* Overflow.  Return the maximum normal.  */
+                    flags = float_flag_invalid;
+                    exp = exp_max;
+                    frac_allones(p);
+                    p->frac_lo &= ~round_mask;
+                }
+                break;
+
+            default:
+                g_assert_not_reached();
             }
         }
         frac_shr(p, frac_shift);
@@ -434,13 +454,13 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
             frac_clear(p);
             return;
         case float_class_inf:
-            g_assert(!fmt->arm_althp);
+            assert(fmt->exp_max_kind == float_expmax_ieee);
             p->exp = fmt->exp_max;
             frac_clear(p);
             return;
         case float_class_qnan:
         case float_class_snan:
-            g_assert(!fmt->arm_althp);
+            assert(fmt->exp_max_kind != float_expmax_normal);
             p->exp = fmt->exp_max;
             frac_shr(p, fmt->frac_shift);
             return;
-- 
2.43.0


