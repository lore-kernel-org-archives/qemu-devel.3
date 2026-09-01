Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C60C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Og2-0000Ox-9h; Tue, 01 Sep 2026 09:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Og0-0000Nt-OP; Tue, 01 Sep 2026 09:37:24 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Ofy-0004If-0R; Tue, 01 Sep 2026 09:37:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdG29pz/OqwsCAUtld3ad9MZ2XYQaEMqaYxNydPmPQdddWQeWfzHN6w+fUhws55x/tssRrOmEhRoCMlsCbtBrfcY+6MGmzAhAMSOcKdnjgkuVpdwdAQmNndXkGftK/KCaUuHZ8Xx4PMi8vVsTEXtEa6ynKJx3u8FWq1q4Tr5rKYwy8XLtwbQXCl3gHxLBgJy//X0t3WhCfhmqRxS5CQ60UjlGmjFe2t3ShrfZI79RDyae1rjmSr74hxwiQ7H29EgXjl1wcMXNf3K/+sDl/+nV255MBvQpy8HEvel6nqtugO31ae2W3DQA5I7iQXYNzmCaKtDKsDmxKgR5TzKYIPg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkmiP9XfKS6hFeoX6spYUOKTgyhsECHrI2Wr/EwE6ZY=;
 b=A8PWNlYPxjAOYI0A3QyUjBlZZPOYCxSngTiyA6BafK0NK12n8cL7nRGY6Ni8PhZahPco8VrF1wOJY8UPbXBD0kbznVyS+7tajIiF9O0CN7gVNUxYcmtlLcRkNIJ7qe+E/QQhyOvzMld1BMNW7nsuV/BWbjwglOg8TY1ZlybukA+WhMLgWTis8+QLYOZc7+ryC9jx/jLhSq1WrUgxxwQ+uFYOf9aU8J/Gp0s8u9ZDlySF+zTb4mThYJqDw68R4keuij90MtcI7dgx4PZvC9sOFZttPJV/yGUV2QzsAnOJJHzAXILy25BtVwtN2GSWQC/UMH47AHribxuy/3A0piprjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkmiP9XfKS6hFeoX6spYUOKTgyhsECHrI2Wr/EwE6ZY=;
 b=A46JbC4Y9rY/i+xDuiGx0ScbYHUIx6InS1ooMwkVguQqOcCAqWHtzPm8xRLyCzSz4YMgAZ4dOMVODmHOc1LgGA2wjne9TtE6X4JCk2B/hez8P/ePhUG3r3oPlUwuZRQrgrIcOI+v+jeB9OiYMwUlRtEjKu0XnSVZX+mdRbN2mS3gde24ymNgsbqPQdq39hn8JnQy86bk4vPJL0unOXoKNBqNVgyXmHggyoHr53ipLKH2O7cqScz0ztGEZoDSpsBXFCvlxl8L6esjB7P7J1jRQkVyk3sepVMEhe5ThAL6kQ9tbpxKTsmzRHoLjBtp006rXZEztwLk7KkADmjnQYeQ0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by FRRPR08MB11965.eurprd08.prod.outlook.com
 (2603:10a6:d10:1cd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 13:37:11 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 13:37:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 7/9] block/block-copy: track known-zero source clusters
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260828144554.1741910-8-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
 <20260828144554.1741910-8-den@openvz.org>
Date: Tue, 01 Sep 2026 16:37:05 +0300
Message-Id: <178826982594.73810.4225192708153339814.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0114.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|FRRPR08MB11965:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3bf8f3-05ab-42cb-aa25-08df082e203c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|23010399003|1800799024|366016|38350700014|6133799003|10067099003|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: xlg4vRgVkwh/eCcu5/hJXKsKOtw71B5vLgheW7jrmbSO1QUYSNWb3zVPa/9TVh/G1HYC+8u4aETnMX2tyqXixEavOxwfLjXRWML3sGKtVKiRc/UKQ/a2qVCYLgeq/XGs0VZyCDO/LmVV5CmXYkkYYZ41QnLw9DKFjJXyuweDu0iR8Ai7ZnGchqsAexHOpD1rRwt29oUE84NC36EiNrLYu80Veh5wrnar7wYgrb+Q6vRG6w6SvmoIiXbEDtjiRomVXnCFy60Q5b19IdhnuXRQPmRbKiklaMBv2fLgTMnUjzusqj/pwoagY7pfx3R1I+TNCy47tHwAQphh3dCAZspvR51GGHy5xgHcT0uwVVpFHCgiukYm7/Avke0Oijfu544r3sFopZ5c5zRPKInKRpMXHRPeYdd5w9S2Ih00VnwP9TwRrqmBXuRbUsw9Da7m3pR7osTRH2SBskQaer+WUXGUdX6z53Ys9czrJ+EhBvplioAUYliHqw/zWT/9dU2vBxwGhm3Y5XqcvUyWGkdFelwaGCIv12iwY8+nYNhSyiBaUOZIdiRDU68B2SJtcsAXYilUVTzSuh3bP5cLEjSR5SjCaw7D/+joUHhgC1M5ypcjJcXqGyVcDyS2tWSyPUbgXb5A/dtu0aruVN8OX+Gf8h18586hfK2rAGtnMI2CA/qZNJorZmCdc6NMb0T5CufmHGapQIB+LSzd+IAntTnO46TARuYt2nJn1mpqg2Q2U84QLPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(6133799003)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmZTanl4YUU3WGgwY2VlWmpuRkNRTWlqWGpZN2ZCckJwU1RIb20zZWZuOVBn?=
 =?utf-8?B?a0pLRDFMVWhVSTJNZzhYeHorRnlCME9aYjVPZzFGL3NkOVYrVkYrdlJuUTNz?=
 =?utf-8?B?QzljRXdHaGR6b1AvUTZSNzNuTnVxNmFTblUxdERoZUY2TU02TDVNcVdkUWdE?=
 =?utf-8?B?cHhaSEl2Mm5jeFd2emp4NGFmRmJDbTZudlJWeE9jN0oydzlOQ3VMbkNUdGd5?=
 =?utf-8?B?L3FUMnlGUWcvVEl4eS9FK3hSNEdhTGtQcmJUUXlDNWtVZms5TldvOHZNS2Zk?=
 =?utf-8?B?S0piaGZHNWFoV05sZFFsaXlOczYyVTdLRjFxNVBHR2ZXY0RmNlEyUjNhbXBK?=
 =?utf-8?B?OFBNSUh1Y0tCMzBtRDRQT3l6Z1dCT3pMU0RVL2FOVE8zKzdqanQ3ekRENnZH?=
 =?utf-8?B?SWVaeFZVeENrOVpWSjZVM285czJ5VDJ2MCtGVVdKenpIZFJQb2NZMkpaSXpy?=
 =?utf-8?B?WkV0YTM1aCtObFVaQWhUMzJXWnd3ZmErNEJvSFVBY011ZEl6UTdoQzlnTEQ4?=
 =?utf-8?B?ZnZtT0wrblRvVlpTYXdYSzVqQjFnSTZiaUVaVTFUMFhLUTBHdS9MdU1ERmll?=
 =?utf-8?B?RjdnR2RsT21UanRxS0ZiS0N6UmZZcEZsTk5GL0ZkZFdZTHRscE5RVEJqUWxZ?=
 =?utf-8?B?TFZwdTlwU2xIaHBQNSt4cEJ3OGJFL3ZpUUFBMlJnT1Y2NHpBSzJ4U3A5WGJx?=
 =?utf-8?B?ZzllMldRWGQ1S1JxSGVQS2pidUNOTElSNWJobndZbmNMNU9tc2dYNHNFSmNW?=
 =?utf-8?B?MHNaYkF1VndaNzhEYnpTZ3NSb0hOSUdDN3cyc1AzN1kreWRNbzliYWw0Zk9O?=
 =?utf-8?B?bmh0VFNPenlpZ2J6a0VJY3NrVzFTVlBWOHZLUzVYRTh0YnRpTVlaZ09XdlVC?=
 =?utf-8?B?ZnFmYlozL2Nab0wxbm55R1UyMVhOTnZnalhqUDJzUGdsWFdsdXp3RjBsdUdX?=
 =?utf-8?B?ajF0Z3YyTU80MmFTdklZQTR3WkplMmpsOGsvQmxOQzczWFk3WUhBYlFyQWNl?=
 =?utf-8?B?enNQNWdSeHg3K1dlNU9zei8wdkxMMTVHK1ZVZkhJREVOaEJEcGtuRytkTHJz?=
 =?utf-8?B?a2NsZW1jVDhJQXFzR0FKQS9ublFNK2FoT2JBUWdpQkxjSU5sdVh5amh1ejNl?=
 =?utf-8?B?SHFuN0drRXVWNlozRFlYdlVXSGw0TUNaZzdDNzg2S2tzNmpHYVhzWHhkWVJV?=
 =?utf-8?B?V3A2Q2hRWTdrc3dwc0xDQUkrVDliU3ROL09rd1hCTHlmL0JUZFVkLzF2OEZI?=
 =?utf-8?B?Zk1ZUHExZ1hJVGdnM3VSQ2dURXVtTzAyUDlpK1ZrRFFzbGsxZmE1WlRuTWx2?=
 =?utf-8?B?VTlzNHpUeDlzVGM5cW9vVjQ1bXhFMDlDUVlRSTRBUDVBVTE5UXFMRDJ5Tjcv?=
 =?utf-8?B?MitBM2tuSzZYRUszd1JiZ1U3Zk5qVEdVQ0p6enZ2dGlYcGU2aDNmazEwd1Jh?=
 =?utf-8?B?ZVdhVXpNQThYY29ENzUrejVzOVpTaHZGWjdLclRIY0JjLzFsQXl2Yno3U3Ez?=
 =?utf-8?B?em9qNC9SZ1NkSmd6QkZ5eE45blRMVW95b2o4bkZpaWRGM1Jhc0QwbWhoTkJ2?=
 =?utf-8?B?eHJrVS9UeFlJakV0RklsTkp3NmJwYmJEVStpdms0NXd0YkpTcjdZVTFhSGZr?=
 =?utf-8?B?VXV6aEd2WlE3RGlSNm1Zd0EvQWZzSTZmZXhRU0M2U05iSlJvcmhOY3hCQUNp?=
 =?utf-8?B?amk5Z2w3ellwTEg0THFlNlB2eGRCS2oyMVBWUHViSlBOWTVzekZsbWN2QnJK?=
 =?utf-8?B?cC9kejVkaDVrWGxyVllwWVBTWTBaN1lxRmxXOWRiaFZmZ0JON2lBNjcrQ2lx?=
 =?utf-8?B?SzNsRFFwNzUrN0piNnZZem5PZVEwc2QxcFVkL01uSGVpTXlBYndGUzRLS0t4?=
 =?utf-8?B?TnNLYmJXblpjTEFWYlQ2TVA5ZVVienJ2ZzlSeHZZRDRXL2t2MHRNb00rZ3V1?=
 =?utf-8?B?RGIzc3lVZ2lxVFFFSTRrazBUdENwUU0wNGRubTkzRUp3bjBCWXRDUk0wTXVJ?=
 =?utf-8?B?UGR4T0tFeEdsMVVCMXhQaXNIdm1QalMyL3dJQjN1ajl4bmo3SUl0UG14OUw3?=
 =?utf-8?B?WWZDTFBaZXVXeDV0TUtOMXBNd3oyalM2TGhuM0pkRldxd1ZDN21oSHBHcWQ4?=
 =?utf-8?B?WlAvdzZaRWo2bHhYYTFqbTBjWU9sNzkxdkNJUEV4dHJGOW5LbXJ2eDAyV1V1?=
 =?utf-8?B?T0dsaWUrcTZWdHNCYzQxcEFVVjZ0anZ1UVhxTENGSEhEb2xXNFBDWEN0YmZt?=
 =?utf-8?B?RkszTzh5dXE0ZGhIOVIzRzdhUm1hS3BPQXJGV2xSUGRoZHhOSGl5aFBPSUNK?=
 =?utf-8?B?bHV1b1hRUjc4OHlFODNONGJwbDQ4VXJ4NlcxeFlNc1JBMFArYjYyaGpYM2Fj?=
 =?utf-8?Q?ZEni0+K6+6ZcXDCc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3bf8f3-05ab-42cb-aa25-08df082e203c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:37:11.3654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mc9o9VsMIPq4IcZKgo9iyvCI5l20LJkF8tJspwGELre7vZwQjZeTXMsKN+JFdpK9jBKSG0HfVZG2nlkUXU41rAlBVrnsfxE24AhtGgMPsbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR08MB11965
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

> block_copy_reset_unallocated()'s up-front scan already queries the
> source, and the same query reports zero-ness. The copy loop re-queries
> per task and, having no answer up front, can only size a task by the
> copy buffer, so a mostly-zero image is cut into thousands of pieces
> that each turn out to read as zero.
> 
> Cache the answer in zero_bitmap, published by zero_bitmap_valid once
> the scan is done. block_copy_task_create() then picks the method from
> the bitmap and ends the task where the answer changes, so a zero task
> never reaches into data and a copy task never swallows a zero run. The
> per-task query stays as the fallback until the flag is set, since CBW
> intercepts guest writes while the scan is still running.
> 
> The scan and the query it replaces must resolve BDRV_BLOCK_ZERO against
> the same part of the chain, so the scan moves from bdrv_co_is_allocated()
> to bdrv_co_block_status_above() and the base selection is factored out
> into block_copy_status_base().
> 
> zero_bitmap is a plain HBitmap, not a BdrvDirtyBitmap: an internal cache
> has no business in query-named-block-nodes. One writer and readers gated
> by the flag need no mutex, but the publish needs ordering, hence
> store-release and load-acquire. It is allocated on demand, so sync=none
> and a standalone copy-before-write filter do not pay for it.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/block/backup.c b/block/backup.c
> index d4713fa1cd4..11d70243e24 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -280,6 +280,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
>              offset += count;
>          }
>          block_copy_set_skip_unallocated(s->bcs, false);
> +        block_copy_set_zero_bitmap_valid(s->bcs);
>      }
>  
>      if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
> diff --git a/block/block-copy.c b/block/block-copy.c
> index d71d070dbd0..94d4f3dd69a 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -20,6 +20,8 @@
>  #include "block/block_int-io.h"
>  #include "block/dirty-bitmap.h"
>  #include "block/reqlist.h"
> +#include "qemu/hbitmap.h"
> +#include "qemu/host-utils.h"
>  #include "system/block-backend.h"
>  #include "qemu/units.h"
>  #include "qemu/co-shared-resource.h"
> @@ -157,6 +159,10 @@ typedef struct BlockCopyState {
>      bool skip_unallocated; /* atomic */
>      /* State fields that use a thread-safe API */
>      BdrvDirtyBitmap *copy_bitmap;
> +    /* Clusters reading as zero; allocated on demand, frozen once valid. */
> +    HBitmap *zero_bitmap;
> +    /* Published only after the scan, with skip_unallocated already false. */
> +    bool zero_bitmap_valid; /* atomic, store-release/load-acquire */
>      ProgressMeter *progress;
>      SharedResource *mem;
>      RateLimit rate_limit;
> @@ -190,6 +196,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
>                         int64_t offset, int64_t bytes)
>  {
>      BlockCopyTask *task;
> +    BlockCopyMethod method;
>      int64_t max_chunk;
>  
>      QEMU_LOCK_GUARD(&s->lock);
> @@ -201,6 +208,27 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
>          return NULL;
>      }
>  
> +    method = s->method;
> +
> +    /*
> +     * The scan already knows how this range reads: pick the method here and
> +     * stop the task where the answer changes.
> +     */
> +    if (qatomic_load_acquire(&s->zero_bitmap_valid)) {
> +        int64_t boundary;
> +
> +        if (hbitmap_get(s->zero_bitmap, offset)) {
> +            method = COPY_WRITE_ZEROES;
> +            boundary = hbitmap_next_zero(s->zero_bitmap, offset, bytes);
> +        } else {
> +            boundary = hbitmap_next_dirty(s->zero_bitmap, offset, bytes);
> +        }
> +
> +        if (boundary >= 0) {
> +            bytes = boundary - offset;
> +        }
> +    }
> +
>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>      bytes = QEMU_ALIGN_UP(bytes, s->cluster_size);
>  
> @@ -215,7 +243,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
>          .task.func = block_copy_task_entry,
>          .s = s,
>          .call_state = call_state,
> -        .method = s->method,
> +        .method = method,
>      };
>      reqlist_init_req(&s->reqs, &task->req, offset, bytes);
>  
> @@ -271,6 +299,9 @@ void block_copy_state_free(BlockCopyState *s)
>  
>      ratelimit_destroy(&s->rate_limit);
>      bdrv_release_dirty_bitmap(s->copy_bitmap);
> +    if (s->zero_bitmap) {
> +        hbitmap_free(s->zero_bitmap);
> +    }
>      shres_destroy(s->mem);
>      g_free(s);
>  }
> @@ -624,20 +655,24 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
>      return ret;
>  }
>  
> +/* The scan and the per-task query must resolve BDRV_BLOCK_ZERO alike. */
> +static GRAPH_RDLOCK BlockDriverState *block_copy_status_base(BlockCopyState *s)
> +{
> +    if (qatomic_read(&s->skip_unallocated)) {
> +        return bdrv_backing_chain_next(s->source->bs);
> +    }
> +
> +    return NULL;
> +}
> +
>  static coroutine_fn GRAPH_RDLOCK
>  int block_copy_block_status(BlockCopyState *s, int64_t offset, int64_t bytes,
>                              int64_t *pnum)
>  {
>      int64_t num;
> -    BlockDriverState *base;
> +    BlockDriverState *base = block_copy_status_base(s);
>      int ret;
>  
> -    if (qatomic_read(&s->skip_unallocated)) {
> -        base = bdrv_backing_chain_next(s->source->bs);
> -    } else {
> -        base = NULL;
> -    }
> -
>      ret = bdrv_co_block_status_above(s->source->bs, base, offset, bytes, &num,
>                                       NULL, NULL);
>      if (ret < 0 || num < s->cluster_size) {
> @@ -657,16 +692,41 @@ int block_copy_block_status(BlockCopyState *s, int64_t offset, int64_t bytes,
>      return ret;
>  }
>  
> +/* Only the scan allocates, and it runs before zero_bitmap_valid. */
> +static HBitmap *block_copy_zero_bitmap(BlockCopyState *s)
> +{
> +    if (!s->zero_bitmap) {
> +        s->zero_bitmap = hbitmap_alloc(s->len, ctz32(s->cluster_size));

Hmm why it's ctz32() when cluster_size is int64_t ? Is this intentional
or an oversight?

Andrey

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

