Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C7DCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 18:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBdQd-0007ii-E1; Wed, 22 Oct 2025 14:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vBdQC-0007aD-Mx
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:18:53 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vBdQ9-0000Ki-MI
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:18:52 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-65418f835a9so73905eaf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1761157123; x=1761761923; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lwpDoE+AQS0vtBN6brZEAMWyxfShnXJKsHxHNq6DP8=;
 b=JrwMGBRin2fhRz1vMU9L8ybMuXdgJgSp1WluOYES4mwgyR1WJp2zarL3ffWfCp5dq8
 M15E+Ju/F9MLMPnJm0fdqmWG7vXQZ6afW2FdJ2+L9dJXXdsEvPqOujBwBfCCWd1IaYRs
 weyZbNa4gVaguaBLN54sVszRWQb/n2hOY/mB51WKbAsn3+fAjx25kLZ/1yez1o03m7me
 ++Py8PIj8R0q7WfMnLKmK2WvqJIT07Qcgp3Vaw1i9H1lLvREQI0Gkt7CrpMiyZ5s+Hd4
 omNx0vRoSU+Xb8kooHlZ+wNhg71Xy9Gnl07fy0IxO/4FhDOTFeS/EFg48glnImdHxk2c
 DAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761157123; x=1761761923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1lwpDoE+AQS0vtBN6brZEAMWyxfShnXJKsHxHNq6DP8=;
 b=euAJocLBe5iN8YSqSf6Kvkpe/7VFRXrT1LiQHn+ziiGo7xjAc5zf0myN1qWaVfC8CZ
 jxkXNrli6Czn0TM4olcEZZ97zNLtR2TSmWyLBs0Ik1yDbnbOKi303hZsyvC6H6csoRbn
 IlcvIIl8/aPVMg+g21RJgjOmqn9bPqm2Ch5b/2dDoWn/zYX62NOCJqITRvFGFrkgP7cC
 oxnuT15fl1kARQnoVjxTigjCg3+UssAljrRmEoTDuI5C4Mh066TTDrgfpiZ+4pz5xIVC
 5SwT+2xT0+ZQKpGRXbyBOpXTYrpW1yzppMUuBEg09Cd+B6w6rtFgRyqAUBHH8r1Z0+j3
 DhMQ==
X-Gm-Message-State: AOJu0Yz2FlAuBy4lu8d65NnQslhtGgfKvUaEK7z+wnVkQz5PRL8UlTxt
 yQVhVSu/kekgjly3u9Ox7U3EJzBabn3McBRxDaavtxjYci0Yv5TbdGQdFMWumLi7nZA4WzPU9if
 M2yFZwVuRcnv+qJV1Y1xwsU0DbJ751u5M7PnBBcJRvA==
X-Gm-Gg: ASbGncssslgyxrMFPKI6VI8Dv76OVL0aCtprLUNzWF3shIdJZi5QZaS+SyImx9HhW/A
 z7x6I5U78okbCDs0ZgWCarif1oGTLs3CGaV4W3JsDVZ3MVq+CS6/O6pHo86hZyWE5aav97q6Xue
 c6zmy0hJrHhJWtnIIRmFzZ2V40W8rheKegBxj/STcLiY47NXX6vj2q3aIgn2NwsjeGL/5PwDzdH
 ffYHBh+OnxaPEitQApGTQMya34sNtKY50EI7ur9Hn2QqSmRZ0rOiJ6yiV9kLSWJRDcomt/vmf+N
 Y1hyCAoDf9XFfZywEvj6Yhm3YTsAPH1DiA50EoIiha5hG6npRMIN
X-Google-Smtp-Source: AGHT+IEorxuBFMx1iGhPbbFBaeth67qGUV5xZCEsQtYHTc/NgjqRZ0+VCcsIevn2FKpn1j7OXqqGWMMJICEMvFDzfCQ=
X-Received: by 2002:a05:6870:eca9:b0:345:c0a7:5fa3 with SMTP id
 586e51a60fabf-3c98cf94fc9mr7634155fac.20.1761157123290; Wed, 22 Oct 2025
 11:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-6-salil.mehta@opnsrc.net>
 <a03ed205-b61a-4bba-9f25-83663b7d8a86@redhat.com>
In-Reply-To: <a03ed205-b61a-4bba-9f25-83663b7d8a86@redhat.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Wed, 22 Oct 2025 18:18:32 +0000
X-Gm-Features: AS18NWC1ttp07K6Ix5F0Fg-D8s8wWwKauzGSj4OsCDZxJrxv5NlAHhq3699c2mI
Message-ID: <CAJ7pxeYurHLqj8GnLrfznmofMpsaw91GeZ3KMyucL0B_gn9gPg@mail.gmail.com>
Subject: Re: [PATCH RFC V6 05/24] arm/virt,kvm: Pre-create KVM vCPUs for
 'disabled' QOM vCPUs at machine init
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com, 
 salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org, 
 jonathan.cameron@huawei.com, lpieralisi@kernel.org, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, imammedo@redhat.com, armbru@redhat.com, 
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org, 
 eric.auger@redhat.com, will@kernel.org, ardb@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org, 
 borntraeger@linux.ibm.com, alex.bennee@linaro.org, gustavo.romero@linaro.org, 
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk, 
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com, 
 vishnu@os.amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 karl.heubaum@oracle.com, miguel.luis@oracle.com, zhukeqian1@huawei.com, 
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com, 
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn, 
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com, 
 Keqian Zhu <zhuqian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Gavin,

On Wed, Oct 22, 2025 at 10:37=E2=80=AFAM Gavin Shan <gshan@redhat.com> wrot=
e:
>
> Hi Salil,
>
> On 10/1/25 11:01 AM, salil.mehta@opnsrc.net wrote:
> > From: Salil Mehta <salil.mehta@huawei.com>
> >
> > ARM CPU architecture does not allow CPUs to be plugged after system has
> > initialized. This is a constraint. Hence, the Kernel must know all the =
CPUs
> > being booted during its initialization. This applies to the Guest Kerne=
l as
> > well and therefore, the number of KVM vCPU descriptors in the host must=
 be
> > fixed at VM initialization time.
> >
> > Also, the GIC must know all the CPUs it is connected to during its
> > initialization, and this cannot change afterward. This must also be ens=
ured
> > during the initialization of the VGIC in KVM. This is necessary because=
:
> >
> > 1. The association between GICR and MPIDR must be fixed at VM initializ=
ation
> >     time. This is represented by the register
> >     `GICR_TYPER(mp_affinity, proc_num)`.
> > 2. Memory regions associated with GICR, etc., cannot be changed (added,
> >     deleted, or modified) after the VM has been initialized. This is no=
t an
> >     ARM architectural constraint but rather invites a difficult and mes=
sy
> >     change in VGIC data structures.
> >
> > To enable a hot-add=E2=80=93like model while preserving these constrain=
ts, the virt
> > machine may enumerate more CPUs than are enabled at boot using
> > `-smp disabledcpus=3DN`. Such CPUs are present but start offline (i.e.,
> > administratively disabled at init). The topology remains fixed at VM
> > creation time; only the online/offline status may change later.
> >
> > Administratively disabled vCPUs are not realized in QOM until first ena=
bled,
> > avoiding creation of unnecessary vCPU threads at boot. On large systems=
, this
> > reduces startup time proportionally to the number of disabled vCPUs. On=
ce a
> > QOM vCPU is realized and its thread created, subsequent enable/disable =
actions
> > do not unrealize it. This behaviour was adopted following review feedba=
ck and
> > differs from earlier RFC versions.
> >
> > Co-developed-by: Keqian Zhu <zhuqian1@huawei.com>
> > Signed-off-by: Keqian Zhu <zhuqian1@huawei.com>
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> >   accel/kvm/kvm-all.c    |  2 +-
> >   hw/arm/virt.c          | 77 ++++++++++++++++++++++++++++++++++++++---=
-
> >   hw/core/qdev.c         | 17 ++++++++++
> >   include/hw/qdev-core.h | 19 +++++++++++
> >   include/system/kvm.h   |  8 +++++
> >   target/arm/cpu.c       |  2 ++
> >   target/arm/kvm.c       | 40 +++++++++++++++++++++-
> >   target/arm/kvm_arm.h   | 11 ++++++
> >   8 files changed, 168 insertions(+), 8 deletions(-)
> >
[...]
> >
> > +static void
> > +virt_setup_lazy_vcpu_realization(Object *cpuobj, VirtMachineState *vms=
)
> > +{
> > +    /*
> > +     * Present & administratively disabled vCPUs:
> > +     *
> > +     * These CPUs are marked offline at init via '-smp disabledcpus=3D=
N'. We
> > +     * intentionally do not realize them during the first boot, since =
it is
> > +     * not known if or when they will ever be enabled. The decision to=
 enable
> > +     * such CPUs depends on policy (e.g. guided by SLAs or other deplo=
yment
> > +     * requirements).
> > +     *
> > +     * Realizing all disabled vCPUs up front would make boot time prop=
ortional
> > +     * to 'maxcpus', even if policy permits only a small subset to be =
enabled.
> > +     * This can lead to unacceptable boot delays in some scenarios.
> > +     *
> > +     * Instead, these CPUs remain administratively disabled and unreal=
ized at
> > +     * boot, to be instantiated and brought online only if policy late=
r allows
> > +     * it.
> > +     */
> > +
> > +    /* set this vCPU to be administratively 'disabled' in QOM */
> > +    qdev_disable(DEVICE(cpuobj), NULL, &error_fatal);
> > +
> > +    if (vms->psci_conduit !=3D QEMU_PSCI_CONDUIT_DISABLED) {
> > +        object_property_set_int(cpuobj, "psci-conduit", vms->psci_cond=
uit,
> > +                                NULL);
> > +    }
> > +
> > +    /*
> > +     * [!] Constraint: The ARM CPU architecture does not permit new CP=
Us
> > +     * to be added after system initialization.
> > +     *
> > +     * Workaround: Pre-create KVM vCPUs even for those that are not ye=
t
> > +     * online i.e. powered-off, keeping them `parked` and in an
> > +     * `unrealized (at-least during boot time)` state within QEMU unti=
l
> > +     * they are powered-on and made online.
> > +     */
> > +    if (kvm_enabled()) {
> > +        kvm_arm_create_host_vcpu(ARM_CPU(cpuobj));
> > +    }
> > +}
> > +
> >   static void machvirt_init(MachineState *machine)
> >   {
> >       VirtMachineState *vms =3D VIRT_MACHINE(machine);
> > @@ -2319,10 +2362,6 @@ static void machvirt_init(MachineState *machine)
> >           Object *cpuobj;
> >           CPUState *cs;
> >
> > -        if (n >=3D smp_cpus) {
> > -            break;
> > -        }
> > -
> >           cpuobj =3D object_new(possible_cpus->cpus[n].type);
> >           object_property_set_int(cpuobj, "mp-affinity",
> >                                   possible_cpus->cpus[n].arch_id, NULL)=
;
> > @@ -2427,8 +2466,34 @@ static void machvirt_init(MachineState *machine)
> >               }
> >           }
> >
> > -        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> > -        object_unref(cpuobj);
> > +        /* start secondary vCPUs in a powered-down state */
> > +        if(n && mc->has_online_capable_cpus) {
> > +            object_property_set_bool(cpuobj, "start-powered-off", true=
, NULL);
> > +        }
> > +
> > +        if (n < smp_cpus) {
> > +            /* 'Present' & 'Enabled' vCPUs */
> > +            qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> > +            object_unref(cpuobj);
> > +        } else {
> > +            /* 'Present' & 'Disabled' vCPUs */
> > +            virt_setup_lazy_vcpu_realization(cpuobj, vms);
> > +        }
> > +
> > +        /*
> > +         * All possible vCPUs should have QOM vCPU Object pointer & ar=
ch-id.
> > +         * 'cpus_queue' (accessed via qemu_get_cpu()) contains only re=
alized and
> > +         * enabled vCPUs. Hence, we must now populate the 'possible_cp=
us' list.
> > +         */
> > +        if (kvm_enabled()) {
> > +            /*
> > +             * Override the default architecture ID with the one retri=
eved
> > +             * from KVM, as they currently differ.
> > +             */
> > +            machine->possible_cpus->cpus[n].arch_id =3D
> > +                arm_cpu_mp_affinity(ARM_CPU(cs));
> > +        }
> > +        machine->possible_cpus->cpus[n].cpu =3D cs;
> >       }
> >
> >       /* Now we've created the CPUs we can see if they have the hypvirt=
 timer */
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 8502d6216f..5816abae39 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -309,6 +309,23 @@ void qdev_assert_realized_properly(void)
> >                                      qdev_assert_realized_properly_cb, =
NULL);
> >   }
> >

[...]

> > +void kvm_arm_create_host_vcpu(ARMCPU *cpu)
> > +{
> > +    CPUState *cs =3D CPU(cpu);
> > +    unsigned long vcpu_id =3D cs->cpu_index;
> > +    int ret;
> > +
> > +    ret =3D kvm_create_vcpu(cs);
> > +    if (ret < 0) {
> > +        error_report("Failed to create host vcpu %ld", vcpu_id);
> > +        abort();
> > +    }
> > +
> > +    /*
> > +     * Initialize the vCPU in the host. This will reset the sys regs
> > +     * for this vCPU and related registers like MPIDR_EL1 etc. also
> > +     * get programmed during this call to host. These are referenced
> > +     * later while setting device attributes of the GICR during GICv3
> > +     * reset.
> > +     */
> > +    ret =3D kvm_arch_init_vcpu(cs);
> > +    if (ret < 0) {
> > +        error_report("Failed to initialize host vcpu %ld", vcpu_id);
> > +        abort();
> > +    }
> > +
> > +    /*
> > +     * park the created vCPU. shall be used during kvm_get_vcpu() when
> > +     * threads are created during realization of ARM vCPUs.
> > +     */
> > +    kvm_park_vcpu(cs);
> > +}
> > +
>
> I don't think we're able to simply call kvm_arch_init_vcpu() in the lazil=
y realized
> path. Otherwise, it can trigger a crash dump on my Nvidia's grace-hopper =
machine where
> SVE is supported by default.

Thanks for reporting this. That is not true. As long as we initialize
KVM correctly and
finalize the features like SVE we should be fine. In fact, this is
precisely what we are
doing right now.

To understand the crash, I need a bit more info.

1#  is happening because KVM_ARM_VCPU_INIT is failing. If yes, the can you =
check
      within the KVM if it is happening because
     a.  features specified by QEMU are not matching the defaults within th=
e KVM
           (HInt: check kvm_vcpu_init_check_features())?
     b. or complaining about init feate change kvm_vcpu_init_changed()?
2#  or it is happening during the setting of vector length or
finalizing features?

int kvm_arch_init_vcpu(CPUState *cs)
{
   [...]
         /* Do KVM_ARM_VCPU_INIT ioctl */
        ret =3D kvm_arm_vcpu_init(cpu);   ---->[1]
        if (ret) {
           return ret;
       }
          if (cpu_isar_feature(aa64_sve, cpu)) {
        ret =3D kvm_arm_sve_set_vls(cpu); ---->[2]
        if (ret) {
            return ret;
        }
        ret =3D kvm_arm_vcpu_finalize(cpu, KVM_ARM_VCPU_SVE);--->[3]
        if (ret) {
            return ret;
        }
    }
[...]
}

I think it's happening because vector length is going uninitialized.
This initialization
happens in context to  arm_cpu_finalize_features() which I forgot to call b=
efore
calling KVM finalize.

>
> kvm_arch_init_vcpu() is supposed to be called in the realization path in =
current
> implementation (without this series) because the parameters (features) to=
 KVM_ARM_VCPU_INIT
> is populated at vCPU realization time.

Not necessarily. It is just meant to initialize the KVM. If we take care of=
 the
KVM requirements in the similar way the realize path does we should be
fine. Can you try to add the patch below in your code and test if it works?

 diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c4b68a0b17..1091593478 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1068,6 +1068,9 @@ void kvm_arm_create_host_vcpu(ARMCPU *cpu)
         abort();
     }

+     /* finalize the features like SVE, SME etc */
+     arm_cpu_finalize_features(cpu, &error_abort);
+
     /*
      * Initialize the vCPU in the host. This will reset the sys regs
      * for this vCPU and related registers like MPIDR_EL1 etc. also




>
> $ home/gavin/sandbox/qemu.main/build/qemu-system-aarch64           \
>    --enable-kvm -machine virt,gic-version=3D3 -cpu host               \
>    -smp cpus=3D4,disabledcpus=3D2 -m 1024M                              \
>    -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image    \
>    -initrd /home/gavin/sandbox/images/rootfs.cpio.xz -nographic
> qemu-system-aarch64: Failed to initialize host vcpu 4
> Aborted (core dumped)
>
> Backtrace
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> (gdb) bt
> #0  0x0000ffff9106bc80 in __pthread_kill_implementation () at /lib64/libc=
.so.6
> #1  0x0000ffff9101aa40 [PAC] in raise () at /lib64/libc.so.6
> #2  0x0000ffff91005988 [PAC] in abort () at /lib64/libc.so.6
> #3  0x0000aaaab1cc26b8 [PAC] in kvm_arm_create_host_vcpu (cpu=3D0xaaaab9a=
b1bc0)
>      at ../target/arm/kvm.c:1081
> #4  0x0000aaaab1cd0c94 in virt_setup_lazy_vcpu_realization (cpuobj=3D0xaa=
aab9ab1bc0, vms=3D0xaaaab98870a0)
>      at ../hw/arm/virt.c:2483
> #5  0x0000aaaab1cd180c in machvirt_init (machine=3D0xaaaab98870a0) at ../=
hw/arm/virt.c:2777
> #6  0x0000aaaab160f220 in machine_run_board_init
>      (machine=3D0xaaaab98870a0, mem_path=3D0x0, errp=3D0xfffffa86bdc8) at=
 ../hw/core/machine.c:1722
> #7  0x0000aaaab1a25ef4 in qemu_init_board () at ../system/vl.c:2723
> #8  0x0000aaaab1a2635c in qmp_x_exit_preconfig (errp=3D0xaaaab38a50f0 <er=
ror_fatal>)
>      at ../system/vl.c:2821
> #9  0x0000aaaab1a28b08 in qemu_init (argc=3D15, argv=3D0xfffffa86c1f8) at=
 ../system/vl.c:3882
> #10 0x0000aaaab221d9e4 in main (argc=3D15, argv=3D0xfffffa86c1f8) at ../s=
ystem/main.c:71


Thank you for this. Please let me know if the above fix works and also
the return values in
case you encounter errors.

Many thanks!
Salil.


>
> Thanks,
> Gavin
>
> >   /*
> >    * Update KVM's MP_STATE based on what QEMU thinks it is
> >    */
> > @@ -1876,7 +1908,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >           return -EINVAL;
> >       }
> >
> > -    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
> > +    /*
> > +     * Install VM change handler only when vCPU thread has been spawne=
d
> > +     * i.e. vCPU is being realized
> > +     */
> > +    if (cs->thread_id) {
> > +        qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu)=
;
> > +    }
> >
> >       /* Determine init features for this CPU */
> >       memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features))=
;
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index 6a9b6374a6..ec9dc95ee8 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -98,6 +98,17 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu);
> >   void kvm_arm_reset_vcpu(ARMCPU *cpu);
> >
> >   struct kvm_vcpu_init;
> > +
> > +/**
> > + * kvm_arm_create_host_vcpu:
> > + * @cpu: ARMCPU
> > + *
> > + * Called to pre-create possible KVM vCPU within the host during the
> > + * `virt_machine` initialization phase. This pre-created vCPU will be =
parked and
> > + * will be reused when ARM QOM vCPU is actually hotplugged.
> > + */
> > +void kvm_arm_create_host_vcpu(ARMCPU *cpu);
> > +
> >   /**
> >    * kvm_arm_create_scratch_host_vcpu:
> >    * @fdarray: filled in with kvmfd, vmfd, cpufd file descriptors in th=
at order
>

