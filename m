Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6758C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHeY-0002xi-0G; Thu, 02 Jul 2026 09:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfHeS-0002xA-U1
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:40:24 -0400
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfHeQ-0002MK-BY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:40:24 -0400
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380f3c172f5so214251a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782999621; x=1783604421; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qEJagJJB8d/UT1dEARi/ieGivTtepnXkDt36O3ubz04=;
 b=sEosvpQBGLQInb3q6zEUY1osZY7eSj1Lzjg6QbKbV1v1mpsTBHanR6qsqa1ZqVzsmd
 OKYgv6ar90uOIdVsYMSwKFRJuZ7vuxO13X8255LwyGf2kKVlpbBF9W81aGfCZI8tWBnF
 XMrosv9bWIsqEF59JdWzjrNlhCXziGK9pEmMpKW15r1h+vJjcJB0kt9+oGK1NXYHRQgC
 ZlW4TVNZOL0hg/jtghQZFtC/xjU2dWjM4CymMyEKG9bpObY8FpYhVXy12PN9W5jAiAC8
 5BE4J7h8yZ4VGr3bwz6pFkG5tsf7NYnI9K6Xx0SDIX9F5DdPZ5zUQ4T5Hqi1xjGxzN4L
 Tvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782999621; x=1783604421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEJagJJB8d/UT1dEARi/ieGivTtepnXkDt36O3ubz04=;
 b=EhIpxyQGZkIMp1VTBeTvg6WmURIvPToLDPMa5f7xddkhlno61aQ9eTohmmzrqCrG+s
 A/k7HY6llT6jTjaNrKf6JGCX2NrJTxGquQKvI4EW42uepmG14zZlcStxNiMweXYls+no
 E5AqfCS9WlSR4kGacHyQvai2L/L2PQzJpWEAFQJoQ1X67Ph2DfTGGAqD3jvJRQB4aahp
 D19kIouG5qsHVTa5gb9fDbwFBT+T207ZVxKFiPLqmcq8nlpx/QIFn56SJyXZ3rb33Qs0
 znktvcM/l3LKVI/YWPHbwz8ZPdN0JTUKqsHTgKRcGkM1oQKGOdWIVw/kL0kmlRsf3V7P
 iNXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGoQUJUTbRzbyOgmcKmbnlAJorhgzLuJwGCJ/epwU9bh78dBA+t9HWEiWVDByfE4p+wvuNuUkRMAIy@nongnu.org
X-Gm-Message-State: AOJu0Yxfr6t9cRSBbNZHP1RYEOPMLxjrCK94vxVtnhghMRCbW8vTFQXI
 VJJrhtoDDIeAD3z18Fm8XcJE9WxwvPlH/2HWNgIQbhaPmJfdqbIwE5g5
X-Gm-Gg: AfdE7cny0WiVPedsph501tKXeU4cn8ZjoOXeJDSxEMffsCihJknEjq2DNnCXYLi+sym
 ZY0B+qe3MTLU/3VxHMcumXne6Ryg3yhsS33/T5WvPTNzPZU6tvAj/oO1xcvYBzEkMbp7Nh2bsFm
 Q4GmCgGZgfpRgkU4amE7Tw2heYe1cGNWvNqZMft5CqxX8UIWttbuD1bcy5KbM9X7ZJR7MdA599u
 hySS/N5yBiN/RaUtQR5014QOr+CVotsvrZen7nPZdfCnCq3uGnOeXUMOx9yhTN3mzwmvcvHCPw2
 ycWYSvR0QHrQkB5UC6+woE+0tyFiCcBDePQ+NGoZj4tsQQ4TNDLb4tBS+NqDgwg8Eu/l1Xqb/Zl
 W/t96OvR9uNJ1VxDFq4SYIh6P3PmtfXZbG8tR9R/IrFJGLnvP5oME6elc9eDa1jk9GkGKe+fY/B
 JbK0ZmhBLlimNiQ3z4Z9fSv2johnYxam4NLhWczZlVJ3GFGw/V
X-Received: by 2002:a17:90a:d44b:b0:37f:f080:38f5 with SMTP id
 98e67ed59e1d1-380aa1b86f4mr6061968a91.22.1782999620786; 
 Thu, 02 Jul 2026 06:40:20 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd221bsm10208741eec.22.2026.07.02.06.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:40:20 -0700 (PDT)
Date: Thu, 2 Jul 2026 21:40:17 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 alistair.francis@wdc.com, farosas@suse.de, lvivier@redhat.com,
 liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 4/5] hw/riscv: Add Milk-V Duo board support
Message-ID: <akZqNlzqKFo5QkcH@ChaodeMacBook-Pro.local>
References: <20260616190147.1286316-1-visitorckw@gmail.com>
 <20260616190147.1286316-5-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616190147.1286316-5-visitorckw@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::1;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x01.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 16, 2026 at 07:01:46PM +0800, Kuan-Wei Chiu wrote:
> Add support for the Milk-V Duo development board, which is powered by
> the Sophgo CV1800B SoC.
> 
> The implementation includes:
> - Board-level machine initialization with 64mb of default ram.
> - Integration of the CV1800B SoC.
> - Support for loading external FDT, kernel, and initrd images.
> - Proper setup of the reset vector to match the CV1800B's boot flow.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  MAINTAINERS                                 |  11 ++
>  configs/devices/riscv64-softmmu/default.mak |   1 +
>  hw/riscv/Kconfig                            |   6 +
>  hw/riscv/meson.build                        |   1 +
>  hw/riscv/milkv_duo.c                        | 124 ++++++++++++++++++++
>  5 files changed, 143 insertions(+)
>  create mode 100644 hw/riscv/milkv_duo.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93df53d87f..e197dcb5b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1797,6 +1797,17 @@ F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
>  F: tests/qtest/k230-wdt-test.c
>  
> +Milk-V Duo
> +M: Kuan-Wei Chiu <visitorckw@gmail.com>
> +S: Maintained
> +F: hw/char/dw8250.c
> +F: hw/misc/cv1800b_clk.c
> +F: hw/riscv/cv1800b.c
> +F: hw/riscv/milkv_duo.c
> +F: include/hw/char/dw8250.h
> +F: include/hw/misc/cv1800b_clk.h
> +F: include/hw/riscv/cv1800b.h
> +
>  RX Machines
>  -----------
>  rx-gdbsim
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
> index a8e4d0ab33..2ba91b14d4 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -13,3 +13,4 @@
>  # CONFIG_SHAKTI_C=n
>  # CONFIG_XIANGSHAN_KUNMINGHU=n
>  # CONFIG_MIPS_BOSTON_AIA=n
> +# CONFIG_MILKV_DUO=n
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 299baed4a8..42a0e78574 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -157,3 +157,9 @@ config SOPHGO_CV1800B
>      select SIFIVE_PLIC
>      select SOPHGO_CV1800B_CLK
>      select DW8250
> +
> +config MILKV_DUO
> +    bool
> +    depends on RISCV64
> +    default y
> +    select SOPHGO_CV1800B
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 6c242d77da..8c88f2bc25 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -20,5 +20,6 @@ riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
>  riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
>  
>  riscv_ss.add(when: 'CONFIG_SOPHGO_CV1800B', if_true: files('cv1800b.c'))
> +riscv_ss.add(when: 'CONFIG_MILKV_DUO', if_true: files('milkv_duo.c'))
>  
>  hw_arch += {'riscv': riscv_ss}
> diff --git a/hw/riscv/milkv_duo.c b/hw/riscv/milkv_duo.c
> new file mode 100644
> index 0000000000..8e9a553a57
> --- /dev/null
> +++ b/hw/riscv/milkv_duo.c
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Milk-V Duo board
> + *
> + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "hw/core/boards.h"
> +#include "hw/riscv/cv1800b.h"
> +#include "hw/riscv/boot.h"
> +#include "target/riscv/cpu-qom.h"
> +#include "system/system.h"
> +#include "system/device_tree.h"
> +#include "qemu/error-report.h"
> +#include "hw/core/loader.h"
> +#include <libfdt.h>
> +#include "hw/riscv/machines-qom.h"
> +
> +struct MilkVDuoState {
> +    MachineState parent_obj;
> +    CV1800BSoCState soc;
> +};
> +
> +#define TYPE_MILK_V_DUO MACHINE_TYPE_NAME("milkv-duo")
> +OBJECT_DECLARE_SIMPLE_TYPE(MilkVDuoState, MILK_V_DUO)
> +
> +static void milkv_duo_init(MachineState *machine)
> +{
> +    MilkVDuoState *s = MILK_V_DUO(machine);
> +    MemoryRegion *system_memory = get_system_memory();
> +    RISCVBootInfo boot_info;
> +    hwaddr firmware_load_addr, firmware_end_addr;
> +    hwaddr fdt_load_addr = 0;
> +    int fdt_size = 0;
> +    uint64_t kernel_entry = 0;
> +
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_CV1800B_SOC);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +
> +    memory_region_add_subregion(system_memory,
> +                                cv1800b_memmap[CV1800B_DEV_DRAM].base,
> +                                machine->ram);
> +
> +    riscv_boot_info_init(&boot_info, &s->soc.cpus);
> +
> +    firmware_load_addr = cv1800b_memmap[CV1800B_DEV_DRAM].base;
> +    firmware_end_addr = firmware_load_addr;
> +    if (machine->firmware) {
> +        firmware_end_addr = riscv_find_and_load_firmware(machine, machine->firmware,
> +                                                         &firmware_load_addr, NULL);
> +    }
> +
> +    if (machine->dtb) {
> +        machine->fdt = load_device_tree(machine->dtb, &fdt_size);
> +        if (!machine->fdt) {
> +            error_report("Failed to load device tree");
> +            exit(1);
> +        }
> +
> +        if (machine->kernel_cmdline && *machine->kernel_cmdline) {
> +            if (fdt_path_offset(machine->fdt, "/chosen") < 0) {
> +                qemu_fdt_add_subnode(machine->fdt, "/chosen");
> +            }
> +            qemu_fdt_setprop_string(machine->fdt, "/chosen", "bootargs",
> +                                    machine->kernel_cmdline);
> +        }
> +    }
> +
> +    if (machine->kernel_filename) {
> +        hwaddr kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
> +                                                                firmware_end_addr);
> +        riscv_load_kernel(machine, &boot_info, kernel_start_addr, true, NULL);
> +        kernel_entry = boot_info.image_low_addr;
> +    }
> +
> +    if (machine->dtb) {
> +        fdt_load_addr = riscv_compute_fdt_addr(cv1800b_memmap[CV1800B_DEV_DRAM].base,
> +                                               machine->ram_size, machine, &boot_info);
> +        rom_add_blob_fixed_as("fdt", machine->fdt, fdt_size, fdt_load_addr,
> +                              &address_space_memory);
> +    }
> +
> +    riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
> +                              firmware_load_addr,
> +                              cv1800b_memmap[CV1800B_DEV_ROM].base,
> +                              cv1800b_memmap[CV1800B_DEV_ROM].size,
> +                              kernel_entry,
> +                              fdt_load_addr);
> +}
> +
> +static void milkv_duo_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    static const char *const valid_cpu_types[] = {
> +        TYPE_RISCV_CPU_THEAD_C906,
> +        NULL
> +    };
> +
> +    mc->desc = "Milk-V Duo Board (CV1800B)";
> +    mc->init = milkv_duo_init;
> +    mc->max_cpus = 2;
> +    mc->default_cpu_type = TYPE_RISCV_CPU_THEAD_C906;
> +    mc->valid_cpu_types = valid_cpu_types;
> +    mc->default_ram_size = 64 * MiB;
> +    mc->default_ram_id = "riscv.milkv_duo.ram";
> +}
> +
> +static const TypeInfo milkv_duo_machine_type_info = {
> +    .name = TYPE_MILK_V_DUO,
> +    .parent = TYPE_MACHINE,
> +    .instance_size = sizeof(MilkVDuoState),
> +    .class_init = milkv_duo_machine_class_init,
> +    .interfaces = riscv64_machine_interfaces,
> +};
> +
> +static void milkv_duo_machine_register_types(void)
> +{
> +    type_register_static(&milkv_duo_machine_type_info);
> +}
> +
> +type_init(milkv_duo_machine_register_types)
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
> 

