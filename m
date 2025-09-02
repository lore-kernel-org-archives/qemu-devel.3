Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C0DCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utU2Q-0004cM-U0; Tue, 02 Sep 2025 12:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utU2O-0004Ze-C6; Tue, 02 Sep 2025 12:39:16 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utU2L-0000I0-Ht; Tue, 02 Sep 2025 12:39:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbGqbPtHWz/74CyR+lr4c/iT4J+ovFKmMOBy7RPpf9HTZLfDp0IYpVIjqz1Wap5Cr4iKXrZKb4fbuwpiUoDvmeaIiNSjRzsJ6lp/b4YQiXbnMZauvTKbgpaYSfZ2oyLib6t8rNrBVwEfDz+Ch2dSfs3l2YhgLgKVAtL1HBtcX5b4Jtor3oR0ZAjdHfxqvoBEtbC75+n1r8JnvUaSyRHNepIIldcO9CdPsln+kg1LGwGD/zxROC0LL0UG2zNMOyclQTiWL75qkN9Fdh6b0MSTC1q9qd8oJFL0IQn+IG4ae7QNUNbACQeiYedy6Gw+raMeEt8ypg3jTuzu+jxbbv454Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3a6h4pTIiQy1H+ZQa5FkeDKegwKf9zj1lPP/9RmF5k=;
 b=ODe9xWnD8cPk8dlvT/8tzkbZeoOir+G/8tiMdVNZDaM0UypJBjFeYG63mRGjAYk/RvyLmd40aGDDCRPRgyHmvRTZrlp+t82+0u+d1FY3RWmW9zbYZOCXchW2DHXsVePy4LPwahdDb+gtzqfNeG5SpIsTNT4M//3wMl2KmU3oePw/HzZ40Kpz9vSxNUCLLI/0UZyiMQ9fqCOXxleQr8BdTdRTeKrA4e+Mf+18zIc+mBmK5lvZE8aBqp7E47OhvB4RahfSw1BshSZng99sRWNwcCXOGBTW/JIosv7Br0iGeiOZfPIO6YSvra1sfDi3m63Wlzt3YJm3VLe0Zx1u2VGMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3a6h4pTIiQy1H+ZQa5FkeDKegwKf9zj1lPP/9RmF5k=;
 b=IS79R0qMYfaRl1ZzFLiIECDP4+ZZtL+eHOXQNiHXBaNQ//IgbbaC2yko52nI+1DeswBiR1qw110icBGWqiv8ddqjJwR/+N8LW0hYxhLPovnDazjGd+0KFgD2+X1MNDvYoE2KDbhS68TO+z39/H8hMnZc3gWPcDc6OgczJJihO31DG/NgkER9HIYo0nNcu3L87N8OUkWfPy3krKioVsiznXMtc64C1mRpYUBKP7BouWP25zwujJM4amuBTr1kKo3Nxma1lGn6wBHi3n2U6q8mOw1KyTsR4oj9oPcoBe5BLPkMjZJNe/qIxLm3d6bA/LfONZ0wk1TH7fb6rJnk/XREvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB7334.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 16:39:08 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 16:39:08 +0000
Message-ID: <21b6726a-1ceb-4782-a219-36f32cebb774@siemens.com>
Date: Tue, 2 Sep 2025 18:39:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
From: Jan Kiszka <jan.kiszka@siemens.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?SmFuIEzDvGJiZSI=?=
 <jlu@pengutronix.de>, Joel Stanley <joel@jms.id.au>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
 <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
 <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
 <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
 <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
 <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
 <d21f6449-e646-42fc-8277-b011a886e9c9@linaro.org>
 <41d2e67e-3345-4720-b3aa-1051224025de@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <41d2e67e-3345-4720-b3aa-1051224025de@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::26) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f22ec28-dcd5-4364-d2c1-08ddea3f3cad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWhpOFZIeEpPand5Wnk5UFZVS0c4UHdnZEEySVRHa3lrcmxUN0txQ3g5L21r?=
 =?utf-8?B?QW1JUmN1SU53SGltSTFFai9qVmtxUFcyWnZGeDdvTFFUcXVPdm8yNWMzMEJG?=
 =?utf-8?B?QVBBUmJiYnJUdkR0TGFBWEhQZDUvV1Ezb05Yd3FqeUtURlRySFBuT0R0MmFa?=
 =?utf-8?B?Wmw4YzVuNmZod3liZ3VxTGY3cXlCd1luNWwxUkdzNWFybXM2em9mSHp6ZCtE?=
 =?utf-8?B?QTRIUWU2SjlXSGZPTGJ4UGovUytFbkVqWkVOYTd6ZDdxVVRVTFY0ZVBpZyti?=
 =?utf-8?B?SDhTQUFhOWdzQkJkdVNRVHN6d2UvQlRMZFpFeFNmTnNjckJQZWZRYjlCOVFV?=
 =?utf-8?B?S1ZLRjViWnBCdnB0dG5DY3hKR1ozejVlUlpGYUpKdVBWNnlkbXppWGhuaXRZ?=
 =?utf-8?B?MWN6ZG55N0VYMGNqT2dVeEpUK0x1NVVKaEwyMFJDY29OQ3JaLysrLzFUT2xq?=
 =?utf-8?B?aTRvZGRnL2pSbUtLNzh5NmZlMnJvWnQ3MFN5V3puYjM5SSsyYTBHWUJKM09U?=
 =?utf-8?B?VVlOSmJ0TmE5MUhSYStIMkpnSk1wWVd6MGN3bUcrcVVMdEVMTlQvYW9rVFh5?=
 =?utf-8?B?V3FLcTFsVDdHQUdIUnQ5b1lSWGloZ0JXZmtkY05FdnVyNXl4VUIxNlRQdGw1?=
 =?utf-8?B?dXRMNExNbnpaVkhqL1ltR1FHdms0SHpwaFNKOFJGT0E5aTN3QWVDeC9IaXRl?=
 =?utf-8?B?Tko5bTdxQmJLR0xDbDBITFhKSHYzc3IxWktlSk5sRW9PNHpwVWRCeFFja2Ex?=
 =?utf-8?B?R0hGcUVxSXpkTU55bWtVVDRZdjhPRXd3SEVhdy9PVW1GMTVIOFF0RmNFbnMr?=
 =?utf-8?B?b3VDRE4xT2FPT2dOWEVrZDNDNzQvekFiMVBtbzZEdUl6OTlWWHIyUUQ4RCsr?=
 =?utf-8?B?WkdLcFlENS84Rk1vMFZGMzhYS3k2bDN2TmoxNFYxMU40ZUkxODhYYUo0Rk1E?=
 =?utf-8?B?Rkx2SUpLWm5DS1BqQTBNY05JcHo1SFAzZzlEcmVGSEkvNVh1MEN0UHhCNHFt?=
 =?utf-8?B?dHNCb2xnQXVvMzBRUFhmelNqbjlhWFRCMUFSeEp6U1pCSGRoM1NwdmhCOU1l?=
 =?utf-8?B?MlQrTnBTNWl5eHUzbkpCS1k5dzMxVDVWLzRBM3VmZ3VvaFNXT0IxUnNsbjds?=
 =?utf-8?B?STZBWnlDbHdtMGFOUnJLWmRTMU1KVkQwVEVnQzNOSVM4QWQ1a1cvOGtUeXJl?=
 =?utf-8?B?aUlQd0lweFl4M1RlK1RTR3YvMURYaXpjK0hYSkdLc29WL2ZhcFVDbHBSSWs2?=
 =?utf-8?B?aHZWc29DWXluY3lwZ2kxVEpLOTRVQ3pINXQ0UmVmczV0emNORUNNaDc1Ujdq?=
 =?utf-8?B?NUVqK0xmRDFpdEV5SU1QNFM3YmVQdW9uc0RUam1UdDQrdk5Ebmx0L2ZKQWtm?=
 =?utf-8?B?SHZ6MVlpM3ZZdjAxdE52U3F5UjRDd2Ftb05iZkNDTkpJYVMvcDZUL2I5dW1q?=
 =?utf-8?B?dU1UaEs4K2pSSEFSMmwzbFFsVmNXUGJpVW1GQzlRWE1ScHBWdjFDVlNSbktz?=
 =?utf-8?B?T2hPRHBmc0tLV1ZHSHFjdXZPK2pSU2RmZDhYbWx4Y2Q5S1dxVnZuSURFb3FX?=
 =?utf-8?B?bVVyOGJUU05xbkRxUVc2WHJ5VzZpd09PRVVUYm1qZVR1Z0JHUTg4cmZPeW14?=
 =?utf-8?B?eWtFQWh2T1JZYTNCY3JQcG84R3JDc3JpMzBsZVp4MndLZ3A1N3p3YWgrQkpV?=
 =?utf-8?B?V3JpeU1rQThpbUFuRStnYWFPUXNqc0Z3WkY0ZHB5R2VhdGtucEdZVm1YSVNa?=
 =?utf-8?B?ZXI0SFBDaTRjTEJxRy9DVFdFT29qU3lDVVJpd1dQOE0wNTZMampRaTUzK3FP?=
 =?utf-8?Q?5nPR1nAzLx8pcNVp18MuOxQ7aBnDKiBpBN7FU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0h3L3BlcTcrdkpnZWhaZ0xhdWNMNjUvSGpYVWZ3Rm0vcy9SSGNNOGNJUVQ5?=
 =?utf-8?B?NHhRWXhhcG5vWGt3VFNxZkZyNG1iWTJaLzJLOUZxdGVPWkdWeExVd0tqY1hz?=
 =?utf-8?B?SXlCQzdmWE45V3docU1uc0VoK0pOQjNNOEpRdk14RjBhZVJ1QnFkWi8xQnhS?=
 =?utf-8?B?NHdqQjJqRFY3UlhzYi9lM2laTXRMMjI2OGVXRHc2QThrTm9BUjc0bGRHa1dv?=
 =?utf-8?B?R0dRMFpmcExrOFkvR2E0Z0Jmb1g1eE5FVDVWRHFNN3dHUXZ5cHRIcE5Bakox?=
 =?utf-8?B?Wlh4ZDRpQ1g5dmEyNXVoU3RKK0tSSE0ram1pYlg1VS9QNGQxYUE0OXNsK1lN?=
 =?utf-8?B?Wmw2UDVmMGJQK3ExM2JQM25aMkJFY3ZZbjl1aDFjc1JxeDNjK2dtVWt5dFpB?=
 =?utf-8?B?dm15bUgyTW5GY2FmRThGRThhK3ErcFBtZDNabGsyWHBmY3VEMUhub1JnbDIy?=
 =?utf-8?B?MkRrQ2pNRU41ZHp3TmxTaE1kbk1HT1FyUk4wRFZhL3oydVRKbk5pM3lEdGND?=
 =?utf-8?B?S2pVeHUrUHlqcGtDV29MbmNyOFFja25hdXpvNDFIenRnbWVCTjdBNE9ZdDU3?=
 =?utf-8?B?WEJmN3lUdlh4Y1JvOEtqZEplTmJ0M2gyV3NXLzAyaVEvcHcxYzdObkhwTmo5?=
 =?utf-8?B?eWUzWTlacmQzZjZIVHVSaFAwYmN1K2tzSGFiM0ttTWdlbVh0UGttU2JaUnF4?=
 =?utf-8?B?NHFWSUtpaWJBbERMUjA0eTUwN0hzREV4WWhtY095UEtsTEQ3SkRXdXdSYUFW?=
 =?utf-8?B?TkZRZWVnYnFseEF6cEpHbU1UTlNnNXQ5dTBQUXByRDZHZ3JoVHd6b050Nm5z?=
 =?utf-8?B?T1FROXZZN0tOSVpOM1JaV0NCb2N5UklPamRRb1BkLzUxamh2ZVNlUndXK0pV?=
 =?utf-8?B?SHFYVTg5UEU1anRUd1FJMnh5MVp1WDJ2ZzV2cVJMU3RxSXVacmJTVTZDOXlp?=
 =?utf-8?B?SnM4b0pRQUsvK21oN1kxS3pFS1hNeVVXdWx3VHY4UE5IcHJsQXpCbWNNaXpW?=
 =?utf-8?B?UmRtK1JrYjRYOVlNV2pIeWh5bTB3ellGTFppVzV3cTRoSThsQmE4aHcrcm9W?=
 =?utf-8?B?RW9uRW9GTG02OGNwRlpVdXNHak9qQUZvNUliRTMvbk1EbXVaaXBOWHBwSlpP?=
 =?utf-8?B?eGl0R0p5SVBnWVJEU0U0MldBQkdITzVxUkFNbFNZdnUvRXJXSTFaNjhRdDA4?=
 =?utf-8?B?QW55M2Y2cEhRQ3IxM0U5alRsMU0yR3pGUUhDK0dXcXJ3cE4wdU42MkVRbWt3?=
 =?utf-8?B?RlFOVk1SU0Uwd2tjRENMT2QvRnpqOXBwL2JCNGVtdkFqQ3pmdnVramEzSUpI?=
 =?utf-8?B?R1lkMVI1T0Q4V21OTVZ5ZDIxRThzTzhSUXoxVGNkQkNEdnQrYUxCNk9kRjl1?=
 =?utf-8?B?bHlZQi9vVkd6MXpSUTRXTWRsYi82NDR1c0ZKVmFqUVVPVkRWdnMzY3VDT3hx?=
 =?utf-8?B?bjl0Nk5VMFZjTnJnMGFqVnpsWTdxdTFJNDdzenBMQ1dKYUc3ZHczazlDQkMy?=
 =?utf-8?B?U2dhT3RiNzE5dmhlK0g2dDNZZ0RMWU11aldwY2M4anBOVS93M3ZsWTk2azJ5?=
 =?utf-8?B?YWV4YWFJQkRFOTJLalpORzMzWUNLTGE2UDZoNTN2WnNjdTBhcy93T3hRdklX?=
 =?utf-8?B?VFZ6QnNrWHU3NExHOTdCbnhmbzM4dldtbjJRdEloTmVSWkEvbzIycU9lMFEw?=
 =?utf-8?B?dGYwQ0JhdTVQRjQrZVZBMGo2R1ZWTTJkbm9wS2IwNEVPTU1QdDVxUWJqTzVL?=
 =?utf-8?B?QTNzZmRTWWN6MDVydVMrS3o0WFR2bWoxaGE0TkRPYXQ5eGgvcFhjZWlyV3ZF?=
 =?utf-8?B?dk12L3ZxejJMeFZaT0Z1M2p5dXhRUDdIMHFPRnducXMvVVRMY01mWXQ0dkZT?=
 =?utf-8?B?K2g2UXd2RS9jYnRvVWJWZERDby9uS1VsQmFiMXhrTFJYS05QV09CTDNKYkZn?=
 =?utf-8?B?bmEwdHdjb1Q5cW1KU0JrT2YrMVdBZHFNcHBpZjAybFczTXJzUjFlRmcxZ3lj?=
 =?utf-8?B?R0ZxZE1xWGNZUTU0V2hqVzVlL0MrTjRMcXJ6a0ZRYzIvUVdPSTl6czU0amlJ?=
 =?utf-8?B?Z3MrbWJtNWZmMklObFN3UGxQWWNaSmpBR1laM3J4cmZhNlRhVGdIV054VGFy?=
 =?utf-8?B?NyttMU1XZEpCOUlIcVNZYXMxZE40RkpQK0p2N3gzVXl5QU1INm1UYktQTDI4?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f22ec28-dcd5-4364-d2c1-08ddea3f3cad
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 16:39:08.3281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgGxOM132ATYGeGRJlf+bJAZvudyF/9Ypqe5+Ej1VIFmm/UdatW6CUSsJrV3JBih9C2XMBVCn+TpaJvp6XlMIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7334
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

On 02.09.25 18:24, Jan Kiszka wrote:
> On 02.09.25 18:20, Philippe Mathieu-Daudé wrote:
>> On 2/9/25 18:14, Philippe Mathieu-Daudé wrote:
>>> On 2/9/25 18:00, Cédric Le Goater wrote:
>>>> On 9/2/25 17:55, Philippe Mathieu-Daudé wrote:
>>>>> On 2/9/25 17:47, Cédric Le Goater wrote:
>>>>>> On 9/2/25 17:45, Philippe Mathieu-Daudé wrote:
>>>>>>> On 2/9/25 17:43, Philippe Mathieu-Daudé wrote:
>>>>>>>> On 2/9/25 17:34, Jan Kiszka wrote:
>>>>>>>>> On 02.09.25 17:06, Philippe Mathieu-Daudé wrote:
>>>>>>>>>> On 1/9/25 07:56, Jan Kiszka wrote:
>>>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>>>
>>>>>>>>>>> The power-of-2 rule applies to the user data area, not the
>>>>>>>>>>> complete
>>>>>>>>>>> block image. The latter can be concatenation of boot partition
>>>>>>>>>>> images
>>>>>>>>>>> and the user data.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>>>>> ---
>>>>>>>>>>>    hw/sd/sd.c | 2 +-
>>>>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>>>>>>>>> index 8c290595f0..16aee210b4 100644
>>>>>>>>>>> --- a/hw/sd/sd.c
>>>>>>>>>>> +++ b/hw/sd/sd.c
>>>>>>>>>>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev,
>>>>>>>>>>> Error
>>>>>>>>>>> **errp)
>>>>>>>>>>>                return;
>>>>>>>>>>>            }
>>>>>>>>>>>    -        blk_size = blk_getlength(sd->blk);
>>>>>>>>>>> +        blk_size = blk_getlength(sd->blk) - sd-
>>>>>>>>>>>> boot_part_size * 2;
>>>>>>>>>>>            if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>>>>>>>>                int64_t blk_size_aligned = pow2ceil(blk_size);
>>>>>>>>>>>                char *blk_size_str;
>>>>>>>>>>
>>>>>>>>>> This seems to break the tests/functional/arm/
>>>>>>>>>> test_aspeed_rainier.py
>>>>>>>>>> test due to mmc-p10bmc-20240617.qcow2 size:
>>>>>>>>>>
>>>>>>>>>> Command: /builds/qemu-project/qemu/build/qemu-system-arm -
>>>>>>>>>> display none -
>>>>>>>>>> vga none -chardev socket,id=mon,fd=5 -mon
>>>>>>>>>> chardev=mon,mode=control -
>>>>>>>>>> machine rainier-bmc -chardev socket,id=console,fd=10 -serial
>>>>>>>>>> chardev:console -drive file=/builds/qemu-project/qemu/
>>>>>>>>>> functional- cache/
>>>>>>>>>> download/
>>>>>>>>>> d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=sd,id=sd2,index=2 -net nic -net user -snapshot
>>>>>>>>>> Output: qemu-system-arm: Invalid SD card size: 16 GiB
>>>>>>>>>> SD card size has to be a power of 2, e.g. 16 GiB.
>>>>>>>>>>
>>>>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hmm, then the test was always wrong as well. I suspect the
>>>>>>>>> aspeed is
>>>>>>>>> enabling boot partitions by default, and the image was created
>>>>>>>>> to pass
>>>>>>>>> the wrong alignment check. Where / by whom is the image maintained?
>>>>>>>>
>>>>>>>> Cédric Le Goater (Cc'ed).
>>>>>>>>
>>>>>>>> The test comes from:
>>>>>>>> https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb-
>>>>>>>> a85f-09964268533d@kaod.org/
>>>>>>>>
>>>>>>>> Maybe also relevant to your suspicion:
>>>>>>>> https://lore.kernel.org/qemu-devel/e401d119-402e-0edd-
>>>>>>>> c2bf-28950ba48ccb@kaod.org/
>>>
>>> [*]
>>>
>>>>>>>
>>>>>>> Digging further:
>>>>>>> https://lore.kernel.org/qemu-
>>>>>>> devel/9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/
>>>>>>>
>>>>>>
>>>>>> yes commit c078298301a8 might have some impact there.
>>>>>
>>>>> With Jan patch, your script doesn't need anymore the
>>>>>
>>>>>    echo "Fixing size to keep qemu happy..."
>>>>>
>>>>> kludge.
>>>>
>>>> which script ?
>>>
>>> The one you pasted in [*]:
>>>
>>> -- 
>>> #!/bin/sh
>>>
>>> URLBASE=https://jenkins.openbmc.org/view/latest/job/latest-master/
>>> label=docker-builder,target=witherspoon-tacoma/lastSuccessfulBuild/
>>> artifact/openbmc/build/tmp/deploy/images/witherspoon-tacoma/
>>>
>>> IMAGESIZE=128
>>> OUTFILE=mmc.img
>>>
>>> FILES="u-boot.bin u-boot-spl.bin obmc-phosphor-image-witherspoon-
>>> tacoma.wic.xz"
>>>
>>> for file in ${FILES}; do
>>>
>>>      if test -f ${file}; then
>>>          echo "${file}: Already downloaded"
>>>      else
>>>          echo "${file}: Downloading"
>>>          wget -nv ${URLBASE}/${file}
>>>      fi
>>> done
>>>
>>> echo
>>>
>>> echo "Creating empty image..."
>>> dd status=none if=/dev/zero of=${OUTFILE} bs=1M count=${IMAGESIZE}
>>> echo "Adding SPL..."
>>> dd status=none if=u-boot-spl.bin of=${OUTFILE} conv=notrunc
>>> echo "Adding u-boot..."
>>> dd status=none if=u-boot.bin of=${OUTFILE} conv=notrunc bs=1K seek=64
>>> echo "Adding userdata..."
>>> unxz -c obmc-phosphor-image-witherspoon-tacoma.wic.xz | dd
>>> status=progress of=${OUTFILE} conv=notrunc bs=1M seek=2
>>> echo "Fixing size to keep qemu happy..."
>>> truncate --size 16G ${OUTFILE}
>>>
>>> echo "Done!"
>>> echo
>>> echo " qemu-system-arm -M tacoma-bmc -nographic -drive
>>> file=mmc.img,if=sd,index=2,format=raw"
>>> ---
>>
>> FTR the alignment check was added to shut up fuzzed CVEs in commit
>> a9bcedd15a5 ("hw/sd/sdcard: Do not allow invalid SD card sizes"):
>>
>>     QEMU allows to create SD card with unrealistic sizes. This could
>>     work, but some guests (at least Linux) consider sizes that are not
>>     a power of 2 as a firmware bug and fix the card size to the next
>>     power of 2.
>>
>>     While the possibility to use small SD card images has been seen as
>>     a feature, it became a bug with CVE-2020-13253, where the guest is
>>     able to do OOB read/write accesses past the image size end.
>>
>>     In a pair of commits we will fix CVE-2020-13253 as:
>>
>>         Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>         occurred and no data transfer is performed.
>>
>>         Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>         occurred and no data transfer is performed.
>>
>>         WP_VIOLATION errors are not modified: the error bit is set, we
>>         stay in receive-data state, wait for a stop command. All further
>>         data transfer is ignored. See the check on sd->card_status at
>>         the beginning of sd_read_data() and sd_write_data().
>>
>>     While this is the correct behavior, in case QEMU create smaller SD
>>     cards, guests still try to access past the image size end, and QEMU
>>     considers this is an invalid address, thus "all further data
>>     transfer is ignored". This is wrong and make the guest looping until
>>     eventually timeouts.
>>
>>     Fix by not allowing invalid SD card sizes (suggesting the expected
>>     size as a hint):
>>
>>       $ qemu-system-arm -M orangepi-pc -drive
>> file=rootfs.ext2,if=sd,format=raw
>>       qemu-system-arm: Invalid SD card size: 60 MiB
>>       SD card size has to be a power of 2, e.g. 64 MiB.
>>       You can resize disk images with 'qemu-img resize <imagefile> <new-
>> size>'
>>       (note that this will lose data if you make the image smaller than
>> it currently is).
>>
>>
>> I expect us to be safe and able to deal with non-pow2 regions if we use
>> QEMUSGList from the "system/dma.h" API. But this is a rework nobody had
>> time to do so far.
> 
> We have to tell two things apart: partitions sizes on the one side and
> backing storage sizes. The partitions sizes are (to my reading) clearly
> defined in the spec, and the user partition (alone!) has to be power of
> 2. The boot and RPMB partitions are multiples of 128K. The sum of them
> all is nowhere limited to power of 2 or even only multiples of 128K.
> 

Re-reading the part of the device capacity, the rules are more complex:
 - power of two up to 2 GB
 - multiple of 512 bytes beyond that

So that power-of-two enforcement was and still is likely too strict.

But I still see no indication, neither in the existing eMMC code of QEMU
nor the spec, that the boot and RPMB partition sizes are included in that.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

