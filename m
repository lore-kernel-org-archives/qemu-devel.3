Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A007FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whoJQ-0008QY-4M; Thu, 09 Jul 2026 08:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1whoJH-0008Og-Pp; Thu, 09 Jul 2026 08:56:59 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1whoJF-0007Nu-Rq; Thu, 09 Jul 2026 08:56:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddlU7HYieBhCmTWFzeAuiSDwrY8Ib0KU4sz8RLrOe4EIYThKsTvd8Hf8cbHoRAMQ7w1LXmExokoxJogxP0gKbGfaU/txdewFXqtLQYIxwrxXb5M3ixsBs6s0Yy/I6RM0QM+fG1nH73s5H1+NxOcYuAb1va7pgF8BJypG4vmVjm7rQI8MvOmwtEKJ/s3vKeIONpP2Jjq8GpRXke0fFhbmqVC7+5kGnApDkzW9HPzcGynXgfiWvLZddaAbnsziwKCCIiv0AUnQNPBC4qhzzOYZTI8Xh0fYU8dADypBxwpuxW21LA/0Ysuk8N1jboUStwXdwo2F1FznEJ8hqQ5nopN84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cvfYIpAHTU6x9sJyx+8E2IqBKSqTDN/v7bcnXSYayk=;
 b=Bzj8fMxTjKalbLt8W/d5nouDPVgYFQt7XMtzqHMM6TsqpC7/NxOmjz12d64B8fnBpWWhtirJEFVIcVN+62PfM5WDAh7q8SGKoK0qXFwEV727pB9ynnpn/HhUINvYqSo5AIinGMikPHfxwzGmFshiejP+io1LSyYp4eeM3aRbIpLH5Y5C8F0D/rDdhok0dplbBToldeJpBXhniFIzq9Quk8+cWWLYUAMZCFuO9WMCVTNC/tt0QXPqO2XGvKIlpQeUyhqvoHoOALB4UAI8wCtDEHn62mo3Onb+vBy4ANija3YIqQT58hhTHuYxfItF3RTFhMTAjEKLslaQoApBiLIIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cvfYIpAHTU6x9sJyx+8E2IqBKSqTDN/v7bcnXSYayk=;
 b=pcUNIDiv+cwNaNGvLCOVBg13vgdsRBIMJDVs/O2pQcoda7sm3GF78R7WB0adThIhOwr6TWQ4NsZ+idwfj7/K75tr2mK3yc3vU9sWzLOHRseo+smFfx4dSXpcCqc5A6H1yCDoy7QXQowvivQkT5Fs7sJw6SpiujYvoLknptHgXuIEfJwadNs8E7G9tj/ueBVEM3m75DN1q4ZkH6vKDqHMOMq5KQawrTsrKFJaRqh6RGQ73rE1w9wEj6cYUc4tCY1DqXyiE2P//ilCj9qGli/A8QJH9zBRvRrcThHjdBLb3hmvS5QgF6pPW38dJ7tYRKWmV9ifx2WvL6Y9E4xfeDsizw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU0PR08MB9903.eurprd08.prod.outlook.com (2603:10a6:10:470::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 12:56:45 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:56:45 +0000
Message-ID: <17f3a145-a2b2-4621-8454-4edd31affa30@virtuozzo.com>
Date: Thu, 9 Jul 2026 14:56:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20260610115850.2410566-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260610115850.2410566-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0018.eurprd02.prod.outlook.com
 (2603:10a6:803:14::31) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU0PR08MB9903:EE_
X-MS-Office365-Filtering-Correlation-Id: 84194602-f493-46d3-89ff-08deddb987d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|23010399003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: anpinmBa6Bl90bczFaL/JY2EXXyfPaKq55Wz4iZsiiPqTUSU36QkGeJQYMZJbDTmSqKR0FUCZaqnvDQbv3Wf/T0NPU6DNlSfWdIYlTWTMmpZWnWxgxYGSyoGTILlc7w1HhvcXPuNZo0Wof++zhhqfsbPOHIOkJhBHSOUVdcGuEeLAeXI1w0lRHbh43Bk/bOKguSrPblF97GWsWvimoOHtaXIn/faFjRLRIk18sfgT+zEa0VH7iOdBOR6zY9FERBpp9e+84G6KSVbMLdEriNDzOJ6pO56dsYX6A/HsBrWIQUT8O9XzNQFkzhAJojhpZKeQhtMFluv9mudQgzu417fHt1/sn0GrJ979U178Pbl8Dx5kcokH0Ta9b5cmqIwrRS9R8D866Rfv8pl6t+DWd4zb6rNovCRubkG+vtxgXJtPeB73IqtdUFWLnYGcSrXLQbaUhR97QfNh1K7MkwynLNXIvV/cEfpavStnn0x4FUZ1smjbET/gktntmsBU0nrehrwbv4kvjhOSXYQh5PkD6rrWHs/hMG4Vtlf6bxn/jUkzymWGr9jtqI5K50QlVLFSi4EP+deDNlDFCfCsr8p3/aLIDs23rJstAkmt5FlS2xLa22IXmuBja43geX1czjVyMENo5sLOuRb+htLPlZweGs2rK+6+auC0GsfH+7cyKU+Ff4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(23010399003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjlHRXplRkF1SWpRTGMyU1FUV1hkaE9TREFKTmlhMnkwVTJhUVNjV0lzNzdi?=
 =?utf-8?B?Ym9NQk1kU3MrbXlRb0dEaGQyN1FRRVk0ektZOXRBaE1XNHJRRHdBamNWb2Nh?=
 =?utf-8?B?SC9melJQSGYza2tubi9Rd1BpNTBRWVVWWkpPeVUwUktVdmZFRnVoU1VKMHEr?=
 =?utf-8?B?YXhpaklLRCt6eVhqRDE0am16WFRudEFtcm1iRlB2NThWanl2Y25kTVhPSlJS?=
 =?utf-8?B?UXlaQ1lVeGZQTUZLZWI3cWdxMG9uOGZkc0F5RTUzVkFIeWFna1BXSHo0R3hF?=
 =?utf-8?B?NU93d1dRbFdTVlZkMWROL3RBTUZES25JTEQ1cWp0Sm94RG5MdTFhaEtiMVph?=
 =?utf-8?B?QkNNU1g4UG1lLzVtam8wVURYMlZIcGhmOFlob3pib1Jwd1BMZVdGWmloWHBq?=
 =?utf-8?B?UXdYbHdvMStydzVsNFpvcCtuVDFBWXREbmtvVWFpOCtUZ1Ivc01KUGErMmN4?=
 =?utf-8?B?d1lkQzJqdncxM2xKNjZramVzRWVzRDFiR2lOWC9mWWJMYysydG5EaXhFUEdW?=
 =?utf-8?B?YXN5L1BMTnZ5TWZxTi9sa2QrVVgyWlBEUUxBa3RaSnh3WDRrejEyQmV4OEQz?=
 =?utf-8?B?d1FwZnlUOEtCQzVnQlJ3SGZqMGpHd0lUYUVDMWhkdnF2bVpoWllqeWU1elpX?=
 =?utf-8?B?aFdaM3lHbzU4MHVMbFdJU0NPZjlNa2RPV25WT3lzMHFKMVVwajZRL3RUdWdr?=
 =?utf-8?B?cjl0clJsZzluSk5KYTNxcS9ISHRNanJMc0tlTmVxUVFJNlMzcGVscGFnSDE3?=
 =?utf-8?B?SHdJOHhzcitkRzVTVlBKMWFjZnJvckE3Ry91WlMxVkZOMURaYy9BNE44TG1U?=
 =?utf-8?B?ZklLZk9wN0s5N0lQUmNzSHNlMU9lQTQzMGpSYWwyUnpBRDFFV1lPaHA4N0xK?=
 =?utf-8?B?cXNtQkNHMDEzTEJuYjhwZHNISWh2VkdOWmhvQS9DM051a3pyU3lOd0IwZUcz?=
 =?utf-8?B?UHIycGlNMFdYTDRJUUVKUUpGSTR1NkdQZHQrZGNtNkN5bkhJS2JhTytSQ0I2?=
 =?utf-8?B?d2RuRVh6TVdack0xNFBzUnlzOFVXZkJpSnFSV3JueGRJb0R1YnNjZUpsR0JZ?=
 =?utf-8?B?Z3E5cDZQVmlaSk4vUDFpUFpuL2VUWmJMR29OdXRqd040MWgxQnkvSnlkTHEv?=
 =?utf-8?B?WTI5V2NTcXpNRlJwQ3BwOWFjQTdoU1Jjb0o2cjloUkpsSDNicHk4Zm1EbU9n?=
 =?utf-8?B?ZFRLVldkZ0UvZFcybzRDMmxKOVdGRGVpellPTWdodFFLUDVsWHdIRHBJQmEv?=
 =?utf-8?B?TXFEWEZVRGU0V0pMTVZ0djd4Z25EWDA4b0g3ZzdmRHlOUUk5bTZ4NnBhNGZU?=
 =?utf-8?B?L3BGWENRSUVyRGY5UTNBd3h1N0kxOEZIM1NrSWQyU3N5N25aMWRzd0NLcmxW?=
 =?utf-8?B?dFR3RmJwUm9qbmppN3ZJZGhqTTdUUU5iWjFpSHdGWTVha1lld2N5VXUvZEV3?=
 =?utf-8?B?NS9YTUdaS3RSenRzMmppSklnUkM1Y0xWYU1YdmJRa1JrUDNnTHRBWFB5R2lK?=
 =?utf-8?B?RWxKY3lGOU44REJvZW0vRkpiUHJ2cDNHLzUxc2FjNnJKYU83aHpscTNnUXNN?=
 =?utf-8?B?eSs4Y2xBODVwVFVDYWJSUFRHVXAvdnpuWG5NOHdNYmMxc25OeVBIM0ZWRjlN?=
 =?utf-8?B?NXR5dk5ERkxNVFhOUGt2eVAzWitaamh3OURZdkpTNDZXWDVLMmMwVlltL1g5?=
 =?utf-8?B?djQvTzVrbnljOGUweG4rL0pPRjFlRXVjMDJMS3Y4UGtOMldPa3RRWmlrUW0r?=
 =?utf-8?B?YzcyaVROZkdqNDZsb3ZHZmRXeGRVYTkxRWFwWGFYQWF2TytFZjhkTWUyR0NV?=
 =?utf-8?B?Wm9YUmpqTU9rTTlUUTAzbFhCdmVwRlVGdDh6YnFma0hYbmZUeldscnNLSlJJ?=
 =?utf-8?B?d0hSWXNLWEVQT1pFZWZWYnpmSnBqbUFxOTUxT0U2SDZZc3BqY1J5N1paN3pZ?=
 =?utf-8?B?dVdSRm52Z3c5UkpUYXB2OHphZG9JcDZSNTBjY2hnTTlNYlRXQUJWaTRsdWdh?=
 =?utf-8?B?Tk1aUVV3OEtpRDlNazlmeTdjRGNnaHJreVQ2SFlIeEpNeVJzd29xTUNSc3pv?=
 =?utf-8?B?bjl6N0xvaUhQYThvREJySGYwVTl3d2JQaDZnZFpnUjVYOXB6UGxIa2V2T0hM?=
 =?utf-8?B?Q3Q3Y00rUTZuSTgrSHJGQ3dGRVIyUVlXTktHOUl4UmZKcUZEdFdyL0NySUVT?=
 =?utf-8?B?bUdXZ1NGWG05YlBOaE9aVVFNVWFJZ2ZaVWxhWm5HeFFDK1prZ1NmV1U5R3No?=
 =?utf-8?B?Y29EWmMxSXA0RHh5SE1vZGJabzcwZysybHQ4SndHRk0vSkFoZy9qQmhMYmtL?=
 =?utf-8?B?VVMzd1luMjRtZnlrK3p2VzdPNXVoT2pmRVY4bUlhQWd6NXRzN0tWT20zVWxp?=
 =?utf-8?Q?sEOdEVJ0AeMzORvyCfEa6kuUENfnviSNgaqPxmKv2g+Je?=
X-MS-Exchange-AntiSpam-MessageData-1: WPoizcpXWsEHzQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84194602-f493-46d3-89ff-08deddb987d8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 12:56:45.2003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFy2W2zb/NgIJR8U0tMvF3czWlG0/RCG8YIaqKCFJQ+cvX7RWq8WqZ6qPbBwy2Y/MHVeZz/6TnW3oqtqdVMYvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9903
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=den@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

On 6/10/26 13:58, Denis V. Lunev wrote:
> Changes since v2
> ----------------
>   * Drop the redundant fast-path check in qemu_co_sleep(); the publish
>     cmpxchg already consumes a pending wake (Kevin).
>   * Add a deterministic regression test, no threads or timers needed.
>
> Changes since v1
> ----------------
>   * Patch 1 (graph-lock) applied as e3082ab3b3, dropped here.
>   * Fix the qemu_co_sleep_wake() primitive instead of working around
>     it in qcow2 (Kevin).
>
> Problem
> -------
>
> The qemu shutdown / blockdev-close path can deadlock permanently on
> upstream master. The main thread enters ppoll(timeout=-1) holding
> BQL, no other thread has a wake source that points back at it, and
> qemu has to be SIGKILLed. The hang has no timeout -- it is a hard
> deadlock, not a slow operation; behind BQL, RCU, VCPUs and every
> iothread path that needs BQL stall with it.
>
> The race exposed in qcow2's cache_clean_timer cancellation path:
>
>   ppoll -> aio_poll -> cache_clean_timer_del_and_wait -> qcow2_close
>
> The race diagram and the exact stale-state read are in the patch's
> commit message.
>
> Reproducer
> ----------
>
> Environment: 4-vCPU VM guest, kernel 6.12.x, upstream master at
> de5d8bfd61. On modern bare-metal the window is narrow enough that the
> hang rarely reproduces without a VM -- a VM guest under full CPU
> saturation is what makes the timing reliable.
>
>     # reproducer
>     stress-ng --cpu "$(nproc)" --timeout 0 &
>     for r in $(seq 20); do
>         timeout 120 ./build/tests/qemu-iotests/check -qcow2 iothreads-create
>     done
>     kill %1
>
> With `stress-ng --cpu $(nproc)` the race surfaces. With
> `stress-ng --cpu $(($(nproc) - 1))` or without a stressor it does
> not reproduce reliably across 20 iterations.
>
> The new unit test reproduces the same lost wakeup deterministically,
> without a VM or a stressor.
>
> Results
> -------
>
> Same guest, 20 iterations of the loop above, master at de5d8bfd61:
>
>   without this patch:  reproduces reliably (qcow2_close in ppoll)
>   with this patch:     20/20 PASS
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
>
> Denis V. Lunev (1):
>   coroutine: fix lost wakeup in qemu_co_sleep_wake()
>
>  include/qemu/coroutine.h    | 17 +++++++++---
>  tests/unit/test-coroutine.c | 53 +++++++++++++++++++++++++++++++++++++
>  util/qemu-coroutine-sleep.c | 53 ++++++++++++++++++++++++++-----------
>  3 files changed, 104 insertions(+), 19 deletions(-)
>
ping v4

