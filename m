Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC304C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWM-0001xP-Db; Thu, 25 Apr 2024 06:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWK-0001wu-Vy
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:05 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWI-0006xJ-By
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:04 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51b526f0fc4so961495e87.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041600; x=1714646400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TC2bP0/6Mi0Irx1gaZY1ePjw6SgQQnFAjnZrvi/Kncc=;
 b=qAB1ssif5nk5VlZUz2ouokF8/05l1k55J0WIozUi6HJkEWRX7bszktiZ8viluYsVv1
 MLWUrYGV+BNwZl7EdxYEx/sKVkGRrYqHvoVjRNBhMUPZCtB5Df6FHM6AvfGhM5uSTbsQ
 gg3vEkzOltYPok8nI7w5x51Jyt0bPmOAB1B9pGtGVm+qLO5uUYNGj3OU/p4EgpF6T8UA
 kzB4DLf7aQog/Iimk5DlodbZJrsX1iBz96D7X1kfdacMI2QNHvHtIDpwGIa4zzaCVMTp
 Af3RtODUcNWRP/fAdF981VQXuRBvzCvpiojUUhX+6/eTEm8A/nsVn43nyGwDh5TThaCo
 hSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041600; x=1714646400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TC2bP0/6Mi0Irx1gaZY1ePjw6SgQQnFAjnZrvi/Kncc=;
 b=DUQOg020odgcF4rZzA4GYVh1vtosbtranU9MvBTDwxLINY9E5PYxTiwR8ItsIC0Dxa
 Hjy2Jgx2/1noTvGTB5uxw7/NjG2izYrfqaZXd1ZVyPmVrmDSySG/iOiTptnwfYJTW+U1
 UB4l71SZj6ZWwVg18Pcfhm0BITHpnImxdEp09Uk3GStmviM6jhF7ic89SsfiJ75zUoZ4
 Q+zG1yTfULSzXipCGkseLkeeUacwc7LyBcq2meWDueDkmlv0jbpO4TGQmzhIfUN+OC64
 lrm3uPuHdzQofzUya50EmSbRU1cR79/XKEizv8ONv34KO+LUxiQyq6BfR1H6qKGnUCwZ
 xoMQ==
X-Gm-Message-State: AOJu0Yz3oovcRTYoys1VZCAyh5BpWWsdMhbsx2jHY405wRyuFpcJ1ec2
 LfCqr7UXfAJ3CdhEnprgHe911pWBIPGFyBK19YHbCvT+3lAoxpT1Mywk+/LlWa3UnvR/FEpWTwL
 p
X-Google-Smtp-Source: AGHT+IE+qGS4bXfIcf5j68ql3G5K96VnQIZM59yGQNRGCbAqmYNdl+vySuXXfpbV15m07dkqoP69yQ==
X-Received: by 2002:ac2:4ec8:0:b0:51c:1d6b:5171 with SMTP id
 p8-20020ac24ec8000000b0051c1d6b5171mr1793246lfr.56.1714041600016; 
 Thu, 25 Apr 2024 03:40:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.39.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:39:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/37] target-arm queue
Date: Thu, 25 Apr 2024 11:39:21 +0100
Message-Id: <20240425103958.3237225-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

Hi; here's the first arm pullreq for 9.1.

This includes the reset method function signature change, so it has
some chance of compile failures due to merge conflicts if some other
pullreq added a device reset method and that pullreq got applied
before this one.  If so, the changes needed to fix those up can be
created by running the spatch rune described in the commit message of
the "hw, target: Add ResetType argument to hold and exit phase
methods" commit.

thanks
-- PMM

The following changes since commit 5da72194df36535d773c8bdc951529ecd5e31707:

  Merge tag 'pull-tcg-20240424' of https://gitlab.com/rth7680/qemu into staging (2024-04-24 15:51:49 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240425

for you to fetch changes up to 214652da123e3821657a64691ee556281e9f6238:

  tests/qtest: Add tests for the STM32L4x5 USART (2024-04-25 10:21:59 +0100)

----------------------------------------------------------------
target-arm queue:
 * Implement FEAT_NMI and NMI support in the GICv3
 * hw/dma: avoid apparent overflow in soc_dma_set_request
 * linux-user/flatload.c: Remove unused bFLT shared-library and ZFLAT code
 * Add ResetType argument to Resettable hold and exit phase methods
 * Add RESET_TYPE_SNAPSHOT_LOAD ResetType
 * Implement STM32L4x5 USART

----------------------------------------------------------------
Anastasia Belova (1):
      hw/dma: avoid apparent overflow in soc_dma_set_request

Arnaud Minier (5):
      hw/char: Implement STM32L4x5 USART skeleton
      hw/char/stm32l4x5_usart: Enable serial read and write
      hw/char/stm32l4x5_usart: Add options for serial parameters setting
      hw/arm: Add the USART to the stm32l4x5 SoC
      tests/qtest: Add tests for the STM32L4x5 USART

Jinjie Ruan (22):
      target/arm: Handle HCR_EL2 accesses for bits introduced with FEAT_NMI
      target/arm: Add PSTATE.ALLINT
      target/arm: Add support for FEAT_NMI, Non-maskable Interrupt
      target/arm: Implement ALLINT MSR (immediate)
      target/arm: Support MSR access to ALLINT
      target/arm: Add support for Non-maskable Interrupt
      target/arm: Add support for NMI in arm_phys_excp_target_el()
      target/arm: Handle IS/FS in ISR_EL1 for NMI, VINMI and VFNMI
      target/arm: Handle PSTATE.ALLINT on taking an exception
      hw/intc/arm_gicv3: Add external IRQ lines for NMI
      hw/arm/virt: Wire NMI and VINMI irq lines from GIC to CPU
      target/arm: Handle NMI in arm_cpu_do_interrupt_aarch64()
      hw/intc/arm_gicv3: Add has-nmi property to GICv3 device
      hw/intc/arm_gicv3_kvm: Not set has-nmi=true for the KVM GICv3
      hw/intc/arm_gicv3: Add irq non-maskable property
      hw/intc/arm_gicv3_redist: Implement GICR_INMIR0
      hw/intc/arm_gicv3: Implement GICD_INMIR
      hw/intc/arm_gicv3: Implement NMI interrupt priority
      hw/intc/arm_gicv3: Report the NMI interrupt in gicv3_cpuif_update()
      hw/intc/arm_gicv3: Report the VINMI interrupt
      target/arm: Add FEAT_NMI to max
      hw/arm/virt: Enable NMI support in the GIC if the CPU has FEAT_NMI

Peter Maydell (9):
      hw/intc/arm_gicv3: Add NMI handling CPU interface registers
      hw/intc/arm_gicv3: Handle icv_nmiar1_read() for icc_nmiar1_read()
      linux-user/flatload.c: Remove unused bFLT shared-library and ZFLAT code
      hw/misc: Don't special case RESET_TYPE_COLD in npcm7xx_clk, gcr
      allwinner-i2c, adm1272: Use device_cold_reset() for software-triggered reset
      scripts/coccinelle: New script to add ResetType to hold and exit phases
      hw, target: Add ResetType argument to hold and exit phase methods
      docs/devel/reset: Update to new API for hold and exit phase methods
      reset: Add RESET_TYPE_SNAPSHOT_LOAD

 MAINTAINERS                         |   1 +
 docs/devel/reset.rst                |  25 +-
 docs/system/arm/b-l475e-iot01a.rst  |   2 +-
 docs/system/arm/emulation.rst       |   1 +
 scripts/coccinelle/reset-type.cocci | 133 ++++++++
 hw/intc/gicv3_internal.h            |  13 +
 include/hw/arm/stm32l4x5_soc.h      |   7 +
 include/hw/char/stm32l4x5_usart.h   |  67 ++++
 include/hw/intc/arm_gic_common.h    |   2 +
 include/hw/intc/arm_gicv3_common.h  |  14 +
 include/hw/resettable.h             |   5 +-
 linux-user/flat.h                   |   5 +-
 target/arm/cpu-features.h           |   5 +
 target/arm/cpu-qom.h                |   5 +-
 target/arm/cpu.h                    |   9 +
 target/arm/internals.h              |  21 ++
 target/arm/tcg/helper-a64.h         |   1 +
 target/arm/tcg/a64.decode           |   1 +
 hw/adc/npcm7xx_adc.c                |   2 +-
 hw/arm/pxa2xx_pic.c                 |   2 +-
 hw/arm/smmu-common.c                |   2 +-
 hw/arm/smmuv3.c                     |   4 +-
 hw/arm/stellaris.c                  |  10 +-
 hw/arm/stm32l4x5_soc.c              |  83 ++++-
 hw/arm/virt.c                       |  29 +-
 hw/audio/asc.c                      |   2 +-
 hw/char/cadence_uart.c              |   2 +-
 hw/char/sifive_uart.c               |   2 +-
 hw/char/stm32l4x5_usart.c           | 637 ++++++++++++++++++++++++++++++++++++
 hw/core/cpu-common.c                |   2 +-
 hw/core/qdev.c                      |   4 +-
 hw/core/reset.c                     |  17 +-
 hw/core/resettable.c                |   8 +-
 hw/display/virtio-vga.c             |   4 +-
 hw/dma/soc_dma.c                    |   4 +-
 hw/gpio/npcm7xx_gpio.c              |   2 +-
 hw/gpio/pl061.c                     |   2 +-
 hw/gpio/stm32l4x5_gpio.c            |   2 +-
 hw/hyperv/vmbus.c                   |   2 +-
 hw/i2c/allwinner-i2c.c              |   5 +-
 hw/i2c/npcm7xx_smbus.c              |   2 +-
 hw/input/adb.c                      |   2 +-
 hw/input/ps2.c                      |  12 +-
 hw/intc/arm_gic_common.c            |   2 +-
 hw/intc/arm_gic_kvm.c               |   4 +-
 hw/intc/arm_gicv3.c                 |  67 +++-
 hw/intc/arm_gicv3_common.c          |  50 ++-
 hw/intc/arm_gicv3_cpuif.c           | 268 ++++++++++++++-
 hw/intc/arm_gicv3_dist.c            |  36 ++
 hw/intc/arm_gicv3_its.c             |   4 +-
 hw/intc/arm_gicv3_its_common.c      |   2 +-
 hw/intc/arm_gicv3_its_kvm.c         |   4 +-
 hw/intc/arm_gicv3_kvm.c             |   9 +-
 hw/intc/arm_gicv3_redist.c          |  22 ++
 hw/intc/xics.c                      |   2 +-
 hw/m68k/q800-glue.c                 |   2 +-
 hw/misc/djmemc.c                    |   2 +-
 hw/misc/iosb.c                      |   2 +-
 hw/misc/mac_via.c                   |   8 +-
 hw/misc/macio/cuda.c                |   4 +-
 hw/misc/macio/pmu.c                 |   4 +-
 hw/misc/mos6522.c                   |   2 +-
 hw/misc/npcm7xx_clk.c               |  13 +-
 hw/misc/npcm7xx_gcr.c               |  12 +-
 hw/misc/npcm7xx_mft.c               |   2 +-
 hw/misc/npcm7xx_pwm.c               |   2 +-
 hw/misc/stm32l4x5_exti.c            |   2 +-
 hw/misc/stm32l4x5_rcc.c             |  10 +-
 hw/misc/stm32l4x5_syscfg.c          |   2 +-
 hw/misc/xlnx-versal-cframe-reg.c    |   2 +-
 hw/misc/xlnx-versal-crl.c           |   2 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c  |   2 +-
 hw/misc/xlnx-versal-trng.c          |   2 +-
 hw/misc/xlnx-versal-xramc.c         |   2 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c      |   2 +-
 hw/misc/xlnx-zynqmp-crf.c           |   2 +-
 hw/misc/zynq_slcr.c                 |   4 +-
 hw/net/can/xlnx-zynqmp-can.c        |   2 +-
 hw/net/e1000.c                      |   2 +-
 hw/net/e1000e.c                     |   2 +-
 hw/net/igb.c                        |   2 +-
 hw/net/igbvf.c                      |   2 +-
 hw/nvram/xlnx-bbram.c               |   2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c   |   2 +-
 hw/nvram/xlnx-zynqmp-efuse.c        |   2 +-
 hw/pci-bridge/cxl_root_port.c       |   4 +-
 hw/pci-bridge/pcie_root_port.c      |   2 +-
 hw/pci-host/bonito.c                |   2 +-
 hw/pci-host/pnv_phb.c               |   4 +-
 hw/pci-host/pnv_phb3_msi.c          |   4 +-
 hw/pci/pci.c                        |   4 +-
 hw/rtc/mc146818rtc.c                |   2 +-
 hw/s390x/css-bridge.c               |   2 +-
 hw/sensor/adm1266.c                 |   2 +-
 hw/sensor/adm1272.c                 |   4 +-
 hw/sensor/isl_pmbus_vr.c            |  10 +-
 hw/sensor/max31785.c                |   2 +-
 hw/sensor/max34451.c                |   2 +-
 hw/ssi/npcm7xx_fiu.c                |   2 +-
 hw/timer/etraxfs_timer.c            |   2 +-
 hw/timer/npcm7xx_timer.c            |   2 +-
 hw/usb/hcd-dwc2.c                   |   8 +-
 hw/usb/xlnx-versal-usb2-ctrl-regs.c |   2 +-
 hw/virtio/virtio-pci.c              |   2 +-
 linux-user/flatload.c               | 293 +----------------
 target/arm/cpu.c                    | 151 ++++++++-
 target/arm/helper.c                 | 101 +++++-
 target/arm/tcg/cpu64.c              |   1 +
 target/arm/tcg/helper-a64.c         |  16 +-
 target/arm/tcg/translate-a64.c      |  19 ++
 target/avr/cpu.c                    |   4 +-
 target/cris/cpu.c                   |   4 +-
 target/hexagon/cpu.c                |   4 +-
 target/i386/cpu.c                   |   4 +-
 target/loongarch/cpu.c              |   4 +-
 target/m68k/cpu.c                   |   4 +-
 target/microblaze/cpu.c             |   4 +-
 target/mips/cpu.c                   |   4 +-
 target/openrisc/cpu.c               |   4 +-
 target/ppc/cpu_init.c               |   4 +-
 target/riscv/cpu.c                  |   4 +-
 target/rx/cpu.c                     |   4 +-
 target/sh4/cpu.c                    |   4 +-
 target/sparc/cpu.c                  |   4 +-
 target/tricore/cpu.c                |   4 +-
 target/xtensa/cpu.c                 |   4 +-
 tests/qtest/stm32l4x5_usart-test.c  | 315 ++++++++++++++++++
 hw/arm/Kconfig                      |   1 +
 hw/char/Kconfig                     |   3 +
 hw/char/meson.build                 |   1 +
 hw/char/trace-events                |  12 +
 hw/intc/trace-events                |   2 +
 tests/qtest/meson.build             |   4 +-
 133 files changed, 2239 insertions(+), 537 deletions(-)
 create mode 100644 scripts/coccinelle/reset-type.cocci
 create mode 100644 include/hw/char/stm32l4x5_usart.h
 create mode 100644 hw/char/stm32l4x5_usart.c
 create mode 100644 tests/qtest/stm32l4x5_usart-test.c

