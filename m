Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2D3C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJw9V-0008B4-KK; Tue, 27 May 2025 11:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJw9T-0008Ac-Lb
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJw9L-0000fB-9o
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748359405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6OZpWKPqGapm0+I4vdMB0gL0A2vP4QHiUoxzFDATlmE=;
 b=ETjlkhMFozW0HV9WMSCWBTbgeuxBum77P1AijnRKg8GVOjVYddk9+/au8PTXmCNr4FGf+C
 pXCvpQSsrw5OBFCm4KZXhh/h8+l3zZHdo143QRkfQBeSrcLBRp1SjpyPeLzlBMK4s0h2Ec
 HN9U6hxtu9icj2eS03hGLwG0cWF7oqI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-EswTORvkNASF39jm6Uyhcw-1; Tue,
 27 May 2025 11:23:19 -0400
X-MC-Unique: EswTORvkNASF39jm6Uyhcw-1
X-Mimecast-MFC-AGG-ID: EswTORvkNASF39jm6Uyhcw_1748359397
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 460501955DB5; Tue, 27 May 2025 15:23:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.20])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00B86180049D; Tue, 27 May 2025 15:23:09 +0000 (UTC)
Date: Tue, 27 May 2025 17:23:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v3 10/24] block: move drain outside of
 bdrv_attach_child_common(_abort)()
Message-ID: <aDXY29pxla27wXru@redhat.com>
References: <20250526132140.1641377-1-f.ebner@proxmox.com>
 <20250526132140.1641377-11-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526132140.1641377-11-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

Am 26.05.2025 um 15:21 hat Fiona Ebner geschrieben:
> This is part of resolving the deadlock mentioned in commit "block:
> move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".
> 
> The function bdrv_attach_child_common_abort() is used only as the
> abort callback in bdrv_attach_child_common_drv transactions, so the
> tran_finalize() calls of such transactions need to be in drained
> sections too.
> 
> All code paths are covered:
> The bdrv_attach_child_common_drv transactions are only used in
> bdrv_attach_child_common(), so it is enough to check callers of
> bdrv_attach_child_common() following the transactions.
> 
> bdrv_attach_child_common() is called by:
> 1. bdrv_attach_child_noperm(), which does not finalize the
>    transaction yet.
> 2. bdrv_root_attach_child(), where a drained section is introduced.
> 
> bdrv_attach_child_noperm() is called by:
> 1. bdrv_attach_child(), where a drained section is introduced.
> 2. bdrv_set_file_or_backing_noperm(), which does not finalize the
>    transaction yet.
> 3. bdrv_append(), where a drained section is introduced.
> 
> bdrv_set_file_or_backing_noperm() is called by:
> 1. bdrv_set_backing_hd_drained(), where a drained section is
>    introduced.
> 2. bdrv_reopen_parse_file_or_backing(), which does not finalize the
>    transaction yet. Draining the old child bs currently happens under
>    the graph lock there. This is replaced with an assertion, because
>    the drain will be moved further up to the caller.
> 
> bdrv_reopen_parse_file_or_backing() is called by:
> 1. bdrv_reopen_prepare(), which does not finalize the transaction yet.
> 
> bdrv_reopen_prepare() is called by:
> 1. bdrv_reopen_multiple(), which does finalize the transaction. It is
>    called after bdrv_reopen_queue(), which starts a drained section.
>    The drained section ends, when bdrv_reopen_queue_free() is called
>    at the end of bdrv_reopen_multiple().
> 
> This resolves all code paths.
> 
> The functions bdrv_set_backing_hd_drained(), bdrv_attach_child() and
> bdrv_root_attach_child() run under the graph lock, so they are not
> actually allowed to drain. This will be addressed in the following
> commits.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> No changes in v3.
> 
>  block.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 3aaacabf7f..64db71e38d 100644
> --- a/block.c
> +++ b/block.c
> @@ -3028,10 +3028,8 @@ static void GRAPH_WRLOCK bdrv_attach_child_common_abort(void *opaque)
>      bdrv_replace_child_noperm(s->child, NULL);
>  
>      if (bdrv_get_aio_context(bs) != s->old_child_ctx) {
> -        bdrv_drain_all_begin();
>          bdrv_try_change_aio_context_locked(bs, s->old_child_ctx, NULL,
>                                             &error_abort);
> -        bdrv_drain_all_end();
>      }
>  
>      if (bdrv_child_get_parent_aio_context(s->child) != s->old_parent_ctx) {
> @@ -3043,10 +3041,8 @@ static void GRAPH_WRLOCK bdrv_attach_child_common_abort(void *opaque)
>  
>          /* No need to visit `child`, because it has been detached already */
>          visited = g_hash_table_new(NULL, NULL);
> -        bdrv_drain_all_begin();
>          ret = s->child->klass->change_aio_ctx(s->child, s->old_parent_ctx,
>                                                visited, tran, &error_abort);
> -        bdrv_drain_all_end();
>          g_hash_table_destroy(visited);
>  
>          /* transaction is supposed to always succeed */
> @@ -3118,10 +3114,8 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
>      parent_ctx = bdrv_child_get_parent_aio_context(new_child);
>      if (child_ctx != parent_ctx) {
>          Error *local_err = NULL;
> -        bdrv_drain_all_begin();
>          int ret = bdrv_try_change_aio_context_locked(child_bs, parent_ctx, NULL,
>                                                       &local_err);
> -        bdrv_drain_all_end();
>  
>          if (ret < 0 && child_class->change_aio_ctx) {
>              Transaction *aio_ctx_tran = tran_new();
> @@ -3129,11 +3123,9 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
>              bool ret_child;
>  
>              g_hash_table_add(visited, new_child);
> -            bdrv_drain_all_begin();
>              ret_child = child_class->change_aio_ctx(new_child, child_ctx,
>                                                      visited, aio_ctx_tran,
>                                                      NULL);
> -            bdrv_drain_all_end();
>              if (ret_child == true) {
>                  error_free(local_err);
>                  ret = 0;

Should we mention in the function comment for bdrv_attach_child_common()
that all block nodes must be drained from before this functoin is called
until after the transaction is finalized?

A similar note would probably be good for all the other functions you
mention in the commit message that don't finalize the transaction yet so
that we convert them in this same patch.

> @@ -4721,6 +4719,8 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
>   * Return 0 on success, otherwise return < 0 and set @errp.
>   *
>   * @reopen_state->bs can move to a different AioContext in this function.
> + *
> + * The old child bs must be drained.
>   */
>  static int GRAPH_UNLOCKED
>  bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,

Only the old child or all nodes?

bdrv_try_change_aio_context_locked() is documented as "Called while all
bs are drained." and we call it indirectly here (which will be more
obvious when you add the comments as suggested above).

Apart from the comments, the actual code looks fine to me.

Kevin


