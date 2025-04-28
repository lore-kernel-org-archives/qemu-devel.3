Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE21C369D1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 03:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9EyU-00021e-1z; Sun, 27 Apr 2025 23:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u9EyR-000219-T0
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:16:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u9EyP-0005fB-Qm
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:16:03 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxrnLu8g5oUfPHAA--.3800S3;
 Mon, 28 Apr 2025 11:15:58 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxzMTt8g5oiluaAA--.59816S3;
 Mon, 28 Apr 2025 11:15:58 +0800 (CST)
Subject: Re: [PATCH v2 09/16] hw/intc/loongarch_pch: Use generic read callback
 for iomem8 region
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-10-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3023ee39-d7cd-271e-634c-031a39b017cc@loongson.cn>
Date: Mon, 28 Apr 2025 11:18:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250324093730.3683378-10-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxzMTt8g5oiluaAA--.59816S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF1xWF45tr48Xw48XrWkAFc_yoW5Jw4fpr
 W3Ary3tF4DtFy2grnrA3yDZF1xG3Z7W34Sga90kFy09rZ8Z3s5XFyDJ34kGFyYk34xAry8
 XFs8Grn093W7u3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Li
 SJUUUUU==
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
> Add iomem8 region register read operation emulation in generic read
> function loongarch_pch_pic_read(), and use this function for iomem8
> region.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c | 32 +++++++++++---------------------
>   1 file changed, 11 insertions(+), 21 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

thanks,
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index 0057b0f357..01e6fc6257 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -76,7 +76,7 @@ static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>       uint64_t val = 0;
> -    uint32_t offset = addr & 7;
> +    uint32_t offset = addr & 7, tmp;
>   
>       switch (addr) {
>       case PCH_PIC_INT_ID ... PCH_PIC_INT_ID + 7:
> @@ -101,6 +101,14 @@ static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
>       case PCH_PIC_INT_POL ... PCH_PIC_INT_POL + 7:
>           val = s->int_polarity;
>           break;
> +    case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
> +        tmp = addr - offset - PCH_PIC_HTMSI_VEC;
> +        val = *(uint64_t *)(s->htmsi_vector + tmp);
> +        break;
> +    case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
> +        tmp = addr - offset - PCH_PIC_ROUTE_ENTRY;
> +        val = *(uint64_t *)(s->route_entry + tmp);
> +        break;
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "pch_pic_read: Bad address 0x%"PRIx64"\n", addr);
> @@ -262,28 +270,10 @@ static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
>   static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
>                                           unsigned size)
>   {
> -    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
> -    uint64_t val = 0;
> -    int64_t offset_tmp;
> +    uint64_t val;
>   
>       addr += PCH_PIC_ROUTE_ENTRY;
> -    switch (addr) {
> -    case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
> -        offset_tmp = addr - PCH_PIC_HTMSI_VEC;
> -        if (offset_tmp >= 0 && offset_tmp < 64) {
> -            val = s->htmsi_vector[offset_tmp];
> -        }
> -        break;
> -    case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
> -        offset_tmp = addr - PCH_PIC_ROUTE_ENTRY;
> -        if (offset_tmp >= 0 && offset_tmp < 64) {
> -            val = s->route_entry[offset_tmp];
> -        }
> -        break;
> -    default:
> -        break;
> -    }
> -
> +    val = loongarch_pch_pic_read(opaque, addr, size);
>       trace_loongarch_pch_pic_readb(size, addr, val);
>       return val;
>   }


