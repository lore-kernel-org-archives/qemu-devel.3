Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E1ED44D75
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 14:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8hIU-0005RC-0t; Wed, 06 Nov 2024 09:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8hID-0005Pt-SC; Wed, 06 Nov 2024 09:46:03 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8hI5-00060N-73; Wed, 06 Nov 2024 09:45:56 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xk7Gm55Vfz6J6sP;
 Wed,  6 Nov 2024 22:42:56 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 36396140B2F;
 Wed,  6 Nov 2024 22:45:44 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 15:45:42 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 6 Nov 2024 15:45:42 +0100
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
Thread-Index: AQHbMExwRTIJtUKJlEic/SrRi9Z39bKqNgWAgAAbf+A=
Date: Wed, 6 Nov 2024 14:45:42 +0000
Message-ID: <28a19ad7554e4b70819e1435669eeba3@huawei.com>
References: <20241106130331.205020-1-salil.mehta@huawei.com>
 <20241106130331.205020-3-salil.mehta@huawei.com>
 <20241106145635.77332d7c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241106145635.77332d7c@imammedo.users.ipa.redhat.com>
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

>  From: qemu-arm-bounces+salil.mehta=3Dhuawei.com@nongnu.org <qemu-
>  arm-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of Igor
>  Mammedov
>  Sent: Wednesday, November 6, 2024 1:57 PM
>  To: Salil Mehta <salil.mehta@huawei.com>
> =20
>  On Wed, 6 Nov 2024 13:03:30 +0000
>  Salil Mehta <salil.mehta@huawei.com> wrote:
> =20
>  > Checking `is_present` first can break x86 migration from new Qemu
>  > version to old Qemu. This is because CPRS Bit is not defined in the
>  > older Qemu register block and will always be 0 resulting in check
>  > always failing. Reversing the logic to first check `is_enabled` can
>  > alleviate below problem:
>  >
>  > -                If ((\_SB.PCI0.PRES.CPEN =3D=3D One))
>  > -                {
>  > -                    Local0 =3D 0x0F
>  > +                If ((\_SB.PCI0.PRES.CPRS =3D=3D One))
>  > +                {
>  > +                    If ((\_SB.PCI0.PRES.CPEN =3D=3D One))
>  > +                    {
>  > +                        Local0 =3D 0x0F
>  > +                    }
>  > +                    Else
>  > +                    {
>  > +                        Local0 =3D 0x0D
>  > +                    }
>  >                  }
>  >
>  > Suggested-by: Igor Mammedov <imammedo@redhat.com>
>  'Reported-by' maybe, but certainly not suggested.


No issues. I can change.


> =20
>  After more thinking and given presence is system wide that doesn't chang=
e
>  at runtime, I don't see any reason for introducing presence bit as ABI (=
and
>  undocumented on top of that).


This is a wrong assumption. Presence bit can change in future. We have take=
n
into account this aspect by design in the kernel code as well. Both virtual
and physical CPU hot plug can co-exists or entirely as sole features.  This=
 is
a requirement.


> =20
>  Instead changing AML code to account for it would be better, something l=
ike
>  this:
> =20
>  diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h index
>  32654dc274..4a3e591120 100644
>  --- a/include/hw/acpi/cpu.h
>  +++ b/include/hw/acpi/cpu.h
>  @@ -55,6 +55,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object
>  *owner,  typedef struct CPUHotplugFeatures {
>       bool acpi_1_compatible;
>       bool has_legacy_cphp;
>  +    bool always_present_cpus;


This has to be fetched from architecture code. Please see other changes in =
the V3
patch-set.


>       bool fw_unplugs_cpu;
>       const char *smi_path;
>   } CPUHotplugFeatures;
>  diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index 5cb60ca8bc..2bcce2b31c
>  100644
>  --- a/hw/acpi/cpu.c
>  +++ b/hw/acpi/cpu.c
>  @@ -452,15 +452,16 @@ void build_cpus_aml(Aml *table, MachineState
>  *machine, CPUHotplugFeatures opts,
> =20
>           method =3D aml_method(CPU_STS_METHOD, 1, AML_SERIALIZED);
>           {
>  +            uint8_t default_sta =3D opts.always_present_cpus?0xd:0;
>               Aml *idx =3D aml_arg(0);
>  -            Aml *sta =3D aml_local(0);
>  +            Aml *sta =3D aml_local(default_sta);
> =20
>               aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
>               aml_append(method, aml_store(idx, cpu_selector));
>               aml_append(method, aml_store(zero, sta));
>               ifctx =3D aml_if(aml_equal(is_enabled, one));
>               {
>  -                aml_append(ifctx, aml_store(aml_int(0xF), sta));
>  +                aml_append(ifctx, aml_or(aml_int(0xF), sta, sta));
>               }
>               aml_append(method, ifctx);
>               aml_append(method, aml_release(ctrl_lock))
> =20
>  then for ARM set
>   CPUHotplugFeatures::always_present_cpus =3D true to get present flag
>  always enabled


We MUST fetch this from architecture code as this can dynamically change in
future and hence, we need to keep that flexibility

> =20
>  After that revert _all_ other presence bit related changes that were jus=
t
>  merged.
>  (I did ask to get rid of that in previous reviews but it came back again=
 for no
>  good reason).


The CPUs AML in the V2 patch-set would have broken the x86 functionality.


Thanks
Salil.


