Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8D1CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMclc-0001px-FY; Fri, 21 Nov 2025 20:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vMbSb-000683-6i; Fri, 21 Nov 2025 19:26:41 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vMbSN-0003H8-1v; Fri, 21 Nov 2025 19:26:35 -0500
Received: from AS4PR08MB8219.eurprd08.prod.outlook.com (2603:10a6:20b:51e::11)
 by PAWPR08MB9099.eurprd08.prod.outlook.com (2603:10a6:102:343::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 23:14:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhZ9BCpIriLEBeyqhRDsOfcXYoVrX2gV/GMrs69R09zuYDBgXOhECFt1+xQttyDILAptEoacvteuzi6H7y92feoqApoAqH4bVo5W2zXQvV64P9R6HCd+yL40ziZXEg1UxiF/Q7HsNE4K/dECGfQqfE7NnJcJYNjLz++ZrIPnnymRxsZU23vn2Z/2OxUT4sj/nE3k7lxZnde82jHxyP6Z0JDyka/5PufLZRaFu9hZTbuNyOOQZLFzYL/YfiEs2HpNsbpeUiy7Qug4FFVL8igLgK+yEQLT7/SNOTI8GxmnULt2jpfg004yHBaKnb1LSNO+SjxKwSkadXFeOM/LT+YrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt+hRAHGvIOBogp/qmj46ioEqG0gvO/P/9T/O3+b7wg=;
 b=Go96wwYq4ZmCYwydOmKiNNxpgDeTBNk+yPTnEd9zCi7qaaR3cAkDmqQUwn82QXss+Kxe9vo2qLqHMpPd8V8hQP+cw67+PR/l0xxEadXbJJ8YvT0JA59qIQq7lp6hs+MCQiwu4N5aFmD7TU8Ja17MtQd3DKlikLCn1MpLhLCv9LqLD+Q4VJAA9J2fnpu1jDMFUAUBilb585NHVAkkapf/DNJXxG+10csC1OzdvMLtne8yE9umaGYZZysNf26WLW0MgBvGGEjq/a5yh62jiZrvDn97SApE7a36M2haCfRMbJ7M//lGqmz1EhNR+NiyWmri054qam0jzaHj3RG9tqykXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt+hRAHGvIOBogp/qmj46ioEqG0gvO/P/9T/O3+b7wg=;
 b=AEm8nMPoa8qBXgtgurLzFXfAzFx+VIT98uPEl34yBwlfl6JtoTfIrh8OqSILLqDRxzJNE4sRQRSmYiI32hb94C/bubI+T6fMKJjFyKgW19TMe+yLqUU9Hj/yLSZC2dF+LcTQdLJdtruuNCuHk2wgAs3yjhL5WKjtYNGWRXL4bMX38xJFNncEKj97kl4ecsXGK0VOeQhAU0wHbqgR+/2mH1t9auiJeNqwWLDHxkneFK0OfPJqgwqgK+6uf5t1KHByTUOOpoxoHvoRXk9PefWjnsPh/tX5seRXk1CRPfVFk0wtnLKYw7k+azptrKsrdNpeMGaJtmD8WxS6mri1Y4zZIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS4PR08MB8219.eurprd08.prod.outlook.com
 (2603:10a6:20b:51e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 12:04:43 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 12:04:43 +0000
Message-ID: <8ac88a67-6c41-429a-897a-2d5cea59bd63@virtuozzo.com>
Date: Fri, 21 Nov 2025 14:01:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block-backend: Fix race when resuming queued requests
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, den@virtuozzo.com, f.ebner@proxmox.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
References: <20251119172720.135424-1-kwolf@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20251119172720.135424-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS4PR08MB8219:EE_|PAWPR08MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 996dafa6-5d2c-4faf-5253-08de28f6280b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkJubzNUdEwwSkZ3Wjhrb01tMTl0Y3k2UU1SZnhXMUxSNWpWOElNUjFHMGVm?=
 =?utf-8?B?Ykg3a24rajk0enN2V1dManE1aStJYXl5R2JJc0xvcTAzVW9sNXc0eWJVVjFG?=
 =?utf-8?B?T0RrQmRwcW00dGpOZ2xmWDl0NW5BUTdQSmdXN0ZhRWI0NjQvbFVya2pFQXlp?=
 =?utf-8?B?RGpDVVhPRE1renJ0bDAxWDFHRFgyMVZLSnVzY08zVUdpUHVzd1crTnB3Wk1m?=
 =?utf-8?B?WHhxazhaRjVBN3JDRHB3a1g3d1FTaVNuOHdpTmNqOHBqRXdCNm5uQi9Qc1Ar?=
 =?utf-8?B?YU12elIwRFJRcUVlUlo5TmFBSDltY2xXbjYrOXQzdTVoSGRrazNpRzIwR0hD?=
 =?utf-8?B?dVdoWlgvSzJub2dURVI5Q1JYZTBrTFVnWjVPR3A4Qlp4bzVkUGNURWVEU1lu?=
 =?utf-8?B?b3dyTHEyN01EaFF1a2JuWExLVVJ1UFdNQW9CNmVzbVg4bW5tOVhYWmxKKys5?=
 =?utf-8?B?VlY3UEhMWWVESE15UDExZndLejh5K3RibjgvNjJmNmRJdkt4aXl6RzhJK3Rp?=
 =?utf-8?B?aW01RlNmaHRjSHM1Z2FvSURPM3NRK1Nlb2djSUpFT3VpaWQraFpkbmpKSkdV?=
 =?utf-8?B?ZWZYaEFSTS8wa2cva1hLVVFoVUJKd21Va2ZtRVdpcEZpWEV6bW54c1AvT1dV?=
 =?utf-8?B?SE12WkM2NU1jWTU3VHlZcEVHLzk1WTNhQktwcGtMclZDdG1UM1lITU04Z1VS?=
 =?utf-8?B?T2U3VHNtYm1CUHVrTTJVcE5nWnFjSHczbU9mN1k0ajArbUdxZFE4MmxWSm8y?=
 =?utf-8?B?RHdwcjRnVmZmY1c3YzJQSDB4d2t4UVRLNVFSbHRySVc2RHh5ZzV2bit0VVgw?=
 =?utf-8?B?aGV0WGM2UTBocWxha0FScjV6ODFzdUFTRkg5Um16RGY5ek5xTjlGVUJaQThj?=
 =?utf-8?B?Rm9tVVJZRVBpWGdiam9YVXJrak1IVmhQTnJiL1J2aEZjOTBjT0RQeWg3dnhx?=
 =?utf-8?B?b1p5Tm92Ky9tUkJsYXN1UldaTXdWRFZYU0RSZHpUR3lyaUdMT1BLdDRyQzRo?=
 =?utf-8?B?OTJkMStMci9CTWl5Rk9FWlU3YmZOY0FQRlV6dExrZmJpSUJGQWlEeGwwZUs0?=
 =?utf-8?B?K2w5eTdFd1oyVTFvdHY1OGdTTTJiTWpRenlsblpXUmh6TENQOTFVNVlnM3R5?=
 =?utf-8?B?MzZDN2tGcHRXSjZOUW5zQy9NajU3TEVJWFg2bklleWRyMWs3bTJqVFZ2RjJO?=
 =?utf-8?B?RWFVaEt4STREWnlFTEw5T0tHeEhkQk1BR1A3eGd1eUw3ZFhwOGFxVTgvQnZo?=
 =?utf-8?B?anZ1NU9wdzZkZnlEbTU3dFU2TVBGajJlTHVpa3VVTG5DSUQ5RHdPQ3B2Mzh3?=
 =?utf-8?B?cTA1VVBKMHNqdmlMWG5hWm53QlBFWG9Ca25xQ0p0WDJmdWZCeXJDRWtPVXkv?=
 =?utf-8?B?aGpPTE5nZVkxdmQyUzRxcjlRSEJxU3V3UC9sOVFQSkp1TlAzc0diQ1VObE9R?=
 =?utf-8?B?Y3FqWlRQcWxET3FYR205cFRNTzErRmo2YnRocG5oZzZtcUtRRFg4VkR1MjZz?=
 =?utf-8?B?bVZ0azNOYjZvczJWNzUyRm9KbThiazBHUzhrZC92c1JtWEpjR2NRb0pkTHNq?=
 =?utf-8?B?WGxSQmNwOEN3MGxOaGhtcDZtU0lZN09XQWt4aTlqZEx3Z09qU0RPOG9LNFRr?=
 =?utf-8?B?VC9IeEZwbVpCMGxwMSs3ZE44UHpienlaOWRwZ21PZStqTmw4dlBaVTBKcmRB?=
 =?utf-8?B?MEtNTWU2d0NiVHNPY2RoaEM2WDBiTnVudmJMbEN5ZDFxTkpKUTE2UEhRSWlS?=
 =?utf-8?B?c1AveUd1dW5qaThtV3VhUkluRWZpYkVwZmdNaVk0K0g4L01POVBhMlcyYnpP?=
 =?utf-8?B?dHhnQjlsYVdjOVJwOVhHK2JQZ1hGU3cyMXlXWCtJWlBxNzdHbjFDUnYxQXUx?=
 =?utf-8?B?eVRLQ2VWZzRtTFBvU2IxankvU1UyRFZ0aStOYkxQZWJwTWxiQWttelpPU3Nw?=
 =?utf-8?Q?Du0rIW37DO4LJrtPE3aL4lwWqf8ahO9X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHg4NUxKanZYOERlSjRUY3RFbHBiRUNWUUZGaTcrMHlYKzRPMG03ZW1GeHlD?=
 =?utf-8?B?eFZ1bUFWNE1sWnVWV2dydExReDQ0TjMzRjhYV0pnaXFUWjl5aFZyOWRNY0I2?=
 =?utf-8?B?QmZrdDZCOVM4SkU5RWNNMEFNMUJqcVRWUjgvYVl5ZU5sUTFObFdxRnl4T3pR?=
 =?utf-8?B?VVd1LzBwVVRSekNTNU41QWQ5ZWtjWDg4YVBZYm5yRk0xMzk3NERFbnVLL0VY?=
 =?utf-8?B?S3BlZ2RZQXlqUGs0YUI3cXBXSjFuWStiaDRPeGtQb205dWllY0R6V1BKSFlS?=
 =?utf-8?B?eGFXY2tuT2tVSFM2QUx0KzZ2YVNyN281RGs1enExRWxFS25zRGZhQk16bHVV?=
 =?utf-8?B?TUoxV1FjRysrd0tjRkE1NEZVZ3UyWnEzeE9lNTV4dlY5TzZQTWVLNHplUGsz?=
 =?utf-8?B?ejVlcnJpenN5K0xzNUk4VnpyQ1FiY09pRHBIZXBRVnVzaUVreCtRWmhsdC9G?=
 =?utf-8?B?SnZFOXpaeHlid3pqRlZmKzFHcXRLTTZJMkhJUXBaKzJ1aUY3NXVoWmRPeWkz?=
 =?utf-8?B?UVppSzExQXNMUkxLRm1WTzRla2ZhV3M3TENLVS9QMzZ2RndPMEJXemFrMnUr?=
 =?utf-8?B?Yk5RMlVOL3JvMnA3djF2MXNwVklVZWgxYWR5dFN5YmpjcG5mR1oyL0VGcHJE?=
 =?utf-8?B?eWtWY0lRNWoxQUtIS1NDWXJMYTM0T3FYa0t0WFk0akh1aTcwU3BRRUpqYUh1?=
 =?utf-8?B?VzBvT2cxVWh0cE1CVDRmdVNBa3JlQTF4dThaeHhpM2JqeU01NGJpcHU1c2V5?=
 =?utf-8?B?ZzZlanpUMytLbzNIbHV3aHVBNldRZUZ5MzhHbGVYaFN6WDJiOFAzMDFyUFFl?=
 =?utf-8?B?V3NnNTY4R1ZHZytqTG0rMlNlQlVNODdiMERXYzhCUnhveitNZC9TOGdLS1ph?=
 =?utf-8?B?bkxaTDhsekIyM0lzMUpZbEoyUDJzYUp6aU9LWS9yckQzcVcybDdxd2VQTVAr?=
 =?utf-8?B?SnhJYmgyRmJlMHhFeEU3ZVNIMUl0eUdlZktTekVHOWRCdFdFeVBkN3JoSnVa?=
 =?utf-8?B?c1F5R2l5dWRuTlhXMnFydzZYUnhKdVpFMGduVHZPOEkxU3FQK3JjTkFrUk9j?=
 =?utf-8?B?aERGQlZDK1Vib0hBNHVYVm9PQUdIb1FUYTlRbFhrY1lmT1AyV2Y2cElqNTRP?=
 =?utf-8?B?TjY4dStZQmw0N3FzSEpUTXloNnBrZHV5aEFrQnZBeHd1MExmSGo0NG4vOUQ0?=
 =?utf-8?B?bVp4THJoSDgySndta3ZnOEFGZ2dka09kekt5amlXNWdheVFqUkJ5Mlk1SktH?=
 =?utf-8?B?YnJNTFZySC9acDVib3RZZHB1UGdrWEhXbVdkaVFjdUJyMjBSZnd4NjQ5dmZO?=
 =?utf-8?B?bGNvZkZudVlhVEM1YXd0N1lRaVlBZXFsMTlUYUtDZFpYcElTLzBxL0xya25G?=
 =?utf-8?B?KzBodHAwNW4xY1czNmFKSVB2clFIcklhZHArSFQ0Q0t4UWtHK0FPb3FGVU8v?=
 =?utf-8?B?L2oxTGdRN3ptUDFzNHMydm0xcnd0NHJoN2pCczBDbno1RzNpMGNQQ3Vvb1k2?=
 =?utf-8?B?K0VyNnE1YkxVbzJRR3FGU1J6b2k0Y2tBRk1Ra1FHK2lLT0h4elVUSXV4NW9C?=
 =?utf-8?B?L3RKRHZxQVVEYlhPazBuazQ0WjRudmJOdXp5V2s0WHFOREN5M2pLeW1nUUlX?=
 =?utf-8?B?M1NMTHlUZysvK1BlaGpZMDJ4RTdtcER2WFRGelFpVlVYeU0zaEZFL1hyWEdz?=
 =?utf-8?B?UGRkeUtxZmNHUFBsRkJ6S2pZNEFDNnV2aW10VzBsL3hKYUxSclRDTlk4MFdE?=
 =?utf-8?B?RVNldHBmdlJHNk05ay9JZTBMVzVIOUxSdGFDcmszQ2s1NWQvMDJQYlFDa2hy?=
 =?utf-8?B?ajk4ZTBJdndRRjNyandUSmlVOUh2alFUSHVkNjkxR0IvVi9YMDU4Nzd4M0xH?=
 =?utf-8?B?KzhyVFdNUDVDaE51RGpRbmhEa2RrTnR1cjFPV2JNeXE4OGxVNWwrYjY2dGFh?=
 =?utf-8?B?RTZVRUNscnNiRUFYRVRMa29UM2tGc1VFaWFWb3V0dkl5Q3ZDUFFaeWFpU1ln?=
 =?utf-8?B?RGRUa2YrZVB2S1hselM2YXNtVWJweXRKY1J0czdEZUQyUXkzTlprS3BuOU1G?=
 =?utf-8?B?OWNDcTlQY2dGUWlqb05MaE1CREZKUzZuVnFEV3dUTDI4OWZzbWk4TUgvaWZP?=
 =?utf-8?B?eWlNVGc2TjRsM0lVY0pEV2J4cU90dVVDRHduZ2tjWWdFME0zM29pd0ZXTU5M?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 996dafa6-5d2c-4faf-5253-08de28f6280b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 12:04:43.4182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oxg2yKkMUihk2xDNBhaseNg2pTJARl28SzL1+NGS+1H/aH5ay5T4l/5C+oCHC3yQQKOjrMCbWUg75Q3uIZNvlRFF12LXuzG7jKXanKhXGMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8219
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 11/19/25 7:27 PM, Kevin Wolf wrote:
> When new requests arrive at a BlockBackend that is currently drained,
> these requests are queued until the drain section ends.
> 
> There is a race window between blk_root_drained_end() waking up a queued
> request in an iothread from the main thread and blk_wait_while_drained()
> actually being woken up in the iothread and calling blk_in_flight(). If
> the BlockBackend is drained again during this window, drain won't wait
> for this request and it will sneak in when the BlockBackend is already
> supposed to be quiesced. This causes assertion failures in
> bdrv_drain_all_begin() and can have other unintended consequences.
> 
> Fix this by increasing the in_flight counter immediately when scheduling
> the request to be resumed so that the next drain will wait for it to
> complete.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

I can confirm that the crash is no longer reproducible with this fix
applied.  Thanks for looking into this!

Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

