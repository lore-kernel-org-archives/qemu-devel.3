Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B19C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 08:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA36k-0003i3-S6; Wed, 30 Apr 2025 04:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uA36g-0003gR-FT
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:47:56 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uA36e-0006B8-HR
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:47:54 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A0E8649F7C;
 Wed, 30 Apr 2025 10:47:47 +0200 (CEST)
Message-ID: <32df0a6d-93c7-4474-bae5-2254e6c1ecd2@proxmox.com>
Date: Wed, 30 Apr 2025 10:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: [BUG, RFC] Block graph deadlock on job-dismiss
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
References: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 24.04.25 um 19:32 schrieb Andrey Drobyshev:
> So it looks like main thread is processing job-dismiss request and is
> holding write lock taken in block_job_remove_all_bdrv() (frame #20
> above).  At the same time iothread spawns a coroutine which performs IO
> request.  Before the coroutine is spawned, blk_aio_prwv() increases
> 'in_flight' counter for Blk.  Then blk_co_do_preadv_part() (frame #5) is
> trying to acquire the read lock.  But main thread isn't releasing the
> lock as blk_root_drained_poll() returns true since blk->in_flight > 0.
> Here's the deadlock.

And for the IO test you provided, it's client->nb_requests that behaves
similarly to blk->in_flight here.

The issue also reproduces easily when issuing the following QMP command
in a loop while doing IO on a device:

> void qmp_block_locked_drain(const char *node_name, Error **errp)
> {
>     BlockDriverState *bs;
> 
>     bs = bdrv_find_node(node_name);
>     if (!bs) {
>         error_setg(errp, "node not found");
>         return;
>     }
> 
>     bdrv_graph_wrlock();
>     bdrv_drained_begin(bs);
>     bdrv_drained_end(bs);
>     bdrv_graph_wrunlock();
> }

It seems like either it would be necessary to require:
1. not draining inside an exclusively locked section
or
2. making sure that variables used by drained_poll routines are only set
while holding the reader lock
?

Those seem to require rather involved changes, so a third option might
be to make draining inside an exclusively locked section possible, by
embedding such locked sections in a drained section:

> diff --git a/blockjob.c b/blockjob.c
> index 32007f31a9..9b2f3b3ea9 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -198,6 +198,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
>       * one to make sure that such a concurrent access does not attempt
>       * to process an already freed BdrvChild.
>       */
> +    bdrv_drain_all_begin();
>      bdrv_graph_wrlock();
>      while (job->nodes) {
>          GSList *l = job->nodes;
> @@ -211,6 +212,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
>          g_slist_free_1(l);
>      }
>      bdrv_graph_wrunlock();
> +    bdrv_drain_all_end();
>  }
>  
>  bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)

This seems to fix the issue at hand. I can send a patch if this is
considered an acceptable approach.

Best Regards,
Fiona


