Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7652C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 14:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCg6G-0002c2-6R; Wed, 07 May 2025 10:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCg6E-0002bp-Vu
 for qemu-devel@nongnu.org; Wed, 07 May 2025 10:50:19 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCg6D-0000J6-2u
 for qemu-devel@nongnu.org; Wed, 07 May 2025 10:50:18 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-af9925bbeb7so5177735a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746629415; x=1747234215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zUH8NegmOUqkBUVPiEJI2/tfc215D4zcHFQATTWMW80=;
 b=CFzL13hCWyW3q4SUJLw9HvOO0z0CXxA+y/OFG0yH8b5U3v+mdpbBVK2z9hZTQaN1aW
 Cp8JNXMZ3DJDuZeVBp6KjwJx/p8rpYrJoq9ybr9X0DY87RMz/785o9Jex8gDWDFkOqv+
 g7gt3s8GerRcIzrl8DfodHL9B0E7aG48UfK22jZmXbgy8dVnmmLUKI5lwjLA4ssW0l2E
 rLFEgk1g07XZMRiUDcBzJVKKUxylLjbdxPLVQw32LSgGNcHQQExXsaoizsmcSpDsT09O
 L1kw+Rt++ERAR5EYbUQ/oBgoDlKASTBKw4yEzVW+Hh5Aip2di8O219020BJjphEOc8Pk
 1TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746629415; x=1747234215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zUH8NegmOUqkBUVPiEJI2/tfc215D4zcHFQATTWMW80=;
 b=SVFDSmCp30dgGCD8sM4UMn4SEhSCeOvS69u9/94xL4o2Ahu2rfS4fcRXmxW1Kd3rlq
 xPp397XZOFdgfp3jAMsg1vKfmfAQZmb1VdKcUojbNrbYdIM8itKwv9QbZaiOojQbMi24
 5wBVCCd4yOvEkgT1NFsW1FnBlh9GwdHvpsYSJ686Jm+GjOUAfdIWixMCORMew6EntcHu
 Poo02cQkCDJ5TW0HYSf5cO349KC0Bcb9zyl0GcTJJIL/+UTLld6dKl8l/wKukW72l5l6
 H0hLiXTJ3CF94pffS8HsXjhRoDDH4xkCK15zWEu1eT4Ag5AIuceeMLFres+L68rzXlZG
 x0lw==
X-Gm-Message-State: AOJu0YxT7cxIMz59NhxEm2MpSWfaCB9BB6lblafln9WSFqTuR/5c+Bla
 7b+y59hS5QP5bLVtOHdX80Tmix28F7Hg7/vitwwc2PGybEN1yaAk1B15Dvmu7aRxX4ZvJq95jwZ
 F
X-Gm-Gg: ASbGncvPoRc7uysMyQJXfP3IakXfv6800oKaYypfvfJr0vWqseZcrnb2DCsgNDRFm5Q
 kwQgbcZi1OCea4EF5x3Ynif/r8uzto8dbkxRdSKXsclAYRVhk+3GMKi+IUZIWfZNrBxaafj6pyI
 x4KTVLDJT/x4fCnptwLe7l2F70rU9WI5bL0YUCX7SEvJQNmEh0r+dK8onF5/mVyr6gbY/beAEHQ
 8JghLbc2Wp/Rl4sHLzJQl6KApIul/TIhBatOcFAH663KK7KLiCWuHPwgOE8I9HVY1exatfH8BR1
 gXVJgAFjDnml5jsvfYxzjrRlZI5y9sUMebVwGeUsWlc+5csJHWPUPjiNkJeAam8LNwBpsULokCA
 =
X-Google-Smtp-Source: AGHT+IF8TnpDcsT6w+Nc3VGlNFK5UzhOwonK9+ATAD2Kie1VVBPlQDlrYMstUvMTOeBcF361gucQgg==
X-Received: by 2002:a05:6a20:d489:b0:1f5:97c3:41b9 with SMTP id
 adf61e73a8af0-2148b018ab8mr4541529637.5.1746629415241; 
 Wed, 07 May 2025 07:50:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7aebdsm11357799b3a.32.2025.05.07.07.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 07:50:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] fpu: Process float_muladd_negate_result after rounding
Date: Wed,  7 May 2025 07:50:13 -0700
Message-ID: <20250507145013.4024038-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Changing the sign before rounding affects the correctness of
the asymmetric rouding modes: float_round_up and float_round_down.

Reported-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c                     | 54 +++++++++++++++++++++++------
 tests/tcg/multiarch/fnmsub.c        | 36 +++++++++++++++++++
 fpu/softfloat-parts.c.inc           |  4 ---
 tests/tcg/multiarch/Makefile.target |  1 +
 4 files changed, 81 insertions(+), 14 deletions(-)
 create mode 100644 tests/tcg/multiarch/fnmsub.c

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 34c962d6bd..8094358c2e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1731,11 +1731,8 @@ static float64 float64_round_pack_canonical(FloatParts64 *p,
     return float64_pack_raw(p);
 }
 
-static float64 float64r32_round_pack_canonical(FloatParts64 *p,
-                                               float_status *s)
+static float64 float64r32_pack_raw(FloatParts64 *p)
 {
-    parts_uncanon(p, s, &float32_params);
-
     /*
      * In parts_uncanon, we placed the fraction for float32 at the lsb.
      * We need to adjust the fraction higher so that the least N bits are
@@ -1776,6 +1773,13 @@ static float64 float64r32_round_pack_canonical(FloatParts64 *p,
     return float64_pack_raw(p);
 }
 
+static float64 float64r32_round_pack_canonical(FloatParts64 *p,
+                                               float_status *s)
+{
+    parts_uncanon(p, s, &float32_params);
+    return float64r32_pack_raw(p);
+}
+
 static void float128_unpack_canonical(FloatParts128 *p, float128 f,
                                       float_status *s)
 {
@@ -2240,7 +2244,12 @@ float16_muladd_scalbn(float16 a, float16 b, float16 c,
     float16_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
-    return float16_round_pack_canonical(pr, status);
+    /* Round before applying negate result. */
+    parts_uncanon(pr, status, &float16_params);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
+        pr->sign ^= 1;
+    }
+    return float16_pack_raw(pr);
 }
 
 float16 float16_muladd(float16 a, float16 b, float16 c,
@@ -2260,7 +2269,12 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
     float32_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
-    return float32_round_pack_canonical(pr, status);
+    /* Round before applying negate result. */
+    parts_uncanon(pr, status, &float32_params);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
+        pr->sign ^= 1;
+    }
+    return float32_pack_raw(pr);
 }
 
 float64 QEMU_SOFTFLOAT_ATTR
@@ -2274,7 +2288,12 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
     float64_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
-    return float64_round_pack_canonical(pr, status);
+    /* Round before applying negate result. */
+    parts_uncanon(pr, status, &float64_params);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
+        pr->sign ^= 1;
+    }
+    return float64_pack_raw(pr);
 }
 
 static bool force_soft_fma;
@@ -2428,7 +2447,12 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     float64_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
-    return float64r32_round_pack_canonical(pr, status);
+    /* Round before applying negate result. */
+    parts_uncanon(pr, status, &float32_params);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
+        pr->sign ^= 1;
+    }
+    return float64r32_pack_raw(pr);
 }
 
 bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
@@ -2441,7 +2465,12 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     bfloat16_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
-    return bfloat16_round_pack_canonical(pr, status);
+    /* Round before applying negate result. */
+    parts_uncanon(pr, status, &bfloat16_params);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
+        pr->sign ^= 1;
+    }
+    return bfloat16_pack_raw(pr);
 }
 
 float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
@@ -2454,7 +2483,12 @@ float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
     float128_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
-    return float128_round_pack_canonical(pr, status);
+    /* Round before applying negate result. */
+    parts_uncanon(pr, status, &float128_params);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
+        pr->sign ^= 1;
+    }
+    return float128_pack_raw(pr);
 }
 
 /*
diff --git a/tests/tcg/multiarch/fnmsub.c b/tests/tcg/multiarch/fnmsub.c
new file mode 100644
index 0000000000..52dc516baf
--- /dev/null
+++ b/tests/tcg/multiarch/fnmsub.c
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <stdio.h>
+#include <math.h>
+#include <fenv.h>
+
+union U {
+  double d;
+  unsigned long long l;
+};
+
+union U x = { .l = 0x4ff0000000000000ULL };
+union U y = { .l = 0x2ff0000000000000ULL };
+union U r;
+
+int main()
+{
+    fesetround(FE_DOWNWARD);
+
+#if defined(__loongarch__)
+    asm("fnmsub.d %0, %1, %1, %2" : "=f"(r.d) : "f"(x.d), "f"(y.d));
+#elif defined(__powerpc64__)
+    asm("fnmsub %0,%1,%1,%2" : "=f"(r.d) : "f"(x.d), "f"(y.d));
+#elif defined(__s390x__) && 0 /* need -march=z14 */
+    asm("vfnms %0,%1,%1,%2,0,3" : "=f"(r.d) : "f"(x.d), "f"(y.d));
+#else
+    r.d = -fma(x.d, x.d, -y.d);
+#endif
+
+    if (r.l == 0xdfefffffffffffffULL) {
+        return 0;
+    }
+
+    printf("r = %.18a (%016llx)\n", r.d, r.l);
+    return 1;
+}
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 171bfd06e3..5e0438fc0b 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -708,10 +708,6 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
  return_normal:
     a->exp += scale;
  finish_sign:
-    if (flags & float_muladd_negate_result) {
-        a->sign ^= 1;
-    }
-
     /*
      * All result types except for "return the default NaN
      * because this is an Invalid Operation" go through here;
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 45c9cfe18c..bfdf7197a7 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -29,6 +29,7 @@ run-float_%: float_%
 	$(call run-test,$<, $(QEMU) $(QEMU_OPTS) $<)
 	$(call conditional-diff-out,$<,$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/$<.ref)
 
+fnmsub: LDFLAGS+=-lm
 
 testthread: LDFLAGS+=-lpthread
 
-- 
2.43.0


