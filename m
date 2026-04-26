Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A9EFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpR-0007NB-Qb; Sun, 26 Apr 2026 09:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoG-0005wL-8a
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoC-0001WV-Oj
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2adbfab4501so44256085ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211156; x=1777815956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWJrfKmeP7SU5fQs6ar9lmfrjUnpO5JxKfUBv73woWo=;
 b=E8adwnwhNliTFesxtJvbKqrafhSINE8S6xAk0kFoXqJfUoiHe8NEbVQcCoEXGq+7TI
 9hs54uzsUQcHam7GsSxSZJPreluCygNNB8dYUetslxFVg6bxXAuKoH0WNxgUYIH3U7ZV
 aN9ohAI6TO4LRDzFOAxmyDrudGgpDidstIFuBmjreYzvFyFtftRfr+jaFWMnAfkeMyy9
 RgBq5/fNVZ0l8GchCmEYCKyBBt7HR27gqkPdO8UCFS+tqUPC4AzN/lpv2WOZdtKfFXkt
 //ZV2L3eR7Xk0prHHtqajcCbIUxlseel/lEBy//+U89jTsrlGPJrez0L9Ioq9ITh6LR/
 DLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211156; x=1777815956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wWJrfKmeP7SU5fQs6ar9lmfrjUnpO5JxKfUBv73woWo=;
 b=EPX2Xn1NWbHgopcleQFLcNBZn4zeZ6+jKVjVdhT19qUz1Y+bivp3WZWl0Ouzfmqk98
 2YpkFRWfmzBFILxvjJdl61axZBGb+ypRnyjBU56sLnPx4vxRRtkcmBBZq5PffUv1jlIx
 r2QrnPYdQ67qhsCYrl5Xtb4VMXhrpmMvFPLhKYxjvEjnwXf8/EolMrtjMNqL1pXYacct
 gAxwNcUzCt2f5zwUeuJHOgIKb/s+rS/VNTqUnmeubLc56Nyt7WyjMib3tOFyMlfqg3bT
 rCMmC+Cpiwd0TJV/EmiXGH8JMguRUeFDrItGPeNpaosmVm3uStsyFp9qGsHfEOp6tF/E
 ItxA==
X-Gm-Message-State: AOJu0YwmccMnKx7oy8A2oa8r8ZhhfKr0gHyieSOTLlO6kWGYTRbPRrZi
 U+ursc5IyDviJM8QrqAph+sRYspD7OZRoHcP34RWujKXYO/3SKCQoHQRPRo5ElCO+4g58hRSD2R
 d5UEQzhc=
X-Gm-Gg: AeBDieve9Xe0MDIn3Y1os4flw/WYL02OanJRIGf8xzF9vA0xT7IStglB8vS9o6s/Maq
 ZMS1CF4c0JqJxkhZiPNjzMjHnnqunzsVwXp+hTp9iadvY030y5FB0UI1XAocWb7zWrp1xvkGkPK
 tzrtWyq300Mshugb35fOikJVoMLiNcl/HVS6LhM/gaqlDwQRcgZVkrJORk1PqNs7JgmO009S/tW
 k4hakWEeCCLgrP9/l6nizhHiC9qRUCYD4RUT+xDuRaq5hE1fDbGwiQGDNbB5v8dGS4BoJWVpHvq
 y0L1hH86WjpdCDY/HBVBhb1Gy3/qoygGAOaYu4U8htNo/a4aJqbTPTq5QAoLzrcFaprDIUjchOn
 8Jztt00Es/I42WbEFJYl3a7TMWdQ7BFao/JRCO56+tXgJTRgf1zglGJABnNAiI0yI9TG5uoCq5f
 uHkVVjNvfchsQWnQYCXtqJF1OaxTHkUlOS9sLdny7F
X-Received: by 2002:a17:902:aa06:b0:2b4:6664:97d4 with SMTP id
 d9443c01a7336-2b5f9f83295mr275847935ad.24.1777211155667; 
 Sun, 26 Apr 2026 06:45:55 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 61/84] fpu: Return struct from parts{64,128}_silence_nan
Date: Sun, 26 Apr 2026 23:39:38 +1000
Message-ID: <20260426134002.865628-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 fpu/softfloat.c                | 10 +++++-----
 fpu/softfloat-parts.c.inc      |  6 +++---
 fpu/softfloat-specialize.c.inc | 20 ++++++++++++++------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index fa8913a288..9c1e6fdce4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4634,7 +4634,7 @@ float16 float16_silence_nan(float16 a, float_status *status)
     FloatParts64 p = unpack_raw64(&float16_params, a);
 
     p.frac <<= float16_params.frac_shift;
-    parts64_silence_nan(&p, status);
+    p = parts64_silence_nan(&p, status);
     p.frac >>= float16_params.frac_shift;
     return pack_raw64(&p, &float16_params);
 }
@@ -4644,7 +4644,7 @@ float32 float32_silence_nan(float32 a, float_status *status)
     FloatParts64 p = unpack_raw64(&float32_params, a);
 
     p.frac <<= float32_params.frac_shift;
-    parts64_silence_nan(&p, status);
+    p = parts64_silence_nan(&p, status);
     p.frac >>= float32_params.frac_shift;
     return pack_raw64(&p, &float32_params);
 }
@@ -4654,7 +4654,7 @@ float64 float64_silence_nan(float64 a, float_status *status)
     FloatParts64 p = unpack_raw64(&float64_params, a);
 
     p.frac <<= float64_params.frac_shift;
-    parts64_silence_nan(&p, status);
+    p = parts64_silence_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
     return pack_raw64(&p, &float64_params);
 }
@@ -4664,7 +4664,7 @@ bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
     FloatParts64 p = unpack_raw64(&bfloat16_params, a);
 
     p.frac <<= bfloat16_params.frac_shift;
-    parts64_silence_nan(&p, status);
+    p = parts64_silence_nan(&p, status);
     p.frac >>= bfloat16_params.frac_shift;
     return pack_raw64(&p, &bfloat16_params);
 }
@@ -4674,7 +4674,7 @@ float128 float128_silence_nan(float128 a, float_status *status)
     FloatParts128 p = float128_unpack_raw(a);
 
     frac128_shl(&p, float128_params.frac_shift);
-    parts128_silence_nan(&p, status);
+    p = parts128_silence_nan(&p, status);
     frac128_shr(&p, float128_params.frac_shift);
     return float128_pack_raw(&p);
 }
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index ed7080d886..4733755f35 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -23,7 +23,7 @@ static void partsN(return_nan)(FloatPartsN *a, float_status *s)
         if (s->default_nan_mode) {
             *a = partsN(default_nan)(s);
         } else {
-            partsN(silence_nan)(a, s);
+            *a = partsN(silence_nan)(a, s);
         }
         break;
     case float_class_qnan:
@@ -109,7 +109,7 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        partsN(silence_nan)(ret, s);
+        *ret = partsN(silence_nan)(ret, s);
     }
     return ret;
 }
@@ -179,7 +179,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        partsN(silence_nan)(ret, s);
+        *ret = partsN(silence_nan)(ret, s);
     }
     return ret;
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index dd65432813..2723bf5e61 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -179,16 +179,24 @@ static uint64_t parts_silence_nan_frac(uint64_t frac, float_status *status)
     return frac;
 }
 
-static void parts64_silence_nan(FloatParts64 *p, float_status *status)
+static FloatParts64 parts64_silence_nan(const FloatParts64 *p,
+                                        float_status *status)
 {
-    p->frac = parts_silence_nan_frac(p->frac, status);
-    p->cls = float_class_qnan;
+    FloatParts64 r = *p;
+
+    r.frac = parts_silence_nan_frac(r.frac, status);
+    r.cls = float_class_qnan;
+    return r;
 }
 
-static void parts128_silence_nan(FloatParts128 *p, float_status *status)
+static FloatParts128 parts128_silence_nan(const FloatParts128 *p,
+                                          float_status *status)
 {
-    p->frac_hi = parts_silence_nan_frac(p->frac_hi, status);
-    p->cls = float_class_qnan;
+    FloatParts128 r = *p;
+
+    r.frac_hi = parts_silence_nan_frac(r.frac_hi, status);
+    r.cls = float_class_qnan;
+    return r;
 }
 
 /*----------------------------------------------------------------------------
-- 
2.43.0


