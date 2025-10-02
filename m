Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBECCCA472
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DpJ-00042L-Qw; Thu, 02 Oct 2025 03:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4Doo-0003z9-Ce; Thu, 02 Oct 2025 03:33:40 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4Dof-0007bM-Jd; Thu, 02 Oct 2025 03:33:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDro2rUoj5jDvAioRhSfVA6SMXRVsAgBxaDCL0AotiFpNaRoD9J2hZWP+kYAYbwStSqOq4HXhjItkJQ71rdarhfubjie8rWKgRVNbl354PR+HOjCkd92isMmsZpKUwBqeZEgmtXLmQSdbGqNz90o7KUUJB3BbCDa7H6IXRs+zXh4uUhIbOSuyVUFfPhuAHv0AQOosC2L4kAQSIwtldI122GaA9ou0ku4z1CprAOoS6qb398cHE+O2vu6/ONIFUgq1CiNxXL3YDVu5z5FGMDIxEIFm8bgvA9/l5EywlIX3GPNRn8907KalV8y/ErKgijuOpjXSExnbgPKNUD69Ksx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKFuP3cxRPY3+8pFK79H3vZ2vb2HvoxT4enIYiHtcE4=;
 b=pTN8SaaAhJ3BWQchhjJTidxjtKYCZrY0/6ChuIJQSXBoCpoI/WG588AJgzJVVcOrBcoHUy4ZalwuAH4E8Np5GAuBcEZsnvb7igfzjjYWkpGZb2PxRH4U+IlBc1E/8x2fLG7kSGavorJqE/g7noFIBwQqXOSUcWtLrDcCKq6GRI9gVYfaCFOe6rGa3+u7pb8YogaeMGU3bsYwr3NnhRTH/UsCs3w0ktqUGquN8FOqm1BjbR1A1oKBPx7+EubFwJkkIVX02LAH/gIsVFjpY7jreJn/yTyjX8mqRTZwia2+9yoWg9ooAPXHxaPFKU+F9f5TKL7PABqTONWLnG3yhhIueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKFuP3cxRPY3+8pFK79H3vZ2vb2HvoxT4enIYiHtcE4=;
 b=V1CwBC4OfAkCf/+AOT0GiEMeSbZ+ahHZmchSnzRQqBAwhMEN69uOzXcw2D6RbCvnz1umww+D5Zbht96NiVmaVKbhTgRWT7VOTdnouvMGaAvXyvujCOoDyE1JSxqhXUt0xqpIshn3MtcwhKAPMFrkUUklODaTBkHtrE8OhbW6G/9GhAus/2/ppfyxZulvQJtWAbx8uoNFwPLa+7R9NiG5G7IhrwKR26IlLra9jK3Q/LjwcIxq4i3mnkyEphgZj+u1aDMCDXL8NX5nXUir69pHxrnSjQPFJduwBfeGvzH5AQiuHMwZkF6DROkr4SxMdu9gzciQF1VCW1QkLHx0vYxvQg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:33:12 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:33:12 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 12/27] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Thread-Topic: [PATCH v4 12/27] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Thread-Index: AQHcMWFLDn2h9razOUuZ2JXnwOkMU7Suek3Q
Date: Thu, 2 Oct 2025 07:33:12 +0000
Message-ID: <CH3PR12MB754813688AABF9ED2D31EEADABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-13-skolothumtho@nvidia.com>
 <20250929175114.00003b03@huawei.com>
In-Reply-To: <20250929175114.00003b03@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV3PR12MB9258:EE_
x-ms-office365-filtering-correlation-id: 1ae11b41-3d03-45e3-d376-08de0185f11b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uZCYc/thXU1XOkefqt2QDmqZwZRmFzgmavtXXBouBJkqNJY3g7ujD72ZHkHW?=
 =?us-ascii?Q?ArGlQADoIKs1sh7kITaANBXyraUn8ex6S76t6Z7VaqMFFhO8GCVBQ13gk0Jm?=
 =?us-ascii?Q?9/vMSHTBGzI423n/oYI7tumZ0B/HcDDwdlkuy/Hplw7k2H2c2v+1XP7u/HlM?=
 =?us-ascii?Q?deug1y2ZmV9gsr96cfBRVs510/iruQIbck1n+NkTue+AsCT91AbhayqCuiQE?=
 =?us-ascii?Q?SF7bVNdFWpxLQZUo2SRrYa5R5KMp571ylp6t152W1gK3uRdzTzflqc7wDRUf?=
 =?us-ascii?Q?jXxKzMbKwZcryepFzOX/2zeFLAUx7WstHeaF2EoqRFI431ZjN8ojj5QhVI79?=
 =?us-ascii?Q?eg3PwBubdjlcFXCjecW1udp2AHhUs/k4qwuQQH51dM8NO5qvce5j0mzCoQnX?=
 =?us-ascii?Q?qWejzO3ck/vhvfkOSok8I04R2hZbrKJCQN82k6ZOqPipFW/ewPSw+FObC8zt?=
 =?us-ascii?Q?DlWwui9W5Sv81HqlG7BGHxcHo8e+JXj3E1DwAGP+SJ/sgZUbHjt50BzZPRnk?=
 =?us-ascii?Q?zm8/i7/m2VCA54wpBYH+lZcrbArSL2MSipvEeeXSZ6kiAuYnvNnDRW1VuUl6?=
 =?us-ascii?Q?2582bBsEmbF/jrRBqF8j2Sjo3UQIiorRWNroOU828i+Sxe98dZzX0GrDV0g3?=
 =?us-ascii?Q?lkcwr70h20KFohzAtt/8QHcHQnxY0NIl/Nh+h1rJtmCWO9eDFsgT5vwculwT?=
 =?us-ascii?Q?0BbF2kva5jYp450FfYJPr9WVtL4YqB69+6nRaou524aeSsPIMGWi0LAB6K+F?=
 =?us-ascii?Q?VIbiFp1CpU8yvTggbd/oQ2T5v+tpefasqvoLSrqoghMgOrP/uJ0uC2LdBJ1d?=
 =?us-ascii?Q?9qtiEgzQDWKJ9V/xNiArtECE6kZu6Z7i1iWeMFl+OwCAF61Gs9VAOj3c0Nu4?=
 =?us-ascii?Q?KRLxeQZC4OiLDMlP1xYaDYdeC2mNrhwzjakln8/UQp77eH230u/6I7npJDmo?=
 =?us-ascii?Q?0QAREZ1nM0Gsx6qpWuXcLBMn2S6iPuodJGmKu3Zua9N4Yud1t8O/3s7b4VXO?=
 =?us-ascii?Q?GiKDUF92D1aj9DNltsg7g+9PJNGM/Jiu6Ovk5CJ6XDGexRm0POOaiKTRMpqd?=
 =?us-ascii?Q?5yrQiEG7moi2RuH6hxoGbBPbhZFS9iw2Nh415pUovWEEJ6bR74rz38xlLWvG?=
 =?us-ascii?Q?gotTliMCmyvO0WSHOOJ3QTuz9lJTwxJrAztt3hvnaLa70K8gT/xLwjW5WvXQ?=
 =?us-ascii?Q?Mg07fQ7gbU5uymuq5ikX+0RzBOyKgkbiFoDgYMe2NrsN8rS3MWmu8E241IXs?=
 =?us-ascii?Q?h6j+vtpourexFvImQesXVESVuo0mZZ/doE/UGh5weyIAmJuarDfHTayP0M2I?=
 =?us-ascii?Q?2lXw9WZIbrq/3mmFAwC/vboz84ZSTSMtaI3PrJU+m/JMXCKaI7d6vrRZf3Dy?=
 =?us-ascii?Q?SjQ4aXoCZVoO64oV36qKL1UhNXzUw8uPgcOCoBglGlG1HqdvPmF8aw3EMETc?=
 =?us-ascii?Q?IjBSELt2q655brYEtfIOyRo0gPf14+WM4hopEU+djZ9DO70Ud9ehbP1/2DSc?=
 =?us-ascii?Q?CT6jPH3tJ4hSrxN4+H2Xa9MA5p69feoyOJge?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fyCnKMQrxBGLXdyE2qug58gFxQAUKGuAiYp9jBVoq3oXu+pZObkVCJf0Qor3?=
 =?us-ascii?Q?K6hl8oUPZazXGGcd5l1XHaSLbQJRdmOvKs2BmHAaH9bDhpvisxGw1lU2f0KI?=
 =?us-ascii?Q?opkl0S9hxIF2P/riFUdutVzNRRBxxMYf6gGU7uoFMa0cq85MK+Cwq7Zgisyf?=
 =?us-ascii?Q?51HSvK41ImtKxQ1HRMWEbxRb8QRPSgi0hVGPnt99V7gUkJDrqP7GF5b02ym9?=
 =?us-ascii?Q?Jks11o8WbtAEnyH4HqMp9L8vzoppYovIxI9LkPWMPrkcvfwJWzvySj+P/Mts?=
 =?us-ascii?Q?FdkriWlJzXJGB2HrljcRyLKcIyVjrYYGZh97vIjMPdMnHa+y5McqzaAbXPke?=
 =?us-ascii?Q?PhBWQOpJeMcC61ExjhpNiGUESGcdTRqAZf4g+LCrWBhZCHsEUD9XYfSIQAGq?=
 =?us-ascii?Q?PzwRf89RGL+8EmF2WBnYFaWpAnctBSubKhZqTibXRME2042CBdEg8WkNV2md?=
 =?us-ascii?Q?fvi6QnO3Og+HCeP+k6E2VG6DVzPWXfXqZMg3pOgKI5hO+/6hbCi+HZkbkHPA?=
 =?us-ascii?Q?4sT+WC15ehDwMUHxLN54w7PiY1pA023SuSj8G23Q50Hmr/luD+debQyoHnsE?=
 =?us-ascii?Q?sKXH/N8Te/Tgbn0l3MAfuYmJP5omr8fdb5dPzFPpGJnPdTSP0oxCN5KwaTbp?=
 =?us-ascii?Q?uJRz/MEzqi+aHx2GDn1W+iMxU4Z4Z2nsfW651HQjfBFev6Q4i4V3mNeN80fq?=
 =?us-ascii?Q?/391zXLZYhkf2rpXfKSNEbgtCwcloMVY5VD5TCychLpl4qvGrBb5o8rVzi/D?=
 =?us-ascii?Q?17VNRFhNEKJbdI6cG/vgpLDRv3x7vwUNWtFyEBqTWUlsIZwJFiRNXj2lsXvT?=
 =?us-ascii?Q?YFPivHNPUrG2PQjOf+skNGjmzvMy34hxP6Fgf8fLJCRPZ0d/Hjw3chZry/PA?=
 =?us-ascii?Q?IE6wv6Lk8RR+gsuE5usXdymxR/IvdkSq9KyGWEfCH4P2VHp+fsh4eXny5h6d?=
 =?us-ascii?Q?YBg62uqCvpl/WKpjLOS4VVB4Qkii3k8fnq+0RfDxuQTj3g9Ru/EDpew+jNhX?=
 =?us-ascii?Q?tPxGcf36HdjBrLKnUKPdz6mEq0iTKS6Q++ZXs/zEKuuki/k/0MLk2ZRJD4qk?=
 =?us-ascii?Q?Pm+YWbggMvs06Di/hAxzNvcGfG72X0Es7YGzyp8Dk1Fu/Tc/RPLJaL7kOAzt?=
 =?us-ascii?Q?A3mG2NnA9U6ijkg7JDFWD7mOnwCx09iUb7EwBOtTWULt591WBI79gWi5wFB6?=
 =?us-ascii?Q?F943FUldoaIi8Ek2F2sX4bHutzhH05hAws6RyIq0votDPlzVNnCVYu7Fikyp?=
 =?us-ascii?Q?PFKbog2Lmby/y2hfAcO2CO/gSbz+jB3lUlvBCijTPbsOr+ulhfwNuln4d+Yz?=
 =?us-ascii?Q?35kgXib1nXebyvcEMeGhfc4zG6QBpND3YQVLqbtUiNflJyt45R29J4QO6eIP?=
 =?us-ascii?Q?CMV4hv8dErBZKamC3H8jbmE2EuvSoGpRcRLiSuu1QLFVfa+N5YnDyp4zKktU?=
 =?us-ascii?Q?GJbSdx2SLFkFnYHrPFG+dD3gRuRtJlevGJuPhQnE05pr7E3F9xjOthMHaaA1?=
 =?us-ascii?Q?39z8TtN44HelG+HqXo5cCq5aqNRMXvJRYnkEeorUgn4LE09TPM8xbvR5GxjH?=
 =?us-ascii?Q?INsQtReeXEwEBbQqa1SP7EwoNHO/DcDlhUwUmulk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae11b41-3d03-45e3-d376-08de0185f11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 07:33:12.0510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgI3h8KoXsAcMGRQc3TGL4AzwsD9RM/u6chqtI/+uty0YscDxJ7KbUPOy/ZWFjbzJgHowE65xJKBXxJa1FJD7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
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
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 29 September 2025 17:51
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> shameerkolothum@gmail.com
> Subject: Re: [PATCH v4 12/27] hw/arm/smmuv3-accel: Make use of
> get_msi_address_space() callback
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, 29 Sep 2025 14:36:28 +0100
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>=20
> > Here we return the IOMMU address space if the device has S1 translation
> > enabled by Guest. Otherwise return system address space.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Naming question inline.
>=20
> > ---
> >  hw/arm/smmuv3-accel.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> > index 790887ac31..f4e01fba6d 100644
> > --- a/hw/arm/smmuv3-accel.c
> > +++ b/hw/arm/smmuv3-accel.c
> > @@ -387,6 +387,26 @@ static void
> smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
> >      }
> >  }
> >
> > +static AddressSpace *smmuv3_accel_find_msi_as(PCIBus *bus, void
> *opaque,
>=20
> Why find rather than get for naming?

I just followed the get_address_space() convention. Will revisit.

Thanks,
Shameer
>=20
> > +                                              int devfn)
> > +{
> > +    SMMUState *bs =3D opaque;
> > +    SMMUPciBus *sbus =3D smmu_get_sbus(bs, bus);
> > +    SMMUv3AccelDevice *accel_dev =3D smmuv3_accel_get_dev(bs, sbus, bu=
s,
> devfn);
> > +    SMMUDevice *sdev =3D &accel_dev->sdev;
> > +
> > +    /*
> > +     * If the assigned vfio-pci dev has S1 translation enabled by
> > +     * Guest, return IOMMU address space for MSI translation.
> > +     * Otherwise, return system address space.
> > +     */
> > +    if (accel_dev->s1_hwpt) {
> > +        return &sdev->as;
> > +    } else {
> > +        return &address_space_memory;
> > +    }
> > +}
> > +
> >  static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
> >  {
> >
> > @@ -475,6 +495,7 @@ static const PCIIOMMUOps smmuv3_accel_ops =3D {
> >      .get_viommu_flags =3D smmuv3_accel_get_viommu_flags,
> >      .set_iommu_device =3D smmuv3_accel_set_iommu_device,
> >      .unset_iommu_device =3D smmuv3_accel_unset_iommu_device,
> > +    .get_msi_address_space =3D smmuv3_accel_find_msi_as,
> >  };
> >
> >  void smmuv3_accel_init(SMMUv3State *s)


