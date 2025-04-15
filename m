Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869F4C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 13:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4gDy-0002A5-8K; Tue, 15 Apr 2025 09:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u4gDI-00026J-S2
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:20:39 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u4gDF-0006Ag-Ji
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:20:32 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-301d6cbbd5bso5641789a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1744723227; x=1745328027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HtMnccx4Oo8q7IhpN/0Rv/iWjJY5L+batKVmwuxeYjw=;
 b=Hs+yTPReiwVBj00tWpOSRbTbo551Byypw62kW9uY+XG44Ay3htz97yHTKYvJmj4MJu
 IxORHE9sDYqtp35qvIMNE+eQ/CqaJEQM9sMv2Ho4sl0U5XvVC5hJDN/lYp2Dh0NAtBoz
 eSA0P9omnJGwIie9RcjUb1Wn6P2ScenBU1RzMHpIW08TaQ+CyEuUsn2Q3hMJRwgtP5Vb
 YL6mDObFbUTp3vkdjNwR5sI3jVv0RQTudrr5LgR2EN0x5q7PIyMMLoKaZAn+SPlprDmv
 uk3XGsxCbGNf5f81+CQNYqX0ct9Vdktpnf2fL9E9CeuGItWwv1+WZTUmBPy5p82dwdjG
 LYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744723227; x=1745328027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HtMnccx4Oo8q7IhpN/0Rv/iWjJY5L+batKVmwuxeYjw=;
 b=F2pGSsyRBY8lpiYaIqUL6SpQfzzsSfc7WQE5j0vKU+I3u8sCoqbSwZL0HPfm9PO9/d
 np5AEVh+RaypjW8RoQZhPuG5NKrDj8V4tG4QYdSo4usEjEnfY23AygHz8kfHZm8z+IGA
 dZ3Wl1Gua840P58tEpQ+bgMbBHrZXem1UozAvAtAIJphcXtXHoXX4sAepksrirBMXtzw
 74PtPvU6rMzwMWhhCcPxfNtSO9xNsGi0H3DkrUPOcD/3VG/PlrgGJRK3HYuBGb7XiLqA
 yP42LQCvUUr6QUpR7lrBNkt5QT5DEpW7GwZUHuTtKwJ/XQ/8LkSRx1y5c6wn7THPj2kj
 jNUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv4U7OXrCjP7dv0j1kyJpZQe9WZUGVgdNXqlnGRWnqAmS1fhHHcbEB9xL0NzbR/PEBR6TeH/0QHdhG@nongnu.org
X-Gm-Message-State: AOJu0YwpU0GNVNQVmNUU/sKiihwtLXEwlFBrgR7JPZggOjwLWOyxp2xU
 q0YJ1G+TPTwhTcpQSoeLqhmi9MomJQCh/9GuN4ibZqUdCQSbCpPt+1H5ZBILt8Y=
X-Gm-Gg: ASbGncuXGhxKMv8Q9dGLXPwlJy70YWaS4kQx/cpqADqYewvmsegFLnZtWMpxaRWTfSn
 DTdBzv2gQe97EMleCPXj6Ozg0TZeP55+HVUWQaliyxT3tSt8rlKe3PdBuKblLimWbuuoAlpxNjM
 yY7jZimde85/LjT5Wqa3Wv+eWtmqP+T9boWb+SoO3XCDD3aX+aKObVobLPiQNcZnHkjFtfkiyjT
 TxNAIEY+6B/bxs3N1NTYDWbtsM5N940KcZ3Nd0zfyd10gaQ9psm39+S/c+DpcqZgByIW9CpSySf
 jrX8xG850vtIw1carP5KUkHMTR2EfQBVb5WScXOEiXNRmVgi3lTJCDA=
X-Google-Smtp-Source: AGHT+IFzuKT91zGTOFb7tVzQ3w4Ze3z1iDd2Yjh9oQCbsQtt2RRC6LMyzkj81dPP/AD5WNO3ly917A==
X-Received: by 2002:a17:90b:2f44:b0:2ff:6a5f:9b39 with SMTP id
 98e67ed59e1d1-30823653224mr27643940a91.18.1744723227283; 
 Tue, 15 Apr 2025 06:20:27 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b65112sm116201415ad.19.2025.04.15.06.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 06:20:26 -0700 (PDT)
Message-ID: <253ef6eb-9aa1-4aba-9dd2-2d0490816199@ventanamicro.com>
Date: Tue, 15 Apr 2025 10:20:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] hw/riscv: virt: Add WorldGuard support
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250415081231.21186-1-jim.shu@sifive.com>
 <20250415081231.21186-18-jim.shu@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250415081231.21186-18-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102c.google.com
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



On 4/15/25 5:12 AM, Jim Shu wrote:
> * Add 'wg=on' option to enable RISC-V WorldGuard
> * Add wgChecker to protect several resources:
>    DRAM, FLASH, UART.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   docs/system/riscv/virt.rst |  20 +++++
>   hw/riscv/Kconfig           |   1 +
>   hw/riscv/virt.c            | 163 ++++++++++++++++++++++++++++++++++++-
>   include/hw/riscv/virt.h    |  15 +++-
>   4 files changed, 195 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 60850970ce..d2bc65f71c 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -146,6 +146,26 @@ The following machine-specific options are supported:
>   
>     Enables the riscv-iommu-sys platform device. Defaults to 'off'.
>   
> +- wg=[on|off]
> +
> +  When this option is "on", RISC-V WorldGuard will be enabled in the system
> +  to provide the isolation of multiple worlds. RISC-V HARTs will enable WG
> +  extensions to have WID in memory transaction. wgCheckers in front of RAMs
> +  and device MMIO will be enabled to provide the access control of resources
> +  if the transaction contains WID. When not specified, this option is assumed
> +  to be "off".
> +
> +  The WG configuration of virt machine includes 4 worlds. For WG configuration
> +  of CPUs, the M-mode WID of CPU (`mwid`) is set to the largest WID number,
> +  and the authorized WID list of CPU (`mwidlist`) includes all WIDs. We can
> +  modify the configuration of all CPUs via `x-mwid` and `x-mwidlist`

This change will break the doc build:

====

[3002/3003] Generating docs/QEMU manual with a custom command
FAILED: docs/docs.stamp
/usr/bin/env CONFDIR=etc/qemu /home/danielhb/work/qemu/build/pyvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=1 -j auto -Dversion=9.2.92 -Drelease= -Ddepfile=docs/docs.d -Ddepfile_stamp=docs/docs.stamp -b html -d /home/danielhb/work/qemu/build/docs/manual.p /home/danielhb/work/qemu/docs /home/danielhb/work/qemu/build/docs/manual

Warning, treated as error:
/home/danielhb/work/qemu/docs/system/riscv/virt.rst:158:'any' reference target not found: mwid
ninja: build stopped: subcommand failed.

====

This happens because you're wrapping words with a single back-quote, and RST
thinks that you're referring to an internal page/link.

You need double back-quotes (``) in this case:

$ git diff
diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index d2bc65f71c..69b028bd73 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -156,9 +156,9 @@ The following machine-specific options are supported:
    to be "off".
  
    The WG configuration of virt machine includes 4 worlds. For WG configuration
-  of CPUs, the M-mode WID of CPU (`mwid`) is set to the largest WID number,
-  and the authorized WID list of CPU (`mwidlist`) includes all WIDs. We can
-  modify the configuration of all CPUs via `x-mwid` and `x-mwidlist`
+  of CPUs, the M-mode WID of CPU (``mwid``) is set to the largest WID number,
+  and the authorized WID list of CPU (``mwidlist``) includes all WIDs. We can
+  modify the configuration of all CPUs via ``x-mwid`` and ``x-mwidlist``
    CPU options. There are 3 wgCheckers in the virt machine, which seperately
    protects DRAM, FLASH, and UART. Default WG configuration on the virt machine
    is enough to run the demo of dual OSes in the different worlds. For example,



> +  CPU options. There are 3 wgCheckers in the virt machine, which seperately

s/seperately/separately


Code looks good otherwise. Thanks,

Daniel

> +  protects DRAM, FLASH, and UART. Default WG configuration on the virt machine
> +  is enough to run the demo of dual OSes in the different worlds. For example,
> +  running both Linux kernel and Secure OS (e.g. OP-TEE) in it's own world.
> +
> +  This option is restricted to the TCG accelerator.
> +
>   Running Linux kernel
>   --------------------
>   
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e6a0ac1fa1..5c3e7b3479 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -68,6 +68,7 @@ config RISCV_VIRT
>       select PLATFORM_BUS
>       select ACPI
>       select ACPI_PCI
> +    select RISCV_WORLDGUARD
>   
>   config SHAKTI_C
>       bool
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index e517002fdf..da873bc8b8 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -58,6 +58,7 @@
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
>   #include "hw/uefi/var-service-api.h"
> +#include "hw/misc/riscv_worldguard.h"
>   
>   /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
>   static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
> @@ -89,6 +90,9 @@ static const MemMapEntry virt_memmap[] = {
>       [VIRT_PCIE_PIO] =     {  0x3000000,       0x10000 },
>       [VIRT_IOMMU_SYS] =    {  0x3010000,        0x1000 },
>       [VIRT_PLATFORM_BUS] = {  0x4000000,     0x2000000 },
> +    [VIRT_WGC_DRAM] =     {  0x6000000,        0x1000 },
> +    [VIRT_WGC_FLASH] =    {  0x6001000,        0x1000 },
> +    [VIRT_WGC_UART] =     {  0x6002000,        0x1000 },
>       [VIRT_PLIC] =         {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MAX * 2) },
>       [VIRT_APLIC_M] =      {  0xc000000, APLIC_SIZE(VIRT_CPUS_MAX) },
>       [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
> @@ -114,6 +118,38 @@ static MemMapEntry virt_high_pcie_memmap;
>   
>   #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
>   
> +/* wgChecker helpers */
> +typedef struct WGCInfo {
> +    int memmap_idx;
> +    uint32_t irq_num;
> +    uint32_t slot_count;
> +
> +    int num_of_child;
> +    MemoryRegion *c_region[WGC_NUM_REGIONS];
> +    uint64_t c_offset[WGC_NUM_REGIONS];
> +} WGCInfo;
> +
> +enum {
> +    WGC_DRAM,
> +    WGC_FLASH,
> +    WGC_UART,
> +    WGC_NUM,
> +};
> +
> +static WGCInfo virt_wgcinfo[] = {
> +    [WGC_DRAM]  = { VIRT_WGC_DRAM, WGC_DRAM_IRQ, 16 },
> +    [WGC_FLASH] = { VIRT_WGC_FLASH, WGC_FLASH_IRQ, 16 },
> +    [WGC_UART]  = { VIRT_WGC_UART, WGC_UART_IRQ, 1 },
> +};
> +
> +static void wgc_append_child(WGCInfo *info, MemoryRegion *region,
> +                             uint64_t offset)
> +{
> +    info->c_region[info->num_of_child] = region;
> +    info->c_offset[info->num_of_child] = offset;
> +    info->num_of_child += 1;
> +}
> +
>   static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
>                                          const char *name,
>                                          const char *alias_prop_name)
> @@ -164,7 +200,8 @@ static void virt_flash_map1(PFlashCFI01 *flash,
>   }
>   
>   static void virt_flash_map(RISCVVirtState *s,
> -                           MemoryRegion *sysmem)
> +                           MemoryRegion *sysmem,
> +                           WGCInfo *info)
>   {
>       hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
>       hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
> @@ -173,6 +210,15 @@ static void virt_flash_map(RISCVVirtState *s,
>                       sysmem);
>       virt_flash_map1(s->flash[1], flashbase + flashsize, flashsize,
>                       sysmem);
> +
> +    if (info) {
> +        wgc_append_child(info,
> +                         sysbus_mmio_get_region(SYS_BUS_DEVICE(s->flash[0]), 0),
> +                         flashbase);
> +        wgc_append_child(info,
> +                         sysbus_mmio_get_region(SYS_BUS_DEVICE(s->flash[1]), 0),
> +                         flashbase + flashsize);
> +    }
>   }
>   
>   static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
> @@ -1426,6 +1472,71 @@ static void virt_build_smbios(RISCVVirtState *s)
>       }
>   }
>   
> +static DeviceState *create_wgc(WGCInfo *info, DeviceState *irqchip)
> +{
> +    MemoryRegion *system_memory = get_system_memory();
> +    DeviceState *wgc;
> +    MemoryRegion *upstream_mr, *downstream_mr;
> +    qemu_irq irq = qdev_get_gpio_in(irqchip, info->irq_num);
> +    hwaddr base, size;
> +
> +    /* Unmap downstream_mr from system_memory if it is already mapped. */
> +    for (int i=0; i<info->num_of_child; i++) {
> +        downstream_mr = info->c_region[i];
> +
> +        g_assert(downstream_mr);
> +        if (downstream_mr->container == system_memory) {
> +            memory_region_del_subregion(system_memory, downstream_mr);
> +        }
> +
> +        /*
> +         * Clear the offset of downstream_mr, so we could correctly do
> +         * address_space_init() to it in wgchecker.
> +         */
> +        memory_region_set_address(downstream_mr, 0);
> +    }
> +
> +    base = virt_memmap[info->memmap_idx].base;
> +    size = virt_memmap[info->memmap_idx].size;
> +
> +    wgc = riscv_wgchecker_create(
> +        base, size, irq, info->slot_count, 0, 0,
> +        info->num_of_child, info->c_region, info->c_offset, 0, NULL);
> +
> +    /* Map upstream_mr to system_memory */
> +    for (int i=0; i<info->num_of_child; i++) {
> +        upstream_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(wgc), i+1);
> +        g_assert(upstream_mr);
> +        memory_region_add_subregion(system_memory, info->c_offset[i], upstream_mr);
> +    }
> +
> +    return wgc;
> +}
> +
> +static void virt_create_worldguard(WGCInfo *wgcinfo, int wgc_num,
> +                                   DeviceState *irqchip)
> +{
> +    CPUState *cpu;
> +
> +    /* Global WG config */
> +    riscv_worldguard_create(VIRT_WG_NWORLDS,
> +                            VIRT_WG_TRUSTEDWID,
> +                            VIRT_WG_HWBYPASS,
> +                            VIRT_WG_TZCOMPAT);
> +
> +    /* Enable WG extension of each CPU */
> +    CPU_FOREACH(cpu) {
> +        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
> +
> +        riscv_worldguard_apply_cpu(env->mhartid);
> +    }
> +
> +    /* Create all wgChecker devices */
> +    for (int i=0; i<wgc_num; i++) {
> +        create_wgc(&wgcinfo[i], DEVICE(irqchip));
> +    }
> +}
> +
>   static void virt_machine_done(Notifier *notifier, void *data)
>   {
>       RISCVVirtState *s = container_of(notifier, RISCVVirtState,
> @@ -1527,10 +1638,12 @@ static void virt_machine_done(Notifier *notifier, void *data)
>   static void virt_machine_init(MachineState *machine)
>   {
>       const MemMapEntry *memmap = virt_memmap;
> +    WGCInfo *wgcinfo = virt_wgcinfo;
>       RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
>       MemoryRegion *system_memory = get_system_memory();
>       MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>       DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
> +    SerialMM *uart;
>       int i, base_hartid, hart_count;
>       int socket_count = riscv_socket_count(machine);
>   
> @@ -1546,6 +1659,11 @@ static void virt_machine_init(MachineState *machine)
>           exit(1);
>       }
>   
> +    if (!tcg_enabled() && s->have_wg) {
> +        error_report("'wg' is only available with TCG acceleration");
> +        exit(1);
> +    }
> +
>       /* Initialize sockets */
>       mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
>       for (i = 0; i < socket_count; i++) {
> @@ -1673,6 +1791,10 @@ static void virt_machine_init(MachineState *machine)
>       memory_region_add_subregion(system_memory, memmap[VIRT_DRAM].base,
>           machine->ram);
>   
> +    if (tcg_enabled() && s->have_wg) {
> +        wgc_append_child(&wgcinfo[WGC_DRAM], machine->ram, memmap[VIRT_DRAM].base);
> +    }
> +
>       /* boot rom */
>       memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
>                              memmap[VIRT_MROM].size, &error_fatal);
> @@ -1700,10 +1822,16 @@ static void virt_machine_init(MachineState *machine)
>   
>       create_platform_bus(s, mmio_irqchip);
>   
> -    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> +    uart = serial_mm_init(system_memory, memmap[VIRT_UART0].base,
>           0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
>           serial_hd(0), DEVICE_LITTLE_ENDIAN);
>   
> +    if (tcg_enabled() && s->have_wg) {
> +        wgc_append_child(&wgcinfo[WGC_UART],
> +                         sysbus_mmio_get_region(SYS_BUS_DEVICE(uart), 0),
> +                         memmap[VIRT_UART0].base);
> +    }
> +
>       sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
>           qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
>   
> @@ -1712,7 +1840,16 @@ static void virt_machine_init(MachineState *machine)
>           pflash_cfi01_legacy_drive(s->flash[i],
>                                     drive_get(IF_PFLASH, 0, i));
>       }
> -    virt_flash_map(s, system_memory);
> +
> +    if (tcg_enabled() && s->have_wg) {
> +        virt_flash_map(s, system_memory, &wgcinfo[WGC_FLASH]);
> +    } else {
> +        virt_flash_map(s, system_memory, NULL);
> +    }
> +
> +    if (tcg_enabled() && s->have_wg) {
> +        virt_create_worldguard(wgcinfo, WGC_NUM, mmio_irqchip);
> +    }
>   
>       /* load/create device tree */
>       if (machine->dtb) {
> @@ -1757,6 +1894,20 @@ static void virt_machine_instance_init(Object *obj)
>       s->iommu_sys = ON_OFF_AUTO_AUTO;
>   }
>   
> +static bool virt_get_wg(Object *obj, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    return s->have_wg;
> +}
> +
> +static void virt_set_wg(Object *obj, bool value, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    s->have_wg = value;
> +}
> +
>   static char *virt_get_aia_guests(Object *obj, Error **errp)
>   {
>       RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> @@ -1977,6 +2128,12 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>                                 NULL, NULL);
>       object_class_property_set_description(oc, "iommu-sys",
>                                             "Enable IOMMU platform device");
> +
> +    object_class_property_add_bool(oc, "wg", virt_get_wg,
> +                                   virt_set_wg);
> +    object_class_property_set_description(oc, "wg",
> +                                              "Set on/off to enable/disable the "
> +                                              "RISC-V WorldGuard.");
>   }
>   
>   static const TypeInfo virt_machine_typeinfo = {
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 48a14bea2e..3a631a6a23 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -57,6 +57,7 @@ struct RISCVVirtState {
>       bool have_aclint;
>       RISCVVirtAIAType aia_type;
>       int aia_guests;
> +    bool have_wg;
>       char *oem_id;
>       char *oem_table_id;
>       OnOffAuto acpi;
> @@ -87,11 +88,17 @@ enum {
>       VIRT_PLATFORM_BUS,
>       VIRT_PCIE_ECAM,
>       VIRT_IOMMU_SYS,
> +    VIRT_WGC_DRAM,
> +    VIRT_WGC_FLASH,
> +    VIRT_WGC_UART
>   };
>   
>   enum {
>       UART0_IRQ = 10,
>       RTC_IRQ = 11,
> +    WGC_DRAM_IRQ = 15,
> +    WGC_FLASH_IRQ = 16,
> +    WGC_UART_IRQ = 17,
>       VIRTIO_IRQ = 1, /* 1 to 8 */
>       VIRTIO_COUNT = 8,
>       PCIE_IRQ = 0x20, /* 32 to 35 */
> @@ -102,7 +109,7 @@ enum {
>   #define VIRT_PLATFORM_BUS_NUM_IRQS 32
>   
>   #define VIRT_IRQCHIP_NUM_MSIS 255
> -#define VIRT_IRQCHIP_NUM_SOURCES 96
> +#define VIRT_IRQCHIP_NUM_SOURCES 128
>   #define VIRT_IRQCHIP_NUM_PRIO_BITS 3
>   #define VIRT_IRQCHIP_MAX_GUESTS_BITS 3
>   #define VIRT_IRQCHIP_MAX_GUESTS ((1U << VIRT_IRQCHIP_MAX_GUESTS_BITS) - 1U)
> @@ -158,4 +165,10 @@ uint32_t imsic_num_bits(uint32_t count);
>   #error "Can't accommodate all IMSIC groups in address space"
>   #endif
>   
> +/* WorldGuard */
> +#define VIRT_WG_NWORLDS         4
> +#define VIRT_WG_TRUSTEDWID      3
> +#define VIRT_WG_HWBYPASS        true
> +#define VIRT_WG_TZCOMPAT        false
> +
>   #endif


