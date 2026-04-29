Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E609FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDL4-0008NF-EP; Wed, 29 Apr 2026 18:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDL2-0008Mk-5W
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:00 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDL0-0004V9-20
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:24:59 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-356337f058aso124201a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501497; x=1778106297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWTirkzwzjfMjCJY4v6LGxNAeG2bsrVrjNCZwRmk+Ns=;
 b=Gnu5x5KhVSVMjcCAtNOeHf/SKTIJ5FXDbSs3S/GZnEreMeZroKXAFtc1uGglngzRV0
 ooInzfNKhgG6zwli5IR1dv3kXfF0fJS+cfwQoh/7XNGMf/G9qGDE306CYlWfmO9Nb5kU
 DTUweuoJopxsPoxT2QvqBrYOsYbDiLeybKASaWzVy8Kq5EO+uUCuJwDUskLHZvgwBLTe
 IftMcbm3ISyB/4smwjnKqJOg3kr4ekgLAXBMiH9EyqZguKb7S4Fj8Y6+TdUp75IMElGM
 2sAX9MrMMNObCKz9czA11cmeHC1nZjZ2x1oCGPjaFtsTxdbyWoLXtk+ymeMWiaCyFHev
 DWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501497; x=1778106297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OWTirkzwzjfMjCJY4v6LGxNAeG2bsrVrjNCZwRmk+Ns=;
 b=Jz3CMeac5niqc64GeQmGuj5PzT9+nIll8329h8M/qY41aqHKlKzBMBrkHxPWexpEqi
 Ysz3hzDhhifmldxvLSvV6VbSH7mg7NX292cllml22b1anbSqXprPz4vbAMLxzM0UMpFd
 IDlzdO4qG39xyIrGOpI8IAhCrazJLa9VRnQRpvIrhAMMdwM/UJtjvQLkaf5SchzjiZ/U
 BUREbFdExU4AEH1oTjj7dvwOhs4qAJUAtGaSUnTll14Rga95ewvgSeFhisHor+9nynjQ
 FPiNi7f2AvaT7us4+K8TMeEYz3RGXWVVBL0NEnTVsmihZCAJ2OjtUOUTR9Fk1SEkGjwA
 l7gQ==
X-Gm-Message-State: AOJu0YwZR7xHK1zFtyE5yH9xp2uMI165LM+6a1SuvU0WuXhbUO0eY+tc
 qyoJm/wPPzpwqsgPNu9bolQfAKRX1SRIiD9q8VN1hq2+KQLsn7f1aRzU9dxdEI7K0RcuxvzdoR3
 xEMR4ilw=
X-Gm-Gg: AeBDievOF5pNanIPAk7cVywVqXmHCZUJwimomS92NH8KOLlOJLxzUNy8UeMhBI/c9Ja
 Cu4zrjq5/U9xYwr7Ec9ERMXW4qyckd8ccDY5HkJnkKh3T+ygHsm7E2WdBcuJqDZg6ZaAaAx3Hwe
 asMw/RNbRtnhv9Y3MbkpSvc1U+b4m5EXNQAa4cif0OrvQD0+Sfzcm625/mmOMrrSBe7YRcCzrNN
 /aE6NyX3EkepAgYbn1WO9CF/+wWpPXREixBdUjbvWdeh+myYmnIUGAKICqKZwKKg15fkVYq+0ZU
 ydfoGHVLwcdWpLp5g5i1/SWykHmtzxotaI2OvO1ntf7ORWPhWj89nZzfqNg9C6jmhIim30shkgp
 aM9yPqHMFNNzz0xzGek+1fhFznQkrluo41AZaemtmTMa8Wfdbh42+dKzLbV4ct96PpLyh5sgJI/
 /Knif2xYFjTkgSqIaXqiR1kc+JWC8V6Xmltf4R0i0l
X-Received: by 2002:a17:90a:fc4f:b0:364:aa5d:7d64 with SMTP id
 98e67ed59e1d1-364c308db3amr151227a91.14.1777501496562; 
 Wed, 29 Apr 2026 15:24:56 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:24:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/48] fpu: Drop parts_uncanon
Date: Thu, 30 Apr 2026 08:23:59 +1000
Message-ID: <20260429222445.26301-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Use parts{64,128}_uncanon at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


