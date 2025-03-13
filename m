Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D04BC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmSr-0003e3-Rg; Thu, 13 Mar 2025 13:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmSf-0003MQ-CL
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:35:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmST-0001kG-IT
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:35:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2239c066347so27422055ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741887300; x=1742492100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=chbPReIHspRZ1BpA9Iz/iTPFS17pxc+EHX8tp/E6cAU=;
 b=j6flU7e+c+XpUz3GPP3rZmKw/oTBzxnRTXnKB0oHqVCs/BCyvWWK+K7hUagtpIuukN
 VomeLl3h8qK1SsBYw2zmHIbQEipksdgLRRMV0oVZz9JDcd0I3yc90hhONkwgHf3PeP7Q
 Z9D2Z+kr2EyUqybrZg0aQ8wt8t3BpJ5ifMk+BE2h3CBLJodZPKbi9/Ii93jKIsZOpv8b
 ZM9WxPdMbGT+HTyF5wvFrg2ueQWXDpsAcfEab95kumFxByFCi8IaLweDQbC9naeSE0++
 LQamsawY7FJCHsmWJKv6d9oFm6y2a9xy/9vY0nl/HRTldt3hkV40aU0JHWMwrHG0C2JB
 WNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741887300; x=1742492100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=chbPReIHspRZ1BpA9Iz/iTPFS17pxc+EHX8tp/E6cAU=;
 b=HUXKVDcoY/zcgk0/TkHYACA1xx4okHLgdtiEYPQr1axQIj/LKbuvV/md01L3sDbpKW
 BbTcd372+LdTuOZs9j3b2P2fN+I0HRbzlj5UFiGQ6J4hbc0NYq5ZPyvfEIFi6/zzfj/t
 EfPf7zwInajXwZWzGTjq1BJ9nknyhu0q3qLhW4xoYSYvAC6OxJ0/sKcaHsaviV+YXmWm
 M5Wv8bYkSLy0MXWMGe9IriK5oF6PE9zyFHE7ECuy1Cfbr2g3Fw77MpXVBbrq7rFWwFOf
 6qbhf7PQScmoxvdIyFOv/n3mKyrQqq/Qw+21Dm8FEh6650uvG6DKwVV68g2aUjFApkTB
 qKrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5cbzgvUjSPZcnBLh8ag0f8xCVbDWPcdOH+sS1EwGe9XHlCAJy4PWTZ+iNJesr3zZZPG+Y/dQFGE70@nongnu.org
X-Gm-Message-State: AOJu0YxRIwdW0caULTvfTOQ5h6bhbhSbg4PXu1aT4to0ytzBf6MLUFQ3
 t7fHUO9uLiYwyxfmC0zVWeAiNVwK+B1kJdSXUCx2uBjJuwmkKsVIm+fWwqYSuFg=
X-Gm-Gg: ASbGncusCP/FAiR4bv6M1w+0RJ67CV2O4uVVqOyHYHJLGJ6Oy/yhATTfw0hPuAWuFDW
 Tdz1dBetClcV4jjc9UCR7STEUxk/jhm4bLxK4N2iKM13NLJGnOm7gOyVrjhI9OFzB72zBzCX/fI
 rIbMMh7+Hhxo4HhkuWIlqLlEDvoqw8kEH+DFxvp3Vr9MoZ9xqe8B5x2O4fM9guoumHaeDHRYGHt
 ou/HNk+QT8wkIMqNNzHok61mKy6kGj81Gpl5na6JaEWPL28zgXAlsGJXezepM3RH60oOvrX+LqF
 RGep/TcqtjRfRNB9ChbZ9B5ZBPaCdsx5Gl281eBfd0CLBJiQndd1PKaJGw==
X-Google-Smtp-Source: AGHT+IGLlUDWeNI4DNl8RWUBt4BTi3DTxRRoJE51BrFK11vQGQbo8Msk+HR8zuLmmU9EIpRxQ+eMJg==
X-Received: by 2002:a17:902:d503:b0:225:ac99:ae0d with SMTP id
 d9443c01a7336-225dd84f059mr4454435ad.10.1741887299667; 
 Thu, 13 Mar 2025 10:34:59 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd4e8dsm15933715ad.228.2025.03.13.10.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:34:59 -0700 (PDT)
Message-ID: <1a84ccdf-a8d4-47f4-ac44-48bd242253fa@linaro.org>
Date: Thu, 13 Mar 2025 10:34:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/37] include/system: Move exec/address-spaces.h to
 system/address-spaces.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
> Convert the existing includes with sed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/net/i82596.h                           | 2 +-
>   hw/s390x/ipl.h                            | 2 +-
>   include/hw/misc/lasi.h                    | 2 +-
>   include/hw/nubus/nubus.h                  | 2 +-
>   include/hw/ppc/vof.h                      | 2 +-
>   include/hw/tricore/triboard.h             | 2 +-
>   include/{exec => system}/address-spaces.h | 8 ++------
>   include/system/dma.h                      | 2 +-
>   rust/wrapper.h                            | 2 +-
>   target/i386/hvf/vmx.h                     | 2 +-
>   accel/hvf/hvf-accel-ops.c                 | 2 +-
>   hw/acpi/erst.c                            | 2 +-
>   hw/arm/aspeed_ast10x0.c                   | 2 +-
>   hw/arm/bananapi_m2u.c                     | 2 +-
>   hw/arm/collie.c                           | 2 +-
>   hw/arm/exynos4_boards.c                   | 2 +-
>   hw/arm/fsl-imx31.c                        | 2 +-
>   hw/arm/fsl-imx8mp.c                       | 2 +-
>   hw/arm/imx8mp-evk.c                       | 2 +-
>   hw/arm/integratorcp.c                     | 2 +-
>   hw/arm/kzm.c                              | 2 +-
>   hw/arm/microbit.c                         | 2 +-
>   hw/arm/mps2-tz.c                          | 2 +-
>   hw/arm/mps2.c                             | 2 +-
>   hw/arm/mps3r.c                            | 2 +-
>   hw/arm/msf2-soc.c                         | 2 +-
>   hw/arm/msf2-som.c                         | 2 +-
>   hw/arm/musca.c                            | 2 +-
>   hw/arm/omap1.c                            | 2 +-
>   hw/arm/omap_sx1.c                         | 2 +-
>   hw/arm/orangepi.c                         | 2 +-
>   hw/arm/stellaris.c                        | 2 +-
>   hw/arm/stm32f100_soc.c                    | 2 +-
>   hw/arm/stm32f205_soc.c                    | 2 +-
>   hw/arm/stm32f405_soc.c                    | 2 +-
>   hw/arm/stm32l4x5_soc.c                    | 2 +-
>   hw/avr/atmega.c                           | 2 +-
>   hw/char/goldfish_tty.c                    | 2 +-
>   hw/char/omap_uart.c                       | 2 +-
>   hw/char/riscv_htif.c                      | 2 +-
>   hw/core/cpu-system.c                      | 2 +-
>   hw/core/null-machine.c                    | 2 +-
>   hw/core/sysbus.c                          | 2 +-
>   hw/dma/rc4030.c                           | 2 +-
>   hw/hyperv/hv-balloon.c                    | 2 +-
>   hw/hyperv/hyperv.c                        | 2 +-
>   hw/i386/kvm/xen_evtchn.c                  | 2 +-
>   hw/i386/kvm/xen_gnttab.c                  | 2 +-
>   hw/i386/kvm/xen_overlay.c                 | 2 +-
>   hw/i386/sgx-epc.c                         | 2 +-
>   hw/i386/sgx.c                             | 2 +-
>   hw/i386/vapic.c                           | 2 +-
>   hw/ide/ahci-sysbus.c                      | 2 +-
>   hw/input/lasips2.c                        | 2 +-
>   hw/intc/loongarch_extioi.c                | 2 +-
>   hw/intc/riscv_aplic.c                     | 2 +-
>   hw/intc/riscv_imsic.c                     | 2 +-
>   hw/loongarch/virt.c                       | 2 +-
>   hw/mem/memory-device.c                    | 2 +-
>   hw/microblaze/petalogix_ml605_mmu.c       | 2 +-
>   hw/microblaze/petalogix_s3adsp1800_mmu.c  | 2 +-
>   hw/microblaze/xlnx-zynqmp-pmu.c           | 2 +-
>   hw/mips/mipssim.c                         | 2 +-
>   hw/misc/allwinner-h3-dramc.c              | 2 +-
>   hw/misc/allwinner-r40-dramc.c             | 2 +-
>   hw/misc/ivshmem-flat.c                    | 2 +-
>   hw/misc/mac_via.c                         | 2 +-
>   hw/net/i82596.c                           | 2 +-
>   hw/nvram/fw_cfg.c                         | 2 +-
>   hw/openrisc/openrisc_sim.c                | 2 +-
>   hw/openrisc/virt.c                        | 2 +-
>   hw/pci-host/mv64361.c                     | 2 +-
>   hw/ppc/pegasos2.c                         | 2 +-
>   hw/ppc/pnv_psi.c                          | 2 +-
>   hw/ppc/ppc405_uc.c                        | 2 +-
>   hw/ppc/ppc4xx_sdram.c                     | 2 +-
>   hw/ppc/prep_systemio.c                    | 2 +-
>   hw/ppc/rs6000_mc.c                        | 2 +-
>   hw/ppc/spapr_ovec.c                       | 2 +-
>   hw/ppc/vof.c                              | 2 +-
>   hw/remote/iommu.c                         | 2 +-
>   hw/riscv/microblaze-v-generic.c           | 2 +-
>   hw/riscv/opentitan.c                      | 2 +-
>   hw/riscv/shakti_c.c                       | 2 +-
>   hw/s390x/css.c                            | 2 +-
>   hw/s390x/s390-skeys.c                     | 2 +-
>   hw/s390x/virtio-ccw.c                     | 2 +-
>   hw/sparc/sun4m_iommu.c                    | 2 +-
>   hw/sparc64/sun4u_iommu.c                  | 2 +-
>   hw/timer/hpet.c                           | 2 +-
>   hw/tpm/tpm_crb.c                          | 2 +-
>   hw/vfio/ap.c                              | 2 +-
>   hw/vfio/ccw.c                             | 2 +-
>   hw/vfio/common.c                          | 2 +-
>   hw/vfio/container.c                       | 2 +-
>   hw/vfio/platform.c                        | 2 +-
>   hw/vfio/spapr.c                           | 2 +-
>   hw/virtio/vhost-vdpa.c                    | 2 +-
>   hw/virtio/virtio-balloon.c                | 2 +-
>   hw/virtio/virtio-bus.c                    | 2 +-
>   monitor/hmp-cmds-target.c                 | 2 +-
>   monitor/hmp-cmds.c                        | 2 +-
>   system/ioport.c                           | 2 +-
>   system/memory.c                           | 2 +-
>   system/memory_mapping.c                   | 2 +-
>   target/arm/hvf/hvf.c                      | 2 +-
>   target/arm/kvm.c                          | 2 +-
>   target/avr/helper.c                       | 2 +-
>   target/i386/cpu-apic.c                    | 2 +-
>   target/i386/cpu.c                         | 2 +-
>   target/i386/kvm/xen-emu.c                 | 2 +-
>   target/i386/nvmm/nvmm-all.c               | 2 +-
>   target/i386/sev.c                         | 2 +-
>   target/i386/tcg/system/misc_helper.c      | 2 +-
>   target/i386/tcg/system/tcg-cpu.c          | 2 +-
>   target/i386/whpx/whpx-all.c               | 2 +-
>   target/loongarch/kvm/kvm.c                | 2 +-
>   target/riscv/kvm/kvm-cpu.c                | 2 +-
>   target/s390x/mmu_helper.c                 | 2 +-
>   target/s390x/sigp.c                       | 2 +-
>   target/s390x/tcg/excp_helper.c            | 2 +-
>   target/xtensa/dbg_helper.c                | 2 +-
>   hw/display/apple-gfx.m                    | 2 +-
>   123 files changed, 124 insertions(+), 128 deletions(-)
>   rename include/{exec => system}/address-spaces.h (89%)
> 
> diff --git a/hw/net/i82596.h b/hw/net/i82596.h
> index 4bdfcaf856..dc1fa1a1dc 100644
> --- a/hw/net/i82596.h
> +++ b/hw/net/i82596.h
> @@ -4,7 +4,7 @@
>   #define I82596_IOPORT_SIZE       0x20
>   
>   #include "system/memory.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   #define PORT_RESET              0x00    /* reset 82596 */
>   #define PORT_SELFTEST           0x01    /* selftest */
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 8e3882d506..c6ecb3433c 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -14,7 +14,7 @@
>   #define HW_S390_IPL_H
>   
>   #include "cpu.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/qdev-core.h"
>   #include "hw/s390x/ipl/qipl.h"
>   #include "qom/object.h"
> diff --git a/include/hw/misc/lasi.h b/include/hw/misc/lasi.h
> index f01c0f680a..0bdfb11b50 100644
> --- a/include/hw/misc/lasi.h
> +++ b/include/hw/misc/lasi.h
> @@ -12,7 +12,7 @@
>   #ifndef LASI_H
>   #define LASI_H
>   
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/pci/pci_host.h"
>   #include "hw/boards.h"
>   
> diff --git a/include/hw/nubus/nubus.h b/include/hw/nubus/nubus.h
> index fee79b71d1..7825840dca 100644
> --- a/include/hw/nubus/nubus.h
> +++ b/include/hw/nubus/nubus.h
> @@ -11,7 +11,7 @@
>   
>   #include "hw/qdev-properties.h"
>   #include "hw/sysbus.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qom/object.h"
>   #include "qemu/units.h"
>   
> diff --git a/include/hw/ppc/vof.h b/include/hw/ppc/vof.h
> index 2918aaab12..3a0fbffe54 100644
> --- a/include/hw/ppc/vof.h
> +++ b/include/hw/ppc/vof.h
> @@ -7,7 +7,7 @@
>   #define HW_VOF_H
>   
>   #include "qom/object.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/memory.h"
>   #include "exec/cpu-defs.h"
>   
> diff --git a/include/hw/tricore/triboard.h b/include/hw/tricore/triboard.h
> index 8250470643..ca49a0c752 100644
> --- a/include/hw/tricore/triboard.h
> +++ b/include/hw/tricore/triboard.h
> @@ -21,7 +21,7 @@
>   #include "qapi/error.h"
>   #include "hw/boards.h"
>   #include "system/system.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qom/object.h"
>   
>   #include "hw/tricore/tc27x_soc.h"
> diff --git a/include/exec/address-spaces.h b/include/system/address-spaces.h
> similarity index 89%
> rename from include/exec/address-spaces.h
> rename to include/system/address-spaces.h
> index 0d0aa61d68..72d17afb0f 100644
> --- a/include/exec/address-spaces.h
> +++ b/include/system/address-spaces.h
> @@ -11,16 +11,14 @@
>    *
>    */
>   
> -#ifndef EXEC_ADDRESS_SPACES_H
> -#define EXEC_ADDRESS_SPACES_H
> +#ifndef SYSTEM_ADDRESS_SPACES_H
> +#define SYSTEM_ADDRESS_SPACES_H
>   
>   /*
>    * Internal interfaces between memory.c/exec.c/vl.c.  Do not #include unless
>    * you're one of them.
>    */
>   
> -#ifndef CONFIG_USER_ONLY
> -
>   /* Get the root memory region.  This interface should only be used temporarily
>    * until a proper bus interface is available.
>    */
> @@ -35,5 +33,3 @@ extern AddressSpace address_space_memory;
>   extern AddressSpace address_space_io;
>   
>   #endif
> -
> -#endif
> diff --git a/include/system/dma.h b/include/system/dma.h
> index 0a2f0ad2dd..7178d4f610 100644
> --- a/include/system/dma.h
> +++ b/include/system/dma.h
> @@ -11,7 +11,7 @@
>   #define DMA_H
>   
>   #include "system/memory.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "block/block.h"
>   #include "block/accounting.h"
>   
> diff --git a/rust/wrapper.h b/rust/wrapper.h
> index 3bc4a6c899..f80dbab24f 100644
> --- a/rust/wrapper.h
> +++ b/rust/wrapper.h
> @@ -64,4 +64,4 @@ typedef enum memory_order {
>   #include "chardev/char-serial.h"
>   #include "exec/memattrs.h"
>   #include "qemu/timer.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
> diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
> index 80ce26279b..87a478f7fd 100644
> --- a/target/i386/hvf/vmx.h
> +++ b/target/i386/hvf/vmx.h
> @@ -33,7 +33,7 @@
>   #include "system/hvf.h"
>   #include "system/hvf_int.h"
>   
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   static inline uint64_t rreg(hv_vcpuid_t vcpu, hv_x86_reg_t reg)
>   {
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index 12fc30c276..601c3bc0ac 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -50,7 +50,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "exec/exec-all.h"
>   #include "gdbstub/enums.h"
>   #include "hw/boards.h"
> diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
> index 5c4c1dc638..2e49b551f2 100644
> --- a/hw/acpi/erst.c
> +++ b/hw/acpi/erst.c
> @@ -23,7 +23,7 @@
>   #include "hw/acpi/acpi-defs.h"
>   #include "hw/acpi/aml-build.h"
>   #include "hw/acpi/bios-linker-loader.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/hostmem.h"
>   #include "hw/acpi/erst.h"
>   #include "trace.h"
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index ec329f4991..21ffab10f3 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -11,7 +11,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/system.h"
>   #include "hw/qdev-clock.h"
>   #include "hw/misc/unimp.h"
> diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
> index 4d84d10d24..b750a575f7 100644
> --- a/hw/arm/bananapi_m2u.c
> +++ b/hw/arm/bananapi_m2u.c
> @@ -19,7 +19,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "hw/boards.h"
> diff --git a/hw/arm/collie.c b/hw/arm/collie.c
> index eaa5c52d45..e83aee58c6 100644
> --- a/hw/arm/collie.c
> +++ b/hw/arm/collie.c
> @@ -16,7 +16,7 @@
>   #include "strongarm.h"
>   #include "hw/arm/boot.h"
>   #include "hw/block/flash.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qom/object.h"
>   #include "qemu/error-report.h"
>   
> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> index 43dc89d902..2d8f2d7326 100644
> --- a/hw/arm/exynos4_boards.c
> +++ b/hw/arm/exynos4_boards.c
> @@ -28,7 +28,7 @@
>   #include "hw/sysbus.h"
>   #include "net/net.h"
>   #include "hw/arm/boot.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/arm/exynos4210.h"
>   #include "hw/net/lan9118.h"
>   #include "hw/qdev-properties.h"
> diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
> index 9de0f2148f..2a8ffb15f7 100644
> --- a/hw/arm/fsl-imx31.c
> +++ b/hw/arm/fsl-imx31.c
> @@ -23,7 +23,7 @@
>   #include "qapi/error.h"
>   #include "hw/arm/fsl-imx31.h"
>   #include "system/system.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/qdev-properties.h"
>   #include "chardev/char.h"
>   #include "target/arm/cpu-qom.h"
> diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> index 1ea98e1463..0b19e071cf 100644
> --- a/hw/arm/fsl-imx8mp.c
> +++ b/hw/arm/fsl-imx8mp.c
> @@ -9,7 +9,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/arm/bsa.h"
>   #include "hw/arm/fsl-imx8mp.h"
>   #include "hw/intc/arm_gicv3.h"
> diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
> index e1a7892fd7..6e64ec4ea5 100644
> --- a/hw/arm/imx8mp-evk.c
> +++ b/hw/arm/imx8mp-evk.c
> @@ -7,7 +7,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/arm/boot.h"
>   #include "hw/arm/fsl-imx8mp.h"
>   #include "hw/boards.h"
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index 8aa2e6e98e..ac0c6c6096 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -16,7 +16,7 @@
>   #include "hw/misc/arm_integrator_debug.h"
>   #include "hw/net/smc91c111.h"
>   #include "net/net.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/runstate.h"
>   #include "system/system.h"
>   #include "qemu/log.h"
> diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
> index 08d2b3025c..362c145409 100644
> --- a/hw/arm/kzm.c
> +++ b/hw/arm/kzm.c
> @@ -19,7 +19,7 @@
>   #include "hw/arm/boot.h"
>   #include "hw/boards.h"
>   #include "qemu/error-report.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "net/net.h"
>   #include "hw/net/lan9118.h"
>   #include "hw/char/serial-mm.h"
> diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
> index 3f56fb45ce..ade363daaa 100644
> --- a/hw/arm/microbit.c
> +++ b/hw/arm/microbit.c
> @@ -13,7 +13,7 @@
>   #include "hw/boards.h"
>   #include "hw/arm/boot.h"
>   #include "system/system.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   #include "hw/arm/nrf51_soc.h"
>   #include "hw/i2c/microbit_i2c.h"
> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
> index 13ed868b6b..b0633a5a69 100644
> --- a/hw/arm/mps2-tz.c
> +++ b/hw/arm/mps2-tz.c
> @@ -54,7 +54,7 @@
>   #include "hw/arm/armv7m.h"
>   #include "hw/or-irq.h"
>   #include "hw/boards.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/system.h"
>   #include "system/reset.h"
>   #include "hw/misc/unimp.h"
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index 3f8db0cab6..6958485a66 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c
> @@ -33,7 +33,7 @@
>   #include "hw/arm/armv7m.h"
>   #include "hw/or-irq.h"
>   #include "hw/boards.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/system.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/misc/unimp.h"
> diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
> index 1bddb5e822..4dd1e8a718 100644
> --- a/hw/arm/mps3r.c
> +++ b/hw/arm/mps3r.c
> @@ -28,7 +28,7 @@
>   #include "qemu/units.h"
>   #include "qapi/error.h"
>   #include "qobject/qlist.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "cpu.h"
>   #include "system/system.h"
>   #include "hw/boards.h"
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index e8a5b231ba..bc9b419e37 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -25,7 +25,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
>   #include "qapi/error.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/char/serial-mm.h"
>   #include "hw/arm/msf2-soc.h"
>   #include "hw/misc/unimp.h"
> diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
> index 9b20f1e2c9..29c76c6860 100644
> --- a/hw/arm/msf2-som.c
> +++ b/hw/arm/msf2-som.c
> @@ -33,7 +33,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/arm/boot.h"
>   #include "hw/qdev-clock.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/arm/msf2-soc.h"
>   
>   #define DDR_BASE_ADDRESS      0xA0000000
> diff --git a/hw/arm/musca.c b/hw/arm/musca.c
> index e9c092abc3..a4f43f1992 100644
> --- a/hw/arm/musca.c
> +++ b/hw/arm/musca.c
> @@ -22,7 +22,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/system.h"
>   #include "hw/arm/boot.h"
>   #include "hw/arm/armsse.h"
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index 3ee10b4777..91d7e3f04b 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -23,7 +23,7 @@
>   #include "qemu/main-loop.h"
>   #include "qapi/error.h"
>   #include "cpu.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/hw.h"
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
> diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
> index 24b4043183..aa1e96b3ad 100644
> --- a/hw/arm/omap_sx1.c
> +++ b/hw/arm/omap_sx1.c
> @@ -34,7 +34,7 @@
>   #include "hw/arm/boot.h"
>   #include "hw/block/flash.h"
>   #include "system/qtest.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qemu/cutils.h"
>   #include "qemu/error-report.h"
>   
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index 634af9b0a1..e0956880d1 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -19,7 +19,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "hw/boards.h"
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 3361111360..cbe914c93e 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -20,7 +20,7 @@
>   #include "net/net.h"
>   #include "hw/boards.h"
>   #include "qemu/log.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/system.h"
>   #include "hw/arm/armv7m.h"
>   #include "hw/char/pl011.h"
> diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
> index 53b5636452..0eabaf8d9b 100644
> --- a/hw/arm/stm32f100_soc.c
> +++ b/hw/arm/stm32f100_soc.c
> @@ -27,7 +27,7 @@
>   #include "qapi/error.h"
>   #include "qemu/module.h"
>   #include "hw/arm/boot.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/arm/stm32f100_soc.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-clock.h"
> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
> index 47a54e592b..32e96912f0 100644
> --- a/hw/arm/stm32f205_soc.c
> +++ b/hw/arm/stm32f205_soc.c
> @@ -26,7 +26,7 @@
>   #include "qapi/error.h"
>   #include "qemu/module.h"
>   #include "hw/arm/boot.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/arm/stm32f205_soc.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-clock.h"
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index 18d8824f29..bba9060daf 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -24,7 +24,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/system.h"
>   #include "hw/arm/stm32f405_soc.h"
>   #include "hw/qdev-clock.h"
> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index dbf75329f7..6278d354c8 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -24,7 +24,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
>   #include "qapi/error.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/system.h"
>   #include "hw/or-irq.h"
>   #include "hw/arm/stm32l4x5_soc.h"
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> index 59c0160283..ee8747781e 100644
> --- a/hw/avr/atmega.c
> +++ b/hw/avr/atmega.c
> @@ -13,7 +13,7 @@
>   #include "qemu/units.h"
>   #include "qapi/error.h"
>   #include "system/memory.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/system.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/sysbus.h"
> diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
> index 7374561141..f0891ffa4d 100644
> --- a/hw/char/goldfish_tty.c
> +++ b/hw/char/goldfish_tty.c
> @@ -15,7 +15,7 @@
>   #include "chardev/char-fe.h"
>   #include "qemu/log.h"
>   #include "trace.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/dma.h"
>   #include "hw/char/goldfish_tty.h"
>   
> diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
> index 07fb868965..8cbf6ce803 100644
> --- a/hw/char/omap_uart.c
> +++ b/hw/char/omap_uart.c
> @@ -21,7 +21,7 @@
>   #include "chardev/char.h"
>   #include "hw/arm/omap.h"
>   #include "hw/char/serial-mm.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   /* UARTs */
>   struct omap_uart_s {
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index ec5db5a597..c884be5d75 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -28,7 +28,7 @@
>   #include "chardev/char-fe.h"
>   #include "qemu/timer.h"
>   #include "qemu/error-report.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "exec/tswap.h"
>   #include "system/dma.h"
>   #include "system/runstate.h"
> diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
> index 5ef8c24b5b..82b68b8927 100644
> --- a/hw/core/cpu-system.c
> +++ b/hw/core/cpu-system.c
> @@ -20,7 +20,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "exec/cputlb.h"
>   #include "system/memory.h"
>   #include "exec/tb-flush.h"
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index 7f1fb562be..a6e477a2d8 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -14,7 +14,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
>   #include "hw/boards.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/core/cpu.h"
>   
>   static void machine_none_init(MachineState *mch)
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index 98819d5dc6..6eb4c0f15a 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -21,7 +21,7 @@
>   #include "qapi/error.h"
>   #include "hw/sysbus.h"
>   #include "monitor/monitor.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent);
>   static char *sysbus_get_fw_dev_path(DeviceState *dev);
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 5bf54347ed..6842e7d491 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -32,7 +32,7 @@
>   #include "qemu/timer.h"
>   #include "qemu/log.h"
>   #include "qemu/module.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "trace.h"
>   #include "qom/object.h"
>   
> diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
> index 6f33c3e741..0b1da723c8 100644
> --- a/hw/hyperv/hv-balloon.c
> +++ b/hw/hyperv/hv-balloon.c
> @@ -10,7 +10,7 @@
>   #include "qemu/osdep.h"
>   #include "hv-balloon-internal.h"
>   
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "exec/cpu-common.h"
>   #include "exec/ramblock.h"
>   #include "hw/boards.h"
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 382c62d668..d21e428eae 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -11,7 +11,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "qapi/error.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/memory.h"
>   #include "system/kvm.h"
>   #include "qemu/bitops.h"
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index 9b8b092bc2..f9223ef1a1 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -23,7 +23,7 @@
>   #include "qobject/qdict.h"
>   #include "qom/object.h"
>   #include "exec/target_page.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   
> diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
> index 7b843a72b1..430ba62896 100644
> --- a/hw/i386/kvm/xen_gnttab.c
> +++ b/hw/i386/kvm/xen_gnttab.c
> @@ -17,7 +17,7 @@
>   #include "qapi/error.h"
>   #include "qom/object.h"
>   #include "exec/target_page.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "migration/vmstate.h"
>   
>   #include "hw/sysbus.h"
> diff --git a/hw/i386/kvm/xen_overlay.c b/hw/i386/kvm/xen_overlay.c
> index db9aa7942d..a2b26e9906 100644
> --- a/hw/i386/kvm/xen_overlay.c
> +++ b/hw/i386/kvm/xen_overlay.c
> @@ -16,7 +16,7 @@
>   #include "qapi/error.h"
>   #include "qom/object.h"
>   #include "exec/target_page.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "migration/vmstate.h"
>   
>   #include "hw/sysbus.h"
> diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
> index 875e1c5c33..00b220d4d6 100644
> --- a/hw/i386/sgx-epc.c
> +++ b/hw/i386/sgx-epc.c
> @@ -17,7 +17,7 @@
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
>   #include "target/i386/cpu.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   static const Property sgx_epc_properties[] = {
>       DEFINE_PROP_UINT64(SGX_EPC_ADDR_PROP, SGXEPCDevice, addr, 0),
> diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
> index e665e2111c..5685c4fb80 100644
> --- a/hw/i386/sgx.c
> +++ b/hw/i386/sgx.c
> @@ -20,7 +20,7 @@
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qapi/qapi-commands-misc-target.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/hw_accel.h"
>   #include "system/reset.h"
>   #include <sys/ioctl.h>
> diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
> index 14de9b7a82..26aae64e5d 100644
> --- a/hw/i386/vapic.c
> +++ b/hw/i386/vapic.c
> @@ -16,7 +16,7 @@
>   #include "system/hw_accel.h"
>   #include "system/kvm.h"
>   #include "system/runstate.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/i386/apic_internal.h"
>   #include "hw/sysbus.h"
>   #include "hw/boards.h"
> diff --git a/hw/ide/ahci-sysbus.c b/hw/ide/ahci-sysbus.c
> index 03a5bd42d0..3c1935d81c 100644
> --- a/hw/ide/ahci-sysbus.c
> +++ b/hw/ide/ahci-sysbus.c
> @@ -22,7 +22,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
>   
> diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
> index d9f8c36778..987034efd3 100644
> --- a/hw/input/lasips2.c
> +++ b/hw/input/lasips2.c
> @@ -29,7 +29,7 @@
>   #include "hw/input/lasips2.h"
>   #include "exec/hwaddr.h"
>   #include "trace.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "migration/vmstate.h"
>   #include "hw/irq.h"
>   #include "qapi/error.h"
> diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
> index a51a215e6e..a558c50185 100644
> --- a/hw/intc/loongarch_extioi.c
> +++ b/hw/intc/loongarch_extioi.c
> @@ -11,7 +11,7 @@
>   #include "qapi/error.h"
>   #include "hw/irq.h"
>   #include "hw/loongarch/virt.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/intc/loongarch_extioi.h"
>   #include "trace.h"
>   
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 5964cde7e0..789c4a4d6e 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -22,7 +22,7 @@
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
>   #include "qemu/bswap.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/sysbus.h"
>   #include "hw/pci/msi.h"
>   #include "hw/boards.h"
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index 241b12fef0..852f413e5a 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -22,7 +22,7 @@
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
>   #include "qemu/bswap.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/sysbus.h"
>   #include "hw/pci/msi.h"
>   #include "hw/boards.h"
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index a5840ff968..08ae2d9692 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -18,7 +18,7 @@
>   #include "system/reset.h"
>   #include "system/rtc.h"
>   #include "hw/loongarch/virt.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/irq.h"
>   #include "net/net.h"
>   #include "hw/loader.h"
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 1de8dfec7d..1a432e9bd2 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -17,7 +17,7 @@
>   #include "qemu/range.h"
>   #include "hw/virtio/vhost.h"
>   #include "system/kvm.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "trace.h"
>   
>   static bool memory_device_is_empty(const MemoryDeviceState *md)
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
> index 21ad215e44..c887c7a99e 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -36,7 +36,7 @@
>   #include "hw/boards.h"
>   #include "hw/char/serial-mm.h"
>   #include "hw/qdev-properties.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/ssi/ssi.h"
>   
>   #include "boot.h"
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index bdba2006b7..f976c90bd2 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -33,7 +33,7 @@
>   #include "system/system.h"
>   #include "hw/boards.h"
>   #include "hw/misc/unimp.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/char/xilinx_uartlite.h"
>   
>   #include "boot.h"
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index bdbf7328bf..0922c65295 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -17,7 +17,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/boards.h"
>   #include "cpu.h"
>   #include "boot.h"
> diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
> index c530688e76..b6dabf2893 100644
> --- a/hw/mips/mipssim.c
> +++ b/hw/mips/mipssim.c
> @@ -28,7 +28,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "qemu/datadir.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/clock.h"
>   #include "hw/mips/mips.h"
>   #include "hw/char/serial-mm.h"
> diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
> index c4f3eb9274..74ff71b753 100644
> --- a/hw/misc/allwinner-h3-dramc.c
> +++ b/hw/misc/allwinner-h3-dramc.c
> @@ -24,7 +24,7 @@
>   #include "migration/vmstate.h"
>   #include "qemu/log.h"
>   #include "qemu/module.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/qdev-properties.h"
>   #include "qapi/error.h"
>   #include "hw/misc/allwinner-h3-dramc.h"
> diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
> index 96e1848c21..5908a059e8 100644
> --- a/hw/misc/allwinner-r40-dramc.c
> +++ b/hw/misc/allwinner-r40-dramc.c
> @@ -24,7 +24,7 @@
>   #include "migration/vmstate.h"
>   #include "qemu/log.h"
>   #include "qemu/module.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/qdev-properties.h"
>   #include "qapi/error.h"
>   #include "qemu/bitops.h"
> diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
> index 40309a8ff3..076c4b42de 100644
> --- a/hw/misc/ivshmem-flat.c
> +++ b/hw/misc/ivshmem-flat.c
> @@ -17,7 +17,7 @@
>   #include "hw/qdev-properties-system.h"
>   #include "hw/sysbus.h"
>   #include "chardev/char-fe.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "trace.h"
>   
>   #include "hw/misc/ivshmem-flat.h"
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 03b1feda50..3c0819c58a 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -16,7 +16,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "migration/vmstate.h"
>   #include "hw/sysbus.h"
>   #include "hw/irq.h"
> diff --git a/hw/net/i82596.c b/hw/net/i82596.c
> index ee919dab3c..64ed3c8390 100644
> --- a/hw/net/i82596.c
> +++ b/hw/net/i82596.c
> @@ -15,7 +15,7 @@
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qemu/module.h"
>   #include "trace.h"
>   #include "i82596.h"
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index a757939cfb..cbfb2b5303 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -27,7 +27,7 @@
>   #include "system/system.h"
>   #include "system/dma.h"
>   #include "system/reset.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/boards.h"
>   #include "hw/nvram/fw_cfg.h"
>   #include "hw/qdev-properties.h"
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 83d7c2a8af..c2284a7d41 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -28,7 +28,7 @@
>   #include "net/net.h"
>   #include "hw/openrisc/boot.h"
>   #include "hw/qdev-properties.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/device_tree.h"
>   #include "system/system.h"
>   #include "hw/sysbus.h"
> diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
> index 3055306783..0d1c1f103c 100644
> --- a/hw/openrisc/virt.c
> +++ b/hw/openrisc/virt.c
> @@ -11,7 +11,7 @@
>   #include "qemu/guest-random.h"
>   #include "qapi/error.h"
>   #include "cpu.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/irq.h"
>   #include "hw/boards.h"
>   #include "hw/char/serial-mm.h"
> diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
> index 9c41c155fb..a297318c6e 100644
> --- a/hw/pci-host/mv64361.c
> +++ b/hw/pci-host/mv64361.c
> @@ -17,7 +17,7 @@
>   #include "hw/irq.h"
>   #include "hw/intc/i8259.h"
>   #include "hw/qdev-properties.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qemu/log.h"
>   #include "qemu/error-report.h"
>   #include "trace.h"
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index 246d6d633b..7b2dc6985c 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -31,7 +31,7 @@
>   #include "qemu/error-report.h"
>   #include "system/kvm.h"
>   #include "kvm_ppc.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qom/qom-qobject.h"
>   #include "qobject/qdict.h"
>   #include "trace.h"
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 1fe11dde50..f832ee61e8 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -18,7 +18,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/irq.h"
>   #include "target/ppc/cpu.h"
>   #include "qemu/log.h"
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 8250824a1a..5c7278ea4b 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -36,7 +36,7 @@
>   #include "qemu/timer.h"
>   #include "system/reset.h"
>   #include "system/system.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/intc/ppc-uic.h"
>   #include "trace.h"
>   
> diff --git a/hw/ppc/ppc4xx_sdram.c b/hw/ppc/ppc4xx_sdram.c
> index 562bff8d53..bf0faad9e7 100644
> --- a/hw/ppc/ppc4xx_sdram.c
> +++ b/hw/ppc/ppc4xx_sdram.c
> @@ -34,7 +34,7 @@
>   #include "qapi/error.h"
>   #include "qemu/log.h"
>   #include "qemu/error-report.h"
> -#include "exec/address-spaces.h" /* get_system_memory() */
> +#include "system/address-spaces.h" /* get_system_memory() */
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/ppc/ppc4xx.h"
> diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
> index b1f2e130f0..08f29e72e4 100644
> --- a/hw/ppc/prep_systemio.c
> +++ b/hw/ppc/prep_systemio.c
> @@ -28,7 +28,7 @@
>   #include "hw/isa/isa.h"
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qom/object.h"
>   #include "qemu/error-report.h" /* for error_report() */
>   #include "qemu/module.h"
> diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
> index 0e5d53b8b6..27f1c90f06 100644
> --- a/hw/ppc/rs6000_mc.c
> +++ b/hw/ppc/rs6000_mc.c
> @@ -24,7 +24,7 @@
>   #include "hw/isa/isa.h"
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qapi/error.h"
>   #include "trace.h"
>   #include "qom/object.h"
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> index 88e29536aa..6d6eaf67cb 100644
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -15,7 +15,7 @@
>   #include "hw/ppc/spapr_ovec.h"
>   #include "migration/vmstate.h"
>   #include "qemu/bitmap.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qemu/error-report.h"
>   #include "trace.h"
>   #include <libfdt.h>
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index 09cb77de93..f14efa3a7c 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -15,7 +15,7 @@
>   #include "qemu/units.h"
>   #include "qemu/log.h"
>   #include "qapi/error.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/ppc/vof.h"
>   #include "hw/ppc/fdt.h"
>   #include "system/runstate.h"
> diff --git a/hw/remote/iommu.c b/hw/remote/iommu.c
> index ec845d1f58..3e0758a21e 100644
> --- a/hw/remote/iommu.c
> +++ b/hw/remote/iommu.c
> @@ -14,7 +14,7 @@
>   #include "hw/pci/pci_bus.h"
>   #include "hw/pci/pci.h"
>   #include "system/memory.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "trace.h"
>   
>   /**
> diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
> index d8e67906d2..e863c50cbc 100644
> --- a/hw/riscv/microblaze-v-generic.c
> +++ b/hw/riscv/microblaze-v-generic.c
> @@ -22,7 +22,7 @@
>   #include "net/net.h"
>   #include "hw/boards.h"
>   #include "hw/char/serial-mm.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/char/xilinx_uartlite.h"
>   #include "hw/misc/unimp.h"
>   
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 98a67fe52a..019d6b3986 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -28,7 +28,7 @@
>   #include "hw/riscv/boot.h"
>   #include "qemu/units.h"
>   #include "system/system.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   /*
>    * This version of the OpenTitan machine currently supports
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index e2242b97d0..17c5c72102 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -25,7 +25,7 @@
>   #include "hw/intc/riscv_aclint.h"
>   #include "system/system.h"
>   #include "hw/qdev-properties.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/riscv/boot.h"
>   
>   static const struct MemmapEntry {
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 738800c98d..2059c5dd0b 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -14,7 +14,7 @@
>   #include "qapi/visitor.h"
>   #include "qemu/bitops.h"
>   #include "qemu/error-report.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/s390x/ioinst.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/s390x/css.h"
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index 811d892122..425e3e4a87 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -19,7 +19,7 @@
>   #include "qobject/qdict.h"
>   #include "qemu/error-report.h"
>   #include "system/memory_mapping.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/kvm.h"
>   #include "migration/qemu-file-types.h"
>   #include "migration/register.h"
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 43f3b162c8..e8ecb90826 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -12,7 +12,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/kvm.h"
>   #include "net/net.h"
>   #include "hw/virtio/virtio.h"
> diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
> index 5a4c1f5e3b..4a542b18d2 100644
> --- a/hw/sparc/sun4m_iommu.c
> +++ b/hw/sparc/sun4m_iommu.c
> @@ -29,7 +29,7 @@
>   #include "hw/sysbus.h"
>   #include "migration/vmstate.h"
>   #include "qemu/module.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "trace.h"
>   
>   /*
> diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
> index eba811af0c..533fcae1fb 100644
> --- a/hw/sparc64/sun4u_iommu.c
> +++ b/hw/sparc64/sun4u_iommu.c
> @@ -27,7 +27,7 @@
>   #include "qemu/osdep.h"
>   #include "hw/sysbus.h"
>   #include "hw/sparc/sun4u_iommu.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qemu/log.h"
>   #include "qemu/module.h"
>   #include "trace.h"
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index ccb97b6806..ea82472105 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -36,7 +36,7 @@
>   #include "hw/rtc/mc146818rtc_regs.h"
>   #include "migration/vmstate.h"
>   #include "hw/timer/i8254.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qom/object.h"
>   #include "trace.h"
>   
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 6cdeb72df0..b668aee97a 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -18,7 +18,7 @@
>   
>   #include "qemu/module.h"
>   #include "qapi/error.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/pci/pci_ids.h"
>   #include "hw/acpi/tpm.h"
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index c7ab4ff57a..d6575d7c44 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -28,7 +28,7 @@
>   #include "migration/vmstate.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/s390x/ap-bridge.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qom/object.h"
>   
>   #define TYPE_VFIO_AP_DEVICE      "vfio-ap"
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index e5e0d9e3e7..29e804e122 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -27,7 +27,7 @@
>   #include "hw/s390x/vfio-ccw.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/s390x/ccw-device.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index cdcec21c08..5c3bc88222 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -27,7 +27,7 @@
>   
>   #include "hw/vfio/vfio-common.h"
>   #include "hw/vfio/pci.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/memory.h"
>   #include "exec/ram_addr.h"
>   #include "hw/hw.h"
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 1d1c5f9a77..2e993c7e73 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -23,7 +23,7 @@
>   #include <linux/vfio.h>
>   
>   #include "hw/vfio/vfio-common.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/memory.h"
>   #include "exec/ram_addr.h"
>   #include "qemu/error-report.h"
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 96c6bf5654..c6edbdd4ae 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -29,7 +29,7 @@
>   #include "qemu/module.h"
>   #include "qemu/range.h"
>   #include "system/memory.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qemu/queue.h"
>   #include "hw/sysbus.h"
>   #include "trace.h"
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index ad4c499eaf..bc00badb34 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -15,7 +15,7 @@
>   #include <linux/kvm.h>
>   #endif
>   #include "system/kvm.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   #include "hw/vfio/vfio-common.h"
>   #include "hw/hw.h"
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 7efbde3d4c..1e0336df1d 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -20,7 +20,7 @@
>   #include "hw/virtio/virtio-net.h"
>   #include "hw/virtio/vhost-shadow-virtqueue.h"
>   #include "hw/virtio/vhost-vdpa.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "migration/blocker.h"
>   #include "qemu/cutils.h"
>   #include "qemu/main-loop.h"
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 2eb5a14fa2..0d0603c674 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -24,7 +24,7 @@
>   #include "hw/boards.h"
>   #include "system/balloon.h"
>   #include "hw/virtio/virtio-balloon.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-events-machine.h"
>   #include "qapi/visitor.h"
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 896feb37a1..d1c79c567b 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -28,7 +28,7 @@
>   #include "qapi/error.h"
>   #include "hw/virtio/virtio-bus.h"
>   #include "hw/virtio/virtio.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   /* #define DEBUG_VIRTIO_BUS */
>   
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index 6654d31406..011a367357 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -24,7 +24,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "disas/disas.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/memory.h"
>   #include "monitor/hmp-target.h"
>   #include "monitor/monitor-internal.h"
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 7ded3378cf..8ddcdd76c1 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -14,7 +14,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "exec/ioport.h"
>   #include "exec/gdbstub.h"
>   #include "gdbstub/enums.h"
> diff --git a/system/ioport.c b/system/ioport.c
> index 5f8718486c..2bc14bdcfa 100644
> --- a/system/ioport.c
> +++ b/system/ioport.c
> @@ -29,7 +29,7 @@
>   #include "cpu.h"
>   #include "exec/ioport.h"
>   #include "system/memory.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "trace.h"
>   
>   struct MemoryRegionPortioList {
> diff --git a/system/memory.c b/system/memory.c
> index 6d6b33b366..050bffdbf8 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -33,7 +33,7 @@
>   #include "qemu/accel.h"
>   #include "hw/boards.h"
>   #include "migration/vmstate.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   //#define DEBUG_UNASSIGNED
>   
> diff --git a/system/memory_mapping.c b/system/memory_mapping.c
> index 8538a8241e..da708a08ab 100644
> --- a/system/memory_mapping.c
> +++ b/system/memory_mapping.c
> @@ -17,7 +17,7 @@
>   
>   #include "system/memory_mapping.h"
>   #include "system/memory.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/core/cpu.h"
>   
>   //#define DEBUG_GUEST_PHYS_REGION_ADD
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 2439af63a0..93a3f9b53d 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -22,7 +22,7 @@
>   
>   #include <mach/mach_time.h>
>   
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/boards.h"
>   #include "hw/irq.h"
>   #include "qemu/main-loop.h"
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index da30bdbb23..97de8c7e93 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -30,7 +30,7 @@
>   #include "internals.h"
>   #include "hw/pci/pci.h"
>   #include "exec/memattrs.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "gdbstub/enums.h"
>   #include "hw/boards.h"
>   #include "hw/irq.h"
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index 3412312ad5..a1e2cc9c35 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -26,7 +26,7 @@
>   #include "exec/cputlb.h"
>   #include "exec/page-protection.h"
>   #include "exec/cpu_ldst.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "exec/helper-proto.h"
>   
>   bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
> index c1708b04bb..242a05fdbe 100644
> --- a/target/i386/cpu-apic.c
> +++ b/target/i386/cpu-apic.c
> @@ -14,7 +14,7 @@
>   #include "system/hw_accel.h"
>   #include "system/kvm.h"
>   #include "system/xen.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/i386/apic_internal.h"
>   #include "cpu-internal.h"
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1b64ceaaba..dba1b3ffef 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -38,7 +38,7 @@
>   #ifndef CONFIG_USER_ONLY
>   #include "system/reset.h"
>   #include "qapi/qapi-commands-machine-target.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/boards.h"
>   #include "hw/i386/sgx-epc.h"
>   #endif
> diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
> index e81a245881..b23010374f 100644
> --- a/target/i386/kvm/xen-emu.c
> +++ b/target/i386/kvm/xen-emu.c
> @@ -17,7 +17,7 @@
>   #include "system/kvm_int.h"
>   #include "system/kvm_xen.h"
>   #include "kvm/kvm_i386.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "xen-emu.h"
>   #include "trace.h"
>   #include "system/runstate.h"
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index 04e5f7e637..91f0e32366 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -9,7 +9,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "exec/ioport.h"
>   #include "qemu/accel.h"
>   #include "system/nvmm.h"
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 0e1dbb6959..ba88976e9f 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -39,7 +39,7 @@
>   #include "qapi/qapi-commands-misc-target.h"
>   #include "confidential-guest.h"
>   #include "hw/i386/pc.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "qemu/queue.h"
>   
>   OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
> diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
> index ce18c75b9f..0555cf2604 100644
> --- a/target/i386/tcg/system/misc_helper.c
> +++ b/target/i386/tcg/system/misc_helper.c
> @@ -22,7 +22,7 @@
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
>   #include "exec/cpu_ldst.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "exec/cputlb.h"
>   #include "tcg/helper-tcg.h"
>   #include "hw/i386/apic.h"
> diff --git a/target/i386/tcg/system/tcg-cpu.c b/target/i386/tcg/system/tcg-cpu.c
> index 13a3507863..ab1f3c7c59 100644
> --- a/target/i386/tcg/system/tcg-cpu.c
> +++ b/target/i386/tcg/system/tcg-cpu.c
> @@ -23,7 +23,7 @@
>   
>   #include "system/system.h"
>   #include "qemu/units.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   #include "tcg/tcg-cpu.h"
>   
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 41fb8c5a4e..d58cb11cee 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -10,7 +10,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "exec/ioport.h"
>   #include "gdbstub/helpers.h"
>   #include "qemu/accel.h"
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 28735c80be..1668f12410 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -18,7 +18,7 @@
>   #include "system/kvm_int.h"
>   #include "hw/pci/pci.h"
>   #include "exec/memattrs.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/boards.h"
>   #include "hw/irq.h"
>   #include "hw/loongarch/virt.h"
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 4ffeeaa1c9..9686fa86e0 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -35,7 +35,7 @@
>   #include "accel/accel-cpu-target.h"
>   #include "hw/pci/pci.h"
>   #include "exec/memattrs.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/boards.h"
>   #include "hw/irq.h"
>   #include "hw/intc/riscv_imsic.h"
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index d8f483898d..b079d120db 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -17,7 +17,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "cpu.h"
>   #include "s390x-internal.h"
>   #include "kvm/kvm_s390x.h"
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index 6a4d9c5081..a3347f1236 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -14,7 +14,7 @@
>   #include "hw/boards.h"
>   #include "system/hw_accel.h"
>   #include "system/runstate.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "exec/cputlb.h"
>   #include "exec/exec-all.h"
>   #include "system/tcg.h"
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
> index f969850f87..ac733f407f 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -28,7 +28,7 @@
>   #include "tcg_s390x.h"
>   #ifndef CONFIG_USER_ONLY
>   #include "qemu/timer.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "hw/s390x/ioinst.h"
>   #include "hw/s390x/s390_flic.h"
>   #include "hw/boards.h"
> diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
> index 5546c82ecd..163a1ffc7b 100644
> --- a/target/xtensa/dbg_helper.c
> +++ b/target/xtensa/dbg_helper.c
> @@ -31,7 +31,7 @@
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
>   #include "exec/exec-all.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   
>   void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
>   {
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> index c4323574e1..2ff1c90df7 100644
> --- a/hw/display/apple-gfx.m
> +++ b/hw/display/apple-gfx.m
> @@ -18,7 +18,7 @@
>   #include "qapi/visitor.h"
>   #include "qapi/error.h"
>   #include "block/aio-wait.h"
> -#include "exec/address-spaces.h"
> +#include "system/address-spaces.h"
>   #include "system/dma.h"
>   #include "migration/blocker.h"
>   #include "ui/console.h"

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


