Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93220FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLq-0000ZJ-Bw; Wed, 29 Apr 2026 18:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLo-0000P8-B6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:48 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLm-00056S-Gk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:48 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35d9f68d011so109356a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501545; x=1778106345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMNMmP51MzAfmnEvRon5cWfF7WNzLdBZNzrwQ9eWX/c=;
 b=UciMemuXpMx7dhGucB2zn8TW+8KY3lWOwo5xalj4NWElg2W8+JeASUlSw5HLNkaZxU
 rG5/6k9meJKyzXH6TvdXMvtR/3sWPM5KA+moWsbr/9GYjgjQ7bxYffWCrGmlWTaqkuyv
 CK6MsG/FKWC2dQ8ICtQLFHsOT3XhReN2CyLQMTUEFtkbJ8cqhLp9a7KB2seeT3YmaCNr
 TuD3OLjaOMF1Xbs4kkxRQN9SS2Z57LOTSZ5xr0nHhZ+KVlE2WZcVuouVFsncA/X0y1CM
 Sf6TPNdqkSkI9uJKxMcpTB2uomAWcv7GMaa19j8XIbNBLCe+SMvnYHF0erTpHLlNcveS
 n7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501545; x=1778106345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XMNMmP51MzAfmnEvRon5cWfF7WNzLdBZNzrwQ9eWX/c=;
 b=P7V/SmfYAdFOJP5JazYfS//SyoqDIBxFCVEgste3IePFRwNt2zH1wS5R6e7S7wgySY
 449XSUNWVCcOy8lEtIg14LNW2Y2+AAA5bDfB4oADWrKW1TsGJi0cqTZ7BT7GrMzZU6jc
 SLPO9poWgAW0qhzBBpjW/0Oxv1Co9A/IuZIHsWrBw5fXoPaNQ0WJ4A1IqSx1T1Uvr3zQ
 uLFH1Pxw1ldkeAgmTH72j3ixcSJXuIjwnCGwNW8/WoOiMZJ8J9LBwdjsT2txgqwhla7m
 yWJxeFxGmK5weW3MKnQCV9al0vppI5jAibANzsYgjQkb1ZFw162R6/G57I0afoTooBBa
 BIxg==
X-Gm-Message-State: AOJu0YwOT0pjKhfaKiIfX+dgch8fRvd4gweO+8z8HyxcCmjFEPJXNDxN
 z+aQ4/ziWlQTYfoFeNu+bqv2GFG82eN66gYpqN5YQUxU3qhOGbZNyi5N4tZu13Zxw2GeYZfYBE+
 R0OQWJjk=
X-Gm-Gg: AeBDievgESicxW1hTOP6RNltboedSg8WgR/qLZxPb5Wu289a4we++EhHrIiotJD9UJR
 RygC7TgiS1iMpz2xr6ARhFHZg4DAuCG7qX3Fbf6zl/9kk7HFvKRbv/ClS3MCsYTO+wzTpyzHKh+
 jHZIauXYuSBhP81SCigVtAp0em4pQQFE7ReHkb5Lh1ouxjcvcy+MmdM9heCZNxIAeV8Cx3mvxRD
 8j6s99/OjQE9kxsZH793GE3m4N0fUSsV7lUJ1aQrdvcAcF0RGqupovXUUSJE5Nqy25OjPqK6Ii+
 ck72+hhmvc1gX0Haakmw3ugxRL3QusAIKrSl7yzK2ohsqF/RCszZW9ptN/RV8zth2HM/1gXk0Xk
 QudtpUAEP/ycFV5qyKsoHEaKiLpXdVPiur8Uq2rtZkNx/Am1JrKjtPp/AFLvePvc6/tTn/DWskL
 32OPwhISho1z0Q0Og+K/ON0WQ13QiqNNbLqad2l2lJRBvbZwu6o+k=
X-Received: by 2002:a17:90b:1fc6:b0:35b:e4d8:e21d with SMTP id
 98e67ed59e1d1-364c2f8216cmr167837a91.2.1777501544956; 
 Wed, 29 Apr 2026 15:25:44 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/48] fpu: Drop parts_float_to_sint_modulo
Date: Thu, 30 Apr 2026 08:24:18 +1000
Message-ID: <20260429222445.26301-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Use parts64_float_to_sint_modulo at each call site.

That leaves parts128_float_to_sint_modulo unused,
so move the whole function back to softfloat.c and
specialize for FloatParts64.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 84 +++++++++++++++++++++++++++++++++------
 fpu/softfloat-parts.c.inc | 79 ------------------------------------
 2 files changed, 72 insertions(+), 91 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 869b592cd0..0b2638c34b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,16 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static int64_t parts64_float_to_sint_modulo(FloatParts64 *p,
-                                            FloatRoundMode rmode,
-                                            int bitsm1, float_status *s);
-static int64_t parts128_float_to_sint_modulo(FloatParts128 *p,
-                                             FloatRoundMode rmode,
-                                             int bitsm1, float_status *s);
-
-#define parts_float_to_sint_modulo(P, R, M, S) \
-    PARTS_GENERIC_64_128(float_to_sint_modulo, P)(P, R, M, S)
-
 static void parts64_sint_to_float(FloatParts64 *p, int64_t a,
                                   int scale, float_status *s);
 static void parts128_sint_to_float(FloatParts128 *p, int64_t a,
@@ -3558,13 +3548,83 @@ int64_t bfloat16_to_int64_round_to_zero(bfloat16 a, float_status *s)
     return bfloat16_to_int64_scalbn(a, float_round_to_zero, 0, s);
 }
 
+/*
+ * Like partsN(float_to_sint), except do not saturate the result.
+ * Instead, return the rounded unbounded precision two's compliment result,
+ * modulo 2**(bitsm1 + 1).
+ */
+static int64_t parts64_float_to_sint_modulo(FloatParts64 *p,
+                                            FloatRoundMode rmode,
+                                            int bitsm1, float_status *s)
+{
+    int flags = 0;
+    uint64_t r;
+    bool overflow = false;
+
+    switch (p->cls) {
+    case float_class_snan:
+        flags |= float_flag_invalid_snan;
+        /* fall through */
+    case float_class_qnan:
+        flags |= float_flag_invalid;
+        r = 0;
+        break;
+
+    case float_class_inf:
+        overflow = true;
+        r = 0;
+        break;
+
+    case float_class_zero:
+        return 0;
+
+    case float_class_normal:
+    case float_class_denormal:
+        /* TODO: 64 - 2 is frac_size for rounding; could use input fmt. */
+        if (parts64_round_to_int_normal(p, rmode, 0, 64 - 2)) {
+            flags = float_flag_inexact;
+        }
+
+        if (p->exp <= DECOMPOSED_BINARY_POINT) {
+            r = p->frac >> (DECOMPOSED_BINARY_POINT - p->exp);
+            if (p->exp < bitsm1) {
+                /* Result in range. */
+            } else if (p->exp == bitsm1) {
+                /* The only in-range value is INT_MIN. */
+                overflow = !p->sign || p->frac != DECOMPOSED_IMPLICIT_BIT;
+            } else {
+                overflow = true;
+            }
+        } else {
+            /* Overflow, but there might still be bits to return. */
+            int shl = p->exp - DECOMPOSED_BINARY_POINT;
+            r = (shl < 64 ? p->frac << shl : 0);
+            overflow = true;
+        }
+
+        if (p->sign) {
+            r = -r;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    if (overflow) {
+        flags = float_flag_invalid | float_flag_invalid_cvti;
+    }
+    float_raise(flags, s);
+    return r;
+}
+
 int32_t float64_to_int32_modulo(float64 a, FloatRoundMode rmode,
                                 float_status *s)
 {
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    return parts_float_to_sint_modulo(&p, rmode, 31, s);
+    return parts64_float_to_sint_modulo(&p, rmode, 31, s);
 }
 
 int64_t float64_to_int64_modulo(float64 a, FloatRoundMode rmode,
@@ -3573,7 +3633,7 @@ int64_t float64_to_int64_modulo(float64 a, FloatRoundMode rmode,
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    return parts_float_to_sint_modulo(&p, rmode, 63, s);
+    return parts64_float_to_sint_modulo(&p, rmode, 63, s);
 }
 
 /*
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 9b719ac5cf..d8eb9f5b78 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1415,85 +1415,6 @@ static uint64_t partsN(float_to_uint)(FloatPartsN *p, FloatRoundMode rmode,
     return r;
 }
 
-/*
- * Like partsN(float_to_sint), except do not saturate the result.
- * Instead, return the rounded unbounded precision two's compliment result,
- * modulo 2**(bitsm1 + 1).
- */
-static int64_t partsN(float_to_sint_modulo)(FloatPartsN *p,
-                                            FloatRoundMode rmode,
-                                            int bitsm1, float_status *s)
-{
-    int flags = 0;
-    uint64_t r;
-    bool overflow = false;
-
-    switch (p->cls) {
-    case float_class_snan:
-        flags |= float_flag_invalid_snan;
-        /* fall through */
-    case float_class_qnan:
-        flags |= float_flag_invalid;
-        r = 0;
-        break;
-
-    case float_class_inf:
-        overflow = true;
-        r = 0;
-        break;
-
-    case float_class_zero:
-        return 0;
-
-    case float_class_normal:
-    case float_class_denormal:
-        /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
-        if (partsN(round_to_int_normal)(p, rmode, 0, N - 2)) {
-            flags = float_flag_inexact;
-        }
-
-        if (p->exp <= DECOMPOSED_BINARY_POINT) {
-            /*
-             * Because we rounded to integral, and exp < 64,
-             * we know frac_low is zero.
-             */
-            r = p->frac_hi >> (DECOMPOSED_BINARY_POINT - p->exp);
-            if (p->exp < bitsm1) {
-                /* Result in range. */
-            } else if (p->exp == bitsm1) {
-                /* The only in-range value is INT_MIN. */
-                overflow = !p->sign || p->frac_hi != DECOMPOSED_IMPLICIT_BIT;
-            } else {
-                overflow = true;
-            }
-        } else {
-            /* Overflow, but there might still be bits to return. */
-            int shl = p->exp - DECOMPOSED_BINARY_POINT;
-            if (shl < N) {
-                frac_shl(p, shl);
-                r = p->frac_hi;
-            } else {
-                r = 0;
-            }
-            overflow = true;
-        }
-
-        if (p->sign) {
-            r = -r;
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-
-    if (overflow) {
-        flags = float_flag_invalid | float_flag_invalid_cvti;
-    }
-    float_raise(flags, s);
-    return r;
-}
-
 /*
  * Integer to float conversions
  *
-- 
2.43.0


