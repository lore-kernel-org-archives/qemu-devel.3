Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837B5C3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFE7-00087R-9w; Wed, 14 May 2025 12:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFF5d-00086C-EO
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFF5b-00032K-Iz
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747240575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e+yg5Ju1msM+o5euJhiZhQls6mQwVa5lB2gNcOVCXEc=;
 b=L3aW9nYscT20BoVYG+UZCqU31zFkmLN+T5twZjxnIlyCjmXYgIpfB44ZnuiK1nFOmNmzbS
 Cuy4OWCFLW4yv7x8dn/jIUvfJjzpu/iVsvln+QIu3W0OkhKCk6q0zAKdvug0bIHA6YmZS+
 YiEyxFtaSVTdcGNFNEx8Uthts9FzRK0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520--_D4wNzkOfazqIfd-7cvQg-1; Wed,
 14 May 2025 12:36:11 -0400
X-MC-Unique: -_D4wNzkOfazqIfd-7cvQg-1
X-Mimecast-MFC-AGG-ID: -_D4wNzkOfazqIfd-7cvQg_1747240569
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAE9E180098E; Wed, 14 May 2025 16:36:08 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF84F19560AD; Wed, 14 May 2025 16:36:04 +0000 (UTC)
Date: Wed, 14 May 2025 18:36:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 02/11] block: move drain outside of read-locked
 bdrv_reopen_queue_child()
Message-ID: <aCTGceRCQ4bywHx5@redhat.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-3-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508140936.3344485-3-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
> This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
> 
> More granular draining is not trivially possible, because
> bdrv_reopen_queue_child() can recursively call itself.

Yeah, we would have to collect the affected nodes first and only then do
whatever the draining is needed for. And consider that draining could
invalidate the list of nodes so that we would have to start over...

Draining only selectively was probably premature optimisation anyway.

> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 33f78dbe1c..0085dbfa74 100644
> --- a/block.c
> +++ b/block.c
> @@ -4358,7 +4358,7 @@ bdrv_recurse_has_child(BlockDriverState *bs, BlockDriverState *child)
>   * returns a pointer to bs_queue, which is either the newly allocated
>   * bs_queue, or the existing bs_queue being used.
>   *
> - * bs is drained here and undrained by bdrv_reopen_queue_free().
> + * bs needs to be drained
>   */
>  static BlockReopenQueue * GRAPH_RDLOCK
>  bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
> @@ -4368,6 +4368,7 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
>                          bool keep_old_opts)
>  {
>      assert(bs != NULL);
> +    assert(qatomic_read(&bs->quiesce_counter) > 0);

BlockDriverState.quiesce_counter isn't accessed with atomics elsewhere.
Did you confuse it with BlockBackend.quiesce_counter?

>  
>      BlockReopenQueueEntry *bs_entry;
>      BdrvChild *child;
> @@ -4377,13 +4378,6 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
>  
>      GLOBAL_STATE_CODE();
>  
> -    /*
> -     * Strictly speaking, draining is illegal under GRAPH_RDLOCK. We know that
> -     * we've been called with bdrv_graph_rdlock_main_loop(), though, so it's ok
> -     * in practice.
> -     */
> -    bdrv_drained_begin(bs);
> -
>      if (bs_queue == NULL) {
>          bs_queue = g_new0(BlockReopenQueue, 1);
>          QTAILQ_INIT(bs_queue);
> @@ -4522,6 +4516,14 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
>                                      QDict *options, bool keep_old_opts)
>  {
>      GLOBAL_STATE_CODE();
> +
> +    if (bs_queue == NULL) {
> +        /*
> +         * paired with bdrv_drain_all_end() in bdrv_reopen_queue_free().
> +         */
> +        bdrv_drain_all_begin();

Having this comment is a good idea. It fits on a single line, though.

> +    }
> +
>      GRAPH_RDLOCK_GUARD_MAINLOOP();
>  
>      return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, 0, false,
> @@ -4534,12 +4536,16 @@ void bdrv_reopen_queue_free(BlockReopenQueue *bs_queue)
>      if (bs_queue) {
>          BlockReopenQueueEntry *bs_entry, *next;
>          QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
> -            bdrv_drained_end(bs_entry->state.bs);
>              qobject_unref(bs_entry->state.explicit_options);
>              qobject_unref(bs_entry->state.options);
>              g_free(bs_entry);
>          }
>          g_free(bs_queue);
> +
> +        /*
> +         * paired with bdrv_drain_all_begin() in bdrv_reopen_queue().
> +         */
> +        bdrv_drain_all_end();

This could be a single line comment, too.

Kevin


