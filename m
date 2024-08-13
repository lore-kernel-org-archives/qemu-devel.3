Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40D6C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdulY-0004lq-K5; Tue, 13 Aug 2024 12:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulW-0004ex-K4
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:52:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulT-000191-7o
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:52:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4280c55e488so507245e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723567972; x=1724172772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wczG768tMwJetPgc7ickx8Sw3AesqFj+1jfdYXgjTyQ=;
 b=el9RDp9nXzaYFpgFwHOItacfTj9Pr190toS9c+6uvlUc7Xtm1cMphqDOF8h65nFOjU
 L1x0EbRDAqBKyFn8mmxhq6LibwhXP3EteLt6xuLibtpMdNngaqrOhrcPBujVafNQVLLh
 evy3+yZFwLlkEhXbzFlqNwgKmCzG9to+SOt/9XnjJJn7qTS+jlCiuLFFb7ngef7RdOjD
 WcGJtFkEuSAK9gz5/7zM1ywKQmc5TBSp+7fTx90I6zmaeItyloDxsoUvWxpnB83mMh5m
 dceUzGQy8XPCfnOVf3H05GM3dhx3F9KBPVA7eVvxdbB4v/Nh1/QFL/iLRNGfyeobQjN9
 MdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567972; x=1724172772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wczG768tMwJetPgc7ickx8Sw3AesqFj+1jfdYXgjTyQ=;
 b=Ov4cgNY3EioknlCi50TIYfiPASYZmBRmEpG3B3aAGNu9DU9H4l1MIQFnmuBRqMOYc/
 OgSpzuXA9SC3iSyXRCoG0atrJJq0HSbmSofc1YvK1gPV5pcB5UVYs7LYKpziPZPsFys5
 EZB94HLBTTAekFpsUsfeJ/jSbIadZ3j6p2ADtSljyD320QYOoduBvDY3akNybl3RSwLO
 ih3u3o6hbpsk2YeI5HCLFnG4z1CQVQsBZ3M5I9qqGYEUAdw3uqCz5md5h7dwIaY4XtT0
 6z+pnQ0ufO1Y5jej4GCHKiZRonWhFuyQ0KJ+LJoBzcHNaJH7reWX2jRTkzPMv9IkuRCs
 xoDw==
X-Gm-Message-State: AOJu0Yw0TppvY75kOJ0Y5dEdb9AE49dLFLC+Xj9xli7FarSApaohAJSv
 ObJw6EMa7R0cMM4uCyrqT8BP0S5zVR3muyM3siQAXRrhZzWxXFKfrkfTEvYfH+tJ7aG4jw7Teg7
 4
X-Google-Smtp-Source: AGHT+IHv11gPl9hfp/skgAutmGCTrHMsS/VB4PwyW8vrRKmiHuKNzGSVIh00fiQ62nLmQc0NhSdWhw==
X-Received: by 2002:a05:600c:450a:b0:426:676a:c4d1 with SMTP id
 5b1f17b1804b1-429dd0688c5mr2836805e9.8.1723567972111; 
 Tue, 13 Aug 2024 09:52:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77374a5sm147347015e9.30.2024.08.13.09.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:52:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH for-9.2 00/10] s390: Convert virtio-ccw,
 cpu to three-phase reset, and followup cleanup
Date: Tue, 13 Aug 2024 17:52:40 +0100
Message-Id: <20240813165250.2717650-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The main aim of this patchseries is to remove the two remaining uses
of device_class_set_parent_reset() in the tree, which are virtio-ccw
and the s390 CPU class. Doing that lets us do some followup cleanup.
(The diffstat looks alarming but is almost all coccinelle automated
changes.)

virtio-ccw is a simple conversion, because it's a leaf class and no
other code interacts with the reset function. So we convert to
three-phase and resettable_class_set_parent_phases().

The s390 CPU is trickier, because s390 has its own set of different
kinds of reset (the S390_CPU_RESET_* enum values). At the moment we
have a single function implementing the reset, which always chains to
the parent DeviceClass::reset, and which can be called both from the
CPU object's own DeviceClass::reset method and also from other s390
code.

I opted to handle this by adding two new S390-CPU-specific reset types
to the Resettable ResetType enum.  Now instead of having an underlying
implementation of reset that is s390-specific and which might be
called either directly or via the DeviceClass::reset method, we can
implement only the Resettable hold phase method, and have the places
that need to trigger an s390-specific reset type do so by calling
resettable_reset().
                            
The other option would have been to smuggle in the s390 reset type
via, for instance, a field in the CPU state that we set in
s390_do_cpu_initial_reset() etc and then examined in the reset method,
but doing it this way seems cleaner.

The rest of the series is largely cleanup. Some small stuff:
 * remove the now-unused device_class_set_parent_reset() function
 * remove some CPU state struct fields in alpha and hppa that
   were simply unused
 * fix an accidental comma in xilinx_axidma that confused a
   Coccinelle script
 * hw/remote/message.c should not be directly invoking the
   DeviceClass::reset method

There are also patches here which convert devices from directly
setting:
   dc->reset = my_reset_function;
to using a function call:
   device_class_set_legacy_reset(dc, my_reset_function);

The conversion is entirely scripted using a coccinelle patch, and it
is responsible for the large diffstat here.

If people feel this is unnecessary churn I'm open to that argument,
but my motivation here is:
 * it means that people writing device code see the "legacy" word
   and get a hint that a new QEMU device probably should be using
   something else (i.e. Resettable)
 * it makes it easier to find the places in the code that are
   still using legacy-reset with a simple grep

In particular, having done that makes it easier to rename the
DeviceState::reset field to DeviceState::legacy_reset, and that in
turn is how I found that hw/remote/ was still directly invoking it.

The last patch removes device_phases_reset(), which was the part of
the reset transition glue that supported "device is reset via the
legacy reset method but it is a three-phase device".  Now we know
there is no way to directly invoke legacy-reset any more, we can drop
that bit of glue. (The opposite direction, "device is reset via a
three-phase-aware method but only implements the legacy reset method",
is still supported.)

I am pondering the idea of a further Coccinelle-driven conversion
of device_class_set_legacy_reset() calls into three-phase setting
of the Resettable hold phase method. This would be a zero behaviour
change, but the difficult part will be where we have devices
which make direct function calls to their reset function as well
as registering it as the reset method; I'm not sure if Coccinelle
can do "match functions which are not referenced elsewhere in the
file" checks.

Note that my testing here has only been "make check" and
"make check-avocado", which I know doesn't really exercise reset
very heavily.

thanks
-- PMM

Peter Maydell (10):
  hw/s390/virtio-ccw: Convert to three-phase reset
  target/s390: Convert CPU to Resettable interface
  hw: Remove device_class_set_parent_reset()
  target/alpha, hppa: Remove unused parent_reset fields
  hw/dma/xilinx_axidma: Use semicolon at end of statement, not comma
  hw/remote/message.c: Don't directly invoke DeviceClass:reset
  hw: Define new device_class_set_legacy_reset()
  hw: Use device_class_set_legacy_reset() instead of opencoding
  hw: Rename DeviceClass::reset field to legacy_reset
  hw: Remove device_phases_reset()

 docs/devel/reset.rst                  | 10 +++++
 scripts/coccinelle/device-reset.cocci | 30 ++++++++++++++
 hw/s390x/virtio-ccw.h                 |  2 +-
 include/hw/qdev-core.h                | 33 +++++++--------
 include/hw/resettable.h               |  2 +
 target/alpha/cpu.h                    |  2 -
 target/hppa/cpu.h                     |  2 -
 target/s390x/cpu.h                    | 21 ++--------
 hw/acpi/erst.c                        |  2 +-
 hw/acpi/piix4.c                       |  2 +-
 hw/adc/aspeed_adc.c                   |  2 +-
 hw/adc/max111x.c                      |  2 +-
 hw/adc/stm32f2xx_adc.c                |  2 +-
 hw/adc/zynq-xadc.c                    |  2 +-
 hw/arm/armsse.c                       |  2 +-
 hw/arm/highbank.c                     |  2 +-
 hw/arm/musicpal.c                     |  6 +--
 hw/arm/pxa2xx.c                       |  4 +-
 hw/arm/strongarm.c                    |  4 +-
 hw/audio/ac97.c                       |  2 +-
 hw/audio/cs4231.c                     |  2 +-
 hw/audio/cs4231a.c                    |  2 +-
 hw/audio/es1370.c                     |  2 +-
 hw/audio/hda-codec.c                  |  2 +-
 hw/audio/intel-hda.c                  |  2 +-
 hw/audio/marvell_88w8618.c            |  2 +-
 hw/audio/pl041.c                      |  2 +-
 hw/audio/via-ac97.c                   |  2 +-
 hw/block/fdc-isa.c                    |  2 +-
 hw/block/fdc-sysbus.c                 |  2 +-
 hw/block/m25p80.c                     |  2 +-
 hw/block/nand.c                       |  2 +-
 hw/block/onenand.c                    |  2 +-
 hw/block/pflash_cfi01.c               |  2 +-
 hw/block/pflash_cfi02.c               |  2 +-
 hw/block/swim.c                       |  2 +-
 hw/char/avr_usart.c                   |  2 +-
 hw/char/cmsdk-apb-uart.c              |  2 +-
 hw/char/digic-uart.c                  |  2 +-
 hw/char/escc.c                        |  2 +-
 hw/char/etraxfs_ser.c                 |  2 +-
 hw/char/exynos4210_uart.c             |  2 +-
 hw/char/goldfish_tty.c                |  2 +-
 hw/char/grlib_apbuart.c               |  2 +-
 hw/char/ibex_uart.c                   |  2 +-
 hw/char/imx_serial.c                  |  2 +-
 hw/char/mcf_uart.c                    |  2 +-
 hw/char/mchp_pfsoc_mmuart.c           |  2 +-
 hw/char/nrf51_uart.c                  |  2 +-
 hw/char/pl011.c                       |  2 +-
 hw/char/renesas_sci.c                 |  2 +-
 hw/char/sclpconsole-lm.c              |  2 +-
 hw/char/sclpconsole.c                 |  2 +-
 hw/char/sh_serial.c                   |  2 +-
 hw/char/shakti_uart.c                 |  2 +-
 hw/char/stm32f2xx_usart.c             |  2 +-
 hw/char/xilinx_uartlite.c             |  2 +-
 hw/core/or-irq.c                      |  2 +-
 hw/core/qdev.c                        | 58 +++++++--------------------
 hw/cxl/switch-mailbox-cci.c           |  2 +-
 hw/display/artist.c                   |  2 +-
 hw/display/ati.c                      |  2 +-
 hw/display/bcm2835_fb.c               |  2 +-
 hw/display/cg3.c                      |  2 +-
 hw/display/dpcd.c                     |  2 +-
 hw/display/exynos4210_fimd.c          |  2 +-
 hw/display/g364fb.c                   |  2 +-
 hw/display/i2c-ddc.c                  |  2 +-
 hw/display/jazz_led.c                 |  2 +-
 hw/display/macfb.c                    |  4 +-
 hw/display/qxl.c                      |  2 +-
 hw/display/sii9022.c                  |  2 +-
 hw/display/sm501.c                    |  4 +-
 hw/display/tcx.c                      |  2 +-
 hw/display/vga-isa.c                  |  2 +-
 hw/display/vga-mmio.c                 |  2 +-
 hw/display/vga-pci.c                  |  2 +-
 hw/display/vmware_vga.c               |  2 +-
 hw/display/xlnx_dp.c                  |  2 +-
 hw/dma/bcm2835_dma.c                  |  2 +-
 hw/dma/i8257.c                        |  2 +-
 hw/dma/pl080.c                        |  2 +-
 hw/dma/pl330.c                        |  2 +-
 hw/dma/rc4030.c                       |  2 +-
 hw/dma/sparc32_dma.c                  |  2 +-
 hw/dma/xilinx_axidma.c                |  4 +-
 hw/dma/xlnx-zdma.c                    |  2 +-
 hw/dma/xlnx-zynq-devcfg.c             |  2 +-
 hw/dma/xlnx_csu_dma.c                 |  2 +-
 hw/dma/xlnx_dpdma.c                   |  2 +-
 hw/fsi/aspeed_apb2opb.c               |  2 +-
 hw/fsi/fsi-master.c                   |  2 +-
 hw/fsi/fsi.c                          |  2 +-
 hw/fsi/lbus.c                         |  2 +-
 hw/gpio/aspeed_gpio.c                 |  2 +-
 hw/gpio/bcm2835_gpio.c                |  2 +-
 hw/gpio/bcm2838_gpio.c                |  2 +-
 hw/gpio/gpio_key.c                    |  2 +-
 hw/gpio/imx_gpio.c                    |  2 +-
 hw/gpio/max7310.c                     |  2 +-
 hw/gpio/mpc8xxx.c                     |  2 +-
 hw/gpio/nrf51_gpio.c                  |  2 +-
 hw/gpio/omap_gpio.c                   |  4 +-
 hw/gpio/pca9552.c                     |  2 +-
 hw/gpio/pca9554.c                     |  2 +-
 hw/gpio/pcf8574.c                     |  2 +-
 hw/gpio/sifive_gpio.c                 |  2 +-
 hw/hyperv/hyperv.c                    |  2 +-
 hw/hyperv/vmbus.c                     |  2 +-
 hw/i2c/aspeed_i2c.c                   |  4 +-
 hw/i2c/bcm2835_i2c.c                  |  2 +-
 hw/i2c/exynos4210_i2c.c               |  2 +-
 hw/i2c/imx_i2c.c                      |  2 +-
 hw/i2c/microbit_i2c.c                 |  2 +-
 hw/i2c/mpc_i2c.c                      |  2 +-
 hw/i2c/omap_i2c.c                     |  2 +-
 hw/i2c/ppc4xx_i2c.c                   |  2 +-
 hw/i2c/smbus_eeprom.c                 |  2 +-
 hw/i386/amd_iommu.c                   |  2 +-
 hw/i386/intel_iommu.c                 |  2 +-
 hw/i386/kvm/i8254.c                   |  2 +-
 hw/i386/kvm/i8259.c                   |  2 +-
 hw/i386/kvm/ioapic.c                  |  2 +-
 hw/i386/kvm/xen_overlay.c             |  2 +-
 hw/i386/port92.c                      |  2 +-
 hw/i386/vapic.c                       |  2 +-
 hw/i386/vmmouse.c                     |  2 +-
 hw/i386/xen/xen_platform.c            |  2 +-
 hw/ide/ahci.c                         |  2 +-
 hw/ide/cmd646.c                       |  2 +-
 hw/ide/ich.c                          |  2 +-
 hw/ide/isa.c                          |  2 +-
 hw/ide/macio.c                        |  2 +-
 hw/ide/microdrive.c                   |  2 +-
 hw/ide/mmio.c                         |  2 +-
 hw/ide/piix.c                         |  4 +-
 hw/ide/sii3112.c                      |  2 +-
 hw/ide/via.c                          |  2 +-
 hw/input/adb-kbd.c                    |  2 +-
 hw/input/adb-mouse.c                  |  2 +-
 hw/input/lm832x.c                     |  2 +-
 hw/input/pckbd.c                      |  4 +-
 hw/intc/allwinner-a10-pic.c           |  2 +-
 hw/intc/apic_common.c                 |  2 +-
 hw/intc/armv7m_nvic.c                 |  2 +-
 hw/intc/aspeed_intc.c                 |  2 +-
 hw/intc/aspeed_vic.c                  |  2 +-
 hw/intc/bcm2835_ic.c                  |  2 +-
 hw/intc/bcm2836_control.c             |  2 +-
 hw/intc/exynos4210_combiner.c         |  2 +-
 hw/intc/goldfish_pic.c                |  2 +-
 hw/intc/grlib_irqmp.c                 |  2 +-
 hw/intc/heathrow_pic.c                |  2 +-
 hw/intc/i8259.c                       |  2 +-
 hw/intc/imx_avic.c                    |  2 +-
 hw/intc/imx_gpcv2.c                   |  2 +-
 hw/intc/ioapic.c                      |  2 +-
 hw/intc/loongarch_extioi.c            |  2 +-
 hw/intc/loongarch_pch_pic.c           |  2 +-
 hw/intc/m68k_irqc.c                   |  2 +-
 hw/intc/omap_intc.c                   |  4 +-
 hw/intc/openpic.c                     |  2 +-
 hw/intc/openpic_kvm.c                 |  2 +-
 hw/intc/pl190.c                       |  2 +-
 hw/intc/ppc-uic.c                     |  2 +-
 hw/intc/s390_flic.c                   |  2 +-
 hw/intc/s390_flic_kvm.c               |  2 +-
 hw/intc/sifive_plic.c                 |  2 +-
 hw/intc/slavio_intctl.c               |  2 +-
 hw/intc/xlnx-pmu-iomod-intc.c         |  2 +-
 hw/intc/xlnx-zynqmp-ipi.c             |  2 +-
 hw/isa/lpc_ich9.c                     |  2 +-
 hw/isa/pc87312.c                      |  2 +-
 hw/isa/piix.c                         |  2 +-
 hw/isa/vt82c686.c                     | 10 ++---
 hw/m68k/mcf5206.c                     |  2 +-
 hw/m68k/mcf_intc.c                    |  2 +-
 hw/m68k/next-cube.c                   |  2 +-
 hw/m68k/next-kbd.c                    |  2 +-
 hw/mem/cxl_type3.c                    |  2 +-
 hw/misc/a9scu.c                       |  2 +-
 hw/misc/allwinner-cpucfg.c            |  2 +-
 hw/misc/allwinner-h3-ccu.c            |  2 +-
 hw/misc/allwinner-h3-dramc.c          |  2 +-
 hw/misc/allwinner-h3-sysctrl.c        |  2 +-
 hw/misc/allwinner-r40-ccu.c           |  2 +-
 hw/misc/allwinner-r40-dramc.c         |  2 +-
 hw/misc/allwinner-sid.c               |  2 +-
 hw/misc/allwinner-sramc.c             |  2 +-
 hw/misc/applesmc.c                    |  2 +-
 hw/misc/arm_l2x0.c                    |  2 +-
 hw/misc/arm_sysctl.c                  |  2 +-
 hw/misc/armsse-cpu-pwrctrl.c          |  2 +-
 hw/misc/armsse-mhu.c                  |  2 +-
 hw/misc/aspeed_hace.c                 |  2 +-
 hw/misc/aspeed_i3c.c                  |  4 +-
 hw/misc/aspeed_lpc.c                  |  2 +-
 hw/misc/aspeed_peci.c                 |  2 +-
 hw/misc/aspeed_sbc.c                  |  2 +-
 hw/misc/aspeed_scu.c                  | 10 ++---
 hw/misc/aspeed_sdmc.c                 |  4 +-
 hw/misc/aspeed_xdma.c                 |  2 +-
 hw/misc/avr_power.c                   |  2 +-
 hw/misc/bcm2835_cprman.c              |  8 ++--
 hw/misc/bcm2835_mbox.c                |  2 +-
 hw/misc/bcm2835_mphi.c                |  2 +-
 hw/misc/bcm2835_powermgt.c            |  2 +-
 hw/misc/bcm2835_rng.c                 |  2 +-
 hw/misc/bcm2835_thermal.c             |  2 +-
 hw/misc/eccmemctl.c                   |  2 +-
 hw/misc/exynos4210_clk.c              |  2 +-
 hw/misc/exynos4210_pmu.c              |  2 +-
 hw/misc/exynos4210_rng.c              |  2 +-
 hw/misc/imx25_ccm.c                   |  2 +-
 hw/misc/imx31_ccm.c                   |  2 +-
 hw/misc/imx6_ccm.c                    |  2 +-
 hw/misc/imx6_src.c                    |  2 +-
 hw/misc/imx6ul_ccm.c                  |  2 +-
 hw/misc/imx7_ccm.c                    |  4 +-
 hw/misc/imx7_snvs.c                   |  2 +-
 hw/misc/imx7_src.c                    |  2 +-
 hw/misc/imx_rngc.c                    |  2 +-
 hw/misc/iotkit-secctl.c               |  2 +-
 hw/misc/iotkit-sysctl.c               |  2 +-
 hw/misc/ivshmem.c                     |  2 +-
 hw/misc/lasi.c                        |  2 +-
 hw/misc/led.c                         |  2 +-
 hw/misc/macio/cuda.c                  |  2 +-
 hw/misc/macio/gpio.c                  |  2 +-
 hw/misc/macio/mac_dbdma.c             |  2 +-
 hw/misc/macio/pmu.c                   |  2 +-
 hw/misc/mips_cmgcr.c                  |  2 +-
 hw/misc/mips_cpc.c                    |  2 +-
 hw/misc/mips_itu.c                    |  2 +-
 hw/misc/mps2-fpgaio.c                 |  2 +-
 hw/misc/mps2-scc.c                    |  2 +-
 hw/misc/msf2-sysreg.c                 |  2 +-
 hw/misc/nrf51_rng.c                   |  2 +-
 hw/misc/pci-testdev.c                 |  2 +-
 hw/misc/sifive_e_aon.c                |  2 +-
 hw/misc/sifive_u_prci.c               |  2 +-
 hw/misc/slavio_misc.c                 |  2 +-
 hw/misc/stm32f2xx_syscfg.c            |  2 +-
 hw/misc/stm32f4xx_exti.c              |  2 +-
 hw/misc/stm32f4xx_syscfg.c            |  2 +-
 hw/misc/tz-mpc.c                      |  2 +-
 hw/misc/tz-msc.c                      |  2 +-
 hw/misc/tz-ppc.c                      |  2 +-
 hw/misc/virt_ctrl.c                   |  2 +-
 hw/misc/xlnx-versal-cfu.c             |  2 +-
 hw/net/allwinner-sun8i-emac.c         |  2 +-
 hw/net/allwinner_emac.c               |  2 +-
 hw/net/cadence_gem.c                  |  2 +-
 hw/net/can/can_kvaser_pci.c           |  2 +-
 hw/net/can/can_mioe3680_pci.c         |  2 +-
 hw/net/can/can_pcm3680_pci.c          |  2 +-
 hw/net/can/ctucan_pci.c               |  2 +-
 hw/net/can/xlnx-versal-canfd.c        |  2 +-
 hw/net/dp8393x.c                      |  2 +-
 hw/net/etraxfs_eth.c                  |  2 +-
 hw/net/fsl_etsec/etsec.c              |  2 +-
 hw/net/ftgmac100.c                    |  4 +-
 hw/net/imx_fec.c                      |  2 +-
 hw/net/lan9118.c                      |  2 +-
 hw/net/lance.c                        |  2 +-
 hw/net/lasi_i82596.c                  |  2 +-
 hw/net/mcf_fec.c                      |  2 +-
 hw/net/mipsnet.c                      |  2 +-
 hw/net/msf2-emac.c                    |  2 +-
 hw/net/npcm7xx_emc.c                  |  2 +-
 hw/net/npcm_gmac.c                    |  2 +-
 hw/net/opencores_eth.c                |  2 +-
 hw/net/pcnet-pci.c                    |  2 +-
 hw/net/rocker/rocker.c                |  2 +-
 hw/net/rtl8139.c                      |  2 +-
 hw/net/smc91c111.c                    |  2 +-
 hw/net/stellaris_enet.c               |  2 +-
 hw/net/sungem.c                       |  2 +-
 hw/net/sunhme.c                       |  2 +-
 hw/net/tulip.c                        |  2 +-
 hw/net/vmxnet3.c                      |  2 +-
 hw/net/xilinx_axienet.c               |  2 +-
 hw/net/xilinx_ethlite.c               |  2 +-
 hw/nvme/ctrl.c                        |  2 +-
 hw/nvram/eeprom_at24c.c               |  2 +-
 hw/nvram/fw_cfg.c                     |  2 +-
 hw/nvram/mac_nvram.c                  |  2 +-
 hw/nvram/nrf51_nvm.c                  |  2 +-
 hw/pci-bridge/cxl_downstream.c        |  2 +-
 hw/pci-bridge/cxl_upstream.c          |  2 +-
 hw/pci-bridge/i82801b11.c             |  2 +-
 hw/pci-bridge/pci_bridge_dev.c        |  2 +-
 hw/pci-bridge/pci_expander_bridge.c   |  2 +-
 hw/pci-bridge/pcie_pci_bridge.c       |  2 +-
 hw/pci-bridge/simba.c                 |  2 +-
 hw/pci-bridge/xio3130_downstream.c    |  2 +-
 hw/pci-bridge/xio3130_upstream.c      |  2 +-
 hw/pci-host/astro.c                   |  4 +-
 hw/pci-host/designware.c              |  2 +-
 hw/pci-host/dino.c                    |  2 +-
 hw/pci-host/gt64120.c                 |  2 +-
 hw/pci-host/mv64361.c                 |  2 +-
 hw/pci-host/ppc440_pcix.c             |  2 +-
 hw/pci-host/q35.c                     |  2 +-
 hw/pci-host/sabre.c                   |  2 +-
 hw/pci-host/versatile.c               |  2 +-
 hw/pci-host/xilinx-pcie.c             |  2 +-
 hw/ppc/pnv_psi.c                      |  4 +-
 hw/ppc/ppc405_boards.c                |  2 +-
 hw/ppc/ppc405_uc.c                    | 12 +++---
 hw/ppc/ppc4xx_devs.c                  |  6 +--
 hw/ppc/ppc4xx_sdram.c                 |  4 +-
 hw/ppc/ppce500_spin.c                 |  2 +-
 hw/ppc/spapr_cpu_core.c               |  2 +-
 hw/ppc/spapr_iommu.c                  |  2 +-
 hw/ppc/spapr_pci.c                    |  2 +-
 hw/ppc/spapr_vio.c                    |  2 +-
 hw/remote/message.c                   |  5 +--
 hw/remote/proxy.c                     |  2 +-
 hw/rtc/allwinner-rtc.c                |  2 +-
 hw/rtc/aspeed_rtc.c                   |  2 +-
 hw/rtc/ds1338.c                       |  2 +-
 hw/rtc/exynos4210_rtc.c               |  2 +-
 hw/rtc/goldfish_rtc.c                 |  2 +-
 hw/rtc/ls7a_rtc.c                     |  2 +-
 hw/rtc/m48t59-isa.c                   |  2 +-
 hw/rtc/m48t59.c                       |  2 +-
 hw/rtc/xlnx-zynqmp-rtc.c              |  2 +-
 hw/s390x/ccw-device.c                 |  2 +-
 hw/s390x/event-facility.c             |  2 +-
 hw/s390x/ipl.c                        |  2 +-
 hw/s390x/s390-pci-bus.c               |  4 +-
 hw/s390x/sclpquiesce.c                |  2 +-
 hw/s390x/virtio-ccw.c                 | 13 +++---
 hw/scsi/esp-pci.c                     |  2 +-
 hw/scsi/esp.c                         |  2 +-
 hw/scsi/lsi53c895a.c                  |  2 +-
 hw/scsi/megasas.c                     |  2 +-
 hw/scsi/mptsas.c                      |  2 +-
 hw/scsi/scsi-disk.c                   |  2 +-
 hw/scsi/scsi-generic.c                |  2 +-
 hw/scsi/vmw_pvscsi.c                  |  2 +-
 hw/sd/allwinner-sdhost.c              |  2 +-
 hw/sd/aspeed_sdhci.c                  |  2 +-
 hw/sd/bcm2835_sdhost.c                |  2 +-
 hw/sd/cadence_sdhci.c                 |  2 +-
 hw/sd/npcm7xx_sdhci.c                 |  2 +-
 hw/sd/pl181.c                         |  2 +-
 hw/sd/pxa2xx_mmci.c                   |  2 +-
 hw/sd/sd.c                            |  2 +-
 hw/sd/sdhci.c                         |  2 +-
 hw/sd/ssi-sd.c                        |  2 +-
 hw/sensor/dps310.c                    |  2 +-
 hw/sensor/emc141x.c                   |  2 +-
 hw/sensor/lsm303dlhc_mag.c            |  2 +-
 hw/sparc/sun4m_iommu.c                |  2 +-
 hw/sparc64/sun4u_iommu.c              |  2 +-
 hw/ssi/aspeed_smc.c                   |  2 +-
 hw/ssi/bcm2835_spi.c                  |  2 +-
 hw/ssi/ibex_spi_host.c                |  2 +-
 hw/ssi/imx_spi.c                      |  2 +-
 hw/ssi/mss-spi.c                      |  2 +-
 hw/ssi/pl022.c                        |  2 +-
 hw/ssi/pnv_spi.c                      |  2 +-
 hw/ssi/sifive_spi.c                   |  2 +-
 hw/ssi/stm32f2xx_spi.c                |  2 +-
 hw/ssi/xilinx_spi.c                   |  2 +-
 hw/ssi/xilinx_spips.c                 |  4 +-
 hw/ssi/xlnx-versal-ospi.c             |  2 +-
 hw/timer/a9gtimer.c                   |  2 +-
 hw/timer/allwinner-a10-pit.c          |  2 +-
 hw/timer/arm_mptimer.c                |  2 +-
 hw/timer/armv7m_systick.c             |  2 +-
 hw/timer/aspeed_timer.c               |  2 +-
 hw/timer/avr_timer16.c                |  2 +-
 hw/timer/bcm2835_systmr.c             |  2 +-
 hw/timer/cmsdk-apb-dualtimer.c        |  2 +-
 hw/timer/cmsdk-apb-timer.c            |  2 +-
 hw/timer/digic-timer.c                |  2 +-
 hw/timer/exynos4210_mct.c             |  2 +-
 hw/timer/exynos4210_pwm.c             |  2 +-
 hw/timer/grlib_gptimer.c              |  2 +-
 hw/timer/hpet.c                       |  2 +-
 hw/timer/i8254.c                      |  2 +-
 hw/timer/ibex_timer.c                 |  2 +-
 hw/timer/imx_epit.c                   |  2 +-
 hw/timer/imx_gpt.c                    |  2 +-
 hw/timer/nrf51_timer.c                |  2 +-
 hw/timer/renesas_cmt.c                |  2 +-
 hw/timer/renesas_tmr.c                |  2 +-
 hw/timer/sifive_pwm.c                 |  2 +-
 hw/timer/slavio_timer.c               |  2 +-
 hw/timer/sse-counter.c                |  2 +-
 hw/timer/sse-timer.c                  |  2 +-
 hw/timer/stm32f2xx_timer.c            |  2 +-
 hw/tpm/tpm_tis_i2c.c                  |  2 +-
 hw/tpm/tpm_tis_isa.c                  |  2 +-
 hw/tpm/tpm_tis_sysbus.c               |  2 +-
 hw/tricore/tricore_testdevice.c       |  2 +-
 hw/usb/hcd-dwc3.c                     |  2 +-
 hw/usb/hcd-ehci-pci.c                 |  2 +-
 hw/usb/hcd-ehci-sysbus.c              |  2 +-
 hw/usb/hcd-ohci-pci.c                 |  2 +-
 hw/usb/hcd-ohci-sysbus.c              |  2 +-
 hw/usb/hcd-uhci.c                     |  2 +-
 hw/usb/hcd-xhci-pci.c                 |  2 +-
 hw/usb/hcd-xhci-sysbus.c              |  2 +-
 hw/usb/hcd-xhci.c                     |  2 +-
 hw/usb/imx-usb-phy.c                  |  2 +-
 hw/usb/tusb6010.c                     |  2 +-
 hw/vfio/ap.c                          |  2 +-
 hw/vfio/ccw.c                         |  2 +-
 hw/vfio/pci.c                         |  2 +-
 hw/virtio/virtio-mmio.c               |  2 +-
 hw/watchdog/cmsdk-apb-watchdog.c      |  2 +-
 hw/watchdog/sbsa_gwdt.c               |  2 +-
 hw/watchdog/wdt_aspeed.c              |  2 +-
 hw/watchdog/wdt_diag288.c             |  2 +-
 hw/watchdog/wdt_i6300esb.c            |  2 +-
 hw/watchdog/wdt_ib700.c               |  2 +-
 hw/watchdog/wdt_imx2.c                |  2 +-
 target/s390x/cpu.c                    | 38 ++++++++----------
 target/s390x/sigp.c                   |  8 +---
 423 files changed, 553 insertions(+), 569 deletions(-)
 create mode 100644 scripts/coccinelle/device-reset.cocci

-- 
2.34.1


