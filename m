Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53B3D35E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 02:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8VOl-00022n-M3; Tue, 05 Nov 2024 21:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t8VOj-00022b-Ak
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:03:53 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t8VOg-0001X7-DP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:03:53 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxeeF7zipnBj0zAA--.38513S3;
 Wed, 06 Nov 2024 10:03:39 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxXUd7zipndGxEAA--.59281S3;
 Wed, 06 Nov 2024 10:03:39 +0800 (CST)
Subject: Re: [PATCH v3 5/5] hw/loongarch/virt: Enable cpu hotplug feature on
 virt machine
To: Igor Mammedov <imammedo@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20241104063435.4130262-1-maobibo@loongson.cn>
 <20241104063435.4130262-6-maobibo@loongson.cn>
 <20241105145837.3c10b922@imammedo.users.ipa.redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <0abb19d1-8fbe-1938-8227-955e777205e3@loongson.cn>
Date: Wed, 6 Nov 2024 10:03:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241105145837.3c10b922@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXUd7zipndGxEAA--.59281S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JryUAFWfKFy3Xr4rJFyfXwc_yoW7tw48pF
 W7Aas09r4UJFnrC39ag3WYgryvyrn3Kay7ursFyFyfAwnFkr1rJF1Fkw4Y9F4rAayvvF4v
 v3Z8WFsFgF42kFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.588,
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



On 2024/11/5 下午9:58, Igor Mammedov wrote:
> On Mon,  4 Nov 2024 14:34:35 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> On virt machine, enable CPU hotplug feature has_hotpluggable_cpus. For
>> hot-added CPUs after power on, interrupt pin of extioi and ipi interrupt
>> controller need connect to pins of new CPU.
>>
>> Also change num-cpu property of extioi and ipi from smp.cpus to
>> smp.max_cpus
>>
>> Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c         | 57 +++++++++++++++++++++++++++++++++----
>>   include/hw/loongarch/virt.h |  2 ++
>>   2 files changed, 54 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index e73f689c83..6673493109 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -891,8 +891,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>>   
>>       /* Create IPI device */
>>       ipi = qdev_new(TYPE_LOONGARCH_IPI);
>> -    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
>> +    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.max_cpus);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
>> +    lvms->ipi = ipi;
>>   
>>       /* IPI iocsr memory region */
>>       memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
>> @@ -905,11 +906,12 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>>   
>>       /* Create EXTIOI device */
>>       extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
>> -    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
>> +    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.max_cpus);
>>       if (virt_is_veiointc_enabled(lvms)) {
>>           qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
>>       }
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
>> +    lvms->extioi = extioi;
>>       memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
>>                       sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
>>       if (virt_is_veiointc_enabled(lvms)) {
>> @@ -1403,8 +1405,40 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>        }
>>   
>>       if (cpu->phy_id == UNSET_PHY_ID) {
>> -        error_setg(&local_err, "CPU hotplug not supported");
>> -        goto out;
>> +        if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
>> +            error_setg(&local_err,
>> +                       "Invalid thread-id %u specified, must be in range 1:%u",
>> +                       cpu->thread_id, ms->smp.threads - 1);
>> +            goto out;
>> +        }
>> +
>> +        if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
>> +            error_setg(&local_err,
>> +                       "Invalid core-id %u specified, must be in range 1:%u",
>> +                       cpu->core_id, ms->smp.cores - 1);
>> +            goto out;
>> +        }
>> +
>> +        if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
>> +            error_setg(&local_err,
>> +                       "Invalid socket-id %u specified, must be in range 1:%u",
>> +                       cpu->socket_id, ms->smp.sockets - 1);
>> +            goto out;
>> +        }
>> +
>> +        topo.socket_id = cpu->socket_id;
>> +        topo.core_id = cpu->core_id;
>> +        topo.thread_id = cpu->thread_id;
>> +        arch_id =  virt_get_arch_id_from_topo(ms, &topo);
>> +        cpu_slot = virt_find_cpu_slot(ms, arch_id, &index);
>> +        if (CPU(cpu_slot->cpu)) {
>> +            error_setg(&local_err,
>> +                       "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
>> +                       cs->cpu_index, cpu->socket_id, cpu->core_id,
>> +                       cpu->thread_id, cpu_slot->arch_id);
>> +            goto out;
>> +        }
>> +        cpu->phy_id = arch_id;
>>       } else {
>>           /*
>>            * For cold-add cpu, topo property is not set. And only physical id
>> @@ -1484,10 +1518,22 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>>                                   DeviceState *dev, Error **errp)
>>   {
>>       CPUArchId *cpu_slot;
>> +    Error *local_err = NULL;
>>       LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>> +    MachineState *ms = MACHINE(hotplug_dev);
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
>>   
>> -    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
>> +    if (lvms->acpi_ged) {
>> +        /* Connect irq to cpu, including ipi and extioi irqchip */
> 
>> +        virt_init_cpu_irq(ms, CPU(cpu));
> 
> why it depends on GED?
> Can't you just call it unconditionally here for both hotplugged and coldplugged CPUs?
> /and drop this call from for() loop of coldplug CPUs/
yes, will do in this way, then it will be unified for hotplugged and 
coldplugged CPUs.

CPU objects need be created after interrupt controller, also it can be 
created after acpi ged device. From the code function 
hotplug_handler_plug() will check PHASE_MACHINE_READY and hotplugged 
state, and do nothing for coldplugged CPUs.

And thanks for your guidance, will send the patch in next round.

Regards
Bibo Mao
> 
>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>> +    }
>> +
>> +    cpu_slot = virt_find_cpu_slot(ms, cpu->phy_id, NULL);
>>       cpu_slot->cpu = CPU(dev);
>>       return;
>>   }
>> @@ -1671,6 +1717,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
>>       mc->numa_mem_supported = true;
>>       mc->auto_enable_numa_with_memhp = true;
>>       mc->auto_enable_numa_with_memdev = true;
>> +    mc->has_hotpluggable_cpus = true;
>>       mc->get_hotplug_handler = virt_get_hotplug_handler;
>>       mc->default_nic = "virtio-net-pci";
>>       hc->plug = virt_device_plug_cb;
>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>> index 861034d614..79a85723c9 100644
>> --- a/include/hw/loongarch/virt.h
>> +++ b/include/hw/loongarch/virt.h
>> @@ -61,6 +61,8 @@ struct LoongArchVirtMachineState {
>>       MemoryRegion iocsr_mem;
>>       AddressSpace as_iocsr;
>>       struct loongarch_boot_info bootinfo;
>> +    DeviceState *ipi;
>> +    DeviceState *extioi;
>>   };
>>   
>>   #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
> 


