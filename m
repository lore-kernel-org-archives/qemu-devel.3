Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D169FFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLh-0000Hk-OX; Wed, 29 Apr 2026 18:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLU-0000BL-Ql
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:33 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLS-0004qc-OB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:28 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35d95017a68so153354a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501525; x=1778106325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNhUQubv0Ujs2Q4sfxENZ0/GvrdtYcMc/gJ6VN/sHJ4=;
 b=kNKiDoVTgTiCEqFWyyq3ctUlLd7yJOL88mT8PoWV7DSePx+NaIOxQ8AD41RfEOBSjk
 VRbEHeuq/okx+wOrb1Uf6l4VVBC4t9kq0ittWmljLszrVyOu8O8OHijAOK6umZihwpT2
 cApjqf/MD4IjDt1y6TqPIqD+HYXrfXqp7kor5Lm5gxqDW8BA4wUBSTCw50oJxzwG0Npp
 TWtlXx5eLJ0mEYINyk/sGLn6IoypK48k60sn3efTLjXVHXEj5eoUMdxGYExeRE1hq57s
 rqwcwfBeKuXVC1JdPx2VuNF+jx+MSOsxtq8ZpOWBQK9/4SnQBdyvhLDtB3+OgI76WiE9
 zm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501525; x=1778106325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BNhUQubv0Ujs2Q4sfxENZ0/GvrdtYcMc/gJ6VN/sHJ4=;
 b=QtqDKEdMpoSG9Lov2XVGpgYWEaVS9OLKhgLlTDC9DxQNfE+xRr2S4bg8+U+RmhHB9q
 X9GiXjqID7Hld3d7KGG+dffyQBtsLx7tzLewkedU5wInlLHUhiRnys7TViBzNeFBuV1F
 Wi33rUWA9F5d2zKhgyPKSN7eMmrr5m8D8YNv2d+l+KAQl3mbjpA10MhaeFIqRVdVh5nn
 cj9CgymDdfDJ5b3Slqq+0S/rAS9iuUBYyKTLkefXHcY31miis4ncf1wFKay7iY0d8oBO
 g573WrSxqQey6OiJ+xrdbjjvJyizYO9l4JxgNpLsG6nmrwGz6OqTCLNs4HITtPQSdRmb
 hBFw==
X-Gm-Message-State: AOJu0Yz73RoqbAv8vT5uQuopPvoXQuG6ZA/6f0I1cmzSrQmCuO5whGXa
 p/QF0YFJy0YZ8U1mAN2igde3f37++nHA6g1zpyRNk/Mx5tbKTeeGNM+ex515osIs6aWvfGgN7Kh
 odomq3nQ=
X-Gm-Gg: AeBDieuFC/moTv9yYwJPQZDryK2LsxsqC36aAHBcgN/ncC50KUOwqrqUt7zCqt4hSJ5
 a/XM9DINskb1YQ3V541n7OjLLfQGxJLn9YENGjLOfv1ShFklgGw38U8EOP1Iw5dNNwg8Rjjz0Po
 oS7/gnCJfx9EtTKYIKuQf+eIaABN89YsFZiIOiQpu0BoAssWJ3m8W4UPv/bWE4MHeUY8go9e8h4
 UojZn638DvsWMh8Ybxi+wNEWmZ+2zO6uT/6l6qsU+YwWDvSO4WDvlSuRj8dyYneIZVTZX01pSFI
 dgAsMqzVmm6cL2USF2Y2xja1AgsI718niPKzk/qI8tjS95IXLGWJGMN3Vm3oV+aaSnhSPmHJpdX
 HdvIwIXJLGw7uU0vmkF+3EL8D7I7nTHt43L3uqrbATsMPX0gh82exOVmO/9T58/k+jWJu0WB/F6
 Y96Hpzq1iKgwrsLxNCAbouHlkO3miPaRlUOcoxyiIl
X-Received: by 2002:a17:90b:264b:b0:35d:a380:6d1a with SMTP id
 98e67ed59e1d1-364c2f2e00bmr184565a91.2.1777501525236; 
 Wed, 29 Apr 2026 15:25:25 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/48] fpu: Drop parts_muladd_scalbn
Date: Thu, 30 Apr 2026 08:24:10 +1000
Message-ID: <20260429222445.26301-14-richard.henderson@linaro.org>
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

Use parts{64,128}_muladd_scalbn at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8adc73c863..aa62fea47d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,16 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_muladd_scalbn(FloatParts64 *a, FloatParts64 *b,
-                                           FloatParts64 *c, int scale,
-                                           int flags, float_status *s);
-static FloatParts128 *parts128_muladd_scalbn(FloatParts128 *a, FloatParts128 *b,
-                                             FloatParts128 *c, int scale,
-                                             int flags, float_status *s);
-
-#define parts_muladd_scalbn(A, B, C, Z, Y, S) \
-    PARTS_GENERIC_64_128(muladd_scalbn, A)(A, B, C, Z, Y, S)
-
 static FloatParts64 *parts64_div(FloatParts64 *a, FloatParts64 *b,
                                  float_status *s);
 static FloatParts128 *parts128_div(FloatParts128 *a, FloatParts128 *b,
@@ -2256,7 +2246,7 @@ float16_muladd_scalbn(float16 a, float16 b, float16 c,
     float16_unpack_canonical(&pa, a, status);
     float16_unpack_canonical(&pb, b, status);
     float16_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float16_params, false);
@@ -2281,7 +2271,7 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
     float32_unpack_canonical(&pa, a, status);
     float32_unpack_canonical(&pb, b, status);
     float32_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float32_params, false);
@@ -2300,7 +2290,7 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
     float64_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float64_params, false);
@@ -2459,7 +2449,7 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
     float64_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float32_params, false);
@@ -2477,7 +2467,7 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     bfloat16_unpack_canonical(&pa, a, status);
     bfloat16_unpack_canonical(&pb, b, status);
     bfloat16_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &bfloat16_params, false);
@@ -2495,7 +2485,7 @@ float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
     float128_unpack_canonical(&pa, a, status);
     float128_unpack_canonical(&pb, b, status);
     float128_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    pr = parts128_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
     parts128_uncanon(pr, status, &float128_params, false);
@@ -5442,7 +5432,7 @@ float32 float32_exp2(float32 a, float_status *status)
     for (i = 0 ; i < 15 ; i++) {
 
         float64_unpack_canonical(&tp, float32_exp2_coefficients[i], status);
-        rp = *parts_muladd_scalbn(&tp, &xnp, &rp, 0, 0, status);
+        rp = *parts64_muladd_scalbn(&tp, &xnp, &rp, 0, 0, status);
         xnp = *parts64_mul(&xnp, &xp, status);
     }
 
@@ -5522,8 +5512,8 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
 
         /* Compute precise remainder */
         r_precise_buf = *b;
-        r_precise = parts_muladd_scalbn(&r_precise_buf, n, a, 0,
-                                        float_muladd_negate_product, status);
+        r_precise = parts64_muladd_scalbn(&r_precise_buf, n, a, 0,
+                                          float_muladd_negate_product, status);
 
         /* Round remainder to the target format */
         *r = *r_precise;
-- 
2.43.0


