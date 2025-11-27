Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0E4D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObsj-0004EG-H6; Thu, 27 Nov 2025 08:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr6-0002jz-OA
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqy-0001IS-TQ
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tySLCAazpKjzXw8C+yTh2G1Jlal6Qmte86yH+orrCHU=;
 b=b9Arke73//BF6FQMwU6SsVFEWe1gNf2CiiV6OVS0efGmqyLUo70ebYyREN5xNwy6fL1UL3
 cRpvo69BAAqxG0TD+92/reV7eMnC3UhlRml4Ysq4+5/Eyfv20M7bJHbateAatYGxTFW1i6
 X9oJYViWwiu3jjaW9oaW4KEDDJmA5oQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-koxk0BW9Mh2hvg0RaXTf6Q-1; Thu, 27 Nov 2025 08:15:56 -0500
X-MC-Unique: koxk0BW9Mh2hvg0RaXTf6Q-1
X-Mimecast-MFC-AGG-ID: koxk0BW9Mh2hvg0RaXTf6Q_1764249356
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-64537824851so1020907a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249355; x=1764854155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tySLCAazpKjzXw8C+yTh2G1Jlal6Qmte86yH+orrCHU=;
 b=d/L7GoQ3ikm7TnsuRDTOZD3ox2svV9t7UvDjF7JoZR1NPPNTRDbyJNM7Lxu1/fdDvX
 wASKdOHlZsvDHKlkQzeRtIUwLNKkqAGZAH9ITd5+6Lc02B90pLwVy1MG4/SmoUqZA83B
 eMLcq/+4NVenrJhlfh/HMRpp6IodEX5dwnW6BD0lPlebfqTs9jkGAuNOXBe0Se/bdozy
 eybwh2nOlV+B/ItahojnNgZrtQ0DCtMovJZ5o3RMRj8cPuuTnGGpjb/9csJyeYRLBW6H
 foFkrYIeIS8adMFdYIko1imUcVZGZoyiT/BxYoUqgIqD7IUhHrf26kgmMOn+Q9id7LRP
 7LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249355; x=1764854155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tySLCAazpKjzXw8C+yTh2G1Jlal6Qmte86yH+orrCHU=;
 b=a+BXV/D6MRWXvTXihibvr5yceVNZEasxCpWN6iqlYjQrN4qvAs6sFF1+hppbgQgzIL
 MpYi6IbLxyqKVkgo+n6s7SxucHdW22vwFm6qGwu9P/Eid8/ktdW24HlKs9s1lwJoQ4nt
 i/PJaE3Vkf2KjkUGWiV5LN5fqWuYdaoRPq70CxTNk7wlD5iCNe4NMemYrfAALdELbceV
 0OEkxd3VBgtkfg0/P2VYDHMiwjgw95HbIUdSrrxqM/ObGpMCaoZX9nBAWwWYO3NAHbg9
 gQRVnf5D3uH8Od/3U+5KC2xRNBUfOr/BxXjYuo3UluTXnEIRhbRzvYL7KXyS8zsZLRIA
 eZsg==
X-Gm-Message-State: AOJu0YzLLgKSEvYYC78B4UwORKFZrGv3pHP4WC0ai4wIvCfsjGDD86QP
 +E/vmAd/5CUthvIFWr+ruZzO33AVucy3HhKq21wRPBY7VJjZhgpkenlVoCdkTCgDfa+acgJgMcy
 +GleXpjCT/nw1ioLgtGvfIZaYNUqPJsYe5bklwth2fexXwuaK2RThpsZdahwVD8Q1mWh5II/xUR
 cV6Bs8sHB+hgKaWJxBvU+fpr8li7H7uViNmuaJUy2O
X-Gm-Gg: ASbGncs8cX2h35+/VyOHSjUKeaDvflvk2N8EnnbKXgdSHr3RXzqZzop6zPmWHL/S/xn
 WyjHm/dmmBacNaYh8CM0iofI68YlXXHejBTmwVAG5VE9VlXTxja9A4Na2Xwp2o/bUfpX1caQ+RF
 uYChApTn2tUyVrm92rzkspHIGCGEcS+igUV6ux9trc7p+TIccVFO40Hp+55VrWT7jl5Ud2Ev43J
 NjlJg9JBDjudGxwMn66h5NZeZdVeYH8I+vwjhYNsGaEbDLjBYA5vb0HVvj6v70SyzQBB2WG6Bxk
 ydZqAy11stdY9PtoUJAWGvGZ+Sn2oD8w4heAy+Enrt5vUeCv8926EKxiWHcpsTkj/9EjnHnLLnL
 sB/cFxyk9pt6uP7HrQ79hAFR8a9Tf5nrr8KmbLLshD53LXiFUdc28NLEZNxqs80D2ekKqfuoJQs
 PMqnoBJeCZOB/YnVE=
X-Received: by 2002:a05:6402:5246:b0:640:ca67:848d with SMTP id
 4fb4d7f45d1cf-64555b9945fmr20088097a12.8.1764249353285; 
 Thu, 27 Nov 2025 05:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3VVrIvAQT3Q20IKuHoOslS7EWyHoBuDM/8hqZJrOr5pd2trzvZR4Jr7vjCCH9ASgO/8qKNw==
X-Received: by 2002:a05:6402:5246:b0:640:ca67:848d with SMTP id
 4fb4d7f45d1cf-64555b9945fmr20087932a12.8.1764249350748; 
 Thu, 27 Nov 2025 05:15:50 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751062261sm1723893a12.33.2025.11.27.05.15.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/28] include: move hw/qdev-properties.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:06 +0100
Message-ID: <20251127131516.80807-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 docs/devel/migration/compatibility.rst  | 2 +-
 hw/display/apple-gfx.h                  | 2 +-
 hw/riscv/riscv-iommu.h                  | 2 +-
 hw/tpm/tpm_prop.h                       | 2 +-
 include/hw/char/cadence_uart.h          | 2 +-
 include/hw/char/sifive_uart.h           | 2 +-
 include/hw/{ => core}/qdev-properties.h | 0
 include/hw/ide/ide-dev.h                | 2 +-
 include/hw/misc/unimp.h                 | 2 +-
 include/hw/net/ne2000-isa.h             | 2 +-
 include/hw/nubus/nubus.h                | 2 +-
 include/hw/qdev-properties-system.h     | 2 +-
 include/hw/timer/i8254.h                | 2 +-
 migration/options.h                     | 2 +-
 rust/hw/core/wrapper.h                  | 2 +-
 target/riscv/cpu.h                      | 2 +-
 backends/spdm-socket.c                  | 2 +-
 backends/tpm/tpm_util.c                 | 2 +-
 hw/9pfs/virtio-9p-device.c              | 2 +-
 hw/acpi/erst.c                          | 2 +-
 hw/acpi/generic_event_device.c          | 2 +-
 hw/acpi/piix4.c                         | 2 +-
 hw/acpi/vmclock.c                       | 2 +-
 hw/acpi/vmgenid.c                       | 2 +-
 hw/adc/aspeed_adc.c                     | 2 +-
 hw/adc/npcm7xx_adc.c                    | 2 +-
 hw/arm/armv7m.c                         | 2 +-
 hw/arm/aspeed_coprocessor_common.c      | 2 +-
 hw/arm/aspeed_soc_common.c              | 2 +-
 hw/arm/b-l475e-iot01a.c                 | 2 +-
 hw/arm/bananapi_m2u.c                   | 2 +-
 hw/arm/cubieboard.c                     | 2 +-
 hw/arm/digic.c                          | 2 +-
 hw/arm/exynos4210.c                     | 2 +-
 hw/arm/exynos4_boards.c                 | 2 +-
 hw/arm/fsl-imx25.c                      | 2 +-
 hw/arm/fsl-imx31.c                      | 2 +-
 hw/arm/fsl-imx6.c                       | 2 +-
 hw/arm/imx25_pdk.c                      | 2 +-
 hw/arm/imx8mp-evk.c                     | 2 +-
 hw/arm/max78000fthr.c                   | 2 +-
 hw/arm/mcimx6ul-evk.c                   | 2 +-
 hw/arm/mcimx7d-sabre.c                  | 2 +-
 hw/arm/microbit.c                       | 2 +-
 hw/arm/mps2.c                           | 2 +-
 hw/arm/mps3r.c                          | 2 +-
 hw/arm/msf2-som.c                       | 2 +-
 hw/arm/musicpal.c                       | 2 +-
 hw/arm/netduino2.c                      | 2 +-
 hw/arm/netduinoplus2.c                  | 2 +-
 hw/arm/npcm7xx.c                        | 2 +-
 hw/arm/npcm7xx_boards.c                 | 2 +-
 hw/arm/npcm8xx.c                        | 2 +-
 hw/arm/npcm8xx_boards.c                 | 2 +-
 hw/arm/olimex-stm32-h405.c              | 2 +-
 hw/arm/omap1.c                          | 2 +-
 hw/arm/orangepi.c                       | 2 +-
 hw/arm/sabrelite.c                      | 2 +-
 hw/arm/sbsa-ref.c                       | 2 +-
 hw/arm/smmu-common.c                    | 2 +-
 hw/arm/smmuv3.c                         | 2 +-
 hw/arm/stm32f100_soc.c                  | 2 +-
 hw/arm/stm32f205_soc.c                  | 2 +-
 hw/arm/stm32vldiscovery.c               | 2 +-
 hw/arm/strongarm.c                      | 2 +-
 hw/arm/virt.c                           | 2 +-
 hw/audio/ac97.c                         | 2 +-
 hw/audio/adlib.c                        | 2 +-
 hw/audio/asc.c                          | 2 +-
 hw/audio/cs4231a.c                      | 2 +-
 hw/audio/gus.c                          | 2 +-
 hw/audio/hda-codec.c                    | 2 +-
 hw/audio/intel-hda.c                    | 2 +-
 hw/audio/marvell_88w8618.c              | 2 +-
 hw/audio/model.c                        | 2 +-
 hw/audio/pl041.c                        | 2 +-
 hw/audio/sb16.c                         | 2 +-
 hw/avr/atmega.c                         | 2 +-
 hw/block/fdc-isa.c                      | 2 +-
 hw/block/fdc.c                          | 2 +-
 hw/block/m25p80.c                       | 2 +-
 hw/block/pflash_cfi01.c                 | 2 +-
 hw/block/pflash_cfi02.c                 | 2 +-
 hw/block/swim.c                         | 2 +-
 hw/block/vhost-user-blk.c               | 2 +-
 hw/block/virtio-blk.c                   | 2 +-
 hw/block/xen-block.c                    | 2 +-
 hw/char/avr_usart.c                     | 2 +-
 hw/char/bcm2835_aux.c                   | 2 +-
 hw/char/debugcon.c                      | 2 +-
 hw/char/digic-uart.c                    | 2 +-
 hw/char/diva-gsp.c                      | 2 +-
 hw/char/escc.c                          | 2 +-
 hw/char/exynos4210_uart.c               | 2 +-
 hw/char/grlib_apbuart.c                 | 2 +-
 hw/char/ibex_uart.c                     | 2 +-
 hw/char/imx_serial.c                    | 2 +-
 hw/char/ipoctal232.c                    | 2 +-
 hw/char/max78000_uart.c                 | 2 +-
 hw/char/mcf_uart.c                      | 2 +-
 hw/char/mchp_pfsoc_mmuart.c             | 2 +-
 hw/char/nrf51_uart.c                    | 2 +-
 hw/char/parallel-isa.c                  | 2 +-
 hw/char/parallel.c                      | 2 +-
 hw/char/pl011.c                         | 2 +-
 hw/char/renesas_sci.c                   | 2 +-
 hw/char/sclpconsole-lm.c                | 2 +-
 hw/char/sclpconsole.c                   | 2 +-
 hw/char/serial-isa.c                    | 2 +-
 hw/char/serial-mm.c                     | 2 +-
 hw/char/serial-pci-multi.c              | 2 +-
 hw/char/serial-pci.c                    | 2 +-
 hw/char/serial.c                        | 2 +-
 hw/char/sh_serial.c                     | 2 +-
 hw/char/shakti_uart.c                   | 2 +-
 hw/char/spapr_vty.c                     | 2 +-
 hw/char/stm32f2xx_usart.c               | 2 +-
 hw/char/stm32l4x5_usart.c               | 2 +-
 hw/char/terminal3270.c                  | 2 +-
 hw/char/virtio-console.c                | 2 +-
 hw/char/virtio-serial-bus.c             | 2 +-
 hw/char/xen_console.c                   | 2 +-
 hw/char/xilinx_uartlite.c               | 2 +-
 hw/core/bus.c                           | 2 +-
 hw/core/cpu-common.c                    | 2 +-
 hw/core/cpu-system.c                    | 2 +-
 hw/core/cpu-user.c                      | 2 +-
 hw/core/generic-loader.c                | 2 +-
 hw/core/guest-loader.c                  | 2 +-
 hw/core/or-irq.c                        | 2 +-
 hw/core/platform-bus.c                  | 2 +-
 hw/core/qdev-properties-system.c        | 2 +-
 hw/core/qdev-properties.c               | 2 +-
 hw/core/qdev.c                          | 2 +-
 hw/core/split-irq.c                     | 2 +-
 hw/cpu/a15mpcore.c                      | 2 +-
 hw/cpu/a9mpcore.c                       | 2 +-
 hw/cpu/arm11mpcore.c                    | 2 +-
 hw/cpu/cluster.c                        | 2 +-
 hw/cxl/switch-mailbox-cci.c             | 2 +-
 hw/display/artist.c                     | 2 +-
 hw/display/ati.c                        | 2 +-
 hw/display/bcm2835_fb.c                 | 2 +-
 hw/display/bochs-display.c              | 2 +-
 hw/display/cg3.c                        | 2 +-
 hw/display/cirrus_vga.c                 | 2 +-
 hw/display/cirrus_vga_isa.c             | 2 +-
 hw/display/dm163.c                      | 2 +-
 hw/display/exynos4210_fimd.c            | 2 +-
 hw/display/g364fb.c                     | 2 +-
 hw/display/i2c-ddc.c                    | 2 +-
 hw/display/macfb.c                      | 2 +-
 hw/display/pl110.c                      | 2 +-
 hw/display/qxl.c                        | 2 +-
 hw/display/ramfb-standalone.c           | 2 +-
 hw/display/sm501.c                      | 2 +-
 hw/display/tcx.c                        | 2 +-
 hw/display/vga-isa.c                    | 2 +-
 hw/display/vga-mmio.c                   | 2 +-
 hw/display/vga-pci.c                    | 2 +-
 hw/display/vhost-user-gpu.c             | 2 +-
 hw/display/virtio-gpu-gl.c              | 2 +-
 hw/display/virtio-gpu-pci-gl.c          | 2 +-
 hw/display/virtio-gpu-pci-rutabaga.c    | 2 +-
 hw/display/virtio-gpu-pci.c             | 2 +-
 hw/display/virtio-gpu.c                 | 2 +-
 hw/display/virtio-vga-gl.c              | 2 +-
 hw/display/virtio-vga-rutabaga.c        | 2 +-
 hw/display/virtio-vga.c                 | 2 +-
 hw/display/vmware_vga.c                 | 2 +-
 hw/dma/i82374.c                         | 2 +-
 hw/dma/i8257.c                          | 2 +-
 hw/dma/pl080.c                          | 2 +-
 hw/dma/pl330.c                          | 2 +-
 hw/dma/sifive_pdma.c                    | 2 +-
 hw/dma/sparc32_dma.c                    | 2 +-
 hw/dma/xilinx_axidma.c                  | 2 +-
 hw/dma/xlnx-zdma.c                      | 2 +-
 hw/dma/xlnx_csu_dma.c                   | 2 +-
 hw/fsi/cfam.c                           | 2 +-
 hw/fsi/lbus.c                           | 2 +-
 hw/gpio/imx_gpio.c                      | 2 +-
 hw/gpio/npcm7xx_gpio.c                  | 2 +-
 hw/gpio/omap_gpio.c                     | 2 +-
 hw/gpio/pca9552.c                       | 2 +-
 hw/gpio/pca9554.c                       | 2 +-
 hw/gpio/pl061.c                         | 2 +-
 hw/gpio/sifive_gpio.c                   | 2 +-
 hw/gpio/stm32l4x5_gpio.c                | 2 +-
 hw/hyperv/hv-balloon.c                  | 2 +-
 hw/hyperv/syndbg.c                      | 2 +-
 hw/hyperv/vmbus.c                       | 2 +-
 hw/i2c/aspeed_i2c.c                     | 2 +-
 hw/i2c/core.c                           | 2 +-
 hw/i2c/i2c_mux_pca954x.c                | 2 +-
 hw/i2c/omap_i2c.c                       | 2 +-
 hw/i2c/smbus_eeprom.c                   | 2 +-
 hw/i386/amd_iommu.c                     | 2 +-
 hw/i386/intel_iommu.c                   | 2 +-
 hw/i386/kvm/clock.c                     | 2 +-
 hw/i386/kvm/ioapic.c                    | 2 +-
 hw/i386/pc_q35.c                        | 2 +-
 hw/i386/pc_sysfw.c                      | 2 +-
 hw/i386/sgx-epc.c                       | 2 +-
 hw/i386/vmmouse.c                       | 2 +-
 hw/i386/vmport.c                        | 2 +-
 hw/i386/x86-iommu.c                     | 2 +-
 hw/i386/xen/xen_pvdevice.c              | 2 +-
 hw/ide/ahci-sysbus.c                    | 2 +-
 hw/ide/cmd646.c                         | 2 +-
 hw/ide/isa.c                            | 2 +-
 hw/ide/macio.c                          | 2 +-
 hw/ide/mmio.c                           | 2 +-
 hw/input/adb.c                          | 2 +-
 hw/input/lasips2.c                      | 2 +-
 hw/input/pckbd.c                        | 2 +-
 hw/input/stellaris_gamepad.c            | 2 +-
 hw/input/virtio-input-hid.c             | 2 +-
 hw/input/virtio-input-host.c            | 2 +-
 hw/input/virtio-input.c                 | 2 +-
 hw/intc/apic_common.c                   | 2 +-
 hw/intc/arm_gic_common.c                | 2 +-
 hw/intc/arm_gicv2m.c                    | 2 +-
 hw/intc/arm_gicv3_common.c              | 2 +-
 hw/intc/arm_gicv3_its.c                 | 2 +-
 hw/intc/arm_gicv3_its_kvm.c             | 2 +-
 hw/intc/armv7m_nvic.c                   | 2 +-
 hw/intc/exynos4210_combiner.c           | 2 +-
 hw/intc/exynos4210_gic.c                | 2 +-
 hw/intc/goldfish_pic.c                  | 2 +-
 hw/intc/grlib_irqmp.c                   | 2 +-
 hw/intc/i8259_common.c                  | 2 +-
 hw/intc/ioapic.c                        | 2 +-
 hw/intc/loongarch_dintc.c               | 2 +-
 hw/intc/loongarch_extioi_common.c       | 2 +-
 hw/intc/loongarch_ipi.c                 | 2 +-
 hw/intc/loongarch_pic_common.c          | 2 +-
 hw/intc/loongson_ipi.c                  | 2 +-
 hw/intc/loongson_liointc.c              | 2 +-
 hw/intc/m68k_irqc.c                     | 2 +-
 hw/intc/mips_gic.c                      | 2 +-
 hw/intc/omap_intc.c                     | 2 +-
 hw/intc/ompic.c                         | 2 +-
 hw/intc/openpic.c                       | 2 +-
 hw/intc/openpic_kvm.c                   | 2 +-
 hw/intc/pnv_xive.c                      | 2 +-
 hw/intc/pnv_xive2.c                     | 2 +-
 hw/intc/ppc-uic.c                       | 2 +-
 hw/intc/realview_gic.c                  | 2 +-
 hw/intc/riscv_aclint.c                  | 2 +-
 hw/intc/riscv_aplic.c                   | 2 +-
 hw/intc/riscv_imsic.c                   | 2 +-
 hw/intc/rx_icu.c                        | 2 +-
 hw/intc/s390_flic.c                     | 2 +-
 hw/intc/sifive_plic.c                   | 2 +-
 hw/intc/spapr_xive.c                    | 2 +-
 hw/intc/xics.c                          | 2 +-
 hw/intc/xilinx_intc.c                   | 2 +-
 hw/intc/xive.c                          | 2 +-
 hw/intc/xive2.c                         | 2 +-
 hw/intc/xlnx-pmu-iomod-intc.c           | 2 +-
 hw/ipack/ipack.c                        | 2 +-
 hw/ipmi/ipmi.c                          | 2 +-
 hw/ipmi/ipmi_bmc_extern.c               | 2 +-
 hw/ipmi/ipmi_bmc_sim.c                  | 2 +-
 hw/ipmi/isa_ipmi_bt.c                   | 2 +-
 hw/ipmi/isa_ipmi_kcs.c                  | 2 +-
 hw/isa/isa-superio.c                    | 2 +-
 hw/isa/lpc_ich9.c                       | 2 +-
 hw/isa/pc87312.c                        | 2 +-
 hw/isa/piix.c                           | 2 +-
 hw/isa/vt82c686.c                       | 2 +-
 hw/m68k/mcf5206.c                       | 2 +-
 hw/m68k/mcf_intc.c                      | 2 +-
 hw/m68k/next-cube.c                     | 2 +-
 hw/m68k/q800-glue.c                     | 2 +-
 hw/m68k/virt.c                          | 2 +-
 hw/mem/cxl_type3.c                      | 2 +-
 hw/mem/nvdimm.c                         | 2 +-
 hw/mem/pc-dimm.c                        | 2 +-
 hw/mem/sparse-mem.c                     | 2 +-
 hw/microblaze/petalogix_ml605_mmu.c     | 2 +-
 hw/mips/boston.c                        | 2 +-
 hw/mips/cps.c                           | 2 +-
 hw/mips/fuloong2e.c                     | 2 +-
 hw/misc/a9scu.c                         | 2 +-
 hw/misc/allwinner-h3-dramc.c            | 2 +-
 hw/misc/allwinner-r40-dramc.c           | 2 +-
 hw/misc/allwinner-sid.c                 | 2 +-
 hw/misc/allwinner-sramc.c               | 2 +-
 hw/misc/applesmc.c                      | 2 +-
 hw/misc/arm11scu.c                      | 2 +-
 hw/misc/arm_l2x0.c                      | 2 +-
 hw/misc/arm_sysctl.c                    | 2 +-
 hw/misc/armsse-cpuid.c                  | 2 +-
 hw/misc/aspeed_hace.c                   | 2 +-
 hw/misc/aspeed_i3c.c                    | 2 +-
 hw/misc/aspeed_lpc.c                    | 2 +-
 hw/misc/aspeed_sbc.c                    | 2 +-
 hw/misc/aspeed_scu.c                    | 2 +-
 hw/misc/aspeed_sdmc.c                   | 2 +-
 hw/misc/aspeed_sli.c                    | 2 +-
 hw/misc/avr_power.c                     | 2 +-
 hw/misc/bcm2835_cprman.c                | 2 +-
 hw/misc/bcm2835_property.c              | 2 +-
 hw/misc/debugexit.c                     | 2 +-
 hw/misc/djmemc.c                        | 2 +-
 hw/misc/eccmemctl.c                     | 2 +-
 hw/misc/empty_slot.c                    | 2 +-
 hw/misc/iotkit-secctl.c                 | 2 +-
 hw/misc/iotkit-sysctl.c                 | 2 +-
 hw/misc/iotkit-sysinfo.c                | 2 +-
 hw/misc/ivshmem-pci.c                   | 2 +-
 hw/misc/led.c                           | 2 +-
 hw/misc/mac_via.c                       | 2 +-
 hw/misc/macio/cuda.c                    | 2 +-
 hw/misc/macio/gpio.c                    | 2 +-
 hw/misc/macio/macio.c                   | 2 +-
 hw/misc/macio/pmu.c                     | 2 +-
 hw/misc/max78000_gcr.c                  | 2 +-
 hw/misc/mips_cmgcr.c                    | 2 +-
 hw/misc/mips_cpc.c                      | 2 +-
 hw/misc/mips_itu.c                      | 2 +-
 hw/misc/mos6522.c                       | 2 +-
 hw/misc/mps2-fpgaio.c                   | 2 +-
 hw/misc/mps2-scc.c                      | 2 +-
 hw/misc/msf2-sysreg.c                   | 2 +-
 hw/misc/npcm7xx_mft.c                   | 2 +-
 hw/misc/npcm7xx_pwm.c                   | 2 +-
 hw/misc/npcm_gcr.c                      | 2 +-
 hw/misc/nrf51_rng.c                     | 2 +-
 hw/misc/pci-testdev.c                   | 2 +-
 hw/misc/pvpanic-isa.c                   | 2 +-
 hw/misc/pvpanic-mmio.c                  | 2 +-
 hw/misc/pvpanic-pci.c                   | 2 +-
 hw/misc/pvpanic.c                       | 2 +-
 hw/misc/sifive_e_aon.c                  | 2 +-
 hw/misc/sifive_u_otp.c                  | 2 +-
 hw/misc/stm32l4x5_rcc.c                 | 2 +-
 hw/misc/tz-mpc.c                        | 2 +-
 hw/misc/tz-msc.c                        | 2 +-
 hw/misc/tz-ppc.c                        | 2 +-
 hw/misc/virt_ctrl.c                     | 2 +-
 hw/misc/xlnx-versal-cframe-reg.c        | 2 +-
 hw/misc/xlnx-versal-cfu.c               | 2 +-
 hw/misc/xlnx-versal-crl.c               | 2 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c      | 2 +-
 hw/misc/xlnx-versal-trng.c              | 2 +-
 hw/misc/xlnx-versal-xramc.c             | 2 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c          | 2 +-
 hw/misc/zynq_slcr.c                     | 2 +-
 hw/net/allwinner-sun8i-emac.c           | 2 +-
 hw/net/allwinner_emac.c                 | 2 +-
 hw/net/cadence_gem.c                    | 2 +-
 hw/net/can/can_kvaser_pci.c             | 2 +-
 hw/net/can/can_mioe3680_pci.c           | 2 +-
 hw/net/can/can_pcm3680_pci.c            | 2 +-
 hw/net/can/ctucan_pci.c                 | 2 +-
 hw/net/can/xlnx-versal-canfd.c          | 2 +-
 hw/net/can/xlnx-zynqmp-can.c            | 2 +-
 hw/net/dp8393x.c                        | 2 +-
 hw/net/e1000.c                          | 2 +-
 hw/net/e1000e.c                         | 2 +-
 hw/net/eepro100.c                       | 2 +-
 hw/net/fsl_etsec/etsec.c                | 2 +-
 hw/net/ftgmac100.c                      | 2 +-
 hw/net/i82596.c                         | 2 +-
 hw/net/igb.c                            | 2 +-
 hw/net/imx_fec.c                        | 2 +-
 hw/net/lan9118.c                        | 2 +-
 hw/net/lance.c                          | 2 +-
 hw/net/lasi_i82596.c                    | 2 +-
 hw/net/mcf_fec.c                        | 2 +-
 hw/net/msf2-emac.c                      | 2 +-
 hw/net/mv88w8618_eth.c                  | 2 +-
 hw/net/ne2000-pci.c                     | 2 +-
 hw/net/npcm7xx_emc.c                    | 2 +-
 hw/net/opencores_eth.c                  | 2 +-
 hw/net/pcnet-pci.c                      | 2 +-
 hw/net/pcnet.c                          | 2 +-
 hw/net/rocker/rocker.c                  | 2 +-
 hw/net/rtl8139.c                        | 2 +-
 hw/net/smc91c111.c                      | 2 +-
 hw/net/spapr_llan.c                     | 2 +-
 hw/net/stellaris_enet.c                 | 2 +-
 hw/net/sungem.c                         | 2 +-
 hw/net/sunhme.c                         | 2 +-
 hw/net/tulip.c                          | 2 +-
 hw/net/virtio-net.c                     | 2 +-
 hw/net/vmxnet3.c                        | 2 +-
 hw/net/xen_nic.c                        | 2 +-
 hw/net/xgmac.c                          | 2 +-
 hw/net/xilinx_axienet.c                 | 2 +-
 hw/net/xilinx_ethlite.c                 | 2 +-
 hw/nvram/aspeed_otp.c                   | 2 +-
 hw/nvram/ds1225y.c                      | 2 +-
 hw/nvram/eeprom_at24c.c                 | 2 +-
 hw/nvram/fw_cfg.c                       | 2 +-
 hw/nvram/mac_nvram.c                    | 2 +-
 hw/nvram/nrf51_nvm.c                    | 2 +-
 hw/nvram/spapr_nvram.c                  | 2 +-
 hw/nvram/xlnx-bbram.c                   | 2 +-
 hw/nvram/xlnx-efuse.c                   | 2 +-
 hw/nvram/xlnx-versal-efuse-cache.c      | 2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c       | 2 +-
 hw/nvram/xlnx-zynqmp-efuse.c            | 2 +-
 hw/openrisc/openrisc_sim.c              | 2 +-
 hw/openrisc/virt.c                      | 2 +-
 hw/pci-bridge/cxl_downstream.c          | 2 +-
 hw/pci-bridge/cxl_root_port.c           | 2 +-
 hw/pci-bridge/cxl_upstream.c            | 2 +-
 hw/pci-bridge/gen_pcie_root_port.c      | 2 +-
 hw/pci-bridge/pci_bridge_dev.c          | 2 +-
 hw/pci-bridge/pci_expander_bridge.c     | 2 +-
 hw/pci-bridge/pcie_pci_bridge.c         | 2 +-
 hw/pci-bridge/pcie_root_port.c          | 2 +-
 hw/pci-bridge/xio3130_downstream.c      | 2 +-
 hw/pci-host/aspeed_pcie.c               | 2 +-
 hw/pci-host/astro.c                     | 2 +-
 hw/pci-host/designware.c                | 2 +-
 hw/pci-host/dino.c                      | 2 +-
 hw/pci-host/gpex.c                      | 2 +-
 hw/pci-host/grackle.c                   | 2 +-
 hw/pci-host/gt64120.c                   | 2 +-
 hw/pci-host/i440fx.c                    | 2 +-
 hw/pci-host/mv64361.c                   | 2 +-
 hw/pci-host/pnv_phb.c                   | 2 +-
 hw/pci-host/pnv_phb3.c                  | 2 +-
 hw/pci-host/pnv_phb3_msi.c              | 2 +-
 hw/pci-host/pnv_phb4.c                  | 2 +-
 hw/pci-host/pnv_phb4_pec.c              | 2 +-
 hw/pci-host/ppce500.c                   | 2 +-
 hw/pci-host/q35.c                       | 2 +-
 hw/pci-host/raven.c                     | 2 +-
 hw/pci-host/remote.c                    | 2 +-
 hw/pci-host/sabre.c                     | 2 +-
 hw/pci-host/uninorth.c                  | 2 +-
 hw/pci-host/versatile.c                 | 2 +-
 hw/pci-host/xilinx-pcie.c               | 2 +-
 hw/pci/pci.c                            | 2 +-
 hw/pci/pci_bridge.c                     | 2 +-
 hw/pci/pci_host.c                       | 2 +-
 hw/pci/pcie_port.c                      | 2 +-
 hw/pci/pcie_sriov.c                     | 2 +-
 hw/ppc/e500.c                           | 2 +-
 hw/ppc/mac_newworld.c                   | 2 +-
 hw/ppc/mac_oldworld.c                   | 2 +-
 hw/ppc/pegasos.c                        | 2 +-
 hw/ppc/pnv.c                            | 2 +-
 hw/ppc/pnv_adu.c                        | 2 +-
 hw/ppc/pnv_chiptod.c                    | 2 +-
 hw/ppc/pnv_core.c                       | 2 +-
 hw/ppc/pnv_homer.c                      | 2 +-
 hw/ppc/pnv_i2c.c                        | 2 +-
 hw/ppc/pnv_lpc.c                        | 2 +-
 hw/ppc/pnv_n1_chiplet.c                 | 2 +-
 hw/ppc/pnv_nest_pervasive.c             | 2 +-
 hw/ppc/pnv_occ.c                        | 2 +-
 hw/ppc/pnv_pnor.c                       | 2 +-
 hw/ppc/pnv_psi.c                        | 2 +-
 hw/ppc/pnv_sbe.c                        | 2 +-
 hw/ppc/ppc440_bamboo.c                  | 2 +-
 hw/ppc/ppc440_uc.c                      | 2 +-
 hw/ppc/ppc4xx_devs.c                    | 2 +-
 hw/ppc/ppc4xx_sdram.c                   | 2 +-
 hw/ppc/prep.c                           | 2 +-
 hw/ppc/prep_systemio.c                  | 2 +-
 hw/ppc/rs6000_mc.c                      | 2 +-
 hw/ppc/sam460ex.c                       | 2 +-
 hw/ppc/spapr.c                          | 2 +-
 hw/ppc/spapr_cpu_core.c                 | 2 +-
 hw/ppc/spapr_irq.c                      | 2 +-
 hw/ppc/spapr_nvdimm.c                   | 2 +-
 hw/ppc/spapr_pci.c                      | 2 +-
 hw/ppc/spapr_rng.c                      | 2 +-
 hw/ppc/spapr_tpm_proxy.c                | 2 +-
 hw/ppc/virtex_ml507.c                   | 2 +-
 hw/remote/proxy.c                       | 2 +-
 hw/riscv/numa.c                         | 2 +-
 hw/riscv/riscv-iommu-pci.c              | 2 +-
 hw/riscv/riscv-iommu-sys.c              | 2 +-
 hw/riscv/riscv-iommu.c                  | 2 +-
 hw/riscv/riscv_hart.c                   | 2 +-
 hw/riscv/shakti_c.c                     | 2 +-
 hw/riscv/virt.c                         | 2 +-
 hw/riscv/xiangshan_kmh.c                | 2 +-
 hw/rtc/allwinner-rtc.c                  | 2 +-
 hw/rtc/goldfish_rtc.c                   | 2 +-
 hw/rtc/m48t59-isa.c                     | 2 +-
 hw/rtc/m48t59.c                         | 2 +-
 hw/rtc/mc146818rtc.c                    | 2 +-
 hw/rtc/pl031.c                          | 2 +-
 hw/rtc/rs5c372.c                        | 2 +-
 hw/rx/rx62n.c                           | 2 +-
 hw/s390x/3270-ccw.c                     | 2 +-
 hw/s390x/ccw-device.c                   | 2 +-
 hw/s390x/cpu-topology.c                 | 2 +-
 hw/s390x/css-bridge.c                   | 2 +-
 hw/s390x/css.c                          | 2 +-
 hw/s390x/ipl.c                          | 2 +-
 hw/s390x/s390-pci-bus.c                 | 2 +-
 hw/s390x/s390-skeys.c                   | 2 +-
 hw/s390x/s390-stattrib.c                | 2 +-
 hw/s390x/s390-virtio-ccw.c              | 2 +-
 hw/s390x/vhost-scsi-ccw.c               | 2 +-
 hw/s390x/vhost-user-fs-ccw.c            | 2 +-
 hw/s390x/vhost-vsock-ccw.c              | 2 +-
 hw/s390x/virtio-ccw-9p.c                | 2 +-
 hw/s390x/virtio-ccw-balloon.c           | 2 +-
 hw/s390x/virtio-ccw-blk.c               | 2 +-
 hw/s390x/virtio-ccw-crypto.c            | 2 +-
 hw/s390x/virtio-ccw-gpu.c               | 2 +-
 hw/s390x/virtio-ccw-input.c             | 2 +-
 hw/s390x/virtio-ccw-mem.c               | 2 +-
 hw/s390x/virtio-ccw-net.c               | 2 +-
 hw/s390x/virtio-ccw-rng.c               | 2 +-
 hw/s390x/virtio-ccw-scsi.c              | 2 +-
 hw/s390x/virtio-ccw-serial.c            | 2 +-
 hw/scsi/megasas.c                       | 2 +-
 hw/scsi/mptsas.c                        | 2 +-
 hw/scsi/scsi-bus.c                      | 2 +-
 hw/scsi/scsi-disk.c                     | 2 +-
 hw/scsi/scsi-generic.c                  | 2 +-
 hw/scsi/spapr_vscsi.c                   | 2 +-
 hw/scsi/vhost-scsi.c                    | 2 +-
 hw/scsi/vhost-user-scsi.c               | 2 +-
 hw/scsi/virtio-scsi.c                   | 2 +-
 hw/scsi/vmw_pvscsi.c                    | 2 +-
 hw/sd/allwinner-sdhost.c                | 2 +-
 hw/sd/aspeed_sdhci.c                    | 2 +-
 hw/sd/sd.c                              | 2 +-
 hw/sd/sdhci-pci.c                       | 2 +-
 hw/sd/sdhci.c                           | 2 +-
 hw/sd/ssi-sd.c                          | 2 +-
 hw/sensor/isl_pmbus_vr.c                | 2 +-
 hw/sh4/r2d.c                            | 2 +-
 hw/sh4/sh7750.c                         | 2 +-
 hw/sparc/leon3.c                        | 2 +-
 hw/sparc/sun4m.c                        | 2 +-
 hw/sparc/sun4m_iommu.c                  | 2 +-
 hw/sparc64/sun4u.c                      | 2 +-
 hw/ssi/aspeed_smc.c                     | 2 +-
 hw/ssi/ibex_spi_host.c                  | 2 +-
 hw/ssi/npcm7xx_fiu.c                    | 2 +-
 hw/ssi/pnv_spi.c                        | 2 +-
 hw/ssi/sifive_spi.c                     | 2 +-
 hw/ssi/ssi.c                            | 2 +-
 hw/ssi/xilinx_spi.c                     | 2 +-
 hw/ssi/xilinx_spips.c                   | 2 +-
 hw/ssi/xlnx-versal-ospi.c               | 2 +-
 hw/timer/a9gtimer.c                     | 2 +-
 hw/timer/allwinner-a10-pit.c            | 2 +-
 hw/timer/arm_mptimer.c                  | 2 +-
 hw/timer/arm_timer.c                    | 2 +-
 hw/timer/aspeed_timer.c                 | 2 +-
 hw/timer/avr_timer16.c                  | 2 +-
 hw/timer/cmsdk-apb-dualtimer.c          | 2 +-
 hw/timer/grlib_gptimer.c                | 2 +-
 hw/timer/hpet.c                         | 2 +-
 hw/timer/ibex_timer.c                   | 2 +-
 hw/timer/mss-timer.c                    | 2 +-
 hw/timer/npcm7xx_timer.c                | 2 +-
 hw/timer/nrf51_timer.c                  | 2 +-
 hw/timer/pxa2xx_timer.c                 | 2 +-
 hw/timer/renesas_cmt.c                  | 2 +-
 hw/timer/renesas_tmr.c                  | 2 +-
 hw/timer/sifive_pwm.c                   | 2 +-
 hw/timer/slavio_timer.c                 | 2 +-
 hw/timer/sse-timer.c                    | 2 +-
 hw/timer/stm32f2xx_timer.c              | 2 +-
 hw/timer/xilinx_timer.c                 | 2 +-
 hw/tpm/tpm_crb.c                        | 2 +-
 hw/tpm/tpm_spapr.c                      | 2 +-
 hw/tpm/tpm_tis_common.c                 | 2 +-
 hw/tpm/tpm_tis_isa.c                    | 2 +-
 hw/tpm/tpm_tis_sysbus.c                 | 2 +-
 hw/tricore/triboard.c                   | 2 +-
 hw/tricore/tricore_testdevice.c         | 2 +-
 hw/uefi/var-service-sysbus.c            | 2 +-
 hw/usb/bus.c                            | 2 +-
 hw/usb/canokey.c                        | 2 +-
 hw/usb/ccid-card-emulated.c             | 2 +-
 hw/usb/ccid-card-passthru.c             | 2 +-
 hw/usb/dev-audio.c                      | 2 +-
 hw/usb/dev-hid.c                        | 2 +-
 hw/usb/dev-hub.c                        | 2 +-
 hw/usb/dev-mtp.c                        | 2 +-
 hw/usb/dev-network.c                    | 2 +-
 hw/usb/dev-serial.c                     | 2 +-
 hw/usb/dev-smartcard-reader.c           | 2 +-
 hw/usb/dev-storage.c                    | 2 +-
 hw/usb/dev-uas.c                        | 2 +-
 hw/usb/hcd-dwc2.c                       | 2 +-
 hw/usb/hcd-dwc3.c                       | 2 +-
 hw/usb/hcd-ehci-pci.c                   | 2 +-
 hw/usb/hcd-ehci-sysbus.c                | 2 +-
 hw/usb/hcd-ohci-pci.c                   | 2 +-
 hw/usb/hcd-ohci-sysbus.c                | 2 +-
 hw/usb/hcd-ohci.c                       | 2 +-
 hw/usb/hcd-uhci.c                       | 2 +-
 hw/usb/hcd-xhci-nec.c                   | 2 +-
 hw/usb/hcd-xhci-pci.c                   | 2 +-
 hw/usb/hcd-xhci-sysbus.c                | 2 +-
 hw/usb/hcd-xhci.c                       | 2 +-
 hw/usb/host-libusb.c                    | 2 +-
 hw/usb/redirect.c                       | 2 +-
 hw/usb/u2f-emulated.c                   | 2 +-
 hw/usb/u2f-passthru.c                   | 2 +-
 hw/usb/xlnx-usb-subsystem.c             | 2 +-
 hw/vfio-user/pci.c                      | 2 +-
 hw/vfio/ap.c                            | 2 +-
 hw/vfio/ccw.c                           | 2 +-
 hw/vfio/pci-quirks.c                    | 2 +-
 hw/vfio/pci.c                           | 2 +-
 hw/virtio/vdpa-dev-pci.c                | 2 +-
 hw/virtio/vdpa-dev.c                    | 2 +-
 hw/virtio/vhost-scsi-pci.c              | 2 +-
 hw/virtio/vhost-user-base.c             | 2 +-
 hw/virtio/vhost-user-blk-pci.c          | 2 +-
 hw/virtio/vhost-user-fs-pci.c           | 2 +-
 hw/virtio/vhost-user-fs.c               | 2 +-
 hw/virtio/vhost-user-gpio-pci.c         | 2 +-
 hw/virtio/vhost-user-gpio.c             | 2 +-
 hw/virtio/vhost-user-i2c-pci.c          | 2 +-
 hw/virtio/vhost-user-i2c.c              | 2 +-
 hw/virtio/vhost-user-rng-pci.c          | 2 +-
 hw/virtio/vhost-user-rng.c              | 2 +-
 hw/virtio/vhost-user-scmi-pci.c         | 2 +-
 hw/virtio/vhost-user-scsi-pci.c         | 2 +-
 hw/virtio/vhost-user-snd-pci.c          | 2 +-
 hw/virtio/vhost-user-snd.c              | 2 +-
 hw/virtio/vhost-user-test-device-pci.c  | 2 +-
 hw/virtio/vhost-user-test-device.c      | 2 +-
 hw/virtio/vhost-user-vsock-pci.c        | 2 +-
 hw/virtio/vhost-user-vsock.c            | 2 +-
 hw/virtio/vhost-vsock-common.c          | 2 +-
 hw/virtio/vhost-vsock-pci.c             | 2 +-
 hw/virtio/vhost-vsock.c                 | 2 +-
 hw/virtio/virtio-9p-pci.c               | 2 +-
 hw/virtio/virtio-balloon-pci.c          | 2 +-
 hw/virtio/virtio-balloon.c              | 2 +-
 hw/virtio/virtio-blk-pci.c              | 2 +-
 hw/virtio/virtio-crypto-pci.c           | 2 +-
 hw/virtio/virtio-crypto.c               | 2 +-
 hw/virtio/virtio-input-pci.c            | 2 +-
 hw/virtio/virtio-iommu-pci.c            | 2 +-
 hw/virtio/virtio-iommu.c                | 2 +-
 hw/virtio/virtio-mem.c                  | 2 +-
 hw/virtio/virtio-mmio.c                 | 2 +-
 hw/virtio/virtio-net-pci.c              | 2 +-
 hw/virtio/virtio-nsm-pci.c              | 2 +-
 hw/virtio/virtio-pci.c                  | 2 +-
 hw/virtio/virtio-pmem.c                 | 2 +-
 hw/virtio/virtio-rng-pci.c              | 2 +-
 hw/virtio/virtio-rng.c                  | 2 +-
 hw/virtio/virtio-scsi-pci.c             | 2 +-
 hw/virtio/virtio-serial-pci.c           | 2 +-
 hw/virtio/virtio.c                      | 2 +-
 hw/vmapple/vmapple.c                    | 2 +-
 hw/watchdog/cmsdk-apb-watchdog.c        | 2 +-
 hw/watchdog/sbsa_gwdt.c                 | 2 +-
 hw/watchdog/wdt_aspeed.c                | 2 +-
 hw/watchdog/wdt_imx2.c                  | 2 +-
 hw/xen/xen-bus.c                        | 2 +-
 hw/xen/xen-legacy-backend.c             | 2 +-
 hw/xen/xen_pt.c                         | 2 +-
 hw/xtensa/xtfpga.c                      | 2 +-
 net/net.c                               | 2 +-
 system/physmem.c                        | 2 +-
 system/qdev-monitor.c                   | 2 +-
 system/vl.c                             | 2 +-
 target/arm/cpu.c                        | 2 +-
 target/arm/cpu64.c                      | 2 +-
 target/arm/tcg/cpu64.c                  | 2 +-
 target/avr/cpu.c                        | 2 +-
 target/hexagon/cpu.c                    | 2 +-
 target/i386/cpu-apic.c                  | 2 +-
 target/i386/cpu.c                       | 2 +-
 target/loongarch/cpu.c                  | 2 +-
 target/microblaze/cpu.c                 | 2 +-
 target/mips/cpu.c                       | 2 +-
 target/ppc/cpu_init.c                   | 2 +-
 target/riscv/cpu.c                      | 2 +-
 target/s390x/cpu.c                      | 2 +-
 target/sparc/cpu.c                      | 2 +-
 tests/unit/test-qdev-global-props.c     | 2 +-
 686 files changed, 685 insertions(+), 685 deletions(-)
 rename include/hw/{ => core}/qdev-properties.h (100%)

diff --git a/docs/devel/migration/compatibility.rst b/docs/devel/migration/compatibility.rst
index ecb887e3184..ce3a1100deb 100644
--- a/docs/devel/migration/compatibility.rst
+++ b/docs/devel/migration/compatibility.rst
@@ -111,7 +111,7 @@ that array to see what value it needs to get for that feature.  And
 what are we going to put in that array, the value of a property.
 
 To create a property for a device, we need to use one of the
-DEFINE_PROP_*() macros. See include/hw/qdev-properties.h to find the
+DEFINE_PROP_*() macros. See include/hw/core/qdev-properties.h to find the
 macros that exist.  With it, we set the default value for that
 property, and that is what it is going to get in the latest released
 version.  But if we want a different value for a previous version, we
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index a8b1d1efc09..3197bd853da 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -10,7 +10,7 @@
 
 #include "qemu/queue.h"
 #include "system/memory.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "ui/surface.h"
 
 #define TYPE_APPLE_GFX_MMIO         "apple-gfx-mmio"
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index a31aa62144f..2dabd86941b 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -20,7 +20,7 @@
 #define HW_RISCV_IOMMU_STATE_H
 
 #include "qom/object.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/dma.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h
index c4df74805a7..876f5c80fcd 100644
--- a/hw/tpm/tpm_prop.h
+++ b/hw/tpm/tpm_prop.h
@@ -23,7 +23,7 @@
 #define HW_TPM_PROP_H
 
 #include "system/tpm_backend.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 extern const PropertyInfo qdev_prop_tpm;
 
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
index c87c327357f..ad09fbdf32c 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -19,7 +19,7 @@
 #ifndef CADENCE_UART_H
 #define CADENCE_UART_H
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 6486c3f4a5d..dea6055f872 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -21,7 +21,7 @@
 #define HW_SIFIVE_UART_H
 
 #include "chardev/char-fe.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 #include "qemu/fifo8.h"
diff --git a/include/hw/qdev-properties.h b/include/hw/core/qdev-properties.h
similarity index 100%
rename from include/hw/qdev-properties.h
rename to include/hw/core/qdev-properties.h
diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 92e88687800..617e8159c77 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -21,7 +21,7 @@
 #define IDE_DEV_H
 
 #include "system/dma.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/block/block.h"
 
 typedef struct IDEDevice IDEDevice;
diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 518d627dc5d..904f502fab1 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -8,7 +8,7 @@
 #ifndef HW_MISC_UNIMP_H
 #define HW_MISC_UNIMP_H
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qom/object.h"
diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index 73bae10ad1a..1e14d1afc0b 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -11,7 +11,7 @@
 #define HW_NET_NE2000_ISA_H
 
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "net/net.h"
 #include "qapi/error.h"
 
diff --git a/include/hw/nubus/nubus.h b/include/hw/nubus/nubus.h
index 7825840dcac..105ddddd0d8 100644
--- a/include/hw/nubus/nubus.h
+++ b/include/hw/nubus/nubus.h
@@ -9,7 +9,7 @@
 #ifndef HW_NUBUS_NUBUS_H
 #define HW_NUBUS_NUBUS_H
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 45687be005f..ec39ef3bd6e 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -1,7 +1,7 @@
 #ifndef HW_QDEV_PROPERTIES_SYSTEM_H
 #define HW_QDEV_PROPERTIES_SYSTEM_H
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
                                        Error **errp);
diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index f7148d92865..65775b789df 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -25,7 +25,7 @@
 #ifndef HW_I8254_H
 #define HW_I8254_H
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/isa/isa.h"
 #include "qapi/error.h"
 #include "qom/object.h"
diff --git a/migration/options.h b/migration/options.h
index a7b3262d1ed..d6f1742e5b9 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -14,7 +14,7 @@
 #ifndef QEMU_MIGRATION_OPTIONS_H
 #define QEMU_MIGRATION_OPTIONS_H
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/client-options.h"
 
diff --git a/rust/hw/core/wrapper.h b/rust/hw/core/wrapper.h
index 44f8583bff9..8fda78924d8 100644
--- a/rust/hw/core/wrapper.h
+++ b/rust/hw/core/wrapper.h
@@ -27,6 +27,6 @@ typedef enum memory_order {
 #include "hw/sysbus.h"
 #include "hw/core/clock.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/core/irq.h"
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f100374..b54cd78f8f7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -22,7 +22,7 @@
 
 #include "hw/core/cpu.h"
 #include "hw/registerfields.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 6d8f02d3b92..07aea375165 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "system/spdm-socket.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/core/qdev-prop-internal.h"
 
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index f2d1739e336..a64e156f45f 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -26,7 +26,7 @@
 #include "qapi/visitor.h"
 #include "tpm_int.h"
 #include "system/memory.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/tpm_backend.h"
 #include "system/tpm_util.h"
 #include "trace.h"
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 81b91e47c63..9f70e2338cd 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -22,7 +22,7 @@
 #include "virtio-9p.h"
 #include "fsdev/qemu-fsdev.h"
 #include "coth.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index 10bbe37c170..b6c1942e308 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -18,7 +18,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/error-report.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/aml-build.h"
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 675ec43d094..6741f46723c 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -19,7 +19,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "system/runstate.h"
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 1e3c6345411..19d4d4be932 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -24,7 +24,7 @@
 #include "hw/isa/apm.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/piix4.h"
diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
index c582c0c1f83..55c9f950662 100644
--- a/hw/acpi/vmclock.c
+++ b/hw/acpi/vmclock.c
@@ -17,7 +17,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/vmclock.h"
 #include "hw/nvram/fw_cfg.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "system/reset.h"
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 33c35c85dd4..fcf9a94daf1 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -17,7 +17,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/vmgenid.h"
 #include "hw/nvram/fw_cfg.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "system/reset.h"
diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
index 564979f24dd..fd3af308296 100644
--- a/hw/adc/aspeed_adc.c
+++ b/hw/adc/aspeed_adc.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/adc/aspeed_adc.h"
 #include "trace.h"
diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index 4494d5558f0..44079791cbd 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 #include "hw/adc/npcm7xx_adc.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index d9c7bcbcd71..844d620286c 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -13,7 +13,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "elf.h"
 #include "system/reset.h"
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor_common.c
index f037d5b573f..a0a4c73d08d 100644
--- a/hw/arm/aspeed_coprocessor_common.c
+++ b/hw/arm/aspeed_coprocessor_common.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "system/memory.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/aspeed_coprocessor.h"
 
 static void aspeed_coprocessor_realize(DeviceState *dev, Error **errp)
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 84e6458e80a..fd08793575a 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/char/serial-mm.h"
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index a724b5fdb20..ee789c8df94 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/core/split-irq.h"
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index fd347e18d26..9b468cd8ac8 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -24,7 +24,7 @@
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
 #include "hw/i2c/i2c.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-r40.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 9fe282342ab..a643ae4e27d 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index d831bc974d2..5dfa5839a61 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/arm/digic.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/system.h"
 
 #define DIGIC4_TIMER_BASE(n)    (0xc0210000 + (n) * 0x100)
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 992edd3ba89..5d68579cd6b 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -32,7 +32,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/exynos4210.h"
 #include "hw/sd/sdhci.h"
 #include "hw/usb/hcd-ehci.h"
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index f07dd452fcb..e8c171f40a8 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -32,7 +32,7 @@
 #include "system/address-spaces.h"
 #include "hw/arm/exynos4210.h"
 #include "hw/net/lan9118.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 7aad6359ea8..dd670827ff7 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx25.h"
 #include "system/system.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "chardev/char.h"
 #include "target/arm/cpu-qom.h"
 
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index e9f70ad94b8..190f863355d 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -24,7 +24,7 @@
 #include "hw/arm/fsl-imx31.h"
 #include "system/system.h"
 #include "system/address-spaces.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "chardev/char.h"
 #include "target/arm/cpu-qom.h"
 
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 50b34139fa2..f3aa1d81501 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -25,7 +25,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/system.h"
 #include "chardev/char.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 21860ed14d3..7ebd6c8eb9c 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/fsl-imx25.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index ed8c52e1bd2..0af5aad5835 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -12,7 +12,7 @@
 #include "hw/arm/fsl-imx8mp.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index 4b6e76e46bb..ed50bb91979 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/max78000_soc.h"
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 5fe6526ba0a..6e9d92b1f1d 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -16,7 +16,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
 
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index b1b56b920d4..a0ac647c3df 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -18,7 +18,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
 
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index cd035fffc76..9d5c4898469 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -18,7 +18,7 @@
 
 #include "hw/arm/nrf51_soc.h"
 #include "hw/i2c/microbit_i2c.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 
 struct MicrobitMachineState {
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 7d2efc703bd..ac9366d8447 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -36,7 +36,7 @@
 #include "hw/core/boards.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/unimp.h"
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/timer/cmsdk-apb-timer.h"
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 77a0c0b7aff..2d64a198c42 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -34,7 +34,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/or-irq.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 10382f0d3b2..caf6e7e1ad7 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/core/qdev-clock.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index a4ddc0d08f9..39e8f69cae0 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -22,7 +22,7 @@
 #include "hw/char/serial-mm.h"
 #include "qemu/timer.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/block/flash.h"
 #include "ui/console.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index c9281059365..c32deaf43ba 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f205_soc.h"
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index d64d2aefe46..a90dcbe8c26 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 6905e1d8a7d..c2bbcd89dbc 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -22,7 +22,7 @@
 #include "hw/core/loader.h"
 #include "hw/misc/unimp.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "exec/tswap.h"
 #include "qemu/units.h"
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 729306b33c5..57a8d3186e6 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -24,7 +24,7 @@
 #include "hw/core/loader.h"
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 71e47dac2e1..9ce6ea52d97 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -25,7 +25,7 @@
 #include "hw/core/loader.h"
 #include "hw/misc/unimp.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/units.h"
 #include "system/system.h"
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 7252edf3dcb..042a928857c 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -23,7 +23,7 @@
 #include "hw/core/cpu.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/datadir.h"
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 1a08d742155..e801e4308ed 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 994e5a919e1..fcba6eb52d5 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -26,7 +26,7 @@
 #include "system/address-spaces.h"
 #include "hw/hw.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/omap.h"
 #include "hw/sd/sd.h"
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index c0dd32f13ce..d84443bb7b3 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -23,7 +23,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-h3.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 99cbd5e2fea..db5669c5c24 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -16,7 +16,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 5f0fb16a54c..d86b4706869 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -44,7 +44,7 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/core/loader.h"
 #include "hw/pci-host/gpex.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/usb.h"
 #include "hw/usb/xhci.h"
 #include "hw/char/pl011.h"
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 62a76121841..e1b77cc55fc 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -21,7 +21,7 @@
 #include "exec/target_page.h"
 #include "hw/core/cpu.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/jhash.h"
 #include "qemu/module.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e391842dc33..e12a64a20fb 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -21,7 +21,7 @@
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev.h"
 #include "hw/pci/pci.h"
 #include "cpu.h"
diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
index 8d61be72c48..2358368dbab 100644
--- a/hw/arm/stm32f100_soc.c
+++ b/hw/arm/stm32f100_soc.c
@@ -29,7 +29,7 @@
 #include "hw/arm/boot.h"
 #include "system/address-spaces.h"
 #include "hw/arm/stm32f100_soc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "system/system.h"
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 406f614f1d5..a03c6b40025 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -28,7 +28,7 @@
 #include "hw/arm/boot.h"
 #include "system/address-spaces.h"
 #include "hw/arm/stm32f205_soc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "system/system.h"
 
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index e7e1b8200e1..8f93c0036a3 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f100_soc.h"
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 95dda078522..3ee73ee4594 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -29,7 +29,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0d2652e6dbc..d8773cb541f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -63,7 +63,7 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/core/sysbus-fdt.h"
 #include "hw/core/platform-bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/fdt.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 60daa62ea33..0694f0adf9c 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -21,7 +21,7 @@
 #include "hw/audio/model.h"
 #include "qemu/audio.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "system/dma.h"
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 19d3a5f1280..8b9fe53e17b 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -28,7 +28,7 @@
 #include "hw/audio/model.h"
 #include "qemu/audio.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
 
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index b6f42045003..77a5cc1092d 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -17,7 +17,7 @@
 #include "hw/core/irq.h"
 #include "qemu/audio.h"
 #include "hw/audio/asc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 8368172f401..7489cf42b7d 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -27,7 +27,7 @@
 #include "qemu/audio.h"
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 6c41b25486e..69ddc419191 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -29,7 +29,7 @@
 #include "qemu/audio.h"
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "gusemu.h"
 #include "qemu/error-report.h"
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index e90c9de046e..6445d227594 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "intel-hda.h"
 #include "migration/vmstate.h"
 #include "qemu/host-utils.h"
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 758e130c938..d7c2c3c2fd4 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci/msi.h"
 #include "monitor/qdev.h"
 #include "qemu/timer.h"
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index ba9bd6befd7..39f4b4514dc 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -14,7 +14,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/audio/wm8750.h"
 #include "qemu/audio.h"
 #include "qapi/error.h"
diff --git a/hw/audio/model.c b/hw/audio/model.c
index ff4e4b24528..86a5419b09e 100644
--- a/hw/audio/model.c
+++ b/hw/audio/model.c
@@ -26,7 +26,7 @@
 #include "monitor/qdev.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/audio/model.h"
 
 struct audio_model {
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 7bb2c81afcd..117b6b0ae65 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 6ca31a0e649..3c5beb9dfa3 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -27,7 +27,7 @@
 #include "qemu/audio.h"
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 95b6da5e343..b185295d551 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -16,7 +16,7 @@
 #include "system/memory.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 0034c3594ae..ebb3d2f7cd8 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -35,7 +35,7 @@
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index e0e53ba0382..1747f6506fd 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -35,7 +35,7 @@
 #include "qemu/memalign.h"
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index a5336d92ff9..648e6bdc008 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -26,7 +26,7 @@
 #include "system/block-backend.h"
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 168101d8dfe..f93b812c024 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -39,7 +39,7 @@
 #include "qemu/osdep.h"
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "system/block-backend.h"
 #include "qapi/error.h"
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 3244b699b98..6a74bcb7a1b 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -35,7 +35,7 @@
 #include "qemu/osdep.h"
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/block/swim.c b/hw/block/swim.c
index ad047362f88..53ba7fa59cf 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -18,7 +18,7 @@
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
 #include "hw/block/swim.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 
 
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index b399eab51a1..62295f187ca 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/virtio/virtio-blk-common.h"
 #include "hw/virtio/vhost.h"
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 64efce48462..ddf0e9ee53e 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -21,7 +21,7 @@
 #include "block/block_int.h"
 #include "trace.h"
 #include "hw/block/block.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/blockdev.h"
 #include "system/block-ram-registrar.h"
 #include "system/system.h"
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 74de897c798..5dc4ba9d076 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -20,7 +20,7 @@
 #include "qobject/qstring.h"
 #include "qom/object_interfaces.h"
 #include "hw/block/xen_blkif.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/xen/xen-block.h"
 #include "hw/xen/xen-backend.h"
 #include "system/blockdev.h"
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index e98ad53e447..c3515b6f7d0 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -23,7 +23,7 @@
 #include "hw/char/avr_usart.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
 static int avr_usart_can_receive(void *opaque)
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 03428efeea8..47e24c5bba1 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/bcm2835_aux.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index bb323adda55..36607d0c1c7 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -29,7 +29,7 @@
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qom/object.h"
 
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 0f6af51bb7b..04dec0df8a6 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -34,7 +34,7 @@
 #include "qemu/module.h"
 
 #include "hw/char/digic-uart.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
 enum {
diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 835594e5cb6..1dafc1e80c3 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -20,7 +20,7 @@
 #include "hw/char/serial.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 27269dca643..496bbc56dea 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 8ba310fd7ac..387156d5e34 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -31,7 +31,7 @@
 
 #include "hw/arm/exynos4210.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
 #include "trace.h"
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 15925eb2e63..9731e664c1b 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/char/grlib_uart.h"
 #include "hw/sysbus.h"
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index 23abeacb1b5..ac4a43af84e 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -29,7 +29,7 @@
 #include "hw/char/ibex_uart.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/registerfields.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 9f13236f29c..78d2c25f86f 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/imx_serial.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 6e38916150c..19f312b9d30 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/ipack/ipack.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
diff --git a/hw/char/max78000_uart.c b/hw/char/max78000_uart.c
index 5fc933123e9..59ec24a15e8 100644
--- a/hw/char/max78000_uart.c
+++ b/hw/char/max78000_uart.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/max78000_uart.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index d9d551924b3..391674dbcc6 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -12,7 +12,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/m68k/mcf.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
diff --git a/hw/char/mchp_pfsoc_mmuart.c b/hw/char/mchp_pfsoc_mmuart.c
index 6149f9d2047..6673721454c 100644
--- a/hw/char/mchp_pfsoc_mmuart.c
+++ b/hw/char/mchp_pfsoc_mmuart.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "hw/char/mchp_pfsoc_mmuart.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #define REGS_OFFSET 0x20
 
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index 39d144538d1..6087cabeb3c 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -17,7 +17,7 @@
 #include "qemu/module.h"
 #include "hw/char/nrf51_uart.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index b6dfb6cc31a..92e94138f4a 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "system/system.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/char/parallel.h"
 #include "qapi/error.h"
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 8732e4e9f96..6708d7658bd 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -28,7 +28,7 @@
 #include "qemu/module.h"
 #include "chardev/char-parallel.h"
 #include "hw/acpi/acpi_aml_interface.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/char/parallel-isa.h"
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 030d6a2e8b4..f37ffd349f6 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -24,7 +24,7 @@
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
index b32e41d5b8a..3c1cc43954b 100644
--- a/hw/char/renesas_sci.c
+++ b/hw/char/renesas_sci.c
@@ -25,7 +25,7 @@
 #include "qemu/log.h"
 #include "hw/core/irq.h"
 #include "hw/registerfields.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/char/renesas_sci.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index c51308f9c5c..ed08cf42da2 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -22,7 +22,7 @@
 #include "hw/s390x/sclp.h"
 #include "migration/vmstate.h"
 #include "hw/s390x/event-facility.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/s390x/ebcdic.h"
 #include "qom/object.h"
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 2abf861dbcf..ab444fe1fa4 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -19,7 +19,7 @@
 
 #include "hw/s390x/sclp.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/s390x/event-facility.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 0ea59a3d5c2..a4be0492c59 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -31,7 +31,7 @@
 #include "hw/char/serial.h"
 #include "hw/char/serial-isa.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
index 13aba780ec5..6e963e581f9 100644
--- a/hw/char/serial-mm.c
+++ b/hw/char/serial-mm.c
@@ -28,7 +28,7 @@
 #include "exec/cpu-common.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 static uint64_t serial_mm_read(void *opaque, hwaddr addr, unsigned size)
 {
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 34608569988..f0af12c14f9 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -32,7 +32,7 @@
 #include "hw/char/serial.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index d05d0898998..d8cacc90859 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -31,7 +31,7 @@
 #include "hw/char/serial.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 11685b397b7..cbff68a7111 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -35,7 +35,7 @@
 #include "system/runstate.h"
 #include "qemu/error-report.h"
 #include "trace.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
 #define UART_LCR_DLAB   0x80    /* Divisor latch access bit */
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 008a2ea2f04..9cd79fce334 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -29,7 +29,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sh4/sh.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/shakti_uart.c b/hw/char/shakti_uart.c
index 6e216edb0fc..51e45351d95 100644
--- a/hw/char/shakti_uart.c
+++ b/hw/char/shakti_uart.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/char/shakti_uart.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qemu/log.h"
 
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 766b2bfcac0..17a17c47c36 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -6,7 +6,7 @@
 #include "chardev/char-fe.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qom/object.h"
 
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 49bbda03b87..2c19ec69cc8 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/stm32f2xx_usart.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 4533cbc93be..8b208ba9b6a 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -26,7 +26,7 @@
 #include "hw/core/clock.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/registerfields.h"
 #include "trace.h"
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index c993f67b42a..821a75c37a2 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/s390x/3270-ccw.h"
 #include "qom/object.h"
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 1b669c9be83..8c2a6a9d1d3 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -15,7 +15,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "trace.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qapi/error.h"
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 673c50f0be0..5ec5f5313b2 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -27,7 +27,7 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-access.h"
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index a639fb0b114..a0d142582ee 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -29,7 +29,7 @@
 #include "chardev/char-fe.h"
 #include "hw/xen/xen-backend.h"
 #include "hw/xen/xen-bus-helper.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/xen/interface/io/console.h"
 #include "hw/xen/interface/io/xs_wire.h"
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index da1ecd249c7..9d81cd904c6 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "hw/char/xilinx_uartlite.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/core/bus.c b/hw/core/bus.c
index bddfc22d388..53f392fdda8 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/ctype.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index fb8421184d5..2e925880afa 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -32,7 +32,7 @@
 #include "exec/gdbstub.h"
 #include "system/tcg.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin.h"
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 5d5a4357399..48c8ddf4b15 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -25,7 +25,7 @@
 #include "system/memory.h"
 #include "qemu/target-info.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/sysemu-cpu-ops.h"
 #include "migration/vmstate.h"
 #include "system/tcg.h"
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
index 270afe5b9f6..25aa25ad240 100644
--- a/hw/core/cpu-user.c
+++ b/hw/core/cpu-user.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/cpu.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 590c6a8131a..24f3908b1cc 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -35,7 +35,7 @@
 #include "system/reset.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/core/generic-loader.h"
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index e46897c4974..38cb9f992cb 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -28,7 +28,7 @@
 #include "hw/core/cpu.h"
 #include "system/dma.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "guest-loader.h"
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index bcc7ad1e444..3dc008ea4f3 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/or-irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 4b6cc5f6498..a2217a2deec 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/platform-bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 7aa5cbb5103..d0a66358b5a 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 422a486969c..b4e936dcf06 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-visit-common.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index fae9ffc7595..a3b41286ea0 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -33,7 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "hw/sysbus.h"
 #include "hw/core/qdev-clock.h"
diff --git a/hw/core/split-irq.c b/hw/core/split-irq.c
index d0aaa108eb9..7491d74791e 100644
--- a/hw/core/split-irq.c
+++ b/hw/core/split-irq.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/split-irq.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 1a6fb914f3b..28cc4b3a4bd 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -23,7 +23,7 @@
 #include "qemu/module.h"
 #include "hw/cpu/a15mpcore.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
 #include "kvm_arm.h"
 #include "target/arm/gtimer.h"
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 9f8e0f70c49..2127f955789 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -13,7 +13,7 @@
 #include "qemu/module.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/cpu.h"
 #include "target/arm/cpu-qom.h"
 
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 1953d12f61b..f3a5174c1f9 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -13,7 +13,7 @@
 #include "hw/cpu/arm11mpcore.h"
 #include "hw/intc/realview_gic.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #define ARM11MPCORE_NUM_GIC_PRIORITY_BITS    4
 
diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index ef3b3d1e940..628fe333673 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -22,7 +22,7 @@
 
 #include "hw/core/cpu.h"
 #include "hw/cpu/cluster.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 
 static const Property cpu_cluster_properties[] = {
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 223f2204331..5ba587b4e55 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/cxl/cxl.h"
 
 #define CXL_SWCCI_MSIX_MBOX 3
diff --git a/hw/display/artist.c b/hw/display/artist.c
index e6fed03786e..22524d9c5fe 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -17,7 +17,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
 #include "trace.h"
diff --git a/hw/display/ati.c b/hw/display/ati.c
index f7c0006a879..e9c3ad2cd15 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -20,7 +20,7 @@
 #include "ati_int.h"
 #include "ati_regs.h"
 #include "vga-access.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "vga_regs.h"
 #include "qemu/bswap.h"
 #include "qemu/log.h"
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index f8f13b55cb4..8eec0dc600b 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -31,7 +31,7 @@
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index ad2821c9745..5fb6b733cb5 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -9,7 +9,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/display/bochs-vbe.h"
 #include "hw/display/edid.h"
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 5ec09b63247..f4067d7825a 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -32,7 +32,7 @@
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index ef08694626d..37228ff1345 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -40,7 +40,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ui/pixel_ops.h"
 #include "vga_regs.h"
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index 5cacf4fc127..bad9ec7599c 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/isa/isa.h"
 #include "cirrus_vga_internal.h"
 #include "qom/object.h"
diff --git a/hw/display/dm163.c b/hw/display/dm163.c
index e78804693cd..4feae912945 100644
--- a/hw/display/dm163.c
+++ b/hw/display/dm163.c
@@ -18,7 +18,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/display/dm163.h"
 #include "ui/console.h"
 #include "trace.h"
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 8d8062f427c..8e3a61ed0e8 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/hw.h"
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 10686cd6763..8ed3e6ecc37 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -21,7 +21,7 @@
 #include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
index 2adfc1a1472..1fddc5807a0 100644
--- a/hw/display/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -20,7 +20,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/display/i2c-ddc.h"
 
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 574d667173c..fa3572ead34 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -18,7 +18,7 @@
 #include "hw/nubus/nubus.h"
 #include "hw/display/macfb.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index e78a55184e9..2537c264625 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
 #include "framebuffer.h"
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 18f482ca7f7..f29b736722c 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -28,7 +28,7 @@
 #include "qemu/atomic.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/runstate.h"
 #include "migration/cpr.h"
 #include "migration/vmstate.h"
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 130f4e01df0..f1958be32ad 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -3,7 +3,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
 #include "qom/object.h"
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index bc091b3c9fb..6ccec03fe72 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -35,7 +35,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/i2c/i2c.h"
 #include "hw/display/i2c-ddc.h"
 #include "qemu/range.h"
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index dfe234e3354..b208923523a 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -28,7 +28,7 @@
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index d2213b0f3e6..95d85ff69a5 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -31,7 +31,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "ui/console.h"
 #include "qom/object.h"
 
diff --git a/hw/display/vga-mmio.c b/hw/display/vga-mmio.c
index 33263856b76..4c497b70f41 100644
--- a/hw/display/vga-mmio.c
+++ b/hw/display/vga-mmio.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/display/vga.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "ui/console.h"
 #include "vga_int.h"
 
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 7a39bb9b213..d0f9de1ab35 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 9fc6bbcd2ce..3f6fb7a8033 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index c06a078fb36..b98ef2ef987 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -21,7 +21,7 @@
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #include <virglrenderer.h>
 
diff --git a/hw/display/virtio-gpu-pci-gl.c b/hw/display/virtio-gpu-pci-gl.c
index a2819e1ca93..c8923795dfa 100644
--- a/hw/display/virtio-gpu-pci-gl.c
+++ b/hw/display/virtio-gpu-pci-gl.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu-pci.h"
diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-pci-rutabaga.c
index 5fdff37f2c1..4db77cb868d 100644
--- a/hw/display/virtio-gpu-pci-rutabaga.c
+++ b/hw/display/virtio-gpu-pci-rutabaga.c
@@ -4,7 +4,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu-pci.h"
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index c0d71b6254c..22659ca196b 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu-pci.h"
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 43e88a4daff..f23eec6862a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -26,7 +26,7 @@
 #include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/memfd.h"
 #include "qemu/module.h"
diff --git a/hw/display/virtio-vga-gl.c b/hw/display/virtio-vga-gl.c
index 984faa6b39a..178e4c71725 100644
--- a/hw/display/virtio-vga-gl.c
+++ b/hw/display/virtio-vga-gl.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/display/vga.h"
 #include "qapi/error.h"
diff --git a/hw/display/virtio-vga-rutabaga.c b/hw/display/virtio-vga-rutabaga.c
index a7bef6da248..1e07ee0b0d3 100644
--- a/hw/display/virtio-vga-rutabaga.c
+++ b/hw/display/virtio-vga-rutabaga.c
@@ -2,7 +2,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/display/vga.h"
 #include "qapi/error.h"
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 40e60f70fcd..5e087169f2f 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 7ca5a551426..ea7a9fca04e 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -30,7 +30,7 @@
 #include "hw/core/loader.h"
 #include "trace.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 #include "ui/console.h"
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index e226eda6d15..c909cf46401 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/dma/i8257.h"
 #include "qom/object.h"
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 2463952ada2..d909d6c8fc2 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/dma/i8257.h"
 #include "qapi/error.h"
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 28f79371646..bd61d8ed488 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -15,7 +15,7 @@
 #include "hw/dma/pl080.h"
 #include "hw/hw.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 
 #define PL080_CONF_E    0x1
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index a9e6d2746f0..4f00092f856 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index bae77544b23..2fbc37ffd14 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -25,7 +25,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 9f56faf9a53..5601d221ec2 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 15da3fcbc2c..7cdd76330f3 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -29,7 +29,7 @@
 #include "hw/hw.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 660fc21b6d1..306c56c3ef5 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -29,7 +29,7 @@
 #include "qemu/osdep.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index 92f445034e8..650401614ed 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -22,7 +22,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
index e2145c5934b..54c0b05769d 100644
--- a/hw/fsi/cfam.c
+++ b/hw/fsi/cfam.c
@@ -14,7 +14,7 @@
 #include "hw/fsi/cfam.h"
 #include "hw/fsi/fsi.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #define ENGINE_CONFIG_NEXT            BIT(31)
 #define ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
index 8ec7f5fd780..cae29e0658b 100644
--- a/hw/fsi/lbus.c
+++ b/hw/fsi/lbus.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/fsi/lbus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/log.h"
 #include "trace.h"
 
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 842c997a2a6..5abf208df47 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/gpio/npcm7xx_gpio.c b/hw/gpio/npcm7xx_gpio.c
index 59b95d232bf..ad19b9fd427 100644
--- a/hw/gpio/npcm7xx_gpio.c
+++ b/hw/gpio/npcm7xx_gpio.c
@@ -17,7 +17,7 @@
 
 #include "hw/gpio/npcm7xx_gpio.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 547f0a15a27..0c2a0f9aa6c 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index fe1d8dbffa2..dd3c795e49a 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -14,7 +14,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/bitops.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/gpio/pca9552.h"
 #include "hw/gpio/pca9552_regs.h"
 #include "hw/core/irq.h"
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index c6cdd27b3ff..8427e01e9b2 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -10,7 +10,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/bitops.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/gpio/pca9554.h"
 #include "hw/gpio/pca9554_regs.h"
 #include "hw/core/irq.h"
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 09b32247127..55f51b6cf20 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -32,7 +32,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/gpio/sifive_gpio.c b/hw/gpio/sifive_gpio.c
index 63ca721fadd..b7a56935c05 100644
--- a/hw/gpio/sifive_gpio.c
+++ b/hw/gpio/sifive_gpio.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/gpio/sifive_gpio.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index 5686bd53c23..92fa397fbaf 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -22,7 +22,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/clock.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index deb20d7b6a3..9dd759f11e8 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -20,7 +20,7 @@
 #include "hw/mem/memory-device.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index 29908e886b4..dc6cc84b503 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -13,7 +13,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/loader.h"
 #include "exec/target_page.h"
 #include "hw/hyperv/hyperv.h"
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 961406cdd6a..639d932b094 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -13,7 +13,7 @@
 #include "exec/target_page.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/hyperv/hyperv.h"
 #include "hw/hyperv/vmbus.h"
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 3d66dd863a1..e3ca77865bd 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "trace.h"
 
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 4b6345b5889..54f6bdca882 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index fd317f56701..7802c68452f 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -20,7 +20,7 @@
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_slave.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 6ac151d8515..c768f99e384 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -22,7 +22,7 @@
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index ce3723e1483..d9ac556a0ab 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -28,7 +28,7 @@
 #include "hw/core/boards.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_slave.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "qom/object.h"
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d689a06eca4..789e09d6f2b 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -31,7 +31,7 @@
 #include "hw/i386/apic_internal.h"
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "kvm/kvm_i386.h"
 #include "qemu/iova-tree.h"
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 78b142cceab..f744be9f70f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -27,7 +27,7 @@
 #include "intel_iommu_internal.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index f56382717f7..310b9a8eb5a 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -23,7 +23,7 @@
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/i386/kvm/clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 
 #include <linux/kvm.h>
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 693ee978a12..ba7888e3d1e 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/ioapic_internal.h"
 #include "hw/intc/kvm_irqcount.h"
 #include "system/kvm.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 5fd2f9d1e0c..18158ad15e4 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -40,7 +40,7 @@
 #include "hw/i386/kvm/clock.h"
 #include "hw/pci-host/q35.h"
 #include "hw/pci/pcie_port.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/amd_iommu.h"
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 4d64aa15550..906df5e7886 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -33,7 +33,7 @@
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/block/flash.h"
 #include "system/kvm.h"
 #include "target/i386/sev.h"
diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index 2b3b2823b5f..d3fe10028c5 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -13,7 +13,7 @@
 #include "hw/i386/pc.h"
 #include "hw/i386/sgx-epc.h"
 #include "hw/mem/memory-device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "target/i386/cpu.h"
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 3896159b055..2ae7f3a242e 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -27,7 +27,7 @@
 #include "ui/console.h"
 #include "hw/i386/vmport.h"
 #include "hw/input/i8042.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "cpu.h"
 #include "qom/object.h"
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 32e02e1eeb0..865e0e70db6 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -31,7 +31,7 @@
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/vmport.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "system/system.h"
 #include "system/hw_accel.h"
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index c127a44bb4b..21e0d40e114 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/i386/x86-iommu.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/i386/pc.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index 87a974ae5a0..fab26a06af1 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -33,7 +33,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qom/object.h"
diff --git a/hw/ide/ahci-sysbus.c b/hw/ide/ahci-sysbus.c
index 210818d0479..c722e91be1c 100644
--- a/hw/ide/ahci-sysbus.c
+++ b/hw/ide/ahci-sysbus.c
@@ -23,7 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "system/address-spaces.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 #include "hw/ide/ahci-sysbus.h"
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 2a59516a9dd..d44a90a1622 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/isa/isa.h"
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 5f418413c18..c97b7a1ff4d 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 07db7dc34aa..a7ed41fa265 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/ppc/mac_dbdma.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/misc/macio/macio.h"
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 699874db785..04b56ac5d86 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -30,7 +30,7 @@
 #include "system/dma.h"
 
 #include "hw/ide/mmio.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "ide-internal.h"
 
 /***********************************************************/
diff --git a/hw/input/adb.c b/hw/input/adb.c
index bcb11edca35..29c09c75596 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/input/adb.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
index 70a179907ca..e34e9cb5c02 100644
--- a/hw/input/lasips2.c
+++ b/hw/input/lasips2.c
@@ -23,7 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/input/ps2.h"
 #include "hw/input/lasips2.h"
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 48b457cac76..b09c3bce933 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -33,7 +33,7 @@
 #include "hw/input/ps2.h"
 #include "hw/core/irq.h"
 #include "hw/input/i8042.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index bd80db6fac5..f64f5ea9ce3 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -11,7 +11,7 @@
 #include "qapi/error.h"
 #include "hw/input/stellaris_gamepad.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
 
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index d986c3c16e3..bcbfef0b905 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -9,7 +9,7 @@
 #include "qemu/module.h"
 
 #include "hw/virtio/virtio.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
 
 #include "ui/console.h"
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index 9f62532559d..633547cc4f7 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -10,7 +10,7 @@
 #include "qemu/sockets.h"
 
 #include "hw/virtio/virtio.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
 
 #include <sys/ioctl.h>
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index a3f554f2110..6494cfbbe82 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -11,7 +11,7 @@
 #include "trace.h"
 
 #include "hw/virtio/virtio.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
 
 #include "standard-headers/linux/input.h"
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 83e1bc2d759..afac20440f8 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -29,7 +29,7 @@
 #include "trace.h"
 #include "hw/core/boards.h"
 #include "system/kvm.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index ed5be056452..304d89cf562 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -24,7 +24,7 @@
 #include "qemu/error-report.h"
 #include "gic_internal.h"
 #include "hw/arm/linux-boot-if.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "system/kvm.h"
 
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index e823fcc97fc..c39d31b1870 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -30,7 +30,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/pci/msi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 2d0df6da86c..0a2e5a3e2fc 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "hw/core/cpu.h"
 #include "hw/intc/arm_gicv3_common.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
index 577b4454057..cce3486d74c 100644
--- a/hw/intc/arm_gicv3_its.c
+++ b/hw/intc/arm_gicv3_its.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "trace.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "gicv3_internal.h"
 #include "qom/object.h"
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 9812d508597..ae12d41eee1 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -23,7 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "hw/intc/arm_gicv3_its_common.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/runstate.h"
 #include "system/kvm.h"
 #include "kvm_arm.h"
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index bb39a690a59..5fa210c6335 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -17,7 +17,7 @@
 #include "qemu/timer.h"
 #include "hw/intc/armv7m_nvic.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/tcg.h"
 #include "system/runstate.h"
 #include "target/arm/cpu.h"
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index b9e74d19c37..8bea69d91b7 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -35,7 +35,7 @@
 #include "hw/arm/exynos4210.h"
 #include "hw/hw.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 
 //#define DEBUG_COMBINER
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index 5b156f7ef5a..a65c9c6d28b 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/exynos4210_gic.h"
 #include "hw/arm/exynos4210.h"
 #include "qom/object.h"
diff --git a/hw/intc/goldfish_pic.c b/hw/intc/goldfish_pic.c
index 7aaccba75ae..96e7d5c225f 100644
--- a/hw/intc/goldfish_pic.c
+++ b/hw/intc/goldfish_pic.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index bb2ee5f8015..ce7cbc98c17 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -30,7 +30,7 @@
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/grlib_irqmp.h"
 
 #include "trace.h"
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 602e44c8eaf..8ceb5841b9b 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/intc/i8259.h"
 #include "hw/isa/i8259_internal.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 38e43846486..98de6ca8108 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -29,7 +29,7 @@
 #include "hw/intc/ioapic.h"
 #include "hw/intc/ioapic_internal.h"
 #include "hw/pci/msi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/accel-irq.h"
 #include "system/kvm.h"
 #include "system/system.h"
diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index 082755d28bb..574e4a0d277 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -15,7 +15,7 @@
 #include "hw/misc/unimp.h"
 #include "migration/vmstate.h"
 #include "trace.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "target/loongarch/cpu.h"
 #include "qemu/error-report.h"
 #include "system/hw_accel.h"
diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index ba03383ed19..5cb0d396c65 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -7,7 +7,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/loongarch_extioi_common.h"
 #include "migration/vmstate.h"
 #include "target/loongarch/cpu.h"
diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 2a4557a8baa..5d8b8c96df7 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -10,7 +10,7 @@
 #include "hw/core/boards.h"
 #include "qapi/error.h"
 #include "hw/intc/loongarch_ipi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
 #include "target/loongarch/cpu.h"
 
diff --git a/hw/intc/loongarch_pic_common.c b/hw/intc/loongarch_pic_common.c
index de170501cf2..309182b2fb1 100644
--- a/hw/intc/loongarch_pic_common.c
+++ b/hw/intc/loongarch_pic_common.c
@@ -7,7 +7,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/intc/loongarch_pic_common.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 static int loongarch_pic_pre_save(void *opaque)
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index fbc73e8b001..88d22afa6ac 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/loongson_ipi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "target/mips/cpu.h"
 
diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
index 4c24f330ed7..053d9898f8c 100644
--- a/hw/intc/loongson_liointc.c
+++ b/hw/intc/loongson_liointc.c
@@ -23,7 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/loongson_liointc.h"
 
 #define NUM_IRQS                32
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index 67cb9acb418..c652bf143f0 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/nmi.h"
 #include "hw/intc/intc.h"
 #include "hw/intc/m68k_irqc.h"
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 08925fe1e41..e983f3a2b58 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -20,7 +20,7 @@
 #include "kvm_mips.h"
 #include "hw/intc/mips_gic.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 static void mips_gic_set_vp_irq(MIPSGICState *gic, int vp, int pin)
 {
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 7b23b6d2cec..deb21f9dc19 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 5a630bd51cb..05f0ef82549 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -10,7 +10,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "system/memory.h"
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index edac46227f5..4cc5068ffc8 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -35,7 +35,7 @@
 #include "hw/pci/pci.h"
 #include "hw/ppc/openpic.h"
 #include "hw/ppc/ppc_e500.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/pci/msi.h"
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 673ea9ca055..6558135baa1 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -28,7 +28,7 @@
 #include "hw/ppc/openpic.h"
 #include "hw/ppc/openpic_kvm.h"
 #include "hw/pci/msi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "system/kvm.h"
 #include "qemu/log.h"
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index c2ca40b8be8..13ac2c6ccbf 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -21,7 +21,7 @@
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_xive.h"
 #include "hw/ppc/xive_regs.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/ppc.h"
 #include "trace.h"
 
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 0663baab544..ae424d01c42 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -22,7 +22,7 @@
 #include "hw/ppc/xive_regs.h"
 #include "hw/ppc/xive2_regs.h"
 #include "hw/ppc/ppc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/reset.h"
 #include "system/qtest.h"
 
diff --git a/hw/intc/ppc-uic.c b/hw/intc/ppc-uic.c
index bfc4a4fbceb..5090101f077 100644
--- a/hw/intc/ppc-uic.c
+++ b/hw/intc/ppc-uic.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/intc/ppc-uic.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 enum {
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index ecaf8201fd6..56ece334a5e 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -12,7 +12,7 @@
 #include "qemu/module.h"
 #include "hw/intc/realview_gic.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 static void realview_gic_set_irq(void *opaque, int irq, int level)
 {
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index f3e37df47d1..83968ad7cca 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -29,7 +29,7 @@
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "target/riscv/time_helper.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/riscv_aclint.h"
 #include "qemu/timer.h"
 #include "hw/core/irq.h"
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 580622d1712..cc5f30b5588 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -26,7 +26,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/msi.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/core/irq.h"
 #include "target/riscv/cpu.h"
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 54e72b81e78..bc580c000ef 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -26,7 +26,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/msi.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/riscv_imsic.h"
 #include "hw/core/irq.h"
 #include "target/riscv/cpu.h"
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index 84712e2e4d0..788afe6b1a0 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -28,7 +28,7 @@
 #include "qemu/error-report.h"
 #include "hw/core/irq.h"
 #include "hw/registerfields.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/rx_icu.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 1eed5125d17..508b58382ed 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -17,7 +17,7 @@
 #include "hw/sysbus.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390_flic.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/s390x/css.h"
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index c578b6e36d2..5df578822f9 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -25,7 +25,7 @@
 #include "qemu/error-report.h"
 #include "hw/sysbus.h"
 #include "hw/pci/msi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/sifive_plic.h"
 #include "target/riscv/cpu.h"
 #include "migration/vmstate.h"
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index e393f5dcdcc..76ab476f59a 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -21,7 +21,7 @@
 #include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive_regs.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 
 /*
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e87c0ad2bcd..1d40c4386d1 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -30,7 +30,7 @@
 #include "trace.h"
 #include "qemu/timer.h"
 #include "hw/ppc/xics.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/visitor.h"
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index f5a59d89830..465df1c3af2 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -30,7 +30,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qom/object.h"
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 6f9babf601c..d702b58bd0a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -14,7 +14,7 @@
 #include "system/cpus.h"
 #include "system/dma.h"
 #include "system/reset.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/ppc/xive.h"
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index fbb3b7975e5..495925196a8 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -13,7 +13,7 @@
 #include "target/ppc/cpu.h"
 #include "system/cpus.h"
 #include "system/dma.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive2.h"
 #include "hw/ppc/xive2_regs.h"
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index 098c1f327cd..f3509efa0ab 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -33,7 +33,7 @@
 #include "qemu/module.h"
 #include "hw/intc/xlnx-pmu-iomod-intc.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #ifndef XLNX_PMU_IO_INTC_ERR_DEBUG
 #define XLNX_PMU_IO_INTC_ERR_DEBUG 0
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index 4a710eb1876..f2e5524fa8b 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -13,7 +13,7 @@
 #include "qemu/module.h"
 #include "hw/ipack/ipack.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 IPackDevice *ipack_device_find(IPackBus *bus, int32_t slot)
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 2a7bc667ec3..b49affaccec 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/ipmi/ipmi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qom/object_interfaces.h"
 #include "system/runstate.h"
 #include "qapi/error.h"
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 2c6c5155792..fb90a7d7c30 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -34,7 +34,7 @@
 #include "qemu/timer.h"
 #include "chardev/char-fe.h"
 #include "hw/ipmi/ipmi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 9b3e3a4b7e7..b86943c3245 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -29,7 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 2b26f9c9f0f..911e16afbe7 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -28,7 +28,7 @@
 #include "hw/core/irq.h"
 #include "hw/ipmi/ipmi_bt.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 #include "hw/acpi/ipmi.h"
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 14e85e6e9fd..927f6b7a561 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -28,7 +28,7 @@
 #include "hw/core/irq.h"
 #include "hw/ipmi/ipmi_kcs.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 #include "hw/acpi/ipmi.h"
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 941b0f91d75..dc6ae3cb104 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -20,7 +20,7 @@
 #include "hw/char/parallel.h"
 #include "hw/block/fdc.h"
 #include "hw/isa/superio.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/input/i8042.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/char/serial-isa.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 6e772eca573..51dc680029d 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -45,7 +45,7 @@
 #include "hw/acpi/ich9.h"
 #include "hw/acpi/ich9_timer.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/runstate.h"
 #include "system/system.h"
 #include "hw/core/cpu.h"
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 388da8f5900..2a2c3e7b66a 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/pc87312.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index bf1c79a3e63..04b2be2cc39 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -30,7 +30,7 @@
 #include "hw/southbridge/piix.h"
 #include "hw/timer/i8254.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ide/piix.h"
 #include "hw/intc/i8259.h"
 #include "hw/isa/isa.h"
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 1362a1f4042..99be41d0adf 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -19,7 +19,7 @@
 #include "hw/char/parallel-isa.h"
 #include "hw/char/serial-isa.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ide/pci.h"
 #include "hw/isa/isa.h"
 #include "hw/isa/superio.h"
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index e17da4fd209..4bc7b1d189e 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -10,7 +10,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
 #include "hw/m68k/mcf.h"
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index efac6802a97..b8770e3a53f 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -14,7 +14,7 @@
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 
 #define TYPE_MCF_INTC "mcf-intc"
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index e7217cbaeac..75ae66c311a 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -25,7 +25,7 @@
 #include "hw/char/escc.h" /* ZILOG 8530 Serial Emulation */
 #include "hw/block/fdc.h"
 #include "hw/misc/empty_slot.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "ui/console.h"
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 84dd01459cd..24fccab9666 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -26,7 +26,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
 #include "hw/core/nmi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 /*
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 7007d4e4e9f..2d83919fa86 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -14,7 +14,7 @@
 #include "system/system.h"
 #include "cpu.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "elf.h"
 #include "hw/core/loader.h"
 #include "ui/console.h"
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4f3688a71b6..26baa1c3d6c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -17,7 +17,7 @@
 #include "hw/mem/memory-device.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 23ab143ef8e..b7032525271 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/mem/nvdimm.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/mem/memory-device.h"
 #include "system/hostmem.h"
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 33e5a376ffa..3efe47f499a 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/boards.h"
 #include "hw/mem/pc-dimm.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/mem/memory-device.h"
diff --git a/hw/mem/sparse-mem.c b/hw/mem/sparse-mem.c
index d7b00e563ae..9186da6b1a9 100644
--- a/hw/mem/sparse-mem.c
+++ b/hw/mem/sparse-mem.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/units.h"
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index f5b9b2e8904..9c2b0ff0b37 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -35,7 +35,7 @@
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/address-spaces.h"
 #include "hw/ssi/ssi.h"
 
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index b63b27d03fa..4579df23eb7 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -31,7 +31,7 @@
 #include "hw/mips/cps.h"
 #include "hw/pci-host/xilinx-pcie.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 13f048ef9c9..620ee972f8f 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -23,7 +23,7 @@
 #include "hw/mips/cps.h"
 #include "hw/mips/mips.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/tcg.h"
 #include "system/reset.h"
 
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index d4c100b69a0..d0efe36f7ce 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -33,7 +33,7 @@
 #include "hw/pci/pci.h"
 #include "hw/core/loader.h"
 #include "hw/ide/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "elf.h"
 #include "hw/isa/vt82c686.h"
 #include "system/qtest.h"
diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index bb00ae29692..d5eb985044b 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/misc/a9scu.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
index 8834524c30c..ef491b36ffb 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -25,7 +25,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "system/address-spaces.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "hw/misc/allwinner-h3-dramc.h"
 #include "trace.h"
diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index 1c8e17e3c0b..3af8af733ac 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -25,7 +25,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "system/address-spaces.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
 #include "hw/misc/allwinner-r40-dramc.h"
diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
index 1e66c14567b..17faf67e606 100644
--- a/hw/misc/allwinner-sid.c
+++ b/hw/misc/allwinner-sid.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/misc/allwinner-sid.h"
 #include "trace.h"
diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
index ed299ecaae7..bd7f59fec97 100644
--- a/hw/misc/allwinner-sramc.c
+++ b/hw/misc/allwinner-sramc.c
@@ -24,7 +24,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/misc/allwinner-sramc.h"
 #include "trace.h"
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index a015d4a9b8c..fd96f5f245f 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -32,7 +32,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "ui/console.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/misc/arm11scu.c b/hw/misc/arm11scu.c
index 2ad4fd1d21d..89c2c4cd730 100644
--- a/hw/misc/arm11scu.c
+++ b/hw/misc/arm11scu.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/misc/arm11scu.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index 8b4b61eed00..a5511845c7c 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 8995eaeec36..0c91ebafac7 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/timer.h"
 #include "system/runstate.h"
 #include "qemu/bitops.h"
diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
index a57764d731f..3a52bb5381f 100644
--- a/hw/misc/armsse-cpuid.c
+++ b/hw/misc/armsse-cpuid.c
@@ -26,7 +26,7 @@
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/armsse-cpuid.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 REG32(CPUID, 0x0)
 REG32(PID4, 0xfd0)
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 51c73ca2a52..23e8030cd96 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -18,7 +18,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "crypto/hash.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/irq.h"
 #include "trace.h"
 
diff --git a/hw/misc/aspeed_i3c.c b/hw/misc/aspeed_i3c.c
index 3bef1c84dd1..37a05b9ce27 100644
--- a/hw/misc/aspeed_i3c.c
+++ b/hw/misc/aspeed_i3c.c
@@ -12,7 +12,7 @@
 #include "qemu/error-report.h"
 #include "hw/misc/aspeed_i3c.h"
 #include "hw/registerfields.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c
index 829955e6f16..68f0f6334bc 100644
--- a/hw/misc/aspeed_lpc.c
+++ b/hw/misc/aspeed_lpc.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 #define TO_REG(offset) ((offset) >> 2)
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 2fc5db749d2..065e822e70d 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/aspeed_sbc.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index a0ab5eed8f1..d27e0c7f915 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/misc/aspeed_scu.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index dff7cc362d3..59b4a9a4264 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -12,7 +12,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "hw/misc/aspeed_sdmc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/misc/aspeed_sli.c b/hw/misc/aspeed_sli.c
index c51484035e0..5b4d70cdc06 100644
--- a/hw/misc/aspeed_sli.c
+++ b/hw/misc/aspeed_sli.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/aspeed_sli.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
index 947304ed3b6..f42cf4fd906 100644
--- a/hw/misc/avr_power.c
+++ b/hw/misc/avr_power.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/avr_power.h"
 #include "qemu/log.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/irq.h"
 #include "trace.h"
 
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index efe6f900dbf..8220f7a6b4b 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -46,7 +46,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/bcm2835_cprman.h"
 #include "hw/misc/bcm2835_cprman_internals.h"
 #include "trace.h"
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 2026294ce12..216a746c2bd 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/misc/bcm2835_property.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index 04a9fc31223..cdd19166a5a 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "system/runstate.h"
diff --git a/hw/misc/djmemc.c b/hw/misc/djmemc.c
index c5b09f551b0..5fd3a8bfb25 100644
--- a/hw/misc/djmemc.c
+++ b/hw/misc/djmemc.c
@@ -11,7 +11,7 @@
 #include "qemu/log.h"
 #include "migration/vmstate.h"
 #include "hw/misc/djmemc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 
 
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index 71243ba5bad..f93cbd16590 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index 239d7603207..a012668214f 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/empty_slot.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index f8a2946191d..64e94a76479 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -20,7 +20,7 @@
 #include "hw/core/irq.h"
 #include "hw/misc/iotkit-secctl.h"
 #include "hw/arm/armsse-version.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 /* Registers in the secure privilege control block */
 REG32(SECRESPCFG, 0x10)
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index d70e51ab2ec..a9c3568c216 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -27,7 +27,7 @@
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/misc/iotkit-sysctl.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/armsse-version.h"
 #include "target/arm/arm-powerctl.h"
 
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 57405cb7e17..a53b1f51802 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -25,7 +25,7 @@
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/iotkit-sysinfo.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/arm/armsse-version.h"
 
 REG32(SYS_VERSION, 0x0)
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index 636d0b83dee..fb69af52f62 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
diff --git a/hw/misc/led.c b/hw/misc/led.c
index f7f709072af..d9256aaaf56 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/led.h"
 #include "trace.h"
 
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 13ccd3023fb..887397ae842 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -27,7 +27,7 @@
 #include "system/runstate.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "system/block-backend.h"
 #include "system/rtc.h"
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 3b8dd462f56..312dde242ba 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/misc/macio/cuda.h"
 #include "qemu/timer.h"
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 77658cb6d02..1a7c534d652 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/misc/macio/macio.h"
 #include "hw/misc/macio/gpio.h"
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 6710485d728..2813705c03b 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -29,7 +29,7 @@
 #include "hw/misc/macio/cuda.h"
 #include "hw/pci/pci.h"
 #include "hw/ppc/mac_dbdma.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/char/escc.h"
 #include "hw/misc/macio/macio.h"
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 73e64306b86..04640c20e0a 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -29,7 +29,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/misc/macio/pmu.h"
diff --git a/hw/misc/max78000_gcr.c b/hw/misc/max78000_gcr.c
index 6d2e2bd6176..e8dc5937329 100644
--- a/hw/misc/max78000_gcr.c
+++ b/hw/misc/max78000_gcr.c
@@ -12,7 +12,7 @@
 #include "hw/core/irq.h"
 #include "system/runstate.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/char/max78000_uart.h"
 #include "hw/misc/max78000_trng.h"
 #include "hw/misc/max78000_aes.h"
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 5484b739674..1c6e9d1f6f0 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -16,7 +16,7 @@
 #include "migration/vmstate.h"
 #include "hw/misc/mips_cmgcr.h"
 #include "hw/misc/mips_cpc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/mips_gic.h"
 
 static inline bool is_cpc_connected(MIPSGCRState *s)
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 9bfb7c97219..efc0326f6f2 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -26,7 +26,7 @@
 #include "migration/vmstate.h"
 
 #include "hw/misc/mips_cpc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 static inline uint64_t cpc_vp_run_mask(MIPSCPCState *cpc)
 {
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index fc17385cde7..82c0a90f704 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
 #include "hw/misc/mips_itu.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "target/mips/cpu.h"
 
 #define ITC_TAG_ADDRSPACE_SZ (ITC_ADDRESSMAP_NUM * 8)
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 728931883d8..bae766ef178 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/misc/mos6522.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index bee1309f5a6..f3d51fd2286 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -25,7 +25,7 @@
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-fpgaio.h"
 #include "hw/misc/led.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/timer.h"
 
 REG32(LED0, 0)
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index ea9cad85dc2..56aa0135072 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -28,7 +28,7 @@
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-scc.h"
 #include "hw/misc/led.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 REG32(CFG0, 0)
 REG32(CFG1, 4)
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index ce0ad50c1be..90c786e95ad 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -17,7 +17,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/misc/msf2-sysreg.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "trace.h"
diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index 0bbae111cf9..21e74385c71 100644
--- a/hw/misc/npcm7xx_mft.c
+++ b/hw/misc/npcm7xx_mft.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/npcm7xx_mft.h"
 #include "hw/misc/npcm7xx_pwm.h"
 #include "hw/registerfields.h"
diff --git a/hw/misc/npcm7xx_pwm.c b/hw/misc/npcm7xx_pwm.c
index 39ac0dbe2a5..1b010e51ec0 100644
--- a/hw/misc/npcm7xx_pwm.c
+++ b/hw/misc/npcm7xx_pwm.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/npcm7xx_pwm.h"
 #include "hw/registerfields.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index 2acaa167713..2d7e5b5a015 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/misc/npcm_gcr.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index 0254fb377a6..37c832d976c 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -16,7 +16,7 @@
 #include "hw/arm/nrf51.h"
 #include "hw/core/irq.h"
 #include "hw/misc/nrf51_rng.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/guest-random.h"
 
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index ba71c5069ff..3c3887afe0d 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/event_notifier.h"
 #include "qemu/module.h"
 #include "system/kvm.h"
diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index f7b421c713b..85fb7da5e5c 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -17,7 +17,7 @@
 #include "system/runstate.h"
 
 #include "hw/nvram/fw_cfg.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/isa/isa.h"
diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
index 2a363106b2d..2d1464435a8 100644
--- a/hw/misc/pvpanic-mmio.c
+++ b/hw/misc/pvpanic-mmio.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 #include "hw/sysbus.h"
 #include "standard-headers/misc/pvpanic.h"
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index 2869b6a7ff8..5509f70a3e5 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -16,7 +16,7 @@
 #include "system/runstate.h"
 
 #include "hw/nvram/fw_cfg.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index c83247c4087..bbd06d9accd 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -18,7 +18,7 @@
 #include "system/runstate.h"
 
 #include "hw/nvram/fw_cfg.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "standard-headers/misc/pvpanic.h"
diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
index 9b1e7baf95e..4d6e015ca38 100644
--- a/hw/misc/sifive_e_aon.c
+++ b/hw/misc/sifive_e_aon.c
@@ -25,7 +25,7 @@
 #include "qapi/visitor.h"
 #include "qapi/error.h"
 #include "system/watchdog.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 REG32(AON_WDT_WDOGCFG, 0x0)
     FIELD(AON_WDT_WDOGCFG, SCALE, 0, 4)
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index 1ebed2fd8b4..1d352680468 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 1b012d1cc1e..c2b25e9a4de 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -26,7 +26,7 @@
 #include "hw/core/clock.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/registerfields.h"
 #include "trace.h"
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index d922639da17..fb5d232bff5 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -19,7 +19,7 @@
 #include "hw/registerfields.h"
 #include "hw/core/irq.h"
 #include "hw/misc/tz-mpc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 /* Our IOMMU has two IOMMU indexes, one for secure transactions and one for
  * non-secure transactions.
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index 74c31f6d7d2..3e33455d421 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -19,7 +19,7 @@
 #include "hw/registerfields.h"
 #include "hw/core/irq.h"
 #include "hw/misc/tz-msc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 static void tz_msc_update_irq(TZMSC *s)
 {
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 2ab03fa9730..a41c6011fba 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -19,7 +19,7 @@
 #include "hw/registerfields.h"
 #include "hw/core/irq.h"
 #include "hw/misc/tz-ppc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 static void tz_ppc_update_irq(TZPPC *s)
 {
diff --git a/hw/misc/virt_ctrl.c b/hw/misc/virt_ctrl.c
index 9f16093ca2c..7cb1ea5d181 100644
--- a/hw/misc/virt_ctrl.c
+++ b/hw/misc/virt_ctrl.c
@@ -5,7 +5,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 616c0ecf837..33a4ece26f6 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -16,7 +16,7 @@
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index ce58404eb2c..80f9612b2ff 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -18,7 +18,7 @@
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 8f9a40d941d..b0baabc1adf 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/register.h"
diff --git a/hw/misc/xlnx-versal-pmc-iou-slcr.c b/hw/misc/xlnx-versal-pmc-iou-slcr.c
index c75800c1b3c..84d474c38fc 100644
--- a/hw/misc/xlnx-versal-pmc-iou-slcr.c
+++ b/hw/misc/xlnx-versal-pmc-iou-slcr.c
@@ -30,7 +30,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 
 #ifndef XILINX_VERSAL_PMC_IOU_SLCR_ERR_DEBUG
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 2b573a45bdb..aa1d65de7b7 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -35,7 +35,7 @@
 #include "qemu/timer.h"
 #include "qapi/visitor.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #ifndef XLNX_VERSAL_TRNG_ERR_DEBUG
 #define XLNX_VERSAL_TRNG_ERR_DEBUG 0
diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
index af58bc761f3..6a86f6b5d48 100644
--- a/hw/misc/xlnx-versal-xramc.c
+++ b/hw/misc/xlnx-versal-xramc.c
@@ -12,7 +12,7 @@
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/irq.h"
 #include "hw/misc/xlnx-versal-xramc.h"
 
diff --git a/hw/misc/xlnx-zynqmp-apu-ctrl.c b/hw/misc/xlnx-zynqmp-apu-ctrl.c
index 196e2452ae3..93f0bedc48e 100644
--- a/hw/misc/xlnx-zynqmp-apu-ctrl.c
+++ b/hw/misc/xlnx-zynqmp-apu-ctrl.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/register.h"
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index cc18b21b22b..d1900a2b948 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -24,7 +24,7 @@
 #include "hw/registerfields.h"
 #include "hw/core/qdev-clock.h"
 #include "qom/object.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 
 #ifndef ZYNQ_SLCR_ERR_DEBUG
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index a4824d61bda..8ff0db5ccdc 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -24,7 +24,7 @@
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/log.h"
 #include "trace.h"
 #include "net/checksum.h"
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 9158c77cb4f..cbe4cb80e4a 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -24,7 +24,7 @@
 #include "qemu/fifo8.h"
 #include "hw/core/irq.h"
 #include "hw/net/allwinner_emac.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include <zlib.h>
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index ef72821f8d7..fe9747fdb6f 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -27,7 +27,7 @@
 
 #include "hw/core/irq.h"
 #include "hw/net/cadence_gem.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 52584c5d6fa..f2912b206da 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -34,7 +34,7 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
 
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 2e9e09741b2..fe1a91ee0e7 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
 
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 7dd23c905e5..ea45de28a82 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
 
diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
index ad2b1e60cb4..40654778a45 100644
--- a/hw/net/can/ctucan_pci.c
+++ b/hw/net/can/ctucan_pci.c
@@ -31,7 +31,7 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
 
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 07342795575..94d9178a540 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -36,7 +36,7 @@
 #include "hw/register.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "trace.h"
diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index a98b208169f..533ac854a2f 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -38,7 +38,7 @@
 #include "qemu/log.h"
 #include "qemu/cutils.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "net/can_emu.h"
 #include "net/can_host.h"
 #include "qemu/event_notifier.h"
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 68062481c59..182f0e5f6b1 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/net/dp8393x.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index a80a7b0cdb4..202ad404013 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/net/mii.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/eth.h"
 #include "net/net.h"
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 89e6d52ba0f..3d4683370c6 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -45,7 +45,7 @@
 #include "hw/net/mii.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 #include "e1000_common.h"
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index d47df5a97fd..aaa3eb60f8a 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -45,7 +45,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/eth.h"
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index e6a29d9ec6d..5b77528e365 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -31,7 +31,7 @@
 #include "hw/core/irq.h"
 #include "hw/net/mii.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "etsec.h"
 #include "registers.h"
 #include "qapi/error.h"
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index d5590391b7f..d29f7dcd171 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -21,7 +21,7 @@
 #include "net/checksum.h"
 #include "net/eth.h"
 #include "hw/net/mii.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 #include <zlib.h> /* for crc32 */
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index a94cfa2d6df..37ce20efb19 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -41,7 +41,7 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "system/address-spaces.h"
 #include "qemu/module.h"
diff --git a/hw/net/igb.c b/hw/net/igb.c
index e4c02365d67..d39eba9f64d 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -52,7 +52,7 @@
 #include "hw/pci/pcie_sriov.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 #include "igb_common.h"
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 386d24421cb..c177b7ff2b7 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/net/imx_fec.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
 #include "qemu/log.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 191fd8b421b..381fd387641 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -19,7 +19,7 @@
 #include "hw/net/lan9118_phy.h"
 #include "hw/net/lan9118.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/bswap.h"
 #include "qemu/log.h"
diff --git a/hw/net/lance.c b/hw/net/lance.c
index dfb855c23a4..5d5bf9b9616 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -41,7 +41,7 @@
 #include "hw/sparc/sparc32_dma.h"
 #include "migration/vmstate.h"
 #include "hw/net/lance.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 #include "system/system.h"
 
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 2f212a7ed38..50e3c4fa86d 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -19,7 +19,7 @@
 #include "hw/net/lasi_82596.h"
 #include "hw/net/i82596.h"
 #include "trace.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 #define PA_I82596_RESET         0       /* Offsets relative to LASI-LAN-Addr.*/
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 9cd94369859..ecf105adf2e 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -14,7 +14,7 @@
 #include "hw/m68k/mcf.h"
 #include "hw/m68k/mcf_fec.h"
 #include "hw/net/mii.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include <zlib.h> /* for crc32 */
 
diff --git a/hw/net/msf2-emac.c b/hw/net/msf2-emac.c
index 3e279209628..ac01d1ce472 100644
--- a/hw/net/msf2-emac.c
+++ b/hw/net/msf2-emac.c
@@ -35,7 +35,7 @@
 #include "hw/net/msf2-emac.h"
 #include "hw/net/mii.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 REG32(CFG1, 0x0)
diff --git a/hw/net/mv88w8618_eth.c b/hw/net/mv88w8618_eth.c
index 68fda839660..1a1bba8b572 100644
--- a/hw/net/mv88w8618_eth.c
+++ b/hw/net/mv88w8618_eth.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/net/mv88w8618_eth.h"
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index 7b215eb1f2e..f741478101d 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ne2000.h"
 #include "system/system.h"
diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index 704f4387684..4105e894297 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -33,7 +33,7 @@
 
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/net/npcm7xx_emc.h"
 #include "net/eth.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 85419321d94..34992f3cc9f 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -34,7 +34,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/net/mii.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "qemu/module.h"
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index dad5d2ab06d..bef608959a6 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -30,7 +30,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "qemu/module.h"
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index fc2ce5eeb2d..0bd7d4314e7 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -38,7 +38,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/eth.h"
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index cc49701dd3c..935e74fd7d1 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/pci/msix.h"
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 324fb932aac..9fd00574d29 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -52,7 +52,7 @@
 #include <zlib.h> /* for crc32 */
 
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
 #include "qemu/module.h"
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index b1c675be6fc..e3bf3b0e726 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -14,7 +14,7 @@
 #include "hw/core/irq.h"
 #include "hw/net/smc91c111.h"
 #include "hw/registerfields.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index f6f217d6320..550848307d1 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -32,7 +32,7 @@
 #include "migration/vmstate.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/system.h"
 #include "trace.h"
 
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index a05aa8a024c..c97d6945852 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index b405eb89fa5..308c2d0dbd0 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index c2f7a8483da..e2cd1b52710 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/net/mii.h"
 #include "net/net.h"
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 5f9df76a74e..bc7b18ed36d 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -10,7 +10,7 @@
 #include "qemu/log.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/nvram/eeprom93xx.h"
 #include "migration/vmstate.h"
 #include "system/system.h"
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f5d93eb4005..3ded9ab8011 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -33,7 +33,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-net.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 03732375a76..bae3a44cb0c 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "net/tap.h"
 #include "net/checksum.h"
 #include "system/system.h"
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index e7bdc732de0..4ef1b7dd29a 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -37,7 +37,7 @@
 
 #include "hw/xen/xen-backend.h"
 #include "hw/xen/xen-bus-helper.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
 #include "hw/xen/interface/io/netif.h"
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 25768644f58..f07be725120 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index c7cb257e62d..36047a51c00 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -32,7 +32,7 @@
 #include "net/checksum.h"
 
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/stream.h"
 #include "qom/object.h"
 
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 0d00e3cc0d9..39e64a46e26 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -33,7 +33,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/misc/unimp.h"
 #include "net/net.h"
diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
index dcf8ed3917e..a60289000c3 100644
--- a/hw/nvram/aspeed_otp.c
+++ b/hw/nvram/aspeed_otp.c
@@ -10,7 +10,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "system/block-backend.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/nvram/aspeed_otp.h"
 #include "hw/nvram/trace.h"
 
diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 0945e36652e..512e5485187 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 82ea97e552a..e947cf8a3b2 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
 #include "hw/nvram/eeprom_at24c.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "system/block-backend.h"
 #include "qom/object.h"
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index df07424e553..e5c35b0e2e4 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -30,7 +30,7 @@
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index 66526a22914..b048db0777a 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/nvram/mac_nvram.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "system/block-backend.h"
 #include "migration/vmstate.h"
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index 23cc9fe9b3d..b841ead579d 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -23,7 +23,7 @@
 #include "qemu/module.h"
 #include "hw/arm/nrf51.h"
 #include "hw/nvram/nrf51_nvm.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 /*
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index d0ac4e5735f..c9202ddfcd4 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -36,7 +36,7 @@
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qom/object.h"
 
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 22aefbc240d..aad445b9018 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -31,7 +31,7 @@
 #include "qapi/error.h"
 #include "system/blockdev.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/nvram/xlnx-efuse.h"
 
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 4c23f8b9312..7eb156f9413 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -31,7 +31,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "system/blockdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
 #define TBIT0_OFFSET     28
diff --git a/hw/nvram/xlnx-versal-efuse-cache.c b/hw/nvram/xlnx-versal-efuse-cache.c
index d4ec96a6264..56c2def5f89 100644
--- a/hw/nvram/xlnx-versal-efuse-cache.c
+++ b/hw/nvram/xlnx-versal-efuse-cache.c
@@ -26,7 +26,7 @@
 #include "hw/nvram/xlnx-versal-efuse.h"
 
 #include "qemu/log.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #define MR_SIZE 0xC00
 
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 6f17f32a0c3..b7dc0e49e5f 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -29,7 +29,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #ifndef XLNX_VERSAL_EFUSE_CTRL_ERR_DEBUG
 #define XLNX_VERSAL_EFUSE_CTRL_ERR_DEBUG 0
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index ce35bb0cc1f..e6bc54fc6bd 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -31,7 +31,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #ifndef ZYNQMP_EFUSE_ERR_DEBUG
 #define ZYNQMP_EFUSE_ERR_DEBUG 0
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index a42e7b5e271..bafb877cc38 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -27,7 +27,7 @@
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
 #include "hw/openrisc/boot.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/address-spaces.h"
 #include "system/device_tree.h"
 #include "system/system.h"
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index bc5d27dbdd8..446a81579c1 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -20,7 +20,7 @@
 #include "hw/misc/sifive_test.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/rtc/goldfish_rtc.h"
 #include "hw/sysbus.h"
 #include "hw/virtio/virtio-mmio.h"
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 1065245a8b8..1265e40c395 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -13,7 +13,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/cxl/cxl.h"
 #include "qapi/error.h"
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index e6a4035d26c..df359dee670 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -23,7 +23,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci/msi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 208e0c6172e..019c311bb5b 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index d9078e783bf..fa1cf5e58fd 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_port.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index cb4809f38b1..0c1383562d9 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -27,7 +27,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/shpc.h"
 #include "hw/pci/slotid_cap.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/memory.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/core/hotplug.h"
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index b3a5f16e22a..08d40aa2eae 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -16,7 +16,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/cxl/cxl.h"
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index fce292a519b..e826fb2829f 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -16,7 +16,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/shpc.h"
 #include "hw/pci/slotid_cap.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 
 struct PCIEPCIBridge {
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 22c2fdb71e7..fe3ced56851 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -16,7 +16,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/pci/pcie_port.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 static void rp_aer_vector_update(PCIDevice *d)
 {
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index dc7d1aa7d77..0c3fed3053b 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -24,7 +24,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 5d837f638c2..27f1078e3a5 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index b54f6ef2d53..00a904277c0 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -28,7 +28,7 @@
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci-host/astro.h"
 #include "hw/hppa/hppa_hardware.h"
 #include "migration/vmstate.h"
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 5a80502abb7..019e0253820 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -26,7 +26,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/pci-host/designware.h"
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index e6fdb927f5e..4e64e0f553a 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -17,7 +17,7 @@
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci-host/dino.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 3db4c8c9f05..b5074c05c00 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -34,7 +34,7 @@
 #include "hw/core/irq.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 85a4b83228a..9a58f0e9b56 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci/pci_device.h"
 #include "hw/core/irq.h"
 #include "qapi/error.h"
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 3e497b5da5b..2339f10a30a 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -29,7 +29,7 @@
 #include "qemu/units.h"
 #include "qemu/log.h"
 #include "qemu/bswap.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index e13bb1b53e4..15354abf3ba 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -29,7 +29,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci-host/i440fx.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 9f080e4825a..636228c4074 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -16,7 +16,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/core/irq.h"
 #include "hw/intc/i8259.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/address-spaces.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 4b0ced79b08..85fcc3b6868 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -15,7 +15,7 @@
 #include "hw/pci-host/pnv_phb3.h"
 #include "hw/pci-host/pnv_phb4.h"
 #include "hw/ppc/pnv.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 #include "system/system.h"
 
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 9808d575509..d6ab5153374 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -19,7 +19,7 @@
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 #include "system/system.h"
 
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index f6bf4e323a9..66ba7b79134 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -14,7 +14,7 @@
 #include "hw/ppc/pnv.h"
 #include "hw/pci/msi.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/reset.h"
 
 static uint64_t phb3_msi_ive_addr(PnvPHB3 *phb, int srcno)
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 9f17fc1bb41..396bc47817d 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -19,7 +19,7 @@
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 #include "trace.h"
 
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 5bac1c42ed0..58ec14ec2fc 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -18,7 +18,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/system.h"
 
 #include <libfdt.h>
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index a8e172136eb..76623f78c46 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index a708758d361..bf562290514 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -32,7 +32,7 @@
 #include "qemu/log.h"
 #include "hw/i386/pc.h"
 #include "hw/pci-host/q35.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index a587f16131b..c50061996c7 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -30,7 +30,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/i8259.h"
 #include "hw/core/irq.h"
 #include "hw/core/or-irq.h"
diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
index e6d2af4502a..feaaa9adaa1 100644
--- a/hw/pci-host/remote.c
+++ b/hw/pci-host/remote.c
@@ -26,7 +26,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_host.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci-host/remote.h"
 #include "system/memory.h"
 
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index c2f99b76f80..87af933dc29 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -28,7 +28,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/core/irq.h"
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 7a25f3f39f5..d39546b6f42 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/module.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 40dce72e674..1fdae78210a 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -15,7 +15,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index ac6e61c83b0..86c20377d19 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -22,7 +22,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/irq.h"
 #include "hw/pci-host/xilinx-pcie.h"
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index a3118ac6d0d..2371a916809 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -30,7 +30,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/cpr.h"
 #include "migration/qemu-file-types.h"
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 76255c4cd89..e85932e41a9 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -38,7 +38,7 @@
 #include "qapi/error.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/acpi/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 /* PCI bridge subsystem vendor ID helper functions */
 #define PCI_SSVID_SIZEOF        8
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 7179d99178b..05f1475dc74 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -22,7 +22,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/module.h"
 #include "hw/pci/pci_bus.h"
 #include "migration/vmstate.h"
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index 20b5e4cfb51..dbb6032160e 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pcie_port.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/module.h"
 #include "hw/core/hotplug.h"
 
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index c4f88f09757..34e0875d210 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -14,7 +14,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 7c65757e215..7f164331c8e 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -38,7 +38,7 @@
 #include "hw/ppc/openpic.h"
 #include "hw/ppc/openpic_kvm.h"
 #include "hw/ppc/ppc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/loader.h"
 #include "elf.h"
 #include "hw/sysbus.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 909a4fe257d..410a3ac392e 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -52,7 +52,7 @@
 #include "qapi/error.h"
 #include "exec/target_page.h"
 #include "hw/ppc/ppc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/nvram/mac_nvram.h"
 #include "hw/core/boards.h"
 #include "hw/pci-host/uninorth.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 8400db6c352..e679d338985 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "exec/target_page.h"
 #include "hw/ppc/ppc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "hw/input/adb.h"
 #include "system/system.h"
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 2de80a5fae9..bf290a7dcd5 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -20,7 +20,7 @@
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
 #include "hw/i2c/smbus_eeprom.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/qtest.h"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8a50e9f0d85..f891c3a797c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -50,7 +50,7 @@
 #include "hw/pci-host/pnv_phb4.h"
 
 #include "hw/ppc/xics.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/pnv_chip.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_pnor.h"
diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index 005fbda4750..d686bfa62d9 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_adu.h"
 #include "hw/ppc/pnv_chip.h"
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index 540d5e365f4..09a5a52ac72 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -29,7 +29,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/pnv.h"
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index fb2dfc7ba21..59a9eee597c 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -29,7 +29,7 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/xics.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "helper_regs.h"
 
 static const char *pnv_core_cpu_typename(PnvCore *pc)
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index fb394cc6e09..1683513daca 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -23,7 +23,7 @@
 #include "system/memory.h"
 #include "system/cpus.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
 #include "hw/ppc/pnv_homer.h"
diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 213e58b455c..c8e90c636f4 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -12,7 +12,7 @@
 #include "system/reset.h"
 
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 538681bdb32..3b65c123164 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -24,7 +24,7 @@
 #include "qemu/module.h"
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
 #include "hw/ppc/pnv_lpc.h"
diff --git a/hw/ppc/pnv_n1_chiplet.c b/hw/ppc/pnv_n1_chiplet.c
index 053f6473f22..c75ac671d36 100644
--- a/hw/ppc/pnv_n1_chiplet.c
+++ b/hw/ppc/pnv_n1_chiplet.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_n1_chiplet.h"
diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
index 1b1b14fed95..01119e667c3 100644
--- a/hw/ppc/pnv_nest_pervasive.c
+++ b/hw/ppc/pnv_nest_pervasive.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_nest_pervasive.h"
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 7e93e6a6b11..64cab3e9dc8 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -22,7 +22,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
 #include "hw/ppc/pnv_xscom.h"
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index c7cbc525b33..1083e42ab57 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -15,7 +15,7 @@
 #include "system/blockdev.h"
 #include "hw/core/loader.h"
 #include "hw/ppc/pnv_pnor.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
 static uint64_t pnv_pnor_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 1cea9375c0e..264568cdfb1 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -30,7 +30,7 @@
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/pnv_psi.h"
 
 #include <libfdt.h>
diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 4798e129983..27383ce6837 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -22,7 +22,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_sbe.h"
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 9e71037d84c..491560575c0 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -30,7 +30,7 @@
 #include "system/reset.h"
 #include "hw/sysbus.h"
 #include "hw/intc/ppc-uic.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 
 #include <libfdt.h>
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index fd9203d7e2a..fc6dd332e88 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -15,7 +15,7 @@
 #include "hw/core/irq.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/pci-host/ppc4xx.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci/pci.h"
 #include "system/reset.h"
 #include "cpu.h"
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index f36c519c8bf..1e6b6fec5da 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/ppc/ppc4xx.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 
 /*****************************************************************************/
diff --git a/hw/ppc/ppc4xx_sdram.c b/hw/ppc/ppc4xx_sdram.c
index 6cc2a82ac5c..b2c8f96d5f8 100644
--- a/hw/ppc/ppc4xx_sdram.c
+++ b/hw/ppc/ppc4xx_sdram.c
@@ -36,7 +36,7 @@
 #include "qemu/error-report.h"
 #include "system/address-spaces.h" /* get_system_memory() */
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/ppc4xx.h"
 #include "trace.h"
 
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 90164face16..c4efd1d3908 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -39,7 +39,7 @@
 #include "hw/core/loader.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/isa/pc87312.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "exec/target_page.h"
 #include "system/kvm.h"
 #include "system/reset.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index d0e42e8731a..bc8b0964e75 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -26,7 +26,7 @@
 #include "qemu/log.h"
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index a0964051d1e..d87afd6d5b4 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "system/address-spaces.h"
 #include "qapi/error.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 550aaa21fa2..b6e233747ed 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -37,7 +37,7 @@
 #include "hw/ide/pci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/ppc/fdt.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/intc/ppc-uic.h"
 
 #include <libfdt.h>
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7363e533e15..eb626547ebd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -68,7 +68,7 @@
 #include "hw/ppc/spapr_nested.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/ppc/vof.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci-host/spapr.h"
 #include "hw/pci/msi.h"
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 4952f9bd2cf..41e37103c04 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/cpu/core.h"
 #include "hw/ppc/spapr_cpu_core.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "target/ppc/cpu.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 32a2edbe5cc..3a9c96d939b 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -17,7 +17,7 @@
 #include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xics.h"
 #include "hw/ppc/xics_spapr.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "cpu-models.h"
 #include "system/kvm.h"
 
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 72b4a6329fb..66474283915 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -34,7 +34,7 @@
 #include "block/thread-pool.h"
 #include "migration/vmstate.h"
 #include "qemu/pmem.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 /* DIMM health bitmap bitmap indicators. Taken from kernel's papr_scm.c */
 /* SCM device is unable to persist memory contents */
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 523edaa7b6c..a7c064be330 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -43,7 +43,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/ppc/spapr_drc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/device_tree.h"
 #include "system/kvm.h"
 #include "system/hostmem.h"
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index 6fec6070370..846ea3e3b6d 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -25,7 +25,7 @@
 #include "system/device_tree.h"
 #include "system/rng.h"
 #include "hw/ppc/spapr.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "kvm_ppc.h"
 #include "qom/object.h"
 
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index 1297b3ad569..a48dab7e7a6 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -15,7 +15,7 @@
 #include "qemu/error-report.h"
 #include "system/reset.h"
 #include "hw/ppc/spapr.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 
 #define TPM_SPAPR_BUFSIZE 4096
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 8b5f4eb57a0..cf2d10ecb27 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -43,7 +43,7 @@
 #include "hw/intc/ppc-uic.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #include <libfdt.h>
 
diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index 18e0f7a064f..5081d67e7f4 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -12,7 +12,7 @@
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
 #include "io/channel-util.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "monitor/monitor.h"
 #include "migration/blocker.h"
 #include "qemu/sockets.h"
diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
index 726df2daf1f..24a803f7fad 100644
--- a/hw/riscv/numa.c
+++ b/hw/riscv/numa.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/riscv/numa.h"
 #include "system/device_tree.h"
 
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index cdb4a7a8f03..5f7d3592047 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -21,7 +21,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 7d8c6f1c7c6..2a11c4dab6d 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -19,7 +19,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f8656ec04b1..baaadadda10 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -21,7 +21,7 @@
 #include "exec/target_page.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 33cbc9873e6..31187487946 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -26,7 +26,7 @@
 #include "qemu/cutils.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index d309ea2e39e..49a39b30212 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -24,7 +24,7 @@
 #include "hw/intc/sifive_plic.h"
 #include "hw/intc/riscv_aclint.h"
 #include "system/system.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/address-spaces.h"
 #include "hw/riscv/boot.h"
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9cb4f16432e..d79add55768 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -26,7 +26,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/char/serial-mm.h"
 #include "target/riscv/cpu.h"
 #include "hw/core/sysbus-fdt.h"
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index e831954cb36..436e51c1c59 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -37,7 +37,7 @@
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/riscv_imsic.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/xiangshan_kmh.h"
 #include "hw/riscv/riscv_hart.h"
diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c
index a747bff534c..0ffd38cf787 100644
--- a/hw/rtc/allwinner-rtc.c
+++ b/hw/rtc/allwinner-rtc.c
@@ -23,7 +23,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/rtc/allwinner-rtc.h"
 #include "system/rtc.h"
 #include "trace.h"
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 67f9eacb22a..79d2a04c721 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -23,7 +23,7 @@
 #include "hw/rtc/goldfish_rtc.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 9e2f6563a0a..ea0f307aa06 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/rtc/m48t59.h"
 #include "m48t59-internal.h"
 #include "qapi/error.h"
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 0be17b3e798..be8efb8c0ad 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/rtc/m48t59.h"
 #include "qemu/timer.h"
 #include "system/runstate.h"
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 4c4c1c84219..56f8c79479e 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -29,7 +29,7 @@
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/intc/kvm_irqcount.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qemu/timer.h"
 #include "system/system.h"
diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index 2ec8ac8add6..847349b407a 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -15,7 +15,7 @@
 #include "hw/rtc/pl031.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "system/system.h"
diff --git a/hw/rtc/rs5c372.c b/hw/rtc/rs5c372.c
index bb924534a73..58f12b836d3 100644
--- a/hw/rtc/rs5c372.c
+++ b/hw/rtc/rs5c372.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/resettable.h"
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 3fe9a4a518c..e1fa3d56618 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -27,7 +27,7 @@
 #include "hw/rx/rx62n.h"
 #include "hw/core/loader.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/system.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 3f0d384fd80..51c6828ff17 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/css-bridge.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/s390x/3270-ccw.h"
 
 /* Handle READ ccw commands from guest */
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 8be1813b9e7..25c42732795 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "ccw-device.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/module.h"
 #include "ipl.h"
 #include "qapi/visitor.h"
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index 9182ddb628d..efe88bc9674 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "target/s390x/cpu.h"
 #include "hw/s390x/s390-virtio-ccw.h"
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index f3b6ef56300..887794beef7 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/hotplug.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 53444f68288..d2c0af6a9bf 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -16,7 +16,7 @@
 #include "qemu/error-report.h"
 #include "system/address-spaces.h"
 #include "hw/s390x/ioinst.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/s390x/css.h"
 #include "trace.h"
 #include "hw/s390x/s390_flic.h"
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index e0a04ab1a22..b119a87a864 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -20,7 +20,7 @@
 #include "system/tcg.h"
 #include "elf.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "hw/s390x/virtio-ccw.h"
 #include "hw/s390x/vfio-ccw.h"
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3eea2f0c9d9..ff415b6312d 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -22,7 +22,7 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/core/boards.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
 #include "qemu/error-report.h"
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 8eeecfd58fc..d974d97b5e7 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -13,7 +13,7 @@
 #include "qemu/units.h"
 #include "exec/target_page.h"
 #include "hw/s390x/s390-virtio-ccw.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index aa185372914..f149af16ac1 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -14,7 +14,7 @@
 #include "exec/target_page.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c5e0691a26d..8314655ec2c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -36,7 +36,7 @@
 #include "migration/register.h"
 #include "target/s390x/cpu_models.h"
 #include "hw/core/nmi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/s390x/tod.h"
 #include "system/system.h"
 #include "system/cpus.h"
diff --git a/hw/s390x/vhost-scsi-ccw.c b/hw/s390x/vhost-scsi-ccw.c
index 8341b23a95c..1e68459eb0e 100644
--- a/hw/s390x/vhost-scsi-ccw.c
+++ b/hw/s390x/vhost-scsi-ccw.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/vhost-user-fs-ccw.c b/hw/s390x/vhost-user-fs-ccw.c
index cc1b8227fc0..35a77e4cb71 100644
--- a/hw/s390x/vhost-user-fs-ccw.c
+++ b/hw/s390x/vhost-user-fs-ccw.c
@@ -8,7 +8,7 @@
  * directory.
  */
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "hw/virtio/vhost-user-fs.h"
 #include "virtio-ccw.h"
diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
index 552e9e86a4b..efdfdeec84c 100644
--- a/hw/s390x/vhost-vsock-ccw.c
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-9p.c b/hw/s390x/virtio-ccw-9p.c
index 72bf6ec80c8..d8612f7cd13 100644
--- a/hw/s390x/virtio-ccw-9p.c
+++ b/hw/s390x/virtio-ccw-9p.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-balloon.c b/hw/s390x/virtio-ccw-balloon.c
index 399b40f366e..4f67310b693 100644
--- a/hw/s390x/virtio-ccw-balloon.c
+++ b/hw/s390x/virtio-ccw-balloon.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
index 7d8c4a75ced..939dcaeed38 100644
--- a/hw/s390x/virtio-ccw-blk.c
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index 75e714603b1..2c4ee2ca394 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-gpu.c b/hw/s390x/virtio-ccw-gpu.c
index edb6a47d376..4120c6bcb9f 100644
--- a/hw/s390x/virtio-ccw-gpu.c
+++ b/hw/s390x/virtio-ccw-gpu.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-input.c b/hw/s390x/virtio-ccw-input.c
index 2250d8cf981..a9ec60428ca 100644
--- a/hw/s390x/virtio-ccw-input.c
+++ b/hw/s390x/virtio-ccw-input.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-mem.c b/hw/s390x/virtio-ccw-mem.c
index daa485d189f..dea30aacfb3 100644
--- a/hw/s390x/virtio-ccw-mem.c
+++ b/hw/s390x/virtio-ccw-mem.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "virtio-ccw-mem.h"
diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
index a7d4afbeb9e..30e7055ab2b 100644
--- a/hw/s390x/virtio-ccw-net.c
+++ b/hw/s390x/virtio-ccw-net.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index 3263287d45a..0647621e33d 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-scsi.c b/hw/s390x/virtio-ccw-scsi.c
index 06b4c6c4a5a..c181a2b7692 100644
--- a/hw/s390x/virtio-ccw-scsi.c
+++ b/hw/s390x/virtio-ccw-scsi.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-serial.c b/hw/s390x/virtio-ccw-serial.c
index 0dac590c080..7ff07a08412 100644
--- a/hw/s390x/virtio-ccw-serial.c
+++ b/hw/s390x/virtio-ccw-serial.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qemu/module.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-serial.h"
 #include "virtio-ccw.h"
 
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 844643d916f..f62e420a91e 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/dma.h"
 #include "system/block-backend.h"
 #include "system/rtc.h"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 4ada35b7ec8..e4a7b2fee4a 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/dma.h"
 #include "hw/pci/msi.h"
 #include "qemu/iov.h"
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index b9b115deedd..f310ddafb96 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -4,7 +4,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/hw-version.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/scsi/scsi.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index b4782c6248d..9c78c9e18e2 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -36,7 +36,7 @@
 #include "system/block-backend.h"
 #include "system/blockdev.h"
 #include "hw/block/block.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "system/dma.h"
 #include "system/system.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 9e380a2109e..2ac4fd66c37 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -18,7 +18,7 @@
 #include "qemu/module.h"
 #include "hw/scsi/scsi.h"
 #include "migration/qemu-file-types.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/scsi/emulation.h"
 #include "system/block-backend.h"
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index a6591319db7..b4c8f94d22a 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -40,7 +40,7 @@
 #include "srp.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "viosrp.h"
 #include "trace.h"
 
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index b356bd9762e..ede4021648a 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -27,7 +27,7 @@
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/core/fw-path-provider.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/cutils.h"
 #include "system/system.h"
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 2c79522b09a..89f06066b70 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -20,7 +20,7 @@
 #include "qemu/error-report.h"
 #include "hw/core/fw-path-provider.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 93e87c459c7..774968d8c70 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -24,7 +24,7 @@
 #include "qemu/module.h"
 #include "system/block-backend.h"
 #include "system/dma.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
 #include "hw/virtio/iothread-vq-mapping.h"
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 7c98b1b8ea6..b3cdc255b46 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -33,7 +33,7 @@
 #include "migration/vmstate.h"
 #include "scsi/constants.h"
 #include "hw/pci/msi.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "vmw_pvscsi.h"
 #include "trace.h"
 #include "qom/object.h"
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index 4c039b9520e..87bb7df9035 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "system/blockdev.h"
 #include "system/dma.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/irq.h"
 #include "hw/sd/allwinner-sdhost.h"
 #include "migration/vmstate.h"
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index c2c85eaaf17..77bb753b9d1 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -13,7 +13,7 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 
 #define ASPEED_SDHCI_INFO            0x00
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ff45c8e70ca..3df331d5611 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -42,7 +42,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 0e38bed49a9..27001e5e1ec 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 39185f0a987..9146e0cde06 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -29,7 +29,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/dma.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 3aacbd03871..c6e350af2dd 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -19,7 +19,7 @@
 #include "system/blockdev.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sd/sd.h"
 #include "qapi/error.h"
 #include "qemu/crc-ccitt.h"
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index e8d29b08ff3..0fad04def77 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sensor/isl_pmbus_vr.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 9e8c2fa8d12..35db5cbbcd1 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -35,7 +35,7 @@
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "net/net.h"
 #include "sh7750_regs.h"
 #include "hw/ide/mmio.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 6cb42e34412..aff45320bc5 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -30,7 +30,7 @@
 #include "hw/sh4/sh.h"
 #include "system/system.h"
 #include "target/sh4/cpu.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "sh7750_regs.h"
 #include "sh7750_regnames.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 50f1cf91706..ec9a386b48d 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -33,7 +33,7 @@
 #include "hw/core/irq.h"
 #include "qemu/timer.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "system/system.h"
 #include "system/qtest.h"
 #include "system/reset.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index fa524513036..2e3952c917b 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -43,7 +43,7 @@
 #include "hw/core/boards.h"
 #include "hw/scsi/esp.h"
 #include "hw/nvram/sun_nvram.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 9ce2e3b7fc8..10c4786dad6 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index c0fb421d2ba..14b47c037ba 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -33,7 +33,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci-host/sabre.h"
 #include "hw/char/serial-isa.h"
 #include "hw/char/serial-mm.h"
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9819904a4ad..6bef856c620 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -34,7 +34,7 @@
 #include "trace.h"
 
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ssi/aspeed_smc.h"
 
 /* CE Type Setting Register */
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index 63f4cce5129..a7dc0c2f032 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -29,7 +29,7 @@
 #include "hw/registerfields.h"
 #include "hw/ssi/ibex_spi_host.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index bc5e4e20ccd..02707de350f 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ssi/npcm7xx_fiu.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index e59386712b4..1cf3a4416de 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ssi/pnv_spi.h"
 #include "hw/ssi/pnv_spi_regs.h"
diff --git a/hw/ssi/sifive_spi.c b/hw/ssi/sifive_spi.c
index c66fae80a9c..577cd5d2d8b 100644
--- a/hw/ssi/sifive_spi.c
+++ b/hw/ssi/sifive_spi.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/fifo8.h"
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index d0de640fe64..3a4fade2d5b 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 9e8656b5560..6dcdd63916a 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -32,7 +32,7 @@
 #include "qemu/fifo8.h"
 
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
 #include "qom/object.h"
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 5fa9bf965ff..e3c6035c169 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -26,7 +26,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/bitops.h"
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index 88fafb5a2ed..93cdc9d3999 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index a0b73fb7311..a2363a89a5f 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/timer/a9gtimer.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 6c0d3b556a2..d52669787ee 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index adec87cc8d2..869db913d40 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -23,7 +23,7 @@
 #include "hw/hw.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/timer/arm_mptimer.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 8d8b250698c..c38e56f5b89 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -13,7 +13,7 @@
 #include "qemu/timer.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "qom/object.h"
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index b08a737bc97..20adb7decbe 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -19,7 +19,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 
 #define TIMER_NR_REGS 4
diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
index 0f1fda4218f..1a65a61ed2b 100644
--- a/hw/timer/avr_timer16.c
+++ b/hw/timer/avr_timer16.c
@@ -35,7 +35,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/timer/avr_timer16.h"
 #include "trace.h"
 
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index 5f4848ef618..bcb6f8e43d7 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -23,7 +23,7 @@
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 82d0d9d7622..dbce6f736fa 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -30,7 +30,7 @@
 #include "qemu/timer.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/module.h"
 
 #include "trace.h"
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1387c417ae1..82006df0e34 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -29,7 +29,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/timer/hpet.h"
 #include "hw/sysbus.h"
 #include "hw/rtc/mc146818rtc.h"
diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index d2c4f86e038..ee186521893 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -30,7 +30,7 @@
 #include "qemu/timer.h"
 #include "hw/timer/ibex_timer.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "target/riscv/cpu.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index 946e87c99a6..bd3f3e845fd 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -27,7 +27,7 @@
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/timer/mss-timer.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index 0e62add74d3..16b62d3374b 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -18,7 +18,7 @@
 
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/timer/npcm7xx_timer.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 0688f49eefb..b0443b94827 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -17,7 +17,7 @@
 #include "hw/arm/nrf51.h"
 #include "hw/core/irq.h"
 #include "hw/timer/nrf51_timer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index d18d98b2337..b875c050525 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/timer.h"
 #include "system/runstate.h"
 #include "hw/sysbus.h"
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
index c62dad690ff..35962e66c32 100644
--- a/hw/timer/renesas_cmt.c
+++ b/hw/timer/renesas_cmt.c
@@ -25,7 +25,7 @@
 #include "qemu/log.h"
 #include "hw/core/irq.h"
 #include "hw/registerfields.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/timer/renesas_cmt.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index 1fc539e9497..2e7d7d4543a 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -25,7 +25,7 @@
 #include "qemu/log.h"
 #include "hw/core/irq.h"
 #include "hw/registerfields.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/timer/renesas_tmr.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
index f1882ae6bc1..8fda5445e74 100644
--- a/hw/timer/sifive_pwm.c
+++ b/hw/timer/sifive_pwm.c
@@ -28,7 +28,7 @@
 #include "trace.h"
 #include "hw/core/irq.h"
 #include "hw/timer/sifive_pwm.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index f66b3aaa433..07359a6fe70 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -26,7 +26,7 @@
 #include "qemu/timer.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index 1de882f3eb3..50d1de58055 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -45,7 +45,7 @@
 #include "hw/registerfields.h"
 #include "hw/core/clock.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 REG32(CNTPCT_LO, 0x0)
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 979b6ad5bae..0442ac64adc 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index fbc10015916..57a2c7101d1 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -30,7 +30,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index bc7a78f898c..8723536f931 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -19,7 +19,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "system/address-spaces.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/acpi/tpm.h"
 #include "migration/vmstate.h"
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index ea608ba4c80..19075d1f012 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 
 #include "system/tpm_backend.h"
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index 1615be29339..f594b15b8ab 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -32,7 +32,7 @@
 
 #include "hw/acpi/tpm.h"
 #include "hw/pci/pci_ids.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "system/tpm_backend.h"
 #include "system/tpm_util.h"
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index dce83057a94..61e95434f5b 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/tpm.h"
 #include "tpm_prop.h"
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 2ffa85852ac..07c30401301 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/tpm.h"
 #include "tpm_prop.h"
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index db6f2b765ac..23f11cf0a16 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "net/net.h"
 #include "hw/core/loader.h"
 #include "elf.h"
diff --git a/hw/tricore/tricore_testdevice.c b/hw/tricore/tricore_testdevice.c
index e8daf952982..d3ffc5fe9f3 100644
--- a/hw/tricore/tricore_testdevice.c
+++ b/hw/tricore/tricore_testdevice.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/tricore/tricore_testdevice.h"
 
 static void tricore_testdevice_write(void *opaque, hwaddr offset,
diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index a5aa218e260..3bf93356506 100644
--- a/hw/uefi/var-service-sysbus.c
+++ b/hw/uefi/var-service-sysbus.c
@@ -6,7 +6,7 @@
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 
 #include "hw/uefi/hardware-info.h"
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 887a4a2e487..9084326d11d 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/usb.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
diff --git a/hw/usb/canokey.c b/hw/usb/canokey.c
index acd4ea30d98..c3baedac2c2 100644
--- a/hw/usb/canokey.c
+++ b/hw/usb/canokey.c
@@ -13,7 +13,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/usb/usb.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 #include "desc.h"
 #include "canokey.h"
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index c21cefd82d2..985f21997aa 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -34,7 +34,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "ccid.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index c8aada0988d..306dd7d9146 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -13,7 +13,7 @@
 #include "qemu/units.h"
 #include <libcacard.h>
 #include "chardev/char-fe.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 988824ea750..dfda2dccc04 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -31,7 +31,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 296e9d0d856..ae19d60203f 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -33,7 +33,7 @@
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
 #include "hw/usb/hid.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 
 struct USBHIDState {
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index f418da14094..b45d571fa83 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "trace.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 04e8eedbf61..1d8cfd32dc6 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -22,7 +22,7 @@
 #include "qemu/module.h"
 #include "qemu/filemonitor.h"
 #include "trace.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 34cd906d6cc..568a6ff24c6 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 17bdff9e820..286c7711f64 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -13,7 +13,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index a1081e545aa..964c142d106 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -40,7 +40,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index bbd97406f00..040cf150518 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -16,7 +16,7 @@
 #include "hw/usb/usb.h"
 #include "hw/usb/msd.h"
 #include "desc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/scsi/scsi.h"
 #include "migration/vmstate.h"
 #include "qemu/cutils.h"
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 75f01c74038..8576dfec96f 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -21,7 +21,7 @@
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
 #include "qom/object.h"
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 83864505bb8..cd3b61158d1 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -41,7 +41,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #define USB_HZ_FS       12000000
 #define USB_HZ_HS       96000000
diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
index 98a342b8b82..74dff39fda1 100644
--- a/hw/usb/hcd-dwc3.c
+++ b/hw/usb/hcd-dwc3.c
@@ -33,7 +33,7 @@
 #include "qemu/bitops.h"
 #include "qom/object.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/hcd-dwc3.h"
 #include "qapi/error.h"
 
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 38ad3406b32..9febcc10314 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/hcd-ehci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 0449f5fa6d6..b31032bbf39 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/hcd-ehci.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 25c400698ee..bdbbaaa87a3 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -26,7 +26,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/sysbus.h"
 #include "hw/core/qdev-dma.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
 #include "qom/object.h"
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 8224fb88628..350b0118997 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -27,7 +27,7 @@
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/core/qdev-dma.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
 
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 588cecef14d..c771aafdd06 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -34,7 +34,7 @@
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/core/qdev-dma.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
 
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index c243a4f42cc..b2224c7f766 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -32,7 +32,7 @@
 #include "migration/vmstate.h"
 #include "hw/pci/pci.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/iov.h"
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 5fc853eb330..46839911f3f 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -23,7 +23,7 @@
 #include "hw/usb/usb.h"
 #include "qemu/module.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #include "hcd-xhci-pci.h"
 
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index b93c80b09d8..aa570506fc1 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -24,7 +24,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index 862673054a0..19664c5985e 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -8,7 +8,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 292c378bfc9..2cdab3ba0e4 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "qemu/queue.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "trace.h"
 #include "qapi/error.h"
 
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 38893b5e680..b9f3ad3f66d 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -55,7 +55,7 @@
 #include "system/system.h"
 #include "trace.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/usb.h"
 
 /* ------------------------------------------------------------------------ */
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 1a73db68f26..6fd04b7b421 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -41,7 +41,7 @@
 #include <usbredirparser.h>
 #include <usbredirfilter.h>
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/usb/usb.h"
 #include "migration/qemu-file-types.h"
diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
index 783e7f1af0b..196d05a83a5 100644
--- a/hw/usb/u2f-emulated.c
+++ b/hw/usb/u2f-emulated.c
@@ -29,7 +29,7 @@
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/usb/usb.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #include <u2f-emu/u2f-emu.h>
 
diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index b3206fb7fe4..59b5f9829d4 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -28,7 +28,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/usb/xlnx-usb-subsystem.c b/hw/usb/xlnx-usb-subsystem.c
index 98967ef49f1..7193dd4cd2c 100644
--- a/hw/usb/xlnx-usb-subsystem.c
+++ b/hw/usb/xlnx-usb-subsystem.c
@@ -28,7 +28,7 @@
 #include "qemu/bitops.h"
 #include "qom/object.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
 
 static void versal_usb2_realize(DeviceState *dev, Error **errp)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 353d07e7819..64b8b3cb8cf 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -11,7 +11,7 @@
 #include "qapi-visit-sockets.h"
 #include "qemu/error-report.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/vfio/pci.h"
 #include "hw/vfio-user/device.h"
 #include "hw/vfio-user/proxy.h"
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 3368ac89150..e58a0169af9 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -28,7 +28,7 @@
 #include "qemu/config-file.h"
 #include "kvm/kvm_s390x.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/s390x/ap-bridge.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 4d9588e7aa1..2251facb356 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -25,7 +25,7 @@
 #include "system/iommufd.h"
 #include "hw/s390x/s390-ccw.h"
 #include "hw/s390x/vfio-ccw.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/s390x/ccw-device.h"
 #include "system/address-spaces.h"
 #include "qemu/error-report.h"
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index b5da6afbf5b..7b907b9360d 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -23,7 +23,7 @@
 #include "qapi/visitor.h"
 #include <sys/ioctl.h>
 #include "hw/nvram/fw_cfg.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "pci.h"
 #include "pci-quirks.h"
 #include "trace.h"
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b46b1305a7b..6b71605dd97 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -27,7 +27,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "migration/vmstate.h"
diff --git a/hw/virtio/vdpa-dev-pci.c b/hw/virtio/vdpa-dev-pci.c
index 30681121465..c047b0400db 100644
--- a/hw/virtio/vdpa-dev-pci.c
+++ b/hw/virtio/vdpa-dev-pci.c
@@ -19,7 +19,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vdpa-dev.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 57739385a96..3a6de7ebb43 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -20,7 +20,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio.h"
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index 7399acef8e2..a78e13e0381 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "standard-headers/linux/virtio_pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-scsi.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index ff67a020b47..01ab9ca56b1 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-base.h"
 #include "qemu/error-report.h"
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
index 904369f5a3d..20d100f665d 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -22,7 +22,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost-user-blk.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
index 1490c118bca..92ae2fc8a67 100644
--- a/hw/virtio/vhost-user-fs-pci.c
+++ b/hw/virtio/vhost-user-fs-pci.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-user-fs.h"
 #include "hw/virtio/virtio-pci.h"
 #include "qom/object.h"
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index e77c69eb12e..0acd9580b13 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -15,7 +15,7 @@
 #include <sys/ioctl.h>
 #include "standard-headers/linux/virtio_fs.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
diff --git a/hw/virtio/vhost-user-gpio-pci.c b/hw/virtio/vhost-user-gpio-pci.c
index 9b165b54f8f..9bd59e7ae7e 100644
--- a/hw/virtio/vhost-user-gpio-pci.c
+++ b/hw/virtio/vhost-user-gpio-pci.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-user-gpio.h"
 #include "hw/virtio/virtio-pci.h"
 
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index a7fd49b10a3..d473f870778 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-gpio.h"
 #include "standard-headers/linux/virtio_ids.h"
diff --git a/hw/virtio/vhost-user-i2c-pci.c b/hw/virtio/vhost-user-i2c-pci.c
index 692cd66fde6..5ddae8367bb 100644
--- a/hw/virtio/vhost-user-i2c-pci.c
+++ b/hw/virtio/vhost-user-i2c-pci.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-user-i2c.h"
 #include "hw/virtio/virtio-pci.h"
 
diff --git a/hw/virtio/vhost-user-i2c.c b/hw/virtio/vhost-user-i2c.c
index ae007fe97d9..152b1f67401 100644
--- a/hw/virtio/vhost-user-i2c.c
+++ b/hw/virtio/vhost-user-i2c.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-i2c.h"
 #include "qemu/error-report.h"
diff --git a/hw/virtio/vhost-user-rng-pci.c b/hw/virtio/vhost-user-rng-pci.c
index 9f45fc6f355..cc289d0cb36 100644
--- a/hw/virtio/vhost-user-rng-pci.c
+++ b/hw/virtio/vhost-user-rng-pci.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-user-rng.h"
 #include "hw/virtio/virtio-pci.h"
 
diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index 61dadcda054..106c8f211aa 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-rng.h"
 #include "standard-headers/linux/virtio_ids.h"
diff --git a/hw/virtio/vhost-user-scmi-pci.c b/hw/virtio/vhost-user-scmi-pci.c
index 0ab56a50bb3..9a83e1f1ba8 100644
--- a/hw/virtio/vhost-user-scmi-pci.c
+++ b/hw/virtio/vhost-user-scmi-pci.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-user-scmi.h"
 #include "hw/virtio/virtio-pci.h"
 
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index 367b8f27da5..174552eb71b 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -22,7 +22,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/vhost-user-snd-pci.c b/hw/virtio/vhost-user-snd-pci.c
index f5015fb6c4e..90f47bf7a52 100644
--- a/hw/virtio/vhost-user-snd-pci.c
+++ b/hw/virtio/vhost-user-snd-pci.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-user-snd.h"
 #include "hw/virtio/virtio-pci.h"
 
diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 732411c6551..7129b77d9c0 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-snd.h"
 #include "standard-headers/linux/virtio_ids.h"
diff --git a/hw/virtio/vhost-user-test-device-pci.c b/hw/virtio/vhost-user-test-device-pci.c
index b4ed0efb50f..7f6d7516903 100644
--- a/hw/virtio/vhost-user-test-device-pci.c
+++ b/hw/virtio/vhost-user-test-device-pci.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-user-base.h"
 #include "hw/virtio/virtio-pci.h"
 
diff --git a/hw/virtio/vhost-user-test-device.c b/hw/virtio/vhost-user-test-device.c
index 1b98ea3e488..a2f963fdf60 100644
--- a/hw/virtio/vhost-user-test-device.c
+++ b/hw/virtio/vhost-user-test-device.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-base.h"
 #include "qemu/error-report.h"
diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
index adb877b6e05..bac96c96d8a 100644
--- a/hw/virtio/vhost-user-vsock-pci.c
+++ b/hw/virtio/vhost-user-vsock-pci.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/virtio/virtio-pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-user-vsock.h"
 #include "qom/object.h"
 
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index 993c2873482..e20e0aee439 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -12,7 +12,7 @@
 
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/virtio/vhost-user-vsock.h"
 
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index c6c44d8989f..b33def900a7 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -13,7 +13,7 @@
 #include "qapi/error.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qemu/error-report.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "qemu/iov.h"
diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
index 0022a713d43..3a94d06f8c0 100644
--- a/hw/virtio/vhost-vsock-pci.c
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/virtio/virtio-pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 107d88babea..5b60065bdd0 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -17,7 +17,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
 
diff --git a/hw/virtio/virtio-9p-pci.c b/hw/virtio/virtio-9p-pci.c
index 594742ff656..4b501ac2a37 100644
--- a/hw/virtio/virtio-9p-pci.c
+++ b/hw/virtio/virtio-9p-pci.c
@@ -17,7 +17,7 @@
 
 #include "hw/virtio/virtio-pci.h"
 #include "hw/9pfs/virtio-9p.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/module.h"
 #include "qom/object.h"
 
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
index 96e88b6b86d..0bb5931bbcc 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/virtio/virtio-pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-balloon.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index bcf6ab64432..38bf1e84a1d 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -20,7 +20,7 @@
 #include "qemu/madvise.h"
 #include "hw/virtio/virtio.h"
 #include "hw/mem/pc-dimm.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "system/balloon.h"
 #include "system/ramblock.h"
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index fd33bbd7e83..64a434c81b5 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-pci.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 868abc03a9e..7b7dd056169 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-pci.h"
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 517f2089c5a..cbd1810fbc6 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -20,7 +20,7 @@
 
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-crypto.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "system/cryptodev-vhost.h"
 
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index 3be5358b4cd..cd356084606 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/virtio/virtio-pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index dd4100033f1..9d32b8a7b3c 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -13,7 +13,7 @@
 
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-iommu.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 3500f1b0820..4226a676d07 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -23,7 +23,7 @@
 #include "qemu/range.h"
 #include "qemu/reserved-region.h"
 #include "exec/target_page.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "system/kvm.h"
 #include "system/reset.h"
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 5d1d90edc52..41de2ef5a0a 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -28,7 +28,7 @@
 #include "qapi/visitor.h"
 #include "migration/misc.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/acpi/acpi.h"
 #include "trace.h"
 
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index d54d70b4fb8..54bd0c57b5f 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "standard-headers/linux/virtio_mmio.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index f857a84f11c..fd3e0303f5f 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-pci.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio-nsm-pci.c b/hw/virtio/virtio-nsm-pci.c
index ec243963e1e..96e92be1b66 100644
--- a/hw/virtio/virtio-nsm-pci.c
+++ b/hw/virtio/virtio-nsm-pci.c
@@ -12,7 +12,7 @@
 
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-nsm.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7382e7db6fa..b273eb26919 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -25,7 +25,7 @@
 #include "migration/qemu-file-types.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 3416ea1827c..854d08abf6e 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -17,7 +17,7 @@
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
 #include "hw/virtio/virtio-pmem.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_pmem.h"
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
index 39b600356ea..dcea260825f 100644
--- a/hw/virtio/virtio-rng-pci.c
+++ b/hw/virtio/virtio-rng-pci.c
@@ -13,7 +13,7 @@
 
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-rng.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 3df5d2576ec..66690a34dc9 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/virtio/virtio.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-rng.h"
 #include "system/rng.h"
 #include "system/runstate.h"
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index af877592070..fd5102819ad 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -15,7 +15,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "qemu/module.h"
 #include "hw/virtio/virtio-pci.h"
diff --git a/hw/virtio/virtio-serial-pci.c b/hw/virtio/virtio-serial-pci.c
index 3f212ffe52f..6d33d149dfd 100644
--- a/hw/virtio/virtio-serial-pci.c
+++ b/hw/virtio/virtio-serial-pci.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qemu/module.h"
 #include "hw/virtio/virtio-pci.h"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 257cda506a4..5b64eb4d67f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -28,7 +28,7 @@
 #include "migration/qemu-file-types.h"
 #include "qemu/atomic.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "system/dma.h"
 #include "system/iothread.h"
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index ad513d4cbc1..2ebd0f07bd3 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -28,7 +28,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/usb/usb.h"
 #include "hw/arm/boot.h"
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index f1dd7d66eee..90d14e342b0 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -28,7 +28,7 @@
 #include "system/watchdog.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index ce84849df0e..7ade5c6f187 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "system/reset.h"
 #include "system/watchdog.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "qemu/timer.h"
 #include "migration/vmstate.h"
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 30226435efc..930834bfcaf 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "system/watchdog.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "migration/vmstate.h"
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 10151a15d08..c83d4107c19 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "system/watchdog.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 
 #include "hw/watchdog/wdt_imx2.h"
 #include "trace.h"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 6bd2e546f6b..e3c51030f35 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -9,7 +9,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/uuid.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/xen-backend.h"
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index da9a8e5213a..f9b0dd1513d 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -26,7 +26,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/xen/xen-legacy-backend.h"
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 006b5b55f24..c1b92d90cf9 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -58,7 +58,7 @@
 #include <sys/ioctl.h>
 
 #include "hw/pci/pci.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/xen/xen_pt.h"
 #include "hw/xen/xen_igd.h"
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index a96abcd4bdd..a533f2bac3f 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -32,7 +32,7 @@
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "elf.h"
 #include "system/memory.h"
 #include "exec/tswap.h"
diff --git a/net/net.c b/net/net.c
index 8aefdb3424f..4930b573ed3 100644
--- a/net/net.c
+++ b/net/net.c
@@ -27,7 +27,7 @@
 #include "net/net.h"
 #include "clients.h"
 #include "hub.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "net/slirp.h"
 #include "net/eth.h"
 #include "util.h"
diff --git a/system/physmem.c b/system/physmem.c
index ba69be2d082..e3221ce00de 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -37,7 +37,7 @@
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
 #include "hw/core/qdev.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "system/xen.h"
 #include "system/kvm.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index c8773d864d9..8e74e24c190 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -40,7 +40,7 @@
 #include "system/block-backend.h"
 #include "migration/misc.h"
 #include "qemu/cutils.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/clock.h"
 #include "hw/core/boards.h"
 
diff --git a/system/vl.c b/system/vl.c
index 659c6506fc7..2417f82c3ec 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -30,7 +30,7 @@
 #include "qemu/target-info.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 09e89272edc..caf7980b1fc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -34,7 +34,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/target_page.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/core/loader.h"
 #include "hw/core/boards.h"
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index ae84d8e4205..bf303813701 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -31,7 +31,7 @@
 #include "kvm_arm.h"
 #include "hvf_arm.h"
 #include "qapi/visitor.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "internals.h"
 #include "cpu-features.h"
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6871956382f..917db5bb09a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -23,7 +23,7 @@
 #include "cpu.h"
 #include "qemu/module.h"
 #include "qapi/visitor.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qemu/units.h"
 #include "internals.h"
 #include "cpu-features.h"
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a6df71d0205..52237da3ce9 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -26,7 +26,7 @@
 #include "cpu.h"
 #include "disas/dis-asm.h"
 #include "tcg/debug-assert.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "accel/tcg/cpu-ops.h"
 
 static void avr_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index a5a04173ab8..8ac4f49aa3b 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -21,7 +21,7 @@
 #include "internal.h"
 #include "exec/translation-block.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 #include "exec/gdbstub.h"
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index 564c1288e47..eeee62b52a2 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -15,7 +15,7 @@
 #include "system/kvm.h"
 #include "system/xen.h"
 #include "system/address-spaces.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/i386/apic_internal.h"
 #include "cpu-internal.h"
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4216ca9ec1d..fe52538723b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -34,7 +34,7 @@
 #include "qemu/error-report.h"
 #include "qapi/qapi-visit-machine.h"
 #include "standard-headers/asm-x86/kvm_para.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/i386/topology.h"
 #include "exec/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d74c3c3766b..e01e044239b 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -14,7 +14,7 @@
 #include "system/tcg.h"
 #include "system/kvm.h"
 #include "kvm/kvm_loongarch.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "exec/translation-block.h"
 #include "cpu.h"
 #include "cpu-mmu.h"
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 22231f09e60..53649ec6567 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/module.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/gdbstub.h"
 #include "exec/translation-block.h"
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 894799c02c7..f74a9d5f615 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -29,7 +29,7 @@
 #include "qemu/module.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "fpu_helper.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a3b14cceada..929254827d6 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -34,7 +34,7 @@
 #include "qapi/error.h"
 #include "qobject/qnull.h"
 #include "qapi/visitor.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/ppc/ppc.h"
 #include "mmu-book3s-v3.h"
 #include "qemu/cutils.h"
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c8..8f26d8b8b07 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-prop-internal.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f05ce317da1..be99b2ab94c 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -30,7 +30,7 @@
 #include "trace.h"
 #include "qapi/qapi-types-machine.h"
 #include "system/hw_accel.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/resettable.h"
 #include "fpu/softfloat-helpers.h"
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index c9773f15401..bfc6fb9d00d 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -24,7 +24,7 @@
 #include "qemu/qemu-print.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/translation-block.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/visitor.h"
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 33062762a67..8ea362cbb90 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-- 
2.51.1


