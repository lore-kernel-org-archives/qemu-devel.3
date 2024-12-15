Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46C3E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtw8-0001ES-PM; Sun, 15 Dec 2024 14:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw3-0001CF-Lk
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:49 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw0-0000wa-8H
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:47 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-29f87f1152cso1768049fac.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289542; x=1734894342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T7q3ufHs9zosMGA9aNeKz5eunrnTYFH26x4LwhKt7cI=;
 b=EijDCpEIG+AHwPCwE9lWjmpCNvRy+8jtsaExOezivtipq/5aqYuCWop2te7XPsFQ+y
 zCzCEPUT2TTTYxIc5R1edk7IeKKFHqe1aY1itHNJBGGxgktey/3tXt/6O7zEleu0MKS7
 HgvHmWPcHkJJU6cOZpe4vrWF/Oh3fIW0LyOCcC52JC11B8G8F56vyNDwrJC5Xof4nc5U
 j0/tjHzxjcATLpsqQkmo1aQbEi1dxqvGHUChp2X6lwRdKtPjBLpw6zARUydXMaXQZIUw
 iaA7y5A8zeaj389P+WLxmTAtN9c/KxfCgk7tC6KUprWTNUr2xmla4F4WISU7jniLjAlT
 0Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289542; x=1734894342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T7q3ufHs9zosMGA9aNeKz5eunrnTYFH26x4LwhKt7cI=;
 b=sxe/S1dQ6ZK6CR9xaMaKZlq6ru4Ih5MLoGIXjmEsXYjGBOB778NTi53o7nZTHUf0wE
 U4JvOTM3tBfiUsPNbFP9IMbrXG229EzOakaUb4Q4CROxEhS0DHstbJU0yNaiC4BVS8jE
 iSKwF692T4cz902Vay0+zJnBawhdPuF+MeDVtIMd82SId4PF0Ihs2fcJ9md2zdtUyaop
 6pOalXRO3stC46BOoNcNfrkm4N9GdpcEhHyRbDetGFNLmY1JzmpzPUZV4isg0ZqqbaCO
 BSVJNbd4iCQO2CXurEFcQXwbuX7UNs4k8y+g1QwHpCc6DI+Imxu7ci+hn7ZECeSty78f
 3m2w==
X-Gm-Message-State: AOJu0YxAw8j7VOnL/B51NPc5BoipBm4HIfAiPKp0Sbttq86tL3q1e/+p
 LWGAKdiD4NtYNap5BqnoixCY4uUdh4hcvgHZrwkVO4L5dq+Hq+PJIxKIb99wCKI6MavZNrOFz44
 aR4xI15Oy
X-Gm-Gg: ASbGncuF9r7xk+xZ2kHcZVQ6EuepnSjs5zTsNMC73v1ZG1ItqZ1MlrBuA8++jrzm82K
 p/D3/igqoLWvwOfu2uELj4+VQpmwwmn9IwU3NPoPbiOkpDP5ej26JsMn5vyJJ63UrAd/bkoQapl
 4yvKBRcTrTIFNbvaoe+9wOHG8b2t9qZ6PmQFmqO1dKWjf6eG1yqn+n2Nf2C2SK48leNjfGmn0qt
 V7i1+DsKt85Zsmhdl+12KOhvALx4Hse/EO0aqtP2c1llfCFc7v95w3sHDKpMs5B2HcElZDw5Isj
 JGTxTj95YC92gG9hFYhtRf9NMQBZA14vVIHoxirB07o=
X-Google-Smtp-Source: AGHT+IHXOxHAgJ56D9mnDxwNIb0AiS3ho1vcufkLLMGKAuqqU8K4ZXrNEYjcxLzv/eNZ/ors4DMBYg==
X-Received: by 2002:a05:6871:520d:b0:29e:7f5b:b003 with SMTP id
 586e51a60fabf-2a3ac6ba7fbmr4425160fac.22.1734289541148; 
 Sun, 15 Dec 2024 11:05:41 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/67] Constify almost all Property
Date: Sun, 15 Dec 2024 13:04:26 -0600
Message-ID: <20241215190533.3222854-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

The following changes since commit ca80a5d026a280762e0772615f1988db542b3ade:

  Merge tag 'hw-misc-20241214' of https://github.com/philmd/qemu into staging (2024-12-14 08:42:53 -0500)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-prop-20241215

for you to fetch changes up to fd363a14f68a7bcbede024fb5155371c19b8f5d2:

  docs: Constify all Property in examples (2024-12-15 12:56:51 -0600)

----------------------------------------------------------------
Constify almost all struct Property

----------------------------------------------------------------
Richard Henderson (67):
      target/arm: Constify all Property
      target/avr: Constify all Property
      target/hexagon: Constify all Property
      target/i386: Constify all Property
      target/microblaze: Constify all Property
      target/mips: Constify all Property
      target/riscv: Constify all Property
      target/s390x: Constify all Property
      target/sparc: Constify all Property and PropertyInfo
      cpu-target: Constify all Property
      hw/9pfs: Constify all Property
      hw/acpi: Constify all Property
      hw/adc: Constify all Property
      hw/arm: Constify all Property
      hw/audio: Constify all Property
      hw/avr: Constify all Property
      hw/block/xen-block: Unexport PropertyInfo
      hw/block: Constify all Property
      hw/char: Constify all Property
      hw/core: Constify all Property
      hw/cpu: Constify all Property
      hw/cxl: Constify all Property
      hw/display: Constify all Property
      hw/dma: Constify all Property
      hw/gpio: Constify all Property
      hw/hyperv: Constify all Property
      hw/i2c: Constify all Property
      hw/i386: Constify all Property
      hw/ide: Constify all Property
      hw/input: Constify all Property
      hw/intc: Constify all Property
      hw/ipack: Constify all Property
      hw/ipmi: Constify all Property
      hw/isa: Constify all Property
      hw/m68k: Constify all Property
      hw/mem: Constify all Property
      hw/mips: Constify all Property
      hw/misc/xlnx-versal-trng: Constify trng_props
      hw/misc: Constify all Property
      hw/net: Constify all Property
      hw/nubus: Constify all Property
      hw/nvme: Constify all Property
      hw/nvram: Constify all Property
      hw/pci-bridge: Constify all Property
      hw/pci-host: Constify all Property
      hw/pci: Constify all Property
      hw/ppc: Constify all Property
      hw/remote: Constify all Property
      hw/riscv: Constify all Property
      hw/rtc: Constify all Property
      hw/rx: Constify all Property
      hw/s390x: Constify all Property
      hw/scsi: Constify all Property
      hw/sd: Constify all Property
      hw/sparc: Constify all Property
      hw/sparc64: Constify all Property
      hw/ssi: Constify all Property
      hw/timer: Constify all Property
      hw/tpm: Constify all Property
      hw/ufs: Constify all Property
      hw/usb: Constify all Property
      hw/vfio: Constify all Property
      hw/virtio: Constify all Property
      hw/watchdog: Constify all Property
      hw/xen: Constify all Property
      tests/unit: Constify all Property
      docs: Constify all Property in examples

 cpu-target.c                           |  2 +-
 hw/9pfs/virtio-9p-device.c             |  2 +-
 hw/acpi/erst.c                         |  2 +-
 hw/acpi/generic_event_device.c         |  2 +-
 hw/acpi/piix4.c                        |  2 +-
 hw/acpi/vmgenid.c                      |  2 +-
 hw/adc/aspeed_adc.c                    |  2 +-
 hw/adc/npcm7xx_adc.c                   |  2 +-
 hw/arm/armsse.c                        |  8 ++++----
 hw/arm/armv7m.c                        |  4 ++--
 hw/arm/aspeed_soc_common.c             |  2 +-
 hw/arm/bcm2836.c                       |  2 +-
 hw/arm/fsl-imx25.c                     |  2 +-
 hw/arm/fsl-imx6.c                      |  2 +-
 hw/arm/fsl-imx6ul.c                    |  2 +-
 hw/arm/fsl-imx7.c                      |  2 +-
 hw/arm/integratorcp.c                  |  2 +-
 hw/arm/msf2-soc.c                      |  2 +-
 hw/arm/npcm7xx.c                       |  2 +-
 hw/arm/nrf51_soc.c                     |  2 +-
 hw/arm/smmu-common.c                   |  2 +-
 hw/arm/smmuv3.c                        |  2 +-
 hw/arm/stellaris.c                     |  2 +-
 hw/arm/strongarm.c                     |  2 +-
 hw/arm/xlnx-versal.c                   |  2 +-
 hw/arm/xlnx-zynqmp.c                   |  2 +-
 hw/audio/ac97.c                        |  2 +-
 hw/audio/adlib.c                       |  2 +-
 hw/audio/asc.c                         |  2 +-
 hw/audio/cs4231a.c                     |  2 +-
 hw/audio/es1370.c                      |  2 +-
 hw/audio/gus.c                         |  2 +-
 hw/audio/hda-codec.c                   |  2 +-
 hw/audio/intel-hda.c                   |  4 ++--
 hw/audio/pcspk.c                       |  2 +-
 hw/audio/pl041.c                       |  2 +-
 hw/audio/sb16.c                        |  2 +-
 hw/audio/via-ac97.c                    |  2 +-
 hw/audio/virtio-snd-pci.c              |  2 +-
 hw/audio/virtio-snd.c                  |  2 +-
 hw/audio/wm8750.c                      |  2 +-
 hw/avr/atmega.c                        |  2 +-
 hw/block/fdc-isa.c                     |  2 +-
 hw/block/fdc-sysbus.c                  |  4 ++--
 hw/block/fdc.c                         |  2 +-
 hw/block/m25p80.c                      |  2 +-
 hw/block/nand.c                        |  2 +-
 hw/block/pflash_cfi01.c                |  2 +-
 hw/block/pflash_cfi02.c                |  2 +-
 hw/block/swim.c                        |  2 +-
 hw/block/vhost-user-blk.c              |  2 +-
 hw/block/virtio-blk.c                  |  2 +-
 hw/block/xen-block.c                   |  4 ++--
 hw/char/avr_usart.c                    |  2 +-
 hw/char/bcm2835_aux.c                  |  2 +-
 hw/char/cadence_uart.c                 |  2 +-
 hw/char/cmsdk-apb-uart.c               |  2 +-
 hw/char/debugcon.c                     |  2 +-
 hw/char/digic-uart.c                   |  2 +-
 hw/char/escc.c                         |  2 +-
 hw/char/exynos4210_uart.c              |  2 +-
 hw/char/goldfish_tty.c                 |  2 +-
 hw/char/grlib_apbuart.c                |  2 +-
 hw/char/ibex_uart.c                    |  2 +-
 hw/char/imx_serial.c                   |  2 +-
 hw/char/ipoctal232.c                   |  2 +-
 hw/char/mcf_uart.c                     |  2 +-
 hw/char/nrf51_uart.c                   |  2 +-
 hw/char/parallel.c                     |  2 +-
 hw/char/pl011.c                        |  2 +-
 hw/char/renesas_sci.c                  |  2 +-
 hw/char/sclpconsole-lm.c               |  2 +-
 hw/char/sclpconsole.c                  |  2 +-
 hw/char/serial-isa.c                   |  2 +-
 hw/char/serial-mm.c                    |  2 +-
 hw/char/serial-pci-multi.c             |  4 ++--
 hw/char/serial-pci.c                   |  2 +-
 hw/char/serial.c                       |  2 +-
 hw/char/sh_serial.c                    |  2 +-
 hw/char/shakti_uart.c                  |  2 +-
 hw/char/sifive_uart.c                  |  2 +-
 hw/char/spapr_vty.c                    |  2 +-
 hw/char/stm32f2xx_usart.c              |  2 +-
 hw/char/stm32l4x5_usart.c              |  2 +-
 hw/char/terminal3270.c                 |  2 +-
 hw/char/virtio-console.c               |  2 +-
 hw/char/virtio-serial-bus.c            |  4 ++--
 hw/char/xen_console.c                  |  2 +-
 hw/char/xilinx_uartlite.c              |  2 +-
 hw/core/generic-loader.c               |  2 +-
 hw/core/guest-loader.c                 |  2 +-
 hw/core/or-irq.c                       |  2 +-
 hw/core/platform-bus.c                 |  2 +-
 hw/core/split-irq.c                    |  2 +-
 hw/cpu/a15mpcore.c                     |  2 +-
 hw/cpu/a9mpcore.c                      |  2 +-
 hw/cpu/arm11mpcore.c                   |  2 +-
 hw/cpu/cluster.c                       |  2 +-
 hw/cpu/realview_mpcore.c               |  2 +-
 hw/cxl/switch-mailbox-cci.c            |  2 +-
 hw/display/artist.c                    |  2 +-
 hw/display/ati.c                       |  2 +-
 hw/display/bcm2835_fb.c                |  2 +-
 hw/display/bochs-display.c             |  2 +-
 hw/display/cg3.c                       |  2 +-
 hw/display/cirrus_vga.c                |  2 +-
 hw/display/cirrus_vga_isa.c            |  2 +-
 hw/display/exynos4210_fimd.c           |  2 +-
 hw/display/g364fb.c                    |  2 +-
 hw/display/i2c-ddc.c                   |  2 +-
 hw/display/macfb.c                     |  4 ++--
 hw/display/pl110.c                     |  2 +-
 hw/display/qxl.c                       |  2 +-
 hw/display/ramfb-standalone.c          |  2 +-
 hw/display/sm501.c                     |  4 ++--
 hw/display/tcx.c                       |  2 +-
 hw/display/vga-isa.c                   |  2 +-
 hw/display/vga-mmio.c                  |  2 +-
 hw/display/vga-pci.c                   |  4 ++--
 hw/display/vhost-user-gpu.c            |  2 +-
 hw/display/virtio-gpu-gl.c             |  2 +-
 hw/display/virtio-gpu-pci.c            |  2 +-
 hw/display/virtio-gpu-rutabaga.c       |  2 +-
 hw/display/virtio-gpu.c                |  2 +-
 hw/display/virtio-vga.c                |  2 +-
 hw/display/vmware_vga.c                |  2 +-
 hw/display/xlnx_dp.c                   |  2 +-
 hw/dma/i82374.c                        |  2 +-
 hw/dma/i8257.c                         |  2 +-
 hw/dma/pl080.c                         |  2 +-
 hw/dma/pl330.c                         |  2 +-
 hw/dma/xilinx_axidma.c                 |  2 +-
 hw/dma/xlnx-zdma.c                     |  2 +-
 hw/dma/xlnx_csu_dma.c                  |  2 +-
 hw/gpio/imx_gpio.c                     |  2 +-
 hw/gpio/npcm7xx_gpio.c                 |  2 +-
 hw/gpio/omap_gpio.c                    |  2 +-
 hw/gpio/pca9552.c                      |  2 +-
 hw/gpio/pca9554.c                      |  2 +-
 hw/gpio/pl061.c                        |  2 +-
 hw/gpio/sifive_gpio.c                  |  2 +-
 hw/gpio/stm32l4x5_gpio.c               |  2 +-
 hw/hyperv/hv-balloon.c                 |  2 +-
 hw/hyperv/syndbg.c                     |  2 +-
 hw/hyperv/vmbus.c                      |  4 ++--
 hw/i2c/aspeed_i2c.c                    |  4 ++--
 hw/i2c/core.c                          |  2 +-
 hw/i2c/i2c_mux_pca954x.c               |  2 +-
 hw/i2c/omap_i2c.c                      |  2 +-
 hw/i386/amd_iommu.c                    |  2 +-
 hw/i386/intel_iommu.c                  |  2 +-
 hw/i386/kvm/clock.c                    |  2 +-
 hw/i386/kvm/i8254.c                    |  2 +-
 hw/i386/kvm/ioapic.c                   |  2 +-
 hw/i386/sgx-epc.c                      |  2 +-
 hw/i386/vmmouse.c                      |  2 +-
 hw/i386/vmport.c                       |  2 +-
 hw/i386/x86-iommu.c                    |  2 +-
 hw/i386/xen/xen_pvdevice.c             |  2 +-
 hw/ide/cf.c                            |  2 +-
 hw/ide/cmd646.c                        |  2 +-
 hw/ide/ide-dev.c                       |  6 +++---
 hw/ide/isa.c                           |  2 +-
 hw/ide/macio.c                         |  2 +-
 hw/ide/mmio.c                          |  2 +-
 hw/input/pckbd.c                       |  4 ++--
 hw/input/stellaris_gamepad.c           |  2 +-
 hw/input/virtio-input-hid.c            |  6 +++---
 hw/input/virtio-input-host.c           |  2 +-
 hw/input/virtio-input.c                |  2 +-
 hw/intc/apic_common.c                  |  2 +-
 hw/intc/arm_gic_common.c               |  2 +-
 hw/intc/arm_gicv2m.c                   |  2 +-
 hw/intc/arm_gicv3_common.c             |  2 +-
 hw/intc/arm_gicv3_its.c                |  2 +-
 hw/intc/arm_gicv3_its_kvm.c            |  2 +-
 hw/intc/armv7m_nvic.c                  |  2 +-
 hw/intc/exynos4210_combiner.c          |  2 +-
 hw/intc/exynos4210_gic.c               |  2 +-
 hw/intc/goldfish_pic.c                 |  2 +-
 hw/intc/grlib_irqmp.c                  |  2 +-
 hw/intc/i8259_common.c                 |  2 +-
 hw/intc/ioapic.c                       |  2 +-
 hw/intc/loongarch_extioi.c             |  2 +-
 hw/intc/loongarch_pch_msi.c            |  2 +-
 hw/intc/loongarch_pch_pic.c            |  2 +-
 hw/intc/loongson_ipi_common.c          |  2 +-
 hw/intc/m68k_irqc.c                    |  2 +-
 hw/intc/mips_gic.c                     |  2 +-
 hw/intc/omap_intc.c                    |  2 +-
 hw/intc/ompic.c                        |  2 +-
 hw/intc/openpic.c                      |  2 +-
 hw/intc/openpic_kvm.c                  |  2 +-
 hw/intc/pnv_xive.c                     |  2 +-
 hw/intc/pnv_xive2.c                    |  2 +-
 hw/intc/ppc-uic.c                      |  2 +-
 hw/intc/riscv_aclint.c                 |  4 ++--
 hw/intc/riscv_aplic.c                  |  2 +-
 hw/intc/riscv_imsic.c                  |  2 +-
 hw/intc/rx_icu.c                       |  2 +-
 hw/intc/s390_flic.c                    |  4 ++--
 hw/intc/sifive_plic.c                  |  2 +-
 hw/intc/spapr_xive.c                   |  2 +-
 hw/intc/xics.c                         |  4 ++--
 hw/intc/xilinx_intc.c                  |  2 +-
 hw/intc/xive.c                         |  8 ++++----
 hw/intc/xive2.c                        |  4 ++--
 hw/intc/xlnx-pmu-iomod-intc.c          |  2 +-
 hw/ipack/ipack.c                       |  2 +-
 hw/ipmi/ipmi.c                         |  2 +-
 hw/ipmi/ipmi_bmc_extern.c              |  2 +-
 hw/ipmi/ipmi_bmc_sim.c                 |  2 +-
 hw/ipmi/isa_ipmi_bt.c                  |  2 +-
 hw/ipmi/isa_ipmi_kcs.c                 |  2 +-
 hw/isa/lpc_ich9.c                      |  2 +-
 hw/isa/pc87312.c                       |  2 +-
 hw/isa/piix.c                          |  2 +-
 hw/m68k/mcf5206.c                      |  2 +-
 hw/m68k/mcf_intc.c                     |  2 +-
 hw/m68k/next-cube.c                    |  2 +-
 hw/m68k/q800-glue.c                    |  2 +-
 hw/mem/cxl_type3.c                     |  2 +-
 hw/mem/nvdimm.c                        |  2 +-
 hw/mem/pc-dimm.c                       |  2 +-
 hw/mem/sparse-mem.c                    |  2 +-
 hw/mips/cps.c                          |  2 +-
 hw/misc/a9scu.c                        |  2 +-
 hw/misc/allwinner-h3-dramc.c           |  2 +-
 hw/misc/allwinner-r40-dramc.c          |  2 +-
 hw/misc/allwinner-sid.c                |  2 +-
 hw/misc/applesmc.c                     |  2 +-
 hw/misc/arm11scu.c                     |  2 +-
 hw/misc/arm_l2x0.c                     |  2 +-
 hw/misc/arm_sysctl.c                   |  2 +-
 hw/misc/armsse-cpuid.c                 |  2 +-
 hw/misc/aspeed_hace.c                  |  2 +-
 hw/misc/aspeed_i3c.c                   |  2 +-
 hw/misc/aspeed_lpc.c                   |  2 +-
 hw/misc/aspeed_sbc.c                   |  2 +-
 hw/misc/aspeed_scu.c                   |  2 +-
 hw/misc/aspeed_sdmc.c                  |  2 +-
 hw/misc/bcm2835_cprman.c               |  2 +-
 hw/misc/bcm2835_property.c             |  2 +-
 hw/misc/debugexit.c                    |  2 +-
 hw/misc/eccmemctl.c                    |  2 +-
 hw/misc/empty_slot.c                   |  2 +-
 hw/misc/iotkit-secctl.c                |  2 +-
 hw/misc/iotkit-sysctl.c                |  2 +-
 hw/misc/iotkit-sysinfo.c               |  2 +-
 hw/misc/ivshmem.c                      |  4 ++--
 hw/misc/led.c                          |  2 +-
 hw/misc/mac_via.c                      |  2 +-
 hw/misc/macio/cuda.c                   |  2 +-
 hw/misc/macio/macio.c                  |  4 ++--
 hw/misc/macio/pmu.c                    |  2 +-
 hw/misc/mips_cmgcr.c                   |  2 +-
 hw/misc/mips_cpc.c                     |  2 +-
 hw/misc/mips_itu.c                     |  2 +-
 hw/misc/mos6522.c                      |  2 +-
 hw/misc/mps2-fpgaio.c                  |  2 +-
 hw/misc/mps2-scc.c                     |  2 +-
 hw/misc/msf2-sysreg.c                  |  2 +-
 hw/misc/npcm7xx_gcr.c                  |  2 +-
 hw/misc/nrf51_rng.c                    |  2 +-
 hw/misc/pci-testdev.c                  |  2 +-
 hw/misc/pvpanic-isa.c                  |  2 +-
 hw/misc/pvpanic-pci.c                  |  2 +-
 hw/misc/sifive_e_aon.c                 |  2 +-
 hw/misc/sifive_u_otp.c                 |  2 +-
 hw/misc/stm32l4x5_rcc.c                |  2 +-
 hw/misc/tz-mpc.c                       |  2 +-
 hw/misc/tz-msc.c                       |  2 +-
 hw/misc/tz-ppc.c                       |  2 +-
 hw/misc/unimp.c                        |  2 +-
 hw/misc/xlnx-versal-cframe-reg.c       |  4 ++--
 hw/misc/xlnx-versal-cfu.c              |  4 ++--
 hw/misc/xlnx-versal-trng.c             |  6 +++---
 hw/misc/xlnx-versal-xramc.c            |  2 +-
 hw/misc/zynq_slcr.c                    |  2 +-
 hw/net/allwinner-sun8i-emac.c          |  2 +-
 hw/net/allwinner_emac.c                |  2 +-
 hw/net/cadence_gem.c                   |  2 +-
 hw/net/can/xlnx-versal-canfd.c         |  2 +-
 hw/net/can/xlnx-zynqmp-can.c           |  2 +-
 hw/net/dp8393x.c                       |  2 +-
 hw/net/e1000.c                         |  2 +-
 hw/net/e1000e.c                        |  2 +-
 hw/net/eepro100.c                      |  2 +-
 hw/net/fsl_etsec/etsec.c               |  2 +-
 hw/net/ftgmac100.c                     |  4 ++--
 hw/net/igb.c                           |  2 +-
 hw/net/imx_fec.c                       |  2 +-
 hw/net/lan9118.c                       |  2 +-
 hw/net/lance.c                         |  2 +-
 hw/net/lasi_i82596.c                   |  2 +-
 hw/net/mcf_fec.c                       |  2 +-
 hw/net/mipsnet.c                       |  2 +-
 hw/net/msf2-emac.c                     |  2 +-
 hw/net/mv88w8618_eth.c                 |  2 +-
 hw/net/ne2000-isa.c                    |  2 +-
 hw/net/ne2000-pci.c                    |  2 +-
 hw/net/npcm7xx_emc.c                   |  2 +-
 hw/net/npcm_gmac.c                     |  2 +-
 hw/net/opencores_eth.c                 |  2 +-
 hw/net/pcnet-pci.c                     |  2 +-
 hw/net/rocker/rocker.c                 |  2 +-
 hw/net/rtl8139.c                       |  2 +-
 hw/net/smc91c111.c                     |  2 +-
 hw/net/spapr_llan.c                    |  2 +-
 hw/net/stellaris_enet.c                |  2 +-
 hw/net/sungem.c                        |  2 +-
 hw/net/sunhme.c                        |  2 +-
 hw/net/tulip.c                         |  2 +-
 hw/net/virtio-net.c                    |  2 +-
 hw/net/vmxnet3.c                       |  2 +-
 hw/net/xen_nic.c                       |  2 +-
 hw/net/xgmac.c                         |  2 +-
 hw/net/xilinx_axienet.c                |  2 +-
 hw/net/xilinx_ethlite.c                |  2 +-
 hw/nubus/nubus-bridge.c                |  2 +-
 hw/nubus/nubus-device.c                |  2 +-
 hw/nvme/ctrl.c                         |  2 +-
 hw/nvme/ns.c                           |  2 +-
 hw/nvme/subsys.c                       |  2 +-
 hw/nvram/ds1225y.c                     |  2 +-
 hw/nvram/eeprom_at24c.c                |  2 +-
 hw/nvram/fw_cfg.c                      |  6 +++---
 hw/nvram/mac_nvram.c                   |  2 +-
 hw/nvram/nrf51_nvm.c                   |  2 +-
 hw/nvram/spapr_nvram.c                 |  2 +-
 hw/nvram/xlnx-bbram.c                  |  2 +-
 hw/nvram/xlnx-efuse.c                  |  2 +-
 hw/nvram/xlnx-versal-efuse-cache.c     |  2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c      |  2 +-
 hw/nvram/xlnx-zynqmp-efuse.c           |  2 +-
 hw/pci-bridge/cxl_downstream.c         |  2 +-
 hw/pci-bridge/cxl_root_port.c          |  2 +-
 hw/pci-bridge/cxl_upstream.c           |  2 +-
 hw/pci-bridge/gen_pcie_root_port.c     |  2 +-
 hw/pci-bridge/pci_bridge_dev.c         |  2 +-
 hw/pci-bridge/pci_expander_bridge.c    |  4 ++--
 hw/pci-bridge/pcie_pci_bridge.c        |  2 +-
 hw/pci-bridge/pcie_root_port.c         |  2 +-
 hw/pci-bridge/xio3130_downstream.c     |  2 +-
 hw/pci-host/dino.c                     |  2 +-
 hw/pci-host/gpex.c                     |  2 +-
 hw/pci-host/grackle.c                  |  2 +-
 hw/pci-host/gt64120.c                  |  2 +-
 hw/pci-host/i440fx.c                   |  2 +-
 hw/pci-host/mv64361.c                  |  2 +-
 hw/pci-host/pnv_phb.c                  |  4 ++--
 hw/pci-host/pnv_phb3.c                 |  2 +-
 hw/pci-host/pnv_phb4.c                 |  2 +-
 hw/pci-host/pnv_phb4_pec.c             |  2 +-
 hw/pci-host/ppce500.c                  |  2 +-
 hw/pci-host/q35.c                      |  4 ++--
 hw/pci-host/raven.c                    |  2 +-
 hw/pci-host/sabre.c                    |  2 +-
 hw/pci-host/uninorth.c                 |  2 +-
 hw/pci-host/versatile.c                |  2 +-
 hw/pci-host/xilinx-pcie.c              |  2 +-
 hw/pci/pci.c                           |  2 +-
 hw/pci/pci_bridge.c                    |  2 +-
 hw/pci/pci_host.c                      |  2 +-
 hw/pci/pcie_port.c                     |  4 ++--
 hw/ppc/pnv.c                           |  2 +-
 hw/ppc/pnv_adu.c                       |  2 +-
 hw/ppc/pnv_chiptod.c                   |  2 +-
 hw/ppc/pnv_core.c                      |  4 ++--
 hw/ppc/pnv_homer.c                     |  2 +-
 hw/ppc/pnv_i2c.c                       |  2 +-
 hw/ppc/pnv_lpc.c                       |  2 +-
 hw/ppc/pnv_pnor.c                      |  2 +-
 hw/ppc/pnv_psi.c                       |  2 +-
 hw/ppc/ppc405_uc.c                     |  2 +-
 hw/ppc/ppc440_uc.c                     |  2 +-
 hw/ppc/ppc4xx_devs.c                   |  4 ++--
 hw/ppc/ppc4xx_sdram.c                  |  4 ++--
 hw/ppc/prep_systemio.c                 |  2 +-
 hw/ppc/rs6000_mc.c                     |  2 +-
 hw/ppc/spapr_cpu_core.c                |  2 +-
 hw/ppc/spapr_nvdimm.c                  |  2 +-
 hw/ppc/spapr_pci.c                     |  2 +-
 hw/ppc/spapr_rng.c                     |  2 +-
 hw/ppc/spapr_tpm_proxy.c               |  2 +-
 hw/remote/proxy.c                      |  2 +-
 hw/riscv/opentitan.c                   |  2 +-
 hw/riscv/riscv-iommu-pci.c             |  2 +-
 hw/riscv/riscv-iommu.c                 |  2 +-
 hw/riscv/riscv_hart.c                  |  2 +-
 hw/riscv/sifive_u.c                    |  2 +-
 hw/rtc/allwinner-rtc.c                 |  2 +-
 hw/rtc/goldfish_rtc.c                  |  2 +-
 hw/rtc/m48t59-isa.c                    |  2 +-
 hw/rtc/m48t59.c                        |  2 +-
 hw/rtc/mc146818rtc.c                   |  2 +-
 hw/rtc/pl031.c                         |  2 +-
 hw/rx/rx62n.c                          |  2 +-
 hw/s390x/ccw-device.c                  |  2 +-
 hw/s390x/css-bridge.c                  |  2 +-
 hw/s390x/ipl.c                         |  2 +-
 hw/s390x/s390-pci-bus.c                |  2 +-
 hw/s390x/s390-skeys.c                  |  2 +-
 hw/s390x/s390-stattrib.c               |  2 +-
 hw/s390x/vhost-scsi-ccw.c              |  2 +-
 hw/s390x/vhost-user-fs-ccw.c           |  2 +-
 hw/s390x/vhost-vsock-ccw.c             |  2 +-
 hw/s390x/virtio-ccw-9p.c               |  2 +-
 hw/s390x/virtio-ccw-balloon.c          |  2 +-
 hw/s390x/virtio-ccw-blk.c              |  2 +-
 hw/s390x/virtio-ccw-crypto.c           |  2 +-
 hw/s390x/virtio-ccw-gpu.c              |  2 +-
 hw/s390x/virtio-ccw-input.c            |  2 +-
 hw/s390x/virtio-ccw-net.c              |  2 +-
 hw/s390x/virtio-ccw-rng.c              |  2 +-
 hw/s390x/virtio-ccw-scsi.c             |  2 +-
 hw/s390x/virtio-ccw-serial.c           |  2 +-
 hw/scsi/megasas.c                      |  6 +++---
 hw/scsi/mptsas.c                       |  2 +-
 hw/scsi/scsi-bus.c                     |  2 +-
 hw/scsi/scsi-disk.c                    |  6 +++---
 hw/scsi/scsi-generic.c                 |  2 +-
 hw/scsi/spapr_vscsi.c                  |  2 +-
 hw/scsi/vhost-scsi.c                   |  2 +-
 hw/scsi/vhost-user-scsi.c              |  2 +-
 hw/scsi/virtio-scsi.c                  |  2 +-
 hw/scsi/vmw_pvscsi.c                   |  2 +-
 hw/sd/allwinner-sdhost.c               |  2 +-
 hw/sd/aspeed_sdhci.c                   |  2 +-
 hw/sd/sd.c                             |  6 +++---
 hw/sd/sdhci-pci.c                      |  2 +-
 hw/sd/sdhci.c                          |  2 +-
 hw/sparc/sun4m_iommu.c                 |  2 +-
 hw/sparc64/sun4u.c                     |  4 ++--
 hw/ssi/aspeed_smc.c                    |  4 ++--
 hw/ssi/ibex_spi_host.c                 |  2 +-
 hw/ssi/npcm7xx_fiu.c                   |  2 +-
 hw/ssi/pnv_spi.c                       |  2 +-
 hw/ssi/sifive_spi.c                    |  2 +-
 hw/ssi/ssi.c                           |  2 +-
 hw/ssi/xilinx_spi.c                    |  2 +-
 hw/ssi/xilinx_spips.c                  |  4 ++--
 hw/ssi/xlnx-versal-ospi.c              |  2 +-
 hw/timer/a9gtimer.c                    |  2 +-
 hw/timer/allwinner-a10-pit.c           |  2 +-
 hw/timer/arm_mptimer.c                 |  2 +-
 hw/timer/arm_timer.c                   |  2 +-
 hw/timer/aspeed_timer.c                |  2 +-
 hw/timer/avr_timer16.c                 |  2 +-
 hw/timer/grlib_gptimer.c               |  2 +-
 hw/timer/hpet.c                        |  2 +-
 hw/timer/i8254_common.c                |  2 +-
 hw/timer/ibex_timer.c                  |  2 +-
 hw/timer/mss-timer.c                   |  2 +-
 hw/timer/nrf51_timer.c                 |  2 +-
 hw/timer/pxa2xx_timer.c                |  2 +-
 hw/timer/renesas_cmt.c                 |  2 +-
 hw/timer/renesas_tmr.c                 |  2 +-
 hw/timer/sifive_pwm.c                  |  2 +-
 hw/timer/slavio_timer.c                |  2 +-
 hw/timer/sse-timer.c                   |  2 +-
 hw/timer/stm32f2xx_timer.c             |  2 +-
 hw/timer/xilinx_timer.c                |  2 +-
 hw/tpm/tpm_crb.c                       |  2 +-
 hw/tpm/tpm_spapr.c                     |  2 +-
 hw/tpm/tpm_tis_i2c.c                   |  2 +-
 hw/tpm/tpm_tis_isa.c                   |  2 +-
 hw/tpm/tpm_tis_sysbus.c                |  2 +-
 hw/ufs/lu.c                            |  2 +-
 hw/ufs/ufs.c                           |  2 +-
 hw/usb/bus.c                           |  2 +-
 hw/usb/canokey.c                       |  2 +-
 hw/usb/ccid-card-emulated.c            |  2 +-
 hw/usb/ccid-card-passthru.c            |  2 +-
 hw/usb/dev-audio.c                     |  2 +-
 hw/usb/dev-hid.c                       |  6 +++---
 hw/usb/dev-hub.c                       |  2 +-
 hw/usb/dev-mtp.c                       |  2 +-
 hw/usb/dev-network.c                   |  2 +-
 hw/usb/dev-serial.c                    |  4 ++--
 hw/usb/dev-smartcard-reader.c          |  4 ++--
 hw/usb/dev-storage-classic.c           |  2 +-
 hw/usb/dev-uas.c                       |  2 +-
 hw/usb/hcd-dwc2.c                      |  2 +-
 hw/usb/hcd-dwc3.c                      |  2 +-
 hw/usb/hcd-ehci-pci.c                  |  2 +-
 hw/usb/hcd-ehci-sysbus.c               |  2 +-
 hw/usb/hcd-ohci-pci.c                  |  2 +-
 hw/usb/hcd-ohci-sysbus.c               |  2 +-
 hw/usb/hcd-uhci.c                      |  4 ++--
 hw/usb/hcd-xhci-nec.c                  |  2 +-
 hw/usb/hcd-xhci-sysbus.c               |  2 +-
 hw/usb/hcd-xhci.c                      |  2 +-
 hw/usb/host-libusb.c                   |  2 +-
 hw/usb/redirect.c                      |  2 +-
 hw/usb/u2f-emulated.c                  |  2 +-
 hw/usb/u2f-passthru.c                  |  2 +-
 hw/vfio/ap.c                           |  2 +-
 hw/vfio/ccw.c                          |  2 +-
 hw/vfio/pci.c                          |  4 ++--
 hw/vfio/platform.c                     |  2 +-
 hw/virtio/vdpa-dev.c                   |  2 +-
 hw/virtio/vhost-scsi-pci.c             |  2 +-
 hw/virtio/vhost-user-blk-pci.c         |  2 +-
 hw/virtio/vhost-user-device.c          |  2 +-
 hw/virtio/vhost-user-fs-pci.c          |  2 +-
 hw/virtio/vhost-user-fs.c              |  2 +-
 hw/virtio/vhost-user-gpio.c            |  2 +-
 hw/virtio/vhost-user-i2c.c             |  2 +-
 hw/virtio/vhost-user-input.c           |  2 +-
 hw/virtio/vhost-user-rng-pci.c         |  2 +-
 hw/virtio/vhost-user-rng.c             |  2 +-
 hw/virtio/vhost-user-scmi.c            |  2 +-
 hw/virtio/vhost-user-scsi-pci.c        |  2 +-
 hw/virtio/vhost-user-snd.c             |  2 +-
 hw/virtio/vhost-user-vsock-pci.c       |  2 +-
 hw/virtio/vhost-user-vsock.c           |  2 +-
 hw/virtio/vhost-vsock-common.c         |  2 +-
 hw/virtio/vhost-vsock-pci.c            |  2 +-
 hw/virtio/vhost-vsock.c                |  2 +-
 hw/virtio/virtio-9p-pci.c              |  2 +-
 hw/virtio/virtio-balloon.c             |  2 +-
 hw/virtio/virtio-blk-pci.c             |  2 +-
 hw/virtio/virtio-crypto-pci.c          |  2 +-
 hw/virtio/virtio-crypto.c              |  2 +-
 hw/virtio/virtio-input-pci.c           |  2 +-
 hw/virtio/virtio-iommu-pci.c           |  2 +-
 hw/virtio/virtio-iommu.c               |  2 +-
 hw/virtio/virtio-mem.c                 |  2 +-
 hw/virtio/virtio-mmio.c                |  2 +-
 hw/virtio/virtio-net-pci.c             |  2 +-
 hw/virtio/virtio-nsm.c                 |  2 +-
 hw/virtio/virtio-pci.c                 |  4 ++--
 hw/virtio/virtio-pmem.c                |  2 +-
 hw/virtio/virtio-rng-pci.c             |  2 +-
 hw/virtio/virtio-rng.c                 |  2 +-
 hw/virtio/virtio-scsi-pci.c            |  2 +-
 hw/virtio/virtio-serial-pci.c          |  2 +-
 hw/virtio/virtio.c                     |  2 +-
 hw/watchdog/sbsa_gwdt.c                |  2 +-
 hw/watchdog/wdt_aspeed.c               |  2 +-
 hw/watchdog/wdt_imx2.c                 |  2 +-
 hw/xen/xen-bus.c                       |  2 +-
 hw/xen/xen_pt.c                        |  2 +-
 target/arm/cpu.c                       | 26 +++++++++++++-------------
 target/arm/cpu64.c                     |  6 +++---
 target/arm/tcg/cpu64.c                 |  2 +-
 target/avr/cpu.c                       |  2 +-
 target/hexagon/cpu.c                   |  2 +-
 target/i386/cpu.c                      |  4 ++--
 target/microblaze/cpu.c                |  2 +-
 target/mips/cpu.c                      |  2 +-
 target/riscv/cpu.c                     |  2 +-
 target/s390x/cpu.c                     |  2 +-
 target/sparc/cpu.c                     |  4 ++--
 tests/unit/test-qdev-global-props.c    |  2 +-
 docs/devel/migration/compatibility.rst |  4 ++--
 docs/devel/virtio-backends.rst         |  2 +-
 558 files changed, 633 insertions(+), 633 deletions(-)

