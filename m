Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E51DCA0FFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 14:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk354-0005Sk-I3; Fri, 30 Aug 2024 10:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk352-0005M8-Rr
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:28 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34v-0004bM-L8
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:28 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-533463f6b16so2467226e87.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725029900; x=1725634700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWpdb/g67wtH0k+YODA2Qm9tS8zw0Noyu/9i4+TqQZE=;
 b=wPyn61Rx1Ze157KCDAjktREEM9BdH/qnusM+NnM+GEfqEXAEU8oL/gUXDeRCLP1oKg
 SYpcvBfmOCKzBXeVMuOJSQ2Y5UZhqGKuQJWVav16VR2sgqLTCc2btHgG2/+De387g947
 SdtT4GcOl2CP9vaCE8o6eQP9LKc8Yj+jSnszFpFLSYYyHi83DcCZqhcPKYpaWAxUdFc3
 621Lu2GeLuOWZqejpGtBu5Je3Bqsk6Q9Wj1M+ib90Ggg77QAs0AmqqAvwlbrLTYHo8Sg
 3R8XdiqTKNvAd6JUpTH8/C1WW3ZfrY8SIfqNtZQfKjHEQToiPItgkwN70JXL+9BNxQTx
 bNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725029900; x=1725634700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWpdb/g67wtH0k+YODA2Qm9tS8zw0Noyu/9i4+TqQZE=;
 b=N+KDGtZygnx6LJiqQTa/zUO8JJEMTIDXTO5kLG1PVyi3MUxAp2aL2cuiAIkeyMuGFM
 gN2qUTpvgCbARyXFQD0CIOu+dk6XJI1hK+9zCVaJiTKg4JDaSaJVY6Mht1zZ3Nc34/TL
 xX4lwCms551L+zK75ZXIgDKJ69suIwp8lSnGX178/axZRWiiyogOWeR3FEk1jjM6+0dv
 1RByQNOVkuBazSip2A97oXwBJpe8K+mr84Vtw7O34NPhvlzF+iG59k3oXka/Ymn7WEw+
 h3Im9ZWS3P07ic4B+HOR5LLiT2VxLsjwjW13h4SOlH3o6UgY1bQq8oNcI0pbW6afiOEx
 eIng==
X-Gm-Message-State: AOJu0YwDwLZt4oCrnxPDb0c1vwi7k+XBwVvkOMPIAA6zXJhFHYyGJo0e
 TpCKQuAjb/ZL1v2LNwDdwpCF+720uaWdp9tHJosOaweVS0hplrkXm/zrHmdt4paC2mIf6xM+bOP
 f
X-Google-Smtp-Source: AGHT+IHjHfStTImVbsNoNq8bPxCT085r8J8k4rsvWD0gJuWIPVtC2teNJycwhieGUUlZG97eRrL7ig==
X-Received: by 2002:a05:6512:3351:b0:52f:89aa:c344 with SMTP id
 2adb3069b0e04-53546aff219mr1524489e87.16.1725029899201; 
 Fri, 30 Aug 2024 07:58:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6da24bbsm49022345e9.0.2024.08.30.07.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:58:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 07/11] hw: Use device_class_set_legacy_reset() instead of
 opencoding
Date: Fri, 30 Aug 2024 15:58:08 +0100
Message-Id: <20240830145812.1967042-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830145812.1967042-1-peter.maydell@linaro.org>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use device_class_set_legacy_reset() instead of opencoding an
assignment to DeviceClass::reset. This change was produced
with:
 spatch --macro-file scripts/cocci-macro-file.h \
    --sp-file scripts/coccinelle/device-reset.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/acpi/erst.c                      |  2 +-
 hw/acpi/piix4.c                     |  2 +-
 hw/adc/aspeed_adc.c                 |  2 +-
 hw/adc/max111x.c                    |  2 +-
 hw/adc/stm32f2xx_adc.c              |  2 +-
 hw/adc/zynq-xadc.c                  |  2 +-
 hw/arm/armsse.c                     |  2 +-
 hw/arm/highbank.c                   |  2 +-
 hw/arm/musicpal.c                   |  6 +++---
 hw/arm/pxa2xx.c                     |  4 ++--
 hw/arm/strongarm.c                  |  4 ++--
 hw/audio/ac97.c                     |  2 +-
 hw/audio/cs4231.c                   |  2 +-
 hw/audio/cs4231a.c                  |  2 +-
 hw/audio/es1370.c                   |  2 +-
 hw/audio/hda-codec.c                |  2 +-
 hw/audio/intel-hda.c                |  2 +-
 hw/audio/marvell_88w8618.c          |  2 +-
 hw/audio/pl041.c                    |  2 +-
 hw/audio/via-ac97.c                 |  2 +-
 hw/block/fdc-isa.c                  |  2 +-
 hw/block/fdc-sysbus.c               |  2 +-
 hw/block/m25p80.c                   |  2 +-
 hw/block/nand.c                     |  2 +-
 hw/block/onenand.c                  |  2 +-
 hw/block/pflash_cfi01.c             |  2 +-
 hw/block/pflash_cfi02.c             |  2 +-
 hw/block/swim.c                     |  2 +-
 hw/char/avr_usart.c                 |  2 +-
 hw/char/cmsdk-apb-uart.c            |  2 +-
 hw/char/digic-uart.c                |  2 +-
 hw/char/escc.c                      |  2 +-
 hw/char/etraxfs_ser.c               |  2 +-
 hw/char/exynos4210_uart.c           |  2 +-
 hw/char/goldfish_tty.c              |  2 +-
 hw/char/grlib_apbuart.c             |  2 +-
 hw/char/ibex_uart.c                 |  2 +-
 hw/char/imx_serial.c                |  2 +-
 hw/char/mcf_uart.c                  |  2 +-
 hw/char/mchp_pfsoc_mmuart.c         |  2 +-
 hw/char/nrf51_uart.c                |  2 +-
 hw/char/pl011.c                     |  2 +-
 hw/char/renesas_sci.c               |  2 +-
 hw/char/sclpconsole-lm.c            |  2 +-
 hw/char/sclpconsole.c               |  2 +-
 hw/char/sh_serial.c                 |  2 +-
 hw/char/shakti_uart.c               |  2 +-
 hw/char/stm32f2xx_usart.c           |  2 +-
 hw/char/xilinx_uartlite.c           |  2 +-
 hw/core/or-irq.c                    |  2 +-
 hw/core/qdev.c                      |  2 +-
 hw/cxl/switch-mailbox-cci.c         |  2 +-
 hw/display/artist.c                 |  2 +-
 hw/display/ati.c                    |  2 +-
 hw/display/bcm2835_fb.c             |  2 +-
 hw/display/cg3.c                    |  2 +-
 hw/display/dpcd.c                   |  2 +-
 hw/display/exynos4210_fimd.c        |  2 +-
 hw/display/g364fb.c                 |  2 +-
 hw/display/i2c-ddc.c                |  2 +-
 hw/display/jazz_led.c               |  2 +-
 hw/display/macfb.c                  |  4 ++--
 hw/display/qxl.c                    |  2 +-
 hw/display/sii9022.c                |  2 +-
 hw/display/sm501.c                  |  4 ++--
 hw/display/tcx.c                    |  2 +-
 hw/display/vga-isa.c                |  2 +-
 hw/display/vga-mmio.c               |  2 +-
 hw/display/vga-pci.c                |  2 +-
 hw/display/vmware_vga.c             |  2 +-
 hw/display/xlnx_dp.c                |  2 +-
 hw/dma/bcm2835_dma.c                |  2 +-
 hw/dma/i8257.c                      |  2 +-
 hw/dma/pl080.c                      |  2 +-
 hw/dma/pl330.c                      |  2 +-
 hw/dma/rc4030.c                     |  2 +-
 hw/dma/sparc32_dma.c                |  2 +-
 hw/dma/xilinx_axidma.c              |  2 +-
 hw/dma/xlnx-zdma.c                  |  2 +-
 hw/dma/xlnx-zynq-devcfg.c           |  2 +-
 hw/dma/xlnx_csu_dma.c               |  2 +-
 hw/dma/xlnx_dpdma.c                 |  2 +-
 hw/fsi/aspeed_apb2opb.c             |  2 +-
 hw/fsi/fsi-master.c                 |  2 +-
 hw/fsi/fsi.c                        |  2 +-
 hw/fsi/lbus.c                       |  2 +-
 hw/gpio/aspeed_gpio.c               |  2 +-
 hw/gpio/bcm2835_gpio.c              |  2 +-
 hw/gpio/bcm2838_gpio.c              |  2 +-
 hw/gpio/gpio_key.c                  |  2 +-
 hw/gpio/imx_gpio.c                  |  2 +-
 hw/gpio/max7310.c                   |  2 +-
 hw/gpio/mpc8xxx.c                   |  2 +-
 hw/gpio/nrf51_gpio.c                |  2 +-
 hw/gpio/omap_gpio.c                 |  4 ++--
 hw/gpio/pca9552.c                   |  2 +-
 hw/gpio/pca9554.c                   |  2 +-
 hw/gpio/pcf8574.c                   |  2 +-
 hw/gpio/sifive_gpio.c               |  2 +-
 hw/hyperv/hyperv.c                  |  2 +-
 hw/hyperv/vmbus.c                   |  2 +-
 hw/i2c/aspeed_i2c.c                 |  4 ++--
 hw/i2c/bcm2835_i2c.c                |  2 +-
 hw/i2c/exynos4210_i2c.c             |  2 +-
 hw/i2c/imx_i2c.c                    |  2 +-
 hw/i2c/microbit_i2c.c               |  2 +-
 hw/i2c/mpc_i2c.c                    |  2 +-
 hw/i2c/omap_i2c.c                   |  2 +-
 hw/i2c/ppc4xx_i2c.c                 |  2 +-
 hw/i2c/smbus_eeprom.c               |  2 +-
 hw/i386/amd_iommu.c                 |  2 +-
 hw/i386/intel_iommu.c               |  2 +-
 hw/i386/kvm/i8254.c                 |  2 +-
 hw/i386/kvm/i8259.c                 |  2 +-
 hw/i386/kvm/ioapic.c                |  2 +-
 hw/i386/kvm/xen_overlay.c           |  2 +-
 hw/i386/port92.c                    |  2 +-
 hw/i386/vapic.c                     |  2 +-
 hw/i386/vmmouse.c                   |  2 +-
 hw/i386/xen/xen_platform.c          |  2 +-
 hw/ide/ahci.c                       |  2 +-
 hw/ide/cmd646.c                     |  2 +-
 hw/ide/ich.c                        |  2 +-
 hw/ide/isa.c                        |  2 +-
 hw/ide/macio.c                      |  2 +-
 hw/ide/microdrive.c                 |  2 +-
 hw/ide/mmio.c                       |  2 +-
 hw/ide/piix.c                       |  4 ++--
 hw/ide/sii3112.c                    |  2 +-
 hw/ide/via.c                        |  2 +-
 hw/input/adb-kbd.c                  |  2 +-
 hw/input/adb-mouse.c                |  2 +-
 hw/input/lm832x.c                   |  2 +-
 hw/input/pckbd.c                    |  4 ++--
 hw/intc/allwinner-a10-pic.c         |  2 +-
 hw/intc/apic_common.c               |  2 +-
 hw/intc/armv7m_nvic.c               |  2 +-
 hw/intc/aspeed_intc.c               |  2 +-
 hw/intc/aspeed_vic.c                |  2 +-
 hw/intc/bcm2835_ic.c                |  2 +-
 hw/intc/bcm2836_control.c           |  2 +-
 hw/intc/exynos4210_combiner.c       |  2 +-
 hw/intc/goldfish_pic.c              |  2 +-
 hw/intc/grlib_irqmp.c               |  2 +-
 hw/intc/heathrow_pic.c              |  2 +-
 hw/intc/i8259.c                     |  2 +-
 hw/intc/imx_avic.c                  |  2 +-
 hw/intc/imx_gpcv2.c                 |  2 +-
 hw/intc/ioapic.c                    |  2 +-
 hw/intc/loongarch_extioi.c          |  2 +-
 hw/intc/loongarch_pch_pic.c         |  2 +-
 hw/intc/m68k_irqc.c                 |  2 +-
 hw/intc/omap_intc.c                 |  4 ++--
 hw/intc/openpic.c                   |  2 +-
 hw/intc/openpic_kvm.c               |  2 +-
 hw/intc/pl190.c                     |  2 +-
 hw/intc/ppc-uic.c                   |  2 +-
 hw/intc/s390_flic.c                 |  2 +-
 hw/intc/s390_flic_kvm.c             |  2 +-
 hw/intc/sifive_plic.c               |  2 +-
 hw/intc/slavio_intctl.c             |  2 +-
 hw/intc/xlnx-pmu-iomod-intc.c       |  2 +-
 hw/intc/xlnx-zynqmp-ipi.c           |  2 +-
 hw/isa/lpc_ich9.c                   |  2 +-
 hw/isa/pc87312.c                    |  2 +-
 hw/isa/piix.c                       |  2 +-
 hw/isa/vt82c686.c                   | 10 +++++-----
 hw/m68k/mcf5206.c                   |  2 +-
 hw/m68k/mcf_intc.c                  |  2 +-
 hw/m68k/next-cube.c                 |  2 +-
 hw/m68k/next-kbd.c                  |  2 +-
 hw/mem/cxl_type3.c                  |  2 +-
 hw/misc/a9scu.c                     |  2 +-
 hw/misc/allwinner-cpucfg.c          |  2 +-
 hw/misc/allwinner-h3-ccu.c          |  2 +-
 hw/misc/allwinner-h3-dramc.c        |  2 +-
 hw/misc/allwinner-h3-sysctrl.c      |  2 +-
 hw/misc/allwinner-r40-ccu.c         |  2 +-
 hw/misc/allwinner-r40-dramc.c       |  2 +-
 hw/misc/allwinner-sid.c             |  2 +-
 hw/misc/allwinner-sramc.c           |  2 +-
 hw/misc/applesmc.c                  |  2 +-
 hw/misc/arm_l2x0.c                  |  2 +-
 hw/misc/arm_sysctl.c                |  2 +-
 hw/misc/armsse-cpu-pwrctrl.c        |  2 +-
 hw/misc/armsse-mhu.c                |  2 +-
 hw/misc/aspeed_hace.c               |  2 +-
 hw/misc/aspeed_i3c.c                |  4 ++--
 hw/misc/aspeed_lpc.c                |  2 +-
 hw/misc/aspeed_peci.c               |  2 +-
 hw/misc/aspeed_sbc.c                |  2 +-
 hw/misc/aspeed_scu.c                | 10 +++++-----
 hw/misc/aspeed_sdmc.c               |  4 ++--
 hw/misc/aspeed_xdma.c               |  2 +-
 hw/misc/avr_power.c                 |  2 +-
 hw/misc/bcm2835_cprman.c            |  8 ++++----
 hw/misc/bcm2835_mbox.c              |  2 +-
 hw/misc/bcm2835_mphi.c              |  2 +-
 hw/misc/bcm2835_powermgt.c          |  2 +-
 hw/misc/bcm2835_rng.c               |  2 +-
 hw/misc/bcm2835_thermal.c           |  2 +-
 hw/misc/eccmemctl.c                 |  2 +-
 hw/misc/exynos4210_clk.c            |  2 +-
 hw/misc/exynos4210_pmu.c            |  2 +-
 hw/misc/exynos4210_rng.c            |  2 +-
 hw/misc/imx25_ccm.c                 |  2 +-
 hw/misc/imx31_ccm.c                 |  2 +-
 hw/misc/imx6_ccm.c                  |  2 +-
 hw/misc/imx6_src.c                  |  2 +-
 hw/misc/imx6ul_ccm.c                |  2 +-
 hw/misc/imx7_ccm.c                  |  4 ++--
 hw/misc/imx7_snvs.c                 |  2 +-
 hw/misc/imx7_src.c                  |  2 +-
 hw/misc/imx_rngc.c                  |  2 +-
 hw/misc/iotkit-secctl.c             |  2 +-
 hw/misc/iotkit-sysctl.c             |  2 +-
 hw/misc/ivshmem.c                   |  2 +-
 hw/misc/lasi.c                      |  2 +-
 hw/misc/led.c                       |  2 +-
 hw/misc/macio/cuda.c                |  2 +-
 hw/misc/macio/gpio.c                |  2 +-
 hw/misc/macio/mac_dbdma.c           |  2 +-
 hw/misc/macio/pmu.c                 |  2 +-
 hw/misc/mips_cmgcr.c                |  2 +-
 hw/misc/mips_cpc.c                  |  2 +-
 hw/misc/mips_itu.c                  |  2 +-
 hw/misc/mps2-fpgaio.c               |  2 +-
 hw/misc/mps2-scc.c                  |  2 +-
 hw/misc/msf2-sysreg.c               |  2 +-
 hw/misc/nrf51_rng.c                 |  2 +-
 hw/misc/pci-testdev.c               |  2 +-
 hw/misc/sifive_e_aon.c              |  2 +-
 hw/misc/sifive_u_prci.c             |  2 +-
 hw/misc/slavio_misc.c               |  2 +-
 hw/misc/stm32f2xx_syscfg.c          |  2 +-
 hw/misc/stm32f4xx_exti.c            |  2 +-
 hw/misc/stm32f4xx_syscfg.c          |  2 +-
 hw/misc/tz-mpc.c                    |  2 +-
 hw/misc/tz-msc.c                    |  2 +-
 hw/misc/tz-ppc.c                    |  2 +-
 hw/misc/virt_ctrl.c                 |  2 +-
 hw/misc/xlnx-versal-cfu.c           |  2 +-
 hw/net/allwinner-sun8i-emac.c       |  2 +-
 hw/net/allwinner_emac.c             |  2 +-
 hw/net/cadence_gem.c                |  2 +-
 hw/net/can/can_kvaser_pci.c         |  2 +-
 hw/net/can/can_mioe3680_pci.c       |  2 +-
 hw/net/can/can_pcm3680_pci.c        |  2 +-
 hw/net/can/ctucan_pci.c             |  2 +-
 hw/net/can/xlnx-versal-canfd.c      |  2 +-
 hw/net/dp8393x.c                    |  2 +-
 hw/net/etraxfs_eth.c                |  2 +-
 hw/net/fsl_etsec/etsec.c            |  2 +-
 hw/net/ftgmac100.c                  |  4 ++--
 hw/net/imx_fec.c                    |  2 +-
 hw/net/lan9118.c                    |  2 +-
 hw/net/lance.c                      |  2 +-
 hw/net/lasi_i82596.c                |  2 +-
 hw/net/mcf_fec.c                    |  2 +-
 hw/net/mipsnet.c                    |  2 +-
 hw/net/msf2-emac.c                  |  2 +-
 hw/net/npcm7xx_emc.c                |  2 +-
 hw/net/npcm_gmac.c                  |  2 +-
 hw/net/opencores_eth.c              |  2 +-
 hw/net/pcnet-pci.c                  |  2 +-
 hw/net/rocker/rocker.c              |  2 +-
 hw/net/rtl8139.c                    |  2 +-
 hw/net/smc91c111.c                  |  2 +-
 hw/net/stellaris_enet.c             |  2 +-
 hw/net/sungem.c                     |  2 +-
 hw/net/sunhme.c                     |  2 +-
 hw/net/tulip.c                      |  2 +-
 hw/net/vmxnet3.c                    |  2 +-
 hw/net/xilinx_axienet.c             |  2 +-
 hw/net/xilinx_ethlite.c             |  2 +-
 hw/nvme/ctrl.c                      |  2 +-
 hw/nvram/eeprom_at24c.c             |  2 +-
 hw/nvram/fw_cfg.c                   |  2 +-
 hw/nvram/mac_nvram.c                |  2 +-
 hw/nvram/nrf51_nvm.c                |  2 +-
 hw/pci-bridge/cxl_downstream.c      |  2 +-
 hw/pci-bridge/cxl_upstream.c        |  2 +-
 hw/pci-bridge/i82801b11.c           |  2 +-
 hw/pci-bridge/pci_bridge_dev.c      |  2 +-
 hw/pci-bridge/pci_expander_bridge.c |  2 +-
 hw/pci-bridge/pcie_pci_bridge.c     |  2 +-
 hw/pci-bridge/simba.c               |  2 +-
 hw/pci-bridge/xio3130_downstream.c  |  2 +-
 hw/pci-bridge/xio3130_upstream.c    |  2 +-
 hw/pci-host/astro.c                 |  4 ++--
 hw/pci-host/designware.c            |  2 +-
 hw/pci-host/dino.c                  |  2 +-
 hw/pci-host/gt64120.c               |  2 +-
 hw/pci-host/mv64361.c               |  2 +-
 hw/pci-host/ppc440_pcix.c           |  2 +-
 hw/pci-host/q35.c                   |  2 +-
 hw/pci-host/sabre.c                 |  2 +-
 hw/pci-host/versatile.c             |  2 +-
 hw/pci-host/xilinx-pcie.c           |  2 +-
 hw/ppc/pnv_psi.c                    |  4 ++--
 hw/ppc/ppc405_boards.c              |  2 +-
 hw/ppc/ppc405_uc.c                  | 12 ++++++------
 hw/ppc/ppc4xx_devs.c                |  6 +++---
 hw/ppc/ppc4xx_sdram.c               |  4 ++--
 hw/ppc/ppce500_spin.c               |  2 +-
 hw/ppc/spapr_cpu_core.c             |  2 +-
 hw/ppc/spapr_iommu.c                |  2 +-
 hw/ppc/spapr_pci.c                  |  2 +-
 hw/ppc/spapr_vio.c                  |  2 +-
 hw/remote/proxy.c                   |  2 +-
 hw/rtc/allwinner-rtc.c              |  2 +-
 hw/rtc/aspeed_rtc.c                 |  2 +-
 hw/rtc/ds1338.c                     |  2 +-
 hw/rtc/exynos4210_rtc.c             |  2 +-
 hw/rtc/goldfish_rtc.c               |  2 +-
 hw/rtc/ls7a_rtc.c                   |  2 +-
 hw/rtc/m48t59-isa.c                 |  2 +-
 hw/rtc/m48t59.c                     |  2 +-
 hw/rtc/xlnx-zynqmp-rtc.c            |  2 +-
 hw/s390x/event-facility.c           |  2 +-
 hw/s390x/ipl.c                      |  2 +-
 hw/s390x/s390-pci-bus.c             |  4 ++--
 hw/s390x/sclpquiesce.c              |  2 +-
 hw/scsi/esp-pci.c                   |  2 +-
 hw/scsi/esp.c                       |  2 +-
 hw/scsi/lsi53c895a.c                |  2 +-
 hw/scsi/megasas.c                   |  2 +-
 hw/scsi/mptsas.c                    |  2 +-
 hw/scsi/scsi-disk.c                 |  2 +-
 hw/scsi/scsi-generic.c              |  2 +-
 hw/scsi/vmw_pvscsi.c                |  2 +-
 hw/sd/allwinner-sdhost.c            |  2 +-
 hw/sd/aspeed_sdhci.c                |  2 +-
 hw/sd/bcm2835_sdhost.c              |  2 +-
 hw/sd/cadence_sdhci.c               |  2 +-
 hw/sd/npcm7xx_sdhci.c               |  2 +-
 hw/sd/pl181.c                       |  2 +-
 hw/sd/pxa2xx_mmci.c                 |  2 +-
 hw/sd/sd.c                          |  2 +-
 hw/sd/sdhci.c                       |  2 +-
 hw/sd/ssi-sd.c                      |  2 +-
 hw/sensor/dps310.c                  |  2 +-
 hw/sensor/emc141x.c                 |  2 +-
 hw/sensor/lsm303dlhc_mag.c          |  2 +-
 hw/sparc/sun4m_iommu.c              |  2 +-
 hw/sparc64/sun4u_iommu.c            |  2 +-
 hw/ssi/aspeed_smc.c                 |  2 +-
 hw/ssi/bcm2835_spi.c                |  2 +-
 hw/ssi/ibex_spi_host.c              |  2 +-
 hw/ssi/imx_spi.c                    |  2 +-
 hw/ssi/mss-spi.c                    |  2 +-
 hw/ssi/pl022.c                      |  2 +-
 hw/ssi/pnv_spi.c                    |  2 +-
 hw/ssi/sifive_spi.c                 |  2 +-
 hw/ssi/stm32f2xx_spi.c              |  2 +-
 hw/ssi/xilinx_spi.c                 |  2 +-
 hw/ssi/xilinx_spips.c               |  4 ++--
 hw/ssi/xlnx-versal-ospi.c           |  2 +-
 hw/timer/a9gtimer.c                 |  2 +-
 hw/timer/allwinner-a10-pit.c        |  2 +-
 hw/timer/arm_mptimer.c              |  2 +-
 hw/timer/armv7m_systick.c           |  2 +-
 hw/timer/aspeed_timer.c             |  2 +-
 hw/timer/avr_timer16.c              |  2 +-
 hw/timer/bcm2835_systmr.c           |  2 +-
 hw/timer/cmsdk-apb-dualtimer.c      |  2 +-
 hw/timer/cmsdk-apb-timer.c          |  2 +-
 hw/timer/digic-timer.c              |  2 +-
 hw/timer/exynos4210_mct.c           |  2 +-
 hw/timer/exynos4210_pwm.c           |  2 +-
 hw/timer/grlib_gptimer.c            |  2 +-
 hw/timer/hpet.c                     |  2 +-
 hw/timer/i8254.c                    |  2 +-
 hw/timer/ibex_timer.c               |  2 +-
 hw/timer/imx_epit.c                 |  2 +-
 hw/timer/imx_gpt.c                  |  2 +-
 hw/timer/nrf51_timer.c              |  2 +-
 hw/timer/renesas_cmt.c              |  2 +-
 hw/timer/renesas_tmr.c              |  2 +-
 hw/timer/sifive_pwm.c               |  2 +-
 hw/timer/slavio_timer.c             |  2 +-
 hw/timer/sse-counter.c              |  2 +-
 hw/timer/sse-timer.c                |  2 +-
 hw/timer/stm32f2xx_timer.c          |  2 +-
 hw/tpm/tpm_tis_i2c.c                |  2 +-
 hw/tpm/tpm_tis_isa.c                |  2 +-
 hw/tpm/tpm_tis_sysbus.c             |  2 +-
 hw/tricore/tricore_testdevice.c     |  2 +-
 hw/usb/hcd-dwc3.c                   |  2 +-
 hw/usb/hcd-ehci-pci.c               |  2 +-
 hw/usb/hcd-ehci-sysbus.c            |  2 +-
 hw/usb/hcd-ohci-pci.c               |  2 +-
 hw/usb/hcd-ohci-sysbus.c            |  2 +-
 hw/usb/hcd-uhci.c                   |  2 +-
 hw/usb/hcd-xhci-pci.c               |  2 +-
 hw/usb/hcd-xhci-sysbus.c            |  2 +-
 hw/usb/hcd-xhci.c                   |  2 +-
 hw/usb/imx-usb-phy.c                |  2 +-
 hw/usb/tusb6010.c                   |  2 +-
 hw/vfio/ap.c                        |  2 +-
 hw/vfio/ccw.c                       |  2 +-
 hw/vfio/pci.c                       |  2 +-
 hw/virtio/virtio-mmio.c             |  2 +-
 hw/watchdog/cmsdk-apb-watchdog.c    |  2 +-
 hw/watchdog/sbsa_gwdt.c             |  2 +-
 hw/watchdog/wdt_aspeed.c            |  2 +-
 hw/watchdog/wdt_diag288.c           |  2 +-
 hw/watchdog/wdt_i6300esb.c          |  2 +-
 hw/watchdog/wdt_ib700.c             |  2 +-
 hw/watchdog/wdt_imx2.c              |  2 +-
 410 files changed, 448 insertions(+), 448 deletions(-)

diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index b2f1b136301..a108cfe49b5 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -1030,7 +1030,7 @@ static void erst_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_REDHAT_ACPI_ERST;
     k->revision = 0x00;
     k->class_id = PCI_CLASS_OTHERS;
-    dc->reset = erst_reset;
+    device_class_set_legacy_reset(dc, erst_reset);
     dc->vmsd = &erst_vmstate;
     dc->user_creatable = true;
     dc->hotpluggable = false;
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index debe1adb846..1de3fe32611 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -633,7 +633,7 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_INTEL_82371AB_3;
     k->revision = 0x03;
     k->class_id = PCI_CLASS_BRIDGE_OTHER;
-    dc->reset = piix4_pm_reset;
+    device_class_set_legacy_reset(dc, piix4_pm_reset);
     dc->desc = "PM";
     dc->vmsd = &vmstate_acpi;
     device_class_set_props(dc, piix4_pm_properties);
diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
index 48328ef8919..598f2bdf482 100644
--- a/hw/adc/aspeed_adc.c
+++ b/hw/adc/aspeed_adc.c
@@ -297,7 +297,7 @@ static void aspeed_adc_engine_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aspeed_adc_engine_realize;
-    dc->reset = aspeed_adc_engine_reset;
+    device_class_set_legacy_reset(dc, aspeed_adc_engine_reset);
     device_class_set_props(dc, aspeed_adc_engine_properties);
     dc->desc = "Aspeed Analog-to-Digital Engine";
     dc->vmsd = &vmstate_aspeed_adc_engine;
diff --git a/hw/adc/max111x.c b/hw/adc/max111x.c
index 957d177e1ce..aa51e47245d 100644
--- a/hw/adc/max111x.c
+++ b/hw/adc/max111x.c
@@ -183,7 +183,7 @@ static void max111x_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->transfer = max111x_transfer;
-    dc->reset = max111x_reset;
+    device_class_set_legacy_reset(dc, max111x_reset);
     dc->vmsd = &vmstate_max111x;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index e9df6ea53f3..e3b21f90779 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -288,7 +288,7 @@ static void stm32f2xx_adc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = stm32f2xx_adc_reset;
+    device_class_set_legacy_reset(dc, stm32f2xx_adc_reset);
     dc->vmsd = &vmstate_stm32f2xx_adc;
 }
 
diff --git a/hw/adc/zynq-xadc.c b/hw/adc/zynq-xadc.c
index 34268319a40..26d9a7b9a5b 100644
--- a/hw/adc/zynq-xadc.c
+++ b/hw/adc/zynq-xadc.c
@@ -286,7 +286,7 @@ static void zynq_xadc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_zynq_xadc;
-    dc->reset = zynq_xadc_reset;
+    device_class_set_legacy_reset(dc, zynq_xadc_reset);
 }
 
 static const TypeInfo zynq_xadc_info = {
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 91502d157a9..255346a595a 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1700,7 +1700,7 @@ static void armsse_class_init(ObjectClass *klass, void *data)
     dc->realize = armsse_realize;
     dc->vmsd = &armsse_vmstate;
     device_class_set_props(dc, info->props);
-    dc->reset = armsse_reset;
+    device_class_set_legacy_reset(dc, armsse_reset);
     iic->check = armsse_idau_check;
     asc->info = info;
 }
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index c71b1a8db32..6915eb63c75 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -145,7 +145,7 @@ static void highbank_regs_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "Calxeda Highbank registers";
     dc->vmsd = &vmstate_highbank_regs;
-    dc->reset = highbank_regs_reset;
+    device_class_set_legacy_reset(dc, highbank_regs_reset);
 }
 
 static const TypeInfo highbank_regs_info = {
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 2020f73a576..3293f04d221 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -411,7 +411,7 @@ static void mv88w8618_pic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = mv88w8618_pic_reset;
+    device_class_set_legacy_reset(dc, mv88w8618_pic_reset);
     dc->vmsd = &mv88w8618_pic_vmsd;
 }
 
@@ -605,7 +605,7 @@ static void mv88w8618_pit_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = mv88w8618_pit_reset;
+    device_class_set_legacy_reset(dc, mv88w8618_pit_reset);
     dc->vmsd = &mv88w8618_pit_vmsd;
 }
 
@@ -1030,7 +1030,7 @@ static void musicpal_gpio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = musicpal_gpio_reset;
+    device_class_set_legacy_reset(dc, musicpal_gpio_reset);
     dc->vmsd = &musicpal_gpio_vmsd;
 }
 
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 6b2e54473b3..23e1aecc942 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2051,7 +2051,7 @@ static void pxa2xx_fir_class_init(ObjectClass *klass, void *data)
     dc->realize = pxa2xx_fir_realize;
     dc->vmsd = &pxa2xx_fir_vmsd;
     device_class_set_props(dc, pxa2xx_fir_properties);
-    dc->reset = pxa2xx_fir_reset;
+    device_class_set_legacy_reset(dc, pxa2xx_fir_reset);
 }
 
 static const TypeInfo pxa2xx_fir_info = {
@@ -2369,7 +2369,7 @@ static void pxa2xx_ssp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = pxa2xx_ssp_reset;
+    device_class_set_legacy_reset(dc, pxa2xx_ssp_reset);
     dc->vmsd = &vmstate_pxa2xx_ssp;
 }
 
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 823b4931b0a..612115ab5b7 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1342,7 +1342,7 @@ static void strongarm_uart_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "StrongARM UART controller";
-    dc->reset = strongarm_uart_reset;
+    device_class_set_legacy_reset(dc, strongarm_uart_reset);
     dc->vmsd = &vmstate_strongarm_uart_regs;
     device_class_set_props(dc, strongarm_uart_properties);
     dc->realize = strongarm_uart_realize;
@@ -1595,7 +1595,7 @@ static void strongarm_ssp_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "StrongARM SSP controller";
-    dc->reset = strongarm_ssp_reset;
+    device_class_set_legacy_reset(dc, strongarm_ssp_reset);
     dc->vmsd = &vmstate_strongarm_ssp_regs;
 }
 
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 3f0053f94de..e373f09d78d 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1344,7 +1344,7 @@ static void ac97_class_init(ObjectClass *klass, void *data)
     dc->desc = "Intel 82801AA AC97 Audio";
     dc->vmsd = &vmstate_ac97;
     device_class_set_props(dc, ac97_properties);
-    dc->reset = ac97_on_reset;
+    device_class_set_legacy_reset(dc, ac97_on_reset);
 }
 
 static const TypeInfo ac97_info = {
diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index 967caa7fcbd..8321f89c882 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -164,7 +164,7 @@ static void cs4231_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = cs_reset;
+    device_class_set_legacy_reset(dc, cs_reset);
     dc->vmsd = &vmstate_cs4231;
 }
 
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 9ef57f042d1..2d693720872 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -702,7 +702,7 @@ static void cs4231a_class_initfn (ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS (klass);
 
     dc->realize = cs4231a_realizefn;
-    dc->reset = cs4231a_reset;
+    device_class_set_legacy_reset(dc, cs4231a_reset);
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc = "Crystal Semiconductor CS4231A";
     dc->vmsd = &vmstate_cs4231a;
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 4ab61d3b9da..9a508e7b818 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -888,7 +888,7 @@ static void es1370_class_init (ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc = "ENSONIQ AudioPCI ES1370";
     dc->vmsd = &vmstate_es1370;
-    dc->reset = es1370_on_reset;
+    device_class_set_legacy_reset(dc, es1370_on_reset);
     device_class_set_props(dc, es1370_properties);
 }
 
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index b22e486fda9..b40eec96041 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -910,7 +910,7 @@ static void hda_audio_base_class_init(ObjectClass *klass, void *data)
     k->command = hda_audio_command;
     k->stream = hda_audio_stream;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
-    dc->reset = hda_audio_reset;
+    device_class_set_legacy_reset(dc, hda_audio_reset);
     dc->vmsd = &vmstate_hda_audio;
     device_class_set_props(dc, hda_audio_properties);
 }
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 9c54e60b718..6918e23c5d0 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1231,7 +1231,7 @@ static void intel_hda_class_init(ObjectClass *klass, void *data)
     k->exit = intel_hda_exit;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->class_id = PCI_CLASS_MULTIMEDIA_HD_AUDIO;
-    dc->reset = intel_hda_reset;
+    device_class_set_legacy_reset(dc, intel_hda_reset);
     dc->vmsd = &vmstate_intel_hda;
     device_class_set_props(dc, intel_hda_properties);
 }
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index cc285444bce..28f9af320de 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -292,7 +292,7 @@ static void mv88w8618_audio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = mv88w8618_audio_realize;
-    dc->reset = mv88w8618_audio_reset;
+    device_class_set_legacy_reset(dc, mv88w8618_audio_reset);
     dc->vmsd = &mv88w8618_audio_vmsd;
     dc->user_creatable = false;
 }
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index b435208c242..eb96dc2898e 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -639,7 +639,7 @@ static void pl041_device_class_init(ObjectClass *klass, void *data)
 
     dc->realize = pl041_realize;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
-    dc->reset = pl041_device_reset;
+    device_class_set_legacy_reset(dc, pl041_device_reset);
     dc->vmsd = &vmstate_pl041;
     device_class_set_props(dc, pl041_device_properties);
 }
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 4c127a1def6..85243e6313a 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -478,7 +478,7 @@ static void via_ac97_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, via_ac97_properties);
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc = "VIA AC97";
-    dc->reset = via_ac97_reset;
+    device_class_set_legacy_reset(dc, via_ac97_reset);
     /* Reason: Part of a south bridge chip */
     dc->user_creatable = false;
 }
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 796835f57b3..5ed3c18c28e 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -307,7 +307,7 @@ static void isabus_fdc_class_init(ObjectClass *klass, void *data)
     dc->desc = "virtual floppy controller";
     dc->realize = isabus_fdc_realize;
     dc->fw_name = "fdc";
-    dc->reset = fdctrl_external_reset_isa;
+    device_class_set_legacy_reset(dc, fdctrl_external_reset_isa);
     dc->vmsd = &vmstate_isa_fdc;
     adevc->build_dev_aml = build_fdc_aml;
     device_class_set_props(dc, isa_fdc_properties);
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index 035bc089752..e1ddbf3d1a6 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -181,7 +181,7 @@ static void sysbus_fdc_common_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = sysbus_fdc_realize;
-    dc->reset = fdctrl_external_reset_sysbus;
+    device_class_set_legacy_reset(dc, fdctrl_external_reset_sysbus);
     dc->vmsd = &vmstate_sysbus_fdc;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 0b94af3653f..134ee07fbcb 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1824,7 +1824,7 @@ static void m25p80_class_init(ObjectClass *klass, void *data)
     k->cs_polarity = SSI_CS_LOW;
     dc->vmsd = &vmstate_m25p80;
     device_class_set_props(dc, m25p80_properties);
-    dc->reset = m25p80_reset;
+    device_class_set_legacy_reset(dc, m25p80_reset);
     mc->pi = data;
 }
 
diff --git a/hw/block/nand.c b/hw/block/nand.c
index e2433c25bdc..ac0a5d2b42e 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -457,7 +457,7 @@ static void nand_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = nand_realize;
-    dc->reset = nand_reset;
+    device_class_set_legacy_reset(dc, nand_reset);
     dc->vmsd = &vmstate_nand;
     device_class_set_props(dc, nand_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index d8a6944027a..a7c215d2040 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -846,7 +846,7 @@ static void onenand_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = onenand_realize;
-    dc->reset = onenand_system_reset;
+    device_class_set_legacy_reset(dc, onenand_system_reset);
     device_class_set_props(dc, onenand_properties);
 }
 
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 2f3d1dd509c..7b6ec644426 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -940,7 +940,7 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = pflash_cfi01_system_reset;
+    device_class_set_legacy_reset(dc, pflash_cfi01_system_reset);
     dc->realize = pflash_cfi01_realize;
     device_class_set_props(dc, pflash_cfi01_properties);
     dc->vmsd = &vmstate_pflash;
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 2314142373f..8393f261b8d 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -974,7 +974,7 @@ static void pflash_cfi02_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pflash_cfi02_realize;
-    dc->reset = pflash_cfi02_reset;
+    device_class_set_legacy_reset(dc, pflash_cfi02_reset);
     dc->unrealize = pflash_cfi02_unrealize;
     device_class_set_props(dc, pflash_cfi02_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/block/swim.c b/hw/block/swim.c
index 44761c11cbc..64992eb72e8 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -556,7 +556,7 @@ static void sysbus_swim_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = sysbus_swim_realize;
-    dc->reset = sysbus_swim_reset;
+    device_class_set_legacy_reset(dc, sysbus_swim_reset);
     dc->vmsd = &vmstate_sysbus_swim;
 }
 
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index 5bcf9db0b78..24d26ad7a17 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -300,7 +300,7 @@ static void avr_usart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = avr_usart_reset;
+    device_class_set_legacy_reset(dc, avr_usart_reset);
     device_class_set_props(dc, avr_usart_properties);
     dc->realize = avr_usart_realize;
 }
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index d07cca1bd42..467e40b715f 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -389,7 +389,7 @@ static void cmsdk_apb_uart_class_init(ObjectClass *klass, void *data)
 
     dc->realize = cmsdk_apb_uart_realize;
     dc->vmsd = &cmsdk_apb_uart_vmstate;
-    dc->reset = cmsdk_apb_uart_reset;
+    device_class_set_legacy_reset(dc, cmsdk_apb_uart_reset);
     device_class_set_props(dc, cmsdk_apb_uart_properties);
 }
 
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index ef2d7627262..5b04abec1d6 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -182,7 +182,7 @@ static void digic_uart_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = digic_uart_realize;
-    dc->reset = digic_uart_reset;
+    device_class_set_legacy_reset(dc, digic_uart_reset);
     dc->vmsd = &vmstate_digic_uart;
     device_class_set_props(dc, digic_uart_properties);
 }
diff --git a/hw/char/escc.c b/hw/char/escc.c
index d450d70eda1..b08819f23c8 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -1062,7 +1062,7 @@ static void escc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = escc_reset;
+    device_class_set_legacy_reset(dc, escc_reset);
     dc->realize = escc_realize;
     dc->vmsd = &vmstate_escc;
     device_class_set_props(dc, escc_properties);
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index 8d6422dae41..97fa971aabc 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -246,7 +246,7 @@ static void etraxfs_ser_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = etraxfs_ser_reset;
+    device_class_set_legacy_reset(dc, etraxfs_ser_reset);
     device_class_set_props(dc, etraxfs_ser_properties);
     dc->realize = etraxfs_ser_realize;
 }
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 8cdd42e54fd..d9e732f98b1 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -717,7 +717,7 @@ static void exynos4210_uart_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = exynos4210_uart_realize;
-    dc->reset = exynos4210_uart_reset;
+    device_class_set_legacy_reset(dc, exynos4210_uart_reset);
     device_class_set_props(dc, exynos4210_uart_properties);
     dc->vmsd = &vmstate_exynos4210_uart;
 }
diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index c2e1f6537f7..d1917b83d88 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -262,7 +262,7 @@ static void goldfish_tty_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     device_class_set_props(dc, goldfish_tty_properties);
-    dc->reset = goldfish_tty_reset;
+    device_class_set_legacy_reset(dc, goldfish_tty_reset);
     dc->realize = goldfish_tty_realize;
     dc->unrealize = goldfish_tty_unrealize;
     dc->vmsd = &vmstate_goldfish_tty;
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 515b65bc070..d0032b4d2a8 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -287,7 +287,7 @@ static void grlib_apbuart_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = grlib_apbuart_realize;
-    dc->reset = grlib_apbuart_reset;
+    device_class_set_legacy_reset(dc, grlib_apbuart_reset);
     device_class_set_props(dc, grlib_apbuart_properties);
 }
 
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index 63aae6dc2c7..589177f85b9 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -547,7 +547,7 @@ static void ibex_uart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = ibex_uart_reset;
+    device_class_set_legacy_reset(dc, ibex_uart_reset);
     dc->realize = ibex_uart_realize;
     dc->vmsd = &vmstate_ibex_uart;
     device_class_set_props(dc, ibex_uart_properties);
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index ba37be6faab..22c9080b1c7 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -449,7 +449,7 @@ static void imx_serial_class_init(ObjectClass *klass, void *data)
 
     dc->realize = imx_serial_realize;
     dc->vmsd = &vmstate_imx_serial;
-    dc->reset = imx_serial_reset_at_boot;
+    device_class_set_legacy_reset(dc, imx_serial_reset_at_boot);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     dc->desc = "i.MX series UART";
     device_class_set_props(dc, imx_serial_properties);
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index f9cbc9bdc42..ad15e28944f 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -322,7 +322,7 @@ static void mcf_uart_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = mcf_uart_realize;
-    dc->reset = mcf_uart_reset;
+    device_class_set_legacy_reset(dc, mcf_uart_reset);
     device_class_set_props(dc, mcf_uart_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
diff --git a/hw/char/mchp_pfsoc_mmuart.c b/hw/char/mchp_pfsoc_mmuart.c
index e7908bbfb5d..3c3224c05d9 100644
--- a/hw/char/mchp_pfsoc_mmuart.c
+++ b/hw/char/mchp_pfsoc_mmuart.c
@@ -126,7 +126,7 @@ static void mchp_pfsoc_mmuart_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = mchp_pfsoc_mmuart_realize;
-    dc->reset = mchp_pfsoc_mmuart_reset;
+    device_class_set_legacy_reset(dc, mchp_pfsoc_mmuart_reset);
     dc->vmsd = &mchp_pfsoc_mmuart_vmstate;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index c2cd6bb5e71..04da3f8d973 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -313,7 +313,7 @@ static void nrf51_uart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = nrf51_uart_reset;
+    device_class_set_legacy_reset(dc, nrf51_uart_reset);
     dc->realize = nrf51_uart_realize;
     device_class_set_props(dc, nrf51_uart_properties);
     dc->vmsd = &nrf51_uart_vmstate;
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index f8078aa216d..615fe3a5678 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -629,7 +629,7 @@ static void pl011_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = pl011_realize;
-    dc->reset = pl011_reset;
+    device_class_set_legacy_reset(dc, pl011_reset);
     dc->vmsd = &vmstate_pl011;
     device_class_set_props(dc, pl011_properties);
 }
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
index 5cb733545c4..7ce0408b0c2 100644
--- a/hw/char/renesas_sci.c
+++ b/hw/char/renesas_sci.c
@@ -331,7 +331,7 @@ static void rsci_class_init(ObjectClass *klass, void *data)
 
     dc->realize = rsci_realize;
     dc->vmsd = &vmstate_rsci;
-    dc->reset = rsci_reset;
+    device_class_set_legacy_reset(dc, rsci_reset);
     device_class_set_props(dc, rsci_properties);
 }
 
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 7719f438f68..4fe1c4d2890 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -346,7 +346,7 @@ static void console_class_init(ObjectClass *klass, void *data)
     SCLPEventClass *ec = SCLP_EVENT_CLASS(klass);
 
     device_class_set_props(dc, console_properties);
-    dc->reset = console_reset;
+    device_class_set_legacy_reset(dc, console_reset);
     dc->vmsd = &vmstate_sclplmconsole;
     ec->init = console_init;
     ec->get_send_mask = send_mask;
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 5d630b04bb9..e6d49e819ee 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -262,7 +262,7 @@ static void console_class_init(ObjectClass *klass, void *data)
     SCLPEventClass *ec = SCLP_EVENT_CLASS(klass);
 
     device_class_set_props(dc, console_properties);
-    dc->reset = console_reset;
+    device_class_set_legacy_reset(dc, console_reset);
     dc->vmsd = &vmstate_sclpconsole;
     ec->init = console_init;
     ec->get_send_mask = send_mask;
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 355886ee3a1..429b2562aa3 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -459,7 +459,7 @@ static void sh_serial_class_init(ObjectClass *oc, void *data)
 
     device_class_set_props(dc, sh_serial_properties);
     dc->realize = sh_serial_realize;
-    dc->reset = sh_serial_reset;
+    device_class_set_legacy_reset(dc, sh_serial_reset);
     /* Reason: part of SuperH CPU/SoC, needs to be wired up */
     dc->user_creatable = false;
 }
diff --git a/hw/char/shakti_uart.c b/hw/char/shakti_uart.c
index 98b142c7df8..4a71953c9a7 100644
--- a/hw/char/shakti_uart.c
+++ b/hw/char/shakti_uart.c
@@ -165,7 +165,7 @@ static Property shakti_uart_properties[] = {
 static void shakti_uart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    dc->reset = shakti_uart_reset;
+    device_class_set_legacy_reset(dc, shakti_uart_reset);
     dc->realize = shakti_uart_realize;
     device_class_set_props(dc, shakti_uart_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 8753afeb2b8..17b5b1f15f7 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -228,7 +228,7 @@ static void stm32f2xx_usart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = stm32f2xx_usart_reset;
+    device_class_set_legacy_reset(dc, stm32f2xx_usart_reset);
     device_class_set_props(dc, stm32f2xx_usart_properties);
     dc->realize = stm32f2xx_usart_realize;
 }
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 180bb97202c..f325084f8b9 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -234,7 +234,7 @@ static void xilinx_uartlite_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = xilinx_uartlite_reset;
+    device_class_set_legacy_reset(dc, xilinx_uartlite_reset);
     dc->realize = xilinx_uartlite_realize;
     device_class_set_props(dc, xilinx_uartlite_properties);
 }
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 13907df0266..b25468e38ac 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -124,7 +124,7 @@ static void or_irq_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = or_irq_reset;
+    device_class_set_legacy_reset(dc, or_irq_reset);
     device_class_set_props(dc, or_irq_properties);
     dc->realize = or_irq_realize;
     dc->vmsd = &vmstate_or_irq;
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 51827858ce7..17423a9f573 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -831,7 +831,7 @@ static void device_class_init(ObjectClass *class, void *data)
      *   will be registered as the parent reset method and effectively call
      *   parent reset phases.
      */
-    dc->reset = device_phases_reset;
+    device_class_set_legacy_reset(dc, device_phases_reset);
     rc->get_transitional_function = device_get_transitional_reset;
 
     object_class_property_add_bool(class, "realized",
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index ba399c62407..4f419443ab4 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -89,7 +89,7 @@ static void cswmbcci_class_init(ObjectClass *oc, void *data)
     pc->device_id = 0xa123;
     pc->revision = 0;
     dc->desc = "CXL Switch Mailbox CCI";
-    dc->reset = cswmbcci_reset;
+    device_class_set_legacy_reset(dc, cswmbcci_reset);
     device_class_set_props(dc, cxl_switch_cci_props);
 }
 
diff --git a/hw/display/artist.c b/hw/display/artist.c
index d9134532fb7..5790b7a64ed 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1491,7 +1491,7 @@ static void artist_class_init(ObjectClass *klass, void *data)
 
     dc->realize = artist_realizefn;
     dc->vmsd = &vmstate_artist;
-    dc->reset = artist_reset;
+    device_class_set_legacy_reset(dc, artist_reset);
     device_class_set_props(dc, artist_properties);
 }
 
diff --git a/hw/display/ati.c b/hw/display/ati.c
index b1f94f5b767..593a25328d5 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1055,7 +1055,7 @@ static void ati_vga_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    dc->reset = ati_vga_reset;
+    device_class_set_legacy_reset(dc, ati_vga_reset);
     device_class_set_props(dc, ati_vga_properties);
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 650db3da82c..7005d5bfeae 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -449,7 +449,7 @@ static void bcm2835_fb_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, bcm2835_fb_props);
     dc->realize = bcm2835_fb_realize;
-    dc->reset = bcm2835_fb_reset;
+    device_class_set_legacy_reset(dc, bcm2835_fb_reset);
     dc->vmsd = &vmstate_bcm2835_fb;
 }
 
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index b271faaa484..95f8f98b993 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -374,7 +374,7 @@ static void cg3_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = cg3_realizefn;
-    dc->reset = cg3_reset;
+    device_class_set_legacy_reset(dc, cg3_reset);
     dc->vmsd = &vmstate_cg3;
     device_class_set_props(dc, cg3_properties);
 }
diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
index aab1b1a2d7f..108faf7887b 100644
--- a/hw/display/dpcd.c
+++ b/hw/display/dpcd.c
@@ -145,7 +145,7 @@ static void dpcd_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->reset = dpcd_reset;
+    device_class_set_legacy_reset(dc, dpcd_reset);
     dc->vmsd = &vmstate_dpcd;
 }
 
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 5712558e13d..f3d82498bfc 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1964,7 +1964,7 @@ static void exynos4210_fimd_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &exynos4210_fimd_vmstate;
-    dc->reset = exynos4210_fimd_reset;
+    device_class_set_legacy_reset(dc, exynos4210_fimd_reset);
     dc->realize = exynos4210_fimd_realize;
     device_class_set_props(dc, exynos4210_fimd_properties);
 }
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index e08ec3f8de4..fa2f1849085 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -534,7 +534,7 @@ static void g364fb_sysbus_class_init(ObjectClass *klass, void *data)
     dc->realize = g364fb_sysbus_realize;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->desc = "G364 framebuffer";
-    dc->reset = g364fb_sysbus_reset;
+    device_class_set_legacy_reset(dc, g364fb_sysbus_reset);
     dc->vmsd = &vmstate_g364fb_sysbus;
     device_class_set_props(dc, g364fb_sysbus_properties);
 }
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
index 3f9d1e1f6fe..465b00355e1 100644
--- a/hw/display/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -105,7 +105,7 @@ static void i2c_ddc_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
 
-    dc->reset = i2c_ddc_reset;
+    device_class_set_legacy_reset(dc, i2c_ddc_reset);
     dc->vmsd = &vmstate_i2c_ddc;
     device_class_set_props(dc, i2c_ddc_properties);
     isc->event = i2c_ddc_event;
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index 534f15dcfd4..1448488d063 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -300,7 +300,7 @@ static void jazz_led_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "Jazz LED display",
     dc->vmsd = &vmstate_jazz_led;
-    dc->reset = jazz_led_reset;
+    device_class_set_legacy_reset(dc, jazz_led_reset);
     dc->realize = jazz_led_realize;
 }
 
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 1ace341a0ff..a5b4a499f3e 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -802,7 +802,7 @@ static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
 
     dc->realize = macfb_sysbus_realize;
     dc->desc = "SysBus Macintosh framebuffer";
-    dc->reset = macfb_sysbus_reset;
+    device_class_set_legacy_reset(dc, macfb_sysbus_reset);
     dc->vmsd = &vmstate_macfb_sysbus;
     device_class_set_props(dc, macfb_sysbus_properties);
 }
@@ -817,7 +817,7 @@ static void macfb_nubus_class_init(ObjectClass *klass, void *data)
     device_class_set_parent_unrealize(dc, macfb_nubus_unrealize,
                                       &ndc->parent_unrealize);
     dc->desc = "Nubus Macintosh framebuffer";
-    dc->reset = macfb_nubus_reset;
+    device_class_set_legacy_reset(dc, macfb_nubus_reset);
     dc->vmsd = &vmstate_macfb_nubus;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     device_class_set_props(dc, macfb_nubus_properties);
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 7178dec85d9..3c2b5182ca0 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2486,7 +2486,7 @@ static void qxl_pci_class_init(ObjectClass *klass, void *data)
     k->vendor_id = REDHAT_PCI_VENDOR_ID;
     k->device_id = QXL_DEVICE_ID_STABLE;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
-    dc->reset = qxl_reset_handler;
+    device_class_set_legacy_reset(dc, qxl_reset_handler);
     dc->vmsd = &qxl_vmstate;
     device_class_set_props(dc, qxl_properties);
 }
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index 60c3f785498..16f8cb487cd 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -175,7 +175,7 @@ static void sii9022_class_init(ObjectClass *klass, void *data)
     k->event = sii9022_event;
     k->recv = sii9022_rx;
     k->send = sii9022_tx;
-    dc->reset = sii9022_reset;
+    device_class_set_legacy_reset(dc, sii9022_reset);
     dc->realize = sii9022_realize;
     dc->vmsd = &vmstate_sii9022;
 }
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 26dc8170d89..73e80d67de6 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -2086,7 +2086,7 @@ static void sm501_sysbus_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->desc = "SM501 Multimedia Companion";
     device_class_set_props(dc, sm501_sysbus_properties);
-    dc->reset = sm501_reset_sysbus;
+    device_class_set_legacy_reset(dc, sm501_reset_sysbus);
     dc->vmsd = &vmstate_sm501_sysbus;
 }
 
@@ -2181,7 +2181,7 @@ static void sm501_pci_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->desc = "SM501 Display Controller";
     device_class_set_props(dc, sm501_pci_properties);
-    dc->reset = sm501_reset_pci;
+    device_class_set_legacy_reset(dc, sm501_reset_pci);
     dc->hotpluggable = false;
     dc->vmsd = &vmstate_sm501_pci;
 }
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 99507e76388..f000288fcd3 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -892,7 +892,7 @@ static void tcx_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = tcx_realizefn;
-    dc->reset = tcx_reset;
+    device_class_set_legacy_reset(dc, tcx_reset);
     dc->vmsd = &vmstate_tcx;
     device_class_set_props(dc, tcx_properties);
 }
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index c096ec93e52..c0256326350 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -98,7 +98,7 @@ static void vga_isa_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = vga_isa_realizefn;
-    dc->reset = vga_isa_reset;
+    device_class_set_legacy_reset(dc, vga_isa_reset);
     dc->vmsd = &vmstate_vga_common;
     device_class_set_props(dc, vga_isa_properties);
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
diff --git a/hw/display/vga-mmio.c b/hw/display/vga-mmio.c
index cd2c46776dc..be33204517e 100644
--- a/hw/display/vga-mmio.c
+++ b/hw/display/vga-mmio.c
@@ -122,7 +122,7 @@ static void vga_mmio_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = vga_mmio_realizefn;
-    dc->reset = vga_mmio_reset;
+    device_class_set_legacy_reset(dc, vga_mmio_reset);
     dc->vmsd = &vmstate_vga_common;
     device_class_set_props(dc, vga_mmio_properties);
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 2d8adce5da6..6b51019966e 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -403,7 +403,7 @@ static void secondary_class_init(ObjectClass *klass, void *data)
     k->exit = pci_secondary_vga_exit;
     k->class_id = PCI_CLASS_DISPLAY_OTHER;
     device_class_set_props(dc, secondary_pci_properties);
-    dc->reset = pci_secondary_vga_reset;
+    device_class_set_legacy_reset(dc, pci_secondary_vga_reset);
 }
 
 static const TypeInfo vga_info = {
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 3db3ff98f76..f2d72c3fc7c 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1352,7 +1352,7 @@ static void vmsvga_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_DISPLAY_VGA;
     k->subsystem_vendor_id = PCI_VENDOR_ID_VMWARE;
     k->subsystem_id = SVGA_PCI_DEVICE_ID;
-    dc->reset = vmsvga_reset;
+    device_class_set_legacy_reset(dc, vmsvga_reset);
     dc->vmsd = &vmstate_vmware_vga;
     device_class_set_props(dc, vga_vmware_properties);
     dc->hotpluggable = false;
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index c42fc388dc7..6ab2335499d 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1398,7 +1398,7 @@ static void xlnx_dp_class_init(ObjectClass *oc, void *data)
 
     dc->realize = xlnx_dp_realize;
     dc->vmsd = &vmstate_dp;
-    dc->reset = xlnx_dp_reset;
+    device_class_set_legacy_reset(dc, xlnx_dp_reset);
     device_class_set_props(dc, xlnx_dp_device_properties);
 }
 
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 9bda45072b6..9b2fca2c7c1 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -390,7 +390,7 @@ static void bcm2835_dma_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = bcm2835_dma_realize;
-    dc->reset = bcm2835_dma_reset;
+    device_class_set_legacy_reset(dc, bcm2835_dma_reset);
     dc->vmsd = &vmstate_bcm2835_dma;
 }
 
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 24a54ca272d..3e6700e53b0 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -599,7 +599,7 @@ static void i8257_class_init(ObjectClass *klass, void *data)
     IsaDmaClass *idc = ISADMA_CLASS(klass);
 
     dc->realize = i8257_realize;
-    dc->reset = i8257_reset;
+    device_class_set_legacy_reset(dc, i8257_reset);
     dc->vmsd = &vmstate_i8257;
     device_class_set_props(dc, i8257_properties);
 
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 1e49c22e933..8e76f88a693 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -421,7 +421,7 @@ static void pl080_class_init(ObjectClass *oc, void *data)
     dc->vmsd = &vmstate_pl080;
     dc->realize = pl080_realize;
     device_class_set_props(dc, pl080_properties);
-    dc->reset = pl080_reset;
+    device_class_set_legacy_reset(dc, pl080_reset);
 }
 
 static const TypeInfo pl080_info = {
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 5f89295af3a..0668caed7c2 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -1678,7 +1678,7 @@ static void pl330_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pl330_realize;
-    dc->reset = pl330_reset;
+    device_class_set_legacy_reset(dc, pl330_reset);
     device_class_set_props(dc, pl330_properties);
     dc->vmsd = &vmstate_pl330;
 }
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 915284194fe..5bf54347ed4 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -707,7 +707,7 @@ static void rc4030_class_init(ObjectClass *klass, void *class_data)
 
     dc->realize = rc4030_realize;
     dc->unrealize = rc4030_unrealize;
-    dc->reset = rc4030_reset;
+    device_class_set_legacy_reset(dc, rc4030_reset);
     dc->vmsd = &vmstate_rc4030;
 }
 
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 80196419427..9fdba16603e 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -278,7 +278,7 @@ static void sparc32_dma_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = sparc32_dma_device_reset;
+    device_class_set_legacy_reset(dc, sparc32_dma_device_reset);
     dc->vmsd = &vmstate_sparc32_dma_device;
 }
 
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 7707634253a..73a480bfbf8 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -627,7 +627,7 @@ static void axidma_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = xilinx_axidma_realize;
-    dc->reset = xilinx_axidma_reset;
+    device_class_set_legacy_reset(dc, xilinx_axidma_reset);
     device_class_set_props(dc, axidma_properties);
 }
 
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 670c9568669..46f50631ff2 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -821,7 +821,7 @@ static void zdma_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = zdma_reset;
+    device_class_set_legacy_reset(dc, zdma_reset);
     dc->realize = zdma_realize;
     device_class_set_props(dc, zdma_props);
     dc->vmsd = &vmstate_zdma;
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index e901f68ff34..b8544d07314 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -384,7 +384,7 @@ static void xlnx_zynq_devcfg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = xlnx_zynq_devcfg_reset;
+    device_class_set_legacy_reset(dc, xlnx_zynq_devcfg_reset);
     dc->vmsd = &vmstate_xlnx_zynq_devcfg;
 }
 
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index ae307482f22..43738c43503 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -719,7 +719,7 @@ static void xlnx_csu_dma_class_init(ObjectClass *klass, void *data)
     StreamSinkClass *ssc = STREAM_SINK_CLASS(klass);
     XlnxCSUDMAClass *xcdc = XLNX_CSU_DMA_CLASS(klass);
 
-    dc->reset = xlnx_csu_dma_reset;
+    device_class_set_legacy_reset(dc, xlnx_csu_dma_reset);
     dc->realize = xlnx_csu_dma_realize;
     dc->vmsd = &vmstate_xlnx_csu_dma;
     device_class_set_props(dc, xlnx_csu_dma_properties);
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index a685bd28bb8..2657808d379 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -598,7 +598,7 @@ static void xlnx_dpdma_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->vmsd = &vmstate_xlnx_dpdma;
-    dc->reset = xlnx_dpdma_reset;
+    device_class_set_legacy_reset(dc, xlnx_dpdma_reset);
 }
 
 static const TypeInfo xlnx_dpdma_info = {
diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
index ea50718b6a2..0e2cc143f10 100644
--- a/hw/fsi/aspeed_apb2opb.c
+++ b/hw/fsi/aspeed_apb2opb.c
@@ -326,7 +326,7 @@ static void fsi_aspeed_apb2opb_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "ASPEED APB2OPB Bridge";
     dc->realize = fsi_aspeed_apb2opb_realize;
-    dc->reset = fsi_aspeed_apb2opb_reset;
+    device_class_set_legacy_reset(dc, fsi_aspeed_apb2opb_reset);
 }
 
 static const TypeInfo aspeed_apb2opb_info = {
diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
index a5f0598c98e..50fb1cd4672 100644
--- a/hw/fsi/fsi-master.c
+++ b/hw/fsi/fsi-master.c
@@ -151,7 +151,7 @@ static void fsi_master_class_init(ObjectClass *klass, void *data)
     dc->bus_type = TYPE_OP_BUS;
     dc->desc = "FSI Master";
     dc->realize = fsi_master_realize;
-    dc->reset = fsi_master_reset;
+    device_class_set_legacy_reset(dc, fsi_master_reset);
 }
 
 static const TypeInfo fsi_master_info = {
diff --git a/hw/fsi/fsi.c b/hw/fsi/fsi.c
index 9a5f4e616f1..83ddb17ae63 100644
--- a/hw/fsi/fsi.c
+++ b/hw/fsi/fsi.c
@@ -82,7 +82,7 @@ static void fsi_slave_class_init(ObjectClass *klass, void *data)
 
     dc->bus_type = TYPE_FSI_BUS;
     dc->desc = "FSI Slave";
-    dc->reset = fsi_slave_reset;
+    device_class_set_legacy_reset(dc, fsi_slave_reset);
 }
 
 static const TypeInfo fsi_slave_info = {
diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
index 20495f42fd9..4f87b28a228 100644
--- a/hw/fsi/lbus.c
+++ b/hw/fsi/lbus.c
@@ -97,7 +97,7 @@ static void fsi_scratchpad_class_init(ObjectClass *klass, void *data)
 
     dc->bus_type = TYPE_FSI_LBUS;
     dc->realize = fsi_scratchpad_realize;
-    dc->reset = fsi_scratchpad_reset;
+    device_class_set_legacy_reset(dc, fsi_scratchpad_reset);
 }
 
 static const TypeInfo fsi_scratchpad_info = {
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 6474bb8de5b..3e7b35cf4f5 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -1116,7 +1116,7 @@ static void aspeed_gpio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aspeed_gpio_realize;
-    dc->reset = aspeed_gpio_reset;
+    device_class_set_legacy_reset(dc, aspeed_gpio_reset);
     dc->desc = "Aspeed GPIO Controller";
     dc->vmsd = &vmstate_aspeed_gpio;
 }
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index 6bd50bb0b69..5a5f1df5e80 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -325,7 +325,7 @@ static void bcm2835_gpio_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_bcm2835_gpio;
     dc->realize = &bcm2835_gpio_realize;
-    dc->reset = &bcm2835_gpio_reset;
+    device_class_set_legacy_reset(dc, bcm2835_gpio_reset);
 }
 
 static const TypeInfo bcm2835_gpio_info = {
diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 2ddf62f6959..0a1739fc468 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -371,7 +371,7 @@ static void bcm2838_gpio_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_bcm2838_gpio;
     dc->realize = &bcm2838_gpio_realize;
-    dc->reset = &bcm2838_gpio_reset;
+    device_class_set_legacy_reset(dc, bcm2838_gpio_reset);
 }
 
 static const TypeInfo bcm2838_gpio_info = {
diff --git a/hw/gpio/gpio_key.c b/hw/gpio/gpio_key.c
index 61bb5870589..2fcab9ead60 100644
--- a/hw/gpio/gpio_key.c
+++ b/hw/gpio/gpio_key.c
@@ -91,7 +91,7 @@ static void gpio_key_class_init(ObjectClass *klass, void *data)
 
     dc->realize = gpio_key_realize;
     dc->vmsd = &vmstate_gpio_key;
-    dc->reset = &gpio_key_reset;
+    device_class_set_legacy_reset(dc, gpio_key_reset);
 }
 
 static const TypeInfo gpio_key_info = {
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index e53b00d951d..27535a577f2 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -333,7 +333,7 @@ static void imx_gpio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = imx_gpio_realize;
-    dc->reset = imx_gpio_reset;
+    device_class_set_legacy_reset(dc, imx_gpio_reset);
     device_class_set_props(dc, imx_gpio_properties);
     dc->vmsd = &vmstate_imx_gpio;
     dc->desc = "i.MX GPIO controller";
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 86315714fbd..43a92b8db97 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -198,7 +198,7 @@ static void max7310_class_init(ObjectClass *klass, void *data)
     k->event = max7310_event;
     k->recv = max7310_rx;
     k->send = max7310_tx;
-    dc->reset = max7310_reset;
+    device_class_set_legacy_reset(dc, max7310_reset);
     dc->vmsd = &vmstate_max7310;
 }
 
diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index 0b3f9e516da..63b7a5c881d 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -205,7 +205,7 @@ static void mpc8xxx_gpio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_mpc8xxx_gpio;
-    dc->reset = mpc8xxx_gpio_reset;
+    device_class_set_legacy_reset(dc, mpc8xxx_gpio_reset);
 }
 
 static const TypeInfo mpc8xxx_gpio_info = {
diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index ffc7dff7964..0eed3a3a06d 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -310,7 +310,7 @@ static void nrf51_gpio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_nrf51_gpio;
-    dc->reset = nrf51_gpio_reset;
+    device_class_set_legacy_reset(dc, nrf51_gpio_reset);
     dc->desc = "nRF51 GPIO";
 }
 
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index a3341d70f16..77c90f9a0d3 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -757,7 +757,7 @@ static void omap_gpio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = omap_gpio_realize;
-    dc->reset = omap_gpif_reset;
+    device_class_set_legacy_reset(dc, omap_gpif_reset);
     device_class_set_props(dc, omap_gpio_properties);
     /* Reason: pointer property "clk" */
     dc->user_creatable = false;
@@ -792,7 +792,7 @@ static void omap2_gpio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = omap2_gpio_realize;
-    dc->reset = omap2_gpif_reset;
+    device_class_set_legacy_reset(dc, omap2_gpif_reset);
     device_class_set_props(dc, omap2_gpio_properties);
     /* Reason: pointer properties "iclk", "fclk0", ..., "fclk5" */
     dc->user_creatable = false;
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 27d4db06809..59b233339a5 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -460,7 +460,7 @@ static void pca9552_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCA955xClass *pc = PCA955X_CLASS(oc);
 
-    dc->reset = pca9552_reset;
+    device_class_set_legacy_reset(dc, pca9552_reset);
     dc->vmsd = &pca9552_vmstate;
     pc->max_reg = PCA9552_LS3;
     pc->pin_count = 16;
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 7d10a64ba7c..68cc9e1de4d 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -305,7 +305,7 @@ static void pca9554_class_init(ObjectClass *klass, void *data)
     k->recv = pca9554_recv;
     k->send = pca9554_send;
     dc->realize = pca9554_realize;
-    dc->reset = pca9554_reset;
+    device_class_set_legacy_reset(dc, pca9554_reset);
     dc->vmsd = &pca9554_vmstate;
     device_class_set_props(dc, pca9554_properties);
 }
diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
index d37909e2ada..208efe69ea5 100644
--- a/hw/gpio/pcf8574.c
+++ b/hw/gpio/pcf8574.c
@@ -146,7 +146,7 @@ static void pcf8574_class_init(ObjectClass *klass, void *data)
     k->recv     = pcf8574_rx;
     k->send     = pcf8574_tx;
     dc->realize = pcf8574_realize;
-    dc->reset   = pcf8574_reset;
+    device_class_set_legacy_reset(dc, pcf8574_reset);
     dc->vmsd    = &vmstate_pcf8574;
 }
 
diff --git a/hw/gpio/sifive_gpio.c b/hw/gpio/sifive_gpio.c
index 995a43c7958..e85c0406a27 100644
--- a/hw/gpio/sifive_gpio.c
+++ b/hw/gpio/sifive_gpio.c
@@ -378,7 +378,7 @@ static void sifive_gpio_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, sifive_gpio_properties);
     dc->vmsd = &vmstate_sifive_gpio;
     dc->realize = sifive_gpio_realize;
-    dc->reset = sifive_gpio_reset;
+    device_class_set_legacy_reset(dc, sifive_gpio_reset);
     dc->desc = "SiFive GPIO";
 }
 
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 483dcca3083..ba94bf9f8db 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -138,7 +138,7 @@ static void synic_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = synic_realize;
-    dc->reset = synic_reset;
+    device_class_set_legacy_reset(dc, synic_reset);
     dc->user_creatable = false;
 }
 
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 490d805d298..15e0d600c7f 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2362,7 +2362,7 @@ static void vmbus_dev_class_init(ObjectClass *klass, void *data)
     kdev->bus_type = TYPE_VMBUS;
     kdev->realize = vmbus_dev_realize;
     kdev->unrealize = vmbus_dev_unrealize;
-    kdev->reset = vmbus_dev_reset;
+    device_class_set_legacy_reset(kdev, vmbus_dev_reset);
 }
 
 static void vmbus_dev_instance_init(Object *obj)
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index b52a99896c5..f1989137142 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1065,7 +1065,7 @@ static void aspeed_i2c_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &aspeed_i2c_vmstate;
-    dc->reset = aspeed_i2c_reset;
+    device_class_set_legacy_reset(dc, aspeed_i2c_reset);
     device_class_set_props(dc, aspeed_i2c_properties);
     dc->realize = aspeed_i2c_realize;
     dc->desc = "Aspeed I2C Controller";
@@ -1249,7 +1249,7 @@ static void aspeed_i2c_bus_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "Aspeed I2C Bus";
     dc->realize = aspeed_i2c_bus_realize;
-    dc->reset = aspeed_i2c_bus_reset;
+    device_class_set_legacy_reset(dc, aspeed_i2c_bus_reset);
     device_class_set_props(dc, aspeed_i2c_bus_properties);
 }
 
diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c
index 20ec46eeabc..67bfdef3b40 100644
--- a/hw/i2c/bcm2835_i2c.c
+++ b/hw/i2c/bcm2835_i2c.c
@@ -262,7 +262,7 @@ static void bcm2835_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = bcm2835_i2c_reset;
+    device_class_set_legacy_reset(dc, bcm2835_i2c_reset);
     dc->realize = bcm2835_i2c_realize;
     dc->vmsd = &vmstate_bcm2835_i2c;
 }
diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
index 9445424d5fd..b1d00096eea 100644
--- a/hw/i2c/exynos4210_i2c.c
+++ b/hw/i2c/exynos4210_i2c.c
@@ -314,7 +314,7 @@ static void exynos4210_i2c_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &exynos4210_i2c_vmstate;
-    dc->reset = exynos4210_i2c_reset;
+    device_class_set_legacy_reset(dc, exynos4210_i2c_reset);
 }
 
 static const TypeInfo exynos4210_i2c_type_info = {
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index a25676f0254..c565fd5b8ab 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -313,7 +313,7 @@ static void imx_i2c_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &imx_i2c_vmstate;
-    dc->reset = imx_i2c_reset;
+    device_class_set_legacy_reset(dc, imx_i2c_reset);
     dc->realize = imx_i2c_realize;
     dc->desc = "i.MX I2C Controller";
 }
diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
index 24d36d15b09..06fbd18a780 100644
--- a/hw/i2c/microbit_i2c.c
+++ b/hw/i2c/microbit_i2c.c
@@ -110,7 +110,7 @@ static void microbit_i2c_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &microbit_i2c_vmstate;
-    dc->reset = microbit_i2c_reset;
+    device_class_set_legacy_reset(dc, microbit_i2c_reset);
     dc->realize = microbit_i2c_realize;
     dc->desc = "Microbit I2C controller";
 }
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 06d4ce7d68d..2467d1a9aa2 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -339,7 +339,7 @@ static void mpc_i2c_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd  = &mpc_i2c_vmstate ;
-    dc->reset = mpc_i2c_reset;
+    device_class_set_legacy_reset(dc, mpc_i2c_reset);
     dc->realize = mpc_i2c_realize;
     dc->desc = "MPC I2C Controller";
 }
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index e5d205dda5a..e78505ebdd9 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -521,7 +521,7 @@ static void omap_i2c_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_props(dc, omap_i2c_properties);
-    dc->reset = omap_i2c_reset;
+    device_class_set_legacy_reset(dc, omap_i2c_reset);
     /* Reason: pointer properties "iclk", "fclk" */
     dc->user_creatable = false;
     dc->realize = omap_i2c_realize;
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index 75d50f15158..7b124a7e337 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -358,7 +358,7 @@ static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = ppc4xx_i2c_reset;
+    device_class_set_legacy_reset(dc, ppc4xx_i2c_reset);
 }
 
 static const TypeInfo ppc4xx_i2c_type_info = {
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index c42236bb139..9e62c27a1a5 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -143,7 +143,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(klass);
 
     dc->realize = smbus_eeprom_realize;
-    dc->reset = smbus_eeprom_reset;
+    device_class_set_legacy_reset(dc, smbus_eeprom_reset);
     sc->receive_byte = eeprom_receive_byte;
     sc->write_data = eeprom_write_data;
     dc->vmsd = &vmstate_smbus_eeprom;
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 87643d28917..464f0b666e6 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1628,7 +1628,7 @@ static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     X86IOMMUClass *dc_class = X86_IOMMU_DEVICE_CLASS(klass);
 
-    dc->reset = amdvi_sysbus_reset;
+    device_class_set_legacy_reset(dc, amdvi_sysbus_reset);
     dc->vmsd = &vmstate_amdvi_sysbus;
     dc->hotpluggable = false;
     dc_class->realize = amdvi_sysbus_realize;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 16d2885fcc0..67a7fd8428f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4368,7 +4368,7 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     X86IOMMUClass *x86_class = X86_IOMMU_DEVICE_CLASS(klass);
 
-    dc->reset = vtd_reset;
+    device_class_set_legacy_reset(dc, vtd_reset);
     dc->vmsd = &vtd_vmstate;
     device_class_set_props(dc, vtd_properties);
     dc->hotpluggable = false;
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index e49b9c4b565..baa4b39582a 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -303,7 +303,7 @@ static void kvm_pit_class_init(ObjectClass *klass, void *data)
                                     &kpc->parent_realize);
     k->set_channel_gate = kvm_pit_set_gate;
     k->get_channel_info = kvm_pit_get_channel_info;
-    dc->reset = kvm_pit_reset;
+    device_class_set_legacy_reset(dc, kvm_pit_reset);
     device_class_set_props(dc, kvm_pit_properties);
 }
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 3ca0e1ff036..9c2fb645fed 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -145,7 +145,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, void *data)
     PICCommonClass *k = PIC_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset     = kvm_pic_reset;
+    device_class_set_legacy_reset(dc, kvm_pic_reset);
     device_class_set_parent_realize(dc, kvm_pic_realize, &kpc->parent_realize);
     k->pre_save   = kvm_pic_get;
     k->post_load  = kvm_pic_put;
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index b96fe84eed3..2907b08164c 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -146,7 +146,7 @@ static void kvm_ioapic_class_init(ObjectClass *klass, void *data)
     k->realize   = kvm_ioapic_realize;
     k->pre_save  = kvm_ioapic_get;
     k->post_load = kvm_ioapic_put;
-    dc->reset    = kvm_ioapic_reset;
+    device_class_set_legacy_reset(dc, kvm_ioapic_reset);
     device_class_set_props(dc, kvm_ioapic_properties);
 }
 
diff --git a/hw/i386/kvm/xen_overlay.c b/hw/i386/kvm/xen_overlay.c
index c68e78ac5ce..3483a332a6b 100644
--- a/hw/i386/kvm/xen_overlay.c
+++ b/hw/i386/kvm/xen_overlay.c
@@ -155,7 +155,7 @@ static void xen_overlay_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = xen_overlay_reset;
+    device_class_set_legacy_reset(dc, xen_overlay_reset);
     dc->realize = xen_overlay_realize;
     dc->vmsd = &xen_overlay_vmstate;
 }
diff --git a/hw/i386/port92.c b/hw/i386/port92.c
index b25157f6e4b..1b03b34f1d1 100644
--- a/hw/i386/port92.c
+++ b/hw/i386/port92.c
@@ -102,7 +102,7 @@ static void port92_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = port92_realizefn;
-    dc->reset = port92_reset;
+    device_class_set_legacy_reset(dc, port92_reset);
     dc->vmsd = &vmstate_port92_isa;
     /*
      * Reason: unlike ordinary ISA devices, this one needs additional
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index f5b1db7e5fc..ef7f8b967f3 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -850,7 +850,7 @@ static void vapic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset   = vapic_reset;
+    device_class_set_legacy_reset(dc, vapic_reset);
     dc->vmsd    = &vmstate_vapic;
     dc->realize = vapic_realize;
 }
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index a8d014d09a8..76130cd46d9 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -327,7 +327,7 @@ static void vmmouse_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = vmmouse_realizefn;
-    dc->reset = vmmouse_reset;
+    device_class_set_legacy_reset(dc, vmmouse_reset);
     dc->vmsd = &vmstate_vmmouse;
     device_class_set_props(dc, vmmouse_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 708488af32d..ec0e536e852 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -595,7 +595,7 @@ static void xen_platform_class_init(ObjectClass *klass, void *data)
     k->revision = 1;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "XEN platform pci device";
-    dc->reset = platform_reset;
+    device_class_set_legacy_reset(dc, platform_reset);
     dc->vmsd = &vmstate_xen_platform;
 }
 
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index bfefad2965d..7fc2a08df2e 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1878,7 +1878,7 @@ static void sysbus_ahci_class_init(ObjectClass *klass, void *data)
     dc->realize = sysbus_ahci_realize;
     dc->vmsd = &vmstate_sysbus_ahci;
     device_class_set_props(dc, sysbus_ahci_properties);
-    dc->reset = sysbus_ahci_reset;
+    device_class_set_legacy_reset(dc, sysbus_ahci_reset);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 8cebd1b63d3..6b02fc81ec6 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -323,7 +323,7 @@ static void cmd646_ide_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    dc->reset = cmd646_reset;
+    device_class_set_legacy_reset(dc, cmd646_reset);
     dc->vmsd = &vmstate_ide_pci;
     k->realize = pci_cmd646_ide_realize;
     k->exit = pci_cmd646_ide_exitfn;
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 9b909c87f33..b311450c12d 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -176,7 +176,7 @@ static void ich_ahci_class_init(ObjectClass *klass, void *data)
     k->revision = 0x02;
     k->class_id = PCI_CLASS_STORAGE_SATA;
     dc->vmsd = &vmstate_ich9_ahci;
-    dc->reset = pci_ich9_reset;
+    device_class_set_legacy_reset(dc, pci_ich9_reset);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 934c45887cc..211ebc9ba75 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -114,7 +114,7 @@ static void isa_ide_class_initfn(ObjectClass *klass, void *data)
 
     dc->realize = isa_ide_realizefn;
     dc->fw_name = "ide";
-    dc->reset = isa_ide_reset;
+    device_class_set_legacy_reset(dc, isa_ide_reset);
     device_class_set_props(dc, isa_ide_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index e84bf2c9f65..bec2e866d76 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -476,7 +476,7 @@ static void macio_ide_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = macio_ide_realizefn;
-    dc->reset = macio_ide_reset;
+    device_class_set_legacy_reset(dc, macio_ide_reset);
     device_class_set_props(dc, macio_ide_properties);
     dc->vmsd = &vmstate_pmac;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index 3bb152b5d33..5475d599788 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -622,7 +622,7 @@ static void microdrive_class_init(ObjectClass *oc, void *data)
     pcc->io_write = md_common_write;
 
     dc->realize = microdrive_realize;
-    dc->reset = md_reset;
+    device_class_set_legacy_reset(dc, md_reset);
     dc->vmsd = &vmstate_microdrive;
 }
 
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 87362813056..53d22fb37f4 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -151,7 +151,7 @@ static void mmio_ide_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = mmio_ide_realizefn;
-    dc->reset = mmio_ide_reset;
+    device_class_set_legacy_reset(dc, mmio_ide_reset);
     device_class_set_props(dc, mmio_ide_properties);
     dc->vmsd = &vmstate_ide_mmio;
 }
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 80efc633d3c..818ff60d6f9 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -183,7 +183,7 @@ static void piix3_ide_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    dc->reset = piix_ide_reset;
+    device_class_set_legacy_reset(dc, piix_ide_reset);
     dc->vmsd = &vmstate_ide_pci;
     k->realize = pci_piix_ide_realize;
     k->exit = pci_piix_ide_exitfn;
@@ -206,7 +206,7 @@ static void piix4_ide_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    dc->reset = piix_ide_reset;
+    device_class_set_legacy_reset(dc, piix_ide_reset);
     dc->vmsd = &vmstate_ide_pci;
     k->realize = pci_piix_ide_realize;
     k->exit = pci_piix_ide_exitfn;
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index af17384ff20..ce8a1e4cba3 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -300,7 +300,7 @@ static void sii3112_pci_class_init(ObjectClass *klass, void *data)
     pd->class_id = PCI_CLASS_STORAGE_RAID;
     pd->revision = 1;
     pd->realize = sii3112_pci_realize;
-    dc->reset = sii3112_reset;
+    device_class_set_legacy_reset(dc, sii3112_reset);
     dc->desc = "SiI3112A SATA controller";
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
diff --git a/hw/ide/via.c b/hw/ide/via.c
index a32f56b0e79..c88eb6c025f 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -250,7 +250,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    dc->reset = via_ide_reset;
+    device_class_set_legacy_reset(dc, via_ide_reset);
     dc->vmsd = &vmstate_ide_pci;
     /* Reason: only works as function of VIA southbridge */
     dc->user_creatable = false;
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 758fa6d2676..3649d03ef22 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -387,7 +387,7 @@ static void adb_kbd_class_init(ObjectClass *oc, void *data)
 
     adc->devreq = adb_kbd_request;
     adc->devhasdata = adb_kbd_has_data;
-    dc->reset = adb_kbd_reset;
+    device_class_set_legacy_reset(dc, adb_kbd_reset);
     dc->vmsd = &vmstate_adb_kbd;
 }
 
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 144a0ccce71..7a8a8a90585 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -258,7 +258,7 @@ static void adb_mouse_class_init(ObjectClass *oc, void *data)
 
     adc->devreq = adb_mouse_request;
     adc->devhasdata = adb_mouse_has_data;
-    dc->reset = adb_mouse_reset;
+    device_class_set_legacy_reset(dc, adb_mouse_reset);
     dc->vmsd = &vmstate_adb_mouse;
 }
 
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index 59e5567afd5..ef65ad18b89 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -505,7 +505,7 @@ static void lm8323_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    dc->reset = lm_kbd_reset;
+    device_class_set_legacy_reset(dc, lm_kbd_reset);
     dc->realize = lm8323_realize;
     k->event = lm_i2c_event;
     k->recv = lm_i2c_rx;
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 74f10b640fd..04c1b3cbf91 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -756,7 +756,7 @@ static void i8042_mmio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = i8042_mmio_realize;
-    dc->reset = i8042_mmio_reset;
+    device_class_set_legacy_reset(dc, i8042_mmio_reset);
     dc->vmsd = &vmstate_kbd_mmio;
     device_class_set_props(dc, i8042_mmio_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
@@ -947,7 +947,7 @@ static void i8042_class_initfn(ObjectClass *klass, void *data)
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
     device_class_set_props(dc, i8042_properties);
-    dc->reset = i8042_reset;
+    device_class_set_legacy_reset(dc, i8042_reset);
     dc->realize = i8042_realizefn;
     dc->vmsd = &vmstate_kbd_isa;
     adevc->build_dev_aml = i8042_build_aml;
diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index cea559c39dd..c0f30092cd6 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -191,7 +191,7 @@ static void aw_a10_pic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = aw_a10_pic_reset;
+    device_class_set_legacy_reset(dc, aw_a10_pic_reset);
     dc->desc = "allwinner a10 pic";
     dc->vmsd = &vmstate_aw_a10_pic;
  }
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index c13cdd79943..62f3bbf203f 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -471,7 +471,7 @@ static void apic_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = apic_reset_common;
+    device_class_set_legacy_reset(dc, apic_reset_common);
     device_class_set_props(dc, apic_properties_common);
     dc->realize = apic_common_realize;
     dc->unrealize = apic_common_unrealize;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 404a445138a..98f3cf59bca 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2737,7 +2737,7 @@ static void armv7m_nvic_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd  = &vmstate_nvic;
     device_class_set_props(dc, props_nvic);
-    dc->reset = armv7m_nvic_reset;
+    device_class_set_legacy_reset(dc, armv7m_nvic_reset);
     dc->realize = armv7m_nvic_realize;
 }
 
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 7515558baba..126b711b943 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -322,7 +322,7 @@ static void aspeed_intc_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "ASPEED INTC Controller";
     dc->realize = aspeed_intc_realize;
-    dc->reset = aspeed_intc_reset;
+    device_class_set_legacy_reset(dc, aspeed_intc_reset);
     dc->vmsd = NULL;
 }
 
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index ba1d953c2cf..55fe51a6675 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -343,7 +343,7 @@ static void aspeed_vic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = aspeed_vic_realize;
-    dc->reset = aspeed_vic_reset;
+    device_class_set_legacy_reset(dc, aspeed_vic_reset);
     dc->desc = "ASPEED Interrupt Controller (New)";
     dc->vmsd = &vmstate_aspeed_vic;
 }
diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 2c2e2b1822c..4a42fcf60dd 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -223,7 +223,7 @@ static void bcm2835_ic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = bcm2835_ic_reset;
+    device_class_set_legacy_reset(dc, bcm2835_ic_reset);
     dc->vmsd = &vmstate_bcm2835_ic;
 }
 
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index 81faf032b0e..197a0e2ccf7 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -388,7 +388,7 @@ static void bcm2836_control_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = bcm2836_control_reset;
+    device_class_set_legacy_reset(dc, bcm2836_control_reset);
     dc->vmsd = &vmstate_bcm2836_control;
 }
 
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index f0d310a0ebc..afecef1e151 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -334,7 +334,7 @@ static void exynos4210_combiner_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = exynos4210_combiner_reset;
+    device_class_set_legacy_reset(dc, exynos4210_combiner_reset);
     device_class_set_props(dc, exynos4210_combiner_properties);
     dc->vmsd = &vmstate_exynos4210_combiner;
 }
diff --git a/hw/intc/goldfish_pic.c b/hw/intc/goldfish_pic.c
index 6cc1c69d267..166a3cba1ef 100644
--- a/hw/intc/goldfish_pic.c
+++ b/hw/intc/goldfish_pic.c
@@ -191,7 +191,7 @@ static void goldfish_pic_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(oc);
 
-    dc->reset = goldfish_pic_reset;
+    device_class_set_legacy_reset(dc, goldfish_pic_reset);
     dc->realize = goldfish_pic_realize;
     dc->vmsd = &vmstate_goldfish_pic;
     ic->get_statistics = goldfish_pic_get_statistics;
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index c6c51a349cc..37ac63fd804 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -386,7 +386,7 @@ static void grlib_irqmp_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = grlib_irqmp_realize;
-    dc->reset = grlib_irqmp_reset;
+    device_class_set_legacy_reset(dc, grlib_irqmp_reset);
     device_class_set_props(dc, grlib_irqmp_properties);
 }
 
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index c2946ba1ad5..729498f1dfe 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -188,7 +188,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->reset = heathrow_reset;
+    device_class_set_legacy_reset(dc, heathrow_reset);
     dc->vmsd = &vmstate_heathrow;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index bbae2d87f4b..d88b20f40b1 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -442,7 +442,7 @@ static void i8259_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_parent_realize(dc, pic_realize, &k->parent_realize);
-    dc->reset = pic_reset;
+    device_class_set_legacy_reset(dc, pic_reset);
 }
 
 static const TypeInfo i8259_info = {
diff --git a/hw/intc/imx_avic.c b/hw/intc/imx_avic.c
index aedc708bed4..e1c9ce769dc 100644
--- a/hw/intc/imx_avic.c
+++ b/hw/intc/imx_avic.c
@@ -346,7 +346,7 @@ static void imx_avic_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_imx_avic;
-    dc->reset = imx_avic_reset;
+    device_class_set_legacy_reset(dc, imx_avic_reset);
     dc->desc = "i.MX Advanced Vector Interrupt Controller";
 }
 
diff --git a/hw/intc/imx_gpcv2.c b/hw/intc/imx_gpcv2.c
index af45e5194c4..9e5cf28371f 100644
--- a/hw/intc/imx_gpcv2.c
+++ b/hw/intc/imx_gpcv2.c
@@ -106,7 +106,7 @@ static void imx_gpcv2_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = imx_gpcv2_reset;
+    device_class_set_legacy_reset(dc, imx_gpcv2_reset);
     dc->vmsd  = &vmstate_imx_gpcv2;
     dc->desc  = "i.MX GPCv2 Module";
 }
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 716ffc8bbbd..e73c8d4f070 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -493,7 +493,7 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
      * migration, otherwise first 24 gsi routes will be invalid.
      */
     k->post_load = ioapic_update_kvm_routes;
-    dc->reset = ioapic_reset_common;
+    device_class_set_legacy_reset(dc, ioapic_reset_common);
     device_class_set_props(dc, ioapic_properties);
 }
 
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 1e8e0114dc1..02dc4e6db3b 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -440,7 +440,7 @@ static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = loongarch_extioi_realize;
-    dc->reset   = loongarch_extioi_reset;
+    device_class_set_legacy_reset(dc, loongarch_extioi_reset);
     device_class_set_props(dc, extioi_properties);
     dc->vmsd = &vmstate_loongarch_extioi;
 }
diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 2d5e65abfff..b9581805910 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -442,7 +442,7 @@ static void loongarch_pch_pic_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = loongarch_pch_pic_realize;
-    dc->reset = loongarch_pch_pic_reset;
+    device_class_set_legacy_reset(dc, loongarch_pch_pic_reset);
     dc->vmsd = &vmstate_loongarch_pch_pic;
     device_class_set_props(dc, loongarch_pch_pic_properties);
 }
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index cf3beefcfe1..b4471e185a0 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -99,7 +99,7 @@ static void m68k_irqc_class_init(ObjectClass *oc, void *data)
 
     device_class_set_props(dc, m68k_irqc_properties);
     nc->nmi_monitor_handler = m68k_nmi;
-    dc->reset = m68k_irqc_reset;
+    device_class_set_legacy_reset(dc, m68k_irqc_reset);
     dc->vmsd = &vmstate_m68k_irqc;
     ic->get_statistics = m68k_irqc_get_statistics;
     ic->print_info = m68k_irqc_print_info;
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 435c47600fc..02acece8cf1 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -406,7 +406,7 @@ static void omap_intc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = omap_inth_reset;
+    device_class_set_legacy_reset(dc, omap_inth_reset);
     device_class_set_props(dc, omap_intc_properties);
     /* Reason: pointer property "clk" */
     dc->user_creatable = false;
@@ -659,7 +659,7 @@ static void omap2_intc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = omap_inth_reset;
+    device_class_set_legacy_reset(dc, omap_inth_reset);
     device_class_set_props(dc, omap2_intc_properties);
     /* Reason: pointer property "iclk", "fclk" */
     dc->user_creatable = false;
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 9792a112240..32bd880dfa5 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1620,7 +1620,7 @@ static void openpic_class_init(ObjectClass *oc, void *data)
 
     dc->realize = openpic_realize;
     device_class_set_props(dc, openpic_properties);
-    dc->reset = openpic_reset;
+    device_class_set_legacy_reset(dc, openpic_reset);
     dc->vmsd = &vmstate_openpic;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 557dd0c2bf5..838c6b9d99a 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -274,7 +274,7 @@ static void kvm_openpic_class_init(ObjectClass *oc, void *data)
 
     dc->realize = kvm_openpic_realize;
     device_class_set_props(dc, kvm_openpic_properties);
-    dc->reset = kvm_openpic_reset;
+    device_class_set_legacy_reset(dc, kvm_openpic_reset);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index d79e5d8076f..a5e2d763153 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -277,7 +277,7 @@ static void pl190_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = pl190_reset;
+    device_class_set_legacy_reset(dc, pl190_reset);
     dc->vmsd = &vmstate_pl190;
 }
 
diff --git a/hw/intc/ppc-uic.c b/hw/intc/ppc-uic.c
index 9a67f7f6511..f2a224f3aa4 100644
--- a/hw/intc/ppc-uic.c
+++ b/hw/intc/ppc-uic.c
@@ -286,7 +286,7 @@ static void ppc_uic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = ppc_uic_reset;
+    device_class_set_legacy_reset(dc, ppc_uic_reset);
     dc->realize = ppc_uic_realize;
     dc->vmsd = &ppc_uic_vmstate;
     device_class_set_props(dc, ppc_uic_properties);
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index a91a4a47e82..c3d2b8d7658 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -457,7 +457,7 @@ static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
     S390FLICStateClass *fsc = S390_FLIC_COMMON_CLASS(oc);
 
     device_class_set_props(dc, qemu_s390_flic_properties);
-    dc->reset = qemu_s390_flic_reset;
+    device_class_set_legacy_reset(dc, qemu_s390_flic_reset);
     dc->vmsd = &qemu_s390_flic_vmstate;
     fsc->register_io_adapter = qemu_s390_register_io_adapter;
     fsc->io_adapter_map = qemu_s390_io_adapter_map;
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 330f08dfdc2..7930d72390c 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -679,7 +679,7 @@ static void kvm_s390_flic_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, kvm_s390_flic_realize,
                                     &kfsc->parent_realize);
     dc->vmsd = &kvm_s390_flic_vmstate;
-    dc->reset = kvm_s390_flic_reset;
+    device_class_set_legacy_reset(dc, kvm_s390_flic_reset);
     fsc->register_io_adapter = kvm_s390_register_io_adapter;
     fsc->io_adapter_map = kvm_s390_io_adapter_map;
     fsc->add_adapter_routes = kvm_s390_add_adapter_routes;
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index e559f118052..7f43e96310a 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -444,7 +444,7 @@ static void sifive_plic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = sifive_plic_reset;
+    device_class_set_legacy_reset(dc, sifive_plic_reset);
     device_class_set_props(dc, sifive_plic_properties);
     dc->realize = sifive_plic_realize;
     dc->vmsd = &vmstate_sifive_plic;
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index d6e49d29aad..f83709a8576 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -446,7 +446,7 @@ static void slavio_intctl_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
-    dc->reset = slavio_intctl_reset;
+    device_class_set_legacy_reset(dc, slavio_intctl_reset);
     dc->vmsd = &vmstate_intctl;
 #ifdef DEBUG_IRQ_COUNT
     ic->get_statistics = slavio_intctl_get_statistics;
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index 12bd1a3fff3..48cd3ae94be 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -536,7 +536,7 @@ static void xlnx_pmu_io_intc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = xlnx_pmu_io_intc_reset;
+    device_class_set_legacy_reset(dc, xlnx_pmu_io_intc_reset);
     dc->realize = xlnx_pmu_io_intc_realize;
     dc->vmsd = &vmstate_xlnx_pmu_io_intc;
     device_class_set_props(dc, xlnx_pmu_io_intc_properties);
diff --git a/hw/intc/xlnx-zynqmp-ipi.c b/hw/intc/xlnx-zynqmp-ipi.c
index 509ee799cc2..72413772981 100644
--- a/hw/intc/xlnx-zynqmp-ipi.c
+++ b/hw/intc/xlnx-zynqmp-ipi.c
@@ -359,7 +359,7 @@ static void xlnx_zynqmp_ipi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = xlnx_zynqmp_ipi_reset;
+    device_class_set_legacy_reset(dc, xlnx_zynqmp_ipi_reset);
     dc->realize = xlnx_zynqmp_ipi_realize;
     dc->vmsd = &vmstate_zynqmp_pmu_ipi;
 }
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index bd727b2320b..552b70ecf50 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -871,7 +871,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
     AcpiDevAmlIfClass *amldevc = ACPI_DEV_AML_IF_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    dc->reset = ich9_lpc_reset;
+    device_class_set_legacy_reset(dc, ich9_lpc_reset);
     k->realize = ich9_lpc_realize;
     dc->vmsd = &vmstate_ich9_lpc;
     device_class_set_props(dc, ich9_lpc_properties);
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 64dd17b537f..f67155498de 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -338,7 +338,7 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
 
-    dc->reset = pc87312_reset;
+    device_class_set_legacy_reset(dc, pc87312_reset);
     dc->vmsd = &vmstate_pc87312;
     device_class_set_parent_realize(dc, pc87312_realize,
                                     &sc->parent_realize);
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 2d30711b178..b4a402f61b0 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -425,7 +425,7 @@ static void pci_piix_class_init(ObjectClass *klass, void *data)
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
     k->config_write = piix_write_config;
-    dc->reset       = piix_reset;
+    device_class_set_legacy_reset(dc, piix_reset);
     dc->desc        = "ISA bridge";
     dc->hotpluggable   = false;
     k->vendor_id    = PCI_VENDOR_ID_INTEL;
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 505b44c4e6b..f9da63cd3c6 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -232,7 +232,7 @@ static void via_pm_class_init(ObjectClass *klass, void *data)
     k->device_id = info->device_id;
     k->class_id = PCI_CLASS_BRIDGE_OTHER;
     k->revision = 0x40;
-    dc->reset = via_pm_reset;
+    device_class_set_legacy_reset(dc, via_pm_reset);
     /* Reason: part of VIA south bridge, does not exist stand alone */
     dc->user_creatable = false;
     dc->vmsd = &vmstate_acpi;
@@ -461,7 +461,7 @@ static void vt82c686b_superio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
 
-    dc->reset = vt82c686b_superio_reset;
+    device_class_set_legacy_reset(dc, vt82c686b_superio_reset);
     sc->serial.count = 2;
     sc->parallel.count = 1;
     sc->ide.count = 0; /* emulated by via-ide */
@@ -570,7 +570,7 @@ static void vt8231_superio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
 
-    dc->reset = vt8231_superio_reset;
+    device_class_set_legacy_reset(dc, vt8231_superio_reset);
     sc->serial.count = 1;
     sc->parallel.count = 1;
     sc->ide.count = 0; /* emulated by via-ide */
@@ -843,7 +843,7 @@ static void vt82c686b_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_VIA_82C686B_ISA;
     k->class_id = PCI_CLASS_BRIDGE_ISA;
     k->revision = 0x40;
-    dc->reset = vt82c686b_isa_reset;
+    device_class_set_legacy_reset(dc, vt82c686b_isa_reset);
     dc->desc = "ISA bridge";
     dc->vmsd = &vmstate_via;
     /* Reason: part of VIA VT82C686 southbridge, needs to be wired up */
@@ -908,7 +908,7 @@ static void vt8231_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_VIA_8231_ISA;
     k->class_id = PCI_CLASS_BRIDGE_ISA;
     k->revision = 0x10;
-    dc->reset = vt8231_isa_reset;
+    device_class_set_legacy_reset(dc, vt8231_isa_reset);
     dc->desc = "ISA bridge";
     dc->vmsd = &vmstate_via;
     /* Reason: part of VIA VT8231 southbridge, needs to be wired up */
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 183fd3cc085..7247cdbe5e2 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -614,7 +614,7 @@ static void mcf5206_mbar_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "MCF5206 system integration module";
     dc->realize = mcf5206_mbar_realize;
-    dc->reset = m5206_mbar_reset;
+    device_class_set_legacy_reset(dc, m5206_mbar_reset);
 }
 
 static const TypeInfo mcf5206_mbar_info = {
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 1d3b34e18c6..9fc30b03bae 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -189,7 +189,7 @@ static void mcf_intc_class_init(ObjectClass *oc, void *data)
 
     device_class_set_props(dc, mcf_intc_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->reset = mcf_intc_reset;
+    device_class_set_legacy_reset(dc, mcf_intc_reset);
 }
 
 static const TypeInfo mcf_intc_gate_info = {
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9f6f90d68b4..9b78767ea8e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -959,7 +959,7 @@ static void next_pc_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "NeXT Peripheral Controller";
     dc->realize = next_pc_realize;
-    dc->reset = next_pc_reset;
+    device_class_set_legacy_reset(dc, next_pc_reset);
     device_class_set_props(dc, next_pc_properties);
     dc->vmsd = &next_pc_vmstate;
 }
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 0c348c18cf2..bc67810f318 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -271,7 +271,7 @@ static void nextkbd_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     dc->vmsd = &nextkbd_vmstate;
     dc->realize = nextkbd_realize;
-    dc->reset = nextkbd_reset;
+    device_class_set_legacy_reset(dc, nextkbd_reset);
 }
 
 static const TypeInfo nextkbd_info = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d648192ab9d..235ac40aebe 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2144,7 +2144,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->desc = "CXL Memory Device (Type 3)";
-    dc->reset = ct3d_reset;
+    device_class_set_legacy_reset(dc, ct3d_reset);
     device_class_set_props(dc, ct3_props);
 
     cvc->get_lsa_size = get_lsa_size;
diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 04225dfb78d..a40d5072de8 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -134,7 +134,7 @@ static void a9_scu_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, a9_scu_properties);
     dc->vmsd = &vmstate_a9_scu;
-    dc->reset = a9_scu_reset;
+    device_class_set_legacy_reset(dc, a9_scu_reset);
     dc->realize = a9_scu_realize;
 }
 
diff --git a/hw/misc/allwinner-cpucfg.c b/hw/misc/allwinner-cpucfg.c
index 31b97809695..022f63ddf34 100644
--- a/hw/misc/allwinner-cpucfg.c
+++ b/hw/misc/allwinner-cpucfg.c
@@ -262,7 +262,7 @@ static void allwinner_cpucfg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = allwinner_cpucfg_reset;
+    device_class_set_legacy_reset(dc, allwinner_cpucfg_reset);
     dc->vmsd = &allwinner_cpucfg_vmstate;
 }
 
diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c
index cfc68522d33..92e579a9918 100644
--- a/hw/misc/allwinner-h3-ccu.c
+++ b/hw/misc/allwinner-h3-ccu.c
@@ -222,7 +222,7 @@ static void allwinner_h3_ccu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = allwinner_h3_ccu_reset;
+    device_class_set_legacy_reset(dc, allwinner_h3_ccu_reset);
     dc->vmsd = &allwinner_h3_ccu_vmstate;
 }
 
diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
index e168ffe6233..eeab0dc5d2a 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -336,7 +336,7 @@ static void allwinner_h3_dramc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = allwinner_h3_dramc_reset;
+    device_class_set_legacy_reset(dc, allwinner_h3_dramc_reset);
     dc->vmsd = &allwinner_h3_dramc_vmstate;
     dc->realize = allwinner_h3_dramc_realize;
     device_class_set_props(dc, allwinner_h3_dramc_properties);
diff --git a/hw/misc/allwinner-h3-sysctrl.c b/hw/misc/allwinner-h3-sysctrl.c
index 2d29be83e3a..40059e8cb0c 100644
--- a/hw/misc/allwinner-h3-sysctrl.c
+++ b/hw/misc/allwinner-h3-sysctrl.c
@@ -120,7 +120,7 @@ static void allwinner_h3_sysctrl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = allwinner_h3_sysctrl_reset;
+    device_class_set_legacy_reset(dc, allwinner_h3_sysctrl_reset);
     dc->vmsd = &allwinner_h3_sysctrl_vmstate;
 }
 
diff --git a/hw/misc/allwinner-r40-ccu.c b/hw/misc/allwinner-r40-ccu.c
index 33baf4429dd..005a15b2dae 100644
--- a/hw/misc/allwinner-r40-ccu.c
+++ b/hw/misc/allwinner-r40-ccu.c
@@ -189,7 +189,7 @@ static void allwinner_r40_ccu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = allwinner_r40_ccu_reset;
+    device_class_set_legacy_reset(dc, allwinner_r40_ccu_reset);
     dc->vmsd = &allwinner_r40_ccu_vmstate;
 }
 
diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index 75b0bef4fd9..3ae48900372 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -489,7 +489,7 @@ static void allwinner_r40_dramc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = allwinner_r40_dramc_reset;
+    device_class_set_legacy_reset(dc, allwinner_r40_dramc_reset);
     dc->vmsd = &allwinner_r40_dramc_vmstate;
     dc->realize = allwinner_r40_dramc_realize;
     device_class_set_props(dc, allwinner_r40_dramc_properties);
diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
index e5cd431743b..19ff17d24af 100644
--- a/hw/misc/allwinner-sid.c
+++ b/hw/misc/allwinner-sid.c
@@ -148,7 +148,7 @@ static void allwinner_sid_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = allwinner_sid_reset;
+    device_class_set_legacy_reset(dc, allwinner_sid_reset);
     dc->vmsd = &allwinner_sid_vmstate;
     device_class_set_props(dc, allwinner_sid_properties);
 }
diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
index cf10ca8ffe8..a20b0b4c5cb 100644
--- a/hw/misc/allwinner-sramc.c
+++ b/hw/misc/allwinner-sramc.c
@@ -139,7 +139,7 @@ static void allwinner_sramc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = allwinner_sramc_reset;
+    device_class_set_legacy_reset(dc, allwinner_sramc_reset);
     dc->vmsd = &allwinner_sramc_vmstate;
 }
 
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 59a48993127..5b766277d62 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -383,7 +383,7 @@ static void qdev_applesmc_class_init(ObjectClass *klass, void *data)
 
     dc->realize = applesmc_isa_realize;
     dc->unrealize = applesmc_unrealize;
-    dc->reset = qdev_applesmc_isa_reset;
+    device_class_set_legacy_reset(dc, qdev_applesmc_isa_reset);
     device_class_set_props(dc, applesmc_isa_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     adevc->build_dev_aml = build_applesmc_aml;
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index b14d0a26767..1902ebd3bca 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -184,7 +184,7 @@ static void l2x0_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_l2x0;
     device_class_set_props(dc, l2x0_properties);
-    dc->reset = l2x0_priv_reset;
+    device_class_set_legacy_reset(dc, l2x0_priv_reset);
 }
 
 static const TypeInfo l2x0_info = {
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 5108f3eda92..9c4dce350a9 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -640,7 +640,7 @@ static void arm_sysctl_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = arm_sysctl_realize;
-    dc->reset = arm_sysctl_reset;
+    device_class_set_legacy_reset(dc, arm_sysctl_reset);
     dc->vmsd = &vmstate_arm_sysctl;
     device_class_set_props(dc, arm_sysctl_properties);
 }
diff --git a/hw/misc/armsse-cpu-pwrctrl.c b/hw/misc/armsse-cpu-pwrctrl.c
index bfc51d175cb..2d3a0ac29ce 100644
--- a/hw/misc/armsse-cpu-pwrctrl.c
+++ b/hw/misc/armsse-cpu-pwrctrl.c
@@ -129,7 +129,7 @@ static void pwrctrl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = pwrctrl_reset;
+    device_class_set_legacy_reset(dc, pwrctrl_reset);
     dc->vmsd = &pwrctrl_vmstate;
 }
 
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
index 55625b2cca8..91c49108b00 100644
--- a/hw/misc/armsse-mhu.c
+++ b/hw/misc/armsse-mhu.c
@@ -180,7 +180,7 @@ static void armsse_mhu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = armsse_mhu_reset;
+    device_class_set_legacy_reset(dc, armsse_mhu_reset);
     dc->vmsd = &armsse_mhu_vmstate;
 }
 
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index c06c04ddc66..b0d6c5dac00 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -446,7 +446,7 @@ static void aspeed_hace_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aspeed_hace_realize;
-    dc->reset = aspeed_hace_reset;
+    device_class_set_legacy_reset(dc, aspeed_hace_reset);
     device_class_set_props(dc, aspeed_hace_properties);
     dc->vmsd = &vmstate_aspeed_hace;
 }
diff --git a/hw/misc/aspeed_i3c.c b/hw/misc/aspeed_i3c.c
index 827c9e522d3..371ee7dba84 100644
--- a/hw/misc/aspeed_i3c.c
+++ b/hw/misc/aspeed_i3c.c
@@ -334,7 +334,7 @@ static void aspeed_i3c_device_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "Aspeed I3C Device";
     dc->realize = aspeed_i3c_device_realize;
-    dc->reset = aspeed_i3c_device_reset;
+    device_class_set_legacy_reset(dc, aspeed_i3c_device_reset);
     device_class_set_props(dc, aspeed_i3c_device_properties);
 }
 
@@ -362,7 +362,7 @@ static void aspeed_i3c_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aspeed_i3c_realize;
-    dc->reset = aspeed_i3c_reset;
+    device_class_set_legacy_reset(dc, aspeed_i3c_reset);
     dc->desc = "Aspeed I3C Controller";
     dc->vmsd = &vmstate_aspeed_i3c;
 }
diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c
index 193f0dea591..f2d4ca6f430 100644
--- a/hw/misc/aspeed_lpc.c
+++ b/hw/misc/aspeed_lpc.c
@@ -464,7 +464,7 @@ static void aspeed_lpc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aspeed_lpc_realize;
-    dc->reset = aspeed_lpc_reset;
+    device_class_set_legacy_reset(dc, aspeed_lpc_reset);
     dc->desc = "Aspeed LPC Controller",
     dc->vmsd = &vmstate_aspeed_lpc;
     device_class_set_props(dc, aspeed_lpc_properties);
diff --git a/hw/misc/aspeed_peci.c b/hw/misc/aspeed_peci.c
index 93cc672e968..9025b35f836 100644
--- a/hw/misc/aspeed_peci.c
+++ b/hw/misc/aspeed_peci.c
@@ -135,7 +135,7 @@ static void aspeed_peci_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aspeed_peci_realize;
-    dc->reset = aspeed_peci_reset;
+    device_class_set_legacy_reset(dc, aspeed_peci_reset);
     dc->desc = "Aspeed PECI Controller";
 }
 
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 8bb1f90e4e7..f5eb2a0e379 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -147,7 +147,7 @@ static void aspeed_sbc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aspeed_sbc_realize;
-    dc->reset = aspeed_sbc_reset;
+    device_class_set_legacy_reset(dc, aspeed_sbc_reset);
     dc->vmsd = &vmstate_aspeed_sbc;
     device_class_set_props(dc, aspeed_sbc_properties);
 }
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 451e837272d..2c919349cfc 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -614,7 +614,7 @@ static void aspeed_scu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = aspeed_scu_realize;
-    dc->reset = aspeed_scu_reset;
+    device_class_set_legacy_reset(dc, aspeed_scu_reset);
     dc->desc = "ASPEED System Control Unit";
     dc->vmsd = &vmstate_aspeed_scu;
     device_class_set_props(dc, aspeed_scu_properties);
@@ -831,7 +831,7 @@ static void aspeed_2600_scu_class_init(ObjectClass *klass, void *data)
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
 
     dc->desc = "ASPEED 2600 System Control Unit";
-    dc->reset = aspeed_ast2600_scu_reset;
+    device_class_set_legacy_reset(dc, aspeed_ast2600_scu_reset);
     asc->resets = ast2600_a3_resets;
     asc->calc_hpll = aspeed_2600_scu_calc_hpll;
     asc->get_apb = aspeed_2600_scu_get_apb_freq;
@@ -947,7 +947,7 @@ static void aspeed_2700_scu_class_init(ObjectClass *klass, void *data)
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
 
     dc->desc = "ASPEED 2700 System Control Unit";
-    dc->reset = aspeed_ast2700_scu_reset;
+    device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);
     asc->resets = ast2700_a0_resets;
     asc->calc_hpll = aspeed_2600_scu_calc_hpll;
     asc->get_apb = aspeed_2700_scu_get_apb_freq;
@@ -1061,7 +1061,7 @@ static void aspeed_2700_scuio_class_init(ObjectClass *klass, void *data)
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
 
     dc->desc = "ASPEED 2700 System Control Unit I/O";
-    dc->reset = aspeed_ast2700_scu_reset;
+    device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);
     asc->resets = ast2700_a0_resets_io;
     asc->calc_hpll = aspeed_2600_scu_calc_hpll;
     asc->get_apb = aspeed_2700_scuio_get_apb_freq;
@@ -1119,7 +1119,7 @@ static void aspeed_1030_scu_class_init(ObjectClass *klass, void *data)
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
 
     dc->desc = "ASPEED 1030 System Control Unit";
-    dc->reset = aspeed_ast1030_scu_reset;
+    device_class_set_legacy_reset(dc, aspeed_ast1030_scu_reset);
     asc->resets = ast1030_a1_resets;
     asc->calc_hpll = aspeed_2600_scu_calc_hpll;
     asc->get_apb = aspeed_1030_scu_get_apb_freq;
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index ebf139cb5c9..4bc9faf691d 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -304,7 +304,7 @@ static void aspeed_sdmc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = aspeed_sdmc_realize;
-    dc->reset = aspeed_sdmc_reset;
+    device_class_set_legacy_reset(dc, aspeed_sdmc_reset);
     dc->desc = "ASPEED SDRAM Memory Controller";
     dc->vmsd = &vmstate_aspeed_sdmc;
     device_class_set_props(dc, aspeed_sdmc_properties);
@@ -677,7 +677,7 @@ static void aspeed_2700_sdmc_class_init(ObjectClass *klass, void *data)
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
 
     dc->desc = "ASPEED 2700 SDRAM Memory Controller";
-    dc->reset = aspeed_2700_sdmc_reset;
+    device_class_set_legacy_reset(dc, aspeed_2700_sdmc_reset);
 
     asc->is_bus64bit = true;
     asc->max_ram_size = 8 * GiB;
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index 76ab8467ddb..1dd32f72f45 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -222,7 +222,7 @@ static void aspeed_xdma_class_init(ObjectClass *classp, void *data)
     DeviceClass *dc = DEVICE_CLASS(classp);
 
     dc->realize = aspeed_xdma_realize;
-    dc->reset = aspeed_xdma_reset;
+    device_class_set_legacy_reset(dc, aspeed_xdma_reset);
     dc->vmsd = &aspeed_xdma_vmstate;
 }
 
diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
index a5412f2cfe6..ac7b96f53e3 100644
--- a/hw/misc/avr_power.c
+++ b/hw/misc/avr_power.c
@@ -94,7 +94,7 @@ static void avr_mask_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = avr_mask_reset;
+    device_class_set_legacy_reset(dc, avr_mask_reset);
 }
 
 static const TypeInfo avr_mask_info = {
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 91c8f7bd170..63e1045abf9 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -135,7 +135,7 @@ static void pll_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = pll_reset;
+    device_class_set_legacy_reset(dc, pll_reset);
     dc->vmsd = &pll_vmstate;
 }
 
@@ -239,7 +239,7 @@ static void pll_channel_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = pll_channel_reset;
+    device_class_set_legacy_reset(dc, pll_channel_reset);
     dc->vmsd = &pll_channel_vmstate;
 }
 
@@ -360,7 +360,7 @@ static void clock_mux_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = clock_mux_reset;
+    device_class_set_legacy_reset(dc, clock_mux_reset);
     dc->vmsd = &clock_mux_vmstate;
 }
 
@@ -788,7 +788,7 @@ static void cprman_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = cprman_realize;
-    dc->reset = cprman_reset;
+    device_class_set_legacy_reset(dc, cprman_reset);
     dc->vmsd = &cprman_vmstate;
     device_class_set_props(dc, cprman_properties);
 }
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 67bfc3bd719..ed6dbea1917 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -319,7 +319,7 @@ static void bcm2835_mbox_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = bcm2835_mbox_realize;
-    dc->reset = bcm2835_mbox_reset;
+    device_class_set_legacy_reset(dc, bcm2835_mbox_reset);
     dc->vmsd = &vmstate_bcm2835_mbox;
 }
 
diff --git a/hw/misc/bcm2835_mphi.c b/hw/misc/bcm2835_mphi.c
index f1eeda27862..7309cf22fc7 100644
--- a/hw/misc/bcm2835_mphi.c
+++ b/hw/misc/bcm2835_mphi.c
@@ -171,7 +171,7 @@ static void mphi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = mphi_realize;
-    dc->reset = mphi_reset;
+    device_class_set_legacy_reset(dc, mphi_reset);
     dc->vmsd = &vmstate_mphi_state;
 }
 
diff --git a/hw/misc/bcm2835_powermgt.c b/hw/misc/bcm2835_powermgt.c
index 1649da86689..d88689a0a5a 100644
--- a/hw/misc/bcm2835_powermgt.c
+++ b/hw/misc/bcm2835_powermgt.c
@@ -140,7 +140,7 @@ static void bcm2835_powermgt_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = bcm2835_powermgt_reset;
+    device_class_set_legacy_reset(dc, bcm2835_powermgt_reset);
     dc->vmsd = &vmstate_bcm2835_powermgt;
 }
 
diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index 10e741b11d1..06f40817df6 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -127,7 +127,7 @@ static void bcm2835_rng_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = bcm2835_rng_reset;
+    device_class_set_legacy_reset(dc, bcm2835_rng_reset);
     dc->vmsd = &vmstate_bcm2835_rng;
 }
 
diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
index 0c49c088a79..1c1b0671cc0 100644
--- a/hw/misc/bcm2835_thermal.c
+++ b/hw/misc/bcm2835_thermal.c
@@ -118,7 +118,7 @@ static void bcm2835_thermal_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = bcm2835_thermal_realize;
-    dc->reset = bcm2835_thermal_reset;
+    device_class_set_legacy_reset(dc, bcm2835_thermal_reset);
     dc->vmsd = &bcm2835_thermal_vmstate;
 }
 
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index 5a14a489991..0f68fbe1b64 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -335,7 +335,7 @@ static void ecc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = ecc_realize;
-    dc->reset = ecc_reset;
+    device_class_set_legacy_reset(dc, ecc_reset);
     dc->vmsd = &vmstate_ecc;
     device_class_set_props(dc, ecc_properties);
 }
diff --git a/hw/misc/exynos4210_clk.c b/hw/misc/exynos4210_clk.c
index 4566a426faa..886d10bbab5 100644
--- a/hw/misc/exynos4210_clk.c
+++ b/hw/misc/exynos4210_clk.c
@@ -145,7 +145,7 @@ static void exynos4210_clk_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = exynos4210_clk_reset;
+    device_class_set_legacy_reset(dc, exynos4210_clk_reset);
     dc->vmsd = &exynos4210_clk_vmstate;
 }
 
diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index 7e28e790d7c..9d3c2e817d2 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -502,7 +502,7 @@ static void exynos4210_pmu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = exynos4210_pmu_reset;
+    device_class_set_legacy_reset(dc, exynos4210_pmu_reset);
     dc->vmsd = &exynos4210_pmu_vmstate;
 }
 
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 674d8eece5f..a741cf176b7 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -259,7 +259,7 @@ static void exynos4210_rng_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = exynos4210_rng_reset;
+    device_class_set_legacy_reset(dc, exynos4210_rng_reset);
     dc->vmsd = &exynos4210_rng_vmstate;
 }
 
diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index faa726a86ac..9654d23f195 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -297,7 +297,7 @@ static void imx25_ccm_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
 
-    dc->reset = imx25_ccm_reset;
+    device_class_set_legacy_reset(dc, imx25_ccm_reset);
     dc->vmsd = &vmstate_imx25_ccm;
     dc->desc = "i.MX25 Clock Control Module";
 
diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index 125d4fceebb..93130b24e5e 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -324,7 +324,7 @@ static void imx31_ccm_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc  = DEVICE_CLASS(klass);
     IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
 
-    dc->reset = imx31_ccm_reset;
+    device_class_set_legacy_reset(dc, imx31_ccm_reset);
     dc->vmsd  = &vmstate_imx31_ccm;
     dc->desc  = "i.MX31 Clock Control Module";
 
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index b1def7f05b9..4b23ef19cd9 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -747,7 +747,7 @@ static void imx6_ccm_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
 
-    dc->reset = imx6_ccm_reset;
+    device_class_set_legacy_reset(dc, imx6_ccm_reset);
     dc->vmsd = &vmstate_imx6_ccm;
     dc->desc = "i.MX6 Clock Control Module";
 
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index 3766bdf5619..dc6a2b92ba4 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -291,7 +291,7 @@ static void imx6_src_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = imx6_src_realize;
-    dc->reset = imx6_src_reset;
+    device_class_set_legacy_reset(dc, imx6_src_reset);
     dc->vmsd = &vmstate_imx6_src;
     dc->desc = "i.MX6 System Reset Controller";
 }
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index 0ac49ea34b3..c836dfe494c 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -909,7 +909,7 @@ static void imx6ul_ccm_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
 
-    dc->reset = imx6ul_ccm_reset;
+    device_class_set_legacy_reset(dc, imx6ul_ccm_reset);
     dc->vmsd = &vmstate_imx6ul_ccm;
     dc->desc = "i.MX6UL Clock Control Module";
 
diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
index 88354f020ee..c3ecfd78c19 100644
--- a/hw/misc/imx7_ccm.c
+++ b/hw/misc/imx7_ccm.c
@@ -267,7 +267,7 @@ static void imx7_ccm_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
 
-    dc->reset = imx7_ccm_reset;
+    device_class_set_legacy_reset(dc, imx7_ccm_reset);
     dc->vmsd  = &vmstate_imx7_ccm;
     dc->desc  = "i.MX7 Clock Control Module";
 
@@ -297,7 +297,7 @@ static void imx7_analog_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = imx7_analog_reset;
+    device_class_set_legacy_reset(dc, imx7_analog_reset);
     dc->vmsd  = &vmstate_imx7_analog;
     dc->desc  = "i.MX7 Analog Module";
 }
diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
index edb2df215a6..070d55339e3 100644
--- a/hw/misc/imx7_snvs.c
+++ b/hw/misc/imx7_snvs.c
@@ -147,7 +147,7 @@ static void imx7_snvs_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = imx7_snvs_reset;
+    device_class_set_legacy_reset(dc, imx7_snvs_reset);
     dc->vmsd = &vmstate_imx7_snvs;
     dc->desc  = "i.MX7 Secure Non-Volatile Storage Module";
 }
diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
index d19f0450d4a..35341c68198 100644
--- a/hw/misc/imx7_src.c
+++ b/hw/misc/imx7_src.c
@@ -256,7 +256,7 @@ static void imx7_src_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = imx7_src_realize;
-    dc->reset = imx7_src_reset;
+    device_class_set_legacy_reset(dc, imx7_src_reset);
     dc->vmsd = &vmstate_imx7_src;
     dc->desc = "i.MX6 System Reset Controller";
 }
diff --git a/hw/misc/imx_rngc.c b/hw/misc/imx_rngc.c
index ab7775e0952..0cbf28db5dd 100644
--- a/hw/misc/imx_rngc.c
+++ b/hw/misc/imx_rngc.c
@@ -259,7 +259,7 @@ static void imx_rngc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = imx_rngc_realize;
-    dc->reset = imx_rngc_reset;
+    device_class_set_legacy_reset(dc, imx_rngc_reset);
     dc->desc = RNGC_NAME,
     dc->vmsd = &vmstate_imx_rngc;
 }
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index f9c45f60bf3..6e22f2aad62 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -824,7 +824,7 @@ static void iotkit_secctl_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &iotkit_secctl_vmstate;
-    dc->reset = iotkit_secctl_reset;
+    device_class_set_legacy_reset(dc, iotkit_secctl_reset);
     dc->realize = iotkit_secctl_realize;
     device_class_set_props(dc, iotkit_secctl_props);
 }
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index 45393e84ba4..c1b357e6b7f 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -850,7 +850,7 @@ static void iotkit_sysctl_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &iotkit_sysctl_vmstate;
-    dc->reset = iotkit_sysctl_reset;
+    device_class_set_legacy_reset(dc, iotkit_sysctl_reset);
     device_class_set_props(dc, iotkit_sysctl_props);
     dc->realize = iotkit_sysctl_realize;
 }
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index de49d1b8a82..5ce3fc0949a 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -991,7 +991,7 @@ static void ivshmem_common_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_IVSHMEM;
     k->class_id = PCI_CLASS_MEMORY_RAM;
     k->revision = 1;
-    dc->reset = ivshmem_reset;
+    device_class_set_legacy_reset(dc, ivshmem_reset);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "Inter-VM shared memory";
 }
diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index 970fc98b5c7..5dc209cf8d6 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -267,7 +267,7 @@ static void lasi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = lasi_reset;
+    device_class_set_legacy_reset(dc, lasi_reset);
     dc->vmsd = &vmstate_lasi;
 }
 
diff --git a/hw/misc/led.c b/hw/misc/led.c
index d9998ab8954..4bb6ce8d296 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -114,7 +114,7 @@ static void led_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "LED";
     dc->vmsd = &vmstate_led;
-    dc->reset = led_reset;
+    device_class_set_legacy_reset(dc, led_reset);
     dc->realize = led_realize;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     device_class_set_props(dc, led_properties);
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index beab0ffb13f..1db7ebf3e20 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -564,7 +564,7 @@ static void cuda_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = cuda_realize;
-    dc->reset = cuda_reset;
+    device_class_set_legacy_reset(dc, cuda_reset);
     dc->vmsd = &vmstate_cuda;
     device_class_set_props(dc, cuda_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 549563747dc..7cad62819a0 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -194,7 +194,7 @@ static void macio_gpio_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
 
-    dc->reset = macio_gpio_reset;
+    device_class_set_legacy_reset(dc, macio_gpio_reset);
     dc->vmsd = &vmstate_macio_gpio;
     nc->nmi_monitor_handler = macio_gpio_nmi;
 }
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 2a528ea08ca..74c2cb3462f 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -922,7 +922,7 @@ static void mac_dbdma_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = mac_dbdma_realize;
-    dc->reset = mac_dbdma_reset;
+    device_class_set_legacy_reset(dc, mac_dbdma_reset);
     dc->vmsd = &vmstate_dbdma;
 }
 
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 238da58eade..4b451e0af34 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -770,7 +770,7 @@ static void pmu_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = pmu_realize;
-    dc->reset = pmu_reset;
+    device_class_set_legacy_reset(dc, pmu_reset);
     dc->vmsd = &vmstate_pmu;
     device_class_set_props(dc, pmu_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 2703040f459..04256aacdc7 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -235,7 +235,7 @@ static void mips_gcr_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     device_class_set_props(dc, mips_gcr_properties);
     dc->vmsd = &vmstate_mips_gcr;
-    dc->reset = mips_gcr_reset;
+    device_class_set_legacy_reset(dc, mips_gcr_reset);
     dc->realize = mips_gcr_realize;
 }
 
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 1e8fd2e6996..2f7fb8167f6 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -174,7 +174,7 @@ static void mips_cpc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = mips_cpc_realize;
-    dc->reset = mips_cpc_reset;
+    device_class_set_legacy_reset(dc, mips_cpc_reset);
     dc->vmsd = &vmstate_mips_cpc;
     device_class_set_props(dc, mips_cpc_properties);
 }
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index f8acfb3ee26..c5214c8b30b 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -547,7 +547,7 @@ static void mips_itu_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, mips_itu_properties);
     dc->realize = mips_itu_realize;
-    dc->reset = mips_itu_reset;
+    device_class_set_legacy_reset(dc, mips_itu_reset);
 }
 
 static const TypeInfo mips_itu_info = {
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index aa1bb83e721..20359254bad 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -335,7 +335,7 @@ static void mps2_fpgaio_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &mps2_fpgaio_vmstate;
     dc->realize = mps2_fpgaio_realize;
-    dc->reset = mps2_fpgaio_reset;
+    device_class_set_legacy_reset(dc, mps2_fpgaio_reset);
     device_class_set_props(dc, mps2_fpgaio_properties);
 }
 
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 18be74157ee..d45ff77bd60 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -481,7 +481,7 @@ static void mps2_scc_class_init(ObjectClass *klass, void *data)
 
     dc->realize = mps2_scc_realize;
     dc->vmsd = &mps2_scc_vmstate;
-    dc->reset = mps2_scc_reset;
+    device_class_set_legacy_reset(dc, mps2_scc_reset);
     device_class_set_props(dc, mps2_scc_properties);
 }
 
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index f54382a816c..b8dde198c6b 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -142,7 +142,7 @@ static void msf2_sysreg_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_msf2_sysreg;
-    dc->reset = msf2_sysreg_reset;
+    device_class_set_legacy_reset(dc, msf2_sysreg_reset);
     device_class_set_props(dc, msf2_sysreg_properties);
     dc->realize = msf2_sysreg_realize;
 }
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index 2d76c457182..bf1eb0cf4a1 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -247,7 +247,7 @@ static void nrf51_rng_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, nrf51_rng_properties);
     dc->vmsd = &vmstate_rng;
-    dc->reset = nrf51_rng_reset;
+    device_class_set_legacy_reset(dc, nrf51_rng_reset);
 }
 
 static const TypeInfo nrf51_rng_info = {
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index acedd0f82bc..0b5f236a208 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -337,7 +337,7 @@ static void pci_testdev_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_OTHERS;
     dc->desc = "PCI Test Device";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->reset = qdev_pci_testdev_reset;
+    device_class_set_legacy_reset(dc, qdev_pci_testdev_reset);
     device_class_set_props(dc, pci_testdev_properties);
 }
 
diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
index 4656457d0bb..f819fc10e68 100644
--- a/hw/misc/sifive_e_aon.c
+++ b/hw/misc/sifive_e_aon.c
@@ -299,7 +299,7 @@ static void sifive_e_aon_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->reset = sifive_e_aon_reset;
+    device_class_set_legacy_reset(dc, sifive_e_aon_reset);
     device_class_set_props(dc, sifive_e_aon_properties);
 }
 
diff --git a/hw/misc/sifive_u_prci.c b/hw/misc/sifive_u_prci.c
index 5d9d446ee86..cafe6a66f4e 100644
--- a/hw/misc/sifive_u_prci.c
+++ b/hw/misc/sifive_u_prci.c
@@ -151,7 +151,7 @@ static void sifive_u_prci_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = sifive_u_prci_realize;
-    dc->reset = sifive_u_prci_reset;
+    device_class_set_legacy_reset(dc, sifive_u_prci_reset);
 }
 
 static const TypeInfo sifive_u_prci_info = {
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index 94369e4cc88..c7905942fb3 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -487,7 +487,7 @@ static void slavio_misc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = slavio_misc_reset;
+    device_class_set_legacy_reset(dc, slavio_misc_reset);
     dc->vmsd = &vmstate_misc;
 }
 
diff --git a/hw/misc/stm32f2xx_syscfg.c b/hw/misc/stm32f2xx_syscfg.c
index 19c1e864245..6c7b722274a 100644
--- a/hw/misc/stm32f2xx_syscfg.c
+++ b/hw/misc/stm32f2xx_syscfg.c
@@ -142,7 +142,7 @@ static void stm32f2xx_syscfg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = stm32f2xx_syscfg_reset;
+    device_class_set_legacy_reset(dc, stm32f2xx_syscfg_reset);
 }
 
 static const TypeInfo stm32f2xx_syscfg_info = {
diff --git a/hw/misc/stm32f4xx_exti.c b/hw/misc/stm32f4xx_exti.c
index 7bd3afcd7cc..efd996df94e 100644
--- a/hw/misc/stm32f4xx_exti.c
+++ b/hw/misc/stm32f4xx_exti.c
@@ -168,7 +168,7 @@ static void stm32f4xx_exti_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = stm32f4xx_exti_reset;
+    device_class_set_legacy_reset(dc, stm32f4xx_exti_reset);
     dc->vmsd = &vmstate_stm32f4xx_exti;
 }
 
diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
index 854fce6a952..7d0f3eb5f5b 100644
--- a/hw/misc/stm32f4xx_syscfg.c
+++ b/hw/misc/stm32f4xx_syscfg.c
@@ -151,7 +151,7 @@ static void stm32f4xx_syscfg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = stm32f4xx_syscfg_reset;
+    device_class_set_legacy_reset(dc, stm32f4xx_syscfg_reset);
     dc->vmsd = &vmstate_stm32f4xx_syscfg;
 }
 
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index 92b994919be..66a46a7b9f5 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -599,7 +599,7 @@ static void tz_mpc_class_init(ObjectClass *klass, void *data)
 
     dc->realize = tz_mpc_realize;
     dc->vmsd = &tz_mpc_vmstate;
-    dc->reset = tz_mpc_reset;
+    device_class_set_legacy_reset(dc, tz_mpc_reset);
     device_class_set_props(dc, tz_mpc_properties);
 }
 
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index de5a3126cca..82ccaa014ae 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -292,7 +292,7 @@ static void tz_msc_class_init(ObjectClass *klass, void *data)
 
     dc->realize = tz_msc_realize;
     dc->vmsd = &tz_msc_vmstate;
-    dc->reset = tz_msc_reset;
+    device_class_set_legacy_reset(dc, tz_msc_reset);
     device_class_set_props(dc, tz_msc_properties);
 }
 
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 64507787209..922dcf7f63f 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -332,7 +332,7 @@ static void tz_ppc_class_init(ObjectClass *klass, void *data)
 
     dc->realize = tz_ppc_realize;
     dc->vmsd = &tz_ppc_vmstate;
-    dc->reset = tz_ppc_reset;
+    device_class_set_legacy_reset(dc, tz_ppc_reset);
     device_class_set_props(dc, tz_ppc_properties);
 }
 
diff --git a/hw/misc/virt_ctrl.c b/hw/misc/virt_ctrl.c
index 1a6c744bac2..aa00d6c574f 100644
--- a/hw/misc/virt_ctrl.c
+++ b/hw/misc/virt_ctrl.c
@@ -129,7 +129,7 @@ static void virt_ctrl_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->reset = virt_ctrl_reset;
+    device_class_set_legacy_reset(dc, virt_ctrl_reset);
     dc->realize = virt_ctrl_realize;
     dc->vmsd = &vmstate_virt_ctrl;
 }
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 6bb82e51c15..5d281c7d268 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -495,7 +495,7 @@ static void cfu_apb_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = cfu_apb_reset;
+    device_class_set_legacy_reset(dc, cfu_apb_reset);
     dc->vmsd = &vmstate_cfu_apb;
     device_class_set_props(dc, cfu_props);
 }
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 108ae9c8535..cdae74f503d 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -881,7 +881,7 @@ static void allwinner_sun8i_emac_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = allwinner_sun8i_emac_realize;
-    dc->reset = allwinner_sun8i_emac_reset;
+    device_class_set_legacy_reset(dc, allwinner_sun8i_emac_reset);
     dc->vmsd = &vmstate_aw_emac;
     device_class_set_props(dc, allwinner_sun8i_emac_properties);
 }
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index d40ff37e994..c104c2588e4 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -521,7 +521,7 @@ static void aw_emac_class_init(ObjectClass *klass, void *data)
 
     dc->realize = aw_emac_realize;
     device_class_set_props(dc, aw_emac_properties);
-    dc->reset = aw_emac_reset;
+    device_class_set_legacy_reset(dc, aw_emac_reset);
     dc->vmsd = &vmstate_aw_emac;
 }
 
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index ec7bf562e57..44a5e65b8ff 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1809,7 +1809,7 @@ static void gem_class_init(ObjectClass *klass, void *data)
     dc->realize = gem_realize;
     device_class_set_props(dc, gem_properties);
     dc->vmsd = &vmstate_cadence_gem;
-    dc->reset = gem_reset;
+    device_class_set_legacy_reset(dc, gem_reset);
 }
 
 static const TypeInfo gem_info = {
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index bf41e6b2612..38434d3a04b 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -299,7 +299,7 @@ static void kvaser_pci_class_init(ObjectClass *klass, void *data)
     k->class_id = 0x00ff00;
     dc->desc = "Kvaser PCICANx";
     dc->vmsd = &vmstate_kvaser_pci;
-    dc->reset = kvaser_pci_reset;
+    device_class_set_legacy_reset(dc, kvaser_pci_reset);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 308b17e0c00..21659b7afb1 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -243,7 +243,7 @@ static void mioe3680_pci_class_init(ObjectClass *klass, void *data)
     dc->desc = "Mioe3680 PCICANx";
     dc->vmsd = &vmstate_mioe3680_pci;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->reset = mioe3680_pci_reset;
+    device_class_set_legacy_reset(dc, mioe3680_pci_reset);
 }
 
 static const TypeInfo mioe3680_pci_info = {
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index e4c8d93b984..af21dc6855f 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -244,7 +244,7 @@ static void pcm3680i_pci_class_init(ObjectClass *klass, void *data)
     dc->desc = "Pcm3680i PCICANx";
     dc->vmsd = &vmstate_pcm3680i_pci;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->reset = pcm3680i_pci_reset;
+    device_class_set_legacy_reset(dc, pcm3680i_pci_reset);
 }
 
 static const TypeInfo pcm3680i_pci_info = {
diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
index d8f7344ddc6..65f1f823030 100644
--- a/hw/net/can/ctucan_pci.c
+++ b/hw/net/can/ctucan_pci.c
@@ -257,7 +257,7 @@ static void ctucan_pci_class_init(ObjectClass *klass, void *data)
     dc->desc = "CTU CAN PCI";
     dc->vmsd = &vmstate_ctucan_pci;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->reset = ctucan_pci_reset;
+    device_class_set_legacy_reset(dc, ctucan_pci_reset);
 }
 
 static const TypeInfo ctucan_pci_info = {
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 5f083c21e93..b30edb83bf8 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -2088,7 +2088,7 @@ static void canfd_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = canfd_reset;
+    device_class_set_legacy_reset(dc, canfd_reset);
     dc->realize = canfd_realize;
     device_class_set_props(dc, canfd_core_properties);
     dc->vmsd = &vmstate_canfd;
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index bf0652da1b4..09d708f989d 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -946,7 +946,7 @@ static void dp8393x_class_init(ObjectClass *klass, void *data)
 
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->realize = dp8393x_realize;
-    dc->reset = dp8393x_reset;
+    device_class_set_legacy_reset(dc, dp8393x_reset);
     dc->vmsd = &vmstate_dp8393x;
     device_class_set_props(dc, dp8393x_properties);
 }
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 5faf20c782c..3ef057f1bf6 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -638,7 +638,7 @@ static void etraxfs_eth_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = etraxfs_eth_realize;
-    dc->reset = etraxfs_eth_reset;
+    device_class_set_legacy_reset(dc, etraxfs_eth_reset);
     device_class_set_props(dc, etraxfs_eth_properties);
     /* Reason: dma_out, dma_in are not user settable */
     dc->user_creatable = false;
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 00315f305d8..3fdd16ef2ee 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -425,7 +425,7 @@ static void etsec_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = etsec_realize;
-    dc->reset = etsec_reset;
+    device_class_set_legacy_reset(dc, etsec_reset);
     device_class_set_props(dc, etsec_properties);
     /* Supported by ppce500 machine */
     dc->user_creatable = true;
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 80f9cd56d53..178a11675d5 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1267,7 +1267,7 @@ static void ftgmac100_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_ftgmac100;
-    dc->reset = ftgmac100_reset;
+    device_class_set_legacy_reset(dc, ftgmac100_reset);
     device_class_set_props(dc, ftgmac100_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->realize = ftgmac100_realize;
@@ -1427,7 +1427,7 @@ static void aspeed_mii_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_aspeed_mii;
-    dc->reset = aspeed_mii_reset;
+    device_class_set_legacy_reset(dc, aspeed_mii_reset);
     dc->realize = aspeed_mii_realize;
     dc->desc = "Aspeed MII controller";
     device_class_set_props(dc, aspeed_mii_properties);
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 8c91d20d44c..f9265de18b0 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1354,7 +1354,7 @@ static void imx_eth_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd    = &vmstate_imx_eth;
-    dc->reset   = imx_eth_reset;
+    device_class_set_legacy_reset(dc, imx_eth_reset);
     device_class_set_props(dc, imx_eth_properties);
     dc->realize = imx_eth_realize;
     dc->desc    = "i.MX FEC/ENET Ethernet Controller";
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 91d81b410b5..5a49601497c 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1408,7 +1408,7 @@ static void lan9118_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = lan9118_reset;
+    device_class_set_legacy_reset(dc, lan9118_reset);
     device_class_set_props(dc, lan9118_properties);
     dc->vmsd = &vmstate_lan9118;
     dc->realize = lan9118_realize;
diff --git a/hw/net/lance.c b/hw/net/lance.c
index e1ed24c2cea..269615b4520 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -151,7 +151,7 @@ static void lance_class_init(ObjectClass *klass, void *data)
     dc->realize = lance_realize;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->fw_name = "ethernet";
-    dc->reset = lance_reset;
+    device_class_set_legacy_reset(dc, lance_reset);
     dc->vmsd = &vmstate_lance;
     device_class_set_props(dc, lance_properties);
 }
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index fcf7fae9411..183fab87126 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -170,7 +170,7 @@ static void lasi_82596_class_init(ObjectClass *klass, void *data)
     dc->realize = lasi_82596_realize;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->fw_name = "ethernet";
-    dc->reset = lasi_82596_reset;
+    device_class_set_legacy_reset(dc, lasi_82596_reset);
     dc->vmsd = &vmstate_lasi_82596;
     dc->user_creatable = false;
     device_class_set_props(dc, lasi_82596_properties);
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index e6902716bd2..2898ad22d8f 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -673,7 +673,7 @@ static void mcf_fec_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->realize = mcf_fec_realize;
     dc->desc = "MCF Fast Ethernet Controller network device";
-    dc->reset = mcf_fec_reset;
+    device_class_set_legacy_reset(dc, mcf_fec_reset);
     device_class_set_props(dc, mcf_fec_properties);
 }
 
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index df5101aed73..31bbd6fb895 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -278,7 +278,7 @@ static void mipsnet_class_init(ObjectClass *klass, void *data)
     dc->realize = mipsnet_realize;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->desc = "MIPS Simulator network device";
-    dc->reset = mipsnet_sysbus_reset;
+    device_class_set_legacy_reset(dc, mipsnet_sysbus_reset);
     dc->vmsd = &vmstate_mipsnet;
     device_class_set_props(dc, mipsnet_properties);
 }
diff --git a/hw/net/msf2-emac.c b/hw/net/msf2-emac.c
index c1fc10de2ab..d28fc6c5704 100644
--- a/hw/net/msf2-emac.c
+++ b/hw/net/msf2-emac.c
@@ -571,7 +571,7 @@ static void msf2_emac_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = msf2_emac_realize;
-    dc->reset = msf2_emac_reset;
+    device_class_set_legacy_reset(dc, msf2_emac_reset);
     dc->vmsd = &vmstate_msf2_emac;
     device_class_set_props(dc, msf2_emac_properties);
 }
diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index d1583b6f9b3..31e488d138e 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -859,7 +859,7 @@ static void npcm7xx_emc_class_init(ObjectClass *klass, void *data)
     dc->desc = "NPCM7xx EMC Controller";
     dc->realize = npcm7xx_emc_realize;
     dc->unrealize = npcm7xx_emc_unrealize;
-    dc->reset = npcm7xx_emc_reset;
+    device_class_set_legacy_reset(dc, npcm7xx_emc_reset);
     dc->vmsd = &vmstate_npcm7xx_emc;
     device_class_set_props(dc, npcm7xx_emc_properties);
 }
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 1b71e2526e3..6fa6bece61f 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -926,7 +926,7 @@ static void npcm_gmac_class_init(ObjectClass *klass, void *data)
     dc->desc = "NPCM GMAC Controller";
     dc->realize = npcm_gmac_realize;
     dc->unrealize = npcm_gmac_unrealize;
-    dc->reset = npcm_gmac_reset;
+    device_class_set_legacy_reset(dc, npcm_gmac_reset);
     dc->vmsd = &vmstate_npcm_gmac;
     device_class_set_props(dc, npcm_gmac_properties);
 }
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index f96d6ea2ccf..2c0ebda100a 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -755,7 +755,7 @@ static void open_eth_class_init(ObjectClass *klass, void *data)
     dc->realize = sysbus_open_eth_realize;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->desc = "Opencores 10/100 Mbit Ethernet";
-    dc->reset = qdev_open_eth_reset;
+    device_class_set_legacy_reset(dc, qdev_open_eth_reset);
     device_class_set_props(dc, open_eth_properties);
 }
 
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index fe1a845b2b0..6190b769169 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -269,7 +269,7 @@ static void pcnet_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_AMD_LANCE;
     k->revision = 0x10;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
-    dc->reset = pci_reset;
+    device_class_set_legacy_reset(dc, pci_reset);
     dc->vmsd = &vmstate_pci_pcnet;
     device_class_set_props(dc, pcnet_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 7ea8eb6ba55..1ab58521137 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1494,7 +1494,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_NETWORK_OTHER;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->desc = "Rocker Switch";
-    dc->reset = rocker_reset;
+    device_class_set_legacy_reset(dc, rocker_reset);
     device_class_set_props(dc, rocker_properties);
     dc->vmsd = &rocker_vmsd;
 }
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 03a204ef8ab..1b78deb14c4 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3429,7 +3429,7 @@ static void rtl8139_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_REALTEK_8139;
     k->revision = RTL8139_PCI_REVID; /* >=0x20 is for 8139C+ */
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
-    dc->reset = rtl8139_reset;
+    device_class_set_legacy_reset(dc, rtl8139_reset);
     dc->vmsd = &vmstate_rtl8139;
     device_class_set_props(dc, rtl8139_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 702d0e8e837..c5338dd49e8 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -799,7 +799,7 @@ static void smc91c111_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = smc91c111_realize;
-    dc->reset = smc91c111_reset;
+    device_class_set_legacy_reset(dc, smc91c111_reset);
     dc->vmsd = &vmstate_smc91c111;
     device_class_set_props(dc, smc91c111_properties);
 }
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index db95766e294..08e53931516 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -507,7 +507,7 @@ static void stellaris_enet_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = stellaris_enet_realize;
-    dc->reset = stellaris_enet_reset;
+    device_class_set_legacy_reset(dc, stellaris_enet_reset);
     device_class_set_props(dc, stellaris_enet_properties);
     dc->vmsd = &vmstate_stellaris_enet;
 }
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index dd1b4a13446..67087e98423 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1467,7 +1467,7 @@ static void sungem_class_init(ObjectClass *klass, void *data)
     k->revision = 0x01;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     dc->vmsd = &vmstate_sungem;
-    dc->reset = sungem_reset;
+    device_class_set_legacy_reset(dc, sungem_reset);
     device_class_set_props(dc, sungem_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index ae8452e5f9f..0e6c655a5b2 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -948,7 +948,7 @@ static void sunhme_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_SUN_HME;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     dc->vmsd = &vmstate_hme;
-    dc->reset = sunhme_reset;
+    device_class_set_legacy_reset(dc, sunhme_reset);
     device_class_set_props(dc, sunhme_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 1f2ef209775..9df3e17162f 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -1026,7 +1026,7 @@ static void tulip_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     dc->vmsd = &vmstate_pci_tulip;
     device_class_set_props(dc, tulip_properties);
-    dc->reset = tulip_qdev_reset;
+    device_class_set_legacy_reset(dc, tulip_qdev_reset);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
 
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 63a91877730..bb8583c7aba 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2512,7 +2512,7 @@ static void vmxnet3_class_init(ObjectClass *class, void *data)
     device_class_set_parent_realize(dc, vmxnet3_realize,
                                     &vc->parent_dc_realize);
     dc->desc = "VMWare Paravirtualized Ethernet v3";
-    dc->reset = vmxnet3_qdev_reset;
+    device_class_set_legacy_reset(dc, vmxnet3_qdev_reset);
     dc->vmsd = &vmstate_vmxnet3;
     device_class_set_props(dc, vmxnet3_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 05d41bd5480..faf27947b01 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -1014,7 +1014,7 @@ static void xilinx_enet_class_init(ObjectClass *klass, void *data)
 
     dc->realize = xilinx_enet_realize;
     device_class_set_props(dc, xilinx_enet_properties);
-    dc->reset = xilinx_axienet_reset;
+    device_class_set_legacy_reset(dc, xilinx_axienet_reset);
 }
 
 static void xilinx_enet_control_stream_class_init(ObjectClass *klass,
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 989afaf037f..bd812908085 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -263,7 +263,7 @@ static void xilinx_ethlite_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = xilinx_ethlite_realize;
-    dc->reset = xilinx_ethlite_reset;
+    device_class_set_legacy_reset(dc, xilinx_ethlite_reset);
     device_class_set_props(dc, xilinx_ethlite_properties);
 }
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 9f277b81d83..9e94a240540 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8845,7 +8845,7 @@ static void nvme_class_init(ObjectClass *oc, void *data)
     dc->desc = "Non-Volatile Memory Express";
     device_class_set_props(dc, nvme_props);
     dc->vmsd = &nvme_vmstate;
-    dc->reset = nvme_pci_reset;
+    device_class_set_legacy_reset(dc, nvme_pci_reset);
 }
 
 static void nvme_instance_init(Object *obj)
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 3272068663e..ec748e58e7d 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -254,7 +254,7 @@ void at24c_eeprom_class_init(ObjectClass *klass, void *data)
     k->send = &at24c_eeprom_send;
 
     device_class_set_props(dc, at24c_eeprom_props);
-    dc->reset = at24c_eeprom_reset;
+    device_class_set_legacy_reset(dc, at24c_eeprom_reset);
 }
 
 static
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index fc0263f3491..2dadfd6e1f2 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1260,7 +1260,7 @@ static void fw_cfg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = fw_cfg_reset;
+    device_class_set_legacy_reset(dc, fw_cfg_reset);
     dc->vmsd = &vmstate_fw_cfg;
 
     device_class_set_props(dc, fw_cfg_properties);
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index fe9df9fa35b..fef34e7f412 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -147,7 +147,7 @@ static void macio_nvram_class_init(ObjectClass *oc, void *data)
 
     dc->realize = macio_nvram_realizefn;
     dc->unrealize = macio_nvram_unrealizefn;
-    dc->reset = macio_nvram_reset;
+    device_class_set_legacy_reset(dc, macio_nvram_reset);
     dc->vmsd = &vmstate_macio_nvram;
     device_class_set_props(dc, macio_nvram_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index 73564f7e6ea..b1f81752a3d 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -378,7 +378,7 @@ static void nrf51_nvm_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, nrf51_nvm_properties);
     dc->vmsd = &vmstate_nvm;
     dc->realize = nrf51_nvm_realize;
-    dc->reset = nrf51_nvm_reset;
+    device_class_set_legacy_reset(dc, nrf51_nvm_reset);
 }
 
 static const TypeInfo nrf51_nvm_info = {
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 742da07a015..4b429843602 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -236,7 +236,7 @@ static void cxl_dsp_class_init(ObjectClass *oc, void *data)
     k->revision = 0;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "CXL Switch Downstream Port";
-    dc->reset = cxl_dsp_reset;
+    device_class_set_legacy_reset(dc, cxl_dsp_reset);
 }
 
 static const TypeInfo cxl_dsp_info = {
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index e51221a5f33..e3bd897b660 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -380,7 +380,7 @@ static void cxl_upstream_class_init(ObjectClass *oc, void *data)
     k->revision = 0;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "CXL Switch Upstream Port";
-    dc->reset = cxl_usp_reset;
+    device_class_set_legacy_reset(dc, cxl_usp_reset);
     device_class_set_props(dc, cxl_upstream_props);
 }
 
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index c140919cbc5..00d2fbd7cf1 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -98,7 +98,7 @@ static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
     k->realize = i82801b11_bridge_realize;
     k->config_write = pci_bridge_write_config;
     dc->vmsd = &i82801b11_bridge_dev_vmstate;
-    dc->reset = pci_bridge_reset;
+    device_class_set_legacy_reset(dc, pci_bridge_reset);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 089f91efed4..8e7f9266210 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -254,7 +254,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_REDHAT_BRIDGE;
     k->class_id = PCI_CLASS_BRIDGE_PCI;
     dc->desc = "Standard PCI Bridge";
-    dc->reset = qdev_pci_bridge_dev_reset;
+    device_class_set_legacy_reset(dc, qdev_pci_bridge_dev_reset);
     device_class_set_props(dc, pci_bridge_dev_properties);
     dc->vmsd = &pci_bridge_dev_vmstate;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 0411ad31ea4..dfaea6cbf4b 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -515,7 +515,7 @@ static void pxb_cxl_dev_class_init(ObjectClass *klass, void *data)
 
     /* Host bridges aren't hotpluggable. FIXME: spec reference */
     dc->hotpluggable = false;
-    dc->reset = pxb_cxl_dev_reset;
+    device_class_set_legacy_reset(dc, pxb_cxl_dev_reset);
 }
 
 static const TypeInfo pxb_cxl_dev_info = {
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 7646ac23975..6e8d7d9478d 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -152,7 +152,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
     k->config_write = pcie_pci_bridge_write_config;
     dc->vmsd = &pcie_pci_bridge_dev_vmstate;
     device_class_set_props(dc, pcie_pci_bridge_dev_properties);
-    dc->reset = &pcie_pci_bridge_reset;
+    device_class_set_legacy_reset(dc, pcie_pci_bridge_reset);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hc->plug = pci_bridge_dev_plug_cb;
     hc->unplug = pci_bridge_dev_unplug_cb;
diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
index 17aa0d7b216..5fe090df6cf 100644
--- a/hw/pci-bridge/simba.c
+++ b/hw/pci-bridge/simba.c
@@ -78,7 +78,7 @@ static void simba_pci_bridge_class_init(ObjectClass *klass, void *data)
     k->revision = 0x11;
     k->config_write = pci_bridge_write_config;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    dc->reset = pci_bridge_reset;
+    device_class_set_legacy_reset(dc, pci_bridge_reset);
     dc->vmsd = &vmstate_pci_device;
 }
 
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 907d5105b01..473e2dd9504 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -167,7 +167,7 @@ static void xio3130_downstream_class_init(ObjectClass *klass, void *data)
     k->revision = XIO3130_REVISION;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "TI X3130 Downstream Port of PCI Express Switch";
-    dc->reset = xio3130_downstream_reset;
+    device_class_set_legacy_reset(dc, xio3130_downstream_reset);
     dc->vmsd = &vmstate_xio3130_downstream;
     device_class_set_props(dc, xio3130_downstream_props);
 }
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 2a6cff6e033..fb1547b74ab 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -136,7 +136,7 @@ static void xio3130_upstream_class_init(ObjectClass *klass, void *data)
     k->revision = XIO3130_REVISION;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "TI X3130 Upstream Port of PCI Express Switch";
-    dc->reset = xio3130_upstream_reset;
+    device_class_set_legacy_reset(dc, xio3130_upstream_reset);
     dc->vmsd = &vmstate_xio3130_upstream;
 }
 
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index e3e589ceacc..379095b3566 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -489,7 +489,7 @@ static void elroy_pcihost_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = elroy_reset;
+    device_class_set_legacy_reset(dc, elroy_reset);
     device_class_set_props(dc, elroy_pcihost_properties);
     dc->vmsd = &vmstate_elroy;
     dc->user_creatable = false;
@@ -865,7 +865,7 @@ static void astro_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = astro_reset;
+    device_class_set_legacy_reset(dc, astro_reset);
     dc->vmsd = &vmstate_astro;
     dc->realize = astro_realize;
     /*
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index c25d50f1c6b..a8210e9bbba 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -607,7 +607,7 @@ static void designware_pcie_root_class_init(ObjectClass *klass, void *data)
     k->config_read = designware_pcie_root_config_read;
     k->config_write = designware_pcie_root_config_write;
 
-    dc->reset = pci_bridge_reset;
+    device_class_set_legacy_reset(dc, pci_bridge_reset);
     /*
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index d992c4bb69d..283fc0dc575 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -502,7 +502,7 @@ static void dino_pcihost_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = dino_pcihost_reset;
+    device_class_set_legacy_reset(dc, dino_pcihost_reset);
     dc->realize = dino_pcihost_realize;
     dc->unrealize = dino_pcihost_unrealize;
     device_class_set_props(dc, dino_pcihost_properties);
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 33607dfbec4..9b9966faeb5 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1289,7 +1289,7 @@ static void gt64120_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_props(dc, gt64120_properties);
     dc->realize = gt64120_realize;
-    dc->reset = gt64120_reset;
+    device_class_set_legacy_reset(dc, gt64120_reset);
     dc->vmsd = &vmstate_gt64120;
 }
 
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 01bd8c887fa..1036d8600d7 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -928,7 +928,7 @@ static void mv64361_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = mv64361_realize;
-    dc->reset = mv64361_reset;
+    device_class_set_legacy_reset(dc, mv64361_reset);
 }
 
 static const TypeInfo mv64361_type_info = {
diff --git a/hw/pci-host/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
index ef212d99aaf..07924bce28a 100644
--- a/hw/pci-host/ppc440_pcix.c
+++ b/hw/pci-host/ppc440_pcix.c
@@ -524,7 +524,7 @@ static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = ppc440_pcix_realize;
-    dc->reset = ppc440_pcix_reset;
+    device_class_set_legacy_reset(dc, ppc440_pcix_reset);
 }
 
 static const TypeInfo ppc440_pcix_info = {
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 0b6cbaed7ed..d5a657a02a7 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -686,7 +686,7 @@ static void mch_class_init(ObjectClass *klass, void *data)
 
     k->realize = mch_realize;
     k->config_write = mch_write_config;
-    dc->reset = mch_reset;
+    device_class_set_legacy_reset(dc, mch_reset);
     device_class_set_props(dc, mch_props);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "Host bridge";
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index d0851b48b02..1707feb9513 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -504,7 +504,7 @@ static void sabre_class_init(ObjectClass *klass, void *data)
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
 
     dc->realize = sabre_realize;
-    dc->reset = sabre_reset;
+    device_class_set_legacy_reset(dc, sabre_reset);
     device_class_set_props(dc, sabre_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 0e65deb3f97..d257acee172 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -509,7 +509,7 @@ static void pci_vpb_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pci_vpb_realize;
-    dc->reset = pci_vpb_reset;
+    device_class_set_legacy_reset(dc, pci_vpb_reset);
     dc->vmsd = &pci_vpb_vmstate;
     device_class_set_props(dc, pci_vpb_properties);
 }
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index c9ab7052f43..24f691ea829 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -300,7 +300,7 @@ static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_BRIDGE_HOST;
     k->realize = xilinx_pcie_root_realize;
     k->exit = pci_bridge_exitfn;
-    dc->reset = pci_bridge_reset;
+    device_class_set_legacy_reset(dc, pci_bridge_reset);
     k->config_read = xilinx_pcie_root_config_read;
     k->config_write = xilinx_pcie_root_config_write;
     /*
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 18cc76a7e4b..37c56882b85 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -897,7 +897,7 @@ static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
 
     dc->desc    = "PowerNV PSI Controller POWER9";
     dc->realize = pnv_psi_power9_realize;
-    dc->reset   = pnv_psi_power9_reset;
+    device_class_set_legacy_reset(dc, pnv_psi_power9_reset);
 
     ppc->xscom_pcba = PNV9_XSCOM_PSIHB_BASE;
     ppc->xscom_size = PNV9_XSCOM_PSIHB_SIZE;
@@ -949,7 +949,7 @@ static void pnv_psi_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "PowerNV PSI Controller";
     device_class_set_props(dc, pnv_psi_properties);
-    dc->reset = pnv_psi_reset;
+    device_class_set_legacy_reset(dc, pnv_psi_reset);
     dc->user_creatable = false;
 }
 
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index c44e7ed162f..347428e6330 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -457,7 +457,7 @@ static void ref405ep_fpga_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ref405ep_fpga_realize;
-    dc->reset = ref405ep_fpga_reset;
+    device_class_set_legacy_reset(dc, ref405ep_fpga_reset);
     /* Reason: only works as part of a ppc405 board */
     dc->user_creatable = false;
 }
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 0cc68178adf..5f0e2333c0b 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -119,7 +119,7 @@ static void ppc405_pob_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ppc405_pob_realize;
-    dc->reset = ppc405_pob_reset;
+    device_class_set_legacy_reset(dc, ppc405_pob_reset);
     /* Reason: only works as function of a ppc4xx SoC */
     dc->user_creatable = false;
 }
@@ -196,7 +196,7 @@ static void ppc405_opba_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ppc405_opba_realize;
-    dc->reset = ppc405_opba_reset;
+    device_class_set_legacy_reset(dc, ppc405_opba_reset);
     /* Reason: only works as function of a ppc4xx SoC */
     dc->user_creatable = false;
 }
@@ -302,7 +302,7 @@ static void ppc405_dma_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ppc405_dma_realize;
-    dc->reset = ppc405_dma_reset;
+    device_class_set_legacy_reset(dc, ppc405_dma_reset);
     /* Reason: only works as function of a ppc4xx SoC */
     dc->user_creatable = false;
 }
@@ -492,7 +492,7 @@ static void ppc405_ocm_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ppc405_ocm_realize;
-    dc->reset = ppc405_ocm_reset;
+    device_class_set_legacy_reset(dc, ppc405_ocm_reset);
     /* Reason: only works as function of a ppc4xx SoC */
     dc->user_creatable = false;
 }
@@ -726,7 +726,7 @@ static void ppc405_gpt_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ppc405_gpt_realize;
-    dc->reset = ppc405_gpt_reset;
+    device_class_set_legacy_reset(dc, ppc405_gpt_reset);
     /* Reason: only works as function of a ppc4xx SoC */
     dc->user_creatable = false;
 }
@@ -975,7 +975,7 @@ static void ppc405_cpc_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ppc405_cpc_realize;
-    dc->reset = ppc405_cpc_reset;
+    device_class_set_legacy_reset(dc, ppc405_cpc_reset);
     /* Reason: only works as function of a ppc4xx SoC */
     dc->user_creatable = false;
     device_class_set_props(dc, ppc405_cpc_properties);
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index c1d111465db..db8f6b94975 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -242,7 +242,7 @@ static void ppc4xx_mal_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ppc4xx_mal_realize;
-    dc->reset = ppc4xx_mal_reset;
+    device_class_set_legacy_reset(dc, ppc4xx_mal_reset);
     /* Reason: only works as function of a ppc4xx SoC */
     dc->user_creatable = false;
     device_class_set_props(dc, ppc4xx_mal_properties);
@@ -332,7 +332,7 @@ static void ppc405_plb_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ppc405_plb_realize;
-    dc->reset = ppc405_plb_reset;
+    device_class_set_legacy_reset(dc, ppc405_plb_reset);
     /* Reason: only works as function of a ppc4xx SoC */
     dc->user_creatable = false;
 }
@@ -518,7 +518,7 @@ static void ppc405_ebc_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ppc405_ebc_realize;
-    dc->reset = ppc405_ebc_reset;
+    device_class_set_legacy_reset(dc, ppc405_ebc_reset);
     /* Reason: only works as function of a ppc4xx SoC */
     dc->user_creatable = false;
 }
diff --git a/hw/ppc/ppc4xx_sdram.c b/hw/ppc/ppc4xx_sdram.c
index c0c87ff636a..2ee21f1ca76 100644
--- a/hw/ppc/ppc4xx_sdram.c
+++ b/hw/ppc/ppc4xx_sdram.c
@@ -437,7 +437,7 @@ static void ppc4xx_sdram_ddr_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ppc4xx_sdram_ddr_realize;
-    dc->reset = ppc4xx_sdram_ddr_reset;
+    device_class_set_legacy_reset(dc, ppc4xx_sdram_ddr_reset);
     /* Reason: only works as function of a ppc4xx SoC */
     dc->user_creatable = false;
     device_class_set_props(dc, ppc4xx_sdram_ddr_props);
@@ -722,7 +722,7 @@ static void ppc4xx_sdram_ddr2_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = ppc4xx_sdram_ddr2_realize;
-    dc->reset = ppc4xx_sdram_ddr2_reset;
+    device_class_set_legacy_reset(dc, ppc4xx_sdram_ddr2_reset);
     /* Reason: only works as function of a ppc4xx SoC */
     dc->user_creatable = false;
     device_class_set_props(dc, ppc4xx_sdram_ddr2_props);
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index dfbe759481a..e08739a443d 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -191,7 +191,7 @@ static void ppce500_spin_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = spin_reset;
+    device_class_set_legacy_reset(dc, spin_reset);
 }
 
 static const TypeInfo ppce500_spin_info = {
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 56090abcd11..46422451688 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -378,7 +378,7 @@ static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
 
     dc->realize = spapr_cpu_core_realize;
     dc->unrealize = spapr_cpu_core_unrealize;
-    dc->reset = spapr_cpu_core_reset;
+    device_class_set_legacy_reset(dc, spapr_cpu_core_reset);
     device_class_set_props(dc, spapr_cpu_core_properties);
     scc->cpu_type = data;
 }
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index e3c01ef44f8..7836dc71fc2 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -672,7 +672,7 @@ static void spapr_tce_table_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = spapr_tce_table_realize;
-    dc->reset = spapr_tce_reset;
+    device_class_set_legacy_reset(dc, spapr_tce_reset);
     dc->unrealize = spapr_tce_table_unrealize;
     /* Reason: This is just an internal device for handling the hypercalls */
     dc->user_creatable = false;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7cf9904c354..5c0024bef9c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2248,7 +2248,7 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
     dc->realize = spapr_phb_realize;
     dc->unrealize = spapr_phb_unrealize;
     device_class_set_props(dc, spapr_phb_properties);
-    dc->reset = spapr_phb_reset;
+    device_class_set_legacy_reset(dc, spapr_phb_reset);
     dc->vmsd = &vmstate_spapr_pci;
     /* Supported by TYPE_SPAPR_MACHINE */
     dc->user_creatable = true;
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 3221874848d..6a5a7f57c7d 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -635,7 +635,7 @@ static void vio_spapr_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->realize = spapr_vio_busdev_realize;
-    k->reset = spapr_vio_busdev_reset;
+    device_class_set_legacy_reset(k, spapr_vio_busdev_reset);
     k->bus_type = TYPE_SPAPR_VIO_BUS;
 }
 
diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index fbc85a8d36f..302a0a4d4df 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -206,7 +206,7 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
 
-    dc->reset = proxy_device_reset;
+    device_class_set_legacy_reset(dc, proxy_device_reset);
 
     device_class_set_props(dc, proxy_properties);
 }
diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c
index 2ac50b30cb8..1057d6a57f2 100644
--- a/hw/rtc/allwinner-rtc.c
+++ b/hw/rtc/allwinner-rtc.c
@@ -320,7 +320,7 @@ static void allwinner_rtc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = allwinner_rtc_reset;
+    device_class_set_legacy_reset(dc, allwinner_rtc_reset);
     dc->vmsd = &allwinner_rtc_vmstate;
     device_class_set_props(dc, allwinner_rtc_properties);
 }
diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
index 589d9a5a7a8..3cddf43eeab 100644
--- a/hw/rtc/aspeed_rtc.c
+++ b/hw/rtc/aspeed_rtc.c
@@ -162,7 +162,7 @@ static void aspeed_rtc_class_init(ObjectClass *klass, void *data)
 
     dc->realize = aspeed_rtc_realize;
     dc->vmsd = &vmstate_aspeed_rtc;
-    dc->reset = aspeed_rtc_reset;
+    device_class_set_legacy_reset(dc, aspeed_rtc_reset);
 }
 
 static const TypeInfo aspeed_rtc_info = {
diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index e479661c391..a5fe2214184 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -223,7 +223,7 @@ static void ds1338_class_init(ObjectClass *klass, void *data)
     k->event = ds1338_event;
     k->recv = ds1338_recv;
     k->send = ds1338_send;
-    dc->reset = ds1338_reset;
+    device_class_set_legacy_reset(dc, ds1338_reset);
     dc->vmsd = &vmstate_ds1338;
 }
 
diff --git a/hw/rtc/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
index 319371f97d1..ca28a456729 100644
--- a/hw/rtc/exynos4210_rtc.c
+++ b/hw/rtc/exynos4210_rtc.c
@@ -596,7 +596,7 @@ static void exynos4210_rtc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = exynos4210_rtc_reset;
+    device_class_set_legacy_reset(dc, exynos4210_rtc_reset);
     dc->vmsd = &vmstate_exynos4210_rtc_state;
 }
 
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 01acf30b278..a6dfbf89f34 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -298,7 +298,7 @@ static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, goldfish_rtc_properties);
     dc->realize = goldfish_rtc_realize;
-    dc->reset = goldfish_rtc_reset;
+    device_class_set_legacy_reset(dc, goldfish_rtc_reset);
     dc->vmsd = &goldfish_rtc_vmstate;
 }
 
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index 3226b6105e8..c9c3cd84da7 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -469,7 +469,7 @@ static void ls7a_rtc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->vmsd = &vmstate_ls7a_rtc;
     dc->realize = ls7a_rtc_realize;
-    dc->reset = ls7a_rtc_reset;
+    device_class_set_legacy_reset(dc, ls7a_rtc_reset);
     dc->desc = "ls7a rtc";
 }
 
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 5bb46f23838..6e9723fdf19 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -120,7 +120,7 @@ static void m48txx_isa_class_init(ObjectClass *klass, void *data)
     NvramClass *nc = NVRAM_CLASS(klass);
 
     dc->realize = m48t59_isa_realize;
-    dc->reset = m48t59_reset_isa;
+    device_class_set_legacy_reset(dc, m48t59_reset_isa);
     device_class_set_props(dc, m48t59_isa_properties);
     nc->read = m48txx_isa_read;
     nc->write = m48txx_isa_write;
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 1585a2d3997..48846d8df40 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -629,7 +629,7 @@ static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
     NvramClass *nc = NVRAM_CLASS(klass);
 
     dc->realize = m48t59_realize;
-    dc->reset = m48t59_reset_sysbus;
+    device_class_set_legacy_reset(dc, m48t59_reset_sysbus);
     device_class_set_props(dc, m48t59_sysbus_properties);
     dc->vmsd = &vmstate_m48t59;
     nc->read = m48txx_sysbus_read;
diff --git a/hw/rtc/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
index 613c6407a60..f37df09cfb9 100644
--- a/hw/rtc/xlnx-zynqmp-rtc.c
+++ b/hw/rtc/xlnx-zynqmp-rtc.c
@@ -255,7 +255,7 @@ static void rtc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = rtc_reset;
+    device_class_set_legacy_reset(dc, rtc_reset);
     dc->vmsd = &vmstate_rtc;
 }
 
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 06c1da0eced..2b0332c20e2 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -467,7 +467,7 @@ static void init_event_facility_class(ObjectClass *klass, void *data)
     SCLPEventFacilityClass *k = EVENT_FACILITY_CLASS(dc);
 
     dc->realize = realize_event_facility;
-    dc->reset = reset_event_facility;
+    device_class_set_legacy_reset(dc, reset_event_facility);
     dc->vmsd = &vmstate_event_facility;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     k->command_handler = command_handler;
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index e934bf89d15..dd71689642b 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -770,7 +770,7 @@ static void s390_ipl_class_init(ObjectClass *klass, void *data)
 
     dc->realize = s390_ipl_realize;
     device_class_set_props(dc, s390_ipl_properties);
-    dc->reset = s390_ipl_reset;
+    device_class_set_legacy_reset(dc, s390_ipl_reset);
     dc->vmsd = &vmstate_ipl;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     /* Reason: Loads the ROMs and thus can only be used one time - internally */
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3e57d5faca1..40b2567aa70 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1323,7 +1323,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
-    dc->reset = s390_pcihost_reset;
+    device_class_set_legacy_reset(dc, s390_pcihost_reset);
     dc->realize = s390_pcihost_realize;
     dc->unrealize = s390_pcihost_unrealize;
     hc->pre_plug = s390_pcihost_pre_plug;
@@ -1506,7 +1506,7 @@ static void s390_pci_device_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "zpci device";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->reset = s390_pci_device_reset;
+    device_class_set_legacy_reset(dc, s390_pci_device_reset);
     dc->bus_type = TYPE_S390_PCI_BUS;
     dc->realize = s390_pci_device_realize;
     device_class_set_props(dc, s390_pci_device_properties);
diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index 14936aa94ba..a32d6a91f58 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -117,7 +117,7 @@ static void quiesce_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCLPEventClass *k = SCLP_EVENT_CLASS(klass);
 
-    dc->reset = quiesce_reset;
+    device_class_set_legacy_reset(dc, quiesce_reset);
     dc->vmsd = &vmstate_sclpquiesce;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     /*
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 42d9d2e4835..fe4e045a6f5 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -440,7 +440,7 @@ static void esp_pci_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_STORAGE_SCSI;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->desc = "AMD Am53c974 PCscsi-PCI SCSI adapter";
-    dc->reset = esp_pci_hard_reset;
+    device_class_set_legacy_reset(dc, esp_pci_hard_reset);
     dc->vmsd = &vmstate_esp_pci_scsi;
 }
 
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index b7af8256232..ac841dc32e7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1576,7 +1576,7 @@ static void sysbus_esp_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = sysbus_esp_realize;
-    dc->reset = sysbus_esp_hard_reset;
+    device_class_set_legacy_reset(dc, sysbus_esp_hard_reset);
     dc->vmsd = &vmstate_sysbus_esp_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index f1935e53280..1f728416e2a 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2386,7 +2386,7 @@ static void lsi_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_LSI_53C895A;
     k->class_id = PCI_CLASS_STORAGE_SCSI;
     k->subsystem_id = 0x1000;
-    dc->reset = lsi_scsi_reset;
+    device_class_set_legacy_reset(dc, lsi_scsi_reset);
     dc->vmsd = &vmstate_lsi_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 2d0c6071771..221b06d6aaf 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2557,7 +2557,7 @@ static void megasas_class_init(ObjectClass *oc, void *data)
     e->product_name = info->product_name;
     e->product_version = info->product_version;
     device_class_set_props(dc, info->props);
-    dc->reset = megasas_scsi_reset;
+    device_class_set_legacy_reset(dc, megasas_scsi_reset);
     dc->vmsd = info->vmsd;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->desc = info->desc;
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index c5d3138c936..361b75e633a 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1431,7 +1431,7 @@ static void mptsas1068_class_init(ObjectClass *oc, void *data)
     pc->subsystem_id = 0x8000;
     pc->class_id = PCI_CLASS_STORAGE_SCSI;
     device_class_set_props(dc, mptsas_properties);
-    dc->reset = mptsas_reset;
+    device_class_set_legacy_reset(dc, mptsas_reset);
     dc->vmsd = &vmstate_mptsas;
     dc->desc = "LSI SAS 1068";
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4d94b2b8167..cb222da7a5d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3141,7 +3141,7 @@ static void scsi_disk_base_class_initfn(ObjectClass *klass, void *data)
     SCSIDiskClass *sdc = SCSI_DISK_BASE_CLASS(klass);
 
     dc->fw_name = "disk";
-    dc->reset = scsi_disk_reset;
+    device_class_set_legacy_reset(dc, scsi_disk_reset);
     sdc->dma_readv = scsi_dma_readv;
     sdc->dma_writev = scsi_dma_writev;
     sdc->need_fua_emulation = scsi_is_cmd_fua;
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index ee945f87e33..76f04a5ee8d 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -797,7 +797,7 @@ static void scsi_generic_class_initfn(ObjectClass *klass, void *data)
     sc->parse_cdb    = scsi_generic_parse_cdb;
     dc->fw_name = "disk";
     dc->desc = "pass through generic scsi device (/dev/sg*)";
-    dc->reset = scsi_generic_reset;
+    device_class_set_legacy_reset(dc, scsi_generic_reset);
     device_class_set_props(dc, scsi_generic_properties);
     dc->vmsd  = &vmstate_scsi_device;
 }
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index cd7bf6aa015..57761b55946 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1333,7 +1333,7 @@ static void pvscsi_class_init(ObjectClass *klass, void *data)
     k->subsystem_id = 0x1000;
     device_class_set_parent_realize(dc, pvscsi_realize,
                                     &pvs_k->parent_dc_realize);
-    dc->reset = pvscsi_reset;
+    device_class_set_legacy_reset(dc, pvscsi_reset);
     dc->vmsd = &vmstate_pvscsi;
     device_class_set_props(dc, pvscsi_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index a1b7230633e..bcfb4c13225 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -900,7 +900,7 @@ static void allwinner_sdhost_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = allwinner_sdhost_reset;
+    device_class_set_legacy_reset(dc, allwinner_sdhost_reset);
     dc->vmsd = &vmstate_allwinner_sdhost;
     dc->realize = allwinner_sdhost_realize;
     device_class_set_props(dc, allwinner_sdhost_properties);
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 3b63926c3a2..427e5336a8f 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -193,7 +193,7 @@ static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
     DeviceClass *dc = DEVICE_CLASS(classp);
 
     dc->realize = aspeed_sdhci_realize;
-    dc->reset = aspeed_sdhci_reset;
+    device_class_set_legacy_reset(dc, aspeed_sdhci_reset);
     dc->vmsd = &vmstate_aspeed_sdhci;
     device_class_set_props(dc, aspeed_sdhci_properties);
 }
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 11c54dd4a73..4e411ff7986 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -432,7 +432,7 @@ static void bcm2835_sdhost_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = bcm2835_sdhost_reset;
+    device_class_set_legacy_reset(dc, bcm2835_sdhost_reset);
     dc->vmsd = &vmstate_bcm2835_sdhost;
 }
 
diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
index 7c8bc5464b9..ad9daa20ed9 100644
--- a/hw/sd/cadence_sdhci.c
+++ b/hw/sd/cadence_sdhci.c
@@ -171,7 +171,7 @@ static void cadence_sdhci_class_init(ObjectClass *classp, void *data)
 
     dc->desc = "Cadence SD/SDIO/eMMC Host Controller (SD4HC)";
     dc->realize = cadence_sdhci_realize;
-    dc->reset = cadence_sdhci_reset;
+    device_class_set_legacy_reset(dc, cadence_sdhci_reset);
     dc->vmsd = &vmstate_cadence_sdhci;
 }
 
diff --git a/hw/sd/npcm7xx_sdhci.c b/hw/sd/npcm7xx_sdhci.c
index fb51821e110..99028c1a2ca 100644
--- a/hw/sd/npcm7xx_sdhci.c
+++ b/hw/sd/npcm7xx_sdhci.c
@@ -155,7 +155,7 @@ static void npcm7xx_sdhci_class_init(ObjectClass *classp, void *data)
 
     dc->desc = "NPCM7xx SD/eMMC Host Controller";
     dc->realize = npcm7xx_sdhci_realize;
-    dc->reset = npcm7xx_sdhci_reset;
+    device_class_set_legacy_reset(dc, npcm7xx_sdhci_reset);
     dc->vmsd = &vmstate_npcm7xx_sdhci;
 }
 
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index e3633c2e6fc..51b10cadca3 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -514,7 +514,7 @@ static void pl181_class_init(ObjectClass *klass, void *data)
     DeviceClass *k = DEVICE_CLASS(klass);
 
     k->vmsd = &vmstate_pl181;
-    k->reset = pl181_reset;
+    device_class_set_legacy_reset(k, pl181_reset);
     /* Reason: output IRQs should be wired up */
     k->user_creatable = false;
 }
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 82529708c8a..a834be7cb12 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -564,7 +564,7 @@ static void pxa2xx_mmci_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_pxa2xx_mmci;
-    dc->reset = pxa2xx_mmci_reset;
+    device_class_set_legacy_reset(dc, pxa2xx_mmci_reset);
 }
 
 static void pxa2xx_mmci_bus_class_init(ObjectClass *klass, void *data)
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a140a32ccd4..2dd7a8217cb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2819,7 +2819,7 @@ static void sdmmc_common_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, sdmmc_common_properties);
     dc->vmsd = &sd_vmstate;
-    dc->reset = sd_reset;
+    device_class_set_legacy_reset(dc, sd_reset);
     dc->bus_type = TYPE_SD_BUS;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 8293d835562..87122e4245c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1520,7 +1520,7 @@ void sdhci_common_class_init(ObjectClass *klass, void *data)
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->vmsd = &sdhci_vmstate;
-    dc->reset = sdhci_poweron_reset;
+    device_class_set_legacy_reset(dc, sdhci_poweron_reset);
 }
 
 /* --- qdev SysBus --- */
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 2dd070f978c..15940515ab9 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -398,7 +398,7 @@ static void ssi_sd_class_init(ObjectClass *klass, void *data)
     k->transfer = ssi_sd_transfer;
     k->cs_polarity = SSI_CS_LOW;
     dc->vmsd = &vmstate_ssi_sd;
-    dc->reset = ssi_sd_reset;
+    device_class_set_legacy_reset(dc, ssi_sd_reset);
     /* Reason: GPIO chip-select line should be wired up */
     dc->user_creatable = false;
 }
diff --git a/hw/sensor/dps310.c b/hw/sensor/dps310.c
index 01c776dd7a8..6966a53248b 100644
--- a/hw/sensor/dps310.c
+++ b/hw/sensor/dps310.c
@@ -205,7 +205,7 @@ static void dps310_class_init(ObjectClass *klass, void *data)
     k->event = dps310_event;
     k->recv = dps310_rx;
     k->send = dps310_tx;
-    dc->reset = dps310_reset;
+    device_class_set_legacy_reset(dc, dps310_reset);
     dc->vmsd = &vmstate_dps310;
 }
 
diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
index 95079558e87..aeccd2a3c94 100644
--- a/hw/sensor/emc141x.c
+++ b/hw/sensor/emc141x.c
@@ -270,7 +270,7 @@ static void emc141x_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    dc->reset = emc141x_reset;
+    device_class_set_legacy_reset(dc, emc141x_reset);
     k->event = emc141x_event;
     k->recv = emc141x_rx;
     k->send = emc141x_tx;
diff --git a/hw/sensor/lsm303dlhc_mag.c b/hw/sensor/lsm303dlhc_mag.c
index 343ff989904..04471539b59 100644
--- a/hw/sensor/lsm303dlhc_mag.c
+++ b/hw/sensor/lsm303dlhc_mag.c
@@ -535,7 +535,7 @@ static void lsm303dlhc_mag_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    dc->reset = lsm303dlhc_mag_reset;
+    device_class_set_legacy_reset(dc, lsm303dlhc_mag_reset);
     dc->vmsd = &vmstate_lsm303dlhc_mag;
     k->event = lsm303dlhc_mag_event;
     k->recv = lsm303dlhc_mag_recv;
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 06703b1d96e..6f765e97e46 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -377,7 +377,7 @@ static void iommu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = iommu_reset;
+    device_class_set_legacy_reset(dc, iommu_reset);
     dc->vmsd = &vmstate_iommu;
     device_class_set_props(dc, iommu_properties);
 }
diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
index 1c1dca712e3..eba811af0cc 100644
--- a/hw/sparc64/sun4u_iommu.c
+++ b/hw/sparc64/sun4u_iommu.c
@@ -309,7 +309,7 @@ static void iommu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = iommu_reset;
+    device_class_set_legacy_reset(dc, iommu_reset);
 }
 
 static const TypeInfo iommu_info = {
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index f39fb85a35e..e3fdc66cb2b 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1284,7 +1284,7 @@ static void aspeed_smc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aspeed_smc_realize;
-    dc->reset = aspeed_smc_reset;
+    device_class_set_legacy_reset(dc, aspeed_smc_reset);
     device_class_set_props(dc, aspeed_smc_properties);
     dc->vmsd = &vmstate_aspeed_smc;
 }
diff --git a/hw/ssi/bcm2835_spi.c b/hw/ssi/bcm2835_spi.c
index 6ecb42d4e3b..ebd8809f7cc 100644
--- a/hw/ssi/bcm2835_spi.c
+++ b/hw/ssi/bcm2835_spi.c
@@ -268,7 +268,7 @@ static void bcm2835_spi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = bcm2835_spi_reset;
+    device_class_set_legacy_reset(dc, bcm2835_spi_reset);
     dc->realize = bcm2835_spi_realize;
     dc->vmsd = &vmstate_bcm2835_spi;
 }
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index 863b5fd60e9..9e07432f7c9 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -628,7 +628,7 @@ static void ibex_spi_host_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = ibex_spi_host_realize;
-    dc->reset = ibex_spi_host_reset;
+    device_class_set_legacy_reset(dc, ibex_spi_host_reset);
     dc->vmsd = &vmstate_ibex;
     device_class_set_props(dc, ibex_spi_properties);
 }
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 12d897d306f..2e317879b47 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -481,7 +481,7 @@ static void imx_spi_class_init(ObjectClass *klass, void *data)
 
     dc->realize = imx_spi_realize;
     dc->vmsd = &vmstate_imx_spi;
-    dc->reset = imx_spi_reset;
+    device_class_set_legacy_reset(dc, imx_spi_reset);
     dc->desc = "i.MX SPI Controller";
 }
 
diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index 1d25ba23aa5..340adcdd3f6 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -403,7 +403,7 @@ static void mss_spi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = mss_spi_realize;
-    dc->reset = mss_spi_reset;
+    device_class_set_legacy_reset(dc, mss_spi_reset);
     dc->vmsd = &vmstate_mss_spi;
 }
 
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index b8be8ddf0ea..53c9c225ad8 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -296,7 +296,7 @@ static void pl022_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = pl022_reset;
+    device_class_set_legacy_reset(dc, pl022_reset);
     dc->vmsd = &vmstate_pl022;
     dc->realize = pl022_realize;
 }
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index c1297ab7330..9e7207bf7c0 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1245,7 +1245,7 @@ static void pnv_spi_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "PowerNV SPI";
     dc->realize = pnv_spi_realize;
-    dc->reset = do_reset;
+    device_class_set_legacy_reset(dc, do_reset);
     device_class_set_props(dc, pnv_spi_properties);
 }
 
diff --git a/hw/ssi/sifive_spi.c b/hw/ssi/sifive_spi.c
index 1b4a401ca18..08a107792b6 100644
--- a/hw/ssi/sifive_spi.c
+++ b/hw/ssi/sifive_spi.c
@@ -338,7 +338,7 @@ static void sifive_spi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_props(dc, sifive_spi_properties);
-    dc->reset = sifive_spi_reset;
+    device_class_set_legacy_reset(dc, sifive_spi_reset);
     dc->realize = sifive_spi_realize;
 }
 
diff --git a/hw/ssi/stm32f2xx_spi.c b/hw/ssi/stm32f2xx_spi.c
index a37139fe5ac..ea9b74a4094 100644
--- a/hw/ssi/stm32f2xx_spi.c
+++ b/hw/ssi/stm32f2xx_spi.c
@@ -206,7 +206,7 @@ static void stm32f2xx_spi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = stm32f2xx_spi_reset;
+    device_class_set_legacy_reset(dc, stm32f2xx_spi_reset);
     dc->vmsd = &vmstate_stm32f2xx_spi;
 }
 
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 2e0687ac907..7f1e1808c51 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -371,7 +371,7 @@ static void xilinx_spi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = xilinx_spi_realize;
-    dc->reset = xlx_spi_reset;
+    device_class_set_legacy_reset(dc, xlx_spi_reset);
     device_class_set_props(dc, xilinx_spi_properties);
     dc->vmsd = &vmstate_xilinx_spi;
 }
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 71952a410d8..1595a887a1d 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1448,7 +1448,7 @@ static void xilinx_spips_class_init(ObjectClass *klass, void *data)
     XilinxSPIPSClass *xsc = XILINX_SPIPS_CLASS(klass);
 
     dc->realize = xilinx_spips_realize;
-    dc->reset = xilinx_spips_reset;
+    device_class_set_legacy_reset(dc, xilinx_spips_reset);
     device_class_set_props(dc, xilinx_spips_properties);
     dc->vmsd = &vmstate_xilinx_spips;
 
@@ -1464,7 +1464,7 @@ static void xlnx_zynqmp_qspips_class_init(ObjectClass *klass, void * data)
     XilinxSPIPSClass *xsc = XILINX_SPIPS_CLASS(klass);
 
     dc->realize = xlnx_zynqmp_qspips_realize;
-    dc->reset = xlnx_zynqmp_qspips_reset;
+    device_class_set_legacy_reset(dc, xlnx_zynqmp_qspips_reset);
     dc->vmsd = &vmstate_xlnx_zynqmp_qspips;
     device_class_set_props(dc, xilinx_zynqmp_qspips_properties);
     xsc->reg_ops = &xlnx_zynqmp_qspips_ops;
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index c479138ec1c..ecc1903b8ec 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -1836,7 +1836,7 @@ static void xlnx_versal_ospi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = xlnx_versal_ospi_reset;
+    device_class_set_legacy_reset(dc, xlnx_versal_ospi_reset);
     dc->realize = xlnx_versal_ospi_realize;
     dc->vmsd = &vmstate_xlnx_versal_ospi;
     device_class_set_props(dc, xlnx_versal_ospi_properties);
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 64d80cdf6a3..8091ec18c7f 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -384,7 +384,7 @@ static void a9_gtimer_class_init(ObjectClass *klass, void *data)
 
     dc->realize = a9_gtimer_realize;
     dc->vmsd = &vmstate_a9_gtimer;
-    dc->reset = a9_gtimer_reset;
+    device_class_set_legacy_reset(dc, a9_gtimer_reset);
     device_class_set_props(dc, a9_gtimer_properties);
 }
 
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index a524de13817..d488e9782b2 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -293,7 +293,7 @@ static void a10_pit_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = a10_pit_reset;
+    device_class_set_legacy_reset(dc, a10_pit_reset);
     device_class_set_props(dc, a10_pit_properties);
     dc->desc = "allwinner a10 timer";
     dc->vmsd = &vmstate_a10_pit;
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index bca4cee0e4e..defa30b46dd 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -311,7 +311,7 @@ static void arm_mptimer_class_init(ObjectClass *klass, void *data)
 
     dc->realize = arm_mptimer_realize;
     dc->vmsd = &vmstate_arm_mptimer;
-    dc->reset = arm_mptimer_reset;
+    device_class_set_legacy_reset(dc, arm_mptimer_reset);
     device_class_set_props(dc, arm_mptimer_properties);
 }
 
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index f6b1acef271..a07febd1d1e 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -290,7 +290,7 @@ static void systick_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_systick;
-    dc->reset = systick_reset;
+    device_class_set_legacy_reset(dc, systick_reset);
     dc->realize = systick_realize;
 }
 
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index fc5c94bdf36..b1f860ecfb8 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -682,7 +682,7 @@ static void timer_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aspeed_timer_realize;
-    dc->reset = aspeed_timer_reset;
+    device_class_set_legacy_reset(dc, aspeed_timer_reset);
     dc->desc = "ASPEED Timer";
     dc->vmsd = &vmstate_aspeed_timer_state;
     device_class_set_props(dc, aspeed_timer_properties);
diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
index c48555da525..421920054fa 100644
--- a/hw/timer/avr_timer16.c
+++ b/hw/timer/avr_timer16.c
@@ -600,7 +600,7 @@ static void avr_timer16_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = avr_timer16_reset;
+    device_class_set_legacy_reset(dc, avr_timer16_reset);
     dc->realize = avr_timer16_realize;
     device_class_set_props(dc, avr_timer16_properties);
 }
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index 3ec64604ee5..2f0fee33420 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -159,7 +159,7 @@ static void bcm2835_systmr_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = bcm2835_systmr_realize;
-    dc->reset = bcm2835_systmr_reset;
+    device_class_set_legacy_reset(dc, bcm2835_systmr_reset);
     dc->vmsd = &bcm2835_systmr_vmstate;
 }
 
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index ddf9070c3c0..2ecd8dfe3c7 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -540,7 +540,7 @@ static void cmsdk_apb_dualtimer_class_init(ObjectClass *klass, void *data)
 
     dc->realize = cmsdk_apb_dualtimer_realize;
     dc->vmsd = &cmsdk_apb_dualtimer_vmstate;
-    dc->reset = cmsdk_apb_dualtimer_reset;
+    device_class_set_legacy_reset(dc, cmsdk_apb_dualtimer_reset);
 }
 
 static const TypeInfo cmsdk_apb_dualtimer_info = {
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 814545c7832..16d0b2170ef 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -267,7 +267,7 @@ static void cmsdk_apb_timer_class_init(ObjectClass *klass, void *data)
 
     dc->realize = cmsdk_apb_timer_realize;
     dc->vmsd = &cmsdk_apb_timer_vmstate;
-    dc->reset = cmsdk_apb_timer_reset;
+    device_class_set_legacy_reset(dc, cmsdk_apb_timer_reset);
 }
 
 static const TypeInfo cmsdk_apb_timer_info = {
diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index 9fc5c1d8a46..00c32978d29 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -165,7 +165,7 @@ static void digic_timer_class_init(ObjectClass *klass, void *class_data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = digic_timer_reset;
+    device_class_set_legacy_reset(dc, digic_timer_reset);
     dc->vmsd = &vmstate_digic_timer;
 }
 
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 75098cdb555..e807fe2de90 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -1550,7 +1550,7 @@ static void exynos4210_mct_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = exynos4210_mct_reset;
+    device_class_set_legacy_reset(dc, exynos4210_mct_reset);
     dc->vmsd = &vmstate_exynos4210_mct_state;
 }
 
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index ca330e9446c..703d1d2b4ad 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -424,7 +424,7 @@ static void exynos4210_pwm_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = exynos4210_pwm_reset;
+    device_class_set_legacy_reset(dc, exynos4210_pwm_reset);
     dc->vmsd = &vmstate_exynos4210_pwm_state;
 }
 
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 49908854510..6ef08f25fd9 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -415,7 +415,7 @@ static void grlib_gptimer_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = grlib_gptimer_realize;
-    dc->reset = grlib_gptimer_reset;
+    device_class_set_legacy_reset(dc, grlib_gptimer_reset);
     device_class_set_props(dc, grlib_gptimer_properties);
 }
 
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 471950adef1..5399f1b2a3f 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -758,7 +758,7 @@ static void hpet_device_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = hpet_realize;
-    dc->reset = hpet_reset;
+    device_class_set_legacy_reset(dc, hpet_reset);
     dc->vmsd = &vmstate_hpet;
     device_class_set_props(dc, hpet_device_properties);
 }
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index c235496fc9c..058fc61ce99 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -360,7 +360,7 @@ static void pit_class_initfn(ObjectClass *klass, void *data)
     k->set_channel_gate = pit_set_channel_gate;
     k->get_channel_info = pit_get_channel_info_common;
     k->post_load = pit_post_load;
-    dc->reset = pit_reset;
+    device_class_set_legacy_reset(dc, pit_reset);
 }
 
 static const TypeInfo pit_info = {
diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index 4917388d45a..2bdcff532dd 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -291,7 +291,7 @@ static void ibex_timer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = ibex_timer_reset;
+    device_class_set_legacy_reset(dc, ibex_timer_reset);
     dc->vmsd = &vmstate_ibex_timer;
     dc->realize = ibex_timer_realize;
     device_class_set_props(dc, ibex_timer_properties);
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index bd625203aaf..f40ab166973 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -432,7 +432,7 @@ static void imx_epit_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc  = DEVICE_CLASS(klass);
 
     dc->realize = imx_epit_realize;
-    dc->reset = imx_epit_dev_reset;
+    device_class_set_legacy_reset(dc, imx_epit_dev_reset);
     dc->vmsd = &vmstate_imx_timer_epit;
     dc->desc = "i.MX periodic timer";
 }
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index a8edaec8673..23b3d79bdb8 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -524,7 +524,7 @@ static void imx_gpt_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = imx_gpt_realize;
-    dc->reset = imx_gpt_reset;
+    device_class_set_legacy_reset(dc, imx_gpt_reset);
     dc->vmsd = &vmstate_imx_timer_gpt;
     dc->desc = "i.MX general timer";
 }
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index a33166a8817..35b0e62d5b5 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -388,7 +388,7 @@ static void nrf51_timer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = nrf51_timer_reset;
+    device_class_set_legacy_reset(dc, nrf51_timer_reset);
     dc->vmsd = &vmstate_nrf51_timer;
     device_class_set_props(dc, nrf51_timer_properties);
 }
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
index 08832932d2a..cd59b08c876 100644
--- a/hw/timer/renesas_cmt.c
+++ b/hw/timer/renesas_cmt.c
@@ -263,7 +263,7 @@ static void rcmt_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_rcmt;
-    dc->reset = rcmt_reset;
+    device_class_set_legacy_reset(dc, rcmt_reset);
     device_class_set_props(dc, rcmt_properties);
 }
 
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index 1d47d0615a4..a93e075fcda 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -473,7 +473,7 @@ static void rtmr_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_rtmr;
-    dc->reset = rtmr_reset;
+    device_class_set_legacy_reset(dc, rtmr_reset);
     device_class_set_props(dc, rtmr_properties);
 }
 
diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
index e8610c37dd3..4602fc1a616 100644
--- a/hw/timer/sifive_pwm.c
+++ b/hw/timer/sifive_pwm.c
@@ -446,7 +446,7 @@ static void sifive_pwm_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = sifive_pwm_reset;
+    device_class_set_legacy_reset(dc, sifive_pwm_reset);
     device_class_set_props(dc, sifive_pwm_properties);
     dc->vmsd = &vmstate_sifive_pwm;
     dc->realize = sifive_pwm_realize;
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 5507b0145b5..12cb3bac97f 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -429,7 +429,7 @@ static void slavio_timer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = slavio_timer_reset;
+    device_class_set_legacy_reset(dc, slavio_timer_reset);
     dc->vmsd = &vmstate_slavio_timer;
     device_class_set_props(dc, slavio_timer_properties);
 }
diff --git a/hw/timer/sse-counter.c b/hw/timer/sse-counter.c
index daceedf964e..f17064abe35 100644
--- a/hw/timer/sse-counter.c
+++ b/hw/timer/sse-counter.c
@@ -454,7 +454,7 @@ static void sse_counter_class_init(ObjectClass *klass, void *data)
 
     dc->realize = sse_counter_realize;
     dc->vmsd = &sse_counter_vmstate;
-    dc->reset = sse_counter_reset;
+    device_class_set_legacy_reset(dc, sse_counter_reset);
 }
 
 static const TypeInfo sse_counter_info = {
diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index cb20a9eb79e..115b0138c87 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -451,7 +451,7 @@ static void sse_timer_class_init(ObjectClass *klass, void *data)
 
     dc->realize = sse_timer_realize;
     dc->vmsd = &sse_timer_vmstate;
-    dc->reset = sse_timer_reset;
+    device_class_set_legacy_reset(dc, sse_timer_reset);
     device_class_set_props(dc, sse_timer_properties);
 }
 
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index de4208b1a61..16b47887a5e 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -325,7 +325,7 @@ static void stm32f2xx_timer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = stm32f2xx_timer_reset;
+    device_class_set_legacy_reset(dc, stm32f2xx_timer_reset);
     device_class_set_props(dc, stm32f2xx_timer_properties);
     dc->vmsd = &vmstate_stm32f2xx_timer;
     dc->realize = stm32f2xx_timer_realize;
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index 4bb09655b40..c5548b0a459 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -538,7 +538,7 @@ static void tpm_tis_i2c_class_init(ObjectClass *klass, void *data)
     TPMIfClass *tc = TPM_IF_CLASS(klass);
 
     dc->realize = tpm_tis_i2c_realizefn;
-    dc->reset = tpm_tis_i2c_reset;
+    device_class_set_legacy_reset(dc, tpm_tis_i2c_reset);
     dc->vmsd = &vmstate_tpm_tis_i2c;
     device_class_set_props(dc, tpm_tis_i2c_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 8887b3c9c49..21109edcaa2 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -177,7 +177,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass, void *data)
     dc->vmsd  = &vmstate_tpm_tis_isa;
     tc->model = TPM_MODEL_TPM_TIS;
     dc->realize = tpm_tis_isa_realizefn;
-    dc->reset = tpm_tis_isa_reset;
+    device_class_set_legacy_reset(dc, tpm_tis_isa_reset);
     tc->request_completed = tpm_tis_isa_request_completed;
     tc->get_version = tpm_tis_isa_get_tpm_version;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 941f7f7f62c..967f2646342 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -135,7 +135,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
     tc->model = TPM_MODEL_TPM_TIS;
     dc->realize = tpm_tis_sysbus_realizefn;
     dc->user_creatable = true;
-    dc->reset = tpm_tis_sysbus_reset;
+    device_class_set_legacy_reset(dc, tpm_tis_sysbus_reset);
     tc->request_completed = tpm_tis_sysbus_request_completed;
     tc->get_version = tpm_tis_sysbus_get_tpm_version;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
diff --git a/hw/tricore/tricore_testdevice.c b/hw/tricore/tricore_testdevice.c
index 9028d970b00..ae95c495654 100644
--- a/hw/tricore/tricore_testdevice.c
+++ b/hw/tricore/tricore_testdevice.c
@@ -67,7 +67,7 @@ static void tricore_testdevice_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_props(dc, tricore_testdevice_properties);
-    dc->reset = tricore_testdevice_reset;
+    device_class_set_legacy_reset(dc, tricore_testdevice_reset);
 }
 
 static const TypeInfo tricore_testdevice_info = {
diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
index 09d8e25b971..e7d8c7924ba 100644
--- a/hw/usb/hcd-dwc3.c
+++ b/hw/usb/hcd-dwc3.c
@@ -666,7 +666,7 @@ static void usb_dwc3_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = usb_dwc3_reset;
+    device_class_set_legacy_reset(dc, usb_dwc3_reset);
     dc->realize = usb_dwc3_realize;
     dc->vmsd = &vmstate_usb_dwc3;
     device_class_set_props(dc, usb_dwc3_properties);
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 3ff54edf62a..c94fc9f6c58 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -162,7 +162,7 @@ static void ehci_class_init(ObjectClass *klass, void *data)
     k->config_write = usb_ehci_pci_write_config;
     dc->vmsd = &vmstate_ehci_pci;
     device_class_set_props(dc, ehci_pci_properties);
-    dc->reset = usb_ehci_pci_reset;
+    device_class_set_legacy_reset(dc, usb_ehci_pci_reset);
 }
 
 static const TypeInfo ehci_pci_type_info = {
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index fe1dabd0bbe..2b1652f7a8b 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -93,7 +93,7 @@ static void ehci_sysbus_class_init(ObjectClass *klass, void *data)
     dc->realize = usb_ehci_sysbus_realize;
     dc->vmsd = &vmstate_ehci_sysbus;
     device_class_set_props(dc, ehci_sysbus_properties);
-    dc->reset = usb_ehci_sysbus_reset;
+    device_class_set_legacy_reset(dc, usb_ehci_sysbus_reset);
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 33ed9b6f5a5..47fb6598066 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -142,7 +142,7 @@ static void ohci_pci_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, ohci_pci_properties);
     dc->hotpluggable = false;
     dc->vmsd = &vmstate_ohci;
-    dc->reset = usb_ohci_reset_pci;
+    device_class_set_legacy_reset(dc, usb_ohci_reset_pci);
 }
 
 static const TypeInfo ohci_pci_info = {
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 6fba7f50f87..313e1e71bb1 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -73,7 +73,7 @@ static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
     dc->desc = "OHCI USB Controller";
     device_class_set_props(dc, ohci_sysbus_properties);
-    dc->reset = ohci_sysbus_reset;
+    device_class_set_legacy_reset(dc, ohci_sysbus_reset);
 }
 
 static const TypeInfo ohci_sysbus_types[] = {
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index a03cf22e69f..3d0339af7b9 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1247,7 +1247,7 @@ static void uhci_class_init(ObjectClass *klass, void *data)
 
     k->class_id  = PCI_CLASS_SERIAL_USB;
     dc->vmsd = &vmstate_uhci;
-    dc->reset = uhci_reset;
+    device_class_set_legacy_reset(dc, uhci_reset);
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 264d7ebb776..a039f5778a6 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -202,7 +202,7 @@ static void xhci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset   = xhci_pci_reset;
+    device_class_set_legacy_reset(dc, xhci_pci_reset);
     dc->vmsd    = &vmstate_xhci_pci;
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
     k->realize      = usb_xhci_pci_realize;
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index d93bae31f93..59cf7fd4ab1 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -101,7 +101,7 @@ static void xhci_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = xhci_sysbus_reset;
+    device_class_set_legacy_reset(dc, xhci_sysbus_reset);
     dc->realize = xhci_sysbus_realize;
     dc->vmsd = &vmstate_xhci_sysbus;
     device_class_set_props(dc, xhci_sysbus_props);
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b6411f0bdac..d85adaca0dc 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3621,7 +3621,7 @@ static void xhci_class_init(ObjectClass *klass, void *data)
 
     dc->realize = usb_xhci_realize;
     dc->unrealize = usb_xhci_unrealize;
-    dc->reset   = xhci_reset;
+    device_class_set_legacy_reset(dc, xhci_reset);
     device_class_set_props(dc, xhci_properties);
     dc->user_creatable = false;
 }
diff --git a/hw/usb/imx-usb-phy.c b/hw/usb/imx-usb-phy.c
index 18917d7599e..f519250567d 100644
--- a/hw/usb/imx-usb-phy.c
+++ b/hw/usb/imx-usb-phy.c
@@ -218,7 +218,7 @@ static void imx_usbphy_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = imx_usbphy_reset;
+    device_class_set_legacy_reset(dc, imx_usbphy_reset);
     dc->vmsd = &vmstate_imx_usbphy;
     dc->desc = "i.MX USB PHY Module";
     dc->realize = imx_usbphy_realize;
diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index 1dd4071e683..4a9114021b0 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -832,7 +832,7 @@ static void tusb6010_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = tusb6010_realize;
-    dc->reset = tusb6010_reset;
+    device_class_set_legacy_reset(dc, tusb6010_reset);
 }
 
 static const TypeInfo tusb6010_info = {
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 71bf32b83c5..4013e7b4366 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -256,7 +256,7 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
     dc->realize = vfio_ap_realize;
     dc->unrealize = vfio_ap_unrealize;
     dc->hotpluggable = true;
-    dc->reset = vfio_ap_reset;
+    device_class_set_legacy_reset(dc, vfio_ap_reset);
     dc->bus_type = TYPE_AP_BUS;
 }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 115862f4303..24703c814a0 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -711,7 +711,7 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->realize = vfio_ccw_realize;
     dc->unrealize = vfio_ccw_unrealize;
-    dc->reset = vfio_ccw_reset;
+    device_class_set_legacy_reset(dc, vfio_ccw_reset);
 
     cdc->handle_request = vfio_ccw_handle_request;
     cdc->handle_halt = vfio_ccw_handle_halt;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2407720c353..26537e8ad22 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3424,7 +3424,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
-    dc->reset = vfio_pci_reset;
+    device_class_set_legacy_reset(dc, vfio_pci_reset);
     device_class_set_props(dc, vfio_pci_dev_properties);
 #ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 320428ac0d3..e3366fe54ca 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -790,7 +790,7 @@ static void virtio_mmio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = virtio_mmio_realizefn;
-    dc->reset = virtio_mmio_reset;
+    device_class_set_legacy_reset(dc, virtio_mmio_reset);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     device_class_set_props(dc, virtio_mmio_properties);
 }
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 3091e5c3d54..7ad46f94105 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -380,7 +380,7 @@ static void cmsdk_apb_watchdog_class_init(ObjectClass *klass, void *data)
 
     dc->realize = cmsdk_apb_watchdog_realize;
     dc->vmsd = &cmsdk_apb_watchdog_vmstate;
-    dc->reset = cmsdk_apb_watchdog_reset;
+    device_class_set_legacy_reset(dc, cmsdk_apb_watchdog_reset);
 }
 
 static const TypeInfo cmsdk_apb_watchdog_info = {
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index d437535cc66..80f9b36e79b 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -278,7 +278,7 @@ static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = wdt_sbsa_gwdt_realize;
-    dc->reset = wdt_sbsa_gwdt_reset;
+    device_class_set_legacy_reset(dc, wdt_sbsa_gwdt_reset);
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
     dc->vmsd = &vmstate_sbsa_gwdt;
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 75685c56470..39c3f362a83 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -300,7 +300,7 @@ static void aspeed_wdt_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "ASPEED Watchdog Controller";
     dc->realize = aspeed_wdt_realize;
-    dc->reset = aspeed_wdt_reset;
+    device_class_set_legacy_reset(dc, aspeed_wdt_reset);
     set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
     dc->vmsd = &vmstate_aspeed_wdt;
     device_class_set_props(dc, aspeed_wdt_properties);
diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 1b73b16fb35..040d20fde76 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -115,7 +115,7 @@ static void wdt_diag288_class_init(ObjectClass *klass, void *data)
 
     dc->realize = wdt_diag288_realize;
     dc->unrealize = wdt_diag288_unrealize;
-    dc->reset = wdt_diag288_reset;
+    device_class_set_legacy_reset(dc, wdt_diag288_reset);
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
     dc->vmsd = &vmstate_diag288;
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 8bce0509cd5..9427abfb49e 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -469,7 +469,7 @@ static void i6300esb_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_ESB_9;
     k->class_id = PCI_CLASS_SYSTEM_OTHER;
-    dc->reset = i6300esb_reset;
+    device_class_set_legacy_reset(dc, i6300esb_reset);
     dc->vmsd = &vmstate_i6300esb;
     set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
     dc->desc = "Intel 6300ESB";
diff --git a/hw/watchdog/wdt_ib700.c b/hw/watchdog/wdt_ib700.c
index eea8da60596..17c82897bf3 100644
--- a/hw/watchdog/wdt_ib700.c
+++ b/hw/watchdog/wdt_ib700.c
@@ -133,7 +133,7 @@ static void wdt_ib700_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = wdt_ib700_realize;
-    dc->reset = wdt_ib700_reset;
+    device_class_set_legacy_reset(dc, wdt_ib700_reset);
     dc->vmsd = &vmstate_ib700;
     set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
     dc->desc = "iBASE 700";
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 6452fc4721d..be63d421da1 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -294,7 +294,7 @@ static void imx2_wdt_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, imx2_wdt_properties);
     dc->realize = imx2_wdt_realize;
-    dc->reset = imx2_wdt_reset;
+    device_class_set_legacy_reset(dc, imx2_wdt_reset);
     dc->vmsd = &vmstate_imx2_wdt;
     dc->desc = "i.MX2 watchdog timer";
     set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
-- 
2.34.1


