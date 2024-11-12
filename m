Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974A2D41D4E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 03:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAhje-0002w5-E1; Mon, 11 Nov 2024 22:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tAhjb-0002uj-Lm; Mon, 11 Nov 2024 22:38:31 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1tAhjZ-0002gY-F0; Mon, 11 Nov 2024 22:38:31 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxUa+tzTJnqL07AA--.52621S3;
 Tue, 12 Nov 2024 11:38:21 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAx7uCqzTJnsz1SAA--.56511S3;
 Tue, 12 Nov 2024 11:38:21 +0800 (CST)
Subject: Re: [PATCH 3/3] hw/intc/loongarch_extioi: Use set_bit32() and
 clear_bit32() for s->isr
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241108135514.4006953-1-peter.maydell@linaro.org>
 <20241108135514.4006953-4-peter.maydell@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <7ae0d2a1-6b62-1913-75e7-a1316f3cd91a@loongson.cn>
Date: Tue, 12 Nov 2024 11:37:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241108135514.4006953-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx7uCqzTJnsz1SAA--.56511S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF4xAw4xKw43ZF13CFy5WrX_yoW5Zr13pF
 y5Cr1Ykr4xX34UJ3yvg3yY9ryUWFnYva4YyF42vry0gFy3GFyFgFykKryUXF4UC34kXay2
 9FW5Xw4qvFWYyagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70Pf
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.909,
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



On 2024/11/8 下午9:55, Peter Maydell wrote:
> In extioi_setirq() we try to operate on a bit array stored as an
> array of uint32_t using the set_bit() and clear_bit() functions
> by casting the pointer to 'unsigned long *'.
> This has two problems:
>   * the alignment of 'uint32_t' is less than that of 'unsigned long'
>     so we pass an insufficiently aligned pointer, which is
>     undefined behaviour
>   * on big-endian hosts the 64-bit 'unsigned long' will have
>     its two halves the wrong way around, and we will produce
>     incorrect results
> 
> The undefined behaviour is shown by the clang undefined-behaviour
> sanitizer when running the loongarch64-virt functional test:
> 
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitops.h:41:5: runtime error: store to misaligned address 0x555559745d9c for type 'unsigned long', which requires 8 byte alignment
> 0x555559745d9c: note: pointer points here
>    ff ff ff ff 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>                ^
>      #0 0x555556fb81c4 in set_bit /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitops.h:41:9
>      #1 0x555556fb81c4 in extioi_setirq /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/intc/loongarch_extioi.c:65:9
>      #2 0x555556fb6e90 in pch_pic_irq_handler /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/intc/loongarch_pch_pic.c:75:5
>      #3 0x555556710265 in serial_ioport_write /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/char/serial.c
> 
> Fix these problems by using set_bit32() and clear_bit32(),
> which work with bit arrays stored as an array of uint32_t.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: cbff2db1e92f8759 ("hw/intc: Add LoongArch extioi interrupt controller(EIOINTC)")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/loongarch_extioi.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
> index 02dc4e6db3b..97d1af5ccc2 100644
> --- a/hw/intc/loongarch_extioi.c
> +++ b/hw/intc/loongarch_extioi.c
> @@ -57,14 +57,9 @@ static void extioi_setirq(void *opaque, int irq, int level)
>       LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
>       trace_loongarch_extioi_setirq(irq, level);
>       if (level) {
> -        /*
> -         * s->isr should be used in vmstate structure,
> -         * but it not support 'unsigned long',
> -         * so we have to switch it.
> -         */
> -        set_bit(irq, (unsigned long *)s->isr);
> +        set_bit32(irq, s->isr);
>       } else {
> -        clear_bit(irq, (unsigned long *)s->isr);
> +        clear_bit32(irq, s->isr);
>       }
>       extioi_update_irq(s, irq, level);
>   }
> @@ -154,7 +149,7 @@ static inline void extioi_update_sw_coremap(LoongArchExtIOI *s, int irq,
>               continue;
>           }
>   
> -        if (notify && test_bit(irq + i, (unsigned long *)s->isr)) {
> +        if (notify && test_bit32(irq + i, s->isr)) {
>               /*
>                * lower irq at old cpu and raise irq at new cpu
>                */
> 
Hi Peter,

Thanks for finding and fixing this issue, it looks good to me.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

Regards
Bibo Mao


