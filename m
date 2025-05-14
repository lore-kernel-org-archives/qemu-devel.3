Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A897C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFI3g-0007qQ-9r; Wed, 14 May 2025 15:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFI36-0007jV-Qt
 for qemu-devel@nongnu.org; Wed, 14 May 2025 15:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFI32-0000of-Bf
 for qemu-devel@nongnu.org; Wed, 14 May 2025 15:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747251945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O+/5FjS6LSjdfKcTkvLmwHlB6OJyVZwXGrPhTxtoAaI=;
 b=DqyfPsC7oGG2GwOV6FPtA40jDRDSpac5k0zjjt/6yxHf03rN+iJkaZ7ddKPT93pfjMsnHH
 nODN+Nh7WbZWqtBlFdi6pM7WFHKtG59XoaLsdB+wb3VLAPa/BTsaYhNRzI/S0STsZunAaZ
 e+JoB5GyuTRFmeRmmGUsa3K+Gl0b/DQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-BCw2hJ12MrekdG1mET-PpA-1; Wed,
 14 May 2025 15:45:42 -0400
X-MC-Unique: BCw2hJ12MrekdG1mET-PpA-1
X-Mimecast-MFC-AGG-ID: BCw2hJ12MrekdG1mET-PpA_1747251941
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4E4119560B0; Wed, 14 May 2025 19:45:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.207])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01CD919560BC; Wed, 14 May 2025 19:45:35 +0000 (UTC)
Date: Wed, 14 May 2025 21:45:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 09/11] block: move drain out of bdrv_change_aio_context()
Message-ID: <aCTy3NoJE2zSY47O@redhat.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-10-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508140936.3344485-10-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
> While bdrv_drained_begin() is now marked as GRAPH_UNLOCKED, TSA is not
> able to catch a remaining instance where the function is called with
> the graph lock held in bdrv_change_aio_context(). This is because the
> call is preceded by a bdrv_graph_rdunlock_main_loop(), but for callers
> that hold the exclusive lock that does not actually release the lock.

And releasing it wouldn't be correct anyway.

> In combination with block-stream, there is a deadlock that can happen
> because of this [0]. In particular, it can happen that
> main thread              IO thread
> 1. acquires write lock
>                          in blk_co_do_preadv_part():
>                          2. have non-zero blk->in_flight
>                          3. try to acquire read lock
> 4. begin drain
> 
> Steps 3 and 4 might be switched. Draining will poll and get stuck,
> because it will see the non-zero in_flight counter. But the IO thread
> will not make any progress either, because it cannot acquire the read
> lock.
> 
> More granular draining is not trivially possible, because
> bdrv_change_aio_context() can recursively call itself e.g. via
> bdrv_child_change_aio_context().
> 
> [0]: https://lore.kernel.org/qemu-devel/73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com/
> 
> Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block.c                            | 91 ++++++++++++++++++++----------
>  block/backup.c                     |  2 +
>  block/blklogwrites.c               |  4 ++
>  block/blkverify.c                  |  2 +
>  block/block-backend.c              |  4 ++
>  block/commit.c                     |  4 ++
>  block/mirror.c                     |  5 ++
>  block/qcow2.c                      |  2 +
>  block/quorum.c                     |  4 ++
>  block/replication.c                |  7 +++
>  block/snapshot.c                   |  2 +
>  block/stream.c                     | 10 ++--
>  block/vmdk.c                       | 10 ++++
>  blockdev.c                         | 17 ++++--
>  blockjob.c                         |  6 ++
>  include/block/block-global-state.h |  8 ++-
>  tests/unit/test-bdrv-drain.c       | 18 ++++++
>  tests/unit/test-bdrv-graph-mod.c   | 10 ++++
>  18 files changed, 164 insertions(+), 42 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 10052027cd..d84ac2f394 100644
> --- a/block.c
> +++ b/block.c
> @@ -1720,12 +1720,14 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
>  open_failed:
>      bs->drv = NULL;
>  
> +    bdrv_drain_all_begin();
>      bdrv_graph_wrlock();
>      if (bs->file != NULL) {
>          bdrv_unref_child(bs, bs->file);
>          assert(!bs->file);
>      }
>      bdrv_graph_wrunlock();
> +    bdrv_drain_all_end();

I feel this patch is doing too much at once, pushing drain up three
levels to all callers of bdrv_unref_child().

Please split it, doing only one level per patch, i.e. the first patch
only marks bdrv_change_aio_context() GRAPH_RDLOCK, removes the double
locking and moves the drain (which becomes drain_all) to
bdrv_try_change_aio_context(). Then the next patch marks that one
GRAPH_RDLOCK, etc.

This will make it more obvious that each step is done correctly. For
example, checking this hunk I noticed that bdrv_unref_child() doesn't
document that child->bs must be drained, but doing everything at once,
it's not obvious if and which other functions have the same problem.

> @@ -7702,14 +7699,12 @@ static bool bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
>  }
>  
>  /*
> - * Change bs's and recursively all of its parents' and children's AioContext
> - * to the given new context, returning an error if that isn't possible.
> - *
> - * If ignore_child is not NULL, that child (and its subgraph) will not
> - * be touched.
> + * Use bdrv_try_change_aio_context() or bdrv_try_change_aio_context_locked().
>   */
> -int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
> -                                BdrvChild *ignore_child, Error **errp)
> +static int bdrv_try_change_aio_context_common(BlockDriverState *bs,
> +                                              AioContext *ctx,
> +                                              BdrvChild *ignore_child,
> +                                              Error **errp)

This is exactly the same as bdrv_try_change_aio_context_locked(), so
this should be called bdrv_try_change_aio_context_locked() and the
wrapper below should go away.

Don't forget to add TSA annotations to functions whose interface you
touch (but I already mentioned this above).

>  {
>      Transaction *tran;
>      GHashTable *visited;

I'll defer review of the rest of the patch to the next version when it's
split. As it is, it's too hard to understand where each specific change
comes from. (That is, I could probably work it out for each individual
hunk, but I'd lose the big picture of what I'm really looking at and if
the changes are complete.)

Kevin


