Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E5DCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 02:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utGmC-0001SF-4f; Mon, 01 Sep 2025 22:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1utGm9-0001S6-Mu
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 22:29:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1utGm5-0003ry-Ql
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 22:29:37 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxF9GEVrZoOJoFAA--.11588S3;
 Tue, 02 Sep 2025 10:29:25 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxH8J_VrZoQRh4AA--.61809S3;
 Tue, 02 Sep 2025 10:29:24 +0800 (CST)
Subject: Re: [PATCH v2] hw/loongarch/virt: Add reset interface for virt-machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20250901081900.2931303-1-maobibo@loongson.cn>
 <e99ce8c4-b2cc-4eba-a947-f150330eda34@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <a205202e-7d0d-0739-ddd6-11a2081a9810@loongson.cn>
Date: Tue, 2 Sep 2025 10:27:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e99ce8c4-b2cc-4eba-a947-f150330eda34@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8J_VrZoQRh4AA--.61809S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww43ur1xJrW5WryDJr13GFX_yoWxWr47pr
 ykAFW5JrWrGr1kXw47A34UuFyDZr1xKa13ZF1xtFyIkr4UXryjqr1jqr9FgF1UAw4rWF1Y
 vr1DXw17ZF47J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.599,
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



On 2025/9/1 下午6:51, Philippe Mathieu-Daudé wrote:
> Hi Bibo,
> 
> On 1/9/25 10:19, Bibo Mao wrote:
>> With generic cpu reset interface, pc register is entry of FLASH for
>> UEFI BIOS. However with direct kernel booting requirement, there is
>> a little different, pc register of primary cpu is entry address of ELF
>> file.
>>
>> At the same time with requirement of cpu hotplug, hot-added CPU should
>> register reset interface for this cpu object. Now reset callback is
>> not registered for hot-added CPU.
>>
>> With this patch reset callback for CPU is register when CPU instance
>> is created, and reset interface is added for virt-machine board. In
>> reset interface of virt-machine, reset for direct kernel booting
>> requirement is called.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>> v1 ... v2:
>>    1. Add qemu_unregister_reset() in function 
>> loongarch_cpu_unrealizefn(),
>>       remove reset callback if vCPU is unrealized.
>> ---
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/boot.c         |  9 +--------
>>   hw/loongarch/virt.c         | 14 ++++++++++++++
>>   include/hw/loongarch/boot.h |  1 +
>>   target/loongarch/cpu.c      | 11 +++++++++++
>>   4 files changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index 14d6c52d4e..4919758a20 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -324,12 +324,11 @@ static int64_t load_kernel_info(struct 
>> loongarch_boot_info *info)
>>       return kernel_entry;
>>   }
>> -static void reset_load_elf(void *opaque)
>> +void reset_load_elf(void *opaque)
>>   {
>>       LoongArchCPU *cpu = opaque;
>>       CPULoongArchState *env = &cpu->env;
>> -    cpu_reset(CPU(cpu));
>>       if (env->load_elf) {
>>           if (cpu == LOONGARCH_CPU(first_cpu)) {
>>               env->gpr[4] = env->boot_info->a0;
>> @@ -429,12 +428,6 @@ static void 
>> loongarch_direct_kernel_boot(MachineState *ms,
>>   void loongarch_load_kernel(MachineState *ms, struct 
>> loongarch_boot_info *info)
>>   {
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
>> -    int i;
>> -
>> -    /* register reset function */
>> -    for (i = 0; i < ms->smp.cpus; i++) {
>> -        qemu_register_reset(reset_load_elf, 
>> LOONGARCH_CPU(qemu_get_cpu(i)));
> 
> I agree CPU reset shouldn't be part of loading code to memory.
> 
>> -    }
>>       info->kernel_filename = ms->kernel_filename;
>>       info->kernel_cmdline = ms->kernel_cmdline;
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index b15ada2078..4fc8506c10 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -1199,6 +1199,19 @@ static int64_t 
>> virt_get_default_cpu_node_id(const MachineState *ms, int idx)
>>       }
>>   }
>> +static void virt_reset(MachineState *machine, ResetType type)
>> +{
>> +    CPUState *cs;
>> +
>> +    /* Reset all devices including CPU devices */
>> +    qemu_devices_reset(type);
>  > +> +    /* Reset PC and register context for kernel direct booting 
> method */
>> +    CPU_FOREACH(cs) {
>> +        reset_load_elf(LOONGARCH_CPU(cs));
>> +    }
>> +}
>> +
>>   static void virt_class_init(ObjectClass *oc, const void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -1223,6 +1236,7 @@ static void virt_class_init(ObjectClass *oc, 
>> const void *data)
>>       mc->has_hotpluggable_cpus = true;
>>       mc->get_hotplug_handler = virt_get_hotplug_handler;
>>       mc->default_nic = "virtio-net-pci";
>> +    mc->reset = virt_reset;
>>       hc->plug = virt_device_plug_cb;
>>       hc->pre_plug = virt_device_pre_plug;
>>       hc->unplug_request = virt_device_unplug_request;
>> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
>> index 9819f7fbe3..386b4406ad 100644
>> --- a/include/hw/loongarch/boot.h
>> +++ b/include/hw/loongarch/boot.h
>> @@ -114,5 +114,6 @@ struct memmap_entry {
>>   };
>>   void loongarch_load_kernel(MachineState *ms, struct 
>> loongarch_boot_info *info);
>> +void reset_load_elf(void *opaque);
>>   #endif /* HW_LOONGARCH_BOOT_H */
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index 3a7621c0ea..61c8acb3c2 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -652,6 +652,13 @@ static void loongarch_cpu_disas_set_info(CPUState 
>> *s, disassemble_info *info)
>>       info->print_insn = print_insn_loongarch;
>>   }
>> +#ifndef CONFIG_USER_ONLY
>> +static void loongarch_cpu_reset_cb(void *opaque)
>> +{
>> +    cpu_reset((CPUState *) opaque);
>> +}
>> +#endif
>> +
>>   static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>>   {
>>       CPUState *cs = CPU(dev);
>> @@ -668,6 +675,9 @@ static void loongarch_cpu_realizefn(DeviceState 
>> *dev, Error **errp)
>>       qemu_init_vcpu(cs);
>>       cpu_reset(cs);
> 
> Devices shouldn't call their DeviceReset handler manually, as it is
> always called after DeviceRealize.
ok, will remove this.

> 
>> +#ifndef CONFIG_USER_ONLY
>> +    qemu_register_reset(loongarch_cpu_reset_cb, dev);
> 
> qemu_register_reset() is a legacy API, replaced by
> qemu_register_resettable().
> 
> That said, I don't think the CPU object has to register its own
> reset handlers. Instead that should the be responsibility of the
> object creating the CPU objects.
sure, will use qemu_register_resettable().
> 
>> +#endif
>>       lacc->parent_realize(dev, errp);
>>   }
>> @@ -678,6 +688,7 @@ static void loongarch_cpu_unrealizefn(DeviceState 
>> *dev)
>>   #ifndef CONFIG_USER_ONLY
>>       cpu_remove_sync(CPU(dev));
>> +    qemu_unregister_reset(loongarch_cpu_reset_cb, dev);
> 
> Ditto, legacy -> qemu_unregister_resettable().
will use qemu_unregister_resettable().

Regards
Bibo Mao
> 
>>   #endif
>>       lacc->parent_unrealize(dev);
>>
>> base-commit: 91589bcd9fee0e66b241d04e5f37cd4f218187a2


