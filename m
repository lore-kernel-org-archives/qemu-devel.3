Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DACEC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 16:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5wm-0000Yn-32; Wed, 15 Jan 2025 11:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tY5wl-0000YZ-2w
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tY5wi-0005q5-3d
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736957322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNZEV6bbyR4wEAAGmqt214Poc5ofHJcQQ7j3BdDqmvA=;
 b=YjSYSA5qKYoplsTuwrG3D45e0Y7JIWeySABNnxCUbMtfeS1xl28Vc0wppYneS7ZKUZ3dru
 R3W6Vuo7wUacBQ6YF9jMEkiviOfDO/6ouT5niyxJ+ilzWPhgZopkabsQFc9070icckIo7q
 +m3t4s640QTRMRjCXY0s/2fN47FYKxg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-7tIIGW0yNAG-3AOtbRWW2A-1; Wed, 15 Jan 2025 11:08:38 -0500
X-MC-Unique: 7tIIGW0yNAG-3AOtbRWW2A-1
X-Mimecast-MFC-AGG-ID: 7tIIGW0yNAG-3AOtbRWW2A
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso2584369f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 08:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736957317; x=1737562117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yNZEV6bbyR4wEAAGmqt214Poc5ofHJcQQ7j3BdDqmvA=;
 b=hdS2bq7bAmSpGOdYtOOhsC89CkmBwd4Bg87weMmOUX7mQ+EPMxR1Yx7ZCPnmmVmUfx
 ACy1KynUqXxJnr0YyLSUDuD0IjT+zIIjQVW60s2TbWAKytuZbLx1ZWYe9LTm16KGfyUM
 8tWQmGdmHAo7zDV1QLKvRFoT7RZ108awZc3g3EexYT5Dh7XCYHwCtal/ue8kHY/r1yKs
 5dIbAc0tXzmyP3BVKiCH7Un25IkWtbs47afyTzHBMFHvu8On/BjLaKq0tv/QJYlMk4fD
 7hECtNCbnASKTXgfmcwu1L461sbfo7751HhYFQROcNC0OKZ2pK+DsfE+UUxDmf+D61fI
 6hkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMm5la9eJ67Ph2u54AhhpFWfIIwqInnHVADiLyuLy5toi7d8LSLWzwalSg9itatxNnEKmCcsaxFo9h@nongnu.org
X-Gm-Message-State: AOJu0YzZFfepFSDq4sB0f4iUbfCDkcVUTP+YNXH/C2x4AzC1z0YI4pB5
 UJhK6evnWqzV59b1iTGQvXBMjP+vIi9A2ykA2QnR4lx8nZdnRCridSUYz5hz8zpnA07fgrbPUks
 hJEy6gCaQ8Wkh0K3aOcL9eKjM5YdLpR2jrv1BZUvFGklv+CYUgkGGwECtWxoI1h/tSJzoKb7/VO
 XjlL6IQkwbiP7zR2aHEYBhk0M513o=
X-Gm-Gg: ASbGncu6fGo+X0Odu8622iGvPohmp2WedEQtyFmRwHgdtOVpT2iMoO8gmmFmojDNjh/
 +fDSNeT+Ay8pdjxIvguVpLeepvp2uHWLoYHQiWKVQ
X-Received: by 2002:a05:6000:2a9:b0:385:e394:37ed with SMTP id
 ffacd0b85a97d-38a87305463mr25363331f8f.18.1736957316477; 
 Wed, 15 Jan 2025 08:08:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ2x4rAMscphJIrqXFfxdYihn6pBQX3bkoy/2pOBqF9z46BFx3OE9iqp9iIQuYAbAwHfHcgABOJ3NGXRWlZb4=
X-Received: by 2002:a05:6000:2a9:b0:385:e394:37ed with SMTP id
 ffacd0b85a97d-38a87305463mr25363266f8f.18.1736957315893; Wed, 15 Jan 2025
 08:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20241212144918.981542-1-anisinha@redhat.com>
 <CAK3XEhNpe9JVXKOVGM+dxorATzL8kM6u1=CDSfxH_cbpWkx3yQ@mail.gmail.com>
 <20250115083742-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250115083742-mutt-send-email-mst@kernel.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 15 Jan 2025 21:38:24 +0530
X-Gm-Features: AbW1kvY87e3KBJ6ahKSnv5t5RWgdvgs39vMpq6SfxulALAUrxhb2WsoCsQgQCaM
Message-ID: <CAK3XEhNLfSfKVHvLGruBKYH-W3Cy5dk5sz6VVisaEgq3_HUnjg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386/cpu: remove default_cpu_version and simplify
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Zhao Liu <zhao1.liu@intel.com>, imammedo@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

On Wed, Jan 15, 2025 at 7:08=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jan 15, 2025 at 11:33:10AM +0530, Ani Sinha wrote:
> > On Thu, Dec 12, 2024 at 8:19=E2=80=AFPM Ani Sinha <anisinha@redhat.com>=
 wrote:
> > >
> > > commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
> > > introduced 'default_cpu_version' for PCMachineClass. This created thr=
ee
> > > categories of CPU models:
> > >  - Most unversioned CPU models would use version 1 by default.
> > >  - For machines 4.0.1 and older that do not support cpu model aliases=
, a
> > >    special default_cpu_version value of CPU_VERSION_LEGACY is used.
> > >  - It was thought that future machines would use the latest value of =
cpu
> > >    versions corresponding to default_cpu_version value of
> > >    CPU_VERSION_LATEST [1].
> > >
> > > All pc machines still use the default cpu version of 1 for
> > > unversioned cpu models. CPU_VERSION_LATEST is a moving target and
> > > changes with time. Therefore, if machines use CPU_VERSION_LATEST, it =
would
> > > mean that over a period of time, for the same machine type, the cpu v=
ersion
> > > would be different depending on what is latest at that time. This wou=
ld
> > > break guests even when they use a constant machine type. Therefore, f=
or
> > > pc machines, use of CPU_VERSION_LATEST is not possible. Currently, on=
ly
> > > microvms use CPU_VERSION_LATEST.
> > >
> > > This change cleans up the complicated logic around default_cpu_versio=
n
> > > including getting rid of default_cpu_version property itself. A coupl=
e of new
> > > flags are introduced, one for the legacy model for machines 4.0.1 and=
 older
> > > and other for microvms. For older machines, a new pc machine property=
 is
> > > introduced that separates pc machine versions 4.0.1 and older from th=
e newer
> > > machines. 4.0.1 and older machines are scheduled to be deleted toward=
s
> > > end of 2025 since they would be 6 years old by then. At that time, we=
 can
> > > remove all logic around legacy cpus. Microvms are the only machines t=
hat
> > > continue to use the latest cpu version. If this changes later, we can
> > > remove all logic around x86_cpu_model_last_version(). Default cpu ver=
sion
> > > for unversioned cpu models is hardcoded to the value 1 and applies
> > > unconditionally for all pc machine types of version 4.1 and above.
> > >
> > > This change also removes all complications around CPU_VERSION_AUTO
> > > including removal of the value itself.
> > >
> > > 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
> > >
> > > CC: imammedo@redhat.com
> > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >
> > Has this been picked up by anyone?
>
>
> Fails CI:
>
> https://gitlab.com/mstredhat/qemu/-/jobs/8857478218

Ah, very interesting! Subtle issue with the patch which is easily fixed

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 930ffd91b4..a4c64a4e1b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6287,7 +6287,7 @@ static void x86_cpu_apply_version_props(X86CPU
*cpu, X86CPUModel *model)
     const X86CPUVersionDefinition *vdef;
     X86CPUVersion version =3D x86_cpu_model_resolve_version(model);
-    if (use_legacy_cpu) {
+    if (version =3D=3D DEFAULT_CPU_VERSION && use_legacy_cpu) {
         return;
     }
@@ -6317,7 +6317,7 @@ static const CPUCaches
*x86_cpu_get_versioned_cache_info(X86CPU *cpu,
     X86CPUVersion version =3D x86_cpu_model_resolve_version(model);
     const CPUCaches *cache_info =3D model->cpudef->cache_info;
-    if (use_legacy_cpu) {
+    if (version =3D=3D DEFAULT_CPU_VERSION && use_legacy_cpu) {
         return cache_info;
     }

functional test that was failing seems to pass:

$ pyvenv/bin/python3 ../tests/functional/test_x86_cpu_model_versions.py

TAP version 13
ok 1 test_x86_cpu_model_versions.CascadelakeArchCapabilities.test_4_0
ok 2 test_x86_cpu_model_versions.CascadelakeArchCapabilities.test_4_1
ok 3 test_x86_cpu_model_versions.CascadelakeArchCapabilities.test_set_4_0
ok 4 test_x86_cpu_model_versions.CascadelakeArchCapabilities.test_unset_4_1
ok 5 test_x86_cpu_model_versions.CascadelakeArchCapabilities.test_v1_4_0
ok 6 test_x86_cpu_model_versions.CascadelakeArchCapabilities.test_v1_set_4_=
0
ok 7 test_x86_cpu_model_versions.CascadelakeArchCapabilities.test_v2_4_0
ok 8 test_x86_cpu_model_versions.CascadelakeArchCapabilities.test_v2_unset_=
4_1
ok 9 test_x86_cpu_model_versions.X86CPUModelAliases.test_4_0_alias_compatib=
ility
ok 10 test_x86_cpu_model_versions.X86CPUModelAliases.test_4_1_alias
ok 11 test_x86_cpu_model_versions.X86CPUModelAliases.test_none_alias
1..11

Will run some more tests and repost. Thanks!

>
> > > ---
> > >  hw/i386/microvm.c     |  2 +-
> > >  hw/i386/pc_piix.c     |  6 +++---
> > >  hw/i386/pc_q35.c      |  6 +++---
> > >  hw/i386/x86-common.c  | 15 ++++++++++---
> > >  include/hw/i386/pc.h  | 21 +++++++++++++++---
> > >  include/hw/i386/x86.h |  5 ++++-
> > >  target/i386/cpu.c     | 50 +++++++++++++++++++++--------------------=
--
> > >  target/i386/cpu.h     | 21 ++++--------------
> > >  8 files changed, 69 insertions(+), 57 deletions(-)
> > >
> > > changelog:
> > > v2: explain in commit log why use of CPU_VERSION_LATEST for machines
> > > is problematic.
> > >
> > > diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> > > index 86637afa0f..2cbe08caea 100644
> > > --- a/hw/i386/microvm.c
> > > +++ b/hw/i386/microvm.c
> > > @@ -458,7 +458,7 @@ static void microvm_machine_state_init(MachineSta=
te *machine)
> > >
> > >      microvm_memory_init(mms);
> > >
> > > -    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
> > > +    x86_cpus_init_with_latest_cpu_version(x86ms);
> > >
> > >      microvm_devices_init(mms);
> > >  }
> > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > index 2bf6865d40..8e0ab0387f 100644
> > > --- a/hw/i386/pc_piix.c
> > > +++ b/hw/i386/pc_piix.c
> > > @@ -181,7 +181,8 @@ static void pc_init1(MachineState *machine, const=
 char *pci_type)
> > >      }
> > >
> > >      pc_machine_init_sgx_epc(pcms);
> > > -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
> > > +
> > > +    pc_init_cpus(machine);
> > >
> > >      if (kvm_enabled()) {
> > >          kvmclock_create(pcmc->kvmclock_create_always);
> > > @@ -454,7 +455,6 @@ static void pc_i440fx_machine_options(MachineClas=
s *m)
> > >      ObjectClass *oc =3D OBJECT_CLASS(m);
> > >      pcmc->default_south_bridge =3D TYPE_PIIX3_DEVICE;
> > >      pcmc->pci_root_uid =3D 0;
> > > -    pcmc->default_cpu_version =3D 1;
> > >
> > >      m->family =3D "pc_piix";
> > >      m->desc =3D "Standard PC (i440FX + PIIX, 1996)";
> > > @@ -661,7 +661,7 @@ static void pc_i440fx_machine_4_0_options(Machine=
Class *m)
> > >  {
> > >      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> > >      pc_i440fx_machine_4_1_options(m);
> > > -    pcmc->default_cpu_version =3D CPU_VERSION_LEGACY;
> > > +    pcmc->no_versioned_cpu_model =3D true;
> > >      compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_l=
en);
> > >      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_l=
en);
> > >  }
> > > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > > index 8319b6d45e..9a4f14b336 100644
> > > --- a/hw/i386/pc_q35.c
> > > +++ b/hw/i386/pc_q35.c
> > > @@ -187,7 +187,8 @@ static void pc_q35_init(MachineState *machine)
> > >      }
> > >
> > >      pc_machine_init_sgx_epc(pcms);
> > > -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
> > > +
> > > +    pc_init_cpus(machine);
> > >
> > >      if (kvm_enabled()) {
> > >          kvmclock_create(pcmc->kvmclock_create_always);
> > > @@ -336,7 +337,6 @@ static void pc_q35_machine_options(MachineClass *=
m)
> > >  {
> > >      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> > >      pcmc->pci_root_uid =3D 0;
> > > -    pcmc->default_cpu_version =3D 1;
> > >
> > >      m->family =3D "pc_q35";
> > >      m->desc =3D "Standard PC (Q35 + ICH9, 2009)";
> > > @@ -537,7 +537,7 @@ static void pc_q35_machine_4_0_1_options(MachineC=
lass *m)
> > >  {
> > >      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> > >      pc_q35_machine_4_1_options(m);
> > > -    pcmc->default_cpu_version =3D CPU_VERSION_LEGACY;
> > > +    pcmc->no_versioned_cpu_model =3D true;
> > >      /*
> > >       * This is the default machine for the 4.0-stable branch. It is =
basically
> > >       * a 4.0 that doesn't use split irqchip by default. It MUST henc=
e apply the
> > > diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> > > index dc031af662..37dfdb7300 100644
> > > --- a/hw/i386/x86-common.c
> > > +++ b/hw/i386/x86-common.c
> > > @@ -66,15 +66,24 @@ out:
> > >      object_unref(cpu);
> > >  }
> > >
> > > -void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
> > > +void x86_legacy_cpus_init(X86MachineState *x86ms)
> > > +{
> > > +    machine_uses_legacy_cpu();
> > > +    x86_cpus_init(x86ms);
> > > +}
> > > +
> > > +void x86_cpus_init_with_latest_cpu_version(X86MachineState *x86ms)
> > > +{
> > > +    x86_cpu_uses_lastest_version();
> > > +    x86_cpus_init(x86ms);
> > > +}
> > > +void x86_cpus_init(X86MachineState *x86ms)
> > >  {
> > >      int i;
> > >      const CPUArchIdList *possible_cpus;
> > >      MachineState *ms =3D MACHINE(x86ms);
> > >      MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
> > >
> > > -    x86_cpu_set_default_version(default_cpu_version);
> > > -
> > >      /*
> > >       * Calculates the limit to CPU APIC ID values
> > >       *
> > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > index 14ee06287d..b514b957d9 100644
> > > --- a/include/hw/i386/pc.h
> > > +++ b/include/hw/i386/pc.h
> > > @@ -92,9 +92,6 @@ struct PCMachineClass {
> > >
> > >      /* Compat options: */
> > >
> > > -    /* Default CPU model version.  See x86_cpu_set_default_version()=
. */
> > > -    int default_cpu_version;
> > > -
> > >      /* ACPI compat: */
> > >      bool has_acpi_build;
> > >      int pci_root_uid;
> > > @@ -125,11 +122,29 @@ struct PCMachineClass {
> > >       * check for memory.
> > >       */
> > >      bool broken_32bit_mem_addr_check;
> > > +
> > > +    /* whether the machine supports versioned cpu models */
> > > +    bool no_versioned_cpu_model;
> > >  };
> > >
> > >  #define TYPE_PC_MACHINE "generic-pc-machine"
> > >  OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)
> > >
> > > +static inline void pc_init_cpus(MachineState *ms)
> > > +{
> > > +    X86MachineState *x86ms =3D X86_MACHINE(ms);
> > > +    PCMachineState *pcms =3D PC_MACHINE(ms);
> > > +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> > > +
> > > +    if (pcmc->no_versioned_cpu_model) {
> > > +        /* use legacy cpu as it does not support versions */
> > > +        x86_legacy_cpus_init(x86ms);
> > > +    } else {
> > > +        /* use non-legacy cpus */
> > > +        x86_cpus_init(x86ms);
> > > +    }
> > > +}
> > > +
> > >  /* ioapic.c */
> > >
> > >  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
> > > diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> > > index d43cb3908e..a90464f74b 100644
> > > --- a/include/hw/i386/x86.h
> > > +++ b/include/hw/i386/x86.h
> > > @@ -114,7 +114,10 @@ void init_topo_info(X86CPUTopoInfo *topo_info, c=
onst X86MachineState *x86ms);
> > >  uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
> > >                                      unsigned int cpu_index);
> > >
> > > -void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
> > > +void x86_cpus_init(X86MachineState *pcms);
> > > +void x86_legacy_cpus_init(X86MachineState *x86ms);
> > > +void x86_cpus_init_with_latest_cpu_version(X86MachineState *x86ms);
> > > +
> > >  void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
> > >  void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> > >                        DeviceState *dev, Error **errp);
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 3725dbbc4b..14f5aa359b 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -191,6 +191,9 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_des=
criptors[] =3D {
> > >   */
> > >  #define CACHE_DESCRIPTOR_UNAVAILABLE 0xFF
> > >
> > > +/* default cpu version to use */
> > > +#define DEFAULT_CPU_VERSION 1
> > > +
> > >  /*
> > >   * Return a CPUID 2 cache descriptor for a given cache.
> > >   * If no known descriptor is found, return CACHE_DESCRIPTOR_UNAVAILA=
BLE
> > > @@ -5343,20 +5346,16 @@ static const X86CPUDefinition builtin_x86_def=
s[] =3D {
> > >      },
> > >  };
> > >
> > > -/*
> > > - * We resolve CPU model aliases using -v1 when using "-machine
> > > - * none", but this is just for compatibility while libvirt isn't
> > > - * adapted to resolve CPU model versions before creating VMs.
> > > - * See "Runnability guarantee of CPU models" at
> > > - * docs/about/deprecated.rst.
> > > - */
> > > -X86CPUVersion default_cpu_version =3D 1;
> > > +static bool use_legacy_cpu;
> > > +void machine_uses_legacy_cpu(void)
> > > +{
> > > +    use_legacy_cpu =3D true;
> > > +}
> > >
> > > -void x86_cpu_set_default_version(X86CPUVersion version)
> > > +static bool use_last_cpu_version;
> > > +void x86_cpu_uses_lastest_version(void)
> > >  {
> > > -    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make=
 sense */
> > > -    assert(version !=3D CPU_VERSION_AUTO);
> > > -    default_cpu_version =3D version;
> > > +    use_last_cpu_version =3D true;
> > >  }
> > >
> > >  static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *m=
odel)
> > > @@ -5374,14 +5373,11 @@ static X86CPUVersion x86_cpu_model_last_versi=
on(const X86CPUModel *model)
> > >  /* Return the actual version being used for a specific CPU model */
> > >  static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel=
 *model)
> > >  {
> > > -    X86CPUVersion v =3D model->version;
> > > -    if (v =3D=3D CPU_VERSION_AUTO) {
> > > -        v =3D default_cpu_version;
> > > -    }
> > > -    if (v =3D=3D CPU_VERSION_LATEST) {
> > > +    if (use_last_cpu_version) {
> > >          return x86_cpu_model_last_version(model);
> > >      }
> > > -    return v;
> > > +
> > > +    return model->version;
> > >  }
> > >
> > >  static Property max_x86_cpu_properties[] =3D {
> > > @@ -5986,6 +5982,12 @@ static char *x86_cpu_class_get_alias_of(X86CPU=
Class *cc)
> > >      if (!cc->model || !cc->model->is_alias) {
> > >          return NULL;
> > >      }
> > > +
> > > +    if (use_legacy_cpu) {
> > > +        /* legacy cpu models do not support cpu aliases */
> > > +        return NULL;
> > > +    }
> > > +
> > >      version =3D x86_cpu_model_resolve_version(cc->model);
> > >      if (version <=3D 0) {
> > >          return NULL;
> > > @@ -6003,11 +6005,7 @@ static void x86_cpu_list_entry(gpointer data, =
gpointer user_data)
> > >      g_autofree char *model_id =3D x86_cpu_class_get_model_id(cc);
> > >
> > >      if (!desc && alias_of) {
> > > -        if (cc->model && cc->model->version =3D=3D CPU_VERSION_AUTO)=
 {
> > > -            desc =3D g_strdup("(alias configured by machine type)");
> > > -        } else {
> > >              desc =3D g_strdup_printf("(alias of %s)", alias_of);
> > > -        }
> > >      }
> > >      if (!desc && cc->model && cc->model->note) {
> > >          desc =3D g_strdup_printf("%s [%s]", model_id, cc->model->not=
e);
> > > @@ -6114,7 +6112,7 @@ static void x86_cpu_definition_entry(gpointer d=
ata, gpointer user_data)
> > >       * Old machine types won't report aliases, so that alias transla=
tion
> > >       * doesn't break compatibility with previous QEMU versions.
> > >       */
> > > -    if (default_cpu_version !=3D CPU_VERSION_LEGACY) {
> > > +    if (!use_legacy_cpu) {
> > >          info->alias_of =3D x86_cpu_class_get_alias_of(cc);
> > >      }
> > >
> > > @@ -6288,7 +6286,7 @@ static void x86_cpu_apply_version_props(X86CPU =
*cpu, X86CPUModel *model)
> > >      const X86CPUVersionDefinition *vdef;
> > >      X86CPUVersion version =3D x86_cpu_model_resolve_version(model);
> > >
> > > -    if (version =3D=3D CPU_VERSION_LEGACY) {
> > > +    if (use_legacy_cpu) {
> > >          return;
> > >      }
> > >
> > > @@ -6318,7 +6316,7 @@ static const CPUCaches *x86_cpu_get_versioned_c=
ache_info(X86CPU *cpu,
> > >      X86CPUVersion version =3D x86_cpu_model_resolve_version(model);
> > >      const CPUCaches *cache_info =3D model->cpudef->cache_info;
> > >
> > > -    if (version =3D=3D CPU_VERSION_LEGACY) {
> > > +    if (use_legacy_cpu) {
> > >          return cache_info;
> > >      }
> > >
> > > @@ -6453,7 +6451,7 @@ static void x86_register_cpudef_types(const X86=
CPUDefinition *def)
> > >      /* Unversioned model: */
> > >      m =3D g_new0(X86CPUModel, 1);
> > >      m->cpudef =3D def;
> > > -    m->version =3D CPU_VERSION_AUTO;
> > > +    m->version =3D DEFAULT_CPU_VERSION;
> > >      m->is_alias =3D true;
> > >      x86_register_cpu_model_type(def->name, m);
> > >
> > > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > > index 4c239a6970..5ad80c8a97 100644
> > > --- a/target/i386/cpu.h
> > > +++ b/target/i386/cpu.h
> > > @@ -2658,28 +2658,15 @@ void cpu_report_tpr_access(CPUX86State *env, =
TPRAccess access);
> > >  void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
> > >                                     TPRAccess access);
> > >
> > > -/* Special values for X86CPUVersion: */
> > > -
> > > -/* Resolve to latest CPU version */
> > > -#define CPU_VERSION_LATEST -1
> > > -
> > > -/*
> > > - * Resolve to version defined by current machine type.
> > > - * See x86_cpu_set_default_version()
> > > - */
> > > -#define CPU_VERSION_AUTO   -2
> > > -
> > > -/* Don't resolve to any versioned CPU models, like old QEMU versions=
 */
> > > -#define CPU_VERSION_LEGACY  0
> > > -
> > >  typedef int X86CPUVersion;
> > >
> > >  /*
> > > - * Set default CPU model version for CPU models having
> > > - * version =3D=3D CPU_VERSION_AUTO.
> > > + * Set CPU model version to the lastest version.
> > > + * Currently, this is only used by microvm.
> > >   */
> > > -void x86_cpu_set_default_version(X86CPUVersion version);
> > > +void x86_cpu_uses_lastest_version(void);
> > >
> > > +void machine_uses_legacy_cpu(void);
> > >  #ifndef CONFIG_USER_ONLY
> > >
> > >  void do_cpu_sipi(X86CPU *cpu);
> > > --
> > > 2.45.2
> > >
>


