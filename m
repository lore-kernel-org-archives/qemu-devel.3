Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26158CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 07:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uymIH-0005ye-T1; Wed, 17 Sep 2025 03:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uymID-0005xq-Ob; Wed, 17 Sep 2025 03:09:29 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uymIA-0004OJ-N3; Wed, 17 Sep 2025 03:09:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh+BZXlo8pGxQ0WWvQ+1t++KYls3XNXwJxzxDNV6wGF6qBj4dAdvU/cauBudluMGiV0rR1bXnP0Eyznpmwz9QMdlDsKOzyCHrukcjvjGuBBxVqBiesePcWhYgbZxMYAanvS0/VeZNU1AvpqCvRO5FMZBHI55NKN70UsQYagq7Ustzqa9YM9Oy4NAE4+a3r6mfPLTlYQAD3kqBrXntEEHTJgGuxJg1L5w2NL6EeuR9QFQLN6U2cyHgm436R9WdecI2DduXpzraGNLx5t+aNs9aDu5iI8KQkY7jBAr7yqq0pC8j9DCeUnA9oWc5NfLAt7iTmb7vW5jSkGyZJaQOP11yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4W3uztZx4sCDksXy59lROTMm/NPNxNbjev0wDdWFLlU=;
 b=KgIzfpiczkrTSQG179BN2sRVoKJYrY8YQrvlKrkwObOtk+xcElfEoyFcvBJyMgUCAhfbJvTD1A9GvxaZIAs3PF/YBaxRsyZYucAZ2Vv6xDjokyc8tbX+ZGx0MIG5gU1UyPZl2SxPSI07l7EXzfhc/Xe/tNlfdu9CKrnT9HhWRBC+hYIbP83Y7P00qXnkxIPgykTVPJqEyhr130TwkwlF7Cm++rqNtK8j6zWj6QOb8I08xZlYNZKYGIzNB+OGk9a5PtKk5ilMUeRRX+b8uGHp8qSCgWgl0eE77KXpAqJeWZAQzWZxWWvcSIH+sHaJt75d4TzG9fwIM40CHVTw8JZXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W3uztZx4sCDksXy59lROTMm/NPNxNbjev0wDdWFLlU=;
 b=BrYmSaC4sSRyMKqK9ruLxRz5B2XltiYLJHtSrK12LDVqJKeoLUiP0/z/pVrnnAf/OWF7mPV7/r/91F+3tirByaC9pwj5M7d95PVhCCPKyKSMqAsvSdxfqruyHqIORVCLIPNvRjsGFHvlfMTn8+Y3+49ixdtmX9T6KRnHjh1hoak9PT7sqoNdB1HMoxnFZU+079wjAVONYz9tAMckaTdrpyyZ4WcffzbuARGFHnGGtWWOBA45zfKMRcROxEyLQo/XVwbFfxwBFLMm/8+pSnjtyKG6TB8tjyi14QYZ8VhIvT7aAfiYJg1ESeX8zjD6dbE0AQBVKXHsrdSU3PejgixbyQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 07:09:17 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 07:09:17 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v9 00/11] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Thread-Topic: [PATCH v9 00/11] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Thread-Index: AQHcJxXu7CgU3dw/NkWSLpeUETUe17SW9Sjw
Date: Wed, 17 Sep 2025 07:09:17 +0000
Message-ID: <CH3PR12MB7548FE594C7DF1CD7C11ECCBAB17A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250829082543.7680-1-skolothumtho@nvidia.com>
 <CAFEAcA_7aA8tV_hRzn=3Wi8LZnxaRrYA1DwPxt1MbmVgQKh6Rg@mail.gmail.com>
In-Reply-To: <CAFEAcA_7aA8tV_hRzn=3Wi8LZnxaRrYA1DwPxt1MbmVgQKh6Rg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS0PR12MB7898:EE_
x-ms-office365-filtering-correlation-id: 2553fb46-89d3-420d-7e33-08ddf5b91dfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OoE2lZOMmotGMMIFbq3zxB43iGxwoxY8rHa9gAV3rJ4wZ/LbWyLelnVFT4uj?=
 =?us-ascii?Q?RObfvHxolnKJF2xR5ng2kcp5YvZV/XzsiQIXVI50o4olP1/e8f0F8ry5tgeb?=
 =?us-ascii?Q?/CDedaf56SW4C85R+Olhs1soXB73d4/Vt4jYkjZTG7/+NRT6UPleDjttlszh?=
 =?us-ascii?Q?jOGrLqxPlPg0E5pKZiR+qTljms13UWbbagzlkbUEAKcs4L4swJ++3QhewrM9?=
 =?us-ascii?Q?nRmuEKNbpZwpxBvHL+JY5/yBeOD3FrINsLRj6PwR3L+e0FMoSvSrbHs4OE/Q?=
 =?us-ascii?Q?YTrZUnJ4qOCYxLv7rB3BwmXolTxdFmpwg3s5iotfWQgTTuoUvApZmhbG/FEk?=
 =?us-ascii?Q?xppYaq2kePkZlR5wF0VYjiIOcGTrNApn8u2nbD5QOY6IC+8Eouk7p7K46vjb?=
 =?us-ascii?Q?CCzJ0T59of1MCNjNRiO9zhVDgvvlH0IzQFffTvWxj+TjBzfzAlTxNMJIvcKd?=
 =?us-ascii?Q?Pkw/rFStK7Lkk9L7DaXiEfeoug3SpYOehhxM+/TwmHBiagAYLKVoUCMngCu+?=
 =?us-ascii?Q?PLea7XH0aOdHO8E17FWesd9yJSoNBZN4oKUS3SfhpcdRUylHLwqjNQCCjUM7?=
 =?us-ascii?Q?oKc/DhBH0ebRKG97c0rGdGOEtUyLasKxkOWq4oB5VedOkiqKw6OENsWc2bZf?=
 =?us-ascii?Q?14E+POWIpc5qS3g4ekMrlJNdLlzYsQcoMdbU27VeDSsi17NfrvkiG5psRy0Y?=
 =?us-ascii?Q?/yAcy5CfPMdOF3wyVGD9PG2w8coxJ8qlU9nzpSxvjz3vwQPgrnblBrQuGxkx?=
 =?us-ascii?Q?PrN6HDuxMwCmE2baWmc2gkxOA7X7mA0IWjkO52+1rUw791wqKmWpg7r32C05?=
 =?us-ascii?Q?TYsemoe7Y256KlGZ310al6/uOKgSNnAG/ryS56vcluzDV0lluTpWeIEhGFmB?=
 =?us-ascii?Q?ZZ6JvIfvdGO98rs7zqmIW7n3GxBcV905mQ7/x2j4WAhL0GIkzo5nBe8pOx1g?=
 =?us-ascii?Q?WE4VpS9I1GQQ+eSClTtrulwHYVY42fbRf2u2KfKQeU8Y4BZkRxrDiUleU144?=
 =?us-ascii?Q?vSQc88dpv4UmoRfIxUxYPEqgarhYNG+ouxVYCyLRypDSyVncK+jbzNC5JOoK?=
 =?us-ascii?Q?ZtbxEOv0Fv9Ofkuo+c9Hu7omxFiIphwhhfl6jWVrWtG8MjD3mD1O34LsRznS?=
 =?us-ascii?Q?3/KdmoneK+6J/09B4dxFnY1r/9/Tsb+xTjskQufgAmNx3uqF015JJt+V8jBt?=
 =?us-ascii?Q?7EJtx5uGFZDsY+63fpih8YoYtpyt6NqMtjQhXavfHZmjnHn3IKAfQjS7qusV?=
 =?us-ascii?Q?Ilg0J4dF5JQ0EynvL/TJJs0M8UBusBQ7pNIpT0nFEug3J12KXFO4V5IAJ1Gr?=
 =?us-ascii?Q?rDPB+7WJyaGGjDjgAQmc0kR1BzLY2ZhM1pNRJT+MT5xmJG9xMZ4GhzAKR7oz?=
 =?us-ascii?Q?6zct2EZmojg/oBQP6Hge1rUaQE3EAPP4u3vbfYB7KTGmAMJRsmjGhLAuaW3F?=
 =?us-ascii?Q?jVGKK+Er68k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V0kSMOeu7N3553IdeacQOxVQJ7kv8HhgYMDJt11XqOtNMXjqz9ls6vu7ycX1?=
 =?us-ascii?Q?uCBoL+D+hEkoTjHrWbKsiAr6BwY23zMgv1aKmjgrlOhkGFKTPObfZAfBjaBq?=
 =?us-ascii?Q?lHsGrGSWoHD+Dgf7el6rV9tg/+jRMXwPTTTJVMsfrqTa/wW01Jy/Qd/29GOa?=
 =?us-ascii?Q?gyicJi3c4vYeygxy8M2jRS+G0/KrlyyDRTkh2qvqcDdB535OsAYh+zHJgm/Y?=
 =?us-ascii?Q?iJRpm/iXvWT8xsYvI/UzTaqqaxn0vVfE9qnLP4twpSEt0E1wZjaoMjJeL8VC?=
 =?us-ascii?Q?CRAQJOmv1QOjRXnHaqInKu6MuKei2eVwDkVS/TxxVOPZaWj6PVfgSTqWZpu3?=
 =?us-ascii?Q?hatus7ifOW5E2xcqle0UTP8wHzdKsVNKHFTVad2ErkQ+W3DgJ85461KxZ/EV?=
 =?us-ascii?Q?cRzUy3cWGgG1aE7DMjQprY2dMAZ9CBLyFt9ef/W/ZT0gbyJN9A3MgkElZGa2?=
 =?us-ascii?Q?Bl9681NzhhEe/eZyd0M52+KcBLYRRnTe/lVwa4SrQUTc6EYyW2OXbMrsO3th?=
 =?us-ascii?Q?c0j4gThYc7/vxQGeORkcwI8xs9GwiBc4v2H5ye9VXGfuIiejXKorWavtfcUH?=
 =?us-ascii?Q?+bBarPzPtchZztyHnaYpsGOVL03mZcz0cCuMCLE3Mmerja3UYnUmZCHJbN8w?=
 =?us-ascii?Q?fDDqx7H+GnQ+XwEMOYqtEAVuhDr9sxhoKj1FIQW6VZurQxoNjp30fTP2JNLX?=
 =?us-ascii?Q?L4AsY55s1aSi8kLiCaTAkFd7keI9ZTvJ8LS5MT+ExchqdMp33oypk4O4l9VB?=
 =?us-ascii?Q?Ypmv6DjpHCyy+Ujqs3mBCHnGGdHqn2yNAQNVEmH/xkbSp5jykRI2Dd/m+A6h?=
 =?us-ascii?Q?a42YOnY98ZxJmeJ52IZeWVA6e0FsICk+l0x0784wg09S9jOUeTUyTQpbTxWz?=
 =?us-ascii?Q?p7zk9Qazcllubroy64s9OFq9dIxZn/zMoW4unUWcUyU6serJUzawNOl1D28+?=
 =?us-ascii?Q?JF/CV5vIOBh9PbNWluPz8+Wb02G6p9IzM5jbORfWdaXsAHUob9KMxiXmUdgc?=
 =?us-ascii?Q?awsPWK/XT68gq10QKOjXqQQDC9DHSXLw/+67n9dXlH1fwpzDDc3UffDaLwTa?=
 =?us-ascii?Q?jS7av0+nWTXj7gnHxNtlVS60K5/opH2QMrA2Pz71BQESJH8FWg4Xj88004QC?=
 =?us-ascii?Q?IpDYZXgB35vrvvKcQG7YeIpVGa09nAC68+PJw9MUlHJ+l05GvfPtXXAWWHn7?=
 =?us-ascii?Q?K6ZrCymP2kSVUnyQdLJWcxp5Zzy8irEmV6A/4Ki+vJA2WB1V0hQWY8/yl8g1?=
 =?us-ascii?Q?4rBEN924nhsWiH84/PkLuuQFbpUJT1N1h+8HCQyICtRwpgA2Yi3Xl6reY/ze?=
 =?us-ascii?Q?cQoebrtE+lHKE0tRj/+vIHeX/Svvjwmg1QorO80AlHOeZm6c+WYFYRvCYXsC?=
 =?us-ascii?Q?KlpM6WW0hOJtcndGD7iIdWgs28b+cpjfWexrgKRg+P7neT43OzcvnNAbHidb?=
 =?us-ascii?Q?2wYZHmhmQs8bAKsBIk8xBTlQQ7QADUnUF+vdknpxTkyYmU6j2aY21XcJvb+6?=
 =?us-ascii?Q?mwNqcY9OgwNaSmgH6P5IpHcwQvGT8HZ3PmgyDKOlHF5xweNdr5wlIiCYS7WY?=
 =?us-ascii?Q?fAohhvkSm+7amAkB8MZB4YfPpPm8EdFQyvCY7inE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2553fb46-89d3-420d-7e33-08ddf5b91dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 07:09:17.6784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxQ71gkNv5PAFiKBOVHRTqHlpSrUfY0dw+iIRfcqVjFac+K790o9JbJHuhCNmwkbYbbkAWLO4RCmDk5KtJDl5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: 16 September 2025 15:27
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; Jason Gunthorpe <jgg@nvidia.com>; Nicolin Chen
> <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
> imammedo@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; mst@redhat.com;
> marcel.apfelbaum@gmail.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org
> Subject: Re: [PATCH v9 00/11] hw/arm/virt: Add support for user creatable
> SMMUv3 device
>
>
> On Fri, 29 Aug 2025 at 09:28, Shameer Kolothum
> <skolothumtho@nvidia.com> wrote:
> >
> > Hi,
> >
> > Changes from v8:
> >
> https://lore.k/
> ernel.org%2Fqemu-devel%2F20250711084749.18300-1-
> shameerali.kolothum.thodi%40huawei.com%2F&data=3D05%7C02%7Cskolothu
> mtho%40nvidia.com%7Cb353ba5aeb52400076e808ddf52d18d4%7C43083d1
> 5727340c1b7db39efd9ccc17a%7C0%7C0%7C638936296246973267%7CUnkno
> wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsI
> lAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> a=3Dd2GPo8T%2BgwLfrfvYg7Zal8JbjpyVk%2BueWdAK1ycvBPU%3D&reserved=3D0
> >
> > 1.Dropped previous patch #1 as that one is now already in.
> > 2.Rebased and updated DSDT in patch #11 to make bios table tests happy.
> >   The DSDT has changed since Eric's PCI hotplug series work.
> > 3.Added T-by tags from Nicolin. Thanks!.
> >
> > I think this is in a good shape now. Please take a look.
>
> Hi; I've applied this version to target-arm.next. Thanks
> for this work, and also to everybody who has helped out with
> code review and testing on the series.

Thanks!

> >  hw/arm/smmu-common.c                          |  37 +++-
> >  hw/arm/smmuv3.c                               |   2 +
> >  hw/arm/virt-acpi-build.c                      | 201 ++++++++++++++----
> >  hw/arm/virt.c                                 | 111 +++++++---
> >  hw/core/sysbus-fdt.c                          |   3 +
> >  hw/pci-bridge/pci_expander_bridge.c           |   1 -
> >  hw/pci/pci.c                                  |  31 +++
> >  include/hw/arm/smmu-common.h                  |   1 +
> >  include/hw/arm/virt.h                         |   1 +
> >  include/hw/pci/pci.h                          |   2 +
> >  include/hw/pci/pci_bridge.h                   |   1 +
> >  include/hw/pci/pci_bus.h                      |   1 +
> >  qemu-options.hx                               |   7 +
> >  tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 0 -> 10230 bytes
> >  .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 0 -> 10230 bytes
> >  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 0 -> 364 bytes
> >  .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 0 -> 276 bytes
> >  tests/qtest/bios-tables-test.c                |  86 ++++++++
>
> Could I ask you to write a followup documentation patch which
> adds something to docs/system/arm/virt.rst to describe the
> new functionality and give an example of how to use it?

Ok. Will do.

Thanks,
Shameer

