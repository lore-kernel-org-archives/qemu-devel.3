Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADEFC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtnj-00015N-3k; Tue, 13 May 2025 13:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcI-0000PF-CY
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:36 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcG-0003Pa-CR
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a1fa0d8884so2782556f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158030; x=1747762830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOQr33THEcq0t4i2qfK/BB9LCYbfrT4uaAwTHlVrFMs=;
 b=phrswJalDLMHHbOAWS9yMlaQnLeJj40ph9Rhac7dD0ylVM1LF2VnkFS0ljMo+lhxfI
 JfgpmN0xLteCgpDNw6iWChINhQ2MCn/QHDzABJakbOCcYE2uPongkdwNHsPsbnyRUvRy
 yB0sf/NF7Okj9z4xNirWVLtU6awRqKpIqzGInBWiSXJLSpXGPf2NhjrUVDPIJDEJjipU
 PCVAMmUyE27ORMpm5mq2PU8TdB8HNO+gjV4ezLSKseVyOF5sNCmBWNgdUVk1dtGuxrKH
 w/2sHHHMUyzJko7hoVJNahvUbO+vPmcnuV4PmIh9an1ePdnjz3ocFj8oWOmuHRhQheFr
 qGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158030; x=1747762830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOQr33THEcq0t4i2qfK/BB9LCYbfrT4uaAwTHlVrFMs=;
 b=B/UyP1SoP/Liastj0TDSHx4+ob7a2L84gS4K6dLU4RkM3dWQALpRtxj3hdTmC7DfCM
 SFus++h6PWKKP9c3+hm1e/lzt0nMn830PcN//3a5YjAfcP3NET4bWkOcrxIj14asxVAz
 afqV0pbou8raPdLTStugnIHoULjiAC94il6fsVX9WucxeXPZxAnEKARp2kg1SXu4Yg2j
 ce03Mf5IVnSX/rnWdCLQ8SRlGRsuqfLJ0SQnPf3Sq9kzAfnmH0uNcZVAYIEMFFT8ik/m
 NKl2nQIfKIWofEPtnPcriHnAZhB//uoCBrE88m1Z5sp3tlq5PzNut0a5XQZmGIMjsfic
 +Gsw==
X-Gm-Message-State: AOJu0YwF19YYzZdLPWaVlArevM7d3HEBCTYsLELyB2X+JP6A2fITN9pT
 a+V9aESl61RfNYsXuIEXgBXUnfrteCImEseYlSdlBP6Ob5W7r+X4q5LfgQKb2NpU7EGcd7hyKbp
 8/gM=
X-Gm-Gg: ASbGncvcDTUtNzmzkwvHDhLzN4FyFC4raV6EnVojzBX7dHFsc2Y4HJv5tokiBF29BSe
 fKcX9QGwj+qLDKFLJcLIIP3RymE+z266emj2zKas/Tol9AADlsM6Jdh6jk7khjKsE3bDH6pLSHj
 mPHOAATkOI74z00qTJeGBRpRcrgVMoELI7RNbq6ozI85p6f2yrkwAxxCopkC+1qD3pp/0SJbupy
 XMTFiwchVW04ktc5aC1Lf41LeA4jOCL2C/VRVR5vdTGuN3v69V8taYjY0kNVcdAm2wA6jASbIef
 en5sbW2koGJm1ZVlacjH3ifEnC4TxAykNuzZJ2o+Rh7qMhOeQ4lx62grVWMdluNMC6QQGEYsBL8
 1C4gJrzQXydqFOTHCnyKHp2ICtpNM
X-Google-Smtp-Source: AGHT+IF/Ao0CiYu3lMErawoihyp6PoXGJVLvVFANvPVRFGKrkMTjs9cJXz5YYQNh0aeGBpa488BGZw==
X-Received: by 2002:a5d:68d2:0:b0:3a0:9705:eb13 with SMTP id
 ffacd0b85a97d-3a34991e9a6mr113074f8f.43.1747158030224; 
 Tue, 13 May 2025 10:40:30 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2a1dsm16527595f8f.43.2025.05.13.10.40.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:40:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/19] target/arm: Move some definitions from 'cpu.h' to
 'multiprocessing.h'
Date: Tue, 13 May 2025 18:39:21 +0100
Message-ID: <20250513173928.77376-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

arm_build_mp_affinity() and affinity mask definitionss are
related to multiprocessing. Move them to "multiprocessing.h",
including this header when necessary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h             | 17 -----------------
 target/arm/multiprocessing.h | 18 ++++++++++++++++++
 hw/arm/aspeed_ast2600.c      |  1 +
 hw/arm/aspeed_ast27x0.c      |  1 +
 hw/arm/exynos4210.c          |  1 +
 hw/arm/npcm8xx.c             |  1 +
 hw/arm/sbsa-ref.c            |  1 +
 hw/vmapple/vmapple.c         |  1 +
 target/arm/kvm.c             |  1 +
 9 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 33ac0c9f818..b70c7a3ecd2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1155,23 +1155,6 @@ void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
 
 void arm_cpu_post_init(Object *obj);
 
-#define ARM_AFF0_SHIFT 0
-#define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
-#define ARM_AFF1_SHIFT 8
-#define ARM_AFF1_MASK  (0xFFULL << ARM_AFF1_SHIFT)
-#define ARM_AFF2_SHIFT 16
-#define ARM_AFF2_MASK  (0xFFULL << ARM_AFF2_SHIFT)
-#define ARM_AFF3_SHIFT 32
-#define ARM_AFF3_MASK  (0xFFULL << ARM_AFF3_SHIFT)
-#define ARM_DEFAULT_CPUS_PER_CLUSTER 8
-
-#define ARM32_AFFINITY_MASK (ARM_AFF0_MASK | ARM_AFF1_MASK | ARM_AFF2_MASK)
-#define ARM64_AFFINITY_MASK \
-    (ARM_AFF0_MASK | ARM_AFF1_MASK | ARM_AFF2_MASK | ARM_AFF3_MASK)
-#define ARM64_AFFINITY_INVALID (~ARM64_AFFINITY_MASK)
-
-uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz);
-
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_arm_cpu;
 
diff --git a/target/arm/multiprocessing.h b/target/arm/multiprocessing.h
index 81715d345c2..8eec79b11d8 100644
--- a/target/arm/multiprocessing.h
+++ b/target/arm/multiprocessing.h
@@ -11,6 +11,24 @@
 
 #include "target/arm/cpu-qom.h"
 
+#define ARM_AFF0_SHIFT 0
+#define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
+#define ARM_AFF1_SHIFT 8
+#define ARM_AFF1_MASK  (0xFFULL << ARM_AFF1_SHIFT)
+#define ARM_AFF2_SHIFT 16
+#define ARM_AFF2_MASK  (0xFFULL << ARM_AFF2_SHIFT)
+#define ARM_AFF3_SHIFT 32
+#define ARM_AFF3_MASK  (0xFFULL << ARM_AFF3_SHIFT)
+#define ARM_DEFAULT_CPUS_PER_CLUSTER 8
+
+#define ARM32_AFFINITY_MASK \
+            (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK)
+#define ARM64_AFFINITY_MASK \
+            (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK|ARM_AFF3_MASK)
+#define ARM64_AFFINITY_INVALID (~ARM64_AFFINITY_MASK)
+
+uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz);
+
 uint64_t arm_cpu_mp_affinity(ARMCPU *cpu);
 
 #endif
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index d12707f0abe..62a9200dac6 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -17,6 +17,7 @@
 #include "net/net.h"
 #include "system/system.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/multiprocessing.h"
 
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
 #define ASPEED_SOC_DPMCU_SIZE       0x00040000
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 1974a257660..a38c2a19751 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -22,6 +22,7 @@
 #include "hw/intc/arm_gicv3.h"
 #include "qobject/qlist.h"
 #include "qemu/log.h"
+#include "target/arm/multiprocessing.h"
 
 #define AST2700_SOC_IO_SIZE          0x01000000
 #define AST2700_SOC_IOMEM_SIZE       0x01000000
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 56267ec2bd2..e83a88d3369 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -36,6 +36,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/multiprocessing.h"
 
 #define EXYNOS4210_CHIPID_ADDR         0x10000000
 
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index d7ee306de7a..e6c16537eef 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "qemu/units.h"
 #include "system/system.h"
+#include "target/arm/multiprocessing.h"
 
 /*
  * This covers the whole MMIO space. We'll use this to catch any MMIO accesses
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index deae5cf9861..25ffb029ff4 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -52,6 +52,7 @@
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/multiprocessing.h"
 
 #define RAMLIMIT_GB 8192
 #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 16e6110b68f..47f23b6e2c0 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -51,6 +51,7 @@
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/system.h"
+#include "target/arm/multiprocessing.h"
 
 struct VMAppleMachineState {
     MachineState parent;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a08a269ad61..5969249b579 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/multiprocessing.h"
 #include "migration/blocker.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
-- 
2.47.1


