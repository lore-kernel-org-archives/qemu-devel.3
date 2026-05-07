Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4770CD3447
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EO-0004Xb-2n; Thu, 07 May 2026 12:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EL-0004Vt-2G
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:41 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EH-0006ok-RL
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:40 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dbd23bc684so658549a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169936; x=1778774736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ox8Ftrrwl5FOenMz5UHZ2+9nQwQi749aQXGpa+1QyV4=;
 b=c8YsnOds8FLWuZ3ivnqXYvcwUMqjUKTeh6MNPt4quDviwSa+x8BUdWS37YQtHgmDOe
 /+ODcEIbbjHWT93+mn7a8OixevDlBuOgvfKEs/kOVxn6UI/BoNZLt+waEgB1fuSI5Oqf
 yyuOYdG3RoD1O5+2MLtPbfxudgHJ6OdRzw90iToAzSL7g9oXwSvGTn8Dzpz7TFFPgxP8
 DLHQ+BtnVij6bllmkS+VB/VzcaQdqcMZ8xk4Ztu8bu+k1gBd0gGu8VXNGCuzNdfBAc/I
 OdUtTk0DAQY73B/0KxcCmNUx1lvoJCN+wpmKuld+rxKTShx69uvw+Z1le+dzxfA2juCk
 zDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169936; x=1778774736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ox8Ftrrwl5FOenMz5UHZ2+9nQwQi749aQXGpa+1QyV4=;
 b=pu2ycm99s22SrpNEMhKVYjpwsqz4isVdpwhl8OvBErM5+Ooh8Uvmj8DjyU4e1PPhqn
 xHw7hQ2rdENVZJ4H6FBZCWZm4f493fkEohe+2inwEB8lR8Y4ab07bL9ze15B5A1yc5ms
 Cl8LxtITtGTTi84JD9DBBT9/IGagzo3fQzgbHfD/q6uvNytsiN0B2V8aWEaNp//9RFPl
 nlGIcTq4OfR76IETceKT1h42Z4h3FbM3ysiR78JRgzvk+sopP/vWM1HJivR3jM+2xQjb
 Zh7kQqnJcjOlH1INK3wk+VfnqO7YT7FTphOZD5ai88NOCykwE87KNDn+3DHD5kIERloX
 BWnw==
X-Gm-Message-State: AOJu0YyI6KFKhgscRmrK/ijf3ne/Jb+wlFe629FsHo32p/f/YxWhSQGw
 9s9LwXs8i8W150ltplMbm658g01nB8NCpg3OWI2I1gAHUnfeIX8YZADrlNeXUXXGGy2AKNOSW0e
 nR4kh
X-Gm-Gg: AeBDieswmANDA5MyM90copcEaMse0a7D1XEHBS4tntx+vn5rKPmgrHV07/EUCODyNeE
 Lu8DNJq9L9ZjrZ21cLyN5l8KaINfNzQ/F4sVpIpx4edyMdbc2I38AwWPii2AFzAs1YGb+FrmgYf
 ouDzZsjDoc0H8fTjhTmRgaZfTM1cS2aB5KLM26yoIV9EE82NTorQ+c8HvDOXu+oq3kEGXB6tYn8
 /LMM33APCVqfKsDhc0ZW0lgIq6/YKJkC72YIqaHU1XWWTy2sARUKkE+2XwkuVdBdS0hcex/Aolw
 4ZsIyBGzWz1hbGjgbYYAzihkI+SapxXqB2nj88zv/hbhsKDHd48YVPj3ETv30184iglTwqF9lhO
 8vDWz0RtMMzqMYSGk57ZNg4/YSTNCD4kJKxqSO7pIfk/CLho1Ma64qSWOzNqaE0QZ+nZi5n47xX
 Z+INq6G0EGdwJKdjTBH6CCvF4MbaZE+tdAh+acQK8S0RbO3A==
X-Received: by 2002:a05:6830:d85:b0:7e1:cbe3:bb1b with SMTP id
 46e09a7af769-7e1dea57df5mr5162140a34.0.1778169936174; 
 Thu, 07 May 2026 09:05:36 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/29] fpu: Return struct from parts{64,128}_silence_nan
Date: Thu,  7 May 2026 11:05:01 -0500
Message-ID: <20260507160518.444797-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


