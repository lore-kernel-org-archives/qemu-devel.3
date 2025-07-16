Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1F5C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyWh-0005rC-FU; Wed, 16 Jul 2025 05:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubyWf-0005n4-M9; Wed, 16 Jul 2025 05:34:09 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubyWd-00010z-CH; Wed, 16 Jul 2025 05:34:09 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhrSd2SCyz6M4lc;
 Wed, 16 Jul 2025 17:32:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 868551404FE;
 Wed, 16 Jul 2025 17:34:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Jul 2025 11:34:04 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 16 Jul 2025 11:34:04 +0200
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Topic: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHb9NhJqDDdVP51l0m0Xe+3c+VdWbQy4kYAgAB23gCAANCmgIAAVFUw
Date: Wed, 16 Jul 2025 09:34:04 +0000
Message-ID: <798f739303f74fbca49a09a623a0a118@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
 <IA3PR11MB9136E0D793F99E3837D208229256A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136E0D793F99E3837D208229256A@IA3PR11MB9136.namprd11.prod.outlook.com>
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
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: Wednesday, July 16, 2025 7:26 AM
> To: Nicolin Chen <nicolinc@nvidia.com>
> Cc: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
> qemu-devel@nongnu.org; eric.auger@redhat.com;
> peter.maydell@linaro.org; jgg@nvidia.com; ddutile@redhat.com;
> berrange@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
> smostafa@google.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>;
> zhangfei.gao@linaro.org; shameerkolothum@gmail.com
> Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
> accelerated SMMUv3 to vfio-pci endpoints with iommufd
>=20

...

> >> >+static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool
> >*vfio_pci)
> >> >+{
> >> >+
> >> >+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
> >> >+        object_dynamic_cast(OBJECT(pdev), "pxb-pcie") ||
> >> >+        object_dynamic_cast(OBJECT(pdev), "gpex-root")) {
> >> >+        return true;
> >> >+    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI) &&
> >> >+        object_property_find(OBJECT(pdev), "iommufd"))) {
> >>
> >> Will this always return true?
> >
> >It won't if a vfio-pci device doesn't have the "iommufd" property?
>=20
> IIUC, iommufd property is always there, just value not filled for legacy
> container case.
> What about checking VFIOPCIDevice.vbasedev.iommufd?

That's right. The property is always there. But instead of accessing VFIOPC=
IDevice
in SMMUv3 code, I think we can use object_property_get_link(obj, "iommufd",=
 &error_abort)
instead?
=20
> >
> >> >+        *vfio_pci =3D true;
> >> >+        return true;
> >> >+    }
> >> >+    return false;
> >
> >Then, it returns "false" here.
> >
> >> > static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void
> >> >*opaque,
> >> >                                               int devfn)
> >> > {
> >> >+    PCIDevice *pdev =3D pci_find_device(bus, pci_bus_num(bus), devfn=
);
> >> >     SMMUState *bs =3D opaque;
> >> >+    bool vfio_pci =3D false;
> >> >     SMMUPciBus *sbus;
> >> >     SMMUv3AccelDevice *accel_dev;
> >> >     SMMUDevice *sdev;
> >> >
> >> >+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
> >> >+        error_report("Device(%s) not allowed. Only PCIe root complex
> >> >devices "
> >> >+                     "or PCI bridge devices or vfio-pci endpoint
> >devices
> >> >with "
> >> >+                     "iommufd as backend is allowed with
> >> >arm-smmuv3,accel=3Don",
> >> >+                     pdev->name);
> >> >+        exit(1);
> >>
> >> Seems aggressive for a hotplug, could we fail hotplug instead of kill
> QEMU?
> >
> >Hotplug will unlikely be supported well, as it would introduce
> >too much complication.
> >
> >With iommufd, a vIOMMU object is allocated per device (vfio). If
> >the device fd (cdev) is not yet given to the QEMU. It isn't able
> >to allocate a vIOMMU object when creating a VM.
> >
> >While a vIOMMU object can be allocated at a later stage once the
> >device is hotplugged. But things like IORT mappings aren't able
> >to get refreshed since the OS is likely already booted. Even an
> >IOMMU capability sync via the hw_info ioctl will be difficult to
> >do at the runtime post the guest iommu driver's initialization.
> >
> >I am not 100% sure. But I think Intel model could have a similar
> >problem if the guest boots with zero cold-plugged device and then
> >hot-plugs a PASID-capable device at the runtime, when the guest-
> >level IOMMU driver is already inited?
>=20
> For vtd we define a property for each capability we care about.
> When hotplug a device, we get hw_info through ioctl and compare
> host's capability with virtual vtd's property setting, if incompatible,
> we fail the hotplug.
>=20
> In old implementation we sync host iommu caps into virtual vtd's cap,
> but that's Naked by maintainer. The suggested way is to define property
> for each capability we care and do compatibility check.
>=20
> There is a "pasid" property in virtual vtd, only when it's true, the PASI=
D-
> capable
> device can work with pasid.

Thanks for this information. I think probably we need to take a look at thi=
s as
this doesn't have a dependency on cold-plug device to be present for SMMUv3=
.
Will go through intel vtd implementation.

Thanks,
Shameer



