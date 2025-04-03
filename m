Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389F3C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UU0-00030E-UF; Thu, 03 Apr 2025 20:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTy-0002km-O2
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTw-0002yE-KZ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:26 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so1224932f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724822; x=1744329622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32V1HojRNsh/T5N/dXOEuwUaz3gtbYi6NWT44YAtRCI=;
 b=e0ZAfoRk3rLy+n5YUJjuSkWWgmfyx2GJWnmyg4SBNloS4RzPwo2oFilH7fohcxLmd2
 weeyvAvPCkfJQoPT5BCFhrwUsehnxBciiBUl5iNVbTl0WXiZwu3pStvm/S3v/tXjdwjS
 VL+5DzvL9YJ8ggLW6jmHYl55uu5BakpDe46UA791QqgboXhzXL3qZbrCbkZ7FuYTI1YG
 rlomLsHfgUdgue2cU4t4Jjrvnd9vNINJBmyw2QvS0dsQV9fggBAeApNmW4PCO0DoxsLh
 MhWrDZ5vOqEnX/GvOexV7uOFiVFg4XkhfTrgZZCDmrloLJqREWnCdhJH7XePvwjFALCi
 n6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724822; x=1744329622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32V1HojRNsh/T5N/dXOEuwUaz3gtbYi6NWT44YAtRCI=;
 b=sLCxnPibVKIz/uznOs9ZnOz17QMt9vdcd/bwCFE2AjZPqnEGdtuGyB6bX9QDFm8BaM
 Iq5HJsjKuVq3a2GXeNnS/IOm1KKNoMe/4/bVOTSPRkGIcHO1OAjadsbkCUJyBJzouVu7
 mjMftJwW7xsYplQ7U1DjOgsWkiMWtYefw1OQiV6wSRWyPuIp6OeM7w14KPp3vBpdf5J+
 U3m7CVPw9txK9VsGJxglWG70GcLOOkiSfSFStldkFjW6bQ54gpdN2a7SLYak5kAw+7GO
 +IkgrhUnJMMMCclvnxgZYjo9vLTbAoyp2KTWiubkai5a9UyyGd9HR4bnKGXAQtYAR+uF
 fI9Q==
X-Gm-Message-State: AOJu0YwPJCrYdrGBYpDtlIdLeJXpjCfPi5DpKJCGcGHCi4bZ24iHQxbr
 mD3yXKm6Gd9sgsIhLUATOSaHFxkX7zhMPPwaCJ2TRp4I05xHCCttVfc+LFwkm8atbBDbNYKVT1m
 s
X-Gm-Gg: ASbGncvUhDI9EWhhEGnrucRAJFhLwX+ZcD86cdZ9WT6P0SNcOkLDxoirHrVoCbszS8L
 geZt5xKj7EGkcLB91EsVMh4vOJ4d+EexWRLa/JojrInTOTdyYuqEYnoehHPfPo3cCNhLvpvyhjR
 jMJaDclzZ9BXjoCOsup2yU1aAJSplWrxXG8+xmurSGvvjjBbyY6tf9VjF4VXpy+ipkBcXgch6Os
 R2YqfUC4zCBpBphf48zifWqPEbQjiuyY/HlEHDo5hHYhu8qFwa4ZtxinSXZUTjvZdw/sM3GI4B2
 0Bczi06LRrVtRMYYxdJrF/p6dKWOJL1auaBjIQTdhvpxsFSTV50IbDTF4lqwmgIZMVQBfeRsbtx
 KI1CRG405VveHlanpOlg=
X-Google-Smtp-Source: AGHT+IF9RcpNw8afbE4Br0wvMrHGjZYCmODuHqwekIhOM1V90rPXGNTMYD/OsZYaUKOHitLAS39AiQ==
X-Received: by 2002:a5d:64aa:0:b0:39c:dfa:d347 with SMTP id
 ffacd0b85a97d-39cb36b2afemr845667f8f.2.1743724822630; 
 Thu, 03 Apr 2025 17:00:22 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a67a1sm2931343f8f.24.2025.04.03.17.00.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:00:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 18/39] target/arm: Move some definitions from
 'cpu.h' to 'multiprocessing.h'
Date: Fri,  4 Apr 2025 01:58:00 +0200
Message-ID: <20250403235821.9909-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
index 1a1ae229e1d..0db7292698c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1158,23 +1158,6 @@ void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
 
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
index 1f994ba26c6..4438402340b 100644
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
index dce7255a2c0..37bfeef304d 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -22,6 +22,7 @@
 #include "hw/intc/arm_gicv3.h"
 #include "qobject/qlist.h"
 #include "qemu/log.h"
+#include "target/arm/multiprocessing.h"
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_SRAM]      =  0x10000000,
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 04439364370..01e6e2fb052 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -36,6 +36,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/multiprocessing.h"
 
 #define EXYNOS4210_CHIPID_ADDR         0x10000000
 
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index f182accc47c..3987e55355b 100644
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
index 112cbbf29e6..90fbb56ba7a 100644
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
index fa117bf1511..9bb5b0553a2 100644
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
index 97de8c7e939..a28acdecf3e 100644
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


