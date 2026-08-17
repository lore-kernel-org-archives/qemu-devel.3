Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55025C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyT4-0006lv-8C; Mon, 17 Aug 2026 10:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wvyT2-0006kr-Oo; Mon, 17 Aug 2026 10:37:36 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wvyT0-0000GD-Tl; Mon, 17 Aug 2026 10:37:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqz0uioPZB7Av2gv0R50Ra5RjJlGxCQy1ACMAo4OZEKayFHPr7v1eOaHVKgzNs23YOc69hIif65+46QIeEMmamttn9OaxvdWg+4Hv4+oWKjxy0wh3CfO+kAWfEbecd8ne5QdXyFStIG+zYLQzVhvWg5gIkqueDKyqWjZuMEetbJkc6yvW+Y27JiiNY2PwTGZJRU7fArVyM/QiOSgA31rjo00xwctVYu3kzugWWL6FuFVlEi5FutXs6T3pUUqL7mb6Rd8d3B7vL8Lr9FP8759nY3DGtcdj68D8/mftuV+7zYQadgn1QG6WzZEzz/ESE++FRTaV0ikyR094iNnYJ2VFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIYWrkFtZ4RKmfTV4Q/ouYVu7BJ4v8STfCPDVEtbnJU=;
 b=NMsBZLt2ckNAvEISR8aiCFFg+eYj/0k/8is3iqUijX0s0B/CHNqsOkvpOIWElQQLz0ZZ9mcOLyOtDluT9fifN/Fa5DilFT53oliypDIwp26/GSBj8xNO6cpVOde0chCF005eWFm7NKSmi4lD2JUHtEgO6FLRee/GMdT1m0A6m5R0OmCgmJWMtpoH0qPSo1gnejhpwwXpOT3RgVF6W/WSoVu43l4eg6/VpiYoRqL5hAimsq8cGrpf/wVA7LD9TLoWLp5bWk0b9m8qZXEouO91Sn3quh4Ht9c++en+nAKFoG1OqznAKS6RMR+GGwMc5DEq9vJLhdw+hOhLXtcPmR3zRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIYWrkFtZ4RKmfTV4Q/ouYVu7BJ4v8STfCPDVEtbnJU=;
 b=nucN2Pcl0BBEbNJ1D5G9IkUaduVhcJVYW+Ns8jpmiJC0dxAv8U3o3+P0eXIreB0hbmHkhfqX6pWnd4ZqIrF/6l9g+vPQioYtTY0d71LcwBIxPWYZVxwb/q1mkMi13rGb8XmvHQepW2wTIUIHdDLfQEwSY0fj61C/rpDcuajhiZ4P/v11uMDhGJk77ULpvI+p3jT70RECY06AmYVwaQm+iFjGa/5pRN1sTpVODvLFWk5650E7tWKiDUUIqc4q6wHarQWo31sWNI3Tgh0LvyfotAjICkn8ziWQWMp/NcKnnDxhe0Z/+wi3uCA9V3fyOGVtCKMmIljhuHUYrh4Iga6BLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAWPR08MB8813.eurprd08.prod.outlook.com (2603:10a6:102:335::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:37:28 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:37:27 +0000
Message-ID: <d64158df-c1b0-4501-9fd4-7f28135b8dad@virtuozzo.com>
Date: Mon, 17 Aug 2026 16:37:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] dirty-bitmap: fix integer overflow in serialization
 coverage
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260811173857.396571-1-den@openvz.org>
 <20260811173857.396571-4-den@openvz.org>
 <183c3455-caf3-4132-a99d-ce6d6c7585dc@yandex-team.ru>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <183c3455-caf3-4132-a99d-ce6d6c7585dc@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0028.eurprd02.prod.outlook.com
 (2603:10a6:803:14::41) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAWPR08MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8fb40c-1071-4760-cbbd-08defc6d0f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|1800799024|376014|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8JgD6adPn4BcOqX7FsbiuOTg7qAY5oz5nLAo22GNdbOovc1WckL3kWLKaKVj3Y6BlkglkzCgClWlWZkG3nWom+wnwpoXhdhpdIDJ6fgy4dDw/1EALVCxrDTXJtaTz8nyBqYAd8gtjIhw+OHacbv4hojwVW4AEnktLv0VGkhyaPgTXQGS3s+eIIbOYPDmfndzevrZqsexGd2/xbokkIftlbu0tv1AZs+UxKMN/wzoUGghvdLNmrX+cq0u+fzX9gZ1YNksqklQ654GZq2aGLoz4soCbd+5us9Xmqx4wUKYQ5JomfGHe/l2U/+xfOUXRwydHDSdU43SuzYQTdLUh9sHyO1XhMhRr9PmfVLyu6wA5FkiKqbBEqvRAS7tq3C36ZKdxBOKQUW2pZkkAufGFl4VYRq0mmJdAopXl8asfm79LpIH7vnaKJuQg5n7b9zXhe8IQ5wFITDCZnfo8Gv6gzjcslHCKxLuiV3osZ7OAT/pGxByKGDGCwcxQZGWT16OXAFJdG0e65khnfIieTv236YhVwiNojAQmIefzkSKu5fg6PLpcro5ogcP05AuC4zRCbIB8elwVZNmDQUtwrOwr5d0ZlmN8vUi7J7QFTsHl7OaDhnmRsHx07ixP7LD1sSVRUjflRRmoNLeBNS43nlsX/7pf1WBdVXnAnjua/w4gEC+W1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFc0N0hyZ3k4RkxYMHBxQ0JpV25mWmRrUWkvaHRYZ0VkRnVlMjgvN2FybXFy?=
 =?utf-8?B?aEhzbXdGUzdkVW1TcDlaM3dodjF2MEFzY2RVSTQ5dFZKcnZHRHlRWXRJZk1K?=
 =?utf-8?B?cG5hZTRmZ0xmWVZRc09ZSGcxS3R3NUFGcGRQamJEUExrU2JuRmxjUFhNOTRN?=
 =?utf-8?B?MG9NNHBTVXpmY0s1eFZLR0FPbzYyUHRqUmhxb0hhV24ydTJYdTFpYWVkdlhp?=
 =?utf-8?B?dTBTZWk0K0UvVzgyNGVVUDZmUy8rSEYyUDgzWDZOQ05PcDZ3TW9qNTBvMUx2?=
 =?utf-8?B?dFprNis0eXdkVkxsc1JZWUZOM04rcVhIMjVGWG5UU1ZTQUwwUFBoSEtZUnNU?=
 =?utf-8?B?Z0ZNdCtlRGhlTVpLU1Q0NnVxL0ZVS1RKLzIvYlVobnBYaklQZGRiSlhPM3Iz?=
 =?utf-8?B?UHdiQzFTQkc4WTVXRmJCK01mb3BHYTEwbThMbkxPbUZwOGt0UGJha2NleGp2?=
 =?utf-8?B?bE8rZ0RvSjdhczU2blBvR1Njb29tcm9GOUtwYmI3bXhUVVNONThIVzlTWThi?=
 =?utf-8?B?TFFBOFliM25RTE00ell1NmZtcWQzZlJoTkh2Z2hJVjcyWC9nUEUycG5jbDJU?=
 =?utf-8?B?aEc0ZVcwT3kxVUVkemMyejFLWTNQU3lFaDZmMkJQZytLRlpzS2dSUmdkRG8y?=
 =?utf-8?B?N3JiUldtd0Rod1BPbklVbUJrZWpnOExIU1V4d2wyS080ajNMYjFDV21ER3JW?=
 =?utf-8?B?ZnpVVlpEUHVrdUdPTmlYMmRST0ozMVBJM2Q5SFRxc05xTlhSd1Z5UXpid2U0?=
 =?utf-8?B?ajVtUkNSbWdya2c5Z2tQREpZQjg3VWQvbFduUFA5OHF6UHpHWGlxTnNVYmNy?=
 =?utf-8?B?VkxzZkI0Nmd1c3UwamFIZStUQXpOSy9mU05JMzhUaHo4VDA1aHFRTzRXbGZs?=
 =?utf-8?B?ZllSZGowdHYwYmNmQUs4UWVIZk5JQTl0REtKQ1NHSGxPY2tvUlNGVTdDcDZY?=
 =?utf-8?B?eFJqbkFRbC9ZWCtWcW9KS2ZQL1Vadjg3end5R2pnYlhoQW1SZ2dRZFMweXN3?=
 =?utf-8?B?MUZLVk45Uk5BS3M3OVpTKzhONUlTK0lZa2FaMTR0NDUyVWplT05pWkdyQkFZ?=
 =?utf-8?B?RWE1VWsrK0xrK0w4alB0dlN0MHJlQ3NvWkJCVXhIZUtuMnRrRGVYdnUzbHNF?=
 =?utf-8?B?TG80QUV2OTFkS2ZKMDUvMG1UdFhZMUlBcTJraC9GalpiZVRhbGdpdXluT1c2?=
 =?utf-8?B?TG5XUVd2U2ZWRXlsVkdxdW8zZ3psa0Q4akZLd3VZU0pGWGJ6cllOYUlUTWxH?=
 =?utf-8?B?bCtCWW4vdUhvalFSYlVITVFCNm92K2NOdDNhZWFXSnZEcTFnOGZYa2pQVWRo?=
 =?utf-8?B?Wkh6YWZTT0JJOWJGamd3T01xSEZNQkpONEFzSWhGd0gwbGhNTEtrb1RCUmZy?=
 =?utf-8?B?RXkyUmsxcWxQaFExclZ5cFErVThRT1l3TXc3UWo4aGJsY0I3TkdQbDJFMmlQ?=
 =?utf-8?B?WDdpTnRJNFdET1RXQVZGUmVicVdLeGtGZ3lpQ2ExdDM4RjU0aGM1cUsrUzFD?=
 =?utf-8?B?cXdSMldhVVV4ZkU3U2ZDQ2pubjd5WFAyd3lTUEVXekZKNHlHSkNBYXNzLzQy?=
 =?utf-8?B?SC9zM3RrRGFQanV5cEdLdGlIVTRoZ1hiUmNZVXNDblJzS1dYK3FIVTVoYnhk?=
 =?utf-8?B?NzZOR2lZRWp3Nko3T29DZ0ZvMGR2eWVkYXdyL09XbU1sUHptQmpoUUphVG1M?=
 =?utf-8?B?Q3hlMUx2bE5zTUJoYjlvMUlCVWJ6MHVhVzhZWXVvTnB1dzdCMXc0YWNYcTUw?=
 =?utf-8?B?b1MzeVBFd3J2QndDS1RXSzRTZDNyU0l1SENUTEZ3VW4rR0IzaWNJYUtZZkV2?=
 =?utf-8?B?cmkxd0VkSzNma3R0NXBhUE1yWjRGYTBlT2k0TXNrYVFIbXZ6cXlnTUROLzVt?=
 =?utf-8?B?UHVZUmlOWm9wMVFYQ2RGd25qRDl0dmIwb3gxY0o0ZkY3c1NIRkxDdURpZ3BU?=
 =?utf-8?B?Z29kZzBHMjBCVDFLbHZUenFDN1NzZ2E0Sy8wUXZtQlVIUVFmbkFpNSttWXU4?=
 =?utf-8?B?QTlCaWNjOU55U0VPTjM5b0NxdjZrYThLdVdaai9mRlBqTmVvejVHMEVGL2FF?=
 =?utf-8?B?RjFuOHRxWkYxNEh5dTZua1A0SVp6NUx0TEoxdHkvbktyMFpNSXp5NEtlUEVM?=
 =?utf-8?B?UmRScmd0NmFYNTdoUVF3ZlN6Y1FqTEkyWEgvVTRQdTUxT1pBM1lFMnRoQmlj?=
 =?utf-8?B?TnkwYnJvWklMOEhKdCs1dnNiR0VnQStzODZRakN3NlVCMW5FS3Y0RlFLZWhE?=
 =?utf-8?B?OUFtU2U3YjhFSHVNY0RwR2hMMkVmdmdOck9MK2ZWSjViMnFmekpaZFlZM3BP?=
 =?utf-8?B?U3phT2ZYb0RkcW9zQU03cjc5R2pOUmRlSVNSNmw4ZjZzTDVJeEh1d2p0a1RU?=
 =?utf-8?Q?PpTfa0yiLbdnvpA8dy2jd+ccwV68ubcYi1xLr2Tt86bdC?=
X-MS-Exchange-AntiSpam-MessageData-1: o2bu+VDHVrMG7A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8fb40c-1071-4760-cbbd-08defc6d0f9a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:37:27.7818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdBkpDEWVSTaJzJ8ERcIwQtgTLJCkviVQXfkOrsUwntu23SdtKHSryn6r2D3ORZnLMhk9+jC/34CTB0etHJX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8813
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=den@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

On 8/17/26 16:17, Vladimir Sementsov-Ogievskiy wrote:
> On 11.08.26 20:38, Denis V. Lunev wrote:
>> The chunk size is an int and is shifted left by 3 before the result is
>> widened, so a chunk size of 1 << 28 or above overflows.
>>
>> parallels passes s->cluster_size, which parallels_open() lets reach
>> 2 GiB. With a bitmap needing two L1 entries the bogus limit makes the
>> "bm_size - offset" in parallels_load_bitmap_data() underflow; both
>> wrong values slip past the assertions in serialization_chunk() and the
>> resulting index lands outside the hbitmap, so a 128 KiB image memsets
>> unrelated memory through hbitmap_deserialize_ones().
>>
>> Widen the shift. qcow2, the only other caller, never exceeds a 2 MiB
>> cluster.
>>
>> Fixes: 35f428ba3971 ("qcow2-bitmap: make bytes_covered_by_bitmap_cluster() public")
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>   block/dirty-bitmap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 13a1979755..9fda3a4b98 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -612,7 +612,7 @@ uint64_t bdrv_dirty_bitmap_serialization_coverage(int serialized_chunk_size,
>>                                                     const BdrvDirtyBitmap *bitmap)
>>   {
>>       uint64_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
>> -    uint64_t limit = granularity * (serialized_chunk_size << 3);
>> +    uint64_t limit = granularity * ((uint64_t)serialized_chunk_size << 3);
>>   
>>       assert(QEMU_IS_ALIGNED(limit,
>>                              bdrv_dirty_bitmap_serialization_align(bitmap)));
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
> I think, it's good to pick this one for my next pull request with another
> bitmap-related fixes.
>
> Thanks, applied to my block branch (this one 3/8 patch).
>
>
Great. Will remove it from pull request.

Thanks!

