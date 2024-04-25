Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224B5C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWg-0002Rd-VU; Thu, 25 Apr 2024 06:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWd-0002KF-L0
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWY-0007Eq-8c
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:23 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34c1a17da03so250243f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041616; x=1714646416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=usqTyuhd4ZHCj44xCBnwXB6CC08SjV0kVyVlX55Byrw=;
 b=SMkglc6IVfPL+ZxS3e+Llcd7sJXMrCVipEsbwGLitRMth6bTlP7vswN68e3Wu3nMgJ
 eANAHSZXDaTXKQpSrA6hy1d02W9pPIgPKis7O5/dQxw2u/w18Mz5vYhhgx8gQMrELnwl
 pqSH7gWtmORWelrghXIRfIC3VTFYpBw24U1rwP1EzBLMPp6mde+8/V6wY58lGLDUdhd3
 EkHreh5QJx0cNHLiKJbqvePqnFMd01HRxZzSqh1+b9tVr08ADz4ZOewN5Gn2KwuNR+9z
 rizD9Xy6AGOSdaAiX0wX0NkXQV+CNUMHrSSeaNhKEP+zWF0ZqavajvXLpTUxzLcW2XhX
 eqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041616; x=1714646416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usqTyuhd4ZHCj44xCBnwXB6CC08SjV0kVyVlX55Byrw=;
 b=IYvW4lg/BWGqpm2cU8CnD7Yl066NlHFdPrATg2GX+HJ9alBCFXLSFo1o31RKcyG6Tp
 IoeBxigcxoXTJHxtYdqlzlYeIG4S4e7iXwBMY5sNIM7A453MBFM0AJlykx/N+DkA0mgp
 wCVKd3ShP18QIo3yor2m8/ucj/h3/zLw+7/D8VA5F1Yr8Xl2zlrr5yfU+6Sq8dgB8rFH
 4zyD8rInbe+vWi+bzrJ6ROs3xSUwJzG4GSX6O+vWQY1DM+ohfPGX9m+u1sgdUa5dI1aZ
 Z+BCcEmAyRJfRNwjSrfGdJqrKW8+VEbifgKza3pqlnyZmyne2tn0s3Ft6RLsC1h8/jaQ
 0pcQ==
X-Gm-Message-State: AOJu0YzOtsXEiXEY/gxcNPvBeOY9Yh4q+fmnhVJkaiEuOK2tDsjOOfAq
 1tS5uyaGLPkcOjKV3lJ+RjDz0T/cz2HW2x+TkKUtdDsoDa/E5+tm/DIncuF6ftVYH7daM/QKDEL
 R
X-Google-Smtp-Source: AGHT+IFuXsKMysiACY6ev8AXd257IldyDwXoKTifS3m8s7rbybU0XHqxlKCELSlI/h1QK3yitBbyAw==
X-Received: by 2002:a05:6000:1e88:b0:34c:1c1e:a322 with SMTP id
 dd8-20020a0560001e8800b0034c1c1ea322mr984003wrb.22.1714041615516; 
 Thu, 25 Apr 2024 03:40:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/37] hw,
 target: Add ResetType argument to hold and exit phase methods
Date: Thu, 25 Apr 2024 11:39:51 +0100
Message-Id: <20240425103958.3237225-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

We pass a ResetType argument to the Resettable class enter
phase method, but we don't pass it to hold and exit, even though
the callsites have it readily available. This means that if
a device cared about the ResetType it would need to record it
in the enter phase method to use later on. Pass the type to
all three of the phase methods to avoid having to do that.

Commit created with

  for dir in hw target include; do \
      spatch --macro-file scripts/cocci-macro-file.h \
             --sp-file scripts/coccinelle/reset-type.cocci \
             --keep-comments --smpl-spacing --in-place \
             --include-headers --dir $dir; done

and no manual edits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-id: 20240412160809.1260625-5-peter.maydell@linaro.org
---
 include/hw/resettable.h             |  4 ++--
 hw/adc/npcm7xx_adc.c                |  2 +-
 hw/arm/pxa2xx_pic.c                 |  2 +-
 hw/arm/smmu-common.c                |  2 +-
 hw/arm/smmuv3.c                     |  4 ++--
 hw/arm/stellaris.c                  | 10 +++++-----
 hw/audio/asc.c                      |  2 +-
 hw/char/cadence_uart.c              |  2 +-
 hw/char/sifive_uart.c               |  2 +-
 hw/core/cpu-common.c                |  2 +-
 hw/core/qdev.c                      |  4 ++--
 hw/core/reset.c                     |  2 +-
 hw/core/resettable.c                |  4 ++--
 hw/display/virtio-vga.c             |  4 ++--
 hw/gpio/npcm7xx_gpio.c              |  2 +-
 hw/gpio/pl061.c                     |  2 +-
 hw/gpio/stm32l4x5_gpio.c            |  2 +-
 hw/hyperv/vmbus.c                   |  2 +-
 hw/i2c/allwinner-i2c.c              |  2 +-
 hw/i2c/npcm7xx_smbus.c              |  2 +-
 hw/input/adb.c                      |  2 +-
 hw/input/ps2.c                      | 12 ++++++------
 hw/intc/arm_gic_common.c            |  2 +-
 hw/intc/arm_gic_kvm.c               |  4 ++--
 hw/intc/arm_gicv3_common.c          |  2 +-
 hw/intc/arm_gicv3_its.c             |  4 ++--
 hw/intc/arm_gicv3_its_common.c      |  2 +-
 hw/intc/arm_gicv3_its_kvm.c         |  4 ++--
 hw/intc/arm_gicv3_kvm.c             |  4 ++--
 hw/intc/xics.c                      |  2 +-
 hw/m68k/q800-glue.c                 |  2 +-
 hw/misc/djmemc.c                    |  2 +-
 hw/misc/iosb.c                      |  2 +-
 hw/misc/mac_via.c                   |  8 ++++----
 hw/misc/macio/cuda.c                |  4 ++--
 hw/misc/macio/pmu.c                 |  4 ++--
 hw/misc/mos6522.c                   |  2 +-
 hw/misc/npcm7xx_mft.c               |  2 +-
 hw/misc/npcm7xx_pwm.c               |  2 +-
 hw/misc/stm32l4x5_exti.c            |  2 +-
 hw/misc/stm32l4x5_rcc.c             | 10 +++++-----
 hw/misc/stm32l4x5_syscfg.c          |  2 +-
 hw/misc/xlnx-versal-cframe-reg.c    |  2 +-
 hw/misc/xlnx-versal-crl.c           |  2 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c  |  2 +-
 hw/misc/xlnx-versal-trng.c          |  2 +-
 hw/misc/xlnx-versal-xramc.c         |  2 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c      |  2 +-
 hw/misc/xlnx-zynqmp-crf.c           |  2 +-
 hw/misc/zynq_slcr.c                 |  4 ++--
 hw/net/can/xlnx-zynqmp-can.c        |  2 +-
 hw/net/e1000.c                      |  2 +-
 hw/net/e1000e.c                     |  2 +-
 hw/net/igb.c                        |  2 +-
 hw/net/igbvf.c                      |  2 +-
 hw/nvram/xlnx-bbram.c               |  2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c   |  2 +-
 hw/nvram/xlnx-zynqmp-efuse.c        |  2 +-
 hw/pci-bridge/cxl_root_port.c       |  4 ++--
 hw/pci-bridge/pcie_root_port.c      |  2 +-
 hw/pci-host/bonito.c                |  2 +-
 hw/pci-host/pnv_phb.c               |  4 ++--
 hw/pci-host/pnv_phb3_msi.c          |  4 ++--
 hw/pci/pci.c                        |  4 ++--
 hw/rtc/mc146818rtc.c                |  2 +-
 hw/s390x/css-bridge.c               |  2 +-
 hw/sensor/adm1266.c                 |  2 +-
 hw/sensor/adm1272.c                 |  2 +-
 hw/sensor/isl_pmbus_vr.c            | 10 +++++-----
 hw/sensor/max31785.c                |  2 +-
 hw/sensor/max34451.c                |  2 +-
 hw/ssi/npcm7xx_fiu.c                |  2 +-
 hw/timer/etraxfs_timer.c            |  2 +-
 hw/timer/npcm7xx_timer.c            |  2 +-
 hw/usb/hcd-dwc2.c                   |  8 ++++----
 hw/usb/xlnx-versal-usb2-ctrl-regs.c |  2 +-
 hw/virtio/virtio-pci.c              |  2 +-
 target/arm/cpu.c                    |  4 ++--
 target/avr/cpu.c                    |  4 ++--
 target/cris/cpu.c                   |  4 ++--
 target/hexagon/cpu.c                |  4 ++--
 target/i386/cpu.c                   |  4 ++--
 target/loongarch/cpu.c              |  4 ++--
 target/m68k/cpu.c                   |  4 ++--
 target/microblaze/cpu.c             |  4 ++--
 target/mips/cpu.c                   |  4 ++--
 target/openrisc/cpu.c               |  4 ++--
 target/ppc/cpu_init.c               |  4 ++--
 target/riscv/cpu.c                  |  4 ++--
 target/rx/cpu.c                     |  4 ++--
 target/sh4/cpu.c                    |  4 ++--
 target/sparc/cpu.c                  |  4 ++--
 target/tricore/cpu.c                |  4 ++--
 target/xtensa/cpu.c                 |  4 ++--
 94 files changed, 150 insertions(+), 150 deletions(-)

diff --git a/include/hw/resettable.h b/include/hw/resettable.h
index bdcd1276b69..3161e471c9b 100644
--- a/include/hw/resettable.h
+++ b/include/hw/resettable.h
@@ -103,8 +103,8 @@ typedef enum ResetType {
  * the callback.
  */
 typedef void (*ResettableEnterPhase)(Object *obj, ResetType type);
-typedef void (*ResettableHoldPhase)(Object *obj);
-typedef void (*ResettableExitPhase)(Object *obj);
+typedef void (*ResettableHoldPhase)(Object *obj, ResetType type);
+typedef void (*ResettableExitPhase)(Object *obj, ResetType type);
 typedef ResettableState * (*ResettableGetState)(Object *obj);
 typedef void (*ResettableTrFunction)(Object *obj);
 typedef ResettableTrFunction (*ResettableGetTrFunction)(Object *obj);
diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index c6647eec6d7..de8469dae4f 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -218,7 +218,7 @@ static void npcm7xx_adc_enter_reset(Object *obj, ResetType type)
     npcm7xx_adc_reset(s);
 }
 
-static void npcm7xx_adc_hold_reset(Object *obj)
+static void npcm7xx_adc_hold_reset(Object *obj, ResetType type)
 {
     NPCM7xxADCState *s = NPCM7XX_ADC(obj);
 
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index f54546cd4df..34c5555dba9 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -272,7 +272,7 @@ static int pxa2xx_pic_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void pxa2xx_pic_reset_hold(Object *obj)
+static void pxa2xx_pic_reset_hold(Object *obj, ResetType type)
 {
     PXA2xxPICState *s = PXA2XX_PIC(obj);
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index c4b540656c1..1ce706bf94b 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -682,7 +682,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void smmu_base_reset_hold(Object *obj)
+static void smmu_base_reset_hold(Object *obj, ResetType type)
 {
     SMMUState *s = ARM_SMMU(obj);
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9eb56a70f39..2d1e0d55ec2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1727,13 +1727,13 @@ static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
     }
 }
 
-static void smmu_reset_hold(Object *obj)
+static void smmu_reset_hold(Object *obj, ResetType type)
 {
     SMMUv3State *s = ARM_SMMUV3(obj);
     SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
 
     if (c->parent_phases.hold) {
-        c->parent_phases.hold(obj);
+        c->parent_phases.hold(obj, type);
     }
 
     smmuv3_init_regs(s);
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index a2f998bf9e2..376746251e6 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -394,7 +394,7 @@ static void stellaris_sys_reset_enter(Object *obj, ResetType type)
     s->dcgc[0] = 1;
 }
 
-static void stellaris_sys_reset_hold(Object *obj)
+static void stellaris_sys_reset_hold(Object *obj, ResetType type)
 {
     ssys_state *s = STELLARIS_SYS(obj);
 
@@ -402,7 +402,7 @@ static void stellaris_sys_reset_hold(Object *obj)
     ssys_calculate_system_clock(s, true);
 }
 
-static void stellaris_sys_reset_exit(Object *obj)
+static void stellaris_sys_reset_exit(Object *obj, ResetType type)
 {
 }
 
@@ -618,7 +618,7 @@ static void stellaris_i2c_reset_enter(Object *obj, ResetType type)
         i2c_end_transfer(s->bus);
 }
 
-static void stellaris_i2c_reset_hold(Object *obj)
+static void stellaris_i2c_reset_hold(Object *obj, ResetType type)
 {
     stellaris_i2c_state *s = STELLARIS_I2C(obj);
 
@@ -631,7 +631,7 @@ static void stellaris_i2c_reset_hold(Object *obj)
     s->mcr = 0;
 }
 
-static void stellaris_i2c_reset_exit(Object *obj)
+static void stellaris_i2c_reset_exit(Object *obj, ResetType type)
 {
     stellaris_i2c_state *s = STELLARIS_I2C(obj);
 
@@ -787,7 +787,7 @@ static void stellaris_adc_trigger(void *opaque, int irq, int level)
     }
 }
 
-static void stellaris_adc_reset_hold(Object *obj)
+static void stellaris_adc_reset_hold(Object *obj, ResetType type)
 {
     StellarisADCState *s = STELLARIS_ADC(obj);
     int n;
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 87b56243262..805416372c2 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -610,7 +610,7 @@ static void asc_fifo_init(ASCFIFOState *fs, int index)
     g_free(name);
 }
 
-static void asc_reset_hold(Object *obj)
+static void asc_reset_hold(Object *obj, ResetType type)
 {
     ASCState *s = ASC(obj);
 
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index db31d7cc859..77d9a2a221f 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -525,7 +525,7 @@ static void cadence_uart_reset_init(Object *obj, ResetType type)
     s->r[R_TTRIG] = 0x00000020;
 }
 
-static void cadence_uart_reset_hold(Object *obj)
+static void cadence_uart_reset_hold(Object *obj, ResetType type)
 {
     CadenceUARTState *s = CADENCE_UART(obj);
 
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index e8716c42523..7fc6787f690 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -214,7 +214,7 @@ static void sifive_uart_reset_enter(Object *obj, ResetType type)
     s->rx_fifo_len = 0;
 }
 
-static void sifive_uart_reset_hold(Object *obj)
+static void sifive_uart_reset_hold(Object *obj, ResetType type)
 {
     SiFiveUARTState *s = SIFIVE_UART(obj);
     qemu_irq_lower(s->irq);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 4bd9c70a83f..a72d48d9e17 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -113,7 +113,7 @@ void cpu_reset(CPUState *cpu)
     trace_cpu_reset(cpu->cpu_index);
 }
 
-static void cpu_common_reset_hold(Object *obj)
+static void cpu_common_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cpu = CPU(obj);
     CPUClass *cc = CPU_GET_CLASS(cpu);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 00efaf1bd10..f3a996f57de 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -760,10 +760,10 @@ static void device_phases_reset(DeviceState *dev)
         rc->phases.enter(OBJECT(dev), RESET_TYPE_COLD);
     }
     if (rc->phases.hold) {
-        rc->phases.hold(OBJECT(dev));
+        rc->phases.hold(OBJECT(dev), RESET_TYPE_COLD);
     }
     if (rc->phases.exit) {
-        rc->phases.exit(OBJECT(dev));
+        rc->phases.exit(OBJECT(dev), RESET_TYPE_COLD);
     }
 }
 
diff --git a/hw/core/reset.c b/hw/core/reset.c
index d50da7e3041..f9fef45e050 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -73,7 +73,7 @@ static ResettableState *legacy_reset_get_state(Object *obj)
     return &lr->reset_state;
 }
 
-static void legacy_reset_hold(Object *obj)
+static void legacy_reset_hold(Object *obj, ResetType type)
 {
     LegacyReset *lr = LEGACY_RESET(obj);
 
diff --git a/hw/core/resettable.c b/hw/core/resettable.c
index c3df75c6ba8..bebf7f10b26 100644
--- a/hw/core/resettable.c
+++ b/hw/core/resettable.c
@@ -181,7 +181,7 @@ static void resettable_phase_hold(Object *obj, void *opaque, ResetType type)
             trace_resettable_transitional_function(obj, obj_typename);
             tr_func(obj);
         } else if (rc->phases.hold) {
-            rc->phases.hold(obj);
+            rc->phases.hold(obj, type);
         }
     }
     trace_resettable_phase_hold_end(obj, obj_typename, s->count);
@@ -204,7 +204,7 @@ static void resettable_phase_exit(Object *obj, void *opaque, ResetType type)
     if (--s->count == 0) {
         trace_resettable_phase_exit_exec(obj, obj_typename, !!rc->phases.exit);
         if (rc->phases.exit && !resettable_get_tr_func(rc, obj)) {
-            rc->phases.exit(obj);
+            rc->phases.exit(obj, type);
         }
     }
     s->exit_phase_in_progress = false;
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 94d3353f540..276f315108b 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -180,14 +180,14 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     }
 }
 
-static void virtio_vga_base_reset_hold(Object *obj)
+static void virtio_vga_base_reset_hold(Object *obj, ResetType type)
 {
     VirtIOVGABaseClass *klass = VIRTIO_VGA_BASE_GET_CLASS(obj);
     VirtIOVGABase *vvga = VIRTIO_VGA_BASE(obj);
 
     /* reset virtio-gpu */
     if (klass->parent_phases.hold) {
-        klass->parent_phases.hold(obj);
+        klass->parent_phases.hold(obj, type);
     }
 
     /* reset vga */
diff --git a/hw/gpio/npcm7xx_gpio.c b/hw/gpio/npcm7xx_gpio.c
index 6e70ac1f24b..ba19b9ebad3 100644
--- a/hw/gpio/npcm7xx_gpio.c
+++ b/hw/gpio/npcm7xx_gpio.c
@@ -352,7 +352,7 @@ static void npcm7xx_gpio_enter_reset(Object *obj, ResetType type)
     s->regs[NPCM7XX_GPIO_ODSC] = s->reset_odsc;
 }
 
-static void npcm7xx_gpio_hold_reset(Object *obj)
+static void npcm7xx_gpio_hold_reset(Object *obj, ResetType type)
 {
     NPCM7xxGPIOState *s = NPCM7XX_GPIO(obj);
 
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 86f23836553..d5838b8e98d 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -484,7 +484,7 @@ static void pl061_enter_reset(Object *obj, ResetType type)
     s->amsel = 0;
 }
 
-static void pl061_hold_reset(Object *obj)
+static void pl061_hold_reset(Object *obj, ResetType type)
 {
     PL061State *s = PL061(obj);
     int i, level;
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index 63b8763e9d3..71bf5fddb2a 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -70,7 +70,7 @@ static bool is_push_pull(Stm32l4x5GpioState *s, unsigned pin)
     return extract32(s->otyper, pin, 1) == 0;
 }
 
-static void stm32l4x5_gpio_reset_hold(Object *obj)
+static void stm32l4x5_gpio_reset_hold(Object *obj, ResetType type)
 {
     Stm32l4x5GpioState *s = STM32L4X5_GPIO(obj);
 
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index f33afeeea27..490d805d298 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2453,7 +2453,7 @@ static void vmbus_unrealize(BusState *bus)
     qemu_mutex_destroy(&vmbus->rx_queue_lock);
 }
 
-static void vmbus_reset_hold(Object *obj)
+static void vmbus_reset_hold(Object *obj, ResetType type)
 {
     vmbus_deinit(VMBUS(obj));
 }
diff --git a/hw/i2c/allwinner-i2c.c b/hw/i2c/allwinner-i2c.c
index 96c20c86372..16f1d6d40e7 100644
--- a/hw/i2c/allwinner-i2c.c
+++ b/hw/i2c/allwinner-i2c.c
@@ -170,7 +170,7 @@ static inline bool allwinner_i2c_interrupt_is_enabled(AWI2CState *s)
     return s->cntr & TWI_CNTR_INT_EN;
 }
 
-static void allwinner_i2c_reset_hold(Object *obj)
+static void allwinner_i2c_reset_hold(Object *obj, ResetType type)
 {
     AWI2CState *s = AW_I2C(obj);
 
diff --git a/hw/i2c/npcm7xx_smbus.c b/hw/i2c/npcm7xx_smbus.c
index 0ea3083bb6e..22d68fc67dd 100644
--- a/hw/i2c/npcm7xx_smbus.c
+++ b/hw/i2c/npcm7xx_smbus.c
@@ -1022,7 +1022,7 @@ static void npcm7xx_smbus_enter_reset(Object *obj, ResetType type)
     s->rx_cur = 0;
 }
 
-static void npcm7xx_smbus_hold_reset(Object *obj)
+static void npcm7xx_smbus_hold_reset(Object *obj, ResetType type)
 {
     NPCM7xxSMBusState *s = NPCM7XX_SMBUS(obj);
 
diff --git a/hw/input/adb.c b/hw/input/adb.c
index 98f39b4281a..aff7130fd0f 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -231,7 +231,7 @@ static const VMStateDescription vmstate_adb_bus = {
     }
 };
 
-static void adb_bus_reset_hold(Object *obj)
+static void adb_bus_reset_hold(Object *obj, ResetType type)
 {
     ADBBusState *adb_bus = ADB_BUS(obj);
 
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 00b695a0b97..d6f834443dd 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1007,7 +1007,7 @@ void ps2_write_mouse(PS2MouseState *s, int val)
     }
 }
 
-static void ps2_reset_hold(Object *obj)
+static void ps2_reset_hold(Object *obj, ResetType type)
 {
     PS2State *s = PS2_DEVICE(obj);
 
@@ -1015,7 +1015,7 @@ static void ps2_reset_hold(Object *obj)
     ps2_reset_queue(s);
 }
 
-static void ps2_reset_exit(Object *obj)
+static void ps2_reset_exit(Object *obj, ResetType type)
 {
     PS2State *s = PS2_DEVICE(obj);
 
@@ -1048,7 +1048,7 @@ static void ps2_common_post_load(PS2State *s)
     q->cwptr = ccount ? (q->rptr + ccount) & (PS2_BUFFER_SIZE - 1) : -1;
 }
 
-static void ps2_kbd_reset_hold(Object *obj)
+static void ps2_kbd_reset_hold(Object *obj, ResetType type)
 {
     PS2DeviceClass *ps2dc = PS2_DEVICE_GET_CLASS(obj);
     PS2KbdState *s = PS2_KBD_DEVICE(obj);
@@ -1056,7 +1056,7 @@ static void ps2_kbd_reset_hold(Object *obj)
     trace_ps2_kbd_reset(s);
 
     if (ps2dc->parent_phases.hold) {
-        ps2dc->parent_phases.hold(obj);
+        ps2dc->parent_phases.hold(obj, type);
     }
 
     s->scan_enabled = 1;
@@ -1065,7 +1065,7 @@ static void ps2_kbd_reset_hold(Object *obj)
     s->modifiers = 0;
 }
 
-static void ps2_mouse_reset_hold(Object *obj)
+static void ps2_mouse_reset_hold(Object *obj, ResetType type)
 {
     PS2DeviceClass *ps2dc = PS2_DEVICE_GET_CLASS(obj);
     PS2MouseState *s = PS2_MOUSE_DEVICE(obj);
@@ -1073,7 +1073,7 @@ static void ps2_mouse_reset_hold(Object *obj)
     trace_ps2_mouse_reset(s);
 
     if (ps2dc->parent_phases.hold) {
-        ps2dc->parent_phases.hold(obj);
+        ps2dc->parent_phases.hold(obj, type);
     }
 
     s->mouse_status = 0;
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 94c173cb071..53fb2c4e2d3 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -263,7 +263,7 @@ static inline void arm_gic_common_reset_irq_state(GICState *s, int cidx,
     }
 }
 
-static void arm_gic_common_reset_hold(Object *obj)
+static void arm_gic_common_reset_hold(Object *obj, ResetType type)
 {
     GICState *s = ARM_GIC_COMMON(obj);
     int i, j;
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index e0d9e512a37..53defee7d59 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -473,13 +473,13 @@ static void kvm_arm_gic_get(GICState *s)
     }
 }
 
-static void kvm_arm_gic_reset_hold(Object *obj)
+static void kvm_arm_gic_reset_hold(Object *obj, ResetType type)
 {
     GICState *s = ARM_GIC_COMMON(obj);
     KVMARMGICClass *kgc = KVM_ARM_GIC_GET_CLASS(s);
 
     if (kgc->parent_phases.hold) {
-        kgc->parent_phases.hold(obj);
+        kgc->parent_phases.hold(obj, type);
     }
 
     if (kvm_arm_gic_can_save_restore(s)) {
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 207f8417e1f..bd50a1b0795 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -495,7 +495,7 @@ static void arm_gicv3_finalize(Object *obj)
     g_free(s->redist_region_count);
 }
 
-static void arm_gicv3_common_reset_hold(Object *obj)
+static void arm_gicv3_common_reset_hold(Object *obj, ResetType type)
 {
     GICv3State *s = ARM_GICV3_COMMON(obj);
     int i;
diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
index 52e9aca9c65..bf31158470e 100644
--- a/hw/intc/arm_gicv3_its.c
+++ b/hw/intc/arm_gicv3_its.c
@@ -1950,13 +1950,13 @@ static void gicv3_arm_its_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void gicv3_its_reset_hold(Object *obj)
+static void gicv3_its_reset_hold(Object *obj, ResetType type)
 {
     GICv3ITSState *s = ARM_GICV3_ITS_COMMON(obj);
     GICv3ITSClass *c = ARM_GICV3_ITS_GET_CLASS(s);
 
     if (c->parent_phases.hold) {
-        c->parent_phases.hold(obj);
+        c->parent_phases.hold(obj, type);
     }
 
     /* Quiescent bit reset to 1 */
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 331d6b93cc1..0b97362cd21 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -123,7 +123,7 @@ void gicv3_its_init_mmio(GICv3ITSState *s, const MemoryRegionOps *ops,
     msi_nonbroken = true;
 }
 
-static void gicv3_its_common_reset_hold(Object *obj)
+static void gicv3_its_common_reset_hold(Object *obj, ResetType type)
 {
     GICv3ITSState *s = ARM_GICV3_ITS_COMMON(obj);
 
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 3befc960db2..35539c099fc 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -197,14 +197,14 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
                       GITS_CTLR, &s->ctlr, true, &error_abort);
 }
 
-static void kvm_arm_its_reset_hold(Object *obj)
+static void kvm_arm_its_reset_hold(Object *obj, ResetType type)
 {
     GICv3ITSState *s = ARM_GICV3_ITS_COMMON(obj);
     KVMARMITSClass *c = KVM_ARM_ITS_GET_CLASS(s);
     int i;
 
     if (c->parent_phases.hold) {
-        c->parent_phases.hold(obj);
+        c->parent_phases.hold(obj, type);
     }
 
     if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 00a383079b9..9ea6b8e2189 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -703,7 +703,7 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
 }
 
-static void kvm_arm_gicv3_reset_hold(Object *obj)
+static void kvm_arm_gicv3_reset_hold(Object *obj, ResetType type)
 {
     GICv3State *s = ARM_GICV3_COMMON(obj);
     KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
@@ -711,7 +711,7 @@ static void kvm_arm_gicv3_reset_hold(Object *obj)
     DPRINTF("Reset\n");
 
     if (kgc->parent_phases.hold) {
-        kgc->parent_phases.hold(obj);
+        kgc->parent_phases.hold(obj, type);
     }
 
     if (s->migration_blocker) {
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 700abfa7a62..9b3b7abaea2 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -579,7 +579,7 @@ static void ics_reset_irq(ICSIRQState *irq)
     irq->saved_priority = 0xff;
 }
 
-static void ics_reset_hold(Object *obj)
+static void ics_reset_hold(Object *obj, ResetType type)
 {
     ICSState *ics = ICS(obj);
     g_autofree uint8_t *flags = g_malloc(ics->nr_irqs);
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index b5a7713863f..e2ae7c32011 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -175,7 +175,7 @@ static void glue_nmi_release(void *opaque)
     GLUE_set_irq(s, GLUE_IRQ_IN_NMI, 0);
 }
 
-static void glue_reset_hold(Object *obj)
+static void glue_reset_hold(Object *obj, ResetType type)
 {
     GLUEState *s = GLUE(obj);
 
diff --git a/hw/misc/djmemc.c b/hw/misc/djmemc.c
index 9b69656c3a8..96d5efb5e3a 100644
--- a/hw/misc/djmemc.c
+++ b/hw/misc/djmemc.c
@@ -96,7 +96,7 @@ static void djmemc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->mem_regs);
 }
 
-static void djmemc_reset_hold(Object *obj)
+static void djmemc_reset_hold(Object *obj, ResetType type)
 {
     DJMEMCState *s = DJMEMC(obj);
 
diff --git a/hw/misc/iosb.c b/hw/misc/iosb.c
index e20305e8013..31927eaedb4 100644
--- a/hw/misc/iosb.c
+++ b/hw/misc/iosb.c
@@ -81,7 +81,7 @@ static const MemoryRegionOps iosb_mmio_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void iosb_reset_hold(Object *obj)
+static void iosb_reset_hold(Object *obj, ResetType type)
 {
     IOSBState *s = IOSB(obj);
 
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index db6142b5f41..652395b84fc 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -1203,7 +1203,7 @@ static int via1_post_load(void *opaque, int version_id)
 }
 
 /* VIA 1 */
-static void mos6522_q800_via1_reset_hold(Object *obj)
+static void mos6522_q800_via1_reset_hold(Object *obj, ResetType type)
 {
     MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(obj);
     MOS6522State *ms = MOS6522(v1s);
@@ -1211,7 +1211,7 @@ static void mos6522_q800_via1_reset_hold(Object *obj)
     ADBBusState *adb_bus = &v1s->adb_bus;
 
     if (mdc->parent_phases.hold) {
-        mdc->parent_phases.hold(obj);
+        mdc->parent_phases.hold(obj, type);
     }
 
     ms->timers[0].frequency = VIA_TIMER_FREQ;
@@ -1359,13 +1359,13 @@ static void mos6522_q800_via2_portB_write(MOS6522State *s)
     }
 }
 
-static void mos6522_q800_via2_reset_hold(Object *obj)
+static void mos6522_q800_via2_reset_hold(Object *obj, ResetType type)
 {
     MOS6522State *ms = MOS6522(obj);
     MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(ms);
 
     if (mdc->parent_phases.hold) {
-        mdc->parent_phases.hold(obj);
+        mdc->parent_phases.hold(obj, type);
     }
 
     ms->timers[0].frequency = VIA_TIMER_FREQ;
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 41934e2cf8e..beab0ffb13f 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -586,13 +586,13 @@ static void mos6522_cuda_portB_write(MOS6522State *s)
     cuda_update(cs);
 }
 
-static void mos6522_cuda_reset_hold(Object *obj)
+static void mos6522_cuda_reset_hold(Object *obj, ResetType type)
 {
     MOS6522State *ms = MOS6522(obj);
     MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(ms);
 
     if (mdc->parent_phases.hold) {
-        mdc->parent_phases.hold(obj);
+        mdc->parent_phases.hold(obj, type);
     }
 
     ms->timers[0].frequency = CUDA_TIMER_FREQ;
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index e40c51bf529..238da58eade 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -792,7 +792,7 @@ static void mos6522_pmu_portB_write(MOS6522State *s)
     pmu_update(ps);
 }
 
-static void mos6522_pmu_reset_hold(Object *obj)
+static void mos6522_pmu_reset_hold(Object *obj, ResetType type)
 {
     MOS6522State *ms = MOS6522(obj);
     MOS6522PMUState *mps = container_of(ms, MOS6522PMUState, parent_obj);
@@ -800,7 +800,7 @@ static void mos6522_pmu_reset_hold(Object *obj)
     MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(ms);
 
     if (mdc->parent_phases.hold) {
-        mdc->parent_phases.hold(obj);
+        mdc->parent_phases.hold(obj, type);
     }
 
     ms->timers[0].frequency = VIA_TIMER_FREQ;
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index e3fe87c20ca..515f62e687d 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -642,7 +642,7 @@ const VMStateDescription vmstate_mos6522 = {
     }
 };
 
-static void mos6522_reset_hold(Object *obj)
+static void mos6522_reset_hold(Object *obj, ResetType type)
 {
     MOS6522State *s = MOS6522(obj);
 
diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index 9a848584e18..9fcc69fe5c5 100644
--- a/hw/misc/npcm7xx_mft.c
+++ b/hw/misc/npcm7xx_mft.c
@@ -467,7 +467,7 @@ static void npcm7xx_mft_enter_reset(Object *obj, ResetType type)
     npcm7xx_mft_reset(s);
 }
 
-static void npcm7xx_mft_hold_reset(Object *obj)
+static void npcm7xx_mft_hold_reset(Object *obj, ResetType type)
 {
     NPCM7xxMFTState *s = NPCM7XX_MFT(obj);
 
diff --git a/hw/misc/npcm7xx_pwm.c b/hw/misc/npcm7xx_pwm.c
index fca2dd2e5af..f7f77e30a22 100644
--- a/hw/misc/npcm7xx_pwm.c
+++ b/hw/misc/npcm7xx_pwm.c
@@ -468,7 +468,7 @@ static void npcm7xx_pwm_enter_reset(Object *obj, ResetType type)
     s->piir = 0x00000000;
 }
 
-static void npcm7xx_pwm_hold_reset(Object *obj)
+static void npcm7xx_pwm_hold_reset(Object *obj, ResetType type)
 {
     NPCM7xxPWMState *s = NPCM7XX_PWM(obj);
     int i;
diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index 9fd859160d4..a090dbd366f 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -77,7 +77,7 @@ static unsigned configurable_mask(unsigned bank)
      return valid_mask(bank) & ~exti_romask[bank];
 }
 
-static void stm32l4x5_exti_reset_hold(Object *obj)
+static void stm32l4x5_exti_reset_hold(Object *obj, ResetType type)
 {
     Stm32l4x5ExtiState *s = STM32L4X5_EXTI(obj);
 
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index ed2dbd9dc3f..417bd5e85f6 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -113,13 +113,13 @@ static void clock_mux_reset_enter(Object *obj, ResetType type)
     set_clock_mux_init_info(s, s->id);
 }
 
-static void clock_mux_reset_hold(Object *obj)
+static void clock_mux_reset_hold(Object *obj, ResetType type)
 {
     RccClockMuxState *s = RCC_CLOCK_MUX(obj);
     clock_mux_update(s, true);
 }
 
-static void clock_mux_reset_exit(Object *obj)
+static void clock_mux_reset_exit(Object *obj, ResetType type)
 {
     RccClockMuxState *s = RCC_CLOCK_MUX(obj);
     clock_mux_update(s, false);
@@ -263,13 +263,13 @@ static void pll_reset_enter(Object *obj, ResetType type)
     set_pll_init_info(s, s->id);
 }
 
-static void pll_reset_hold(Object *obj)
+static void pll_reset_hold(Object *obj, ResetType type)
 {
     RccPllState *s = RCC_PLL(obj);
     pll_update(s, true);
 }
 
-static void pll_reset_exit(Object *obj)
+static void pll_reset_exit(Object *obj, ResetType type)
 {
     RccPllState *s = RCC_PLL(obj);
     pll_update(s, false);
@@ -907,7 +907,7 @@ static void rcc_update_csr(Stm32l4x5RccState *s)
     rcc_update_irq(s);
 }
 
-static void stm32l4x5_rcc_reset_hold(Object *obj)
+static void stm32l4x5_rcc_reset_hold(Object *obj, ResetType type)
 {
     Stm32l4x5RccState *s = STM32L4X5_RCC(obj);
     s->cr = 0x00000063;
diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
index 3dafc00b49d..a5a1ce26804 100644
--- a/hw/misc/stm32l4x5_syscfg.c
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -65,7 +65,7 @@
 
 #define NUM_LINES_PER_EXTICR_REG 4
 
-static void stm32l4x5_syscfg_hold_reset(Object *obj)
+static void stm32l4x5_syscfg_hold_reset(Object *obj, ResetType type)
 {
     Stm32l4x5SyscfgState *s = STM32L4X5_SYSCFG(obj);
 
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index a6ab287b019..3fc838bd54b 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -542,7 +542,7 @@ static void cframe_reg_reset_enter(Object *obj, ResetType type)
     }
 }
 
-static void cframe_reg_reset_hold(Object *obj)
+static void cframe_reg_reset_hold(Object *obj, ResetType type)
 {
     XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
 
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 1f1762ef163..f143900d5b4 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -311,7 +311,7 @@ static void crl_reset_enter(Object *obj, ResetType type)
     }
 }
 
-static void crl_reset_hold(Object *obj)
+static void crl_reset_hold(Object *obj, ResetType type)
 {
     XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
 
diff --git a/hw/misc/xlnx-versal-pmc-iou-slcr.c b/hw/misc/xlnx-versal-pmc-iou-slcr.c
index 60e13a78ab8..e469c04d763 100644
--- a/hw/misc/xlnx-versal-pmc-iou-slcr.c
+++ b/hw/misc/xlnx-versal-pmc-iou-slcr.c
@@ -1350,7 +1350,7 @@ static void xlnx_versal_pmc_iou_slcr_reset_init(Object *obj, ResetType type)
     }
 }
 
-static void xlnx_versal_pmc_iou_slcr_reset_hold(Object *obj)
+static void xlnx_versal_pmc_iou_slcr_reset_hold(Object *obj, ResetType type)
 {
     XlnxVersalPmcIouSlcr *s = XILINX_VERSAL_PMC_IOU_SLCR(obj);
 
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 6495188dc74..51eb7600414 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -632,7 +632,7 @@ static void trng_unrealize(DeviceState *dev)
     s->prng = NULL;
 }
 
-static void trng_reset_hold(Object *obj)
+static void trng_reset_hold(Object *obj, ResetType type)
 {
     trng_reset(XLNX_VERSAL_TRNG(obj));
 }
diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
index a5f78c190eb..ad839ce7e9f 100644
--- a/hw/misc/xlnx-versal-xramc.c
+++ b/hw/misc/xlnx-versal-xramc.c
@@ -137,7 +137,7 @@ static void xram_ctrl_reset_enter(Object *obj, ResetType type)
     ARRAY_FIELD_DP32(s->regs, XRAM_IMP, SIZE, s->cfg.encoded_size);
 }
 
-static void xram_ctrl_reset_hold(Object *obj)
+static void xram_ctrl_reset_hold(Object *obj, ResetType type)
 {
     XlnxXramCtrl *s = XLNX_XRAM_CTRL(obj);
 
diff --git a/hw/misc/xlnx-zynqmp-apu-ctrl.c b/hw/misc/xlnx-zynqmp-apu-ctrl.c
index 1d441b41dfe..87e4a140679 100644
--- a/hw/misc/xlnx-zynqmp-apu-ctrl.c
+++ b/hw/misc/xlnx-zynqmp-apu-ctrl.c
@@ -150,7 +150,7 @@ static void zynqmp_apu_reset_enter(Object *obj, ResetType type)
     s->cpu_in_wfi = 0;
 }
 
-static void zynqmp_apu_reset_hold(Object *obj)
+static void zynqmp_apu_reset_hold(Object *obj, ResetType type)
 {
     XlnxZynqMPAPUCtrl *s = XLNX_ZYNQMP_APU_CTRL(obj);
 
diff --git a/hw/misc/xlnx-zynqmp-crf.c b/hw/misc/xlnx-zynqmp-crf.c
index a83efb44e31..e5aba56f691 100644
--- a/hw/misc/xlnx-zynqmp-crf.c
+++ b/hw/misc/xlnx-zynqmp-crf.c
@@ -191,7 +191,7 @@ static void crf_reset_enter(Object *obj, ResetType type)
     }
 }
 
-static void crf_reset_hold(Object *obj)
+static void crf_reset_hold(Object *obj, ResetType type)
 {
     XlnxZynqMPCRF *s = XLNX_ZYNQMP_CRF(obj);
     ir_update_irq(s);
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index d2ac2e77f26..3412ff099ea 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -416,7 +416,7 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
     s->regs[R_DDRIOB + 12] = 0x00000021;
 }
 
-static void zynq_slcr_reset_hold(Object *obj)
+static void zynq_slcr_reset_hold(Object *obj, ResetType type)
 {
     ZynqSLCRState *s = ZYNQ_SLCR(obj);
 
@@ -425,7 +425,7 @@ static void zynq_slcr_reset_hold(Object *obj)
     zynq_slcr_propagate_clocks(s);
 }
 
-static void zynq_slcr_reset_exit(Object *obj)
+static void zynq_slcr_reset_exit(Object *obj, ResetType type)
 {
     ZynqSLCRState *s = ZYNQ_SLCR(obj);
 
diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index ca0ce4e8bbf..58f1432bb35 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -1006,7 +1006,7 @@ static void xlnx_zynqmp_can_reset_init(Object *obj, ResetType type)
     ptimer_transaction_commit(s->can_timer);
 }
 
-static void xlnx_zynqmp_can_reset_hold(Object *obj)
+static void xlnx_zynqmp_can_reset_hold(Object *obj, ResetType type)
 {
     XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(obj);
     unsigned int i;
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 43f3a4a7011..5012b964640 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -373,7 +373,7 @@ static bool e1000_vet_init_need(void *opaque)
     return chkflag(VET);
 }
 
-static void e1000_reset_hold(Object *obj)
+static void e1000_reset_hold(Object *obj, ResetType type)
 {
     E1000State *d = E1000(obj);
     E1000BaseClass *edc = E1000_GET_CLASS(d);
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 7c6f6029518..edc101eaf68 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -513,7 +513,7 @@ static void e1000e_pci_uninit(PCIDevice *pci_dev)
     msi_uninit(pci_dev);
 }
 
-static void e1000e_qdev_reset_hold(Object *obj)
+static void e1000e_qdev_reset_hold(Object *obj, ResetType type)
 {
     E1000EState *s = E1000E(obj);
 
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 9b37523d6df..1ef6170465f 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -486,7 +486,7 @@ static void igb_pci_uninit(PCIDevice *pci_dev)
     msi_uninit(pci_dev);
 }
 
-static void igb_qdev_reset_hold(Object *obj)
+static void igb_qdev_reset_hold(Object *obj, ResetType type)
 {
     IGBState *s = IGB(obj);
 
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 94a4e885f20..21a97d4d61d 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -282,7 +282,7 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
     pcie_ari_init(dev, 0x150);
 }
 
-static void igbvf_qdev_reset_hold(Object *obj)
+static void igbvf_qdev_reset_hold(Object *obj, ResetType type)
 {
     PCIDevice *vf = PCI_DEVICE(obj);
 
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 0a71a005c69..09575a77d77 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -417,7 +417,7 @@ static RegisterAccessInfo bbram_ctrl_regs_info[] = {
     }
 };
 
-static void bbram_ctrl_reset_hold(Object *obj)
+static void bbram_ctrl_reset_hold(Object *obj, ResetType type)
 {
     XlnxBBRam *s = XLNX_BBRAM(obj);
     unsigned int i;
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index e4b9e11a3dd..def6fe3302b 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -658,7 +658,7 @@ static void efuse_ctrl_register_reset(RegisterInfo *reg)
     register_reset(reg);
 }
 
-static void efuse_ctrl_reset_hold(Object *obj)
+static void efuse_ctrl_reset_hold(Object *obj, ResetType type)
 {
     XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
     unsigned int i;
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index ec98456e5d1..2d465f0fc6a 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -770,7 +770,7 @@ static void zynqmp_efuse_register_reset(RegisterInfo *reg)
     register_reset(reg);
 }
 
-static void zynqmp_efuse_reset_hold(Object *obj)
+static void zynqmp_efuse_reset_hold(Object *obj, ResetType type)
 {
     XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(obj);
     unsigned int i;
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 8a30da602cc..2dd10239bd2 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -186,13 +186,13 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
                      component_bar);
 }
 
-static void cxl_rp_reset_hold(Object *obj)
+static void cxl_rp_reset_hold(Object *obj, ResetType type)
 {
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(obj);
     CXLRootPort *crp = CXL_ROOT_PORT(obj);
 
     if (rpc->parent_phases.hold) {
-        rpc->parent_phases.hold(obj);
+        rpc->parent_phases.hold(obj, type);
     }
 
     latch_registers(crp);
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index efd96bf1741..09a34786bc6 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -43,7 +43,7 @@ static void rp_write_config(PCIDevice *d, uint32_t address,
     pcie_aer_root_write_config(d, address, val, len, root_cmd);
 }
 
-static void rp_reset_hold(Object *obj)
+static void rp_reset_hold(Object *obj, ResetType type)
 {
     PCIDevice *d = PCI_DEVICE(obj);
     DeviceState *qdev = DEVICE(obj);
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 1f0c4353484..1516d0074dd 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -590,7 +590,7 @@ static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
     }
 }
 
-static void bonito_reset_hold(Object *obj)
+static void bonito_reset_hold(Object *obj, ResetType type)
 {
     PCIBonitoState *s = PCI_BONITO(obj);
     uint32_t val = 0;
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 157c00782ce..d4c118d4436 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -208,7 +208,7 @@ static void pnv_phb_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = true;
 }
 
-static void pnv_phb_root_port_reset_hold(Object *obj)
+static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
 {
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(obj);
     PnvPHBRootPort *phb_rp = PNV_PHB_ROOT_PORT(obj);
@@ -216,7 +216,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj)
     uint8_t *conf = d->config;
 
     if (rpc->parent_phases.hold) {
-        rpc->parent_phases.hold(obj);
+        rpc->parent_phases.hold(obj, type);
     }
 
     if (phb_rp->version == 3) {
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index dc8d8637f26..a6d827f903f 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -228,13 +228,13 @@ static void phb3_msi_resend(ICSState *ics)
     }
 }
 
-static void phb3_msi_reset_hold(Object *obj)
+static void phb3_msi_reset_hold(Object *obj, ResetType type)
 {
     Phb3MsiState *msi = PHB3_MSI(obj);
     ICSStateClass *icsc = ICS_GET_CLASS(obj);
 
     if (icsc->parent_phases.hold) {
-        icsc->parent_phases.hold(obj);
+        icsc->parent_phases.hold(obj, type);
     }
 
     memset(msi->rba, 0, sizeof(msi->rba));
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e7a39cb203a..324c1302d25 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -64,7 +64,7 @@ bool pci_available = true;
 
 static char *pcibus_get_dev_path(DeviceState *dev);
 static char *pcibus_get_fw_dev_path(DeviceState *dev);
-static void pcibus_reset_hold(Object *obj);
+static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
 static Property pci_props[] = {
@@ -427,7 +427,7 @@ void pci_device_reset(PCIDevice *dev)
  * Called via bus_cold_reset on RST# assert, after the devices
  * have been reset device_cold_reset-ed already.
  */
-static void pcibus_reset_hold(Object *obj)
+static void pcibus_reset_hold(Object *obj, ResetType type)
 {
     PCIBus *bus = PCI_BUS(obj);
     int i;
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index f4c18692325..3379f92748b 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -998,7 +998,7 @@ static void rtc_reset_enter(Object *obj, ResetType type)
     }
 }
 
-static void rtc_reset_hold(Object *obj)
+static void rtc_reset_hold(Object *obj, ResetType type)
 {
     MC146818RtcState *s = MC146818_RTC(obj);
 
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 34639f21435..8657ff7bf48 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -56,7 +56,7 @@ static void ccw_device_unplug(HotplugHandler *hotplug_dev,
     qdev_unrealize(dev);
 }
 
-static void virtual_css_bus_reset_hold(Object *obj)
+static void virtual_css_bus_reset_hold(Object *obj, ResetType type)
 {
     /* This should actually be modelled via the generic css */
     css_reset();
diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 5454b73a639..25b87a72961 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -76,7 +76,7 @@ static const uint8_t adm1266_ic_device_id[] = {0x03, 0x41, 0x12, 0x66};
 static const uint8_t adm1266_ic_device_rev[] = {0x08, 0x01, 0x08, 0x07, 0x0,
                                                 0x0, 0x07, 0x41, 0x30};
 
-static void adm1266_exit_reset(Object *obj)
+static void adm1266_exit_reset(Object *obj, ResetType type)
 {
     ADM1266State *s = ADM1266(obj);
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
diff --git a/hw/sensor/adm1272.c b/hw/sensor/adm1272.c
index a19557ec9ea..3fc1e5d0ad9 100644
--- a/hw/sensor/adm1272.c
+++ b/hw/sensor/adm1272.c
@@ -185,7 +185,7 @@ static uint32_t adm1272_direct_to_watts(uint16_t value)
     return pmbus_direct_mode2data(c, value);
 }
 
-static void adm1272_exit_reset(Object *obj)
+static void adm1272_exit_reset(Object *obj, ResetType type)
 {
     ADM1272State *s = ADM1272(obj);
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index e51269f6b83..304a66ea8b0 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -63,7 +63,7 @@ static void isl_pmbus_vr_set(Object *obj, Visitor *v, const char *name,
     pmbus_check_limits(pmdev);
 }
 
-static void isl_pmbus_vr_exit_reset(Object *obj)
+static void isl_pmbus_vr_exit_reset(Object *obj, ResetType type)
 {
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
 
@@ -102,11 +102,11 @@ static void isl_pmbus_vr_exit_reset(Object *obj)
 }
 
 /* The raa228000 uses different direct mode coefficients from most isl devices */
-static void raa228000_exit_reset(Object *obj)
+static void raa228000_exit_reset(Object *obj, ResetType type)
 {
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
 
-    isl_pmbus_vr_exit_reset(obj);
+    isl_pmbus_vr_exit_reset(obj, type);
 
     pmdev->pages[0].read_iout = 0;
     pmdev->pages[0].read_pout = 0;
@@ -119,13 +119,13 @@ static void raa228000_exit_reset(Object *obj)
     pmdev->pages[0].read_temperature_3 = 0;
 }
 
-static void isl69259_exit_reset(Object *obj)
+static void isl69259_exit_reset(Object *obj, ResetType type)
 {
     ISLState *s = ISL69260(obj);
     static const uint8_t ic_device_id[] = {0x04, 0x00, 0x81, 0xD2, 0x49, 0x3c};
     g_assert(sizeof(ic_device_id) <= sizeof(s->ic_device_id));
 
-    isl_pmbus_vr_exit_reset(obj);
+    isl_pmbus_vr_exit_reset(obj, type);
 
     s->ic_device_id_len = sizeof(ic_device_id);
     memcpy(s->ic_device_id, ic_device_id, sizeof(ic_device_id));
diff --git a/hw/sensor/max31785.c b/hw/sensor/max31785.c
index 916ed4d457b..3577a7c2180 100644
--- a/hw/sensor/max31785.c
+++ b/hw/sensor/max31785.c
@@ -444,7 +444,7 @@ static int max31785_write_data(PMBusDevice *pmdev, const uint8_t *buf,
     return 0;
 }
 
-static void max31785_exit_reset(Object *obj)
+static void max31785_exit_reset(Object *obj, ResetType type)
 {
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
     MAX31785State *s = MAX31785(obj);
diff --git a/hw/sensor/max34451.c b/hw/sensor/max34451.c
index 031ae53f594..93b53f3db2f 100644
--- a/hw/sensor/max34451.c
+++ b/hw/sensor/max34451.c
@@ -608,7 +608,7 @@ static inline void *memset_word(void *s, uint16_t c, size_t n)
     return s;
 }
 
-static void max34451_exit_reset(Object *obj)
+static void max34451_exit_reset(Object *obj, ResetType type)
 {
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
     MAX34451State *s = MAX34451(obj);
diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 81dd972ee8c..119c38c4156 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -483,7 +483,7 @@ static void npcm7xx_fiu_enter_reset(Object *obj, ResetType type)
     s->regs[NPCM7XX_FIU_CFG] = 0x0000000b;
 }
 
-static void npcm7xx_fiu_hold_reset(Object *obj)
+static void npcm7xx_fiu_hold_reset(Object *obj, ResetType type)
 {
     NPCM7xxFIUState *s = NPCM7XX_FIU(obj);
     int i;
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index da7c946af52..dd6d96b0a10 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -357,7 +357,7 @@ static void etraxfs_timer_reset_enter(Object *obj, ResetType type)
     t->rw_intr_mask = 0;
 }
 
-static void etraxfs_timer_reset_hold(Object *obj)
+static void etraxfs_timer_reset_hold(Object *obj, ResetType type)
 {
     ETRAXTimerState *t = ETRAX_TIMER(obj);
 
diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index 779c6049fab..c55ba022353 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -592,7 +592,7 @@ static void npcm7xx_watchdog_timer_expired(void *opaque)
     }
 }
 
-static void npcm7xx_timer_hold_reset(Object *obj)
+static void npcm7xx_timer_hold_reset(Object *obj, ResetType type)
 {
     NPCM7xxTimerCtrlState *s = NPCM7XX_TIMER(obj);
     int i;
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 222eef82a55..8cac9c0a062 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -1305,7 +1305,7 @@ static void dwc2_reset_enter(Object *obj, ResetType type)
     }
 }
 
-static void dwc2_reset_hold(Object *obj)
+static void dwc2_reset_hold(Object *obj, ResetType type)
 {
     DWC2Class *c = DWC2_USB_GET_CLASS(obj);
     DWC2State *s = DWC2_USB(obj);
@@ -1313,13 +1313,13 @@ static void dwc2_reset_hold(Object *obj)
     trace_usb_dwc2_reset_hold();
 
     if (c->parent_phases.hold) {
-        c->parent_phases.hold(obj);
+        c->parent_phases.hold(obj, type);
     }
 
     dwc2_update_irq(s);
 }
 
-static void dwc2_reset_exit(Object *obj)
+static void dwc2_reset_exit(Object *obj, ResetType type)
 {
     DWC2Class *c = DWC2_USB_GET_CLASS(obj);
     DWC2State *s = DWC2_USB(obj);
@@ -1327,7 +1327,7 @@ static void dwc2_reset_exit(Object *obj)
     trace_usb_dwc2_reset_exit();
 
     if (c->parent_phases.exit) {
-        c->parent_phases.exit(obj);
+        c->parent_phases.exit(obj, type);
     }
 
     s->hprt0 = HPRT0_PWR;
diff --git a/hw/usb/xlnx-versal-usb2-ctrl-regs.c b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
index 6fc453817ea..66c793a6021 100644
--- a/hw/usb/xlnx-versal-usb2-ctrl-regs.c
+++ b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
@@ -153,7 +153,7 @@ static void usb2_ctrl_regs_reset_init(Object *obj, ResetType type)
     }
 }
 
-static void usb2_ctrl_regs_reset_hold(Object *obj)
+static void usb2_ctrl_regs_reset_hold(Object *obj, ResetType type)
 {
     VersalUsb2CtrlRegs *s = XILINX_VERSAL_USB2_CTRL_REGS(obj);
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cb159fd0785..b1d02f4b3de 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2292,7 +2292,7 @@ static void virtio_pci_reset(DeviceState *qdev)
     }
 }
 
-static void virtio_pci_bus_reset_hold(Object *obj)
+static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
 {
     PCIDevice *dev = PCI_DEVICE(obj);
     DeviceState *qdev = DEVICE(obj);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d2dfd36fd45..a152def2413 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -220,7 +220,7 @@ static void cp_reg_check_reset(gpointer key, gpointer value,  gpointer opaque)
     assert(oldvalue == newvalue);
 }
 
-static void arm_cpu_reset_hold(Object *obj)
+static void arm_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     ARMCPU *cpu = ARM_CPU(cs);
@@ -228,7 +228,7 @@ static void arm_cpu_reset_hold(Object *obj)
     CPUARMState *env = &cpu->env;
 
     if (acc->parent_phases.hold) {
-        acc->parent_phases.hold(obj);
+        acc->parent_phases.hold(obj, type);
     }
 
     memset(env, 0, offsetof(CPUARMState, end_reset_fields));
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 45ee1b5f89e..71ce62a4c25 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -66,7 +66,7 @@ static void avr_restore_state_to_opc(CPUState *cs,
     cpu_env(cs)->pc_w = data[0];
 }
 
-static void avr_cpu_reset_hold(Object *obj)
+static void avr_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     AVRCPU *cpu = AVR_CPU(cs);
@@ -74,7 +74,7 @@ static void avr_cpu_reset_hold(Object *obj)
     CPUAVRState *env = &cpu->env;
 
     if (mcc->parent_phases.hold) {
-        mcc->parent_phases.hold(obj);
+        mcc->parent_phases.hold(obj, type);
     }
 
     env->pc_w = 0;
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index eb4bddcb7e7..535ec39c730 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -61,7 +61,7 @@ static int cris_cpu_mmu_index(CPUState *cs, bool ifetch)
     return !!(cpu_env(cs)->pregs[PR_CCS] & U_FLAG);
 }
 
-static void cris_cpu_reset_hold(Object *obj)
+static void cris_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(obj);
@@ -69,7 +69,7 @@ static void cris_cpu_reset_hold(Object *obj)
     uint32_t vr;
 
     if (ccc->parent_phases.hold) {
-        ccc->parent_phases.hold(obj);
+        ccc->parent_phases.hold(obj, type);
     }
 
     vr = env->pregs[PR_VR];
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 3a716b9be3c..a56bb4b075c 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -273,14 +273,14 @@ static void hexagon_restore_state_to_opc(CPUState *cs,
     cpu_env(cs)->gpr[HEX_REG_PC] = data[0];
 }
 
-static void hexagon_cpu_reset_hold(Object *obj)
+static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(obj);
     CPUHexagonState *env = cpu_env(cs);
 
     if (mcc->parent_phases.hold) {
-        mcc->parent_phases.hold(obj);
+        mcc->parent_phases.hold(obj, type);
     }
 
     set_default_nan_mode(1, &env->fp_status);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fd6af0d7632..fa1ea3735d2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6830,7 +6830,7 @@ static void x86_cpu_set_sgxlepubkeyhash(CPUX86State *env)
 #endif
 }
 
-static void x86_cpu_reset_hold(Object *obj)
+static void x86_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     X86CPU *cpu = X86_CPU(cs);
@@ -6841,7 +6841,7 @@ static void x86_cpu_reset_hold(Object *obj)
     int i;
 
     if (xcc->parent_phases.hold) {
-        xcc->parent_phases.hold(obj);
+        xcc->parent_phases.hold(obj, type);
     }
 
     memset(env, 0, offsetof(CPUX86State, end_reset_fields));
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 203a349055c..bac84dca7af 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -495,14 +495,14 @@ static void loongarch_max_initfn(Object *obj)
     loongarch_la464_initfn(obj);
 }
 
-static void loongarch_cpu_reset_hold(Object *obj)
+static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
     CPULoongArchState *env = cpu_env(cs);
 
     if (lacc->parent_phases.hold) {
-        lacc->parent_phases.hold(obj);
+        lacc->parent_phases.hold(obj, type);
     }
 
     env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index df49ff1880c..efd6bbded86 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -71,7 +71,7 @@ static void m68k_unset_feature(CPUM68KState *env, int feature)
     env->features &= ~BIT_ULL(feature);
 }
 
-static void m68k_cpu_reset_hold(Object *obj)
+static void m68k_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(obj);
@@ -80,7 +80,7 @@ static void m68k_cpu_reset_hold(Object *obj)
     int i;
 
     if (mcc->parent_phases.hold) {
-        mcc->parent_phases.hold(obj);
+        mcc->parent_phases.hold(obj, type);
     }
 
     memset(env, 0, offsetof(CPUM68KState, end_reset_fields));
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 96c2b71f7f7..f8dc3173fc0 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -181,7 +181,7 @@ static void microblaze_cpu_set_irq(void *opaque, int irq, int level)
 }
 #endif
 
-static void mb_cpu_reset_hold(Object *obj)
+static void mb_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
@@ -189,7 +189,7 @@ static void mb_cpu_reset_hold(Object *obj)
     CPUMBState *env = &cpu->env;
 
     if (mcc->parent_phases.hold) {
-        mcc->parent_phases.hold(obj);
+        mcc->parent_phases.hold(obj, type);
     }
 
     memset(env, 0, offsetof(CPUMBState, end_reset_fields));
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 8d8f690a535..bbe01d07dd8 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -185,7 +185,7 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
 
 #include "cpu-defs.c.inc"
 
-static void mips_cpu_reset_hold(Object *obj)
+static void mips_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     MIPSCPU *cpu = MIPS_CPU(cs);
@@ -193,7 +193,7 @@ static void mips_cpu_reset_hold(Object *obj)
     CPUMIPSState *env = &cpu->env;
 
     if (mcc->parent_phases.hold) {
-        mcc->parent_phases.hold(obj);
+        mcc->parent_phases.hold(obj, type);
     }
 
     memset(env, 0, offsetof(CPUMIPSState, end_reset_fields));
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 33c45dbf04e..d711035cf59 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -85,14 +85,14 @@ static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
     info->print_insn = print_insn_or1k;
 }
 
-static void openrisc_cpu_reset_hold(Object *obj)
+static void openrisc_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(obj);
 
     if (occ->parent_phases.hold) {
-        occ->parent_phases.hold(obj);
+        occ->parent_phases.hold(obj, type);
     }
 
     memset(&cpu->env, 0, offsetof(CPUOpenRISCState, end_reset_fields));
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 6241de62ce8..6d82f24c875 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7136,7 +7136,7 @@ static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
     return ppc_env_mmu_index(cpu_env(cs), ifetch);
 }
 
-static void ppc_cpu_reset_hold(Object *obj)
+static void ppc_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
@@ -7146,7 +7146,7 @@ static void ppc_cpu_reset_hold(Object *obj)
     int i;
 
     if (pcc->parent_phases.hold) {
-        pcc->parent_phases.hold(obj);
+        pcc->parent_phases.hold(obj, type);
     }
 
     msr = (target_ulong)0;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 36e3e5fdaf5..eb1a2e7d6d9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -918,7 +918,7 @@ static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
     return riscv_env_mmu_index(cpu_env(cs), ifetch);
 }
 
-static void riscv_cpu_reset_hold(Object *obj)
+static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 {
 #ifndef CONFIG_USER_ONLY
     uint8_t iprio;
@@ -930,7 +930,7 @@ static void riscv_cpu_reset_hold(Object *obj)
     CPURISCVState *env = &cpu->env;
 
     if (mcc->parent_phases.hold) {
-        mcc->parent_phases.hold(obj);
+        mcc->parent_phases.hold(obj, type);
     }
 #ifndef CONFIG_USER_ONLY
     env->misa_mxl = mcc->misa_mxl_max;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index da673a595d4..e3dfb097225 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -69,7 +69,7 @@ static int riscv_cpu_mmu_index(CPUState *cs, bool ifunc)
     return 0;
 }
 
-static void rx_cpu_reset_hold(Object *obj)
+static void rx_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     RXCPUClass *rcc = RX_CPU_GET_CLASS(obj);
@@ -77,7 +77,7 @@ static void rx_cpu_reset_hold(Object *obj)
     uint32_t *resetvec;
 
     if (rcc->parent_phases.hold) {
-        rcc->parent_phases.hold(obj);
+        rcc->parent_phases.hold(obj, type);
     }
 
     memset(env, 0, offsetof(CPURXState, end_reset_fields));
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 4f5a4a3d985..43e35ec2ca7 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -103,14 +103,14 @@ static int sh4_cpu_mmu_index(CPUState *cs, bool ifetch)
     }
 }
 
-static void superh_cpu_reset_hold(Object *obj)
+static void superh_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(obj);
     CPUSH4State *env = cpu_env(cs);
 
     if (scc->parent_phases.hold) {
-        scc->parent_phases.hold(obj);
+        scc->parent_phases.hold(obj, type);
     }
 
     memset(env, 0, offsetof(CPUSH4State, end_reset_fields));
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e820f50acf6..485d416925b 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -29,14 +29,14 @@
 
 //#define DEBUG_FEATURES
 
-static void sparc_cpu_reset_hold(Object *obj)
+static void sparc_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(obj);
     CPUSPARCState *env = cpu_env(cs);
 
     if (scc->parent_phases.hold) {
-        scc->parent_phases.hold(obj);
+        scc->parent_phases.hold(obj, type);
     }
 
     memset(env, 0, offsetof(CPUSPARCState, end_reset_fields));
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index a9af73aeb58..8f9b72c3a04 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -58,13 +58,13 @@ static void tricore_restore_state_to_opc(CPUState *cs,
     cpu_env(cs)->PC = data[0];
 }
 
-static void tricore_cpu_reset_hold(Object *obj)
+static void tricore_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(obj);
 
     if (tcc->parent_phases.hold) {
-        tcc->parent_phases.hold(obj);
+        tcc->parent_phases.hold(obj, type);
     }
 
     cpu_state_reset(cpu_env(cs));
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 875cf843c93..de907cfeb1b 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -93,7 +93,7 @@ bool xtensa_abi_call0(void)
 }
 #endif
 
-static void xtensa_cpu_reset_hold(Object *obj)
+static void xtensa_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(obj);
@@ -102,7 +102,7 @@ static void xtensa_cpu_reset_hold(Object *obj)
                                       XTENSA_OPTION_DFP_COPROCESSOR);
 
     if (xcc->parent_phases.hold) {
-        xcc->parent_phases.hold(obj);
+        xcc->parent_phases.hold(obj, type);
     }
 
     env->pc = env->config->exception_vector[EXC_RESET0 + env->static_vectors];
-- 
2.34.1


