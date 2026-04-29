Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D77FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDPe-0005ot-FH; Wed, 29 Apr 2026 18:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPY-0005SB-Ov
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:41 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPW-0006yi-Mj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:40 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so152557a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501777; x=1778106577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UyziKzBm03O+Tx0BBBbP2Rb+m5xqlSSla/fD7HN85E=;
 b=F25TZMH8SbiIFOb+BpsJNMrL052bxpIossI9FjmugdQ0ko8JpGj2J+ECbcZoBaN/ks
 oeNXccehubFM4HTsGXYDLEzoPE/w6vrsQUzUDN6ic937q56ELR6CE0IYMapbK8zSFqSK
 1Dk/YOrTK9NzgAlNSbvDuQH/W/BTkpQ87r7Ol9+9lTr5Zj4tVjAYDD94h24LvhrHn9pH
 emw0+mz/+3eJuaEemsVzsYtHI/nncDpg1wHw4E0JcXaKDfhrYlKDfz1zTpbD6Cx9HuMJ
 K7hj2PAq/+WOGfHmrXBy9gFzY8jvY6pp8TQ7O3cDYuDHz/WlxVTSpJeRBnND5IdU6OBd
 NR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501777; x=1778106577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+UyziKzBm03O+Tx0BBBbP2Rb+m5xqlSSla/fD7HN85E=;
 b=l7iIlTEOpAZAlzpzfY8k/oDCI9DLKEiA83/GYHlbGcjB2jpA7G0ie5B7vEqo2GLMYX
 jM9WuUQzs7iySwzShGRhIZq+QSdcAMaaeoZeLs2fWZkzQnjQtfCTXXCX6q8ozUsUxccL
 qgCg5ya2HViP7oecfOuIrzak5TeNffIRVFwzghKFJ2Ru0hTb2PBRbpqK4C8u4Zx9WcWI
 MHVx9vQTqSPyVf8nc70oK9MI3eGMGb+4sXqBKWMG2lyPquLyN6kcuUTlNm1yC9DsBR0X
 ybORqF/jLjCVfjJTxotSLDiEjxtjj3xYZozmO9SpZtAu5uIor5+JdjUM9BvjA9NhCVbe
 /uag==
X-Gm-Message-State: AOJu0YwJ+wtiv66q1S/ddRwTJ0E6KqZCJen8WXNmp1Yk9BeS8ORJ5YUs
 dO6uB474PgbrXDDwp+SQsPFmMxTnHGDsCAJPZnWAz4on3nKPGmK4Q/La1QN3ir90/VhKRaFxIT0
 m1J2Y8EE=
X-Gm-Gg: AeBDiest7I48N8F+gSGH8/Alu93+hAIIknVP7oUx0Kk+nr8xf5Zn2PhfgKv8pG7ElwD
 5Kk3tZ5FPsY+79H3yu+3Zdt0xGigumAzHYA/LCTPs5PHUwQKDGQ1gArGrnFmLivi7duNkR6h51i
 xOpvz/ZNg7ZW+durBv16+qaUa5ztafXX23Kij7SvzUQVUnIKQgYtBnTywMq+19DOqM6ZmUVuHhJ
 /bxoCS1cMn7/ncyZh81+KRPGQqzbHOhgJIWziBMg5IQlFy6anT25KeygY8wcX+WyFrQfL54j/i9
 l4Q7Z0mZAxBbFz5oaFLqstwF8e/rIPMG8AvS4I+OApLYhGFqzqG0Rtd+21bMHrjNBfUu9MpPIDP
 57dnVQxonWDOqP/HSzc6r2KQIIWL+x2hG4/ViM6EnoJWB2X7/Koodzlp/or3xBHkiCOBTOn6dYl
 nYOpDjFiPCbZ468WQ1IyjIzq7TPkbSjD63jnqNTCBy
X-Received: by 2002:a17:90b:584c:b0:35d:a38a:a117 with SMTP id
 98e67ed59e1d1-364c308ef0bmr168723a91.15.1777501776770; 
 Wed, 29 Apr 2026 15:29:36 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf54203sm630479a91.7.2026.04.29.15.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:29:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/48] fpu: Return struct from bfloat16_unpack_canonical
Date: Thu, 30 Apr 2026 08:24:37 +1000
Message-ID: <20260429222445.26301-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 108 +++++++++++++++++-------------------------------
 1 file changed, 37 insertions(+), 71 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 566154a729..19cca8fb85 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1482,11 +1482,11 @@ static FloatParts64 float16_unpack_canonical(float16 f, float_status *s)
     return float16a_unpack_canonical(f, s, &float16_params);
 }
 
-static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
-                                      float_status *s)
+static FloatParts64 bfloat16_unpack_canonical(bfloat16 f, float_status *s)
 {
-    *p = unpack_raw64(&bfloat16_params, f);
-    parts64_canonicalize(p, s, &bfloat16_params);
+    FloatParts64 p = unpack_raw64(&bfloat16_params, f);
+    parts64_canonicalize(&p, s, &bfloat16_params);
+    return p;
 }
 
 static float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p,
@@ -1873,11 +1873,9 @@ float64 float64r32_sub(float64 a, float64 b, float_status *status)
 static bfloat16 QEMU_FLATTEN
 bfloat16_addsub(bfloat16 a, bfloat16 b, float_status *status, bool subtract)
 {
-    FloatParts64 pa, pb, *pr;
-
-    bfloat16_unpack_canonical(&pa, a, status);
-    bfloat16_unpack_canonical(&pb, b, status);
-    pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pa = bfloat16_unpack_canonical(a, status);
+    FloatParts64 pb = bfloat16_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
 
     return bfloat16_round_pack_canonical(pr, status);
 }
@@ -2013,11 +2011,9 @@ float64 float64r32_mul(float64 a, float64 b, float_status *status)
 bfloat16 QEMU_FLATTEN
 bfloat16_mul(bfloat16 a, bfloat16 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    bfloat16_unpack_canonical(&pa, a, status);
-    bfloat16_unpack_canonical(&pb, b, status);
-    pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pa = bfloat16_unpack_canonical(a, status);
+    FloatParts64 pb = bfloat16_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
 
     return bfloat16_round_pack_canonical(pr, status);
 }
@@ -2276,12 +2272,10 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
 bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
                                       int flags, float_status *status)
 {
-    FloatParts64 pa, pb, pc, *pr;
-
-    bfloat16_unpack_canonical(&pa, a, status);
-    bfloat16_unpack_canonical(&pb, b, status);
-    bfloat16_unpack_canonical(&pc, c, status);
-    pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    FloatParts64 pa = bfloat16_unpack_canonical(a, status);
+    FloatParts64 pb = bfloat16_unpack_canonical(b, status);
+    FloatParts64 pc = bfloat16_unpack_canonical(c, status);
+    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &bfloat16_params, false);
@@ -2418,11 +2412,9 @@ float64 float64r32_div(float64 a, float64 b, float_status *status)
 bfloat16 QEMU_FLATTEN
 bfloat16_div(bfloat16 a, bfloat16 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    bfloat16_unpack_canonical(&pa, a, status);
-    bfloat16_unpack_canonical(&pb, b, status);
-    pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pa = bfloat16_unpack_canonical(a, status);
+    FloatParts64 pb = bfloat16_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_div(&pa, &pb, status);
 
     return bfloat16_round_pack_canonical(pr, status);
 }
@@ -2791,36 +2783,32 @@ float32 float64_to_float32(float64 a, float_status *s)
 
 float8_e4m3 bfloat16_to_float8_e4m3(bfloat16 a, bool saturate, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
 
-    bfloat16_unpack_canonical(&p, a, s);
     parts64_float_to_float(&p, s);
     return float8_e4m3_round_pack_canonical(&p, s, saturate);
 }
 
 float8_e5m2 bfloat16_to_float8_e5m2(bfloat16 a, bool saturate, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
 
-    bfloat16_unpack_canonical(&p, a, s);
     parts_float_to_e5m2(&p, s, saturate);
     return float8_e5m2_round_pack_canonical(&p, s, saturate);
 }
 
 float32 bfloat16_to_float32(bfloat16 a, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
 
-    bfloat16_unpack_canonical(&p, a, s);
     parts64_float_to_float(&p, s);
     return float32_round_pack_canonical(&p, s);
 }
 
 float64 bfloat16_to_float64(bfloat16 a, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
 
-    bfloat16_unpack_canonical(&p, a, s);
     parts64_float_to_float(&p, s);
     return float64_round_pack_canonical(&p, s);
 }
@@ -2982,9 +2970,8 @@ float64 float64_round_to_int(float64 a, float_status *s)
 
 bfloat16 bfloat16_round_to_int(bfloat16 a, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
 
-    bfloat16_unpack_canonical(&p, a, s);
     parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &bfloat16_params);
     return bfloat16_round_pack_canonical(&p, s);
 }
@@ -3100,36 +3087,28 @@ int64_t float64_to_int64_scalbn(float64 a, FloatRoundMode rmode, int scale,
 int8_t bfloat16_to_int8_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
                                float_status *s)
 {
-    FloatParts64 p;
-
-    bfloat16_unpack_canonical(&p, a, s);
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT8_MIN, INT8_MAX, s);
 }
 
 int16_t bfloat16_to_int16_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
                                  float_status *s)
 {
-    FloatParts64 p;
-
-    bfloat16_unpack_canonical(&p, a, s);
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
 int32_t bfloat16_to_int32_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
                                  float_status *s)
 {
-    FloatParts64 p;
-
-    bfloat16_unpack_canonical(&p, a, s);
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 int64_t bfloat16_to_int64_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
                                  float_status *s)
 {
-    FloatParts64 p;
-
-    bfloat16_unpack_canonical(&p, a, s);
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
@@ -3590,36 +3569,28 @@ uint64_t float64_to_uint64_scalbn(float64 a, FloatRoundMode rmode, int scale,
 uint8_t bfloat16_to_uint8_scalbn(bfloat16 a, FloatRoundMode rmode,
                                  int scale, float_status *s)
 {
-    FloatParts64 p;
-
-    bfloat16_unpack_canonical(&p, a, s);
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT8_MAX, s);
 }
 
 uint16_t bfloat16_to_uint16_scalbn(bfloat16 a, FloatRoundMode rmode,
                                    int scale, float_status *s)
 {
-    FloatParts64 p;
-
-    bfloat16_unpack_canonical(&p, a, s);
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
 }
 
 uint32_t bfloat16_to_uint32_scalbn(bfloat16 a, FloatRoundMode rmode,
                                    int scale, float_status *s)
 {
-    FloatParts64 p;
-
-    bfloat16_unpack_canonical(&p, a, s);
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 uint64_t bfloat16_to_uint64_scalbn(bfloat16 a, FloatRoundMode rmode,
                                    int scale, float_status *s)
 {
-    FloatParts64 p;
-
-    bfloat16_unpack_canonical(&p, a, s);
+    FloatParts64 p = bfloat16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
@@ -4296,11 +4267,9 @@ static float16 float16_minmax(float16 a, float16 b, float_status *s, int flags)
 static bfloat16 bfloat16_minmax(bfloat16 a, bfloat16 b,
                                 float_status *s, int flags)
 {
-    FloatParts64 pa, pb, *pr;
-
-    bfloat16_unpack_canonical(&pa, a, s);
-    bfloat16_unpack_canonical(&pb, b, s);
-    pr = parts64_minmax(&pa, &pb, s, flags);
+    FloatParts64 pa = bfloat16_unpack_canonical(a, s);
+    FloatParts64 pb = bfloat16_unpack_canonical(b, s);
+    FloatParts64 *pr = parts64_minmax(&pa, &pb, s, flags);
 
     return bfloat16_round_pack_canonical(pr, s);
 }
@@ -4496,10 +4465,9 @@ FloatRelation float64_compare_quiet(float64 a, float64 b, float_status *s)
 static FloatRelation QEMU_FLATTEN
 bfloat16_do_compare(bfloat16 a, bfloat16 b, float_status *s, bool is_quiet)
 {
-    FloatParts64 pa, pb;
+    FloatParts64 pa = bfloat16_unpack_canonical(a, s);
+    FloatParts64 pb = bfloat16_unpack_canonical(b, s);
 
-    bfloat16_unpack_canonical(&pa, a, s);
-    bfloat16_unpack_canonical(&pb, b, s);
     return parts64_compare(&pa, &pb, s, is_quiet);
 }
 
@@ -4587,9 +4555,8 @@ float64 float64_scalbn(float64 a, int n, float_status *status)
 
 bfloat16 bfloat16_scalbn(bfloat16 a, int n, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = bfloat16_unpack_canonical(a, status);
 
-    bfloat16_unpack_canonical(&p, a, status);
     parts64_scalbn(&p, n, status);
     return bfloat16_round_pack_canonical(&p, status);
 }
@@ -4711,9 +4678,8 @@ float64 float64r32_sqrt(float64 a, float_status *status)
 
 bfloat16 QEMU_FLATTEN bfloat16_sqrt(bfloat16 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = bfloat16_unpack_canonical(a, status);
 
-    bfloat16_unpack_canonical(&p, a, status);
     parts64_sqrt(&p, status, &bfloat16_params);
     return bfloat16_round_pack_canonical(&p, status);
 }
-- 
2.43.0


