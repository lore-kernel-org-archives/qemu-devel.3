Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C241C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthO-0002Bn-JR; Thu, 11 Jul 2024 09:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthD-0001WI-93
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth7-00063Q-B3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266182a9d7so5441345e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703909; x=1721308709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nFYyrjsNrLUd84ygFglfo4UEH7zDocaQimrRcj1rdrk=;
 b=j9BzpUSA38kTZVnZ30oIa01V10Zvxk1NLMBqQZLgjevKYcGCaKw/nXIcrXHcVUbly+
 BETVa9PPdQL/wskZERc5o2I147PyF8PUCGrTkbgtorDyMA1M8cHjHzZ0pMlCHfLw6HMz
 Vy575bPYiMvyHBzh0hVpIeWvD/7NDPr1M3EjitVBXpmx4Qg+Om5IyLxgYVa6fVjIUAFR
 SccwFqifvsoBVeTtMtCV+lFCy6hHhR1DPAEMZuXr1N0suSVTnINX1fdxgEgod9hVrZfc
 x7HLys9zIv5SP5X3Nm2/I1cQNfJhV6pEuR3FuREuYmJXNlnZf3W8jyDh3DKNJhjFBBf/
 iOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703909; x=1721308709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFYyrjsNrLUd84ygFglfo4UEH7zDocaQimrRcj1rdrk=;
 b=W+iFFfDpoWIiPMt2fP4omOD5qdS5usr1hTzP1wV/akvHYoT4AtaTyiCHIjxIc+lu3Z
 G81+9aHlIBufHPxc9sAmnQIymxhHGUI4GNcXig2RPN7h0Ooi5kPMBfLEDH6FLVk9EfOR
 4i5j80olquejg38cqu3hfDHKxf3gFFYQaVxs/3rJbBqpJAUXMHQdy0/viYGcvAATqzs+
 +50izIGx9aHj3YOAVqecglNMPeS1xQs6yIzAlik36XQczTUKmPhr3OB86tXc9HRYZP3p
 VxiYMm0Ydt12EXu0wf4rK11iTZqbT6VmEiKL8mK90B4b+5MGXb2U8LOzY8J1QpIHcDRE
 gdvQ==
X-Gm-Message-State: AOJu0YzPfX/MDNnmU/qXpdqGldL5N3k0dSgEBeCHoL2un5oWc2k7yXLx
 lR2qEczufxJk0bS6rbbWVhWIOAkygHNNYtMiYZLX+CyuTLMG5WhGsr6fkoRh9fEQfCwUEJQsBWE
 mG1k=
X-Google-Smtp-Source: AGHT+IFDt5fPKTsd7j/Jd0ZGDHV2qARJrV8KuvqPDIaItvgJZrgvI2p7FXYDZcckLhnnnNddHvJYVA==
X-Received: by 2002:a05:600c:4a98:b0:426:6ea0:d5b8 with SMTP id
 5b1f17b1804b1-426708f2012mr55968125e9.29.1720703909314; 
 Thu, 11 Jul 2024 06:18:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/24] target/arm: Allow FPCR bits that aren't in FPSCR
Date: Thu, 11 Jul 2024 14:18:07 +0100
Message-Id: <20240711131822.3909903-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In order to allow FPCR bits that aren't in the FPSCR (like the new
bits that are defined for FEAT_AFP), we need to make sure that writes
to the FPSCR only write to the bits of FPCR that are architecturally
mapped, and not the others.

Implement this with a new function vfp_set_fpcr_masked() which
takes a mask of which bits to update.

(We could do the same for FPSR, but we leave that until we actually
are likely to need it.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240628142347.1283015-10-peter.maydell@linaro.org
---
 target/arm/vfp_helper.c | 54 ++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index cbe69ae3fe3..b3698da8ca7 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -113,11 +113,12 @@ static void vfp_set_fpsr_to_host(CPUARMState *env, uint32_t val)
     set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
 }
 
-static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val)
+static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     uint64_t changed = env->vfp.fpcr;
 
     changed ^= val;
+    changed &= mask;
     if (changed & (3 << 22)) {
         int i = (val >> 22) & 3;
         switch (i) {
@@ -167,7 +168,7 @@ static void vfp_set_fpsr_to_host(CPUARMState *env, uint32_t val)
 {
 }
 
-static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val)
+static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
 {
 }
 
@@ -239,8 +240,13 @@ void vfp_set_fpsr(CPUARMState *env, uint32_t val)
     env->vfp.fpsr = val;
 }
 
-void vfp_set_fpcr(CPUARMState *env, uint32_t val)
+static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
 {
+    /*
+     * We only set FPCR bits defined by mask, and leave the others alone.
+     * We assume the mask is sensible (e.g. doesn't try to set only
+     * part of a field)
+     */
     ARMCPU *cpu = env_archcpu(env);
 
     /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
@@ -248,22 +254,24 @@ void vfp_set_fpcr(CPUARMState *env, uint32_t val)
         val &= ~FPCR_FZ16;
     }
 
-    vfp_set_fpcr_to_host(env, val);
+    vfp_set_fpcr_to_host(env, val, mask);
 
-    if (!arm_feature(env, ARM_FEATURE_M)) {
-        /*
-         * Short-vector length and stride; on M-profile these bits
-         * are used for different purposes.
-         * We can't make this conditional be "if MVFR0.FPShVec != 0",
-         * because in v7A no-short-vector-support cores still had to
-         * allow Stride/Len to be written with the only effect that
-         * some insns are required to UNDEF if the guest sets them.
-         */
-        env->vfp.vec_len = extract32(val, 16, 3);
-        env->vfp.vec_stride = extract32(val, 20, 2);
-    } else if (cpu_isar_feature(aa32_mve, cpu)) {
-        env->v7m.ltpsize = extract32(val, FPCR_LTPSIZE_SHIFT,
-                                     FPCR_LTPSIZE_LENGTH);
+    if (mask & (FPCR_LEN_MASK | FPCR_STRIDE_MASK)) {
+        if (!arm_feature(env, ARM_FEATURE_M)) {
+            /*
+             * Short-vector length and stride; on M-profile these bits
+             * are used for different purposes.
+             * We can't make this conditional be "if MVFR0.FPShVec != 0",
+             * because in v7A no-short-vector-support cores still had to
+             * allow Stride/Len to be written with the only effect that
+             * some insns are required to UNDEF if the guest sets them.
+             */
+            env->vfp.vec_len = extract32(val, 16, 3);
+            env->vfp.vec_stride = extract32(val, 20, 2);
+        } else if (cpu_isar_feature(aa32_mve, cpu)) {
+            env->v7m.ltpsize = extract32(val, FPCR_LTPSIZE_SHIFT,
+                                         FPCR_LTPSIZE_LENGTH);
+        }
     }
 
     /*
@@ -276,12 +284,18 @@ void vfp_set_fpcr(CPUARMState *env, uint32_t val)
      * bits.
      */
     val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16;
-    env->vfp.fpcr = val;
+    env->vfp.fpcr &= ~mask;
+    env->vfp.fpcr |= val;
+}
+
+void vfp_set_fpcr(CPUARMState *env, uint32_t val)
+{
+    vfp_set_fpcr_masked(env, val, MAKE_64BIT_MASK(0, 32));
 }
 
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 {
-    vfp_set_fpcr(env, val & FPSCR_FPCR_MASK);
+    vfp_set_fpcr_masked(env, val, FPSCR_FPCR_MASK);
     vfp_set_fpsr(env, val & FPSCR_FPSR_MASK);
 }
 
-- 
2.34.1


