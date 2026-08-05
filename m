Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCB2C55838
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 03:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrRs1-0003Dl-8v; Tue, 04 Aug 2026 23:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wrRry-0003DI-PQ; Tue, 04 Aug 2026 23:00:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1wrRrw-0005HZ-6g; Tue, 04 Aug 2026 23:00:38 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxHJtMp3JqNYMKAA--.10883S3;
 Wed, 05 Aug 2026 11:00:28 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxu8RJp3JqLjgkAA--.13824S2;
 Wed, 05 Aug 2026 11:00:25 +0800 (CST)
Subject: Re: [PATCH] hw/intc/loongarch_pch_pic: Validate htmsi_vector before
 indexing parent_irq
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-stable@nongnu.org
References: <20260804073445.55612-1-guobin@linux.alibaba.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <75b3d68e-58f4-3779-2366-99821dd22d06@loongson.cn>
Date: Wed, 5 Aug 2026 11:00:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260804073445.55612-1-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxu8RJp3JqLjgkAA--.13824S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur4rur17CrWUKryfur48uFX_yoW8tr1DpF
 ZrC3ZIgr4rtr13Zr93G3yUXF18urn7WF1IvFn3K3s7Cr9xAr18WFn7JrW7WF1xG3sxJrWj
 v3ySgr4jqa4293XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcVc_
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.999,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/8/4 下午3:34, Bin Guo wrote:
> pch_pic_update_irq() used the guest-writable htmsi_vector[irq] value as an
> index into parent_irq[] without checking bounds.  A value >= irq_num (64 in
> the array, but only 32 are used by the virt machine) causes an out-of-bounds
> read and a guest-triggerable QEMU crash.
> 
> Validate the vector before calling qemu_set_irq() in both the raise and lower
> paths and log a guest error if it is out of range.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4114
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   hw/intc/loongarch_pch_pic.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index 82e16be391..e87c7497c1 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -19,13 +19,21 @@ static void pch_pic_update_irq(LoongArchPICCommonState *s, uint64_t mask,
>   {
>       uint64_t val;
>       int irq;
> +    uint8_t vector;
>   
>       if (level) {
>           val = mask & s->intirr & ~s->int_mask;
>           if (val) {
>               irq = ctz64(val);
> +            vector = s->htmsi_vector[irq];
> +            if (vector >= s->irq_num) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: htmsi_vector[%d]=%u out of range\n",
> +                              __func__, irq, vector);
> +                return;
> +            }
>               s->intisr |= MAKE_64BIT_MASK(irq, 1);
> -            qemu_set_irq(s->parent_irq[s->htmsi_vector[irq]], 1);
> +            qemu_set_irq(s->parent_irq[vector], 1);
>           }
>       } else {
>           /*
> @@ -35,8 +43,15 @@ static void pch_pic_update_irq(LoongArchPICCommonState *s, uint64_t mask,
>           val = mask & s->intisr & ~s->intirr;
>           if (val) {
>               irq = ctz64(val);
> +            vector = s->htmsi_vector[irq];
> +            if (vector >= s->irq_num) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: htmsi_vector[%d]=%u out of range\n",
> +                              __func__, irq, vector);
> +                return;
> +            }
>               s->intisr &= ~MAKE_64BIT_MASK(irq, 1);
> -            qemu_set_irq(s->parent_irq[s->htmsi_vector[irq]], 0);
> +            qemu_set_irq(s->parent_irq[vector], 0);
>           }
>       }
>   }
> 
Hi Bin,

Thanks for solving this problem.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

Regards
Bibo Mao


