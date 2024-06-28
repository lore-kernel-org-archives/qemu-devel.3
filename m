Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7E7C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 03:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN1uv-0006P2-3G; Thu, 27 Jun 2024 23:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sN1ur-0006Ol-LT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 23:04:49 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sN1um-0002If-AA
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 23:04:48 -0400
To: Igor Mammedov <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>
Subject: Re: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Topic: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Index: AQHayQfjqB1yzA8L7E6Vor5BZay2kg==
Date: Fri, 28 Jun 2024 03:04:28 +0000
Message-ID: <6d033738d79d4b9a83fe216679f8e587@baidu.com>
References: <20240625035224.13019-1-gaoshiyuan@baidu.com>,
 <20240627154548.74a969c2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240627154548.74a969c2@imammedo.users.ipa.redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.78]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.49
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> > that OS cannot get control of SHPC hotplug and hotplug device to
> > the PCI bridge will fail when we use SHPC Native type:
> >
> >=A0=A0 [3.336059] shpchp 0000:00:03.0: Requesting control of SHPC hotplu=
g via OSHP (\_SB_.PCI0.S28_)
> >=A0=A0 [3.337408] shpchp 0000:00:03.0: Requesting control of SHPC hotplu=
g via OSHP (\_SB_.PCI0)
> >=A0=A0 [3.338710] shpchp 0000:00:03.0: Cannot get control of SHPC hotplu=
g
> >
> > Add OSHP method support for transfer control to the operating system,
> > after this SHPC driver will be loaded success and the hotplug device to
> > the PCI bridge will success when we use SHPC Native type.
> >
> >=A0=A0 [1.703975] shpchp 0000:00:03.0: Requesting control of SHPC hotplu=
g via OSHP (\_SB_.PCI0.S18_)
> >=A0=A0 [1.704934] shpchp 0000:00:03.0: Requesting control of SHPC hotplu=
g via OSHP (\_SB_.PCI0)
> >=A0=A0 [1.705855] shpchp 0000:00:03.0: Gained control of SHPC hotplug (\=
_SB_.PCI0)
> >=A0=A0 [1.707054] shpchp 0000:00:03.0: HPC vendor_id 1b36 device_id 1 ss=
_vid 0 ss_did 0
>
> please describe in commit message reproducer
> (aka QEMU CLI and guest OS and if necessary other details)

qemu-system-x86_64 -machine pc-q35-9.0
    ...
    -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=3Doff

guest OS: centos7/ubuntu22.04

I will add it in the next version.

> > +/*
> > + * PCI Firmware Specification 3.0
> > + * 4.8. The OSHP Control Method
> > + */
> > +static Aml *build_oshp_method(void)
> > +{
> > +=A0=A0=A0 Aml *method;
> > +
> > +=A0=A0=A0 /*
> > +=A0=A0=A0=A0 * We don't use ACPI to control the SHPC, so just return
> > +=A0=A0=A0=A0 * success is enough.
> > +=A0=A0=A0=A0 */
> > +=A0=A0=A0 method =3D aml_method("OSHP", 0, AML_NOTSERIALIZED);
> > +=A0=A0=A0 aml_append(method, aml_return(aml_int(0x0)));
> > +=A0=A0=A0 return method;
> > +}
> > +
> >=A0 static void
> >=A0 build_dsdt(GArray *table_data, BIOSLinker *linker,
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AcpiPmInfo *pm, AcpiMiscInfo *misc,
> > @@ -1452,6 +1469,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, aml_name_decl("_HID", aml_ei=
said("PNP0A03")));
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, aml_name_decl("_UID", aml_in=
t(pcmc->pci_root_uid)));
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, aml_pci_edsm());
> > +=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, build_oshp_method());
>
> it's global and what will happen if we have ACPI PCI hotplug enabled
> and guest calls this NOP method?

ths OS get the control of SHPC hotplug and SHPC driver load fail later.

[    6.170345] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via =
OSHP (\_SB_.PCI0.S18_)
[    6.171962] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via =
OSHP (\_SB_.PCI0)
[    6.173556] shpchp 0000:00:03.0: Gained control of SHPC hotplug (\_SB_.P=
CI0)
[    6.175144] shpchp 0000:00:03.0: HPC vendor_id 1b36 device_id 1 ss_vid 0=
 ss_did 0
[    6.196153] shpchp 0000:00:03.0: irq 24 for MSI/MSI-X
[    6.197211] shpchp 0000:00:03.0: pci_hp_register failed with error -16
[    6.198272] shpchp 0000:00:03.0: Slot initialization failed

this looks more suitable.

+    if (!pm->pcihp_bridge_en) {
+        aml_append(dev, build_i440fx_oshp_method());
+    }

>
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(sb_scope, dev);
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dsdt, sb_scope);
> >
> > @@ -1586,6 +1604,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, buil=
d_q35_osc_method(true));
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, aml_=
name_decl("_HID", aml_eisaid("PNP0A03")));
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, build_os=
hp_method());
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (numa_node !=3D NUMA_NODE_UNA=
SSIGNED) {

Hot plug/unplug a device using SHPC will take more time than ACPI PCI hotpl=
ug, because
after pressing the button, it can be cancelled within 5 seconds in SHPC dri=
ver.

If I want to use ACPI PCI hotplug in the pxb bridge, what else need to be d=
one?

thanks.=

