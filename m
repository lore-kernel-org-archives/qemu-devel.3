Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E66C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 22:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u06Vz-00059Y-IQ; Wed, 02 Apr 2025 18:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06Vd-0004pk-H7
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06VY-0002W7-9o
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso2284925e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 15:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743632664; x=1744237464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J3tibzouVprzftlyy0nQmuXd714bGB2mGhjHzSWC2OY=;
 b=hDY/sIkf3Vqfg03IRmnFpGQ/dA3ccU2o/xfmOCfsW7DJ4YPkTSWooUAxn/c9Hdxxtk
 r8BL6um+HYmySAb3WlEXVIKD63d+Uw1JrcOHcVEiRnN7FkkUstQbdebslXVeZNjSr5da
 m1tdBxP2em75nKcWgsGWtKXP6wjWaqHnVhjZ4kjqr+dnzSD6FK5DsJhAD4ccd9h/oCC0
 NRP6OTb2V9222aM6A9+KzwzqecoAqwBkwV7tEgxONTX2YiOi/iMMd9bcJbvWTwBnV+VP
 P5NGkoFwvhXE1PWIqHco/weVKbCjUIS2OqYfMW1zGrtfLRu10bRd5ASWwzxcsOHlBYlx
 tGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743632664; x=1744237464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J3tibzouVprzftlyy0nQmuXd714bGB2mGhjHzSWC2OY=;
 b=DjOOAzcDpfMEXaom05SJiX9CfnQcPltd9OEw4aPcGFLBRDI8HqG/pTuhceVZOcTx8v
 +c0OQzUQWXRw23HdWhNwczBcMTbMdzymA5GTlSVfVcmsh6ZgRJqa5oaAlMoFj8bfwlqK
 Qj6q8hMdQu4N97cdEsr9bPdhuv2iiAhAL/DtrSEVkGm6e9XN8AOPiQV2p8DBjWUhKE4A
 Gpwf1d4cX7Z1CyNzYs3MDi4f4IArpmGiO8emnNrK8nnROv3/EvMtMUj++9fwjLjGYn9F
 4ZdqUwOe5AxCb0QlGh9FII3zWjZ2zviysoPDdUZ4Jpl+gFpygyLfZvmAmr+4ZHZHs2DC
 SYnA==
X-Gm-Message-State: AOJu0YwXiZSgm7iRsFpjpqqHKVOv9CyrPWjosTjAQVS7waP9RB1yfQph
 SWN+8mLS2LDEcmonkp3x1F2eukq1XJuKN5hqmFmCKFc/0p/V1c9rQe8M/Lc/GauXX9yZUQeUADj
 d
X-Gm-Gg: ASbGnctUkyuvQNBTBVYPMP2b5GwsvH5ZLnAyZehSdcnViw0KeA29lj6XyJ1NcwgqpYJ
 6txtDPmF8IeEJ2DqGo6QdrZqGnHL2bMQfF3OSClOE3DqlhTjBh55uV71527EwFv+B5Ibi7eiSxL
 wvqDt61ggLUyUq5Fk1vICzmoV2oAigKMEiBN9PelDHyqQGlGKyMiO+m8DDh0bYcqY1aA8N5RQ+l
 I9LQjFXfrW0lfRqf+j61bAqKhsI0JK5ijfv3Em4Pv3bQ67wa6Tn1jII/sRFkHiN5pncwTWCAgcb
 yTsMs8ZWLJQ+C4bohsWiXIlX+IlV26P4wo1SopUUN3BAaM2LWiSjs5pfxR1XYRmzKdDaoC5OsXS
 x6/QLgzvxJGq1PNn7NKc=
X-Google-Smtp-Source: AGHT+IHP4JJ+SCHXhDhMpHeOnhV5Zon3z0lm1wmpFlryXMPXUVHzVM3xmKSV4LFjoZBFg39I4hSWYw==
X-Received: by 2002:a05:600c:190d:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-43eb5c95bbbmr25892055e9.25.1743632663737; 
 Wed, 02 Apr 2025 15:24:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec36699e0sm162755e9.35.2025.04.02.15.24.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 15:24:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 10/13] target/arm: Extract feature definitions to
 'cpu_has_feature.h' header
Date: Thu,  3 Apr 2025 00:23:30 +0200
Message-ID: <20250402222334.66511-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402222334.66511-1-philmd@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h             | 54 +-----------------------------
 target/arm/cpu_has_feature.h | 65 ++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 53 deletions(-)
 create mode 100644 target/arm/cpu_has_feature.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e78a1668bba..a76874badc3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -30,6 +30,7 @@
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
 #include "qapi/qapi-types-common.h"
+#include "target/arm/cpu_has_feature.h"
 #include "target/arm/gtimer.h"
 
 #define EXCP_UDEF            1   /* undefined instruction */
@@ -2379,59 +2380,6 @@ FIELD(MFAR, NS, 63, 1)
 
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
-/* If adding a feature bit which corresponds to a Linux ELF
- * HWCAP bit, remember to update the feature-bit-to-hwcap
- * mapping in linux-user/elfload.c:get_elf_hwcap().
- */
-enum arm_features {
-    ARM_FEATURE_AUXCR,  /* ARM1026 Auxiliary control register.  */
-    ARM_FEATURE_XSCALE, /* Intel XScale extensions.  */
-    ARM_FEATURE_IWMMXT, /* Intel iwMMXt extension.  */
-    ARM_FEATURE_V6,
-    ARM_FEATURE_V6K,
-    ARM_FEATURE_V7,
-    ARM_FEATURE_THUMB2,
-    ARM_FEATURE_PMSA,   /* no MMU; may have Memory Protection Unit */
-    ARM_FEATURE_NEON,
-    ARM_FEATURE_M, /* Microcontroller profile.  */
-    ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
-    ARM_FEATURE_THUMB2EE,
-    ARM_FEATURE_V7MP,    /* v7 Multiprocessing Extensions */
-    ARM_FEATURE_V7VE, /* v7 Virtualization Extensions (non-EL2 parts) */
-    ARM_FEATURE_V4T,
-    ARM_FEATURE_V5,
-    ARM_FEATURE_STRONGARM,
-    ARM_FEATURE_VAPA, /* cp15 VA to PA lookups */
-    ARM_FEATURE_GENERIC_TIMER,
-    ARM_FEATURE_MVFR, /* Media and VFP Feature Registers 0 and 1 */
-    ARM_FEATURE_DUMMY_C15_REGS, /* RAZ/WI all of cp15 crn=15 */
-    ARM_FEATURE_CACHE_TEST_CLEAN, /* 926/1026 style test-and-clean ops */
-    ARM_FEATURE_CACHE_DIRTY_REG, /* 1136/1176 cache dirty status register */
-    ARM_FEATURE_CACHE_BLOCK_OPS, /* v6 optional cache block operations */
-    ARM_FEATURE_MPIDR, /* has cp15 MPIDR */
-    ARM_FEATURE_LPAE, /* has Large Physical Address Extension */
-    ARM_FEATURE_V8,
-    ARM_FEATURE_AARCH64, /* supports 64 bit mode */
-    ARM_FEATURE_CBAR, /* has cp15 CBAR */
-    ARM_FEATURE_CBAR_RO, /* has cp15 CBAR and it is read-only */
-    ARM_FEATURE_EL2, /* has EL2 Virtualization support */
-    ARM_FEATURE_EL3, /* has EL3 Secure monitor support */
-    ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings */
-    ARM_FEATURE_PMU, /* has PMU support */
-    ARM_FEATURE_VBAR, /* has cp15 VBAR */
-    ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
-    ARM_FEATURE_M_MAIN, /* M profile Main Extension */
-    ARM_FEATURE_V8_1M, /* M profile extras only in v8.1M and later */
-    /*
-     * ARM_FEATURE_BACKCOMPAT_CNTFRQ makes the CPU default cntfrq be 62.5MHz
-     * if the board doesn't set a value, instead of 1GHz. It is for backwards
-     * compatibility and used only with CPU definitions that were already
-     * in QEMU before we changed the default. It should not be set on any
-     * CPU types added in future.
-     */
-    ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
-};
-
 static inline int arm_feature(CPUARMState *env, int feature)
 {
     return (env->features & (1ULL << feature)) != 0;
diff --git a/target/arm/cpu_has_feature.h b/target/arm/cpu_has_feature.h
new file mode 100644
index 00000000000..2adfccd9208
--- /dev/null
+++ b/target/arm/cpu_has_feature.h
@@ -0,0 +1,65 @@
+/*
+ * Helper to check ARM CPU has features
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef TARGET_ARM_CPU_HAS_FEATURE_H
+#define TARGET_ARM_CPU_HAS_FEATURE_H
+
+/*
+ * If adding a feature bit which corresponds to a Linux ELF
+ * HWCAP bit, remember to update the feature-bit-to-hwcap
+ * mapping in linux-user/elfload.c:get_elf_hwcap().
+ */
+typedef enum arm_features {
+    ARM_FEATURE_AUXCR,  /* ARM1026 Auxiliary control register.  */
+    ARM_FEATURE_XSCALE, /* Intel XScale extensions.  */
+    ARM_FEATURE_IWMMXT, /* Intel iwMMXt extension.  */
+    ARM_FEATURE_V6,
+    ARM_FEATURE_V6K,
+    ARM_FEATURE_V7,
+    ARM_FEATURE_THUMB2,
+    ARM_FEATURE_PMSA,   /* no MMU; may have Memory Protection Unit */
+    ARM_FEATURE_NEON,
+    ARM_FEATURE_M, /* Microcontroller profile.  */
+    ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
+    ARM_FEATURE_THUMB2EE,
+    ARM_FEATURE_V7MP,    /* v7 Multiprocessing Extensions */
+    ARM_FEATURE_V7VE, /* v7 Virtualization Extensions (non-EL2 parts) */
+    ARM_FEATURE_V4T,
+    ARM_FEATURE_V5,
+    ARM_FEATURE_STRONGARM,
+    ARM_FEATURE_VAPA, /* cp15 VA to PA lookups */
+    ARM_FEATURE_GENERIC_TIMER,
+    ARM_FEATURE_MVFR, /* Media and VFP Feature Registers 0 and 1 */
+    ARM_FEATURE_DUMMY_C15_REGS, /* RAZ/WI all of cp15 crn=15 */
+    ARM_FEATURE_CACHE_TEST_CLEAN, /* 926/1026 style test-and-clean ops */
+    ARM_FEATURE_CACHE_DIRTY_REG, /* 1136/1176 cache dirty status register */
+    ARM_FEATURE_CACHE_BLOCK_OPS, /* v6 optional cache block operations */
+    ARM_FEATURE_MPIDR, /* has cp15 MPIDR */
+    ARM_FEATURE_LPAE, /* has Large Physical Address Extension */
+    ARM_FEATURE_V8,
+    ARM_FEATURE_AARCH64, /* supports 64 bit mode */
+    ARM_FEATURE_CBAR, /* has cp15 CBAR */
+    ARM_FEATURE_CBAR_RO, /* has cp15 CBAR and it is read-only */
+    ARM_FEATURE_EL2, /* has EL2 Virtualization support */
+    ARM_FEATURE_EL3, /* has EL3 Secure monitor support */
+    ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings */
+    ARM_FEATURE_PMU, /* has PMU support */
+    ARM_FEATURE_VBAR, /* has cp15 VBAR */
+    ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
+    ARM_FEATURE_M_MAIN, /* M profile Main Extension */
+    ARM_FEATURE_V8_1M, /* M profile extras only in v8.1M and later */
+    /*
+     * ARM_FEATURE_BACKCOMPAT_CNTFRQ makes the CPU default cntfrq be 62.5MHz
+     * if the board doesn't set a value, instead of 1GHz. It is for backwards
+     * compatibility and used only with CPU definitions that were already
+     * in QEMU before we changed the default. It should not be set on any
+     * CPU types added in future.
+     */
+    ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
+} ArmCpuFeature;
+
+#endif
-- 
2.47.1


