Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0448CF318B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 10:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLff5-0007jT-QZ; Wed, 19 Nov 2025 05:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vLff3-0007jF-RW
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:43:42 -0500
Received: from mail-westus2azon11010044.outbound.protection.outlook.com
 ([52.101.46.44] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vLff1-0005DB-RM
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:43:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xP5lQ5HiCcFlRPjs8WIzY1YnM6odiWVuI5CDMp7grBzByOloc1BWROzs3FHhEehuXBHssOSt0JjcFRJNwBAoPSyGV+EeOC0aBRWyfAEg55WuFnHXhwU0AXE4ioN5q6LVTpu/M3Sne54tuCD+ZcWrJHUAqliRjBOspClqN6ndwJjeg9TF/gyuz/zfJEOVgHitbUV49YWeXp7lgYP0ZODEH1YA8pjdHtTh4GjCi7s2BrUnj1M6rYhmNXVqcUVrR/ZE8dBtY1SFYVrBq6u+igpXOrFmv3nQ+cIBKYnSFwoP13T2AiAIF8Z+l9c0E7U2kd2j9xCAKxZa1U+UFuNk5KWHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0icYMluI1+wb+QToiQBb5xvIWh2xiRJo9MgYfHqQSiE=;
 b=retBnouDgq5gRABD1tWCVzfV6xm9rK3e1d4FeKlQwTIkmdD0ppNXvijMOUkFn+Dy53HTDpoCuMuEnATsOm3JR/eeFb8CqtNlIeMkJeuqexbKioFk0xREY9LLd+L2jb5kSpNsmnZe9NjqpAh3tut41ZLyREztGInM7bpWUTXFUvjLxb4HPWHmOFLHoOUYtOqIeWdtAjn7qW0qhBOuOjYLB6nUzHI1KK2A3+Od2Vvx6jtQt23vV4sFTDHs2HPBr3v4RrLpFJqQxy/m92MZISlZghEUTWO4QTKv84RigXfavVIn9Qw1iMyfUbbFEXnERyMe87tHkAqIuN2eOZgL8273xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0icYMluI1+wb+QToiQBb5xvIWh2xiRJo9MgYfHqQSiE=;
 b=tHJxJYiafYXWD9CsJNzMRFt2M1MrncQuF/ppjr8HwfXQSbUJLSqaV0Rc/8xGJ5WwVvcUoNGv8byxh0bZUu6LSog+JyQJDs9WmJexhYIzl2hY/QGttE4Ax6Wq+WuQRVQdpdPEL5e8agyAAjXClPcMeX7ER5l6Fdaim3ernRGSk6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 10:38:33 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:38:33 +0000
Message-ID: <2b500262-56f9-4950-9af8-c5653299e87a@amd.com>
Date: Wed, 19 Nov 2025 16:08:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] amd_iommu: Support Generation of IOMMU XT interrupts
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com
References: <20251118082403.3455-1-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251118082403.3455-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa0a25c-6b34-4223-2c78-08de2757c9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlRuSVJMcWhFQnpPcGRya1krczFPTmQwQ1FTcW0rN0ZmVW4xcTJmNnBTNy9I?=
 =?utf-8?B?WVpub0dYZmt5alo2SEtWOFNOOWo1MDdESjB6ZUhpZGkrUkQrVzRub2Y0U3Ja?=
 =?utf-8?B?UnhHQlVOVVdPK29uOVh1dmFDKzlzeGdrRHpPU0FyN3FiRzgyRUZRK3ZSbmo1?=
 =?utf-8?B?WElnbk9Kb3lFNHVHb1c1b3R6Y25GTEsrQWJKcVZrWjRXWXluL3JXNXlEM1pI?=
 =?utf-8?B?RG5xT01WdHlsaHlUQ0d4alJPZGFpR0pjZzdDWGRSa0lGTXVOY0ZtMXpqTUJX?=
 =?utf-8?B?bWo4b2dSVVFJRGxiSjI5QlNEZ3hMY21lVU1TMDRxMkNlSWk0UlhqV013ZUxL?=
 =?utf-8?B?MVdYbmFjVzIxS0U0WVZiRU54SlNiRzRmemZvQkRPNnlsbERMLzE0SmhGRUE3?=
 =?utf-8?B?VS9mT3VFUGtxRGJ6TWwyaWpvZGlsNFdaaTVrWUJ1aHZlUlFEUytNdGpTbUxD?=
 =?utf-8?B?R0NKZ3dYd3N5V2w2c3ZhS09nRUlKeUkvT0QrZmNIazNSc2dnMjlHUWlYQlpx?=
 =?utf-8?B?czZjbjZmaVdXTzU5ejNIOXZveDhRL1BFVlFmVEdFR3ZYS3BCQTRLdUdvUlZM?=
 =?utf-8?B?SkI2RzQvdDZJR1hDV3JveGZxR1Y5Ym1lMWNaazNOeTRlR01RSU54eTg0MzlI?=
 =?utf-8?B?RnhuLysvWU0vSVNBMVNtTVF3K25KRDl1RHJxVnVIK3VxQWFXYWo3bWNxYjUy?=
 =?utf-8?B?aDJXNVF4QzdCcG8xaENyblF3alZYejV3RlpPSFBkYU54QmdJaDc3OEhoTnQw?=
 =?utf-8?B?U3VZemtxcm8vRytIa2dLcHJINUZlMGlneGp2Zzd1RGRnNVJSUFhpK1R2ZWNm?=
 =?utf-8?B?dU8reWM5dFVyRkN1MFdMcFRzTXFDWTRwUGNFcTh1RXVPUlNxeEhWY0FiSFph?=
 =?utf-8?B?TVIvaWUzT3dESmFaN0lUdnBvMEpxdys1aWQ5NHJxMllHVU55dUJLQ3RtTWZY?=
 =?utf-8?B?RENvSFViOHB1Z1dwUHR0QkNWQXl5a0U1QkJuM3pBWmJxUGFMRmYxd3o5amto?=
 =?utf-8?B?QU1ydjlnZ09NU0E3NGNRZDRrTU1rdDRHTFcyVGdYeXVTTnB4VGpqYm5jSVVo?=
 =?utf-8?B?RFl6R0lOOHJtck4vQS9sYk1xeVlzWGRSSFdzbVh1cEZvQkpPeGdmWFA1OUVY?=
 =?utf-8?B?djhRWGNDTXkvK3pHOWNmZnRzZ3ZOMkJUQi84YzJHRFhzOVZWcVBrRXFqMEJs?=
 =?utf-8?B?NmEvVlVUUnZnWGMzSnRWeVZyZlFVYlZxT3VHemk4NTBYNnJBWnJ5SVg5WWtw?=
 =?utf-8?B?bkZwYXlXOEZzWFg4cTJRMGlZUXJ0aXBQVHFTRDA2ckJRcXdXSlB5UDJHLzZn?=
 =?utf-8?B?OWZzemJXMUlRSlhDY2xJR1F5aEJHbW03cWtXdXk1Sjd3ZFdSbE92VnBhREN5?=
 =?utf-8?B?M3RnRktNRkc4cjBSa3RBM24wNXdBb2FtUjY2UGEwN3JyKy9zZGRoTkhhQ0pM?=
 =?utf-8?B?TytkSnRFZnZSN1BLbmkzV0NaZCtubWJoNzBCZ0dYTjBMWGpWLzBFYkxySnBK?=
 =?utf-8?B?bDV5YjF6UUp2dTl1VWNLQTdDR085YTV1YWhaVG52bFJzK3pzM0YvbUhTSUEy?=
 =?utf-8?B?bkVIZFdidG50OWIzVmxkSk40a3VXb1BHYmpkK0ZORlhpSFJUY3VKZmZjQXhv?=
 =?utf-8?B?WW1iTmx3Y1U2Y2U2MEl0aHJZZGVwMUtQWUp3d2FNUTdydEtWcVBJVGttV1Bm?=
 =?utf-8?B?eDR4ZU1BYS9DWVdZSlpHK0lnR1R1QStaK0gwR05sV1NtREhVS2RJTzd2Q1pn?=
 =?utf-8?B?Q2NSRklGeThyR0FvUEdKcy9JRnBGVFVxaVMrcmRsSlJCekJWbmxpbjg0OWtI?=
 =?utf-8?B?bm5TMWVaS1lpa052V21BYWFwRis5OVk0c05LVzc4QWdlR2VUcTArN1RnYjU5?=
 =?utf-8?B?bDROeVplTEVnSDI3RFNjQ2U2RWhkS2FSK2lWNVJSdDgxcFhnZ3hpT0NjQXZi?=
 =?utf-8?Q?cdcIEmvBeQ7oSt8sQnD3bveW2VXWtGTJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eldSVjgxZ25Eb0o4UURIMFg5QWRjMFBlUnhNM3JabXc1M0JYUFgxYlQ2ZzA3?=
 =?utf-8?B?d1ZaR1JPcCtLS2hHTFQ2c0dkbU1FcmMwSkJpMW5PakFvMk80R2xOSjlFUmgz?=
 =?utf-8?B?K1g5UTB3OGZhU0lhSzdRZmNiNWVQTHNIUXFrZVlJWHI1TndXR1BEYkk0bGVL?=
 =?utf-8?B?REFjTk8wMkRtM2g2NG1SdUl1TzBPa0tMMkhjUXJ0T0s2RlZvWmxBUHF6TTBq?=
 =?utf-8?B?QWh5NzRkSzNiZzEvQTJkb3NFL3R3NFlFcE1UMHdzL2pOZzNEb3VnSGZHVnZa?=
 =?utf-8?B?UjlVNUMxTmY0Y2FHMG9nTjNCaWRDTGpQanNVNUg0c3o0R3RMc0JnUFl2SVgx?=
 =?utf-8?B?MkpXS0JNMHFsc0tPMCtBQlFQOHp1d2ZhcFd0VjEvbVVuUmZWK2pUbUwyL0E3?=
 =?utf-8?B?OVV5bUR0VjlQcUMvQWdSU2o0WmhZOTQ3UHFUSWQrcXNKRlRtcmVybVpobUJM?=
 =?utf-8?B?aXBTemxqRllJUGtTQ2JQZkVQWDRyK0paaHNONG9GV1BqcGpSd0JySTBVQ0Yw?=
 =?utf-8?B?U2pGbDgvY2VEQ21DM09tNmMrSlArU2dETzVsNVR6WVgvUUxMNVdyTVN0UHhi?=
 =?utf-8?B?RTBDVHZtbGtxbTA2V3F3bExlV3loUVJTRURramNFZmJxbEtYOCtvcHlOdyt4?=
 =?utf-8?B?UUhzT0MrQ3RRRTM0aHdhTmx5aUtTd3BKOTZ3clBZKzNtbVpWNVUyQnYvU1pT?=
 =?utf-8?B?MThVTWhVY0l1UTVnQ0psMHJlcXpjUXhoWmRqV0dCK1E4N0xxUExXSjFlcmlz?=
 =?utf-8?B?aEdyTkxZTEpObzQyei85M013bzlnZ3BHd2JSWGNHRTFCczVZems3dnRSc2ZG?=
 =?utf-8?B?QWdwcjZZcFIyNDJiVEJDVUlwU2g1alJvUkxxZW1HSE9EbDBiMnVsZU9ZQmFU?=
 =?utf-8?B?QzMwTDN0Z1ppS211SUZESUtiS1VLeklFbGFtcEVhYjN3Yy9jQ1RiaUxkbVZI?=
 =?utf-8?B?ZURKSktlS1ZpK2Q1ZWxpM0RlTWpKenMwaGVlSzhVSm5rT0VmNkNUSkVHakF3?=
 =?utf-8?B?aGpqMDlZVlZKSDltaitpOHZQWTVORFJCNTByOGtQT2wrYWxJaXp1Wk9IVlBN?=
 =?utf-8?B?ZHZKUWhvcWcwSGFYSEZieE9zcGZ0RjBGc25nUXRUNXA1ZStUQVVhd2N4OUsw?=
 =?utf-8?B?MzFuZDJGdndOMDkydzNEV2dMT3dTZndVWWdmclBGOWFUUFd2T0djSksrcDBJ?=
 =?utf-8?B?TnZ3NWh5ZGNuYmxhangwWTVkb3E3cU9pQTFIS24yRFo1bWg4U1B2S2ZWMHVs?=
 =?utf-8?B?VDkrR1E2RHNkQVN2ZHQ0d1RyUFlWOE5CZ3gxc0h4SzNnTGhvUGppYWFOeTFz?=
 =?utf-8?B?KzF1SndJM1RkNU5RK3I2QWhoZlc3WDNPU29YcDBkT1B6enh2K1VPVGpQNXlo?=
 =?utf-8?B?bGJSbDRaaHRUSXZFTFRXb0FVMHhpNmtpTzcvbWRLTjRmdVpLVGZuekFzU05N?=
 =?utf-8?B?eXc1Nk05Y3dzQmJTYnBvYVFIR0tpeHNCK0JVOENYMFhBelowYTFYQTByalBW?=
 =?utf-8?B?U2wzeGNYdTUyaXBrTEhnYlppNDVML0pxODVwZEg1NFk4MWJYNFJnUDMyZXhW?=
 =?utf-8?B?TWFYRXpFV3NnSmRSYjFwSm1FaGZvSnFPUEFEbm45RW1NRFJaVCtFWGFSMW5m?=
 =?utf-8?B?ZEI5djZWY0tjSm1GbWpvUzNKWnBLY1FBUnpoQnlldmJDSm5kVTB4dWhEeHVT?=
 =?utf-8?B?b0RHd2czUkp3Z1hsZlN6YmpwNDZpWFhKSENySTh3R2dWek5iYTZkRVhFbFRX?=
 =?utf-8?B?NTRUN1Q3Sm0xYzRuOHhyTHZHZTJRZjVsLzZlTzBDaUxYNlhwOWpGSHBud1Vn?=
 =?utf-8?B?SFZpd3pWekMwaVlLaW40Vm9VOEVLQ3E1RHpGYkl0SjhPKzdzRjZLUDlDUy9S?=
 =?utf-8?B?eWxuYWphWEo3UmJTdk82dlMwMnZRaDVqWmUxV2tYbUFDaTZzVkUvRlBKVXlt?=
 =?utf-8?B?OTB3UHBXNlJZSzRsektMQXBsOUFqb3VQbzZtdUJTTFgvM2dpdHBlcFFnazJW?=
 =?utf-8?B?bmpMZnppQTVWRWNhM0pDaWNtVFkyRmc4MnhDY01kZFNCemIvNmxic2dLMXFs?=
 =?utf-8?B?NnEzWVhVSkQ2S2UycllWRHhRWUs1TTluUy9JbkkrRFJjdGJ1STBFc0ZVV2R5?=
 =?utf-8?Q?8ZHQJCG9CQMd3PvdPrn0a0Ewz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa0a25c-6b34-4223-2c78-08de2757c9cd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:38:33.8616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MgMIDxjXcmaIyCnw1EQKRifqWlNZI9xuEv8VhJqNL59SIKnKH8z2hCLj6VWC72pepaJjMmjyWsNrkuZD6EiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
Received-SPF: permerror client-ip=52.101.46.44;
 envelope-from=Vasant.Hegde@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 11/18/2025 1:54 PM, Sairaj Kodilkar wrote:
> AMD IOMMU uses MMIO registers 0x170-0x180 to generate the interrupts when guest
> has enabled xt support through control register. The guest programs these
> registers with appropriate vector and destination ID instead of writing to PCI
> MSI capability.
> 
> Until now enabling the xt support through command line "xtsup=on" provided
> support for 128 bit IRTE. But it has few limitations:
> 
> 1. It does not consider if guest has actually enabled xt support through MMIO
>    control register (0x18). This may cause problems for the guests which do
>    not enable this support.
> 2. The vIOMMU is not capable of generating interrupts using vector and
>    destinatio ID in IOMMU x2APIC Control Registers (not supporting event log
>    interrupts).
> 
> To overcome above limitations, this patch series introduces new internal flag 
> "intcapxten" which is set when guest writes "1" to MMIO control register (0x18)
> bit 51 (IntCapXTEn) and adds support to generate event log interrupt using
> vector and 32 bit destination ID in XT MMIO register 0x170.

I have reviewed this series and it looks good. For entire series,

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant


