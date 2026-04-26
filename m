Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBC0FF8863
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzkf-0001CW-8m; Sun, 26 Apr 2026 09:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzk9-0000Ku-2P
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:54 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzk5-0000Nk-CX
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:52 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so39831975ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210908; x=1777815708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aS1gs1RvelZlceNbvZcAlxYN3xyEvlj7p2J5cTIwkbw=;
 b=tgeS1dxk7z7N9j9HjL1KYoIIokjc0MK+P8MEotSU3ITeOq7GpVMZtVswJk+uq1B2c1
 zqq6lJeTGGUxmjg371/JUC2QOIVNUgSX/48CQb4gahn7/dCaa+nAMaxY4Z7kNieRU3gN
 2CxCq2wpL1ldES3g79OCRkMpzKefEh2cqqrlsnuh4vGWQyuQMUXy88u0cdY2IU2VSJP5
 AnLSM0d7YkJTz/HZiFEgcrtR0P12J4WmHBYEDRTqhi1hMVYGHYC1i6lD3Hc6+LNeqvG4
 TzAGomMC2bpWIJGHKPj46O5yamChTRt/0uPplji69JYz96y3jdBipmsyqXbJEaytnaxe
 JF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210908; x=1777815708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aS1gs1RvelZlceNbvZcAlxYN3xyEvlj7p2J5cTIwkbw=;
 b=gl8BUBdZJ9ve415OENt1fFySuknA/Diule1f1jAA/biPYGBc9w9nGYLErDch7epyVd
 EaKZouNuJoWD86IbKOqmAgOpN1G4QVSkYMhRxLEGQviBcKTtSHRabrCmgkWgq3OFgRGH
 wSU+Ku1X1qCJSZrAVgKNxrsDUCwOG6FsNaVUzfz58XQGJWcPPJwL8yrs+214VoBdtHUb
 H1SgpSnFXUBWfeWABGeUJh0R4b38O4ECNszXayAKXTp7ffZVEl1TtH1hXtMWNI58M302
 1TjTTqlh/ZZ+c3Sx7tZ5K+ffg5RWLuXvliVRk1O9gNKRGR3KeDXJA6uGTk6F+zxCW3P2
 V/5w==
X-Gm-Message-State: AOJu0Yw/csjUIlj3CZAqLf94nZK/UvRKPt3h0w7ast5p5XnfdAsbOm9u
 4fM+YsXIH+mr3g9o9wtB6NqusQlufEzyU7cji1ISRQ5BjE/zjJ1+FtibLnbZvIfHXk6aQh/wVIM
 lbHxzHjI=
X-Gm-Gg: AeBDiesNR+QrdH/PQO2ThAyr1MdFXDaWnzGjXFezW780VkCNr1xXL0dlYMBCv5kPU5c
 YzShfw9ob8Lw1pNamaUgtpX1sBsO9nosW1YUBTPkwwizlg66Rd8I8qP9X4luUAOyGOf/m+nUXBz
 M61EtHU1Ct5/joj5BKyhxzvwtViZpEy6vb0bZcqbn2Ers8q5Es8wsZYPMrbwiLWcChHQVUm7kxB
 wP+4oLUIMBy83Yv9QXFe/CAvXS9GtubAbCLS4h1qX8JwSGhzcXhOhNFdKX3/hygaW0MfVPeYks+
 He1To+jIOzqLOQNYfSPe2+gzdsgqjrK1gHFrD1Rfky0Ms5FeAgLR1nTui/VDbOt7xkrdJ53ZXJT
 P9V9Xo4qMySPx7eRzDyWcWHiE7zoXGW/L/IcOUZR8dhCEyVB95OSWRuqRN6TAaVElMwE3RIrVqH
 w0jMTkN1r+sPqK0ZJbvNGXBARlbI3+J/cWEk99YX4d
X-Received: by 2002:a17:903:384c:b0:2b0:7e4d:f390 with SMTP id
 d9443c01a7336-2b5f9fb1b9cmr382189115ad.41.1777210907946; 
 Sun, 26 Apr 2026 06:41:47 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 38/84] fpu: Return struct from float16_unpack_canonical
Date: Sun, 26 Apr 2026 23:39:15 +1000
Message-ID: <20260426134002.865628-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 fpu/softfloat.c | 94 +++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 62 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index dee5dcd0d2..3612d2fceb 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1482,10 +1482,9 @@ static FloatParts64 float16a_unpack_canonical(float16 f, float_status *s,
     return p;
 }
 
-static void float16_unpack_canonical(FloatParts64 *p, float16 f,
-                                     float_status *s)
+static FloatParts64 float16_unpack_canonical(float16 f, float_status *s)
 {
-    *p = float16a_unpack_canonical(f, s, &float16_params);
+    return float16a_unpack_canonical(f, s, &float16_params);
 }
 
 static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
@@ -1718,11 +1717,9 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
 static float16 QEMU_FLATTEN
 float16_addsub(float16 a, float16 b, float_status *status, bool subtract)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float16_unpack_canonical(&pa, a, status);
-    float16_unpack_canonical(&pb, b, status);
-    pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pa = float16_unpack_canonical(a, status);
+    FloatParts64 pb = float16_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
 
     return float16_round_pack_canonical(pr, status);
 }
@@ -1952,11 +1949,9 @@ floatx80 floatx80_sub(floatx80 a, floatx80 b, float_status *status)
 
 float16 QEMU_FLATTEN float16_mul(float16 a, float16 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float16_unpack_canonical(&pa, a, status);
-    float16_unpack_canonical(&pb, b, status);
-    pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pa = float16_unpack_canonical(a, status);
+    FloatParts64 pb = float16_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
 
     return float16_round_pack_canonical(pr, status);
 }
@@ -2066,12 +2061,11 @@ float16 QEMU_FLATTEN
 float16_muladd_scalbn(float16 a, float16 b, float16 c,
                       int scale, int flags, float_status *status)
 {
-    FloatParts64 pa, pb, pc, *pr;
-
-    float16_unpack_canonical(&pa, a, status);
-    float16_unpack_canonical(&pb, b, status);
-    float16_unpack_canonical(&pc, c, status);
-    pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    FloatParts64 pa = float16_unpack_canonical(a, status);
+    FloatParts64 pb = float16_unpack_canonical(b, status);
+    FloatParts64 pc = float16_unpack_canonical(c, status);
+    FloatParts64 *pr =
+        parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float16_params, false);
@@ -2326,11 +2320,9 @@ float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
 
 float16 float16_div(float16 a, float16 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float16_unpack_canonical(&pa, a, status);
-    float16_unpack_canonical(&pb, b, status);
-    pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pa = float16_unpack_canonical(a, status);
+    FloatParts64 pb = float16_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_div(&pa, &pb, status);
 
     return float16_round_pack_canonical(pr, status);
 }
@@ -2969,9 +2961,8 @@ floatx80 float128_to_floatx80(float128 a, float_status *s)
 
 float16 float16_round_to_int(float16 a, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float16_unpack_canonical(a, s);
 
-    float16_unpack_canonical(&p, a, s);
     parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float16_params);
     return float16_round_pack_canonical(&p, s);
 }
@@ -3032,36 +3023,28 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
 int8_t float16_to_int8_scalbn(float16 a, FloatRoundMode rmode, int scale,
                               float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT8_MIN, INT8_MAX, s);
 }
 
 int16_t float16_to_int16_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
 int32_t float16_to_int32_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 int64_t float16_to_int64_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
@@ -3530,36 +3513,28 @@ int64_t float64_to_int64_modulo(float64 a, FloatRoundMode rmode,
 uint8_t float16_to_uint8_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT8_MAX, s);
 }
 
 uint16_t float16_to_uint16_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
 }
 
 uint32_t float16_to_uint32_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 uint64_t float16_to_uint64_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
@@ -4316,11 +4291,9 @@ float128 uint128_to_float128(Int128 a, float_status *status)
 
 static float16 float16_minmax(float16 a, float16 b, float_status *s, int flags)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float16_unpack_canonical(&pa, a, s);
-    float16_unpack_canonical(&pb, b, s);
-    pr = parts64_minmax(&pa, &pb, s, flags);
+    FloatParts64 pa = float16_unpack_canonical(a, s);
+    FloatParts64 pb = float16_unpack_canonical(b, s);
+    FloatParts64 *pr = parts64_minmax(&pa, &pb, s, flags);
 
     return float16_round_pack_canonical(pr, s);
 }
@@ -4401,10 +4374,9 @@ MINMAX_2(float128)
 static FloatRelation QEMU_FLATTEN
 float16_do_compare(float16 a, float16 b, float_status *s, bool is_quiet)
 {
-    FloatParts64 pa, pb;
+    FloatParts64 pa = float16_unpack_canonical(a, s);
+    FloatParts64 pb = float16_unpack_canonical(b, s);
 
-    float16_unpack_canonical(&pa, a, s);
-    float16_unpack_canonical(&pb, b, s);
     return parts64_compare(&pa, &pb, s, is_quiet);
 }
 
@@ -4594,9 +4566,8 @@ FloatRelation floatx80_compare_quiet(floatx80 a, floatx80 b, float_status *s)
 
 float16 float16_scalbn(float16 a, int n, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = float16_unpack_canonical(a, status);
 
-    float16_unpack_canonical(&p, a, status);
     parts64_scalbn(&p, n, status);
     return float16_round_pack_canonical(&p, status);
 }
@@ -4654,9 +4625,8 @@ floatx80 floatx80_scalbn(floatx80 a, int n, float_status *status)
 
 float16 QEMU_FLATTEN float16_sqrt(float16 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = float16_unpack_canonical(a, status);
 
-    float16_unpack_canonical(&p, a, status);
     parts64_sqrt(&p, status, &float16_params);
     return float16_round_pack_canonical(&p, status);
 }
-- 
2.43.0


