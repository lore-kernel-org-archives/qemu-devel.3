Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DA9606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fQN6kHLK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAgF-0002Qg-7x; Thu, 19 Nov 2026 17:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xUAgA-0002Q7-GG
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:32:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xUAg8-00028Z-U8
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795127548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=msep5PbqPJBrosM7lwfoq6KFWgs/BA/7Emnf/fGn1is=;
 b=fQN6kHLKTd6a5uXc6QdrwmB6iLsiNqms/AyeEgKsbYHcIxM/J2C5FSPFI9/ITb4UzZALCj
 tsDC+yzwmbuihABo8xoMbwknr905Yn0PWZZmRN2wxOlHcp1Kn9nHgSQ0NfmW7QJO4cyoYP
 wvlbKtfR/57/7e3fzGlxUp841kLT2yY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-FmaeiRFbNmWMp0bzurWDbg-1; Thu,
 19 Nov 2026 22:32:24 +0000
X-MC-Unique: FmaeiRFbNmWMp0bzurWDbg-1
X-Mimecast-MFC-AGG-ID: FmaeiRFbNmWMp0bzurWDbg_1795127543
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D50D71800344; Thu, 19 Nov 2026 22:32:22 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2BE618004F5; Thu, 19 Nov 2026 22:32:19 +0000 (UTC)
Date: Thu, 19 Nov 2026 16:32:17 -0600
From: Eric Blake <eblake@redhat.com>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net
Subject: Re: [PATCH 2/5] block: Refresh the connection before block_resize
Message-ID: <av91249yWhnS7Gri@redhat.com>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
 <20261119144632.232457-3-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119144632.232457-3-guillaume.vincke@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 03:46:29PM +0100, Guillaume Vincke wrote:
> When a network based device is not connected, there is no way for the
> backend to notify a change. For instance, the NBD client relies on lazy
> reconnection. Therefore, if an NBD backend changes size, there is
> currently no way to update the device size until at least one I/O
> operation is sent.
> 
> This patch adds the bdrv_co_refresh_connection callback to the
> BlockDriver structure so a reconnection can be forced. Considering
> nbd_co_truncate() does not perform any I/O, it also modifies the QMP
> block_resize implementation to execute the callback, if defined, before
> truncating.
> 
> No functional change.

At least not until later patches start implementing the new
callback. But overall the explanation of why this callback is useful
makes sense to me.

> 
> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
> ---
>  block/block-backend.c             | 12 ++++++++++++
>  block/io.c                        | 24 ++++++++++++++++++++++++
>  blockdev.c                        |  9 +++++++++
>  include/block/block-io.h          |  8 ++++++++
>  include/block/block_int-common.h  |  3 +++
>  include/system/block-backend-io.h |  2 ++
>  6 files changed, 58 insertions(+)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 656c0aed67..b133bb8292 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2600,6 +2600,18 @@ int coroutine_fn blk_co_truncate(BlockBackend *blk, int64_t offset, bool exact,
>      return bdrv_co_truncate(blk->root, offset, exact, prealloc, flags, errp);
>  }
>  
> +int coroutine_fn blk_co_refresh_connection(BlockBackend *blk, Error **errp)
> +{

Check out scripts/git.orderfile for a way to list the .h changes (with
the documentation) ahead of the .c changes (with the implementation).

> +++ b/blockdev.c
> @@ -2314,6 +2314,7 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
>      BlockBackend *blk;
>      BlockDriverState *bs;
>      AioContext *old_ctx;
> +    int ret;
>  
>      bs = bdrv_lookup_bs(device, node_name, &local_err);
>      if (local_err) {
> @@ -2338,6 +2339,14 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
>          return;
>      }
>  
> +    old_ctx = bdrv_co_enter(bs);
> +    ret = blk_co_refresh_connection(blk, errp);
> +    bdrv_co_leave(bs, old_ctx);
> +    if (ret < 0) {
> +        blk_co_unref(blk);
> +        return;
> +    }
> +
>      bdrv_drained_begin(bs);
>  
>      old_ctx = bdrv_co_enter(bs);

Am I missing a reason for why you add a separate bdrv_co_enter/leave
critical section prior the bdrv_drained_begin, rather than reusing the
critical section already present during the drained region?  Is it
because you want to ensure the (re-)connection is in place before the
drain can trigger IO traffic?

> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index f671476f08..5a7328fed5 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -114,6 +114,14 @@ int coroutine_fn GRAPH_RDLOCK bdrv_co_flush(BlockDriverState *bs);
>  int coroutine_fn GRAPH_RDLOCK bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
>                                                 int64_t bytes);
>  
> +/*
> + * Ensure the connection is ready to process requests by re-establishing it if
> + * closed.
> + * Returns 0 when the driver does not declare the callback.
> + */
> +int coroutine_fn GRAPH_RDLOCK bdrv_co_refresh_connection(BdrvChild *child,
> +                                                         Error **errp);

Maybe word it as "Returns 0 when ready or if driver does not declare
the callback, and -errno on failure to reconnect."

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


