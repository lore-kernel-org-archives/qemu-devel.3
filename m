Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05251FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEur-0006h3-3i; Wed, 29 Apr 2026 20:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEun-0006Zr-RH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEum-0001mP-6l
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:01 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-83177129e28so158489b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507559; x=1778112359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWJrfKmeP7SU5fQs6ar9lmfrjUnpO5JxKfUBv73woWo=;
 b=kok9QKUYCty4WSAnnlToL1tgECkUvtkYo8c5jYwlZKLNdrj0slteMxaQO90971MryH
 VRd2g49iQiFcqnpM+jX3xF1SkVe5bSRPBHu6WtikgmMoxgnHvbja9gqr8ej+M0/zGxdM
 2E2TIsInrHMpVBvcaQmECJdPm7FRgV05Crl2MXtOQJZ8BxFddvDFfLrNR509U/lEvJAG
 TSf9y9ZknlDzNMIBjr6e9Xz+TsqlBEptjwsFtxIiQRSXryhSsl/616XP/UYw5RKe7HLI
 r/nBvOZtctDgXitduC/qKURU9GrcoALRN/Q0tG42jZsotZEXGErGsYGLXQp71GMpM1DN
 Jztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507559; x=1778112359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wWJrfKmeP7SU5fQs6ar9lmfrjUnpO5JxKfUBv73woWo=;
 b=kl9oV0hWrZ/9eUmdhUgMSS2oevVYyEEQOiZkLrAK5spNJ5vmANgmlhG5bAqHpbrCJY
 ioJ4mw6Pk9/KIWD51LhCXVpu177nr+Hq1Cuqmvq4zIZbsjCLmsy4KC0/eVo9pvWx+J/p
 9Gn9Kp2/iP6DMPMGUVGBLAQmUQNVH1pU++p8RZjW7gI6Ijdpak0NPMJJEEa+xtYUTFRt
 1wzQYmUG0FRAHBWSWELj1kswB6NSckmv35k7MSJMzJ3JNZINHEgA8MWBxj2TBgb5pXnf
 KYvZR9UOMSzL9cgsK71+iy9Ta6ifwHwPtc+HrglzUd+rkHs09QpFSoG/j2CT2+OsqPcW
 lXsw==
X-Gm-Message-State: AOJu0Yw7Jndq6tMf1h0b6RTWLwOTIPY7L5TgIl0Cjn3elN8soPHivhuI
 JL/6OV4lSlM8d07KohzvH5Tp0B1RvoIAbQgxGGXYn82KAv9FMEMWODzp3aC8JdULGYhlWUM7MpG
 6l/2zTN8=
X-Gm-Gg: AeBDietDzcZDGgsT8RNfQCgym/YlZH/XxYmZYAmyA00AzHRTvJ3ZcTf6TuJKbA15La0
 tIF8T1+1PBRk+Pmk92REoc7PSObfNbeRX3HyUSOA1Q2ohlP3po2+BNQP0nKseeGYvKIM+/inOQs
 w/VwE+ByhaTBeSFUgvtoQ0VZyWFjaf3bHe2qJyg6NTgjQP5XL0mt41RZbpvh3WB4LFlG+TuPZNn
 soF7Rx5CAMi0uh/QV4JOkQogVJ4N1pkVZ/rNveGmbclAYY94l6/412oZoI0btvT5C51iiVZ7OiX
 H5NLchWeOw+KKTy6m5oQuYib6UTZ2n678K06IbLG/oJFN6wI9OzU7LZUV9nfA9BRConVxkf7OCn
 WfFN5IES2qbM8/9/dnqi7aHFsomUHn3jOVK7jVOboe7LQC982wdOeEujHVhENgHqDbVL37cdZh6
 Q0dAHy3dd0XOJMTEMBUhKL4PyoGODpJLKZNwinwLWp
X-Received: by 2002:a05:6a00:4503:b0:82d:5da9:adbf with SMTP id
 d2e1a72fcca58-834fdccc01fmr870255b3a.41.1777507558546; 
 Wed, 29 Apr 2026 17:05:58 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 13/40] fpu: Return struct from parts{64,128}_silence_nan
Date: Thu, 30 Apr 2026 10:04:56 +1000
Message-ID: <20260430000524.56046-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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


