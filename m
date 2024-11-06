Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FABDD44D49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dUD-0003nz-BL; Wed, 06 Nov 2024 05:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8dU7-0003mG-Pz
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:41:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8dU5-0005SH-2m
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730889715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8RvQlp+LW/HMMJA3MB3DKziw5aA556H38AmXBVfawg=;
 b=jRnjduh385bzUIQGU5EKjwX168phmcEnXvpZnrMtcLcBjpPLVSvVdy0+Ta0Q136spnHoOr
 DMj6f14f4PGppiT9luYdiFvM6kJnSNXtefZSV4BC/rqa1qPJzD2nQ9RTDU0+X9eFHCa1WF
 wDb4Nb/UFB+eSvW29osHoABWo7IB1HQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-_lGvLg5qNImc23CLDVsUpQ-1; Wed, 06 Nov 2024 05:41:54 -0500
X-MC-Unique: _lGvLg5qNImc23CLDVsUpQ-1
X-Mimecast-MFC-AGG-ID: _lGvLg5qNImc23CLDVsUpQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431604a3b47so41259255e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 02:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730889713; x=1731494513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8RvQlp+LW/HMMJA3MB3DKziw5aA556H38AmXBVfawg=;
 b=dYA8+bsPk6gb1h3gyqgrcTimTN2wKneWMpc8nGXaS1iOmyiJfH/XiRyazpSHiA/7uK
 W7s6IgnaDeZ2To7yudQ33OVzmLPhVh8oo6wEk5e8zPMj6GPb6QRbSNskvgU99QK3Cibf
 pHuuPlf1+KzN080bGxhirPiJYDiUjJhetrOpr1637c7iPTuO2WJk/8jJ0APpMl0anSLP
 LDUNbfY05KnikL69bxP+HkRVpX+PIZT4wongPikc2Y3QqS1Q22w+B4F0fTkpxw2aX1Tu
 KI0/078LNTosWXpAtN3uZV9HAw8vq9/xpIXpDuO+mD0qhyu0MNqEoM7d2vImqPHnwR3f
 VgAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqwCKwpj0Vf0vEUev6UC/lRt5gBAt4HaNMcQJnRY8azvV0gwTziyopdsgq6DpcrdZTUQQFyGz0mmns@nongnu.org
X-Gm-Message-State: AOJu0YxOHFcAVbZd/L5zh5KBYcyt4FUXHQCFmeWUFYoI6fm7h6PldkF8
 lfhQsC2ogQWqOeEkQsRtIKdntICWracfH5pIaraiyRao28nSI0XNcexa3VeXwL3OdH3gsibW97c
 TzB+jAKHKk862gDWdS6bLTJqurjQFNDyj1qHxw6EQJWysPrE088UC
X-Received: by 2002:a05:600c:19c8:b0:430:54a4:5b03 with SMTP id
 5b1f17b1804b1-4319ac6fad6mr316758705e9.6.1730889712889; 
 Wed, 06 Nov 2024 02:41:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnPDhhkc55p/MP9jT58GU3JHgua2H3uAoIUMDQd9w4BxRQQUSlT0JeyiEbQx7yqW7W3iRQMA==
X-Received: by 2002:a05:600c:19c8:b0:430:54a4:5b03 with SMTP id
 5b1f17b1804b1-4319ac6fad6mr316758475e9.6.1730889712455; 
 Wed, 06 Nov 2024 02:41:52 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6e6fbcsm17264735e9.34.2024.11.06.02.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 02:41:51 -0800 (PST)
Date: Wed, 6 Nov 2024 11:41:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>, Paolo
 Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 1/4] hw/loongarch/virt: Add CPU topology support
Message-ID: <20241106114150.5af254a7@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZyDg00Vwowxkt5LO@intel.com>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-2-maobibo@loongson.cn>
 <ZyDg00Vwowxkt5LO@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, 29 Oct 2024 21:19:15 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Hi Bibo,
> 
> [snip]
> 
> > +In the CPU topology relationship, When we know the ``socket_id`` ``core_id``
> > +and ``thread_id`` of the CPU, we can calculate its ``arch_id``:
> > +
> > +``arch_id = (socket_id * S) + (core_id * C) + (thread_id * T)``  
> 
> What's the difference between arch_id and CPU index (CPUState.cpu_index)?

They might be the same but not necessarily.
arch_id is unique cpu identifier from architecture point of view
(which easily could be sparse and without specific order).
(ex: for x86 it's apic_id, for spapr it's core_id)

while cpu_index is internal QEMU, that existed before possible_cpus[]
and non-sparse range and depends on order of cpus are created.
For machines that support possible_cpus[], we override default
cpu_index assignment to fit possible_cpus[].

It might be nice to get rid of cpu_index in favor of possible_cpus[],
but that would be a lot work probably with no huge benefit
when it comes majority of machines that don't need variable
cpu count. 

>   
> >  static void virt_init(MachineState *machine)
> >  {
> > -    LoongArchCPU *lacpu;
> >      const char *cpu_model = machine->cpu_type;
> >      MemoryRegion *address_space_mem = get_system_memory();
> >      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
> > @@ -1145,7 +1144,7 @@ static void virt_init(MachineState *machine)
> >      hwaddr base, size, ram_size = machine->ram_size;
> >      const CPUArchIdList *possible_cpus;
> >      MachineClass *mc = MACHINE_GET_CLASS(machine);
> > -    CPUState *cpu;
> > +    Object *cpuobj;
> >  
> >      if (!cpu_model) {
> >          cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
> > @@ -1164,12 +1163,25 @@ static void virt_init(MachineState *machine)
> >  
> >      /* Init CPUs */
> >      possible_cpus = mc->possible_cpu_arch_ids(machine);
> > -    for (i = 0; i < possible_cpus->len; i++) {
> > -        cpu = cpu_create(machine->cpu_type);
> > -        cpu->cpu_index = i;
> > -        machine->possible_cpus->cpus[i].cpu = cpu;
> > -        lacpu = LOONGARCH_CPU(cpu);
> > -        lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
> > +    for (i = 0; i < machine->smp.cpus; i++) {
> > +        cpuobj = object_new(machine->cpu_type);
> > +        object_property_set_uint(cpuobj, "phy-id",
> > +                                possible_cpus->cpus[i].arch_id, NULL);
> > +        /*
> > +         * The CPU in place at the time of machine startup will also enter
> > +         * the CPU hot-plug process when it is created, but at this time,
> > +         * the GED device has not been created, resulting in exit in the CPU
> > +         * hot-plug process, which can avoid the incumbent CPU repeatedly
> > +         * applying for resources.
> > +         *
> > +         * The interrupt resource of the in-place CPU will be requested at
> > +         * the current function call virt_irq_init().
> > +         *
> > +         * The interrupt resource of the subsequently inserted CPU will be
> > +         * requested in the CPU hot-plug process.
> > +         */
> > +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> > +        object_unref(cpuobj);  
> 
> You can use qdev_realize_and_unref().
> 
> >      }
> >      fdt_add_cpu_nodes(lvms);
> >      fdt_add_memory_nodes(machine);
> > @@ -1286,6 +1298,35 @@ static void virt_initfn(Object *obj)
> >      virt_flash_create(lvms);
> >  }
> >  
> > +static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPUTopo *topo)
> > +{
> > +    int arch_id, sock_vcpu_num, core_vcpu_num;
> > +
> > +    /*
> > +     * calculate total logical cpus across socket/core/thread.
> > +     * For more information on how to calculate the arch_id,
> > +     * you can refer to the CPU Topology chapter of the
> > +     * docs/system/loongarch/virt.rst document.
> > +     */
> > +    sock_vcpu_num = topo->socket_id * (ms->smp.threads * ms->smp.cores);
> > +    core_vcpu_num = topo->core_id * ms->smp.threads;
> > +
> > +    /* get vcpu-id(logical cpu index) for this vcpu from this topology */
> > +    arch_id = (sock_vcpu_num + core_vcpu_num) + topo->thread_id;  
> 
> Looking at the calculations, arch_id looks the same as cpu_index, right?
> 
> > +    assert(arch_id >= 0 && arch_id < ms->possible_cpus->len);
> > +
> > +    return arch_id;
> > +}
> > +
> > +static void virt_get_topo_from_index(MachineState *ms,
> > +                                     LoongArchCPUTopo *topo, int index)
> > +{
> > +    topo->socket_id = index / (ms->smp.cores * ms->smp.threads);
> > +    topo->core_id = index / ms->smp.threads % ms->smp.cores;
> > +    topo->thread_id = index % ms->smp.threads;
> > +}
> > +
> >  static bool memhp_type_supported(DeviceState *dev)
> >  {
> >      /* we only support pc dimm now */
> > @@ -1385,8 +1426,9 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
> >  
> >  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
> >  {
> > -    int n;
> > +    int n, arch_id;
> >      unsigned int max_cpus = ms->smp.max_cpus;
> > +    LoongArchCPUTopo topo;
> >  
> >      if (ms->possible_cpus) {
> >          assert(ms->possible_cpus->len == max_cpus);
> > @@ -1397,17 +1439,17 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
> >                                    sizeof(CPUArchId) * max_cpus);
> >      ms->possible_cpus->len = max_cpus;
> >      for (n = 0; n < ms->possible_cpus->len; n++) {
> > +        virt_get_topo_from_index(ms, &topo, n);
> > +        arch_id = virt_get_arch_id_from_topo(ms, &topo);
> > +        ms->possible_cpus->cpus[n].vcpus_count = ms->smp.threads;  
> 
> In include/hw/boards.h, the doc of CPUArchId said:
> 
> vcpus_count - number of threads provided by @cpu object
> 
> And I undersatnd each element in possible_cpus->cpus[] is mapped to a
> CPU object, so that here vcpus_count should be 1.

it's arch specific, CPU object in possible_cpus was meant to point to
thread/core/..higher layers in future../

For example spapr put's there CPUCore, where vcpus_count can be > 1

That is a bit broken though, since CPUCore is not CPUState by any means,
spapr_core_plug() gets away with it only because
  core_slot->cpu = CPU(dev)
CPU() is dumb pointer cast.

Ideally CPUArchId::cpu should be (Object*) to accommodate various
levels of granularity correctly (with dumb cast above it's just
cosmetics though as long as we treat it as Object in non arch
specific code).

> >          ms->possible_cpus->cpus[n].type = ms->cpu_type;
> > -        ms->possible_cpus->cpus[n].arch_id = n;
> > -
> > +        ms->possible_cpus->cpus[n].arch_id = arch_id;
> >          ms->possible_cpus->cpus[n].props.has_socket_id = true;
> > -        ms->possible_cpus->cpus[n].props.socket_id  =
> > -                                   n / (ms->smp.cores * ms->smp.threads);
> > +        ms->possible_cpus->cpus[n].props.socket_id = topo.socket_id;
> >          ms->possible_cpus->cpus[n].props.has_core_id = true;
> > -        ms->possible_cpus->cpus[n].props.core_id =
> > -                                   n / ms->smp.threads % ms->smp.cores;
> > +        ms->possible_cpus->cpus[n].props.core_id = topo.core_id;
> >          ms->possible_cpus->cpus[n].props.has_thread_id = true;
> > -        ms->possible_cpus->cpus[n].props.thread_id = n % ms->smp.threads;
> > +        ms->possible_cpus->cpus[n].props.thread_id = topo.thread_id;
> >      }
> >      return ms->possible_cpus;
> >  }
> > diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> > index 7212fb5f8f..5dfc0d5c43 100644
> > --- a/target/loongarch/cpu.c
> > +++ b/target/loongarch/cpu.c
> > @@ -16,6 +16,7 @@
> >  #include "kvm/kvm_loongarch.h"
> >  #include "exec/exec-all.h"
> >  #include "cpu.h"
> > +#include "hw/qdev-properties.h"
> >  #include "internals.h"
> >  #include "fpu/softfloat-helpers.h"
> >  #include "cpu-csr.h"
> > @@ -780,6 +781,15 @@ static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
> >  }
> >  #endif
> >  
> > +static Property loongarch_cpu_properties[] = {
> > +    DEFINE_PROP_UINT32("phy-id", LoongArchCPU, phy_id, UNSET_PHY_ID),  
> 
> IIUC, the phy_id is kind of like the x86 apic_id, but the field is completely
> derived from topology, so why do you need to define it as a property and then
> expose it to the user?

for x86 we do expose apic_id as a property as well, partly from historical pov
but also it's better to access cpu fields via properties from outside of
CPU object than directly poke inside of CPU structure from outside of CPU
(especially if it comes to generic code)

> 
> Thanks,
> Zhao
> 
> 


