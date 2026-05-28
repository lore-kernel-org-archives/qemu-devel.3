Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5BACD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSX3O-0004zv-Pl; Thu, 28 May 2026 05:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wSX3M-0004zV-Hd; Thu, 28 May 2026 05:29:24 -0400
Received: from mail-norwayeastazon11023121.outbound.protection.outlook.com
 ([40.107.159.121] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wSX3K-0007GF-Gy; Thu, 28 May 2026 05:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4G3ccQ/vcrOHnWVLPJsF4ZclG6mq8CYsjMmZbG/yxFZX/5o203CDZAis9wyT5cigL0jD4ScD+reDH72YgH/VN7zDxiVV9MbSGZHk8EbeYRnNppJHDeO0oTAKR7ahPkP3W28MxBQ9l0x6PLxT7j16V/042mUAkXEfugWiTqrwPB5ORZtBX1LYr8oUvxShOAeTF3D6hE2XWZhwznzh4sz2/AGEOspwpyaF4UL+URZkM/SBLTRB8mYIW+aPtExyXqqz9KVR4hP2j6pSeHxTzrQoxBrJS4UKBn8nMyvXZY9QjGwjIYgR3DF3zPUo8dSo6F/zKzoKjQQnXaYYtoWPAmOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGI40w/8rioFxUwHA/crF51eJSpCUi5XYQReXROmn+U=;
 b=Cxqnl62G8gQc9qPQQfqz/Nooiz0RuN0QVQu0D77C7dX780KTFFkiXQJ2NbibqOzc7vktYU/miVBMoYDySBRbONoI74UU5JbZjdt8HN4NslXZZ0eV0HxPD0mm9xNc5iND5Tb8rr59cTwPIx3TmdBXMFF3dSm07vSaHSpAIg0qumON/PNgwjqBEOlcjAPAgnD9GvnRkbWdwAJ9LMPgXHhK8Nc+jxs+IM+zJPeZPfkwbCjB9Lw34ZksmPl3NmUPC07eIfmC4CtWkgQJy64wByVgKrnOBIkFMCj0DLfL24B1DwxOoIDIjOUn4D2nMluUUoGwagY091CyeywbDHk92R2Ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGI40w/8rioFxUwHA/crF51eJSpCUi5XYQReXROmn+U=;
 b=O61erp/Xh1bGA0grKE0fgs7swIfRRcf9HC5Tnoicq1IaRYsIF9ARqXDM4p7uO/8pPsd70oU4iIJB+CR93VI6SCDS+Swz0oIrQRXYE4yFa04Qa3MIHPFVjCr6o7oll5e78joFJPEbI7Y+0BzEC+gflZEhMdsG5tjLlPE4NC7L8fJfNP6j4R6BsXN5mf47Oo11twQWr64E13YsxvvKA5rJ22sesvh5IwBwBKTe6aXBRUIpC35umBD7nNJItGmscIrKTZ7kF98GcKVKX+GCIgkuxl6q2/mzd8IgnijwUmF0w3gd2bP1tHlQahS0xXlLUVAgCoBZbvVtuC/wHs6wE1UAWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU5PR08MB10400.eurprd08.prod.outlook.com (2603:10a6:10:521::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 09:25:12 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 09:25:12 +0000
Message-ID: <2edfc462-515f-4ae0-8a31-3e8f5810ff4a@virtuozzo.com>
Date: Thu, 28 May 2026 11:25:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com
References: <20260520193849.467936-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260520193849.467936-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::43) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU5PR08MB10400:EE_
X-MS-Office365-Filtering-Correlation-Id: 722adfff-c53d-4f7b-58bd-08debc9b04d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|5023799004|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: RhnucA7r/SrbbEtRTo/HHf2n7R811U0yNhSvKtd0yzGrkIvWfIuWTd/RAqJ5Rwmyqf9x5EgH12s12PgNe+mdabCfjVJF8FlRwvekMuA6NBlj3LiP1I5vTW5Si/f0hPETcNxXov5UYMslcNJOinRhoKwPJKE/fos/wqnnFxC4wK+v2r4PsvBCS2ASYfQEAbVcE+MmztU6W+2d1jJTWBavuv2nCEslKPmCehwnZzmNJOwmN7vRxKWFRAu0p6WJBhPYkq6SgRIo6TXIMxSfw7AmJ1JxwasLcH4UooO+x/1+NbFOYgGcQntHZDYv7uBt2PF16hMA9n7xUG4ajcUbA1h5GyuPKWJW+gj2TlD8rf5VoqkPRD6dcsRHj9drqS1RTJT9uaghfw0FdwdeFnf3eRZwPzietqkXbAftCzY0P4gnAJTE6gdd2hsrlOkwSobit5zvB7TpSn/9dBbyTBLtdFSbrLN03Ve4DSBbJhyBzpgI4cul3TWr3oazbmoudSESv8oi/VvRHXGhiEyBedvJBk5UF98mZEBp2cAeCjLQHp5kdXJo8Wq4g/ScqlIqAn2j/EnGEndoae7N/ZWzFZvwqs3mKXz97NOmoEyA9w4yqRvmRVIBuf8tjXr+QWOjduKmLD7TryS8jqJu3dRuxGiv5cawxXdFGDfVOeGFaX2G1lbHIaDbRtkF6FBZKdvU2sAoc54Z6A+DSa5iKnATQIeoaMqa6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(5023799004)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVocWRaRXB2bzRaSmFFbFJDZlJRQk5aZFVVZkhTdUFoMHc4bzdOU0Fla2FM?=
 =?utf-8?B?UW9RTTZJN1NNbGZuNS9GMU96QUh2QnFBWUNMN05DMjljZElBaE16bmdRNnly?=
 =?utf-8?B?S2tMV1dnQ1FFcFN2c1FmdXJpV05xcG1TRjVlYzcrd2w1UDllQzg2VDdtZTdo?=
 =?utf-8?B?UTVPNGcxUnFvYTViUklqalkzSEZDNGwyLytkanhtQ0sxaXBMYkdxRUFXa002?=
 =?utf-8?B?MG5YVGF4WWR4enFTSERaeHdQZmZidmFDelNaVTdVRzVyY0h4WENlKzFXb3dz?=
 =?utf-8?B?bnM5OGN2Z09HT1A3U3prQVhBNVlab3krU2lOS3o5Z1lXMW84MGI4RFdvbjBu?=
 =?utf-8?B?ejFSbGorWmFyQUg1TFowZ3ZidzFtK1dNUElYWnA0YnZIbkZ2KzJmclg3YU80?=
 =?utf-8?B?VEx1Mkw0RkhFN0E5cGZHbGJjSG1qRURDMWR1TnAwMTFwK25ocHdRYnZSSHVl?=
 =?utf-8?B?RnNrTnFmSlZJSE0vQWxyMFg0WDI0UmlFNnZpTVRXSFpWZjRjVE1PN1lZdnJt?=
 =?utf-8?B?SFRJL1lMZ3dhWll6bllOR2hNSzUxenowaXg1K1hRVEM3S0g5MlNDWWwvRkJG?=
 =?utf-8?B?R2hUUllyQmthN25wMDU5Nko1cDFLUVlSU0VGaVJJUCs5cEd3RFF4VmVrTjBq?=
 =?utf-8?B?QVhoM3pNSi8ySXFUVkErckFWRGxkb2ZmNTVreGQ4Q2IwbGYxSS96bGpOZXE4?=
 =?utf-8?B?Q0tyMUF3YVB0aEo0ZnNtOXlIR2pOTm4wSWNzaGlPUFZTU2NpMWkxVWFhSFpM?=
 =?utf-8?B?N1hQQWlrNCtQVUdlU3RRRVFNZmgzTTNMSk5ueW5kVVg4SGc4Zmc2Z3NIempx?=
 =?utf-8?B?NzJ0REJlV1p2ZEtUN25NZUFRcG5iZnhGQTVpcUJTVWtieGdXRGhjcWJtQWFW?=
 =?utf-8?B?YnhteDY4NE42bURCZVJveHFHcmxtNXR6STFxckhxOUpBaHE3K1FvakNnb0pK?=
 =?utf-8?B?UFlwWmJtQWwwOWZ2RG9OVHVueGZOa1AzWlUxeVgvS0pUdTNkZVRFVk9BeFAz?=
 =?utf-8?B?bVVZcnJiajRzaEJSMVFqUUVIeEx3N3UydC9GeHFVVmZ2cDlmVFNSTUNJUito?=
 =?utf-8?B?RzlSNHNQRE00TFVXTEFKR0V1cFI2Vk9ScDlWYWFpWHBkbXFwZDBCN2tPemtl?=
 =?utf-8?B?YkZpOU5yNW54NGJ5bWJsZEFCc2ZKTGhYSGZ5eWVNdnR2d1JYYkFoWklBZlNO?=
 =?utf-8?B?UHF1cktqU01tdkNwZ3FYcDFReFQwaG1SM0t3UlRDT0pqdlJJNkcrV0pLMEFw?=
 =?utf-8?B?WXg1R0hBOEpwWXlDSDNBeFZzQ1FKNUh5K1J3OEZTNmlqNkpUOFdzQzhjSkFE?=
 =?utf-8?B?MjJ2STNlQ2lObEZTQ2gxZitDSEZ3SEl2TkpWWUp2M3hrQThJY050Uy9nYlVS?=
 =?utf-8?B?cDNxN210bWtxM0daeklaY3dTZ1dMNFFXc1VGTzNXNXRERG5zc1FNSjJkcjYz?=
 =?utf-8?B?elJZUFBnTGhIa1F5cHhUSnpoMElnQ2ZxdE93Z0FJeTczWHFVSmpSNmNMRWxR?=
 =?utf-8?B?dUNIeXZXcDhQaFRsK0oyNUN2NGxES045aDU3OWJGVTYzMG9xeEZPRzhXM3Fm?=
 =?utf-8?B?dzVVY0UvQStGaWFEMENJMDBqM0VkL3BvbjV4UFpMS09kaGlqUXhTdG1tOCtK?=
 =?utf-8?B?V21mNW9CdDhQdUhCY1NYeXgzMWJoUk1CWndKVExpR3BQS3A4RWtzYWdwRVBJ?=
 =?utf-8?B?ejdqMllBeWZiRkhUUlJOYTM3OVhBQTV0dTZzL1VBNThuaGJCZ3RtNEtJNEZB?=
 =?utf-8?B?amdLNVVQOVpBeFVyeDlodFNUR1EyR3RPZHpWYndzRzFMbmd0bktGUWU5WGhZ?=
 =?utf-8?B?ZG5BWGU3NWFDOUlDL3hDcFNTallRdXhjYnVoczNvZU4rSlJGT0l5WHRER09P?=
 =?utf-8?B?V1pOMnNOYWtGdWlySWJlblpBMnBQbHJJZENOdGRVQXdHVE5UODd1MnNnWDFk?=
 =?utf-8?B?K3VkaHBXazZPWnhjYVk1MGluY3puTUZCNVpPRDZ4VTdRZ2kyTUZsZlU4MjBN?=
 =?utf-8?B?RzZod21JS0srdXZ2TC9pdFdYQVpITTdZUlJRa0NZbG41b3JESXZBd2piUUs5?=
 =?utf-8?B?Vk9CRXJQQ3hpd1pXaFpuMlJxcG5hNDVkYndNUjErS2JZNlZJc0h1NGVBVzl1?=
 =?utf-8?B?UGhLYkJVN1ZOUEJwMTZQNmd5dXdFcWhidnZmOW0zNEVyeEhQRWFNWUFNd2sv?=
 =?utf-8?B?bmxHejFyc1ZydmlvU0d4ditJaTljeTY2cEViZXpkalgwUWxPZmxOdGpkTEMr?=
 =?utf-8?B?RFVBSysxdzd4RHMvNFRmRDVYWmtzNjF4N2ZsQ1pPY1V5MTRIc2lJdHhmckpF?=
 =?utf-8?B?eW00ZkdKYmlkV3ZJWC9Ub055ZEJvNGxZUUhZTEw1VWZXdHRodmZBTE1kYnZQ?=
 =?utf-8?Q?Yz5rSPDF7TMa7kiO5WoC1XKFwZngriQ/Uh7eytxIaXoZC?=
X-MS-Exchange-AntiSpam-MessageData-1: 1NHaD8zFiopIGA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722adfff-c53d-4f7b-58bd-08debc9b04d3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 09:25:12.1169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2mINBTwEEfGyqQfECk8N2UwzzgAhNET2o2zoNk07LTiwTfyBbQBP0isat2XfBdv1YPR2/7xeXXIbtgpIwWf9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10400
Received-SPF: pass client-ip=40.107.159.121; envelope-from=den@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 5/20/26 21:38, Denis V. Lunev wrote:
> Changes since v1
> ----------------
>
> v1 was a two-patch series tracking two independent missed-wakeup
> races on the qemu shutdown path.
>
>   * Patch 1, "block/graph-lock: fix missed wakeup in
>     bdrv_graph_co_rdunlock()", was applied as e3082ab3b3 by Kevin
>     and is now in tree. This v2 carries only the remaining race.
>
>   * Per Kevin's review of v1 patch 2 [1], the cache_clean_timer
>     hang is no longer worked around inside block/qcow2.c. Instead,
>     the underlying primitive -- qemu_co_sleep_wake() -- is fixed,
>     closing the lost-wakeup window for every caller
>     (cache_clean_timer, block_copy_kick, ...) rather than just
>     qcow2. Cancellation latency through qemu_co_sleep_wake() drops
>     from "next 1 s tick" (v1 workaround) to aio_co_wake().
>
> [1] https://lore.kernel.org/qemu-devel/agcYkmTWud8euTds@redhat.com/
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
> Two independent missed-wakeup races in the block layer contributed
> to the symptom on v1. Both shared the same shape: a waiter arms on
> one side, the waker reads stale state on its fast path and silently
> skips the kick, and nothing else on the AioContext fires to
> recover. The first (block/graph-lock) was fixed by e3082ab3b3 and
> is now in tree. This patch closes the second one, exposed in
> qcow2's cache_clean_timer cancellation path:
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
> e3082ab3b3 (with the graph-lock fix already applied). On modern
> bare-metal the window is narrow enough that the hang rarely
> reproduces without a VM -- a VM guest under full CPU saturation is
> what makes the timing reliable.
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
> When the race fires, the Python QMP client times out on
> vm.run_job() after 5 s, the qemu process keeps running but never
> makes forward progress, and the outer `timeout 120` eventually
> kills it. Attach gdb before the timeout kills qemu to capture the
> stack.
>
> Results
> -------
>
> Same guest, 20 iterations of the loop above, master at e3082ab3b3:
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
>  include/qemu/coroutine.h    | 17 ++++++++---
>  util/qemu-coroutine-sleep.c | 60 +++++++++++++++++++++++++++----------
>  2 files changed, 58 insertions(+), 19 deletions(-)
>
ping

