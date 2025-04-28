Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38678C369D1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 03:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9F3e-0005A8-4d; Sun, 27 Apr 2025 23:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u9F3c-00059r-1d
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:21:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u9F3Z-00066A-RE
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:21:23 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxvnMv9A5oZ_THAA--.36467S3;
 Mon, 28 Apr 2025 11:21:19 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxzxst9A5oo12aAA--.7675S3;
 Mon, 28 Apr 2025 11:21:19 +0800 (CST)
Subject: Re: [PATCH v2 11/16] hw/intc/loongarch_pch: Use generic write
 callback for iomem32_high region
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-12-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <7e512749-10f7-1593-24a4-08bb1b35d251@loongson.cn>
Date: Mon, 28 Apr 2025 11:23:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250324093730.3683378-12-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxzxst9A5oo12aAA--.7675S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFy8ur43AFW5uFW7Xw4UKFX_yoW5Jr4rpr
 W3Zr9xKa1DtFnrXF1kAa4UZr1xJFn7W34S93ZIkryv9rs8Zrn09F1DJrWIqFyjk34xGrya
 qFs5uF90va1DGFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8
 CztUUUUU=
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
> Add iomem32_high region register write operation emulation in generic
> write function loongarch_pch_pic_write(), and use this function for
> iomem32_high region.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c | 28 +++++-----------------------
>   1 file changed, 5 insertions(+), 23 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks,
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index d5a8c8377d..83148a234b 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -158,6 +158,9 @@ static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
>       case PCH_PIC_AUTO_CTRL1 ... PCH_PIC_AUTO_CTRL1 + 7:
>           /* Discard auto_ctrl access */
>           break;
> +    case PCH_PIC_INT_POL ... PCH_PIC_INT_POL + 7:
> +        s->int_polarity = (s->int_polarity & ~mask) | data;
> +        break;
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "pch_pic_write: Bad address 0x%"PRIx64"\n", addr);
> @@ -226,14 +229,6 @@ static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
>       return val;
>   }
>   
> -static uint64_t get_writew_val(uint64_t value, uint32_t target, bool hi)
> -{
> -    uint64_t mask = 0xffffffff00000000;
> -    uint64_t data = target;
> -
> -    return hi ? (value & ~mask) | (data << 32) : (value & mask) | data;
> -}
> -
>   static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
>                                            uint64_t value, unsigned size)
>   {
> @@ -255,22 +250,9 @@ static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
>   static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
>                                        uint64_t value, unsigned size)
>   {
> -    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
> -    uint32_t data = (uint32_t)value;
> -
>       addr += PCH_PIC_INT_STATUS;
> -    trace_loongarch_pch_pic_high_writew(size, addr, data);
> -
> -    switch (addr) {
> -    case PCH_PIC_INT_POL:
> -        s->int_polarity = get_writew_val(s->int_polarity, data, 0);
> -        break;
> -    case PCH_PIC_INT_POL + 4:
> -        s->int_polarity = get_writew_val(s->int_polarity, data, 1);
> -        break;
> -    default:
> -        break;
> -    }
> +    trace_loongarch_pch_pic_high_writew(size, addr, value);
> +    loongarch_pch_pic_write(opaque, addr, value, size);
>   }
>   
>   static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,


