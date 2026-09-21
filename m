Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754EAC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 19:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8jsH-0000A3-6e; Mon, 21 Sep 2026 15:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x8jsA-000062-Bn; Mon, 21 Sep 2026 15:40:18 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x8js8-0000Of-6a; Mon, 21 Sep 2026 15:40:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npK3H3KA3cKjpGlJp5JADTkfavIfglZQLOBhenvyLtzJW7ZTjZgAx8sGy7tcvDEGktjjUgkI/kWAoX9f81y+V901GtVVrSqgdyzBjE/ukNvzwEKSv7fMEMyxAAK0cx5eVeqbD+S0Lh6yc64zfTQhkL7FBjeRO8mGGIp6+rELcJOGlMkr/0Q2mcMwh8pbiNP8YBwlEH9cTHBfamb6JWpsohaajOx0dcB4p+2YkOidBSnLDm98VCfmjoJBOe40HYC7Lkk/Wpk8cj1IC9OvevchOXc4Xunsgrs/9QHOuPX+SxPO9dy4ppsE+8e33SEOqNTM0NOVKGECTVCq1qGndO5LMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ckEs0vr99ceo9SyyQzWFbidRXvzYea1IXBZZpBfpL4=;
 b=LQloT2jTYoTQxeYZcUWeX2YoVGoAXH46+z+jjp9J8CbdGrAjfYrmHXPemkHYobzJOWS7F08d6C7GCx9U0r3nVpGQ/CAKe/mdm7VxOt/J4TY/jwTcCCw3es7n6yrQBDW5Pm+UclGNtk8v5d9larp7A6Gg3DS9R51VApIaI9FwLHijJ0hr/zqyPMCYHZJoqLjXW545ektVxMqwIbSrviSEfJb9grY/eoTDKOYKCQfpllMNR0pzunQ7VJtyn3+46gYTfbNxzJ/V9y+N+e8fLHyQjVpMJlszosjzLhErT7lS77DAhDXwBTaiMCAzZLcARVZYL4X/K8Sg45FeKdxqgiKvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ckEs0vr99ceo9SyyQzWFbidRXvzYea1IXBZZpBfpL4=;
 b=PHWCW1xTnPLfJce7DsksFEA6dW3fnYC54blo4SALrPZpKRSsCruTcwyCwdCXYWOzOI0m1s9FdL27F4qT1wpqJXREY1TY3CnJRVYRJka6w1WOowPxPql1b7CdnY48rPiaYekXWz0vNWoqJQYYNlbsnFCXOrz838y/LbIUhy0B+9nmOzTrXAN1lb3B7bVnTXAiKZLNSYBkAqW0CO9MZxqnfvIFTsVuucs0sKmrN0JWhQqFPShtXYmfoOUz2p8NGkQAW6fzCw+rWrCm/kay8Lf+LT63Ms/LMtYeE14oKhR2gtLAuERGMSvKiRt+G8EIrFIVoVZu0FFiPqinMXdriC4P/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Mon, 21 Sep
 2026 19:40:11 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0451.012; Mon, 21 Sep 2026
 19:40:11 +0000
Message-ID: <02bdc4a4-c9bc-4f20-87e8-df4c116321db@virtuozzo.com>
Date: Mon, 21 Sep 2026 21:40:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix bdrv_next() skipping monitor-owned nodes
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260828222005.2888213-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260828222005.2888213-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::37) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9eee10-b757-4929-8905-08df18182570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|23010399003|5023799004|56012099006|10067099003|6133799003|18002099003|22082099003|18056099003;
X-Microsoft-Antispam-Message-Info: oQCiAYDt9fTxnp1qjDEeOCfQf7jhJS1PKMDIZ03CW3dgm942cwFam99GRCYztR2O/kmf9rAZBx55g4gNOiwQcxhTOYZJMXkeLIglH+mCYlQIxhG/0k5evyUTtNTXinQlQulBEqOdIr+vBzY/zyKqRp7KqtZY4R3XdCSF/kO9Sl28g4EcY9YABad8x0l7lOeThSlePHQ0yQqd3jjNMc5jpjN283DaZHcJ+lBuNptEgLOirG2hGSj46+Wtq/tc5O43D+8FZmeXxWLKHqzZ0RWypsM2TIYvHSrPN5DyVy//UnRFefyKWXDJgtDYgLsdcTK0bOb11oX9oaFIsQ2XD0a/PfSx4w4yK/D7e5Ib8yU3hGJuFh8wHH3cKMwzCP1mGD5lZjzwDYINzFHyVBrTPbZyBdtFQG7QuW8zVimXDk1YTHjkahx7YLwcRESW8HumuD7F03y4JqmXapTcrNpPR1Q3RkedAjBmHujGGN5dC4vT41ZHSAV5D4jgB7cggbf9PINUd2qJbQwfaAFpkTQRMJszgmoQgQORxn16gVZyH8aXgV308PmQJ8vMFd+q0arR3Mm2TV57M9waNOA8luK2hKH/7XNdRklv8KQ/biNg9jWGSpeeLTXWizTDFNvkea0PFQ9ABlc7JiJ1i/tZefMdgXw2Y8znYIOZpzkwjaZel77DICk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(5023799004)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(18056099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGZxYThwVHdXTHZONVk1KzBHMk5McGN4N0piKzgzNXRHcWF6R1hKV1hSYmN2?=
 =?utf-8?B?UVA2bFA0SVBaTWc3TlZpQVdNUkVTa29QZ0RCYnhmeU91MkwxVFRMUkQ4d3NW?=
 =?utf-8?B?Z0l0eU0zRXJsdURIb1JnaEozdCt1VGJRam1aSHZXM1R1dzFTbE4zRGhQeXh0?=
 =?utf-8?B?dktLNkJyOVJkem5tTW81SzBwQzU0TmRJYUpmZlAxQUxVYkhidTliU3hLOG8z?=
 =?utf-8?B?Zlg3blNWdmFPczNZNmd4eEV5VUphRVFBcVRHNjViU09PNE83OExVaUNkQ201?=
 =?utf-8?B?U3dNSjRjeVFaUUlGd3JKbzgySmlsU2pXOUlKck0vL3l4eldjWE1Zc2VUaHlR?=
 =?utf-8?B?OEJyazRpa2lWYm96MVdUczlMY1Y2b0llcVNwOXI2dUJCOEtJVjJZOVhRb2pV?=
 =?utf-8?B?ZXpFN3JVYVZnb2dWL0ZNUnR4M1lpUVFQa05PMjhQSW1UeENvUVYvT0tPZkd6?=
 =?utf-8?B?VlhFME53dVYzYTI4cVRqaGVxaitHZVJTcm01L0RPYnhVWjNrQTdtSk9mUUFo?=
 =?utf-8?B?TXBIclJiQ0J2NHFxU3lmU1IvZURycDZzaUJkck5mSUZtbWZ0U1QvM3RudDZZ?=
 =?utf-8?B?UDR4RjY0NXFyeG9KdS9KWGVEUEhoR3FmYlFjc0o0UkFocTZCMXhQeEF3Nm81?=
 =?utf-8?B?TVNKVGJ3Uno3UENLQWZOMi9xdUZRbUhaRVJYMTZ5aVFHbThwODJ1MTVoQ0NB?=
 =?utf-8?B?Tkx6Ymt4U1pUS090dzRHTURidkFxQUxLcFE2aXZweGhyc0ZlVjQ4Skx3M0NQ?=
 =?utf-8?B?Uk9BZFZrVEJJQ0FGZnRsaXk4RVVVaCthTEtqczdKa0xkaEpiTExKaG82TndI?=
 =?utf-8?B?SmIwbXZVWkgxbElaSDdMdjZ1NGkzQUpBVGQyQTVCVFBjUVQyUGFhNVYvSTFs?=
 =?utf-8?B?RWdVVmp3L3RTVW9FU0RiTFRiUTJLVU1WSDVOTWF1ZzJCWVh3UDRXKzBsdzE2?=
 =?utf-8?B?aFNtQXRpTFU5QXYrMEVwVzdlYXIwRjR1Z1REeXhBbENGWkpNcVNYb3pobDNa?=
 =?utf-8?B?N05GN2dGdFBzekJYWjUxbzNYS0hjeWd2YnIrSEJrTkFqWjBJRmhZS1E0L3Rk?=
 =?utf-8?B?YTFrK2tHMDQ5WUtyRjlaSDdidXd4bGZ3VnhNaFg0TDMvY1B0WFBLYllpTkh1?=
 =?utf-8?B?dTdBSk1mU3FaV2pEdG0xUjBWYmdWUTBDQkphdHJ2YXliaUd3eFdSODdHZlVK?=
 =?utf-8?B?MXVhK1phRUh3N3RDZ0JhY3NiMVdLUXJwV3pkODkvK01RZWhvRzNXcEtyUjVL?=
 =?utf-8?B?MVBLQ1VSVzZmV2xxMGFUTFJFTWQ1aTRGeWdDcjlzbTNSNkdhVFJBaGkyMXF3?=
 =?utf-8?B?a0xtTUgzcE1QT2s1WFQzcWdkd3dSQ1J2TGlLb3lLREFteWl1dGJFV0ZpVVpH?=
 =?utf-8?B?bHlSU25iUVlwTXI4R2V3MTlsVHlXeitXLzF6ZDcydUYrZmNYVnNwelM0Tkc0?=
 =?utf-8?B?VDMwMDlOMFI1ZEEwdWxrckw0N25DeUhPalBmblRyWXI0ZzlPWVN5b2dnM2NQ?=
 =?utf-8?B?bkFFTXUvd1hnMGp6S1h6UmUwQkRyZjRGbms0MG5GYjhhbXduZEVyNTdhekxx?=
 =?utf-8?B?MC8wWVJIOWt5cVdTZ2pieE1VMjUyQlQ1cXpsbWMzcFU2VUwvYW50OEtUNERj?=
 =?utf-8?B?MndvWU1XQjhsVzFzb2pWcms4MTF2citja3p3Rjc5Lys0cUxwemJpc3dTL1By?=
 =?utf-8?B?TnVzTUtNN1hMQ2ZJOTFjMm1UemRZWmlITEhFZHVIamt5Um90d0t3eWVoT3dQ?=
 =?utf-8?B?SzE3QUtkRlhGRUJuWDFIU2hJUk50RTBONUNIdnNmM1RTcXBaQWhoVzdWTktO?=
 =?utf-8?B?WDY1RXdYZEN3MWtZMFF5ZDU1U2g1b3R1YWZ3UXZwSGFQeHJPR2tiWlN4WERW?=
 =?utf-8?B?NVhKTFZsK3FSMDExTW1FdUk0d0RhMHdxWEtwUlNublFwS1pDekxxeDErTGt1?=
 =?utf-8?B?dDhGcUI2QkpGaXRjWVgvTWpWSitQOUtNYkV0Q1puSWNUeUxheDRMQitpMnJn?=
 =?utf-8?B?M2ZpRHo2VW5PMThyNXIvMWxLUkswYk52V20vOWs4MGVWT1NZNGpKRWZzUXlq?=
 =?utf-8?B?cTlXRVVoS3ZvLzh6dEdENVVLMHE2NWN3d2FMT2dFWWdYalJvanZmNXhDOVdV?=
 =?utf-8?B?Nzg1eHc4SHhaNUZPNUhqYitsQ1dsa3BhTzMzUkxJR2szREtpMmFSd0VKVDVs?=
 =?utf-8?B?RXZrYUpMMmQzb095UEpGQ1JQZlhaNHNQM2N3N1NUdi85RUVhWTZMeURaVHRr?=
 =?utf-8?B?NmNkTDkyb1ErM2pjQWRSM2tTUHhKQ1o1L1U3N2FRR1hOTG51RFN6V2o3eXJh?=
 =?utf-8?B?RDNFckYxRU1nN2RLUGRZVEw4aDJMbGdLSnZkeWhqbUFMSUpNamRxclROQi9K?=
 =?utf-8?Q?HkVz1akA5H8xIY+YuqhWEGHVMFwZGJjiawZbtgAT6q1GG?=
X-MS-Exchange-AntiSpam-MessageData-1: dnHAxbe1Pejv3g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9eee10-b757-4929-8905-08df18182570
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:40:11.4025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrY3Z8/1E7zEUc1YGpiUMSjD0nTINjxlV4m6wS7sMw8K98c9l2yVEcWy1s+1rErkgT2McitvfJx2ji06V2uvvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
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

On 8/29/26 00:20, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> From: Denis V. Lunev <den@openvz.org>
>
> it->bs is the cursor into monitor_bdrv_states for the second phase of
> bdrv_next(), so it has to be NULL when that phase starts. Commit
> f6d38c9f6d made the first phase store the node it returns there, to
> unreference the right one when the graph changes underneath. The cursor
> is now left pointing at the last BlockBackend root, so the second phase
> resumes from there instead of from the head of the list and never
> returns a node added before it.
>
> A skipped node drops out of the vm_stop and migration handover paths:
> not flushed, not inactivated, not snapshotted. bdrv_inactivate_all()
> still reports success, so the node keeps its image lock and the
> migration target cannot open the image. Only detached nodes are hit in
> practice, as these callers also recurse into children.
>
> Reset the cursor when the second phase starts. old_bs is taken at the
> top of the function, so f6d38c9f6d keeps working.
>
> Fixes: f6d38c9f6d ("block-backend: fix edge case in bdrv_next() where BDS associated to BB changes")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Fiona Ebner <f.ebner@proxmox.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> ---
>
> Notes:
>     The iterator was correct from its introduction in 2016 until 2024:
>     it->bs was written only by the second phase, and the node to unreference
>     came from the BlockBackend instead.
>
>     f6d38c9f6d's own reproducer does not fire for me, 240 runs across 8
>     timings, even with its fix reverted. Tried hard.
>
>  block/block-backend.c                          |  1 +
>  tests/qemu-iotests/tests/inactive-node-nbd     | 16 ++++++++++++++++
>  tests/qemu-iotests/tests/inactive-node-nbd.out |  8 ++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 37ba7e9fc4..55497c4551 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -625,6 +625,7 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it)
>              return bs;
>          }
>          it->phase = BDRV_NEXT_MONITOR_OWNED;
> +        it->bs = NULL;
>      }
>  
>      /* Then return the monitor-owned BDSes without a BB attached. Ignore all
> diff --git a/tests/qemu-iotests/tests/inactive-node-nbd b/tests/qemu-iotests/tests/inactive-node-nbd
> index 664157bfd0..ef876ae6be 100755
> --- a/tests/qemu-iotests/tests/inactive-node-nbd
> +++ b/tests/qemu-iotests/tests/inactive-node-nbd
> @@ -47,6 +47,7 @@ def node_is_active(_vm, node_name):
>      return node['active']
>  
>  with iotests.FilePath('disk.img') as path, \
> +     iotests.FilePath('detached.img') as detached_path, \
>       iotests.FilePath('snap.qcow2') as snap_path, \
>       iotests.FilePath('snap2.qcow2') as snap2_path, \
>       iotests.FilePath('target.img') as target_path, \
> @@ -58,6 +59,7 @@ with iotests.FilePath('disk.img') as path, \
>      iotests.log('Preparing disk...')
>      iotests.qemu_img_create('-f', iotests.imgfmt, path, img_size)
>      iotests.qemu_img_create('-f', iotests.imgfmt, target_path, img_size)
> +    iotests.qemu_img_create('-f', iotests.imgfmt, detached_path, img_size)
>  
>      iotests.qemu_img_create('-f', 'qcow2', '-b', path, '-F', iotests.imgfmt,
>                              snap_path)
> @@ -68,6 +70,9 @@ with iotests.FilePath('disk.img') as path, \
>      vm.add_blockdev(f'file,node-name=disk-file,filename={path}')
>      vm.add_blockdev(f'{iotests.imgfmt},file=disk-file,node-name=disk-fmt,'
>                       'active=off')
> +    vm.add_blockdev(f'file,node-name=detached-file,filename={detached_path}')
> +    vm.add_blockdev(f'{iotests.imgfmt},file=detached-file,'
> +                     'node-name=detached-fmt')
>      vm.add_blockdev(f'file,node-name=target-file,filename={target_path}')
>      vm.add_blockdev(f'{iotests.imgfmt},file=target-file,node-name=target-fmt')
>      vm.add_blockdev(f'file,node-name=snap-file,filename={snap_path}')
> @@ -297,6 +302,17 @@ with iotests.FilePath('disk.img') as path, \
>      iotests.log('snap2-fmt active: %s' % node_is_active(vm, 'snap2-fmt'))
>      iotests.log('target-fmt active: %s' % node_is_active(vm, 'target-fmt'))
>  
> +    iotests.log('\n=== Inactivating all nodes at once ===')
> +
> +    # detached-fmt has no parent and no BlockBackend, so nothing can reach it
> +    # by recursion. It is only inactivated if bdrv_next() actually returns it.
> +    vm.qmp_log('stop')
> +    vm.qmp_log('blockdev-set-active', active=False)
> +
> +    iotests.log('detached-fmt active: %s' % node_is_active(vm, 'detached-fmt'))
> +    iotests.log('detached-file active: %s'
> +                % node_is_active(vm, 'detached-file'))
> +
>      iotests.log('\nShutting down...')
>      vm.shutdown()
>      log = vm.get_log()
> diff --git a/tests/qemu-iotests/tests/inactive-node-nbd.out b/tests/qemu-iotests/tests/inactive-node-nbd.out
> index a458b4fc05..48451dc0c5 100644
> --- a/tests/qemu-iotests/tests/inactive-node-nbd.out
> +++ b/tests/qemu-iotests/tests/inactive-node-nbd.out
> @@ -235,5 +235,13 @@ snap-fmt active: True
>  snap2-fmt active: True
>  target-fmt active: True
>  
> +=== Inactivating all nodes at once ===
> +{"execute": "stop", "arguments": {}}
> +{"return": {}}
> +{"execute": "blockdev-set-active", "arguments": {"active": false}}
> +{"return": {}}
> +detached-fmt active: False
> +detached-file active: False
> +
>  Shutting down...
>  
ping

