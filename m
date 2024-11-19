Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E4DD60D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 10:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDLKE-0001D4-9V; Tue, 19 Nov 2024 05:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tDLKC-0001CX-Dr
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:19:12 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tDLK9-0000fG-AX
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:19:12 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxQK0XZjxnImFCAA--.25793S3;
 Tue, 19 Nov 2024 18:19:04 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxHEcUZjxnLjZdAA--.28031S3;
 Tue, 19 Nov 2024 18:19:03 +0800 (CST)
Subject: Re: [PATCH v4 6/6] hw/loongarch/virt: Enable cpu hotplug feature on
 virt machine
To: Igor Mammedov <imammedo@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20241112021738.1952851-1-maobibo@loongson.cn>
 <20241112021738.1952851-7-maobibo@loongson.cn>
 <20241118180306.6b8019c4@imammedo.users.ipa.redhat.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <2ecae20c-d354-5cb7-0972-f0fdc2c568c2@loongson.cn>
Date: Tue, 19 Nov 2024 18:18:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241118180306.6b8019c4@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHEcUZjxnLjZdAA--.28031S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw1kXw4kWFy5ArW3tr48Xwc_yoWxCw4rpr
 WUA3Wq9r1UAFnFv3ySqF1Ygr1Fyr18Gay7WrZFyF13Z3Wqkr95JF1Ykw4YgFs3u34vqF40
 93Z8AFsF9F42gFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
 14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2uc_DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.492,
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



On 2024/11/19 上午1:03, Igor Mammedov wrote:
> On Tue, 12 Nov 2024 10:17:38 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> On virt machine, enable CPU hotplug feature has_hotpluggable_cpus. For
>> hot-added CPUs, there is socket-id/core-id/thread-id property set,
>> arch_id can be caculated from these properties. So that cpu slot can be
>> searched from its arch_id.
>>
>> Also change num-cpu property of extioi and ipi from smp.cpus to
>> smp.max_cpus
>>
>> Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c | 68 +++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 59 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index b49b15c0f6..5f81673368 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -890,7 +890,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>>   
>>       /* Create IPI device */
>>       ipi = qdev_new(TYPE_LOONGARCH_IPI);
>> -    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
>> +    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.max_cpus);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
>>       lvms->ipi = ipi;
>>   
>> @@ -905,7 +905,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>>   
>>       /* Create EXTIOI device */
>>       extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
>> -    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
>> +    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.max_cpus);
>>       if (virt_is_veiointc_enabled(lvms)) {
>>           qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
>>       }
>> @@ -1369,11 +1369,15 @@ static void virt_get_topo_from_index(MachineState *ms,
>>   }
>>   
>>   /* Find cpu slot in machine->possible_cpus by arch_id */
>> -static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id)
>> +static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id, int *index)
>>   {
>>       int n;
>>       for (n = 0; n < ms->possible_cpus->len; n++) {
>>           if (ms->possible_cpus->cpus[n].arch_id == arch_id) {
>> +            if (index) {
>> +                *index = n;
>> +            }
>> +
>>               return &ms->possible_cpus->cpus[n];
>>           }
>>       }
>> @@ -1386,10 +1390,12 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>   {
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
>>       MachineState *ms = MACHINE(OBJECT(hotplug_dev));
>> +    CPUState *cs = CPU(dev);
>>       LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>>       CPUArchId *cpu_slot;
>>       Error *local_err = NULL;
>> -    int arch_id;
>> +    LoongArchCPUTopo topo;
>> +    int arch_id, index;
>>   
>>       /* sanity check the cpu */
>>       if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
>> @@ -1408,12 +1414,45 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>        }
>>   
>>       if (cpu->phy_id == UNSET_PHY_ID) {
> 
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
>> +        cs->cpu_index = index;
> this whole branch applies to cold-plugged CPUs as well, especially
> if both (hot/cold plugged CPUs are getting wired with help of pre_plug)
> So this hunk should be introduced somewhere earlier in series,
> and than I'd likely won't need (cpu->phy_id == UNSET_PHY_ID) check to begin with.
> 
> the only difference vs cold-plug would be need to call acpi_ged plug handler,
> like you are dong below in virt_cpu_plug
Sure, will check acpi_ged plug handler for cold-plug/hot-plug CPU.

> 
>>       } else {
>>           /* For cold-add cpu, find cpu slot from arch_id */
>>           arch_id = cpu->phy_id;
>> -        cpu_slot = virt_find_cpu_slot(ms, arch_id);
>> +        cpu_slot = virt_find_cpu_slot(ms, arch_id, NULL);
>>       }
>>   
>>       numa_cpu_pre_plug(cpu_slot, dev, &local_err);
>> @@ -1468,7 +1507,7 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>>           return;
>>       }
>>   
>> -    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>> +    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
>>       cpu_slot->cpu = NULL;
>>       return;
>>   }
>> @@ -1477,14 +1516,24 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>>                                   DeviceState *dev, Error **errp)
>>   {
>>       CPUArchId *cpu_slot;
>> +    Error *local_err = NULL;
>>       LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>>       MachineState *ms = MACHINE(hotplug_dev);
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
>>   
>>       /* Connect irq to cpu, including ipi and extioi irqchip */
>>       virt_init_cpu_irq(ms, CPU(cpu));
>> -    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>> +    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
>>       cpu_slot->cpu = CPU(dev);
>> +
>> +    if (lvms->acpi_ged) {
> Why do you need check, can machine be created without acpi_ged?
There is no NULL check with macro HOTPLUG_HANDLER() for cold-plug cpu.
Now machine is created with acpi_ged always, in later will add noapic 
option support.

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
>>       return;
>>   }
>>   
>> @@ -1667,6 +1716,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
>>       mc->numa_mem_supported = true;
>>       mc->auto_enable_numa_with_memhp = true;
>>       mc->auto_enable_numa_with_memdev = true;
>> +    mc->has_hotpluggable_cpus = true;
>>       mc->get_hotplug_handler = virt_get_hotplug_handler;
>>       mc->default_nic = "virtio-net-pci";
>>       hc->plug = virt_device_plug_cb;


