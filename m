Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7303DFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDMF-00028o-G4; Wed, 29 Apr 2026 18:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMC-0001or-QX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:12 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDM9-0005E1-BH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:12 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35da9692ec3so264981a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501568; x=1778106368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkxM3MBDHHoyDO221L68O+0q0Gu+Hndr9J7p3POpJe8=;
 b=Cx9DQoPtSPMCnR9GUuhq7W6J7JdoWr1ucytWMApg9rdCy7UX3KGye9PLPz8/WwY7sE
 tLlSi6Wjx2+K5QeTZ6pCfe6GPdKyzjyia5NFVH46OYUXg9TzAdHAYnw18D58R8k8DA11
 kgTdrvyzedvSt6pywsdtxRqzJZDTrJje3FsR82cUDBUro/eEQkEBCUTfsg7G7T8Utqu+
 TYma1JE0UMtuLkFmFALb2k8DITLdztejY6kpBpuVOFBkd5FT53A9HD3ePff7CgLnK0mU
 V2/xHO8Vbc9R8CBWJmyDGp2oQzXQQjwMjDA2uE8z1TdPXqmg97A5s+L1P9qu0mlmDuul
 6hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501568; x=1778106368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CkxM3MBDHHoyDO221L68O+0q0Gu+Hndr9J7p3POpJe8=;
 b=ieY/A+Xvl5U87xI2HyO1eNDVSvbomk9/Pb26xSfZjxOIwYJeALv4Ec7gMJm7Q5B1Ja
 dzaad9LSZanFYyA8pNjUqWlxJF7WVWDb0g3XWv6dcIkE+GwtEiaTLa1BTZh0kB0BbYGk
 X2Fb9V1RH+F+uMOZ2BM5MC4rEDEzTKaIc/ZtoX2KU2qU9EZ5RiBnubBGwEIWlXzN3/oV
 fDY5HlwpNh3OEOTUqOqzPp2oi/BTqxg4SVhOgmFYbKokXw3xVqk0HlK2hLxFXwdduQoQ
 QmH4b81YndJkRHipg4KE6bUqqI8cS9BlSisEmua/N/cb0t4/X2wsToqlY9OdktoPNe+b
 m+wg==
X-Gm-Message-State: AOJu0Yxo2gXBYidCtLQs7ki2IM1SBjzGEL28Y2YsjzBCbd6O23PYZzhi
 DMQVeHBC9cPyEFMMDMbZgjz5V73oMF0EZeKA5JXbKYQlKbauTo6Gycu8IZPeWGJ9rwjrsc6Jt8p
 koisaH/k=
X-Gm-Gg: AeBDies+x8WyE1owXiB7jW+MTU8DroxrnwKdYcnJUdKlD0QNrhFciqN+Mu/gLoDptl8
 HbKNSbTg4VLZRNj3Wk0rcqMfFCO1Bi6rsZol2JUNLTu3exLk0yxoD3YlnBKR6cyeGWj2/RzZKfN
 Atqj58QHqOukRBgiTbrEwmVlwsmuFFPYLpZWMh8XgFCtH7sh+W90GZxHstsHoyGeAKZn5SpRZkp
 b27nmjOI1nZJ9YaV98MTBmtSr4IV54Ok1TCFD1RV3TLDBSW84wjMhrZgrfSwU6xA/XBy35vtmyG
 vehyaYzKb7qfLIZCTRmSssTYfq4SZBaAyCZLarScKLUYbOFrKY8vVuNmogOf+FIzT5nwDHdDQzx
 GUAmrrnIwNEKaEOwwiurJhqxCp/Q20PlMwaZEuqN7O6g2zvvTc+3VvW4f7MYNhgih8uGO/+jG8M
 NE34pjA3NpWU5sD+ul8gtAxpcJIb65iLNiMJsMs48q
X-Received: by 2002:a17:90b:5603:b0:35d:9efd:7956 with SMTP id
 98e67ed59e1d1-364c2f41293mr200398a91.11.1777501567814; 
 Wed, 29 Apr 2026 15:26:07 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/48] fpu: Drop FRAC_GENERIC_64_128{_256}
Date: Thu, 30 Apr 2026 08:24:27 +1000
Message-ID: <20260429222445.26301-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

This requires more complexity to handle const selectors, and
an indirection macro for each function.  Easier to just use
the preprocessor.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c                  |  69 +++++----------------
 fpu/softfloat-parts-addsub.c.inc |  22 +++----
 fpu/softfloat-parts.c.inc        | 102 +++++++++++++++----------------
 3 files changed, 77 insertions(+), 116 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d077e8da69..e462fb7d74 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -774,15 +774,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
  * Helper functions for softfloat-parts.c.inc, per-size operations.
  */
 
-#define FRAC_GENERIC_64_128(NAME, P) \
-    _Generic((P), FloatParts64 *: frac64_##NAME, \
-                  FloatParts128 *: frac128_##NAME)
-
-#define FRAC_GENERIC_64_128_256(NAME, P) \
-    _Generic((P), FloatParts64 *: frac64_##NAME, \
-                  FloatParts128 *: frac128_##NAME, \
-                  FloatParts256 *: frac256_##NAME)
-
 static bool frac64_add(FloatParts64 *r, FloatParts64 *a, FloatParts64 *b)
 {
     return uadd64_overflow(a->frac, b->frac, &r->frac);
@@ -806,8 +797,6 @@ static bool frac256_add(FloatParts256 *r, FloatParts256 *a, FloatParts256 *b)
     return c;
 }
 
-#define frac_add(R, A, B)  FRAC_GENERIC_64_128_256(add, R)(R, A, B)
-
 static bool frac64_addi(FloatParts64 *r, FloatParts64 *a, uint64_t c)
 {
     return uadd64_overflow(a->frac, c, &r->frac);
@@ -819,8 +808,6 @@ static bool frac128_addi(FloatParts128 *r, FloatParts128 *a, uint64_t c)
     return uadd64_overflow(a->frac_hi, c, &r->frac_hi);
 }
 
-#define frac_addi(R, A, C)  FRAC_GENERIC_64_128(addi, R)(R, A, C)
-
 static void frac64_allones(FloatParts64 *a)
 {
     a->frac = -1;
@@ -831,8 +818,6 @@ static void frac128_allones(FloatParts128 *a)
     a->frac_hi = a->frac_lo = -1;
 }
 
-#define frac_allones(A)  FRAC_GENERIC_64_128(allones, A)(A)
-
 static FloatRelation frac64_cmp(FloatParts64 *a, FloatParts64 *b)
 {
     return (a->frac == b->frac ? float_relation_equal
@@ -852,8 +837,6 @@ static FloatRelation frac128_cmp(FloatParts128 *a, FloatParts128 *b)
     return ta < tb ? float_relation_less : float_relation_greater;
 }
 
-#define frac_cmp(A, B)  FRAC_GENERIC_64_128(cmp, A)(A, B)
-
 static void frac64_clear(FloatParts64 *a)
 {
     a->frac = 0;
@@ -864,8 +847,6 @@ static void frac128_clear(FloatParts128 *a)
     a->frac_hi = a->frac_lo = 0;
 }
 
-#define frac_clear(A)  FRAC_GENERIC_64_128(clear, A)(A)
-
 static bool frac64_div(FloatParts64 *a, FloatParts64 *b)
 {
     uint64_t n1, n0, r, q;
@@ -945,8 +926,6 @@ static bool frac128_div(FloatParts128 *a, FloatParts128 *b)
     return ret;
 }
 
-#define frac_div(A, B)  FRAC_GENERIC_64_128(div, A)(A, B)
-
 static bool frac64_eqz(FloatParts64 *a)
 {
     return a->frac == 0;
@@ -957,8 +936,6 @@ static bool frac128_eqz(FloatParts128 *a)
     return (a->frac_hi | a->frac_lo) == 0;
 }
 
-#define frac_eqz(A)  FRAC_GENERIC_64_128(eqz, A)(A)
-
 static void frac64_mulw(FloatParts128 *r, FloatParts64 *a, FloatParts64 *b)
 {
     mulu64(&r->frac_lo, &r->frac_hi, a->frac, b->frac);
@@ -970,8 +947,6 @@ static void frac128_mulw(FloatParts256 *r, FloatParts128 *a, FloatParts128 *b)
                 &r->frac_hi, &r->frac_hm, &r->frac_lm, &r->frac_lo);
 }
 
-#define frac_mulw(R, A, B)  FRAC_GENERIC_64_128(mulw, A)(R, A, B)
-
 static void frac64_neg(FloatParts64 *a)
 {
     a->frac = -a->frac;
@@ -993,8 +968,6 @@ static void frac256_neg(FloatParts256 *a)
     a->frac_hi = usub64_borrow(0, a->frac_hi, &c);
 }
 
-#define frac_neg(A)  FRAC_GENERIC_64_128_256(neg, A)(A)
-
 static int frac64_normalize(FloatParts64 *a)
 {
     if (a->frac) {
@@ -1068,8 +1041,6 @@ static int frac256_normalize(FloatParts256 *a)
     return ret;
 }
 
-#define frac_normalize(A)  FRAC_GENERIC_64_128_256(normalize, A)(A)
-
 static void frac64_modrem(FloatParts64 *a, FloatParts64 *b, uint64_t *mod_quot)
 {
     uint64_t a0, a1, b0, t0, t1, q, quot;
@@ -1248,8 +1219,6 @@ static void frac128_modrem(FloatParts128 *a, FloatParts128 *b,
     a->frac_lo = a1 | (a2 != 0);
 }
 
-#define frac_modrem(A, B, Q)  FRAC_GENERIC_64_128(modrem, A)(A, B, Q)
-
 static void frac64_shl(FloatParts64 *a, int c)
 {
     a->frac <<= c;
@@ -1273,8 +1242,6 @@ static void frac128_shl(FloatParts128 *a, int c)
     a->frac_lo = a1;
 }
 
-#define frac_shl(A, C)  FRAC_GENERIC_64_128(shl, A)(A, C)
-
 static void frac64_shr(FloatParts64 *a, int c)
 {
     a->frac >>= c;
@@ -1298,8 +1265,6 @@ static void frac128_shr(FloatParts128 *a, int c)
     a->frac_lo = a1;
 }
 
-#define frac_shr(A, C)  FRAC_GENERIC_64_128(shr, A)(A, C)
-
 static void frac64_shrjam(FloatParts64 *a, int c)
 {
     uint64_t a0 = a->frac;
@@ -1388,8 +1353,6 @@ static void frac256_shrjam(FloatParts256 *a, int c)
     a->frac_hi = a0;
 }
 
-#define frac_shrjam(A, C)  FRAC_GENERIC_64_128_256(shrjam, A)(A, C)
-
 static bool frac64_sub(FloatParts64 *r, FloatParts64 *a, FloatParts64 *b)
 {
     return usub64_overflow(a->frac, b->frac, &r->frac);
@@ -1413,8 +1376,6 @@ static bool frac256_sub(FloatParts256 *r, FloatParts256 *a, FloatParts256 *b)
     return c;
 }
 
-#define frac_sub(R, A, B)  FRAC_GENERIC_64_128_256(sub, R)(R, A, B)
-
 static void frac64_truncjam(FloatParts64 *r, FloatParts128 *a)
 {
     r->frac = a->frac_hi | (a->frac_lo != 0);
@@ -1426,8 +1387,6 @@ static void frac128_truncjam(FloatParts128 *r, FloatParts256 *a)
     r->frac_lo = a->frac_hm | ((a->frac_lm | a->frac_lo) != 0);
 }
 
-#define frac_truncjam(R, A)  FRAC_GENERIC_64_128(truncjam, R)(R, A)
-
 static void frac64_widen(FloatParts128 *r, FloatParts64 *a)
 {
     r->frac_hi = a->frac;
@@ -1442,8 +1401,6 @@ static void frac128_widen(FloatParts256 *r, FloatParts128 *a)
     r->frac_lo = 0;
 }
 
-#define frac_widen(A, B)  FRAC_GENERIC_64_128(widen, B)(A, B)
-
 /*
  * Reciprocal sqrt table.  1 bit of exponent, 6-bits of mantessa.
  * From https://git.musl-libc.org/cgit/musl/tree/src/math/sqrt_data.c
@@ -1468,6 +1425,8 @@ static const uint16_t rsqrt_tab[128] = {
     0xba91, 0xb9cc, 0xb90a, 0xb84a, 0xb78c, 0xb6d0, 0xb617, 0xb560,
 };
 
+#define fracN(NAME)    glue(glue(glue(frac,N),_),NAME)
+#define fracW(NAME)    glue(glue(glue(frac,W),_),NAME)
 #define partsN(NAME)   glue(glue(glue(parts,N),_),NAME)
 #define partsW(NAME)   glue(glue(glue(parts,W),_),NAME)
 #define FloatPartsN    glue(FloatParts,N)
@@ -1494,6 +1453,8 @@ static const uint16_t rsqrt_tab[128] = {
 
 #undef  N
 #undef  W
+#undef  fracN
+#undef  fracW
 #undef  partsN
 #undef  partsW
 #undef  FloatPartsN
@@ -1624,19 +1585,19 @@ static float64 float64r32_pack_raw(FloatParts64 *p)
              * The result is denormal for float32, but can be represented
              * in normalized form for float64.  Adjust, per canonicalize.
              */
-            int shift = frac_normalize(p);
+            int shift = frac64_normalize(p);
             p->exp = (float32_params.frac_shift -
                       float32_params.exp_bias - shift + 1 +
                       float64_params.exp_bias);
-            frac_shr(p, float64_params.frac_shift);
+            frac64_shr(p, float64_params.frac_shift);
         } else {
-            frac_shl(p, float32_params.frac_shift - float64_params.frac_shift);
+            frac64_shl(p, float32_params.frac_shift - float64_params.frac_shift);
             p->exp += float64_params.exp_bias - float32_params.exp_bias;
         }
         break;
     case float_class_snan:
     case float_class_qnan:
-        frac_shl(p, float32_params.frac_shift - float64_params.frac_shift);
+        frac64_shl(p, float32_params.frac_shift - float64_params.frac_shift);
         p->exp = float64_params.exp_max;
         break;
     case float_class_inf:
@@ -1724,7 +1685,7 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
 
             p64.sign = p->sign;
             p64.exp = p->exp;
-            frac_truncjam(&p64, p);
+            frac64_truncjam(&p64, p);
             parts64_uncanon_normal(&p64, s, fmt, false);
             frac = p64.frac;
             exp = p64.exp;
@@ -2698,7 +2659,7 @@ static void parts_float_to_float_narrow(FloatParts64 *a, FloatParts128 *b,
         float_raise(float_flag_input_denormal_used, s);
         /* fall through */
     case float_class_normal:
-        frac_truncjam(a, b);
+        frac64_truncjam(a, b);
         break;
     case float_class_snan:
     case float_class_qnan:
@@ -2717,7 +2678,7 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     a->cls = b->cls;
     a->sign = b->sign;
     a->exp = b->exp;
-    frac_widen(a, b);
+    frac64_widen(a, b);
 
     if (is_nan(a->cls)) {
         parts128_return_nan(a, s);
@@ -4939,7 +4900,7 @@ static void parts64_log2(FloatParts64 *a, float_status *s, const FloatFmt *fmt)
         FloatParts64 f = {
             .cls = float_class_normal, .frac = r
         };
-        f.exp = f_exp - frac_normalize(&f);
+        f.exp = f_exp - frac64_normalize(&f);
 
         if (a_exp < 0) {
             parts64_sub_normal(a, &f);
@@ -5010,7 +4971,7 @@ float128 float128_default_nan(float_status *status)
     FloatParts128 p;
 
     parts128_default_nan(&p, status);
-    frac_shr(&p, float128_params.frac_shift);
+    frac128_shr(&p, float128_params.frac_shift);
     return float128_pack_raw(&p);
 }
 
@@ -5076,9 +5037,9 @@ float128 float128_silence_nan(float128 a, float_status *status)
     FloatParts128 p;
 
     float128_unpack_raw(&p, a);
-    frac_shl(&p, float128_params.frac_shift);
+    frac128_shl(&p, float128_params.frac_shift);
     parts128_silence_nan(&p, status);
-    frac_shr(&p, float128_params.frac_shift);
+    frac128_shr(&p, float128_params.frac_shift);
     return float128_pack_raw(&p);
 }
 
diff --git a/fpu/softfloat-parts-addsub.c.inc b/fpu/softfloat-parts-addsub.c.inc
index ae5c1017c5..accf996d7c 100644
--- a/fpu/softfloat-parts-addsub.c.inc
+++ b/fpu/softfloat-parts-addsub.c.inc
@@ -20,14 +20,14 @@ static void partsN(add_normal)(FloatPartsN *a, FloatPartsN *b)
     int exp_diff = a->exp - b->exp;
 
     if (exp_diff > 0) {
-        frac_shrjam(b, exp_diff);
+        fracN(shrjam)(b, exp_diff);
     } else if (exp_diff < 0) {
-        frac_shrjam(a, -exp_diff);
+        fracN(shrjam)(a, -exp_diff);
         a->exp = b->exp;
     }
 
-    if (frac_add(a, a, b)) {
-        frac_shrjam(a, 1);
+    if (fracN(add)(a, a, b)) {
+        fracN(shrjam)(a, 1);
         a->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
         a->exp += 1;
     }
@@ -39,20 +39,20 @@ static bool partsN(sub_normal)(FloatPartsN *a, FloatPartsN *b)
     int shift;
 
     if (exp_diff > 0) {
-        frac_shrjam(b, exp_diff);
-        frac_sub(a, a, b);
+        fracN(shrjam)(b, exp_diff);
+        fracN(sub)(a, a, b);
     } else if (exp_diff < 0) {
         a->exp = b->exp;
         a->sign ^= 1;
-        frac_shrjam(a, -exp_diff);
-        frac_sub(a, b, a);
-    } else if (frac_sub(a, a, b)) {
+        fracN(shrjam)(a, -exp_diff);
+        fracN(sub)(a, b, a);
+    } else if (fracN(sub)(a, a, b)) {
         /* Overflow means that A was less than B. */
-        frac_neg(a);
+        fracN(neg)(a);
         a->sign ^= 1;
     }
 
-    shift = frac_normalize(a);
+    shift = fracN(normalize)(a);
     if (likely(shift < N)) {
         a->exp -= shift;
 	return true;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5f27efd288..5d344f9afe 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -98,7 +98,7 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
             ret = b;
             break;
         }
-        cmp = frac_cmp(a, b);
+        cmp = fracN(cmp)(a, b);
         if (cmp == 0) {
             cmp = a->sign < b->sign;
         }
@@ -215,14 +215,14 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
         (status->floatx80_behaviour & floatx80_pseudo_denormal_valid);
 
     if (unlikely(p->exp == 0)) {
-        if (likely(frac_eqz(p))) {
+        if (likely(fracN(eqz)(p))) {
             p->cls = float_class_zero;
         } else if (status->flush_inputs_to_zero) {
             float_raise(float_flag_input_denormal_flushed, status);
             p->cls = float_class_zero;
-            frac_clear(p);
+            fracN(clear)(p);
         } else {
-            int shift = frac_normalize(p);
+            int shift = fracN(normalize)(p);
             p->cls = float_class_denormal;
             p->exp = fmt->frac_shift - fmt->exp_bias
                    - shift + !has_pseudo_denormals;
@@ -232,10 +232,10 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
     if (unlikely(p->exp == fmt->exp_max)) {
         switch (fmt->exp_max_kind) {
         case float_expmax_ieee:
-            if (likely(frac_eqz(p))) {
+            if (likely(fracN(eqz)(p))) {
                 p->cls = float_class_inf;
             } else {
-                frac_shl(p, fmt->frac_shift);
+                fracN(shl)(p, fmt->frac_shift);
                 p->cls = (parts_is_snan_frac(p->frac_hi, status)
                           ? float_class_snan : float_class_qnan);
             }
@@ -244,7 +244,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
             break;
         case float_expmax_e4m3:
             if (p->frac_hi == 0b111) {
-                frac_shl(p, fmt->frac_shift);
+                fracN(shl)(p, fmt->frac_shift);
                 p->cls = (parts_is_snan_frac(p->frac_hi, status)
                           ? float_class_snan : float_class_qnan);
                 return;
@@ -258,7 +258,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
 
     p->cls = float_class_normal;
     p->exp -= fmt->exp_bias;
-    frac_shl(p, fmt->frac_shift);
+    fracN(shl)(p, fmt->frac_shift);
     p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
 }
 
@@ -344,8 +344,8 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
     if (likely(exp > 0)) {
         if (p->frac_lo & round_mask) {
             flags |= float_flag_inexact;
-            if (frac_addi(p, p, inc)) {
-                frac_shr(p, 1);
+            if (fracN(addi)(p, p, inc)) {
+                fracN(shr)(p, 1);
                 p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
                 exp++;
             }
@@ -361,13 +361,13 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
                 } else if (overflow_norm) {
                     flags |= float_flag_inexact;
                     exp = exp_max - 1;
-                    frac_allones(p);
+                    fracN(allones)(p);
                     p->frac_lo &= ~round_mask;
                 } else {
                     flags |= float_flag_inexact;
                     p->cls = float_class_inf;
                     exp = exp_max;
-                    frac_clear(p);
+                    fracN(clear)(p);
                 }
                 break;
 
@@ -378,7 +378,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
                              ? float_flag_invalid
                              : float_flag_overflow | float_flag_inexact);
                     exp = exp_max;
-                    frac_allones(p);
+                    fracN(allones)(p);
                     p->frac_lo &= ~round_mask;
                 }
                 break;
@@ -395,26 +395,26 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
                 g_assert_not_reached();
             }
         }
-        frac_shr(p, frac_shift);
+        fracN(shr)(p, frac_shift);
     } else if (unlikely(s->rebias_underflow)) {
         flags |= float_flag_underflow;
         exp += fmt->exp_re_bias;
         if (p->frac_lo & round_mask) {
             flags |= float_flag_inexact;
-            if (frac_addi(p, p, inc)) {
-                frac_shr(p, 1);
+            if (fracN(addi)(p, p, inc)) {
+                fracN(shr)(p, 1);
                 p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
                 exp++;
             }
             p->frac_lo &= ~round_mask;
         }
-        frac_shr(p, frac_shift);
+        fracN(shr)(p, frac_shift);
     } else if (s->flush_to_zero &&
                s->ftz_detection == float_ftz_before_rounding) {
         flags |= float_flag_output_denormal_flushed;
         p->cls = float_class_zero;
         exp = 0;
-        frac_clear(p);
+        fracN(clear)(p);
     } else {
         bool is_tiny = s->tininess_before_rounding || exp < 0;
         bool has_pseudo_denormals = fmt->has_explicit_bit &&
@@ -422,10 +422,10 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
 
         if (!is_tiny) {
             FloatPartsN discard;
-            is_tiny = !frac_addi(&discard, p, inc);
+            is_tiny = !fracN(addi)(&discard, p, inc);
         }
 
-        frac_shrjam(p, !has_pseudo_denormals - exp);
+        fracN(shrjam)(p, !has_pseudo_denormals - exp);
 
         if (p->frac_lo & round_mask) {
             /* Need to recompute round-to-even/round-to-odd. */
@@ -452,12 +452,12 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
                 break;
             }
             flags |= float_flag_inexact;
-            frac_addi(p, p, inc);
+            fracN(addi)(p, p, inc);
             p->frac_lo &= ~round_mask;
         }
 
         exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) && !has_pseudo_denormals;
-        frac_shr(p, frac_shift);
+        fracN(shr)(p, frac_shift);
 
         if (is_tiny) {
             if (s->flush_to_zero) {
@@ -465,11 +465,11 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
                 flags |= float_flag_output_denormal_flushed;
                 p->cls = float_class_zero;
                 exp = 0;
-                frac_clear(p);
+                fracN(clear)(p);
             } else if (flags & float_flag_inexact) {
                 flags |= float_flag_underflow;
             }
-            if (exp == 0 && frac_eqz(p)) {
+            if (exp == 0 && fracN(eqz)(p)) {
                 p->cls = float_class_zero;
             }
         }
@@ -487,17 +487,17 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
         switch (p->cls) {
         case float_class_zero:
             p->exp = 0;
-            frac_clear(p);
+            fracN(clear)(p);
             return;
         case float_class_inf:
             switch (fmt->exp_max_kind) {
             case float_expmax_ieee:
                 p->exp = fmt->exp_max;
-                frac_clear(p);
+                fracN(clear)(p);
                 break;
             case float_expmax_e4m3:
                 partsN(uncanon_e4m3_overflow)(p, s, fmt, saturate);
-                frac_shr(p, fmt->frac_shift);
+                fracN(shr)(p, fmt->frac_shift);
                 break;
             case float_expmax_normal:
             default:
@@ -508,7 +508,7 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
         case float_class_snan:
             assert(fmt->exp_max_kind != float_expmax_normal);
             p->exp = fmt->exp_max;
-            frac_shr(p, fmt->frac_shift);
+            fracN(shr)(p, fmt->frac_shift);
             return;
         default:
             break;
@@ -625,12 +625,12 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
             float_raise(float_flag_input_denormal_used, s);
         }
 
-        frac_mulw(&tmp, a, b);
-        frac_truncjam(a, &tmp);
+        fracN(mulw)(&tmp, a, b);
+        fracN(truncjam)(a, &tmp);
 
         a->exp += b->exp + 1;
         if (!(a->frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
-            frac_add(a, a, a);
+            fracN(add)(a, a, a);
             a->exp -= 1;
         }
 
@@ -747,16 +747,16 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
     /* Perform the multiplication step. */
     p_widen.sign = a->sign;
     p_widen.exp = a->exp + b->exp + 1;
-    frac_mulw(&p_widen, a, b);
+    fracN(mulw)(&p_widen, a, b);
     if (!(p_widen.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
-        frac_add(&p_widen, &p_widen, &p_widen);
+        fracW(add)(&p_widen, &p_widen, &p_widen);
         p_widen.exp -= 1;
     }
 
     /* Perform the addition step. */
     if (c->cls != float_class_zero) {
         /* Zero-extend C to less significant bits. */
-        frac_widen(&c_widen, c);
+        fracN(widen)(&c_widen, c);
         c_widen.exp = c->exp;
 
         if (a->sign == c->sign) {
@@ -767,7 +767,7 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
     }
 
     /* Narrow with sticky bit, for proper rounding later. */
-    frac_truncjam(a, &p_widen);
+    fracN(truncjam)(a, &p_widen);
     a->sign = p_widen.sign;
     a->exp = p_widen.exp;
 
@@ -816,7 +816,7 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
             float_raise(float_flag_input_denormal_used, s);
         }
         a->sign = sign;
-        a->exp -= b->exp + frac_div(a, b);
+        a->exp -= b->exp + fracN(div)(a, b);
         return a;
     }
 
@@ -880,7 +880,7 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
         if (ab_mask & float_cmask_denormal) {
             float_raise(float_flag_input_denormal_used, s);
         }
-        frac_modrem(a, b, mod_quot);
+        fracN(modrem)(a, b, mod_quot);
         return a;
     }
 
@@ -969,7 +969,7 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
     exp_odd = a->exp & 1;
     index = extract64(a->frac_hi, 57, 6) | (!exp_odd << 6);
     if (!exp_odd) {
-        frac_shr(a, 1);
+        fracN(shr)(a, 1);
     }
 
     /*
@@ -1110,7 +1110,7 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
     /* Convert back from base 4 to base 2. */
     a->exp >>= 1;
     if (!(a->frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
-        frac_add(a, a, a);
+        fracN(add)(a, a, a);
     } else {
         a->exp += 1;
     }
@@ -1150,9 +1150,9 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
             if (a->exp == -1) {
                 FloatPartsN tmp;
                 /* Shift left one, discarding DECOMPOSED_IMPLICIT_BIT */
-                frac_add(&tmp, a, a);
+                fracN(add)(&tmp, a, a);
                 /* Anything remaining means frac > 0.5. */
-                one = !frac_eqz(&tmp);
+                one = !fracN(eqz)(&tmp);
             }
             break;
         case float_round_ties_away:
@@ -1174,7 +1174,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
             g_assert_not_reached();
         }
 
-        frac_clear(a);
+        fracN(clear)(a);
         a->exp = 0;
         if (one) {
             a->frac_hi = DECOMPOSED_IMPLICIT_BIT;
@@ -1190,7 +1190,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
          * which leaves room for sticky and rounding bit.
          */
         shift_adj = (N - 1) - (a->exp + 2);
-        frac_shrjam(a, shift_adj);
+        fracN(shrjam)(a, shift_adj);
         frac_lsb = 1 << 2;
     } else {
         /*
@@ -1208,7 +1208,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
 
     if (!(a->frac_lo & rnd_mask)) {
         /* Fractional bits already clear, undo the shift above. */
-        frac_shl(a, shift_adj);
+        fracN(shl)(a, shift_adj);
         return false;
     }
 
@@ -1236,21 +1236,21 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
     }
 
     if (shift_adj == 0) {
-        if (frac_addi(a, a, inc)) {
-            frac_shr(a, 1);
+        if (fracN(addi)(a, a, inc)) {
+            fracN(shr)(a, 1);
             a->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
             a->exp++;
         }
         a->frac_lo &= ~rnd_mask;
     } else {
-        frac_addi(a, a, inc);
+        fracN(addi)(a, a, inc);
         a->frac_lo &= ~rnd_mask;
         /* Be careful shifting back, not to overflow */
-        frac_shl(a, shift_adj - 1);
+        fracN(shl)(a, shift_adj - 1);
         if (a->frac_hi & DECOMPOSED_IMPLICIT_BIT) {
             a->exp++;
         } else {
-            frac_add(a, a, a);
+            fracN(add)(a, a, a);
         }
     }
     return true;
@@ -1555,7 +1555,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
     /* Compare magnitudes. */
     cmp = a_exp - b_exp;
     if (cmp == 0) {
-        cmp = frac_cmp(a, b);
+        cmp = fracN(cmp)(a, b);
     }
 
     /*
@@ -1597,7 +1597,7 @@ static FloatRelation partsN(compare)(FloatPartsN *a, FloatPartsN *b,
             goto a_sign;
         }
         if (a->exp == b->exp) {
-            cmp = frac_cmp(a, b);
+            cmp = fracN(cmp)(a, b);
         } else if (a->exp < b->exp) {
             cmp = float_relation_less;
         } else {
-- 
2.43.0


