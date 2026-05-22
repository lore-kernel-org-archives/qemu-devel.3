Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E806CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUbE-0005Qi-TL; Fri, 22 May 2026 14:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbC-0005Hy-Ab
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:54 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbA-0005ae-Gw
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2bea7176c72so17029805ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474471; x=1780079271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdCiAeyqDTXuK52kfIqalebuIdHOX+3Sh4uzHDXmhFg=;
 b=MY3AtajjYlnjgFvLg9y5Th7It0llw2zF0fEcHtdYkulH6GrloYWJSoSh0HONwNdXrq
 q8iDe92qg7K+vZXzW68s6lBEDJukvS53oyECcA50bnfMOlbpI9FcXB/JBoAjxjBxgWrm
 dLKZsGP8G8PZHMCZDmf3FGtGllzOr3Ael+dOANg752JVvIbRrE5ijlBEQPdxenu+QR7G
 FQ0P/awYq9GSBuNSqNs7on2ojjjZO578ESBYfmXDkVJuQb4kAArwq1xkM1QuNFvoujt3
 l1Qk0Zr83DP6ehlZgaxJAmWYcpoAlSvXQxvhxGuA1l72JiaEgHalJT+YtJSipDwNKkQI
 QZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474471; x=1780079271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rdCiAeyqDTXuK52kfIqalebuIdHOX+3Sh4uzHDXmhFg=;
 b=WALSvEI1/cO3zOxyyiX3dtgQ2VPK1P8Mx4kfzwLu4O+zIBeOCzryweEiJ+w6usIxfm
 /zRxGmJyvMmYZ9QH6Nq/dM7z9V4fwNbXwniDP+t2yafv9pOlJO4r1MApv98MXFh1Mgu6
 1ZVwc2walJSfAU2h8ep9m9JV2+jBYpzyaFmTaGNLE+Avlv+iK80nyKFgzmqPjP+ZJH3l
 JUSul2H0kSzu6PfHvuEmYOuHFePVRFibhKq0K7IKiiRYT10dCGn8OxI6qcDoz9RmmNPw
 1DDmw3D0u2O1F0vg3AQKZs2L03A+CQPzdtmKMirZkQKkUm/amUMDXdrdowLCp1S5HKLN
 y61Q==
X-Gm-Message-State: AOJu0YzEG/BkvXHlVziSuxGVLWL/NKcAqsoNKEZzmHYz1UEfL/03DTtw
 cLm+y3WS2cDPg+0jaboL7h4CxhayG7XinKbefpDuskx2mA1N8aDsbVEbL28UeFtmGDukrHScC0G
 aBIh9
X-Gm-Gg: Acq92OG/KYceN0SkhhQeVxfpJZewdmClB8UxBbAT3fmEEB2LXBRwaaPADQpK1qkh4Ft
 khu3b5mltKFaS8zKbMnKkWpf5yEfsZ6uoYRqANzyb52Rwo0raCEGRVI4CNDu+Owb4UdAClNq5am
 QVDU/a1dkM15jhz25lLU1ZejGam+lNhDRPVGHfaVxCjrLNZwiAhK3XD1yIoBS4WKaVDdFYwk4vJ
 Iq5hSE2DS9f2RJCjePwa7425o/llC9c1sSHineqc1FgU1s8FbKU9Hq6Ls6zdUACXTuTNuRcZm54
 8EWP8FXTj2A1TaqdEmxmsKfSetyCUftJ7DvtpBjN31oaLeR2b6JeKn0GFO/AH9qRWKdHnSeLLae
 7lrBAHjiUQFLouNLPry81iX0mWAgy3liufaxpFbKtRBPZXi3fx9yDC/Wi/dRwEnEzrVfc7X45ns
 SkZlbt8mBDy+fkgIIOesE38B4lZEFbXN5b6jw9HsY=
X-Received: by 2002:a17:903:2bcc:b0:2bc:b80f:677e with SMTP id
 d9443c01a7336-2beb069970bmr49630525ad.25.1779474471005; 
 Fri, 22 May 2026 11:27:51 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/30] fpu: Add accessors for rebias_{underflow,overflow}
Date: Fri, 22 May 2026 11:26:54 -0700
Message-ID: <20260522182658.184604-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 include/fpu/softfloat-helpers.h | 10 ++++++++++
 target/ppc/cpu.c                |  4 ++--
 fpu/softfloat-parts.c.inc       |  4 ++--
 fpu/softfloat-specialize.c.inc  | 10 ++++++++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 49e04ffee9..4791a7fc87 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -131,6 +131,16 @@ static inline void set_snan_rule(FloatSNaNRule val, float_status *status)
     status->float_snan_rule = val;
 }
 
+static inline void set_float_rebias_overflow(bool val, float_status *status)
+{
+    status->rebias_overflow = val;
+}
+
+static inline void set_float_rebias_underflow(bool val, float_status *status)
+{
+    status->rebias_underflow = val;
+}
+
 static inline FloatRoundMode get_float_rounding_mode(const float_status *status)
 {
     return status->float_rounding_mode;
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 4d8faaddee..41edb18643 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -248,8 +248,8 @@ void ppc_store_fpscr(CPUPPCState *env, target_ulong val)
         val |= FP_FEX;
     }
     env->fpscr = val;
-    env->fp_status.rebias_overflow  = (FP_OE & env->fpscr) ? true : false;
-    env->fp_status.rebias_underflow = (FP_UE & env->fpscr) ? true : false;
+    set_float_rebias_overflow(FP_OE & env->fpscr, &env->fp_status);
+    set_float_rebias_underflow(FP_UE & env->fpscr, &env->fp_status);
     if (tcg_enabled()) {
         fpscr_set_rounding_mode(env);
     }
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index bef47a932d..184614ea47 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -358,7 +358,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             switch (fmt->exp_max_kind) {
             case float_expmax_ieee:
                 flags |= float_flag_overflow;
-                if (s->rebias_overflow) {
+                if (get_float_rebias_overflow(s)) {
                     exp -= fmt->exp_re_bias;
                 } else if (overflow_norm) {
                     flags |= float_flag_inexact;
@@ -398,7 +398,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             }
         }
         fracN(shr)(p, frac_shift);
-    } else if (unlikely(s->rebias_underflow)) {
+    } else if (unlikely(get_float_rebias_underflow(s))) {
         flags |= float_flag_underflow;
         exp += fmt->exp_re_bias;
         if (p->frac_lo & round_mask) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index c1ed661f5e..b97c971ae6 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -94,6 +94,16 @@ static inline uint8_t get_float_default_nan_pattern(const float_status *status)
     return status->default_nan_pattern;
 }
 
+static inline bool get_float_rebias_overflow(const float_status *status)
+{
+    return status->rebias_overflow;
+}
+
+static inline bool get_float_rebias_underflow(const float_status *status)
+{
+    return status->rebias_underflow;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
-- 
2.43.0


