Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9E4CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 18:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEAml-0003ss-8i; Wed, 29 Oct 2025 14:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEAme-0003qv-KE; Wed, 29 Oct 2025 14:20:33 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEAmU-0001lX-UC; Wed, 29 Oct 2025 14:20:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xh0slCVOtWZR16MOjTfr66BaAAcOwQVMMKe+zM7x/eLalWUisuSmS9B7tJYnY+P76rdkeQ6kcYRTEGa87iECIApwtJBfl3m2C2/jfV83QlgpGp+HpZcSsh2tPVxZF6aDzW1eNQXUBlI11REGbaJPG2l/+7Yb8oP2hLNzbR2641I9vSPxEZiecY0NSIyH+Aepg7IS1SCOe9NWbX5SiUUsktj02WZUf851EnjnkHjP2TQ4da07Sd0dz6q0x96GvrBqqOjfOcN4Vepf4CsdQMmyclnyNieyw9G/zkz5ifIiBT7Nwtewe4+c8w0uTTfpEAQwZ8uAwJB3nHZysJPYmHOq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAUJQ4uMyiOTRh09y1bzTCtbqK1vmBfR/0GnZ2QP1kg=;
 b=kSDm913fk7E2vkBz5ovsl7ZLxJgcQbCNCB8cArb3bec4hUUadZhU0iegymn4VuCbQaPGbU0A6RvmV8Z8YMPDlrPShGxPg5ZOKOeWnqriHQwn6zFqIP0HBrmHo+5BuzQGyTS5emrS0P5siGdHdjaidz2gceZp730vb4lbLvarEaZqi3yPH61h+zFI3FmKUtFI5fZi9ViaeD0FfnCrsiz+WYA4CE3sIRN1kXkjYV5QY/WN267S2iP7VRGqk+JlHcPG63Ld6Gs4ER3dEydk/dCBKj4FkV0PrvJnoPitKRGuWdOxK90OpH0PPd5B4XqJt99ePYSv3rE3VxF2J54wZT0Npg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAUJQ4uMyiOTRh09y1bzTCtbqK1vmBfR/0GnZ2QP1kg=;
 b=Pz+5/zrvLzZyDi0Jm5Z881Wdfgf6mrP+8M5M0EkDzVjyhyrBUJvT6yPdtzGjecuLoQ2uJSfa0B6PvR/hWLdknV1M7e5DrK0sHf1dpVqL4ZaTRspH1CLKOIa+Rdb6NtF2bzGSgIH3axq9DhpSrh0NUo8eIIC2Cry3huuNE6lqdchDh3s0F2zZHk+zSml80ty+UELbu0u5ZjbTPnuwd3P79wcQjB2anDoBdZ5Kkpnel6xnxy7OnWpk2KFcnJqBGccAQcv4gSYNrG9enbsg9YjOTvAl50DMQy3FJ3l/Y8USONx47IFMDrrZZWhGfDT7p4MrSCBTvlV4H2oUt8RFyHqjBA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 18:19:59 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 18:19:59 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Thread-Topic: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Thread-Index: AQHcPvNf8cNe0zISsE6Kcr2+CesP+rTWHWaAgAAEKcCAAnkGgIAA30qw
Date: Wed, 29 Oct 2025 18:19:59 +0000
Message-ID: <CH3PR12MB7548FB14A0D0F08688DE9CCDABFAA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-20-skolothumtho@nvidia.com>
 <aPF9l5GwctGN0tqT@Asurada-Nvidia>
 <76ce5b05-98fe-4682-a5ca-2f87b7535f35@redhat.com>
 <CH3PR12MB75480062975BA40AD454742CABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQGXibWAiMpXAQlF@Asurada-Nvidia>
In-Reply-To: <aQGXibWAiMpXAQlF@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY5PR12MB6275:EE_
x-ms-office365-filtering-correlation-id: 9a15092b-fac4-4b49-dcbb-08de1717c521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?OEpZSXUvQ2x3dzUzT0RBUER5eE1ZbzgvamtEZlA5SlNWZm9KN1BNeTluYldE?=
 =?utf-8?B?ZHpPWERnQUhJL0FnNU1OSmsyZytDd0pYc1BPOWdsa1diN3NyaTY0Q0daYUxS?=
 =?utf-8?B?OWprbWdVM0FjZ3hJYlljVlBySlorUDJKWjZEalhKNVlsK09YV3dZc0hIWWJZ?=
 =?utf-8?B?cml5MGNCOXBMZjFlY3lLamZjVDFOQU5wU3ZiVGdRbTVLM0diSEdaRzMyY0Ny?=
 =?utf-8?B?eXlDQm8yRWhZQ3hqQk9iT1BNT3FqK2c5bmEzaHpLYlgyYlpzZ1dUbkFEbjlx?=
 =?utf-8?B?QW1qekJCOXNwcm1jN3RBRHkzYVJHWG5DV3dmZUtNdXNuWDNCRFhoRW00cXUw?=
 =?utf-8?B?ZnB3eE00MXpVaEFmazlFc2dwd1NHRWtaVjhvNmpYRlFYeElKQlBYek1oOW5y?=
 =?utf-8?B?YkJpOXNTdHZ4akYyRTdKMDRkb0hLQjVaY01NVVRBZyt3YkdJb2QzWWY2d29s?=
 =?utf-8?B?cG5QalV2VDBkaXFJTEozc3RYU3NYZ2NHY1lFbWZoR1hUUFZud3pORnZod2FH?=
 =?utf-8?B?emI1L0FaNHpSMWh1L2VsQzZ1Y0lTcG1FRVRleG41dEh4RzRSU1FNODVnWUE3?=
 =?utf-8?B?cnlwOTYwLzdLL1B5OUY1Z0graXBuZWFjbHRZMytMSFFPVjJjQWNUUFVkNjI5?=
 =?utf-8?B?UFVGYlVXSGV3cHdrY0ZhSXpMNThiZmRGNDZKVWpMcnZwL3lJV3NBelRSTTdk?=
 =?utf-8?B?RmZBaERlOUczRDJ1aDZ1NGw2UjI5MnRGSnJvUzUydElMNXBxNURwdnJIKzl5?=
 =?utf-8?B?bm5DaWtUMlNPYkRtQzEwamgwNEJxbEg0Skw4dDArNzVxYnVzVWNRd0puTXFh?=
 =?utf-8?B?V1Q1N1p6M2JUNVBRMzRCckNQQ2hlc0U4VkYvRnBrRTdtWVZWSVBRU29VS05I?=
 =?utf-8?B?bisrU0srSW9hWEhZcitMbWVPN0xOc091VlFKSGJyb1JYNE1TZURFQTVWdzhp?=
 =?utf-8?B?aGVQWkpSYVlaSldVR2ZOZFd0VjZ0aGtFK0trVXBxU2VUckl6MUtFSGFjRldX?=
 =?utf-8?B?aC9xZktLQ3I5UThKK1lXK050aUI5TnBzT2VYb3BzVDJJbkJvVmV1aEFIWjlP?=
 =?utf-8?B?TVlocndmWVVta1owa0RPbFBBVFlTNE5hRVJBRlBJT3hVQkpUUm11Y2pEUEF6?=
 =?utf-8?B?SlQ3ZkVTblJwRXJZa3lMS1g1akgvZGZ3UmRYLzg1SzZQeTJvblFEc2w0bW05?=
 =?utf-8?B?NHNKeXF4VXdDcjlpd1pzenRnMEtHbjR5ZzJKMFRiaSsvc1c1ZGxIdERvRVZC?=
 =?utf-8?B?bzBCcDM4SGcyQXlSbGxNNUpFamErM0VhSEM0S1o1K3JKeURuTjdsdjIvNEVn?=
 =?utf-8?B?VUs4bHFlM2x1aTJoRWE4UElxUWNDRzhWVUcraGNUZ0M1dUZkN0JDeS9rdDg2?=
 =?utf-8?B?T2dwaUNrZTI3Vnh1b2RMMUp2ajhvem0za1ZKSkppbUJ3akZwUTk4Z1hQZ3BZ?=
 =?utf-8?B?ei9BdXNXRzcxenJ2SlAwWFdNdWVOTkN1NEwxV3Q4MzBTWnRaSjArK1F1VHpM?=
 =?utf-8?B?bk4velJZREZLalcyaWZaaTBNRkRTd0h0cE9VejRidDNva1J5bmZuMnV3Z09a?=
 =?utf-8?B?VXk2QXZQdWlPTVU2S3FBRURlNlpUa0JOMG9HVFZHUFcyQjVPLzNyREE5WExv?=
 =?utf-8?B?eTlqMzdNTHJxT0NGMTFBUHdaNkFmWmdqVmJlTVJHcDhIRG9HblhIWnBVT0NC?=
 =?utf-8?B?OGhCek1sNk9MakpwcTJPNDhLQjA3L0VWTklZQlhHQU5ITFlnUXJPRFVoRTYr?=
 =?utf-8?B?SmFvaVZDM09KMEs3NXdwNEQwSnh5NWVMaFhlZ0MyT0FnMDdlU2Y0blZrSTVU?=
 =?utf-8?B?c3hEQ25XcTlHWjEvbHRGaWU3WExoRUZLemxodHNwdHlQaHV0WnVFRWlIZ2p3?=
 =?utf-8?B?ckwrYzl5TnNIc3d5Zmw0dEI1TEJvTk9Va2FjWTRndCtvbkJQM25XK01qVUVC?=
 =?utf-8?B?TTZBMi9scE9mczlMSXFGU3JKcFVXRTFwTHczSEJZTFVncjJEWlF3Rmc1YmFr?=
 =?utf-8?B?Q3BpWkpmdmIxeU9zaVZ1UzgvWDFLcnVGdTFidll4VEtzY3EyaUJ4UGNjcnNl?=
 =?utf-8?Q?x0OxkW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU9LcGFjTEJQcWIzN1J1aFdYdHlzcU1vOFJ6MUpGYXdyZ2tjT0lyQmpPVWdq?=
 =?utf-8?B?TjdhbkNlbUpCd2FOa2xNUjdleXRLVlJja3RNeVNRWklhUGFpNit2NllDemZX?=
 =?utf-8?B?MS9OalNDSlJsbU9KY1paSk0valVJRmNBMnhHak01dTFkVVcxcjRyS3VhUDI2?=
 =?utf-8?B?MFlyenI1Z1Rja0R2SVlQdFVtOGk2WU0wR1I1TnFQTlNNL1ZKWlpHYi9MYmVm?=
 =?utf-8?B?SlZka0xJMkkrSlpKcEpkRnVmM1FzRjBhM3lFQTdwcUprZ2lqMncrTHFPZFE5?=
 =?utf-8?B?YlJNU3FGRC9jYkx3c09DakdPK1VBU000T3JaUHN5NFQxZVZoOC9oQ1ZtMnZt?=
 =?utf-8?B?Y3dnWHRUVDhqbU9VN1NiMUhzcFZLNnhaaUZDcis1UkdjanR5SDR5OHBmNnJ4?=
 =?utf-8?B?NW1EVVYvcjh5MVlkRUhvb3RDZ0tVVGRmZlBTUWxzM2U5aXZFRFFmZmlrMG1C?=
 =?utf-8?B?OTNKVEptRUQyNmo0ckdaRWZZY3MxVERMK1FhbDRva2k5QjJ6RUdQcnNkSmFM?=
 =?utf-8?B?WFBWZ2NxbTlKbFVrK3hEN2FtZE9FcTMrK1ZjRlcxVUNUMC9tWTRZNS90c3Y0?=
 =?utf-8?B?UFQyOTF0L1B0d0pkaklQcHN0VXkzY0dyenBGYjdXd2FhL3RLYWZHMFpiRW1z?=
 =?utf-8?B?T29XRStIay92OWs0RjVoRjlaa3B3THk3R0QrNFlFc2JyTXpYNW1Ra1hRdFA1?=
 =?utf-8?B?ZEd3OWlCZlNwM1FESk4vSDdBdm1ua1ZZd01OTDAza0Mwa1h4Zk05UmhFc2RY?=
 =?utf-8?B?QXdXc0diTllsejg1SXNCN3IwdWh6Q3B0UXVsWUc1KzAySEEyeUZtYndYSWxJ?=
 =?utf-8?B?U29BdXprU1czNGU3dFhLaDhRU2NRM2JxT2V2MnZRMnRONkpPOUJyWFJ4UXBn?=
 =?utf-8?B?L0xjUk9hTjQrM1phVEFidzk5RGNuZ1VwSno2SHVMSWlsSE1RMnRyMzZUdGxL?=
 =?utf-8?B?bDExYjU5d21tZmNaK2VxOVVTbEN5RnN4R2x5bTNmSVdFVlpvMnRvYnlDVUph?=
 =?utf-8?B?cEhZRGwwVXhEMjhIbTBZaVA3dlFqTjJrRmpqZnFqK3AvdGRzaXZUTGdsMEJ6?=
 =?utf-8?B?UUtqSkg5R1FhV2d5L1hRZ1V0cmpGMHY5VnkxcnJ0VnAwQzN6YUM4MGxWcE9B?=
 =?utf-8?B?enhOVnBvc1lzWFl5dnYxWDVJVUE5bzhTWldPeGlkTEpwVDBwQnAyMjN4ZThW?=
 =?utf-8?B?Rml5TGE5MXgySHlwYnhKVnpsYzQ0VzhCV1c3Njg4dEl0cjg4M2MvbFV3S0cv?=
 =?utf-8?B?TzJqL3htNTEzRUY5MzE5bU93dC9lWU9Ma2R5ZStjNXBlS1R3L1hQb2h1N0I5?=
 =?utf-8?B?dEU1bUhNc1lYbDZTL0ptVUZqQnVsVUJ4R1B6VDYyQktSRVpYc0lNczNUQTRG?=
 =?utf-8?B?NE9HSnVEVnFkZkFMT0QxRitWSWtRaXFQakNwNU9qUFc0bWgrVGV4UzNsZHhZ?=
 =?utf-8?B?elM5dklzNVpuendTeGtrV01WV0ZQeFhhMG1GdXBMTXhlUCtiWkVPdlZ5bjZS?=
 =?utf-8?B?UG1TQ1kvM0g5Y1JJZERIekFMa3FUcWhnUHF1RjJiV2k4ZWZ4TnlGU3E3RnFw?=
 =?utf-8?B?eU5FQnhNeGR3U2NyZXdkeFdYdnRaclIxWDgwZUlDZjlZQkUrTFVjTHBwK2tR?=
 =?utf-8?B?Q1lKTnVuMzhuYjJCakJrNjB5MElGMGhwdVBJTXh2M2Y0enVVTndDbzI1WXha?=
 =?utf-8?B?RHZDQkRqTVZ4elJZZFNRNzEyQ25KTlJIbDNSN2JTdmJxNVM1NDV0L0hVcnMr?=
 =?utf-8?B?VEJiZmVqQkx3UTdiRm9rUVNveHF4NGhlT2dTd3RKaURlUkE0K0V5L0RubmJ1?=
 =?utf-8?B?VFRRUWxRNy9nV1REZHJmM3dUbVVZK002QnhNNVh4RzRGTHhCU2FRbk9ZNjc4?=
 =?utf-8?B?Z1Z4UW50VzZzNmkzOW5BaVA2NXpWL1MyOVJCOEw2ekljL0o4WW5XbWhqWFBk?=
 =?utf-8?B?Y1RPdEszMVpyNEVrVGtHcEdKaDRlQ2Qya2VuRWg0NnB6dERVclFPSCtyZHR3?=
 =?utf-8?B?REhicjFzT3cyWW5LcDhRY1lIK0c2V1ZVbEVWcUdxNnNLN1ByVGRLdGNjdmdN?=
 =?utf-8?B?ckZEZWxoVnBxdzhEL3RSV2VwRUFURlpDcDRMUzVvS2ZZdDdXRFQyNkJRMFJE?=
 =?utf-8?Q?UMUUoJ1JUxqrPpyGhZSNOSHno?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a15092b-fac4-4b49-dcbb-08de1717c521
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 18:19:59.2078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PE+kKYdXisdJQBiXFbQmJzSIlT6CzlJYi8L0Rv9B7NSvEcVW8Dr8UHZzXrlm91+Nwd94fogrsn+pQxMuTftXMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiBTZW50OiAyOSBPY3RvYmVyIDIwMjUgMDQ6MjcNCj4gVG86
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzogZXJpYy5h
dWdlckByZWRoYXQuY29tOyBxZW11LWFybUBub25nbnUub3JnOyBxZW11LQ0KPiBkZXZlbEBub25n
bnUub3JnOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZQ0KPiA8amdn
QG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5jb207IE5h
dGhhbg0KPiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRp
YS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsN
Cj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0K
PiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyB5aS5s
LmxpdUBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBnbWFpbC5jb20NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NCAxOS8yN10gaHcvYXJtL3NtbXV2My1hY2NlbDogSW5zdGFsbCBTMSBieXBh
c3MgaHdwdA0KPiBvbiByZXNldA0KPiANCj4gT24gTW9uLCBPY3QgMjcsIDIwMjUgYXQgMDc6NTE6
MTVBTSAtMDcwMCwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiA+IE9uIDEwLzE3LzI1IDE6
MTkgQU0sIE5pY29saW4gQ2hlbiB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCBTZXAgMjksIDIwMjUg
YXQgMDI6MzY6MzVQTSArMDEwMCwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiA+ID4+IFdo
ZW4gdGhlIGd1ZXN0IHJlYm9vdHMgd2l0aCBkZXZpY2VzIGluIG5lc3RlZCBtb2RlIChTMSArIFMy
KSwgYW55DQo+ID4gPiBRRU1VL1VFRkkNCj4gPiA+ID4+IGFjY2VzcyB0byB0aG9zZSBkZXZpY2Vz
IGNhbiBmYWlsIGJlY2F1c2UgUzEgdHJhbnNsYXRpb24gaXMgbm90IHZhbGlkIGR1cmluZw0KPiA+
ID4gPj4gdGhlIHJlYm9vdC4gRm9yIGV4YW1wbGUsIGEgcGFzc3Rocm91Z2ggTlZNZSBkZXZpY2Ug
bWF5IGhvbGQgR1JVQg0KPiBib290DQo+ID4gPiBpbmZvDQo+ID4gPiA+PiB0aGF0IFVFRkkgdHJp
ZXMgdG8gcmVhZCBkdXJpbmcgdGhlIHJlYm9vdC4NCj4gPiA+ID4+DQo+ID4gPiA+PiBTZXQgUzEg
dG8gYnlwYXNzIG1vZGUgZHVyaW5nIHJlc2V0IHRvIGF2b2lkIHN1Y2ggZmFpbHVyZXMuDQo+ID4g
PiA+IEdCUEEgaXMgc2V0IHRvIGJ5cGFzcyBvbiByZXNldCBzbyBJIHRoaW5rIGl0J3MgZmluZS4g
WWV0LCBtYXliZSB0aGUNCj4gPiA+ID4gY29kZSBzaG91bGQgY2hlY2sgdGhhdC4NCj4gPiA+DQo+
ID4gPiBzaG91bGRuJ3Qgd2UgY2hlY2sgaXRzIGFjdHVhbCB2YWx1ZSBiZWZvcmUgc2V0dGluZyBi
eXBhc3M/DQo+ID4gPg0KPiA+ID4gQnkgdGhlIHdheSB0aGUgc3BlYyBzYXlzIGlzIEFCT1JUIGlz
IHNldCB0byAweDA6DQo+ID4gPiAiRG8gbm90IGFib3J0IGluY29taW5nIHRyYW5zYWN0aW9ucy4g
VHJhbnNhY3Rpb25zIGJ5cGFzcyB0aGUgU01NVSB3aXRoDQo+ID4gPiBhdHRyaWJ1dGVzIGdpdmVu
IGJ5IG90aGVyIGZpZWxkcyBpbiB0aGlzIHJlZ2lzdGVyLiINCj4gPiA+DQo+ID4gPiBXb25kZXJp
bmcgYWJvdXQgdGhvc2UgYXR0cmlidXRlcyBhbmQgdGhleSBjYW4gYXBwbHkgb24gdGhlIGhvc3Q/
DQo+ID4NCj4gPiBUaGF04oCZcyByaWdodC4gVGhlcmUgYXJlIG90aGVyIGF0dHJpYnV0ZXMgdGhl
cmUuIEN1cnJlbnRseSBrZXJuZWwgb25seQ0KPiA+IHN1cHBvcnQsDQo+ID4NCj4gPiAqIEBzdGU6
IFRoZSBmaXJzdCB0d28gZG91YmxlIHdvcmRzIG9mIHRoZSB1c2VyIHNwYWNlIFN0cmVhbSBUYWJs
ZSBFbnRyeSBmb3INCj4gPiAgKiAgICAgICB0aGUgdHJhbnNsYXRpb24uIE11c3QgYmUgbGl0dGxl
LWVuZGlhbi4NCj4gPiAgKiAgICAgICBBbGxvd2VkIGZpZWxkczogKFJlZmVyIHRvICI1LjIgU3Ry
ZWFtIFRhYmxlIEVudHJ5IiBpbiBTTU1VdjMgSFcgU3BlYykNCj4gPiAgKiAgICAgICAtIHdvcmQt
MDogViwgQ2ZnLCBTMUZtdCwgUzFDb250ZXh0UHRyLCBTMUNETWF4DQo+ID4gICogICAgICAgLSB3
b3JkLTE6IEVBVFMsIFMxRFNTLCBTMUNJUiwgUzFDT1IsIFMxQ1NILCBTMVNUQUxMRA0KPiA+DQo+
ID4gSWYgb3RoZXIgYXR0cmlidXRlcyBtYWtlIHNlbnNlLCB3ZSBtYXkgaGF2ZSB0byB1cGRhdGUg
a2VybmVsLiBJIHdpbGwgYWRkIGENCj4gbm90ZQ0KPiA+IGhlcmUsIHNvIHRoYXQgd2UgY2FuIHVw
ZGF0ZSBpdCBpZiByZXF1aXJlZC4gSSB0aGluayBOaWNvbGluIGlzIGxvb2tpbmcgaW50byB0aGlz
Lg0KPiANCj4gQWNjb3JkaW5nIHRvIFNNTVUgc3BlYyA2LjMgR0JQQSByZWdpc3RlcidzIEFkZGl0
aW9uYWwgaW5mb3JtYXRpb246DQo+ICAtIElmIFNNTVVfSURSMS5BVFRSX1RZUEVTX09WUiA9PSAw
LCBNVENGRywgU0hDRkcsIEFMTE9DQ0ZHIGFyZQ0KPiAgICBlZmZlY3RpdmVseSBmaXhlZCBhcyBV
c2UgaW5jb21pbmcgYW5kIGl0IGlzIElNUExFTUVOVEFUSU9ODQo+ICAgIFNQRUNJRklDIHdoZXRo
ZXIgdGhlc2UgZmllbGRzIHJlYWQgYXMgemVybyBvciBhIHByZXZpb3VzbHkNCj4gICAgd3JpdHRl
biB2YWx1ZS4gSW4gdGhpcyBjYXNlLCBNZW1BdHRyIHJlYWRzIGFzIFVOS05PV04uDQo+ICAtIElm
IFNNTVVfSURSMS5BVFRSX1BFUk1TX09WUiA9PSAwLCBJTlNUQ0ZHIGFuZCBQUklWQ0ZHIGFyZQ0K
PiAgICBlZmZlY3RpdmVseSBmaXhlZCBhcyBVc2UgaW5jb21pbmcgYW5kIGl0IGlzIElNUExFTUVO
VEFUSU9ODQo+ICAgIFNQRUNJRklDIHdoZXRoZXIgdGhlc2UgZmllbGRzIHJlYWQgYXMgemVybyBv
ciBhIHByZXZpb3VzbHkNCj4gICAgd3JpdHRlbiB2YWx1ZS4NCj4gDQo+IE9uIHRoZSBvdGhlciBo
YW5kLCBRRU1VIHNlZW1zIHRvIHNldCBib3RoIE9WUiBmaWVsZHMgdG8gMCwgc28gYWxsDQo+IHRo
b3NlICJvdGhlciBhdHRyaWJ1dGVzIiB3b3VsZG4ndCBiZSBuZWNlc3NhcmlseSBmb3J3YXJkZWQg
dG8gdGhlDQo+IGtlcm5lbD8NCg0KT0suIEJhc2VkIG9uIHRoZSBRRU1VIE9WUiB2YWx1ZSwgR0JQ
QSBub3cgcmVzZXRzIHRvIDB4MTAwMCwgbWVhbmluZw0KU0hDRkcgPSAwYjAxIChVc2UgaW5jb21p
bmcpLiBIb3dldmVyLCBpbiB0aGUgY3VycmVudCB2U1RFIGJ5cGFzcy9hYm9ydA0KY2FzZXMsIFNI
Q0ZHIGlzIHNldCB0byAwYjAwIChOb24tc2hhcmVhYmxlKS4NCg0KSG93ZXZlciwgSSB0aGluayB0
aGUgU0hDRkcgd2lsbCBiZSBvdmVycmlkZGVuIGJ5IFMyRldCLg0KDQpTbywgSSBkb27igJl0IHRo
aW5rIHdlIG5lZWQgdG8gbW9kaWZ5IGFueXRoaW5nIGF0IHRoaXMgc3RhZ2UuIEluIGdlbmVyYWws
DQp0aG91Z2gsIHRoZSBrZXJuZWwgbWlnaHQgbmVlZCB0byBwcm9wYWdhdGUgc29tZSBvZiB0aGVz
ZSBhdHRyaWJ1dGVzLA0KcG9zc2libHkgSU5TVENGRyBhbmQgUFJJVkNGRywgc2luY2UgdGhleSBh
cmUgbm90IG92ZXJyaWRkZW4gYnkgUzJGV0IgPw0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCg0KDQoN
Cg0KDQo=

