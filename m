Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3689EF5867
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 17:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs2Ol-0005b5-Si; Mon, 16 Feb 2026 12:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vs2Oj-0005ZD-J2; Mon, 16 Feb 2026 12:28:38 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vs2Oa-0002Kq-MG; Mon, 16 Feb 2026 12:28:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGWP2pBPEPvDL4FciHDH0i313X9Dx11Waxl81EX/AQbunsKQvw67728zgljuPrFqOtSlpyTYaYbFfuTCKTaWcxQY+W0RTWCxfXPyAm7QZFMMM30CMNJI569pUTDHBH5SfehT84ZzuKiTGul+EU1wT1U+l3m1YWxI9FVTrBgvANf01yuwxYlounnkXDP7diVlU9a10b/Pbel5VXPOcF5k5sNaj3Q45R+48JQlBiS++CKylfy67cxAt6elO+qDHJJ1kBtLk9asTEidsuZAEdqjBCPxxiI/pijHTPm0YHAPKMqMdwC0yoKqKTCiFMk1KRsmcgOPyJuEJrwtkhxrtf8YZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MocpWZd9s+o9q9h5aynFuyHj55ATYVbFcC1qO8MzxI=;
 b=lKxvwgLnIi9Ok8UgmzhgDC+6wtRYtmSkhGf5uZ63DsPhgt9DPWCaZbNNpAse5+0JB6YRenCE2tBkloAEs/NmAFn35P3wJe1gh6sVzoJ2zGIJ/x7hJ4IIhzjH/1jv7OfxPhXJ7stx0wWhrvyyLrIyfYxJx+hyfQVxxkjQdxEOHlVEGFgY+GapqdplJil6ohGw/y3kDXIuzeIeIVtfQ+xsQYbdCwWhtZzF0gjwRhm7rcL9srER4SlF2ich1V/uaoouJIVuL8fab1fz69O9qvyHmq5LBJRzC23ClpI3mMk7qYcW4GjzqHvH3nk+/91e1HsBX7O0JjnP3BgO7CRVJz3atQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MocpWZd9s+o9q9h5aynFuyHj55ATYVbFcC1qO8MzxI=;
 b=sbY/7iM7vthEKyLjkvIZHQbpXamA4lbXqR7ycINyUQA2U+dCdFLeBmYS2BTyiJ9xMh7iv0s36I8n//LJZ0vFAPEr7tSeoqcdVP8OfRCyBo/iDReBJTPK0eM7fEcunYJ9Ibjwlx6aRje3ugOUM75LyyefjxdzuPDS/QERI6bHyPX9RU1yzWe9bMMqQHEmIIcN8QUAKzPE1ogow92/Rl4FzBqCZjzvpIl71zpLZC1Rx/hQLUBThttiduzzwYcJ1Ego9TQGlyqJ6kj6E/M6lYlBNlJmwPTxRpAxJcoGv/UhjzZ/jb5CEjALwLyGsIETkmupb7Cj+fMDHBUPE6af4EFMag==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:28:23 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:28:22 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Nicolin Chen <nicolinc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v6 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v6 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHcnNWSbJbcjBWJW0qjaUXjPQ/BMLWBM9eAgAPVAgCAAIgSAIAAAw2A
Date: Mon, 16 Feb 2026 17:28:22 +0000
Message-ID: <CH3PR12MB7548C1BE4F3EBAEFBE1A950AAB6CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
 <20260213103942.142823-4-skolothumtho@nvidia.com>
 <aY+jVfUUTawwPN+f@nvidia.com>
 <CH3PR12MB754850BF9EFF16CEF6130ED8AB6CA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA9h5_4OaKwJe3ca4o5YfMTn7HCsecjKLWy9qeF4+GF04Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9h5_4OaKwJe3ca4o5YfMTn7HCsecjKLWy9qeF4+GF04Q@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB9126:EE_
x-ms-office365-filtering-correlation-id: 16c3f2ee-c082-450b-2b96-08de6d80c8d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?c0p5M3VSWFFPbFBrV0FMUStHaE9XUWJaai9MMnp5Q3l4K3l4d1hRRWxqMDF4?=
 =?utf-8?B?OFVrT2JwM1ByTEgwSUxTQitMNjNhTGJKRHQ2NmdkakE2V3JWc29scGp6Y0or?=
 =?utf-8?B?Rm9FK3BMSnRpWUlMUGVEZGN3WkhYL3dyVUFER3Q5RHlHMHFiM25WMzdlOVcr?=
 =?utf-8?B?ZVg2L0hndUpoQlVnTFNsVmZ1cEd0djBwUUE4QkFjVnRXY0xMUEwzbjVUMU14?=
 =?utf-8?B?dktLVDY2dkJ3NUFPeE5RS1c3bStUMDlmWEppQ1RjQUFtaE5VQ1F3TTUyVHVL?=
 =?utf-8?B?Q2x1aUUybXN4R205ckx4dnVTM2I3SEpYNVg3YW43MG9jbThadllDNVZDSHZI?=
 =?utf-8?B?OWQ5Zld4NlFnNTY1M00rQjdTMVNweEVNcjc4NnJSUDlzbGNwbTJHSzV6MkRx?=
 =?utf-8?B?NWtCSlNjN1NsSGx5bkhkaTZvK09XTCtmTVNoZ1dPV0RaL2xCd0Jid0lDemta?=
 =?utf-8?B?bGh5OENvM3lKQVNhNjdBZ3N3bEd0YXJBY0R1Z2tFOCtjWEhHSTJoSzlxTWlJ?=
 =?utf-8?B?RGZLWDl1WGhUSUg0OXZ4Z3YyRDA0YkY0Um1PdFZjWU1LWHhlZC9FdWpTMkdr?=
 =?utf-8?B?ZXZpZkdvelNHU2JGZTZxSitpZzA1aDZWd3dPTUNiNU42MnJDeFNWdnRmOWsx?=
 =?utf-8?B?ZzZnVXZKd2E5RHdVTzJ2REJxSGpDVHAvNWZEbkQrRXNVamgrNkNOWHZPUTdD?=
 =?utf-8?B?M1VYMm9uKzJ5SlJhd01PQVk5NmttRU9Edmk4eWJyZjRONkg3c2gxUFhrcndU?=
 =?utf-8?B?dktsSG5PenAxQkJnTEhTUU42SnltMEJwYnV2Qlpud1lsTjkrZElUWmNWWVpr?=
 =?utf-8?B?OFh2azAvbk13TUNyZm9GU3RISndHaWpjbGlNclliYk4vV3RWZDliOHVmNkF5?=
 =?utf-8?B?R0FOUDFzUWdUR0svZlNMQi9vNlFUTTZsRjJnd0U5aUxCNk10aThwUm9Uc3Nk?=
 =?utf-8?B?alRpWEVDTS9VOGtmLytCZHQzVEE5L3FJZ0xiMjNpY3VyK1YybEJITXRrWlNm?=
 =?utf-8?B?Q2NIeFZNNFkwclRuRTRIeEszcXQvdkVjbHZYc2Rja1N2N0wzZWxzUEtlN1dr?=
 =?utf-8?B?MXVSOGdoUzJ0dExtVWppRUR3eXRRNmhiZkFmaW9pUW1FY1lUc2JmczBpZnRZ?=
 =?utf-8?B?VjlRMEVpQUo2TEdJQitMQkhiYlROY2QwYWhqTWo4d05VblluV1JNUkFDZndV?=
 =?utf-8?B?SW1tQ3lXZ3FGbzBGaHNCaEJRWUdsdUxlb0RWZ2RDZkJYSnRQR1k2a1F2RjdZ?=
 =?utf-8?B?aE1sVjg3TnhiTXF3dWtESDlSaEdIdWh0YU55L1RuZ0FjYVY0Ri9SWkRCbWth?=
 =?utf-8?B?eHRjK3NGK2JLYy9hb0JJTmZ2TnRwTE9IS0VQMFRSektraGFXK2ZmUWRUeTlD?=
 =?utf-8?B?cHNjZkJSZHdiQ3ZwTnF0T05vS0FqbFdiblhnRXhLK2dSRk9EbSs3dVdCTkJ4?=
 =?utf-8?B?NzN1MEhpc1lIT1Q2bG1VMDJNQlV5TUkxVDF3dXA2YVFTbDEreGR5VVZyZ3lo?=
 =?utf-8?B?L1pySDhpZUpDaW9sdzZwdHRseVVza2NOWDI4RERicmpFRFRrYlZQM0JQaVJK?=
 =?utf-8?B?TjNnRzU5bGttQk1neURwcHVJV0lBUzVWd1JvNGIrS2ZHNmF5K282ODZEb1o2?=
 =?utf-8?B?NGh6Q3hXMHNJVWI4MUN4d0dIL3drcEJYTExlTG9VWDVFcC9jQndINWdtUUR0?=
 =?utf-8?B?czBtSjduM0VNcEdYNUpiZ0RyNkRwMWh2SEkyYjdxY21NdGFYbllLbjFVYk9X?=
 =?utf-8?B?RDlENWJ0VnRFUjdKQy9LOCtpTG9GMlQ3QWRNMUVUanBOY20zbnBxdktHdzBr?=
 =?utf-8?B?MTA2cVZIc1lUcnEvU1VaMG96RjU4RWY4a3ZJbVFRSVc1YjlHYmxQaE5lcEJQ?=
 =?utf-8?B?OENXUk1WNzRzeGQ1SDhFTVpxVkFHc2NkcHdScU5RNk9UU2c3bWxSWUxUOEQz?=
 =?utf-8?B?Ym5scVFNOEloYlZKdFpXamwyVVFqUFBTVHVCK2M5VHJqU2NNNFNOWFpocmdr?=
 =?utf-8?B?Q2ZKL1V2K0ZVaGxLL1pkbUNjdHo1M3N6cWVFYXhGWXJ1Y0g0dmRoYWxncko4?=
 =?utf-8?B?OThGMzd1OWROeXNYOEtDMWJrRUVFTHErN0t2NVRHbU4wc0YvclRSYm5QSW9j?=
 =?utf-8?B?UkhpaU9QdWR0UkJiNnMrMlpLNmlGUEVvL0duaDZpUmEyL29OZ1k2RDBieERW?=
 =?utf-8?Q?ipGC2AHnomr/6QP0ReAvPp0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFRrQmc2ZlFaSXR1aDF4WEVZR1pSMFljemZPSlcyeEhUZ2V3Nklwd0IwWWlz?=
 =?utf-8?B?cGVxWlZrSTJwRTFSYWhlRU9tdHJyVDA0K0Y1Q1hQZzhZNTZUNmp4SGlseGtK?=
 =?utf-8?B?V09DMUNOWFRMdE5oNVVDZFRtMVJPR0hHTi9lb24wYTVzVEdsS2JOWUErbFla?=
 =?utf-8?B?ai9tVkhmd0piQXd0akRRNmFNaUJGY2JjWkZuUXJzV1I0NHRPSDU0WWNxdUJF?=
 =?utf-8?B?VWFFUmI3NDNweGdMNTJvdEZ3MkxwNFhibjY2UDJmTzVLNFc2UjFoYzZxODZM?=
 =?utf-8?B?NWhBbHZ5aVBhdUxwemk0VzhaNUpLV0FpQzl6emNxZ2pGZVZ2dE52U0szTG9O?=
 =?utf-8?B?Y0Z3aHNzaWZJYlhZUUJOV3JHYTFQRkl2S0ZmdXlmUVczQUNNVHJyL0lPMU5M?=
 =?utf-8?B?cnZ4eHhnVTl5WXBSYWJIQ2hIam5KMWM2VlN0aTZCQzFNZGc5UFppRWovZi9q?=
 =?utf-8?B?NFRCV0dpZHB4bStBckhaVEM4eTYwY3I3cTV0WC9CVzFlSHFhNEU0aHExeHJN?=
 =?utf-8?B?T01zRk1Ib0Nzald3OEJ6dWlESk1JbS90d01UdStGMzNQTlp3SGtiSVByb3ZC?=
 =?utf-8?B?TWRrQmZ3TG01bW1XcFdZalVNeXRHSXZSSFpZQ0ZQcG1uVzdWSWk0bmlFT2FX?=
 =?utf-8?B?dUtjZDFnK0g5ZzJTSVovMjQvTzJWdGpmdUVUdFR3MU1GbEdXRXhHOGoyWG4y?=
 =?utf-8?B?aWkweTJhcDNmS0lJL3RZQjBLRTc2OXZSc0FjQUdTZDV6dy9lU1o1ek5iandi?=
 =?utf-8?B?WjMrd0lkMnpHRTJQZHFER0Z5bW40ZFE5T2ZqMkpaY00xMGRMUjlqSXBsVWNo?=
 =?utf-8?B?N3ZpOWsxRmlCSWh4WU5JYXgrZHRKL0lqalQ4MFVtQkVQM1RHQU1OcS9wZEw5?=
 =?utf-8?B?UE5wOVdVSjJMakNSVjdUN2h1dUdyaFdMNmhsYkhCV1dVbmhCNmRLWFRVOVBS?=
 =?utf-8?B?enFqeWhndkNtZDcrcjRnRnEwTUFIVG1vNHNZYndtOHF2QVNRQjVxQXhXVmFB?=
 =?utf-8?B?Mmp1WjB4ZFBENGd6N1NqUlVGMFJtR0EzUzEwZUMzaEpYcnhXS2p3V09uRWJG?=
 =?utf-8?B?MnlpRXZRZkFIMXdXZEhUNjdvSkJ6eFhESFBRcVdhU3NQeDd4OHUyNUNOVEdB?=
 =?utf-8?B?YnBLV0l3Sk4xa01tU3FKN0hXTEY5SG1ZN3pQSXo5azlyeGtVQUtkRkJMa1di?=
 =?utf-8?B?aVBNd3JicmplZFV1bGJ3Vit5a09LQWNHVFJKWnJXc3BOS0J4cWJyaU1qT1NX?=
 =?utf-8?B?ZGJQNWFqM0N0Y1EwbXZRemhlUnJqMGJYSlBOVGVHSzd4b3h3MWJDcnpvdHNx?=
 =?utf-8?B?a0ZBc0hhTWJFUmtCRGVVZUFzRURqdGJwRU82QzlQQnM2dElFUmk1UHlZY0ZW?=
 =?utf-8?B?a1N5MGpXcE9CQmR5SUtlaFpVV1JMTVpKWDlmMXBrZ1hoK0lsU3VDYkEweDFu?=
 =?utf-8?B?cElqOE55WDJHMGRMWHIyK0JrYTg3RmVVa0lCWmhiMlVsYXJxY2tkMTdvbUhI?=
 =?utf-8?B?MTl5RWVpOTJ4RThJRkljL3BHVWcyV2RLcXIyYkxUc3dHZ1JPbEVGUnU4SnN3?=
 =?utf-8?B?SDVZQnFDdlA1b29jcEhZUG9MMFdrWE5Yc2VtWFdNOE9FRXlXdTJDT2dUa3gy?=
 =?utf-8?B?WGFSWXI4b0ZreDdrK1l6YXI2WGZOV3ZRUDhrOVUzWlNyU1FQZ2YvQ2FEZFFx?=
 =?utf-8?B?Q0NHM1ZiN0k0RHVodFowT2FqZTlwMmZuTThFVGdOVWN5b3RPR1ZJRDh0MG9Z?=
 =?utf-8?B?bTFuMnArYUQ3MDNEUUJSQXlzeU5Lanplb0dWRkc0ZnNRaWJteUlVbHd5OFY5?=
 =?utf-8?B?SE82bEZXRzFKVWhSbmRLdTBoSzlPK3JyRVBDb1IvY3BYRlZXeExEclJMUWds?=
 =?utf-8?B?aEJ0R2s4UFhoeHJ6OFJUeHRHSGRES3lEVVFJYUlwQTM3cThadXk2Q09UR0dt?=
 =?utf-8?B?N092dHk5Y1k0MWFqNGJZY05TOGN4ZTNSa3htRFpOb2VxT1dDMnRlODZBTGY4?=
 =?utf-8?B?aFdqam1ET0JmS3poZURSSzhNN1g2c1RVMTdCSTZYalJySEFoWEVKUERDelpi?=
 =?utf-8?B?TzB0QnB2WDZmM3VpdkE1L2xKQzhuMEdJazhaVldQUHdmeStCZ0Rwa002WE9B?=
 =?utf-8?B?R01PblhESC9XSHgrNXR2SUpuaXNEb1dtRnlEVEw5eFdYZUxrcUo4N0w4WEpv?=
 =?utf-8?B?VE5YZE5SUTlRWHJ0ME5ZaDZXZ0J5SkMxcmNKcDgzdzZmVTI2SHg5WllFNDV6?=
 =?utf-8?B?YmxpZDRrSE1EekVmdTNLRU9TM0JJc25zeTNPc3hJdEYyN3F3eUx5RXBOVFBz?=
 =?utf-8?B?cnp1akk2RFhSRTFML0d5NERha09TWWw3SDB2NmIyZUl0Q3BwQXdUQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c3f2ee-c082-450b-2b96-08de6d80c8d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 17:28:22.4797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEnjTQUIHxsXMi6CsOJ47AI5QBC0DJEkQRIGnp9Hm3C1xJvaRJSW/avQqtz9OrF7yL+lTLdlGgWYvVsnjdmluQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiAxNiBGZWJydWFyeSAyMDI2IDE2OjU3
DQo+IFRvOiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4N
Cj4gQ2M6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IHFlbXUtYXJtQG5vbmdu
dS5vcmc7IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc7IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsg
TmF0aGFuIENoZW4NCj4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZp
ZGlhLmNvbT47IEppYW5kaSBBbg0KPiA8amFuQG52aWRpYS5jb20+OyBKYXNvbiBHdW50aG9ycGUg
PGpnZ0BudmlkaWEuY29tPjsNCj4gam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOyB6aGFuZ2Zl
aS5nYW9AbGluYXJvLm9yZzsNCj4gemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyBLcmlzaG5ha2Fu
dCBKYWp1IDxramFqdUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDMvNV0g
aHcvYXJtL3NtbXV2My1hY2NlbDogQWxsb2NhdGUgdkVWRU5UUSBmb3INCj4gYWNjZWxlcmF0ZWQg
U01NVXYzIGRldmljZXMNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5n
IGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gTW9uLCAxNiBGZWIgMjAyNiBhdCAw
ODo1OCwgU2hhbWVlciBLb2xvdGh1bSBUaG9kaQ0KPiA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+
IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiA+IFNl
bnQ6IDEzIEZlYnJ1YXJ5IDIwMjYgMjI6MTkNCj4gPiA+IFRvOiBTaGFtZWVyIEtvbG90aHVtIFRo
b2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiA+IENjOiBxZW11LWFybUBub25nbnUu
b3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+ID4gPiBlcmljLmF1Z2VyQHJlZGhhdC5jb207
IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgTmF0aGFuIENoZW4NCj4gPiA+IDxuYXRoYW5jQG52
aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4NCj4gPiA+
IDxqYW5AbnZpZGlhLmNvbT47IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+Ow0KPiA+
ID4gam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsN
Cj4gPiA+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdSA8a2phanVA
bnZpZGlhLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMy81XSBody9hcm0vc21t
dXYzLWFjY2VsOiBBbGxvY2F0ZSB2RVZFTlRRIGZvcg0KPiA+ID4gYWNjZWxlcmF0ZWQgU01NVXYz
IGRldmljZXMNCj4gPiA+DQo+ID4gPiBPbiBGcmksIEZlYiAxMywgMjAyNiBhdCAxMDozOTo0MEFN
ICswMDAwLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+ID4gPiAgc3RhdGljIE1lbVR4UmVz
dWx0IHNtbXVfd3JpdGVsKFNNTVV2M1N0YXRlICpzLCBod2FkZHIgb2Zmc2V0LA0KPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGRhdGEsIE1lbVR4QXR0cnMg
YXR0cnMpICB7DQo+ID4gPiA+IC0gICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+ID4gPiA+
ICsgICAgRXJyb3IgKmVyciA9IE5VTEwsICpsb2NhbF9lcnIgPSBOVUxMOw0KPiA+ID4gPg0KPiA+
ID4gPiAgICAgIHN3aXRjaCAob2Zmc2V0KSB7DQo+ID4gPiA+ICAgICAgY2FzZSBBX0NSMDoNCj4g
PiA+ID4gICAgICAgICAgcy0+Y3JbMF0gPSBkYXRhOw0KPiA+ID4gPiAgICAgICAgICBzLT5jcjBh
Y2sgPSBkYXRhICYgflNNTVVfQ1IwX1JFU0VSVkVEOw0KPiA+ID4gPiAgICAgICAgICAvKiBpbiBj
YXNlIHRoZSBjb21tYW5kIHF1ZXVlIGhhcyBiZWVuIGVuYWJsZWQgKi8NCj4gPiA+ID4gLSAgICAg
ICAgc21tdXYzX2NtZHFfY29uc3VtZShzLCAmbG9jYWxfZXJyKTsNCj4gPiA+ID4gKyAgICAgICAg
c21tdXYzX2NtZHFfY29uc3VtZShzLCAmZXJyKTsNCj4gPiA+ID4gKyAgICAgICAgLyogQWxsb2Nh
dGUgdkVWRU5UUSBpZiBFVkVOVFEgaXMgZW5hYmxlZCBhbmQgYSB2SU9NTVUgaXMNCj4gYXZhaWxh
YmxlDQo+ID4gPiAqLw0KPiA+ID4gPiArICAgICAgICBzbW11djNfYWNjZWxfYWxsb2NfdmV2ZW50
cShzLCAmbG9jYWxfZXJyKTsNCj4gPiA+ID4gKyAgICAgICAgZXJyb3JfcHJvcGFnYXRlKCZlcnIs
IGxvY2FsX2Vycik7DQo+ID4gPg0KPiA+ID4gSXQgd291bGQgYmUgY2xlYW5lciB0byBoYXZlOg0K
PiA+ID4NCj4gPiA+ICAgICAgRXJyb3IgKmxvY2FsX2VycjIgPSBOVUxMOw0KPiA+ID4gICAgICBF
cnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4gPg0KPiA+IFllYWguIEkgaGFkIGEgYml0IG9mIGJh
Y2sgYW5kIGZvcnRoIG9uIHRoaXMuIE15IHRoaW5raW5nIHdhcyB0byB1c2UgZXJyIGFzDQo+ID4g
YW4gYWNjdW11bGF0aW5nIGVycm9yIHBvaW50ZXIgaW4gY2FzZSBhZGRpdGlvbmFsIGVycm9yIHBh
dGhzIGFyZSBhZGRlZA0KPiA+IGxhdGVyLCB3aXRoIGxvY2FsX2Vycl94IHVzZWQgZm9yIGludGVy
bWVkaWF0ZSBjYWxscy4NCj4gPg0KPiA+IEVpdGhlciB3YXkgaXMgZmluZSBJIGd1ZXNzIGZvciBu
b3cuDQo+IA0KPiBHZW5lcmFsbHkgc3BlYWtpbmcgd2Ugc2hvdWxkIHRyeSB0byBzdGljayB0byBv
bmUgb2YgdGhlDQo+IGRlZmluZWQgc3RhbmRhcmQgcGF0dGVybnMgZm9yIEVycm9yIGhhbmRsaW5n
IGluIHRoZQ0KPiBiaWcgY29tbWVudCBpbiBpbmNsdWRlL3FhcGkvZXJyb3IuaC4NCj4gDQo+IFlv
dXJzIGlzIHRoZSAicmVjZWl2ZSBhbmQgYWNjdW11bGF0ZSBtdWx0aXBsZSBlcnJvcnMiIHBhdHRl
cm4sIEkgdGhpbms/DQoNClllcywgdGhpcyBjdXJyZW50bHkgdXNlcyB0aGF0IHBhdHRlcm4uDQoN
Cj4gVGhhdCB3b3JrcywgYnV0IGRvIHlvdSByZWFsbHkgd2FudCB0byB0aHJvdyBhd2F5IHRoZSBz
ZWNvbmQgZXJyb3INCj4gbWVzc2FnZSB3aXRob3V0IHJlcG9ydGluZyBpdCBpZiBib3RoIGNhbGxz
IGZhaWw/DQoNClRoaXMgd2FzIGNvbnNpZGVyZWQgZWFybGllciwgYnV0IHN3aXRjaGVkIHRvIHRo
ZSBlcnJvcl9wcm9wYWdhdGUoKQ0KcGF0dGVybiB0byBmb2xsb3cgdGhlIGFjY3VtdWxhdGlvbiBz
dHlsZS4gU2luY2UgdGhlIHR3byBjYWxscyBhcmUNCmluZGVwZW5kZW50LCBJIGFncmVlIGl0IGlz
IGJldHRlciB0byByZXBvcnQgYm90aCBleHBsaWNpdGx5LiBJIHdpbGwNCnVwZGF0ZSB0aGlzIGlu
IHRoZSBuZXh0IHJldmlzaW9uIGlmIHRoZXJlIGFyZSBubyBmdXJ0aGVyIGNvbmNlcm5zLg0KDQo+
IFBsdXMsIGZyb20gdGhlIGNvbW1pdCBtZXNzYWdlOg0KPiANCj4gPiBBbHNvLCByZW5hbWUgdGhl
IGxvY2FsIGVycm9yIHZhcmlhYmxlIGFuZCByZWZhY3RvciBzbW11X3dyaXRlbCgpIHRvIHVzZQ0K
PiA+IGEgc2luZ2xlIGVycm9yIGFjY3VtdWxhdG9yIHdpdGggZXJyb3JfcHJvcGFnYXRlKCkuDQo+
IA0KPiBJZiB5b3UgZmluZCB5b3Vyc2VsZiB3cml0aW5nICJBbHNvLCAuLi4iIGluIGEgY29tbWl0
IG1lc3NhZ2UsDQo+IGl0J3Mgb2Z0ZW4gYSBzaWduIHRoYXQgeW91IHNob3VsZCBjb25zaWRlciBz
cGxpdHRpbmcgdGhlDQo+IGNvbW1pdCBpbiB0d28uDQoNClN1cmUuIEpvbmF0aGFuIGFsc28gbWVu
dGlvbmVkIHRoYXQuIChJIHdhcyBsYXp5KQ0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

