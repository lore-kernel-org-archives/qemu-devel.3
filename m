Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A7FC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuc-0005Tw-PG; Fri, 11 Jul 2025 09:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtu-0004RA-94
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:55 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtr-00034l-Ie
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-455e6fb8057so6305515e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240890; x=1752845690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Erap8AHQdZkhg+yiGAeAXU/b7lA6PMXWKp0iI3z4iK8=;
 b=YtQF5Hn6794FEejrChFZUoKo75JlMawMLrFFOXFCdsGxFsD1gtJu2DYwH3JOAvNWlO
 he3NukpNVEvPtRhlELRxXPV6rz6UOSVT/Ps6gUA9EIpjTo9lbcvCia3ffPp2oVYNQymP
 bKLZQVYSa9q+knOgqOz+LQilhDFK2RXlcQCvOVH4SJrX8UM9CEignT4T77tvuMh7vF/N
 PZXfcV9Hk1anRbCcfp9AEN+NH8waLOB2PAughQKFaLoRuL4B7UQTKEF9cJUcf5vjrNTl
 dL6ryeQWyj6N6CBz36jJ10HFIQgBjRQS6+Y/DL1QNdce1eqLcJzKOOyUmf7zAWPvsc4B
 b/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240890; x=1752845690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Erap8AHQdZkhg+yiGAeAXU/b7lA6PMXWKp0iI3z4iK8=;
 b=MIyugQ6t45cJ98dyPRO7Hvq61uMBA4kfXrO/C7/yDU9CHV2beMadZpk1bd0S+9Yflr
 u1L3MY83gsXyuf0YVW1JnZMEUH9JdSGas1Y2XsBukzyUH8baiqTfQovubjOG7V4zjEk0
 kLg4/Kb07NA81lR1zebUKfOi+pSBavrwI9Dk5I4/vvoArwwjXauSHqu9CnxhmmQMsXRQ
 NnI2511/zHwwOAM/HrHJfof6u7H3V7E23l2R4q7faov8lvp91W5odj/tDRkwW/ZToqIP
 aQ1/GdkB/PpRCrUfAnjFGZbVWlGWRwAJcZ1TPnQ/xx2LXIT1s3ekbjPg/Wambju02Pdx
 ZU8w==
X-Gm-Message-State: AOJu0Ywr2lLW2hEW9YkmxpSCpLMGjTWBQlwXsMPN7ivhb/jlha/n0iyv
 XyDDmCAxVv6993c1gYp5qbvBYx3ntF6x/qGD1wPjP26IUwQMYg8GuUsF64OZ+o+SaY+w/1DhhCD
 P5E53
X-Gm-Gg: ASbGnctEOJpQAXvpIuy89+oWho6RTNwQsj4FZvm4WaL3NDxvD+1D0bJibPt1ZyfKCS0
 fePuEuiHuHIe7rvilXXrm35ThtYq4pVPA95QNKBSp9m9GB7Psp/tHlNjuEZA67bs+Y0VonbRrIB
 UOF2lZLvhGMx9R1ko0ENnOawQ9fQ7/v8HUshtKCcffNRTE6Hat4nZo9x93mvNlSvzABIixx8JOj
 axc2jRla1JHDc+YY1U52P7eDboCcPswVFB4bn2o9O8icNVsEA53ytLME2jWcPwxUYFzvbFZb8J+
 mAPqblC/QWPQwzoP9858XZfafE56POzC6cXQOqFIzz/uMjbQfU9CNLQYSCQVj4qliQcO+G5Y48S
 EjzajmpSwcXYUippN/L53obzrOmvi
X-Google-Smtp-Source: AGHT+IEVtcy4y8HvT3Gl+rG1qbKApJL+4GJj1w/R5n/Zdy1RVU33De3349hw+Oah4lJ9+GRGGApVBw==
X-Received: by 2002:a05:600c:1d1c:b0:454:aac0:ce1a with SMTP id
 5b1f17b1804b1-454ec128bafmr33199565e9.14.1752240889569; 
 Fri, 11 Jul 2025 06:34:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/36] arm/cpu: store id_afr0 into the idregs array
Date: Fri, 11 Jul 2025 14:34:10 +0100
Message-ID: <20250711133429.1423030-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
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

From: Cornelia Huck <cohuck@redhat.com>

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250704141927.38963-2-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  1 -
 target/arm/cpu-sysregs.h.inc |  1 +
 hw/intc/armv7m_nvic.c        |  2 +-
 target/arm/cpu64.c           |  4 ++--
 target/arm/helper.c          |  2 +-
 target/arm/tcg/cpu-v7m.c     | 12 ++++++------
 target/arm/tcg/cpu32.c       | 22 +++++++++++-----------
 target/arm/tcg/cpu64.c       | 16 ++++++++--------
 8 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c8cf0ab417b..835700cfab8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1082,7 +1082,6 @@ struct ArchCPU {
     uint32_t reset_sctlr;
     uint64_t pmceid0;
     uint64_t pmceid1;
-    uint32_t id_afr0;
     uint64_t id_aa64afr0;
     uint64_t id_aa64afr1;
     uint64_t clidr;
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index cb99286f704..b96a3588043 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -14,6 +14,7 @@ DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
 DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
 DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
 DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
+DEF(ID_AFR0_EL1, 3, 0, 0, 1, 3)
 DEF(ID_MMFR0_EL1, 3, 0, 0, 1, 4)
 DEF(ID_MMFR1_EL1, 3, 0, 0, 1, 5)
 DEF(ID_MMFR2_EL1, 3, 0, 0, 1, 6)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 6d85720f1b4..d93e593fcba 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1279,7 +1279,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->id_afr0;
+        return GET_IDREG(isar, ID_AFR0);
     case 0xd50: /* MMFR0.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index bd33d6cc6ea..d648ea066c6 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -663,7 +663,7 @@ static void aarch64_a57_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10101105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
@@ -725,7 +725,7 @@ static void aarch64_a53_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10101105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b3f0d6f17a8..ae6231803e1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7809,7 +7809,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->id_afr0 },
+              .resetvalue = GET_IDREG(isar, ID_AFR0)},
             { .name = "ID_MMFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index eddd7117d5b..a65b83fe990 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -62,7 +62,7 @@ static void cortex_m0_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00000030);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x00000000);
@@ -88,7 +88,7 @@ static void cortex_m3_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00000030);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x00000000);
@@ -119,7 +119,7 @@ static void cortex_m4_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00000030);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x00000000);
@@ -150,7 +150,7 @@ static void cortex_m7_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00100030);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x01000000);
@@ -183,7 +183,7 @@ static void cortex_m33_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000210);
     SET_IDREG(isar, ID_DFR0, 0x00200000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00101F40);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x01000000);
@@ -221,7 +221,7 @@ static void cortex_m55_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x20000030);
     SET_IDREG(isar, ID_PFR1, 0x00000230);
     SET_IDREG(isar, ID_DFR0, 0x10200000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00111040);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x01000000);
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 942b636aa5b..03cbe42f22f 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -225,7 +225,7 @@ static void arm1136_r2_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
     SET_IDREG(isar, ID_DFR0, 0x2);
-    cpu->id_afr0 = 0x3;
+    SET_IDREG(isar, ID_AFR0, 0x3);
     SET_IDREG(isar, ID_MMFR0, 0x01130003);
     SET_IDREG(isar, ID_MMFR1, 0x10030302);
     SET_IDREG(isar, ID_MMFR2, 0x01222110);
@@ -257,7 +257,7 @@ static void arm1136_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
     SET_IDREG(isar, ID_DFR0, 0x2);
-    cpu->id_afr0 = 0x3;
+    SET_IDREG(isar, ID_AFR0, 0x3);
     SET_IDREG(isar, ID_MMFR0, 0x01130003);
     SET_IDREG(isar, ID_MMFR1, 0x10030302);
     SET_IDREG(isar, ID_MMFR2, 0x01222110);
@@ -290,7 +290,7 @@ static void arm1176_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x11);
     SET_IDREG(isar, ID_DFR0, 0x33);
-    cpu->id_afr0 = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x01130003);
     SET_IDREG(isar, ID_MMFR1, 0x10030302);
     SET_IDREG(isar, ID_MMFR2, 0x01222100);
@@ -320,7 +320,7 @@ static void arm11mpcore_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
     SET_IDREG(isar, ID_DFR0, 0);
-    cpu->id_afr0 = 0x2;
+    SET_IDREG(isar, ID_AFR0, 0x2);
     SET_IDREG(isar, ID_MMFR0, 0x01100103);
     SET_IDREG(isar, ID_MMFR1, 0x10020302);
     SET_IDREG(isar, ID_MMFR2, 0x01222000);
@@ -360,7 +360,7 @@ static void cortex_a8_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x1031);
     SET_IDREG(isar, ID_PFR1, 0x11);
     SET_IDREG(isar, ID_DFR0, 0x400);
-    cpu->id_afr0 = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x31100003);
     SET_IDREG(isar, ID_MMFR1, 0x20000000);
     SET_IDREG(isar, ID_MMFR2, 0x01202000);
@@ -436,7 +436,7 @@ static void cortex_a9_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x1031);
     SET_IDREG(isar, ID_PFR1, 0x11);
     SET_IDREG(isar, ID_DFR0, 0x000);
-    cpu->id_afr0 = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x00100103);
     SET_IDREG(isar, ID_MMFR1, 0x20000000);
     SET_IDREG(isar, ID_MMFR2, 0x01230000);
@@ -502,7 +502,7 @@ static void cortex_a7_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00001131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x02010555);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10101105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01240000);
@@ -554,7 +554,7 @@ static void cortex_a15_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00001131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x02010555);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10201105);
     SET_IDREG(isar, ID_MMFR1, 0x20000000);
     SET_IDREG(isar, ID_MMFR2, 0x01240000);
@@ -598,7 +598,7 @@ static void cortex_r5_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x0131);
     SET_IDREG(isar, ID_PFR1, 0x001);
     SET_IDREG(isar, ID_DFR0, 0x010400);
-    cpu->id_afr0 = 0x0;
+    SET_IDREG(isar, ID_AFR0, 0x0);
     SET_IDREG(isar, ID_MMFR0, 0x0210030);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x01200000);
@@ -745,7 +745,7 @@ static void cortex_r52_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x10111001);
     SET_IDREG(isar, ID_DFR0, 0x03010006);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00211040);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01200000);
@@ -977,7 +977,7 @@ static void arm_max_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10101105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index d0df50a2f34..e3183c53bb1 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -52,7 +52,7 @@ static void aarch64_a35_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
-    cpu->id_afr0 = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x10201105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
@@ -227,7 +227,7 @@ static void aarch64_a55_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(isar, ID_AA64PFR0, 0x0000000010112222ull);
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
-    cpu->id_afr0       = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
@@ -298,7 +298,7 @@ static void aarch64_a72_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10201105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
@@ -360,7 +360,7 @@ static void aarch64_a76_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
-    cpu->id_afr0       = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
@@ -608,7 +608,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
-    cpu->id_afr0       = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
@@ -687,7 +687,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR2, 0x0220011102101011ull),
     SET_IDREG(isar, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
-    cpu->id_afr0       = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_DFR0, 0x15011099);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
@@ -905,7 +905,7 @@ static void aarch64_a710_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_DFR0, 0x16011099);
-    cpu->id_afr0       = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x10201105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
@@ -1007,7 +1007,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_DFR0, 0x16011099);
-    cpu->id_afr0       = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x10201105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
-- 
2.43.0


