Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238C5E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVq4z-0004xr-NN; Thu, 09 Jan 2025 05:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tVq4x-0004xB-Ly
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tVq4v-00078x-DJ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736419671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=554rhkk05VCeOV81WA5uAj5cSf0hSZ+1ALR22a0wo0g=;
 b=J0ewqLkEAMKBdSTnfwQuF0zJQfIBxEkkQ2tukuvTutZb68c5J29grepPYIQv36wbHMSaiB
 3xeKCDm7VA+KF1BIW4MGHvqA5nSvVkWoWqcOHV4g8mooYq9u6aUYyn6jy6cxJRJ7ucmFJR
 0mX9ZVdEgNDprbB9HiydnZwgIOH5zbQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-wqnyfWC5O3eff45NWH3B5Q-1; Thu,
 09 Jan 2025 05:47:47 -0500
X-MC-Unique: wqnyfWC5O3eff45NWH3B5Q-1
X-Mimecast-MFC-AGG-ID: wqnyfWC5O3eff45NWH3B5Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6563119560BB; Thu,  9 Jan 2025 10:47:46 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.231])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBB4530001BE; Thu,  9 Jan 2025 10:47:43 +0000 (UTC)
Date: Thu, 9 Jan 2025 11:47:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH] block-backend: protect setting block root to NULL with
 block graph write lock
Message-ID: <Z3-pTUj66O2nfqc_@redhat.com>
References: <20250108124649.333668-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108124649.333668-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am 08.01.2025 um 13:46 hat Fiona Ebner geschrieben:
> Setting blk->root is a graph change operation and thus needs to be
> protected by the block graph write lock in blk_remove_bs(). The
> assignment to blk->root in blk_insert_bs() is already protected by
> the block graph write lock.

Hm, if that's the case, then we should also enforce this in the
declaration of BlockBackend:

    BdrvChild * GRAPH_RDLOCK_PTR root;

However, this results in more compiler failures that we need to fix. You
caught the only remaining writer, but the lock is only fully effective
if all readers take it, too.

> In particular, the graph read lock in blk_co_do_flush() could
> previously not ensure that blk_bs(blk) would always return the same
> value during the locked section, which could lead to a segfault [0] in
> combination with migration [1].
> 
> From the user-provided backtraces in the forum thread [1], it seems
> like blk_co_do_flush() managed to get past the
> blk_co_is_available(blk) check, meaning that blk_bs(blk) returned a
> non-NULL value during the check, but then, when calling
> bdrv_co_flush(), blk_bs(blk) returned NULL.
> 
> [0]:
> 
> > 0  bdrv_primary_child (bs=bs@entry=0x0) at ../block.c:8287
> > 1  bdrv_co_flush (bs=0x0) at ../block/io.c:2948
> > 2  bdrv_co_flush_entry (opaque=0x7a610affae90) at block/block-gen.c:901
> 
> [1]: https://forum.proxmox.com/threads/158072
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block/block-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index c93a7525ad..9678615318 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -887,9 +887,9 @@ void blk_remove_bs(BlockBackend *blk)
>       */
>      blk_drain(blk);
>      root = blk->root;
> -    blk->root = NULL;
>  
>      bdrv_graph_wrlock();
> +    blk->root = NULL;
>      bdrv_root_unref_child(root);
>      bdrv_graph_wrunlock();
>  }

I think the 'root = blk->root' needs to be inside the locked section,
too. Otherwise blk->root could change during bdrv_graph_wrlock() (which
has a nested event loop) and root would be stale. I assume clang would
complain about this with the added GRAPH_RDLOCK_PTR.

Kevin


