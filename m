Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171AAE8B39C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHK-0007O2-Rz; Wed, 04 Feb 2026 00:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHJ-0007Lz-JM
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:13 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHH-0007np-0E
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:13 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-8230d228372so219069b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182290; x=1770787090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1r7TljzV5N4sqNZuIAysMozbrBxFdSAmX++0Au0cYo=;
 b=SirKWYZGSmpu4lad+G6R3bMnN0+74NdkKp3rrvww6TfnPzPS77PcbsdLM8Knh+M0+L
 Bt2pubeouHzk4myP4OC/F+pm9oq1WyJ1Z8JC4aUcbFVYIcN0x/+EAcbPEg+amZXdls4s
 UiUD3ioA7UnxwcjvSlgYPh9bKHRC8J5HTs+rBcKBnfZBbqjdwlJDev5rtWq+632B11Wb
 hBkozDhYrNBHA1PjLTuSGwhYBPuyM3uU++8Uw1V9qODQAr31XrY1bgHVHeyf1e8bdJya
 1Hc1BDSLtcTQ2LFcNwzXusdCqwFqeCQ+vD825vkqxrtj+LkVI6bRoZ3u1cem+P990Csf
 aQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182290; x=1770787090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c1r7TljzV5N4sqNZuIAysMozbrBxFdSAmX++0Au0cYo=;
 b=Fnq3SovI21tyGRqdmRU0QaJ23MDov0mb1Jv20u5TvmdUtGmkJ9J6psKHudNoHyBDI1
 T7nPOvIw5jJ8SADsJxQMPKpHpCe7JjbSyLJcVwsVUPLcfhgd9wbtyWzt+yZ5d5mO2UPA
 fbo2n69lqRLOJfnUK42qFo8t0GaKAbq4bnSDXbJQC3VYhAoBhZe7OA4u2yh0HxYxsBxZ
 veBmEdtxdBuYJoz8ZKfY1gptLQ+PIu5S/U0CZrlTPCzWLfaylgU89RkHrXJr9T5m7hQp
 2yfccccphL0mfm0yiYCzpLpAIo341iKd3ERrmW3jYmJkqN0LxrbdLNtWTybHYtmmxZv1
 kmDg==
X-Gm-Message-State: AOJu0YxHxIQdFQb4+u3f3n8gn8dcl7+mn9w6D5TsBXqfn+cZpPWi+wtc
 6OfjXAQ63p61HdTURG19btsl2G0dfCeUl3qy67HXW2ODkB/71aWb2Af68E5ekBnI90uwvhzFhoe
 MzS3UDCb5D1FbUibmKzkZ/DftWTox5JYVet/Qhbs1/xyILOpuzU0xQw6+mlTd5UD1bcfFvuTcOK
 gEBD+4oMTvfByoVrGR5qoLvozpp1jZ7gdZJjjqEJTozDiRZRY=
X-Gm-Gg: AZuq6aIgCKeiFY76p3dqPtAt42IicLGHd95cRu9tPhlt7oURxpYzzPmP87pJooMS5x6
 MYqAyG9rvsDCDUYocttPKfKklZhjjCW4wIAAdk4cItrOP+nwsnsEnRJ+UBpTdIzUNzC2eo/nHVC
 151vNxV1J8MFeM5rJ1ieDOtukm5Z37ISHo9SsNgVX/qvqxyGREB8BUfRrTzH0JKVvDeDmbRwI3j
 1f33gq/XQkqg2/KtKaAGLJefM6UR6BXO/kevVENhhTK1AGjJlN49/MSuU+qJGy29rFBFbCfR8wZ
 xEbJ7ZImBKKb1fWFEENyUhHLMLT+3YLTbe3AaYQv/55gaIrAdJc21p9y97X+4FqS1+JQ25/Mx/T
 lE3LMgXzk2TJ2h+HWXWjrKzU8KGhsYOsgxjEhg7iDmjK5fyaN6riqnUCHm8Xj8VylmXeXO4JQWZ
 6yAvKZWTOe/NYNSyXaBr52++ExhUU6ZV2cht8TI54w7txfLi8s2X1s/J/7h2/Ou076RN2lwZwsl
 69HX2YtMLMKW9mIWXrUEWC1IQ==
X-Received: by 2002:a05:6a21:4d92:b0:363:b976:8f79 with SMTP id
 adf61e73a8af0-393723e9e71mr1810172637.43.1770182289454; 
 Tue, 03 Feb 2026 21:18:09 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:09 -0800 (PST)
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
Subject: [PATCH v3 02/19] fpu/softfloat: Refactor IEEE format NaN
 classification to share code
Date: Wed,  4 Feb 2026 13:17:38 +0800
Message-ID: <20260204051756.667397-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x441.google.com
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

The floatN_is_[quiet|signaling]_nan functions for following formats
(float16, bfloat16, float32, float64, float128) contain duplicated
logic that should be shared.
This commit introduces
[float16|bfloat16|float32|float64|float128]_nan_is_snan that determine
if a NaN is signaling.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat-specialize.c.inc | 176 ++++++++++++++-------------------
 1 file changed, 72 insertions(+), 104 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ba4fa08b7b..7d2515c1fa 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -227,42 +227,26 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
 }
 
 /*----------------------------------------------------------------------------
-| Returns 1 if the half-precision floating-point value `a' is a quiet
-| NaN; otherwise returns 0.
+| Determine if a float16 NaN is signaling NaN.
 *----------------------------------------------------------------------------*/
 
-bool float16_is_quiet_nan(float16 a_, float_status *status)
+static bool float16_nan_is_snan(float16 a, float_status *status)
 {
     if (no_signaling_nans(status)) {
-        return float16_is_any_nan(a_);
-    } else {
-        uint16_t a = float16_val(a_);
-        if (snan_bit_is_one(status)) {
-            return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
-        } else {
-
-            return ((a >> 9) & 0x3F) == 0x3F;
-        }
+        return false;
     }
+    bool frac_msb_is_one = (a >> 9) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
-| Returns 1 if the bfloat16 value `a' is a quiet
+| Returns 1 if the half-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-bool bfloat16_is_quiet_nan(bfloat16 a_, float_status *status)
+bool float16_is_quiet_nan(float16 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return bfloat16_is_any_nan(a_);
-    } else {
-        uint16_t a = a_;
-        if (snan_bit_is_one(status)) {
-            return (((a >> 6) & 0x1FF) == 0x1FE) && (a & 0x3F);
-        } else {
-            return ((a >> 6) & 0x1FF) == 0x1FF;
-        }
-    }
+    return float16_is_any_nan(a_) && !float16_nan_is_snan(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -271,36 +255,52 @@ bool bfloat16_is_quiet_nan(bfloat16 a_, float_status *status)
 *----------------------------------------------------------------------------*/
 
 bool float16_is_signaling_nan(float16 a_, float_status *status)
+{
+    return float16_is_any_nan(a_) && float16_nan_is_snan(a_, status);
+}
+
+/*----------------------------------------------------------------------------
+| Determine if a bfloat16 NaN is signaling NaN.
+*----------------------------------------------------------------------------*/
+
+static bool bfloat16_nan_is_snan(bfloat16 a, float_status *status)
 {
     if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint16_t a = float16_val(a_);
-        if (snan_bit_is_one(status)) {
-            return ((a >> 9) & 0x3F) == 0x3F;
-        } else {
-            return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
-        }
+        return false;
     }
+    bool frac_msb_is_one = (a >> 6) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
-| Returns 1 if the bfloat16 value `a' is a signaling
-| NaN; otherwise returns 0.
+| Returns 1 if the bfloat16 value `a' is a quiet NaN; otherwise returns 0.
+*----------------------------------------------------------------------------*/
+
+bool bfloat16_is_quiet_nan(bfloat16 a_, float_status *status)
+{
+    return bfloat16_is_any_nan(a_) && !bfloat16_nan_is_snan(a_, status);
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the bfloat16 value `a' is a signaling NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
 bool bfloat16_is_signaling_nan(bfloat16 a_, float_status *status)
+{
+    return bfloat16_is_any_nan(a_) && bfloat16_nan_is_snan(a_, status);
+}
+
+/*----------------------------------------------------------------------------
+| Determine if a float32 NaN is signaling NaN.
+*----------------------------------------------------------------------------*/
+
+static bool float32_nan_is_snan(float32 a, float_status *status)
 {
     if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint16_t a = a_;
-        if (snan_bit_is_one(status)) {
-            return ((a >> 6) & 0x1FF) == 0x1FF;
-        } else {
-            return (((a >> 6) & 0x1FF) == 0x1FE) && (a & 0x3F);
-        }
+        return false;
     }
+    bool frac_msb_is_one = (a >> 22) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
@@ -310,16 +310,7 @@ bool bfloat16_is_signaling_nan(bfloat16 a_, float_status *status)
 
 bool float32_is_quiet_nan(float32 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return float32_is_any_nan(a_);
-    } else {
-        uint32_t a = float32_val(a_);
-        if (snan_bit_is_one(status)) {
-            return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
-        } else {
-            return ((uint32_t)(a << 1) >= 0xFF800000);
-        }
-    }
+    return float32_is_any_nan(a_) && !float32_nan_is_snan(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -328,17 +319,21 @@ bool float32_is_quiet_nan(float32 a_, float_status *status)
 *----------------------------------------------------------------------------*/
 
 bool float32_is_signaling_nan(float32 a_, float_status *status)
+{
+    return float32_is_any_nan(a_) && float32_nan_is_snan(a_, status);
+}
+
+/*----------------------------------------------------------------------------
+| Determine if a float64 NaN is signaling NaN.
+*----------------------------------------------------------------------------*/
+
+static bool float64_nan_is_snan(float64 a, float_status *status)
 {
     if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint32_t a = float32_val(a_);
-        if (snan_bit_is_one(status)) {
-            return ((uint32_t)(a << 1) >= 0xFF800000);
-        } else {
-            return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
-        }
+        return false;
     }
+    bool frac_msb_is_one = (a >> 51) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
@@ -348,17 +343,7 @@ bool float32_is_signaling_nan(float32 a_, float_status *status)
 
 bool float64_is_quiet_nan(float64 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return float64_is_any_nan(a_);
-    } else {
-        uint64_t a = float64_val(a_);
-        if (snan_bit_is_one(status)) {
-            return (((a >> 51) & 0xFFF) == 0xFFE)
-                && (a & 0x0007FFFFFFFFFFFFULL);
-        } else {
-            return ((a << 1) >= 0xFFF0000000000000ULL);
-        }
-    }
+    return float64_is_any_nan(a_) && !float64_nan_is_snan(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -368,17 +353,7 @@ bool float64_is_quiet_nan(float64 a_, float_status *status)
 
 bool float64_is_signaling_nan(float64 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint64_t a = float64_val(a_);
-        if (snan_bit_is_one(status)) {
-            return ((a << 1) >= 0xFFF0000000000000ULL);
-        } else {
-            return (((a >> 51) & 0xFFF) == 0xFFE)
-                && (a & UINT64_C(0x0007FFFFFFFFFFFF));
-        }
-    }
+    return float64_is_any_nan(a_) && float64_nan_is_snan(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -444,6 +419,19 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
     return a;
 }
 
+/*----------------------------------------------------------------------------
+| Determine if a float128 NaN is signaling NaN.
+*----------------------------------------------------------------------------*/
+
+static bool float128_nan_is_snan(float128 a, float_status *status)
+{
+    if (no_signaling_nans(status)) {
+        return false;
+    }
+    bool frac_msb_is_one = (a.high >> 47) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
+}
+
 /*----------------------------------------------------------------------------
 | Returns 1 if the quadruple-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
@@ -451,17 +439,7 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 
 bool float128_is_quiet_nan(float128 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return float128_is_any_nan(a);
-    } else {
-        if (snan_bit_is_one(status)) {
-            return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
-                && (a.low || (a.high & 0x00007FFFFFFFFFFFULL));
-        } else {
-            return ((a.high << 1) >= 0xFFFF000000000000ULL)
-                && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
-        }
-    }
+    return float128_is_any_nan(a) && !float128_nan_is_snan(a, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -471,15 +449,5 @@ bool float128_is_quiet_nan(float128 a, float_status *status)
 
 bool float128_is_signaling_nan(float128 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        if (snan_bit_is_one(status)) {
-            return ((a.high << 1) >= 0xFFFF000000000000ULL)
-                && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
-        } else {
-            return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
-                && (a.low || (a.high & UINT64_C(0x00007FFFFFFFFFFF)));
-        }
-    }
+    return float128_is_any_nan(a) && float128_nan_is_snan(a, status);
 }
-- 
2.52.0


