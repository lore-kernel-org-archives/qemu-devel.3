Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A164C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sWD-0007bd-L9; Wed, 16 Sep 2026 12:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6sW2-0007Z6-5U; Wed, 16 Sep 2026 12:29:46 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6sVz-0005RC-Uy; Wed, 16 Sep 2026 12:29:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V57RXzJN6hk8t9IeJkU6nbXtknbCQPE69WTceEQdpsc5LTN1g93qE6PosSb019OXVbScDD15h+oRg2aPy3Ho5U21h4YZwy9Y9/le4Jzftd6hMDUz8wWe+Lkv72RcqH1H2Y3WuqM1p2JTTeNudI3cPAVw5z/iR0+rVxztD8If3Wf+jSabI9xVflgap0miKzTx+zU8S5zu1Zf61H+ZMO2jTW2ih+H0dwnYM9xafJ0GNtBsEwx9h0G1diy2PdzzrN0REE9M5e/ZZsG93y445rUgK4Vvj3Zwfv81h1juSOHbM2jpVHtpKrqF9x7zWem5EKVlUUhk4sX3Mw7tlBDpJ+czvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFYKSOUKG0kjWB0UAlrcxua8Vb8dG0OgLd7wL0Gi8IE=;
 b=rdVtQbPNbIn+dUI4aOgfqGYFmeCl/3TwWSK2O4i5pcglg2R2g+v3hAnKxK+Pm81GmjTWBzVHTwzQqSOb1oABNTtPnF5pyw7pjFBQt/8PSLWYB1rCuFze645vtbHfdNeGKEqZu5r+StLnBhOeRcNBa7g34BRK7e78O/P26UQzvSU9r4bUGfSwSMJ4j+Zguc4Jb5p2MvYfkjMlOBqMbSLF/jCRHgKKdr8uAhm0vL0bi8mvvYbK/iCOoRFlFhqaBsZOTpEhHNerU8Bse7qc3myUWM0VCJEmA46XX5nYg3aQd/Xp4/CgZ/DXGUyq7U4OHFiEH7FDm/lXCz3JpiJgWcTxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFYKSOUKG0kjWB0UAlrcxua8Vb8dG0OgLd7wL0Gi8IE=;
 b=XjjQCgiu0hYn9HDllPgvheOezVPhZmPILgpsMbMOeVNWLmOFy5ZKsSEIgsSV1tjtKPGwx2gfaSuHH6kP6zwoKbSFqXbLONmyjBKMeB0YkNOb3/OUfVSV2NEt86XygB/1sBJkSwcP/SIdtjiirMEFcUncMKKkiR8ONVUOtUUyus/7LJuXku+aIEpaw4AIwrSXI+NU3z5yH4WG3IvVXh+bYOEX8QkA4fGpRm2AMLWc3UKv5F+XVM+7eiaFduWnTlpHwvvq30iKXqu/VSaGzR8fbS5CLeA9jrO86vikIu3Em4cFMhNi+EujDUkzlaxwF+92rm94/T8qbe64feO2oO2hNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by BR0PR08MB801654.eurprd08.prod.outlook.com
 (2603:10a6:2c8:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 16:29:28 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 16:29:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 9/9] block/block-copy: coalesce write-zeroes tasks
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260914145250.2792879-10-den@openvz.org>
References: <20260914145250.2792879-1-den@openvz.org>
 <20260914145250.2792879-10-den@openvz.org>
Date: Wed, 16 Sep 2026 19:29:16 +0300
Message-Id: <178957615605.653083.4507906324748620096.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIVP296CA0098.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|BR0PR08MB801654:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e84b358-a46c-406b-48c3-08df140fad95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|52116014|1800799024|366016|10067099003|6133799003|56012099006|5023799004|4143699003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: ToBlOqC4yPC5+rB8BlqXg7QC/vzIL5pG6y+kraieAWhOxgBsWiP/ZR3C43Ne8Y/apFj/c1MfV0gWoYo+K4u0bs+G3JbOMc8MQVGkp5IXwZ5lxDBCIxfSHyiJpewd9wvZOfYJTBK2WaWiz8GsatwxcC0gyP0szRI6lmOfbZ/KMIaQ1rda52Qc9t938VOvcPLnimRo4voPUueAiRSjV2e3ph0kaSzVWRAP9DG4qvvx7yR6QCulQBJ02ALh+1M7LTh57fn4E3pBJrWEni2MYBlk/RZr/RBuxy4gIhQ8rHigffcaM/+46CeElg9c8D4D4jOQuXovPcXcMszzD5YcquikzV8qccEqKC9D3LmodwdqxOsI/ShhSOeF/tYuWaeuwiWO5BhrHJpQ+wSZSfamLhc0vTuZiTN5ynRXmyZzk5v8kSWHnnsraPPQ4bQUO5p3/zfa6iFgEKVgsSdx+yeADCTLaLte6ymkynDa0rYRrdKEH0T0sTjOQhTWJ0ASigrTDv8TwqHaQ/aKeprj5LP1YjjCU3jo/LJfYt0Cjs5SYW9GoIfnMy+pD7PW3z/rao6tOpo4oArUgKQTsQ6EvHpuRpDNpzsXZLmaYEngJjaEPg0cUgMIOQo+gWXIH5AbUCNHXdfZfziqMHtI8Ol0N/ZIaUqOCW8fE7l/gH6l2qFQRPLNsLkYRNM2OAmHAVE1EXM9BomYenHK6G5pgcZZWgeNe7ynRTMxGt22IMRVD6Ln0m+ZF0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(52116014)(1800799024)(366016)(10067099003)(6133799003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhKZzcwYjJMdTNNem9hN3dZR1RxQmhVdVk2MXJaVmdNN1IxaU4zM3V5QURF?=
 =?utf-8?B?aVNLY2pvZFJaNW5nM0MxMXBZOHU1bW5XcjRRcS9IVE91YzZJM2tGMDNORDk0?=
 =?utf-8?B?dmEzMnFzOUpvbmxQSlQxUUhwK0FGckFncE1zeXA2WFllKzBLRlNxSzkxbUM0?=
 =?utf-8?B?VmNUTkV5bnp0T1VXbnhRWkhDbVNIQVdpcGpjVHVLOUZ1UXNQeEhZcW1wRVhE?=
 =?utf-8?B?WU02eVZpZW5GZUpSOXBTOEoxdTVSYTByaG8wUTZjUk1JVFIyQXpiNXRSWERn?=
 =?utf-8?B?Q1liU3VXcXU4eFU4NGxrejFYMm9PQUF0U0ZNOEdZUnNQVzBCQVFzRi90VU04?=
 =?utf-8?B?M3c4THk1QTAzVG5MZk9RcW5PQlE5d1NlWTFIRE9JVERwWUhCeGZlQis1WjZG?=
 =?utf-8?B?U1k1ajV2enljbmZWSFViZUhxUm1kdm5ZMEsvMnpscEJNS0FYVUczcFNXVDcx?=
 =?utf-8?B?MW1iVnFEMlJNS2JnVEd1K0pMS2tRdjdkTHkyVnZPb3VhMTVUeG1xS3hxYmh2?=
 =?utf-8?B?aEV3MndmOUgrMnlKanZ4VnEzR0pYTCtGM0d0MnIzNFhaUURiT21xVGFRN3Fx?=
 =?utf-8?B?L0RldllWR0N6L1EwUnFyOGc1K2tIWnlMWGgzRlRCY0JtSkUvbTdCalVZcmNa?=
 =?utf-8?B?RDRvcTB2RXRmWDhxdjZmelpnRGhSNDcvMU0vM05TS2ZvU3BOU3ROcWVuRGxs?=
 =?utf-8?B?SGJCVXhPdXJPTWhnS2dVREU5MG83c0s0Y0h5L1cvTTF0SXRBcEV3c2ZhQk0y?=
 =?utf-8?B?U2d0Q0tudkdmejBxRUQwZXZwcG1WUzNYN0oxQU0wWXJuSjd6QnV0Q3U1bmF2?=
 =?utf-8?B?UGFndXhJYWlSMEJOK04zdy9zQThlUThCKzk5M0J4czNsQ3hlaWxzcTc5Nys4?=
 =?utf-8?B?ampIMmRGSkJqQ0RKM3hWL05WRFk0UHcrUWsxYTQ0UjJhb3RxUzVYS1BZM29H?=
 =?utf-8?B?SklXd3RkcjRsQmJUYkRBeVljN3BnNEo2YzlzSmVMRHhCQWpmRTViMFl0SzVH?=
 =?utf-8?B?ZCtZYzIwRUhWRFZ0aUJsbVhkdXZqS3NDY0NGSVdBeXdKT3pMU0UvZzJLMU9C?=
 =?utf-8?B?amplUWM3R2NBNGtCZG5CN0VSNHpoVUsxbGw5YkFvaHN4OUUxWDRBSmhCL09N?=
 =?utf-8?B?Zm9xS2ZkVGR4NmlKdEpZZHRyS04vRCtIdlBFaXJneFBMNTlvd1RMQy9xTENn?=
 =?utf-8?B?Z0tIcEtFNWRxYmxzSlcxZlpvQW1xK0QyNnQvc3REQk9qS0ZRcXVNMFIyMFVp?=
 =?utf-8?B?M3VQU1JwNDJ4S2VManhxRXpRdnRwTWxVZzRjdGk1REdxYTB6d0I4MytXU21V?=
 =?utf-8?B?RWNqUm5iMjJtSEFFZWJ1eXVjQUxPR2FaSnlYYVo2Ky9MWXdzdlJKVGFsVGZK?=
 =?utf-8?B?TU5uRjI1bXJRVDQ2aXY0cXVVT0tpWk9QZkpDeXlSTGQvbGhHdGpERndxNjdV?=
 =?utf-8?B?YXlNdHZ1R1JnRzJFSWlHVkIzMlJ1Vjh1QmN0QzNZRHdUQXVWdi9pdUUwcm5L?=
 =?utf-8?B?SHFaemppVDVYTHJUc1RDN1Ewei9RS09yQUJHQm8rYXhyZks4b2FLTjVDZjB2?=
 =?utf-8?B?YU9iRGlGYUhuc1EzallyUmMxcUpPeTdUZElQeENhSENkN0pFR0RnT1ZJZWpp?=
 =?utf-8?B?RVRDZHB1SGsxbHdLOGxmMzdnOHFJM0lESGV6a1FYRG1iQzU2d1hQZ21SRVJj?=
 =?utf-8?B?RXVKM0dsaG9TWDlPWGtvVGVnbFN0azM5dUpWUFBTL1NUR056T3Z4Q2xuUHAx?=
 =?utf-8?B?RFJQOStGNXBhclh3YjNaeXVmNWhJQmFLQW93eHpOTXpRdkEvUkF1WWRrcjZO?=
 =?utf-8?B?eE5NOWNlVjN4bVpXTU9KbGdESnRYOXZGN3RYZm1qbTcrdHBqSVRUR0FucDhl?=
 =?utf-8?B?S2MrYkFxN096NkhwL1A5bUI4N1RXYVZSUlpaam55TjJSbkRYRTNRWThvRWNz?=
 =?utf-8?B?UnR0TjFRTTNoL2hZRnVXNU5BKzJhQlovSUNFTE5RaExRQ2ZQRytoM25qM25U?=
 =?utf-8?B?YTYvMzZ4YnRnVzkwVU5ScTc4WUpUbXdXYWhHN2xGVGxseUpMNHR5ek1DSkNK?=
 =?utf-8?B?cnFhWHhyc09PQ0tUR0pFSXJ4RGx2ZEpwVk9LanBXR3ovZXlUUXJ0dzk0Slo2?=
 =?utf-8?B?c0Y2K25Ob3diQ1hpZVN2ZEJDTDNJR1NGYlpoekt5Yi83WjBtdCtvUE56RGtj?=
 =?utf-8?B?UDMwMDFUVjBFamxENTdGQm1DTFkyR3dRai81UHlOVGg0d2kwMWZEZHJjajRx?=
 =?utf-8?B?TkE2WXZqZ0QxSTZlNUUrRXozd3h6TVdkMUw1TVg3dkZkMU1XVTVyeE9SNXI3?=
 =?utf-8?B?aUFLcUpjRFVMM1ptVVBTb29DTVVja2g3WSs3OFJqSncrN0tIWWlGVlB3RzJW?=
 =?utf-8?Q?M30TUJdyDAb1u+B0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e84b358-a46c-406b-48c3-08df140fad95
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 16:29:28.0412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5uKK8aXCCrSpXuC7j6fNZcWWzP+BjlB7Nvl+lRNnv2WCPjp5Ez4fKDQ0Dy52JDmTOICJzFXJBjQb+JSm4x5QuzjpgORc+1a8Mski/KzvKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR08MB801654
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

> Task size was capped to block_copy_chunk_size() regardless of method,
> which sizes a task by the copy buffer. A write-zeroes task carries no
> buffer, so that cap only splits one long known-zero run into a crowd of
> small COPY_WRITE_ZEROES tasks, each with its own request against the
> target.
> 
> block_copy_task_create() already decides from zero_bitmap how far a task
> may run, so add block_copy_widen_zero_area() to that decision: for a
> write-zeroes task, re-search the dirty area under BDRV_REQUEST_MAX_BYTES
> instead of the buffer chunk size, and let the existing clamp cut it back
> to where the zero run ends. That bound is INT_MAX rounded down to a
> sector, so it is aligned down at the use site, nothing bounding
> cluster_size. Widening is safe: an overlapping caller waits on the
> task's BlockReq via reqlist_wait_one() rather than observing it
> mid-flight.
> 
> A request that large is only cheap where the target zeroes by metadata.
> BDRV_REQ_NO_FALLBACK in supported_zero_flags rules out the targets which
> cannot, qcow2 v2 and iscsi among them, but it is optimistic for the rest:
> file-posix advertises it at open and only learns from a failing
> fallocate. So the first widened request also asks for it, which costs
> nothing when the target obliges and fails without writing when it does
> not. The run then keeps every write-zeroes request at the buffer chunk
> size, and the range that found out is written in those chunks.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/block/block-copy.c b/block/block-copy.c
> index c0a33599384..16f3d048195 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -38,6 +38,12 @@
>  #define BLOCK_COPY_SLICE_TIME 100000000ULL /* ns */
>  #define BLOCK_COPY_CLUSTER_SIZE_DEFAULT (1 << 16)
>  
> +typedef enum {
> +    ZERO_WIDEN_UNPROBED,
> +    ZERO_WIDEN_ON,
> +    ZERO_WIDEN_OFF,
> +} BlockCopyZeroWiden;
> +
>  typedef enum {
>      COPY_READ_WRITE_CLUSTER,
>      COPY_READ_WRITE,
> @@ -159,6 +165,8 @@ typedef struct BlockCopyState {
>      bool skip_unallocated; /* atomic */
>      /* State fields that use a thread-safe API */
>      BdrvDirtyBitmap *copy_bitmap;
> +    /* Whether the target zeroes by metadata; see block_copy_write_zeroes(). */
> +    BlockCopyZeroWiden zero_widen; /* atomic */
>      /* Clusters reading as zero; allocated on demand, frozen once valid. */
>      HBitmap *zero_bitmap;
>      /* Published only after the scan, with skip_unallocated already false. */
> @@ -187,6 +195,34 @@ static int64_t block_copy_chunk_size(BlockCopyState *s)
>      }
>  }
>  
> +/*
> + * A write-zeroes task carries no buffer, so it may cover far more than
> + * block_copy_chunk_size(). Return how far it may run; the caller clamps it
> + * to where the zero run ends.
> + */
> +static int64_t block_copy_widen_zero_area(BlockCopyState *s,
> +                                          BlockCopyCallState *call_state,
> +                                          int64_t offset, int64_t search_end,
> +                                          int64_t bytes)
> +{
> +    int64_t aligned = QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
> +                                      s->cluster_size);
> +    int64_t zero_chunk = MIN_NON_ZERO(MAX(aligned, s->cluster_size),
> +                                      call_state->max_chunk);
> +    int64_t wide_offset, wide_bytes;
> +
> +    if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap, offset, search_end,
> +                                           zero_chunk, &wide_offset,
> +                                           &wide_bytes)) {
> +        return bytes;
> +    }
> +
> +    /* @offset is dirty, so the search cannot have moved past it. */
> +    assert(wide_offset == offset);
> +
> +    return wide_bytes;
> +}
> +
>  /*
>   * Search for the first dirty area in offset/bytes range and create task at
>   * the beginning of it.
> @@ -198,6 +234,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
>      BlockCopyTask *task;
>      BlockCopyMethod method;
>      int64_t max_chunk;
> +    int64_t search_end = offset + bytes;
>  
>      QEMU_LOCK_GUARD(&s->lock);
>      max_chunk = MIN_NON_ZERO(block_copy_chunk_size(s), call_state->max_chunk);
> @@ -219,6 +256,10 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
>  
>          if (hbitmap_get(s->zero_bitmap, offset)) {
>              method = COPY_WRITE_ZEROES;
> +            if (qatomic_read(&s->zero_widen) != ZERO_WIDEN_OFF) {

There's a potential race here.  Imagine:

  1) task A is created and widened here;
  2) task B is created and widened here;
  3) in block_copy_write_zeroes() we get -ENOTSUP on task A and
     set zero_widen=OFF.
  4) in block_copy_write_zeroes() OFF != UNPROBED, we skip the probing
     and go via slow path.

The race is minor, but still.  Maybe we don't need tristate enum here
and might just make zero_widen a bool, so every fast-path request
carries NO_FALLBACK (not just the 1st request)?

> +                bytes = block_copy_widen_zero_area(s, call_state, offset,
> +                                                   search_end, bytes);
> +            }
>              boundary = hbitmap_next_zero(s->zero_bitmap, offset, bytes);
>          } else {
>              boundary = hbitmap_next_dirty(s->zero_bitmap, offset, bytes);
> @@ -465,6 +506,8 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>          .max_transfer = QEMU_ALIGN_DOWN(
>                                      block_copy_max_transfer(source, target),
>                                      cluster_size),
> +        .zero_widen = target->bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK ?
> +                      ZERO_WIDEN_UNPROBED : ZERO_WIDEN_OFF,
>      };
>  
>      s->discard_source = discard_source;
> @@ -521,6 +564,54 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
>      return 0;
>  }
>  
> +/*
> + * Widening a write-zeroes request only pays off where the target zeroes by
> + * metadata. Ask the first one to fail instead of falling back to writing the
> + * zeroes out: it then costs nothing, and a target which would have written
> + * them keeps its requests small for the rest of the run.
> + */
> +static int coroutine_fn GRAPH_RDLOCK
> +block_copy_write_zeroes(BlockCopyState *s, int64_t offset, int64_t bytes,
> +                        bool *error_is_read)
> +{
> +    BdrvRequestFlags flags = s->write_flags & ~BDRV_REQ_WRITE_COMPRESSED;
> +    int64_t chunk = bytes;
> +    int ret = 0;
> +
> +    if (qatomic_read(&s->zero_widen) == ZERO_WIDEN_UNPROBED) {
> +        ret = bdrv_co_pwrite_zeroes(s->target, offset, bytes,
> +                                    flags | BDRV_REQ_NO_FALLBACK);
> +        if (ret != -ENOTSUP) {

And what if it's -EIO?  Why not 'if (ret == 0)'?

> +            qatomic_set(&s->zero_widen, ZERO_WIDEN_ON);
> +            goto out;
> +        }
> +
> +        /* Nothing has been written, so the whole range is still to do. */
> +        qatomic_set(&s->zero_widen, ZERO_WIDEN_OFF);
> +        chunk = block_copy_chunk_size(s);

block_copy_chunk_size() own doc says "Called with lock held", but we
aren't doing so here.  Should we?

Andrey

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

