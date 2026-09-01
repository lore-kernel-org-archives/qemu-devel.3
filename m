Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26A8C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Og2-0000P3-SA; Tue, 01 Sep 2026 09:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Og1-0000O3-3U; Tue, 01 Sep 2026 09:37:25 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Ofz-0004KL-2b; Tue, 01 Sep 2026 09:37:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJ6uz84o51Hvw2fU3kS0PVRIYdaf1VpUQuQglx5Ckw46zfMBcxOZ1EJoof6dl+nUIep/hN0FQI5P4VhRkrpKAUuNbWKCHREEV+nvfS+e3dtPPhqL20ZzE4a2hOqk2t4ah+bInwR6xUKghLagSSVmsKjKTDVh3FOSd0v37nzpYuZTYAkKWp4SWQTKK/aoy3semUzfINuReRJyTaM77p9ztB9u7Jb2dvQ6h6NWzLHU6heyFkoHqFCzK9DkhwEmBmann99SF+JGYutJN4JoYd8ZJgwm7uoEJMFEl+PFOsz9vvA9HAKGskAGczo+x5gGIer+dvrxcuJhec6+z375JB4E/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dtI2lkrdE61rPZYoDI2PbE1dO/OFOGc5J+EpyO9L/c=;
 b=iQQcsYUk6If2PiZL1BtyLKjq8KFjOjcBAgqlshiQD/HqyONgvZh1sTOCsOZcnJPAk9kS+oI0xODWvXkq7xqjub7CH5sj8Oq9fIldx1Ylc3nfV/1J1MzbkPMOxzBxa7pFdG0zpyJhqq3hRPz/CF6Bj6R7wmSuVpB0Cz8svmmlyJySfWI8fQRGW7Pac8zmMLHOEVMWVYw7Cfdn1fmwGLJumkLUaVxS5VUgIkuJ+KfvTcaB5gH3qqPZOeHRlJnazsgWj9pq3m67XEHA3fFJrYYwU1dUl3HHaK0ojoh5wnow8GLzu0X/be7FjJE+J2Jmwv2N1qz5nHbniW8UO2Uby3abyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dtI2lkrdE61rPZYoDI2PbE1dO/OFOGc5J+EpyO9L/c=;
 b=OuNjRB1CBvpcJHEvsz8H4k6LV2d3gUWtUAVjex1iffz1xFRbroFGQoPZXYPFDM3xW+4TJabnc06Btpcnvx3VLm7mWEFNPbRzZeqd/2MivHuw2rxoePyMhjNrpDlvJaya3H/yxOV4UmmzW2ecixyqlLGn5+pQ4r4dWt3Fq8APHfyoDbisbKzX91Uj+8mg/99QpcDCZKrmnW+vFmigWGwqF9hKp9X0TDDbrRtj13iXX9Nivy3lDURiNWzNe7gqcs7236KnzcQorsUjcF2SPcsWXwqeyFXhgvmuwuTDqfeD+syyTmAwQmKn75NBbsufMZTJcqFls73n26IzYLcrFPMgJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by FRRPR08MB11965.eurprd08.prod.outlook.com
 (2603:10a6:d10:1cd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 13:37:12 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 13:37:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 8/9] block/backup: pre-fill zero_bitmap for full/bitmap
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260828144554.1741910-9-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
 <20260828144554.1741910-9-den@openvz.org>
Date: Tue, 01 Sep 2026 16:37:05 +0300
Message-Id: <178826982594.73810.5219790132256584070.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0114.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|FRRPR08MB11965:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c090d94-2fb7-4f0f-77be-08df082e20a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|23010399003|1800799024|366016|38350700014|6133799003|10067099003|4143699003|5023799004|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: CclnIZuRy7KTZPms03tcq7or+TnMGzdKDkGx9ZgXktZG11F5nSbok1H2XlMnwbMtgaZEyYL5vmClaa19Ft5likxOh8IpbGamYJt+RAJtxlrMvISXN7uLRHxjc+Cc/TCgLoA45FNrA7zX75HZdPXtdH/kc1wnGPkBXVBVZIP0ZMcGhY/lvqjZrWisQz8/5W83jopzPTOQUAgUpb3YvK5K4UvSOiSPoh4gFohf3u9GKIY+NHpMcrnDdqgwF/cce+gGMiHgV59VAuYHp9a512ebRd9XzbhHLZUa67HUiDmWMN3vL92cGpEZrCpxTJ+ZzA5HZZkvr8GBZ6C3KiS2Sx3wHOfT+bOticI8WWBFMkNB2We4ivZrlFBOdhdwNNK0kBD/i4fZjjS4gTXqBtt+ByOjiuxlBeANKk0QIilqC+lvgZUT7bMFT6dwhHVa56+cSHiKQzgUTrw17QKFk756PPDAydRbie1/frj2hPZVki71QZUrcqOJh/wHrzLQrIE2euMp/z18bwl6IKxJLIZfJshdCTBMUDEEKhDIiql3nZPaAtdYQ5p8gMJpgOFjZ8svXslj8SIbEb4zXK5ac5Mpm5OLc+lzUU4IrveQntuMfi0V5p+zbSeGYNeNlHKDcMNjRjskLG6VyJIM8wZsz6S/pyG5QR8mgyrP7gKaMD0Vs6i64kYqHjvuPEM210IQF8eYt4ftIhrH64FDRQKsuhhwh2lXQNdBoxbi3ZVhDlASdf53xx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(6133799003)(10067099003)(4143699003)(5023799004)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRaUTBWZ2JYYlF1V1ZONndLblFvbEtQMnpCbCsvZzZ4U2RWS2pYQlVHZjlp?=
 =?utf-8?B?T01nQVlGZ1h4WVNDYThpOG5kQmxCV1dQM1BmUk1kM2RrZ2xoa3ZJUW53Qy9X?=
 =?utf-8?B?WEFtdGpza0JKMHVRYm9IKzdLT1dzNVY4TlhSSWNIR3hlRW5ZTk1WWkVRSFZ6?=
 =?utf-8?B?Y3cvVlE0dllFTXRSNmF0VW5YTVZBQjlVUGUxbzU2TXdxZi8wTUU3VVAwOXFz?=
 =?utf-8?B?SzNJOVFFeVRkYS9tSFFjOUVxZjZSOTdPaWJXWDh2T1RZRFoyeDR4dkpMQ1Q2?=
 =?utf-8?B?Zkx4OE40cDFPdWp1cDZ6dktGRkR0Vk9JTFBpODlFb05nMjNwRU1DWmRseHlr?=
 =?utf-8?B?NFF3UzZlUzhHNmZtcEUrYnhoV1dvaU0xa3NpL1d3VEE0TEFvWUdGZHh5eDhO?=
 =?utf-8?B?TkNYYlNoUUxOdDlxQm9PY0N6Y3lHa0RXb2hXbkpYWEhpWU9yRTVycjMycnFq?=
 =?utf-8?B?RDlDQzRnc3hCeWlzdFU4RGc5K0trQnl6eVlEU3NUVXA4MHBZdUpDNExWV2tm?=
 =?utf-8?B?K3hkZVZuUzV3WDZwUVRFeVQrSTNkZ2pOREhKOWNza1V4WktWWnFXVVJOdFNv?=
 =?utf-8?B?bTRaUkRUMk1CS1I2ZGZrMHlRVU4rNnlxRGFMd21rOWdzckRiUVdwT25yOWFU?=
 =?utf-8?B?RExxTnI3azZBSGVVVFFGY2dPY21QckVxZXJESE80TWl0Z2pKUnptTFBpdW95?=
 =?utf-8?B?SHBCYUV3K2RleUt0SUxoN1dONjJCWmlNekg3RDVaTlZCVXYzaXZLUzBWQ2Vj?=
 =?utf-8?B?amZUWHBxS0xmWVE0Qk54RDVmMDdZcnNGSFhYRjIzQlE3Snhib29Ua2FWSUJp?=
 =?utf-8?B?RDEwZUJtUFBMYzlhdkJRWnhYem1IdGpWU1RkNUF2TUhTK1FqRGYyVDhuNEtT?=
 =?utf-8?B?bHZCNmhZenBpYVZXU0JMVjFud1U2SU5PZlVqcVR1eTFYSkxtR3RHZERtWWtp?=
 =?utf-8?B?K3J2NTJPdTVKNjhjVmwrTXprcmd6SDlqZkJBcWk0UGVYUllVTmZya0ZQck9R?=
 =?utf-8?B?MXVFdE5VbmdYTnNwRTVoUTdDRXNFdXVNL2ZRVTZGRENwTWlRSkpNdkNiWWlK?=
 =?utf-8?B?VVJHMElCNmFHdDhiMEVUeEcvRm5GWUZkd050cXQxbzJnTFhpcUFHakl1a1Y1?=
 =?utf-8?B?VldYRnQwMjdQTmE5K1ZsYVQ3ODlUcWpzK2l3QTRGcGtsR1V5K1YzYVJ3ZGhO?=
 =?utf-8?B?STNxQy9RL0xHYWZxQWF3NVRKcjVMQmNUdlpDWDYwRUpBaXNRamhHUnlQTlpJ?=
 =?utf-8?B?dEhKSmIxRlVqT3Jlb1hqTGtyUzBJNmlzdGVscUNTcmRaUjRGeS84U25jdk5B?=
 =?utf-8?B?T1JFaGJUbktiTlljbTJMWlQ5L3AzbVJFekI2Z1lka1JqbmgzQnRTdXdMMUs0?=
 =?utf-8?B?SmVnOGJ1RnVaTDhKaVZOd09iUWt4bnl2V3pjc2VTZE1WeFZLK3FYOTVqMXJy?=
 =?utf-8?B?Y0lYdVhLSnRBM1ExVGNvVGZnR1MvQmIwaEVTSUJ3MFYzUFNWeklsdWx4U0JT?=
 =?utf-8?B?VFg4YUFWRXBjWEVpdE92bCtCVEt4anh2Z0U2Vldyb3RjK3VaYkFUdEJYSGRO?=
 =?utf-8?B?aEt2UjRsZFJ6QllSMmRZRFpnMldTZlVNdjNDL0VQR1JzR0NHMEt4dk9VcVln?=
 =?utf-8?B?Q3pJdlRwTTVFdERnWW13OXRoek9xdENKR2poTHJDc3ZZWkhPRDRaVEtENVZK?=
 =?utf-8?B?blVRL1FHZSs5Vjl3RzRyMFBvTkVkUUtvQlJkaG1WYkZzZ2d4Z3VpdTBLaHhQ?=
 =?utf-8?B?WVRQeWlOdnFON05NY1J5cVBqbFZsODV2ZHVaM1lPUzZyRWhJMllHdEM4NFFW?=
 =?utf-8?B?ZVc2eGxtRERNYVZwZEt6M1lRSHhodkEvUmZBQXR2azlyQ1lJQUlLakhQYjRQ?=
 =?utf-8?B?K2svV3BEN1doc0dzNllvZllKTnBPZk9iY2hsamlTOGlxRzNSbzJKN1hwQlQz?=
 =?utf-8?B?aWlNVnVRc0ZWQjk3OEptMDNrTjV0ZUxHN09uOHFjMk1GT2k3NXI3L291WFE0?=
 =?utf-8?B?L2xqL1JpVjFUWFFRcHJvUGNLdEcyNUpGZ1JSRmphd1ZLa3ZqRENjNlBZL2sz?=
 =?utf-8?B?TndDVE05RUVURjNobUNmcU9xWkRrek40Znp0bjZ3cE5kTGtMaytsUmpraGVy?=
 =?utf-8?B?R1hxZ0ZFdlhiUlJISldWejFCUkErWU9LdkkrbUFjR1E5cEc2NkZPNkxmZCs0?=
 =?utf-8?B?TmpmV2xpS3FEUnVtM21tSGEzV3ZDT21uKzltVkhHbnlGZWpmVnVkd25oQm52?=
 =?utf-8?B?UWl5eWYxYXB2RXAza0ltejliU0drby9oT1E0N28wS0x5N3cxcG92NmwxT2hq?=
 =?utf-8?B?NlB5NU11KzkrV2FuODlYaDgrTFpRZ2NvZVJTNmQ1YVpBekFlbHlwODUyOHRy?=
 =?utf-8?Q?znoIiW4zyzG6ne7s=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c090d94-2fb7-4f0f-77be-08df082e20a5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:37:12.3295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrKOYOwrw9D+F3j3nsXBUkDIIQf9krmPaRyT3wzMhz4qUibTcjpyRSVwF28maXK7eORmg219R8e3nbsGhDZZH+wsDkWl49A2WEkEtXHIwQs=
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

> Only sync=top runs an up-front scan, so the previous patch did nothing
> for the other modes. FULL and BITMAP know their complete copy_bitmap
> before copying starts, and the same copy-before-write guarantee holds:
> a cluster still dirty when the copy loop reaches it has not been written
> since the scan.
> 
> Add block_copy_calculate_zero_bitmap(), driven one query at a time from
> backup_scan_source() so the graph rdlock and the pause point are taken
> per query, and query each confirmed span once however many dirty areas
> it covers. The scan only fills zero_bitmap and never clears copy_bitmap,
> so sync=full still writes zeroes for clusters the source never
> allocated; it just stops re-querying to find that out. Unlike the
> per-task queries it replaces the scan is serial, so a sparsely dirtied
> job against a slow source may spend more time here than it saves. The
> sync=top loop had the same shape, so both fold into
> backup_scan_source().
> 
> sync=none keeps the per-task query. Its bitmap says "anything may be
> copied", not "this will be copied", and it only ever copies what the
> guest writes during the fleecing window, so scanning the whole image at
> attach is the wrong trade.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/block/backup.c b/block/backup.c
> index 11d70243e24..b6e559a97e9 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -247,59 +247,85 @@ static void backup_init_bcs_bitmap(BackupBlockJob *job)
>      job_progress_set_remaining(&job->common.job, estimate);
>  }
>  
> -static int coroutine_fn backup_run(Job *job, Error **errp)
> +/*
> + * Walk the source before copying starts: fill zero_bitmap and, for sync=top,
> + * drop the clusters that are not allocated above the backing.
> + */
> +static int coroutine_fn backup_scan_source(BackupBlockJob *s)
>  {
> -    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
> -    int ret;
> -
> -    backup_init_bcs_bitmap(s);
> -
> -    if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
> -        int64_t offset = 0;
> -        int64_t count;
> +    Job *job = &s->common.job;
> +    bool top = s->sync_mode == MIRROR_SYNC_MODE_TOP;
> +    int64_t offset, cached_end = 0, count;
> +    int ret = 0;
>  
> -        for (offset = 0; offset < s->len; ) {
> -            if (job_is_cancelled(job)) {
> -                return -ECANCELED;
> -            }
> +    for (offset = 0; offset < s->len; offset += count) {
> +        if (job_is_cancelled(job)) {
> +            return -ECANCELED;
> +        }
>  
> -            job_pause_point(job);
> +        job_pause_point(job);
>  
> -            if (job_is_cancelled(job)) {
> -                return -ECANCELED;
> -            }
> +        if (job_is_cancelled(job)) {
> +            return -ECANCELED;
> +        }
>  
> -            /* rdlock protects the subsequent call to bdrv_is_allocated() */
> -            bdrv_graph_co_rdlock();
> +        /* rdlock protects the block-status queries below */
> +        bdrv_graph_co_rdlock();
> +        if (top) {
>              ret = block_copy_reset_unallocated(s->bcs, offset, &count);
> -            bdrv_graph_co_rdunlock();
> -            if (ret < 0) {
> -                return ret;
> -            }
> +        } else {
> +            block_copy_calculate_zero_bitmap(s->bcs, offset, &cached_end,
> +                                             &count);
> +        }
> +        bdrv_graph_co_rdunlock();
>  
> -            offset += count;
> +        if (ret < 0) {
> +            return ret;
>          }
> +    }
> +
> +    if (top) {
>          block_copy_set_skip_unallocated(s->bcs, false);
> -        block_copy_set_zero_bitmap_valid(s->bcs);
>      }
> +    block_copy_set_zero_bitmap_valid(s->bcs);
>  
> -    if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
> +    return 0;
> +}
> +
> +static int coroutine_fn backup_run(Job *job, Error **errp)
> +{
> +    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
> +    int ret;
> +
> +    backup_init_bcs_bitmap(s);
> +
> +    switch (s->sync_mode) {
> +    case MIRROR_SYNC_MODE_TOP:
> +    case MIRROR_SYNC_MODE_FULL:
> +    case MIRROR_SYNC_MODE_BITMAP:
> +        ret = backup_scan_source(s);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        break;
> +
> +    case MIRROR_SYNC_MODE_NONE:
>          /*
>           * All bits are set in bcs bitmap to allow any cluster to be copied.
> -         * This does not actually require them to be copied.
> +         * This does not actually require them to be copied. Yield until the
> +         * job is cancelled and let the before_write notify callback service
> +         * CoW requests.
>           */
>          while (!job_is_cancelled(job)) {
> -            /*
> -             * Yield until the job is cancelled.  We just let our before_write
> -             * notify callback service CoW requests.
> -             */
>              job_yield(job);
>          }
> -    } else {
> -        return backup_loop(s);
> +        return 0;
> +
> +    default:
> +        break;

The only mode left is MIRROR_SYNC_MODE_INCREMENTAL, and we can't get
here with this mode: it's asserted away in backup_job_create().  So how
about g_assert_not_reached() in the default case?

With that applied:

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

