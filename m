Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DFCC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 09:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCamn-00059U-PJ; Wed, 07 May 2025 05:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCako-0002JE-Hd; Wed, 07 May 2025 05:07:54 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCakj-0002sZ-VX; Wed, 07 May 2025 05:07:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZsprG3tStz6K9dp;
 Wed,  7 May 2025 16:50:38 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 9ED0D1400D9;
 Wed,  7 May 2025 16:50:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 May 2025 10:50:51 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 7 May 2025 10:50:51 +0200
To: Markus Armbruster <armbru@redhat.com>, Donald Dutile <ddutile@redhat.com>
CC: Shameer Kolothum via <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Topic: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Index: AQHbu1V0fvNxmQCU0kS/eGPfhGB2G7PFgqACgAB1wICAANEzi4AAFpHg
Date: Wed, 7 May 2025 08:50:51 +0000
Message-ID: <72f9043a73294bfc9b539ae9b94836d3@huawei.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
 <87frhglwjl.fsf@pond.sub.org>
In-Reply-To: <87frhglwjl.fsf@pond.sub.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Markus Armbruster <armbru@redhat.com>
> Sent: Wednesday, May 7, 2025 8:17 AM
> To: Donald Dutile <ddutile@redhat.com>
> Cc: Shameer Kolothum via <qemu-devel@nongnu.org>; qemu-
> arm@nongnu.org; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; eric.auger@redhat.com;
> peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
> berrange@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
> smostafa@google.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>;
> zhangfei.gao@linaro.org
> Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a
> PCIe RC
>=20
> Donald Dutile <ddutile@redhat.com> writes:
>=20
> [...]
>=20
> > In this series, an iommu/smmu needs to be placed -BETWEEN- a sysbus
> and a PCIe-tree,
> > or step-wise, plug an smmuv3 into a sysbus, and a pcie tree/domain/RC
> into an SMMUv3.
>=20
> RC =3D root complex?

Yes.

>=20
> > So, an smmu needs to be associated with a bus (tree), i.e., pcie.0, pci=
e.1...
> > One could model it as a PCIe device, attached at the pcie-RC ... but th=
at's
> not how it's modelled in ARM hw.
>=20
> Physical ARM hardware?
>=20
> Assuming the virtual devices and buses we're discussing model physical
> devices and buses:
>=20
> * What are the physical devices of interest?
>=20
> * How are they wired together?  Which of the wires are buses, in
>   particular PCI buses?

SMMUv3 is a platform device and its placement in a system is typically as b=
elow
for PCI devices,

+------------------+
|   PCIe Devices   |
+------------------+
         |
         v
  +-------------+      +---------------+
  |  PCIe RC A  |<---->| Interconnect  |
  +-------------+      +---------------+
                               |
                               |
                        +------v---+
                        | SMMUv3.A |
                        | (IOMMU)  |
                        +----+-----+
                             |
                             v
                     +-------+--------+
                     |   System RAM   |
                     +----------------+
=20
This patch is attempting to establish that association between the PCIe RC =
and=20
the SMMUv3 device so that Qemu can build the ACPI tables/DT iommu mappings =
=20
for the SMMUv3 device.

> > SMMU's are discovered via ACPI tables.
> >
> > That leaves us back to the 'how to associate an SMMUv3 to a PCIe
> tree(RC)',
> > and that leads me to the other discussion & format I saw btwn Eric &
> Shameer:
> >  -device arm-smmv3,id=3Dsmmuv3.3
> >  -device xxxx,smmuv3=3D smmuv3.3
> > where one tags a (PCIe) device to an smmuv3(id), which is needed to bui=
ld
> the (proper) IORT for (pcie-)device<->SMMUv3 associativity in a multi-
> SMMUv3 configuration.
> >
> > We could keep the bus=3Dpcie.X option for the -device arm-smmuv3 to
> indicate that all PCIe devices connected to the pcie.0 tree go through th=
at
> smmuv3;
> > qdev would model/config as the smmuv3 is 'attached to pcie.0'... which =
it
> sorta is...  and I think the IORT build could associate all devices on pc=
ie.0 to
> be associated
> > with the proper smmuv3.
>=20
> Device property "bus" is strictly for specifying into which the bus the
> device is to be plugged.  The device's type must match the bus: only a
> PCI device can plug into a PCI bus, and so forth.

The whole idea of reusing the "bus" property for SMMUv3 device was to make
it easier for libvirt. As I mentioned earlier we could go back and use a di=
fferent
property name like "primary-bus" or "pci-bus" for SMMUv3 dev here.

Thanks,
Shameer

