Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83E7D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 16:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOef5-0007zo-BL; Thu, 27 Nov 2025 11:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vOef2-0007zS-3H
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 11:16:01 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vOeey-0004Jk-Me
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 11:15:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE2WYCOvPdWcKRwq0OWOkLw0Re4UnGl/YiC8QejBXXbMJBPrj6A2iOi71iyH2ev0/w4rXYEJf1gwrw4TWxkF4DazO48XDjJdGsl7zUoXYBQX+PeiqbmXZDz+/iYoHwiP85fw6gJbSuSCSyPR+a5A64U45dUlxAqw9gzEHbs1WJwg/GJ2Dw+t9TYm51jZ9fG5ZNeoijKzySMwwfmoKxXo6fQ186vaf2AU8PO7TFwdKa5lysT5iJO+NBeLm/dLAv6YZvBb7hU5BqNOH2fWfdaYYUfv1VFngu9BL8h/S5Tq0WJck0bv3vRCPMAQect6yaxjnELPeB+Cv2DB8KFS1k7AUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkJLJn8LWvKbgsYrjjRjrlwdi5tCqRVZa7BBhf5wLQA=;
 b=BreuMX+BJbuOek2QyJE36Wg5CPKle4yPZpCAn4fDL3O8Mb9V/7Ob52jjvvU4fipbF1msOGtb/cF6VTe1Jb+R17A2UN+RwVapIkrcjx1v2OJ3oFDWmd9n/V2prNMsHoGO17AP+hiiOIfsel6KWIeu3mBW9A4bMKlkkmTcatbvbISfIRE6ynGXPT3xktWLAcc/ruv9t1UnDnP6vguPe2Bw6yAQowtwK6SD4W+OVHXXFId7x4zuEvl6VfKA64I1AeSEd77XIshRICjSW8TOEuSmxPfg/ZxI2gl8XPT5Rew/sJkS8Tx5o6bu41VollG5pW4anRxwn3d09ztG6TpHivFDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkJLJn8LWvKbgsYrjjRjrlwdi5tCqRVZa7BBhf5wLQA=;
 b=0F7+Dyka6J4uq1W0Fsn/VfNcVCLTCJsB676m+XDErCIqB2se3/3moy5LIyvi3unzI8Jj+bTxTHpW4pP3KI+K+TPBuJN39xFIPrJfV5NSeIFZTEX4h7DuySCF4tlBQEVyrC67Ayq0gJ4YiDKXoeErWr0XQFMoxa9+PsExLDRKy/chXoi3lXUsG/0qGNZMdGSO+AU59gWuLk12pry/9t8aLg3G4wR+5Nbj0utNJxARi2w+g90pM1DFpA0uIIbvGaM/8pZT2CjT+h1WRurQilPmjzH4wRFj0wf8+iBRba9mUZu38kC8shFNGFtmzWVKWL3NXQwJaR9+7jvbFkVpHr7wSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA4PR08MB7545.eurprd08.prod.outlook.com
 (2603:10a6:102:26b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 16:15:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 16:15:52 +0000
Message-ID: <1ec1b39c-96a9-498a-bbcd-f16aa33e58c3@virtuozzo.com>
Date: Thu, 27 Nov 2025 18:13:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peterx@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
 <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
 <20251126205857.GA595594@fedora>
 <d5e75db3-5c5c-43d5-844c-b13a69c21d51@virtuozzo.com>
 <20251127144806.GB609942@fedora>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20251127144806.GB609942@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0278.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA4PR08MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d99c52b-cac7-452e-31c7-08de2dd03c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGVpSGhhdytTNEZxR3hhQ0FnL3JFdFZzckcwWitOcTNPUkxhVzhZR1ZJRjAr?=
 =?utf-8?B?S2pwTjJaU0V0TDZIc1pXQmwrY0k4YWFBMERVd1U0VUdzbm5ObUx4Vzh2Snh0?=
 =?utf-8?B?dFJOM0FySU1lbWFvMGVROTcyQkpMSzUvZ0NXcXVKUzcvVU04RVdaOG5pNU80?=
 =?utf-8?B?WHMzOFI1VDFBQ1FDZEFZSHNyV3kya20vQ3o3Y2NnNXlTenlONGgzTXd2UmJu?=
 =?utf-8?B?VEliem5kWmM4ejErUlFOMEFVbXRReTd2YktzTGZ1Zi85Q0FRVlZzRE5aNWFK?=
 =?utf-8?B?b3ZTaGVvSkRuV3BGeDZuQS9JaENDTDQwK0lRNFVrbFRrUXlxc0F4NjVEUGFC?=
 =?utf-8?B?SmV1cHVaN0JqR21xSXJ0bVRER2J1NG51L3BvV2M1OGdGYm1QWmpJS01wY2JJ?=
 =?utf-8?B?aGxvbVd3c1RSVVRIY1NPSWhhTVZzMGpwK0czV09IbExnaWJiYXVra3RDRDN3?=
 =?utf-8?B?S21aMFlLNGdGQ21OV2xVZEUremVsOEZZK3NCWkF6dHhSUE51d2pUZlE4b2hv?=
 =?utf-8?B?dTRnOHh3THlQU2hiOGVWajBSVlRYQU9RR0tBN1B6cGJFbEZLOWtueXhidmFN?=
 =?utf-8?B?TitEYk1OYk10NmhIYTdQR1hGMWFmbURVM3UvRnAxV1JMZUhHcFdzK0dhSERu?=
 =?utf-8?B?aEl5YmVJN1FpVkVqNEpRRUN3SXV6WEdZM0o0YzZhVUMzRTkwaDhaUFFwMFpY?=
 =?utf-8?B?YW5UckE4ME96eUR1WnkzVTI5dkRFOGpTRmsxN3kzUVJoRXlhVnNmZHZWVEFB?=
 =?utf-8?B?T3h5UVhrL3lHRlQyRGdYRVBnNVNTRjlYZ3BXOXBQZ0R1NkJnSlJSelNFMnpD?=
 =?utf-8?B?SEM1cGpwK0dRVlFmNWdDdmdoMW9jZzQxRUFNTFY1SjBzYm1INzlkUGtIN0sw?=
 =?utf-8?B?amoxdERwalQ4L2lHL2xYaDRGbU8xcUZqUWg5RjJ6TXpselNUeFZiTjVMMENN?=
 =?utf-8?B?QVA4ZG92TGxkSjl0NU03Q3VxS2VLMURqZFVZT0x6RWdoTnNFSTB0cFdUdnNX?=
 =?utf-8?B?Y2k5bTRpdmU3QTB5THFXNnNrWVU5QkJ2Q09PVXQ3OXBkd0pReEZnbVpXYXJS?=
 =?utf-8?B?NzEwa01uVkhDbE5ZNUtodGlkQ3hZRzBtYkltcGxCRGtHVktrNCtlMm9rQk9w?=
 =?utf-8?B?czF5Y09VejRmeGxxU1FDQko2NGhJcXBTVXNCVmd3am0wS3cxcmQwM2ZKKzB3?=
 =?utf-8?B?SEg2eTRiK1pzTFJSVndZTzNpNzRwTGtneWFiR2dNNVlmMWdaV3B5VEs3V0l1?=
 =?utf-8?B?dXg3bDg2Z3l4emkvMWhaTWV1MUxRakdIUllDcDZqNGNBRy9BdkFxUm9Qd1VW?=
 =?utf-8?B?U01qM09LVUVIditaSzF2bC9UMVJkNCtjYnBoN1hQMjVNcmZWSE5uRXcvQmsz?=
 =?utf-8?B?WndYTnFIcGVzL0ZWVXREOGxTNy9qTUJFamNHckxxWUVoUHJyQWM1MzZWd0pu?=
 =?utf-8?B?MkxUNkw3QnhBcFExK0RmclVkdFBTSkdwOW12SUJ1UzlQc0s4elE0MU91bHdS?=
 =?utf-8?B?dXBmdllOZk9KU055RWJ4RGtxUzZCRkJCSHBZcC9lam40TXZVOFFka2JlcXZw?=
 =?utf-8?B?WUp4RmtDZ256M1dFYllJRVI4WWVOOWNLN0RWMzVUWEZod2o1NGpIZmtRUzZK?=
 =?utf-8?B?MCtxNFRNYU1oQy9wY1loY0tiVWgycTBKL1JrSkVQTGR0VE5DT1pEZXRZWk92?=
 =?utf-8?B?NkJSYlBCMzFVR2VPMVpWVVYrMDJWaW5SNnEyRGk1Y2RMY01hMEd0Z3l6Q1JY?=
 =?utf-8?B?aEh3MzFnMmErelVIYVpXQldTZytONjExYWZCMDVxMEhDL2ZoVDd0bmNrUGdU?=
 =?utf-8?B?bWNyOUFTSjdWeWF4Z2RlMDNQbnhBdGdabjVrc0k3dWJvQm01aG9OeDVCeW5K?=
 =?utf-8?B?RGJZaXhkV0RrZytSZmYrWkZrWldyOHIxeHl5c2ZqMHEwQVRPZmQwdzdvcHpr?=
 =?utf-8?B?TFJGMDNjNGxCNEFzT2M3T1p2UVFIbisyaTFnOE1iSkt4dHByN1dVMFdJandJ?=
 =?utf-8?B?UzRvSzNVOUZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzExM0hkcE94N24vQ0d3ZkVld0lxc1QvYnRuV1VKeVA1MEtLQ2cxcDRjNTYr?=
 =?utf-8?B?YmlBNzdRVWhQN3M5UzNqa0t5NW9MZGhhSEl2eUxyMFRENnR6eStMUlBLUmJh?=
 =?utf-8?B?Tm94cENoYTdYdGdQd2crYjBrU1hnNDF6TnR4OHJkUVVNUGwvdzZLTTdvQzlH?=
 =?utf-8?B?MUp3STliNmVUZ1A3clk5TUR5cTZQdEt3R0NKL2VXbkRqM3RzRTEzZTdpZXJQ?=
 =?utf-8?B?NFo4YklYSzZ2cWhHQXJzdUt3V09ZVEZ6ZXdvbXVzMnlrWk1Ca2RiZ0tFN2Fi?=
 =?utf-8?B?d2lPdUx0eUFFSEdQUDdCYW05QmFwUU9mOFk5YWh5TjBxZktQdERyeHphNjZH?=
 =?utf-8?B?R2NxVWdmOTd5aCs2aXdMcko4MHBSOW1yeW5YYXJIWFdGZkZXUWJEdmU0UGVv?=
 =?utf-8?B?NGhFaDFjMnVkWEFhLzhGc3NyektWODR4anBLT3U4cS91Ti9RTjlmVWsrTVhC?=
 =?utf-8?B?VVphNk9xOG1XMG5DSDI0UjdzVUk5RGg5SjlxeCt5bG5maFpnd1ZRYnppZ0RP?=
 =?utf-8?B?aFhyMitFdWk1U2gzb2VkSDhJVEJ4bGFreG12R1VBZm1LdTFJMk5OMVdNbkFO?=
 =?utf-8?B?STk5MmREV291elRjOW9YUlRpQWlyZDBYNHljWDg3YlNWUW5TbFUyWnBFdGor?=
 =?utf-8?B?Rlc2aWhBU2Q3TTVPWHJZb1ZYeEpXZ2dHdGNwaXd4b2FWS1VnMmJPUmlZbjZ6?=
 =?utf-8?B?MFhYdTMrSm9KRlo1Ym1hWXIzcnNuRy9GQTdOb2dpNnc2Y1hvQ05naEJaSkxk?=
 =?utf-8?B?ZXZJSDF0Y2RLeHNpaGxQcWdrSzVkTndJaWFLVjlTWlpHUFNzc1FQN3hBZzhl?=
 =?utf-8?B?MUdnN2FRSHErSmV2cGdjbWx4K2w4OG1Sd2lWdm9TRmFlL0xheDRFR0tkc1JL?=
 =?utf-8?B?MnhXbStIWisrOEMweW9WVVBtZGxYbmpqZEQxSnVPcnY3aktQa0VQVmdCUGhU?=
 =?utf-8?B?bkVRNTk3SFZMTTVLSXFMeWIrSlRxN3kvRU4vV2lTZjlkNmtCTGE4cnFlTzdK?=
 =?utf-8?B?UzllcktsQWNRUFZKYlZETDZ6SEgzTUtkMXJ3cTR1ZWtYcXlrV0VBaEFKUyta?=
 =?utf-8?B?eHRKelkrdk1FdEJmdXpqdm1WZWhSU0RaU2VGaXlKbVhUSkhZNXJHTTJocksr?=
 =?utf-8?B?YlRtY251T1lQNktXYTBjak03V3RNaTd0L3FoN2EyVHVKOEJBTGNDaXRTK2Mv?=
 =?utf-8?B?MWh5cWljY1drU09vNGZoNDhocUxxalUyeXkxZ1N2dlBaRFBsNkVDdTh6Q000?=
 =?utf-8?B?MmZmVVlDRE9BcGJ4dEJJWXVrbkxkR0VmdkpSMy9ON3VvTTF0dUgzM0dZTGNh?=
 =?utf-8?B?RnJTRHpFOGZFNnV5WjBmWklXS3V3REg5Y1krZm1ZTEhrQU4ySTE3VjRWdmll?=
 =?utf-8?B?bnIzZzlhWXBVYklrMSs1ZmQvUURsWWNqaWk5aEg1YzFqNVJCbUtPQ3lHREJY?=
 =?utf-8?B?UDloQm1ubFdxa3o4dkZENmhTMXQ0dWk3TmtOVFEvOFFiNW5yWjhXQ2p6V0Yv?=
 =?utf-8?B?WDY4cnRUNzE5bCszdWdjcnZiSFlDNDl1ekxTRmE1akpHNVBydkNYdlZ2cklJ?=
 =?utf-8?B?dk94a0p4RXlHVDlwNDZQZXNRYUd4MEY0ZkVtU2RKanVEZHVyV2xidS9SS2t5?=
 =?utf-8?B?d2ttZUtWdVJRbTFtNUIwKy9tNmVKcHg1TTlCZnVoTEhsOGYvM09iclVUVGlk?=
 =?utf-8?B?WWMyc3BpMTB5NVMrOGh1cFY4UUhYTXJob3EvVUduYmxFbFJKNWcxT0t2RHNQ?=
 =?utf-8?B?RGFGUlgrSXpPbWJVVEk2ZWRYNUJSWWt3bGV5Mys5aFdmSTJtODRZcCtRQWMy?=
 =?utf-8?B?U01DNFNMb1VUamtLTk50dnI4WTVUVFVQbDZVZVkwamZwVnA2MFIvNUpIWGhL?=
 =?utf-8?B?RXcxcE82OEw1QWV1UndaN3ZTRkhuUnBUMlhQU3F3Q3pqTVN5MGNETXc2bFU0?=
 =?utf-8?B?cC9WUmozblZtUHpDdXpaL2dyMGo1aTBDSG5ldUdPMDljdm9kQXE0L1cyejF4?=
 =?utf-8?B?RG4yZURacDFmSkV4OUxCZ28vRU15a1Y1Tys4WnV4Nm1McGJWbWlVcHcvQjhq?=
 =?utf-8?B?ekhYbTJJYklWTXpFQi9sRHdtQVhwWk9GcjZwMmJxc1BWOEtFR3VSbVhaTzhE?=
 =?utf-8?B?aklYZ3hJa0FZbUlaT0xPYzZjRFRFYnRGVks3ODNqcGtZcUVDYkhuTWJtZWFP?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d99c52b-cac7-452e-31c7-08de2dd03c50
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 16:15:52.4806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqzdWM5kATgpiZXxjej4uanKlnuBiQda6+2G+MndAhVvSnFBgzzUn0Hvq/j7vjMfN6SXjbjRZensrO5BkV+z8BfjbEBemgSS+zPYQSqF+0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7545
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

On 11/27/25 4:48 PM, Stefan Hajnoczi wrote:
> On Thu, Nov 27, 2025 at 03:14:43PM +0200, Andrey Drobyshev wrote:
>> On 11/26/25 10:58 PM, Stefan Hajnoczi wrote:
>>> On Tue, Nov 25, 2025 at 04:21:05PM +0200, andrey.drobyshev@virtuozzo.com wrote:
>>>> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>
>>>> Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
>>>> coredumps") introduced coroutine traces in coredumps using raw stack
>>>> unwinding.  While this works, this approach does not allow to view the
>>>> function arguments in the corresponding stack frames.
>>>>
>>>> As an alternative, we can obtain saved registers from the coroutine's
>>>> jmpbuf, copy the original coredump file into a temporary file, patch the
>>>> saved registers into the tmp coredump's struct elf_prstatus and execute
>>>> another gdb subprocess to get backtrace from the patched temporary coredump.
>>>>
>>>> While providing more detailed info, this alternative approach, however, is
>>>> quite heavyweight as it takes significantly more time and disk space.
>>>> So, instead of making it a new default, let's keep raw unwind the default
>>>> behaviour, but add the '--detailed' option for 'qemu bt' and 'qemu coroutine'
>>>> command which would enforce the new behaviour.
>>>
>>> Wow, that's a big hack around GDB limitations but I don't see any harm
>>> in offering this as an option.
>>>
>>>>
>>>> That's how this looks:
>>>>
>>>>   (gdb) qemu coroutine 0x7fda9335a508
>>>>   #0  0x5602bdb41c26 in qemu_coroutine_switch<+214> () at ../util/coroutine-ucontext.c:321
>>>>   #1  0x5602bdb3e8fe in qemu_aio_coroutine_enter<+493> () at ../util/qemu-coroutine.c:293
>>>>   #2  0x5602bdb3c4eb in co_schedule_bh_cb<+538> () at ../util/async.c:547
>>>>   #3  0x5602bdb3b518 in aio_bh_call<+119> () at ../util/async.c:172
>>>>   #4  0x5602bdb3b79a in aio_bh_poll<+457> () at ../util/async.c:219
>>>>   #5  0x5602bdb10f22 in aio_poll<+1201> () at ../util/aio-posix.c:719
>>>>   #6  0x5602bd8fb1ac in iothread_run<+123> () at ../iothread.c:63
>>>>   #7  0x5602bdb18a24 in qemu_thread_start<+355> () at ../util/qemu-thread-posix.c:393
>>>>
>>>>   (gdb) qemu coroutine 0x7fda9335a508 --detailed
>>>>   patching core file /tmp/tmpq4hmk2qc
>>>>   found "CORE" at 0x10c48
>>>>   assume pt_regs at 0x10cbc
>>>>   write r15 at 0x10cbc
>>>>   write r14 at 0x10cc4
>>>>   write r13 at 0x10ccc
>>>>   write r12 at 0x10cd4
>>>>   write rbp at 0x10cdc
>>>>   write rbx at 0x10ce4
>>>>   write rip at 0x10d3c
>>>>   write rsp at 0x10d54
>>>>
>>>>   #0  0x00005602bdb41c26 in qemu_coroutine_switch (from_=0x7fda9335a508, to_=0x7fda8400c280, action=COROUTINE_ENTER) at ../util/coroutine-ucontext.c:321
>>>>   #1  0x00005602bdb3e8fe in qemu_aio_coroutine_enter (ctx=0x5602bf7147c0, co=0x7fda8400c280) at ../util/qemu-coroutine.c:293
>>>>   #2  0x00005602bdb3c4eb in co_schedule_bh_cb (opaque=0x5602bf7147c0) at ../util/async.c:547
>>>>   #3  0x00005602bdb3b518 in aio_bh_call (bh=0x5602bf714a40) at ../util/async.c:172
>>>>   #4  0x00005602bdb3b79a in aio_bh_poll (ctx=0x5602bf7147c0) at ../util/async.c:219
>>>>   #5  0x00005602bdb10f22 in aio_poll (ctx=0x5602bf7147c0, blocking=true) at ../util/aio-posix.c:719
>>>>   #6  0x00005602bd8fb1ac in iothread_run (opaque=0x5602bf42b100) at ../iothread.c:63
>>>>   #7  0x00005602bdb18a24 in qemu_thread_start (args=0x5602bf7164a0) at ../util/qemu-thread-posix.c:393
>>>>   #8  0x00007fda9e89f7f2 in start_thread (arg=<optimized out>) at pthread_create.c:443
>>>>   #9  0x00007fda9e83f450 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>>>>
>>>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> CC: Peter Xu <peterx@redhat.com>
>>>> Originally-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>>  scripts/qemugdb/coroutine.py | 126 ++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 115 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
>>>> index e98fc48a4b..b1c7f96af5 100644
>>>> --- a/scripts/qemugdb/coroutine.py
>>>> +++ b/scripts/qemugdb/coroutine.py
>>>> @@ -10,6 +10,13 @@
>>>>  # or later.  See the COPYING file in the top-level directory.
>>>>  
>>>>  import gdb
>>>> +import os
>>>> +import re
>>>> +import struct
>>>> +import shutil
>>>> +import subprocess
>>>> +import tempfile
>>>> +import textwrap
>>>>  
>>>>  VOID_PTR = gdb.lookup_type('void').pointer()
>>>>  
>>>> @@ -77,6 +84,65 @@ def symbol_lookup(addr):
>>>>  
>>>>      return f"{func_str} at {path}:{line}"
>>>>  
>>>> +def write_regs_to_coredump(corefile, set_regs):
>>>> +    # asm/ptrace.h
>>>> +    pt_regs = ['r15', 'r14', 'r13', 'r12', 'rbp', 'rbx', 'r11', 'r10',
>>>> +               'r9', 'r8', 'rax', 'rcx', 'rdx', 'rsi', 'rdi', 'orig_rax',
>>>> +               'rip', 'cs', 'eflags', 'rsp', 'ss']
>>>> +
>>>> +    with open(corefile, 'r+b') as f:
>>>> +        gdb.write(f'patching core file {corefile}\n')
>>>> +
>>>> +        while f.read(4) != b'CORE':
>>>> +            pass
>>>> +        gdb.write(f'found "CORE" at 0x{f.tell():x}\n')
>>>> +
>>>> +        # Looking for struct elf_prstatus and pr_reg field in it (an array
>>>> +        # of general purpose registers).  See sys/procfs.h
>>>> +
>>>> +        # lseek(f.fileno(), 4, SEEK_CUR): go to elf_prstatus
>>>> +        f.seek(4, 1)
>>>> +        # lseek(f.fileno(), 112, SEEK_CUR): offsetof(struct elf_prstatus, pr_reg)
>>>> +        f.seek(112, 1)
>>>> +
>>>> +        gdb.write(f'assume pt_regs at 0x{f.tell():x}\n')
>>>> +        for reg in pt_regs:
>>>> +            if reg in set_regs:
>>>> +                gdb.write(f'write {reg} at 0x{f.tell():x}\n')
>>>> +                f.write(struct.pack('q', set_regs[reg]))
>>>> +            else:
>>>> +                # lseek(f.fileno(), 8, SEEK_CUR): go to the next reg
>>>> +                f.seek(8, 1)
>>>> +
>>>> +def clone_coredump(source, target, set_regs):
>>>> +    shutil.copyfile(source, target)
>>>> +    write_regs_to_coredump(target, set_regs)
>>>> +
>>>> +def dump_backtrace_patched(regs):
>>>> +    files = gdb.execute('info files', False, True).split('\n')
>>>> +    executable = re.match('^Symbols from "(.*)".$', files[0]).group(1)
>>>> +    dump = re.search("`(.*)'", files[2]).group(1)
>>>> +
>>>> +    with tempfile.NamedTemporaryFile(dir='/tmp', delete=False) as f:
>>>> +        tmpcore = f.name
>>>> +
>>>> +    clone_coredump(dump, tmpcore, regs)
>>>> +
>>>> +    cmd = ['script', '-qec',
>>>> +           'gdb -batch ' +
>>>> +           '-ex "set complaints 0" ' +
>>>> +           '-ex "set verbose off" ' +
>>>> +           '-ex "set style enabled on" ' +
>>>> +           '-ex "python print(\'----split----\')" ' +
>>>> +           f'-ex bt {executable} {tmpcore}',
>>>> +           '/dev/null']
>>>> +    out = subprocess.check_output(cmd, stderr=subprocess.DEVNULL)
>>>
>>> Is script(1) necessary or just something you used for debugging?
>>>
>>> On Fedora 43 the script(1) utility isn't installed by default. Due to
>>> its generic name it's also a little hard to find the package name
>>> online. It would be nice to print a help message pointing to the
>>> packages. From what I can tell, script(1) is available in
>>> util-linux-script on Red Hat-based distros, bsdutils on Debian-based
>>> distros, and util-linux on Arch.
>>>
>>> [...]
>> My sole purpose for using script(1) was to make GDB subprocess produce
>> colored stack trace output, just like what we get when calling 'bt' in a
>> regular GDB session.  I just find it easier to read.  So, unless there's
>> an easier way to achieve that same result, I'd prefer to keep using
>> script(1).
> 
> Have you tried the pty Python standard library module?
> https://docs.python.org/3/library/pty.html
> 

I haven't until now.  Although using it creates a necessity to manually
fork() and manage master/slave fds, it does serves its purpose and
eliminates the dependency for external programs.  So thank you, I'll add
it in v2.

>>
>> But your point is of course valid -- I didn't think of the case when
>> script(1) program might not be installed.  Since we're just decorating
>> the output here, instead of failing with a help message I'd suggest
>> simply checking whether script(1) binary is present in the system with
>> smth like shutil.which(), and only using it if it is.  I'll update the
>> patch accordingly, if there're no objections.
>>
>> Andrey
>>


