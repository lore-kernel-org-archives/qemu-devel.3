Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59781CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfxt-0007yR-Ly; Fri, 02 Oct 2026 12:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCfx2-0007hm-1P; Fri, 02 Oct 2026 12:17:36 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCfx0-0004zx-Cx; Fri, 02 Oct 2026 12:17:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVfswX4VAXbD/NT9XCERp8J6+IU9bBMbaEbHEmsasopUxeN2ROgvfEEc3Hta1BzJiB0KgRGZWpLGDj6TGroKVQeQIo25A6UD/1pRBAF2xe7uIGev/4ZB+lS60o91yr1RJDH2FeOcExAJrfoOOr5Oeg+bmrPSiWTL9Bh4N5y78jZPvz6aBHm3CmxkDhl4mbITBXqVTnpeFXsk3b15g1D/rOxI1YHLTc2+Sm+Hp7KY5Bq/B7XKODgyxVjTkytv0zl2Zove9SUfKFsVdezzvedCgzCAaQ51aLuWmewOErcdgiVOii9ukDlTFSk60gezB/qD7xfXhowpIbsWqg5vV/lgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYmaH7wd7eiPNhrBr1sDufSw0bisYvoO9OEfRNZW/2s=;
 b=Mc9TeABce5kMRdl/IKNvSY0brL5nxfi0Ygwzv/ctgoHx1Dzy8bh7xkvlmmfDt84Zg0WMVc5Fv0IZ0tuafQ0EN9f9szrRNz9F9XHKeMVAh4Gey4IPN8N+DOYdHPBaU3HtTFvfcjvttXS/2h3rnCdx5zPJSf8/Zs1gIjV78lEBUarpBEhxtdjxi49YnyCIrwUSqEviaOA/ZhL7zljPwiqdaXN3srma19oZuTUahKcJ3aMucJmMY20XX68X6JvZaohCo8EMJBqgV+M2WK2TkWLJ2u2qk8bq/GLIk86jHa5YqLzf+C3buWbEYFp7s74Tm3fRubLLQSQr+G9H25KMRH8qZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYmaH7wd7eiPNhrBr1sDufSw0bisYvoO9OEfRNZW/2s=;
 b=q8j+0pdkWD0kpTuOF7Bx9uoOkTSTDGSdxhMqAmnuN615rPu0oW4xnEasmGUL2TDvcInDIqhGLFmhA35oyXWKSlQyaEKbEjjeb3pjEzK255B4n6fxGTQiioIqKSnVdlPHQu4OwrmuCfbbwXc8qGgwSjf2dWw2v8u8rB10sauhJxl9a78bMDGZ4MNFri0A0YbyxQY6o+ZPtQG4Yr0hxqtOVbFbmDW7GOKd1cG7G9AbffRLqo32i6n2Y1D/yQi43GQ0OWJP6GiczndV16jtqqa9EszuzDpdYTWnyRiZMhIZOoSmyR/DIIpRlLcNMqNklgO9GpBo3xY6232FuMQugIijAw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from GVXPR08MB10667.eurprd08.prod.outlook.com
 (2603:10a6:150:15a::13) by DU2PR08MB9961.eurprd08.prod.outlook.com
 (2603:10a6:10:494::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 16:17:20 +0000
Received: from GVXPR08MB10667.eurprd08.prod.outlook.com
 ([fe80::d70a:96e3:8888:668d]) by GVXPR08MB10667.eurprd08.prod.outlook.com
 ([fe80::d70a:96e3:8888:668d%5]) with mapi id 15.21.0496.010; Fri, 2 Oct 2026
 16:17:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 04/13] block/preallocate: serialise the filter state
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260930165000.303236-5-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
 <20260930165000.303236-5-den@openvz.org>
Date: Fri, 02 Oct 2026 19:16:59 +0300
Message-Id: <179095781937.643598.7058731900778279289.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR09CA0091.eurprd09.prod.outlook.com
 (2603:10a6:803:78::14) To GVXPR08MB10667.eurprd08.prod.outlook.com
 (2603:10a6:150:15a::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR08MB10667:EE_|DU2PR08MB9961:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f6aa7b-0d05-4ed0-6217-08df20a09a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|23010399003|18002099003|10067099003|22082099003|3023799007|38350700014|4143699003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: Chp+nUej7kgLR+fzns+rr2ABplyIr7yGccqpM+C3NjhuoaKpy2kmPm2UqR4z/6KT+f67SaUD6NnEpCl2M8ppdhayG5rxP8NmzphW93LB4DaN3qBxy1CYCLl8dyGnpcxBlKZ2Fe88DP0/L2rthRKo0p4eXGVN1r8ZuQ7f2wHpsHWcMDBsTTpZC215eEGlinrRaAMKy7rMRsuAvauD4EG2kLcPc/+ALuqL+HrIeQ0Q40tNd9QgAvHCRBxbb+a0IYKN4OnTITKyGB2MQ9IBwfBtaecRsANnMmjNk8UDLnoyteh1rGQe9ipRY3ozy9/s7dTE8MLt5VcfGe6hBNjN2KNSs6yDf1Juy5LPEfM3Y1lEy2gP3AdHTVcvqIsdYkoUuAf6sU+lQ5NAz0i7NfjfiphkCQLmRa6Pug8bEcJc6hHJGJ6LpYjK2OoLKRSwDdz0krpq2b8HwKC6wCXbcF/5+kZoMQiJ48Kn9XhCOTza8gJx67XjeBcRsg/ZzsXaj6jkr8dbLlgebxpseUDRzSVWMimmfmLtAuxINswL0NJbm7NTLZ39OouAGrwCe/9B981W3zGodG12C18MPnbr4joGAs7ZRQhzkwewlBwndHZWdye/b4wfSTSn2V+lvdHCf6JIAa0b3EUp0QfWxFwIlDRcQt6WWfOQ//B/bYwKUiUJjzwmKPOMi8ls6ejry1voYs2rycyNx0N1zh0UL2jyHGWbjeF4Dc8OI1DsFET1ta/3jK8uc1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR08MB10667.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(23010399003)(18002099003)(10067099003)(22082099003)(3023799007)(38350700014)(4143699003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZYdGlOQzh2bmZFcUtHMUErNHBHTUJNQ0hvanRaTEY3a2REbXNMU1huNlpG?=
 =?utf-8?B?S0g1SE5wREJJTjNjZmJmUTdManJhNW9jMlRpdytnSDRSWm5pa2c5SFphaVh0?=
 =?utf-8?B?TXZTM2I0NEhxNkhheDhkREhDRGU3Q09SdkdkeFZMdVRya2h4dXFDT21zeDdO?=
 =?utf-8?B?NXNSU0F0V3VqeWhlc2Uwb2g2bHZmUC9GamN1QjMzN2FiQ1JRV2JLU2FIbEpk?=
 =?utf-8?B?MUh2eExMWU1iNmZMNUxaamxxODAxaXg5Zjd2NllvaXFEdkJrZUIzZkdDYTlM?=
 =?utf-8?B?ZmpEUzdwdGVtYm13cS81cFNsc2xYYnl6dEttMHUvYzBqUWN6RnpGMUlQSVpF?=
 =?utf-8?B?aExidWpkUHEveXBMZE9ERkR4bXpDbmRvZUYzVENhTWxqSkcvR0VlYnpCVFRy?=
 =?utf-8?B?UjdvWmpKNDBaY3VYemIrQjFtN1lzUEpURDMrOXRnUDN4Vm1UamZDbEtiTVRJ?=
 =?utf-8?B?cVlCdXpSdldLZkNOeXRCQzNDZ1MzRFI0SjRQTFVoK0UwSjRmalhub3NsNGp1?=
 =?utf-8?B?TE5NK1prNmEvaVBwTkJPMlJjSDd5MGVuMTJDK1gwb0RYU0d5SlBIV2FTTHBW?=
 =?utf-8?B?ZlR6OFNEemtUNWZzazhUZkxDbDdCTGZCRXdIM1owMitjcmI3b3U4ZnVZUnY5?=
 =?utf-8?B?a0VxclhSOXVjeXdRTk5DNnQyZnJiczdJWFBPVWIydGxwN1lsNEh0S1FUVzhX?=
 =?utf-8?B?K0UveHg5a2RCTTZoVkF1dTVZTmU4ZGc2bDFOamtUVDhHT2VxSTd5bWQxR0FQ?=
 =?utf-8?B?Uk43ME5DaXRzVXFDVDJ0eDRTQktqVW1vTUJIeWx3Um40N1hTUS8vM1ovUExz?=
 =?utf-8?B?RWFDSGoya2RCNFQ2UUJhNmJFazFMNzNqeEJaWk9ob242KzhLakF3eUtXK3hs?=
 =?utf-8?B?TTJyMVRiTHFqeXl5NjZXMTN3Z2Y1Y0p4b2pqNFh0clpCdXY1WW85OGFhZGNm?=
 =?utf-8?B?MEJuV1BaUGI2Ykc2YjY4eFJOa3l5U05mSmoxL3VsMmJrMUxhaGMrSGRqWm9N?=
 =?utf-8?B?WTltcnRhRVFKYUkxeWJweTlQdGFRWDg1WEMwR2UzOTBHSHk1S1lkcUFXbTcy?=
 =?utf-8?B?WHVBWDd2TjE0bURvZDdXZDBYU3R6SHVCdEdHcFlIVHNrRVFhL0h3QStyOXIw?=
 =?utf-8?B?NmhPRmFQdFhoTXkxRGR1aTVWMmt5Q1FXeXI4SDZCeHR3MHVvcFhhbkJrSmJD?=
 =?utf-8?B?clZiNG9zLzd2NHJEYlI2bEtYOG1ObHIzRy9aWjBjZFJOM0lvaStXSnQ5aW84?=
 =?utf-8?B?ZjFFMnFRQzFJa1NlVEFnbXBWV2N6aEVHWjlKSzIwcmZNT3dRNEd5Q3BLSXdQ?=
 =?utf-8?B?Ti9KWEhzS0drdWZDWkNIU0pWYy9WMHlZOVpZeENFR0xpbjU0aGp2eVV6ZjlW?=
 =?utf-8?B?R2dQUlBzNzB3c3NIYytaZjA2ZU93bHhqdG9SRFlEWWR0Z05lNEFNOUdkbDBy?=
 =?utf-8?B?UEZPcVlNTlVJVjBCbnNtemhveDRKOU8yQmhjY1RaWGFNY0paaXBYL0gxZVh5?=
 =?utf-8?B?VUhCYmF6c0RlNS9lazhqRUY4L3IyVlhWK0dwem9tQmJ4aVdObDBUK3hTTUxV?=
 =?utf-8?B?QnBrcUk0cTc0STNYYU5Jd09BTnhyRGtBaTlpeGQ1Y2czNkR2bjZUUWJ4cElX?=
 =?utf-8?B?WnZTbDljdGxCVmZHMkg3aHkraTVSVTBFRzQ1WEpiSGtsKzRXSjFxK3I2czdm?=
 =?utf-8?B?dCsrVERQRnhyQWZkcmtCRlBUbUpORktDd3Q5TXVGMGZkbkRCK3NmY3dPNW9V?=
 =?utf-8?B?R0U5eTZOdGtSYW5kQ2dZRXB2YzRqU1R4OUw1R3dXTHdhdENpcGpaMkhEcjU0?=
 =?utf-8?B?L2JzR1dzVXJqdlpuQy8veDg0aSs3VStlaGJLMjJPRGRuQmpIc2VCSk01eVlr?=
 =?utf-8?B?bTZ5L0lpa3pRaWtmdnJCZXdGdnl6aGZxNkYxNkM1b2dkRGZhdUF0SkJLR0N5?=
 =?utf-8?B?NUM0bHlxbWdCR2tmVmpLODU1eUlMVHpOOFZSblBvN1E3TzNYUGd6Sk1KWlJq?=
 =?utf-8?B?NXZPekRiT3ozTmt4M0ZDaDVlMW5YUHFvTEdJZGc2d3V5eXYyNXBzNFVyNGM0?=
 =?utf-8?B?amduOHFrbDQyZFZHR2FQazZPQVVCNlp1ZTlIMnI3NDdRTmtuSzNRcUdtdjly?=
 =?utf-8?B?dmpESElTSEZIWHlOdDVCZElkK2hkZHJPWDJ3N0VmTjhDc2ovdm9IZCtGWjdn?=
 =?utf-8?B?S08xS0Izei9NWnNiOGZhelA2VzJ0T0VBY245UGFOSVFsazlaMitYaFBVVXFU?=
 =?utf-8?B?SlkxSjJNa3NHR1lGdnZBdnVmcWVlTkFMejNtMUhXT0Z4UGhhWFkzT3djeEZz?=
 =?utf-8?B?RURYY25PZEtIN0x3U2oydVVBTE95SHRndkhrRWMrbnl1K3BKY2tSeUhySS9E?=
 =?utf-8?Q?Y2A7ujgJGGNxPI4k=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f6aa7b-0d05-4ed0-6217-08df20a09a23
X-MS-Exchange-CrossTenant-AuthSource: GVXPR08MB10667.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:17:06.4533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEo4URucjc60Fzk0CToLoN6Cv7U6HHGfvVIomITLWTo1y8FyX2mdf8DGFgvm0ry6xcBmWrxtHnl8e2a6emIJ+8rBgLS8VXbuFTjQLD1fcO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB9961
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

> The filter keeps the file length it has seen, the length it has
> reserved and where the trailing zeroes start in plain fields, and
> updates them with a read, a compare and a store. That was indivisible
> while one node was driven by one AioContext. It is not any more:
> virtio-blk with iothread-vq-mapping drives one node from several.
> 
> Two writers extending the file then both pass the compare, and the
> smaller end lands last:
> 
>   writer A, [1G, 1G+64k)            writer B, [1G+64k, 1G+128k)
>   --------------------------------  --------------------------------
>   reads data_end 1G, 1G+64k > 1G
>                                     reads data_end 1G, 1G+128k > 1G
>                                     stores data_end = 1G+128k
>   stores data_end = 1G+64k
> 
> Both writes are acknowledged, and data_end now sits below B's data.
> Nothing raises it again except a later write ending beyond it, and
> closing the image truncates the file to it, so B's data is cut off the
> end. The last pair of extending writes before a shutdown is exactly
> where this bites.
> 
> Take a mutex across handle_write() and preallocate_co_getlength(). The
> remaining readers, apart from preallocate_co_truncate(), reach the
> state from global state code with the node drained, where no request
> is in flight.

The patch logic LGTM.  However if this claim is true, why don't we go
through each and every other reader of s->data_end and add
GLOBAL_STATE_CODE() in their preamble, to make sure this claim holds?

> Holding it cannot deadlock. A writer waiting for it has not reached
> bs->file yet, so it owns nothing below the filter, and the only calls
> made under it go to the child. preallocate_co_truncate() is left out
> for that reason: growing the file waits for the requests in flight on
> the child, and once the next patch issues the preallocation without
> the mutex, one of those can be a preallocation that needs it back.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: qemu-stable@nongnu.org
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/block/preallocate.c b/block/preallocate.c
> index 8cd98684f49..442cdb01768 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -76,6 +76,8 @@ typedef struct BDRVPreallocateState {
>       * BLK_PERM_WRITE permissions on file child.
>       */
>  
> +    CoMutex lock;

Also why don't we add some comment above the 'lock' field explaining
that we serialize updates of s->data_end (or state in general) and it's
relevant with iothread-vq-mapping and multiple AioContext's.

Thanks,
Andrey

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

