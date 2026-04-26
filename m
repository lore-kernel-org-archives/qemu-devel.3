Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFB4FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGznx-0005rZ-Ga; Sun, 26 Apr 2026 09:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznZ-0005dW-Dd
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:36 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznW-0001Ky-2S
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:23 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35da01fc0baso5874565a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211121; x=1777815921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91KpAxRphFoJ92UJqSPx0ipa0G5SKbiIfR6fXaE6u/Y=;
 b=GIgoqIAFC5RQvJVZGTSojn3Mxf8pRlEp/HIbyyRIVyep86SCPC4MTzv+jcInzeLVNN
 imGBsoOR4RLk34vEIl+g85smnIHYlfDBji9vEZpVc18ePr5j3FrqG8nzaRcbvhOxfVrD
 hhDP2xDyTADr+F7J9lh7s0kFowgVZJvTE3i7j8HNp6ix9edN5ULe9ibvOYkvBcSJCMF2
 v1xLIFyKpYMGxs8u3GSde+KvwdCYKZmoqVpl5egNOZ2AJIAuQzEQz9LXkQk9pMxNHXgp
 ndDt1P+0+3m7zRautQKZAjF1fYX3BxoboxP8G0N5oH1NBMCuvx2hCT/cjQ2+pm0Tk6pK
 L30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211121; x=1777815921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=91KpAxRphFoJ92UJqSPx0ipa0G5SKbiIfR6fXaE6u/Y=;
 b=eXZ+PmOSkSbOqtjgmeGvvNXE5dG76+ecqD6ra15aYu2UsjSxz+ETaoZky/rEFNXj6O
 Vww9vbpybPQrZ68qpjQ+kTg/fwm+LKe0ajLUciGK3opnEEdDIWblxJcY02DVlxxNXUYv
 lXRDRM21yOXoCkFldvVCqUE63XMLd8S/n9v+jMXnwj9CotRjAQfyP5ZXNYFx7bnPk6rm
 K29aCBWgP11j2ETF3ZAfOuMEikKDfdg3Uw6OIAguV0BE6ags91Kf0m4Q8sb8/U/B9Zmb
 LUn6cCtIing7+NQCYYJitQB2OZEZlCdhIDyaJgziykiGkFL/0hmUagMlDCqWWCr3s3pY
 aqGw==
X-Gm-Message-State: AOJu0YwHkaJMZtpS7xtlPx0nacDMaOZm+Un/NG6q4acTX/IgJkaeUUkK
 bBDKFHdVKLKJW42FrFnFnGSvBY4Xn8doTUDAc8/tVwcWgv88zAlXyBTY7w/s6O4PXI1oDcH5Ml+
 FtmEvRUM=
X-Gm-Gg: AeBDiesoi/LAolBA5pqzhuefk8yy/RY6hYIT33+TrYBL+CcX1x2lmLhiTN+qk5RLNJr
 6VtZlFgalW++qJ4iy6Xw0mahwbC6i1S4hLaRLvs1RmK43MpI79ySnaLod0K5NdYrL0csZpSDS9u
 whn6JSIumf/Isv6Ieyf4R7XM/7mQsOVu2jzE8LqqQAUH57exlzWAbQJarpigFfYJGsoiYSf1Xwl
 ToH9eN4mK5xLxM+vUZtjpSd/jyTex9QB8lnWg+tyy+7/XsUMMVYwM3zKM/eA0fx5h8HsGSR5v7W
 DyHd5SeGH+CDJtgw623v00lsX4wdrV8ZVahbS/9A0E4kFds8THNOoomUtlJSxAcDMY5pHLwUCp/
 /PnU8SQTvnMB7vgciqWcgkDh0sSNkOoldhU3pyYj0LoVnGKz3D23zxa/eS82Cza/asRu1bhX5EX
 Qb3WjfduAD6krX7DYWFvL9Xv3u+xM5fvQpaF5YVz7d
X-Received: by 2002:a17:90b:3e8b:b0:364:6558:99bd with SMTP id
 98e67ed59e1d1-36465589ae7mr3859850a91.23.1777211120546; 
 Sun, 26 Apr 2026 06:45:20 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 48/84] fpu: Change parts_float_to_float_widen to
 parts64_to_parts128
Date: Sun, 26 Apr 2026 23:39:25 +1000
Message-ID: <20260426134002.865628-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Rename and return FloatParts128 structure.
Use switch instead of 2 ifs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 99f0036d0d..5d58caf5ea 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2590,20 +2590,27 @@ static FloatParts64 parts128_to_parts64(FloatParts128 *b, float_status *s)
     return r;
 }
 
-static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
-                                       float_status *s)
+static FloatParts128 parts64_to_parts128(FloatParts64 *b, float_status *s)
 {
-    a->cls = b->cls;
-    a->sign = b->sign;
-    a->exp = b->exp;
-    frac64_widen(a, b);
+    FloatParts128 r = {
+        .cls = b->cls,
+        .sign = b->sign,
+        .exp = b->exp,
+        .frac_hi = b->frac,
+    };
 
-    if (is_nan(a->cls)) {
-        parts128_return_nan(a, s);
-    }
-    if (a->cls == float_class_denormal) {
+    switch (r.cls) {
+    case float_class_qnan:
+    case float_class_snan:
+        parts128_return_nan(&r, s);
+        break;
+    case float_class_denormal:
         float_raise(float_flag_input_denormal_used, s);
+        break;
+    default:
+        break;
     }
+    return r;
 }
 
 float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
@@ -2791,18 +2798,16 @@ float64 float128_to_float64(float128 a, float_status *s)
 float128 float32_to_float128(float32 a, float_status *s)
 {
     FloatParts64 p64 = float32_unpack_canonical(a, s);
-    FloatParts128 p128;
+    FloatParts128 p128 = parts64_to_parts128(&p64, s);
 
-    parts_float_to_float_widen(&p128, &p64, s);
     return float128_round_pack_canonical(&p128, s);
 }
 
 float128 float64_to_float128(float64 a, float_status *s)
 {
     FloatParts64 p64 = float64_unpack_canonical(a, s);
-    FloatParts128 p128;
+    FloatParts128 p128 = parts64_to_parts128(&p64, s);
 
-    parts_float_to_float_widen(&p128, &p64, s);
     return float128_round_pack_canonical(&p128, s);
 }
 
@@ -2847,18 +2852,16 @@ float128 floatx80_to_float128(floatx80 a, float_status *s)
 floatx80 float32_to_floatx80(float32 a, float_status *s)
 {
     FloatParts64 p64 = float32_unpack_canonical(a, s);
-    FloatParts128 p128;
+    FloatParts128 p128 = parts64_to_parts128(&p64, s);
 
-    parts_float_to_float_widen(&p128, &p64, s);
     return floatx80_round_pack_canonical(&p128, s);
 }
 
 floatx80 float64_to_floatx80(float64 a, float_status *s)
 {
     FloatParts64 p64 = float64_unpack_canonical(a, s);
-    FloatParts128 p128;
+    FloatParts128 p128 = parts64_to_parts128(&p64, s);
 
-    parts_float_to_float_widen(&p128, &p64, s);
     return floatx80_round_pack_canonical(&p128, s);
 }
 
-- 
2.43.0


