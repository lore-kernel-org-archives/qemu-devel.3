Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50FDF01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUrh-0001At-36; Fri, 06 Mar 2026 08:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyUrX-00018V-Vj
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:05:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyUrV-0007yx-6p
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772802299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJ3/xJpc2vik7pXFjnyZ3yqyRbJZCzukY4HKU1BYiw8=;
 b=MG9EmHbKP3ZzEKFV4/ovMs2iHR+IuqbouJguzHQoTesP1e9oGwuCLy6Amx8H2xEO7Nohr6
 BgHAhy/S3MZd2BM0Gz4PZXAg+9aqaZLU12d2BUsgg2vLgFTh3651NGpDE8EQEiYjQFJsX8
 ok4Xb55Gk4g/nfOorNYOgNhgtfYlinE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-ICiU5OqEOZ2TTi1LkeCiAw-1; Fri,
 06 Mar 2026 08:04:58 -0500
X-MC-Unique: ICiU5OqEOZ2TTi1LkeCiAw-1
X-Mimecast-MFC-AGG-ID: ICiU5OqEOZ2TTi1LkeCiAw_1772802297
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 125C419560AD; Fri,  6 Mar 2026 13:04:57 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.210])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6B9218001FE; Fri,  6 Mar 2026 13:04:55 +0000 (UTC)
Date: Fri, 6 Mar 2026 14:04:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] block: Introduce BDRV_O_NO_DATA_{WRITE,RESIZE}
Message-ID: <aarQ9RSHeFHfsdwB@redhat.com>
References: <20260205144737.31131-1-hreitz@redhat.com>
 <20260205144737.31131-3-hreitz@redhat.com>
 <aaWfEfuBZGW4BHPD@redhat.com>
 <83ed45e5-b1f5-447a-8489-6f13edb2372c@redhat.com>
 <aahaDEON0LMkioKz@redhat.com>
 <0331f8e8-8654-45a3-9049-0d4c7b43172b@redhat.com>
 <aaq2rtctmiYgi-4y@redhat.com>
 <538cb2b6-5a4f-4927-afbf-ce4512320d21@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <538cb2b6-5a4f-4927-afbf-ce4512320d21@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

Am 06.03.2026 um 12:28 hat Hanna Czenczek geschrieben:
> On 06.03.26 12:12, Kevin Wolf wrote:
> > Am 06.03.2026 um 11:20 hat Hanna Czenczek geschrieben:
> > > On 04.03.26 17:13, Kevin Wolf wrote:
> > > > Am 04.03.2026 um 15:20 hat Hanna Czenczek geschrieben:
> > > > > On 02.03.26 15:30, Kevin Wolf wrote:
> > > > > > Am 05.02.2026 um 15:47 hat Hanna Czenczek geschrieben:
> > > > > > > Add BDS flags that prevent taking WRITE and/or RESIZE permissions on
> > > > > > > pure data (no metadata) children.  These are going to be used by qcow2
> > > > > > > during formatting, when we need write access to format the metadata
> > > > > > > file, but no write access to an external data file.  This will allow
> > > > > > > creating a qcow2 image for a raw image while the latter is currently in
> > > > > > > use by the VM.
> > > > > > > 
> > > > > > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > > > > > ---
> > > > > > >     include/block/block-common.h | 11 +++++++++++
> > > > > > >     block.c                      | 15 +++++++++++++++
> > > > > > >     2 files changed, 26 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/include/block/block-common.h b/include/block/block-common.h
> > > > > > > index c8c626daea..504f6aa113 100644
> > > > > > > --- a/include/block/block-common.h
> > > > > > > +++ b/include/block/block-common.h
> > > > > > > @@ -245,6 +245,17 @@ typedef enum {
> > > > > > >     #define BDRV_O_CBW_DISCARD_SOURCE 0x80000 /* for copy-before-write filter */
> > > > > > > +/*
> > > > > > > + * Promise not to write any data to pure (non-metadata-bearing) data storage
> > > > > > > + * children, so we don't need the WRITE permission for them.
> > > > > > > + * For image creation, formatting requires write access to the image, but not
> > > > > > > + * necessarily to its pure storage children.  This allows creating an image on
> > > > > > > + * top of an existing raw storage image that is already attached to the VM.
> > > > > > > + */
> > > > > > > +#define BDRV_O_NO_DATA_WRITE  0x100000
> > > > > > Can't we just use BDRV_O_NO_IO for this one? It is stricter because it
> > > > > > doesn't allow reading either, but I don't think image creation ever
> > > > > > requires reading from the image?
> > > > > How would qcow2 set it?  It opens the qcow2 image, so it can only set the
> > > > > flag on the qcow2 BDS (via a BlockBackend), but BDRV_O_NO_IO needs to go on
> > > > > the data-file child.  Maybe we can construct the graph manually…? It would
> > > > > be quite painful, I imagine, but I haven’t tried yet.
> > > > Why should it go on the data-file child? The child permissions are
> > > > defined by the qcow2 node. If the caller promises not to do any I/O (and
> > > > I'm fairly sure that apart from preallocation, creating the image
> > > > doesn't involve any I/O on the qcow2 node, just on the primary child),
> > > > then qcow2 doesn't need any permissions on data-file.
> > > > 
> > > > Or am I missing a reason why BDRV_O_NO_IO can't be set for the qcow2
> > > > node?
> > > First, bdrv_co_write_req_prepare() requires !BDRV_O_NO_IO and the RESIZE
> > > permission.
> > Ah, I wasn't aware that truncate requires !BDRV_O_NO_IO. It's not what I
> > would intuitively call I/O, but it's also justifiable because it changes
> > the result of reading some blocks.
> > 
> > The part where things start to feel questionable is with the way
> > qcow2_co_create() uses truncate. It doesn't actually want to truncate
> > the image (especially with an existing data file), but just allocate the
> > metadata for the full image size.
> > 
> > If the problem is just bdrv_co_write_req_prepare(), would a request flag
> > for the truncate solve it without having to introduce two global BDS
> > flags that can never be set by the user? BDRV_REQ_NO_DATA_IO or
> > something?
> 
> Oh, only one new flag.  We can drop the RESIZE flag, as you said, and make
> it !BDRV_O_RESIZE.  (If we call qcow2_co_truncate() directly, that is.)

The per-request part feels almost more important to me than having only
one flag. But yes, two separate flags for a single purpose isn't great
either, so moving to one would already be some improvement.

> Dropping that flag changes the error messages sometimes (because without
> this flag, WRITE will always imply RESIZE, so with a guest device that
> prevents concurrent resize, you will then always get RESIZE conflicts
> alongside WRITE), but that’s OK (because it’s only when you get a WRITE
> conflict anyway).
> 
> > > We could bypass this by calling qcow2_co_truncate() instead of
> > > blk_co_truncate().  Feels wrong to me to pass BDRV_O_NO_IO and
> > > !BDRV_O_RESIZE to blk_co_new_open() when we actually kind of want those
> > > things and just bypass the BB to get them, but only morally wrong. Not
> > > technically wrong.
> > > 
> > > Bigger problem: BDRV_O_NO_IO makes qcow2 skip opening the data-file
> > > altogether.  So we would need to distinguish between qemu-img info and
> > > this case somehow.
> > Do we need to have it opened, except for preallocation, which can't set
> > BDRV_O_NO_IO anyway?
> 
> Yes, for resizing it without preallocation (growing to fit).

Right. In this case, this series wouldn't set BDRV_O_NO_DATA_RESIZE
either, but it would set BDRV_O_NO_DATA_WRITE. This makes me wonder if
it would make sense...

> We could have qcow2_do_open() distinguish by checking whether the
> "data-file" option in the QDict is set and a string (a node-name), because
> if it is, it’s safe to take that existing BDS despite BDRV_O_NO_IO.

...to let qcow2_do_open() still open the data file with BDRV_O_NO_IO if
BDRV_O_RESIZE is given at the same time.

> I’m still not sure how I morally feel about passing BDRV_O_NO_IO when we do
> want to do I/O.  Yes, only metadata.  I know.  But I understand BDRV_O_NO_IO
> was introduced specifically for nothing at all, just querying image
> information.

"Just querying image information" is reading metadata. So if you include
metadata in your definition, you're already inconsistent.

For me I/O means reads, writes, discards etc. on the node. That is,
operations that actually access data. Metadata was never part of this
for me and obviously it is always accessed read-only at least because
otherwise you can't open the image. What's different here is that it's
also written to, but that's what BDRV_O_RDWR means. If you don't want to
write either data or metadata, you should just open the image read-only.

> And it works, yes – you just have to make sure you keep
> BDRV_O_RDWR in there, too, because otherwise the whole thing will be
> read-only and not work.  Feels really wrong to me, but I guess we already do
> the same thing at the end of qcow2_co_create() to flush the image, so…  Too
> late to protest now, I suppose.

Yes, that seems like the same case to me. Nothing is doing I/O on the
qcow2 node, but some metadata writes may be involved.

Kevin


