Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A420C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1V6-0004fb-8K; Fri, 30 May 2025 11:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uL1V3-0004Zk-JI
 for qemu-devel@nongnu.org; Fri, 30 May 2025 11:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uL1V0-0003GG-4a
 for qemu-devel@nongnu.org; Fri, 30 May 2025 11:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748618299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvgyK8oIx2NKgP8MLQYldutIr76Qpg4CUDezm89xMWQ=;
 b=N0quD81NV8yqIZBTl1CdEZcTSlqPpFGQtc5uVDFiLlGUNQckUgxhSUijklzaDno3bpP3Cv
 9WX0INmju4nCpGyysU3txpECwxaj/iSKPjXsOczwKaRRWc+7/oMB0nN2jYOyIJNpegV6nD
 FcM0pnml9zQ2xK5CWRpIK7NYrtecTlU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-WjkHUNVyP6iPwcgIFfZpcw-1; Fri, 30 May 2025 11:18:18 -0400
X-MC-Unique: WjkHUNVyP6iPwcgIFfZpcw-1
X-Mimecast-MFC-AGG-ID: WjkHUNVyP6iPwcgIFfZpcw_1748618297
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b1442e039eeso1459384a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 08:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748618297; x=1749223097;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvgyK8oIx2NKgP8MLQYldutIr76Qpg4CUDezm89xMWQ=;
 b=eH6NucvEBU73kgsGjTTBBJF8Qxo1NBPInODfVqWtouydo1lXuiDDdg20saq3vnf98F
 ALckwfPppOXo0W9j5Xv5aKzwF6/3A6T7L7vM3rWEtfe1oPW4OaRp6G0i86Krk3A7lkUc
 0UKQlBGMIfRCFXVNojGzAVpD0X8R0dJ0HbCBaMGLTgIyWfZzJ2I88ZeLDAkUsMRo541X
 2Ilf/iQ70JCeYrsRrHdpOHUUYGHsZZYmg4JiexaMv2QHUYoKfiR7YQLyw8BGBhuu4Xxm
 yMzlRaGI6JEtxNXbwF7lSLL4HhFXUqO24Owk28BgNESRWPXQnAGpA3uaj0Irlj/am5Va
 qaxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYXJqLuh+7lwet1ZsTkQLuk1oJE9tByWbihw6cv6T6y3GvUgJ1oN9+rA9u2fojJT/DCkxBiGaEhTOW@nongnu.org
X-Gm-Message-State: AOJu0YzuHOAi0G4b6vqSBsqLUTxKL1JnbrB23E++qWqJxaZusmDrEQke
 KaGLAVISzRRO714atHTEQbkYda6tJ1lQzDbWKWaSeHJAxc+5VuuAudKhMEmrGHOPiwi2jrN7/d6
 45Hk7dSsP9xqmbIsEDwH+z/X5QdrW3hyiFYU/bhSkK3BRDC2G0MZEDZKMaiyYgN2upck=
X-Gm-Gg: ASbGncvhGaesm6wOwEiV1UlwuOdAQFkpwSDDnUhMLiLoh1Tb/FAInMYYWkGBHv8/T3R
 YUcuYLyAt8Nra+RQs+j5xTs/vwRBCzeLJVVeHRTRy3ABCeUWUJ5ePZM9TrqkFKvD00yVPNwUgEm
 VOc+Si5kGLe0yQAgIiXOyWJiqb8DwM1RmuGCNwKTK0lSufMEBvHrCep/el3Ws4B2j0rBrmoZh7y
 Y3uzYR7N/OXIZSA+n6I6gFiezxz7Nj5io9EoQ+iv/wZUf23IuzBik4lC+NrFggpAZ3I8dDujkuu
 ERMRU79mqP8lGTdVmi5BmV4N59k=
X-Received: by 2002:a17:902:e806:b0:234:f182:a734 with SMTP id
 d9443c01a7336-23529a10c9fmr56643935ad.31.1748618296524; 
 Fri, 30 May 2025 08:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz1xDK4IivjHci2cvH0UfTQ+btYoLKko2Z3OymxCkfjwz3uepw93Ny4goz4eqOFgDj1X/dZQ==
X-Received: by 2002:a17:902:e806:b0:234:f182:a734 with SMTP id
 d9443c01a7336-23529a10c9fmr56643295ad.31.1748618295878; 
 Fri, 30 May 2025 08:18:15 -0700 (PDT)
Received: from smtpclient.apple ([110.225.20.38])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bdb54esm29557005ad.69.2025.05.30.08.18.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 May 2025 08:18:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.4\))
Subject: Re: [PATCH v7] hw/i386/cpu: remove default_cpu_version and simplify
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20250530170705.31927dd8@imammedo.users.ipa.redhat.com>
Date: Fri, 30 May 2025 20:48:00 +0530
Cc: Michael Tsirkin <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FBA9E494-6706-4406-9E1F-3DE37FDD8C6A@redhat.com>
References: <20250307102329.556260-1-anisinha@redhat.com>
 <20250511093927-mutt-send-email-mst@kernel.org>
 <20250530170705.31927dd8@imammedo.users.ipa.redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 30 May 2025, at 8:37=E2=80=AFPM, Igor Mammedov =
<imammedo@redhat.com> wrote:
>=20
> On Sun, 11 May 2025 09:40:08 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
>> On Fri, Mar 07, 2025 at 03:53:28PM +0530, Ani Sinha wrote:
>>> commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be =
aliases")
>>> introduced 'default_cpu_version' for PCMachineClass. This created =
three
>>> categories of CPU models:
>>> - Most unversioned CPU models would use version 1 by default.
>>> - For machines 4.0.1 and older that do not support cpu model =
aliases, a
>>>   special default_cpu_version value of CPU_VERSION_LEGACY is used.
>>> - It was thought that future machines would use the latest value of =
cpu
>>>   versions corresponding to default_cpu_version value of
>>>   CPU_VERSION_LATEST [1].
>>>=20
>>> All pc machines still use the default cpu version of 1 for
>>> unversioned cpu models. Use of CPU_VERSION_LATEST was removed in =
[2].
>>>=20
>>> This change cleans up the complicated logic around =
default_cpu_version
>>> including getting rid of default_cpu_version property itself. One =
new
>>> flag is introduced for the legacy model for machines 4.0.1 and =
older.
>>> For older machines, a new pc machine property is
>>> introduced that separates pc machine versions 4.0.1 and older from =
the newer
>>> machines. 4.0.1 and older machines are scheduled to be deleted =
towards
>>> end of 2025 since they would be 6 years old by then. At that time, =
we can
>>> remove all logic around legacy cpus.
>>> This change also removes all complications around CPU_VERSION_AUTO
>>> including removal of the value itself.
>>>=20
>>> 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
>>> 2) See commit XXX ("microvm: do not use the lastest cpu version")
>>>=20
>>> CC: imammedo@redhat.com
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com> =20
>>=20
>> Anyone merging this? If so:
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Presumably cpu stuff goes via Paolo's tree.
>=20
> This cleanup should go together with=20
> 1) "[PATCH v2] microvm: do not use the lastest cpu version"
> https://lists.nongnu.org/archive/html/qemu-devel/2025-03/msg00094.html
> that I and Intel folks (arguably the single user of microvm) acked.
>=20
> Ani,
>   would this patch work with without [1]?=20

No.

>=20
>=20
>=20
>>=20
>>> ---
>>> hw/i386/microvm.c     |  2 +-
>>> hw/i386/pc.c          |  1 +
>>> hw/i386/pc_piix.c     | 10 +++++---
>>> hw/i386/pc_q35.c      | 10 +++++---
>>> hw/i386/x86-common.c  |  4 +---
>>> include/hw/i386/pc.h  |  6 ++---
>>> include/hw/i386/x86.h |  2 +-
>>> target/i386/cpu.c     | 56 =
++++++++++++-------------------------------
>>> target/i386/cpu.h     | 16 +------------
>>> 9 files changed, 37 insertions(+), 70 deletions(-)
>>>=20
>>> changelog:
>>> v2: explain in commit log why use of CPU_VERSION_LATEST for machines
>>> is problematic.
>>> v3: fix a bug that broke the pipeline
>>> https://gitlab.com/mstredhat/qemu/-/pipelines/1626171267
>>> when cpu versions are explicitly specified in the command line,
>>> respect that and do not enforce legacy (unversioned) cpu logic.
>>> The pipeline is green now with the fix:
>>> https://gitlab.com/anisinha/qemu/-/pipelines/1626783632
>>> v4: made changes as per Zhao's suggestions.
>>> Pipeline passes =
https://gitlab.com/anisinha/qemu/-/pipelines/1635829877
>>> v5: adjustment of pc_init_cpus() declaration as per Zhao's =
suggestion. This
>>> simplifies things and also passes compilation.
>>> CI still passes =
https://gitlab.com/anisinha/qemu/-/pipelines/1637657451
>>> v6: cosmetic commit log correction as suggested by Igor. rebase, =
added tags.
>>> v7: This patch is based off the top of
>>> https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg00934.html.
>>> Igor's inputs taken into consideration.
>>> CI passed.
>>> Note: The above patch has not merged to QEMU upstream yet. Hence, =
its
>>> commit hash is marked as XXX in the commit log for this patch.
>>>=20
>>> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
>>> index a340a5fd39..0eca629958 100644
>>> --- a/hw/i386/microvm.c
>>> +++ b/hw/i386/microvm.c
>>> @@ -491,7 +491,7 @@ static void =
microvm_machine_state_init(MachineState *machine)
>>>=20
>>>     microvm_memory_init(mms);
>>>=20
>>> -    x86_cpus_init(x86ms, 1);
>>> +    x86_cpus_init(x86ms);
>>>=20
>>>     microvm_devices_init(mms);
>>> }
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 63a96cd23f..6a2ccfd42a 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -30,6 +30,7 @@
>>> #include "hw/hyperv/hv-balloon.h"
>>> #include "hw/i386/fw_cfg.h"
>>> #include "hw/i386/vmport.h"
>>> +#include "target/i386/cpu.h"
>>> #include "system/cpus.h"
>>> #include "hw/ide/ide-bus.h"
>>> #include "hw/timer/hpet.h"
>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>> index 04d2957adc..b793a4c765 100644
>>> --- a/hw/i386/pc_piix.c
>>> +++ b/hw/i386/pc_piix.c
>>> @@ -181,7 +181,12 @@ static void pc_init1(MachineState *machine, =
const char *pci_type)
>>>     }
>>>=20
>>>     pc_machine_init_sgx_epc(pcms);
>>> -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
>>> +
>>> +    if (pcmc->no_versioned_cpu_model) {
>>> +        /* use legacy cpu as it does not support versions */
>>> +        x86_cpu_set_legacy_version();
>>> +    }
>>> +    x86_cpus_init(x86ms);
>>>=20
>>>     if (kvm_enabled()) {
>>>         kvmclock_create(pcmc->kvmclock_create_always);
>>> @@ -457,7 +462,6 @@ static void =
pc_i440fx_machine_options(MachineClass *m)
>>>     ObjectClass *oc =3D OBJECT_CLASS(m);
>>>     pcmc->default_south_bridge =3D TYPE_PIIX3_DEVICE;
>>>     pcmc->pci_root_uid =3D 0;
>>> -    pcmc->default_cpu_version =3D 1;
>>>=20
>>>     m->family =3D "pc_piix";
>>>     m->desc =3D "Standard PC (i440FX + PIIX, 1996)";
>>> @@ -669,7 +673,7 @@ static void =
pc_i440fx_machine_4_0_options(MachineClass *m)
>>> {
>>>     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>>>     pc_i440fx_machine_4_1_options(m);
>>> -    pcmc->default_cpu_version =3D CPU_VERSION_LEGACY;
>>> +    pcmc->no_versioned_cpu_model =3D true;
>>>     compat_props_add(m->compat_props, hw_compat_4_0, =
hw_compat_4_0_len);
>>>     compat_props_add(m->compat_props, pc_compat_4_0, =
pc_compat_4_0_len);
>>> }
>>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>>> index 77536dd697..be7775e9de 100644
>>> --- a/hw/i386/pc_q35.c
>>> +++ b/hw/i386/pc_q35.c
>>> @@ -187,7 +187,12 @@ static void pc_q35_init(MachineState *machine)
>>>     }
>>>=20
>>>     pc_machine_init_sgx_epc(pcms);
>>> -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
>>> +
>>> +    if (pcmc->no_versioned_cpu_model) {
>>> +        /* use legacy cpu as it does not support versions */
>>> +        x86_cpu_set_legacy_version();
>>> +    }
>>> +    x86_cpus_init(x86ms);
>>>=20
>>>     if (kvm_enabled()) {
>>>         kvmclock_create(pcmc->kvmclock_create_always);
>>> @@ -339,7 +344,6 @@ static void pc_q35_machine_options(MachineClass =
*m)
>>> {
>>>     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>>>     pcmc->pci_root_uid =3D 0;
>>> -    pcmc->default_cpu_version =3D 1;
>>>=20
>>>     m->family =3D "pc_q35";
>>>     m->desc =3D "Standard PC (Q35 + ICH9, 2009)";
>>> @@ -547,7 +551,7 @@ static void =
pc_q35_machine_4_0_1_options(MachineClass *m)
>>> {
>>>     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>>>     pc_q35_machine_4_1_options(m);
>>> -    pcmc->default_cpu_version =3D CPU_VERSION_LEGACY;
>>> +    pcmc->no_versioned_cpu_model =3D true;
>>>     /*
>>>      * This is the default machine for the 4.0-stable branch. It is =
basically
>>>      * a 4.0 that doesn't use split irqchip by default. It MUST =
hence apply the
>>> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
>>> index 1b0671c523..e8c827c1da 100644
>>> --- a/hw/i386/x86-common.c
>>> +++ b/hw/i386/x86-common.c
>>> @@ -66,15 +66,13 @@ out:
>>>     object_unref(cpu);
>>> }
>>>=20
>>> -void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>>> +void x86_cpus_init(X86MachineState *x86ms)
>>> {
>>>     int i;
>>>     const CPUArchIdList *possible_cpus;
>>>     MachineState *ms =3D MACHINE(x86ms);
>>>     MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
>>>=20
>>> -    x86_cpu_set_default_version(default_cpu_version);
>>> -
>>>     /*
>>>      * Calculates the limit to CPU APIC ID values
>>>      *
>>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>>> index 103b54301f..477960275e 100644
>>> --- a/include/hw/i386/pc.h
>>> +++ b/include/hw/i386/pc.h
>>> @@ -92,9 +92,6 @@ struct PCMachineClass {
>>>=20
>>>     /* Compat options: */
>>>=20
>>> -    /* Default CPU model version.  See =
x86_cpu_set_default_version(). */
>>> -    int default_cpu_version;
>>> -
>>>     /* ACPI compat: */
>>>     bool has_acpi_build;
>>>     int pci_root_uid;
>>> @@ -125,6 +122,9 @@ struct PCMachineClass {
>>>      * check for memory.
>>>      */
>>>     bool broken_32bit_mem_addr_check;
>>> +
>>> +    /* whether the machine supports versioned cpu models */
>>> +    bool no_versioned_cpu_model;
>>> };
>>>=20
>>> #define TYPE_PC_MACHINE "generic-pc-machine"
>>> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>>> index d43cb3908e..2d2b987fa1 100644
>>> --- a/include/hw/i386/x86.h
>>> +++ b/include/hw/i386/x86.h
>>> @@ -114,7 +114,7 @@ void init_topo_info(X86CPUTopoInfo *topo_info, =
const X86MachineState *x86ms);
>>> uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>>>                                     unsigned int cpu_index);
>>>=20
>>> -void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
>>> +void x86_cpus_init(X86MachineState *pcms);
>>> void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
>>> void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>>                       DeviceState *dev, Error **errp);
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 2da2cf36fd..e5c8dd98d0 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -5624,30 +5624,16 @@ static const X86CPUDefinition =
builtin_x86_defs[] =3D {
>>>     },
>>> };
>>>=20
>>> -/*
>>> - * We resolve CPU model aliases using -v1 when using "-machine
>>> - * none", but this is just for compatibility while libvirt isn't
>>> - * adapted to resolve CPU model versions before creating VMs.
>>> - * See "Runnability guarantee of CPU models" at
>>> - * docs/about/deprecated.rst.
>>> - */
>>> -X86CPUVersion default_cpu_version =3D 1;
>>> -
>>> -void x86_cpu_set_default_version(X86CPUVersion version)
>>> +static bool no_cpu_alias;
>>> +void x86_cpu_set_legacy_version(void)
>>> {
>>> -    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't =
make sense */
>>> -    assert(version !=3D CPU_VERSION_AUTO);
>>> -    default_cpu_version =3D version;
>>> +    no_cpu_alias =3D true;
>>> }
>>>=20
>>> /* Return the actual version being used for a specific CPU model */
>>> static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel =
*model)
>>> {
>>> -    X86CPUVersion v =3D model->version;
>>> -    if (v =3D=3D CPU_VERSION_AUTO) {
>>> -        v =3D default_cpu_version;
>>> -    }
>>> -    return v;
>>> +    return model->version;
>>> }
>>>=20
>>> static const Property max_x86_cpu_properties[] =3D {
>>> @@ -6251,10 +6237,15 @@ static char =
*x86_cpu_class_get_alias_of(X86CPUClass *cc)
>>>     if (!cc->model || !cc->model->is_alias) {
>>>         return NULL;
>>>     }
>>> -    version =3D x86_cpu_model_resolve_version(cc->model);
>>> -    if (version <=3D 0) {
>>> +
>>> +    if (no_cpu_alias) {
>>> +        /* legacy cpu models do not support cpu aliases */
>>>         return NULL;
>>>     }
>>> +
>>> +    version =3D x86_cpu_model_resolve_version(cc->model);
>>> +    assert(version);
>>> +
>>>     return x86_cpu_versioned_model_name(cc->model->cpudef, version);
>>> }
>>>=20
>>> @@ -6268,11 +6259,7 @@ static void x86_cpu_list_entry(gpointer data, =
gpointer user_data)
>>>     g_autofree char *model_id =3D x86_cpu_class_get_model_id(cc);
>>>=20
>>>     if (!desc && alias_of) {
>>> -        if (cc->model && cc->model->version =3D=3D =
CPU_VERSION_AUTO) {
>>> -            desc =3D g_strdup("(alias configured by machine =
type)");
>>> -        } else {
>>> -            desc =3D g_strdup_printf("(alias of %s)", alias_of);
>>> -        }
>>> +        desc =3D g_strdup_printf("(alias of %s)", alias_of);
>>>     }
>>>     if (!desc && cc->model && cc->model->note) {
>>>         desc =3D g_strdup_printf("%s [%s]", model_id, =
cc->model->note);
>>> @@ -6375,13 +6362,8 @@ static void x86_cpu_definition_entry(gpointer =
data, gpointer user_data)
>>>     } else {
>>>         info->deprecated =3D false;
>>>     }
>>> -    /*
>>> -     * Old machine types won't report aliases, so that alias =
translation
>>> -     * doesn't break compatibility with previous QEMU versions.
>>> -     */
>>> -    if (default_cpu_version !=3D CPU_VERSION_LEGACY) {
>>> -        info->alias_of =3D x86_cpu_class_get_alias_of(cc);
>>> -    }
>>> +
>>> +    info->alias_of =3D x86_cpu_class_get_alias_of(cc);
>>>=20
>>>     QAPI_LIST_PREPEND(*cpu_list, info);
>>> }
>>> @@ -6553,10 +6535,6 @@ static void =
x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
>>>     const X86CPUVersionDefinition *vdef;
>>>     X86CPUVersion version =3D x86_cpu_model_resolve_version(model);
>>>=20
>>> -    if (version =3D=3D CPU_VERSION_LEGACY) {
>>> -        return;
>>> -    }
>>> -
>>>     for (vdef =3D x86_cpu_def_get_versions(model->cpudef); =
vdef->version; vdef++) {
>>>         PropValue *p;
>>>=20
>>> @@ -6583,10 +6561,6 @@ static const CPUCaches =
*x86_cpu_get_versioned_cache_info(X86CPU *cpu,
>>>     X86CPUVersion version =3D x86_cpu_model_resolve_version(model);
>>>     const CPUCaches *cache_info =3D model->cpudef->cache_info;
>>>=20
>>> -    if (version =3D=3D CPU_VERSION_LEGACY) {
>>> -        return cache_info;
>>> -    }
>>> -
>>>     for (vdef =3D x86_cpu_def_get_versions(model->cpudef); =
vdef->version; vdef++) {
>>>         if (vdef->cache_info) {
>>>             cache_info =3D vdef->cache_info;
>>> @@ -6718,7 +6692,7 @@ static void x86_register_cpudef_types(const =
X86CPUDefinition *def)
>>>     /* Unversioned model: */
>>>     m =3D g_new0(X86CPUModel, 1);
>>>     m->cpudef =3D def;
>>> -    m->version =3D CPU_VERSION_AUTO;
>>> +    m->version =3D 1;
>>>     m->is_alias =3D true;
>>>     x86_register_cpu_model_type(def->name, m);
>>>=20
>>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>>> index 113cf10aea..ee1edaa987 100644
>>> --- a/target/i386/cpu.h
>>> +++ b/target/i386/cpu.h
>>> @@ -2739,23 +2739,9 @@ void cpu_report_tpr_access(CPUX86State *env, =
TPRAccess access);
>>> void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
>>>                                    TPRAccess access);
>>>=20
>>> -/* Special values for X86CPUVersion: */
>>> -/*
>>> - * Resolve to version defined by current machine type.
>>> - * See x86_cpu_set_default_version()
>>> - */
>>> -#define CPU_VERSION_AUTO   -2
>>> -
>>> -/* Don't resolve to any versioned CPU models, like old QEMU =
versions */
>>> -#define CPU_VERSION_LEGACY  0
>>> -
>>> typedef int X86CPUVersion;
>>>=20
>>> -/*
>>> - * Set default CPU model version for CPU models having
>>> - * version =3D=3D CPU_VERSION_AUTO.
>>> - */
>>> -void x86_cpu_set_default_version(X86CPUVersion version);
>>> +void x86_cpu_set_legacy_version(void);
>>>=20
>>> #ifndef CONFIG_USER_ONLY
>>>=20
>>> --=20
>>> 2.45.2 =20



