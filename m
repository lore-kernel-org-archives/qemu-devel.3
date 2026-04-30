Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68214CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEum-0006Th-Ii; Wed, 29 Apr 2026 20:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuj-0006No-Fh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuh-0001lh-FU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso193073b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507554; x=1778112354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NNGGFXJ7ObWl7bIfWdwNZWMHdVi1ldGDKtY92ZvWpw=;
 b=qFxIt1shAElGAybW9dlenejbPZNNrc1wrYBJGy1DAiaJemL2LUa7KgVyODTsdxBHgj
 fT+AzHB++wmzdlOXxVfcFfu5AeF479OkHZ/J3nsNq0TZyQEa1+dHi+uE1L66cCx+5yzn
 yHC+klcS17USsJVQ+D3PM/tqllYAvdkindJIHQ3WBP+xQfyQZN1VyVsQA4oFqpUU9ZoJ
 itnNzLBlT2Ht6WfXXfer9ZsgQYT/x2546L1vgmhQSLMlC4ZGIqmOJJOb9J4sy07nn7Uf
 BqK2Ll6c1QM5LoeMahMt4IFt7e/v7sNMIZX7DY9+t3U5jpvTY2GarKwVJfa3RuZJuMDd
 3zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507554; x=1778112354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8NNGGFXJ7ObWl7bIfWdwNZWMHdVi1ldGDKtY92ZvWpw=;
 b=FaTeDFBtYNX9e3kRlXiDA57FBdviFWHRpw53w179Fk/m5AvVmpPIVdG5srlXJAXFoK
 fVspcbOw2h1z/SGFWAMxEPCr7Imge7eh+GAJ9us7UFlUJJgt9ZAuLwL7ZaZwW+aZPEW/
 WuCpvBGnaGtL5s5fupiUoIuqZx1z0Teav0x6UEmQDJKOFVgiVIiaZ7L8K3V14WWqaZVg
 m/CPUYmxF4YSazC3II7Cgq/2/z0YzypEg3g4SRwDLRNtqyRWLas1ioVU6UgJmLC1Ngal
 g37Ki6GJKZTvjCrNBsKTGdJykAfJlGF6jxQMtKPbm3qZW2jmirT+saGHWyGIwOr9oKRy
 VowA==
X-Gm-Message-State: AOJu0Yy7kYMwOfITJ+OIAtAkZytx1i2DtBqSddOTDljt5jNoYKSF4NNa
 7nhnXlSsi+31UMYsDXKhmxyvOQsJse1ztR5p3+0BVYrnyN9SaYJetII4iQv09PoonE8gFoy3dhi
 qZPEyRS8=
X-Gm-Gg: AeBDiesxiRw8KCOaMppCVKtERoJY2Q452uo54W+s1gJ05/LtXnunX7MJ6Vx+fPPLuqF
 8gaHbzk2PHTYvxoJIXhjQD+R3IbqVl/H5W3EF1lYKn8M70aKMc17Zg+T7UsA1Xy5tS8LwjK3pZb
 Oai03oKXxQiAqjP7sYqniU4UsV5YfPALaCDbBQqKhB55UyqjpIUs+AcejHds6yYIcl5MhvKjJ5S
 70J3aBWKDDnILWbhqU9/iPt3TGOyBM2oCczJvTH3f0G6ml8GLP4UyIVwYa/VJsUiSezhRz4ZASf
 O69VG354DoGaWfIkUBN3uDTroJf3Ayv0DXFJ6D6E+Carc8oN2ZMSRuJP7AKvYrwmwz48i+4wLtV
 UCjmWuNmIjnPDdQ/cXH/H0hrFWP1ALI5LvMI06n0fiv9e8DZeGT6e8MDCBKGk4rJHY8VOabyAOA
 rB2SjFjIeJhSzkprCLmTO7smO6ujt9D2g2bzdeWERa
X-Received: by 2002:a05:6a00:2e88:b0:82c:9126:31f1 with SMTP id
 d2e1a72fcca58-834fdb5bdd3mr794215b3a.14.1777507553852; 
 Wed, 29 Apr 2026 17:05:53 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 11/40] fpu: Export unpack_canonical and
 round_pack_canonical routines
Date: Thu, 30 Apr 2026 10:04:54 +1000
Message-ID: <20260430000524.56046-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Export the unpacking and repacking into the various formats.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h | 30 ++++++++++++++++++++++
 fpu/softfloat.c               | 47 ++++++++++++++---------------------
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index a3ae12bb45..f631c38c79 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -133,4 +133,34 @@ typedef struct {
     uint64_t frac_lo;
 } FloatParts128;
 
+/*
+ * Unpack routines from a specific floating-point format.
+ */
+
+FloatParts64 float4_e2m1_unpack_canonical(float4_e2m1 f, float_status *s);
+FloatParts64 float8_e4m3_unpack_canonical(float8_e4m3 f, float_status *s);
+FloatParts64 float8_e5m2_unpack_canonical(float8_e5m2 f, float_status *s);
+FloatParts64 float16_unpack_canonical(float16 f, float_status *s);
+FloatParts64 bfloat16_unpack_canonical(bfloat16 f, float_status *s);
+FloatParts64 float32_unpack_canonical(float32 f, float_status *s);
+FloatParts64 float64_unpack_canonical(float64 f, float_status *s);
+FloatParts128 float128_unpack_canonical(float128 f, float_status *s);
+/* Returns false if the encoding is invalid. */
+bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f, float_status *s);
+
+/*
+ * Pack routines to a specific floating-point format.
+ */
+
+float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p, float_status *s,
+                                             bool saturate);
+float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p, float_status *s,
+                                             bool saturate);
+float16 float16_round_pack_canonical(FloatParts64 *p, float_status *s);
+bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p, float_status *s);
+float32 float32_round_pack_canonical(FloatParts64 *p, float_status *s);
+float64 float64_round_pack_canonical(FloatParts64 *p, float_status *s);
+float128 float128_round_pack_canonical(FloatParts128 *p, float_status *s);
+floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s);
+
 #endif
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d3277e3f60..b857c13d91 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1296,21 +1296,21 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
-static FloatParts64 float4_e2m1_unpack_canonical(float4_e2m1 f, float_status *s)
+FloatParts64 float4_e2m1_unpack_canonical(float4_e2m1 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&float4_e2m1_params, f);
     parts64_canonicalize(&p, s, &float4_e2m1_params);
     return p;
 }
 
-static FloatParts64 float8_e4m3_unpack_canonical(float8_e4m3 f, float_status *s)
+FloatParts64 float8_e4m3_unpack_canonical(float8_e4m3 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&float8_e4m3_params, f);
     parts64_canonicalize(&p, s, &float8_e4m3_params);
     return p;
 }
 
-static FloatParts64 float8_e5m2_unpack_canonical(float8_e5m2 f, float_status *s)
+FloatParts64 float8_e5m2_unpack_canonical(float8_e5m2 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&float8_e5m2_params, f);
     parts64_canonicalize(&p, s, &float8_e5m2_params);
@@ -1325,29 +1325,27 @@ static FloatParts64 float16a_unpack_canonical(float16 f, float_status *s,
     return p;
 }
 
-static FloatParts64 float16_unpack_canonical(float16 f, float_status *s)
+FloatParts64 float16_unpack_canonical(float16 f, float_status *s)
 {
     return float16a_unpack_canonical(f, s, &float16_params);
 }
 
-static FloatParts64 bfloat16_unpack_canonical(bfloat16 f, float_status *s)
+FloatParts64 bfloat16_unpack_canonical(bfloat16 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&bfloat16_params, f);
     parts64_canonicalize(&p, s, &bfloat16_params);
     return p;
 }
 
-static float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p,
-                                                    float_status *s,
-                                                    bool saturate)
+float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p, float_status *s,
+                                             bool saturate)
 {
     parts64_uncanon(p, s, &float8_e4m3_params, saturate);
     return pack_raw64(p, &float8_e4m3_params);
 }
 
-static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
-                                                    float_status *s,
-                                                    bool saturate)
+float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p, float_status *s,
+                                             bool saturate)
 {
     parts64_uncanon(p, s, &float8_e5m2_params, saturate);
     return pack_raw64(p, &float8_e5m2_params);
@@ -1361,42 +1359,38 @@ static float16 float16a_round_pack_canonical(FloatParts64 *p,
     return pack_raw64(p, &float16_params);
 }
 
-static float16 float16_round_pack_canonical(FloatParts64 *p,
-                                            float_status *s)
+float16 float16_round_pack_canonical(FloatParts64 *p, float_status *s)
 {
     return float16a_round_pack_canonical(p, s, &float16_params);
 }
 
-static bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p,
-                                              float_status *s)
+bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p, float_status *s)
 {
     parts64_uncanon(p, s, &bfloat16_params, false);
     return pack_raw64(p, &bfloat16_params);
 }
 
-static FloatParts64 float32_unpack_canonical(float32 f, float_status *s)
+FloatParts64 float32_unpack_canonical(float32 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&float32_params, f);
     parts64_canonicalize(&p, s, &float32_params);
     return p;
 }
 
-static float32 float32_round_pack_canonical(FloatParts64 *p,
-                                            float_status *s)
+float32 float32_round_pack_canonical(FloatParts64 *p, float_status *s)
 {
     parts64_uncanon(p, s, &float32_params, false);
     return pack_raw64(p, &float32_params);
 }
 
-static FloatParts64 float64_unpack_canonical(float64 f, float_status *s)
+FloatParts64 float64_unpack_canonical(float64 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&float64_params, f);
     parts64_canonicalize(&p, s, &float64_params);
     return p;
 }
 
-static float64 float64_round_pack_canonical(FloatParts64 *p,
-                                            float_status *s)
+float64 float64_round_pack_canonical(FloatParts64 *p, float_status *s)
 {
     parts64_uncanon(p, s, &float64_params, false);
     return pack_raw64(p, &float64_params);
@@ -1451,23 +1445,21 @@ static float64 float64r32_round_pack_canonical(FloatParts64 *p,
     return float64r32_pack_raw(p);
 }
 
-static FloatParts128 float128_unpack_canonical(float128 f, float_status *s)
+FloatParts128 float128_unpack_canonical(float128 f, float_status *s)
 {
     FloatParts128 p = float128_unpack_raw(f);
     parts128_canonicalize(&p, s, &float128_params);
     return p;
 }
 
-static float128 float128_round_pack_canonical(FloatParts128 *p,
-                                              float_status *s)
+float128 float128_round_pack_canonical(FloatParts128 *p, float_status *s)
 {
     parts128_uncanon(p, s, &float128_params, false);
     return float128_pack_raw(p);
 }
 
 /* Returns false if the encoding is invalid. */
-static bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f,
-                                      float_status *s)
+bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f, float_status *s)
 {
     /* Ensure rounding precision is set before beginning. */
     switch (s->floatx80_rounding_precision) {
@@ -1503,8 +1495,7 @@ static bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f,
     return true;
 }
 
-static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
-                                              float_status *s)
+floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s)
 {
     const FloatFmt *fmt = &floatx80_params[s->floatx80_rounding_precision];
     uint64_t frac;
-- 
2.43.0


