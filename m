Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91516CFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 08:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNRlL-0004xY-T2; Mon, 24 Nov 2025 03:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vNRlE-0004sj-Fn; Mon, 24 Nov 2025 03:17:25 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vNRlC-0007Ph-4b; Mon, 24 Nov 2025 03:17:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4FfQJ4HXwT2ZMQ24boGrmm0UE0TMmcR70Qs25E/Ck26KM8xjpdJ1eJ7zE/dvojN1SX7yCldFc+I95H0IN9aA/Ah7pNXoJWCicCv8HYDOQvnYQkxA7uj0FaYXmWYl/d1mWOFVZThxg0ZSbIpL4t9xSiRnIs9DD5Dmwh+4Hg1dPmTFq7KGyt7K/1YRHQXUFz9WU2UifBySkeZ/CLLH4dAK1E2a4pWLX4M1NPRKq/HzzM1Hk2ncbimpBmJkh6AEY66cpR20WO9C4dAGxlLdtPnHgOyUHyJVquNew4vuzfBQC5/WjwqLC/GmMVL9n9XAIHoJ/iLf9zmkED8HekPTe73eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tosB5jM5gBEoDHfblkUdaPo0fsz/wtmI3b3cgsCcilQ=;
 b=JzrDImi3kUPosbMni/qKNykGpqdU0pY/ytekycuyCdot/+QezAcler9Ey8UcyD1lFjRTAahbnbSL9TrN3RZzW/QptPjUC6ooH5ebSoLO0AheL+iAUAwBYzpTfsBiQ83mDYf3Lj3t3kXujh+ib7CvPoDG2JbsrJea8dx/XsNG1nAVIRwhx7OG0BPvwgxhFoveDET0FBDumU+muDOsdzmEl+TGUsv437/2YSzzfa/mRDU8td/jazNakj+khdPbdwMOoct4Rf907RwpFQgIVaQWe4/hxCFz31zn5R7SL920adC98grt9AKokHzS3CqQHg/AdQe4gzrPDPfYPnvtEfEmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tosB5jM5gBEoDHfblkUdaPo0fsz/wtmI3b3cgsCcilQ=;
 b=shg47c3DG3hwg2mDGopEJ+pXRM9dqkwOy+AEjtCCWi/AzUMhoVIhGYRjSWwowt6LsKnZxtIw2vNjdZtfnXOFgzTXqSGxB7TCRl5XCNBfaxXc2kk89bP/XDEyqUQlxkBbvbc579ruvEvgS2SRjp1ttbc1IbSUhg+cpSv/iSKk76GeSHfDsCXU+MsbUIn1cMdkWoHprtRDxTSq9iKCBXdiNLxTqmxm03X10NNUaSwwA+7eznlP6KmrS8QH2qy5VhEmVD3XRvPCI82zeBhjQFNQgl7HM5vi3CZ6IViHqYtWuxLQ4Zq8RDtqA5IRnd3x8knE6cm6GeHlI0r1KzgGGY04bA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 08:17:17 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 08:17:17 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v6 33/33] hw/arm/smmuv3-accel: Add support for PASID enable
Thread-Topic: [PATCH v6 33/33] hw/arm/smmuv3-accel: Add support for PASID
 enable
Thread-Index: AQHcWiFqHSYhBOGE40atlLYpe09yo7T8IHEAgADKkVCAAH96AIAEE4YQ
Date: Mon, 24 Nov 2025 08:17:16 +0000
Message-ID: <CH3PR12MB7548FED76113C3EAFCC2D5C3ABD0A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-34-skolothumtho@nvidia.com>
 <aR+RngqP3HTLZIlH@Asurada-Nvidia>
 <CH3PR12MB75485354E16E462D66567416ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aSCmeoFtzRBEGE8I@Asurada-Nvidia>
In-Reply-To: <aSCmeoFtzRBEGE8I@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SN7PR12MB7225:EE_
x-ms-office365-filtering-correlation-id: b10f3008-508c-4617-0515-08de2b31e178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?81u3RcttJ8cXXiZNIEmCLOzFd7jvq/+/GIqJXxM1THcUCknmS6e64rjtLZZI?=
 =?us-ascii?Q?M8ekWDU4UYYKavwo9wgbIpZX51Xbb6G8bPFyWc8Wd+5TosEZok/zvCvfoa7u?=
 =?us-ascii?Q?fzgKqMQt5yvJcQVBChdMl2kmN1ZT7uJaGJCtnaPuEZlFS3lhaKpZiPweB1P4?=
 =?us-ascii?Q?ZEJX01G9g7QNV995Mg2VFVniq/Fz305ATsPjlBn45KOuo6r7piw/Po4JT0Ym?=
 =?us-ascii?Q?zVvAFqYAr/16u+n7PZjyX1sz2ekVuwRulIwJ3R2x8Ula5hYc2oQZfBdmWqz1?=
 =?us-ascii?Q?DpoRQXbc0j1eFyJ2T8syq+IfBNEN6oVZF/sZlaldqztI9oV/s8KBgUY5elL2?=
 =?us-ascii?Q?QvWO61hEsOg3Vb05lzE0A2MKOZ9v++fuBRFiNifhMGutXcuXnu595FxwKSIW?=
 =?us-ascii?Q?6tZx6gb5NnZlpb8TVVuAKf4hYI7JP2K1KYhzO6+Bly42odsk3KpyUUt6BdCz?=
 =?us-ascii?Q?YsiSzxF1mVHlm2DWtwztE3/cDfb9EruUUlsKVW+LnNVZU786/Gu+Vw8JK0vo?=
 =?us-ascii?Q?DpyJ+A+yU+mFbVg/doBr0e/J6kbLW4+kbfgZMpVVb+Qr9n/PVoMcJB1AQwbC?=
 =?us-ascii?Q?icXJdGMHnz/7KgYXUqExz7EeS7hdpPKyNEPBb+yJLTn9f+NbC4sOHRM/Nnft?=
 =?us-ascii?Q?omksOIssoLSuNd5LOF4eKvDdAgYliZHg+TtcI/bUIk0BPG+fhIwzQC1DQefI?=
 =?us-ascii?Q?OpeCn8mNiUxYuLFirX1Z6+L/LTdFTON5Q3WctNCRNlnjoSwmQ9rM3zS7VDDX?=
 =?us-ascii?Q?aehFbiO2blGrd1kd0tPWAFM0oQBG9WcnWImvtivA7LPaunDe9JFOD+xeUTvK?=
 =?us-ascii?Q?6C9qgwBHJgEhE5hUXAllIWuG8FR1fbBbcJ4KcuT42f3Fo0ueGC/W4CffVmvH?=
 =?us-ascii?Q?32tDUdko+IAYckTHjEglAu5lXK97tDZrhQqC+UNXGSztqBjXQEGeoHqxNmTK?=
 =?us-ascii?Q?Kbi0/06MaxPENUQ18PGsxGG+vcSE/J5Vc8XP2YBzM82Jm3Hv6JhGkTnTarvT?=
 =?us-ascii?Q?E/O9I5RHUnu8AY2iIdkoK2VLNihrcAWY6M7NcaCo/8NeLudVcDzQfZBa9epp?=
 =?us-ascii?Q?aq8ueHPlNob09KoI+X3W8NcPMLvV1BHwbcdfML1hL2Vv0f4JOdhaRCZBC79O?=
 =?us-ascii?Q?HmJ2xUQci3TnU/PZTxIvh/+Q4pFH4Ecs7+ZtBUZG2Myyn3e7DRIWawHFNNM2?=
 =?us-ascii?Q?J9vJm7DyNetVdyBhrPVvZGpDLsdr+GHJkzO+N8K2mxtbGrH7sh19Xv4ZGP/o?=
 =?us-ascii?Q?1oRwFCSpi2mSqSVKm1nCtgcINTfHYkPQgBHbbNg3HtiNTiDj1UrU2K+D3kMw?=
 =?us-ascii?Q?NtSamhgpA9bLHG+dQRd4N9CY5dh48Sf4RNVPJxZepsx6KOP+lgJum+YQvtRi?=
 =?us-ascii?Q?W7inakedOUFas0UTP6p5gM5vhFY63+SvP0ctZlFbUDKugOw7MI82NwS/p6BJ?=
 =?us-ascii?Q?idNQF1aMmFHk8cZ1dLEdf5JS3z2LJV9Ck7uk4BZGK44k0DVlBsC+leF4AnQe?=
 =?us-ascii?Q?5y6zNzaeoPI6upohEckIuZoGPk+ajyWW+eda?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h4oMFkoTZ8P5O7HaHlNDjWo4laTT3VnXa+D2C66OIzzHMBMh7S5Y8mHf4IHa?=
 =?us-ascii?Q?rZjoMZO1WzHS3nlqL5JmxJZgJh8iELfTPgBtiJDg/dCWW5MqGhQFDDWFdSHM?=
 =?us-ascii?Q?918K3Hxg1nwWnNsT5mquEJhtKfzm2/GN2g/9rBT/pAxCGO2d+pgvjfYYXiki?=
 =?us-ascii?Q?uqUAdxlv1kgiyughw7cxZ2Qb2NfGWLI3QdZtuqRxctMlQU4kTndgr2DI5r81?=
 =?us-ascii?Q?s//SOPAmx1OOuXIPI2WOvvHe3IVkdCgfkimk30eTe+7smlUMkOjb50uypZWm?=
 =?us-ascii?Q?Jch7If1sW08AkfJuftYpxIcvtcr2K7raHce3vpJIeas6h+k08Sd/9wTeo68p?=
 =?us-ascii?Q?Ct4WaiaIpfe+jcRx0mkyJBBJ1k1F9adAmp9+oR6ep0j0H/I0DWf1SQPOoYhs?=
 =?us-ascii?Q?KXFYmPxguLqw4ORlmlk40TJLAFh/K4awufahpWRY1uSAzBn2bSwoYi1QG8gE?=
 =?us-ascii?Q?YHSw20k+ANEEMjHJgEtEjjnlrXNH+fBWj8+cXBIPQUyTsts8qnvF71azynxl?=
 =?us-ascii?Q?ne6CWJ5h453ZPrW1/BKBcvyk3OASOvJqMs207BGgTb+98IIKX/GCXCxMUvS3?=
 =?us-ascii?Q?JhLdhBHok4UQ9TLNvjYsAe5NTh7AcXeYdMMfw1BzzAOzex5nSPX/4XFqRmE+?=
 =?us-ascii?Q?lVB8XOS76Xr2TqMj4o8WHKuAe9l8UrDHpfxQjauJqTUyiPda72I6N6bim0bt?=
 =?us-ascii?Q?b63oyl9UW0+OF+AFqO9sJ0Xgmy+i6Y/UUHf4RS0su4gG48exZ/qmKYKZAbXU?=
 =?us-ascii?Q?u3dHqUSbU6IOHYLCBRHVuewL4ez36yQUV9G3jr+W/kwzwEFC+DbghMrmAnCa?=
 =?us-ascii?Q?jpfzZu9Kw2PBsCIqkJPccxdwQyLElXGzrnArzODK/Ar/ffyqHJBiEijOwaNc?=
 =?us-ascii?Q?fPm6Yoqt0CKoXSyaKLGbcuJW8oWtiecf1bIPg2X0uQeDeqboOCqmhX0nfSqQ?=
 =?us-ascii?Q?V01JZC9QKdl0CMHpreQqBernV5lCtDsnSKIwJesT9d+EmHxHGKNfKxKKSBLF?=
 =?us-ascii?Q?NH4ZYej8+rq+jcjE5LeBqfvwTIhmzJbmbk8tWzgZZJWjEjs+f3Sr/G4WFX1I?=
 =?us-ascii?Q?wq7sn32Eisgx1h/FabQGR2rCNPSA+VidypurXZPej+zMCImlVZTg68QKNOrN?=
 =?us-ascii?Q?/lPxGNpF6UBWnYTeGyKHkLL6JUvhSek9TQje+j5mgafKKRa16JZWZZ/KsMes?=
 =?us-ascii?Q?tBYZFveILO6YJyIRtUOQnqTtmno3NM4q8lzHc5/EGPuM9nJb+hcDB/vblAl5?=
 =?us-ascii?Q?CMUa61jeJcozUQFNuIRArqdyAxahstjPp3/zcPG2yFdQY18CQ7brRwAZXPNV?=
 =?us-ascii?Q?6bT/VC2IkuEyi8vsyxAhZe2aIgZGH0sj0VyVhjMYFbfqB238J1iR2B86nAVk?=
 =?us-ascii?Q?lNcVJ2ozsYbkMMQ0xkQw8V1o9wzrZ8wNqdrIaBwQiuBUH60YHfAzNS4nlqQ9?=
 =?us-ascii?Q?aujw9P8kwNshMYcIlnkA+jGCGy6t7wRcG8cQyh2mCu1kW36Hwr0drw7n5Ndo?=
 =?us-ascii?Q?enXcUKR8YzKNBCyHxe8HHXuGfEADbglhlcV2FRk6OZ/63VQ29YdW4p7mik+V?=
 =?us-ascii?Q?y1l9FCligPiFuJXsaLxKFKMGfB5esD+7g242O8JR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10f3008-508c-4617-0515-08de2b31e178
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 08:17:16.9172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPPc/RTTmR9MPqH/GppmFPXGK1pZp81E+VYnf4OaBY79uj5OC/frYGkQOcUuNg74HZepNJ3TCcN65xCzzF2RAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 21 November 2025 17:51
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v6 33/33] hw/arm/smmuv3-accel: Add support for PASID
> enable
>=20
> On Fri, Nov 21, 2025 at 02:22:21AM -0800, Shameer Kolothum wrote:
> > > > @@ -2084,6 +2090,7 @@ static const Property smmuv3_properties[] =3D
> {
> > > >      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> > > >      DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
> > > >      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> > > > +    DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
> > > >  };
> > >
> > > Instead of doing a boolean "pasid", perhaps ssidsize and sidsize
> > > should be configurable. Then, user can follow the not-compatible
> > > print to set correct SSIDSIZE and SIDSIZE.
> >
> > Do we really need that? Currently both are set to 16 which means 64K
> > values are supported. I think we can make it configurable when any
> > usecase  with >64K requirement comes up.
>=20
> For upper boundary, we have SoCs with SSIDSIZE=3D0x14 i.e. 20. I
> am not sure how user space would use this range,=20

Right. My assumption was that nobody uses that higher range per SID
now in real applications even if hardware supports that.

but I feel it
> is better not to cap it. And SIDSIZE=3D16 is probably way enough
> given that QEMU only has one PCI Bus domain.
>
> For lower boundary, SMMUv3 spec defines:
>   SSIDSIZE, bits [10:6]
>   Max bits of SubstreamID.
>   Valid range 0 to 20 inclusive, 0 meaning no substreams are supported.
> and
>   SIDSIZE, bits [5:0]
>   Max bits of StreamID.
>   This value is between 0 and 32 inclusive.
>   Note: 0 is a legal value. In this case the SMMU supports one stream.
>=20
> We apply a hard requirement that a host value must >=3D VM value.
> This might not work for hardware that has smaller numbers.

I guess 16 is a reasonable low value for all hardware's out there now,
at least, I am not aware of anyone implementing less than that.
=20
> Yes, we may add an SIDSIZE when somebody actually wants it. But
> the "bool pasid" would be very useless when we add an SSIDSIZE.

That make sense.

> So, I think it's nicer to define "uint32 ssidsize" in the first
> place, which also aligns the QEMU parameter with the HW naming.

Ok. Jason also made this argument that it is better to align it with IDR=20
names here. So I will change this to "ssidsize" so that we have all the=20
configurable properties align with ID register field names.

Thanks,
Shameer


