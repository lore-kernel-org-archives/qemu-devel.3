Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7CEC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 06:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPF9x-0005QO-IE; Wed, 11 Jun 2025 02:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uPF9r-0005PK-T5
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:42:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uPF9j-0002XA-Q6
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:41:59 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxG6wtJUloKXoTAQ--.6994S3;
 Wed, 11 Jun 2025 14:41:49 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxj8UqJUloEZIVAQ--.1940S3;
 Wed, 11 Jun 2025 14:41:49 +0800 (CST)
Subject: Re: [PATCH 06/10] hw/loongarch: Implement avec controller imput and
 output pins
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250609104833.839811-1-gaosong@loongson.cn>
 <20250609104833.839811-7-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5df19ba7-a37d-a806-1461-7f12b36cff70@loongson.cn>
Date: Wed, 11 Jun 2025 14:40:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250609104833.839811-7-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8UqJUloEZIVAQ--.1940S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw48WFW5Jry7uFy5CF1DXFc_yoWrWF4fpF
 W7uFn5Kr1UXFZ7Xwnagw15uFn8Zrn3GFyIga1akrWSkFsrGw109r48JwsIkFWUC3ykua4j
 qF1kZa13Xa17JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8w0eJUU
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
> the AVEC controller supports 256*256 irqs, all the irqs connect CPU INT_AVEC irq
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_avec.c | 28 ++++++++++++++++++++++++++++
>   hw/loongarch/virt.c      | 11 +++++++++--
>   target/loongarch/cpu.h   |  3 ++-
>   3 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
> index 50956e7e4e..c692fef43c 100644
> --- a/hw/intc/loongarch_avec.c
> +++ b/hw/intc/loongarch_avec.c
> @@ -36,9 +36,19 @@ static const MemoryRegionOps loongarch_avec_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
> +static void avec_irq_handler(void *opaque, int irq, int level)
> +{
> +    return;
> +}
> +
>   static void loongarch_avec_realize(DeviceState *dev, Error **errp)
>   {
> +    LoongArchAVECState *s = LOONGARCH_AVEC(dev);
>       LoongArchAVECClass *lac = LOONGARCH_AVEC_GET_CLASS(dev);
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    const CPUArchIdList  *id_list;
> +    int i, irq;
>   
>       Error *local_err = NULL;
>       lac->parent_realize(dev, &local_err);
> @@ -47,6 +57,24 @@ static void loongarch_avec_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    assert(mc->possible_cpu_arch_ids);
> +    id_list = mc->possible_cpu_arch_ids(machine);
> +    s->num_cpu = id_list->len;
> +    s->cpu = g_new(AVECCore, s->num_cpu);
> +    if (s->cpu == NULL) {
> +        error_setg(errp, "Memory allocation for AVECCore fail");
> +        return;
> +    }
> +
> +    for (i = 0; i < s->num_cpu; i++) {
> +        s->cpu[i].arch_id = id_list->cpus[i].arch_id;
> +        s->cpu[i].cpu = CPU(id_list->cpus[i].cpu);
> +        for (irq = 0; irq < NR_VECTORS; irq++) {
> +            qdev_init_gpio_out(dev, &s->cpu[i].parent_irq[irq], 1);
> +        }
One parent irqline for per-cpu is ok, so the total number of parent 
irqline is s->num_cpu, the number of possible cpu.

> +    }
> +    qdev_init_gpio_in(dev, avec_irq_handler, NR_VECTORS * s->num_cpu);
avec_irq_handler() can be removed here.

Regards
Bibo Mao
> +
>       return;
>   }
>   
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 272355da2d..718b5b4f92 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -363,7 +363,7 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
>       }
>   }
>   
> -static void virt_irq_init(LoongArchVirtMachineState *lvms)
> +static void virt_irq_init(LoongArchVirtMachineState *lvms, MachineState *ms)
>   {
>       DeviceState *pch_pic, *pch_msi;
>       DeviceState *ipi, *extioi, *avec;
> @@ -459,6 +459,13 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>           sysbus_realize_and_unref(SYS_BUS_DEVICE(avec), &error_fatal);
>           memory_region_add_subregion(get_system_memory(), VIRT_PCH_MSI_ADDR_LOW,
>                           sysbus_mmio_get_region(SYS_BUS_DEVICE(avec), 0));
> +        CPUState *cpu_state;
> +        DeviceState *cpudev;
> +        for (int cpu = 0; cpu < ms->smp.cpus; cpu++) {
> +            cpu_state = qemu_get_cpu(cpu);
> +            cpudev = DEVICE(cpu_state);
> +            qdev_connect_gpio_out(avec, cpu, qdev_get_gpio_in(cpudev, INT_AVEC));
> +        }
>       }
>   
>       /* Create EXTIOI device */
> @@ -799,7 +806,7 @@ static void virt_init(MachineState *machine)
>       }
>   
>       /* Initialize the IO interrupt subsystem */
> -    virt_irq_init(lvms);
> +    virt_irq_init(lvms, machine);
>       lvms->machine_done.notify = virt_done;
>       qemu_add_machine_init_done_notifier(&lvms->machine_done);
>        /* connect powerdown request */
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index a1918a85da..b96df1cb2a 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -240,9 +240,10 @@ FIELD(CSR_CRMD, WE, 9, 1)
>   extern const char * const regnames[32];
>   extern const char * const fregnames[32];
>   
> -#define N_IRQS      13
> +#define N_IRQS      15
>   #define IRQ_TIMER   11
>   #define IRQ_IPI     12
> +#define INT_AVEC    14
>   
>   #define LOONGARCH_STLB         2048 /* 2048 STLB */
>   #define LOONGARCH_MTLB         64   /* 64 MTLB */
> 


