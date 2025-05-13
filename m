Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40920C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtkM-0002AW-Vs; Tue, 13 May 2025 13:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcW-0000gf-Jw
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:41:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcU-0003Qu-NC
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso9469955e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158045; x=1747762845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NiBLsAOib2fbx3En55zCnPHZz2Kn8ay16k8dNjN2Wz8=;
 b=abDMiwXisWF1xKskxqYVOY1ve3+C9vkFl/okwjZp0XxVMYetviuw6nUJ4ZGpzlcNRN
 vDOn6mg76XTK56HmlgkcWYtHdrxueSs/9ygt0QrsRzcsZSJg9ZKYkTyMSt2J/ufMEmb3
 YDRekKHerq+LYfBF6IATOI80Plp8f/J6Y+4sT7Cy3zmeTa/V3KyLnEggwzxGf839M1EH
 93W8wJG8hW3gkjG5DjNVJqI5DeYifmFZZDugYTFoVbUzBfBDJFYAGoa816cFj4FzwOPI
 EVoWCV2rN4azGYAxDU3l2HILsLi9ALemyYWRfsxoxWF33+rhE+72H+4jOycWcvsbwuD+
 rZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158045; x=1747762845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NiBLsAOib2fbx3En55zCnPHZz2Kn8ay16k8dNjN2Wz8=;
 b=YyaawqavDXQN09mHFHjKIvVxPuLeoNalj1/P9Rg5arSgbjuLI0B4NBZqLbjDPlQZC4
 MExvcB9Hs67ecy/k8YJx9XOBzQqCoxYjIosZHyp0xxKlfp93hzcwR6hkBOMdqnw0NRJl
 A6BPNDQ3lh6ZA0F8ZE80jUAlPV4AY8A8LjT2LiwVzwyiRG3aWWQjrfa1SaEQC6KLSkG4
 XtwInMUGzh67Y0FqsL+Dk9omkjuqt3QR+fYpvuCnDxbe3J3btX/aMjvlWDndTx8FRy5t
 OGmdEJU09MsOANBh0yj1PEQOFNoK2cnmhOASkLI47795S8PmiD/3wF2m1Q9RHlNnqF6m
 Ifeg==
X-Gm-Message-State: AOJu0YzwrLIMXMpQNAS2x8efXx9sY+eENdZZcUicR/m3mIdeQnOehTUt
 C/3LZBPpQ3eCHFEHM1ea+KJC6ViAgmoQUWEWkWrUcNaUT7Qi9J6UozgmRR5RR5zhNLil/UjyngT
 Hlsk=
X-Gm-Gg: ASbGncshNioQpNNs31aVnJfM68ktQFhVKyV8x0RNsx3R6Sy/a6YuBS085wOYA5KKJbf
 YOSOcSrv/TCZ38WFycq55y0LLDx/vgFBPh+QQOtE/9OXgqNe+/OHzMGEguFjbkRkfc0FZiJ6Dty
 +EWK89GfllEcvQZLDojUrrwa+2jNW2rOKOakUA+BSlys0joVtrxt5ylO5AjCtyVQFdHoOl6Lt3i
 HOSNKG96j+x0qedMM1XyfFuzGlsmoSRb9TMHJQ1OtXthrbcBrCAmidkomgvJny3DdsJTATV7ToL
 gdAYWKdcIJ/+6dgidfvtvI3PESRyWtgnr7ENDt8eDZWKkSzD9aX4ZebzCR/kO/2ShCsECXJFAx2
 tUl1+7meXp6HY2Cy8SbFLHCrfnKEu
X-Google-Smtp-Source: AGHT+IGDBvi+QanZlJ4tfLz9CuTLLKeJxGBU6ZLl2XKsEf/btfexQIIjZUXhvV5cPRHQTAvuad81Cw==
X-Received: by 2002:a05:600c:3e87:b0:442:e0e0:250 with SMTP id
 5b1f17b1804b1-442f21793d5mr2180355e9.29.1747158044743; 
 Tue, 13 May 2025 10:40:44 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57dddebsm16769490f8f.3.2025.05.13.10.40.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:40:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/19] target/arm: Extract feature definitions to
 'cpu_has_feature.h' header
Date: Tue, 13 May 2025 18:39:24 +0100
Message-ID: <20250513173928.77376-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 116745975fa..cf3ff21965c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -30,6 +30,7 @@
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
 #include "qapi/qapi-types-common.h"
+#include "target/arm/cpu_has_feature.h"
 #include "target/arm/gtimer.h"
 
 #define EXCP_UDEF            1   /* undefined instruction */
@@ -2376,59 +2377,6 @@ FIELD(MFAR, NS, 63, 1)
 
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


