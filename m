Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79F606A33D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=My83eZb1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOBLY-0002H3-HV; Tue, 03 Nov 2026 05:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOBLW-0002Gd-A2
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 05:02:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOBLU-000563-Jj
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 05:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793700143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JnW2vvaIDI9r7/GXha8d6tGjVCdRhCcTcetPJE08iwA=;
 b=My83eZb1XwfMllVtGYHKt2WWwXhqINCB1bgAQ2kDZOHQPrNma/w3jE5hxq2JaA1Z3F2XMN
 sGGnDn0C/k9K1AeSmG1cWmX9nUM+VKzYMtzzZW3DWSD5sZFWdtyPp4ljgPO60F3ry862ey
 ngZg9VyQZK37bMVgbQHpAvANrjAJ9RI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-ukBy6l_EP6y2NoApGKPaFg-1; Tue,
 03 Nov 2026 05:02:21 -0500
X-MC-Unique: ukBy6l_EP6y2NoApGKPaFg-1
X-Mimecast-MFC-AGG-ID: ukBy6l_EP6y2NoApGKPaFg_1793700140
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D9E91955BDC; Tue,  3 Nov 2026 10:02:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.52])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49C2B180029C; Tue,  3 Nov 2026 10:02:19 +0000 (UTC)
Date: Tue, 3 Nov 2026 11:02:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 1/4] block: notify the parent when a replaced child has a
 different size
Message-ID: <aumxKEG88eJAAupA@redhat.com>
References: <20260812121500.1034178-1-den@openvz.org>
 <20260812121500.1034178-2-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812121500.1034178-2-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 12.08.2026 um 14:14 hat Denis V. Lunev geschrieben:
> bdrv_replace_child_bs() swaps the node a BdrvChild points to without
> telling the parent anything about it, so a parent which tracks the size of
> its child never learns that it changed. Every other way the size of a node
> changes goes through bdrv_co_truncate(), which does notify.
> 
> The device models which care all register the same BlockDevOps hook:
> 
>   virtio-blk  resize_cb = virtio_blk_resize(), ending up in
>               virtio_notify_config()
>   ide/ahci    resize_cb = ide_resize_cb(), refreshing the cached size
>               and the IDENTIFY data
>   scsi-disk   resize_cb = scsi_disk_resize_cb(), reporting
>               CAPACITY DATA HAS CHANGED
>   xen-block   resize_cb = xen_block_resize_cb()
> 
> Only scsi-disk is really hurt by the missing notification, because it is
> the one which validates guest requests against a cached size.
> virtio_blk_sect_range_ok() and ide_sect_range_ok() both call
> blk_get_geometry() for every request, so a missing notification leaves
> those guests with a stale idea of the size but never refuses I/O which the
> node underneath can serve. check_lba_range() compares against
> SCSIDevice.max_lba, filled in by scsi_disk_reset() and updated only by the
> READ CAPACITY(10) and (16) handlers, so with nothing to make the guest
> re-read the capacity every request past the end of the old node is refused
> for the whole life of the device.
> 
> This is reachable with qom-set of the 'drive' property, which is allowed
> on a realized device, and it is silent on the host: out-of-range requests
> are answered by scsi_check_condition() and never reach
> scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and io-status
> stays 'ok'. The guest sees ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS OUT OF
> RANGE, which Linux turns into EREMOTEIO for reads as well as writes.
> 
> Emit the notification from bdrv_replace_child_bs(), so that every device
> model gets it through the path it already implements rather than any of
> them being special cased. Send it only when the size really changed, which
> keeps the callback out of the common case of a replacement by an equally
> sized node.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  block.c                      | 13 +++++++++++++
>  include/block/block_int-io.h |  3 +++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/block.c b/block.c
> index f0a6042e61..1fe66caf8d 100644
> --- a/block.c
> +++ b/block.c
> @@ -5524,9 +5524,12 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
>      Transaction *tran = tran_new();
>      g_autoptr(GSList) refresh_list = NULL;
>      BlockDriverState *old_bs = child->bs;
> +    int64_t old_len;
>  
>      GLOBAL_STATE_CODE();
>  
> +    old_len = bdrv_getlength(old_bs);
> +
>      bdrv_ref(old_bs);
>      bdrv_drained_begin(old_bs);
>      bdrv_drained_begin(new_bs);

bdrv_drained_begin() involves nested event loops. Can't old_len become
stale here? It would feel safer to query it after draining.

> @@ -5542,6 +5545,16 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
>      tran_finalize(tran, ret);
>  
>      bdrv_graph_wrunlock();
> +
> +    /* A parent caching the child size has to learn that it changed */
> +    if (ret == 0) {
> +        int64_t new_len = bdrv_getlength(new_bs);
> +
> +        if (new_len >= 0 && new_len != old_len) {
> +            bdrv_parent_cb_resize(new_bs);

This notifies other parents of the new node as well even though nothing
changed for them.

Especially since you already query old_len/new_len to avoid unnecessary
notifications, we should probably call only child->klass->resize(child)
through a coroutine wrapper here to notify only the BdrvChild that we
actually changed.

> +        }
> +    }
> +
>      bdrv_drained_end(old_bs);
>      bdrv_drained_end(new_bs);
>      bdrv_unref(old_bs);

Kevin


