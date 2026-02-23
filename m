Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A882E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRD8-0002Ka-Fa; Mon, 23 Feb 2026 03:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRD6-0002IW-BZ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:32 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRD4-0008KD-Ln
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:32 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a7d98c1879so26021835ad.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 00:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771834949; x=1772439749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvXQWwSoWNG2h69uqztIMwRPFmzt/DYVgxqvm8Zixf0=;
 b=IT7u75VQrLdf4wPOluIteGcSQEgCqeGT1vH0vDX/2hT0hXwB41aNyjMQjwH2ZLBhzc
 64sZ/iCs3pSZHvWFsPOiNM39AnVbJhfOQ7one1aHAk4luSR44QC084uO+iLRPW0qktgg
 5oJ4INPT/19Yagln/mykTjWbAvM36qd/bpZQ8bEuTlyQzPw6YcYhTE5tV1bOoZtvMJFr
 fu6LOcj/f4ONw1lIhJv6t9SF7PUhQvPBeC6WQJgQHbAOfo0n7BTFKq5wZkQPF8CqZhdO
 CF8YLZ7Bu/aXiC2ao+8lCHMHjGeCBbhV+a1n1jFqfMbCQSeucr43ipvbGKKwCqRobwdx
 Wtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771834949; x=1772439749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qvXQWwSoWNG2h69uqztIMwRPFmzt/DYVgxqvm8Zixf0=;
 b=UeG9FORycDmRn8/hc+67lewV1wFa0Uv18NfRXc0T4qWp8HZlbHYRyNZSHqBbTrkL/n
 RSalPf/yG5c5lruDgeBkLzrn1u3giE6mpyQD5cndYFxGIKpyBaH9jz8aa3/wHDMTqSJx
 Cm81czLG96XxpNaJ3/L7uQ1j1rivnfyWbdwr3HDoygjrZoDeMtrVHBlWH7SS/Go3+cSS
 rf3ziKdvEl/4qm7/vygMi5SEMiL2USWDX4yWThddZjKKuRBWy7dHbq57EwqkbCHh2HkF
 USCuZlrTDQ5g6jZbdlfeg1O29//P2Wf2qs3v+B1LhxxajENuckukFII1dPIEvXtaqepz
 5OeA==
X-Gm-Message-State: AOJu0YyK8L8A0TVFXfZIaNG3Lfvhir8a9uG0D/RckQm1WYdxaue5MSuI
 HPwXaC5uuBM8sa8W6x7AlQNsfyShZd0rz2nNw1Fp1sQl2rVObsOYTB+B282+65UCGBG+SiepPEG
 Zp8gJov4=
X-Gm-Gg: ATEYQzygA3YcLxeqtLr4aaeuydoZReXGpUFDspM7ZUhjt+y/hC3sCZvXgorpc1uc7zX
 GHw4sKHCBKUDtWdHV/7nbJY1G+7l11fKjoxDcgm/SfbotTtE6iSWmfSPM2n7b8uTJQC83HSpWs5
 5p83m3pQYOpiz02wb//resbDFFSsAkqNeLGOvmTpUiMnDACaFvMGH8WAA++4x+l5hXAUkHrGkyu
 Q8iQHZkUp/VUGpiiXD58PpT586E2twEt5mVPspyQugk1Io3I+FgQadUMiIrJQi3nH+mgjyyph0h
 y7hQ+w5YXnrQIZO96efGTMwz5r6h+OxuZguBi4pNhfeWu3VvRFm/nqWu8U83pVawFGLBAggw2m0
 8IDwmg80tPdaYS6sprj1+9WmoGDoxVCMh02Nr2VcJYMLrdrwkn6uvazEX9DPmQWFuDaABoyQsc7
 wXm0qP+TiKzqWitG7MkAq0BMFXFuUXZ1cUvzQ7IjJ543rrePcs+x47hQtZpnBnxmuvRw==
X-Received: by 2002:a17:903:1b6f:b0:2aa:d672:3be with SMTP id
 d9443c01a7336-2ad74595c07mr80286525ad.52.1771834949065; 
 Mon, 23 Feb 2026 00:22:29 -0800 (PST)
Received: from stoup.. (123-243-199-74.static.tpgi.com.au. [123.243.199.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f5dd7asm86543625ad.28.2026.02.23.00.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 00:22:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com,
	chao.liu.zevorn@gmail.com
Subject: [PATCH v5 7/9] fpu: Add conversion routines for OCP FP8 E5M2
Date: Mon, 23 Feb 2026 19:21:52 +1100
Message-ID: <20260223082154.5623-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223082154.5623-1-richard.henderson@linaro.org>
References: <20260223082154.5623-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Max Chou <max.chou@sifive.com>

Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Split out of a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h |  5 +++
 include/fpu/softfloat.h       |  8 ++++
 fpu/softfloat.c               | 85 +++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 8f82fdfc97..be7e2de6e3 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -119,6 +119,11 @@ typedef struct {
  */
 typedef uint16_t bfloat16;
 
+/*
+ * Open Compute Project (OCP) Microscaling Formats
+ */
+typedef uint8_t float8_e5m2;
+
 /*
  * Software IEC/IEEE floating-point underflow tininess-detection mode.
  */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 69b9041ef0..4385462992 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -189,6 +189,14 @@ float128 int128_to_float128(Int128, float_status *status);
 float128 uint64_to_float128(uint64_t, float_status *status);
 float128 uint128_to_float128(Int128, float_status *status);
 
+/*----------------------------------------------------------------------------
+| OCP FP8 conversion routines.
+*----------------------------------------------------------------------------*/
+
+bfloat16 float8_e5m2_to_bfloat16(float8_e5m2, float_status *status);
+float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, bool sat, float_status *status);
+float8_e5m2 float32_to_float8_e5m2(float32, bool sat, float_status *status);
+
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b3c4104854..0dc769283d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -572,6 +572,10 @@ typedef struct {
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
+static const FloatFmt float8_e5m2_params = {
+    FLOAT_PARAMS(5, 2)
+};
+
 static const FloatFmt float16_params = {
     FLOAT_PARAMS(5, 10)
 };
@@ -627,6 +631,11 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
     };
 }
 
+static void QEMU_FLATTEN float8_e5m2_unpack_raw(FloatParts64 *p, float8_e5m2 f)
+{
+    unpack_raw64(p, &float8_e5m2_params, f);
+}
+
 static void QEMU_FLATTEN float16_unpack_raw(FloatParts64 *p, float16 f)
 {
     unpack_raw64(p, &float16_params, f);
@@ -684,6 +693,11 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
+static float8_e5m2 QEMU_FLATTEN float8_e5m2_pack_raw(const FloatParts64 *p)
+{
+    return pack_raw64(p, &float8_e5m2_params);
+}
+
 static float16 QEMU_FLATTEN float16_pack_raw(const FloatParts64 *p)
 {
     return make_float16(pack_raw64(p, &float16_params));
@@ -1675,6 +1689,13 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
+static void float8_e5m2_unpack_canonical(FloatParts64 *p, float8_e5m2 f,
+                                         float_status *s)
+{
+    float8_e5m2_unpack_raw(p, f);
+    parts_canonicalize(p, s, &float8_e5m2_params);
+}
+
 static void float16a_unpack_canonical(FloatParts64 *p, float16 f,
                                       float_status *s, const FloatFmt *params)
 {
@@ -1695,6 +1716,14 @@ static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
     parts_canonicalize(p, s, &bfloat16_params);
 }
 
+static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
+                                                    float_status *s,
+                                                    bool saturate)
+{
+    parts_uncanon(p, s, &float8_e5m2_params, saturate);
+    return float8_e5m2_pack_raw(p);
+}
+
 static float16 float16a_round_pack_canonical(FloatParts64 *p,
                                              float_status *s,
                                              const FloatFmt *params)
@@ -2772,6 +2801,35 @@ static void parts_float_to_ahp(FloatParts64 *a, float_status *s)
     }
 }
 
+static void parts_float_to_e5m2(FloatParts64 *a, float_status *s, bool saturate)
+{
+    switch (a->cls) {
+    case float_class_snan:
+    case float_class_qnan:
+        parts_return_nan(a, s);
+        break;
+
+    case float_class_inf:
+        /* Per OCP, conversion in SATURATE mode bounds Inf to MAX. */
+        if (saturate) {
+            a->cls = float_class_normal;
+            a->exp = float8_e5m2_params.exp_max - 1;
+            a->frac = MAKE_64BIT_MASK(float8_e5m2_params.frac_shift,
+                                      float8_e5m2_params.frac_size + 1);
+        }
+        break;
+
+    case float_class_denormal:
+        float_raise(float_flag_input_denormal_used, s);
+        break;
+    case float_class_normal:
+    case float_class_zero:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void parts64_float_to_float(FloatParts64 *a, float_status *s)
 {
     if (is_nan(a->cls)) {
@@ -2836,6 +2894,15 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     }
 }
 
+bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float8_e5m2_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return bfloat16_round_pack_canonical(&p, s);
+}
+
 float32 float16_to_float32(float16 a, bool ieee, float_status *s)
 {
     const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
@@ -2856,6 +2923,15 @@ float64 float16_to_float64(float16 a, bool ieee, float_status *s)
     return float64_round_pack_canonical(&p, s);
 }
 
+float8_e5m2 float32_to_float8_e5m2(float32 a, bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    float32_unpack_canonical(&p, a, s);
+    parts_float_to_e5m2(&p, s, saturate);
+    return float8_e5m2_round_pack_canonical(&p, s, saturate);
+}
+
 float16 float32_to_float16(float32 a, bool ieee, float_status *s)
 {
     FloatParts64 p;
@@ -2923,6 +2999,15 @@ float32 float64_to_float32(float64 a, float_status *s)
     return float32_round_pack_canonical(&p, s);
 }
 
+float8_e5m2 bfloat16_to_float8_e5m2(bfloat16 a, bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    bfloat16_unpack_canonical(&p, a, s);
+    parts_float_to_e5m2(&p, s, saturate);
+    return float8_e5m2_round_pack_canonical(&p, s, saturate);
+}
+
 float32 bfloat16_to_float32(bfloat16 a, float_status *s)
 {
     FloatParts64 p;
-- 
2.43.0


