Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5155AE77198
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 01:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTWZP-00034g-Br; Thu, 02 Jan 2025 20:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tTWZF-00033w-1d; Thu, 02 Jan 2025 20:33:37 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1tTWZC-0003te-Db; Thu, 02 Jan 2025 20:33:36 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxTOJmPndnz25dAA--.51719S3;
 Fri, 03 Jan 2025 09:33:26 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxncVjPndnIPsRAA--.18903S3;
 Fri, 03 Jan 2025 09:33:25 +0800 (CST)
Subject: Re: [PATCH v3 2/2] hw/loongarch/boot: Support Linux raw boot image
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250102-la-direct-kernel-boot-v3-0-40dbc45d633a@flygoat.com>
 <20250102-la-direct-kernel-boot-v3-2-40dbc45d633a@flygoat.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <e5606478-1c62-ad44-e7bc-1052d1902f19@loongson.cn>
Date: Fri, 3 Jan 2025 09:32:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250102-la-direct-kernel-boot-v3-2-40dbc45d633a@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxncVjPndnIPsRAA--.18903S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr1DWr17Zr1UCrWkJw1UurX_yoW5uw13pF
 Z8ArnxJrZ7tF17Xwn3Zry5CF98Zw18Kr4agF9rGrWFvF4Iqr1kuFykur9FvF40qw4rKrs0
 vF1agw4qg3WUX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.336,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/1/3 上午6:47, Jiaxun Yang wrote:
> Support booting such image by parsing header as per Linux's
> specification [1].
> 
> This enabled booting vmlinux.efi/vmlinuz.efi shipped by
> distros without supplying BIOS.
> 
> [1]: https://docs.kernel.org/arch/loongarch/booting.html
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/loongarch/boot.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 93847b0eaf8e50ce1a990b91267780e6785e1c2f..38c19bffa3475d61ffab27a26af9c4c821769dca 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -16,6 +16,26 @@
>   #include "sysemu/reset.h"
>   #include "sysemu/qtest.h"
>   
> +/*
> + * Linux Image Format
> + * https://docs.kernel.org/arch/loongarch/booting.html
> + */
> +#define LINUX_PE_MAGIC  0x818223cd
> +#define MZ_MAGIC        0x5a4d /* "MZ" */
> +
> +struct loongarch_linux_hdr {
> +    uint32_t mz_magic;
> +    uint32_t res0;
> +    uint64_t kernel_entry;
> +    uint64_t kernel_size;
> +    uint64_t load_offset;
> +    uint64_t res1;
> +    uint64_t res2;
> +    uint64_t res3;
> +    uint32_t linux_pe_magic;
> +    uint32_t pe_header_offset;
> +} QEMU_PACKED;
> +
>   struct memmap_entry *memmap_table;
>   unsigned memmap_entries;
>   
> @@ -260,6 +280,50 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>       return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
>   }
>   
> +static int64_t load_loongarch_linux_image(const char *filename,
> +                                          uint64_t *kernel_entry,
> +                                          uint64_t *kernel_low,
> +                                          uint64_t *kernel_high)
> +{
> +    gsize len;
> +    ssize_t size;
> +    uint8_t *buffer;
> +    struct loongarch_linux_hdr *hdr;
> +
> +    /* Load as raw file otherwise */
> +    if (!g_file_get_contents(filename, (char **)&buffer, &len, NULL)) {
> +        return -1;
> +    }
> +    size = len;
> +
> +    /* Unpack the image if it is a EFI zboot image */
> +    if (unpack_efi_zboot_image(&buffer, &size) < 0) {
> +        g_free(buffer);
> +        return -1;
> +    }
> +
> +    hdr = (struct loongarch_linux_hdr *)buffer;
> +
> +    if (extract32(le32_to_cpu(hdr->mz_magic), 0, 16) != MZ_MAGIC ||
> +        le32_to_cpu(hdr->linux_pe_magic) != LINUX_PE_MAGIC) {
> +        g_free(buffer);
> +        return -1;
> +    }
> +
> +    /* Early kernel versions may have those fields in virtual address */
> +    *kernel_entry = extract64(le64_to_cpu(hdr->kernel_entry),
> +                              0, TARGET_PHYS_ADDR_SPACE_BITS);
> +    *kernel_low = extract64(le64_to_cpu(hdr->load_offset),
> +                            0, TARGET_PHYS_ADDR_SPACE_BITS);
> +    *kernel_high = *kernel_low + size;
> +
> +    rom_add_blob_fixed(filename, buffer, size, *kernel_low);
> +
> +    g_free(buffer);
> +
> +    return size;
> +}
> +
>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>   {
>       uint64_t kernel_entry, kernel_low, kernel_high;
> @@ -270,6 +334,11 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>                              &kernel_entry, &kernel_low,
>                              &kernel_high, NULL, 0,
>                              EM_LOONGARCH, 1, 0);
> +    if (kernel_size < 0) {
> +        kernel_size = load_loongarch_linux_image(info->kernel_filename,
> +                                                 &kernel_entry, &kernel_low,
> +                                                 &kernel_high);
> +    }
>   
>       if (kernel_size < 0) {
>           error_report("could not load kernel '%s': %s",
> 
Good job, and thanks for doing this.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>


