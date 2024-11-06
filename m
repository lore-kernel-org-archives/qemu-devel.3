Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4CDD59F68
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 19:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8lLK-0007yd-Ib; Wed, 06 Nov 2024 14:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8lLH-0007y0-9M; Wed, 06 Nov 2024 14:05:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8lLE-0006mS-Hq; Wed, 06 Nov 2024 14:05:23 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XkF3Y4gJ7z6K5Ws;
 Thu,  7 Nov 2024 03:03:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B7B501404F4;
 Thu,  7 Nov 2024 03:05:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 20:05:15 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 6 Nov 2024 20:05:15 +0100
To: Igor Mammedov <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>
Subject: RE: [PATCH 2/3] Fix: Reverse CPUs presence check logic for x86
 backward compatability
Thread-Topic: [PATCH 2/3] Fix: Reverse CPUs presence check logic for x86
 backward compatability
Thread-Index: AQHbMExwRTIJtUKJlEic/SrRi9Z39bKqNgWAgAAbf+CAAAkaAIAAEedg
Date: Wed, 6 Nov 2024 19:05:15 +0000
Message-ID: <2bb1abda0787405b95af0233940e3df7@huawei.com>
References: <20241106130331.205020-1-salil.mehta@huawei.com>
 <20241106130331.205020-3-salil.mehta@huawei.com>
 <20241106145635.77332d7c@imammedo.users.ipa.redhat.com>
 <28a19ad7554e4b70819e1435669eeba3@huawei.com>
 <20241106170734.0c7a5adb@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241106170734.0c7a5adb@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.170.112]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Igor,

Thanks for replying back and the reviews. Please find my replies
inline.

>  From: Igor Mammedov <imammedo@redhat.com>
>  Sent: Wednesday, November 6, 2024 4:08 PM
>  To: Salil Mehta <salil.mehta@huawei.com>
> =20
>  On Wed, 6 Nov 2024 14:45:42 +0000
>  Salil Mehta <salil.mehta@huawei.com> wrote:
> =20
>  > Hi Igor,
>  >
>  > >  From: qemu-arm-bounces+salil.mehta=3Dhuawei.com@nongnu.org
>  <qemu-
>  > > arm-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of Igor
>  > > Mammedov
>  > >  Sent: Wednesday, November 6, 2024 1:57 PM
>  > >  To: Salil Mehta <salil.mehta@huawei.com>
>  > >
>  > >  On Wed, 6 Nov 2024 13:03:30 +0000
>  > >  Salil Mehta <salil.mehta@huawei.com> wrote:
>  > >
>  > >  > Checking `is_present` first can break x86 migration from new Qemu
>  > > > version to old Qemu. This is because CPRS Bit is not defined in
>  > > the  > older Qemu register block and will always be 0 resulting in
>  > > check  > always failing. Reversing the logic to first check
>  > > `is_enabled` can  > alleviate below problem:
>  > >  >
>  > >  > -                If ((\_SB.PCI0.PRES.CPEN =3D=3D One))
>  > >  > -                {
>  > >  > -                    Local0 =3D 0x0F
>  > >  > +                If ((\_SB.PCI0.PRES.CPRS =3D=3D One))
>  > >  > +                {
>  > >  > +                    If ((\_SB.PCI0.PRES.CPEN =3D=3D One))
>  > >  > +                    {
>  > >  > +                        Local0 =3D 0x0F
>  > >  > +                    }
>  > >  > +                    Else
>  > >  > +                    {
>  > >  > +                        Local0 =3D 0x0D
>  > >  > +                    }
>  > >  >                  }
>  > >  >
>  > >  > Suggested-by: Igor Mammedov <imammedo@redhat.com>
>  'Reported-by'
>  > > maybe, but certainly not suggested.
>  >
>  >
>  > No issues. I can change.
>  >
>  >
>  > >
>  > >  After more thinking and given presence is system wide that doesn't
>  > > change  at runtime, I don't see any reason for introducing presence
>  > > bit as ABI (and  undocumented on top of that).
>  >
>  >
>  > This is a wrong assumption. Presence bit can change in future. We have
>  > taken into account this aspect by design in the kernel code as well.
>  > Both virtual
> =20
>  Above does imply that support for really hotpluggable CPUs might be
>  implemented in the future.
>  Can you point to relevant kernel code/patches?


Let me make it clear so that there is no confusion, there is no support of
physical "CPU" hot-plug on ARM platforms right now and nor will there be
any in future as it does not makes sense to have. The point I made in the
patches is about hot-plug was at different granularity which has not been
denied by ARM.


> =20
>  > and physical CPU hot plug can co-exists or entirely as sole features.
>  > This is a requirement.
> =20
> =20
>  I don't see any _must_ requirements here whatsoever. If/when ARM
>  reaches point where standby and hotplug cpus are mixed within VM
>  instance, we might have to expose presence bit to guest dynamically but =
it
>  is totally not needed within observable future and premature.


>  Your cpu class presence check also works target-wise just with more boil=
er
>  code
>  + not needed presence bit ABI for guest side,
>  The same as my suggestion only from other side.
> =20
>  But regardless of that as long as machine has doesn't mix always present
>  CPUs with hotpluggable ones within the same instance, changing AML side
>  as I've just suggested works.


Sure, I'm not disagreeing. It will work by adding the flag you've suggested
but it will work even by not adding any flag and not defining a `persistent=
`
hook for any architecture.


> =20
>  If ARM ever gets real cpu hotplug as your comment above hints, my
>  suggestion also works fine. With only difference that board code would t=
urn
>  off always_present_cpus if hotpluggable CPUs are used instead of standby=
.


Sure, but is it necessary to define a new flag when you can do even without=
 it?
Having few lines of extra code (literally 2-3 only) should not be a major c=
ause of
worry, especially, if it makes design more clear and easy to understand. Th=
is is
not a performance code either.

Again, I appreciate your compact logic. I'm not disagreeing with it.


>  > >  Instead changing AML code to account for it would be better,
>  > > something like
>  > >  this:
>  > >
>  > >  diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h index
>  > >  32654dc274..4a3e591120 100644
>  > >  --- a/include/hw/acpi/cpu.h
>  > >  +++ b/include/hw/acpi/cpu.h
>  > >  @@ -55,6 +55,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as,
>  Object
>  > > *owner,  typedef struct CPUHotplugFeatures {
>  > >       bool acpi_1_compatible;
>  > >       bool has_legacy_cphp;
>  > >  +    bool always_present_cpus;
>  >
>  >
>  > This has to be fetched from architecture code. Please see other
>  > changes in the V3 patch-set.
> =20
>  I've seen, that and it doesn't have to be fetched dynamically.


Agreed, it is not necessary to be fetched. Hence, if you do not define the
hook. In later case, it assumes the existing logic, which x86 has been foll=
owing.
It will work.


>  In my opinion the series was not ready to be merged (Michael probably
>  picked it by mistake).
> =20
>  We don't really need this in 9.2 as it is only ARM cpu 'hotplug'
>  related, and the later is not ready for 9.2.
>  I'd prefer the series being reverted and we continue improving series,
>  instead of rushing it and fixing broken thing up.
> =20
> =20
>  >
>  >
>  > >       bool fw_unplugs_cpu;
>  > >       const char *smi_path;
>  > >   } CPUHotplugFeatures;
>  > >  diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index
>  > > 5cb60ca8bc..2bcce2b31c
>  > >  100644
>  > >  --- a/hw/acpi/cpu.c
>  > >  +++ b/hw/acpi/cpu.c
>  > >  @@ -452,15 +452,16 @@ void build_cpus_aml(Aml *table,
>  MachineState
>  > > *machine, CPUHotplugFeatures opts,
>  > >
>  > >           method =3D aml_method(CPU_STS_METHOD, 1, AML_SERIALIZED);
>  > >           {
>  > >  +            uint8_t default_sta =3D opts.always_present_cpus?0xd:0=
;
>  > >               Aml *idx =3D aml_arg(0);
>  > >  -            Aml *sta =3D aml_local(0);
>  > >  +            Aml *sta =3D aml_local(default_sta);
>  > >
>  > >               aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
>  > >               aml_append(method, aml_store(idx, cpu_selector));
>  > >               aml_append(method, aml_store(zero, sta));
>  > >               ifctx =3D aml_if(aml_equal(is_enabled, one));
>  > >               {
>  > >  -                aml_append(ifctx, aml_store(aml_int(0xF), sta));
>  > >  +                aml_append(ifctx, aml_or(aml_int(0xF), sta, sta));
>  > >               }
>  > >               aml_append(method, ifctx);
>  > >               aml_append(method, aml_release(ctrl_lock))
>  > >
>  > >  then for ARM set
>  > >   CPUHotplugFeatures::always_present_cpus =3D true to get present fl=
ag
>  > > always enabled
>  >
>  >
>  > We MUST fetch this from architecture code as this can dynamically
>  > change in future and hence, we need to keep that flexibility
> =20
>  CPUHotplugFeatures::always_present_cpus can be set dynamically per VM
>  instance or per Machine type.


Yes, but you need a code for that and I'm not sure what is being saved by
introducing an extra flag then?


>  > >  After that revert _all_ other presence bit related changes that
>  > > were just  merged.
>  > >  (I did ask to get rid of that in previous reviews but it came back
>  > > again for no  good reason).
>  >
>  >
>  > The CPUs AML in the V2 patch-set would have broken the x86
>  functionality.
> =20
>  Frankly speaking, I don't see much progress. All that happens on respins=
 is
>  flipping between what I asked to remove before to some earlier concept.


I think then you've missed the code which addressed one of your key concern=
s
in the V1 patch-set that would have broken x86 migration i.e. presence of t=
he
`is_enabled` state in the CPU Hot-plug VMSD. That has been removed. Maybe
you would like to go through the change log of the V3 patch-set

https://lore.kernel.org/qemu-devel/20241018163118.0ae01a84@imammedo.users.i=
pa.redhat.com/

Below is the relevant excerpt from your many comments:

[...]
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_BOOL(is_inserting, AcpiCpuStatus),
>          VMSTATE_BOOL(is_removing, AcpiCpuStatus),
> +        VMSTATE_BOOL(is_present, AcpiCpuStatus),
> +        VMSTATE_BOOL(is_enabled, AcpiCpuStatus),

that's likely will break x86 migration,
but before bothering peterx, maybe we won't need this hunk if
is_enabled is migrated as part of vCPU state.

[...]


>  And all of that for the purpose to workaround/accommodate fake cpu
>  hotplug hacks.


I've to respectfully disagree on this. This is your assumption which is far=
 from
reality. The accompanying main series of this will never have vCPUs which a=
re
*not* present. BTW, these changes have been tested by Oracle folks with tha=
t
series and are known to work.

https://lore.kernel.org/qemu-devel/C4FEC9E7-69DB-428A-A85F-30170F98814B@ora=
cle.com/



Thanks!

Best regards
Salil.



