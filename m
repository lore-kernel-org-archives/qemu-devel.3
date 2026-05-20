Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848E4CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 14:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPhru-0006AN-Ex; Wed, 20 May 2026 10:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wPhrd-00064B-1t; Wed, 20 May 2026 10:25:39 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wPhra-0004GI-Vb; Wed, 20 May 2026 10:25:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rax5A2BkW8Hu5OEPxNQo8iXvjPiuKVkLiBNbNo459AdDKrQ4kI30287EbGpg2LwU/z1CX14OmTnGO58SLpM3fhUVUkZbC7UrKQqqRBsjG0Zu9ibLIIzcAvJ9Oeesg1F+KfB9oNjxGM/bxkas34ugK6uYPhL5RyKCSU3Ei6wtPRWl7nKCmunKECte4bsDjPg/Mz5F07nUM3BP2afXO+VsL9WsgJLN60Lc6GhM1VrEu/LXRewUvE3bzt6xqXgibubOvzK7KjIr/Y9pjr9HzHfw1UBwNIFeAWPEBT3SgFtRPyJpd8DGa/LrCipWiO39Z5tyuI0BvmNoRaMowzBTk3+ggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpQq8gKeWJvHRSC0rVZeopfVdc0LhjSabxCVByaXarY=;
 b=weYIeZgwn4o9KF2j2fT+yJkV7pf2XANoBr/4kB9OqwT1exFkAfXP8efh0c5Jn/pA/h2dWIXgCX0QXKe3FZN4KdX1Xmvg8dTHzlYuQ1r60Pemwyf3IDHzSGstqbfjysDSp2k2jj59AMj3jrEnywxEwwXU6lGP+rgCxmAe9VTqYUwXFuEolfygxpags03U2oUNEQtkqwfKKYtaioNjDEjq0OYc8f15/LriYND8T5bQt/MMCdzsAAAxGT6RBbedHYHKWFBvkJLXb4zJU3XK/JNNXc3tmyU4X4pxoZknhKAZ+vQyzp58hK+iUN/+wSqgN1pC3hpNx3E26yAv84PaksebSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpQq8gKeWJvHRSC0rVZeopfVdc0LhjSabxCVByaXarY=;
 b=ir8qFP7u6NXtx7ZUVtMmq5FuaD3xgkOXf7YbzlKk1vCtUNVLO8jXD01CWZY/rpxPlLsKBvscQYEpJ0M+NG7HfJuLBcsulLwG8HiGgPoYLiK1cwbzkBq4B+5wfi8vAM770m35m7/zHBBQ8JlNYXJZLvQZZUL4eVrPHCalhpRXZazXSADUw8tV+4o7rrZJ/v5ycK9wDWM+c/llfIVvruxqv9OFu9P+5MMeOvOgkamSo5V/yingHRxjxGzl2XwxGt2wy3ioi/ITHyJ6FO+hb7P+TCL9aBtidsn+0VqW62OeriSSPn6YMzGGV2edVHvFX+SBgCBBdumj3tv5dQOYFi/RTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS2PR08MB8781.eurprd08.prod.outlook.com (2603:10a6:20b:5f1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 14:25:27 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 14:25:26 +0000
Message-ID: <45af4516-c2eb-4fd4-820f-651ceb07877b@virtuozzo.com>
Date: Wed, 20 May 2026 16:25:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block/linux-aio: bound ioq_submit() recursion depth
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260428105811.1325119-2-den@openvz.org>
 <9fc3e8ab-c2a3-4573-9fb4-764d8321bae5@virtuozzo.com>
 <20260519201942.GA335826@fedora>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260519201942.GA335826@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:803:1::18) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS2PR08MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e8d842-784a-4206-e617-08deb67ba320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|4143699003|22082099003|18002099003|56012099003|5023799004;
X-Microsoft-Antispam-Message-Info: wVQ1O+1eaLDyEEMXTiBcCLDNP9oEWRN61sRlIDVQXuXcW9LfVzsAHWAqkj3N8kDSHQPRmWuM90PZvwfnsw+rxURQ1iQdwSXQHLMJwCrTzkAwudLsQ650QgkPn24Jqepj0xUj/bwRCaAV4Bv4mKTfQeFq2ODLmvnl3Lg7EYS2PT2YExCiABgonA7GMC8qHk7qAqycMk15XPYGH3M17/PHE2OSlI38SxqxcIwryW+s6znjsaLoOz3ZJrEhtIpSiP0Owx2I4wr66efmT2HqvsuvloN7T8x8RkBNg5uTDSvsempIBf/9iOjIcV/uFDPfU88dlomF7PDe/kCpqABtytOhzWQ7FBNN5XtM6dDVQtlqITkK8NgjcmE2iB0wtqg1Dz7+SW5Z+Zes25SO2P31ca4TCg2djRDirwhKxdWCGyGgEBwQdSi+jpkBNLpT1s7l+ZaL7Dpz7F+QiRu67e24dW965KPR+s6wzTT7HYyVeWKPMQEqGBke+xwVx1tVj3faCQVIXvp+xMFyuDDknCy1iDWW7GcWNnlrq8+eSfLJCBTuFljEwV7jtzAUxVI3NoTm8yi7ctbBU7vJ3It3vnsjOruw31ePO3bp8dDcUff5r3IZhlZ0RdgWMgJJkd1HSRvQKxIcA6unhDt70BsdTFHkQhYU5DiIIdDg/LU17i1demsETcAPax0xqdXERZoNO8wgNRr3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(4143699003)(22082099003)(18002099003)(56012099003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnlSTXNBcU02T0xCOGRkMDJXVEFCUVNBTGdRckQ0RC9pNE52Mk5FcGJ2cWxz?=
 =?utf-8?B?STRLTEpCcUFUQlRPRTVKSU1iNExNRjdRaFJybTVRbUwyeGtaS1Fhdmd1a3BW?=
 =?utf-8?B?TlNLQWNwcWorL3lqdDZIbVM4VE5zd21oeWxVNHRZbnlIZTBIVlYrQlhFU2Zj?=
 =?utf-8?B?clVhcXM2OHRub1ZUelh4YVN6emRmNEtXaG9WTytuYmV4NnpRWkw4SmVtblpE?=
 =?utf-8?B?M3A3SWFwM1A5d1plODJ0NkN4bVZJakRZazFkUWs0TjEzcXBuU3NlRHdjbktT?=
 =?utf-8?B?dkRhTVExQU5QK0xMcnUrcGRoZENLTEVuL2NObDI0VjZJT0kyTTdRakdGK1N1?=
 =?utf-8?B?Y0JxbHlVd1V2bDFhNG9nY0FaQ2k5emN4TUEzRzJXZEFSaTlZdWR6ZzNNWldx?=
 =?utf-8?B?bnlzeTVEUk50TmVRdGVyWmt4NDA0c1NIRHdzUUJXT2tqNUJRcjliMkc2U01Z?=
 =?utf-8?B?ZFRocFVTMjloeVVhWC96bk83aG1DOTdxWnh0VEdSRk5KMlcrNktmSkRvNWNq?=
 =?utf-8?B?U0sxLzdaSk55ZlNMOXJtMzhsM2hLVytlOTFiRWlQYkFSbjJkMUtVQ29zcmRZ?=
 =?utf-8?B?VVFrbHJQeXUzYTJscHY4anQ4Tm4vRDdyVWhNb0JHVjZNWTQ3enY4QVdMMWxF?=
 =?utf-8?B?dVFDQ1ZsdDBRcVNCWXFRdDQ4RjVHdXVQV2t0L296NlA5LzJ0TVlVT282bTA4?=
 =?utf-8?B?aEcrVzl2cFRmZ1Y0d0l5MHFNUFJoclh1WWpVZTNQaHpzbDY1eGEyS0graCtB?=
 =?utf-8?B?dEtXQnlUMzgvaXlKeWFHUjVTK0YxS1ordmlXNlhxajAvdzcrblhoVFNpdms4?=
 =?utf-8?B?enh2b1JzQkFUS0hGTURmV1Uxc2hLb2dYTCtEdGlUWWx5SkFQTng4bEhRT0Nw?=
 =?utf-8?B?bjhyR2ROQ1NvNUxmT1BzMG0rclh6UkFkRjZtSHhLSDhSblVHblc0c0pTMVc2?=
 =?utf-8?B?OEtCalMyQlhSRGsrUFJuMHo4aGFmRlhJamVoWFZDTXV1RDUrUm5EamZnMUxF?=
 =?utf-8?B?QmNOWW0reWRtVXcwRXZYOGlyZnJ3YW5sTjNnRHUwQi8yUm9TazJaUjZpWkJC?=
 =?utf-8?B?QmxrYTBQOHpzSk1CTFRsbHhMNmFQMG9BblRrU2liYU9jeTVTTG1XOHZJOFh3?=
 =?utf-8?B?QzNCbkdTY1hHODhPSU14Z24wczE0U2x2RlFMR3BWN3VwUnZIeVlWTzV2a3ds?=
 =?utf-8?B?NWg2eHJ1ZFdtOVo5VFJDQnQ2cGpRQno5UytEaDVoUkovNWVNLzRNY3UwckJH?=
 =?utf-8?B?T3E0SWNHemZQcUtoend3TWVnN1hKcHlkOTRnL1VIWUt5bTZrRlBOTlFEWDFz?=
 =?utf-8?B?cEdvZ2RuSWkzeUttVW1ueHF0YWVVUWk2c0kraTA5RDNxcXRsWWFaOEJHY0tD?=
 =?utf-8?B?dk1pN2djZE1YNmtsREROM3I2QU9YeC9XOE95bXFPb2ttTlJEZlo2bEpZMEps?=
 =?utf-8?B?U2R0NHRXZXR1aFp6QnQ1dnFxcWdoaGZEVkFZUE9vZG0ydlhQWmZPSDNoNnFz?=
 =?utf-8?B?TTNIQVR2Z1Y3VEw2d1JiNXVqbnh2SG13cE9qdjNLc0JNY1BqNncySmlIVmpx?=
 =?utf-8?B?czBxd25yN1lzdy8rTUtyNVhpcm56NTZ5c29YWUVmeXduTS8zNWljbUQzbkhm?=
 =?utf-8?B?TnZVWHZLVmdqTjd0TUF1VVRZOEZmekUzcWREaVdGSTVvZkpGVGwzSXN1WTFn?=
 =?utf-8?B?VUViajR1Rk5ocC9HVTQwZW1lTkVlTm5lVUxPZ3g1eTNKdG9rQ0Z2eU9sT09X?=
 =?utf-8?B?RGYyaFI2aUovdEt6enpKKzRSeC9DbjVlMVJ5YW0vNndwY2w1em9wNEZZanh2?=
 =?utf-8?B?NmxNZzBZakdBdFdHN3NzdlBEc2lxTW5GTWhxb3l0QStMTTVnd0RYUEFQT2x2?=
 =?utf-8?B?dEpMc05QQ1U0V3k3cENOL2JmVnE3bFk5Rzl0Ky9ma1MwUUVWc0FhQW96QlRi?=
 =?utf-8?B?a0RKZ1RkK0tvbU9STkh5OXlhaFpKZThyVXkwWTBHYnBkYUp3bTU5SGZUb3Jv?=
 =?utf-8?B?ZWwzV0VNSWFvTFMvY0RtSHAySTR1MHNPODBDSVZlUXB2MEYySEx3eW04OWxw?=
 =?utf-8?B?ejZCUEwySSsydjJnb1BrUTJ3cTFIS29CMEdrRmlYT3ZHQVhPaWM3MHlhQ0dG?=
 =?utf-8?B?dURoemlNRHovY2YydHlPR3VnOTVLbXVwcDNWUEpvQmw3aXpVYStFaGhDWHZO?=
 =?utf-8?B?cERoWEZwTnlFQVVGSDZuNTI1bXdVdnpxcTdQeS84dkhuSjhqSUZGZzF2YTEy?=
 =?utf-8?B?MFg2NEpsNlNhV015TmxpRVExc2VPalFBaVVlQ1dZMXVrVUxTenhWUHZTcTI5?=
 =?utf-8?B?RGlmdDZESWtKamVqR240NGhGeWh4Y1hucElCbzM2a1pXZVhqYUhzbUdtbFJk?=
 =?utf-8?Q?pr3c2rty2ttX8+x2M12HcKwBG6fhK+zN6dTd+TZw5qufj?=
X-MS-Exchange-AntiSpam-MessageData-1: unTe+Lz0P48oNg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e8d842-784a-4206-e617-08deb67ba320
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:25:26.8949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4W/JCCinjLxNRMmvGyWVucOwLSzFqM397FC94THDH3GrP9NAP8SQUHky8W+EkieTgZFuF5TnWVsn2lulUV91g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8781
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=den@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

On 5/19/26 22:19, Stefan Hajnoczi wrote:
> On Mon, May 18, 2026 at 07:13:56PM +0200, Denis V. Lunev wrote:
>> On 4/28/26 12:58, Denis V. Lunev wrote:
>>> qemu_laio_process_completions() wraps its body in defer_call_begin /
>>> defer_call_end. Inside the section, completion callbacks wake coroutines
>>> that queue new aiocbs; laio_do_submit() defers laio_deferred_fn. At the
>>> bottom of qemu_laio_process_completions() the defer_call_end() fires
>>> laio_deferred_fn, which calls ioq_submit(), closing the cycle:
>>>
>>>   ioq_submit
>>>     -> io_submit(2)                           // some sync completions
>>>     -> qemu_laio_process_completions          // defer_call_begin
>>>          -> aio_co_wake                       // resumes coroutine
>>>               -> laio_do_submit
>>>                    -> defer_call(laio_deferred_fn, s)   // enqueued
>>>          -> defer_call_end                    // nesting drops to 0
>>>               -> laio_deferred_fn
>>>                    -> ioq_submit              // +1 stack frame, loop
>>>
>>> When io_submit(2) returns asynchronously (O_DIRECT) the cycle
>>> terminates in one extra frame: the fresh aiocb is still in flight, no
>>> completion is drained, no coroutine wakes, no new submission queues.
>>> When submissions complete synchronously (non-O_DIRECT, or per-descriptor
>>> drivers such as vmdk) each level enqueues more work for the next
>>> defer_call_end() to drain, so recursion grows without bound and QEMU
>>> crashes with SIGSEGV on the thread guard page.
>>>
>>> The cycle was closed by two performance commits, each correct in
>>> isolation:
>>>
>>>   076682885d ("block/linux-aio: convert to blk_io_plug_call() API")
>>>     -- introduced laio_deferred_fn and wired
>>>        laio_do_submit -> defer_call(laio_deferred_fn, s).
>>>
>>>   84d61e5f36 ("virtio: use defer_call() in virtio_irqfd_notify()")
>>>     -- added defer_call_begin/end around qemu_laio_process_completions
>>>        so virtio-irqfd notifications batch across a completion pass.
>>>
>>> The supported aio=native + cache=none pairing keeps submissions
>>> asynchronous, so the cycle stays bounded; nothing in the code enforces
>>> that contract. Observed in production as a SIGSEGV during a backup job
>>> configured with --cached + aio=native; reproducible on upstream with
>>> qemu-io against vmdk.
>>>
>>> Cap ioq_submit() recursion with a per-thread counter. On overflow,
>>> return without submitting. The pending work is drained by
>>> s->completion_bh, which qemu_laio_process_completions() has already
>>> scheduled on entry -- no work is lost; one event-loop round-trip of
>>> latency is paid only when the bound is hit, which cannot happen on a
>>> supported configuration.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Hanna Reitz <hreitz@redhat.com>
>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>> CC: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  block/linux-aio.c | 23 +++++++++++++++++++++++
>>>  1 file changed, 23 insertions(+)
>>>
>>> diff --git a/block/linux-aio.c b/block/linux-aio.c
>>> index 0a7424fbb3..f98bb6e766 100644
>>> --- a/block/linux-aio.c
>>> +++ b/block/linux-aio.c
>>> @@ -36,6 +36,19 @@
>>>  /* Maximum number of requests in a batch. (default value) */
>>>  #define DEFAULT_MAX_BATCH 32
>>>  
>>> +/*
>>> + * Bound on how deep ioq_submit() may recurse on a single thread via the
>>> + * ioq_submit -> qemu_laio_process_completions -> defer_call_end ->
>>> + * laio_deferred_fn -> ioq_submit cycle. The cycle terminates naturally
>>> + * when io_submit(2) returns asynchronously (O_DIRECT), but can grow
>>> + * without bound when submissions complete synchronously. On overflow
>>> + * the caller returns without submitting; the outermost
>>> + * qemu_laio_process_completions() has already scheduled s->completion_bh
>>> + * (via qemu_bh_schedule() at the top of that function), which resumes
>>> + * submission from the next event-loop dispatch.
>>> + */
>>> +#define IOQ_SUBMIT_MAX_DEPTH 8
>>> +
>>>  struct qemu_laiocb {
>>>      Coroutine *co;
>>>      LinuxAioState *ctx;
>>> @@ -80,6 +93,9 @@ struct LinuxAioState {
>>>  static void ioq_submit(LinuxAioState *s);
>>>  static int laio_do_submit(struct qemu_laiocb *laiocb);
>>>  
>>> +/* Per-thread recursion counter for ioq_submit(). See IOQ_SUBMIT_MAX_DEPTH. */
>>> +static __thread unsigned ioq_submit_depth;
>>> +
>>>  static inline ssize_t io_event_ret(struct io_event *ev)
>>>  {
>>>      return (ssize_t)(((uint64_t)ev->res2 << 32) | ev->res);
>>> @@ -340,6 +356,11 @@ static void ioq_submit(LinuxAioState *s)
>>>      QEMU_UNINITIALIZED struct iocb *iocbs[MAX_EVENTS];
>>>      QSIMPLEQ_HEAD(, qemu_laiocb) completed;
>>>  
>>> +    if (ioq_submit_depth >= IOQ_SUBMIT_MAX_DEPTH) {
>>> +        return;
>>> +    }
>>> +    ioq_submit_depth++;
>>> +
>>>      do {
>>>          if (s->io_q.in_flight >= MAX_EVENTS) {
>>>              break;
>>> @@ -385,6 +406,8 @@ static void ioq_submit(LinuxAioState *s)
>>>           * pended requests will be submitted from there.
>>>           */
>>>      }
>>> +
>>> +    ioq_submit_depth--;
>>>  }
>>>  
>>>  static uint64_t laio_max_batch(LinuxAioState *s, uint64_t dev_max_batch)
>> ping
> Sorry, I missed this.
>
> Please add a field to LaioQueue instead of adding a __thread variable.
> LaioQueue is only accessed from a single thread and that's where the
> state lives.
>
> Stefan
>
done, sent v3.

Thanks for review,
    Den

