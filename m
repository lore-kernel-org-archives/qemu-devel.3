Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C57D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObsm-0004dr-12; Thu, 27 Nov 2025 08:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr9-0002nJ-1s
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr4-0001JL-Cg
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=88bRV2EydA50jQjJcsdXKhyl30ziN5BACYW6xA0mepM=;
 b=WKBUgJcWJaQRLHNTI3lMtlOh9X3V68XpGvoKnZMZHeasy+eFUZg5MfFktUCOZT7zdWEYWY
 uE3lLH69P7uPpppUKeLUoGOfwmiimcTPcmLWWinmv/8VqZBfw3dAntBBxHTGfYWP0+9MiP
 Cebc9nZXtBeJs/9ERekZXUh7UOYh+lk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-CWQGTTJ0M0a0qpe0J7O3ZA-1; Thu, 27 Nov 2025 08:16:06 -0500
X-MC-Unique: CWQGTTJ0M0a0qpe0J7O3ZA-1
X-Mimecast-MFC-AGG-ID: CWQGTTJ0M0a0qpe0J7O3ZA_1764249366
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-640ed3ad89bso1446655a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249365; x=1764854165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=88bRV2EydA50jQjJcsdXKhyl30ziN5BACYW6xA0mepM=;
 b=KGzR/yU9H9v4MP0h7NWXgkN8eXmKxttq4zjit8ZGBnuB+3OCpZUroG2SZRrfKveeg1
 blz4cwbCK+jEEl2pWCvX6s6AmrYsJj3wAYeIKU0/5HtQaL67Go/TgQ56gntUrevYajiY
 pWWzIxJhpG42cNm4BxPKYoulfNwj2BxTCryFpnhNsWLm2DEzuCDdmYLtDkdxDw7HkNko
 iBpdgqgRIFY96Vik8iiAJpg0QMr4RxFMZxR753t1/aZMnGGd5RKkb0341b3KFm5RGorY
 EIPK13IlGPirbOy/SupBBfJGzz2bgvC0drW29UxmGG1W5Gd8hBu4VhrrZi+q6CzVtHoy
 K/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249365; x=1764854165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=88bRV2EydA50jQjJcsdXKhyl30ziN5BACYW6xA0mepM=;
 b=jYQGaGd75NYHhSA3XCEy/981TrV5XZZ7mXkzFJGHq4ycEBO2fBSpMfGyMrARvv/JDF
 YEwmUAnuz9x3b+Py1XM/wi7SaOu9pFSexrM9gR5eViywwccsk24PjoM2SGXgVQNTVwvk
 ioIy3TUYRXU4OYPH2WktdmYXyXXcJAU253Auw0DOzSGPhjGbQ1ecYd3NpkArDWym9B/o
 f/sxPRTi1NE5i42OTBaSdGF7/s2xiwdnNVL2kAJVxnH2CuEpP35JivUDlE2IM8JlMK4d
 U9+vSUwM0PE21ky3fpRcZ/HzyFZUDAqEGrCnwWhDNVrFjhIb283xR/wM0v9XtxZrvajQ
 3Yrw==
X-Gm-Message-State: AOJu0Ywye/mli7ZoRpWzFXUTNybQF6CT6LIyhoUlSth8N1FwGS5UAceW
 J43I6tAS0AYtpk/2/HOhibJXBnAvblfSbsOPRsUF6LJK/2rb4XUYxhcPDgLYtFu2XxlF2+3TFQ/
 kzBTpjXi7JXH1LJQSb1r/pGQZh+0IQChW3fgVDX2aK4rVupuEbDc+L8SDIfEH8tMLQwFlGd80TR
 5/ztMeMbXB3tzTS24DaeFjhYihuYvBXdMn9+eTMUMp
X-Gm-Gg: ASbGnctTG1p3wksJR/hgNIyJfzYoH9RwdcUJKtL/aic2PJ4bSQs2zsyL/6yHwuJJuSq
 +AgCTpCloWPJsLytgs3yZyRgMrkIBrcoQ5g09ac7IsjkLJQfQ+H7DU/ugUv00xnAMyFWTL9CbSZ
 KI9cGv3RqYQc6IV5PXBULeYwU7sqgiaqDC+zcLdplZS82MKxeB40kybtuU6qBxnzIoI0Nmbhh6v
 P1KsG0Xe8QBTmpV7MrPGqWWV02EG+zulyWZWKrUB2cd+tRXZziO280qqI787fVoidRUNSEH3cTd
 BJx8BjGl2qeFfsJcLK/DTVUqJQGKMXq4sAe+iYHlaVIKGnuEg+qShoG1rzKXBBSFBevuE8JsPLE
 lfphvxG0EoQRAfi58J0RIIsZkSA5fn7x8wCuEyBucoIb8y4ogLTwa5sZw+eUPmNIOw1RD03k8rM
 MgRpJFiRs+x0xnsIw=
X-Received: by 2002:a17:906:c105:b0:b76:ddc0:d87 with SMTP id
 a640c23a62f3a-b76ddc037eemr713378066b.2.1764249363525; 
 Thu, 27 Nov 2025 05:16:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfOJ6oOtVSzs9DyugOdQ6nBR8AjOOaJEz30mt0hzaxr6Bsq2M29DW85lHSfl1LC37rPLqFFw==
X-Received: by 2002:a17:906:c105:b0:b76:ddc0:d87 with SMTP id
 a640c23a62f3a-b76ddc037eemr713363566b.2.1764249361841; 
 Thu, 27 Nov 2025 05:16:01 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59e8936sm156194266b.48.2025.11.27.05.16.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:16:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/28] include: move hw/sysbus.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:12 +0100
Message-ID: <20251127131516.80807-26-pbonzini@redhat.com>
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
 hw/i386/kvm/xen_evtchn.h                    | 2 +-
 hw/intc/ioapic_internal.h                   | 2 +-
 hw/net/fsl_etsec/etsec.h                    | 2 +-
 hw/ppc/e500-ccsr.h                          | 2 +-
 hw/scsi/lasi_ncr710.h                       | 2 +-
 hw/scsi/ncr53c710.h                         | 2 +-
 hw/usb/hcd-dwc2.h                           | 2 +-
 hw/usb/hcd-ehci.h                           | 2 +-
 hw/usb/hcd-ohci.h                           | 2 +-
 hw/usb/hcd-xhci-sysbus.h                    | 2 +-
 include/hw/acpi/generic_event_device.h      | 2 +-
 include/hw/adc/aspeed_adc.h                 | 2 +-
 include/hw/adc/npcm7xx_adc.h                | 2 +-
 include/hw/adc/stm32f2xx_adc.h              | 2 +-
 include/hw/adc/zynq-xadc.h                  | 2 +-
 include/hw/arm/armsse.h                     | 2 +-
 include/hw/arm/armv7m.h                     | 2 +-
 include/hw/arm/bcm2835_peripherals.h        | 2 +-
 include/hw/arm/exynos4210.h                 | 2 +-
 include/hw/arm/fsl-imx8mp.h                 | 2 +-
 include/hw/arm/nrf51_soc.h                  | 2 +-
 include/hw/arm/smmu-common.h                | 2 +-
 include/hw/arm/xlnx-versal.h                | 2 +-
 include/hw/audio/asc.h                      | 2 +-
 include/hw/block/swim.h                     | 2 +-
 include/hw/char/avr_usart.h                 | 2 +-
 include/hw/char/bcm2835_aux.h               | 2 +-
 include/hw/char/cadence_uart.h              | 2 +-
 include/hw/char/cmsdk-apb-uart.h            | 2 +-
 include/hw/char/digic-uart.h                | 2 +-
 include/hw/char/escc.h                      | 2 +-
 include/hw/char/goldfish_tty.h              | 2 +-
 include/hw/char/ibex_uart.h                 | 2 +-
 include/hw/char/imx_serial.h                | 2 +-
 include/hw/char/max78000_uart.h             | 2 +-
 include/hw/char/mchp_pfsoc_mmuart.h         | 2 +-
 include/hw/char/nrf51_uart.h                | 2 +-
 include/hw/char/pl011.h                     | 2 +-
 include/hw/char/renesas_sci.h               | 2 +-
 include/hw/char/serial-mm.h                 | 2 +-
 include/hw/char/shakti_uart.h               | 2 +-
 include/hw/char/sifive_uart.h               | 2 +-
 include/hw/char/stm32f2xx_usart.h           | 2 +-
 include/hw/char/stm32l4x5_usart.h           | 2 +-
 include/hw/core/or-irq.h                    | 2 +-
 include/hw/core/platform-bus.h              | 2 +-
 include/hw/core/split-irq.h                 | 2 +-
 include/hw/{ => core}/sysbus.h              | 0
 include/hw/cpu/a15mpcore.h                  | 2 +-
 include/hw/cpu/a9mpcore.h                   | 2 +-
 include/hw/cpu/arm11mpcore.h                | 2 +-
 include/hw/display/bcm2835_fb.h             | 2 +-
 include/hw/display/macfb.h                  | 2 +-
 include/hw/display/xlnx_dp.h                | 2 +-
 include/hw/dma/bcm2835_dma.h                | 2 +-
 include/hw/dma/pl080.h                      | 2 +-
 include/hw/dma/sifive_pdma.h                | 2 +-
 include/hw/dma/xlnx-zdma.h                  | 2 +-
 include/hw/dma/xlnx-zynq-devcfg.h           | 2 +-
 include/hw/dma/xlnx_csu_dma.h               | 2 +-
 include/hw/dma/xlnx_dpdma.h                 | 2 +-
 include/hw/fsi/aspeed_apb2opb.h             | 2 +-
 include/hw/gpio/aspeed_gpio.h               | 2 +-
 include/hw/gpio/bcm2835_gpio.h              | 2 +-
 include/hw/gpio/bcm2838_gpio.h              | 2 +-
 include/hw/gpio/imx_gpio.h                  | 2 +-
 include/hw/gpio/npcm7xx_gpio.h              | 2 +-
 include/hw/gpio/nrf51_gpio.h                | 2 +-
 include/hw/gpio/sifive_gpio.h               | 2 +-
 include/hw/gpio/stm32l4x5_gpio.h            | 2 +-
 include/hw/hyperv/vmbus-bridge.h            | 2 +-
 include/hw/i2c/allwinner-i2c.h              | 2 +-
 include/hw/i2c/arm_sbcon_i2c.h              | 2 +-
 include/hw/i2c/aspeed_i2c.h                 | 2 +-
 include/hw/i2c/bcm2835_i2c.h                | 2 +-
 include/hw/i2c/imx_i2c.h                    | 2 +-
 include/hw/i2c/microbit_i2c.h               | 2 +-
 include/hw/i2c/npcm7xx_smbus.h              | 2 +-
 include/hw/i2c/ppc4xx_i2c.h                 | 2 +-
 include/hw/i386/x86-iommu.h                 | 2 +-
 include/hw/ide/ahci-sysbus.h                | 2 +-
 include/hw/input/i8042.h                    | 2 +-
 include/hw/input/lasips2.h                  | 2 +-
 include/hw/input/pl050.h                    | 2 +-
 include/hw/input/ps2.h                      | 2 +-
 include/hw/input/stellaris_gamepad.h        | 2 +-
 include/hw/intc/allwinner-a10-pic.h         | 2 +-
 include/hw/intc/arm_gic_common.h            | 2 +-
 include/hw/intc/arm_gicv3_common.h          | 2 +-
 include/hw/intc/arm_gicv3_its_common.h      | 2 +-
 include/hw/intc/armv7m_nvic.h               | 2 +-
 include/hw/intc/aspeed_intc.h               | 2 +-
 include/hw/intc/aspeed_vic.h                | 2 +-
 include/hw/intc/bcm2835_ic.h                | 2 +-
 include/hw/intc/bcm2836_control.h           | 2 +-
 include/hw/intc/exynos4210_combiner.h       | 2 +-
 include/hw/intc/exynos4210_gic.h            | 2 +-
 include/hw/intc/goldfish_pic.h              | 2 +-
 include/hw/intc/grlib_irqmp.h               | 2 +-
 include/hw/intc/heathrow_pic.h              | 2 +-
 include/hw/intc/imx_avic.h                  | 2 +-
 include/hw/intc/imx_gpcv2.h                 | 2 +-
 include/hw/intc/loongarch_dintc.h           | 2 +-
 include/hw/intc/loongarch_extioi_common.h   | 2 +-
 include/hw/intc/loongarch_pch_msi.h         | 2 +-
 include/hw/intc/loongarch_pic_common.h      | 2 +-
 include/hw/intc/loongson_ipi.h              | 2 +-
 include/hw/intc/loongson_ipi_common.h       | 2 +-
 include/hw/intc/loongson_liointc.h          | 2 +-
 include/hw/intc/m68k_irqc.h                 | 2 +-
 include/hw/intc/mips_gic.h                  | 2 +-
 include/hw/intc/realview_gic.h              | 2 +-
 include/hw/intc/riscv_aclint.h              | 2 +-
 include/hw/intc/riscv_aplic.h               | 2 +-
 include/hw/intc/riscv_imsic.h               | 2 +-
 include/hw/intc/rx_icu.h                    | 2 +-
 include/hw/intc/sifive_plic.h               | 2 +-
 include/hw/intc/xlnx-pmu-iomod-intc.h       | 2 +-
 include/hw/intc/xlnx-zynqmp-ipi.h           | 2 +-
 include/hw/m68k/q800-glue.h                 | 2 +-
 include/hw/mem/npcm7xx_mc.h                 | 2 +-
 include/hw/mips/cps.h                       | 2 +-
 include/hw/misc/a9scu.h                     | 2 +-
 include/hw/misc/allwinner-a10-ccm.h         | 2 +-
 include/hw/misc/allwinner-a10-dramc.h       | 2 +-
 include/hw/misc/allwinner-cpucfg.h          | 2 +-
 include/hw/misc/allwinner-h3-ccu.h          | 2 +-
 include/hw/misc/allwinner-h3-dramc.h        | 2 +-
 include/hw/misc/allwinner-h3-sysctrl.h      | 2 +-
 include/hw/misc/allwinner-r40-ccu.h         | 2 +-
 include/hw/misc/allwinner-r40-dramc.h       | 2 +-
 include/hw/misc/allwinner-sid.h             | 2 +-
 include/hw/misc/allwinner-sramc.h           | 2 +-
 include/hw/misc/arm11scu.h                  | 2 +-
 include/hw/misc/armsse-cpu-pwrctrl.h        | 2 +-
 include/hw/misc/armsse-cpuid.h              | 2 +-
 include/hw/misc/armsse-mhu.h                | 2 +-
 include/hw/misc/armv7m_ras.h                | 2 +-
 include/hw/misc/aspeed_hace.h               | 2 +-
 include/hw/misc/aspeed_i3c.h                | 2 +-
 include/hw/misc/aspeed_lpc.h                | 2 +-
 include/hw/misc/aspeed_peci.h               | 2 +-
 include/hw/misc/aspeed_sbc.h                | 2 +-
 include/hw/misc/aspeed_scu.h                | 2 +-
 include/hw/misc/aspeed_sdmc.h               | 2 +-
 include/hw/misc/aspeed_sli.h                | 2 +-
 include/hw/misc/aspeed_xdma.h               | 2 +-
 include/hw/misc/avr_power.h                 | 2 +-
 include/hw/misc/bcm2835_cprman.h            | 2 +-
 include/hw/misc/bcm2835_mbox.h              | 2 +-
 include/hw/misc/bcm2835_mphi.h              | 2 +-
 include/hw/misc/bcm2835_powermgt.h          | 2 +-
 include/hw/misc/bcm2835_property.h          | 2 +-
 include/hw/misc/bcm2835_rng.h               | 2 +-
 include/hw/misc/bcm2835_thermal.h           | 2 +-
 include/hw/misc/djmemc.h                    | 2 +-
 include/hw/misc/imx6_src.h                  | 2 +-
 include/hw/misc/imx7_gpr.h                  | 2 +-
 include/hw/misc/imx7_snvs.h                 | 2 +-
 include/hw/misc/imx7_src.h                  | 2 +-
 include/hw/misc/imx8mp_analog.h             | 2 +-
 include/hw/misc/imx_ccm.h                   | 2 +-
 include/hw/misc/imx_rngc.h                  | 2 +-
 include/hw/misc/iotkit-secctl.h             | 2 +-
 include/hw/misc/iotkit-sysctl.h             | 2 +-
 include/hw/misc/iotkit-sysinfo.h            | 2 +-
 include/hw/misc/ivshmem-flat.h              | 2 +-
 include/hw/misc/lasi.h                      | 2 +-
 include/hw/misc/mac_via.h                   | 2 +-
 include/hw/misc/macio/gpio.h                | 2 +-
 include/hw/misc/max78000_aes.h              | 2 +-
 include/hw/misc/max78000_gcr.h              | 2 +-
 include/hw/misc/max78000_icc.h              | 2 +-
 include/hw/misc/max78000_trng.h             | 2 +-
 include/hw/misc/mchp_pfsoc_dmc.h            | 2 +-
 include/hw/misc/mchp_pfsoc_ioscb.h          | 2 +-
 include/hw/misc/mchp_pfsoc_sysreg.h         | 2 +-
 include/hw/misc/mips_cmgcr.h                | 2 +-
 include/hw/misc/mips_cpc.h                  | 2 +-
 include/hw/misc/mips_itu.h                  | 2 +-
 include/hw/misc/mos6522.h                   | 2 +-
 include/hw/misc/mps2-fpgaio.h               | 2 +-
 include/hw/misc/mps2-scc.h                  | 2 +-
 include/hw/misc/msf2-sysreg.h               | 2 +-
 include/hw/misc/npcm7xx_mft.h               | 2 +-
 include/hw/misc/npcm7xx_pwm.h               | 2 +-
 include/hw/misc/npcm7xx_rng.h               | 2 +-
 include/hw/misc/npcm_clk.h                  | 2 +-
 include/hw/misc/npcm_gcr.h                  | 2 +-
 include/hw/misc/nrf51_rng.h                 | 2 +-
 include/hw/misc/sifive_e_aon.h              | 2 +-
 include/hw/misc/sifive_e_prci.h             | 2 +-
 include/hw/misc/sifive_test.h               | 2 +-
 include/hw/misc/sifive_u_otp.h              | 2 +-
 include/hw/misc/sifive_u_prci.h             | 2 +-
 include/hw/misc/stm32_rcc.h                 | 2 +-
 include/hw/misc/stm32f2xx_syscfg.h          | 2 +-
 include/hw/misc/stm32f4xx_exti.h            | 2 +-
 include/hw/misc/stm32f4xx_syscfg.h          | 2 +-
 include/hw/misc/stm32l4x5_exti.h            | 2 +-
 include/hw/misc/stm32l4x5_rcc.h             | 2 +-
 include/hw/misc/stm32l4x5_syscfg.h          | 2 +-
 include/hw/misc/tz-mpc.h                    | 2 +-
 include/hw/misc/tz-msc.h                    | 2 +-
 include/hw/misc/tz-ppc.h                    | 2 +-
 include/hw/misc/unimp.h                     | 2 +-
 include/hw/misc/virt_ctrl.h                 | 2 +-
 include/hw/misc/xlnx-versal-cframe-reg.h    | 2 +-
 include/hw/misc/xlnx-versal-cfu.h           | 2 +-
 include/hw/misc/xlnx-versal-crl.h           | 2 +-
 include/hw/misc/xlnx-versal-pmc-iou-slcr.h  | 2 +-
 include/hw/misc/xlnx-versal-trng.h          | 2 +-
 include/hw/misc/xlnx-versal-xramc.h         | 2 +-
 include/hw/misc/xlnx-zynqmp-apu-ctrl.h      | 2 +-
 include/hw/misc/xlnx-zynqmp-crf.h           | 2 +-
 include/hw/net/allwinner-sun8i-emac.h       | 2 +-
 include/hw/net/allwinner_emac.h             | 2 +-
 include/hw/net/cadence_gem.h                | 2 +-
 include/hw/net/dp8393x.h                    | 2 +-
 include/hw/net/ftgmac100.h                  | 2 +-
 include/hw/net/imx_fec.h                    | 2 +-
 include/hw/net/lan9118_phy.h                | 2 +-
 include/hw/net/lance.h                      | 2 +-
 include/hw/net/lasi_82596.h                 | 2 +-
 include/hw/net/msf2-emac.h                  | 2 +-
 include/hw/net/npcm7xx_emc.h                | 2 +-
 include/hw/net/npcm_gmac.h                  | 2 +-
 include/hw/net/npcm_pcs.h                   | 2 +-
 include/hw/net/xlnx-zynqmp-can.h            | 2 +-
 include/hw/nubus/nubus.h                    | 2 +-
 include/hw/nvram/bcm2835_otp.h              | 2 +-
 include/hw/nvram/fw_cfg.h                   | 2 +-
 include/hw/nvram/mac_nvram.h                | 2 +-
 include/hw/nvram/npcm7xx_otp.h              | 2 +-
 include/hw/nvram/nrf51_nvm.h                | 2 +-
 include/hw/nvram/xlnx-bbram.h               | 2 +-
 include/hw/nvram/xlnx-versal-efuse.h        | 2 +-
 include/hw/nvram/xlnx-zynqmp-efuse.h        | 2 +-
 include/hw/pci-host/aspeed_pcie.h           | 2 +-
 include/hw/pci-host/designware.h            | 2 +-
 include/hw/pci-host/fsl_imx8m_phy.h         | 2 +-
 include/hw/pci-host/gpex.h                  | 2 +-
 include/hw/pci-host/xilinx-pcie.h           | 2 +-
 include/hw/pci/pci_host.h                   | 2 +-
 include/hw/ppc/mac_dbdma.h                  | 2 +-
 include/hw/ppc/openpic.h                    | 2 +-
 include/hw/ppc/pnv.h                        | 2 +-
 include/hw/ppc/pnv_chip.h                   | 2 +-
 include/hw/ppc/pnv_pnor.h                   | 2 +-
 include/hw/ppc/pnv_psi.h                    | 2 +-
 include/hw/ppc/ppc4xx.h                     | 2 +-
 include/hw/ppc/xive.h                       | 2 +-
 include/hw/ppc/xive2.h                      | 2 +-
 include/hw/riscv/numa.h                     | 2 +-
 include/hw/riscv/riscv_hart.h               | 2 +-
 include/hw/riscv/spike.h                    | 2 +-
 include/hw/riscv/virt.h                     | 2 +-
 include/hw/rtc/allwinner-rtc.h              | 2 +-
 include/hw/rtc/aspeed_rtc.h                 | 2 +-
 include/hw/rtc/goldfish_rtc.h               | 2 +-
 include/hw/rtc/pl031.h                      | 2 +-
 include/hw/rtc/xlnx-zynqmp-rtc.h            | 2 +-
 include/hw/s390x/3270-ccw.h                 | 2 +-
 include/hw/s390x/css-bridge.h               | 2 +-
 include/hw/s390x/s390_flic.h                | 2 +-
 include/hw/s390x/sclp.h                     | 2 +-
 include/hw/scsi/esp.h                       | 2 +-
 include/hw/sd/allwinner-sdhost.h            | 2 +-
 include/hw/sd/bcm2835_sdhost.h              | 2 +-
 include/hw/sd/sdhci.h                       | 2 +-
 include/hw/sparc/sparc32_dma.h              | 2 +-
 include/hw/sparc/sun4m_iommu.h              | 2 +-
 include/hw/sparc/sun4u_iommu.h              | 2 +-
 include/hw/ssi/allwinner-a10-spi.h          | 2 +-
 include/hw/ssi/aspeed_smc.h                 | 2 +-
 include/hw/ssi/bcm2835_spi.h                | 2 +-
 include/hw/ssi/ibex_spi_host.h              | 2 +-
 include/hw/ssi/imx_spi.h                    | 2 +-
 include/hw/ssi/mss-spi.h                    | 2 +-
 include/hw/ssi/npcm7xx_fiu.h                | 2 +-
 include/hw/ssi/npcm_pspi.h                  | 2 +-
 include/hw/ssi/pl022.h                      | 2 +-
 include/hw/ssi/pnv_spi.h                    | 2 +-
 include/hw/ssi/sifive_spi.h                 | 2 +-
 include/hw/ssi/stm32f2xx_spi.h              | 2 +-
 include/hw/ssi/xilinx_spips.h               | 2 +-
 include/hw/timer/a9gtimer.h                 | 2 +-
 include/hw/timer/allwinner-a10-pit.h        | 2 +-
 include/hw/timer/arm_mptimer.h              | 2 +-
 include/hw/timer/armv7m_systick.h           | 2 +-
 include/hw/timer/avr_timer16.h              | 2 +-
 include/hw/timer/bcm2835_systmr.h           | 2 +-
 include/hw/timer/cadence_ttc.h              | 2 +-
 include/hw/timer/cmsdk-apb-dualtimer.h      | 2 +-
 include/hw/timer/cmsdk-apb-timer.h          | 2 +-
 include/hw/timer/digic-timer.h              | 2 +-
 include/hw/timer/ibex_timer.h               | 2 +-
 include/hw/timer/imx_epit.h                 | 2 +-
 include/hw/timer/imx_gpt.h                  | 2 +-
 include/hw/timer/mss-timer.h                | 2 +-
 include/hw/timer/npcm7xx_timer.h            | 2 +-
 include/hw/timer/nrf51_timer.h              | 2 +-
 include/hw/timer/renesas_cmt.h              | 2 +-
 include/hw/timer/renesas_tmr.h              | 2 +-
 include/hw/timer/sifive_pwm.h               | 2 +-
 include/hw/timer/sse-counter.h              | 2 +-
 include/hw/timer/sse-timer.h                | 2 +-
 include/hw/timer/stellaris-gptm.h           | 2 +-
 include/hw/timer/stm32f2xx_timer.h          | 2 +-
 include/hw/tricore/tc27x_soc.h              | 2 +-
 include/hw/tricore/tricore_testdevice.h     | 2 +-
 include/hw/usb/imx-usb-phy.h                | 2 +-
 include/hw/usb/xlnx-usb-subsystem.h         | 2 +-
 include/hw/usb/xlnx-versal-usb2-ctrl-regs.h | 2 +-
 include/hw/virtio/virtio-mmio.h             | 2 +-
 include/hw/watchdog/allwinner-wdt.h         | 2 +-
 include/hw/watchdog/cmsdk-apb-watchdog.h    | 2 +-
 include/hw/watchdog/sbsa_gwdt.h             | 2 +-
 include/hw/watchdog/wdt_aspeed.h            | 2 +-
 include/hw/watchdog/wdt_imx2.h              | 2 +-
 include/hw/xen/xen_pvdev.h                  | 2 +-
 rust/hw/core/wrapper.h                      | 2 +-
 hw/acpi/cxl.c                               | 2 +-
 hw/adc/stm32f2xx_adc.c                      | 2 +-
 hw/arm/allwinner-a10.c                      | 2 +-
 hw/arm/allwinner-h3.c                       | 2 +-
 hw/arm/allwinner-r40.c                      | 2 +-
 hw/arm/armsse.c                             | 2 +-
 hw/arm/armv7m.c                             | 2 +-
 hw/arm/bcm2836.c                            | 2 +-
 hw/arm/bcm2838.c                            | 2 +-
 hw/arm/collie.c                             | 2 +-
 hw/arm/exynos4210.c                         | 2 +-
 hw/arm/exynos4_boards.c                     | 2 +-
 hw/arm/highbank.c                           | 2 +-
 hw/arm/integratorcp.c                       | 2 +-
 hw/arm/musicpal.c                           | 2 +-
 hw/arm/nrf51_soc.c                          | 2 +-
 hw/arm/omap1.c                              | 2 +-
 hw/arm/realview.c                           | 2 +-
 hw/arm/smmuv3.c                             | 2 +-
 hw/arm/stellaris.c                          | 2 +-
 hw/arm/strongarm.c                          | 2 +-
 hw/arm/versatilepb.c                        | 2 +-
 hw/arm/vexpress.c                           | 2 +-
 hw/arm/virt.c                               | 2 +-
 hw/arm/xilinx_zynq.c                        | 2 +-
 hw/arm/xlnx-versal-virt.c                   | 2 +-
 hw/arm/xlnx-versal.c                        | 2 +-
 hw/audio/asc.c                              | 2 +-
 hw/audio/cs4231.c                           | 2 +-
 hw/audio/marvell_88w8618.c                  | 2 +-
 hw/audio/pl041.c                            | 2 +-
 hw/avr/atmega.c                             | 2 +-
 hw/block/fdc-sysbus.c                       | 2 +-
 hw/block/pflash_cfi01.c                     | 2 +-
 hw/block/pflash_cfi02.c                     | 2 +-
 hw/block/swim.c                             | 2 +-
 hw/char/cadence_uart.c                      | 2 +-
 hw/char/cmsdk-apb-uart.c                    | 2 +-
 hw/char/digic-uart.c                        | 2 +-
 hw/char/escc.c                              | 2 +-
 hw/char/exynos4210_uart.c                   | 2 +-
 hw/char/goldfish_tty.c                      | 2 +-
 hw/char/grlib_apbuart.c                     | 2 +-
 hw/char/mcf_uart.c                          | 2 +-
 hw/char/pl011.c                             | 2 +-
 hw/char/sh_serial.c                         | 2 +-
 hw/char/xilinx_uartlite.c                   | 2 +-
 hw/core/qdev.c                              | 2 +-
 hw/core/sysbus.c                            | 2 +-
 hw/display/artist.c                         | 2 +-
 hw/display/cg3.c                            | 2 +-
 hw/display/exynos4210_fimd.c                | 2 +-
 hw/display/g364fb.c                         | 2 +-
 hw/display/jazz_led.c                       | 2 +-
 hw/display/macfb.c                          | 2 +-
 hw/display/pl110.c                          | 2 +-
 hw/display/sm501.c                          | 2 +-
 hw/display/tcx.c                            | 2 +-
 hw/display/vga-mmio.c                       | 2 +-
 hw/dma/pl080.c                              | 2 +-
 hw/dma/pl330.c                              | 2 +-
 hw/dma/rc4030.c                             | 2 +-
 hw/dma/sifive_pdma.c                        | 2 +-
 hw/dma/sparc32_dma.c                        | 2 +-
 hw/dma/xilinx_axidma.c                      | 2 +-
 hw/dma/xlnx_csu_dma.c                       | 2 +-
 hw/gpio/bcm2835_gpio.c                      | 2 +-
 hw/gpio/bcm2838_gpio.c                      | 2 +-
 hw/gpio/gpio_key.c                          | 2 +-
 hw/gpio/gpio_pwr.c                          | 2 +-
 hw/gpio/mpc8xxx.c                           | 2 +-
 hw/gpio/omap_gpio.c                         | 2 +-
 hw/gpio/pl061.c                             | 2 +-
 hw/gpio/zaurus.c                            | 2 +-
 hw/hyperv/vmbus.c                           | 2 +-
 hw/i2c/aspeed_i2c.c                         | 2 +-
 hw/i2c/bitbang_i2c.c                        | 2 +-
 hw/i2c/exynos4210_i2c.c                     | 2 +-
 hw/i2c/i2c_mux_pca954x.c                    | 2 +-
 hw/i2c/mpc_i2c.c                            | 2 +-
 hw/i2c/omap_i2c.c                           | 2 +-
 hw/i386/intel_iommu.c                       | 2 +-
 hw/i386/kvm/clock.c                         | 2 +-
 hw/i386/kvm/xen_evtchn.c                    | 2 +-
 hw/i386/kvm/xen_gnttab.c                    | 2 +-
 hw/i386/kvm/xen_overlay.c                   | 2 +-
 hw/i386/kvm/xen_primary_console.c           | 2 +-
 hw/i386/kvm/xen_xenstore.c                  | 2 +-
 hw/i386/microvm-dt.c                        | 2 +-
 hw/i386/nitro_enclave.c                     | 2 +-
 hw/i386/pc_piix.c                           | 2 +-
 hw/i386/pc_sysfw.c                          | 2 +-
 hw/i386/vapic.c                             | 2 +-
 hw/i386/x86-iommu.c                         | 2 +-
 hw/ide/mmio.c                               | 2 +-
 hw/input/lasips2.c                          | 2 +-
 hw/input/pl050.c                            | 2 +-
 hw/input/ps2.c                              | 2 +-
 hw/intc/allwinner-a10-pic.c                 | 2 +-
 hw/intc/apic_common.c                       | 2 +-
 hw/intc/arm_gic.c                           | 2 +-
 hw/intc/arm_gicv2m.c                        | 2 +-
 hw/intc/armv7m_nvic.c                       | 2 +-
 hw/intc/exynos4210_combiner.c               | 2 +-
 hw/intc/exynos4210_gic.c                    | 2 +-
 hw/intc/goldfish_pic.c                      | 2 +-
 hw/intc/grlib_irqmp.c                       | 2 +-
 hw/intc/ioapic_common.c                     | 2 +-
 hw/intc/loongarch_dintc.c                   | 2 +-
 hw/intc/loongarch_pch_msi.c                 | 2 +-
 hw/intc/loongson_ipi_common.c               | 2 +-
 hw/intc/mips_gic.c                          | 2 +-
 hw/intc/omap_intc.c                         | 2 +-
 hw/intc/ompic.c                             | 2 +-
 hw/intc/openpic.c                           | 2 +-
 hw/intc/openpic_kvm.c                       | 2 +-
 hw/intc/pl190.c                             | 2 +-
 hw/intc/riscv_aclint.c                      | 2 +-
 hw/intc/riscv_aplic.c                       | 2 +-
 hw/intc/riscv_imsic.c                       | 2 +-
 hw/intc/s390_flic.c                         | 2 +-
 hw/intc/sifive_plic.c                       | 2 +-
 hw/intc/slavio_intctl.c                     | 2 +-
 hw/intc/xilinx_intc.c                       | 2 +-
 hw/intc/xlnx-pmu-iomod-intc.c               | 2 +-
 hw/intc/xlnx-zynqmp-ipi.c                   | 2 +-
 hw/isa/isa-bus.c                            | 2 +-
 hw/m68k/mcf5206.c                           | 2 +-
 hw/m68k/mcf5208.c                           | 2 +-
 hw/m68k/mcf_intc.c                          | 2 +-
 hw/m68k/next-cube.c                         | 2 +-
 hw/m68k/next-kbd.c                          | 2 +-
 hw/m68k/q800.c                              | 2 +-
 hw/m68k/virt.c                              | 2 +-
 hw/mem/sparse-mem.c                         | 2 +-
 hw/microblaze/petalogix_ml605_mmu.c         | 2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c    | 2 +-
 hw/mips/jazz.c                              | 2 +-
 hw/mips/malta.c                             | 2 +-
 hw/misc/allwinner-a10-ccm.c                 | 2 +-
 hw/misc/allwinner-a10-dramc.c               | 2 +-
 hw/misc/allwinner-cpucfg.c                  | 2 +-
 hw/misc/allwinner-h3-ccu.c                  | 2 +-
 hw/misc/allwinner-h3-dramc.c                | 2 +-
 hw/misc/allwinner-h3-sysctrl.c              | 2 +-
 hw/misc/allwinner-r40-ccu.c                 | 2 +-
 hw/misc/allwinner-r40-dramc.c               | 2 +-
 hw/misc/allwinner-sid.c                     | 2 +-
 hw/misc/allwinner-sramc.c                   | 2 +-
 hw/misc/arm_integrator_debug.c              | 2 +-
 hw/misc/arm_l2x0.c                          | 2 +-
 hw/misc/arm_sysctl.c                        | 2 +-
 hw/misc/armsse-cpu-pwrctrl.c                | 2 +-
 hw/misc/armsse-cpuid.c                      | 2 +-
 hw/misc/armsse-mhu.c                        | 2 +-
 hw/misc/eccmemctl.c                         | 2 +-
 hw/misc/empty_slot.c                        | 2 +-
 hw/misc/exynos4210_clk.c                    | 2 +-
 hw/misc/exynos4210_pmu.c                    | 2 +-
 hw/misc/exynos4210_rng.c                    | 2 +-
 hw/misc/grlib_ahb_apb_pnp.c                 | 2 +-
 hw/misc/iosb.c                              | 2 +-
 hw/misc/iotkit-secctl.c                     | 2 +-
 hw/misc/iotkit-sysctl.c                     | 2 +-
 hw/misc/iotkit-sysinfo.c                    | 2 +-
 hw/misc/ivshmem-flat.c                      | 2 +-
 hw/misc/mac_via.c                           | 2 +-
 hw/misc/mchp_pfsoc_dmc.c                    | 2 +-
 hw/misc/mchp_pfsoc_ioscb.c                  | 2 +-
 hw/misc/mchp_pfsoc_sysreg.c                 | 2 +-
 hw/misc/mips_cmgcr.c                        | 2 +-
 hw/misc/mips_cpc.c                          | 2 +-
 hw/misc/mps2-fpgaio.c                       | 2 +-
 hw/misc/mps2-scc.c                          | 2 +-
 hw/misc/pvpanic-mmio.c                      | 2 +-
 hw/misc/sbsa_ec.c                           | 2 +-
 hw/misc/sifive_e_prci.c                     | 2 +-
 hw/misc/sifive_test.c                       | 2 +-
 hw/misc/sifive_u_otp.c                      | 2 +-
 hw/misc/sifive_u_prci.c                     | 2 +-
 hw/misc/slavio_misc.c                       | 2 +-
 hw/misc/tz-mpc.c                            | 2 +-
 hw/misc/tz-msc.c                            | 2 +-
 hw/misc/tz-ppc.c                            | 2 +-
 hw/misc/unimp.c                             | 2 +-
 hw/misc/virt_ctrl.c                         | 2 +-
 hw/misc/xlnx-versal-cframe-reg.c            | 2 +-
 hw/misc/xlnx-versal-cfu.c                   | 2 +-
 hw/misc/xlnx-versal-crl.c                   | 2 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c          | 2 +-
 hw/misc/xlnx-versal-xramc.c                 | 2 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c              | 2 +-
 hw/misc/xlnx-zynqmp-crf.c                   | 2 +-
 hw/misc/zynq_slcr.c                         | 2 +-
 hw/net/allwinner-sun8i-emac.c               | 2 +-
 hw/net/allwinner_emac.c                     | 2 +-
 hw/net/can/xlnx-versal-canfd.c              | 2 +-
 hw/net/can/xlnx-zynqmp-can.c                | 2 +-
 hw/net/dp8393x.c                            | 2 +-
 hw/net/fsl_etsec/etsec.c                    | 2 +-
 hw/net/lan9118.c                            | 2 +-
 hw/net/lasi_i82596.c                        | 2 +-
 hw/net/mcf_fec.c                            | 2 +-
 hw/net/mv88w8618_eth.c                      | 2 +-
 hw/net/opencores_eth.c                      | 2 +-
 hw/net/smc91c111.c                          | 2 +-
 hw/net/stellaris_enet.c                     | 2 +-
 hw/net/xgmac.c                              | 2 +-
 hw/net/xilinx_axienet.c                     | 2 +-
 hw/net/xilinx_ethlite.c                     | 2 +-
 hw/nubus/mac-nubus-bridge.c                 | 2 +-
 hw/nubus/nubus-bridge.c                     | 2 +-
 hw/nvram/ds1225y.c                          | 2 +-
 hw/nvram/fw_cfg.c                           | 2 +-
 hw/openrisc/openrisc_sim.c                  | 2 +-
 hw/openrisc/virt.c                          | 2 +-
 hw/pci-bridge/cxl_root_port.c               | 2 +-
 hw/pci-host/i440fx.c                        | 2 +-
 hw/pci-host/mv64361.c                       | 2 +-
 hw/pci-host/sabre.c                         | 2 +-
 hw/pci-host/sh_pci.c                        | 2 +-
 hw/pci-host/versatile.c                     | 2 +-
 hw/ppc/e500.c                               | 2 +-
 hw/ppc/e500plat.c                           | 2 +-
 hw/ppc/mac_newworld.c                       | 2 +-
 hw/ppc/mpc8544_guts.c                       | 2 +-
 hw/ppc/pegasos.c                            | 2 +-
 hw/ppc/pnv_xscom.c                          | 2 +-
 hw/ppc/ppc440_bamboo.c                      | 2 +-
 hw/ppc/ppce500_spin.c                       | 2 +-
 hw/ppc/sam460ex.c                           | 2 +-
 hw/ppc/spapr_pci.c                          | 2 +-
 hw/ppc/spapr_vio.c                          | 2 +-
 hw/ppc/virtex_ml507.c                       | 2 +-
 hw/riscv/microblaze-v-generic.c             | 2 +-
 hw/riscv/microchip_pfsoc.c                  | 2 +-
 hw/riscv/riscv-iommu-sys.c                  | 2 +-
 hw/riscv/riscv_hart.c                       | 2 +-
 hw/riscv/sifive_e.c                         | 2 +-
 hw/riscv/sifive_u.c                         | 2 +-
 hw/riscv/spike.c                            | 2 +-
 hw/riscv/virt.c                             | 2 +-
 hw/rtc/allwinner-rtc.c                      | 2 +-
 hw/rtc/exynos4210_rtc.c                     | 2 +-
 hw/rtc/goldfish_rtc.c                       | 2 +-
 hw/rtc/ls7a_rtc.c                           | 2 +-
 hw/rtc/m48t59.c                             | 2 +-
 hw/rtc/pl031.c                              | 2 +-
 hw/rtc/sun4v-rtc.c                          | 2 +-
 hw/rtc/xlnx-zynqmp-rtc.c                    | 2 +-
 hw/rx/rx62n.c                               | 2 +-
 hw/s390x/ap-bridge.c                        | 2 +-
 hw/s390x/css-bridge.c                       | 2 +-
 hw/scsi/esp.c                               | 2 +-
 hw/scsi/lasi_ncr710.c                       | 2 +-
 hw/scsi/ncr53c710.c                         | 2 +-
 hw/sd/omap_mmc.c                            | 2 +-
 hw/sd/pl181.c                               | 2 +-
 hw/sh4/r2d.c                                | 2 +-
 hw/sh4/sh7750.c                             | 2 +-
 hw/sparc/sun4m.c                            | 2 +-
 hw/sparc/sun4m_iommu.c                      | 2 +-
 hw/sparc64/sun4u.c                          | 2 +-
 hw/sparc64/sun4u_iommu.c                    | 2 +-
 hw/ssi/aspeed_smc.c                         | 2 +-
 hw/ssi/pl022.c                              | 2 +-
 hw/ssi/sifive_spi.c                         | 2 +-
 hw/ssi/xilinx_spi.c                         | 2 +-
 hw/ssi/xilinx_spips.c                       | 2 +-
 hw/ssi/xlnx-versal-ospi.c                   | 2 +-
 hw/timer/allwinner-a10-pit.c                | 2 +-
 hw/timer/arm_timer.c                        | 2 +-
 hw/timer/armv7m_systick.c                   | 2 +-
 hw/timer/aspeed_timer.c                     | 2 +-
 hw/timer/cadence_ttc.c                      | 2 +-
 hw/timer/cmsdk-apb-dualtimer.c              | 2 +-
 hw/timer/cmsdk-apb-timer.c                  | 2 +-
 hw/timer/digic-timer.c                      | 2 +-
 hw/timer/exynos4210_mct.c                   | 2 +-
 hw/timer/exynos4210_pwm.c                   | 2 +-
 hw/timer/grlib_gptimer.c                    | 2 +-
 hw/timer/hpet.c                             | 2 +-
 hw/timer/pxa2xx_timer.c                     | 2 +-
 hw/timer/slavio_timer.c                     | 2 +-
 hw/timer/sse-counter.c                      | 2 +-
 hw/timer/sse-timer.c                        | 2 +-
 hw/timer/xilinx_timer.c                     | 2 +-
 hw/tpm/tpm_tis_i2c.c                        | 2 +-
 hw/tpm/tpm_tis_sysbus.c                     | 2 +-
 hw/tricore/tc27x_soc.c                      | 2 +-
 hw/tricore/tricore_testdevice.c             | 2 +-
 hw/uefi/var-service-sysbus.c                | 2 +-
 hw/usb/hcd-dwc3.c                           | 2 +-
 hw/usb/hcd-ohci-pci.c                       | 2 +-
 hw/usb/hcd-ohci-sysbus.c                    | 2 +-
 hw/usb/hcd-ohci.c                           | 2 +-
 hw/usb/xlnx-usb-subsystem.c                 | 2 +-
 hw/usb/xlnx-versal-usb2-ctrl-regs.c         | 2 +-
 hw/virtio/virtio-mmio.c                     | 2 +-
 hw/vmapple/aes.c                            | 2 +-
 hw/vmapple/bdif.c                           | 2 +-
 hw/vmapple/cfg.c                            | 2 +-
 hw/vmapple/vmapple.c                        | 2 +-
 hw/watchdog/allwinner-wdt.c                 | 2 +-
 hw/watchdog/cmsdk-apb-watchdog.c            | 2 +-
 hw/watchdog/wdt_aspeed.c                    | 2 +-
 hw/xen/xen-bus.c                            | 2 +-
 hw/xen/xen-legacy-backend.c                 | 2 +-
 hw/xtensa/xtfpga.c                          | 2 +-
 system/qdev-monitor.c                       | 2 +-
 hw/display/apple-gfx-mmio.m                 | 2 +-
 633 files changed, 632 insertions(+), 632 deletions(-)
 rename include/hw/{ => core}/sysbus.h (100%)

diff --git a/hw/i386/kvm/xen_evtchn.h b/hw/i386/kvm/xen_evtchn.h
index 0521ebc0922..8d339db5601 100644
--- a/hw/i386/kvm/xen_evtchn.h
+++ b/hw/i386/kvm/xen_evtchn.h
@@ -12,7 +12,7 @@
 #ifndef QEMU_XEN_EVTCHN_H
 #define QEMU_XEN_EVTCHN_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 typedef uint32_t evtchn_port_t;
 
diff --git a/hw/intc/ioapic_internal.h b/hw/intc/ioapic_internal.h
index 51205767f44..499b997d4b7 100644
--- a/hw/intc/ioapic_internal.h
+++ b/hw/intc/ioapic_internal.h
@@ -24,7 +24,7 @@
 
 #include "system/memory.h"
 #include "hw/intc/ioapic.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/notify.h"
 #include "qom/object.h"
 
diff --git a/hw/net/fsl_etsec/etsec.h b/hw/net/fsl_etsec/etsec.h
index ca8ad5638a3..24e1344bf1e 100644
--- a/hw/net/fsl_etsec/etsec.h
+++ b/hw/net/fsl_etsec/etsec.h
@@ -25,7 +25,7 @@
 #ifndef ETSEC_H
 #define ETSEC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "hw/core/ptimer.h"
 #include "qom/object.h"
diff --git a/hw/ppc/e500-ccsr.h b/hw/ppc/e500-ccsr.h
index 249c17be3b8..4de006b4434 100644
--- a/hw/ppc/e500-ccsr.h
+++ b/hw/ppc/e500-ccsr.h
@@ -1,7 +1,7 @@
 #ifndef E500_CCSR_H
 #define E500_CCSR_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 struct PPCE500CCSRState {
diff --git a/hw/scsi/lasi_ncr710.h b/hw/scsi/lasi_ncr710.h
index 058718068e8..99be001fc3c 100644
--- a/hw/scsi/lasi_ncr710.h
+++ b/hw/scsi/lasi_ncr710.h
@@ -14,7 +14,7 @@
 #ifndef HW_LASI_NCR710_H
 #define HW_LASI_NCR710_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/osdep.h"
 #include "exec/memattrs.h"
 #include "hw/scsi/scsi.h"
diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 9ae64a182d5..a8dc92f4ef8 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -16,7 +16,7 @@
 #define HW_NCR53C710_H
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/scsi/scsi.h"
 #include "qemu/fifo8.h"
 #include "qom/object.h"
diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
index a99409a654b..68877661ca0 100644
--- a/hw/usb/hcd-dwc2.h
+++ b/hw/usb/hcd-dwc2.h
@@ -21,7 +21,7 @@
 
 #include "qemu/timer.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/usb/usb.h"
 #include "system/dma.h"
 #include "qom/object.h"
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index c16717294d3..0ae8c06331a 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -22,7 +22,7 @@
 #include "hw/usb/usb.h"
 #include "system/dma.h"
 #include "hw/pci/pci_device.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #ifndef EHCI_DEBUG
 #define EHCI_DEBUG   0
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
index 75e266de90b..243cd1f46ac 100644
--- a/hw/usb/hcd-ohci.h
+++ b/hw/usb/hcd-ohci.h
@@ -21,7 +21,7 @@
 #ifndef HCD_OHCI_H
 #define HCD_OHCI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/dma.h"
 #include "hw/usb/usb.h"
 #include "qom/object.h"
diff --git a/hw/usb/hcd-xhci-sysbus.h b/hw/usb/hcd-xhci-sysbus.h
index f8175470bab..0ce6b6d9896 100644
--- a/hw/usb/hcd-xhci-sysbus.h
+++ b/hw/usb/hcd-xhci-sysbus.h
@@ -13,7 +13,7 @@
 
 #include "hw/usb/usb.h"
 #include "hcd-xhci.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define XHCI_SYSBUS(obj) \
     OBJECT_CHECK(XHCISysbusState, (obj), TYPE_XHCI_SYSBUS)
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index 130c014d3f0..7cbfb5fe7d7 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -59,7 +59,7 @@
 #ifndef HW_ACPI_GENERIC_EVENT_DEVICE_H
 #define HW_ACPI_GENERIC_EVENT_DEVICE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/cpu.h"
diff --git a/include/hw/adc/aspeed_adc.h b/include/hw/adc/aspeed_adc.h
index f502f197ac0..75c00b03255 100644
--- a/include/hw/adc/aspeed_adc.h
+++ b/include/hw/adc/aspeed_adc.h
@@ -11,7 +11,7 @@
 #ifndef HW_ADC_ASPEED_ADC_H
 #define HW_ADC_ASPEED_ADC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_ASPEED_ADC "aspeed.adc"
 #define TYPE_ASPEED_2400_ADC TYPE_ASPEED_ADC "-ast2400"
diff --git a/include/hw/adc/npcm7xx_adc.h b/include/hw/adc/npcm7xx_adc.h
index 02dc1902fce..867e4c767c0 100644
--- a/include/hw/adc/npcm7xx_adc.h
+++ b/include/hw/adc/npcm7xx_adc.h
@@ -18,7 +18,7 @@
 
 #include "hw/core/clock.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 
 #define NPCM7XX_ADC_NUM_INPUTS      8
diff --git a/include/hw/adc/stm32f2xx_adc.h b/include/hw/adc/stm32f2xx_adc.h
index 42b48981f24..2af21f1852d 100644
--- a/include/hw/adc/stm32f2xx_adc.h
+++ b/include/hw/adc/stm32f2xx_adc.h
@@ -25,7 +25,7 @@
 #ifndef HW_STM32F2XX_ADC_H
 #define HW_STM32F2XX_ADC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define ADC_SR    0x00
diff --git a/include/hw/adc/zynq-xadc.h b/include/hw/adc/zynq-xadc.h
index c10cc4c379c..9b4943681b8 100644
--- a/include/hw/adc/zynq-xadc.h
+++ b/include/hw/adc/zynq-xadc.h
@@ -15,7 +15,7 @@
 #ifndef ZYNQ_XADC_H
 #define ZYNQ_XADC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define ZYNQ_XADC_MMIO_SIZE     0x0020
diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 414e553600d..bdf2d4db8e2 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -93,7 +93,7 @@
 #ifndef ARMSSE_H
 #define ARMSSE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/armv7m.h"
 #include "hw/misc/iotkit-secctl.h"
 #include "hw/misc/tz-ppc.h"
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index e31888cc8cd..98ad08db036 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -10,7 +10,7 @@
 #ifndef HW_ARM_ARMV7M_H
 #define HW_ARM_ARMV7M_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/intc/armv7m_nvic.h"
 #include "hw/misc/armv7m_ras.h"
 #include "target/arm/idau.h"
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index d46d892956d..bf35bb18e54 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -12,7 +12,7 @@
 #ifndef BCM2835_PERIPHERALS_H
 #define BCM2835_PERIPHERALS_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/char/pl011.h"
 #include "hw/char/bcm2835_aux.h"
 #include "hw/display/bcm2835_fb.h"
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index fbe4370219d..b29e7243c72 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -25,7 +25,7 @@
 #define EXYNOS4210_H
 
 #include "hw/core/or-irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/intc/exynos4210_gic.h"
 #include "hw/intc/exynos4210_combiner.h"
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 1275df22f19..4b367b754c6 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -26,7 +26,7 @@
 #include "hw/timer/imx_gpt.h"
 #include "hw/usb/hcd-dwc3.h"
 #include "hw/watchdog/wdt_imx2.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 94d7fc62ac4..f759d007a13 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -10,7 +10,7 @@
 #ifndef NRF51_SOC_H
 #define NRF51_SOC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/armv7m.h"
 #include "hw/char/nrf51_uart.h"
 #include "hw/misc/nrf51_rng.h"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 80d0fecfde8..48368c8e894 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -19,7 +19,7 @@
 #ifndef HW_ARM_SMMU_COMMON_H
 #define HW_ARM_SMMU_COMMON_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/pci.h"
 #include "qom/object.h"
 
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index e1fb1f4cf5b..4c4599add1d 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -13,7 +13,7 @@
 #ifndef XLNX_VERSAL_H
 #define XLNX_VERSAL_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
 #include "hw/arm/xlnx-versal-version.h"
diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
index bb51e9a3d19..f4aefbfe5a5 100644
--- a/include/hw/audio/asc.h
+++ b/include/hw/audio/asc.h
@@ -13,7 +13,7 @@
 #ifndef HW_AUDIO_ASC_H
 #define HW_AUDIO_ASC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/audio.h"
 
 #define ASC_FREQ 22257
diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
index 5f567e8d595..e8998f57c4b 100644
--- a/include/hw/block/swim.h
+++ b/include/hw/block/swim.h
@@ -12,7 +12,7 @@
 #define SWIM_H
 
 #include "hw/block/block.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define SWIM_MAX_FD            2
diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
index bd2d488f9a1..8af7a5d1eec 100644
--- a/include/hw/char/avr_usart.h
+++ b/include/hw/char/avr_usart.h
@@ -22,7 +22,7 @@
 #ifndef HW_CHAR_AVR_USART_H
 #define HW_CHAR_AVR_USART_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.h
index a11134f216f..c5ce148bbce 100644
--- a/include/hw/char/bcm2835_aux.h
+++ b/include/hw/char/bcm2835_aux.h
@@ -9,7 +9,7 @@
 #ifndef BCM2835_AUX_H
 #define BCM2835_AUX_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
index ad09fbdf32c..751a751248f 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -20,7 +20,7 @@
 #define CADENCE_UART_H
 
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/include/hw/char/cmsdk-apb-uart.h b/include/hw/char/cmsdk-apb-uart.h
index 3d0af26cebc..0c62b7f2f50 100644
--- a/include/hw/char/cmsdk-apb-uart.h
+++ b/include/hw/char/cmsdk-apb-uart.h
@@ -12,7 +12,7 @@
 #ifndef CMSDK_APB_UART_H
 #define CMSDK_APB_UART_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
diff --git a/include/hw/char/digic-uart.h b/include/hw/char/digic-uart.h
index 3eebdab8a01..6f67b70dfd5 100644
--- a/include/hw/char/digic-uart.h
+++ b/include/hw/char/digic-uart.h
@@ -18,7 +18,7 @@
 #ifndef HW_CHAR_DIGIC_UART_H
 #define HW_CHAR_DIGIC_UART_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 857f64699e3..9e60175b778 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -3,7 +3,7 @@
 
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "ui/input.h"
 #include "qom/object.h"
 
diff --git a/include/hw/char/goldfish_tty.h b/include/hw/char/goldfish_tty.h
index 70fdedd1d0f..a696362fa55 100644
--- a/include/hw/char/goldfish_tty.h
+++ b/include/hw/char/goldfish_tty.h
@@ -12,7 +12,7 @@
 
 #include "qemu/fifo8.h"
 #include "chardev/char-fe.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_GOLDFISH_TTY "goldfish_tty"
 OBJECT_DECLARE_SIMPLE_TYPE(GoldfishTTYState, GOLDFISH_TTY)
diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h
index 1ccbb602e61..882796e0c64 100644
--- a/include/hw/char/ibex_uart.h
+++ b/include/hw/char/ibex_uart.h
@@ -25,7 +25,7 @@
 #ifndef HW_IBEX_UART_H
 #define HW_IBEX_UART_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index 2dcd2e6bcdd..855792b6055 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -18,7 +18,7 @@
 #ifndef IMX_SERIAL_H
 #define IMX_SERIAL_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 #include "qemu/fifo32.h"
diff --git a/include/hw/char/max78000_uart.h b/include/hw/char/max78000_uart.h
index ac93f83389a..6977c7b3f16 100644
--- a/include/hw/char/max78000_uart.h
+++ b/include/hw/char/max78000_uart.h
@@ -9,7 +9,7 @@
 #ifndef HW_MAX78000_UART_H
 #define HW_MAX78000_UART_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/fifo8.h"
 #include "qom/object.h"
diff --git a/include/hw/char/mchp_pfsoc_mmuart.h b/include/hw/char/mchp_pfsoc_mmuart.h
index a7b8b1b08b3..1e27732df12 100644
--- a/include/hw/char/mchp_pfsoc_mmuart.h
+++ b/include/hw/char/mchp_pfsoc_mmuart.h
@@ -28,7 +28,7 @@
 #ifndef HW_MCHP_PFSOC_MMUART_H
 #define HW_MCHP_PFSOC_MMUART_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/char/serial-mm.h"
 
 #define MCHP_PFSOC_MMUART_REG_COUNT 13
diff --git a/include/hw/char/nrf51_uart.h b/include/hw/char/nrf51_uart.h
index 7a54db746bd..36a6c54cde1 100644
--- a/include/hw/char/nrf51_uart.h
+++ b/include/hw/char/nrf51_uart.h
@@ -11,7 +11,7 @@
 #ifndef NRF51_UART_H
 #define NRF51_UART_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "hw/core/registerfields.h"
 #include "qom/object.h"
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 2d4ff01c815..ff735b5234a 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -15,7 +15,7 @@
 #ifndef HW_PL011_H
 #define HW_PL011_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
diff --git a/include/hw/char/renesas_sci.h b/include/hw/char/renesas_sci.h
index 90e784f36a3..372e788be4c 100644
--- a/include/hw/char/renesas_sci.h
+++ b/include/hw/char/renesas_sci.h
@@ -10,7 +10,7 @@
 #define HW_CHAR_RENESAS_SCI_H
 
 #include "chardev/char-fe.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_RENESAS_SCI "renesas-sci"
diff --git a/include/hw/char/serial-mm.h b/include/hw/char/serial-mm.h
index 77abd098e0d..0076bdc061b 100644
--- a/include/hw/char/serial-mm.h
+++ b/include/hw/char/serial-mm.h
@@ -29,7 +29,7 @@
 #include "hw/char/serial.h"
 #include "system/memory.h"
 #include "chardev/char.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_SERIAL_MM "serial-mm"
diff --git a/include/hw/char/shakti_uart.h b/include/hw/char/shakti_uart.h
index e5e775d7c9a..e77553f2b57 100644
--- a/include/hw/char/shakti_uart.h
+++ b/include/hw/char/shakti_uart.h
@@ -25,7 +25,7 @@
 #ifndef HW_SHAKTI_UART_H
 #define HW_SHAKTI_UART_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 
 #define SHAKTI_UART_BAUD        0x00
diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index dea6055f872..414564b0266 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -22,7 +22,7 @@
 
 #include "chardev/char-fe.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #include "qemu/fifo8.h"
 
diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2xx_usart.h
index f9018b8b8f6..5bb5bb28c13 100644
--- a/include/hw/char/stm32f2xx_usart.h
+++ b/include/hw/char/stm32f2xx_usart.h
@@ -25,7 +25,7 @@
 #ifndef HW_STM32F2XX_USART_H
 #define HW_STM32F2XX_USART_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
diff --git a/include/hw/char/stm32l4x5_usart.h b/include/hw/char/stm32l4x5_usart.h
index cdf7419f533..3bb59fd654b 100644
--- a/include/hw/char/stm32l4x5_usart.h
+++ b/include/hw/char/stm32l4x5_usart.h
@@ -18,7 +18,7 @@
 #ifndef HW_STM32L4X5_USART_H
 #define HW_STM32L4X5_USART_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
diff --git a/include/hw/core/or-irq.h b/include/hw/core/or-irq.h
index c0a42f37112..1123cc518fb 100644
--- a/include/hw/core/or-irq.h
+++ b/include/hw/core/or-irq.h
@@ -25,7 +25,7 @@
 #ifndef HW_OR_IRQ_H
 #define HW_OR_IRQ_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_OR_IRQ "or-irq"
diff --git a/include/hw/core/platform-bus.h b/include/hw/core/platform-bus.h
index 44f30c5353f..45b9d8dbc7b 100644
--- a/include/hw/core/platform-bus.h
+++ b/include/hw/core/platform-bus.h
@@ -22,7 +22,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 
diff --git a/include/hw/core/split-irq.h b/include/hw/core/split-irq.h
index ff8852f4071..19e9830b763 100644
--- a/include/hw/core/split-irq.h
+++ b/include/hw/core/split-irq.h
@@ -35,7 +35,7 @@
 #ifndef HW_SPLIT_IRQ_H
 #define HW_SPLIT_IRQ_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_SPLIT_IRQ "split-irq"
diff --git a/include/hw/sysbus.h b/include/hw/core/sysbus.h
similarity index 100%
rename from include/hw/sysbus.h
rename to include/hw/core/sysbus.h
diff --git a/include/hw/cpu/a15mpcore.h b/include/hw/cpu/a15mpcore.h
index 75d39e5458a..138f491c222 100644
--- a/include/hw/cpu/a15mpcore.h
+++ b/include/hw/cpu/a15mpcore.h
@@ -20,7 +20,7 @@
 #ifndef HW_CPU_A15MPCORE_H
 #define HW_CPU_A15MPCORE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/intc/arm_gic.h"
 #include "qom/object.h"
 
diff --git a/include/hw/cpu/a9mpcore.h b/include/hw/cpu/a9mpcore.h
index e0396ab6af7..60765990247 100644
--- a/include/hw/cpu/a9mpcore.h
+++ b/include/hw/cpu/a9mpcore.h
@@ -10,7 +10,7 @@
 #ifndef HW_CPU_A9MPCORE_H
 #define HW_CPU_A9MPCORE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/misc/a9scu.h"
 #include "hw/timer/arm_mptimer.h"
diff --git a/include/hw/cpu/arm11mpcore.h b/include/hw/cpu/arm11mpcore.h
index 2cac8c1232d..1a8fbc550a6 100644
--- a/include/hw/cpu/arm11mpcore.h
+++ b/include/hw/cpu/arm11mpcore.h
@@ -10,7 +10,7 @@
 #ifndef HW_CPU_ARM11MPCORE_H
 #define HW_CPU_ARM11MPCORE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/arm11scu.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/timer/arm_mptimer.h"
diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index acc9230b6a8..f7ef076f1f4 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -12,7 +12,7 @@
 #ifndef BCM2835_FB_H
 #define BCM2835_FB_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define UPPER_RAM_BASE 0x40000000
diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
index 356a03ce31a..495dead44b5 100644
--- a/include/hw/display/macfb.h
+++ b/include/hw/display/macfb.h
@@ -16,7 +16,7 @@
 #include "system/memory.h"
 #include "hw/core/irq.h"
 #include "hw/nubus/nubus.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "ui/console.h"
 #include "qemu/timer.h"
 
diff --git a/include/hw/display/xlnx_dp.h b/include/hw/display/xlnx_dp.h
index 9ec5a90c342..b01c77fed69 100644
--- a/include/hw/display/xlnx_dp.h
+++ b/include/hw/display/xlnx_dp.h
@@ -24,7 +24,7 @@
 #ifndef XLNX_DP_H
 #define XLNX_DP_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "ui/console.h"
 #include "hw/misc/auxbus.h"
 #include "hw/i2c/i2c.h"
diff --git a/include/hw/dma/bcm2835_dma.h b/include/hw/dma/bcm2835_dma.h
index 1d26b1d8d0f..9c20652d4e4 100644
--- a/include/hw/dma/bcm2835_dma.h
+++ b/include/hw/dma/bcm2835_dma.h
@@ -8,7 +8,7 @@
 #ifndef BCM2835_DMA_H
 #define BCM2835_DMA_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 typedef struct {
diff --git a/include/hw/dma/pl080.h b/include/hw/dma/pl080.h
index 3c9659e4381..6635cd8e93d 100644
--- a/include/hw/dma/pl080.h
+++ b/include/hw/dma/pl080.h
@@ -29,7 +29,7 @@
 #ifndef HW_DMA_PL080_H
 #define HW_DMA_PL080_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define PL080_MAX_CHANNELS 8
diff --git a/include/hw/dma/sifive_pdma.h b/include/hw/dma/sifive_pdma.h
index 8c6cfa7f325..34494ec6014 100644
--- a/include/hw/dma/sifive_pdma.h
+++ b/include/hw/dma/sifive_pdma.h
@@ -23,7 +23,7 @@
 #ifndef SIFIVE_PDMA_H
 #define SIFIVE_PDMA_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 struct sifive_pdma_chan {
     uint32_t control;
diff --git a/include/hw/dma/xlnx-zdma.h b/include/hw/dma/xlnx-zdma.h
index 2d2d4aeefab..7d254c66e7d 100644
--- a/include/hw/dma/xlnx-zdma.h
+++ b/include/hw/dma/xlnx-zdma.h
@@ -29,7 +29,7 @@
 #ifndef XLNX_ZDMA_H
 #define XLNX_ZDMA_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "system/dma.h"
 #include "qom/object.h"
diff --git a/include/hw/dma/xlnx-zynq-devcfg.h b/include/hw/dma/xlnx-zynq-devcfg.h
index 8d10553c22a..3e3cc7b98ba 100644
--- a/include/hw/dma/xlnx-zynq-devcfg.h
+++ b/include/hw/dma/xlnx-zynq-devcfg.h
@@ -28,7 +28,7 @@
 #define XLNX_ZYNQ_DEVCFG_H
 
 #include "hw/core/register.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_XLNX_ZYNQ_DEVCFG "xlnx.ps7-dev-cfg"
diff --git a/include/hw/dma/xlnx_csu_dma.h b/include/hw/dma/xlnx_csu_dma.h
index 4d6d18fb9b5..ceb28f40bae 100644
--- a/include/hw/dma/xlnx_csu_dma.h
+++ b/include/hw/dma/xlnx_csu_dma.h
@@ -21,7 +21,7 @@
 #ifndef XLNX_CSU_DMA_H
 #define XLNX_CSU_DMA_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/stream.h"
diff --git a/include/hw/dma/xlnx_dpdma.h b/include/hw/dma/xlnx_dpdma.h
index 484b2e377f0..7cf67aef6e1 100644
--- a/include/hw/dma/xlnx_dpdma.h
+++ b/include/hw/dma/xlnx_dpdma.h
@@ -25,7 +25,7 @@
 #ifndef XLNX_DPDMA_H
 #define XLNX_DPDMA_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/dma.h"
 #include "qom/object.h"
 
diff --git a/include/hw/fsi/aspeed_apb2opb.h b/include/hw/fsi/aspeed_apb2opb.h
index 878619eafa7..e42399185ad 100644
--- a/include/hw/fsi/aspeed_apb2opb.h
+++ b/include/hw/fsi/aspeed_apb2opb.h
@@ -10,7 +10,7 @@
 
 #include "system/memory.h"
 #include "hw/fsi/fsi-master.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_FSI_OPB "fsi.opb"
 
diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
index e6b2fe71b50..0ff4539cb2d 100644
--- a/include/hw/gpio/aspeed_gpio.h
+++ b/include/hw/gpio/aspeed_gpio.h
@@ -10,7 +10,7 @@
 #ifndef ASPEED_GPIO_H
 #define ASPEED_GPIO_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_ASPEED_GPIO "aspeed.gpio"
diff --git a/include/hw/gpio/bcm2835_gpio.h b/include/hw/gpio/bcm2835_gpio.h
index 1c53a050908..c1410ccbebf 100644
--- a/include/hw/gpio/bcm2835_gpio.h
+++ b/include/hw/gpio/bcm2835_gpio.h
@@ -15,7 +15,7 @@
 #define BCM2835_GPIO_H
 
 #include "hw/sd/sd.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 struct BCM2835GpioState {
diff --git a/include/hw/gpio/bcm2838_gpio.h b/include/hw/gpio/bcm2838_gpio.h
index f2a57a697f2..9324ebcbaeb 100644
--- a/include/hw/gpio/bcm2838_gpio.h
+++ b/include/hw/gpio/bcm2838_gpio.h
@@ -15,7 +15,7 @@
 #define BCM2838_GPIO_H
 
 #include "hw/sd/sd.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2838_GPIO "bcm2838-gpio"
diff --git a/include/hw/gpio/imx_gpio.h b/include/hw/gpio/imx_gpio.h
index 227860b9f0a..ae2afb3c0fb 100644
--- a/include/hw/gpio/imx_gpio.h
+++ b/include/hw/gpio/imx_gpio.h
@@ -20,7 +20,7 @@
 #ifndef IMX_GPIO_H
 #define IMX_GPIO_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_IMX_GPIO "imx.gpio"
diff --git a/include/hw/gpio/npcm7xx_gpio.h b/include/hw/gpio/npcm7xx_gpio.h
index 7c0bf61a960..9b2a3f27d37 100644
--- a/include/hw/gpio/npcm7xx_gpio.h
+++ b/include/hw/gpio/npcm7xx_gpio.h
@@ -16,7 +16,7 @@
 #define NPCM7XX_GPIO_H
 
 #include "system/memory.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /* Number of pins managed by each controller. */
 #define NPCM7XX_GPIO_NR_PINS (32)
diff --git a/include/hw/gpio/nrf51_gpio.h b/include/hw/gpio/nrf51_gpio.h
index fcfa2bac173..661e79b9217 100644
--- a/include/hw/gpio/nrf51_gpio.h
+++ b/include/hw/gpio/nrf51_gpio.h
@@ -26,7 +26,7 @@
 #ifndef NRF51_GPIO_H
 #define NRF51_GPIO_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #define TYPE_NRF51_GPIO "nrf51_soc.gpio"
 OBJECT_DECLARE_SIMPLE_TYPE(NRF51GPIOState, NRF51_GPIO)
diff --git a/include/hw/gpio/sifive_gpio.h b/include/hw/gpio/sifive_gpio.h
index fc53785c9d0..e96cf33df68 100644
--- a/include/hw/gpio/sifive_gpio.h
+++ b/include/hw/gpio/sifive_gpio.h
@@ -14,7 +14,7 @@
 #ifndef SIFIVE_GPIO_H
 #define SIFIVE_GPIO_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_SIFIVE_GPIO "sifive_soc.gpio"
diff --git a/include/hw/gpio/stm32l4x5_gpio.h b/include/hw/gpio/stm32l4x5_gpio.h
index 878bd19fc9b..62197541295 100644
--- a/include/hw/gpio/stm32l4x5_gpio.h
+++ b/include/hw/gpio/stm32l4x5_gpio.h
@@ -19,7 +19,7 @@
 #ifndef HW_STM32L4X5_GPIO_H
 #define HW_STM32L4X5_GPIO_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_STM32L4X5_GPIO "stm32l4x5-gpio"
diff --git a/include/hw/hyperv/vmbus-bridge.h b/include/hw/hyperv/vmbus-bridge.h
index 1e5419574ee..2cf73075c6f 100644
--- a/include/hw/hyperv/vmbus-bridge.h
+++ b/include/hw/hyperv/vmbus-bridge.h
@@ -10,7 +10,7 @@
 #ifndef HW_HYPERV_VMBUS_BRIDGE_H
 #define HW_HYPERV_VMBUS_BRIDGE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/hyperv/vmbus.h"
 #include "qom/object.h"
 
diff --git a/include/hw/i2c/allwinner-i2c.h b/include/hw/i2c/allwinner-i2c.h
index 0e325d265ee..72836cc1017 100644
--- a/include/hw/i2c/allwinner-i2c.h
+++ b/include/hw/i2c/allwinner-i2c.h
@@ -24,7 +24,7 @@
 #ifndef ALLWINNER_I2C_H
 #define ALLWINNER_I2C_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_AW_I2C "allwinner.i2c"
diff --git a/include/hw/i2c/arm_sbcon_i2c.h b/include/hw/i2c/arm_sbcon_i2c.h
index da9b5e8f83b..39b99f57bfb 100644
--- a/include/hw/i2c/arm_sbcon_i2c.h
+++ b/include/hw/i2c/arm_sbcon_i2c.h
@@ -13,7 +13,7 @@
 #ifndef HW_I2C_ARM_SBCON_I2C_H
 #define HW_I2C_ARM_SBCON_I2C_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/i2c/bitbang_i2c.h"
 #include "qom/object.h"
 
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index c9c2620a8a3..ffcff2580f0 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -21,7 +21,7 @@
 #define ASPEED_I2C_H
 
 #include "hw/i2c/i2c.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/registerfields.h"
 #include "qom/object.h"
 
diff --git a/include/hw/i2c/bcm2835_i2c.h b/include/hw/i2c/bcm2835_i2c.h
index 0a56df4720b..45f876df224 100644
--- a/include/hw/i2c/bcm2835_i2c.h
+++ b/include/hw/i2c/bcm2835_i2c.h
@@ -24,7 +24,7 @@
  * THE SOFTWARE.
  */
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/i2c/i2c.h"
 #include "qom/object.h"
 
diff --git a/include/hw/i2c/imx_i2c.h b/include/hw/i2c/imx_i2c.h
index e4f91339f58..988a3e284fb 100644
--- a/include/hw/i2c/imx_i2c.h
+++ b/include/hw/i2c/imx_i2c.h
@@ -21,7 +21,7 @@
 #ifndef IMX_I2C_H
 #define IMX_I2C_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_IMX_I2C "imx.i2c"
diff --git a/include/hw/i2c/microbit_i2c.h b/include/hw/i2c/microbit_i2c.h
index 3c29e09bf38..a3ec27ff6c2 100644
--- a/include/hw/i2c/microbit_i2c.h
+++ b/include/hw/i2c/microbit_i2c.h
@@ -11,7 +11,7 @@
 #ifndef MICROBIT_I2C_H
 #define MICROBIT_I2C_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/nrf51.h"
 #include "qom/object.h"
 
diff --git a/include/hw/i2c/npcm7xx_smbus.h b/include/hw/i2c/npcm7xx_smbus.h
index f5adb69c672..dff9bc2f6ed 100644
--- a/include/hw/i2c/npcm7xx_smbus.h
+++ b/include/hw/i2c/npcm7xx_smbus.h
@@ -19,7 +19,7 @@
 #include "system/memory.h"
 #include "hw/i2c/i2c.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /*
  * Number of addresses this module contains. Do not change this without
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index 4e882fa3c80..5b875eedacc 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -27,7 +27,7 @@
 #ifndef PPC4XX_I2C_H
 #define PPC4XX_I2C_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/i2c/bitbang_i2c.h"
 #include "qom/object.h"
 
diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index e89f55a5c21..c526a047ab6 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -20,7 +20,7 @@
 #ifndef HW_I386_X86_IOMMU_H
 #define HW_I386_X86_IOMMU_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/msi.h"
 #include "qom/object.h"
 
diff --git a/include/hw/ide/ahci-sysbus.h b/include/hw/ide/ahci-sysbus.h
index 06eaac8cb60..34d0c8f55ad 100644
--- a/include/hw/ide/ahci-sysbus.h
+++ b/include/hw/ide/ahci-sysbus.h
@@ -7,7 +7,7 @@
 #define HW_IDE_AHCI_SYSBUS_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/ide/ahci.h"
 
 #define TYPE_SYSBUS_AHCI "sysbus-ahci"
diff --git a/include/hw/input/i8042.h b/include/hw/input/i8042.h
index e90f008b667..07d749b3d04 100644
--- a/include/hw/input/i8042.h
+++ b/include/hw/input/i8042.h
@@ -9,7 +9,7 @@
 #define HW_INPUT_I8042_H
 
 #include "hw/isa/isa.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/input/ps2.h"
 #include "qom/object.h"
 
diff --git a/include/hw/input/lasips2.h b/include/hw/input/lasips2.h
index fd74883073b..2739f752c8e 100644
--- a/include/hw/input/lasips2.h
+++ b/include/hw/input/lasips2.h
@@ -20,7 +20,7 @@
 #define HW_INPUT_LASIPS2_H
 
 #include "exec/hwaddr.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/input/ps2.h"
 
 #define TYPE_LASIPS2_PORT "lasips2-port"
diff --git a/include/hw/input/pl050.h b/include/hw/input/pl050.h
index db662654c58..2cdfa74f73c 100644
--- a/include/hw/input/pl050.h
+++ b/include/hw/input/pl050.h
@@ -10,7 +10,7 @@
 #ifndef HW_PL050_H
 #define HW_PL050_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/input/ps2.h"
 #include "hw/core/irq.h"
diff --git a/include/hw/input/ps2.h b/include/hw/input/ps2.h
index cd61a634c39..058db3e0890 100644
--- a/include/hw/input/ps2.h
+++ b/include/hw/input/ps2.h
@@ -25,7 +25,7 @@
 #ifndef HW_PS2_H
 #define HW_PS2_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define PS2_MOUSE_BUTTON_LEFT   0x01
 #define PS2_MOUSE_BUTTON_RIGHT  0x02
diff --git a/include/hw/input/stellaris_gamepad.h b/include/hw/input/stellaris_gamepad.h
index 51085e166ca..e011482646f 100644
--- a/include/hw/input/stellaris_gamepad.h
+++ b/include/hw/input/stellaris_gamepad.h
@@ -11,7 +11,7 @@
 #ifndef HW_INPUT_STELLARIS_GAMEPAD_H
 #define HW_INPUT_STELLARIS_GAMEPAD_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 /*
diff --git a/include/hw/intc/allwinner-a10-pic.h b/include/hw/intc/allwinner-a10-pic.h
index b8364d3ed40..f22059ed85b 100644
--- a/include/hw/intc/allwinner-a10-pic.h
+++ b/include/hw/intc/allwinner-a10-pic.h
@@ -1,7 +1,7 @@
 #ifndef ALLWINNER_A10_PIC_H
 #define ALLWINNER_A10_PIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_AW_A10_PIC  "allwinner-a10-pic"
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index 93a3cc2bf81..b169394e6ca 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -21,7 +21,7 @@
 #ifndef HW_ARM_GIC_COMMON_H
 #define HW_ARM_GIC_COMMON_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 /* Maximum number of possible interrupts, determined by the GIC architecture */
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 61d51915e07..3d24ad22d28 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -24,7 +24,7 @@
 #ifndef HW_ARM_GICV3_COMMON_H
 #define HW_ARM_GICV3_COMMON_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/intc/arm_gic_common.h"
 #include "qom/object.h"
 #include "qemu/notify.h"
diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index 3c7b543b018..05b438aa7ad 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -21,7 +21,7 @@
 #ifndef QEMU_ARM_GICV3_ITS_COMMON_H
 #define QEMU_ARM_GICV3_ITS_COMMON_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
 
diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 7b9964fe7e4..e699546f6a6 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -11,7 +11,7 @@
 #define HW_ARM_ARMV7M_NVIC_H
 
 #include "target/arm/cpu-qom.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/timer/armv7m_systick.h"
 #include "qom/object.h"
 
diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 6dd8effcd89..5d10268fff3 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -8,7 +8,7 @@
 #ifndef ASPEED_INTC_H
 #define ASPEED_INTC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #include "hw/core/or-irq.h"
 
diff --git a/include/hw/intc/aspeed_vic.h b/include/hw/intc/aspeed_vic.h
index 68d6ab997a1..5172f5c9137 100644
--- a/include/hw/intc/aspeed_vic.h
+++ b/include/hw/intc/aspeed_vic.h
@@ -13,7 +13,7 @@
 #ifndef ASPEED_VIC_H
 #define ASPEED_VIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_ASPEED_VIC "aspeed.vic"
diff --git a/include/hw/intc/bcm2835_ic.h b/include/hw/intc/bcm2835_ic.h
index 588eb76c5cb..f9ebaac8f9b 100644
--- a/include/hw/intc/bcm2835_ic.h
+++ b/include/hw/intc/bcm2835_ic.h
@@ -8,7 +8,7 @@
 #ifndef BCM2835_IC_H
 #define BCM2835_IC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_IC "bcm2835-ic"
diff --git a/include/hw/intc/bcm2836_control.h b/include/hw/intc/bcm2836_control.h
index a410c817e8f..05380f1b855 100644
--- a/include/hw/intc/bcm2836_control.h
+++ b/include/hw/intc/bcm2836_control.h
@@ -15,7 +15,7 @@
 #ifndef BCM2836_CONTROL_H
 #define BCM2836_CONTROL_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
 
diff --git a/include/hw/intc/exynos4210_combiner.h b/include/hw/intc/exynos4210_combiner.h
index bd207a7e6e4..b1db48cb880 100644
--- a/include/hw/intc/exynos4210_combiner.h
+++ b/include/hw/intc/exynos4210_combiner.h
@@ -23,7 +23,7 @@
 #ifndef HW_INTC_EXYNOS4210_COMBINER_H
 #define HW_INTC_EXYNOS4210_COMBINER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /*
  * State for each output signal of internal combiner
diff --git a/include/hw/intc/exynos4210_gic.h b/include/hw/intc/exynos4210_gic.h
index f64c4069c6d..6ffe57c2306 100644
--- a/include/hw/intc/exynos4210_gic.h
+++ b/include/hw/intc/exynos4210_gic.h
@@ -22,7 +22,7 @@
 #ifndef HW_INTC_EXYNOS4210_GIC_H
 #define HW_INTC_EXYNOS4210_GIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_EXYNOS4210_GIC "exynos4210.gic"
 OBJECT_DECLARE_SIMPLE_TYPE(Exynos4210GicState, EXYNOS4210_GIC)
diff --git a/include/hw/intc/goldfish_pic.h b/include/hw/intc/goldfish_pic.h
index 3e795803672..e61df599b0d 100644
--- a/include/hw/intc/goldfish_pic.h
+++ b/include/hw/intc/goldfish_pic.h
@@ -10,7 +10,7 @@
 #ifndef HW_INTC_GOLDFISH_PIC_H
 #define HW_INTC_GOLDFISH_PIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_GOLDFISH_PIC "goldfish_pic"
 OBJECT_DECLARE_SIMPLE_TYPE(GoldfishPICState, GOLDFISH_PIC)
diff --git a/include/hw/intc/grlib_irqmp.h b/include/hw/intc/grlib_irqmp.h
index a76acbf9403..e39496ca5df 100644
--- a/include/hw/intc/grlib_irqmp.h
+++ b/include/hw/intc/grlib_irqmp.h
@@ -27,7 +27,7 @@
 #ifndef GRLIB_IRQMP_H
 #define GRLIB_IRQMP_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /* Emulation of GrLib device is base on the GRLIB IP Core User's Manual:
  * http://www.gaisler.com/products/grlib/grip.pdf
diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pic.h
index c0a7f6f5460..cfd8a8df2b2 100644
--- a/include/hw/intc/heathrow_pic.h
+++ b/include/hw/intc/heathrow_pic.h
@@ -26,7 +26,7 @@
 #ifndef HW_INTC_HEATHROW_PIC_H
 #define HW_INTC_HEATHROW_PIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_HEATHROW "heathrow"
diff --git a/include/hw/intc/imx_avic.h b/include/hw/intc/imx_avic.h
index 75fbd1a89c7..82ce9037eda 100644
--- a/include/hw/intc/imx_avic.h
+++ b/include/hw/intc/imx_avic.h
@@ -17,7 +17,7 @@
 #ifndef IMX_AVIC_H
 #define IMX_AVIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_IMX_AVIC "imx.avic"
diff --git a/include/hw/intc/imx_gpcv2.h b/include/hw/intc/imx_gpcv2.h
index 7bdee7e80a1..7a3441ac657 100644
--- a/include/hw/intc/imx_gpcv2.h
+++ b/include/hw/intc/imx_gpcv2.h
@@ -1,7 +1,7 @@
 #ifndef IMX_GPCV2_H
 #define IMX_GPCV2_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 enum IMXGPCv2Registers {
diff --git a/include/hw/intc/loongarch_dintc.h b/include/hw/intc/loongarch_dintc.h
index 01bb1e465cb..1f4f65705a7 100644
--- a/include/hw/intc/loongarch_dintc.h
+++ b/include/hw/intc/loongarch_dintc.h
@@ -6,7 +6,7 @@
  */
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/loongarch/virt.h"
 #include "system/memory.h"
 
diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
index 1bd2bfa07fc..2dbc2563eb0 100644
--- a/include/hw/intc/loongarch_extioi_common.h
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -8,7 +8,7 @@
 #define LOONGARCH_EXTIOI_COMMON_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/loongarch/virt.h"
 #include "system/memory.h"
 
diff --git a/include/hw/intc/loongarch_pch_msi.h b/include/hw/intc/loongarch_pch_msi.h
index ef4ec4fdeb8..fec51187c21 100644
--- a/include/hw/intc/loongarch_pch_msi.h
+++ b/include/hw/intc/loongarch_pch_msi.h
@@ -5,7 +5,7 @@
  * Copyright (C) 2021 Loongson Technology Corporation Limited
  */
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 
 #define TYPE_LOONGARCH_PCH_MSI "loongarch_pch_msi"
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index 179361eb567..1627ec0899d 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -8,7 +8,7 @@
 #define HW_LOONGARCH_PIC_COMMON_H
 
 #include "hw/loongarch/virt.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 
 #define PCH_PIC_INT_ID                  0x00
diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 4e517cc8dc4..afb8488725b 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -10,7 +10,7 @@
 
 #include "qom/object.h"
 #include "hw/intc/loongson_ipi_common.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_LOONGSON_IPI "loongson_ipi"
 OBJECT_DECLARE_TYPE(LoongsonIPIState, LoongsonIPIClass, LOONGSON_IPI)
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index 4fa03bc351f..feb858780a9 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -9,7 +9,7 @@
 #define HW_LOONGSON_IPI_COMMON_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "exec/memattrs.h"
 #include "system/memory.h"
 
diff --git a/include/hw/intc/loongson_liointc.h b/include/hw/intc/loongson_liointc.h
index 848e65eb359..f400f691b07 100644
--- a/include/hw/intc/loongson_liointc.h
+++ b/include/hw/intc/loongson_liointc.h
@@ -12,7 +12,7 @@
 #define LOONGSON_LIOINTC_H
 
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_LOONGSON_LIOINTC "loongson.liointc"
diff --git a/include/hw/intc/m68k_irqc.h b/include/hw/intc/m68k_irqc.h
index 693e33b0aa5..b2b184dbc98 100644
--- a/include/hw/intc/m68k_irqc.h
+++ b/include/hw/intc/m68k_irqc.h
@@ -10,7 +10,7 @@
 #ifndef M68K_IRQC_H
 #define M68K_IRQC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_M68K_IRQC "m68k-irq-controller"
 #define M68K_IRQC(obj) OBJECT_CHECK(M68KIRQCState, (obj), \
diff --git a/include/hw/intc/mips_gic.h b/include/hw/intc/mips_gic.h
index 5e4c71edd47..e2e6f0a168c 100644
--- a/include/hw/intc/mips_gic.h
+++ b/include/hw/intc/mips_gic.h
@@ -13,7 +13,7 @@
 
 #include "qemu/units.h"
 #include "hw/timer/mips_gictimer.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "cpu.h"
 #include "qom/object.h"
 /*
diff --git a/include/hw/intc/realview_gic.h b/include/hw/intc/realview_gic.h
index f37339dc0b1..6feaf1a605b 100644
--- a/include/hw/intc/realview_gic.h
+++ b/include/hw/intc/realview_gic.h
@@ -10,7 +10,7 @@
 #ifndef HW_INTC_REALVIEW_GIC_H
 #define HW_INTC_REALVIEW_GIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/intc/arm_gic.h"
 #include "qom/object.h"
 
diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
index 4b7406eec00..5310615cbf6 100644
--- a/include/hw/intc/riscv_aclint.h
+++ b/include/hw/intc/riscv_aclint.h
@@ -21,7 +21,7 @@
 #ifndef HW_RISCV_ACLINT_H
 #define HW_RISCV_ACLINT_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_RISCV_ACLINT_MTIMER "riscv.aclint.mtimer"
 
diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index 489b9133c26..c7a4d4ad017 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -19,7 +19,7 @@
 #ifndef HW_RISCV_APLIC_H
 #define HW_RISCV_APLIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_RISCV_APLIC "riscv.aplic"
diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
index 58c2aaa8dc6..fae999731df 100644
--- a/include/hw/intc/riscv_imsic.h
+++ b/include/hw/intc/riscv_imsic.h
@@ -19,7 +19,7 @@
 #ifndef HW_RISCV_IMSIC_H
 #define HW_RISCV_IMSIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_RISCV_IMSIC "riscv.imsic"
diff --git a/include/hw/intc/rx_icu.h b/include/hw/intc/rx_icu.h
index b23504f3dd1..2f2746b8681 100644
--- a/include/hw/intc/rx_icu.h
+++ b/include/hw/intc/rx_icu.h
@@ -21,7 +21,7 @@
 #ifndef HW_INTC_RX_ICU_H
 #define HW_INTC_RX_ICU_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 enum TRG_MODE {
diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
index d3f45ec2481..32973dbf281 100644
--- a/include/hw/intc/sifive_plic.h
+++ b/include/hw/intc/sifive_plic.h
@@ -21,7 +21,7 @@
 #ifndef HW_SIFIVE_PLIC_H
 #define HW_SIFIVE_PLIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_SIFIVE_PLIC "riscv.sifive.plic"
diff --git a/include/hw/intc/xlnx-pmu-iomod-intc.h b/include/hw/intc/xlnx-pmu-iomod-intc.h
index e36b5e17629..1a1b0e813d0 100644
--- a/include/hw/intc/xlnx-pmu-iomod-intc.h
+++ b/include/hw/intc/xlnx-pmu-iomod-intc.h
@@ -25,7 +25,7 @@
 #ifndef HW_INTC_XLNX_PMU_IOMOD_INTC_H
 #define HW_INTC_XLNX_PMU_IOMOD_INTC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "qom/object.h"
 
diff --git a/include/hw/intc/xlnx-zynqmp-ipi.h b/include/hw/intc/xlnx-zynqmp-ipi.h
index 53fc89084af..57ac6e68524 100644
--- a/include/hw/intc/xlnx-zynqmp-ipi.h
+++ b/include/hw/intc/xlnx-zynqmp-ipi.h
@@ -25,7 +25,7 @@
 #ifndef XLNX_ZYNQMP_IPI_H
 #define XLNX_ZYNQMP_IPI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "qom/object.h"
 
diff --git a/include/hw/m68k/q800-glue.h b/include/hw/m68k/q800-glue.h
index 04fac25f6c2..ac3404d6db8 100644
--- a/include/hw/m68k/q800-glue.h
+++ b/include/hw/m68k/q800-glue.h
@@ -23,7 +23,7 @@
 #ifndef HW_Q800_GLUE_H
 #define HW_Q800_GLUE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_GLUE "q800-glue"
 OBJECT_DECLARE_SIMPLE_TYPE(GLUEState, GLUE)
diff --git a/include/hw/mem/npcm7xx_mc.h b/include/hw/mem/npcm7xx_mc.h
index 568cc35fdd7..9c724e83fd2 100644
--- a/include/hw/mem/npcm7xx_mc.h
+++ b/include/hw/mem/npcm7xx_mc.h
@@ -17,7 +17,7 @@
 #define NPCM7XX_MC_H
 
 #include "system/memory.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /**
  * struct NPCM7xxMCState - Device state for the memory controller.
diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index e7309841d08..878b4d819f4 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -20,7 +20,7 @@
 #ifndef MIPS_CPS_H
 #define MIPS_CPS_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/clock.h"
 #include "hw/misc/mips_cmgcr.h"
 #include "hw/intc/mips_gic.h"
diff --git a/include/hw/misc/a9scu.h b/include/hw/misc/a9scu.h
index c3759fb8c8c..312fb29434b 100644
--- a/include/hw/misc/a9scu.h
+++ b/include/hw/misc/a9scu.h
@@ -10,7 +10,7 @@
 #ifndef HW_MISC_A9SCU_H
 #define HW_MISC_A9SCU_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 /* A9MP private memory region.  */
diff --git a/include/hw/misc/allwinner-a10-ccm.h b/include/hw/misc/allwinner-a10-ccm.h
index 7f22532efaa..109b83f4df6 100644
--- a/include/hw/misc/allwinner-a10-ccm.h
+++ b/include/hw/misc/allwinner-a10-ccm.h
@@ -24,7 +24,7 @@
 #define HW_MISC_ALLWINNER_A10_CCM_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /**
  * @name Constants
diff --git a/include/hw/misc/allwinner-a10-dramc.h b/include/hw/misc/allwinner-a10-dramc.h
index a1ae621e217..44663dee44a 100644
--- a/include/hw/misc/allwinner-a10-dramc.h
+++ b/include/hw/misc/allwinner-a10-dramc.h
@@ -24,7 +24,7 @@
 #define HW_MISC_ALLWINNER_A10_DRAMC_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 
 /**
diff --git a/include/hw/misc/allwinner-cpucfg.h b/include/hw/misc/allwinner-cpucfg.h
index a717b47299a..0214f1fb770 100644
--- a/include/hw/misc/allwinner-cpucfg.h
+++ b/include/hw/misc/allwinner-cpucfg.h
@@ -21,7 +21,7 @@
 #define HW_MISC_ALLWINNER_CPUCFG_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /**
  * Object model
diff --git a/include/hw/misc/allwinner-h3-ccu.h b/include/hw/misc/allwinner-h3-ccu.h
index a04875bfca3..b8a17216865 100644
--- a/include/hw/misc/allwinner-h3-ccu.h
+++ b/include/hw/misc/allwinner-h3-ccu.h
@@ -21,7 +21,7 @@
 #define HW_MISC_ALLWINNER_H3_CCU_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /**
  * @name Constants
diff --git a/include/hw/misc/allwinner-h3-dramc.h b/include/hw/misc/allwinner-h3-dramc.h
index 0b6c877ef74..0435120ff92 100644
--- a/include/hw/misc/allwinner-h3-dramc.h
+++ b/include/hw/misc/allwinner-h3-dramc.h
@@ -21,7 +21,7 @@
 #define HW_MISC_ALLWINNER_H3_DRAMC_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "exec/hwaddr.h"
 
 /**
diff --git a/include/hw/misc/allwinner-h3-sysctrl.h b/include/hw/misc/allwinner-h3-sysctrl.h
index ec1c220535e..ff886450f3a 100644
--- a/include/hw/misc/allwinner-h3-sysctrl.h
+++ b/include/hw/misc/allwinner-h3-sysctrl.h
@@ -21,7 +21,7 @@
 #define HW_MISC_ALLWINNER_H3_SYSCTRL_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /**
  * @name Constants
diff --git a/include/hw/misc/allwinner-r40-ccu.h b/include/hw/misc/allwinner-r40-ccu.h
index ceb74eff923..4f1cc4fe115 100644
--- a/include/hw/misc/allwinner-r40-ccu.h
+++ b/include/hw/misc/allwinner-r40-ccu.h
@@ -21,7 +21,7 @@
 #define HW_MISC_ALLWINNER_R40_CCU_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /**
  * @name Constants
diff --git a/include/hw/misc/allwinner-r40-dramc.h b/include/hw/misc/allwinner-r40-dramc.h
index 6a1a3a78935..b823e9eb524 100644
--- a/include/hw/misc/allwinner-r40-dramc.h
+++ b/include/hw/misc/allwinner-r40-dramc.h
@@ -21,7 +21,7 @@
 #define HW_MISC_ALLWINNER_R40_DRAMC_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "exec/hwaddr.h"
 
 /**
diff --git a/include/hw/misc/allwinner-sid.h b/include/hw/misc/allwinner-sid.h
index 3bfa887a969..cfa22a4d7f3 100644
--- a/include/hw/misc/allwinner-sid.h
+++ b/include/hw/misc/allwinner-sid.h
@@ -21,7 +21,7 @@
 #define HW_MISC_ALLWINNER_SID_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/uuid.h"
 
 /**
diff --git a/include/hw/misc/allwinner-sramc.h b/include/hw/misc/allwinner-sramc.h
index 66b01b8d044..43fc338a589 100644
--- a/include/hw/misc/allwinner-sramc.h
+++ b/include/hw/misc/allwinner-sramc.h
@@ -21,7 +21,7 @@
 #define HW_MISC_ALLWINNER_SRAMC_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/uuid.h"
 
 /**
diff --git a/include/hw/misc/arm11scu.h b/include/hw/misc/arm11scu.h
index e5c0282aecf..d7ce0446a93 100644
--- a/include/hw/misc/arm11scu.h
+++ b/include/hw/misc/arm11scu.h
@@ -11,7 +11,7 @@
 #ifndef HW_MISC_ARM11SCU_H
 #define HW_MISC_ARM11SCU_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_ARM11_SCU "arm11-scu"
diff --git a/include/hw/misc/armsse-cpu-pwrctrl.h b/include/hw/misc/armsse-cpu-pwrctrl.h
index 51d45ede7db..1d9c50825bf 100644
--- a/include/hw/misc/armsse-cpu-pwrctrl.h
+++ b/include/hw/misc/armsse-cpu-pwrctrl.h
@@ -21,7 +21,7 @@
 #ifndef HW_MISC_ARMSSE_CPU_PWRCTRL_H
 #define HW_MISC_ARMSSE_CPU_PWRCTRL_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_ARMSSE_CPU_PWRCTRL "armsse-cpu-pwrctrl"
diff --git a/include/hw/misc/armsse-cpuid.h b/include/hw/misc/armsse-cpuid.h
index 9c0926322cb..0daf466972a 100644
--- a/include/hw/misc/armsse-cpuid.h
+++ b/include/hw/misc/armsse-cpuid.h
@@ -22,7 +22,7 @@
 #ifndef HW_MISC_ARMSSE_CPUID_H
 #define HW_MISC_ARMSSE_CPUID_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_ARMSSE_CPUID "armsse-cpuid"
diff --git a/include/hw/misc/armsse-mhu.h b/include/hw/misc/armsse-mhu.h
index 41925ded89b..e34d6c100bf 100644
--- a/include/hw/misc/armsse-mhu.h
+++ b/include/hw/misc/armsse-mhu.h
@@ -23,7 +23,7 @@
 #ifndef HW_MISC_ARMSSE_MHU_H
 #define HW_MISC_ARMSSE_MHU_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_ARMSSE_MHU "armsse-mhu"
diff --git a/include/hw/misc/armv7m_ras.h b/include/hw/misc/armv7m_ras.h
index ba6daccf3fc..2b692fa5f9e 100644
--- a/include/hw/misc/armv7m_ras.h
+++ b/include/hw/misc/armv7m_ras.h
@@ -21,7 +21,7 @@
 #ifndef HW_MISC_ARMV7M_RAS_H
 #define HW_MISC_ARMV7M_RAS_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_ARMV7M_RAS "armv7m-ras"
 OBJECT_DECLARE_SIMPLE_TYPE(ARMv7MRAS, ARMV7M_RAS)
diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
index d5d07c6c021..b5416b0cb5d 100644
--- a/include/hw/misc/aspeed_hace.h
+++ b/include/hw/misc/aspeed_hace.h
@@ -10,7 +10,7 @@
 #ifndef ASPEED_HACE_H
 #define ASPEED_HACE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "crypto/hash.h"
 
 #define TYPE_ASPEED_HACE "aspeed.hace"
diff --git a/include/hw/misc/aspeed_i3c.h b/include/hw/misc/aspeed_i3c.h
index 39679dfa1ae..7a984e1f01a 100644
--- a/include/hw/misc/aspeed_i3c.h
+++ b/include/hw/misc/aspeed_i3c.h
@@ -10,7 +10,7 @@
 #ifndef ASPEED_I3C_H
 #define ASPEED_I3C_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_ASPEED_I3C "aspeed.i3c"
 #define TYPE_ASPEED_I3C_DEVICE "aspeed.i3c.device"
diff --git a/include/hw/misc/aspeed_lpc.h b/include/hw/misc/aspeed_lpc.h
index fa398959af2..64c1039f9ce 100644
--- a/include/hw/misc/aspeed_lpc.h
+++ b/include/hw/misc/aspeed_lpc.h
@@ -10,7 +10,7 @@
 #ifndef ASPEED_LPC_H
 #define ASPEED_LPC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_ASPEED_LPC "aspeed.lpc"
 #define ASPEED_LPC(obj) OBJECT_CHECK(AspeedLPCState, (obj), TYPE_ASPEED_LPC)
diff --git a/include/hw/misc/aspeed_peci.h b/include/hw/misc/aspeed_peci.h
index 8382707d9fd..7680e5befb3 100644
--- a/include/hw/misc/aspeed_peci.h
+++ b/include/hw/misc/aspeed_peci.h
@@ -10,7 +10,7 @@
 #ifndef ASPEED_PECI_H
 #define ASPEED_PECI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define ASPEED_PECI_NR_REGS ((0xFC + 4) >> 2)
 #define TYPE_ASPEED_PECI "aspeed.peci"
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
index 7d640a022e4..07c7c22a86a 100644
--- a/include/hw/misc/aspeed_sbc.h
+++ b/include/hw/misc/aspeed_sbc.h
@@ -9,7 +9,7 @@
 #ifndef ASPEED_SBC_H
 #define ASPEED_SBC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/nvram/aspeed_otp.h"
 
 #define TYPE_ASPEED_SBC "aspeed.sbc"
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 684b48b7222..35b841960af 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -11,7 +11,7 @@
 #ifndef ASPEED_SCU_H
 #define ASPEED_SCU_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_ASPEED_SCU "aspeed.scu"
diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index 61c979583ae..806b1cbc58f 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -9,7 +9,7 @@
 #ifndef ASPEED_SDMC_H
 #define ASPEED_SDMC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_ASPEED_SDMC "aspeed.sdmc"
diff --git a/include/hw/misc/aspeed_sli.h b/include/hw/misc/aspeed_sli.h
index 23f346ab934..fa8d9fbc531 100644
--- a/include/hw/misc/aspeed_sli.h
+++ b/include/hw/misc/aspeed_sli.h
@@ -8,7 +8,7 @@
 #ifndef ASPEED_SLI_H
 #define ASPEED_SLI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_ASPEED_SLI "aspeed.sli"
 #define TYPE_ASPEED_2700_SLI TYPE_ASPEED_SLI "-ast2700"
diff --git a/include/hw/misc/aspeed_xdma.h b/include/hw/misc/aspeed_xdma.h
index b1478fd1c68..0089da9f1fd 100644
--- a/include/hw/misc/aspeed_xdma.h
+++ b/include/hw/misc/aspeed_xdma.h
@@ -9,7 +9,7 @@
 #ifndef ASPEED_XDMA_H
 #define ASPEED_XDMA_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_ASPEED_XDMA "aspeed.xdma"
diff --git a/include/hw/misc/avr_power.h b/include/hw/misc/avr_power.h
index 388e421aa7b..5de78c5125f 100644
--- a/include/hw/misc/avr_power.h
+++ b/include/hw/misc/avr_power.h
@@ -25,7 +25,7 @@
 #ifndef HW_MISC_AVR_POWER_H
 #define HW_MISC_AVR_POWER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 
diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
index 7b2c0a54642..8146bca3ae9 100644
--- a/include/hw/misc/bcm2835_cprman.h
+++ b/include/hw/misc/bcm2835_cprman.h
@@ -9,7 +9,7 @@
 #ifndef HW_MISC_BCM2835_CPRMAN_H
 #define HW_MISC_BCM2835_CPRMAN_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-clock.h"
 
 #define TYPE_BCM2835_CPRMAN "bcm2835-cprman"
diff --git a/include/hw/misc/bcm2835_mbox.h b/include/hw/misc/bcm2835_mbox.h
index ade27af25d0..571741c06e2 100644
--- a/include/hw/misc/bcm2835_mbox.h
+++ b/include/hw/misc/bcm2835_mbox.h
@@ -9,7 +9,7 @@
 #define BCM2835_MBOX_H
 
 #include "bcm2835_mbox_defs.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_MBOX "bcm2835-mbox"
diff --git a/include/hw/misc/bcm2835_mphi.h b/include/hw/misc/bcm2835_mphi.h
index 1a451685e8e..4ddf8ba6521 100644
--- a/include/hw/misc/bcm2835_mphi.h
+++ b/include/hw/misc/bcm2835_mphi.h
@@ -18,7 +18,7 @@
 #define HW_MISC_BCM2835_MPHI_H
 
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define MPHI_MMIO_SIZE      0x1000
diff --git a/include/hw/misc/bcm2835_powermgt.h b/include/hw/misc/bcm2835_powermgt.h
index 303b9a6f684..fb0740c01ec 100644
--- a/include/hw/misc/bcm2835_powermgt.h
+++ b/include/hw/misc/bcm2835_powermgt.h
@@ -11,7 +11,7 @@
 #ifndef BCM2835_POWERMGT_H
 #define BCM2835_POWERMGT_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_POWERMGT "bcm2835-powermgt"
diff --git a/include/hw/misc/bcm2835_property.h b/include/hw/misc/bcm2835_property.h
index 2f93fd0c757..53d2a92d173 100644
--- a/include/hw/misc/bcm2835_property.h
+++ b/include/hw/misc/bcm2835_property.h
@@ -8,7 +8,7 @@
 #ifndef BCM2835_PROPERTY_H
 #define BCM2835_PROPERTY_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "hw/display/bcm2835_fb.h"
 #include "hw/nvram/bcm2835_otp.h"
diff --git a/include/hw/misc/bcm2835_rng.h b/include/hw/misc/bcm2835_rng.h
index 7c1fb3ef405..eaf77f5103d 100644
--- a/include/hw/misc/bcm2835_rng.h
+++ b/include/hw/misc/bcm2835_rng.h
@@ -10,7 +10,7 @@
 #ifndef BCM2835_RNG_H
 #define BCM2835_RNG_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_RNG "bcm2835-rng"
diff --git a/include/hw/misc/bcm2835_thermal.h b/include/hw/misc/bcm2835_thermal.h
index f90f9e487ce..13ffc61c1a7 100644
--- a/include/hw/misc/bcm2835_thermal.h
+++ b/include/hw/misc/bcm2835_thermal.h
@@ -9,7 +9,7 @@
 #ifndef HW_MISC_BCM2835_THERMAL_H
 #define HW_MISC_BCM2835_THERMAL_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_THERMAL "bcm2835-thermal"
diff --git a/include/hw/misc/djmemc.h b/include/hw/misc/djmemc.h
index 82d4e4a2fee..76d6b366ff3 100644
--- a/include/hw/misc/djmemc.h
+++ b/include/hw/misc/djmemc.h
@@ -8,7 +8,7 @@
 #ifndef HW_MISC_DJMEMC_H
 #define HW_MISC_DJMEMC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define DJMEMC_SIZE        0x2000
 #define DJMEMC_NUM_REGS    (0x38 / sizeof(uint32_t))
diff --git a/include/hw/misc/imx6_src.h b/include/hw/misc/imx6_src.h
index f380da3810f..801b5b6a660 100644
--- a/include/hw/misc/imx6_src.h
+++ b/include/hw/misc/imx6_src.h
@@ -11,7 +11,7 @@
 #ifndef IMX6_SRC_H
 #define IMX6_SRC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/bitops.h"
 #include "qom/object.h"
 
diff --git a/include/hw/misc/imx7_gpr.h b/include/hw/misc/imx7_gpr.h
index df364bd8f09..5cb7d50a694 100644
--- a/include/hw/misc/imx7_gpr.h
+++ b/include/hw/misc/imx7_gpr.h
@@ -13,7 +13,7 @@
 #define IMX7_GPR_H
 
 #include "qemu/bitops.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_IMX7_GPR "imx7.gpr"
diff --git a/include/hw/misc/imx7_snvs.h b/include/hw/misc/imx7_snvs.h
index 1272076086a..90f69a6dd67 100644
--- a/include/hw/misc/imx7_snvs.h
+++ b/include/hw/misc/imx7_snvs.h
@@ -13,7 +13,7 @@
 #define IMX7_SNVS_H
 
 #include "qemu/bitops.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 
diff --git a/include/hw/misc/imx7_src.h b/include/hw/misc/imx7_src.h
index b4b97dcb1c1..55b58a03bf3 100644
--- a/include/hw/misc/imx7_src.h
+++ b/include/hw/misc/imx7_src.h
@@ -10,7 +10,7 @@
 #ifndef IMX7_SRC_H
 #define IMX7_SRC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/bitops.h"
 #include "qom/object.h"
 
diff --git a/include/hw/misc/imx8mp_analog.h b/include/hw/misc/imx8mp_analog.h
index 955f03215a0..6996e537718 100644
--- a/include/hw/misc/imx8mp_analog.h
+++ b/include/hw/misc/imx8mp_analog.h
@@ -10,7 +10,7 @@
 #define IMX8MP_ANALOG_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 enum IMX8MPAnalogRegisters {
     ANALOG_AUDIO_PLL1_GEN_CTRL = 0x000 / 4,
diff --git a/include/hw/misc/imx_ccm.h b/include/hw/misc/imx_ccm.h
index 7e5678e9726..c4212d04ea6 100644
--- a/include/hw/misc/imx_ccm.h
+++ b/include/hw/misc/imx_ccm.h
@@ -11,7 +11,7 @@
 #ifndef IMX_CCM_H
 #define IMX_CCM_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define CKIL_FREQ 32768 /* nominal 32khz clock */
diff --git a/include/hw/misc/imx_rngc.h b/include/hw/misc/imx_rngc.h
index 34ad6992259..5fb17551b00 100644
--- a/include/hw/misc/imx_rngc.h
+++ b/include/hw/misc/imx_rngc.h
@@ -10,7 +10,7 @@
 #ifndef IMX_RNGC_H
 #define IMX_RNGC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_IMX_RNGC "imx.rngc"
diff --git a/include/hw/misc/iotkit-secctl.h b/include/hw/misc/iotkit-secctl.h
index 79a36283201..1c189eb7214 100644
--- a/include/hw/misc/iotkit-secctl.h
+++ b/include/hw/misc/iotkit-secctl.h
@@ -55,7 +55,7 @@
 #ifndef IOTKIT_SECCTL_H
 #define IOTKIT_SECCTL_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_IOTKIT_SECCTL "iotkit-secctl"
diff --git a/include/hw/misc/iotkit-sysctl.h b/include/hw/misc/iotkit-sysctl.h
index 481e27f4db1..ce72258a847 100644
--- a/include/hw/misc/iotkit-sysctl.h
+++ b/include/hw/misc/iotkit-sysctl.h
@@ -26,7 +26,7 @@
 #ifndef HW_MISC_IOTKIT_SYSCTL_H
 #define HW_MISC_IOTKIT_SYSCTL_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_IOTKIT_SYSCTL "iotkit-sysctl"
diff --git a/include/hw/misc/iotkit-sysinfo.h b/include/hw/misc/iotkit-sysinfo.h
index 91c23f90d23..36dc702c53d 100644
--- a/include/hw/misc/iotkit-sysinfo.h
+++ b/include/hw/misc/iotkit-sysinfo.h
@@ -22,7 +22,7 @@
 #ifndef HW_MISC_IOTKIT_SYSINFO_H
 #define HW_MISC_IOTKIT_SYSINFO_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_IOTKIT_SYSINFO "iotkit-sysinfo"
diff --git a/include/hw/misc/ivshmem-flat.h b/include/hw/misc/ivshmem-flat.h
index d656e578085..4e7277f386c 100644
--- a/include/hw/misc/ivshmem-flat.h
+++ b/include/hw/misc/ivshmem-flat.h
@@ -16,7 +16,7 @@
 #include "chardev/char-fe.h"
 #include "system/memory.h"
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define IVSHMEM_MAX_VECTOR_NUM 64
 
diff --git a/include/hw/misc/lasi.h b/include/hw/misc/lasi.h
index 5e40c6aebdf..8bf72404037 100644
--- a/include/hw/misc/lasi.h
+++ b/include/hw/misc/lasi.h
@@ -14,7 +14,7 @@
 
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_LASI_CHIP "lasi-chip"
 OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index 6a152281505..114f41db4c7 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -10,7 +10,7 @@
 #define HW_MISC_MAC_VIA_H
 
 #include "system/memory.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/mos6522.h"
 #include "hw/input/adb.h"
 #include "qom/object.h"
diff --git a/include/hw/misc/macio/gpio.h b/include/hw/misc/macio/gpio.h
index 7d2aa886c24..157ea0659b3 100644
--- a/include/hw/misc/macio/gpio.h
+++ b/include/hw/misc/macio/gpio.h
@@ -27,7 +27,7 @@
 #define MACIO_GPIO_H
 
 #include "hw/ppc/openpic.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_MACIO_GPIO "macio-gpio"
diff --git a/include/hw/misc/max78000_aes.h b/include/hw/misc/max78000_aes.h
index 407c45ef61e..f68ab076960 100644
--- a/include/hw/misc/max78000_aes.h
+++ b/include/hw/misc/max78000_aes.h
@@ -8,7 +8,7 @@
 #ifndef HW_MAX78000_AES_H
 #define HW_MAX78000_AES_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "crypto/aes.h"
 #include "qom/object.h"
 
diff --git a/include/hw/misc/max78000_gcr.h b/include/hw/misc/max78000_gcr.h
index d5858a40f3b..c209766fa98 100644
--- a/include/hw/misc/max78000_gcr.h
+++ b/include/hw/misc/max78000_gcr.h
@@ -8,7 +8,7 @@
 #ifndef HW_MAX78000_GCR_H
 #define HW_MAX78000_GCR_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_GCR "max78000-gcr"
diff --git a/include/hw/misc/max78000_icc.h b/include/hw/misc/max78000_icc.h
index 6fe2bb7a156..a8f1d451bd6 100644
--- a/include/hw/misc/max78000_icc.h
+++ b/include/hw/misc/max78000_icc.h
@@ -9,7 +9,7 @@
 #ifndef HW_MAX78000_ICC_H
 #define HW_MAX78000_ICC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_ICC "max78000-icc"
diff --git a/include/hw/misc/max78000_trng.h b/include/hw/misc/max78000_trng.h
index c5a8129b6a0..a027f4b62c7 100644
--- a/include/hw/misc/max78000_trng.h
+++ b/include/hw/misc/max78000_trng.h
@@ -8,7 +8,7 @@
 #ifndef HW_MAX78000_TRNG_H
 #define HW_MAX78000_TRNG_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_TRNG "max78000-trng"
diff --git a/include/hw/misc/mchp_pfsoc_dmc.h b/include/hw/misc/mchp_pfsoc_dmc.h
index 3bc1581e0f2..2ed582fb8ce 100644
--- a/include/hw/misc/mchp_pfsoc_dmc.h
+++ b/include/hw/misc/mchp_pfsoc_dmc.h
@@ -23,7 +23,7 @@
 #ifndef MCHP_PFSOC_DMC_H
 #define MCHP_PFSOC_DMC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /* DDR SGMII PHY module */
 
diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
index 3fd3e749665..eaaa2ac5d98 100644
--- a/include/hw/misc/mchp_pfsoc_ioscb.h
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -23,7 +23,7 @@
 #ifndef MCHP_PFSOC_IOSCB_H
 #define MCHP_PFSOC_IOSCB_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 typedef struct MchpPfSoCIoscbState {
     SysBusDevice parent;
diff --git a/include/hw/misc/mchp_pfsoc_sysreg.h b/include/hw/misc/mchp_pfsoc_sysreg.h
index c2232bd28d0..c2b3688a94b 100644
--- a/include/hw/misc/mchp_pfsoc_sysreg.h
+++ b/include/hw/misc/mchp_pfsoc_sysreg.h
@@ -23,7 +23,7 @@
 #ifndef MCHP_PFSOC_SYSREG_H
 #define MCHP_PFSOC_SYSREG_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define MCHP_PFSOC_SYSREG_REG_SIZE  0x2000
 
diff --git a/include/hw/misc/mips_cmgcr.h b/include/hw/misc/mips_cmgcr.h
index db4bf5f4499..cec0edd6205 100644
--- a/include/hw/misc/mips_cmgcr.h
+++ b/include/hw/misc/mips_cmgcr.h
@@ -10,7 +10,7 @@
 #ifndef MIPS_CMGCR_H
 #define MIPS_CMGCR_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_MIPS_GCR "mips-gcr"
diff --git a/include/hw/misc/mips_cpc.h b/include/hw/misc/mips_cpc.h
index fcafbd5e002..73ed7597e82 100644
--- a/include/hw/misc/mips_cpc.h
+++ b/include/hw/misc/mips_cpc.h
@@ -20,7 +20,7 @@
 #ifndef MIPS_CPC_H
 #define MIPS_CPC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define CPC_ADDRSPACE_SZ    0x6000
diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 27c9a1090d5..0d1c9c419c4 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -20,7 +20,7 @@
 #ifndef MIPS_ITU_H
 #define MIPS_ITU_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_MIPS_ITU "mips-itu"
diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index 920871a598b..150e30a2c11 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -28,7 +28,7 @@
 #define MOS6522_H
 
 #include "exec/hwaddr.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define MOS6522_NUM_REGS 16
diff --git a/include/hw/misc/mps2-fpgaio.h b/include/hw/misc/mps2-fpgaio.h
index 7b8bd604de0..edd9f231212 100644
--- a/include/hw/misc/mps2-fpgaio.h
+++ b/include/hw/misc/mps2-fpgaio.h
@@ -21,7 +21,7 @@
 #ifndef MPS2_FPGAIO_H
 #define MPS2_FPGAIO_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/led.h"
 #include "qom/object.h"
 
diff --git a/include/hw/misc/mps2-scc.h b/include/hw/misc/mps2-scc.h
index 8ff188c06b1..989b2e057dc 100644
--- a/include/hw/misc/mps2-scc.h
+++ b/include/hw/misc/mps2-scc.h
@@ -30,7 +30,7 @@
 #ifndef MPS2_SCC_H
 #define MPS2_SCC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/led.h"
 #include "qom/object.h"
 
diff --git a/include/hw/misc/msf2-sysreg.h b/include/hw/misc/msf2-sysreg.h
index fc1890e710d..e213aedfb73 100644
--- a/include/hw/misc/msf2-sysreg.h
+++ b/include/hw/misc/msf2-sysreg.h
@@ -25,7 +25,7 @@
 #ifndef HW_MSF2_SYSREG_H
 #define HW_MSF2_SYSREG_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 enum {
diff --git a/include/hw/misc/npcm7xx_mft.h b/include/hw/misc/npcm7xx_mft.h
index 79855b6f25d..406ec944434 100644
--- a/include/hw/misc/npcm7xx_mft.h
+++ b/include/hw/misc/npcm7xx_mft.h
@@ -19,7 +19,7 @@
 #include "system/memory.h"
 #include "hw/core/clock.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 /* Max Fan input number. */
diff --git a/include/hw/misc/npcm7xx_pwm.h b/include/hw/misc/npcm7xx_pwm.h
index 6a54b40005d..b5ae9338049 100644
--- a/include/hw/misc/npcm7xx_pwm.h
+++ b/include/hw/misc/npcm7xx_pwm.h
@@ -17,7 +17,7 @@
 #define NPCM7XX_PWM_H
 
 #include "hw/core/clock.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 
 /* Each PWM module holds 4 PWM channels. */
diff --git a/include/hw/misc/npcm7xx_rng.h b/include/hw/misc/npcm7xx_rng.h
index 650375dc2cd..90858a71f5c 100644
--- a/include/hw/misc/npcm7xx_rng.h
+++ b/include/hw/misc/npcm7xx_rng.h
@@ -16,7 +16,7 @@
 #ifndef NPCM7XX_RNG_H
 #define NPCM7XX_RNG_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 struct NPCM7xxRNGState {
     SysBusDevice parent;
diff --git a/include/hw/misc/npcm_clk.h b/include/hw/misc/npcm_clk.h
index 50b93a0094d..74c5c1634a9 100644
--- a/include/hw/misc/npcm_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -18,7 +18,7 @@
 
 #include "system/memory.h"
 #include "hw/core/clock.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define NPCM7XX_CLK_NR_REGS             (0x70 / sizeof(uint32_t))
 #define NPCM8XX_CLK_NR_REGS             (0xc4 / sizeof(uint32_t))
diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
index 702e7fddb1f..97a6e531b89 100644
--- a/include/hw/misc/npcm_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -17,7 +17,7 @@
 #define NPCM_GCR_H
 
 #include "system/memory.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 /*
diff --git a/include/hw/misc/nrf51_rng.h b/include/hw/misc/nrf51_rng.h
index 9aff9a76f89..0c2f6d2257b 100644
--- a/include/hw/misc/nrf51_rng.h
+++ b/include/hw/misc/nrf51_rng.h
@@ -34,7 +34,7 @@
 #ifndef NRF51_RNG_H
 #define NRF51_RNG_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
 #define TYPE_NRF51_RNG "nrf51_soc.rng"
diff --git a/include/hw/misc/sifive_e_aon.h b/include/hw/misc/sifive_e_aon.h
index 2ae1c4139ca..efa2c3023f6 100644
--- a/include/hw/misc/sifive_e_aon.h
+++ b/include/hw/misc/sifive_e_aon.h
@@ -19,7 +19,7 @@
 #ifndef HW_SIFIVE_AON_H
 #define HW_SIFIVE_AON_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_SIFIVE_E_AON "riscv.sifive.e.aon"
diff --git a/include/hw/misc/sifive_e_prci.h b/include/hw/misc/sifive_e_prci.h
index 6aa949e910d..d0abd59f4b7 100644
--- a/include/hw/misc/sifive_e_prci.h
+++ b/include/hw/misc/sifive_e_prci.h
@@ -19,7 +19,7 @@
 #ifndef HW_SIFIVE_E_PRCI_H
 #define HW_SIFIVE_E_PRCI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 enum {
     SIFIVE_E_PRCI_HFROSCCFG = 0x0,
diff --git a/include/hw/misc/sifive_test.h b/include/hw/misc/sifive_test.h
index 88a38d00c59..85afd352631 100644
--- a/include/hw/misc/sifive_test.h
+++ b/include/hw/misc/sifive_test.h
@@ -19,7 +19,7 @@
 #ifndef HW_SIFIVE_TEST_H
 #define HW_SIFIVE_TEST_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_SIFIVE_TEST "riscv.sifive.test"
diff --git a/include/hw/misc/sifive_u_otp.h b/include/hw/misc/sifive_u_otp.h
index 170d2148f25..b3d2091a58a 100644
--- a/include/hw/misc/sifive_u_otp.h
+++ b/include/hw/misc/sifive_u_otp.h
@@ -19,7 +19,7 @@
 #ifndef HW_SIFIVE_U_OTP_H
 #define HW_SIFIVE_U_OTP_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define SIFIVE_U_OTP_PA         0x00
 #define SIFIVE_U_OTP_PAIO       0x04
diff --git a/include/hw/misc/sifive_u_prci.h b/include/hw/misc/sifive_u_prci.h
index 4d2491ad46d..c0cc755a26c 100644
--- a/include/hw/misc/sifive_u_prci.h
+++ b/include/hw/misc/sifive_u_prci.h
@@ -19,7 +19,7 @@
 #ifndef HW_SIFIVE_U_PRCI_H
 #define HW_SIFIVE_U_PRCI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define SIFIVE_U_PRCI_HFXOSCCFG     0x00
 #define SIFIVE_U_PRCI_COREPLLCFG0   0x04
diff --git a/include/hw/misc/stm32_rcc.h b/include/hw/misc/stm32_rcc.h
index ffbdf202ea5..4dccacc2db5 100644
--- a/include/hw/misc/stm32_rcc.h
+++ b/include/hw/misc/stm32_rcc.h
@@ -25,7 +25,7 @@
 #ifndef HW_STM32_RCC_H
 #define HW_STM32_RCC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define STM32_RCC_CR 0x00
diff --git a/include/hw/misc/stm32f2xx_syscfg.h b/include/hw/misc/stm32f2xx_syscfg.h
index 8595a3b31b0..89e47aa091f 100644
--- a/include/hw/misc/stm32f2xx_syscfg.h
+++ b/include/hw/misc/stm32f2xx_syscfg.h
@@ -25,7 +25,7 @@
 #ifndef HW_STM32F2XX_SYSCFG_H
 #define HW_STM32F2XX_SYSCFG_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define SYSCFG_MEMRMP  0x00
diff --git a/include/hw/misc/stm32f4xx_exti.h b/include/hw/misc/stm32f4xx_exti.h
index fc11c595fa4..a2d57ee3459 100644
--- a/include/hw/misc/stm32f4xx_exti.h
+++ b/include/hw/misc/stm32f4xx_exti.h
@@ -25,7 +25,7 @@
 #ifndef HW_STM32F4XX_EXTI_H
 #define HW_STM32F4XX_EXTI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define EXTI_IMR   0x00
diff --git a/include/hw/misc/stm32f4xx_syscfg.h b/include/hw/misc/stm32f4xx_syscfg.h
index 9fce67f4b48..e6d2bc1ff3b 100644
--- a/include/hw/misc/stm32f4xx_syscfg.h
+++ b/include/hw/misc/stm32f4xx_syscfg.h
@@ -25,7 +25,7 @@
 #ifndef HW_STM32F4XX_SYSCFG_H
 #define HW_STM32F4XX_SYSCFG_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define SYSCFG_MEMRMP  0x00
diff --git a/include/hw/misc/stm32l4x5_exti.h b/include/hw/misc/stm32l4x5_exti.h
index 62f79362f28..543662c7b90 100644
--- a/include/hw/misc/stm32l4x5_exti.h
+++ b/include/hw/misc/stm32l4x5_exti.h
@@ -24,7 +24,7 @@
 #ifndef HW_STM32L4X5_EXTI_H
 #define HW_STM32L4X5_EXTI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_STM32L4X5_EXTI "stm32l4x5-exti"
diff --git a/include/hw/misc/stm32l4x5_rcc.h b/include/hw/misc/stm32l4x5_rcc.h
index 0fbfba5c40b..64ead11b3d4 100644
--- a/include/hw/misc/stm32l4x5_rcc.h
+++ b/include/hw/misc/stm32l4x5_rcc.h
@@ -18,7 +18,7 @@
 #ifndef HW_STM32L4X5_RCC_H
 #define HW_STM32L4X5_RCC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_STM32L4X5_RCC "stm32l4x5-rcc"
diff --git a/include/hw/misc/stm32l4x5_syscfg.h b/include/hw/misc/stm32l4x5_syscfg.h
index c450df2b9ea..d83b4c07239 100644
--- a/include/hw/misc/stm32l4x5_syscfg.h
+++ b/include/hw/misc/stm32l4x5_syscfg.h
@@ -24,7 +24,7 @@
 #ifndef HW_STM32L4X5_SYSCFG_H
 #define HW_STM32L4X5_SYSCFG_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
 
diff --git a/include/hw/misc/tz-mpc.h b/include/hw/misc/tz-mpc.h
index 74d5d822cf3..bda4bc2ae3c 100644
--- a/include/hw/misc/tz-mpc.h
+++ b/include/hw/misc/tz-mpc.h
@@ -31,7 +31,7 @@
 #ifndef TZ_MPC_H
 #define TZ_MPC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_TZ_MPC "tz-mpc"
diff --git a/include/hw/misc/tz-msc.h b/include/hw/misc/tz-msc.h
index 77cc7f24048..07112d8caa3 100644
--- a/include/hw/misc/tz-msc.h
+++ b/include/hw/misc/tz-msc.h
@@ -50,7 +50,7 @@
 #ifndef TZ_MSC_H
 #define TZ_MSC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "target/arm/idau.h"
 #include "qom/object.h"
 
diff --git a/include/hw/misc/tz-ppc.h b/include/hw/misc/tz-ppc.h
index 021d671b29b..3fb9401160f 100644
--- a/include/hw/misc/tz-ppc.h
+++ b/include/hw/misc/tz-ppc.h
@@ -65,7 +65,7 @@
 #ifndef TZ_PPC_H
 #define TZ_PPC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_TZ_PPC "tz-ppc"
diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 904f502fab1..77a5077511f 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -9,7 +9,7 @@
 #define HW_MISC_UNIMP_H
 
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 
diff --git a/include/hw/misc/virt_ctrl.h b/include/hw/misc/virt_ctrl.h
index 81346cf017e..ddce36f3b7e 100644
--- a/include/hw/misc/virt_ctrl.h
+++ b/include/hw/misc/virt_ctrl.h
@@ -7,7 +7,7 @@
 #ifndef VIRT_CTRL_H
 #define VIRT_CTRL_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_VIRT_CTRL "virt-ctrl"
 OBJECT_DECLARE_SIMPLE_TYPE(VirtCtrlState, VIRT_CTRL)
diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/xlnx-versal-cframe-reg.h
index fe8788a7453..8f5c2959a82 100644
--- a/include/hw/misc/xlnx-versal-cframe-reg.h
+++ b/include/hw/misc/xlnx-versal-cframe-reg.h
@@ -17,7 +17,7 @@
 #ifndef HW_MISC_XLNX_VERSAL_CFRAME_REG_H
 #define HW_MISC_XLNX_VERSAL_CFRAME_REG_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "hw/misc/xlnx-cfi-if.h"
 #include "hw/misc/xlnx-versal-cfu.h"
diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
index 3d7ca506de1..e4fefe43c00 100644
--- a/include/hw/misc/xlnx-versal-cfu.h
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -17,7 +17,7 @@
 #ifndef HW_MISC_XLNX_VERSAL_CFU_APB_H
 #define HW_MISC_XLNX_VERSAL_CFU_APB_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "hw/misc/xlnx-cfi-if.h"
 #include "qemu/fifo32.h"
diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index ace3d198bde..fea7768642f 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -10,7 +10,7 @@
 #ifndef HW_MISC_XLNX_VERSAL_CRL_H
 #define HW_MISC_XLNX_VERSAL_CRL_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "target/arm/cpu-qom.h"
 #include "hw/arm/xlnx-versal-version.h"
diff --git a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h b/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
index d8f45bd94b2..046f3e525c2 100644
--- a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
+++ b/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
@@ -54,7 +54,7 @@
 #ifndef XLNX_VERSAL_PMC_IOU_SLCR_H
 #define XLNX_VERSAL_PMC_IOU_SLCR_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 
 #define TYPE_XILINX_VERSAL_PMC_IOU_SLCR "xlnx.versal-pmc-iou-slcr"
diff --git a/include/hw/misc/xlnx-versal-trng.h b/include/hw/misc/xlnx-versal-trng.h
index 8de29104048..ea6e4cb2e1a 100644
--- a/include/hw/misc/xlnx-versal-trng.h
+++ b/include/hw/misc/xlnx-versal-trng.h
@@ -27,7 +27,7 @@
 #define XLNX_VERSAL_TRNG_H
 
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 
 #define TYPE_XLNX_VERSAL_TRNG "xlnx.versal-trng"
diff --git a/include/hw/misc/xlnx-versal-xramc.h b/include/hw/misc/xlnx-versal-xramc.h
index e79941d8865..e888a9f03de 100644
--- a/include/hw/misc/xlnx-versal-xramc.h
+++ b/include/hw/misc/xlnx-versal-xramc.h
@@ -9,7 +9,7 @@
 #ifndef XLNX_VERSAL_XRAMC_H
 #define XLNX_VERSAL_XRAMC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 
 #define TYPE_XLNX_XRAM_CTRL "xlnx.versal-xramc"
diff --git a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h b/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
index c0315720053..cc0a531c244 100644
--- a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
+++ b/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
@@ -11,7 +11,7 @@
 #ifndef HW_MISC_XLNX_ZYNQMP_APU_CTRL_H
 #define HW_MISC_XLNX_ZYNQMP_APU_CTRL_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "target/arm/cpu-qom.h"
 
diff --git a/include/hw/misc/xlnx-zynqmp-crf.h b/include/hw/misc/xlnx-zynqmp-crf.h
index df83034a988..933867a6e54 100644
--- a/include/hw/misc/xlnx-zynqmp-crf.h
+++ b/include/hw/misc/xlnx-zynqmp-crf.h
@@ -8,7 +8,7 @@
 #ifndef HW_MISC_XLNX_ZYNQMP_CRF_H
 #define HW_MISC_XLNX_ZYNQMP_CRF_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 
 #define TYPE_XLNX_ZYNQMP_CRF "xlnx.zynqmp_crf"
diff --git a/include/hw/net/allwinner-sun8i-emac.h b/include/hw/net/allwinner-sun8i-emac.h
index 185895f4e13..24662a24ac0 100644
--- a/include/hw/net/allwinner-sun8i-emac.h
+++ b/include/hw/net/allwinner-sun8i-emac.h
@@ -22,7 +22,7 @@
 
 #include "qom/object.h"
 #include "net/net.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /**
  * Object model
diff --git a/include/hw/net/allwinner_emac.h b/include/hw/net/allwinner_emac.h
index 534e748982f..b3482e137ee 100644
--- a/include/hw/net/allwinner_emac.h
+++ b/include/hw/net/allwinner_emac.h
@@ -27,7 +27,7 @@
 #include "net/net.h"
 #include "qemu/fifo8.h"
 #include "hw/net/mii.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_AW_EMAC "allwinner-emac"
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index e63941f18fc..f5f1fa47c16 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -30,7 +30,7 @@
 OBJECT_DECLARE_SIMPLE_TYPE(CadenceGEMState, CADENCE_GEM)
 
 #include "net/net.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define CADENCE_GEM_MAXREG        (0x00000800 / 4) /* Last valid GEM address */
 
diff --git a/include/hw/net/dp8393x.h b/include/hw/net/dp8393x.h
index 24273dc1f43..5fe02d5a3c5 100644
--- a/include/hw/net/dp8393x.h
+++ b/include/hw/net/dp8393x.h
@@ -20,7 +20,7 @@
 #ifndef HW_NET_DP8393X_H
 #define HW_NET_DP8393X_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "system/memory.h"
 
diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index 24ccdf0260a..414963c5fbd 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -19,7 +19,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FTGMAC100State, FTGMAC100)
 #define FTGMAC100_REG_HIGH_MEM_SIZE 0x100
 #define FTGMAC100_REG_HIGH_OFFSET 0x100
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "net/net.h"
 
 /*
diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 99fc285402c..f0ac7d60e14 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -30,7 +30,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXFECState, IMX_FEC)
 
 #define TYPE_IMX_ENET "imx.enet"
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/net/lan9118_phy.h"
 #include "hw/core/irq.h"
 #include "net/net.h"
diff --git a/include/hw/net/lan9118_phy.h b/include/hw/net/lan9118_phy.h
index af12fc33d5f..1f9ad643c7b 100644
--- a/include/hw/net/lan9118_phy.h
+++ b/include/hw/net/lan9118_phy.h
@@ -12,7 +12,7 @@
 #define HW_NET_LAN9118_PHY_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_LAN9118_PHY "lan9118-phy"
 OBJECT_DECLARE_SIMPLE_TYPE(Lan9118PhyState, LAN9118_PHY)
diff --git a/include/hw/net/lance.h b/include/hw/net/lance.h
index f645d6af67f..be473e2eedb 100644
--- a/include/hw/net/lance.h
+++ b/include/hw/net/lance.h
@@ -31,7 +31,7 @@
 
 #include "net/net.h"
 #include "hw/net/pcnet.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_LANCE "lance"
diff --git a/include/hw/net/lasi_82596.h b/include/hw/net/lasi_82596.h
index c46a4a137e2..ab31874a7c5 100644
--- a/include/hw/net/lasi_82596.h
+++ b/include/hw/net/lasi_82596.h
@@ -10,7 +10,7 @@
 
 #include "net/net.h"
 #include "hw/net/i82596.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_LASI_82596 "lasi_82596"
 typedef struct SysBusI82596State SysBusI82596State;
diff --git a/include/hw/net/msf2-emac.h b/include/hw/net/msf2-emac.h
index b5d9127e46c..f018ab3ff38 100644
--- a/include/hw/net/msf2-emac.h
+++ b/include/hw/net/msf2-emac.h
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "net/net.h"
 #include "net/eth.h"
diff --git a/include/hw/net/npcm7xx_emc.h b/include/hw/net/npcm7xx_emc.h
index 03c9941d82d..238507cadce 100644
--- a/include/hw/net/npcm7xx_emc.h
+++ b/include/hw/net/npcm7xx_emc.h
@@ -18,7 +18,7 @@
 #define NPCM7XX_EMC_H
 
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "net/net.h"
 
 /* 32-bit register indices. */
diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
index 44ee7b1bcba..d4fe49ada57 100644
--- a/include/hw/net/npcm_gmac.h
+++ b/include/hw/net/npcm_gmac.h
@@ -21,7 +21,7 @@
 #define NPCM_GMAC_H
 
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "net/net.h"
 
 #define NPCM_GMAC_NR_REGS (0x1060 / sizeof(uint32_t))
diff --git a/include/hw/net/npcm_pcs.h b/include/hw/net/npcm_pcs.h
index d5c481ad70d..7f5aa76353c 100644
--- a/include/hw/net/npcm_pcs.h
+++ b/include/hw/net/npcm_pcs.h
@@ -17,7 +17,7 @@
 #ifndef NPCM_PCS_H
 #define NPCM_PCS_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define NPCM_PCS_NR_SR_CTLS     (0x12 / sizeof(uint16_t))
 #define NPCM_PCS_NR_SR_MIIS     (0x20 / sizeof(uint16_t))
diff --git a/include/hw/net/xlnx-zynqmp-can.h b/include/hw/net/xlnx-zynqmp-can.h
index d23c1523caf..b43384a0983 100644
--- a/include/hw/net/xlnx-zynqmp-can.h
+++ b/include/hw/net/xlnx-zynqmp-can.h
@@ -30,7 +30,7 @@
 #ifndef XLNX_ZYNQMP_CAN_H
 #define XLNX_ZYNQMP_CAN_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "net/can_emu.h"
 #include "net/can_host.h"
diff --git a/include/hw/nubus/nubus.h b/include/hw/nubus/nubus.h
index 105ddddd0d8..52d8797053e 100644
--- a/include/hw/nubus/nubus.h
+++ b/include/hw/nubus/nubus.h
@@ -10,7 +10,7 @@
 #define HW_NUBUS_NUBUS_H
 
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
 #include "qemu/units.h"
diff --git a/include/hw/nvram/bcm2835_otp.h b/include/hw/nvram/bcm2835_otp.h
index 1df33700bde..dba92a41e87 100644
--- a/include/hw/nvram/bcm2835_otp.h
+++ b/include/hw/nvram/bcm2835_otp.h
@@ -9,7 +9,7 @@
 #ifndef BCM2835_OTP_H
 #define BCM2835_OTP_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_OTP "bcm2835-otp"
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index d41b9328fd1..a29a5d55eab 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -3,7 +3,7 @@
 
 #include "exec/hwaddr.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/dma.h"
 #include "qom/object.h"
 
diff --git a/include/hw/nvram/mac_nvram.h b/include/hw/nvram/mac_nvram.h
index e9d8398f849..e0237328225 100644
--- a/include/hw/nvram/mac_nvram.h
+++ b/include/hw/nvram/mac_nvram.h
@@ -27,7 +27,7 @@
 #define MAC_NVRAM_H
 
 #include "system/memory.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define MACIO_NVRAM_SIZE 0x2000
 
diff --git a/include/hw/nvram/npcm7xx_otp.h b/include/hw/nvram/npcm7xx_otp.h
index 77b05f8b82c..95118c64a74 100644
--- a/include/hw/nvram/npcm7xx_otp.h
+++ b/include/hw/nvram/npcm7xx_otp.h
@@ -17,7 +17,7 @@
 #define NPCM7XX_OTP_H
 
 #include "system/memory.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /* Each OTP module holds 8192 bits of one-time programmable storage */
 #define NPCM7XX_OTP_ARRAY_BITS (8192)
diff --git a/include/hw/nvram/nrf51_nvm.h b/include/hw/nvram/nrf51_nvm.h
index d85e788df5d..172e344a5d5 100644
--- a/include/hw/nvram/nrf51_nvm.h
+++ b/include/hw/nvram/nrf51_nvm.h
@@ -22,7 +22,7 @@
 #ifndef NRF51_NVM_H
 #define NRF51_NVM_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #define TYPE_NRF51_NVM "nrf51_soc.nvm"
 OBJECT_DECLARE_SIMPLE_TYPE(NRF51NVMState, NRF51_NVM)
diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
index 27423035d40..7a8dd85effd 100644
--- a/include/hw/nvram/xlnx-bbram.h
+++ b/include/hw/nvram/xlnx-bbram.h
@@ -29,7 +29,7 @@
 #include "system/block-backend.h"
 #include "hw/core/qdev.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 
 #define RMAX_XLNX_BBRAM ((0x4c / 4) + 1)
diff --git a/include/hw/nvram/xlnx-versal-efuse.h b/include/hw/nvram/xlnx-versal-efuse.h
index 07f1000a851..b10d7483171 100644
--- a/include/hw/nvram/xlnx-versal-efuse.h
+++ b/include/hw/nvram/xlnx-versal-efuse.h
@@ -23,7 +23,7 @@
 #define XLNX_VERSAL_EFUSE_H
 
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "hw/nvram/xlnx-efuse.h"
 
diff --git a/include/hw/nvram/xlnx-zynqmp-efuse.h b/include/hw/nvram/xlnx-zynqmp-efuse.h
index d4886943860..b62f8181fd9 100644
--- a/include/hw/nvram/xlnx-zynqmp-efuse.h
+++ b/include/hw/nvram/xlnx-zynqmp-efuse.h
@@ -23,7 +23,7 @@
 #define XLNX_ZYNQMP_EFUSE_H
 
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "hw/nvram/xlnx-efuse.h"
 
diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index be53ea96b90..e660119a455 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -17,7 +17,7 @@
 #ifndef ASPEED_PCIE_H
 #define ASPEED_PCIE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pcie_port.h"
diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index a35a3bd06c8..e82fdc5fe74 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -21,7 +21,7 @@
 #ifndef DESIGNWARE_H
 #define DESIGNWARE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/pci_bridge.h"
 #include "qom/object.h"
 
diff --git a/include/hw/pci-host/fsl_imx8m_phy.h b/include/hw/pci-host/fsl_imx8m_phy.h
index 5f1b212fd97..5786534b0ef 100644
--- a/include/hw/pci-host/fsl_imx8m_phy.h
+++ b/include/hw/pci-host/fsl_imx8m_phy.h
@@ -9,7 +9,7 @@
 #ifndef HW_PCIHOST_FSLIMX8MPCIEPHY_H
 #define HW_PCIHOST_FSLIMX8MPCIEPHY_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #include "system/memory.h"
 
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index feaf8274740..695886dedde 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -21,7 +21,7 @@
 #define HW_GPEX_H
 
 #include "exec/hwaddr.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie_host.h"
 #include "qom/object.h"
diff --git a/include/hw/pci-host/xilinx-pcie.h b/include/hw/pci-host/xilinx-pcie.h
index e1b3c1c2804..b7bab77c247 100644
--- a/include/hw/pci-host/xilinx-pcie.h
+++ b/include/hw/pci-host/xilinx-pcie.h
@@ -20,7 +20,7 @@
 #ifndef HW_XILINX_PCIE_H
 #define HW_XILINX_PCIE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie_host.h"
 #include "qom/object.h"
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index 954dd446fa4..d8dec0ee049 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -28,7 +28,7 @@
 #ifndef PCI_HOST_H
 #define PCI_HOST_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define PCI_HOST_BYPASS_IOMMU "bypass-iommu"
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 76764882453..e42805144ef 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -26,7 +26,7 @@
 #include "system/memory.h"
 #include "qemu/iov.h"
 #include "system/dma.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 typedef struct DBDMA_io DBDMA_io;
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index 9c6af8e2076..5856955af9a 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -1,7 +1,7 @@
 #ifndef OPENPIC_H
 #define OPENPIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/cpu.h"
 #include "qom/object.h"
 
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index a8c1968f281..24f8843a409 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -22,7 +22,7 @@
 
 #include "cpu.h"
 #include "hw/core/boards.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/ppc/pnv_pnor.h"
 
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index a5b8c49680d..ea47c97dd38 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -14,7 +14,7 @@
 #include "hw/ppc/pnv_sbe.h"
 #include "hw/ppc/pnv_xive.h"
 #include "hw/ppc/pnv_i2c.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 OBJECT_DECLARE_TYPE(PnvChip, PnvChipClass,
                     PNV_CHIP)
diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
index b44cafe918d..7bf737d33b4 100644
--- a/include/hw/ppc/pnv_pnor.h
+++ b/include/hw/ppc/pnv_pnor.h
@@ -10,7 +10,7 @@
 #ifndef PPC_PNV_PNOR_H
 #define PPC_PNV_PNOR_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /*
  * PNOR offset on the LPC FW address space. For now this should be 0 because
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index 8a04860aa8b..e1e1ade0ce7 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -20,7 +20,7 @@
 #ifndef PPC_PNV_PSI_H
 #define PPC_PNV_PSI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/ppc/xics.h"
 #include "hw/ppc/xive.h"
 #include "hw/core/qdev.h"
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 2e94b006730..b76bf091cfa 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -27,7 +27,7 @@
 
 #include "hw/ppc/ppc.h"
 #include "system/memory.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /*
  * Generic DCR device
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index b7ca8544e43..e98d011998f 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -139,7 +139,7 @@
 #define PPC_XIVE_H
 
 #include "system/kvm.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/ppc/xive_regs.h"
 #include "qom/object.h"
 
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index f4437e2c79a..9e2af8d8b17 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -11,7 +11,7 @@
 
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive2_regs.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /*
  * XIVE2 Router (POWER10)
diff --git a/include/hw/riscv/numa.h b/include/hw/riscv/numa.h
index 2d9c41ba818..e68ce8e8afd 100644
--- a/include/hw/riscv/numa.h
+++ b/include/hw/riscv/numa.h
@@ -20,7 +20,7 @@
 #define RISCV_NUMA_H
 
 #include "hw/core/boards.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/numa.h"
 
 /**
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index a6ed73a1956..197fa162311 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -21,7 +21,7 @@
 #ifndef HW_RISCV_HART_H
 #define HW_RISCV_HART_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "qom/object.h"
 
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index acd41e90583..68689768841 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -21,7 +21,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define SPIKE_CPUS_MAX 8
 #define SPIKE_SOCKETS_MAX 8
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 806b78cc639..18a2a323a34 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -21,7 +21,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/block/flash.h"
 #include "hw/intc/riscv_imsic.h"
 
diff --git a/include/hw/rtc/allwinner-rtc.h b/include/hw/rtc/allwinner-rtc.h
index bf415431cd7..2b5ff065665 100644
--- a/include/hw/rtc/allwinner-rtc.h
+++ b/include/hw/rtc/allwinner-rtc.h
@@ -21,7 +21,7 @@
 #define HW_MISC_ALLWINNER_RTC_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /**
  * Constants
diff --git a/include/hw/rtc/aspeed_rtc.h b/include/hw/rtc/aspeed_rtc.h
index 596dfebb46c..ef37dd3d69f 100644
--- a/include/hw/rtc/aspeed_rtc.h
+++ b/include/hw/rtc/aspeed_rtc.h
@@ -8,7 +8,7 @@
 #ifndef HW_RTC_ASPEED_RTC_H
 #define HW_RTC_ASPEED_RTC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 struct AspeedRtcState {
diff --git a/include/hw/rtc/goldfish_rtc.h b/include/hw/rtc/goldfish_rtc.h
index 162be338636..55ed9c4085c 100644
--- a/include/hw/rtc/goldfish_rtc.h
+++ b/include/hw/rtc/goldfish_rtc.h
@@ -22,7 +22,7 @@
 #ifndef HW_RTC_GOLDFISH_RTC_H
 #define HW_RTC_GOLDFISH_RTC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_GOLDFISH_RTC "goldfish_rtc"
diff --git a/include/hw/rtc/pl031.h b/include/hw/rtc/pl031.h
index 9fd4be1abba..c8b26c2f00e 100644
--- a/include/hw/rtc/pl031.h
+++ b/include/hw/rtc/pl031.h
@@ -14,7 +14,7 @@
 #ifndef HW_RTC_PL031_H
 #define HW_RTC_PL031_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
 
diff --git a/include/hw/rtc/xlnx-zynqmp-rtc.h b/include/hw/rtc/xlnx-zynqmp-rtc.h
index a542b87cb89..7d8505ce399 100644
--- a/include/hw/rtc/xlnx-zynqmp-rtc.h
+++ b/include/hw/rtc/xlnx-zynqmp-rtc.h
@@ -28,7 +28,7 @@
 #define HW_RTC_XLNX_ZYNQMP_RTC_H
 
 #include "hw/core/register.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_XLNX_ZYNQMP_RTC "xlnx-zynmp.rtc"
diff --git a/include/hw/s390x/3270-ccw.h b/include/hw/s390x/3270-ccw.h
index 14398822944..6b73c8b51f8 100644
--- a/include/hw/s390x/3270-ccw.h
+++ b/include/hw/s390x/3270-ccw.h
@@ -13,7 +13,7 @@
 #ifndef HW_S390X_3270_CCW_H
 #define HW_S390X_3270_CCW_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/ccw-device.h"
 #include "qom/object.h"
diff --git a/include/hw/s390x/css-bridge.h b/include/hw/s390x/css-bridge.h
index 4f874ed781b..1a29d3a542d 100644
--- a/include/hw/s390x/css-bridge.h
+++ b/include/hw/s390x/css-bridge.h
@@ -14,7 +14,7 @@
 #define HW_S390X_CSS_BRIDGE_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /* virtual css bridge */
 struct VirtualCssBridge {
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 91edaaca409..c9db5279e3a 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -13,7 +13,7 @@
 #ifndef HW_S390_FLIC_H
 #define HW_S390_FLIC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/s390x/adapter.h"
 #include "hw/virtio/virtio.h"
 #include "qemu/queue.h"
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index 33f01f85bb1..ddc61f1c214 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -14,7 +14,7 @@
 #ifndef HW_S390_SCLP_H
 #define HW_S390_SCLP_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "target/s390x/cpu-qom.h"
 #include "qom/object.h"
 
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 3526bad7464..8887ba85124 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -2,7 +2,7 @@
 #define QEMU_HW_ESP_H
 
 #include "hw/scsi/scsi.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/fifo8.h"
 #include "qom/object.h"
 
diff --git a/include/hw/sd/allwinner-sdhost.h b/include/hw/sd/allwinner-sdhost.h
index 1b951177dda..d154d81d24c 100644
--- a/include/hw/sd/allwinner-sdhost.h
+++ b/include/hw/sd/allwinner-sdhost.h
@@ -21,7 +21,7 @@
 #define HW_SD_ALLWINNER_SDHOST_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/sd/sd.h"
 
 /**
diff --git a/include/hw/sd/bcm2835_sdhost.h b/include/hw/sd/bcm2835_sdhost.h
index f6bca5c3979..8ba220d89e9 100644
--- a/include/hw/sd/bcm2835_sdhost.h
+++ b/include/hw/sd/bcm2835_sdhost.h
@@ -14,7 +14,7 @@
 #ifndef BCM2835_SDHOST_H
 #define BCM2835_SDHOST_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
 
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 51fb30ea528..32962c210d7 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -26,7 +26,7 @@
 #define SDHCI_H
 
 #include "hw/pci/pci_device.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
 
diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
index cde8ec02cb6..3181c17043a 100644
--- a/include/hw/sparc/sparc32_dma.h
+++ b/include/hw/sparc/sparc32_dma.h
@@ -1,7 +1,7 @@
 #ifndef SPARC32_DMA_H
 #define SPARC32_DMA_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/scsi/esp.h"
 #include "hw/net/lance.h"
 #include "qom/object.h"
diff --git a/include/hw/sparc/sun4m_iommu.h b/include/hw/sparc/sun4m_iommu.h
index 4e2ab34cdef..ccefafedbc4 100644
--- a/include/hw/sparc/sun4m_iommu.h
+++ b/include/hw/sparc/sun4m_iommu.h
@@ -25,7 +25,7 @@
 #ifndef SUN4M_IOMMU_H
 #define SUN4M_IOMMU_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define IOMMU_NREGS         (4 * 4096 / 4)
diff --git a/include/hw/sparc/sun4u_iommu.h b/include/hw/sparc/sun4u_iommu.h
index f94566a72c9..3ae81a2406a 100644
--- a/include/hw/sparc/sun4u_iommu.h
+++ b/include/hw/sparc/sun4u_iommu.h
@@ -27,7 +27,7 @@
 #ifndef SUN4U_IOMMU_H
 #define SUN4U_IOMMU_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define IOMMU_NREGS             3
diff --git a/include/hw/ssi/allwinner-a10-spi.h b/include/hw/ssi/allwinner-a10-spi.h
index da46e29a278..6e0e2993615 100644
--- a/include/hw/ssi/allwinner-a10-spi.h
+++ b/include/hw/ssi/allwinner-a10-spi.h
@@ -23,7 +23,7 @@
 #define ALLWINNER_A10_SPI_H
 
 #include "hw/ssi/ssi.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/fifo8.h"
 #include "qom/object.h"
 
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 25b95e74060..76831422c6f 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -26,7 +26,7 @@
 #define ASPEED_SMC_H
 
 #include "hw/ssi/ssi.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 struct AspeedSMCState;
diff --git a/include/hw/ssi/bcm2835_spi.h b/include/hw/ssi/bcm2835_spi.h
index d3f8cec1119..d5891fd9257 100644
--- a/include/hw/ssi/bcm2835_spi.h
+++ b/include/hw/ssi/bcm2835_spi.h
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/ssi/ssi.h"
 #include "qom/object.h"
 #include "qemu/fifo8.h"
diff --git a/include/hw/ssi/ibex_spi_host.h b/include/hw/ssi/ibex_spi_host.h
index 5bd5557b9a1..2aac6ee920c 100644
--- a/include/hw/ssi/ibex_spi_host.h
+++ b/include/hw/ssi/ibex_spi_host.h
@@ -27,7 +27,7 @@
 #ifndef IBEX_SPI_HOST_H
 #define IBEX_SPI_HOST_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/fifo8.h"
 #include "qom/object.h"
diff --git a/include/hw/ssi/imx_spi.h b/include/hw/ssi/imx_spi.h
index eeaf49bbac3..9a95127755f 100644
--- a/include/hw/ssi/imx_spi.h
+++ b/include/hw/ssi/imx_spi.h
@@ -10,7 +10,7 @@
 #ifndef IMX_SPI_H
 #define IMX_SPI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/bitops.h"
 #include "qemu/fifo32.h"
diff --git a/include/hw/ssi/mss-spi.h b/include/hw/ssi/mss-spi.h
index ce6279c4310..85e11f72669 100644
--- a/include/hw/ssi/mss-spi.h
+++ b/include/hw/ssi/mss-spi.h
@@ -25,7 +25,7 @@
 #ifndef HW_MSS_SPI_H
 #define HW_MSS_SPI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/fifo32.h"
 #include "qom/object.h"
diff --git a/include/hw/ssi/npcm7xx_fiu.h b/include/hw/ssi/npcm7xx_fiu.h
index 7ebd422ca6c..530d8e2f44a 100644
--- a/include/hw/ssi/npcm7xx_fiu.h
+++ b/include/hw/ssi/npcm7xx_fiu.h
@@ -17,7 +17,7 @@
 #define NPCM7XX_FIU_H
 
 #include "hw/ssi/ssi.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /*
  * Number of registers in our device state structure. Don't change this without
diff --git a/include/hw/ssi/npcm_pspi.h b/include/hw/ssi/npcm_pspi.h
index 37cc784d962..dbf40710f32 100644
--- a/include/hw/ssi/npcm_pspi.h
+++ b/include/hw/ssi/npcm_pspi.h
@@ -17,7 +17,7 @@
 #define NPCM_PSPI_H
 
 #include "hw/ssi/ssi.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /*
  * Number of registers in our device state structure. Don't change this without
diff --git a/include/hw/ssi/pl022.h b/include/hw/ssi/pl022.h
index 25d58db5f32..afddc314c79 100644
--- a/include/hw/ssi/pl022.h
+++ b/include/hw/ssi/pl022.h
@@ -22,7 +22,7 @@
 #ifndef HW_SSI_PL022_H
 #define HW_SSI_PL022_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_PL022 "pl022"
diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
index c591a0663da..31a690854ba 100644
--- a/include/hw/ssi/pnv_spi.h
+++ b/include/hw/ssi/pnv_spi.h
@@ -22,7 +22,7 @@
 #define PPC_PNV_SPI_H
 
 #include "hw/ssi/ssi.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/fifo8.h"
 
 #define TYPE_PNV_SPI "pnv-spi"
diff --git a/include/hw/ssi/sifive_spi.h b/include/hw/ssi/sifive_spi.h
index d0c40cdb11b..e45becb8c59 100644
--- a/include/hw/ssi/sifive_spi.h
+++ b/include/hw/ssi/sifive_spi.h
@@ -23,7 +23,7 @@
 #define HW_SIFIVE_SPI_H
 
 #include "qemu/fifo8.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define SIFIVE_SPI_REG_NUM  (0x78 / 4)
 
diff --git a/include/hw/ssi/stm32f2xx_spi.h b/include/hw/ssi/stm32f2xx_spi.h
index 3683b4ad329..26b02429aaa 100644
--- a/include/hw/ssi/stm32f2xx_spi.h
+++ b/include/hw/ssi/stm32f2xx_spi.h
@@ -25,7 +25,7 @@
 #ifndef HW_STM32F2XX_SPI_H
 #define HW_STM32F2XX_SPI_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/ssi/ssi.h"
 #include "qom/object.h"
 
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 56cf69a37d2..c8f6c5053c4 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -28,7 +28,7 @@
 #include "hw/ssi/ssi.h"
 #include "qemu/fifo32.h"
 #include "hw/core/stream.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 typedef struct XilinxSPIPS XilinxSPIPS;
diff --git a/include/hw/timer/a9gtimer.h b/include/hw/timer/a9gtimer.h
index 6ae9122e4b6..5c9b048b954 100644
--- a/include/hw/timer/a9gtimer.h
+++ b/include/hw/timer/a9gtimer.h
@@ -23,7 +23,7 @@
 #ifndef A9GTIMER_H
 #define A9GTIMER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define A9_GTIMER_MAX_CPUS 4
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwinner-a10-pit.h
index 623a1fec219..fe6a408022e 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -2,7 +2,7 @@
 #define ALLWINNER_A10_PIT_H
 
 #include "hw/core/ptimer.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_AW_A10_PIT "allwinner-A10-timer"
diff --git a/include/hw/timer/arm_mptimer.h b/include/hw/timer/arm_mptimer.h
index 65a96e2a0dc..4c6f5696319 100644
--- a/include/hw/timer/arm_mptimer.h
+++ b/include/hw/timer/arm_mptimer.h
@@ -21,7 +21,7 @@
 #ifndef HW_TIMER_ARM_MPTIMER_H
 #define HW_TIMER_ARM_MPTIMER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define ARM_MPTIMER_MAX_CPUS 4
diff --git a/include/hw/timer/armv7m_systick.h b/include/hw/timer/armv7m_systick.h
index fb73f78a7b8..637dbf35c5c 100644
--- a/include/hw/timer/armv7m_systick.h
+++ b/include/hw/timer/armv7m_systick.h
@@ -12,7 +12,7 @@
 #ifndef HW_TIMER_ARMV7M_SYSTICK_H
 #define HW_TIMER_ARMV7M_SYSTICK_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/clock.h"
diff --git a/include/hw/timer/avr_timer16.h b/include/hw/timer/avr_timer16.h
index a1a032a24dc..5c9dca134a0 100644
--- a/include/hw/timer/avr_timer16.h
+++ b/include/hw/timer/avr_timer16.h
@@ -28,7 +28,7 @@
 #ifndef HW_TIMER_AVR_TIMER16_H
 #define HW_TIMER_AVR_TIMER16_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
 
diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index 93cb3415a68..0674a18f12d 100644
--- a/include/hw/timer/bcm2835_systmr.h
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -9,7 +9,7 @@
 #ifndef BCM2835_SYSTMR_H
 #define BCM2835_SYSTMR_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
diff --git a/include/hw/timer/cadence_ttc.h b/include/hw/timer/cadence_ttc.h
index e1251383f2a..27b555e96a4 100644
--- a/include/hw/timer/cadence_ttc.h
+++ b/include/hw/timer/cadence_ttc.h
@@ -18,7 +18,7 @@
 #ifndef HW_TIMER_CADENCE_TTC_H
 #define HW_TIMER_CADENCE_TTC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 
 typedef struct {
diff --git a/include/hw/timer/cmsdk-apb-dualtimer.h b/include/hw/timer/cmsdk-apb-dualtimer.h
index 103ac228815..7e238f04dfe 100644
--- a/include/hw/timer/cmsdk-apb-dualtimer.h
+++ b/include/hw/timer/cmsdk-apb-dualtimer.h
@@ -26,7 +26,7 @@
 #ifndef CMSDK_APB_DUALTIMER_H
 #define CMSDK_APB_DUALTIMER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/clock.h"
 #include "qom/object.h"
diff --git a/include/hw/timer/cmsdk-apb-timer.h b/include/hw/timer/cmsdk-apb-timer.h
index f8c8fb8ce55..5ecda01776e 100644
--- a/include/hw/timer/cmsdk-apb-timer.h
+++ b/include/hw/timer/cmsdk-apb-timer.h
@@ -12,7 +12,7 @@
 #ifndef CMSDK_APB_TIMER_H
 #define CMSDK_APB_TIMER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/clock.h"
 #include "qom/object.h"
diff --git a/include/hw/timer/digic-timer.h b/include/hw/timer/digic-timer.h
index f62242eaad3..bcd80108a2b 100644
--- a/include/hw/timer/digic-timer.h
+++ b/include/hw/timer/digic-timer.h
@@ -18,7 +18,7 @@
 #ifndef HW_TIMER_DIGIC_TIMER_H
 #define HW_TIMER_DIGIC_TIMER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/ptimer.h"
 #include "qom/object.h"
 
diff --git a/include/hw/timer/ibex_timer.h b/include/hw/timer/ibex_timer.h
index 41f5c82a920..53055f3351b 100644
--- a/include/hw/timer/ibex_timer.h
+++ b/include/hw/timer/ibex_timer.h
@@ -25,7 +25,7 @@
 #ifndef HW_IBEX_TIMER_H
 #define HW_IBEX_TIMER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_IBEX_TIMER "ibex-timer"
 OBJECT_DECLARE_SIMPLE_TYPE(IbexTimerState, IBEX_TIMER)
diff --git a/include/hw/timer/imx_epit.h b/include/hw/timer/imx_epit.h
index 2947fad1069..18d41ec1393 100644
--- a/include/hw/timer/imx_epit.h
+++ b/include/hw/timer/imx_epit.h
@@ -29,7 +29,7 @@
 #ifndef IMX_EPIT_H
 #define IMX_EPIT_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/ptimer.h"
 #include "hw/misc/imx_ccm.h"
 #include "qom/object.h"
diff --git a/include/hw/timer/imx_gpt.h b/include/hw/timer/imx_gpt.h
index 5c12f686e1b..7f0d55b3499 100644
--- a/include/hw/timer/imx_gpt.h
+++ b/include/hw/timer/imx_gpt.h
@@ -29,7 +29,7 @@
 #ifndef IMX_GPT_H
 #define IMX_GPT_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/ptimer.h"
 #include "hw/misc/imx_ccm.h"
 #include "qom/object.h"
diff --git a/include/hw/timer/mss-timer.h b/include/hw/timer/mss-timer.h
index 0cc376f945f..93a73fae72a 100644
--- a/include/hw/timer/mss-timer.h
+++ b/include/hw/timer/mss-timer.h
@@ -25,7 +25,7 @@
 #ifndef HW_MSS_TIMER_H
 #define HW_MSS_TIMER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/ptimer.h"
 #include "qom/object.h"
 
diff --git a/include/hw/timer/npcm7xx_timer.h b/include/hw/timer/npcm7xx_timer.h
index e287375dce6..9ad42c65a8a 100644
--- a/include/hw/timer/npcm7xx_timer.h
+++ b/include/hw/timer/npcm7xx_timer.h
@@ -17,7 +17,7 @@
 #define NPCM7XX_TIMER_H
 
 #include "system/memory.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 
 /* Each Timer Module (TIM) instance holds five 25 MHz timers. */
diff --git a/include/hw/timer/nrf51_timer.h b/include/hw/timer/nrf51_timer.h
index 76827c11dc7..fe282ff78fd 100644
--- a/include/hw/timer/nrf51_timer.h
+++ b/include/hw/timer/nrf51_timer.h
@@ -13,7 +13,7 @@
 #ifndef NRF51_TIMER_H
 #define NRF51_TIMER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
 #define TYPE_NRF51_TIMER "nrf51_soc.timer"
diff --git a/include/hw/timer/renesas_cmt.h b/include/hw/timer/renesas_cmt.h
index 1c0b65c1d5a..e2aa6d47af5 100644
--- a/include/hw/timer/renesas_cmt.h
+++ b/include/hw/timer/renesas_cmt.h
@@ -10,7 +10,7 @@
 #define HW_TIMER_RENESAS_CMT_H
 
 #include "qemu/timer.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_RENESAS_CMT "renesas-cmt"
diff --git a/include/hw/timer/renesas_tmr.h b/include/hw/timer/renesas_tmr.h
index caf7eec0dca..061b8f2900a 100644
--- a/include/hw/timer/renesas_tmr.h
+++ b/include/hw/timer/renesas_tmr.h
@@ -10,7 +10,7 @@
 #define HW_TIMER_RENESAS_TMR_H
 
 #include "qemu/timer.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_RENESAS_TMR "renesas-tmr"
diff --git a/include/hw/timer/sifive_pwm.h b/include/hw/timer/sifive_pwm.h
index 6a8cf7b29e4..d3a49be6b6a 100644
--- a/include/hw/timer/sifive_pwm.h
+++ b/include/hw/timer/sifive_pwm.h
@@ -27,7 +27,7 @@
 #ifndef HW_SIFIVE_PWM_H
 #define HW_SIFIVE_PWM_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
 
diff --git a/include/hw/timer/sse-counter.h b/include/hw/timer/sse-counter.h
index b433e58d370..15bd1a51047 100644
--- a/include/hw/timer/sse-counter.h
+++ b/include/hw/timer/sse-counter.h
@@ -30,7 +30,7 @@
 #ifndef SSE_COUNTER_H
 #define SSE_COUNTER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #include "qemu/notify.h"
 
diff --git a/include/hw/timer/sse-timer.h b/include/hw/timer/sse-timer.h
index 265ad32400d..c9ad2225a63 100644
--- a/include/hw/timer/sse-timer.h
+++ b/include/hw/timer/sse-timer.h
@@ -24,7 +24,7 @@
 #ifndef SSE_TIMER_H
 #define SSE_TIMER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
 #include "hw/timer/sse-counter.h"
diff --git a/include/hw/timer/stellaris-gptm.h b/include/hw/timer/stellaris-gptm.h
index 9d663b58dfa..824723b2730 100644
--- a/include/hw/timer/stellaris-gptm.h
+++ b/include/hw/timer/stellaris-gptm.h
@@ -11,7 +11,7 @@
 #define HW_TIMER_STELLARIS_GPTM_H
 
 #include "qom/object.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/clock.h"
 
diff --git a/include/hw/timer/stm32f2xx_timer.h b/include/hw/timer/stm32f2xx_timer.h
index 90f40f1746f..040e64d4992 100644
--- a/include/hw/timer/stm32f2xx_timer.h
+++ b/include/hw/timer/stm32f2xx_timer.h
@@ -25,7 +25,7 @@
 #ifndef HW_STM32F2XX_TIMER_H
 #define HW_STM32F2XX_TIMER_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
 
diff --git a/include/hw/tricore/tc27x_soc.h b/include/hw/tricore/tc27x_soc.h
index dd3a7485c85..2d2bdca3fd2 100644
--- a/include/hw/tricore/tc27x_soc.h
+++ b/include/hw/tricore/tc27x_soc.h
@@ -21,7 +21,7 @@
 #ifndef TC27X_SOC_H
 #define TC27X_SOC_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "target/tricore/cpu.h"
 #include "qom/object.h"
 
diff --git a/include/hw/tricore/tricore_testdevice.h b/include/hw/tricore/tricore_testdevice.h
index 2c57b62f222..98c87ba76be 100644
--- a/include/hw/tricore/tricore_testdevice.h
+++ b/include/hw/tricore/tricore_testdevice.h
@@ -18,7 +18,7 @@
 #ifndef HW_TRICORE_TESTDEVICE_H
 #define HW_TRICORE_TESTDEVICE_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_TRICORE_TESTDEVICE "tricore_testdevice"
 #define TRICORE_TESTDEVICE(obj) \
diff --git a/include/hw/usb/imx-usb-phy.h b/include/hw/usb/imx-usb-phy.h
index d1e867b77a3..1b45b6e62a5 100644
--- a/include/hw/usb/imx-usb-phy.h
+++ b/include/hw/usb/imx-usb-phy.h
@@ -1,7 +1,7 @@
 #ifndef IMX_USB_PHY_H
 #define IMX_USB_PHY_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/bitops.h"
 #include "qom/object.h"
 
diff --git a/include/hw/usb/xlnx-usb-subsystem.h b/include/hw/usb/xlnx-usb-subsystem.h
index b22e5d065be..e78ca743d34 100644
--- a/include/hw/usb/xlnx-usb-subsystem.h
+++ b/include/hw/usb/xlnx-usb-subsystem.h
@@ -26,7 +26,7 @@
 #define XLNX_USB_SUBSYSTEM_H
 
 #include "hw/core/register.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/usb/xlnx-versal-usb2-ctrl-regs.h"
 #include "hw/usb/hcd-dwc3.h"
 
diff --git a/include/hw/usb/xlnx-versal-usb2-ctrl-regs.h b/include/hw/usb/xlnx-versal-usb2-ctrl-regs.h
index c1470da4758..a8575ad6696 100644
--- a/include/hw/usb/xlnx-versal-usb2-ctrl-regs.h
+++ b/include/hw/usb/xlnx-versal-usb2-ctrl-regs.h
@@ -27,7 +27,7 @@
 #define XLNX_VERSAL_USB2_CTRL_REGS_H
 
 #include "hw/core/register.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #define TYPE_XILINX_VERSAL_USB2_CTRL_REGS "xlnx.versal-usb2-ctrl-regs"
 
diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
index aa492620228..1eab3c0dece 100644
--- a/include/hw/virtio/virtio-mmio.h
+++ b/include/hw/virtio/virtio-mmio.h
@@ -22,7 +22,7 @@
 #ifndef HW_VIRTIO_MMIO_H
 #define HW_VIRTIO_MMIO_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/virtio/virtio-bus.h"
 
 /* QOM macros */
diff --git a/include/hw/watchdog/allwinner-wdt.h b/include/hw/watchdog/allwinner-wdt.h
index 6f84dbd1a72..e6da42a9f78 100644
--- a/include/hw/watchdog/allwinner-wdt.h
+++ b/include/hw/watchdog/allwinner-wdt.h
@@ -25,7 +25,7 @@
 
 #include "qom/object.h"
 #include "hw/core/ptimer.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /*
  * This is a model of the Allwinner watchdog.
diff --git a/include/hw/watchdog/cmsdk-apb-watchdog.h b/include/hw/watchdog/cmsdk-apb-watchdog.h
index 9bf95ba06d5..1c7de639993 100644
--- a/include/hw/watchdog/cmsdk-apb-watchdog.h
+++ b/include/hw/watchdog/cmsdk-apb-watchdog.h
@@ -31,7 +31,7 @@
 #ifndef CMSDK_APB_WATCHDOG_H
 #define CMSDK_APB_WATCHDOG_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/clock.h"
 #include "qom/object.h"
diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
index ace8fe04c87..307a4f291a3 100644
--- a/include/hw/watchdog/sbsa_gwdt.h
+++ b/include/hw/watchdog/sbsa_gwdt.h
@@ -13,7 +13,7 @@
 #define WDT_SBSA_GWDT_H
 
 #include "qemu/bitops.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 
 #define TYPE_WDT_SBSA "sbsa_gwdt"
diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
index 830b0a79368..ecf20fbb4ea 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -11,7 +11,7 @@
 #define WDT_ASPEED_H
 
 #include "hw/misc/aspeed_scu.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define TYPE_ASPEED_WDT "aspeed.wdt"
diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index 53a8360e906..ad36b8820d8 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -13,7 +13,7 @@
 #define WDT_IMX2_H
 
 #include "qemu/bitops.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
 #include "qom/object.h"
diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
index 629bec90d09..232c496008c 100644
--- a/include/hw/xen/xen_pvdev.h
+++ b/include/hw/xen/xen_pvdev.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_HW_XEN_PVDEV_H
 #define QEMU_HW_XEN_PVDEV_H
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/xen/xen_backend_ops.h"
 
 /* ------------------------------------------------------------- */
diff --git a/rust/hw/core/wrapper.h b/rust/hw/core/wrapper.h
index f6b34161a68..8278738f3d8 100644
--- a/rust/hw/core/wrapper.h
+++ b/rust/hw/core/wrapper.h
@@ -24,7 +24,7 @@ typedef enum memory_order {
 
 #include "qemu/osdep.h"
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/clock.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 75d5b30bb8b..75edb2c0a65 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/cxl/cxl.h"
diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index a490ae640d9..50a04a0722f 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index d7508ee0ecd..66f30757dd5 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -20,7 +20,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/char/serial-mm.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/misc/unimp.h"
 #include "system/system.h"
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 757c89ef39f..262e99b3f9a 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -23,7 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/core/qdev.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/hcd-ehci.h"
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 396e886af47..a1ae75deb6b 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -24,7 +24,7 @@
 #include "qemu/units.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/hcd-ehci.h"
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index b6fc95df3b6..ddb210c8957 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -16,7 +16,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/registerfields.h"
 #include "hw/arm/armsse.h"
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 844d620286c..a29eab6c915 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/arm/armv7m.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index cd61ba15054..ee2f44debd1 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "hw/arm/bcm2836.h"
 #include "hw/arm/raspi_platform.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 22aa754613c..c14a8540465 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -10,7 +10,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/arm/raspi_platform.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/bcm2838.h"
 #include "trace.h"
 
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 73c40bc57da..91f0a94b6ff 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/boards.h"
 #include "strongarm.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 5d68579cd6b..25c385ba1f5 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -29,7 +29,7 @@
 #include "hw/core/irq.h"
 #include "system/blockdev.h"
 #include "system/system.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index e8c171f40a8..1b8c9b618f8 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -25,7 +25,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index b8c1256328d..92d497999c0 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index b24df11db92..118808f2dc7 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/boards.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 39e8f69cae0..250fdb49b6f 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index a4ccfa373a6..8d8ea71da43 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "qemu/log.h"
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index fcba6eb52d5..f3d6be1e295 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -38,7 +38,7 @@
 #include "system/runstate.h"
 #include "system/rtc.h"
 #include "qemu/range.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/cutils.h"
 #include "qemu/bcd.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index d7f96b9d3e4..c9558be4d45 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e12a64a20fb..985dfb345f2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -19,7 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev.h"
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index f3e8e15de81..56ecc828f4f 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -11,7 +11,7 @@
 #include "qemu/bitops.h"
 #include "qapi/error.h"
 #include "hw/core/split-irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/sd/sd.h"
 #include "hw/ssi/ssi.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index acc75476c34..5a3242195ab 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -31,7 +31,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "strongarm.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 94661b83d00..254b1610b39 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 75cb77da828..cc6ae7d4c48 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d8773cb541f..fd0e28f030a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -34,7 +34,7 @@
 #include "qemu/option.h"
 #include "qemu/target-info.h"
 #include "monitor/qdev.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 0d9c01e4b78..d43f36b7189 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "net/net.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index e82ac8e3538..2b04513ba2e 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -17,7 +17,7 @@
 #include "system/address-spaces.h"
 #include "hw/block/flash.h"
 #include "hw/core/boards.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/fdt.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index a0b2f18b551..facf92b45cc 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "qobject/qlist.h"
 #include "qemu/module.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "system/system.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 77a5cc1092d..a934c2e82c0 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "qemu/audio.h"
 #include "hw/audio/asc.h"
diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index 97cceb44d86..bcf98160ec3 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 39f4b4514dc..6d5e99123d6 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 117b6b0ae65..4a9b8ad65ce 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index b185295d551..280f613af3a 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -17,7 +17,7 @@
 #include "system/address-spaces.h"
 #include "system/system.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #include "hw/misc/unimp.h"
 #include "migration/vmstate.h"
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index 956860ab298..ab57dfd83ea 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "system/memory.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/block/fdc.h"
 #include "migration/vmstate.h"
 #include "fdc-internal.h"
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index d1673a1b411..c0f5b9d8fad 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -48,7 +48,7 @@
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "system/blockdev.h"
 #include "system/runstate.h"
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 423516cb301..6f952fe7de0 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -44,7 +44,7 @@
 #include "system/block-backend.h"
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/block/swim.c b/hw/block/swim.c
index 53ba7fa59cf..54b63bfbb52 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -14,7 +14,7 @@
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "system/block-backend.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
 #include "hw/block/swim.h"
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index c24ece5fe88..eff6a3c4d17 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -22,7 +22,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 1a83e4a9bd1..bf891081dcc 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -20,7 +20,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/registerfields.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 8a704dfcf50..bd669173f01 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -27,7 +27,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
diff --git a/hw/char/escc.c b/hw/char/escc.c
index a2fb682f8be..3b46818ecc9 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -26,7 +26,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/char/escc.h"
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index d1c2f249150..46fc4e31b83 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index 35bcb2a9676..8e1e9228c78 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties-system.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 7be847d0932..92f534552ee 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -29,7 +29,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/char/grlib_uart.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
 
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 51edf917c94..24fd42da063 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/m68k/mcf.h"
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 0b0af677988..ac453c1057f 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "hw/char/pl011.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index b3bed2bb7bf..10f96e3a44b 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -26,7 +26,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index ba7e9e339b6..3ef99adadda 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -29,7 +29,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index a3b41286ea0..fc3425a8fe1 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -35,7 +35,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-clock.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index ae447c1196a..3adf2f2faf2 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "monitor/monitor.h"
 #include "system/address-spaces.h"
 
diff --git a/hw/display/artist.c b/hw/display/artist.c
index 22524d9c5fe..206f77afba1 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -14,7 +14,7 @@
 #include "qemu/units.h"
 #include "qemu/bswap.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index f4067d7825a..59d66d3d4b8 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "ui/console.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/core/loader.h"
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 8e3a61ed0e8..7f841b88047 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -26,7 +26,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/hw.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 8ed3e6ecc37..2eefafcaf67 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -28,7 +28,7 @@
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index 90e82b58be2..9d62e51bed9 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -27,7 +27,7 @@
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index fa3572ead34..388f8de5070 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "hw/nubus/nubus.h"
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 2537c264625..4cd62a98757 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 6ccec03fe72..a07aa9886f9 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -32,7 +32,7 @@
 #include "hw/usb/hcd-ohci.h"
 #include "hw/char/serial-mm.h"
 #include "ui/console.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index b208923523a..7cba3e25a78 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -29,7 +29,7 @@
 #include "ui/pixel_ops.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/display/vga-mmio.c b/hw/display/vga-mmio.c
index 4c497b70f41..1a9608d865f 100644
--- a/hw/display/vga-mmio.c
+++ b/hw/display/vga-mmio.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/display/vga.h"
 #include "hw/core/qdev-properties.h"
 #include "ui/console.h"
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index bd61d8ed488..514206b7c31 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 4f00092f856..5a8df39d8f5 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -18,7 +18,7 @@
 #include "qemu/cutils.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 8ce74257b62..93db286e690 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "hw/core/irq.h"
 #include "hw/mips/mips.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index 2fbc37ffd14..2844515b2d7 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
 #include "hw/dma/sifive_pdma.h"
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 5601d221ec2..5b770599865 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -30,7 +30,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/sparc/sun4m_iommu.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
 #include "qapi/error.h"
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 90ba7bf0573..8488f125b5f 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/hw.h"
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index b390d092699..436f9915e02 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -23,7 +23,7 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
 #include "hw/core/ptimer.h"
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index bd9170b8932..d7c44ea2abe 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -16,7 +16,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/sd/sd.h"
 #include "hw/gpio/bcm2835_gpio.h"
diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index dab50faf285..4ae7706b9a0 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/sd/sd.h"
 #include "hw/gpio/bcm2838_gpio.h"
diff --git a/hw/gpio/gpio_key.c b/hw/gpio/gpio_key.c
index f8cf4da239a..14e0fb9d4cb 100644
--- a/hw/gpio/gpio_key.c
+++ b/hw/gpio/gpio_key.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/gpio/gpio_pwr.c b/hw/gpio/gpio_pwr.c
index 2d14f8b344c..a60b24a5535 100644
--- a/hw/gpio/gpio_pwr.c
+++ b/hw/gpio/gpio_pwr.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/runstate.h"
 
 #define TYPE_GPIOPWR "gpio-pwr"
diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index 377832e9d24..2e882329f0f 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 0c2a0f9aa6c..f7619260ca7 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -23,7 +23,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/omap.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 55f51b6cf20..d6a4fb90b96 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -31,7 +31,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 0a9f76e7743..3cf626a550d 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -18,7 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 86b53a23ade..c01f3392360 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -18,7 +18,7 @@
 #include "hw/hyperv/hyperv.h"
 #include "hw/hyperv/vmbus.h"
 #include "hw/hyperv/vmbus-bridge.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "exec/target_page.h"
 #include "trace.h"
 
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 1f9ce131bf7..faf2160c067 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index d379cfd7751..1f5d66ce33d 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/i2c/bitbang_i2c.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "trace.h"
diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
index dd72dda4fd0..9fac588e82e 100644
--- a/hw/i2c/exynos4210_i2c.c
+++ b/hw/i2c/exynos4210_i2c.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/i2c/i2c.h"
 #include "hw/core/irq.h"
diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index 7802c68452f..c6034460284 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -21,7 +21,7 @@
 #include "hw/i2c/smbus_slave.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/queue.h"
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index e2097f819ce..abb2240f9f3 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 #include "trace.h"
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index c768f99e384..e0798f2c8a5 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -24,7 +24,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/omap.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f744be9f70f..224b7b94790 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -23,7 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "intel_iommu_internal.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 310b9a8eb5a..8ca88afae24 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -21,7 +21,7 @@
 #include "system/hw_accel.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/i386/kvm/clock.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index a510ab871de..b65871f3542 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -27,7 +27,7 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/xen/xen.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index 4b9e272c5eb..85b324e62d0 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -20,7 +20,7 @@
 #include "system/address-spaces.h"
 #include "migration/vmstate.h"
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/xen_backend_ops.h"
 #include "xen_overlay.h"
diff --git a/hw/i386/kvm/xen_overlay.c b/hw/i386/kvm/xen_overlay.c
index 3cb73619371..74cadffb728 100644
--- a/hw/i386/kvm/xen_overlay.c
+++ b/hw/i386/kvm/xen_overlay.c
@@ -19,7 +19,7 @@
 #include "system/address-spaces.h"
 #include "migration/vmstate.h"
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/xen/xen.h"
 #include "xen_overlay.h"
 
diff --git a/hw/i386/kvm/xen_primary_console.c b/hw/i386/kvm/xen_primary_console.c
index 6e9d6417c3e..bf61f6235be 100644
--- a/hw/i386/kvm/xen_primary_console.c
+++ b/hw/i386/kvm/xen_primary_console.c
@@ -13,7 +13,7 @@
 
 #include "qapi/error.h"
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/xen_backend_ops.h"
 #include "xen_evtchn.h"
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 42955cccd90..0dc0edf3bfd 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -20,7 +20,7 @@
 #include "qom/object.h"
 #include "migration/vmstate.h"
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/xen_backend_ops.h"
 #include "xen_overlay.h"
diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index 81eaddafc8b..45fbb5bbd15 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -37,7 +37,7 @@
 #include "hw/char/serial-isa.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/virtio/virtio-mmio.h"
 #include "hw/usb/xhci.h"
 
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index 5ee50f3b858..640b1d8c548 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -14,7 +14,7 @@
 #include "qom/object_interfaces.h"
 
 #include "chardev/char.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/eif.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/microvm.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3f8fd078318..2e2671d6050 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -41,7 +41,7 @@
 #include "hw/core/irq.h"
 #include "system/kvm.h"
 #include "hw/i386/kvm/clock.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "system/memory.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 906df5e7886..d8a86756ca4 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -29,7 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/core/loader.h"
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 3a4254638b2..32f92a28b88 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -19,7 +19,7 @@
 #include "system/runstate.h"
 #include "system/address-spaces.h"
 #include "hw/i386/apic_internal.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/boards.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 21e0d40e114..33ac0bfc97e 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/i386/x86-iommu.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/i386/pc.h"
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 04b56ac5d86..0de904ac56a 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "system/dma.h"
diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
index e34e9cb5c02..c03a127f3df 100644
--- a/hw/input/lasips2.c
+++ b/hw/input/lasips2.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/input/ps2.h"
 #include "hw/input/lasips2.h"
 #include "exec/hwaddr.h"
diff --git a/hw/input/pl050.c b/hw/input/pl050.c
index cb8efc74f77..48df2734e26 100644
--- a/hw/input/pl050.c
+++ b/hw/input/pl050.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/input/ps2.h"
 #include "hw/input/pl050.h"
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 96850124a7b..10ac7324030 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/input/ps2.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 0e1ec521e42..8e17a77c801 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/intc/allwinner-a10-pic.h"
 #include "hw/core/irq.h"
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index afac20440f8..4e9e3089945 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -30,7 +30,7 @@
 #include "hw/core/boards.h"
 #include "system/kvm.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 
 bool apic_report_tpr_access;
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index e27bb20bf8c..4d0cb125a61 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "gic_internal.h"
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index c39d31b1870..b343e17ca53 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/pci/msi.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 5fa210c6335..3a31eb56f36 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "hw/intc/armv7m_nvic.h"
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index 8bea69d91b7..ec935a084db 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -28,7 +28,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/intc/exynos4210_combiner.h"
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index a65c9c6d28b..d15e41174a9 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -21,7 +21,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/intc/goldfish_pic.c b/hw/intc/goldfish_pic.c
index 96e7d5c225f..16f351a30d3 100644
--- a/hw/intc/goldfish_pic.c
+++ b/hw/intc/goldfish_pic.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "trace.h"
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index ce7cbc98c17..d860ec15d88 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -28,7 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #include "hw/core/qdev-properties.h"
 #include "hw/intc/grlib_irqmp.h"
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index fce3486e519..d3bcd5699f5 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -26,7 +26,7 @@
 #include "hw/intc/intc.h"
 #include "hw/intc/ioapic.h"
 #include "hw/intc/ioapic_internal.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /* ioapic_no count start from 0 to MAX_IOAPICS,
  * remove as static variable from ioapic_common_init.
diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index 574e4a0d277..c42a919df4a 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/intc/loongarch_pch_msi.h"
 #include "hw/intc/loongarch_pch_pic.h"
diff --git a/hw/intc/loongarch_pch_msi.c b/hw/intc/loongarch_pch_msi.c
index 63090b27261..3656c6cea97 100644
--- a/hw/intc/loongarch_pch_msi.c
+++ b/hw/intc/loongarch_pch_msi.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/intc/loongarch_pch_msi.h"
 #include "hw/intc/loongarch_pch_pic.h"
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index b3d8e781ca1..d9d8a374d36 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/intc/loongson_ipi_common.h"
 #include "hw/core/irq.h"
 #include "qemu/log.h"
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index e983f3a2b58..ad9363a4c7d 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -13,7 +13,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "system/kvm.h"
 #include "system/reset.h"
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index deb21f9dc19..b2438d2d5f8 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -22,7 +22,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/omap.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 05f0ef82549..58736cd8a0c 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -11,7 +11,7 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "system/memory.h"
 #include "qom/object.h"
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 4cc5068ffc8..cd353a04f53 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -36,7 +36,7 @@
 #include "hw/ppc/openpic.h"
 #include "hw/ppc/ppc_e500.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/pci/msi.h"
 #include "qapi/error.h"
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 6558135baa1..9aafef5d9eb 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -29,7 +29,7 @@
 #include "hw/ppc/openpic_kvm.h"
 #include "hw/pci/msi.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/kvm.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index f1e4959e9ae..d53292d15e8 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 83968ad7cca..9c1491bd043 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -26,7 +26,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "target/riscv/time_helper.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index cc5f30b5588..92ff0ecaa74 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -23,7 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/bswap.h"
 #include "system/address-spaces.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/msi.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index bc580c000ef..7c9a0120335 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -23,7 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/bswap.h"
 #include "system/address-spaces.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/msi.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 508b58382ed..57fd4b2b81c 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -14,7 +14,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 5df578822f9..9c84ff06a9f 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -23,7 +23,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/msi.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/intc/sifive_plic.h"
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index b12c8cbd69f..640d8e2baa6 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/intc/intc.h"
 #include "hw/core/irq.h"
 #include "trace.h"
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index f93f0d6e7ea..782a286e43c 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/module.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index b8bafe2f3f3..0d9e85473d3 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/register.h"
 #include "qemu/bitops.h"
diff --git a/hw/intc/xlnx-zynqmp-ipi.c b/hw/intc/xlnx-zynqmp-ipi.c
index e69ea74ff74..3538a0e5db9 100644
--- a/hw/intc/xlnx-zynqmp-ipi.c
+++ b/hw/intc/xlnx-zynqmp-ipi.c
@@ -26,7 +26,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/register.h"
 #include "qemu/bitops.h"
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 6c9802eb7ac..7e6d2ce5a94 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/system.h"
 #include "hw/isa/isa.h"
 
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 4bc7b1d189e..c5befa02eb5 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -17,7 +17,7 @@
 #include "qemu/timer.h"
 #include "hw/core/ptimer.h"
 #include "system/system.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 /* General purpose timer module.  */
 typedef struct {
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 3a87e1f282c..c6d1c5fae9f 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -31,7 +31,7 @@
 #include "net/net.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "elf.h"
 
 #define SYS_FREQ 166666666
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index b8770e3a53f..20112c94be1 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -12,7 +12,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/m68k/mcf.h"
 #include "hw/core/qdev-properties.h"
 #include "qom/object.h"
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 75ae66c311a..ca3df7b887b 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -20,7 +20,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
 #include "hw/scsi/esp.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 #include "hw/char/escc.h" /* ZILOG 8530 Serial Emulation */
 #include "hw/block/fdc.h"
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 2bec945acfb..571a9555040 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -29,7 +29,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/m68k/next-cube.h"
 #include "ui/console.h"
 #include "migration/vmstate.h"
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 6fe030e8c5d..25ddddb5d9f 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -33,7 +33,7 @@
 #include "hw/core/loader.h"
 #include "ui/console.h"
 #include "hw/char/escc.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/scsi/esp.h"
 #include "standard-headers/asm-m68k/bootinfo.h"
 #include "standard-headers/asm-m68k/bootinfo-mac.h"
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 2d83919fa86..7be3a248000 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -18,7 +18,7 @@
 #include "elf.h"
 #include "hw/core/loader.h"
 #include "ui/console.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "standard-headers/asm-m68k/bootinfo.h"
 #include "standard-headers/asm-m68k/bootinfo-virt.h"
 #include "bootinfo.h"
diff --git a/hw/mem/sparse-mem.c b/hw/mem/sparse-mem.c
index 9186da6b1a9..3b754de887e 100644
--- a/hw/mem/sparse-mem.c
+++ b/hw/mem/sparse-mem.c
@@ -14,7 +14,7 @@
 #include "qemu/error-report.h"
 
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/units.h"
 #include "system/qtest.h"
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 51ee237d584..b3bdc4d65f2 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -29,7 +29,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
 #include "system/system.h"
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 266ecf9e8ab..2a853a7fa5f 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -27,7 +27,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
 #include "system/system.h"
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index fb01af8ece3..e0adb96c548 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -43,7 +43,7 @@
 #include "hw/display/bochs-vbe.h"
 #include "hw/audio/pcspk.h"
 #include "hw/input/i8042.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "qapi/error.h"
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index e5ed0b56923..812ff64d831 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -47,7 +47,7 @@
 #include "hw/core/loader.h"
 #include "elf.h"
 #include "qom/object.h"
-#include "hw/sysbus.h"             /* SysBusDevice */
+#include "hw/core/sysbus.h"             /* SysBusDevice */
 #include "qemu/host-utils.h"
 #include "system/qtest.h"
 #include "system/reset.h"
diff --git a/hw/misc/allwinner-a10-ccm.c b/hw/misc/allwinner-a10-ccm.c
index 6b188c25a5d..dc7f8ff205a 100644
--- a/hw/misc/allwinner-a10-ccm.c
+++ b/hw/misc/allwinner-a10-ccm.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/allwinner-a10-dramc.c b/hw/misc/allwinner-a10-dramc.c
index c16814cc5b8..757f2cad957 100644
--- a/hw/misc/allwinner-a10-dramc.c
+++ b/hw/misc/allwinner-a10-dramc.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/allwinner-cpucfg.c b/hw/misc/allwinner-cpucfg.c
index 90dd872abf0..3a1526bda0d 100644
--- a/hw/misc/allwinner-cpucfg.c
+++ b/hw/misc/allwinner-cpucfg.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c
index be91c0c1cae..ac5ae01acc0 100644
--- a/hw/misc/allwinner-h3-ccu.c
+++ b/hw/misc/allwinner-h3-ccu.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
index ef491b36ffb..10d929a3039 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/allwinner-h3-sysctrl.c b/hw/misc/allwinner-h3-sysctrl.c
index 6b86524606a..d37c0a6e260 100644
--- a/hw/misc/allwinner-h3-sysctrl.c
+++ b/hw/misc/allwinner-h3-sysctrl.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/allwinner-r40-ccu.c b/hw/misc/allwinner-r40-ccu.c
index 4e21eeafdd0..8ba4e7aa429 100644
--- a/hw/misc/allwinner-r40-ccu.c
+++ b/hw/misc/allwinner-r40-ccu.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index 3af8af733ac..8e6aa7c3106 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
index 92a0c7918bc..b5f827d4bdf 100644
--- a/hw/misc/allwinner-sid.c
+++ b/hw/misc/allwinner-sid.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
index 423e0a844fa..1d30f8cf326 100644
--- a/hw/misc/allwinner-sramc.c
+++ b/hw/misc/allwinner-sramc.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/arm_integrator_debug.c b/hw/misc/arm_integrator_debug.c
index 9a197278290..9ac6a50a930 100644
--- a/hw/misc/arm_integrator_debug.c
+++ b/hw/misc/arm_integrator_debug.c
@@ -15,7 +15,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/arm_integrator_debug.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index a5511845c7c..039f1b0f2ce 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 0c91ebafac7..2a317ac7f5b 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -13,7 +13,7 @@
 #include "qemu/timer.h"
 #include "system/runstate.h"
 #include "qemu/bitops.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/primecell.h"
 #include "qemu/log.h"
diff --git a/hw/misc/armsse-cpu-pwrctrl.c b/hw/misc/armsse-cpu-pwrctrl.c
index 87770facfce..86a26a8ac5a 100644
--- a/hw/misc/armsse-cpu-pwrctrl.c
+++ b/hw/misc/armsse-cpu-pwrctrl.c
@@ -21,7 +21,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/registerfields.h"
 #include "hw/misc/armsse-cpu-pwrctrl.h"
 
diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
index 03833125514..ea2a099ccb1 100644
--- a/hw/misc/armsse-cpuid.c
+++ b/hw/misc/armsse-cpuid.c
@@ -23,7 +23,7 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/registerfields.h"
 #include "hw/misc/armsse-cpuid.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
index 6fbe2cca37e..48c4b59067a 100644
--- a/hw/misc/armsse-mhu.c
+++ b/hw/misc/armsse-mhu.c
@@ -20,7 +20,7 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/irq.h"
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index f93cbd16590..dd1be7d698e 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index a012668214f..aab9373c097 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/misc/empty_slot.h"
 #include "qapi/error.h"
diff --git a/hw/misc/exynos4210_clk.c b/hw/misc/exynos4210_clk.c
index fdf5bdd6034..e7526792191 100644
--- a/hw/misc/exynos4210_clk.c
+++ b/hw/misc/exynos4210_clk.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index a86ec9aba85..0be793b3aa7 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "system/runstate.h"
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 2d0ebc457bc..3f743b47502 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index cdca00ad542..0d12bcde9d8 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -23,7 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/grlib_ahb_apb_pnp.h"
 #include "trace.h"
 
diff --git a/hw/misc/iosb.c b/hw/misc/iosb.c
index 96221e1ee5a..ea63e34b937 100644
--- a/hw/misc/iosb.c
+++ b/hw/misc/iosb.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/iosb.h"
 #include "trace.h"
 
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 832b0217774..54bfe1ba597 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/irq.h"
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index d673ae326bc..dff89c677f7 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -23,7 +23,7 @@
 #include "system/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/registerfields.h"
 #include "hw/misc/iotkit-sysctl.h"
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 3b4d228e3ef..19f089e6ee9 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -22,7 +22,7 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/registerfields.h"
 #include "hw/misc/iotkit-sysinfo.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index 1248f9e81bc..920aa4943a7 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties-system.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char-fe.h"
 #include "system/address-spaces.h"
 #include "trace.h"
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 0c608c3dc63..26ee230dcc4 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "system/address-spaces.h"
 #include "migration/vmstate.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "qemu/timer.h"
 #include "hw/misc/mac_via.h"
diff --git a/hw/misc/mchp_pfsoc_dmc.c b/hw/misc/mchp_pfsoc_dmc.c
index 599f845f459..1fe4535464f 100644
--- a/hw/misc/mchp_pfsoc_dmc.c
+++ b/hw/misc/mchp_pfsoc_dmc.c
@@ -24,7 +24,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/mchp_pfsoc_dmc.h"
 
 /* DDR SGMII PHY module */
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index 84e957244e5..05538d012a9 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -25,7 +25,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/mchp_pfsoc_ioscb.h"
 
 /*
diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
index 2a415151037..f190ecc78e0 100644
--- a/hw/misc/mchp_pfsoc_sysreg.c
+++ b/hw/misc/mchp_pfsoc_sysreg.c
@@ -25,7 +25,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "system/runstate.h"
 
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 1c6e9d1f6f0..3e262e828bc 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/misc/mips_cmgcr.h"
 #include "hw/misc/mips_cpc.h"
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index efc0326f6f2..924de855ee2 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 
 #include "hw/misc/mips_cpc.h"
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 9cd5e9884c0..da78cb60701 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -20,7 +20,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/registerfields.h"
 #include "hw/misc/mps2-fpgaio.h"
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 06d436cf58e..350bba3dab8 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -22,7 +22,7 @@
 #include "qemu/module.h"
 #include "qemu/bitops.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/core/registerfields.h"
diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
index 2d1464435a8..a173a1a9a58 100644
--- a/hw/misc/pvpanic-mmio.c
+++ b/hw/misc/pvpanic-mmio.c
@@ -10,7 +10,7 @@
 
 #include "hw/core/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "standard-headers/misc/pvpanic.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(PVPanicMMIOState, PVPANIC_MMIO_DEVICE)
diff --git a/hw/misc/sbsa_ec.c b/hw/misc/sbsa_ec.c
index dfee1af5ad2..93296d3350c 100644
--- a/hw/misc/sbsa_ec.c
+++ b/hw/misc/sbsa_ec.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/runstate.h"
 
 typedef struct SECUREECState {
diff --git a/hw/misc/sifive_e_prci.c b/hw/misc/sifive_e_prci.c
index a8702c6a5d4..400664aabae 100644
--- a/hw/misc/sifive_e_prci.c
+++ b/hw/misc/sifive_e_prci.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/sifive_test.c b/hw/misc/sifive_test.c
index b94bb2d29db..41f102e2dca 100644
--- a/hw/misc/sifive_test.c
+++ b/hw/misc/sifive_test.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index 899bc31745c..7205374bc39 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/sifive_u_prci.c b/hw/misc/sifive_u_prci.c
index 6e75cb6d0d5..f51588623ab 100644
--- a/hw/misc/sifive_u_prci.c
+++ b/hw/misc/sifive_u_prci.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/misc/sifive_u_prci.h"
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index 43ce5d0bc97..49be827c458 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "system/runstate.h"
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index 65517d390d3..02fe0bcb1d5 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/irq.h"
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index dd845193d64..9d9fc072ff0 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/irq.h"
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 7b812a034b2..159073d1e6d 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/irq.h"
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index 4370c14ef16..521b84bf20b 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/unimp.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/virt_ctrl.c b/hw/misc/virt_ctrl.c
index 7cb1ea5d181..40747925a29 100644
--- a/hw/misc/virt_ctrl.c
+++ b/hw/misc/virt_ctrl.c
@@ -6,7 +6,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "trace.h"
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index efacbe83abb..47d3b9e84ad 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "hw/core/registerfields.h"
 #include "qemu/bitops.h"
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index bdce0ce7475..86df37d6e8a 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "hw/core/irq.h"
 #include "qemu/bitops.h"
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 9bbf44def6b..1379974f81e 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/register.h"
 #include "hw/core/resettable.h"
diff --git a/hw/misc/xlnx-versal-pmc-iou-slcr.c b/hw/misc/xlnx-versal-pmc-iou-slcr.c
index 0246167a5e6..57a24641cfa 100644
--- a/hw/misc/xlnx-versal-pmc-iou-slcr.c
+++ b/hw/misc/xlnx-versal-pmc-iou-slcr.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "hw/core/irq.h"
 #include "qemu/bitops.h"
diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
index f4f02c7680b..da8c98ae032 100644
--- a/hw/misc/xlnx-versal-xramc.c
+++ b/hw/misc/xlnx-versal-xramc.c
@@ -10,7 +10,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/irq.h"
diff --git a/hw/misc/xlnx-zynqmp-apu-ctrl.c b/hw/misc/xlnx-zynqmp-apu-ctrl.c
index 957043f01b9..c46951d552e 100644
--- a/hw/misc/xlnx-zynqmp-apu-ctrl.c
+++ b/hw/misc/xlnx-zynqmp-apu-ctrl.c
@@ -13,7 +13,7 @@
 #include "qemu/log.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/register.h"
 
diff --git a/hw/misc/xlnx-zynqmp-crf.c b/hw/misc/xlnx-zynqmp-crf.c
index a2ebf6ce5d7..1f7107c322c 100644
--- a/hw/misc/xlnx-zynqmp-crf.c
+++ b/hw/misc/xlnx-zynqmp-crf.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index d7d490b093d..faae98fa023 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "system/runstate.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 8ff0db5ccdc..9b7c67ae8e4 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "hw/core/irq.h"
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index cbe4cb80e4a..55d1b6a9a6b 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "qemu/fifo8.h"
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 3ceb1a8b912..4a7cdc31ee4 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -31,7 +31,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/register.h"
 #include "qapi/error.h"
diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index 6c583cab8f5..bccf6240169 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -30,7 +30,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "hw/core/irq.h"
 #include "qapi/error.h"
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 182f0e5f6b1..5b611fcbbe7 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -21,7 +21,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/net/dp8393x.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "qapi/error.h"
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 5b77528e365..1d61d918b8d 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -27,7 +27,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/net/mii.h"
 #include "hw/core/ptimer.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 381fd387641..072a741d811 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/eth.h"
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 50e3c4fa86d..423a8676a08 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/system.h"
 #include "net/eth.h"
 #include "hw/net/lasi_82596.h"
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index ecf105adf2e..5f267e5ea38 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -15,7 +15,7 @@
 #include "hw/m68k/mcf_fec.h"
 #include "hw/net/mii.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include <zlib.h> /* for crc32 */
 
 //#define DEBUG_FEC 1
diff --git a/hw/net/mv88w8618_eth.c b/hw/net/mv88w8618_eth.c
index 1a1bba8b572..1fcfbe912ee 100644
--- a/hw/net/mv88w8618_eth.c
+++ b/hw/net/mv88w8618_eth.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/net/mv88w8618_eth.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 34992f3cc9f..ec3301414cc 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -35,7 +35,7 @@
 #include "hw/core/irq.h"
 #include "hw/net/mii.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "qemu/module.h"
 #include "net/eth.h"
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index d6f57bc004a..3420d8e28e1 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "hw/core/irq.h"
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index c97d6945852..ac7924bdd9e 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "qemu/log.h"
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index f07be725120..8d316e94c17 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "net/net.h"
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 451f8da2122..29c09b88ebf 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 72b14811a9d..ba3acd4c77c 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -31,7 +31,7 @@
 #include "qemu/bitops.h"
 #include "qom/object.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
diff --git a/hw/nubus/mac-nubus-bridge.c b/hw/nubus/mac-nubus-bridge.c
index 0dac8d19b37..dc9ae6d21fa 100644
--- a/hw/nubus/mac-nubus-bridge.c
+++ b/hw/nubus/mac-nubus-bridge.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/nubus/mac-nubus-bridge.h"
 
 
diff --git a/hw/nubus/nubus-bridge.c b/hw/nubus/nubus-bridge.c
index fb14402c4fc..f0e1620ee09 100644
--- a/hw/nubus/nubus-bridge.c
+++ b/hw/nubus/nubus-bridge.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/nubus/nubus.h"
 
 
diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 512e5485187..4f35bfebdab 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/error-report.h"
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index e5c35b0e2e4..437ab6e210f 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -31,7 +31,7 @@
 #include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index bafb877cc38..603d8ca0d99 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -31,7 +31,7 @@
 #include "system/address-spaces.h"
 #include "system/device_tree.h"
 #include "system/system.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "hw/core/split-irq.h"
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 446a81579c1..54ce96666e5 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -22,7 +22,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/rtc/goldfish_rtc.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/virtio/virtio-mmio.h"
 #include "system/device_tree.h"
 #include "system/system.h"
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 616d5d934cc..197d3148d20 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -25,7 +25,7 @@
 #include "hw/pci/msi.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "hw/cxl/cxl.h"
 
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 15354abf3ba..e7d638b296c 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -30,7 +30,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/pci-host/i440fx.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "qapi/visitor.h"
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 636228c4074..ef1c77563e8 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
 #include "hw/core/irq.h"
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 87af933dc29..b3f57dca7d7 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 87a71c889e4..3ffd2cdbd70 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/sh4/sh.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 1fdae78210a..b27531f7fbb 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 7f164331c8e..113a2daca1d 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -41,7 +41,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/loader.h"
 #include "elf.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/host-utils.h"
 #include "qemu/option.h"
 #include "hw/pci-host/ppce500.h"
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 4f1d659e723..ca5647284d0 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -15,7 +15,7 @@
 #include "hw/net/fsl_etsec/etsec.h"
 #include "system/device_tree.h"
 #include "system/kvm.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/ppc/openpic.h"
 #include "kvm_ppc.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 410a3ac392e..7275563a155 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -73,7 +73,7 @@
 #include "system/reset.h"
 #include "kvm_ppc.h"
 #include "hw/usb/usb.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "trace.h"
 
 #define MAX_IDE_BUS 2
diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index a25041e8367..88ae573d1e8 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -21,7 +21,7 @@
 #include "qemu/log.h"
 #include "system/runstate.h"
 #include "cpu.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qom/object.h"
 
 #define MPC8544_GUTS_MMIO_SIZE        0x1000
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index bf290a7dcd5..3e4d19fbe84 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -11,7 +11,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/ppc/ppc.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/core/irq.h"
 #include "hw/core/or-irq.h"
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index fbfec829d5b..8557b560aeb 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -22,7 +22,7 @@
 #include "qemu/module.h"
 #include "system/hw_accel.h"
 #include "target/ppc/cpu.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/pnv.h"
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 491560575c0..2dde008b0e4 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -28,7 +28,7 @@
 #include "hw/pci-host/ppc4xx.h"
 #include "system/system.h"
 #include "system/reset.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/intc/ppc-uic.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index bc70e50e926..a066ada77ed 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -31,7 +31,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/hw.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/hw_accel.h"
 #include "hw/ppc/ppc.h"
 #include "e500.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index b6e233747ed..b13dd224ba1 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -30,7 +30,7 @@
 #include "hw/block/flash.h"
 #include "system/system.h"
 #include "system/reset.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/char/serial-mm.h"
 #include "hw/i2c/ppc4xx_i2c.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index a7c064be330..ea998bdff15 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 875c17f4784..501e82a7665 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -26,7 +26,7 @@
 #include "qemu/log.h"
 #include "hw/core/loader.h"
 #include "elf.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/kvm.h"
 #include "system/device_tree.h"
 #include "kvm_ppc.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index cf2d10ecb27..8b3e67b627c 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -27,7 +27,7 @@
 #include "qemu/units.h"
 #include "exec/page-protection.h"
 #include "cpu.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/char/serial-mm.h"
 #include "hw/block/flash.h"
 #include "system/system.h"
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 8a461a0dd56..d56b64792d7 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -17,7 +17,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "system/system.h"
 #include "net/net.h"
 #include "hw/core/boards.h"
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 9de6456c141..0cf849ffb6d 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -42,7 +42,7 @@
 #include "qapi/visitor.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "chardev/char.h"
 #include "hw/cpu/cluster.h"
 #include "target/riscv/cpu.h"
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 2a11c4dab6d..bf87b0b4ea3 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -20,7 +20,7 @@
 #include "hw/core/irq.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/host-utils.h"
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 31187487946..e675358e1a1 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -24,7 +24,7 @@
 #include "system/reset.h"
 #include "system/qtest.h"
 #include "qemu/cutils.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index c2032176c43..4cb9c07ffbf 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -34,7 +34,7 @@
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/unimp.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3e081ddf37e..f1b47ab5848 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -42,7 +42,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
 #include "hw/core/loader.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/misc/unimp.h"
 #include "hw/sd/sd.h"
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index c9451d7e3b3..ea527c7bfc1 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/spike.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d79add55768..c87c169d38c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/char/serial-mm.h"
 #include "target/riscv/cpu.h"
diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c
index 0ffd38cf787..52006a0e3a3 100644
--- a/hw/rtc/allwinner-rtc.c
+++ b/hw/rtc/allwinner-rtc.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/rtc/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
index a15b5274bd3..846839d2d8b 100644
--- a/hw/rtc/exynos4210_rtc.c
+++ b/hw/rtc/exynos4210_rtc.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/bcd.h"
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 79d2a04c721..5354a6b02f3 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -24,7 +24,7 @@
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
 #include "system/system.h"
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index b0c6588e098..158c8155055 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/register.h"
 #include "qemu/timer.h"
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index be8efb8c0ad..be4196b21c4 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -31,7 +31,7 @@
 #include "system/runstate.h"
 #include "system/rtc.h"
 #include "system/system.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/bcd.h"
 #include "qemu/module.h"
diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index 847349b407a..b56877c3a20 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -16,7 +16,7 @@
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "system/system.h"
 #include "system/rtc.h"
diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
index 29e24ef6bed..675b6cd5bd6 100644
--- a/hw/rtc/sun4v-rtc.c
+++ b/hw/rtc/sun4v-rtc.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/rtc/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
index 49d48dc6782..28ae7a24f9d 100644
--- a/hw/rtc/xlnx-zynqmp-rtc.c
+++ b/hw/rtc/xlnx-zynqmp-rtc.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index e1fa3d56618..3d137a517b8 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "hw/rx/rx62n.h"
 #include "hw/core/loader.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-properties.h"
 #include "system/system.h"
 #include "qobject/qlist.h"
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index edeb3dbef34..5cdbf098074 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "hw/s390x/ap-bridge.h"
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 887794beef7..440fefb7d0f 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "hw/core/hotplug.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "hw/s390x/css.h"
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9da6119be26..933271431ba 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/scsi/esp.h"
diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index 7e0076c7a3b..4fde2265b5b 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "hw/scsi/lasi_ncr710.h"
 #include "hw/scsi/ncr53c710.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "trace.h"
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 9931fd4dc7d..0f8914d353d 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -29,7 +29,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/scsi/scsi.h"
 #include "hw/scsi/ncr53c710.h"
 #include "migration/vmstate.h"
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 267b723e3c5..020429aa4f4 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -23,7 +23,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/arm/omap.h"
 #include "hw/sd/sd.h"
 
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 761b262d7ba..08c34fea31d 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "system/blockdev.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/sd/sd.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 35db5cbbcd1..acb3fe75a8b 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/sh4/sh.h"
 #include "system/reset.h"
 #include "system/runstate.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index a0aa89ad318..3ae71f99fe5 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/sh4/sh.h"
 #include "system/system.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 2e3952c917b..8ad4eb46bbe 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -28,7 +28,7 @@
 #include "qemu/datadir.h"
 #include "cpu.h"
 #include "exec/target_page.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "hw/sparc/sun4m_iommu.h"
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 10c4786dad6..ab5eb67072a 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -26,7 +26,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/sparc/sun4m_iommu.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "system/address-spaces.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 14b47c037ba..d3ce32b6b09 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -51,7 +51,7 @@
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/sparc/sparc64.h"
 #include "hw/nvram/fw_cfg.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/ide/pci.h"
 #include "hw/core/loader.h"
 #include "hw/core/fw-path-provider.h"
diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
index 14645f475a0..0188ce35d29 100644
--- a/hw/sparc64/sun4u_iommu.c
+++ b/hw/sparc64/sun4u_iommu.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/sparc/sun4u_iommu.h"
 #include "system/address-spaces.h"
 #include "qemu/log.h"
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 6bef856c620..b9d5ecba292 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/block/flash.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index 1851118d55f..715a2d21f4e 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/ssi/pl022.h"
diff --git a/hw/ssi/sifive_spi.c b/hw/ssi/sifive_spi.c
index 577cd5d2d8b..2ece78053b2 100644
--- a/hw/ssi/sifive_spi.c
+++ b/hw/ssi/sifive_spi.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/fifo8.h"
 #include "qemu/log.h"
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index cf406d08246..79f3e8bfae3 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/fifo8.h"
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a56a5e304dc..a4718fb72d9 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index 93cdc9d3999..467f0ce7033 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -23,7 +23,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/bitops.h"
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index d52669787ee..bb995313ae0 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index c38e56f5b89..fb70333c538 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "hw/core/irq.h"
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index baba0817b8f..65cfaf49142 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -13,7 +13,7 @@
 #include "hw/timer/armv7m_systick.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-clock.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 20adb7decbe..1e954f7aec5 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/timer/aspeed_timer.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 6f02c6a02d9..3d53921cfaf 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -18,7 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index 39b1fa3a149..0f57f01aad9 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -21,7 +21,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/registerfields.h"
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index e8b6601097c..4717cec0464 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -32,7 +32,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/qdev-clock.h"
diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index 12b79914df0..352132bf214 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -27,7 +27,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/ptimer.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index f6527a451b6..0424539c78f 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -54,7 +54,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/module.h"
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index 1643fa39418..64eb4f5c8d7 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/module.h"
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index dbce6f736fa..099ab6c5866 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/timer/grlib_gptimer.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 82006df0e34..070b40e7f67 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -31,7 +31,7 @@
 #include "qemu/timer.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/timer/hpet.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/rtc/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index b875c050525..b4f501e57fe 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -12,7 +12,7 @@
 #include "hw/core/qdev-properties.h"
 #include "qemu/timer.h"
 #include "system/runstate.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 07359a6fe70..71696a4b615 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -27,7 +27,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/module.h"
diff --git a/hw/timer/sse-counter.c b/hw/timer/sse-counter.c
index 39d140347e5..bec3333b0d8 100644
--- a/hw/timer/sse-counter.c
+++ b/hw/timer/sse-counter.c
@@ -32,7 +32,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/timer/sse-counter.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/clock.h"
 #include "hw/core/qdev-clock.h"
diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index 62381e07e06..ea607118922 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -40,7 +40,7 @@
 #include "trace.h"
 #include "hw/timer/sse-timer.h"
 #include "hw/timer/sse-counter.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/clock.h"
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 9c2969a2c4f..8a502dae0ee 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index 5ce84dc7a45..9f13e0ec120 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/acpi/tpm.h"
 #include "migration/vmstate.h"
 #include "tpm_prop.h"
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 07c30401301..e9372e73163 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -27,7 +27,7 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/tpm.h"
 #include "tpm_prop.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "tpm_tis.h"
 #include "qom/object.h"
 
diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c
index e1a97a43874..5b1b07cee1c 100644
--- a/hw/tricore/tc27x_soc.c
+++ b/hw/tricore/tc27x_soc.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/loader.h"
 #include "qemu/units.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/tricore/tricore_testdevice.c b/hw/tricore/tricore_testdevice.c
index d3ffc5fe9f3..2eb16731e90 100644
--- a/hw/tricore/tricore_testdevice.c
+++ b/hw/tricore/tricore_testdevice.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/tricore/tricore_testdevice.h"
 
diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index 3bf93356506..75b07905184 100644
--- a/hw/uefi/var-service-sysbus.c
+++ b/hw/uefi/var-service-sysbus.c
@@ -7,7 +7,7 @@
 #include "migration/vmstate.h"
 
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 
 #include "hw/uefi/hardware-info.h"
 #include "hw/uefi/var-service.h"
diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
index 4018d70f02f..785732fc978 100644
--- a/hw/usb/hcd-dwc3.c
+++ b/hw/usb/hcd-dwc3.c
@@ -28,7 +28,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "qemu/bitops.h"
 #include "qom/object.h"
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index bdbbaaa87a3..18b58f5fcbc 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -24,7 +24,7 @@
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-dma.h"
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 350b0118997..1a2cf29bed8 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -25,7 +25,7 @@
 #include "qemu/timer.h"
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-dma.h"
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index c771aafdd06..c7e9c719035 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -32,7 +32,7 @@
 #include "qemu/timer.h"
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/qdev-dma.h"
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
diff --git a/hw/usb/xlnx-usb-subsystem.c b/hw/usb/xlnx-usb-subsystem.c
index e0dfdfdcbd1..9bf040c917b 100644
--- a/hw/usb/xlnx-usb-subsystem.c
+++ b/hw/usb/xlnx-usb-subsystem.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/register.h"
 #include "qemu/bitops.h"
 #include "qom/object.h"
diff --git a/hw/usb/xlnx-versal-usb2-ctrl-regs.c b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
index 33a7d7fbca0..15ea4384488 100644
--- a/hw/usb/xlnx-versal-usb2-ctrl-regs.c
+++ b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
@@ -28,7 +28,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/register.h"
 #include "qemu/bitops.h"
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 54bd0c57b5f..0b0412b22f2 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -23,7 +23,7 @@
 #include "standard-headers/linux/virtio_mmio.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
 #include "qemu/host-utils.h"
diff --git a/hw/vmapple/aes.c b/hw/vmapple/aes.c
index a6e94610b85..553e688adbe 100644
--- a/hw/vmapple/aes.c
+++ b/hw/vmapple/aes.c
@@ -15,7 +15,7 @@
 #include "crypto/aes.h"
 #include "crypto/cipher.h"
 #include "hw/core/irq.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/vmapple/vmapple.h"
 #include "migration/vmstate.h"
 #include "qemu/cutils.h"
diff --git a/hw/vmapple/bdif.c b/hw/vmapple/bdif.c
index 5ccd3745819..4dc10c151d2 100644
--- a/hw/vmapple/bdif.c
+++ b/hw/vmapple/bdif.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "hw/vmapple/vmapple.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
 #include "system/block-backend.h"
diff --git a/hw/vmapple/cfg.c b/hw/vmapple/cfg.c
index 3d58a29f69d..2a3204f0ec2 100644
--- a/hw/vmapple/cfg.c
+++ b/hw/vmapple/cfg.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/vmapple/vmapple.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 2ebd0f07bd3..b1379eafef3 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -29,7 +29,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/usb/usb.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
diff --git a/hw/watchdog/allwinner-wdt.c b/hw/watchdog/allwinner-wdt.c
index 68b600689a5..156f8235342 100644
--- a/hw/watchdog/allwinner-wdt.c
+++ b/hw/watchdog/allwinner-wdt.c
@@ -25,7 +25,7 @@
 #include "qemu/units.h"
 #include "qemu/module.h"
 #include "trace.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/registerfields.h"
 #include "hw/watchdog/allwinner-wdt.h"
 #include "system/watchdog.h"
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index ceae792580e..c474166cfcc 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "system/watchdog.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/registerfields.h"
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 930834bfcaf..26506f3c33f 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -15,7 +15,7 @@
 #include "qemu/timer.h"
 #include "system/watchdog.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index e3c51030f35..dfad2bc5085 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -10,7 +10,7 @@
 #include "qemu/module.h"
 #include "qemu/uuid.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/xen-backend.h"
 #include "hw/xen/xen-legacy-backend.h" /* xen_be_init() */
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index f9b0dd1513d..7977b527127 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/main-loop.h"
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index a533f2bac3f..5e6f897429d 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -38,7 +38,7 @@
 #include "exec/tswap.h"
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/block/flash.h"
 #include "chardev/char.h"
 #include "system/device_tree.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 8e74e24c190..0bf514cb096 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index b83f5f4fe62..983fc1724a0 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "block/aio-wait.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "apple-gfx.h"
 #include "trace.h"
-- 
2.51.1


