Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0EDC531D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmu2R-0006Fe-O2; Thu, 23 Jul 2026 10:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wmu2Q-0006FP-1p; Thu, 23 Jul 2026 10:04:38 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wmu2N-0004Gz-Va; Thu, 23 Jul 2026 10:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBpMkwaKYZIXMjLtqOjlBZORzHR91lQ4s/INQcv+ViFmSxOO0MCPzj7Xqc8ipYv42yXKZJmWzrWUPsheYGcO3+cE5nprflSiQu4QQbJ4UrxCy62I+KRAsNFuwmP7QpqQcBACBXbquTYVURGoaqjk3uyA1N175se8fmfUM1+wtqGHdKwIb9gCsDFUjgzLNFL2bVoR8+73b4L1chmLOyvOB58WRw6hFM4yE5eeeW/BRXKACdRYjfj2iqzXLpXYVmN6A907NmX4XC59jctFnF17fwa4Dp90tLiICnM/Je5UrSD4bwnuSNaCC+JRTZ1blmLWyBAR62wQMJharQmPHVSG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW44XSrFIfIpOTcdF0coSXfDjswUu84jBY24AW9XhN8=;
 b=bZihth9HaEuCD/dtHzCChSdqXF5ssO7+NMHsG51ppAdYAqHItKHp12U6OmSIAgIHh+jY8AdJl/Y6FkcNSVQLVzFp/CQOjwquZPANLkzNWUdNiOkHG652pt6UftVK2ng5lusxsTazU5xJfW3oKp6Mo1u1kHrZfFzQpMwL2H445ZyG07sxqGxZynP0ck83+Bh4pWWVTNn/BeYXjecVqkUqh373aX+yrP5kP6wBP1bpYo5OktwLzYyPoH+sJnaGOpnZHAmi5VEIrv47KRF6HzCCE3oRb2UMhWlyij5RvdX7vt/yJnas+QICxZvtV+weSM/coTV19HG8dXMSxlWSt8W3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW44XSrFIfIpOTcdF0coSXfDjswUu84jBY24AW9XhN8=;
 b=CDIZDdW3Bgk96a+M3FOC3S7U9hFEEnk4Z/vCqMDj2iMB+nJ4URyAbazzp6vtXk0uHFEd36EfgoHCRtKwuHAXwaDAunsHsS3xCipor8VvYzH49Ip6ne4tV1zEQyDGgxE5GHHusOgQL4HE0NgchwLWeNI3/ONz0FgfhMOdvOvAaQxi3TrwOxT3/QpZ2+uFiH+8nrF8o5sTHG1+aVJXBx6Bowb0SHe1jJyfgFhRt7/CfL6DDzIH6E46dqq5Ixzeg4SRUKtxy7mQnxq0WzAmNMwWCnwk/wwn2D2KUJDH2k10xQRrPx4ZigltnDUXNkjijX6sIYSvGkV+BKLOvq8qBtiluw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DBAPR08MB5720.eurprd08.prod.outlook.com
 (2603:10a6:10:1a1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 14:04:32 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 14:04:32 +0000
Message-ID: <af143df9-d9f9-4f83-874f-df3b11774d79@virtuozzo.com>
Date: Thu, 23 Jul 2026 17:04:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/unit: add reproducer for BlockAcctStats
 histogram locking race
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260723123745.3294227-1-den@openvz.org>
 <20260723123745.3294227-4-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260723123745.3294227-4-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DBAPR08MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 40143683-ee08-4fda-e384-08dee8c351c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VJIIqi2DOteNaDvm7KLLG68dRDJD63QbaN3BptGfwsr2dlto43Kf2U1AICCdSRb6zs6LkEJwlptN9MJ7Ax8eH7ZeegPPhgQkPf1pPxUEei2syrYzRyXu7NDxkZwmmLoTde9BUCodfdZcgwKlKoBTKc579cSTNCTBP9ftJ4jR6FElZhkbBaUlFA5xMWuwVSqha5CnOtWMxk7EfP9uHAthqOYbtKR9uhWou2Kom7sDj7nrjqevt1b36BSnoJZIK2TZ79fQa6p0qDbo7/POHXnsoQdq8gHaMKxRyyKFUkGa15QjQgv7CTW/dmItd2Kukkd5ofCG0AKA01vOIPAejMu4aCgU5PWROlmnqLnLd9ryQ5jL1liPGT3W9ShDjNyCbox3RH40759bpvljpdcIl9rTh2wTwr2DnYAHqKFltZQ7buUr6HNNEJAxQyG76q/Qti8K78CruXD6vTzbCA3YKVN3Ia2mTw/FaB2nnJonoDTOC8X6ukjID0eIal7iBw0Xzj9WP1R5IgZ7iwDQp2fervNNpo9t/YCSLxQNfoRk6kpUe3eJ06r4ojyE5U/UwQ2HQkW7NpzFbkNpvk8q6s3XFpAvSlGjkH0foFkpQTWZsN+EGJ+Zp54NprJ0mkFvKShaxVRzD1CC+s50BHfT1zUz2wAMEqqOkaXua27BGHbItEyQ+gI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2xCOVFyZGJmTkJJZVFhcm1PVTFZSlExdTJ0V0tNczVYbFQ0cE5aeUd3anRs?=
 =?utf-8?B?QkhFSWJNQjZyb29qRE5sbUg1Z2NCL0R6TFhON3VtaVovV0l4TmMyRlZVNS9w?=
 =?utf-8?B?U2VHbWdIZytLM3lIakhoZ2FmVEJUQ0xFUkdXNmFnS25xRkNJNkY2cHp6QVdP?=
 =?utf-8?B?ZFcxZXJ1MUw0Vlk3cE00dVhwZWdOc1Y2RWthRUFlUWJCVURWWVJSMEJvNlpl?=
 =?utf-8?B?Ulo2ZDJWYTgybGgzREJicHpMU0VuOXhKTkdkOFNuZUtGZlVtWUxOOHQ5Z0No?=
 =?utf-8?B?bWh6b2RPNVVPTzByZ1UxcVZva1dINE5Wd3gxb1Zhdk5ZZUpZZ0I1Um9JRng4?=
 =?utf-8?B?bVNtTHlGQ3dOb1JpV3NWRjNWYjR0WE44QkFOQTRoYXFjdEJSZTh6RnVmNGVK?=
 =?utf-8?B?ZTJUNUp0ampFbTBuR1BlQlZxQytWVy9NYUNkQklUYkZUZVhxZVZFbzFDdkdR?=
 =?utf-8?B?ZGwyNkVnRGlPRWsyaHYrMXI2aWdSMXlndnZXSWVTUzNDVTkwMk8rNHpqT0tC?=
 =?utf-8?B?cUNBanloL3NUSnY3QXEvdHl6YmFzYTNDQzN1TDRTb002em9qbnZvVVQ1S3Rm?=
 =?utf-8?B?MURzMmNVdWlMMnAwemVyYXRPTDIyeDhqRU9OQVdDcXY0aWJsdTd4TFR2Q1la?=
 =?utf-8?B?NUFLNUpzWFZzUU5uemk4MGFUajRnbC9CRlhBWXBUMytLWVMvNW55RVJDckJ1?=
 =?utf-8?B?bTJNYVFpS3JDb3ZXQVViSkRNb0hHOEtHZW1lYVBDWHU0V1ZaajJDTHRtZndO?=
 =?utf-8?B?ZGtZRUI2aUsxVGxERzlPam9TRnpCQ3luaEh3aGczaEdERHBQQ2l2bldaZE9U?=
 =?utf-8?B?YXRjZC9Jd0NVcVhCSE93MXcvcEY5ekQ2L1J4KzMycmNqNXc1UUZuWnFzNlRY?=
 =?utf-8?B?VTVCV2FZWlFSYVBsNEJ6KzdjRm1HSGd5OXNzNjV2RFliQWQ1NHhsNWJaUzZ4?=
 =?utf-8?B?WXRVeFUzTVk4U2FNRjFtNXlhcWVXdTRCSzBpVXV5Tk43WGQ2MWF5Vk04VFhr?=
 =?utf-8?B?ajI5bmZiN0hBeXI2VVVVZVRWdTgvNjVHbzY1NHBwcEIxNEVlbjFrb0NUdHRm?=
 =?utf-8?B?RndIQVovVkU4dEszajUvTHhCNlNhaTVhNkVlRTlzUjJDNG02dGFaTWtJUjha?=
 =?utf-8?B?RUp4c05LVDBlaDJVN2cyVElrdXJaazZUWEkvdy9uK1hlejlrKzBPeXJaQmtS?=
 =?utf-8?B?YkNHWkhjRU8rZGMzb1YzZU5SZkREZzcvRmQ1L01ERllyd1VtaXNSSWhicmxF?=
 =?utf-8?B?OWs1UkhMNEVkNEVkMERHYWN4SG4ycllsNlZHYmYvdFViL0tNYmJvN3hWNG0w?=
 =?utf-8?B?N3JLVnBCNWdNSTdoaFQ2MWsvRWRiMDQ2cUpmbkk3UWlwTDNpWFNIdFlVUHRU?=
 =?utf-8?B?UHJaQytTTnRDVU4vUkUxSURJeHZVeThNNkpkV0c0SHhnazBQMkFUYmkzazQ3?=
 =?utf-8?B?a1kyRkFwVGdnU0VtYUxacXNJY05xcDNldDl1Mzk1d3RRdUo1SDhBOWcyamFV?=
 =?utf-8?B?MUVMbExYbUV0UkZDQVVqclYyU3dnWHFDYUpETTR3NHJKUXdBbHVtVno2d3pa?=
 =?utf-8?B?Tm9aUUxLMkhxcks1d1FxUzAzaGFFRElqL1R0SGRpbE9HMkZYQlZRVXNjbEF6?=
 =?utf-8?B?Ri8xdWoyQ3ZFK2xHclhHYk1LQ2MwNFVtS0lUK08rRm5KdkJQUXF1cTVJK3Qx?=
 =?utf-8?B?WXgxMStuR3ZkREdES25WdEZleXltaFNCM3graFR3OWVIOTcyOVc0ajV2R0x1?=
 =?utf-8?B?YndIc1FXNUxEdGVvTkV2aDkzbkhqLzlkZWtyazFkZ29SZk4wWkdIZ1kyRDFt?=
 =?utf-8?B?WWxLUVg3OXNjTk5OTEM2OVA4UG16eUVpWHlUa25OaHpRdTBPRDMxZk5YMnk0?=
 =?utf-8?B?Y2o0aGtTK1R1TkJ2ZHVVSHNkODNwL29uam5PN2lqeis0QzdzbWNPNGNiNDRy?=
 =?utf-8?B?eGFDcVNWTzFvUGZSckQ3Y0tSVFNNVGNFdjNSWStRT1JPQmthc1RJTjhCb00v?=
 =?utf-8?B?ZWxjWURkb2lySDk4dDkvNFBkN09mTVJMN0VvRm1pRWhFVkZ4b2tYSCt2MXhX?=
 =?utf-8?B?a3B6TWZxVlovQ3d6cFVTdUdGeEFRUVJOZzc0TmFkcU5vR2JUUzhpT3A1MXFG?=
 =?utf-8?B?R3VGc2dOU3pNdFA1Uk95WHQ3bFRuOXJVT0dVOG96dXEvcmljNUc0MHhaVStU?=
 =?utf-8?B?RVRLckhpUzIwazM5b0ZuTXpjOXhCdEJCZktPYXZWbkI5YnFoYXpuZXRJdUsv?=
 =?utf-8?B?c2hidFhiLzhTQ1N2b0wvMnF3ckdLVFlWRjgvWUUxWHFpbUtFaTFIUEhwUGhS?=
 =?utf-8?B?LzRPZTlGenk5SHlIcFNFTFBuWUhOSEVhNmgzaEpvdTNpRjU4eGhtblhpTGRa?=
 =?utf-8?Q?792g/eHTzjYvKSFc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40143683-ee08-4fda-e384-08dee8c351c8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 14:04:32.2768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rp787499Cl35gKLXOAIXkpL1RGdXokvY8YoFX8iP1iXdX6WgrjolNUIqjsh0XeA2QFCQrMhgwO7EPAvq+b+YCEabchHtD02EIvh/AqWr4EY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5720
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 7/23/26 3:37 PM, Denis V. Lunev wrote:
> block_latency_histogram_set() and block_latency_histograms_clear()
> replace BlockLatencyHistogram's nbins/boundaries/bins without taking
> stats->lock, while block_account_one_io() reads those same fields
> under that lock from whatever iothread completes the I/O.
> 
> Add a test that races two real threads against
> block_latency_histogram_set() and
> block_acct_start()/block_acct_done() on the same BlockAcctStats.
> Applied here it passes, since the previous two commits already take
> the lock; reverting them locally reproduces the abort this series
> fixes, in about a second.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  tests/unit/meson.build             |   1 +
>  tests/unit/test-block-accounting.c | 114 +++++++++++++++++++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 tests/unit/test-block-accounting.c
> 
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index 5ba6b1a230..dc3fb954c0 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -75,6 +75,7 @@ if have_block
>      'test-blockjob': [testblock],
>      'test-blockjob-txn': [testblock],
>      'test-block-backend': [testblock],
> +    'test-block-accounting': [testblock],
>      'test-block-iothread': [testblock],
>      'test-write-threshold': [testblock],
>      'test-crypto-hash': [crypto],
> diff --git a/tests/unit/test-block-accounting.c b/tests/unit/test-block-accounting.c
> new file mode 100644
> index 0000000000..e749b73749
> --- /dev/null
> +++ b/tests/unit/test-block-accounting.c
> @@ -0,0 +1,114 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * BlockAcctStats latency histogram locking regression test
> + *
> + * Copyright (c) 2026 Virtuozzo International GmbH.
> + *
> + * Regression test for missing stats->lock in
> + * block_latency_histogram_set()/block_latency_histograms_clear(),
> + * racing block_account_one_io() reading the same fields from an
> + * iothread. Aborts reliably before the fix, passes after it.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "block/block.h"
> +#include "block/accounting.h"
> +#include "system/block-backend.h"
> +#include "system/block-backend-io.h"
> +#include "qapi/error.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/thread.h"
> +
> +#define RACE_DURATION_MS 2000
> +#define NUM_READER_THREADS 8
> +
> +static bool stop_workers;
> +
> +/*
> + * Different bin counts, so the writer's g_free()/g_new() churn can be
> + * caught mid-update. Values are small enough (nanoseconds) that plain
> + * back-to-back start/done calls exercise every bin without sleeping.
> + */
> +static uint64List boundaries_a[] = {
> +    { .next = &boundaries_a[1], .value = 1000 },
> +    { .next = &boundaries_a[2], .value = 5000 },
> +    { .next = NULL,             .value = 50000 },
> +};
> +
> +static uint64List boundaries_b[] = {
> +    { .next = &boundaries_b[1], .value = 800 },
> +    { .next = &boundaries_b[2], .value = 3000 },
> +    { .next = &boundaries_b[3], .value = 20000 },
> +    { .next = NULL,             .value = 200000 },
> +};
> +
> +static void *writer_thread(void *opaque)
> +{
> +    BlockAcctStats *stats = opaque;
> +
> +    while (!qatomic_read(&stop_workers)) {
> +        block_latency_histogram_set(stats, BLOCK_ACCT_READ, boundaries_a);
> +        block_latency_histogram_set(stats, BLOCK_ACCT_READ, boundaries_b);

We fixed block_latency_histograms_clear() in the 1st patch but don't
cover it here in the test.  Should we add a call to
block_latency_histograms_clear(stats) here in the end of while loop to
get it covered?

Andrey

> +    }
> +
> +    return NULL;
> +}
> +
> +static void *reader_thread(void *opaque)
> +{
> +    BlockAcctStats *stats = opaque;
> +
> +    while (!qatomic_read(&stop_workers)) {
> +        BlockAcctCookie cookie;
> +
> +        block_acct_start(stats, &cookie, 4096, BLOCK_ACCT_READ);
> +        block_acct_done(stats, &cookie);
> +    }
> +
> +    return NULL;
> +}
> +
> +static void test_latency_histogram_race(void)
> +{
> +    BlockBackend *blk = blk_new(qemu_get_aio_context(),
> +                                BLK_PERM_ALL, BLK_PERM_ALL);
> +    BlockAcctStats *stats = blk_get_stats(blk);
> +    QemuThread writer, readers[NUM_READER_THREADS];
> +    int i;
> +
> +    /* Histogram has to be enabled (bins != NULL) before racing it. */
> +    g_assert(block_latency_histogram_set(stats, BLOCK_ACCT_READ,
> +                                         boundaries_a) == 0);
> +
> +    stop_workers = false;
> +    qemu_thread_create(&writer, "hist-writer", writer_thread, stats,
> +                       QEMU_THREAD_JOINABLE);
> +    for (i = 0; i < NUM_READER_THREADS; i++) {
> +        qemu_thread_create(&readers[i], "hist-reader", reader_thread, stats,
> +                           QEMU_THREAD_JOINABLE);
> +    }
> +
> +    g_usleep(RACE_DURATION_MS * 1000);
> +    qatomic_set(&stop_workers, true);
> +
> +    qemu_thread_join(&writer);
> +    for (i = 0; i < NUM_READER_THREADS; i++) {
> +        qemu_thread_join(&readers[i]);
> +    }
> +
> +    blk_unref(blk);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    bdrv_init();
> +    qemu_init_main_loop(&error_abort);
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    g_test_add_func("/block-accounting/latency_histogram_race",
> +                    test_latency_histogram_race);
> +
> +    return g_test_run();
> +}


