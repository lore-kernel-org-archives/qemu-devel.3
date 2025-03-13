Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C8BC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfMy-0001zU-UT; Thu, 13 Mar 2025 06:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfMe-0001xl-G9
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:00:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfMc-00081a-Dq
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:00:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso4500305e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741860029; x=1742464829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yoAlrHUChqgF50xftQwqgV9isB37AtZUJqD9JgAEfBA=;
 b=tJGLeGbPjqLtn4eHBvoHjSDTJA7SqRrFdiQclFtdXXHx3wlCP5/MCmjEAaX4C71gPE
 OODFMU3MO1og9fa6W+YIp1T2bVtQ2seGFJvbPxCyrFqWG//7zCcC8vucSAzetUIzWFUJ
 6PPzUqOu9s/ZK0Sf72EwjzzvzINxLoi4/gOfpi5Hs0DdveDssVAarYVG3hIlVUNSNaTk
 a9ZHe2Cm3aJTPg6P+GToz95z46xTE129JwgI6Et3uJ7JFkAzRL5DSvUZcxVJPhnGyxQo
 jomPPv5brvmWA3GMVbNmaoeV4EvDgsVGvWUcsFedmnQuMznkB0snsnd2i+lQkUL3DulN
 harQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741860029; x=1742464829;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yoAlrHUChqgF50xftQwqgV9isB37AtZUJqD9JgAEfBA=;
 b=kXLDh7HdVKVAQI3Zirzu4yYg79+JcDcuCY6AVdsxK2ZpjJq0yalliTMi5ZJm7bVoEb
 CLtvtl2hW5eNz211bDxaXeCGyAIgWcQN6FcTQKAjh/KUZUHiq0OoOo6R54I7h/54veBC
 h/2oMK309grJSGAP+eQaF3MiK8SzQCbfrYkwZnZVarbTfU9dsUzUkkYkebI1VWdv/Mwc
 K3uLeu/OP68PuPo0g4KLWZB2jho2lyLYch2KWGQ/HEPpkh6anlGFBa+XIk6lFRVGL8CN
 y5Kf3YU/D2KUOjr+kTF/tWBUXLI/YTQn3g0H1cQSUaB3moRHZoR100Qa4NY2qphYkA1I
 YNSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk7oD9EQJQHd6YuYigrlsTXwDS+qJgfzxQdbIu7jhCgL6w9RU7vih/h/LeDEF3s7npMvyVBp843C1v@nongnu.org
X-Gm-Message-State: AOJu0YzNXVrYrVuaq+q93PlD2+VYcGvsUpGvihd5t4Aat2MOLUt2sAVm
 QTtmhXCogxpj2aN1IP2vWpEmArV5dHCAA5BvJZqa2eY80ht6h1tPyQRwv9ZBpgs=
X-Gm-Gg: ASbGncsVkx1X0sMEfuL3dVkkMJlPMT9gT5X32SETj8PVOJ3aoKMxK8AhVB2vkXfXBz1
 sf5ail79XaXN2Ff2e07hbUm4U+WdDtwa9/SpbMrlrVtlSoeKE4ETYCJKOg11gBcq01M6ooWf0FV
 tGHx5zOmGwquzo/eCSX7kgaGLxMvMYd6K1p6nstMMw1fbQw43lFG4rXOlzDHjCkPjCcFwFd5vNc
 ovge2c75oVmvJX5qfX24Ifu4Vaa1EWscQMVlEQAEEw514wT14WA3kGuvOr/Egdc4YlRHpGTJrmc
 AQSTeT+NMPbTFtftUV1YVqkKD5NS5kphhef/ytSR97Fhl51Yi3sjEUlq0pmpQshifvv7IYXaLt9
 toqrXxewyfhedYt4=
X-Google-Smtp-Source: AGHT+IE3A/PTtMhgEDwpVWEkTyrWSGNdtSU1H7YjsnmZDmDE8fyGHwpBpX8f+998BJeaWZegAlY1qA==
X-Received: by 2002:a05:6000:402a:b0:390:e5c6:920 with SMTP id
 ffacd0b85a97d-39132d22aa7mr18333721f8f.3.1741860028624; 
 Thu, 13 Mar 2025 03:00:28 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d031d2c26sm50423415e9.0.2025.03.13.03.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 03:00:28 -0700 (PDT)
Message-ID: <5b8bf976-1487-462f-a2b4-ff7117da97ba@linaro.org>
Date: Thu, 13 Mar 2025 11:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/37] include/system: Move exec/memory.h to
 system/memory.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313034524.3069690-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 13/3/25 04:44, Richard Henderson wrote:
> Convert the existing includes with
> 
>    sed -i ,exec/memory.h,system/memory.h,g
> 
> Move the include within cpu-all.h into a !CONFIG_USER_ONLY block.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/arm/strongarm.h                        | 2 +-
>   hw/display/apple-gfx.h                    | 2 +-
>   hw/display/framebuffer.h                  | 2 +-
>   hw/display/vga_int.h                      | 2 +-
>   hw/hyperv/hv-balloon-our_range_memslots.h | 2 +-
>   hw/intc/ioapic_internal.h                 | 2 +-
>   hw/net/i82596.h                           | 2 +-
>   hw/net/pcnet.h                            | 2 +-
>   hw/tpm/tpm_ppi.h                          | 2 +-
>   hw/usb/hcd-uhci.h                         | 2 +-
>   hw/vfio/pci.h                             | 2 +-
>   hw/virtio/vhost-iova-tree.h               | 2 +-
>   include/exec/cpu-all.h                    | 3 +--
>   include/exec/ioport.h                     | 2 +-
>   include/hw/acpi/acpi.h                    | 2 +-
>   include/hw/acpi/ich9_tco.h                | 2 +-
>   include/hw/arm/fsl-imx25.h                | 2 +-
>   include/hw/arm/fsl-imx31.h                | 2 +-
>   include/hw/arm/fsl-imx6.h                 | 2 +-
>   include/hw/arm/fsl-imx6ul.h               | 2 +-
>   include/hw/arm/omap.h                     | 2 +-
>   include/hw/arm/stm32l4x5_soc.h            | 2 +-
>   include/hw/boards.h                       | 2 +-
>   include/hw/char/parallel.h                | 2 +-
>   include/hw/char/riscv_htif.h              | 2 +-
>   include/hw/char/serial-mm.h               | 2 +-
>   include/hw/char/serial.h                  | 2 +-
>   include/hw/display/macfb.h                | 2 +-
>   include/hw/fsi/aspeed_apb2opb.h           | 2 +-
>   include/hw/fsi/cfam.h                     | 2 +-
>   include/hw/fsi/fsi-master.h               | 2 +-
>   include/hw/fsi/fsi.h                      | 2 +-
>   include/hw/fsi/lbus.h                     | 2 +-
>   include/hw/gpio/npcm7xx_gpio.h            | 2 +-
>   include/hw/i2c/npcm7xx_smbus.h            | 2 +-
>   include/hw/i2c/pm_smbus.h                 | 2 +-
>   include/hw/i386/apic_internal.h           | 2 +-
>   include/hw/i386/x86.h                     | 2 +-
>   include/hw/ide/ahci.h                     | 2 +-
>   include/hw/ipmi/ipmi.h                    | 2 +-
>   include/hw/isa/apm.h                      | 2 +-
>   include/hw/isa/isa.h                      | 2 +-
>   include/hw/m68k/q800.h                    | 2 +-
>   include/hw/mem/npcm7xx_mc.h               | 2 +-
>   include/hw/mem/pc-dimm.h                  | 2 +-
>   include/hw/mips/mips.h                    | 2 +-
>   include/hw/misc/auxbus.h                  | 2 +-
>   include/hw/misc/ivshmem-flat.h            | 2 +-
>   include/hw/misc/mac_via.h                 | 2 +-
>   include/hw/misc/npcm7xx_mft.h             | 2 +-
>   include/hw/misc/npcm_clk.h                | 2 +-
>   include/hw/misc/npcm_gcr.h                | 2 +-
>   include/hw/misc/pvpanic.h                 | 2 +-
>   include/hw/net/dp8393x.h                  | 2 +-
>   include/hw/net/msf2-emac.h                | 2 +-
>   include/hw/nvram/mac_nvram.h              | 2 +-
>   include/hw/nvram/npcm7xx_otp.h            | 2 +-
>   include/hw/pci-host/fsl_imx8m_phy.h       | 2 +-
>   include/hw/pci-host/pam.h                 | 2 +-
>   include/hw/pci-host/remote.h              | 2 +-
>   include/hw/pci/pci.h                      | 2 +-
>   include/hw/pci/pcie_host.h                | 2 +-
>   include/hw/pci/shpc.h                     | 2 +-
>   include/hw/ppc/mac_dbdma.h                | 2 +-
>   include/hw/ppc/pnv_lpc.h                  | 2 +-
>   include/hw/ppc/pnv_occ.h                  | 2 +-
>   include/hw/ppc/pnv_sbe.h                  | 2 +-
>   include/hw/ppc/pnv_xscom.h                | 2 +-
>   include/hw/ppc/ppc4xx.h                   | 2 +-
>   include/hw/ppc/vof.h                      | 2 +-
>   include/hw/ppc/xics.h                     | 2 +-
>   include/hw/register.h                     | 2 +-
>   include/hw/remote/proxy-memory-listener.h | 2 +-
>   include/hw/sh4/sh_intc.h                  | 2 +-
>   include/hw/southbridge/ich9.h             | 2 +-
>   include/hw/sysbus.h                       | 2 +-
>   include/hw/timer/npcm7xx_timer.h          | 2 +-
>   include/hw/tricore/tricore.h              | 2 +-
>   include/hw/usb.h                          | 2 +-
>   include/hw/vfio/vfio-common.h             | 2 +-
>   include/hw/vfio/vfio-container-base.h     | 2 +-
>   include/hw/virtio/vhost-backend.h         | 2 +-
>   include/hw/virtio/vhost.h                 | 2 +-
>   include/hw/virtio/virtio.h                | 2 +-
>   include/hw/xen/xen-pvh-common.h           | 2 +-
>   include/hw/xtensa/mx_pic.h                | 2 +-
>   include/qemu/iova-tree.h                  | 2 +-
>   include/qemu/reserved-region.h            | 2 +-
>   include/system/dma.h                      | 2 +-
>   include/system/hostmem.h                  | 2 +-
>   include/system/kvm_int.h                  | 2 +-
>   include/{exec => system}/memory.h         | 8 ++------
>   include/system/vhost-user-backend.h       | 2 +-
>   migration/rdma.h                          | 2 +-
>   rust/wrapper.h                            | 2 +-
>   target/loongarch/cpu.h                    | 2 +-
>   target/mips/cpu.h                         | 2 +-
>   accel/kvm/kvm-all.c                       | 2 +-
>   accel/tcg/cputlb.c                        | 2 +-
>   backends/tpm/tpm_util.c                   | 2 +-
>   block/blkio.c                             | 4 ++--
>   disas/disas-mon.c                         | 2 +-
>   hw/acpi/erst.c                            | 2 +-
>   hw/avr/atmega.c                           | 2 +-
>   hw/block/fdc-sysbus.c                     | 2 +-
>   hw/core/cpu-system.c                      | 2 +-
>   hw/core/loader-fit.c                      | 2 +-
>   hw/core/loader.c                          | 2 +-
>   hw/display/edid-region.c                  | 2 +-
>   hw/hyperv/hyperv.c                        | 2 +-
>   hw/i386/acpi-common.c                     | 2 +-
>   hw/i386/acpi-microvm.c                    | 2 +-
>   hw/i386/pc_piix.c                         | 2 +-
>   hw/intc/mips_gic.c                        | 2 +-
>   hw/intc/ompic.c                           | 2 +-
>   hw/net/ne2000.c                           | 2 +-
>   hw/pci-bridge/pci_bridge_dev.c            | 2 +-
>   hw/pci-host/remote.c                      | 2 +-
>   hw/ppc/pnv_homer.c                        | 2 +-
>   hw/ppc/sam460ex.c                         | 2 +-
>   hw/remote/iommu.c                         | 2 +-
>   hw/remote/machine.c                       | 2 +-
>   hw/remote/proxy-memory-listener.c         | 2 +-
>   hw/remote/vfio-user-obj.c                 | 2 +-
>   hw/s390x/s390-pci-inst.c                  | 2 +-
>   hw/timer/sh_timer.c                       | 2 +-
>   hw/vfio/common.c                          | 2 +-
>   hw/vfio/container.c                       | 2 +-
>   hw/vfio/platform.c                        | 2 +-
>   hw/xtensa/sim.c                           | 2 +-
>   hw/xtensa/virt.c                          | 2 +-
>   hw/xtensa/xtensa_memory.c                 | 2 +-
>   hw/xtensa/xtfpga.c                        | 2 +-
>   migration/dirtyrate.c                     | 2 +-
>   migration/rdma.c                          | 2 +-
>   migration/savevm.c                        | 2 +-
>   monitor/hmp-cmds-target.c                 | 2 +-
>   stubs/ram-block.c                         | 2 +-
>   system/dirtylimit.c                       | 2 +-
>   system/ioport.c                           | 2 +-
>   system/memory.c                           | 2 +-
>   system/memory_mapping.c                   | 2 +-
>   system/physmem.c                          | 2 +-
>   system/qtest.c                            | 2 +-
>   target/xtensa/cpu.c                       | 2 +-
>   tests/qtest/fuzz/generic_fuzz.c           | 2 +-
>   tests/qtest/fuzz/qos_fuzz.c               | 2 +-
>   tests/unit/test-resv-mem.c                | 2 +-
>   ui/console.c                              | 2 +-
>   util/vfio-helpers.c                       | 2 +-
>   MAINTAINERS                               | 2 +-
>   docs/devel/memory.rst                     | 2 +-
>   scripts/analyze-inclusions                | 2 +-
>   153 files changed, 155 insertions(+), 160 deletions(-)
>   rename include/{exec => system}/memory.h (99%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


