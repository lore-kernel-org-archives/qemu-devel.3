Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD85E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 18:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMX4d-0007lo-4u; Sat, 14 Dec 2024 13:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tMX4a-0007l3-4J
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 13:41:04 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tMX4V-0006q2-Qt
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 13:41:03 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so1553517f8f.2
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 10:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734201656; x=1734806456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=1XWMiXr2vQLL/8f8hBJKMNj0ZSLjMK/8Jo8juI3iHLQ=;
 b=itS3pe8G/DhsETfQvUM4hHtc3EQiCqWciD+sgFCuqxizZyUevkfEZhnIpd6nv5FIQz
 hkl7jyYmI1UJs2osTcqV2d36MTun2gAm0SBv+UF97FaOTW7HwAbupKlZ0Xb0Oj/Vz4FV
 fDFW9oM1pBS/B3z2xLeNBgmxLUtgTv/5cCmORjdND4oAM/opmmg7q0u0xEsHR5yI002R
 ESX89c0JB5IgGDPkkfAPp1KubKBSyhSYbPNYXJ5o0qCbaVFBpJ49uMCSonjGlHloGyss
 gGSIEq5sVtSvFqsWl3oF35Z9u1UVcZvV9VSu3KU6j/1Q5TdeJjmSr7vLCbjIUIYRqiDH
 d+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734201656; x=1734806456;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XWMiXr2vQLL/8f8hBJKMNj0ZSLjMK/8Jo8juI3iHLQ=;
 b=LasyWAZ6Y/8LH2jcUUNsz/tBVSRH/1MbjRh1RVNcb5fMyCLDlW6FZ2jIfEFNIZ8wBE
 dwepHjBtlJ88WsW5WOx1sxNuYbMYJF42PlXsw0FATDZ58r2mCkBJzewMc3GjoUptJTfl
 3tWkGrVDYKa2QTfX0pSnPw5R5jOUq0F4pHMs5/XwSzOX40aU20hzkrX1xUK1CyiEiKoS
 hIRaHNuA+7X2FPgwFrqlwkwj3X4GLvcRZYq3LMkRa1K5jHHgqgNJFXRQQTi2eLR/4q/G
 hiXenVZHAXLbXQkOMXRm/Qwxl/zmWW3CRxHN8x08qFDhB/hRJlYC29waQwH6tVtbaIG+
 VS2A==
X-Gm-Message-State: AOJu0YzsFLlxd2lsm186e/iZAXAcz3w7U3W/otoa85gj1oDKr4LuOe+T
 Fjam3czJbf0CbygdHIKm63wRjTolILubHUqYMQuVKcXnvJhAwLz/b3aGwA==
X-Gm-Gg: ASbGncvPZbo+H+b9RXxy0GcJ2dZrl5kVYan5GxstmMy7unLN3oXYv1O0aNaRK7UXR10
 aqDJ/5zlJFxgbHY633BOCgeU71fE+hG+dC9fCkNI3I1tgXSWv67Gn6FaHhlYD2+fBqgKfZ3UInm
 dV+IT8thhIgR99Qq8BB7F3fe+nAZYS9uEbGNvV1utrJxYSMnAGHXADtVamBw4pqeZzEKgpCwcEV
 kDgHnvJERKk0uDdoU2t9lkx0VrHpdGcppOZsxOYjU9d1EPtwVu/
X-Google-Smtp-Source: AGHT+IFzWrMfYl9k5iYCmXWAs1fxJt0X1hzSXiy458e0jbJqWx/TtRTjhEr0mH2QZPLemmjN7+SM2g==
X-Received: by 2002:a05:6000:188c:b0:385:dd10:215d with SMTP id
 ffacd0b85a97d-3888e0b5a34mr6133563f8f.44.1734201655435; 
 Sat, 14 Dec 2024 10:40:55 -0800 (PST)
Received: from [127.0.0.1] ([185.238.219.73]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm3212610f8f.32.2024.12.14.10.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 10:40:55 -0800 (PST)
Date: Sat, 14 Dec 2024 18:40:51 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/71] whole-tree: Constify Property structures
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
Message-ID: <15525622-FE2B-404D-9D4D-2EC8745A763B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 13=2E Dezember 2024 19:06:30 UTC schrieb Richard Henderson <richard=2Eh=
enderson@linaro=2Eorg>:
>Since d36f165d952 (qdev: make properties array "const"), we can
>define our Property structure const=2E  Do this across the entire tree=2E
>
>There are a few other minor changes:
>  - Two instances where it was obvious that an empty property list
>    could be removed entirely=2E  There are other empty lists that
>    probably should be removed, but I didn't look further into usage=2E
>  - In hw/misc/xlnx-versal-trng=2Ec, adjust a Property to use the
>    correct PropertyInfo in the definition, rather than setting
>    it at runtime=2E
>  - One instance where { } was used instead of DEFINE_PROP_END_OF_LIST=2E
>    Not a bug, but wrong style=2E
>
>
>r~
>
>
>Richard Henderson (71):
>  target/arm: Constify all Property
>  target/avr: Constify all Property
>  target/hexagon: Constify all Property
>  target/i386: Constify all Property
>  target/microblaze: Constify all Property
>  target/mips: Constify all Property
>  target/ppc: Remove empty property list
>  target/riscv: Constify all Property
>  target/s390x: Constify all Property
>  target/sparc: Constify all Property and PropertyInfo
>  cpu-target: Constify all Property
>  hw/9pfs: Constify all Property
>  hw/acpi: Constify all Property
>  hw/adc: Constify all Property
>  hw/arm: Constify all Property
>  hw/audio: Constify all Property
>  hw/avr: Constify all Property
>  hw/block/xen-block: Unexport PropertyInfo
>  hw/block: Constify all Property
>  hw/char: Constify all Property
>  hw/core: Constify all Property
>  hw/cpu: Constify all Property
>  hw/cxl: Constify all Property
>  hw/display: Constify all Property
>  hw/dma: Constify all Property
>  hw/gpio: Constify all Property
>  hw/hyperv: Constify all Property
>  hw/i2c: Constify all Property
>  hw/i386: Constify all Property
>  hw/ide: Constify all Property
>  hw/input: Constify all Property
>  hw/intc: Constify all Property
>  hw/ipack: Constify all Property
>  hw/ipmi: Constify all Property
>  hw/isa: Constify all Property
>  hw/m68k: Constify all Property
>  hw/mem: Constify all Property
>  hw/mips: Constify all Property
>  hw/misc/xlnx-versal-trng: Constify trng_props
>  hw/misc: Constify all Property
>  hw/net: Constify all Property
>  hw/nubus: Constify all Property
>  hw/nvme: Constify all Property
>  hw/nvram: Constify all Property
>  hw/pci-bridge: Constify all Property
>  hw/pci-host/astro: Remove empty Property list
>  hw/pci-host: Constify all Property
>  hw/pci: Constify all Property
>  hw/ppc: Constify all Property
>  hw/remote: Constify all Property
>  hw/riscv: Constify all Property
>  hw/rtc: Constify all Property
>  hw/rx: Constify all Property
>  hw/s390x: Constify all Property
>  hw/scsi: Constify all Property
>  hw/sd: Constify all Property
>  hw/sparc: Constify all Property
>  hw/sparc64: Constify all Property
>  hw/ssi: Constify all Property
>  hw/timer: Constify all Property
>  hw/tpm: Constify all Property
>  hw/tricore: Constify all Property
>  hw/ufs: Constify all Property
>  hw/usb: Constify all Property
>  hw/vfio: Constify all Property
>  hw/virtio: Constify all Property
>  hw/watchdog: Constify all Property
>  hw/xen: Constify all Property
>  hw/xen: Use DEFINE_PROP_END_OF_LIST in xen_sysdev_properties
>  tests/unit: Constify all Property
>  docs: Constify all Property in examples
>
> cpu-target=2Ec                           |  2 +-
> hw/9pfs/virtio-9p-device=2Ec             |  2 +-
> hw/acpi/erst=2Ec                         |  2 +-
> hw/acpi/generic_event_device=2Ec         |  2 +-
> hw/acpi/piix4=2Ec                        |  2 +-
> hw/acpi/vmgenid=2Ec                      |  2 +-
> hw/adc/aspeed_adc=2Ec                    |  2 +-
> hw/adc/npcm7xx_adc=2Ec                   |  2 +-
> hw/arm/armsse=2Ec                        |  8 ++++----
> hw/arm/armv7m=2Ec                        |  4 ++--
> hw/arm/aspeed_soc_common=2Ec             |  2 +-
> hw/arm/bcm2836=2Ec                       |  2 +-
> hw/arm/fsl-imx25=2Ec                     |  2 +-
> hw/arm/fsl-imx6=2Ec                      |  2 +-
> hw/arm/fsl-imx6ul=2Ec                    |  2 +-
> hw/arm/fsl-imx7=2Ec                      |  2 +-
> hw/arm/integratorcp=2Ec                  |  2 +-
> hw/arm/msf2-soc=2Ec                      |  2 +-
> hw/arm/npcm7xx=2Ec                       |  2 +-
> hw/arm/nrf51_soc=2Ec                     |  2 +-
> hw/arm/smmu-common=2Ec                   |  2 +-
> hw/arm/smmuv3=2Ec                        |  2 +-
> hw/arm/stellaris=2Ec                     |  2 +-
> hw/arm/strongarm=2Ec                     |  2 +-
> hw/arm/xlnx-versal=2Ec                   |  2 +-
> hw/arm/xlnx-zynqmp=2Ec                   |  2 +-
> hw/audio/ac97=2Ec                        |  2 +-
> hw/audio/adlib=2Ec                       |  2 +-
> hw/audio/asc=2Ec                         |  2 +-
> hw/audio/cs4231a=2Ec                     |  2 +-
> hw/audio/es1370=2Ec                      |  2 +-
> hw/audio/gus=2Ec                         |  2 +-
> hw/audio/hda-codec=2Ec                   |  2 +-
> hw/audio/intel-hda=2Ec                   |  4 ++--
> hw/audio/pcspk=2Ec                       |  2 +-
> hw/audio/pl041=2Ec                       |  2 +-
> hw/audio/sb16=2Ec                        |  2 +-
> hw/audio/via-ac97=2Ec                    |  2 +-
> hw/audio/virtio-snd-pci=2Ec              |  2 +-
> hw/audio/virtio-snd=2Ec                  |  2 +-
> hw/audio/wm8750=2Ec                      |  2 +-
> hw/avr/atmega=2Ec                        |  2 +-
> hw/block/fdc-isa=2Ec                     |  2 +-
> hw/block/fdc-sysbus=2Ec                  |  4 ++--
> hw/block/fdc=2Ec                         |  2 +-
> hw/block/m25p80=2Ec                      |  2 +-
> hw/block/nand=2Ec                        |  2 +-
> hw/block/pflash_cfi01=2Ec                |  2 +-
> hw/block/pflash_cfi02=2Ec                |  2 +-
> hw/block/swim=2Ec                        |  2 +-
> hw/block/vhost-user-blk=2Ec              |  2 +-
> hw/block/virtio-blk=2Ec                  |  2 +-
> hw/block/xen-block=2Ec                   |  4 ++--
> hw/char/avr_usart=2Ec                    |  2 +-
> hw/char/bcm2835_aux=2Ec                  |  2 +-
> hw/char/cadence_uart=2Ec                 |  2 +-
> hw/char/cmsdk-apb-uart=2Ec               |  2 +-
> hw/char/debugcon=2Ec                     |  2 +-
> hw/char/digic-uart=2Ec                   |  2 +-
> hw/char/escc=2Ec                         |  2 +-
> hw/char/exynos4210_uart=2Ec              |  2 +-
> hw/char/goldfish_tty=2Ec                 |  2 +-
> hw/char/grlib_apbuart=2Ec                |  2 +-
> hw/char/ibex_uart=2Ec                    |  2 +-
> hw/char/imx_serial=2Ec                   |  2 +-
> hw/char/ipoctal232=2Ec                   |  2 +-
> hw/char/mcf_uart=2Ec                     |  2 +-
> hw/char/nrf51_uart=2Ec                   |  2 +-
> hw/char/parallel=2Ec                     |  2 +-
> hw/char/pl011=2Ec                        |  2 +-
> hw/char/renesas_sci=2Ec                  |  2 +-
> hw/char/sclpconsole-lm=2Ec               |  2 +-
> hw/char/sclpconsole=2Ec                  |  2 +-
> hw/char/serial-isa=2Ec                   |  2 +-
> hw/char/serial-mm=2Ec                    |  2 +-
> hw/char/serial-pci-multi=2Ec             |  4 ++--
> hw/char/serial-pci=2Ec                   |  2 +-
> hw/char/serial=2Ec                       |  2 +-
> hw/char/sh_serial=2Ec                    |  2 +-
> hw/char/shakti_uart=2Ec                  |  2 +-
> hw/char/sifive_uart=2Ec                  |  2 +-
> hw/char/spapr_vty=2Ec                    |  2 +-
> hw/char/stm32f2xx_usart=2Ec              |  2 +-
> hw/char/stm32l4x5_usart=2Ec              |  2 +-
> hw/char/terminal3270=2Ec                 |  2 +-
> hw/char/virtio-console=2Ec               |  2 +-
> hw/char/virtio-serial-bus=2Ec            |  4 ++--
> hw/char/xen_console=2Ec                  |  2 +-
> hw/char/xilinx_uartlite=2Ec              |  2 +-
> hw/core/generic-loader=2Ec               |  2 +-
> hw/core/guest-loader=2Ec                 |  2 +-
> hw/core/or-irq=2Ec                       |  2 +-
> hw/core/platform-bus=2Ec                 |  2 +-
> hw/core/split-irq=2Ec                    |  2 +-
> hw/cpu/a15mpcore=2Ec                     |  2 +-
> hw/cpu/a9mpcore=2Ec                      |  2 +-
> hw/cpu/arm11mpcore=2Ec                   |  2 +-
> hw/cpu/cluster=2Ec                       |  2 +-
> hw/cpu/realview_mpcore=2Ec               |  2 +-
> hw/cxl/switch-mailbox-cci=2Ec            |  2 +-
> hw/display/artist=2Ec                    |  2 +-
> hw/display/ati=2Ec                       |  2 +-
> hw/display/bcm2835_fb=2Ec                |  2 +-
> hw/display/bochs-display=2Ec             |  2 +-
> hw/display/cg3=2Ec                       |  2 +-
> hw/display/cirrus_vga=2Ec                |  2 +-
> hw/display/cirrus_vga_isa=2Ec            |  2 +-
> hw/display/exynos4210_fimd=2Ec           |  2 +-
> hw/display/g364fb=2Ec                    |  2 +-
> hw/display/i2c-ddc=2Ec                   |  2 +-
> hw/display/macfb=2Ec                     |  4 ++--
> hw/display/pl110=2Ec                     |  2 +-
> hw/display/qxl=2Ec                       |  2 +-
> hw/display/ramfb-standalone=2Ec          |  2 +-
> hw/display/sm501=2Ec                     |  4 ++--
> hw/display/tcx=2Ec                       |  2 +-
> hw/display/vga-isa=2Ec                   |  2 +-
> hw/display/vga-mmio=2Ec                  |  2 +-
> hw/display/vga-pci=2Ec                   |  4 ++--
> hw/display/vhost-user-gpu=2Ec            |  2 +-
> hw/display/virtio-gpu-gl=2Ec             |  2 +-
> hw/display/virtio-gpu-pci=2Ec            |  2 +-
> hw/display/virtio-gpu-rutabaga=2Ec       |  2 +-
> hw/display/virtio-gpu=2Ec                |  2 +-
> hw/display/virtio-vga=2Ec                |  2 +-
> hw/display/vmware_vga=2Ec                |  2 +-
> hw/display/xlnx_dp=2Ec                   |  2 +-
> hw/dma/i82374=2Ec                        |  2 +-
> hw/dma/i8257=2Ec                         |  2 +-
> hw/dma/pl080=2Ec                         |  2 +-
> hw/dma/pl330=2Ec                         |  2 +-
> hw/dma/xilinx_axidma=2Ec                 |  2 +-
> hw/dma/xlnx-zdma=2Ec                     |  2 +-
> hw/dma/xlnx_csu_dma=2Ec                  |  2 +-
> hw/gpio/imx_gpio=2Ec                     |  2 +-
> hw/gpio/npcm7xx_gpio=2Ec                 |  2 +-
> hw/gpio/omap_gpio=2Ec                    |  2 +-
> hw/gpio/pca9552=2Ec                      |  2 +-
> hw/gpio/pca9554=2Ec                      |  2 +-
> hw/gpio/pl061=2Ec                        |  2 +-
> hw/gpio/sifive_gpio=2Ec                  |  2 +-
> hw/gpio/stm32l4x5_gpio=2Ec               |  2 +-
> hw/hyperv/hv-balloon=2Ec                 |  2 +-
> hw/hyperv/syndbg=2Ec                     |  2 +-
> hw/hyperv/vmbus=2Ec                      |  4 ++--
> hw/i2c/aspeed_i2c=2Ec                    |  4 ++--
> hw/i2c/core=2Ec                          |  2 +-
> hw/i2c/i2c_mux_pca954x=2Ec               |  2 +-
> hw/i2c/omap_i2c=2Ec                      |  2 +-
> hw/i386/amd_iommu=2Ec                    |  2 +-
> hw/i386/intel_iommu=2Ec                  |  2 +-
> hw/i386/kvm/clock=2Ec                    |  2 +-
> hw/i386/kvm/i8254=2Ec                    |  2 +-
> hw/i386/kvm/ioapic=2Ec                   |  2 +-
> hw/i386/sgx-epc=2Ec                      |  2 +-
> hw/i386/vmmouse=2Ec                      |  2 +-
> hw/i386/vmport=2Ec                       |  2 +-
> hw/i386/x86-iommu=2Ec                    |  2 +-
> hw/i386/xen/xen_pvdevice=2Ec             |  2 +-
> hw/ide/ahci=2Ec                          |  2 +-
> hw/ide/cf=2Ec                            |  2 +-
> hw/ide/cmd646=2Ec                        |  2 +-
> hw/ide/ide-dev=2Ec                       |  6 +++---
> hw/ide/isa=2Ec                           |  2 +-
> hw/ide/macio=2Ec                         |  2 +-
> hw/ide/mmio=2Ec                          |  2 +-
> hw/input/pckbd=2Ec                       |  4 ++--
> hw/input/stellaris_gamepad=2Ec           |  2 +-
> hw/input/virtio-input-hid=2Ec            |  6 +++---
> hw/input/virtio-input-host=2Ec           |  2 +-
> hw/input/virtio-input=2Ec                |  2 +-
> hw/intc/apic_common=2Ec                  |  2 +-
> hw/intc/arm_gic_common=2Ec               |  2 +-
> hw/intc/arm_gicv2m=2Ec                   |  2 +-
> hw/intc/arm_gicv3_common=2Ec             |  2 +-
> hw/intc/arm_gicv3_its=2Ec                |  2 +-
> hw/intc/arm_gicv3_its_kvm=2Ec            |  2 +-
> hw/intc/armv7m_nvic=2Ec                  |  2 +-
> hw/intc/exynos4210_combiner=2Ec          |  2 +-
> hw/intc/exynos4210_gic=2Ec               |  2 +-
> hw/intc/goldfish_pic=2Ec                 |  2 +-
> hw/intc/grlib_irqmp=2Ec                  |  2 +-
> hw/intc/i8259_common=2Ec                 |  2 +-
> hw/intc/ioapic=2Ec                       |  2 +-
> hw/intc/loongarch_extioi=2Ec             |  2 +-
> hw/intc/loongarch_pch_msi=2Ec            |  2 +-
> hw/intc/loongarch_pch_pic=2Ec            |  2 +-
> hw/intc/loongson_ipi_common=2Ec          |  2 +-
> hw/intc/m68k_irqc=2Ec                    |  2 +-
> hw/intc/mips_gic=2Ec                     |  2 +-
> hw/intc/omap_intc=2Ec                    |  2 +-
> hw/intc/ompic=2Ec                        |  2 +-
> hw/intc/openpic=2Ec                      |  2 +-
> hw/intc/openpic_kvm=2Ec                  |  2 +-
> hw/intc/pnv_xive=2Ec                     |  2 +-
> hw/intc/pnv_xive2=2Ec                    |  2 +-
> hw/intc/ppc-uic=2Ec                      |  2 +-
> hw/intc/riscv_aclint=2Ec                 |  4 ++--
> hw/intc/riscv_aplic=2Ec                  |  2 +-
> hw/intc/riscv_imsic=2Ec                  |  2 +-
> hw/intc/rx_icu=2Ec                       |  2 +-
> hw/intc/s390_flic=2Ec                    |  4 ++--
> hw/intc/sifive_plic=2Ec                  |  2 +-
> hw/intc/spapr_xive=2Ec                   |  2 +-
> hw/intc/xics=2Ec                         |  4 ++--
> hw/intc/xilinx_intc=2Ec                  |  2 +-
> hw/intc/xive=2Ec                         |  8 ++++----
> hw/intc/xive2=2Ec                        |  4 ++--
> hw/intc/xlnx-pmu-iomod-intc=2Ec          |  2 +-
> hw/ipack/ipack=2Ec                       |  2 +-
> hw/ipmi/ipmi=2Ec                         |  2 +-
> hw/ipmi/ipmi_bmc_extern=2Ec              |  2 +-
> hw/ipmi/ipmi_bmc_sim=2Ec                 |  2 +-
> hw/ipmi/isa_ipmi_bt=2Ec                  |  2 +-
> hw/ipmi/isa_ipmi_kcs=2Ec                 |  2 +-
> hw/isa/lpc_ich9=2Ec                      |  2 +-
> hw/isa/pc87312=2Ec                       |  2 +-
> hw/isa/piix=2Ec                          |  2 +-
> hw/m68k/mcf5206=2Ec                      |  2 +-
> hw/m68k/mcf_intc=2Ec                     |  2 +-
> hw/m68k/next-cube=2Ec                    |  2 +-
> hw/m68k/q800-glue=2Ec                    |  2 +-
> hw/mem/cxl_type3=2Ec                     |  2 +-
> hw/mem/nvdimm=2Ec                        |  2 +-
> hw/mem/pc-dimm=2Ec                       |  2 +-
> hw/mem/sparse-mem=2Ec                    |  2 +-
> hw/mips/cps=2Ec                          |  2 +-
> hw/misc/a9scu=2Ec                        |  2 +-
> hw/misc/allwinner-h3-dramc=2Ec           |  2 +-
> hw/misc/allwinner-r40-dramc=2Ec          |  2 +-
> hw/misc/allwinner-sid=2Ec                |  2 +-
> hw/misc/applesmc=2Ec                     |  2 +-
> hw/misc/arm11scu=2Ec                     |  2 +-
> hw/misc/arm_l2x0=2Ec                     |  2 +-
> hw/misc/arm_sysctl=2Ec                   |  2 +-
> hw/misc/armsse-cpuid=2Ec                 |  2 +-
> hw/misc/aspeed_hace=2Ec                  |  2 +-
> hw/misc/aspeed_i3c=2Ec                   |  2 +-
> hw/misc/aspeed_lpc=2Ec                   |  2 +-
> hw/misc/aspeed_sbc=2Ec                   |  2 +-
> hw/misc/aspeed_scu=2Ec                   |  2 +-
> hw/misc/aspeed_sdmc=2Ec                  |  2 +-
> hw/misc/bcm2835_cprman=2Ec               |  2 +-
> hw/misc/bcm2835_property=2Ec             |  2 +-
> hw/misc/debugexit=2Ec                    |  2 +-
> hw/misc/eccmemctl=2Ec                    |  2 +-
> hw/misc/empty_slot=2Ec                   |  2 +-
> hw/misc/iotkit-secctl=2Ec                |  2 +-
> hw/misc/iotkit-sysctl=2Ec                |  2 +-
> hw/misc/iotkit-sysinfo=2Ec               |  2 +-
> hw/misc/ivshmem=2Ec                      |  4 ++--
> hw/misc/led=2Ec                          |  2 +-
> hw/misc/mac_via=2Ec                      |  2 +-
> hw/misc/macio/cuda=2Ec                   |  2 +-
> hw/misc/macio/macio=2Ec                  |  4 ++--
> hw/misc/macio/pmu=2Ec                    |  2 +-
> hw/misc/mips_cmgcr=2Ec                   |  2 +-
> hw/misc/mips_cpc=2Ec                     |  2 +-
> hw/misc/mips_itu=2Ec                     |  2 +-
> hw/misc/mos6522=2Ec                      |  2 +-
> hw/misc/mps2-fpgaio=2Ec                  |  2 +-
> hw/misc/mps2-scc=2Ec                     |  2 +-
> hw/misc/msf2-sysreg=2Ec                  |  2 +-
> hw/misc/npcm7xx_gcr=2Ec                  |  2 +-
> hw/misc/nrf51_rng=2Ec                    |  2 +-
> hw/misc/pci-testdev=2Ec                  |  2 +-
> hw/misc/pvpanic-isa=2Ec                  |  2 +-
> hw/misc/pvpanic-pci=2Ec                  |  2 +-
> hw/misc/sifive_e_aon=2Ec                 |  2 +-
> hw/misc/sifive_u_otp=2Ec                 |  2 +-
> hw/misc/stm32l4x5_rcc=2Ec                |  2 +-
> hw/misc/tz-mpc=2Ec                       |  2 +-
> hw/misc/tz-msc=2Ec                       |  2 +-
> hw/misc/tz-ppc=2Ec                       |  2 +-
> hw/misc/unimp=2Ec                        |  2 +-
> hw/misc/xlnx-versal-cframe-reg=2Ec       |  4 ++--
> hw/misc/xlnx-versal-cfu=2Ec              |  4 ++--
> hw/misc/xlnx-versal-trng=2Ec             |  6 +++---
> hw/misc/xlnx-versal-xramc=2Ec            |  2 +-
> hw/misc/zynq_slcr=2Ec                    |  2 +-
> hw/net/allwinner-sun8i-emac=2Ec          |  2 +-
> hw/net/allwinner_emac=2Ec                |  2 +-
> hw/net/cadence_gem=2Ec                   |  2 +-
> hw/net/can/xlnx-versal-canfd=2Ec         |  2 +-
> hw/net/can/xlnx-zynqmp-can=2Ec           |  2 +-
> hw/net/dp8393x=2Ec                       |  2 +-
> hw/net/e1000=2Ec                         |  2 +-
> hw/net/e1000e=2Ec                        |  2 +-
> hw/net/eepro100=2Ec                      |  2 +-
> hw/net/fsl_etsec/etsec=2Ec               |  2 +-
> hw/net/ftgmac100=2Ec                     |  4 ++--
> hw/net/igb=2Ec                           |  2 +-
> hw/net/imx_fec=2Ec                       |  2 +-
> hw/net/lan9118=2Ec                       |  2 +-
> hw/net/lance=2Ec                         |  2 +-
> hw/net/lasi_i82596=2Ec                   |  2 +-
> hw/net/mcf_fec=2Ec                       |  2 +-
> hw/net/mipsnet=2Ec                       |  2 +-
> hw/net/msf2-emac=2Ec                     |  2 +-
> hw/net/mv88w8618_eth=2Ec                 |  2 +-
> hw/net/ne2000-isa=2Ec                    |  2 +-
> hw/net/ne2000-pci=2Ec                    |  2 +-
> hw/net/npcm7xx_emc=2Ec                   |  2 +-
> hw/net/npcm_gmac=2Ec                     |  2 +-
> hw/net/opencores_eth=2Ec                 |  2 +-
> hw/net/pcnet-pci=2Ec                     |  2 +-
> hw/net/rocker/rocker=2Ec                 |  2 +-
> hw/net/rtl8139=2Ec                       |  2 +-
> hw/net/smc91c111=2Ec                     |  2 +-
> hw/net/spapr_llan=2Ec                    |  2 +-
> hw/net/stellaris_enet=2Ec                |  2 +-
> hw/net/sungem=2Ec                        |  2 +-
> hw/net/sunhme=2Ec                        |  2 +-
> hw/net/tulip=2Ec                         |  2 +-
> hw/net/virtio-net=2Ec                    |  2 +-
> hw/net/vmxnet3=2Ec                       |  2 +-
> hw/net/xen_nic=2Ec                       |  2 +-
> hw/net/xgmac=2Ec                         |  2 +-
> hw/net/xilinx_axienet=2Ec                |  2 +-
> hw/net/xilinx_ethlite=2Ec                |  2 +-
> hw/nubus/nubus-bridge=2Ec                |  2 +-
> hw/nubus/nubus-device=2Ec                |  2 +-
> hw/nvme/ctrl=2Ec                         |  2 +-
> hw/nvme/ns=2Ec                           |  2 +-
> hw/nvme/subsys=2Ec                       |  2 +-
> hw/nvram/ds1225y=2Ec                     |  2 +-
> hw/nvram/eeprom_at24c=2Ec                |  2 +-
> hw/nvram/fw_cfg=2Ec                      |  6 +++---
> hw/nvram/mac_nvram=2Ec                   |  2 +-
> hw/nvram/nrf51_nvm=2Ec                   |  2 +-
> hw/nvram/spapr_nvram=2Ec                 |  2 +-
> hw/nvram/xlnx-bbram=2Ec                  |  2 +-
> hw/nvram/xlnx-efuse=2Ec                  |  2 +-
> hw/nvram/xlnx-versal-efuse-cache=2Ec     |  2 +-
> hw/nvram/xlnx-versal-efuse-ctrl=2Ec      |  2 +-
> hw/nvram/xlnx-zynqmp-efuse=2Ec           |  2 +-
> hw/pci-bridge/cxl_downstream=2Ec         |  2 +-
> hw/pci-bridge/cxl_root_port=2Ec          |  2 +-
> hw/pci-bridge/cxl_upstream=2Ec           |  2 +-
> hw/pci-bridge/gen_pcie_root_port=2Ec     |  2 +-
> hw/pci-bridge/pci_bridge_dev=2Ec         |  2 +-
> hw/pci-bridge/pci_expander_bridge=2Ec    |  4 ++--
> hw/pci-bridge/pcie_pci_bridge=2Ec        |  2 +-
> hw/pci-bridge/pcie_root_port=2Ec         |  2 +-
> hw/pci-bridge/xio3130_downstream=2Ec     |  2 +-
> hw/pci-host/astro=2Ec                    |  5 -----
> hw/pci-host/dino=2Ec                     |  2 +-
> hw/pci-host/gpex=2Ec                     |  2 +-
> hw/pci-host/grackle=2Ec                  |  2 +-
> hw/pci-host/gt64120=2Ec                  |  2 +-
> hw/pci-host/i440fx=2Ec                   |  2 +-
> hw/pci-host/mv64361=2Ec                  |  2 +-
> hw/pci-host/pnv_phb=2Ec                  |  4 ++--
> hw/pci-host/pnv_phb3=2Ec                 |  2 +-
> hw/pci-host/pnv_phb4=2Ec                 |  2 +-
> hw/pci-host/pnv_phb4_pec=2Ec             |  2 +-
> hw/pci-host/ppce500=2Ec                  |  2 +-
> hw/pci-host/q35=2Ec                      |  4 ++--
> hw/pci-host/raven=2Ec                    |  2 +-
> hw/pci-host/sabre=2Ec                    |  2 +-
> hw/pci-host/uninorth=2Ec                 |  2 +-
> hw/pci-host/versatile=2Ec                |  2 +-
> hw/pci-host/xilinx-pcie=2Ec              |  2 +-
> hw/pci/pci=2Ec                           |  2 +-
> hw/pci/pci_bridge=2Ec                    |  2 +-
> hw/pci/pci_host=2Ec                      |  2 +-
> hw/pci/pcie_port=2Ec                     |  4 ++--
> hw/ppc/pnv=2Ec                           |  2 +-
> hw/ppc/pnv_adu=2Ec                       |  2 +-
> hw/ppc/pnv_chiptod=2Ec                   |  2 +-
> hw/ppc/pnv_core=2Ec                      |  4 ++--
> hw/ppc/pnv_homer=2Ec                     |  2 +-
> hw/ppc/pnv_i2c=2Ec                       |  2 +-
> hw/ppc/pnv_lpc=2Ec                       |  2 +-
> hw/ppc/pnv_pnor=2Ec                      |  2 +-
> hw/ppc/pnv_psi=2Ec                       |  2 +-
> hw/ppc/ppc405_uc=2Ec                     |  2 +-
> hw/ppc/ppc440_uc=2Ec                     |  2 +-
> hw/ppc/ppc4xx_devs=2Ec                   |  4 ++--
> hw/ppc/ppc4xx_sdram=2Ec                  |  4 ++--
> hw/ppc/prep_systemio=2Ec                 |  2 +-
> hw/ppc/rs6000_mc=2Ec                     |  2 +-
> hw/ppc/spapr_cpu_core=2Ec                |  2 +-
> hw/ppc/spapr_nvdimm=2Ec                  |  2 +-
> hw/ppc/spapr_pci=2Ec                     |  2 +-
> hw/ppc/spapr_rng=2Ec                     |  2 +-
> hw/ppc/spapr_tpm_proxy=2Ec               |  2 +-
> hw/remote/proxy=2Ec                      |  2 +-
> hw/riscv/opentitan=2Ec                   |  2 +-
> hw/riscv/riscv-iommu-pci=2Ec             |  2 +-
> hw/riscv/riscv-iommu=2Ec                 |  2 +-
> hw/riscv/riscv_hart=2Ec                  |  2 +-
> hw/riscv/sifive_u=2Ec                    |  2 +-
> hw/rtc/allwinner-rtc=2Ec                 |  2 +-
> hw/rtc/goldfish_rtc=2Ec                  |  2 +-
> hw/rtc/m48t59-isa=2Ec                    |  2 +-
> hw/rtc/m48t59=2Ec                        |  2 +-
> hw/rtc/mc146818rtc=2Ec                   |  2 +-
> hw/rtc/pl031=2Ec                         |  2 +-
> hw/rx/rx62n=2Ec                          |  2 +-
> hw/s390x/3270-ccw=2Ec                    |  2 +-
> hw/s390x/ccw-device=2Ec                  |  2 +-
> hw/s390x/css-bridge=2Ec                  |  2 +-
> hw/s390x/ipl=2Ec                         |  2 +-
> hw/s390x/s390-pci-bus=2Ec                |  2 +-
> hw/s390x/s390-skeys=2Ec                  |  2 +-
> hw/s390x/s390-stattrib=2Ec               |  2 +-
> hw/s390x/vhost-scsi-ccw=2Ec              |  2 +-
> hw/s390x/vhost-user-fs-ccw=2Ec           |  2 +-
> hw/s390x/vhost-vsock-ccw=2Ec             |  2 +-
> hw/s390x/virtio-ccw-9p=2Ec               |  2 +-
> hw/s390x/virtio-ccw-balloon=2Ec          |  2 +-
> hw/s390x/virtio-ccw-blk=2Ec              |  2 +-
> hw/s390x/virtio-ccw-crypto=2Ec           |  2 +-
> hw/s390x/virtio-ccw-gpu=2Ec              |  2 +-
> hw/s390x/virtio-ccw-input=2Ec            |  2 +-
> hw/s390x/virtio-ccw-net=2Ec              |  2 +-
> hw/s390x/virtio-ccw-rng=2Ec              |  2 +-
> hw/s390x/virtio-ccw-scsi=2Ec             |  2 +-
> hw/s390x/virtio-ccw-serial=2Ec           |  2 +-
> hw/scsi/megasas=2Ec                      |  6 +++---
> hw/scsi/mptsas=2Ec                       |  2 +-
> hw/scsi/scsi-bus=2Ec                     |  2 +-
> hw/scsi/scsi-disk=2Ec                    |  6 +++---
> hw/scsi/scsi-generic=2Ec                 |  2 +-
> hw/scsi/spapr_vscsi=2Ec                  |  2 +-
> hw/scsi/vhost-scsi=2Ec                   |  2 +-
> hw/scsi/vhost-user-scsi=2Ec              |  2 +-
> hw/scsi/virtio-scsi=2Ec                  |  2 +-
> hw/scsi/vmw_pvscsi=2Ec                   |  2 +-
> hw/sd/allwinner-sdhost=2Ec               |  2 +-
> hw/sd/aspeed_sdhci=2Ec                   |  2 +-
> hw/sd/sd=2Ec                             |  6 +++---
> hw/sd/sdhci-pci=2Ec                      |  2 +-
> hw/sd/sdhci=2Ec                          |  2 +-
> hw/sparc/sun4m=2Ec                       |  2 +-
> hw/sparc/sun4m_iommu=2Ec                 |  2 +-
> hw/sparc64/sun4u=2Ec                     |  6 +++---
> hw/ssi/aspeed_smc=2Ec                    |  4 ++--
> hw/ssi/ibex_spi_host=2Ec                 |  2 +-
> hw/ssi/npcm7xx_fiu=2Ec                   |  2 +-
> hw/ssi/pnv_spi=2Ec                       |  2 +-
> hw/ssi/sifive_spi=2Ec                    |  2 +-
> hw/ssi/ssi=2Ec                           |  2 +-
> hw/ssi/xilinx_spi=2Ec                    |  2 +-
> hw/ssi/xilinx_spips=2Ec                  |  4 ++--
> hw/ssi/xlnx-versal-ospi=2Ec              |  2 +-
> hw/timer/a9gtimer=2Ec                    |  2 +-
> hw/timer/allwinner-a10-pit=2Ec           |  2 +-
> hw/timer/arm_mptimer=2Ec                 |  2 +-
> hw/timer/arm_timer=2Ec                   |  2 +-
> hw/timer/aspeed_timer=2Ec                |  2 +-
> hw/timer/avr_timer16=2Ec                 |  2 +-
> hw/timer/grlib_gptimer=2Ec               |  2 +-
> hw/timer/hpet=2Ec                        |  2 +-
> hw/timer/i8254_common=2Ec                |  2 +-
> hw/timer/ibex_timer=2Ec                  |  2 +-
> hw/timer/mss-timer=2Ec                   |  2 +-
> hw/timer/nrf51_timer=2Ec                 |  2 +-
> hw/timer/pxa2xx_timer=2Ec                |  2 +-
> hw/timer/renesas_cmt=2Ec                 |  2 +-
> hw/timer/renesas_tmr=2Ec                 |  2 +-
> hw/timer/sifive_pwm=2Ec                  |  2 +-
> hw/timer/slavio_timer=2Ec                |  2 +-
> hw/timer/sse-timer=2Ec                   |  2 +-
> hw/timer/stm32f2xx_timer=2Ec             |  2 +-
> hw/timer/xilinx_timer=2Ec                |  2 +-
> hw/tpm/tpm_crb=2Ec                       |  2 +-
> hw/tpm/tpm_spapr=2Ec                     |  2 +-
> hw/tpm/tpm_tis_i2c=2Ec                   |  2 +-
> hw/tpm/tpm_tis_isa=2Ec                   |  2 +-
> hw/tpm/tpm_tis_sysbus=2Ec                |  2 +-
> hw/tricore/tc27x_soc=2Ec                 |  2 +-
> hw/tricore/tricore_testdevice=2Ec        |  2 +-
> hw/ufs/lu=2Ec                            |  2 +-
> hw/ufs/ufs=2Ec                           |  2 +-
> hw/usb/bus=2Ec                           |  2 +-
> hw/usb/canokey=2Ec                       |  2 +-
> hw/usb/ccid-card-emulated=2Ec            |  2 +-
> hw/usb/ccid-card-passthru=2Ec            |  2 +-
> hw/usb/dev-audio=2Ec                     |  2 +-
> hw/usb/dev-hid=2Ec                       |  6 +++---
> hw/usb/dev-hub=2Ec                       |  2 +-
> hw/usb/dev-mtp=2Ec                       |  2 +-
> hw/usb/dev-network=2Ec                   |  2 +-
> hw/usb/dev-serial=2Ec                    |  4 ++--
> hw/usb/dev-smartcard-reader=2Ec          |  4 ++--
> hw/usb/dev-storage-classic=2Ec           |  2 +-
> hw/usb/dev-uas=2Ec                       |  2 +-
> hw/usb/hcd-dwc2=2Ec                      |  2 +-
> hw/usb/hcd-dwc3=2Ec                      |  2 +-
> hw/usb/hcd-ehci-pci=2Ec                  |  2 +-
> hw/usb/hcd-ehci-sysbus=2Ec               |  2 +-
> hw/usb/hcd-ohci-pci=2Ec                  |  2 +-
> hw/usb/hcd-ohci-sysbus=2Ec               |  2 +-
> hw/usb/hcd-uhci=2Ec                      |  4 ++--
> hw/usb/hcd-xhci-nec=2Ec                  |  2 +-
> hw/usb/hcd-xhci-sysbus=2Ec               |  2 +-
> hw/usb/hcd-xhci=2Ec                      |  2 +-
> hw/usb/host-libusb=2Ec                   |  2 +-
> hw/usb/redirect=2Ec                      |  2 +-
> hw/usb/u2f-emulated=2Ec                  |  2 +-
> hw/usb/u2f-passthru=2Ec                  |  2 +-
> hw/vfio/ap=2Ec                           |  2 +-
> hw/vfio/ccw=2Ec                          |  2 +-
> hw/vfio/pci=2Ec                          |  4 ++--
> hw/vfio/platform=2Ec                     |  2 +-
> hw/virtio/vdpa-dev-pci=2Ec               |  2 +-
> hw/virtio/vdpa-dev=2Ec                   |  2 +-
> hw/virtio/vhost-scsi-pci=2Ec             |  2 +-
> hw/virtio/vhost-user-blk-pci=2Ec         |  2 +-
> hw/virtio/vhost-user-device=2Ec          |  2 +-
> hw/virtio/vhost-user-fs-pci=2Ec          |  2 +-
> hw/virtio/vhost-user-fs=2Ec              |  2 +-
> hw/virtio/vhost-user-gpio=2Ec            |  2 +-
> hw/virtio/vhost-user-i2c=2Ec             |  2 +-
> hw/virtio/vhost-user-input=2Ec           |  2 +-
> hw/virtio/vhost-user-rng-pci=2Ec         |  2 +-
> hw/virtio/vhost-user-rng=2Ec             |  2 +-
> hw/virtio/vhost-user-scmi=2Ec            |  2 +-
> hw/virtio/vhost-user-scsi-pci=2Ec        |  2 +-
> hw/virtio/vhost-user-snd-pci=2Ec         |  2 +-
> hw/virtio/vhost-user-snd=2Ec             |  2 +-
> hw/virtio/vhost-user-vsock-pci=2Ec       |  2 +-
> hw/virtio/vhost-user-vsock=2Ec           |  2 +-
> hw/virtio/vhost-vsock-common=2Ec         |  2 +-
> hw/virtio/vhost-vsock-pci=2Ec            |  2 +-
> hw/virtio/vhost-vsock=2Ec                |  2 +-
> hw/virtio/virtio-9p-pci=2Ec              |  2 +-
> hw/virtio/virtio-balloon=2Ec             |  2 +-
> hw/virtio/virtio-blk-pci=2Ec             |  2 +-
> hw/virtio/virtio-crypto-pci=2Ec          |  2 +-
> hw/virtio/virtio-crypto=2Ec              |  2 +-
> hw/virtio/virtio-input-pci=2Ec           |  2 +-
> hw/virtio/virtio-iommu-pci=2Ec           |  2 +-
> hw/virtio/virtio-iommu=2Ec               |  2 +-
> hw/virtio/virtio-mem=2Ec                 |  2 +-
> hw/virtio/virtio-mmio=2Ec                |  2 +-
> hw/virtio/virtio-net-pci=2Ec             |  2 +-
> hw/virtio/virtio-nsm=2Ec                 |  2 +-
> hw/virtio/virtio-pci=2Ec                 |  4 ++--
> hw/virtio/virtio-pmem=2Ec                |  2 +-
> hw/virtio/virtio-rng-pci=2Ec             |  2 +-
> hw/virtio/virtio-rng=2Ec                 |  2 +-
> hw/virtio/virtio-scsi-pci=2Ec            |  2 +-
> hw/virtio/virtio-serial-pci=2Ec          |  2 +-
> hw/virtio/virtio=2Ec                     |  2 +-
> hw/watchdog/sbsa_gwdt=2Ec                |  2 +-
> hw/watchdog/wdt_aspeed=2Ec               |  2 +-
> hw/watchdog/wdt_imx2=2Ec                 |  2 +-
> hw/xen/xen-bus=2Ec                       |  2 +-
> hw/xen/xen-legacy-backend=2Ec            |  6 +++---
> hw/xen/xen_pt=2Ec                        |  2 +-
> target/arm/cpu=2Ec                       | 26 +++++++++++++-------------
> target/arm/cpu64=2Ec                     |  6 +++---
> target/arm/tcg/cpu64=2Ec                 |  2 +-
> target/avr/cpu=2Ec                       |  2 +-
> target/hexagon/cpu=2Ec                   |  2 +-
> target/i386/cpu=2Ec                      |  4 ++--
> target/microblaze/cpu=2Ec                |  2 +-
> target/mips/cpu=2Ec                      |  2 +-
> target/ppc/cpu_init=2Ec                  |  6 ------
> target/riscv/cpu=2Ec                     |  2 +-
> target/s390x/cpu=2Ec                     |  2 +-
> target/sparc/cpu=2Ec                     |  4 ++--
> tests/unit/test-qdev-global-props=2Ec    |  2 +-
> docs/devel/migration/compatibility=2Erst |  4 ++--
> docs/devel/virtio-backends=2Erst         |  2 +-
> 568 files changed, 644 insertions(+), 655 deletions(-)
>

Maybe extend checkpatch to catch these in the future? (Not meant to be a b=
locker)

Best regards,
Bernhard

