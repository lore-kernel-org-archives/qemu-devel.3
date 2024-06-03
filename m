Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C72BC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jq-0006qg-Cn; Mon, 03 Jun 2024 02:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jh-0006kN-UY
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:03 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0je-00070x-OD
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394399; x=1748930399;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=z8u53u+CM2INsVXAc6uqK70A1lJTTUSaPFDUaxCmfhk=;
 b=g9fpAuXoAxWCy1NVp5fCKf2z+y3GsWmx9mg7eSW0QQD1nd6mXm21L72C
 QxxGYMLO62akBsTb8Mr3WH1ObxJtVVpX8gJQ1x7hNpm2fuT9xU5iPlt/N
 2kb/P90aakL+SgUySWPwyZSrlXmFFFsDAPyQQ+aWe2jcIVH2/go6ZdUTM
 sdLmZsZvqB7D1jQTp3hAhQvV39R/HawZ8In5O/dW/GVAjGYSzW6RxiCka
 vewnM8p0LGPAdOGyl+0IAqY+hEcMmu2/tbd/qiUGzUL+rzg/83QF0iFIl
 yollvV4LDvpEjRVAfT4Av2Ph3GtSE/KeW05unRj7QwJhoMkL4kFdNYsy1 g==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815878"
X-MGA-submission: =?us-ascii?q?MDHwQ4j8y9Ip9XSWWpuGa0SkPI1EdSKoxqsbLI?=
 =?us-ascii?q?2eUzJ38Uw+V6k2EfE5DYgS5oQOA2boD4dHhUHMSc2Z5lJuzP7ibA+PU7?=
 =?us-ascii?q?HF5Pe5MgojuH0EKzb0NOYTjQuktgKru8+ZqTbf2eAhsvdhctqBdOO/89?=
 =?us-ascii?q?kRlQ77HA6oHrKQl9R2PkK8jA=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVz1ZUJsVDTgJb+QflYCPvtVEIslS52AJ/YwESMKac8lK2W2PSe0ygkU1yKDCF0J6N/Nggv60v3Bi6nVFudSGbWGguboHQsCibdHGfqwLzoaNYwNNpMzsjDiYgqCrLTwatjM/AkQTraM6jEyJLIRfjL4jgBl1vEYinNs5w8U9B7X85CAq2ExZkt+z7FXF5kRkcZ4Enf/1gzd99zFcvM7zPhAvr1lGahhpltVgVcYQ4TMbTxWOKHMwGghd1prOknrvUlbzwZmPsV7BAnXKLNfyzY8gJ1DhOOnjEqngVBHoYNJbN9hp0N0KEtNmrIAhcEZ8/t1elpIyVm6XgdVB3PNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8u53u+CM2INsVXAc6uqK70A1lJTTUSaPFDUaxCmfhk=;
 b=UkoRDhx3bYCk6Bsds7HUsaIkbTFv3FLDrGuO5Yt1kdI8Ee+V0sOm74ptTMld1w++QBoMzkkRdI/FOnA0jYTQ5WadkHoye3l08gEm+BX3zvp67SiKW5XYn6vZkpKoZvxFbdImUZrKcCFsOQkal1VhJXPzUE23Ih4dquWRJS5Z63cfVkDMIP6foy4dWnr9SbhZVvQIpAt3KF/nwPkHwgmH8n+3NWyFpYAIV6Wp/NvR1yizJMagquRWhe5g6SyAxjh1G6i1szgBoGx5w52JwYOzxL5lIq4KoszZvKijiGYh9EUM6sPEbPJoxsS9tV4iBeIxFAzTcFKReLfI+yrmv95WqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8u53u+CM2INsVXAc6uqK70A1lJTTUSaPFDUaxCmfhk=;
 b=Khu4QM2bAp/tJNcIXJJYQrGrJ8677kXM4nsgvJSUGruJFnEeK/vRjiciiBQZxU8VOksCwY0XJOJ/rF11yxYDKDOQah6SsUKeGuon56IVYRBFevGU7DlKC2YWSEJ8/5MoCcC59IkJZ0IfYWoD7f6/ylOu3mljvdqAUWt5I5aQAU16L2yJ8U5uETiZH2noxj1HcL+6Vo1n8/r7DFTflTmi/1oOwN9VPx9duxbMxDnxgWTO5cNFRb9A2w/ZopCA0ARWDZjldTrog+HEOzv8nrNv3Wg2PRtNaVC1CBKg2SIL8XFMvx7JopT+jQZ3/UHDiMZrZPJRtNsjOcCwWatxa87OQA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:45 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:45 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 07/22] pcie: helper functions to check if PASID and
 ATS are enabled
Thread-Topic: [PATCH ats_vtd v5 07/22] pcie: helper functions to check if
 PASID and ATS are enabled
Thread-Index: AQHatXs7XMyQi9yUpEaND2cFURryiw==
Date: Mon, 3 Jun 2024 05:59:45 +0000
Message-ID: <20240603055917.18735-8-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: 1dbe1e5c-04bd-4ad1-7b8b-08dc83925e75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NDRhY3o1NVFEdFZha0JGeUVEZG01NkxkSmRQME8zMjRuTmF1dE9Cb2NHcjBi?=
 =?utf-8?B?a1VYR2NEQ3RWbHNEZncyWDRzZlVhT3BGbW45YmpqODdrT1VYRE1KZFQwRUNn?=
 =?utf-8?B?T1ArdlBCTGhPRFY3VzJRZDBURDNsdmNsV0hEamRMVGRZL0dva29XclBOTnpj?=
 =?utf-8?B?eHNoK2RpTzM4bWVEVGVrTlF3TWowVlo0ZDlteVE3VkRkK2d2eEpYYThtMjgv?=
 =?utf-8?B?dGdKQkoxcGFZNHRuRDJ4ME13UXV1Vnpac1ducEVTcXJ0OWtRblduMTFRcm1q?=
 =?utf-8?B?Y0xRYTZES1RwK3AyRXRubXRRYVBaNUxJM0NXdXN4VVA4Ym9waThKZWZ0anBa?=
 =?utf-8?B?QmVQRU5MOGZuNjdpLzFUcWRlYjRFZklIRlZiNzZROHZoQ09oSDJ2OHJXTDk2?=
 =?utf-8?B?MzJKMHcyNWtoTEUrREZNTzVyMERzMmc2ZnJKcnl3ZXg0RTdVNzJiMUJyeGIy?=
 =?utf-8?B?ZFNQNUhqbEM4Wm9GNE1EWDh1NktuSTdzMElydlp0T1pRYzJrTnBCNGdTUHQ4?=
 =?utf-8?B?SmdUWXpIeHozMkt5ZVQwZm5tK3NQdytCMUg0TTVnaWk5M3RYNmlDSXY0M3NM?=
 =?utf-8?B?VXVTVHd0cG9LYWdlSkFlcnJzVXB4OHB0RGFwN1VaUm1aY1orNEVCWHhSVGRj?=
 =?utf-8?B?Rk8rQmJMemxBY2dicVNKTmsxYXc1d1N1N0VRMmRRZ251M0JHbmluR0NzcWw1?=
 =?utf-8?B?S0VsT1JtNDJwNXk2bGc5ck02MzdSSVYvYllsdklIcWpORUNEWXNCVWFSS1Ry?=
 =?utf-8?B?aTVBZElERWwxU2JBS2d0OVpIV1lqN3EzbU5zdkN5RWVIS1NKZzFzNndBTG0z?=
 =?utf-8?B?QVY4di9tNWhCMDh4a3hnSnR5YmhvMHdXczQ5WUpIMHBYVlBydEJzM1F5UmJD?=
 =?utf-8?B?Uzk3ekp1THUyNk5pWWJuUWZGUkhKVzR5UmczYkNjdGFpQUJKZVU5ajhTYXV4?=
 =?utf-8?B?T0prUWNBRWtlMHU0TitsZ0pQQWU1QmdCTm9JZWE3bDU5YmRIdmJQNGtTRHFq?=
 =?utf-8?B?OTBFNk5NMi9UUEVnZ01hWDhvZ3dpbFM2VmxQV2dBK1hsQXJxQzVrSXByQ2Nr?=
 =?utf-8?B?bnFUMnVKVTJlWlRKdi96WnBEZUdqTlZhdzZsdWRKbnQ2UVJWQW9MTVA3MDJL?=
 =?utf-8?B?SU5waTJTTjJWSy9OZzRYSWhybU8vd3RkTWRib1Fxek5Ub0hQeHlwK1hpM3FU?=
 =?utf-8?B?OGwxYk03UjVVSDhVcjdZc3JjZVV1WUN0cnhXWlJ5TFE5aXdSdVRrTTFRWGlY?=
 =?utf-8?B?MUgyYWNvUWVjYm1MZ2lWVlEzU1djclROMnpudEhXbm1xYmtxa2FkdS9FNHps?=
 =?utf-8?B?MjlhME5pelM1OEMweHM1NGpBQ2ZLUVozM2cwRmxwaG1nb2hMM0Y3RnIvNzMx?=
 =?utf-8?B?N3psYlMrMU13NHJicWl6dkJPMjlqa0sxdVY4dG1GaER4WmdzUlBGSitMQ2Vo?=
 =?utf-8?B?YUVORWZSaUk2aDNIS0JZTCtqRDZaamo3WHk4TGliR3hFME0xdEJwKys2VVY3?=
 =?utf-8?B?NzllV3dBUEs0RWg4YU9hK1JRMlVjTXBzUlJxWmdlWEhEY1gwbXBXd0Q4eTly?=
 =?utf-8?B?enFzRTE2bktUK0VMOVNXb0NOVEVBaHJ1SzNySnduWk1VaFg5c1BvZ1dmdEI2?=
 =?utf-8?B?cCtGUzQ0VFdJMW1OYUg4Q0o1SjlGQWtWR1pJRHVjZ0kwN2k0STd2UktyazYx?=
 =?utf-8?B?OW1qcEhsN0hudGRMWGFKNENvZmc5aW9UaVI3eVFUb01ycmY1TEUzdnhGUGRl?=
 =?utf-8?B?RDgxL3F5Uy9JV3pFSEJUSXhIRDFHd0Z6WlZ1QmVpRlVVdEFWaWpyYjVHMTli?=
 =?utf-8?B?dzhibkdzMVVGS3RuaFRuZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0FtbGluVnRTdjBpODFOVXRMWTlLN3pkMTlPRVVpbytSaEtEeW5CSVl4UXNX?=
 =?utf-8?B?NUR6TEJFRDVOVVFicTB5aFhsbmxCaXJuc0I5REduRGhJa3dHNDgzcnFESW56?=
 =?utf-8?B?aWVjTjVpbU1Fa2xOV29HTjJyNGtOQVFLb29kNjhLQmlPdy91K1JTODMvK1Bt?=
 =?utf-8?B?VW5QcWwySmxpcnVNU3IzSFRBYzBGaXlyZVB5Um53bG9TRnJ2V2VBTTBmUk91?=
 =?utf-8?B?d002a0ZIZ0NjRUViem1ES0s4N3phcFB5NFFXNkpQYk5DNXBTM3ByazcvN04x?=
 =?utf-8?B?ZmFOOFhSWTJhMDF5YnIrd0x1SFMxTnluUjduckxoeGEra3RYOWdhUzZDMGJn?=
 =?utf-8?B?MmdnTTBoZ05WNmlkZWFuSmpSamlHdWNNQWROYksyUDQrT282Uzk5UEpVSmFx?=
 =?utf-8?B?RllFNWJYODZta0NGbXJOTkxnNnlldFd3bHFiTWhVWXhSSzJJTjBNSndTRVA3?=
 =?utf-8?B?ZC9RclVuZ2dqZzJrRUJKd2lmQ2VTTFozMy80dE4wZFVyQ0dnKzBWQWlZUlNh?=
 =?utf-8?B?NzZJREsxZ2RoUEhKL1RUUFhuWWZ0LzQ0djBpMXVsbDFYNnBwQ2JIeTkxTVQ4?=
 =?utf-8?B?eVBWaVlyQVFOcUE4amt2NVhQd3NSb2VHVjRPYk9EQ2FKQ1lPUURDTC95Uk1G?=
 =?utf-8?B?SnY2ZEN2WWMvY21sNkhBTDJ6NUhMNXAwK1JHWUkvaVBZZktia0s4aEg0VmU4?=
 =?utf-8?B?WXQvMzZ5dS85em1WeHZRSjVqSDRPeHlkQ1JTcjVnenRFZWZLQlg1VDN3V2J5?=
 =?utf-8?B?ajhxS2dhSE5URzltMVlvbnBabEkvaldQaENxdittMUtzLy9tbHF6SVMwdnJ3?=
 =?utf-8?B?UTNrbitxZnFBOGtTR2Rrd3pvWlFsazQ0eE9DbnMrdmh0R0VJc2JmL0U1QWtr?=
 =?utf-8?B?WWFiVEpmRUJkME9HRGs5aFhsVi94RmxJb2I4N0kwMXpJdWMzY2pyZU1uTm1r?=
 =?utf-8?B?OHpGekRRWktuV29tR0xxNENXYVUzMi8yb1A0a3NPa0V0VjhkTDdodjZERjNn?=
 =?utf-8?B?OHdTVHNSRjBucjFFQi9YK2ZybTNveWZhaklyR3l6SUFBcjNCdU56ZnptMjZQ?=
 =?utf-8?B?aW9Cc3UrS2d2MkRLVkV0RVF0UnNwUGtjTlR3R3F4bFpDZTRlaUpaeG1yaHd5?=
 =?utf-8?B?ZHNiQjZJQjlyaGtUM0lFRmt2dWxORkY5SHBjcy9peTBoRXdBa1J6WlIxenZu?=
 =?utf-8?B?TkgvS2d2bU5hNTdydTFWNm4vYmY2T3ZzT1o4ck5SM2ZBUThpZ1hUTVFwNVVz?=
 =?utf-8?B?RzkrQzFIWUQ0aHkzN3h3T0o5OXN4YUd5Q2tjVmlPTTJOQk5JUm1Zc005eUd3?=
 =?utf-8?B?dG5vSVNkL2ZqTlluZkpLYXdudkxWYzhYanFiUEdnM3B4ZEZxdm5vc0dNS3d1?=
 =?utf-8?B?cE1lamh6T2FwZUlCNmZiVjV0NHE0OEdtM2ZYUU96ak9xNHZhZWE0Z1lzZm14?=
 =?utf-8?B?SGJENWxvRE11T0lTR3luMVRJSldwallDaVNIdVU0TVdXeUNJMXB5cnFuRFFy?=
 =?utf-8?B?QTRjR1NhSEtBb284NHBrcUxnNHQ4K1dZMTA4WndobGI4MENQMWNvelBXU1FZ?=
 =?utf-8?B?dXFjWE1BN3dZT1p6N2J5ZVVCWEpta1AySitjTnU2ZjFxQ2Jtc1ByaG16YzZo?=
 =?utf-8?B?THRNS25ySlhkL20vWkFrUUtxcW1VOWN2Nm5rdm13N3kwWFF5c0w1UjhRd2tH?=
 =?utf-8?B?QjVPblNMWTloNks1c3JKcVZFQS83akpOWjJxc0J6Sk1BZmJLSlRmOStLZzZQ?=
 =?utf-8?B?Wno2aXVpSGpxMWJ6dFpnZmgrdldVRWY2NWt3b1p0V0VDdTBFTFpWOW90YUY4?=
 =?utf-8?B?ZnA3QmtRNGk2djc2b2I5YWY4U1RCRlNuYVgrdittRGNISXNHaGhCam5PMGhm?=
 =?utf-8?B?VDFIaTR0QTJYbEJick0rSkIwTVhpTCtTWmJWZmY4dXhaRlNjR0JHUW1CREpn?=
 =?utf-8?B?THViL2crSDdFWGpGQzlJMEpra0swSURYRFZTcjJHVnp1VldYVXZaeEFSd0ds?=
 =?utf-8?B?K0hpUFJDMXdKVWk2OFFUamZtWGpBNUxybnlxRk1VS2xOR2l2aW1jQnlFWTVR?=
 =?utf-8?B?VFJ3NDl2WFFJZzhDQzNoejZScWhiUllLelhFZ1hoc1JEVkExeG5zZk1lZ3Q3?=
 =?utf-8?B?OVRaQjNWSzExZ1htek9qZmVCN2NVMGUrSzZFYmhNdVNWZ1VkdE4wT1hxOS9L?=
 =?utf-8?Q?7hUxJ7oR91HGmqdK9XTZyJ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0206B37C22524C4BBD30D199EB16BFB3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbe1e5c-04bd-4ad1-7b8b-08dc83925e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:45.2601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8VlLlXh6xznQ//jOvLLW1NwqJzkzYoiCgvYrmQzVJ9WHBtFT/W20zjJmxAdPjvhnEqrFVdnyObhDi/dPi58ccPUO4Xywe9ID+5mF+Jm5w3rb5HSBcqChoggRcYC11lVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCmF0c19lbmFibGVkIGFuZCBwYXNpZF9lbmFibGVkIGNoZWNrIHdoZXRoZXIgdGhl
IGNhcGFiaWxpdGllcyBhcmUNCnByZXNlbnQgb3Igbm90LiBJZiBzbywgd2UgcmVhZCB0aGUgY29u
ZmlndXJhdGlvbiBzcGFjZSB0byBnZXQNCnRoZSBzdGF0dXMgb2YgdGhlIGZlYXR1cmUgKGVuYWJs
ZWQgb3Igbm90KS4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpZS5jICAgICAg
ICAgfCAxOCArKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2h3L3BjaS9wY2llLmggfCAgMyAr
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3
L3BjaS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQppbmRleCBkNmEwNTJiNjE2Li40ZWZkODRmZWQ1
IDEwMDY0NA0KLS0tIGEvaHcvcGNpL3BjaWUuYw0KKysrIGIvaHcvcGNpL3BjaWUuYw0KQEAgLTEy
MDEsMyArMTIwMSwyMSBAQCB2b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lEZXZpY2UgKmRldiwgdWlu
dDE2X3Qgb2Zmc2V0LCB1aW50OF90IHBhc2lkX3dpZHRoLA0KIA0KICAgICBkZXYtPmV4cC5wYXNp
ZF9jYXAgPSBvZmZzZXQ7DQogfQ0KKw0KK2Jvb2wgcGNpZV9wYXNpZF9lbmFibGVkKGNvbnN0IFBD
SURldmljZSAqZGV2KQ0KK3sNCisgICAgaWYgKCFwY2lfaXNfZXhwcmVzcyhkZXYpIHx8ICFkZXYt
PmV4cC5wYXNpZF9jYXApIHsNCisgICAgICAgIHJldHVybiBmYWxzZTsNCisgICAgfQ0KKyAgICBy
ZXR1cm4gKHBjaV9nZXRfd29yZChkZXYtPmNvbmZpZyArIGRldi0+ZXhwLnBhc2lkX2NhcCArIFBD
SV9QQVNJRF9DVFJMKSAmDQorICAgICAgICAgICAgICAgIFBDSV9QQVNJRF9DVFJMX0VOQUJMRSkg
IT0gMDsNCit9DQorDQorYm9vbCBwY2llX2F0c19lbmFibGVkKGNvbnN0IFBDSURldmljZSAqZGV2
KQ0KK3sNCisgICAgaWYgKCFwY2lfaXNfZXhwcmVzcyhkZXYpIHx8ICFkZXYtPmV4cC5hdHNfY2Fw
KSB7DQorICAgICAgICByZXR1cm4gZmFsc2U7DQorICAgIH0NCisgICAgcmV0dXJuIChwY2lfZ2V0
X3dvcmQoZGV2LT5jb25maWcgKyBkZXYtPmV4cC5hdHNfY2FwICsgUENJX0FUU19DVFJMKSAmDQor
ICAgICAgICAgICAgICAgIFBDSV9BVFNfQ1RSTF9FTkFCTEUpICE9IDA7DQorfQ0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvaHcvcGNpL3BjaWUuaCBiL2luY2x1ZGUvaHcvcGNpL3BjaWUuaA0KaW5kZXgg
Yjg3MDk1OGM5OS4uMGMxMjdiMjlkYyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaWUu
aA0KKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQpAQCAtMTU0LDQgKzE1NCw3IEBAIHZvaWQg
cGNpZV9jYXBfc2xvdF91bnBsdWdfcmVxdWVzdF9jYihIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19k
ZXYsDQogDQogdm9pZCBwY2llX3Bhc2lkX2luaXQoUENJRGV2aWNlICpkZXYsIHVpbnQxNl90IG9m
ZnNldCwgdWludDhfdCBwYXNpZF93aWR0aCwNCiAgICAgICAgICAgICAgICAgICAgICBib29sIGV4
ZWNfcGVybSwgYm9vbCBwcml2X21vZCk7DQorDQorYm9vbCBwY2llX3Bhc2lkX2VuYWJsZWQoY29u
c3QgUENJRGV2aWNlICpkZXYpOw0KK2Jvb2wgcGNpZV9hdHNfZW5hYmxlZChjb25zdCBQQ0lEZXZp
Y2UgKmRldik7DQogI2VuZGlmIC8qIFFFTVVfUENJRV9IICovDQotLSANCjIuNDUuMQ0K

