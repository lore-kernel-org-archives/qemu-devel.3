Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0D1F4181C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzecA-0001HG-2M; Mon, 09 Mar 2026 13:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzec6-0001G3-C6; Mon, 09 Mar 2026 13:41:54 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzebp-0001rg-As; Mon, 09 Mar 2026 13:41:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSdM0SGXNbuE5fqjhDdjfjD9+IjZ3dTJuL274GrBxomKqfNP8IbvSzhoi1YzukvtyPwFFlfsCYYqd5DTQ939YHUS7kdOaEzC9752a5TDjI3beMQYdUnQUnLnPKUu8W6Pi1V8lZmWKeJKxLQHuVgy9wQ30wenUZ45Frtw21ilXrdVo/qqaEg/AMr4pj5mAnv0tVU5GnBIKK56rmGtFvKZ1h94/4M4oFLp1bMVXsJDX98vlbILNAmJnfnipZ+6sI7R+002No+X4uQE170gLPEnfz5VB5Z0kOnFRbWydH99DMDjQLuLAahxNQMG+uVZDVgeAhYICPYAZRSejEZ0jO2axQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKzyPZtys64HKjwMlJeEk2ZU4eoB3ITSCEZCxpRs4ig=;
 b=kFCj6ye0xxMrDyZkljsUbDnpeP8VNWMLoL6X4PRZ5i0YX8x7pkivva4qjjIliVetFohuJq0PFg0fazVnEH6+2k3ESH3IwGVgabG/2a7IqvjILP5qBvf/zrQtYE1vufqYcx9sf1c+ofqgliEpclw5rXzIHBBvaYq/diAC3xlpfI9rRC/HA5D7VWx9XxAqeI65fjKTnJ2y3O3j4kIioAMo2sePCOyNg+Q2/3UczaBWg7LBxUibCI4vjP9cNMuTQ3NOU1DBzGYCPkmmLMEcFD2wZ58xE3RvqjQD9vi6bIorlpn4h/jEloQTDLgQDJEgo+SZSIG6l+x4OAl1ORMy35LPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKzyPZtys64HKjwMlJeEk2ZU4eoB3ITSCEZCxpRs4ig=;
 b=cGeuAdNoTFs4qXv2abBzvyj28J4U0Jd5mOhvRV9PRG2uLL4jTRsRrAe23K80kFhmiguNC3YiRqTn6RsHm+gjYDjijfer6WTIUyCXBYCkKLt4XjefmW5GGz+7F2aVlOjyYuqG8EFS3+kaBTN+ejWGu1SRC0jAzeWr7pDSSlArYQlO6PM9yUJqEdteQHtD1W8TseLGfWuaN5COWhlO79Z72Hh004IhSwkUhFF/SoxDqdjh0uZqsZG3dNHgt4ULtQGLIBM45hQkJkTzb4wNu4K3CPzMaeoPpzAOOsPGBfgjo+sTfmP9poY4WVXety8FUd+uIXpVooEw+4eujl86VIEc2w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 17:41:25 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 17:41:25 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v3 22/32] hw/arm/tegra241-cmdqv: Add vEVENTQ allocation
 and free
Thread-Topic: [PATCH v3 22/32] hw/arm/tegra241-cmdqv: Add vEVENTQ allocation
 and free
Thread-Index: AQHcpw4eoK2DWewFmE2ues+F+aYYQ7WmhQWAgAAAncA=
Date: Mon, 9 Mar 2026 17:41:24 +0000
Message-ID: <CH3PR12MB75489D97EEC973AADC0B4244AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-23-skolothumtho@nvidia.com>
 <aa8CRT0gv3tr5GkV@Asurada-Nvidia>
In-Reply-To: <aa8CRT0gv3tr5GkV@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB8474:EE_
x-ms-office365-filtering-correlation-id: ff0e2a8d-d91c-4f8e-8417-08de7e0315d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: Ee0uFHRiGjg3+exBPfwKd46pJ9bmUp3tMJr3vlFrsSVlzY5lmqgYJN0q0HsfMa10tR2CjNheF1cl3DjaSMBIl0037sAu8Aoim90FAJ3ZmPyGoQWJXm7MLLPSVSA6vGtlXHIfSRLYwvsJBSEkzDN1Soxe2BhnogKBqjWsn9t2BXqHoePet751Pi2cH+uIjjjQ45e1f4AkfF13LnB9/Mb5XSq29FDr58nlY/GTdQdxRxUzzicszDessAqhnJnkKrQlNi4wV+WchcxGbZseWLfWB0B9R/52ncp8YGJWJBVCNyol4J0w1k4w4TlEfY0ksY90XtGWZB4Vbr2cQLO2VYzz/3zBhc2qhhfs25i/aAIdWDo+V6psznAmv0va7HQAvqbO7dCNqvpYH2ktCD0jgI1nhh/OB2r+pGuYnfN7qRX+HQma4Tj0IA8Rcs/kr57yPdSEjN2rl1jjplvZskTGRhLjfjzWlEs3C0RwgMMrL+9JDnSyeCV+qot8LU2FjOGUuqpo74BMui4n44I8D51W4FzSvPsN7BUBGe2XLE3V5EGngAQa63xFxesxxb1iGtf5npnRD61ebuwJaYpSa9eLmXmfsyG+3M8BvFF2OK1GZDs2gOeqFeRP2ARDUVirmUAaTu8pe/eKzg2IfA9BJgUYnQ/XN8xq4ymVFqrMZOpBmleJ09IMx2mi3QRPh3sxJy9nAU4zHi1mtasVm+iWIZam63ZDAUyBPO7wutqum3u2XHebdl6Rxg1s0w7w0piv4JybolSnrVoYWqembQRBW30l1sQJ0P7An0/s74YlQtfN82iXh48=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sq8VTmRjiJ31TR01WO+uxw6SJDyVcCy3xK0OzNOVCW6C2mUUDURX9ta0KUFn?=
 =?us-ascii?Q?Y6eCFKG7m2SXXnW8mnTPbJ075WeZKkmYU7BWQVCbYKiLhC3o7Oz0a5lO1sbS?=
 =?us-ascii?Q?gWauhEeFi+qS9o4CkIdSqiAGFpVL1V1n2F5cypdaHaWQtto+F0XCaqhxEPkI?=
 =?us-ascii?Q?5WwUKFbV1lJC9IAOEJMnNCw2LtO6CaItufVsTzCzFYrAtU4RqMpaoMISD40q?=
 =?us-ascii?Q?k/iKtVXAmuFpxi9UHya/VZr5014gekvq1qDpT8Lr2ANtI2TLxwVomahtzvDk?=
 =?us-ascii?Q?p3Sp0FIVd0Y6oEEU6SoL8xFt5M1Ko67lXRVowPqGDraYFs26b6MJUzca0bfl?=
 =?us-ascii?Q?OUw5ab9E6hXnZLRuAs/YR75kWTh2dUdVdOksw5YGc4N4E/uzTDS5oVSDRg8G?=
 =?us-ascii?Q?199s0GZ2I6bHOEtI7vXHdepYz+rs5CpFmE3zHAmPlG9+lQwU9eI0gf0XiFuQ?=
 =?us-ascii?Q?f5Rx2JT8ppzAU2QRoWUiPF9/0jjxzqQ8ry+vAGdhvkBQXoc0Q7/lXnNcQheT?=
 =?us-ascii?Q?NiLKIk+a9d3f3pkppuZahJjxZy80eWwlDIyRvcqrd/hzAKvB2zHzz78mKuG8?=
 =?us-ascii?Q?nPM5myMyo2KFdp/sNzt0JElYejmqws0qeW3wYb+Vs9CuGrUaNfob9HCSxA5i?=
 =?us-ascii?Q?tHiByIZxWc8bMOyKNEXTQsgja8SmBDesHiAwVBB6x1UCGVX3iIHms/ymINft?=
 =?us-ascii?Q?nQ5dzpqS7qeVTh5OrrqQN57F2IGfgisVVRDtICMZIv2/1UJCiJ7lhUGzmCFT?=
 =?us-ascii?Q?lGkS8a71xH5Vc4PnWZICrQ9FIb1MdDSFDHvOkHv5w7dXHFx41k3s2zL1iC4a?=
 =?us-ascii?Q?ZndlpK8BgP41xEM2Qz3kdZbsKLxl8DYvN0ogADd3XgEP5JlRsfl+1M+BBoHm?=
 =?us-ascii?Q?3l6KJjO/Nn3cW2MSIhEyv08N132x2iJArEzF8HUObN/oT+TrQd88WUwmBvbb?=
 =?us-ascii?Q?BQT1I52geTfr6l5b60cnKmCpxaqJS+3EXgS6FrrApyXl2XQ9LJO69W2k/ha0?=
 =?us-ascii?Q?njSUkNmwq6nmqcOVroi4DdG/GtTZGM/Q0WbNBwB3EEuMGDgdGe6k6f3uYo5D?=
 =?us-ascii?Q?2CeKzf00tz1sabcHxzgA+MmG9QaKNuuKbCzMR/UDNekkg9rHjc1nwS2eyKK8?=
 =?us-ascii?Q?Uk5ffIKWe5dOcpkiMJ2RLhEz7XSL/43b+2P95u6oCuxCGjpmht27GYPibZLg?=
 =?us-ascii?Q?i3hzKOOinVJRKelzkrrVkI21qhkrDO4fOmN1r4R5zhgwH9JhGpjeeE650Je/?=
 =?us-ascii?Q?IMz7A6X1HU3psyX+zbGKZDyyGzW/86stlQfuIWaXJ7/pIxCIq6JxaQByPyi0?=
 =?us-ascii?Q?NfYblG0K961oJyN94w/fqTv4F7bGztv1U5nE0u0M6NlzpmTk8MQsTReC9z2B?=
 =?us-ascii?Q?tZv5UnBCPvewYB/ReTPYsVJ+Sc42M2xmJmmulwvVhbIGkko0vBd4ER5yh6C8?=
 =?us-ascii?Q?2+HS11rwazpWpBGYpU1kHz0eKpbf+15AV/U1AEMBcgbSb0B2GJFgfvCeMiK0?=
 =?us-ascii?Q?3J0xqv8rK0ZcpO5q+EpC4SLms8HbckBSDNqKnkil0qDSWa02tmJr4ioiZ9uj?=
 =?us-ascii?Q?c+aZ+Xuo6KSMhvhTKzhkGj05k80NOasx4hvVAGJ2tRwASKxZJWlDX3KMqfYZ?=
 =?us-ascii?Q?nJ4AAdm0Jw6nmv5dyO16xM3K60wrgBW8KFfu7BtiBQgEK4uLLSIFK5ld2Tic?=
 =?us-ascii?Q?PsmAmWpBPkFtDVbvqYSUN3xk/3qyXmFry/KCBwlL1R3/dO1Trj1OKPGojA/R?=
 =?us-ascii?Q?KZrHrjQaVA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0e2a8d-d91c-4f8e-8417-08de7e0315d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 17:41:24.9241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssJNwKa9zjtS1Vm1hrzkcxn1tQE7y3NF6TbgjCefu0wSKb0dAtHY/taYJVLCV4BASJt19+aFeuCuQmIWus8JJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 09 March 2026 17:24
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>; phrdina@redhat.com
> Subject: Re: [PATCH v3 22/32] hw/arm/tegra241-cmdqv: Add vEVENTQ
> allocation and free
>=20
> On Thu, Feb 26, 2026 at 10:50:46AM +0000, Shameer Kolothum wrote:
> > Allocate a CMDQV specific vEVENTQ via IOMMUFD, and add the
> > corresponding teardown path to free the vEVENTQ during cleanup.
> >
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >  hw/arm/smmuv3-accel.h   |  2 ++
> >  hw/arm/tegra241-cmdqv.h |  1 +
> >  hw/arm/smmuv3-accel.c   | 10 ++++++++-
> >  hw/arm/tegra241-cmdqv.c | 47
> +++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 59 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> > index 7d6e4c6b76..4bff90e2c1 100644
> > --- a/hw/arm/smmuv3-accel.h
> > +++ b/hw/arm/smmuv3-accel.h
> > @@ -28,6 +28,8 @@ typedef struct SMMUv3AccelCmdqvOps {
> >                           uint32_t *out_viommu_id,
> >                           Error **errp);
> >      void (*free_viommu)(SMMUv3State *s);
> > +    bool (*alloc_veventq)(SMMUv3State *s,  Error **errp);
> > +    void (*free_veventq)(SMMUv3State *s);
>=20
> As I replied in v2, this should really depend on viommu and should
> be simply added to tegra241_cmdqv_alloc/free_viommu().

Yes, I remember that. That was actually my initial plan, which is why
this was not part of the original callbacks in the ops struct.

However, I then realised that we are storing the viommu pointer
in veventq,

veventq->viommu =3D accel->viommu;

And that struct viommu is only allocated after alloc_viommu() returns.

I didn't find an easy way to resolve that.  Need to take another look.

>=20
> The alloc_viommu is an override of the standard viommu type, so it
> might be useful to have an op.
>=20
> > diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> > index 4373bbd97b..f6602f51aa 100644
> > --- a/hw/arm/smmuv3-accel.c
> > +++ b/hw/arm/smmuv3-accel.c
> > @@ -576,13 +576,21 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s,
> HostIOMMUDeviceIOMMUFD *idev,
> >          goto free_bypass_hwpt;
> >      }
> >
> > +    if (cmdqv_ops && !cmdqv_ops->alloc_veventq(s, errp)) {
> > +        goto free_veventq;
> > +    }
> > +
>=20
> But, this veventq op is completely in parallel to the standard one.
> There is no need for the smmuv3-accel to initiate the allocation?

If we can resolve the above dependency, then yes it can be tucked
inside .

Thanks,
Shameer



