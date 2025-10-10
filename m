Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3991BCCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 03:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v73c3-00024R-Gd; Thu, 09 Oct 2025 23:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v73c0-000230-P4
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:16:09 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v73bu-0007QS-IV
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:16:07 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-30cce872d9cso1121513fac.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 20:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1760066156; x=1760670956; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WrGY7pQhf7viHLOc4nGJ3PBr/8dvl3VzOqhYCDsy3i0=;
 b=LeYJCC6H4kqGwOr12HDNgvf5RqJ/YXHsjuD4oxlrHWI900ha8e1AAhSEA99oasA9Qr
 yZ2mwdCDaE0d5m2jpumqIGtiMZhUw64s8dTHUQnGVXMsqmUptGz5BHGJH1MW5ZhghB3K
 PkWkNTervsglwa2VbsL9qYqzw7VCxqwgvpeIlwSokuWvfTFXoYmSJrNP65atvmCg/OKz
 ylrCIlks7wpHElwAQmyT6axSkA8JaZgKGu+SGe1gob2FK1BskZKQOrfwfZumeaHSqXmQ
 WU0V4hznrx6QAMLaxSQD+j/Gv6gMQ3fj4PvjSoPug42XV2vx4MJGSpl1nhxzr3Vvyto7
 cvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760066156; x=1760670956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WrGY7pQhf7viHLOc4nGJ3PBr/8dvl3VzOqhYCDsy3i0=;
 b=cD2hlFv6sRi5lwpUhRkeJqxW8sx7Ngq3DhF6E/LOm53GqlvNNulzSvxhOSodZ825N6
 J8sG0+lD+sDL71idSLgGpPFGVvc7qW82Vh+E/5HGvIA0Ri00xoTDEUfFD64405XQOm6f
 obnubeS8cLuprq8nneJA7iDeC3w/kuDrcQYezjLoIdwosCNgtwPq6c62i4izeQD1tL5B
 ggkGfLoIavv2JFQPPfGtEGS2jS5WB3MTOiwsTeGhGgVYHrpu2VmbhUQK6ayI4EYMQ4IC
 w8pvHGShwHmH/BfornbQxvH+pvfneoM70/CaTlmE+ZLy7t7HY9ZjSzzVxwIhrE2cNoja
 WC2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw/KHiz3V5mUynsFUzAoMkvXgdbmnD4HLpJhJ3SWgwHhbCm7qdPnqEtyuqI+Yx1oDrbbKZzSrvVvjS@nongnu.org
X-Gm-Message-State: AOJu0Yy0CxReFLSm47ZqeBRdjdxrieVSIgvGKV1GCtVTzzCMfSeLTy5a
 BlEuE0VUazL+MLd7CL2qEzId5r0eYkRMXKnRBz4vcxkhe+kYS6RDf+Ma6ql+u/5BS4Rhgh7cmOm
 HObTYq4HNOSZxSYSVz77uVshfPAZj/MRDjh6cuDxxiCK3M49k9V4tPpln2g==
X-Gm-Gg: ASbGncsvwQWw12jyrtT9Lys/LcAQOv/wQ0DRFrLdRGiP/brGHwRLYAQR6OgSjgH/o2+
 R0PERO9/kynAlFK3+x4RJhPjcsiwEdfqdwk16YXbGi5F5syCfLRU9zhZ3kiEfARRFxDELY2En4M
 XhfGBo6eWTVAohctZBo1moQUvDa4jVn5JYNVWLNbY3d+lhr3VEETAywYbA0OZZSdY3XKVfaJcXq
 vJeQSTbx8ehxIICYRuvberB7Xidg7qwsKQsbfcsu7N6NSBWEh6/g/Ybqkmljgblpxzjp9bu/wkv
 HRzZs3rTL3rVkxlkfA==
X-Google-Smtp-Source: AGHT+IGbs5CZdj+DkHVuGVM2+H2z53v0R3MBIlNeKwAxLSM8QeG9b3xvC6SH7x78L2aDl/ZxKV//jVg7k4Gwr98FcKk=
X-Received: by 2002:a05:6870:8114:b0:36d:535f:830c with SMTP id
 586e51a60fabf-3c0f6af2706mr4476494fac.17.1760066156490; Thu, 09 Oct 2025
 20:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-12-salil.mehta@opnsrc.net>
 <20251003170908.48070061@fedora>
 <0175e40f70424dd9a29389b8a4f16c42@huawei.com> <20251007142016.3ed85bff@fedora>
In-Reply-To: <20251007142016.3ed85bff@fedora>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Fri, 10 Oct 2025 03:15:45 +0000
X-Gm-Features: AS18NWBK4f6T6cw8NtI3bjCooy0-QY3JbqFpVEeq6Z7Tji4KZE6FjQoHFxZ4emY
Message-ID: <CAJ7pxeYjCUmDZ8j=WryrezLQvWCo4Siww-=vJZ59nA3Fhgm4xA@mail.gmail.com>
Subject: Re: [PATCH RFC V6 11/24] hw/arm/acpi: MADT change to size the guest
 with possible vCPUs
To: Igor Mammedov <imammedo@redhat.com>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "maz@kernel.org" <maz@kernel.org>, 
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "armbru@redhat.com" <armbru@redhat.com>, 
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>, 
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>, 
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>, 
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>, 
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>, 
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>, 
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>, 
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, 
 Linuxarm <linuxarm@huawei.com>, "jiakernel2@gmail.com" <jiakernel2@gmail.com>, 
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, 
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="00000000000009ffa70640c55614"
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000009ffa70640c55614
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

On Tue, Oct 7, 2025 at 12:20=E2=80=AFPM Igor Mammedov <imammedo@redhat.com>=
 wrote:

> On Tue, 7 Oct 2025 11:34:48 +0000
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
> > Hi Igor,
> >
> > > From: Igor Mammedov <imammedo@redhat.com>
> > > Sent: Friday, October 3, 2025 4:09 PM
> > > To: salil.mehta@opnsrc.net
> > >
> > > On Wed,  1 Oct 2025 01:01:14 +0000
> > > salil.mehta@opnsrc.net wrote:
> > >
> > > > From: Salil Mehta <salil.mehta@huawei.com>
> > > >
> > > > When QEMU builds the MADT table, modifications are needed to includ=
e
> > > > information about possible vCPUs that are exposed as ACPI-disabled
> (i.e.,
> > > `_STA.Enabled=3D0`).
> > > > This new information will help the guest kernel pre-size its
> resources
> > > > during boot time. Pre-sizing based on possible vCPUs will facilitat=
e
> > > > the future hot-plugging of the currently disabled vCPUs.
> > > >
> > > > Additionally, this change addresses updates to the ACPI MADT GIC CP=
U
> > > > interface flags, as introduced in the UEFI ACPI 6.5 specification
> [1].
> > > > These updates enable deferred virtual CPU onlining in the guest
> kernel.
> > > >
> > > > Reference:
> > > > [1] 5.2.12.14. GIC CPU Interface (GICC) Structure (Table 5.37 GICC
> CPU
> > > Interface Flags)
> > > >     Link:
> > > >
> > > https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.h
> > > tm
> > > > l#gic-cpu-interface-gicc-structure
> > > >
> > > > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > > > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > > > ---
> > > >  hw/arm/virt-acpi-build.c | 40 ++++++++++++++++++++++++++++++++++-
> > > -----
> > > >  hw/core/machine.c        | 14 ++++++++++++++
> > > >  include/hw/boards.h      | 20 ++++++++++++++++++++
> > > >  3 files changed, 68 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index
> > > > b01fc4f8ef..7c24dd6369 100644
> > > > --- a/hw/arm/virt-acpi-build.c
> > > > +++ b/hw/arm/virt-acpi-build.c
> > > > @@ -760,6 +760,32 @@ static void build_append_gicr(GArray
> *table_data,
> > > uint64_t base, uint32_t size)
> > > >      build_append_int_noprefix(table_data, size, 4); /* Discovery
> > > > Range Length */  }
> > > >
> > > > +static uint32_t virt_acpi_get_gicc_flags(CPUState *cpu) {
> > > > +    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> > > > +    const uint32_t GICC_FLAG_ENABLED =3D BIT(0);
> > > > +    const uint32_t GICC_FLAG_ONLINE_CAPABLE =3D BIT(3);
> > > > +
> > > > +    /* ARM architecture does not support vCPU hotplug yet */
> > > > +    if (!cpu) {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    /*
> > > > +     * If the machine does not support online-capable CPUs, report
> the
> > > GICC as
> > > > +     * 'enabled' only.
> > > > +     */
> > > > +    if (!mc->has_online_capable_cpus) {
> > > > +        return GICC_FLAG_ENABLED;
> > > > +    }
> > > > +
> > > > +    /*
> > > > +     * ACPI 6.5, 5.2.12.14 (GICC): mark the boot CPU 'enabled' and
> all others
> > > > +     * 'online-capable'.
> > > > +     */
> > > > +    return (cpu =3D=3D first_cpu) ? GICC_FLAG_ENABLED :
> > > > +GICC_FLAG_ONLINE_CAPABLE; }
> > > > +
> > > >  static void
> > > >  build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineStat=
e
> > > > *vms)  { @@ -785,12 +811,14 @@ build_madt(GArray *table_data,
> > > > BIOSLinker *linker, VirtMachineState *vms)
> > > >      build_append_int_noprefix(table_data, vms->gic_version, 1);
> > > >      build_append_int_noprefix(table_data, 0, 3);   /* Reserved */
> > > >
> > > > -    for (i =3D 0; i < MACHINE(vms)->smp.cpus; i++) {
> > > > -        ARMCPU *armcpu =3D ARM_CPU(qemu_get_cpu(i));
> > > > +    for (i =3D 0; i < MACHINE(vms)->smp.max_cpus; i++) {
> > >                                      ^^^^^^^^^^^^
> > > > +        CPUState *cpu =3D machine_get_possible_cpu(i);
> > > ...
> > > > +        CPUArchId *archid =3D machine_get_possible_cpu_arch_id(i);
> > >
> > > what complexity above adds? /and then you say creating instantiating
> ARM
> > > VM is slow./
> > >
> > > I'd drop machine_get_possible_cpu/machine_get_possible_cpu_arch_id
> > > altogether and mimic what acpi_build_madt() does.
> >
> >
> > We can do that here but I need this function elsewhere in the monitor
> code as well
> > to iterate over the possible CPUs and if I remember correctly I was
> getting compilation
> > errors there. But I will check if this can be removed.
> >
> > I would like to keep machine_get_possible_cpu().
>
> if you did iteration with this helper over CPUs, you'd basically
> introducing
> ^2 complexity at that point.
> But that's details, we will sort it out eventually.
>

Sure. you might be right here. I do not intend to disagree. I'll surely
look into it.

Thanks for this.


>
> >
> > I think you've misunderstood the reason of the boot time delay mentione=
d
> to you in RFC V5.
> > It is because of the realization leg i.e. qdev_relaize(), of the vCPU
> and not because of this
> > initialization leg
>
> I did misunderstood wrt slow vcpus creation.
>

No issues


> I did object to lazy creation in general, and well I still dislike it.
>

For sure, and I respect your apprehensions. I want to understand the
technical reasons why
you think having this approach could be problematic?

We have used this because:
1. It will drastically change the boot time on 500+ core system. In fact
boot time becomes
    constant almost independent of the core count. I had previous even
share the numbers
    for this in the KVM Forum 2023 conference slides
2.  Just for this series RFC V6, we have a bigger problem in leaving
disabled vCPUs threads
     running. These add to the KVM Lock contention during VM initialization
time and cpu_reset()
     can fail due to failure in ICC_CTLR_EL1 fetch.

Point 2 is a blocker.


> For more on this topic see my reply to cover letter, let continue
> discussion there
> about that.
>

sure, I will later today.

Sorry, for the gaps in my replies. My mails are either not reaching the
mailing list and
the people or I'm not receiving them. For legal reasons we must make
technical discussion
public so I'm refraining to reply from official ID till this problem gets
identified.

The discussion otherwise appears under broken links defeating the
traceability part. Later
is a legal requirement.

I've been told lore.kernel server is rejecting the emails. I don't know
whom to contact?


>
> >
> >
> > >
> > > > +        uint32_t flags =3D virt_acpi_get_gicc_flags(cpu);
> > > > +        uint64_t mpidr =3D archid->arch_id;
> > > >
> > > >          if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
> > > >              physical_base_address =3D memmap[VIRT_GIC_CPU].base; @=
@
> > > > -805,7 +833,7 @@ build_madt(GArray *table_data, BIOSLinker *linker,
> > > VirtMachineState *vms)
> > > >          build_append_int_noprefix(table_data, i, 4);    /* GIC ID =
*/
> > > >          build_append_int_noprefix(table_data, i, 4);    /* ACPI
> Processor UID
> > > */
> > > >          /* Flags */
> > > > -        build_append_int_noprefix(table_data, 1, 4);    /* Enabled
> */
> > > > +        build_append_int_noprefix(table_data, flags, 4);
> > > >          /* Parking Protocol Version */
> > > >          build_append_int_noprefix(table_data, 0, 4);
> > > >          /* Performance Interrupt GSIV */ @@ -819,7 +847,7 @@
> > > > build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState
> > > *vms)
> > > >          build_append_int_noprefix(table_data, vgic_interrupt, 4);
> > > >          build_append_int_noprefix(table_data, 0, 8);    /* GICR
> Base
> > > Address*/
> > > >          /* MPIDR */
> > > > -        build_append_int_noprefix(table_data,
> > > arm_cpu_mp_affinity(armcpu), 8);
> > > > +        build_append_int_noprefix(table_data, mpidr, 8);
> > > >          /* Processor Power Efficiency Class */
> > > >          build_append_int_noprefix(table_data, 0, 1);
> > > >          /* Reserved */
> > > > diff --git a/hw/core/machine.c b/hw/core/machine.c index
> > > > 69d5632464..65388d859a 100644
> > > > --- a/hw/core/machine.c
> > > > +++ b/hw/core/machine.c
> > > > @@ -1383,6 +1383,20 @@ CPUState *machine_get_possible_cpu(int64_t
> > > cpu_index)
> > > >      return NULL;
> > > >  }
> > > >
> > > > +CPUArchId *machine_get_possible_cpu_arch_id(int64_t cpu_index) {
> > > > +    MachineState *ms =3D MACHINE(qdev_get_machine());
> > > > +    CPUArchIdList *possible_cpus =3D ms->possible_cpus;
> > > > +
> > > > +    for (int i =3D 0; i < possible_cpus->len; i++) {
> > > > +        if (possible_cpus->cpus[i].cpu &&
> > > > +            possible_cpus->cpus[i].cpu->cpu_index =3D=3D cpu_index=
) {
> > > > +            return &possible_cpus->cpus[i];
> > > > +        }
> > > > +    }
> > > > +    return NULL;
> > > > +}
> > > > +
> > > >  static char *cpu_slot_to_string(const CPUArchId *cpu)  {
> > > >      GString *s =3D g_string_new(NULL);
> > > > diff --git a/include/hw/boards.h b/include/hw/boards.h index
> > > > 3ff77a8b3a..fe51ca58bf 100644
> > > > --- a/include/hw/boards.h
> > > > +++ b/include/hw/boards.h
> > > > @@ -461,6 +461,26 @@ struct MachineState {
> > > >      bool acpi_spcr_enabled;
> > > >  };
> > > >
> > > > +/*
> > > > + * machine_get_possible_cpu_arch_id:
> > > > + * @cpu_index: logical cpu_index to search for
> > > > + *
> > > > + * Return a pointer to the CPUArchId entry matching the given
> > > > +@cpu_index
> > > > + * in the current machine's MachineState. The possible_cpus array
> > > > +holds
> > > > + * the full set of CPUs that the machine could support, including
> > > > +those
> > > > + * that may be created as disabled or taken offline.
> > > > + *
> > > > + * The slot index in ms->possible_cpus[] is always sequential, but
> > > > +the
> > > > + * logical cpu_index values are assigned by QEMU and may or may no=
t
> > > > +be
> > > > + * sequential depending on the implementation of a particular
> machine.
> > > > + * Direct indexing by cpu_index is therefore unsafe in general. Th=
is
> > > > + * helper performs a linear search of the possible_cpus array to
> find
> > > > + * the matching entry.
> > > > + *
> > > > + * Returns: pointer to the matching CPUArchId, or NULL if not foun=
d.
> > > > + */
> > > > +CPUArchId *machine_get_possible_cpu_arch_id(int64_t cpu_index);
> > > > +
> > > >  /*
> > > >   * The macros which follow are intended to facilitate the
> > > >   * definition of versioned machine types, using a somewhat
> > >
> >
>
>

--00000000000009ffa70640c55614
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Igor,</div><br><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct=
 7, 2025 at 12:20=E2=80=AFPM Igor Mammedov &lt;<a href=3D"mailto:imammedo@r=
edhat.com">imammedo@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Tue, 7 Oct 2025 11:34:48 +0000<br>
Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.com" target=3D"_blank"=
>salil.mehta@huawei.com</a>&gt; wrote:<br>
<br>
&gt; Hi Igor,<br>
&gt; <br>
&gt; &gt; From: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" ta=
rget=3D"_blank">imammedo@redhat.com</a>&gt;<br>
&gt; &gt; Sent: Friday, October 3, 2025 4:09 PM<br>
&gt; &gt; To: <a href=3D"mailto:salil.mehta@opnsrc.net" target=3D"_blank">s=
alil.mehta@opnsrc.net</a><br>
&gt; &gt; <br>
&gt; &gt; On Wed,=C2=A0 1 Oct 2025 01:01:14 +0000<br>
&gt; &gt; <a href=3D"mailto:salil.mehta@opnsrc.net" target=3D"_blank">salil=
.mehta@opnsrc.net</a> wrote:<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt; &gt; From: Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.c=
om" target=3D"_blank">salil.mehta@huawei.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; When QEMU builds the MADT table, modifications are needed to=
 include<br>
&gt; &gt; &gt; information about possible vCPUs that are exposed as ACPI-di=
sabled (i.e.,=C2=A0 <br>
&gt; &gt; `_STA.Enabled=3D0`).=C2=A0 <br>
&gt; &gt; &gt; This new information will help the guest kernel pre-size its=
 resources<br>
&gt; &gt; &gt; during boot time. Pre-sizing based on possible vCPUs will fa=
cilitate<br>
&gt; &gt; &gt; the future hot-plugging of the currently disabled vCPUs.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Additionally, this change addresses updates to the ACPI MADT=
 GIC CPU<br>
&gt; &gt; &gt; interface flags, as introduced in the UEFI ACPI 6.5 specific=
ation [1].<br>
&gt; &gt; &gt; These updates enable deferred virtual CPU onlining in the gu=
est kernel.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Reference:<br>
&gt; &gt; &gt; [1] 5.2.12.14. GIC CPU Interface (GICC) Structure (Table 5.3=
7 GICC CPU=C2=A0 <br>
&gt; &gt; Interface Flags)=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0Link:<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; <a href=3D"https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Progr=
amming_Model.h" rel=3D"noreferrer" target=3D"_blank">https://uefi.org/specs=
/ACPI/6.5/05_ACPI_Software_Programming_Model.h</a><br>
&gt; &gt; tm=C2=A0 <br>
&gt; &gt; &gt; l#gic-cpu-interface-gicc-structure<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Co-developed-by: Keqian Zhu &lt;<a href=3D"mailto:zhukeqian1=
@huawei.com" target=3D"_blank">zhukeqian1@huawei.com</a>&gt;<br>
&gt; &gt; &gt; Signed-off-by: Keqian Zhu &lt;<a href=3D"mailto:zhukeqian1@h=
uawei.com" target=3D"_blank">zhukeqian1@huawei.com</a>&gt;<br>
&gt; &gt; &gt; Signed-off-by: Salil Mehta &lt;<a href=3D"mailto:salil.mehta=
@huawei.com" target=3D"_blank">salil.mehta@huawei.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 hw/arm/virt-acpi-build.c | 40 ++++++++++++++++++++++++=
++++++++++-=C2=A0 <br>
&gt; &gt; -----=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 hw/core/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 ++++=
++++++++++<br>
&gt; &gt; &gt;=C2=A0 include/hw/boards.h=C2=A0 =C2=A0 =C2=A0 | 20 +++++++++=
+++++++++++<br>
&gt; &gt; &gt;=C2=A0 3 files changed, 68 insertions(+), 6 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-bui=
ld.c index<br>
&gt; &gt; &gt; b01fc4f8ef..7c24dd6369 100644<br>
&gt; &gt; &gt; --- a/hw/arm/virt-acpi-build.c<br>
&gt; &gt; &gt; +++ b/hw/arm/virt-acpi-build.c<br>
&gt; &gt; &gt; @@ -760,6 +760,32 @@ static void build_append_gicr(GArray *t=
able_data,=C2=A0 <br>
&gt; &gt; uint64_t base, uint32_t size)=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(table_data, si=
ze, 4); /* Discovery<br>
&gt; &gt; &gt; Range Length */=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +static uint32_t virt_acpi_get_gicc_flags(CPUState *cpu) {<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_GET_CLASS(qdev_g=
et_machine());<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 const uint32_t GICC_FLAG_ENABLED =3D BIT(0);<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 const uint32_t GICC_FLAG_ONLINE_CAPABLE =3D B=
IT(3);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* ARM architecture does not support vCPU hot=
plug yet */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!cpu) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* If the machine does not support onlin=
e-capable CPUs, report the=C2=A0 <br>
&gt; &gt; GICC as=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* &#39;enabled&#39; only.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!mc-&gt;has_online_capable_cpus) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return GICC_FLAG_ENABLED;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* ACPI 6.5, 5.2.12.14 (GICC): mark the =
boot CPU &#39;enabled&#39; and all others<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* &#39;online-capable&#39;.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return (cpu =3D=3D first_cpu) ? GICC_FLAG_ENA=
BLED :<br>
&gt; &gt; &gt; +GICC_FLAG_ONLINE_CAPABLE; }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 static void<br>
&gt; &gt; &gt;=C2=A0 build_madt(GArray *table_data, BIOSLinker *linker, Vir=
tMachineState<br>
&gt; &gt; &gt; *vms)=C2=A0 { @@ -785,12 +811,14 @@ build_madt(GArray *table=
_data,<br>
&gt; &gt; &gt; BIOSLinker *linker, VirtMachineState *vms)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(table_data, vm=
s-&gt;gic_version, 1);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(table_data, 0,=
 3);=C2=A0 =C2=A0/* Reserved */<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; MACHINE(vms)-&gt;smp.cpu=
s; i++) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ARMCPU *armcpu =3D ARM_CPU(qemu=
_get_cpu(i));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; MACHINE(vms)-&gt;smp.max=
_cpus; i++) {=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^=
^^^^=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUState *cpu =3D machine_get_p=
ossible_cpu(i);=C2=A0 <br>
&gt; &gt; ...=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUArchId *archid =3D machine_g=
et_possible_cpu_arch_id(i);=C2=A0 <br>
&gt; &gt; <br>
&gt; &gt; what complexity above adds? /and then you say creating instantiat=
ing ARM<br>
&gt; &gt; VM is slow./<br>
&gt; &gt; <br>
&gt; &gt; I&#39;d drop machine_get_possible_cpu/machine_get_possible_cpu_ar=
ch_id<br>
&gt; &gt; altogether and mimic what acpi_build_madt() does.=C2=A0 <br>
&gt; <br>
&gt; <br>
&gt; We can do that here but I need this function elsewhere in the monitor =
code as well<br>
&gt; to iterate over the possible CPUs and if I remember correctly I was ge=
tting compilation<br>
&gt; errors there. But I will check if this can be removed.<br>
&gt; <br>
&gt; I would like to keep machine_get_possible_cpu().<br>
<br>
if you did iteration with this helper over CPUs, you&#39;d basically introd=
ucing<br>
^2 complexity at that point.<br>
But that&#39;s details, we will sort it out eventually.<br></blockquote><di=
v><br></div><div>Sure. you might be right here. I do not intend=C2=A0to dis=
agree. I&#39;ll surely look into it.</div><div><br></div><div>Thanks for th=
is.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt; <br>
&gt; I think you&#39;ve misunderstood the reason of the boot time delay men=
tioned to you in RFC V5.<br>
&gt; It is because of the realization leg i.e. qdev_relaize(), of the vCPU =
and not because of this<br>
&gt; initialization leg<br>
<br>
I did misunderstood wrt slow vcpus creation.<br></blockquote><div><br></div=
><div>No issues</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
I did object to lazy creation in general, and well I still dislike it.<br><=
/blockquote><div><br></div><div>For sure, and I respect your apprehensions.=
 I want to understand the technical reasons why</div><div>you think having =
this approach could be problematic?</div><div><br></div><div>We have used t=
his because:</div><div>1. It will drastically change the boot time on 500+ =
core system. In fact boot time becomes</div><div>=C2=A0 =C2=A0 constant alm=
ost independent=C2=A0of the core count. I had previous even share the numbe=
rs</div><div>=C2=A0 =C2=A0 for this in the KVM Forum 2023 conference slides=
</div><div>2.=C2=A0 Just for this series RFC V6, we have a bigger problem i=
n leaving disabled vCPUs threads</div><div>=C2=A0 =C2=A0 =C2=A0running. The=
se add to the KVM Lock contention during VM initialization time and cpu_res=
et()</div><div>=C2=A0 =C2=A0 =C2=A0can fail due to failure in ICC_CTLR_EL1 =
fetch.</div><div><br></div><div>Point 2 is a blocker.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
For more on this topic see my reply to cover letter, let continue discussio=
n there<br>
about that.<br></blockquote><div><br></div><div>sure, I will later today.</=
div><div><br></div><div>Sorry, for the gaps in my replies. My mails are eit=
her not reaching the mailing list and</div><div>the people or I&#39;m not r=
eceiving them. For legal reasons we must make technical discussion</div><di=
v>public so I&#39;m refraining to reply from official ID till this problem =
gets identified.</div><div><br></div><div>The discussion otherwise appears =
under broken links defeating the traceability part. Later</div><div>is a le=
gal requirement.</div><div><br></div><div>I&#39;ve been told lore.kernel se=
rver is rejecting the emails. I don&#39;t=C2=A0know whom to contact?</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t flags =3D virt_acpi_ge=
t_gicc_flags(cpu);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t mpidr =3D archid-&gt;a=
rch_id;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vms-&gt;gic_version =
=3D=3D VIRT_GIC_VERSION_2) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 physical_bas=
e_address =3D memmap[VIRT_GIC_CPU].base; @@<br>
&gt; &gt; &gt; -805,7 +833,7 @@ build_madt(GArray *table_data, BIOSLinker *=
linker,=C2=A0 <br>
&gt; &gt; VirtMachineState *vms)=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(=
table_data, i, 4);=C2=A0 =C2=A0 /* GIC ID */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(=
table_data, i, 4);=C2=A0 =C2=A0 /* ACPI Processor UID=C2=A0 <br>
&gt; &gt; */=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Flags */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(table=
_data, 1, 4);=C2=A0 =C2=A0 /* Enabled */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(table=
_data, flags, 4);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Parking Protocol Versio=
n */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(=
table_data, 0, 4);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Performance Interrupt G=
SIV */ @@ -819,7 +847,7 @@<br>
&gt; &gt; &gt; build_madt(GArray *table_data, BIOSLinker *linker, VirtMachi=
neState=C2=A0 <br>
&gt; &gt; *vms)=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(=
table_data, vgic_interrupt, 4);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(=
table_data, 0, 8);=C2=A0 =C2=A0 /* GICR Base=C2=A0 <br>
&gt; &gt; Address*/=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* MPIDR */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(table=
_data,=C2=A0 <br>
&gt; &gt; arm_cpu_mp_affinity(armcpu), 8);=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(table=
_data, mpidr, 8);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Processor Power Efficie=
ncy Class */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_append_int_noprefix(=
table_data, 0, 1);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reserved */<br>
&gt; &gt; &gt; diff --git a/hw/core/machine.c b/hw/core/machine.c index<br>
&gt; &gt; &gt; 69d5632464..65388d859a 100644<br>
&gt; &gt; &gt; --- a/hw/core/machine.c<br>
&gt; &gt; &gt; +++ b/hw/core/machine.c<br>
&gt; &gt; &gt; @@ -1383,6 +1383,20 @@ CPUState *machine_get_possible_cpu(in=
t64_t=C2=A0 <br>
&gt; &gt; cpu_index)=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +CPUArchId *machine_get_possible_cpu_arch_id(int64_t cpu_ind=
ex) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(qdev_get_machine=
());<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 CPUArchIdList *possible_cpus =3D ms-&gt;possi=
ble_cpus;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; possible_cpus-&gt;le=
n; i++) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (possible_cpus-&gt;cpus[i].c=
pu &amp;&amp;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 possible_cpus-&gt=
;cpus[i].cpu-&gt;cpu_index =3D=3D cpu_index) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;possi=
ble_cpus-&gt;cpus[i];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 static char *cpu_slot_to_string(const CPUArchId *cpu)=
=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 GString *s =3D g_string_new(NULL);<br>
&gt; &gt; &gt; diff --git a/include/hw/boards.h b/include/hw/boards.h index=
<br>
&gt; &gt; &gt; 3ff77a8b3a..fe51ca58bf 100644<br>
&gt; &gt; &gt; --- a/include/hw/boards.h<br>
&gt; &gt; &gt; +++ b/include/hw/boards.h<br>
&gt; &gt; &gt; @@ -461,6 +461,26 @@ struct MachineState {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool acpi_spcr_enabled;<br>
&gt; &gt; &gt;=C2=A0 };<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; + * machine_get_possible_cpu_arch_id:<br>
&gt; &gt; &gt; + * @cpu_index: logical cpu_index to search for<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Return a pointer to the CPUArchId entry matching the giv=
en<br>
&gt; &gt; &gt; +@cpu_index<br>
&gt; &gt; &gt; + * in the current machine&#39;s MachineState. The possible_=
cpus array<br>
&gt; &gt; &gt; +holds<br>
&gt; &gt; &gt; + * the full set of CPUs that the machine could support, inc=
luding<br>
&gt; &gt; &gt; +those<br>
&gt; &gt; &gt; + * that may be created as disabled or taken offline.<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * The slot index in ms-&gt;possible_cpus[] is always seque=
ntial, but<br>
&gt; &gt; &gt; +the<br>
&gt; &gt; &gt; + * logical cpu_index values are assigned by QEMU and may or=
 may not<br>
&gt; &gt; &gt; +be<br>
&gt; &gt; &gt; + * sequential depending on the implementation of a particul=
ar machine.<br>
&gt; &gt; &gt; + * Direct indexing by cpu_index is therefore unsafe in gene=
ral. This<br>
&gt; &gt; &gt; + * helper performs a linear search of the possible_cpus arr=
ay to find<br>
&gt; &gt; &gt; + * the matching entry.<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Returns: pointer to the matching CPUArchId, or NULL if n=
ot found.<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +CPUArchId *machine_get_possible_cpu_arch_id(int64_t cpu_ind=
ex);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 /*<br>
&gt; &gt; &gt;=C2=A0 =C2=A0* The macros which follow are intended to facili=
tate the<br>
&gt; &gt; &gt;=C2=A0 =C2=A0* definition of versioned machine types, using a=
 somewhat=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000009ffa70640c55614--

