Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677E8E7718C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuLX-0003Mh-9X; Wed, 18 Dec 2024 08:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKu-0001gb-JI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:36 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKn-0005ii-Dr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:36 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3eb7e725aa0so2988132b6e.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529407; x=1735134207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwfwRaToZZ7HGq0nFBRjJ507wzJ+M8LJmZd99n4AVhk=;
 b=kpzUZZsIivljcVrwwWlhp+RT2LNItmG5gWBrVsuvkt/9/tFVyg+EyF3foECmoCub+R
 LTz7fnFzHXG1mrKMb2ED0LJgIHrKOCH1FSHxmCcVZFw/tb1fezP6aJ4mW/updjy5Oy4c
 hMHHki+POAVAfjn/mh58dzPzFnuOMlHsUF3bwPYUokbubRGYcrqU5xCk4x6oCKrhgX73
 LJgaW3oKA8Zi8anMUP5HQrs1KD74QriR7IPTxNi2GS8rDRzZweDwY4c2jW+1srPHu4KW
 A/dnWrqeWrJXbxJXwinUispbI0CjcUtP6Jd+s9WoBpLfV/wJjOxgBwqYg+7tihi6Uept
 5zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529407; x=1735134207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwfwRaToZZ7HGq0nFBRjJ507wzJ+M8LJmZd99n4AVhk=;
 b=qnFfIrIvzBI+QGmL9HM+de/l/6UT9cJ/hO6KLzPc+mxuUj1gHfnA91uVHJGaVX02IA
 WHHWqswKa2vLtx0aPkgizSRREOai/WiE9biPK0zkZseY+SL2qAgygNthSDPTW7UPLkwV
 jkHpwcFPIrdFWgrEbjyIGsxB3fe0bbr2QSUze7AhKuHCaJDQxk7fx6DXye93hEKijESq
 BzFJqRuzlaYb7nXLS6T2vCix9sd/rCH6wBWqEfSR0rekscW03RZH9nIz/m0b1Q8yASss
 gKGNJ/dz4gnHa5FdUNvwMRsXyMfjNnJ8ZEUKa9Gip9My7B2LIopZ06ZdHXetZN/xrx7h
 stVA==
X-Gm-Message-State: AOJu0Yz8gWjHHQyd4dIjlkDjqMnq0QnB96noUv9NDkHAcOwHoToPsuao
 zqHeTJjUzqMKTw+hvrGU67PVi33+AVI9+FO2hVCe1Z3eYbChsfyzcPeIRx0U3dabToidAyUkMTL
 KqUTuhFtc
X-Gm-Gg: ASbGncukQyJnq5M8X7vUjIxfxu+AUOoQ8JhSYFwz9MYDcTBiRJMeRn2syp6RH/PCgE9
 dZcuTbvfxzAEcaveiOjWM/jop2ggxU7/pV7cMUmV64ZmTisrHGl4oe8vFJWBItg7yslEvwTdTmh
 lM+VPy8RO65Mu5iDZhjzg+JWxZvXXAtx29R+9zTSCdkGRPth9i8XgT0609kZTOZ9JS15MYcHVJe
 9v+1jrrCdaRvWAiQNn4ezQhubZCxUPlyUqYJOc6k/UmwcMYsvSESFHPnCGUTedX
X-Google-Smtp-Source: AGHT+IHZcI8bFfq8we9l6zE0ZGOThCVv21eSh3KDzevLbYwKIfEbVl+uUbSyOz9Sh3lUB3gGPwUOcA==
X-Received: by 2002:a05:6808:1812:b0:3eb:5980:45d3 with SMTP id
 5614622812f47-3eccbf2d203mr1876508b6e.9.1734529406241; 
 Wed, 18 Dec 2024 05:43:26 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 20/24] include/hw/qdev-properties: Remove
 DEFINE_PROP_END_OF_LIST
Date: Wed, 18 Dec 2024 07:42:47 -0600
Message-ID: <20241218134251.4724-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Now that all of the Property arrays are counted, we can remove
the terminator object from each array.  Update the assertions
in device_class_set_props to match.

With struct Property being 88 bytes, this was a rather large
form of terminator.  Saves 30k from qemu-system-aarch64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-core.h                 | 12 ++++++------
 include/hw/qdev-properties.h           |  3 ---
 cpu-target.c                           |  1 -
 hw/9pfs/virtio-9p-device.c             |  1 -
 hw/acpi/erst.c                         |  1 -
 hw/acpi/generic_event_device.c         |  1 -
 hw/acpi/piix4.c                        |  1 -
 hw/acpi/vmgenid.c                      |  1 -
 hw/adc/aspeed_adc.c                    |  1 -
 hw/adc/npcm7xx_adc.c                   |  1 -
 hw/arm/armv7m.c                        |  2 --
 hw/arm/aspeed_soc_common.c             |  1 -
 hw/arm/fsl-imx25.c                     |  1 -
 hw/arm/fsl-imx6.c                      |  1 -
 hw/arm/fsl-imx6ul.c                    |  1 -
 hw/arm/fsl-imx7.c                      |  1 -
 hw/arm/integratorcp.c                  |  1 -
 hw/arm/msf2-soc.c                      |  1 -
 hw/arm/npcm7xx.c                       |  1 -
 hw/arm/nrf51_soc.c                     |  1 -
 hw/arm/smmu-common.c                   |  1 -
 hw/arm/smmuv3.c                        |  1 -
 hw/arm/stellaris.c                     |  1 -
 hw/arm/strongarm.c                     |  1 -
 hw/arm/xlnx-versal.c                   |  1 -
 hw/arm/xlnx-zynqmp.c                   |  1 -
 hw/audio/ac97.c                        |  1 -
 hw/audio/adlib.c                       |  1 -
 hw/audio/asc.c                         |  1 -
 hw/audio/cs4231a.c                     |  1 -
 hw/audio/es1370.c                      |  1 -
 hw/audio/gus.c                         |  1 -
 hw/audio/hda-codec.c                   |  1 -
 hw/audio/intel-hda.c                   |  2 --
 hw/audio/pcspk.c                       |  1 -
 hw/audio/pl041.c                       |  1 -
 hw/audio/sb16.c                        |  1 -
 hw/audio/via-ac97.c                    |  1 -
 hw/audio/virtio-snd-pci.c              |  1 -
 hw/audio/virtio-snd.c                  |  1 -
 hw/audio/wm8750.c                      |  1 -
 hw/avr/atmega.c                        |  1 -
 hw/block/fdc-isa.c                     |  1 -
 hw/block/fdc-sysbus.c                  |  2 --
 hw/block/fdc.c                         |  1 -
 hw/block/m25p80.c                      |  1 -
 hw/block/nand.c                        |  1 -
 hw/block/pflash_cfi01.c                |  1 -
 hw/block/pflash_cfi02.c                |  1 -
 hw/block/swim.c                        |  1 -
 hw/block/vhost-user-blk.c              |  1 -
 hw/block/virtio-blk.c                  |  1 -
 hw/block/xen-block.c                   |  1 -
 hw/char/avr_usart.c                    |  1 -
 hw/char/bcm2835_aux.c                  |  1 -
 hw/char/cadence_uart.c                 |  1 -
 hw/char/cmsdk-apb-uart.c               |  1 -
 hw/char/debugcon.c                     |  1 -
 hw/char/digic-uart.c                   |  1 -
 hw/char/escc.c                         |  1 -
 hw/char/exynos4210_uart.c              |  1 -
 hw/char/goldfish_tty.c                 |  1 -
 hw/char/grlib_apbuart.c                |  1 -
 hw/char/ibex_uart.c                    |  1 -
 hw/char/imx_serial.c                   |  1 -
 hw/char/ipoctal232.c                   |  1 -
 hw/char/mcf_uart.c                     |  1 -
 hw/char/nrf51_uart.c                   |  1 -
 hw/char/parallel.c                     |  1 -
 hw/char/pl011.c                        |  1 -
 hw/char/renesas_sci.c                  |  1 -
 hw/char/sclpconsole-lm.c               |  1 -
 hw/char/sclpconsole.c                  |  1 -
 hw/char/serial-isa.c                   |  1 -
 hw/char/serial-mm.c                    |  1 -
 hw/char/serial-pci-multi.c             |  2 --
 hw/char/serial-pci.c                   |  1 -
 hw/char/serial.c                       |  1 -
 hw/char/sh_serial.c                    |  1 -
 hw/char/shakti_uart.c                  |  1 -
 hw/char/sifive_uart.c                  |  1 -
 hw/char/spapr_vty.c                    |  1 -
 hw/char/stm32f2xx_usart.c              |  1 -
 hw/char/stm32l4x5_usart.c              |  1 -
 hw/char/terminal3270.c                 |  1 -
 hw/char/virtio-console.c               |  1 -
 hw/char/virtio-serial-bus.c            |  2 --
 hw/char/xen_console.c                  |  1 -
 hw/char/xilinx_uartlite.c              |  1 -
 hw/core/generic-loader.c               |  1 -
 hw/core/guest-loader.c                 |  1 -
 hw/core/or-irq.c                       |  1 -
 hw/core/platform-bus.c                 |  1 -
 hw/core/split-irq.c                    |  1 -
 hw/cpu/a15mpcore.c                     |  1 -
 hw/cpu/a9mpcore.c                      |  1 -
 hw/cpu/arm11mpcore.c                   |  1 -
 hw/cpu/cluster.c                       |  1 -
 hw/cpu/realview_mpcore.c               |  1 -
 hw/cxl/switch-mailbox-cci.c            |  1 -
 hw/display/artist.c                    |  1 -
 hw/display/ati.c                       |  1 -
 hw/display/bcm2835_fb.c                |  1 -
 hw/display/bochs-display.c             |  1 -
 hw/display/cg3.c                       |  1 -
 hw/display/cirrus_vga.c                |  1 -
 hw/display/cirrus_vga_isa.c            |  1 -
 hw/display/exynos4210_fimd.c           |  1 -
 hw/display/g364fb.c                    |  1 -
 hw/display/i2c-ddc.c                   |  1 -
 hw/display/macfb.c                     |  2 --
 hw/display/pl110.c                     |  1 -
 hw/display/qxl.c                       |  1 -
 hw/display/ramfb-standalone.c          |  1 -
 hw/display/sm501.c                     |  2 --
 hw/display/tcx.c                       |  1 -
 hw/display/vga-isa.c                   |  1 -
 hw/display/vga-mmio.c                  |  1 -
 hw/display/vga-pci.c                   |  2 --
 hw/display/vhost-user-gpu.c            |  1 -
 hw/display/virtio-gpu-gl.c             |  1 -
 hw/display/virtio-gpu-pci.c            |  1 -
 hw/display/virtio-gpu-rutabaga.c       |  1 -
 hw/display/virtio-gpu.c                |  1 -
 hw/display/virtio-vga.c                |  1 -
 hw/display/vmware_vga.c                |  1 -
 hw/display/xlnx_dp.c                   |  1 -
 hw/dma/i82374.c                        |  1 -
 hw/dma/i8257.c                         |  1 -
 hw/dma/pl080.c                         |  1 -
 hw/dma/pl330.c                         |  2 --
 hw/dma/xilinx_axidma.c                 |  1 -
 hw/dma/xlnx-zdma.c                     |  1 -
 hw/dma/xlnx_csu_dma.c                  |  1 -
 hw/gpio/imx_gpio.c                     |  1 -
 hw/gpio/npcm7xx_gpio.c                 |  1 -
 hw/gpio/omap_gpio.c                    |  1 -
 hw/gpio/pca9552.c                      |  1 -
 hw/gpio/pca9554.c                      |  1 -
 hw/gpio/pl061.c                        |  1 -
 hw/gpio/sifive_gpio.c                  |  1 -
 hw/gpio/stm32l4x5_gpio.c               |  1 -
 hw/hyperv/hv-balloon.c                 |  2 --
 hw/hyperv/syndbg.c                     |  1 -
 hw/hyperv/vmbus.c                      |  2 --
 hw/i2c/aspeed_i2c.c                    |  2 --
 hw/i2c/core.c                          |  1 -
 hw/i2c/i2c_mux_pca954x.c               |  1 -
 hw/i2c/omap_i2c.c                      |  1 -
 hw/i386/amd_iommu.c                    |  1 -
 hw/i386/intel_iommu.c                  |  1 -
 hw/i386/kvm/clock.c                    |  1 -
 hw/i386/kvm/i8254.c                    |  1 -
 hw/i386/kvm/ioapic.c                   |  1 -
 hw/i386/sgx-epc.c                      |  1 -
 hw/i386/vmmouse.c                      |  1 -
 hw/i386/vmport.c                       |  2 --
 hw/i386/x86-iommu.c                    |  1 -
 hw/i386/xen/xen_pvdevice.c             |  1 -
 hw/ide/ahci-sysbus.c                   |  1 -
 hw/ide/cf.c                            |  1 -
 hw/ide/cmd646.c                        |  1 -
 hw/ide/ide-dev.c                       |  3 ---
 hw/ide/isa.c                           |  1 -
 hw/ide/macio.c                         |  1 -
 hw/ide/mmio.c                          |  1 -
 hw/input/pckbd.c                       |  2 --
 hw/input/stellaris_gamepad.c           |  1 -
 hw/input/virtio-input-hid.c            |  3 ---
 hw/input/virtio-input-host.c           |  1 -
 hw/input/virtio-input.c                |  1 -
 hw/intc/apic_common.c                  |  1 -
 hw/intc/arm_gic_common.c               |  1 -
 hw/intc/arm_gicv2m.c                   |  1 -
 hw/intc/arm_gicv3_common.c             |  1 -
 hw/intc/arm_gicv3_its.c                |  1 -
 hw/intc/arm_gicv3_its_kvm.c            |  1 -
 hw/intc/armv7m_nvic.c                  |  1 -
 hw/intc/exynos4210_combiner.c          |  1 -
 hw/intc/exynos4210_gic.c               |  1 -
 hw/intc/goldfish_pic.c                 |  1 -
 hw/intc/grlib_irqmp.c                  |  1 -
 hw/intc/i8259_common.c                 |  1 -
 hw/intc/ioapic.c                       |  1 -
 hw/intc/loongarch_extioi.c             |  1 -
 hw/intc/loongarch_pch_msi.c            |  1 -
 hw/intc/loongarch_pch_pic.c            |  1 -
 hw/intc/loongson_ipi_common.c          |  1 -
 hw/intc/m68k_irqc.c                    |  1 -
 hw/intc/mips_gic.c                     |  1 -
 hw/intc/omap_intc.c                    |  1 -
 hw/intc/ompic.c                        |  1 -
 hw/intc/openpic.c                      |  1 -
 hw/intc/openpic_kvm.c                  |  1 -
 hw/intc/pnv_xive.c                     |  1 -
 hw/intc/pnv_xive2.c                    |  1 -
 hw/intc/ppc-uic.c                      |  1 -
 hw/intc/riscv_aclint.c                 |  2 --
 hw/intc/riscv_aplic.c                  |  1 -
 hw/intc/riscv_imsic.c                  |  1 -
 hw/intc/rx_icu.c                       |  1 -
 hw/intc/s390_flic.c                    |  2 --
 hw/intc/sifive_plic.c                  |  1 -
 hw/intc/spapr_xive.c                   |  1 -
 hw/intc/xics.c                         |  2 --
 hw/intc/xilinx_intc.c                  |  1 -
 hw/intc/xive.c                         |  4 ----
 hw/intc/xive2.c                        |  2 --
 hw/intc/xlnx-pmu-iomod-intc.c          |  1 -
 hw/ipack/ipack.c                       |  1 -
 hw/ipmi/ipmi.c                         |  1 -
 hw/ipmi/ipmi_bmc_extern.c              |  1 -
 hw/ipmi/ipmi_bmc_sim.c                 |  1 -
 hw/ipmi/isa_ipmi_bt.c                  |  1 -
 hw/ipmi/isa_ipmi_kcs.c                 |  1 -
 hw/isa/lpc_ich9.c                      |  1 -
 hw/isa/pc87312.c                       |  1 -
 hw/isa/piix.c                          |  1 -
 hw/m68k/mcf5206.c                      |  1 -
 hw/m68k/mcf_intc.c                     |  1 -
 hw/m68k/next-cube.c                    |  1 -
 hw/m68k/q800-glue.c                    |  1 -
 hw/mem/cxl_type3.c                     |  1 -
 hw/mem/nvdimm.c                        |  1 -
 hw/mem/pc-dimm.c                       |  1 -
 hw/mem/sparse-mem.c                    |  1 -
 hw/mips/cps.c                          |  1 -
 hw/misc/a9scu.c                        |  1 -
 hw/misc/allwinner-h3-dramc.c           |  1 -
 hw/misc/allwinner-r40-dramc.c          |  1 -
 hw/misc/allwinner-sid.c                |  1 -
 hw/misc/applesmc.c                     |  1 -
 hw/misc/arm11scu.c                     |  1 -
 hw/misc/arm_l2x0.c                     |  1 -
 hw/misc/arm_sysctl.c                   |  1 -
 hw/misc/armsse-cpuid.c                 |  1 -
 hw/misc/aspeed_hace.c                  |  1 -
 hw/misc/aspeed_i3c.c                   |  1 -
 hw/misc/aspeed_lpc.c                   |  1 -
 hw/misc/aspeed_sbc.c                   |  1 -
 hw/misc/aspeed_scu.c                   |  1 -
 hw/misc/aspeed_sdmc.c                  |  1 -
 hw/misc/bcm2835_cprman.c               |  1 -
 hw/misc/bcm2835_property.c             |  1 -
 hw/misc/debugexit.c                    |  1 -
 hw/misc/eccmemctl.c                    |  1 -
 hw/misc/empty_slot.c                   |  1 -
 hw/misc/iotkit-secctl.c                |  1 -
 hw/misc/iotkit-sysctl.c                |  1 -
 hw/misc/iotkit-sysinfo.c               |  1 -
 hw/misc/ivshmem.c                      |  2 --
 hw/misc/led.c                          |  1 -
 hw/misc/mac_via.c                      |  1 -
 hw/misc/macio/cuda.c                   |  1 -
 hw/misc/macio/macio.c                  |  2 --
 hw/misc/macio/pmu.c                    |  1 -
 hw/misc/mips_cmgcr.c                   |  1 -
 hw/misc/mips_cpc.c                     |  1 -
 hw/misc/mips_itu.c                     |  1 -
 hw/misc/mos6522.c                      |  1 -
 hw/misc/mps2-fpgaio.c                  |  1 -
 hw/misc/mps2-scc.c                     |  1 -
 hw/misc/msf2-sysreg.c                  |  1 -
 hw/misc/npcm7xx_gcr.c                  |  1 -
 hw/misc/nrf51_rng.c                    |  1 -
 hw/misc/pci-testdev.c                  |  1 -
 hw/misc/pvpanic-isa.c                  |  1 -
 hw/misc/pvpanic-pci.c                  |  1 -
 hw/misc/sifive_e_aon.c                 |  1 -
 hw/misc/sifive_u_otp.c                 |  1 -
 hw/misc/stm32l4x5_rcc.c                |  1 -
 hw/misc/tz-mpc.c                       |  1 -
 hw/misc/tz-msc.c                       |  1 -
 hw/misc/tz-ppc.c                       |  1 -
 hw/misc/unimp.c                        |  1 -
 hw/misc/xlnx-versal-cframe-reg.c       |  2 --
 hw/misc/xlnx-versal-cfu.c              |  2 --
 hw/misc/xlnx-versal-trng.c             |  2 --
 hw/misc/xlnx-versal-xramc.c            |  1 -
 hw/misc/zynq_slcr.c                    |  1 -
 hw/net/allwinner-sun8i-emac.c          |  1 -
 hw/net/allwinner_emac.c                |  1 -
 hw/net/cadence_gem.c                   |  1 -
 hw/net/can/xlnx-versal-canfd.c         |  1 -
 hw/net/can/xlnx-zynqmp-can.c           |  1 -
 hw/net/dp8393x.c                       |  1 -
 hw/net/e1000.c                         |  1 -
 hw/net/e1000e.c                        |  1 -
 hw/net/eepro100.c                      |  1 -
 hw/net/fsl_etsec/etsec.c               |  1 -
 hw/net/ftgmac100.c                     |  2 --
 hw/net/igb.c                           |  1 -
 hw/net/imx_fec.c                       |  1 -
 hw/net/lan9118.c                       |  1 -
 hw/net/lance.c                         |  1 -
 hw/net/lasi_i82596.c                   |  1 -
 hw/net/mcf_fec.c                       |  1 -
 hw/net/mipsnet.c                       |  1 -
 hw/net/msf2-emac.c                     |  1 -
 hw/net/mv88w8618_eth.c                 |  1 -
 hw/net/ne2000-isa.c                    |  1 -
 hw/net/ne2000-pci.c                    |  1 -
 hw/net/npcm7xx_emc.c                   |  1 -
 hw/net/npcm_gmac.c                     |  1 -
 hw/net/opencores_eth.c                 |  1 -
 hw/net/pcnet-pci.c                     |  1 -
 hw/net/rocker/rocker.c                 |  1 -
 hw/net/rtl8139.c                       |  1 -
 hw/net/smc91c111.c                     |  1 -
 hw/net/spapr_llan.c                    |  1 -
 hw/net/stellaris_enet.c                |  1 -
 hw/net/sungem.c                        |  1 -
 hw/net/sunhme.c                        |  1 -
 hw/net/tulip.c                         |  1 -
 hw/net/virtio-net.c                    |  1 -
 hw/net/vmxnet3.c                       |  1 -
 hw/net/xen_nic.c                       |  1 -
 hw/net/xgmac.c                         |  1 -
 hw/net/xilinx_axienet.c                |  1 -
 hw/net/xilinx_ethlite.c                |  1 -
 hw/nubus/nubus-bridge.c                |  1 -
 hw/nubus/nubus-device.c                |  1 -
 hw/nvme/ctrl.c                         |  1 -
 hw/nvme/ns.c                           |  1 -
 hw/nvme/subsys.c                       |  1 -
 hw/nvram/ds1225y.c                     |  1 -
 hw/nvram/eeprom_at24c.c                |  1 -
 hw/nvram/fw_cfg.c                      |  3 ---
 hw/nvram/mac_nvram.c                   |  1 -
 hw/nvram/nrf51_nvm.c                   |  1 -
 hw/nvram/spapr_nvram.c                 |  1 -
 hw/nvram/xlnx-bbram.c                  |  1 -
 hw/nvram/xlnx-efuse.c                  |  1 -
 hw/nvram/xlnx-versal-efuse-cache.c     |  2 --
 hw/nvram/xlnx-versal-efuse-ctrl.c      |  2 --
 hw/nvram/xlnx-zynqmp-efuse.c           |  2 --
 hw/pci-bridge/cxl_downstream.c         |  1 -
 hw/pci-bridge/cxl_root_port.c          |  1 -
 hw/pci-bridge/cxl_upstream.c           |  1 -
 hw/pci-bridge/gen_pcie_root_port.c     |  1 -
 hw/pci-bridge/pci_bridge_dev.c         |  1 -
 hw/pci-bridge/pci_expander_bridge.c    |  2 --
 hw/pci-bridge/pcie_pci_bridge.c        |  1 -
 hw/pci-bridge/pcie_root_port.c         |  1 -
 hw/pci-bridge/xio3130_downstream.c     |  1 -
 hw/pci-host/dino.c                     |  1 -
 hw/pci-host/gpex.c                     |  1 -
 hw/pci-host/grackle.c                  |  1 -
 hw/pci-host/gt64120.c                  |  1 -
 hw/pci-host/i440fx.c                   |  1 -
 hw/pci-host/mv64361.c                  |  1 -
 hw/pci-host/pnv_phb.c                  |  4 ----
 hw/pci-host/pnv_phb3.c                 |  1 -
 hw/pci-host/pnv_phb4.c                 |  1 -
 hw/pci-host/pnv_phb4_pec.c             |  1 -
 hw/pci-host/ppce500.c                  |  1 -
 hw/pci-host/q35.c                      |  2 --
 hw/pci-host/raven.c                    |  1 -
 hw/pci-host/sabre.c                    |  1 -
 hw/pci-host/uninorth.c                 |  1 -
 hw/pci-host/versatile.c                |  1 -
 hw/pci-host/xilinx-pcie.c              |  1 -
 hw/pci/pci.c                           |  1 -
 hw/pci/pci_bridge.c                    |  1 -
 hw/pci/pci_host.c                      |  1 -
 hw/pci/pcie_port.c                     |  2 --
 hw/ppc/pnv.c                           |  1 -
 hw/ppc/pnv_adu.c                       |  1 -
 hw/ppc/pnv_chiptod.c                   |  1 -
 hw/ppc/pnv_core.c                      |  2 --
 hw/ppc/pnv_homer.c                     |  1 -
 hw/ppc/pnv_i2c.c                       |  1 -
 hw/ppc/pnv_lpc.c                       |  1 -
 hw/ppc/pnv_pnor.c                      |  1 -
 hw/ppc/pnv_psi.c                       |  1 -
 hw/ppc/ppc405_uc.c                     |  1 -
 hw/ppc/ppc440_uc.c                     |  1 -
 hw/ppc/ppc4xx_devs.c                   |  2 --
 hw/ppc/ppc4xx_sdram.c                  |  2 --
 hw/ppc/prep_systemio.c                 |  1 -
 hw/ppc/rs6000_mc.c                     |  1 -
 hw/ppc/spapr_cpu_core.c                |  1 -
 hw/ppc/spapr_nvdimm.c                  |  1 -
 hw/ppc/spapr_pci.c                     |  1 -
 hw/ppc/spapr_rng.c                     |  1 -
 hw/ppc/spapr_tpm_proxy.c               |  1 -
 hw/remote/proxy.c                      |  1 -
 hw/riscv/opentitan.c                   |  1 -
 hw/riscv/riscv-iommu-pci.c             |  1 -
 hw/riscv/riscv-iommu.c                 |  1 -
 hw/riscv/riscv_hart.c                  |  1 -
 hw/riscv/sifive_u.c                    |  1 -
 hw/rtc/allwinner-rtc.c                 |  1 -
 hw/rtc/goldfish_rtc.c                  |  1 -
 hw/rtc/m48t59-isa.c                    |  1 -
 hw/rtc/m48t59.c                        |  1 -
 hw/rtc/mc146818rtc.c                   |  1 -
 hw/rtc/pl031.c                         |  1 -
 hw/rx/rx62n.c                          |  1 -
 hw/s390x/ccw-device.c                  |  1 -
 hw/s390x/css-bridge.c                  |  1 -
 hw/s390x/ipl.c                         |  1 -
 hw/s390x/s390-pci-bus.c                |  1 -
 hw/s390x/s390-skeys.c                  |  1 -
 hw/s390x/s390-stattrib.c               |  1 -
 hw/s390x/vhost-scsi-ccw.c              |  1 -
 hw/s390x/vhost-user-fs-ccw.c           |  1 -
 hw/s390x/vhost-vsock-ccw.c             |  1 -
 hw/s390x/virtio-ccw-9p.c               |  1 -
 hw/s390x/virtio-ccw-balloon.c          |  1 -
 hw/s390x/virtio-ccw-blk.c              |  1 -
 hw/s390x/virtio-ccw-crypto.c           |  1 -
 hw/s390x/virtio-ccw-gpu.c              |  1 -
 hw/s390x/virtio-ccw-input.c            |  1 -
 hw/s390x/virtio-ccw-net.c              |  1 -
 hw/s390x/virtio-ccw-rng.c              |  1 -
 hw/s390x/virtio-ccw-scsi.c             |  1 -
 hw/s390x/virtio-ccw-serial.c           |  1 -
 hw/scsi/mptsas.c                       |  1 -
 hw/scsi/scsi-bus.c                     |  1 -
 hw/scsi/scsi-disk.c                    |  3 ---
 hw/scsi/scsi-generic.c                 |  1 -
 hw/scsi/spapr_vscsi.c                  |  1 -
 hw/scsi/vhost-scsi.c                   |  1 -
 hw/scsi/vhost-user-scsi.c              |  1 -
 hw/scsi/virtio-scsi.c                  |  1 -
 hw/scsi/vmw_pvscsi.c                   |  1 -
 hw/sd/allwinner-sdhost.c               |  1 -
 hw/sd/aspeed_sdhci.c                   |  1 -
 hw/sd/sd.c                             |  3 ---
 hw/sd/sdhci-pci.c                      |  1 -
 hw/sd/sdhci.c                          |  1 -
 hw/sparc/sun4m_iommu.c                 |  1 -
 hw/sparc64/sun4u.c                     |  2 --
 hw/ssi/aspeed_smc.c                    |  2 --
 hw/ssi/ibex_spi_host.c                 |  1 -
 hw/ssi/npcm7xx_fiu.c                   |  1 -
 hw/ssi/pnv_spi.c                       |  1 -
 hw/ssi/sifive_spi.c                    |  1 -
 hw/ssi/ssi.c                           |  1 -
 hw/ssi/xilinx_spi.c                    |  1 -
 hw/ssi/xilinx_spips.c                  |  2 --
 hw/ssi/xlnx-versal-ospi.c              |  1 -
 hw/timer/a9gtimer.c                    |  1 -
 hw/timer/allwinner-a10-pit.c           |  1 -
 hw/timer/arm_mptimer.c                 |  1 -
 hw/timer/arm_timer.c                   |  1 -
 hw/timer/aspeed_timer.c                |  1 -
 hw/timer/avr_timer16.c                 |  1 -
 hw/timer/grlib_gptimer.c               |  1 -
 hw/timer/hpet.c                        |  1 -
 hw/timer/i8254_common.c                |  1 -
 hw/timer/ibex_timer.c                  |  1 -
 hw/timer/mss-timer.c                   |  1 -
 hw/timer/nrf51_timer.c                 |  1 -
 hw/timer/pxa2xx_timer.c                |  1 -
 hw/timer/renesas_cmt.c                 |  1 -
 hw/timer/renesas_tmr.c                 |  1 -
 hw/timer/sifive_pwm.c                  |  1 -
 hw/timer/slavio_timer.c                |  1 -
 hw/timer/sse-timer.c                   |  1 -
 hw/timer/stm32f2xx_timer.c             |  1 -
 hw/timer/xilinx_timer.c                |  1 -
 hw/tpm/tpm_crb.c                       |  1 -
 hw/tpm/tpm_spapr.c                     |  1 -
 hw/tpm/tpm_tis_i2c.c                   |  1 -
 hw/tpm/tpm_tis_isa.c                   |  1 -
 hw/tpm/tpm_tis_sysbus.c                |  1 -
 hw/ufs/lu.c                            |  1 -
 hw/ufs/ufs.c                           |  1 -
 hw/usb/bus.c                           |  1 -
 hw/usb/canokey.c                       |  1 -
 hw/usb/ccid-card-emulated.c            |  1 -
 hw/usb/ccid-card-passthru.c            |  1 -
 hw/usb/dev-audio.c                     |  1 -
 hw/usb/dev-hid.c                       |  3 ---
 hw/usb/dev-hub.c                       |  1 -
 hw/usb/dev-mtp.c                       |  1 -
 hw/usb/dev-network.c                   |  1 -
 hw/usb/dev-serial.c                    |  2 --
 hw/usb/dev-smartcard-reader.c          |  2 --
 hw/usb/dev-storage-classic.c           |  1 -
 hw/usb/dev-uas.c                       |  1 -
 hw/usb/hcd-dwc2.c                      |  1 -
 hw/usb/hcd-dwc3.c                      |  1 -
 hw/usb/hcd-ehci-pci.c                  |  1 -
 hw/usb/hcd-ehci-sysbus.c               |  1 -
 hw/usb/hcd-ohci-pci.c                  |  1 -
 hw/usb/hcd-ohci-sysbus.c               |  1 -
 hw/usb/hcd-uhci.c                      |  2 --
 hw/usb/hcd-xhci-nec.c                  |  1 -
 hw/usb/hcd-xhci-sysbus.c               |  1 -
 hw/usb/hcd-xhci.c                      |  1 -
 hw/usb/host-libusb.c                   |  1 -
 hw/usb/redirect.c                      |  1 -
 hw/usb/u2f-emulated.c                  |  1 -
 hw/usb/u2f-passthru.c                  |  1 -
 hw/vfio/ap.c                           |  1 -
 hw/vfio/ccw.c                          |  1 -
 hw/vfio/pci.c                          |  2 --
 hw/vfio/platform.c                     |  1 -
 hw/virtio/vdpa-dev.c                   |  1 -
 hw/virtio/vhost-scsi-pci.c             |  1 -
 hw/virtio/vhost-user-blk-pci.c         |  1 -
 hw/virtio/vhost-user-device.c          |  1 -
 hw/virtio/vhost-user-fs-pci.c          |  1 -
 hw/virtio/vhost-user-fs.c              |  1 -
 hw/virtio/vhost-user-gpio.c            |  1 -
 hw/virtio/vhost-user-i2c.c             |  1 -
 hw/virtio/vhost-user-input.c           |  1 -
 hw/virtio/vhost-user-rng-pci.c         |  1 -
 hw/virtio/vhost-user-rng.c             |  1 -
 hw/virtio/vhost-user-scmi.c            |  1 -
 hw/virtio/vhost-user-scsi-pci.c        |  1 -
 hw/virtio/vhost-user-snd.c             |  1 -
 hw/virtio/vhost-user-vsock-pci.c       |  1 -
 hw/virtio/vhost-user-vsock.c           |  1 -
 hw/virtio/vhost-vsock-common.c         |  1 -
 hw/virtio/vhost-vsock-pci.c            |  1 -
 hw/virtio/vhost-vsock.c                |  1 -
 hw/virtio/virtio-9p-pci.c              |  1 -
 hw/virtio/virtio-balloon.c             |  1 -
 hw/virtio/virtio-blk-pci.c             |  1 -
 hw/virtio/virtio-crypto-pci.c          |  1 -
 hw/virtio/virtio-crypto.c              |  1 -
 hw/virtio/virtio-input-pci.c           |  1 -
 hw/virtio/virtio-iommu-pci.c           |  1 -
 hw/virtio/virtio-iommu.c               |  1 -
 hw/virtio/virtio-mem.c                 |  1 -
 hw/virtio/virtio-mmio.c                |  1 -
 hw/virtio/virtio-net-pci.c             |  1 -
 hw/virtio/virtio-nsm.c                 |  1 -
 hw/virtio/virtio-pci.c                 |  2 --
 hw/virtio/virtio-pmem.c                |  1 -
 hw/virtio/virtio-rng-pci.c             |  1 -
 hw/virtio/virtio-rng.c                 |  1 -
 hw/virtio/virtio-scsi-pci.c            |  1 -
 hw/virtio/virtio-serial-pci.c          |  1 -
 hw/virtio/virtio.c                     |  1 -
 hw/watchdog/sbsa_gwdt.c                |  1 -
 hw/watchdog/wdt_aspeed.c               |  1 -
 hw/watchdog/wdt_imx2.c                 |  1 -
 hw/xen/xen-bus.c                       |  1 -
 hw/xen/xen_pt.c                        |  1 -
 target/arm/cpu.c                       |  1 -
 target/avr/cpu.c                       |  1 -
 target/hexagon/cpu.c                   |  1 -
 target/i386/cpu.c                      |  2 --
 target/microblaze/cpu.c                |  1 -
 target/mips/cpu.c                      |  1 -
 target/riscv/cpu.c                     |  1 -
 target/s390x/cpu.c                     |  1 -
 target/sparc/cpu.c                     |  1 -
 tests/unit/test-qdev-global-props.c    |  1 -
 docs/devel/migration/compatibility.rst |  1 -
 docs/devel/virtio-backends.rst         |  1 -
 556 files changed, 6 insertions(+), 623 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index fc13623d43..c404bf5555 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -941,7 +941,7 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
 /**
  * device_class_set_props(): add a set of properties to an device
  * @dc: the parent DeviceClass all devices inherit
- * @props: an array of properties, terminate by DEFINE_PROP_END_OF_LIST()
+ * @props: an array of properties
  *
  * This will add a set of properties to the object. It will fault if
  * you attempt to add an existing property defined by a parent class.
@@ -949,14 +949,14 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
  *
  * Validate that @props has at least one Property plus the terminator.
  * Validate that @props is an array via ARRAY_SIZE.
- * Validate that the array is terminated at compile-time (with -O2),
- * which requires the array to be const.
+ * Validate that the array does not have a legacy terminator at compile-time;
+ * requires -O2 and the array to be const.
  */
 #define device_class_set_props(dc, props) \
     do {                                                                \
         QEMU_BUILD_BUG_ON(sizeof(props) == 0);                          \
-        size_t props_count_ = ARRAY_SIZE(props) - 1;                    \
-        if ((props)[props_count_].name != NULL) {                       \
+        size_t props_count_ = ARRAY_SIZE(props);                        \
+        if ((props)[props_count_ - 1].name == NULL) {                   \
             qemu_build_not_reached();                                   \
         }                                                               \
         device_class_set_props_n((dc), (props), props_count_);          \
@@ -965,7 +965,7 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
 /**
  * device_class_set_props_n(): add a set of properties to an device
  * @dc: the parent DeviceClass all devices inherit
- * @props: an array of properties, not terminated by DEFINE_PROP_END_OF_LIST.
+ * @props: an array of properties
  * @n: ARRAY_SIZE(@props)
  *
  * This will add a set of properties to the object. It will fault if
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 26ebd23068..ef3fd7b4ae 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -171,9 +171,6 @@ extern const PropertyInfo qdev_prop_link;
 #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
 
-#define DEFINE_PROP_END_OF_LIST()               \
-    {}
-
 /*
  * Set properties between creation and realization.
  *
diff --git a/cpu-target.c b/cpu-target.c
index 2ae07a779e..6af34098b9 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -201,7 +201,6 @@ static const Property cpu_common_props[] = {
     DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
 #endif
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index b764e4cd3d..ef0d845109 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -246,7 +246,6 @@ static const VMStateDescription vmstate_virtio_9p = {
 static const Property virtio_9p_properties[] = {
     DEFINE_PROP_STRING("mount_tag", V9fsVirtioState, state.fsconf.tag),
     DEFINE_PROP_STRING("fsdev", V9fsVirtioState, state.fsconf.fsdev_id),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_9p_class_init(ObjectClass *klass, void *data)
diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index 5ef5ddccb6..dfa0f37176 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -1016,7 +1016,6 @@ static const Property erst_properties[] = {
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_UINT32(ACPI_ERST_RECORD_SIZE_PROP, ERSTDeviceState,
                      default_record_size, ERST_RECORD_SIZE),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void erst_class_init(ObjectClass *klass, void *data)
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 8c4706f8cf..cfb14299b6 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -318,7 +318,6 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
 
 static const Property acpi_ged_properties[] = {
     DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_memhp_state = {
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 2bfaf5a38d..cc755b36eb 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -617,7 +617,6 @@ static const Property piix4_pm_properties[] = {
     DEFINE_PROP_BOOL("smm-enabled", PIIX4PMState, smm_enabled, false),
     DEFINE_PROP_BOOL("x-not-migrate-acpi-index", PIIX4PMState,
                       not_migrate_acpi_index, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void piix4_pm_class_init(ObjectClass *klass, void *data)
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 9c2ca85cc7..af3ec85989 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -216,7 +216,6 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
 
 static const Property vmgenid_device_properties[] = {
     DEFINE_PROP_UUID(VMGENID_GUID, VmGenIdState, guid),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vmgenid_device_class_init(ObjectClass *klass, void *data)
diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
index f94c6f2be3..1cc554f179 100644
--- a/hw/adc/aspeed_adc.c
+++ b/hw/adc/aspeed_adc.c
@@ -289,7 +289,6 @@ static const VMStateDescription vmstate_aspeed_adc_engine = {
 static const Property aspeed_adc_engine_properties[] = {
     DEFINE_PROP_UINT32("engine-id", AspeedADCEngineState, engine_id, 0),
     DEFINE_PROP_UINT32("nr-channels", AspeedADCEngineState, nr_channels, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_adc_engine_class_init(ObjectClass *klass, void *data)
diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index 1781ff4c0b..0a83d28605 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -269,7 +269,6 @@ static const VMStateDescription vmstate_npcm7xx_adc = {
 
 static const Property npcm7xx_timer_properties[] = {
     DEFINE_PROP_UINT32("iref", NPCM7xxADCState, iref, NPCM7XX_ADC_DEFAULT_IREF),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void npcm7xx_adc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index e20f719c9b..1134606fc2 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -552,7 +552,6 @@ static const Property armv7m_properties[] = {
     DEFINE_PROP_BOOL("dsp", ARMv7MState, dsp, true),
     DEFINE_PROP_UINT32("mpu-ns-regions", ARMv7MState, mpu_ns_regions, UINT_MAX),
     DEFINE_PROP_UINT32("mpu-s-regions", ARMv7MState, mpu_s_regions, UINT_MAX),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_armv7m = {
@@ -635,7 +634,6 @@ static const Property bitband_properties[] = {
     DEFINE_PROP_UINT32("base", BitBandState, base, 0),
     DEFINE_PROP_LINK("source-memory", BitBandState, source_memory,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void bitband_class_init(ObjectClass *klass, void *data)
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 4221cacd51..1ddcb26c1e 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -144,7 +144,6 @@ static const Property aspeed_soc_properties[] = {
                      MemoryRegion *),
     DEFINE_PROP_LINK("memory", AspeedSoCState, memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 48763b03fe..ef1242d0a0 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -311,7 +311,6 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
 static const Property fsl_imx25_properties[] = {
     DEFINE_PROP_UINT32("fec-phy-num", FslIMX25State, phy_num, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void fsl_imx25_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 236d15bc9c..fed2dbb46d 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -483,7 +483,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
 static const Property fsl_imx6_properties[] = {
     DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void fsl_imx6_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 1e0bbbb5d7..6995746f64 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -725,7 +725,6 @@ static const Property fsl_imx6ul_properties[] = {
                      true),
     DEFINE_PROP_BOOL("fec2-phy-connected", FslIMX6ULState, phy_connected[1],
                      true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void fsl_imx6ul_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 0310c15b0c..55b3b3d3c2 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -743,7 +743,6 @@ static const Property fsl_imx7_properties[] = {
                      true),
     DEFINE_PROP_BOOL("fec2-phy-connected", FslIMX7State, phy_connected[1],
                      true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void fsl_imx7_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index ee6c7e0c0d..64025bac64 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -696,7 +696,6 @@ DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void core_class_init(ObjectClass *klass, void *data)
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 5d7c3f2e5a..224530f4da 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -234,7 +234,6 @@ static const Property m2sxxx_soc_properties[] = {
     /* default divisors in Libero GUI */
     DEFINE_PROP_UINT8("apb0div", MSF2State, apb0div, 2),
     DEFINE_PROP_UINT8("apb1div", MSF2State, apb1div, 2),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void m2sxxx_soc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 2960b63b59..780936493e 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -813,7 +813,6 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
 static const Property npcm7xx_properties[] = {
     DEFINE_PROP_LINK("dram-mr", NPCM7xxState, dram, TYPE_MEMORY_REGION,
                      MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void npcm7xx_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 43fac8a8db..37dd4cf5f4 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -214,7 +214,6 @@ static const Property nrf51_soc_properties[] = {
     DEFINE_PROP_UINT32("sram-size", NRF51State, sram_size, NRF51822_SRAM_SIZE),
     DEFINE_PROP_UINT32("flash-size", NRF51State, flash_size,
                        NRF51822_FLASH_SIZE),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void nrf51_soc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 6baa9d0fc3..dd74c2e558 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -938,7 +938,6 @@ static const Property smmu_dev_properties[] = {
     DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
     DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void smmu_base_class_init(ObjectClass *klass, void *data)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 026838f9ac..c0cf5df0f6 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1985,7 +1985,6 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void smmuv3_instance_init(Object *obj)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 7fc13d96c9..ea04b2837f 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -448,7 +448,6 @@ static const Property stellaris_sys_properties[] = {
     DEFINE_PROP_UINT32("dc2", ssys_state, dc2, 0),
     DEFINE_PROP_UINT32("dc3", ssys_state, dc3, 0),
     DEFINE_PROP_UINT32("dc4", ssys_state, dc4, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void stellaris_sys_instance_init(Object *obj)
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 4c4ff21e80..f56781519f 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1334,7 +1334,6 @@ static const VMStateDescription vmstate_strongarm_uart_regs = {
 
 static const Property strongarm_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", StrongARMUARTState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void strongarm_uart_class_init(ObjectClass *klass, void *data)
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3adbe7b1fb..3760d101fd 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -975,7 +975,6 @@ static const Property versal_properties[] = {
                       TYPE_CAN_BUS, CanBusState *),
     DEFINE_PROP_LINK("canbus1", Versal, lpd.iou.canbus[1],
                       TYPE_CAN_BUS, CanBusState *),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void versal_class_init(ObjectClass *klass, void *data)
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 1082c62c30..6bb4629a5c 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -867,7 +867,6 @@ static const Property xlnx_zynqmp_props[] = {
                      CanBusState *),
     DEFINE_PROP_LINK("canbus1", XlnxZynqMPState, canbus[1], TYPE_CAN_BUS,
                      CanBusState *),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void xlnx_zynqmp_class_init(ObjectClass *oc, void *data)
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 8033bbbaed..35533c6bad 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1326,7 +1326,6 @@ static void ac97_exit(PCIDevice *dev)
 
 static const Property ac97_properties[] = {
     DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ac97_class_init(ObjectClass *klass, void *data)
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index c1d8faecb4..8c9767b537 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -301,7 +301,6 @@ static const Property adlib_properties[] = {
     DEFINE_AUDIO_PROPERTIES(AdlibState, card),
     DEFINE_PROP_UINT32 ("iobase",  AdlibState, port, 0x220),
     DEFINE_PROP_UINT32 ("freq",    AdlibState, freq,  44100),
-    DEFINE_PROP_END_OF_LIST (),
 };
 
 static void adlib_class_initfn (ObjectClass *klass, void *data)
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 452039418d..cc205bf063 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -698,7 +698,6 @@ static void asc_init(Object *obj)
 static const Property asc_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ASCState, card),
     DEFINE_PROP_UINT8("asctype", ASCState, type, ASC_TYPE_ASC),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void asc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index abc38720a3..5a9be80ba3 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -694,7 +694,6 @@ static const Property cs4231a_properties[] = {
     DEFINE_PROP_UINT32 ("iobase",  CSState, port, 0x534),
     DEFINE_PROP_UINT32 ("irq",     CSState, irq,  9),
     DEFINE_PROP_UINT32 ("dma",     CSState, dma,  3),
-    DEFINE_PROP_END_OF_LIST (),
 };
 
 static void cs4231a_class_initfn (ObjectClass *klass, void *data)
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 6170425a5a..b5756b97d5 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -870,7 +870,6 @@ static void es1370_exit(PCIDevice *dev)
 
 static const Property es1370_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ES1370State, card),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void es1370_class_init (ObjectClass *klass, void *data)
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index dd5a5a3441..e718c1183e 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -296,7 +296,6 @@ static const Property gus_properties[] = {
     DEFINE_PROP_UINT32 ("iobase",  GUSState, port,        0x240),
     DEFINE_PROP_UINT32 ("irq",     GUSState, emu.gusirq,  7),
     DEFINE_PROP_UINT32 ("dma",     GUSState, emu.gusdma,  3),
-    DEFINE_PROP_END_OF_LIST (),
 };
 
 static void gus_class_initfn (ObjectClass *klass, void *data)
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 8bd8f62c48..6f3a8f691b 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -862,7 +862,6 @@ static const Property hda_audio_properties[] = {
     DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
     DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
     DEFINE_PROP_BOOL("use-timer", HDAAudioState, use_timer,  true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 3e4a755228..ec24dfd77a 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -39,7 +39,6 @@
 
 static const Property hda_props[] = {
     DEFINE_PROP_UINT32("cad", HDACodecDevice, cad, -1),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const TypeInfo hda_codec_bus_info = {
@@ -1219,7 +1218,6 @@ static const Property intel_hda_properties[] = {
     DEFINE_PROP_UINT32("debug", IntelHDAState, debug, 0),
     DEFINE_PROP_ON_OFF_AUTO("msi", IntelHDAState, msi, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("old_msi_addr", IntelHDAState, old_msi_addr, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void intel_hda_class_init(ObjectClass *klass, void *data)
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 7a6b9f52d3..17be185547 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -219,7 +219,6 @@ static const Property pcspk_properties[] = {
     DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
     DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pcspk_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 6c66a240cb..f771d725fa 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -630,7 +630,6 @@ static const Property pl041_device_properties[] = {
     /* Non-compact FIFO depth property */
     DEFINE_PROP_UINT32("nc_fifo_depth", PL041State, fifo_depth,
                        DEFAULT_FIFO_DEPTH),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pl041_device_class_init(ObjectClass *klass, void *data)
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 143b9e71e1..0c661b4947 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1447,7 +1447,6 @@ static const Property sb16_properties[] = {
     DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
     DEFINE_PROP_UINT32 ("dma",     SB16State, dma,  1),
     DEFINE_PROP_UINT32 ("dma16",   SB16State, hdma, 5),
-    DEFINE_PROP_END_OF_LIST (),
 };
 
 static void sb16_class_initfn (ObjectClass *klass, void *data)
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index e43ddf37f3..4e115e011e 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -461,7 +461,6 @@ static void via_ac97_exit(PCIDevice *dev)
 
 static const Property via_ac97_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ViaAC97State, card),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void via_ac97_class_init(ObjectClass *klass, void *data)
diff --git a/hw/audio/virtio-snd-pci.c b/hw/audio/virtio-snd-pci.c
index b762d7e81e..74d93f4e9c 100644
--- a/hw/audio/virtio-snd-pci.c
+++ b/hw/audio/virtio-snd-pci.c
@@ -31,7 +31,6 @@ static const Property virtio_snd_pci_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index e2b112e059..7e8ab74ceb 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -85,7 +85,6 @@ static const Property virtio_snd_properties[] = {
                        VIRTIO_SOUND_STREAM_DEFAULT),
     DEFINE_PROP_UINT32("chmaps", VirtIOSound, snd_conf.chmaps,
                        VIRTIO_SOUND_CHMAP_DEFAULT),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 19e7755060..8d381dbc65 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -708,7 +708,6 @@ void wm8750_set_bclk_in(void *opaque, int new_hz)
 
 static const Property wm8750_properties[] = {
     DEFINE_AUDIO_PROPERTIES(WM8750State, card),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void wm8750_class_init(ObjectClass *klass, void *data)
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index ce630ec572..981f34219f 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -358,7 +358,6 @@ static void atmega_realize(DeviceState *dev, Error **errp)
 static const Property atmega_props[] = {
     DEFINE_PROP_UINT64("xtal-frequency-hz", AtmegaMcuState,
                        xtal_freq_hz, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void atmega_class_init(ObjectClass *oc, void *data)
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 2b9f667fe4..e71be8ab2c 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -296,7 +296,6 @@ static const Property isa_fdc_properties[] = {
     DEFINE_PROP_SIGNED("fallback", FDCtrlISABus, state.fallback,
                         FLOPPY_DRIVE_TYPE_288, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void isabus_fdc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index f17e04b138..381b492aec 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -206,7 +206,6 @@ static const Property sysbus_fdc_properties[] = {
     DEFINE_PROP_SIGNED("fallback", FDCtrlSysBus, state.fallback,
                         FLOPPY_DRIVE_TYPE_144, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sysbus_fdc_class_init(ObjectClass *klass, void *data)
@@ -230,7 +229,6 @@ static const Property sun4m_fdc_properties[] = {
     DEFINE_PROP_SIGNED("fallback", FDCtrlSysBus, state.fallback,
                         FLOPPY_DRIVE_TYPE_144, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sun4m_fdc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 57d6844806..d81b7a2a73 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -460,7 +460,6 @@ static const Property floppy_drive_properties[] = {
     DEFINE_PROP_SIGNED("drive-type", FloppyDrive, type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void floppy_drive_realize(DeviceState *qdev, Error **errp)
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index ca97365926..8b5f148796 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1729,7 +1729,6 @@ static const Property m25p80_properties[] = {
     DEFINE_PROP_UINT8("spansion-cr3nv", Flash, spansion_cr3nv, 0x2),
     DEFINE_PROP_UINT8("spansion-cr4nv", Flash, spansion_cr4nv, 0x10),
     DEFINE_PROP_DRIVE("drive", Flash, blk),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static int m25p80_pre_load(void *opaque)
diff --git a/hw/block/nand.c b/hw/block/nand.c
index b6e6bfac23..35a91a870b 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -449,7 +449,6 @@ static const Property nand_properties[] = {
     DEFINE_PROP_UINT8("manufacturer_id", NANDFlashState, manf_id, 0),
     DEFINE_PROP_UINT8("chip_id", NANDFlashState, chip_id, 0),
     DEFINE_PROP_DRIVE("drive", NANDFlashState, blk),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void nand_class_init(ObjectClass *klass, void *data)
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 20f4fc67a0..06db20da60 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -932,7 +932,6 @@ static const Property pflash_cfi01_properties[] = {
     DEFINE_PROP_STRING("name", PFlashCFI01, name),
     DEFINE_PROP_BOOL("old-multiple-chip-handling", PFlashCFI01,
                      old_multiple_chip_handling, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c82002d665..559fac8ce8 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -959,7 +959,6 @@ static const Property pflash_cfi02_properties[] = {
     DEFINE_PROP_UINT16("unlock-addr0", PFlashCFI02, unlock_addr0, 0),
     DEFINE_PROP_UINT16("unlock-addr1", PFlashCFI02, unlock_addr1, 0),
     DEFINE_PROP_STRING("name", PFlashCFI02, name),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pflash_cfi02_unrealize(DeviceState *dev)
diff --git a/hw/block/swim.c b/hw/block/swim.c
index c336d83bdc..4a7f8d13f7 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -169,7 +169,6 @@ static const BlockDevOps swim_block_ops = {
 static const Property swim_drive_properties[] = {
     DEFINE_PROP_INT32("unit", SWIMDrive, unit, -1),
     DEFINE_BLOCK_PROPERTIES(SWIMDrive, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void swim_drive_realize(DeviceState *qdev, Error **errp)
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index f3ac007108..d13c597d7e 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -581,7 +581,6 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_DISCARD, true),
     DEFINE_PROP_BIT64("write-zeroes", VHostUserBlk, parent_obj.host_features,
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9ca60fbc07..5bcb77ed20 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -2014,7 +2014,6 @@ static const Property virtio_blk_properties[] = {
                        conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SECTORS),
     DEFINE_PROP_BOOL("x-enable-wce-if-config-wce", VirtIOBlock,
                      conf.x_enable_wce_if_config_wce, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_blk_class_init(ObjectClass *klass, void *data)
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 0c0817f498..56a6713660 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -674,7 +674,6 @@ static const Property xen_block_props[] = {
                        props.max_ring_page_order, 4),
     DEFINE_PROP_LINK("iothread", XenBlockDevice, props.iothread,
                      TYPE_IOTHREAD, IOThread *),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void xen_block_class_init(ObjectClass *class, void *data)
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index 3421576e45..e8012cae3a 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -261,7 +261,6 @@ static const MemoryRegionOps avr_usart_ops = {
 
 static const Property avr_usart_properties[] = {
     DEFINE_PROP_CHR("chardev", AVRUsartState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void avr_usart_pr(void *opaque, int irq, int level)
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 30285c97b0..73ad593406 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -292,7 +292,6 @@ static void bcm2835_aux_realize(DeviceState *dev, Error **errp)
 
 static const Property bcm2835_aux_props[] = {
     DEFINE_PROP_CHR("chardev", BCM2835AuxState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void bcm2835_aux_class_init(ObjectClass *oc, void *data)
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 2e778f7a9c..ebd846a083 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -619,7 +619,6 @@ static const VMStateDescription vmstate_cadence_uart = {
 
 static const Property cadence_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", CadenceUARTState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void cadence_uart_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index e37e14e0f2..0506500215 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -380,7 +380,6 @@ static const VMStateDescription cmsdk_apb_uart_vmstate = {
 static const Property cmsdk_apb_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", CMSDKAPBUART, chr),
     DEFINE_PROP_UINT32("pclk-frq", CMSDKAPBUART, pclk_frq, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void cmsdk_apb_uart_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index c0f16e9bd6..1bc3bf85fe 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -118,7 +118,6 @@ static const Property debugcon_isa_properties[] = {
     DEFINE_PROP_UINT32("iobase", ISADebugconState, iobase, 0xe9),
     DEFINE_PROP_CHR("chardev",  ISADebugconState, state.chr),
     DEFINE_PROP_UINT32("readback", ISADebugconState, state.readback, 0xe9),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void debugcon_isa_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 03beba11ad..b0b0714e0f 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -174,7 +174,6 @@ static const VMStateDescription vmstate_digic_uart = {
 
 static const Property digic_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", DigicUartState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void digic_uart_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 08bc65ef2c..a5fdd8f698 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -1099,7 +1099,6 @@ static const Property escc_properties[] = {
     DEFINE_PROP_CHR("chrB", ESCCState, chn[0].chr),
     DEFINE_PROP_CHR("chrA", ESCCState, chn[1].chr),
     DEFINE_PROP_STRING("chnA-sunkbd-layout", ESCCState, chn[1].sunkbd_layout),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void escc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index c2836ff8fd..a1a9a12caf 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -709,7 +709,6 @@ static const Property exynos4210_uart_properties[] = {
     DEFINE_PROP_UINT32("channel", Exynos4210UartState, channel, 0),
     DEFINE_PROP_UINT32("rx-size", Exynos4210UartState, rx.size, 16),
     DEFINE_PROP_UINT32("tx-size", Exynos4210UartState, tx.size, 16),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void exynos4210_uart_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index 68e261236e..701eb98893 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -243,7 +243,6 @@ static const VMStateDescription vmstate_goldfish_tty = {
 
 static const Property goldfish_tty_properties[] = {
     DEFINE_PROP_CHR("chardev", GoldfishTTYState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void goldfish_tty_instance_init(Object *obj)
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index caae88d77d..db6bcdad41 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -279,7 +279,6 @@ static void grlib_apbuart_reset(DeviceState *d)
 
 static const Property grlib_apbuart_properties[] = {
     DEFINE_PROP_CHR("chrdev", UART, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void grlib_apbuart_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index b1bdb2ad15..392375ad55 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -510,7 +510,6 @@ static const VMStateDescription vmstate_ibex_uart = {
 
 static const Property ibex_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", IbexUartState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ibex_uart_init(Object *obj)
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 6376f2cadc..12705a1337 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -440,7 +440,6 @@ static void imx_serial_init(Object *obj)
 
 static const Property imx_serial_properties[] = {
     DEFINE_PROP_CHR("chardev", IMXSerialState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void imx_serial_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index fb8cb6c2b7..d1e5f6dad2 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -567,7 +567,6 @@ static const Property ipoctal_properties[] = {
     DEFINE_PROP_CHR("chardev5", IPOctalState, ch[5].dev),
     DEFINE_PROP_CHR("chardev6", IPOctalState, ch[6].dev),
     DEFINE_PROP_CHR("chardev7", IPOctalState, ch[7].dev),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ipoctal_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index c044536d5d..980a12fcb7 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -314,7 +314,6 @@ static void mcf_uart_realize(DeviceState *dev, Error **errp)
 
 static const Property mcf_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", mcf_uart_state, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mcf_uart_class_init(ObjectClass *oc, void *data)
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index b164c70f52..82a61ee95f 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -306,7 +306,6 @@ static const VMStateDescription nrf51_uart_vmstate = {
 
 static const Property nrf51_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", NRF51UARTState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void nrf51_uart_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 15191698f5..df31ce4722 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -608,7 +608,6 @@ static const Property parallel_isa_properties[] = {
     DEFINE_PROP_UINT32("iobase", ISAParallelState, iobase,  -1),
     DEFINE_PROP_UINT32("irq",   ISAParallelState, isairq,  7),
     DEFINE_PROP_CHR("chardev",  ISAParallelState, state.chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void parallel_isa_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 5fbee5e6c5..06ce851044 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -606,7 +606,6 @@ static const VMStateDescription vmstate_pl011 = {
 static const Property pl011_properties[] = {
     DEFINE_PROP_CHR("chardev", PL011State, chr),
     DEFINE_PROP_BOOL("migrate-clk", PL011State, migrate_clk, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pl011_init(Object *obj)
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
index 516b48648b..ea94494932 100644
--- a/hw/char/renesas_sci.c
+++ b/hw/char/renesas_sci.c
@@ -322,7 +322,6 @@ static const VMStateDescription vmstate_rsci = {
 static const Property rsci_properties[] = {
     DEFINE_PROP_UINT64("input-freq", RSCIState, input_freq, 0),
     DEFINE_PROP_CHR("chardev", RSCIState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void rsci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 536b283471..ddb9a726d5 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -337,7 +337,6 @@ static const Property console_properties[] = {
     DEFINE_PROP_CHR("chardev", SCLPConsoleLM, chr),
     DEFINE_PROP_UINT32("write_errors", SCLPConsoleLM, write_errors, 0),
     DEFINE_PROP_BOOL("echo", SCLPConsoleLM, echo, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void console_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index a90b892d1d..01233b933d 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -253,7 +253,6 @@ static void console_reset(DeviceState *dev)
 
 static const Property console_properties[] = {
     DEFINE_PROP_CHR("chardev", SCLPConsole, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void console_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 2cf50eb0bb..f44959c769 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -117,7 +117,6 @@ static const Property serial_isa_properties[] = {
     DEFINE_PROP_UINT32("index",  ISASerialState, index,   -1),
     DEFINE_PROP_UINT32("iobase",  ISASerialState, iobase,  -1),
     DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void serial_isa_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
index 8f51f1d3b8..6338e7c0ba 100644
--- a/hw/char/serial-mm.c
+++ b/hw/char/serial-mm.c
@@ -132,7 +132,6 @@ static const Property serial_mm_properties[] = {
      */
     DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
     DEFINE_PROP_UINT8("endianness", SerialMM, endianness, DEVICE_NATIVE_ENDIAN),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void serial_mm_class_init(ObjectClass *oc, void *data)
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index c2f20d8e74..7578e863cf 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -136,7 +136,6 @@ static const Property multi_2x_serial_pci_properties[] = {
     DEFINE_PROP_CHR("chardev1",  PCIMultiSerialState, state[0].chr),
     DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
     DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const Property multi_4x_serial_pci_properties[] = {
@@ -145,7 +144,6 @@ static const Property multi_4x_serial_pci_properties[] = {
     DEFINE_PROP_CHR("chardev3",  PCIMultiSerialState, state[2].chr),
     DEFINE_PROP_CHR("chardev4",  PCIMultiSerialState, state[3].chr),
     DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void multi_2x_serial_pci_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 2f487a3a79..6659cef5d4 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -83,7 +83,6 @@ static const VMStateDescription vmstate_pci_serial = {
 
 static const Property serial_pci_properties[] = {
     DEFINE_PROP_UINT8("prog_if",  PCISerialState, prog_if, 0x02),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void serial_pci_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 85dba02ace..81b346a5ab 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -968,7 +968,6 @@ static const Property serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SerialState, chr),
     DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
     DEFINE_PROP_BOOL("wakeup", SerialState, wakeup, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void serial_class_init(ObjectClass *klass, void* data)
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 2ab7197aee..247aeb071a 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -450,7 +450,6 @@ static void sh_serial_init(Object *obj)
 static const Property sh_serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SHSerialState, chr),
     DEFINE_PROP_UINT8("features", SHSerialState, feat, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void sh_serial_class_init(ObjectClass *oc, void *data)
diff --git a/hw/char/shakti_uart.c b/hw/char/shakti_uart.c
index 6e56754ca6..09975d9d34 100644
--- a/hw/char/shakti_uart.c
+++ b/hw/char/shakti_uart.c
@@ -159,7 +159,6 @@ static void shakti_uart_instance_init(Object *obj)
 
 static const Property shakti_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", ShaktiUartState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void shakti_uart_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 97e4be37c0..4bc5767284 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -253,7 +253,6 @@ static int sifive_uart_be_change(void *opaque)
 
 static const Property sifive_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", SiFiveUARTState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sifive_uart_init(Object *obj)
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index cd91dad709..6451d010ac 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -166,7 +166,6 @@ void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev)
 static const Property spapr_vty_properties[] = {
     DEFINE_SPAPR_PROPERTIES(SpaprVioVty, sdev),
     DEFINE_PROP_CHR("chardev", SpaprVioVty, chardev),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_spapr_vty = {
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 4a3c30eddb..ebcc510f4e 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -201,7 +201,6 @@ static const MemoryRegionOps stm32f2xx_usart_ops = {
 
 static const Property stm32f2xx_usart_properties[] = {
     DEFINE_PROP_CHR("chardev", STM32F2XXUsartState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void stm32f2xx_usart_init(Object *obj)
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 360e79cc3f..bcc310bd97 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -536,7 +536,6 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
 
 static const Property stm32l4x5_usart_base_properties[] = {
     DEFINE_PROP_CHR("chardev", Stm32l4x5UsartBaseState, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void stm32l4x5_usart_base_init(Object *obj)
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index c2aafda0ce..04ee26dcbd 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -285,7 +285,6 @@ static int write_payload_3270(EmulatedCcw3270Device *dev, uint8_t cmd)
 
 static const Property terminal_properties[] = {
     DEFINE_PROP_CHR("chardev", Terminal3270, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription terminal3270_vmstate = {
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index f58292e2bb..aa6d611a47 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -276,7 +276,6 @@ static const TypeInfo virtconsole_info = {
 
 static const Property virtserialport_properties[] = {
     DEFINE_PROP_CHR("chardev", VirtConsole, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtserialport_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 1e631bcb2b..b6d2743a9c 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -838,7 +838,6 @@ static void virtser_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
 static const Property virtser_props[] = {
     DEFINE_PROP_UINT32("nr", VirtIOSerialPort, id, VIRTIO_CONSOLE_BAD_ID),
     DEFINE_PROP_STRING("name", VirtIOSerialPort, name),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void virtser_bus_class_init(ObjectClass *klass, void *data)
@@ -1158,7 +1157,6 @@ static const Property virtio_serial_properties[] = {
                                                   31),
     DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
                       VIRTIO_CONSOLE_F_EMERG_WRITE, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_serial_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index c20c1b4b84..96e7d5940d 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -490,7 +490,6 @@ static char *xen_console_get_frontend_path(XenDevice *xendev, Error **errp)
 static const Property xen_console_properties[] = {
     DEFINE_PROP_CHR("chardev", XenConsole, chr),
     DEFINE_PROP_INT32("idx", XenConsole, dev, -1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xen_console_class_init(ObjectClass *class, void *data)
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index ad77226217..56955e0d74 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -178,7 +178,6 @@ static const MemoryRegionOps uart_ops = {
 
 static const Property xilinx_uartlite_properties[] = {
     DEFINE_PROP_CHR("chardev", XilinxUARTLite, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void uart_rx(void *opaque, const uint8_t *buf, int size)
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index c1cddecf60..67f2008995 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -187,7 +187,6 @@ static const Property generic_loader_props[] = {
     DEFINE_PROP_UINT32("cpu-num", GenericLoaderState, cpu_num, CPU_NONE),
     DEFINE_PROP_BOOL("force-raw", GenericLoaderState, force_raw, false),
     DEFINE_PROP_STRING("file", GenericLoaderState, file),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void generic_loader_class_init(ObjectClass *klass, void *data)
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 74af00cee7..57315e5cef 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -116,7 +116,6 @@ static const Property guest_loader_props[] = {
     DEFINE_PROP_STRING("kernel", GuestLoaderState, kernel),
     DEFINE_PROP_STRING("bootargs", GuestLoaderState, args),
     DEFINE_PROP_STRING("initrd", GuestLoaderState, initrd),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void guest_loader_class_init(ObjectClass *klass, void *data)
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index fc52796f54..4d0d3cabf1 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -117,7 +117,6 @@ static const VMStateDescription vmstate_or_irq = {
 
 static const Property or_irq_properties[] = {
     DEFINE_PROP_UINT16("num-lines", OrIRQState, num_lines, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void or_irq_class_init(ObjectClass *klass, void *data)
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index a29c9c6e59..1d00c4d36d 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -207,7 +207,6 @@ static void platform_bus_realize(DeviceState *dev, Error **errp)
 static const Property platform_bus_properties[] = {
     DEFINE_PROP_UINT32("num_irqs", PlatformBusDevice, num_irqs, 0),
     DEFINE_PROP_UINT32("mmio_size", PlatformBusDevice, mmio_size, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void platform_bus_class_init(ObjectClass *klass, void *data)
diff --git a/hw/core/split-irq.c b/hw/core/split-irq.c
index 40fc7e2e77..fc12274811 100644
--- a/hw/core/split-irq.c
+++ b/hw/core/split-irq.c
@@ -61,7 +61,6 @@ static void split_irq_realize(DeviceState *dev, Error **errp)
 
 static const Property split_irq_properties[] = {
     DEFINE_PROP_UINT16("num-lines", SplitIRQ, num_lines, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void split_irq_class_init(ObjectClass *klass, void *data)
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 5346b8b6c6..bad44836f7 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -153,7 +153,6 @@ static const Property a15mp_priv_properties[] = {
      * Other boards may differ and should set this property appropriately.
      */
     DEFINE_PROP_UINT32("num-irq", A15MPPrivState, num_irq, 160),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void a15mp_priv_class_init(ObjectClass *klass, void *data)
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index c3fdfb92e1..9671585b5f 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -167,7 +167,6 @@ static const Property a9mp_priv_properties[] = {
      * Other boards may differ and should set this property appropriately.
      */
     DEFINE_PROP_UINT32("num-irq", A9MPPrivState, num_irq, 96),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void a9mp_priv_class_init(ObjectClass *klass, void *data)
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 193fc182ab..94861a06d9 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -142,7 +142,6 @@ static const Property mpcore_priv_properties[] = {
      * has more IRQ lines than the kernel expects.
      */
     DEFINE_PROP_UINT32("num-irq", ARM11MPCorePriveState, num_irq, 64),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mpcore_priv_class_init(ObjectClass *klass, void *data)
diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index 8e43621b5c..9da5221f88 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -27,7 +27,6 @@
 
 static const Property cpu_cluster_properties[] = {
     DEFINE_PROP_UINT32("cluster-id", CPUClusterState, cluster_id, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 typedef struct CallbackData {
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 9a0ff1df86..4268735e3a 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -110,7 +110,6 @@ static void mpcore_rirq_init(Object *obj)
 
 static const Property mpcore_rirq_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", mpcore_rirq_state, num_cpu, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mpcore_rirq_class_init(ObjectClass *klass, void *data)
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 3fde0f8aae..65cdac6cc1 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -68,7 +68,6 @@ static void cswmbcci_exit(PCIDevice *pci_dev)
 static const Property cxl_switch_cci_props[] = {
     DEFINE_PROP_LINK("target", CSWMBCCIDev,
                      target, TYPE_CXL_USP, PCIDevice *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void cswmbcci_class_init(ObjectClass *oc, void *data)
diff --git a/hw/display/artist.c b/hw/display/artist.c
index 49deed328d..8b719b11ed 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1478,7 +1478,6 @@ static const Property artist_properties[] = {
     DEFINE_PROP_UINT16("width",        ARTISTState, width, 1280),
     DEFINE_PROP_UINT16("height",       ARTISTState, height, 1024),
     DEFINE_PROP_UINT16("depth",        ARTISTState, depth, 8),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void artist_reset(DeviceState *qdev)
diff --git a/hw/display/ati.c b/hw/display/ati.c
index e24e092bbc..864fa4fc2c 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1047,7 +1047,6 @@ static const Property ati_vga_properties[] = {
     DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, false),
     /* this is a debug option, prefer PROP_UINT over PROP_BIT for simplicity */
     DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, DEFAULT_X_PIXMAN),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void ati_vga_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 2539fcc8ab..a5bded5156 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -440,7 +440,6 @@ static const Property bcm2835_fb_props[] = {
                        initial_config.pixo, 1), /* 1=RGB, 0=BGR */
     DEFINE_PROP_UINT32("alpha", BCM2835FBState,
                        initial_config.alpha, 2), /* alpha ignored */
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void bcm2835_fb_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 9a3263aa01..086f7a0f06 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -349,7 +349,6 @@ static const Property bochs_display_properties[] = {
     DEFINE_PROP_SIZE("vgamem", BochsDisplayState, vgamem, 16 * MiB),
     DEFINE_PROP_BOOL("edid", BochsDisplayState, enable_edid, true),
     DEFINE_EDID_PROPERTIES(BochsDisplayState, edid_info),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void bochs_display_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 75b3312c24..3f971d875f 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -366,7 +366,6 @@ static const Property cg3_properties[] = {
     DEFINE_PROP_UINT16("width",        CG3State, width,     -1),
     DEFINE_PROP_UINT16("height",       CG3State, height,    -1),
     DEFINE_PROP_UINT16("depth",        CG3State, depth,     -1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void cg3_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 198ed9ed9b..47ca6a7754 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2989,7 +2989,6 @@ static const Property pci_vga_cirrus_properties[] = {
                      cirrus_vga.enable_blitter, true),
     DEFINE_PROP_BOOL("global-vmstate", struct PCICirrusVGAState,
                      cirrus_vga.vga.global_vmstate, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void cirrus_vga_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index d0d134470f..60b7fd20f1 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -74,7 +74,6 @@ static const Property isa_cirrus_vga_properties[] = {
                        cirrus_vga.vga.vram_size_mb, 4),
     DEFINE_PROP_BOOL("blitter", struct ISACirrusVGAState,
                      cirrus_vga.enable_blitter, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 4f097a172c..04c864a308 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1928,7 +1928,6 @@ static const GraphicHwOps exynos4210_fimd_ops = {
 static const Property exynos4210_fimd_properties[] = {
     DEFINE_PROP_LINK("framebuffer-memory", Exynos4210fimdState, fbmem,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void exynos4210_fimd_init(Object *obj)
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index a7533c6908..30b5ea67f2 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -514,7 +514,6 @@ static void g364fb_sysbus_reset(DeviceState *d)
 
 static const Property g364fb_sysbus_properties[] = {
     DEFINE_PROP_UINT32("vram_size", G364SysBusState, g364.vram_size, 8 * MiB),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_g364fb_sysbus = {
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
index a2d1f2b044..d8ab9eee40 100644
--- a/hw/display/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -97,7 +97,6 @@ static const VMStateDescription vmstate_i2c_ddc = {
 
 static const Property i2c_ddc_properties[] = {
     DEFINE_EDID_PROPERTIES(I2CDDCState, edid_info),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void i2c_ddc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 977901bfdd..e83fc863be 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -764,7 +764,6 @@ static const Property macfb_sysbus_properties[] = {
     DEFINE_PROP_UINT8("depth", MacfbSysBusState, macfb.depth, 8),
     DEFINE_PROP_UINT8("display", MacfbSysBusState, macfb.type,
                       MACFB_DISPLAY_VGA),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_macfb_sysbus = {
@@ -783,7 +782,6 @@ static const Property macfb_nubus_properties[] = {
     DEFINE_PROP_UINT8("depth", MacfbNubusState, macfb.depth, 8),
     DEFINE_PROP_UINT8("display", MacfbNubusState, macfb.type,
                       MACFB_DISPLAY_VGA),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_macfb_nubus = {
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index eca00b4279..4d4f477b94 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -538,7 +538,6 @@ static const GraphicHwOps pl110_gfx_ops = {
 static const Property pl110_properties[] = {
     DEFINE_PROP_LINK("framebuffer-memory", PL110State, fbmem,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pl110_realize(DeviceState *dev, Error **errp)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 949949d374..f3b1be7ebf 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2475,7 +2475,6 @@ static const Property qxl_properties[] = {
         DEFINE_PROP_UINT32("xres", PCIQXLDevice, xres, 0),
         DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
         DEFINE_PROP_BOOL("global-vmstate", PCIQXLDevice, vga.global_vmstate, false),
-        DEFINE_PROP_END_OF_LIST(),
 };
 
 static void qxl_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index e677f44be6..6c35028965 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -62,7 +62,6 @@ static const VMStateDescription ramfb_dev_vmstate = {
 
 static const Property ramfb_properties[] = {
     DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ramfb_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 446b648f1a..09edcf86f8 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -2058,7 +2058,6 @@ static const Property sm501_sysbus_properties[] = {
     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
     /* this a debug option, prefer PROP_UINT over PROP_BIT for simplicity */
     DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, DEFAULT_X_PIXMAN),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sm501_reset_sysbus(DeviceState *dev)
@@ -2146,7 +2145,6 @@ static void sm501_realize_pci(PCIDevice *dev, Error **errp)
 static const Property sm501_pci_properties[] = {
     DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * MiB),
     DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, DEFAULT_X_PIXMAN),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sm501_reset_pci(DeviceState *dev)
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 3eb0a91ff9..2cfc1e8f01 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -884,7 +884,6 @@ static const Property tcx_properties[] = {
     DEFINE_PROP_UINT16("width",    TCXState, width,     -1),
     DEFINE_PROP_UINT16("height",   TCXState, height,    -1),
     DEFINE_PROP_UINT16("depth",    TCXState, depth,     -1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void tcx_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index a6cbf77103..2920628f78 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -90,7 +90,6 @@ static void vga_isa_realizefn(DeviceState *dev, Error **errp)
 
 static const Property vga_isa_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", ISAVGAState, state.vram_size_mb, 8),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vga_isa_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/display/vga-mmio.c b/hw/display/vga-mmio.c
index b759efdde7..1e0c2dbf74 100644
--- a/hw/display/vga-mmio.c
+++ b/hw/display/vga-mmio.c
@@ -114,7 +114,6 @@ static void vga_mmio_realizefn(DeviceState *dev, Error **errp)
 static const Property vga_mmio_properties[] = {
     DEFINE_PROP_UINT8("it_shift", VGAMmioState, it_shift, 0),
     DEFINE_PROP_UINT32("vgamem_mb", VGAMmioState, vga.vram_size_mb, 8),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vga_mmio_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 3145c448f5..dd084c20b1 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -339,7 +339,6 @@ static const Property vga_pci_properties[] = {
                     PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, true),
     DEFINE_EDID_PROPERTIES(PCIVGAState, edid_info),
     DEFINE_PROP_BOOL("global-vmstate", PCIVGAState, vga.global_vmstate, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const Property secondary_pci_properties[] = {
@@ -349,7 +348,6 @@ static const Property secondary_pci_properties[] = {
     DEFINE_PROP_BIT("edid",
                     PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, true),
     DEFINE_EDID_PROPERTIES(PCIVGAState, edid_info),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vga_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index a36eddcb12..12d5c37ee5 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -647,7 +647,6 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
 
 static const Property vhost_user_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 6f31149e1e..c6609ddb1b 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -159,7 +159,6 @@ static const Property virtio_gpu_gl_properties[] = {
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
     DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index 89d27c9d85..6d789701a3 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -23,7 +23,6 @@
 
 static const Property virtio_gpu_pci_base_properties[] = {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_gpu_pci_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index f6486acdda..f6eb29472e 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1108,7 +1108,6 @@ static const Property virtio_gpu_rutabaga_properties[] = {
     DEFINE_PROP_STRING("wayland-socket-path", VirtIOGPURutabaga,
                        wayland_socket_path),
     DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 82741d19e5..c2a74a8d99 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1682,7 +1682,6 @@ static const Property virtio_gpu_properties[] = {
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
     DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
     DEFINE_PROP_UINT8("x-scanout-vmstate-version", VirtIOGPU, scanout_vmstate_version, 2),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_gpu_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 532e4c62d5..fefbdb61e1 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -211,7 +211,6 @@ static void virtio_vga_set_big_endian_fb(Object *obj, bool value, Error **errp)
 
 static const Property virtio_vga_base_properties[] = {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_vga_base_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index f49bbf393a..2dd661e3c1 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1337,7 +1337,6 @@ static const Property vga_vmware_properties[] = {
                        chip.vga.vram_size_mb, 16),
     DEFINE_PROP_BOOL("global-vmstate", struct pci_vmsvga_state_s,
                      chip.vga.global_vmstate, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vmsvga_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 7838f28bca..1272da0133 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1389,7 +1389,6 @@ static void xlnx_dp_reset(DeviceState *dev)
 
 static const Property xlnx_dp_device_properties[] = {
     DEFINE_AUDIO_PROPERTIES(XlnxDPState, aud_card),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xlnx_dp_class_init(ObjectClass *oc, void *data)
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 032afedde2..9652d47adc 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -141,7 +141,6 @@ static void i82374_realize(DeviceState *dev, Error **errp)
 
 static const Property i82374_properties[] = {
     DEFINE_PROP_UINT32("iobase", I82374State, iobase, 0x400),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void i82374_class_init(ObjectClass *klass, void *data)
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 8b04177393..74c38d2ee8 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -590,7 +590,6 @@ static const Property i8257_properties[] = {
     DEFINE_PROP_INT32("page-base", I8257State, page_base, 0x80),
     DEFINE_PROP_INT32("pageh-base", I8257State, pageh_base, 0x480),
     DEFINE_PROP_INT32("dshift", I8257State, dshift, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void i8257_class_init(ObjectClass *klass, void *data)
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 3f392822ed..8a9b073b24 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -411,7 +411,6 @@ static void pl081_init(Object *obj)
 static const Property pl080_properties[] = {
     DEFINE_PROP_LINK("downstream", PL080State, downstream,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pl080_class_init(ObjectClass *oc, void *data)
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index d5a0a1caa2..ffef9ebb6f 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -1669,8 +1669,6 @@ static const Property pl330_properties[] = {
 
     DEFINE_PROP_LINK("memory", PL330State, mem_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pl330_class_init(ObjectClass *klass, void *data)
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index f09452d0b5..4bae52a301 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -619,7 +619,6 @@ static const Property axidma_properties[] = {
                      tx_control_dev, TYPE_STREAM_SINK, StreamSink *),
     DEFINE_PROP_LINK("dma", XilinxAXIDMA, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void axidma_class_init(ObjectClass *klass, void *data)
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 1a63d5f3b2..bb27cb2e64 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -814,7 +814,6 @@ static const Property zdma_props[] = {
     DEFINE_PROP_UINT32("bus-width", XlnxZDMA, cfg.bus_width, 64),
     DEFINE_PROP_LINK("dma", XlnxZDMA, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void zdma_class_init(ObjectClass *klass, void *data)
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index d78dc6444b..f46485a42c 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -710,7 +710,6 @@ static const Property xlnx_csu_dma_properties[] = {
                      TYPE_STREAM_SINK, StreamSink *),
     DEFINE_PROP_LINK("dma", XlnxCSUDMA, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xlnx_csu_dma_class_init(ObjectClass *klass, void *data)
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 919d53701f..898f80f8c8 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -294,7 +294,6 @@ static const Property imx_gpio_properties[] = {
     DEFINE_PROP_BOOL("has-edge-sel", IMXGPIOState, has_edge_sel, true),
     DEFINE_PROP_BOOL("has-upper-pin-irq", IMXGPIOState, has_upper_pin_irq,
                      false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void imx_gpio_reset(DeviceState *dev)
diff --git a/hw/gpio/npcm7xx_gpio.c b/hw/gpio/npcm7xx_gpio.c
index db6792b2ad..23e67424c9 100644
--- a/hw/gpio/npcm7xx_gpio.c
+++ b/hw/gpio/npcm7xx_gpio.c
@@ -395,7 +395,6 @@ static const Property npcm7xx_gpio_properties[] = {
     DEFINE_PROP_UINT32("reset-osrc", NPCM7xxGPIOState, reset_osrc, 0),
     /* Bit n set => pin n has high drive strength by default. */
     DEFINE_PROP_UINT32("reset-odsc", NPCM7xxGPIOState, reset_odsc, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void npcm7xx_gpio_class_init(ObjectClass *klass, void *data)
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 03ee9e47c6..8a9f14ba15 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -227,7 +227,6 @@ void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk)
 
 static const Property omap_gpio_properties[] = {
     DEFINE_PROP_INT32("mpu_model", Omap1GpioState, mpu_model, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void omap_gpio_class_init(ObjectClass *klass, void *data)
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 427419d218..1ac0cf6c46 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -430,7 +430,6 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
 
 static const Property pca955x_properties[] = {
     DEFINE_PROP_STRING("description", PCA955xState, description),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pca955x_class_init(ObjectClass *klass, void *data)
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index e8b0458aac..fe03bb4b5e 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -293,7 +293,6 @@ static void pca9554_realize(DeviceState *dev, Error **errp)
 
 static const Property pca9554_properties[] = {
     DEFINE_PROP_STRING("description", PCA9554State, description),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pca9554_class_init(ObjectClass *klass, void *data)
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 9b8ca6de32..60ce4a7f62 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -565,7 +565,6 @@ static void pl061_realize(DeviceState *dev, Error **errp)
 static const Property pl061_props[] = {
     DEFINE_PROP_UINT32("pullups", PL061State, pullups, 0xff),
     DEFINE_PROP_UINT32("pulldowns", PL061State, pulldowns, 0x0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void pl061_class_init(ObjectClass *klass, void *data)
diff --git a/hw/gpio/sifive_gpio.c b/hw/gpio/sifive_gpio.c
index 5603f0c235..0d5206ae6b 100644
--- a/hw/gpio/sifive_gpio.c
+++ b/hw/gpio/sifive_gpio.c
@@ -351,7 +351,6 @@ static const VMStateDescription vmstate_sifive_gpio = {
 
 static const Property sifive_gpio_properties[] = {
     DEFINE_PROP_UINT32("ngpio", SIFIVEGPIOState, ngpio, SIFIVE_GPIO_PINS),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sifive_gpio_realize(DeviceState *dev, Error **errp)
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index d1394f3f55..f69fc1db4f 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -452,7 +452,6 @@ static const Property stm32l4x5_gpio_properties[] = {
     DEFINE_PROP_UINT32("mode-reset", Stm32l4x5GpioState, moder_reset, 0),
     DEFINE_PROP_UINT32("ospeed-reset", Stm32l4x5GpioState, ospeedr_reset, 0),
     DEFINE_PROP_UINT32("pupd-reset", Stm32l4x5GpioState, pupdr_reset, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void stm32l4x5_gpio_class_init(ObjectClass *klass, void *data)
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 74897b1604..c0bf528429 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -1741,8 +1741,6 @@ static const Property hv_balloon_properties[] = {
     DEFINE_PROP_LINK(HV_BALLOON_MEMDEV_PROP, HvBalloon, hostmem,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_UINT64(HV_BALLOON_ADDR_PROP, HvBalloon, addr, 0),
-
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void hv_balloon_class_init(ObjectClass *klass, void *data)
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index 0193addd42..d3e3917077 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -370,7 +370,6 @@ static const Property hv_syndbg_properties[] = {
     DEFINE_PROP_STRING("host_ip", HvSynDbg, host_ip),
     DEFINE_PROP_UINT16("host_port", HvSynDbg, host_port, 50000),
     DEFINE_PROP_BOOL("use_hcalls", HvSynDbg, use_hcalls, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void hv_syndbg_class_init(ObjectClass *klass, void *data)
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 3d1f4d14e8..12a7dc4312 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2348,7 +2348,6 @@ static void vmbus_dev_unrealize(DeviceState *dev)
 
 static const Property vmbus_dev_props[] = {
     DEFINE_PROP_UUID("instanceid", VMBusDevice, instanceid),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 
@@ -2655,7 +2654,6 @@ static const VMStateDescription vmstate_vmbus_bridge = {
 
 static const Property vmbus_bridge_props[] = {
     DEFINE_PROP_UINT8("irq", VMBusBridge, irq, 7),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void vmbus_bridge_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 2ea68c3090..a8fbb9f44a 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1261,7 +1261,6 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
 static const Property aspeed_i2c_properties[] = {
     DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_i2c_class_init(ObjectClass *klass, void *data)
@@ -1450,7 +1449,6 @@ static const Property aspeed_i2c_bus_properties[] = {
     DEFINE_PROP_UINT8("bus-id", AspeedI2CBus, id, 0),
     DEFINE_PROP_LINK("controller", AspeedI2CBus, controller, TYPE_ASPEED_I2C,
                      AspeedI2CState *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_i2c_bus_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 4118d3db50..26bb18514a 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -20,7 +20,6 @@
 
 static const Property i2c_props[] = {
     DEFINE_PROP_UINT8("address", struct I2CSlave, address, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const TypeInfo i2c_bus_info = {
diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index 80c570fd10..779cc4e66e 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -213,7 +213,6 @@ static void pca954x_init(Object *obj)
 
 static const Property pca954x_props[] = {
     DEFINE_PROP_STRING("name", Pca954xState, name),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void pca954x_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 172df135f5..a641db2348 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -513,7 +513,6 @@ void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk)
 
 static const Property omap_i2c_properties[] = {
     DEFINE_PROP_UINT8("revision", OMAPI2CState, revision, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void omap_i2c_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index ca3e62a244..be522b5d7d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1670,7 +1670,6 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 
 static const Property amdvi_properties[] = {
     DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_amdvi_sysbus = {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a5b268342f..f81f34dafa 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3418,7 +3418,6 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 /* Read IRTE entry with specific index */
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 71150ed2e0..f7b49bd9f7 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -308,7 +308,6 @@ static const VMStateDescription kvmclock_vmsd = {
 static const Property kvmclock_properties[] = {
     DEFINE_PROP_BOOL("x-mach-use-reliable-get-clock", KVMClockState,
                       mach_use_reliable_get_clock, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void kvmclock_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 2933d3f458..da5eb60052 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -290,7 +290,6 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
 static const Property kvm_pit_properties[] = {
     DEFINE_PROP_LOSTTICKPOLICY("lost_tick_policy", KVMPITState,
                                lost_tick_policy, LOST_TICK_POLICY_DELAY),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void kvm_pit_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 217ff43b98..73b31df6ab 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -135,7 +135,6 @@ static void kvm_ioapic_realize(DeviceState *dev, Error **errp)
 
 static const Property kvm_ioapic_properties[] = {
     DEFINE_PROP_UINT32("gsi_base", KVMIOAPICState, kvm_gsi_base, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void kvm_ioapic_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index c232e825e0..875e1c5c33 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -24,7 +24,6 @@ static const Property sgx_epc_properties[] = {
     DEFINE_PROP_UINT32(SGX_EPC_NUMA_NODE_PROP, SGXEPCDevice, node, 0),
     DEFINE_PROP_LINK(SGX_EPC_MEMDEV_PROP, SGXEPCDevice, hostmem,
                      TYPE_MEMORY_BACKEND_EPC, HostMemoryBackendEpc *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sgx_epc_get_size(Object *obj, Visitor *v, const char *name,
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index da9c35c1ec..3e07d12512 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -319,7 +319,6 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
 
 static const Property vmmouse_properties[] = {
     DEFINE_PROP_LINK("i8042", VMMouseState, i8042, TYPE_I8042, ISAKBDState *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vmmouse_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index cab6e72089..2096686b64 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -284,8 +284,6 @@ static const Property vmport_properties[] = {
      * 5 - ACE 1.x (Deprecated)
      */
     DEFINE_PROP_UINT8("vmware-vmx-type", VMPortState, vmware_vmx_type, 2),
-
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vmport_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 155f6262ea..e5ec60eae7 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -130,7 +130,6 @@ static const Property x86_iommu_properties[] = {
                             intr_supported, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
     DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void x86_iommu_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index e71483e6e3..9453da97bd 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -120,7 +120,6 @@ static const Property xen_pv_props[] = {
     DEFINE_PROP_UINT16("device-id", XenPVDevice, device_id, 0xffff),
     DEFINE_PROP_UINT8("revision", XenPVDevice, revision, 0x01),
     DEFINE_PROP_UINT32("size", XenPVDevice, size, 0x400000),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void xen_pv_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ide/ahci-sysbus.c b/hw/ide/ahci-sysbus.c
index 2432039290..03a5bd42d0 100644
--- a/hw/ide/ahci-sysbus.c
+++ b/hw/ide/ahci-sysbus.c
@@ -64,7 +64,6 @@ static void sysbus_ahci_realize(DeviceState *dev, Error **errp)
 
 static const Property sysbus_ahci_properties[] = {
     DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci.ports, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sysbus_ahci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ide/cf.c b/hw/ide/cf.c
index 190914f513..cfb4394f80 100644
--- a/hw/ide/cf.c
+++ b/hw/ide/cf.c
@@ -29,7 +29,6 @@ static const Property ide_cf_properties[] = {
     DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
     DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
                 IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ide_cf_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 942f6c470c..bcc3f344fc 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -315,7 +315,6 @@ static void pci_cmd646_ide_exitfn(PCIDevice *dev)
 
 static const Property cmd646_ide_properties[] = {
     DEFINE_PROP_UINT32("secondary", PCIIDEState, secondary, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void cmd646_ide_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index cc92531f1c..789056c5dc 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -32,7 +32,6 @@
 static const Property ide_props[] = {
     DEFINE_PROP_UINT32("unit", IDEDevice, unit, -1),
     DEFINE_PROP_BOOL("win2k-install-hack", IDEDevice, win2k_install_hack, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ide_qdev_realize(DeviceState *qdev, Error **errp)
@@ -197,7 +196,6 @@ static const Property ide_hd_properties[] = {
     DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
                 IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
     DEFINE_PROP_UINT16("rotation_rate", IDEDrive, dev.rotation_rate, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ide_hd_class_init(ObjectClass *klass, void *data)
@@ -220,7 +218,6 @@ static const TypeInfo ide_hd_info = {
 
 static const Property ide_cd_properties[] = {
     DEFINE_IDE_DEV_PROPERTIES(),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ide_cd_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index a0a7e4837c..9a3c2d522c 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -105,7 +105,6 @@ static const Property isa_ide_properties[] = {
     DEFINE_PROP_UINT32("iobase",  ISAIDEState, iobase,  0x1f0),
     DEFINE_PROP_UINT32("iobase2", ISAIDEState, iobase2, 0x3f6),
     DEFINE_PROP_UINT32("irq",     ISAIDEState, irqnum,  14),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void isa_ide_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 25f8403e80..ecaab77862 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -462,7 +462,6 @@ static void macio_ide_initfn(Object *obj)
 static const Property macio_ide_properties[] = {
     DEFINE_PROP_UINT32("channel", MACIOIDEState, channel, 0),
     DEFINE_PROP_UINT32("addr", MACIOIDEState, addr, -1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void macio_ide_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 43ab66f347..a1b0fd23de 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -143,7 +143,6 @@ static void mmio_ide_initfn(Object *obj)
 
 static const Property mmio_ide_properties[] = {
     DEFINE_PROP_UINT32("shift", MMIOIDEState, shift, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void mmio_ide_class_init(ObjectClass *oc, void *data)
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 24a133fd25..16ac82e34d 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -738,7 +738,6 @@ static void i8042_mmio_init(Object *obj)
 static const Property i8042_mmio_properties[] = {
     DEFINE_PROP_UINT64("mask", MMIOKBDState, kbd.mask, UINT64_MAX),
     DEFINE_PROP_UINT32("size", MMIOKBDState, size, -1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_kbd_mmio = {
@@ -938,7 +937,6 @@ static const Property i8042_properties[] = {
     DEFINE_PROP_BOOL("kbd-throttle", ISAKBDState, kbd_throttle, false),
     DEFINE_PROP_UINT8("kbd-irq", ISAKBDState, kbd_irq, 1),
     DEFINE_PROP_UINT8("mouse-irq", ISAKBDState, mouse_irq, 12),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void i8042_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index b1cc693189..98382a0e15 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -80,7 +80,6 @@ static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
 static const Property stellaris_gamepad_properties[] = {
     DEFINE_PROP_ARRAY("keycodes", StellarisGamepad, num_buttons,
                       keycodes, qdev_prop_uint32, uint32_t),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void stellaris_gamepad_class_init(ObjectClass *klass, void *data)
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 7396385508..812faaef8f 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -240,7 +240,6 @@ static void virtio_input_hid_handle_status(VirtIOInput *vinput,
 static const Property virtio_input_hid_properties[] = {
     DEFINE_PROP_STRING("display", VirtIOInputHID, display),
     DEFINE_PROP_UINT32("head", VirtIOInputHID, head, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_input_hid_class_init(ObjectClass *klass, void *data)
@@ -382,7 +381,6 @@ static struct virtio_input_config virtio_mouse_config_v2[] = {
 
 static const Property virtio_mouse_properties[] = {
     DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_mouse_class_init(ObjectClass *klass, void *data)
@@ -507,7 +505,6 @@ static struct virtio_input_config virtio_tablet_config_v2[] = {
 
 static const Property virtio_tablet_properties[] = {
     DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_tablet_class_init(ObjectClass *klass, void *data)
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index 2be2c633ab..8bfb17f3c4 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -223,7 +223,6 @@ static const VMStateDescription vmstate_virtio_input_host = {
 
 static const Property virtio_input_host_properties[] = {
     DEFINE_PROP_STRING("evdev", VirtIOInputHost, evdev),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_input_host_class_init(ObjectClass *klass, void *data)
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index edcd94dedb..1394d99c6b 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -302,7 +302,6 @@ static const VMStateDescription vmstate_virtio_input = {
 
 static const Property virtio_input_properties[] = {
     DEFINE_PROP_STRING("serial", VirtIOInput, serial),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_input_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 8be9f22de8..de8074d474 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -414,7 +414,6 @@ static const Property apic_properties_common[] = {
                     true),
     DEFINE_PROP_BOOL("legacy-instance-id", APICCommonState, legacy_instance_id,
                      false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void apic_common_get_id(Object *obj, Visitor *v, const char *name,
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index e961cd9156..50c516f2f2 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -360,7 +360,6 @@ static const Property arm_gic_common_properties[] = {
     /* True if the GIC should implement the virtualization extensions */
     DEFINE_PROP_BOOL("has-virtualization-extensions", GICState, virt_extn, 0),
     DEFINE_PROP_UINT32("num-priority-bits", GICState, n_prio_bits, 8),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void arm_gic_common_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index ffa830b433..ae389fe584 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -173,7 +173,6 @@ static void gicv2m_init(Object *obj)
 static const Property gicv2m_properties[] = {
     DEFINE_PROP_UINT32("base-spi", ARMGICv2mState, base_spi, 0),
     DEFINE_PROP_UINT32("num-spi", ARMGICv2mState, num_spi, 64),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void gicv2m_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index a8ec615a3f..53e7a251b0 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -621,7 +621,6 @@ static const Property arm_gicv3_common_properties[] = {
                       redist_region_count, qdev_prop_uint32, uint32_t),
     DEFINE_PROP_LINK("sysmem", GICv3State, dma, TYPE_MEMORY_REGION,
                      MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void arm_gicv3_common_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
index f50b1814ea..2388a96799 100644
--- a/hw/intc/arm_gicv3_its.c
+++ b/hw/intc/arm_gicv3_its.c
@@ -2005,7 +2005,6 @@ static void gicv3_its_post_load(GICv3ITSState *s)
 static const Property gicv3_its_props[] = {
     DEFINE_PROP_LINK("parent-gicv3", GICv3ITSState, gicv3, "arm-gicv3",
                      GICv3State *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void gicv3_its_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 68a6144add..3d9150a5c2 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -237,7 +237,6 @@ static void kvm_arm_its_reset_hold(Object *obj, ResetType type)
 static const Property kvm_arm_its_props[] = {
     DEFINE_PROP_LINK("parent-gicv3", GICv3ITSState, gicv3, "kvm-arm-gicv3",
                      GICv3State *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 6e2803b123..a30f31833a 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2577,7 +2577,6 @@ static const Property props_nvic[] = {
      * to use a reasonable default.
      */
     DEFINE_PROP_UINT8("num-prio-bits", NVICState, num_prio_bits, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void armv7m_nvic_reset(DeviceState *dev)
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index 221dfa912a..6ddbcd4c6d 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -327,7 +327,6 @@ static void exynos4210_combiner_init(Object *obj)
 
 static const Property exynos4210_combiner_properties[] = {
     DEFINE_PROP_UINT32("external", Exynos4210CombinerState, external, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void exynos4210_combiner_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index e1b956d990..01a53936d3 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -113,7 +113,6 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
 
 static const Property exynos4210_gic_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", Exynos4210GicState, num_cpu, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void exynos4210_gic_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/goldfish_pic.c b/hw/intc/goldfish_pic.c
index f5343c9d2f..aa5162c18f 100644
--- a/hw/intc/goldfish_pic.c
+++ b/hw/intc/goldfish_pic.c
@@ -183,7 +183,6 @@ static void goldfish_pic_instance_init(Object *obj)
 
 static const Property goldfish_pic_properties[] = {
     DEFINE_PROP_UINT8("index", GoldfishPICState, idx, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void goldfish_pic_class_init(ObjectClass *oc, void *data)
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index bf53251ea2..95cdb411d2 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -378,7 +378,6 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
 
 static const Property grlib_irqmp_properties[] = {
     DEFINE_PROP_UINT32("ncpus", IRQMP, ncpus, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void grlib_irqmp_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index c3174f4fdc..c77ff683bb 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -198,7 +198,6 @@ static const Property pic_properties_common[] = {
     DEFINE_PROP_UINT32("elcr_addr", PICCommonState, elcr_addr,  -1),
     DEFINE_PROP_UINT8("elcr_mask", PICCommonState, elcr_mask,  -1),
     DEFINE_PROP_BIT("master", PICCommonState, master,  0, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pic_common_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 6d566165b0..bfc8cb7ece 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -478,7 +478,6 @@ static void ioapic_unrealize(DeviceState *dev)
 
 static const Property ioapic_properties[] = {
     DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ioapic_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index dd91f89361..be7d3997fd 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -427,7 +427,6 @@ static const Property extioi_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOI, num_cpu, 1),
     DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOI, features,
                     EXTIOI_HAS_VIRT_EXTENSION, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/loongarch_pch_msi.c b/hw/intc/loongarch_pch_msi.c
index e2eca30660..66b5c1e660 100644
--- a/hw/intc/loongarch_pch_msi.c
+++ b/hw/intc/loongarch_pch_msi.c
@@ -86,7 +86,6 @@ static void loongarch_pch_msi_init(Object *obj)
 static const Property loongarch_msi_properties[] = {
     DEFINE_PROP_UINT32("msi_irq_base", LoongArchPCHMSI, irq_base, 0),
     DEFINE_PROP_UINT32("msi_irq_num",  LoongArchPCHMSI, irq_num, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void loongarch_pch_msi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 6a87b1aab7..dc93c90b3c 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -413,7 +413,6 @@ static void loongarch_pch_pic_init(Object *obj)
 
 static const Property loongarch_pch_pic_properties[] = {
     DEFINE_PROP_UINT32("pch_pic_irq_num",  LoongArchPCHPIC, irq_num, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_loongarch_pch_pic = {
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index d3f894a5bd..9a081565f5 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -317,7 +317,6 @@ static const VMStateDescription vmstate_loongson_ipi_common = {
 
 static const Property ipi_common_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void loongson_ipi_common_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index b5d10ab1f6..a82b80f5c6 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -88,7 +88,6 @@ static const VMStateDescription vmstate_m68k_irqc = {
 static const Property m68k_irqc_properties[] = {
     DEFINE_PROP_LINK("m68k-cpu", M68KIRQCState, cpu,
                      TYPE_M68K_CPU, ArchCPU *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void m68k_irqc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 996db095c3..3f50eac38a 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -441,7 +441,6 @@ static void mips_gic_realize(DeviceState *dev, Error **errp)
 static const Property mips_gic_properties[] = {
     DEFINE_PROP_UINT32("num-vp", MIPSGICState, num_vps, 1),
     DEFINE_PROP_UINT32("num-irq", MIPSGICState, num_irq, 256),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mips_gic_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 28606f102b..095a3d504f 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -377,7 +377,6 @@ void omap_intc_set_fclk(OMAPIntcState *intc, omap_clk clk)
 
 static const Property omap_intc_properties[] = {
     DEFINE_PROP_UINT32("size", OMAPIntcState, size, 0x100),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void omap_intc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 8ee1bd64bd..42af4567c6 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -130,7 +130,6 @@ static void or1k_ompic_realize(DeviceState *dev, Error **errp)
 
 static const Property or1k_ompic_properties[] = {
     DEFINE_PROP_UINT32("num-cpus", OR1KOMPICState, num_cpus, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_or1k_ompic_cpu = {
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 2257ae2ee7..78a82d0d30 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1609,7 +1609,6 @@ static void openpic_realize(DeviceState *dev, Error **errp)
 static const Property openpic_properties[] = {
     DEFINE_PROP_UINT32("model", OpenPICState, model, OPENPIC_MODEL_FSL_MPIC_20),
     DEFINE_PROP_UINT32("nb_cpus", OpenPICState, nb_cpus, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void openpic_class_init(ObjectClass *oc, void *data)
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 135fe8301a..3f5d7e5886 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -265,7 +265,6 @@ int kvm_openpic_connect_vcpu(DeviceState *d, CPUState *cs)
 static const Property kvm_openpic_properties[] = {
     DEFINE_PROP_UINT32("model", KVMOpenPICState, model,
                        OPENPIC_MODEL_FSL_MPIC_20),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void kvm_openpic_class_init(ObjectClass *oc, void *data)
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 581659839b..fc5b5a9789 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -2066,7 +2066,6 @@ static const Property pnv_xive_properties[] = {
     DEFINE_PROP_UINT64("tm-bar", PnvXive, tm_base, 0),
     /* The PnvChip id identifies the XIVE interrupt controller. */
     DEFINE_PROP_LINK("chip", PnvXive, chip, TYPE_PNV_CHIP, PnvChip *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_xive_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 5dd305453a..ff36d4d03f 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2366,7 +2366,6 @@ static const Property pnv_xive2_properties[] = {
     DEFINE_PROP_UINT64("config", PnvXive2, config,
                        PNV_XIVE2_CONFIGURATION),
     DEFINE_PROP_LINK("chip", PnvXive2, chip, TYPE_PNV_CHIP, PnvChip *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_xive2_instance_init(Object *obj)
diff --git a/hw/intc/ppc-uic.c b/hw/intc/ppc-uic.c
index d683413a83..7de4bf9885 100644
--- a/hw/intc/ppc-uic.c
+++ b/hw/intc/ppc-uic.c
@@ -262,7 +262,6 @@ static void ppc_uic_realize(DeviceState *dev, Error **errp)
 static const Property ppc_uic_properties[] = {
     DEFINE_PROP_UINT32("dcr-base", PPCUIC, dcr_base, 0xc0),
     DEFINE_PROP_BOOL("use-vectors", PPCUIC, use_vectors, true),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const VMStateDescription ppc_uic_vmstate = {
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index db195fb1ff..db374a7c2d 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -274,7 +274,6 @@ static const Property riscv_aclint_mtimer_properties[] = {
         aperture_size, RISCV_ACLINT_DEFAULT_MTIMER_SIZE),
     DEFINE_PROP_UINT32("timebase-freq", RISCVAclintMTimerState,
         timebase_freq, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
@@ -466,7 +465,6 @@ static const Property riscv_aclint_swi_properties[] = {
     DEFINE_PROP_UINT32("hartid-base", RISCVAclintSwiState, hartid_base, 0),
     DEFINE_PROP_UINT32("num-harts", RISCVAclintSwiState, num_harts, 1),
     DEFINE_PROP_UINT32("sswi", RISCVAclintSwiState, sswi, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void riscv_aclint_swi_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 353eec8136..e160816d26 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -912,7 +912,6 @@ static const Property riscv_aplic_properties[] = {
     DEFINE_PROP_UINT32("num-irqs", RISCVAPLICState, num_irqs, 0),
     DEFINE_PROP_BOOL("msimode", RISCVAPLICState, msimode, 0),
     DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_riscv_aplic = {
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index adc36151b4..64b0da6d20 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -393,7 +393,6 @@ static const Property riscv_imsic_properties[] = {
     DEFINE_PROP_UINT32("hartid", RISCVIMSICState, hartid, 0),
     DEFINE_PROP_UINT32("num-pages", RISCVIMSICState, num_pages, 0),
     DEFINE_PROP_UINT32("num-irqs", RISCVIMSICState, num_irqs, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_riscv_imsic = {
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index dfe11ade20..ca13c5fb37 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -366,7 +366,6 @@ static const Property rxicu_properties[] = {
                       qdev_prop_uint8, uint8_t),
     DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
                       qdev_prop_uint8, uint8_t),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void rxicu_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 2963bd5bd6..3f3fa939d3 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -448,7 +448,6 @@ static void qemu_s390_flic_instance_init(Object *obj)
 static const Property qemu_s390_flic_properties[] = {
     DEFINE_PROP_BOOL("migrate-all-state", QEMUS390FLICState,
                      migrate_all_state, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
@@ -476,7 +475,6 @@ static const Property s390_flic_common_properties[] = {
                        adapter_routes_max_batch, ADAPTER_ROUTES_MAX_GSI),
     DEFINE_PROP_BOOL("migration-enabled", S390FLICState,
                      migration_enabled, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void s390_flic_common_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 49895be803..52946fb7bd 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -444,7 +444,6 @@ static const Property sifive_plic_properties[] = {
     DEFINE_PROP_UINT32("context-base", SiFivePLICState, context_base, 0),
     DEFINE_PROP_UINT32("context-stride", SiFivePLICState, context_stride, 0),
     DEFINE_PROP_UINT32("aperture-size", SiFivePLICState, aperture_size, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sifive_plic_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 09f643d633..897029a65a 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -633,7 +633,6 @@ static const Property spapr_xive_properties[] = {
     DEFINE_PROP_UINT64("vc-base", SpaprXive, vc_base, SPAPR_XIVE_VC_BASE),
     DEFINE_PROP_UINT64("tm-base", SpaprXive, tm_base, SPAPR_XIVE_TM_BASE),
     DEFINE_PROP_UINT8("hv-prio", SpaprXive, hv_prio, 7),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static int spapr_xive_cpu_intc_create(SpaprInterruptController *intc,
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 81bbfdd84b..8852b68f87 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -348,7 +348,6 @@ static const Property icp_properties[] = {
     DEFINE_PROP_LINK(ICP_PROP_XICS, ICPState, xics, TYPE_XICS_FABRIC,
                      XICSFabric *),
     DEFINE_PROP_LINK(ICP_PROP_CPU, ICPState, cs, TYPE_CPU, CPUState *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void icp_class_init(ObjectClass *klass, void *data)
@@ -680,7 +679,6 @@ static const Property ics_properties[] = {
     DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
     DEFINE_PROP_LINK(ICS_PROP_XICS, ICSState, xics, TYPE_XICS_FABRIC,
                      XICSFabric *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ics_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 3e860ab582..d99cf567ae 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -178,7 +178,6 @@ static void xilinx_intc_init(Object *obj)
 
 static const Property xilinx_intc_properties[] = {
     DEFINE_PROP_UINT32("kind-of-intr", XpsIntc, c_kind_of_intr, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xilinx_intc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 308e5743bd..3cf8780b8a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -931,7 +931,6 @@ static const Property xive_tctx_properties[] = {
     DEFINE_PROP_LINK("cpu", XiveTCTX, cs, TYPE_CPU, CPUState *),
     DEFINE_PROP_LINK("presenter", XiveTCTX, xptr, TYPE_XIVE_PRESENTER,
                      XivePresenter *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xive_tctx_class_init(ObjectClass *klass, void *data)
@@ -1414,7 +1413,6 @@ static const Property xive_source_properties[] = {
     DEFINE_PROP_UINT8("reset-pq", XiveSource, reset_pq, XIVE_ESB_OFF),
     DEFINE_PROP_LINK("xive", XiveSource, xive, TYPE_XIVE_NOTIFIER,
                      XiveNotifier *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xive_source_class_init(ObjectClass *klass, void *data)
@@ -2005,7 +2003,6 @@ void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
 static const Property xive_router_properties[] = {
     DEFINE_PROP_LINK("xive-fabric", XiveRouter, xfb,
                      TYPE_XIVE_FABRIC, XiveFabric *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xive_router_class_init(ObjectClass *klass, void *data)
@@ -2175,7 +2172,6 @@ static const Property xive_end_source_properties[] = {
     DEFINE_PROP_UINT32("shift", XiveENDSource, esb_shift, XIVE_ESB_64K),
     DEFINE_PROP_LINK("xive", XiveENDSource, xrtr, TYPE_XIVE_ROUTER,
                      XiveRouter *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xive_end_source_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 3233d3f14e..07a90c900f 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1031,7 +1031,6 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
 static const Property xive2_router_properties[] = {
     DEFINE_PROP_LINK("xive-fabric", Xive2Router, xfb,
                      TYPE_XIVE_FABRIC, XiveFabric *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xive2_router_class_init(ObjectClass *klass, void *data)
@@ -1247,7 +1246,6 @@ static const Property xive2_end_source_properties[] = {
     DEFINE_PROP_UINT32("shift", Xive2EndSource, esb_shift, XIVE_ESB_64K),
     DEFINE_PROP_LINK("xive", Xive2EndSource, xrtr, TYPE_XIVE2_ROUTER,
                      Xive2Router *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xive2_end_source_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index 21b9c83658..ccdab244b3 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -478,7 +478,6 @@ static const Property xlnx_pmu_io_intc_properties[] = {
     DEFINE_PROP_UINT32("intc-intr-size", XlnxPMUIOIntc, cfg.intr_size, 0),
     DEFINE_PROP_UINT32("intc-level-edge", XlnxPMUIOIntc, cfg.level_edge, 0),
     DEFINE_PROP_UINT32("intc-positive", XlnxPMUIOIntc, cfg.positive, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xlnx_pmu_io_intc_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index 7ffc4ffe6f..ed75f79183 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -75,7 +75,6 @@ static void ipack_device_unrealize(DeviceState *dev)
 
 static const Property ipack_device_props[] = {
     DEFINE_PROP_INT32("slot", IPackDevice, slot, -1),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void ipack_device_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 850b3bc463..047bb90be9 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -110,7 +110,6 @@ void ipmi_bmc_find_and_link(Object *obj, Object **bmc)
 
 static const Property ipmi_bmc_properties[] = {
     DEFINE_PROP_UINT8("slave_addr",  IPMIBmc, slave_addr, 0x20),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void bmc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index cfec1da87c..d015500254 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -517,7 +517,6 @@ static void ipmi_bmc_extern_finalize(Object *obj)
 
 static const Property ipmi_bmc_extern_properties[] = {
     DEFINE_PROP_CHR("chardev", IPMIBmcExtern, chr),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ipmi_bmc_extern_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 8a55893e89..eb2eecd46a 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2203,7 +2203,6 @@ static const Property ipmi_sim_properties[] = {
     DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
     DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
     DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ipmi_sim_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 16062abb31..a1b66d5ee8 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -138,7 +138,6 @@ static void *isa_ipmi_bt_get_backend_data(IPMIInterface *ii)
 static const Property ipmi_isa_properties[] = {
     DEFINE_PROP_UINT32("ioport", ISAIPMIBTDevice, bt.io_base,  0xe4),
     DEFINE_PROP_INT32("irq",   ISAIPMIBTDevice, isairq,  5),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void isa_ipmi_bt_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 7e7a37659e..d9ebdd5371 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -145,7 +145,6 @@ static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
 static const Property ipmi_isa_properties[] = {
     DEFINE_PROP_UINT32("ioport", ISAIPMIKCSDevice, kcs.io_base,  0xca2),
     DEFINE_PROP_INT32("irq",   ISAIPMIKCSDevice, isairq,  5),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void isa_ipmi_kcs_class_init(ObjectClass *oc, void *data)
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 378244aa8f..0f94378a1d 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -840,7 +840,6 @@ static const Property ich9_lpc_properties[] = {
                      pm.swsmi_timer_enabled, true),
     DEFINE_PROP_BOOL("x-smi-periodic-timer", ICH9LPCState,
                      pm.periodic_timer_enabled, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ich9_send_gpe(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 7bb2af817d..5f5868442a 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -330,7 +330,6 @@ static const VMStateDescription vmstate_pc87312 = {
 static const Property pc87312_properties[] = {
     DEFINE_PROP_UINT16("iobase", PC87312State, iobase, 0x398),
     DEFINE_PROP_UINT8("config", PC87312State, config, 1),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void pc87312_class_init(ObjectClass *klass, void *data)
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 8ec9c63b8a..eabf256731 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -415,7 +415,6 @@ static const Property pci_piix_props[] = {
     DEFINE_PROP_BOOL("has-pit", PIIXState, has_pit, true),
     DEFINE_PROP_BOOL("has-usb", PIIXState, has_usb, true),
     DEFINE_PROP_BOOL("smm-enabled", PIIXState, smm_enabled, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pci_piix_class_init(ObjectClass *klass, void *data)
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 45e5f74600..395c49fea7 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -603,7 +603,6 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
 static const Property mcf5206_mbar_properties[] = {
     DEFINE_PROP_LINK("m68k-cpu", m5206_mbar_state, cpu,
                      TYPE_M68K_CPU, M68kCPU *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mcf5206_mbar_class_init(ObjectClass *oc, void *data)
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index c24b0b715d..008626f813 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -180,7 +180,6 @@ static void mcf_intc_instance_init(Object *obj)
 static const Property mcf_intc_properties[] = {
     DEFINE_PROP_LINK("m68k-cpu", mcf_intc_state, cpu,
                      TYPE_M68K_CPU, M68kCPU *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mcf_intc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index a37ce00874..e4fb5013de 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -916,7 +916,6 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
  */
 static const Property next_pc_properties[] = {
     DEFINE_PROP_LINK("cpu", NeXTPC, cpu, TYPE_M68K_CPU, M68kCPU *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription next_rtc_vmstate = {
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 0d8cb8b1cb..168665b382 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -205,7 +205,6 @@ static const VMStateDescription vmstate_glue = {
  */
 static const Property glue_properties[] = {
     DEFINE_PROP_LINK("cpu", GLUEState, cpu, TYPE_M68K_CPU, M68kCPU *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void glue_finalize(Object *obj)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 12205c4d32..b553c7d646 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1234,7 +1234,6 @@ static const Property ct3_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
                                 width, PCIE_LINK_WIDTH_16),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static uint64_t get_lsa_size(CXLType3Dev *ct3d)
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 10506d52e4..51362cfe92 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -248,7 +248,6 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
 
 static const Property nvdimm_properties[] = {
     DEFINE_PROP_BOOL(NVDIMM_UNARMED_PROP, NVDIMMDevice, unarmed, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void nvdimm_class_init(ObjectClass *oc, void *data)
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 49c5f9fd44..dca3db7a36 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -157,7 +157,6 @@ static const Property pc_dimm_properties[] = {
                       PC_DIMM_UNASSIGNED_SLOT),
     DEFINE_PROP_LINK(PC_DIMM_MEMDEV_PROP, PCDIMMDevice, hostmem,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
diff --git a/hw/mem/sparse-mem.c b/hw/mem/sparse-mem.c
index 8d681adfc0..375d728684 100644
--- a/hw/mem/sparse-mem.c
+++ b/hw/mem/sparse-mem.c
@@ -103,7 +103,6 @@ static const Property sparse_mem_properties[] = {
     DEFINE_PROP_UINT64("length", SparseMemState, length, UINT64_MAX),
     /* Max amount of actual memory that can be used to back the sparse memory */
     DEFINE_PROP_UINT64("maxsize", SparseMemState, maxsize, 10 * MiB),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 MemoryRegion *sparse_mem_init(uint64_t addr, uint64_t length)
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 1a2208666c..f8c17f3f2b 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -171,7 +171,6 @@ static const Property mips_cps_properties[] = {
     DEFINE_PROP_UINT32("num-irq", MIPSCPSState, num_irq, 256),
     DEFINE_PROP_STRING("cpu-type", MIPSCPSState, cpu_type),
     DEFINE_PROP_BOOL("cpu-big-endian", MIPSCPSState, cpu_is_bigendian, false),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void mips_cps_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index e2d73edde8..088d4adb0d 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -125,7 +125,6 @@ static const VMStateDescription vmstate_a9_scu = {
 
 static const Property a9_scu_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A9SCUState, num_cpu, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void a9_scu_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
index 247bf62c43..13bba26d0e 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -317,7 +317,6 @@ static void allwinner_h3_dramc_init(Object *obj)
 static const Property allwinner_h3_dramc_properties[] = {
     DEFINE_PROP_UINT64("ram-addr", AwH3DramCtlState, ram_addr, 0x0),
     DEFINE_PROP_UINT32("ram-size", AwH3DramCtlState, ram_size, 256 * MiB),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const VMStateDescription allwinner_h3_dramc_vmstate = {
diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index a51284ff91..97c3664e3a 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -467,7 +467,6 @@ static void allwinner_r40_dramc_init(Object *obj)
 static const Property allwinner_r40_dramc_properties[] = {
     DEFINE_PROP_UINT64("ram-addr", AwR40DramCtlState, ram_addr, 0x0),
     DEFINE_PROP_UINT32("ram-size", AwR40DramCtlState, ram_size, 256), /* MiB */
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const VMStateDescription allwinner_r40_dramc_vmstate = {
diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
index 3a09dca111..042b747f30 100644
--- a/hw/misc/allwinner-sid.c
+++ b/hw/misc/allwinner-sid.c
@@ -129,7 +129,6 @@ static void allwinner_sid_init(Object *obj)
 
 static const Property allwinner_sid_properties[] = {
     DEFINE_PROP_UUID_NODEFAULT("identifier", AwSidState, identifier),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const VMStateDescription allwinner_sid_vmstate = {
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 9d0e273e33..97ea842d60 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -354,7 +354,6 @@ static const Property applesmc_isa_properties[] = {
     DEFINE_PROP_UINT32(APPLESMC_PROP_IO_BASE, AppleSMCState, iobase,
                        APPLESMC_DEFAULT_IOBASE),
     DEFINE_PROP_STRING("osk", AppleSMCState, osk),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void build_applesmc_aml(AcpiDevAmlIf *adev, Aml *scope)
diff --git a/hw/misc/arm11scu.c b/hw/misc/arm11scu.c
index 37feed9da7..02493cec31 100644
--- a/hw/misc/arm11scu.c
+++ b/hw/misc/arm11scu.c
@@ -77,7 +77,6 @@ static void arm11_scu_init(Object *obj)
 
 static const Property arm11_scu_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", ARM11SCUState, num_cpu, 1),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void arm11_scu_class_init(ObjectClass *oc, void *data)
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index 9c209f13b0..39b4642da7 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -175,7 +175,6 @@ static void l2x0_priv_init(Object *obj)
 
 static const Property l2x0_properties[] = {
     DEFINE_PROP_UINT32("cache-type", L2x0State, cache_type, 0x1c100100),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void l2x0_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 69e379fa10..1c25d51b96 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -632,7 +632,6 @@ static const Property arm_sysctl_properties[] = {
     /* Daughterboard clock reset values (as reported via SYS_CFG) */
     DEFINE_PROP_ARRAY("db-clock", arm_sysctl_state, db_num_clocks,
                       db_clock_reset, qdev_prop_uint32, uint32_t),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void arm_sysctl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
index b05bcdcabc..58cb37333f 100644
--- a/hw/misc/armsse-cpuid.c
+++ b/hw/misc/armsse-cpuid.c
@@ -94,7 +94,6 @@ static const MemoryRegionOps armsse_cpuid_ops = {
 
 static const Property armsse_cpuid_props[] = {
     DEFINE_PROP_UINT32("CPUID", ARMSSECPUID, cpuid, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void armsse_cpuid_init(Object *obj)
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 5cefbadf9a..e3f7df2e86 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -439,7 +439,6 @@ static void aspeed_hace_realize(DeviceState *dev, Error **errp)
 static const Property aspeed_hace_properties[] = {
     DEFINE_PROP_LINK("dram", AspeedHACEState, dram_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 
diff --git a/hw/misc/aspeed_i3c.c b/hw/misc/aspeed_i3c.c
index 7f5a389864..ab39c6435b 100644
--- a/hw/misc/aspeed_i3c.c
+++ b/hw/misc/aspeed_i3c.c
@@ -325,7 +325,6 @@ static void aspeed_i3c_realize(DeviceState *dev, Error **errp)
 
 static const Property aspeed_i3c_device_properties[] = {
     DEFINE_PROP_UINT8("device-id", AspeedI3CDevice, id, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_i3c_device_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c
index bb9066b0f0..228d250dc0 100644
--- a/hw/misc/aspeed_lpc.c
+++ b/hw/misc/aspeed_lpc.c
@@ -456,7 +456,6 @@ static const VMStateDescription vmstate_aspeed_lpc = {
 
 static const Property aspeed_lpc_properties[] = {
     DEFINE_PROP_UINT32("hicr7", AspeedLPCState, hicr7, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_lpc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index b97cf51fa1..e4a6bd1581 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -139,7 +139,6 @@ static const VMStateDescription vmstate_aspeed_sbc = {
 static const Property aspeed_sbc_properties[] = {
     DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),
     DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_sbc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index ac33b8d6cb..bac1441b06 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -607,7 +607,6 @@ static const Property aspeed_scu_properties[] = {
     DEFINE_PROP_UINT32("hw-strap1", AspeedSCUState, hw_strap1, 0),
     DEFINE_PROP_UINT32("hw-strap2", AspeedSCUState, hw_strap2, 0),
     DEFINE_PROP_UINT32("hw-prot-key", AspeedSCUState, hw_prot_key, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_scu_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 4980080f74..f359640a9a 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -297,7 +297,6 @@ static const VMStateDescription vmstate_aspeed_sdmc = {
 static const Property aspeed_sdmc_properties[] = {
     DEFINE_PROP_UINT64("max-ram-size", AspeedSDMCState, max_ram_size, 0),
     DEFINE_PROP_BOOL("unlocked", AspeedSDMCState, unlocked, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_sdmc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 1a20cd0bc8..aa14cd931f 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -780,7 +780,6 @@ static const VMStateDescription cprman_vmstate = {
 
 static const Property cprman_properties[] = {
     DEFINE_PROP_UINT32("xosc-freq-hz", BCM2835CprmanState, xosc_freq, 19200000),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void cprman_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 09a6f2c6e3..fde66cd590 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -554,7 +554,6 @@ static void bcm2835_property_realize(DeviceState *dev, Error **errp)
 static const Property bcm2835_property_props[] = {
     DEFINE_PROP_UINT32("board-rev", BCM2835PropertyState, board_rev, 0),
     DEFINE_PROP_STRING("command-line", BCM2835PropertyState, command_line),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void bcm2835_property_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index 639a8cc3e3..260537bba3 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -59,7 +59,6 @@ static void debug_exit_realizefn(DeviceState *d, Error **errp)
 static const Property debug_exit_properties[] = {
     DEFINE_PROP_UINT32("iobase", ISADebugExitState, iobase, 0x501),
     DEFINE_PROP_UINT32("iosize", ISADebugExitState, iosize, 0x02),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void debug_exit_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index 4fc88bd4e5..d7452c4cc8 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -327,7 +327,6 @@ static void ecc_realize(DeviceState *dev, Error **errp)
 
 static const Property ecc_properties[] = {
     DEFINE_PROP_UINT32("version", ECCState, version, -1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ecc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index 79572c5be0..221ea7cb54 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -82,7 +82,6 @@ static void empty_slot_realize(DeviceState *dev, Error **errp)
 static const Property empty_slot_properties[] = {
     DEFINE_PROP_UINT64("size", EmptySlot, size, 0),
     DEFINE_PROP_STRING("name", EmptySlot, name),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void empty_slot_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index abb6a963ca..04ced3559c 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -816,7 +816,6 @@ static const VMStateDescription iotkit_secctl_vmstate = {
 
 static const Property iotkit_secctl_props[] = {
     DEFINE_PROP_UINT32("sse-version", IoTKitSecCtl, sse_version, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void iotkit_secctl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index 23b49d7dff..57ffdc3d02 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -842,7 +842,6 @@ static const Property iotkit_sysctl_props[] = {
                        0x10000000),
     DEFINE_PROP_UINT32("INITSVTOR1_RST", IoTKitSysCtl, initsvtor1_rst,
                        0x10000000),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void iotkit_sysctl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 7d4eea6bfb..75260f7fab 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -136,7 +136,6 @@ static const Property iotkit_sysinfo_props[] = {
     DEFINE_PROP_UINT32("SYS_CONFIG", IoTKitSysInfo, sys_config, 0),
     DEFINE_PROP_UINT32("sse-version", IoTKitSysInfo, sse_version, 0),
     DEFINE_PROP_UINT32("IIDR", IoTKitSysInfo, iidr, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void iotkit_sysinfo_init(Object *obj)
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 6d735ec29f..8f9e1f2fc6 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1026,7 +1026,6 @@ static const Property ivshmem_plain_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("master", IVShmemState, master, ON_OFF_AUTO_OFF),
     DEFINE_PROP_LINK("memdev", IVShmemState, hostmem, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ivshmem_plain_realize(PCIDevice *dev, Error **errp)
@@ -1083,7 +1082,6 @@ static const Property ivshmem_doorbell_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", IVShmemState, features, IVSHMEM_IOEVENTFD,
                     true),
     DEFINE_PROP_ON_OFF_AUTO("master", IVShmemState, master, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ivshmem_doorbell_init(Object *obj)
diff --git a/hw/misc/led.c b/hw/misc/led.c
index 76efdbc3f1..9364d9945e 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -105,7 +105,6 @@ static const Property led_properties[] = {
     DEFINE_PROP_STRING("color", LEDState, color),
     DEFINE_PROP_STRING("description", LEDState, description),
     DEFINE_PROP_BOOL("gpio-active-high", LEDState, gpio_active_high, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void led_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index a376a2b8a0..5d16bff12c 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -1324,7 +1324,6 @@ static const VMStateDescription vmstate_q800_via1 = {
 
 static const Property mos6522_q800_via1_properties[] = {
     DEFINE_PROP_DRIVE("drive", MOS6522Q800VIA1State, blk),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mos6522_q800_via1_class_init(ObjectClass *oc, void *data)
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index cfc8afd1dc..270adcb0cd 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -556,7 +556,6 @@ static void cuda_init(Object *obj)
 
 static const Property cuda_properties[] = {
     DEFINE_PROP_UINT64("timebase-frequency", CUDAState, tb_frequency, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void cuda_class_init(ObjectClass *oc, void *data)
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 7e3d5aa977..194b152eff 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -408,7 +408,6 @@ static const VMStateDescription vmstate_macio_newworld = {
 static const Property macio_newworld_properties[] = {
     DEFINE_PROP_BOOL("has-pmu", NewWorldMacIOState, has_pmu, false),
     DEFINE_PROP_BOOL("has-adb", NewWorldMacIOState, has_adb, false),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void macio_newworld_class_init(ObjectClass *oc, void *data)
@@ -424,7 +423,6 @@ static void macio_newworld_class_init(ObjectClass *oc, void *data)
 
 static const Property macio_properties[] = {
     DEFINE_PROP_UINT64("frequency", MacIOState, frequency, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void macio_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 64bf44f67f..47ebb8e8c0 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -762,7 +762,6 @@ static void pmu_init(Object *obj)
 
 static const Property pmu_properties[] = {
     DEFINE_PROP_BOOL("has-adb", PMUState, has_adb, true),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void pmu_class_init(ObjectClass *oc, void *data)
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 80ca224f76..95f19912b4 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -219,7 +219,6 @@ static const Property mips_gcr_properties[] = {
                      MemoryRegion *),
     DEFINE_PROP_LINK("cpc", MIPSGCRState, cpc_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mips_gcr_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 86ff0f7ad8..772b8c0017 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -166,7 +166,6 @@ static const VMStateDescription vmstate_mips_cpc = {
 static const Property mips_cpc_properties[] = {
     DEFINE_PROP_UINT32("num-vp", MIPSCPCState, num_vp, 0x1),
     DEFINE_PROP_UINT64("vp-start-running", MIPSCPCState, vp_start_running, 0x1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mips_cpc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index d84a7dbf15..2d126ebaf8 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -538,7 +538,6 @@ static const Property mips_itu_properties[] = {
                       ITC_FIFO_NUM_MAX),
     DEFINE_PROP_UINT32("num-semaphores", MIPSITUState, num_semaphores,
                       ITC_SEMAPH_NUM_MAX),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mips_itu_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 0225a5869b..0b8f6a4cb4 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -698,7 +698,6 @@ static void mos6522_finalize(Object *obj)
 
 static const Property mos6522_properties[] = {
     DEFINE_PROP_UINT64("frequency", MOS6522State, frequency, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void mos6522_class_init(ObjectClass *oc, void *data)
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 2e8d1c721c..d07568248d 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -326,7 +326,6 @@ static const Property mps2_fpgaio_properties[] = {
     DEFINE_PROP_UINT32("num-leds", MPS2FPGAIO, num_leds, 2),
     DEFINE_PROP_BOOL("has-switches", MPS2FPGAIO, has_switches, false),
     DEFINE_PROP_BOOL("has-dbgctrl", MPS2FPGAIO, has_dbgctrl, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mps2_fpgaio_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index f378b75571..5f8d6bca43 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -472,7 +472,6 @@ static const Property mps2_scc_properties[] = {
      */
     DEFINE_PROP_ARRAY("oscclk", MPS2SCC, num_oscclk, oscclk_reset,
                       qdev_prop_uint32, uint32_t),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mps2_scc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index 0d7a713c76..20009adbd9 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -122,7 +122,6 @@ static const Property msf2_sysreg_properties[] = {
     /* default divisors in Libero GUI */
     DEFINE_PROP_UINT8("apb0divisor", MSF2SysregState, apb0div, 2),
     DEFINE_PROP_UINT8("apb1divisor", MSF2SysregState, apb1div, 2),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void msf2_sysreg_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
index 17aeaf22cb..07464a4dc9 100644
--- a/hw/misc/npcm7xx_gcr.c
+++ b/hw/misc/npcm7xx_gcr.c
@@ -232,7 +232,6 @@ static const VMStateDescription vmstate_npcm7xx_gcr = {
 static const Property npcm7xx_gcr_properties[] = {
     DEFINE_PROP_UINT32("disabled-modules", NPCM7xxGCRState, reset_mdlr, 0),
     DEFINE_PROP_UINT32("power-on-straps", NPCM7xxGCRState, reset_pwron, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index 2b550a6bca..1e67acdf23 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -224,7 +224,6 @@ static const Property nrf51_rng_properties[] = {
             period_unfiltered_us, 167),
     DEFINE_PROP_UINT16("period_filtered_us", NRF51RNGState,
             period_filtered_us, 660),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_rng = {
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 7927397a23..ca6a388431 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -321,7 +321,6 @@ static void qdev_pci_testdev_reset(DeviceState *dev)
 
 static const Property pci_testdev_properties[] = {
     DEFINE_PROP_SIZE("membar", PCITestDevState, membar_size, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pci_testdev_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index 824a2e4528..f9a3156a5c 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -102,7 +102,6 @@ static const Property pvpanic_isa_properties[] = {
     DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicISAState, ioport, 0x505),
     DEFINE_PROP_UINT8("events", PVPanicISAState, pvpanic.events,
                       PVPANIC_EVENTS),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pvpanic_isa_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index 1c3eafc137..967842359f 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -56,7 +56,6 @@ static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
 static const Property pvpanic_pci_properties[] = {
     DEFINE_PROP_UINT8("events", PVPanicPCIState, pvpanic.events,
                       PVPANIC_EVENTS),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pvpanic_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
index c48429b131..165e41dfc3 100644
--- a/hw/misc/sifive_e_aon.c
+++ b/hw/misc/sifive_e_aon.c
@@ -292,7 +292,6 @@ static void sifive_e_aon_init(Object *obj)
 static const Property sifive_e_aon_properties[] = {
     DEFINE_PROP_UINT64("wdogclk-frequency", SiFiveEAONState, wdogclk_freq,
                        SIFIVE_E_LFCLK_DEFAULT_FREQ),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sifive_e_aon_class_init(ObjectClass *oc, void *data)
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index 32cd8e8dfb..955134af0d 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -197,7 +197,6 @@ static const MemoryRegionOps sifive_u_otp_ops = {
 static const Property sifive_u_otp_properties[] = {
     DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
     DEFINE_PROP_DRIVE("drive", SiFiveUOTPState, blk),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sifive_u_otp_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index b61241d195..fd8466dff3 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -1433,7 +1433,6 @@ static const Property stm32l4x5_rcc_properties[] = {
         sai1_extclk_frequency, 0),
     DEFINE_PROP_UINT64("sai2_extclk_frequency", Stm32l4x5RccState,
         sai2_extclk_frequency, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void stm32l4x5_rcc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index b06eb9f119..6d827d21dc 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -590,7 +590,6 @@ static const VMStateDescription tz_mpc_vmstate = {
 static const Property tz_mpc_properties[] = {
     DEFINE_PROP_LINK("downstream", TZMPC, downstream,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void tz_mpc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index 96413a502d..505df4e190 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -283,7 +283,6 @@ static const Property tz_msc_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_LINK("idau", TZMSC, idau,
                      TYPE_IDAU_INTERFACE, IDAUInterface *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void tz_msc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 1943d8d165..1daa54c5e6 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -323,7 +323,6 @@ static const Property tz_ppc_properties[] = {
     DEFINE_PORT(13),
     DEFINE_PORT(14),
     DEFINE_PORT(15),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void tz_ppc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index 62e1153627..257282a3a9 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -73,7 +73,6 @@ static void unimp_realize(DeviceState *dev, Error **errp)
 static const Property unimp_properties[] = {
     DEFINE_PROP_UINT64("size", UnimplementedDeviceState, size, 0),
     DEFINE_PROP_STRING("name", UnimplementedDeviceState, name),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void unimp_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 8281a9baff..8db0f7e658 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -737,7 +737,6 @@ static const Property cframe_regs_props[] = {
                        cfg.blktype_num_frames[5], 0),
     DEFINE_PROP_UINT32("blktype6-frames", XlnxVersalCFrameReg,
                        cfg.blktype_num_frames[6], 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void cframe_bcast_reg_init(Object *obj)
@@ -802,7 +801,6 @@ static const Property cframe_bcast_regs_props[] = {
                      TYPE_XLNX_CFI_IF, XlnxCfiIf *),
     DEFINE_PROP_LINK("cframe14", XlnxVersalCFrameBcastReg, cfg.cframe[14],
                      TYPE_XLNX_CFI_IF, XlnxCfiIf *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void cframe_reg_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 7cfdabdb8e..26d06e2557 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -457,13 +457,11 @@ static const Property cfu_props[] = {
                          TYPE_XLNX_CFI_IF, XlnxCfiIf *),
         DEFINE_PROP_LINK("cframe14", XlnxVersalCFUAPB, cfg.cframe[14],
                          TYPE_XLNX_CFI_IF, XlnxCfiIf *),
-        DEFINE_PROP_END_OF_LIST(),
 };
 
 static const Property cfu_sfr_props[] = {
         DEFINE_PROP_LINK("cfu", XlnxVersalCFUSFR, cfg.cfu,
                          TYPE_XLNX_VERSAL_CFU_APB, XlnxVersalCFUAPB *),
-        DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_cfu_apb = {
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 2f6af4f680..0419f648b7 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -666,8 +666,6 @@ static const Property trng_props[] = {
     DEFINE_PROP_UINT32("hw-version", XlnxVersalTRng, hw_version, 0x0200),
     DEFINE_PROP("fips-fault-events", XlnxVersalTRng, forced_faults,
                 trng_prop_fault_events, uint32_t),
-
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_trng = {
diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
index a06b9fbc05..d1e76be027 100644
--- a/hw/misc/xlnx-versal-xramc.c
+++ b/hw/misc/xlnx-versal-xramc.c
@@ -220,7 +220,6 @@ static const VMStateDescription vmstate_xram_ctrl = {
 
 static const Property xram_ctrl_properties[] = {
     DEFINE_PROP_UINT64("size", XlnxXramCtrl, cfg.size, 1 * MiB),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xram_ctrl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index ffa14ecb84..f4fa3b1840 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -625,7 +625,6 @@ static const VMStateDescription vmstate_zynq_slcr = {
 
 static const Property zynq_slcr_props[] = {
     DEFINE_PROP_UINT8("boot-mode", ZynqSLCRState, boot_mode, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void zynq_slcr_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 3f03060bf5..314a28af6d 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -834,7 +834,6 @@ static const Property allwinner_sun8i_emac_properties[] = {
     DEFINE_PROP_UINT8("phy-addr", AwSun8iEmacState, mii_phy_addr, 0),
     DEFINE_PROP_LINK("dma-memory", AwSun8iEmacState, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static int allwinner_sun8i_emac_post_load(void *opaque, int version_id)
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 39c10426cf..3eb9e09dc5 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -465,7 +465,6 @@ static void aw_emac_realize(DeviceState *dev, Error **errp)
 static const Property aw_emac_properties[] = {
     DEFINE_NIC_PROPERTIES(AwEmacState, conf),
     DEFINE_PROP_UINT8("phy-addr", AwEmacState, phy_addr, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_mii = {
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 3fce01315f..0282bd1d7f 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1799,7 +1799,6 @@ static const Property gem_properties[] = {
                        jumbo_max_len, 10240),
     DEFINE_PROP_LINK("dma", CadenceGEMState, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void gem_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 97fa46c4b3..dc242e9215 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -2052,7 +2052,6 @@ static const Property canfd_core_properties[] = {
                        CANFD_DEFAULT_CLOCK),
     DEFINE_PROP_LINK("canfdbus", XlnxVersalCANFDState, canfdbus, TYPE_CAN_BUS,
                      CanBusState *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void canfd_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index 61c104c18b..9fbdeea368 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -1174,7 +1174,6 @@ static const Property xlnx_zynqmp_can_properties[] = {
                        CAN_DEFAULT_CLOCK),
     DEFINE_PROP_LINK("canbus", XlnxZynqMPCANState, canbus, TYPE_CAN_BUS,
                      CanBusState *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xlnx_zynqmp_can_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index e3ca11991b..c80ddb12e3 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -937,7 +937,6 @@ static const Property dp8393x_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
     DEFINE_PROP_BOOL("big_endian", dp8393xState, big_endian, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void dp8393x_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index ef0af31751..7348d39632 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1685,7 +1685,6 @@ static const Property e1000_properties[] = {
                     compat_flags, E1000_FLAG_TSO_BIT, true),
     DEFINE_PROP_BIT("init-vet", E1000State,
                     compat_flags, E1000_FLAG_VET_BIT, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 typedef struct E1000Info {
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index e2b7576f67..544a39eae9 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -672,7 +672,6 @@ static const Property e1000e_properties[] = {
                         e1000e_prop_subsys, uint16_t),
     DEFINE_PROP_BOOL("init-vet", E1000EState, init_vet, true),
     DEFINE_PROP_BOOL("migrate-timadj", E1000EState, timadj, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void e1000e_class_init(ObjectClass *class, void *data)
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index b8cb8d5cf1..5801cb0635 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -2060,7 +2060,6 @@ static E100PCIDeviceInfo *eepro100_get_class(EEPRO100State *s)
 
 static const Property e100_properties[] = {
     DEFINE_NIC_PROPERTIES(EEPRO100State, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void eepro100_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 764be2c6a2..781b900395 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -416,7 +416,6 @@ static void etsec_instance_init(Object *obj)
 
 static const Property etsec_properties[] = {
     DEFINE_NIC_PROPERTIES(eTSEC, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void etsec_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 4adc7fb10c..40a13d1667 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1258,7 +1258,6 @@ static const Property ftgmac100_properties[] = {
     DEFINE_PROP_BOOL("aspeed", FTGMAC100State, aspeed, false),
     DEFINE_NIC_PROPERTIES(FTGMAC100State, conf),
     DEFINE_PROP_BOOL("dma64", FTGMAC100State, dma64, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ftgmac100_class_init(ObjectClass *klass, void *data)
@@ -1418,7 +1417,6 @@ static const VMStateDescription vmstate_aspeed_mii = {
 static const Property aspeed_mii_properties[] = {
     DEFINE_PROP_LINK("nic", AspeedMiiState, nic, TYPE_FTGMAC100,
                      FTGMAC100State *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_mii_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/igb.c b/hw/net/igb.c
index ad0f748d82..ae973f40d6 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -594,7 +594,6 @@ static const VMStateDescription igb_vmstate = {
 static const Property igb_properties[] = {
     DEFINE_NIC_PROPERTIES(IGBState, conf),
     DEFINE_PROP_BOOL("x-pcie-flr-init", IGBState, has_flr, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void igb_class_init(ObjectClass *class, void *data)
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 9b64968477..e0342d9363 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1229,7 +1229,6 @@ static const Property imx_eth_properties[] = {
     DEFINE_PROP_BOOL("phy-connected", IMXFECState, phy_connected, true),
     DEFINE_PROP_LINK("phy-consumer", IMXFECState, phy_consumer, TYPE_IMX_FEC,
                      IMXFECState *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void imx_eth_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 237e9b97d5..afee68c7db 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1307,7 +1307,6 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
 static const Property lan9118_properties[] = {
     DEFINE_NIC_PROPERTIES(lan9118_state, conf),
     DEFINE_PROP_UINT32("mode_16bit", lan9118_state, mode_16bit, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void lan9118_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 9ed9c94cff..a0945e1c88 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -141,7 +141,6 @@ static const Property lance_properties[] = {
     DEFINE_PROP_LINK("dma", SysBusPCNetState, state.dma_opaque,
                      TYPE_DEVICE, DeviceState *),
     DEFINE_NIC_PROPERTIES(SysBusPCNetState, state.conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void lance_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 248e3841db..95f56311d9 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -160,7 +160,6 @@ static void lasi_82596_instance_init(Object *obj)
 
 static const Property lasi_82596_properties[] = {
     DEFINE_NIC_PROPERTIES(SysBusI82596State, state.conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void lasi_82596_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 55bad4c069..d5572a81d3 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -662,7 +662,6 @@ static void mcf_fec_instance_init(Object *obj)
 
 static const Property mcf_fec_properties[] = {
     DEFINE_NIC_PROPERTIES(mcf_fec_state, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mcf_fec_class_init(ObjectClass *oc, void *data)
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index c9ef1beb7b..8852b6f3a1 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -268,7 +268,6 @@ static void mipsnet_sysbus_reset(DeviceState *dev)
 
 static const Property mipsnet_properties[] = {
     DEFINE_NIC_PROPERTIES(MIPSnetState, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mipsnet_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/msf2-emac.c b/hw/net/msf2-emac.c
index 8d9015f962..80f75f19dd 100644
--- a/hw/net/msf2-emac.c
+++ b/hw/net/msf2-emac.c
@@ -550,7 +550,6 @@ static const Property msf2_emac_properties[] = {
     DEFINE_PROP_LINK("ahb-bus", MSF2EmacState, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_NIC_PROPERTIES(MSF2EmacState, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_msf2_emac = {
diff --git a/hw/net/mv88w8618_eth.c b/hw/net/mv88w8618_eth.c
index ccb11512db..a1f51f7ade 100644
--- a/hw/net/mv88w8618_eth.c
+++ b/hw/net/mv88w8618_eth.c
@@ -375,7 +375,6 @@ static const Property mv88w8618_eth_properties[] = {
     DEFINE_NIC_PROPERTIES(mv88w8618_eth_state, conf),
     DEFINE_PROP_LINK("dma-memory", mv88w8618_eth_state, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mv88w8618_eth_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 1cd070d419..c445f2a222 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -83,7 +83,6 @@ static const Property ne2000_isa_properties[] = {
     DEFINE_PROP_UINT32("iobase", ISANE2000State, iobase, 0x300),
     DEFINE_PROP_UINT32("irq",   ISANE2000State, isairq, 9),
     DEFINE_NIC_PROPERTIES(ISANE2000State, ne2000.c),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void isa_ne2000_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index 12fa579d22..929e9a1930 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -98,7 +98,6 @@ static void ne2000_instance_init(Object *obj)
 
 static const Property ne2000_properties[] = {
     DEFINE_NIC_PROPERTIES(PCINE2000State, ne2000.c),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ne2000_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index f06e908d04..cc38080c7d 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -847,7 +847,6 @@ static const VMStateDescription vmstate_npcm7xx_emc = {
 
 static const Property npcm7xx_emc_properties[] = {
     DEFINE_NIC_PROPERTIES(NPCM7xxEMCState, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void npcm7xx_emc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 1db29307d7..6d7f8398b6 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -914,7 +914,6 @@ static const VMStateDescription vmstate_npcm_gmac = {
 
 static const Property npcm_gmac_properties[] = {
     DEFINE_NIC_PROPERTIES(NPCMGMACState, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void npcm_gmac_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 003b452bc9..54daab7b04 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -745,7 +745,6 @@ static void qdev_open_eth_reset(DeviceState *dev)
 
 static const Property open_eth_properties[] = {
     DEFINE_NIC_PROPERTIES(OpenEthState, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void open_eth_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 83ba8cd949..b8e9ff95e8 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -254,7 +254,6 @@ static void pcnet_instance_init(Object *obj)
 
 static const Property pcnet_properties[] = {
     DEFINE_NIC_PROPERTIES(PCIPCNetState, state.conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pcnet_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index efc20396aa..aa5d87fbc5 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1468,7 +1468,6 @@ static const Property rocker_properties[] = {
                        switch_id, 0),
     DEFINE_PROP_ARRAY("ports", Rocker, fp_ports,
                       fp_ports_peers, qdev_prop_netdev, NICPeers),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription rocker_vmsd = {
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 064a73b6b4..3245aa1f1d 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3412,7 +3412,6 @@ static void rtl8139_instance_init(Object *obj)
 
 static const Property rtl8139_properties[] = {
     DEFINE_NIC_PROPERTIES(RTL8139State, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void rtl8139_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index a853c30fa2..b18d5c23c3 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -790,7 +790,6 @@ static void smc91c111_realize(DeviceState *dev, Error **errp)
 
 static const Property smc91c111_properties[] = {
     DEFINE_NIC_PROPERTIES(smc91c111_state, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void smc91c111_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index d381c041db..da98a7ec3e 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -791,7 +791,6 @@ static const Property spapr_vlan_properties[] = {
     DEFINE_NIC_PROPERTIES(SpaprVioVlan, nicconf),
     DEFINE_PROP_BIT("use-rx-buffer-pools", SpaprVioVlan,
                     compat_flags, SPAPRVLAN_FLAG_RX_BUF_POOLS_BIT, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static bool spapr_vlan_rx_buffer_pools_needed(void *opaque)
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 4af1afa733..a420732d48 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -499,7 +499,6 @@ static void stellaris_enet_realize(DeviceState *dev, Error **errp)
 
 static const Property stellaris_enet_properties[] = {
     DEFINE_NIC_PROPERTIES(stellaris_enet_state, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void stellaris_enet_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index bcc7a18382..e1c672acd3 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1427,7 +1427,6 @@ static const Property sungem_properties[] = {
      * override.
      */
     DEFINE_PROP_UINT32("phy_addr", SunGEMState, phy_addr, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_sungem = {
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 86f472fcbe..539e0d5e46 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -179,7 +179,6 @@ struct SunHMEState {
 
 static const Property sunhme_properties[] = {
     DEFINE_NIC_PROPERTIES(SunHMEState, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sunhme_reset_tx(SunHMEState *s)
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index f35b58a88c..d753dc790d 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -1009,7 +1009,6 @@ static void tulip_instance_init(Object *obj)
 
 static const Property tulip_properties[] = {
     DEFINE_NIC_PROPERTIES(TULIPState, c),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void tulip_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4fd1f9acca..e2d3d18804 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4057,7 +4057,6 @@ static const Property virtio_net_properties[] = {
                       VIRTIO_NET_F_GUEST_USO6, true),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                       VIRTIO_NET_F_HOST_USO, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_net_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index f69547cad5..4c77d69b78 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2477,7 +2477,6 @@ static const Property vmxnet3_properties[] = {
                     VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", VMXNET3State, compat_flags,
                     VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vmxnet3_realize(DeviceState *qdev, Error **errp)
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 5a5259150a..97ebd9fa30 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -558,7 +558,6 @@ static void xen_netdev_unrealize(XenDevice *xendev)
 static const Property xen_netdev_properties[] = {
     DEFINE_NIC_PROPERTIES(XenNetDev, conf),
     DEFINE_PROP_INT32("idx", XenNetDev, dev, -1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xen_netdev_class_init(ObjectClass *class, void *data)
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 6e0f96f485..e3cc4c60eb 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -416,7 +416,6 @@ static void xgmac_enet_realize(DeviceState *dev, Error **errp)
 
 static const Property xgmac_properties[] = {
     DEFINE_NIC_PROPERTIES(XgmacState, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xgmac_enet_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 9d0c618e2f..457952af19 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -1005,7 +1005,6 @@ static const Property xilinx_enet_properties[] = {
                      tx_data_dev, TYPE_STREAM_SINK, StreamSink *),
     DEFINE_PROP_LINK("axistream-control-connected", XilinxAXIEnet,
                      tx_control_dev, TYPE_STREAM_SINK, StreamSink *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xilinx_enet_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 9413731d20..f3eb2af193 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -255,7 +255,6 @@ static const Property xilinx_ethlite_properties[] = {
     DEFINE_PROP_UINT32("tx-ping-pong", struct xlx_ethlite, c_tx_pingpong, 1),
     DEFINE_PROP_UINT32("rx-ping-pong", struct xlx_ethlite, c_rx_pingpong, 1),
     DEFINE_NIC_PROPERTIES(struct xlx_ethlite, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xilinx_ethlite_class_init(ObjectClass *klass, void *data)
diff --git a/hw/nubus/nubus-bridge.c b/hw/nubus/nubus-bridge.c
index 83893e5a46..8fe4362723 100644
--- a/hw/nubus/nubus-bridge.c
+++ b/hw/nubus/nubus-bridge.c
@@ -26,7 +26,6 @@ static void nubus_bridge_init(Object *obj)
 static const Property nubus_bridge_properties[] = {
     DEFINE_PROP_UINT16("slot-available-mask", NubusBridge,
                        bus.slot_available_mask, 0xffff),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void nubus_bridge_class_init(ObjectClass *klass, void *data)
diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 7cafc13427..6755c3dc43 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -110,7 +110,6 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
 static const Property nubus_device_properties[] = {
     DEFINE_PROP_INT32("slot", NubusDevice, slot, -1),
     DEFINE_PROP_STRING("romfile", NubusDevice, romfile),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void nubus_device_class_init(ObjectClass *oc, void *data)
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 33a3062466..d9c8dace1e 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8965,7 +8965,6 @@ static const Property nvme_props[] = {
     DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
     DEFINE_PROP_UINT16("atomic.awupf", NvmeCtrl, params.atomic_awupf, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void nvme_get_smart_warning(Object *obj, Visitor *v, const char *name,
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 192b80f18d..0a7881b21f 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -834,7 +834,6 @@ static const Property nvme_ns_props[] = {
     DEFINE_PROP_BOOL("eui64-default", NvmeNamespace, params.eui64_default,
                      false),
     DEFINE_PROP_STRING("fdp.ruhs", NvmeNamespace, params.fdp.ruhs),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void nvme_ns_class_init(ObjectClass *oc, void *data)
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 3171c3888c..2ae56f12a5 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -223,7 +223,6 @@ static const Property nvme_subsystem_props[] = {
                      NVME_DEFAULT_RU_SIZE),
     DEFINE_PROP_UINT32("fdp.nrg", NvmeSubsystem, params.fdp.nrg, 1),
     DEFINE_PROP_UINT16("fdp.nruh", NvmeSubsystem, params.fdp.nruh, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void nvme_subsys_class_init(ObjectClass *oc, void *data)
diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 19bf8d2091..6b2aa8c7d2 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -145,7 +145,6 @@ static void nvram_sysbus_realize(DeviceState *dev, Error **errp)
 static const Property nvram_sysbus_properties[] = {
     DEFINE_PROP_UINT32("size", SysBusNvRamState, nvram.chip_size, 0x2000),
     DEFINE_PROP_STRING("filename", SysBusNvRamState, nvram.filename),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void nvram_sysbus_class_init(ObjectClass *klass, void *data)
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 669920b2b9..5f525d37e4 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -239,7 +239,6 @@ static const Property at24c_eeprom_props[] = {
     DEFINE_PROP_UINT8("address-size", EEPROMState, asize, 0),
     DEFINE_PROP_BOOL("writable", EEPROMState, writable, true),
     DEFINE_PROP_DRIVE("drive", EEPROMState, blk),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7461d99ff2..327d623d8d 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1084,7 +1084,6 @@ static void fw_cfg_machine_ready(struct Notifier *n, void *data)
 
 static const Property fw_cfg_properties[] = {
     DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState, acpi_mr_restore, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
@@ -1278,7 +1277,6 @@ static const Property fw_cfg_io_properties[] = {
                      true),
     DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slots,
                        FW_CFG_FILE_SLOTS_DFLT),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
@@ -1328,7 +1326,6 @@ static const Property fw_cfg_mem_properties[] = {
                      true),
     DEFINE_PROP_UINT16("x-file-slots", FWCfgMemState, parent_obj.file_slots,
                        FW_CFG_FILE_SLOTS_DFLT),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index d62ad719c8..db42817e1f 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -138,7 +138,6 @@ static const Property macio_nvram_properties[] = {
     DEFINE_PROP_UINT32("size", MacIONVRAMState, size, 0),
     DEFINE_PROP_UINT32("it_shift", MacIONVRAMState, it_shift, 0),
     DEFINE_PROP_DRIVE("drive", MacIONVRAMState, blk),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void macio_nvram_class_init(ObjectClass *oc, void *data)
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index 236049462b..2ed4078858 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -356,7 +356,6 @@ static void nrf51_nvm_reset(DeviceState *dev)
 
 static const Property nrf51_nvm_properties[] = {
     DEFINE_PROP_UINT32("flash-size", NRF51NVMState, flash_size, 0x40000),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_nvm = {
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 2251ff2f4c..1230884f52 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -255,7 +255,6 @@ static const VMStateDescription vmstate_spapr_nvram = {
 static const Property spapr_nvram_properties[] = {
     DEFINE_SPAPR_PROPERTIES(SpaprNvram, sdev),
     DEFINE_PROP_DRIVE("drive", SpaprNvram, blk),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void spapr_nvram_class_init(ObjectClass *klass, void *data)
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 4fa528f048..d3f238fc83 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -523,7 +523,6 @@ static const VMStateDescription vmstate_bbram_ctrl = {
 static const Property bbram_ctrl_props[] = {
     DEFINE_PROP("drive", XlnxBBRam, blk, bbram_prop_drive, BlockBackend *),
     DEFINE_PROP_UINT32("crc-zpads", XlnxBBRam, crc_zpads, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void bbram_ctrl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 5dae9e8e9a..f1787d0db5 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -272,7 +272,6 @@ static const Property efuse_properties[] = {
     DEFINE_PROP_BOOL("init-factory-tbits", XlnxEFuse, init_tbits, true),
     DEFINE_PROP_ARRAY("read-only", XlnxEFuse, ro_bits_cnt, ro_bits,
                       qdev_prop_uint32, uint32_t),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void efuse_class_init(ObjectClass *klass, void *data)
diff --git a/hw/nvram/xlnx-versal-efuse-cache.c b/hw/nvram/xlnx-versal-efuse-cache.c
index 1aea27afd3..2fb599422c 100644
--- a/hw/nvram/xlnx-versal-efuse-cache.c
+++ b/hw/nvram/xlnx-versal-efuse-cache.c
@@ -87,8 +87,6 @@ static const Property efuse_cache_props[] = {
     DEFINE_PROP_LINK("efuse",
                      XlnxVersalEFuseCache, efuse,
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
-
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void efuse_cache_class_init(ObjectClass *klass, void *data)
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 599aa126fb..3246eb3ca6 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -750,8 +750,6 @@ static const Property efuse_ctrl_props[] = {
     DEFINE_PROP_ARRAY("pg0-lock",
                       XlnxVersalEFuseCtrl, extra_pg0_lock_n16,
                       extra_pg0_lock_spec, qdev_prop_uint16, uint16_t),
-
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void efuse_ctrl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index af53187905..15024daf4f 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -837,8 +837,6 @@ static const Property zynqmp_efuse_props[] = {
     DEFINE_PROP_LINK("efuse",
                      XlnxZynqMPEFuse, efuse,
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
-
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void zynqmp_efuse_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index cfe50e60e9..e337f1ac50 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -217,7 +217,6 @@ static const Property cxl_dsp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 5824ba3c75..c0037f2cfb 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -211,7 +211,6 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index ef94aa3654..28b109c49a 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -369,7 +369,6 @@ static const Property cxl_upstream_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, void *data)
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index c319ca8263..3c0b41ef1a 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -145,7 +145,6 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_16),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 35a37e056a..0a91a8ae6c 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -186,7 +186,6 @@ static const Property pci_bridge_dev_properties[] = {
                      res_reserve.mem_pref_32, -1),
     DEFINE_PROP_SIZE("pref64-reserve", PCIBridgeDev,
                      res_reserve.mem_pref_64, -1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static bool pci_device_shpc_present(void *opaque, int version_id)
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 01997c1ab3..af4591a9c3 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -425,7 +425,6 @@ static const Property pxb_dev_properties[] = {
     DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
     DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
     DEFINE_PROP_BOOL("bypass_iommu", PXBDev, bypass_iommu, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pxb_dev_class_init(ObjectClass *klass, void *data)
@@ -509,7 +508,6 @@ static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
 
 static const Property pxb_cxl_dev_properties[] = {
     DEFINE_PROP_BOOL("hdm_for_passthrough", PXBCXLDev, hdm_for_passthrough, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pxb_cxl_dev_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 8834ff3dbf..fd4514a595 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -126,7 +126,6 @@ static void pcie_pci_bridge_write_config(PCIDevice *d,
 
 static const Property pcie_pci_bridge_dev_properties[] = {
         DEFINE_PROP_ON_OFF_AUTO("msi", PCIEPCIBridge, msi, ON_OFF_AUTO_AUTO),
-        DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription pcie_pci_bridge_dev_vmstate = {
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index a7f87a1bc4..dd40b366bf 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -152,7 +152,6 @@ static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void rp_instance_post_init(Object *obj)
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 92e5fb72ec..d4e94f2657 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -137,7 +137,6 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
 static const Property xio3130_downstream_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const VMStateDescription vmstate_xio3130_downstream = {
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index ead9893f21..58fdbf7bc9 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -495,7 +495,6 @@ static void dino_pcihost_init(Object *obj)
 static const Property dino_pcihost_properties[] = {
     DEFINE_PROP_LINK("memory-as", DinoState, memory_as, TYPE_MEMORY_REGION,
                      MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void dino_pcihost_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 8a955ca130..c6aa8e87a2 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -166,7 +166,6 @@ static const Property gpex_host_properties[] = {
                        gpex_cfg.mmio64.base, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MMIO_SIZE, GPEXHost,
                      gpex_cfg.mmio64.size, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void gpex_host_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index d64de73774..84e5ee8c6e 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -131,7 +131,6 @@ static char *grackle_ofw_unit_address(const SysBusDevice *dev)
 
 static const Property grackle_properties[] = {
     DEFINE_PROP_UINT32("ofw-addr", GrackleState, ofw_addr, -1),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void grackle_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 3c73ebe83f..d5c13a89b6 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1277,7 +1277,6 @@ static const TypeInfo gt64120_pci_info = {
 static const Property gt64120_properties[] = {
     DEFINE_PROP_BOOL("cpu-little-endian", GT64120State,
                      cpu_little_endian, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void gt64120_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 40780fbc52..1e69691c6d 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -362,7 +362,6 @@ static const Property i440fx_props[] = {
                      above_4g_mem_size, 0),
     DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
     DEFINE_PROP_STRING(I440FX_HOST_PROP_PCI_TYPE, I440FXState, pci_type),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 2518d5abe6..9c41c155fb 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -100,7 +100,6 @@ static void mv64361_pcihost_realize(DeviceState *dev, Error **errp)
 
 static const Property mv64361_pcihost_props[] = {
     DEFINE_PROP_UINT8("index", MV64361PCIState, index, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void mv64361_pcihost_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 888f0786a0..97cfb52119 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -192,8 +192,6 @@ static const Property pnv_phb_properties[] = {
 
     DEFINE_PROP_LINK("pec", PnvPHB, pec, TYPE_PNV_PHB4_PEC,
                      PnvPhb4PecState *),
-
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_phb_class_init(ObjectClass *klass, void *data)
@@ -304,8 +302,6 @@ static void pnv_phb_root_port_realize(DeviceState *dev, Error **errp)
 
 static const Property pnv_phb_root_port_properties[] = {
     DEFINE_PROP_UINT32("version", PnvPHBRootPort, version, 0),
-
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_phb_root_port_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 529b33b5a2..cd178f7eaf 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1095,7 +1095,6 @@ static const Property pnv_phb3_properties[] = {
     DEFINE_PROP_UINT32("chip-id", PnvPHB3, chip_id, 0),
     DEFINE_PROP_LINK("chip", PnvPHB3, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_LINK("phb-base", PnvPHB3, phb_base, TYPE_PNV_PHB, PnvPHB *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_phb3_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 482fe25803..178c73f519 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1694,7 +1694,6 @@ static const Property pnv_phb4_properties[] = {
     DEFINE_PROP_LINK("pec", PnvPHB4, pec, TYPE_PNV_PHB4_PEC,
                      PnvPhb4PecState *),
     DEFINE_PROP_LINK("phb-base", PnvPHB4, phb_base, TYPE_PNV_PHB, PnvPHB *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_phb4_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index f8975403d3..e4d33fa060 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -288,7 +288,6 @@ static const Property pnv_pec_properties[] = {
     DEFINE_PROP_UINT32("chip-id", PnvPhb4PecState, chip_id, 0),
     DEFINE_PROP_LINK("chip", PnvPhb4PecState, chip, TYPE_PNV_CHIP,
                      PnvChip *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static uint32_t pnv_pec_xscom_pci_base(PnvPhb4PecState *pec)
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 54071fc125..345ce4c526 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -510,7 +510,6 @@ static void e500_host_bridge_class_init(ObjectClass *klass, void *data)
 static const Property pcihost_properties[] = {
     DEFINE_PROP_UINT32("first_slot", PPCE500PCIState, first_slot, 0x11),
     DEFINE_PROP_UINT32("first_pin_irq", PPCE500PCIState, first_pin_irq, 0x1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void e500_pcihost_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index af0b77ea1e..06be3d77cb 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -182,7 +182,6 @@ static const Property q35_host_props[] = {
     DEFINE_PROP_BOOL(PCI_HOST_PROP_SMM_RANGES, Q35PCIHost,
                      mch.has_smm_ranges, true),
     DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void q35_host_class_init(ObjectClass *klass, void *data)
@@ -666,7 +665,6 @@ static const Property mch_props[] = {
     DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
                        16),
     DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mch_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index b0a4a669f5..918a3237a9 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -429,7 +429,6 @@ static const Property raven_pcihost_properties[] = {
     /* Temporary workaround until legacy prep machine is removed */
     DEFINE_PROP_BOOL("is-legacy-prep", PREPPCIState, is_legacy_prep,
                      false),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void raven_pcihost_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 623afed644..56f057a63f 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -495,7 +495,6 @@ static char *sabre_ofw_unit_address(const SysBusDevice *dev)
 static const Property sabre_properties[] = {
     DEFINE_PROP_UINT64("special-base", SabreState, special_base, 0),
     DEFINE_PROP_UINT64("mem-base", SabreState, mem_base, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sabre_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index bd670cfa9d..37e2461bbb 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -425,7 +425,6 @@ static const TypeInfo unin_internal_pci_host_info = {
 
 static const Property pci_unin_main_pci_host_props[] = {
     DEFINE_PROP_UINT32("ofw-addr", UNINHostState, ofw_addr, -1),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void pci_unin_main_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 5d59640691..c3fbf4cbf9 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -501,7 +501,6 @@ static const TypeInfo versatile_pci_host_info = {
 static const Property pci_vpb_properties[] = {
     DEFINE_PROP_UINT8("broken-irq-mapping", PCIVPBState, irq_mapping_prop,
                       PCI_VPB_IRQMAP_ASSUME_OK),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void pci_vpb_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 848403970b..18688485f4 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -163,7 +163,6 @@ static const Property xilinx_pcie_host_props[] = {
     DEFINE_PROP_SIZE("mmio_base", XilinxPCIEHost, mmio_base, 0),
     DEFINE_PROP_SIZE("mmio_size", XilinxPCIEHost, mmio_size, 1 * MiB),
     DEFINE_PROP_BOOL("link_up", XilinxPCIEHost, link_up, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xilinx_pcie_host_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 90248481b1..714208aa98 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -104,7 +104,6 @@ static const Property pci_props[] = {
     DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
                     QEMU_PCIE_EXT_TAG_BITNR, true),
     { .name = "busnr", .info = &prop_pci_busnr },
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const VMStateDescription vmstate_pcibus = {
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index dd4fd3674f..aee4dd7d1f 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -480,7 +480,6 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
 static const Property pci_bridge_properties[] = {
     DEFINE_PROP_BOOL("x-pci-express-writeable-slt-bug", PCIBridge,
                      pcie_writeable_slt_bug, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pci_bridge_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 321e7be709..4510890dfc 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -244,7 +244,6 @@ static const Property pci_host_properties_common[] = {
     DEFINE_PROP_BOOL("x-config-reg-migration-enabled", PCIHostState,
                      mig_enabled, true),
     DEFINE_PROP_BOOL(PCI_HOST_BYPASS_IOMMU, PCIHostState, bypass_iommu, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pci_host_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index bac2822e98..c73db30e98 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -116,7 +116,6 @@ static const Property pcie_port_props[] = {
     DEFINE_PROP_UINT16("aer_log_max", PCIEPort,
                        parent_obj.parent_obj.exp.aer_log.log_max,
                        PCIE_AER_LOG_MAX_DEFAULT),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void pcie_port_class_init(ObjectClass *oc, void *data)
@@ -210,7 +209,6 @@ static const Property pcie_slot_props[] = {
     DEFINE_PROP_BOOL("hotplug", PCIESlot, hotplug, true),
     DEFINE_PROP_BOOL("x-do-not-expose-native-hotplug-cap", PCIESlot,
                      hide_native_hotplug_cap, false),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void pcie_slot_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b90a052ce0..770516d7e5 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2431,7 +2431,6 @@ static const Property pnv_chip_properties[] = {
     DEFINE_PROP_UINT32("nr-threads", PnvChip, nr_threads, 1),
     DEFINE_PROP_BOOL("big-core", PnvChip, big_core, false),
     DEFINE_PROP_BOOL("lpar-per-core", PnvChip, lpar_per_core, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_chip_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index 646736f7e9..d09a167466 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -187,7 +187,6 @@ static void pnv_adu_realize(DeviceState *dev, Error **errp)
 
 static const Property pnv_adu_properties[] = {
     DEFINE_PROP_LINK("lpc", PnvADU, lpc, TYPE_PNV_LPC, PnvLpcController *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_adu_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index 840ef23128..011822ea1d 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -454,7 +454,6 @@ static const Property pnv_chiptod_properties[] = {
     DEFINE_PROP_BOOL("primary", PnvChipTOD, primary, false),
     DEFINE_PROP_BOOL("secondary", PnvChipTOD, secondary, false),
     DEFINE_PROP_LINK("chip", PnvChipTOD , chip, TYPE_PNV_CHIP, PnvChip *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_chiptod_power9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 22864c92f3..a5ebd392e1 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -443,7 +443,6 @@ static const Property pnv_core_properties[] = {
                      false),
     DEFINE_PROP_BOOL("lpar-per-core", PnvCore, lpar_per_core, false),
     DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_core_power8_class_init(ObjectClass *oc, void *data)
@@ -695,7 +694,6 @@ static void pnv_quad_power10_realize(DeviceState *dev, Error **errp)
 
 static const Property pnv_quad_properties[] = {
     DEFINE_PROP_UINT32("quad-id", PnvQuad, quad_id, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index b1f83e2cf2..11c8da8bed 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -414,7 +414,6 @@ static void pnv_homer_realize(DeviceState *dev, Error **errp)
 
 static const Property pnv_homer_properties[] = {
     DEFINE_PROP_LINK("chip", PnvHomer, chip, TYPE_PNV_CHIP, PnvChip *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_homer_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 4bd61abeed..13f16906dc 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -547,7 +547,6 @@ static const Property pnv_i2c_properties[] = {
     DEFINE_PROP_LINK("chip", PnvI2C, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_UINT32("engine", PnvI2C, engine, 1),
     DEFINE_PROP_UINT32("num-busses", PnvI2C, num_busses, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_i2c_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 4d47167163..0480a60f3f 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -830,7 +830,6 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
 
 static const Property pnv_lpc_properties[] = {
     DEFINE_PROP_BOOL("psi-serirq", PnvLpcController, psi_has_serirq, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_lpc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index eed6d32650..5bb755df76 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -115,7 +115,6 @@ static void pnv_pnor_realize(DeviceState *dev, Error **errp)
 static const Property pnv_pnor_properties[] = {
     DEFINE_PROP_INT64("size", PnvPnor, size, 128 * MiB),
     DEFINE_PROP_DRIVE("drive", PnvPnor, blk),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_pnor_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index e7d6ceee99..cd5021c4f5 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -555,7 +555,6 @@ static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom_offset)
 static const Property pnv_psi_properties[] = {
     DEFINE_PROP_UINT64("bar", PnvPsi, bar, 0),
     DEFINE_PROP_UINT64("fsp-bar", PnvPsi, fsp_bar, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_psi_power8_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 801f97811f..f8c9cec9ce 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -967,7 +967,6 @@ static void ppc405_cpc_realize(DeviceState *dev, Error **errp)
 
 static const Property ppc405_cpc_properties[] = {
     DEFINE_PROP_UINT32("sys-clk", Ppc405CpcState, sysclk, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ppc405_cpc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 05a5ef6f77..0d6f8d8a04 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1025,7 +1025,6 @@ static const Property ppc460ex_pcie_props[] = {
     DEFINE_PROP_INT32("dcrn-base", PPC460EXPCIEState, dcrn_base, -1),
     DEFINE_PROP_LINK("cpu", PPC460EXPCIEState, cpu, TYPE_POWERPC_CPU,
                      PowerPCCPU *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ppc460ex_pcie_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 530a392f2a..9ce9777510 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -234,7 +234,6 @@ static void ppc4xx_mal_finalize(Object *obj)
 static const Property ppc4xx_mal_properties[] = {
     DEFINE_PROP_UINT8("txc-num", Ppc4xxMalState, txcnum, 0),
     DEFINE_PROP_UINT8("rxc-num", Ppc4xxMalState, rxcnum, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ppc4xx_mal_class_init(ObjectClass *oc, void *data)
@@ -542,7 +541,6 @@ bool ppc4xx_dcr_realize(Ppc4xxDcrDeviceState *dev, PowerPCCPU *cpu,
 static const Property ppc4xx_dcr_properties[] = {
     DEFINE_PROP_LINK("cpu", Ppc4xxDcrDeviceState, cpu, TYPE_POWERPC_CPU,
                      PowerPCCPU *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ppc4xx_dcr_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/ppc4xx_sdram.c b/hw/ppc/ppc4xx_sdram.c
index 6cfb07a11f..562bff8d53 100644
--- a/hw/ppc/ppc4xx_sdram.c
+++ b/hw/ppc/ppc4xx_sdram.c
@@ -429,7 +429,6 @@ static const Property ppc4xx_sdram_ddr_props[] = {
     DEFINE_PROP_LINK("dram", Ppc4xxSdramDdrState, dram_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("nbanks", Ppc4xxSdramDdrState, nbanks, 4),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ppc4xx_sdram_ddr_class_init(ObjectClass *oc, void *data)
@@ -714,7 +713,6 @@ static const Property ppc4xx_sdram_ddr2_props[] = {
     DEFINE_PROP_LINK("dram", Ppc4xxSdramDdr2State, dram_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("nbanks", Ppc4xxSdramDdr2State, nbanks, 4),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ppc4xx_sdram_ddr2_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index ca475c69f4..6e2ae98625 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -288,7 +288,6 @@ static const VMStateDescription vmstate_prep_systemio = {
 static const Property prep_systemio_properties[] = {
     DEFINE_PROP_UINT8("ibm-planar-id", PrepSystemIoState, ibm_planar_id, 0),
     DEFINE_PROP_UINT8("equipment", PrepSystemIoState, equipment, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void prep_systemio_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index bee9bc62d4..0e5d53b8b6 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -210,7 +210,6 @@ static const VMStateDescription vmstate_rs6000mc = {
 static const Property rs6000mc_properties[] = {
     DEFINE_PROP_UINT32("ram-size", RS6000MCState, ram_size, 0),
     DEFINE_PROP_BOOL("auto-configure", RS6000MCState, autoconfigure, true),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void rs6000mc_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 88d743a3c3..559dd918e1 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -363,7 +363,6 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
 static const Property spapr_cpu_core_properties[] = {
     DEFINE_PROP_INT32("node-id", SpaprCpuCore, node_id, CPU_UNSET_NUMA_NODE_ID),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 8bcce4146a..6f875d73b2 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -887,7 +887,6 @@ static void spapr_nvdimm_unrealize(NVDIMMDevice *dimm)
 #ifdef CONFIG_LIBPMEM
 static const Property spapr_nvdimm_properties[] = {
     DEFINE_PROP_BOOL("pmem-override", SpaprNVDIMMDevice, pmem_override, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 #endif
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 3edff528ca..0dcbd5900c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2055,7 +2055,6 @@ static const Property spapr_phb_properties[] = {
                      pcie_ecs, true),
     DEFINE_PROP_BOOL("pre-5.1-associativity", SpaprPhbState,
                      pre_5_1_assoc, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_spapr_pci_lsi = {
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index 51c3a54d45..6935f00832 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -134,7 +134,6 @@ static const Property spapr_rng_properties[] = {
     DEFINE_PROP_BOOL("use-kvm", SpaprRngState, use_kvm, false),
     DEFINE_PROP_LINK("rng", SpaprRngState, backend, TYPE_RNG_BACKEND,
                      RngBackend *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void spapr_rng_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index 37521b88cb..2a17a5108b 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -147,7 +147,6 @@ static void spapr_tpm_proxy_unrealize(DeviceState *d)
 
 static const Property spapr_tpm_proxy_properties[] = {
     DEFINE_PROP_STRING("host-path", SpaprTpmProxy, host_path),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void spapr_tpm_proxy_class_init(ObjectClass *k, void *data)
diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index 6f84fdd3fa..ee9a22bba3 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -193,7 +193,6 @@ static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
 
 static const Property proxy_properties[] = {
     DEFINE_PROP_STRING("fd", PCIProxyDev, fd),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 8ce85ea9f7..bc26b5313a 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -308,7 +308,6 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
 
 static const Property lowrisc_ibex_soc_props[] = {
     DEFINE_PROP_UINT32("resetvec", LowRISCIbexSoCState, resetvec, 0x20000400),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void lowrisc_ibex_soc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index a695314bbe..257a5faa5f 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -163,7 +163,6 @@ static const Property riscv_iommu_pci_properties[] = {
     DEFINE_PROP_UINT16("device-id", RISCVIOMMUStatePci, device_id,
                        PCI_DEVICE_ID_REDHAT_RISCV_IOMMU),
     DEFINE_PROP_UINT8("revision", RISCVIOMMUStatePci, revision, 0x01),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void riscv_iommu_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 07fed36986..41f3e6cf7c 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2248,7 +2248,6 @@ static const Property riscv_iommu_properties[] = {
     DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
     DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
         TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void riscv_iommu_class_init(ObjectClass *klass, void* data)
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 0df454772f..74b91ac60c 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -33,7 +33,6 @@ static const Property riscv_harts_props[] = {
     DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
     DEFINE_PROP_UINT64("resetvec", RISCVHartArrayState, resetvec,
                        DEFAULT_RSTVEC),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void riscv_harts_cpu_reset(void *opaque)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 124ffd4842..f5c01dbbd0 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -939,7 +939,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
 static const Property sifive_u_soc_props[] = {
     DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
     DEFINE_PROP_STRING("cpu-type", SiFiveUSoCState, cpu_type),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void sifive_u_soc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c
index 838db72136..b56098b0a9 100644
--- a/hw/rtc/allwinner-rtc.c
+++ b/hw/rtc/allwinner-rtc.c
@@ -313,7 +313,6 @@ static const VMStateDescription allwinner_rtc_vmstate = {
 
 static const Property allwinner_rtc_properties[] = {
     DEFINE_PROP_INT32("base-year", AwRtcState, base_year, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void allwinner_rtc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 389f192efa..cd11bf8208 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -289,7 +289,6 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
 static const Property goldfish_rtc_properties[] = {
     DEFINE_PROP_BOOL("big-endian", GoldfishRTCState, big_endian,
                       false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 51f80d27ef..38bc8dcf10 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -81,7 +81,6 @@ static const Property m48t59_isa_properties[] = {
     DEFINE_PROP_INT32("base-year", M48txxISAState, state.base_year, 0),
     DEFINE_PROP_UINT32("iobase", M48txxISAState, io_base, 0x74),
     DEFINE_PROP_UINT8("irq", M48txxISAState, isairq, 8),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void m48t59_reset_isa(DeviceState *d)
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 5a2c7b4abd..57c17e5133 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -620,7 +620,6 @@ static void m48txx_sysbus_toggle_lock(Nvram *obj, int lock)
 
 static const Property m48t59_sysbus_properties[] = {
     DEFINE_PROP_INT32("base-year", M48txxSysBusState, state.base_year, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 973ed9914d..37f247fce8 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -966,7 +966,6 @@ static const Property mc146818rtc_properties[] = {
     DEFINE_PROP_UINT8("irq", MC146818RtcState, isairq, RTC_ISA_IRQ),
     DEFINE_PROP_LOSTTICKPOLICY("lost_tick_policy", MC146818RtcState,
                                lost_tick_policy, LOST_TICK_POLICY_DISCARD),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void rtc_reset_enter(Object *obj, ResetType type)
diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index 1dc8e6e00f..32ce5bbb99 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -330,7 +330,6 @@ static const Property pl031_properties[] = {
      */
     DEFINE_PROP_BOOL("migrate-tick-offset",
                      PL031State, migrate_tick_offset, true),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void pl031_class_init(ObjectClass *klass, void *data)
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index dfa27bc94e..da1a1cc00e 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -262,7 +262,6 @@ static const Property rx62n_properties[] = {
                      MemoryRegion *),
     DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
     DEFINE_PROP_UINT32("xtal-frequency-hz", RX62NState, xtal_freq_hz, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void rx62n_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 0d10c3ed55..494faebb5a 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -85,7 +85,6 @@ static const Property ccw_device_properties[] = {
     DEFINE_PROP_CSS_DEV_ID("devno", CcwDevice, devno),
     DEFINE_PROP_CSS_DEV_ID_RO("dev_id", CcwDevice, dev_id),
     DEFINE_PROP_CSS_DEV_ID_RO("subch_id", CcwDevice, subch_id),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ccw_device_reset_hold(Object *obj, ResetType type)
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 860a04a7da..04ab1f6402 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -123,7 +123,6 @@ VirtualCssBus *virtual_css_bus_init(void)
 static const Property virtual_css_bridge_properties[] = {
     DEFINE_PROP_BOOL("css_dev_path", VirtualCssBridge, css_dev_path,
                      true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static bool prop_get_true(Object *obj, Error **errp)
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 88a97f0085..0344c02ece 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -299,7 +299,6 @@ static const Property s390_ipl_properties[] = {
     DEFINE_PROP_BOOL("enforce_bios", S390IPLState, enforce_bios, false),
     DEFINE_PROP_BOOL("iplbext_migration", S390IPLState, iplbext_migration,
                      true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void s390_ipl_set_boot_menu(S390IPLState *ipl)
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 22e6be67af..5fbbf41a3d 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1488,7 +1488,6 @@ static const Property s390_pci_device_properties[] = {
     DEFINE_PROP_BOOL("interpret", S390PCIBusDevice, interp, true),
     DEFINE_PROP_BOOL("forwarding-assist", S390PCIBusDevice, forwarding_assist,
                      true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription s390_pci_device_vmstate = {
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 6d0a47ed73..4409e62b6a 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -477,7 +477,6 @@ static void s390_skeys_realize(DeviceState *dev, Error **errp)
 
 static const Property s390_skeys_props[] = {
     DEFINE_PROP_BOOL("migration-enabled", S390SKeysState, migration_enabled, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void s390_skeys_class_init(ObjectClass *oc, void *data)
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 6c69c01e1f..8e07acbddc 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -362,7 +362,6 @@ static void s390_stattrib_realize(DeviceState *dev, Error **errp)
 
 static const Property s390_stattrib_props[] = {
     DEFINE_PROP_BOOL("migration-enabled", S390StAttribState, migration_enabled, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void s390_stattrib_class_init(ObjectClass *oc, void *data)
diff --git a/hw/s390x/vhost-scsi-ccw.c b/hw/s390x/vhost-scsi-ccw.c
index 0be0f8a82c..e6bf0c55bc 100644
--- a/hw/s390x/vhost-scsi-ccw.c
+++ b/hw/s390x/vhost-scsi-ccw.c
@@ -44,7 +44,6 @@ static void vhost_ccw_scsi_instance_init(Object *obj)
 static const Property vhost_ccw_scsi_properties[] = {
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_ccw_scsi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/vhost-user-fs-ccw.c b/hw/s390x/vhost-user-fs-ccw.c
index 934378aaec..6a9654d77b 100644
--- a/hw/s390x/vhost-user-fs-ccw.c
+++ b/hw/s390x/vhost-user-fs-ccw.c
@@ -28,7 +28,6 @@ static const Property vhost_user_fs_ccw_properties[] = {
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_user_fs_ccw_realize(VirtioCcwDevice *ccw_dev, Error **errp)
diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
index 3ba4008b4b..875ccf3485 100644
--- a/hw/s390x/vhost-vsock-ccw.c
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -25,7 +25,6 @@ struct VHostVSockCCWState {
 static const Property vhost_vsock_ccw_properties[] = {
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_vsock_ccw_realize(VirtioCcwDevice *ccw_dev, Error **errp)
diff --git a/hw/s390x/virtio-ccw-9p.c b/hw/s390x/virtio-ccw-9p.c
index c10b084d40..287ae2ba76 100644
--- a/hw/s390x/virtio-ccw-9p.c
+++ b/hw/s390x/virtio-ccw-9p.c
@@ -46,7 +46,6 @@ static const Property virtio_ccw_9p_properties[] = {
             VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_ccw_9p_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/virtio-ccw-balloon.c b/hw/s390x/virtio-ccw-balloon.c
index bbbed494b3..1180efaf6d 100644
--- a/hw/s390x/virtio-ccw-balloon.c
+++ b/hw/s390x/virtio-ccw-balloon.c
@@ -51,7 +51,6 @@ static const Property virtio_ccw_balloon_properties[] = {
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
index 3182851234..db9d442ffb 100644
--- a/hw/s390x/virtio-ccw-blk.c
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -49,7 +49,6 @@ static const Property virtio_ccw_blk_properties[] = {
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
     DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index b4cd7605c9..b693f87c70 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -49,7 +49,6 @@ static const Property virtio_ccw_crypto_properties[] = {
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/virtio-ccw-gpu.c b/hw/s390x/virtio-ccw-gpu.c
index c44dc2d355..a6b14c25d9 100644
--- a/hw/s390x/virtio-ccw-gpu.c
+++ b/hw/s390x/virtio-ccw-gpu.c
@@ -47,7 +47,6 @@ static const Property virtio_ccw_gpu_properties[] = {
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_ccw_gpu_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/virtio-ccw-input.c b/hw/s390x/virtio-ccw-input.c
index 040a9e04a9..6ca10d58ee 100644
--- a/hw/s390x/virtio-ccw-input.c
+++ b/hw/s390x/virtio-ccw-input.c
@@ -48,7 +48,6 @@ static const Property virtio_ccw_input_properties[] = {
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_ccw_input_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
index c41d347034..80a5581baf 100644
--- a/hw/s390x/virtio-ccw-net.c
+++ b/hw/s390x/virtio-ccw-net.c
@@ -52,7 +52,6 @@ static const Property virtio_ccw_net_properties[] = {
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
     DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_ccw_net_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index c9a15c4eb6..ccd124ee91 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -48,7 +48,6 @@ static const Property virtio_ccw_rng_properties[] = {
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_ccw_rng_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/virtio-ccw-scsi.c b/hw/s390x/virtio-ccw-scsi.c
index bec9a73518..bfcea3cfe7 100644
--- a/hw/s390x/virtio-ccw-scsi.c
+++ b/hw/s390x/virtio-ccw-scsi.c
@@ -58,7 +58,6 @@ static const Property virtio_ccw_scsi_properties[] = {
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/virtio-ccw-serial.c b/hw/s390x/virtio-ccw-serial.c
index 037d4f9db1..59743d1e25 100644
--- a/hw/s390x/virtio-ccw-serial.c
+++ b/hw/s390x/virtio-ccw-serial.c
@@ -58,7 +58,6 @@ static const Property virtio_ccw_serial_properties[] = {
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index a06113d908..de628ae89b 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1414,7 +1414,6 @@ static const Property mptsas_properties[] = {
     DEFINE_PROP_UINT64("sas_address", MPTSASState, sas_addr, 0),
     /* TODO: test MSI support under Windows */
     DEFINE_PROP_ON_OFF_AUTO("msi", MPTSASState, msi, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mptsas1068_class_init(ObjectClass *oc, void *data)
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 2f1678d51e..181720b7a8 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1947,7 +1947,6 @@ static const Property scsi_props[] = {
     DEFINE_PROP_UINT32("channel", SCSIDevice, channel, 0),
     DEFINE_PROP_UINT32("scsi-id", SCSIDevice, id, -1),
     DEFINE_PROP_UINT32("lun", SCSIDevice, lun, -1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void scsi_device_class_init(ObjectClass *klass, void *data)
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a47b80907f..16351b4988 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3227,7 +3227,6 @@ static const Property scsi_hd_properties[] = {
                     quirks, SCSI_DISK_QUIRK_MODE_PAGE_VENDOR_SPECIFIC_APPLE,
                     0),
     DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_scsi_disk_state = {
@@ -3285,7 +3284,6 @@ static const Property scsi_cd_properties[] = {
                     0),
     DEFINE_PROP_BIT("quirk_mode_page_truncated", SCSIDiskState, quirks,
                     SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void scsi_cd_class_initfn(ObjectClass *klass, void *data)
@@ -3323,7 +3321,6 @@ static const Property scsi_block_properties[] = {
                       -1),
     DEFINE_PROP_UINT32("io_timeout", SCSIDiskState, qdev.io_timeout,
                        DEFAULT_IO_TIMEOUT),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void scsi_block_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index d7ae7549d0..0290a196cc 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -777,7 +777,6 @@ static const Property scsi_generic_properties[] = {
     DEFINE_PROP_BOOL("share-rw", SCSIDevice, conf.share_rw, false),
     DEFINE_PROP_UINT32("io_timeout", SCSIDevice, io_timeout,
                        DEFAULT_IO_TIMEOUT),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static int scsi_generic_parse_cdb(SCSIDevice *dev, SCSICommand *cmd,
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 7c55e4d40f..6962194eaa 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1252,7 +1252,6 @@ static int spapr_vscsi_devnode(SpaprVioDevice *dev, void *fdt, int node_off)
 
 static const Property spapr_vscsi_properties[] = {
     DEFINE_SPAPR_PROPERTIES(VSCSIState, vdev),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_spapr_vscsi = {
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index effb8dab1f..9f760663a0 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -362,7 +362,6 @@ static const Property vhost_scsi_properties[] = {
     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
     DEFINE_PROP_BOOL("worker_per_virtqueue", VirtIOSCSICommon,
                      conf.worker_per_virtqueue, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_scsi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index d5265c57bc..689bc6c13e 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -360,7 +360,6 @@ static const Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_BIT64("t10_pi", VHostSCSICommon, host_features,
                                                  VIRTIO_SCSI_F_T10_PI,
                                                  false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_user_scsi_reset(VirtIODevice *vdev)
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index c0a4f1a620..eb70a7a46e 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1302,7 +1302,6 @@ static const Property virtio_scsi_properties[] = {
                                                 VIRTIO_SCSI_F_CHANGE, true),
     DEFINE_PROP_LINK("iothread", VirtIOSCSI, parent_obj.conf.iothread,
                      TYPE_IOTHREAD, IOThread *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_virtio_scsi = {
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 46cec531cc..f07e377cb8 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1302,7 +1302,6 @@ static const Property pvscsi_properties[] = {
                     PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
                     PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pvscsi_realize(DeviceState *qdev, Error **errp)
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index be39ec2e71..0b235bccfd 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -811,7 +811,6 @@ static const VMStateDescription vmstate_allwinner_sdhost = {
 static const Property allwinner_sdhost_properties[] = {
     DEFINE_PROP_LINK("dma-memory", AwSdHostState, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void allwinner_sdhost_init(Object *obj)
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 99703f1842..12cbbae5e7 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -206,7 +206,6 @@ static const VMStateDescription vmstate_aspeed_sdhci = {
 
 static const Property aspeed_sdhci_properties[] = {
     DEFINE_PROP_UINT8("num-slots", AspeedSDHCIState, num_slots, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b994ef581e..779bac6631 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2800,19 +2800,16 @@ static void emmc_realize(DeviceState *dev, Error **errp)
 
 static const Property sdmmc_common_properties[] = {
     DEFINE_PROP_DRIVE("drive", SDState, blk),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
                       spec_version, SD_PHY_SPECv3_01_VERS),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const Property emmc_properties[] = {
     DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
     DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void sdmmc_common_class_init(ObjectClass *klass, void *data)
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 83892a7a15..5268c0dee5 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -24,7 +24,6 @@
 
 static const Property sdhci_pci_properties[] = {
     DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e697ee05b3..64a936fcf0 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1550,7 +1550,6 @@ static const Property sdhci_sysbus_properties[] = {
                      false),
     DEFINE_PROP_LINK("dma", SDHCIState,
                      dma_mr, TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sdhci_sysbus_init(Object *obj)
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 3d6fcdf576..8c1fc82534 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -370,7 +370,6 @@ static void iommu_init(Object *obj)
 
 static const Property iommu_properties[] = {
     DEFINE_PROP_UINT32("version", IOMMUState, version, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void iommu_class_init(ObjectClass *klass, void *data)
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 05b8c7369e..b6f65e8d2f 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -377,7 +377,6 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
 static const Property ebus_properties[] = {
     DEFINE_PROP_UINT64("console-serial-base", EbusState,
                        console_serial_base, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ebus_class_init(ObjectClass *klass, void *data)
@@ -529,7 +528,6 @@ static void ram_init(hwaddr addr, ram_addr_t RAM_size)
 
 static const Property ram_properties[] = {
     DEFINE_PROP_UINT64("size", RamDevice, size, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ram_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index bbdd4e4786..faef1a8e5b 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1292,7 +1292,6 @@ static const Property aspeed_smc_properties[] = {
     DEFINE_PROP_UINT64("dram-base", AspeedSMCState, dram_base, 0),
     DEFINE_PROP_LINK("dram", AspeedSMCState, dram_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_smc_class_init(ObjectClass *klass, void *data)
@@ -1340,7 +1339,6 @@ static const Property aspeed_smc_flash_properties[] = {
     DEFINE_PROP_UINT8("cs", AspeedSMCFlash, cs, 0),
     DEFINE_PROP_LINK("controller", AspeedSMCFlash, controller, TYPE_ASPEED_SMC,
                      AspeedSMCState *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_smc_flash_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index 60a0b17b62..46c7b633c2 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -563,7 +563,6 @@ static const MemoryRegionOps ibex_spi_ops = {
 
 static const Property ibex_spi_properties[] = {
     DEFINE_PROP_UINT32("num_cs", IbexSPIHostState, num_cs, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_ibex = {
diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index fdd3ad2fdc..21fc489038 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -543,7 +543,6 @@ static const VMStateDescription vmstate_npcm7xx_fiu = {
 
 static const Property npcm7xx_fiu_properties[] = {
     DEFINE_PROP_INT32("cs-count", NPCM7xxFIUState, cs_count, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void npcm7xx_fiu_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 4ca9c469a4..15e25bd1be 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1198,7 +1198,6 @@ static const MemoryRegionOps pnv_spi_xscom_ops = {
 static const Property pnv_spi_properties[] = {
     DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
     DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pnv_spi_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ssi/sifive_spi.c b/hw/ssi/sifive_spi.c
index 7458747779..76f8654f41 100644
--- a/hw/ssi/sifive_spi.c
+++ b/hw/ssi/sifive_spi.c
@@ -330,7 +330,6 @@ static void sifive_spi_realize(DeviceState *dev, Error **errp)
 
 static const Property sifive_spi_properties[] = {
     DEFINE_PROP_UINT32("num-cs", SiFiveSPIState, num_cs, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sifive_spi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index cab0014c3f..872c4e8036 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -110,7 +110,6 @@ static void ssi_peripheral_realize(DeviceState *dev, Error **errp)
 
 static const Property ssi_peripheral_properties[] = {
     DEFINE_PROP_UINT8("cs", SSIPeripheral, cs_index, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ssi_peripheral_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 588c1ec071..fd1ff12eb1 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -363,7 +363,6 @@ static const VMStateDescription vmstate_xilinx_spi = {
 
 static const Property xilinx_spi_properties[] = {
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPI, num_cs, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xilinx_spi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index f72cb3cbc8..984c178087 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1422,14 +1422,12 @@ static const VMStateDescription vmstate_xlnx_zynqmp_qspips = {
 
 static const Property xilinx_zynqmp_qspips_properties[] = {
     DEFINE_PROP_UINT32("dma-burst-size", XlnxZynqMPQSPIPS, dma_burst_size, 64),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const Property xilinx_spips_properties[] = {
     DEFINE_PROP_UINT8("num-busses", XilinxSPIPS, num_busses, 1),
     DEFINE_PROP_UINT8("num-ss-bits", XilinxSPIPS, num_cs, 4),
     DEFINE_PROP_UINT8("num-txrx-bytes", XilinxSPIPS, num_txrx_bytes, 1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xilinx_qspips_class_init(ObjectClass *klass, void * data)
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index e51abe9de2..9e96c9b69a 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -1829,7 +1829,6 @@ static const Property xlnx_versal_ospi_properties[] = {
     DEFINE_PROP_BOOL("dac-with-indac", XlnxVersalOspi, dac_with_indac, false),
     DEFINE_PROP_BOOL("indac-write-disabled", XlnxVersalOspi,
                      ind_write_disabled, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xlnx_versal_ospi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index c0a91bab0c..0c4eef2636 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -375,7 +375,6 @@ static const VMStateDescription vmstate_a9_gtimer = {
 
 static const Property a9_gtimer_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A9GTimerState, num_cpu, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void a9_gtimer_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 2904ccfb42..ddaf2128c2 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -193,7 +193,6 @@ static const Property a10_pit_properties[] = {
     DEFINE_PROP_UINT32("clk1-freq", AwA10PITState, clk_freq[1], 0),
     DEFINE_PROP_UINT32("clk2-freq", AwA10PITState, clk_freq[2], 0),
     DEFINE_PROP_UINT32("clk3-freq", AwA10PITState, clk_freq[3], 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_a10_pit = {
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 6244a7a84f..803dad1e8a 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -302,7 +302,6 @@ static const VMStateDescription vmstate_arm_mptimer = {
 
 static const Property arm_mptimer_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", ARMMPTimerState, num_cpu, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void arm_mptimer_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index dfa034296c..1213b77aa0 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -390,7 +390,6 @@ static const TypeInfo icp_pit_info = {
 static const Property sp804_properties[] = {
     DEFINE_PROP_UINT32("freq0", SP804State, freq0, 1000000),
     DEFINE_PROP_UINT32("freq1", SP804State, freq1, 1000000),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sp804_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 4c16b5016e..4868651ad4 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -677,7 +677,6 @@ static const VMStateDescription vmstate_aspeed_timer_state = {
 static const Property aspeed_timer_properties[] = {
     DEFINE_PROP_LINK("scu", AspeedTimerCtrlState, scu, TYPE_ASPEED_SCU,
                      AspeedSCUState *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void timer_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
index 2e3ce83c43..96baf9cf60 100644
--- a/hw/timer/avr_timer16.c
+++ b/hw/timer/avr_timer16.c
@@ -546,7 +546,6 @@ static const Property avr_timer16_properties[] = {
     DEFINE_PROP_UINT8("id", struct AVRTimer16State, id, 0),
     DEFINE_PROP_UINT64("cpu-frequency-hz", struct AVRTimer16State,
                        cpu_freq_hz, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void avr_timer16_pr(void *opaque, int irq, int level)
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index a7428ed938..f0802b6eb6 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -407,7 +407,6 @@ static const Property grlib_gptimer_properties[] = {
     DEFINE_PROP_UINT32("frequency", GPTimerUnit, freq_hz,   40000000),
     DEFINE_PROP_UINT32("irq-line",  GPTimerUnit, irq_line,  8),
     DEFINE_PROP_UINT32("nr-timers", GPTimerUnit, nr_timers, 2),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void grlib_gptimer_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 46886c379e..2a45410c0d 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -750,7 +750,6 @@ static const Property hpet_device_properties[] = {
     DEFINE_PROP_BIT("msi", HPETState, flags, HPET_MSI_SUPPORT, false),
     DEFINE_PROP_UINT32(HPET_INTCAP, HPETState, intcap, 0),
     DEFINE_PROP_BOOL("hpet-offset-saved", HPETState, hpet_offset_saved, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void hpet_device_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index 953c1e11eb..29105afcc3 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -240,7 +240,6 @@ static const VMStateDescription vmstate_pit_common = {
 
 static const Property pit_common_properties[] = {
     DEFINE_PROP_UINT32("iobase", PITCommonState, iobase,  -1),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pit_common_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index fba4466a89..3ebc870097 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -265,7 +265,6 @@ static const VMStateDescription vmstate_ibex_timer = {
 
 static const Property ibex_timer_properties[] = {
     DEFINE_PROP_UINT32("timebase-freq", IbexTimerState, timebase_freq, 10000),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ibex_timer_init(Object *obj)
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index e5c5cd6a84..594da64eae 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -283,7 +283,6 @@ static const Property mss_timer_properties[] = {
     /* Libero GUI shows 100Mhz as default for clocks */
     DEFINE_PROP_UINT32("clock-frequency", MSSTimerState, freq_hz,
                       100 * 1000000),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void mss_timer_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 48fccec1bf..11ad8b575e 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -381,7 +381,6 @@ static const VMStateDescription vmstate_nrf51_timer = {
 
 static const Property nrf51_timer_properties[] = {
     DEFINE_PROP_UINT8("id", NRF51TimerState, id, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void nrf51_timer_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 345145bfa8..6ec3fa54dd 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -553,7 +553,6 @@ static const Property pxa25x_timer_dev_properties[] = {
     DEFINE_PROP_UINT32("freq", PXA2xxTimerInfo, freq, PXA25X_FREQ),
     DEFINE_PROP_BIT("tm4", PXA2xxTimerInfo, flags,
                     PXA2XX_TIMER_HAVE_TM4, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pxa25x_timer_dev_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
index 6d451fa86b..93e7f58cc2 100644
--- a/hw/timer/renesas_cmt.c
+++ b/hw/timer/renesas_cmt.c
@@ -255,7 +255,6 @@ static const VMStateDescription vmstate_rcmt = {
 
 static const Property rcmt_properties[] = {
     DEFINE_PROP_UINT64("input-freq", RCMTState, input_freq, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void rcmt_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index 890f803cf8..884349c2cc 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -465,7 +465,6 @@ static const VMStateDescription vmstate_rtmr = {
 
 static const Property rtmr_properties[] = {
     DEFINE_PROP_UINT64("input-freq", RTMRState, input_freq, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void rtmr_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
index 042c89c67a..fc796e9bc3 100644
--- a/hw/timer/sifive_pwm.c
+++ b/hw/timer/sifive_pwm.c
@@ -408,7 +408,6 @@ static const Property sifive_pwm_properties[] = {
     /* 0.5Ghz per spec after FSBL */
     DEFINE_PROP_UINT64("clock-frequency", struct SiFivePwmState,
                        freq_hz, 500000000ULL),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sifive_pwm_init(Object *obj)
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 32991f4436..65b24e4f06 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -422,7 +422,6 @@ static void slavio_timer_init(Object *obj)
 
 static const Property slavio_timer_properties[] = {
     DEFINE_PROP_UINT32("num_cpus",  SLAVIO_TIMERState, num_cpus,  0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void slavio_timer_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index 6b7a67941c..e106739ea9 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -442,7 +442,6 @@ static const VMStateDescription sse_timer_vmstate = {
 
 static const Property sse_timer_properties[] = {
     DEFINE_PROP_LINK("counter", SSETimer, counter, TYPE_SSE_COUNTER, SSECounter *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sse_timer_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index d9d745cd76..4707190d6a 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -301,7 +301,6 @@ static const VMStateDescription vmstate_stm32f2xx_timer = {
 static const Property stm32f2xx_timer_properties[] = {
     DEFINE_PROP_UINT64("clock-frequency", struct STM32F2XXTimerState,
                        freq_hz, 1000000000),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void stm32f2xx_timer_init(Object *obj)
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 7fe3e83baa..4955fe1b01 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -245,7 +245,6 @@ static void xilinx_timer_init(Object *obj)
 static const Property xilinx_timer_properties[] = {
     DEFINE_PROP_UINT32("clock-frequency", XpsTimerState, freq_hz, 62 * 1000000),
     DEFINE_PROP_UINT8("one-timer-only", XpsTimerState, one_timer_only, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xilinx_timer_class_init(ObjectClass *klass, void *data)
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 2bf6e7ffe9..e652679a1f 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -229,7 +229,6 @@ static const VMStateDescription vmstate_tpm_crb = {
 static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
     DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void tpm_crb_reset(void *dev)
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index e15b67dd45..797fd8b290 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -367,7 +367,6 @@ static const VMStateDescription vmstate_spapr_vtpm = {
 static const Property tpm_spapr_properties[] = {
     DEFINE_SPAPR_PROPERTIES(SpaprTpmState, vdev),
     DEFINE_PROP_TPMBE("tpmdev", SpaprTpmState, be_driver),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void tpm_spapr_realizefn(SpaprVioDevice *dev, Error **errp)
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index b27af230cd..504328e3b0 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -493,7 +493,6 @@ static int tpm_tis_i2c_send(I2CSlave *i2c, uint8_t data)
 
 static const Property tpm_tis_i2c_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", TPMStateI2C, state.be_driver),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void tpm_tis_i2c_realizefn(DeviceState *dev, Error **errp)
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 9b2160972a..876cb02cb5 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -95,7 +95,6 @@ static const Property tpm_tis_isa_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
     DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void tpm_tis_isa_initfn(Object *obj)
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 88c1f1e478..ee0bfe9538 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -93,7 +93,6 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
 static const Property tpm_tis_sysbus_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void tpm_tis_sysbus_initfn(Object *obj)
diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 74ff52ad09..4100ea28e2 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -277,7 +277,6 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 static const Property ufs_lu_props[] = {
     DEFINE_PROP_DRIVE("drive", UfsLu, conf.blk),
     DEFINE_PROP_UINT8("lun", UfsLu, lun, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static bool ufs_add_lu(UfsHc *u, UfsLu *lu, Error **errp)
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index fe77158439..8d26d13791 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1758,7 +1758,6 @@ static const Property ufs_props[] = {
     DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
     DEFINE_PROP_BOOL("mcq", UfsHc, params.mcq, false),
     DEFINE_PROP_UINT8("mcq-maxq", UfsHc, params.mcq_maxq, 2),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription ufs_vmstate = {
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 80e6a92820..7e4ff36fed 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -24,7 +24,6 @@ static const Property usb_props[] = {
     DEFINE_PROP_BIT("msos-desc", USBDevice, flags,
                     USB_DEV_FLAG_MSOS_DESC_ENABLE, true),
     DEFINE_PROP_STRING("pcap", USBDevice, pcap_filename),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void usb_bus_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/canokey.c b/hw/usb/canokey.c
index 7cb600e3c8..fae212f053 100644
--- a/hw/usb/canokey.c
+++ b/hw/usb/canokey.c
@@ -298,7 +298,6 @@ static void canokey_unrealize(USBDevice *base)
 
 static const Property canokey_properties[] = {
     DEFINE_PROP_STRING("file", CanoKeyState, file),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void canokey_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index dd58333943..b1e330f21d 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -589,7 +589,6 @@ static const Property emulated_card_properties[] = {
     DEFINE_PROP_STRING("cert3", EmulatedState, cert3),
     DEFINE_PROP_STRING("db", EmulatedState, db),
     DEFINE_PROP_UINT8("debug", EmulatedState, debug, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void emulated_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index f97dcf767f..bf81485f87 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -391,7 +391,6 @@ static const VMStateDescription passthru_vmstate = {
 static const Property passthru_card_properties[] = {
     DEFINE_PROP_CHR("chardev", PassthruState, cs),
     DEFINE_PROP_UINT8("debug", PassthruState, debug, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void passthru_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 6007f16d30..40f031252a 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -995,7 +995,6 @@ static const Property usb_audio_properties[] = {
     DEFINE_PROP_UINT32("debug", USBAudioState, debug, 0),
     DEFINE_PROP_UINT32("buffer", USBAudioState, buffer_user, 0),
     DEFINE_PROP_BOOL("multi", USBAudioState, multi, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_audio_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index d83f67b984..accdd460e3 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -797,7 +797,6 @@ static const Property usb_tablet_properties[] = {
         DEFINE_PROP_UINT32("usb_version", USBHIDState, usb_version, 2),
         DEFINE_PROP_STRING("display", USBHIDState, display),
         DEFINE_PROP_UINT32("head", USBHIDState, head, 0),
-        DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_tablet_class_initfn(ObjectClass *klass, void *data)
@@ -820,7 +819,6 @@ static const TypeInfo usb_tablet_info = {
 
 static const Property usb_mouse_properties[] = {
         DEFINE_PROP_UINT32("usb_version", USBHIDState, usb_version, 2),
-        DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_mouse_class_initfn(ObjectClass *klass, void *data)
@@ -844,7 +842,6 @@ static const TypeInfo usb_mouse_info = {
 static const Property usb_keyboard_properties[] = {
         DEFINE_PROP_UINT32("usb_version", USBHIDState, usb_version, 2),
         DEFINE_PROP_STRING("display", USBHIDState, display),
-        DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_keyboard_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 317ca0b081..3880e2aca8 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -668,7 +668,6 @@ static const VMStateDescription vmstate_usb_hub = {
 static const Property usb_hub_properties[] = {
     DEFINE_PROP_UINT32("ports", USBHubState, num_ports, 8),
     DEFINE_PROP_BOOL("port-power", USBHubState, port_power, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_hub_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 7994727e5e..326c92a43d 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -2082,7 +2082,6 @@ static const Property mtp_properties[] = {
     DEFINE_PROP_STRING("rootdir", MTPState, root),
     DEFINE_PROP_STRING("desc", MTPState, desc),
     DEFINE_PROP_BOOL("readonly", MTPState, readonly, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_mtp_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 6c4f5776d4..81863105ac 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1409,7 +1409,6 @@ static const VMStateDescription vmstate_usb_net = {
 
 static const Property net_properties[] = {
     DEFINE_NIC_PROPERTIES(USBNetState, conf),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_net_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 0c3e9160ec..a0821db902 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -637,7 +637,6 @@ static const VMStateDescription vmstate_usb_serial = {
 static const Property serial_properties[] = {
     DEFINE_PROP_CHR("chardev", USBSerialState, cs),
     DEFINE_PROP_BOOL("always-plugged", USBSerialState, always_plugged, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_serial_dev_class_init(ObjectClass *klass, void *data)
@@ -679,7 +678,6 @@ static const TypeInfo serial_info = {
 
 static const Property braille_properties[] = {
     DEFINE_PROP_CHR("chardev", USBSerialState, cs),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_braille_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index c3c02f0aad..73deb3ce83 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1173,7 +1173,6 @@ static Answer *ccid_peek_next_answer(USBCCIDState *s)
 
 static const Property ccid_props[] = {
     DEFINE_PROP_UINT32("slot", struct CCIDCardState, slot, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const TypeInfo ccid_bus_info = {
@@ -1433,7 +1432,6 @@ static const VMStateDescription ccid_vmstate = {
 
 static const Property ccid_properties[] = {
     DEFINE_PROP_UINT8("debug", USBCCIDState, debug, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ccid_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index ca037ba96f..818f58db2f 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -72,7 +72,6 @@ static const Property msd_properties[] = {
     DEFINE_BLOCK_ERROR_PROPERTIES(MSDState, conf),
     DEFINE_PROP_BOOL("removable", MSDState, removable, false),
     DEFINE_PROP_BOOL("commandlog", MSDState, commandlog, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_msd_class_storage_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 57e8d20051..44e30013d7 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -955,7 +955,6 @@ static const VMStateDescription vmstate_usb_uas = {
 
 static const Property uas_properties[] = {
     DEFINE_PROP_UINT32("log-scsi-req", UASDevice, requestlog, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_uas_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 6a10f3e9cd..e8152719f8 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -1450,7 +1450,6 @@ const VMStateDescription vmstate_dwc2_state = {
 
 static const Property dwc2_usb_properties[] = {
     DEFINE_PROP_UINT32("usb_version", DWC2State, usb_version, 2),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void dwc2_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
index ff970bd989..9ce9ba0b04 100644
--- a/hw/usb/hcd-dwc3.c
+++ b/hw/usb/hcd-dwc3.c
@@ -659,7 +659,6 @@ static const VMStateDescription vmstate_usb_dwc3 = {
 static const Property usb_dwc3_properties[] = {
     DEFINE_PROP_UINT32("DWC_USB3_USERID", USBDWC3, cfg.dwc_usb3_user,
                        0x12345678),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_dwc3_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 374f25c5ed..d410c38a8a 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -137,7 +137,6 @@ static void usb_ehci_pci_write_config(PCIDevice *dev, uint32_t addr,
 
 static const Property ehci_pci_properties[] = {
     DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_ehci_pci = {
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index f4e08aab89..768c3dd797 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -34,7 +34,6 @@ static const Property ehci_sysbus_properties[] = {
     DEFINE_PROP_UINT32("maxframes", EHCISysBusState, ehci.maxframes, 128),
     DEFINE_PROP_BOOL("companion-enable", EHCISysBusState, ehci.companion_enable,
                      false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 459644cc1b..b3684a2ef6 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -113,7 +113,6 @@ static const Property ohci_pci_properties[] = {
     DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),
     DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),
     DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_ohci = {
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 81cf2e558d..15311949b3 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -62,7 +62,6 @@ static const Property ohci_sysbus_properties[] = {
     DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
     DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),
     DEFINE_PROP_DMAADDR("dma-offset", OHCISysBusState, dma_offset, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 245352c231..142f24f2ea 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1232,12 +1232,10 @@ static const Property uhci_properties_companion[] = {
     DEFINE_PROP_UINT32("firstport", UHCIState, firstport, 0),
     DEFINE_PROP_UINT32("bandwidth", UHCIState, frame_bandwidth, 1280),
     DEFINE_PROP_UINT32("maxframes", UHCIState, maxframes, 128),
-    DEFINE_PROP_END_OF_LIST(),
 };
 static const Property uhci_properties_standalone[] = {
     DEFINE_PROP_UINT32("bandwidth", UHCIState, frame_bandwidth, 1280),
     DEFINE_PROP_UINT32("maxframes", UHCIState, maxframes, 128),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void uhci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index f06e7403e2..b1df95b52a 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -41,7 +41,6 @@ static const Property nec_xhci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
     DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void nec_xhci_instance_init(Object *obj)
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index f4dbad7cc6..ce43322396 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -85,7 +85,6 @@ void xhci_sysbus_build_aml(Aml *scope, uint32_t mmio, unsigned int irq)
 static const Property xhci_sysbus_props[] = {
     DEFINE_PROP_UINT32("intrs", XHCISysbusState, xhci.numintrs, XHCI_MAXINTRS),
     DEFINE_PROP_UINT32("slots", XHCISysbusState, xhci.numslots, XHCI_MAXSLOTS),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_xhci_sysbus = {
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 3c5006f425..3719c0f190 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3612,7 +3612,6 @@ static const Property xhci_properties[] = {
     DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),
     DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVICE,
                      DeviceState *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xhci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 85d33b51ba..0c753f5cc5 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1779,7 +1779,6 @@ static const Property usb_host_dev_properties[] = {
                     USB_HOST_OPT_PIPELINE, true),
     DEFINE_PROP_BOOL("suppress-remote-wake", USBHostDevice,
                      suppress_remote_wake, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usb_host_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index f72a612d5a..96fb963809 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2580,7 +2580,6 @@ static const Property usbredir_properties[] = {
     DEFINE_PROP_BOOL("streams", USBRedirDevice, enable_streams, true),
     DEFINE_PROP_BOOL("suppress-remote-wake", USBRedirDevice,
                      suppress_remote_wake, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void usbredir_class_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
index df86ce97fc..e1dd19ee92 100644
--- a/hw/usb/u2f-emulated.c
+++ b/hw/usb/u2f-emulated.c
@@ -375,7 +375,6 @@ static const Property u2f_emulated_properties[] = {
     DEFINE_PROP_STRING("privkey", U2FEmulatedState, privkey),
     DEFINE_PROP_STRING("entropy", U2FEmulatedState, entropy),
     DEFINE_PROP_STRING("counter", U2FEmulatedState, counter),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void u2f_emulated_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index ec4f6165d8..8df5215a1f 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -518,7 +518,6 @@ static const VMStateDescription u2f_passthru_vmstate = {
 
 static const Property u2f_passthru_properties[] = {
     DEFINE_PROP_STRING("hidraw", U2FPassthruState, hidraw),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void u2f_passthru_class_init(ObjectClass *klass, void *data)
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 2e6ea2dd93..529aad6332 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -197,7 +197,6 @@ static const Property vfio_ap_properties[] = {
     DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vfio_ap_reset(DeviceState *dev)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index b96ab27e12..bac56e8dd9 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -663,7 +663,6 @@ static const Property vfio_ccw_properties[] = {
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
     DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vfio_ccw_vmstate = {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 93aca850e3..0c5621da36 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3409,7 +3409,6 @@ static const Property vfio_pci_dev_properties[] = {
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 #ifdef CONFIG_IOMMUFD
@@ -3455,7 +3454,6 @@ static const Property vfio_pci_dev_nohotplug_properties[] = {
     DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
     DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
                             ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 766e8a86ef..7bc52a6f56 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -640,7 +640,6 @@ static const Property vfio_platform_dev_properties[] = {
     DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vfio_platform_instance_init(Object *obj)
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 61849b3b0e..d7b6af03f6 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -340,7 +340,6 @@ static void vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
 static const Property vhost_vdpa_device_properties[] = {
     DEFINE_PROP_STRING("vhostdev", VhostVdpaDevice, vhostdev),
     DEFINE_PROP_UINT16("queue-size", VhostVdpaDevice, queue_size, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const VMStateDescription vmstate_vhost_vdpa_device = {
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index 7536b37f18..3778f6131e 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -41,7 +41,6 @@ struct VHostSCSIPCI {
 static const Property vhost_scsi_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
index 99f1472023..1767ef2c9c 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -47,7 +47,6 @@ static const Property vhost_user_blk_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index 3222b67bd9..86eba138b4 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -35,7 +35,6 @@ static const Property vud_properties[] = {
     DEFINE_PROP_UINT32("vq_size", VHostUserBase, vq_size, 64),
     DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),
     DEFINE_PROP_UINT32("config_size", VHostUserBase, config_size, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vud_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
index 9ba6c40655..116eaab907 100644
--- a/hw/virtio/vhost-user-fs-pci.c
+++ b/hw/virtio/vhost-user-fs-pci.c
@@ -32,7 +32,6 @@ DECLARE_INSTANCE_CHECKER(VHostUserFSPCI, VHOST_USER_FS_PCI,
 static const Property vhost_user_fs_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index c0462329a5..f8714b5660 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -409,7 +409,6 @@ static const Property vuf_properties[] = {
     DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
                        conf.num_request_queues, 1),
     DEFINE_PROP_UINT16("queue-size", VHostUserFS, conf.queue_size, 128),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vuf_instance_init(Object *obj)
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index c997c66d80..4a08814904 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -16,7 +16,6 @@
 
 static const Property vgpio_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vgpio_realize(DeviceState *dev, Error **errp)
diff --git a/hw/virtio/vhost-user-i2c.c b/hw/virtio/vhost-user-i2c.c
index b0a5cbf3ea..1c7cde503c 100644
--- a/hw/virtio/vhost-user-i2c.c
+++ b/hw/virtio/vhost-user-i2c.c
@@ -16,7 +16,6 @@
 
 static const Property vi2c_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vi2c_realize(DeviceState *dev, Error **errp)
diff --git a/hw/virtio/vhost-user-input.c b/hw/virtio/vhost-user-input.c
index c57cc461bb..917405329f 100644
--- a/hw/virtio/vhost-user-input.c
+++ b/hw/virtio/vhost-user-input.c
@@ -9,7 +9,6 @@
 
 static const Property vinput_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vinput_realize(DeviceState *dev, Error **errp)
diff --git a/hw/virtio/vhost-user-rng-pci.c b/hw/virtio/vhost-user-rng-pci.c
index 0016ee74ce..a4e690148d 100644
--- a/hw/virtio/vhost-user-rng-pci.c
+++ b/hw/virtio/vhost-user-rng-pci.c
@@ -26,7 +26,6 @@ DECLARE_INSTANCE_CHECKER(VHostUserRNGPCI, VHOST_USER_RNG_PCI,
 static const Property vhost_user_rng_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_user_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index c9985b5fad..5aa432e5e1 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -22,7 +22,6 @@ static const VMStateDescription vu_rng_vmstate = {
 
 static const Property vrng_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vu_rng_base_realize(DeviceState *dev, Error **errp)
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index a15e6916ef..410a936ca7 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -279,7 +279,6 @@ static const VMStateDescription vu_scmi_vmstate = {
 
 static const Property vu_scmi_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserSCMI, chardev),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vu_scmi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index b2f6451f48..34e1a701b1 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -47,7 +47,6 @@ struct VHostUserSCSIPCI {
 static const Property vhost_user_scsi_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 8810a9f699..8610370af8 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -23,7 +23,6 @@ static const VMStateDescription vu_snd_vmstate = {
 
 static const Property vsnd_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vu_snd_base_realize(DeviceState *dev, Error **errp)
diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
index 529d967059..f730a05e78 100644
--- a/hw/virtio/vhost-user-vsock-pci.c
+++ b/hw/virtio/vhost-user-vsock-pci.c
@@ -33,7 +33,6 @@ struct VHostUserVSockPCI {
 
 static const Property vhost_user_vsock_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_user_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index 97885bfeab..293273080b 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -150,7 +150,6 @@ static void vuv_device_unrealize(DeviceState *dev)
 
 static const Property vuv_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserVSock, conf.chardev),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vuv_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index cb2253c39f..9ac587d20c 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -288,7 +288,6 @@ static struct vhost_dev *vhost_vsock_common_get_vhost(VirtIODevice *vdev)
 static const Property vhost_vsock_common_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("seqpacket", VHostVSockCommon, seqpacket,
                             ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_vsock_common_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
index 1d9abd02bd..6c618ee908 100644
--- a/hw/virtio/vhost-vsock-pci.c
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -37,7 +37,6 @@ struct VHostVSockPCI {
 
 static const Property vhost_vsock_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index ce80e84494..940b30fa27 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -208,7 +208,6 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
 static const Property vhost_vsock_properties[] = {
     DEFINE_PROP_UINT64("guest-cid", VHostVSock, conf.guest_cid, 0),
     DEFINE_PROP_STRING("vhostfd", VHostVSock, conf.vhostfd),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void vhost_vsock_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-9p-pci.c b/hw/virtio/virtio-9p-pci.c
index b33faf2fbb..aa1dce8f28 100644
--- a/hw/virtio/virtio-9p-pci.c
+++ b/hw/virtio/virtio-9p-pci.c
@@ -47,7 +47,6 @@ static const Property virtio_9p_pci_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_9p_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index ab2ee30475..ec4aa945f2 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -1032,7 +1032,6 @@ static const Property virtio_balloon_properties[] = {
                      qemu_4_0_config_size, false),
     DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
                      IOThread *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_balloon_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index abdcc11b2e..fc06cec656 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -44,7 +44,6 @@ static const Property virtio_blk_pci_properties[] = {
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 23c85fe586..8699481375 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -41,7 +41,6 @@ static const Property virtio_crypto_pci_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_crypto_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 9ae0b02598..617163f127 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1131,7 +1131,6 @@ static const VMStateDescription vmstate_virtio_crypto = {
 static const Property virtio_crypto_properties[] = {
     DEFINE_PROP_LINK("cryptodev", VirtIOCrypto, conf.cryptodev,
                      TYPE_CRYPTODEV_BACKEND, CryptoDevBackend *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_crypto_get_config(VirtIODevice *vdev, uint8_t *config)
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index 55c0b0555b..9e3c106777 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -39,7 +39,6 @@ struct VirtIOInputHIDPCI {
 
 static const Property virtio_input_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_input_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 92adf63684..97e03ce803 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -39,7 +39,6 @@ static const Property virtio_iommu_pci_properties[] = {
     DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
                       vdev.nr_prop_resv_regions, vdev.prop_resv_regions,
                       qdev_prop_reserved_region, ReservedRegion),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 576ad8383f..0988d21209 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1662,7 +1662,6 @@ static const Property virtio_iommu_properties[] = {
     DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
                              GRANULE_MODE_HOST),
     DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_iommu_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 3f6f46fad7..317d056eba 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1694,7 +1694,6 @@ static const Property virtio_mem_properties[] = {
                      early_migration, true),
     DEFINE_PROP_BOOL(VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP, VirtIOMEM,
                      dynamic_memslots, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static uint64_t virtio_mem_rdm_get_min_granularity(const RamDiscardManager *rdm,
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 49d9fe8f30..27d2f4b3b0 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -757,7 +757,6 @@ static const Property virtio_mmio_properties[] = {
     DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),
     DEFINE_PROP_BIT("ioeventfd", VirtIOMMIOProxy, flags,
                     VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_mmio_realizefn(DeviceState *d, Error **errp)
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index e86094ae22..e18953ad67 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -43,7 +43,6 @@ static const Property virtio_net_properties[] = {
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_net_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
index 685c548361..098e1aeac6 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -1707,7 +1707,6 @@ static const VMStateDescription vmstate_virtio_nsm = {
 
 static const Property virtio_nsm_properties[] = {
     DEFINE_PROP_STRING("module-id", VirtIONSM, module_id),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_nsm_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index de41cb5ef2..cb61adc659 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2378,7 +2378,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_AER_BIT, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
@@ -2435,7 +2434,6 @@ static const Property virtio_pci_generic_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("disable-legacy", VirtIOPCIProxy, disable_legacy,
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("disable-modern", VirtIOPCIProxy, disable_modern, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_pci_base_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index f6f3b5ddaf..9759023ab3 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -159,7 +159,6 @@ static const Property virtio_pmem_properties[] = {
     DEFINE_PROP_UINT64(VIRTIO_PMEM_ADDR_PROP, VirtIOPMEM, start, 0),
     DEFINE_PROP_LINK(VIRTIO_PMEM_MEMDEV_PROP, VirtIOPMEM, memdev,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_pmem_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
index 398f432237..a94ff767b2 100644
--- a/hw/virtio/virtio-rng-pci.c
+++ b/hw/virtio/virtio-rng-pci.c
@@ -37,7 +37,6 @@ static const Property virtio_rng_properties[] = {
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 13a1a0b236..0660e872f7 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -258,7 +258,6 @@ static const Property virtio_rng_properties[] = {
     DEFINE_PROP_UINT64("max-bytes", VirtIORNG, conf.max_bytes, INT64_MAX),
     DEFINE_PROP_UINT32("period", VirtIORNG, conf.period_ms, 1 << 16),
     DEFINE_PROP_LINK("rng", VirtIORNG, conf.rng, TYPE_RNG_BACKEND, RngBackend *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_rng_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index 733b5756db..d44fd2fffb 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -40,7 +40,6 @@ static const Property virtio_scsi_pci_properties[] = {
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                        DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/hw/virtio/virtio-serial-pci.c b/hw/virtio/virtio-serial-pci.c
index bda643ec54..b5b77eb266 100644
--- a/hw/virtio/virtio-serial-pci.c
+++ b/hw/virtio/virtio-serial-pci.c
@@ -74,7 +74,6 @@ static const Property virtio_serial_pci_properties[] = {
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void virtio_serial_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7fcdb55ba4..b871295b94 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4018,7 +4018,6 @@ static const Property virtio_properties[] = {
     DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
     DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
                      disable_legacy_check, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 2e25d4b4e9..6b6fc31f22 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -270,7 +270,6 @@ static const Property wdt_sbsa_gwdt_props[] = {
      */
     DEFINE_PROP_UINT64("clock-frequency", struct SBSA_GWDTState, freq,
                        62500000),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, void *data)
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index c95877e5c7..78dedb065e 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -291,7 +291,6 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
 static const Property aspeed_wdt_properties[] = {
     DEFINE_PROP_LINK("scu", AspeedWDTState, scu, TYPE_ASPEED_SCU,
                      AspeedSCUState *),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void aspeed_wdt_class_init(ObjectClass *klass, void *data)
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 61fbd91ee4..878e5098b6 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -284,7 +284,6 @@ static void imx2_wdt_realize(DeviceState *dev, Error **errp)
 static const Property imx2_wdt_properties[] = {
     DEFINE_PROP_BOOL("pretimeout-support", IMX2WdtState, pretimeout_support,
                      false),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void imx2_wdt_class_init(ObjectClass *klass, void *data)
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 0d7defb8cd..2007ec0892 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1095,7 +1095,6 @@ unrealize:
 static const Property xen_device_props[] = {
     DEFINE_PROP_UINT16("frontend-id", XenDevice, frontend_id,
                        DOMID_INVALID),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void xen_device_class_init(ObjectClass *class, void *data)
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 557aa98be4..e2bd4c7d41 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -934,7 +934,6 @@ static void xen_pt_unregister_device(PCIDevice *d)
 static const Property xen_pci_passthrough_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("hostaddr", XenPCIPassthroughState, hostaddr),
     DEFINE_PROP_BOOL("permissive", XenPCIPassthroughState, permissive, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xen_pci_passthrough_instance_init(Object *obj)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1afa07511e..0e882c474e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2652,7 +2652,6 @@ static const Property arm_cpu_properties[] = {
     DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
     /* True to default to the backward-compat old CNTFRQ rather than 1Ghz */
     DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU, backcompat_cntfrq, false),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const gchar *arm_gdb_arch_name(CPUState *cs)
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a7529a1b3d..64dc15655b 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -151,7 +151,6 @@ static void avr_cpu_initfn(Object *obj)
 
 static const Property avr_cpu_properties[] = {
     DEFINE_PROP_UINT32("init-sp", AVRCPU, init_sp, 0),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index a70007245e..8c89a8ce31 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -53,7 +53,6 @@ static const Property hexagon_cpu_properties[] = {
     DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
                          qdev_prop_uint32, target_ulong),
     DEFINE_PROP_BOOL("short-circuit", HexagonCPU, short_circuit, true),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS] = {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5253399459..c28adee34f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5387,7 +5387,6 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
 static const Property max_x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("migratable", X86CPU, migratable, true),
     DEFINE_PROP_BOOL("host-cache-info", X86CPU, cache_info_passthrough, false),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void max_x86_cpu_realize(DeviceState *dev, Error **errp)
@@ -8548,7 +8547,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 0e41e39c0e..83554f62d3 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -403,7 +403,6 @@ static const Property mb_properties[] = {
     /*
      * End of properties reserved by Xilinx DTS conversion tool.
      */
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 02c0e1b0f9..aa3d905e70 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -541,7 +541,6 @@ static const struct SysemuCPUOps mips_sysemu_ops = {
 
 static const Property mips_cpu_properties[] = {
     DEFINE_PROP_BOOL("big-endian", MIPSCPU, is_big_endian, TARGET_BIG_ENDIAN),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 #ifdef CONFIG_TCG
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7aa041f57a..a5aa3a8670 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2699,7 +2699,6 @@ static const Property riscv_cpu_properties[] = {
      * it with -x and default to 'false'.
      */
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 #if defined(TARGET_RISCV64)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 263f9e84ed..9b367ed2d5 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -318,7 +318,6 @@ static const Property s390x_cpu_properties[] = {
     DEFINE_PROP_BOOL("dedicated", S390CPU, env.dedicated, false),
     DEFINE_PROP_CPUS390ENTITLEMENT("entitlement", S390CPU, env.entitlement,
                                    S390_CPU_ENTITLEMENT_AUTO),
-    DEFINE_PROP_END_OF_LIST()
 };
 #endif
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 8f494c286a..a65a6466a7 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -917,7 +917,6 @@ static const Property sparc_cpu_properties[] = {
     DEFINE_PROP_UINT32("mmu-version", SPARCCPU, env.def.mmu_version, 0),
     DEFINE_PROP("nwindows", SPARCCPU, env.def.nwindows,
                 qdev_prop_nwindows, uint32_t),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 1eb95d2429..de7a572e68 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -49,7 +49,6 @@ struct MyType {
 static const Property static_props[] = {
     DEFINE_PROP_UINT32("prop1", MyType, prop1, PROP_DEFAULT),
     DEFINE_PROP_UINT32("prop2", MyType, prop2, PROP_DEFAULT),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static void static_prop_class_init(ObjectClass *oc, void *data)
diff --git a/docs/devel/migration/compatibility.rst b/docs/devel/migration/compatibility.rst
index c787f53738..ecb887e318 100644
--- a/docs/devel/migration/compatibility.rst
+++ b/docs/devel/migration/compatibility.rst
@@ -401,7 +401,6 @@ the old behaviour or the new behaviour::
          DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
     +    DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
     +                    QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
-         DEFINE_PROP_END_OF_LIST()
      };
 
 Notice that we enable the feature for new machine types.
diff --git a/docs/devel/virtio-backends.rst b/docs/devel/virtio-backends.rst
index a6f9df4845..679d7544b8 100644
--- a/docs/devel/virtio-backends.rst
+++ b/docs/devel/virtio-backends.rst
@@ -107,7 +107,6 @@ manually instantiated:
                       VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
       DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
                          DEV_NVECTORS_UNSPECIFIED),
-      DEFINE_PROP_END_OF_LIST(),
   };
 
   static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-- 
2.43.0


