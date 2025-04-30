Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEC3C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 03:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9xxf-0003YT-RV; Tue, 29 Apr 2025 23:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u9xxd-0003YJ-60
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 23:18:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u9xxa-0008C6-9b
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 23:18:12 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxWOFWlhFoZ7jKAA--.7453S3;
 Wed, 30 Apr 2025 11:17:42 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxLcVSlhFoyWmfAA--.4120S3;
 Wed, 30 Apr 2025 11:17:40 +0800 (CST)
Subject: Re: [PATCH v3] hw/loongarch/virt: Get physical entry address with elf
 file
To: Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250430030447.1404720-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d4c2789f-1bb6-9d7e-a7be-d85705e8a331@loongson.cn>
Date: Wed, 30 Apr 2025 11:20:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250430030447.1404720-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxLcVSlhFoyWmfAA--.4120S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw13Aw4xZFyUKrW3AF1rKrX_yoW8tr18pF
 9xAr45Kr48JF1fCa9rW3sruFyDX3WDuF1agasrCr1F9rsIqr1Ivr1a93sYvFWjqw4rK34Y
 vFsayF4j93WDJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.12, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/4/30 ÉÏÎç11:04, Bibo Mao Ð´µÀ:
> With load_elf() api, image load low address and high address is converted
> to physical address if parameter translate_fn is provided. However
> executing entry address is still virtual address. Here convert entry
> address into physical address, since MMU is disabled when system power on,
> the first PC instruction should be physical address.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>    v2 ... v3:
>    1. Modify link script about tcg system test cases, loading address is
>       changed from virtual address 0x9000000000200000 to physical address
>       0x200000. Otherwise test case memory-with-libmem.so fails to run
>       with check-tcg command.
>
>    v1 ... v2:
>    1. Only modify LoongArch specified rather than load_elf() API, since
>       there is be potential influence with other architectures.
> ---
>   hw/loongarch/boot.c                    | 1 +
>   tests/tcg/loongarch64/system/kernel.ld | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 354cf458c8..0324d6adcb 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -245,6 +245,7 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>                              &kernel_entry, &kernel_low,
>                              &kernel_high, NULL, ELFDATA2LSB,
>                              EM_LOONGARCH, 1, 0);
> +    kernel_entry = cpu_loongarch_virt_to_phys(NULL, kernel_entry);
>       if (kernel_size < 0) {
>           kernel_size = load_loongarch_linux_image(info->kernel_filename,
>                                                    &kernel_entry, &kernel_low,
> diff --git a/tests/tcg/loongarch64/system/kernel.ld b/tests/tcg/loongarch64/system/kernel.ld
> index f1a7c0168c..56d8588f1a 100644
> --- a/tests/tcg/loongarch64/system/kernel.ld
> +++ b/tests/tcg/loongarch64/system/kernel.ld
> @@ -3,7 +3,7 @@ ENTRY(_start)
>   SECTIONS
>   {
>       /* Linux kernel legacy start address.  */
> -    . = 0x9000000000200000;
> +    . = 0x200000;

Tested-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>       _text = .;
>       .text : {
>           *(.text)
>
> base-commit: 73d29ea2417b58ca55fba1aa468ba38e3607b583


