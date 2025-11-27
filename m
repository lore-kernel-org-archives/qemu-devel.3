Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB769D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObso-0004z8-DZ; Thu, 27 Nov 2025 08:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqe-0002dg-W3
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqa-0001FN-54
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xi2qp9A3OlPda+UIHyZfNuA0l3dvijpMohD+GlNPRrc=;
 b=LdQGuDaUvQgBhx4sHE0JlAdBMurR8sfjpalP3VITlRW+fUg7ckgDLgCs1mADRsrQfY7ccX
 gAj08v2KPxPmWbiSb4Z3Py7wmXXbiQ+cYrvC0AGT1xnFXUxoWaJSnU3tRF8nZFrr7kX+q6
 tAxkOnqjxCDGklE35oNOGNuUlr5Ky1Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-BbpvHOxzOWqMQej-M1LNPA-1; Thu, 27 Nov 2025 08:15:40 -0500
X-MC-Unique: BbpvHOxzOWqMQej-M1LNPA-1
X-Mimecast-MFC-AGG-ID: BbpvHOxzOWqMQej-M1LNPA_1764249339
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b71043a0e4fso81259666b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249339; x=1764854139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xi2qp9A3OlPda+UIHyZfNuA0l3dvijpMohD+GlNPRrc=;
 b=Mx0l5n5WIa2LaNCHivRMzly2yPjLRx/5Nhgi19uvWxDNj4JGIlud772XdKiS1WmNLe
 bXdAX7rIcaNcDt0h2Wv2dcmateAM9U16QSgtY3zw+cUJbUHqSyTZBbViIahvzC+spDH/
 WZhPtqoBMMuqKJ/5GHLG0ybHbAY5U6Nxp7au9bmd3ioSWpUgFVOv0U2uGR8pWJcGktHm
 rfMMhIWCAepUiiKtNCokTPNWM8irSM3mQmz1aGV1GEr8UoSbXEyvOVqqQ7Ns8s4rG+VA
 pLW23M7ifFsO8wZJwebWnxIUroAmR3CfFnVGp12KVp8A3uV2ExDos8atyNl5b9pHy5J5
 euxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249339; x=1764854139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xi2qp9A3OlPda+UIHyZfNuA0l3dvijpMohD+GlNPRrc=;
 b=vGxF8sH3OozCVNcN9s7wf+7EpKBarXMbe5sL6WGza/T4g8yzEz+dxdSZG61kXajFB0
 +SMr6RoReWtRnZvO0RBOJIaDv/cC4NjdBjGJRlwQ3+XXc4wRPH7Rd2mD/Yoay4J/TzDn
 5Pm9o/oIBTHtO3OVhBWwpAyfHYylNm3tk2qd6JJ40cVw77T5P/ywY1/mptfJGoMM8WUp
 olrpEdhA/IXFYVGuFNatU/Vl2pmI86mc8jDfjuvwXXwcqkVK4OEGDUsa1aHnIXoEshFW
 5dHhAyEEC5hij9GPGyf+xrrit93WARBnHrz5En+u8kKnn5Yf4Ej0oW0r61iQjesvyX7Y
 bviQ==
X-Gm-Message-State: AOJu0YxTgICYT86TZNwHuDeR56ns3GUFmhTAwr1cA71PbqZwNvkNL8WM
 HCyjvGy8Qs0c0NajLfIYSV3DMEKaTEXTY5vjL7+2Q6XPVUt7YGIFy50X2Qvx5tp0i3pZ4m6gWth
 4cY17NwWifQdg31oK6ZcvEm8vME3u/M94CEHwiO5NEtIpKXnCGLvmC/7zHl3/hptlv0nmTonya9
 j+lYW7+4SfNBuHECyM2GCdUD4B8S3BlympkIGrwzKF
X-Gm-Gg: ASbGnctqVg7kiYT/e9cpDeU1zSTmZdM0Qb4F2Is972zMAA6NPwW80hoyYQoKp356u7o
 Kgrx8ZeJT6FgZou+r8LrWKAQmjozZc8tANoBCfmj/UaI2sDNtP9CdGt1lj9+NJZtfB1954nWXXn
 xNXYcW+nhqsTwr2E2avuBVG/bwhp+DRREspDZq+HPOue4rlp1mEJIw+S+6MaGcEaNrHCGZkvsO5
 qpNS1qkFvvKELoWoUY1/x4xnbfNLWhi/zMZKpQReadQOt/XesEN0skoabjg19ADjoEeI++erEkC
 Mi3MnWsw2NbfKuLbS7FClTyu/ri47MqNriSoeOv+SCpQKpvwRYnbezoKPV1C3LnPV/n1KMYMmhN
 m2WgYFvvFIn8F4Khpkvg8nv46yrJHr8g8O7nV3PJ6EYsCE3Pzqk65Jdpnp4TQXOuUC3F6j4wvNr
 B73TBKXb8xsnAHjkw=
X-Received: by 2002:a17:907:7245:b0:b76:339d:63ed with SMTP id
 a640c23a62f3a-b767183c00emr2385582866b.52.1764249336744; 
 Thu, 27 Nov 2025 05:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHimDJXLbA1yyJ4NevnRnqnBVnfNLdVEgWKhc1t8HlpFQ6pXyb5R229VfwN7pXU5B9t7Dyplg==
X-Received: by 2002:a17:907:7245:b0:b76:339d:63ed with SMTP id
 a640c23a62f3a-b767183c00emr2385563066b.52.1764249334497; 
 Thu, 27 Nov 2025 05:15:34 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f51c55e9sm158136166b.26.2025.11.27.05.15.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/28] include: move hw/irq.h to hw/core/
Date: Thu, 27 Nov 2025 14:14:56 +0100
Message-ID: <20251127131516.80807-10-pbonzini@redhat.com>
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
 hw/net/pcnet.h                       | 2 +-
 hw/scsi/ncr53c710.h                  | 2 +-
 hw/usb/hcd-dwc2.h                    | 2 +-
 include/hw/adc/npcm7xx_adc.h         | 2 +-
 include/hw/char/parallel.h           | 2 +-
 include/hw/{ => core}/irq.h          | 0
 include/hw/display/macfb.h           | 2 +-
 include/hw/i2c/npcm7xx_smbus.h       | 2 +-
 include/hw/ide/ahci-pci.h            | 2 +-
 include/hw/input/pl050.h             | 2 +-
 include/hw/ipack/ipack.h             | 2 +-
 include/hw/misc/bcm2835_mphi.h       | 2 +-
 include/hw/misc/npcm7xx_mft.h        | 2 +-
 include/hw/misc/npcm7xx_pwm.h        | 2 +-
 include/hw/misc/xlnx-versal-trng.h   | 2 +-
 include/hw/net/imx_fec.h             | 2 +-
 include/hw/net/npcm7xx_emc.h         | 2 +-
 include/hw/net/npcm_gmac.h           | 2 +-
 include/hw/nvram/xlnx-bbram.h        | 2 +-
 include/hw/nvram/xlnx-versal-efuse.h | 2 +-
 include/hw/nvram/xlnx-zynqmp-efuse.h | 2 +-
 include/hw/ppc/spapr_vio.h           | 2 +-
 include/hw/qdev-core.h               | 2 +-
 include/hw/timer/bcm2835_systmr.h    | 2 +-
 include/hw/timer/stellaris-gptm.h    | 2 +-
 include/hw/watchdog/sbsa_gwdt.h      | 2 +-
 include/hw/watchdog/wdt_imx2.h       | 2 +-
 rust/hw/core/wrapper.h               | 2 +-
 accel/kvm/kvm-all.c                  | 2 +-
 hw/acpi/core.c                       | 2 +-
 hw/acpi/generic_event_device.c       | 2 +-
 hw/acpi/piix4.c                      | 2 +-
 hw/adc/aspeed_adc.c                  | 2 +-
 hw/adc/zynq-xadc.c                   | 2 +-
 hw/alpha/typhoon.c                   | 2 +-
 hw/arm/armsse.c                      | 2 +-
 hw/arm/exynos4210.c                  | 2 +-
 hw/arm/exynos4_boards.c              | 2 +-
 hw/arm/integratorcp.c                | 2 +-
 hw/arm/mps2-tz.c                     | 2 +-
 hw/arm/musicpal.c                    | 2 +-
 hw/arm/omap1.c                       | 2 +-
 hw/arm/realview.c                    | 2 +-
 hw/arm/smmuv3.c                      | 2 +-
 hw/arm/stellaris.c                   | 2 +-
 hw/arm/strongarm.c                   | 2 +-
 hw/arm/versatilepb.c                 | 2 +-
 hw/arm/virt.c                        | 2 +-
 hw/audio/asc.c                       | 2 +-
 hw/audio/cs4231a.c                   | 2 +-
 hw/audio/gus.c                       | 2 +-
 hw/audio/marvell_88w8618.c           | 2 +-
 hw/audio/pl041.c                     | 2 +-
 hw/audio/sb16.c                      | 2 +-
 hw/block/fdc-isa.c                   | 2 +-
 hw/block/fdc.c                       | 2 +-
 hw/char/avr_usart.c                  | 2 +-
 hw/char/bcm2835_aux.c                | 2 +-
 hw/char/cadence_uart.c               | 2 +-
 hw/char/cmsdk-apb-uart.c             | 2 +-
 hw/char/diva-gsp.c                   | 2 +-
 hw/char/escc.c                       | 2 +-
 hw/char/exynos4210_uart.c            | 2 +-
 hw/char/goldfish_tty.c               | 2 +-
 hw/char/grlib_apbuart.c              | 2 +-
 hw/char/ibex_uart.c                  | 2 +-
 hw/char/imx_serial.c                 | 2 +-
 hw/char/ipoctal232.c                 | 2 +-
 hw/char/max78000_uart.c              | 2 +-
 hw/char/mcf_uart.c                   | 2 +-
 hw/char/nrf51_uart.c                 | 2 +-
 hw/char/pl011.c                      | 2 +-
 hw/char/renesas_sci.c                | 2 +-
 hw/char/serial-pci-multi.c           | 2 +-
 hw/char/serial-pci.c                 | 2 +-
 hw/char/serial.c                     | 2 +-
 hw/char/sh_serial.c                  | 2 +-
 hw/char/sifive_uart.c                | 2 +-
 hw/char/stm32f2xx_usart.c            | 2 +-
 hw/char/stm32l4x5_usart.c            | 2 +-
 hw/char/xilinx_uartlite.c            | 2 +-
 hw/core/gpio.c                       | 2 +-
 hw/core/irq.c                        | 2 +-
 hw/core/or-irq.c                     | 2 +-
 hw/core/qdev.c                       | 2 +-
 hw/core/split-irq.c                  | 2 +-
 hw/cpu/a15mpcore.c                   | 2 +-
 hw/cpu/a9mpcore.c                    | 2 +-
 hw/cpu/arm11mpcore.c                 | 2 +-
 hw/cpu/realview_mpcore.c             | 2 +-
 hw/display/bcm2835_fb.c              | 2 +-
 hw/display/cg3.c                     | 2 +-
 hw/display/dm163.c                   | 2 +-
 hw/display/exynos4210_fimd.c         | 2 +-
 hw/display/g364fb.c                  | 2 +-
 hw/display/omap_lcdc.c               | 2 +-
 hw/display/pl110.c                   | 2 +-
 hw/display/xlnx_dp.c                 | 2 +-
 hw/dma/bcm2835_dma.c                 | 2 +-
 hw/dma/omap_dma.c                    | 2 +-
 hw/dma/pl080.c                       | 2 +-
 hw/dma/pl330.c                       | 2 +-
 hw/dma/rc4030.c                      | 2 +-
 hw/dma/sifive_pdma.c                 | 2 +-
 hw/dma/sparc32_dma.c                 | 2 +-
 hw/dma/xilinx_axidma.c               | 2 +-
 hw/dma/xlnx-zdma.c                   | 2 +-
 hw/dma/xlnx-zynq-devcfg.c            | 2 +-
 hw/dma/xlnx_csu_dma.c                | 2 +-
 hw/dma/xlnx_dpdma.c                  | 2 +-
 hw/gpio/aspeed_gpio.c                | 2 +-
 hw/gpio/bcm2835_gpio.c               | 2 +-
 hw/gpio/bcm2838_gpio.c               | 2 +-
 hw/gpio/gpio_key.c                   | 2 +-
 hw/gpio/imx_gpio.c                   | 2 +-
 hw/gpio/mpc8xxx.c                    | 2 +-
 hw/gpio/npcm7xx_gpio.c               | 2 +-
 hw/gpio/nrf51_gpio.c                 | 2 +-
 hw/gpio/omap_gpio.c                  | 2 +-
 hw/gpio/pca9552.c                    | 2 +-
 hw/gpio/pca9554.c                    | 2 +-
 hw/gpio/pcf8574.c                    | 2 +-
 hw/gpio/pl061.c                      | 2 +-
 hw/gpio/sifive_gpio.c                | 2 +-
 hw/gpio/stm32l4x5_gpio.c             | 2 +-
 hw/gpio/zaurus.c                     | 2 +-
 hw/i2c/allwinner-i2c.c               | 2 +-
 hw/i2c/aspeed_i2c.c                  | 2 +-
 hw/i2c/bcm2835_i2c.c                 | 2 +-
 hw/i2c/bitbang_i2c.c                 | 2 +-
 hw/i2c/exynos4210_i2c.c              | 2 +-
 hw/i2c/imx_i2c.c                     | 2 +-
 hw/i2c/mpc_i2c.c                     | 2 +-
 hw/i2c/omap_i2c.c                    | 2 +-
 hw/i2c/ppc4xx_i2c.c                  | 2 +-
 hw/i386/kvm/i8259.c                  | 2 +-
 hw/i386/kvm/xen_evtchn.c             | 2 +-
 hw/i386/microvm.c                    | 2 +-
 hw/i386/pc_piix.c                    | 2 +-
 hw/i386/port92.c                     | 2 +-
 hw/i386/x86-common.c                 | 2 +-
 hw/i386/x86-cpu.c                    | 2 +-
 hw/i386/xen/xen-hvm.c                | 2 +-
 hw/ide/ahci.c                        | 2 +-
 hw/ide/core.c                        | 2 +-
 hw/ide/macio.c                       | 2 +-
 hw/ide/pci.c                         | 2 +-
 hw/ide/via.c                         | 2 +-
 hw/input/lasips2.c                   | 2 +-
 hw/input/pckbd.c                     | 2 +-
 hw/input/pl050.c                     | 2 +-
 hw/input/ps2.c                       | 2 +-
 hw/input/stellaris_gamepad.c         | 2 +-
 hw/intc/allwinner-a10-pic.c          | 2 +-
 hw/intc/arm_gic.c                    | 2 +-
 hw/intc/arm_gicv2m.c                 | 2 +-
 hw/intc/arm_gicv3_cpuif.c            | 2 +-
 hw/intc/armv7m_nvic.c                | 2 +-
 hw/intc/aspeed_intc.c                | 2 +-
 hw/intc/aspeed_vic.c                 | 2 +-
 hw/intc/bcm2835_ic.c                 | 2 +-
 hw/intc/bcm2836_control.c            | 2 +-
 hw/intc/exynos4210_combiner.c        | 2 +-
 hw/intc/exynos4210_gic.c             | 2 +-
 hw/intc/goldfish_pic.c               | 2 +-
 hw/intc/grlib_irqmp.c                | 2 +-
 hw/intc/heathrow_pic.c               | 2 +-
 hw/intc/i8259.c                      | 2 +-
 hw/intc/imx_avic.c                   | 2 +-
 hw/intc/loongarch_dintc.c            | 2 +-
 hw/intc/loongarch_extioi.c           | 2 +-
 hw/intc/loongarch_pch_msi.c          | 2 +-
 hw/intc/loongarch_pch_pic.c          | 2 +-
 hw/intc/loongson_ipi_common.c        | 2 +-
 hw/intc/loongson_liointc.c           | 2 +-
 hw/intc/mips_gic.c                   | 2 +-
 hw/intc/omap_intc.c                  | 2 +-
 hw/intc/ompic.c                      | 2 +-
 hw/intc/openpic.c                    | 2 +-
 hw/intc/pl190.c                      | 2 +-
 hw/intc/ppc-uic.c                    | 2 +-
 hw/intc/realview_gic.c               | 2 +-
 hw/intc/riscv_aclint.c               | 2 +-
 hw/intc/riscv_aplic.c                | 2 +-
 hw/intc/riscv_imsic.c                | 2 +-
 hw/intc/rx_icu.c                     | 2 +-
 hw/intc/sh_intc.c                    | 2 +-
 hw/intc/sifive_plic.c                | 2 +-
 hw/intc/slavio_intctl.c              | 2 +-
 hw/intc/xics.c                       | 2 +-
 hw/intc/xilinx_intc.c                | 2 +-
 hw/intc/xive.c                       | 2 +-
 hw/intc/xlnx-pmu-iomod-intc.c        | 2 +-
 hw/intc/xlnx-zynqmp-ipi.c            | 2 +-
 hw/ipack/ipack.c                     | 2 +-
 hw/ipack/tpci200.c                   | 2 +-
 hw/ipmi/isa_ipmi_bt.c                | 2 +-
 hw/ipmi/isa_ipmi_kcs.c               | 2 +-
 hw/isa/i82378.c                      | 2 +-
 hw/isa/lpc_ich9.c                    | 2 +-
 hw/isa/piix.c                        | 2 +-
 hw/isa/vt82c686.c                    | 2 +-
 hw/loongarch/virt.c                  | 2 +-
 hw/m68k/mcf5206.c                    | 2 +-
 hw/m68k/mcf5208.c                    | 2 +-
 hw/m68k/mcf_intc.c                   | 2 +-
 hw/m68k/next-cube.c                  | 2 +-
 hw/m68k/q800-glue.c                  | 2 +-
 hw/mips/malta.c                      | 2 +-
 hw/mips/mips_int.c                   | 2 +-
 hw/misc/arm_sysctl.c                 | 2 +-
 hw/misc/armsse-mhu.c                 | 2 +-
 hw/misc/aspeed_hace.c                | 2 +-
 hw/misc/aspeed_lpc.c                 | 2 +-
 hw/misc/aspeed_peci.c                | 2 +-
 hw/misc/aspeed_xdma.c                | 2 +-
 hw/misc/avr_power.c                  | 2 +-
 hw/misc/bcm2835_mbox.c               | 2 +-
 hw/misc/bcm2835_property.c           | 2 +-
 hw/misc/eccmemctl.c                  | 2 +-
 hw/misc/imx_rngc.c                   | 2 +-
 hw/misc/iotkit-secctl.c              | 2 +-
 hw/misc/ivshmem-flat.c               | 2 +-
 hw/misc/lasi.c                       | 2 +-
 hw/misc/mac_via.c                    | 2 +-
 hw/misc/macio/cuda.c                 | 2 +-
 hw/misc/macio/gpio.c                 | 2 +-
 hw/misc/macio/mac_dbdma.c            | 2 +-
 hw/misc/macio/pmu.c                  | 2 +-
 hw/misc/max78000_aes.c               | 2 +-
 hw/misc/max78000_gcr.c               | 2 +-
 hw/misc/max78000_icc.c               | 2 +-
 hw/misc/max78000_trng.c              | 2 +-
 hw/misc/mchp_pfsoc_ioscb.c           | 2 +-
 hw/misc/mchp_pfsoc_sysreg.c          | 2 +-
 hw/misc/mos6522.c                    | 2 +-
 hw/misc/mps2-scc.c                   | 2 +-
 hw/misc/npcm7xx_mft.c                | 2 +-
 hw/misc/npcm7xx_pwm.c                | 2 +-
 hw/misc/nrf51_rng.c                  | 2 +-
 hw/misc/omap_clk.c                   | 2 +-
 hw/misc/pc-testdev.c                 | 2 +-
 hw/misc/sifive_e_aon.c               | 2 +-
 hw/misc/slavio_misc.c                | 2 +-
 hw/misc/stm32_rcc.c                  | 2 +-
 hw/misc/stm32f4xx_exti.c             | 2 +-
 hw/misc/stm32f4xx_syscfg.c           | 2 +-
 hw/misc/stm32l4x5_exti.c             | 2 +-
 hw/misc/stm32l4x5_rcc.c              | 2 +-
 hw/misc/stm32l4x5_syscfg.c           | 2 +-
 hw/misc/tz-mpc.c                     | 2 +-
 hw/misc/tz-msc.c                     | 2 +-
 hw/misc/tz-ppc.c                     | 2 +-
 hw/misc/xlnx-versal-cframe-reg.c     | 2 +-
 hw/misc/xlnx-versal-cfu.c            | 2 +-
 hw/misc/xlnx-versal-crl.c            | 2 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c   | 2 +-
 hw/misc/xlnx-versal-xramc.c          | 2 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c       | 2 +-
 hw/misc/xlnx-zynqmp-crf.c            | 2 +-
 hw/net/allwinner-sun8i-emac.c        | 2 +-
 hw/net/allwinner_emac.c              | 2 +-
 hw/net/cadence_gem.c                 | 2 +-
 hw/net/can/can_kvaser_pci.c          | 2 +-
 hw/net/can/can_mioe3680_pci.c        | 2 +-
 hw/net/can/can_pcm3680_pci.c         | 2 +-
 hw/net/can/can_sja1000.c             | 2 +-
 hw/net/can/ctucan_core.c             | 2 +-
 hw/net/can/ctucan_pci.c              | 2 +-
 hw/net/can/xlnx-versal-canfd.c       | 2 +-
 hw/net/can/xlnx-zynqmp-can.c         | 2 +-
 hw/net/dp8393x.c                     | 2 +-
 hw/net/fsl_etsec/etsec.c             | 2 +-
 hw/net/ftgmac100.c                   | 2 +-
 hw/net/i82596.c                      | 2 +-
 hw/net/imx_fec.c                     | 2 +-
 hw/net/lan9118.c                     | 2 +-
 hw/net/lan9118_phy.c                 | 2 +-
 hw/net/mcf_fec.c                     | 2 +-
 hw/net/msf2-emac.c                   | 2 +-
 hw/net/mv88w8618_eth.c               | 2 +-
 hw/net/ne2000-pci.c                  | 2 +-
 hw/net/ne2000.c                      | 2 +-
 hw/net/npcm7xx_emc.c                 | 2 +-
 hw/net/opencores_eth.c               | 2 +-
 hw/net/pcnet-pci.c                   | 2 +-
 hw/net/pcnet.c                       | 2 +-
 hw/net/smc91c111.c                   | 2 +-
 hw/net/stellaris_enet.c              | 2 +-
 hw/net/tulip.c                       | 2 +-
 hw/net/xgmac.c                       | 2 +-
 hw/net/xilinx_axienet.c              | 2 +-
 hw/net/xilinx_ethlite.c              | 2 +-
 hw/nubus/nubus-device.c              | 2 +-
 hw/openrisc/openrisc_sim.c           | 2 +-
 hw/openrisc/virt.c                   | 2 +-
 hw/pci-host/articia.c                | 2 +-
 hw/pci-host/aspeed_pcie.c            | 2 +-
 hw/pci-host/astro.c                  | 2 +-
 hw/pci-host/bonito.c                 | 2 +-
 hw/pci-host/designware.c             | 2 +-
 hw/pci-host/dino.c                   | 2 +-
 hw/pci-host/gpex.c                   | 2 +-
 hw/pci-host/grackle.c                | 2 +-
 hw/pci-host/gt64120.c                | 2 +-
 hw/pci-host/mv64361.c                | 2 +-
 hw/pci-host/pnv_phb3.c               | 2 +-
 hw/pci-host/pnv_phb3_msi.c           | 2 +-
 hw/pci-host/pnv_phb4.c               | 2 +-
 hw/pci-host/ppc440_pcix.c            | 2 +-
 hw/pci-host/ppc4xx_pci.c             | 2 +-
 hw/pci-host/ppce500.c                | 2 +-
 hw/pci-host/raven.c                  | 2 +-
 hw/pci-host/sabre.c                  | 2 +-
 hw/pci-host/sh_pci.c                 | 2 +-
 hw/pci-host/uninorth.c               | 2 +-
 hw/pci-host/versatile.c              | 2 +-
 hw/pci-host/xilinx-pcie.c            | 2 +-
 hw/pci/pci.c                         | 2 +-
 hw/ppc/e500.c                        | 2 +-
 hw/ppc/pegasos.c                     | 2 +-
 hw/ppc/pnv_chiptod.c                 | 2 +-
 hw/ppc/pnv_i2c.c                     | 2 +-
 hw/ppc/pnv_lpc.c                     | 2 +-
 hw/ppc/pnv_occ.c                     | 2 +-
 hw/ppc/pnv_psi.c                     | 2 +-
 hw/ppc/pnv_sbe.c                     | 2 +-
 hw/ppc/ppc.c                         | 2 +-
 hw/ppc/ppc440_uc.c                   | 2 +-
 hw/ppc/ppc4xx_sdram.c                | 2 +-
 hw/ppc/prep_systemio.c               | 2 +-
 hw/ppc/spapr_events.c                | 2 +-
 hw/ppc/spapr_irq.c                   | 2 +-
 hw/ppc/spapr_pci.c                   | 2 +-
 hw/riscv/riscv-iommu-sys.c           | 2 +-
 hw/riscv/sifive_u.c                  | 2 +-
 hw/rtc/exynos4210_rtc.c              | 2 +-
 hw/rtc/goldfish_rtc.c                | 2 +-
 hw/rtc/ls7a_rtc.c                    | 2 +-
 hw/rtc/m48t59.c                      | 2 +-
 hw/rtc/mc146818rtc.c                 | 2 +-
 hw/rtc/pl031.c                       | 2 +-
 hw/rtc/xlnx-zynqmp-rtc.c             | 2 +-
 hw/scsi/esp-pci.c                    | 2 +-
 hw/scsi/esp.c                        | 2 +-
 hw/scsi/lsi53c895a.c                 | 2 +-
 hw/scsi/ncr53c710.c                  | 2 +-
 hw/sd/allwinner-sdhost.c             | 2 +-
 hw/sd/aspeed_sdhci.c                 | 2 +-
 hw/sd/bcm2835_sdhost.c               | 2 +-
 hw/sd/omap_mmc.c                     | 2 +-
 hw/sd/pl181.c                        | 2 +-
 hw/sd/sd.c                           | 2 +-
 hw/sd/sdhci-pci.c                    | 2 +-
 hw/sd/sdhci.c                        | 2 +-
 hw/sensor/adm1266.c                  | 2 +-
 hw/sensor/adm1272.c                  | 2 +-
 hw/sensor/max31785.c                 | 2 +-
 hw/sensor/max34451.c                 | 2 +-
 hw/sensor/tmp105.c                   | 2 +-
 hw/sh4/r2d.c                         | 2 +-
 hw/sh4/sh7750.c                      | 2 +-
 hw/sparc/leon3.c                     | 2 +-
 hw/sparc/sun4m.c                     | 2 +-
 hw/sparc/sun4m_iommu.c               | 2 +-
 hw/sparc64/sun4u.c                   | 2 +-
 hw/ssi/allwinner-a10-spi.c           | 2 +-
 hw/ssi/aspeed_smc.c                  | 2 +-
 hw/ssi/bcm2835_spi.c                 | 2 +-
 hw/ssi/ibex_spi_host.c               | 2 +-
 hw/ssi/imx_spi.c                     | 2 +-
 hw/ssi/mss-spi.c                     | 2 +-
 hw/ssi/npcm7xx_fiu.c                 | 2 +-
 hw/ssi/npcm_pspi.c                   | 2 +-
 hw/ssi/pl022.c                       | 2 +-
 hw/ssi/pnv_spi.c                     | 2 +-
 hw/ssi/sifive_spi.c                  | 2 +-
 hw/ssi/xilinx_spi.c                  | 2 +-
 hw/ssi/xilinx_spips.c                | 2 +-
 hw/ssi/xlnx-versal-ospi.c            | 2 +-
 hw/timer/a9gtimer.c                  | 2 +-
 hw/timer/allwinner-a10-pit.c         | 2 +-
 hw/timer/arm_mptimer.c               | 2 +-
 hw/timer/arm_timer.c                 | 2 +-
 hw/timer/armv7m_systick.c            | 2 +-
 hw/timer/aspeed_timer.c              | 2 +-
 hw/timer/avr_timer16.c               | 2 +-
 hw/timer/cadence_ttc.c               | 2 +-
 hw/timer/cmsdk-apb-dualtimer.c       | 2 +-
 hw/timer/cmsdk-apb-timer.c           | 2 +-
 hw/timer/exynos4210_mct.c            | 2 +-
 hw/timer/exynos4210_pwm.c            | 2 +-
 hw/timer/grlib_gptimer.c             | 2 +-
 hw/timer/hpet.c                      | 2 +-
 hw/timer/i8254.c                     | 2 +-
 hw/timer/ibex_timer.c                | 2 +-
 hw/timer/imx_epit.c                  | 2 +-
 hw/timer/imx_gpt.c                   | 2 +-
 hw/timer/mss-timer.c                 | 2 +-
 hw/timer/npcm7xx_timer.c             | 2 +-
 hw/timer/nrf51_timer.c               | 2 +-
 hw/timer/pxa2xx_timer.c              | 2 +-
 hw/timer/renesas_cmt.c               | 2 +-
 hw/timer/renesas_tmr.c               | 2 +-
 hw/timer/sh_timer.c                  | 2 +-
 hw/timer/sifive_pwm.c                | 2 +-
 hw/timer/slavio_timer.c              | 2 +-
 hw/timer/sse-timer.c                 | 2 +-
 hw/timer/stm32f2xx_timer.c           | 2 +-
 hw/timer/xilinx_timer.c              | 2 +-
 hw/tpm/tpm_tis_common.c              | 2 +-
 hw/ufs/ufs.c                         | 2 +-
 hw/usb/hcd-ehci.c                    | 2 +-
 hw/usb/hcd-ohci-sysbus.c             | 2 +-
 hw/usb/hcd-ohci.c                    | 2 +-
 hw/usb/hcd-uhci.c                    | 2 +-
 hw/usb/hcd-xhci-sysbus.c             | 2 +-
 hw/usb/vt82c686-uhci-pci.c           | 2 +-
 hw/usb/xlnx-versal-usb2-ctrl-regs.c  | 2 +-
 hw/virtio/virtio-mmio.c              | 2 +-
 hw/vmapple/aes.c                     | 2 +-
 hw/vmapple/vmapple.c                 | 2 +-
 hw/watchdog/cmsdk-apb-watchdog.c     | 2 +-
 hw/xen/xen-pvh-common.c              | 2 +-
 hw/xtensa/mx_pic.c                   | 2 +-
 hw/xtensa/pic_cpu.c                  | 2 +-
 system/qtest.c                       | 2 +-
 target/arm/cpregs-gcs.c              | 2 +-
 target/arm/cpregs-pmu.c              | 2 +-
 target/arm/helper.c                  | 2 +-
 target/arm/hvf/hvf.c                 | 2 +-
 target/arm/kvm.c                     | 2 +-
 target/i386/tcg/system/fpu_helper.c  | 2 +-
 target/loongarch/kvm/kvm.c           | 2 +-
 target/loongarch/tcg/csr_helper.c    | 2 +-
 target/mips/system/cp0_timer.c       | 2 +-
 target/riscv/kvm/kvm-cpu.c           | 2 +-
 target/rx/helper.c                   | 2 +-
 hw/display/apple-gfx-mmio.m          | 2 +-
 439 files changed, 438 insertions(+), 438 deletions(-)
 rename include/hw/{ => core}/irq.h (100%)

diff --git a/hw/net/pcnet.h b/hw/net/pcnet.h
index a94356ec30b..d12e7cbf9e2 100644
--- a/hw/net/pcnet.h
+++ b/hw/net/pcnet.h
@@ -8,7 +8,7 @@
 #define PCNET_LOOPTEST_NOCRC    2
 
 #include "system/memory.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 /* BUS CONFIGURATION REGISTERS */
 #define BCR_MSRDA    0
diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 6d30f9b6632..9ae64a182d5 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -21,7 +21,7 @@
 #include "qemu/fifo8.h"
 #include "qom/object.h"
 #include "system/memory.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/timer.h"
 
 #define TYPE_NCR710_SCSI "ncr710-scsi"
diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
index 0c02392ade0..a99409a654b 100644
--- a/hw/usb/hcd-dwc2.h
+++ b/hw/usb/hcd-dwc2.h
@@ -20,7 +20,7 @@
 #define HW_USB_HCD_DWC2_H
 
 #include "qemu/timer.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/usb/usb.h"
 #include "system/dma.h"
diff --git a/include/hw/adc/npcm7xx_adc.h b/include/hw/adc/npcm7xx_adc.h
index a0c56d42365..02dc1902fce 100644
--- a/include/hw/adc/npcm7xx_adc.h
+++ b/include/hw/adc/npcm7xx_adc.h
@@ -17,7 +17,7 @@
 #define NPCM7XX_ADC_H
 
 #include "hw/core/clock.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 
diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index 3f8d9b59a76..f2c92eb5bc0 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -3,7 +3,7 @@
 
 #include "system/memory.h"
 #include "hw/isa/isa.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "chardev/char-fe.h"
 #include "chardev/char.h"
 
diff --git a/include/hw/irq.h b/include/hw/core/irq.h
similarity index 100%
rename from include/hw/irq.h
rename to include/hw/core/irq.h
diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
index 0fae1f33a65..356a03ce31a 100644
--- a/include/hw/display/macfb.h
+++ b/include/hw/display/macfb.h
@@ -14,7 +14,7 @@
 #define MACFB_H
 
 #include "system/memory.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/nubus/nubus.h"
 #include "hw/sysbus.h"
 #include "ui/console.h"
diff --git a/include/hw/i2c/npcm7xx_smbus.h b/include/hw/i2c/npcm7xx_smbus.h
index 9c544c561b7..f5adb69c672 100644
--- a/include/hw/i2c/npcm7xx_smbus.h
+++ b/include/hw/i2c/npcm7xx_smbus.h
@@ -18,7 +18,7 @@
 
 #include "system/memory.h"
 #include "hw/i2c/i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 
 /*
diff --git a/include/hw/ide/ahci-pci.h b/include/hw/ide/ahci-pci.h
index face1a9a4a4..85cd899abe5 100644
--- a/include/hw/ide/ahci-pci.h
+++ b/include/hw/ide/ahci-pci.h
@@ -9,7 +9,7 @@
 #include "qom/object.h"
 #include "hw/ide/ahci.h"
 #include "hw/pci/pci_device.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 #define TYPE_ICH9_AHCI "ich9-ahci"
 OBJECT_DECLARE_SIMPLE_TYPE(AHCIPCIState, ICH9_AHCI)
diff --git a/include/hw/input/pl050.h b/include/hw/input/pl050.h
index 4cb8985f31a..db662654c58 100644
--- a/include/hw/input/pl050.h
+++ b/include/hw/input/pl050.h
@@ -13,7 +13,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/input/ps2.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 struct PL050DeviceClass {
     SysBusDeviceClass parent_class;
diff --git a/include/hw/ipack/ipack.h b/include/hw/ipack/ipack.h
index 00f397fd020..d86ef84233c 100644
--- a/include/hw/ipack/ipack.h
+++ b/include/hw/ipack/ipack.h
@@ -12,7 +12,7 @@
 #define QEMU_IPACK_H
 
 #include "hw/qdev-core.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qom/object.h"
 
 
diff --git a/include/hw/misc/bcm2835_mphi.h b/include/hw/misc/bcm2835_mphi.h
index 3f1997e5f24..1a451685e8e 100644
--- a/include/hw/misc/bcm2835_mphi.h
+++ b/include/hw/misc/bcm2835_mphi.h
@@ -17,7 +17,7 @@
 #ifndef HW_MISC_BCM2835_MPHI_H
 #define HW_MISC_BCM2835_MPHI_H
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
diff --git a/include/hw/misc/npcm7xx_mft.h b/include/hw/misc/npcm7xx_mft.h
index 54a2c2a82e6..79855b6f25d 100644
--- a/include/hw/misc/npcm7xx_mft.h
+++ b/include/hw/misc/npcm7xx_mft.h
@@ -18,7 +18,7 @@
 
 #include "system/memory.h"
 #include "hw/core/clock.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
diff --git a/include/hw/misc/npcm7xx_pwm.h b/include/hw/misc/npcm7xx_pwm.h
index f697a77cdca..6a54b40005d 100644
--- a/include/hw/misc/npcm7xx_pwm.h
+++ b/include/hw/misc/npcm7xx_pwm.h
@@ -18,7 +18,7 @@
 
 #include "hw/core/clock.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 /* Each PWM module holds 4 PWM channels. */
 #define NPCM7XX_PWM_PER_MODULE 4
diff --git a/include/hw/misc/xlnx-versal-trng.h b/include/hw/misc/xlnx-versal-trng.h
index d96f8f9eff3..4e516216dbe 100644
--- a/include/hw/misc/xlnx-versal-trng.h
+++ b/include/hw/misc/xlnx-versal-trng.h
@@ -26,7 +26,7 @@
 #ifndef XLNX_VERSAL_TRNG_H
 #define XLNX_VERSAL_TRNG_H
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
 
diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 83b21637eeb..99fc285402c 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -32,7 +32,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXFECState, IMX_FEC)
 
 #include "hw/sysbus.h"
 #include "hw/net/lan9118_phy.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "net/net.h"
 
 #define ENET_EIR               1
diff --git a/include/hw/net/npcm7xx_emc.h b/include/hw/net/npcm7xx_emc.h
index b789007160a..03c9941d82d 100644
--- a/include/hw/net/npcm7xx_emc.h
+++ b/include/hw/net/npcm7xx_emc.h
@@ -17,7 +17,7 @@
 #ifndef NPCM7XX_EMC_H
 #define NPCM7XX_EMC_H
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 
diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
index 6340ffe92ca..44ee7b1bcba 100644
--- a/include/hw/net/npcm_gmac.h
+++ b/include/hw/net/npcm_gmac.h
@@ -20,7 +20,7 @@
 #ifndef NPCM_GMAC_H
 #define NPCM_GMAC_H
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 
diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
index af90900bfc6..ad2e4a250f5 100644
--- a/include/hw/nvram/xlnx-bbram.h
+++ b/include/hw/nvram/xlnx-bbram.h
@@ -28,7 +28,7 @@
 
 #include "system/block-backend.h"
 #include "hw/qdev-core.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
 
diff --git a/include/hw/nvram/xlnx-versal-efuse.h b/include/hw/nvram/xlnx-versal-efuse.h
index afa4f4f9960..37d09da4809 100644
--- a/include/hw/nvram/xlnx-versal-efuse.h
+++ b/include/hw/nvram/xlnx-versal-efuse.h
@@ -22,7 +22,7 @@
 #ifndef XLNX_VERSAL_EFUSE_H
 #define XLNX_VERSAL_EFUSE_H
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
 #include "hw/nvram/xlnx-efuse.h"
diff --git a/include/hw/nvram/xlnx-zynqmp-efuse.h b/include/hw/nvram/xlnx-zynqmp-efuse.h
index 7fb12df3fbb..6eb3fea8fa2 100644
--- a/include/hw/nvram/xlnx-zynqmp-efuse.h
+++ b/include/hw/nvram/xlnx-zynqmp-efuse.h
@@ -22,7 +22,7 @@
 #ifndef XLNX_ZYNQMP_EFUSE_H
 #define XLNX_ZYNQMP_EFUSE_H
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
 #include "hw/nvram/xlnx-efuse.h"
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index b8de4b06fb1..0ea0dbae8b1 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -24,7 +24,7 @@
 
 #include "hw/ppc/spapr.h"
 #include "system/dma.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qom/object.h"
 
 #define TYPE_VIO_SPAPR_DEVICE "vio-spapr-device"
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 8170836d432..da93611d373 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -8,7 +8,7 @@
 #include "qemu/rcu_queue.h"
 #include "qom/object.h"
 #include "hw/core/hotplug.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/resettable.h"
 
 /**
diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index a8f605beeb6..93cb3415a68 100644
--- a/include/hw/timer/bcm2835_systmr.h
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -10,7 +10,7 @@
 #define BCM2835_SYSTMR_H
 
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
 
diff --git a/include/hw/timer/stellaris-gptm.h b/include/hw/timer/stellaris-gptm.h
index c705508b829..9d663b58dfa 100644
--- a/include/hw/timer/stellaris-gptm.h
+++ b/include/hw/timer/stellaris-gptm.h
@@ -12,7 +12,7 @@
 
 #include "qom/object.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/core/clock.h"
 
 #define TYPE_STELLARIS_GPTM "stellaris-gptm"
diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
index 4bdc6c6fdb6..ace8fe04c87 100644
--- a/include/hw/watchdog/sbsa_gwdt.h
+++ b/include/hw/watchdog/sbsa_gwdt.h
@@ -14,7 +14,7 @@
 
 #include "qemu/bitops.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 #define TYPE_WDT_SBSA "sbsa_gwdt"
 #define SBSA_GWDT(obj) \
diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index 600a552d2e2..ddc49aaea4f 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -14,7 +14,7 @@
 
 #include "qemu/bitops.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ptimer.h"
 #include "qom/object.h"
 
diff --git a/rust/hw/core/wrapper.h b/rust/hw/core/wrapper.h
index 77b541f83f9..e5c7e0518a5 100644
--- a/rust/hw/core/wrapper.h
+++ b/rust/hw/core/wrapper.h
@@ -29,4 +29,4 @@ typedef enum memory_order {
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4cb2ea6c84a..e5822fcbb72 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -42,7 +42,7 @@
 #include "qemu/event_notifier.h"
 #include "qemu/main-loop.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index ff165828033..2b74bed8823 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/config-file.h"
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index e7b773d84d5..675ec43d094 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -15,7 +15,7 @@
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/pci/pci.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9e0892a51f8..1e3c6345411 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/apm.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
index 3e820cae1e3..564979f24dd 100644
--- a/hw/adc/aspeed_adc.c
+++ b/hw/adc/aspeed_adc.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/adc/aspeed_adc.h"
diff --git a/hw/adc/zynq-xadc.c b/hw/adc/zynq-xadc.c
index 748a51ba78b..1934ef0b1a9 100644
--- a/hw/adc/zynq-xadc.c
+++ b/hw/adc/zynq-xadc.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/adc/zynq-xadc.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 4c56f981d71..01fda4b1c8a 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -13,7 +13,7 @@
 #include "qapi/error.h"
 #include "hw/pci/pci_host.h"
 #include "cpu.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "alpha_sys.h"
 
 
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 50ab7f48105..c0d99182bf9 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -22,7 +22,7 @@
 #include "hw/arm/armsse.h"
 #include "hw/arm/armsse-version.h"
 #include "hw/arm/boot.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-clock.h"
 
 /*
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 76001ff0dfc..2d8e257ca2a 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -26,7 +26,7 @@
 #include "exec/tswap.h"
 #include "cpu.h"
 #include "hw/cpu/a9mpcore.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "system/blockdev.h"
 #include "system/system.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 66af0e2376d..f07dd452fcb 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -34,7 +34,7 @@
 #include "hw/net/lan9118.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/boards.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "target/arm/cpu-qom.h"
 
 #define SMDK_LAN9118_BASE_ADDR      0x05000000
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 436fcdd5101..b24df11db92 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -24,7 +24,7 @@
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
 #include "hw/hw.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
 #include "qemu/audio.h"
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 3188caf2228..a0d917f9a9e 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -75,7 +75,7 @@
 #include "hw/core/split-irq.h"
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 #define MPS2TZ_NUMIRQ_MAX 96
 #define MPS2TZ_RAM_MAX 5
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 3e624540960..9852e8f7648 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -27,7 +27,7 @@
 #include "ui/console.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/bitbang_i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/or-irq.h"
 #include "hw/audio/wm8750.h"
 #include "system/block-backend.h"
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 74458fb7c69..994e5a919e1 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -25,7 +25,7 @@
 #include "cpu.h"
 #include "system/address-spaces.h"
 #include "hw/hw.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/omap.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 97008490f6a..65506768e41 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -27,7 +27,7 @@
 #include "hw/char/pl011.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/intc/realview_gic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
 #include "qemu/audio.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index bcf8af8dc73..ae4fba15991 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -18,7 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index d1cbf43777e..34cbcbe32c2 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -26,7 +26,7 @@
 #include "hw/arm/armv7m.h"
 #include "hw/char/pl011.h"
 #include "hw/input/stellaris_gamepad.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "migration/vmstate.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 059b07907d8..95dda078522 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -28,7 +28,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index dd1047f6c62..94661b83d00 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -19,7 +19,7 @@
 #include "hw/pci/pci.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/core/boards.h"
 #include "hw/block/flash.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 25fb2bab568..6155db2b093 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -68,7 +68,7 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
 #include "hw/firmware/smbios.h"
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 0abb106979b..b6f42045003 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -14,7 +14,7 @@
 #include "qemu/timer.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/audio.h"
 #include "hw/audio/asc.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 98fdbc5b725..8368172f401 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/audio/model.h"
 #include "qemu/audio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 68f89e994c2..6c41b25486e 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -27,7 +27,7 @@
 #include "qemu/module.h"
 #include "hw/audio/model.h"
 #include "qemu/audio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index a483f4e70d1..ba9bd6befd7 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/audio/wm8750.h"
 #include "qemu/audio.h"
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index fd3d09611fa..7bb2c81afcd 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -21,7 +21,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 1e3c4caf5ef..6ca31a0e649 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/audio/model.h"
 #include "qemu/audio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 6d1790e0e61..0034c3594ae 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -33,7 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "hw/acpi/acpi_aml_interface.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index d0f08c7be54..e0e53ba0382 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -33,7 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/memalign.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index fae15217e9f..e98ad53e447 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/avr_usart.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 2b397f2ff39..03428efeea8 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/char/bcm2835_aux.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 0dfa356b6d0..738ba3114b9 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -30,7 +30,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/char/cadence_uart.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties-system.h"
 #include "trace.h"
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 32090f3516f..a5ec61a0044 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -26,7 +26,7 @@
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
 #include "hw/char/cmsdk-apb-uart.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties-system.h"
 
 REG32(DATA, 0)
diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index e1f0713cb79..835594e5cb6 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/char/serial.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/char/escc.c b/hw/char/escc.c
index afe4ca483e7..27269dca643 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 9e45d819904..8ba310fd7ac 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -30,7 +30,7 @@
 #include "chardev/char-serial.h"
 
 #include "hw/arm/exynos4210.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index a37408adae5..821b3218502 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index b2d5a40bb4d..15925eb2e63 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/char/grlib_uart.h"
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index d6f0d18c777..db852511091 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/char/ibex_uart.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 509b0141d05..9f13236f29c 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/char/imx_serial.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 25d7fc9574a..6e38916150c 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/ipack/ipack.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/max78000_uart.c b/hw/char/max78000_uart.c
index c76c0e759b6..5fc933123e9 100644
--- a/hw/char/max78000_uart.c
+++ b/hw/char/max78000_uart.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/char/max78000_uart.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qemu/log.h"
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index f14de59530c..d9d551924b3 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index 41d423446f3..39d144538d1 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -16,7 +16,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/char/nrf51_uart.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 01335d9437d..75fdb8158e4 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/char/pl011.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
index b9d0ed1c89b..b32e41d5b8a 100644
--- a/hw/char/renesas_sci.c
+++ b/hw/char/renesas_sci.c
@@ -23,7 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 34f30fb70b8..34608569988 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -30,7 +30,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/char/serial.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 46efabc4cbe..d05d0898998 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -29,7 +29,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/char/serial.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 03fec3fe75b..11685b397b7 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "hw/char/serial.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
 #include "qapi/error.h"
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 83227a84a60..ee430dd3d26 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index e7357d585a1..473374d3de1 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -22,7 +22,7 @@
 #include "migration/vmstate.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/qdev-properties-system.h"
 
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 45c30643a74..49bbda03b87 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/char/stm32f2xx_usart.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qemu/log.h"
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 60d8ab5a0e5..ce4a35da8f4 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -24,7 +24,7 @@
 #include "migration/vmstate.h"
 #include "hw/char/stm32l4x5_usart.h"
 #include "hw/core/clock.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 8feb58a898e..da1ecd249c7 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -26,7 +26,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/char/xilinx_uartlite.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
diff --git a/hw/core/gpio.c b/hw/core/gpio.c
index c7c2936fc55..11f26a2f2dd 100644
--- a/hw/core/gpio.c
+++ b/hw/core/gpio.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/qdev-core.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qapi/error.h"
 
 static NamedGPIOList *qdev_get_named_gpio_list(DeviceState *dev,
diff --git a/hw/core/irq.c b/hw/core/irq.c
index 0c768f7704e..106805e2417 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -23,7 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qom/object.h"
 
 void qemu_set_irq(qemu_irq irq, int level)
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 3942c709939..61006672ad6 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/or-irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 423a3a1d660..f9f56c66aec 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -32,7 +32,7 @@
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "hw/sysbus.h"
diff --git a/hw/core/split-irq.c b/hw/core/split-irq.c
index f8b48750c5b..d0aaa108eb9 100644
--- a/hw/core/split-irq.c
+++ b/hw/core/split-irq.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/split-irq.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index bd36dd94d4a..1a6fb914f3b 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/cpu/a15mpcore.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "system/kvm.h"
 #include "kvm_arm.h"
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 64bebbd19cb..9f8e0f70c49 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/cpu/a9mpcore.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 01772e7f77b..1953d12f61b 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -12,7 +12,7 @@
 #include "qemu/module.h"
 #include "hw/cpu/arm11mpcore.h"
 #include "hw/intc/realview_gic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 
 #define ARM11MPCORE_NUM_GIC_PRIORITY_BITS    4
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 099b71a9ef2..525f03e9e54 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -13,7 +13,7 @@
 #include "qemu/module.h"
 #include "hw/cpu/arm11mpcore.h"
 #include "hw/intc/realview_gic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qom/object.h"
 
 #define TYPE_REALVIEW_MPCORE_RIRQ "realview_mpcore"
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 1bb2ee45a01..f8f13b55cb4 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "hw/display/bcm2835_fb.h"
 #include "hw/hw.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "ui/console.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index daeef152174..8191237124e 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -30,7 +30,7 @@
 #include "ui/console.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
diff --git a/hw/display/dm163.c b/hw/display/dm163.c
index f8340d8275e..e78804693cd 100644
--- a/hw/display/dm163.c
+++ b/hw/display/dm163.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/display/dm163.h"
 #include "ui/console.h"
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 49c180fec0c..8d8062f427c 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-properties.h"
 #include "hw/hw.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index a6ddc21d3e4..10686cd6763 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/hw.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/display/omap_lcdc.c b/hw/display/omap_lcdc.c
index 3532a801be2..90a97314541 100644
--- a/hw/display/omap_lcdc.c
+++ b/hw/display/omap_lcdc.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "ui/console.h"
 #include "hw/arm/omap.h"
 #include "framebuffer.h"
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 09c3c59e0ed..e78a55184e9 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index a248b943a5a..a24e95f0a73 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -28,7 +28,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/display/xlnx_dp.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 
 #ifndef DEBUG_DP
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index a2771ddcb52..d07459de2d0 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/dma/bcm2835_dma.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 101f91f4a33..2bf9ebad565 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -21,7 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/arm/soc_dma.h"
 
 struct omap_dma_channel_s {
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 277d9343223..28f79371646 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "hw/dma/pl080.h"
 #include "hw/hw.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index f9c91f924bb..a9e6d2746f0 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index b6ed1d46433..8ce74257b62 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/mips/mips.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index 48de3a24785..bae77544b23 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -24,7 +24,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 60c23b69e5c..9f56faf9a53 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -26,7 +26,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/sparc/sun4m_iommu.h"
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 2020399fd59..9b05080ae59 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/hw.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 0c075e7d0d1..660fc21b6d1 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -28,7 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/dma/xlnx-zdma.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 8141d460338..cf00aa863d5 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/dma/xlnx-zynq-devcfg.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "system/dma.h"
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index d8c7da1a501..0b1185325ba 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 3d88ccc8da9..32f56036a4c 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -27,7 +27,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/dma/xlnx_dpdma.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 
 #ifndef DEBUG_DPDMA
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 2d78bf9515c..85a5acd7087 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -13,7 +13,7 @@
 #include "hw/misc/aspeed_scu.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "hw/registerfields.h"
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index dfb5d5cb578..bd9170b8932 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -20,7 +20,7 @@
 #include "migration/vmstate.h"
 #include "hw/sd/sd.h"
 #include "hw/gpio/bcm2835_gpio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 #define GPFSEL0   0x00
 #define GPFSEL1   0x04
diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 1069e7811bb..dab50faf285 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -19,7 +19,7 @@
 #include "migration/vmstate.h"
 #include "hw/sd/sd.h"
 #include "hw/gpio/bcm2838_gpio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 #define GPFSEL0   0x00
 #define GPFSEL1   0x04
diff --git a/hw/gpio/gpio_key.c b/hw/gpio/gpio_key.c
index 40c028bed9e..f8cf4da239a 100644
--- a/hw/gpio/gpio_key.c
+++ b/hw/gpio/gpio_key.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 450ece45482..842c997a2a6 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/gpio/imx_gpio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index 257497af584..377832e9d24 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
diff --git a/hw/gpio/npcm7xx_gpio.c b/hw/gpio/npcm7xx_gpio.c
index 66f8256a7a7..59b95d232bf 100644
--- a/hw/gpio/npcm7xx_gpio.c
+++ b/hw/gpio/npcm7xx_gpio.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/gpio/npcm7xx_gpio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index d94c0c47da2..567eb1fe7da 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -14,7 +14,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/gpio/nrf51_gpio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index f27806b774a..547f0a15a27 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 1e10238b2e0..fe1d8dbffa2 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -17,7 +17,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/gpio/pca9552.h"
 #include "hw/gpio/pca9552_regs.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index eac0d23be34..c6cdd27b3ff 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -13,7 +13,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/gpio/pca9554.h"
 #include "hw/gpio/pca9554_regs.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
index 274b44bb616..f871f1e7880 100644
--- a/hw/gpio/pcf8574.c
+++ b/hw/gpio/pcf8574.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
 #include "hw/gpio/pcf8574.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index a3ac038c2f7..09b32247127 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -30,7 +30,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/gpio/sifive_gpio.c b/hw/gpio/sifive_gpio.c
index 5831647b4d0..63ca721fadd 100644
--- a/hw/gpio/sifive_gpio.c
+++ b/hw/gpio/sifive_gpio.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/gpio/sifive_gpio.h"
 #include "migration/vmstate.h"
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index 42fe984c493..a5a38da6384 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -19,7 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/core/clock.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 590ffde89d1..0a9f76e7743 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -17,7 +17,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/i2c/allwinner-i2c.c b/hw/i2c/allwinner-i2c.c
index fe887e1c6a9..c879e5009df 100644
--- a/hw/i2c/allwinner-i2c.c
+++ b/hw/i2c/allwinner-i2c.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/allwinner-i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/i2c/i2c.h"
 #include "qemu/log.h"
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 83fb906bdc7..3d66dd863a1 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/i2c/aspeed_i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "trace.h"
diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c
index be11cca2a93..34de1f36e5b 100644
--- a/hw/i2c/bcm2835_i2c.c
+++ b/hw/i2c/bcm2835_i2c.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/i2c/bcm2835_i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 
 static void bcm2835_i2c_update_interrupt(BCM2835I2CState *s)
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index e020f314e2a..d379cfd7751 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/i2c/bitbang_i2c.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
index 9d0c1cdaa8a..dd72dda4fd0 100644
--- a/hw/i2c/exynos4210_i2c.c
+++ b/hw/i2c/exynos4210_i2c.c
@@ -26,7 +26,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/i2c/i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qom/object.h"
 
 #ifndef EXYNOS4_I2C_DEBUG
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index d26177c85df..88269653e2c 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/imx_i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/i2c/i2c.h"
 #include "qemu/log.h"
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 25f91b7bc82..e2097f819ce 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 751bf748fd9..6ac151d8515 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -21,7 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index 09d4c49d657..d38efd72883 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -30,7 +30,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/i2c/ppc4xx_i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 #define PPC4xx_I2C_MEM_SIZE 18
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 8a72d6e4dd3..66f37e13039 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -15,7 +15,7 @@
 #include "hw/intc/i8259.h"
 #include "qemu/module.h"
 #include "hw/intc/kvm_irqcount.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "system/kvm.h"
 #include "qom/object.h"
 
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index dd566c49679..a510ab871de 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -34,7 +34,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/xen/xen_backend_ops.h"
 
 #include "xen_evtchn.h"
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 94d22a232ac..e3bafb83af9 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -31,7 +31,7 @@
 #include "microvm-dt.h"
 
 #include "hw/loader.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/i386/kvm/clock.h"
 #include "hw/i386/microvm.h"
 #include "hw/i386/x86.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f6b9a1bc406..3f8fd078318 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -38,7 +38,7 @@
 #include "hw/usb/usb.h"
 #include "net/net.h"
 #include "hw/ide/pci.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "system/kvm.h"
 #include "hw/i386/kvm/clock.h"
 #include "hw/sysbus.h"
diff --git a/hw/i386/port92.c b/hw/i386/port92.c
index 39b6f3178fe..48a174316fd 100644
--- a/hw/i386/port92.c
+++ b/hw/i386/port92.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "system/runstate.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
 #include "trace.h"
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index c844749900a..27f2f284c81 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -37,7 +37,7 @@
 #include "target/i386/sev.h"
 
 #include "hw/acpi/cpu_hotplug.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/loader.h"
 #include "multiboot.h"
 #include "elf.h"
diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
index 1a86a853d5f..276f2b0cdf8 100644
--- a/hw/i386/x86-cpu.c
+++ b/hw/i386/x86-cpu.c
@@ -28,7 +28,7 @@
 #include "hw/i386/x86.h"
 #include "target/i386/cpu.h"
 #include "hw/intc/i8259.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "system/kvm.h"
 
 /* TSC handling */
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index ceb2242aa71..591da26d453 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -17,7 +17,7 @@
 
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/xen/xen-x86.h"
 #include "qemu/range.h"
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 14bc66fb7fa..08f51c8e361 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -22,7 +22,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 
 #include "qemu/error-report.h"
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 8c380abf7c1..b45abf067b2 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index c23bf32d2b1..07db7dc34aa 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 1e50bb9e483..7ce1ae67ab2 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index dedc2674c00..3a77d744caf 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -32,7 +32,7 @@
 #include "system/dma.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "ide-internal.h"
 #include "trace.h"
 
diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
index de625723c78..70a179907ca 100644
--- a/hw/input/lasips2.c
+++ b/hw/input/lasips2.c
@@ -31,7 +31,7 @@
 #include "trace.h"
 #include "system/address-spaces.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qapi/error.h"
 
 
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 71f5f976e9c..48b457cac76 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -31,7 +31,7 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/input/ps2.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
 #include "system/reset.h"
diff --git a/hw/input/pl050.c b/hw/input/pl050.c
index c5f4a3fa843..cb8efc74f77 100644
--- a/hw/input/pl050.c
+++ b/hw/input/pl050.c
@@ -20,7 +20,7 @@
 #include "migration/vmstate.h"
 #include "hw/input/ps2.h"
 #include "hw/input/pl050.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 7f7b1fce2e5..96850124a7b 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/input/ps2.h"
 #include "migration/vmstate.h"
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index fec1161c9c1..bd80db6fac5 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/input/stellaris_gamepad.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 04097341557..0e1ec521e42 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -19,7 +19,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/intc/allwinner-a10-pic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 899f1333633..e27bb20bf8c 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "gic_internal.h"
 #include "qapi/error.h"
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index cef06882216..e823fcc97fc 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/msi.h"
 #include "hw/qdev-properties.h"
 #include "system/kvm.h"
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 2e6c1f778a9..eaf1e512ede 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -18,7 +18,7 @@
 #include "qemu/main-loop.h"
 #include "trace.h"
 #include "gicv3_internal.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "cpu.h"
 #include "target/arm/cpregs.h"
 #include "target/arm/cpu-features.h"
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 7c78961040e..bb39a690a59 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -16,7 +16,7 @@
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "hw/intc/armv7m_nvic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "system/tcg.h"
 #include "system/runstate.h"
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 5cd786dee6c..d92305b9ca1 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/aspeed_intc.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/log.h"
 #include "trace.h"
 #include "hw/registerfields.h"
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 7120088454c..b0a9a397055 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -29,7 +29,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/aspeed_vic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 55e0a5a503b..71bf671761b 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/bcm2835_ic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index 1c028536696..f1deafaf7a2 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/bcm2836_control.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index ebbe23436f4..b9e74d19c37 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -34,7 +34,7 @@
 #include "hw/intc/exynos4210_combiner.h"
 #include "hw/arm/exynos4210.h"
 #include "hw/hw.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "qom/object.h"
 
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index 7e2d79d00cd..5b156f7ef5a 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -25,7 +25,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/exynos4210_gic.h"
 #include "hw/arm/exynos4210.h"
diff --git a/hw/intc/goldfish_pic.c b/hw/intc/goldfish_pic.c
index 2359861785d..7aaccba75ae 100644
--- a/hw/intc/goldfish_pic.c
+++ b/hw/intc/goldfish_pic.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index e0f26466ba3..bb2ee5f8015 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -27,7 +27,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 
 #include "hw/qdev-properties.h"
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 447e8c25d8d..b65ec04e475 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -27,7 +27,7 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/intc/heathrow_pic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "trace.h"
 
 static inline int heathrow_check_irq(HeathrowPICState *pic)
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index b6f96bf208c..8f2aa1f0fb1 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/i8259.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
diff --git a/hw/intc/imx_avic.c b/hw/intc/imx_avic.c
index 09c3bfac0b6..a3d71aba8ef 100644
--- a/hw/intc/imx_avic.c
+++ b/hw/intc/imx_avic.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/imx_avic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index 32bdd171c58..082755d28bb 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/intc/loongarch_pch_msi.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_dintc.h"
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 3e9c88d1d9c..29997402694 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -9,7 +9,7 @@
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/loongarch/virt.h"
 #include "system/address-spaces.h"
 #include "system/kvm.h"
diff --git a/hw/intc/loongarch_pch_msi.c b/hw/intc/loongarch_pch_msi.c
index f6d163158da..63090b27261 100644
--- a/hw/intc/loongarch_pch_msi.c
+++ b/hw/intc/loongarch_pch_msi.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/intc/loongarch_pch_msi.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/pci/msi.h"
diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 32f01aabf0e..82e16be3918 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "system/kvm.h"
 #include "trace.h"
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index 8cd78d48589..b3d8e781ca1 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/intc/loongson_ipi_common.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
 #include "system/kvm.h"
diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
index c10fb97a063..4c24f330ed7 100644
--- a/hw/intc/loongson_liointc.c
+++ b/hw/intc/loongson_liointc.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/loongson_liointc.h"
 
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 0c50ba41f62..08925fe1e41 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -19,7 +19,7 @@
 #include "system/reset.h"
 #include "kvm_mips.h"
 #include "hw/intc/mips_gic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 
 static void mips_gic_set_vp_irq(MIPSGICState *gic, int vp, int pin)
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index c61158bddd3..7b23b6d2cec 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 047c367478d..5a630bd51cb 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 87733eb7c30..edac46227f5 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -31,7 +31,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/ppc/openpic.h"
 #include "hw/ppc/ppc_e500.h"
diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index 838c21c4a02..f1e4959e9ae 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/intc/ppc-uic.c b/hw/intc/ppc-uic.c
index bc4dc90ade1..bfc4a4fbceb 100644
--- a/hw/intc/ppc-uic.c
+++ b/hw/intc/ppc-uic.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/ppc-uic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index 63e25c2a781..ecaf8201fd6 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -11,7 +11,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/intc/realview_gic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 
 static void realview_gic_set_irq(void *opaque, int irq, int level)
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index c6f13f647ec..f3e37df47d1 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -32,7 +32,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/intc/riscv_aclint.h"
 #include "qemu/timer.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 
 typedef struct riscv_aclint_mtimer_callback {
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a559664c40b..580622d1712 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -28,7 +28,7 @@
 #include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/riscv_aplic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "target/riscv/cpu.h"
 #include "system/system.h"
 #include "system/kvm.h"
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 513e38d9c12..54e72b81e78 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -28,7 +28,7 @@
 #include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/riscv_imsic.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "target/riscv/cpu.h"
 #include "target/riscv/cpu_bits.h"
 #include "system/system.h"
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index f8615527b75..84712e2e4d0 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/rx_icu.h"
diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index c9b0b0c1ecc..16e4b619d6d 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -12,7 +12,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "hw/sh4/sh_intc.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sh4/sh.h"
 #include "trace.h"
 
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 3160b216fdc..c578b6e36d2 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -29,7 +29,7 @@
 #include "hw/intc/sifive_plic.h"
 #include "target/riscv/cpu.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "system/kvm.h"
 
 static bool addr_between(uint32_t addr, uint32_t base, uint32_t num)
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index 00b80bb177c..b12c8cbd69f 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -27,7 +27,7 @@
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/intc/intc.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "trace.h"
 #include "qom/object.h"
 
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 200710eb6ca..e87c0ad2bcd 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -36,7 +36,7 @@
 #include "qapi/visitor.h"
 #include "migration/vmstate.h"
 #include "hw/intc/intc.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "system/kvm.h"
 #include "system/reset.h"
 #include "target/ppc/cpu.h"
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 5257ad54b17..f5a59d89830 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -29,7 +29,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qom/object.h"
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index e0ffcf89ebf..6f9babf601c 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -16,7 +16,7 @@
 #include "system/reset.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive2.h"
 #include "hw/ppc/xive_regs.h"
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index 9200585e325..098c1f327cd 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -32,7 +32,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/intc/xlnx-pmu-iomod-intc.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 
 #ifndef XLNX_PMU_IO_INTC_ERR_DEBUG
diff --git a/hw/intc/xlnx-zynqmp-ipi.c b/hw/intc/xlnx-zynqmp-ipi.c
index 610cd0e3164..99566bc2e20 100644
--- a/hw/intc/xlnx-zynqmp-ipi.c
+++ b/hw/intc/xlnx-zynqmp-ipi.c
@@ -33,7 +33,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/intc/xlnx-zynqmp-ipi.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 #ifndef XLNX_ZYNQMP_IPI_ERR_DEBUG
 #define XLNX_ZYNQMP_IPI_ERR_DEBUG 0
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index ab602bff734..4a710eb1876 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/ipack/ipack.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index 40b30517c75..b074b8727dc 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/ipack/ipack.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 0ad91ccf689..2b26f9c9f0f 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ipmi/ipmi_bt.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 418d234e0f1..14e85e6e9fd 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ipmi/ipmi_kcs.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 06e8f0ce3e0..dfa8a3775cf 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci_device.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/intc/i8259.h"
 #include "hw/timer/i8254.h"
 #include "migration/vmstate.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index c9cb8f77799..6e772eca573 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -37,7 +37,7 @@
 #include "hw/dma/i8257.h"
 #include "hw/isa/isa.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/apm.h"
 #include "hw/pci/pci.h"
 #include "hw/southbridge/ich9.h"
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 52c14d3cd5b..bf1c79a3e63 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -29,7 +29,7 @@
 #include "hw/dma/i8257.h"
 #include "hw/southbridge/piix.h"
 #include "hw/timer/i8254.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ide/piix.h"
 #include "hw/intc/i8259.h"
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 337958617a4..1362a1f4042 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -24,7 +24,7 @@
 #include "hw/isa/isa.h"
 #include "hw/isa/superio.h"
 #include "hw/intc/i8259.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/dma/i8257.h"
 #include "hw/usb/hcd-uhci.h"
 #include "hw/timer/i8254.h"
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a78a9bc03d8..0e11eb340f0 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -20,7 +20,7 @@
 #include "system/rtc.h"
 #include "hw/loongarch/virt.h"
 #include "system/address-spaces.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "net/net.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 6359aa81d0e..4cf86d510b3 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -12,7 +12,7 @@
 #include "cpu.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/boards.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/m68k/mcf.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index c1067435bf8..b2b02f25ff1 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "qemu/datadir.h"
 #include "cpu.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/m68k/mcf.h"
 #include "hw/m68k/mcf_fec.h"
 #include "qemu/timer.h"
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index e3055b841e8..efac6802a97 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -11,7 +11,7 @@
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d7c460bcd4b..1411436a463 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -15,7 +15,7 @@
 #include "exec/cpu-interrupt.h"
 #include "system/system.h"
 #include "system/qtest.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/m68k/next-cube.h"
 #include "hw/core/boards.h"
 #include "hw/loader.h"
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index d663d124fce..94f47175ae5 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -24,7 +24,7 @@
 #include "cpu.h"
 #include "hw/m68k/q800-glue.h"
 #include "hw/core/boards.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/nmi.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 44ae8bc6c72..c63d77d4cca 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -43,7 +43,7 @@
 #include "hw/pci/pci_bus.h"
 #include "qemu/log.h"
 #include "hw/ide/pci.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "qom/object.h"
diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 26fdb934f50..2b740afc4d8 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "system/kvm.h"
 #include "kvm_mips.h"
 
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 0f4e37cd474..8995eaeec36 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "qemu/timer.h"
 #include "system/runstate.h"
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
index d5d307a186c..2673c2de3ef 100644
--- a/hw/misc/armsse-mhu.c
+++ b/hw/misc/armsse-mhu.c
@@ -23,7 +23,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/armsse-mhu.h"
 
 REG32(CPU0INTR_STAT, 0x0)
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 726368fbbc2..51c73ca2a52 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -19,7 +19,7 @@
 #include "migration/vmstate.h"
 #include "crypto/hash.h"
 #include "hw/qdev-properties.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "trace.h"
 
 #define R_CRYPT_CMD     (0x10 / 4)
diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c
index 78406dae248..829955e6f16 100644
--- a/hw/misc/aspeed_lpc.c
+++ b/hw/misc/aspeed_lpc.c
@@ -13,7 +13,7 @@
 #include "hw/misc/aspeed_lpc.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/misc/aspeed_peci.c b/hw/misc/aspeed_peci.c
index a7a449a9236..cf902a8ab8c 100644
--- a/hw/misc/aspeed_peci.c
+++ b/hw/misc/aspeed_peci.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/aspeed_peci.h"
 #include "hw/registerfields.h"
 #include "trace.h"
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index cc03c422b0e..3bc272d39c5 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/aspeed_xdma.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
index 411f016c997..947304ed3b6 100644
--- a/hw/misc/avr_power.c
+++ b/hw/misc/avr_power.c
@@ -26,7 +26,7 @@
 #include "hw/misc/avr_power.h"
 #include "qemu/log.h"
 #include "hw/qdev-properties.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "trace.h"
 
 static void avr_mask_reset(DeviceState *dev)
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 603eaaa710d..ac37fe99571 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/bcm2835_mbox.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index a21c6a541c0..2026294ce12 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -10,7 +10,7 @@
 #include "hw/misc/bcm2835_property.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
 #include "hw/arm/raspberrypi-fw-defs.h"
 #include "system/dma.h"
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index 81fc536131c..71243ba5bad 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/imx_rngc.c b/hw/misc/imx_rngc.c
index 630f6cb54b5..9f49bbcc2e7 100644
--- a/hw/misc/imx_rngc.c
+++ b/hw/misc/imx_rngc.c
@@ -15,7 +15,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/guest-random.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/imx_rngc.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index afd9ab48df7..f8a2946191d 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -17,7 +17,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/iotkit-secctl.h"
 #include "hw/arm/armsse-version.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index 27ee8c92183..790500d34de 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -13,7 +13,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index 6684f16fd75..e8e1578b751 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -14,7 +14,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "system/system.h"
 #include "system/runstate.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index bc37e2a2cb7..13ccd3023fb 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -19,7 +19,7 @@
 #include "system/address-spaces.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/timer.h"
 #include "hw/misc/mac_via.h"
 #include "hw/misc/mos6522.h"
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index bcd00c9bb1b..3b8dd462f56 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/misc/macio/cuda.h"
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 990551f91f4..9fed4265676 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -28,7 +28,7 @@
 #include "migration/vmstate.h"
 #include "hw/misc/macio/macio.h"
 #include "hw/misc/macio/gpio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/nmi.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index b2b42dd5622..a55c9c99824 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -38,7 +38,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "migration/vmstate.h"
 #include "qemu/main-loop.h"
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 37349139948..73e64306b86 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -31,7 +31,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/macio/pmu.h"
 #include "qemu/timer.h"
 #include "system/runstate.h"
diff --git a/hw/misc/max78000_aes.c b/hw/misc/max78000_aes.c
index d883ddd2b61..65846757332 100644
--- a/hw/misc/max78000_aes.c
+++ b/hw/misc/max78000_aes.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/misc/max78000_aes.h"
 #include "crypto/aes.h"
diff --git a/hw/misc/max78000_gcr.c b/hw/misc/max78000_gcr.c
index fbbc92cca32..6d2e2bd6176 100644
--- a/hw/misc/max78000_gcr.c
+++ b/hw/misc/max78000_gcr.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "system/runstate.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/misc/max78000_icc.c b/hw/misc/max78000_icc.c
index 6f7d2b20bf5..622baa5719d 100644
--- a/hw/misc/max78000_icc.c
+++ b/hw/misc/max78000_icc.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/misc/max78000_icc.h"
 
diff --git a/hw/misc/max78000_trng.c b/hw/misc/max78000_trng.c
index ecdaef53b6c..1435138344d 100644
--- a/hw/misc/max78000_trng.c
+++ b/hw/misc/max78000_trng.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/misc/max78000_trng.h"
 #include "qemu/guest-random.h"
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index 10fc7ea2a95..84e957244e5 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -24,7 +24,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/misc/mchp_pfsoc_ioscb.h"
 
diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
index f47c835f80d..2a415151037 100644
--- a/hw/misc/mchp_pfsoc_sysreg.c
+++ b/hw/misc/mchp_pfsoc_sysreg.c
@@ -24,7 +24,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "system/runstate.h"
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 8dd6b82ac5f..728931883d8 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/mos6522.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index a9a5d4a535b..ea9cad85dc2 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -23,7 +23,7 @@
 #include "qemu/bitops.h"
 #include "trace.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-scc.h"
diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index b35e971fe53..514d29f2015 100644
--- a/hw/misc/npcm7xx_mft.c
+++ b/hw/misc/npcm7xx_mft.c
@@ -15,7 +15,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/npcm7xx_mft.h"
diff --git a/hw/misc/npcm7xx_pwm.c b/hw/misc/npcm7xx_pwm.c
index 2de18d09b82..2e72d1c7d4f 100644
--- a/hw/misc/npcm7xx_pwm.c
+++ b/hw/misc/npcm7xx_pwm.c
@@ -15,7 +15,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/npcm7xx_pwm.h"
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index 8cd7ffe3f55..0254fb377a6 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/arm/nrf51.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/nrf51_rng.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/omap_clk.c b/hw/misc/omap_clk.c
index da95c4ace58..37afef09903 100644
--- a/hw/misc/omap_clk.c
+++ b/hw/misc/omap_clk.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/arm/omap.h"
 
 struct clk {
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 67c486f347c..4093cb3c99c 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -37,7 +37,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "qom/object.h"
 
diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
index 6eef38d622a..9b1e7baf95e 100644
--- a/hw/misc/sifive_e_aon.c
+++ b/hw/misc/sifive_e_aon.c
@@ -19,7 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/registerfields.h"
 #include "hw/misc/sifive_e_aon.h"
 #include "qapi/visitor.h"
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index a034df3592f..43ce5d0bc97 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
index 5815b3efa54..74ea29b1560 100644
--- a/hw/misc/stm32_rcc.c
+++ b/hw/misc/stm32_rcc.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/misc/stm32_rcc.h"
 
diff --git a/hw/misc/stm32f4xx_exti.c b/hw/misc/stm32f4xx_exti.c
index 0688e6e73ec..a9d396c5dcf 100644
--- a/hw/misc/stm32f4xx_exti.c
+++ b/hw/misc/stm32f4xx_exti.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/misc/stm32f4xx_exti.h"
 
diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
index addfb031e88..57e89a13aaa 100644
--- a/hw/misc/stm32f4xx_syscfg.c
+++ b/hw/misc/stm32f4xx_syscfg.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/misc/stm32f4xx_syscfg.h"
 
diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index 9c002164c82..8de4568de70 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/misc/stm32l4x5_exti.h"
 
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 514159777a0..d4af2cd6963 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -24,7 +24,7 @@
 #include "hw/misc/stm32l4x5_rcc.h"
 #include "hw/misc/stm32l4x5_rcc_internals.h"
 #include "hw/core/clock.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
index 85be226d2f4..de488a46780 100644
--- a/hw/misc/stm32l4x5_syscfg.c
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/core/clock.h"
 #include "hw/qdev-clock.h"
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index a158d4a2944..d922639da17 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -17,7 +17,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/tz-mpc.h"
 #include "hw/qdev-properties.h"
 
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index af0cc5d4718..74c31f6d7d2 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -17,7 +17,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/tz-msc.h"
 #include "hw/qdev-properties.h"
 
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index e4235a846d4..2ab03fa9730 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -17,7 +17,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/tz-ppc.h"
 #include "hw/qdev-properties.h"
 
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 95e167b9213..616c0ecf837 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -18,7 +18,7 @@
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 
 #ifndef XLNX_VERSAL_CFRAME_REG_ERR_DEBUG
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index b920fc77c3f..ce58404eb2c 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/units.h"
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 5987f32c716..8f9a40d941d 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -11,7 +11,7 @@
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/register.h"
 #include "hw/resettable.h"
 
diff --git a/hw/misc/xlnx-versal-pmc-iou-slcr.c b/hw/misc/xlnx-versal-pmc-iou-slcr.c
index d76df468d49..c75800c1b3c 100644
--- a/hw/misc/xlnx-versal-pmc-iou-slcr.c
+++ b/hw/misc/xlnx-versal-pmc-iou-slcr.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
index d90f3e87c74..af58bc761f3 100644
--- a/hw/misc/xlnx-versal-xramc.c
+++ b/hw/misc/xlnx-versal-xramc.c
@@ -13,7 +13,7 @@
 #include "hw/sysbus.h"
 #include "hw/register.h"
 #include "hw/qdev-properties.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/xlnx-versal-xramc.h"
 
 #ifndef XLNX_XRAM_CTRL_ERR_DEBUG
diff --git a/hw/misc/xlnx-zynqmp-apu-ctrl.c b/hw/misc/xlnx-zynqmp-apu-ctrl.c
index 08777496d56..196e2452ae3 100644
--- a/hw/misc/xlnx-zynqmp-apu-ctrl.c
+++ b/hw/misc/xlnx-zynqmp-apu-ctrl.c
@@ -14,7 +14,7 @@
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/register.h"
 
 #include "qemu/bitops.h"
diff --git a/hw/misc/xlnx-zynqmp-crf.c b/hw/misc/xlnx-zynqmp-crf.c
index d9c1bd50e4f..841bce2231c 100644
--- a/hw/misc/xlnx-zynqmp-crf.c
+++ b/hw/misc/xlnx-zynqmp-crf.c
@@ -12,7 +12,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/xlnx-zynqmp-crf.h"
 #include "target/arm/arm-powerctl.h"
 
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 30a81576b4c..a4824d61bda 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -23,7 +23,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "trace.h"
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 77d089d9887..9158c77cb4f 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -22,7 +22,7 @@
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "qemu/fifo8.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/net/allwinner_emac.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 44896f1801b..ef72821f8d7 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include <zlib.h> /* for crc32 */
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index be16769de29..52584c5d6fa 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -32,7 +32,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 44f3ba370dc..2e9e09741b2 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 7296d63be79..7dd23c905e5 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 6b08e977a1d..922431effbc 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
 
diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index 6bd99c477b2..b6ad7cdb400 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -29,7 +29,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
 
diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
index bed6785433e..ad2b1e60cb4 100644
--- a/hw/net/can/ctucan_pci.c
+++ b/hw/net/can/ctucan_pci.c
@@ -29,7 +29,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 5735639b85a..07342795575 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -32,7 +32,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/register.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index ca9edd4a5b8..a98b208169f 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -32,7 +32,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index d49032059bb..68062481c59 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/net/dp8393x.h"
 #include "hw/sysbus.h"
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 846f6cbc5d9..6ae8a1e1a3c 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -28,7 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/net/mii.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index c41ce889cf1..d5590391b7f 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/net/ftgmac100.h"
 #include "system/dma.h"
 #include "qapi/error.h"
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index af1abd49960..a94cfa2d6df 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -40,7 +40,7 @@
 #include "qemu/timer.h"
 #include "net/net.h"
 #include "net/eth.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "system/address-spaces.h"
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index e5e34dd1a47..386d24421cb 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -22,7 +22,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/net/imx_fec.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 3017e129710..1c9bb4807d2 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -15,7 +15,7 @@
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/eth.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/net/lan9118_phy.h"
 #include "hw/net/lan9118.h"
 #include "hw/ptimer.h"
diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index 4c4e03df115..f0f6e55d807 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 #include "hw/net/lan9118_phy.h"
 #include "hw/net/mii.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/resettable.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index ae128fa3114..9cd94369859 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "net/net.h"
 #include "qemu/module.h"
 #include "hw/m68k/mcf.h"
diff --git a/hw/net/msf2-emac.c b/hw/net/msf2-emac.c
index 59045973ab9..3e279209628 100644
--- a/hw/net/msf2-emac.c
+++ b/hw/net/msf2-emac.c
@@ -34,7 +34,7 @@
 #include "hw/registerfields.h"
 #include "hw/net/msf2-emac.h"
 #include "hw/net/mii.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/net/mv88w8618_eth.c b/hw/net/mv88w8618_eth.c
index 6f08846c81c..68fda839660 100644
--- a/hw/net/mv88w8618_eth.c
+++ b/hw/net/mv88w8618_eth.c
@@ -9,7 +9,7 @@
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/net/mv88w8618_eth.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index ce937e1b618..7b215eb1f2e 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index b1923c8c3e1..fea21627f0f 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -26,7 +26,7 @@
 #include "net/eth.h"
 #include "qemu/module.h"
 #include "system/memory.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "ne2000.h"
 #include "trace.h"
diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index 9ba35e2c819..9eb39a6b846 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -31,7 +31,7 @@
 
 #include <zlib.h> /* for crc32 */
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/net/npcm7xx_emc.h"
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 7e955c01322..85419321d94 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -32,7 +32,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/net/mii.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 0ca5bc21938..dad5d2ab06d 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -28,7 +28,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index ad675ab29d4..fc2ce5eeb2d 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -37,7 +37,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 5cd78e334b6..b1c675be6fc 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -11,7 +11,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/net/smc91c111.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 2fc51e1e16d..a05aa8a024c 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 319af906c8d..5f9df76a74e 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
 #include "hw/nvram/eeprom93xx.h"
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index d45f8724673..25768644f58 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 1f5c7480476..c7cb257e62d 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -31,7 +31,7 @@
 #include "net/net.h"
 #include "net/checksum.h"
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/stream.h"
 #include "qom/object.h"
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 42b19d07c76..0d00e3cc0d9 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -32,7 +32,7 @@
 #include "qom/object.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 0d4d6c0d875..1abd9489044 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "exec/target_page.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/loader.h"
 #include "hw/nubus/nubus.h"
 #include "qapi/error.h"
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 769107e835e..a42e7b5e271 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 3cfd1c0b5ce..bc5d27dbdd8 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "system/address-spaces.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/core/split-irq.h"
diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index cc65aac2a87..1881e03d586 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/i2c/bitbang_i2c.h"
 #include "hw/intc/i8259.h"
 #include "hw/pci-host/articia.h"
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 1fc2c617727..5d837f638c2 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-host/aspeed_pcie.h"
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 1024ede7b68..b54f6ef2d53 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index cbda068ef7d..90040045c1f 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -43,7 +43,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/pci/pci_device.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/mips/mips.h"
 #include "hw/pci-host/bonito.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index f6e49ce9b8d..5a80502abb7 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -28,7 +28,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci-host/designware.h"
 
 #define DESIGNWARE_PCIE_PORT_LINK_CONTROL          0x710
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 924053499c1..e6fdb927f5e 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index b806a2286f7..3db4c8c9f05 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -31,7 +31,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index f9da5a908c1..85a4b83228a 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_device.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index b1d96f62fe9..3e497b5da5b 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -36,7 +36,7 @@
 #include "hw/misc/empty_slot.h"
 #include "migration/vmstate.h"
 #include "hw/intc/i8259.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "trace.h"
 #include "qom/object.h"
 
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index e05b6770102..9f080e4825a 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -14,7 +14,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/intc/i8259.h"
 #include "hw/qdev-properties.h"
 #include "system/address-spaces.h"
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 5d8383fac30..9808d575509 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -18,7 +18,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "qom/object.h"
 #include "system/system.h"
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index 3a83311faff..f6bf4e323a9 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -13,7 +13,7 @@
 #include "hw/pci-host/pnv_phb3.h"
 #include "hw/ppc/pnv.h"
 #include "hw/pci/msi.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "system/reset.h"
 
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 18992054e83..9f17fc1bb41 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -18,7 +18,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "qom/object.h"
 #include "trace.h"
diff --git a/hw/pci-host/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
index 744b85e49cc..3bd15b8c32b 100644
--- a/hw/pci-host/ppc440_pcix.c
+++ b/hw/pci-host/ppc440_pcix.c
@@ -24,7 +24,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci-host/ppc4xx.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
index 25478176881..b9a00f51930 100644
--- a/hw/pci-host/ppc4xx_pci.c
+++ b/hw/pci-host/ppc4xx_pci.c
@@ -23,7 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci-host/ppc4xx.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 975d191ccb8..a8e172136eb 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -15,7 +15,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 22ad244eb6e..3032e0d6854 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -32,7 +32,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/i8259.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/or-irq.h"
 #include "qom/object.h"
 
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 538624c5079..c2f99b76f80 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -31,7 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci-bridge/simba.h"
 #include "hw/pci-host/sabre.h"
 #include "qapi/error.h"
diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 62fb945075f..87a71c889e4 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/sh4/sh.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
 #include "qemu/module.h"
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 194037d6e75..7a25f3f39f5 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 8ea26e3ff00..40dce72e674 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -11,7 +11,7 @@
 #include "qemu/units.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index c71492de9e7..ac6e61c83b0 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -23,7 +23,7 @@
 #include "qapi/error.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/qdev-properties.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci-host/xilinx-pcie.h"
 
 enum root_cfg_reg {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 02a59f355b6..ffeb3fbf7cf 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 8842f7f6b88..eeca31dabb9 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -49,7 +49,7 @@
 #include "hw/platform-bus.h"
 #include "hw/net/fsl_etsec/etsec.h"
 #include "hw/i2c/i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sd/sdhci.h"
 #include "hw/misc/unimp.h"
 
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index e7396a729f3..8b5958e7498 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -13,7 +13,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci_host.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/or-irq.h"
 #include "hw/pci-host/articia.h"
 #include "hw/pci-host/mv64361.h"
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index f887a18cde8..540d5e365f4 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 60de4794917..213e58b455c 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -11,7 +11,7 @@
 #include "qemu/log.h"
 #include "system/reset.h"
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 
 #include "hw/ppc/pnv.h"
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index f6beba0917d..538681bdb32 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 24b789c191c..7e93e6a6b11 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5d947d8b520..1cea9375c0e 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "system/address-spaces.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 34dc013d47b..4798e129983 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 3e436c70413..a512d4fa647 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc_e500.h"
 #include "qemu/timer.h"
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 89e3fae08d7..fd9203d7e2a 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -12,7 +12,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/pci-host/ppc4xx.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/ppc/ppc4xx_sdram.c b/hw/ppc/ppc4xx_sdram.c
index 592769826bd..6cc2a82ac5c 100644
--- a/hw/ppc/ppc4xx_sdram.c
+++ b/hw/ppc/ppc4xx_sdram.c
@@ -35,7 +35,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "system/address-spaces.h" /* get_system_memory() */
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc4xx.h"
 #include "trace.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 41cd923b94a..d0e42e8731a 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 892ddc7f8f7..b1774e88f2b 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -34,7 +34,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/pci/pci.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci-host/spapr.h"
 #include "hw/ppc/spapr_drc.h"
 #include "qemu/help_option.h"
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index fc45a5d5d61..32a2edbe5cc 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -11,7 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_xive.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d596a9e38e3..523edaa7b6c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci.h"
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index e34d00aef64..7d8c6f1c7c6 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -17,7 +17,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6839a2635e8..00438d2e596 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -40,7 +40,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/core/boards.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
diff --git a/hw/rtc/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
index 624b4f61a85..a7e17031ca8 100644
--- a/hw/rtc/exynos4210_rtc.c
+++ b/hw/rtc/exynos4210_rtc.c
@@ -34,7 +34,7 @@
 #include "qemu/bcd.h"
 #include "hw/ptimer.h"
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 #include "hw/arm/exynos4210.h"
 #include "qom/object.h"
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 78df031cf29..67f9eacb22a 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/rtc/goldfish_rtc.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index 10097b2db75..234a7e97698 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/register.h"
 #include "qemu/timer.h"
 #include "system/system.h"
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 68be2dad6f3..0be17b3e798 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/rtc/m48t59.h"
 #include "qemu/timer.h"
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 8631386b9f0..4c4c1c84219 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -28,7 +28,7 @@
 #include "qemu/bcd.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/intc/kvm_irqcount.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qemu/timer.h"
diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index e545b9dfd64..2ec8ac8add6 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "hw/rtc/pl031.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
diff --git a/hw/rtc/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
index 500982a8011..18849340d62 100644
--- a/hw/rtc/xlnx-zynqmp-rtc.c
+++ b/hw/rtc/xlnx-zynqmp-rtc.c
@@ -30,7 +30,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/cutils.h"
 #include "system/system.h"
 #include "system/rtc.h"
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 12c86eb7aaa..b31ccdbeccb 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci_device.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/nvram/eeprom93xx.h"
 #include "hw/scsi/esp.h"
 #include "migration/vmstate.h"
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 2809fcdee09..9da6119be26 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/scsi/esp.h"
 #include "trace.h"
 #include "qemu/log.h"
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 9ea4aa0a853..6f43e500b3c 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -15,7 +15,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/scsi/scsi.h"
 #include "migration/vmstate.h"
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 47a69834912..9931fd4dc7d 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/scsi/scsi.h"
 #include "hw/scsi/ncr53c710.h"
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index 9d61b372e70..4c039b9520e 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -25,7 +25,7 @@
 #include "system/blockdev.h"
 #include "system/dma.h"
 #include "hw/qdev-properties.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sd/allwinner-sdhost.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index fc38ad39ce1..c2c85eaaf17 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -11,7 +11,7 @@
 #include "qemu/error-report.h"
 #include "hw/sd/aspeed_sdhci.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index f7cef7bb1cd..2736aa14d43 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -15,7 +15,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "system/blockdev.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 5a1d25defaa..267b723e3c5 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/arm/omap.h"
 #include "hw/sd/sd.h"
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 5d56ead4d91..761b262d7ba 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -11,7 +11,7 @@
 #include "system/blockdev.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sd/sd.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 40a75a43ffb..ff45c8e70ca 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -35,7 +35,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/registerfields.h"
 #include "system/block-backend.h"
 #include "hw/sd/sd.h"
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index c18b91fe63c..0e38bed49a9 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 89b595ce4a5..39185f0a987 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -28,7 +28,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "system/dma.h"
 #include "qemu/timer.h"
diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 9017ce6116c..37d1cffd57a 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/pmbus_device.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/sensor/adm1272.c b/hw/sensor/adm1272.c
index 0c739aa0d85..0aa2a865568 100644
--- a/hw/sensor/adm1272.c
+++ b/hw/sensor/adm1272.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/pmbus_device.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/sensor/max31785.c b/hw/sensor/max31785.c
index c75581455a2..468858a60e4 100644
--- a/hw/sensor/max31785.c
+++ b/hw/sensor/max31785.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/pmbus_device.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/sensor/max34451.c b/hw/sensor/max34451.c
index a369d2b5319..4d64434f3af 100644
--- a/hw/sensor/max34451.c
+++ b/hw/sensor/max34451.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/pmbus_device.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index f5b61109e36..4e5c968bcc7 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/sensor/tmp105.h"
 #include "qapi/error.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index bccd40f5712..5352f23ae82 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -39,7 +39,7 @@
 #include "net/net.h"
 #include "sh7750_regs.h"
 #include "hw/ide/mmio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/loader.h"
 #include "hw/usb/usb.h"
 #include "hw/block/flash.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 300eabc595d..6cb42e34412 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sh4/sh.h"
 #include "system/system.h"
 #include "target/sh4/cpu.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 367beecf192..500b63bc9b7 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/datadir.h"
 #include "cpu.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index b0d2d6f8bc8..fa5592f26cb 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -49,7 +49,7 @@
 #include "hw/char/escc.h"
 #include "hw/misc/empty_slot.h"
 #include "hw/misc/unimp.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/or-irq.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index a7ff36ee78c..9ce2e3b7fc8 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 62ceb7eef4d..5b25ba81cc8 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -29,7 +29,7 @@
 #include "qemu/datadir.h"
 #include "cpu.h"
 #include "exec/target_page.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/ssi/allwinner-a10-spi.c b/hw/ssi/allwinner-a10-spi.c
index 6b7cca8d32a..69920b935af 100644
--- a/hw/ssi/allwinner-a10-spi.c
+++ b/hw/ssi/allwinner-a10-spi.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ssi/allwinner-a10-spi.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index e33496f5029..9819904a4ad 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -33,7 +33,7 @@
 #include "qemu/units.h"
 #include "trace.h"
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ssi/aspeed_smc.h"
 
diff --git a/hw/ssi/bcm2835_spi.c b/hw/ssi/bcm2835_spi.c
index bf8ba35e04c..01763c458c1 100644
--- a/hw/ssi/bcm2835_spi.c
+++ b/hw/ssi/bcm2835_spi.c
@@ -26,7 +26,7 @@
 #include "qemu/log.h"
 #include "qemu/fifo8.h"
 #include "hw/ssi/bcm2835_spi.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "migration/vmstate.h"
 
 static void bcm2835_spi_update_int(BCM2835SPIState *s)
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index f05be687483..63f4cce5129 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -28,7 +28,7 @@
 #include "qemu/module.h"
 #include "hw/registerfields.h"
 #include "hw/ssi/ibex_spi_host.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 1312f588d2e..8e014b7a7bb 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ssi/imx_spi.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index fd7ba7eeb04..3c118fc0f8c 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ssi/mss-spi.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 056ce13394f..bc5e4e20ccd 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ssi/npcm7xx_fiu.h"
 #include "migration/vmstate.h"
diff --git a/hw/ssi/npcm_pspi.c b/hw/ssi/npcm_pspi.c
index a31dcc050e8..1f11e1f8a46 100644
--- a/hw/ssi/npcm_pspi.c
+++ b/hw/ssi/npcm_pspi.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/registerfields.h"
 #include "hw/ssi/npcm_pspi.h"
 #include "migration/vmstate.h"
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index 1dc0bcbcc04..1851118d55f 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ssi/pl022.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/log.h"
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index f40e8836b9c..e59386712b4 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -14,7 +14,7 @@
 #include "hw/ssi/pnv_spi_regs.h"
 #include "hw/ssi/ssi.h"
 #include <libfdt.h>
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "trace.h"
 
 #define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
diff --git a/hw/ssi/sifive_spi.c b/hw/ssi/sifive_spi.c
index 3e01fef61cd..c66fae80a9c 100644
--- a/hw/ssi/sifive_spi.c
+++ b/hw/ssi/sifive_spi.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/ssi/ssi.h"
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 4144c8a6270..9e8656b5560 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -31,7 +31,7 @@
 #include "qemu/module.h"
 #include "qemu/fifo8.h"
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a79f3b8e494..b2f66275182 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index 56d51ce0e30..88fafb5a2ed 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -28,7 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
 
 #ifndef XILINX_VERSAL_OSPI_ERR_DEBUG
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 690140f5a6c..a0b73fb7311 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/a9gtimer.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index e4c353273a1..6c0d3b556a2 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/timer/allwinner-a10-pit.h"
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 7cc5915e9ec..ac6313039a8 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/arm_mptimer.h"
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 56638ff5cdc..e5ef28de6f7 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -11,7 +11,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index 7e4ddcd4058..c9e0f4c2e17 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/timer/armv7m_systick.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-clock.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 57db03512f4..b08a737bc97 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/timer/aspeed_timer.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
index 012d8290018..0f1fda4218f 100644
--- a/hw/timer/avr_timer16.c
+++ b/hw/timer/avr_timer16.c
@@ -34,7 +34,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/avr_timer16.h"
 #include "trace.h"
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 9c7ba168768..6f02c6a02d9 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -17,7 +17,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index 34c550a3f98..57fea11a855 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-clock.h"
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 4095267b4aa..8b7595731cc 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -33,7 +33,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-clock.h"
 #include "hw/timer/cmsdk-apb-timer.h"
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index bb0f9c8b9a6..06524efca27 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -61,7 +61,7 @@
 #include "hw/ptimer.h"
 
 #include "hw/arm/exynos4210.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qom/object.h"
 
 //#define DEBUG_MCT
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index 69f737a8e6f..dc76932fdfb 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -29,7 +29,7 @@
 #include "hw/ptimer.h"
 
 #include "hw/arm/exynos4210.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qom/object.h"
 
 //#define DEBUG_PWM
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 0e06fa09e99..6218c255d2c 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -28,7 +28,7 @@
 #include "hw/timer/grlib_gptimer.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1acba4fa9db..1387c417ae1 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 7033ebf50da..1a8b6bf9abe 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index c7320ef30fa..d2c4f86e038 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -29,7 +29,7 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "hw/timer/ibex_timer.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "target/riscv/cpu.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index 6123321c352..c67a39f10cc 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "hw/timer/imx_epit.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/misc/imx_ccm.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 8c7cbfdeac3..168cadcb3f9 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/timer/imx_gpt.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index 2ce821178b6..946e87c99a6 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/mss-timer.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index 6a116ad54b7..e09e4ee03ad 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/npcm7xx_timer.h"
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index e228fdebc34..0688f49eefb 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -15,7 +15,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/arm/nrf51.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/timer/nrf51_timer.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 6d4ac31574e..d18d98b2337 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "qemu/timer.h"
 #include "system/runstate.h"
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
index cdff7f47f16..c62dad690ff 100644
--- a/hw/timer/renesas_cmt.c
+++ b/hw/timer/renesas_cmt.c
@@ -23,7 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/renesas_cmt.h"
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index 95707f2b8c5..1fc539e9497 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -23,7 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/renesas_tmr.h"
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index d4fa32c9d65..adc05715528 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "system/memory.h"
 #include "qemu/log.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sh4/sh.h"
 #include "hw/timer/tmu012.h"
 #include "hw/ptimer.h"
diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
index e85e389f7a5..f1882ae6bc1 100644
--- a/hw/timer/sifive_pwm.c
+++ b/hw/timer/sifive_pwm.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "trace.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/timer/sifive_pwm.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 3e071fbdb4c..5bf94157ca4 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index c5fd038162b..fc48179d25d 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -41,7 +41,7 @@
 #include "hw/timer/sse-timer.h"
 #include "hw/timer/sse-counter.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/registerfields.h"
 #include "hw/core/clock.h"
 #include "hw/qdev-clock.h"
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index be844e7f5a3..979b6ad5bae 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index ff4a224d08f..c1b6d2bdf2d 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index cdd0df11374..1615be29339 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -23,7 +23,7 @@
  * TPM Profile (PTP) Specification, Family 2.0, Revision 00.43
  */
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "qapi/error.h"
 #include "qemu/bswap.h"
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 0577747f469..cab42ae7b65 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "scsi/constants.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "trace.h"
 #include "ufs.h"
 
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index b090f253656..57f930b0998 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -28,7 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/usb/ehci-regs.h"
 #include "hw/usb/hcd-ehci.h"
 #include "migration/vmstate.h"
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 2d3c770b117..5c3434153db 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index c48f07f7e39..ea3d5d2bd14 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -26,7 +26,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 124ac4faec0..c243a4f42cc 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -31,7 +31,7 @@
 #include "hw/usb/uhci-regs.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index 244698e5f2b..862673054a0 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "hcd-xhci-sysbus.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 static bool xhci_sysbus_intr_raise(XHCIState *xhci, int n, bool level)
 {
diff --git a/hw/usb/vt82c686-uhci-pci.c b/hw/usb/vt82c686-uhci-pci.c
index 61628061722..97c09a51cfc 100644
--- a/hw/usb/vt82c686-uhci-pci.c
+++ b/hw/usb/vt82c686-uhci-pci.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/isa/vt82c686.h"
 #include "hcd-uhci.h"
 
diff --git a/hw/usb/xlnx-versal-usb2-ctrl-regs.c b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
index 4114672d4f4..eb946b5dbd9 100644
--- a/hw/usb/xlnx-versal-usb2-ctrl-regs.c
+++ b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
@@ -29,7 +29,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/register.h"
 #include "qemu/bitops.h"
 #include "qom/object.h"
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index c05c00bcd4a..d54d70b4fb8 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "standard-headers/linux/virtio_mmio.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/virtio/virtio.h"
diff --git a/hw/vmapple/aes.c b/hw/vmapple/aes.c
index a4853a98f8c..a6e94610b85 100644
--- a/hw/vmapple/aes.c
+++ b/hw/vmapple/aes.c
@@ -14,7 +14,7 @@
 #include "crypto/hash.h"
 #include "crypto/aes.h"
 #include "crypto/cipher.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/vmapple/vmapple.h"
 #include "migration/vmstate.h"
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 5da28cf72b2..9154a4c2576 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "monitor/qdev.h"
 #include "hw/core/boards.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 6a8d07ca569..e1a2a33d73e 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -27,7 +27,7 @@
 #include "qemu/module.h"
 #include "system/watchdog.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-clock.h"
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index c3fc501fe6e..f365222019a 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -11,7 +11,7 @@
 #include "qemu/units.h"
 #include "qapi/visitor.h"
 #include "hw/core/boards.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "system/tpm.h"
 #include "system/tpm_backend.h"
 #include "system/runstate.h"
diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index 8211c993eb7..07c3731aef0 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -26,7 +26,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/xtensa/mx_pic.h"
 #include "qemu/log.h"
 
diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index e3885316106..c00167859a2 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cpu-interrupt.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "qemu/atomic.h"
diff --git a/system/qtest.c b/system/qtest.c
index cbeb7f37728..6cf686a31ec 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -20,7 +20,7 @@
 #include "system/memory.h"
 #include "exec/tswap.h"
 #include "hw/qdev-core.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/core/cpu.h"
 #include "qemu/accel.h"
 #include "system/cpu-timers.h"
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 1ed52a211a6..e31827342d9 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -6,7 +6,7 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "exec/icount.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "cpu.h"
 #include "cpu-features.h"
 #include "cpregs.h"
diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 31c01eddc87..47e1e4652b1 100644
--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -6,7 +6,7 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "exec/icount.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "cpu.h"
 #include "cpu-features.h"
 #include "cpregs.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27ebc6f29b8..263ca29d92b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -20,7 +20,7 @@
 #include "qemu/qemu-print.h"
 #include "exec/cputlb.h"
 #include "exec/translation-block.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "system/cpu-timers.h"
 #include "exec/icount.h"
 #include "system/kvm.h"
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 93806fa8005..2b544eaf04d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -26,7 +26,7 @@
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "hw/core/boards.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/main-loop.h"
 #include "system/cpus.h"
 #include "arm-powerctl.h"
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c7ea6fc2f62..12a63602b11 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -34,7 +34,7 @@
 #include "system/address-spaces.h"
 #include "gdbstub/enums.h"
 #include "hw/core/boards.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "hw/acpi/acpi.h"
diff --git a/target/i386/tcg/system/fpu_helper.c b/target/i386/tcg/system/fpu_helper.c
index 0b4fa187dfb..26b24d40356 100644
--- a/target/i386/tcg/system/fpu_helper.c
+++ b/target/i386/tcg/system/fpu_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 
 static qemu_irq ferr_irq;
 
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 6412584e1bd..8ed62acf84d 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -20,7 +20,7 @@
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/loongarch/virt.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index c1a8ba3089c..cd35ca93c7a 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -14,7 +14,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "cpu-csr.h"
 #include "cpu-mmu.h"
 
diff --git a/target/mips/system/cp0_timer.c b/target/mips/system/cp0_timer.c
index ca16945cee1..afa163c3196 100644
--- a/target/mips/system/cp0_timer.c
+++ b/target/mips/system/cp0_timer.c
@@ -21,7 +21,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/timer.h"
 #include "system/kvm.h"
 #include "internal.h"
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 301d8de67fd..1d99e5f4908 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -38,7 +38,7 @@
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "hw/core/boards.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "hw/intc/riscv_imsic.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
diff --git a/target/rx/helper.c b/target/rx/helper.c
index e9a7aaf610d..9a78f1457f5 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/log.h"
 #include "accel/tcg/cpu-ldst.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "qemu/plugin.h"
 
 void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index b0b6e2993eb..b83f5f4fe62 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -16,7 +16,7 @@
 #include "qemu/log.h"
 #include "block/aio-wait.h"
 #include "hw/sysbus.h"
-#include "hw/irq.h"
+#include "hw/core/irq.h"
 #include "apple-gfx.h"
 #include "trace.h"
 
-- 
2.51.1


