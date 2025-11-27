Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC440CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOd43-00053J-FH; Thu, 27 Nov 2025 09:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vOd42-00052s-5V
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:33:42 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vOd40-0001Qm-1L
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:33:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrwPAcpbFx+L2M2f36T2BeLVBTnhKAGIE1ranPm1yqlXF0UR1iAMyFRNBLOxJPPJOh4gigMJEGatNw84QKePwqn2Ql+oAom7GTgdAcXVav0ZZ7zKW0SYTOEPvn947OOKVBe8FrZO4s8sIKcbMiG/3gX5QVyVIz6mmhKr8mMhdINeWwPNEf6sP/CaOJ2DSmwLmtAcNf23hQ1ckyb7HNcyLl/u9YiVQBYapTcA5o2FlV+87hvfZ2d1Ip6s6GEOL35BNlkvFuKIsSCvp1qjusfmFtBTFAMhlDyIi6eYFgGmCCOTuMV0HEHiXYbVZp2utTgae45/uDHhtJFFC1tNnZ1/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAqoTrJDo4zhBVjpz8Zv7ZGjsThByKsyNwQGpCNoQX0=;
 b=eeFBouI2Xl5/DcI+M2CjPo0vCcX7DpohxID08Mk4Pxnjx/BvLGt8tZBFULjB1fJzjpwooTCk6zBzRSff58ERoc/OXIJ+qgkx+H6DD+PkanGhDOIK0qFfLnMOzoG3ZHudSJLbuOCqkjMMh6J7e8yVq9xaEoK1wzkMrHGC4pSnfqr95++jexWLa1nJ2VjM0DpLLGT3C5nExNStX3oiEGltOEDwdsej2Vqyrf9sQe9YBVyN/a7WnCONfIksJeXYy9euuLrlk4w8tMjpZZHL/TQERQmRsBAkF2T5lIXqAKQ1jaaeBBKFieh5DcQHM/OqwSrdG486vO/Vo+qy/L8DeD1tLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAqoTrJDo4zhBVjpz8Zv7ZGjsThByKsyNwQGpCNoQX0=;
 b=rDO3nYSIZTOsk3ucrkK9vChx45+06sFmJQQrhMPhMi8yHY7yF4rdvtE6G8wYnnPtLewB5chCUQPCRKtk1Eq77I/SjVGfWpSCpwaW52lXbwQnsS/DE8GUc5TXgR+hnEPKYbCdqmPQxIhOckYm2NhepFyw+laEz9ZkgE7eRTVOzzyTfzhsHdSpy86dkrhK+WOsekOXflJ6Il7XjO6b72jTsRAYoRfgKJdaFnr/0h3g9SOL5s/hFxDCvKuSqPQq4mQvdjncMvphfOoDxl/j0adeJVQ807CD4LrOuxYg9LWvUjkxNIuPpEtA9keNcfKb/V/TGkSo3geKOu3oJaLH/k0yNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PR3PR08MB5691.eurprd08.prod.outlook.com
 (2603:10a6:102:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:33:35 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 14:33:35 +0000
Message-ID: <ef51cf63-16b1-48c4-8070-0acaf618ef3c@virtuozzo.com>
Date: Thu, 27 Nov 2025 16:31:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
 <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
 <aSggPDzhqem_jxnR@redhat.com> <aSghvhrBXL0xxL1a@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aSghvhrBXL0xxL1a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PR3PR08MB5691:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c4a8fd-bac4-4eee-b1d9-08de2dc1f21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnBubEpaUkx0ZjlzNWIwNld4aXN0dVZWRU9DbDFpNFhQWUFVNmpZL0FlWGc5?=
 =?utf-8?B?Q1pUOFd6dlVBeE01VGg3aVV2T3AwTnJIMFNjMTRFaVRacmE1d1pFazhhcnZx?=
 =?utf-8?B?b2lqRHZNSjhIYnZMbnZmUFNlOXlOT3lveExlWmE2ci9aa1U3WkdUT0I0aUsw?=
 =?utf-8?B?bk4zWDZUdWV5Y29iS0J1LytIOUxKU0l3emdTcXd2N0VUeGJjQkVDMVJCSEJW?=
 =?utf-8?B?bjd4VUhEYmtHUVlPb29xdm5rV0JuR29SZGtxRTdYcE1iT2dEN0VRTW55ZDEr?=
 =?utf-8?B?cTVsRkpSTzdjRGtIaGcxWm54RGZreTFybzQyVjdNUFpPY012MEl5ZXZvM0Jn?=
 =?utf-8?B?MFdLaDd1aEZwZzg0czVSTEJKYzQ5MmhaRWxEaS9Vc0I5YVEyeHJXR2svTCtX?=
 =?utf-8?B?dmdDL1FQb2RpVkNkUkVHUlJxRmFzdE4rN09lbHVaUmZGQ0EzOGJiNEUxR3Vp?=
 =?utf-8?B?b29TZ0Z5aldhMHdDSWdYOWpNMFR4UE9oUHJLL09BcmlTZzg0MWdIS2RDZ1VW?=
 =?utf-8?B?dEt0WUdtWmlabVRmSXUybDBRVkwveVRTYTdpNkZWM2hnUWl3NVZOKzRFTFly?=
 =?utf-8?B?d29TS0NZMTlnN25ML25KL3gwY1hkQWVReCs0TENXSGZnZitzOFBCUnUzRzJZ?=
 =?utf-8?B?SEZmb2N2Qk90OCtESG5NVEJKc0lCbmJiYjU4ZldtcTlXQUtvU1lHZlZRK3hS?=
 =?utf-8?B?bnFLcGJwSU5EMjhKZ3h2VStUM1hXOWl2T1lRZWxYRk5PeUFMUGZhZERYQUVL?=
 =?utf-8?B?d3JMMFFJN2pPajhwN1hzMkhFaGVpcHQ1Q2hzRzRPcHNRKzBuamhvQlVSRXFk?=
 =?utf-8?B?QldhQnQyLzltSUYvN2gxZ3VCV3daY2lIVmkvMXAxdlg3UnhyNm9Gb1F2eVAw?=
 =?utf-8?B?N09WcWp1UTR4WEthOFBucnNMMEVGMmF1UXRWSjI1d3ZzVjNJOFU5UHk0KzQ0?=
 =?utf-8?B?UVJZWDJXekcxWDY2Q0VhWXl5VnppQmdIZ2ZjWU9IQXNPTGRxODJCRFM4UXd4?=
 =?utf-8?B?c1lNTUFSZTBBdk1EcWxMQUM2bWlDb1Mvb1VsYjR3VlQ0eWxPVzU0T21LRXZE?=
 =?utf-8?B?TmpPUXNhM2VLb3NtZ21qb01oZVMvcWYwZCtmOGVWTzRtT1FvVi9DSzZhMkdT?=
 =?utf-8?B?V1BPK0RCaFppVVhja25jM2J3RVBRUFJaZVNCK2lMc291b0JpakJ6S3R6Q2ho?=
 =?utf-8?B?MXp4QS9vdVBXajJKd3VZeWwzUW1jdUNWV3NZZDVwRFV0Y1Z4T3A0V2dFdCty?=
 =?utf-8?B?Z0R0SE9MeENyK0Y0TWZiK3duUkJzL2dLLzQ1VUN4cm5Jck4rOVhPU1hkYWRR?=
 =?utf-8?B?SHUvWXhKTDFLa2pjaDZPcGthTU8vZjdKa0JsajgrdTYrUUNNM3pqWmJycDRx?=
 =?utf-8?B?ekpJMW1ycjBHdXZjVnhxRXpXbmxBVjdJVy9wWTBKZjBEb00zZmZqVVV3RVlE?=
 =?utf-8?B?SyszZlBwTW0wQ051VFlKUG9yUStxWkE2SUQ3WUdseGxnS2FwQ1FubFI3MDJ0?=
 =?utf-8?B?SG8razNURk5KN0paNmM2cU1UMWFWYTdRRStnS010cmVLSFZBTGNHR3k3a0ZS?=
 =?utf-8?B?UGg5RGVKMlUvOG9NOTJlK083YjRHWVFoTUtybW55VDFaeXhzQ3FTbXUwelBP?=
 =?utf-8?B?UFZrN2t2V09CVXViSC9SSzlpVWRra0FrRVlTVGtUZFI4WEI1cXFaN1ZvZVlt?=
 =?utf-8?B?MGN3b2R4RzRGcE9VaGVGVkZhRFBacHRLZFVNWFU2N1A5MDE2SDg1WGlqcE5v?=
 =?utf-8?B?Z0lMem13WnhIUWxLYUhZVkNnQXprU3pWbUNrdTF4Lys5bm81RWtTQVZZWmZK?=
 =?utf-8?B?dHBlMkMvaG9GUkdGbzlkVXJVRDRlRzNOTitnSGhlTkJ5WW5MbTF0ZDljOVVN?=
 =?utf-8?B?VlN2eUNCa1Z5L3J5R2RmaEMvTE5UUHRCdXlWcUN4c1YyVkpqY21raDQxRDBv?=
 =?utf-8?Q?AY4Zx9Eq7De/S16M82uUbocKLz9FPHLl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFF3dS9sVUxQUWQ4UE82Vk5GUjNYR2ZCeVNQNTdiZnR2elVuRktiMCt6bEcz?=
 =?utf-8?B?c2dCTk42OFFrOG9oLzd3VlEyTk1MeHlhY2E0em0vSkZOU2QrdHRUc2I2Ykls?=
 =?utf-8?B?TXBaTVg1ZTd4c1VuanBqV1NnM3IzQjhsbnVyeTI3UnkzajdxNmFlbURaS2ZM?=
 =?utf-8?B?TW14RGFUZmtZQmVlSFAxWU0yMnNCQ1JDVGNvTVhnVEplQ1k4UlB0WGtheUpC?=
 =?utf-8?B?N2RUSWZBQjhLcDR3UitkaUh0S1NUMGliQ0lrTTBaOVNlTEV2c21pRlN3UHpm?=
 =?utf-8?B?Z3lLOTgwaUU0MW1SRmcyTllTbDc2WllxVTkrTThQYUxTc3FSSWcrN2NRNTRY?=
 =?utf-8?B?ZVBUWEhZaUphdG5PYi9ZMERmSUdlNkFFQWZVQXFYbkNCemNxY2tVZ1ZSRXJQ?=
 =?utf-8?B?dWZGaWxzUHVEdU1NckVNNFZkUEhJS2xyVmtncjUrRDFxSGpOVXRPWGcwcjBn?=
 =?utf-8?B?WlpacmRBdmNDeGtFZkR4N0ErZEIyL2V6K2gwNS9tM0RLTzhqSGlJNXBSOXU1?=
 =?utf-8?B?bFQ4NlVEWngwNytDYjF1cXFjL3paaFRqbkUvallJaDM3NFMwQkRYTXNTMWpX?=
 =?utf-8?B?ZXZoSkVmR1VYaVczd1N0d01OekhnSnBuMjArQ2NjUFlSQXZ5eXZFTWZpeVBk?=
 =?utf-8?B?eGlpU01xY0x0YmptNTNETVJiTHd0QTZ3M3ZjWmgyOFJmelFnVnVETlhRcnhB?=
 =?utf-8?B?R3k0d0RjWnN2cldyekxPaHplUkU5RVVBek9DU04zLzVKeHlWQnUzNUVxaUhh?=
 =?utf-8?B?SXNJK2Z3ekFxR09QRFRLVUhpbWNRMjJhRU9VMXNFcHh2Wk5idlV2cVh6Wmt0?=
 =?utf-8?B?NGpDd3VxOUx4UEhtMFF3MkZWQWo2ZDZkU3hMREpuZi9ycXVoMGxEWmMxWFZK?=
 =?utf-8?B?L2ZQeVJGN0NQTnUydWZIT0pZQjUrME9yc3F0d1dsMENhR2ZLUGhyN3BrRmhM?=
 =?utf-8?B?L3IzT0JTTW9pcVF1MjF1aVNjdFRoWWo3dWdKU29TRkY3dkM5dnJ4alh2ZVZN?=
 =?utf-8?B?Q3Zwdk5PY1pTcmpTN3N5VWwvUDl3V0hTcnZmVW5CYmdtYmk2azFFeUZVV0VB?=
 =?utf-8?B?enNEaFdMbVNLaEJ6Mjc0Qldram5RcHloUmtQSllwOHdnQW9HYk0zdkgyb1Uz?=
 =?utf-8?B?UGtUQ0JWNXZ0TENTYjhtaTN5dWd0d3BKOFI0amUyNUpzMWxKSTFhTEE1MmxM?=
 =?utf-8?B?RGF4eUlqOWc4RzJiNzNjR0h0RHRWVFdDNlBDcGhlV3lENTNiODlEWDF4Z3JX?=
 =?utf-8?B?QUprdUx4dTV4MnBSSUsyMWNGeFZLekttbXBIMkVGdk5KaUVLYUpieGJtS2RF?=
 =?utf-8?B?WGdBY3NZQkJETUQvRldiWkJUMnQ4aDU2LzEzbWs0b0FTRW0xdG93TFRMd2do?=
 =?utf-8?B?YkxGdEZWVkZrZWdzd3liRnNhUk9WOU40Z2lPOUtKQkhJaER4ZlFlT1hsR2Rq?=
 =?utf-8?B?MUN0VjNrclFRbytkeW8rYVVUSmFSOVZZazNxL1grZ1o1MjVHZkhocHliWE96?=
 =?utf-8?B?Q2tyS2pLbEs5KzRaR29kMlNMWlBkZ1ZEZjZxVHRCNEpEc3F0NThHUXNoRUQ5?=
 =?utf-8?B?VlUzWktib0tnZUxQYmdlLzFEUFA5ZXJOMjlNZTFlZVBwWUI4OWFXYUJ2T05B?=
 =?utf-8?B?UGU0V0tma2theUo0cHI2Rmh3azBkRDJCSmF2OTcxWTk5MUdhUldaM3ljYnp0?=
 =?utf-8?B?YnRPRHhZeE1VTVNVTVk0ekFGRGNZcHZRRXpMbDQvV1FmbkI3OC9ybW5NRnpX?=
 =?utf-8?B?NEUyNFo5THpvbndzUSsydFhmczBaanBkTjdialVrcEJvdk5XY1FITnRWSXU2?=
 =?utf-8?B?dXowSDMxV09sNzlLQ2RROFpHalV2Z2pHZTZ5NHpOQWJKcU9LQVQ3M1BnbVJo?=
 =?utf-8?B?STVVT2gwTlpDVXpxa3EvcE1ZSk5ETzk3VGdxelNLNThaYzc1T0ZmUU1xVjJj?=
 =?utf-8?B?S1hNOWlWZys1WjhseDBCUmRDTmg2TGlJRVlVZll5UUZJSzR0RnhydGVDSVZW?=
 =?utf-8?B?YTlXc1VaTmF0dGYrT3kyRS9VVDd0SmRmU0hqTmdNaE52bkZXd0x6WWZzVWdz?=
 =?utf-8?B?d3BSLzZQejdKSnpEV3ZWN1RtTlFUajV6Vk90bnJoY1R3R1NUUVR3L2IrSEky?=
 =?utf-8?B?UWVNdENMczZ4N21GR0ZTUmxVL1RuSW5zNVJPRmpvTUd1TGdZRlZOV0NnNDJW?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c4a8fd-bac4-4eee-b1d9-08de2dc1f21c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:33:34.8955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DubcJMXCPbIyC5vgK1LrMHYsPy9x9jgxRPGn2AG7sxC/DPIJbWoprJDa9d/KKBlucsAcoXd1fxmiBTya81oV84wakrMvy/DIsTPmvi6Uwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5691
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 11/27/25 12:02 PM, Daniel P. Berrangé wrote:
> On Thu, Nov 27, 2025 at 10:56:12AM +0100, Kevin Wolf wrote:
>> Am 25.11.2025 um 15:21 hat andrey.drobyshev@virtuozzo.com geschrieben:
>>> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>
>>> Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
>>> coredumps") introduced coroutine traces in coredumps using raw stack
>>> unwinding.  While this works, this approach does not allow to view the
>>> function arguments in the corresponding stack frames.
>>>
>>> As an alternative, we can obtain saved registers from the coroutine's
>>> jmpbuf, copy the original coredump file into a temporary file, patch the
>>> saved registers into the tmp coredump's struct elf_prstatus and execute
>>> another gdb subprocess to get backtrace from the patched temporary coredump.
>>>
>>> While providing more detailed info, this alternative approach, however, is
>>> quite heavyweight as it takes significantly more time and disk space.
>>> So, instead of making it a new default, let's keep raw unwind the default
>>> behaviour, but add the '--detailed' option for 'qemu bt' and 'qemu coroutine'
>>> command which would enforce the new behaviour.
>>> [...]
>>
>>> +def clone_coredump(source, target, set_regs):
>>> +    shutil.copyfile(source, target)
>>> +    write_regs_to_coredump(target, set_regs)
>>> +
>>> +def dump_backtrace_patched(regs):
>>> +    files = gdb.execute('info files', False, True).split('\n')
>>> +    executable = re.match('^Symbols from "(.*)".$', files[0]).group(1)
>>> +    dump = re.search("`(.*)'", files[2]).group(1)
>>> +
>>> +    with tempfile.NamedTemporaryFile(dir='/tmp', delete=False) as f:
>>> +        tmpcore = f.name
>>> +
>>> +    clone_coredump(dump, tmpcore, regs)
>>
>> I think this is what makes it so heavy, right? Coredumps can be quite
>> large and /tmp is probably a different filesystem, so you end up really
>> copying the full size of the coredump around.
> 
> On my system /tmp is  tmpfs, so this is actually bringing the whole
> coredump into RAM which is not a sensible approach.
> 
>> Wouldn't it be better in the general case if we could just do a reflink
>> copy of the coredump and then do only very few writes for updating the
>> register values? Then the overhead should actually be quite negligible
>> both in terms of time and disk space.
> 

That's correct, copying the file to /tmp takes most of the time with
this approach.

As for reflink copy, this might've been a great solution.  However, it
would largely depend on the FS used.  E.g. in my system coredumpctl
places uncompressed coredump at /var/tmp, which is mounted as ext4.  And
in this case:

# cp --reflink /var/tmp/coredump-MQCZQc /root
cp: failed to clone '/root/coredump-MQCZQc' from
'/var/tmp/coredump-MQCZQc': Invalid cross-device link

# cp --reflink /var/tmp/coredump-MQCZQc /var/tmp/coredump.ref
cp: failed to clone '/var/tmp/coredump.ref' from
'/var/tmp/coredump-MQCZQc': Operation not supported

Apparently, ext4 doesn't support reflink copy. xfs and btrfs do.  But I
guess our implementation better be FS-agnostic.
> Personally I'd be fine with just modifying the core dump in place
> most of the time. I don't need to keep the current file untouched,
> as it is is just a temporary download acquired from systemd's
> coredumpctl, or from a bug tracker. 
> 
>

Hmm, that's an interesting proposal.  But I still see some potential
pitfalls with it:

1. When dealing with the core dump stored by coredumpctl, original file
is indeed stored compressed and not being modified.  We don't really
care about the uncompressed temporary dump placed in /var/tmp.  What we
do care about is that current GDB session keeps working smoothly.  I
tried patching the dump in place without copying, and it doesn't seem to
break subsequent commands.  However GDB keeps the temporary dump open
throughout the whole session, which means it can occasionally read
modified data from it.  I'm not sure that we have a solid guarantee that
things will keep working with the patched dump.

2. If we're dealing with an external core dump downloaded from a bug
report, we surely want to be able to create new GDB sessions with it.
That means we'll want its unmodified version.  Having to re-download it
again is even slower than plain copying.

The solution to both problems would be saving original registers and
patching them back into the core dump once we've obtained our coroutine
trace.  It's still potentially fragile in 2nd case if GDB process
abruptly gets killed/dies leaving registers un-restored.  But I guess we
can live with it?

What do you think?


> With regards,
> Daniel


