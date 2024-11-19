Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD1FD60074
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 08:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDJBt-0006w7-1K; Tue, 19 Nov 2024 03:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tDJBq-0006vk-Fp
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 03:02:26 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tDJBn-0005X8-9M
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 03:02:26 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxG+IIRjxn8UFCAA--.64102S3;
 Tue, 19 Nov 2024 16:02:16 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCx70cDRjxnsBFdAA--.28216S3;
 Tue, 19 Nov 2024 16:02:16 +0800 (CST)
Subject: Re: [PATCH v4 1/6] hw/loongarch/virt: Add CPU topology support
To: Igor Mammedov <imammedo@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20241112021738.1952851-1-maobibo@loongson.cn>
 <20241112021738.1952851-2-maobibo@loongson.cn>
 <20241118171029.5a9ed8bd@imammedo.users.ipa.redhat.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <10896516-58cd-d614-e6f0-f9c683da7b88@loongson.cn>
Date: Tue, 19 Nov 2024 16:01:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241118171029.5a9ed8bd@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx70cDRjxnsBFdAA--.28216S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3tw4ktw15Aw17XF45try8CrX_yoWkWrWxpr
 Wqk3Way3WUJr93ZwsxW3W3WF1ktr1Ig3WxXa4xKa1Fk3WqgryrJr18K390vF4ku3yDXF10
 vF48JF13uFy0gFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xu
 ctUUUUU==
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


Hi Ignor,

On 2024/11/19 上午12:10, Igor Mammedov wrote:
> On Tue, 12 Nov 2024 10:17:33 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> Add topological relationships for Loongarch VCPU and initialize
>> topology member variables. Also physical cpu id calculation
>> method comes from its topo information.
>>
>> Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   docs/system/loongarch/virt.rst | 31 +++++++++++++++
>>   hw/loongarch/virt.c            | 73 ++++++++++++++++++++++++++++------
>>   target/loongarch/cpu.c         | 12 ++++++
>>   target/loongarch/cpu.h         | 16 ++++++++
>>   4 files changed, 119 insertions(+), 13 deletions(-)
>>
>> diff --git a/docs/system/loongarch/virt.rst b/docs/system/loongarch/virt.rst
>> index 172fba079e..8daf60785f 100644
>> --- a/docs/system/loongarch/virt.rst
>> +++ b/docs/system/loongarch/virt.rst
>> @@ -28,6 +28,37 @@ The ``qemu-system-loongarch64`` provides emulation for virt
>>   machine. You can specify the machine type ``virt`` and
>>   cpu type ``la464``.
>>   
>> +CPU Topology
>> +------------
>> +
>> +The ``LA464`` type CPUs have the concept of Socket Core and Thread.
>> +
>> +For example:
>> +
>> +``-smp 1,maxcpus=M,sockets=S,cores=C,threads=T``
>> +
>> +The above parameters indicate that the machine has a maximum of ``M`` vCPUs and
>> +``S`` sockets, each socket has ``C`` cores, each core has ``T`` threads,
>> +and each thread corresponds to a vCPU.
>> +
>> +Then ``M`` ``S`` ``C`` ``T`` has the following relationship:
>> +
>> +``M = S * C * T``
>> +
>> +In the CPU topology relationship, When we know the ``socket_id`` ``core_id``
>> +and ``thread_id`` of the CPU, we can calculate its ``arch_id``:
>> +
>> +``arch_id = (socket_id * S) + (core_id * C) + (thread_id * T)``
> 
> Is there a spec or some other reference where all of this is described?
> (or is that a made up just for QEMU?)
With hardware manual about cpuid register, it only says that it is 9-bit 
width now, however there is no detailed introduction about 
socket_id/core_id/thread_id about this register. So it can be treated as 
a made up for QEMU.
> 
> 
>> +
>> +Similarly, when we know the ``arch_id`` of the CPU,
>> +we can also get its ``socket_id`` ``core_id`` and ``thread_id``:
>> +
>> +``socket_id = arch_id / (C * T)``
>> +
>> +``core_id = (arch_id / T) % C``
>> +
>> +``thread_id = arch_id % T``
>> +
>>   Boot options
>>   ------------
>>   
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 9a635d1d3d..1ed5130edf 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -1143,9 +1143,9 @@ static void virt_init(MachineState *machine)
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
>>       int i;
>>       hwaddr base, size, ram_size = machine->ram_size;
>> -    const CPUArchIdList *possible_cpus;
>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>>       CPUState *cpu;
>> +    Object *cpuobj;
>>   
>>       if (!cpu_model) {
>>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
>> @@ -1163,13 +1163,30 @@ static void virt_init(MachineState *machine)
>>       memory_region_add_subregion(&lvms->system_iocsr, 0, &lvms->iocsr_mem);
>>   
>>       /* Init CPUs */
>> -    possible_cpus = mc->possible_cpu_arch_ids(machine);
> I'd keep this, and use below, it makes line shorter
Sure, will modify it in next version.

> 
> 
>> -    for (i = 0; i < possible_cpus->len; i++) {
>> -        cpu = cpu_create(machine->cpu_type);
>> +    mc->possible_cpu_arch_ids(machine);
>> +    for (i = 0; i < machine->smp.cpus; i++) {
>> +        cpuobj = object_new(machine->cpu_type);
>> +        if (cpuobj == NULL) {
>> +            error_report("Fail to create object with type %s ",
>> +                         machine->cpu_type);
>> +            exit(EXIT_FAILURE);
>> +        }
>> +
>> +        cpu = CPU(cpuobj);
> 
>>           cpu->cpu_index = i;
> this probably should be in _pre_plug handler,
> also see
> (a15d2728a9aa pc: Init CPUState->cpu_index with index in possible_cpus[])
> for why x86 does it.
> 
Will modify it in next version.

>>           machine->possible_cpus->cpus[i].cpu = cpu;
>> -        lacpu = LOONGARCH_CPU(cpu);
>> +        lacpu = LOONGARCH_CPU(cpuobj);
> 
>>           lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
> Given above is derived from topo data set below, I'd move above above
> to pre_plug time, and calculate/set it there based on topo data.
> There is no point in setting both at the same place.
> 
Will do.
>> +        object_property_set_int(cpuobj, "socket-id",
>> +                                machine->possible_cpus->cpus[i].props.socket_id,
>> +                                NULL);
>> +        object_property_set_int(cpuobj, "core-id",
>> +                                machine->possible_cpus->cpus[i].props.core_id,
>> +                                NULL);
>> +        object_property_set_int(cpuobj, "thread-id",
>> +                                machine->possible_cpus->cpus[i].props.thread_id,
>> +                                NULL);
>> +        qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
>>       }
>>       fdt_add_cpu_nodes(lvms);
>>       fdt_add_memory_nodes(machine);
>> @@ -1286,6 +1303,35 @@ static void virt_initfn(Object *obj)
>>       virt_flash_create(lvms);
>>   }
>>   
>> +static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPUTopo *topo)
>> +{
>> +    int arch_id, sock_vcpu_num, core_vcpu_num;
>> +
>> +    /*
>> +     * calculate total logical cpus across socket/core/thread.
>> +     * For more information on how to calculate the arch_id,
>> +     * you can refer to the CPU Topology chapter of the
>> +     * docs/system/loongarch/virt.rst document.
>> +     */
>> +    sock_vcpu_num = topo->socket_id * (ms->smp.threads * ms->smp.cores);
>> +    core_vcpu_num = topo->core_id * ms->smp.threads;
>> +
>> +    /* get vcpu-id(logical cpu index) for this vcpu from this topology */
>> +    arch_id = (sock_vcpu_num + core_vcpu_num) + topo->thread_id;
>> +
>> +    assert(arch_id >= 0 && arch_id < ms->possible_cpus->len);
>> +
>> +    return arch_id;
>> +}
>> +
>> +static void virt_get_topo_from_index(MachineState *ms,
>> +                                     LoongArchCPUTopo *topo, int index)
>> +{
>> +    topo->socket_id = index / (ms->smp.cores * ms->smp.threads);
>> +    topo->core_id = index / ms->smp.threads % ms->smp.cores;
>> +    topo->thread_id = index % ms->smp.threads;
>> +}
>> +
>>   static bool memhp_type_supported(DeviceState *dev)
>>   {
>>       /* we only support pc dimm now */
>> @@ -1385,8 +1431,9 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
>>   
>>   static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>>   {
>> -    int n;
>> +    int n, arch_id;
>>       unsigned int max_cpus = ms->smp.max_cpus;
>> +    LoongArchCPUTopo topo;
>>   
>>       if (ms->possible_cpus) {
>>           assert(ms->possible_cpus->len == max_cpus);
>> @@ -1397,17 +1444,17 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>>                                     sizeof(CPUArchId) * max_cpus);
>>       ms->possible_cpus->len = max_cpus;
>>       for (n = 0; n < ms->possible_cpus->len; n++) {
>> +        virt_get_topo_from_index(ms, &topo, n);
>> +        arch_id = virt_get_arch_id_from_topo(ms, &topo);
>> +        ms->possible_cpus->cpus[n].vcpus_count = 1;
>>           ms->possible_cpus->cpus[n].type = ms->cpu_type;
>> -        ms->possible_cpus->cpus[n].arch_id = n;
>> -
>> +        ms->possible_cpus->cpus[n].arch_id = arch_id;
>>           ms->possible_cpus->cpus[n].props.has_socket_id = true;
>> -        ms->possible_cpus->cpus[n].props.socket_id  =
>> -                                   n / (ms->smp.cores * ms->smp.threads);
>> +        ms->possible_cpus->cpus[n].props.socket_id = topo.socket_id;
>>           ms->possible_cpus->cpus[n].props.has_core_id = true;
>> -        ms->possible_cpus->cpus[n].props.core_id =
>> -                                   n / ms->smp.threads % ms->smp.cores;
>> +        ms->possible_cpus->cpus[n].props.core_id = topo.core_id;
>>           ms->possible_cpus->cpus[n].props.has_thread_id = true;
>> -        ms->possible_cpus->cpus[n].props.thread_id = n % ms->smp.threads;
>> +        ms->possible_cpus->cpus[n].props.thread_id = topo.thread_id;
>>       }
>>       return ms->possible_cpus;
>>   }
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index 57cc4f314b..a99e22094e 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -16,6 +16,7 @@
>>   #include "kvm/kvm_loongarch.h"
>>   #include "exec/exec-all.h"
>>   #include "cpu.h"
>> +#include "hw/qdev-properties.h"
>>   #include "internals.h"
>>   #include "fpu/softfloat-helpers.h"
>>   #include "cpu-csr.h"
>> @@ -725,6 +726,7 @@ static void loongarch_cpu_init(Object *obj)
>>       timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
>>                     &loongarch_constant_timer_cb, cpu);
>>   #endif
>> +    cpu->phy_id = UNSET_PHY_ID;
>>   #endif
>>   }
>>   
>> @@ -823,6 +825,14 @@ static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
>>   }
>>   #endif
>>   
>> +static Property loongarch_cpu_properties[] = {
>> +    DEFINE_PROP_INT32("socket-id", LoongArchCPU, socket_id, 0),
>> +    DEFINE_PROP_INT32("core-id", LoongArchCPU, core_id, 0),
>> +    DEFINE_PROP_INT32("thread-id", LoongArchCPU, thread_id, 0),
>> +    DEFINE_PROP_INT32("node-id", LoongArchCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
>> +    DEFINE_PROP_END_OF_LIST()
>> +};
>> +
>>   static void loongarch_cpu_class_init(ObjectClass *c, void *data)
>>   {
>>       LoongArchCPUClass *lacc = LOONGARCH_CPU_CLASS(c);
>> @@ -830,6 +840,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
>>       DeviceClass *dc = DEVICE_CLASS(c);
>>       ResettableClass *rc = RESETTABLE_CLASS(c);
>>   
>> +    device_class_set_props(dc, loongarch_cpu_properties);
>>       device_class_set_parent_realize(dc, loongarch_cpu_realizefn,
>>                                       &lacc->parent_realize);
>>       resettable_class_set_parent_phases(rc, NULL, loongarch_cpu_reset_hold, NULL,
>> @@ -854,6 +865,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
>>   #ifdef CONFIG_TCG
>>       cc->tcg_ops = &loongarch_tcg_ops;
>>   #endif
>> +    dc->user_creatable = true;
>>   }
>>   
>>   static const gchar *loongarch32_gdb_arch_name(CPUState *cs)
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index 86c86c6c95..7472df0521 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -19,6 +19,12 @@
>>   #include "cpu-csr.h"
>>   #include "cpu-qom.h"
>>   
>> +/*
>> + * CPU can't have 0xFFFFFFFF physical ID, use that value to distinguish
>> + * that physical ID hasn't been set yet
> 
> pointer to CPU spec/doc here would be nice to have
> 
Will add comments about CPU manual, the physical ID is 9-bit width at 
most now.

Regards
Bibo Mao
>> + */
>> +#define UNSET_PHY_ID 0xFFFFFFFF
>> +
>>   #define IOCSRF_TEMP             0
>>   #define IOCSRF_NODECNT          1
>>   #define IOCSRF_MSI              2
>> @@ -390,6 +396,12 @@ typedef struct CPUArchState {
>>   #endif
>>   } CPULoongArchState;
>>   
>> +typedef struct LoongArchCPUTopo {
>> +    int32_t socket_id;  /* socket-id of this VCPU */
>> +    int32_t core_id;    /* core-id of this VCPU */
>> +    int32_t thread_id;  /* thread-id of this VCPU */
>> +} LoongArchCPUTopo;
>> +
>>   /**
>>    * LoongArchCPU:
>>    * @env: #CPULoongArchState
>> @@ -404,6 +416,10 @@ struct ArchCPU {
>>       uint32_t  phy_id;
>>       OnOffAuto lbt;
>>       OnOffAuto pmu;
>> +    int32_t socket_id;  /* socket-id of this VCPU */
>> +    int32_t core_id;    /* core-id of this VCPU */
>> +    int32_t thread_id;  /* thread-id of this VCPU */
>> +    int32_t node_id;    /* NUMA node of this VCPU */
>>   
>>       /* 'compatible' string for this CPU for Linux device trees */
>>       const char *dtb_compatible;


