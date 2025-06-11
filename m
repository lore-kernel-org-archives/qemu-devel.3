Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31493C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 06:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPF6V-0003hy-Ox; Wed, 11 Jun 2025 02:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uPF6P-0003hF-R5
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:38:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uPF6M-0001sk-IU
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:38:24 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxPuNXJEloNnkTAQ--.12685S3;
 Wed, 11 Jun 2025 14:38:15 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxDcVUJEloLJEVAQ--.62009S3;
 Wed, 11 Jun 2025 14:38:14 +0800 (CST)
Subject: Re: [PATCH 07/10] hw/loongarch: connect pch_msi controller to avec
 controller
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250609104833.839811-1-gaosong@loongson.cn>
 <20250609104833.839811-8-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <b0441034-9c99-0480-d0e1-2e30aac9a143@loongson.cn>
Date: Wed, 11 Jun 2025 14:36:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250609104833.839811-8-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxDcVUJEloLJEVAQ--.62009S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF18Zr4rur18JFWxZFW5Jwc_yoW8ZrWUpa
 yDua9YkrW0qa4xWrZagw4UGr98Aws3KF1I9FnrKr18Kw15Zryj9Fy8Aws8GryUtr95ZFyq
 v34UWa9Fg3WDC3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5r7UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.653,
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



On 2025/6/9 下午6:48, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 718b5b4f92..6b670e7936 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -503,11 +503,19 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms, MachineState *ms)
>       qdev_prop_set_uint32(pch_msi, "msi_irq_num", num);
>       d = SYS_BUS_DEVICE(pch_msi);
>       sysbus_realize_and_unref(d, &error_fatal);
> -    sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
> -    for (i = 0; i < num; i++) {
> -        /* Connect pch_msi irqs to extioi */
> -        qdev_connect_gpio_out(DEVICE(d), i,
> -                              qdev_get_gpio_in(extioi, i + start));
> +    if (virt_is_avecintc_enabled(lvms)) {
> +        for (i = 0; i < num; i++) {
> +            /* Connect pch_msi irqs to avec */
> +            qdev_connect_gpio_out(DEVICE(d), i,
> +                                 qdev_get_gpio_in(avec, i + start));
one parent irqline for avec is enough. Variable num is the number 
allocated for pch_msi when connecting to extioi. So variable num is 
meaningless with avec.

Also there is no msi memory map region for avec such as 
sysbus_mmio_map() in the following.

> +        }
> +    } else {In the first, I think irqchip avec and pch_msi can coexist together.
MSI memory area for avec is
    [VIRT_PCH_MSI_ADDR_LOW - 0x100000, VIRT_PCH_MSI_ADDR_LOW)
for pch_msi is
    [VIRT_PCH_MSI_ADDR_LOW, VIRT_PCH_MSI_ADDR_LOW + 0x8)

For parent line, AVEC is connected to CPU MSGINT BIT14 and pch_msi is
connected to extioi.

So they can coexists together, it only depends on how guest kernel use 
MSI controller.

Regards
Bibo Mao
> +        sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
> +        for (i = 0; i < num; i++) {
> +            /* Connect pch_msi irqs to extioi */
> +            qdev_connect_gpio_out(DEVICE(d), i,
> +                                  qdev_get_gpio_in(extioi, i + start));
> +        }
>       }
>   
>       virt_devices_init(pch_pic, lvms);
> 


