Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84961E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNxJ-0006rY-6I; Wed, 11 Dec 2024 09:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxH-0006qo-RX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:47 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxF-0003qk-8b
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:47 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-435004228c0so29576845e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733928284; x=1734533084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=na2mVMXjYERuCY2HfRkKGK/haMymRcX2C110KFrsYNY=;
 b=ORHtmYyBFOZWzDHgAV9xx+P1M6MDUsbQIUB47p41H7evCN0EU2NG6iRrZjrdkWk4Hu
 92He0QvuUtysAfPnCRM8ilmKSe960SYNgaohHC6Z2NGXkR9AgvJjWa/PyhaiI3LID2nj
 RRpH/hmFvk2qGOSAjqRhK9JuI+tpu3yX+XKP2G2fBU5d3ZpVfDaV7KbMB7AHhJ/iuoio
 bAToB2b2BbC52IOUyKW1/D9ycn4o+F0+FrOl0w6tmOO536pUF4WkyBtgwE8h/apsofVX
 LbGc+zid7ExiYEa2MS0VcR2uBdQpc1s6wN/2TQWvX4/X5AZ5Ql6WWqXGgB0WfY+Fd7ca
 TJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928284; x=1734533084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=na2mVMXjYERuCY2HfRkKGK/haMymRcX2C110KFrsYNY=;
 b=ZWl42uJGcpeRaDJZN30OHp4t1EGxbC+AaFDVTR5h7Y/5kyKsH/53mjSSX5vCqzqAkD
 QKDW2yldcligTQj4vCZLmcQEZnT71SyepXYuC77KSbpHbjQioYFE4eqG1GgJQ8fzIzMm
 15V3oIafCEtrNVfBrwRH+a0pzpUJXKHQcd+bZ8WooxQpZy8X7fnUmiPZsB/ESLOGvn4B
 ICKrF/OTFooiBZoZl3mmwx3sRZKa4jJ4VYRrc82CkXnWGy/9LLpLKOZTuaTe6ysnE97n
 xOJURSZNqBd0CEZrlHBRXcpMDM7OoFRBimdhlUh3I7dDOg6MvdrfQop0B2+0z17FJEQW
 lijw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlWbvE75JlGk2QjhuLq+KLcbNhJU4YXW02TSKYyfbxgv/CBtYK1vwvDdxmoDaUViEIFdHa/8uKIxnL@nongnu.org
X-Gm-Message-State: AOJu0YxrQ+Fitlskqs+U5gLJ9OAS29vUFO1F3aagkvUd2WA9hE4rmh8M
 kV8V9+IKio8YGub90TtVj9RjGA6P7gRZfCqy6LJ5JyHbwG5IgmO7wtR9KdkyvpQ=
X-Gm-Gg: ASbGnctJQYIxsGGLgYidMkVKkO43mXhBgQEJ2vvHzj7bOWJB/52EXXmUAytPky+2Zzo
 bscdrvqEsdFmKuCJUHCUTsZ8u7ebYaADkwrjQl/cjFA466QoPwpo8/2MIjA+MuL3/SZzMgN8v69
 iVImHYgeMKXhv+OLJhj1eH53JMznGsiPwFgXXgmSzhuUhgixrX2WEHmQSsHBMYohRh4k1lc2alf
 rohpwQkjZQmePMjN6T+opTHffkamoKoLyNN5NS+vMHPkOiKBcilQG/Zv5pY
X-Google-Smtp-Source: AGHT+IGosAjhqHyVcCafiF3oKnSrx57sKB+artIlZcAF8Z1AvmgMi45HkYD3b1MSbZZbbKxb1McgWQ==
X-Received: by 2002:a05:600c:35c9:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-4361c3c6fbfmr30226985e9.16.1733928283603; 
 Wed, 11 Dec 2024 06:44:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361e54ef20sm19477685e9.5.2024.12.11.06.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 06:44:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] target/arm: Implement fine-grained-trap handling for
 FEAT_XS
Date: Wed, 11 Dec 2024 14:44:35 +0000
Message-Id: <20241211144440.2700268-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211144440.2700268-1-peter.maydell@linaro.org>
References: <20241211144440.2700268-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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


