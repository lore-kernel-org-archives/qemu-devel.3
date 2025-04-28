Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D71C369D1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 03:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9F17-0003Ry-Gp; Sun, 27 Apr 2025 23:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u9F13-0003Qq-Qo
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:18:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u9F11-0005lM-Kn
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:18:45 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxaWqP8w5ozvPHAA--.5595S3;
 Mon, 28 Apr 2025 11:18:39 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBx3xuM8w5osVyaAA--.7745S3;
 Mon, 28 Apr 2025 11:18:38 +0800 (CST)
Subject: Re: [PATCH v2 10/16] hw/intc/loongarch_pch: Use generic write
 callback for iomem32_low region
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-11-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <0c670658-a91d-e44c-f0c6-258f3a3df6c0@loongson.cn>
Date: Mon, 28 Apr 2025 11:21:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250324093730.3683378-11-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBx3xuM8w5osVyaAA--.7745S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF45Cr4kCFyrGFW3Jw1DJwc_yoW7XF1rpF
 W5ZF9IkF4DtF4UWFs7uws8ZF1xAFn7XrySg3ZxK3409rWDJ3s5uF1DJr97Kr1Yk3sxJr40
 qF45urZ09anFqFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8QJ
 57UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.279, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

ÔÚ 2025/3/24 ÏÂÎç5:37, Bibo Mao Ð´µÀ:
> For memory region iomem32_low, generic write callback is used.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c | 140 +++++++++++++++++++-----------------
>   1 file changed, 73 insertions(+), 67 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index 01e6fc6257..d5a8c8377d 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -118,6 +118,53 @@ static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
>       return (val >> (offset * 8)) & field_mask;
>   }
>   
> +static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
> +                          uint64_t field_mask)
> +{
> +    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
> +    uint32_t offset;
> +    uint64_t old, mask, data;
> +
> +    offset = addr & 7;
> +    addr -= offset;
> +    mask = field_mask << (offset * 8);
> +    data = (value & field_mask) << (offset * 8);
> +    switch (addr) {
> +    case PCH_PIC_INT_MASK ... PCH_PIC_INT_MASK + 7:
> +        old = s->int_mask;
> +        s->int_mask = (old & ~mask) | data;
> +        if (old & ~data) {
> +            pch_pic_update_irq(s, old & ~data, 1);
> +        }
> +
> +        if (~old & data) {
> +            pch_pic_update_irq(s, ~old & data, 0);
> +        }
> +        break;
> +    case PCH_PIC_INT_EDGE ... PCH_PIC_INT_EDGE + 7:
> +        s->intedge = (s->intedge & ~mask) | data;
> +        break;
> +    case PCH_PIC_INT_CLEAR ... PCH_PIC_INT_CLEAR + 7:
> +        if (s->intedge & data) {
> +            s->intirr &= ~data;
> +            pch_pic_update_irq(s, data, 0);
> +            s->intisr &= ~data;
> +        }
> +        break;
> +    case PCH_PIC_HTMSI_EN ... PCH_PIC_HTMSI_EN + 7:
> +        s->htmsi_en = (s->htmsi_en & ~mask) | data;
> +        break;
> +    case PCH_PIC_AUTO_CTRL0 ... PCH_PIC_AUTO_CTRL0 + 7:
> +    case PCH_PIC_AUTO_CTRL1 ... PCH_PIC_AUTO_CTRL1 + 7:
> +        /* Discard auto_ctrl access */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "pch_pic_write: Bad address 0x%"PRIx64"\n", addr);
> +        break;
> +    }
> +}
> +
>   static uint64_t loongarch_pch_pic_read(void *opaque, hwaddr addr,
>                                          unsigned size)
>   {
> @@ -145,6 +192,30 @@ static uint64_t loongarch_pch_pic_read(void *opaque, hwaddr addr,
>       return val;
>   }
>   
> +static void loongarch_pch_pic_write(void *opaque, hwaddr addr,
> +                                    uint64_t value, unsigned size)
> +{
> +    switch (size) {
> +    case 1:
> +        pch_pic_write(opaque, addr, value, 0xFF);
> +        break;
> +    case 2:
> +        pch_pic_write(opaque, addr, value, 0xFFFF);
> +        break;
> +        break;
> +    case 4:
> +        pch_pic_write(opaque, addr, value, UINT_MAX);
> +        break;
> +    case 8:
> +        pch_pic_write(opaque, addr, value, UINT64_MAX);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "loongarch_pch_pic_write: Bad size %d\n", size);
> +        break;
> +    }
> +}
> +
>   static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
>                                               unsigned size)
>   {
> @@ -166,73 +237,8 @@ static uint64_t get_writew_val(uint64_t value, uint32_t target, bool hi)
>   static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
>                                            uint64_t value, unsigned size)
>   {
> -    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
> -    uint32_t old_valid, data = (uint32_t)value;
> -    uint64_t old, int_mask;
> -
> -    trace_loongarch_pch_pic_low_writew(size, addr, data);
> -
> -    switch (addr) {
> -    case PCH_PIC_INT_MASK:
> -        old = s->int_mask;
> -        s->int_mask = get_writew_val(old, data, 0);
> -        old_valid = (uint32_t)old;
> -        if (old_valid & ~data) {
> -            pch_pic_update_irq(s, (old_valid & ~data), 1);
> -        }
> -        if (~old_valid & data) {
> -            pch_pic_update_irq(s, (~old_valid & data), 0);
> -        }
> -        break;
> -    case PCH_PIC_INT_MASK + 4:
> -        old = s->int_mask;
> -        s->int_mask = get_writew_val(old, data, 1);
> -        old_valid = (uint32_t)(old >> 32);
> -        int_mask = old_valid & ~data;
> -        if (int_mask) {
> -            pch_pic_update_irq(s, int_mask << 32, 1);
> -        }
> -        int_mask = ~old_valid & data;
> -        if (int_mask) {
> -            pch_pic_update_irq(s, int_mask << 32, 0);
> -        }
> -        break;
> -    case PCH_PIC_INT_EDGE:
> -        s->intedge = get_writew_val(s->intedge, data, 0);
> -        break;
> -    case PCH_PIC_INT_EDGE + 4:
> -        s->intedge = get_writew_val(s->intedge, data, 1);
> -        break;
> -    case PCH_PIC_INT_CLEAR:
> -        if (s->intedge & data) {
> -            s->intirr &= (~data);
> -            pch_pic_update_irq(s, data, 0);
> -            s->intisr &= (~data);
> -        }
> -        break;
> -    case PCH_PIC_INT_CLEAR + 4:
> -        value <<= 32;
> -        if (s->intedge & value) {
> -            s->intirr &= (~value);
> -            pch_pic_update_irq(s, value, 0);
> -            s->intisr &= (~value);
> -        }
> -        break;
> -    case PCH_PIC_HTMSI_EN:
> -        s->htmsi_en = get_writew_val(s->htmsi_en, data, 0);
> -        break;
> -    case PCH_PIC_HTMSI_EN + 4:
> -        s->htmsi_en = get_writew_val(s->htmsi_en, data, 1);
> -        break;
> -    case PCH_PIC_AUTO_CTRL0:
> -    case PCH_PIC_AUTO_CTRL0 + 4:
> -    case PCH_PIC_AUTO_CTRL1:
> -    case PCH_PIC_AUTO_CTRL1 + 4:
> -        /* discard auto_ctrl access */
> -        break;
> -    default:
> -        break;
> -    }
> +    trace_loongarch_pch_pic_low_writew(size, addr, value);
> +    loongarch_pch_pic_write(opaque, addr, value, size);
>   }
>   
>   static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,


