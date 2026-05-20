Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF04CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkaM-0002Yo-FG; Wed, 20 May 2026 13:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZE-0001a0-G8
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:48 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ7-00020P-NL
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:48 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3680540a6efso2786113a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297520; x=1779902320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdCiAeyqDTXuK52kfIqalebuIdHOX+3Sh4uzHDXmhFg=;
 b=Bd/pvMtWAjdhY8yW3X1wPXwXjr/8koOxG6H5yxPjNeb28oa95XFW2Fv60OdHEmKBpj
 qjMreP1qFCPzTikHXHRc8VzLJm+0o6o7IqnfzzopsHr3wVAdRl4M615AhWDWGGlPI+k5
 vn1kZ2Qn7yHyiFlbdI8k93q/UV6b9E1MojGeu1nU4+BGkXEk8iH/Im0zSHIJc9wDzag2
 GAOEmjUL+wwTOCsOEfOFLe+EaMibE+kgNCNUIW26UZbHitybbTciarGNmUjcul9qfDTd
 zE6nefYVYJYbnVVTka65fOzAtqyIKTCtfnyISlYuyUqSBQfV8aJKxKj2r6IjHbqFx+ai
 CNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297520; x=1779902320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rdCiAeyqDTXuK52kfIqalebuIdHOX+3Sh4uzHDXmhFg=;
 b=Dm1/mvjABP+5P13Z01GCmMf2CBOdERr2zq7tFwlI/fGlm66Uk047Beg2lWDkKPXsU6
 IUOPJru6bM4KurUijhjbtr8iFHXs84HmXNWzwEjvWFvrq9dC1pCttKXvgySuDraJ9YAq
 +us0CC3vHqVpXytq++AyUQir8Xw9ocLzdOrU09bINbUzVcQ4mwLeO6rtzl1PIcOAkUYn
 s9LiwPuCRRhAGTcuJjLKbmLW68ED8VDLLISa946BF4CQVCnhouyUXqG7nGSh9hAtTd9a
 E5QM7PAIhnNemSqYoQONMtJZriM6BvEE/ALZpc1pmhuoi2IjcOnaq/v8FPQKAEIJmFqu
 8yhw==
X-Gm-Message-State: AOJu0YzO0OQlbjkyzhSFAen3XWt62v/cHV/HYI9jYbgipejYAcjCjm0h
 JfoCMmwQcXGBb8RJknnVs+yBmmP7Ffq4luZVDiKsU9ECVG1TEAcnQkJFw8TWgFIRJ7ahXC5k/4h
 NvcMEd9o=
X-Gm-Gg: Acq92OGKcw7a+7Q2KLTQdMSueXOiYl+eg48gb4SwUT9JxSNGYMoa3SaJrg1WPLcqgc0
 PqeEOExk4VTpBS70oPiK/hNiN4EVCoIUg6/KQobGtRyDXxxmgFJqUDbmjB35/Z4kRBzF9MxW9JK
 gsBtZ6BY3yTOEe/QPp9Mepc8z22uLNjBq1TqAVIMijjS+wnTbw3dF1NHuD8HfZAxVEB4ad8Kzmh
 +mjsk0zJucBh3cSXxN+TEjaGXyv2VeqkKyI0q2sWQdK+ZVPDD5TF351g/nF23niMONVxBiaBeY0
 bLJMxpsSDEcRC8yyexLGl75d6D3Mn140ufGoNpJt+p2Zsc25RRMg1GgV6TYqGux/JgB5tbWCs/p
 RKrYrMkTwldRnaBajELpgiKEYAVaAxCA7BrTEpNYcskK99qYoiIrpXUt070TBCqFAzea4kVhWAi
 pFjIasvUb+mCTId0tbohneUZVsuUP1OHliPIgK5oU=
X-Received: by 2002:a17:90b:260b:b0:365:f8fc:3846 with SMTP id
 98e67ed59e1d1-36951b87209mr26499265a91.22.1779297520228; 
 Wed, 20 May 2026 10:18:40 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 26/30] fpu: Add accessors for rebias_{underflow,overflow}
Date: Wed, 20 May 2026 10:18:16 -0700
Message-ID: <20260520171820.848839-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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


