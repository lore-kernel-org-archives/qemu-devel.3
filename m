Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16B6C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYr-0005CW-Lx; Fri, 24 Jan 2025 11:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYW-0003zW-FF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:17 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYU-0005Yi-Mj
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:16 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso16014235e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736153; x=1738340953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y5oz9pArMzFfW9wvGP0yBGuc3ozPKdEsvW7lbByV5HM=;
 b=Da0PXiFOAGUwhSarHIHL66ST5LgrJE7FWjOTKc1j10+UA1Wi18+Q2eVDx1YkXRNI/B
 Y8p1eUvx3fqSMQp2E1lbavFrFqJ79TWxFVgtDuPoG/+kk3Y8raVU0FJl/Siq3eDZGcr9
 Psc72TrvcyfiZBKI+nQDXqqJXurMmGmaKvPwSkXGmNpKIRFQohRc/QvbOZEINTstZO1S
 AEmYrtlpPoY1ZU1g87deTmTdnNbNf09Rp6Un5skvS9c7YLrM3NnxtDcOmhA1OimQQFTP
 1vY0j8B1Tp4A2xBvWOlmjFPwfmLveeb3k44qPmYLzSvqtKdgXG/rkQTjTHigYVASA6Ly
 bRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736153; x=1738340953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5oz9pArMzFfW9wvGP0yBGuc3ozPKdEsvW7lbByV5HM=;
 b=F/mnUrrkDwfwgYLu+5XD2AYzyFkR+vtQZv7ezFYuQx++pzr4xCy02q72iL2SVWMLkv
 5jr7rDo+afE7q0h+i5cV2SF2jtCvwsOSVyIBPsy+sibgEw2GVfd1TX0jYkT+mKDWz4s2
 8AVHYRDPCR6o4NUfV/pFF2kL9Fe7v7vH7ZaIXzaCoJi20a8w1Ljo9tdBrNIQ9SYZ0Hmu
 rfVxwuR4BuTJm/6REZtfK6MIrSDZKLvG1qZkkgmbvDtwxlz2cmZGCf1uCLsc4MYQICAh
 S6n1apH6ElU+tXKx/7dfGWMqZ935+oXOD7tZ4xusmpVvGYsKJJKVE/1b3E6uCzkrOTGP
 dupA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOL8JXh8tVg8vO6ASOzpSBm+v0O51RJO8iyiknJdgwNLGO/EJoq5Zuvsyr7j/yAHPeeUhZNnI4Tiky@nongnu.org
X-Gm-Message-State: AOJu0Yyqjg4aixGCnOchL7aAk0GS9RXs1esV5tx2t6pP5P6c1A5RrqJg
 UUrTIwXBhyextHx304ByzyL4zVqfx6jfhM072rP0nvic9kJoFp4527urfseP794=
X-Gm-Gg: ASbGncsSxyL6lwrgJEmlDEzURopcDJV/Q3GZwn15CCEa52adGgSJ5Clwg85T+Y6UKcX
 hBY8N+y1U1sXQLCna24Fr7fxygmqT+bJICbmBVru3kaZp6U2zRnLWHV4PmGlJeN5TRYRPuB+GWg
 ltEOl7OPZqDv4PSUkQnA6sCcaWxwi3oNP+DqFWP5To/NG+Qjcqywm0aAh2U9mc1BJ84iTvo/P+i
 vCTdhVvhIinq1ExzvFR02tEsS+nwPEjnpusHtiKkRSr4ugCHajCqQNcXyfxr/wTNP53DyReO4PX
 3TbdD6lxowQ=
X-Google-Smtp-Source: AGHT+IGhML3RxVbgOrLLlWWOQ5npLmVuAk9+/9X7wA63A5AwcmvCYsUF4SknYmpeIRtCMJqEntCNHA==
X-Received: by 2002:a7b:cb43:0:b0:434:fafe:edb with SMTP id
 5b1f17b1804b1-43891427757mr260174695e9.24.1737736153235; 
 Fri, 24 Jan 2025 08:29:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 28/76] target/arm: Implement FPCR.FIZ handling
Date: Fri, 24 Jan 2025 16:27:48 +0000
Message-Id: <20250124162836.2332150-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Part of FEAT_AFP is the new control bit FPCR.FIZ.  This bit affects
flushing of single and double precision denormal inputs to zero for
AArch64 floating point instructions.  (For half-precision, the
existing FPCR.FZ16 control remains the only one.)

FPCR.FIZ differs from FPCR.FZ in that if we flush an input denormal
only because of FPCR.FIZ then we should *not* set the cumulative
exception bit FPSR.IDC.

FEAT_AFP also defines that in AArch64 the existing FPCR.FZ only
applies when FPCR.AH is 0.

We can implement this by setting the "flush inputs to zero" state
appropriately when FPCR is written, and by not reflecting the
float_flag_input_denormal status flag into FPSR reads when it is the
result only of FPSR.FIZ.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 58 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 8c79ab4fc8a..5a0b389f7a3 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -61,19 +61,29 @@ static inline uint32_t vfp_exceptbits_from_host(int host_bits)
 
 static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
-    uint32_t i = 0;
+    uint32_t a32_flags = 0, a64_flags = 0;
 
-    i |= get_float_exception_flags(&env->vfp.fp_status_a32);
-    i |= get_float_exception_flags(&env->vfp.fp_status_a64);
-    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
+    a32_flags |= get_float_exception_flags(&env->vfp.fp_status_a32);
+    a32_flags |= get_float_exception_flags(&env->vfp.standard_fp_status);
     /* FZ16 does not generate an input denormal exception.  */
-    i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
+    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
           & ~float_flag_input_denormal_flushed);
-    i |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
+    a32_flags |= (get_float_exception_flags(&env->vfp.standard_fp_status_f16)
           & ~float_flag_input_denormal_flushed);
-    i |= (get_float_exception_flags(&env->vfp.standard_fp_status_f16)
+
+    a64_flags |= get_float_exception_flags(&env->vfp.fp_status_a64);
+    a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
           & ~float_flag_input_denormal_flushed);
-    return vfp_exceptbits_from_host(i);
+    /*
+     * Flushing an input denormal only because FPCR.FIZ == 1 does
+     * not set FPSR.IDC. So squash it unless (FPCR.AH == 0 && FPCR.FZ == 1).
+     * We only do this for the a64 flags because FIZ has no effect
+     * on AArch32 even if it is set.
+     */
+    if ((env->vfp.fpcr & (FPCR_FZ | FPCR_AH)) != FPCR_FZ) {
+        a64_flags &= ~float_flag_input_denormal_flushed;
+    }
+    return vfp_exceptbits_from_host(a32_flags | a64_flags);
 }
 
 static void vfp_clear_float_status_exc_flags(CPUARMState *env)
@@ -91,6 +101,17 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
 }
 
+static void vfp_sync_and_clear_float_status_exc_flags(CPUARMState *env)
+{
+    /*
+     * Synchronize any pending exception-flag information in the
+     * float_status values into env->vfp.fpsr, and then clear out
+     * the float_status data.
+     */
+    env->vfp.fpsr |= vfp_get_fpsr_from_host(env);
+    vfp_clear_float_status_exc_flags(env);
+}
+
 static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     uint64_t changed = env->vfp.fpcr;
@@ -130,9 +151,18 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a64);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a64);
+        /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+    }
+    if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
+        /*
+         * A64: Flush denormalized inputs to zero if FPCR.FIZ = 1, or
+         * both FPCR.AH = 0 and FPCR.FZ = 1.
+         */
+        bool fitz_enabled = (val & FPCR_FIZ) ||
+            (val & (FPCR_FZ | FPCR_AH)) == FPCR_FZ;
+        set_flush_inputs_to_zero(fitz_enabled, &env->vfp.fp_status_a64);
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
@@ -141,6 +171,14 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
     }
+    /*
+     * If any bits changed that we look at in vfp_get_fpsr_from_host(),
+     * we must sync the float_status flags into vfp.fpsr now (under the
+     * old regime) before we update vfp.fpcr.
+     */
+    if (changed & (FPCR_FZ | FPCR_AH | FPCR_FIZ)) {
+        vfp_sync_and_clear_float_status_exc_flags(env);
+    }
 }
 
 #else
-- 
2.34.1


