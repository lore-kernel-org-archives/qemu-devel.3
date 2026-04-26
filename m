Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ECDFF8863
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpe-0000KX-MO; Sun, 26 Apr 2026 09:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzor-0006WK-QV
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:45 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzon-0001rZ-Iv
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:44 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so6302556a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211200; x=1777816000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GlUZEeXNrd6IeBTT/VPgwheNJ2QhpgSCUGop1hIVl8=;
 b=FyWMDIp3KALu3tcxavaUbvTUltKzVK9yFqznPX+pAE1LEKWAC6n7chbeA6Qgi3AXgM
 L75ArCERyMgbNmlnmoUdFBAoQ0RWRe47oLTjy5DxAVm2XGPnFtIvGBOH/HyuJjTdVvCk
 WJJaemvCzQn0d1JqlbFPnnUVGNEX50o+IZSpNWxz7JwOU2rm8Ugy8V2sc3KXYmsJMtBC
 1rYAg/Q2ue/DiThWsykWXbMut0VFspJSd2KNThcQCYozqZgInKdV1epETDR3ERA+aofY
 wocWeh9Eqq+K1kIKHPTGvJEqd9+sXnrTHE0F98LN7dhIy1KKHS+za7v/Nf00dYWpeAWK
 kwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211200; x=1777816000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3GlUZEeXNrd6IeBTT/VPgwheNJ2QhpgSCUGop1hIVl8=;
 b=fsVXto97hRsc7QKSZE5yIf4jjgJNj21QwxFmVqLtqk+jyVme6cH734tc/mYV0av0AH
 h6sSZLsX5vLoaaIj/WPWch1xguMjNJpYvGU1kRIC7or0KDJivVBrBIARYYOIWAWHL3wW
 IFBh5xxXE8a3Qq6lVtuxgTnqrRd43/G/BfA1A+fUGndpWlBxvHGzPGtteTHN2oJb+YgH
 vg62DqPI/AMbwhHCyzIwxiaO1KxvKq1my1rVcUfvdIVV/9GbjAbFUBvP5bPvxHEZvJ5t
 s6i9+3F7ZDQqKptevsWdRoIwmzd46aEs+kwDIGI6Mj/cTe3zA49UC2yJRxFuYVyJ4u9q
 41Hg==
X-Gm-Message-State: AOJu0YxvlI4Fj3L9Kk78SKRMzlVKcH8ptFWosSbMBhRQd4eqhwasaTkv
 mZXvLfrHkgTE9nd6D5lgl0qCQewdkgssHplxT5qT2ll81n0eMbOTmNa8WpwVWP0JH8bvOTGh/Zb
 IFKxpj00=
X-Gm-Gg: AeBDiesLKVmEa25wYPizWUJEW6kKjVCmFYHOjvGi/AHmkuFcP4lCcElufoi5CnHOnw/
 vhRtTfvTkxXAslLq7r/5imVbamT2+rGaTJOoULh5z/AWHAzTaqxiBPsBSc/R5VmtREMPLvyIzb1
 NpMzXDOn/Q4xSNLAAC3GerL7Ja+1q/kGQdRiemzBWYero80kCjhKWOUlsgVKmnXGWNpgavH0zaX
 SRAeGc4DJ76CMxPJRor+wDDtuRLCSGr+V4lzZzNtGRC1QRNiOozGPkfogWY0V51rMirWxoHQ1Yq
 Ls0+tWfQKMW4k2Gp7Cvwq9JViKNrTpxZr5xWa9mek/TPTMCXoXmc0QcmCe2gHVCdOmno3PPlRr0
 +S45s4Zk/PmwQ/L7K953N10b3lIjL3nw3kr0/4L6pS6YwvlH6NVNATJBRzV+YjiIv9bQc3E4KnO
 AaD71f7LJ3Ng3iiaqEDjM3FkXcNJG1HnG+lJZQUx9pJaFu9vNlskQ=
X-Received: by 2002:a17:90a:6c90:b0:35f:bb33:d721 with SMTP id
 98e67ed59e1d1-361403cbdb9mr24620435a91.5.1777211199882; 
 Sun, 26 Apr 2026 06:46:39 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:46:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 77/84] fpu: Return struct from parts{64,128}_mul
Date: Sun, 26 Apr 2026 23:39:54 +1000
Message-ID: <20260426134002.865628-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

At the same time, export.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  5 +++++
 fpu/softfloat.c               | 34 +++++++++++++++++-----------------
 fpu/softfloat-parts.c.inc     | 35 ++++++++++++++++-------------------
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index f8f96e2f68..f2c31eb7a6 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -189,6 +189,11 @@ FloatRelation parts64_compare(const FloatParts64 *a, const FloatParts64 *b,
 FloatRelation parts128_compare(const FloatParts128 *a, const FloatParts128 *b,
                                float_status *s, bool quiet);
 
+FloatParts64 parts64_mul(const FloatParts64 *a, const FloatParts64 *b,
+                         float_status *s);
+FloatParts128 parts128_mul(const FloatParts128 *a, const FloatParts128 *b,
+                           float_status *s);
+
 FloatParts64 parts64_muladd_scalbn(const FloatParts64 *a,
                                    const FloatParts64 *b,
                                    const FloatParts64 *c,
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d51920652a..2db08ca660 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1801,9 +1801,9 @@ float16 QEMU_FLATTEN float16_mul(float16 a, float16 b, float_status *status)
 {
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float16_round_pack_canonical(pr, status);
+    return float16_round_pack_canonical(&pr, status);
 }
 
 static float32 QEMU_SOFTFLOAT_ATTR
@@ -1811,9 +1811,9 @@ soft_f32_mul(float32 a, float32 b, float_status *status)
 {
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float32_round_pack_canonical(pr, status);
+    return float32_round_pack_canonical(&pr, status);
 }
 
 static float64 QEMU_SOFTFLOAT_ATTR
@@ -1821,9 +1821,9 @@ soft_f64_mul(float64 a, float64 b, float_status *status)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float64_round_pack_canonical(pr, status);
+    return float64_round_pack_canonical(&pr, status);
 }
 
 static float hard_f32_mul(float a, float b)
@@ -1854,9 +1854,9 @@ float64 float64r32_mul(float64 a, float64 b, float_status *status)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float64r32_round_pack_canonical(pr, status);
+    return float64r32_round_pack_canonical(&pr, status);
 }
 
 bfloat16 QEMU_FLATTEN
@@ -1864,9 +1864,9 @@ bfloat16_mul(bfloat16 a, bfloat16 b, float_status *status)
 {
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return bfloat16_round_pack_canonical(pr, status);
+    return bfloat16_round_pack_canonical(&pr, status);
 }
 
 float128 QEMU_FLATTEN
@@ -1874,23 +1874,23 @@ float128_mul(float128 a, float128 b, float_status *status)
 {
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
-    FloatParts128 *pr = parts128_mul(&pa, &pb, status);
+    FloatParts128 pr = parts128_mul(&pa, &pb, status);
 
-    return float128_round_pack_canonical(pr, status);
+    return float128_round_pack_canonical(&pr, status);
 }
 
 floatx80 QEMU_FLATTEN
 floatx80_mul(floatx80 a, floatx80 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
+    FloatParts128 pa, pb;
 
     if (!floatx80_unpack_canonical(&pa, a, status) ||
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
 
-    pr = parts128_mul(&pa, &pb, status);
-    return floatx80_round_pack_canonical(pr, status);
+    pa = parts128_mul(&pa, &pb, status);
+    return floatx80_round_pack_canonical(&pa, status);
 }
 
 /*
@@ -5108,14 +5108,14 @@ float32 float32_exp2(float32 a, float_status *status)
     float_raise(float_flag_inexact, status);
 
     tp = float64_unpack_canonical(float64_ln2, status);
-    xp = *parts64_mul(&xp, &tp, status);
+    xp = parts64_mul(&xp, &tp, status);
     xnp = xp;
 
     rp = float64_unpack_canonical(float64_one, status);
     for (int i = 0; i < 15; i++) {
         tp = float64_unpack_canonical(float32_exp2_coefficients[i], status);
         rp = parts64_muladd_scalbn(&tp, &xnp, &rp, 0, 0, status);
-        xnp = *parts64_mul(&xnp, &xp, status);
+        xnp = parts64_mul(&xnp, &xp, status);
     }
 
     return float32_round_pack_canonical(&rp, status);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index fcb6b33f23..dca751fb94 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -613,55 +613,52 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
  * `b'. The operation is performed according to the IEC/IEEE Standard
  * for Binary Floating-Point Arithmetic.
  */
-static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
-                                float_status *s)
+FloatPartsN partsN(mul)(const FloatPartsN *a, const FloatPartsN *b,
+                        float_status *s)
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
     bool sign = a->sign ^ b->sign;
 
     if (likely(cmask_is_only_normals(ab_mask))) {
         FloatPartsW tmp;
+        FloatPartsN r = {
+            .cls = float_class_normal,
+            .sign = sign,
+            .exp = a->exp + b->exp + 1,
+        };
 
         record_denormals_used(ab_mask, s);
 
         fracN(mulw)(&tmp, a, b);
-        fracN(truncjam)(a, &tmp);
+        fracN(truncjam)(&r, &tmp);
 
-        a->exp += b->exp + 1;
-        if (!(a->frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
-            fracN(add)(a, a, a);
-            a->exp -= 1;
+        if (!(r.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
+            fracN(add)(&r, &r, &r);
+            r.exp -= 1;
         }
 
-        a->sign = sign;
-        return a;
+        return r;
     }
 
     /* Inf * Zero == NaN */
     if (unlikely(ab_mask == float_cmask_infzero)) {
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
-        *a = partsN(default_nan)(s);
-        return a;
+        return partsN(default_nan)(s);
     }
 
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        *a = partsN(pick_nan)(a, b, s);
-	return a;
+        return partsN(pick_nan)(a, b, s);
     }
 
     /* Multiply by 0 or Inf */
     record_denormals_used(ab_mask, s);
 
     if (ab_mask & float_cmask_inf) {
-        a->cls = float_class_inf;
-        a->sign = sign;
-        return a;
+        return (FloatPartsN){ .cls = float_class_inf, .sign = sign };
     }
 
     g_assert(ab_mask & float_cmask_zero);
-    a->cls = float_class_zero;
-    a->sign = sign;
-    return a;
+    return (FloatPartsN){ .cls = float_class_zero, .sign = sign };
 }
 
 /*
-- 
2.43.0


