Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10C7CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 09:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvXzC-0003FG-5E; Mon, 08 Sep 2025 05:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvXz6-0003El-JY; Mon, 08 Sep 2025 05:16:24 -0400
Received: from mail-bn8nam04on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2408::610]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvXyu-0001zn-Is; Mon, 08 Sep 2025 05:16:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEIfhw2O7BpIu1CjUDNkJx1Rsa1PI/8l2XIc51DK9K/nVElxeyZmRROsVv2hKwQuWaj2Rz67R8Q8tbobwxRUHLhQRaMrbxWvh/b7iA94mr/yuYoZ0TuWtOdidu6cubYd+/96LTDzJY/1Xf6GTyOfy3VMdui3lcPnyJKgYouEyAo2/9vNljUsHGFWHtV2FxOrkzW3YGoQFH1KINPuBTXIoB55nYDvVpf0hq4zmsKbFD6V34TXZJ2N+w8OZapJVWOQIXf2bhzuERTHMcmLEQagHcsOicNzXP3/wsgS8Q+m5pUUlLK75d3S/xFYX487pC7OgpX/3EndGXT8RchAFSYq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv8DQeep7rs36r9dPwD21iZC53ASq630RC6HdClpT0k=;
 b=E5zxfQdwpcwExUReX3prG20EXqp+6aTwaZAnxPDlm/ssCcpiandAIMBEwPGFq4mH5Wu/l8E1fh9QY+jOsHk6SB8zw8OXtyXAYcZ0b9On1U5OrRIhr+M3cjllyXhICSxRm32Zuj1tPfkoWxB54Mi36kPLBYX8218F9RwBJ57sfrCAEuOtHY0t9leHYXswQRh7m2DuYL4FMPNMGtuvFRRDP6CM5F+K0Qn6ABKWLwe6RzdtE2I8oQ2Kb4d6Zs3NAq0PNAdNYa6Axc+JDGIPj3Ds4iKmF92RJdh2clGYSYA7GHuszpO+MQ0LzfQnqxyqmB11xv8TZKGMCc+/JHbnhjx7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv8DQeep7rs36r9dPwD21iZC53ASq630RC6HdClpT0k=;
 b=HtJJ+eVZojzoLvwernPr+gJO4pFnvBOSp59f9TROboSjib4XNFUXt4YfzMhVODHiequsEZJpAECy2G5kZBCCLploQe4KvB08SEmK5xC4J1+LqEO609CTHCTQtjjgsZXnoGFMJ/zGDpOtviiKil/r+b/ik3AbWHl1+Vu1UyzBFdpaXmySFZxZiJ4+fIjseAeZp/ekt/GcvE1jTh4Eg8eBmUBz29L0WAJGpNpe4zSYveqYjl+dH5BJxUaEGvLz/zDEHFEd/ydEmM0Pv22bQMbngSRR+RPBAQkI7NxCoRznjmrCxI2adLUDd3r9z+nlcoG/s/Sh9du+Tgt0VB9UOkcBoA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 09:15:59 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%2]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 09:15:59 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: RE: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Topic: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Index: AQHcHajecGBvRYDlMUyaDHeRHM9GsLSEP0uQgAAiGICABKUk8A==
Date: Mon, 8 Sep 2025 09:15:59 +0000
Message-ID: <CH3PR12MB7548BB9816DABCED39BEB667AB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
 <aHU9INgBsFgvtec+@Asurada-Nvidia>
 <f0473156-2e59-4467-90cc-d8315cf9063e@redhat.com>
 <CH3PR12MB754884A2F1673D1424EE8378AB03A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <e2761aa2-1edf-42e9-97f6-e6bcedafd828@redhat.com>
In-Reply-To: <e2761aa2-1edf-42e9-97f6-e6bcedafd828@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS2PR12MB9798:EE_
x-ms-office365-filtering-correlation-id: 11ccd4a5-258f-4fc7-8599-08ddeeb8530b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?STdqckF1UnlNRERYOEJ1ZVY0OFMwOGprdnR3blMxeWYzaWZZYW1HTUsxVmJK?=
 =?utf-8?B?S0lVVlVhY0FwUzFQUjRuTHV1RU4rL2NpbEhVNFZ2ZXIxaWZ1SjI0V0tKM3Va?=
 =?utf-8?B?UWZVTUxVaWowTS9tbDZHU3BVdzY3UEtvZnVDWVhFSXVlZDBlSFBGZEFyR0Nu?=
 =?utf-8?B?SXhwK2U1cUQrMVFBYmhSMFRZTGhwY1hiU3JUR0JnY25TSVdjcGpFT2RSNWxP?=
 =?utf-8?B?em1SM0doaEpla1VZaXlHNUUzeWdjakNGWndtKzdmL25iNkIreEZqN3BIS0tw?=
 =?utf-8?B?MDdZRWpPRUg4MVRFOXNRM2xQaWlWa21sakkwa2ZadStJYnYzVHZJOGZud0M0?=
 =?utf-8?B?QWdpUERBQXh4Yi9VNHZ6VkhVL1ZXZDB3WkJUY291UVczSVljbHMyOG8vM2s5?=
 =?utf-8?B?QnFpSTRvRGZEM1FueDNxajBweVBBcWVoNzk5d1ZpZVhUdjJsNEJXYVQrN1p0?=
 =?utf-8?B?NlVkSjFDNU1YVGdsbFZRWXAyRmdXeTllc2tHL1lsVS9sczRRQ1hKc2ZOT29u?=
 =?utf-8?B?dmV0Y2d2bzJVV2dzLzFkYmJmTnpDWUNMcWc4RENRRGpTOWpmRlJaRzZDekxl?=
 =?utf-8?B?cDN1aVROT09waHVpa3RNVDJCV3JZd1BOMmYrKzZxd1hRN21BWE5pMjlxblR4?=
 =?utf-8?B?N01jdU5qbnhMMWJuWTc2TENCd2VGcjhQQXkraml5ZHFWSzduQnRYa1BtV3cx?=
 =?utf-8?B?UGxPQVRsY2VMcEdESkprVDR4YUM4RkZ6Tlhab29EZ201MHhXd1hNZ21JMDJl?=
 =?utf-8?B?dzc0MXF0VmdFTDNkWUIySVd0MThtV1g4R2JEeFB2MXJjc2tLaVM0c0tWV2E2?=
 =?utf-8?B?Q1pER2dUbXJpVmpqQWIwakg0Q1MxbURhOHFUamx6dU5vdFpROGFRaDFwSGhz?=
 =?utf-8?B?U0czMzdRdkNWM0ZxbjhHVGpTL295TkVpcGJ1WHJUYy9SZXFhUVRZSklwZE9H?=
 =?utf-8?B?WTh0Y2JTVEQ3RWhlc3pEOTVOS0ZDNW9OaStQTEhFRVQ3ZHRoa2VmTHVNTldn?=
 =?utf-8?B?QXcvdW9TRDlQbG5hanBOcjNYazU0TU45U3VzWWEzUzNLYVBnMG1vMFJuYkU0?=
 =?utf-8?B?bDhFUGMvSkJnajc1Y21wZW1KQ0srQjNRWjdsbldPell4N0lQS0t1VUtZT3pw?=
 =?utf-8?B?QlJhMkg3clJ5QW0wYkRoNE1IV2g2QzBvRmtmS2pwM1FOVStBbGxUdE9LQ1lj?=
 =?utf-8?B?WVpWbEZ6dkhiRWNSbjd5QTlaVWphMVRxS0EvRTRiS0grMmhqaFFjelNmV0ph?=
 =?utf-8?B?cEFlU3VQZTMyVFZsbFRocG01U3NYZ0dkdFpGa203SG5XWEJBVFdTYXRyNHBJ?=
 =?utf-8?B?UWFlQ3BaUVZJcjFxMGpMVkEvYnpBSDVDU1FvazJTQlMwOTB4VXhHQXZsVEdy?=
 =?utf-8?B?QmJMM0hnejgvNmZYUEgxTHBHVDlaMEJvRmtzK2NZQmlFRUZHSU00Rm5JQzZH?=
 =?utf-8?B?SjBCT0xXY2V4bnBsakVabTZmY0lzZjczb1N0M0xHT1lIVzlGM2hQK3Vkb0Y2?=
 =?utf-8?B?a1lZc2I2dGV4VHlxUFJ0TmM3Y3RjYk5MZHZ1WkVxTnl0UnU4ajhjL3hkaWN4?=
 =?utf-8?B?ZkNUK3VBcjlGQXpNL1EyME9KS1QxZnpzenFCemFjcEJRVWxnM2NaZWRDY0Fm?=
 =?utf-8?B?NWhwUDlQNXNORWFqd3JpVytZLzBTZHRJUmhkYW5YWHRESThqWUhxTTVMMjNo?=
 =?utf-8?B?Rm1UdDRHNXdrUVhmdUI4VGJGODIxRkVuNW5KMEF0aVE5c2FLQ0lDa0pmeHRL?=
 =?utf-8?B?YzBqWHJXUEM5dVAxZFlCby81WTRWSlVHMVNRakJhVWFLVGlqVFBqaGtlSmFo?=
 =?utf-8?B?cy9BWWkrMkMrNm1VanhaRmdDT2xLWjFKekkxQjIxYWw0QnBLbkZPNEQyMm8r?=
 =?utf-8?B?RFRISks2UHVCeXBTMUd5a3pESFN6ZUx3WFRXNms2MzFwNzUvV3NzbzJXZllU?=
 =?utf-8?B?T3FJT2o3Z0pjcUxBdENjdXFhc2NKS0VBaFZCdEd0SEc3T0doa0tBVVpnQmYy?=
 =?utf-8?B?bzByUkZLOVlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXVDdVMreGVlakZ4MCsvckU1SGhIdlZCd0dmRllLZkFMZDFSeGE0dzdhS2U2?=
 =?utf-8?B?Y1lBd211OFozVU1OeE5aTlIxL3YyOWxHbW9DSmkxQ3lzdytBbTFCcGpoeDgv?=
 =?utf-8?B?MmIwV0FGRlRWNFQ0Mm5PWHRDcnFFUFArMWU2Ni9TWWF5bHJHQUZNSm14blUz?=
 =?utf-8?B?R2hxQUlkMUF3MlFod1dCQXJNQTZZbDVDMk5ZZFY1L1ZJSUpLd203S09mcUdQ?=
 =?utf-8?B?Q1VJWHp0SlFNYlZnV0xjRWpYNjdDUjRFQm9tZ0dCSFJ4KzgxdDcvMzZ3ZEdy?=
 =?utf-8?B?M1ZkNjVQVkMwTXBSODhGUnduZDAxV1IyVU5HaHd2ejdKSnRZbTZIWFBzTUVV?=
 =?utf-8?B?OHdRMlVKc0tIN0NsSlNZOXN0c3YwZy8zR1ZacTNqcGx6dE42N1hkeW9FZFFo?=
 =?utf-8?B?VFo3eGJBUTFqK29qdlZEUytocjhMS1lsV1AwN3p4cUZRNXY0a000d1VGSWpz?=
 =?utf-8?B?S2ZMK3VoRkw5SnhSTUUveHVnQTNPQTZBSk1HNHltY2YzU3NhWUJuZUJXSE9F?=
 =?utf-8?B?cThoVWpzb3ZzNENiSU9OdXdLQ0ZseVZ0bnZqZzBlbDVYWmdHRnhzejNuZkNK?=
 =?utf-8?B?VUdvN3V2aUFVQ2FBRXE4Nlg4U2xRd3lKM0laeG1sSG56d09YU1BHb3R6R2U1?=
 =?utf-8?B?TVMzUWVORXVTR2llTHplZTkvcThUbUZ5cVZSUk9yTDRudFMrWEFpNjRzMXBE?=
 =?utf-8?B?M1JGMk1IdThFdXFMMG9OcEJkV1QzNS9MRERnT1dSUFRqYSt6bGlLQUhtU2lY?=
 =?utf-8?B?QmpzOVNYTmpHeHNpTzdhMm9xOWhDS1Y0SDcyY1Zod2lqWVJ1d0xLRnZURXVS?=
 =?utf-8?B?VXJidnJUd25XUGJJNHVPbHlhM1BicWQxUk80MFdockZ1N1plUE1LY0RXclg4?=
 =?utf-8?B?bnVWcjdnL29oYUgvVjZlTUlqM0p0NGZUcGJ4TEtXWDhkRkZLc3FRelUwb0JU?=
 =?utf-8?B?ekVvaU1EcElxUnhPZTVyZDF0dEpBakRJbWtxZlVkaVBUbE10LzlyTVZNOUdx?=
 =?utf-8?B?eEdsVDdzRDlSWEJDK1ZrSlhoaTZ1RndEN0FLS3hicUthb1UzQ1RIZkplSFNt?=
 =?utf-8?B?U0l4dEZDUnZ2NHU4cEpUZXE0WitITmttVFFwNEJrMlZhWEErLzg3b0diSHda?=
 =?utf-8?B?d0pxdUhUbmdCeTNubTdGN2UwRGF5bC9DQStiYmZzcGpmS0l5dWxRcHFldUZu?=
 =?utf-8?B?aTYvcHcrZmNIWjgrVDZGOWk3SEc2Wkg2NlJvOVhhZnhzVzV5RUlBbUlGa2ov?=
 =?utf-8?B?dVhGcEtwQ2ZrOHE2VnQxWEFCb1R3TTdqTHB2bFdzdWNCVE10bEdETURSK21r?=
 =?utf-8?B?Q2haU2RCZzBZSGxCb0gyTVA3UWx1Y214U3cwZExadFV4eHl1YW9xUHM0ditY?=
 =?utf-8?B?Qzd5UEJiaGlpc2h6OWVLUGxCWmJBdjVwQ2ZBd3ZFbDBNV2NWeWVuVTJzMW52?=
 =?utf-8?B?MGh0UXVNbWdyM2hGQm5ZVFRrWHpRSk5ZT2NmNGl2aitKSjhBL2pMVlBld0VF?=
 =?utf-8?B?NUNTWVk2Ymo1RGxmNm52SnBHaDJ6NHkwTUYvSjJ2Vjl5bWNBWGV1d01FejN1?=
 =?utf-8?B?ai8wY3NKOTBURjJQWDd3TTlvSFF0SWN4b2NrcFRmK3hyYUd4cTl0S1h2K09m?=
 =?utf-8?B?N2lOQUx5dnk1SDlHU0Y5OEFkZnQraVUyN295VGovSGtkT25hRFlrQXRDSGs5?=
 =?utf-8?B?WVJPNGp0NjVBVGMzQTREMGphNzcwRFZyd1FJV1NnRCtWbnl2TWFBdUgyZlM5?=
 =?utf-8?B?V2haNEpOVFVmbnJjZDBwZ0tHcmF1RCtHVzBWaER3alhwc2dSc0pqM2swQUxN?=
 =?utf-8?B?eXJ1ekpzN1ZuR1MrLzR2Ukx5QmkvSVc4SlRkQ2NFTG5vNE1uSUpnUFIzb3d4?=
 =?utf-8?B?dVZMelpTb0l0dDVxVFpLNW1ZcDNDZTVKZ1Boa0Q5ZjNJSUkrVmRMN1NsVnRE?=
 =?utf-8?B?bGhyOTZCL2Z3TUo1SzEwZ282c2tqc1dWV2g5TnhDNm00akRublB5Zm1JU0Zz?=
 =?utf-8?B?MFZtcnJHVnQzemFVR3oxRkgzSmIxUTE2OGczcEJEWmFaM29uTm9GTXB3TFpS?=
 =?utf-8?B?bnd5cnRKeXpIQWEraWhnbmMwQlI4TEFnWGYwVlQzWG05V3p4S0kvUkNBelZH?=
 =?utf-8?Q?JE8TqqZPhXAEtMjhV1hoSZNn7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ccd4a5-258f-4fc7-8599-08ddeeb8530b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 09:15:59.0891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KT8bO5f3Jiwoc4ZwMM3M1hJE0//dRl1TiFNwzxiaRo4YTnYB97gaWyTU0cNXoOxYqa3/61y8fOBCPSfrXDuQ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798
Received-SPF: permerror client-ip=2a01:111:f403:2408::610;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=2.131, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNSBTZXB0ZW1iZXIgMjAyNSAxMToxOA0KPiBU
bzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBOaWNvbGluIENo
ZW4NCj4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBx
ZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgSmFzb24g
R3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47DQo+IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFu
Z2VAcmVkaGF0LmNvbTsgTmF0aGFuIENoZW4NCj4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQg
T2NocyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IGxpbnV4YXJt
QGh1YXdlaS5jb207IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3
ZWkuY29tOyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5h
cm8ub3JnOyB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBnbWFp
bC5jb207IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gU3Vi
amVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMDUvMTVdIGh3L2FybS9zbW11djMtYWNjZWw6IEludHJv
ZHVjZQ0KPiBzbW11djMgYWNjZWwgZGV2aWNlDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDkvNS8yNSAx
MDoyMiBBTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5j
b20+DQo+ID4+IFNlbnQ6IDA0IFNlcHRlbWJlciAyMDI1IDE1OjMzDQo+ID4+IFRvOiBOaWNvbGlu
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBTaGFtZWVyIEtvbG90aHVtDQo+ID4+IDxza29s
b3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPj4gQ2M6IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZzsNCj4gPj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBH
dW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsNCj4gPj4gZGR1dGlsZUByZWRoYXQuY29tOyBiZXJy
YW5nZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbg0KPiA+PiA8bmF0aGFuY0BudmlkaWEuY29tPjsg
TWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsNCj4gPj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsg
bGludXhhcm1AaHVhd2VpLmNvbTsNCj4gd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+ID4+IGpp
YW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gPj4g
emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsNCj4gPj4g
c2hhbWVlcmtvbG90aHVtQGdtYWlsLmNvbQ0KPiA+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2
MyAwNS8xNV0gaHcvYXJtL3NtbXV2My1hY2NlbDogSW50cm9kdWNlDQo+ID4+IHNtbXV2MyBhY2Nl
bCBkZXZpY2UNCj4gPj4NCj4gPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcg
bGlua3Mgb3IgYXR0YWNobWVudHMNCj4gPj4NCj4gPj4NCj4gPj4gT24gNy8xNC8yNSA3OjIzIFBN
LCBOaWNvbGluIENoZW4gd3JvdGU6DQo+ID4+PiBPbiBNb24sIEp1bCAxNCwgMjAyNSBhdCAwNDo1
OTozMVBNICswMTAwLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+Pj4+IEFsc28gc2V0dXAg
c3BlY2lmaWMgUENJSU9NTVVPcHMgZm9yIGFjY2VsIFNNTVV2MyBhcyBhY2NlbA0KPiA+Pj4+IFNN
TVV2MyB3aWxsIGhhdmUgZGlmZmVyZW50IGhhbmRsaW5nIGZvciB0aG9zZSBvcHMgY2FsbGJhY2tz
IGluDQo+ID4+Pj4gc3Vic2VxdWVudCBwYXRjaGVzLg0KPiA+Pj4+DQo+ID4+Pj4gVGhlICJhY2Nl
bCIgcHJvcGVydHkgaXMgbm90IHlldCBhZGRlZCwgc28gdXNlcnMgY2Fubm90IHNldCBpdCBhdA0K
PiA+Pj4+IHRoaXMgcG9pbnQuIEl0IHdpbGwgYmUgaW50cm9kdWNlZCBpbiBhIHN1YnNlcXVlbnQg
cGF0Y2ggb25jZSB0aGUNCj4gPj4+PiBuZWNlc3Nhcnkgc3VwcG9ydCBpcyBpbiBwbGFjZS4NCj4g
Pj4+Pg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0NCj4gPj4+PiA8c2hh
bWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+Pj4gT3ZlcmFsbCB0aGUgcGF0
Y2ggbG9va3MgZ29vZCB0byBtZSwNCj4gPj4+IFJldmlld2VkLWJ5OiBOaWNvbGluIENoZW4gPG5p
Y29saW5jQG52aWRpYS5jb20+DQo+ID4+Pg0KPiA+Pj4gd2l0aCBzb21lIG5pdHM6DQo+ID4+Pg0K
PiA+Pj4+IEBAIC02MSw3ICs2MSw4IEBAIGFybV9jb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdf
QVJNU1NFJywNCj4gPj4gaWZfdHJ1ZToNCj4gPj4+PiBmaWxlcygnYXJtc3NlLmMnKSkNCj4gPj4+
PiAgYXJtX2NvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19GU0xfSU1YNycsIGlmX3RydWU6DQo+
ID4+Pj4gZmlsZXMoJ2ZzbC1pbXg3LmMnLCAnbWNpbXg3ZC1zYWJyZS5jJykpDQo+ID4+Pj4gIGFy
bV9jb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfRlNMX0lNWDhNUCcsIGlmX3RydWU6DQo+ID4+
Pj4gZmlsZXMoJ2ZzbC1pbXg4bXAuYycpKQ0KPiA+Pj4+ICBhcm1fY29tbW9uX3NzLmFkZCh3aGVu
OiAnQ09ORklHX0ZTTF9JTVg4TVBfRVZLJywgaWZfdHJ1ZToNCj4gPj4+PiBmaWxlcygnaW14OG1w
LWV2ay5jJykpDQo+ID4+Pj4gLWFybV9jb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfQVJNX1NN
TVVWMycsIGlmX3RydWU6DQo+ID4+Pj4gZmlsZXMoJ3NtbXV2My5jJykpDQo+ID4+Pj4gK2FybV9z
cy5hZGQod2hlbjogJ0NPTkZJR19BUk1fU01NVVYzJywgaWZfdHJ1ZToNCj4gZmlsZXMoJ3NtbXV2
My5jJykpDQo+ID4+Pj4gK2FybV9zcy5hZGQod2hlbjogWydDT05GSUdfQVJNX1NNTVVWMycsICdD
T05GSUdfSU9NTVVGRCddLA0KPiA+PiBpZl90cnVlOg0KPiA+Pj4+ICtmaWxlcygnc21tdXYzLWFj
Y2VsLmMnKSkNCj4gPj4+IFdvbmRlcmluZyB3aHkgImFybV9jb21tb25fc3MiIGlzIGNoYW5nZWQg
dG8gImFybV9zcyI/DQo+ID4+IEluZGVlZCB3aHkgZGlkIHlvdSBuZWVkIHRvIGNoYW5nZSB0aGF0
Pw0KPiA+IFRoYW5rcyBmb3IgZ29pbmcgdGhyb3VnaCB0aGUgc2VyaWVzLiBJIHdpbGwgZ28gdGhy
b3VnaCBhbGwgdGhlDQo+ID4gY29tbWVudHMgYW5kIHJld29yayB0aGUgc2VyaWVzIHNvb24sIGJ1
dCBhIHF1aWNrIG9uZSBvbiB0aGUgYWJvdmUNCj4gcXVlc3Rpb24uDQo+ID4NCj4gPiBJIHdhcyBn
ZXR0aW5nIHRoaXMgY29tcGlsZSBlcnJvciBhcyBub3cgd2UgdXNlICNpbmNsdWRlIENPTkZJR19E
RVZJQ0VTDQo+ID4gdG8gY2hlY2sgQ09ORklHX0lPTU1VRkQNCj4gPg0KPiA+IC5kIC1vIGxpYnN5
c3RlbV9hcm0uYS5wL2h3X2FybV9zbW11djMuYy5vIC1jIC4uL2h3L2FybS9zbW11djMuYyBJbg0K
PiA+IGZpbGUgaW5jbHVkZWQgZnJvbSAuLi9ody9hcm0vc21tdXYzLmM6MzU6DQo+ID4gLi4vaHcv
YXJtL3NtbXV2My1hY2NlbC5oOjE3OjEwOiBlcnJvcjogI2luY2x1ZGUgZXhwZWN0cyAiRklMRU5B
TUUiIG9yDQo+IDxGSUxFTkFNRT4NCj4gPiAgICAxNyB8ICNpbmNsdWRlIENPTkZJR19ERVZJQ0VT
DQo+ID4gICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+fg0KPiA+IC4uL2h3L2FybS9zbW11
djMtYWNjZWwuaDo1NToxMzogZXJyb3I6IGF0dGVtcHQgdG8gdXNlIHBvaXNvbmVkDQo+ICJDT05G
SUdfQVJNX1NNTVVWMyINCj4gPiAgICA1NSB8ICNpZiBkZWZpbmVkKENPTkZJR19BUk1fU01NVVYz
KSAmJg0KPiBkZWZpbmVkKENPTkZJR19JT01NVUZEKQ0KPiA+ICAgICAgIHwgICAgICAgICAgICAg
Xg0KPiA+IC4uL2h3L2FybS9zbW11djMtYWNjZWwuaDo1NTo0MzogZXJyb3I6IGF0dGVtcHQgdG8g
dXNlIHBvaXNvbmVkDQo+ICJDT05GSUdfSU9NTVVGRCINCj4gPiAgICA1NSB8ICNpZiBkZWZpbmVk
KENPTkZJR19BUk1fU01NVVYzKSAmJg0KPiBkZWZpbmVkKENPTkZJR19JT01NVUZEKQ0KPiA+ICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiA+IG5p
bmphOiBidWlsZCBzdG9wcGVkOiBzdWJjb21tYW5kIGZhaWxlZC4NCj4gPiBtYWtlWzFdOiAqKiog
W01ha2VmaWxlOjE2ODogcnVuLW5pbmphXSBFcnJvciAxDQo+ID4gbWFrZVsxXTogTGVhdmluZyBk
aXJlY3RvcnkgJy9yb290L3FlbXUtaGlzaS9idWlsZCcNCj4gPg0KPiA+IEFuZCB3aXRoIGFybV9j
b21tb25fc3MuYWRkLCBpdCBsb29rcyBsaWtlIHRoZSBjb21waWxlciBpcyBtaXNzaW5nDQo+ID4g
Jy1EQ09ORklHX0RFVklDRVM9ImFhcmNoNjQtc29mdG1tdS1jb25maWctZGV2aWNlcy5oIicuDQo+
IEkgZ3Vlc3MgdGhpcyBpcyBiZWNhdXNlIGRldmljZXMgYXJlIGFyY2ggc3BlY2lmaWMgc28gaXQg
Y2Fubm90IGJlICJjb21tb24iDQo+IGFueW1vcmUuIExvb2tzIHNlbnNpYmxlIHRvIG1lLiBBZGRp
bmcgUGhpbGlwcGUgaW4gdGhlIGxvb3AuDQo+IA0KPiBVbnJlbGF0ZWQgdG8gdGhhdCwgZG8geW91
IGhhdmUgYSB3YXkgdG8gb3B0LW91dCBTTU1VdjMgSFcgYWNjZWxlcmF0aW9uLg0KPiBTb21lIHBl
b3BsZSBtaWdodCBub3QgYmUgaW50ZXJlc3RlZCBpbiB0aGF0IGZlYXR1cmUuDQoNCllvdSBtZWFu
IGEgY29uZmlnIG9wdGlvbiBsaWtlIEFSTV9TTU1VVjNfQUNDRUwgdG8gb3B0IG91dCBkdXJpbmcg
Y29tcGlsZT8NCkNhbiBkby4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQoNCg==

