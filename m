Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31067C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB30-0002Ho-JG; Wed, 12 Aug 2026 11:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wuB2y-0002GM-5P; Wed, 12 Aug 2026 11:39:16 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wuB2v-0007Ud-44; Wed, 12 Aug 2026 11:39:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdSOful+5hBQ+STdk9YqO7f/iGZ8bbmQdcYbu+pEd4Hba2O6m6oixSfpMmB3gcMHR+AjtLjrPKYiV6PeleUCUFDLci8aPiPHFteD8uPr/9JVkLh3ctHMTdYWO0GlRHfDww6/O4rbaaNrc4XnhxuTUzvKiYR0FJuy3mQqIspPZ0oyauAk/2PdfOOyAwthO7M3TtTMYAVogcpgPFb3Vv3yVU3fx9/oVKTXO+oxo0FLf8dnbny40u+8YTvHyTKDqEGGovVJ4wSB0Nb5Sz9jZC50hEzhjee9rms0oewWA7Vsptj3wVUVin4EMqImEpQYvb1LBEpHJM+rjODhtPAkY3OiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1kf9yt+p9bzdlfYeLiTmzqe/pz+dvMRm8AqGc09ACI=;
 b=qXGDYvnbku+aqBXhZVVAd9kt9gu7gpWEgM2Aka09WYejTCCV5HQqpLkQPLANM0mxWxW75FwhfHg9DqR1QpHjXY0dzu5Us5v9JG5lx8t2vZRyItHet9wBuDcJ6GOSunRCGF3wBnv+lzA16+XVARYoyFK3HMI99+eHUvthw/Pl94HyoK/cxNzdoJ3pcRnpLC2oldSuDXFpvoBfhZETAMOnJIAWwXva5Z4ubV4Xr1ySIxY1WNkth5gwESpqw28jZFxJsyV+gRNVYqe7jUIXjnQqvO+nBU12TptIFeq5j0RdRGGeKwlfMvBdWhtHePJY2qUWXBvBP8YObOzJDVIuWMBCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1kf9yt+p9bzdlfYeLiTmzqe/pz+dvMRm8AqGc09ACI=;
 b=VtMXCHNEhmq2L9L9QI9H/oKZrsH2Xxgsye5R3tY1vwf27lZUvWOfwETQJp2GihaOqpVzUtyEILDyJt6Bob9wWHNmUU51cjpvs5HExBohmr4GHLG8VFjgG1Bs76kgj4aXNShMa8XmYskXfC1bDdPChUYT1dFIYoStip84dBbvQ0gVc0v57iDR1y7Thc3c4qyWJNufvb0o6iwsq5tpYjgxUDr+bpFRPEK6VcLW3k0zcsXDpXJ4lHuQ9WQmDwYq9rXJvLNieEeB1yLk2min3LpTd3CaYafPQe2jGWpUSPI1rAuKC2E3RmZCpi+VeX02Z7FWVpvh/Y7m7AASSab6JdKOaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by PAWPR08MB11558.eurprd08.prod.outlook.com (2603:10a6:102:509::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 15:39:08 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 15:39:08 +0000
Message-ID: <afcab54a-d472-43c5-852c-87bbbd82f37f@virtuozzo.com>
Date: Wed, 12 Aug 2026 18:39:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] qcow2: repair a dirty image when it becomes
 writable
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
References: <20260811154213.184947-1-den@openvz.org>
 <20260811154213.184947-5-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260811154213.184947-5-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|PAWPR08MB11558:EE_
X-MS-Office365-Filtering-Correlation-Id: 412daaf8-669f-4c82-2391-08def887d969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|56012099006|10067099003|5023799004|4143699003|6133799003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: dP0wTP4/j3q6ahw7dk87bZg7zawTfNs0XlXzAhLcAhaULSQKvlTTinrya+oyuWyIhLUDrUuU+ywQXlyOOOBQwWUpwlKLA8ZjqW/p/XapPHmx4qmhtulrgAKnvPOnC2g5kUYzojqf4avmnEgVACqcV0XUIHsNS6RAGZgwj4+z0syLYg3lb4LNPVXkV/0X0c1XvKQzMouzBhm8jFqPdtkRsmTKWxaxaj2LDTYKW1PGb30zN566Af5ECG+A2xlv3cUbBE6339/ypXH48DEP939BeRyTHRZlZVAyMfYlNyCMVwz1rHro22ftv+Je4DJmfrFbVIveGDjG+BlXi6rtesQdEI/X9oEJZxSoJUqfcV9FUpxyR4gaxywLGbeh62GK2AJj6j15Wf/KuFbj0tHfMaG0KhRGd2cekiz0yvmyrjn8tOHKYIpnUzrvEtYetLvCY8VbUHYAyb9PVT3d7WTXBUqlHsCKOag1u+io7ipegXEu358L7qrvSdkYUaYXHWZCAIRf27jKVftpitt9oTUq3/ZRoQWhho8kJXg0l9GI5WDv9Bdiwbc1+OWxgCDt3uSYmEHQrBCOA7Uxd7cApLqp06sXnC9ekL3882eiB6wwYidkAX7EjIhQcl33osaZFilbiGSRTSdMAssst9CAUpV3ZCrdgexRbr9TvLFjOXQrEjHvFag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(56012099006)(10067099003)(5023799004)(4143699003)(6133799003)(3023799007)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktUVGNNb0JadDZySXNhMmhvM0thWlA4Q2pZSjcvdVBFOUZNa0FLUzAvMm1D?=
 =?utf-8?B?QVN0MitDU2NTYmdGbmdPa3Jwa1JCUWlRSTlJS3RteTc2TUMvNkNob042Mjcw?=
 =?utf-8?B?YUd5YTVjMjdpY2Q2dzhXWXljV3VXTGJsZUQwYjhYTkVWM3JrWkcrc2RvV1FO?=
 =?utf-8?B?cFNicHNKcmRlTXE2VXJrYUtVRHc2Q2tEclJhQXVPOEtsNm9ic1NjUTd6L3JZ?=
 =?utf-8?B?aXc5NVRTbnBDbW1oazIvN1QrZlNIZXY4S2xZd3NtWCtROGIzWnBHbG5WMmwr?=
 =?utf-8?B?SHZWQ00wOTdUcDJaa3VxSkw3Vmtod3UzV3g3MU1UcFRudWVldUFENVVRaCs2?=
 =?utf-8?B?M1k2dDJJUk5zdUlxMCtob1JCNFJXYWVRSVN6OWtRbWkwM1VIRkV3STJQYlh6?=
 =?utf-8?B?anZidVZmUE1nRUVDSUhzWFBvcmR5ckRkZzBudTRYbzVnUDZhajYyWFlubkxo?=
 =?utf-8?B?Y3pBOUUwVjVTc3R1cnNCMURoeWlmU2FGSkNRd2V2cXMrNnZNZi9VSjZ5MzR2?=
 =?utf-8?B?RkpEclN3V1h1cCs5SG5OZDNnalJkTkREVTVoRHdZUnlteVdKd2JPaThYNVM4?=
 =?utf-8?B?SFQ0T3BhcjExcmttWGVMdzFIUC9QSlhYUWFrOFlEeTFLekZHN3d4QWpaMEVG?=
 =?utf-8?B?WVNHS2NTTmZTVVAzYXlCMzFPNnpnOFZEdGJLNjFjcjV4NkFWd0pBMFZFNW5W?=
 =?utf-8?B?SmFqZHh0Z0tuS1dGMUN6dUh6VW8rTkUzeEtvb3Z0YlRsZDdQV09VeEVxL1Iy?=
 =?utf-8?B?NUE0eStyVjBPUXI4bWI1aEhENytYOU9wK2xlMkIxUXlDYWhHT3F0R0l5RStl?=
 =?utf-8?B?ZVlsRUZ4N3FtTG53SmVLdm9xZ3Q1MFhCUE10WEhQV2FMQ3QzdzdqMFlxS2hv?=
 =?utf-8?B?WDhKWHUzekJFT1YwbmRibHZkRTBDbWhxWVhDSnhybklMcjB0QU9uNE1ReEg2?=
 =?utf-8?B?M0xEcjhTTkJSQmQwcEJ4WlNSK1duMENIcHhCZWw0UG4rb2lPNUtTeWlnbnJE?=
 =?utf-8?B?V0dhTTFNanp6NGRTeXU0TmNLOGhSUDdLNGg3Y1ZNajJqRVNxTGdHcVppN1c5?=
 =?utf-8?B?RDlzRE1ta1U4QU9UV3ZyTTN1U3l1eGx2N0ZtMWpNbXNHcUNSWVR0TllpOUEz?=
 =?utf-8?B?ZXRhb3RsV3QzbUlObGxIcnd4Q1hmRno0S2pqL1JuU3JGOVlMSm1GNDU2b0U0?=
 =?utf-8?B?Tzl5MSswTFIzelpVeFArSzJJZzZLcnhYSnF0K1hreDVvbVJCdGJoZGV6bjRv?=
 =?utf-8?B?ZWxOMTRpRFg4T0ppeDRkdzh6UmQ0ZVlnQ0hVRmhCbHFlemZSVFpyc0dJNXMx?=
 =?utf-8?B?a0hxN3U2dlNDQjZVSlc0cENEZnBuSS9ZOGwySVNRaExXNzkvV2Y5VzdkWFlh?=
 =?utf-8?B?VHVVVFRvV1JlL3picEVoQmpDMHFRSEF4UG80VFhGSXU4R1U5NkFHVGVPQzdl?=
 =?utf-8?B?UVZHQW5qeHl4eTg3TmpLK1lhSllWMXZwS29iZzV2UjlzbUV2Z1NhbjZKKzJS?=
 =?utf-8?B?R2JPTzhaVGhIbElQLzl4c1VONU15NldnMU9iSyt5dndRY2dGZStoVzRYUDJr?=
 =?utf-8?B?MmVZZklNNGp3VzhrUHNkek4vNWczSHphTmtGbDFxWVFjMDFYNXBrZDdqS0tH?=
 =?utf-8?B?WTRsMllJZVNtT0NzbGx3U2NKZGh3bG5wNW9UaWFFcUZ6dy9BblNqeHNBOUdq?=
 =?utf-8?B?bGZpREhLdE9aeUhiU0pXbGdSN01LMlRhK05qeXZ5SldQaFQ2V0lNWHVuTVJi?=
 =?utf-8?B?bVJzVDZBMjV2VFJtU2F0T3dCZHk4amEvUklwU0pHZGxHa1pic3pYeCtOS0Mz?=
 =?utf-8?B?STF6TDFNbUR1dWMzc1dPQUlPbGxaRmVqa0dTQkZOem1uRStEN1pEaDV1Sk1K?=
 =?utf-8?B?VW1ySWdPTTZNc1o3WDVUZXFlZ2ZPVmNqcVNmNUtyUVRTRlZPL0F1VHNrNzFx?=
 =?utf-8?B?VlBaRFh6OUFuRXN4aHJEYllkSEcvUGxPR0UwOXpqa2kvbzlxQXhNWG5qK2Jl?=
 =?utf-8?B?QjlLMGJiVjVJQTBtWmoyNWlxUnZ4ckxVODEzNi9qYTlCdHBnSlRjVk51aW9k?=
 =?utf-8?B?cWxCVnZ1VzdFdjRhSlF2SVZTQUVqVUFqeS9qUEdoZy9FaXBrZExqb0w4VFZE?=
 =?utf-8?B?NXRiWmZIN3lGWVRXS2tUVk9rYmxyWjZZNkplaEhCakdHTlBtUzJTUkkxV3Ux?=
 =?utf-8?B?cThONjdOa0Q1eTFOSlJWYlpJSWtNVm5EZTBFLzdTSVUzUVo4eFpLU200UEZD?=
 =?utf-8?B?ZkFqV1NFVTlDK1Z4TUJtSWVqdi94YjAvOGIzcWN2Wm9UZDNFMTZjd2ZNRVM4?=
 =?utf-8?B?c2FkRjQ3ZkJCUDFOQnVpeThWWjB2UDEwNjBBNnRJeGtibDMxNkkxanRJc2U3?=
 =?utf-8?Q?cHW9D86W34SO/rZo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412daaf8-669f-4c82-2391-08def887d969
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 15:39:08.6287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bd+2voGgEMmxbZSheLxtAHv/WoQlldLg/oVhXIWocieiVYfjp/b28m7rOhmIQcfGpceJBzx0c6K+rN7R2naP3JVKKgtu9ZQQGs+kFEFIgS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11558
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

On 8/11/26 6:42 PM, Denis V. Lunev wrote:
> A dirty image must be repaired before anything allocates a cluster in
> it. qcow2_do_open() does that, but only for a node that is writable
> from the start. A node opened read-only skips it, and nothing revisits
> the question once that node becomes writable, which block-commit does
> routinely: commit_active_start() and commit_start() reopen the base
> read-write for the duration of the job.
> 
> With lazy refcounts the on-disk refcount block then still accounts for
> the metadata clusters only, so the allocator restarts at the front of
> the image and hands out clusters that L2 entries point at. Two guest
> offsets end up sharing one host cluster. Nothing fails, the corrupt bit
> stays clear, and a clean close clears the dirty bit, so no later open
> repairs the image either.
> 
> Do the repair in qcow2_reopen_commit_post(). bdrv_reopen_prepare() runs
> before bdrv_list_refresh_perms(), so it holds no BLK_PERM_WRITE and,
> with auto-read-only, bs->file may still have an O_RDONLY descriptor.
> commit_post cannot reject the reopen, so signal corruption if the
> repair fails rather than let writes alias live clusters. That drops
> bs->drv, so return the error and skip the bitmaps. An inactive node is
> skipped: bdrv_activate() calls qcow2_do_open() again through
> qcow2_co_invalidate_cache().
> 
> With lazy refcounts the dirty bit stays set for the whole writable
> session, so a node that is merely writable says nothing. Repair only
> when it has just become writable, which BDRVReopenState remembers:
> a read-write to read-write reopen must not scan a live image.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: qemu-stable@nongnu.org
> ---
>  block/qcow2.c              | 17 +++++++++++
>  tests/qemu-iotests/039     | 60 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/039.out | 36 +++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 553a94d003..bac3e49cf5 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2147,8 +2147,25 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
>  
>  static int qcow2_reopen_commit_post(BDRVReopenState *state, Error **errp)
>  {
> +    BDRVQcow2State *s = state->bs->opaque;
> +
>      GRAPH_RDLOCK_GUARD_MAINLOOP();
>  
> +    if (!state->was_writable && bdrv_is_writable(state->bs) &&
> +        (s->incompatible_features & QCOW2_INCOMPAT_DIRTY)) {

Nit: qcow2_do_open() also guards this with !(flags & BDRV_O_CHECK).
AFAICT we can't reach it here since the only place we open with
BDRV_O_CHECK is qemu-img check, and it never does reopen.  Still, might
consider adding the guard.

> +        BdrvCheckResult result = {0};
> +        int ret;
> +
> +        ret = bdrv_check(state->bs, &result, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
> +        if (ret < 0 || result.check_errors) {
> +            /* This clears bs->drv, there is nothing left to reopen */
> +            qcow2_signal_corruption(state->bs, true, -1, -1,
> +                                    "Could not repair dirty image");
> +            error_setg(errp, "Could not repair dirty image");

Which image?  blockdev-reopen can process multiple nodes.  And we have
no clue which one failed.  How about adding
bdrv_get_device_or_node_name(state->bs)?

> +            return -EIO;

Path qcow2_do_open() -> qcow2_co_check_locked() does preserve the
check's error: ret < 0 ? ret : -EIO; error_setg_errno(-ret).  Here a
-ENOMEM from the check comes back as -EIO.

> +        }
> +    }
> +

There's also a logical issue with this check.  qcow2_signal_corruption()
does 'bs->drv = NULL', which explicitly makes the node unusable.  Now,
block commit does reopen the base node to RW, remembering its previous
state.  If reopen fails, it does rollback reopen to RO.  And on this 2nd
reopen we'll likely end up asserting on:

bdrv_reopen_set_read_only()
  bdrv_reopen()
    bdrv_reopen_multiple()
      bdrv_reopen_prepare()
        assert(reopen_state->bs->drv != NULL)

on this unusable node.

Can we afford making bdrv_reopen_prepare() return an error instead of
crashing?  Or maybe guard this rollback in commit_start() by
!bdrv_is_inserted(base).  IMO this is either a separate commit, or part
of 2nd commit.

And we should probably add a qmp_block_commit test which would cover
exactly this problematic case.


Also the QAPI docs for blockdev-reopen say:

> ... if one of them fails then the whole transaction is cancelled.

That no longer appears to be true.  Probably should amend the docs as well.

Andrey

>      if (state->flags & BDRV_O_RDWR) {
>          Error *local_err = NULL;
>  
> diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> index db52c580d1..dd4f48fa14 100755
> --- a/tests/qemu-iotests/039
> +++ b/tests/qemu-iotests/039
> @@ -136,6 +136,66 @@ $QEMU_IO -c "write 0 512" "$TEST_IMG" | _filter_qemu_io
>  # The dirty bit must not be set
>  _qcow2_dump_header | grep incompatible_features
>  
> +echo
> +echo "== Reopening a dirty image read/write should repair it =="
> +
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
> +
> +_NO_VALGRIND \
> +$QEMU_IO -c "write -P 0x5a 0 512" \
> +         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> +    | _filter_qemu_io
> +
> +# The dirty bit must be set
> +_qcow2_dump_header | grep incompatible_features
> +
> +# Without the repair this write would alias the cluster at offset 0
> +$QEMU_IO -r -c "reopen -w" \
> +            -c "write -P 0xb1 1M 512" \
> +            -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
> +
> +# The dirty bit must not be set
> +_qcow2_dump_header | grep incompatible_features
> +_check_test_img
> +
> +echo
> +echo "== A read/write reopen must not check the image =="
> +
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
> +
> +_NO_VALGRIND \
> +$QEMU_IO -c "write -P 0x5a 0 512" \
> +         -c "reopen -o l2-cache-size=1M" \
> +         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> +    | _filter_qemu_io
> +
> +# The dirty bit must still be set, it belongs to the running session
> +_qcow2_dump_header | grep incompatible_features
> +
> +echo
> +echo "== A failed repair must fail the reopen =="
> +
> +_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
> +
> +_NO_VALGRIND \
> +$QEMU_IO -c "write -P 0x5a 0 512" \
> +         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> +    | _filter_qemu_io
> +
> +cat > "$TEST_DIR/blkdebug.conf" <<EOF
> +[inject-error]
> +event = "none"
> +iotype = "write"
> +errno = "5"
> +EOF
> +
> +# The repair cannot write, so the reopen itself must report the failure
> +$QEMU_IO -r -c "reopen -w" -c "read -P 0x5a 0 512" \
> +    "blkdebug:$TEST_DIR/blkdebug.conf:$TEST_IMG" 2>&1 \
> +    | _filter_testdir | _filter_qemu_io
> +
> +rm -f "$TEST_DIR/blkdebug.conf"
> +
>  echo
>  echo "== Creating an image file with lazy_refcounts=off =="
>  
> diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
> index 3c71e5a3dd..c0e1bf0a09 100644
> --- a/tests/qemu-iotests/039.out
> +++ b/tests/qemu-iotests/039.out
> @@ -64,6 +64,42 @@ wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  incompatible_features     []
>  
> +== Reopening a dirty image read/write should repair it ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> +wrote 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +incompatible_features     [0]
> +ERROR cluster 5 refcount=0 reference=1
> +Rebuilding refcount structure
> +Repairing cluster 1 refcount=1 reference=0
> +Repairing cluster 2 refcount=1 reference=0
> +wrote 512/512 bytes at offset 1048576
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +incompatible_features     []
> +No errors were found on the image.
> +
> +== A read/write reopen must not check the image ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> +wrote 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +incompatible_features     [0]
> +
> +== A failed repair must fail the reopen ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> +wrote 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +ERROR cluster 5 refcount=0 reference=1
> +Rebuilding refcount structure
> +qemu-io: ERROR writing refblock: Input/output error
> +qcow2: Marking image as corrupt: Could not repair dirty image; further corruption events will be suppressed
> +qemu-io: Could not repair dirty image
> +read failed: No medium found
> +
>  == Creating an image file with lazy_refcounts=off ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0


