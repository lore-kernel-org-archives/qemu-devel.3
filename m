Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91353D49231
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 15:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD3Zw-000233-3v; Mon, 18 Nov 2024 10:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tD3Zt-00022v-MZ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tD3Zl-0004Hq-Qu
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731943321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebyncT2SVUycE86ryT0jihhp121bsmZ4zTn+3D1YlgY=;
 b=TWJCxSwmFkJDBgjSOMMs8m+2BEUekjfqkqar8Kom1lOutkB5bIPJSNss//7/RJiJfaSxyf
 AnDrRfB09egf9M/JSy5JTJe/NrAmm27Dqtqz5GEd/3RBpIt4oeChMpk7jZJUThtOp5U8C6
 492iglOCVFM01Jjz2/CxW+RiHOhvHGM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-Xo-eNUO6M86Ww_HvN8Remg-1; Mon, 18 Nov 2024 10:22:00 -0500
X-MC-Unique: Xo-eNUO6M86Ww_HvN8Remg-1
X-Mimecast-MFC-AGG-ID: Xo-eNUO6M86Ww_HvN8Remg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-382428c257eso714352f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 07:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731943319; x=1732548119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebyncT2SVUycE86ryT0jihhp121bsmZ4zTn+3D1YlgY=;
 b=eZcBvN9h8bg+4mAnS3Jb9u2KJiU+q+nk9v3N4R280hv//KtKokDeT91TVdWOJFkpf5
 HolpE86W8jfRnlGvQLfj742hxH4FxvQ7IGQKu1EHaSeI+5v1hJ8dPhvPT/nJR8OsU1yC
 0qjCj4wCJlRJUoml6Ghl90y8fqY995WErIYWJm6PNJflZp/ZaP+kgecIE7lwKU6aiUXz
 5eDOhKpNp+GvAvfop5mn81Xkpkj1+MCZTjBoQfSCkAdSuSlljPFn6hdbmKWQe0hTIAJm
 1RC1clTv+Bb5KzjChiQjJGT4WGQUgOAbVO3ycH8Pfw5TQm4QrLklHLqCvf9uAUWBD9sZ
 d/3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSRWXKLWuiVuMDNPq9WKML1LHMV4at+cE3cYeBbzDjavibwVvjR94ViZUeDDS5SGKnZ308vRfw7eYR@nongnu.org
X-Gm-Message-State: AOJu0YxoPXEH/mqhGul6LQHhoLUlH+zSN9TST1QF0syEYx/YCKcYK98K
 tdfWqbMgW9/o/cTbErMonR0oPSH5uZ4Zv/XihKRvdUpwmMTOJyU1Z6wqnBOGoI7ydASAm4GbnVP
 S0VufprxrfAk0foFP8S8a4B5m60s9FFHwiAGAX6JtVxBoWxs3a/Gv
X-Received: by 2002:a05:6000:400b:b0:382:450c:2607 with SMTP id
 ffacd0b85a97d-382450c29f3mr3969403f8f.4.1731943319233; 
 Mon, 18 Nov 2024 07:21:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL1nPeai3N38R3RlZo0XsBJEBk4o4MqA+52S3yasXCuWbzY8v8ogTP1689HCDBo+UGyKDwzw==
X-Received: by 2002:a05:6000:400b:b0:382:450c:2607 with SMTP id
 ffacd0b85a97d-382450c29f3mr3969388f8f.4.1731943318844; 
 Mon, 18 Nov 2024 07:21:58 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3823e0c910asm6101208f8f.39.2024.11.18.07.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 07:21:58 -0800 (PST)
Date: Mon, 18 Nov 2024 16:21:56 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: maobibo <maobibo@loongson.cn>
Cc: Zhao Liu <zhao1.liu@intel.com>, Song Gao <gaosong@loongson.cn>, Paolo
 Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 1/4] hw/loongarch/virt: Add CPU topology support
Message-ID: <20241118162156.42c07d7f@imammedo.users.ipa.redhat.com>
In-Reply-To: <bf91f8fd-3ce8-3837-436d-30fd5665f5da@loongson.cn>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-2-maobibo@loongson.cn>
 <ZyDg00Vwowxkt5LO@intel.com>
 <20241106114150.5af254a7@imammedo.users.ipa.redhat.com>
 <bf91f8fd-3ce8-3837-436d-30fd5665f5da@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 7 Nov 2024 10:13:38 +0800
maobibo <maobibo@loongson.cn> wrote:

> On 2024/11/6 =E4=B8=8B=E5=8D=886:41, Igor Mammedov wrote:
> > On Tue, 29 Oct 2024 21:19:15 +0800
> > Zhao Liu <zhao1.liu@intel.com> wrote:
> >  =20
> >> Hi Bibo,
> >>
> >> [snip]
> >> =20
> >>> +In the CPU topology relationship, When we know the ``socket_id`` ``c=
ore_id``
> >>> +and ``thread_id`` of the CPU, we can calculate its ``arch_id``:
> >>> +
> >>> +``arch_id =3D (socket_id * S) + (core_id * C) + (thread_id * T)`` =20
> >>
> >> What's the difference between arch_id and CPU index (CPUState.cpu_inde=
x)? =20
> >=20
> > They might be the same but not necessarily.
> > arch_id is unique cpu identifier from architecture point of view
> > (which easily could be sparse and without specific order).
> > (ex: for x86 it's apic_id, for spapr it's core_id)
> >=20
> > while cpu_index is internal QEMU, that existed before possible_cpus[]
> > and non-sparse range and depends on order of cpus are created.
> > For machines that support possible_cpus[], we override default
> > cpu_index assignment to fit possible_cpus[].
> >=20
> > It might be nice to get rid of cpu_index in favor of possible_cpus[],
> > but that would be a lot work probably with no huge benefit
> > when it comes majority of machines that don't need variable
> > cpu count.
> >  =20
> >>     =20
> >>>   static void virt_init(MachineState *machine)
> >>>   {
> >>> -    LoongArchCPU *lacpu;
> >>>       const char *cpu_model =3D machine->cpu_type;
> >>>       MemoryRegion *address_space_mem =3D get_system_memory();
> >>>       LoongArchVirtMachineState *lvms =3D LOONGARCH_VIRT_MACHINE(mach=
ine);
> >>> @@ -1145,7 +1144,7 @@ static void virt_init(MachineState *machine)
> >>>       hwaddr base, size, ram_size =3D machine->ram_size;
> >>>       const CPUArchIdList *possible_cpus;
> >>>       MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> >>> -    CPUState *cpu;
> >>> +    Object *cpuobj;
> >>>  =20
> >>>       if (!cpu_model) {
> >>>           cpu_model =3D LOONGARCH_CPU_TYPE_NAME("la464");
> >>> @@ -1164,12 +1163,25 @@ static void virt_init(MachineState *machine)
> >>>  =20
> >>>       /* Init CPUs */
> >>>       possible_cpus =3D mc->possible_cpu_arch_ids(machine);
> >>> -    for (i =3D 0; i < possible_cpus->len; i++) {
> >>> -        cpu =3D cpu_create(machine->cpu_type);
> >>> -        cpu->cpu_index =3D i;
> >>> -        machine->possible_cpus->cpus[i].cpu =3D cpu;
> >>> -        lacpu =3D LOONGARCH_CPU(cpu);
> >>> -        lacpu->phy_id =3D machine->possible_cpus->cpus[i].arch_id;
> >>> +    for (i =3D 0; i < machine->smp.cpus; i++) {
> >>> +        cpuobj =3D object_new(machine->cpu_type);
> >>> +        object_property_set_uint(cpuobj, "phy-id",
> >>> +                                possible_cpus->cpus[i].arch_id, NULL=
);
> >>> +        /*
> >>> +         * The CPU in place at the time of machine startup will also=
 enter
> >>> +         * the CPU hot-plug process when it is created, but at this =
time,
> >>> +         * the GED device has not been created, resulting in exit in=
 the CPU
> >>> +         * hot-plug process, which can avoid the incumbent CPU repea=
tedly
> >>> +         * applying for resources.
> >>> +         *
> >>> +         * The interrupt resource of the in-place CPU will be reques=
ted at
> >>> +         * the current function call virt_irq_init().
> >>> +         *
> >>> +         * The interrupt resource of the subsequently inserted CPU w=
ill be
> >>> +         * requested in the CPU hot-plug process.
> >>> +         */
> >>> +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> >>> +        object_unref(cpuobj); =20
> >>
> >> You can use qdev_realize_and_unref().
> >> =20
> >>>       }
> >>>       fdt_add_cpu_nodes(lvms);
> >>>       fdt_add_memory_nodes(machine);
> >>> @@ -1286,6 +1298,35 @@ static void virt_initfn(Object *obj)
> >>>       virt_flash_create(lvms);
> >>>   }
> >>>  =20
> >>> +static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPU=
Topo *topo)
> >>> +{
> >>> +    int arch_id, sock_vcpu_num, core_vcpu_num;
> >>> +
> >>> +    /*
> >>> +     * calculate total logical cpus across socket/core/thread.
> >>> +     * For more information on how to calculate the arch_id,
> >>> +     * you can refer to the CPU Topology chapter of the
> >>> +     * docs/system/loongarch/virt.rst document.
> >>> +     */
> >>> +    sock_vcpu_num =3D topo->socket_id * (ms->smp.threads * ms->smp.c=
ores);
> >>> +    core_vcpu_num =3D topo->core_id * ms->smp.threads;
> >>> +
> >>> +    /* get vcpu-id(logical cpu index) for this vcpu from this topolo=
gy */
> >>> +    arch_id =3D (sock_vcpu_num + core_vcpu_num) + topo->thread_id; =
=20
> >>
> >> Looking at the calculations, arch_id looks the same as cpu_index, righ=
t?
> >> =20
> >>> +    assert(arch_id >=3D 0 && arch_id < ms->possible_cpus->len);
> >>> +
> >>> +    return arch_id;
> >>> +}
> >>> +
> >>> +static void virt_get_topo_from_index(MachineState *ms,
> >>> +                                     LoongArchCPUTopo *topo, int ind=
ex)
> >>> +{
> >>> +    topo->socket_id =3D index / (ms->smp.cores * ms->smp.threads);
> >>> +    topo->core_id =3D index / ms->smp.threads % ms->smp.cores;
> >>> +    topo->thread_id =3D index % ms->smp.threads;
> >>> +}
> >>> +
> >>>   static bool memhp_type_supported(DeviceState *dev)
> >>>   {
> >>>       /* we only support pc dimm now */
> >>> @@ -1385,8 +1426,9 @@ static HotplugHandler *virt_get_hotplug_handler=
(MachineState *machine,
> >>>  =20
> >>>   static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState=
 *ms)
> >>>   {
> >>> -    int n;
> >>> +    int n, arch_id;
> >>>       unsigned int max_cpus =3D ms->smp.max_cpus;
> >>> +    LoongArchCPUTopo topo;
> >>>  =20
> >>>       if (ms->possible_cpus) {
> >>>           assert(ms->possible_cpus->len =3D=3D max_cpus);
> >>> @@ -1397,17 +1439,17 @@ static const CPUArchIdList *virt_possible_cpu=
_arch_ids(MachineState *ms)
> >>>                                     sizeof(CPUArchId) * max_cpus);
> >>>       ms->possible_cpus->len =3D max_cpus;
> >>>       for (n =3D 0; n < ms->possible_cpus->len; n++) {
> >>> +        virt_get_topo_from_index(ms, &topo, n);
> >>> +        arch_id =3D virt_get_arch_id_from_topo(ms, &topo);
> >>> +        ms->possible_cpus->cpus[n].vcpus_count =3D ms->smp.threads; =
=20
> >>
> >> In include/hw/boards.h, the doc of CPUArchId said:
> >>
> >> vcpus_count - number of threads provided by @cpu object
> >>
> >> And I undersatnd each element in possible_cpus->cpus[] is mapped to a
> >> CPU object, so that here vcpus_count should be 1. =20
> >=20
> > it's arch specific, CPU object in possible_cpus was meant to point to
> > thread/core/..higher layers in future../
> >=20
> > For example spapr put's there CPUCore, where vcpus_count can be > 1
> >=20
> > That is a bit broken though, since CPUCore is not CPUState by any means,
> > spapr_core_plug() gets away with it only because
> >    core_slot->cpu =3D CPU(dev)
> > CPU() is dumb pointer cast.
> >=20
> > Ideally CPUArchId::cpu should be (Object*) to accommodate various
> > levels of granularity correctly (with dumb cast above it's just
> > cosmetics though as long as we treat it as Object in non arch
> > specific code).
> >  =20
> >>>           ms->possible_cpus->cpus[n].type =3D ms->cpu_type;
> >>> -        ms->possible_cpus->cpus[n].arch_id =3D n;
> >>> -
> >>> +        ms->possible_cpus->cpus[n].arch_id =3D arch_id;
> >>>           ms->possible_cpus->cpus[n].props.has_socket_id =3D true;
> >>> -        ms->possible_cpus->cpus[n].props.socket_id  =3D
> >>> -                                   n / (ms->smp.cores * ms->smp.thre=
ads);
> >>> +        ms->possible_cpus->cpus[n].props.socket_id =3D topo.socket_i=
d;
> >>>           ms->possible_cpus->cpus[n].props.has_core_id =3D true;
> >>> -        ms->possible_cpus->cpus[n].props.core_id =3D
> >>> -                                   n / ms->smp.threads % ms->smp.cor=
es;
> >>> +        ms->possible_cpus->cpus[n].props.core_id =3D topo.core_id;
> >>>           ms->possible_cpus->cpus[n].props.has_thread_id =3D true;
> >>> -        ms->possible_cpus->cpus[n].props.thread_id =3D n % ms->smp.t=
hreads;
> >>> +        ms->possible_cpus->cpus[n].props.thread_id =3D topo.thread_i=
d;
> >>>       }
> >>>       return ms->possible_cpus;
> >>>   }
> >>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> >>> index 7212fb5f8f..5dfc0d5c43 100644
> >>> --- a/target/loongarch/cpu.c
> >>> +++ b/target/loongarch/cpu.c
> >>> @@ -16,6 +16,7 @@
> >>>   #include "kvm/kvm_loongarch.h"
> >>>   #include "exec/exec-all.h"
> >>>   #include "cpu.h"
> >>> +#include "hw/qdev-properties.h"
> >>>   #include "internals.h"
> >>>   #include "fpu/softfloat-helpers.h"
> >>>   #include "cpu-csr.h"
> >>> @@ -780,6 +781,15 @@ static int64_t loongarch_cpu_get_arch_id(CPUStat=
e *cs)
> >>>   }
> >>>   #endif
> >>>  =20
> >>> +static Property loongarch_cpu_properties[] =3D {
> >>> +    DEFINE_PROP_UINT32("phy-id", LoongArchCPU, phy_id, UNSET_PHY_ID)=
, =20
> >>
> >> IIUC, the phy_id is kind of like the x86 apic_id, but the field is com=
pletely
> >> derived from topology, so why do you need to define it as a property a=
nd then
> >> expose it to the user? =20
> >=20
> > for x86 we do expose apic_id as a property as well, partly from histori=
cal pov
> > but also it's better to access cpu fields via properties from outside of
> > CPU object than directly poke inside of CPU structure from outside of C=
PU
> > (especially if it comes to generic code) =20
> yes, accessing fields via properties is better than directly poking=20
> internal structure elements. Is there internal property for cpu object?=20
> so that internal property is invisible for users.

not that I'm aware of. usually we add prefix 'x-' to a property that is
'experimental/not stable/shouldn't be used by endusers'=20

extending properties API to mark/create internal properties,
would be nice to have but I won't ask you to do that as it's very
much off topic.

> There will be problem if user adds CPU object with apic-id property, for=
=20
> example:

apic-id is there for historical reasons. that's why x86 has a bunch of chec=
ks
to make sure input is correct.

> qemu-system-x86_64 -display none -no-user-config -m 2048 -nodefaults=20
> -monitor stdio -machine pc,accel=3Dkvm,usb=3Doff -smp 1,maxcpus=3D2 -cpu=
=20
> IvyBridge-IBRS -qmp unix:/tmp/qmp-sock,server=3Don,wait=3Doff
>=20
> (qemu) device_add=20
> id=3Dcpu-2,driver=3DIvyBridge-IBRS-x86_64-cpu,socket-id=3D0,core-id=3D1,t=
hread-id=3D0,apic-id=3D100
> Error: Invalid CPU [socket: 50, die: 0, module: 0, core: 0, thread: 0]=20
> with APIC ID 100, valid index range 0:1
>=20
> (qemu) device_add=20
> id=3Dcpu-2,driver=3DIvyBridge-IBRS-x86_64-cpu,socket-id=3D0,core-id=3D1,t=
hread-id=3D0,apic-id=3D0
> Error: CPU[0] with APIC ID 0 exists
>=20
>=20
> Regards
> Bibo Mao
> >  =20
> >>
> >> Thanks,
> >> Zhao
> >>
> >> =20
>=20


