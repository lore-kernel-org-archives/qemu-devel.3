Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0E9C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrye-00035x-DQ; Tue, 28 Jan 2025 15:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxx-0002GM-W8
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:47 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxv-0001dS-QL
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:45 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso185025e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095221; x=1738700021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gh847BGiPPHCIyBLSzaOJRl7XyJqcLE9tcNfNxjs5hU=;
 b=RrHSGQjYBZnVd1Re2XbUqRSQUdiOJs6aZIomLEH0pauE/BWNAhNZifQrqIVsxMdfWd
 Muoq9HIeXRucxUUcb0+iKRMIYR7fm8f9/f5fhzfKta1G4gZ7f0/X4Op0T8oyzt8zb0T9
 GIiuGCCA9JZtmtM/xEOYkjuT1ocp5U7l0tz4FC7tZRq3HIoyNT+5bXUPLfXr+pm/5NVj
 wsYaNJIinT4SMI+icukC/4/DBkh+vBYb4cGNcyMRdWy9qibwjQ+3Xm3iFmnCsARtJtbY
 9sPcMKu+92xjkXblGzYKYp8bYeqsqScbUs0gkNcaSSXDtcCPZOzaqG86ijOi79atxRhT
 k1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095221; x=1738700021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gh847BGiPPHCIyBLSzaOJRl7XyJqcLE9tcNfNxjs5hU=;
 b=RRLkZ14+w3pBoe00nMZZIVnmGcNSE09O3oeHKbeBQ0+9y037qohwS1/bSe65Nxyaej
 LrQgU0D4iE3R4hki2VK3OMyeXCj27cb05r56NKNC4eu5Hg8dNB4PQzPE7eUnAVvVWdeG
 MR59CF7jBfcMY5SaW6sSM9LQoYBnPMUh9IHte2fESaAKeuvaIKtZnYOYEsUAmrswGEDR
 DX4R0ha4+iu7lKAm69O+rxVUZNcNEkS7iKsvRzXKyxVO0kMu0J7fY2I13pXWweWWHSag
 /a7QUnFRczudSRN85SbGaScPenUAsSNKv4ZfRxW1KJI7Peer2o6AeDSuIecgrEGrV5H5
 HVDg==
X-Gm-Message-State: AOJu0YxH/x5OxizK7y9Ca0a9sBLWsk4sSNziA8cvsahJBJ4a8BavmFAH
 vgdvtVA8tDH51A3w/Iy91m6myUci6Q7WnzFvCsgIMHbvuLy+LlcJdh0w5r+lQbwv2BoTkjHGebf
 C
X-Gm-Gg: ASbGnctxOr5/JXWE7qIcKY/Faj+YDQsRvaAMeI5hSLmkwPfQCm9vBIuoG7bMnq5/q8U
 bMQMjXjc8TL5biK3bGDjlPgYjJlGtCL69PB4A/QIz27ymJoC9hdM6dIvqmudEF5ZwlQipO3v4bd
 EEmhqOlx/t53ZSLhtBhmsArZbXeNizE6i2fNJkdHA4C8vpqqvhSqGPKF22jbGx8D4fvl0T1waZ7
 IoAwyyMFQEgpGpeAtyXV3ksKhJfEbcLqBBTz4v/x0wYy6CS9jkRN1eRXk0pdkKyJmQ6iRg1kVUo
 wkmBW5to40X9RnGTNS2+vQ==
X-Google-Smtp-Source: AGHT+IFTFpYA1Y5KSGk+e46I5iDEK3Zx3enlgL2lph3Segko+6CHFd6iJYM2A170Vu8hqbY8IBD86w==
X-Received: by 2002:a05:600c:3511:b0:436:e69a:7341 with SMTP id
 5b1f17b1804b1-438dbe866f5mr5703135e9.3.1738095221521; 
 Tue, 28 Jan 2025 12:13:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/36] target/arm: Remove now-unused vfp.fp_status and FPST_FPCR
Date: Tue, 28 Jan 2025 20:13:02 +0000
Message-Id: <20250128201314.44038-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now we have moved all the uses of vfp.fp_status and FPST_FPCR
to either the A32 or A64 fields, we can remove these.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-13-peter.maydell@linaro.org
---
 target/arm/cpu.h           | 2 --
 target/arm/tcg/translate.h | 6 ------
 target/arm/cpu.c           | 1 -
 target/arm/vfp_helper.c    | 8 +-------
 4 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 337c5383748..7b967bbd1d2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -633,7 +633,6 @@ typedef struct CPUArchState {
 
         /* There are a number of distinct float control structures:
          *
-         *  fp_status: is the "normal" fp status.
          *  fp_status_a32: is the "normal" fp status for AArch32 insns
          *  fp_status_a64: is the "normal" fp status for AArch64 insns
          *  fp_status_fp16: used for half-precision calculations
@@ -660,7 +659,6 @@ typedef struct CPUArchState {
          * only thing which needs to read the exception flags being
          * an explicit FPSCR read.
          */
-        float_status fp_status;
         float_status fp_status_a32;
         float_status fp_status_a64;
         float_status fp_status_f16;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index c8414d94d5e..fca68b7c4c8 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -670,7 +670,6 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
  * Enum for argument to fpstatus_ptr().
  */
 typedef enum ARMFPStatusFlavour {
-    FPST_FPCR,
     FPST_A32,
     FPST_A64,
     FPST_FPCR_F16,
@@ -686,8 +685,6 @@ typedef enum ARMFPStatusFlavour {
  * been set up to point to the requested field in the CPU state struct.
  * The options are:
  *
- * FPST_FPCR
- *   for non-FP16 operations controlled by the FPCR
  * FPST_A32
  *   for AArch32 non-FP16 operations controlled by the FPCR
  * FPST_A64
@@ -705,9 +702,6 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     int offset;
 
     switch (flavour) {
-    case FPST_FPCR:
-        offset = offsetof(CPUARMState, vfp.fp_status);
-        break;
     case FPST_A32:
         offset = offsetof(CPUARMState, vfp.fp_status_a32);
         break;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8bdd535db95..a2b9bd3fb9d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -572,7 +572,6 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_inputs_to_zero(1, &env->vfp.standard_fp_status);
     set_default_nan_mode(1, &env->vfp.standard_fp_status);
     set_default_nan_mode(1, &env->vfp.standard_fp_status_f16);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 034f26e5daa..9fee6265f20 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -61,9 +61,8 @@ static inline uint32_t vfp_exceptbits_from_host(int host_bits)
 
 static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
-    uint32_t i;
+    uint32_t i = 0;
 
-    i = get_float_exception_flags(&env->vfp.fp_status);
     i |= get_float_exception_flags(&env->vfp.fp_status_a32);
     i |= get_float_exception_flags(&env->vfp.fp_status_a64);
     i |= get_float_exception_flags(&env->vfp.standard_fp_status);
@@ -82,7 +81,6 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      * values. The caller should have arranged for env->vfp.fpsr to
      * be the architecturally up-to-date exception flag information first.
      */
-    set_float_exception_flags(0, &env->vfp.fp_status);
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
     set_float_exception_flags(0, &env->vfp.fp_status_f16);
@@ -112,7 +110,6 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
             i = float_round_to_zero;
             break;
         }
-        set_float_rounding_mode(i, &env->vfp.fp_status);
         set_float_rounding_mode(i, &env->vfp.fp_status_a32);
         set_float_rounding_mode(i, &env->vfp.fp_status_a64);
         set_float_rounding_mode(i, &env->vfp.fp_status_f16);
@@ -126,8 +123,6 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a64);
@@ -135,7 +130,6 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16);
-- 
2.34.1


