Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5E0EFB805
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vulEo-0004Ce-2W; Tue, 24 Feb 2026 00:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulE1-0003ox-5K
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:44:55 -0500
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulDz-0002IW-7t
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:44:48 -0500
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so6429932eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 21:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771911886; x=1772516686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVUWgEvjLQB0NDOZm7G+U6gmWtQsgOgvHpv/+3PxHe0=;
 b=I03uGeldf1T3JC9TVlMx1P8W5Rm5CZo6bwOSRFofRfjiQtxsZxJWglQhXp7jcWR8UI
 FCV7IAZUrTB6pmCSPcU+eGHLZu/CYc9DOk03UZMCNlupDm8B/oo9fklMetoW6gqDDZhq
 YrMIXXWD0CiJCCyrUwmvQOTCwBy3ZAGJQ3+xnZhowN6zqMaBoOdjyq5pRoxjtNaqWYRc
 eBBn3ZK2lwPisJmUcFbzF8IBpJzKBb+XhreXsLzRwW9bMQ3Injg0IYXm6B7NVjsgh6rc
 XjNVV256WagodVg2VfZlWvdMNBjMxj2RXKS+G9nJUL2/6ThtbIXPSUk/syR+DdURWS+V
 VHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771911886; x=1772516686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DVUWgEvjLQB0NDOZm7G+U6gmWtQsgOgvHpv/+3PxHe0=;
 b=FtN6gASc//VO+AUb0pGOYhIXn2g6RE5TKlKaJ51T84Ni+lbxd0XfIhqXq3yE5SQp2s
 wchCB2ApL/gTPeJLxjEw/xDfBGihUEB8HRYeseE/4ZGyHnhEUfsSZhYkXxekxVjR+Qhn
 mUQ0mPDQFgLj45dxMWNs3ESxBy/EVf/s66qvVmrkCnh+SCMP6IYN8qNOdsEpQ1UxL8S8
 xil+lE9D902m0wjL2wS0k5dB1vK449bYT7E/3MYcQyRJHzXP0K3laSLb/0NMi2uwzo2e
 yLxeRrnfogQG4fVHSoBnRPP934ooMFrRt4Zl5RYNoe4k5wUKUQJQyiiYZoGlD5MloUfh
 TCsA==
X-Gm-Message-State: AOJu0YyurRr2aX3NDI2oHw/PHTqdaQn9IOl3X+R/OH9i9qFzvH6tzPim
 syzEmyYrWVqJDEqG1BWleaEMrB0N02KSSvsBFl2i4+OatVFRTru7JkywvdOC9b+TSLy5MV1mVkw
 XZfa9jGg=
X-Gm-Gg: ATEYQzxzupa4WhUU4n4tswlSB7iT5dRiBdhTAfigX+rDlueMqK6wQFHOKsS5SkXyojA
 zPutY7ea0xOwRHtd525OPUlibo33G7GQpM3gJcEkx1tthvKW2+P9fLJguZi0+hp4U0u3FFeqG32
 Y0nKGr7yf173gM3uJ0sPcA0oX90xvfAKI/DaEySO6sYZODSM5u6qejAviffT4vUUHKf2WAt6QPw
 1VFKdcjNzCWi4al3O4wIecuL5988fBOsIGbFzFjRTDANwdylV0UBDO3IQ79Su3iJdQ5Uxjg4yHQ
 nqvNuJ0Rn4jaOPBDvow/8kMbo6o5zc/3gWplYLy+O/hHPLYLP6Mz4+IoscHs+9qzoB7v3Yhagh/
 WXzZrHBZKPNhzi8o3eptmvTxNM5VBPwyGQOeRAHqOA6mAE8ZAa3VbOj+l/QF0w+qAsqQgKif43o
 /hCNykUr7tzyAa7LKCpuegw4vZ5qwiywEANx27HKFyK1zcRTnumYLc
X-Received: by 2002:a05:7300:6c9f:b0:2ba:8121:3f81 with SMTP id
 5a478bee46e88-2bd7bd281f3mr5679297eec.25.1771911885553; 
 Mon, 23 Feb 2026 21:44:45 -0800 (PST)
Received: from stoup.. ([172.56.177.223]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7daa37c7sm5958093eec.12.2026.02.23.21.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 21:44:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 4/9] fpu: Introduce FloatFmtExpMaxKind
Date: Tue, 24 Feb 2026 16:44:12 +1100
Message-ID: <20260224054417.32430-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224054417.32430-1-richard.henderson@linaro.org>
References: <20260224054417.32430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=richard.henderson@linaro.org; helo=mail-dy1-x1330.google.com
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

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 17 ++++++--
 fpu/softfloat-parts.c.inc | 92 ++++++++++++++++++++++++---------------
 2 files changed, 69 insertions(+), 40 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8740975348..8d8e576757 100644
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
index 79b56014ab..455bbf281e 100644
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


