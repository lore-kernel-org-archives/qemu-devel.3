Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5244CC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woK5Z-0004Dq-B9; Mon, 27 Jul 2026 08:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1woK5I-0003sK-Vy; Mon, 27 Jul 2026 08:05:32 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1woK5F-0005mc-RO; Mon, 27 Jul 2026 08:05:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm/Uof4mI6NEJVzNfEmuhLQr7mXxx/6454OKV3IQx6mfnwse1EivmKBcFicAETkfIoo+i9MBXL6l11g1nW6UB9dhwU9+T60gvhdHd9y347IagmRjUX+przu1YJOZeNw7IujVeotZZlUSs4iKuf7va0lLFx5G6VX6NwnNTMB+3+EDuOwCRXSJO0cBXIL5tV0AlJTtrM85CP9XwIX8NwTOcrZrCnmgrvWuvbdOdPqNhOrkbS5jU0Kf7lI8VAMp8BDaZKsfgDqNoUbo3JS7UJPllVb6UyBBNEfTjyuEaAeIizlWwNMFsz0Ak30vtYZ6ruhJHZLt7RDVixVormm6szjLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS6zMx0FlAtewDGxtlMXmDR1EWljf8zFJqqH6DYn/hE=;
 b=StrxIF53gFDQ6/5co7tH65TfQdX8J1ZAZI0KQaZlWuglNRjweoPCCUCyvi4L9fzzkio+XLTWAqMUi3NilLf3amy5TiKlHcuCciJdhs8j8+LU+stOKGHMFatazdWWg1kUxXUeYNL80yiKaf8vWoGM5X+0411Uitx1XdRhLdfEebWo4E/zs/AJeqy1DL4CKxrOIymzLjAyxsLZ/EOZXwEBG+kF/BrCilnOysnhjTpf9lF9c2NHXk7luCnryFScjDQwE0v9r4pmPIcfN1i3cFwUEpTASMXbaLg/ngC8X89X3YJNJHBbWGZ4mk6SPMJD/OSia//z2uBvuaGOLQHIERcbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS6zMx0FlAtewDGxtlMXmDR1EWljf8zFJqqH6DYn/hE=;
 b=Fh7msbI7Hrht2f/IEtZhFRRzGYsEcVVXHzsp1WnjU5j3UFC4gGG815OIKGB5TKmxB7FsQfrF/eogDwc2aQi3FVbF3OlIdH3mF0lL0sgTbc7brJoWEcJ62nl3uq76MQ64IMHCUj2G5gs9HSGraqZfOnHb5Eg5yoSCUq6BAbSViy55AOsReclVcyTk072Mkh3HiPeU9GY5HMlmuTuc9IYF4RLlPWnQbckZnRCK9gMtNYTnnuYSaF+qyNduS3sRnoKDXP79p7nQM408V8PeYZaAT6mxsXy9DLhT8+GJRri3pwMgauioBoN9Np94XsrlzNDxXOFcX2b08t8E6TLHqbB6iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GV1PR08MB7331.eurprd08.prod.outlook.com (2603:10a6:150:1e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:05:20 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 12:05:20 +0000
Message-ID: <cb21314c-f664-444e-a446-f613a40b3151@virtuozzo.com>
Date: Mon, 27 Jul 2026 14:05:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block: reject persistent bitmaps a node can never
 store
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260716112242.3000035-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260716112242.3000035-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:803:64::25) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GV1PR08MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 3771c30c-6bde-4e5b-b1ad-08deebd75493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|23010399003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: AlebcGiSi5v6rPwM+1UC5nSoKmDSP66kZSSMKzNEr+fsT+ZTNpbT5CPiuO+OW0uExKfspCRltMZg4GJlhbEdFhmtb7EyrQG/BM98UTsSMu/FQe0EijN+gcrla+Hvn5GK0UnXKClsEVf+H3fZnTmaOaP6s/+sjM9d93lKrFm3eTntGKAny6Sc6/2iwx4MVdjX8Kx+Du9Akj8HAqjalU7e96VUHwbk0kfpmsuVthCJqpnXY2+SAu2RavgvKftTSlFePoijlIuon15BLrdqXCUeQoX7ZVr9qXP66EmawR5aljRKic/d9nEtTJa20AC6yixDx1WK9vvRTjX01Z4XWgoOAruSTD8R3hgndPXk7FJbc1AcnWieqvsgHIw8XOe1SuplGKKwO2vJNXL0vM4sCcHvjONBFIuMY/CxEOasQtWNRf33zvlLNFbik17pqRVQzitn6GJcfzI+cF3Mh5QrucDCg/abYI7c//dEJy1R9Rb34HP9BlzgUKbigr/w33CpxeXUiskKKfqMdcP+6eGsTQ7fCz+JpJgue/oFX0kAJEuvGoizpCJFgd5tnQYYzRwW9zmvSK3Jl0lj3ucQMj518gIAJTAPo8XgUYmiPznBhHf4hMPhfySo9txwLFe1iNvrhJECD4mAtUQJrpEZdsFjhzzMJWu9EM1W05ZS4fxDUeYoJec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnFaVndySlU5MEpGSHBUbGV2R0VFMzV3UkY4d25pU0RMOEcvbFJJcVk2NFJH?=
 =?utf-8?B?dERzN0ozeGtEbkVHTXRoYmNBeTE0SHdxZUQ3aXA0bmRNcmc2R1dtT0NZVjFo?=
 =?utf-8?B?RGtSeWxoNlBQcFJHMEU0bytOUlBWdU5scHJMTzhxMlVuTmUwdHlzVmw3YS8x?=
 =?utf-8?B?Um80eU9sRXNod3J3TkJvNVlsdmpQcXFyY1FGZ293c0d5Z3lQclRWb05SOFRD?=
 =?utf-8?B?WElMSnFzd1ZwRDg2aHllVHl4WHBjZWlsVHdHMEgwOE4zRmZpd0NMc3ZEcjFU?=
 =?utf-8?B?Ukxrd1hlQWt0MU1xbzUrMFMzaHl2L1ZKVUl1aWtWeERTYS9pTStJWDlyL0Jn?=
 =?utf-8?B?bEkyNDdyUFo1RERpS3IzRkFjVlVsVGYzajlKOE5zTkNnQ2VqOEd4enlmaFJv?=
 =?utf-8?B?NHRpT2wzYXZhaFFIaEtzV3BEbkxhYzRQeERyQ2Y2cXhicmVadzhQc0NyNmxt?=
 =?utf-8?B?UjFDS2liZm1YbVFENDBzallabkR5OHJkYUp6OGlubFdQd3EyT3hxVWlwNUtN?=
 =?utf-8?B?a0NQeHBySHVDUGhjZitUZmdIS3prdElDZWxPV2ZMVS81WVp1Si8xdm9NWmYw?=
 =?utf-8?B?N0xpMGN6bTlPUmJ0U3doK2tNTi83bEpJM1NnY0dsTXZPK1lhYTZMQXJKNE5W?=
 =?utf-8?B?L2pTRVlTVzdaLzh2a2F1VTVsVWhVcDlvcW5jajNXN21lVmFVWGliUFhLb0lJ?=
 =?utf-8?B?MG80d3FSY0RmcFdPSXQrSXY3U0toaFBuNFRTNjJ0cnBrUGZySkE1eFlycEhr?=
 =?utf-8?B?bFd6bEh1eVovR3daMWRkL2Y2ZG56MFg5WDZCNlEybDZ5NnFWYkIxUS9EbjYr?=
 =?utf-8?B?YXRjM0lkNHBUZUMydkxBcFFwREVFWTVUY2dUYkNwLzVYVkJTckJIVUJqWmtD?=
 =?utf-8?B?aS9JRmRzZU82UTU0V3RwTlpwekFHSEpRNTVpcUo3Y0ZPckdsT0VaYTNuZDVa?=
 =?utf-8?B?ZnFac255UEpaR3FGdkVmbWw5emZVekJuZmdWeERzQi9MSVpSVU1BdFZrdTA1?=
 =?utf-8?B?UXJmTkFzNUlNWjR6YUJrRVBTWnlZRWlxQmtMUnhmNDNBM3daTmZ3K1NuV1VH?=
 =?utf-8?B?RHZjL2tXMjBiUzRGUW5MVUJDYmkvb3RxNzdBc0RNUDhUS1RJczFCdVNYMlVo?=
 =?utf-8?B?WGlnVXBFT0s3cjJpbjdtTTY0dmVscnpYOXlWZGRscmJiM0p1dUJsMHp6SkFJ?=
 =?utf-8?B?TXhpeWpBMTNlR2RHaHJKdEdVaUdCQm9ObDY3ZU1SeXRPTkVDNEVFU09aWmNH?=
 =?utf-8?B?ZEtReXE2ZDVabmhHelphOVFYczdCaHNmYnU3M2I1L0tFZEV1b1UxR1BHM1ND?=
 =?utf-8?B?KzhCL1hVeHNtUjFYaCttUUd1bklyVjFBVkt6R3JnNW5FNFY1Z0dmSWxNMHdt?=
 =?utf-8?B?RW56N1p1WUNOV0NqU3J2dHdRaVlXYzJ4WjA1Zys1S0hBY3pVSVpYMXVHY3Y1?=
 =?utf-8?B?TTI2RHJLL2QrTVYycDF6K05WNk5HMkhDZWhaNWVLK1ZtSXVBTlcxRlN6QmZG?=
 =?utf-8?B?RGwzcEl3M3ZtQzhlcDVCTnR2andpV1FsSW8wRkpuVTdmQU9JNFhaaFkvQ3hF?=
 =?utf-8?B?OE5JNFNOQWhoUnRjQmJtNHFLV2ZXZWV3OFpGNThFNFRLYVNrS1dIWUw2MWQy?=
 =?utf-8?B?YTgrNDJnTCtySjlHTzJXVi84bHBDMzBnVVlDZVpMbTdSTWRuNGw3bW5jNUpC?=
 =?utf-8?B?OTBGczFHVDJDS2lXYmR1TGgzOTJXejN1YXQ2Qlh2TXQwQWZqTW5KWXFIaVZy?=
 =?utf-8?B?amlyNTR6Z0prUEdML2pUU0F3UjRTRDl6UmRGVGhHbWpFZjNUaS91NDU1SUpr?=
 =?utf-8?B?Vzc0dnp6aWtSVzVCM3h3SzBCSjhzcDFhMUZnS0svSHozVzJDTStNMmkzdnlu?=
 =?utf-8?B?KzhYL2dVOEM3bUhXU1NndVU4REltenhlaEJZd1ByY3lFT0orb0xRRkpVSjRJ?=
 =?utf-8?B?L05VR1NVR1JpSEpZWWVqK2NUVnBKUU1PYVVTeG1hWEh1THZ1b1dRcHpwR25Z?=
 =?utf-8?B?RHhVWjFlc1AvTjhWRWtTWWNmSUFSQ0R5di9EWHdLK3hhcHdiOEZTbDdja3JS?=
 =?utf-8?B?QytuL0preXNEUFhNL0c3YThYamlwUmI5Vm5mbzJWeWVkOGZFOHZxMUhMb3lR?=
 =?utf-8?B?cTFXYlUyYlVCNitjUXZ2UWZpOWpzQXp3UlYvQ1l5eCtYTjllMG91L1FjTHB5?=
 =?utf-8?B?SWZPRDlCUTRCNkFCV0Y4VWE0NFVOZmE2SjhhRHYrbWNaKzBiZk41eWxFUXZ6?=
 =?utf-8?B?WndhYnVDYm5tMFZISVY2V1dHcDdja25iaDlZN25kMnJpV0RJTnJpSmxtcDZY?=
 =?utf-8?B?YlgxR1NoVTR0Vkg0YnhaczE4UWVJVlRJOXdaNjA2WlRnUzA0QmF5RWxmaGZp?=
 =?utf-8?Q?lYMFKt9AHn/+kIwy7aJudtSPniEdj6h7Sebl7uPpp/93i?=
X-MS-Exchange-AntiSpam-MessageData-1: x/cNMUaF23IWYw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3771c30c-6bde-4e5b-b1ad-08deebd75493
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:05:20.4028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLrBKAMINiqDPoPZtHq5HKPDJQ+z+MsutFPfS0u7Uqh9I79CPH1a2i/gaVzKn1HpetkPtY7gMH1sbHV2mjrmxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7331
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

On 7/16/26 13:22, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> qmp_block_dirty_bitmap_add() and the incoming-migration bitmap loader
> both create a persistent bitmap with bdrv_create_dirty_bitmap(), which
> always creates it writable, without checking whether the node can
> actually be written to. A persistent bitmap added to an already
> read-only or inactive node stays writable in memory on a node that
> can never store it, and the next global inactivation (migration
> completion, save, or any other bdrv_inactivate_all() caller) fails
> trying to flush it back:
>
>   Lost persistent bitmaps during inactivation of node '<node>': No write access
>   migration_block_inactivate: bdrv_inactivate_all() failed: -22
>
> Patch 1 rejects this at block-dirty-bitmap-add (and, wrapped in a
> transaction, denies the whole transaction). Patch 2 closes the same
> hole on the incoming-migration path. Patch 3 fixes a knock-on
> regression from patch 1's approach: a bitmap that was rejected from
> ever being written can still exist in memory read-only and must
> remain removable without requiring write access.
>
> v1 -> v2
> * approach changed to deny rather than adopt (Vladimir)
> * added patch to add permission check on migration path
> * added patch to change permissions check on bitmap drop to more natural
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> Denis V. Lunev (3):
>   block/monitor: reject persistent bitmap add on a read-only node
>   migration/block-dirty-bitmap: reject bitmap load onto ro node
>   block/monitor: allow dropping a bitmap never stored on disk
>
>  block/monitor/bitmap-qmp-cmds.c               | 19 +++++++----
>  block/qcow2-bitmap.c                          |  9 +++++
>  migration/block-dirty-bitmap.c                | 22 +++++++++----
>  qapi/block-core.json                          |  4 ++-
>  tests/qemu-iotests/tests/migrate-bitmaps-test | 33 +++++++++++++++++++
>  .../tests/migrate-bitmaps-test.out            |  4 +--
>  .../tests/remove-bitmap-from-backing          | 29 +++++++++++++++-
>  .../tests/remove-bitmap-from-backing.out      | 22 ++++++++++++-
>  8 files changed, 124 insertions(+), 18 deletions(-)
>
Hi, Vladimir!

Will this go through your tree? It is looking like nobody else cares.

Den

