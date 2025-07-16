Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843EBC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyQP-0006uA-T1; Wed, 16 Jul 2025 05:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubyQM-0006rk-Su; Wed, 16 Jul 2025 05:27:38 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubyQH-0008Kw-Tn; Wed, 16 Jul 2025 05:27:38 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhrGK1w8Bz6L53d;
 Wed, 16 Jul 2025 17:23:53 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 826591404A6;
 Wed, 16 Jul 2025 17:27:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Jul 2025 11:27:25 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 16 Jul 2025 11:27:25 +0200
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
Subject: RE: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Topic: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Index: AQHb9NhIGqv2DKEgZE6UQbgEjow1nbQy4MqAgABv5oCAAKpOAIAAglBA
Date: Wed, 16 Jul 2025 09:27:25 +0000
Message-ID: <6ee7908c8ea44270b9f4aa64abacaace@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136ACFB4721D47304A9885C9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaP3ULG90gGqWHJ@Asurada-Nvidia>
 <IA3PR11MB9136C94472D7D50CDC627CB49256A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136C94472D7D50CDC627CB49256A@IA3PR11MB9136.namprd11.prod.outlook.com>
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
> Sent: Wednesday, July 16, 2025 4:39 AM
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
> Subject: RE: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce
> smmuv3 accel device
>=20
>=20
>=20
> >-----Original Message-----
> >From: Nicolin Chen <nicolinc@nvidia.com>
> >Subject: Re: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce
> >smmuv3 accel device
> >
> >On Tue, Jul 15, 2025 at 10:48:31AM +0000, Duan, Zhenzhong wrote:
> >> >+static const TypeInfo types[] =3D {
> >> >+    {
> >> >+        .name =3D TYPE_ARM_SMMUV3_ACCEL,
> >> >+        .parent =3D TYPE_ARM_SMMUV3,
> >> >+        .class_init =3D smmuv3_accel_class_init,
> >> >+    }
> >>
> >> In cover-letter, I see "-device arm-smmuv3", so where is above accel
> >> device created so we could use smmuv3_accel_ops?
> >
> >The smmu-common.c is the shared file between accel and non-accel
> >instances. It has a module property:
> >    DEFINE_PROP_BOOL("accel", SMMUState, accel, false),
>=20
> It looks we expose a new TYPE_ARM_SMMUV3_ACCEL type device just for
> exporting accel iommu_ops?
> What about returning accel iommu_ops directly in
> smmu_iommu_ops_by_type() and drop the new type?

We are not creating any new device here. Its just a Class object of differe=
nt type.
I had a different approach previously and Eric suggested to try this as the=
re
are examples in VFIO/IOMMUFD for something like this.

https://lore.kernel.org/qemu-devel/1105d100-dd1e-4aca-b518-50f903967416@red=
hat.com/

Thanks,
Shameer

> >
> >where it directs to different iommu_ops:
> >937 static const PCIIOMMUOps *smmu_iommu_ops_by_type(SMMUState
> *s)
> >938 {
> >939     SMMUBaseClass *sbc;
> >940
> >941     if (s->accel) {
> >942         sbc =3D
> >ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMUV3_ACCEL));
> >943     } else {
> >944         sbc =3D
> >ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMU));
> >945     }
> >946     assert(sbc->iommu_ops);
> >947
> >948     return sbc->iommu_ops;
> >949 }
> >
> >Nicolin


