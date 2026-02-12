Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDB4EB491F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 12:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqWGz-00052L-VC; Thu, 12 Feb 2026 07:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqWGy-00052B-Jj
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 07:58:20 -0500
Received: from smtppost.atos.net ([193.56.114.177] helo=smarthost2.atos.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqWGv-0005pr-Ca
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 07:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1770901098; x=1802437098;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ecmtEfN/OaF+oLKDzcjn422npJeMagJvuqY0Mp47CeI=;
 b=sadQFlN2H63xuPOUDHcEsUictxRAURJE99OFGaXpD5S3691nyHJYuF8f
 sXbYC+R7htVKMQVolKEUUk95FKH+KE5iO9s5rhHiS87mjhE7PUzSw6I1F
 z5QyGzplZIUnKzQSAKqGoWyTHWnsUkTVBQz0tB+4RhJudBslXCg7aUPLI
 G9GQBjGUCJiay0svHubbptLglF5aIaaZv09jgDjf5sfXXRNS1DQNGwHx4
 VJkqpGXHupnOACwZZ4qIsuU7YozPUoxuorcCXCz+0e+1rEMIGlJ6qpPiv
 GztLxWUHUA8kRaJLBF5BThmWrMfOuR63dKYWyTKrpwf/sjW38UBIa5WnQ g==;
X-CSE-ConnectionGUID: LdJkjBRwQO6gdUhdbGhABg==
X-CSE-MsgGUID: /zSMIyGSTIqsL9TFK+pXmA==
X-IronPort-AV: E=Sophos;i="6.21,286,1763420400"; d="scan'208";a="826733865"
X-MGA-submission: =?us-ascii?q?MDHgC+lYIpAdESypIBP4+2UHKbBdJGn6gB1Br3?=
 =?us-ascii?q?tJOQIsUVzhzICybbHdTYnu109d0H5dhAirsLOxxtvZWAIbceQsom82S2?=
 =?us-ascii?q?yn7ix4itcyT5ddmd5tF0FVwlHwy726gzhAgy41Ji5fs1kMNtJ2SSumXY?=
 =?us-ascii?q?v5?=
Received: from smtp1.atos-infogerance.fr ([193.56.241.17])
 by smarthost2.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Feb 2026 13:58:15 +0100
Received: from smtp-hub.atos-infogerance.fr (smtp-hub.atos-infogerance.fr
 [193.56.47.18])
 by smtp1.atos-infogerance.fr (8.15.2/8.15.2) with ESMTPS id 61CCwDfb006356
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Thu, 12 Feb 2026 13:58:13 +0100
Received: from rocky.hd2c.dom ([129.181.244.14])
 by smtp-hub.atos-infogerance.fr (envelope-from
 clement.mathieu--drif@eviden.com) (8.15.2/8.15.2) with ESMTP id
 61CCwDGm025604; Thu, 12 Feb 2026 13:58:13 +0100
Received: from openbmc (unknown [10.22.85.22])
 by rocky.hd2c.dom (Postfix) with ESMTP id E72AA256CA5;
 Thu, 12 Feb 2026 13:58:12 +0100 (CET)
Received: from [127.0.0.1] (host.containers.internal [10.88.0.1])
 by openbmc (Postfix) with ESMTP id 107A6248987;
 Thu, 12 Feb 2026 12:58:12 +0000 (UTC)
Message-ID: <efa471d513bb227e41ba466fb0e9f7e46fe491d7.camel@eviden.com>
Subject: Re: [RFC PATCH 04/14] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com"	 <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"	
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com"	 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"	
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L"	 <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Date: Thu, 12 Feb 2026 13:57:51 +0100
In-Reply-To: <IA3PR11MB9136CD500D64456273F3202B9260A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-5-zhenzhong.duan@intel.com>
 <669e9b9b6fe10f797d8d9571c7327c8a5617ae3f.camel@eviden.com>
 <IA3PR11MB9136CD500D64456273F3202B9260A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
Received-SPF: pass client-ip=193.56.114.177;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.atos.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On Thu, 2026-02-12 at 08:33 +0000, Duan, Zhenzhong wrote:
>=20
>=20
>=20
> > -----Original Message-----
> > From: Clement Mathieu--Drif <[clement.mathieu--drif@eviden.com](mailto:=
clement.mathieu--drif@eviden.com)>
> > Subject: Re: [RFC PATCH 04/14] intel_iommu: Create the nested hwpt with
> > IOMMU_HWPT_ALLOC_PASID flag
> >=20
> >=20
> > On Wed, 2026-02-04 at 22:11 -0500, Zhenzhong Duan wrote:
> >=20
> > > When pasid is enabled, any hwpt attached to non-PASID or PASID should=
 be
> > > IOMMU_HWPT_ALLOC_PASID flagged, or else attachment fails.
> > >=20
> > > Signed-off-by: Zhenzhong Duan
> >=20
> > <[[zhenzhong.duan@intel.com](mailto:zhenzhong.duan@intel.com)](mailto:[=
zhenzhong.duan@intel.com](mailto:zhenzhong.duan@intel.com))>
> >=20
> > > ---
> > > =C2=A0hw/i386/intel_iommu_accel.c | 10 ++++++----
> > > =C2=A01 file changed, 6 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.=
c
> > > index 67d54849f2..d61cfec1e6 100644
> > > --- a/hw/i386/intel_iommu_accel.c
> > > +++ b/hw/i386/intel_iommu_accel.c
> > > @@ -69,11 +69,13 @@ VTDHostIOMMUDevice
> >=20
> > *vtd_find_hiod_iommufd(VTDAddressSpace *as)
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > > =C2=A0}
> > >=20
> > > -static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> > > +static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
> >=20
> >=20
> > Does this change break naming consistency?
>=20
>=20
> Yes, because we need to check vtd_hiod->iommu_state->pasid in vtd_create_=
fs_hwpt() but not in vtd_destroy_old_fs_hwpt().
>=20
> We can change vtd_destroy_old_fs_hwpt() to also pass vtd_hiod or add a ne=
w =20
> parameter 'iommu_state *s' to vtd_create_fs_hwpt().

First solution lgtm

>=20
>=20
>=20
> > Other functions use use idev for HostIOMMUDeviceIOMMUFD structures
>=20
>=20
> Do you see others except vtd_destroy_old_fs_hwpt()?

I don't think so

Thanks !

>=20
> Thanks =20
> Zhenzhong
>=20
>=20
>=20
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VTDPASIDEntry *pe, uint32_t *fs_=
hwpt_id,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
> > > =C2=A0{
> > > +=C2=A0=C2=A0=C2=A0 HostIOMMUDeviceIOMMUFD *idev =3D
> >=20
> > HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 struct iommu_hwpt_vtd_s1 vtd =3D {};
> > > +=C2=A0=C2=A0=C2=A0 uint32_t flags =3D vtd_hiod->iommu_state->pasid ?
> >=20
> > IOMMU_HWPT_ALLOC_PASID : 0;
> >=20
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 vtd.flags =3D (VTD_SM_PASID_ENTRY_SRE(pe) ? =
IOMMU_VTD_S1_SRE : 0) |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE =
: 0) |
> > > @@ -82,8 +84,8 @@ static bool
> >=20
> > vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 vtd.pgtbl_addr =3D (uint64_t)vtd_pe_get_fspt=
_base(pe);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 return iommufd_backend_alloc_hwpt(idev->iomm=
ufd, idev->devid, idev-
> > > hwpt_id,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0, IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 &vtd, fs_hwpt_id, errp);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 flags, IOMMU_HWPT_DATA_VTD_S1,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sizeof(vtd), &vtd, fs_hwpt_id, errp);
> > > =C2=A0}
> > >=20
> > > =C2=A0static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *ide=
v,
> > > @@ -116,7 +118,7 @@ static bool
> >=20
> > vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 if (vtd_pe_pgtt_is_fst(pe)) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vtd_create_fs_hwpt(i=
dev, pe, &hwpt_id, errp)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vtd_create_fs_hwpt(v=
td_hiod, pe, &hwpt_id, errp)) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return false;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> >
>=20

