Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB091C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 01:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0tRP-0002Ew-Fj; Sat, 27 Apr 2024 21:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s0tRL-0002Ed-4K
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 21:34:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s0tRI-0006jd-9C
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 21:34:50 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8BxFvCypy1mnjAEAA--.15711S3;
 Sun, 28 Apr 2024 09:34:42 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axz1evpy1mrtoHAA--.17128S3; 
 Sun, 28 Apr 2024 09:34:41 +0800 (CST)
Subject: Re: [PATCH v7 06/17] hw/loongarch: Init efi_boot_memmap table
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 philmd@linaro.org, zltjiangshi@gmail.com
References: <20240426091551.2397867-1-gaosong@loongson.cn>
 <20240426091551.2397867-7-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <80152dbe-220d-3d40-862d-9c26c33a0ab4@loongson.cn>
Date: Sun, 28 Apr 2024 09:34:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240426091551.2397867-7-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axz1evpy1mrtoHAA--.17128S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JrW8WF4kWr1DZFy3GF48AFc_yoW7WFWDpF
 9Iv3Zakrs5JF17XrZ3Xw1jqFn8Zrs7KF12ga47GryFkrnrJr1kWF1fJa4DZFWkJ3y0k3Wq
 vFnY93yUWFsrXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.307,
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



On 2024/4/26 下午5:15, Song Gao wrote:

Message test is also missing there :(

> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240307164835.300412-7-gaosong@loongson.cn>
> ---
>   include/hw/loongarch/boot.h | 27 +++++++++++++++++++++++++
>   include/hw/loongarch/virt.h | 10 ++++++++++
>   hw/loongarch/boot.c         | 40 +++++++++++++++++++++++++++++++++++++
>   hw/loongarch/virt.c         | 11 ++--------
>   4 files changed, 79 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> index cf0e4d4f91..76622af2e2 100644
> --- a/include/hw/loongarch/boot.h
> +++ b/include/hw/loongarch/boot.h
> @@ -21,6 +21,15 @@ typedef struct {
>       uint8_t b[16];
>   } efi_guid_t QEMU_ALIGNED(8);
>   
> +#define EFI_GUID(a, b, c, d...) (efi_guid_t){ {                                \
> +        (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
> +        (b) & 0xff, ((b) >> 8) & 0xff,                                         \
> +        (c) & 0xff, ((c) >> 8) & 0xff, d } }
> +
> +#define LINUX_EFI_BOOT_MEMMAP_GUID \
> +        EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, \
> +                 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
> +
>   struct efi_config_table {
>       efi_guid_t guid;
>       uint64_t *ptr;
> @@ -56,6 +65,24 @@ struct efi_system_table {
>       struct efi_configuration_table *tables;
>   };
>   
> +typedef struct {
> +    uint32_t type;
> +    uint32_t pad;
> +    uint64_t phys_addr;
> +    uint64_t virt_addr;
> +    uint64_t num_pages;
> +    uint64_t attribute;
> +} efi_memory_desc_t;
> +
> +struct efi_boot_memmap {
> +    uint64_t map_size;
> +    uint64_t desc_size;
> +    uint32_t desc_ver;
> +    uint64_t map_key;
> +    uint64_t buff_size;
> +    efi_memory_desc_t map[32];
> +};
> +
>   struct loongarch_boot_info {
>       uint64_t ram_size;
>       const char *kernel_filename;
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index d7a074d69f..8a9fe4053d 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -35,6 +35,16 @@
>   
>   #define COMMAND_LINE_SIZE       512
>   
> +extern struct memmap_entry *memmap_table;
> +extern unsigned memmap_entries;
> +
> +struct memmap_entry {
> +    uint64_t address;
> +    uint64_t length;
> +    uint32_t type;
> +    uint32_t reserved;
> +};
> +
>   struct LoongArchMachineState {
>       /*< private >*/
>       MachineState parent_obj;
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 46a241a04c..18aae3434d 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -63,8 +63,41 @@ static const unsigned int slave_boot_code[] = {
>       0x4c000020,   /* jirl       $zero, $ra,0                   */
>   };
>   
> +static inline void *guidcpy(void *dst, const void *src)
> +{
> +    return memcpy(dst, src, sizeof(efi_guid_t));
> +}
> +
> +static void init_efi_boot_memmap(struct efi_system_table *systab,
> +                                 void *p, void *start)
> +{
> +    unsigned i;
> +    struct efi_boot_memmap *boot_memmap = p;
> +    efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
> +
> +    /* efi_configuration_table 1 */
> +    guidcpy(&systab->tables[0].guid, &tbl_guid);
> +    systab->tables[0].table = (struct efi_configuration_table *)(p - start);
> +    systab->nr_tables = 1;
> +
> +    boot_memmap->desc_size = sizeof(efi_memory_desc_t);
> +    boot_memmap->desc_ver = 1;
> +    boot_memmap->map_size = 0;
> +
> +    efi_memory_desc_t *map = p + sizeof(struct efi_boot_memmap);
> +    for (i = 0; i < memmap_entries; i++) {
> +        map = (void *)boot_memmap + sizeof(*map);
> +        map[i].type = memmap_table[i].type;
> +        map[i].phys_addr = ROUND_UP(memmap_table[i].address, 64 * KiB);
> +        map[i].num_pages = ROUND_DOWN(memmap_table[i].address +
> +                        memmap_table[i].length - map[i].phys_addr, 64 * KiB);
> +        p += sizeof(efi_memory_desc_t);
> +    }
> +}

Do you verify that memory size of VM is the same with qemu command line 
setting? I am ok if the test result is the same.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> +
>   static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
>   {
> +    void *bp_tables_start;
>       struct efi_system_table *systab = p;
>   
>       info->a2 = (uint64_t)p - (uint64_t)start;
> @@ -80,6 +113,13 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
>       p += ROUND_UP(sizeof(struct efi_system_table), 64 * KiB);
>   
>       systab->tables = p;
> +    bp_tables_start = p;
> +
> +    init_efi_boot_memmap(systab, p, start);
> +    p += ROUND_UP(sizeof(struct efi_boot_memmap) +
> +                  sizeof(efi_memory_desc_t) * memmap_entries, 64 * KiB);
> +
> +    systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
>   }
>   
>   static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index bfb88aedab..708aa8bc60 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -378,15 +378,8 @@ static void virt_powerdown_req(Notifier *notifier, void *opaque)
>       acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
>   }
>   
> -struct memmap_entry {
> -    uint64_t address;
> -    uint64_t length;
> -    uint32_t type;
> -    uint32_t reserved;
> -};
> -
> -static struct memmap_entry *memmap_table;
> -static unsigned memmap_entries;
> +struct memmap_entry *memmap_table;
> +unsigned memmap_entries;
>   
>   static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
>   {
> 


