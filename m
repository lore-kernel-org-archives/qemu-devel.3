Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D7AD66B86
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwQI-0006ih-OG; Wed, 17 Dec 2025 13:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vVwQB-0006ZL-2o; Wed, 17 Dec 2025 13:38:50 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vVwQ4-0007lN-6J; Wed, 17 Dec 2025 13:38:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnzV4IO2zlK9LNYhUy23eJtQHMQxO9YjeYVMCabollkDMWJtCAQvpAPdPkJB5RUNT41FsV0v6EU8hSJDuP+8dghGfTWgEcQ+pAGHM0+LjTHULbljOTrFJBHsWBDHuxX/iuVW2N91LqSV17cDoDDEmGA/JVnVsYsuFP3wcA/+mtJvLsGtH0EeSPlyGj126lL/aBepwbsDZhyy5muUJ/TQsd+Z2kmvaOsVjOM2KlqLxaldTs8UfZCWF3t+vnd7uSks8nQ48jiS9D0Q3uihcmDVnAsburQTM0RUeplbzOp+zhWeMe/I8ZfRdZfPp4SnRwAM6w7HHhliT8QxXqur4UQiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvPWYS+NDENqvwlo5cFT3Cy3h0uqZ5QeInfqWHsqO3Y=;
 b=oR+mEG6YgSFSlyKCff1jeFa/Rof/rwGH9MVrwmekS2tgTDJVHt2dDV49Fn0gruAQfjNmfxQGXd1RE2CvrTF3YRIolCyzddKjgy0kcLo3aAA5H0cTwcZntvo09pfVUR0Z2gwaaEPjbjJfV4lw8TgfsuPdANcgx4SHcy5alqMCf5SLmxgsJhiJ6s6pmaSgPHWjXhGFQ7Euqab2pdIiTGt/cx1ItCxlPK8GMA7wFFsSFlC00ZApFpZ3UVxrrBLJT7f96mQgfVqlyuW6VErjTp8yUlGlphbptSny+DfAp3WaUB/gwcxVUisIt9p+v2kbgwCdOsLe4nJtd85njiEDZbpQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvPWYS+NDENqvwlo5cFT3Cy3h0uqZ5QeInfqWHsqO3Y=;
 b=Erfr8i1+unD3CVHLj/GAkRGKZNFGP5yslzezCHlCNdsDJxL5Lgm5f0ME/pe2MMY4uVKoNqRv52DiDR8YVXgBPlRA3OEB2Z5TSMsx9oxsByJYGZrJb5FE5NOD9gPPg7IgSw/KkNJJ2aSpOMwKJi1k+ugtgrdmXYOCUtGQBeLQ/54aNWBJsAvaM/sRCovy/+sp6z3oGNezCYBAUP1W3IU0hXvE2fGAt57o+/QcumoWm8EgloABCJOqsLTgzosumwq+2RRbu+qD2tqgdU7Ah7oIfx7BRSn06terGwTYqqnSg/Hoguh1N/LVn6jpI4B/ItCtbV6egAjgAPZgvzcU/ZtSqg==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:38:32 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:38:32 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v6 05/33] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Topic: [PATCH v6 05/33] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Index: AQHcWiEz3NPQuSLS1Uq+6MXwYU/Cr7Uchm+AgAEZyrCACKOPgIAABZJg
Date: Wed, 17 Dec 2025 18:38:32 +0000
Message-ID: <IA0PR12MB75555BE35A7F2CDD8580E7EEABABA@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-6-skolothumtho@nvidia.com>
 <6a062129-2b8f-420a-a4b9-87dde7574481@redhat.com>
 <CH3PR12MB7548E01E6CC271356D4D4208ABAEA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <5b17d7e8-e4d0-4087-b104-c50a418ff24c@redhat.com>
In-Reply-To: <5b17d7e8-e4d0-4087-b104-c50a418ff24c@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|SJ0PR12MB7005:EE_
x-ms-office365-filtering-correlation-id: b850dc0d-59d0-4987-5d00-08de3d9b7ae7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?OWl0Wk95N1VkYmpMUU90QXR5OUdoWnVSRVNpdlFBRzFtNDh5b0hLdUFONy81?=
 =?utf-8?B?L1FqQ0tOQVJWbjZ1OEVaZGJsN1hvVzh5LytqUUJPSTFFRWFCK0p6NXhNcVlF?=
 =?utf-8?B?T0htdW5vOTd2NWRicTJGU3ViNlBvcE8vdkhSRFZ5dmJlNHVpM1NKY0Z0SGNn?=
 =?utf-8?B?WDh2b0dZdXJEMmRCVk4zdEtRMmczM1VDN2dsb1JjQWVrYWlBVitXR0cybGFZ?=
 =?utf-8?B?RDA1U1dtQzR4alIzZ0x1ZEo1QXlOeGxRZ3hMY3p3UlBVMG9kVUJlQlgxajhH?=
 =?utf-8?B?Z1RBMHNwdnpsYUhHaVJ5UjB4dEszZlNWcHNWeGd3M1pKNGdnd2IzcGRyeHR1?=
 =?utf-8?B?NXpKRTBuMmVzSU5FSG1HVXBHajlyNjlYTFhTYlZEWnRncXlKWVVGVW5hRUpQ?=
 =?utf-8?B?cDFlVHV2ME9ONWF0MFBhT0dBTElKQjhSWlRjWEFuWUtEV0NYb1duNmx6VDVi?=
 =?utf-8?B?QTdrZ2IzV2VxVTVXcUpyZndHdEhzM0lpa29oQzZGMnVOdUFTOEZKbnl0UUV3?=
 =?utf-8?B?dFJ0UnhobC80Wnh3L2dRVDVyL0FFZ0Y5cWV0VjVWVzROVTV1YTZLYXArWEZk?=
 =?utf-8?B?ck9NRENZV2RHU3FySHlINWRQenF6QTZmYnhXZHBIZVpNUkRYSEozRUtkMFVh?=
 =?utf-8?B?UEcwdktVdnVOZkVaUlRLMmxCMlorZTVrcGRLUW5LN1RVcmh4aDhneXdVYlE0?=
 =?utf-8?B?eTZVWWdtS2V1SnAzY2dRclNOU3p3NGV3Mit2VnFWT0xlQzRodFUxTlpoSmdO?=
 =?utf-8?B?ek5rcVMzMm5SZXhkb0gxT1dLYzkzUll5ZFJnQ0lEbjAweUxIUHZVU0d6bEM0?=
 =?utf-8?B?elJRdzFocW9ycmFUQkFNM1JLa0N2Mk1ueTZJMzNqYjMwaWhDZFRBY2gyMGVR?=
 =?utf-8?B?Z204SFVwbkVVMmV5aXEvZ085WDVpNWFROURBZVp5Z3VaeW1oVDVJL2lTSnBO?=
 =?utf-8?B?Q1M0K1Z1bGcwTkJwNFZaZXcweFpPQ2IzWWt3UVZOTE1NVkIxNFY3Z09PdlJV?=
 =?utf-8?B?RDdyclNwMTExL2UyaGc4UlJsK2ZpQlNoamRJQW00eVpLcktnbUZtY1N0dlJE?=
 =?utf-8?B?NURiRk0xRHFOcFovVnpqMkQxUW94eVQwc1dEQUU1Q3NLWE03OWR2YmRMcGdS?=
 =?utf-8?B?bXRQWTZCK25wMGgvWEZ6cWRQNGNiaUs4bThxQ2daZ1M3TUZ2ZWcyaUxUbVR4?=
 =?utf-8?B?ZXBwUThHN1pCUnNLNUZTMlhXbW1XSlRMWEN3WUVacVdUQW5mTUFaNG9yeVFh?=
 =?utf-8?B?NlNoa3pGVWtTTFIvTUJsU2Z1UFNzNHpYTjF6SG9TU0tQeXk1S3ZQWEdKRUpw?=
 =?utf-8?B?Q0hwWG55cGVhSzcrZTljT2hnWDB3SWkvR1ppOC83YzMydnBhSDA4VmdMcWVm?=
 =?utf-8?B?OGVvSWRCcGxJY1IzMGRwRXhWaTRRa1BMdm5tQUR6WCtiZWJoa2VmOStmRm1i?=
 =?utf-8?B?aGN5NzVQUDhFVkFLRnQ4cVIxL3M5OFRFcis3UCt0R1Y2NzJvazh3SlpKbkMr?=
 =?utf-8?B?b1Z1VlNjakxCUERWWVF1clBPWXZ1UGo1eWFaUHhFb0xmTXJ1ZWk4NzZqMURV?=
 =?utf-8?B?cjZ5ejA5bnRBdFBURDEybllDSlNKcmRIT1EyeVN6b3BSNnExcVhlTFRSNmNm?=
 =?utf-8?B?dGNjWXhOZzFDTWtpZDN2QUNFUnlIQSthWVZoRVBsREx1ckIySU1EZWNNSWZF?=
 =?utf-8?B?UHhrM1hMbW5MZ0tCMTNxMVdwUGxrUjlMUzVPUktVNTJLUnhHZFdMMHhLRG0y?=
 =?utf-8?B?RHNZVWcrWFFvc0lQVFU2b2tVdVU2SFgvNWM3dGVTanFHZnlIT3duejNrbjJ0?=
 =?utf-8?B?OUNVOWc3QlZ5bitrTkVHQVZmWXlOZ1RvNWZOV21xQXdjWUNCYWM0SGgveHhJ?=
 =?utf-8?B?aEl2QytpSzkwM2FYWnhXUGVUOEk4YlVTWkdrTm9nQVhIOFVEN1g1bU5kNC9k?=
 =?utf-8?B?YTFUVUpqWjN0SlNCZ2ZrQlNsOTBSOVFENjhUeGxXQnVTaGkxT2YzdzJMTjFN?=
 =?utf-8?B?Y0kzcndQZFlRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzYrVWk3VjE0UWE5dXVPdXBZdUJMVTNYV1lYbXRXYkdDNHZwTHNML2dibW9J?=
 =?utf-8?B?OWhxWEE5RUE3SGpNMm0yUzFwRk9GQ0x0VTNpUm1DMmhkc255UUhBcisyTUVG?=
 =?utf-8?B?WTRyRDFieG9HSW9RTTNzQkx4RStYUWMya0M2QUVzZW9XVW5oWk1qM09lcWF6?=
 =?utf-8?B?NGk2bEd2cVFpQnhlYW5DMFhkWjZHK3R3b1RSTzRsbWhacTZZaWNoMk9ZRVRR?=
 =?utf-8?B?UmQ2TUNnQS8xdFhjWSt2U2FSVGVSRmdITTBzRm94WG9JU2hmNkcvZnl4ejJu?=
 =?utf-8?B?dkFOeHFER1VXaUtCenNKSERaZVdQTXAzRnhYUEFKdmhlWmhUOUlSSkhRWThx?=
 =?utf-8?B?cUp0Zmthb3VGcnJ4N2hJZCtpeXc2VnRkc0NzWTRXdHpqVURLckFqNUtqZzBr?=
 =?utf-8?B?OGI5WTBydTdKY0RydWN4UFhpMkJUVzdwTUdZWDl6blludlg5OWhMR2VwZnhF?=
 =?utf-8?B?c3pKdkRCejhYVXo2S3luazNoOCtYVW5ZbUlOZzVYVDV1bnpwaTN1NXRqVm5s?=
 =?utf-8?B?R1hyZDd4UDgvMkJRQVpCZEFqK2RRWklkUGFsdHN1NHFmTm1UcXF3MW45VUxp?=
 =?utf-8?B?U0RxTU9JYTFLdlhCQjBIQjBPNGtDcmRpV1hwME5GNHlEaURLTDhZVElJdDFT?=
 =?utf-8?B?VGgrMUd2aHlwTXg4bEpVMVBzc1QvTUFxVHNka0o1UU9tQ1pWTzNsMTAyUEdR?=
 =?utf-8?B?QnZWckdiN2x1UEN0SytUcGdKUjhMSGhORi9waXhqeWt6QktxcGR1WkZYTFly?=
 =?utf-8?B?WHo2d09pREtTbEhzZ2s4YkFRaDJUYld1NFdadm5rTnJjNmcrQkFmYkI0SldH?=
 =?utf-8?B?aE9LSWdBUFdqSlBXcklYSVQ4cVdtZytmSGNhRzd5OHBVK2ZhbHdIdDdYNlNM?=
 =?utf-8?B?NlJ6Z3Q1WlRTSEdGUSttQmFYL1dwcXlwOWdnNlp1blFzVjFvSFdBRUpGTU50?=
 =?utf-8?B?RnV5aVcrV1lRVkZWb2ZHRWtENzRjS1RoV3IyNVE4R3ovVStsdWRPcjhIbkFH?=
 =?utf-8?B?aXEvSnVoMEpIREkxZjRObWxLNC9FNVJkKzR0SUVLR1BvdTUyMkdQeWFaajh0?=
 =?utf-8?B?RVBFODZVVWRmMFd4dnlrUktzcjNVbkpWRTgxdER3bTNwZ2Q4RXVtNlp5bERx?=
 =?utf-8?B?MnZWa2ZjWTlOemJUYUpqOTk4NEl0Z1BiYzV0Smt3QzJsSmJUdm84VzlyZTRX?=
 =?utf-8?B?QkFDbG83Ukcvb0czMWgyV2pZdGV0WTAxVEZYUGhyaE1HODJYdlpuZWlBK2RQ?=
 =?utf-8?B?Smw2UFhTS0lPbHVrOE9aWmdTWlF6d0lueGV2blN1dzlWVk1INEV6WGxFdngr?=
 =?utf-8?B?L1BHaXhYN21Yd2djWVNRbmRac3NWeWhST3J0elpLQnRWbFhsclBUYVNyZzAr?=
 =?utf-8?B?L05rNXcwYUhELzNQdzBVVDJiUk9LdTFYdDZhTmJQaHl1L1ZTWk5nRE1VdlM2?=
 =?utf-8?B?c0k1OWZlTWxjYm9MQW4xeHR4U3QzR2lSQU4xb2MxUnF1Sm9tOHEyNTlrQUdo?=
 =?utf-8?B?dEQwNU9mTktkM2tXU2JsN3dCdENRTXd1ZzZ6N3hzL0s4dzJJUWc3MHJ2eVls?=
 =?utf-8?B?Y2c5V2JsTCtZR3pGYkdmWkVqYmdPcXNqREF3Szl5d01GNjY3QmY1S2hxNWNl?=
 =?utf-8?B?MzV1WnRFQUVuOXdscEk5THNoWllpRG9LUUpwOHFiS1YvLzlZN0ZJUUN6TzVu?=
 =?utf-8?B?bzh1aDFTSEk1QWdZZk1rc2lJK3d2eXhJcWtCM1ByQ0hGcm16VE44VnIzQTlt?=
 =?utf-8?B?endua1JoVHVOSm52RWJmUXBRbk1QQVgyRVVFVytKOXNMd3dPRlA1b2F3U2Ja?=
 =?utf-8?B?VGxTSDVvQVpocW5NQlkwSXQ3VStaRXJHY1ZRQlc2ZDBSZzhtbXdFSlVkNUJ1?=
 =?utf-8?B?QUFvc3ViZy9TWVBwVVZRdjhlT1RwL3A1TDNPR3h1OVJpVXhrWFhzbHdMQkxE?=
 =?utf-8?B?RkEwMEphVy9ST2xja2NJanlUZHNnUVVMaUlBVzZjSURnN21PMjQ2cXE5N1lx?=
 =?utf-8?B?QmV4eTIyZ0ZZWmE2SjFRNThHL3dOTXVRRCtENVFFRE5xZndXVGZqUTI3bEM4?=
 =?utf-8?B?RVJPejVjNTJDQWhtWXZjQnVoSkNreXMwTGRuM1VLdFYwZ3pubHNPTHNqU21p?=
 =?utf-8?Q?l5y1IghIQ/Gpm8UtEmCPq9/ic?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b850dc0d-59d0-4987-5d00-08de3d9b7ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 18:38:32.3994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOz9zj6D4NYInuzEKCt9jxYlcIQFPr6i5QhiIPoL3L8jr0VD1Vmu63PfNc9plN4+wzge0+QmM2pa3QF0ri9PQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
Received-SPF: softfail client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDE3IERlY2VtYmVyIDIwMjUg
MTc6MzkNCj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsg
cWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogZXJp
Yy5hdWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRo
b3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5j
b20+OyBkZHV0aWxlQHJlZGhhdC5jb207DQo+IGJlcnJhbmdlQHJlZGhhdC5jb207IE5hdGhhbiBD
aGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMNCj4gPG1vY2hzQG52aWRpYS5jb20+
OyBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdr
dW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2Zl
aS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRl
bC5jb207DQo+IEtyaXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjYgMDUvMzNdIGh3L2FybS9zbW11djMtYWNjZWw6IEludHJvZHVjZSBzbW11
djMNCj4gYWNjZWwgZGV2aWNlDQo+IA0KDQpbLi4uXQ0KDQo+ID4+DQo+ID4+IEhhdmUgeW91IGNv
bnNpZGVyZWQgbW9kZWxpbmcgd2l0aCBhIFFPTSBvYmplY3QgaW5zdGVhZCA/DQo+ID4NCj4gPiBB
IGJpdCBvZiBoaXN0b3J5IG9uIHRoaXM6DQo+ID4NCj4gPiBUaGUgU01NVXYzIGFjY2VsIHN1cHBv
cnQgd2FzIGludHJvZHVjZWQgZmlyc3QgYXMgYSBzZXBhcmF0ZSBkZXZpY2UsDQo+ID4gLWRldmlj
ZSBhcm0tc21tdXYzLWFjY2VsDQo+ID4NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11
LWRldmVsLzIwMjUwMzExMTQxMDQ1LjY2NjIwLTQtDQo+IHNoYW1lZXJhbGkua29sb3RodW0udGhv
ZGlAaHVhd2VpLmNvbS8NCj4gPg0KPiA+IEhvd2V2ZXIsIHRoZSBnZW5lcmFsIGNvbnNlbnN1cyBh
dCB0aGF0IHRpbWUgd2FzIHRoYXQgd2Ugc2hvdWxkIGluc3RlYWQNCj4gPiBtb2RlbCBpdCBvbiB0
aGUgLWRldmljZSBhcm0tc21tdXYzIGl0c2VsZiwgd2l0aCBhbiBhZGRlZCAiYWNjZWwiIHByb3Bl
cnR5Lg0KPiA+DQo+ID4gRXJpYyBoYWQgYWxzbyBzdWdnZXN0ZWQgbWFraW5nIHVzZSBvZiBzb21l
dGhpbmcgc2ltaWxhciB0byB0aGUNCj4gPiBUWVBFX1ZGSU9fSU9NTVVfSU9NTVVGRCAvIExFR0FD
WSBjbGFzc2VzIGZvciBzZWxlY3RpbmcgdGhlDQo+IGlvbW11X29wcy4NCj4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9xZW11LWRldmVsLzExMDVkMTAwLWRkMWUtNGFjYS1iNTE4LQ0KPiA1MGY5
MDM5Njc0MTZAcmVkaGF0LmNvbS8NCj4gPg0KPiA+IEluIFJGQ3YzLCBJIGRpZCBpbnRyb2R1Y2Ug
YSBUWVBFX0FSTV9TTU1VVjNfQUNDRUwgb2JqZWN0IGNsYXNzLCBidXQgd2UNCj4gPiBsYXRlciBm
b3VuZCB0aGF0IGl0IHdhc27igJl0IGRvaW5nIG11Y2ggYmV5b25kIGhlbHBpbmcgdG8gcmV0cmll
dmUgdGhlDQo+IGlvbW11X29wcw0KPiA+IGJhc2VkIG9uIHRoZSBvYmplY3QgdHlwZSwgc28gZGVj
aWRlZCB0byBkcm9wIGl0Lg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwv
NzFjYTkxMzItOGRlYi00ZjU3LWFiYjAtDQo+IDJiY2MwZmU5M2FlOUByZWRoYXQuY29tLw0KPiA+
DQo+ID4gIEZyb20geW91ciBmZWVkYmFjaywgSSB1bmRlcnN0YW5kIHRoYXQgeW91IHdvdWxkIGxp
a2UgdG8gcmV2aXNpdCB0aGF0DQo+IGFwcHJvYWNoDQo+ID4gYWdhaW4uIEp1c3QgdG8gbWFrZSBz
dXJlIEkgZ2V0IHRoaXMgcmlnaHQsIGlzIHRoZSBTTU1VdjNBY2NlbENsYXNzIHlvdSBoYXZlDQo+
IGluDQo+ID4gbWluZCBtZWFudCB0byBiZSBhbiBhYnN0cmFjdCBvYmplY3QsIGxpa2UgSE9TVF9J
T01NVV9ERVZJQ0UsIG9yIGFyZQ0KPiA+IHlvdSBzdWdnZXN0aW5nIGFub3RoZXIgY2hpbGQgZGV2
aWNlIG9iamVjdD8NCj4gDQo+IEhPU1RfSU9NTVVfREVWSUNFIGFyZSBmb3IgaG9zdCBJT01NVSBi
YWNrZW5kcyAoVkZJTyBJT01NVSBUeXBlMQ0KPiBsZWdhY3kgYW5kIElPTU1VRkQpLiBJIHdhcyBp
bWFnaW5pbmcgYW4gImFybS1zbW11djMiIGNoaWxkcmVuIGNsYXNzDQo+IGZvciBhY2NlbGVyYXRp
b24uDQoNCk9rLiBBcyBtZW50aW9uZWQgYWJvdmUsIHRoZSBhY2NlbGVyYXRlZCBTTU1VdjMgaXMg
Y3VycmVudGx5IG5vdCBhIHNlcGFyYXRlDQpjaGlsZCBkZXZpY2Ugb2YgImFybS1zbW11djMiLiBJ
bnN0ZWFkLCBhY2NlbGVyYXRpb24gc3VwcG9ydCBpcyBlbmFibGVkIHZpYSB0aGUNCmFjY2VsIHBy
b3BlcnR5IG9uICJhcm0tc21tdXYzIi4NCg0KPiBJIHVuZGVyc3RhbmQgSSBhbSBqdW1waW5nIGEg
Yml0IGxhdGUgaW4gdGhlIGRpc2N1c3Npb24uIFNvcnJ5IGFib3V0DQo+IHRoYXQgYW5kIHRoZSBs
YXRlIHJlcGx5IGFsc28uDQo+IA0KPiBJIGhhdmUgYmVlbiBleHBlcmltZW50aW5nIHdpdGggeW91
ciBzZXJpZXMgb24gb3RoZXIgc3lzdGVtcyBhbmQgb24NCj4gYW4gQVJNIHN5c3RlbSB3aXRoIE1M
WDUgVkZzIGFuZCBhbiBMNCBHUFUuIEkgaGFkIHRvIGZha2UgQ0FOV0JTDQo+IHN1cHBvcnQgaW4g
dGhlIGhvc3Qga2VybmVsIHRvIG1ha2UgcHJvZ3Jlc3MuIE9uIGEgc2lkZSBub3RlLCBJIGFsc28N
Cj4gcHVsbGVkIGluIGEgcGF0Y2ggZnJvbSBOaWNvbGluIHRvIGFkZCBkbWFidWYgc3VwcG9ydCBh
bmQgaXQgc2VlbWVkDQo+IHRvIGJlaGF2ZSBvay4gVGhpcyB3b3VsZCByZXF1aXJlIG1vcmUgaW4t
ZGVwdGggUDJQIHRlc3RpbmcuIFRoYXQncw0KPiBhbm90aGVyIHRvcGljIHdlIHNob3VsZCBkaXNj
dXNzIGluIHRoZSBRRU1VIDExLjAgY3ljbGUuDQoNClRoYW5rcyBmb3IgZ2l2aW5nIHRoaXMgYSBz
cGluLiANCg0KPiANCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlcmUgaXMgYW4gZXhhbXBs
ZS9wcmVjZWRlbnQsIEkgY2FuIGxvb2sgYXQgZm9yIGENCj4gc2ltaWxhcg0KPiA+IG9iamVjdCBt
b2RlbCBpbiBRRU1VLg0KPiANCj4gTm93IHJlZ2FyZGluZyBtb2RlbGluZywgaXQgaXMgbW9yZSBv
ciBsZXNzIGEgZGVzaWduIGNob2ljZS4gQnV0IHdoaWxlDQo+IEkgc2Nhbm5lZCB0aHJvdWdoIHRo
ZSBjb2RlLCBJIGZlbHQgdGhlcmUgd2FzIHNvbWUgcHJvYmxlbXMgdGhhdCBjb3VsZA0KPiBiZSBz
b2x2ZWQgaW4gYSBjbGVhbmVyIHdheSB3aXRoIGEgc3ViIGNsYXNzLiBUaGUgY2hhbmdlcyBhcmUg
bW9zdGx5DQo+IGFib3V0IG1vdmluZyBjb2RlIGluIGRpZmZlcmVudCBwbGFjZXMgYW5kIGNoYW5n
aW5nL3JlbW92aW5nIHRoZQ0KPiAiaWYgKHMtPmFjY2VsKSBwYXJ0cyIuIERvbid0IGNoYW5nZSBl
dmVyeXRoaW5nIG5vdywgSSB3aWxsIGNoZWNrIFJGQ3YzLg0KDQpXaXRob3V0IGhhdmluZyBhIHBy
b3BlciBjaGlsZCBkZXZpY2Ugb2YgImFybS1zbW11djMiLCBpdCBpcyBub3QgY2xlYXIgdG8gbWUN
CmhvdyB3ZSBjYW4gYXZvaWQgdGhlICJpZiAocy0+YWNjZWwpIiBjaGVja3MuIFBsZWFzZSBsZXQg
bWUga25vdyBpZiB5b3UgaGF2ZQ0KYW55IHRob3VnaHRzIG9uIHRoaXMuDQogDQo+IE5ldmVydGhl
bGVzcywgdGhleSBhcmUgc2V2ZXJhbCBtb3JlIGlzc3VlcywgYnVpbGQgYnJlYWthZ2VzIGFuZCBh
bHNvDQo+IHJ1bnRpbWUgYnJlYWthZ2UgdGhhdCBzaG91bGQgYmUgYWRkcmVzc2VkLiBMZXQncyBk
byB0aGF0IGZpcnN0Lg0KDQpUaGUgYnVpbGQgYnJlYWthZ2UgeW91IHBvaW50ZWQgb3V0IGlzIHNv
bWV0aGluZyBJIG1pc3NlZCBkdXJpbmcgbXkNCnRlc3Rpbmcg4pi5LiBUaGUgc2FtZSBhcHBsaWVz
IHRvIHRoZSBHUFUgbWRldiBjb3JlIGR1bXAuIEhvcGVmdWxseSwgd2UNCmNhbiBhZGRyZXNzIHRo
ZXNlIHdpdGhvdXQgcmVxdWlyaW5nIG1ham9yIHJld29yay4NCg0KPiBGdXJ0aGVybW9yZSwgYW4g
KGlkZWFsaXN0aWMpIGRlc2lnbiBwcmluY2lwbGUgb2YgUUVNVSB0aGF0IHdlIHRlbmQgdG8NCj4g
Zm9yZ2V0IGlzIHRvIG9mZmVyIGFjY2VsZXJhdGlvbiB3aGVuIHBvc3NpYmxlIGFuZCBlbHNlIGZh
bGxiYWNrIHRvDQo+IGVtdWxhdGlvbiwgaW4gb3JkZXIgdG8gZ3VhcmFudGVlIHBhcml0eSBvZiBm
ZWF0dXJlcyBiZXR3ZWVuIGRpZmZlcmVudA0KPiBoYXJkd2FyZS4gSSBleHBlY3RlZCB0aGUgImFy
bS1zbW11djMiIGRldmljZSB0byBkZWNpZGUgdG8gb3BlcmF0ZSBpbg0KPiBhY2NlbGVyYXRlZCBt
b2RlIHdoZW4gZXZlciBwb3NzaWJsZSwgIGkuZSB3aGVuIHRoZSBJT01NVUZEIGJhY2tlbmQNCj4g
KHRoZSBTTU1VVjMgKyB0aGUgRlcpIG9mZmVycyB0aGUgcmlnaHQgbGV2ZWwgb2YgZnVuY3Rpb25h
bGl0eS4NCg0KQWNjZWxlcmF0ZWQgU01NVXYzIHN1cHBvcnQgb25seSBtYWtlcyBzZW5zZSBmb3Ig
dmZpbyBwY2kgcGFzcy10aHJvdWdoDQpkZXZpY2VzIHdoaWNoIHJlcXVpcmUgdGhlIG5lc3RlZCBz
dGFnZSBjb25maWd1cmF0aW9uLiBFbXVsYXRlZCBlbmRwb2ludA0KZGV2aWNlcyBhcmUgbm90IGFs
bG93ZWQgd2l0aCBhY2NlbCBTTU1VdjMuDQoNCiBUaGlzDQo+IHdvdWxkIGFsbG93IHRoZSBtYWNo
aW5lIHRvIG1haW50YWluIGEgY29uc3RhbnQgdmlldyBvZiB0aGUgc01NVXYzDQo+IGRldmljZSBh
bmQgZmFjaWxpdGF0ZSBpdHMgaW50ZWdyYXRpb24gd2l0aCBtYW5hZ2VtZW50IGxheWVycyBhbmQN
Cj4gZWFzZSBtaWdyYXRpb24gdG9vLg0KDQpUaGUgY3VycmVudCBtb2RlbCByZWxpZXMgb24gc3Bl
Y2lmeWluZyBhbiBhY2NlbGVyYXRlZCBTTU1VdjMgd2l0aCB0aGUNCmRlZmF1bHQgZmVhdHVyZXMg
b2YgImFybS1zbW11djMiLCBhbG9uZyB3aXRoIHVzZXItc3BlY2lmaWVkIG9wdGlvbmFsDQpmZWF0
dXJlcyB0aGF0IG1ha2Ugc2Vuc2UgZm9yIGFjY2VsZXJhdGVkIHVzZSBjYXNlcyAoZS5nLiBSSUws
IFBBU0lEKS4gVGhlDQppbXBsZW1lbnRhdGlvbiBwZXJmb3JtcyBhIGNvbXBhdGliaWxpdHkgY2hl
Y2sgYWdhaW5zdCB0aGUgaG9zdCBTTU1VdjMNCnRvIGVuc3VyZSB0aGUgcmVxdWVzdGVkIGNvbmZp
Z3VyYXRpb24gY2FuIGJlIHNhZmVseSBzdXBwb3J0ZWQgKHBhdGNoICMyMCkuDQoNCj4gSSB1bmRl
cnN0YW5kIHRoaXMgaXMgY29tcGxleCwgaXQgaGFzIGJlZW4gZG9uZSBmb3Igc29tZSBpbnRlcnJ1
cHQNCj4gY29udHJvbGxlcnMsIGFuZCB0aGlzIGlzIG5vdCB0aGUgYXBwcm9hY2ggb2YgdGhlIHNl
cmllcy4NCiANCj4gVGhhdCBzYWlkLCB3aGF0IGFib3V0IGludGVncmF0aW9uIHdpdGggbGlidmly
dCA/DQoNCk5hdGhhbiBoYXMgdGhpcyAiSW1wbGVtZW50IHN1cHBvcnQgZm9yIGlvbW11ZmQgYW5k
IG11bHRpcGxlIEhXLWFjY2VsDQp2U01NVXMiIGxpYnZpcnQgc2VyaWVzIGhlcmU6DQoNCmh0dHBz
Oi8vbGlzdHMubGlidmlydC5vcmcvYXJjaGl2ZXMvbGlzdC9kZXZlbEBsaXN0cy5saWJ2aXJ0Lm9y
Zy90aHJlYWQvRjRYSVVaQ0ROTVhHVzVXQko0N1ZMVlNaTUdYTzVCNkUvDQoNCkFuZCBJIGJlbGll
dmUgaGlzIHByZWN1cnNvciwg4oCcSW1wbGVtZW50IHN1cHBvcnQgZm9yIG11bHRpcGxlIGRldmlj
ZS1wbHVnZ2FibGUNClNNTVV2M3PigJ0sIGhhcyBhbHJlYWR5IGJlZW4gYXBwbGllZC4NCmh0dHBz
Oi8vbGlzdHMubGlidmlydC5vcmcvYXJjaGl2ZXMvbGlzdC9kZXZlbEBsaXN0cy5saWJ2aXJ0Lm9y
Zy90aHJlYWQvV09KS0RTM04yM042M1NNTURMTFRaSlJWWFdQSEs3RU0vDQoNClRoYW5rcywNClNo
YW1lZXINCg==

