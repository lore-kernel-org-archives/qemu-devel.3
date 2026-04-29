Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1CFCD13D3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDM6-00017T-OC; Wed, 29 Apr 2026 18:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDM5-00014W-RR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:05 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDM4-0005DJ-7Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:05 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-362e50b4641so143038a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501563; x=1778106363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paaIchymR74CGvGMoEe290hs4RBl4U5o/eQBqkxESGA=;
 b=AzkV5aWEilamVkw7mWIhxcd+h9GGhZC4goPcsUWp+L2gR3gqhUTFSIQ6PIdKGGwM92
 CrqjiccJ4IA/Odhpd9s1ey0eYSZtQkDr7kjvb74gRUZeHftTjRSeIsLVR6BlOBFbHpue
 430r8+EUbFvmnOzZvfCINaoi95w8YwbiNJI2PmZStkRy3da0yxXYThAmOF22Y2g6R/qV
 WjsltCxmhA7s91k5I0AuwNJJqaxJZcrtkpg8kfjdDoYeg8FA1Gq2DD7UBkkGHPmYyH0Y
 IEOMqz3VLtX7IusJzZcBY4Y/uLxCqqmulcrlhHOu4w10BLxEI6+NC/nrtxWR3dNrHGQH
 gkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501563; x=1778106363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=paaIchymR74CGvGMoEe290hs4RBl4U5o/eQBqkxESGA=;
 b=hO9Iw+2ZVGAUp/49QJkYa2mrcRMjHJC+AGG815t7/t+FgcUR3cX9SS98HRb/3Ry7f7
 jvIkGJmgHzGHo0XQvk8bOZsH9gN0G3dduD5g1hra5maq5ybnAkFBLtCwDT1pggNMP/iy
 HZfGPFiILF6FbD7tVufMbxI1NqBMbILAQGwRo+Ax0nqslueAIVbKKh5XwgFyMG/n7B04
 vntTKmK0/yzQ1ZOEpEHpwGue1bXZv2fJngUGx9kQTbUDeLwssFwCTf4+0Z6k1BkSJZOr
 j9ZzFjsGq9D4a+/xezWvvgd6G060AlBOVttBowFXpxbZMHSvSP9UPg61p1ZohSK/UbTw
 D5wg==
X-Gm-Message-State: AOJu0YwdJqVjO1M9nf5qwzMRFTwAFP+O+R0NVo2kPqmT9LIPQwdLdk0w
 C3CaaLpf31opOAOAwRhtb6Uo7Rmy+n3R6tBCL0RJUOIfGbWw9gnKE1Y+fL39F5tIOtDOa8N9JTL
 t9PqntUg=
X-Gm-Gg: AeBDieuglPcbOJ/XlBAJHEqNWq5+RXo/64r3oEeNpVVJ0nHTLs0QiydRQgNls+aunhy
 rhFRJiY6V+s6+JbEX3CFTIa50ftHgS884FItLLH9DwN6xFogldudk3DW7f7zO0g3fhuqbS4Umfb
 V62vg/pcfwTP2OLlIqYyhJlydVWyKMfWvg6PLu7q7Y/p+ty2BBb8o0siQBTD6tDZ0vq76OW9WbW
 NQixVrOY5pdpz79el7hVikwCIUQg9lzjaC9EeJUbKXQ4Oway0bpy6wEomRRq8LOiv39aErGUJ4Z
 Eu/E5Q3PofUbRti+ei+aoPThG/KZGJnDK+BRBGdCCRCkUD0V9/q7zCc8WzW4z/q+/ObffqwGVnV
 21hf/wGXp0ROEw2ZNq0nw/fQrBTiPUGRWDYt1vn4NM7lDgM+RErxzdjmWVN/EZ/fXO6DVFu8Nnz
 eWkp3DOGxEGZjLpUsNoHeq2XQiJDK9u0JC9BTccfe8
X-Received: by 2002:a17:90b:1642:b0:35d:90c4:59f3 with SMTP id
 98e67ed59e1d1-364c308d421mr164465a91.13.1777501562627; 
 Wed, 29 Apr 2026 15:26:02 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/48] fpu: Drop parts_float_to_float
Date: Thu, 30 Apr 2026 08:24:25 +1000
Message-ID: <20260429222445.26301-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Use parts{64,128}_float_to_float at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6a38d161f7..b1c2f884fc 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2695,9 +2695,6 @@ static void parts128_float_to_float(FloatParts128 *a, float_status *s)
     }
 }
 
-#define parts_float_to_float(P, S) \
-    PARTS_GENERIC_64_128(float_to_float, P)(P, S)
-
 static void parts_float_to_float_narrow(FloatParts64 *a, FloatParts128 *b,
                                         float_status *s)
 {
@@ -2744,7 +2741,7 @@ float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
     FloatParts64 p;
 
     float4_e2m1_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float8_e4m3_round_pack_canonical(&p, s, false);
 }
 
@@ -2753,7 +2750,7 @@ bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
     FloatParts64 p;
 
     float8_e4m3_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -2762,7 +2759,7 @@ bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, float_status *s)
     FloatParts64 p;
 
     float8_e5m2_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -2772,7 +2769,7 @@ float32 float16_to_float32(float16 a, bool ieee, float_status *s)
     FloatParts64 p;
 
     float16a_unpack_canonical(&p, a, s, fmt16);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float32_round_pack_canonical(&p, s);
 }
 
@@ -2782,7 +2779,7 @@ float64 float16_to_float64(float16 a, bool ieee, float_status *s)
     FloatParts64 p;
 
     float16a_unpack_canonical(&p, a, s, fmt16);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float64_round_pack_canonical(&p, s);
 }
 
@@ -2791,7 +2788,7 @@ float8_e4m3 float32_to_float8_e4m3(float32 a, bool saturate, float_status *s)
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float8_e4m3_round_pack_canonical(&p, s, saturate);
 }
 
@@ -2811,7 +2808,7 @@ float16 float32_to_float16(float32 a, bool ieee, float_status *s)
 
     float32_unpack_canonical(&p, a, s);
     if (ieee) {
-        parts_float_to_float(&p, s);
+        parts64_float_to_float(&p, s);
         fmt = &float16_params;
     } else {
         parts_float_to_ahp(&p, s);
@@ -2826,7 +2823,7 @@ soft_float32_to_float64(float32 a, float_status *s)
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float64_round_pack_canonical(&p, s);
 }
 
@@ -2853,7 +2850,7 @@ float16 float64_to_float16(float64 a, bool ieee, float_status *s)
 
     float64_unpack_canonical(&p, a, s);
     if (ieee) {
-        parts_float_to_float(&p, s);
+        parts64_float_to_float(&p, s);
         fmt = &float16_params;
     } else {
         parts_float_to_ahp(&p, s);
@@ -2867,7 +2864,7 @@ float32 float64_to_float32(float64 a, float_status *s)
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float32_round_pack_canonical(&p, s);
 }
 
@@ -2876,7 +2873,7 @@ float8_e4m3 bfloat16_to_float8_e4m3(bfloat16 a, bool saturate, float_status *s)
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float8_e4m3_round_pack_canonical(&p, s, saturate);
 }
 
@@ -2894,7 +2891,7 @@ float32 bfloat16_to_float32(bfloat16 a, float_status *s)
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float32_round_pack_canonical(&p, s);
 }
 
@@ -2903,7 +2900,7 @@ float64 bfloat16_to_float64(bfloat16 a, float_status *s)
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float64_round_pack_canonical(&p, s);
 }
 
@@ -2912,7 +2909,7 @@ bfloat16 float32_to_bfloat16(float32 a, float_status *s)
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -2921,7 +2918,7 @@ bfloat16 float64_to_bfloat16(float64 a, float_status *s)
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -2996,7 +2993,7 @@ float128 floatx80_to_float128(floatx80 a, float_status *s)
     FloatParts128 p;
 
     if (floatx80_unpack_canonical(&p, a, s)) {
-        parts_float_to_float(&p, s);
+        parts128_float_to_float(&p, s);
     } else {
         parts128_default_nan(&p, s);
     }
@@ -3028,7 +3025,7 @@ floatx80 float128_to_floatx80(float128 a, float_status *s)
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts128_float_to_float(&p, s);
     return floatx80_round_pack_canonical(&p, s);
 }
 
-- 
2.43.0


