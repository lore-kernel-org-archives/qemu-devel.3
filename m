Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4676AC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x66kA-0000yF-3i; Mon, 14 Sep 2026 09:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x66k7-0000y3-KT; Mon, 14 Sep 2026 09:29:07 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x66k5-0000zY-CP; Mon, 14 Sep 2026 09:29:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hs2nX0pnu53YomD2CzZdwOQfYfU9NxgypryZnQ5WqUZYLhyjnPbhuAkLQDmjxBbfFJmnd/BCVhV+6dhAiu4JlJ3ZcHTubmtqEFz1R9+q3jEEs0LqdYKEFs6QcGNYoMrXZlF6PX5+xvCAVhlml2y5C9RLXQRnCf6RvrfWINAjgNpLEo8QAlbQcxIRwGKMyntE5Yb5w945QoB3AMuVfO+QgfwYpEO6vJ9D2WZnbr5X77R5bTtjWpUp45O7f+YSuFGVGM/H5EcmM2yQvP+H6J9aYoPRxOumLTo1Cdw1Gxlqovx7MhbG9PRW3Fl8SmZvz1t/3gsdn0joF4WIXZOoAOY7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXe9xFkzMixUgpyzNJTz/ohr74eTe1tVVkpqOv8ocfA=;
 b=NiD7PsvoVQdZjCFMhkyhR7IOvbuN6awZf8Ox1dq4G14tSwQT9IKAF3h/eKLk5XchUWPx+wn3oAK8A4LpeUzBFvCxz7Zv+8CcKZ0JjhTJAJDM4pe8QYFShqLLPNW3u+dDeTz+5ayK1jUIG2lFjxMBbkDW6o7liXq4ACg0w6BiS5YEoxSQMpkmR733bfDtEr0Wguk0VsJmv4BRFXtujTobPHSc6YvU5RVZNh2UVUDUoksVQa1/bJopXTnq1KMOzKZg4VcZWTI5C3F5qJGXKgcqZzZeMIcVOTHTnS13R1UoBtKXRhgrP+Ap5qn8643e86O2KJwH0u1as2795tYJQR0fmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXe9xFkzMixUgpyzNJTz/ohr74eTe1tVVkpqOv8ocfA=;
 b=KYDu1fr4WCYqsebs4Ow7t0HLD/mFYTxNVgy3AGzkOywdPelPF+XZaZJOTltv6a5eUZ43hFZhmmdYFSiMRC644ZIFXFm+sYYrZOn48zhCbBy7/fhUbv5wBWCA0cDz3iix/ALt4Y2i0G5fyoNSFwV4CnctpjZmOpLVec/6LtzeRVWdeJ1KGh0+npCwpujphRSGNVA0e1ktyidmPpLfWUtbN6obRgPJ9KNXHRv96ZyoCIDEVJmqKXEJVvDWtBEeJZENGTeb6ToLeLGcOUvZnZ1wbEsuQC9t4UZLaltQt5ZP8V1onOfXfj3YAzCr4kXm/DQv/VgzsX900pDFIT1diewmGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 14 Sep
 2026 13:29:00 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 13:28:59 +0000
Message-ID: <457b3743-341a-4c61-b3b7-e062c3841c1c@virtuozzo.com>
Date: Mon, 14 Sep 2026 15:28:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] block/block-copy: track known-zero source clusters
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
References: <20260828144554.1741910-1-den@openvz.org>
 <20260828144554.1741910-8-den@openvz.org>
 <178826982594.73810.4225192708153339814.b4-review@b4>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <178826982594.73810.4225192708153339814.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0093.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::10) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU0PR08MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cf1100-bcd1-490c-cd91-08df12642285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10070799003|6133799003|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: Y2RX+xjMPUwAlmzeQfQ4Pc0Y0y3Nrb9uGQtgdC5BZW12FmKZWYZu/cEnudeiYTUIksWaBKQ9lmNe2ad2hptzOdh8P+jMoc1EvAGaDHeXCIOD4zep/u/A8bV5h9ik/dPuHxMns8pDJnSVIaS80Ig7gmq/zZo1qtOqgbYi1RgRMymjdc+4+rRnLt6Yc0JTOnnd6q+la727Gof/gccCq2umjDELw0wku8VDPU1FnB+tz9MN1k9S55eEs1G1HGZSqqbVkO/nz0hN+gf5MxMbnSoXa1swC2P8ZmQ1eqe2Qlfs64iAvXnBkmEHsz8mQQFbZ9PyCWoVOjFHJCYR8SG94OE8/6zEOVRObvfZHebTHL2GNC/GEu3gLhTZB7xueqt2aVIkj4y2yUIMmRW3xL2kM0s2O8r51r8WLSNLHLFmVFlpKaRnAO2jfdz4+lHLMFgvM6BBKMcwhukCwsmbSYeIVa12YKp8160UyPbeprM/uSFV80FYRLAcNvT6bt6Nz7VLv3nzJo2gSC/RpRQDZp3JyEaT6M4PtkmKfFlyIjWU6nuql1YVKH1h0YKMcqAIFoXDkUTbYwwuyU4O0JYLsKYbwOHcggXbBkTxGg+IKkotc6xujVUqf02Y2uwTpjNeSGZWsbWOfEM7NKgLjsAgZeO8EGynOmIPfuBEzwcwTiPAU6i/Ijw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10070799003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkEvbXpwU25oWkZuWEJqY0xBZGgzRE1sY09DVWNybjVNSHB6OXh6dDM4OUhJ?=
 =?utf-8?B?YkkraXY3YThQSWlTbXhSY2MxSHI2dURNT2NJZ1ZKT1kwM1lQMnNGMWl5dVEr?=
 =?utf-8?B?eEFMcU1ZQVVNazZvNzBhcDVKUjlWVFBOeThIYjhmc0dET3Fia0doVDlsR1U2?=
 =?utf-8?B?UjJXM0U5RWJab0tLRmRwVHBCVEZoK2dBd1VhVlUrKytXUFlzb21xcmcwNzNX?=
 =?utf-8?B?YUluTnRyUnViN0NGUndmVjA4ckFyZ0cySE1RNlI3SnlUNGY2d2h3bVdOdEI4?=
 =?utf-8?B?QmJxVGYxZmIvWGxPVlBRTzBnUlhsNi9iV3M2K244UStDdm03MnV0VURCYk9y?=
 =?utf-8?B?U3M1RnIyTVZqS2JXRHo2Y05HY3lvVXFTQkliOHNQRGY1R0F4VTJzN2NQazRa?=
 =?utf-8?B?T1dLRDhEZTF0QXpEYkFaWmNKU1JVSWtFaGNDRkRpVmc0RmJVSnAvRFAvUmpa?=
 =?utf-8?B?ZHcyNmVVZFpCenNCbXFWSThjTXRMMXlQNnY3c1UyMTROUFl1WHo3VHdEU2tn?=
 =?utf-8?B?R1A0eXgxZlY2WjFUUVh6Y2hjTm84L2VkUEdnbUVKZjR0cGt0KzRLNm9LWlNT?=
 =?utf-8?B?TGFTN1NaeUEzWHFvelh4Sy9qT25Wd3FZS3MyaktNT2E5Tjl5ZHN5T2xNV09S?=
 =?utf-8?B?WWd0ZU0ydFVRVXRlamhiSTJzeEl5ZTRvTFV3V1Y4Q2xKaldPYXlKellCRm1r?=
 =?utf-8?B?bGNWUjJyNXA0Q21IcHJIa1p1YzM2cEdaaVl4YUUzWUR1NERmdjU0cWJlUmdo?=
 =?utf-8?B?Qm1ScjRYRkdTMkZyNGVpb2NMaDRUcUhJc2t3UVlsRlBkZFJhZ0M0WnpnZVg4?=
 =?utf-8?B?bVdrYlVBbDZPdEJPdm1OckdrVFA3SUlTRDkrcVFBekdlVFpFTWNHZUt4RUtX?=
 =?utf-8?B?UGdDdCszLzVFc1lYSU8wK3VmZk1JUnB0ekJjSE1CcTVjYjZVdDErMy9NeXlN?=
 =?utf-8?B?TkZrdzFLSCs1ME9JSjRqY3BvcVpYMHZpNnoraFFZU01zbUNxcFVoTjYxYVlS?=
 =?utf-8?B?U1BIaUJRdVRIZmxCVHE0TUxzK2hzbDIwK3dTY3h1djJQYStzSzZNMzYwNEN3?=
 =?utf-8?B?TUJzQmxsTnNvQ1VLeFVnV3NkR0pXb1UvVUpUbFNKVmsxSEZ5N2ZWUC9mZW1E?=
 =?utf-8?B?R2hkVXZBbzBrNmhvTXEwcHFFblZLbWNnY3ZrUjZmRm5DNWd4SXhDRGx2SE5l?=
 =?utf-8?B?Mkk4c1hUVG41M0VOMEF0Mi83Vm42eDJybG5ndkxKMWhyeUk5dVNHaHViMWVu?=
 =?utf-8?B?VVVvMDVhbXNxTTNxdWtRWklGeFNTQ2pLMWIxVFIycVBiSUZKYlVUaVE5L21h?=
 =?utf-8?B?aW5uVzd5R2k5L3lZVVZzOTlZVHVQZlFoanRPRlQ5MnpBVDZnZGtVdkNCRk43?=
 =?utf-8?B?ZHBZSFJ5QjZaRi9pMDVDQXV3RHkvTy9TR1lYSG5YM1hVUS9lbGIzcFYzaDZH?=
 =?utf-8?B?NGZ1NzZQU2JQT2ZLTU03OXo2RkV3VWdpNVJiT1YyN1BqVnpTSHV0VUtxaW9j?=
 =?utf-8?B?MGtBZkoreG14dlhQc3FVZk10ZkE0M3pBT01WL0RRL1NsK2tLd21jVExDSzZV?=
 =?utf-8?B?RHJkME5lcWVFaDZSSnJsMDU2UjZETTJkS29PbEh2RnR2Z0MxeUg4ZlNZeGs2?=
 =?utf-8?B?am45QXNUL3dYU0lwbENQaWJ3NllwaUR6Mzg3S3czaTFpUUQ4MzZsVjUwMWhN?=
 =?utf-8?B?UEZOZ090Wm5HUHhwN1JXbTVIQ2tvRXgwWDNVM3dFS2ZnYnR4VGRWdGJhTzhF?=
 =?utf-8?B?Y3lJZlVvMVpaZ0dhdzV3ZSt0Z2tIRnVSYjRKT1prdzZhd1VzQnc1WGh0TUFK?=
 =?utf-8?B?TWtPY3Z4WDdubGcrdDhvYy9ENEFDaitKdVZxbEIxUjFuYkZiWDViMkFCdzg3?=
 =?utf-8?B?Zk41SktUS0REQVFRV215Rml3cHRzUnV4Qm1lb3ZXUWllejZJejRaVjUrSHNJ?=
 =?utf-8?B?UHUzZFMyZlNuU2hmNncydS9tNGFnZStLMVRFUWlESUwweWh0ZFV6bzhydzRL?=
 =?utf-8?B?RWF2NS81Mk53bWQwZGFMb2wzNENLRkNwZEJXNXZUTW1BQWlrNktSV2JuNWN3?=
 =?utf-8?B?R2tJNGxXWUVZMFA3T0VLenF0VnBSbjBuREdzbFA0NkMrQWh6ZzBIbzhiK3Bp?=
 =?utf-8?B?T3o5OHFrc3dJYTFucmlZWGZIZ1ZGMENxTW1Udi9XL2NMVjJRakUzdUdHekVQ?=
 =?utf-8?B?WkRua1hGVDB6NFgyNkRaMEVUbWxXRU5UMG5BMDUyNzFXTXd5UDlzMlBzMkgw?=
 =?utf-8?B?bWcwRGJVT3J3RUJOa3dYMEc1Y1ZXUFZPSkJTd1hxd1M0N0ZmRDZOOUtCektZ?=
 =?utf-8?B?T1orTGZBKzN3TVV5Sit2UmRONTRRdzlZMThkWk83ZFd3M1dwMWxtTlAyVmNv?=
 =?utf-8?Q?FkKXHcGJQ3O4UmvAv2RXjl9hPRx7MUN9uzxSAGx1WZSSe?=
X-MS-Exchange-AntiSpam-MessageData-1: FVahEoDU+k3Gtw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cf1100-bcd1-490c-cd91-08df12642285
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:28:59.6768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWyIRBVEkslYeWtuLGQk2cXvne4zDcwiAlXhc7iJp8mOAXaOz/GwIlPll9SkthTBl4hWMNyaLAC8+QUl8hnWCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8422
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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
>> block_copy_reset_unallocated()'s up-front scan already queries the
>> source, and the same query reports zero-ness. The copy loop re-queries
>> per task and, having no answer up front, can only size a task by the
>> copy buffer, so a mostly-zero image is cut into thousands of pieces
>> that each turn out to read as zero.
>>
>> Cache the answer in zero_bitmap, published by zero_bitmap_valid once
>> the scan is done. block_copy_task_create() then picks the method from
>> the bitmap and ends the task where the answer changes, so a zero task
>> never reaches into data and a copy task never swallows a zero run. The
>> per-task query stays as the fallback until the flag is set, since CBW
>> intercepts guest writes while the scan is still running.
>>
>> The scan and the query it replaces must resolve BDRV_BLOCK_ZERO against
>> the same part of the chain, so the scan moves from bdrv_co_is_allocated()
>> to bdrv_co_block_status_above() and the base selection is factored out
>> into block_copy_status_base().
>>
>> zero_bitmap is a plain HBitmap, not a BdrvDirtyBitmap: an internal cache
>> has no business in query-named-block-nodes. One writer and readers gated
>> by the flag need no mutex, but the publish needs ordering, hence
>> store-release and load-acquire. It is allocated on demand, so sync=none
>> and a standalone copy-before-write filter do not pay for it.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> CC: John Snow <jsnow@redhat.com>
>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>
>> diff --git a/block/backup.c b/block/backup.c
>> index d4713fa1cd4..11d70243e24 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -280,6 +280,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
>>              offset += count;
>>          }
>>          block_copy_set_skip_unallocated(s->bcs, false);
>> +        block_copy_set_zero_bitmap_valid(s->bcs);
>>      }
>>  
>>      if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index d71d070dbd0..94d4f3dd69a 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>> @@ -20,6 +20,8 @@
>>  #include "block/block_int-io.h"
>>  #include "block/dirty-bitmap.h"
>>  #include "block/reqlist.h"
>> +#include "qemu/hbitmap.h"
>> +#include "qemu/host-utils.h"
>>  #include "system/block-backend.h"
>>  #include "qemu/units.h"
>>  #include "qemu/co-shared-resource.h"
>> @@ -157,6 +159,10 @@ typedef struct BlockCopyState {
>>      bool skip_unallocated; /* atomic */
>>      /* State fields that use a thread-safe API */
>>      BdrvDirtyBitmap *copy_bitmap;
>> +    /* Clusters reading as zero; allocated on demand, frozen once valid. */
>> +    HBitmap *zero_bitmap;
>> +    /* Published only after the scan, with skip_unallocated already false. */
>> +    bool zero_bitmap_valid; /* atomic, store-release/load-acquire */
>>      ProgressMeter *progress;
>>      SharedResource *mem;
>>      RateLimit rate_limit;
>> @@ -190,6 +196,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
>>                         int64_t offset, int64_t bytes)
>>  {
>>      BlockCopyTask *task;
>> +    BlockCopyMethod method;
>>      int64_t max_chunk;
>>  
>>      QEMU_LOCK_GUARD(&s->lock);
>> @@ -201,6 +208,27 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
>>          return NULL;
>>      }
>>  
>> +    method = s->method;
>> +
>> +    /*
>> +     * The scan already knows how this range reads: pick the method here and
>> +     * stop the task where the answer changes.
>> +     */
>> +    if (qatomic_load_acquire(&s->zero_bitmap_valid)) {
>> +        int64_t boundary;
>> +
>> +        if (hbitmap_get(s->zero_bitmap, offset)) {
>> +            method = COPY_WRITE_ZEROES;
>> +            boundary = hbitmap_next_zero(s->zero_bitmap, offset, bytes);
>> +        } else {
>> +            boundary = hbitmap_next_dirty(s->zero_bitmap, offset, bytes);
>> +        }
>> +
>> +        if (boundary >= 0) {
>> +            bytes = boundary - offset;
>> +        }
>> +    }
>> +
>>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>>      bytes = QEMU_ALIGN_UP(bytes, s->cluster_size);
>>  
>> @@ -215,7 +243,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
>>          .task.func = block_copy_task_entry,
>>          .s = s,
>>          .call_state = call_state,
>> -        .method = s->method,
>> +        .method = method,
>>      };
>>      reqlist_init_req(&s->reqs, &task->req, offset, bytes);
>>  
>> @@ -271,6 +299,9 @@ void block_copy_state_free(BlockCopyState *s)
>>  
>>      ratelimit_destroy(&s->rate_limit);
>>      bdrv_release_dirty_bitmap(s->copy_bitmap);
>> +    if (s->zero_bitmap) {
>> +        hbitmap_free(s->zero_bitmap);
>> +    }
>>      shres_destroy(s->mem);
>>      g_free(s);
>>  }
>> @@ -624,20 +655,24 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
>>      return ret;
>>  }
>>  
>> +/* The scan and the per-task query must resolve BDRV_BLOCK_ZERO alike. */
>> +static GRAPH_RDLOCK BlockDriverState *block_copy_status_base(BlockCopyState *s)
>> +{
>> +    if (qatomic_read(&s->skip_unallocated)) {
>> +        return bdrv_backing_chain_next(s->source->bs);
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>>  static coroutine_fn GRAPH_RDLOCK
>>  int block_copy_block_status(BlockCopyState *s, int64_t offset, int64_t bytes,
>>                              int64_t *pnum)
>>  {
>>      int64_t num;
>> -    BlockDriverState *base;
>> +    BlockDriverState *base = block_copy_status_base(s);
>>      int ret;
>>  
>> -    if (qatomic_read(&s->skip_unallocated)) {
>> -        base = bdrv_backing_chain_next(s->source->bs);
>> -    } else {
>> -        base = NULL;
>> -    }
>> -
>>      ret = bdrv_co_block_status_above(s->source->bs, base, offset, bytes, &num,
>>                                       NULL, NULL);
>>      if (ret < 0 || num < s->cluster_size) {
>> @@ -657,16 +692,41 @@ int block_copy_block_status(BlockCopyState *s, int64_t offset, int64_t bytes,
>>      return ret;
>>  }
>>  
>> +/* Only the scan allocates, and it runs before zero_bitmap_valid. */
>> +static HBitmap *block_copy_zero_bitmap(BlockCopyState *s)
>> +{
>> +    if (!s->zero_bitmap) {
>> +        s->zero_bitmap = hbitmap_alloc(s->len, ctz32(s->cluster_size));
> Hmm why it's ctz32() when cluster_size is int64_t ? Is this intentional
> or an oversight?
Intentional, and it is the same assumption the file already makes a few
lines up: copy_bitmap is created by bdrv_create_dirty_bitmap(), whose
granularity parameter is a uint32_t, and that call is handed the very
same s->cluster_size. block/dirty-bitmap.c then reaches hbitmap_alloc()
through ctz32() as well, so zero_bitmap and copy_bitmap end up with the
same granularity by the same route.

The type is int64_t because the block layer passes sizes around as
int64_t. The value cannot need more: it comes from bdi.cluster_size,
which is an int. The one way to push it past 4G is an x-perf
min-cluster-size above that, and copy_bitmap would truncate before
zero_bitmap did - a pre-existing gap in the parameter checking rather
than something this series introduces.

Thank you for review,
    Den

