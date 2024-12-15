Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF37E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkyq-0005yZ-KO; Sun, 15 Dec 2024 04:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkyp-0005y9-G0
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:32:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkyl-0002BC-MC
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734255117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+MtksixUPVX2kkCumGyzaj7KNgB13QdogcPVlly/bV8=;
 b=IWlVEYNrfAym50/ZdJ8m5tpp6EzO0rZmBbX7mewudIoqHcyEW1pLjFPdb6BZzfEkg4wBBQ
 OvXhHW5YaJD6sfqEYaS6xhakP5BGMbg43GD00+WQDcrFeTBFYrhISLmJni31kLVqaUuivY
 j9BdgyTejKEccn7gimyShWdK9Gw6ouw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-QMx0wMU9NhOJWjpZmhxbMg-1; Sun, 15 Dec 2024 04:31:52 -0500
X-MC-Unique: QMx0wMU9NhOJWjpZmhxbMg-1
X-Mimecast-MFC-AGG-ID: QMx0wMU9NhOJWjpZmhxbMg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d52591d6so1568623f8f.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734255111; x=1734859911;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+MtksixUPVX2kkCumGyzaj7KNgB13QdogcPVlly/bV8=;
 b=jpFTPpdEkg6P/i4TbL0eqySerrP/pwRgCWQU3oKR556j7Gn92g/AKW+d48un7V8f8v
 CDlPsqvulxFzOVp76pd57HUQbqD6puppFBnu0M6rZqyAHxTg4cginyjq4pUhEw+yKQvN
 iERfTyEDzKxH/DldHNuHBdRE3/HVcJ8RBU4yjGLgwJ/FieNjABzaI3N2tGJkkMa4qehi
 bbYUyo1JlpLBKTGTKYSBqTNC0hiGYbpwJ62sS7QxdPSYS+LFewVd5nyqLVfHKPU4iNeZ
 2fI2mb2Myman4wp+RVYkkZ7d/m0LpLUjqmznmx9WlTR9AKeRnh04Nu+iIgitJhwnW8Yd
 0V8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdhUzI0y0dA4EPZuC3w7Ucn3a9ch1xVBMMCPZOU0awtFEFia9HDKRaFiih8k76Jw1L91cFfXb74oB3@nongnu.org
X-Gm-Message-State: AOJu0YzwJbq6ERjjW5yx0iAl7vtZVoA9+h4CBUusnKpn4tDaSS6XPKqw
 3BJbdKdfnLLdO0vws0oA4jZCI1TYh4ABXszBC35uLQM6DwvjZyvfdIROEWzv64Td7XbkXTKUfim
 N6FFWK58NfxBiyDjrFLXG0QVzZf4yFQvnbtbFd4jtkjWz99TuKfgRYKF6r6bV
X-Gm-Gg: ASbGncvbsfABYsqGvZALhh0OYLu/6yjO1KFEeRhIiRUqDxdN2oVnmh8xF49MZowaW5E
 UNf5F2E+5G4460rWDasoPSMqM2AC4tfIxZp6WIFtT0j3yf6ep6VwN+bg4Y2iRfnuUTvyJK+++b2
 qj25QDBtagXYi04G8vlgz42G6cNvxAxOEciPe0UtUg/Ag++lFIP+G+yR/nKMqKQXmsR07vhzFUP
 hx3DcGPJPsCgPDqCah91w2uzep7EG78J37MI4nuYxRaXj5oUryDW1P6gpE=
X-Received: by 2002:a05:6000:682:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-387888051d8mr10299708f8f.15.1734255110407; 
 Sun, 15 Dec 2024 01:31:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQYJG2UWPUoIHAqp05v7GYLsbyTeTwaL0UQZH3j+uHzQHhYblrD5o064pmxqYfmOqOpmHu2g==
X-Received: by 2002:a05:6000:682:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-387888051d8mr10299634f8f.15.1734255108400; 
 Sun, 15 Dec 2024 01:31:48 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-388c801223dsm4857966f8f.3.2024.12.15.01.31.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 01:31:47 -0800 (PST)
Message-ID: <c26046f4-e520-4090-9b82-0310afeb86ef@redhat.com>
Date: Sun, 15 Dec 2024 10:31:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/71] whole-tree: Constify Property structures
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/13/24 20:06, Richard Henderson wrote:
> Since d36f165d952 (qdev: make properties array "const"), we can
> define our Property structure const.  Do this across the entire tree.
> 
> There are a few other minor changes:
>    - Two instances where it was obvious that an empty property list
>      could be removed entirely.  There are other empty lists that
>      probably should be removed, but I didn't look further into usage.
>    - In hw/misc/xlnx-versal-trng.c, adjust a Property to use the
>      correct PropertyInfo in the definition, rather than setting
>      it at runtime.
>    - One instance where { } was used instead of DEFINE_PROP_END_OF_LIST.
>      Not a bug, but wrong style.

Thanks very much!  It's not a lot of memory but it's nice to share these 
across multiple instances of QEMU.

Paolo

> r~
> 
> 
> Richard Henderson (71):
>    target/arm: Constify all Property
>    target/avr: Constify all Property
>    target/hexagon: Constify all Property
>    target/i386: Constify all Property
>    target/microblaze: Constify all Property
>    target/mips: Constify all Property
>    target/ppc: Remove empty property list
>    target/riscv: Constify all Property
>    target/s390x: Constify all Property
>    target/sparc: Constify all Property and PropertyInfo
>    cpu-target: Constify all Property
>    hw/9pfs: Constify all Property
>    hw/acpi: Constify all Property
>    hw/adc: Constify all Property
>    hw/arm: Constify all Property
>    hw/audio: Constify all Property
>    hw/avr: Constify all Property
>    hw/block/xen-block: Unexport PropertyInfo
>    hw/block: Constify all Property
>    hw/char: Constify all Property
>    hw/core: Constify all Property
>    hw/cpu: Constify all Property
>    hw/cxl: Constify all Property
>    hw/display: Constify all Property
>    hw/dma: Constify all Property
>    hw/gpio: Constify all Property
>    hw/hyperv: Constify all Property
>    hw/i2c: Constify all Property
>    hw/i386: Constify all Property
>    hw/ide: Constify all Property
>    hw/input: Constify all Property
>    hw/intc: Constify all Property
>    hw/ipack: Constify all Property
>    hw/ipmi: Constify all Property
>    hw/isa: Constify all Property
>    hw/m68k: Constify all Property
>    hw/mem: Constify all Property
>    hw/mips: Constify all Property
>    hw/misc/xlnx-versal-trng: Constify trng_props
>    hw/misc: Constify all Property
>    hw/net: Constify all Property
>    hw/nubus: Constify all Property
>    hw/nvme: Constify all Property
>    hw/nvram: Constify all Property
>    hw/pci-bridge: Constify all Property
>    hw/pci-host/astro: Remove empty Property list
>    hw/pci-host: Constify all Property
>    hw/pci: Constify all Property
>    hw/ppc: Constify all Property
>    hw/remote: Constify all Property
>    hw/riscv: Constify all Property
>    hw/rtc: Constify all Property
>    hw/rx: Constify all Property
>    hw/s390x: Constify all Property
>    hw/scsi: Constify all Property
>    hw/sd: Constify all Property
>    hw/sparc: Constify all Property
>    hw/sparc64: Constify all Property
>    hw/ssi: Constify all Property
>    hw/timer: Constify all Property
>    hw/tpm: Constify all Property
>    hw/tricore: Constify all Property
>    hw/ufs: Constify all Property
>    hw/usb: Constify all Property
>    hw/vfio: Constify all Property
>    hw/virtio: Constify all Property
>    hw/watchdog: Constify all Property
>    hw/xen: Constify all Property
>    hw/xen: Use DEFINE_PROP_END_OF_LIST in xen_sysdev_properties
>    tests/unit: Constify all Property
>    docs: Constify all Property in examples
> 
>   cpu-target.c                           |  2 +-
>   hw/9pfs/virtio-9p-device.c             |  2 +-
>   hw/acpi/erst.c                         |  2 +-
>   hw/acpi/generic_event_device.c         |  2 +-
>   hw/acpi/piix4.c                        |  2 +-
>   hw/acpi/vmgenid.c                      |  2 +-
>   hw/adc/aspeed_adc.c                    |  2 +-
>   hw/adc/npcm7xx_adc.c                   |  2 +-
>   hw/arm/armsse.c                        |  8 ++++----
>   hw/arm/armv7m.c                        |  4 ++--
>   hw/arm/aspeed_soc_common.c             |  2 +-
>   hw/arm/bcm2836.c                       |  2 +-
>   hw/arm/fsl-imx25.c                     |  2 +-
>   hw/arm/fsl-imx6.c                      |  2 +-
>   hw/arm/fsl-imx6ul.c                    |  2 +-
>   hw/arm/fsl-imx7.c                      |  2 +-
>   hw/arm/integratorcp.c                  |  2 +-
>   hw/arm/msf2-soc.c                      |  2 +-
>   hw/arm/npcm7xx.c                       |  2 +-
>   hw/arm/nrf51_soc.c                     |  2 +-
>   hw/arm/smmu-common.c                   |  2 +-
>   hw/arm/smmuv3.c                        |  2 +-
>   hw/arm/stellaris.c                     |  2 +-
>   hw/arm/strongarm.c                     |  2 +-
>   hw/arm/xlnx-versal.c                   |  2 +-
>   hw/arm/xlnx-zynqmp.c                   |  2 +-
>   hw/audio/ac97.c                        |  2 +-
>   hw/audio/adlib.c                       |  2 +-
>   hw/audio/asc.c                         |  2 +-
>   hw/audio/cs4231a.c                     |  2 +-
>   hw/audio/es1370.c                      |  2 +-
>   hw/audio/gus.c                         |  2 +-
>   hw/audio/hda-codec.c                   |  2 +-
>   hw/audio/intel-hda.c                   |  4 ++--
>   hw/audio/pcspk.c                       |  2 +-
>   hw/audio/pl041.c                       |  2 +-
>   hw/audio/sb16.c                        |  2 +-
>   hw/audio/via-ac97.c                    |  2 +-
>   hw/audio/virtio-snd-pci.c              |  2 +-
>   hw/audio/virtio-snd.c                  |  2 +-
>   hw/audio/wm8750.c                      |  2 +-
>   hw/avr/atmega.c                        |  2 +-
>   hw/block/fdc-isa.c                     |  2 +-
>   hw/block/fdc-sysbus.c                  |  4 ++--
>   hw/block/fdc.c                         |  2 +-
>   hw/block/m25p80.c                      |  2 +-
>   hw/block/nand.c                        |  2 +-
>   hw/block/pflash_cfi01.c                |  2 +-
>   hw/block/pflash_cfi02.c                |  2 +-
>   hw/block/swim.c                        |  2 +-
>   hw/block/vhost-user-blk.c              |  2 +-
>   hw/block/virtio-blk.c                  |  2 +-
>   hw/block/xen-block.c                   |  4 ++--
>   hw/char/avr_usart.c                    |  2 +-
>   hw/char/bcm2835_aux.c                  |  2 +-
>   hw/char/cadence_uart.c                 |  2 +-
>   hw/char/cmsdk-apb-uart.c               |  2 +-
>   hw/char/debugcon.c                     |  2 +-
>   hw/char/digic-uart.c                   |  2 +-
>   hw/char/escc.c                         |  2 +-
>   hw/char/exynos4210_uart.c              |  2 +-
>   hw/char/goldfish_tty.c                 |  2 +-
>   hw/char/grlib_apbuart.c                |  2 +-
>   hw/char/ibex_uart.c                    |  2 +-
>   hw/char/imx_serial.c                   |  2 +-
>   hw/char/ipoctal232.c                   |  2 +-
>   hw/char/mcf_uart.c                     |  2 +-
>   hw/char/nrf51_uart.c                   |  2 +-
>   hw/char/parallel.c                     |  2 +-
>   hw/char/pl011.c                        |  2 +-
>   hw/char/renesas_sci.c                  |  2 +-
>   hw/char/sclpconsole-lm.c               |  2 +-
>   hw/char/sclpconsole.c                  |  2 +-
>   hw/char/serial-isa.c                   |  2 +-
>   hw/char/serial-mm.c                    |  2 +-
>   hw/char/serial-pci-multi.c             |  4 ++--
>   hw/char/serial-pci.c                   |  2 +-
>   hw/char/serial.c                       |  2 +-
>   hw/char/sh_serial.c                    |  2 +-
>   hw/char/shakti_uart.c                  |  2 +-
>   hw/char/sifive_uart.c                  |  2 +-
>   hw/char/spapr_vty.c                    |  2 +-
>   hw/char/stm32f2xx_usart.c              |  2 +-
>   hw/char/stm32l4x5_usart.c              |  2 +-
>   hw/char/terminal3270.c                 |  2 +-
>   hw/char/virtio-console.c               |  2 +-
>   hw/char/virtio-serial-bus.c            |  4 ++--
>   hw/char/xen_console.c                  |  2 +-
>   hw/char/xilinx_uartlite.c              |  2 +-
>   hw/core/generic-loader.c               |  2 +-
>   hw/core/guest-loader.c                 |  2 +-
>   hw/core/or-irq.c                       |  2 +-
>   hw/core/platform-bus.c                 |  2 +-
>   hw/core/split-irq.c                    |  2 +-
>   hw/cpu/a15mpcore.c                     |  2 +-
>   hw/cpu/a9mpcore.c                      |  2 +-
>   hw/cpu/arm11mpcore.c                   |  2 +-
>   hw/cpu/cluster.c                       |  2 +-
>   hw/cpu/realview_mpcore.c               |  2 +-
>   hw/cxl/switch-mailbox-cci.c            |  2 +-
>   hw/display/artist.c                    |  2 +-
>   hw/display/ati.c                       |  2 +-
>   hw/display/bcm2835_fb.c                |  2 +-
>   hw/display/bochs-display.c             |  2 +-
>   hw/display/cg3.c                       |  2 +-
>   hw/display/cirrus_vga.c                |  2 +-
>   hw/display/cirrus_vga_isa.c            |  2 +-
>   hw/display/exynos4210_fimd.c           |  2 +-
>   hw/display/g364fb.c                    |  2 +-
>   hw/display/i2c-ddc.c                   |  2 +-
>   hw/display/macfb.c                     |  4 ++--
>   hw/display/pl110.c                     |  2 +-
>   hw/display/qxl.c                       |  2 +-
>   hw/display/ramfb-standalone.c          |  2 +-
>   hw/display/sm501.c                     |  4 ++--
>   hw/display/tcx.c                       |  2 +-
>   hw/display/vga-isa.c                   |  2 +-
>   hw/display/vga-mmio.c                  |  2 +-
>   hw/display/vga-pci.c                   |  4 ++--
>   hw/display/vhost-user-gpu.c            |  2 +-
>   hw/display/virtio-gpu-gl.c             |  2 +-
>   hw/display/virtio-gpu-pci.c            |  2 +-
>   hw/display/virtio-gpu-rutabaga.c       |  2 +-
>   hw/display/virtio-gpu.c                |  2 +-
>   hw/display/virtio-vga.c                |  2 +-
>   hw/display/vmware_vga.c                |  2 +-
>   hw/display/xlnx_dp.c                   |  2 +-
>   hw/dma/i82374.c                        |  2 +-
>   hw/dma/i8257.c                         |  2 +-
>   hw/dma/pl080.c                         |  2 +-
>   hw/dma/pl330.c                         |  2 +-
>   hw/dma/xilinx_axidma.c                 |  2 +-
>   hw/dma/xlnx-zdma.c                     |  2 +-
>   hw/dma/xlnx_csu_dma.c                  |  2 +-
>   hw/gpio/imx_gpio.c                     |  2 +-
>   hw/gpio/npcm7xx_gpio.c                 |  2 +-
>   hw/gpio/omap_gpio.c                    |  2 +-
>   hw/gpio/pca9552.c                      |  2 +-
>   hw/gpio/pca9554.c                      |  2 +-
>   hw/gpio/pl061.c                        |  2 +-
>   hw/gpio/sifive_gpio.c                  |  2 +-
>   hw/gpio/stm32l4x5_gpio.c               |  2 +-
>   hw/hyperv/hv-balloon.c                 |  2 +-
>   hw/hyperv/syndbg.c                     |  2 +-
>   hw/hyperv/vmbus.c                      |  4 ++--
>   hw/i2c/aspeed_i2c.c                    |  4 ++--
>   hw/i2c/core.c                          |  2 +-
>   hw/i2c/i2c_mux_pca954x.c               |  2 +-
>   hw/i2c/omap_i2c.c                      |  2 +-
>   hw/i386/amd_iommu.c                    |  2 +-
>   hw/i386/intel_iommu.c                  |  2 +-
>   hw/i386/kvm/clock.c                    |  2 +-
>   hw/i386/kvm/i8254.c                    |  2 +-
>   hw/i386/kvm/ioapic.c                   |  2 +-
>   hw/i386/sgx-epc.c                      |  2 +-
>   hw/i386/vmmouse.c                      |  2 +-
>   hw/i386/vmport.c                       |  2 +-
>   hw/i386/x86-iommu.c                    |  2 +-
>   hw/i386/xen/xen_pvdevice.c             |  2 +-
>   hw/ide/ahci.c                          |  2 +-
>   hw/ide/cf.c                            |  2 +-
>   hw/ide/cmd646.c                        |  2 +-
>   hw/ide/ide-dev.c                       |  6 +++---
>   hw/ide/isa.c                           |  2 +-
>   hw/ide/macio.c                         |  2 +-
>   hw/ide/mmio.c                          |  2 +-
>   hw/input/pckbd.c                       |  4 ++--
>   hw/input/stellaris_gamepad.c           |  2 +-
>   hw/input/virtio-input-hid.c            |  6 +++---
>   hw/input/virtio-input-host.c           |  2 +-
>   hw/input/virtio-input.c                |  2 +-
>   hw/intc/apic_common.c                  |  2 +-
>   hw/intc/arm_gic_common.c               |  2 +-
>   hw/intc/arm_gicv2m.c                   |  2 +-
>   hw/intc/arm_gicv3_common.c             |  2 +-
>   hw/intc/arm_gicv3_its.c                |  2 +-
>   hw/intc/arm_gicv3_its_kvm.c            |  2 +-
>   hw/intc/armv7m_nvic.c                  |  2 +-
>   hw/intc/exynos4210_combiner.c          |  2 +-
>   hw/intc/exynos4210_gic.c               |  2 +-
>   hw/intc/goldfish_pic.c                 |  2 +-
>   hw/intc/grlib_irqmp.c                  |  2 +-
>   hw/intc/i8259_common.c                 |  2 +-
>   hw/intc/ioapic.c                       |  2 +-
>   hw/intc/loongarch_extioi.c             |  2 +-
>   hw/intc/loongarch_pch_msi.c            |  2 +-
>   hw/intc/loongarch_pch_pic.c            |  2 +-
>   hw/intc/loongson_ipi_common.c          |  2 +-
>   hw/intc/m68k_irqc.c                    |  2 +-
>   hw/intc/mips_gic.c                     |  2 +-
>   hw/intc/omap_intc.c                    |  2 +-
>   hw/intc/ompic.c                        |  2 +-
>   hw/intc/openpic.c                      |  2 +-
>   hw/intc/openpic_kvm.c                  |  2 +-
>   hw/intc/pnv_xive.c                     |  2 +-
>   hw/intc/pnv_xive2.c                    |  2 +-
>   hw/intc/ppc-uic.c                      |  2 +-
>   hw/intc/riscv_aclint.c                 |  4 ++--
>   hw/intc/riscv_aplic.c                  |  2 +-
>   hw/intc/riscv_imsic.c                  |  2 +-
>   hw/intc/rx_icu.c                       |  2 +-
>   hw/intc/s390_flic.c                    |  4 ++--
>   hw/intc/sifive_plic.c                  |  2 +-
>   hw/intc/spapr_xive.c                   |  2 +-
>   hw/intc/xics.c                         |  4 ++--
>   hw/intc/xilinx_intc.c                  |  2 +-
>   hw/intc/xive.c                         |  8 ++++----
>   hw/intc/xive2.c                        |  4 ++--
>   hw/intc/xlnx-pmu-iomod-intc.c          |  2 +-
>   hw/ipack/ipack.c                       |  2 +-
>   hw/ipmi/ipmi.c                         |  2 +-
>   hw/ipmi/ipmi_bmc_extern.c              |  2 +-
>   hw/ipmi/ipmi_bmc_sim.c                 |  2 +-
>   hw/ipmi/isa_ipmi_bt.c                  |  2 +-
>   hw/ipmi/isa_ipmi_kcs.c                 |  2 +-
>   hw/isa/lpc_ich9.c                      |  2 +-
>   hw/isa/pc87312.c                       |  2 +-
>   hw/isa/piix.c                          |  2 +-
>   hw/m68k/mcf5206.c                      |  2 +-
>   hw/m68k/mcf_intc.c                     |  2 +-
>   hw/m68k/next-cube.c                    |  2 +-
>   hw/m68k/q800-glue.c                    |  2 +-
>   hw/mem/cxl_type3.c                     |  2 +-
>   hw/mem/nvdimm.c                        |  2 +-
>   hw/mem/pc-dimm.c                       |  2 +-
>   hw/mem/sparse-mem.c                    |  2 +-
>   hw/mips/cps.c                          |  2 +-
>   hw/misc/a9scu.c                        |  2 +-
>   hw/misc/allwinner-h3-dramc.c           |  2 +-
>   hw/misc/allwinner-r40-dramc.c          |  2 +-
>   hw/misc/allwinner-sid.c                |  2 +-
>   hw/misc/applesmc.c                     |  2 +-
>   hw/misc/arm11scu.c                     |  2 +-
>   hw/misc/arm_l2x0.c                     |  2 +-
>   hw/misc/arm_sysctl.c                   |  2 +-
>   hw/misc/armsse-cpuid.c                 |  2 +-
>   hw/misc/aspeed_hace.c                  |  2 +-
>   hw/misc/aspeed_i3c.c                   |  2 +-
>   hw/misc/aspeed_lpc.c                   |  2 +-
>   hw/misc/aspeed_sbc.c                   |  2 +-
>   hw/misc/aspeed_scu.c                   |  2 +-
>   hw/misc/aspeed_sdmc.c                  |  2 +-
>   hw/misc/bcm2835_cprman.c               |  2 +-
>   hw/misc/bcm2835_property.c             |  2 +-
>   hw/misc/debugexit.c                    |  2 +-
>   hw/misc/eccmemctl.c                    |  2 +-
>   hw/misc/empty_slot.c                   |  2 +-
>   hw/misc/iotkit-secctl.c                |  2 +-
>   hw/misc/iotkit-sysctl.c                |  2 +-
>   hw/misc/iotkit-sysinfo.c               |  2 +-
>   hw/misc/ivshmem.c                      |  4 ++--
>   hw/misc/led.c                          |  2 +-
>   hw/misc/mac_via.c                      |  2 +-
>   hw/misc/macio/cuda.c                   |  2 +-
>   hw/misc/macio/macio.c                  |  4 ++--
>   hw/misc/macio/pmu.c                    |  2 +-
>   hw/misc/mips_cmgcr.c                   |  2 +-
>   hw/misc/mips_cpc.c                     |  2 +-
>   hw/misc/mips_itu.c                     |  2 +-
>   hw/misc/mos6522.c                      |  2 +-
>   hw/misc/mps2-fpgaio.c                  |  2 +-
>   hw/misc/mps2-scc.c                     |  2 +-
>   hw/misc/msf2-sysreg.c                  |  2 +-
>   hw/misc/npcm7xx_gcr.c                  |  2 +-
>   hw/misc/nrf51_rng.c                    |  2 +-
>   hw/misc/pci-testdev.c                  |  2 +-
>   hw/misc/pvpanic-isa.c                  |  2 +-
>   hw/misc/pvpanic-pci.c                  |  2 +-
>   hw/misc/sifive_e_aon.c                 |  2 +-
>   hw/misc/sifive_u_otp.c                 |  2 +-
>   hw/misc/stm32l4x5_rcc.c                |  2 +-
>   hw/misc/tz-mpc.c                       |  2 +-
>   hw/misc/tz-msc.c                       |  2 +-
>   hw/misc/tz-ppc.c                       |  2 +-
>   hw/misc/unimp.c                        |  2 +-
>   hw/misc/xlnx-versal-cframe-reg.c       |  4 ++--
>   hw/misc/xlnx-versal-cfu.c              |  4 ++--
>   hw/misc/xlnx-versal-trng.c             |  6 +++---
>   hw/misc/xlnx-versal-xramc.c            |  2 +-
>   hw/misc/zynq_slcr.c                    |  2 +-
>   hw/net/allwinner-sun8i-emac.c          |  2 +-
>   hw/net/allwinner_emac.c                |  2 +-
>   hw/net/cadence_gem.c                   |  2 +-
>   hw/net/can/xlnx-versal-canfd.c         |  2 +-
>   hw/net/can/xlnx-zynqmp-can.c           |  2 +-
>   hw/net/dp8393x.c                       |  2 +-
>   hw/net/e1000.c                         |  2 +-
>   hw/net/e1000e.c                        |  2 +-
>   hw/net/eepro100.c                      |  2 +-
>   hw/net/fsl_etsec/etsec.c               |  2 +-
>   hw/net/ftgmac100.c                     |  4 ++--
>   hw/net/igb.c                           |  2 +-
>   hw/net/imx_fec.c                       |  2 +-
>   hw/net/lan9118.c                       |  2 +-
>   hw/net/lance.c                         |  2 +-
>   hw/net/lasi_i82596.c                   |  2 +-
>   hw/net/mcf_fec.c                       |  2 +-
>   hw/net/mipsnet.c                       |  2 +-
>   hw/net/msf2-emac.c                     |  2 +-
>   hw/net/mv88w8618_eth.c                 |  2 +-
>   hw/net/ne2000-isa.c                    |  2 +-
>   hw/net/ne2000-pci.c                    |  2 +-
>   hw/net/npcm7xx_emc.c                   |  2 +-
>   hw/net/npcm_gmac.c                     |  2 +-
>   hw/net/opencores_eth.c                 |  2 +-
>   hw/net/pcnet-pci.c                     |  2 +-
>   hw/net/rocker/rocker.c                 |  2 +-
>   hw/net/rtl8139.c                       |  2 +-
>   hw/net/smc91c111.c                     |  2 +-
>   hw/net/spapr_llan.c                    |  2 +-
>   hw/net/stellaris_enet.c                |  2 +-
>   hw/net/sungem.c                        |  2 +-
>   hw/net/sunhme.c                        |  2 +-
>   hw/net/tulip.c                         |  2 +-
>   hw/net/virtio-net.c                    |  2 +-
>   hw/net/vmxnet3.c                       |  2 +-
>   hw/net/xen_nic.c                       |  2 +-
>   hw/net/xgmac.c                         |  2 +-
>   hw/net/xilinx_axienet.c                |  2 +-
>   hw/net/xilinx_ethlite.c                |  2 +-
>   hw/nubus/nubus-bridge.c                |  2 +-
>   hw/nubus/nubus-device.c                |  2 +-
>   hw/nvme/ctrl.c                         |  2 +-
>   hw/nvme/ns.c                           |  2 +-
>   hw/nvme/subsys.c                       |  2 +-
>   hw/nvram/ds1225y.c                     |  2 +-
>   hw/nvram/eeprom_at24c.c                |  2 +-
>   hw/nvram/fw_cfg.c                      |  6 +++---
>   hw/nvram/mac_nvram.c                   |  2 +-
>   hw/nvram/nrf51_nvm.c                   |  2 +-
>   hw/nvram/spapr_nvram.c                 |  2 +-
>   hw/nvram/xlnx-bbram.c                  |  2 +-
>   hw/nvram/xlnx-efuse.c                  |  2 +-
>   hw/nvram/xlnx-versal-efuse-cache.c     |  2 +-
>   hw/nvram/xlnx-versal-efuse-ctrl.c      |  2 +-
>   hw/nvram/xlnx-zynqmp-efuse.c           |  2 +-
>   hw/pci-bridge/cxl_downstream.c         |  2 +-
>   hw/pci-bridge/cxl_root_port.c          |  2 +-
>   hw/pci-bridge/cxl_upstream.c           |  2 +-
>   hw/pci-bridge/gen_pcie_root_port.c     |  2 +-
>   hw/pci-bridge/pci_bridge_dev.c         |  2 +-
>   hw/pci-bridge/pci_expander_bridge.c    |  4 ++--
>   hw/pci-bridge/pcie_pci_bridge.c        |  2 +-
>   hw/pci-bridge/pcie_root_port.c         |  2 +-
>   hw/pci-bridge/xio3130_downstream.c     |  2 +-
>   hw/pci-host/astro.c                    |  5 -----
>   hw/pci-host/dino.c                     |  2 +-
>   hw/pci-host/gpex.c                     |  2 +-
>   hw/pci-host/grackle.c                  |  2 +-
>   hw/pci-host/gt64120.c                  |  2 +-
>   hw/pci-host/i440fx.c                   |  2 +-
>   hw/pci-host/mv64361.c                  |  2 +-
>   hw/pci-host/pnv_phb.c                  |  4 ++--
>   hw/pci-host/pnv_phb3.c                 |  2 +-
>   hw/pci-host/pnv_phb4.c                 |  2 +-
>   hw/pci-host/pnv_phb4_pec.c             |  2 +-
>   hw/pci-host/ppce500.c                  |  2 +-
>   hw/pci-host/q35.c                      |  4 ++--
>   hw/pci-host/raven.c                    |  2 +-
>   hw/pci-host/sabre.c                    |  2 +-
>   hw/pci-host/uninorth.c                 |  2 +-
>   hw/pci-host/versatile.c                |  2 +-
>   hw/pci-host/xilinx-pcie.c              |  2 +-
>   hw/pci/pci.c                           |  2 +-
>   hw/pci/pci_bridge.c                    |  2 +-
>   hw/pci/pci_host.c                      |  2 +-
>   hw/pci/pcie_port.c                     |  4 ++--
>   hw/ppc/pnv.c                           |  2 +-
>   hw/ppc/pnv_adu.c                       |  2 +-
>   hw/ppc/pnv_chiptod.c                   |  2 +-
>   hw/ppc/pnv_core.c                      |  4 ++--
>   hw/ppc/pnv_homer.c                     |  2 +-
>   hw/ppc/pnv_i2c.c                       |  2 +-
>   hw/ppc/pnv_lpc.c                       |  2 +-
>   hw/ppc/pnv_pnor.c                      |  2 +-
>   hw/ppc/pnv_psi.c                       |  2 +-
>   hw/ppc/ppc405_uc.c                     |  2 +-
>   hw/ppc/ppc440_uc.c                     |  2 +-
>   hw/ppc/ppc4xx_devs.c                   |  4 ++--
>   hw/ppc/ppc4xx_sdram.c                  |  4 ++--
>   hw/ppc/prep_systemio.c                 |  2 +-
>   hw/ppc/rs6000_mc.c                     |  2 +-
>   hw/ppc/spapr_cpu_core.c                |  2 +-
>   hw/ppc/spapr_nvdimm.c                  |  2 +-
>   hw/ppc/spapr_pci.c                     |  2 +-
>   hw/ppc/spapr_rng.c                     |  2 +-
>   hw/ppc/spapr_tpm_proxy.c               |  2 +-
>   hw/remote/proxy.c                      |  2 +-
>   hw/riscv/opentitan.c                   |  2 +-
>   hw/riscv/riscv-iommu-pci.c             |  2 +-
>   hw/riscv/riscv-iommu.c                 |  2 +-
>   hw/riscv/riscv_hart.c                  |  2 +-
>   hw/riscv/sifive_u.c                    |  2 +-
>   hw/rtc/allwinner-rtc.c                 |  2 +-
>   hw/rtc/goldfish_rtc.c                  |  2 +-
>   hw/rtc/m48t59-isa.c                    |  2 +-
>   hw/rtc/m48t59.c                        |  2 +-
>   hw/rtc/mc146818rtc.c                   |  2 +-
>   hw/rtc/pl031.c                         |  2 +-
>   hw/rx/rx62n.c                          |  2 +-
>   hw/s390x/3270-ccw.c                    |  2 +-
>   hw/s390x/ccw-device.c                  |  2 +-
>   hw/s390x/css-bridge.c                  |  2 +-
>   hw/s390x/ipl.c                         |  2 +-
>   hw/s390x/s390-pci-bus.c                |  2 +-
>   hw/s390x/s390-skeys.c                  |  2 +-
>   hw/s390x/s390-stattrib.c               |  2 +-
>   hw/s390x/vhost-scsi-ccw.c              |  2 +-
>   hw/s390x/vhost-user-fs-ccw.c           |  2 +-
>   hw/s390x/vhost-vsock-ccw.c             |  2 +-
>   hw/s390x/virtio-ccw-9p.c               |  2 +-
>   hw/s390x/virtio-ccw-balloon.c          |  2 +-
>   hw/s390x/virtio-ccw-blk.c              |  2 +-
>   hw/s390x/virtio-ccw-crypto.c           |  2 +-
>   hw/s390x/virtio-ccw-gpu.c              |  2 +-
>   hw/s390x/virtio-ccw-input.c            |  2 +-
>   hw/s390x/virtio-ccw-net.c              |  2 +-
>   hw/s390x/virtio-ccw-rng.c              |  2 +-
>   hw/s390x/virtio-ccw-scsi.c             |  2 +-
>   hw/s390x/virtio-ccw-serial.c           |  2 +-
>   hw/scsi/megasas.c                      |  6 +++---
>   hw/scsi/mptsas.c                       |  2 +-
>   hw/scsi/scsi-bus.c                     |  2 +-
>   hw/scsi/scsi-disk.c                    |  6 +++---
>   hw/scsi/scsi-generic.c                 |  2 +-
>   hw/scsi/spapr_vscsi.c                  |  2 +-
>   hw/scsi/vhost-scsi.c                   |  2 +-
>   hw/scsi/vhost-user-scsi.c              |  2 +-
>   hw/scsi/virtio-scsi.c                  |  2 +-
>   hw/scsi/vmw_pvscsi.c                   |  2 +-
>   hw/sd/allwinner-sdhost.c               |  2 +-
>   hw/sd/aspeed_sdhci.c                   |  2 +-
>   hw/sd/sd.c                             |  6 +++---
>   hw/sd/sdhci-pci.c                      |  2 +-
>   hw/sd/sdhci.c                          |  2 +-
>   hw/sparc/sun4m.c                       |  2 +-
>   hw/sparc/sun4m_iommu.c                 |  2 +-
>   hw/sparc64/sun4u.c                     |  6 +++---
>   hw/ssi/aspeed_smc.c                    |  4 ++--
>   hw/ssi/ibex_spi_host.c                 |  2 +-
>   hw/ssi/npcm7xx_fiu.c                   |  2 +-
>   hw/ssi/pnv_spi.c                       |  2 +-
>   hw/ssi/sifive_spi.c                    |  2 +-
>   hw/ssi/ssi.c                           |  2 +-
>   hw/ssi/xilinx_spi.c                    |  2 +-
>   hw/ssi/xilinx_spips.c                  |  4 ++--
>   hw/ssi/xlnx-versal-ospi.c              |  2 +-
>   hw/timer/a9gtimer.c                    |  2 +-
>   hw/timer/allwinner-a10-pit.c           |  2 +-
>   hw/timer/arm_mptimer.c                 |  2 +-
>   hw/timer/arm_timer.c                   |  2 +-
>   hw/timer/aspeed_timer.c                |  2 +-
>   hw/timer/avr_timer16.c                 |  2 +-
>   hw/timer/grlib_gptimer.c               |  2 +-
>   hw/timer/hpet.c                        |  2 +-
>   hw/timer/i8254_common.c                |  2 +-
>   hw/timer/ibex_timer.c                  |  2 +-
>   hw/timer/mss-timer.c                   |  2 +-
>   hw/timer/nrf51_timer.c                 |  2 +-
>   hw/timer/pxa2xx_timer.c                |  2 +-
>   hw/timer/renesas_cmt.c                 |  2 +-
>   hw/timer/renesas_tmr.c                 |  2 +-
>   hw/timer/sifive_pwm.c                  |  2 +-
>   hw/timer/slavio_timer.c                |  2 +-
>   hw/timer/sse-timer.c                   |  2 +-
>   hw/timer/stm32f2xx_timer.c             |  2 +-
>   hw/timer/xilinx_timer.c                |  2 +-
>   hw/tpm/tpm_crb.c                       |  2 +-
>   hw/tpm/tpm_spapr.c                     |  2 +-
>   hw/tpm/tpm_tis_i2c.c                   |  2 +-
>   hw/tpm/tpm_tis_isa.c                   |  2 +-
>   hw/tpm/tpm_tis_sysbus.c                |  2 +-
>   hw/tricore/tc27x_soc.c                 |  2 +-
>   hw/tricore/tricore_testdevice.c        |  2 +-
>   hw/ufs/lu.c                            |  2 +-
>   hw/ufs/ufs.c                           |  2 +-
>   hw/usb/bus.c                           |  2 +-
>   hw/usb/canokey.c                       |  2 +-
>   hw/usb/ccid-card-emulated.c            |  2 +-
>   hw/usb/ccid-card-passthru.c            |  2 +-
>   hw/usb/dev-audio.c                     |  2 +-
>   hw/usb/dev-hid.c                       |  6 +++---
>   hw/usb/dev-hub.c                       |  2 +-
>   hw/usb/dev-mtp.c                       |  2 +-
>   hw/usb/dev-network.c                   |  2 +-
>   hw/usb/dev-serial.c                    |  4 ++--
>   hw/usb/dev-smartcard-reader.c          |  4 ++--
>   hw/usb/dev-storage-classic.c           |  2 +-
>   hw/usb/dev-uas.c                       |  2 +-
>   hw/usb/hcd-dwc2.c                      |  2 +-
>   hw/usb/hcd-dwc3.c                      |  2 +-
>   hw/usb/hcd-ehci-pci.c                  |  2 +-
>   hw/usb/hcd-ehci-sysbus.c               |  2 +-
>   hw/usb/hcd-ohci-pci.c                  |  2 +-
>   hw/usb/hcd-ohci-sysbus.c               |  2 +-
>   hw/usb/hcd-uhci.c                      |  4 ++--
>   hw/usb/hcd-xhci-nec.c                  |  2 +-
>   hw/usb/hcd-xhci-sysbus.c               |  2 +-
>   hw/usb/hcd-xhci.c                      |  2 +-
>   hw/usb/host-libusb.c                   |  2 +-
>   hw/usb/redirect.c                      |  2 +-
>   hw/usb/u2f-emulated.c                  |  2 +-
>   hw/usb/u2f-passthru.c                  |  2 +-
>   hw/vfio/ap.c                           |  2 +-
>   hw/vfio/ccw.c                          |  2 +-
>   hw/vfio/pci.c                          |  4 ++--
>   hw/vfio/platform.c                     |  2 +-
>   hw/virtio/vdpa-dev-pci.c               |  2 +-
>   hw/virtio/vdpa-dev.c                   |  2 +-
>   hw/virtio/vhost-scsi-pci.c             |  2 +-
>   hw/virtio/vhost-user-blk-pci.c         |  2 +-
>   hw/virtio/vhost-user-device.c          |  2 +-
>   hw/virtio/vhost-user-fs-pci.c          |  2 +-
>   hw/virtio/vhost-user-fs.c              |  2 +-
>   hw/virtio/vhost-user-gpio.c            |  2 +-
>   hw/virtio/vhost-user-i2c.c             |  2 +-
>   hw/virtio/vhost-user-input.c           |  2 +-
>   hw/virtio/vhost-user-rng-pci.c         |  2 +-
>   hw/virtio/vhost-user-rng.c             |  2 +-
>   hw/virtio/vhost-user-scmi.c            |  2 +-
>   hw/virtio/vhost-user-scsi-pci.c        |  2 +-
>   hw/virtio/vhost-user-snd-pci.c         |  2 +-
>   hw/virtio/vhost-user-snd.c             |  2 +-
>   hw/virtio/vhost-user-vsock-pci.c       |  2 +-
>   hw/virtio/vhost-user-vsock.c           |  2 +-
>   hw/virtio/vhost-vsock-common.c         |  2 +-
>   hw/virtio/vhost-vsock-pci.c            |  2 +-
>   hw/virtio/vhost-vsock.c                |  2 +-
>   hw/virtio/virtio-9p-pci.c              |  2 +-
>   hw/virtio/virtio-balloon.c             |  2 +-
>   hw/virtio/virtio-blk-pci.c             |  2 +-
>   hw/virtio/virtio-crypto-pci.c          |  2 +-
>   hw/virtio/virtio-crypto.c              |  2 +-
>   hw/virtio/virtio-input-pci.c           |  2 +-
>   hw/virtio/virtio-iommu-pci.c           |  2 +-
>   hw/virtio/virtio-iommu.c               |  2 +-
>   hw/virtio/virtio-mem.c                 |  2 +-
>   hw/virtio/virtio-mmio.c                |  2 +-
>   hw/virtio/virtio-net-pci.c             |  2 +-
>   hw/virtio/virtio-nsm.c                 |  2 +-
>   hw/virtio/virtio-pci.c                 |  4 ++--
>   hw/virtio/virtio-pmem.c                |  2 +-
>   hw/virtio/virtio-rng-pci.c             |  2 +-
>   hw/virtio/virtio-rng.c                 |  2 +-
>   hw/virtio/virtio-scsi-pci.c            |  2 +-
>   hw/virtio/virtio-serial-pci.c          |  2 +-
>   hw/virtio/virtio.c                     |  2 +-
>   hw/watchdog/sbsa_gwdt.c                |  2 +-
>   hw/watchdog/wdt_aspeed.c               |  2 +-
>   hw/watchdog/wdt_imx2.c                 |  2 +-
>   hw/xen/xen-bus.c                       |  2 +-
>   hw/xen/xen-legacy-backend.c            |  6 +++---
>   hw/xen/xen_pt.c                        |  2 +-
>   target/arm/cpu.c                       | 26 +++++++++++++-------------
>   target/arm/cpu64.c                     |  6 +++---
>   target/arm/tcg/cpu64.c                 |  2 +-
>   target/avr/cpu.c                       |  2 +-
>   target/hexagon/cpu.c                   |  2 +-
>   target/i386/cpu.c                      |  4 ++--
>   target/microblaze/cpu.c                |  2 +-
>   target/mips/cpu.c                      |  2 +-
>   target/ppc/cpu_init.c                  |  6 ------
>   target/riscv/cpu.c                     |  2 +-
>   target/s390x/cpu.c                     |  2 +-
>   target/sparc/cpu.c                     |  4 ++--
>   tests/unit/test-qdev-global-props.c    |  2 +-
>   docs/devel/migration/compatibility.rst |  4 ++--
>   docs/devel/virtio-backends.rst         |  2 +-
>   568 files changed, 644 insertions(+), 655 deletions(-)
> 


