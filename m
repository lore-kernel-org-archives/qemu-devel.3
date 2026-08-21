Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504EBC5DF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 17:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxT8g-0006KT-Lb; Fri, 21 Aug 2026 13:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wxT8S-0006ED-Ki; Fri, 21 Aug 2026 13:34:33 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wxT8M-0004oQ-Gn; Fri, 21 Aug 2026 13:34:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTbmhHNa91rd5esfPmB3AS/Jk0mXbQcS59rMAZkYhsJTTIuNY+32+wEUFlSVah+fZNg1iE7OZFudOurm/WZze31SLMkeOq/SV6MuLn5tvEGNi9DDoFKDh74ST0W+iwiLvOJ8EL5Lbeq0aSfu8or4L0tNbkBmOg1QNzc7TIyMFzyMmmpWuowo/jQGoNcPjsn12Wi9hFSgjogbFDf85BaYWLQSDC+8IyhBxV0gJmUyKYAB7+rjDLViiHrRQu3QPIGLcjOdbZKVFjO+8m8eoN+FQfjwZRF2sdQs4OYhnaRR7lK9wYu3X5UqirGdHrlCZVc2CXwL62C6Q6sNPj3yyH2gCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9G8J8DywES9bnx0D/rcAtfH2thFLznvuZ9TB7CshDk=;
 b=KhI2KOzJ0TxqZeHj1tOXI2AMq8SR1kF4dUKkFHWm3ia0eI81hXxZd8+M9muGDu8TzbvncES1xgQMT5zq5HEm51OQ9oxpPAUbBFnnBERFS4K0yCGGANi7jiC2YpWHp7y6E3VF9GENF59cb57Tn13U7CvXTBO0tfSAFoBv/VM/nC9RGFGHduWlUBQus3dGKlnwE9N4i0OS3/GMPDjyGSLiPl+vKXWKjplfdaZgpVOUDrKZCkOIeBgddrYDsRt7Mmg/pT9C7s0shiZ8LgzStt8bGkHNbK35BEmcYXglENK1ceneEfSmBiIZfZIs812jcYJvmHxi+5ESpBEEi4A/JdrWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9G8J8DywES9bnx0D/rcAtfH2thFLznvuZ9TB7CshDk=;
 b=c3H+ERtzCwmuKHVVUjkHWAiUJvadPOrdQoqf4CFA0eZePB8pD9+m6tKB0RnGG8KRuUaoCitgBXkfHAUgJDrtdeXO52Lq+PjD6V6sqMGvxlSeyh/kfu6CUQsw9QaKHKoWcLV5keU8zskhNkGGN0W/507ru7jUNnlKp2Ucjj3CRMU20dS6Eqt3JE+YbjZd/yJcWR07SM7mzeJbNv9RfAe0Q9WRxTRLPsFySWTHNOYRzD9M2u5AsRl+9ZKvfd6DNecXPrfLnxqodxS2xVfsNjD1ZAg82Jo6xIlhywQ2bT58PUdYb3fRWCWrIL4Kb3yMQ6LClpvv9WuCHduyOj0SvCY9Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU5PR08MB10467.eurprd08.prod.outlook.com
 (2603:10a6:10:519::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 17:34:22 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 17:34:22 +0000
Message-ID: <000f96f5-1b53-487e-9528-8bb454583be9@virtuozzo.com>
Date: Fri, 21 Aug 2026 20:34:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] qcow2: silent corruption when a dirty image
 becomes writable
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20260819120558.3870413-1-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260819120558.3870413-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU5PR08MB10467:EE_
X-MS-Office365-Filtering-Correlation-Id: 161e8793-35e5-4224-2aef-08deffaa6fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: jSt2WSdxzXI+GEIjj3Zmfk+31CVm6MYJf6nb/BgDbVZSMlLhEdkwQCLfxqAM0JlGChPq99ryRGAB38bQH1aW7vVprfKkyp3sLerGYz87qXoZXjW6DdvdRlw0q/wS4FMtsZ2dnTo0BCmXENSFzRwdQAO6kah2BNXF7lF6ZPavavlK3JoYqtUtKEdaX2WmYVQ/MWCHcy/Ym5dJCHMEgIenndmDQI6FI4llYvtvOnWEHtpWcK99raTwxQp70cx9xIxsJKT4UdVEH1ht5CoWl1es0qGoqiYmoBYlBo+rz7eXgA9qIMTTSlc7LVLILMABqQSWT11EMJKbM8D+GDiv1Is3cN/ptnigiigIQLmPXsjstQtijxGqtwyejZ7sJa9GOAxyQiz9n0own3coEzHj1jKyGIiEbMsTiR8P4/YtvPLw4ORlLaRRGYNu2x9dWPPYDK98b906LhGYYdv3xtqeE+0jtlsx05/1n7XO3K34DwDGMU0NKr30lcLBMqr7Oo/l8eyiCMBuPCzjZY1U1+4dELROr80p0Z+Ye4CKjTYz8RWYLjnAw6hdglTQ8823wxaZd5OQ1Q4nNBzC35plXzNPC6d5JWc3Ti1vJgW0/rS+UAP0/oqRALOgLyEbV6nju88frDvVq1IBUETq7Dv4KQ0Ah8BU6crw9LSRaIvu0YV+fQrJNCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(5023799004)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWx5MFR1ejE5eUxYc0JKSFA2QmwzMmcxRzAvZVBlY3NLRUVHR01oUDltWisx?=
 =?utf-8?B?L3lQdlUydU0wUHZjZTJVa2w3czZndHg3SHpXSk9NR3ZzN25YbjRGRUUrcE02?=
 =?utf-8?B?UjRVMkJLSTQxc0RGOVpyRmdyVVFac3VlWG13dWQ5YnRCODBxSWR2aDRyZmcr?=
 =?utf-8?B?NENuTjlYeVlzQWd3WTRDU0w2SlFBdEhQS3FuTVBhUnJBaGF4YmpiRFd3ZGNa?=
 =?utf-8?B?QkZLcnBaVUFGZmNCcW9TSGVOSmRENlZtWTBuVEM5SWIrREdXQ1FYa2RGbFJu?=
 =?utf-8?B?a0VSeitoY1lQU1FvUVZ0ZDJTN0xKWUd5cW1CWWVzYVhNKzBKSmw1QUZuVG43?=
 =?utf-8?B?aHZlKzlGMit2KzNLSVo0SndsbHh3UlV4YUlmdkY1QkNmK1VJdWV3UFdJdi91?=
 =?utf-8?B?YU5WUlExbzNqS1l5Vmp5Qjl2NnREOWpSMmNmMDNWcVljSC9PRjltSFFJM2Fh?=
 =?utf-8?B?Mm5UdzlDZVVTTTNPMk5JSWVYL2kzM244OExXdm1DL21YUzExd0ZZbHNTcHJ6?=
 =?utf-8?B?MkFJSDQxemMzRWtDaTJTdG5Cb0h2Tm1ENWtya3RtSmpZaVFTMklhcDZYNFJy?=
 =?utf-8?B?R0NrRzBnOFNTczJEenh3ZnNSY0JBZWtla0hEa1FGaDZDcEFuVjRKWGpLaEoy?=
 =?utf-8?B?WlhlaWU1OUtCZUdWN2lmWTRhY2lGMzNHN3ppcGxBN0JqZEw4VzdqVWxSL1Bw?=
 =?utf-8?B?OG1Mdmh0a1NHZHNkcWY2U1dibHZpS1hQaEdTY0VDVWRaTkF1UXlQRWs5dURk?=
 =?utf-8?B?UlJTUUMxZzBUaU04a2FKNTUwRW1xNFIrMTI1ZzFmcEFWNjVYQXhPVlB3QUFZ?=
 =?utf-8?B?aFAxK0RVTlAzRmw2Y2FRUnhOczFFNnFHYlNqRGdxNXVQMmJhYWdWYU5ZaWkz?=
 =?utf-8?B?NlN0dzlJTTU2OG1YaHRUMlBpc0ZqSjlSMGJWY0ZXSmJxRHNFSWljTmJjeEVh?=
 =?utf-8?B?Y3ZOUXY0RDNNdFBMNHFoamVBdTRQdUY5emROZmhIVHVsajA0OEZUUWJPUmtP?=
 =?utf-8?B?ZW9yMllsUkVIcm9aQXpqZGx3Sk1DL1dScXlBTTZRZDBnUElka1orMG5QbnNo?=
 =?utf-8?B?MW1KTlIrKzFWMGI0bHNOR0VZMlNGRmZZVi81TFFOWWZIb0V0RGtZU3BTdDBG?=
 =?utf-8?B?TzRTaTNiN3dGbFhFb2ZvNGJ3OXJ4TUR2UkY1b3pTMkZxYURGZmc2TUY0UnRl?=
 =?utf-8?B?M3RpT0NCVnBCM1M2T3BjWElNb2FjTUhMY3RZcjBzYUhmYi9PRDVtOXJGMXpp?=
 =?utf-8?B?aTNsZ1N4QzJEQ1k5MGpGbGo0TnVVaCtnRkl5Tk40aWN3a2k1bjh4M3RFQjhB?=
 =?utf-8?B?MjVTSXdzODROY2lYM3lyZXVGKzg2K0lJY3hxQ2ZBS2p1TTROVURJblB3MjQv?=
 =?utf-8?B?TTZsUGJSMEF4Yyt1K0lOVllDS3VjZDhyVThyVlFBSU5jSG5TZlRDT1NHMlNj?=
 =?utf-8?B?Q2VzQllNMGNoaEhnMFNCSS8zL05XeHU3UWRDK2lFSGI2MGtZdUFCaXNDR280?=
 =?utf-8?B?bEhXaU1kSVBFSGtLcFlNa1E3S3pBdVFFbHQvSGYrZWZ4WlIram5xRHNldkR5?=
 =?utf-8?B?WHk4VWJkOHdIdGUvZnp6dEpJaGZ2WmowTDFKOUU1WTdiL0ptcU80ckpzRHNP?=
 =?utf-8?B?MUxNUGJMZUFsemFIR3lKOU8rZk1lTGcvNEFZUDdpZEloMElIQUM5WkVwVlUz?=
 =?utf-8?B?QTVWMGt0Ujd6Q2lpU3VVanh5b3RRd25GWHdxQ2NyTlB6NEdhTnFrekhtRlF6?=
 =?utf-8?B?Wkc5V2x4N1hiYytZa3NMaGNKUUh2NUNhYVp3ZVVtRktLakxCRmdIeFd6RThF?=
 =?utf-8?B?N0JZYW9sYXk0VDJycncvMFQ2YmZpVm1sSG9kK3pON2RvcHRpa2NrSXJPa3Vy?=
 =?utf-8?B?STZjMEUwNFhWN20wVVRQTDkrTnlVSHU5TStvdHFaTDR4M0IyQStVSXRHSWtW?=
 =?utf-8?B?SE9MdXV1NXFTWDhNbmVUNnc0T2VEQURnMkJHZTlvY0liOVRSRUdGM1BFc05z?=
 =?utf-8?B?a1lxUFVacEtMckY2WTlZcmlxYmQydXlnV0dHOU1yMHQ4UWNqREJEUEIyNEIy?=
 =?utf-8?B?MWo1bU9ZZTlVOFpkQkM0cWZ4YzlqblNqM256WVlVc1dUWm51YXZJUVRRSEc2?=
 =?utf-8?B?QW0yTXpsYW9vS3JOcS9kYlhPcm5ranBzcE1idzlHZXUrQng4Y0dreWV0dFZr?=
 =?utf-8?B?czFJdTgyK1ZnalpBQXh6SlFvblAycEtpYWNBcXE5M0ZSalhrQ1JkUnpNZzVP?=
 =?utf-8?B?cXd1YXJpYjFvNVZGQUFydy9hdldudTlhc1lybG9JWVNJcmVkVkdkdWdyNnNl?=
 =?utf-8?B?ZGtlQ2dKQzVTNWJCSWg2TUZGcHlmSFBlWkxIMEJsYTJQODAyYnluRkl2WUlu?=
 =?utf-8?Q?6x0KTk4cgs+KLopo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161e8793-35e5-4224-2aef-08deffaa6fd2
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 17:34:21.9569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUK0Y5o/mGScrfxpBxMgD1U+EbBsXChxmnLSStAKt+qDv1v4BvsMW1efDk33Cc9OBnRhn6LQCR3DbDHP17nQV72aMt85SQ//Sc6bgWYVb0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10467
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

On 8/19/26 3:05 PM, Denis V. Lunev wrote:
> Today I have faced real data corrupt from our customer with the
> situation very close to the one addressed in the patch
> "qcow2: do not try to clear the dirty bit on a read-only node" and
> that is interesting. I was really unsure that design is correct
> but with today case I can say that correct thing was done.
> 
> The problem
> -----------
> 
> qcow2_do_open() repairs an image carrying QCOW2_INCOMPAT_DIRTY, but only
> for a node that is writable from the start:
> 
>     if (!(flags & BDRV_O_CHECK) && bdrv_is_writable(bs) &&
>         (s->incompatible_features & QCOW2_INCOMPAT_DIRTY)) {
> 
> A node opened read-only skips it, correctly, since it resolves nothing
> and writes nothing. Nothing revisits the question when that same node
> later becomes writable, and bdrv_reopen() is not an exotic way to get
> there: commit_active_start() and commit_start() both reopen the base
> read-write for the duration of the job, so an ordinary block-commit onto
> a read-only backing file is enough.
> 
> With lazy refcounts the refcount blocks are not written again once the
> dirty bit is set, so an image left behind by a killed QEMU has an
> on-disk refcount block that accounts for the metadata clusters and
> nothing else. Every data cluster reads as free. s->free_cluster_index
> starts at 0, so the first allocation after such a reopen starts at the
> front of the image and hands out clusters that L2 entries still point
> at.
> 
> The result is aliasing: two guest offsets mapped onto one host cluster,
> so the guest reads back data belonging to some other offset. Nothing
> about this fails. No I/O error is reported, the corrupt bit stays clear,
> and a clean close clears the dirty bit as well, so no later open will
> repair the image either. Afterwards qemu-img check reports
> 
>     ERROR cluster N refcount=1 reference=2
>     ERROR cluster N refcount=0 reference=1
>     ERROR OFLAG_COPIED data cluster: l2_entry=<host>|COPIED refcount=0
> 
> and the only runtime witness, if something eventually frees one of those
> clusters, is a bare
> 
>     qcow2_free_clusters failed: Invalid argument
> 
> on stderr, with the guest none the wiser.
> 
> How it looked in production
> ---------------------------
> 
> A VM was killed while its storage was unavailable, leaving a 100 GiB
> volume dirty. It came back with a snapshot-revert overlay on top, so the
> volume itself was now the read-only backing file, and the overlay was
> committed into it two and a half hours later. 8082 host clusters ended
> up referenced by two L2 entries each, roughly 8 GiB of guest data
> cross-mapped. The guest filesystem began failing metadata verification
> on buffers holding fragments of unrelated files.
> 
> Two properties of the damage are worth recording, because they are what
> told us this was not a race:
> 
>  - aliasing is exactly two-way, never three or more, which is a single
>    monotonic sweep of the allocator rather than a window hit repeatedly;
> 
>  - it stops dead at the host cluster that was the image end at the
>    moment the volume was made writable. Everything allocated after that
>    point is intact.
> 
> qemu-img check -r all makes the metadata self-consistent again, and then
> honestly reports no errors, but it cannot un-alias anything. The guest
> data stays wrong.
> 
> Reproducer
> ----------
> 
> Under a second, no guest and no block job required:
> 
>   qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=on base.qcow2 1G
>   qemu-io -f qcow2 -c "write -P 0xaa 0 100M" -c flush \
>           -c "sigraise 9" base.qcow2
> 
>   qemu-io -r -f qcow2 base.qcow2 \
>       <<< $'reopen -w\nwrite -P 0xbb 900M 100M\nquit'
> 
>   qemu-io -r -f qcow2 -c "read -v 0 16" base.qcow2
>   # 00000000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> 
> The flush is load-bearing: it writes out the L2 cache but not the
> refcount blocks, which is exactly the asymmetry the bug needs. Guest
> fsyncs supply it in production, so a long-running VM is the ideal
> victim. qemu-img commit of an overlay reaches the same state through
> commit_active_start().
> v1:
> https://lore.kernel.org/qemu-devel/20260731220039.1765584-1-den@openvz.org/
> v2:
> https://lore.kernel.org/qemu-devel/20260811173857.396571-1-den@openvz.org/
> 
> Notes for review
> ----------------
> 
>  - The repair still runs under bdrv_drain_all(), so a block-commit onto
>    a large dirty base stalls guest I/O for the length of a full metadata
>    scan. Rejecting the reopen instead would be cheap, but block-commit
>    depends on it succeeding, so repairing in place is the only option.
> 
>  - .bdrv_reopen_commit_post() runs after the transaction is committed
>    and cannot roll anything back, so a negative return value reports an
>    unusable node rather than rejecting the reopen. That is unusual, and
>    it is the only channel available: there is no failable hook once the
>    node holds BLK_PERM_WRITE.
> 
> Changes in v3
> -------------
> 
>  - patch 1: the same bug aborts QEMU, not only fails a reopen, when the
>    file node below is writable; the message says so and iotests 039
>    covers the read-write to read-only direction as well. (Andrey)
>  - patch 2: new, a reopen of a node whose driver is gone segfaults in
>    bdrv_reopen_queue_child() and asserts in bdrv_reopen_prepare(), which
>    is the crash a failed repair would reach through commit_clean();
>    bdrv_reopen_prepare() reports it instead, iotests 060 covers it.
>    (Andrey)
>  - patch 3: bdrv_reopen_multiple() documents that a failure means either
>    nothing changed or the reopen went through and left an unusable tree;
>    no caller changes. (Andrey)
>  - patch 3: an implementation which fails must set an error, asserted,
>    and the loop skips a node whose driver is already gone.
>  - patch 4: the pre-reopen flags are recorded as int old_flags rather
>    than a bool, with a bdrv_reopen_was_writable() accessor for drivers.
>    (Andrey)
>  - patch 5: the failure names the node and keeps the errno of the check.
>    (Andrey)
>  - patch 5: a failed repair drops the driver instead of calling
>    qcow2_signal_corruption(), which would write the corrupt bit into the
>    header for what may be a transient ENOSPC.
>  - patch 5: blockdev-reopen and block-commit document the failure and the
>    state it leaves. (Andrey)
>  - patch 5: iotests 040 covers a commit onto a dirty base through both
>    commit_start() and commit_active_start(), and the failed repair.
>    (Andrey)
> 
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> Denis V. Lunev (5):
>   qcow2: do not clear the dirty bit when reopening a read-only node
>   block: reject a reopen of an unusable node instead of crashing
>   block: let bdrv_reopen_commit_post() report a failure
>   block: remember the flags a reopen starts from
>   qcow2: repair a dirty image when it becomes writable
> 
>  block.c                          |  55 ++++++++++++--
>  block/qcow2.c                    |  33 ++++++++-
>  include/block/block-common.h     |   1 +
>  include/block/block_int-common.h |  11 ++-
>  qapi/block-core.json             |  16 ++++
>  tests/qemu-iotests/039           | 110 ++++++++++++++++++++++++++++
>  tests/qemu-iotests/039.out       |  56 ++++++++++++++
>  tests/qemu-iotests/040           | 122 +++++++++++++++++++++++++++++++
>  tests/qemu-iotests/040.out       |   4 +-
>  tests/qemu-iotests/060           |  30 ++++++++
>  tests/qemu-iotests/060.out       |  13 ++++
>  11 files changed, 436 insertions(+), 15 deletions(-)
> 
> 
> base-commit: fa19879df1658f96ac07365fca8835b7decd6995

Overall LGTM, with a couple of wording nits in the last commit.  For the
series:

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Btw this respin lost 'Cc: qemu-stable@nongnu.org' compared to v2 - but
it's probably needed since we're fixing genuine crash.

Andrey

