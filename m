Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D0BE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbF3-00081z-Sj; Tue, 17 Dec 2024 12:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEw-0007z3-7P
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:10 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEi-0006DM-31
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:08 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3862b364538so3245691f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455992; x=1735060792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qu7n5SMfurjzkPz6Mh3VSolF3Qw9b8ZT5LnuFsdfpCY=;
 b=MJPqB2yW/FW+/dIQhjnSV8kPxzktMNX+IiHp+37+r3eEgzLmHBGZPUcZct2pRyjcAW
 JhLnR/qkNwEuRiPYTmuJR9Jpr/KS53LYLgSWVjUzXRSL28+6ssMLs20j6VaUgevTFUes
 5Jy9/WbXpIUMSgCXv5W1fXeg+ZyRtqBPcHNWjaxcPZpanwZ1Lw3X6db/RwK/HpKnBx29
 TJTN2y0iYzTKe6Ky8o/6KKzwg2/EdbaH3aClpPL4ROy/+SYRq+3WX9rMBMUfHv47n+C9
 vfuZHCeVbwEAXbCFD63tn/qrcEwZwr0OcpHo2SckCa8Mt/heuoRU68DQ5HiX1Tk0cKDD
 WEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455992; x=1735060792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qu7n5SMfurjzkPz6Mh3VSolF3Qw9b8ZT5LnuFsdfpCY=;
 b=avBBfQjVFrYDmc0Ri/1/q3THwFczgesxcaFX2tNOdUT12r4hyLhBSoTUBvqjK64kQj
 uzzwyO3qsISnvmoT8YenLLAdIi8x7fbS8URUhXL27hGciHHgR/zwMrq5YPxH3cQ8VyZG
 ItXxbxkb8gpwG41x5Ami0g0Gbsm3a9c+OxetlccSs5V/k7UcRjtM3p3oXPS0o/As0OtS
 IBnyH1YiDWBFQyzRycsXKh7vV5ZaI+sm9Tz3Kc8HQFP/RxnMhAUJSNk4ixu2zhetyXPA
 SSoIHooOloxSW9G2muoKixJO9Q8NV11CF2/PA0dcFqSKQwL6aQ3C/8tWqdi7qcHViRvr
 9qAg==
X-Gm-Message-State: AOJu0Yzk5D6xCqgMIhxt6E9bra4otFAxoAQdIxwLfeK6//Bci8FP2Ils
 RJ1Gu2zPJpJ4ilzei4wMU+U8pT9pbUyk81Ov9gzmAeYyVCxQSxp1N7pPGPXoD3SF1NtkVdb6loj
 S
X-Gm-Gg: ASbGnctYGtERCX1DqK+liMgMtOmWS4NAdw2vZhuWe8+yxKWdyQ8HmFPiU5QRF+2/gcH
 PDbwQionf8YCIOUKDRfH3GZOECjGYqIK6t1d1tUXJmIIFoIZLKX27LfMK6e4/5gi0DVa21hc8Sp
 tIOzePML+keaFhVjRLMaNVajchgpR3tHklKqlbb3kuf6o+KVXSMYzgXidl8F2dB7hAzysubOn7X
 C/Psmn7i5rZnMQs0G+jtjQ/rf9gApjZ0u9UXtAI5HeWRHAEqOqlqLF2v1jGVVY=
X-Google-Smtp-Source: AGHT+IFVeC4pUB7v1Jj5/UlFinktIcDBnioe3qyD5qpPCY8WJO4+cXmanU2sKzYGF4i37Qs+zNEEpw==
X-Received: by 2002:a05:6000:987:b0:382:3211:6b7e with SMTP id
 ffacd0b85a97d-388db266e4amr2913090f8f.31.1734455992187; 
 Tue, 17 Dec 2024 09:19:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/19] target/arm: Implement fine-grained-trap handling for
 FEAT_XS
Date: Tue, 17 Dec 2024 17:19:30 +0000
Message-Id: <20241217171937.3899947-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

FEAT_XS introduces a set of new TLBI maintenance instructions with an
"nXS" qualifier.  These behave like the stardard ones except that
they do not wait for memory accesses with the XS attribute to
complete.  They have an interaction with the fine-grained-trap
handling: the FGT bits that a hypervisor can use to trap TLBI
maintenance instructions normally trap also the nXS variants, but the
hypervisor can elect to not trap the nXS variants by setting
HCRX_EL2.FGTnXS to 1.

Add support to our FGT mechanism for these TLBI bits. For each
TLBI-trapping FGT bit we define, for example:
 * FGT_TLBIVAE1 -- the same value we do at present for the
   normal variant of the insn
 * FGT_TLBIVAE1NXS -- for the nXS qualified insn; the value of
   this enum has an NXS bit ORed into it

In access_check_cp_reg() we can then ignore the trap bit for an
access where ri->fgt has the NXS bit set and HCRX_EL2.FGTnXS is 1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211144440.2700268-2-peter.maydell@linaro.org
---
 target/arm/cpregs.h        | 72 ++++++++++++++++++++++----------------
 target/arm/cpu-features.h  |  5 +++
 target/arm/helper.c        |  5 ++-
 target/arm/tcg/op_helper.c | 11 +++++-
 4 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index cc7c54378f4..87704762ef9 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -621,6 +621,7 @@ FIELD(HDFGWTR_EL2, NBRBCTL, 60, 1)
 FIELD(HDFGWTR_EL2, NBRBDATA, 61, 1)
 FIELD(HDFGWTR_EL2, NPMSNEVFR_EL1, 62, 1)
 
+FIELD(FGT, NXS, 13, 1) /* Honour HCR_EL2.FGTnXS to suppress FGT */
 /* Which fine-grained trap bit register to check, if any */
 FIELD(FGT, TYPE, 10, 3)
 FIELD(FGT, REV, 9, 1) /* Is bit sense reversed? */
@@ -639,6 +640,17 @@ FIELD(FGT, BITPOS, 0, 6) /* Bit position within the uint64_t */
 #define DO_REV_BIT(REG, BITNAME)                                        \
     FGT_##BITNAME = FGT_##REG | FGT_REV | R_##REG##_EL2_##BITNAME##_SHIFT
 
+/*
+ * The FGT bits for TLBI maintenance instructions accessible at EL1 always
+ * affect the "normal" TLBI insns; they affect the corresponding TLBI insns
+ * with the nXS qualifier only if HCRX_EL2.FGTnXS is 0. We define e.g.
+ * FGT_TLBIVAE1 to use for the normal insn, and FGT_TLBIVAE1NXS to use
+ * for the nXS qualified insn.
+ */
+#define DO_TLBINXS_BIT(REG, BITNAME)                             \
+    FGT_##BITNAME = FGT_##REG | R_##REG##_EL2_##BITNAME##_SHIFT, \
+    FGT_##BITNAME##NXS = FGT_##BITNAME | R_FGT_NXS_MASK
+
 typedef enum FGTBit {
     /*
      * These bits tell us which register arrays to use:
@@ -772,36 +784,36 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, ATS1E0W),
     DO_BIT(HFGITR, ATS1E1RP),
     DO_BIT(HFGITR, ATS1E1WP),
-    DO_BIT(HFGITR, TLBIVMALLE1OS),
-    DO_BIT(HFGITR, TLBIVAE1OS),
-    DO_BIT(HFGITR, TLBIASIDE1OS),
-    DO_BIT(HFGITR, TLBIVAAE1OS),
-    DO_BIT(HFGITR, TLBIVALE1OS),
-    DO_BIT(HFGITR, TLBIVAALE1OS),
-    DO_BIT(HFGITR, TLBIRVAE1OS),
-    DO_BIT(HFGITR, TLBIRVAAE1OS),
-    DO_BIT(HFGITR, TLBIRVALE1OS),
-    DO_BIT(HFGITR, TLBIRVAALE1OS),
-    DO_BIT(HFGITR, TLBIVMALLE1IS),
-    DO_BIT(HFGITR, TLBIVAE1IS),
-    DO_BIT(HFGITR, TLBIASIDE1IS),
-    DO_BIT(HFGITR, TLBIVAAE1IS),
-    DO_BIT(HFGITR, TLBIVALE1IS),
-    DO_BIT(HFGITR, TLBIVAALE1IS),
-    DO_BIT(HFGITR, TLBIRVAE1IS),
-    DO_BIT(HFGITR, TLBIRVAAE1IS),
-    DO_BIT(HFGITR, TLBIRVALE1IS),
-    DO_BIT(HFGITR, TLBIRVAALE1IS),
-    DO_BIT(HFGITR, TLBIRVAE1),
-    DO_BIT(HFGITR, TLBIRVAAE1),
-    DO_BIT(HFGITR, TLBIRVALE1),
-    DO_BIT(HFGITR, TLBIRVAALE1),
-    DO_BIT(HFGITR, TLBIVMALLE1),
-    DO_BIT(HFGITR, TLBIVAE1),
-    DO_BIT(HFGITR, TLBIASIDE1),
-    DO_BIT(HFGITR, TLBIVAAE1),
-    DO_BIT(HFGITR, TLBIVALE1),
-    DO_BIT(HFGITR, TLBIVAALE1),
+    DO_TLBINXS_BIT(HFGITR, TLBIVMALLE1OS),
+    DO_TLBINXS_BIT(HFGITR, TLBIVAE1OS),
+    DO_TLBINXS_BIT(HFGITR, TLBIASIDE1OS),
+    DO_TLBINXS_BIT(HFGITR, TLBIVAAE1OS),
+    DO_TLBINXS_BIT(HFGITR, TLBIVALE1OS),
+    DO_TLBINXS_BIT(HFGITR, TLBIVAALE1OS),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVAE1OS),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVAAE1OS),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVALE1OS),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVAALE1OS),
+    DO_TLBINXS_BIT(HFGITR, TLBIVMALLE1IS),
+    DO_TLBINXS_BIT(HFGITR, TLBIVAE1IS),
+    DO_TLBINXS_BIT(HFGITR, TLBIASIDE1IS),
+    DO_TLBINXS_BIT(HFGITR, TLBIVAAE1IS),
+    DO_TLBINXS_BIT(HFGITR, TLBIVALE1IS),
+    DO_TLBINXS_BIT(HFGITR, TLBIVAALE1IS),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVAE1IS),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVAAE1IS),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVALE1IS),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVAALE1IS),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVAE1),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVAAE1),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVALE1),
+    DO_TLBINXS_BIT(HFGITR, TLBIRVAALE1),
+    DO_TLBINXS_BIT(HFGITR, TLBIVMALLE1),
+    DO_TLBINXS_BIT(HFGITR, TLBIVAE1),
+    DO_TLBINXS_BIT(HFGITR, TLBIASIDE1),
+    DO_TLBINXS_BIT(HFGITR, TLBIVAAE1),
+    DO_TLBINXS_BIT(HFGITR, TLBIVALE1),
+    DO_TLBINXS_BIT(HFGITR, TLBIVAALE1),
     DO_BIT(HFGITR, CFPRCTX),
     DO_BIT(HFGITR, DVPRCTX),
     DO_BIT(HFGITR, CPPRCTX),
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e806f138b8f..30302d6c5b4 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -474,6 +474,11 @@ static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
 }
 
+static inline bool isar_feature_aa64_xs(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, XS) != 0;
+}
+
 /*
  * These are the values from APA/API/APA3.
  * In general these must be compared '>=', per the normal Arm ARM
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 910ae62c476..8e62769ec0d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5346,10 +5346,13 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
         valid_mask |= HCRX_TALLINT | HCRX_VINMI | HCRX_VFNMI;
     }
     /* FEAT_CMOW adds CMOW */
-
     if (cpu_isar_feature(aa64_cmow, cpu)) {
         valid_mask |= HCRX_CMOW;
     }
+    /* FEAT_XS adds FGTnXS, FnXS */
+    if (cpu_isar_feature(aa64_xs, cpu)) {
+        valid_mask |= HCRX_FGTNXS | HCRX_FNXS;
+    }
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 1ecb4659889..1161d301b71 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -817,6 +817,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         unsigned int idx = FIELD_EX32(ri->fgt, FGT, IDX);
         unsigned int bitpos = FIELD_EX32(ri->fgt, FGT, BITPOS);
         bool rev = FIELD_EX32(ri->fgt, FGT, REV);
+        bool nxs = FIELD_EX32(ri->fgt, FGT, NXS);
         bool trapbit;
 
         if (ri->fgt & FGT_EXEC) {
@@ -830,7 +831,15 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
             trapword = env->cp15.fgt_write[idx];
         }
 
-        trapbit = extract64(trapword, bitpos, 1);
+        if (nxs && (arm_hcrx_el2_eff(env) & HCRX_FGTNXS)) {
+            /*
+             * If HCRX_EL2.FGTnXS is 1 then the fine-grained trap for
+             * TLBI maintenance insns does *not* apply to the nXS variant.
+             */
+            trapbit = 0;
+        } else {
+            trapbit = extract64(trapword, bitpos, 1);
+        }
         if (trapbit != rev) {
             res = CP_ACCESS_TRAP_EL2;
             goto fail;
-- 
2.34.1


