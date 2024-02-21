Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9546CC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcod1-0008Ra-NS; Wed, 21 Feb 2024 10:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rcoaS-0007sF-Ew
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:32:44 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rchvG-00035J-IV
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:25:49 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Ax++iGs9VlxLwPAA--.21223S3;
 Wed, 21 Feb 2024 16:25:42 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxrhODs9Vl1qo9AA--.38362S3; 
 Wed, 21 Feb 2024 16:25:42 +0800 (CST)
Subject: Re: [PATCH V2 1/1] loongarch: Change the UEFI loading mode to
 loongarch
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Andrea Bolognani <abologna@redhat.com>, maobibo@loongson.cn,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 zhaotianrui@loongson.cn
References: <cover.1708336919.git.lixianglai@loongson.cn>
 <0bd892aa9b88e0f4cc904cb70efd0251fc1cde29.1708336919.git.lixianglai@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <471e15f0-8463-6f29-f09a-4d5cf528e12d@loongson.cn>
Date: Wed, 21 Feb 2024 16:25:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0bd892aa9b88e0f4cc904cb70efd0251fc1cde29.1708336919.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxrhODs9Vl1qo9AA--.38362S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKrykWFW3Zw17CF15Jw4rtFc_yoWDXr4fpF
 W8CFsY9r18XFnrWr1xJwsxGa40yrn7Ka45Wrya9r10kasxWr18WrWfK3y0yFy8Z34kXF4j
 gFn5XFZ2kanrXrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9
 N3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.297,
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

在 2024/2/19 下午6:34, Xianglai Li 写道:
> The UEFI loading mode in loongarch is very different
> from that in other architectures:loongarch's UEFI code
> is in rom, while other architectures' UEFI code is in flash.
>
> loongarch UEFI can be loaded as follows:
> -machine virt,pflash=pflash0-format
> -bios ./QEMU_EFI.fd
>
> Other architectures load UEFI using the following methods:
> -machine virt,pflash0=pflash0-format,pflash1=pflash1-format
>
> loongarch's UEFI loading method makes qemu and libvirt incompatible
> when using NVRAM, and the cost of loongarch's current loading method
> far outweighs the benefits, so we decided to use the same UEFI loading
> scheme as other architectures.
>
> Cc: Andrea Bolognani <abologna@redhat.com>
> Cc: maobibo@loongson.cn
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: zhaotianrui@loongson.cn
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Andrea Bolognani <abologna@redhat.com>
> ---
>   hw/loongarch/acpi-build.c   |  29 +++++++++--
>   hw/loongarch/virt.c         | 101 ++++++++++++++++++++++++++----------
>   include/hw/loongarch/virt.h |  10 ++--
>   3 files changed, 107 insertions(+), 33 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index a1c4198741..6c75f216ea 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -314,16 +314,39 @@ static void build_pci_device_aml(Aml *scope, LoongArchMachineState *lams)
>   static void build_flash_aml(Aml *scope, LoongArchMachineState *lams)
>   {
>       Aml *dev, *crs;
> +    MemoryRegion *flash_mem;
>   
> -    hwaddr flash_base = VIRT_FLASH_BASE;
> -    hwaddr flash_size = VIRT_FLASH_SIZE;
> +    hwaddr flash0_base;
> +    hwaddr flash0_size;
> +
> +    hwaddr flash1_base;
> +    hwaddr flash1_size;
> +
> +    flash_mem = pflash_cfi01_get_memory(lams->flash[0]);
> +    flash0_base = flash_mem->addr;
> +    flash0_size = flash_mem->size;
> +
> +    flash_mem = pflash_cfi01_get_memory(lams->flash[1]);
> +    flash1_base = flash_mem->addr;
> +    flash1_size = flash_mem->size;
>   
>       dev = aml_device("FLS0");
>       aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0015")));
>       aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>   
>       crs = aml_resource_template();
> -    aml_append(crs, aml_memory32_fixed(flash_base, flash_size, AML_READ_WRITE));
> +    aml_append(crs, aml_memory32_fixed(flash0_base, flash0_size,
> +                                       AML_READ_WRITE));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +
> +    dev = aml_device("FLS1");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0015")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_memory32_fixed(flash1_base, flash1_size,
> +                                       AML_READ_WRITE));
>       aml_append(dev, aml_name_decl("_CRS", crs));
>       aml_append(scope, dev);
>   }
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 0ad7d8c887..a7b9199e70 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -54,7 +54,9 @@ struct loaderparams {
>       const char *initrd_filename;
>   };
>   
> -static void virt_flash_create(LoongArchMachineState *lams)
> +static PFlashCFI01 *virt_flash_create1(LoongArchMachineState *lams,
> +                                       const char *name,
> +                                       const char *alias_prop_name)
>   {
>       DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
>   
> @@ -66,45 +68,78 @@ static void virt_flash_create(LoongArchMachineState *lams)
>       qdev_prop_set_uint16(dev, "id1", 0x18);
>       qdev_prop_set_uint16(dev, "id2", 0x00);
>       qdev_prop_set_uint16(dev, "id3", 0x00);
> -    qdev_prop_set_string(dev, "name", "virt.flash");
> -    object_property_add_child(OBJECT(lams), "virt.flash", OBJECT(dev));
> -    object_property_add_alias(OBJECT(lams), "pflash",
> +    qdev_prop_set_string(dev, "name", name);
> +    object_property_add_child(OBJECT(lams), name, OBJECT(dev));
> +    object_property_add_alias(OBJECT(lams), alias_prop_name,
>                                 OBJECT(dev), "drive");
> +    return PFLASH_CFI01(dev);
> +}
>   
> -    lams->flash = PFLASH_CFI01(dev);
> +static void virt_flash_create(LoongArchMachineState *lams)
> +{
> +    lams->flash[0] = virt_flash_create1(lams, "virt.flash0", "pflash0");
> +    lams->flash[1] = virt_flash_create1(lams, "virt.flash1", "pflash1");
>   }
>   
> -static void virt_flash_map(LoongArchMachineState *lams,
> -                           MemoryRegion *sysmem)
> +static void virt_flash_map1(PFlashCFI01 *flash,
> +                            hwaddr base, hwaddr size,
> +                            MemoryRegion *sysmem)
>   {
> -    PFlashCFI01 *flash = lams->flash;
>       DeviceState *dev = DEVICE(flash);
> -    hwaddr base = VIRT_FLASH_BASE;
> -    hwaddr size = VIRT_FLASH_SIZE;
> +    BlockBackend *blk;
> +    hwaddr real_size = size;
> +
> +    blk = pflash_cfi01_get_blk(flash);
> +    if (blk) {
> +        real_size = blk_getlength(blk);
> +        assert(real_size && real_size <= size);
> +    }
>   
> -    assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
> -    assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
> +    assert(QEMU_IS_ALIGNED(real_size, VIRT_FLASH_SECTOR_SIZE));
> +    assert(real_size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
>   
> -    qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
> +    qdev_prop_set_uint32(dev, "num-blocks", real_size / VIRT_FLASH_SECTOR_SIZE);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       memory_region_add_subregion(sysmem, base,
>                                   sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
> +}
>   
> +static void virt_flash_map(LoongArchMachineState *lams,
> +                           MemoryRegion *sysmem)
> +{
> +    PFlashCFI01 *flash0 = lams->flash[0];
> +    PFlashCFI01 *flash1 = lams->flash[1];
> +
> +    virt_flash_map1(flash0, VIRT_FLASH0_BASE, VIRT_FLASH0_SIZE, sysmem);
> +    virt_flash_map1(flash1, VIRT_FLASH1_BASE, VIRT_FLASH1_SIZE, sysmem);
>   }
>   
>   static void fdt_add_flash_node(LoongArchMachineState *lams)
>   {
>       MachineState *ms = MACHINE(lams);
>       char *nodename;
> +    MemoryRegion *flash_mem;
> +
> +    hwaddr flash0_base;
> +    hwaddr flash0_size;
>   
> -    hwaddr flash_base = VIRT_FLASH_BASE;
> -    hwaddr flash_size = VIRT_FLASH_SIZE;
> +    hwaddr flash1_base;
> +    hwaddr flash1_size;
>   
> -    nodename = g_strdup_printf("/flash@%" PRIx64, flash_base);
> +    flash_mem = pflash_cfi01_get_memory(lams->flash[0]);
> +    flash0_base = flash_mem->addr;
> +    flash0_size = flash_mem->size;
> +
> +    flash_mem = pflash_cfi01_get_memory(lams->flash[1]);
> +    flash1_base = flash_mem->addr;
> +    flash1_size = flash_mem->size;
> +
> +    nodename = g_strdup_printf("/flash@%" PRIx64, flash0_base);
>       qemu_fdt_add_subnode(ms->fdt, nodename);
>       qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "cfi-flash");
>       qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
> -                                 2, flash_base, 2, flash_size);
> +                                 2, flash0_base, 2, flash0_size,
> +                                 2, flash1_base, 2, flash1_size);
>       qemu_fdt_setprop_cell(ms->fdt, nodename, "bank-width", 4);
>       g_free(nodename);
>   }
> @@ -637,12 +672,32 @@ static void loongarch_firmware_init(LoongArchMachineState *lams)
>   {
>       char *filename = MACHINE(lams)->firmware;
>       char *bios_name = NULL;
> -    int bios_size;
> +    int bios_size, i;
> +    BlockBackend *pflash_blk0;
> +    MemoryRegion *mr;
>   
>       lams->bios_loaded = false;
>   
> +    /* Map legacy -drive if=pflash to machine properties */
> +    for (i = 0; i < ARRAY_SIZE(lams->flash); i++) {
> +        pflash_cfi01_legacy_drive(lams->flash[i],
> +                                  drive_get(IF_PFLASH, 0, i));
> +    }
> +
>       virt_flash_map(lams, get_system_memory());
>   
> +    pflash_blk0 = pflash_cfi01_get_blk(lams->flash[0]);
> +
> +    if (pflash_blk0) {
> +        if (filename) {
> +            error_report("cannot use both '-bios' and '-drive if=pflash'"
> +                         "options at once");
> +            exit(1);
> +        }
> +        lams->bios_loaded = true;
> +        return;
> +    }
> +
>       if (filename) {
>           bios_name = qemu_find_file(QEMU_FILE_TYPE_BIOS, filename);
>           if (!bios_name) {
> @@ -650,21 +705,15 @@ static void loongarch_firmware_init(LoongArchMachineState *lams)
>               exit(1);
>           }
>   
> -        bios_size = load_image_targphys(bios_name, VIRT_BIOS_BASE, VIRT_BIOS_SIZE);
> +        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(lams->flash[0]), 0);
> +        bios_size = load_image_mr(bios_name, mr);
>           if (bios_size < 0) {
>               error_report("Could not load ROM image '%s'", bios_name);
>               exit(1);
>           }
> -
>           g_free(bios_name);
> -
> -        memory_region_init_ram(&lams->bios, NULL, "loongarch.bios",
> -                               VIRT_BIOS_SIZE, &error_fatal);
> -        memory_region_set_readonly(&lams->bios, true);
> -        memory_region_add_subregion(get_system_memory(), VIRT_BIOS_BASE, &lams->bios);
>           lams->bios_loaded = true;
>       }
> -
>   }
>   
>   static void reset_load_elf(void *opaque)
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 6ef9a92394..252f7df7f4 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -18,10 +18,12 @@
>   
>   #define VIRT_FWCFG_BASE         0x1e020000UL
>   #define VIRT_BIOS_BASE          0x1c000000UL
> -#define VIRT_BIOS_SIZE          (4 * MiB)
> +#define VIRT_BIOS_SIZE          (16 * MiB)
>   #define VIRT_FLASH_SECTOR_SIZE  (128 * KiB)
> -#define VIRT_FLASH_BASE         0x1d000000UL
> -#define VIRT_FLASH_SIZE         (16 * MiB)
> +#define VIRT_FLASH0_BASE        VIRT_BIOS_BASE
> +#define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE
> +#define VIRT_FLASH1_BASE        0x1d000000UL
> +#define VIRT_FLASH1_SIZE        (16 * MiB)
>   
>   #define VIRT_LOWMEM_BASE        0
>   #define VIRT_LOWMEM_SIZE        0x10000000
> @@ -49,7 +51,7 @@ struct LoongArchMachineState {
>       int          fdt_size;
>       DeviceState *platform_bus_dev;
>       PCIBus       *pci_bus;
> -    PFlashCFI01  *flash;
> +    PFlashCFI01  *flash[2];
>       MemoryRegion system_iocsr;
>       MemoryRegion iocsr_mem;
>       AddressSpace as_iocsr;


