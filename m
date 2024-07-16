Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE94C3DA4B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 03:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTYTv-0002b3-Bf; Mon, 15 Jul 2024 23:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTYTq-0002aS-1G
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 23:03:55 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTYTn-0004V1-Mz
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 23:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721099032; x=1752635032;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BaLfrLwOblxU3ZjDnFzafpk0eskfOtFSngMFKEWxV+k=;
 b=YMIUV+5L7nrGGX3Rdd9tqhBVUuINv3pba1ZRLhruKqpAaGz/bIgSzAhz
 r8EubNLLB/H0Sh3GS4NZ2U1XcI9PFKyT4BnG37QGcfycJTMCGPhomXVk6
 8gyqSR3r8yLIoiYjx0MXgsC7MugeAYZlb0Z0e/rVKSXa/vB4h9V1VIwPF
 ZnAVFGbl2xeDHrk7qlxBf6D5MCvB5b2w0K6bPT7Rx0fcbHu+jg48QkJwH
 cHVamelqCFPKRrn6rmEBhaGzayp1NYQIFofxknVkqxWnsKdXeBlEoWc0U
 ymKJy3B0ISFhavvl9X/Wd7bl/SXyjHnyme2gEZA24WzyjF1hVygaYa6q6 w==;
X-CSE-ConnectionGUID: aJ9xhuZgQSqn4Ikn6+JkoQ==
X-CSE-MsgGUID: AvxwQvshQJWVUxgTgI/Qgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="41037015"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="41037015"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 20:03:49 -0700
X-CSE-ConnectionGUID: VyfAi7lQRfi0zOMbbCJZoA==
X-CSE-MsgGUID: K7AV4ZHzSEq3US2yJEWLHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="49779889"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Jul 2024 20:03:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 20:03:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 20:03:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 20:03:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gluYW4dEuQJn0SIRZiffmy65EXixAdznSlWh5TtQMwraCbwRIS0x2F5YTNafbhHb3JyRsagPDqTqfAy54cguguKthpZl1JlTUolN20HRfxNvStTIiJuPW/LjZgUJMYEytUs8bIY9HiFl73zHDWBtDG9DRJ7vrn0tYTHojrH8eyQWMp2h1bwqxB37jtjQyr5E6fig+AGPs8+N2vMYpSNgzK8mPNb8lDHFB5NDAfFdC0in+dUtCoXsrZyG6qEC76gqpc6gyQQhV3gqdf6daXoQQhwtFT52qALU1M3wyemXz1juJjyZ0qz7655g4dJKsRZr552gwTHCjURcNIYFpJU4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEHfvitPMOKohJ/l3kLwFyNSechC5Lkq+ws9M2NrIfM=;
 b=kiNv3wtuIxGJXHdmUg6wHcWEjqXZ7sZFhUtSm8c3ebOK6he/qchOk9nMEtXLBipRcSxbBL6cwEW5JTY97S1TopuHjWVZW08hOrtC/cNmddlhMQC8sEmYzvAjAv+BbIGjqzv6hbfEdUg0DPjQVoHexDvUiSHy2xpB3YnpVVZQH2TArHpWkDC4lTsPBeUTTcoe8Laaxt2YdMlccU6NaYsO63SdNduOAUeUBYeTzX/IRIxLzDPD/t6fDViiHtN8MKkxgemtDv7C2dKfg2u/cVXmqj7swlNoCqzeIP9gC8L3CwPb8Oa8ubfOTy3cQR/bf2GFZZkdDchhlM22yhYyDy5+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by BL3PR11MB6483.namprd11.prod.outlook.com (2603:10b6:208:3be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Tue, 16 Jul
 2024 03:03:41 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7762.025; Tue, 16 Jul 2024
 03:03:41 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "Wang, Yichen" <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, "Wang, Yichen"
 <yichen.wang@bytedance.com>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: RE: [PATCH v6 2/5] meson: Introduce 'qatzip' feature to the build
 system
Thread-Topic: [PATCH v6 2/5] meson: Introduce 'qatzip' feature to the build
 system
Thread-Index: AQHa1wQ0zwDezs9yr0CEBmbHTa3DVrH4pDfg
Date: Tue, 16 Jul 2024 03:03:41 +0000
Message-ID: <PH7PR11MB5941855152B88359581D7E1DA3A22@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240715221245.12435-1-yichen.wang@bytedance.com>
 <20240715221245.12435-3-yichen.wang@bytedance.com>
In-Reply-To: <20240715221245.12435-3-yichen.wang@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|BL3PR11MB6483:EE_
x-ms-office365-filtering-correlation-id: 230fafc6-d2e5-42cb-3f81-08dca543e596
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Ra7m5ecxBQwLI9ZIEfBDZ/j1U6nxs4oypZa3wMT8ILvlWY17Z6BVlRIFpN?=
 =?iso-8859-1?Q?9mLssmIN8ryP6BgHQ/dHZpM3k7DkfBa3XYcz2+ZUR45/sAJUWVPY39izz9?=
 =?iso-8859-1?Q?1S5BjW6ETTm7OyHVITcv1v7QcFkmtp1T498QXard310S/ernOLDwfPJXyM?=
 =?iso-8859-1?Q?sPoOrrvZ8E8NTJW4z3+tPB+QOyGtyA4HBoHbErtRc0iDJOwyhjD+9bL02M?=
 =?iso-8859-1?Q?npQFbHPE685tR5WUwoEGLAB7GuNFvSjulX/ADt45iSRZ+ExR3kLmTkRA7E?=
 =?iso-8859-1?Q?FPDSlHywMZ0bcq7sW6Nt2Du4DqykrBkvzC+GUI0KzRSOJFgDn8dToADfu0?=
 =?iso-8859-1?Q?5zcuDdDb2aYFbONo9bJM2AWgxhUOfzIeM8aWJDth6EEbaEeVCVfZDqa36Y?=
 =?iso-8859-1?Q?ogGQaufMWUvo0/zsDtvROJoL6E0/BG3xvzqlH6G56pjLJdMS9/fQrMmZoQ?=
 =?iso-8859-1?Q?HCFOcKXXkaMXVzRMS1ta9k4egQnvJ5/AkfOnmbJntN8j0sBXyvY83dK58O?=
 =?iso-8859-1?Q?evYA9NHm3VQFT0tQMOWiLFVHk+4BLrhBsI57jI+iHwTYw5XEGVkKTA2Tqu?=
 =?iso-8859-1?Q?cHNmOJOIz4khpJqp+GY7L6ih+S6WbXdYdzpvRqT2cS+K6Y5+N9JTbEiH+M?=
 =?iso-8859-1?Q?SZwPT4EkIW/IdiNMyfaZuehJBKeQ5rL9sYNU3+j8a4vJghF0SgrQJU1j51?=
 =?iso-8859-1?Q?P5hEuYtUeCafINr2NF5zLZPRw3qC9jctQ989olqX4ivYEYTc2TR0sQ2Fwa?=
 =?iso-8859-1?Q?iCFAi+C6+cu92y6NVXtAF+WQM995yqvx6Z1wWEkHCxpVoVW6aDd8K/pAce?=
 =?iso-8859-1?Q?gbSVgjf11McziMIDecMnJ2JOm+yMmDhUMCpWUSDkUr3FO09yLkvJO7pJ6k?=
 =?iso-8859-1?Q?RlHo2Em5M6NnkKdKGkLoNh4tnAvUcr3xPLagi2/ffVdQI/voRt5VauriBJ?=
 =?iso-8859-1?Q?Hn2pbc3Lv/GkhLC7pTFZhG6hZxiFCEObrXb3IUgcNwXn3ZilYrvJPSNKDa?=
 =?iso-8859-1?Q?mMVzkXYcr3rGy9pL/zWzjVpO2oFhBACulYoQUYu5zKBHTO6KkOxVbon8Hd?=
 =?iso-8859-1?Q?JxC2vM7T3MSw5MlSC3m5spOV9YhbQfWmgAnoUUW3ODPXr8L93slkEfmlDV?=
 =?iso-8859-1?Q?LysS7JlyJCnAiEh10ul0WdgngO0HBnsNBxUBaED68aG6zxVoH7x53LAZSr?=
 =?iso-8859-1?Q?IWFOGg0DkdJgwOM+3EoyDxiFiCWOFhsff/Vwuvm7Fss1wbzmw/TaxKVVyr?=
 =?iso-8859-1?Q?/v6t4SJkWJSZdkWUggLSK63h+mia8SB2sMfBfw+6MoNSjcNs/cTJ7S7iMw?=
 =?iso-8859-1?Q?TarwpgcxvUuxE1qpgK8FFWZ9mzKSWT+HWbukUVmtDgeG9+nisONqlET3Ri?=
 =?iso-8859-1?Q?aEE6tsrZbHA54nZYSi4v87t5AoP/xiuPbZnrYk5ilRt0e3ABNh0qik29Sx?=
 =?iso-8859-1?Q?YN1IwqtRXMtv5MIIe/AamlkCByfF9z9ZDYaZCrYr3ILt8nl9gzkQBGejKg?=
 =?iso-8859-1?Q?k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SI2QTgaQI2EUjmvbzT+xwlPkc2ujN8VC85kucqUrlJwIH5FvhJq1iI1ZM1?=
 =?iso-8859-1?Q?C5VPN2ZdKE2pINOgRMYbg6vSMXfoIVwiNlYZ//Cp/Y5FlEO4QgNB0u1+k9?=
 =?iso-8859-1?Q?0asPBOpLyjJlqwL6iZZ3QHCGUDkQl19NvDBuVOVP7X53ogbQiwQ8D//I4w?=
 =?iso-8859-1?Q?w/O5e+Or56YExmPTib7y5l9NEesuq2plNUNGHaVK7gBAMEDh3oIeK/EdCg?=
 =?iso-8859-1?Q?6c+mJly73BUElnsvHC8psTHq7m82c647eUz7lkUwcjPs0KaTZ1p6WYTIUM?=
 =?iso-8859-1?Q?TiytOFump3lJl61Pv1LC9gOKFBPey7eD/9jBMZXCcQcqip0ocAn9gnfbo5?=
 =?iso-8859-1?Q?xsyd80b8dmU0xfIyevx+aJ6l0fINtfCrVDVkWQEcZ49SPUMSIF14QfEikt?=
 =?iso-8859-1?Q?Uw/sZ40STCVZVlrVLFM8JpfkRr13lJY1gPUDNRMjLixQE9kPd8G5wB7gaW?=
 =?iso-8859-1?Q?79KgHl1oY8QSDqU0dCFU+W4t24B5tW4Eo5pBtTIbnhKWaa+JY+YwBA9TJF?=
 =?iso-8859-1?Q?1wC16uyNIR7kIANGnRg7meOoYSK7bdR1MewfxaMwyjiEB7zpc4XzJaxkt5?=
 =?iso-8859-1?Q?TQAJCTeejYBlwd1p3sNXfOy86zqk4lYJ1KALBId8h53qTIZtXzr0uD47Ka?=
 =?iso-8859-1?Q?eB2QLbJq/cDqa5pDJX17JRvPrLoZafknsk7LYkkq1bMkA3xWag6bgnHI0o?=
 =?iso-8859-1?Q?4tsoWGQpYdcTNpncP7BS8ovsFFzQFQvsEsjl3RqVHB6wyn6jlfD2bHzwtD?=
 =?iso-8859-1?Q?FJ18YniAeoc1o0L37nkMd1Y6a3hH+Q+DQuKEX73p4trY9JNcjkWAPrw6JB?=
 =?iso-8859-1?Q?qOGFa7x/50BKsBcLf5rafyFKh+IbaD3+OJEbtjYp5urJb2gkX8KfRw1JVA?=
 =?iso-8859-1?Q?TqFeEMXn37+ERBJAh1R4o0wdSZ8137RAbT3WmqI/QnC11AzSWgV1gxzH7w?=
 =?iso-8859-1?Q?Ng8b0iHzAH0HfJ60MDZqmikRvfJAUnbIJN8hA5GW6BuNab01O0pnCaDbeT?=
 =?iso-8859-1?Q?W132Vmi9CdqP1Ik78ViHf2CPDwAoNpUenY8XocWcxVT8y/DRICcwiKyeq0?=
 =?iso-8859-1?Q?0qJVBH76LeqNEwVGIopuC7t7KdIm2wmfFHt2LRFS724yARC/7TtpXbls23?=
 =?iso-8859-1?Q?3nfCcWvBOnszDtHtauxGCDFwppcv4CAkpckUq2/RtUow05x+6eKBmrNh1w?=
 =?iso-8859-1?Q?VRqJQ4w3JPKQDXf1ud5hwTxklgyjJvw4zDZUTalfgbj3jR+n8fnKntZ6mn?=
 =?iso-8859-1?Q?n5ygWGuAbjd0187EklIcRnRIQ1R76R25ktyaC1WgQyXecybZaolIrCjeTP?=
 =?iso-8859-1?Q?oJ6TT5sHLIxgDrhTfJyT03TjRRL0n6TRul1IPoHgrwTH4CU5kr61o5JWrw?=
 =?iso-8859-1?Q?CORe6mrjdksmcqAQT3DnPHOQo5eWXBBDFwFA3LpdHWD+ps3BwIbB46/shm?=
 =?iso-8859-1?Q?w4ecr3eOgm80sIT9P2whzu00Mo215vpikDrRY/PiXd0iNu+1SXAxS3/+HZ?=
 =?iso-8859-1?Q?IUatBsMD5zAIP/NDRrz/gamd2vqxVVVhHsDsuHLG/QhFxjt6EA7UtiWlcc?=
 =?iso-8859-1?Q?GbTsx8/R/mGE1Qw873jZnzaZSr0IRVe9qW7pTC1w9XcTvM8NSdppAqk5qj?=
 =?iso-8859-1?Q?0pL4GYuIKbqWmq+gzJks5yvTqTZ7e3bSIT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230fafc6-d2e5-42cb-3f81-08dca543e596
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 03:03:41.2699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nW0zXJ4yq9edd92ekbZioWRBnDDRfysGmGGF4mrogpBFjudFssj5QV/lF5s0wBzWNJ8/DRsUt2KRcNIXTkzebg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6483
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> -----Original Message-----
> From: Yichen Wang <yichen.wang@bytedance.com>
> Sent: Tuesday, July 16, 2024 6:13 AM
> To: Peter Xu <peterx@redhat.com>; Fabiano Rosas <farosas@suse.de>; Paolo
> Bonzini <pbonzini@redhat.com>; Daniel P. Berrang=E9 <berrange@redhat.com>=
;
> Eduardo Habkost <eduardo@habkost.net>; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>; Thomas Huth <thuth@redhat.com>; Philippe
> Mathieu-Daud=E9 <philmd@linaro.org>; Eric Blake <eblake@redhat.com>; Mark=
us
> Armbruster <armbru@redhat.com>; Laurent Vivier <lvivier@redhat.com>; qemu=
-
> devel@nongnu.org
> Cc: Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1 <yuan1.liu@intel.com>;
> Zou, Nanhai <nanhai.zou@intel.com>; Ho-Ren (Jack) Chuang
> <horenchuang@bytedance.com>; Wang, Yichen <yichen.wang@bytedance.com>;
> Bryan Zhang <bryan.zhang@bytedance.com>
> Subject: [PATCH v6 2/5] meson: Introduce 'qatzip' feature to the build
> system
>=20
> From: Bryan Zhang <bryan.zhang@bytedance.com>
>=20
> Add a 'qatzip' feature, which is automatically disabled, and which
> depends on the QATzip library if enabled.
>=20
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  meson.build                   | 10 ++++++++++
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  3 +++
>  3 files changed, 15 insertions(+)
>=20
> diff --git a/meson.build b/meson.build
> index 6a93da48e1..ea977c6cbf 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1244,6 +1244,14 @@ if not get_option('uadk').auto() or have_system
>       uadk =3D declare_dependency(dependencies: [libwd, libwd_comp])
>    endif
>  endif
> +
> +qatzip =3D not_found
> +if get_option('qatzip').enabled()
> +  qatzip =3D dependency('qatzip', version: '>=3D1.1.2',
> +                      required: get_option('qatzip'),
> +                      method: 'pkg-config')
> +endif
> +

How about changing to the following code=20
if not get_option('qatzip').auto() or have_system
  qatzip =3D dependency('qatzip', version: '>=3D1.1.2',
                      required: get_option('qatzip'),
                      method: 'pkg-config')
endif

This means that on all Qemu emulation targets, always use=20
--enable-qatzip and --disable-qatzip to determine whether
qatzip is required.

I think your previous code can remove if get_option('qatzip').enabled()
And it also can work

>  virgl =3D not_found
>=20
>  have_vhost_user_gpu =3D have_tools and host_os =3D=3D 'linux' and
> pixman.found()
> @@ -2378,6 +2386,7 @@ config_host_data.set('CONFIG_STATX_MNT_ID',
> has_statx_mnt_id)
>  config_host_data.set('CONFIG_ZSTD', zstd.found())
>  config_host_data.set('CONFIG_QPL', qpl.found())
>  config_host_data.set('CONFIG_UADK', uadk.found())
> +config_host_data.set('CONFIG_QATZIP', qatzip.found())
>  config_host_data.set('CONFIG_FUSE', fuse.found())
>  config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
>  config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
> @@ -4484,6 +4493,7 @@ summary_info +=3D {'lzfse support':     liblzfse}
>  summary_info +=3D {'zstd support':      zstd}
>  summary_info +=3D {'Query Processing Library support': qpl}
>  summary_info +=3D {'UADK Library support': uadk}
> +summary_info +=3D {'qatzip support':    qatzip}
>  summary_info +=3D {'NUMA host support': numa}
>  summary_info +=3D {'capstone':          capstone}
>  summary_info +=3D {'libpmem support':   libpmem}
> diff --git a/meson_options.txt b/meson_options.txt
> index 0269fa0f16..35a69f6697 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -261,6 +261,8 @@ option('qpl', type : 'feature', value : 'auto',
>         description: 'Query Processing Library support')
>  option('uadk', type : 'feature', value : 'auto',
>         description: 'UADK Library support')
> +option('qatzip', type: 'feature', value: 'disabled',

If you agree with the above changes, set the qatzip value to auto
option('qatzip', type: 'feature', value: 'auto'

> +       description: 'QATzip compression support')
>  option('fuse', type: 'feature', value: 'auto',
>         description: 'FUSE block device export')
>  option('fuse_lseek', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index cfadb5ea86..1ce467e9cc 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -163,6 +163,7 @@ meson_options_help() {
>    printf "%s\n" '  pixman          pixman support'
>    printf "%s\n" '  plugins         TCG plugins via shared library
> loading'
>    printf "%s\n" '  png             PNG support with libpng'
> +  printf "%s\n" '  qatzip          QATzip compression support'
>    printf "%s\n" '  qcow1           qcow1 image format support'
>    printf "%s\n" '  qed             qed image format support'
>    printf "%s\n" '  qga-vss         build QGA VSS support (broken with
> MinGW)'
> @@ -427,6 +428,8 @@ _meson_option_parse() {
>      --enable-png) printf "%s" -Dpng=3Denabled ;;
>      --disable-png) printf "%s" -Dpng=3Ddisabled ;;
>      --prefix=3D*) quote_sh "-Dprefix=3D$2" ;;
> +    --enable-qatzip) printf "%s" -Dqatzip=3Denabled ;;
> +    --disable-qatzip) printf "%s" -Dqatzip=3Ddisabled ;;
>      --enable-qcow1) printf "%s" -Dqcow1=3Denabled ;;
>      --disable-qcow1) printf "%s" -Dqcow1=3Ddisabled ;;
>      --enable-qed) printf "%s" -Dqed=3Denabled ;;
> --
> Yichen Wang


