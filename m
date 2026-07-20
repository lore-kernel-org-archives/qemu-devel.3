Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D44C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wliuQ-0007bo-Ng; Mon, 20 Jul 2026 03:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wliuI-0007RW-HF; Mon, 20 Jul 2026 03:59:22 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wliuE-00071T-B2; Mon, 20 Jul 2026 03:59:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSipwLHJGlIDOpy7xRpkPf4ynaJ9nYmiX5YRXKuLovdDfljzpNPqA65IAlaolR/G54uZLqZsfQr1cf+z5tUoGKnCh2YdyrdibuqYGMNs8QeG8LtpnTW9K+1UjAxyRPF76WJtJeQVet8gA2kLfgzKPXb0PiGkZRFnWSwrrBfXcIL9N+yqsLyFCKi343NdxP468iO7zGHLTMbv1Se29aLMldrEBopjMVxZRzeByzJbpwGNlyzMy4VwTLWGoIwOzQlfrttBjrwDMz3xFuKtJGE5YumHUOZ1++IZRxSAZWhWkGhkDWjO99JADQ6l5IXw+VQismJbaU/vB2jlvWEGGIxgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhQpJSQ2Do7L4fpGJkceHVh8V3JYokuisGbDEKz2B/o=;
 b=sW18pAgeipUeEAAt43s8a9jTiXpfTTjpu7kC7lY+jfNVg9QKlj6C39hCCtCi/K4nYlalw0FymLHYsMe9RMeaQdr2USnIDc25VtkoNgzo8BbdPg1dwi+WB+wX7i7OoWOWN2nWqPF1DT+DqN6A9YvSOsqr8WzYAh/5ct4HvKUs8qBoWocpgH/eF2eju78F2pJFIl0/TzlPbXBoZ7+YXPJJMz2bZBSMy3F+2dYsuI2d+it16/SS1/yVbGNxIrBnvxmEbCZ8tPHrECHJ9lfFfBcbGDGicXdmsBL4BhJFtaL9f/kaCXUq4CEnfqoB3IN5hYOhnePagCvQs1zoEnWpicPaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhQpJSQ2Do7L4fpGJkceHVh8V3JYokuisGbDEKz2B/o=;
 b=ysukEMtgEBUuIhLFKUFiYt+EC4/ACe89SrEU91+5SJ0sdgVQ8ob8oZnJX8Pz5kSQaA/bAery9XEqpwzRVN3EXsrkSyg9w2ZGOKqIq7Pc2DGIMffBhY4qHkpB6I7HR2E9D5yjke8BbxKpSarSgEonT5PH4g/qTVCjDUYfyYTlhQfPXMOlvcVVGKA2A8O/KYpl2MzcN0she7apwAY3Ii6Bmz94niC0Lvk+th81iCSA2/cvhHfbGScdeTe1S2QGU3fipT+YYK6LymS9Wj9+bNIiBPcLqzsd/n6HGM3vFX2bpLGesOvrCAF6QF+vfA/P2HCsgOyk7JJmHXhqBP/Sz2lsEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU2PR08MB9962.eurprd08.prod.outlook.com (2603:10a6:10:498::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 07:59:12 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 07:59:12 +0000
Message-ID: <f0c8a8ac-9a64-4d5d-a028-9961ff68f78f@virtuozzo.com>
Date: Mon, 20 Jul 2026 09:59:11 +0200
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
X-ClientProxiedBy: VI1P194CA0053.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::42) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU2PR08MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: 9458d63b-8297-41ef-621d-08dee634c935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|10070799003|376014|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dNJA0s/spallLzbUYm4m4FR3JWnoLkqlpzpBWxNvuUAeWXjx6mWJlGdEghGnW6IttR9Hc0/YMQwqJENzi5nmkYfYZcqN1JuX5CjyGALCTOo2JvNgGoxKdQFBOqm0DpTGOwqcLX9k7+mpiNGmXq9HW32aC9Fr7r58B4kOuy0sSbsAon3LQi3X9V3bJFBZiDRG+9lSCEbJ93gP2Bbwdy5y8OVuG7hQ3AtTni7Zz0qpO5aopydMoVoLMG9JvCEfXCY1TLq5MRRaaYerf9ZvdiHhFeLiK0wAhnmK9T24tSYkpLO6rgEIsHcu2bPSl9tf9auzo5bjPSY/IL00QmrE/PgfHAOQpe6u73mJ0NwKeBdYdMDL0kDZqMD5rE1B09LQ7lkRLH952QYtFnEJMGIMVs4l8qI29+D//ufJZwVcRitxBjss1AAVyeGwaUwcXXKtkwhsEeyttFZceapqRD6uOQ2My6d18z5+Rvx+UXQ2ZbQG0JgBQX86JVu2Nv82gUehlCtUEv0ZFkahiHzHrldGYsSgW8syvbgJyR5uPlujBS6cl0z0gcmvdFFsvGxTmmIXan2DRtIrXtIppjJBjiwn32BX+1OE2pgms/lsa/PG+ruuODYZsL81zveDHPIs1HjaKX1jA7fZHmonQviNe+7RNWjKNMehreZZgfX4gmO/7vcJKcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTJScWU0SjBSUUF0dzVJMlFRaHpPeUI4N2JDZ08zTWRzd3NoRVVULy93Vm55?=
 =?utf-8?B?d3lTdnZlTVVtS2FvVTVhWmt0eVUvVmZCOHlPQWxxSkpLQzlsRzZGQlU1Vm96?=
 =?utf-8?B?Skw4QmkxZkFxWWVScXJnTEpBSjRxSWZwUEx1RmN5cXVQWG5QZ0FCd3ZWUVh6?=
 =?utf-8?B?MVhNYVQ4dGFKZUw5SnNtVDNOdW1YS0FiK1F6Q253Vk5PRUYrQmZWSEhrMmMw?=
 =?utf-8?B?VXFKcW1iSE9pUmRPZEJlclZOWVlpT3pzUG5DWnpsTDYyanZoMk1kL3JHWm9o?=
 =?utf-8?B?dEY4ellGdmtkWVRnUGNDWS9Yd3BYMHg0S2ljWnNuUzVmQVI3R0pnRTlMK0FI?=
 =?utf-8?B?ckxkRVdMVFR1bFM4NXo4bU1nM1lxRW44TVNVdGlMVWRvY2VMVTVvaUd3UkJT?=
 =?utf-8?B?czhBVW02amJPU2FPeTg3b1hJbnIza0xSaVNab21HSS9ZMHkyb0YyR2U2eHAw?=
 =?utf-8?B?aHhTSGRVMDJZYmlCMC9jbURmaGttWnRXb1ROQ01GbUN2dit2TGtPMzdTTE5j?=
 =?utf-8?B?ak0yOFhyQ2xtYlFIRmxJOVB5MnJ4WE9UbTl1ZVh1d08wNk1PbjRIWVI1K3NR?=
 =?utf-8?B?VUE4RFRkMlBlV3o5ZnhMTkJNSEEwbzEyU3hNUCtKeTJuci9QMXVkTFpzQ0p5?=
 =?utf-8?B?UVhLcHlWOFlwaEhzZlArSDA3bUtsSy9XSlVOMTBhMHBCaDFxYSs5UWcwRVNY?=
 =?utf-8?B?bjhRa3dRWkpNcno0NE9yWFJXN1lrWllTMllDUXNXZTVmRnBQK1NpaGtKeld4?=
 =?utf-8?B?VVB0Vk0zYk1jREtueGdyaEdlc1JXSURMSmNFTGpRdXFsWjJZVlpYNjVySnpU?=
 =?utf-8?B?SDh3bjk5R2hJMlhkNk5SeE9SaU0rVVVYeDVxNlJiREdyL3VsVldua1J5NTNU?=
 =?utf-8?B?cWZRU25vd2ZaRFg1U3hkbEEzTWVrQUxnMkkwcDRDQVhsdWRWcWY5cVRESlRk?=
 =?utf-8?B?cmJLQy9LeUFmNU1SNmVxWnlkWU5yOWJVek9IcEZHdEZ3ZHYvcy9sT1VKTThC?=
 =?utf-8?B?WlkyQUFHakZLdEdncldNY25qbHRmR1ZzY3Z0VUZCUHZiU1VUZmZJMGNBckpw?=
 =?utf-8?B?MXRscFgyYmNhLzdhTWJ5MmhqZEFKZkpRMkdHM3J2Rjh3MGoxc3pGc21qZFd4?=
 =?utf-8?B?cmtXQ1F3WlNTeE42R1dpUnY4ekl0ME1sZGNpajNHbkxRMVFQVVIzRkU5dm5R?=
 =?utf-8?B?Q1hsTi91SHRCZ0tVZXdNSElveG5rdXRsTXF1SFVCeENHaXdYWm9nSnZCWkRi?=
 =?utf-8?B?L3N3WjdKNzhQTDNZQnZqdmxYWUJ4WCsvSEtacEpkcFhMdGcyKzE1WTFyS3VB?=
 =?utf-8?B?U0k1NTVoYmdveGplcE8vbEZUV0M0M2kxNDNnZVFzOVpRRFFPZmRjMFdQbm0y?=
 =?utf-8?B?elEzTzV3YWFiVmpoZnVTRzVsTnJaMEttMVlocm0zaGVmMDRWMkkwZHVrb01O?=
 =?utf-8?B?ZXI1NHZjOXNlUUNXZ0Q0a3c0Skw0NkM1dk1UUWNmS2E0V2V5ZU1URXE1d2tD?=
 =?utf-8?B?K2lEK3NETkNadHg1OGs0NDVnRTdvYmJlS1FEUVF5TnZuWlp0cUxuTUpTRGRL?=
 =?utf-8?B?c3k2YVluaDM1TklWaUFkVVJ6dTQyeDRqR05ITUpWeGdZQkxzcUptT2k4bVFy?=
 =?utf-8?B?ZHBWVU1ZTzNzMmJnS214elo2RUh5Rk56aEYvbnlXRlB2ZjNFTzJjaFZtdGt1?=
 =?utf-8?B?NFRwS0txSmxCNytGVWFqVm5hcWtTQnArcS9GYW9RYml6Z1p4VGlWTjBpOWpC?=
 =?utf-8?B?eUQyT2lOTEt4Z1p4THVjTUMyVUNyRzFzbVkzalhBYWN6YVdJN2YzK0VpSHcv?=
 =?utf-8?B?Qk5PekdUaHg2YWFnRytVTG0yUWhZcEh6R0x6cjBGMDlGT1Eyc2JBeDJGSVUw?=
 =?utf-8?B?WUdDa3VCWWVMcUFHbHordkRtQTlWMkVwY2dGU21XRG82c1F2SDJzUHBmL1Fw?=
 =?utf-8?B?VkpUaEpyRWY1MTBOamNTTmU4MjZ4TFVVa0VxeTlTU1NEZitJN0hlZmtSTEky?=
 =?utf-8?B?aGc3ZVd1M3VleUZ1cngvL3RkMDRLOE1jYkt0RFJyOFVDLzNTR0tiTEZ2di9l?=
 =?utf-8?B?eEZIcmJzWUhZVm5FblJFdWQ3VHdDVXlZc2MrK21vV3VwRUNXS09aNTNxUktM?=
 =?utf-8?B?dkRjZk1nanRRY3dRelhMZllJZXFaMFpIbm9USjhOVkhXc21SRWJ0Uzg4SlRa?=
 =?utf-8?B?RXUycks3TWRLck10cnJnUjQyZjV2dkgvbEVQUTVKM25LZ0crcENxaTFwVHlY?=
 =?utf-8?B?QTk1cDJZMFRFeU4zcUlZTGQ4TWRIVVZtbG9RSjVWNngzd3ZsN2V3WEw1MkJQ?=
 =?utf-8?B?R0xHMXJyQ2l2S3BNek9XeFczdzZhWjliWmowRXJoSUxZUkQrazBzK1piL2hX?=
 =?utf-8?Q?EqeGFczZQFhS4Sx0rleCeguZuz3zbsMPT7qG3HuaMlkhQ?=
X-MS-Exchange-AntiSpam-MessageData-1: ypxFLqnwkrlXXQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9458d63b-8297-41ef-621d-08dee634c935
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 07:59:12.3415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlwOWjETWIz7L8RIP2idpGgBPeGjwIBJLao7/+6t6rwEQzur4BAem6ceN5f2nvzJf4dQxpdZCLUPX7RPiiUo8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB9962
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
ping v5

