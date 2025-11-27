Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE89CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObrl-0003B2-2b; Thu, 27 Nov 2025 08:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr6-0002k0-OQ
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqy-0001IE-TO
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQIjFIgFEKZNL57CWppgTe5fleUieqhoACa2fnBgQjU=;
 b=FGMGpFTb0W08PKiRu+Ms1HcYRnBIMZIp2twOLeSjXt2MlK3Rx79tMBA1Tx6EaYGMYWG8pa
 aEFo1u8vtmXF9Nv7Oogy6dwjiH8V9N/LRb0ABmGWgBxvfT7lkvuT1JWFariqwasMfF5fsB
 gJ3NG2FBZBxzCPI7sRDb810gcYgsdas=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-Xg0bB0dIMKa-rrVEDnWwLw-1; Thu, 27 Nov 2025 08:15:58 -0500
X-MC-Unique: Xg0bB0dIMKa-rrVEDnWwLw-1
X-Mimecast-MFC-AGG-ID: Xg0bB0dIMKa-rrVEDnWwLw_1764249357
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b733b21a138so90691266b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249356; x=1764854156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XQIjFIgFEKZNL57CWppgTe5fleUieqhoACa2fnBgQjU=;
 b=JGdUNMXyafoB592N8XmXZh2rxQRr6aV1qMdOXGaGPhrr+sw5Y853RMS0FeP4nK+ke2
 jEyMyz9cibdPwCfQq43eAKE9dPZVq5/ccEtfkPzCz/ZjAFBYzLqB9Dq8FENfxLnBl9+a
 CXN7vTEkIMEEGv6kjtOjLw4jqTGbLke8iui13J8/m10uwOibSksvSe4cnytrN6dVb5lw
 ospdHli0Bg0rUbzaVYyCgYOIOXEJ7gZmsdW1TXyCZELPqp+7HMGOiBZmGzPBUqRzbX2i
 lcWWeusMEO8aV06qxakoFVvcJaOMCOaH1ksOls6BxzgPTDihsKWdcVH3H78fzBOZ4Xo8
 mrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249356; x=1764854156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XQIjFIgFEKZNL57CWppgTe5fleUieqhoACa2fnBgQjU=;
 b=u9DYL1HaqvBuiYJHz8EiQwsrwPsXa+Ic7M5k475U7jzU/yX8Zpr59qnuN3x3d6wfas
 OF6P8HkEEjDCjtZfk/N4AkK6uHtnugLgLLYnlSrnmToBgOPH3k/74WKgY9c9gznovu63
 LOWBWt8/1jHaxmhzQ4N/NwvLTLvBRKgiExvflB00RRYFUGwbZ73/ZFEIWNPOVpDSzhcB
 M1j59n0g6OZsT1dUMxf91Z8Sa6Ci4s8abVFRxcinqRVNYHO2hZZeRURzJfZxib4RTGl3
 hrsZR4KJbi40javjeDtuJxAdpThZsbfzcOPbwSH1RWNUOgegmSbr4gww5JElRS2tF1yk
 7qEA==
X-Gm-Message-State: AOJu0Yxsb3rdB/gbCea5DPY1tuz/4GFOH9ClQRAZncRXzmlo+3rCB7e5
 f69db4mkL/OqnHu7W2AnNhdQgfE0E3D6ikHSPGxbyTTnVS588HkqIyzv+Ttre9DrZd0fgGhzQDx
 lV7iUx00T2fse08xTwV+uQUzS9byf8z0+6pz8bA/L1/xFBGdKIHAXuAQMlKrquVQjbxrpxsenpB
 GbkbU5yANZBU8ChNdr/9G9ns7hXayBCyamnlr2dbSe
X-Gm-Gg: ASbGnctwjafZs2qWAQM7rHYHTyAGxgowGoPlZMP0qS/Vyf3wfJmghzDWBnzEe/ik8nM
 Spo6GvgBiVn7fNWqiBhzRELbb7BdGiyO2UmKKeNpryDQTKIP4KrJrMwYmW31KA7CWGXusTtezDc
 E/euEMjSTMD9o0ysnmo1PJ4JPxGrrpF57rFrldsHR8rcbD/5saZk+lY2ixDn4dVoXLYIZKOY16Q
 bkA07LgU8yjIJ/Ts+rxI1MwtPRvxD7DzG/rEQeoW+SOwVTsUn+2sl1ZVwiPU4/G2JCWNX/NEDYU
 WWrUnfkqa+0YOe3IVIRHjGNg3U/iE0COR88O2yB1sCZsiqjqoU79Xx3Zc7S1Sl4tr+a+aPkK6lc
 9G0Fe3Pp3gHna/aQ4NzBEGH1+J7ud0aMRpD3JIjLr70P+qYlPil63Eoho/Iy+VA4ZV/wCl4pBFg
 orW7VF6V+D8bJSpgE=
X-Received: by 2002:a17:907:3f1e:b0:b73:5acd:465e with SMTP id
 a640c23a62f3a-b767153ee39mr2632923166b.11.1764249355871; 
 Thu, 27 Nov 2025 05:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9JUauvtIrEI2RISFncHMHMcyktLZBFUqBJ3goZ6kmqZ50K2hhpQnzuR4dYULVNpyXkRfJsA==
X-Received: by 2002:a17:907:3f1e:b0:b73:5acd:465e with SMTP id
 a640c23a62f3a-b767153ee39mr2632906566b.11.1764249353864; 
 Thu, 27 Nov 2025 05:15:53 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5162088sm162990366b.1.2025.11.27.05.15.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/28] include: move hw/registerfields.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:08 +0100
Message-ID: <20251127131516.80807-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                | 2 +-
 docs/devel/style.rst                       | 2 +-
 hw/arm/smmuv3-internal.h                   | 2 +-
 hw/intc/gic_internal.h                     | 2 +-
 hw/intc/gicv3_internal.h                   | 2 +-
 hw/sd/sdhci-internal.h                     | 2 +-
 include/block/nvme.h                       | 2 +-
 include/block/ufs.h                        | 2 +-
 include/fpu/softfloat-types.h              | 2 +-
 include/hw/acpi/tpm.h                      | 2 +-
 include/hw/char/nrf51_uart.h               | 2 +-
 include/hw/{ => core}/registerfields.h     | 0
 include/hw/i2c/aspeed_i2c.h                | 2 +-
 include/hw/misc/bcm2835_cprman_internals.h | 2 +-
 include/hw/misc/stm32l4x5_rcc_internals.h  | 2 +-
 include/hw/register.h                      | 2 +-
 target/arm/cpregs.h                        | 2 +-
 target/arm/cpu-features.h                  | 2 +-
 target/arm/cpu.h                           | 2 +-
 target/arm/internals.h                     | 2 +-
 target/arm/mmuidx-internal.h               | 2 +-
 target/hexagon/cpu.h                       | 2 +-
 target/hppa/cpu.h                          | 2 +-
 target/loongarch/cpu-csr.h                 | 2 +-
 target/loongarch/cpu.h                     | 2 +-
 target/ppc/cpu.h                           | 2 +-
 target/ppc/internal.h                      | 2 +-
 target/riscv/cpu.h                         | 2 +-
 target/riscv/internals.h                   | 2 +-
 target/riscv/vector_internals.h            | 2 +-
 target/rx/cpu.h                            | 2 +-
 target/tricore/cpu.h                       | 2 +-
 hw/adc/npcm7xx_adc.c                       | 2 +-
 hw/arm/armsse.c                            | 2 +-
 hw/arm/raspi.c                             | 2 +-
 hw/arm/raspi4b.c                           | 2 +-
 hw/char/cmsdk-apb-uart.c                   | 2 +-
 hw/char/ibex_uart.c                        | 2 +-
 hw/char/renesas_sci.c                      | 2 +-
 hw/char/stm32l4x5_usart.c                  | 2 +-
 hw/gpio/aspeed_gpio.c                      | 2 +-
 hw/i2c/arm_sbcon_i2c.c                     | 2 +-
 hw/i2c/aspeed_i2c.c                        | 2 +-
 hw/intc/aspeed_intc.c                      | 2 +-
 hw/intc/rx_icu.c                           | 2 +-
 hw/misc/armsse-cpu-pwrctrl.c               | 2 +-
 hw/misc/armsse-cpuid.c                     | 2 +-
 hw/misc/armsse-mhu.c                       | 2 +-
 hw/misc/aspeed_i3c.c                       | 2 +-
 hw/misc/aspeed_peci.c                      | 2 +-
 hw/misc/bcm2835_thermal.c                  | 2 +-
 hw/misc/imx6ul_ccm.c                       | 2 +-
 hw/misc/imx7_src.c                         | 2 +-
 hw/misc/iotkit-secctl.c                    | 2 +-
 hw/misc/iotkit-sysctl.c                    | 2 +-
 hw/misc/iotkit-sysinfo.c                   | 2 +-
 hw/misc/mps2-fpgaio.c                      | 2 +-
 hw/misc/mps2-scc.c                         | 2 +-
 hw/misc/npcm7xx_mft.c                      | 2 +-
 hw/misc/npcm7xx_pwm.c                      | 2 +-
 hw/misc/sifive_e_aon.c                     | 2 +-
 hw/misc/stm32l4x5_rcc.c                    | 2 +-
 hw/misc/tz-mpc.c                           | 2 +-
 hw/misc/tz-msc.c                           | 2 +-
 hw/misc/tz-ppc.c                           | 2 +-
 hw/misc/xlnx-versal-cframe-reg.c           | 2 +-
 hw/misc/zynq_slcr.c                        | 2 +-
 hw/net/cadence_gem.c                       | 2 +-
 hw/net/msf2-emac.c                         | 2 +-
 hw/net/npcm_gmac.c                         | 2 +-
 hw/net/npcm_pcs.c                          | 2 +-
 hw/net/smc91c111.c                         | 2 +-
 hw/pci-host/aspeed_pcie.c                  | 2 +-
 hw/pci-host/bonito.c                       | 2 +-
 hw/pci-host/gt64120.c                      | 2 +-
 hw/rtc/ls7a_rtc.c                          | 2 +-
 hw/sd/sd.c                                 | 2 +-
 hw/sensor/tmp105.c                         | 2 +-
 hw/ssi/ibex_spi_host.c                     | 2 +-
 hw/ssi/npcm_pspi.c                         | 2 +-
 hw/timer/bcm2835_systmr.c                  | 2 +-
 hw/timer/cmsdk-apb-dualtimer.c             | 2 +-
 hw/timer/cmsdk-apb-timer.c                 | 2 +-
 hw/timer/renesas_cmt.c                     | 2 +-
 hw/timer/renesas_tmr.c                     | 2 +-
 hw/timer/sifive_pwm.c                      | 2 +-
 hw/timer/sse-counter.c                     | 2 +-
 hw/timer/sse-timer.c                       | 2 +-
 hw/watchdog/allwinner-wdt.c                | 2 +-
 hw/watchdog/cmsdk-apb-watchdog.c           | 2 +-
 target/tricore/helper.c                    | 2 +-
 tests/qtest/sdhci-test.c                   | 2 +-
 tests/qtest/sifive-e-aon-watchdog-test.c   | 2 +-
 tests/qtest/stm32l4x5_rcc-test.c           | 2 +-
 tests/qtest/stm32l4x5_usart-test.c         | 2 +-
 95 files changed, 94 insertions(+), 94 deletions(-)
 rename include/hw/{ => core}/registerfields.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f6e9ad535fa..55cdcc46752 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3560,7 +3560,7 @@ M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
 F: hw/core/register.c
 F: include/hw/register.h
-F: include/hw/registerfields.h
+F: include/hw/core/registerfields.h
 
 Rust
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 941fe14bfd4..12e509d10de 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -433,7 +433,7 @@ We also suggest avoiding bitfields even in structures where the exact
 layout does not matter, unless you can show that they provide a significant
 usability benefit.
 
-We encourage the usage of ``include/hw/registerfields.h`` as a safe replacement
+We encourage the usage of ``include/hw/core/registerfields.h`` as a safe replacement
 for bitfields.
 
 Reserved namespaces in C and POSIX
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b6b7399347f..d15031f2651 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -21,7 +21,7 @@
 #ifndef HW_ARM_SMMUV3_INTERNAL_H
 #define HW_ARM_SMMUV3_INTERNAL_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/arm/smmu-common.h"
 
 typedef enum SMMUTranslationStatus {
diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
index 8ddbf554c69..b821f1feb3b 100644
--- a/hw/intc/gic_internal.h
+++ b/hw/intc/gic_internal.h
@@ -21,7 +21,7 @@
 #ifndef QEMU_ARM_GIC_INTERNAL_H
 #define QEMU_ARM_GIC_INTERNAL_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/intc/arm_gic.h"
 
 #define ALL_CPU_MASK ((unsigned)(((1 << GIC_NCPU) - 1)))
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index fc586524f56..880dbe52d86 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -24,7 +24,7 @@
 #ifndef QEMU_ARM_GICV3_INTERNAL_H
 #define QEMU_ARM_GICV3_INTERNAL_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/intc/arm_gicv3_common.h"
 
 /* Distributor registers, as offsets from the distributor base address */
diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 9f768c418e0..3e81821dd1e 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -24,7 +24,7 @@
 #ifndef SDHCI_INTERNAL_H
 #define SDHCI_INTERNAL_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 /* R/W SDMA System Address register 0x0 */
 #define SDHC_SYSAD                     0x00
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 9fa2ecaf281..f6373d458bc 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1,7 +1,7 @@
 #ifndef BLOCK_NVME_H
 #define BLOCK_NVME_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 typedef struct QEMU_PACKED NvmeBar {
     uint64_t    cap;
diff --git a/include/block/ufs.h b/include/block/ufs.h
index a3ee62b027a..ede4aff08ea 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -3,7 +3,7 @@
 #ifndef BLOCK_UFS_H
 #define BLOCK_UFS_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 typedef struct QEMU_PACKED UfsReg {
     uint32_t cap;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 1af2a0cb14b..8f82fdfc975 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -80,7 +80,7 @@ this code that are retained.
 #ifndef SOFTFLOAT_TYPES_H
 #define SOFTFLOAT_TYPES_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 /*
  * Software IEC/IEEE floating-point types.
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 9d0fe6f2f96..d2bf6637c54 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -17,7 +17,7 @@
 #define HW_ACPI_TPM_H
 
 #include "qemu/units.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/acpi/aml-build.h"
 #include "system/tpm.h"
 
diff --git a/include/hw/char/nrf51_uart.h b/include/hw/char/nrf51_uart.h
index 03d8c2a20d2..7a54db746bd 100644
--- a/include/hw/char/nrf51_uart.h
+++ b/include/hw/char/nrf51_uart.h
@@ -13,7 +13,7 @@
 
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "qom/object.h"
 
 #define UART_FIFO_LENGTH 6
diff --git a/include/hw/registerfields.h b/include/hw/core/registerfields.h
similarity index 100%
rename from include/hw/registerfields.h
rename to include/hw/core/registerfields.h
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 2daacc10ce0..c9c2620a8a3 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -22,7 +22,7 @@
 
 #include "hw/i2c/i2c.h"
 #include "hw/sysbus.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "qom/object.h"
 
 #define TYPE_ASPEED_I2C "aspeed.i2c"
diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
index 7617aff96fd..de75139cfdd 100644
--- a/include/hw/misc/bcm2835_cprman_internals.h
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -9,7 +9,7 @@
 #ifndef HW_MISC_BCM2835_CPRMAN_INTERNALS_H
 #define HW_MISC_BCM2835_CPRMAN_INTERNALS_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/misc/bcm2835_cprman.h"
 
 #define TYPE_CPRMAN_PLL "bcm2835-cprman-pll"
diff --git a/include/hw/misc/stm32l4x5_rcc_internals.h b/include/hw/misc/stm32l4x5_rcc_internals.h
index ff1c834f694..1e044604c87 100644
--- a/include/hw/misc/stm32l4x5_rcc_internals.h
+++ b/include/hw/misc/stm32l4x5_rcc_internals.h
@@ -18,7 +18,7 @@
 #ifndef HW_STM32L4X5_RCC_INTERNALS_H
 #define HW_STM32L4X5_RCC_INTERNALS_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/misc/stm32l4x5_rcc.h"
 
 #define TYPE_RCC_CLOCK_MUX "stm32l4x5-rcc-clock-mux"
diff --git a/include/hw/register.h b/include/hw/register.h
index b3d20fee7d3..1f265f4ed71 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -13,7 +13,7 @@
 
 #include "hw/core/qdev.h"
 #include "system/memory.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "qom/object.h"
 
 typedef struct RegisterInfo RegisterInfo;
diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 48a406a5fbc..f5ec7484c1d 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -21,7 +21,7 @@
 #ifndef TARGET_ARM_CPREGS_H
 #define TARGET_ARM_CPREGS_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "exec/memop.h"
 #include "target/arm/kvm-consts.h"
 #include "cpu.h"
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 579fa8f8f42..c86a4e667dc 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -20,7 +20,7 @@
 #ifndef TARGET_ARM_FEATURES_H
 #define TARGET_ARM_FEATURES_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "qemu/host-utils.h"
 #include "cpu.h"
 #include "cpu-sysregs.h"
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39f2b2e54de..9579d43ba33 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -22,7 +22,7 @@
 
 #include "kvm-consts.h"
 #include "qemu/cpu-float.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 75677945af3..9cd4bf74efb 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -29,7 +29,7 @@
 #include "exec/vaddr.h"
 #include "exec/breakpoint.h"
 #include "accel/tcg/tb-cpu-state.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "system/memory.h"
 #include "syndrome.h"
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 962b0538526..776e31c9ba5 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -8,7 +8,7 @@
 
 #include "mmuidx.h"
 #include "tcg/debug-assert.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 
 FIELD(MMUIDXINFO, EL, 0, 2)
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 43a854f5172..656b7dc0449 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -25,7 +25,7 @@
 #include "exec/cpu-defs.h"
 #include "hex_regs.h"
 #include "mmvec/mmvec.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 #ifndef CONFIG_USER_ONLY
 #error "Hexagon does not support system emulation"
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c652ef945ac..012e54f8f6f 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -27,7 +27,7 @@
 #include "system/memory.h"
 #include "qemu/cpu-float.h"
 #include "qemu/interval-tree.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 #define MMU_KERNEL_IDX    0
 #define MMU_KERNEL_P_IDX  1
diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 68989474987..77555929264 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -8,7 +8,7 @@
 #ifndef LOONGARCH_CPU_CSR_H
 #define LOONGARCH_CPU_CSR_H
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 /* Based on kernel definitions: arch/loongarch/include/asm/loongarch.h */
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 1a14469b3bc..92af68ea7f8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -13,7 +13,7 @@
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "qemu/timer.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/memory.h"
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 787020f6f90..dbebae89dce 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -27,7 +27,7 @@
 #include "exec/cpu-interrupt.h"
 #include "cpu-qom.h"
 #include "qom/object.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 #define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
 
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 7723350227f..58f315ffcf5 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -19,7 +19,7 @@
 #define PPC_INTERNAL_H
 
 #include "exec/breakpoint.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "exec/page-protection.h"
 #include "accel/tcg/tb-cpu-state.h"
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b54cd78f8f7..90b3e951053 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -21,7 +21,7 @@
 #define RISCV_CPU_H
 
 #include "hw/core/cpu.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 172296f12e2..35b923c4bf5 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -20,7 +20,7 @@
 #define RISCV_CPU_INTERNALS_H
 
 #include "exec/cpu-common.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "fpu/softfloat-types.h"
 #include "target/riscv/cpu_bits.h"
 
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 8eee7e5c31c..5681b818153 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -20,7 +20,7 @@
 #define TARGET_RISCV_VECTOR_INTERNALS_H
 
 #include "qemu/bitops.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "cpu.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index ba5761b6472..b3b1ecff5af 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -20,7 +20,7 @@
 #define RX_CPU_H
 
 #include "qemu/bitops.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "cpu-qom.h"
 
 #include "exec/cpu-common.h"
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 82085fbc32f..ab46192e261 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -21,7 +21,7 @@
 #define TRICORE_CPU_H
 
 #include "cpu-qom.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index 44079791cbd..3584c27c75a 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -18,7 +18,7 @@
 #include "hw/adc/npcm7xx_adc.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 42ceb097ae8..b6fc95df3b6 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -18,7 +18,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/arm/armsse.h"
 #include "hw/arm/armsse-version.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 637525a7e3f..1276bb4df40 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -20,7 +20,7 @@
 #include "hw/arm/bcm2836.h"
 #include "hw/arm/bcm2838.h"
 #include "hw/arm/raspi_platform.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index ead28500c73..3eeb8f447e6 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -14,7 +14,7 @@
 #include "hw/arm/machines-qom.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/display/bcm2835_fb.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
 #include "hw/core/boards.h"
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index c3645a553ec..1a83e4a9bd1 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -22,7 +22,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
 #include "hw/char/cmsdk-apb-uart.h"
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index 3166f6d3094..127d219df3c 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -31,7 +31,7 @@
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
index f1c5d5ae6b3..dc2810a9b11 100644
--- a/hw/char/renesas_sci.c
+++ b/hw/char/renesas_sci.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/char/renesas_sci.h"
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 664d03d6b96..736f1e764e6 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -28,7 +28,7 @@
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "trace.h"
 
 
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 85a5acd7087..d9237d4360f 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -16,7 +16,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "trace.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 #define GPIOS_PER_GROUP 8
 
diff --git a/hw/i2c/arm_sbcon_i2c.c b/hw/i2c/arm_sbcon_i2c.c
index 979ccbe0ed6..688f45c3139 100644
--- a/hw/i2c/arm_sbcon_i2c.c
+++ b/hw/i2c/arm_sbcon_i2c.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index e3ca77865bd..1f9ce131bf7 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -29,7 +29,7 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "trace.h"
 
 /* Enable SLAVE_ADDR_RX_MATCH always */
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index d92305b9ca1..f14c340b602 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -11,7 +11,7 @@
 #include "hw/core/irq.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "qapi/error.h"
 
 /*
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index 788afe6b1a0..87cdc6cbdef 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -27,7 +27,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "hw/core/irq.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/intc/rx_icu.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/armsse-cpu-pwrctrl.c b/hw/misc/armsse-cpu-pwrctrl.c
index 66e9218f277..87770facfce 100644
--- a/hw/misc/armsse-cpu-pwrctrl.c
+++ b/hw/misc/armsse-cpu-pwrctrl.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/misc/armsse-cpu-pwrctrl.h"
 
 REG32(CPUPWRCFG, 0x0)
diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
index 3a52bb5381f..03833125514 100644
--- a/hw/misc/armsse-cpuid.c
+++ b/hw/misc/armsse-cpuid.c
@@ -24,7 +24,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/misc/armsse-cpuid.h"
 #include "hw/core/qdev-properties.h"
 
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
index 2673c2de3ef..6fbe2cca37e 100644
--- a/hw/misc/armsse-mhu.c
+++ b/hw/misc/armsse-mhu.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/irq.h"
 #include "hw/misc/armsse-mhu.h"
 
diff --git a/hw/misc/aspeed_i3c.c b/hw/misc/aspeed_i3c.c
index 37a05b9ce27..ac6db214ee2 100644
--- a/hw/misc/aspeed_i3c.c
+++ b/hw/misc/aspeed_i3c.c
@@ -11,7 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "hw/misc/aspeed_i3c.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/aspeed_peci.c b/hw/misc/aspeed_peci.c
index cf902a8ab8c..0569ee57d1f 100644
--- a/hw/misc/aspeed_peci.c
+++ b/hw/misc/aspeed_peci.c
@@ -11,7 +11,7 @@
 #include "qemu/log.h"
 #include "hw/core/irq.h"
 #include "hw/misc/aspeed_peci.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "trace.h"
 
 #define ASPEED_PECI_CC_RSP_SUCCESS (0x40U)
diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
index 33bfc91c7aa..0dc1be15b4a 100644
--- a/hw/misc/bcm2835_thermal.c
+++ b/hw/misc/bcm2835_thermal.c
@@ -10,7 +10,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/misc/bcm2835_thermal.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 
 REG32(CTL, 0)
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index 7f3ae61710c..c4f6e372fe1 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 #include "hw/misc/imx6ul_ccm.h"
 #include "qemu/log.h"
diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
index df0b0a69057..77f13bd020b 100644
--- a/hw/misc/imx7_src.c
+++ b/hw/misc/imx7_src.c
@@ -17,7 +17,7 @@
 #include "qemu/module.h"
 #include "target/arm/arm-powerctl.h"
 #include "hw/core/cpu.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 #include "trace.h"
 
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 64e94a76479..832b0217774 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -16,7 +16,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/irq.h"
 #include "hw/misc/iotkit-secctl.h"
 #include "hw/arm/armsse-version.h"
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index a9c3568c216..d673ae326bc 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/misc/iotkit-sysctl.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/armsse-version.h"
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index a53b1f51802..3b4d228e3ef 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -23,7 +23,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/misc/iotkit-sysinfo.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/armsse-version.h"
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index f3d51fd2286..9cd5e9884c0 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -22,7 +22,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/misc/mps2-fpgaio.h"
 #include "hw/misc/led.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 56aa0135072..06d436cf58e 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -25,7 +25,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/misc/mps2-scc.h"
 #include "hw/misc/led.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index 21e74385c71..742166c4e82 100644
--- a/hw/misc/npcm7xx_mft.c
+++ b/hw/misc/npcm7xx_mft.c
@@ -20,7 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/misc/npcm7xx_mft.h"
 #include "hw/misc/npcm7xx_pwm.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/misc/npcm7xx_pwm.c b/hw/misc/npcm7xx_pwm.c
index 1b010e51ec0..3ee34820c8a 100644
--- a/hw/misc/npcm7xx_pwm.c
+++ b/hw/misc/npcm7xx_pwm.c
@@ -19,7 +19,7 @@
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/misc/npcm7xx_pwm.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
index 4d6e015ca38..0e82ae3758b 100644
--- a/hw/misc/sifive_e_aon.c
+++ b/hw/misc/sifive_e_aon.c
@@ -20,7 +20,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/misc/sifive_e_aon.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index cf7fa28cbe9..85095871340 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -28,7 +28,7 @@
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "trace.h"
 
 #define HSE_DEFAULT_FRQ 48000000ULL
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index fb5d232bff5..65517d390d3 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -16,7 +16,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/irq.h"
 #include "hw/misc/tz-mpc.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index 3e33455d421..dd845193d64 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -16,7 +16,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/irq.h"
 #include "hw/misc/tz-msc.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index a41c6011fba..7b812a034b2 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -16,7 +16,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/irq.h"
 #include "hw/misc/tz-ppc.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 33a4ece26f6..a5a5e41f3e3 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/units.h"
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index d1900a2b948..d7d490b093d 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -21,7 +21,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/qdev-clock.h"
 #include "qom/object.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index fe9747fdb6f..b568fa3392d 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -28,7 +28,7 @@
 #include "hw/core/irq.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/net/msf2-emac.c b/hw/net/msf2-emac.c
index ac01d1ce472..077485c95d9 100644
--- a/hw/net/msf2-emac.c
+++ b/hw/net/msf2-emac.c
@@ -31,7 +31,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/net/msf2-emac.h"
 #include "hw/net/mii.h"
 #include "hw/core/irq.h"
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 5e32cd3edf3..123fb92ca40 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -23,7 +23,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/net/mii.h"
 #include "hw/net/npcm_gmac.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/npcm_pcs.c b/hw/net/npcm_pcs.c
index 6aec105271a..ae078e14c38 100644
--- a/hw/net/npcm_pcs.c
+++ b/hw/net/npcm_pcs.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 
 #include "exec/hwaddr.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/net/npcm_pcs.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index e3bf3b0e726..d6f57bc004a 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -13,7 +13,7 @@
 #include "net/net.h"
 #include "hw/core/irq.h"
 #include "hw/net/smc91c111.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 27f1078e3a5..83a1c7075c3 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -18,7 +18,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 90040045c1f..ff2f5c966eb 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -50,7 +50,7 @@
 #include "migration/vmstate.h"
 #include "system/runstate.h"
 #include "hw/misc/unimp.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "qom/object.h"
 #include "trace.h"
 
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 2339f10a30a..d361c457edb 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -30,7 +30,7 @@
 #include "qemu/log.h"
 #include "qemu/bswap.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
 #include "hw/misc/empty_slot.h"
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index 234a7e97698..54943f60b80 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -16,7 +16,7 @@
 #include "migration/vmstate.h"
 #include "hw/misc/unimp.h"
 #include "system/rtc.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 
 #define SYS_TOYTRIM        0x20
 #define SYS_TOYWRITE0      0x24
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5aa34f1d5bd..5a1fda38a7b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -36,7 +36,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "hw/core/irq.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "system/block-backend.h"
 #include "hw/sd/sd.h"
 #include "migration/vmstate.h"
diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 4e5c968bcc7..c5089d74f4b 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "trace.h"
 
 FIELD(CONFIG, SHUTDOWN_MODE,        0, 1)
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index 50cf08de9c9..1e574c3fcb8 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/ssi/ibex_spi_host.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/ssi/npcm_pspi.c b/hw/ssi/npcm_pspi.c
index 1f11e1f8a46..2e05d5dacb2 100644
--- a/hw/ssi/npcm_pspi.c
+++ b/hw/ssi/npcm_pspi.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/core/irq.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/ssi/npcm_pspi.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index 7929aaa882a..00bcfcd05c6 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -16,7 +16,7 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "hw/timer/bcm2835_systmr.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index bcb6f8e43d7..39b1fa3a149 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -24,7 +24,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index d80bf1f96d0..e8b6601097c 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -34,7 +34,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/timer/cmsdk-apb-timer.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
index 35962e66c32..a5cc7ebd270 100644
--- a/hw/timer/renesas_cmt.c
+++ b/hw/timer/renesas_cmt.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/timer/renesas_cmt.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index 2e7d7d4543a..c917f70de22 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/timer/renesas_tmr.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
index 8fda5445e74..780eaa50799 100644
--- a/hw/timer/sifive_pwm.c
+++ b/hw/timer/sifive_pwm.c
@@ -29,7 +29,7 @@
 #include "hw/core/irq.h"
 #include "hw/timer/sifive_pwm.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/timer/sse-counter.c b/hw/timer/sse-counter.c
index de9d354483b..39d140347e5 100644
--- a/hw/timer/sse-counter.c
+++ b/hw/timer/sse-counter.c
@@ -33,7 +33,7 @@
 #include "trace.h"
 #include "hw/timer/sse-counter.h"
 #include "hw/sysbus.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/clock.h"
 #include "hw/core/qdev-clock.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index 50d1de58055..62381e07e06 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -42,7 +42,7 @@
 #include "hw/timer/sse-counter.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/clock.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/watchdog/allwinner-wdt.c b/hw/watchdog/allwinner-wdt.c
index 8fcd7766752..68b600689a5 100644
--- a/hw/watchdog/allwinner-wdt.c
+++ b/hw/watchdog/allwinner-wdt.c
@@ -26,7 +26,7 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "hw/sysbus.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/watchdog/allwinner-wdt.h"
 #include "system/watchdog.h"
 #include "migration/vmstate.h"
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 90d14e342b0..ceae792580e 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -29,7 +29,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "migration/vmstate.h"
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 7574111c87d..7ee8c7fd699 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-mmu-index.h"
diff --git a/tests/qtest/sdhci-test.c b/tests/qtest/sdhci-test.c
index 6275e7626c2..7b32711c8f8 100644
--- a/tests/qtest/sdhci-test.c
+++ b/tests/qtest/sdhci-test.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "libqtest.h"
 #include "qemu/module.h"
 #include "libqos/pci-pc.h"
diff --git a/tests/qtest/sifive-e-aon-watchdog-test.c b/tests/qtest/sifive-e-aon-watchdog-test.c
index 1f313d16ad8..277f1b8360b 100644
--- a/tests/qtest/sifive-e-aon-watchdog-test.c
+++ b/tests/qtest/sifive-e-aon-watchdog-test.c
@@ -20,7 +20,7 @@
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "libqtest.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "hw/misc/sifive_e_aon.h"
 
 FIELD(AON_WDT_WDOGCFG, SCALE, 0, 4)
diff --git a/tests/qtest/stm32l4x5_rcc-test.c b/tests/qtest/stm32l4x5_rcc-test.c
index d927c655d13..4ab0a0ab29f 100644
--- a/tests/qtest/stm32l4x5_rcc-test.c
+++ b/tests/qtest/stm32l4x5_rcc-test.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "libqtest-single.h"
 #include "hw/misc/stm32l4x5_rcc_internals.h"
 
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index 98a7472307f..a72c5a685d1 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "hw/misc/stm32l4x5_rcc_internals.h"
-#include "hw/registerfields.h"
+#include "hw/core/registerfields.h"
 #include "stm32l4x5.h"
 
 #define RCC_BASE_ADDR 0x40021000
-- 
2.51.1


