Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C34C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxs-0002Ba-CD; Tue, 28 Jan 2025 15:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxq-0002AX-I1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxo-0001bz-MQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:38 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so43175175e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095215; x=1738700015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qHcYtEEPB7QhSseJRxWmTazgGuwL9WqJND/LxAT7lA4=;
 b=i13JZxNmOhOyTXgGnn/plvSU96Lp92t42pULpLtdouq2xBAv73XfkWQCAp2Rb7ajkJ
 9nLwb1tT2PBXoa2zvbODFEklwvQaphg3rrV6hMttUGcXNMYAvwR/mMTMnckXMabDC5im
 eFQgldhznX3snfVcsTBo58PctZN5vuIflAfN7yyA0hCmkdlCSc9ukyQcfV6ISx5OnbwQ
 22zOVX//aJehr43EXgku/cNZBAUwGKqK+4CdJu55u7VYIui1DnqGxxoovQhdmqHVZJVg
 Iwu4vqaI6JH8jZV7DieHlyE8o4WINqycYb7aFs6upjLgDOAy6cTFhyK5FysR4XrnyNej
 KK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095215; x=1738700015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHcYtEEPB7QhSseJRxWmTazgGuwL9WqJND/LxAT7lA4=;
 b=iksWphKLsP+RGouSamhmtblQkagw38VzDrMsllFYFw2vqZ1TqiqbbTGa0SkPFfzid9
 qfsOoPXzW7uLBRkTwATSoIGgR7kcmqIldXlpfy+gtS2JxjRNwHnBex56RESAvomcQ8uA
 l7QzEf5KCzZilPsRKWn7bQcobQ79D4xGtCOiWdUR1KzYRIxjLHl3MNS4wZq55uF0orDT
 wI2WiqDROQ5jNeGrfp091s5Kn3sJHPlCtFnpKcQM14vgK30Ua7XZspHjG8jjeN0U1HWr
 ZkpULHyFi78hPzNXDqK0OZswTAMwiV4e9q7VsZfFrF10mEizVcHqJdpgl5T8MGIBdQ2E
 oxCQ==
X-Gm-Message-State: AOJu0Yx4k3SFQIdNsJlGsk2OPceDhDwkFnPcMAVw2tqrAqKCG1L3wc+q
 ObeWFKri467Evlg/u//ksIboFJOgV4pAg/ljTM26ZdZeuiTZzniIjOJKursHKc1GETIur7BV1sq
 T
X-Gm-Gg: ASbGncuMadpHVQGSBWBFdCYs0dBJGdbCydQFt5lX2Vonv0zGFhJGH/AC8wNcrb2yVMy
 HE/CC1HVgbfydMx9QQ/AcB1toadjo3Lrf96VM60aQFvKqYxrYCfonRMAbH2zDw5b+eIcYlLn09g
 w9zcHc0ns7EvJlJbV4Fq9FPzZgd8lA8SeYb/YP+iXsZyMWPEWDXkP59iX2jnxH3Ua8arDOKyKXA
 YUKGg4AwOuBAksECKV9+1SzsI40F44hxyNW4fLEY87Hkg3Ggebj3feGLsslj38QtHuAbpVI512c
 7llOPSPvY5/hegIZjGONVA==
X-Google-Smtp-Source: AGHT+IFTLzkt1X4NZYZ780d+IGnX5bJJ8F4KyZ6PpNGL7oRVJQRi1uK7Ko4xar7c6gKT8aI/7yX1PQ==
X-Received: by 2002:a05:600c:5486:b0:433:c76d:d57e with SMTP id
 5b1f17b1804b1-438dc3a40d3mr2622465e9.5.1738095214886; 
 Tue, 28 Jan 2025 12:13:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/36] target/arm: Define new fp_status_a32 and fp_status_a64
Date: Tue, 28 Jan 2025 20:12:55 +0000
Message-Id: <20250128201314.44038-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

We want to split the existing fp_status in the Arm CPUState into
separate float_status fields for AArch32 and AArch64.  (This is
because new control bits defined by FEAT_AFP only have an effect for
AArch64, not AArch32.) To make this split we will:
 * define new fp_status_a32 and fp_status_a64 which have
   identical behaviour to the existing fp_status
 * move existing uses of fp_status to fp_status_a32 or
   fp_status_a64 as appropriate
 * delete the old fp_status when it has no uses left

In this patch we add the new float_status fields.

We will also need to split fp_status_f16, but we will do that
as a separate series of patches.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-7-peter.maydell@linaro.org
---
 target/arm/cpu.h           |  4 ++++
 target/arm/tcg/translate.h | 12 ++++++++++++
 target/arm/cpu.c           |  2 ++
 target/arm/vfp_helper.c    | 12 ++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9a6e8e589cc..337c5383748 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -634,6 +634,8 @@ typedef struct CPUArchState {
         /* There are a number of distinct float control structures:
          *
          *  fp_status: is the "normal" fp status.
+         *  fp_status_a32: is the "normal" fp status for AArch32 insns
+         *  fp_status_a64: is the "normal" fp status for AArch64 insns
          *  fp_status_fp16: used for half-precision calculations
          *  standard_fp_status : the ARM "Standard FPSCR Value"
          *  standard_fp_status_fp16 : used for half-precision
@@ -659,6 +661,8 @@ typedef struct CPUArchState {
          * an explicit FPSCR read.
          */
         float_status fp_status;
+        float_status fp_status_a32;
+        float_status fp_status_a64;
         float_status fp_status_f16;
         float_status standard_fp_status;
         float_status standard_fp_status_f16;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 2d37d7c9f21..c8414d94d5e 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -671,6 +671,8 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
  */
 typedef enum ARMFPStatusFlavour {
     FPST_FPCR,
+    FPST_A32,
+    FPST_A64,
     FPST_FPCR_F16,
     FPST_STD,
     FPST_STD_F16,
@@ -686,6 +688,10 @@ typedef enum ARMFPStatusFlavour {
  *
  * FPST_FPCR
  *   for non-FP16 operations controlled by the FPCR
+ * FPST_A32
+ *   for AArch32 non-FP16 operations controlled by the FPCR
+ * FPST_A64
+ *   for AArch64 non-FP16 operations controlled by the FPCR
  * FPST_FPCR_F16
  *   for operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_STD
@@ -702,6 +708,12 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     case FPST_FPCR:
         offset = offsetof(CPUARMState, vfp.fp_status);
         break;
+    case FPST_A32:
+        offset = offsetof(CPUARMState, vfp.fp_status_a32);
+        break;
+    case FPST_A64:
+        offset = offsetof(CPUARMState, vfp.fp_status_a64);
+        break;
     case FPST_FPCR_F16:
         offset = offsetof(CPUARMState, vfp.fp_status_f16);
         break;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dc0231233a6..8bdd535db95 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -573,6 +573,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_default_nan_mode(1, &env->vfp.standard_fp_status);
     set_default_nan_mode(1, &env->vfp.standard_fp_status_f16);
     arm_set_default_fp_behaviours(&env->vfp.fp_status);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status_f16);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index afc41420eb1..7475f97e0ce 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -64,6 +64,8 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     uint32_t i;
 
     i = get_float_exception_flags(&env->vfp.fp_status);
+    i |= get_float_exception_flags(&env->vfp.fp_status_a32);
+    i |= get_float_exception_flags(&env->vfp.fp_status_a64);
     i |= get_float_exception_flags(&env->vfp.standard_fp_status);
     /* FZ16 does not generate an input denormal exception.  */
     i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
@@ -81,6 +83,8 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      * be the architecturally up-to-date exception flag information first.
      */
     set_float_exception_flags(0, &env->vfp.fp_status);
+    set_float_exception_flags(0, &env->vfp.fp_status_a32);
+    set_float_exception_flags(0, &env->vfp.fp_status_a64);
     set_float_exception_flags(0, &env->vfp.fp_status_f16);
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
     set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
@@ -109,6 +113,8 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
             break;
         }
         set_float_rounding_mode(i, &env->vfp.fp_status);
+        set_float_rounding_mode(i, &env->vfp.fp_status_a32);
+        set_float_rounding_mode(i, &env->vfp.fp_status_a64);
         set_float_rounding_mode(i, &env->vfp.fp_status_f16);
     }
     if (changed & FPCR_FZ16) {
@@ -122,10 +128,16 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         bool ftz_enabled = val & FPCR_FZ;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a64);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a64);
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16);
     }
 }
-- 
2.34.1


