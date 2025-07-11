Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58063C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHSj-0001jb-3x; Fri, 11 Jul 2025 13:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSh-0001ge-0O
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:03 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSe-0002zS-5H
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:02 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40aef72f252so718698b6e.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752254579; x=1752859379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4bSMi3Nc0BLTJTdgmUkBHkPEiCcYcFpM0gdgLBlkKo=;
 b=RWg79fR5C7maHQ/SLuglI5rk46/iJtdhZYJ+Lc6czslJX6Drzo5GTYmFw06uvBE7Mq
 xOnXHyYMGR/zwFbY7B59VRsKuT+kH/f2a51kNidN2p1n1jDAJDYUN6mWql2wJNlMhck/
 og5unExO/PJ6l4cLBWFpXV7nFdAqxj9Yre2WLhXmYrvFXQFivBeP1UqxR5GhukkakLBo
 IsiPYL0XbkiuDou1Ujcf8TLFLjjcQc3vWwQQP2qJs1ND8fAwwLHWQNZHf9AaGL69le3+
 KUj3xObt+UIUXrwdG339O4vy+7FOCFO5aYfhQljOIWhEvFFs1R/dRNzdxi1MIYR4AnwX
 gnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254579; x=1752859379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4bSMi3Nc0BLTJTdgmUkBHkPEiCcYcFpM0gdgLBlkKo=;
 b=HhNjyal1V+y7djd8n+f8n9qGqDbdGMjhfTa9U0cQI02fQpXE8ZqPrcbu4qh8TFmZJd
 4VgkfALb+L0aL4Wj5nNOPRogi6QSiCjSHqfme7mOT1ODmARNLcUulk737T0g5rS6t1jk
 TGXQoRUGIdD7jzhe4jrx2R8YqQaC//SUTaKKc9weO/sOIenDefBbKibzGzTwzHfWogfC
 VmeY6vaftRamvRu2YEJjCgMUEZ6rAblBuLOGB9y39ivCjUrIVcgjgNUO2HW6ElutR9I0
 zvnxZbM2OT4K2KEMPLpDkxPS5j+YAZUey0FcyjF0AQwE5yGsnKZsK7gE55dL2FcryJHX
 cw4g==
X-Gm-Message-State: AOJu0Ywbwt1ParD0UMPxFiUa1uGp/PCKnCxZg+xCUQ8xGwvb2+zOZZXP
 f+gQehluIwpepmBukLXFdKqSeE9PYl3rolnqqG81bBhdf8fvz7LqukNYfYU4fRlCdrGn+Eg2lrG
 Yq9ID4CA=
X-Gm-Gg: ASbGncvZmLGPCHrmAp5Zu82l5ZBKRlQ2V/sHADdDkMq94oKXBK07UNDx3dVLr9N6VHB
 NTD0oJ+dML7gFQaybNEJz/0Atft9mSb8A8Mq8rA54Q6Y4uqu4mAcdsjarxxbu4ueoiWsKi5cwoA
 XeOoklf1B6DVOe6qOrQfTezm+QqG86/0SNVUoGnOMpM0D30eEhUlbgCTquMCuChASkrhvbOqfgr
 80TkS6Ko/SW7qt943Om7vNaPMk6xaijdsJr+tPSsbQ5KdEW6fr4ZX0UqumQr4sqFN1+VLyWMY3A
 LRrqgv3LE+iJdUiMWObuFFNwEAcgdmRIDXAe5BtmmnazFiyxnVg4HR5FvOOFAu1VxLf0SrzejI3
 LpbAuRNRXag6NRudxM2EeaUu5lUmvW5/VZbzlgnfq+yTTY8OiTOqi8kJkn3bWn/QneKGT0BsG7i
 FjNHBuErk5kcnQ9QvF3N4=
X-Google-Smtp-Source: AGHT+IHAYV5GrI+8/SU6OSnjlp8tsfE83mcXb72e6vGL95FOllWtqP1+KhScS7iW4u/dWcab89JuwA==
X-Received: by 2002:a05:6808:1483:b0:408:e711:9aa with SMTP id
 5614622812f47-4151008211bmr3271568b6e.37.1752254578622; 
 Fri, 11 Jul 2025 10:22:58 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c77ada0sm602041b6e.44.2025.07.11.10.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:22:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: WANG Rui <wangrui@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/9] fpu: Process float_muladd_negate_result after rounding
Date: Fri, 11 Jul 2025 11:22:46 -0600
Message-ID: <20250711172254.229201-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711172254.229201-1-richard.henderson@linaro.org>
References: <20250711172254.229201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c                     | 54 +++++++++++++++++++++++------
 tests/tcg/multiarch/fnmsub.c        | 37 ++++++++++++++++++++
 fpu/softfloat-parts.c.inc           |  4 ---
 tests/tcg/multiarch/Makefile.target |  1 +
 4 files changed, 82 insertions(+), 14 deletions(-)
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
index 0000000000..15dd41d3bd
--- /dev/null
+++ b/tests/tcg/multiarch/fnmsub.c
@@ -0,0 +1,37 @@
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
+#ifdef FE_DOWNWARD
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
+    if (r.l != 0xdfefffffffffffffULL) {
+        printf("r = %.18a (%016llx)\n", r.d, r.l);
+        return 1;
+    }
+#endif
+    return 0;
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


