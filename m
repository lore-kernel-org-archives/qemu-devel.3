Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75532C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZL-0001Vl-4p; Sat, 01 Feb 2025 11:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYl-0007Ro-Lt
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYj-0001Le-Hd
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:31 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso22548795e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428088; x=1739032888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SzNiCTM1wRDHeMF6JHYRq3YiojwFkHP92UV866vxOSE=;
 b=YvXv+BcoHqdozDGpcT4l1ieFEgu3ypxRJKj1Y02wRmjXUy4QHx1x2Nssvd/kkaFheo
 F/0Y/iL6Zn+42H1VVQX/CH8nG5OONv4LU8yhGGrfTgaGaYMt489P8MkRQSUHkdvKs/re
 Kvg4423ALHXmgmvqhT7M1EXEoBaWQUyucaHcmqn5ylIWOwPKM6E8HeSs2EeO2furTSON
 p6V1MxVeTuxdHAkJ9I8uOHFAzHVYQMriNJ6y5Vxk0ieDsKbI+zy//iXYyDo00ee3eZsJ
 XnjNi0pxjWMOrFMEPli1NcOixYiZ9b5qsnZo/AojYyWCkKEMKvLc84uXwqHgGMf8pRcr
 CMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428088; x=1739032888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzNiCTM1wRDHeMF6JHYRq3YiojwFkHP92UV866vxOSE=;
 b=uFo5qYyi0o0thyGpyrnd3FpXQ2zdvwkdledfLZ0iCZfAcztVwpeHrzEDGaiHIm4bzI
 zXYohCsZdojMeeXP9FjWr9TwSZ3QJg2krbV3umZfsykZHSU49BhzK5lXcAagfVhtPrG0
 /wyUiqe7g7nM107qpkv4Ui+JYXTcARiH0gNgoEZl/C1McEaoGCjoxT60XnYBaJXzRY5O
 N3uNwErdk9CK+HqNSKsbG9q3cCKv6bs9XEaJ6j2Yk4mn6Td0wYjLjlqFoDKeyIdhI8is
 ah31sG+yVdsEaTlKlkVVBa96BLddMWi82PFgZ3myDMuhkr+tVgfs9gCZnMlwYIPoKdm8
 SSPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMMzCEAfdPz6z6bKX3Tq87o0tA1swWs3YkCjJzVtOC7lsYJylsYegsBXaXFfxU3fCL85E6HiQebvjz@nongnu.org
X-Gm-Message-State: AOJu0Yzvduz3C2xw7hFABymxtDVIcf9NSegRX+VfzBUFe6UiBBwZFIit
 6SunrETPVqWPxA8GeutvEb/suybaMh0KFh+xFZAiEHQHxTkwcWy9W1MGHjFmSj8=
X-Gm-Gg: ASbGncv9X7EwWRKShukxKTxk9a4VYAiFa0WsixOVumgz3u01LXIGln62VXgomj4WKGk
 VIhHDlaImev4LlCzH7UzhqMA0txBWNCz0SB3d+cry1jFtla+6B/MVX1U3euhcTYS09bVHpj6fqx
 6/O6Ug7vl18jtaN+EZBwbV/g3L7tylIl4UM53S9mqwKyd0cJp31AxI8wZs2E90LNlzIpfkzkgBT
 azL84OmfcoyBdXLjmiFTWHC05dhGLKM0OuGQM/XRhjttCq8Cnytk4DVDteQbKzzsQwbQmavV7IC
 q8CzhxVbY6G45kFmu67O
X-Google-Smtp-Source: AGHT+IGIIBrdG4po1XZ8VvRBLRvCWOdJQCbI6EEcKotFIdvtrHHT7Lyh7fX8z5tAxzTkodZHqaieJw==
X-Received: by 2002:a05:600c:1c99:b0:431:5044:e388 with SMTP id
 5b1f17b1804b1-438dc40be3dmr125177545e9.22.1738428087910; 
 Sat, 01 Feb 2025 08:41:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 57/69] target/arm: Introduce CPUARMState.vfp.fp_status[]
Date: Sat,  1 Feb 2025 16:40:00 +0000
Message-Id: <20250201164012.1660228-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
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
index f562e0687c9..c025649ff24 100644
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


