Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75259C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYUr-0006Rr-Gq; Mon, 27 Jan 2025 18:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUh-0006LX-5l
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:15 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUd-0005XZ-LT
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:14 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so6948913a91.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020370; x=1738625170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vVvCoSEED6StCi5sBDfcgbMdG6XA3WhhdL8usKsqm8=;
 b=b3Say35nkh5LlZ4EeLZIf7j3CmlNnU2mTQNIKs+sA3jYP8YbqhPCWfOtIzGRtou/JE
 V83LZidyEBIXpgVmycYPDVxHo2qwfrnkzWCNUOAxI0qHzF0rdrfRgLYKjdGipAhTbTSO
 YYlnaWNN1d56vQ6glKJG9sTV8UlF9y6nqJQprUPzUfSA/RR5caC8mDzwRS4ESKL4br1W
 Pbjce1Ly3To1l7lIgFJE1zn7WcN0/e0i+eVK2Ysrx2BMFxtOKTKDi/vg6QO4c/26o241
 /0H4oZ4WuABymSJhQ8ck7Hzn7tHpPKgJMbV0SzBWKuAoUp+xI0/JRWo2rZ6YidxWdl42
 8JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020370; x=1738625170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vVvCoSEED6StCi5sBDfcgbMdG6XA3WhhdL8usKsqm8=;
 b=abp+qHHYxhmKsd8BzwNNwo/wLbwJoQm5MhcfgXzsVeL41BN7NZ1u2KCb2+PsfFBGXX
 XOux2hZMLoaLykTMFSRDNbeEVu2QbAbpcX48gDcpKIKZqSH0oryxMBnXV092Jm3SRpDl
 /YGXeuWybaz3POQOgv2f0DZrtrNZlBBGE7tVx4vvBYsdrpj7/stSx3tqDMwqaW5Dpjkr
 dVRKC3QBg2nxVzIo8J6xKLDiuSBaTojvzU2qxuzP9zapqYT0K+peiAHTYFEFRp8g+aJz
 LgtH/ine9f7yiFrbki6nwbvyQjU/9NY4FatvcV3xyk97MeOH4t2FAW3Ncfu4tTvHyAsk
 BdWg==
X-Gm-Message-State: AOJu0YxbiB17U3b6PBGBAUjbDSZMAjW7tMjA2oBX7uZxXxZ3Jxj9aNXl
 mQkq2dt3djRY5SBjHDMgPdUOfdC3VqBCEqVZz/uJ1EmZqJAFjssTp2apOdoNNTWQ+8xqNn0Bh1W
 j
X-Gm-Gg: ASbGncvKxeiGSzHyShkY7zGQhsSxyGd4IhZnbsUs+ZtNprKtpkOUc8Vvyr1TiiJROsi
 BqgiCNI/QMxvY7cl+VEBHSaGCmZ5uV4+snlFJz0JR2Y+KXYzoETxWPZprPkHSK8MnLHpEnRQzVE
 3Ozka/Z8XvMEOgIdcAhSz4rRVy6H2+BPFyhXAab2gskZ9gAL7UBsVJVCWVx0oJ1fyP917zwt5pD
 6QsiOw0s6nTxUbMwNpwMxHRxhbbTQDxRSwYLvuVlNP8MG5YJqAhGfVyMMYj+Qd8PmR5A0ZzfVxd
 P4T/hEKI9EpePX0l2oU0QtHEdoH0BHL9WGqWbHI=
X-Google-Smtp-Source: AGHT+IHNB54/w6AULh5aWPnemOEaR7eAUQXk6xOoAMbwg8aSTtQLaCe4u68UFyOYobAAaIUA4G/aJA==
X-Received: by 2002:a17:90b:534b:b0:2f6:f107:fae6 with SMTP id
 98e67ed59e1d1-2f782d32397mr51458002a91.23.1738020370305; 
 Mon, 27 Jan 2025 15:26:10 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 06/22] target/arm: Introduce CPUARMState.vfp.fp_status[]
Date: Mon, 27 Jan 2025 15:25:48 -0800
Message-ID: <20250127232604.20386-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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


