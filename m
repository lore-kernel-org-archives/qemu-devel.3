Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E94C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 08:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubxdL-0002dl-PE; Wed, 16 Jul 2025 04:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubxdH-0002Zl-6u; Wed, 16 Jul 2025 04:36:55 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubxdA-00069S-NX; Wed, 16 Jul 2025 04:36:54 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhqBS5JDVz6DJdC;
 Wed, 16 Jul 2025 16:35:28 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 119B71400D7;
 Wed, 16 Jul 2025 16:36:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Jul 2025 10:36:38 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 16 Jul 2025 10:36:38 +0200
To: Nicolin Chen <nicolinc@nvidia.com>
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
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 09/15] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Thread-Topic: [RFC PATCH v3 09/15] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Thread-Index: AQHb9SEIjYQyBzgBgkK3ICXEi4CvUbQzsC+AgAC6xIA=
Date: Wed, 16 Jul 2025 08:36:38 +0000
Message-ID: <6110ab250e844af9982dddb230fb8707@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-10-shameerali.kolothum.thodi@huawei.com>
 <aHbgc8LXuuuJ/cz0@Asurada-Nvidia>
In-Reply-To: <aHbgc8LXuuuJ/cz0@Asurada-Nvidia>
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
> Sent: Wednesday, July 16, 2025 12:13 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
> mochs@nvidia.com; smostafa@google.com; Linuxarm
> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; shameerkolothum@gmail.com
> Subject: Re: [RFC PATCH v3 09/15] hw/arm/smmuv3-accel: Support nested
> STE install/uninstall support
>=20
> On Mon, Jul 14, 2025 at 04:59:35PM +0100, Shameer Kolothum wrote:
> > +static void
> > +smmuv3_accel_ste_range(gpointer key, gpointer value, gpointer
> user_data)
> > +{
> > +    SMMUDevice *sdev =3D (SMMUDevice *)key;
> > +    uint32_t sid =3D smmu_get_sid(sdev);
> > +    SMMUSIDRange *sid_range =3D (SMMUSIDRange *)user_data;
> > +
> > +    if (sid >=3D sid_range->start && sid <=3D sid_range->end) {
> > +        SMMUv3State *s =3D sdev->smmu;
> > +        SMMUState *bs =3D &s->smmu_state;
> > +
> > +        smmuv3_accel_install_nested_ste(bs, sdev, sid);
> > +    }
> > +}
> > +
> > +void
> > +smmuv3_accel_install_nested_ste_range(SMMUState *bs,
> SMMUSIDRange *range)
> > +{
> > +    if (!bs->accel) {
> > +        return;
> > +    }
> > +
> > +    g_hash_table_foreach(bs->configs, smmuv3_accel_ste_range, range);
>=20
> This will not work correctly?
>=20
> The bs->configs is a cache that gets an entry inserted to when a
> config is fetched via smmuv3_get_config(), which gets invoked by
> smmuv3_notify_iova() and smmuv3_translate() only.
>=20
> But CMDQ_OP_CFGI_ALL can actually happen very early, e.g. Linux
> driver does that in the probe() right after SMMU CMDQ is enabled,
> at which point neither smmuv3_notify_iova nor smmuv3_translate
> could ever get invoked, meaning that the g_hash_table is empty.
>=20
> Without the acceleration, this foreach works because vSMMU does
> not need to do anything since the cache is indeed empty.
>=20
> But, with accel, it must call smmuv3_accel_install_nested_ste().

Ok. The only place I can see CMDQ_OP_CFGI_ALL get invoked by Linux
kernel is during arm_smmu_device_reset() and that is to clear all.
But I am not sure we will have any valid STEs at that time. Just curious,
are you seeing any issues with this at the moment?
=20
> So, I think this should foreach the viommu->device_list instead.

But agree. Using device_list is more appropriate unless we cache the=20
configs during each install_netsed_ste() path.

Thanks,
Shameer=20

