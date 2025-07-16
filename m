Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB9AC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 08:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubxKi-00043v-9D; Wed, 16 Jul 2025 04:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubxA2-0003Ri-LQ; Wed, 16 Jul 2025 04:06:43 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubx9y-000824-Td; Wed, 16 Jul 2025 04:06:42 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhpWb1tGhz6M4hS;
 Wed, 16 Jul 2025 16:05:15 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 6635B14027A;
 Wed, 16 Jul 2025 16:06:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Jul 2025 10:06:30 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 16 Jul 2025 10:06:29 +0200
To: Nicolin Chen <nicolinc@nvidia.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>
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
Thread-Index: AQHb9NhJqDDdVP51l0m0Xe+3c+VdWbQy4kYAgAB23gCAAQTY8A==
Date: Wed, 16 Jul 2025 08:06:29 +0000
Message-ID: <756cf804fbd14d66ba8f23358524fe96@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
In-Reply-To: <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, July 15, 2025 6:59 PM
> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Cc: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
> qemu-devel@nongnu.org; eric.auger@redhat.com;
> peter.maydell@linaro.org; jgg@nvidia.com; ddutile@redhat.com;
> berrange@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
> smostafa@google.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>;
> zhangfei.gao@linaro.org; shameerkolothum@gmail.com
> Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
> accelerated SMMUv3 to vfio-pci endpoints with iommufd

...

> > >+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
> > >+        error_report("Device(%s) not allowed. Only PCIe root complex
> > >devices "
> > >+                     "or PCI bridge devices or vfio-pci endpoint devi=
ces
> > >with "
> > >+                     "iommufd as backend is allowed with
> > >arm-smmuv3,accel=3Don",
> > >+                     pdev->name);
> > >+        exit(1);
> >
> > Seems aggressive for a hotplug, could we fail hotplug instead of kill
> QEMU?

That's right. I will try to see whether it is possible to do a dev->hotplug=
ged
check here.
=20
> Hotplug will unlikely be supported well, as it would introduce
> too much complication.
>=20
> With iommufd, a vIOMMU object is allocated per device (vfio). If
> the device fd (cdev) is not yet given to the QEMU. It isn't able
> to allocate a vIOMMU object when creating a VM.
>=20
> While a vIOMMU object can be allocated at a later stage once the
> device is hotplugged. But things like IORT mappings aren't able
> to get refreshed since the OS is likely already booted.

Why do we need IORT mappings to be refreshed during hotplug?
AFAICS, the mappings are created per host bridge Ids. And how is this
different from a host machine doing hotplug?

 Even an
> IOMMU capability sync via the hw_info ioctl will be difficult to
> do at the runtime post the guest iommu driver's initialization.

We had some discussion on this "at least one vfio-pci" restriction
for accelerated mode previously here.
https://lore.kernel.org/qemu-devel/Z6TtCLQ35UI12T77@redhat.com/#t

I am not sure we reached any consensus on that. The 3 different approaches
discussed were,

1. The current one used here. At least one cold plugged vfio-pci device
   so that  we can retrieve the host SMMUV3 HW_INFO as per current
  IOMMUFD APIs.

2. A new IOMMUFD API to retrieve HW_INFO without a device.=20

3. A fully specified vSMMUv3 through Qemu command line so that we
   don't need HW_INFO from kernel.

We're going with option one for now, but completely blocking hotplug
because of it  feels a bit too restrictive to me.

The real issue (for now), as I see it, is that we need some way to remember
the Guest SMMUv3 <-> Host SMMUv3 mapping after the guest has booted.
That way, even if all devices tied to a Guest SMMUv3 get hot-unplugged,
QEMU can still block attaching a device that belongs to a different Host
SMMUv3.

Thanks,
Shameer

> I am not 100% sure. But I think Intel model could have a similar
> problem if the guest boots with zero cold-plugged device and then
> hot-plugs a PASID-capable device at the runtime, when the guest-
> level IOMMU driver is already inited?
>=20
> FWIW, Shameer's cover-letter has the following line:
>  "At least one vfio-pci device must currently be cold-plugged to
>   a PCIe root complex associated with arm-smmuv3,accel=3Don."
>=20
> Perhaps there should be a similar highlight in this smmuv3-accel
> file as well (@Shameer).
>=20
> Nicolin

