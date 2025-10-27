Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D27CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 18:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDSEs-0000w1-97; Mon, 27 Oct 2025 14:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vDSEF-0000hW-Eq
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vDSDy-00008A-4n
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761590741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqlQl71wwArtgcRzEVBElOvBZmUKW8peUZkfGghk45w=;
 b=ZJv90ufQAJ2IHImg6UK8Zb9BFTy2saj9A56lycFQAaqUb0TDKHjUmoi3TPryjm0Dzh6KoV
 yKMSp3Kanq9OyrZsHqWSabn3RYDo34ggOAkWy17yjecw9SXIqWgIh299i4Iol9rNj7XdDi
 JCfhsUp3Ba80IOIq3wmBt4xcN14bH/k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-UxVHithYOyKMAbAXAqECPg-1; Mon,
 27 Oct 2025 14:45:37 -0400
X-MC-Unique: UxVHithYOyKMAbAXAqECPg-1
X-Mimecast-MFC-AGG-ID: UxVHithYOyKMAbAXAqECPg_1761590736
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 082661800D87; Mon, 27 Oct 2025 18:45:36 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.37])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A1BC3000223; Mon, 27 Oct 2025 18:45:33 +0000 (UTC)
Date: Mon, 27 Oct 2025 19:45:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Wesley Hershberger <wesley.hershberger@canonical.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH] block: Add missing null checks during
 query-named-block-nodes
Message-ID: <aP-9yoqUzkCI_6df@redhat.com>
References: <20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com>
 <aP9BhBEUSuM0ougc@redhat.com>
 <CADzzt1B4ZwRwv+ZCWyGwyZwqScHAfKkbL2UEaujd3BJNSkMbXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADzzt1B4ZwRwv+ZCWyGwyZwqScHAfKkbL2UEaujd3BJNSkMbXg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 27.10.2025 um 17:04 hat Wesley Hershberger geschrieben:
> On Mon, Oct 27, 2025 at 4:55 AM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 24.10.2025 um 20:07 hat Wesley Hershberger geschrieben:
> >
> > Sorry, Wesley, that this turns out to be a bit more complicated! We'll
> > probably need some further discussion before we can know if or which
> > adjustments to the patch are needed.
> 
> Hi Kevin, thanks for your thoughts.
> 
> > Before I send this, I just had another thought: Why does copy-on-read
> > even drop the child in bdrv_cor_filter_drop()? Wouldn't the normal
> > mode of operation be that for a short time you have both the cor node
> > and its parent point to the same child node, and that would just work?
> > I see commit messages about conflicting node permissions (3108a15cf09 by
> > Vladimir), but I don't understand this. A filter without parents
> > shouldn't try to take any permissions.
> >
> > So another option for never letting the situation arise would be that
> > cor_filter_bs just keeps its child until it's really deleted.
> 
> It sounds like you'd be open to a patch that partially reverts 3108a15cf09?

Hm, yes and no. Primarily I'm trying to find out what our options are as
the next step. So in this case, why did we make the change back then,
and can the same problem it was supposed to solve still be solved in a
different way? If so, then yes, we can essentially revert it. But I'm
not proposing that we skip the step of understanding and just go ahead,
change the code and then wait and see what breaks.

Maybe Vladimir can remember, that would be the easiest. Otherwise, maybe
some mailing list archeology can help. If none of these lead to
anything, we'd still have to thoroughly think through the consequences
for all callers before we can conclude that changing things this way is
safe.

> In my local testing I did verify that preventing the child from being
> detached resolves the bug and am currently double-checking it with
> this diff:
> 
> diff --git a/block.c b/block.c
> index 8848e9a7ed..72261ea1d4 100644
> --- a/block.c
> +++ b/block.c
> @@ -5386,17 +5386,13 @@ bdrv_replace_node_noperm(BlockDriverState *from,
>   *
>   * With auto_skip=false the error is returned if from has a parent which should
>   * not be updated.
> - *
> - * With @detach_subchain=true @to must be in a backing chain of @from. In this
> - * case backing link of the cow-parent of @to is removed.
>   */
>  static int GRAPH_WRLOCK
>  bdrv_replace_node_common(BlockDriverState *from, BlockDriverState *to,
> -                         bool auto_skip, bool detach_subchain, Error **errp)
> +                         bool auto_skip, Error **errp)
>  {
>      Transaction *tran = tran_new();
>      g_autoptr(GSList) refresh_list = NULL;
> -    BlockDriverState *to_cow_parent = NULL;
>      int ret;
> 
>      GLOBAL_STATE_CODE();
> @@ -5405,17 +5401,6 @@ bdrv_replace_node_common(BlockDriverState
> *from, BlockDriverState *to,
>      assert(to->quiesce_counter);
>      assert(bdrv_get_aio_context(from) == bdrv_get_aio_context(to));
> 
> -    if (detach_subchain) {
> -        assert(bdrv_chain_contains(from, to));
> -        assert(from != to);
> -        for (to_cow_parent = from;
> -             bdrv_filter_or_cow_bs(to_cow_parent) != to;
> -             to_cow_parent = bdrv_filter_or_cow_bs(to_cow_parent))
> -        {
> -            ;
> -        }
> -    }
> -
>      /*
>       * Do the replacement without permission update.
>       * Replacement may influence the permissions, we should calculate new
> @@ -5427,11 +5412,6 @@ bdrv_replace_node_common(BlockDriverState
> *from, BlockDriverState *to,
>          goto out;
>      }
> 
> -    if (detach_subchain) {
> -        /* to_cow_parent is already drained because from is drained */
> -        bdrv_remove_child(bdrv_filter_or_cow_child(to_cow_parent), tran);
> -    }
> -
>      refresh_list = g_slist_prepend(refresh_list, to);
>      refresh_list = g_slist_prepend(refresh_list, from);
> 
> @@ -5450,7 +5430,7 @@ out:
>  int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
>                        Error **errp)
>  {
> -    return bdrv_replace_node_common(from, to, true, false, errp);
> +    return bdrv_replace_node_common(from, to, true, errp);
>  }
> 
>  int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
> @@ -5466,7 +5446,7 @@ int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
> 
>      bdrv_drained_begin(child_bs);
>      bdrv_graph_wrlock();
> -    ret = bdrv_replace_node_common(bs, child_bs, true, true, errp);
> +    ret = bdrv_replace_node_common(bs, child_bs, true, errp);
>      bdrv_graph_wrunlock();
>      bdrv_drained_end(child_bs);
> 
> @@ -5917,17 +5897,7 @@ int bdrv_drop_intermediate(BlockDriverState
> *top, BlockDriverState *base,
>          updated_children = g_slist_prepend(updated_children, c);
>      }
> 
> -    /*
> -     * It seems correct to pass detach_subchain=true here, but it triggers
> -     * one more yet not fixed bug, when due to nested aio_poll loop
> we switch to
> -     * another drained section, which modify the graph (for example, removing
> -     * the child, which we keep in updated_children list). So, it's a TODO.
> -     *
> -     * Note, bug triggered if pass detach_subchain=true here and run
> -     * test-bdrv-drain. test_drop_intermediate_poll() test-case will crash.
> -     * That's a FIXME.
> -     */
> -    bdrv_replace_node_common(top, base, false, false, &local_err);
> +    bdrv_replace_node_common(top, base, false, &local_err);
>      bdrv_graph_wrunlock();
> 
>      if (local_err) {
> 
> > Vladimir, do you remember what the specific problem was?
> 
> I'd be happy to submit this if Vladimir is happy that it won't cause
> other issues
> (I've run make check-block with it and saw no failures).

Ok, that's a good start at least. And I see that before commit bcc8584,
bdrv_cor_filter_drop() didn't have this detaching behaviour either, it
used plain bdrv_replace_node(). So it might actually have been
unintentional here.

The other user is bdrv_cbw_drop(), and that one did have an explicit
bdrv_set_backing_hd(bs, NULL, &error_abort); before switching to
bdrv_drop_filter() in commit b75d64b. Not sure if it was right before,
but at least it always behaved like this, and we would change it now
rather than reverting to an older state.

Let's see if others have something to say on this.

Kevin


