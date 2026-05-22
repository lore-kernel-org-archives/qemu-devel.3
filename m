Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAF1CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUaU-0004Yx-3E; Fri, 22 May 2026 14:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUaQ-0004Y9-Fn
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:08 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUaO-0004xM-MQ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b9fcf7c91bso84284485ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474423; x=1780079223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/kDXd23+ycS383PGeIrgHSsrr0fsby8WIj0IEq0o18=;
 b=MMLn56i4EKIf7qsOJ9D2C2K03Zd5U6sxPlYIQG3kLb1q4I05ZJrFDlgq51FKkCdyiP
 Yh5Q71H9+AGnCppGFYktOzspm2JVsnzay6Ejnj8A0786tseUhrjc1Q7AfwFJtEDR9K4u
 qViP8eMdpXQO76keD1XZx+Fqx31ngtFoZRC6qgaL+C9IUpSsaclZgmlx1v3a/VYfRc0x
 0TxsQZunY+p07Fk9aWXCBzsyb55D6j5ewY91oSY0CZQK2yEw+L3r2ubm44ug/lhWmrDm
 Z+Be+X+VDX5d+lZtdfRcE3QVOmG8XrKYOVX0VJ4sCXZKA77a4m0Dwp/0V1yle03oQnWp
 VCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474423; x=1780079223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u/kDXd23+ycS383PGeIrgHSsrr0fsby8WIj0IEq0o18=;
 b=BjzOFYUw8FUGTHyOqfRBYrItPj3zlW30d+ok1DwNrE90XeeZJe5GHlPrkRgFRLTZo6
 fuxpQeExjvghrHxz5Ony3g9c0i4nu2kmvA6YiQlS+WwExpmIMIvGlR0OCnEvv9bXOZiA
 i4g1JLidf/WiiFnNsVaz8yCIhBCORuJpO2dRrgKTZY5uvyjVao+kK8gF32j1wo+Rl9K9
 vDwdqMaTy47BWG8EkJgOPfhT8vnD/QLQcQAAWnRo1J3FxN/92K/YmLSUcMs7EaWLmb5L
 hKH4nqsguV1vxwh0UZy6RcLIqu3TC1dsUIxa6sVs/QoSyGTI4vv+Nq94QSS7Q1rhHYN2
 JE6Q==
X-Gm-Message-State: AOJu0YzegLCy622MtYhuI5AFZMUHcljR5G1e8iTXnjjDibRBuYhCL8Q0
 1/cdpi3NNqJdbewy+nboDPVY50aRgzawEludoHLa+xQ4i10VMKzyj1PXwJQHLJkHVtdCN2W0WhQ
 BJNEa
X-Gm-Gg: Acq92OGm24dvYpfaEXL621HsJCrzdVL3lhBWo5TR5nhK96d6NRs32EOpvanW4BdIR7m
 B45IjLyzJyJHraYLMQM3lGeupowXE8uJ6otOMpTXUib0cwbcqfWOOGkjoaXxqtgqEYP5l25qd2P
 gFE+fKqStiLFXrGH+KkVtE8EdEBYtg0AU4fYnDcGYi6xT+gOp2XsyiB/+8zZVFPDizOnle1uOMp
 6jkFNQ5Y4Awt2mLHnn8l4RNFBa+1pU/QbPUdc7Y2pjOle7ZoRA8+mzS6HoaQEASFYxURsz77gTy
 EDArQKCGbA0dCQ1XGEFoqLUOzDyEAVtwHUbhtwYATMSSK+zyWcpu9wuiJOK227O5EV0nDvC7ae6
 gwY/bvH/JmgLmfjoIyycmMD3DCJtkw7F0HSqAiNgenepcfNmA1o/QvA1b7MGxmgf2ffWnhM+8gh
 nTQHmNPEl0l9V8BVgdPEgKw06WVSDW
X-Received: by 2002:a17:902:e885:b0:2bc:e62a:979b with SMTP id
 d9443c01a7336-2beb0699cdemr52513425ad.30.1779474422520; 
 Fri, 22 May 2026 11:27:02 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/30] fpu: Return struct from parts{64,128}_scalbn
Date: Fri, 22 May 2026 11:26:29 -0700
Message-ID: <20260522182658.184604-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

At the same time, export.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  3 +++
 fpu/softfloat.c               | 18 +++++++++---------
 fpu/softfloat-parts.c.inc     | 14 ++++++++------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 9504d0daa0..46618d217e 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -214,4 +214,7 @@ FloatParts128 parts128_round_to_int(const FloatParts128 *a,
 FloatParts64 parts64_round_to_fmt(const FloatParts64 *p, float_status *s,
                                   const FloatFmt *fmt);
 
+FloatParts64 parts64_scalbn(const FloatParts64 *a, int n, float_status *s);
+FloatParts128 parts128_scalbn(const FloatParts128 *a, int n, float_status *s);
+
 #endif
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 90ebd83f69..7fc6df461e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1910,7 +1910,7 @@ float16 float16_muladd_scalbn(float16 a, float16 b, float16 c,
 
     /* Before rounding, scale. */
     if (scale) {
-        parts64_scalbn(pr, scale, status);
+        *pr = parts64_scalbn(pr, scale, status);
     }
     parts64_uncanon(pr, status, &float16_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
@@ -1937,7 +1937,7 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
 
     /* Before rounding, scale. */
     if (scale) {
-        parts64_scalbn(pr, scale, status);
+        *pr = parts64_scalbn(pr, scale, status);
     }
     parts64_uncanon(pr, status, &float32_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
@@ -1958,7 +1958,7 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
 
     /* Before rounding, scale. */
     if (scale) {
-        parts64_scalbn(pr, scale, status);
+        *pr = parts64_scalbn(pr, scale, status);
     }
     parts64_uncanon(pr, status, &float64_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
@@ -4312,7 +4312,7 @@ float16 float16_scalbn(float16 a, int n, float_status *status)
 {
     FloatParts64 p = float16_unpack_canonical(a, status);
 
-    parts64_scalbn(&p, n, status);
+    p = parts64_scalbn(&p, n, status);
     return float16_round_pack_canonical(&p, status);
 }
 
@@ -4320,7 +4320,7 @@ float32 float32_scalbn(float32 a, int n, float_status *status)
 {
     FloatParts64 p = float32_unpack_canonical(a, status);
 
-    parts64_scalbn(&p, n, status);
+    p = parts64_scalbn(&p, n, status);
     return float32_round_pack_canonical(&p, status);
 }
 
@@ -4328,7 +4328,7 @@ float64 float64_scalbn(float64 a, int n, float_status *status)
 {
     FloatParts64 p = float64_unpack_canonical(a, status);
 
-    parts64_scalbn(&p, n, status);
+    p = parts64_scalbn(&p, n, status);
     return float64_round_pack_canonical(&p, status);
 }
 
@@ -4336,7 +4336,7 @@ bfloat16 bfloat16_scalbn(bfloat16 a, int n, float_status *status)
 {
     FloatParts64 p = bfloat16_unpack_canonical(a, status);
 
-    parts64_scalbn(&p, n, status);
+    p = parts64_scalbn(&p, n, status);
     return bfloat16_round_pack_canonical(&p, status);
 }
 
@@ -4344,7 +4344,7 @@ float128 float128_scalbn(float128 a, int n, float_status *status)
 {
     FloatParts128 p = float128_unpack_canonical(a, status);
 
-    parts128_scalbn(&p, n, status);
+    p = parts128_scalbn(&p, n, status);
     return float128_round_pack_canonical(&p, status);
 }
 
@@ -4355,7 +4355,7 @@ floatx80 floatx80_scalbn(floatx80 a, int n, float_status *status)
     if (!floatx80_unpack_canonical(&p, a, status)) {
         return floatx80_default_nan(status);
     }
-    parts128_scalbn(&p, n, status);
+    p = parts128_scalbn(&p, n, status);
     return floatx80_round_pack_canonical(&p, status);
 }
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 2114797aca..3a9c2748cd 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1633,22 +1633,24 @@ FloatRelation partsN(compare)(const FloatPartsN *a, const FloatPartsN *b,
 /*
  * Multiply A by 2 raised to the power N.
  */
-static void partsN(scalbn)(FloatPartsN *a, int n, float_status *s)
+FloatPartsN partsN(scalbn)(const FloatPartsN *a, int n, float_status *s)
 {
     switch (a->cls) {
     case float_class_snan:
     case float_class_qnan:
-        *a = partsN(return_nan)(a, s);
-        break;
+        return partsN(return_nan)(a, s);
     case float_class_zero:
     case float_class_inf:
-        break;
+        return *a;
     case float_class_denormal:
         float_raise(float_flag_input_denormal_used, s);
         /* fall through */
     case float_class_normal:
-        a->exp += MIN(MAX(n, -0x10000), 0x10000);
-        break;
+        {
+            FloatPartsN r = *a;
+            r.exp += MIN(MAX(n, -0x10000), 0x10000);
+            return r;
+        }
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


