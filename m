Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3641C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJwFW-0001gX-AU; Tue, 27 May 2025 11:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJwFU-0001g1-8S
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJwFQ-0001O1-PA
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748359786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CCvPT9Qh8N6WBHksbMF8yPY2VPhwxxJPUp9k1VX1H90=;
 b=a1Wb30k4hSw6S539Y9mdI1YFha+FEfVj6romVy3Uu64J80/qWK66iWC6kIZ+wi5aJWVg54
 jPCsC07lAhnOWbZRE7T87Y49J1sUW1aQflIL9edjaqm3yU27YIfmpEES9HGJtfViwAW5zd
 QYtw4XqSgzOlhJVFv32QSopSEGKXdq8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-XMg1hHCNMzWg-4xzvzttnw-1; Tue,
 27 May 2025 11:29:42 -0400
X-MC-Unique: XMg1hHCNMzWg-4xzvzttnw-1
X-Mimecast-MFC-AGG-ID: XMg1hHCNMzWg-4xzvzttnw_1748359781
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E2AF1954236; Tue, 27 May 2025 15:29:40 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.20])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4BF430001B0; Tue, 27 May 2025 15:29:34 +0000 (UTC)
Date: Tue, 27 May 2025 17:29:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v3 11/24] block: move drain outside of
 bdrv_set_backing_hd_drained()
Message-ID: <aDXaW_Xr5etQejUd@redhat.com>
References: <20250526132140.1641377-1-f.ebner@proxmox.com>
 <20250526132140.1641377-12-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526132140.1641377-12-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

Am 26.05.2025 um 15:21 hat Fiona Ebner geschrieben:
> This is part of resolving the deadlock mentioned in commit "block:
> move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".
> 
> The function bdrv_set_backing_hd_drained() holds the graph lock, so it
> is not allowed to drain. It is called by:
> 1. bdrv_set_backing_hd(), where a drained section is introduced,
>    replacing the previously present bs-specific drains.
> 2. stream_prepare(), where a drained section is introduced replacing
>    the previously present bs-specific drains.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> No changes in v3.
> 
>  block.c        | 6 ++----
>  block/stream.c | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 64db71e38d..75322789b5 100644
> --- a/block.c
> +++ b/block.c
> @@ -3569,7 +3569,6 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
>          assert(bs->backing->bs->quiesce_counter > 0);
>      }
>  
> -    bdrv_drain_all_begin();
>      ret = bdrv_set_file_or_backing_noperm(bs, backing_hd, true, tran, errp);
>      if (ret < 0) {
>          goto out;
> @@ -3578,7 +3577,6 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
>      ret = bdrv_refresh_perms(bs, tran, errp);
>  out:
>      tran_finalize(tran, ret);
> -    bdrv_drain_all_end();
>      return ret;
>  }

Do we need to update the comment for bdrv_set_backing_hd_drained()?

 * If a backing child is already present (i.e. we're detaching a node), that
 * child node must be drained.

Same as in the previous patch, this is now probably all nodes.

> @@ -3594,11 +3592,11 @@ int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
>      bdrv_graph_rdunlock_main_loop();
>  
>      bdrv_ref(drain_bs);
> -    bdrv_drained_begin(drain_bs);
> +    bdrv_drain_all_begin();
>      bdrv_graph_wrlock();
>      ret = bdrv_set_backing_hd_drained(bs, backing_hd, errp);
>      bdrv_graph_wrunlock();
> -    bdrv_drained_end(drain_bs);
> +    bdrv_drain_all_end();
>      bdrv_unref(drain_bs);

The only thing we do with drain_bs now is finding it, bdrv_ref() and
immediately bdrv_unref(). I don't think it should exist any more after
the change to drain_all.

Kevin


