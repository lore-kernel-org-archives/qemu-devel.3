Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5820BC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UUR-0005I5-On; Thu, 03 Apr 2025 20:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUJ-0004yL-80
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:47 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUH-00032J-13
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so1201676f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724843; x=1744329643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wr+KhDAwxc2q6VRSwbOelX+XVOHTzw66xSd8DPCtE8A=;
 b=j3JiLh240+BmGH5ottVe6WNFJO9tr9SE12SY7z/3hoXRnED0WVd+SgAgKmy8LqXYWo
 t+wGAxTFaQU+6U1E7tMZqR0Pz1fJVzFt2QOX6rVS+O/SMu1S9V0hrHT466kDK/JVpIwi
 mbS4ZFLIBhCjtaT7ZkWCQMRNW2k7zpOf1n8It/VhRt8deWLtLGTNHnwwtQdSqGoQTQMR
 wFnQi/zbneerig6aiVnkwsR/8T4ULPvEGH8QR5A7lldz7yrCC3V9wfMaKlRwbsS67XPq
 Wk/UDoj2jBHNdNvsl3GGdZwUEFEagmeJmAPoiI2bzC5NUcqGIShcU0lnwfy0m70YqZSF
 iahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724843; x=1744329643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wr+KhDAwxc2q6VRSwbOelX+XVOHTzw66xSd8DPCtE8A=;
 b=ZGW5GMSRFHvd8efQ/FHtxXX71owqJZ5ryhZ29lnEkekh0gx5I+SEXBmOqRY643E4C6
 XUcsdkzFEPLMuQKRkQpnQc1h+lKaN9cKLury4s2giv1QAKNPkxvqdLz1ElDQc9naxQl0
 Ix1LsyZXdf5TENV7IMuOxEPfQyjhOjluKtDFIuRl+gXAkOpYotsSc930jYC26QeOrtVd
 a90jr1K5wD6gynn0ksYk9QCSi8zBhqEz4S4F/Y2wUW0hbXvzdZJ1KlX/ysGXh4+NPDBP
 o0UO5pUcSZ1DyyljI+uyDIrGqAiMTJlrL2CryXn77BqIYUw7l4DIgh1FBS+u5CoDPPH7
 ALpQ==
X-Gm-Message-State: AOJu0YxvOsouudE4OO3CfBFzGf7HFeNAgwj7NQ0Sk/Z/L/C5lvBENrOZ
 29ZdqdjqbZotTiRPdW9yjRL2GlP2rSgdZsMokfDVTgG5Ojc/vggucnrWGDra10YZjwm5hbHjK4s
 3
X-Gm-Gg: ASbGncsGI8hDC63hirA3VcfwUblluD1Asl++wAwdrIIxPC0b1PNyRdIRdQmsobXtzNA
 JfYHt5AfsDRmrkmLj5HH///45ymhCBeg4+nz/0ZsiJuTXUgNepjgTK4OweZkfhNcqS2tRztWp3a
 QmyxLTPV9UZ4Kyq+GxOJisJCGSTZ+LBXQ7wgblfCgaY60nJqAaW4GAyo/pIZpg1idLhMyaW48HM
 s3epGx1fIR7kQ1wruDZjhwCaqxig36qbOhH0NWqB0A1VTyD7shWXf0R+yCJL1xtLrUkwiVQtR3r
 3PuS+zy/l4z/xV5RySKwcf6am3glP/TTA49MuKM0bCv1gc0mcwNqsB5apBiniAoJZsyYVQasYWb
 8svewbcxOmYy03MzhVoE=
X-Google-Smtp-Source: AGHT+IEyLLAekZB96mGGMUVu9jARVEOvn1JrtBZY4VJZhc3qD8yRpoPLANeR6oTWo0XW2gyaDvBC0g==
X-Received: by 2002:a05:6000:1887:b0:391:13d6:c9e5 with SMTP id
 ffacd0b85a97d-39cba9333bemr760470f8f.19.1743724842825; 
 Thu, 03 Apr 2025 17:00:42 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b42besm2945277f8f.41.2025.04.03.17.00.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:00:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 21/39] target/arm: Extract feature definitions to
 'cpu_has_feature.h' header
Date: Fri,  4 Apr 2025 01:58:03 +0200
Message-ID: <20250403235821.9909-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h             | 54 +-----------------------------
 target/arm/cpu_has_feature.h | 65 ++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 53 deletions(-)
 create mode 100644 target/arm/cpu_has_feature.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 930c5366029..fd8beb8bcb1 100644
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


