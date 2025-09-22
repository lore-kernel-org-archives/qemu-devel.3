Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EC8CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0g2v-0001Yc-VM; Mon, 22 Sep 2025 08:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v0g2p-0001XA-O9
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v0g2j-00009e-QE
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758545599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4cxzeWe+XuuuHIat9zkBNts9uKX4iVz9TDadMszqRDM=;
 b=eSarTQdtYb7oMxDsqNowOTuPZLQvVevzIXuIb6vP0+DYxYfvzst5hKNOIrG70k7o8u5/yb
 BLn4cwoDMJBZLs12NeLtEISTkTr0LPnLmfFnM14tNHJAJTH5yIJ+xfySv5fzeco6a2/xxu
 gfEs3P1g7GVdc/fG6qvoztgQuOETTWw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-Pz3fCenSNUWis-aaeMonWQ-1; Mon,
 22 Sep 2025 08:53:15 -0400
X-MC-Unique: Pz3fCenSNUWis-aaeMonWQ-1
X-Mimecast-MFC-AGG-ID: Pz3fCenSNUWis-aaeMonWQ_1758545594
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4821B19560B5; Mon, 22 Sep 2025 12:53:14 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BA3C3000198; Mon, 22 Sep 2025 12:53:10 +0000 (UTC)
Date: Mon, 22 Sep 2025 07:53:08 -0500
From: Eric Blake <eblake@redhat.com>
To: luzhipeng <luzhipeng@cestc.cn>
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] mirror: Optimize mirroring for zero blocks in
 mirror_read_complete
Message-ID: <2pfcwex4mzczvrezsv5mmlnd5elfgg2yt5akymfe7dslksnlbr@yyjlkqoibnpb>
References: <20250922113657.391-1-luzhipeng@cestc.cn>
 <20250922113657.391-2-luzhipeng@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922113657.391-2-luzhipeng@cestc.cn>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 22, 2025 at 07:36:55PM +0800, luzhipeng wrote:
> When mirroring data blocks, detect if the read data consists entirely of
> zeros. If so, use blk_co_pwrite_zeroes() instead of regular write to
> improve performance.
> 
> Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
> ---
>  block/mirror.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

First, some minor observations:

> 
> diff --git a/block/mirror.c b/block/mirror.c
> index b344182c74..535112f65d 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -269,6 +269,33 @@ static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
>          return;
>      }
>  
> +    /* Check if the read data is all zeros */
> +    bool is_zero = true;
> +    for (int i = 0; i < op->qiov.niov; i++) {
> +        if (!buffer_is_zero(op->qiov.iov[i].iov_base,
> +                           op->qiov.iov[i].iov_len)) {

Indentation looks off here.

> +            is_zero = false;
> +            break;
> +        }
> +    }
> +
> +    /* Write to target - optimized path for zero blocks */
> +    if (is_zero) {
> +        /*
> +         * Use zero-writing interface which may:
> +         * 1. Avoid actual data transfer
> +         * 2. Enable storage-level optimizations
> +         * 3. Potentially unmap blocks (if supported)
> +         */
> +        ret = blk_co_pwrite_zeroes(s->target, op->offset,
> +                                 op->qiov.size,
> +                                 BDRV_REQ_MAY_UNMAP);

...and here.

> +    } else {
> +        /* Normal data write path */
> +        ret = blk_co_pwritev(s->target, op->offset,
> +                           op->qiov.size, &op->qiov, 0);

...here too.

> +    }
> +
>      ret = blk_co_pwritev(s->target, op->offset, op->qiov.size, &op->qiov, 0);
>      mirror_write_complete(op, ret);
>  }

Then a higher-level question.  Should we teach blk_co_pwritev() to
have a flag that ANY caller can set to request write-zero
optimizations, rather than having to open-code a check and call to
blk_co_pwrite_zeroes() at every call-site that might benefit?

Optimizing to a write zero is often nice, but using BDRV_REQ_MAY_UNMAP
may break use cases that have explicitly requested full allocation.
The more we can consolidate all of the decisions about whether or not
to use write zeroes, and whether or not to allow unmap in that
attempt, into a single common function rather than duplicated out at
every call site that might benefit, the easier it will be to maintain
the code down the road.

Thus, I'm wondering if it might be better to introduce a new BDRV_REQ_
flag for passing to blk_co_pwritev for deciding to trigger potential
write-zero optimizations.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


