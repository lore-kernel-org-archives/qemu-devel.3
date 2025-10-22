Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACFACCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 18:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBdv5-00055d-62; Wed, 22 Oct 2025 14:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vBduf-0004wg-N8
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:50:23 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vBduZ-0004gP-O2
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:50:17 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7827025e548so3045066a34.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1761159014; x=1761763814; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqfHJCnZouYNAO9FGWFhlqlueSll8zJSraA3bDe8KTs=;
 b=g29QwOcN3zumx/ViBa+goYmQ553K/ZDMGFghh3nK5yj9XCTs78jSG2HX9dvkk1iFYF
 AYFdupObf5Wvke816UV5LwN94YWUbvzFWT/Uz0BYM47ogIcZPVaEOmDJ3VTdXYNtoZhu
 k8MtQ5Ybf8y5FMvthOGy24Zl2fd1bu3CVTkaVwSXEl537ollw1dcULY5QQxmvhPFzMVM
 zGe0IjLOcHNgAHeyOZJ4cn4zLRFk1xskv3l3952woj4X4HhAux4pGp7fSwl18WooBnHV
 MarwRR949UP8lnGKltZqd0z+vQ+LTAUDe2xRGeFdlSz90Dn9LwYmGaMkPlQUVaBkRP7v
 7qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761159014; x=1761763814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqfHJCnZouYNAO9FGWFhlqlueSll8zJSraA3bDe8KTs=;
 b=qyXF0SlatGGwt8cL68Qdw+WdIc3gtZhnYycemCl6SlgARe9pqxFxeATDVW0Gn61eIn
 77brHvpvPMVlDWvwdDQ5/qB2kpGBEEx+neicYdqjApZkXrJx/uPEheilLNEvCbOHNYor
 WK0HgxzhRL3OUqaNCG1gOEAZ3BqpqNtH6kAHgxAHccQ4894iMCeHPztpRCVC0ebVcUxz
 mZZCvOF78/4BCsRvO4jgBWwwLoeN6osTfEBQvaY8acF1vXHT1Z0hSbhNcGmgPPvX0CZ5
 CyXEVEm/+rVQNtLSNgioKcZpHfKB771NrYD8pWAM/Bt5GyvXWsS/p+SkHH12X6L3inQ2
 BtHQ==
X-Gm-Message-State: AOJu0Ywd87TSlXp1Dqp6E0Iqn4oZiyEo4pj2wbq583rxSaR1S+dExe5H
 d6tj2FyImBYvg1PR401O/GT0cVhRQHSABLI9QEf7u3eTeRi/HIUWR3JAzO7qMtSpAKBQcjHH22u
 uJW2A+dIuImW0cdfMdTT9oo+y6hfo1eeWF6gu5hjrYA==
X-Gm-Gg: ASbGncu5iTCLuN8AijhEwmHrc7oUls2Nbv2c6PFh2kRd0tONA1/L6XjYs1isb2fTTVe
 XEaYtEGu95TxjD/qjIHc4kL5QVdSLNA/DQfBskXWokgd+8fY9ozC1wrlZdC9sCHQR9EyU5j55qw
 UURAoyF6SqrO7AO8nRqeFF+xOLjEdsa8znk0qMLBZOW5km3uV8uxbBodRLoUiGIrl+Y8pv/4CNT
 9lhZLgl77DS15pza0kytc1J97aniqIlgXmsnLOwYZYb/Uz33CJfaJmINM5plyeSrgDj/4quLXaQ
 Ru0cFLctLiNG2vCsPgVo9gJlV+8gkVWlw+AJMEC5eTt34Y14AMfkVSteRlNmytE=
X-Google-Smtp-Source: AGHT+IGgR0uNtM/o8uQ+1SdxbmpfSSEEmSjiPu6pwwDyZ9ith1vSnfNevNAUXDrb2OUGfRQ6jGXtIbnO4Pkf57jIwAY=
X-Received: by 2002:a05:6870:c08f:b0:374:c57d:2c7f with SMTP id
 586e51a60fabf-3c98d13543bmr8369321fac.25.1761159014119; Wed, 22 Oct 2025
 11:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-6-salil.mehta@opnsrc.net>
 <a03ed205-b61a-4bba-9f25-83663b7d8a86@redhat.com>
 <CAJ7pxeYurHLqj8GnLrfznmofMpsaw91GeZ3KMyucL0B_gn9gPg@mail.gmail.com>
In-Reply-To: <CAJ7pxeYurHLqj8GnLrfznmofMpsaw91GeZ3KMyucL0B_gn9gPg@mail.gmail.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Wed, 22 Oct 2025 18:50:02 +0000
X-Gm-Features: AS18NWDKCHeJ_cAZi2sgEARiuXc3-VJghr1fixk648AX6B599j3MEArtMpLMM68
Message-ID: <CAJ7pxeaUfUeXwtTVheCTxej-aCTCx0n8-XyAKaFneVUjcWL_7w@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Gavin,

On Wed, Oct 22, 2025 at 6:18=E2=80=AFPM Salil Mehta <salil.mehta@opnsrc.net=
> wrote:
>
> Hi Gavin,
>
> On Wed, Oct 22, 2025 at 10:37=E2=80=AFAM Gavin Shan <gshan@redhat.com> wr=
ote:
> >
> > Hi Salil,
> >
> > On 10/1/25 11:01 AM, salil.mehta@opnsrc.net wrote:
> > > From: Salil Mehta <salil.mehta@huawei.com>
> > >
> > > ARM CPU architecture does not allow CPUs to be plugged after system h=
as
> > > initialized. This is a constraint. Hence, the Kernel must know all th=
e CPUs
> > > being booted during its initialization. This applies to the Guest Ker=
nel as
> > > well and therefore, the number of KVM vCPU descriptors in the host mu=
st be
> > > fixed at VM initialization time.
> > >
> > > Also, the GIC must know all the CPUs it is connected to during its
> > > initialization, and this cannot change afterward. This must also be e=
nsured
> > > during the initialization of the VGIC in KVM. This is necessary becau=
se:
> > >
> > > 1. The association between GICR and MPIDR must be fixed at VM initial=
ization
> > >     time. This is represented by the register
> > >     `GICR_TYPER(mp_affinity, proc_num)`.
> > > 2. Memory regions associated with GICR, etc., cannot be changed (adde=
d,
> > >     deleted, or modified) after the VM has been initialized. This is =
not an
> > >     ARM architectural constraint but rather invites a difficult and m=
essy
> > >     change in VGIC data structures.
> > >
> > > To enable a hot-add=E2=80=93like model while preserving these constra=
ints, the virt
> > > machine may enumerate more CPUs than are enabled at boot using
> > > `-smp disabledcpus=3DN`. Such CPUs are present but start offline (i.e=
.,
> > > administratively disabled at init). The topology remains fixed at VM
> > > creation time; only the online/offline status may change later.
> > >
> > > Administratively disabled vCPUs are not realized in QOM until first e=
nabled,
> > > avoiding creation of unnecessary vCPU threads at boot. On large syste=
ms, this
> > > reduces startup time proportionally to the number of disabled vCPUs. =
Once a
> > > QOM vCPU is realized and its thread created, subsequent enable/disabl=
e actions
> > > do not unrealize it. This behaviour was adopted following review feed=
back and
> > > differs from earlier RFC versions.
> > >
> > > Co-developed-by: Keqian Zhu <zhuqian1@huawei.com>
> > > Signed-off-by: Keqian Zhu <zhuqian1@huawei.com>
> > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > > ---
> > >   accel/kvm/kvm-all.c    |  2 +-
> > >   hw/arm/virt.c          | 77 ++++++++++++++++++++++++++++++++++++++-=
---
> > >   hw/core/qdev.c         | 17 ++++++++++
> > >   include/hw/qdev-core.h | 19 +++++++++++
> > >   include/system/kvm.h   |  8 +++++
> > >   target/arm/cpu.c       |  2 ++
> > >   target/arm/kvm.c       | 40 +++++++++++++++++++++-
> > >   target/arm/kvm_arm.h   | 11 ++++++
> > >   8 files changed, 168 insertions(+), 8 deletions(-)
> > >

[...]

> > > +void kvm_arm_create_host_vcpu(ARMCPU *cpu)
> > > +{
> > > +    CPUState *cs =3D CPU(cpu);
> > > +    unsigned long vcpu_id =3D cs->cpu_index;
> > > +    int ret;
> > > +
> > > +    ret =3D kvm_create_vcpu(cs);
> > > +    if (ret < 0) {
> > > +        error_report("Failed to create host vcpu %ld", vcpu_id);
> > > +        abort();
> > > +    }
> > > +
> > > +    /*
> > > +     * Initialize the vCPU in the host. This will reset the sys regs
> > > +     * for this vCPU and related registers like MPIDR_EL1 etc. also
> > > +     * get programmed during this call to host. These are referenced
> > > +     * later while setting device attributes of the GICR during GICv=
3
> > > +     * reset.
> > > +     */
> > > +    ret =3D kvm_arch_init_vcpu(cs);
> > > +    if (ret < 0) {
> > > +        error_report("Failed to initialize host vcpu %ld", vcpu_id);
> > > +        abort();
> > > +    }
> > > +
> > > +    /*
> > > +     * park the created vCPU. shall be used during kvm_get_vcpu() wh=
en
> > > +     * threads are created during realization of ARM vCPUs.
> > > +     */
> > > +    kvm_park_vcpu(cs);
> > > +}
> > > +
> >
> > I don't think we're able to simply call kvm_arch_init_vcpu() in the laz=
ily realized
> > path. Otherwise, it can trigger a crash dump on my Nvidia's grace-hoppe=
r machine where
> > SVE is supported by default.
>
> Thanks for reporting this. That is not true. As long as we initialize
> KVM correctly and
> finalize the features like SVE we should be fine. In fact, this is
> precisely what we are
> doing right now.
>
> To understand the crash, I need a bit more info.
>
> 1#  is happening because KVM_ARM_VCPU_INIT is failing. If yes, the can yo=
u check
>       within the KVM if it is happening because
>      a.  features specified by QEMU are not matching the defaults within =
the KVM
>            (HInt: check kvm_vcpu_init_check_features())?
>      b. or complaining about init feate change kvm_vcpu_init_changed()?
> 2#  or it is happening during the setting of vector length or
> finalizing features?
>
> int kvm_arch_init_vcpu(CPUState *cs)
> {
>    [...]
>          /* Do KVM_ARM_VCPU_INIT ioctl */
>         ret =3D kvm_arm_vcpu_init(cpu);   ---->[1]
>         if (ret) {
>            return ret;
>        }
>           if (cpu_isar_feature(aa64_sve, cpu)) {
>         ret =3D kvm_arm_sve_set_vls(cpu); ---->[2]
>         if (ret) {
>             return ret;
>         }
>         ret =3D kvm_arm_vcpu_finalize(cpu, KVM_ARM_VCPU_SVE);--->[3]
>         if (ret) {
>             return ret;
>         }
>     }
> [...]
> }
>
> I think it's happening because vector length is going uninitialized.
> This initialization
> happens in context to  arm_cpu_finalize_features() which I forgot to call=
 before
> calling KVM finalize.
>
> >
> > kvm_arch_init_vcpu() is supposed to be called in the realization path i=
n current
> > implementation (without this series) because the parameters (features) =
to KVM_ARM_VCPU_INIT
> > is populated at vCPU realization time.
>
> Not necessarily. It is just meant to initialize the KVM. If we take care =
of the
> KVM requirements in the similar way the realize path does we should be
> fine. Can you try to add the patch below in your code and test if it work=
s?
>
>  diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index c4b68a0b17..1091593478 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1068,6 +1068,9 @@ void kvm_arm_create_host_vcpu(ARMCPU *cpu)
>          abort();
>      }
>
> +     /* finalize the features like SVE, SME etc */
> +     arm_cpu_finalize_features(cpu, &error_abort);
> +
>      /*
>       * Initialize the vCPU in the host. This will reset the sys regs
>       * for this vCPU and related registers like MPIDR_EL1 etc. also
>
>
>
>
> >
> > $ home/gavin/sandbox/qemu.main/build/qemu-system-aarch64           \
> >    --enable-kvm -machine virt,gic-version=3D3 -cpu host               \
> >    -smp cpus=3D4,disabledcpus=3D2 -m 1024M                             =
 \
> >    -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image    \
> >    -initrd /home/gavin/sandbox/images/rootfs.cpio.xz -nographic
> > qemu-system-aarch64: Failed to initialize host vcpu 4
> > Aborted (core dumped)
> >
> > Backtrace
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > (gdb) bt
> > #0  0x0000ffff9106bc80 in __pthread_kill_implementation () at /lib64/li=
bc.so.6
> > #1  0x0000ffff9101aa40 [PAC] in raise () at /lib64/libc.so.6
> > #2  0x0000ffff91005988 [PAC] in abort () at /lib64/libc.so.6
> > #3  0x0000aaaab1cc26b8 [PAC] in kvm_arm_create_host_vcpu (cpu=3D0xaaaab=
9ab1bc0)
> >      at ../target/arm/kvm.c:1081
> > #4  0x0000aaaab1cd0c94 in virt_setup_lazy_vcpu_realization (cpuobj=3D0x=
aaaab9ab1bc0, vms=3D0xaaaab98870a0)
> >      at ../hw/arm/virt.c:2483
> > #5  0x0000aaaab1cd180c in machvirt_init (machine=3D0xaaaab98870a0) at .=
./hw/arm/virt.c:2777
> > #6  0x0000aaaab160f220 in machine_run_board_init
> >      (machine=3D0xaaaab98870a0, mem_path=3D0x0, errp=3D0xfffffa86bdc8) =
at ../hw/core/machine.c:1722
> > #7  0x0000aaaab1a25ef4 in qemu_init_board () at ../system/vl.c:2723
> > #8  0x0000aaaab1a2635c in qmp_x_exit_preconfig (errp=3D0xaaaab38a50f0 <=
error_fatal>)
> >      at ../system/vl.c:2821
> > #9  0x0000aaaab1a28b08 in qemu_init (argc=3D15, argv=3D0xfffffa86c1f8) =
at ../system/vl.c:3882
> > #10 0x0000aaaab221d9e4 in main (argc=3D15, argv=3D0xfffffa86c1f8) at ..=
/system/main.c:71
>
>
> Thank you for this. Please let me know if the above fix works and also
> the return values in
> case you encounter errors.

I've pushed the fix to below branch for your convenience:

Branch: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v6=
.2
Fix: https://github.com/salil-mehta/qemu/commit/1f1fbc0998ffb1fe26140df3c33=
6bf2be2aa8669

Thanks
Salil.

