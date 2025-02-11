Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FD0C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht8h-0006mK-0T; Tue, 11 Feb 2025 11:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6J-00074T-0F
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:10 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6C-0003dq-Tj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:05 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-439473da55aso14979905e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291218; x=1739896018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z5TXLR7YHrFzViztkLtyvVgdUxyFaQzI+G1CRHD9ohQ=;
 b=pfUnpqMOS0swrBvbXbU6hufJJZ77kwSZm1818shQXVOtLFXi9PcEYa8ggrB3CGwZcC
 5ZXb2xvD/a/p0ANcsJ1bXIpce5CZSxL1+cwDZaa6vy4X37GmZw+LeRTJDDqMBH7r6/p0
 PpPgfm+r8X4BX7P7WG/n+sRx8fed9bVs1AevZSbnj7zrF9zPn9d/h/sqJwtjIe1XVo/4
 +m0kM1V/gUhelypyDMzMCWgzrXJd4neOoZ29rr/PKzYNIcmbZ50o2PQW3AcerKwdZBCU
 UAD1I+qlbc7iAHBKA7U+J8U34cD+xma8OP1w/uykf8eNy4+E9NDsmMcEA5SOqfpZMnxg
 0QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291218; x=1739896018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5TXLR7YHrFzViztkLtyvVgdUxyFaQzI+G1CRHD9ohQ=;
 b=qz9CzCQQo29wXIAc23NQLdEU7tGlygX3PEw6Okb5KUkuO9Z+itLGMd/ZPxpeApkbV8
 Gk2s7Yp1/KhxUeXl+T5jdHiVXc1iGvYyDvctV7uQ7y/+GSRKH//S9ngOXv4hHjGJQzKx
 lxDgwZWkYsNlPBz9bGcSDbDH/UEqxKaSUVfGwIWFx9v3IDxlE9gVEmSPmEGLYAO6q3tj
 6fa6xmhO05T3/i4d2X1G/i4wieD4zP9QI1H5TKjzncq0iq0lFAQyuxpRQ+1FGafQag/6
 AhKKlU4tYIiUpPCdcpJYohNeWyKsoiE0Z3275adQTxjstNNoHHrDZ+NaqMvK3yN0zcUV
 R+lg==
X-Gm-Message-State: AOJu0Yw1fUP/Xtk99UCzntGWu7CDP/MTQKXw6WnOszOqGbm/GPvgd6M+
 QItcMfcFGJZYfwKDbd//+Vw1vcuP6ARV5VG+YADQBjZr19mkiF/D13HLSOg04xMyZVkixGmzZD+
 A
X-Gm-Gg: ASbGncsF5ea4SfC/e8l0a8bYd97WL2qIfePvIOaA0BIarw31aMXy3zUigKjDYGTbHQW
 TQiNybWzBU24NpfDDM8Snlb8J0WW95ccnkuU13S/P2nI3tcEBOMySc9flzGtgkfwua5K3jIFJFb
 8s9Otv9JtjCs2b/UVvdYfPBCBItPSDJojjU6oO0q5dYK1Q/BGCfZFFxuP3Icqx/oJiwHUJGcjqV
 fqJBRo1QmM7xNhbJGfwjCuoc82SoUfMIWiIZVZL3VNZRFNFL84877nYu6oiNewC8Id7Q/EygKN6
 PfKYDcm2L6qVv7k/zKSB
X-Google-Smtp-Source: AGHT+IHAqrj6XRQZtiNxfey31DGh+OxnZF44SYGinzCvt5LytvBbzRDDRXZVUGAtDLYNcPn8FxTrsA==
X-Received: by 2002:a05:600c:4f8e:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-43924990be0mr166707545e9.14.1739291217973; 
 Tue, 11 Feb 2025 08:26:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/68] target/arm: Remove ah_fp_status_f16
Date: Tue, 11 Feb 2025 16:25:45 +0000
Message-Id: <20250211162554.4135349-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

Replace with fp_status[FPST_AH_F16].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        |  3 +--
 target/arm/cpu.c        |  2 +-
 target/arm/vfp_helper.c | 10 +++++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9f57dfc3e9c..91e132024e7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -237,7 +237,7 @@ typedef struct NVICState NVICState;
  * behaviour when FPCR.AH == 1: they don't update cumulative
  * exception flags, they act like FPCR.{FZ,FIZ} = {1,1} and
  * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
- * which means we need an ah_fp_status_f16 as well.
+ * which means we need an FPST_AH_F16 as well.
  *
  * To avoid having to transfer exception bits around, we simply
  * say that the FPSCR cumulative exception flags are the logical
@@ -695,7 +695,6 @@ typedef struct CPUArchState {
                 float_status fp_status_f16_a32;
                 float_status fp_status_f16_a64;
                 float_status ah_fp_status;
-                float_status ah_fp_status_f16;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 75b6b93c7c8..5a21a6c6eb2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -559,7 +559,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status);
     set_flush_to_zero(1, &env->vfp.ah_fp_status);
     set_flush_inputs_to_zero(1, &env->vfp.ah_fp_status);
-    arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status_f16);
+    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);
 
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 28b9132be5a..ec7c0d6a98f 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -129,7 +129,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
-     * We do not merge in flags from ah_fp_status or ah_fp_status_f16, because
+     * We do not merge in flags from ah_fp_status or FPST_AH_F16, because
      * they are used for insns that must not set the cumulative exception bits.
      */
 
@@ -162,7 +162,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
     set_float_exception_flags(0, &env->vfp.ah_fp_status);
-    set_float_exception_flags(0, &env->vfp.ah_fp_status_f16);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH_F16]);
 }
 
 static void vfp_sync_and_clear_float_status_exc_flags(CPUARMState *env)
@@ -208,11 +208,11 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
-        set_flush_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
@@ -237,7 +237,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status);
-        set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status_f16);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
     if (changed & FPCR_AH) {
         bool ah_enabled = val & FPCR_AH;
-- 
2.34.1


