Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01DDD11712
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTIi-0004Ap-5T; Tue, 02 Dec 2025 11:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTIf-00049x-Ow
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:32:25 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTId-0005yG-60
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:32:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKWKOvzhTig/66LdWvmDTZupmF1A+zy6ew6GC0iV13AuNVgHAL+Ax4JEh7BCoOnL9lyVJkZJktEIygJAActdAlCTpvovGj9+XdbmCzy554XAa32wW/tVWlLWM2z71O0TQ3k0w7Yp9varAxlVRBAJNtYeYGUY3wYFrwi2vf+Px5UC9gX7D6KqRSqMHlrozDLBY6umuQiK7TxShZDK/+VXcRPrr7FFZETxiiRJwhFV2BIRbUtgJ80oTEuVH7xGtZ8Hxv0m2XEIlm9iWDzJB/idGTAkngU5XZ7C2w/t7mFrghxUJ8r5TTt/GFERM29/NjIp5z+KPl7FUA8Yak/kGAK9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7rClAcctbeu521pF2M6GDEkhHEH/KfSwtfuxjS0O8U=;
 b=scFsdUo8u761Y4H1BDIaLn2+yKeAHBH9x0ZzxdqZ41/pld2pE6LlvFBnbkf4zBvGMsITppwx18bWkSYbWc3jRhTQob1shi7vdXAVuK+n5NLq+DVDETRjApb3PXAOMlbChWcyH0Z2/V/uQ2gLgAKPiL0eEge18lW9zQdsok/6gGPGqG+VMg1KkTo2OI/ANCgRf3l0gLyGRW0pmocCNBBE/IptQZrFI6cClVqAYOE2IFYOUlTP45spTXuuj+2gwOVyYJG2EKmG45sHK37CV8PMhqup/ygoIRsJ5HfFeh3MAMlyONeO4GvsI9RSQggmhPv6YFVHwjFBoba8T5Ano7VFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7rClAcctbeu521pF2M6GDEkhHEH/KfSwtfuxjS0O8U=;
 b=DIYapHtjE1FK7IK+haKUNEPE+AFR4FCGI4ua3doyaVSQlQEMlIoNjjXkOdiYJDHSzeHZUbUB6kw4SfwJu6l54juzMG6T5LiXCR8cS/vsGkdl9nqTPYf9ZlqzwSoZVzIZjmaNCcIw34zYJNqpG00KulEx23vqXR64b7E8xuMuSNY4JDB+TpC88jHtC+OkWLLLJRK0J/0siKuzQqxBDFZ/vnR4GG/mcs8yGNqdfQEgQjvgFCHhqrOeo2J8090zDe2kJk57lBChvOE1qXaiW+8KES5K/knzQxDwXHOuHkowtbBtZnwkTualJcwjA25zGAdE5i54b0CL4ATFBuA+WTqc2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB11051.eurprd08.prod.outlook.com
 (2603:10a6:150:1ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:31:45 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:31:45 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
Date: Tue,  2 Dec 2025 18:31:19 +0200
Message-ID: <20251202163119.363969-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251202163119.363969-1-andrey.drobyshev@virtuozzo.com>
References: <20251202163119.363969-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB11051:EE_
X-MS-Office365-Filtering-Correlation-Id: ef484f5f-058a-45af-6281-08de31c04856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0jym19R/tXn0I4SvimiuSQe7c9/8bZUmRI0C1vN0fAx/X3v2eqHQ2X3/mjhE?=
 =?us-ascii?Q?n+DlZJNxtwvEa85HyzLW5KX061y5UtGFnUAZJ9udr8UNR9MQMh9MqmCL2Z72?=
 =?us-ascii?Q?8MdDp0Lq9X+sdgUeg7rF/vdsjkeu5/j1E2ytDfUE4em5EKKcZ4CC2+NO52Q8?=
 =?us-ascii?Q?IfTNKqKuEZE26T+gb9agdHvS27rmCZjOB0WEqDbj4DMveTD52jFfT3uZ5qb4?=
 =?us-ascii?Q?Rh5zIVawcgBZCYddOmcBJHSJ50i/p3NjmwcCx768KWNC5hGyWszgtlf4iyMC?=
 =?us-ascii?Q?kf02xkn9PMJe3rRnqfDAGc4kdjmRe8QZQX1ZFBGVhDVL+BaXzonYcJXukn24?=
 =?us-ascii?Q?iEzP1KFq1n4TdDbhPIrraOxG1aUOvB9F/fZsIooShnWNd2DInBX1iB7sJC2X?=
 =?us-ascii?Q?IEm0Fn6+95ZugCeZhIrP1TRQTRVjjN6nSBSc01kriDF7SW8h8I/+EdLn2TH5?=
 =?us-ascii?Q?iPACe6W9dzMJ0MlHRWQc9UQHsgA9EbS4MNo58SWQ9OcLOSz3M2//9a4Xax9x?=
 =?us-ascii?Q?qe+fckKeBtMv4JhcS0RqqoJiFr+zPxXjMbwgXivQJICADq45b2ZEDvrSh5OO?=
 =?us-ascii?Q?UF6Pva1zTTIxcs6enEq9hxrNMf9JIS/U95v4HnZCyJwanBWebEt3Tfg5l2is?=
 =?us-ascii?Q?I0GHdiVuN8l7eES+4C7aUv17tMT9NxrR5ex/T6OJ+cVJwckrHrv1MEZkOYiD?=
 =?us-ascii?Q?z0D97ayirKqWKzP91GxBi0qfM6SHmBjG5AxJBTpVb1WPtQb44KRWR7qpyZIe?=
 =?us-ascii?Q?TtTWpn1PY9WxMxteAhs5WzFMx3NAaRWakdD51zT8/eiighnQJBFQWaGFXbCw?=
 =?us-ascii?Q?QLFSmcbFOy8W1k+pWuW1jOhp57miagnDKLwz4JuBiQfLQALIdkvKHQQViEZE?=
 =?us-ascii?Q?BCET9V8S6kTO1wJHSR3Ji7+GOAZyGrch5tpnOvVlQo+a8dp1y3dtQnv5EbEU?=
 =?us-ascii?Q?fuQrxGbrX1Y/ElaGnJMWrxZCoUs+4qVL6lB2DN+gnZnXTanZJj08tS/J9iqD?=
 =?us-ascii?Q?BPUt6EH0PXMOXPAd8LgKFrPcfSx2tQdB4609bqwmFU0zZ48nHWkxaY5EwT0D?=
 =?us-ascii?Q?fNEi4QbPb7AqHsDMtjM0Ev5B0Kwb642bvA3ug2mG4SurFpanBLTv6XdAM5Hm?=
 =?us-ascii?Q?YYDwUYtnp9ruvOU/ZY7twNpHWts+e8gXD3ZL8dmwaC2mGlI1a9GxhXCSjbPS?=
 =?us-ascii?Q?czr1dD736i3TAKUC+5btlIp+NMapSbe7rX4UtQCAuTjzCLmQ5KmlSKmga0qS?=
 =?us-ascii?Q?z/N57p+VlROdLG0nQXklBMoiDzI+V3fNh83LVMttL4kNqr8y5IPj2OKd77DK?=
 =?us-ascii?Q?QvOZQZFIE1CmiSTTiGTWy6uJs0b9zOIgJd1jcigo+bFLAxl4YP55UQXG31Kt?=
 =?us-ascii?Q?+N6lZ5mKg+glG9eeuam6PrMC3OWvrA6NbpsnnW84I8+PihrE6vqusK7fLSo7?=
 =?us-ascii?Q?IjoXht+PlFGgkXEvoSdAfTcp2LgR/M1YI6qp4KgwE4Cmut06U0dotbqWcwb3?=
 =?us-ascii?Q?BBQ4WBRiY/xu/eINkang2xY+47F9MsKlincx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XF6KTeQjYXk0LZitftK3eUqioxqZw62TvIDMkt2m3s7T7y7rs0Vmahx0TwrW?=
 =?us-ascii?Q?8pb9fF31JfVxobhzwJcjNmZkistD9pTfSjo5aJpu7NONDNIM/xHlVRxRmtXo?=
 =?us-ascii?Q?2qgpfUGX8XZMilXqUBQDnuLlYtwRVyFll7Jz2Yu5YQVhyGUWXK/mc6sazg1I?=
 =?us-ascii?Q?LnaXGNwsLseTbhmpTK1ihXSwqyfNaMmOYVfOwS5q6B8qTz5fU/TDmdqUWWAF?=
 =?us-ascii?Q?EzZ1qqYTXXc7vIRMgVClRU5FWiNEZPZMgIEronStrq4U/6ZEnTrkniTpMeA5?=
 =?us-ascii?Q?HqvJNzpGny6vg1475Yv5k4IR6nAWy2kIrvf2lO0U2MvNk1TTBeqGwVr+Bu3d?=
 =?us-ascii?Q?PaFFaagXZlOh9SkUkBlK5lNbDXBVTSifAOU5dSvZSLFypgORGfW5N5V+oj7N?=
 =?us-ascii?Q?dptxJviy/+xMb40TwYmwxyiAtpT/PsbCvTEXjBDHGeOgcSGb4YF17jK20ObZ?=
 =?us-ascii?Q?jsFxz9XnipGzQgdGvvgSi6nEIe6YulkJWxKu/J/jQIO2QXpq/uQDmcnFPmN2?=
 =?us-ascii?Q?tAqdzb9lq+2D10uzpBdp3SIMRNHtQkP4WLmr1BzaW+dnT9WYvJnU5iLzrkzz?=
 =?us-ascii?Q?vlQasHaIiM2pYjLSzwfW+WiacL1zdiXz6sKKXqu7Po48+F4iTPFqZ72pPeac?=
 =?us-ascii?Q?YfppyMn7b53nj+I7d0n1+suHotXxYTD56t4jUKpFThikuTs9sYCt96iNO9pQ?=
 =?us-ascii?Q?efS9rTV+KW+uzEY2bKoo1CoOlXFztNVh3ONPb+4EDLur9JfzuUvT+DD4zxKO?=
 =?us-ascii?Q?12cu9Uq1vid2nSM5J3ib/PFXf4BEBaBRSESjklOQFtCgBYYTbi+1UhDvSWZC?=
 =?us-ascii?Q?yqkS1Wtzv4H3pOzITT5HAxwY+86FzXjvoVD4k7zx+yMbWQQfR+GQ0qUVNcWW?=
 =?us-ascii?Q?8dX/LbkOhn51f3Sju1eodQtnwN/HASm4b/W6WbdlUgKbUJwzOez0DXB4SANe?=
 =?us-ascii?Q?LAuVcNm63sNKifjv2NmyhPGumMIPxKY+2/KdFnHOox6btD+M+q7YO0k5TdvY?=
 =?us-ascii?Q?SxRj/D+29CoQN43vU5JM+/XNczdKZVNYyzeRKZbFJLRFeAa9Z6Hucwn+c+Te?=
 =?us-ascii?Q?iI2xIdWrKczwPsFCjXLVIcgH4+46hXN6I5BLC1vGigpbTS0F2KQ4MmthjFL2?=
 =?us-ascii?Q?g30jXsJi/+PWQ6uLQZPEsNUpvOvLw6xFKpxQ9vQ4y953OdZOpyj9hEq+xBIL?=
 =?us-ascii?Q?w+sm4D0Mpccjdy1/u8N4MW4t6JC9n7BB8m8YjuBn+KJwAKDFALL0dKQgESNN?=
 =?us-ascii?Q?pQ3ZZBH6iQo9AILtnosYmFtW6QT/O/OptKREFKeQsRU5wr73dPekPYF/DbzP?=
 =?us-ascii?Q?dni6qzmXQq35lCNAdN0xZlcUBaW2T6WBhFrlG961JV2WTqSTlOPGlh/vb0ak?=
 =?us-ascii?Q?kJGHoR9N80W7ZQUSot/Hla0JuThBL7rwkAGld4OK6f3SQZDv9u+ih0qOBShA?=
 =?us-ascii?Q?MG/ShEtzouZlI93zH3YW9dcDK1OG89gB05z22QDaPj1mcG7IUrg/R5bPzt2h?=
 =?us-ascii?Q?O0X2m3A3JRslSKXkPdUQMIt6/M9zFhdivHM8Ob7N77wTKt0OHHOYhYLUZ4Wh?=
 =?us-ascii?Q?rppalSTQGruaInmz1Mu9We0te+TiJ7wbsgeKKmzJishh4XSCo4CqyqOJCoxf?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef484f5f-058a-45af-6281-08de31c04856
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:31:45.2638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDNi0V26QmvU1Zzq7cjluefKDiW3Zg2Hv77cu5E9cpozXlYU8AICCZx1gakppbp240sGoua+efDG3i4fzo0UhLwKbacTNTACVHEwgkqIy/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11051
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
coredumps") introduced coroutine traces in coredumps using raw stack
unwinding.  While this works, this approach does not allow to view the
function arguments in the corresponding stack frames.

As an alternative, we can obtain saved registers from the coroutine's
jmpbuf, patch them into the coredump's struct elf_prstatus in place, and
execute another gdb subprocess to get backtrace from the patched temporary
coredump.

While providing more detailed info, this alternative approach, however, is
more invasive as it might potentially corrupt the coredump file. We do take
precautions by saving the original registers values into a separate binary
blob /path/to/coredump.ptregs, so that it can be restores in the next
GDB session.  Still, instead of making it a new deault, let's keep raw unwind
the default behaviour, but add the '--detailed' option for 'qemu bt' and
'qemu coroutine' command which would enforce the new behaviour.

That's how this looks:

  (gdb) qemu coroutine 0x7fda9335a508
  #0  0x5602bdb41c26 in qemu_coroutine_switch<+214> () at ../util/coroutine-ucontext.c:321
  #1  0x5602bdb3e8fe in qemu_aio_coroutine_enter<+493> () at ../util/qemu-coroutine.c:293
  #2  0x5602bdb3c4eb in co_schedule_bh_cb<+538> () at ../util/async.c:547
  #3  0x5602bdb3b518 in aio_bh_call<+119> () at ../util/async.c:172
  #4  0x5602bdb3b79a in aio_bh_poll<+457> () at ../util/async.c:219
  #5  0x5602bdb10f22 in aio_poll<+1201> () at ../util/aio-posix.c:719
  #6  0x5602bd8fb1ac in iothread_run<+123> () at ../iothread.c:63
  #7  0x5602bdb18a24 in qemu_thread_start<+355> () at ../util/qemu-thread-posix.c:393

  (gdb) qemu coroutine 0x7fda9335a508 --detailed
  patching core file /tmp/tmpq4hmk2qc
  found "CORE" at 0x10c48
  assume pt_regs at 0x10cbc
  write r15 at 0x10cbc
  write r14 at 0x10cc4
  write r13 at 0x10ccc
  write r12 at 0x10cd4
  write rbp at 0x10cdc
  write rbx at 0x10ce4
  write rip at 0x10d3c
  write rsp at 0x10d54

  #0  0x00005602bdb41c26 in qemu_coroutine_switch (from_=0x7fda9335a508, to_=0x7fda8400c280, action=COROUTINE_ENTER) at ../util/coroutine-ucontext.c:321
  #1  0x00005602bdb3e8fe in qemu_aio_coroutine_enter (ctx=0x5602bf7147c0, co=0x7fda8400c280) at ../util/qemu-coroutine.c:293
  #2  0x00005602bdb3c4eb in co_schedule_bh_cb (opaque=0x5602bf7147c0) at ../util/async.c:547
  #3  0x00005602bdb3b518 in aio_bh_call (bh=0x5602bf714a40) at ../util/async.c:172
  #4  0x00005602bdb3b79a in aio_bh_poll (ctx=0x5602bf7147c0) at ../util/async.c:219
  #5  0x00005602bdb10f22 in aio_poll (ctx=0x5602bf7147c0, blocking=true) at ../util/aio-posix.c:719
  #6  0x00005602bd8fb1ac in iothread_run (opaque=0x5602bf42b100) at ../iothread.c:63
  #7  0x00005602bdb18a24 in qemu_thread_start (args=0x5602bf7164a0) at ../util/qemu-thread-posix.c:393
  #8  0x00007fda9e89f7f2 in start_thread (arg=<optimized out>) at pthread_create.c:443
  #9  0x00007fda9e83f450 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Peter Xu <peterx@redhat.com>
Originally-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 243 +++++++++++++++++++++++++++++++++--
 1 file changed, 233 insertions(+), 10 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index e98fc48a4b..280c02c12d 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -10,9 +10,116 @@
 # or later.  See the COPYING file in the top-level directory.
 
 import gdb
+import os
+import pty
+import re
+import struct
+import textwrap
+
+from collections import OrderedDict
+from copy import deepcopy
 
 VOID_PTR = gdb.lookup_type('void').pointer()
 
+# Registers in the same order they're present in ELF coredump file.
+# See asm/ptrace.h
+PT_REGS = ['r15', 'r14', 'r13', 'r12', 'rbp', 'rbx', 'r11', 'r10', 'r9',
+           'r8', 'rax', 'rcx', 'rdx', 'rsi', 'rdi', 'orig_rax', 'rip', 'cs',
+           'eflags', 'rsp', 'ss']
+
+coredump = None
+
+
+class Coredump:
+    _ptregs_suff = '.ptregs'
+
+    def __init__(self, coredump, executable):
+        gdb.events.exited.connect(self._cleanup)
+
+        self.coredump = coredump
+        self.executable = executable
+        self._ptregs_blob = coredump + self._ptregs_suff
+        self._dirty = False
+
+        with open(coredump, 'rb') as f:
+            while f.read(4) != b'CORE':
+                pass
+            gdb.write(f'core file {coredump}: found "CORE" at 0x{f.tell():x}\n')
+
+            # Looking for struct elf_prstatus and pr_reg field in it (an array
+            # of general purpose registers).  See sys/procfs.h.
+
+            # lseek(f.fileno(), 4, SEEK_CUR): go to elf_prstatus
+            f.seek(4, 1)
+
+            # lseek(f.fileno(), 112, SEEK_CUR):
+            # offsetof(struct elf_prstatus, pr_reg)
+            f.seek(112, 1)
+
+            self._ptregs_offset = f.tell()
+
+            # If binary blob with the name /path/to/coredump + '.ptregs'
+            # exists, that means proper cleanup didn't happen during previous
+            # GDB session with the same coredump, and registers in the dump
+            # itself might've remained patched.  Thus we restore original
+            # registers values from this blob
+            if os.path.exists(self._ptregs_blob):
+                with open(self._ptregs_blob, 'rb') as b:
+                    orig_ptregs_bytes = b.read()
+                self._dirty = True
+            else:
+                orig_ptregs_bytes = f.read(len(PT_REGS) * 8)
+
+            values = struct.unpack(f"={len(PT_REGS)}q", orig_ptregs_bytes)
+            self._orig_ptregs = OrderedDict(zip(PT_REGS, values))
+
+            if not os.path.exists(self._ptregs_blob):
+                gdb.write(f'saving original pt_regs in {self._ptregs_blob}\n')
+                with open(self._ptregs_blob, 'wb') as b:
+                    b.write(orig_ptregs_bytes)
+
+        gdb.write('\n')
+
+    def patch_regs(self, regs):
+        gdb.write(f'patching core file {self.coredump}\n')
+        patched_ptregs = deepcopy(self._orig_ptregs)
+        int_regs = {k: int(v) for k, v in regs.items()}
+        patched_ptregs.update(int_regs)
+
+        with open(self.coredump, 'ab') as f:
+            gdb.write(f'assume pt_regs at 0x{self._ptregs_offset:x}\n')
+            f.seek(self._ptregs_offset, 0)
+            gdb.write('writing regs:\n')
+            for reg in self._orig_ptregs.keys():
+                if reg in int_regs:
+                    gdb.write(f"  {reg}: {int_regs[reg]:#16x}\n")
+            f.write(struct.pack(f"={len(PT_REGS)}q", *patched_ptregs.values()))
+
+        self._dirty = True
+        gdb.write('\n')
+
+    def restore_regs(self):
+        if not self._dirty:
+            return
+
+        gdb.write(f'\nrestoring original regs in core file {self.coredump}\n')
+        with open(self.coredump, 'ab') as f:
+            gdb.write(f'assume pt_regs at 0x{self._ptregs_offset:x}\n')
+            f.seek(self._ptregs_offset, 0)
+            f.write(struct.pack(f"={len(PT_REGS)}q",
+                                *self._orig_ptregs.values()))
+
+        self._dirty = False
+        gdb.write('\n')
+
+    def _cleanup(self, event):
+        # If we've come to the proper cleanup upon the end of GDB session,
+        # that means original regs are already restored
+        if os.path.exists(self._ptregs_blob):
+            gdb.write(f'\nremoving saved pt_regs file {self._ptregs_blob}\n')
+            os.unlink(self._ptregs_blob)
+
+
 def pthread_self():
     '''Fetch the base address of TLS.'''
     return gdb.parse_and_eval("$fs_base")
@@ -77,6 +184,55 @@ def symbol_lookup(addr):
 
     return f"{func_str} at {path}:{line}"
 
+def run_with_pty(cmd):
+    # Create a PTY pair
+    master_fd, slave_fd = pty.openpty()
+
+    pid = os.fork()
+    if pid == 0:  # Child
+        os.close(master_fd)
+        # Attach stdin/stdout/stderr to the PTY slave side
+        os.dup2(slave_fd, 0)
+        os.dup2(slave_fd, 1)
+        os.dup2(slave_fd, 2)
+        os.close(slave_fd)
+        os.execvp("gdb", cmd) # Runs gdb and doesn't return
+
+    # Parent
+    os.close(slave_fd)
+
+    output = bytearray()
+    try:
+        while True:
+            data = os.read(master_fd, 65536)
+            if not data:
+                break
+            output.extend(data)
+    except OSError: # in case subprocess exits and we get EBADF on read()
+        pass
+    finally:
+        try:
+            os.close(master_fd)
+        except OSError: # in case we get EBADF on close()
+            pass
+
+    # Wait for child to finish (reap zombie)
+    os.waitpid(pid, 0)
+
+    return output.decode('utf-8')
+
+def dump_backtrace_patched(regs):
+    cmd = ['gdb', '-batch',
+           '-ex', 'set debuginfod enabled off',
+           '-ex', 'set complaints 0',
+           '-ex', 'set style enabled on',
+           '-ex', 'python print("----split----")',
+           '-ex', 'bt', coredump.executable, coredump.coredump]
+
+    coredump.patch_regs(regs)
+    out = run_with_pty(cmd).split('----split----')[1]
+    gdb.write(out)
+
 def dump_backtrace(regs):
     '''
     Backtrace dump with raw registers, mimic GDB command 'bt'.
@@ -120,7 +276,7 @@ def dump_backtrace_live(regs):
 
     selected_frame.select()
 
-def bt_jmpbuf(jmpbuf):
+def bt_jmpbuf(jmpbuf, detailed=False):
     '''Backtrace a jmpbuf'''
     regs = get_jmpbuf_regs(jmpbuf)
     try:
@@ -128,8 +284,12 @@ def bt_jmpbuf(jmpbuf):
         # but only works with live sessions.
         dump_backtrace_live(regs)
     except:
-        # If above doesn't work, fallback to poor man's unwind
-        dump_backtrace(regs)
+        if detailed:
+            # Obtain detailed trace by patching regs in copied coredump
+            dump_backtrace_patched(regs)
+        else:
+            # If above doesn't work, fallback to poor man's unwind
+            dump_backtrace(regs)
 
 def co_cast(co):
     return co.cast(gdb.lookup_type('CoroutineUContext').pointer())
@@ -138,28 +298,89 @@ def coroutine_to_jmpbuf(co):
     coroutine_pointer = co_cast(co)
     return coroutine_pointer['env']['__jmpbuf']
 
+def init_coredump():
+    global coredump
+
+    files = gdb.execute('info files', False, True).split('\n')
+
+    if not 'core dump' in files[1]:
+        return False
+
+    core_path = re.search("`(.*)'", files[2]).group(1)
+    exec_path = re.match('^Symbols from "(.*)".$', files[0]).group(1)
+
+    if coredump is None:
+        coredump = Coredump(core_path, exec_path)
+
+    return True
 
 class CoroutineCommand(gdb.Command):
-    '''Display coroutine backtrace'''
+    __doc__ = textwrap.dedent("""\
+        Display coroutine backtrace
+
+        Usage: qemu coroutine COROPTR [--detailed]
+        Show backtrace for a coroutine specified by COROPTR
+
+          --detailed       obtain detailed trace by copying coredump, patching
+                           regs in it, and runing gdb subprocess to get
+                           backtrace from the patched coredump
+        """)
+
     def __init__(self):
         gdb.Command.__init__(self, 'qemu coroutine', gdb.COMMAND_DATA,
                              gdb.COMPLETE_NONE)
 
+    def _usage(self):
+        gdb.write('usage: qemu coroutine <coroutine-pointer> [--detailed]\n')
+        return
+
     def invoke(self, arg, from_tty):
         argv = gdb.string_to_argv(arg)
-        if len(argv) != 1:
-            gdb.write('usage: qemu coroutine <coroutine-pointer>\n')
+        argc = len(argv)
+        if argc == 0 or argc > 2 or (argc == 2 and argv[1] != '--detailed'):
+            return self._usage()
+        detailed = True if argc == 2 else False
+
+        is_coredump = init_coredump()
+        if detailed and not is_coredump:
+            gdb.write('--detailed is only valid when debugging core dumps\n')
             return
 
-        bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])))
+        bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])),
+                  detailed=detailed)
+
+        coredump.restore_regs()
 
 class CoroutineBt(gdb.Command):
-    '''Display backtrace including coroutine switches'''
+    __doc__ = textwrap.dedent("""\
+        Display backtrace including coroutine switches
+
+        Usage: qemu bt [--detailed]
+
+          --detailed       obtain detailed trace by copying coredump, patching
+                           regs in it, and runing gdb subprocess to get
+                           backtrace from the patched coredump
+        """)
+
     def __init__(self):
         gdb.Command.__init__(self, 'qemu bt', gdb.COMMAND_STACK,
                              gdb.COMPLETE_NONE)
 
+    def _usage(self):
+        gdb.write('usage: qemu bt [--detailed]\n')
+        return
+
     def invoke(self, arg, from_tty):
+        argv = gdb.string_to_argv(arg)
+        argc = len(argv)
+        if argc > 1 or (argc == 1 and argv[0] != '--detailed'):
+            return self._usage()
+        detailed = True if argc == 1 else False
+
+        is_coredump = init_coredump()
+        if detailed and not is_coredump:
+            gdb.write('--detailed is only valid when debugging core dumps\n')
+            return
 
         gdb.execute("bt")
 
@@ -178,8 +399,10 @@ def invoke(self, arg, from_tty):
             co_ptr = co["base"]["caller"]
             if co_ptr == 0:
                 break
-            gdb.write("Coroutine at " + str(co_ptr) + ":\n")
-            bt_jmpbuf(coroutine_to_jmpbuf(co_ptr))
+            gdb.write("\nCoroutine at " + str(co_ptr) + ":\n")
+            bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), detailed=detailed)
+
+        coredump.restore_regs()
 
 class CoroutineSPFunction(gdb.Function):
     def __init__(self):
-- 
2.43.5


