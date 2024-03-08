Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93102C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVRb-0007U4-OX; Fri, 08 Mar 2024 03:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1riVRY-0007TU-KX
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:19:04 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1riVRV-0007ZN-7R
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:19:04 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8CxXOnryepl2jgWAA--.45143S3;
 Fri, 08 Mar 2024 16:18:52 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTs3oyeplIyNRAA--.17143S3; 
 Fri, 08 Mar 2024 16:18:51 +0800 (CST)
Subject: Re: [PATCH v6 01/17] hw/loongarch: Move boot fucntions to boot.c
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-2-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <35727d25-a1e7-93dc-c3ca-d11273b6bca8@loongson.cn>
Date: Fri, 8 Mar 2024 16:18:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240307164835.300412-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTs3oyeplIyNRAA--.17143S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWfGryrCr4rZF4fAF4rGrW8Xwc_yoWkZw4kpF
 ZxZFn5Wrs5Jrn3uwnrX3s8uF98Aw4xGa1agF17Kr1SkFsFgryUur18ury2vFW8ta95KF1Y
 qrn5Kw4jq3WDtrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.08,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2024/3/8 上午12:48, Song Gao wrote:
> Move some boot functions to boot.c and struct
> loongarch_boot_info into struct LoongArchMachineState.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-2-gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c         | 128 ++++++++++++++++++++++++++++++++++++
>   hw/loongarch/meson.build    |   1 +
>   hw/loongarch/virt.c         | 121 +++-------------------------------
>   include/hw/loongarch/boot.h |  21 ++++++
>   include/hw/loongarch/virt.h |   2 +
>   5 files changed, 160 insertions(+), 113 deletions(-)
>   create mode 100644 hw/loongarch/boot.c
>   create mode 100644 include/hw/loongarch/boot.h
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> new file mode 100644
> index 0000000000..a8a725a0a8
> --- /dev/null
> +++ b/hw/loongarch/boot.c
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * LoongArch boot helper functions.
> + *
> + * Copyright (c) 2023 Loongson Technology Corporation Limited
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "target/loongarch/cpu.h"
> +#include "hw/loongarch/virt.h"
> +#include "hw/loader.h"
> +#include "elf.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/reset.h"
> +#include "sysemu/qtest.h"
> +
> +static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
> +{
> +    return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
> +}
> +
> +static int64_t load_kernel_info(struct loongarch_boot_info *info)
> +{
> +    uint64_t kernel_entry, kernel_low, kernel_high;
> +    ssize_t kernel_size;
> +
> +    kernel_size = load_elf(info->kernel_filename, NULL,
> +                           cpu_loongarch_virt_to_phys, NULL,
> +                           &kernel_entry, &kernel_low,
> +                           &kernel_high, NULL, 0,
> +                           EM_LOONGARCH, 1, 0);
> +
> +    if (kernel_size < 0) {
> +        error_report("could not load kernel '%s': %s",
> +                     info->kernel_filename,
> +                     load_elf_strerror(kernel_size));
> +        exit(1);
> +    }
> +    return kernel_entry;
> +}
> +
> +static void reset_load_elf(void *opaque)
> +{
> +    LoongArchCPU *cpu = opaque;
> +    CPULoongArchState *env = &cpu->env;
> +
> +    cpu_reset(CPU(cpu));
> +    if (env->load_elf) {
> +        cpu_set_pc(CPU(cpu), env->elf_address);
> +    }
> +}
> +
> +static void fw_cfg_add_kernel_info(struct loongarch_boot_info *info,
> +                                   FWCfgState *fw_cfg)
> +{
> +    /*
> +     * Expose the kernel, the command line, and the initrd in fw_cfg.
> +     * We don't process them here at all, it's all left to the
> +     * firmware.
> +     */
> +    load_image_to_fw_cfg(fw_cfg,
> +                         FW_CFG_KERNEL_SIZE, FW_CFG_KERNEL_DATA,
> +                         info->kernel_filename,
> +                         false);
> +
> +    if (info->initrd_filename) {
> +        load_image_to_fw_cfg(fw_cfg,
> +                             FW_CFG_INITRD_SIZE, FW_CFG_INITRD_DATA,
> +                             info->initrd_filename, false);
> +    }
> +
> +    if (info->kernel_cmdline) {
> +        fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
> +                       strlen(info->kernel_cmdline) + 1);
> +        fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
> +                          info->kernel_cmdline);
> +    }
> +}
> +
> +static void loongarch_firmware_boot(LoongArchMachineState *lams,
> +                                    struct loongarch_boot_info *info)
> +{
> +    fw_cfg_add_kernel_info(info, lams->fw_cfg);
> +}
> +
> +static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
> +{
> +    int64_t kernel_addr = 0;
> +    LoongArchCPU *lacpu;
> +    CPUState *cs;
> +
> +    if (info->kernel_filename) {
> +        kernel_addr = load_kernel_info(info);
> +    } else {
> +        if (!qtest_enabled()) {
> +            error_report("Need kernel filename\n");
> +            exit(1);
> +        }
> +    }
> +
> +    CPU_FOREACH(cs) {
> +        lacpu = LOONGARCH_CPU(cs);
> +        lacpu->env.load_elf = true;
> +        lacpu->env.elf_address = kernel_addr;
> +    }
> +}
> +
> +void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
> +{
> +    LoongArchMachineState *lams = LOONGARCH_MACHINE(ms);
> +    int i;
> +
> +    /* register reset function */
> +    for (i = 0; i < ms->smp.cpus; i++) {
> +        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cpu(i)));
> +    }
> +
> +    info->kernel_filename = ms->kernel_filename;
> +    info->kernel_cmdline = ms->kernel_cmdline;
> +    info->initrd_filename = ms->initrd_filename;
> +
> +    if (lams->bios_loaded) {
> +        loongarch_firmware_boot(lams, info);
> +    } else {
> +        loongarch_direct_kernel_boot(info);
> +    }
> +}
> diff --git a/hw/loongarch/meson.build b/hw/loongarch/meson.build
> index c0421502ab..d306d82c2e 100644
> --- a/hw/loongarch/meson.build
> +++ b/hw/loongarch/meson.build
> @@ -1,6 +1,7 @@
>   loongarch_ss = ss.source_set()
>   loongarch_ss.add(files(
>       'fw_cfg.c',
> +    'boot.c',
>   ))
>   loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: [files('virt.c'), fdt])
>   loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c'))
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 1e98d8bda5..bbd5cc1d4d 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -46,14 +46,6 @@
>   #include "hw/block/flash.h"
>   #include "qemu/error-report.h"
>   
> -
> -struct loaderparams {
> -    uint64_t ram_size;
> -    const char *kernel_filename;
> -    const char *kernel_cmdline;
> -    const char *initrd_filename;
> -};
> -
>   static PFlashCFI01 *virt_flash_create1(LoongArchMachineState *lams,
>                                          const char *name,
>                                          const char *alias_prop_name)
> @@ -411,31 +403,6 @@ static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
>       memmap_entries++;
>   }
>   
> -static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
> -{
> -    return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
> -}
> -
> -static int64_t load_kernel_info(const struct loaderparams *loaderparams)
> -{
> -    uint64_t kernel_entry, kernel_low, kernel_high;
> -    ssize_t kernel_size;
> -
> -    kernel_size = load_elf(loaderparams->kernel_filename, NULL,
> -                           cpu_loongarch_virt_to_phys, NULL,
> -                           &kernel_entry, &kernel_low,
> -                           &kernel_high, NULL, 0,
> -                           EM_LOONGARCH, 1, 0);
> -
> -    if (kernel_size < 0) {
> -        error_report("could not load kernel '%s': %s",
> -                     loaderparams->kernel_filename,
> -                     load_elf_strerror(kernel_size));
> -        exit(1);
> -    }
> -    return kernel_entry;
> -}
> -
>   static DeviceState *create_acpi_ged(DeviceState *pch_pic, LoongArchMachineState *lams)
>   {
>       DeviceState *dev;
> @@ -716,67 +683,6 @@ static void loongarch_firmware_init(LoongArchMachineState *lams)
>       }
>   }
>   
> -static void reset_load_elf(void *opaque)
> -{
> -    LoongArchCPU *cpu = opaque;
> -    CPULoongArchState *env = &cpu->env;
> -
> -    cpu_reset(CPU(cpu));
> -    if (env->load_elf) {
> -        cpu_set_pc(CPU(cpu), env->elf_address);
> -    }
> -}
> -
> -static void fw_cfg_add_kernel_info(const struct loaderparams *loaderparams,
> -                                   FWCfgState *fw_cfg)
> -{
> -    /*
> -     * Expose the kernel, the command line, and the initrd in fw_cfg.
> -     * We don't process them here at all, it's all left to the
> -     * firmware.
> -     */
> -    load_image_to_fw_cfg(fw_cfg,
> -                         FW_CFG_KERNEL_SIZE, FW_CFG_KERNEL_DATA,
> -                         loaderparams->kernel_filename,
> -                         false);
> -
> -    if (loaderparams->initrd_filename) {
> -        load_image_to_fw_cfg(fw_cfg,
> -                             FW_CFG_INITRD_SIZE, FW_CFG_INITRD_DATA,
> -                             loaderparams->initrd_filename, false);
> -    }
> -
> -    if (loaderparams->kernel_cmdline) {
> -        fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
> -                       strlen(loaderparams->kernel_cmdline) + 1);
> -        fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
> -                          loaderparams->kernel_cmdline);
> -    }
> -}
> -
> -static void loongarch_firmware_boot(LoongArchMachineState *lams,
> -                                    const struct loaderparams *loaderparams)
> -{
> -    fw_cfg_add_kernel_info(loaderparams, lams->fw_cfg);
> -}
> -
> -static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
> -                                         const struct loaderparams *loaderparams)
> -{
> -    MachineState *machine = MACHINE(lams);
> -    int64_t kernel_addr = 0;
> -    LoongArchCPU *lacpu;
> -    int i;
> -
> -    kernel_addr = load_kernel_info(loaderparams);
> -    if (!machine->firmware) {
> -        for (i = 0; i < machine->smp.cpus; i++) {
> -            lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
> -            lacpu->env.load_elf = true;
> -            lacpu->env.elf_address = kernel_addr;
> -        }
> -    }
> -}
>   
>   static void loongarch_qemu_write(void *opaque, hwaddr addr,
>                                    uint64_t val, unsigned size)
> @@ -832,7 +738,6 @@ static void loongarch_init(MachineState *machine)
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       CPUState *cpu;
>       char *ramName = NULL;
> -    struct loaderparams loaderparams = { };
>   
>       if (!cpu_model) {
>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
> @@ -935,24 +840,8 @@ static void loongarch_init(MachineState *machine)
>                           sizeof(struct memmap_entry) * (memmap_entries));
>       }
>       fdt_add_fw_cfg_node(lams);
> -    loaderparams.ram_size = ram_size;
> -    loaderparams.kernel_filename = machine->kernel_filename;
> -    loaderparams.kernel_cmdline = machine->kernel_cmdline;
> -    loaderparams.initrd_filename = machine->initrd_filename;
> -    /* load the kernel. */
> -    if (loaderparams.kernel_filename) {
> -        if (lams->bios_loaded) {
> -            loongarch_firmware_boot(lams, &loaderparams);
> -        } else {
> -            loongarch_direct_kernel_boot(lams, &loaderparams);
> -        }
> -    }
>       fdt_add_flash_node(lams);
> -    /* register reset function */
> -    for (i = 0; i < machine->smp.cpus; i++) {
> -        lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
> -        qemu_register_reset(reset_load_elf, lacpu);
> -    }
> +
>       /* Initialize the IO interrupt subsystem */
>       loongarch_irq_init(lams);
>       fdt_add_irqchip_node(lams);
> @@ -976,7 +865,13 @@ static void loongarch_init(MachineState *machine)
>        */
>       fdt_base = 1 * MiB;
>       qemu_fdt_dumpdtb(machine->fdt, lams->fdt_size);
> -    rom_add_blob_fixed("fdt", machine->fdt, lams->fdt_size, fdt_base);
> +    rom_add_blob_fixed_as("fdt", machine->fdt, lams->fdt_size, fdt_base,
> +                          &address_space_memory);
> +    qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
> +            rom_ptr_for_as(&address_space_memory, fdt_base, lams->fdt_size));
> +
> +    lams->bootinfo.ram_size = ram_size;
> +    loongarch_load_kernel(machine, &lams->bootinfo);
>   }
>   
>   bool loongarch_is_acpi_enabled(LoongArchMachineState *lams)
> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> new file mode 100644
> index 0000000000..3275c1e295
> --- /dev/null
> +++ b/include/hw/loongarch/boot.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Definitions for LoongArch boot.
> + *
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef HW_LOONGARCH_BOOT_H
> +#define HW_LOONGARCH_BOOT_H
> +
> +struct loongarch_boot_info {
> +    uint64_t ram_size;
> +    const char *kernel_filename;
> +    const char *kernel_cmdline;
> +    const char *initrd_filename;
> +    uint64_t a0, a1, a2;
> +};
> +
> +void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info);
> +
> +#endif /* HW_LOONGARCH_BOOT_H */
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 252f7df7f4..cf2f2bfb19 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -13,6 +13,7 @@
>   #include "qemu/queue.h"
>   #include "hw/intc/loongarch_ipi.h"
>   #include "hw/block/flash.h"
> +#include "hw/loongarch/boot.h"
>   
>   #define LOONGARCH_MAX_CPUS      256
>   
> @@ -55,6 +56,7 @@ struct LoongArchMachineState {
>       MemoryRegion system_iocsr;
>       MemoryRegion iocsr_mem;
>       AddressSpace as_iocsr;
> +    struct loongarch_boot_info bootinfo;
>   };
>   
>   #define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


