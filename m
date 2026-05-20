Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E01CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZ2-0001Mm-F8; Wed, 20 May 2026 13:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYs-0001J9-Pl
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:26 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYq-0001sM-AU
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:25 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36a35e4eefeso421933a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297503; x=1779902303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/kDXd23+ycS383PGeIrgHSsrr0fsby8WIj0IEq0o18=;
 b=guMiDFAhSnBL1Vc+fN+1Xd0BXDtknzQRzxOxoMl/H4Yp6Bd76RcfRvbZl/dlGsgWUY
 gi75IQQjwekxsI2Zp2LWqWFh5PN6iBcSlZnRiLmfzsuc85iQJUThTp6yUeW41L9EloYD
 8ZdrVH+oSSkAngAFiCGs9ZVB1B8MRQSDsdn6lBcg7DVg9fX+okltSJrb92DDLHGRIzvz
 BBkEhgucw0fHwub1tVlqbf5rPmGzG9l91qsYoMYVAr3B9eKVtOvHRDMrdqs1Kk0O+ujz
 xRyN9o9f6r9DzSYmfFNy3y5Lg4BVOUXGQSAJucg516PwfS55In0HYszpqd1LsGKbTLdG
 oM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297503; x=1779902303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u/kDXd23+ycS383PGeIrgHSsrr0fsby8WIj0IEq0o18=;
 b=fzrCuSExCOJtu4T6s9x7fqyccAfKJTcTHO9vpPlGY7dA6FFxXboTQM/1sY/q8+ayPI
 TjMlR4pU+S13LUmesiu625ja23qli9V3B4mJda1GJJF0/7suTLbvZBF2UrV0dzV1OAbC
 KGL1c7ZYw4QRybgf9nMCZFBFBzAopsO47SGb1ngvMzBIiLApgvbZwp1Mv23/C6xuXfGD
 ILimWLAWeHaVQYgAb+4tx/UQ305HKAr/noO1uQErodajntTZj0BqMkfoZefT42HydP+g
 JMxGHJPOJUykDLOs3RhTX/dN9TF9tpOcf20k+8P6HuReTaO8suau+Dt42cF8Gv9TMkLI
 ACHg==
X-Gm-Message-State: AOJu0Yx4rFQgyaKarZQc/wqTmoRxF0HlG6vwgfiTdUdAPV1j3mjehNai
 VYkMy85J7yNiugeDUbeJmFgz0Tcc12tZXCXxCrWI1JuRe/cSMU08omWMJvH6XWLCQedLGneWP+W
 ZpDwtphc=
X-Gm-Gg: Acq92OHhSeVmr82prvQUQyRzXHa/gv/8jvup+ccdMpAv60YXBypQmozybbsZgwJUtEd
 Fo2yttM1H6Z5L+hczIKKXEy9XD67E+MnhulCHSdzXTY9TAg/Ik1bEFDQFl19IddQXVAwTd8whE4
 OIDupeVLHRZQd35aisWhXbyKowAzyBP/w0Nl7rweAbtXgplsVT/F8bT03CzqmTrafUpHa/pFYwf
 UvkYoJY5xTyBV2FN2e1zoMaHEGr5EUq48j4RWrUbRHYIcIB43N/DEF7HktzWuQnpzIXjEIC0s9m
 Yj2VCTAAfrFZorMkeOs00r0RSlRCyBWtq1Dqk5hQYgZydDDo0fU8HfR/tYDVprCIkjxbFpCpcZB
 pPJvKXPKWY6muzLMgWQeAw51ZaT9PLxw2nRhp6EVivyVg/L7vf1XhYSpZN8hXMbwfD8zqOfNWuB
 kkoCzBph3RfHg5t6bfled1rABl/T69
X-Received: by 2002:a17:90b:5848:b0:35f:b714:e516 with SMTP id
 98e67ed59e1d1-36951a66993mr24337396a91.16.1779297502661; 
 Wed, 20 May 2026 10:18:22 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 01/30] fpu: Return struct from parts{64,128}_scalbn
Date: Wed, 20 May 2026 10:17:51 -0700
Message-ID: <20260520171820.848839-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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


