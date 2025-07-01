Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67643C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSe-0005id-8T; Tue, 01 Jul 2025 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSP-0005UX-PB
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSI-0003Rl-AX
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso36015875e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389656; x=1751994456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zycRU7lHOi2PNxNUKlO7GYurAhRMg/o+383vPotyJ+U=;
 b=Um1r9SzLXPHcJrPU+b17uqQ+kiQJsEiwGi47AVJRVIIFNrUm3NTui0kK8QArIgzsuw
 1uESpqNlMYhjTloeNVzJ3nRjs1ZYHeX5BheujuOCLdw0SPAiEI2KuMiltKbPS56QwBRH
 e0D+JmjApsxEAyc+/xZEgOx68bq83kvIx0Iy5tjL2JwSI9oMD55BOPk+9QJhl5uh1If8
 P2bucUDuRprqR9qFOspeMY3FhfsW0zlTOaTIpiKq3qN9RcZkBOEXhoYu0iTwRNAskNJm
 70DqDmaSvc+2yzMx+4ZOR0XZISDa+Moz+mwtc6YE4pieZMdrw/PCCjpICp971fra8fiM
 pofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389656; x=1751994456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zycRU7lHOi2PNxNUKlO7GYurAhRMg/o+383vPotyJ+U=;
 b=oBbtjbpm5GaafWm3r6Um6GVZhJUdA3ztPPolI63UlOfk9KN1Z7Yn3VGTNduOkwdkrD
 ZVwsRWcIS/BhAZUyxU24/lp/TLYVyI/pFz6l8A983RrDH7Mg2K7lM5irkWhNscze9ZP1
 yRfkXv5DO/2clmyRYCwNobp+3pO0uQWzPU0LmxYnWSnwoPmlfRxEa4ncNseOROVCETGt
 45GzV+afqcaABcyZ/7G5pDTLGiD7zWMMTQOyoZl+R/GDEcPqDn8NJxjQslPc/kjyC7Po
 rXcDEhwcpOn5ErqcUCYH3KDwfr/4j93AIlbVwVYlyTZmP0ubBBraliRHoKf/K0FGwGPH
 L1lQ==
X-Gm-Message-State: AOJu0YxYXXjIBTLFP/ooVDR9EZ/lUplgNHZpY2ELN4UHMnIfH+nKlVbG
 zRyxDtv9tl2xH11/vUb2GAqCKlrdgyOYIw+BW8Gx2z+QnNXZeGsGIj1H3Q1YLCuOVc+vQ5YAX4L
 PlJqr
X-Gm-Gg: ASbGncuCfnBM9aJrEoYxOOCYcqz4Bcx+2rnHxNBjiovsOcELKVsKIf8S8E1mJivwXyp
 OsgsD+DXheg8zAaI9NP+R41uYWffPdDrwTuYsr3qPMs+dw/G4GWpYawTmkHQHfWPg81EVFx6UmP
 6HLGjwRLJoP43q8L+RziztcilDOyN9XI6xgogBxP3+Ul5oVwps93o25X7VRnFs/gS0/Tixs/clY
 BK/3rpifx/7cb2bBGpTa4jZlUCGJyIPQ9V7kyrv5MvINrm/d9L1pHkosEGRmyAX2kmm2tC0FSJM
 k1XpYJRH8C2o4YRoOIfBH0/uBFbSjqhTEqkZXbuSjIj5aG/RL+ehx8qRV4ePVLznN0vp
X-Google-Smtp-Source: AGHT+IGLtf5JGi5vceIBE4mrtCB7GsaMn1zQnoTwioHJDVjzHDEIy2cAoFsFrrTPcwAYSHrEIjviUw==
X-Received: by 2002:a5d:5f4e:0:b0:3a4:dd8e:e16d with SMTP id
 ffacd0b85a97d-3a8f482bbb0mr17373603f8f.15.1751389656126; 
 Tue, 01 Jul 2025 10:07:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/43] arm/cpu: Store id_mmfr0-5 into the idregs array
Date: Tue,  1 Jul 2025 18:06:49 +0100
Message-ID: <20250701170720.4072660-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20250617153931.1330449-12-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 18 ++++----
 target/arm/cpu.h          |  6 ---
 hw/intc/armv7m_nvic.c     |  8 ++--
 target/arm/cpu64.c        | 16 +++----
 target/arm/helper.c       | 12 ++---
 target/arm/kvm.c          | 18 +++-----
 target/arm/tcg/cpu-v7m.c  | 48 ++++++++++----------
 target/arm/tcg/cpu32.c    | 94 +++++++++++++++++++--------------------
 target/arm/tcg/cpu64.c    | 76 +++++++++++++++----------------
 9 files changed, 140 insertions(+), 156 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 0292a7cd6ec..5d8adfb73b6 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -284,17 +284,17 @@ static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa32_pxn(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr0, ID_MMFR0, VMSA) >= 4;
+    return FIELD_EX32_IDREG(id, ID_MMFR0, VMSA) >= 4;
 }
 
 static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) != 0;
+    return FIELD_EX32_IDREG(id, ID_MMFR3, PAN) != 0;
 }
 
 static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) >= 2;
+    return FIELD_EX32_IDREG(id, ID_MMFR3, PAN) >= 2;
 }
 
 static inline bool isar_feature_aa32_pmuv3p1(const ARMISARegisters *id)
@@ -320,32 +320,32 @@ static inline bool isar_feature_aa32_pmuv3p5(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa32_hpd(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, HPDS) != 0;
+    return FIELD_EX32_IDREG(id, ID_MMFR4, HPDS) != 0;
 }
 
 static inline bool isar_feature_aa32_ac2(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, AC2) != 0;
+    return FIELD_EX32_IDREG(id, ID_MMFR4, AC2) != 0;
 }
 
 static inline bool isar_feature_aa32_ccidx(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, CCIDX) != 0;
+    return FIELD_EX32_IDREG(id, ID_MMFR4, CCIDX) != 0;
 }
 
 static inline bool isar_feature_aa32_tts2uxn(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, XNX) != 0;
+    return FIELD_EX32_IDREG(id, ID_MMFR4, XNX) != 0;
 }
 
 static inline bool isar_feature_aa32_half_evt(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, EVT) >= 1;
+    return FIELD_EX32_IDREG(id, ID_MMFR4, EVT) >= 1;
 }
 
 static inline bool isar_feature_aa32_evt(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, EVT) >= 2;
+    return FIELD_EX32_IDREG(id, ID_MMFR4, EVT) >= 2;
 }
 
 static inline bool isar_feature_aa32_dit(const ARMISARegisters *id)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c799105eeb2..8744922330d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1050,12 +1050,6 @@ struct ArchCPU {
      * field by reading the value from the KVM vCPU.
      */
     struct ARMISARegisters {
-        uint32_t id_mmfr0;
-        uint32_t id_mmfr1;
-        uint32_t id_mmfr2;
-        uint32_t id_mmfr3;
-        uint32_t id_mmfr4;
-        uint32_t id_mmfr5;
         uint32_t mvfr0;
         uint32_t mvfr1;
         uint32_t mvfr2;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 2566dd63431..6d85720f1b4 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1284,22 +1284,22 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_mmfr0;
+        return GET_IDREG(isar, ID_MMFR0);
     case 0xd54: /* MMFR1.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_mmfr1;
+        return GET_IDREG(isar, ID_MMFR1);
     case 0xd58: /* MMFR2.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_mmfr2;
+        return GET_IDREG(isar, ID_MMFR2);
     case 0xd5c: /* MMFR3.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->isar.id_mmfr3;
+        return GET_IDREG(isar, ID_MMFR3);
     case 0xd60: /* ISAR0.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 47c2eed3c99..1f3406708bd 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -656,10 +656,10 @@ static void aarch64_a57_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(isar, ID_MMFR0, 0x10101105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02102211);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
@@ -718,10 +718,10 @@ static void aarch64_a53_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(isar, ID_MMFR0, 0x10101105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02102211);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4d90ff7fd51..c311d2df217 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7810,22 +7810,22 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr0 },
+              .resetvalue = GET_IDREG(isar, ID_MMFR0)},
             { .name = "ID_MMFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr1 },
+              .resetvalue = GET_IDREG(isar, ID_MMFR1)},
             { .name = "ID_MMFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr2 },
+              .resetvalue = GET_IDREG(isar, ID_MMFR2)},
             { .name = "ID_MMFR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr3 },
+              .resetvalue = GET_IDREG(isar, ID_MMFR3)},
             { .name = "ID_ISAR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -7860,7 +7860,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr4 },
+              .resetvalue = GET_IDREG(isar, ID_MMFR4)},
             { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -8140,7 +8140,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_mmfr5 },
+              .resetvalue = GET_IDREG(isar, ID_MMFR5)},
             { .name = "RES_0_C0_C3_7", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 2a6a5329b43..3df046b2b91 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -335,14 +335,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= get_host_cpu_reg(fd, ahcf, ID_PFR0_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_PFR1_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_DFR0_EL1_IDX);
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
-                              ARM64_SYS_REG(3, 0, 0, 1, 4));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr1,
-                              ARM64_SYS_REG(3, 0, 0, 1, 5));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr2,
-                              ARM64_SYS_REG(3, 0, 0, 1, 6));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr3,
-                              ARM64_SYS_REG(3, 0, 0, 1, 7));
+        err |= get_host_cpu_reg(fd, ahcf, ID_MMFR0_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_MMFR1_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_MMFR2_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_MMFR3_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_ISAR0_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_ISAR1_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_ISAR2_EL1_IDX);
@@ -350,8 +346,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= get_host_cpu_reg(fd, ahcf, ID_ISAR4_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_ISAR5_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_ISAR6_EL1_IDX);
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr4,
-                              ARM64_SYS_REG(3, 0, 0, 2, 6));
+        err |= get_host_cpu_reg(fd, ahcf, ID_MMFR4_EL1_IDX);
 
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
                               ARM64_SYS_REG(3, 0, 0, 3, 0));
@@ -361,8 +356,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 3, 2));
         err |= get_host_cpu_reg(fd, ahcf, ID_PFR2_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_DFR1_EL1_IDX);
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr5,
-                              ARM64_SYS_REG(3, 0, 0, 3, 6));
+        err |= get_host_cpu_reg(fd, ahcf, ID_MMFR5_EL1_IDX);
 
         /*
          * DBGDIDR is a bit complicated because the kernel doesn't
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 9697c362c19..eddd7117d5b 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -63,10 +63,10 @@ static void cortex_m0_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00000030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x00000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
+    SET_IDREG(isar, ID_MMFR0, 0x00000030);
+    SET_IDREG(isar, ID_MMFR1, 0x00000000);
+    SET_IDREG(isar, ID_MMFR2, 0x00000000);
+    SET_IDREG(isar, ID_MMFR3, 0x00000000);
     SET_IDREG(isar, ID_ISAR0, 0x01141110);
     SET_IDREG(isar, ID_ISAR1, 0x02111000);
     SET_IDREG(isar, ID_ISAR2, 0x21112231);
@@ -89,10 +89,10 @@ static void cortex_m3_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00000030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x00000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
+    SET_IDREG(isar, ID_MMFR0, 0x00000030);
+    SET_IDREG(isar, ID_MMFR1, 0x00000000);
+    SET_IDREG(isar, ID_MMFR2, 0x00000000);
+    SET_IDREG(isar, ID_MMFR3, 0x00000000);
     SET_IDREG(isar, ID_ISAR0, 0x01141110);
     SET_IDREG(isar, ID_ISAR1, 0x02111000);
     SET_IDREG(isar, ID_ISAR2, 0x21112231);
@@ -120,10 +120,10 @@ static void cortex_m4_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00000030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x00000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
+    SET_IDREG(isar, ID_MMFR0, 0x00000030);
+    SET_IDREG(isar, ID_MMFR1, 0x00000000);
+    SET_IDREG(isar, ID_MMFR2, 0x00000000);
+    SET_IDREG(isar, ID_MMFR3, 0x00000000);
     SET_IDREG(isar, ID_ISAR0, 0x01141110);
     SET_IDREG(isar, ID_ISAR1, 0x02111000);
     SET_IDREG(isar, ID_ISAR2, 0x21112231);
@@ -151,10 +151,10 @@ static void cortex_m7_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00100030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
+    SET_IDREG(isar, ID_MMFR0, 0x00100030);
+    SET_IDREG(isar, ID_MMFR1, 0x00000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01000000);
+    SET_IDREG(isar, ID_MMFR3, 0x00000000);
     SET_IDREG(isar, ID_ISAR0, 0x01101110);
     SET_IDREG(isar, ID_ISAR1, 0x02112000);
     SET_IDREG(isar, ID_ISAR2, 0x20232231);
@@ -184,10 +184,10 @@ static void cortex_m33_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00000210);
     SET_IDREG(isar, ID_DFR0, 0x00200000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00101F40;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
+    SET_IDREG(isar, ID_MMFR0, 0x00101F40);
+    SET_IDREG(isar, ID_MMFR1, 0x00000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01000000);
+    SET_IDREG(isar, ID_MMFR3, 0x00000000);
     SET_IDREG(isar, ID_ISAR0, 0x01101110);
     SET_IDREG(isar, ID_ISAR1, 0x02212000);
     SET_IDREG(isar, ID_ISAR2, 0x20232232);
@@ -222,10 +222,10 @@ static void cortex_m55_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00000230);
     SET_IDREG(isar, ID_DFR0, 0x10200000);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00111040;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01000000;
-    cpu->isar.id_mmfr3 = 0x00000011;
+    SET_IDREG(isar, ID_MMFR0, 0x00111040);
+    SET_IDREG(isar, ID_MMFR1, 0x00000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01000000);
+    SET_IDREG(isar, ID_MMFR3, 0x00000011);
     SET_IDREG(isar, ID_ISAR0, 0x01103110);
     SET_IDREG(isar, ID_ISAR1, 0x02212000);
     SET_IDREG(isar, ID_ISAR2, 0x20232232);
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index bec69fe52e4..942b636aa5b 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -55,21 +55,17 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
     cpu->isar.mvfr2 = t;
 
-    t = cpu->isar.id_mmfr3;
-    t = FIELD_DP32(t, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
-    cpu->isar.id_mmfr3 = t;
+    FIELD_DP32_IDREG(isar, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
 
-    t = cpu->isar.id_mmfr4;
+    t = GET_IDREG(isar, ID_MMFR4);
     t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
     t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
     t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
     t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
     t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
-    cpu->isar.id_mmfr4 = t;
+    SET_IDREG(isar, ID_MMFR4, t);
 
-    t = cpu->isar.id_mmfr5;
-    t = FIELD_DP32(t, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
-    cpu->isar.id_mmfr5 = t;
+    FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
 
     t = GET_IDREG(isar, ID_PFR0);
     t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
@@ -230,9 +226,9 @@ static void arm1136_r2_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x1);
     SET_IDREG(isar, ID_DFR0, 0x2);
     cpu->id_afr0 = 0x3;
-    cpu->isar.id_mmfr0 = 0x01130003;
-    cpu->isar.id_mmfr1 = 0x10030302;
-    cpu->isar.id_mmfr2 = 0x01222110;
+    SET_IDREG(isar, ID_MMFR0, 0x01130003);
+    SET_IDREG(isar, ID_MMFR1, 0x10030302);
+    SET_IDREG(isar, ID_MMFR2, 0x01222110);
     SET_IDREG(isar, ID_ISAR0, 0x00140011);
     SET_IDREG(isar, ID_ISAR1, 0x12002111);
     SET_IDREG(isar, ID_ISAR2, 0x11231111);
@@ -262,9 +258,9 @@ static void arm1136_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x1);
     SET_IDREG(isar, ID_DFR0, 0x2);
     cpu->id_afr0 = 0x3;
-    cpu->isar.id_mmfr0 = 0x01130003;
-    cpu->isar.id_mmfr1 = 0x10030302;
-    cpu->isar.id_mmfr2 = 0x01222110;
+    SET_IDREG(isar, ID_MMFR0, 0x01130003);
+    SET_IDREG(isar, ID_MMFR1, 0x10030302);
+    SET_IDREG(isar, ID_MMFR2, 0x01222110);
     SET_IDREG(isar, ID_ISAR0, 0x00140011);
     SET_IDREG(isar, ID_ISAR1, 0x12002111);
     SET_IDREG(isar, ID_ISAR2, 0x11231111);
@@ -295,9 +291,9 @@ static void arm1176_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x11);
     SET_IDREG(isar, ID_DFR0, 0x33);
     cpu->id_afr0 = 0;
-    cpu->isar.id_mmfr0 = 0x01130003;
-    cpu->isar.id_mmfr1 = 0x10030302;
-    cpu->isar.id_mmfr2 = 0x01222100;
+    SET_IDREG(isar, ID_MMFR0, 0x01130003);
+    SET_IDREG(isar, ID_MMFR1, 0x10030302);
+    SET_IDREG(isar, ID_MMFR2, 0x01222100);
     SET_IDREG(isar, ID_ISAR0, 0x0140011);
     SET_IDREG(isar, ID_ISAR1, 0x12002111);
     SET_IDREG(isar, ID_ISAR2, 0x11231121);
@@ -325,9 +321,9 @@ static void arm11mpcore_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x1);
     SET_IDREG(isar, ID_DFR0, 0);
     cpu->id_afr0 = 0x2;
-    cpu->isar.id_mmfr0 = 0x01100103;
-    cpu->isar.id_mmfr1 = 0x10020302;
-    cpu->isar.id_mmfr2 = 0x01222000;
+    SET_IDREG(isar, ID_MMFR0, 0x01100103);
+    SET_IDREG(isar, ID_MMFR1, 0x10020302);
+    SET_IDREG(isar, ID_MMFR2, 0x01222000);
     SET_IDREG(isar, ID_ISAR0, 0x00100011);
     SET_IDREG(isar, ID_ISAR1, 0x12002111);
     SET_IDREG(isar, ID_ISAR2, 0x11221011);
@@ -365,10 +361,10 @@ static void cortex_a8_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x11);
     SET_IDREG(isar, ID_DFR0, 0x400);
     cpu->id_afr0 = 0;
-    cpu->isar.id_mmfr0 = 0x31100003;
-    cpu->isar.id_mmfr1 = 0x20000000;
-    cpu->isar.id_mmfr2 = 0x01202000;
-    cpu->isar.id_mmfr3 = 0x11;
+    SET_IDREG(isar, ID_MMFR0, 0x31100003);
+    SET_IDREG(isar, ID_MMFR1, 0x20000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01202000);
+    SET_IDREG(isar, ID_MMFR3, 0x11);
     SET_IDREG(isar, ID_ISAR0, 0x00101111);
     SET_IDREG(isar, ID_ISAR1, 0x12112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232031);
@@ -441,10 +437,10 @@ static void cortex_a9_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x11);
     SET_IDREG(isar, ID_DFR0, 0x000);
     cpu->id_afr0 = 0;
-    cpu->isar.id_mmfr0 = 0x00100103;
-    cpu->isar.id_mmfr1 = 0x20000000;
-    cpu->isar.id_mmfr2 = 0x01230000;
-    cpu->isar.id_mmfr3 = 0x00002111;
+    SET_IDREG(isar, ID_MMFR0, 0x00100103);
+    SET_IDREG(isar, ID_MMFR1, 0x20000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01230000);
+    SET_IDREG(isar, ID_MMFR3, 0x00002111);
     SET_IDREG(isar, ID_ISAR0, 0x00101111);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232041);
@@ -507,10 +503,10 @@ static void cortex_a7_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x02010555);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01240000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(isar, ID_MMFR0, 0x10101105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01240000);
+    SET_IDREG(isar, ID_MMFR3, 0x02102211);
     /*
      * a7_mpcore_r0p5_trm, page 4-4 gives 0x01101110; but
      * table 4-41 gives 0x02101110, which includes the arm div insns.
@@ -559,10 +555,10 @@ static void cortex_a15_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x02010555);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x20000000;
-    cpu->isar.id_mmfr2 = 0x01240000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(isar, ID_MMFR0, 0x10201105);
+    SET_IDREG(isar, ID_MMFR1, 0x20000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01240000);
+    SET_IDREG(isar, ID_MMFR3, 0x02102211);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232041);
@@ -603,10 +599,10 @@ static void cortex_r5_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x001);
     SET_IDREG(isar, ID_DFR0, 0x010400);
     cpu->id_afr0 = 0x0;
-    cpu->isar.id_mmfr0 = 0x0210030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01200000;
-    cpu->isar.id_mmfr3 = 0x0211;
+    SET_IDREG(isar, ID_MMFR0, 0x0210030);
+    SET_IDREG(isar, ID_MMFR1, 0x00000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01200000);
+    SET_IDREG(isar, ID_MMFR3, 0x0211);
     SET_IDREG(isar, ID_ISAR0, 0x02101111);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232141);
@@ -750,11 +746,11 @@ static void cortex_r52_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x10111001);
     SET_IDREG(isar, ID_DFR0, 0x03010006);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00211040;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01200000;
-    cpu->isar.id_mmfr3 = 0xf0102211;
-    cpu->isar.id_mmfr4 = 0x00000010;
+    SET_IDREG(isar, ID_MMFR0, 0x00211040);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01200000);
+    SET_IDREG(isar, ID_MMFR3, 0xf0102211);
+    SET_IDREG(isar, ID_MMFR4, 0x00000010);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232142);
@@ -982,10 +978,10 @@ static void arm_max_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(isar, ID_MMFR0, 0x10101105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02102211);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index aeaade488fe..937f29e253d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -53,10 +53,10 @@ static void aarch64_a35_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(isar, ID_MMFR0, 0x10201105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02102211);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
@@ -236,11 +236,11 @@ static void aarch64_a55_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00011142);
     SET_IDREG(isar, ID_ISAR5, 0x01011121);
     SET_IDREG(isar, ID_ISAR6, 0x00000010);
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
-    cpu->isar.id_mmfr4 = 0x00021110;
+    SET_IDREG(isar, ID_MMFR0, 0x10201105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02122211);
+    SET_IDREG(isar, ID_MMFR4, 0x00021110);
     SET_IDREG(isar, ID_PFR0, 0x10010131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_PFR2, 0x00000011);
@@ -299,10 +299,10 @@ static void aarch64_a72_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    SET_IDREG(isar, ID_MMFR0, 0x10201105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02102211);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
@@ -369,11 +369,11 @@ static void aarch64_a76_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00010142);
     SET_IDREG(isar, ID_ISAR5, 0x01011121);
     SET_IDREG(isar, ID_ISAR6, 0x00000010);
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
-    cpu->isar.id_mmfr4 = 0x00021110;
+    SET_IDREG(isar, ID_MMFR0, 0x10201105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02122211);
+    SET_IDREG(isar, ID_MMFR4, 0x00021110);
     SET_IDREG(isar, ID_PFR0, 0x10010131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_PFR2, 0x00000011);
@@ -617,11 +617,11 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00010142);
     SET_IDREG(isar, ID_ISAR5, 0x01011121);
     SET_IDREG(isar, ID_ISAR6, 0x00000010);
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
-    cpu->isar.id_mmfr4 = 0x00021110;
+    SET_IDREG(isar, ID_MMFR0, 0x10201105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02122211);
+    SET_IDREG(isar, ID_MMFR4, 0x00021110);
     SET_IDREG(isar, ID_PFR0, 0x10010131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_PFR2, 0x00000011);
@@ -696,11 +696,11 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00010142);
     SET_IDREG(isar, ID_ISAR5, 0x11011121);
     SET_IDREG(isar, ID_ISAR6, 0x01100111);
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
-    cpu->isar.id_mmfr4 = 0x01021110;
+    SET_IDREG(isar, ID_MMFR0, 0x10201105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02122211);
+    SET_IDREG(isar, ID_MMFR4, 0x01021110);
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_PFR2, 0x00000011);
@@ -906,17 +906,17 @@ static void aarch64_a710_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_DFR0, 0x16011099);
     cpu->id_afr0       = 0;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
+    SET_IDREG(isar, ID_MMFR0, 0x10201105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02122211);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
     SET_IDREG(isar, ID_ISAR3, 0x01112131);
     SET_IDREG(isar, ID_ISAR4, 0x00010142);
     SET_IDREG(isar, ID_ISAR5, 0x11011121); /* with Crypto */
-    cpu->isar.id_mmfr4 = 0x21021110;
+    SET_IDREG(isar, ID_MMFR4, 0x21021110);
     SET_IDREG(isar, ID_ISAR6, 0x01111111);
     cpu->isar.mvfr0    = 0x10110222;
     cpu->isar.mvfr1    = 0x13211111;
@@ -1008,17 +1008,17 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_DFR0, 0x16011099);
     cpu->id_afr0       = 0;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02122211;
+    SET_IDREG(isar, ID_MMFR0, 0x10201105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02122211);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
     SET_IDREG(isar, ID_ISAR2, 0x21232042);
     SET_IDREG(isar, ID_ISAR3, 0x01112131);
     SET_IDREG(isar, ID_ISAR4, 0x00010142);
     SET_IDREG(isar, ID_ISAR5, 0x11011121); /* with Crypto */
-    cpu->isar.id_mmfr4 = 0x01021110;
+    SET_IDREG(isar, ID_MMFR4, 0x01021110);
     SET_IDREG(isar, ID_ISAR6, 0x01111111);
     cpu->isar.mvfr0    = 0x10110222;
     cpu->isar.mvfr1    = 0x13211111;
-- 
2.43.0


