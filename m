Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E1CCCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwU3-0008Cy-HN; Mon, 03 Nov 2025 10:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwU0-0008C1-B6; Mon, 03 Nov 2025 10:28:36 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwTw-0007LT-9S; Mon, 03 Nov 2025 10:28:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBx9L2pgb5tPxOYXklcHS20otmsq/iCpMV0aBa0LiyQipctpJn2k98sxGRCyUhMfpgyhjI7YkgPYYLyif+ecKedjd3W08ePu62XluaJtdkl4DiqgUEwMLKXjeC4OsD326yXdi7829rY4KhsKYpnNCeG1ripVJ5gxVAP5qFfeqjibMHIg802WLtmFqlX7A6CinrqOMAZMK9NaeoPI6cb6cXUGGpABhfLFO3bgAmmxGAsuMf/Y7Ko5XbvFaHlmCfUG3oRtDtmskvgOSk2HnH3UvzPCecy7y6Hhdlm7uwuAbjBfkPhhvHJ5wdzWtMpmUx5likdrlTV14eChVvkkkTSDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRjNu+zqlp0S9HLEPKAxOGRIaBTdw8T0fkynWdPVuec=;
 b=SU9vH5BNJfHKnrOel+CUis85z4au0hPjb5sjDradUf/qqOG+ZUU7PZJhY8tKoHNPjXIZ3cBWcP8FWjzHFZHJZjfv/P+v5KRLjohoJRTuICRJrDFGLDIsTE+ZWOlNM/5rlzazzLxBfglYvbaphGjm3D/hd1vU2p1tYC2fwlcjStKcKajFrBsQ8OXC5IKUgYo+G5+JmPWxmwl8jApxCQFMJ8dPQjbxc7RHRwwgtc4ydcIOFOZQ6M3mSiFd5KmtcsoLxNpBl3ii8eXMyQtpgBffGCD5oglWIwna0ttEIz1MwmsivuEszDts1PiQScEMKxRwcATnsUjVtTRNPtZpOytRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRjNu+zqlp0S9HLEPKAxOGRIaBTdw8T0fkynWdPVuec=;
 b=nPsv9BjTSmNCi/HMjLLrSTHhwvnOU8TJHFmEjqtkue8ucSbZZPDBYibPjuJcBOb+tsWo55ILOOcWuWtROFotFEMxrEodnjtxFnbCTcnIF0gr4YNI71UqUM1b6PXbmP8pWwFLqT9uR7re/VW4aZBL+IOvFZx5I5Q+Mc6WuttiIj1D/NOnl/ERvuM2k8Ryd/tiG+fVmNmwH6pGCShDbBW8WGppIWJ6XWYUQs7rVbq8f943duwO+MhjfzYGIgA0y8JhxkPvALRx6toauw7JxRF+AGHpbtapnhm5yItag0Yl6BG/DqNBxsZlWggkWyadlAlj+U2fbg/GzjhZj3ZbRAFekA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 3 Nov
 2025 15:28:14 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:28:14 +0000
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
Subject: RE: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Thread-Topic: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Thread-Index: AQHcSsdxxb/8tkLCo0G9kXiIeGlCzrThFnVw
Date: Mon, 3 Nov 2025 15:28:14 +0000
Message-ID: <CH3PR12MB75481D898FF28E9832B0013EABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-18-skolothumtho@nvidia.com>
 <aQVVxV4I/nh3aAXn@Asurada-Nvidia>
In-Reply-To: <aQVVxV4I/nh3aAXn@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY8PR12MB7100:EE_
x-ms-office365-filtering-correlation-id: 03f9200e-7eb0-4e12-6d08-08de1aed9b0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2RAqF2foSM71zgG20O1/taI2yIZ79VDrXDQsHVzfu6P47t6+VdNE7AKpkT?=
 =?iso-8859-1?Q?cMxZjjhuXWlGeStdlvOsUiDftPZs95aTozbIv8fOrIq9kPhZRoBPmx9Pqu?=
 =?iso-8859-1?Q?5wZMCJ+CzMq+ZSJ7OrznmodW5Ae95339naCvWuRQYEzMoK9BvmR8kAecyM?=
 =?iso-8859-1?Q?XGpqwC73v68zUtwtP8jyJpf7uGXrCqk3TyfxA+/V9hNMTpSa818uxxp+77?=
 =?iso-8859-1?Q?99SQrNBfLflQOhLkDkMRZvHkQDCwY0MnomyDxwNmS7fvQgNCokJJp6/SMP?=
 =?iso-8859-1?Q?CTPNgLl8B1phes0EgUrINtWrdzJxUapLqCCPuIYG/W+uZpK9J93k82Z56n?=
 =?iso-8859-1?Q?Lc9z/ihByjskafsfBVJA92pynDVw5liTfcGlWf8uwQ69noYmCiiiIcpGwS?=
 =?iso-8859-1?Q?WNKoMWcZtkZBMo5dzyhg5HHM0Ws43+mF/SyHlUc3thVqAZ7iyK82u2/tZG?=
 =?iso-8859-1?Q?cyK11KiH+Iz+4SQvrRS+VOyR/SAkuP8yXsMOw08OP51lnyNohoXZDBnBSA?=
 =?iso-8859-1?Q?Dx3uBGfv1Ew3Vq7Dyy6H4XNtb0z9sHTOsykotM9jlt9mEHaIKrafHF3+Dt?=
 =?iso-8859-1?Q?BucUN5iDOpnTqMVvunNdgD/HwhcMcpSJKeS0vCz1IhK4Ru9ibKFvUvwCur?=
 =?iso-8859-1?Q?tOPrhaOiVF6lR0cbeo4JRWw83MnE9SoQUGxeL3MP86GH/hj/XbgkzpnQju?=
 =?iso-8859-1?Q?OZno4gKupoJUz0cZIK5pgm3gUz6i1K+fV0Av94MzMTSzFrWDIi/sJ9ESqn?=
 =?iso-8859-1?Q?Suj/6yv4RQKYdXN1/xF4GBRBLQ0Hi1hgyg6bXw/w+ffBIrvYL1Kza21PIy?=
 =?iso-8859-1?Q?KpcTcjI4j3JmhUwFYd8b6+GwTBK4MtoJpPOSBvXuOcBgZ65MAxH5yVfiFz?=
 =?iso-8859-1?Q?rkbKO7lTckojNEDCJYT45BDQaamgxPjw/7tdu1Yb1UJJEu+CvrIFA6/cPN?=
 =?iso-8859-1?Q?qrGhQJcWOizHMEyBFusDYRIn1+E6m/5nT9FIjYsNPhnnxlT2IGHw1Fp4dc?=
 =?iso-8859-1?Q?Gsdv38xcEiHchsxKy/3hpeWVdW9DCBwzaRuvUUex8vlrs1MLRxXmtfohxZ?=
 =?iso-8859-1?Q?mdgCx3nangthrQMLKnJfiPx8BSHN06msqTID4QHAW5w9D3SwBh0zSyU5R/?=
 =?iso-8859-1?Q?GMbKgE+3/Wln2OOIrtNv2uToAU5/z2Gj3mk+bYfLx5CGCCmpwr8PbOTrtR?=
 =?iso-8859-1?Q?G2mOFiaBMk3dk/6/AnEVjFQFsuUecCbvUODOkUd4+E8T7u0ME5CqJABqDr?=
 =?iso-8859-1?Q?noZa6425fEuIdrbBxO22FIYVl1baXetETfZC1SyGZD+ui9OwkyFwvLbU+v?=
 =?iso-8859-1?Q?bbwQOawfhhhFbdH2oYE7K/C1et6m0zVAqWvHGpTzjryX3YYW+Oh3dew3Hk?=
 =?iso-8859-1?Q?IPmf11LF8SkQ+L9hUf6W9O8rnJf9in524oIrVgdr3FncnCYOxlr4CURgEx?=
 =?iso-8859-1?Q?sNX7BY0Jk0XkYUfIEnXrBIleTrlAT0sO+k/+Pv3zgzq4lr+3Gnaz2GG2vT?=
 =?iso-8859-1?Q?zICBxzhm1xJtHcm8Ey3UsOIXtO9PsAfUPk3AplXWZW8QUcb7fH3R1jCkZf?=
 =?iso-8859-1?Q?lXn1D2fV4CEL0HxJ/F7xFcpOtUqr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WqnB/th/cf82W7cfus4LLXaqUSKjuUfIV63SqtfV/GOcxJ/XjcBe1kj+Td?=
 =?iso-8859-1?Q?59d5nOgh3xriGH0wm3E4ILXB3XHmm56UQeivP9xaV0pMW+gxXrGrbWt6Tf?=
 =?iso-8859-1?Q?x5pv5vLnZIRYF3TqUsy5Mejvz0w78VVNmTAx84l6socUfNz8X3E9sRWnZy?=
 =?iso-8859-1?Q?xNlDXBYHcRdrrOPX1b5UChdgAfYZxuANMPmM7EizRpp5hfgVJ3ASpmnjdq?=
 =?iso-8859-1?Q?G5Zhx7S878WSbrOJ6MuiWQDV6C0ffsNOXjyJuKrITN1lsUSXCHrAdbS9q/?=
 =?iso-8859-1?Q?/KfbKyg+vtiiT6egf1VrIsUHQ9puzKWyuwpcgcxR0w58egwFhiyUSS+Bjl?=
 =?iso-8859-1?Q?jVASFJg9zcrVmkdiJf4PY74xWcaOUosokDCOaifTzM8g9BsMZxf9YQxXFA?=
 =?iso-8859-1?Q?vf/9d6HkvptZkPndhvOEymWfJLxDt0fDRy+rRdxiGZPdBhGHQJ238VjwmG?=
 =?iso-8859-1?Q?ldod+rfQMochM9aJ10gwPl3s/nhXywTYqj8NW1Latp02wlMCffDx463L4+?=
 =?iso-8859-1?Q?Chiof3rbNZbVCoJg7fH8eKL87a2qFcLLgBruTrTuYJVzJMLiz9xlcP+nSF?=
 =?iso-8859-1?Q?35YkGOVqSDCtb0atM7cjuemy2+qI50jH6Bvgj7m5RMMzkGPW57qu88OS6+?=
 =?iso-8859-1?Q?BRNljeeTRU4xUhsP/RgRbKOoOdM1nzZVDwYjen6AJrnEdCh4OwpKppZpoT?=
 =?iso-8859-1?Q?rH1NmR+Ky4hciOh0Gmwcpw/+q/YDGRPfiwRuo7OSCn3z52hKD72BjHvcz7?=
 =?iso-8859-1?Q?qOdz2hj9iEIXl4kLHaZbnc3u/Nn3wGG3il4crY0dEivADlB73zzmxbDZ+P?=
 =?iso-8859-1?Q?mltoBR1uRMJOSfhW9fyE1jWw51aMpUy4pgJ3cqlOls/U+lghxGE1qMSDLv?=
 =?iso-8859-1?Q?BoM1pc3hWsan6NDtnmQBfeknt/Q7k62Hlz6oW8Zq9DRc7J51y90cUoJi0+?=
 =?iso-8859-1?Q?2sqqSG5JFBy/C1WjVEAq1ppp8ZQpwGQazC2hT/dZkoSwK6Mep6d7K0u6SO?=
 =?iso-8859-1?Q?c8bZuMh1+E8pdXzlENj9GHJbB9MAgwDr6FBhTyqXFKI4FMcY+4eYf683yS?=
 =?iso-8859-1?Q?JbGynSv7sfacpFddlLL1r+90rJSoW6sKnx9hWZYvmZlJ/5Y6K54g56b5YX?=
 =?iso-8859-1?Q?e6O/KgARrmN4PcOvLaP/puJtBuYLPonQJCDX2Eqhg/aKPrNLtCQhJBBRdI?=
 =?iso-8859-1?Q?MLYspXpjJlBtoDXfZ2EnEUlLuym40XXQRJq9Xqg4PCJJPZ25+PlgE0/d+I?=
 =?iso-8859-1?Q?1Qvp8J/klCNS37Dx6lmGYUZkyCs6gBmbjhJ/BhkKaTfEC+Etrrz+AE1j26?=
 =?iso-8859-1?Q?6I9ul4jjrgUPBlkZbnUtfcNvQny4SdgSr53PIP69vXFYyIRUAtyzbO3Rxr?=
 =?iso-8859-1?Q?Kn8Y8/fnv/7V9aj7gLbeaHyNqNN+1loo8ggHQt9bnkRBjzymU2U0ymHksG?=
 =?iso-8859-1?Q?Zw3d3cqTViJmNtNcNJC6z9Lj943IJ3iG++n7n/bH39eGQSbWBRqJ2HPF8g?=
 =?iso-8859-1?Q?PQVJ5+9irhIlh7/NwPN4FHDbj/hWkGacyXjjJpEfm4MG3lCIFtI9nKzBJP?=
 =?iso-8859-1?Q?/ceKAflBRRxdIwi4ZlPM2c08yH2CYnNuB9M5YHlbVMjaopGUAobp+UNbG7?=
 =?iso-8859-1?Q?1ASguOCqd2rWMs77N9moePdVqg2XcoTMu5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f9200e-7eb0-4e12-6d08-08de1aed9b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:28:14.4003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oFZrwq6y9TDtWtVccsR6rez4DDCnU+ByHa/PmbK3uBgxEsXGZjAF2OusSTAKTH/qMScvWu8IIksFoGAx9XoFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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
> Sent: 01 November 2025 00:35
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
> invalidation cmd to host
>=20
> On Fri, Oct 31, 2025 at 10:49:50AM +0000, Shameer Kolothum wrote:
> > Provide a helper and use that to issue the invalidation cmd to host SMM=
Uv3.
> > We only issue one cmd at a time for now.
> >
> > Support for batching of commands=A0will be added later after analysing =
the
> > impact.
> >
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>=20
> I think I have given my tag in v4.. anyway..

Sorry I missed that.
>=20
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks.

> >          case SMMU_CMD_TLBI_NH_VAA:
> >          case SMMU_CMD_TLBI_NH_VA:
> > +        {
> > +            Error *local_err =3D NULL;
> > +
> >              if (!STAGE1_SUPPORTED(s)) {
> >                  cmd_error =3D SMMU_CERROR_ILL;
> >                  break;
> >              }
> >              smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
> > +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)=
) {
> > +                error_report_err(local_err);
> > +                cmd_error =3D SMMU_CERROR_ILL;
> > +                break;
> > +            }
> >              break;
> > +        }
>=20
> The local_err isn't used anywhere but by the error_report_err()
> alone. So, it could be moved into smmuv3_accel_issue_inv_cmd().

Though that is true, it is following the same pattern as=20
smmuv3_accel_install_nested_ste()/_range()  functions. The general
idea is, we will pass the errp to accel functions and report or propagate
from here.

Thanks,
Shameer

