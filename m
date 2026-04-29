Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E8AFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDL8-0008Qd-F0; Wed, 29 Apr 2026 18:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDL7-0008Pa-AY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:05 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDL5-0004WE-2i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:05 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35f9ab079bdso151024a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501501; x=1778106301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOWl6dlDmgt5ra+q6IWGJDwLcPjORpV6em0GCLoKPF4=;
 b=v65gqvvr8RdXVZ7bV9nxk6gijiKk/2VxyOm9oPughKNCCaYDJYXnfElrro38FZ2XsA
 htKgYU8pt0HBZNzjMu8pEmumIMTKx1SoobgRO9NGWAzST/mCIPdfwQtQQ34fh2te6DQQ
 mZhOq0gXEg4nUWoiwFE1fWcurxcF23M8I7CVX5X3NkULnV/M0WgCwS5U0JAsDAdhjK5u
 nW4LIBGbwlztqFcDff6FEPzw1HtDki3EIuHPOfUo8rN5XbL9oca3acv/8QBiGAP5N6gu
 BbCzuUhexvgugmFnfFosATbDW//kUXY0MdUzzEa/244jfjNC/4nfHIme1Sa5zcLXqT7S
 wu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501501; x=1778106301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wOWl6dlDmgt5ra+q6IWGJDwLcPjORpV6em0GCLoKPF4=;
 b=BNKMVzDi1a8b3VJTKnu+qJQRF0ypzxtf6Hu/InWN4TUP5cQufrBfNkBthi1SHiY1qO
 kY0RnLGnx9UTdjcRGZE3xeNiP9trFUvxCVbk/7tTnzVOU7bYvS9xYvExDcrQxu6wt9Tw
 2gPAXB7VUrz8+/wZw5/xAG/nfPqS+4PGRGc+yapGrR3yQZWXEsYYUzUUCU+LXU/X9lRe
 alqnLcp83GgJ7BjAuPU2N6/w7UDK8gR/OEw4TGRczLs9s/WZIJKAJ+Z+nq4wMXs8xzpW
 m32kqxXX1RBqFvHUKbLsHBiO/JTgXTrdMF5lONn+YuiKxKhU2BHR1undSjvWWchbaqNb
 5/Hg==
X-Gm-Message-State: AOJu0Yzd8xTqeMB7+o0100TpAxABLCI8H2RDVmIGfYRYjsJVjsiWW0kT
 F63x8xkGj/5r8yPITrskywuZkLhSVPnsj/nQ0z/VOz/iUSqZ7oawa5s9r2fhXwgnZui97Z6ev8v
 mNt2lHC8=
X-Gm-Gg: AeBDietgKsgfPPhHSQwah5UODlrKUAJby4S7bfezTJGA0gA3fSLtRFmhXop0Qm+hxRI
 jvyD0dIXJKFDzEQTkljblydRESeKHalBZqE8hPHqq8GMWRvBtf3343/RZX5KnV/Pmws4K4CC3m+
 gV3DI3ez7xBRiptESpYBeg06+P1Dupa5KJY0TAniEmxily0vsHygwagJbnoqwyFcxmV+9gYB7w6
 h+vzTfycK1PE57TTJDMdoWFPTMJKGmq+bW8AGzxrGyCS5732l804/PXQkr+isDhhWQUunSi1You
 eRwZ4LBmU7SmCr5UoPSiy3NhYTksNjaEEsI9n8aQXYAjseLhyHCrK1nUZWeKRDqPIvcAKdXn8Q8
 Tp11x6oOueR4AzdUS8ORkZ0x+n94JrOdZD1/RhekBeWyRstQzCTv6S6yIO+Jpo5YRd8FkSOIqe7
 WFfJ4vKMPJQfC2oHmVUxUIteUSILbKL+Dte0W6biuZ
X-Received: by 2002:a17:90b:4cc4:b0:35f:b6a1:8d23 with SMTP id
 98e67ed59e1d1-364c2f8c804mr193055a91.11.1777501501515; 
 Wed, 29 Apr 2026 15:25:01 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/48] fpu: Drop parts_default_nan
Date: Thu, 30 Apr 2026 08:24:01 +1000
Message-ID: <20260429222445.26301-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Use parts{64,128}_default_nan at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 23 +++++++++++------------
 fpu/softfloat-parts.c.inc | 24 ++++++++++++------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 4876a8bb27..76c1d4e38a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,7 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-#define parts_default_nan(P, S)    PARTS_GENERIC_64_128(default_nan, P)(P, S)
 #define parts_silence_nan(P, S)    PARTS_GENERIC_64_128(silence_nan, P)(P, S)
 
 static void parts64_return_nan(FloatParts64 *a, float_status *s);
@@ -3156,7 +3155,7 @@ float32 floatx80_to_float32(floatx80 a, float_status *s)
     if (floatx80_unpack_canonical(&p128, a, s)) {
         parts_float_to_float_narrow(&p64, &p128, s);
     } else {
-        parts_default_nan(&p64, s);
+        parts64_default_nan(&p64, s);
     }
     return float32_round_pack_canonical(&p64, s);
 }
@@ -3169,7 +3168,7 @@ float64 floatx80_to_float64(floatx80 a, float_status *s)
     if (floatx80_unpack_canonical(&p128, a, s)) {
         parts_float_to_float_narrow(&p64, &p128, s);
     } else {
-        parts_default_nan(&p64, s);
+        parts64_default_nan(&p64, s);
     }
     return float64_round_pack_canonical(&p64, s);
 }
@@ -3181,7 +3180,7 @@ float128 floatx80_to_float128(floatx80 a, float_status *s)
     if (floatx80_unpack_canonical(&p, a, s)) {
         parts_float_to_float(&p, s);
     } else {
-        parts_default_nan(&p, s);
+        parts128_default_nan(&p, s);
     }
     return float128_round_pack_canonical(&p, s);
 }
@@ -3486,7 +3485,7 @@ static int32_t floatx80_to_int32_scalbn(floatx80 a, FloatRoundMode rmode,
     FloatParts128 p;
 
     if (!floatx80_unpack_canonical(&p, a, s)) {
-        parts_default_nan(&p, s);
+        parts128_default_nan(&p, s);
     }
     return parts_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
@@ -3497,7 +3496,7 @@ static int64_t floatx80_to_int64_scalbn(floatx80 a, FloatRoundMode rmode,
     FloatParts128 p;
 
     if (!floatx80_unpack_canonical(&p, a, s)) {
-        parts_default_nan(&p, s);
+        parts128_default_nan(&p, s);
     }
     return parts_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
@@ -4984,7 +4983,7 @@ float16 float16_default_nan(float_status *status)
 {
     FloatParts64 p;
 
-    parts_default_nan(&p, status);
+    parts64_default_nan(&p, status);
     p.frac >>= float16_params.frac_shift;
     return float16_pack_raw(&p);
 }
@@ -4993,7 +4992,7 @@ float32 float32_default_nan(float_status *status)
 {
     FloatParts64 p;
 
-    parts_default_nan(&p, status);
+    parts64_default_nan(&p, status);
     p.frac >>= float32_params.frac_shift;
     return float32_pack_raw(&p);
 }
@@ -5002,7 +5001,7 @@ float64 float64_default_nan(float_status *status)
 {
     FloatParts64 p;
 
-    parts_default_nan(&p, status);
+    parts64_default_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
     return float64_pack_raw(&p);
 }
@@ -5011,7 +5010,7 @@ float128 float128_default_nan(float_status *status)
 {
     FloatParts128 p;
 
-    parts_default_nan(&p, status);
+    parts128_default_nan(&p, status);
     frac_shr(&p, float128_params.frac_shift);
     return float128_pack_raw(&p);
 }
@@ -5020,7 +5019,7 @@ bfloat16 bfloat16_default_nan(float_status *status)
 {
     FloatParts64 p;
 
-    parts_default_nan(&p, status);
+    parts64_default_nan(&p, status);
     p.frac >>= bfloat16_params.frac_shift;
     return bfloat16_pack_raw(&p);
 }
@@ -5537,7 +5536,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         *n = *r;
         *cc = 1;
     } else if (a->cls == float_class_inf || b->cls == float_class_zero) {
-        parts_default_nan(r, status);
+        parts64_default_nan(r, status);
         *n = *r;
         *cc = 1;
         status->float_exception_flags |= float_flag_invalid;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 948eb7bd6a..37ce731101 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -21,14 +21,14 @@ static void partsN(return_nan)(FloatPartsN *a, float_status *s)
     case float_class_snan:
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
         if (s->default_nan_mode) {
-            parts_default_nan(a, s);
+            partsN(default_nan)(a, s);
         } else {
             parts_silence_nan(a, s);
         }
         break;
     case float_class_qnan:
         if (s->default_nan_mode) {
-            parts_default_nan(a, s);
+            partsN(default_nan)(a, s);
         }
         break;
     default:
@@ -49,7 +49,7 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (s->default_nan_mode) {
-        parts_default_nan(a, s);
+        partsN(default_nan)(a, s);
         return a;
     }
 
@@ -184,7 +184,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     return ret;
 
  default_nan:
-    parts_default_nan(a, s);
+    partsN(default_nan)(a, s);
     return a;
 }
 
@@ -281,7 +281,7 @@ static void partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
         p->exp = fmt->exp_max;
         p->frac_hi = E4M3_NORMAL_FRAC_MAX;
     } else {
-        parts_default_nan(p, s);
+        partsN(default_nan)(p, s);
     }
 }
 
@@ -568,7 +568,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
             }
             /* Inf - Inf */
             float_raise(float_flag_invalid | float_flag_invalid_isi, s);
-            parts_default_nan(a, s);
+            partsN(default_nan)(a, s);
             return a;
         }
     } else {
@@ -641,7 +641,7 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     /* Inf * Zero == NaN */
     if (unlikely(ab_mask == float_cmask_infzero)) {
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
-        parts_default_nan(a, s);
+        partsN(default_nan)(a, s);
         return a;
     }
 
@@ -796,7 +796,7 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
     goto finish_sign;
 
  d_nan:
-    parts_default_nan(a, s);
+    partsN(default_nan)(a, s);
     return a;
 }
 
@@ -864,7 +864,7 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
     return a;
 
  d_nan:
-    parts_default_nan(a, s);
+    partsN(default_nan)(a, s);
     return a;
 }
 
@@ -896,7 +896,7 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
     /* Inf % N; N % 0 */
     if (a->cls == float_class_inf || b->cls == float_class_zero) {
         float_raise(float_flag_invalid, s);
-        parts_default_nan(a, s);
+        partsN(default_nan)(a, s);
         return a;
     }
 
@@ -1118,7 +1118,7 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
 
  d_nan:
     float_raise(float_flag_invalid | float_flag_invalid_sqrt, status);
-    parts_default_nan(a, status);
+    partsN(default_nan)(a, status);
 }
 
 /*
@@ -1879,5 +1879,5 @@ static void partsN(log2)(FloatPartsN *a, float_status *s, const FloatFmt *fmt)
 
  d_nan:
     float_raise(float_flag_invalid, s);
-    parts_default_nan(a, s);
+    partsN(default_nan)(a, s);
 }
-- 
2.43.0


