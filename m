Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A20C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x682R-00021E-VT; Mon, 14 Sep 2026 10:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x682M-0001yv-Vz; Mon, 14 Sep 2026 10:52:04 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x682K-0005d7-Vn; Mon, 14 Sep 2026 10:52:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0wqN/RoRbwClwjbcI5GBUu6Ii1qhWDV9+GlQtv9f5n7gEKUxlm0Srzz/lxp26okNlCIitprTILj+SHSzDIzMvfOE/tvjxl+KPwdKddB1cvDr2y+iM3FIiT3qH1mmzNZ8MICJ3UChNPa5K8w7GPdWFvWjL8fZwdmIG2TRkw721oqRRTackSnWHr5MPu651vtd7//p/bBWI35UXC46WVJBoWBHAsjun22qXbzGw8PKh6AXSuiTYvZTiS8myO8Cu4O7VBzrmB6nUsx2TYRk/RZ2fz8dS47KWAzAdQFLMesKSeqIT7GDzaeMALoOcZoyCF0v94PeIyW6VZiFlI26hhrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa61NCcnv9UNRXRYGjnzj4EnL+qRBjFyZyzbyMsAppk=;
 b=ZQ4be6FkMA6igOi0MWb/+B81CayENY8EtAToTC3rAvZRw3n4ictjUB5Dne54quNNzsykr0isluPy0E8oNNaWe38G9UJx78nB9gtYtNwDwzk5LGYoC8oD8InHnD67e037STahcIrkxo0uvHsK105J4RprKcpKJBmh8DMR+PLYLETyy4myf/9f4eCOy92deGnSWmEnXUGk3SMUDZi9qvwUES1eXuuPdw2N9hIAYxdwqGz38ACr8AZh3/QjTuKOSZJGPWj11JN8WqOfauDOl4aRrfVer+rWlb54z7YZTBsiLEmJtYz1nL6rKFgzfU1Y+pDVh15YoPF1gV1YDX162rQhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa61NCcnv9UNRXRYGjnzj4EnL+qRBjFyZyzbyMsAppk=;
 b=vcsNAF2zzbCy2Y0mJehkNaHWYPOpuSgAxrsyfrZ28nwxbQjRny5Cs1tQRcg9IsvYuiFLQGIoL4CzNcWNq/S78US5+iRQcBj1VbAaNyn9QZu0FOlQeUxArwLZRAzsNJOLhR7gaCVTRLtcrN3LvgVwvQiH4CXn3nBh+5O/t9PtNUgx96cSJ4nfMeUmMzPQ3BWpmadJPzubY4zV3cyddgGf7rON32SbwaaX1p1tIPcaBog7l9TMnb8EAsU8vstkW3B3s6c/3fbcLnACoc8CPSeBq4EB3HO/acO9YADbYDYaWODSl7WBCkO2kdHsI1V2sUwnsNm1HANrUq5ta0K0AsPE0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAXPR08MB6349.eurprd08.prod.outlook.com (2603:10a6:102:15b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 14:51:56 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 14:51:56 +0000
Message-ID: <ae4b9680-8782-4311-af31-ee4599618976@virtuozzo.com>
Date: Mon, 14 Sep 2026 16:51:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] block/block-copy: coalesce write-zeroes tasks
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
References: <20260828144554.1741910-1-den@openvz.org>
 <20260828144554.1741910-10-den@openvz.org>
 <178826982594.73810.9138039014408511227.b4-review@b4>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <178826982594.73810.9138039014408511227.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF00000216.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ce) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAXPR08MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 8503cfa7-4568-4b15-8054-08df126fb911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|10070799003|1800799024|376014|6133799003|18002099003|22082099003|56012099006|5023799004|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 33fDdR5ezhDEkhue8NxGpnJzuOnrRZBtu/e/YNmelBsQ3GHYRM/CmWGKKxLbRHdCWznyMF7bKKQjKZ3sXBUEOVCyMn6791eJlan9SYZ5rhz+UoRL7kkKMD9J7cU5Wz6V+vCbdcGZBDZCD5taEUgPqtRCzXJorzKLdjzOUfRhM1xJAaNVthEdmyQtWh3RCu6QkCNFlLQdGrkxSeARWpeu5o8qG1/R6pO98dquXk7X0RP6Eaaf7hgvt9RGTLG/mFKrbpVsEK9TUxeQfCxg7au++paKPOsTPycJYleiL6eHv94XOqcVwezKx71JGAryLclqMefWb/uhqGr5hC/WpFuNU+XGQHyVSY100Sb+StdNo9QsNmGRePp933xb5+L4DlnmA6Vt0qSi78kV/VmJSHZN3Lmk87RntOIB0Tfz1Sq9wfT/zwskjkiWfwK3FIUCDQER+JhuqYUHuMmut0ALS3NdpeyftkyY1hSrz+4XKJQx0jawnq1+OG89CmHYfpqxp5/JnSopDXd5VbuD0rgDfzgpx3lm4Lx2MJNyMC0WBWR6dzDrRGskbNM4AQLJfEllV6thNC8EK0pN1K8OCsMwPVnRiuXsb7hC3FHbKaLs9086PW8Y0ehOPyeCulSbhj7eOjUmRbmQrOcPUYwvXdlicEBe4kUUmt1lKKDRWuWGhtdm/sY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(10070799003)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGh2TTFUZ3FnRU9EUStjYU1Gak5wTDdiNnFUSXJWcm9FL0dQcGJ3Wnh1VHZU?=
 =?utf-8?B?OFRrc2lFK3k4Y0ZpV05mUW1iaHNmeUs4ZU96MHU4TzZKMWZPaGdMMXZMMW1p?=
 =?utf-8?B?bm00SXYwa0ZZMXpQZjVxbGdPSm50VFhNMjZwZmJaRUhvTTBlVkpVZE5tM2Na?=
 =?utf-8?B?M3pqYVVHNWRIRmt3UTVVWGJ2dVd0Q3lTeUJkNXdaa2tqcUJoQnNWdEkrZVhU?=
 =?utf-8?B?Q094cVByY3dYQkpXbW8vdVVVN1BUNFFQOEthNkErN1lzbDBwVXp2aXJCTWV1?=
 =?utf-8?B?ZFY0VFROOXNlTFlrME0zaXhFcERFWjV1czMrWXJQdm4yZ1dPRzhRS1IzVGVz?=
 =?utf-8?B?ajVuUEdSeDRwQmlwbWwySjNJY2s0TzVha0IrREI3cjFEd01xVGdEUkduQjk4?=
 =?utf-8?B?RExmb0tUeTduZ1RMS1JEMmM4TnZWZGNSd3F4allYemd1c0xEN2ZoVnNES2Ix?=
 =?utf-8?B?OE44MUFYZG83WExJaVQ1Q0tBQTFMU2t5dHo4S1g0Q1RTVHJobVBQaHp1b1F6?=
 =?utf-8?B?UWhxbFdUY0k2Wi90Tkh2eFdSdDBxNlBsd3NVclV3Tzl4aFZ2RFlLR1UzWkZs?=
 =?utf-8?B?c05lbTJ1dkExMkFCQ0JqdityNUgxOXVFb0U5SHdoWmdSRGJyNkF0THgyZ3Ix?=
 =?utf-8?B?TmhlRVBQcnUxYW5WMnVoYmQ2K2poaFE1dk1Tbzd6QVU3T04wb2dNakdPdXJu?=
 =?utf-8?B?eHhnOEhxQm9HMmhJUUFUNEJFVmZiejYyM0QxMHd4QkxUNTgwTHN1cVFLazhH?=
 =?utf-8?B?b2FaU2FBMFZ5c2dPWFhjMFcwVjQ5MlMvK3orM1ZzUWdrRWp3RmN3R0NVVU56?=
 =?utf-8?B?a0pmUmdycW5SdUM0bXNHVVpDenBRN3JOS1M3blJ4YThYUlVUR0F2NVhUUndH?=
 =?utf-8?B?b2ZQWFNhWXNiU25YL2dCZmcvZ3IrNzgxOUhDbXk3N2NQMCtMT3VRSUhFM0JE?=
 =?utf-8?B?TkpjZUpoTHlnSjZoN0l3NkdLQktiYzZ1K1V2Nk5MUjRsRlkvTkRkV1lGVWFT?=
 =?utf-8?B?Qll0YVN4Z3RSRERZQS9oTnV0eUhTUjJvWWJlRHIrb1BzdlJyM0NvU01lM0xY?=
 =?utf-8?B?MU1sY3o5QzdXbW1lNVFwcG5aYUNJMkJ0QlAvUGROd05ER1YyUDVyTGQvVDFt?=
 =?utf-8?B?V2NlWXhQSzhCWEZjNW51ZWNoVzZuODJCS1p5WHJFaW1LaEJUTWRxSHhVckV6?=
 =?utf-8?B?V2lma0I0NTlHSkNzWDhXdE9ucnZmbmVmWFc2V1Q2bTZMdVZPSXhCUlliVUJK?=
 =?utf-8?B?TTRrSTFRckpmYWZ5Q3crbk1KNy9DOU9rQlRPajZsc08vcGZFT3lSY2xFREUx?=
 =?utf-8?B?QmRIbUpSZzNUc1UzODRnL2JFWnJzVU9ZK3B6QWgwZW1tdnYvaGJTMXk0dHFq?=
 =?utf-8?B?SzN0QTRmM2JYQWhtQ3JsTUw1ZnBDRFVEVjV6c3JZUktlYkdtM0VPcHRaWGRT?=
 =?utf-8?B?S3czcEUrd0RYcFlIem9aQ2I2NTNYcHgxS2V2Ni9hWHFpTnhvNkUwSVIySjlL?=
 =?utf-8?B?VWt6RUpScFVpWUJDYm4zSkxYUFQybGphbWkvaHhsUEp2UWp6STh3ODR3anlI?=
 =?utf-8?B?dWZBSzdIZTUyT0xmZHRzWDFOREFvc3JnUnE2Umg5aUpyQTVvcjZnMEJETWQ0?=
 =?utf-8?B?U1ppampHVlZKTzNpcnVpUjNoenBkYWZOTVVHY1FUV050ZFUzeHF3RlNXdDIr?=
 =?utf-8?B?cWZsL1hTT1NXYlVQcTFpa2dpV3QxeFFXK3hZN2hjQy9WbStGZ2NVN1ptcExG?=
 =?utf-8?B?Z2dKdy9jcm52Y3VoQlZzVlhoZUppS0FKbHBGdjBuZitQK3gwQ3JTcTI5Vzgy?=
 =?utf-8?B?VlVEV04rUmZrVnNRc3RHZVlKMUhEOXhMU3FyWFlWMFBWVEU3YjhrNDRubDhC?=
 =?utf-8?B?OS81VTZ2S2J5MVNuQ3NtcTI1UnIzbnRyTHFwTEVMV1F2NWhRaThZd3dISzlu?=
 =?utf-8?B?eis0ZnBweHQra2VUYlYzclVhclpXeG9zbk5iN0MxakZ5VWxDWVpmMG44dlIz?=
 =?utf-8?B?Wnd2dmpmZUpncCthT0FFdWpiQ3BHc21qdmoxVFlvRXQyRXZVQU4xWmxNa1JF?=
 =?utf-8?B?ZzZGS0RKSlJuZzE0ZlcxZW4zdlFDakNmOHY3aVJoeTFjOFZoY2VDSkNzc2tC?=
 =?utf-8?B?NjRYNnB0aW1aYW5ScDRSRFpzRDFUZEhnQjBKVE9JOEZzVHZ0Y1Y5RWVvQUNv?=
 =?utf-8?B?UkUrZ3pEN0hxbTZIbGFnOU5HYjlNLy9pTklKMnprdGFCSGFqVmF3eVVHKzdN?=
 =?utf-8?B?QWQ4WVU4WmduMHlyem1VQ3NsR3lSaVorb2w2NENORFJQbFlQeHBxZ005bW9F?=
 =?utf-8?B?THNOZ1RVN1ZhQ1dwdERSYUk1clZ6R0N1M0EwaHpReHFhNXc2MHllTzEwaGxu?=
 =?utf-8?Q?qDvdwbO4UUHZmIWq9r2gkMrXGuhjnBWKcaUI5HfFh1QfG?=
X-MS-Exchange-AntiSpam-MessageData-1: pO6yWEFhhgfltQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8503cfa7-4568-4b15-8054-08df126fb911
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:51:56.6463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2u3RLKgDT4Wt21CAijDj10HRPO3GSRhC5hhQYNdruJ7VZSVB3RaQuwr0qkpHNwRDFASnHN2OHhOhy3rku+bXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6349
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=den@virtuozzo.com;
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

On 9/1/26 15:37, Andrey Drobyshev wrote:
>> Task size was capped to block_copy_chunk_size() regardless of method,
>> which sizes a task by the copy buffer. A write-zeroes task carries no
>> buffer, so that cap only splits one long known-zero run into a crowd of
>> small COPY_WRITE_ZEROES tasks, each with its own request against the
>> target.
>>
>> block_copy_task_create() already decides from zero_bitmap how far a task
>> may run, so add block_copy_widen_zero_area() to that decision: for a
>> write-zeroes task, re-search the dirty area under
>> BLOCK_COPY_MAX_ZERO_CHUNK instead of the buffer chunk size, and let the
>> existing clamp cut it back to where the zero run ends. Widening is safe:
>> an overlapping caller waits on the task's BlockReq via
>> reqlist_wait_one() rather than observing it mid-flight.
>>
>> The 256M cap stays well under BDRV_REQUEST_MAX_BYTES, where
>> block_copy_do_copy() would trip assert(nbytes < INT_MAX), keeps the rate
>> limiter usable, leaves enough tasks to fill BLOCK_COPY_MAX_WORKERS and
>> bounds how long a cancel waits on one request. It is aligned at the use
>> site rather than in the constant, since nothing bounds cluster_size.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> CC: John Snow <jsnow@redhat.com>
>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index c0a33599384..16b76484cbd 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>> @@ -37,6 +37,8 @@
>>  #define BLOCK_COPY_MAX_WORKERS 64
>>  #define BLOCK_COPY_SLICE_TIME 100000000ULL /* ns */
>>  #define BLOCK_COPY_CLUSTER_SIZE_DEFAULT (1 << 16)
>> +/* Bounded by BDRV_REQUEST_MAX_BYTES, rate limiting and cancel latency. */
>> +#define BLOCK_COPY_MAX_ZERO_CHUNK (256 * MiB)
> AFAIU with this new cap we enlarge the range, a guest IO to which will
> trigger CBW.  It used to be 1M or 16M depending on copy method, now it's
> 256M.  If the target is qcow2 - then write_zeroes() is size-independent
> and is a simple metadata write.  But what if target doesn't support fast
> write_zeroes() operation?  Then guest IO will be stalled for the entire
> CBW, and the latency increases.  Please correct me if I'm wrong.
>
> If it's true - shouldn't we probe for write_zeroes support adding
> BDRV_REQ_NO_FALLBACK to the flags?  And if -ENOTSUP is returned - don't
> widen zero area.
>
> Andrey
>
v2 probes as you suggest. CBW itself cannot grow, though:
block_copy_task_create() searches within the range of the block_copy()
call it serves, so a copy driven by a guest write covers that write and
nothing more. The wait comes the other way round, a guest write landing
on a widened background task and waiting through reqlist_wait_one().

supported_zero_flags rules out the targets which cannot zero cheaply at
all, qcow2 v2 and iscsi among them, but is optimistic for the rest:
file-posix advertises NO_FALLBACK at open and finds out from the first
fallocate that fails. So the first widened request carries the flag. A
target which would write the zeroes out fails it without writing, that
range then goes out in buffer-sized chunks, and widening stays off for
the run.

The cap is therefore BDRV_REQUEST_MAX_BYTES rather than 256M, aligned
down to the cluster size. On a 16G source holding 1G of data, sync=full:
1088 block-copy tasks for qcow2 v3 and raw targets, 16384 for qcow2 v2,
every target identical to the source.

Thank you for your time,
    Den

