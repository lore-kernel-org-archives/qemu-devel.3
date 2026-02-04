Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3861E8B39C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHW-0007VK-IH; Wed, 04 Feb 2026 00:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHV-0007Uk-RJ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:25 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHU-0007ze-9y
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:25 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c6541e35fc0so3688619a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182303; x=1770787103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6pYUSDGgB96lm6vsH7hMSPjVW1YtZoXl+6sWn1elII=;
 b=BTD6eZx7bArugqPCPRB72pFF+IQ4lRI8HrGvpx3u8HNAosj96RUhR+q/xi1H2QTWi5
 9u3U4so2D6BbelRRqq5R5D/ozPVEznTPV+yWI4dwxXRWImdOMKR66drOEThY1PeboYqw
 UcEoCxUs2L+Rq9/LlQf3+G8mo0lgM8/IETlzq6rJZgFhQEoCTWF9sKBgOWfcFXOd/kfU
 QZsq2kLe5c5MGHQFJn1bCJKUMRcJg8974lKsVC06sOcQTTdRbEDcc9EPzXyQF2HrXmp5
 VvauHIGtkg7VZpHVmsaXwXQHsiOY4WInAEQXO8rcDhy/iNyigx+sS3OZ+oS9piBmuzYr
 A9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182303; x=1770787103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J6pYUSDGgB96lm6vsH7hMSPjVW1YtZoXl+6sWn1elII=;
 b=ReKqwfeYQWo4WXZ0cauD3SNeb8LB2aLo/zTe/pZTYkdTVMGcff5dr3je7k10TKzVxu
 HGSyL+ZiMtmXFF/qwpeB7f/FGji2fft1rnsmH5DXG05tMaHB1oUzOKvjzIB9ChD/KNBB
 +dHaa2W/mpn9t0vSfCxBgzCWelzG7BBjNdrSPkKhxHdoJa/ABEAQYIFaiz7MWdV6dLQq
 elWd2Sy70MSrQPbcmW0LtbzId7RQzuq+7e9GPumi8ziuo2BbwZYESnVCHu55+Zri7xGa
 PFZGjyP4DnzHHTHoJ6pjK+Rh6ygL8uK4iEeAlDLKc0DYwfMxVca5oE6kfkCxZrtDET1R
 zNSQ==
X-Gm-Message-State: AOJu0YzYPn3J9rILaOPoJvP8a6daqeslYtQo2ecsPvYch7ogmG36dlHM
 hhi1b/az/VMEok5piLvzUQXI2SyX/PfWnJDGM3u6dk5PJICBxKO5lo7xSDBqTb0ex7PhZCjjGRC
 vsNJhf62qIt8CZ46rAZxmSF6lsOlcmDgZAV3Z3UrGwAYh1+INwzPGBKJK1jhuhCCVutaCq1Dwi5
 Ubcl7IHdgd4kBxKTsDXB9/wwEm/9mL9xMivvZPnK0kTEOs
X-Gm-Gg: AZuq6aKOgdWu5XsJWOoFzH+VPaN/bjlhDgfj8PtpjZqcNzyPg2E2qtbrFLcDStpejro
 mWE+b88sgbgemlTN4zSSmE9yYYbKTvfJ8f9VHGJgYZWqyEymYe88v4MssPDzmH8kvX5kbbgc/wy
 jyyUByQcIy9NB/W+84Nzg88+Jki164bPGPtoU2ZnqmCVR6GRIIgbSZJ90fqupP3DkZgCN/xPLjX
 ezZecQjjLDrIyrRHta4CL49nFjj8MRb67hYWopz7c/ocstzCeoIr3ydCRntQCB6tQ95BTyLUeqC
 JVc3pZwISPnFWF1WY6Y9W6LEqFu0QnKG4KmBeEtwISCXoGVOdybzznfVFW0QwUKsf+Nec5W6YMB
 XbRVedqa0YQP4J+q4bbk8M7nST3K8Lsw/G60Wxj8TdFCCOl5YzKgk9TXQ90l/j0aAIcSTnXApRN
 ONS79i1LqZ2NLTtKDw5gQI2rILgXN4jnPzvNY0CzuzQCC69R78mh1slVG/P6notUiz/aljsBtzt
 UcTDGO8uUJ+MbM=
X-Received: by 2002:a05:6a21:112:b0:38e:676a:f31 with SMTP id
 adf61e73a8af0-393720f1037mr1802328637.25.1770182302853; 
 Tue, 03 Feb 2026 21:18:22 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:20 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 06/19] fpu/softfloat: Support OCP(Open Compute Project)
 OFP4 data type
Date: Wed,  4 Feb 2026 13:17:42 +0800
Message-ID: <20260204051756.667397-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This commit provides the basic operation support for the OCP float4 data
type(e2m1).

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat.c               | 29 +++++++++++++++++++++++
 include/fpu/softfloat-types.h |  5 ++++
 include/fpu/softfloat.h       | 43 +++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 533f96dcda..96845e86df 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -595,6 +595,13 @@ static inline bool fmt_has_nan_encoding(const FloatFmt *fmt)
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
+static const FloatFmt float4_e2m1_params = {
+    FLOAT_PARAMS(2, 1),
+    .no_infinity = true,
+    .limited_nan = true,
+    .normal_frac_max = NORMAL_FRAC_MAX_ALL,
+};
+
 static const FloatFmt float8_e4m3_params = {
     FLOAT_PARAMS(4, 3),
     .no_infinity = true,
@@ -663,6 +670,11 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
     };
 }
 
+static void QEMU_FLATTEN float4_e2m1_unpack_raw(FloatParts64 *p, float4_e2m1 f)
+{
+    unpack_raw64(p, &float4_e2m1_params, f);
+}
+
 static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
 {
     unpack_raw64(p, &float8_e4m3_params, f);
@@ -1745,6 +1757,13 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
+static void float4_e2m1_unpack_canonical(FloatParts64 *p, float4_e2m1 f,
+                                       float_status *s)
+{
+    float4_e2m1_unpack_raw(p, f);
+    parts_canonicalize(p, s, &float4_e2m1_params);
+}
+
 static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
                                          float_status *s)
 {
@@ -2938,6 +2957,16 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     }
 }
 
+float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float4_e2m1_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+
+    return float8_e4m3_round_pack_canonical(&p, s, &float8_e4m3_params, false);
+}
+
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
 {
     FloatParts64 p;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index b781bf10b7..f8cadffff4 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -131,6 +131,11 @@ typedef uint8_t float8_e5m2;
 #define const_float8_e4m3(x) (x)
 #define const_float8_e5m2(x) (x)
 
+typedef uint8_t float4_e2m1;
+#define float4_e2m1_val(x) ((x) & 0xf)
+#define make_float4_e2m1(x) ((x) & 0xf)
+#define const_float4_e2m1(x) ((x) & 0xf)
+
 /*
  * Software IEC/IEEE floating-point underflow tininess-detection mode.
  */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 7abbf92b7e..888efed288 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -200,6 +200,8 @@ float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, bool saturate, float_status *statu
 float8_e4m3 float32_to_float8_e4m3(float32, bool saturate, float_status *status);
 float8_e5m2 float32_to_float8_e5m2(float32, bool saturate, float_status *status);
 
+float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1, float_status *status);
+
 /*----------------------------------------------------------------------------
 | Software OCP operations.
 *----------------------------------------------------------------------------*/
@@ -270,6 +272,47 @@ static inline bool float8_e5m2_is_normal(float8_e5m2 a)
     return (((float8_e5m2_val(a) >> 2) + 1) & 0x1f) >= 2;
 }
 
+static inline bool float4_e2m1_is_quiet_nan(float4_e2m1 a, float_status *status)
+{
+    return false;
+}
+
+static inline bool float4_e2m1_is_signaling_nan(float4_e2m1 a, float_status *status)
+{
+    return false;
+}
+
+static inline bool float4_e2m1_is_any_nan(float4_e2m1 a)
+{
+    return false;
+}
+
+static inline bool float4_e2m1_is_neg(float4_e2m1 a)
+{
+    return float4_e2m1_val(a) >> 3;
+}
+
+static inline bool float4_e2m1_is_infinity(float4_e2m1 a)
+{
+    return false;
+}
+
+static inline bool float4_e2m1_is_zero(float4_e2m1 a)
+{
+    return (float4_e2m1_val(a) & 0x7) == 0;
+}
+
+static inline bool float4_e2m1_is_zero_or_denormal(float4_e2m1 a)
+{
+    return (float4_e2m1_val(a) & 0x6) == 0;
+}
+
+static inline bool float4_e2m1_is_normal(float4_e2m1 a)
+{
+    uint8_t em = float4_e2m1_val(a) & 0x7;
+    return em >= 0x2 && em <= 0x7;
+}
+
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
 *----------------------------------------------------------------------------*/
-- 
2.52.0


