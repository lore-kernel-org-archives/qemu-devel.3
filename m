Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48595E7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 00:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPtEs-0004ZW-8r; Mon, 23 Dec 2024 19:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tPtEp-0004WY-IA
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 19:57:31 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tPtEm-0006op-Bn
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 19:57:31 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxG+LmBmpnwuNZAA--.45236S3;
 Tue, 24 Dec 2024 08:57:10 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDx_8fkBmpnmFQHAA--.40096S3;
 Tue, 24 Dec 2024 08:57:08 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/boot: Support Linux raw boot image
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20241223-la-direct-kernel-boot-v1-1-a79995d8b15e@flygoat.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <81a42119-741f-6ab6-e88d-05c9e609670f@loongson.cn>
Date: Tue, 24 Dec 2024 08:56:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241223-la-direct-kernel-boot-v1-1-a79995d8b15e@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_8fkBmpnmFQHAA--.40096S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFy8Gr4xGr1ftr4kZryrAFc_yoWrXw15pF
 yDArnxJrZ2yr12v3Z3Xw15uF98Zw1xGr4agF9rGryFvF4Iqr18Zrykur9rZFWvqFWrKrn0
 qFn8Kw4jg3Wjq3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.856,
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

Sorry, I do not know the background.
Now kernel image with EFI format can boot if uefi bios is provided.

What is this patch to do?  is it to direct boot kernel with EFI format 
without UEFI bios parameter?

Regards
Bibo Mao

On 2024/12/23 上午8:30, Jiaxun Yang wrote:
> Many distros are shipping raw kernel images (i.e. vmlinux.efi).
> 
> Support booting such image by parsing header as per Linux's
> specification [1].
> 
> [1]: https://docs.kernel.org/arch/loongarch/booting.html
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> It is based on my previous booting protocol patch
> ---
>   hw/loongarch/boot.c         | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   include/hw/loongarch/boot.h | 17 +++++++++++++++++
>   2 files changed, 62 insertions(+)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 93847b0eaf8e50ce1a990b91267780e6785e1c2f..5bc889c51fafa9c6d37426b9bee9709c12183927 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -260,6 +260,43 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>       return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
>   }
>   
> +static int64_t get_linux_image_info(struct loongarch_boot_info *info,
> +                                    uint64_t *kernel_entry,
> +                                    uint64_t *kernel_low,
> +                                    uint64_t *kernel_high)
> +{
> +    int fd;
> +    struct loongarch_linux_hdr hdr;
> +    int64_t kernel_size = -1;
> +
> +    fd = open(info->kernel_filename, O_RDONLY | O_BINARY);
> +    if (fd < 0) {
> +        return -1;
> +    }
> +
> +    if (read(fd, &hdr, sizeof(hdr)) != sizeof(hdr)) {
> +        close(fd);
> +        return -1;
> +    }
> +
> +    if ((le32_to_cpu(hdr.mz_magic) & 0xffff) != MZ_MAGIC ||
> +        le32_to_cpu(hdr.linux_pe_magic) != LINUX_PE_MAGIC) {
> +        close(fd);
> +        return -1;
> +    }
> +
> +    *kernel_entry = le64_to_cpu(hdr.kernel_entry);
> +    /* Early kernel versions may have those fields in virtual address */
> +    *kernel_entry &= MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
> +    *kernel_low = le64_to_cpu(hdr.load_offset);
> +    *kernel_low &= MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
> +    kernel_size = le64_to_cpu(hdr.kernel_size);
> +    *kernel_high = *kernel_low + kernel_size;
> +
> +    close(fd);
> +    return kernel_size;
> +}
> +
>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>   {
>       uint64_t kernel_entry, kernel_low, kernel_high;
> @@ -270,6 +307,14 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>                              &kernel_entry, &kernel_low,
>                              &kernel_high, NULL, 0,
>                              EM_LOONGARCH, 1, 0);
> +    if (kernel_size < 0) {
> +        kernel_size = get_linux_image_info(info, &kernel_entry,
> +                                           &kernel_low, &kernel_high);
> +        if (kernel_size >= 0) {
> +            kernel_size = load_image_targphys(info->kernel_filename,
> +                                              kernel_low, kernel_size);
> +        }
> +    }
>   
>       if (kernel_size < 0) {
>           error_report("could not load kernel '%s': %s",
> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> index 96ec15016a314499acf65c6c47e0c4932aa99d01..5e8bd4dd73bbb27abccfa1fa577df52aed15b6a2 100644
> --- a/include/hw/loongarch/boot.h
> +++ b/include/hw/loongarch/boot.h
> @@ -8,6 +8,23 @@
>   #ifndef HW_LOONGARCH_BOOT_H
>   #define HW_LOONGARCH_BOOT_H
>   
> +/* Linux Image Format */
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
>   /* UEFI 2.10 */
>   #define EFI_SYSTEM_TABLE_SIGNATURE       0x5453595320494249
>   #define EFI_2_100_SYSTEM_TABLE_REVISION  ((2<<16) | (100))
> 
> ---
> base-commit: c69612063e1844b76ac01e3a781b979548c3585c
> change-id: 20241222-la-direct-kernel-boot-c598264710e7
> 
> Best regards,
> 


