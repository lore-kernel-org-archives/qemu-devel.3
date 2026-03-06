Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11140F01825
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 11:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyT73-00016q-9I; Fri, 06 Mar 2026 06:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyT72-00016T-6f
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyT70-0006UH-Jl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772795572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UdWY0qZmzIriqpnJ49S4ekcJBWrUOU9CvPB5alfzOY=;
 b=NNiUF95oJ8xYDQk/LHrvv4gZfV8psvM1ky1U0viu9hagj9VQcz5uyI0c90Inn+LE68ppSO
 73Xzv/HcorefDUiSVlaO4yZ4uokjbA3zYcDrwqiMfqMEDnkIzfpG6E6Ofv9a4MRCyFRfJD
 T85Hlod9dQwDo/nc03dIfOMzC8cq2+k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-L9wHbXSyOauhe2kn6uTNWQ-1; Fri,
 06 Mar 2026 06:12:51 -0500
X-MC-Unique: L9wHbXSyOauhe2kn6uTNWQ-1
X-Mimecast-MFC-AGG-ID: L9wHbXSyOauhe2kn6uTNWQ_1772795570
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 351861956088; Fri,  6 Mar 2026 11:12:50 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.210])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC2A31800673; Fri,  6 Mar 2026 11:12:48 +0000 (UTC)
Date: Fri, 6 Mar 2026 12:12:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] block: Introduce BDRV_O_NO_DATA_{WRITE,RESIZE}
Message-ID: <aaq2rtctmiYgi-4y@redhat.com>
References: <20260205144737.31131-1-hreitz@redhat.com>
 <20260205144737.31131-3-hreitz@redhat.com>
 <aaWfEfuBZGW4BHPD@redhat.com>
 <83ed45e5-b1f5-447a-8489-6f13edb2372c@redhat.com>
 <aahaDEON0LMkioKz@redhat.com>
 <0331f8e8-8654-45a3-9049-0d4c7b43172b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0331f8e8-8654-45a3-9049-0d4c7b43172b@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 06.03.2026 um 11:20 hat Hanna Czenczek geschrieben:
> On 04.03.26 17:13, Kevin Wolf wrote:
> > Am 04.03.2026 um 15:20 hat Hanna Czenczek geschrieben:
> > > On 02.03.26 15:30, Kevin Wolf wrote:
> > > > Am 05.02.2026 um 15:47 hat Hanna Czenczek geschrieben:
> > > > > Add BDS flags that prevent taking WRITE and/or RESIZE permissions on
> > > > > pure data (no metadata) children.  These are going to be used by qcow2
> > > > > during formatting, when we need write access to format the metadata
> > > > > file, but no write access to an external data file.  This will allow
> > > > > creating a qcow2 image for a raw image while the latter is currently in
> > > > > use by the VM.
> > > > > 
> > > > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > > > ---
> > > > >    include/block/block-common.h | 11 +++++++++++
> > > > >    block.c                      | 15 +++++++++++++++
> > > > >    2 files changed, 26 insertions(+)
> > > > > 
> > > > > diff --git a/include/block/block-common.h b/include/block/block-common.h
> > > > > index c8c626daea..504f6aa113 100644
> > > > > --- a/include/block/block-common.h
> > > > > +++ b/include/block/block-common.h
> > > > > @@ -245,6 +245,17 @@ typedef enum {
> > > > >    #define BDRV_O_CBW_DISCARD_SOURCE 0x80000 /* for copy-before-write filter */
> > > > > +/*
> > > > > + * Promise not to write any data to pure (non-metadata-bearing) data storage
> > > > > + * children, so we don't need the WRITE permission for them.
> > > > > + * For image creation, formatting requires write access to the image, but not
> > > > > + * necessarily to its pure storage children.  This allows creating an image on
> > > > > + * top of an existing raw storage image that is already attached to the VM.
> > > > > + */
> > > > > +#define BDRV_O_NO_DATA_WRITE  0x100000
> > > > Can't we just use BDRV_O_NO_IO for this one? It is stricter because it
> > > > doesn't allow reading either, but I don't think image creation ever
> > > > requires reading from the image?
> > > How would qcow2 set it?  It opens the qcow2 image, so it can only set the
> > > flag on the qcow2 BDS (via a BlockBackend), but BDRV_O_NO_IO needs to go on
> > > the data-file child.  Maybe we can construct the graph manually…? It would
> > > be quite painful, I imagine, but I haven’t tried yet.
> > Why should it go on the data-file child? The child permissions are
> > defined by the qcow2 node. If the caller promises not to do any I/O (and
> > I'm fairly sure that apart from preallocation, creating the image
> > doesn't involve any I/O on the qcow2 node, just on the primary child),
> > then qcow2 doesn't need any permissions on data-file.
> > 
> > Or am I missing a reason why BDRV_O_NO_IO can't be set for the qcow2
> > node?
> 
> First, bdrv_co_write_req_prepare() requires !BDRV_O_NO_IO and the RESIZE
> permission.

Ah, I wasn't aware that truncate requires !BDRV_O_NO_IO. It's not what I
would intuitively call I/O, but it's also justifiable because it changes
the result of reading some blocks.

The part where things start to feel questionable is with the way
qcow2_co_create() uses truncate. It doesn't actually want to truncate
the image (especially with an existing data file), but just allocate the
metadata for the full image size.

If the problem is just bdrv_co_write_req_prepare(), would a request flag
for the truncate solve it without having to introduce two global BDS
flags that can never be set by the user? BDRV_REQ_NO_DATA_IO or
something?

> We could bypass this by calling qcow2_co_truncate() instead of
> blk_co_truncate().  Feels wrong to me to pass BDRV_O_NO_IO and
> !BDRV_O_RESIZE to blk_co_new_open() when we actually kind of want those
> things and just bypass the BB to get them, but only morally wrong. Not
> technically wrong.
> 
> Bigger problem: BDRV_O_NO_IO makes qcow2 skip opening the data-file
> altogether.  So we would need to distinguish between qemu-img info and
> this case somehow.

Do we need to have it opened, except for preallocation, which can't set
BDRV_O_NO_IO anyway?

> (I also thought maybe the bdrv_co_truncate() in qcow2_co_truncate() might be
> a problem with data-file inheriting BDRV_O_NO_IO, but because
> qcow2_co_create() puts in a pre-opened BDS (without the flag set), that part
> works.)

We should probably skip truncating the data file for BDRV_REQ_NO_DATA_IO
and we want to make the image the same size as the data file anyway, no?
I don't think we have the intention to actually resize the data file, do
we?

Kevin


