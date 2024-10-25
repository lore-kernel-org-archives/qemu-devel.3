Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E8ED0C612
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 13:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Kjm-0004We-N0; Fri, 25 Oct 2024 09:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t4Kjk-0004WL-6r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t4Kjh-0004li-AB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729864335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LzPxsNLZ9awoqPxbi7SmiFNw3IPK/mlmh5g4JcvZ0p8=;
 b=TyCeDbleU833tQlz9IoZwblqW7MjdBjzGiImM6o32YOthZD4XWT9v6i13dCrUTN0LHE5Sj
 s7oMaZZdFIqooXoGR1VBg5Ujy0eWHwTWjes3Z1AXiU5RkzRXQsoRwROJpwmHXZ6Souqn5t
 BLPPBhonmkw+qLIZr1r8+Ech/CDZHVk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-bFVN803QMWqE5wnfzx6kkg-1; Fri, 25 Oct 2024 09:52:13 -0400
X-MC-Unique: bFVN803QMWqE5wnfzx6kkg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d45f1e935so1090867f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 06:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729864332; x=1730469132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzPxsNLZ9awoqPxbi7SmiFNw3IPK/mlmh5g4JcvZ0p8=;
 b=J5W8itOdhR4TPT7y0+D/s7chCtQzVAzCK7E+7DXDbomgKtgAfwdhxqgfFyYSlgxvr8
 6xSPEG/aBu72UOD2m+kgHCnX5XhjbH6IdyF1ej5Y1UbGsrfrBo3v3RM/fSQISYseXn+q
 A3c/IcKuaYl/+KhVEMqsT2NP8fFNS/RFIzhwdc/SMFRvOpHtNJAH6ALpGjdg1EBF8RJR
 SDwMyC96x+aQEqg4CkRMlUtDgOgJpgy2JrZlS2PprXZTYDHeEreLbQ2CwuW+s2raanOl
 vzOKWnW2hEkTRE6BzecWOeNO8v0UwScigJ9Fys3jrzZCOqezQzBDm2j2d+uibzm6Qn+N
 7mAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHnvEttMIfVZB9gwoOSBhnPjqa6t8H1EjMGwXgLsHeKlMRn4USDOX3NgLpmrD3BbL6/z4z1Xj+XbkG@nongnu.org
X-Gm-Message-State: AOJu0YxHm4SXay6TbQwxoboqYqCuHXiPBarTecbD0y4Gd4XQJC1BtFSj
 74a0x+PNL8Q74pbIBn1dYX8KqL4XnUfKKowbdQhRAxY8BcgbJEd488ZsjZEIQM5YXIFVEU3eGHS
 jeWOqzl+zCXvSUHicIHk05BCNqp7QXJTc+lAnCxbtYtDmEeRg11X/
X-Received: by 2002:a5d:55cc:0:b0:37d:4e80:516 with SMTP id
 ffacd0b85a97d-37efcf1fe4cmr6399732f8f.34.1729864332005; 
 Fri, 25 Oct 2024 06:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWZkPFd40d5hteyH1SltyGOsunZrXnromS7tN+fCGvU5yM65ZkIe4GTAJsr9ix+qFyFso43g==
X-Received: by 2002:a5d:55cc:0:b0:37d:4e80:516 with SMTP id
 ffacd0b85a97d-37efcf1fe4cmr6399669f8f.34.1729864331373; 
 Fri, 25 Oct 2024 06:52:11 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431935f7789sm18428985e9.36.2024.10.25.06.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 06:52:10 -0700 (PDT)
Date: Fri, 25 Oct 2024 15:52:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com,
 linuxarm@huawei.com, gustavo.romero@linaro.org
Subject: Re: [PATCH V1 1/4] hw/acpi: Initialize ACPI Hotplug CPU Status with
 Support for vCPU `Persistence`
Message-ID: <20241025155208.6738d5d1@imammedo.users.ipa.redhat.com>
In-Reply-To: <CAJ7pxebmkChnxUHCVisLSvPT5XYLNo-QV8re0vhWVUbfeOCgaQ@mail.gmail.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-2-salil.mehta@huawei.com>
 <20241018161116.73b12156@imammedo.users.ipa.redhat.com>
 <CAJ7pxebmkChnxUHCVisLSvPT5XYLNo-QV8re0vhWVUbfeOCgaQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

On Mon, 21 Oct 2024 22:50:40 +0100
Salil Mehta <salil.mehta@opnsrc.net> wrote:

> Hi Igor,
>=20
> Thanks for taking time to review and sorry for not being prompt. I was in
> transit
> due to some difficult personal situation.
>=20
> On Fri, Oct 18, 2024 at 3:11=E2=80=AFPM Igor Mammedov <imammedo@redhat.co=
m> wrote:
>=20
> > On Mon, 14 Oct 2024 20:22:02 +0100
> > Salil Mehta <salil.mehta@huawei.com> wrote:
> > =20
> > > Certain CPU architecture specifications [1][2][3] prohibit changes to=
 CPU =20
> >                                           ^^^^^^^^^
> > these do not point to specs but never mind
> > =20
> > > presence after the kernel has booted. This limitation exists because =
=20
> > many system =20
> > > initializations rely on the exact CPU count at boot time and do not =
=20
> > expect it to =20
> > > change later. For example, components like interrupt controllers, whi=
ch =20
> > are =20
> > > closely tied to CPUs, or various per-CPU features, may not support =20
> > configuration =20
> > > changes once the kernel has been initialized. This presents a challen=
ge =20
> > for =20
> > > virtualization features such as vCPU hotplug. =20
> >
> > well, x86 (incl cpu,interrupt ctrls) also doesn't have architectural
> > hotplug.
> > It's just OEM managed to implement it regardless and then bothered to m=
ake
> > OS changes to work with that.
> > It's just ARM community doesn't want to go there at this point of time
> > but using above reasoning as justification for this series doesn't look
> > good to me.
> > =20
>=20
>=20
> There is a difference though. vCPU presence cannot be changed after the
> system has
> initialized in the ARM world due to the Architectural constraint.=20
> I think
> in the x86 world
> it is allowed?=20

As far as I know x86 doesn't have arch defined hotplug, but vendors
managed to implement it somehow and then made sure that OS running on top
could stomach it.

> > So what ARM would like to support is not CPU hotplug but rather a fixed
> > system with standby CPUs (that can be powered on/off on demand).
> > With ACPI spec amended to support that (MADT present/enabled changes), =
it's
> > good enough reason to add 'enabled' handling to acpi cpu-hotplug code
> > instead
> > of inventing alternative one that would do almost the same.
> > =20
>=20
>=20
> Not sure what you mean here but this is what is being done.
it was ack for 'enabled' flag in cphp acpi abi.
The rest was digression wrt 'present' hack in ACPI code.
=20
=20
> > But lets get rid of (can't/may not) language above and use standby CPUs
> > reasoning
> > to avoid any confusion.
> > =20
>=20
>=20
> I've to disagree here. Standy-by means you will have to keep all the vCPUs
> states
> realized and the objects will always exist. This is a problem for larger
> systems
> with vCPU hotplug support as it drastically affects the boot times.
>

see comment below about boot times.

> Please
> check
> the KVM Forum 2023 slides for objective values.

For sure we can conjure unicorns especially virtual ones,
it doesn't mean that we should do it though.

> It's been a long time since this series was actually conceived and at that
> time we wanted
> to use it for kata containers but later with the gradual adoption of
> various microvms
> and the cloud hypervisor requirements have bit changed. Boot time still
> remains one
> of the major requirements. Not bounding boot time while using this feature
> will
> seriously affect performance if the number of vCPUs increases

again wrt boot time, see comment below.


> > PS:
> > I'm taking about hw hotplug (at QEMU level) and not kernel hotplug
> > (where it's at logical cpu level).
> > =20
>=20
> sure
>=20
>=20
> > =20
> > > To address this issue, introduce an `is_enabled` state in the =20
> > `AcpiCpuStatus`, =20
> > > which reflects whether a vCPU has been hot-plugged or hot-unplugged i=
n =20
> > QEMU, =20
> > > marking it as (un)available in the Guest Kernel. =20
> > good so far
> > =20
> > > The `is_present` state should
> > > be set based on the `acpi_persistent` flag. In cases where unplugged =
=20
> > vCPUs need =20
> > > to be deliberately simulated in the ACPI to maintain a persistent vie=
w =20
> > of vCPUs, =20
> > > this flag ensures the guest kernel continues to see those vCPUs. =20
> >
> > that's where I have to disagree, vCPU is present when a corresponding Q=
OM
> > object
> > exists. Faking it's presence will only confuse at the end.
> > =20
>=20
>=20
> Not faking care of it will mean realization  of the unnecessary vCPU
> threads during
> the VM init time, which in turn will increase the boot time. Trade-off
> between more
> clean design and performance.

I very much prefer clean design, which should result in
less code/less bugs/easier maintenance and less regressions
when someone fixes intentional hacks, with a good reasoning that
hardware doesn't work that way.

wrt boot time, see below.

> > I get that you want to reuse device_add/del interface, but that leads to
> > pulling the leg here and there to make thing fit. That in short therm
> > (while someone remembers all tricks) might work for some, but long therm
> > it's not sustainable).
> > =20
>=20
>=20
> I do not understand why?

It's a complicated set of hacks all over place to make something that
do not exists in the real world work somehow.

While at the same time there is alternative approach that mimics ARM hardwa=
re
behavior and is supported by vendor (standby cpus).
That also will be much more simple way, while providing similar to hotplug
functionality.=20


> > Maybe instead of pushing device_add/del, we should rather implement
> > standby CPU model here, as ARM folks expect it to be.
> > i.e. instead of device_add/del add 'enabled' property to ARM vCPU,
> > and let management to turn on/off vCPUs on demand.
> > (and very likely this model could be reused by other sock based platfor=
ms)
> > For end-user it would be the same as device_add/del (i.e. vCPU becomes
> > usable/unsable)
>
>=20
> One of the main goals is to facilitate seamless migration from the x86
> world to
> ARM world. Hence, preservation of the x86 interface is important. It is a
> requirement.
> Just imagine if Apple had to change end user interface experience after
> migrating iOS
> from x86 to ARM architecture. ?

About that I wouldn't worry much as it's secondary.
Management can adapt to call 'qom set' instead of calling device_add/del.
It definitely shouldn't be the thing that turns design decisions
into the bad model.

> > I'd bet it would simplify your ARM CPU hotplug series a lot,
> > since you won't have to fake vCPU object lifetime and do
> > non trivial tricks to make it all work.
> > Which it turn will make ARM hotplug series much more approachable
> > for reviewers /and whomever comes later across that code/.
> > =20
>=20
> Tricks are just for ACPI and GIC and nothing else. Rest is a
> boilerplate code of the
> vCPU hotplug framework which x86 is also using.
=20
looking at your v5 ARM cphp series, it does a bunch refactoring
to handle CPU absence whre there should be one by design.

While in standby cpus, that won't be needed.
(one would need a code to enable/disable CPUs, plus making ACPI
deliver those events, but that's pretty much all. i.e. do what real
hw can do)

> > Regardless of said, we would still need changes to ACPI cphp code,
> > see my comments inline.
> > =20
>=20
> sure.
>=20
>=20
> >
> > =20
> > > Additionally, introduce an `acpi_persistent` property that can be use=
d to
> > > initialize the ACPI vCPU presence state accordingly. Architectures =20
> > requiring =20
> > > ACPI to expose a persistent view of vCPUs can override its default =20
> > value. Refer =20
> > > to the patch-set implelenting vCPU hotplug support for ARM for more =
=20
> > details on =20
> > > its usage.
> > >
> > > References:
> > > [1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Vi=
rt =20
> > CPU Hotplug on =20
> > >     architectures that don=E2=80=99t Support CPU Hotplug (like ARM64)
> > >     a. Kernel Link: =20
> > https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf =20
> > >     b. Qemu Link: =20
> > https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt=
_CPU_Hotplug_-__ii0iNb3.pdf =20
> > > [2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU =
=20
> > Hotplug on =20
> > >     SoC Based Systems (like ARM64)
> > >     Link: https://kvmforum2020.sched.com/event/eE4m
> > > [3] Check comment 5 in the bugzilla entry
> > >     Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481#c5
> > >
> > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > > ---
> > >  cpu-target.c          |  1 +
> > >  hw/acpi/cpu.c         | 35 ++++++++++++++++++++++++++++++++++-
> > >  include/hw/acpi/cpu.h | 21 +++++++++++++++++++++
> > >  include/hw/core/cpu.h | 21 +++++++++++++++++++++
> > >  4 files changed, 77 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/cpu-target.c b/cpu-target.c
> > > index 499facf774..c8a29ab495 100644
> > > --- a/cpu-target.c
> > > +++ b/cpu-target.c
> > > @@ -200,6 +200,7 @@ static Property cpu_common_props[] =3D {
> > >       */
> > >      DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
> > >                       MemoryRegion *),
> > > +    DEFINE_PROP_BOOL("acpi-persistent", CPUState, acpi_persistent, =
=20
> > false),
> >
> > I agree with Gavin, it's not CPU property/business, but a platform one.
> >
> > Pass it as argument to cpu_hotplug_hw_init(),
> > and maybe rename to always_present.
> > Then make sure that it's configurable in GED (which calls the function),
> > and just turn it on for arm/virt machine.
> > Other platforms might want to use x86 approach with GED and have
> > vCPU actually disappearing. /loongson and maybe risc-v/
> > =20
>=20
> can we move it to Machine level or fetch it through firmware?

following would do:
  1. add to ged  a new property to opt-in into this
  2. set the new property from arm's board_init where GED is created=20
  3. when GED calls cpu_hotplug_hw_init(), pass property value as an argume=
nt

> > >  #endif
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > > diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> > > index 5cb60ca8bc..083c4010c2 100644
> > > --- a/hw/acpi/cpu.c
> > > +++ b/hw/acpi/cpu.c
> > > @@ -225,7 +225,40 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Objec=
t =20
> > *owner, =20
> > >      state->dev_count =3D id_list->len;
> > >      state->devs =3D g_new0(typeof(*state->devs), state->dev_count);
> > >      for (i =3D 0; i < id_list->len; i++) {
> > > -        state->devs[i].cpu =3D  CPU(id_list->cpus[i].cpu);
> > > +        struct CPUState *cpu =3D CPU(id_list->cpus[i].cpu);
> > > +        /*
> > > +         * In most architectures, CPUs that are marked as ACPI =20
> > 'present' are =20
> > > +         * also ACPI 'enabled' by default. These states remain =20
> > consistent at =20
> > > +         * both the QOM and ACPI levels.
> > > +         */
> > > +        if (cpu) {
> > > +            state->devs[i].is_enabled =3D true;
> > > +            state->devs[i].is_present =3D true;
> > > +            state->devs[i].cpu =3D cpu;
> > > +        } else {
> > > +            state->devs[i].is_enabled =3D false;
> > > +            /*
> > > +             * In some architectures, even 'unplugged' or 'disabled'=
 =20
> > QOM CPUs =20
> > > +             * may be exposed as ACPI 'present.' This approach provi=
des =20
> > a =20
> > > +             * persistent view of the vCPUs to the guest kernel. Thi=
s =20
> > could be =20
> > > +             * due to an architectural constraint that requires ever=
y =20
> > per-CPU =20
> > > +             * component to be present at boot time, meaning the exa=
ct =20
> > count of =20
> > > +             * vCPUs must be known and cannot be altered after the =
=20
> > kernel has =20
> > > +             * booted. As a result, the vCPU states at the QOM and A=
CPI =20
> > levels =20
> > > +             * might become inconsistent. However, in such cases, th=
e =20
> > presence =20
> > > +             * of vCPUs has been deliberately simulated at the ACPI =
=20
> > level. =20
> > > +             */ =20
> >
> > if cpus are not 'simulated', you will not need comments explaining that=
 all
> > over place and whole hunk would likely go away.
> > =20
>=20
> I can reduce the content if you wish.

you have those comments for a reason since the code does unexpected
'simulate' thing. Removing that would mask intentional behavior
for a reader later down the road.

 =20
> > > +            if (acpi_persistent_cpu(first_cpu)) {
> > > +                state->devs[i].is_present =3D true;
> > > +                /*
> > > +                 * `CPUHotplugState::AcpiCpuStatus::cpu` becomes =20
> > insignificant =20
> > > +                 * in this case
> > > +                 */
> > > +            } else {
> > > +                state->devs[i].is_present =3D false;
> > > +                state->devs[i].cpu =3D cpu;
> > > +            }
> > > +        }
> > >          state->devs[i].arch_id =3D id_list->cpus[i].arch_id;
> > >      }
> > >      memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops,=
 =20
> > state, =20
> > > diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> > > index 32654dc274..bd3f9973c9 100644
> > > --- a/include/hw/acpi/cpu.h
> > > +++ b/include/hw/acpi/cpu.h
> > > @@ -26,6 +26,8 @@ typedef struct AcpiCpuStatus {
> > >      uint64_t arch_id;
> > >      bool is_inserting;
> > >      bool is_removing;
> > > +    bool is_present; =20
> > with always_present, it might be better to move field to CPUHotplugState
> > as it's not per vCPU anymore, and in standby case state->devs[i].cpu
> > should work as implicit present flag. (see below wrt doc first comment)
> > =20
>=20
> I'm still not convinced of the stand-by approach because of the performan=
ce
> impact
> it will have upon increasing the number of possible vCPUs and its worst
> case is
> unbounded. That's a major problem.

# of vCPUs is always bound by host capabilities and by modeled hardware.

=46rom guest point of view both approaches should save time as
guest won't try to online non-present or disabled CPUs
(with large machines guest boot time usually dwarfs whatever
QEMU does before the guest, +UEFI adds to insult event more).
And fast booting large VM (with non present CPUs) initially,
is just postponing problem the the later time when hotplugging
CPUs causes worse timing (since guest effectively does stop_machine)
for 'online'-ing to happen.

Regardless, standby CPUs is what ARM folks have chosen to support.
In this case, I'd pick arch preferred way anytime vs some boot time
improvements.

If arm_cpu_realizefn() is still expensive for your case and better
init times are needed, fix it instead of working around it by faking
hotplug on QEMU side and moving issue to the later time.
That way will benefit not only hotplug case, but also huge VMs case.
(good example is x86, where it scales well without any hotplug)

PS:
Out of curiosity, I've just fed qemu to perf on Ampere host.
There are a number of low hanging fruits that would reduce consumed
CPU cycles, for those who wishes to improve performance.

Some would lead to overall improvements, other could be
done when vCPU is disabled.

ex: with -enable-kvm -smp 100
   - 26.18% arm_cpu_realizefn
      + 8.86% cpu_reset <- likely is not necessary for disabled vCPUs, as o=
ne has to call it again when enabling vCPU
      + 4.53% register_cp_regs_for_features
      + 4.32% arm_cpu_register_gdb_regs_for_features  <- do we need it when=
 gdbstub is not enabled?
      + 4.09% init_cpreg_list  <- naive refactoring makes it a fraction of =
percent
      + 3.40% qemu_init_vcpu
        0.59% trace_init_vcpu

with above hacks it goes down to 11% (12% for x86_cpu_realizefn).
However wall-clock wise compared to x86, the arm/virt doesn't scale well.
So there is something else tgetting in the way (i.e. something stalls vCPU =
creation on ARM?).

And well, I' might be comparing apples to oranges here (old E5-2630v3 vs so=
me 32core 3.3Ghz Ampere cpu).

PS2:
create-gic() is another candidate for improvement, it spends a lot
of time on setting GPIO properties.

> > > +    bool is_enabled; =20
> > I'd move introduction of this field into a separate patch.
> >
> > BTW: new ABI/fields accessible by guest should be described in
> > docs/specs/acpi_cpu_hotplug.rst.
> > It would be better to have the spec as patch 1st, that we all agree on
> > and then follow with implementation.
> > =20
>=20
> We can do that.
>=20
>=20
> > And also include there an expected workflow for standby case. =20
>=20
>=20
>=20
> We need more discussion on this as our requirements for which we floated
                                      ^^^^^^^^^^^^^^
> this
> feature are not being met using stand-by cases.

A list of them would be a good starting point for discussion.
Perhaps requirements should be made more realistic and be re-evaluated.


> Thanks!
>=20
> Best regards
> Salil.
>=20
> >
> > =20
> > >      bool fw_remove;
> > >      uint32_t ost_event;
> > >      uint32_t ost_status;
> > > @@ -75,4 +77,23 @@ extern const VMStateDescription vmstate_cpu_hotplu=
g;
> > >      VMSTATE_STRUCT(cpuhp, state, 1, \
> > >                     vmstate_cpu_hotplug, CPUHotplugState)
> > >
> > > +/**
> > > + * acpi_persistent_cpu:
> > > + * @cpu: The vCPU to check
> > > + *
> > > + * Checks if the vCPU state should always be reflected as *present* =
via =20
> > ACPI =20
> > > + * to the Guest. By default, this is False on all architectures and =
has =20
> > to be =20
> > > + * explicity set during initialization.
> > > + *
> > > + * Returns: True if it is ACPI 'persistent' CPU
> > > + *
> > > + */
> > > +static inline bool acpi_persistent_cpu(CPUState *cpu)
> > > +{
> > > +    /*
> > > +     * returns if 'Presence' of the vCPU is persistent and should be=
 =20
> > simulated =20
> > > +     * via ACPI even after vCPUs have been unplugged in QOM
> > > +     */
> > > +    return cpu && cpu->acpi_persistent;
> > > +}
> > >  #endif
> > > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > > index 04e9ad4996..299e96c45b 100644
> > > --- a/include/hw/core/cpu.h
> > > +++ b/include/hw/core/cpu.h
> > > @@ -542,6 +542,27 @@ struct CPUState {
> > >      CPUPluginState *plugin_state;
> > >  #endif
> > >
> > > +    /*
> > > +     * To implement the vCPU hotplug feature (which simulates CPU =20
> > hotplug =20
> > > +     * behavior), we need to dynamically create and destroy QOM vCPU=
 =20
> > objects, =20
> > > +     * and (de)associate them with pre-existing KVM vCPUs while =20
> > (un)parking the =20
> > > +     * KVM vCPU context. One challenge is ensuring that these =20
> > dynamically =20
> > > +     * appearing or disappearing QOM vCPU objects are accurately =20
> > reflected =20
> > > +     * through ACPI to the Guest Kernel. Due to architectural =20
> > constraints, =20
> > > +     * changing the number of vCPUs after the guest kernel has boote=
d =20
> > may not =20
> > > +     * always be possible.
> > > +     *
> > > +     * In certain architectures, to provide the guest kernel with a =
=20
> > *persistent* =20
> > > +     * view of vCPU presence, even when the QOM does not have a =20
> > corresponding =20
> > > +     * vCPU object, ACPI may simulate the presence of vCPUs by marki=
ng =20
> > them as =20
> > > +     * ACPI-disabled. This is achieved by setting `_STA.PRES=3DTrue`=
 and
> > > +     * `_STA.Ena=3DFalse` for unplugged vCPUs in QEMU's QOM.
> > > +     *
> > > +     * By default, this flag is set to `FALSE`, and it must be =20
> > explicitly set =20
> > > +     * to `TRUE` for architectures like ARM.
> > > +     */
> > > +    bool acpi_persistent;
> > > +
> > >      /* TODO Move common fields from CPUArchState here. */
> > >      int cpu_index;
> > >      int cluster_index; =20
> >
> > =20


