Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5C8C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjXA-0004VD-HN; Tue, 11 Aug 2026 06:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wtjX1-0004UY-40; Tue, 11 Aug 2026 06:16:27 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wtjWy-0003W7-Qx; Tue, 11 Aug 2026 06:16:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YI5kSwzQ+EjBZMa13ms19/HOoQ1mFoCbyOOwTo/RYtuw3yLGax2LVsA3fhhKEyFJJGYGtY8xa74GTIWqQ/cGF74sV3ASc9plOWB5BL9KYMQVH/pLcXF9Ho+aRVfsAuXdDnRfKHmP7/nOJDBvhnhqpi0Jb+0jDWYqLVo8W6l3XzP0uiQq5RvMXhz84uCKDDkhwLlDSdZ6y2iqLCNwkApHFRwZFGZsDsRD9W5R3G0KqqWc9S9QQ9HSgaPHliuEVZ0C7Xfdz2oznmf+icnKRm5VGffzUwNE+hhJxF2LHG0O28RUMZuXIBY5A1FCtrmO/c+25BkzTZdu++f8vBn3qvbfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3bS3XAPZNOWHR2iEwH5LAw5BzgpX9xCyjM0Ne0OZ8M=;
 b=lkAHXr0NeYOsEjrL6xpNnafpdTS7uZr+9D4QecdO2Ew+PJ07/cigqc8rhCmKeEHNxPp9PLRFHsToLrpbD831lpu3nLMN4v91x5UwwE2XKyFdcdjA5JILvPVP1EUo9DpWLYICB66Ka5Po4ucYIPfeHThsEVD9mi4MD6XUZuhplGskq0x6i5MFZHT1tpyHc7l/CKJ25Q5qJmSYgmzKJgJd9iajtl9670HFJoe8R8JRVRAiD3II8LTz5sIXFTVC1y6YQ/Nkhc6d3il2WBOrym1Ab8jRWqynRONIylUNjGDU0GhzmGSkGGJYaxr/6MCBZMXAqmueF2xMxy2sqcthmAtJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3bS3XAPZNOWHR2iEwH5LAw5BzgpX9xCyjM0Ne0OZ8M=;
 b=0Haz3cYX3f5vu85xNKpSdi9n3ojQwNzlMTVh3Q0BuokO5xwUYlGtWFKPmXgP7ataWa3Acjq3uK1L9mZOUX2Hf7MWJX0IJe6TJRV6mxWuE/sL5zjZyGG/PILc/Nd+blG9BgvY4bINz3bJdcP2Dblv8kF6c32VDFUOcTmxIYd+5L2381cfcE3mc3D3TtkZTLK+1aVRIzTJskQ0/tND3B5bM/PCROyGu3RxN7P5sRy9B+ndUOHPbUuXSeJRa+BmxXn45afkMSFVzpzKXTyNQa81N22Gv/kKqsS84hc6Bw0VlyJZKQYHrGlTsqkLueXh5HJUeG6KWswfLedY8NswJe0PZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9612.eurprd08.prod.outlook.com
 (2603:10a6:10:45e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 10:16:15 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 10:16:14 +0000
Message-ID: <8d19b588-dfdb-4e60-837a-c43d335cd935@virtuozzo.com>
Date: Tue, 11 Aug 2026 13:16:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qcow2: repair a dirty image when it becomes writable
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20260731220039.1765584-1-den@openvz.org>
 <20260731220039.1765584-3-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260731220039.1765584-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ef2f71-e6a1-4097-e6a1-08def791933a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|5023799004|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nEZozH4DTomiiWgB3rLeono+2eoUCyXIUxaErHqzWE9IdIQgXqcmEQblQhTHHPA1XvOIZh8EfubH2cSpkxBD9SBjZhsTgI1ZrD/YhnA0te+Yk5GN6wrNV6LvRlkw7rJpaZU/AnrNl/7v/FBT8eqwQGDC6oG38X/EhzSxkHYtdYT8m7j2E5o/bsO99xOvisaXTwO+0M8giKFLxb3J/HtkHBtQF+cekQdoyn4ajRDmNVc3FAkXzL/BNGXpkPrul+jGpJn/R4z+a8OxKcxc8DBYX4mFMCu14kLHofkOQv3N2sRc+xFfCL0zbFYXXsN0BksDeKD8tjxyR48I1Xju/O5f2cKiaz1oU4kxzmlhwNTAUkgo8kL8d97/HyRpFAEFdsTC9CR5W5kkS43JQwZSZFskQ/jScn6s+ZHQlkFH21rhvPp7GnZRnE4xvzVdiAg/dVtpHzZ+YDJjrg3n/TPg2skRaWBXgWggvOvigWEWXKnz3uQhW2QEqNct2tHsvSZyWDnimv0lkOYzkwlzwC654IpqKkeZvW7YTNl+2JWgHSowbLd67sSpcoc2QyXJHDh1PTTPBVYefCe1YFLlAkiKQ69PzrhQb1ZOhl1tDAsCj74odGNDfpM+reCKCTRGUNWovcW5UJzkExHF6EydvyRzN9e4H5xvoQknTRn+zKrM1Fizxhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(5023799004)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QllCN1NpVUpCMnJySWNPQktNci83cWpEVmo2S3BYY0JBUHQrYXN0NjdsU2lY?=
 =?utf-8?B?bkN0RXVmL2xEUURpMjB0NDhBc2dFdUJzU1hLZ3NlRVRQVDdCUG4xK0Zmekxz?=
 =?utf-8?B?QzdiN2dVdDlvUWtHWGN0aVBEYk10UTJncFBGTjFNdlZwMCsxOXdCUUN0a3ox?=
 =?utf-8?B?TTQyNWVsNFJrTGlwcVBFTUJCL1ZDUFFjRVdRZDdSZS9majhyaTZudU5DOThw?=
 =?utf-8?B?NWZaUG5jNHhucFJ3d0ZSUGpSWDRuOStQaVZVUWd1d3daUVIvaHBwVXBVcjE5?=
 =?utf-8?B?SThvekl3WVBCU3A4dVQ2anYvZ0R1czZsOTVUcUh4dEdhbE8xdWlOMm94MHVZ?=
 =?utf-8?B?dGhMWVRQTWcyU2s5cWg5TFhlcGc5dExGWkNvZVMyd0d6RENpc2wzeGdWek9t?=
 =?utf-8?B?L2ZtYkJaZ3NMZTN6Y0IySVZpZzBFT0laT296cFhVWU45OWNuaTlaeHFyaHRq?=
 =?utf-8?B?UjBvdlJzNXRCTFdoRWJ3MW9kaHBya2pvZ1BBVmtJUytZTGlBbXJ1Q0NscFVT?=
 =?utf-8?B?bGE4a29ySXN2c21qYS9aTVpxaTlwTUFsWThFZGZxWjhOU0YzWU41anNOU0dV?=
 =?utf-8?B?ZDhYQnhCVVhEQThnT1crYkRWZHNBNnJyWFNhVGdrSmZESHhpN0JrOVl6QTFv?=
 =?utf-8?B?MVdndmJlcHdXTDVhbFZyaC8zSGdzMUN2YWo4b21ESm5Na2hvb2F0cG9EOGpU?=
 =?utf-8?B?NDQ2NEhBZEJmS3ByeStCMmhuMWtveVlRZlMzZE5WMjZlRkxKZmhjWTJINlVw?=
 =?utf-8?B?dkl3bXdRbXErTndZR0kvQkZBRkxOLzVralk2SEUzTGRxVEhJR1pjVEZNbjNv?=
 =?utf-8?B?SWROWDJGZkI0OE81NWU1cHA0cTk4TnR2ckFJaSt1OWh2OFdQOVorQmNOWDda?=
 =?utf-8?B?clpZbkEwYk40R2Q0UW9VYkFNMWlMZHV6akVSS3ZhczFlY0hIOUFDWnNQYjdT?=
 =?utf-8?B?aHZZbE5ZNzlvREg5T2JXVUt0dHF0Rkp5WDkwRWRRZUFHVGZqQjd0anROOHcv?=
 =?utf-8?B?R2FBYk4ydjFBTUhQT2JtQkN1MXdXY0d6S0RSU2pBVEM0Yjd2K1NlMWtnMUJx?=
 =?utf-8?B?bkhsNDN4NHdnMGlYT2ZWaHFRZjRKY0F0MnRBTHo0T2ZrenY4N1V3aUlqb2RZ?=
 =?utf-8?B?S3NRVm41R29Ka21wNVdHbkNtQ2RzalA4Q0xMeTcyclZnWHdyZnY2VkxyMlVy?=
 =?utf-8?B?Z01EckNsZGZ0Vkt1alJHVUNURGZhaXpwbVFqS3NLT3V3eWRncWJtUEVFMTFu?=
 =?utf-8?B?UDJPRnV3TmxINTQ4V1JQL0ViSkhTK3AzamNOdHFKVnBTUjVRNzlxMlRWWjFi?=
 =?utf-8?B?ZzlneXVMeDA3dW1sbkNzUUUxcXgwSnJKZjh1aDBJeEpjSGNDaCt2VUdRTEdl?=
 =?utf-8?B?d0dJMkF4aEVqbjNhU00zc0NHZloyRVpPWis5RjNObG9LcDNEYmswWXczamh4?=
 =?utf-8?B?L3NhVUJCMGVyd0RPSmhlaGptSThuNFNpYzQxQ1ByejN1Z2RCcVkvQVFaMEZY?=
 =?utf-8?B?R1AxbHRpcUQ5Tll1cHVjT2loUmxid1FEZlRmSjlBU0c4ekt1K1puamhjZ04w?=
 =?utf-8?B?OGo3RjBYQkZJL3lvZGRVY3NXWWEwdVNBaFRVbXZiY3BOZ3M3VEE2Uy9SL0p1?=
 =?utf-8?B?RUFueHBrQ3JxOXNLLzdRd2tLTDVVM0ZHRmJlakJHakVBbVNsbE9JcTgwWTlI?=
 =?utf-8?B?UmZ2R0tqT1FVN0JGdnZDLzVlb0VmMHNic3RteG8yUzFPeGIyemVXaXBUSlJz?=
 =?utf-8?B?Qjd1TGVQYUJRWWtvR3l2SzAzcUNIUWtLNlgzRXc4MEZKM2tSUlRKMkdaTk1P?=
 =?utf-8?B?T2N5WlZVNmpBczgyUlY2M2VmVllJdGFhWkV5RUQ3elhxZGFEMnRzZEd4LzBJ?=
 =?utf-8?B?ZE9KbGVuRVV6QzF3YytLRUJKajJ3ZkxJa1hEZGh2dGlERHpSUjN3dllrM005?=
 =?utf-8?B?aXE3ZHpVOGpodEtGcnl6WVRHZlI3aWhtSGVkcmJidytNYlVneFJCSU5VWlh3?=
 =?utf-8?B?VXk4aCtTWkt5enZEc0RmTFNYckdxNXl1andYcXZ5S2FCN2hQTm9QRDUrVXpV?=
 =?utf-8?B?MkFOa3V0VFJBUFZLejhNYVdpOFppU0dkNEIwSWZKNDlkSE00YU56Y2Z0OXBW?=
 =?utf-8?B?RUl0U0F0YmRzTk5TdVdyeWE2UkZ4RmRZeVlvakY4bWJkN0d0LzFKWlhIV1Jt?=
 =?utf-8?B?NXpMdFB3aU03cUVLSXZuTm8wUlMrZFpvS01kRFFMQ1pUOFdWS2x2cTBSaXR5?=
 =?utf-8?B?T0E2WEJXcDlVNWg5aE1MV2orc014SExKUWJJRnorcC9QTUwrZjl3ejAyeGVC?=
 =?utf-8?B?S0lFOEhyQjBDS296UDdiSFphZGNsangvVVB4MnRYcTZVNkZqdFNBSnEyY1FN?=
 =?utf-8?Q?mZfO+F1Bpo6hVPnM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ef2f71-e6a1-4097-e6a1-08def791933a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:16:14.7728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiYLd8QyoM3YwClqF5zj1FozUUcxnR8Gqz02CM7vtJp3EZtVAfiUSN/WO9h8BAEKcOjV396plfqDXlVCdfQQdHf6YYq1rENs0044nrUjZtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9612
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

On 8/1/26 1:00 AM, Denis V. Lunev wrote:
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
> repair fails rather than let writes alias live clusters. An inactive
> node is skipped: bdrv_activate() calls qcow2_do_open() again through
> qcow2_co_invalidate_cache().
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>  block/qcow2.c              | 14 ++++++++++++++
>  tests/qemu-iotests/039     | 24 ++++++++++++++++++++++++
>  tests/qemu-iotests/039.out | 17 +++++++++++++++++
>  3 files changed, 55 insertions(+)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 1543255eba..e660655a0d 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2147,8 +2147,22 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
>  
>  static void qcow2_reopen_commit_post(BDRVReopenState *state)
>  {
> +    BDRVQcow2State *s = state->bs->opaque;
> +
>      GRAPH_RDLOCK_GUARD_MAINLOOP();
>  
> +    if (bdrv_is_writable(state->bs) &&
> +        (s->incompatible_features & QCOW2_INCOMPAT_DIRTY)) {
> +        BdrvCheckResult result = {0};
> +        int ret;
> +
> +        ret = bdrv_check(state->bs, &result, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
> +        if (ret < 0 || result.check_errors) {
> +            qcow2_signal_corruption(state->bs, true, -1, -1,
> +                                    "Could not repair dirty image");
> +        }
> +    }
> +

This looks wrong.  What if we blockdev_reopen() a healthy image which is
already RW?  Say, we want to tweak L2 cache size.  Then we reopen
RW->RW, and yet with your patch we do full scan of metadata.  IIUC we're
being drained at this point -> we get guest IO stalled because of this
scan.

The subject says "... when it BECOMES writable".  But essentially we're
doing full check anytime it IS writable.  That's a completely different
thing.

Andrey

>      if (state->flags & BDRV_O_RDWR) {
>          Error *local_err = NULL;
>  
> diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> index a5be81bc4a..255dc2e7e5 100755
> --- a/tests/qemu-iotests/039
> +++ b/tests/qemu-iotests/039
> @@ -137,6 +137,30 @@ $QEMU_IO -c "write 0 512" "$TEST_IMG" | _filter_qemu_io
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
> +# The refcounts are only resolved when the node becomes writable. Without
> +# that, this write is allocated on top of the cluster at offset 0 and reading
> +# it back returns the data written here.
> +$QEMU_IO -r -c "reopen -w" \
> +            -c "write -P 0xb1 1M 512" \
> +            -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
> +
> +# The dirty bit must not be set
> +_qcow2_dump_header | grep incompatible_features
> +_check_test_img
> +
>  echo
>  echo "== Creating an image file with lazy_refcounts=off =="
>  
> diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
> index 3c71e5a3dd..62073916a9 100644
> --- a/tests/qemu-iotests/039.out
> +++ b/tests/qemu-iotests/039.out
> @@ -64,6 +64,23 @@ wrote 512/512 bytes at offset 0
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
>  == Creating an image file with lazy_refcounts=off ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0


