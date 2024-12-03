Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1526E74ACF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZgi-0001QM-6t; Tue, 03 Dec 2024 15:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZga-0001KX-1c
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:39:56 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgX-0003AR-GI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:39:54 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ead60cedb7so1477411b6e.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258392; x=1733863192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMdz/R/XzxtV9sRyJPrRUrTNoKD74mGu1MDMytu4Vg0=;
 b=TTiIIk6NaGfk3LhEM/KLPoJQXiWM5kDXTRN650gvoqBggpK8Qk+oUu1hyIz9lE2E9C
 xK2G+aJLKjKoLhBrziUZ/51eR5pUuNlA2JsQPp1HcnpWHFCRXUKCRySXr3C7GsWICXuM
 81Nx5JIkD4uFhyBP4hFCqhAhU9opK88Q72dr/onvcZWgTPHqGt48YY1vz9AIw8jRH0Gm
 E2OHdy80yCeTJJp+TFnIivsd6WUL1vuhj51uXuIWSNtJn5E3K10pwbInro7vaCddolER
 zfTVLkAi+ULPWPSAHv5cMGsUeV0+h32tKIdid5Y5I2TPAQssmrDKWDNHW9IcQSuaJklf
 yTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258392; x=1733863192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMdz/R/XzxtV9sRyJPrRUrTNoKD74mGu1MDMytu4Vg0=;
 b=bkhQ0WZsON8uB3XCcdY7NQWpPMj7GLkZAXhc4HNCJESQWzAcdrol4Eglezywx13QWJ
 +aeC/knCBKnvZBFlQYLgXAlQBBxmeLHpAh8qbIooOMamSDOtZ5EbomEuDB1pjFm5ZaMO
 ZdC6LOER8uvSxMm8hr3KUpaM+Me2Mt1dkctqt4e/uECBX4qu2RjnBs53m4ic6eX+PtpP
 Kf/QLHZ0XcFfh817l/CunsD8+ZvB6VH66HIcbOXAdIBIfGL30s5u1MIaTZ/Pr/eifa+W
 tBDRT7ORMs66cgbXAgY9qUaxm6NRZlVmo0wehxYPjCanzZiPj0HqCXCth716syVZZ0pK
 v7BA==
X-Gm-Message-State: AOJu0YyiGe36MYNIsQgWEZWYk/yxUDDl42HM46RohNCE9wGWbjbK5K4G
 ZiLm1s+t8ctcQ+0ZDe5g2D8ka6tFTA+Nz47hjYX24opOXURwHmxDUmHMeseKgtZJIiUvhD097G1
 z8Ns=
X-Gm-Gg: ASbGncvawp/8hlufWCVKZzRyOVyMEq/C+aNpL1uboTqVuVoDUaM83cwoJ1sutgv9iE7
 ZhZO56GZOSiA1V5B/KG44ALFmRHFQkBStl7BND/v5H6D/BdlPlz5eN9ZAvXmBUI5qOKNeOHLXEL
 ThGTubd4pF/2XQ3PbKUpRdLg4CIjEmnmqfS51xSMJ01GUFAf66qigk1rthowonAPkUsNj/Bboi5
 sS/YJ1B4FiqmrakiwG9dXXCC58Lef1/l3ybDz7unP4raYb3X5Fs1eNbwo71mf3syHU7L2h7zJfq
 4OQ24T4+snMFiy8/Ly9Z/YPL8BPkaCPWHyAk
X-Google-Smtp-Source: AGHT+IFeU7g93isJmMqUzcz0qL/hCV0STZ1GuM0JBtlmegJowVUa+9eDBbc9lV+DAkaUnfyD+4TAmw==
X-Received: by 2002:a05:6870:ed8d:b0:287:4904:7125 with SMTP id
 586e51a60fabf-29e885f8734mr4425833fac.14.1733258392167; 
 Tue, 03 Dec 2024 12:39:52 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:39:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 01/11] target/arm: Copy entire float_status in is_ebf
Date: Tue,  3 Dec 2024 14:39:38 -0600
Message-ID: <20241203203949.483774-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
References: <20241203203949.483774-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that float_status has a bunch of fp parameters,
it is easier to copy an existing structure than create
one from scratch.  Begin by copying the structure that
corresponds to the FPSR and make only the adjustments
required for BFloat16 semantics.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index e825d501a2..ad6f26545a 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2813,25 +2813,19 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
      * no effect on AArch32 instructions.
      */
     bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
-    *statusp = (float_status){
-        .tininess_before_rounding = float_tininess_before_rounding,
-        .float_rounding_mode = float_round_to_odd_inf,
-        .flush_to_zero = true,
-        .flush_inputs_to_zero = true,
-        .default_nan_mode = true,
-    };
+
+    *statusp = env->vfp.fp_status;
+    set_default_nan_mode(true, statusp);
 
     if (ebf) {
-        float_status *fpst = &env->vfp.fp_status;
-        set_flush_to_zero(get_flush_to_zero(fpst), statusp);
-        set_flush_inputs_to_zero(get_flush_inputs_to_zero(fpst), statusp);
-        set_float_rounding_mode(get_float_rounding_mode(fpst), statusp);
-
         /* EBF=1 needs to do a step with round-to-odd semantics */
         *oddstatusp = *statusp;
         set_float_rounding_mode(float_round_to_odd, oddstatusp);
+    } else {
+        set_flush_to_zero(true, statusp);
+        set_flush_inputs_to_zero(true, statusp);
+        set_float_rounding_mode(float_round_to_odd_inf, statusp);
     }
-
     return ebf;
 }
 
-- 
2.43.0


