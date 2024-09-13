Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A924FA375B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp806-0001rX-Jf; Fri, 13 Sep 2024 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp803-0001g5-Uy
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:19 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp7zz-0007l9-Gj
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:19 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5365b6bd901so2700055e87.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240453; x=1726845253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=MJ2gT84C9uvV1bMqxbpyEwTWbmFEoAQ8ozWX0p2QBGA=;
 b=G3oFCP6SklXFRYsVB9qDounanzA4CMMyMEpI+n38MCY1Hiz+/jeArCv6nEjFHjKJ1p
 bZdAbfngCXP7d3Sob+EXsKEaw/6lbSidZ5ifAkHjgIrQjJfKXo1jPBo4YSgx+2HNha0y
 CQHgcj78Hxy6oGZhQdvxyXOQXbhAzr+xHv1L0t6bW88HkyiSZ05aStaqCCzd5wZ4EDYw
 clD2gAxxTyQRcrgw+qiUMmMLE3jTObOK/yff9lXykLL5Sqs5K/oPzhPg3lhrT/qK+lMM
 DNdQula7hwfyITQMNjBvLTH0q8UFh5N3CQFDuga5S3czYTYtXfA49M8gHnOOZ6BTd7Mf
 3uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240453; x=1726845253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MJ2gT84C9uvV1bMqxbpyEwTWbmFEoAQ8ozWX0p2QBGA=;
 b=Ike6qmhgDLX191sZU4V1AzVMWfIiG0XxVTlFvqnYDbmWL1AB9mljxK2ctYw5XeyaEc
 f+O/ySpfvxvPT4v/YGCrYpumPA7XTkDZq4dNRPuSyabDrtFZ+keWcxbxQ4bkHwkuKQDz
 2rM0H5Lq0j3u3UgbF9U/PqeWHDg4d/10BYLrYLjUh+elenWraS7YK2vEU6RF2pqdFy/h
 tDG7dhtaDAefuk4Xpr8VAEmPvfAQbYn+/X32W/4m0CPNPwmhc+yiBmFm8RiCTMXbfoh0
 hRFCGITFD74pVRaPPLLBcoC2SrHOybFS+EqPdzNytJkWX8AN6QLLmgN4/AlnEc+ZCOIW
 phWg==
X-Gm-Message-State: AOJu0YwkpnE3MrNUutVzF+bJCwzUNwnyCVzdcq91Ufr0WFm1gtUwOD1n
 JgM2OA192hdws7NMaPNcBGJVaXabYRb5QxfEP1ZpwFze5sMO6obERQa+3jw0HcBGnnbEmfHgPUg
 i
X-Google-Smtp-Source: AGHT+IEyaYZLq1yINOpFyDrYdA7WJn03ni6gLLv36CI8GmmbfAHlv1PH39FNyI+o0uJooR5RDlYmvA==
X-Received: by 2002:ac2:4f01:0:b0:52c:dd3d:85af with SMTP id
 2adb3069b0e04-53678fc8565mr4180831e87.25.1726240452832; 
 Fri, 13 Sep 2024 08:14:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/27] target-arm queue
Date: Fri, 13 Sep 2024 16:13:44 +0100
Message-Id: <20240913151411.2167922-1-peter.maydell@linaro.org>
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

The following changes since commit 63731c346f071a77e1bb1789bef1ac9d592b6d4f:

  Merge tag 'pull-loongarch-20240912' of https://gitlab.com/gaosong/qemu into staging (2024-09-13 11:38:15 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240913

for you to fetch changes up to 110684c9a69a02cbabfbddcd3afa921826ad565c:

  hw/intc/arm_gic: fix spurious level triggered interrupts (2024-09-13 15:31:50 +0100)

----------------------------------------------------------------
target-arm queue:
 * s390: convert s390 virtio-ccw and CPU to three-phase reset
 * reset: remove now-unused device_class_set_parent_reset()
 * reset: introduce device_class_set_legacy_reset()
 * reset: remove unneeded transitional machinery
 * kvm: Use 'unsigned long' for request argument in functions wrapping ioctl()
 * hvf: arm: Implement and use hvf_get_physical_address_range
   so VMs can have larger-than-36-bit IPA spaces when the host
   supports this
 * target/arm/tcg: refine cache descriptions with a wrapper
 * hw/net/can/xlnx-versal-canfd: fix various bugs
 * MAINTAINERS: update versal, CAN maintainer entries
 * hw/intc/arm_gic: fix spurious level triggered interrupts

----------------------------------------------------------------
Alireza Sanaee (1):
      target/arm/tcg: refine cache descriptions with a wrapper

Danny Canter (3):
      hw/boards: Add hvf_get_physical_address_range to MachineClass
      hvf: Split up hv_vm_create logic per arch
      hvf: arm: Implement and use hvf_get_physical_address_range

Doug Brown (7):
      hw/net/can/xlnx-versal-canfd: Fix interrupt level
      hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
      hw/net/can/xlnx-versal-canfd: Translate CAN ID registers
      hw/net/can/xlnx-versal-canfd: Handle flags correctly
      hw/net/can/xlnx-versal-canfd: Fix byte ordering
      hw/net/can/xlnx-versal-canfd: Simplify DLC conversions
      hw/net/can/xlnx-versal-canfd: Fix FIFO issues

Francisco Iglesias (3):
      MAINTAINERS: Remove Vikram Garhwal as maintainer
      MAINTAINERS: Update Xilinx Versal OSPI maintainer's email address
      MAINTAINERS: Add my-self as CAN maintainer

Jan Klötzke (1):
      hw/intc/arm_gic: fix spurious level triggered interrupts

Johannes Stoelp (1):
      kvm: Use 'unsigned long' for request argument in functions wrapping ioctl()

Peter Maydell (11):
      hw/s390/ccw-device: Convert to three-phase reset
      hw/s390/virtio-ccw: Convert to three-phase reset
      target/s390: Convert CPU to Resettable interface
      hw: Remove device_class_set_parent_reset()
      target/alpha, hppa: Remove unused parent_reset fields
      hw: Define new device_class_set_legacy_reset()
      hw: Use device_class_set_legacy_reset() instead of opencoding
      hw: Rename DeviceClass::reset field to legacy_reset
      hw: Remove device_phases_reset()
      hw/core/qdev: Simplify legacy_reset handling
      hw/core/resettable: Remove transitional_function machinery

 MAINTAINERS                           |   5 +-
 docs/devel/reset.rst                  |  10 ++
 scripts/coccinelle/device-reset.cocci |  30 ++++++
 hw/s390x/virtio-ccw.h                 |   2 +-
 include/hw/boards.h                   |   5 +
 include/hw/qdev-core.h                |  33 +++---
 include/hw/resettable.h               |  15 +--
 include/sysemu/hvf_int.h              |   1 +
 include/sysemu/kvm.h                  |   8 +-
 include/sysemu/kvm_int.h              |  17 +++-
 target/alpha/cpu.h                    |   2 -
 target/arm/cpu-features.h             |  50 +++++++++
 target/arm/hvf_arm.h                  |  19 ++++
 target/arm/internals.h                |  19 ++++
 target/hppa/cpu.h                     |   2 -
 target/s390x/cpu.h                    |  21 +---
 accel/hvf/hvf-accel-ops.c             |  16 ++-
 accel/kvm/kvm-all.c                   |   8 +-
 hw/acpi/erst.c                        |   2 +-
 hw/acpi/piix4.c                       |   2 +-
 hw/adc/aspeed_adc.c                   |   2 +-
 hw/adc/max111x.c                      |   2 +-
 hw/adc/stm32f2xx_adc.c                |   2 +-
 hw/adc/zynq-xadc.c                    |   2 +-
 hw/arm/armsse.c                       |   2 +-
 hw/arm/highbank.c                     |   2 +-
 hw/arm/musicpal.c                     |   6 +-
 hw/arm/pxa2xx.c                       |   4 +-
 hw/arm/strongarm.c                    |   4 +-
 hw/arm/virt.c                         |  38 ++++++-
 hw/audio/ac97.c                       |   2 +-
 hw/audio/cs4231.c                     |   2 +-
 hw/audio/cs4231a.c                    |   2 +-
 hw/audio/es1370.c                     |   2 +-
 hw/audio/hda-codec.c                  |   2 +-
 hw/audio/intel-hda.c                  |   2 +-
 hw/audio/marvell_88w8618.c            |   2 +-
 hw/audio/pl041.c                      |   2 +-
 hw/audio/via-ac97.c                   |   2 +-
 hw/block/fdc-isa.c                    |   2 +-
 hw/block/fdc-sysbus.c                 |   2 +-
 hw/block/m25p80.c                     |   2 +-
 hw/block/nand.c                       |   2 +-
 hw/block/onenand.c                    |   2 +-
 hw/block/pflash_cfi01.c               |   2 +-
 hw/block/pflash_cfi02.c               |   2 +-
 hw/block/swim.c                       |   2 +-
 hw/char/avr_usart.c                   |   2 +-
 hw/char/cmsdk-apb-uart.c              |   2 +-
 hw/char/digic-uart.c                  |   2 +-
 hw/char/escc.c                        |   2 +-
 hw/char/etraxfs_ser.c                 |   2 +-
 hw/char/exynos4210_uart.c             |   2 +-
 hw/char/goldfish_tty.c                |   2 +-
 hw/char/grlib_apbuart.c               |   2 +-
 hw/char/ibex_uart.c                   |   2 +-
 hw/char/imx_serial.c                  |   2 +-
 hw/char/mcf_uart.c                    |   2 +-
 hw/char/mchp_pfsoc_mmuart.c           |   2 +-
 hw/char/nrf51_uart.c                  |   2 +-
 hw/char/pl011.c                       |   2 +-
 hw/char/renesas_sci.c                 |   2 +-
 hw/char/sclpconsole-lm.c              |   2 +-
 hw/char/sclpconsole.c                 |   2 +-
 hw/char/sh_serial.c                   |   2 +-
 hw/char/shakti_uart.c                 |   2 +-
 hw/char/stm32f2xx_usart.c             |   2 +-
 hw/char/xilinx_uartlite.c             |   2 +-
 hw/core/or-irq.c                      |   2 +-
 hw/core/qdev.c                        |  97 +++++-------------
 hw/core/resettable.c                  |  24 +----
 hw/cxl/switch-mailbox-cci.c           |   2 +-
 hw/display/artist.c                   |   2 +-
 hw/display/ati.c                      |   2 +-
 hw/display/bcm2835_fb.c               |   2 +-
 hw/display/cg3.c                      |   2 +-
 hw/display/dpcd.c                     |   2 +-
 hw/display/exynos4210_fimd.c          |   2 +-
 hw/display/g364fb.c                   |   2 +-
 hw/display/i2c-ddc.c                  |   2 +-
 hw/display/jazz_led.c                 |   2 +-
 hw/display/macfb.c                    |   4 +-
 hw/display/qxl.c                      |   2 +-
 hw/display/sii9022.c                  |   2 +-
 hw/display/sm501.c                    |   4 +-
 hw/display/tcx.c                      |   2 +-
 hw/display/vga-isa.c                  |   2 +-
 hw/display/vga-mmio.c                 |   2 +-
 hw/display/vga-pci.c                  |   2 +-
 hw/display/vmware_vga.c               |   2 +-
 hw/display/xlnx_dp.c                  |   2 +-
 hw/dma/bcm2835_dma.c                  |   2 +-
 hw/dma/i8257.c                        |   2 +-
 hw/dma/pl080.c                        |   2 +-
 hw/dma/pl330.c                        |   2 +-
 hw/dma/rc4030.c                       |   2 +-
 hw/dma/sparc32_dma.c                  |   2 +-
 hw/dma/xilinx_axidma.c                |   2 +-
 hw/dma/xlnx-zdma.c                    |   2 +-
 hw/dma/xlnx-zynq-devcfg.c             |   2 +-
 hw/dma/xlnx_csu_dma.c                 |   2 +-
 hw/dma/xlnx_dpdma.c                   |   2 +-
 hw/fsi/aspeed_apb2opb.c               |   2 +-
 hw/fsi/fsi-master.c                   |   2 +-
 hw/fsi/fsi.c                          |   2 +-
 hw/fsi/lbus.c                         |   2 +-
 hw/gpio/aspeed_gpio.c                 |   2 +-
 hw/gpio/bcm2835_gpio.c                |   2 +-
 hw/gpio/bcm2838_gpio.c                |   2 +-
 hw/gpio/gpio_key.c                    |   2 +-
 hw/gpio/imx_gpio.c                    |   2 +-
 hw/gpio/max7310.c                     |   2 +-
 hw/gpio/mpc8xxx.c                     |   2 +-
 hw/gpio/nrf51_gpio.c                  |   2 +-
 hw/gpio/omap_gpio.c                   |   4 +-
 hw/gpio/pca9552.c                     |   2 +-
 hw/gpio/pca9554.c                     |   2 +-
 hw/gpio/pcf8574.c                     |   2 +-
 hw/gpio/sifive_gpio.c                 |   2 +-
 hw/hyperv/hyperv.c                    |   2 +-
 hw/hyperv/vmbus.c                     |   2 +-
 hw/i2c/aspeed_i2c.c                   |   4 +-
 hw/i2c/bcm2835_i2c.c                  |   2 +-
 hw/i2c/exynos4210_i2c.c               |   2 +-
 hw/i2c/imx_i2c.c                      |   2 +-
 hw/i2c/microbit_i2c.c                 |   2 +-
 hw/i2c/mpc_i2c.c                      |   2 +-
 hw/i2c/omap_i2c.c                     |   2 +-
 hw/i2c/ppc4xx_i2c.c                   |   2 +-
 hw/i2c/smbus_eeprom.c                 |   2 +-
 hw/i386/amd_iommu.c                   |   2 +-
 hw/i386/intel_iommu.c                 |   2 +-
 hw/i386/kvm/i8254.c                   |   2 +-
 hw/i386/kvm/i8259.c                   |   2 +-
 hw/i386/kvm/ioapic.c                  |   2 +-
 hw/i386/kvm/xen_overlay.c             |   2 +-
 hw/i386/port92.c                      |   2 +-
 hw/i386/vapic.c                       |   2 +-
 hw/i386/vmmouse.c                     |   2 +-
 hw/i386/xen/xen_platform.c            |   2 +-
 hw/ide/ahci.c                         |   2 +-
 hw/ide/cmd646.c                       |   2 +-
 hw/ide/ich.c                          |   2 +-
 hw/ide/isa.c                          |   2 +-
 hw/ide/macio.c                        |   2 +-
 hw/ide/microdrive.c                   |   2 +-
 hw/ide/mmio.c                         |   2 +-
 hw/ide/piix.c                         |   4 +-
 hw/ide/sii3112.c                      |   2 +-
 hw/ide/via.c                          |   2 +-
 hw/input/adb-kbd.c                    |   2 +-
 hw/input/adb-mouse.c                  |   2 +-
 hw/input/lm832x.c                     |   2 +-
 hw/input/pckbd.c                      |   4 +-
 hw/intc/allwinner-a10-pic.c           |   2 +-
 hw/intc/apic_common.c                 |   2 +-
 hw/intc/arm_gic.c                     |  11 +-
 hw/intc/armv7m_nvic.c                 |   2 +-
 hw/intc/aspeed_intc.c                 |   2 +-
 hw/intc/aspeed_vic.c                  |   2 +-
 hw/intc/bcm2835_ic.c                  |   2 +-
 hw/intc/bcm2836_control.c             |   2 +-
 hw/intc/exynos4210_combiner.c         |   2 +-
 hw/intc/goldfish_pic.c                |   2 +-
 hw/intc/grlib_irqmp.c                 |   2 +-
 hw/intc/heathrow_pic.c                |   2 +-
 hw/intc/i8259.c                       |   2 +-
 hw/intc/imx_avic.c                    |   2 +-
 hw/intc/imx_gpcv2.c                   |   2 +-
 hw/intc/ioapic.c                      |   2 +-
 hw/intc/loongarch_extioi.c            |   2 +-
 hw/intc/loongarch_pch_pic.c           |   2 +-
 hw/intc/m68k_irqc.c                   |   2 +-
 hw/intc/omap_intc.c                   |   4 +-
 hw/intc/openpic.c                     |   2 +-
 hw/intc/openpic_kvm.c                 |   2 +-
 hw/intc/pl190.c                       |   2 +-
 hw/intc/ppc-uic.c                     |   2 +-
 hw/intc/s390_flic.c                   |   2 +-
 hw/intc/s390_flic_kvm.c               |   2 +-
 hw/intc/sifive_plic.c                 |   2 +-
 hw/intc/slavio_intctl.c               |   2 +-
 hw/intc/xlnx-pmu-iomod-intc.c         |   2 +-
 hw/intc/xlnx-zynqmp-ipi.c             |   2 +-
 hw/isa/lpc_ich9.c                     |   2 +-
 hw/isa/pc87312.c                      |   2 +-
 hw/isa/piix.c                         |   2 +-
 hw/isa/vt82c686.c                     |  10 +-
 hw/m68k/mcf5206.c                     |   2 +-
 hw/m68k/mcf_intc.c                    |   2 +-
 hw/m68k/next-cube.c                   |   2 +-
 hw/m68k/next-kbd.c                    |   2 +-
 hw/mem/cxl_type3.c                    |   2 +-
 hw/misc/a9scu.c                       |   2 +-
 hw/misc/allwinner-cpucfg.c            |   2 +-
 hw/misc/allwinner-h3-ccu.c            |   2 +-
 hw/misc/allwinner-h3-dramc.c          |   2 +-
 hw/misc/allwinner-h3-sysctrl.c        |   2 +-
 hw/misc/allwinner-r40-ccu.c           |   2 +-
 hw/misc/allwinner-r40-dramc.c         |   2 +-
 hw/misc/allwinner-sid.c               |   2 +-
 hw/misc/allwinner-sramc.c             |   2 +-
 hw/misc/applesmc.c                    |   2 +-
 hw/misc/arm_l2x0.c                    |   2 +-
 hw/misc/arm_sysctl.c                  |   2 +-
 hw/misc/armsse-cpu-pwrctrl.c          |   2 +-
 hw/misc/armsse-mhu.c                  |   2 +-
 hw/misc/aspeed_hace.c                 |   2 +-
 hw/misc/aspeed_i3c.c                  |   4 +-
 hw/misc/aspeed_lpc.c                  |   2 +-
 hw/misc/aspeed_peci.c                 |   2 +-
 hw/misc/aspeed_sbc.c                  |   2 +-
 hw/misc/aspeed_scu.c                  |  10 +-
 hw/misc/aspeed_sdmc.c                 |   4 +-
 hw/misc/aspeed_xdma.c                 |   2 +-
 hw/misc/avr_power.c                   |   2 +-
 hw/misc/bcm2835_cprman.c              |   8 +-
 hw/misc/bcm2835_mbox.c                |   2 +-
 hw/misc/bcm2835_mphi.c                |   2 +-
 hw/misc/bcm2835_powermgt.c            |   2 +-
 hw/misc/bcm2835_rng.c                 |   2 +-
 hw/misc/bcm2835_thermal.c             |   2 +-
 hw/misc/eccmemctl.c                   |   2 +-
 hw/misc/exynos4210_clk.c              |   2 +-
 hw/misc/exynos4210_pmu.c              |   2 +-
 hw/misc/exynos4210_rng.c              |   2 +-
 hw/misc/imx25_ccm.c                   |   2 +-
 hw/misc/imx31_ccm.c                   |   2 +-
 hw/misc/imx6_ccm.c                    |   2 +-
 hw/misc/imx6_src.c                    |   2 +-
 hw/misc/imx6ul_ccm.c                  |   2 +-
 hw/misc/imx7_ccm.c                    |   4 +-
 hw/misc/imx7_snvs.c                   |   2 +-
 hw/misc/imx7_src.c                    |   2 +-
 hw/misc/imx_rngc.c                    |   2 +-
 hw/misc/iotkit-secctl.c               |   2 +-
 hw/misc/iotkit-sysctl.c               |   2 +-
 hw/misc/ivshmem.c                     |   2 +-
 hw/misc/lasi.c                        |   2 +-
 hw/misc/led.c                         |   2 +-
 hw/misc/macio/cuda.c                  |   2 +-
 hw/misc/macio/gpio.c                  |   2 +-
 hw/misc/macio/mac_dbdma.c             |   2 +-
 hw/misc/macio/pmu.c                   |   2 +-
 hw/misc/mips_cmgcr.c                  |   2 +-
 hw/misc/mips_cpc.c                    |   2 +-
 hw/misc/mips_itu.c                    |   2 +-
 hw/misc/mps2-fpgaio.c                 |   2 +-
 hw/misc/mps2-scc.c                    |   2 +-
 hw/misc/msf2-sysreg.c                 |   2 +-
 hw/misc/nrf51_rng.c                   |   2 +-
 hw/misc/pci-testdev.c                 |   2 +-
 hw/misc/sifive_e_aon.c                |   2 +-
 hw/misc/sifive_u_prci.c               |   2 +-
 hw/misc/slavio_misc.c                 |   2 +-
 hw/misc/stm32f2xx_syscfg.c            |   2 +-
 hw/misc/stm32f4xx_exti.c              |   2 +-
 hw/misc/stm32f4xx_syscfg.c            |   2 +-
 hw/misc/tz-mpc.c                      |   2 +-
 hw/misc/tz-msc.c                      |   2 +-
 hw/misc/tz-ppc.c                      |   2 +-
 hw/misc/virt_ctrl.c                   |   2 +-
 hw/misc/xlnx-versal-cfu.c             |   2 +-
 hw/net/allwinner-sun8i-emac.c         |   2 +-
 hw/net/allwinner_emac.c               |   2 +-
 hw/net/cadence_gem.c                  |   2 +-
 hw/net/can/can_kvaser_pci.c           |   2 +-
 hw/net/can/can_mioe3680_pci.c         |   2 +-
 hw/net/can/can_pcm3680_pci.c          |   2 +-
 hw/net/can/ctucan_pci.c               |   2 +-
 hw/net/can/xlnx-versal-canfd.c        | 185 ++++++++++++++--------------------
 hw/net/dp8393x.c                      |   2 +-
 hw/net/etraxfs_eth.c                  |   2 +-
 hw/net/fsl_etsec/etsec.c              |   2 +-
 hw/net/ftgmac100.c                    |   4 +-
 hw/net/imx_fec.c                      |   2 +-
 hw/net/lan9118.c                      |   2 +-
 hw/net/lance.c                        |   2 +-
 hw/net/lasi_i82596.c                  |   2 +-
 hw/net/mcf_fec.c                      |   2 +-
 hw/net/mipsnet.c                      |   2 +-
 hw/net/msf2-emac.c                    |   2 +-
 hw/net/npcm7xx_emc.c                  |   2 +-
 hw/net/npcm_gmac.c                    |   2 +-
 hw/net/opencores_eth.c                |   2 +-
 hw/net/pcnet-pci.c                    |   2 +-
 hw/net/rocker/rocker.c                |   2 +-
 hw/net/rtl8139.c                      |   2 +-
 hw/net/smc91c111.c                    |   2 +-
 hw/net/stellaris_enet.c               |   2 +-
 hw/net/sungem.c                       |   2 +-
 hw/net/sunhme.c                       |   2 +-
 hw/net/tulip.c                        |   2 +-
 hw/net/vmxnet3.c                      |   2 +-
 hw/net/xilinx_axienet.c               |   2 +-
 hw/net/xilinx_ethlite.c               |   2 +-
 hw/nvme/ctrl.c                        |   2 +-
 hw/nvram/eeprom_at24c.c               |   2 +-
 hw/nvram/fw_cfg.c                     |   2 +-
 hw/nvram/mac_nvram.c                  |   2 +-
 hw/nvram/nrf51_nvm.c                  |   2 +-
 hw/pci-bridge/cxl_downstream.c        |   2 +-
 hw/pci-bridge/cxl_upstream.c          |   2 +-
 hw/pci-bridge/i82801b11.c             |   2 +-
 hw/pci-bridge/pci_bridge_dev.c        |   2 +-
 hw/pci-bridge/pci_expander_bridge.c   |   2 +-
 hw/pci-bridge/pcie_pci_bridge.c       |   2 +-
 hw/pci-bridge/simba.c                 |   2 +-
 hw/pci-bridge/xio3130_downstream.c    |   2 +-
 hw/pci-bridge/xio3130_upstream.c      |   2 +-
 hw/pci-host/astro.c                   |   4 +-
 hw/pci-host/designware.c              |   2 +-
 hw/pci-host/dino.c                    |   2 +-
 hw/pci-host/gt64120.c                 |   2 +-
 hw/pci-host/mv64361.c                 |   2 +-
 hw/pci-host/ppc440_pcix.c             |   2 +-
 hw/pci-host/q35.c                     |   2 +-
 hw/pci-host/sabre.c                   |   2 +-
 hw/pci-host/versatile.c               |   2 +-
 hw/pci-host/xilinx-pcie.c             |   2 +-
 hw/ppc/pnv_psi.c                      |   4 +-
 hw/ppc/ppc405_boards.c                |   2 +-
 hw/ppc/ppc405_uc.c                    |  12 +--
 hw/ppc/ppc4xx_devs.c                  |   6 +-
 hw/ppc/ppc4xx_sdram.c                 |   4 +-
 hw/ppc/ppce500_spin.c                 |   2 +-
 hw/ppc/spapr_cpu_core.c               |   2 +-
 hw/ppc/spapr_iommu.c                  |   2 +-
 hw/ppc/spapr_pci.c                    |   2 +-
 hw/ppc/spapr_vio.c                    |   2 +-
 hw/remote/proxy.c                     |   2 +-
 hw/rtc/allwinner-rtc.c                |   2 +-
 hw/rtc/aspeed_rtc.c                   |   2 +-
 hw/rtc/ds1338.c                       |   2 +-
 hw/rtc/exynos4210_rtc.c               |   2 +-
 hw/rtc/goldfish_rtc.c                 |   2 +-
 hw/rtc/ls7a_rtc.c                     |   2 +-
 hw/rtc/m48t59-isa.c                   |   2 +-
 hw/rtc/m48t59.c                       |   2 +-
 hw/rtc/xlnx-zynqmp-rtc.c              |   2 +-
 hw/s390x/ccw-device.c                 |   7 +-
 hw/s390x/event-facility.c             |   2 +-
 hw/s390x/ipl.c                        |   2 +-
 hw/s390x/s390-pci-bus.c               |   4 +-
 hw/s390x/sclpquiesce.c                |   2 +-
 hw/s390x/virtio-ccw.c                 |  13 ++-
 hw/scsi/esp-pci.c                     |   2 +-
 hw/scsi/esp.c                         |   2 +-
 hw/scsi/lsi53c895a.c                  |   2 +-
 hw/scsi/megasas.c                     |   2 +-
 hw/scsi/mptsas.c                      |   2 +-
 hw/scsi/scsi-disk.c                   |   2 +-
 hw/scsi/scsi-generic.c                |   2 +-
 hw/scsi/vmw_pvscsi.c                  |   2 +-
 hw/sd/allwinner-sdhost.c              |   2 +-
 hw/sd/aspeed_sdhci.c                  |   2 +-
 hw/sd/bcm2835_sdhost.c                |   2 +-
 hw/sd/cadence_sdhci.c                 |   2 +-
 hw/sd/npcm7xx_sdhci.c                 |   2 +-
 hw/sd/pl181.c                         |   2 +-
 hw/sd/pxa2xx_mmci.c                   |   2 +-
 hw/sd/sd.c                            |   2 +-
 hw/sd/sdhci.c                         |   2 +-
 hw/sd/ssi-sd.c                        |   2 +-
 hw/sensor/dps310.c                    |   2 +-
 hw/sensor/emc141x.c                   |   2 +-
 hw/sensor/lsm303dlhc_mag.c            |   2 +-
 hw/sparc/sun4m_iommu.c                |   2 +-
 hw/sparc64/sun4u_iommu.c              |   2 +-
 hw/ssi/aspeed_smc.c                   |   2 +-
 hw/ssi/bcm2835_spi.c                  |   2 +-
 hw/ssi/ibex_spi_host.c                |   2 +-
 hw/ssi/imx_spi.c                      |   2 +-
 hw/ssi/mss-spi.c                      |   2 +-
 hw/ssi/pl022.c                        |   2 +-
 hw/ssi/pnv_spi.c                      |   2 +-
 hw/ssi/sifive_spi.c                   |   2 +-
 hw/ssi/stm32f2xx_spi.c                |   2 +-
 hw/ssi/xilinx_spi.c                   |   2 +-
 hw/ssi/xilinx_spips.c                 |   4 +-
 hw/ssi/xlnx-versal-ospi.c             |   2 +-
 hw/timer/a9gtimer.c                   |   2 +-
 hw/timer/allwinner-a10-pit.c          |   2 +-
 hw/timer/arm_mptimer.c                |   2 +-
 hw/timer/armv7m_systick.c             |   2 +-
 hw/timer/aspeed_timer.c               |   2 +-
 hw/timer/avr_timer16.c                |   2 +-
 hw/timer/bcm2835_systmr.c             |   2 +-
 hw/timer/cmsdk-apb-dualtimer.c        |   2 +-
 hw/timer/cmsdk-apb-timer.c            |   2 +-
 hw/timer/digic-timer.c                |   2 +-
 hw/timer/exynos4210_mct.c             |   2 +-
 hw/timer/exynos4210_pwm.c             |   2 +-
 hw/timer/grlib_gptimer.c              |   2 +-
 hw/timer/hpet.c                       |   2 +-
 hw/timer/i8254.c                      |   2 +-
 hw/timer/ibex_timer.c                 |   2 +-
 hw/timer/imx_epit.c                   |   2 +-
 hw/timer/imx_gpt.c                    |   2 +-
 hw/timer/nrf51_timer.c                |   2 +-
 hw/timer/renesas_cmt.c                |   2 +-
 hw/timer/renesas_tmr.c                |   2 +-
 hw/timer/sifive_pwm.c                 |   2 +-
 hw/timer/slavio_timer.c               |   2 +-
 hw/timer/sse-counter.c                |   2 +-
 hw/timer/sse-timer.c                  |   2 +-
 hw/timer/stm32f2xx_timer.c            |   2 +-
 hw/tpm/tpm_tis_i2c.c                  |   2 +-
 hw/tpm/tpm_tis_isa.c                  |   2 +-
 hw/tpm/tpm_tis_sysbus.c               |   2 +-
 hw/tricore/tricore_testdevice.c       |   2 +-
 hw/usb/hcd-dwc3.c                     |   2 +-
 hw/usb/hcd-ehci-pci.c                 |   2 +-
 hw/usb/hcd-ehci-sysbus.c              |   2 +-
 hw/usb/hcd-ohci-pci.c                 |   2 +-
 hw/usb/hcd-ohci-sysbus.c              |   2 +-
 hw/usb/hcd-uhci.c                     |   2 +-
 hw/usb/hcd-xhci-pci.c                 |   2 +-
 hw/usb/hcd-xhci-sysbus.c              |   2 +-
 hw/usb/hcd-xhci.c                     |   2 +-
 hw/usb/imx-usb-phy.c                  |   2 +-
 hw/usb/tusb6010.c                     |   2 +-
 hw/vfio/ap.c                          |   2 +-
 hw/vfio/ccw.c                         |   2 +-
 hw/vfio/pci.c                         |   2 +-
 hw/virtio/virtio-mmio.c               |   2 +-
 hw/watchdog/cmsdk-apb-watchdog.c      |   2 +-
 hw/watchdog/sbsa_gwdt.c               |   2 +-
 hw/watchdog/wdt_aspeed.c              |   2 +-
 hw/watchdog/wdt_diag288.c             |   2 +-
 hw/watchdog/wdt_i6300esb.c            |   2 +-
 hw/watchdog/wdt_ib700.c               |   2 +-
 hw/watchdog/wdt_imx2.c                |   2 +-
 target/arm/cpu64.c                    |  19 ++--
 target/arm/hvf/hvf.c                  |  63 ++++++++++++
 target/arm/ptw.c                      |  15 +++
 target/arm/tcg/cpu64.c                | 108 ++++++++++----------
 target/i386/hvf/hvf.c                 |   5 +
 target/i386/kvm/kvm.c                 |   3 +-
 target/s390x/cpu.c                    |  38 ++++---
 target/s390x/sigp.c                   |   8 +-
 accel/kvm/trace-events                |   8 +-
 442 files changed, 977 insertions(+), 820 deletions(-)
 create mode 100644 scripts/coccinelle/device-reset.cocci

