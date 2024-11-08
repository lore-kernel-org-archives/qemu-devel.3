Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC547D64063
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 16:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9SAi-0008NU-Ao; Fri, 08 Nov 2024 11:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t9SAh-0008N8-Df
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:49:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t9SAc-0007YK-4s
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731084552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8ketmK1WuAdbsC5ak+Q0KcSWuHAhs8tIOA65xeven0=;
 b=BCD++QOYetQlEOODMSCwULLiBCfVMbPV6Va+TwB7H24fVn4eIuF21dlJI1jZITG8ljz0d7
 hZBGcOY5Sp60KjzPk0lc3Tr43/SHd0W3+AaIkPhLJmrsXHRwozFw0IBK5GQ1TpZkeC3E48
 2EzwQtCGu199dbqgNb5Gea4Iqv/QP+w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-VIFDbOOOOzS8qK-ZcmGQKg-1; Fri, 08 Nov 2024 11:49:11 -0500
X-MC-Unique: VIFDbOOOOzS8qK-ZcmGQKg-1
X-Mimecast-MFC-AGG-ID: VIFDbOOOOzS8qK-ZcmGQKg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d432f9f5eso1165350f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 08:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731084549; x=1731689349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p8ketmK1WuAdbsC5ak+Q0KcSWuHAhs8tIOA65xeven0=;
 b=H9ARYYuf/qsfreP8+1U4+/VG/RdIOdrkMswQb4wih18tTnVWcaYIJPoceBjNQNVkH4
 D2bjsRgabbF4dWFDF7D7QsiQZELSznb10L3RsLaLEkLy18uXQOjhiGhefaLOxTKy/EOv
 s/3zU8Zr5PdVxkwxMNUzeF9qTMl02v1Xz8DglbgywRmNknl9LLq6W7ofX7TsgUgTyxMg
 mmPhEUV+6GCDC+3HCkEFfgugH1Z8bz7YIa+SBl7Ba7TyaZpfwy+XochBTWhEkgJFt0oh
 ipFAUpM4KPvTO/RnNqAcoIwJUNoKQul+gjTg5xqR7LCvid76m7PAmF+xILEGYM9gvaqE
 T5sQ==
X-Gm-Message-State: AOJu0YztXnkGimdmAwbDTTRnUnS/UkEHEMunwPA32ikFoFyZ+8klDk/k
 QUgfBxHDD9XEmg1Eo9OX3AxB25JQX8llXtOXtw0z4/2Ol3uds3CopmXqc2duvWWfi4TSGPrpwai
 PXQ9jZBL5i4PSVZg2AlrqytvL31uluUDr0AknYJnNY6LtebrjLY/7qprM7zco
X-Received: by 2002:a05:6000:1543:b0:37d:45ab:422b with SMTP id
 ffacd0b85a97d-381f1834d46mr2821530f8f.31.1731084548650; 
 Fri, 08 Nov 2024 08:49:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOZv7smpIMeE3Byo5fTHFbusnVFHKSnMSPj5ajk1+ueJ5Z2u4NHtS58wdkxLbGO7cNd2tFHw==
X-Received: by 2002:a05:6000:1543:b0:37d:45ab:422b with SMTP id
 ffacd0b85a97d-381f1834d46mr2821511f8f.31.1731084548143; 
 Fri, 08 Nov 2024 08:49:08 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ec1b1sm5528456f8f.82.2024.11.08.08.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 08:49:07 -0800 (PST)
Date: Fri, 8 Nov 2024 17:49:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "anisinha@redhat.com"
 <anisinha@redhat.com>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "peterx@redhat.com" <peterx@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "gshan@redhat.com"
 <gshan@redhat.com>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net"
 <salil.mehta@opnsrc.net>, zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng
 (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm
 <linuxarm@huawei.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>
Subject: Re: [PATCH 2/3] Fix: Reverse CPUs presence check logic for x86
 backward compatability
Message-ID: <20241108174905.75684edc@imammedo.users.ipa.redhat.com>
In-Reply-To: <6f6b3856c9274be4b070539770be1b39@huawei.com>
References: <20241106130331.205020-1-salil.mehta@huawei.com>
 <20241106130331.205020-3-salil.mehta@huawei.com>
 <20241106145635.77332d7c@imammedo.users.ipa.redhat.com>
 <28a19ad7554e4b70819e1435669eeba3@huawei.com>
 <20241106170734.0c7a5adb@imammedo.users.ipa.redhat.com>
 <2bb1abda0787405b95af0233940e3df7@huawei.com>
 <20241107175715.4f07ae22@imammedo.users.ipa.redhat.com>
 <6f6b3856c9274be4b070539770be1b39@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Thu, 7 Nov 2024 18:59:07 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Igor,
>=20
> Many thanks for taking time to reply.
>=20
> >  From: qemu-arm-bounces+salil.mehta=3Dhuawei.com@nongnu.org <qemu-
> >  arm-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of Igor
> >  Mammedov
> >  Sent: Thursday, November 7, 2024 4:57 PM
> >  To: Salil Mehta <salil.mehta@huawei.com>
> > =20
> >  On Wed, 6 Nov 2024 19:05:15 +0000
> >  Salil Mehta <salil.mehta@huawei.com> wrote:
> >   =20
> >  > Hi Igor,
> >  >
> >  > Thanks for replying back and the reviews. Please find my replies
> >  > inline.
> >  > =20
> >  > >  From: Igor Mammedov <imammedo@redhat.com>
> >  > >  Sent: Wednesday, November 6, 2024 4:08 PM
> >  > >  To: Salil Mehta <salil.mehta@huawei.com>
> >  > >
> >  > >  On Wed, 6 Nov 2024 14:45:42 +0000
> >  > >  Salil Mehta <salil.mehta@huawei.com> wrote:
> >  > > =20
> >  > >  > Hi Igor,
> >  > >  > =20
> >  > >  > >  From: qemu-arm-bounces+salil.mehta=3Dhuawei.com@nongnu.org =
=20
> >  > >  <qemu- =20
> >  > >  > > arm-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of=
 =20
> >  > > Igor  > > Mammedov  > >  Sent: Wednesday, November 6, 2024 1:57 PM=
 =20
> >  > > > >  To: Salil Mehta <salil.mehta@huawei.com>  > >  > >  On Wed, 6=
 =20
> >  > > Nov 2024 13:03:30 +0000  > >  Salil Mehta <salil.mehta@huawei.com>
> >  > > wrote: =20
> >  > >  > > =20
> >  > >  > >  > Checking `is_present` first can break x86 migration from n=
ew =20
> >  > > Qemu  > > > version to old Qemu. This is because CPRS Bit is not
> >  > > defined in  > > the  > older Qemu register block and will always be
> >  > > 0 resulting in  > > check  > always failing. Reversing the logic to
> >  > > first check  > > `is_enabled` can  > alleviate below problem: =20
> >  > >  > >  >
> >  > >  > >  > -                If ((\_SB.PCI0.PRES.CPEN =3D=3D One))
> >  > >  > >  > -                {
> >  > >  > >  > -                    Local0 =3D 0x0F
> >  > >  > >  > +                If ((\_SB.PCI0.PRES.CPRS =3D=3D One))
> >  > >  > >  > +                {
> >  > >  > >  > +                    If ((\_SB.PCI0.PRES.CPEN =3D=3D One))
> >  > >  > >  > +                    {
> >  > >  > >  > +                        Local0 =3D 0x0F
> >  > >  > >  > +                    }
> >  > >  > >  > +                    Else
> >  > >  > >  > +                    {
> >  > >  > >  > +                        Local0 =3D 0x0D
> >  > >  > >  > +                    }
> >  > >  > >  >                  }
> >  > >  > >  >
> >  > >  > >  > Suggested-by: Igor Mammedov <imammedo@redhat.com> =20
> >  > > 'Reported-by' =20
> >  > >  > > maybe, but certainly not suggested. =20
> >  > >  >
> >  > >  >
> >  > >  > No issues. I can change.
> >  > >  >
> >  > >  > =20
> >  > >  > >
> >  > >  > >  After more thinking and given presence is system wide that =
=20
> >  > > doesn't  > > change  at runtime, I don't see any reason for
> >  > > introducing presence  > > bit as ABI (and  undocumented on top of =
that). =20
> >  > >  >
> >  > >  >
> >  > >  > This is a wrong assumption. Presence bit can change in future. =
We =20
> >  > > have  > taken into account this aspect by design in the kernel cod=
e as =20
> >  well. =20
> >  > >  > Both virtual =20
> >  > >
> >  > >  Above does imply that support for really hotpluggable CPUs might =
be
> >  > > implemented in the future.
> >  > >  Can you point to relevant kernel code/patches? =20
> >  >
> >  >
> >  > Let me make it clear so that there is no confusion, there is no
> >  > support of physical "CPU" hot-plug on ARM platforms right now and nor
> >  > will there be any in future as it does not makes sense to have. The
> >  > point I made in the patches is about hot-plug was at different
> >  > granularity which has not been denied by ARM. =20
> > =20
> >  _STA and ACPI cphp registers are per logical CPU and can't be anything=
 else
> >  per spec.
> > =20
> >  how different granularity is relevant here? =20
>=20
>=20
> It is because hot-plug at socket level (or similar level) has not been de=
nied.

It's the same for x86.
However anything above logical CPU level is not CPU devices,
but container devices. Even if you plugged whole socket,
in QEMU that would result in _STA evaluated on all leaf logical CPUs
and guest will online those CPUs individually.

Granularity here is irrelevant, it handles only vCPUs an nothing else.

If there were need to do something with containers (socket/cluster/...)
in hypothetical future, that should have it's own AML code instead of
abusing vCPU one, and well it certainly should be added only at that
time and not earlier.
=20
> >  > >  > and physical CPU hot plug can co-exists or entirely as sole fea=
tures.
> >  > >  > This is a requirement. =20
> >  > >
> >  > >
> >  > >  I don't see any _must_ requirements here whatsoever. If/when ARM
> >  > > reaches point where standby and hotplug cpus are mixed within VM
> >  > > instance, we might have to expose presence bit to guest dynamically
> >  > > but it  is totally not needed within observable future and prematu=
re. =20
> >  >
> >  > =20
> >  > >  Your cpu class presence check also works target-wise just with mo=
re
> >  > > boiler  code  + not needed presence bit ABI for guest side,  The
> >  > > same as my suggestion only from other side.
> >  > >
> >  > >  But regardless of that as long as machine has doesn't mix always
> >  > > present  CPUs with hotpluggable ones within the same instance,
> >  > > changing AML side  as I've just suggested works. =20
> >  >
> >  >
> >  > Sure, I'm not disagreeing. It will work by adding the flag you've
> >  > suggested but it will work even by not adding any flag and not
> >  > defining a `persistent` hook for any architecture. =20
> > =20
> >  hook is more complicated and hidden way, than directly passing down
> >  configuration data to routine that builds AML where it is needed, but =
that's
> >  cosmetics in the end. =20
>=20
>=20
> It is indeed an abstraction and an intentional one because decision wheth=
er
> some or all CPUs should remain present even after unplug action is=20
> specific to an architecture. Hence, should be left with that part.

Arch specific static AML is much simpler in this case, compared to callback=
s.
and this AML is still controlled by machine specific code, which
opts in into always_present cpus feature (it's machine that build's AML
code depending on options).

We do the same in x86, see other flags in CPUHotplugFeatures.
Guest opts in to change curtain parts of AML depending on machine config,
same should be done for ARM.

> >  However there is more to your hook approach, it exposes is_present bit=
 in
> >  cphp flag register which is ABI to guest which we will have to maintain
> >  forever and guest will do not necessary round-trip to QEMU to query it,
> >  while alternative is much simpler AML change without any ABI changes to
> >  care about. =20
>=20
>=20
> I understand your predicament about ABI but I've to respectfully disagree=
 on
> the assumption that guest will never round trip and check for the presenc=
e bit.

It doesn't need it now, isn't it?

When guest really needs to get presence flag dynamically in the future,
that's fine, but do introduce it at that time when it's actually used,
i.e. not for hypothetical case.

> > =20
> >  The point is we shouldn't add new ABI unless we have to. =20
>=20
>=20
> Ok sure. point taken.=20
>=20
>=20
> >  In this case new ABI (is_presence flag) is not _must_, and much simpler
> >  static AML change is sufficient. =20
>=20
>=20
> Agreed, there can be multiple ways to get rid of it . But I'm not sure if=
 its
> simpler or easier to maintain because CPUs AML code has become even
> more obscure by that compact logic. It is not easy to understand at the
> first look. This is not a performance leg and maintainability should take
> over the precedence.

As one who wrote and takes care ACPI and cpuhp, I'd know what code is easier
to read/maintain in the arrea and to a lesser degree elsewhere in QEMU.

When it comes to arch specific side, I usually leave it upto arch maintaine=
rs
as they know specifics there much better.
(unless I notice something that is too much to look away and asks to for ba=
shing)

> But I understand your primary concern now (i.e. to get rid of CPU_PRESENT
> Bit) and allow me to propose in the lines of what you want but maybe in a
> slightly different way. I would still like to retain hooks though.

hooks do have it's use when logic they are executing is complex, dynamic and
differs a lot between impl, but indirection they introduce makes
reading code and maintaining it harder (debugging it becomes outright night=
mare).

Example: I did the same as you in the past, adding madt hook for some future
use, in several years it began to get in the way and eventually was removed.
Burden to clean up (possible in the future but not happened things) falls
on new contributors. Moral of story is: not over-engineer.

If hook can be replaced by config data and data driven code, I'd prefer
it from ease to read/maintainability point of view.

> >  > >  If ARM ever gets real cpu hotplug as your comment above hints, my
> >  > > suggestion also works fine. With only difference that board code
> >  > > would turn  off always_present_cpus if hotpluggable CPUs are used =
=20
> >  instead of standby. =20
> >  >
> >  >
> >  > Sure, but is it necessary to define a new flag when you can do even =
=20
> >  without it? =20
> >  > Having few lines of extra code (literally 2-3 only) should not be a
> >  > major cause of worry, especially, if it makes design more clear and
> >  > easy to understand. This is not a performance code either.
> >  >
> >  > Again, I appreciate your compact logic. I'm not disagreeing with it.
> >  >
> >  > =20
> >  > >  > >  Instead changing AML code to account for it would be better,
> >  > > > > something like  > >  this:
> >  > >  > >
> >  > >  > >  diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h =
=20
> >  > > index  > >  32654dc274..4a3e591120 100644  > >  ---
> >  > > a/include/hw/acpi/cpu.h  > >  +++ b/include/hw/acpi/cpu.h  > >  @@
> >  > > -55,6 +55,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as,  Object =
=20
> >  > =20
> >  > > > *owner,  typedef struct CPUHotplugFeatures { =20
> >  > >  > >       bool acpi_1_compatible;
> >  > >  > >       bool has_legacy_cphp;
> >  > >  > >  +    bool always_present_cpus; =20
> >  > >  >
> >  > >  >
> >  > >  > This has to be fetched from architecture code. Please see other
> >  > > > changes in the V3 patch-set. =20
> >  > >
> >  > >  I've seen, that and it doesn't have to be fetched dynamically. =20
> >  >
> >  >
> >  > Agreed, it is not necessary to be fetched. Hence, if you do not defi=
ne
> >  > the hook. In later case, it assumes the existing logic, which x86 ha=
s been =20
> >  following. =20
> >  > It will work. =20
> > =20
> >  It is better to get rid of not necessary hook altogether, and replace =
it with a
> >  simple AML change. =20
>=20
>=20
> We still need a way to initialize flags in the architecture specific way.=
 Hooks are
> clean way to fetch that architecture specific state rather fiddling with =
flags
> at multiple levels (initialization, migration etc) and you will be duplic=
ating
> CPU states at ACPI level and QOM vCPU object level .  To be frank that's =
not
> a very good design.

cleaner way is to use properties to access object state in arch agnostic wa=
y.
and cpuhp didn't access any cpu state before your bf1ecc8dad60619 commit
...
 -        val |=3D cdev->cpu ? 1 : 0;
 +        val |=3D check_cpu_enabled_status(DEVICE(cdev->cpu)) ? 1 : 0
...
poking into CPU internals (masked by helper function/hook) from another dev=
ice
that is not even parent of CPU, which is layer violation and
should be avoided if possible.

In case of cpuhp there is hotplug handlers infrastructure, to wire up
and connect things.
I particular, machine called acpi_cpu_plug_cb() which may access cpu,
and in your case it can check 'realized' property and store 'enabled'
state in AcpiCpuStatus state. It would be even better if it used
a dedicated property "enabled", instead of abusing 'realized' one.
And do opposite on unplug (can be done from unplug handler).

> That said, I believe your end goal of getting rid of the change in the ABI
> can still be achieved.=20
>=20
>=20
> >  > >  In my opinion the series was not ready to be merged (Michael
> >  > > probably  picked it by mistake).
> >  > >
> >  > >  We don't really need this in 9.2 as it is only ARM cpu 'hotplug'
> >  > >  related, and the later is not ready for 9.2.
> >  > >  I'd prefer the series being reverted and we continue improving
> >  > > series,  instead of rushing it and fixing broken thing up.
> >  > >
> >  > > =20
> >  > >  >
> >  > >  > =20
> >  > >  > >       bool fw_unplugs_cpu;
> >  > >  > >       const char *smi_path;
> >  > >  > >   } CPUHotplugFeatures;
> >  > >  > >  diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index  > > =20
> >  > > 5cb60ca8bc..2bcce2b31c  > >  100644  > >  --- a/hw/acpi/cpu.c  > >
> >  > > +++ b/hw/acpi/cpu.c  > >  @@ -452,15 +452,16 @@ void
> >  > > build_cpus_aml(Aml *table,  MachineState  > > *machine,
> >  > > CPUHotplugFeatures opts,  > > =20
> >  > >  > >           method =3D aml_method(CPU_STS_METHOD, 1, =20
> >  AML_SERIALIZED); =20
> >  > >  > >           {
> >  > >  > >  +            uint8_t default_sta =3D opts.always_present_cpu=
s?0xd:0;
> >  > >  > >               Aml *idx =3D aml_arg(0);
> >  > >  > >  -            Aml *sta =3D aml_local(0);
> >  > >  > >  +            Aml *sta =3D aml_local(default_sta);
> >  > >  > >
> >  > >  > >               aml_append(method, aml_acquire(ctrl_lock, 0xFFF=
F));
> >  > >  > >               aml_append(method, aml_store(idx, cpu_selector)=
);
> >  > >  > >               aml_append(method, aml_store(zero, sta));
> >  > >  > >               ifctx =3D aml_if(aml_equal(is_enabled, one));
> >  > >  > >               {
> >  > >  > >  -                aml_append(ifctx, aml_store(aml_int(0xF), s=
ta));
> >  > >  > >  +                aml_append(ifctx, aml_or(aml_int(0xF), sta,=
 sta));
> >  > >  > >               }
> >  > >  > >               aml_append(method, ifctx);
> >  > >  > >               aml_append(method, aml_release(ctrl_lock))
> >  > >  > >
> >  > >  > >  then for ARM set
> >  > >  > >   CPUHotplugFeatures::always_present_cpus =3D true to get pre=
sent =20
> >  flag =20
> >  > >  > > always enabled =20
> >  > >  >
> >  > >  >
> >  > >  > We MUST fetch this from architecture code as this can dynamical=
ly
> >  > > > change in future and hence, we need to keep that flexibility =20
> >  > >
> >  > >  CPUHotplugFeatures::always_present_cpus can be set dynamically per
> >  > > VM  instance or per Machine type. =20
> >  >
> >  >
> >  > Yes, but you need a code for that and I'm not sure what is being sav=
ed
> >  > by introducing an extra flag then? =20
> > =20
> >  beside snippet, I've suggested. You need to delete all is_present call=
back
> >  related logic, than it save quite a bit, and not only on lines of code.
> > =20
> >  I guess, I need to send a patch to get point across. =20
>=20
>=20
> There is some misunderstanding. We are not maintaining any `is_present`
> state at the ACPI level. Both flags `is_present` and `is_enabled` were
> removed in V3 patch-set.

That was removed from AcpiCpuStatus, however
v3 does introduce present bit in register and callback to fetch it.
It is the same thing, just other way around.

> >  > >  > >  After that revert _all_ other presence bit related changes =
=20
> >  > > that  > > were just  merged. =20
> >  > >  > >  (I did ask to get rid of that in previous reviews but it cam=
e =20
> >  > > back  > > again for no  good reason). =20
> >  > >  >
> >  > >  >
> >  > >  > The CPUs AML in the V2 patch-set would have broken the x86 =20
> >  > > functionality.
> >  > >
> >  > >  Frankly speaking, I don't see much progress. All that happens on
> >  > > respins is  flipping between what I asked to remove before to some=
 =20
> >  earlier concept. =20
> >  >
> >  >
> >  > I think then you've missed the code which addressed one of your key
> >  > concerns in the V1 patch-set that would have broken x86 migration i.=
e.
> >  > presence of the `is_enabled` state in the CPU Hot-plug VMSD. That has
> >  > been removed. Maybe you would like to go through the change log of t=
he
> >  > V3 patch-set
> >  >
> >  > https://lore.kernel.org/qemu- =20
> >  devel/20241018163118.0ae01a84@imammedo.us =20
> >  > ers.ipa.redhat.com/
> >  >
> >  > Below is the relevant excerpt from your many comments:
> >  >
> >  > [...] =20
> >  > >      .fields =3D (const VMStateField[]) {
> >  > >          VMSTATE_BOOL(is_inserting, AcpiCpuStatus),
> >  > >          VMSTATE_BOOL(is_removing, AcpiCpuStatus),
> >  > > +        VMSTATE_BOOL(is_present, AcpiCpuStatus),
> >  > > +        VMSTATE_BOOL(is_enabled, AcpiCpuStatus), =20
> >  >
> >  > that's likely will break x86 migration, but before bothering peterx,
> >  > maybe we won't need this hunk if is_enabled is migrated as part of
> >  > vCPU state.
> >  > =20
> > =20
> >  what has been done in v3 is moving is_present/is_enabled, elsewhere
> >  (callbacks in this case). While argument was that both are not necessa=
ry to
> >  begin with. =20
>=20
>=20
> We need to have a way to check whether CPU is _STA.Enabled or not and=20
> the meaning of the `disabled` is best decided by the architecture specific
> code not the ACPI code. It could mean different across architectures and
> the implementations. We need to keep that flexibility in design.

I'm not arguing about 'enabled' in principle, only about the way it's
implemented. And that 'present' shouldn't be part of dynamic interface.

If you ever need present as dynamic in the future, introduce it at that
time along with patches that would use it.

> The thin Qemu ACPI code is just an interfacing logic with the guest. It is
> best not to duplicate the state of the QOM objects inside the ACPI. That's
> a bad design practice because we will have to worry about keeping those
> states consistent at both the places all the time whether it is during
> initialization or migration.

if we'd follow this logic, we would have a QEMU with direct access across
different objects all over the place. That might work for small project
and avoid duplication, but that is very fragile and won't scale to
project of QEMU size.

And to configure devices we have init/property/hotplug handlers,
so that machine could connect separate objects together in meaning full
way and establish well known control flow.


> >  > [...]
> >  >
> >  > =20
> >  > >  And all of that for the purpose to workaround/accommodate fake cpu
> >  > > hotplug hacks. =20
> >  >
> >  >
> >  > I've to respectfully disagree on this. This is your assumption which
> >  > is far from reality. The accompanying main series of this will never
> >  > have vCPUs which are
> >  > *not* present. =20
> > =20
> >  Reality of your last posted main series (v5), disagrees with what you =
are
> >  saying here
> > =20
> >   [PATCH RFC V5 12/30] arm/virt: Release objects for *disabled* possible
> >  vCPUs after init
> >    https://patchew.org/QEMU/20241015100012.254223-1-
> >  salil.mehta@huawei.com/20241015100012.254223-13-
> >  salil.mehta@huawei.com/ =20
>=20
>=20
> I think you missed what I mentioned above " The accompanying main series.=
..".
> To get more information about that series, please check the details menti=
oned
> in the cover-letter of the V3 patch-set (link below) which clearly says,
>=20
> https://lore.kernel.org/qemu-devel/20241103102419.202225-1-salil.mehta@hu=
awei.com/
>=20
> Excerpt from the cover letter:=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [...]
> This patch-set has been tested alongside ARM-specific
> vCPU hotplug changes (included in the upcoming RFC V6 [4]), and
> hot(un)plug functionalities performed as expected which concerns this
> patch-set. Please have a look.
> [...]
>=20
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [...]
> [4] Upcoming RFC V6, Support of Virtual CPU Hotplug for ARMv8 Arch
>     Link: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rf=
c-v6-rc5=20
> [...]

that v6 series is not posted to the list, so it can disappear
or change any moment. Using it as reference is pointless.
There is no point to comment on something that is not on
the list as later on the github branch can be totally different
from what it was at the time comment was made.=20

That is also a reason why (v3) ARM cpuhp specific ACPI patches
shouldn't have been merged separately from main series.

It was fine when generic acpi cpu hotplug patches where posted as
separate series as those were working with several different RFCs
for cpuhp for different targets that would reuse it.
However posting ARM specific cpuhp acpi changes separately,
without actual user along with them only lead to confusion
and mess we have now.

I suggest you to send revert for merged v3,
and resend those (fixed up) patches as part of main series
where they can be properly reviewed.

(or I can sent it along with a couple of RFC patches doing
the same but in acceptable way from ACPI pov.
The later could be picked up into your next main series)

> >  after this patch, new is_present hook would let you bury the lie about=
 CPU
> >  being present inside ARM specific code. =20
>=20
>=20
> I would request you to check the facts again! (please see previous pointe=
rs)
>=20
> ACPI logic should not worry about what is happening inside architecture
> code. It is beyond its realms and should be by design. It is an interfaci=
ng upper
> layer gelling the Guest with the VMM.
>=20
>=20
> >  > BTW, these changes have been tested by Oracle folks with that series
> >  > and are known to work.
> >  >
> >  > https://lore.kernel.org/qemu-devel/C4FEC9E7-69DB-428A-A85F- =20
> >  30170F98814 =20
> >  > B@oracle.com/ =20
> > =20
> >  One can write anything and it can even work somehow, that however
> >  doesn't mean it's something merge-able, maintainable, ...whatever else
> >  come to mind... =20
>=20
>=20
> It would be very helpful if you can `objectively` point the problems in t=
he
> main series so that there is a context and we can have a productive
> discussion there. There is always a scope of improvement.

I did point to problems in the past (the latest was v2 review),
repeating it now again.

Design wise issue is that ARM architecture doesn't support
cpu hotplug. That's the reason why ARM kernel folks haven't
implemented it there since it's not what hardware does.
Quotes from [2]
  'There is no hardware that does anything of this.'
  'Whatever is defined for virtual machines needs to work on physical
   hardware too =E2=80=93 the OS doesn=E2=80=99t know its in a VM'

Above is also a good reason not to try implementing it on
QEMU side as hotplug as well.

My suggestion was to try instead standby CPUs concept
that ARM does support, which looks like hotplug on
guest side (kernel largely freely mixes up hotplug term
with CPUs onlining).

The only reply I got to this:
unsure, and 'requirements' as if it set in stone and pushed on
QEMU using some presentations [2] as reference, which is basically
a set of issues and wishes plus some ideas how it could be achieved.
Those wishes are by no means any form of consensus on how things should be.

  * 'must reuse device_add/del for smooth transition from x86'

     this one I guess comes from flowing quote:
       'Should have look-and-feel of x86_64 platform VCPU hot-plug feature'
       and then accompanied kernel presentation phrase:
         'No appetite for updating numerous specifications to describe hotp=
lug support'

     On that one can easily counter:
       'then make it virt hardware behave like x86 and write specs for it,
        instead of hacking the heck out of QEMU'

     But that is beside the point, management software can easily adapt
     to dedicated QMP command to online CPUs without abusing device_add/del.
     ARM's 'cpu hotplug' doesn't have to be drop in replacement for ARM,
     you do configure ARM VM differently, you can do 'hotplug'
     differently as well, nothing prevents it beside having a will to do it.

  * 'for large VM to start fast'
       that one I guess, comes from following phrase:
          'allowing for faster boot time'
       but whole bullet point talks about scalability
          'Kata Containers VM starts with a minimum amount of resources, (h=
ot-plug everything)'
       that somehow turned in to requirement:
         'start VM as fast as if real CPU hotplug is supported regardless o=
f the costs'
       as result main series hack is to avoid creation of possible CPUs,
       Depending on series revision it ranged from creation of half initial=
ized vCPU
       objects and then deleting them to creating half initialized vCPU
       and letting them dangle in memory without completing its creation
       in the latest series incarnation (v6). And all of that is to avoid
       calling expensive in current impl. cpu_realize.
       The rest series is some necessary boiler plate code + other hacks
       trying to convince the rest of QEMU that dangling half initialized C=
PU objects
       are nothing to worry about.=20

     well with standby cpu design you can also have 'allowing for faster bo=
ot time'
     it is not as fast as x86 with its hotplug but still faster than onlini=
ng
     all possible CPUs at boot time on guest side.
     Even 'faster startup' wish is stretching things, one just puts off del=
ays
     to a later time in guest lifetime where every single vCPU hotplug
     incurs even bigger time penalty as guest kernel has to stop everything
     to hotplug a CPU.

     The point is: 'standby cpus' design also leads to faster boot
     on guest side compared normal boot with all vCPUs.
     As for comparing with even faster x86, fix cpu_realize to be
     faster (as I demonstrated in v2 review) or fix design to
     implement real hotplug [1], instead of another quote from [2]
          'Creative Hack =E2=80=93 Which Works! Really?'

So my suggestion to try 'standby cpus' approach still stays,
fully realizing CPUs.
Also, you can't reuse device_add with it as that means you'd be forced to
hack workflow one way or another for what it wasn't designed.
Add a new QMP command instead 'device-on/device-off' that
would fit standby concept better.

You will very likely end up with much simpler series that it's now,
probably even more simple than recent loongarch cpu hotplug [3]

PS:
1) If hotplug support is really need, try to convince ARM
to implement it (as minimum for virt environment,
that likely would require some spec & kernel work first).
Or wait until business needs wake up ARM's appetite to do it right.

2)
 KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Ho=
tplug on
    architectures that don=E2=80=99t Support CPU Hotplug (like ARM64)
    a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7=
OJ1YyJ.pdf
    b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_=
Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf

3)
PS2:
   As a recent example of platform that does have 'appetite' to implement '=
real' cpu hotplug see
      [PATCH v3 0/5] hw/loongarch/virt: Add cpu hotplug support
       https://lore.kernel.org/all/20241104063435.4130262-6-maobibo@loongso=
n.cn/T/
   and compare with ARM RFC,
   it looks much more cleaner and strait-forward than ARM variant when one
   doesn't need hack QEMU here and there to make it work.

PS3:
  joke:
     typical QEMU maintainer response to large series
       'rewrite half of QEMU 1st, then do you thing and we will see'
     ARM cpuhp gets much milder treatment
       'rewrite your series in other way that matches real world'

> Many thanks!
>=20
> Best regards
> Salil.
>=20
>=20


