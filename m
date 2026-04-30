Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF57FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEun-0006Vm-5s; Wed, 29 Apr 2026 20:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEul-0006Sr-VR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:00 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuk-0001lx-07
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:59 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so324369b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507556; x=1778112356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnxSC/joRQiFHOM0JVKPwA6B6Eb0DecPwNp7R0mi00U=;
 b=ULTka1rlgHIcVPPgcDa1WoVHm6R7pwK9pCYh9FJq3rzL+mo6XUBJL8rRafNStC5ejv
 Xsurgb0x81ainz5saSXZsFpAsUSfiLSMR5S/hNy4abn79zrroeCCR6icEFF8ZVJR4a8V
 pt2K/MqeIG0xzkPTtF64I/oAwNphGusX9C7B4S7frdLxHpf3FKZBIxHsm2pluCWPNig5
 IHU5X4caR4hj6qVy+uhIvZFFoc+m+xYwVMxpE7zFSHJD5kSkNXcAGHlrqSbQNGwl06cQ
 kk7j804OUcF3DMiHzPCVExQtzH84NMCN5DCdqGbRXOfvkOJNuCRIgv2+Zczwa4UqZDWi
 zQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507556; x=1778112356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TnxSC/joRQiFHOM0JVKPwA6B6Eb0DecPwNp7R0mi00U=;
 b=NJilWhyRliZZ9L9tlAXu1gteCeFgjhyK+N89BNdNm195fYkDmC4Wx6dSop3+YU+FMU
 Fr2s3AWHdaXsX0WlaJQhnDnaXzRJEV1r/g6XgKRFkFHwR1OvtwDiDtlJQOkqZzGTCJvj
 IQCeSLizTI00qmBxRA42bTjAamTTUusHLSMM7dVlUOULV+uRkt/jn08SY7fPHN8PoCX9
 P29hoLVOE5LVaH95MGdwXrAIlJLQXb+eynujy0Em++z0SL2bPFICJ3DesazG+5NnTRL8
 GBe15xkNJCE/3W2qqJxYc0bj/DkfZQwBNJB+QEkKi3A6VFNjPw4SNUuuNau1lk/UojIQ
 xmdQ==
X-Gm-Message-State: AOJu0Yx9tXVDbNzSAwK8jvWtNq6FRWlzHRkft/HV26PduqVw0U1H0+SW
 mgW/jJyf8WMhN61qjIQnYwMjcV8ffvHjwnzo7Q2dUI18FaRzM1+1Lx+BIFofo7ECis/LTYRp3Xn
 JtFToaQs=
X-Gm-Gg: AeBDiesYmpqNMtC4oIK00kw2J9GaXjQXwaNE1HHoSo6RIaUthMV7DgdBDGWte7JQT3j
 TG/3ia9fm7siUbamgosOOuFphds9VUzEO6b0hSvD2fzcy8UPhb14KClxc6RN4+Q0hwMyboVt4Gj
 UZ0quqxAfD7doa9ebfT8OZ6KI2BuqUj5D9X8CJYw6neFg5xUGzwQ/m0TBLrtCIOTMiCr2qz/yCS
 6Z4tjh8bbFTjbj1AUoyfSzsg6LZHd5w4n++Ug0OXca7D62anOMFLuC0t+Ftw45XalhV9CLnwo0x
 zHgbhk69KraugNIP5CTJW57EBFA3WbjkCqxIK1h+Q/GOLnkvseJUIYZgb42OtGWWb+5ZpfhCjup
 ZSkHClWNQEeqimBDHGpGqDKiBz1wHIHQS+HFFrmZ1pnCb3IqvJn45BtKZr4fTCbngtg39EDSs9v
 WjDAAzKCcSs121ulZT12butc17BtjwzGq4x48BMECh
X-Received: by 2002:aa7:88c8:0:b0:82f:2243:e445 with SMTP id
 d2e1a72fcca58-834fdbe6804mr797395b3a.32.1777507556414; 
 Wed, 29 Apr 2026 17:05:56 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 12/40] fpu: Return struct from parts{64,128}_default_nan
Date: Thu, 30 Apr 2026 10:04:55 +1000
Message-ID: <20260430000524.56046-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 fpu/softfloat.c                | 29 ++++++++++++-----------------
 fpu/softfloat-parts.c.inc      | 22 +++++++++++-----------
 fpu/softfloat-specialize.c.inc | 22 ++++++++++------------
 3 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b857c13d91..fa8913a288 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2678,7 +2678,7 @@ float32 floatx80_to_float32(floatx80 a, float_status *s)
     if (floatx80_unpack_canonical(&p128, a, s)) {
         p64 = parts128_to_parts64(&p128, s);
     } else {
-        parts64_default_nan(&p64, s);
+        p64 = parts64_default_nan(s);
     }
     return float32_round_pack_canonical(&p64, s);
 }
@@ -2691,7 +2691,7 @@ float64 floatx80_to_float64(floatx80 a, float_status *s)
     if (floatx80_unpack_canonical(&p128, a, s)) {
         p64 = parts128_to_parts64(&p128, s);
     } else {
-        parts64_default_nan(&p64, s);
+        p64 = parts64_default_nan(s);
     }
     return float64_round_pack_canonical(&p64, s);
 }
@@ -2703,7 +2703,7 @@ float128 floatx80_to_float128(floatx80 a, float_status *s)
     if (floatx80_unpack_canonical(&p, a, s)) {
         parts128_float_to_float(&p, s);
     } else {
-        parts128_default_nan(&p, s);
+        p = parts128_default_nan(s);
     }
     return float128_round_pack_canonical(&p, s);
 }
@@ -2964,7 +2964,7 @@ static int32_t floatx80_to_int32_scalbn(floatx80 a, FloatRoundMode rmode,
     FloatParts128 p;
 
     if (!floatx80_unpack_canonical(&p, a, s)) {
-        parts128_default_nan(&p, s);
+        p = parts128_default_nan(s);
     }
     return parts128_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
@@ -2975,7 +2975,7 @@ static int64_t floatx80_to_int64_scalbn(floatx80 a, FloatRoundMode rmode,
     FloatParts128 p;
 
     if (!floatx80_unpack_canonical(&p, a, s)) {
-        parts128_default_nan(&p, s);
+        p = parts128_default_nan(s);
     }
     return parts128_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
@@ -4562,7 +4562,7 @@ static void parts64_log2(FloatParts64 *a, float_status *s, const FloatFmt *fmt)
 
  d_nan:
     float_raise(float_flag_invalid, s);
-    parts64_default_nan(a, s);
+    *a = parts64_default_nan(s);
 }
 
 float32 float32_log2(float32 a, float_status *status)
@@ -4587,45 +4587,40 @@ float64 float64_log2(float64 a, float_status *status)
 
 float16 float16_default_nan(float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = parts64_default_nan(status);
 
-    parts64_default_nan(&p, status);
     p.frac >>= float16_params.frac_shift;
     return pack_raw64(&p, &float16_params);
 }
 
 float32 float32_default_nan(float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = parts64_default_nan(status);
 
-    parts64_default_nan(&p, status);
     p.frac >>= float32_params.frac_shift;
     return pack_raw64(&p, &float32_params);
 }
 
 float64 float64_default_nan(float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = parts64_default_nan(status);
 
-    parts64_default_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
     return pack_raw64(&p, &float64_params);
 }
 
 float128 float128_default_nan(float_status *status)
 {
-    FloatParts128 p;
+    FloatParts128 p = parts128_default_nan(status);
 
-    parts128_default_nan(&p, status);
     frac128_shr(&p, float128_params.frac_shift);
     return float128_pack_raw(&p);
 }
 
 bfloat16 bfloat16_default_nan(float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = parts64_default_nan(status);
 
-    parts64_default_nan(&p, status);
     p.frac >>= bfloat16_params.frac_shift;
     return pack_raw64(&p, &bfloat16_params);
 }
@@ -5131,7 +5126,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         *n = *r;
         *cc = 1;
     } else if (a->cls == float_class_inf || b->cls == float_class_zero) {
-        parts64_default_nan(r, status);
+        *r = parts64_default_nan(status);
         *n = *r;
         *cc = 1;
         status->float_exception_flags |= float_flag_invalid;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5d344f9afe..ed7080d886 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -21,14 +21,14 @@ static void partsN(return_nan)(FloatPartsN *a, float_status *s)
     case float_class_snan:
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
         if (s->default_nan_mode) {
-            partsN(default_nan)(a, s);
+            *a = partsN(default_nan)(s);
         } else {
             partsN(silence_nan)(a, s);
         }
         break;
     case float_class_qnan:
         if (s->default_nan_mode) {
-            partsN(default_nan)(a, s);
+            *a = partsN(default_nan)(s);
         }
         break;
     default:
@@ -49,7 +49,7 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (s->default_nan_mode) {
-        partsN(default_nan)(a, s);
+        *a = partsN(default_nan)(s);
         return a;
     }
 
@@ -184,7 +184,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     return ret;
 
  default_nan:
-    partsN(default_nan)(a, s);
+    *a = partsN(default_nan)(s);
     return a;
 }
 
@@ -281,7 +281,7 @@ static void partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
         p->exp = fmt->exp_max;
         p->frac_hi = E4M3_NORMAL_FRAC_MAX;
     } else {
-        partsN(default_nan)(p, s);
+        *p = partsN(default_nan)(s);
     }
 }
 
@@ -568,7 +568,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
             }
             /* Inf - Inf */
             float_raise(float_flag_invalid | float_flag_invalid_isi, s);
-            partsN(default_nan)(a, s);
+            *a = partsN(default_nan)(s);
             return a;
         }
     } else {
@@ -641,7 +641,7 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     /* Inf * Zero == NaN */
     if (unlikely(ab_mask == float_cmask_infzero)) {
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
-        partsN(default_nan)(a, s);
+        *a = partsN(default_nan)(s);
         return a;
     }
 
@@ -796,7 +796,7 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
     goto finish_sign;
 
  d_nan:
-    partsN(default_nan)(a, s);
+    *a = partsN(default_nan)(s);
     return a;
 }
 
@@ -864,7 +864,7 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
     return a;
 
  d_nan:
-    partsN(default_nan)(a, s);
+    *a = partsN(default_nan)(s);
     return a;
 }
 
@@ -896,7 +896,7 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
     /* Inf % N; N % 0 */
     if (a->cls == float_class_inf || b->cls == float_class_zero) {
         float_raise(float_flag_invalid, s);
-        partsN(default_nan)(a, s);
+        *a = partsN(default_nan)(s);
         return a;
     }
 
@@ -1118,7 +1118,7 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
 
  d_nan:
     float_raise(float_flag_invalid | float_flag_invalid_sqrt, status);
-    partsN(default_nan)(a, status);
+    *a = partsN(default_nan)(status);
 }
 
 /*
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 9ed968c79b..dd65432813 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -118,7 +118,7 @@ static bool parts_is_snan_frac(uint64_t frac, float_status *status)
 | The pattern for a default generated deconstructed floating-point NaN.
 *----------------------------------------------------------------------------*/
 
-static void parts64_default_nan(FloatParts64 *p, float_status *status)
+static FloatParts64 parts64_default_nan(float_status *status)
 {
     bool sign = 0;
     uint64_t frac;
@@ -134,7 +134,7 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     frac = deposit64(0, DECOMPOSED_BINARY_POINT - 7, 7, dnan_pattern);
     frac = deposit64(frac, 0, DECOMPOSED_BINARY_POINT - 7, -(dnan_pattern & 1));
 
-    *p = (FloatParts64) {
+    return (FloatParts64) {
         .cls = float_class_qnan,
         .sign = sign,
         .exp = INT_MAX,
@@ -142,17 +142,16 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     };
 }
 
-static void parts128_default_nan(FloatParts128 *p, float_status *status)
+static FloatParts128 parts128_default_nan(float_status *status)
 {
     /*
      * Extrapolate from the choices made by parts64_default_nan to fill
      * in the quad-floating format.  If the low bit is set, assume we
      * want to set all non-snan bits.
      */
-    FloatParts64 p64;
-    parts64_default_nan(&p64, status);
+    FloatParts64 p64 = parts64_default_nan(status);
 
-    *p = (FloatParts128) {
+    return (FloatParts128) {
         .cls = float_class_qnan,
         .sign = p64.sign,
         .exp = INT_MAX,
@@ -197,19 +196,18 @@ static void parts128_silence_nan(FloatParts128 *p, float_status *status)
 *----------------------------------------------------------------------------*/
 floatx80 floatx80_default_nan(float_status *status)
 {
-    floatx80 r;
     /*
      * Extrapolate from the choices made by parts64_default_nan to fill
      * in the floatx80 format. We assume that floatx80's explicit
      * integer bit is always set (this is true for i386 and m68k,
      * which are the only real users of this format).
      */
-    FloatParts64 p64;
-    parts64_default_nan(&p64, status);
+    FloatParts64 p64 = parts64_default_nan(status);
 
-    r.high = 0x7FFF | (p64.sign << 15);
-    r.low = (1ULL << DECOMPOSED_BINARY_POINT) | p64.frac;
-    return r;
+    return (floatx80) {
+        .high = 0x7FFF | (p64.sign << 15),
+        .low = (1ULL << DECOMPOSED_BINARY_POINT) | p64.frac,
+    };
 }
 
 /*----------------------------------------------------------------------------
-- 
2.43.0


