Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74F8E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRCx-00021z-SI; Mon, 23 Feb 2026 03:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRCv-0001zN-Lz
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:21 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRCt-00080v-RB
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:21 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c6e1e748dc1so1147992a12.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 00:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771834938; x=1772439738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzMc4Jsiwc1hf5XheDo0H2ldJJ6ILRyIuKU7WU6n5TQ=;
 b=tQOB18fQO/HDq7VKTW/uZAQfvJxdfxaFHlz6SS+TIiNfNfamwChSeAXGI+SevYXju+
 Yr2DdcDLIzQzKiR0ISU0bYCY3SRcXLIxnB4WTljVLokrTb3RNBF3frVuroX0kTfmlC75
 9LQ48g8/WcR21yDcFnYAU583/gS0OiqP0YzkznlfRueI9wKaOO0DvDHH9jizQl8dZFZ7
 8vFm+6np9XIgAqzcH+U5R4/I7NObGvPcAiqF7/vSpQGD0CiXfcyYLpBNyuQkwLcziD2K
 JoWXON+61xv8q/EW6XyGRhbqBPSCRMzZxtaI70ys/fBhyHfUoIKlEce1Rjonvdp+7K+m
 tPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771834938; x=1772439738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pzMc4Jsiwc1hf5XheDo0H2ldJJ6ILRyIuKU7WU6n5TQ=;
 b=BKsm0c/om8+gMRUeor6dV91khSoVpc2L5Jfa7DUI2dXfZ2kLPYv2qdNv9BFzSouikW
 QO72rLcPjs1RsmAoT2sa0ashzoFfGaHMJMdDfhAQoqzhOyE6HyqxpQP3LGtpDmO+JsUv
 DpHAtsJgza9ZFm2HbV3kpNMFM0wY7vRSJ+XoKkdKwt6cPavAneoJSyi6hhgf6A51rxbc
 Mc0H931ak2j8x+ryqVycL1ci6HiXz+Te4yUCMGlvuQ9z7+DP5j8UH3IHDMY6zTL859Xv
 tfEcKMuLMHYOdfFL1IYcttkBKdZS8ZZiHVFm7zcHdXucaQ0xBxcRtWNs5O/ZvMpJv0OZ
 ncKQ==
X-Gm-Message-State: AOJu0YysS8djrLr+rMsPaFczY7LeQgM5s82E3/FbZbOw7NWxvZEKafpN
 XcmccqCdjnh9SugrK8xJUqdE5X7QzQK3zuH38THbkAAS/Q5gHmA1y+in+L9On6+c/BMz6FbguqQ
 q1IikH3s=
X-Gm-Gg: ATEYQzzURbBLy1Tm7zk1zS+5hqyzsfuVK7JDzgnc48jdBHMwC0tfNLQcvSKNGdu+Cfk
 KekpS70K8FL1xyCOdb3I1N+/UIGGRy6JzZqvhOlHy6Jk7ciHSNtpQRuh0ZtHVmGRv+aLXMygI1+
 V0sf1X/BmtGKAlhpw4OAj273V2NRkcUA5rJRNA4+S0U746/tOPEs4i6QiaoREKWyMChFTEt9415
 raf+AVaQ09yBy1TJdwGjvUsFTkQEfIu6QKsKlMi8IEhDDjj6Tqp16qEcxKzCiBWjsyMtTcABPB6
 7P7bwe9VMZTJJ0/1PGx0sx42ybSXknOeiSoHteunKSEu8SbHtYgTN4aL68XffpcynXV7KTtN90K
 XnvbAOW9kE8SuLoKiYgW41AWxTn15Krtz50hw+2dbsPRx4Vp9TSy3PwQGEWbJopxJt+NkmKsUAB
 EVOdGQwbGOnEpz9P8cI4uv668oJwXOfya2vHmiB+/vikVS/cYLPwPlK0pxPD1uOeUvBA==
X-Received: by 2002:a17:903:234f:b0:2a0:89c6:1824 with SMTP id
 d9443c01a7336-2ad5f7348bamr122274025ad.8.1771834938247; 
 Mon, 23 Feb 2026 00:22:18 -0800 (PST)
Received: from stoup.. (123-243-199-74.static.tpgi.com.au. [123.243.199.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f5dd7asm86543625ad.28.2026.02.23.00.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 00:22:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com,
	chao.liu.zevorn@gmail.com
Subject: [PATCH v5 4/9] fpu: Introduce FloatFmtExpMaxKind
Date: Mon, 23 Feb 2026 19:21:49 +1100
Message-ID: <20260223082154.5623-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223082154.5623-1-richard.henderson@linaro.org>
References: <20260223082154.5623-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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


