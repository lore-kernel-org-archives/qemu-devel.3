Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A10CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 07:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uunHo-0007iU-Dy; Sat, 06 Sep 2025 03:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uunHh-0007fG-WC
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:24:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uunHa-0006kr-Kn
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:24:29 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axz7+i4bto1FkHAA--.14289S3;
 Sat, 06 Sep 2025 15:24:18 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxH8Kh4btoMKyBAA--.29222S3;
 Sat, 06 Sep 2025 15:24:17 +0800 (CST)
Subject: Re: [PATCH v6 11/11] hw/loongarch: Implement AVEC plug/unplug
 interfaces
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250904121840.2023683-1-gaosong@loongson.cn>
 <20250904121840.2023683-12-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <d7bcc9d4-b76a-32af-3095-88a5be30a694@loongson.cn>
Date: Sat, 6 Sep 2025 15:22:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250904121840.2023683-12-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8Kh4btoMKyBAA--.29222S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAryDCr1UKr1xZF4rXr1UArc_yoWruF1kp3
 s2yFZYqF1UGFnrZ397X3s8X3Z8Ar4I9342qF1akr13ZF4DGr18Xa48C34DZFW8C3y8C3Wv
 9w4rGan8uFnxJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2F4iUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.794,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 2025/9/4 下午8:18, Song Gao wrote:
> when cpu added, connect avec irq to cpu INT_AVEC irq pin.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_avec.c | 71 ++++++++++++++++++++++++++++++++++++++++
>   hw/loongarch/virt.c      | 11 +++++++
>   2 files changed, 82 insertions(+)
> 
> diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
> index 03a20a7b60..f4b0ff29fa 100644
> --- a/hw/intc/loongarch_avec.c
> +++ b/hw/intc/loongarch_avec.c
> @@ -140,14 +140,81 @@ static void loongarch_avec_init(Object *obj)
>       return;
>   }
>   
> +static AVECCore *loongarch_avec_get_cpu(LoongArchAVECState *s,
> +                                        DeviceState *dev)
> +{
> +    CPUClass *k = CPU_GET_CLASS(dev);
> +    uint64_t arch_id = k->get_arch_id(CPU(dev));
> +    int i;
> +
> +    for (i = 0; i < s->num_cpu; i++) {
> +        if (s->cpu[i].arch_id == arch_id) {
> +            return &s->cpu[i];
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static void loongarch_avec_cpu_plug(HotplugHandler *hotplug_dev,
> +                                   DeviceState *dev, Error **errp)
> +{
> +    LoongArchAVECState *s = LOONGARCH_AVEC(hotplug_dev);
> +    Object *obj = OBJECT(dev);
> +    AVECCore *core;
> +    int index;
> +
> +    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
> +        warn_report("LoongArch AVEC: Invalid %s device type",
> +                                       object_get_typename(obj));
> +        return;
> +    }
> +    core = loongarch_avec_get_cpu(s, dev);
> +    if (!core) {
> +        return;
> +    }
> +
> +    core->cpu = CPU(dev);
> +    index = core - s->cpu;
> +
> +    /* connect avec msg irq to cpu irq */
> +    qdev_connect_gpio_out(DEVICE(s), index, qdev_get_gpio_in(dev, INT_AVEC));
> +    return;
> +}
> +
> +static void loongarch_avec_cpu_unplug(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp)
> +{
> +    LoongArchAVECState *s = LOONGARCH_AVEC(hotplug_dev);
> +    Object *obj = OBJECT(dev);
> +    AVECCore *core;
> +
> +    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
> +        warn_report("LoongArch AVEC: Invalid %s device type",
> +                                       object_get_typename(obj));
> +        return;
> +    }
> +
> +    core = loongarch_avec_get_cpu(s, dev);
> +
> +    if (!core) {
> +        return;
> +    }
> +
> +    core->cpu = NULL;
> +}
> +
>   static void loongarch_avec_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> +    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>       LoongArchAVECClass *lac = LOONGARCH_AVEC_CLASS(klass);
>   
>       dc->unrealize = loongarch_avec_unrealize;
>       device_class_set_parent_realize(dc, loongarch_avec_realize,
>                                       &lac->parent_realize);
> +    hc->plug = loongarch_avec_cpu_plug;
> +    hc->unplug = loongarch_avec_cpu_unplug;
>   }
>   
>   static const TypeInfo loongarch_avec_info = {
> @@ -156,6 +223,10 @@ static const TypeInfo loongarch_avec_info = {
>       .instance_size = sizeof(LoongArchAVECState),
>       .instance_init = loongarch_avec_init,
>       .class_init    = loongarch_avec_class_init,
> +    .interfaces    = (const InterfaceInfo[]) {
> +        { TYPE_HOTPLUG_HANDLER },
> +        { }
> +    },
>   };
>   
>   static void loongarch_avec_register_types(void)
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index a3f8f4c854..ad78dd3f19 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -377,6 +377,10 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
>                                &error_abort);
>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs),
>                                &error_abort);
> +        if (lvms->avec) {
> +            hotplug_handler_plug(HOTPLUG_HANDLER(lvms->avec), DEVICE(cs),
> +                                 &error_abort);
> +        }
>       }
>   }
>   
> @@ -1089,6 +1093,9 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>       /* Notify ipi and extioi irqchip to remove interrupt routing to CPU */
>       hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev, &error_abort);
>       hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi), dev, &error_abort);
> +    if (lvms->avec) {
> +        hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->avec), dev, &error_abort);
> +    }
>   
>       /* Notify acpi ged CPU removed */
>       hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &error_abort);
> @@ -1112,6 +1119,10 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &error_abort);
>       }
>   
> +    if (lvms->avec) {
> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->avec), dev, &error_abort);
> +    }
> +
>       if (lvms->acpi_ged) {
>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev,
>                                &error_abort);
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


