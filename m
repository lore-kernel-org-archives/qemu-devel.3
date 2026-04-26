Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10136FF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzis-0006w3-9p; Sun, 26 Apr 2026 09:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzie-0006qY-6v
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:20 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzia-0008Fs-Pu
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:19 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so41654215ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210814; x=1777815614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jIspN7Eqx+KKzfnFI2Tg1oMhKcfN1oaYCYjnDfppv8=;
 b=cGkoZjkkewP78dNyhMh/9+FicRJlOqtY2l0cqD8Pg2MbImOvyVwC2ABO9LK4GbN7G4
 1K7ZxiOnRasUt4moJnj4lCI+AJ6PxuT+bo7o3pOgmbCzzAvBri4a/LxRWnVzl265E/Qb
 xW6VmP3xX2LM5OoZJ/EFi8cvJGzY8jVGanqMy5LB3M96JqXJiniDEbbiKcmgQ7YuMzRC
 rVEYxCeJAhM9qIQCuR6WWA2I4S4U//u22U53Fz4qzwaJXnJaft4Y4ktdHz2VsEnUhLGO
 jfJrFyMPTgCBo3wQHL80D+4EKvtzllYtWe1xJHDx9jyPImXMKvymnh+1TJjeUYIpuqJY
 AOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210814; x=1777815614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2jIspN7Eqx+KKzfnFI2Tg1oMhKcfN1oaYCYjnDfppv8=;
 b=FWBaa0i7mSa9WgXqXHdGfoMuP7+C9qo0rLTDZZeX2+bKSY0w3nJV2SwtEkjFJbEekJ
 +8SvQalYE/29X83coSi3/Hj3RyAt87IdcXH5/l9ptAjVoSX6iffkLEZEoDAW/u+zvPWi
 ZKBJCHD67pUI8be/g3XgCBgp3PhXn+BLZHO9Mo2O8x+lfscPVKVxc9XTeQcK8a8MtfuX
 VhB1i8Cc/KuUdQYLpsQE2cugl9fi8hu3JqmD4PjzIUeX0Ls2tL56MYwnNw7PNFo1MRc7
 HJr8QnYZt5Gc+YPzFS3Rdz6vIZh1GY85zCCoQRzpX3CXecPzHa0+iWrXwSAlnLJ9acSR
 6zTA==
X-Gm-Message-State: AOJu0YwpjBO7PgvKhAxsd3nEBukI+wy0afj0osnCX0XkvC3jTWH3R1vw
 QD+5rBw7Em4X9fCRuT+3XMcwdSNXUAy5HlQ41NE0fe9Upe+Bua87zP0FUrJiUZHs9monsbWLCo2
 JUMClnUA=
X-Gm-Gg: AeBDietKJgmrL5lbwmcazDdqVDuB4fNSAn3Aywl65Boa6SdFW1eMfRxJRRr+IGeVWjA
 38cIGMlzvrOIA4tJwFOdDjMpUepcjX3ynOjFxPKhClmp3tkye6aRE7e6uE6f4RPS7lOC4xrnnsc
 2yBXYlCsh5s0LpGC6NXan7dlQdQxV01+fpD1uvSvMZYHwsG3ak6y22sJxjTSSS7lor8Wbjp0wDB
 qCA9CkxLbLktxZNmp/1gsAbpS500jxyTqkxCZM647BRF8AJpgSyauW98xSZXEy+meGU2zXKhiVo
 4p1wt79NIk9XLC5BNs0vvnaFrLV3OrqOyK40KaYEp9hpRvZJlemWSU2ZdRVHzzq8xcigshVbbww
 6hZfpXTUiejOkqvh2MW3Cdh5NCOiNmArEQxDXh0mmiMQAmPL7bz4JbSnX79rV2TjZHws5l0D71Q
 8Twlx49qS5+ESb+0WwpKZowoDNpJ8gsCitiZlySZKP
X-Received: by 2002:a17:903:3905:b0:2b0:7e4d:f43f with SMTP id
 d9443c01a7336-2b5f9ffe73amr379940045ad.41.1777210814005; 
 Sun, 26 Apr 2026 06:40:14 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 02/84] fpu: Drop parts_uncanon
Date: Sun, 26 Apr 2026 23:38:39 +1000
Message-ID: <20260426134002.865628-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Use parts{64,128}_uncanon at each call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f9997f5236..7c13a7848e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -814,14 +814,6 @@ static void parts128_uncanon_normal(FloatParts128 *p, float_status *status,
 #define parts_uncanon_normal(A, S, F, X) \
     PARTS_GENERIC_64_128(uncanon_normal, A)(A, S, F, X)
 
-static void parts64_uncanon(FloatParts64 *p, float_status *status,
-                            const FloatFmt *fmt, bool saturate);
-static void parts128_uncanon(FloatParts128 *p, float_status *status,
-                             const FloatFmt *fmt, bool saturate);
-
-#define parts_uncanon(A, S, F, X) \
-    PARTS_GENERIC_64_128(uncanon, A)(A, S, F, X)
-
 static void parts64_add_normal(FloatParts64 *a, FloatParts64 *b);
 static void parts128_add_normal(FloatParts128 *a, FloatParts128 *b);
 static void parts256_add_normal(FloatParts256 *a, FloatParts256 *b);
@@ -1756,7 +1748,7 @@ static float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p,
                                                     float_status *s,
                                                     bool saturate)
 {
-    parts_uncanon(p, s, &float8_e4m3_params, saturate);
+    parts64_uncanon(p, s, &float8_e4m3_params, saturate);
     return float8_e4m3_pack_raw(p);
 }
 
@@ -1764,7 +1756,7 @@ static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
                                                     float_status *s,
                                                     bool saturate)
 {
-    parts_uncanon(p, s, &float8_e5m2_params, saturate);
+    parts64_uncanon(p, s, &float8_e5m2_params, saturate);
     return float8_e5m2_pack_raw(p);
 }
 
@@ -1772,7 +1764,7 @@ static float16 float16a_round_pack_canonical(FloatParts64 *p,
                                              float_status *s,
                                              const FloatFmt *params)
 {
-    parts_uncanon(p, s, params, false);
+    parts64_uncanon(p, s, params, false);
     return float16_pack_raw(p);
 }
 
@@ -1785,7 +1777,7 @@ static float16 float16_round_pack_canonical(FloatParts64 *p,
 static bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p,
                                               float_status *s)
 {
-    parts_uncanon(p, s, &bfloat16_params, false);
+    parts64_uncanon(p, s, &bfloat16_params, false);
     return bfloat16_pack_raw(p);
 }
 
@@ -1799,7 +1791,7 @@ static void float32_unpack_canonical(FloatParts64 *p, float32 f,
 static float32 float32_round_pack_canonical(FloatParts64 *p,
                                             float_status *s)
 {
-    parts_uncanon(p, s, &float32_params, false);
+    parts64_uncanon(p, s, &float32_params, false);
     return float32_pack_raw(p);
 }
 
@@ -1813,14 +1805,14 @@ static void float64_unpack_canonical(FloatParts64 *p, float64 f,
 static float64 float64_round_pack_canonical(FloatParts64 *p,
                                             float_status *s)
 {
-    parts_uncanon(p, s, &float64_params, false);
+    parts64_uncanon(p, s, &float64_params, false);
     return float64_pack_raw(p);
 }
 
 static float64 float64r32_pack_raw(FloatParts64 *p)
 {
     /*
-     * In parts_uncanon, we placed the fraction for float32 at the lsb.
+     * In parts64_uncanon, we placed the fraction for float32 at the lsb.
      * We need to adjust the fraction higher so that the least N bits are
      * zero, and the fraction is adjacent to the float64 implicit bit.
      */
@@ -1862,7 +1854,7 @@ static float64 float64r32_pack_raw(FloatParts64 *p)
 static float64 float64r32_round_pack_canonical(FloatParts64 *p,
                                                float_status *s)
 {
-    parts_uncanon(p, s, &float32_params, false);
+    parts64_uncanon(p, s, &float32_params, false);
     return float64r32_pack_raw(p);
 }
 
@@ -1876,7 +1868,7 @@ static void float128_unpack_canonical(FloatParts128 *p, float128 f,
 static float128 float128_round_pack_canonical(FloatParts128 *p,
                                               float_status *s)
 {
-    parts_uncanon(p, s, &float128_params, false);
+    parts128_uncanon(p, s, &float128_params, false);
     return float128_pack_raw(p);
 }
 
@@ -1924,7 +1916,7 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
     case float_class_normal:
     case float_class_denormal:
         if (s->floatx80_rounding_precision == floatx80_precision_x) {
-            parts_uncanon_normal(p, s, fmt, false);
+            parts128_uncanon_normal(p, s, fmt, false);
             frac = p->frac_hi;
             exp = p->exp;
         } else {
@@ -1933,7 +1925,7 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
             p64.sign = p->sign;
             p64.exp = p->exp;
             frac_truncjam(&p64, p);
-            parts_uncanon_normal(&p64, s, fmt, false);
+            parts64_uncanon_normal(&p64, s, fmt, false);
             frac = p64.frac;
             exp = p64.exp;
         }
@@ -2331,7 +2323,7 @@ float16_muladd_scalbn(float16 a, float16 b, float16 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &float16_params, false);
+    parts64_uncanon(pr, status, &float16_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -2356,7 +2348,7 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &float32_params, false);
+    parts64_uncanon(pr, status, &float32_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -2375,7 +2367,7 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &float64_params, false);
+    parts64_uncanon(pr, status, &float64_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -2534,7 +2526,7 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &float32_params, false);
+    parts64_uncanon(pr, status, &float32_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -2552,7 +2544,7 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &bfloat16_params, false);
+    parts64_uncanon(pr, status, &bfloat16_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -2570,7 +2562,7 @@ float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &float128_params, false);
+    parts128_uncanon(pr, status, &float128_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -5600,7 +5592,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         /* Round remainder to the target format */
         *r = *r_precise;
         status->float_exception_flags = 0;
-        parts_uncanon(r, status, fmt, false);
+        parts64_uncanon(r, status, fmt, false);
         r_flags = status->float_exception_flags;
         r->frac &= (1ULL << fmt->frac_size) - 1;
         parts64_canonicalize(r, status, fmt);
-- 
2.43.0


