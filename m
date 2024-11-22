Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE95FD75E3B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 13:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tETlD-0003k4-RU; Fri, 22 Nov 2024 08:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tETl7-0003jn-Lq
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:31:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tETl4-00013K-SB
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732282295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ak7xZxltT9GboeV46jBRL+PHB79q4G9yPwf2zAkqgAk=;
 b=Q0Ke+CTcUUFGV7qsEakeUvJ27LHlaXDS2BonozzsFTDWeJFR+NUdAflbtEmu/qJYcq9RhX
 j4VSYK0MEebccrX9yIzfX/wi2W9ReLZahkiWeTfi+jyf2bizbo1N49eDXu+BX0AjlOI6wL
 7yCbjuC2iRlFBf0uQ2E7XxAvCe5R6mU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-8jD8NmH0PWyrLlgs8io_QQ-1; Fri, 22 Nov 2024 08:31:30 -0500
X-MC-Unique: 8jD8NmH0PWyrLlgs8io_QQ-1
X-Mimecast-MFC-AGG-ID: 8jD8NmH0PWyrLlgs8io_QQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38235e99a53so1220025f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 05:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732282289; x=1732887089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ak7xZxltT9GboeV46jBRL+PHB79q4G9yPwf2zAkqgAk=;
 b=YGmwFiM9Jp3xqS9NQ+2U/TLCA9ka0DD3NWHt6CMtFgl57S57quuGwi6ykA0qfSngPN
 wNDNYD8i7KwD+/QgySncZ69VRR5K9AtCQPE5gDCWWIGEDGO3nkTMtm2VC4KLTBU7E/ij
 dSyB2FyBKc7bUSUU8VNrYBxAhn8rInpR9fEvVywc5a+miAbAlaOki75DSVsAG4Ky51fU
 wxGPofDrUL+1HLW6uMLIkYQZeDdKc1B+lFLxadxS882ExNCHrZU9wv9/Q8hlzces81+Z
 setylcyZbAkEQXBaqpQMC4NyChxpIIWdbTEoREBUorzOVpA+E1LbbDPWvW2Vm7TMK0FS
 F3Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXho9OaX7peoohk3SS8n5Heg9gFFTl8EqZqQB9PUsTbQz2UTBniYkxK2F7JFACQzH9xKtTLlnZuC/xw@nongnu.org
X-Gm-Message-State: AOJu0YyN94O0ei+BOA/be8sjpu6Au8OqMkIuiQxvmOJgLA964TfBZL96
 Evgzu5DEK3W3yJdasH5XEXQMYVHxAT5DsKjZPl/ShxLNZ7ikhzCKCvVStp9UECR52jUFYUZmXSk
 bCVZo71Fbo+vFDkIzQkVmTdL2NIsKOx9yjYK8pl4Vx/smp48vaoOz
X-Gm-Gg: ASbGncvclI+3e3xieT2PhnvzR/QSiJLDD9XMwZZKEQhSFD7oC5HJSA3rVPgf4J5I3qr
 cwGp0CHfwvJSpD2lp55RAT4ctQ8IzDJ9pJdqHW3rDZ0URrZcX+f20YaPjqc0ZesARiLQF/vKx0K
 0IyEBjRUNVIEQabLWDatgyiv4b8TewkF/48ozjgDc7gtHbzM2BLaMV4xW3K2bU1TN0EuC1M/R/Z
 GK198QiZhBDabkKOp/eYoNrXk1rIhx3BTKGkL6D/CHDNlEUH3nEPXQ7GVHiKsfVV/R6mDfk8SPF
 04xZ4Tla36mEgU6xKT0wCQ==
X-Received: by 2002:a05:6000:1449:b0:37c:f561:1130 with SMTP id
 ffacd0b85a97d-382604fb8e0mr2624790f8f.18.1732282289182; 
 Fri, 22 Nov 2024 05:31:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuanrXF2aKGOiKXP5Mtq5ywNFPS9Bu9OFV6qfMrAmFEBp/otN3ZPtrTy07MUk49/F6/H0B9Q==
X-Received: by 2002:a05:6000:1449:b0:37c:f561:1130 with SMTP id
 ffacd0b85a97d-382604fb8e0mr2624760f8f.18.1732282288725; 
 Fri, 22 Nov 2024 05:31:28 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb05e3esm2472488f8f.42.2024.11.22.05.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 05:31:28 -0800 (PST)
Date: Fri, 22 Nov 2024 14:31:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/6] hw/loongarch/virt: Add CPU topology support
Message-ID: <20241122143126.571199b0@imammedo.users.ipa.redhat.com>
In-Reply-To: <10896516-58cd-d614-e6f0-f9c683da7b88@loongson.cn>
References: <20241112021738.1952851-1-maobibo@loongson.cn>
 <20241112021738.1952851-2-maobibo@loongson.cn>
 <20241118171029.5a9ed8bd@imammedo.users.ipa.redhat.com>
 <10896516-58cd-d614-e6f0-f9c683da7b88@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, 19 Nov 2024 16:01:37 +0800
bibo mao <maobibo@loongson.cn> wrote:

> Hi Ignor,
>=20
> On 2024/11/19 =E4=B8=8A=E5=8D=8812:10, Igor Mammedov wrote:
> > On Tue, 12 Nov 2024 10:17:33 +0800
> > Bibo Mao <maobibo@loongson.cn> wrote:
> >  =20
> >> Add topological relationships for Loongarch VCPU and initialize
> >> topology member variables. Also physical cpu id calculation
> >> method comes from its topo information.
> >>
> >> Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   docs/system/loongarch/virt.rst | 31 +++++++++++++++
> >>   hw/loongarch/virt.c            | 73 ++++++++++++++++++++++++++++----=
--
> >>   target/loongarch/cpu.c         | 12 ++++++
> >>   target/loongarch/cpu.h         | 16 ++++++++
> >>   4 files changed, 119 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/docs/system/loongarch/virt.rst b/docs/system/loongarch/vi=
rt.rst
> >> index 172fba079e..8daf60785f 100644
> >> --- a/docs/system/loongarch/virt.rst
> >> +++ b/docs/system/loongarch/virt.rst
> >> @@ -28,6 +28,37 @@ The ``qemu-system-loongarch64`` provides emulation =
for virt
> >>   machine. You can specify the machine type ``virt`` and
> >>   cpu type ``la464``.
> >>  =20
> >> +CPU Topology
> >> +------------
> >> +
> >> +The ``LA464`` type CPUs have the concept of Socket Core and Thread.
> >> +
> >> +For example:
> >> +
> >> +``-smp 1,maxcpus=3DM,sockets=3DS,cores=3DC,threads=3DT``
> >> +
> >> +The above parameters indicate that the machine has a maximum of ``M``=
 vCPUs and
> >> +``S`` sockets, each socket has ``C`` cores, each core has ``T`` threa=
ds,
> >> +and each thread corresponds to a vCPU.
> >> +
> >> +Then ``M`` ``S`` ``C`` ``T`` has the following relationship:
> >> +
> >> +``M =3D S * C * T``
> >> +
> >> +In the CPU topology relationship, When we know the ``socket_id`` ``co=
re_id``
> >> +and ``thread_id`` of the CPU, we can calculate its ``arch_id``:
> >> +
> >> +``arch_id =3D (socket_id * S) + (core_id * C) + (thread_id * T)`` =20
> >=20
> > Is there a spec or some other reference where all of this is described?
> > (or is that a made up just for QEMU?) =20
> With hardware manual about cpuid register, it only says that it is 9-bit=
=20
Is manual accessible to public/published somewhere?
What I'm basically asking is to add comments to registers involved
that point to specification that defines them in format
  (Spec name, revision, chapter [,reg name])
so whoever reads that code could go and compare it with specification

> width now, however there is no detailed introduction about=20
> socket_id/core_id/thread_id about this register. So it can be treated as=
=20
> a made up for QEMU.
I'd rather not make up thing unless there is no other way around.
arch_id doesn't have to be derived from topo parameters, and can be
separate from them (it's an ID by which a cpu can be addressed in hw)

How topology is encoded on real hw?

> >=20
> >  =20
> >> +
> >> +Similarly, when we know the ``arch_id`` of the CPU,
> >> +we can also get its ``socket_id`` ``core_id`` and ``thread_id``:
> >> +
> >> +``socket_id =3D arch_id / (C * T)``
> >> +
> >> +``core_id =3D (arch_id / T) % C``
> >> +
> >> +``thread_id =3D arch_id % T``
> >> +
> >>   Boot options
> >>   ------------
> >>  =20
> >> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> >> index 9a635d1d3d..1ed5130edf 100644
> >> --- a/hw/loongarch/virt.c
> >> +++ b/hw/loongarch/virt.c
> >> @@ -1143,9 +1143,9 @@ static void virt_init(MachineState *machine)
> >>       LoongArchVirtMachineState *lvms =3D LOONGARCH_VIRT_MACHINE(machi=
ne);
> >>       int i;
> >>       hwaddr base, size, ram_size =3D machine->ram_size;
> >> -    const CPUArchIdList *possible_cpus;
> >>       MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> >>       CPUState *cpu;
> >> +    Object *cpuobj;
> >>  =20
> >>       if (!cpu_model) {
> >>           cpu_model =3D LOONGARCH_CPU_TYPE_NAME("la464");
> >> @@ -1163,13 +1163,30 @@ static void virt_init(MachineState *machine)
> >>       memory_region_add_subregion(&lvms->system_iocsr, 0, &lvms->iocsr=
_mem);
> >>  =20
> >>       /* Init CPUs */
> >> -    possible_cpus =3D mc->possible_cpu_arch_ids(machine); =20
> > I'd keep this, and use below, it makes line shorter =20
> Sure, will modify it in next version.
>=20
> >=20
> >  =20
> >> -    for (i =3D 0; i < possible_cpus->len; i++) {
> >> -        cpu =3D cpu_create(machine->cpu_type);
> >> +    mc->possible_cpu_arch_ids(machine);
> >> +    for (i =3D 0; i < machine->smp.cpus; i++) {
> >> +        cpuobj =3D object_new(machine->cpu_type);
> >> +        if (cpuobj =3D=3D NULL) {
> >> +            error_report("Fail to create object with type %s ",
> >> +                         machine->cpu_type);
> >> +            exit(EXIT_FAILURE);
> >> +        }
> >> +
> >> +        cpu =3D CPU(cpuobj); =20
> >  =20
> >>           cpu->cpu_index =3D i; =20
> > this probably should be in _pre_plug handler,
> > also see
> > (a15d2728a9aa pc: Init CPUState->cpu_index with index in possible_cpus[=
])
> > for why x86 does it.
> >  =20
> Will modify it in next version.
>=20
> >>           machine->possible_cpus->cpus[i].cpu =3D cpu;
> >> -        lacpu =3D LOONGARCH_CPU(cpu);
> >> +        lacpu =3D LOONGARCH_CPU(cpuobj); =20
> >  =20
> >>           lacpu->phy_id =3D machine->possible_cpus->cpus[i].arch_id; =
=20
> > Given above is derived from topo data set below, I'd move above above
> > to pre_plug time, and calculate/set it there based on topo data.
> > There is no point in setting both at the same place.
> >  =20
> Will do.
> >> +        object_property_set_int(cpuobj, "socket-id",
> >> +                                machine->possible_cpus->cpus[i].props=
.socket_id,
> >> +                                NULL);
> >> +        object_property_set_int(cpuobj, "core-id",
> >> +                                machine->possible_cpus->cpus[i].props=
.core_id,
> >> +                                NULL);
> >> +        object_property_set_int(cpuobj, "thread-id",
> >> +                                machine->possible_cpus->cpus[i].props=
.thread_id,
> >> +                                NULL);
> >> +        qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
> >>       }
> >>       fdt_add_cpu_nodes(lvms);
> >>       fdt_add_memory_nodes(machine);
> >> @@ -1286,6 +1303,35 @@ static void virt_initfn(Object *obj)
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
> >> +    arch_id =3D (sock_vcpu_num + core_vcpu_num) + topo->thread_id;
> >> +
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
> >> @@ -1385,8 +1431,9 @@ static HotplugHandler *virt_get_hotplug_handler(=
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
> >> @@ -1397,17 +1444,17 @@ static const CPUArchIdList *virt_possible_cpu_=
arch_ids(MachineState *ms)
> >>                                     sizeof(CPUArchId) * max_cpus);
> >>       ms->possible_cpus->len =3D max_cpus;
> >>       for (n =3D 0; n < ms->possible_cpus->len; n++) {
> >> +        virt_get_topo_from_index(ms, &topo, n);
> >> +        arch_id =3D virt_get_arch_id_from_topo(ms, &topo);
> >> +        ms->possible_cpus->cpus[n].vcpus_count =3D 1;
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
> >> index 57cc4f314b..a99e22094e 100644
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
> >> @@ -725,6 +726,7 @@ static void loongarch_cpu_init(Object *obj)
> >>       timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
> >>                     &loongarch_constant_timer_cb, cpu);
> >>   #endif
> >> +    cpu->phy_id =3D UNSET_PHY_ID;
> >>   #endif
> >>   }
> >>  =20
> >> @@ -823,6 +825,14 @@ static int64_t loongarch_cpu_get_arch_id(CPUState=
 *cs)
> >>   }
> >>   #endif
> >>  =20
> >> +static Property loongarch_cpu_properties[] =3D {
> >> +    DEFINE_PROP_INT32("socket-id", LoongArchCPU, socket_id, 0),
> >> +    DEFINE_PROP_INT32("core-id", LoongArchCPU, core_id, 0),
> >> +    DEFINE_PROP_INT32("thread-id", LoongArchCPU, thread_id, 0),
> >> +    DEFINE_PROP_INT32("node-id", LoongArchCPU, node_id, CPU_UNSET_NUM=
A_NODE_ID),
> >> +    DEFINE_PROP_END_OF_LIST()
> >> +};
> >> +
> >>   static void loongarch_cpu_class_init(ObjectClass *c, void *data)
> >>   {
> >>       LoongArchCPUClass *lacc =3D LOONGARCH_CPU_CLASS(c);
> >> @@ -830,6 +840,7 @@ static void loongarch_cpu_class_init(ObjectClass *=
c, void *data)
> >>       DeviceClass *dc =3D DEVICE_CLASS(c);
> >>       ResettableClass *rc =3D RESETTABLE_CLASS(c);
> >>  =20
> >> +    device_class_set_props(dc, loongarch_cpu_properties);
> >>       device_class_set_parent_realize(dc, loongarch_cpu_realizefn,
> >>                                       &lacc->parent_realize);
> >>       resettable_class_set_parent_phases(rc, NULL, loongarch_cpu_reset=
_hold, NULL,
> >> @@ -854,6 +865,7 @@ static void loongarch_cpu_class_init(ObjectClass *=
c, void *data)
> >>   #ifdef CONFIG_TCG
> >>       cc->tcg_ops =3D &loongarch_tcg_ops;
> >>   #endif
> >> +    dc->user_creatable =3D true;
> >>   }
> >>  =20
> >>   static const gchar *loongarch32_gdb_arch_name(CPUState *cs)
> >> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> >> index 86c86c6c95..7472df0521 100644
> >> --- a/target/loongarch/cpu.h
> >> +++ b/target/loongarch/cpu.h
> >> @@ -19,6 +19,12 @@
> >>   #include "cpu-csr.h"
> >>   #include "cpu-qom.h"
> >>  =20
> >> +/*
> >> + * CPU can't have 0xFFFFFFFF physical ID, use that value to distingui=
sh
> >> + * that physical ID hasn't been set yet =20
> >=20
> > pointer to CPU spec/doc here would be nice to have
> >  =20
> Will add comments about CPU manual, the physical ID is 9-bit width at=20
> most now.
>=20
> Regards
> Bibo Mao
> >> + */
> >> +#define UNSET_PHY_ID 0xFFFFFFFF
> >> +
> >>   #define IOCSRF_TEMP             0
> >>   #define IOCSRF_NODECNT          1
> >>   #define IOCSRF_MSI              2
> >> @@ -390,6 +396,12 @@ typedef struct CPUArchState {
> >>   #endif
> >>   } CPULoongArchState;
> >>  =20
> >> +typedef struct LoongArchCPUTopo {
> >> +    int32_t socket_id;  /* socket-id of this VCPU */
> >> +    int32_t core_id;    /* core-id of this VCPU */
> >> +    int32_t thread_id;  /* thread-id of this VCPU */
> >> +} LoongArchCPUTopo;
> >> +
> >>   /**
> >>    * LoongArchCPU:
> >>    * @env: #CPULoongArchState
> >> @@ -404,6 +416,10 @@ struct ArchCPU {
> >>       uint32_t  phy_id;
> >>       OnOffAuto lbt;
> >>       OnOffAuto pmu;
> >> +    int32_t socket_id;  /* socket-id of this VCPU */
> >> +    int32_t core_id;    /* core-id of this VCPU */
> >> +    int32_t thread_id;  /* thread-id of this VCPU */
> >> +    int32_t node_id;    /* NUMA node of this VCPU */
> >>  =20
> >>       /* 'compatible' string for this CPU for Linux device trees */
> >>       const char *dtb_compatible; =20
>=20


