Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF025C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2q-0000nD-21; Tue, 28 Jan 2025 20:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2o-0000mx-Gi
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:06 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2m-0003UP-Gt
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:06 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2163dc5155fso115848885ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114743; x=1738719543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vVvCoSEED6StCi5sBDfcgbMdG6XA3WhhdL8usKsqm8=;
 b=mLvN5AB6Cjp1oNZC+A81K35Ih8mMG80r1PWySm2o3e7rT3IelMwa6dWlq80TgRskug
 D6KtDfzjv29VNxotGvhsi6NOUptQUMT926YBe3TTWz+9Pp+D8Hs+b0EiqogS1IxMwAJq
 Kb57LNo50bifrFNCozMjRK5vhv+wAFdWQg1Z68dZ1OHQLS9S97OaKfuHV5VvhYf0I6Jh
 Fn5NDVLfZMB/nBEdWsr1jL+lc0h+83QsaUtYKRRPWKuM/WhvRE7jkiCTquBbHJ0BzBqt
 wH84Njbww8WgrOvKjeXQGbtYi59WK+Ah06JAWd6nCvCiL2F+EV84TZ+x+pHp77nbL6Io
 5AVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114743; x=1738719543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vVvCoSEED6StCi5sBDfcgbMdG6XA3WhhdL8usKsqm8=;
 b=CdPkse7/K2Sm/gWzWNtv+lJX2Fp0HHoWZzGyc+D6Pyv9pGZ5TbzUNAgnlSL41ArPH/
 ModwMqN7F72A4YVuZvnVZ/DmTHxIGZoVphUqdOhYmkZRpKw0S/XjIukKRx4kz5la+Ffp
 f2y8g38D5UTlcYCNhgmH9MNsbRK834xu5t24zSTC1v49Ov+Dx0D7TWkTVf1vjjV7Dp6p
 Jatte85LhdbesKn3yHEqhlDkFztUezgfZjWbbDMIihloWmKuqDzknPzAqnliqNuwsM3H
 abGkpaYAwmWAInTKm21pku/YfnkGA98TK0QJNTmLMRE6m+DBs3wTmMJnYYPp28BciSCq
 TjLw==
X-Gm-Message-State: AOJu0Ywk2sYMF3PQXEEBvzCImXxtNTDoTzUll5jBrRRwYR/Dj+jFpC75
 ZQqbF+OMTUefY9irm9pkLExRij9iHu8pdLhbOA7j81PkkFQJ8BDeT1UHiU08qaYXyEbwTV/kJca
 7
X-Gm-Gg: ASbGncvVFjz91zxQ0zEX8Ct4isliyvV9tOsR5TdBpUqF/V78Xf6aZoVl2kMyFIyLD/P
 sP3DTLlA9YcJxiYHmMdpbx1ALAEhGsQRlBo38zQJHrchtwE1OA3IEFQIrFFQmWA9GtpXLTG5uBn
 PNKvw43uPhZiGDIXrx0QCWiGhZ8X1snyU4aszYClAVQSnobgzx7DLfODUTpAV2sOCpYbIitxc0w
 aOf8wspFELU21UYQSK0wPqzQxLU8iYnp8BfCYYFrX7Nrxhqwb2MVhtv4zUCroOYdY9Z7zNbBOds
 uTpxA5x7m/kdYoqCJ4jjDcAnO6bmSwznPP/7Qjp3NqT7d/5nhg==
X-Google-Smtp-Source: AGHT+IFEj47FoLSpNWOLZJAVY9iY/GC9cMYelqnMfrRotXb789dR9pPZuFl841LiQwyoDq/DQIIEZA==
X-Received: by 2002:a17:902:e74a:b0:216:4499:b836 with SMTP id
 d9443c01a7336-21dd7d6637cmr18423855ad.26.1738114742989; 
 Tue, 28 Jan 2025 17:39:02 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 06/34] target/arm: Introduce CPUARMState.vfp.fp_status[]
Date: Tue, 28 Jan 2025 17:38:29 -0800
Message-ID: <20250129013857.135256-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Move ARMFPStatusFlavour to cpu.h with which to index
this array.  For now, place the array in an anonymous
union with the existing structures.  Adjust the order
of the existing structures to match the enum.

Simplify fpstatus_ptr() using the new array.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 119 +++++++++++++++++++++----------------
 target/arm/tcg/translate.h |  64 +-------------------
 2 files changed, 70 insertions(+), 113 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f562e0687c..c025649ff2 100644
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
index d4ae39c469..6f854f1031 100644
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
2.43.0


