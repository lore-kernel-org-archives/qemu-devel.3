Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6216CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 21:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMYZN-0006DL-Du; Mon, 11 May 2026 17:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wMYZM-0006Cm-2y; Mon, 11 May 2026 17:53:44 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wMYZK-0004XW-BF; Mon, 11 May 2026 17:53:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Moqzf1rprx3H7GCxU3rtJcNeI9aPsIxZ8Coh+jjaAbuO1ztVA8Qp4lodutgOorfRSPJKJY0Ok2ONGCGHCzKlsNhx4CWL9Jjd20tyLwBapqLcexH/b8kEc6wTQpptf8PrGLUnWTW2iy2L9bTENB58TC2rUKPbgaap1ybYvBbqz6GiKNb6WZXIkoy18TbqhXGAvIqVnx2lyqgiX9yfbsfBf2Oz12jzAR9v/41PPuyFYewuUQdLJZMKCjDtos7+UkM0eUglxLLbHKWLeQsWM02NGArIUMzncNV9WEjAk5sE0cSTbDRIULv8pr/DRKkfKawMXtn/o6AuQWETBbTvuHuFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HFPYRb6v6cz2lm+Fqx7OlcnuPZV/u9ME+1k3O+g4Hw=;
 b=jZd1v6AWuLjh9ony783uWyOsA77IXd9buqKciu4nN9/rJY1GkIKiUMCiThnvvqM3bTXLMC9UrRdQsB6wMVesxOpfImgcvevyX8FmFOhiLE6pse9Y5pPYDMEUK2XuwpwjM6JOWVza1gkYTzNGlUIYgg9QNHGwmZlU/vXA+2NfRpP0swGqY7XaiqadcTEuwYzX9zXcUMbn6MQNK0Y0NW+vu9ibB7ALrD16fgq9fsv/JcSlZoaCWPCrxh2zpZK9SYvkZt/Hb+QoQGZLSTvaXKGAyOWqKS1hXJZWmrv9VxmXrlydaJkIri8Qg42nsdEn84jU7lX7j9E8DoeTW62x8P/2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HFPYRb6v6cz2lm+Fqx7OlcnuPZV/u9ME+1k3O+g4Hw=;
 b=A34PoEHEO1Kcmff05GD7UO1DbK1gEdLPIiVYa0a8F2HA3bqSVVN8cxsQZppYpOQcmuBlYHmQ5L4w56hacVwU71zGCsxp9sDVaEAUJ6xSwDswllE/j0j5HdEprBpc/D8Kxpx++5DY0QEa0ahC07rs2QkR9Hre24uq8AhO0QE5iRYkGcgymv8LkpQYGEFPpb4rx4H9DGEoEpoYgOIYIiuE1S5RwrYJYWLmhYO7iIT2piuQDcBr14tknuUFE18bFjxREdOFjH1ekUvBGbJ2h3qZvBnW+OJsi3P1eLTY3qAwBScaevdD9ICyZawIKVnqwINR8XvSb7VPO5+rvIGQC8Q8kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA4PR08MB6160.eurprd08.prod.outlook.com (2603:10a6:102:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 11 May
 2026 21:53:38 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%4]) with mapi id 15.20.9913.009; Mon, 11 May 2026
 21:53:38 +0000
Message-ID: <055dc8bf-f5f8-44e3-b1da-b21e05b70d94@virtuozzo.com>
Date: Mon, 11 May 2026 23:53:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: fix two missed-wakeup hangs on shutdown path
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
References: <20260424103917.248668-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260424103917.248668-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:803:64::25) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA4PR08MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3bbd9c-d987-4aff-a3de-08deafa7c237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7sXfAffYOn03O0yjW6PRdaeehgunGohySMK+dyRvHfqEzZ2Q/bb+vrOwgkwDghRkl1hPy0xmwI0L2bGUKq0SOd2sLEPgT15a14KfBlvpXsVAnsihtOGMIMZZjAz0xpAWIvC5p6pxX1KgJE3IsjDPu4llynP7kCJhuCKvPqPqxASbo5zeAyTV6mypxTfwWIskz5caNnDG6/qLjaa71BJ+PuB1M+ywijA6MYjqKe+Vva6CjQh7A//X0Ahw8aB5r2iiqZEh0Fb0A+ey9DXQv0VFuwFHwct7pIRSS9U+49deY0xTb3MlOzk3nL90909TrlONYbiBXJWqfSPbLvaPk1yRAGCsL0+HnTjX9b9xJ/0MeQh1cwxKchMPLVj3acUitlI7+0La/ACJVZ6zVqo/C1NAwtJFpoy2qQHSOVeNc2WAnKdfeU1WNowAtYtHhiOTTJjogCggvtBw3Wz76evp69keuqeNHPQ5/t9tadONsIW1ObMjtypNOV/gyZrCfw5YirXdu9mTNvKRE9oVD84NHCV5VEkzipm6p4EkCmOX29rILfBFTj9Q38ocCxqTaTVGJewOfqufdm95W/JEQsSICr0WH/lqnD2vuARdgBkL0ui3SK9kcJC8/Nh1as4j9wcD0hv9plRGwQeubb/EL5SXEkg+lIjkUa8hWOdS5A5MtKUZDU/aOfKVVAGQb/v+cScmebxb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VCtpcDF0OXkwaC9WNnpLa1QwL29GVjUxUkQzbFRYajFlZzFVd1dvdktGT3B6?=
 =?utf-8?B?NEdndzBaakNtUFpQMTA4VHRXTG1UTHFHdEdkODZZa0lyQlJTUStDbU56Zk9x?=
 =?utf-8?B?Z2NvaDFwdUtyM29oVmFMeHkwNzRsWlc0MFh0ZmdtY2FJQkw1SVN0ckV6bngr?=
 =?utf-8?B?MzBMUnNhMXlyUGtNNFVENzV6dWRYbTFydEh3NmpoR29FeHNCWE5zMVI3VitR?=
 =?utf-8?B?TkF1ZEhNSERYVFpCS21GV0lCQWNGTzNZNEJqbUt0dEpScDhRcm9kSzBJdFdI?=
 =?utf-8?B?L3BoY0t1clYrdVYrZ29XclNZWGdLd3lOYnVvYWlSY003QmtDYVNZa21VcXpp?=
 =?utf-8?B?QUJyRGwwckNpcjBHZ2N0RUlQM0FkaDFCclNuRFZucWhhSXlRRjBjWTdKd2JL?=
 =?utf-8?B?b0ZnblNOSEF4cXM1UGRhZFpaeUFtc2VYSmlocUhSTWpxL2ozZWNhYzU2bzlK?=
 =?utf-8?B?SkJmV2tLOW1maXpxVFZTTHBQZTFhNDRzcTNmUGV4RGt6dlcveDEwVjY4bTA3?=
 =?utf-8?B?ckZKZDFvRERJMVBEbkx2dmh6MFJuU3R4SHB3QWQ3Si9GUThYNmtHZGQvZnlO?=
 =?utf-8?B?a1lGK0kzWjBZSnNUNFFRNEVkVHJsYm1hbytoY2FVTjFiRVZ3d2pQTHoxK20z?=
 =?utf-8?B?TjZFbHZxTkRsYVozSmJzeXZZSEYyL3VkNXh2c0tYN1NnRTBvazNEYTdwL3lZ?=
 =?utf-8?B?OExXcm56S2dsQlJaU0JPK1NzNi9yZ3g1RjNzVjB3ME9WY29XbUF0c0RmWTFN?=
 =?utf-8?B?RnNiVHRRa2JMaGRFeGhzSVhwQk5Ob0p0UVBKb0UyV1hDQVlndDhLYXR2a1M0?=
 =?utf-8?B?cm5WNnBBbTl4c0hDZUZJOThjWU0vbHpvN1BwNXZGVDRqcTRZZzhDUTV2cXN4?=
 =?utf-8?B?NlY1dExNenFnaVVSdmhlZ0FtZFl0eFdEMFZPUVhzK2hJYkFxR3NBbk80V0Jo?=
 =?utf-8?B?UGxNcG0yQWFlUkVOdFFHZjBhdVZsNGdVQ01YSHFBZnIvTXgwUjQ3cXFIL0Uz?=
 =?utf-8?B?OEJ2UVpkdEFpbUkrNTRkWGY5QTZqbjVOL1JQZjh4SW80MkxubFZ2dzZKUEdm?=
 =?utf-8?B?eFlGSExHNVJPOG93ZUxpR0Z0eE9CNVJEWDdrUy8veDlWcVdDVHNhdG1SYkto?=
 =?utf-8?B?NFp4OE0vYm9pWkxVSHkzR3dKWFVTUE9RNmE3eHpwUWh6OU5DR3VVYlVlSmxv?=
 =?utf-8?B?YS9QbW9rQkhJRWtzRVlPaEg4bzBDWnljQW5qUHFMODRTV3R4QVFwQno5d1Uv?=
 =?utf-8?B?NGIyVVhtbHdrMjJnTk03NHVLc2pjb3RzTFQraHpLZzJlZHZrc1JDYlc3ZHVk?=
 =?utf-8?B?NVU3YS8xTWIrbjJTK3lFVGdjQjZJcXRVdnpyOTdJN3BCYzlZVUJYWDczL3JE?=
 =?utf-8?B?ZFhwdGs4NU53dklpaE1MbjhZcWRzVnM0K1ZpNGlPU0ErK3FtaGZQYTZjdHJr?=
 =?utf-8?B?TFMxczl1Sy9RRzBlZmxtRWwvRStxajRGZitHZVM2cHFqcFE3OWlLMXlIb3NW?=
 =?utf-8?B?dERUR1pQb2lvVFF0OTk5eXhMbVpRY0RYTTlMR1VkUlplR2pramlmZHdOMW1O?=
 =?utf-8?B?YlNYT25lQmZMbGhjeU4wSTJJWVRPN0dZc2hTSEN5eUp0RFVoUGJadVBQL2tn?=
 =?utf-8?B?a1J0TGlUOXZrVHdxbG5nRHJDK2xnWkQrVnF1ZGk3S0xXU1hZMVZkK0t0U0Ey?=
 =?utf-8?B?aVpOOVRlZ25EU3NWc2p4cHdGWjZSc25tci9INGxCR283SzJwaEQxWHRIVzBu?=
 =?utf-8?B?aUtBQSszVGhFQkJIR2hNdGREWk9jZGYzQThZNXZNTG94MnBnWGx6YXorclpK?=
 =?utf-8?B?bDVKWFlXMTdIRDlqNk91QVRrbmFUbVlBN1k0TE8zYTZKc0JVbitQcFU5NnRH?=
 =?utf-8?B?UVJWOVc1WDluWWZlNDhHbktvV2pQb3NLTXVuYTBnWWVZTWpudjNEVmNMUDgw?=
 =?utf-8?B?ckh6ZStEMUpTUTNGR1ZNd0dvVkxWV2VXcGFlTWI5aStBTzUxOVptQU1IYWNI?=
 =?utf-8?B?bVlBMUxFd0lWMzlEcUZJVVZtNGhkYysrKzN4ajJoNVNudEJkT2VQVGxFeVJv?=
 =?utf-8?B?WU9RWFRWL091cU1jY0h6NytoQ1ZDQXRsbTE4cFU4UllKZEFTOUtDSjFTNmNG?=
 =?utf-8?B?MHUwRmo5YXZJY0x0WTRkR3ZPMGFIZFR3Sm96dTliQTdlQ0N0Zm1ickd6bWVs?=
 =?utf-8?B?YnRVMmovNy9IU3FFTlNrVjR4NE1YUUpveEdlNXNXdWJCQ0tEU2U4N25YM211?=
 =?utf-8?B?cmc3RUNYM3N3eFM3Qk1SN0tzVXA0TjVHMXN1SFVJaU9pbVk1T0wrcEcrMHhB?=
 =?utf-8?B?anlVUUdybFNqNktLODNIN2UvT2M3Q1o3TFNSTkkyVFNicVFDcDRBbkZwalFt?=
 =?utf-8?Q?leVLmYmADfEA5h3WKNTCD2LmR2+1DZCrrWgI2wD4dC7zo?=
X-MS-Exchange-AntiSpam-MessageData-1: cxdQYbMbWokHvQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3bbd9c-d987-4aff-a3de-08deafa7c237
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 21:53:38.8361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQfHTxJZ2wv1KpqNBxchh7tgYihdqc91XZSOnjqS/TZJgc8TEtsvSHW441UyhyX/5scY9WEmx/18RmN7OgULyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6160
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 4/24/26 12:39, Denis V. Lunev wrote:
> Problem
> -------
>
> The qemu shutdown / blockdev-close path can deadlock permanently on
> upstream master.  The main thread enters ppoll(timeout=-1) holding
> BQL, no other thread has a wake source that points back at it, and
> qemu has to be SIGKILLed.  The hang has no timeout -- it is a hard
> deadlock, not a slow operation; behind BQL, RCU, VCPUs and every
> iothread path that needs BQL stall with it.
>
> Two independent missed-wakeup races in the block layer contribute.
> Both share the same shape: a waiter arms on one side, the waker
> reads stale state on its fast path and silently skips the kick, and
> nothing else on the AioContext will fire to recover.  They are
> different bugs in different subsystems and each patch stands on its
> own; they are posted together because they surface through the same
> test and the same symptom and are easiest to diagnose side by side.
>
> Depending on which race fires, the main thread backtrace at the
> moment of hang is one of:
>
>   ppoll -> aio_poll -> bdrv_graph_wrlock -> blk_remove_bs
>       (patch 1 -- block/graph-lock)
>
>   ppoll -> aio_poll -> cache_clean_timer_del_and_wait -> qcow2_close
>       (patch 2 -- block/qcow2 cache_clean_timer)
>
> Race diagrams and the exact stale-state read are in each patch's
> commit message.
>
> Reproducer
> ----------
>
> Environment used for the numbers below: 4-vCPU VM guest,
> kernel 6.12.x, upstream master at bb230769b4.  On modern bare-metal
> the window is narrow enough that the hangs rarely reproduce without
> a VM -- a VM guest under full CPU saturation is what makes the
> timing reliable.  Downstream trees that still use plain
> bdrv_graph_wrlock() in blk_remove_bs() hit the graph-lock race on
> the first iteration without any stress at all.
>
>     # reproducer
>     stress-ng --cpu "$(nproc)" --timeout 0 &
>     for r in $(seq 20); do
>         timeout 120 ./build/tests/qemu-iotests/check -qcow2 iothreads-create
>     done
>     kill %1
>
> With `stress-ng --cpu $(nproc)` both races surface.  With
> `stress-ng --cpu $(($(nproc) - 1))` or without a stressor neither
> reproduces reliably across 20 iterations.
>
> When a race fires, the Python QMP client times out on vm.run_job()
> after 5 s, the qemu process keeps running but never makes forward
> progress, and the outer `timeout 120` eventually kills it.  attach
> gdb before the timeout kills qemu to capture the stack and
> distinguish which of the two races fired.
>
> Results
> -------
>
> Same guest, 20 iterations of the loop above:
>
>   upstream master:            10/20 FAIL (first fail at iter #2)
>   master + both patches:      20/20 PASS
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fiona Ebner <f.ebner@proxmox.com>
> Cc: Hanna Czenczek <hreitz@redhat.com>
>
> Denis V. Lunev (2):
>   block/graph-lock: fix missed wakeup in bdrv_graph_co_rdunlock()
>   block/qcow2: fix hangup in cache_clean_timer cancellation
>
>  block/graph-lock.c | 12 +++++-------
>  block/qcow2.c      | 28 +++++++++++++++++-----------
>  2 files changed, 22 insertions(+), 18 deletions(-)
>
> --
> 2.51.0
ping

