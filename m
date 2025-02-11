Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C690DC021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht77-00019I-HZ; Tue, 11 Feb 2025 11:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6D-0006xB-4m
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:02 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht68-0003d2-Ru
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:58 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso40472725e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291215; x=1739896015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kbu4pc+zogRWu6uXYrZLOamaF8sA1Rc2dDB91mMAtCw=;
 b=s05pnxC/R1lfAHkZaJ8FCQOlaCJUMaR9Pefp5dQQWxybl9kc9ehxbGTzCozoL0ANoQ
 eMmjFbH2mgAsPoIK+ooZPK1AkmKRaMtL41cLvC1vALxn6buHs7WcGYX5UEgWVc6r+2fp
 6zOwPlDMLHd2gFQcwfPHJXTQ7Ntpxm8z4NrBdrCP7VSOZuAKN8Qgi5VQMInJcGuE+1K/
 ljpZiuhafpMvtBhIoBoIXGwM8Hsbpz+W/8HYlmuQCX5+NpIrJkhYHaM7Pduh4zfCsmMX
 UiTPOmeiS9NIPiwP9vS9/3KRbJGue587R3IyW1Rn6G5VaUji0HBl9QUH11RjkudJmhbt
 7fjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291215; x=1739896015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbu4pc+zogRWu6uXYrZLOamaF8sA1Rc2dDB91mMAtCw=;
 b=nGDTAWwrea+gwsiWG1vdL+gr9eZbOsAak+W7/Lz3gvrHQxoqoTEz4svM9Z0G4yd2aK
 phevPWi3ruYK5O5B/qFb4iTHDXF3zEFq2AQoX4XTEwkAdME3s58v70nOMFSfkSVx7NYQ
 NnuobPaesUaJi5r5D1AE5vZOzfcvs61mp2we3N9Wy3zb9Na4DVq1g6PI1CRSePDVxxjx
 Ij9XZgqoHRThfNIFytnYeZVOCZVcdCpF19h4hBYHkP702eYKhBuR2sdXDqTGvMpCJToG
 IN0moU8Wwes6fZhpeOxUlj9Dux/cas2Sb9jtqLyyA83na1K3TNkFqwyiMwTxsSBJ5qM3
 WvWA==
X-Gm-Message-State: AOJu0YxlOYbXFlHXCWbxIe83G+mQSGUrklCKC192Se22Smo8kJg4XBzq
 SztobVBn4kADcSSwXpOIoTKMvI/ORsO6V6TwC42qeyKLelQXrQxKvw7G/XDIyfTFlNmjjE1K6hz
 w
X-Gm-Gg: ASbGnct+Pizp55Im5UQPEu6Dx8TAw2eq+osByw5kZsBVfpiGiePUdhn9dfDOuf5/zaX
 n92ZA9yD8KoVJjwGJRkBmSXiNnZ4BqoRE7wHnuBlklCDqU+jgEnPnLWqi/NGNmSQV60cS0WpZ5T
 so1Lx/rNfU+Mn1g8511euYFloUDU+dC29+FnHonze7FXJ4TyHm1HctYskB5N7w0djoDN4nMbh+/
 00FknKYktC30DlViFr80UDgG1iwmzCcS6arKXoyVPvEatuW76AdrzXMuBzEUQicuSHnMjPSX4D0
 BuM2rGbD9tEVZeiIw2cl
X-Google-Smtp-Source: AGHT+IF8Nxv4SatVnIO/VEIbdAr67aBaOMIPevsoK0gX3n9MXquyAl5tL7r/MJCpzg25bP2BS3XS7Q==
X-Received: by 2002:a05:600c:56d0:b0:434:9c1b:b36a with SMTP id
 5b1f17b1804b1-4392dfbd5d8mr130264755e9.13.1739291215152; 
 Tue, 11 Feb 2025 08:26:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/68] target/arm: Introduce CPUARMState.vfp.fp_status[]
Date: Tue, 11 Feb 2025 16:25:42 +0000
Message-Id: <20250211162554.4135349-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Move ARMFPStatusFlavour to cpu.h with which to index
this array.  For now, place the array in an anonymous
union with the existing structures.  Adjust the order
of the existing structures to match the enum.

Simplify fpstatus_ptr() using the new array.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           | 119 +++++++++++++++++++++----------------
 target/arm/tcg/translate.h |  64 +-------------------
 2 files changed, 70 insertions(+), 113 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 24b0a5fcb9f..bf68e135d73 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -202,6 +202,61 @@ typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
 
 typedef struct NVICState NVICState;
 
+/*
+ * Enum for indexing vfp.fp_status[].
+ *
+ * FPST_A32: is the "normal" fp status for AArch32 insns
+ * FPST_A64: is the "normal" fp status for AArch64 insns
+ * FPST_A32_F16: used for AArch32 half-precision calculations
+ * FPST_A64_F16: used for AArch64 half-precision calculations
+ * FPST_STD: the ARM "Standard FPSCR Value"
+ * FPST_STD_F16: used for half-precision
+ *       calculations with the ARM "Standard FPSCR Value"
+ * FPST_AH: used for the A64 insns which change behaviour
+ *       when FPCR.AH == 1 (bfloat16 conversions and multiplies,
+ *       and the reciprocal and square root estimate/step insns)
+ * FPST_AH_F16: used for the A64 insns which change behaviour
+ *       when FPCR.AH == 1 (bfloat16 conversions and multiplies,
+ *       and the reciprocal and square root estimate/step insns);
+ *       for half-precision
+ *
+ * Half-precision operations are governed by a separate
+ * flush-to-zero control bit in FPSCR:FZ16. We pass a separate
+ * status structure to control this.
+ *
+ * The "Standard FPSCR", ie default-NaN, flush-to-zero,
+ * round-to-nearest and is used by any operations (generally
+ * Neon) which the architecture defines as controlled by the
+ * standard FPSCR value rather than the FPSCR.
+ *
+ * The "standard FPSCR but for fp16 ops" is needed because
+ * the "standard FPSCR" tracks the FPSCR.FZ16 bit rather than
+ * using a fixed value for it.
+ *
+ * The ah_fp_status is needed because some insns have different
+ * behaviour when FPCR.AH == 1: they don't update cumulative
+ * exception flags, they act like FPCR.{FZ,FIZ} = {1,1} and
+ * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
+ * which means we need an ah_fp_status_f16 as well.
+ *
+ * To avoid having to transfer exception bits around, we simply
+ * say that the FPSCR cumulative exception flags are the logical
+ * OR of the flags in the four fp statuses. This relies on the
+ * only thing which needs to read the exception flags being
+ * an explicit FPSCR read.
+ */
+typedef enum ARMFPStatusFlavour {
+    FPST_A32,
+    FPST_A64,
+    FPST_A32_F16,
+    FPST_A64_F16,
+    FPST_AH,
+    FPST_AH_F16,
+    FPST_STD,
+    FPST_STD_F16,
+} ARMFPStatusFlavour;
+#define FPST_COUNT  8
+
 typedef struct CPUArchState {
     /* Regs for current mode.  */
     uint32_t regs[16];
@@ -631,56 +686,20 @@ typedef struct CPUArchState {
         /* Scratch space for aa32 neon expansion.  */
         uint32_t scratch[8];
 
-        /* There are a number of distinct float control structures:
-         *
-         *  fp_status_a32: is the "normal" fp status for AArch32 insns
-         *  fp_status_a64: is the "normal" fp status for AArch64 insns
-         *  fp_status_fp16_a32: used for AArch32 half-precision calculations
-         *  fp_status_fp16_a64: used for AArch64 half-precision calculations
-         *  standard_fp_status : the ARM "Standard FPSCR Value"
-         *  standard_fp_status_fp16 : used for half-precision
-         *       calculations with the ARM "Standard FPSCR Value"
-         *  ah_fp_status: used for the A64 insns which change behaviour
-         *       when FPCR.AH == 1 (bfloat16 conversions and multiplies,
-         *       and the reciprocal and square root estimate/step insns)
-         *  ah_fp_status_f16: used for the A64 insns which change behaviour
-         *       when FPCR.AH == 1 (bfloat16 conversions and multiplies,
-         *       and the reciprocal and square root estimate/step insns);
-         *       for half-precision
-         *
-         * Half-precision operations are governed by a separate
-         * flush-to-zero control bit in FPSCR:FZ16. We pass a separate
-         * status structure to control this.
-         *
-         * The "Standard FPSCR", ie default-NaN, flush-to-zero,
-         * round-to-nearest and is used by any operations (generally
-         * Neon) which the architecture defines as controlled by the
-         * standard FPSCR value rather than the FPSCR.
-         *
-         * The "standard FPSCR but for fp16 ops" is needed because
-         * the "standard FPSCR" tracks the FPSCR.FZ16 bit rather than
-         * using a fixed value for it.
-         *
-         * The ah_fp_status is needed because some insns have different
-         * behaviour when FPCR.AH == 1: they don't update cumulative
-         * exception flags, they act like FPCR.{FZ,FIZ} = {1,1} and
-         * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
-         * which means we need an ah_fp_status_f16 as well.
-         *
-         * To avoid having to transfer exception bits around, we simply
-         * say that the FPSCR cumulative exception flags are the logical
-         * OR of the flags in the four fp statuses. This relies on the
-         * only thing which needs to read the exception flags being
-         * an explicit FPSCR read.
-         */
-        float_status fp_status_a32;
-        float_status fp_status_a64;
-        float_status fp_status_f16_a32;
-        float_status fp_status_f16_a64;
-        float_status standard_fp_status;
-        float_status standard_fp_status_f16;
-        float_status ah_fp_status;
-        float_status ah_fp_status_f16;
+        /* There are a number of distinct float control structures. */
+        union {
+            float_status fp_status[FPST_COUNT];
+            struct {
+                float_status fp_status_a32;
+                float_status fp_status_a64;
+                float_status fp_status_f16_a32;
+                float_status fp_status_f16_a64;
+                float_status ah_fp_status;
+                float_status ah_fp_status_f16;
+                float_status standard_fp_status;
+                float_status standard_fp_status_f16;
+            };
+        };
 
         uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
         uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 0dff00015e8..f8dc2f0d4bb 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -670,80 +670,18 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
     return (CPUARMTBFlags){ tb->flags, tb->cs_base };
 }
 
-/*
- * Enum for argument to fpstatus_ptr().
- */
-typedef enum ARMFPStatusFlavour {
-    FPST_A32,
-    FPST_A64,
-    FPST_A32_F16,
-    FPST_A64_F16,
-    FPST_AH,
-    FPST_AH_F16,
-    FPST_STD,
-    FPST_STD_F16,
-} ARMFPStatusFlavour;
-
 /**
  * fpstatus_ptr: return TCGv_ptr to the specified fp_status field
  *
  * We have multiple softfloat float_status fields in the Arm CPU state struct
  * (see the comment in cpu.h for details). Return a TCGv_ptr which has
  * been set up to point to the requested field in the CPU state struct.
- * The options are:
- *
- * FPST_A32
- *   for AArch32 non-FP16 operations controlled by the FPCR
- * FPST_A64
- *   for AArch64 non-FP16 operations controlled by the FPCR
- * FPST_A32_F16
- *   for AArch32 operations controlled by the FPCR where FPCR.FZ16 is to be used
- * FPST_A64_F16
- *   for AArch64 operations controlled by the FPCR where FPCR.FZ16 is to be used
- * FPST_AH:
- *   for AArch64 operations which change behaviour when AH=1 (specifically,
- *   bfloat16 conversions and multiplies, and the reciprocal and square root
- *   estimate/step insns)
- * FPST_AH_F16:
- *   ditto, but for half-precision operations
- * FPST_STD
- *   for A32/T32 Neon operations using the "standard FPSCR value"
- * FPST_STD_F16
- *   as FPST_STD, but where FPCR.FZ16 is to be used
  */
 static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
 {
     TCGv_ptr statusptr = tcg_temp_new_ptr();
-    int offset;
+    int offset = offsetof(CPUARMState, vfp.fp_status[flavour]);
 
-    switch (flavour) {
-    case FPST_A32:
-        offset = offsetof(CPUARMState, vfp.fp_status_a32);
-        break;
-    case FPST_A64:
-        offset = offsetof(CPUARMState, vfp.fp_status_a64);
-        break;
-    case FPST_A32_F16:
-        offset = offsetof(CPUARMState, vfp.fp_status_f16_a32);
-        break;
-    case FPST_A64_F16:
-        offset = offsetof(CPUARMState, vfp.fp_status_f16_a64);
-        break;
-    case FPST_AH:
-        offset = offsetof(CPUARMState, vfp.ah_fp_status);
-        break;
-    case FPST_AH_F16:
-        offset = offsetof(CPUARMState, vfp.ah_fp_status_f16);
-        break;
-    case FPST_STD:
-        offset = offsetof(CPUARMState, vfp.standard_fp_status);
-        break;
-    case FPST_STD_F16:
-        offset = offsetof(CPUARMState, vfp.standard_fp_status_f16);
-        break;
-    default:
-        g_assert_not_reached();
-    }
     tcg_gen_addi_ptr(statusptr, tcg_env, offset);
     return statusptr;
 }
-- 
2.34.1


