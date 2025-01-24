Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83520C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYl-0004mZ-L7; Fri, 24 Jan 2025 11:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYH-0003nY-2W
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:01 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYC-0005QD-PY
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:00 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso23692215e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736134; x=1738340934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7RHGAgr/hKGQtSL5QHgoLI2mVD1OoVEOmdEQ9/ADY9s=;
 b=u0Q642vQr0XdhByY/epgBqUytV3Y46pSmjK2FSRbBobReesQptcAvTIOM/sFOSK81y
 2ShHHnI22aM87u200yCcA0rYNRDWcH+xW/SOrp0aZ6tmRMui8Hq8ZisUuiZdW5B7I6b3
 DnkuoS3oGMcKyDkxLUQgy+uouj2tuFudZGISvNViJ73yGtx4HtPyZZ4rGTuGB7f850EX
 qwKs1730K6iSOe7XEvPnwCxUhrLA2FJC+6jLvj0TCYrhd5Dhw9WYLj8QohEmNheGuVHv
 74SHJHAp+XMmI3Do1RnIpin1pZpUDvoc9wEfAB/7kICyO6R9Q5wlmxnhgv5e3BNK5oCO
 bkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736134; x=1738340934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RHGAgr/hKGQtSL5QHgoLI2mVD1OoVEOmdEQ9/ADY9s=;
 b=f/xULUoIf8j6oKF44D3epMaEw/qWMebfkODO4U3BJ7lQ+9fEYr0z8s4NePNJ8BYJku
 1zqUCF7CDO10qPxLkbNoNrdwjXOIr+uGmFz24SYELRYfdrOHcNdTjH5LcIPKpcGi7wbL
 UdOAhmCDZIZHPXk2/LInRXtu9IeIuwouq5NpIodaIXN1Ad6t4Y4fV74isKAwCEcSVfwo
 2Nd3VOjqtAaPtBfLEtGd7vvc0xaRBOhg9KjikoWn00D+llv9ujpAhrpTrYobv3/Y1GS7
 vmu5aIbf6P088lY1R/u+10HmYYpCPDzNnUbmuPCLWHZdLQ7laNwm9a8smxJuWdcQQWGB
 5SKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnnT2RtxOhq6myHGxDDKbv816CuFYRiPpked+6MC6OoEE/V0N6ydb7KAupY7ySgqV8Ww/vEq4WCCtL@nongnu.org
X-Gm-Message-State: AOJu0Yw1C6Qc3eTo29VcAurSo9VQg76eqAPanF6dKBXTpzZOZ9jVVSLM
 Z/PCZ7JaIt6k2OUbyXArgl1EMmMEPllsw1gASz4LyQb7z8xHCKNC6sLgcf9wxAw=
X-Gm-Gg: ASbGnctXv+j0wzYL6OO2IsLrvNjLxYIuZcVGPOu2gDKOeeiJ+XsUrKajG5Fx1mjBkLw
 iptYxDl8LZ0KOL8m02GNXW5qt3738dSRFbNzbWPcNjlwMHkG7qhM+Xz6Q6sNHz7xFyMWYFsRT92
 sQq9OJkBRj0bk4rO2WszrcrBc45DglJzCuY0rAI+H2ogz+RPO5zJHNvd/FT2S6X42EpLlyNomZI
 IAxwX8ctqR6lCIKy4R13lvv8W3NprJyRTE4OcTrDdBHPaWh9jYWRATAJG5XSgVR38uk8Cd52Fmb
 F5k/bLL9t9s=
X-Google-Smtp-Source: AGHT+IHUdMRpLLZpqKzfXlQsvlMNwtuAb7Ve8xSTIL/zD0eWRLAt6eM1CJSqN3BXWQPquRQ8+hwWpQ==
X-Received: by 2002:a05:600c:4e52:b0:436:e751:e445 with SMTP id
 5b1f17b1804b1-438a079c1e7mr275279235e9.5.1737736132377; 
 Fri, 24 Jan 2025 08:28:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/76] target/arm: Remove now-unused vfp.fp_status and
 FPST_FPCR
Date: Fri, 24 Jan 2025 16:27:32 +0000
Message-Id: <20250124162836.2332150-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
index a7509b314b0..197772eb13d 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -670,7 +670,6 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
  * Enum for argument to fpstatus_ptr().
  */
 typedef enum ARMFPStatusFlavour {
-    FPST_FPCR,
     FPST_FPCR_A32,
     FPST_FPCR_A64,
     FPST_FPCR_F16,
@@ -686,8 +685,6 @@ typedef enum ARMFPStatusFlavour {
  * been set up to point to the requested field in the CPU state struct.
  * The options are:
  *
- * FPST_FPCR
- *   for non-FP16 operations controlled by the FPCR
  * FPST_FPCR_A32
  *   for AArch32 non-FP16 operations controlled by the FPCR
  * FPST_FPCR_A64
@@ -705,9 +702,6 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     int offset;
 
     switch (flavour) {
-    case FPST_FPCR:
-        offset = offsetof(CPUARMState, vfp.fp_status);
-        break;
     case FPST_FPCR_A32:
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


