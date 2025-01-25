Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7434BC0218B
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 03:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbWqf-0006O9-2g; Fri, 24 Jan 2025 22:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tbWqd-0006Nw-WE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 22:28:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tbWqb-0000w3-DS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 22:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737775714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3XC2bwi2CpuSIRa01VxPp22FaA7s5HczBlZj8r5WGM=;
 b=PgblGp4MvqMgqLmHsQBbJ53lZRZp+hYB/7y1tPyZGOw+muJuSyEP1jyM2xVzchDfso6v7j
 LCtpA5SRceL61dIWLETzdSIjrEwYrTCDfhVqWaNUcaXEcMV/IGB6/1nRZPUtTQ1FTcV5Q6
 ENsKM++xxoZ5hvYCCEfNL/9JHE3ySJM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-vgaWSx3AOxmgBA3enRQ-9w-1; Fri, 24 Jan 2025 22:28:31 -0500
X-MC-Unique: vgaWSx3AOxmgBA3enRQ-9w-1
X-Mimecast-MFC-AGG-ID: vgaWSx3AOxmgBA3enRQ-9w
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa63b02c69cso338940066b.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 19:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737775709; x=1738380509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3XC2bwi2CpuSIRa01VxPp22FaA7s5HczBlZj8r5WGM=;
 b=mljf7LpKqUfBOUc6FNkeJSRMkL8U2+8GvJwofIxGov4BHEu1L8qbzRThlkWs0eGqpz
 u83Yn/Uw1d783nNx+p4v1VnnQqJmUBrRHOlAbfQGk4KqG3z9HeYTb8mADMTPJx2Ig6qx
 9QsMx5zTllo6JVquh2MMlsLuUzxf6OgSdM7YaIXFXECcklD2xHhzOfmu+V/ueRms+vJ2
 tX6MJ1sy1WijYHWIFXoWEaVGejFioAuUUqBcSBqy/dzE09e9m+E82bByrIsbvCt8IUpT
 8LBmG0uudFegtrw+MNWBT/oiMmdhJd/pzeVS634gZVvMD2/MUpYE7eB0+axcygSgHSLw
 Bz0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB2ONz6svnNyyaUxg7VDPHBXs8Yo8qmFonTod0Ijj3cq7Cwer60eLE1ryQrzi1cPW2X9CbxTK11xK7@nongnu.org
X-Gm-Message-State: AOJu0YyYvo+U4xI2r/XWxz83o9xbGIJZYTjLKWpHFFDZkeTfIPww0nIG
 Na8LuQ6CmfzAwrl5L6fIJDbyHARy+F1CG1O3E24BUaJfOt5fGuDuq8myNxsEWx0QmzvJL0rLjGp
 Om7Bks79dsOgBLgDTzJy1d8P0SUtTSl8Aim9sLM+87ej9k6bjah3lGaMscSWn+LsZSTwFqJGyY2
 K7t1YZcFGbOnCrzL2lh55Kp/1/XF/UQ1aChUefyg==
X-Gm-Gg: ASbGncvtnJbjI56VlQsj11BQULwO7pnTYNZeabl8yWnldEKMkbJtutqIJNYST5Heu7T
 jfuuWsFtTpt6hZNf970E1JnfIJPSYNMkLwVXG0Vo/4wKgpV0nVQxW0sauMyK7628=
X-Received: by 2002:a17:907:9409:b0:ab6:5558:3a69 with SMTP id
 a640c23a62f3a-ab6629fbdefmr949625366b.19.1737775708596; 
 Fri, 24 Jan 2025 19:28:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV+QiwW13BxWpTKE7Iqj1isyebB80mLlhg8c+70Dldh3sklRU5bfdc3D4ZOEalaWbKf5DIe4kORz9f7gZK5Cw=
X-Received: by 2002:a17:907:9409:b0:ab6:5558:3a69 with SMTP id
 a640c23a62f3a-ab6629fbdefmr949623366b.19.1737775708136; Fri, 24 Jan 2025
 19:28:28 -0800 (PST)
MIME-Version: 1.0
References: <20250123115613.1537173-1-anisinha@redhat.com>
 <20250123152215.4142d24e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250123152215.4142d24e@imammedo.users.ipa.redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 25 Jan 2025 08:58:16 +0530
X-Gm-Features: AWEUYZnzUWM_FCPm17gVkI83v03QUbDTHo0yOAMFUUnIn8wzAsRmn53ehEocwWo
Message-ID: <CAK3XEhOXQSL-k22Rq=NQvHB8u-_1wFbgr1hTxpzGG8bxLEVgUQ@mail.gmail.com>
Subject: Re: [PATCH v5] hw/i386/cpu: remove default_cpu_version and simplify
To: Igor Mammedov <imammedo@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 23, 2025 at 7:52=E2=80=AFPM Igor Mammedov <imammedo@redhat.com>=
 wrote:
>
> On Thu, 23 Jan 2025 17:26:12 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>
> > commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
> > introduced 'default_cpu_version' for PCMachineClass. This created three
> > categories of CPU models:
> >  - Most unversioned CPU models would use version 1 by default.
> >  - For machines 4.0.1 and older that do not support cpu model aliases, =
a
> >    special default_cpu_version value of CPU_VERSION_LEGACY is used.
>
>
> Testing current master:
>  =3D=3D=3D=3D
> ./qemu-system-x86_64 -M pc-i440fx-4.0 -cpu Haswell-v4 -monitor stdio
> ...
> (qemu) info hotpluggable-cpus
> Hotpluggable CPUs:
>   type: "Haswell-v4-x86_64-cpu"
>
> we can run versioned on old machine types. with caveat
> not being able to migrate to old qemu that doesn't have it
>
>  =3D=3D=3D=3D
> ./qemu-system-x86_64 -M pc-i440fx-4.0 -cpu Haswell -monitor stdio
> ...
> (qemu) info hotpluggable-cpus
> Hotpluggable CPUs:
>   type: "Haswell-x86_64-cpu"
>
>  =3D=3D=3D=3D
> ./qemu-system-x86_64 -M pc-i440fx-5.0 -cpu Haswell -monitor stdio
> ...
> (qemu) info hotpluggable-cpus
> Hotpluggable CPUs:
>   type: "Haswell-x86_64-cpu"
>
> non-versioned model resolves to the same type regardless of legacy
>
> Do we really have to keep CPU_VERSION_LEGACY code around?
>
> Lets assume we drop all CPU_VERSION_LEGACY code, what would change?

From code, x86_cpu_class_get_alias_of() always returns NULL for
legacy. Maybe somewhere the descriptions are different?

To be safe, I would just wait for another 10 months to drop all legacy stuf=
f.

>
> >  - It was thought that future machines would use the latest value of cp=
u
> >    versions corresponding to default_cpu_version value of
> >    CPU_VERSION_LATEST [1].
> >
> > All pc machines still use the default cpu version of 1 for
> > unversioned cpu models. CPU_VERSION_LATEST is a moving target and
> > changes with time. Therefore, if machines use CPU_VERSION_LATEST, it wo=
uld
> > mean that over a period of time, for the same machine type, the cpu ver=
sion
> > would be different depending on what is latest at that time. This would
> > break guests even when they use a constant machine type. Therefore, for
>                                     ^^^^^^^^^^^^^^^^^^
> s/.../versioned .../
>
> > pc machines, use of CPU_VERSION_LATEST is not possible. Currently, only
> > microvms use CPU_VERSION_LATEST.
> >
> > This change cleans up the complicated logic around default_cpu_version
> > including getting rid of default_cpu_version property itself. A couple =
of new
> > flags are introduced, one for the legacy model for machines 4.0.1 and o=
lder
> > and other for microvms. For older machines, a new pc machine property i=
s
> > introduced that separates pc machine versions 4.0.1 and older from the =
newer
> > machines. 4.0.1 and older machines are scheduled to be deleted towards
> > end of 2025 since they would be 6 years old by then. At that time, we c=
an
> > remove all logic around legacy cpus. Microvms are the only machines tha=
t
> > continue to use the latest cpu version. If this changes later, we can
> > remove all logic around x86_cpu_model_last_version(). Default cpu versi=
on
> > for unversioned cpu models is hardcoded to the value 1 and applies
> > unconditionally for all pc machine types of version 4.1 and above.
> >
> > This change also removes all complications around CPU_VERSION_AUTO
> > including removal of the value itself.
> >
> > 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
> >
> > CC: imammedo@redhat.com
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  hw/i386/microvm.c     |  3 +-
> >  hw/i386/pc.c          | 14 +++++++++
> >  hw/i386/pc_piix.c     |  6 ++--
> >  hw/i386/pc_q35.c      |  6 ++--
> >  hw/i386/x86-common.c  |  4 +--
> >  include/hw/i386/pc.h  |  7 +++--
> >  include/hw/i386/x86.h |  2 +-
> >  target/i386/cpu.c     | 69 ++++++++++++++++++++++---------------------
> >  target/i386/cpu.h     | 21 +++----------
> >  9 files changed, 67 insertions(+), 65 deletions(-)
> >
> > changelog:
> > v2: explain in commit log why use of CPU_VERSION_LATEST for machines
> > is problematic.
> > v3: fix a bug that broke the pipeline
> > https://gitlab.com/mstredhat/qemu/-/pipelines/1626171267
> > when cpu versions are explicitly specified in the command line,
> > respect that and do not enforce legacy (unversioned) cpu logic.
> > The pipeline is green now with the fix:
> > https://gitlab.com/anisinha/qemu/-/pipelines/1626783632
> > v4: made changes as per Zhao's suggestions.
> > Pipeline passes https://gitlab.com/anisinha/qemu/-/pipelines/1635829877
> > v5: adjustment of pc_init_cpus() declaration as per Zhao's suggestion. =
This
> > simplifies things and also passes compilation.
> > CI still passes https://gitlab.com/anisinha/qemu/-/pipelines/1637657451
> >
> > diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> > index a8d354aabe..ffb1b37fe5 100644
> > --- a/hw/i386/microvm.c
> > +++ b/hw/i386/microvm.c
> > @@ -458,7 +458,8 @@ static void microvm_machine_state_init(MachineState=
 *machine)
> >
> >      microvm_memory_init(mms);
> >
> > -    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
> > +    x86_cpu_uses_lastest_version();
> > +    x86_cpus_init(x86ms);
> >
> >      microvm_devices_init(mms);
> >  }
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index b46975c8a4..f97a519573 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -30,6 +30,7 @@
> >  #include "hw/hyperv/hv-balloon.h"
> >  #include "hw/i386/fw_cfg.h"
> >  #include "hw/i386/vmport.h"
> > +#include "target/i386/cpu.h"
> >  #include "system/cpus.h"
> >  #include "hw/ide/ide-bus.h"
> >  #include "hw/timer/hpet.h"
> > @@ -615,6 +616,19 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, =
int level)
> >      }
> >  }
> >
> > +void pc_init_cpus(MachineState *ms)
> > +{
> > +    X86MachineState *x86ms =3D X86_MACHINE(ms);
> > +    PCMachineState *pcms =3D PC_MACHINE(ms);
> > +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> > +
> > +    if (pcmc->no_versioned_cpu_model) {
> > +        /* use legacy cpu as it does not support versions */
> > +        x86_cpu_set_legacy_version();
> > +    }
> > +    x86_cpus_init(x86ms);
> > +}
> > +
> >  static
> >  void pc_machine_done(Notifier *notifier, void *data)
> >  {
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 04d2957adc..dc684cb011 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -181,7 +181,8 @@ static void pc_init1(MachineState *machine, const c=
har *pci_type)
> >      }
> >
> >      pc_machine_init_sgx_epc(pcms);
> > -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
> > +
> > +    pc_init_cpus(machine);
> >
> >      if (kvm_enabled()) {
> >          kvmclock_create(pcmc->kvmclock_create_always);
> > @@ -457,7 +458,6 @@ static void pc_i440fx_machine_options(MachineClass =
*m)
> >      ObjectClass *oc =3D OBJECT_CLASS(m);
> >      pcmc->default_south_bridge =3D TYPE_PIIX3_DEVICE;
> >      pcmc->pci_root_uid =3D 0;
> > -    pcmc->default_cpu_version =3D 1;
> >
> >      m->family =3D "pc_piix";
> >      m->desc =3D "Standard PC (i440FX + PIIX, 1996)";
> > @@ -669,7 +669,7 @@ static void pc_i440fx_machine_4_0_options(MachineCl=
ass *m)
> >  {
> >      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> >      pc_i440fx_machine_4_1_options(m);
> > -    pcmc->default_cpu_version =3D CPU_VERSION_LEGACY;
> > +    pcmc->no_versioned_cpu_model =3D true;
> >      compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len=
);
> >      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len=
);
> >  }
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 77536dd697..045b05da64 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -187,7 +187,8 @@ static void pc_q35_init(MachineState *machine)
> >      }
> >
> >      pc_machine_init_sgx_epc(pcms);
> > -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
> > +
> > +    pc_init_cpus(machine);
> >
> >      if (kvm_enabled()) {
> >          kvmclock_create(pcmc->kvmclock_create_always);
> > @@ -339,7 +340,6 @@ static void pc_q35_machine_options(MachineClass *m)
> >  {
> >      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> >      pcmc->pci_root_uid =3D 0;
> > -    pcmc->default_cpu_version =3D 1;
> >
> >      m->family =3D "pc_q35";
> >      m->desc =3D "Standard PC (Q35 + ICH9, 2009)";
> > @@ -547,7 +547,7 @@ static void pc_q35_machine_4_0_1_options(MachineCla=
ss *m)
> >  {
> >      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> >      pc_q35_machine_4_1_options(m);
> > -    pcmc->default_cpu_version =3D CPU_VERSION_LEGACY;
> > +    pcmc->no_versioned_cpu_model =3D true;
> >      /*
> >       * This is the default machine for the 4.0-stable branch. It is ba=
sically
> >       * a 4.0 that doesn't use split irqchip by default. It MUST hence =
apply the
> > diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> > index 008496b5b8..1ed5bc6010 100644
> > --- a/hw/i386/x86-common.c
> > +++ b/hw/i386/x86-common.c
> > @@ -66,15 +66,13 @@ out:
> >      object_unref(cpu);
> >  }
> >
> > -void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
> > +void x86_cpus_init(X86MachineState *x86ms)
> >  {
> >      int i;
> >      const CPUArchIdList *possible_cpus;
> >      MachineState *ms =3D MACHINE(x86ms);
> >      MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
> >
> > -    x86_cpu_set_default_version(default_cpu_version);
> > -
> >      /*
> >       * Calculates the limit to CPU APIC ID values
> >       *
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index a558705cb9..563f765d7f 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -92,9 +92,6 @@ struct PCMachineClass {
> >
> >      /* Compat options: */
> >
> > -    /* Default CPU model version.  See x86_cpu_set_default_version(). =
*/
> > -    int default_cpu_version;
> > -
> >      /* ACPI compat: */
> >      bool has_acpi_build;
> >      int pci_root_uid;
> > @@ -125,6 +122,9 @@ struct PCMachineClass {
> >       * check for memory.
> >       */
> >      bool broken_32bit_mem_addr_check;
> > +
> > +    /* whether the machine supports versioned cpu models */
> > +    bool no_versioned_cpu_model;
> >  };
> >
> >  #define TYPE_PC_MACHINE "generic-pc-machine"
> > @@ -136,6 +136,7 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_e=
nabled);
> >
> >  /* pc.c */
> >
> > +void pc_init_cpus(MachineState *ms);
> >  void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
> >
> >  #define PCI_HOST_PROP_RAM_MEM          "ram-mem"
> > diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> > index d43cb3908e..2d2b987fa1 100644
> > --- a/include/hw/i386/x86.h
> > +++ b/include/hw/i386/x86.h
> > @@ -114,7 +114,7 @@ void init_topo_info(X86CPUTopoInfo *topo_info, cons=
t X86MachineState *x86ms);
> >  uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
> >                                      unsigned int cpu_index);
> >
> > -void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
> > +void x86_cpus_init(X86MachineState *pcms);
> >  void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
> >  void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >                        DeviceState *dev, Error **errp);
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 1b9c11022c..c1f868c4dd 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -192,6 +192,9 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descr=
iptors[] =3D {
> >   */
> >  #define CACHE_DESCRIPTOR_UNAVAILABLE 0xFF
> >
> > +/* default cpu version to use */
> > +#define DEFAULT_CPU_VERSION 1
> > +
> >  /*
> >   * Return a CPUID 2 cache descriptor for a given cache.
> >   * If no known descriptor is found, return CACHE_DESCRIPTOR_UNAVAILABL=
E
> > @@ -5343,20 +5346,16 @@ static const X86CPUDefinition builtin_x86_defs[=
] =3D {
> >      },
> >  };
> >
> > -/*
> > - * We resolve CPU model aliases using -v1 when using "-machine
> > - * none", but this is just for compatibility while libvirt isn't
> > - * adapted to resolve CPU model versions before creating VMs.
> > - * See "Runnability guarantee of CPU models" at
> > - * docs/about/deprecated.rst.
> > - */
> > -X86CPUVersion default_cpu_version =3D 1;
> > +static bool use_legacy_cpu;
> > +void x86_cpu_set_legacy_version(void)
> > +{
> > +    use_legacy_cpu =3D true;
> > +}
> >
> > -void x86_cpu_set_default_version(X86CPUVersion version)
> > +static bool use_latest_cpu;
> > +void x86_cpu_uses_lastest_version(void)
> >  {
> > -    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make s=
ense */
> > -    assert(version !=3D CPU_VERSION_AUTO);
> > -    default_cpu_version =3D version;
> > +    use_latest_cpu =3D true;
> >  }
> >
> >  static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *mod=
el)
> > @@ -5374,14 +5373,11 @@ static X86CPUVersion x86_cpu_model_last_version=
(const X86CPUModel *model)
> >  /* Return the actual version being used for a specific CPU model */
> >  static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *=
model)
> >  {
> > -    X86CPUVersion v =3D model->version;
> > -    if (v =3D=3D CPU_VERSION_AUTO) {
> > -        v =3D default_cpu_version;
> > -    }
> > -    if (v =3D=3D CPU_VERSION_LATEST) {
> > +    if (use_latest_cpu) {
> >          return x86_cpu_model_last_version(model);
> >      }
> > -    return v;
> > +
> > +    return model->version;
> >  }
> >
> >  static const Property max_x86_cpu_properties[] =3D {
> > @@ -5985,10 +5981,15 @@ static char *x86_cpu_class_get_alias_of(X86CPUC=
lass *cc)
> >      if (!cc->model || !cc->model->is_alias) {
> >          return NULL;
> >      }
> > -    version =3D x86_cpu_model_resolve_version(cc->model);
> > -    if (version <=3D 0) {
> > +
> > +    if (use_legacy_cpu) {
> > +        /* legacy cpu models do not support cpu aliases */
> >          return NULL;
> >      }
> > +
> > +    version =3D x86_cpu_model_resolve_version(cc->model);
> > +    assert(version);
> > +
> >      return x86_cpu_versioned_model_name(cc->model->cpudef, version);
> >  }
> >
> > @@ -6002,11 +6003,7 @@ static void x86_cpu_list_entry(gpointer data, gp=
ointer user_data)
> >      g_autofree char *model_id =3D x86_cpu_class_get_model_id(cc);
> >
> >      if (!desc && alias_of) {
> > -        if (cc->model && cc->model->version =3D=3D CPU_VERSION_AUTO) {
> > -            desc =3D g_strdup("(alias configured by machine type)");
> > -        } else {
> >              desc =3D g_strdup_printf("(alias of %s)", alias_of);
> > -        }
> >      }
> >      if (!desc && cc->model && cc->model->note) {
> >          desc =3D g_strdup_printf("%s [%s]", model_id, cc->model->note)=
;
> > @@ -6109,13 +6106,8 @@ static void x86_cpu_definition_entry(gpointer da=
ta, gpointer user_data)
> >      } else {
> >          info->deprecated =3D false;
> >      }
> > -    /*
> > -     * Old machine types won't report aliases, so that alias translati=
on
> > -     * doesn't break compatibility with previous QEMU versions.
> > -     */
> > -    if (default_cpu_version !=3D CPU_VERSION_LEGACY) {
> > -        info->alias_of =3D x86_cpu_class_get_alias_of(cc);
> > -    }
> > +
> > +    info->alias_of =3D x86_cpu_class_get_alias_of(cc);
> >
> >      QAPI_LIST_PREPEND(*cpu_list, info);
> >  }
> > @@ -6287,7 +6279,12 @@ static void x86_cpu_apply_version_props(X86CPU *=
cpu, X86CPUModel *model)
> >      const X86CPUVersionDefinition *vdef;
> >      X86CPUVersion version =3D x86_cpu_model_resolve_version(model);
> >
> > -    if (version =3D=3D CPU_VERSION_LEGACY) {
> > +    /*
> > +     * if the machine uses legacy cpus, use legacy cpus with no versio=
ns
> > +     * when no explict CPU versions are specified in the CPU definitio=
n
> > +     * passed from the command line.
> > +     */
> > +    if (version =3D=3D DEFAULT_CPU_VERSION && use_legacy_cpu) {
> >          return;
> >      }
> >
> > @@ -6317,7 +6314,11 @@ static const CPUCaches *x86_cpu_get_versioned_ca=
che_info(X86CPU *cpu,
> >      X86CPUVersion version =3D x86_cpu_model_resolve_version(model);
> >      const CPUCaches *cache_info =3D model->cpudef->cache_info;
> >
> > -    if (version =3D=3D CPU_VERSION_LEGACY) {
> > +    /*
> > +     * If machine supports legacy cpus and no explicit cpu versions ar=
e
> > +     * specified, use the cache from the unversioned cpu definition.
> > +     */
> > +    if (version =3D=3D DEFAULT_CPU_VERSION && use_legacy_cpu) {
> >          return cache_info;
> >      }
> >
> > @@ -6452,7 +6453,7 @@ static void x86_register_cpudef_types(const X86CP=
UDefinition *def)
> >      /* Unversioned model: */
> >      m =3D g_new0(X86CPUModel, 1);
> >      m->cpudef =3D def;
> > -    m->version =3D CPU_VERSION_AUTO;
> > +    m->version =3D DEFAULT_CPU_VERSION;
> >      m->is_alias =3D true;
> >      x86_register_cpu_model_type(def->name, m);
> >
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index b26e25ba15..bdbe54b26f 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -2679,27 +2679,14 @@ void cpu_report_tpr_access(CPUX86State *env, TP=
RAccess access);
> >  void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
> >                                     TPRAccess access);
> >
> > -/* Special values for X86CPUVersion: */
> > -
> > -/* Resolve to latest CPU version */
> > -#define CPU_VERSION_LATEST -1
> > -
> > -/*
> > - * Resolve to version defined by current machine type.
> > - * See x86_cpu_set_default_version()
> > - */
> > -#define CPU_VERSION_AUTO   -2
> > -
> > -/* Don't resolve to any versioned CPU models, like old QEMU versions *=
/
> > -#define CPU_VERSION_LEGACY  0
> > -
> >  typedef int X86CPUVersion;
> >
> >  /*
> > - * Set default CPU model version for CPU models having
> > - * version =3D=3D CPU_VERSION_AUTO.
> > + * Set CPU model version to the lastest version.
> > + * Currently, this is only used by microvm.
> >   */
> > -void x86_cpu_set_default_version(X86CPUVersion version);
> > +void x86_cpu_uses_lastest_version(void);
> > +void x86_cpu_set_legacy_version(void);
> >
> >  #ifndef CONFIG_USER_ONLY
> >
>


