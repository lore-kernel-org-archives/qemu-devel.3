Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B48C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uG-0005An-8k; Fri, 14 Mar 2025 09:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uA-00058I-Dr
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u8-00014V-2e
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso14096575e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958206; x=1742563006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JoCJlJB7bw5C9PTN/h6RLrq6shwMf+RftAhK7d1SWBw=;
 b=tDIob5J2cEmZqaKlmai01Y58CfCMjoFTrOEZh8Jt0wuc0H0ubb2xXOtkTLFr0+WMIu
 DCrgqvmpJmEeBDZWaQf6fRRvsYX0cBxQBFgXBe3emEdUoZ4leEqn2nXK/fy79S3AElI5
 eowaQ6mhvAY+ORP+EOkadDzxlJAkFpmtM3clSSbkATWeO0PZXG1yP3chLPIrXI0qO4QI
 LZjes8V3QGAcmrU/LrNYR1och1BQSNSQyhPkTNeeT/vWZQ6h7G1z9ept8y73zX/+z0RB
 y0kA+KjiJeDMWePNscigGQZAvjchU/JBEpaLTaCDgX55icP0gtAPRCBhy3oSLVOiWzaI
 3o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958206; x=1742563006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoCJlJB7bw5C9PTN/h6RLrq6shwMf+RftAhK7d1SWBw=;
 b=VQO6KWRIhqs3EsgKkqbPjIdrGfKlzaK34k4B8kF5FJbAAsyK4kzknXFSYLhn2SwACS
 bCyQYP9ZAaVQbLu947kq/o8zoCjogBPxUPftQJoccK0a9bk5Fc7LvVHZf3lMTA+mI58s
 /BPWiy0XXGk5F1ektKH85Tkadg/N2rYT6an3yzY4o6yqmOc+BAvvEQ4U6kwGBrYbS8WC
 VnR4b5LAWDrU6V7mmsQoytSF80v9tx2HkwYOfXT25hJSSzsNNZyp0tUbfJJBRQmXv6Hd
 8u6dAMtrRCE9MyrU7v3/wbiSLxbnKxDDrh2Dqu/BfLhfpsjSQcRV+Zhb6K/dnSxZnGHK
 JfLA==
X-Gm-Message-State: AOJu0YwTmYDjra1nP1LWNh60cFe3DJuoG5WCYDxM0x6dUyMutVjI6GWr
 FAfh/q8RTVLgrkqokADt8EWhepRezSDMaw7WREs2Q11UBM6RF7L7Hw5QCJnVEXQ10W4n/63obek
 m
X-Gm-Gg: ASbGnctmUezLybNRNGu0yiXXskvM3+J3EqX0TNlzAHWr5+XXjjfqNClP6sSVvS01kQp
 prYaPqI8CdMpknkFnkm+CXKJUhZbIh8CLHZDdOIlE2Lr2ELEh11lt5Ly0xkdTbcO4mNlDcCvZzW
 I2+dVr0RhW7m/2dNSC3RBNvPYmgg6tsPxjM2tkYAlTiQ+pCXh8wb8FyT9vlkUXM7UOdNsNAddsL
 A0LFUL4fFkC8kr0qdAt7bPts4/jsQM1nejpH6YJjNtd/PM1bpkbNSZGwKEVCKzbvmD26he6oZPP
 g2SdBCgbrRmSm9+GMEFTrQCvQ0j3IkZZBS2qRQf/WBmAuK6k5kQ=
X-Google-Smtp-Source: AGHT+IELznoKUBojZluoVq4XJHF4HnNUIfteTWanih2v1ez84lg40owCsmnHO192g4B2wuMuCpJoXg==
X-Received: by 2002:a05:600c:1c9d:b0:43d:186d:a4bf with SMTP id
 5b1f17b1804b1-43d1f120201mr29791515e9.0.1741958205913; 
 Fri, 14 Mar 2025 06:16:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/17] target/arm: Move arm_current_el() and arm_el_is_aa64()
 to internals.h
Date: Fri, 14 Mar 2025 13:16:26 +0000
Message-ID: <20250314131637.371866-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The functions arm_current_el() and arm_el_is_aa64() are used only in
target/arm and in hw/intc/arm_gicv3_cpuif.c.  They're functions that
query internal state of the CPU.  Move them out of cpu.h and into
internals.h.

This means we need to include internals.h in arm_gicv3_cpuif.c, but
this is justifiable because that file is implementing the GICv3 CPU
interface, which really is part of the CPU proper; we just ended up
implementing it in code in hw/intc/ for historical reasons.

The motivation for this move is that we'd like to change
arm_el_is_aa64() to add a condition that uses cpu_isar_feature();
but we don't want to include cpu-features.h in cpu.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h          | 66 --------------------------------------
 target/arm/internals.h    | 67 +++++++++++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_cpuif.c |  1 +
 target/arm/arch_dump.c    |  1 +
 4 files changed, 69 insertions(+), 66 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8a59f705167..a8177c6c2e8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2635,39 +2635,6 @@ uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
 uint64_t arm_hcr_el2_eff(CPUARMState *env);
 uint64_t arm_hcrx_el2_eff(CPUARMState *env);
 
-/* Return true if the specified exception level is running in AArch64 state. */
-static inline bool arm_el_is_aa64(CPUARMState *env, int el)
-{
-    /* This isn't valid for EL0 (if we're in EL0, is_a64() is what you want,
-     * and if we're not in EL0 then the state of EL0 isn't well defined.)
-     */
-    assert(el >= 1 && el <= 3);
-    bool aa64 = arm_feature(env, ARM_FEATURE_AARCH64);
-
-    /* The highest exception level is always at the maximum supported
-     * register width, and then lower levels have a register width controlled
-     * by bits in the SCR or HCR registers.
-     */
-    if (el == 3) {
-        return aa64;
-    }
-
-    if (arm_feature(env, ARM_FEATURE_EL3) &&
-        ((env->cp15.scr_el3 & SCR_NS) || !(env->cp15.scr_el3 & SCR_EEL2))) {
-        aa64 = aa64 && (env->cp15.scr_el3 & SCR_RW);
-    }
-
-    if (el == 2) {
-        return aa64;
-    }
-
-    if (arm_is_el2_enabled(env)) {
-        aa64 = aa64 && (env->cp15.hcr_el2 & HCR_RW);
-    }
-
-    return aa64;
-}
-
 /*
  * Function for determining whether guest cp register reads and writes should
  * access the secure or non-secure bank of a cp register.  When EL3 is
@@ -2699,39 +2666,6 @@ static inline bool arm_v7m_is_handler_mode(CPUARMState *env)
     return env->v7m.exception != 0;
 }
 
-/* Return the current Exception Level (as per ARMv8; note that this differs
- * from the ARMv7 Privilege Level).
- */
-static inline int arm_current_el(CPUARMState *env)
-{
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        return arm_v7m_is_handler_mode(env) ||
-            !(env->v7m.control[env->v7m.secure] & 1);
-    }
-
-    if (is_a64(env)) {
-        return extract32(env->pstate, 2, 2);
-    }
-
-    switch (env->uncached_cpsr & 0x1f) {
-    case ARM_CPU_MODE_USR:
-        return 0;
-    case ARM_CPU_MODE_HYP:
-        return 2;
-    case ARM_CPU_MODE_MON:
-        return 3;
-    default:
-        if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
-            /* If EL3 is 32-bit then all secure privileged modes run in
-             * EL3
-             */
-            return 3;
-        }
-
-        return 1;
-    }
-}
-
 /**
  * write_list_to_cpustate
  * @cpu: ARMCPU
diff --git a/target/arm/internals.h b/target/arm/internals.h
index c2c59e60309..d161a3e396b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -392,6 +392,73 @@ static inline FloatRoundMode arm_rmode_to_sf(ARMFPRounding rmode)
     return arm_rmode_to_sf_map[rmode];
 }
 
+/* Return true if the specified exception level is running in AArch64 state. */
+static inline bool arm_el_is_aa64(CPUARMState *env, int el)
+{
+    /*
+     * This isn't valid for EL0 (if we're in EL0, is_a64() is what you want,
+     * and if we're not in EL0 then the state of EL0 isn't well defined.)
+     */
+    assert(el >= 1 && el <= 3);
+    bool aa64 = arm_feature(env, ARM_FEATURE_AARCH64);
+
+    /*
+     * The highest exception level is always at the maximum supported
+     * register width, and then lower levels have a register width controlled
+     * by bits in the SCR or HCR registers.
+     */
+    if (el == 3) {
+        return aa64;
+    }
+
+    if (arm_feature(env, ARM_FEATURE_EL3) &&
+        ((env->cp15.scr_el3 & SCR_NS) || !(env->cp15.scr_el3 & SCR_EEL2))) {
+        aa64 = aa64 && (env->cp15.scr_el3 & SCR_RW);
+    }
+
+    if (el == 2) {
+        return aa64;
+    }
+
+    if (arm_is_el2_enabled(env)) {
+        aa64 = aa64 && (env->cp15.hcr_el2 & HCR_RW);
+    }
+
+    return aa64;
+}
+
+/*
+ * Return the current Exception Level (as per ARMv8; note that this differs
+ * from the ARMv7 Privilege Level).
+ */
+static inline int arm_current_el(CPUARMState *env)
+{
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return arm_v7m_is_handler_mode(env) ||
+            !(env->v7m.control[env->v7m.secure] & 1);
+    }
+
+    if (is_a64(env)) {
+        return extract32(env->pstate, 2, 2);
+    }
+
+    switch (env->uncached_cpsr & 0x1f) {
+    case ARM_CPU_MODE_USR:
+        return 0;
+    case ARM_CPU_MODE_HYP:
+        return 2;
+    case ARM_CPU_MODE_MON:
+        return 3;
+    default:
+        if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
+            /* If EL3 is 32-bit then all secure privileged modes run in EL3 */
+            return 3;
+        }
+
+        return 1;
+    }
+}
+
 static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
                                                   bool sctlr_b)
 {
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 7f1d071c198..de37465bc87 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "target/arm/cpregs.h"
 #include "target/arm/cpu-features.h"
+#include "target/arm/internals.h"
 #include "system/tcg.h"
 #include "system/qtest.h"
 
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 5c943dc27b5..c40df4e7fd7 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -23,6 +23,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "cpu-features.h"
+#include "internals.h"
 
 /* struct user_pt_regs from arch/arm64/include/uapi/asm/ptrace.h */
 struct aarch64_user_regs {
-- 
2.43.0


