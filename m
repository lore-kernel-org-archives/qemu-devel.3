Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516B5CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU5eR-00030M-4Q; Mon, 01 Jun 2026 12:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wU5eP-0002xN-5H
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wU5eN-0005st-Hb
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780331882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=At6atDiDT6k/rmPgC/cs5BeBhQG7KB7OEEHtMFlfYoE=;
 b=Bkq3BnZUlteLfMfk2AjZrnt+ns78Pev7PU28B4/iaaoZdzRBVQcHgRaNKvdlCXphtUtrTU
 ihKb6mX9Nr7UVSG5UDk/o57Tl+EYIhuamvaOBRO4os3rhulVCEoo4xnnCypmLuorcJk+ZZ
 mGeR6cz2SDrB8LTsH36yQSTUW2X9798=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-zpntn5ZUP3GDSU1114HdQA-1; Mon,
 01 Jun 2026 12:38:01 -0400
X-MC-Unique: zpntn5ZUP3GDSU1114HdQA-1
X-Mimecast-MFC-AGG-ID: zpntn5ZUP3GDSU1114HdQA_1780331880
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 758E918002CF; Mon,  1 Jun 2026 16:38:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.161])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0465119560A3; Mon,  1 Jun 2026 16:37:57 +0000 (UTC)
Date: Mon, 1 Jun 2026 18:37:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Lamprecht <t.lamprecht@proxmox.com>
Cc: qemu-block@nongnu.org, f.ebner@proxmox.com, hreitz@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] qcow2: Fix data loss on zero write with
 detect-zeroes=unmap
Message-ID: <ah21Y_fIiy23V5S7@redhat.com>
References: <20260522151318.238064-1-t.lamprecht@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522151318.238064-1-t.lamprecht@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 22.05.2026 um 17:13 hat Thomas Lamprecht geschrieben:
> Commit b8bfb1478d ("qcow2: Fix corruption on discard during write with
> COW") added a wait_for_dependencies() at the start of
> qcow2_subcluster_zeroize(). That fixes the inconsistency it set out to
> fix, but turns the lock-protected pre-check in the caller,
> qcow2_co_pwrite_zeroes(), into a stale one: the wait yields s->lock,
> so an in-flight allocating write whose QCowL2Meta is already on
> s->cluster_allocs (but whose L2 entry is not yet linked) gets to link
> its entry during the yield. When the zeroize wakes, the cluster is now
> NORMAL, and with BDRV_REQ_MAY_UNMAP the free path in zero_in_l2_slice()
> unmaps the just-written cluster, silently dropping the data write's
> payload.
> 
> This is reachable with detect-zeroes=unmap (the default for VirtIO
> disks with discard on in Proxmox VE), under which the block layer
> auto-promotes all-zero buffers to BDRV_REQ_ZERO_WRITE |
> BDRV_REQ_MAY_UNMAP. A memory-constrained Debian guest running 'apt
> full-upgrade' on such a disk reproduces it as random SIGSEGVs:
> swapped-out code pages come back as zero.
> 
> Wait for in-flight dependencies before the lock-protected check in
> qcow2_co_pwrite_zeroes(). If a write linked its L2 entry during the
> wait, the type check now fails and the block layer falls back to a
> bounce-buffered zero write that only touches the requested subrange,
> preserving the racing write's data. Promote wait_for_dependencies() to
> qcow2_wait_for_dependencies() so qcow2.c can call it.
> 
> Fixes: b8bfb1478d ("qcow2: Fix corruption on discard during write with COW")
> Cc: qemu-stable@nongnu.org
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> ---
> 
> Changes v1 -> v2:
> * improve comments (thx @Fiona)
> * add Fiona's R-b/T-b
> 
>  block/qcow2-cluster.c      | 10 +++++-----
>  block/qcow2.c              | 10 ++++++++--
>  block/qcow2.h              |  4 ++++
>  tests/qemu-iotests/046     | 23 +++++++++++++++++++++++
>  tests/qemu-iotests/046.out | 10 ++++++++++
>  5 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 8b1e80bd0b..e02fae6a0c 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1474,9 +1474,9 @@ static int coroutine_fn handle_dependencies(BlockDriverState *bs,
>      return 0;
>  }
>  
> -static void coroutine_mixed_fn wait_for_dependencies(BlockDriverState *bs,
> -                                                     uint64_t guest_offset,
> -                                                     uint64_t bytes)
> +void coroutine_mixed_fn qcow2_wait_for_dependencies(BlockDriverState *bs,
> +                                                    uint64_t guest_offset,
> +                                                    uint64_t bytes)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      QCowL2Meta *m = NULL;
> @@ -2035,7 +2035,7 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
>       * We don't need to allocate a QCowL2Meta for the discard operation because
>       * s->lock is held for the duration of the whole operation.
>       */
> -    wait_for_dependencies(bs, offset, bytes);
> +    qcow2_wait_for_dependencies(bs, offset, bytes);
>  
>      /* Caller must pass aligned values, except at image end */
>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
> @@ -2204,7 +2204,7 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
>       * We don't need to allocate a QCowL2Meta for the zeroize operation because
>       * s->lock is held for the duration of the whole operation.
>       */
> -    wait_for_dependencies(bs, offset, bytes);
> +    qcow2_wait_for_dependencies(bs, offset, bytes);
>  
>      /* If we have to stay in sync with an external data file, zero out
>       * s->data_file first. */
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 81fd299b4c..96efdd4503 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4234,10 +4234,16 @@ qcow2_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
>          }
>  
>          qemu_co_mutex_lock(&s->lock);
> -        /* We can have new write after previous check */
>          offset -= head;
>          bytes = s->subcluster_size;
> -        nr = s->subcluster_size;

I'm not sure why you changed this line. Isn't the new version of it
doing exactly the same thing as before? This makes the diff a little
more confusing than it should be.

> +        /*
> +         * Wait for in-flight allocating writes first: otherwise the type
> +         * check below could pass on UNALLOCATED while a yet-to-link_l2 write
> +         * completes during qcow2_subcluster_zeroize()'s own wait, letting the
> +         * resumed MAY_UNMAP discard the just-written data.
> +         */
> +        qcow2_wait_for_dependencies(bs, offset, bytes);
> +        nr = bytes;
>          ret = qcow2_get_host_offset(bs, offset, &nr, &off, &type);
>          if (ret < 0 ||
>              (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&

The rest looks good to me. Maybe not perfect because we're calling
qcow2_wait_for_dependencies() twice now and rely on the second instance
not doing anything any more, but I guess that's okay.

So if you agree, I'd just change the assignment of nr above back and
apply this.

Kevin


