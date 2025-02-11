Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB78DC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5c-0006UE-0C; Tue, 11 Feb 2025 11:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5L-0006Om-8I
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:08 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5J-000335-7h
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:07 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso21384215e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291164; x=1739895964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oHCiuj4JVKpkS58JWQkdgF532nZyU3vTNz6sMG44ioQ=;
 b=twbtaz6RlAhIzx0ASTar9/CFIUO1QyjSALACsx7GuqI3fnN4oRpb+A/x6OAq2ovPiF
 cGFUl6OiFpFiEJl9aAx5tLcooMojKidyuHs7qZi0hdoFTqzPrxxbtp37+tLT3uCJbEc5
 xE5GDmJgJbp5UD6DDrwacpiPvCPKsIg82BergzIlIqmyxC9dvoD4CRb7dSGuTV9ppbij
 sUTgn3oPGXD+wA5oe8jDXiY3RTeff0TAFkOaSJ1sOAv067g8Za6n5GnmzoFrevlPg+aW
 nGoUX+Hbchlw7jGMIybtFvNFS8vFGlyGDbCzcn9QQNEdfV4wdm4eG91skqNMaq4vdJvu
 U89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291164; x=1739895964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHCiuj4JVKpkS58JWQkdgF532nZyU3vTNz6sMG44ioQ=;
 b=dx1gdhNLAKNLxP6XcP8bR2cLoy2JgrvbpwZC7WDfAqYAZPqIH3Oy8XP61dzitYpRIt
 Q4Oov/w+z7vJA0T2vrVyrMx0RS7ccR/IPMrVZFHR8wzAymcMGo6yV4um22c63+4h4e3x
 XD70A3pRx71t+dXY/keqffAMOz4AtO8B0XO9bff/Vg6Kk5JpcP4+jTyx4KpvMDq34vIi
 SS7a6uX8dNidzbYfeMCR/K/z2CQx8iI9Zn9pGeMlAyikYDZpjmtnR0333WYuQ5clgh9a
 r088WphuyBtx9PRbZT6MKvBeUPeOds9kbkhPIvGJja6yIasJoHSJDsTx+1M+1GJEzyol
 bNUA==
X-Gm-Message-State: AOJu0Ywvx3Xr0SAdMnhDJqi99A9cAwsltcbDtfYaJUJeBIVEcP01HivE
 UhxKFWvJHyH8zEt4he5yQUEhcobNnnPaGN5KwP7xgpR9t/nyr1mMOhUxpBrbfQqxVI03q0Pzgzz
 A
X-Gm-Gg: ASbGncujWdduBpyZt+OyUr8ohJggjHVNTQ4J402w1AvdKhouuO/n+y2ozQXxT75Zfmj
 0BLNvGOEwL9F9i64gXbuSRjtFpfCFsjPiRKO8E2gUKvav/75bU+M10zcuwRsA5kWROWLnaKpLog
 SCHqtRjVKQfsQHvYpaII/ZstP6bynFsypYEzwatefpPnUttlkS2f7tppxjVltO3JpNqMHaH67JF
 psoCyvG4BpWx3BI4ZJdV68LSiAkEyTz8wANWZCdrhTg73JKPJgtJZPXs20H6YenpsZp5qHq5HUT
 DyB+tZi9rBor0fbwV1e2
X-Google-Smtp-Source: AGHT+IEstagllL9nHnc4gaJU04HddV01/KQ896wJz42yxoD00jNJ1/vbr3vYnrf3wVZ0Bxqu6vP0WA==
X-Received: by 2002:a05:600c:1d02:b0:431:542d:2599 with SMTP id
 5b1f17b1804b1-439249a7ba5mr162747055e9.22.1739291163596; 
 Tue, 11 Feb 2025 08:26:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/68] target/arm: Implement FPCR.FIZ handling
Date: Tue, 11 Feb 2025 16:24:52 +0000
Message-Id: <20250211162554.4135349-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp_helper.c | 60 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 8c79ab4fc8a..30c170ecee5 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -61,19 +61,31 @@ static inline uint32_t vfp_exceptbits_from_host(int host_bits)
 
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
+     * Flushing an input denormal *only* because FPCR.FIZ == 1 does
+     * not set FPSR.IDC; if FPCR.FZ is also set then this takes
+     * precedence and IDC is set (see the FPUnpackBase pseudocode).
+     * So squash it unless (FPCR.AH == 0 && FPCR.FZ == 1).
+     * We only do this for the a64 flags because FIZ has no effect
+     * on AArch32 even if it is set.
+     */
+    if ((env->vfp.fpcr & (FPCR_FZ | FPCR_AH)) != FPCR_FZ) {
+        a64_flags &= ~float_flag_input_denormal_flushed;
+    }
+    return vfp_exceptbits_from_host(a32_flags | a64_flags);
 }
 
 static void vfp_clear_float_status_exc_flags(CPUARMState *env)
@@ -91,6 +103,17 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
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
@@ -130,9 +153,18 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
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
@@ -141,6 +173,14 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
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


