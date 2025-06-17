Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1D8C71159
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 01:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRL5X-0007Qq-UQ; Mon, 16 Jun 2025 21:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uRL5Q-0007Q7-Af
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 21:26:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uRL5N-0001Ha-EW
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 21:26:04 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxyuAbxFBo9A4YAQ--.56295S3;
 Tue, 17 Jun 2025 09:25:47 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxXsUUxFBovsEdAQ--.25346S3;
 Tue, 17 Jun 2025 09:25:42 +0800 (CST)
Subject: Re: [PATCH 06/10] hw/loongarch: Implement avec controller imput and
 output pins
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250609104833.839811-1-gaosong@loongson.cn>
 <20250609104833.839811-7-gaosong@loongson.cn>
 <5df19ba7-a37d-a806-1461-7f12b36cff70@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <eebfb1f6-91ec-3014-c914-44522d4360cb@loongson.cn>
Date: Tue, 17 Jun 2025 09:28:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5df19ba7-a37d-a806-1461-7f12b36cff70@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxXsUUxFBovsEdAQ--.25346S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XF4UAr4rCF4UGFWfCry7XFc_yoW7Ary8pr
 ykAFy5JryUGr93Xw17J345WF98Ar18G3W2qr4S9Fy0yFsrAr10gr4UXrn0gFyUAw4kJr1U
 Xr1kXF43ZF17JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.129,
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

在 2025/6/11 下午2:40, Bibo Mao 写道:
>
>
> On 2025/6/9 下午6:48, Song Gao wrote:
>> the AVEC controller supports 256*256 irqs, all the irqs connect CPU 
>> INT_AVEC irq
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/intc/loongarch_avec.c | 28 ++++++++++++++++++++++++++++
>>   hw/loongarch/virt.c      | 11 +++++++++--
>>   target/loongarch/cpu.h   |  3 ++-
>>   3 files changed, 39 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
>> index 50956e7e4e..c692fef43c 100644
>> --- a/hw/intc/loongarch_avec.c
>> +++ b/hw/intc/loongarch_avec.c
>> @@ -36,9 +36,19 @@ static const MemoryRegionOps loongarch_avec_ops = {
>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>   };
>>   +static void avec_irq_handler(void *opaque, int irq, int level)
>> +{
>> +    return;
>> +}
>> +
>>   static void loongarch_avec_realize(DeviceState *dev, Error **errp)
>>   {
>> +    LoongArchAVECState *s = LOONGARCH_AVEC(dev);
>>       LoongArchAVECClass *lac = LOONGARCH_AVEC_GET_CLASS(dev);
>> +    MachineState *machine = MACHINE(qdev_get_machine());
>> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
>> +    const CPUArchIdList  *id_list;
>> +    int i, irq;
>>         Error *local_err = NULL;
>>       lac->parent_realize(dev, &local_err);
>> @@ -47,6 +57,24 @@ static void loongarch_avec_realize(DeviceState 
>> *dev, Error **errp)
>>           return;
>>       }
>>   +    assert(mc->possible_cpu_arch_ids);
>> +    id_list = mc->possible_cpu_arch_ids(machine);
>> +    s->num_cpu = id_list->len;
>> +    s->cpu = g_new(AVECCore, s->num_cpu);
>> +    if (s->cpu == NULL) {
>> +        error_setg(errp, "Memory allocation for AVECCore fail");
>> +        return;
>> +    }
>> +
>> +    for (i = 0; i < s->num_cpu; i++) {
>> +        s->cpu[i].arch_id = id_list->cpus[i].arch_id;
>> +        s->cpu[i].cpu = CPU(id_list->cpus[i].cpu);
>> +        for (irq = 0; irq < NR_VECTORS; irq++) {
>> +            qdev_init_gpio_out(dev, &s->cpu[i].parent_irq[irq], 1);
>> +        }
> One parent irqline for per-cpu is ok, so the total number of parent 
> irqline is s->num_cpu, the number of possible cpu.
>
emm,  yes ,  so the avec gpio out num is s->num_cpu * s->num_cpu.,
my thought   avec should  gpio_out = aveec gpio in,  and the avec gpio 
in is NR_VECTORS * s->num_cpu.
>> +    }
>> +    qdev_init_gpio_in(dev, avec_irq_handler, NR_VECTORS * s->num_cpu);
> avec_irq_handler() can be removed here.
>
yes.  i 'll remove on v2.

thanks.
Song Gao
> Regards
> Bibo Mao
>> +
>>       return;
>>   }
>>   diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 272355da2d..718b5b4f92 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -363,7 +363,7 @@ static void 
>> virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
>>       }
>>   }
>>   -static void virt_irq_init(LoongArchVirtMachineState *lvms)
>> +static void virt_irq_init(LoongArchVirtMachineState *lvms, 
>> MachineState *ms)
>>   {
>>       DeviceState *pch_pic, *pch_msi;
>>       DeviceState *ipi, *extioi, *avec;
>> @@ -459,6 +459,13 @@ static void 
>> virt_irq_init(LoongArchVirtMachineState *lvms)
>>           sysbus_realize_and_unref(SYS_BUS_DEVICE(avec), &error_fatal);
>>           memory_region_add_subregion(get_system_memory(), 
>> VIRT_PCH_MSI_ADDR_LOW,
>> sysbus_mmio_get_region(SYS_BUS_DEVICE(avec), 0));
>> +        CPUState *cpu_state;
>> +        DeviceState *cpudev;
>> +        for (int cpu = 0; cpu < ms->smp.cpus; cpu++) {
>> +            cpu_state = qemu_get_cpu(cpu);
>> +            cpudev = DEVICE(cpu_state);
>> +            qdev_connect_gpio_out(avec, cpu, 
>> qdev_get_gpio_in(cpudev, INT_AVEC));
here connect all  avec gpio_out to  cpu gpio_in  INT_AVEC.
>> +        }
>>       }
>>         /* Create EXTIOI device */
>> @@ -799,7 +806,7 @@ static void virt_init(MachineState *machine)
>>       }
>>         /* Initialize the IO interrupt subsystem */
>> -    virt_irq_init(lvms);
>> +    virt_irq_init(lvms, machine);
>>       lvms->machine_done.notify = virt_done;
>> qemu_add_machine_init_done_notifier(&lvms->machine_done);
>>        /* connect powerdown request */
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index a1918a85da..b96df1cb2a 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -240,9 +240,10 @@ FIELD(CSR_CRMD, WE, 9, 1)
>>   extern const char * const regnames[32];
>>   extern const char * const fregnames[32];
>>   -#define N_IRQS      13
>> +#define N_IRQS      15
>>   #define IRQ_TIMER   11
>>   #define IRQ_IPI     12
>> +#define INT_AVEC    14
>>     #define LOONGARCH_STLB         2048 /* 2048 STLB */
>>   #define LOONGARCH_MTLB         64   /* 64 MTLB */
>>


