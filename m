Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE54FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEv0-0007LT-Ul; Wed, 29 Apr 2026 20:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuy-0007CK-U3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:13 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEux-0001oe-62
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:12 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so266168b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507570; x=1778112370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSvlZGQiAWrIdEA2H7tknqWIVgUz9Yz+IiSwcs8ZnIo=;
 b=GCmEJrR5saq4z5qctCvVpafH10OUl7LCeDxXcUU75GFY62VoGw5mfj+yHHIEK6hU8q
 f9sEam3KBYgFFJSpe/i4lIPMMDgUcCrzvse+XvdWpV+OjoT/j68sInmorSIzqZjrcIUq
 YSmWWIJnwBPDy0UiOUmdWhfGwsaYssvugTsYMgSr+RjoGU9mUS0JHxBCbbxVbP3MRrAj
 4lLqlSaG3TZiUeGvdKxMul7LuoI58fLOooccy5Rq517+sI/9Yb9wWV7gwk0j1rGraSZa
 AWfV0UQRxMA12icXqjTRY4kaVVBbMv1g9q2W2VdADjaEJQ3UWHSWXoH1Z1B4UPrBAs79
 uoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507570; x=1778112370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JSvlZGQiAWrIdEA2H7tknqWIVgUz9Yz+IiSwcs8ZnIo=;
 b=tVn8U5+Dz+u/bqyK209wFhZREmFZcnqSSRBAmxEw4wiCYd3685eRTlfG2PI0SZ1AAh
 NealsmA2l0QKZTJCJllDjFRAtidS5fj46876J0yXy4dVGx8q7H2FmQtk1tLd2kDif2S2
 J0BbNZWzw+/VQYOeRKos/ekpAbAzW9WdBEFISA1WEYLiRftDofvRYygd2/i1HlaS7ysq
 lSDVx340D8HLPxYsci3XOw7FLpwSjP03k2/WKCuAm1ciT5gnTTULb5q0rn3XCcAFr9Vg
 MuqYll0yIirfMIAjHxVjWrEmgZ777CHabH4p1vZBCFWv8h2kL4LxY63BioPA9+llJaOJ
 3MxQ==
X-Gm-Message-State: AOJu0YzVYSLQRDyTSNI2/lGJUqgYH2X42x8z9sGPSHyBIO5qC6OI4yWP
 mhpynUiX5mVKhL8gU3dUb/PSaDLO4cSmxb9g5PH5Idr9i5VpaPuxv+DwrtqOryVF2kdu0aYQ/FC
 l0wtiSZ0=
X-Gm-Gg: AeBDieuVjRs6+oJrVNvmXr0g4TEIKR3J+eYXfLhbRwJxNMTSu3OkfRhBPeNPkf2C6iC
 DfFWuAspxBE801o+BWuwmQrIVSseZgS5ERidRCNUATd+YALl+Er9NxMVt2bp/spPy/fSNErUK7Y
 9QIFPPMIs44wBhaRovV12Y9JOyrTnjVYmuql9smGbOn7lC4TAno2xAeOShPpVrGQEwdV+KO4i6s
 9TqaWfFBD8QdImR50iNjlDz0wjGSOkjBsx1ZwA8mlEM14i8VTBJI2IFibuiTRndZ1qh3XB40yki
 Wik4lZzl27ct3efMDYb2zK/1LCgR+y625tJxz0Vkzigsxa565lx5inlwxJpFNijARcVWUJj82SA
 JoQBumKAE/NJ4TTePqOaLCupgHjSpDkomzR11FUqPfBHHbzydNSxv2LRJw7nBWAMYRgYNhsErH0
 vLRwQEHxKG5EYWgL1p6M8gMotEIhLbUlEvUsTcAn6A
X-Received: by 2002:a05:6a00:a113:b0:827:2a07:231d with SMTP id
 d2e1a72fcca58-834fdb4058cmr800006b3a.17.1777507569784; 
 Wed, 29 Apr 2026 17:06:09 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 18/40] fpu: Return struct from parts{64,128}_round_to_int
Date: Thu, 30 Apr 2026 10:05:01 +1000
Message-ID: <20260430000524.56046-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  9 +++++++++
 fpu/softfloat.c               | 19 ++++++++++++-------
 fpu/softfloat-parts.c.inc     | 17 ++++++++++-------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 44e0cb7d05..1329bc4d2f 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -172,4 +172,13 @@ FloatParts64 parts64_div(const FloatParts64 *a, const FloatParts64 *b,
 FloatParts128 parts128_div(const FloatParts128 *a, const FloatParts128 *b,
                            float_status *s);
 
+FloatParts64 parts64_round_to_int(const FloatParts64 *a,
+                                  FloatRoundMode rmode,
+                                  int scale, float_status *s,
+                                  const FloatFmt *fmt);
+FloatParts128 parts128_round_to_int(const FloatParts128 *a,
+                                    FloatRoundMode rmode,
+                                    int scale, float_status *s,
+                                    const FloatFmt *fmt);
+
 #endif
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6d69b61c7f..b71bd49483 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2738,7 +2738,8 @@ float16 float16_round_to_int(float16 a, float_status *s)
 {
     FloatParts64 p = float16_unpack_canonical(a, s);
 
-    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float16_params);
+    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+                             &float16_params);
     return float16_round_pack_canonical(&p, s);
 }
 
@@ -2746,7 +2747,8 @@ float32 float32_round_to_int(float32 a, float_status *s)
 {
     FloatParts64 p = float32_unpack_canonical(a, s);
 
-    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float32_params);
+    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+                             &float32_params);
     return float32_round_pack_canonical(&p, s);
 }
 
@@ -2754,7 +2756,8 @@ float64 float64_round_to_int(float64 a, float_status *s)
 {
     FloatParts64 p = float64_unpack_canonical(a, s);
 
-    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float64_params);
+    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+                             &float64_params);
     return float64_round_pack_canonical(&p, s);
 }
 
@@ -2762,7 +2765,8 @@ bfloat16 bfloat16_round_to_int(bfloat16 a, float_status *s)
 {
     FloatParts64 p = bfloat16_unpack_canonical(a, s);
 
-    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &bfloat16_params);
+    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+                             &bfloat16_params);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -2770,7 +2774,8 @@ float128 float128_round_to_int(float128 a, float_status *s)
 {
     FloatParts128 p = float128_unpack_canonical(a, s);
 
-    parts128_round_to_int(&p, s->float_rounding_mode, 0, s, &float128_params);
+    p = parts128_round_to_int(&p, s->float_rounding_mode, 0, s,
+                              &float128_params);
     return float128_round_pack_canonical(&p, s);
 }
 
@@ -2782,8 +2787,8 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    parts128_round_to_int(&p, status->float_rounding_mode, 0, status,
-                       &floatx80_params[status->floatx80_rounding_precision]);
+    p = parts128_round_to_int(&p, status->float_rounding_mode, 0, status,
+                              &floatx80_params[status->floatx80_rounding_precision]);
     return floatx80_round_pack_canonical(&p, status);
 }
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 1634160728..1cd0df4159 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1255,24 +1255,27 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
     return true;
 }
 
-static void partsN(round_to_int)(FloatPartsN *a, FloatRoundMode rmode,
+FloatPartsN partsN(round_to_int)(const FloatPartsN *a,
+                                 FloatRoundMode rmode,
                                  int scale, float_status *s,
                                  const FloatFmt *fmt)
 {
     switch (a->cls) {
     case float_class_qnan:
     case float_class_snan:
-        *a = partsN(return_nan)(a, s);
-        break;
+        return partsN(return_nan)(a, s);
     case float_class_zero:
     case float_class_inf:
-        break;
+        return *a;
     case float_class_normal:
     case float_class_denormal:
-        if (partsN(round_to_int_normal)(a, rmode, scale, fmt->frac_size)) {
-            float_raise(float_flag_inexact, s);
+        {
+            FloatPartsN r = *a;
+            if (partsN(round_to_int_normal)(&r, rmode, scale, fmt->frac_size)) {
+                float_raise(float_flag_inexact, s);
+            }
+            return r;
         }
-        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


