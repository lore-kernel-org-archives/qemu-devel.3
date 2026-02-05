Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58991E91290
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnuhO-000716-8Q; Thu, 05 Feb 2026 03:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vnuhM-00070S-97; Thu, 05 Feb 2026 03:26:48 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vnuhK-0005Bd-RY; Thu, 05 Feb 2026 03:26:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6z5W1XdYVTcERyGhBCXXfdludmqp4h/J+ajk/e2HahYaloQq0lJqpg1S5Q3He3Oe5pZKYbjZ1obCqHe1LqNOTO16UItr/zYuhhRnMdMLt+xbTedUOdgFDlJwaT+d8qborineFMQTCmkdygTMSZS4VNRkPtp1RwYP65e2W/tmHtQajXk5xWjHe3VXOtpgVxIG/jw/BHWm0cd0yLx4Wx4VCim12XjFmiyjPy/QnvLqYNqlKp6Kl1YlWrZs4n+OMAd7lqvUfVZk/LJbh7szggNoqFpC1o9NhZ+jHzLbCxVbETTQbjJ4mbc3tKZCF0Bqcy45z2Mt4HFHR8wBc0N4AKgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XLROWAeVhJYJrl+B5DM3SFMuj3ex52WYjKSTaQxckQ=;
 b=rqU+cCqmwY+cMMVmxFM/HtC+AXwHgDQ5qft+WHr0GHTVMzo9qgq5Evhezu4yH9DEoG9cBuuTWzBVpd1XoWWhfaomqfvbSOzSNNn1HlBtL2ClAvF7eVFbzRxnqd9YBsVz61qcxXJhNisnlYeHKNj4gEtyUv3GT/Hu8aRorqHDBU4jOEu18Cu5gUo8OSFx/xp/q58AtMJNEIYcqi0jIVTkIxOnTW+OdhCrNAps4dKWimBIlR+Twi3lQO4IhAYJKuuHyQawhKuqGcSyK5BH9GoB78PcNbaE2DLAaSwDIQWBCnXOsUdfhDw5/4Qb1Pva3ahXlUyMrvF8JTODzY5SL6mlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XLROWAeVhJYJrl+B5DM3SFMuj3ex52WYjKSTaQxckQ=;
 b=HgiwTSXbEyzrrSm19rnamGapyuYt+qdeEwrPc8W8qpOolnHeJ5EVe1sypuF/LRgVY0EHEbaBu8hW3+nKTVmWD8tiO9q+oCZ0z/SaeghQuMfpVL6JrQuLUka2nOMPI/76uAQWygVzmozzXtaJEYw3WPbO9WT9tXilLEXXiAJejiZ49R8kh1x56vBycpVCv8RvdkKhqzcaiaBEiwJhfeRh5+ZI9lh5RcWOH3RiuMvxQGPfhcXShU2Jgzzv31e6mE39+PEyVygVU/2ZAbGM36MALdPYoYxgwtKADTXafs5BIW8dW3qpNTozB+QDoB468T55PQewn6H/Z47x2dtPCegnZg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 08:26:41 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:26:40 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v4 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v4 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHclgipVdHWZsoTDkm9jZaLfut9hrVy9CgAgADQv/A=
Date: Thu, 5 Feb 2026 08:26:40 +0000
Message-ID: <CH3PR12MB7548F2E4B90928FDC2A0EFC7AB99A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
 <20260204190008.20070-4-skolothumtho@nvidia.com>
 <aYOkBm5Ghih0Uxzf@Asurada-Nvidia>
In-Reply-To: <aYOkBm5Ghih0Uxzf@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB7662:EE_
x-ms-office365-filtering-correlation-id: 62d861a1-f937-4873-fb74-08de64904986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HO3hkV0sRrrH8Z/ODMDGHqlbpJMcSebzBIdzcOV93H1cFINysEXyIBMzx2wI?=
 =?us-ascii?Q?j5XLpX0nzT3UVrdBTW64tI/gw0YZU+/1guSJ7dRm/K2ylk4kTrnx1eeev/RQ?=
 =?us-ascii?Q?iPZwF5ETqU370thTou3xJMkhiNqQTrNpFIlVzfUKTjq2E53QembRTDEvnFap?=
 =?us-ascii?Q?PvPA/pbNinrfrq1bE/6rTNzJS7KXHBpBHX5gREXWDiu7cwscPscA76EZG3nB?=
 =?us-ascii?Q?jbP12aVaNVBbjg/MKs7Y0ZPUuwXew12BrMW79jOFUG34MM+i/7dFIOz/wMjh?=
 =?us-ascii?Q?pZTnkbAJzByF96gRIupvi/NDKmWmn4eacEmvp3hJuSJxZRgzIFMfK/E+50OX?=
 =?us-ascii?Q?Uem/EQMX9waL9De6NRiz/Vx3xIg6MpLjiEWhCA8vMHkJtC4yZUKzT49guf9N?=
 =?us-ascii?Q?RPXoOKmqxjgTcpxBmCX6zvcw688eMpHssRPyDZ2vCUxelUQf+NBEOtK/MkNj?=
 =?us-ascii?Q?QxaPOonZoc4lp5r17Eujfc85SOEUhDj1dvZzH4zRxx1S48mmQqNJ1WUKtn6Z?=
 =?us-ascii?Q?3LIHvTcODpJDbwqsGzIWodosHDopyD7a6//vtfOOxhbQJ2A4h5vUZSaHJPUh?=
 =?us-ascii?Q?msvEGxxw9Q7VIj/KVQR3FuF8pc3om5TrCSdI8ShdTtXdo1pZZQbOvae6dNBa?=
 =?us-ascii?Q?N4hg6LQGGuNYA9Sqvha62XYH1016yP2RKms0LdTH3w+usRr/wgfYlDPlU2Hk?=
 =?us-ascii?Q?GvDPdSTIx0bAB7CwbF9Jo8wUY3POvBZ7+Hbw223q3nt1UDBlr9Kbuw0tyh8b?=
 =?us-ascii?Q?1Be0AWS7Y8/2wqxDGgytBVUA/yqoHWVlxwS3PpENRNCzY+/b4gXL2ljZnEKf?=
 =?us-ascii?Q?JypQgik19xV+FYTAl7DcMrgtHogiOOEFQ4A6uDoMbqBp8qyR74+ApWta9cH5?=
 =?us-ascii?Q?q3vRMTQQqmkV5d2ehKCp4QHNPvw5aTFhMOPiEKUTyk47UALX6vZDQSqpraIL?=
 =?us-ascii?Q?xX3nYlo0qa3SFq1isfyVpXKeHNoJeeT+hNLW7fYvsqtJ3A6DVvNSIN6lNeuE?=
 =?us-ascii?Q?hEm/98vnpAOBIFsyWHUb459i3cVbCdxQqJc7bc06Fq0oep7HAlF2SYVeWtXF?=
 =?us-ascii?Q?MEvBmfJDTegnifu4ByTPd22YHtDFHHuFtQYqy3h3lNRWVmKJ5EqPEjibpDHS?=
 =?us-ascii?Q?c0xHP78f0Tja3lFzleozL4txEttnRzh4n3StJj9TdTM1OQGh8ClQ3EhLrf9H?=
 =?us-ascii?Q?5dh2dtJPyiYnDphEUu088gM48OtX8JGvtd8tUjSiR15v777dWBtxd6Ew/jWx?=
 =?us-ascii?Q?7x5LUV9Ejjojg6Gvi/0W3WOjb9/d1aejufKj3scyhiWYky9E2MaYuBmgOOg3?=
 =?us-ascii?Q?jkEP+tCeRW7hh6VKqaLm1FzjZQiLt5eRcPgJPYbjnzK3eYOE85uk+4j15Yqd?=
 =?us-ascii?Q?iMrulA7pUcP6PCCJpATx07hB6vPrtmVAkj/fI11i5mvj0fI/pK8fSmriWCiC?=
 =?us-ascii?Q?kV05BgVB8CgLs95vMARJqxRPspSXXWZqP6GPbotQkrQfI0ISIgU36GXRrKld?=
 =?us-ascii?Q?MtHHrGIKKP/Y4ohIIbuXwtO1Jqm1Sqq5QFkl0mGJuj3VezS4+JyvplT8kdrc?=
 =?us-ascii?Q?mjC4O4CVsvc/ASpMp/PtB5BDLTpZeuyTDvZaFWV8EtfxXkw1jmO64oXYDGBM?=
 =?us-ascii?Q?msrUNo/6p5UKTdxsnNoR16Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lNUQMydo4Z2UWqmtR1GyrC5/fJ7Oa8K98K2OmxseVOCWYfAMSPZIXZCn04G1?=
 =?us-ascii?Q?k81ojxNbF+G9MmuKCUTy34Q53kA1PkyDT5J0STNHa5OhmQPwKDwCTDhOQv8D?=
 =?us-ascii?Q?UfsByQGJzFEcMpEA3GeNUiElbkaB0W/7XZK7FMD8xwF+yB1xnf32a9EGkys4?=
 =?us-ascii?Q?fUTSfwduOJKlyWqgtt5oZXLh+1SSb6fcblqUTzBiD5B7I1iCcxNqqsyHrT00?=
 =?us-ascii?Q?FTLxe8GjC/ndP2SW4uG9Ejtu3MySFmP55CMT28rufo5oqv03ID49Y4hON1Vn?=
 =?us-ascii?Q?UPioy0IKsLXjQglSgNJc51FRKLoLN6iysRcyWYnsUtRNEjo6mVOVL3hEHDQE?=
 =?us-ascii?Q?rOdI8iUMVzLRThz/Rj+9hlpnbzKv/XxqrF6Uwdk8Q5JQtumYBnvUbpAxBKa1?=
 =?us-ascii?Q?44tZ3T2PUpKPxLXfMdYCiHL3Ko9EthJk0+hUrofj2fpkGdVmcERULSUgmj7S?=
 =?us-ascii?Q?fgUvbJ8LlSjMvm9RJhHE5+OyBtWzY60YkZCJaZD4Mtp1j53BG12GnQKL8RFM?=
 =?us-ascii?Q?bUovSBfEZ91WRO9pIIbN30n4RgFqJfZhju+qtxF0iCXso0VinnejpaubfwQT?=
 =?us-ascii?Q?FNWakmg/ORBlI5oxdzIa47Fa7WVW3cFm084adlIJlhzfgOkZwYjFEA31XGc0?=
 =?us-ascii?Q?2JC6j7dNp/erRCOVzsdH8zRXYeKHzLxSfcVej5OUQFcm18yYI171cPnCd6qd?=
 =?us-ascii?Q?FXg3YMrLaQUmm9UeozegThAIYSDGRzKHdj7gvmrjSlbkkqfTiB5LrSV0rYJ5?=
 =?us-ascii?Q?lpY4oX8SUMuVaSl7KF2+LY/N+uo3YxjbD5FgY+i+rextc8WrHBWp06qDfhlk?=
 =?us-ascii?Q?g1Cm0VqiIFZ6Dai5Pyip0ax7cvuZEC3YObJM7RyzAig1HdVYfE7fjQyBupQK?=
 =?us-ascii?Q?WQI4xNbHyL0ORpIQvc5r0DFoSOdKR/iB3VwUdIRCCkygBWs6NB+OeNt78PG4?=
 =?us-ascii?Q?4sawkua3UnV3wUT5u9CDKUefiKJ9P8riL+t8PUW/sox06IDa7vA/md9cDv3L?=
 =?us-ascii?Q?KOtiUr4/NEzggdF9tx1ZQkE4ePmq5pUBoo6k2LFrhW+coIGf4ISZlUsXV07J?=
 =?us-ascii?Q?FcafqFN786HvbCmPVJXQRTHF5XIGuX6ZJzEUkzC/9OKu7P7VFK5S+WbwRniF?=
 =?us-ascii?Q?0yYBFip+7ui0hM3u+yMpfP5vEs0WaDZKGRJWd2S0GgCpQBR3q0LXw7KDzk8c?=
 =?us-ascii?Q?rxbuzA56/UC4/BCC6KTfSI/npFzR3hbBiB/DcYjNlXgqp6eTKMHHnVHHRGsl?=
 =?us-ascii?Q?PoI48J/2/nj20xQQPtSn//0kF8c86F3qwDrE6T2S0KAwOZxXANn3z5BAbswy?=
 =?us-ascii?Q?Kbe+IYmkF6DSDLzsJ8ogh+F6lqu+d2PluOV3IFwwrV5MoGS/V7SRcpU82lS5?=
 =?us-ascii?Q?wJlHGld0CvuJqkR1935uBl+0D9M5WqACzj8pgua+/VuLsKw8En4BgY9zJBCd?=
 =?us-ascii?Q?zrolNF+rAYZ78bcocCORRWsxOv0aoEoP1X/JMUSkpFXsTruHul3uSRw7h568?=
 =?us-ascii?Q?rUHq65osN9bnw3YpW/zTtoHAe90qENyZNF/qyTWVPYZKw8AVmUSkL35ztvG4?=
 =?us-ascii?Q?ApvQP3nkku9y5lRUqPG7fnN2e+EpTckTMkvhcULf2wf+FC5nU4ONDb7L17YS?=
 =?us-ascii?Q?aqt1S5kBWxYGqx0Pg49kz3twElIrH5ZBuitApgv8x6dUF7JD97D2LSalwLdO?=
 =?us-ascii?Q?LZkK+lYYeSefMAqw/8RjiWmncBFAV71MVvCf5rxsvbHjSWRMcSIxOrK0Ns8j?=
 =?us-ascii?Q?7z55jx0vkQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d861a1-f937-4873-fb74-08de64904986
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 08:26:40.4443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibrPOXqj2z4a1zse5oUi07rARvSYnrq42Jri+c0rZceyP2IG7d5IOi2ZAhuq6SY6L+4jKbl8C4gg2Fr443PpaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> Sent: 04 February 2026 19:55
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v4 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
> accelerated SMMUv3 devices
>=20
> On Wed, Feb 04, 2026 at 07:00:06PM +0000, Shameer Kolothum wrote:
> > +bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp) {
> > +    SMMUv3AccelState *accel =3D s->s_accel;
> > +    IOMMUFDVeventq *veventq;
> > +    uint32_t veventq_id;
> > +    uint32_t veventq_fd;
> > +
> > +    if (!accel->viommu) {
> > +        return true;
> > +    }
>=20
> This seems meaningless or should be an assert?

Hmm.. We need this check because, if there are no cold-plugged devices,
when the guest boots and enables EventQ, the vIOMMU may not exist yet.

Isn't it?

Thanks,
Shameer

