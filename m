Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9347CC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 16:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWIDx-0000Hb-IQ; Tue, 23 Jul 2024 12:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWIDv-0000GL-Ki
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:18:47 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWIDs-00064n-9f
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721751524; x=1753287524;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PYakQlbuxLs+Gid7gePlwfRZYhdvN3PW3MGP4dKH2nA=;
 b=tD4YjYwh8ryidAMO1i5tdC8tDo7jo4PX94gQTAQoxOrR5is7Mubj7fkV
 yarAV+Le7WwiR4uAdL6pTOzAhnD04KzrOWqmFdLKpivxRcJsY5xJqBoKr
 VTysD2WOCGyZ7dmZ+YA00J+95gciyptW+Mx16Hrh1abHSxBWi4WCn2Bx/
 0jHq/A8zNRyqGNeOAkTnWpn5dGWfHxgSDdKfUHOPQNP8UNWok2OxKaCWN
 ybyo5CnNJ/rKekrnYYDoxYJLcMvsRtZ8X+HRb4OIj5+MngJq3WgIK5ot5
 oDLBCQKHnjfF3TnxlbS3asg+qWt0PpL7p01jEFigCIx+mH6q90fw0pt8p Q==;
X-IronPort-AV: E=Sophos;i="6.09,230,1716242400"; d="scan'208";a="17197583"
X-MGA-submission: =?us-ascii?q?MDEyIGnEUemIarLet13PfGhcttabFlSKZTMJef?=
 =?us-ascii?q?GPLhUwZ01AnXoRL5Xg42QW5t61MOS/E2PT/wthytnMjcgPRm4kk6SDXB?=
 =?us-ascii?q?QFHmseGu5B9bwdhCdvOtj2Czmtit8pxzPtLYXTyvExCtTobuY9YOh0DM?=
 =?us-ascii?q?ifEprPyAg1BoGek/kvfIHDXA=3D=3D?=
Received: from mail-am0eur02lp2236.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.236])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 18:18:40 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9rRgQTAmcal+eAabD1D4Gtd4v/Extlt/iPSTwbuXN4utDFBvBBQX8dgxKrxAlrSVc0mv6eWL8ftWq0c9RM1jStPzsQqwepyRacHtcPV+fYD4lOGQ4fqfrCFjJa+ZfURYRMNpNm3Xs84TBHaH7+iCoXO+4rbr8KfVQx8rL2kAUZ7pzSNvlvk6HFktsvXJcYo/MYzw6l+oyT/KcWd5DfN5H11Urvwt2K0OyEI9GdjbkLTUAjMpvw2Ln9VM8Fh+gErQnSwHLanb4TG7zy+IPpBqU+Vzply7EBZpNvcZ1dgg8kgWqG7ychuVNlw1mpEDlW1iOTlbzVyHm6/TvhimTRb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYakQlbuxLs+Gid7gePlwfRZYhdvN3PW3MGP4dKH2nA=;
 b=NRvyb1ITLtzuxdLUpysB8vaYGMwiZvEqr+5owzXTIp3qlKny20TcNExntUNNuBVR14I1I1ebDFg1Pi1cwEl9aC50/BfmU73AY7KalnyA0G0gN5uf960RjA6WsRh1boxf2UZOJsGUknfNDKiBXkQbU3YsifzC4Fv7IAmYRYyv0HuZrjdnkeLQ5KZIQon+D+YoksAkFAU3iIy0BadqfXUdEhixlLBHECvUYV8q4woXQaUKjcqFrgft2Qy8wDnDP9Sd80+smoJEmdUKoeDG6GkasLOe+qmH1HyDve7e89XlrvGnVGvJpJGU1IqIlRV3+iBbQuj+OxVlzVKLPHTdoJgUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYakQlbuxLs+Gid7gePlwfRZYhdvN3PW3MGP4dKH2nA=;
 b=fK2vG7rMpA9ex7Ltmj5kv7MvkoZcKslBglh6pQgWcYJfwsq/HZp8gM4fHUwiqoOKtbkKN6TtKnteIC7/k9QEAK9Zq4LI3UQ5+ZJXwLhmADKEIxiBJZAiTTvTKR6en5tDR0sDVhoMmkDNDRRDKYgp/rbomqg30IxrtgK5VXJkylKIDLIf8/PcttVlpYVcoVQmU9/BfXezRr+3f8mfQRhj4kRAwvo2ghm4/fzkFzLv3x2nJsPWLc/q8NOTHc6GIJ0yQ3CMFr35dsYT0Hd0zrmndlJqqyE2S9OxjAIsCk5Q4tajAIdloHnjAqYlKi2KKcDehz/T75DcpDEMs/Pvq+Y3vw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB6633.eurprd07.prod.outlook.com (2603:10a6:102:6c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.9; Tue, 23 Jul
 2024 16:18:38 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 16:18:38 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v1 10/17] intel_iommu: Process PASID-based iotlb
 invalidation
Thread-Topic: [PATCH v1 10/17] intel_iommu: Process PASID-based iotlb
 invalidation
Thread-Index: AQHa2OtM4EUbjUXBEE+8f/4AMTo3rLIEhhIA
Date: Tue, 23 Jul 2024 16:18:38 +0000
Message-ID: <f2e0011f-9025-4dee-9c6a-5525c4adade4@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-11-zhenzhong.duan@intel.com>
In-Reply-To: <20240718081636.879544-11-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB6633:EE_
x-ms-office365-filtering-correlation-id: 0cafe5aa-d6fa-474f-78dd-08dcab331c2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MVlFNjg3VWx4YlhOSTArek1VQWRpajlDZkFsOXJOdE53eGdiMGtsQUp4dkpP?=
 =?utf-8?B?TXpQc1FqVHBSbktsNlFISkh1WFBWQzZ1Q2NJQ05uelhkWDh3dGQzVXRWWDM5?=
 =?utf-8?B?NTN1eE04ZHIyQ3QraUNJaFJjbTl3Ums1WElBNGFXajlkR0JEOFR0eUVtZ0FF?=
 =?utf-8?B?MGpUeWQvLzh0TzJqYmJWUlAyZk1ZTXdZcldETSsrV0xKYVJqUkdsd25wNi9D?=
 =?utf-8?B?VUVhKzAzSEdZdzVjNzBpU2RTb1lERkt1cnYxdzZsaWhMd1R6VFRNVkRNUERp?=
 =?utf-8?B?RHk5SHpWcFNReDlzd0R5SHZGdTVWRWN6cE1xaWY0ZFNwNWFpOUdxUFhEQXY5?=
 =?utf-8?B?LzdQKy9EVE1MUnUybGh3ZFMrUnN4K21wMkZxbzJQRFM5K0JEL3FsL1FmQVZZ?=
 =?utf-8?B?cWVGOWlnaE9TZ3ZGamxBYXN3S2hidmREeGNMYTlDTDBwclluTlNRYTJSWWxj?=
 =?utf-8?B?SnRMd0M3QTllbjZvTlYzMkNOMlFZNFNyb2duOUl5Y0RtY1dxb0xacG1jSEw1?=
 =?utf-8?B?ZVdIVHFDSFFRUk5UVVpJV0ljcjVxU0I3bWdjaEc5bXE1MHBMdlFvRU5PMmpx?=
 =?utf-8?B?VHo4YjBHTFg5bW4zYVQ3SEt6dTdkRUIwTDYxclhtMDJ3SDVqWEloY0l5S3py?=
 =?utf-8?B?aEt3b0dlS3lGODNReEF1WGI2eUJxc0I2QmFYWm9QR2FrbVUrSWtoNUtVNWJy?=
 =?utf-8?B?dm8rSHJSNk5UNkJwaThlVlZGUjArZzIwR29VcWNyS3NRV1NXQzdzdlM4Y25i?=
 =?utf-8?B?eHY5UjIrckZhYWZvcWJ2OEtVMVZTanlhNEFkOHppOUFNTHp0em03MUJVVHZZ?=
 =?utf-8?B?dVFRNklBM2JqZjVXRkNJRzNMUTgzQVdHYkNjQng0TmZIVkVFTTlHVTFUVTlq?=
 =?utf-8?B?QnJOZUVJY1pNakF0QnFlZVJvZTdqamtZS1VNZnRkUGd1ZTAyMElBL0dkTUJM?=
 =?utf-8?B?TmVxYk5PY284SzZsQ0lybS9DVVVIbk1DNmVWTFdLSHhIamRWMEQzVFREVXZM?=
 =?utf-8?B?K0RTNDFhempETjBLdjdqYkVyQWhQM1Nab0tzaHhXbE5pTEp2dnAvcUJMbEx1?=
 =?utf-8?B?cXVNMytDOXpNc2dOWnRQRzY1dEhjV0pnOUU0bmwxS3ZqYUJydzJQOGM4dGRs?=
 =?utf-8?B?VU1NbzFweStiT2hmOG5PZ1FmYktORzlGNUtHQW5CUFhzcnRBSHoxSkJickpK?=
 =?utf-8?B?eVR1L1F2TzdLY1g5ZGlTdVg4UnB5VElMK1dyYWdocWRPakdqczBsTWhvaCto?=
 =?utf-8?B?Umg0anB1UTN4WVN1R2JKU2Y1QTdFcUZyYUxvY2swVlVsZVJxaGRLT0ZIVDY5?=
 =?utf-8?B?TTVyOWx1eWRxbEM0cy91cTV1VlV3L0laNFQvNVRJSmt2M3lPV29na3pXMXdD?=
 =?utf-8?B?VWc4ZW9aby9KNnhUUWQ3QW0xU1ZTR1EzWURmRFNEZjU1YlJzaTViYmN6UUUy?=
 =?utf-8?B?OThyL1hGOWk0LzRvZkYzUTAxb1lnNFJ3VjBGd1FLTlVWV0o0SXl2YU45OStG?=
 =?utf-8?B?OWtyUFdGQmFkUlF2N3VZMUFKeUFySldlVDlidVVia0daMXo0Vis5VHRTRTVQ?=
 =?utf-8?B?NkNoVjc1OFVvTDIxeUQ2QVVMQXdZTjRTc0trOVFud1pMQjRuK1hpK3E1bVZD?=
 =?utf-8?B?ZVQ2UUNTc2RyYzgxUThhRHFPOEV6cHJGTGNYbFR4VXlleG53ZmZ1amFBNy92?=
 =?utf-8?B?aUNQUkRPZThLT2JseW12VUgxTmVETGxINXpFTkR2Q2tKdXlSSlk0Z2pZOFdU?=
 =?utf-8?B?c05iRlVkdk00b25rWHNWQlNKNHVwdTUvaUVoWkZxdlI5Uk1UTGoveDZ4akxE?=
 =?utf-8?B?NkduRWZDQVdQT2c2NkxGamZmTGEwbkE0M0pGU0V3NUJieGlzTFRFVUp1c3Az?=
 =?utf-8?B?Z1AwRFpvTkgwbG1mNkhLbENBMS80OHBqNEhtdzVFcHB3akE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnE5aFdUbSthQ3ZyVnhvbUJyVjMvV1p5RlRqeXF5MFd2bG1OTzRycmVhYzV0?=
 =?utf-8?B?UTRtUXJwR25nRk1wMU9EdTE2cDl4VVVYZ2tJTjAySEN0ZmE0ZVFoVlg0cWZV?=
 =?utf-8?B?cUxpUElIaDlqalFwMHREeGlUSVFFWURSR2dZc3plOWpTNGJXSUwvYkhTWkVC?=
 =?utf-8?B?TU53Q0lUeDg1djhwZi9Rc0QyMHQyb3BiTWZiSkFuOFB6SG9hUGVDREM3S09s?=
 =?utf-8?B?L3RnVGxCdjY1Y2xSd0hvaFZjT3ZERGE3cGUzZFRwWVFXa0UxVDd5TFl1QVBx?=
 =?utf-8?B?UjYzeFdIOXFFZ3pRLzJ5Y1orTGFwQUQzNi84UnR4WFd0Q1lTYW85d28xdlJ3?=
 =?utf-8?B?VFZtWVFxYXhzc0pVeTJEcHY4cXBqU2YxYzhoRTNkMDMySlNwbXZPOXVQcVZy?=
 =?utf-8?B?V3NTRzdZUVNmWkFrNzgxQzlwNVVFK3hiQ01uN1A3dHJ2ZUlHdFAxRTZ2N2I2?=
 =?utf-8?B?MWYxT1dESlJPNzdTZ1VuYWVJMTlIL09UeFJlRTdtcjJ4V3czMUFOem1YZzRU?=
 =?utf-8?B?b2xEUEtYeVZOcUFCWHlSUE9qNm1MVFc0NUJzUmh0UkNBdW42MG1BNFNhM3Bt?=
 =?utf-8?B?WHBpdjlMZXRFcTl1b1VzVG80ekREUTRNTk9mblI2ZVY1UXU0UUtKYXVjNGFZ?=
 =?utf-8?B?cGF6elJJLzZrZVhEM0dEMUMrcm80R1JaY2Rrdmd5bG8wUno1SzdsWWJzbTJs?=
 =?utf-8?B?VFljWkcxVnN3M1hUNjE0NUlBNTliamlPWWlKbXJkWnhiWkxlV0dSK2lyM0Jx?=
 =?utf-8?B?S2h0RG53SU5wY1p0RHVOaGFMYjFjNFNiaDUvc29QRkJhNmgzRGI5RGxQeXhL?=
 =?utf-8?B?SHgzdlI2VkNLbytoOWNzemxnbFUvdFFVU1VNMVFHUHdvU2g5K0tXcG8wVWdV?=
 =?utf-8?B?YU01cm5TeDF4NnVnNkJzQUV3MXRScXBTVlBTUXdJOTVZZytuQnZpdkgwZlFK?=
 =?utf-8?B?Q2s0YnZyV2IzYm0vZUxuWWIvRWo4eWE2UHV1QmlnQ0VPVkQ0ZjFIZ21IVXBE?=
 =?utf-8?B?V3dLY0hKYnd2TmhTRzB3UlNPdmpWenVTTEhYcTFhaWRzbERTVWtjV0w2MDlv?=
 =?utf-8?B?dzNwTElqN0hoZ3J6V0pUN0hqS200S0RRWEkzSndMNEJsd0hMd1N4dDFrSW1Q?=
 =?utf-8?B?TUd1N2wzZTAzTXZpdDNyUklPVkJlS0RRWWZSbVVtVkxOTHA0MnNWcUpIV2FC?=
 =?utf-8?B?UVoxeEE0VTF1TWowVWJlVS9mVDV3bVRTeU5ZbUNGT1BnRTdGNDY4K2RHVklm?=
 =?utf-8?B?dmt5dStsSWlmOWJPc1pOYVRhMGxaRysvVk9NSEtONWZVdjh3ZUpLR21DYlo2?=
 =?utf-8?B?UElxOUdYM0x6azdhVFlNRllIczNnMkpxSVdIYUFUdXpMMXpCcW5MVUZwczM3?=
 =?utf-8?B?SUtKZVIxRmtkUC9HTXkxOXFBQzBEQnZBdCtDRUp3S1N2L1ZuY29QU0htQS8v?=
 =?utf-8?B?ZGdpY0VOQThBTEZFTUFDZ0FLNzh1d1BJOTY3S0JDaHVJTHE0bGw1ZmlBL2pa?=
 =?utf-8?B?QTRBSmEvNnZOZVZmSlNoYTdSN1JlT2FENWJ3NUdOVzdkS2VLM211TGZyTkh2?=
 =?utf-8?B?bGY3L0VxLzN3amlSV0JRanVqRitUb01acTY0Qmw4d0V4a2Vhb0pzRGtiY3Zr?=
 =?utf-8?B?TWlTSklRTlFuTklWd1ZUVHBxVEVOeHQrYzBZWTNmOW1vS3Y3REJIanNhRENy?=
 =?utf-8?B?Q0hKYkl2WWVIdmN1QlFYWUI0YlNlbTFTcHhEc0JjZlpSQTFBalE4OEpTTHZk?=
 =?utf-8?B?ejk2ZFl6ZDlaVGlQV3FUK0ZTVWs0OE1PTjRTaVo1ZU8ydG9qNGptZlJoUFFZ?=
 =?utf-8?B?cFdQRUl6bmtzUjRJbURvUVVMQVNleEVIckxHRHNObWNyT1QxUVRuc1dub0ww?=
 =?utf-8?B?NFBMT0hpRGtRbzExUk95c0Q4YTVROEZ0d1E3eUZNa3BETWtyTytIQmhYY2o5?=
 =?utf-8?B?M2tTdmRvRjZjNlZpbDNkZEpudGhZYWV0RDlldEttTlp0V28ydXVVSllSK3B5?=
 =?utf-8?B?R1Bmek5uMThjUkdQZ3FSWE5XZ1RTdXBCdEpIQm1LK21EYTNBM01jTUY0TUFU?=
 =?utf-8?B?T3lvR2c3ZkRRRGRHZjVZaGpxcUt5b2dtaExpWHc1aDNidk1YRkppUHkxL0JX?=
 =?utf-8?B?K0V1TDNwRkl2L2JaNUwrZkJjRnV2Nml3b2hIVEFkd1BORU5EK204Ri9UUGFO?=
 =?utf-8?Q?O8Gyy8quEf3c3tUPccwQMVw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <197E7F41F9990F4F9BF61566867AC096@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cafe5aa-d6fa-474f-78dd-08dcab331c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 16:18:38.3585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtfvIVeYeNUKNarB5Q/DnD0FYnOp3sJs5E69XJpd/9SopgmKcPVdE9H6PcaM12lG1FrmJchK1qnMq1wQsXm1qpgnaQRUPf9va6EieEV3mEAGNtYdpVd7Ja3FojwLtf+p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6633
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNCg0KT24gMTgvMDcvMjAyNCAxMDoxNiwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBv
ciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gUEFTSUQtYmFzZWQg
aW90bGIgKHBpb3RsYikgaXMgdXNlZCBkdXJpbmcgd2Fsa2luZyBJbnRlbA0KPiBWVC1kIHN0YWdl
LTEgcGFnZSB0YWJsZS4NCj4NCj4gVGhpcyBlbXVsYXRlcyB0aGUgc3RhZ2UtMSBwYWdlIHRhYmxl
IGlvdGxiIGludmFsaWRhdGlvbiByZXF1ZXN0ZWQNCj4gYnkgYSBQQVNJRC1iYXNlZCBJT1RMQiBJ
bnZhbGlkYXRlIERlc2NyaXB0b3IgKFBfSU9UTEIpLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaSBM
aXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4g
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4gLS0tDQo+ICAgaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oIHwgIDMgKysrDQo+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAg
IHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDIgZmlsZXMgY2hh
bmdlZCwgNDggaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9p
b21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+IGluZGV4
IGNmMGYxNzZlMDYuLjdkZDgxNzZlODYgMTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4g
QEAgLTQ3MCw2ICs0NzAsOSBAQCB0eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVzYzsN
Cj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUEFTSUQodmFsKSAgICAoKCh2YWwpID4+
IDMyKSAmIDB4ZmZmZmZVTEwpDQo+ICAgI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0RJRCh2
YWwpICAgICAgKCgodmFsKSA+PiAxNikgJiBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVlREX0RPTUFJTl9JRF9NQVNLKQ0KPiArI2RlZmluZSBWVERf
SU5WX0RFU0NfUElPVExCX0FERFIodmFsKSAgICAgKCh2YWwpICYgfjB4ZmZmVUxMKQ0KPiArI2Rl
ZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0FNKHZhbCkgICAgICAgKCh2YWwpICYgMHgzZlVMTCkN
Cj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9JSCh2YWwpICAgICAgICgoKHZhbCkgPj4g
NikgJiAweDEpDQo+DQo+ICAgLyogSW5mb3JtYXRpb24gYWJvdXQgcGFnZS1zZWxlY3RpdmUgSU9U
TEIgaW52YWxpZGF0ZSAqLw0KPiAgIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIHsNCj4gZGlm
ZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
PiBpbmRleCA4ZDQ3ZTViYTc4Li44ZWJiNmRiZDdkIDEwMDY0NA0KPiAtLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+IEBAIC0zMjIsNiAr
MzIyLDI4IEBAIHN0YXRpYyBnYm9vbGVhbiB2dGRfaGFzaF9yZW1vdmVfYnlfcGFnZShncG9pbnRl
ciBrZXksIGdwb2ludGVyIHZhbHVlLA0KPiAgICAgICByZXR1cm4gKGVudHJ5LT5nZm4gJiBpbmZv
LT5tYXNrKSA9PSBnZm4gfHwgZW50cnktPmdmbiA9PSBnZm5fdGxiOw0KPiAgIH0NCj4NCj4gK3N0
YXRpYyBnYm9vbGVhbiB2dGRfaGFzaF9yZW1vdmVfYnlfcGFnZV9waW90bGIoZ3BvaW50ZXIga2V5
LCBncG9pbnRlciB2YWx1ZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZ3BvaW50ZXIgdXNlcl9kYXRhKQ0KPiArew0KPiArICAgIFZURElPVExCRW50
cnkgKmVudHJ5ID0gKFZURElPVExCRW50cnkgKil2YWx1ZTsNCj4gKyAgICBWVERJT1RMQlBhZ2VJ
bnZJbmZvICppbmZvID0gKFZURElPVExCUGFnZUludkluZm8gKil1c2VyX2RhdGE7DQo+ICsgICAg
dWludDY0X3QgZ2ZuID0gKGluZm8tPmFkZHIgPj4gVlREX1BBR0VfU0hJRlRfNEspICYgaW5mby0+
bWFzazsNCj4gKyAgICB1aW50NjRfdCBnZm5fdGxiID0gKGluZm8tPmFkZHIgJiBlbnRyeS0+bWFz
aykgPj4gVlREX1BBR0VfU0hJRlRfNEs7DQo+ICsNCj4gKyAgICAvKg0KPiArICAgICAqIEFjY29y
ZGluZyB0byBzcGVjLCBQQVNJRC1iYXNlZC1JT1RMQiBJbnZhbGlkYXRpb24gaW4gcGFnZSBncmFu
dWxhcml0eQ0KPiArICAgICAqIGRvZXNuJ3QgaW52YWxpZGF0ZSBJT1RMQiBlbnRyaWVzIGNhY2hp
bmcgc2Vjb25kLXN0YWdlIChQR1RUPTAxMGIpDQo+ICsgICAgICogb3IgcGFzcy10aHJvdWdoIChQ
R1RUPTEwMGIpIG1hcHBpbmdzLiBOZXN0ZWQgaXNuJ3Qgc3VwcG9ydGVkIHlldCwNCj4gKyAgICAg
KiBzbyBvbmx5IG5lZWQgdG8gY2hlY2sgZmlyc3Qtc3RhZ2UgKFBHVFQ9MDAxYikgbWFwcGluZ3Mu
DQo+ICsgICAgICovDQo+ICsgICAgaWYgKGVudHJ5LT5wZ3R0ICE9IFZURF9TTV9QQVNJRF9FTlRS
WV9GTFQpIHsNCj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgIH0NCj4gKw0KPiArICAg
IHJldHVybiBlbnRyeS0+ZG9tYWluX2lkID09IGluZm8tPmRvbWFpbl9pZCAmJiBlbnRyeS0+cGFz
aWQgPT0gaW5mby0+cGFzaWQgJiYNCj4gKyAgICAgICAgICAgKChlbnRyeS0+Z2ZuICYgaW5mby0+
bWFzaykgPT0gZ2ZuIHx8IGVudHJ5LT5nZm4gPT0gZ2ZuX3RsYik7DQo+ICt9DQo+ICsNCj4gICAv
KiBSZXNldCBhbGwgdGhlIGdlbiBvZiBWVERBZGRyZXNzU3BhY2UgdG8gemVybyBhbmQgc2V0IHRo
ZSBnZW4gb2YNCj4gICAgKiBJbnRlbElPTU1VU3RhdGUgdG8gMS4gIE11c3QgYmUgY2FsbGVkIHdp
dGggSU9NTVUgbG9jayBoZWxkLg0KPiAgICAqLw0KPiBAQCAtMjg4NiwxMSArMjkwOCwzMCBAQCBz
dGF0aWMgdm9pZCB2dGRfcGlvdGxiX3Bhc2lkX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpz
LA0KPiAgICAgICB9DQo+ICAgfQ0KPg0KPiArc3RhdGljIHZvaWQgdnRkX3Bpb3RsYl9wYWdlX2lu
dmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBkb21haW5faWQsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCwgaHdhZGRy
IGFkZHIsIHVpbnQ4X3QgYW0sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBib29sIGloKQ0KPiArew0KPiArICAgIFZURElPVExCUGFnZUludkluZm8gaW5mbzsNCj4g
Kw0KPiArICAgIGluZm8uZG9tYWluX2lkID0gZG9tYWluX2lkOw0KPiArICAgIGluZm8ucGFzaWQg
PSBwYXNpZDsNCj4gKyAgICBpbmZvLmFkZHIgPSBhZGRyOw0KPiArICAgIGluZm8ubWFzayA9IH4o
KDEgPDwgYW0pIC0gMSk7DQo+ICsNCj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4gKyAgICBn
X2hhc2hfdGFibGVfZm9yZWFjaF9yZW1vdmUocy0+aW90bGIsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZ0ZF9oYXNoX3JlbW92ZV9ieV9wYWdlX3Bpb3RsYiwgJmluZm8pOw0K
PiArICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgYm9vbCB2
dGRfcHJvY2Vzc19waW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgVlRESW52RGVzYyAqaW52X2Rlc2MpDQo+ICAgew0K
PiAgICAgICB1aW50MTZfdCBkb21haW5faWQ7DQo+ICAgICAgIHVpbnQzMl90IHBhc2lkOw0KPiAr
ICAgIHVpbnQ4X3QgYW07DQo+ICsgICAgaHdhZGRyIGFkZHI7DQo+DQo+ICAgICAgIGlmICgoaW52
X2Rlc2MtPnZhbFswXSAmIFZURF9JTlZfREVTQ19QSU9UTEJfUlNWRF9WQUwwKSB8fA0KPiAgICAg
ICAgICAgKGludl9kZXNjLT52YWxbMV0gJiBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRfVkFMMSkp
IHsNCj4gQEAgLTI5MDcsNiArMjk0OCwxMCBAQCBzdGF0aWMgYm9vbCB2dGRfcHJvY2Vzc19waW90
bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAgICAgICBicmVhazsNCj4NCj4gICAg
ICAgY2FzZSBWVERfSU5WX0RFU0NfUElPVExCX1BTSV9JTl9QQVNJRDoNCj4gKyAgICAgICAgYW0g
PSBWVERfSU5WX0RFU0NfUElPVExCX0FNKGludl9kZXNjLT52YWxbMV0pOw0KPiArICAgICAgICBh
ZGRyID0gKGh3YWRkcikgVlREX0lOVl9ERVNDX1BJT1RMQl9BRERSKGludl9kZXNjLT52YWxbMV0p
Ow0KPiArICAgICAgICB2dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShzLCBkb21haW5faWQsIHBh
c2lkLCBhZGRyLCBhbSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlRE
X0lOVl9ERVNDX1BJT1RMQl9JSChpbnZfZGVzYy0+dmFsWzFdKSk7DQo+ICAgICAgICAgICBicmVh
azsNCj4NCj4gICAgICAgZGVmYXVsdDoNCj4gLS0NCj4gMi4zNC4xDQo+DQo=

