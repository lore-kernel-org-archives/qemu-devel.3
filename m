Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7C7D690ED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 09:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGaQs-00069D-DE; Thu, 28 Nov 2024 04:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tGaQo-00068w-Jg
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 04:03:26 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tGaQl-0007OD-Ek
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 04:03:26 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxquDJMUhnTYVKAA--.14777S3;
 Thu, 28 Nov 2024 17:03:05 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxFMDHMUhn1jprAA--.46771S3;
 Thu, 28 Nov 2024 17:03:03 +0800 (CST)
Subject: Re: [PATCH v4 3/6] hw/loongarch/virt: Add generic function to init
 interrupt pin of CPU
To: Igor Mammedov <imammedo@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20241112021738.1952851-1-maobibo@loongson.cn>
 <20241112021738.1952851-4-maobibo@loongson.cn>
 <20241118174346.23b6d2ee@imammedo.users.ipa.redhat.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <0c06945b-9a18-e52b-6288-d20255c36dc2@loongson.cn>
Date: Thu, 28 Nov 2024 17:02:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241118174346.23b6d2ee@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxFMDHMUhn1jprAA--.46771S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFykAr1UAFy7KFyrKF48GrX_yoW3Ww4DpF
 W8CanY9r4UJFWfWws2gw1UuF1vvrnakFy2gw4akF4SkF1qkryrCr1DAw45Cay8CrWkXF10
 v3WkXFW3WFnrA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
 e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.901,
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



On 2024/11/19 上午12:43, Igor Mammedov wrote:
> On Tue, 12 Nov 2024 10:17:35 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> Here generic function virt_init_cpu_irq() is added to init interrupt
>> pin of CPU object, IPI and extioi interrupt controllers are connected
>> to interrupt pin of CPU object.
>>
>> The generic function can be used to both cold-plug and hot-plug CPUs.
> 
> this patch is heavily depends on cpu_index and specific order CPUs
> are created.
> 
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c         | 78 ++++++++++++++++++++++++-------------
>>   include/hw/loongarch/virt.h |  2 +
>>   2 files changed, 53 insertions(+), 27 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index b6b616d278..621380e2b3 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -58,6 +58,20 @@ static bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>>       return true;
>>   }
>>   
>> +static CPUState *virt_get_cpu(MachineState *ms, int index)
>> +{
>> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>> +    const CPUArchIdList *possible_cpus;
>> +
>> +    /* Init CPUs */
>> +    possible_cpus = mc->possible_cpu_arch_ids(ms);
>> +    if (index < 0 || index >= possible_cpus->len) {
>> +        return NULL;
>> +    }
>> +
>> +    return possible_cpus->cpus[index].cpu;
>> +}
> 
> instead of adding this helper I'd suggest to try reusing
> virt_find_cpu_slot() added in previous patch.
> 
>> +
>>   static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
>>                                 void *opaque, Error **errp)
>>   {
>> @@ -365,7 +379,7 @@ static void create_fdt(LoongArchVirtMachineState *lvms)
>>   static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
>>   {
>>       int num;
>> -    const MachineState *ms = MACHINE(lvms);
>> +    MachineState *ms = MACHINE(lvms);
>>       int smp_cpus = ms->smp.cpus;
>>   
>>       qemu_fdt_add_subnode(ms->fdt, "/cpus");
>> @@ -375,7 +389,7 @@ static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
>>       /* cpu nodes */
>>       for (num = smp_cpus - 1; num >= 0; num--) {
> 
> loops based on smp_cpus become broken as soon as you have
>   '-smp x, -device your-cpu,...
> since it doesn't take in account '-device' created CPUs.
> You likely need to replace such loops to iterate over possible_cpus
> (in a separate patch please)
>    
>>           char *nodename = g_strdup_printf("/cpus/cpu@%d", num);
>> -        LoongArchCPU *cpu = LOONGARCH_CPU(qemu_get_cpu(num));
>> +        LoongArchCPU *cpu = LOONGARCH_CPU(virt_get_cpu(ms, num));
>>           CPUState *cs = CPU(cpu);
>>   
>>           qemu_fdt_add_subnode(ms->fdt, nodename);
>> @@ -783,16 +797,42 @@ static void virt_devices_init(DeviceState *pch_pic,
>>       lvms->platform_bus_dev = create_platform_bus(pch_pic);
>>   }
>>   
>> +static void virt_init_cpu_irq(MachineState *ms, CPUState *cs)
>> +{
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>> +    CPULoongArchState *env;
>> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
>> +    int pin;
>> +
>> +    if (!lvms->ipi || !lvms->extioi) {
>> +        return;
>> +    }
>> +
>> +    env = &(cpu->env);
>> +    env->address_space_iocsr = &lvms->as_iocsr;
>> +    env->ipistate = lvms->ipi;
>> +    /* connect ipi irq to cpu irq, logic cpu index used here */
>> +    qdev_connect_gpio_out(lvms->ipi, cs->cpu_index,
> I'd try to avoid using cpu_index (basically internal CPU detail) when
> wiring components together. It would be better to implement this the way
> the real hw does it.

lapic is created when x86 cpu object is realized, there is no lapic on 
LoongArch. One mechanism need be used to notify irqchip driver to setup 
interrupt routing for multiple processors when CPU is added.

How about adding HOTPLUG interface in irqchip driver, notifying irqchip 
driver when cpu is added? The sample code is shown at website
https://lore.kernel.org/qemu-devel/20241128021024.662057-5-maobibo@loongson.cn/T/#u

If so, qdev_connect_gpio_out and cs->cpu_index will be removed, just 
hotplug_handler_plug() notification to irqchip driver is used such as
    hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), cs, &local_err);

Regards
Bibo Mao
> 
> 
>> +                              qdev_get_gpio_in(DEVICE(cs), IRQ_IPI));
>> +
>> +    /*
>> +     * connect ext irq to the cpu irq
>> +     * cpu_pin[9:2] <= intc_pin[7:0]
>> +     */
>> +    for (pin = 0; pin < LS3A_INTC_IP; pin++) {
>> +        qdev_connect_gpio_out(lvms->extioi, cs->cpu_index * LS3A_INTC_IP + pin,
>> +                              qdev_get_gpio_in(DEVICE(cs), pin + 2));
>> +    }
>> +}
>> +
>>   static void virt_irq_init(LoongArchVirtMachineState *lvms)
>>   {
>>       MachineState *ms = MACHINE(lvms);
>> -    DeviceState *pch_pic, *pch_msi, *cpudev;
>> +    DeviceState *pch_pic, *pch_msi;
>>       DeviceState *ipi, *extioi;
>>       SysBusDevice *d;
>> -    LoongArchCPU *lacpu;
>> -    CPULoongArchState *env;
>>       CPUState *cpu_state;
>> -    int cpu, pin, i, start, num;
>> +    int cpu, i, start, num;
>>       uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle, pch_msi_phandle;
>>   
>>       /*
>> @@ -843,6 +883,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>>       ipi = qdev_new(TYPE_LOONGARCH_IPI);
>>       qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
>> +    lvms->ipi = ipi;
>>   
>>       /* IPI iocsr memory region */
>>       memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
>> @@ -853,18 +894,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>>       /* Add cpu interrupt-controller */
>>       fdt_add_cpuic_node(lvms, &cpuintc_phandle);
>>   
>> -    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
>> -        cpu_state = qemu_get_cpu(cpu);
>> -        cpudev = DEVICE(cpu_state);
>> -        lacpu = LOONGARCH_CPU(cpu_state);
>> -        env = &(lacpu->env);
>> -        env->address_space_iocsr = &lvms->as_iocsr;
>> -
>> -        /* connect ipi irq to cpu irq */
>> -        qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_IPI));
>> -        env->ipistate = ipi;
>> -    }
>> -
>>       /* Create EXTIOI device */
>>       extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
>>       qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
>> @@ -872,6 +901,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>>           qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
>>       }
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
>> +    lvms->extioi = extioi;
>>       memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
>>                       sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
>>       if (virt_is_veiointc_enabled(lvms)) {
>> @@ -879,16 +909,10 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>>                       sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
>>       }
>>   
>> -    /*
>> -     * connect ext irq to the cpu irq
>> -     * cpu_pin[9:2] <= intc_pin[7:0]
>> -     */
>> +    /* Connect irq to cpu, including ipi and extioi irqchip */
>>       for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
>> -        cpudev = DEVICE(qemu_get_cpu(cpu));
>> -        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
>> -            qdev_connect_gpio_out(extioi, (cpu * 8 + pin),
>> -                                  qdev_get_gpio_in(cpudev, pin + 2));
>> -        }
>> +        cpu_state = virt_get_cpu(ms, cpu);
>> +        virt_init_cpu_irq(ms, cpu_state);
>>       }
>>   
>>       /* Add Extend I/O Interrupt Controller node */
>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>> index 9ba47793ef..260e6bd7cf 100644
>> --- a/include/hw/loongarch/virt.h
>> +++ b/include/hw/loongarch/virt.h
>> @@ -60,6 +60,8 @@ struct LoongArchVirtMachineState {
>>       MemoryRegion iocsr_mem;
>>       AddressSpace as_iocsr;
>>       struct loongarch_boot_info bootinfo;
>> +    DeviceState *ipi;
>> +    DeviceState *extioi;
>>   };
>>   
>>   #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
> 


