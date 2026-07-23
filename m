Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C56C531D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmu1E-0004sg-MT; Thu, 23 Jul 2026 10:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wmu0y-0004CU-Pr; Thu, 23 Jul 2026 10:03:15 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wmu0q-00046j-CD; Thu, 23 Jul 2026 10:03:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qL9QORdth9KZOQgI788Ru7AuEWXu0XzK4a8U+TvfDiXyaZIWCfCKYtZH8D9Zt9gruj7k+PRmgHeUHusaEUcTmXYAJlssE4+jXXH1wTYelnNTekL6VxgQGXit4x/VngRZs0L+nOUjCigTw8aL4WkytmF8I7mRrYTQxT+T04Dq0DDa2+uD9JgAtPc78W1vWyZohmOSvtFIVsjGuXc58Or3WkB7KRcJWiw9RaE1AuzH7lXHXH1evEOSOU+l0OtObD6cIBT9grG5gdZqXdin+knAWoq04xCwamFzVKf7LPoHYtwGUbwZ+lhexM5t+Tcra7y5zhJaXpZQCbV1Vfj0SQXh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEFOi+znxHUkK425dDvHM6ysXDlWwbrc8o1lUmgQCwc=;
 b=jtCT/Jt35u5sen5iOMUWwQp7ezeIAWM28AH/tZJNleM6GSus1Z+jxaMTBTYA7MlHCUDZ5miHfsOfOukQlEyZlYfOBEwLi8aqHeDIfe8qZJBYT7JQeBZ4JcMiDdoV/tskp1GQ6k9KkhHPNu6Q2THsB1d8wrWo3xfC7s94tUB27tJGhqfSH2p8PycfkQc7Qy6e89Dxi4DIwXGjTKD6xN+8esGynjVJB3fo5tuje6SWqogY8ADk8+FVcva5h8D8VwYH4/CUimwKnq31N+tVMKaCo3yDqBJKper3iQeSa/InGKHTjiJ9JEzMA7/JpVxokQUKpu49M6NFbSGGk8N7NlwOIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEFOi+znxHUkK425dDvHM6ysXDlWwbrc8o1lUmgQCwc=;
 b=xxRZoPzB0DAjVHXvwZlHsOxWBLZEZZUvYD+htFzr13EXNH6J3Fk/cdCEmZFhdORYNgMmIn5jTFPEWcp5ScgT9Elnbuy+fGlNuo72dkCXmyekyCadxswQXqnp8G8oZfVE4GPFpgnxz5W6VaMBFEsZ+7nBge5XSBptSWA1xNO+aUkq9WWuofCA6YFDy9IW5AS6h6xBEkgvJVg2O8doqb3APYZMzTNCRkdJR1V6AnJzWsxQ+KKpTxQ4tsSqNou3BTnDLvs2SBDXFt4rbKRUeyXDtzx+ZB9QFNlja3MsnXka5D9w2VrQ3u3lMJefeCBiNXRdSUQZ2QH+TleEUyU7bo/Aug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DBAPR08MB5720.eurprd08.prod.outlook.com
 (2603:10a6:10:1a1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 14:02:55 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 14:02:55 +0000
Message-ID: <18128b57-da00-4cc0-98fa-642d372b4a5b@virtuozzo.com>
Date: Thu, 23 Jul 2026 17:02:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block/qapi: take stats->lock when reading
 BlockAcctStats for query-blockstats
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260723123745.3294227-1-den@openvz.org>
 <20260723123745.3294227-3-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260723123745.3294227-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DBAPR08MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: e7922545-37ea-47ab-4cf4-08dee8c317d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ZerthrJ9WNlmphn2SdYzIaAC/4Z1OOkIi/xPy/DVIyNPC22urqyjOdHxqe34aab4YUQ6Bcdc5NMkozLQXPcV5kdqE+0yNOwm75vOKacO1Lbq7u1nj9cmpMG3y42KI8xzwwQhS3DMyHC6AkbySpqNdIFko5w0hQJKRLcH/ElCdqzcpdLCYh3e0lovjXkDouOp1ygvhSbJzKAVB7l97DR2UYsV335TrOJzK5vM/Aplzc0RBdekXehEUaOJGYr/rViy3RPh4ivnXegL6gIKAmWvrYRIvbhdI10scQCJqjJghAP9bxl55TJsTEcknUPNWWbXiur5NCIIMxVPb3tL81ti58+f8/vDG3OpfmWaxnj8DYiCpn8QgyDSI5lxNG7A/NOmOK0WBXWt670x9Hmtm10WuYbChhVdabqisEH9Ncsy3nhHB5yx34sRrDLn75ot3s8pW1HKtSKbHx0H7UwT98U8qw2/ryHcYfU7JHKy/c59OurI39mmolJZjo0tv8OQLBaDQMI+DvZLSQh7krCsD7UWETjjQ9DbQ/mP+D69Nf1G42KlHZIBc7pg280+FhGN7y3ERSQqRJ992F1CPSLsQHCDwuaezmdUttZjwDf14ruo7FoHHHUMNsXcuUkouh9JWGwuCNG/Am3K7B6U9ozCUylNVBuOROHIWxbaxSVVAzdHJfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEtGZlVRcVloTU0rV1QrMzkxWjdobCtaaVRGQUVrTnFucDI4ajNSY2g2ZDZi?=
 =?utf-8?B?THowSzJhbTdIdVByVjF6R2o5SFBPM3dmdUN4VzNieHFTSSt1a2pHaWorelov?=
 =?utf-8?B?cG1pOHo1WjVmYnR3cWo2UWFuMWNLUjVsa09SUTJCMDNpTVZVR1dmSUdOYUdq?=
 =?utf-8?B?U1czQXREZ0tQeStGS3JDamxLL0Q5QWs3N2Nya09TcVFEZFlwVG50OUs3OVVP?=
 =?utf-8?B?UU5xRjZ1UEprOXVzemtBdHZsa2lPU3J4dEk3MEltVDVyTXBjL3FJK2FrL2or?=
 =?utf-8?B?Qks3WXdsV1VWYUFrRlBsZGxGeFAyaHU4OXhONnByT1VLQXFxR0lvL05pVnFz?=
 =?utf-8?B?MzRBTzVVNWFZVjlhTFI1di9KbjN1b20xUHR1UXBzbUFxdDAxZHhuanZvUTM3?=
 =?utf-8?B?YUd1aE95NmQySDQxQjJWTUxhWnEwenM2S3dBSHk5ODJJc2ZETFU5OU9xNG40?=
 =?utf-8?B?RUVCN2hJYnludGxudVIwWktlTnZWZGJ0aEZDQmZnZVA2OGZBWTNyZldmcDdl?=
 =?utf-8?B?R1p0YjJGYmdsNzF2ZWYzeUt6VUlIUlRyb08rQTI4TlJMZ1VDcDVPODhoQnlh?=
 =?utf-8?B?UUdRSTBOU1BvSHg4N2c0R2h6WkJjeEZzaCtGZVZEdlJZcHpDeFJNdldBS2JH?=
 =?utf-8?B?ZFFpNmsxMGdCWjgvRzlmdElzNUN3RVRMKzA1OHMzRUdzYUx1TnJUVlM5MENk?=
 =?utf-8?B?UHF6U1k2Z3o4WnVQU0hkYTlBaDdPQ3NMenlCeG9pYzMvZ3p0MjFyVFZmeXZh?=
 =?utf-8?B?UzJTNVNwc2p1VEJWOTk2ZlRPVDVoTkVUcUlPOHJUKzJLVmtxdkFibzVXY0l4?=
 =?utf-8?B?b01mVG5RSHc5dXcxaTJYd3lUbFQ3cWMrTmFzOFpNdTljTHV3enJpajFEWjg2?=
 =?utf-8?B?OUVoaHE5MlpwakVoSHBvWENjUVM2SlhSN1g4R2FJd1dLVnRhNlBMcTRna0c0?=
 =?utf-8?B?dmpIMVE1SG8yQ1d5Sm1zUS8yRmlqbCtOZFRRM3BzM0FvYjQ4TW5FVHRSVzJL?=
 =?utf-8?B?am1EampUZy9mSG5JTUhYMml3N0xJQXoxeTlncFhWL3pBUFYyL0YvQUdaMXZs?=
 =?utf-8?B?MmJSTGxFaGxYNnBxTU1EUXJtd3B0Q05TUlllcWFYOXBMNEYrRXN0ekFHSExk?=
 =?utf-8?B?dGVYYW04dmQ0eTczMzFXNnpDU1dWUlVKSFVDWHo4Q3libU9sL2J2cFk3ZmFL?=
 =?utf-8?B?emVsR3FtSFROQ3BlQUpwV1E0YjJaQ0pJdkYrNUxZNFhFMkxZRVF2Q3d1aG00?=
 =?utf-8?B?cjJDckJZZzBHN2UyakxzcStGQy9QV3ROMWU0YWxta3Y5NzVGV1FsZFJXQ09L?=
 =?utf-8?B?b1BrS2RuWWgyaVRhM0NNa1JISU1CRFBhL1dJaGErRHZhQ2lJMmdkWmxWVzJ4?=
 =?utf-8?B?azNPSVd5ODhhRysvTHB2bFpqczl1OC9samVDQVdSdzVtY01hTm8rSkxMaGhU?=
 =?utf-8?B?b2UwdTZqZnJOeEcreVExMU1WdFBRdms0R21hcTNBVDhlT2xpWDZMK09tNU9N?=
 =?utf-8?B?dFRKRGVZMEF3bGgwcm52VTJFc1ZNQURXR1I3Unhwem8xT1pvMDQ2SEorQXEy?=
 =?utf-8?B?TjBLdmhhQU9yYSswamtZSXVuMVBzTTVnOXY0UitiaWNya3FNSklXcTBEMjJ3?=
 =?utf-8?B?NTBMc2NxeUFOcXNlcm9LdmdQbmhESFJBVzVNT2JZaDZkNDdVSFRpM3VBR3Nk?=
 =?utf-8?B?V3hCcDhXb1QzZHkrR2FZSlI0alQ4dlZlMkJ4Z2k0R3lWT1RYMXRzZk5wR2lX?=
 =?utf-8?B?dGUrM2swbkxIK1FralY3a1poT2NFQkFQNmZjblVkakIySXNHOWxWZElkcjdI?=
 =?utf-8?B?cDZFTmFaQm1Tb0JKM21Id0RhOStqeHl6WmlQSEE3SmVQekZheU5GQ252c2Rw?=
 =?utf-8?B?QmF5Qnlxek4xUXp6cXAwWWhZOTlaSFkrM3lWcmxrNXZ0bWtGRFYwM0xLcjZr?=
 =?utf-8?B?N3BmbHJkV2xmWkRHUUMySnFVVXczNGRKeUxTMk1qdnJud2hITTU3NmhsMTRu?=
 =?utf-8?B?RlJRQXhiQVB5Z3Q1Yis1NVpROURmOGNqNWxkanQyUlhVMlVsemZaYjNjUlAy?=
 =?utf-8?B?MUJmYjhHQlhxcEtNWVVpbDlvY2EwdnFUZlpHWGpaKzlhZXh3UmJKRW9IVlJC?=
 =?utf-8?B?S0V3TmorakcrMWtIdGtaVks0L3NCTEp2RkpiSk56Tjl3bFNzalJnaGxZYUI5?=
 =?utf-8?B?UFpuaWhwZDNSU1cwRlZYc1hnQUU5MHYwUVFvWEp2ZFNrdFp4ZjdQcWlRdjVx?=
 =?utf-8?B?R1l6MThGOWVnTWJxTFNIVnRHMVJjZ21GcU9HenRqOCt0dWxxV1c1bWYrZGph?=
 =?utf-8?B?Y0RWM3JWTi84R3ozUGNJZU5FSVZuZzg1eGU3bjgxN0hoV2l5Q2QyeGM3VjVS?=
 =?utf-8?Q?NlMB033dLCHr6F1Q=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7922545-37ea-47ab-4cf4-08dee8c317d1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 14:02:55.0753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9pt5vaIZJoQdYhbDyw0DBqXwBLabfzM4MlV7HmP7ydj6E+uY+t6NUlKFAOLDrBp+nyXRynPPGjDlKUOp2aagWbMmeUZgpAHGLgz7J9BWKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5720
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

On 7/23/26 3:37 PM, Denis V. Lunev wrote:
> bdrv_query_blk_stats() reads nr_bytes[], nr_ops[], failed_ops[],
> invalid_ops[], merged[], total_time_ns[], last_access_time_ns, and
> the latency histogram bins directly off BlockAcctStats, without
> taking stats->lock. block_account_one_io() updates the same fields
> under that lock from whatever iothread completes the I/O, so this is
> an unsynchronized read of concurrently-updated state.
> 
> This is a narrower issue than the one fixed for the histogram
> setters. query-blockstats and block-latency-histogram-set are both
> plain (non-allow-oob) QMP commands, so they always run serialized on
> the monitor thread and can never execute concurrently with each
> other.
> 
> Take stats->lock around the read for consistency.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  block/qapi.c | 102 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 60 insertions(+), 42 deletions(-)
> 
> diff --git a/block/qapi.c b/block/qapi.c
> index eabfbfc258..c3f20832b7 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -535,49 +535,67 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
>      BlockAcctTimedStats *ts = NULL;
>      BlockLatencyHistogram *hgram;
>  
> -    ds->rd_bytes = stats->nr_bytes[BLOCK_ACCT_READ];
> -    ds->wr_bytes = stats->nr_bytes[BLOCK_ACCT_WRITE];
> -    ds->zone_append_bytes = stats->nr_bytes[BLOCK_ACCT_ZONE_APPEND];
> -    ds->unmap_bytes = stats->nr_bytes[BLOCK_ACCT_UNMAP];
> -    ds->rd_operations = stats->nr_ops[BLOCK_ACCT_READ];
> -    ds->wr_operations = stats->nr_ops[BLOCK_ACCT_WRITE];
> -    ds->zone_append_operations = stats->nr_ops[BLOCK_ACCT_ZONE_APPEND];
> -    ds->unmap_operations = stats->nr_ops[BLOCK_ACCT_UNMAP];
> -
> -    ds->failed_rd_operations = stats->failed_ops[BLOCK_ACCT_READ];
> -    ds->failed_wr_operations = stats->failed_ops[BLOCK_ACCT_WRITE];
> -    ds->failed_zone_append_operations =
> -        stats->failed_ops[BLOCK_ACCT_ZONE_APPEND];
> -    ds->failed_flush_operations = stats->failed_ops[BLOCK_ACCT_FLUSH];
> -    ds->failed_unmap_operations = stats->failed_ops[BLOCK_ACCT_UNMAP];
> -
> -    ds->invalid_rd_operations = stats->invalid_ops[BLOCK_ACCT_READ];
> -    ds->invalid_wr_operations = stats->invalid_ops[BLOCK_ACCT_WRITE];
> -    ds->invalid_zone_append_operations =
> -        stats->invalid_ops[BLOCK_ACCT_ZONE_APPEND];
> -    ds->invalid_flush_operations =
> -        stats->invalid_ops[BLOCK_ACCT_FLUSH];
> -    ds->invalid_unmap_operations = stats->invalid_ops[BLOCK_ACCT_UNMAP];
> -
> -    ds->rd_merged = stats->merged[BLOCK_ACCT_READ];
> -    ds->wr_merged = stats->merged[BLOCK_ACCT_WRITE];
> -    ds->zone_append_merged = stats->merged[BLOCK_ACCT_ZONE_APPEND];
> -    ds->unmap_merged = stats->merged[BLOCK_ACCT_UNMAP];
> -    ds->flush_operations = stats->nr_ops[BLOCK_ACCT_FLUSH];
> -    ds->wr_total_time_ns = stats->total_time_ns[BLOCK_ACCT_WRITE];
> -    ds->zone_append_total_time_ns =
> -        stats->total_time_ns[BLOCK_ACCT_ZONE_APPEND];
> -    ds->rd_total_time_ns = stats->total_time_ns[BLOCK_ACCT_READ];
> -    ds->flush_total_time_ns = stats->total_time_ns[BLOCK_ACCT_FLUSH];
> -    ds->unmap_total_time_ns = stats->total_time_ns[BLOCK_ACCT_UNMAP];
> -
> -    ds->has_idle_time_ns = stats->last_access_time_ns > 0;
> -    if (ds->has_idle_time_ns) {
> -        ds->idle_time_ns = block_acct_idle_time_ns(stats);
> -    }
> +    /*
> +     * nr_bytes[] etc. are mutated under stats->lock by block_account_one_io()
> +     * from an iothread, and latency_histogram[].{nbins,boundaries,bins} can
> +     * be freed and reallocated by a concurrent block_latency_histogram_set()
> +     * on the monitor thread, so every read here needs the same lock.
> +     */
> +    WITH_QEMU_LOCK_GUARD(&stats->lock) {
> +        ds->rd_bytes = stats->nr_bytes[BLOCK_ACCT_READ];
> +        ds->wr_bytes = stats->nr_bytes[BLOCK_ACCT_WRITE];
> +        ds->zone_append_bytes = stats->nr_bytes[BLOCK_ACCT_ZONE_APPEND];
> +        ds->unmap_bytes = stats->nr_bytes[BLOCK_ACCT_UNMAP];
> +        ds->rd_operations = stats->nr_ops[BLOCK_ACCT_READ];
> +        ds->wr_operations = stats->nr_ops[BLOCK_ACCT_WRITE];
> +        ds->zone_append_operations = stats->nr_ops[BLOCK_ACCT_ZONE_APPEND];
> +        ds->unmap_operations = stats->nr_ops[BLOCK_ACCT_UNMAP];
> +
> +        ds->failed_rd_operations = stats->failed_ops[BLOCK_ACCT_READ];
> +        ds->failed_wr_operations = stats->failed_ops[BLOCK_ACCT_WRITE];
> +        ds->failed_zone_append_operations =
> +            stats->failed_ops[BLOCK_ACCT_ZONE_APPEND];
> +        ds->failed_flush_operations = stats->failed_ops[BLOCK_ACCT_FLUSH];
> +        ds->failed_unmap_operations = stats->failed_ops[BLOCK_ACCT_UNMAP];
> +
> +        ds->invalid_rd_operations = stats->invalid_ops[BLOCK_ACCT_READ];
> +        ds->invalid_wr_operations = stats->invalid_ops[BLOCK_ACCT_WRITE];
> +        ds->invalid_zone_append_operations =
> +            stats->invalid_ops[BLOCK_ACCT_ZONE_APPEND];
> +        ds->invalid_flush_operations =
> +            stats->invalid_ops[BLOCK_ACCT_FLUSH];
> +        ds->invalid_unmap_operations = stats->invalid_ops[BLOCK_ACCT_UNMAP];
> +
> +        ds->rd_merged = stats->merged[BLOCK_ACCT_READ];
> +        ds->wr_merged = stats->merged[BLOCK_ACCT_WRITE];
> +        ds->zone_append_merged = stats->merged[BLOCK_ACCT_ZONE_APPEND];
> +        ds->unmap_merged = stats->merged[BLOCK_ACCT_UNMAP];
> +        ds->flush_operations = stats->nr_ops[BLOCK_ACCT_FLUSH];
> +        ds->wr_total_time_ns = stats->total_time_ns[BLOCK_ACCT_WRITE];
> +        ds->zone_append_total_time_ns =
> +            stats->total_time_ns[BLOCK_ACCT_ZONE_APPEND];
> +        ds->rd_total_time_ns = stats->total_time_ns[BLOCK_ACCT_READ];
> +        ds->flush_total_time_ns = stats->total_time_ns[BLOCK_ACCT_FLUSH];
> +        ds->unmap_total_time_ns = stats->total_time_ns[BLOCK_ACCT_UNMAP];
> +
> +        ds->has_idle_time_ns = stats->last_access_time_ns > 0;
> +        if (ds->has_idle_time_ns) {
> +            ds->idle_time_ns = block_acct_idle_time_ns(stats);
> +        }
>  
> -    ds->account_invalid = stats->account_invalid;
> -    ds->account_failed = stats->account_failed;
> +        ds->account_invalid = stats->account_invalid;
> +        ds->account_failed = stats->account_failed;
> +
> +        hgram = stats->latency_histogram;
> +        ds->rd_latency_histogram
> +            = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_READ]);
> +        ds->wr_latency_histogram
> +            = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_WRITE]);
> +        ds->zone_append_latency_histogram
> +            = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_ZONE_APPEND]);
> +        ds->flush_latency_histogram
> +            = bdrv_latency_histogram_stats(&hgram[BLOCK_ACCT_FLUSH]);
> +    }

Smth is off with this hunk.  These calls to
bdrv_latency_histogram_stats() pre-exist below (after the while loop).
If they need to be protected by the lock as well, we should remove those
duplicating calls below.

>  
>      while ((ts = block_acct_interval_next(stats, ts))) {
>          BlockDeviceTimedStats *dev_stats = g_malloc0(sizeof(*dev_stats));

Also in the while loop we call timed_average_{min,max,avg} with no
locks, whereas block_account_one_io() does update the intervals under
the lock.  Shouldn't we move the while loop itself under the lock guard?

Andrey

