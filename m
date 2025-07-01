Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6D5C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSe-0005if-DQ; Tue, 01 Jul 2025 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSL-0005Tm-Uj
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSC-0003Ms-Ch
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-450cf214200so29720145e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389649; x=1751994449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RlbDkZHgUiI9yCHVNLkeIlYdXaaoV8XyureuWonJZhI=;
 b=VOM3iTddA4PUBGXwBUfklN9BgzOzkak7/gzJEpsXkh6KNNRgVxDnui2Qxvj6rMDkzq
 Anj+yijqsbHRBAuUU/awyz2iIPM1C4OxXBzOfCO333G3Z8L2m+8fTPPI9tsYK+JUT1OY
 vVUeB0lJnvWX4S+MfaM+iKWNEA70+Sl+m7PExLe7VXnXIFDW4xIdNo5aHFT3J3aYVu8k
 mTr3qHJu+RQxL8mrMfFU9pNJLqt/6/28+CdK5f1WFFmsVdqfNFtIQD4MmJtQd74LXCn+
 Z3WzRXP8V0rdsoR4ZJblaVt88RYvZdZJaIx3f/RSZg4NHvLzfWRaHavJUqyOaWZYD0gO
 FJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389649; x=1751994449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RlbDkZHgUiI9yCHVNLkeIlYdXaaoV8XyureuWonJZhI=;
 b=pzmuNGjG6cMaJmh2jcUyiYERL/wG65lDolx22KDNJoh2DXO1j78wl/8q/SOf963eNc
 k26Q2K6YxFJmaj+uy5ns3r34ZdSE7SwIULKof8DKQMQ/riSWXi1cVH4+F+MynR0h0n3r
 ++xcL7My34Oi23TmB3rz9WSbGayfX5DFQxImggOQPavifZTyb2maO5EP7l8Ba90jmIFx
 gf2WUfORRAUyF4gU/Ygtc/fHBcyxCoVjf86ERl6b2c0yFlJz++Uwt72lBINePnzA9oyY
 Yjd3CuU5+Uag9vIPtiqs9vu9U+KNXKlBOmvz/gPEpgcwx7C5PQASBLwGDxg4F/bSVOyY
 uOVw==
X-Gm-Message-State: AOJu0Yzs5idnbWrpj1EeKGrdbL15RwMnXuXxNn85iuNJrC4XNXue0BuV
 zsbbZdDojzvSnLiL7haEufW2OeoGX8kzXFilBOs8YekdYgVhkNh57Ti5fdGnzt01NFh5q68w9MW
 KSUgL
X-Gm-Gg: ASbGncsA/0C7mjlBJ3Y5CPB2arZSTAp0G0deHD5aYnXab8Yz7UaSXytHIQfmYvjW78H
 o6CdDR1C1YzhH4J1hMIde0zxQp7aK5XAuwdyAkVcQfROi0q5p+NmReHc5CCtfBW0F679fFwAJ/L
 0ehEZRMBhmNwhW3J0VCMKFVfsX94mCop05gBYPEcIYCQ1EvDpKwCjA8giNyZ3hTpy4LnGVFPUMX
 gEZwGNl9AoWQUI0UdIHerf+LJqCG9jg4qVacSls0yea78AauHKTn0YDtkiiVOXFT13SR3SfuNBx
 MPxjZrJ/XrlYArasy3Z8n8Lkz3NuGw33aPFeuES6+EzThPvZo/dZ/5D7s5vr7nXLrbtm
X-Google-Smtp-Source: AGHT+IFrgdrtcnf4Tuk0JTlvZRxL+y6v4qsEO0feeV862iz+2RJCsATCiP1uNWW9Qzg2Yye/1Oh/Ew==
X-Received: by 2002:a05:600c:4706:b0:453:8bc7:5e53 with SMTP id
 5b1f17b1804b1-4538edf9e08mr217180815e9.0.1751389648529; 
 Tue, 01 Jul 2025 10:07:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/43] arm/cpu: Store aa64pfr0/1 into the idregs array
Date: Tue,  1 Jul 2025 18:06:42 +0100
Message-ID: <20250701170720.4072660-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20250617153931.1330449-5-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 40 ++++++++++++++++-----------------
 target/arm/cpu.h          |  2 --
 target/arm/cpu.c          | 29 ++++++++----------------
 target/arm/cpu64.c        | 14 ++++--------
 target/arm/helper.c       |  6 ++---
 target/arm/hvf/hvf.c      |  9 ++++----
 target/arm/kvm.c          | 12 +++++-----
 target/arm/tcg/cpu64.c    | 47 ++++++++++++++++++---------------------
 8 files changed, 68 insertions(+), 91 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 43c9695be0d..3adea85b79b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -607,68 +607,68 @@ static inline bool isar_feature_aa64_rpres(const ARMISARegisters *id)
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) != 0xf;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, FP) != 0xf;
 }
 
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, FP) == 1;
 }
 
 static inline bool isar_feature_aa64_aa32(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, EL0) >= 2;
 }
 
 static inline bool isar_feature_aa64_aa32_el1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL1) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, EL1) >= 2;
 }
 
 static inline bool isar_feature_aa64_aa32_el2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL2) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, EL2) >= 2;
 }
 
 static inline bool isar_feature_aa64_ras(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RAS) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, RAS) != 0;
 }
 
 static inline bool isar_feature_aa64_doublefault(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RAS) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, RAS) >= 2;
 }
 
 static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, SVE) != 0;
 }
 
 static inline bool isar_feature_aa64_sel2(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SEL2) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, SEL2) != 0;
 }
 
 static inline bool isar_feature_aa64_rme(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, RME) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) != 0;
 }
 
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, DIT) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, DIT) != 0;
 }
 
 static inline bool isar_feature_aa64_scxtnum(const ARMISARegisters *id)
 {
-    int key = FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, CSV2);
+    int key = FIELD_EX64_IDREG(id, ID_AA64PFR0, CSV2);
     if (key >= 2) {
         return true;      /* FEAT_CSV2_2 */
     }
     if (key == 1) {
-        key = FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, CSV2_FRAC);
+        key = FIELD_EX64_IDREG(id, ID_AA64PFR1, CSV2_FRAC);
         return key >= 2;  /* FEAT_CSV2_1p2 */
     }
     return false;
@@ -676,37 +676,37 @@ static inline bool isar_feature_aa64_scxtnum(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_ssbs(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SSBS) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, SSBS) != 0;
 }
 
 static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, BT) != 0;
 }
 
 static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) != 0;
 }
 
 static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) >= 2;
 }
 
 static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 3;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) >= 3;
 }
 
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
 }
 
 static inline bool isar_feature_aa64_nmi(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, NMI) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, NMI) != 0;
 }
 
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b81bc46966f..05157a49d75 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1074,8 +1074,6 @@ struct ArchCPU {
         uint32_t dbgdidr;
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
-        uint64_t id_aa64pfr0;
-        uint64_t id_aa64pfr1;
         uint64_t id_aa64mmfr0;
         uint64_t id_aa64mmfr1;
         uint64_t id_aa64mmfr2;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2777de72944..d39e8dc9560 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2120,14 +2120,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (!cpu->has_vfp) {
-        uint64_t t;
         uint32_t u;
 
         FIELD_DP64_IDREG(isar, ID_AA64ISAR1, JSCVT, 0);
 
-        t = cpu->isar.id_aa64pfr0;
-        t = FIELD_DP64(t, ID_AA64PFR0, FP, 0xf);
-        cpu->isar.id_aa64pfr0 = t;
+        FIELD_DP64_IDREG(isar, ID_AA64PFR0, FP, 0xf);
 
         u = cpu->isar.id_isar6;
         u = FIELD_DP32(u, ID_ISAR6, JSCVT, 0);
@@ -2182,9 +2179,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 0);
         SET_IDREG(isar, ID_AA64ISAR1, t);
 
-        t = cpu->isar.id_aa64pfr0;
-        t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 0xf);
-        cpu->isar.id_aa64pfr0 = t;
+        FIELD_DP64_IDREG(isar, ID_AA64PFR0, ADVSIMD, 0xf);
 
         u = cpu->isar.id_isar5;
         u = FIELD_DP32(u, ID_ISAR5, AES, 0);
@@ -2326,12 +2321,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          */
         cpu->isar.id_pfr1 = FIELD_DP32(cpu->isar.id_pfr1, ID_PFR1, SECURITY, 0);
         cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, COPSDBG, 0);
-        cpu->isar.id_aa64pfr0 = FIELD_DP64(cpu->isar.id_aa64pfr0,
-                                           ID_AA64PFR0, EL3, 0);
+        FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL3, 0);
 
         /* Disable the realm management extension, which requires EL3. */
-        cpu->isar.id_aa64pfr0 = FIELD_DP64(cpu->isar.id_aa64pfr0,
-                                           ID_AA64PFR0, RME, 0);
+        FIELD_DP64_IDREG(isar, ID_AA64PFR0, RME, 0);
     }
 
     if (!cpu->has_el2) {
@@ -2366,8 +2359,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * Disable the hypervisor feature bits in the processor feature
          * registers if we don't have EL2.
          */
-        cpu->isar.id_aa64pfr0 = FIELD_DP64(cpu->isar.id_aa64pfr0,
-                                           ID_AA64PFR0, EL2, 0);
+        FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL2, 0);
         cpu->isar.id_pfr1 = FIELD_DP32(cpu->isar.id_pfr1,
                                        ID_PFR1, VIRTUALIZATION, 0);
     }
@@ -2388,8 +2380,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * This matches Cortex-A710 BROADCASTMTE input being LOW.
          */
         if (tcg_enabled() && cpu->tag_memory == NULL) {
-            cpu->isar.id_aa64pfr1 =
-                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
+            FIELD_DP64_IDREG(isar, ID_AA64PFR1, MTE, 1);
         }
 
         /*
@@ -2397,7 +2388,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * enabled on the guest (i.e mte=off), clear guest's MTE bits."
          */
         if (kvm_enabled() && !cpu->kvm_mte) {
-                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
+                FIELD_DP64_IDREG(isar, ID_AA64PFR1, MTE, 0);
         }
 #endif
     }
@@ -2436,13 +2427,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cpu->isar.id_dfr0 =
             FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, MMAPTRC, 0);
         /* FEAT_AMU (Activity Monitors Extension) */
-        cpu->isar.id_aa64pfr0 =
-            FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, AMU, 0);
+        FIELD_DP64_IDREG(isar, ID_AA64PFR0, AMU, 0);
         cpu->isar.id_pfr0 =
             FIELD_DP32(cpu->isar.id_pfr0, ID_PFR0, AMU, 0);
         /* FEAT_MPAM (Memory Partitioning and Monitoring Extension) */
-        cpu->isar.id_aa64pfr0 =
-            FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, MPAM, 0);
+        FIELD_DP64_IDREG(isar, ID_AA64PFR0, MPAM, 0);
     }
 
     /* MPU can be configured out of a PMSA CPU either by setting has-mpu
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e2b25b00431..502aac91730 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -310,16 +310,13 @@ static bool cpu_arm_get_sve(Object *obj, Error **errp)
 static void cpu_arm_set_sve(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    uint64_t t;
 
     if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
         error_setg(errp, "'sve' feature not supported by KVM on this host");
         return;
     }
 
-    t = cpu->isar.id_aa64pfr0;
-    t = FIELD_DP64(t, ID_AA64PFR0, SVE, value);
-    cpu->isar.id_aa64pfr0 = t;
+    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, SVE, value);
 }
 
 void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
@@ -370,11 +367,8 @@ static bool cpu_arm_get_sme(Object *obj, Error **errp)
 static void cpu_arm_set_sme(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    uint64_t t;
 
-    t = cpu->isar.id_aa64pfr1;
-    t = FIELD_DP64(t, ID_AA64PFR1, SME, value);
-    cpu->isar.id_aa64pfr1 = t;
+    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR1, SME, value);
 }
 
 static bool cpu_arm_get_sme_fa64(Object *obj, Error **errp)
@@ -676,7 +670,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
+    SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     cpu->isar.id_aa64mmfr0 = 0x00001124;
@@ -738,7 +732,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
+    SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     cpu->isar.id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fd2a86b6b0e..b221e8df6c0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6943,7 +6943,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
-    uint64_t pfr0 = cpu->isar.id_aa64pfr0;
+    uint64_t pfr0 = GET_IDREG(&cpu->isar, ID_AA64PFR0);
 
     if (env->gicv3state) {
         pfr0 |= 1 << 24;
@@ -7916,7 +7916,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R,
 #ifdef CONFIG_USER_ONLY
               .type = ARM_CP_CONST,
-              .resetvalue = cpu->isar.id_aa64pfr0
+              .resetvalue = GET_IDREG(isar, ID_AA64PFR0)
 #else
               .type = ARM_CP_NO_RAW,
               .accessfn = access_aa64_tid3,
@@ -7928,7 +7928,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64pfr1},
+              .resetvalue = GET_IDREG(isar, ID_AA64PFR1)},
             { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 7554282410f..e1bfca5947c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -863,8 +863,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         int reg;
         uint64_t *val;
     } regs[] = {
-        { HV_SYS_REG_ID_AA64PFR0_EL1, &host_isar.id_aa64pfr0 },
-        { HV_SYS_REG_ID_AA64PFR1_EL1, &host_isar.id_aa64pfr1 },
+        { HV_SYS_REG_ID_AA64PFR0_EL1, &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },
+        { HV_SYS_REG_ID_AA64PFR1_EL1, &host_isar.idregs[ID_AA64PFR1_EL1_IDX] },
         { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.id_aa64dfr0 },
         { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
         { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
@@ -911,7 +911,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * - fix any assumptions we made that SME implies SVE (since
      *   on the M4 there is SME but not SVE)
      */
-    host_isar.id_aa64pfr1 &= ~R_ID_AA64PFR1_SME_MASK;
+    SET_IDREG(&host_isar, ID_AA64PFR1,
+              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
 
     ahcf->isar = host_isar;
 
@@ -928,7 +929,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     ahcf->reset_sctlr |= 0x00800000;
 
     /* Make sure we don't advertise AArch32 support for EL0/EL1 */
-    if ((host_isar.id_aa64pfr0 & 0xff) != 0x11) {
+    if ((GET_IDREG(&host_isar, ID_AA64PFR0) & 0xff) != 0x11) {
         return false;
     }
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 6fa5bdff42a..1e19dba4cb0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -292,8 +292,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     ahcf->dtb_compatible = "arm,arm-v8";
     int fd = fdarray[2];
 
-    err = read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr0,
-                         ARM64_SYS_REG(3, 0, 0, 4, 0));
+    err = get_host_cpu_reg(fd, ahcf, ID_AA64PFR0_EL1_IDX);
     if (unlikely(err < 0)) {
         /*
          * Before v4.15, the kernel only exposed a limited number of system
@@ -311,11 +310,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          * ??? Either of these sounds like too much effort just
          *     to work around running a modern host kernel.
          */
-        ahcf->isar.id_aa64pfr0 = 0x00000011; /* EL1&0, AArch64 only */
+        SET_IDREG(&ahcf->isar, ID_AA64PFR0, 0x00000011); /* EL1&0, AArch64 only */
         err = 0;
     } else {
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr1,
-                              ARM64_SYS_REG(3, 0, 0, 4, 1));
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64PFR1_EL1_IDX);
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64smfr0,
                               ARM64_SYS_REG(3, 0, 0, 4, 5));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,
@@ -395,14 +393,14 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          * arch/arm64/kvm/sys_regs.c:trap_dbgidr() does.
          * We only do this if the CPU supports AArch32 at EL1.
          */
-        if (FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL1) >= 2) {
+        if (FIELD_EX32_IDREG(&ahcf->isar, ID_AA64PFR0, EL1) >= 2) {
             int wrps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, WRPS);
             int brps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, BRPS);
             int ctx_cmps =
                 FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS);
             int version = 6; /* ARMv8 debug architecture */
             bool has_el3 =
-                !!FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL3);
+                !!FIELD_EX32_IDREG(&ahcf->isar, ID_AA64PFR0, EL3);
             uint32_t dbgdidr = 0;
 
             dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, WRPS, wrps);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 91750264724..7a730c7974f 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -63,8 +63,8 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.id_isar3 = 0x01112131;
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
-    cpu->isar.id_aa64pfr1 = 0;
+    SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
+    SET_IDREG(isar, ID_AA64PFR1, 0);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64dfr1 = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
@@ -158,11 +158,8 @@ static bool cpu_arm_get_rme(Object *obj, Error **errp)
 static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    uint64_t t;
 
-    t = cpu->isar.id_aa64pfr0;
-    t = FIELD_DP64(t, ID_AA64PFR0, RME, value);
-    cpu->isar.id_aa64pfr0 = t;
+    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value);
 }
 
 static void cpu_max_set_l0gptsz(Object *obj, Visitor *v, const char *name,
@@ -228,8 +225,8 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
-    cpu->isar.id_aa64pfr0  = 0x0000000010112222ull;
-    cpu->isar.id_aa64pfr1  = 0x0000000000000010ull;
+    SET_IDREG(isar, ID_AA64PFR0, 0x0000000010112222ull);
+    SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x04010088;
     cpu->isar.id_isar0 = 0x02101110;
@@ -312,7 +309,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.id_isar3 = 0x01112131;
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
+    SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
     cpu->isar.id_aa64dfr0 = 0x10305106;
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
     cpu->isar.id_aa64mmfr0 = 0x00001124;
@@ -361,8 +358,8 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
-    cpu->isar.id_aa64pfr0  = 0x1100000010111112ull; /* GIC filled in later */
-    cpu->isar.id_aa64pfr1  = 0x0000000000000010ull;
+    SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
+    SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x04010088;
     cpu->isar.id_isar0 = 0x02101110;
@@ -427,8 +424,8 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->revidr = 0x00000000;
     cpu->ctr = 0x86668006;
     cpu->reset_sctlr = 0x30000180;
-    cpu->isar.id_aa64pfr0 =   0x0000000101111111; /* No RAS Extensions */
-    cpu->isar.id_aa64pfr1 = 0x0000000000000000;
+    SET_IDREG(isar, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
+    SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000000);
     cpu->isar.id_aa64dfr0 = 0x0000000010305408;
     cpu->isar.id_aa64dfr1 = 0x0000000000000000;
     cpu->id_aa64afr0 = 0x0000000000000000;
@@ -609,8 +606,8 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
-    cpu->isar.id_aa64pfr0  = 0x1100000010111112ull; /* GIC filled in later */
-    cpu->isar.id_aa64pfr1  = 0x0000000000000020ull;
+    SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
+    SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x04010088;
     cpu->isar.id_isar0 = 0x02101110;
@@ -688,8 +685,8 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0220011102101011ull;
-    cpu->isar.id_aa64pfr0  = 0x1101110120111112ull; /* GIC filled in later */
-    cpu->isar.id_aa64pfr1  = 0x0000000000000020ull;
+    SET_IDREG(isar, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
+    SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     cpu->id_afr0       = 0x00000000;
     cpu->isar.id_dfr0  = 0x15011099;
     cpu->isar.id_isar0 = 0x02101110;
@@ -925,8 +922,8 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->isar.mvfr1    = 0x13211111;
     cpu->isar.mvfr2    = 0x00000043;
     cpu->isar.id_pfr2  = 0x00000011;
-    cpu->isar.id_aa64pfr0  = 0x1201111120111112ull; /* GIC filled in later */
-    cpu->isar.id_aa64pfr1  = 0x0000000000000221ull;
+    SET_IDREG(isar, ID_AA64PFR0, 0x1201111120111112ull); /* GIC filled in later */
+    SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000221ull);
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
     cpu->isar.id_aa64dfr0  = 0x000011f010305619ull;
     cpu->isar.id_aa64dfr1  = 0;
@@ -1027,8 +1024,8 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->isar.mvfr1    = 0x13211111;
     cpu->isar.mvfr2    = 0x00000043;
     cpu->isar.id_pfr2  = 0x00000011;
-    cpu->isar.id_aa64pfr0  = 0x1201111120111112ull; /* GIC filled in later */
-    cpu->isar.id_aa64pfr1  = 0x0000000000000221ull;
+    SET_IDREG(isar, ID_AA64PFR0, 0x1201111120111112ull); /* GIC filled in later */
+    SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000221ull);
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000110100110021ull); /* with Crypto */
     cpu->isar.id_aa64dfr0  = 0x000011f210305619ull;
     cpu->isar.id_aa64dfr1  = 0;
@@ -1183,7 +1180,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
-    t = cpu->isar.id_aa64pfr0;
+    t = GET_IDREG(isar, ID_AA64PFR0);
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, RAS, 2);       /* FEAT_RASv1p1 + FEAT_DoubleFault */
@@ -1192,9 +1189,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR0, DIT, 1);       /* FEAT_DIT */
     t = FIELD_DP64(t, ID_AA64PFR0, CSV2, 3);      /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR0, CSV3, 1);      /* FEAT_CSV3 */
-    cpu->isar.id_aa64pfr0 = t;
+    SET_IDREG(isar, ID_AA64PFR0, t);
 
-    t = cpu->isar.id_aa64pfr1;
+    t = GET_IDREG(isar, ID_AA64PFR1);
     t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);        /* FEAT_BTI */
     t = FIELD_DP64(t, ID_AA64PFR1, SSBS, 2);      /* FEAT_SSBS2 */
     /*
@@ -1207,7 +1204,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
-    cpu->isar.id_aa64pfr1 = t;
+    SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = cpu->isar.id_aa64mmfr0;
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
-- 
2.43.0


