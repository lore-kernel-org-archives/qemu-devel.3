Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F77606B0D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iVLoadW0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvW-0006NC-S7; Mon, 02 Nov 2026 11:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xNuvP-0006FM-UO
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xNuvL-000243-Qd
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EbcaWWIRorvKTsmIAAfsUkciQBH2sI9CP8iS9ZX1wJA=;
 b=iVLoadW0NTO7ZHDlAHMS3Hi2Z3DI0c75cIXTcN8bRCdKUFJiQSVMzPDAR6SuNHQWxpDjj6
 c0MZ3+5lfGMRug3zUQLuwpyzbAgGVY5sP36qd2ZSD/TsPHmlNsxwUJbj2JklcVQVtIuk3S
 igoATA+hDKV2YgYljrCG/smcHHqeNgU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-5uan4jgwP2KttrBqnr9jXg-1; Mon,
 02 Nov 2026 11:30:11 -0500
X-MC-Unique: 5uan4jgwP2KttrBqnr9jXg-1
X-Mimecast-MFC-AGG-ID: 5uan4jgwP2KttrBqnr9jXg_1793637010
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D3F618007E8; Mon,  2 Nov 2026 16:30:10 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E528A1956049; Mon,  2 Nov 2026 16:30:07 +0000 (UTC)
Date: Mon, 2 Nov 2026 10:30:05 -0600
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 0/4] block, scsi-disk: honour a size change on child
 replacement
Message-ID: <aui6P33zxACLgXAV@redhat.com>
References: <20260812121500.1034178-1-den@openvz.org>
 <b052d608-7dca-4100-a7dd-5d44f8529198@virtuozzo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b052d608-7dca-4100-a7dd-5d44f8529198@virtuozzo.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Fri, Oct 30, 2026 at 12:08:24PM +0100, Denis V. Lunev wrote:
> On 8/12/26 14:14, Denis V. Lunev wrote:
> > qom-set of the 'drive' property is allowed on a realized device and ends
> > up in bdrv_replace_child_bs(), which swaps the node a BdrvChild points to
> > without telling the parent anything about it. Every other way the size of
> > a node changes goes through bdrv_co_truncate(), which does notify, so a
> > device model caching the size of its child has no way to learn that it
> > changed.
> >
> > scsi-disk is the one really hurt by this. check_lba_range() validates
> > every guest request against SCSIDevice.max_lba, filled in by
> > scsi_disk_reset() and updated only by the READ CAPACITY(10) and (16)
> > handlers. Point a scsi-hd at a larger node and every request past the end
> > of the old one is refused with ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS
> > OUT OF RANGE for the whole life of the device, which Linux turns into
> > EREMOTEIO for reads as well as writes. It is silent on the host:
> > out-of-range requests are answered by scsi_check_condition() and never
> > reach scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and
> > io-status stays 'ok'. virtio-blk and ide call blk_get_geometry() for
> > every request, so they end up with a stale idea of the size but never
> > refuse I/O the node underneath can serve.
> >
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Hanna Reitz <hreitz@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Fam Zheng <fam@euphon.net>
> >
> > Denis V. Lunev (4):
> >   block: notify the parent when a replaced child has a different size
> >   scsi-disk: refresh the cached capacity from the resize callback
> >   tests/qtest/virtio-scsi: cover a replacement that changes the size
> >   tests/qemu-iotests/qom-set-drive: replace with a differently sized
> >     node
> >
> >  block.c                                    | 13 +++++
> >  hw/scsi/scsi-disk.c                        | 16 ++++--
> >  include/block/block_int-io.h               |  3 ++
> >  tests/qemu-iotests/tests/qom-set-drive     | 14 +++--
> >  tests/qemu-iotests/tests/qom-set-drive.out |  2 +
> >  tests/qtest/virtio-scsi-test.c             | 63 ++++++++++++++++++++++
> >  6 files changed, 104 insertions(+), 7 deletions(-)
> >
> >
> > base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
> ping

Looks like this one has sat for a while; while it is not directly
related to my usual NBD pulls, I'm in the middle of preparing a block
layer pull request today so I'll add this one in my queue if it passes
my testing.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


