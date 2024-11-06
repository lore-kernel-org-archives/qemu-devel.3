Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E514BD44D46
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dVA-0004yU-Hj; Wed, 06 Nov 2024 05:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8dV9-0004yB-2Y
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:43:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8dV7-0005Vb-4u
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730889780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dy0+x8SaLQwQl3pnq1BVELOQ1lOgvB4myLqJ0fCuc9Y=;
 b=bSem008Au3tZ6NGIA9RRmk51QCD0mXnyXByPIIMx4KCDuA67iSF/7JEtG3yAM5RjBqXCLB
 1V+bqN7EGKZU5YvDQt6xaU1QbyzAUO6DXbtRq31Dn2uK/d9afb+yRJSiOp3fBtuQgXGSIY
 iFyktC7Hc4yfhQt8rL3PIZRdXtsR7Cg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-dx9yqEGPN9qz6_fWlPSqKQ-1; Wed, 06 Nov 2024 05:42:58 -0500
X-MC-Unique: dx9yqEGPN9qz6_fWlPSqKQ-1
X-Mimecast-MFC-AGG-ID: dx9yqEGPN9qz6_fWlPSqKQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-431518ae047so3946705e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 02:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730889777; x=1731494577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dy0+x8SaLQwQl3pnq1BVELOQ1lOgvB4myLqJ0fCuc9Y=;
 b=YrvXSRZWOn2y3p+6ioGngFQfqNlexKm+Y2kwSusETfW52hM+Ge/xsZErDTEunI+ESj
 nSa1yccLwpvzjZ9k0cGloD+pGaRzxZOWCbQnLv0yRaiAYMrDwQzvHbAj65BSjjKx8shW
 Dq9sts0bjpeXLNCIZFXPT2lpIPuM9ohlB6KhjGx5UUgn8e12Fg5cr6zDkm7dKIVpC311
 Eh2lIeT/fWxoRP+zSIP17EuSfEJPRpqx36tWpJERRm3kH3VbkHgQjZPvPQYNvvA5zHTY
 v61zLr4FLyhctrQq1rhxdI+Cv1L4oR18Cr8NZeii4/53fRVIqaLfZPi467pOpOnmlmW5
 MhLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3POu5qIlC4DqJ9BE0WR9ec2rG06Ov25euoQWm7sMm04GISICEbu40XvXK/Os09jdf+iIbuLUr+0Eu@nongnu.org
X-Gm-Message-State: AOJu0YzdA+jYZ+y3BNN8thH/XNRDuYD1VCO5i7OzgwQ/NeGThaFsIyFS
 DVFb55X9tDiQNkw/nXprdtKKPtPh6MN22Q7Z03vshXQa+cpM3SumaF4xNW0c/972Wxwe3q50A4H
 muxBqaNn4zL/cPIs6gpymqsmA7XgYGeVkFVMXkNmUdmE/DPQILwVl
X-Received: by 2002:a05:600c:1d0a:b0:431:559d:4103 with SMTP id
 5b1f17b1804b1-432a9aa0aeemr17246415e9.7.1730889777148; 
 Wed, 06 Nov 2024 02:42:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUcruoSJ7XzBAowjks+TWM9E40dlhkYOWFJplfyRzrJ7G1kSipL+WZ3j6IQgbvtbRfSeX7dQ==
X-Received: by 2002:a05:600c:1d0a:b0:431:559d:4103 with SMTP id
 5b1f17b1804b1-432a9aa0aeemr17246165e9.7.1730889776764; 
 Wed, 06 Nov 2024 02:42:56 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm18554735e9.8.2024.11.06.02.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 02:42:56 -0800 (PST)
Date: Wed, 6 Nov 2024 11:42:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: maobibo <maobibo@loongson.cn>
Cc: Zhao Liu <zhao1.liu@intel.com>, Song Gao <gaosong@loongson.cn>, Paolo
 Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 1/4] hw/loongarch/virt: Add CPU topology support
Message-ID: <20241106114255.14e5ecd7@imammedo.users.ipa.redhat.com>
In-Reply-To: <632065ad-e5e1-94f7-0d79-189d64bcc43c@loongson.cn>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-2-maobibo@loongson.cn>
 <ZyDg00Vwowxkt5LO@intel.com>
 <632065ad-e5e1-94f7-0d79-189d64bcc43c@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 30 Oct 2024 09:42:10 +0800
maobibo <maobibo@loongson.cn> wrote:

> Hi Zhao,
>=20
> Thanks for reviewing the patch.
>=20
> On 2024/10/29 =E4=B8=8B=E5=8D=889:19, Zhao Liu wrote:
> > Hi Bibo,
> >=20
> > [snip]
> >  =20
> >> +In the CPU topology relationship, When we know the ``socket_id`` ``co=
re_id``
> >> +and ``thread_id`` of the CPU, we can calculate its ``arch_id``:
> >> +
> >> +``arch_id =3D (socket_id * S) + (core_id * C) + (thread_id * T)`` =20
> >=20
> > What's the difference between arch_id and CPU index (CPUState.cpu_index=
)?
> >     =20
> >>   static void virt_init(MachineState *machine)
> >>   {
> >> -    LoongArchCPU *lacpu;
> >>       const char *cpu_model =3D machine->cpu_type;
> >>       MemoryRegion *address_space_mem =3D get_system_memory();
> >>       LoongArchVirtMachineState *lvms =3D LOONGARCH_VIRT_MACHINE(machi=
ne);
> >> @@ -1145,7 +1144,7 @@ static void virt_init(MachineState *machine)
> >>       hwaddr base, size, ram_size =3D machine->ram_size;
> >>       const CPUArchIdList *possible_cpus;
> >>       MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> >> -    CPUState *cpu;
> >> +    Object *cpuobj;
> >>  =20
> >>       if (!cpu_model) {
> >>           cpu_model =3D LOONGARCH_CPU_TYPE_NAME("la464");
> >> @@ -1164,12 +1163,25 @@ static void virt_init(MachineState *machine)
> >>  =20
> >>       /* Init CPUs */
> >>       possible_cpus =3D mc->possible_cpu_arch_ids(machine);
> >> -    for (i =3D 0; i < possible_cpus->len; i++) {
> >> -        cpu =3D cpu_create(machine->cpu_type);
> >> -        cpu->cpu_index =3D i;
> >> -        machine->possible_cpus->cpus[i].cpu =3D cpu;
> >> -        lacpu =3D LOONGARCH_CPU(cpu);
> >> -        lacpu->phy_id =3D machine->possible_cpus->cpus[i].arch_id;
> >> +    for (i =3D 0; i < machine->smp.cpus; i++) {
> >> +        cpuobj =3D object_new(machine->cpu_type);
> >> +        object_property_set_uint(cpuobj, "phy-id",
> >> +                                possible_cpus->cpus[i].arch_id, NULL);
> >> +        /*
> >> +         * The CPU in place at the time of machine startup will also =
enter
> >> +         * the CPU hot-plug process when it is created, but at this t=
ime,
> >> +         * the GED device has not been created, resulting in exit in =
the CPU
> >> +         * hot-plug process, which can avoid the incumbent CPU repeat=
edly
> >> +         * applying for resources.
> >> +         *
> >> +         * The interrupt resource of the in-place CPU will be request=
ed at
> >> +         * the current function call virt_irq_init().
> >> +         *
> >> +         * The interrupt resource of the subsequently inserted CPU wi=
ll be
> >> +         * requested in the CPU hot-plug process.
> >> +         */
> >> +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> >> +        object_unref(cpuobj); =20
> >=20
> > You can use qdev_realize_and_unref(). =20
> sure, will do.
>=20
> >  =20
> >>       }
> >>       fdt_add_cpu_nodes(lvms);
> >>       fdt_add_memory_nodes(machine);
> >> @@ -1286,6 +1298,35 @@ static void virt_initfn(Object *obj)
> >>       virt_flash_create(lvms);
> >>   }
> >>  =20
> >> +static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPUT=
opo *topo)
> >> +{
> >> +    int arch_id, sock_vcpu_num, core_vcpu_num;
> >> +
> >> +    /*
> >> +     * calculate total logical cpus across socket/core/thread.
> >> +     * For more information on how to calculate the arch_id,
> >> +     * you can refer to the CPU Topology chapter of the
> >> +     * docs/system/loongarch/virt.rst document.
> >> +     */
> >> +    sock_vcpu_num =3D topo->socket_id * (ms->smp.threads * ms->smp.co=
res);
> >> +    core_vcpu_num =3D topo->core_id * ms->smp.threads;
> >> +
> >> +    /* get vcpu-id(logical cpu index) for this vcpu from this topolog=
y */
> >> +    arch_id =3D (sock_vcpu_num + core_vcpu_num) + topo->thread_id; =20
> >=20
> > Looking at the calculations, arch_id looks the same as cpu_index, right=
? =20
> The value of arch_id and cpu_index is the same now, however meaning is=20
> different. cpu_index is cpuslot index of possible_cpus array, arch_id is=
=20
> physical id.
>=20
> Now there is no special HW calculation for physical id, value of them is=
=20
> the same. In future if physical id width exceeds 8-bit because extioi=20
> only support max 256 cpu routing, its calculation method will change.
> >  =20
> >> +    assert(arch_id >=3D 0 && arch_id < ms->possible_cpus->len);
> >> +
> >> +    return arch_id;
> >> +}
> >> +
> >> +static void virt_get_topo_from_index(MachineState *ms,
> >> +                                     LoongArchCPUTopo *topo, int inde=
x)
> >> +{
> >> +    topo->socket_id =3D index / (ms->smp.cores * ms->smp.threads);
> >> +    topo->core_id =3D index / ms->smp.threads % ms->smp.cores;
> >> +    topo->thread_id =3D index % ms->smp.threads;
> >> +}
> >> +
> >>   static bool memhp_type_supported(DeviceState *dev)
> >>   {
> >>       /* we only support pc dimm now */
> >> @@ -1385,8 +1426,9 @@ static HotplugHandler *virt_get_hotplug_handler(=
MachineState *machine,
> >>  =20
> >>   static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState =
*ms)
> >>   {
> >> -    int n;
> >> +    int n, arch_id;
> >>       unsigned int max_cpus =3D ms->smp.max_cpus;
> >> +    LoongArchCPUTopo topo;
> >>  =20
> >>       if (ms->possible_cpus) {
> >>           assert(ms->possible_cpus->len =3D=3D max_cpus);
> >> @@ -1397,17 +1439,17 @@ static const CPUArchIdList *virt_possible_cpu_=
arch_ids(MachineState *ms)
> >>                                     sizeof(CPUArchId) * max_cpus);
> >>       ms->possible_cpus->len =3D max_cpus;
> >>       for (n =3D 0; n < ms->possible_cpus->len; n++) {
> >> +        virt_get_topo_from_index(ms, &topo, n);
> >> +        arch_id =3D virt_get_arch_id_from_topo(ms, &topo);
> >> +        ms->possible_cpus->cpus[n].vcpus_count =3D ms->smp.threads; =
=20
> >=20
> > In include/hw/boards.h, the doc of CPUArchId said:
> >=20
> > vcpus_count - number of threads provided by @cpu object
> >=20
> > And I undersatnd each element in possible_cpus->cpus[] is mapped to a
> > CPU object, so that here vcpus_count should be 1. =20
> yes, it is should be 1, thank for pointing it out
> >=20
> >  =20
> >>           ms->possible_cpus->cpus[n].type =3D ms->cpu_type;
> >> -        ms->possible_cpus->cpus[n].arch_id =3D n;
> >> -
> >> +        ms->possible_cpus->cpus[n].arch_id =3D arch_id;
> >>           ms->possible_cpus->cpus[n].props.has_socket_id =3D true;
> >> -        ms->possible_cpus->cpus[n].props.socket_id  =3D
> >> -                                   n / (ms->smp.cores * ms->smp.threa=
ds);
> >> +        ms->possible_cpus->cpus[n].props.socket_id =3D topo.socket_id;
> >>           ms->possible_cpus->cpus[n].props.has_core_id =3D true;
> >> -        ms->possible_cpus->cpus[n].props.core_id =3D
> >> -                                   n / ms->smp.threads % ms->smp.core=
s;
> >> +        ms->possible_cpus->cpus[n].props.core_id =3D topo.core_id;
> >>           ms->possible_cpus->cpus[n].props.has_thread_id =3D true;
> >> -        ms->possible_cpus->cpus[n].props.thread_id =3D n % ms->smp.th=
reads;
> >> +        ms->possible_cpus->cpus[n].props.thread_id =3D topo.thread_id;
> >>       }
> >>       return ms->possible_cpus;
> >>   }
> >> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> >> index 7212fb5f8f..5dfc0d5c43 100644
> >> --- a/target/loongarch/cpu.c
> >> +++ b/target/loongarch/cpu.c
> >> @@ -16,6 +16,7 @@
> >>   #include "kvm/kvm_loongarch.h"
> >>   #include "exec/exec-all.h"
> >>   #include "cpu.h"
> >> +#include "hw/qdev-properties.h"
> >>   #include "internals.h"
> >>   #include "fpu/softfloat-helpers.h"
> >>   #include "cpu-csr.h"
> >> @@ -780,6 +781,15 @@ static int64_t loongarch_cpu_get_arch_id(CPUState=
 *cs)
> >>   }
> >>   #endif
> >>  =20
> >> +static Property loongarch_cpu_properties[] =3D {
> >> +    DEFINE_PROP_UINT32("phy-id", LoongArchCPU, phy_id, UNSET_PHY_ID),=
 =20
> >=20
> > IIUC, the phy_id is kind of like the x86 apic_id, but the field is comp=
letely
> > derived from topology, so why do you need to define it as a property an=
d then
> > expose it to the user? =20

> The property is wrongly used here. we want to differentiate cold-added=20
> cpus and hot-added cpus.  phy_id of cold-added cpus can be set during=20
> power on, however that of hot-added cpus is default -1.
why would you need to differentiate them?

>=20
> Internal variable phy_id can be set with default value -1 in function=20
> loongarch_cpu_init(), property can be removed.
>=20
> Regards
> Bibo Mao
> >=20
> > Thanks,
> > Zhao
> >  =20
>=20
>=20


