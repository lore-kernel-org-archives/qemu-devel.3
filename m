Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BA8C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 11:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOac7-0005Ee-Eq; Mon, 09 Jun 2025 07:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uOac5-0005D7-Bo
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:24:25 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uOaby-0000pj-Ue
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:24:25 -0400
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so4610199b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749468256; x=1750073056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vn1D+xlyXVVfQ9ZFvyPBLuhpcRNZli2yYv1Y6LywD5s=;
 b=chGakUYlpWKw/gaju94RzTV5TbTaiYRQut+MBe5bxim9FdnrdlQ6Z9VbTSMo0kGfib
 xbGO7OrfZE41ALh1b36wtDepUzp+z4HfaUhB7nQH7JbuR8KU6a9PFkfOFLV4jXcJjg2O
 6OQm7OOE6AhwMUs+Wb+0QhUd/nP1uUt2lTVDIzDnKblt2ts+sBSV3TMnsfmu2IqMpk8d
 MmWvE5k4/+aizJ+b1qVcI3SJSJnlOYnWEb/TcuQOhz/Y/otnxM/Ad/DGJmacZXSdeWII
 dXuw6/xN0Hm5+rGzY0CQb45XgZroNp9Zy7moNMSc/byJD3MlmVlrmObcAUeIx8ooKjaQ
 zUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749468256; x=1750073056;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vn1D+xlyXVVfQ9ZFvyPBLuhpcRNZli2yYv1Y6LywD5s=;
 b=N7UpV5bwLwDCm0xqKNQOj5wzUq76XB3rjWl3mdQ+ZTwH5cqFnUpFTGWwr/RwFjg5PJ
 9E/mxdkQhB0FMF10K6GLCm7khxrTNybd4pWjq8P7IsXxhznNqDcd68Y62CzNI8Dj21bZ
 UjJyCEsJ5npRA7SvvDV909/SdvZqwT5WaAxX0VJi9QJD9DfnOqUzwq8gvxTwXh59Baj6
 RCgaN/Ly3dQJEN31OEp5xPdDXerKjESv+YSz3VMw06zPJ/cMPBHo8sdh9iDM3yYetJU6
 bu373up7kkXS3BPKcTR5Iiwf8ob75pBiDl5rRdbx5bxK5AdoieQoi+U5wmwvZ5BeMoOr
 qp4g==
X-Gm-Message-State: AOJu0YwQ4HskgHu0PKwf5i+n2x3FaZZdriM7sI1WVIbKhTCNXYtYMMne
 jJ9dNZl/ohg4WqCuSJLWIjre8OmDyAqpKhCdcAUKzl7BaQ0ipzCPtThPBePAtR5Vt6+YXvOnAXg
 chsh9PsN6Qw==
X-Gm-Gg: ASbGncvfYWi5bBY8qd2dyGwaDP42Q3pQgqPZ4ZtI7bjhjlbKWFcSAb6XmMNRR+j3mot
 RnW38FqXwAX5ZmCJpJlVuq3tQrebqQROcbct0TUN6e/8lxnJeb1yIWFGNlUnpVMnbdgUtL5dnF7
 kul91DFF6YOYRyvPajcCHU3uXpHi6BFahjsRAsGiuwogFTQ6po3vEbI8DVEOFJEyi608f1rnXcF
 rGHFwTd4/GDc0ADNqlAreNonkvmcshYMauA6SVHRoqBfpzjwsc+xM2VdqqDLYE1X5VAyDTrnLQJ
 8HJClDt+wpwy4Wn4el4t8P7ydGqYHZGK5A8ofpDfjJ+FJRiIVkJCe4XLDLvbU0cK
X-Google-Smtp-Source: AGHT+IHh/rPwJBts3BAKgB7ebow+GVlznas0BC4JCNg7ETNDoXYGU4Gy3r1JqbOc3EcCEVu5HsJs+Q==
X-Received: by 2002:a17:90b:4b87:b0:311:ea13:2e70 with SMTP id
 98e67ed59e1d1-31347301de7mr20635907a91.14.1749468245289; 
 Mon, 09 Jun 2025 04:24:05 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.21.192])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3132ad9a4aasm6457310a91.1.2025.06.09.04.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 04:24:04 -0700 (PDT)
Message-ID: <ca6cc5a3-029a-4e6c-8dfb-076b910bfbb5@ventanamicro.com>
Date: Mon, 9 Jun 2025 08:24:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/riscv: add CVA6 machine
To: Ben Dooks <ben.dooks@codethink.co.uk>, nazar.kazakov@codethink.co.uk,
 joseph.baker@codethink.co.uk, fran.redondo@codethink.co.uk,
 lawrence.hunter@codethink.co.uk, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250527112437.291445-1-ben.dooks@codethink.co.uk>
 <20250527112437.291445-2-ben.dooks@codethink.co.uk>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250527112437.291445-2-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 5/27/25 8:24 AM, Ben Dooks wrote:
> Add a (currently Genesy2 based) CVA6 machine.
> 
> Has SPI and UART, the GPIO and Ethernet are currently black-holed
> as there is no hardware model for them (lowRISC ethernet and Xilinx
> GPIO)
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> v2:
> - whitespace fixes
> - use g_autofree on plic
> v1:
> - squashed in fixes for sd-card and new qemu init
> - move to spdx for cva6 machine
> - code cleanups missed in first review
> ---
>   hw/riscv/Kconfig        |  10 ++
>   hw/riscv/cva6.c         | 229 ++++++++++++++++++++++++++++++++++++++++
>   hw/riscv/meson.build    |   1 +
>   include/hw/riscv/cva6.h |  85 +++++++++++++++
>   4 files changed, 325 insertions(+)
>   create mode 100644 hw/riscv/cva6.c
>   create mode 100644 include/hw/riscv/cva6.h
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e6a0ac1fa1..b96f6fa014 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -9,6 +9,16 @@ config IBEX
>   
>   # RISC-V machines in alphabetical order
>   
> +config CVA6
> +    bool
> +    default y
> +    depends on RISCV32 || RISCV64
> +    select DEVICE_TREE
> +    select SIFIVE_PLIC
> +    select XILINX_SPI
> +    select RISCV_ACLINT
> +    select UNIMP
> +
>   config MICROCHIP_PFSOC
>       bool
>       default y
> diff --git a/hw/riscv/cva6.c b/hw/riscv/cva6.c
> new file mode 100644
> index 0000000000..3adfa8b5cc
> --- /dev/null
> +++ b/hw/riscv/cva6.c
> @@ -0,0 +1,229 @@
> +/*
> + * QEMU RISC-V Board for OpenHW CVA6 SoC
> + *
> + * Copyright (c) 2025 Codethink Ltd
> + * Ben Dooks <ben.dooks@codethink.co.uk>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "hw/boards.h"
> +#include "hw/irq.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "hw/misc/unimp.h"
> +
> +#include "hw/sd/sd.h"
> +#include "hw/ssi/ssi.h"
> +
> +#include "hw/riscv/cva6.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/intc/riscv_aclint.h"
> +
> +#include "system/system.h"
> +
> +#include <libfdt.h>
> +
> +#define CVA6_ROM_BASE  0x10000
> +
> +static const MemMapEntry cva6_memmap[] = {
> +    [CVA6_DEBUG] =              {  0x0000000,  0x1000 },
> +    [CVA6_ROM] =                { CVA6_ROM_BASE, 0x10000 },
> +    [CVA6_CLINT] =              {  0x2000000, 0xC0000 },
> +    [CVA6_PLIC] =               {  0xC000000, 0x4000000 },
> +    [CVA6_UART] =               { 0x10000000, 0x1000 },
> +    [CVA6_TIMER] =              { 0x18000000, 0x10000 },
> +    [CVA6_SPI] =                { 0x20000000, 0x800000 },
> +    [CVA6_ETHERNET] =           { 0x30000000, 0x10000 },
> +    [CVA6_GPIO] =               { 0x40000000, 0x1000 },
> +    [CVA6_DRAM] =               { 0x80000000, 0x40000000 },
> +};
> +
> +static void cva6_machine_init(MachineState *machine)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    MemoryRegion *sys_mem = get_system_memory();
> +    hwaddr dram_addr = cva6_memmap[CVA6_DRAM].base;
> +    CVA6State *s = CVA6_MACHINE(machine);
> +    RISCVBootInfo boot_info;
> +
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_CVA6);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +
> +    if (machine->ram_size > mc->default_ram_size) {
> +        error_report("RAM size is too big for DRAM area");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    memory_region_add_subregion(sys_mem, dram_addr, machine->ram);
> +    riscv_boot_info_init(&boot_info, &s->soc.cpus);
> +
> +    if (machine->firmware) {
> +         hwaddr firmware_load_addr = cva6_memmap[CVA6_ROM].base;
> +         riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
> +    }
> +
> +     if (machine->kernel_filename) {
> +         /* note - we've not tested just loading the kernel w/o uboot */
> +         riscv_load_kernel(machine, &boot_info, dram_addr, false, NULL);
> +    }
> +
> +}
> +
> +static void cva6_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "RISC-V board for CVA6";
> +    mc->init = cva6_machine_init;
> +    mc->max_cpus = 1;
> +    mc->default_ram_id = "cva6.ram";
> +    /* start with "max" cpu type until we sort out CVA6 type */
> +    mc->default_cpu_type = TYPE_RISCV_CPU_MAX;
> +    mc->default_ram_size = cva6_memmap[CVA6_DRAM].size;
> +};
> +
> +static void cva6_soc_init(Object *obj)
> +{
> +    CVA6SoCState *s = RISCV_CVA6(obj);
> +
> +    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
> +}
> +
> +static void cva6_add_spi(CVA6SoCState *s, const MemMapEntry *map)
> +{
> +    DriveInfo *dinfo;
> +    BlockBackend *blk;
> +    DeviceState *card_dev;
> +    qemu_irq sd_cs;
> +    DeviceState *sddev;
> +    SysBusDevice *busdev;
> +    DeviceState *spi_dev;
> +    SSIBus *spi;
> +
> +    spi_dev = qdev_new("xlnx.xps-spi");
> +    qdev_prop_set_uint8(spi_dev, "num-ss-bits", 1);
> +    qdev_prop_set_string(spi_dev, "endianness", "little");
> +
> +    busdev = SYS_BUS_DEVICE(spi_dev);
> +    sysbus_realize_and_unref(busdev, &error_fatal);
> +    sysbus_mmio_map(busdev, 0, map->base);
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(s->plic), CVA6_SPI_IRQ));
> +
> +    spi = (SSIBus *)qdev_get_child_bus(spi_dev, "spi");
> +
> +    sddev = ssi_create_peripheral(spi, "ssi-sd");
> +    sd_cs = qdev_get_gpio_in_named(sddev, SSI_GPIO_CS, 0);
> +    sysbus_connect_irq(busdev, 1, sd_cs);
> +
> +    dinfo = drive_get(IF_SD, 0, 0);
> +    blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
> +    card_dev = qdev_new(TYPE_SD_CARD_SPI);
> +    qdev_prop_set_drive_err(card_dev, "drive", blk, &error_fatal);
> +
> +    qdev_realize_and_unref(card_dev, qdev_get_child_bus(sddev, "sd-bus"), &error_fatal);
> +}
> +
> +static void not_implemented(const char *name, const MemMapEntry *map)
> +{
> +    create_unimplemented_device(name, map->base, map->size);
> +}
> +
> +static void cva6_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    MemoryRegion *system_memory = get_system_memory();
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    CVA6SoCState *s = RISCV_CVA6(dev_soc);
> +    const MemMapEntry *memmap = cva6_memmap;
> +    MemoryRegion *rom = g_new(MemoryRegion, 1);
> +    g_autofree char *plic_hart_config;
> +
> +    object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->cpus), "resetvec", CVA6_ROM_BASE,
> +                            &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
> +
> +    /* boot rom */
> +    memory_region_init_rom(rom, OBJECT(dev_soc), "riscv.cva6.bootrom",
> +                           memmap[CVA6_ROM].size, &error_fatal);
> +    memory_region_add_subregion(system_memory, memmap[CVA6_ROM].base,
> +                                rom);
> +
> +    /* create PLIC hart topology configuration string */
> +    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
> +
> +    /* MMIO */
> +    s->plic = sifive_plic_create(memmap[CVA6_PLIC].base,
> +        plic_hart_config, ms->smp.cpus, 0,
> +        CVA6_PLIC_NUM_SOURCES,
> +        CVA6_PLIC_NUM_PRIORITIES,
> +        CVA6_PLIC_PRIORITY_BASE,
> +        CVA6_PLIC_PENDING_BASE,
> +        CVA6_PLIC_ENABLE_BASE,
> +        CVA6_PLIC_ENABLE_STRIDE,
> +        CVA6_PLIC_CONTEXT_BASE,
> +        CVA6_PLIC_CONTEXT_STRIDE,
> +        memmap[CVA6_PLIC].size);
> +
> +    riscv_aclint_swi_create(memmap[CVA6_CLINT].base, 0,
> +                            ms->smp.cpus, false);
> +
> +    riscv_aclint_mtimer_create(
> +        memmap[CVA6_CLINT].base + RISCV_ACLINT_SWI_SIZE,
> +        RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
> +        RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> +        CLINT_TIMEBASE_FREQ, true);
> +
> +    /* something in cva6-sdk uboot seems to prod the debug
> +     * unit by accident, so make it not implemented */
> +    not_implemented("debug", &memmap[CVA6_DEBUG]);
> +
> +    /* 16550 uart, one 32bit register per 32bit word */
> +
> +    serial_mm_init(system_memory, memmap[CVA6_UART].base, 2,
> +                   qdev_get_gpio_in(DEVICE(s->plic), CVA6_UART_IRQ),
> +                   50*1000*10000,
> +                   serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +
> +    /* just unimplement the timers, network and gpio here for now.
> +     * no-one seems to be using the apb timer block anyway*/
> +    not_implemented("net", &memmap[CVA6_ETHERNET]);
> +    not_implemented("gpio", &memmap[CVA6_GPIO]);
> +    not_implemented("timer", &memmap[CVA6_TIMER]);
> +
> +    /* connect xilinx spi block here */
> +    cva6_add_spi(s, &memmap[CVA6_SPI]);
> +}
> +
> +static void cva6_soc_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = cva6_soc_realize;
> +    dc->user_creatable = false;
> +};
> +
> +static const TypeInfo cva6_types[] = {
> +    {
> +        .name           = TYPE_RISCV_CVA6,
> +        .parent         = TYPE_DEVICE,
> +        .instance_size  = sizeof(CVA6SoCState),
> +        .instance_init  = cva6_soc_init,
> +        .class_init     = cva6_soc_class_init,
> +    }, {
> +        .name           = TYPE_CVA6_MACHINE,
> +        .parent         = TYPE_MACHINE,
> +        .instance_size  = sizeof(CVA6State),
> +        .class_init     = cva6_machine_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(cva6_types)
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index c22f3a7216..a32fffab63 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -2,6 +2,7 @@ riscv_ss = ss.source_set()
>   riscv_ss.add(files('boot.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>   riscv_ss.add(files('riscv_hart.c'))
> +riscv_ss.add(when: 'CONFIG_CVA6', if_true: files('cva6.c'))
>   riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>   riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
> diff --git a/include/hw/riscv/cva6.h b/include/hw/riscv/cva6.h
> new file mode 100644
> index 0000000000..8f6172e8b8
> --- /dev/null
> +++ b/include/hw/riscv/cva6.h
> @@ -0,0 +1,85 @@
> +/*
> + * QEMU RISC-V Board for OpenHW CVA6 SoC
> + * https://github.com/openhwgroup/cva6/tree/master/corev_apu
> + *
> + * Copyright (c) 2025 Codethink Ltd
> + * Ben Dooks <ben.dooks@codethink.co.uk>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_CVA6_H
> +#define HW_CVA6_H
> +
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/intc/sifive_plic.h"
> +#include "hw/char/serial-mm.h"
> +
> +#include "hw/boards.h"
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RISCV_CVA6 "riscv.cva6.soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(CVA6SoCState, RISCV_CVA6)
> +
> +typedef struct CVA6SoCState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    RISCVHartArrayState cpus;
> +    DeviceState *plic;
> +    MemoryRegion rom;
> +
> +    uint32_t resetvec;
> +} CVA6SoCState;
> +
> +#define TYPE_CVA6_MACHINE MACHINE_TYPE_NAME("cva6")
> +OBJECT_DECLARE_SIMPLE_TYPE(CVA6State, CVA6_MACHINE)
> +
> +typedef struct CVA6State {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +    /*< public >*/
> +    CVA6SoCState soc;
> +}
> +CVA6State;
> +
> +enum {
> +    CVA6_DEBUG,
> +    CVA6_ROM,
> +    CVA6_CLINT,
> +    CVA6_PLIC,
> +    CVA6_UART,
> +    CVA6_TIMER,
> +    CVA6_SPI,
> +    CVA6_ETHERNET,
> +    CVA6_GPIO,
> +    CVA6_DRAM,
> +};
> +
> +enum {
> +    CVA6_UART_IRQ       = 1,
> +    CVA6_SPI_IRQ        = 2,
> +    CVA6_ETH_IRQ        = 3,
> +    CVA6_TIMER0_OVF_IRQ = 4,
> +    CVA6_TIMER0_CMP_IRQ = 5,
> +    CVA6_TIMER1_OVF_IRQ = 6,
> +    CVA6_TIMER1_CMP_IRQ = 7,
> +};
> +
> +#define CLINT_TIMEBASE_FREQ 25000000
> +
> +/* plic register interface in corev_apu/rv_plic/rtl/plic_regmap.sv */
> +

I believe you've missed my comment in v1:

"Where is this file? It's not on QEMU or Linux.

I'm assuming that you're referring to plic_regmap.sv from this repo:

https://github.com/openhwgroup/cva6/tree/master/corev_apu

If that's the case we need to point to this repo in the comment. The commit
msg also works."



Please add the github link in the comment. Thanks,


Daniel






> +#define CVA6_PLIC_NUM_SOURCES           32
> +#define CVA6_PLIC_NUM_PRIORITIES        7
> +#define CVA6_PLIC_PRIORITY_BASE         0x0000
> +#define CVA6_PLIC_PENDING_BASE          0x1000
> +#define CVA6_PLIC_ENABLE_BASE           0x2000
> +#define CVA6_PLIC_ENABLE_STRIDE         0x80
> +#define CVA6_PLIC_CONTEXT_BASE          0x200000
> +#define CVA6_PLIC_CONTEXT_STRIDE        0x1000
> +
> +#endif /* HW_CVA6_H */


