Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91E6C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGd1-00032b-7i; Wed, 17 Jul 2024 22:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sUGcb-0001O4-5R
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sUGcX-0003fE-N8
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:52 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxzOrfeZhmfGYAAA--.2258S3;
 Thu, 18 Jul 2024 10:11:43 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxLMfceZhm3jFNAA--.43210S3; 
 Thu, 18 Jul 2024 10:11:42 +0800 (CST)
Subject: Re: [PATCH v3 04/17] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_realize()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20240717214708.78403-1-philmd@linaro.org>
 <20240717214708.78403-5-philmd@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <94592136-8e6b-0b99-07f3-e98ea0c4d658@loongson.cn>
Date: Thu, 18 Jul 2024 10:11:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240717214708.78403-5-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLMfceZhm3jFNAA--.43210S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxArWkGF4DJw4rKrWDGryDArc_yoW5XF47pF
 4akan0gF1rXFyDAws3GF9rKFy5Zwn5Jw17WFsFka4rKr9xWw1vvw18K3Wakw17uFyFva1Y
 vF90kFW3Ka1UCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.124,
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



On 2024/7/18 上午5:46, Philippe Mathieu-Daudé wrote:
> From: Bibo Mao <maobibo@loongson.cn>
> 
> In preparation to extract common IPI code in few commits,
> extract loongson_ipi_common_realize().
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/intc/loongson_ipi.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
> index 3b3481c43e..40ac769aad 100644
> --- a/hw/intc/loongson_ipi.c
> +++ b/hw/intc/loongson_ipi.c
> @@ -275,7 +275,7 @@ static const MemoryRegionOps loongson_ipi64_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
> -static void loongson_ipi_realize(DeviceState *dev, Error **errp)
> +static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
>   {
>       LoongsonIPIState *s = LOONGSON_IPI(dev);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> @@ -301,20 +301,31 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
>       sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
>   
>       s->cpu = g_new0(IPICore, s->num_cpu);
> -    if (s->cpu == NULL) {
> -        error_setg(errp, "Memory allocation for IPICore faile");
Philippe,

Thanks for the whole series, it looks to me. It is split into small 
patches and adds new option CONFIG_LOONGSON_IPI_COMMON, it is easier to 
review and compile for multiple targets.

One small nit, do we need keep checking sentence for if (s->cpu == NULL)?

Overall, for the whole series it is ok for me and works well on 
LoongArch machine.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>

> +    for (i = 0; i < s->num_cpu; i++) {
> +        s->cpu[i].ipi = s;
> +
> +        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
> +    }
> +}
> +
> +static void loongson_ipi_realize(DeviceState *dev, Error **errp)
> +{
> +    LoongsonIPIState *s = LOONGSON_IPI(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    Error *local_err = NULL;
> +
> +    loongson_ipi_common_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
>           return;
>       }
>   
> -    for (i = 0; i < s->num_cpu; i++) {
> -        s->cpu[i].ipi = s;
> +    for (unsigned i = 0; i < s->num_cpu; i++) {
>           s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
>           g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
>           memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
>                                 &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
>           sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
> -
> -        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
>       }
>   }
>   
> 


