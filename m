Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24C1C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVbn-0007O1-1v; Fri, 08 Mar 2024 03:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1riVbk-0007NJ-UK
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:29:36 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1riVbi-00027p-0q
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:29:36 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8CxifBqzOpliDkWAA--.55470S3;
 Fri, 08 Mar 2024 16:29:31 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxbRNozOplxidRAA--.19136S3; 
 Fri, 08 Mar 2024 16:29:28 +0800 (CST)
Subject: Re: [PATCH v6 05/17] hw/loongarch: Init efi_system_table
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-6-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <75f9e3fd-7796-c743-c29c-0be11a5cf511@loongson.cn>
Date: Fri, 8 Mar 2024 16:29:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240307164835.300412-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbRNozOplxidRAA--.19136S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw4rGFy8tF4rXF17Gw13ZFc_yoWrJr15pF
 yrZry3Krs5JrnxWr93tF1akFn8Ars3GF1agr97J34Fyr4DJrykur1UKasFvFW8Jr4Fyw1Y
 vr1v93yUWFsav3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xO
 z3UUUUU==
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
> Add init_systab and set boot_info->a2
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-6-gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c         | 22 +++++++++++++++++
>   include/hw/loongarch/boot.h | 48 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 70 insertions(+)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index ca65dfde07..1e31e2a59f 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -63,6 +63,25 @@ static const unsigned int slave_boot_code[] = {
>       0x4c000020,   /* jirl       $r0,$r1,0           */
>   };
>   
> +static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
> +{
> +    struct efi_system_table *systab = p;
> +
> +    info->a2 = (uint64_t)p - (uint64_t)start;
> +
> +    systab->hdr.signature = EFI_SYSTEM_TABLE_SIGNATURE;
> +    systab->hdr.revision = EFI_SPECIFICATION_VERSION;
> +    systab->hdr.revision = sizeof(struct efi_system_table),
> +    systab->fw_revision = FW_VERSION << 16 | FW_PATCHLEVEL << 8;
> +    systab->runtime = 0;
> +    systab->boottime = 0;
> +    systab->nr_tables = 0;
> +
> +    p += ROUND_UP(sizeof(struct efi_system_table), 64);
> +
> +    systab->tables = p;
> +}
> +
>   static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
>   {
>       hwaddr cmdline_addr = (hwaddr)p - (hwaddr)start;
> @@ -135,6 +154,7 @@ static void reset_load_elf(void *opaque)
>   	if (cpu == LOONGARCH_CPU(first_cpu)) {
>               env->gpr[4] = env->boot_info->a0;
>               env->gpr[5] = env->boot_info->a1;
> +            env->gpr[6] = env->boot_info->a2;
>           }
>           cpu_set_pc(CPU(cpu), env->elf_address);
>       }
> @@ -182,6 +202,8 @@ static void init_boot_rom(struct loongarch_boot_info *info, void *p)
>   
>       init_cmdline(info, p, start);
>       p += COMMAND_LINE_SIZE;
> +
> +    init_systab(info, p, start);
>   }
>   
>   static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> index 3275c1e295..65ad406f02 100644
> --- a/include/hw/loongarch/boot.h
> +++ b/include/hw/loongarch/boot.h
> @@ -8,6 +8,54 @@
>   #ifndef HW_LOONGARCH_BOOT_H
>   #define HW_LOONGARCH_BOOT_H
>   
> +/* UEFI 2.10 */
> +#define EFI_SYSTEM_TABLE_SIGNATURE       0x5453595320494249
> +#define EFI_2_100_SYSTEM_TABLE_REVISION  ((2<<16) | (100))
> +#define EFI_SPECIFICATION_VERSION        EFI_SYSTEM_TABLE_REVISION
> +#define EFI_SYSTEM_TABLE_REVISION        EFI_2_100_SYSTEM_TABLE_REVISION
> +
> +#define FW_VERSION 0x1
> +#define FW_PATCHLEVEL 0x0
> +
> +typedef struct {
> +    uint8_t b[16];
> +} efi_guid_t __attribute__((aligned(8)));
> +
> +struct efi_config_table {
> +    efi_guid_t guid;
> +    uint64_t *ptr;
> +    const char name[16];
> +};
> +
> +typedef struct {
> +    uint64_t signature;
> +    uint32_t revision;
> +    uint32_t headersize;
> +    uint32_t crc32;
> +    uint32_t reserved;
> +} efi_table_hdr_t;
> +
> +struct efi_configuration_table {
> +    efi_guid_t guid;
> +    void *table;
> +};
> +
> +struct efi_system_table {
> +    efi_table_hdr_t hdr;
> +    uint64_t fw_vendor;        /* physical addr of CHAR16 vendor string */
> +    uint32_t fw_revision;
> +    uint64_t con_in_handle;
> +    uint64_t *con_in;
> +    uint64_t con_out_handle;
> +    uint64_t *con_out;
> +    uint64_t stderr_handle;
> +    uint64_t stderr_placeholder;
> +    uint64_t *runtime;
> +    uint64_t *boottime;
> +    uint64_t nr_tables;
> +    struct efi_configuration_table *tables;
> +};
> +
>   struct loongarch_boot_info {
>       uint64_t ram_size;
>       const char *kernel_filename;
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


