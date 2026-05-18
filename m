Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD877CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP1Xl-0004xG-Gl; Mon, 18 May 2026 13:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wP1Xh-0004wO-5Q; Mon, 18 May 2026 13:14:13 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wP1Xd-0006An-Ah; Mon, 18 May 2026 13:14:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVY6RY8izS5cOh8Doy40OmL3zeC+ciiy7nBsyZPv6HNZmnpmnaPokoDgpoRIWpRT8525VBa5BwhlVjiIUoxRxhMMMYRZBQQHIADbKB9KzP1RBTlzhdCWlM7gmURWPlxXYT6pJ7GfGI2LVEdM9EzqtutwknWwO3xo+GlYts/ldXkNQGsq6LhLk2aj1GZvdf7DuI8WpCzDVXc4i5BZ6uvwH4KwGZp8qqXvd561zgl7Rh3TV4kzUBBinTWYyB1PQqpuT2Cli06Y1UXGdpRt5mycDO8bVpebTsgI5Z9f2U+8KHWKCDdG8toTxR4wNLCmpdO3YKOc5m7NOhDyZE/BCAQR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rITyPD98sebDRuVipPK7RZTmE3/sKvlNsNy4hF7m7dc=;
 b=xE3FFH6LTzLISzvyXAnJQGOJm/CkdzP0ccD2lMmIymBdy2fZpHLjM9e6PN3vGBXfoOvrGV2rWJ1d5YwinjfjG/w1qFypimdQwdOjPYhSugGPld3/agjz2r03wrXqmLKBwvo41BKwlti1ey0nOn/EA09+qMw9YQBHeM6fSHzrSYNxNmKm+wY06G3Cj9U1/XMsrEPsWO/LGAZaua8HY9EsXE6VF+NWIFjlY3ZsPTqJKlHCaZjzVVjQihulK3PHaZ5WJbLHLQkyegcKCxGslENg3QrZj+/+LyNmeNv5Ofq48mKHdjfnoqAVbb/+wNV0OXDb/7BFaylG8uRPAq99O/buJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rITyPD98sebDRuVipPK7RZTmE3/sKvlNsNy4hF7m7dc=;
 b=TQucIGHRqVuPj8wGbVqORBxC0JzPV7y6woame+aVkslmnLAmsmeaFKZGfVV0HdQPkQYrNM2vxIq+naQ8y4tCJjHpyJQKa+NY+fUqQGotIb/LY9vS/+Hz+ENlgClU8prNCJctZRoHr1NSG64WmT34OARr44NRnLiZA0qDhUlv03gdjp4pRMmciHc5Df4Kp01ms31idjGiqzXYPhxDAButL31GXuhoe+84zipmRjRpp5Y+Anmd9z0McVk1eLBi5M+1S5vw3tQurYLTN+bE9GmnNTmme1cG0ilFK2+1ycIsxe/JSHw9CbLyp33ItptV2U23bU7Zpm7Sgzd9aVlYcUgUAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB9563.eurprd08.prod.outlook.com (2603:10a6:10:451::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 17:13:58 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 17:13:58 +0000
Message-ID: <9fc3e8ab-c2a3-4573-9fb4-764d8321bae5@virtuozzo.com>
Date: Mon, 18 May 2026 19:13:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block/linux-aio: bound ioq_submit() recursion depth
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260428105811.1325119-2-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260428105811.1325119-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:803:14::28) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB9563:EE_
X-MS-Office365-Filtering-Correlation-Id: 37cc02c1-c528-4311-f879-08deb500d918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UW7QwxVtfYsOeIGu2Tk++3xu/Bek/orYKXBjdPpl/XPn1qEbwysQ3v0P0dRs9/uzTyRitBF3J9et22gys8ubfVB0wYyRHpq2wMBuOtZUggNNRcndrCVCx/LW50f7ncD58EHJUWyiKvcADzbXqGDyauTl1ePEEYGibhqp/jgOX+ZEt5bBxa0ZhfiH64HomunHh39Eph6NB0E4D0nqhqvnGMjAdeQDT6/clugX7nb7VQAYsJk1rEay6LVkMMzZRhXbC1i+854W3gtrz3dijDVuI7IuqVf1oXLdtapiPoZcY7uAb6YvGk+o8FXprbSoHcsXOQxrQ5a9FVXDaOAwgEX6t2Xm8m1RrmSsavW+7hqanFud58/UFgK2gHwIKl2ttfpaijU3vbwMfjsGq/pttqESiayK55YRw/wIZdNz6TA35CGH6FdNNu2wvC97cf8Y640R/HFSksfMugiBBEqwowod3hP64qB9VRwbOAhiOb8EDtM7G8+PI+51f/MLQtg/YWGoWYAm1x6NaKZxU59k6Y2Z034lhCbXnvhYGiWBD2GcP0AgyeGzFeKsmtyBrbTQqHe7+sBEVbJUYUlGFkgLCtre+h8TNMvrnScHLWp5gr1mW0opU2dT4JfPqkUJhpZl0zCcnrdxXV0chpfLFbVvfJHC33a5mvYFDnJMV7JYea1ti2rA8GQFn5VCUwJrvTABAoh9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFd4ZXJBQ2U3bFM5ZnZ3K24zbU9zd1FWbjhMNEZTT3VleW4zSWtncm01ZzhO?=
 =?utf-8?B?eVFtTVdJUkwyTCttdVI1djM3UUJEL0wrbTBMOE9ZS0wxTUNBS3lia1FqcHhF?=
 =?utf-8?B?Uit3aDZSaElOZkhFNmVqYkxrVGJMdlVNYjlKK1pwbmpHUWlaU0xWdmJ5U2cx?=
 =?utf-8?B?UVhJdmFocUpWM21YMUsvdEZaemhjWWNJc0NxS1ZoMFFPclIrY096bThaSVJ5?=
 =?utf-8?B?dWpyeXRBdVRmdVZJR0NLQjNKWGJ0TDNlWitvRE1kdVF5T0UwL0x6S0tIeTBR?=
 =?utf-8?B?QW9JY3Yrc3ArOFBLSTdwbEdOZVdXZHROOEdIWGFOY0VHb2dPR285d0Vya3Rs?=
 =?utf-8?B?UlkzdjdudXZjSDNtSGZRRXlBdEVCQUd4T2FiemxLY0hPWjloTFcyZ090R2tu?=
 =?utf-8?B?akxNbng2cVIyUldjQjlBZVhGdjcvK2dWWFF0aklCZVVuNHdYTHlJaXpJL0JS?=
 =?utf-8?B?dHNEdzlRVDFlTWkyWGVHSE5HcE16ZmpTV1ZwSWZYbGpvaUZ0S0FXNlJkdVR3?=
 =?utf-8?B?dmp3NGp2aDJBV3Q4M0Fpbk1UbEpsUmxmM3dGbnhIYk1lMUhHbVFtOGlxK3hW?=
 =?utf-8?B?S0ozMzVvVWluMDcwQXZ4enJyV1pVYTkwS3RPMHZMSFpDTnJSUkFKYWRXN0J0?=
 =?utf-8?B?U2tRRjZvbERlV2cyM3JwUUxvbUtXNWVXWmJuaFdrZ1pyazBMQnNYN0RWOGxG?=
 =?utf-8?B?YkdPNWdXOVA5b0NPKzdGdEppaEhQcnI5ejFVdXVVTzh1d1lMWkk0OG93UmNX?=
 =?utf-8?B?SjN5Yms1Vnh2ODRGc05mV1FCMW82eUJCTm5GVVczR3dSbDU5V0FNZUFzL3B4?=
 =?utf-8?B?RmZSL0ZEUFhRVlY1bjlRTGN1SGt1c05Od0tPTzEvWHgrTDA1MVM3V2djVFRs?=
 =?utf-8?B?M3hzalRha3E1Y1daakt5djIvbHBTTWlPck1lOW8yajBkb251Zk5YamF0K2g0?=
 =?utf-8?B?ZE1Jdk1rV2dFeUNYZ0YzKzN3d3lwUlFMTGJaS2ZnREs3Nm8yY1RXTTFrcFBK?=
 =?utf-8?B?ajdVZmx3b1QwT2E4UzFpeFNRYTVDL3dXTUNraGdNU1JsSHIxeTB4akVHd0xl?=
 =?utf-8?B?M3dHaVUzOHY2ekJyamlkbjVxdUV4c1dJaGR1UTF5TUVYQ1l1K3YxQjFXcmpq?=
 =?utf-8?B?eDU2LzBMWGFia0doN3ZZbUZnTzNQU0l1dm9KakFaWm50RHVWakxNYjhGVzht?=
 =?utf-8?B?djR0K083d29Ha01MU3ozUEsyUXB4L1orZUROcTJBODNjUXl2R2pTSU1KUUhX?=
 =?utf-8?B?amRFVlBhUXlxcUV3YXBrWGlDeGdPK0tQWjlhK3F1UDRxeE9JZktsaTgyMHJ5?=
 =?utf-8?B?eSsxSUpobHViVUQ0aVJHOGcxYlNwd0xXeWhadWRiL2IwRWRlR0prWU0rMlc0?=
 =?utf-8?B?R1MxajZENmxyNy8vSmg0dU5LRzhtaXVsWkxkSVpNekhCWGM1WmpobFBodG1w?=
 =?utf-8?B?Mm9wWjA3c3ZoZmY5bkJsSWVoNVlCYlNJSGtNNzBKdVc5MXlFUkszajF1emV3?=
 =?utf-8?B?VlNEdGREVXVpR3MvSnZuZjM2ckpTd0ZKMWVVV2ovemZNdHJ6aDF4Zk9PQ0tP?=
 =?utf-8?B?aE9pUjhuRHlrSE5ZeFE3eERwTGxBbjNQRmYyVGZmVllqSHZ1RlFnRStPU2Qv?=
 =?utf-8?B?ei9qQk9TZXdTbk1hWm9jZ3FZZjZSWEw0ei9aUEhlWkNvWEloclJNQklTbUlu?=
 =?utf-8?B?RjVhTWc0V1doMXNjK3BoL1l1SHM2NG9wYlREUDQwQmU5WlpjakVYSmh0VCtZ?=
 =?utf-8?B?ZnZ0NFAzVDRsSjl3NnN6N3RnY3V0NHgwV1FUM0dKeUU5UlMzZVFxZ1VHc3Vp?=
 =?utf-8?B?YmxNa1pzZWZiWElqa2NhbEUzODc5bXpRa3B2My9iYkZaTGtSNFJlWnVhU2R0?=
 =?utf-8?B?SDZOZnJxanFoV0lQeU90eW5GL2xQMCtJbEF1aHhBczF4cUJmMGJmWXVJbUF2?=
 =?utf-8?B?cmpaSGNING5PWHdRcldqQzhpOEV0UE5sMzNHL3VNQ250WDV0Z1NzNzBqMWtT?=
 =?utf-8?B?SWRFQkMyS3lHcFl0Rnl3MDlKVEZwZFhweEpyOVdZQmlJZm8wVXpqVHc3RWtu?=
 =?utf-8?B?ZzBSZGVJamxXWDNaRFRuYjljcnFnNFRadG1JMXZEdlBibUdoQ3didXZsa09a?=
 =?utf-8?B?UldOY1U1SEpqL0N4QnZOejYvSnF0dHl2dHNrRFR3dWN0NzVDY2g1b3h0U1Vt?=
 =?utf-8?B?enk1aUN2dEFnUjBQT0dLK21EU2x1YlQvTTlHeEJDUDdnK04xZVhVMXFaN1BS?=
 =?utf-8?B?NzdyajhldFg3MXVjQjJSWk8wdmNHcTgyTW9RWUd4T0ptRDFxNndFbWZxTnhh?=
 =?utf-8?B?amJvZzVZK0lGR29Gam8wUURTR1ArUkwzanFqVkc3NDhIcnVWT1ZjS1lxVVRr?=
 =?utf-8?Q?F0iXAV0egEJxfBO/hK9xsJ5s4VfiwXsq5ytPecN20RniC?=
X-MS-Exchange-AntiSpam-MessageData-1: Nr9DxsEVE2kZGQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cc02c1-c528-4311-f879-08deb500d918
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 17:13:58.1806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4rbzA5DdMZt/NqZn+l1sQluXFoRhqN/QtqX6dBkcZUQFpKLtmljJ8S22XF0+A56WxYpaC6NXNRt7wHaDfb06A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9563
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 4/28/26 12:58, Denis V. Lunev wrote:
> qemu_laio_process_completions() wraps its body in defer_call_begin /
> defer_call_end. Inside the section, completion callbacks wake coroutines
> that queue new aiocbs; laio_do_submit() defers laio_deferred_fn. At the
> bottom of qemu_laio_process_completions() the defer_call_end() fires
> laio_deferred_fn, which calls ioq_submit(), closing the cycle:
>
>   ioq_submit
>     -> io_submit(2)                           // some sync completions
>     -> qemu_laio_process_completions          // defer_call_begin
>          -> aio_co_wake                       // resumes coroutine
>               -> laio_do_submit
>                    -> defer_call(laio_deferred_fn, s)   // enqueued
>          -> defer_call_end                    // nesting drops to 0
>               -> laio_deferred_fn
>                    -> ioq_submit              // +1 stack frame, loop
>
> When io_submit(2) returns asynchronously (O_DIRECT) the cycle
> terminates in one extra frame: the fresh aiocb is still in flight, no
> completion is drained, no coroutine wakes, no new submission queues.
> When submissions complete synchronously (non-O_DIRECT, or per-descriptor
> drivers such as vmdk) each level enqueues more work for the next
> defer_call_end() to drain, so recursion grows without bound and QEMU
> crashes with SIGSEGV on the thread guard page.
>
> The cycle was closed by two performance commits, each correct in
> isolation:
>
>   076682885d ("block/linux-aio: convert to blk_io_plug_call() API")
>     -- introduced laio_deferred_fn and wired
>        laio_do_submit -> defer_call(laio_deferred_fn, s).
>
>   84d61e5f36 ("virtio: use defer_call() in virtio_irqfd_notify()")
>     -- added defer_call_begin/end around qemu_laio_process_completions
>        so virtio-irqfd notifications batch across a completion pass.
>
> The supported aio=native + cache=none pairing keeps submissions
> asynchronous, so the cycle stays bounded; nothing in the code enforces
> that contract. Observed in production as a SIGSEGV during a backup job
> configured with --cached + aio=native; reproducible on upstream with
> qemu-io against vmdk.
>
> Cap ioq_submit() recursion with a per-thread counter. On overflow,
> return without submitting. The pending work is drained by
> s->completion_bh, which qemu_laio_process_completions() has already
> scheduled on entry -- no work is lost; one event-loop round-trip of
> latency is paid only when the bound is hit, which cannot happen on a
> supported configuration.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/linux-aio.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/block/linux-aio.c b/block/linux-aio.c
> index 0a7424fbb3..f98bb6e766 100644
> --- a/block/linux-aio.c
> +++ b/block/linux-aio.c
> @@ -36,6 +36,19 @@
>  /* Maximum number of requests in a batch. (default value) */
>  #define DEFAULT_MAX_BATCH 32
>  
> +/*
> + * Bound on how deep ioq_submit() may recurse on a single thread via the
> + * ioq_submit -> qemu_laio_process_completions -> defer_call_end ->
> + * laio_deferred_fn -> ioq_submit cycle. The cycle terminates naturally
> + * when io_submit(2) returns asynchronously (O_DIRECT), but can grow
> + * without bound when submissions complete synchronously. On overflow
> + * the caller returns without submitting; the outermost
> + * qemu_laio_process_completions() has already scheduled s->completion_bh
> + * (via qemu_bh_schedule() at the top of that function), which resumes
> + * submission from the next event-loop dispatch.
> + */
> +#define IOQ_SUBMIT_MAX_DEPTH 8
> +
>  struct qemu_laiocb {
>      Coroutine *co;
>      LinuxAioState *ctx;
> @@ -80,6 +93,9 @@ struct LinuxAioState {
>  static void ioq_submit(LinuxAioState *s);
>  static int laio_do_submit(struct qemu_laiocb *laiocb);
>  
> +/* Per-thread recursion counter for ioq_submit(). See IOQ_SUBMIT_MAX_DEPTH. */
> +static __thread unsigned ioq_submit_depth;
> +
>  static inline ssize_t io_event_ret(struct io_event *ev)
>  {
>      return (ssize_t)(((uint64_t)ev->res2 << 32) | ev->res);
> @@ -340,6 +356,11 @@ static void ioq_submit(LinuxAioState *s)
>      QEMU_UNINITIALIZED struct iocb *iocbs[MAX_EVENTS];
>      QSIMPLEQ_HEAD(, qemu_laiocb) completed;
>  
> +    if (ioq_submit_depth >= IOQ_SUBMIT_MAX_DEPTH) {
> +        return;
> +    }
> +    ioq_submit_depth++;
> +
>      do {
>          if (s->io_q.in_flight >= MAX_EVENTS) {
>              break;
> @@ -385,6 +406,8 @@ static void ioq_submit(LinuxAioState *s)
>           * pended requests will be submitted from there.
>           */
>      }
> +
> +    ioq_submit_depth--;
>  }
>  
>  static uint64_t laio_max_batch(LinuxAioState *s, uint64_t dev_max_batch)
ping

