Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AA9FF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzis-0006wX-C7; Sun, 26 Apr 2026 09:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGziY-0006kW-UK
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:16 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGziX-0008F5-0I
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:14 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c76cce85bd9so3529160a12.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210811; x=1777815611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKtv+p36Hy41OyLkt25kLH4CmBx913v33ogitpjaG94=;
 b=iluiijfz9KXD3wweyOpHYNQw9bD/u8u3WyvW87JCfLjMvNUGGp8z3JpLE8w7l+a7/U
 4PtJOSP7wnWxWv2u065xUHI4jRkcKRfdZg2L5e00QlzckxHk9Pu8b00oE4uZNiYoCahK
 Lz2eso94fKcqHG4PRuTax39MXohnJh3weox9Zh2qZ863JSee+No+131G5wzSZgvvuXNA
 /UxQPgk9pyo/glc3+dpz4ior16U8KHs8CJTokgNGLAd61yViBjUllzqDPLGNT4NaqJuM
 +BkNLeDZnWgA+7ce5O0oWftpFFt7M3+AtLjULG7gKUASGBXNCwrGVsZ3A+e1m34wTUY8
 YS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210811; x=1777815611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PKtv+p36Hy41OyLkt25kLH4CmBx913v33ogitpjaG94=;
 b=LqEjt2BxmNl3T9GZt9xOsBpkgXbYJRMPo5JhQscvquHeeqU5RZnB7tAgGTiJCkJS+C
 j7N4ALLwzBIS4ayQ8AHgGvm4i58WADHDzkjLmTDqrRvc9qt4pNkRhGjUbOsT9WY36mY8
 3cZGytCqYXd+j7lp+7rGVq+pAPtWqoR0bqfHWQ4RVO/waNSSC4z3XL3ztLfDgK2YDTHK
 cNM+viUR50vFU//x39lttMNPbFhX4ZDJkXVb9AAg/dRx7NoiCHZxGcwbw61F9Ai7fw4O
 d8Ym5rea6W97/emcMQ3Ty+sbTpfVEK1LwY80ZzORJOkqaeJxRv0znYKZ5SnOWdFE+pQm
 XHiA==
X-Gm-Message-State: AOJu0YzsGQbPYKmAQzmpIGXEL8eOBe6ASVwsLWMGjmFComMnwDZbI33V
 IHTYcqo/gTQK/B1jLJzsiZQlW8xtLYgUKoKQGWMGGN/sBC8WI1zHkv9soi14KoXgeDocxrE7E7c
 p7m2L55U=
X-Gm-Gg: AeBDies2+0are1PB49oZ9wRWbMK61sYQDJmkacuqHprjl+PUEVdFaWeaoysbaJV0AdC
 cN/mHGpfzFOx4+UqCzsf08aGW6q145+nlt7eizckZCITxwpKaq6FBTd6VnvhuI/woLvfKKIIgUZ
 evyakadx7vkPwa/DrER8/Z3QBwvnRpCSaCIr8jYvqtHWoSXKb7VJXIUEYJTAKGJ3t6iXc85l4W5
 JBeZ6yGES+cXfhYb987iuL4gH0qq52ya0UNllkNCcFimjSrlGF9ggiAVYoPVGhmjAc7VTg0Xmwh
 0XrS8ESwfuPx9DADDLmyIwo2abNXQgRT35vxtMWeDIZhkPgUP4wRFLOObOkSYt7orKDXEz9xJnv
 gewPVLCuu/8ZgJFNF+ulJC/C3XXxgqqyPifRUid1lczJMqWqQbeWZOh4TPS4QD6VxGrUiRywMiW
 2eGgObr/gtrBR3mpXn442lsVLWtL45TPy+JjNdT4HQ
X-Received: by 2002:a17:903:1a4e:b0:2b0:4aeb:dedc with SMTP id
 d9443c01a7336-2b5f9f1c60cmr397206465ad.26.1777210811416; 
 Sun, 26 Apr 2026 06:40:11 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 01/84] fpu: Drop parts_canonicalize
Date: Sun, 26 Apr 2026 23:38:38 +1000
Message-ID: <20260426134002.865628-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Use the specific parts{64,12}_canonicalize at each site.
Drop the forward declarations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 91c34307c8..f9997f5236 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -806,14 +806,6 @@ static FloatParts128 *parts128_pick_nan_muladd(FloatParts128 *a,
 #define parts_pick_nan_muladd(A, B, C, S, ABM, ABCM) \
     PARTS_GENERIC_64_128(pick_nan_muladd, A)(A, B, C, S, ABM, ABCM)
 
-static void parts64_canonicalize(FloatParts64 *p, float_status *status,
-                                 const FloatFmt *fmt);
-static void parts128_canonicalize(FloatParts128 *p, float_status *status,
-                                  const FloatFmt *fmt);
-
-#define parts_canonicalize(A, S, F) \
-    PARTS_GENERIC_64_128(canonicalize, A)(A, S, F)
-
 static void parts64_uncanon_normal(FloatParts64 *p, float_status *status,
                                    const FloatFmt *fmt, bool saturate);
 static void parts128_uncanon_normal(FloatParts128 *p, float_status *status,
@@ -1723,28 +1715,28 @@ static void float4_e2m1_unpack_canonical(FloatParts64 *p, float4_e2m1 f,
                                          float_status *s)
 {
     float4_e2m1_unpack_raw(p, f);
-    parts_canonicalize(p, s, &float4_e2m1_params);
+    parts64_canonicalize(p, s, &float4_e2m1_params);
 }
 
 static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
                                          float_status *s)
 {
     float8_e4m3_unpack_raw(p, f);
-    parts_canonicalize(p, s, &float8_e4m3_params);
+    parts64_canonicalize(p, s, &float8_e4m3_params);
 }
 
 static void float8_e5m2_unpack_canonical(FloatParts64 *p, float8_e5m2 f,
                                          float_status *s)
 {
     float8_e5m2_unpack_raw(p, f);
-    parts_canonicalize(p, s, &float8_e5m2_params);
+    parts64_canonicalize(p, s, &float8_e5m2_params);
 }
 
 static void float16a_unpack_canonical(FloatParts64 *p, float16 f,
                                       float_status *s, const FloatFmt *params)
 {
     float16_unpack_raw(p, f);
-    parts_canonicalize(p, s, params);
+    parts64_canonicalize(p, s, params);
 }
 
 static void float16_unpack_canonical(FloatParts64 *p, float16 f,
@@ -1757,7 +1749,7 @@ static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
                                       float_status *s)
 {
     bfloat16_unpack_raw(p, f);
-    parts_canonicalize(p, s, &bfloat16_params);
+    parts64_canonicalize(p, s, &bfloat16_params);
 }
 
 static float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p,
@@ -1801,7 +1793,7 @@ static void float32_unpack_canonical(FloatParts64 *p, float32 f,
                                      float_status *s)
 {
     float32_unpack_raw(p, f);
-    parts_canonicalize(p, s, &float32_params);
+    parts64_canonicalize(p, s, &float32_params);
 }
 
 static float32 float32_round_pack_canonical(FloatParts64 *p,
@@ -1815,7 +1807,7 @@ static void float64_unpack_canonical(FloatParts64 *p, float64 f,
                                      float_status *s)
 {
     float64_unpack_raw(p, f);
-    parts_canonicalize(p, s, &float64_params);
+    parts64_canonicalize(p, s, &float64_params);
 }
 
 static float64 float64_round_pack_canonical(FloatParts64 *p,
@@ -1878,7 +1870,7 @@ static void float128_unpack_canonical(FloatParts128 *p, float128 f,
                                       float_status *s)
 {
     float128_unpack_raw(p, f);
-    parts_canonicalize(p, s, &float128_params);
+    parts128_canonicalize(p, s, &float128_params);
 }
 
 static float128 float128_round_pack_canonical(FloatParts128 *p,
@@ -1910,7 +1902,7 @@ static bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f,
     floatx80_unpack_raw(p, f);
 
     if (likely(p->exp != floatx80_params[floatx80_precision_x].exp_max)) {
-        parts_canonicalize(p, s, &floatx80_params[floatx80_precision_x]);
+        parts128_canonicalize(p, s, &floatx80_params[floatx80_precision_x]);
     } else {
         /* The explicit integer bit is ignored, after invalid checks. */
         p->frac_hi &= MAKE_64BIT_MASK(0, 63);
@@ -5611,7 +5603,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         parts_uncanon(r, status, fmt, false);
         r_flags = status->float_exception_flags;
         r->frac &= (1ULL << fmt->frac_size) - 1;
-        parts_canonicalize(r, status, fmt);
+        parts64_canonicalize(r, status, fmt);
 
         /* POp table "Results: DIVIDE TO INTEGER (Part 2 of 2)" */
         if (is_q_smallish) {
-- 
2.43.0


