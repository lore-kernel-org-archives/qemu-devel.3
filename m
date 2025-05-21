Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D7CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlxt-0006M8-GR; Wed, 21 May 2025 12:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHlxr-0006KP-Bw
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHlxn-0001FP-KD
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747843598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PPTT3eclU/nkalvJntiHvG8Gke394FpZFkZBX3rTyOs=;
 b=BPpI0bTLfd5qxbzpPcNviVsGHrpeETbAExQq1VP3oW3y06dpKokuR4KBGL4p/UDozB+MPZ
 XGtvzAtqX3M85mDLTvnGzypzwjxNdX3oQcUdKf7q0qxxws+deeD5GW+ODxUHT1tm/NKNQ7
 TcU4id5xTsWKAZERm8pf1hndc2cmEWc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-odu03cxkNGSok0riR7Tujw-1; Wed,
 21 May 2025 12:06:35 -0400
X-MC-Unique: odu03cxkNGSok0riR7Tujw-1
X-Mimecast-MFC-AGG-ID: odu03cxkNGSok0riR7Tujw_1747843592
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A61261956094; Wed, 21 May 2025 16:06:31 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1874619560A7; Wed, 21 May 2025 16:06:11 +0000 (UTC)
Date: Wed, 21 May 2025 18:05:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v2 08/24] block: move drain outside of
 bdrv_change_aio_context() and mark GRAPH_RDLOCK
Message-ID: <aC35wP_tPcNzFvP9@redhat.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-9-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520103012.424311-9-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 20.05.2025 um 12:29 hat Fiona Ebner geschrieben:
> This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
> 
> Note that even if bdrv_drained_begin() would already be marked as

"if ... were already marked"

> GRAPH_UNLOCKED, TSA would not complain about the instance in
> bdrv_change_aio_context() before this change, because it is preceded
> by a bdrv_graph_rdunlock_main_loop() call. It is not correct to
> release the lock here, and in case the caller holds a write lock, it
> wouldn't actually release the lock.
> 
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
> After this change, all paths to bdrv_change_aio_context() drain:
> bdrv_change_aio_context() is called by:
> 1. bdrv_child_cb_change_aio_ctx() which is only called via the
>    change_aio_ctx() callback, see below.
> 2. bdrv_child_change_aio_context(), see below.
> 3. bdrv_try_change_aio_context(), where a drained section is
>    introduced.
> 
> The change_aio_ctx() callback is called by:
> 1. bdrv_attach_child_common_abort(), where a drained section is
>    introduced.
> 2. bdrv_attach_child_common(), where a drained section is introduced.
> 3. bdrv_parent_change_aio_context(), see below.
> 
> bdrv_child_change_aio_context() is called by:
> 1. bdrv_change_aio_context(), i.e. recursive, so being in a drained
>    section is invariant.
> 2. child_job_change_aio_ctx(), which is only called via the
>    change_aio_ctx() callback, see above.
> 
> bdrv_parent_change_aio_context() is called by:
> 1. bdrv_change_aio_context(), i.e. recursive, so being in a drained
>    section is invariant.
> 
> This resolves all code paths. Note that bdrv_attach_child_common()
> and bdrv_attach_child_common_abort() hold the graph write lock and
> callers of bdrv_try_change_aio_context() might too, so they are not
> actually allowed to drain either. This will be addressed in the
> following commits.
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
> 
> Changes in v2:
> * Split up into smaller pieces, flesh out commit messages.
> 
>  block.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 01144c895e..7148618504 100644
> --- a/block.c
> +++ b/block.c
> @@ -106,9 +106,9 @@ static void bdrv_reopen_abort(BDRVReopenState *reopen_state);
>  
>  static bool bdrv_backing_overridden(BlockDriverState *bs);
>  
> -static bool bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
> -                                    GHashTable *visited, Transaction *tran,
> -                                    Error **errp);
> +static bool GRAPH_RDLOCK
> +bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
> +                        GHashTable *visited, Transaction *tran, Error **errp);

For static functions, we should have rhe GRAPH_RDLOCK annotation both
here and in the actual definition, too.

>  /* If non-zero, use only whitelisted block drivers */
>  static int use_bdrv_whitelist;
> @@ -3040,8 +3040,10 @@ static void GRAPH_WRLOCK bdrv_attach_child_common_abort(void *opaque)
>  
>          /* No need to visit `child`, because it has been detached already */
>          visited = g_hash_table_new(NULL, NULL);
> +        bdrv_drain_all_begin();
>          ret = s->child->klass->change_aio_ctx(s->child, s->old_parent_ctx,
>                                                visited, tran, &error_abort);
> +        bdrv_drain_all_end();
>          g_hash_table_destroy(visited);
>  
>          /* transaction is supposed to always succeed */
> @@ -3122,9 +3124,11 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
>              bool ret_child;
>  
>              g_hash_table_add(visited, new_child);
> +            bdrv_drain_all_begin();
>              ret_child = child_class->change_aio_ctx(new_child, child_ctx,
>                                                      visited, aio_ctx_tran,
>                                                      NULL);
> +            bdrv_drain_all_end();
>              if (ret_child == true) {
>                  error_free(local_err);
>                  ret = 0;

Should we document in the header file that BdrvChildClass.change_aio_ctx
is called with the node drained?

We could add assertions to bdrv_child/parent_change_aio_context or at
least comments to this effect. (Assertions might be over the top because
it's easy to verify that both are only called from
bdrv_change_aio_context().)

> @@ -7619,10 +7623,6 @@ bool bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
>  static void bdrv_set_aio_context_clean(void *opaque)
>  {
>      BdrvStateSetAioContext *state = (BdrvStateSetAioContext *) opaque;
> -    BlockDriverState *bs = (BlockDriverState *) state->bs;
> -
> -    /* Paired with bdrv_drained_begin in bdrv_change_aio_context() */
> -    bdrv_drained_end(bs);
>  
>      g_free(state);
>  }
> @@ -7650,6 +7650,8 @@ static TransactionActionDrv set_aio_context = {
>   *
>   * @visited will accumulate all visited BdrvChild objects. The caller is
>   * responsible for freeing the list afterwards.
> + *
> + * @bs must be drained.
>   */
>  static bool bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
>                                      GHashTable *visited, Transaction *tran,
> @@ -7664,21 +7666,17 @@ static bool bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
>          return true;
>      }
>  
> -    bdrv_graph_rdlock_main_loop();
>      QLIST_FOREACH(c, &bs->parents, next_parent) {
>          if (!bdrv_parent_change_aio_context(c, ctx, visited, tran, errp)) {
> -            bdrv_graph_rdunlock_main_loop();
>              return false;
>          }
>      }
>  
>      QLIST_FOREACH(c, &bs->children, next) {
>          if (!bdrv_child_change_aio_context(c, ctx, visited, tran, errp)) {
> -            bdrv_graph_rdunlock_main_loop();
>              return false;
>          }
>      }
> -    bdrv_graph_rdunlock_main_loop();
>  
>      state = g_new(BdrvStateSetAioContext, 1);
>      *state = (BdrvStateSetAioContext) {
> @@ -7686,8 +7684,7 @@ static bool bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
>          .bs = bs,
>      };
>  
> -    /* Paired with bdrv_drained_end in bdrv_set_aio_context_clean() */
> -    bdrv_drained_begin(bs);
> +    assert(bs->quiesce_counter > 0);
>  
>      tran_add(tran, &set_aio_context, state);
>  
> @@ -7720,7 +7717,11 @@ int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
>      if (ignore_child) {
>          g_hash_table_add(visited, ignore_child);
>      }
> +    bdrv_drain_all_begin();
> +    bdrv_graph_rdlock_main_loop();
>      ret = bdrv_change_aio_context(bs, ctx, visited, tran, errp);
> +    bdrv_graph_rdunlock_main_loop();
> +    bdrv_drain_all_end();
>      g_hash_table_destroy(visited);

I think you're ending the drained section too early here. Previously,
the nodes were kept drained until after tran_abort/commit(), and I think
that's important (tran_commit() is the thing that actually switches the
AioContext).

Kevin


