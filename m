Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED63D2AB3B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 13:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5lsu-0004LW-BY; Tue, 29 Oct 2024 09:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5lsg-0004KW-Pk
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:03:32 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5lsd-0004ll-An
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730207008; x=1761743008;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FE1JuJCMbh5+YXP9J+d3LFHDorj8j3oNnybXKf0Ius8=;
 b=fdpikhgcJ1sYhEtds1Wnr9mL8UyAwSoDivL/bBse71MZQmWWIm/0M5s3
 ubbbcwS+6GAY9ij0xGKpB9e02LsA8XMxwjaA+p7iuHFWitkol5BbtFxiB
 5W8p9Qwn0bkYS+95xApZvlXy/Nq7mA0X1vcwpEflqp89GvSo79L7imXU4
 CXsLdrKfN4+hqWh8Lijn4rSU9U1pMVWAZPBMNy3papp51sgXbj28n39S4
 74dp1GMj62rxHp2PBn4ibqC3SNY1pnoLVFYXiQP7W0kPr5dkh1UY5Qxg+
 qOsxrhxXVJaaSsM7trueYZFKk7qqlYEmRdQbLcKv/JH39Ce0qmFnbuGyt g==;
X-CSE-ConnectionGUID: fd3DeljYQNGuAYAS7eL+IQ==
X-CSE-MsgGUID: 2PCQMbeER469FT9d1QfQ1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29964633"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="29964633"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 06:02:58 -0700
X-CSE-ConnectionGUID: Yl7qDagrSI6aDp0tf/8yew==
X-CSE-MsgGUID: xFGndxUwSyivQS9BoE7kbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="81862523"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 29 Oct 2024 06:02:54 -0700
Date: Tue, 29 Oct 2024 21:19:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 1/4] hw/loongarch/virt: Add CPU topology support
Message-ID: <ZyDg00Vwowxkt5LO@intel.com>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-2-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029095335.2219343-2-maobibo@loongson.cn>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Bibo,

[snip]

> +In the CPU topology relationship, When we know the ``socket_id`` ``core_id``
> +and ``thread_id`` of the CPU, we can calculate its ``arch_id``:
> +
> +``arch_id = (socket_id * S) + (core_id * C) + (thread_id * T)``

What's the difference between arch_id and CPU index (CPUState.cpu_index)?
  
>  static void virt_init(MachineState *machine)
>  {
> -    LoongArchCPU *lacpu;
>      const char *cpu_model = machine->cpu_type;
>      MemoryRegion *address_space_mem = get_system_memory();
>      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
> @@ -1145,7 +1144,7 @@ static void virt_init(MachineState *machine)
>      hwaddr base, size, ram_size = machine->ram_size;
>      const CPUArchIdList *possible_cpus;
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
> -    CPUState *cpu;
> +    Object *cpuobj;
>  
>      if (!cpu_model) {
>          cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
> @@ -1164,12 +1163,25 @@ static void virt_init(MachineState *machine)
>  
>      /* Init CPUs */
>      possible_cpus = mc->possible_cpu_arch_ids(machine);
> -    for (i = 0; i < possible_cpus->len; i++) {
> -        cpu = cpu_create(machine->cpu_type);
> -        cpu->cpu_index = i;
> -        machine->possible_cpus->cpus[i].cpu = cpu;
> -        lacpu = LOONGARCH_CPU(cpu);
> -        lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
> +    for (i = 0; i < machine->smp.cpus; i++) {
> +        cpuobj = object_new(machine->cpu_type);
> +        object_property_set_uint(cpuobj, "phy-id",
> +                                possible_cpus->cpus[i].arch_id, NULL);
> +        /*
> +         * The CPU in place at the time of machine startup will also enter
> +         * the CPU hot-plug process when it is created, but at this time,
> +         * the GED device has not been created, resulting in exit in the CPU
> +         * hot-plug process, which can avoid the incumbent CPU repeatedly
> +         * applying for resources.
> +         *
> +         * The interrupt resource of the in-place CPU will be requested at
> +         * the current function call virt_irq_init().
> +         *
> +         * The interrupt resource of the subsequently inserted CPU will be
> +         * requested in the CPU hot-plug process.
> +         */
> +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> +        object_unref(cpuobj);

You can use qdev_realize_and_unref().

>      }
>      fdt_add_cpu_nodes(lvms);
>      fdt_add_memory_nodes(machine);
> @@ -1286,6 +1298,35 @@ static void virt_initfn(Object *obj)
>      virt_flash_create(lvms);
>  }
>  
> +static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPUTopo *topo)
> +{
> +    int arch_id, sock_vcpu_num, core_vcpu_num;
> +
> +    /*
> +     * calculate total logical cpus across socket/core/thread.
> +     * For more information on how to calculate the arch_id,
> +     * you can refer to the CPU Topology chapter of the
> +     * docs/system/loongarch/virt.rst document.
> +     */
> +    sock_vcpu_num = topo->socket_id * (ms->smp.threads * ms->smp.cores);
> +    core_vcpu_num = topo->core_id * ms->smp.threads;
> +
> +    /* get vcpu-id(logical cpu index) for this vcpu from this topology */
> +    arch_id = (sock_vcpu_num + core_vcpu_num) + topo->thread_id;

Looking at the calculations, arch_id looks the same as cpu_index, right?

> +    assert(arch_id >= 0 && arch_id < ms->possible_cpus->len);
> +
> +    return arch_id;
> +}
> +
> +static void virt_get_topo_from_index(MachineState *ms,
> +                                     LoongArchCPUTopo *topo, int index)
> +{
> +    topo->socket_id = index / (ms->smp.cores * ms->smp.threads);
> +    topo->core_id = index / ms->smp.threads % ms->smp.cores;
> +    topo->thread_id = index % ms->smp.threads;
> +}
> +
>  static bool memhp_type_supported(DeviceState *dev)
>  {
>      /* we only support pc dimm now */
> @@ -1385,8 +1426,9 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
>  
>  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>  {
> -    int n;
> +    int n, arch_id;
>      unsigned int max_cpus = ms->smp.max_cpus;
> +    LoongArchCPUTopo topo;
>  
>      if (ms->possible_cpus) {
>          assert(ms->possible_cpus->len == max_cpus);
> @@ -1397,17 +1439,17 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>                                    sizeof(CPUArchId) * max_cpus);
>      ms->possible_cpus->len = max_cpus;
>      for (n = 0; n < ms->possible_cpus->len; n++) {
> +        virt_get_topo_from_index(ms, &topo, n);
> +        arch_id = virt_get_arch_id_from_topo(ms, &topo);
> +        ms->possible_cpus->cpus[n].vcpus_count = ms->smp.threads;

In include/hw/boards.h, the doc of CPUArchId said:

vcpus_count - number of threads provided by @cpu object

And I undersatnd each element in possible_cpus->cpus[] is mapped to a
CPU object, so that here vcpus_count should be 1.


>          ms->possible_cpus->cpus[n].type = ms->cpu_type;
> -        ms->possible_cpus->cpus[n].arch_id = n;
> -
> +        ms->possible_cpus->cpus[n].arch_id = arch_id;
>          ms->possible_cpus->cpus[n].props.has_socket_id = true;
> -        ms->possible_cpus->cpus[n].props.socket_id  =
> -                                   n / (ms->smp.cores * ms->smp.threads);
> +        ms->possible_cpus->cpus[n].props.socket_id = topo.socket_id;
>          ms->possible_cpus->cpus[n].props.has_core_id = true;
> -        ms->possible_cpus->cpus[n].props.core_id =
> -                                   n / ms->smp.threads % ms->smp.cores;
> +        ms->possible_cpus->cpus[n].props.core_id = topo.core_id;
>          ms->possible_cpus->cpus[n].props.has_thread_id = true;
> -        ms->possible_cpus->cpus[n].props.thread_id = n % ms->smp.threads;
> +        ms->possible_cpus->cpus[n].props.thread_id = topo.thread_id;
>      }
>      return ms->possible_cpus;
>  }
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 7212fb5f8f..5dfc0d5c43 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -16,6 +16,7 @@
>  #include "kvm/kvm_loongarch.h"
>  #include "exec/exec-all.h"
>  #include "cpu.h"
> +#include "hw/qdev-properties.h"
>  #include "internals.h"
>  #include "fpu/softfloat-helpers.h"
>  #include "cpu-csr.h"
> @@ -780,6 +781,15 @@ static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
>  }
>  #endif
>  
> +static Property loongarch_cpu_properties[] = {
> +    DEFINE_PROP_UINT32("phy-id", LoongArchCPU, phy_id, UNSET_PHY_ID),

IIUC, the phy_id is kind of like the x86 apic_id, but the field is completely
derived from topology, so why do you need to define it as a property and then
expose it to the user?

Thanks,
Zhao


