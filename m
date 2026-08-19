Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40761C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwcgf-0006FL-Ud; Wed, 19 Aug 2026 05:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wwcgd-0006Eb-VW; Wed, 19 Aug 2026 05:34:19 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wwcgc-0003Up-9i; Wed, 19 Aug 2026 05:34:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsvcOTtR1rDrrboJsPDwGdq3us8GRq8seRt1VYWW/NPf0I9UTMt1yswaYba9l3wiWmK6l0D5MjTPCMgA6sgfaa25Q0D4Zdc7KO0pUuWQwiGtzm9W5i65LcW05LHCgdrDghyJmuBLECGrzL4l7xJuJd0VXhS4rBsp6QF1+jfPfxKUf4H5J5jbmWd0n7SzJIZ13kddkE7foS+v/NU5zlA1Xa3JW+XO2SzEgdaeZIxxwPOwZHB58KhhRGOsM+z3Co7kzK7ZfAWVvjvLrYvL38i22VrH3kDWeiAnEiuXaxJPtJhOZY3ix5Mmpmsfe00el2hRqcFDtvWUZS0T9DxVafWTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7M3j86QUvzx+AvFA4mxcGaHMUWYDLclNeJDFxYd8qo=;
 b=ecx8lvIuc5n4A5QJQBjD8xY08Wn76UmJIZQpaZ98VbMXxzeeYuqAJ7MwTab7rd4Gn/CYIbwpUiF2+qTWiBH/IZWpC5hYxer0qVa+kxovnlOOzq3b/tTF/t+UXGArc3eXg1mLLdOy/lUp1ezi+PFiZvq9/NgroQtJxhFCGvezVwp/6ZE/zX+mf8WTwvMp6Oj7PxCYx6Z9s6MpdwI2GSl5IblnM74JLFOarIp1h9o9CuzzxXSmMyclDeTbe7BTE17UBuPfQS6GSnOtpN3to8i0VkNJZu2pgMWu49vNFrzwnzeUJ3e9dwtF/a/5Vp3G65Wf8wBfPNT9QI3CaudhsMBY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7M3j86QUvzx+AvFA4mxcGaHMUWYDLclNeJDFxYd8qo=;
 b=UeGQQ0kebzNj3mUv00T6u9b41IYF7s9bVxmf/zANjhKeE0ThZW2haLIl5gPfu7PCQ6yvf0HTyEwo2RVkxexp6ra5urCj9VMQxtN+UTHqrh+4jYFx/Tp0niInFQX/B+9KB9A0YUrJi8XyTrElwigmc/LjkOvNhCyd/heNNGgNk7dOFOpkebgMcFLjR/PZRTT7PSfgbANpvzU8/gZ6A5W1bFbi5weiwFBSqlIEdP1HDGCbfqQbbw6pypvWB/9JxJgzR/VNibZuJ6Vcv8STRpUcfDWgdZb3qEYeA0Vr/7/Sy3i5AbiXOyjb7WLnCuf/V+x6tDie7ILDXuqmkQlFJcomZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAVPR08MB8823.eurprd08.prod.outlook.com (2603:10a6:102:2fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 09:34:12 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 09:34:12 +0000
Message-ID: <401f4865-6493-476f-a352-2ded88e908cb@virtuozzo.com>
Date: Wed, 19 Aug 2026 11:34:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] block/nbd: fix a race in reply processing
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260812102906.894063-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260812102906.894063-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:803:104::38) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAVPR08MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 36924912-9c22-4454-1129-08defdd5075a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|10070799003|376014|18002099003|22082099003|6133799003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: gzFbyH1dFLb6HTjIVnOuZxhTlqGITN+gafIIp4ofl7QXD12Wro3fGeN5eBeqxZ2tFwtwHnbXGJSkuDOTbiv7CBtkmNb0H9OKSJYRNqPHmsbUcrK+mVbhwZeB44Ym0UDZfAFtaqlLQV4T4hxSMH+P4H+E2NNrdllsVh5xpItlsQtXr3q/C5D+FZnUURqhdP60n82H2Ngxn3X2TNWBW7y8ib/6yfI3CsOty91+2tKRtwqC9XPlRqLggCjIeOI9TLDaWMEZQfzxBlnJNXBPjxbPO2TKgLWKWYnqHyShkghKLeNPZrWd2egwA2AYknzLKhcRN7wqWA20PxaVOHxjQB11BQYZG4Cdom8VGZEl261Yvjl7kyzue0MVNPqS28SVp2S6y+SZdKACV/0OnYAtdtzRxmH6X+EwwzlYmdq8d+7fDTCm9z5FCD2GZk6VlWAcpuXYw5xbhEUQ47lTq3gnBfHDT6Lhy3F5rgQyHaPq5kZG208OPjLebXApSxWWeseuu1e2UVceACZW8k+P18jpmNpSjFCtIT6Snd5qcPORUyVrwcBZ+JEd4Z+5uPC1WVXOPLIV4Ch158FsV+GNcS95m9HROQ4g1z0rbmQUE8Uto4dRbjOhSGppNu1geMco8RuP1sCW+G8g/ecZelOEVXMJjfLO7rBqpFMUjIsYYEw+qQetZzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXB5aVEzTlA5dERXRithTjVyZjRsUjVpOHRxU0xXaTFsZjhhbzUwWVBJckxh?=
 =?utf-8?B?NkZYK1gwRklsRUJFbjNJN21qZHFKQlU5b3RiSG9wWDB3QzRnZUFDMzlNU2xY?=
 =?utf-8?B?S3JwZTdMdGtScTZwd1lXbTJTTDRBbkl4Z2xsd2xnS0pjT01iN1pnV2R1RVdw?=
 =?utf-8?B?QzJDZVVWWE1GY3l4cWx1NjVrS0RVV1NRdEtnZzk2UHlBZXZGcHFQbUtkMStn?=
 =?utf-8?B?b2I2cW9kckdjczR2QjFOTjB0dzY3Zm5Da0FUNkd0anVVWnNiVVFTN0FiVnNJ?=
 =?utf-8?B?Q0R3aUpIcitvNFJqYkJKeVN5KzFXdzJlR2ZYeDFPOVlEQ3VmaVVYUWR6K3VZ?=
 =?utf-8?B?akpCMmhMKzBiWk82b2dsT1JCWnBNemFySnc0VVRFVTRsanVxZ0dPRGtTTXBL?=
 =?utf-8?B?dW5nVmJ5dEVxMzhQZ3FoSUVHY2ZTUUlrRDJaYXdxaXd5UXMzakJhMGpZQ0lw?=
 =?utf-8?B?VmN3QTc2MWVEckYwUVhCdE54Z3VUZUx1TXFMS2VIUXAxVDdNbENxZFc5ZHl5?=
 =?utf-8?B?ZXl1OFhZUGR5TTZDRnR4SW9EQ0swSUxUaC96WHE0ZU5YM0Y5NXIxdWVFRVds?=
 =?utf-8?B?cWFUTStOWndKTHl5bERFd1gwZ21ydENCRmFnVnRrd014bSs2dVdTTytwY2k3?=
 =?utf-8?B?NERKRXIrSEtGcGRNZWFLVVhQdHRjL2ZXa2kzSE5RZHYrQWdMT3lJbDg5TU9Z?=
 =?utf-8?B?VU9saXp2aFQ2UUtGUVZrQzJ3OGxLTCsxV0tzUTJwTXI4QkpDcDRyTVg3VnJJ?=
 =?utf-8?B?b2M5SC80SlVRcW5kQmNhTEhScE1RODJaRUhJSXVGeE1oVDFNR0lRbkdENUxP?=
 =?utf-8?B?MytWYUZ1Uy9FMHRxQkVTV1JmNUgvRFdUeWJibEk4NldyOFprU1lEbnJ5bUpN?=
 =?utf-8?B?czN5Y3VmV21Tb1JHOXcxdG5MSFJvNGlwYWxieGtNclZqbkZFekFxRE1CSmRy?=
 =?utf-8?B?elVQLzd5YWlwQW1YeXoxNFpRZ241STZ6ZExPOGVUdlVPS05HZkJjdktXMmR3?=
 =?utf-8?B?UWFIazlyRXkzWEI5VG9LUUNZbVJ6K3VjS0Nndk5DUk9IYUtFQ0pNZzdlcnYz?=
 =?utf-8?B?QXEzZ1pNVlFlVG9KVGt0K0E5c3V0V1VVWVBTYmRLZitzQXcvdmxuMFc0QW1G?=
 =?utf-8?B?S1FHOE91WEZyMjZ3SXZ3MUxpM0d5MkVVT2VaMUxMQnpHQVhSYVZQNXVyZngw?=
 =?utf-8?B?R0VYU1FoZC9xaXdLMjQzazAzZzc3aUlxemVtZTlSbFg4ZisvdEpUcXlFZkZB?=
 =?utf-8?B?SXgrK0llMWNyQ3ZuSjBVVFRoUXE1VzVrcEdlamliZ0RZM1Znem9MSFQ2MzBo?=
 =?utf-8?B?bTd0NkRWaVBMY09mWW5LVXVKcDJkR0Vnc0o1RkpqK0hiSFoxa2RWYWhXd3FG?=
 =?utf-8?B?Y1ZFcjBmVFpTYTFHdXBIMWFTdENCLzViU1U5NjltY20vaEQ4a3Y1ZHl2MG9n?=
 =?utf-8?B?blBKUHhwbnowRjlpaTF5SWhnRmcwcU5mUHpqSElQSnd5eXB5WjhsOW5RdnFN?=
 =?utf-8?B?OWNOOWNOTFhwN1JuTkJ6dU14aXZPQ1ROekRLODJsbmg1cGppbWJxcU1la3kz?=
 =?utf-8?B?bDZRTkJ3U2p3bFpGQnJmL1AvcE9YaFI5K3UrbkVkYjNXdWR3Q0hkUDFLa2Jm?=
 =?utf-8?B?dy9lQXFudnluMXVjdzJaTHIzQ3FrbzlRNTdDd1dSNnl6a0tZa0MrTUtwaXFj?=
 =?utf-8?B?RnpkRTZUcTY3Y2h2dnRtZHFZT3JTSHpVMUR6R3BzanlEOURVanZBQzNPODJa?=
 =?utf-8?B?RlR0dytvaGFmT3llVHNMVVZkV0h3dnhsQTBrY3lYR2hzQWJTK2ZKVERieEhN?=
 =?utf-8?B?bWpmVzhMWXMyWGFqU05wWEFmNFl2TkdHRVdYNVBjcEl3L1IrdFMyaXBSaDJh?=
 =?utf-8?B?YVBJQ1FSWFdvTHQxbjJFaEdmYWQ5T3VwWTZja0NmM05IVEhVRTdYaW5wSXNo?=
 =?utf-8?B?K0tncFpQOXA2dVJHS2JCWFFEYnBYODZlODZQV2J6WmRiRXVEVEpDRUhmcmxT?=
 =?utf-8?B?TExVL3k0dmVQQWw3UklyejZaZWpqRWRUNCtodWliYnpRV05KWnZDQWd2QzRD?=
 =?utf-8?B?NlZKcXlzMVZBaU5sdzQwMjcyR2tJMzJTQm5uK0dVVFJPRUVkYXdVZXVKa0Yx?=
 =?utf-8?B?TjdJWkVvRkZPcDdCZWhCL0ZCTGZHUXdlYk9zTjZob0k2bE10WDBRT3h0dlps?=
 =?utf-8?B?aDE4akpPTkRFMlJYNEF5UkRvWnl1dHBiYlZGb0ZIVGlYNWRRNDFhaHBLby9x?=
 =?utf-8?B?LzF0aUR0dWo3dDZPYTlOM3lUMG5pZll4d1k1c29Da2Jyd29oaVg4ZE1RMDc5?=
 =?utf-8?B?OExZakQ5cDZCZkZwd3VVNVM3ZTRvd3k1aWRXeVlhWGVmQXhJQ2JKY0JtN2RT?=
 =?utf-8?Q?Pkm0sXQpTKzyrO7UG9Qsj76QEDPr6P9IXdn2zZEHaVHNP?=
X-MS-Exchange-AntiSpam-MessageData-1: K49xHCCDS22vVQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36924912-9c22-4454-1129-08defdd5075a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 09:34:12.7748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ktzfHjgc/7vwfzIzUbp3f+vcq+VQ5NV7kXVJtAB6VElaUju8E/d0Scf/ij1zQKnJxYkxtHfkgyEoUXapvHHrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8823
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=den@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/12/26 12:29, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> s->reply is documented as protected by s->receive_mutex, but the cookie
> which owns it is cleared without that mutex. A request waiting for its
> own reply reads the very same field under the mutex, and reads it twice
> in a row, so the owner can clear it in between. The second read returns
> 0, COOKIE_TO_INDEX() turns that into an index of -1, and s->requests[]
> is accessed in front of the array:
>
>   Assertion `!s->requests[ind2].receiving' failed.
>
>   (gdb) p cookie
>   $1 = 8
>   (gdb) p s->reply.cookie
>   $2 = 0
>   (gdb) p &((NBDClientRequest *)s->requests)[-1].receiving
>   $3 = (_Bool *) 0x5555558416c0
>   (gdb) p &s->in_flight
>   $4 = (unsigned int *) 0x5555558416c0
>
> requests[-1].receiving lands on in_flight, which is non-zero while
> requests are outstanding, so the read comes back true and the assertion
> fires. Without the assertion it is a plain out of bounds read.
>
> This was hit in the field, on a virtio-blk disk whose backing chain ends
> in an NBD node, with the virtqueues of that disk spread over three
> iothreads. Two coroutines of one NBD node then run in different threads,
> which is what the race needs: there is no yield point between the two
> reads for the owner to squeeze into, so a single AioContext cannot
> produce it.
>
> Patch 3 is the fix, patches 1 and 2 are what I ran into on the way to
> it. The order is dictated by patch 2: it routes every cookie to index
> conversion through a helper which asserts the range, and for the cookie
> of the reply in flight that assertion only holds once patch 1 stops the
> error paths from leaving a value chosen by the server behind.
>
> Reproduced with a scratch harness which drives one NBD client node from
> two AioContexts against a real qemu-nbd. At -O2 gcc merges all three
> reads of s->reply.cookie in nbd_receive_replies() into a single load, so
> the race is not observable at all in such a build; the gdb output above
> comes from an -O1 build of this branch with the two scratch commits on
> top. The report itself came from a build with coverage instrumentation,
> which is the kind of build that keeps the reads apart.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
> Denis V. Lunev (3):
>   block/nbd: clear reply.cookie when the reply is rejected
>   block/nbd: never index requests[] with an unchecked cookie
>   block/nbd: clear reply.cookie under receive_mutex
>
>  block/nbd.c | 53 +++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 18 deletions(-)
>
>
> base-commit: e1705a25aff35635c360bbaba4c2731d019a422a
ping

