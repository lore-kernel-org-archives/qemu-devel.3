Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B19606A32E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FpDalizD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzbG-0000Gq-Jr; Thu, 05 Nov 2026 10:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOzbE-0000Fv-CI
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:42:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOzbC-0002MF-MB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793893317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOoyxMbvrCjPgFvhuyYFn9ubNVntLcoy5ZSXbkUdULc=;
 b=FpDalizDHBMteo4gV0dqQlV1RFsC5wrHATAE/oFhEqHS9uSLwCa8DuWmDpn83cHX8yOW+1
 24ijI9Ia7apUXaY3bRYujm6Ti6GuUPN0i9cb6f42bRz5ltRCkMuWhtMwwnMCPXRwpt/f9y
 k/ArGoZ2QVcuChkIIwDrJQSMZ976vTM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-ruLo1fn3NDa5TVOSXRv93Q-1; Thu,
 05 Nov 2026 10:41:53 -0500
X-MC-Unique: ruLo1fn3NDa5TVOSXRv93Q-1
X-Mimecast-MFC-AGG-ID: ruLo1fn3NDa5TVOSXRv93Q_1793893312
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B255E1955EB7; Thu,  5 Nov 2026 15:41:51 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.106])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC9F61848D41; Thu,  5 Nov 2026 15:41:49 +0000 (UTC)
Date: Thu, 5 Nov 2026 16:41:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 1/4] block: notify the parent when a replaced child has a
 different size
Message-ID: <auyju4uLIBaCGPKH@redhat.com>
References: <20260812121500.1034178-1-den@openvz.org>
 <20260812121500.1034178-2-den@openvz.org>
 <aumxKEG88eJAAupA@redhat.com>
 <ab8f044d-79ad-40c0-8857-50cef77b0b68@virtuozzo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab8f044d-79ad-40c0-8857-50cef77b0b68@virtuozzo.com>
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

Am 04.11.2026 um 15:50 hat Denis V. Lunev geschrieben:
> On 11/3/26 11:02, Kevin Wolf wrote:
> > Am 12.08.2026 um 14:14 hat Denis V. Lunev geschrieben:
> >> bdrv_replace_child_bs() swaps the node a BdrvChild points to without
> >> telling the parent anything about it, so a parent which tracks the size of
> >> its child never learns that it changed. Every other way the size of a node
> >> changes goes through bdrv_co_truncate(), which does notify.
> >>
> >> The device models which care all register the same BlockDevOps hook:
> >>
> >>   virtio-blk  resize_cb = virtio_blk_resize(), ending up in
> >>               virtio_notify_config()
> >>   ide/ahci    resize_cb = ide_resize_cb(), refreshing the cached size
> >>               and the IDENTIFY data
> >>   scsi-disk   resize_cb = scsi_disk_resize_cb(), reporting
> >>               CAPACITY DATA HAS CHANGED
> >>   xen-block   resize_cb = xen_block_resize_cb()
> >>
> >> Only scsi-disk is really hurt by the missing notification, because it is
> >> the one which validates guest requests against a cached size.
> >> virtio_blk_sect_range_ok() and ide_sect_range_ok() both call
> >> blk_get_geometry() for every request, so a missing notification leaves
> >> those guests with a stale idea of the size but never refuses I/O which the
> >> node underneath can serve. check_lba_range() compares against
> >> SCSIDevice.max_lba, filled in by scsi_disk_reset() and updated only by the
> >> READ CAPACITY(10) and (16) handlers, so with nothing to make the guest
> >> re-read the capacity every request past the end of the old node is refused
> >> for the whole life of the device.
> >>
> >> This is reachable with qom-set of the 'drive' property, which is allowed
> >> on a realized device, and it is silent on the host: out-of-range requests
> >> are answered by scsi_check_condition() and never reach
> >> scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and io-status
> >> stays 'ok'. The guest sees ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS OUT OF
> >> RANGE, which Linux turns into EREMOTEIO for reads as well as writes.
> >>
> >> Emit the notification from bdrv_replace_child_bs(), so that every device
> >> model gets it through the path it already implements rather than any of
> >> them being special cased. Send it only when the size really changed, which
> >> keeps the callback out of the common case of a replacement by an equally
> >> sized node.
> >>
> >> Signed-off-by: Denis V. Lunev <den@openvz.org>
> >> ---
> >>  block.c                      | 13 +++++++++++++
> >>  include/block/block_int-io.h |  3 +++
> >>  2 files changed, 16 insertions(+)
> >>
> >> diff --git a/block.c b/block.c
> >> index f0a6042e61..1fe66caf8d 100644
> >> --- a/block.c
> >> +++ b/block.c
> >> @@ -5524,9 +5524,12 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
> >>      Transaction *tran = tran_new();
> >>      g_autoptr(GSList) refresh_list = NULL;
> >>      BlockDriverState *old_bs = child->bs;
> >> +    int64_t old_len;
> >>  
> >>      GLOBAL_STATE_CODE();
> >>  
> >> +    old_len = bdrv_getlength(old_bs);
> >> +
> >>      bdrv_ref(old_bs);
> >>      bdrv_drained_begin(old_bs);
> >>      bdrv_drained_begin(new_bs);
> > bdrv_drained_begin() involves nested event loops. Can't old_len become
> > stale here? It would feel safer to query it after draining.
> I do not think it can. The only caller is blk_replace_bs(), so @child is
> the root of a device and old_len is the virtual size the device checks
> every request against. blk_check_byte_request() refuses writes past it,
> and block_resize is a coroutine QMP command, so it cannot run while the
> qom-set one does. Any size change that does happen goes through
> bdrv_co_write_req_finish(), which notifies the parents of old_bs, @child
> included, on its own.

We're operating at the node level here, not BlockBackend level, so the
node could have multiple parents. For example, in the past, surprising
changes were sometimes caused by a block job completing at the wrong
time. But you could just as well receive a truncate from an export that
is run during the drain.

> If the size could really move in the middle of a replacement, comparing
> it at this point would not make sense in the first place, no matter
> whether it is read before or after the drain.

If you perform all of the querying, the comparison and notification
within the same drained section, it should be consistent. Then you'd
either get the notification from the concurrent size change (if the size
change is run first) or from the node change (if that is first).

> >> @@ -5542,6 +5545,16 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
> >>      tran_finalize(tran, ret);
> >>  
> >>      bdrv_graph_wrunlock();
> >> +
> >> +    /* A parent caching the child size has to learn that it changed */
> >> +    if (ret == 0) {
> >> +        int64_t new_len = bdrv_getlength(new_bs);
> >> +
> >> +        if (new_len >= 0 && new_len != old_len) {
> >> +            bdrv_parent_cb_resize(new_bs);
> > This notifies other parents of the new node as well even though nothing
> > changed for them.
> >
> > Especially since you already query old_len/new_len to avoid unnecessary
> > notifications, we should probably call only child->klass->resize(child)
> > through a coroutine wrapper here to notify only the BdrvChild that we
> > actually changed.
> True, but the extra call costs nothing. The resize callback re-reads the
> size from the node: virtio-blk sends a config interrupt, scsi-disk
> raises CAPACITY DATA HAS CHANGED, and the guest finds the capacity it
> already had. A second parent on the new node also needs share-rw on both
> devices, so this is rare.

Yes, I think you can argue that additional notifications don't hurt. In
this case, we should be consistent and not compare sizes for the parent
getting its child changed either.

For a node with an existing parent, notifying this parent if, and only
if, a newly added parent experienced a size change is really strange
and will make everybody think that this code wasn't thought through.

> A dedicated coroutine wrapper for one call site does not look worth it
> to me. If you still prefer it, I will send the patch. 

You're already adding a coroutine wrapper for bdrv_co_parent_cb_resize()
in this patch, so I don't think it would be very different.

Kevin


