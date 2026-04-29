Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C104FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDL1-0008MV-Gy; Wed, 29 Apr 2026 18:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDKz-0008MG-Kv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:24:57 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDKx-0004Ua-M9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:24:57 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso152386a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501494; x=1778106294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5lDpgAOXBUzFANq2kmivMojdKGuG0rbZpEhWheoTfY=;
 b=ftfiIri22rZAoq5GgQhlfqltI1hL9rnASoB+1QPaIg59CCVJqeGb8w7BmGie9SLz4v
 BWSRDm6S70xQUobwFN4Wdq+9qKlMTjK+BE58R1Q2/9AMXNkApdXqhKusHF/zZYYhQkR5
 9AKNZX0BZzbavVzdPXhwJF6apUQ82fLAokAHw5tAKa72DjK8y+Q61iSZsizlbQzVd2ZB
 3HaFmHcmCZPQf5i5eCrrKGCNt2sE0cxV/hRKDTVe16hk/1TtMdkbmFrb9y8jRXZPhi0V
 5WVpvhaNxk6A2FZaNRo1hf2XOiWpgOlbQhBQLjZNaaIEYF2svYmUy5m1e9RLuuexbF+F
 hP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501494; x=1778106294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A5lDpgAOXBUzFANq2kmivMojdKGuG0rbZpEhWheoTfY=;
 b=MIIKgSyH6eROaqdmoxa/8Sml++/bJgAR5FrrIt6tadij4CyEuLfF/tYnaWe/6G7f40
 jokGePeouawZPyr/rho8RVvPF+/cNDo00LER5BMPFf2L9WcAge8C3V2H8T6AwljDbrIN
 7Qd6RuRt8/TldXKV6AH1pKlhzCpsARmHgqR0idv1qK7qaVS1NFWUrW6gTVb1RxOEHMIW
 fgUqBQiGKakXfzG9zV7PYHXxUPnKSWCY5gwM1+LsAEQu81q4EXzrD8HmhXUe1vGi/PTO
 JJTW7KGLFUqrnZzwX+vz0p+gsvgepeTqEMyFsur3mKWBdBYtppP1aUYe3ittIF+wOiJB
 5OQw==
X-Gm-Message-State: AOJu0YyfBh0yk8dfT+rgjArcVnjKlOUl35GK4QjJR80IPQAMy8J9+7HK
 YyuJfa/dX10fR5SAfztI70YB8OKbQHNHNmrleMYtptE8i5rLYIoUU8I2UMPBJl2FJcApkFPEY4G
 C/J1ygZk=
X-Gm-Gg: AeBDietUd16F0wAG5SCpJ1k5Klz5m/K4ulnt+BB+X/UurLG+lwn6rII/WVMXDHsSEup
 BOrh85akgTjUbOTaRPemgAw5U62pPJ8hZW3MxCFA6Z0dT+tYQ8tM81HmBXqUHxAIDt8MfaOGdsq
 m0FKLAJi6EtOrldVauMa2WfFaUYlnYC/UTEIgO2xGDAp6WCELWWuytwkSOMmuyVuc9GAN+cOuqW
 awQ1Du9gjoPXCliwsJJnejsq3rNSnBuRIYh3udcebMzL7va8jcYgcM5jNl0xTzpkQ6OENvMHbxW
 tl2kGns8wW6iKNfovxMuxVNR8MAcPnBUvo1lIsUoKOU+70SQJN2lXmfy9kukPevpTfvtt4YmEPy
 DDVcD0LCTCAZlvcJXfrUN1eMQ5OziQy3pu6xRx0ktv3IDSI14qIHWaHO1t94zIvjbgMH08M2JVk
 61CXuTGT6ltPIP+B2SVdtxRClvV6Xw04XhEpSaLvP2
X-Received: by 2002:a17:90b:56ce:b0:364:a497:dc45 with SMTP id
 98e67ed59e1d1-364c2daaccemr211358a91.0.1777501494017; 
 Wed, 29 Apr 2026 15:24:54 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:24:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/48] fpu: Drop parts_canonicalize
Date: Thu, 30 Apr 2026 08:23:58 +1000
Message-ID: <20260429222445.26301-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Use the specific parts{64,12}_canonicalize at each site.
Drop the forward declarations.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


