Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E89EF9002
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxoqY-0006jW-A7; Wed, 04 Mar 2026 11:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vxoqW-0006j2-2G
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vxoqU-0001zH-FT
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772640788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PePA3EoSGToggFlcdZD+7pDBcMe+mF8ho6FoB7AFscA=;
 b=MI4D0jecZEP7ckc2SINslZvc/t/wI55fo+Hep2UGSdlzMQ/OYwKmdPAkArwLf0rhtwm4OA
 WZieQf0ch3TgaBDmD5TCjabCeUJ3PXPNyAUp0eq5T1wIXLuVXIR5B736TLKAwd4z+3R8nt
 jZT7+vysjw5rJ9BEMz35YMy2jj8DA/4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-RhLB3DobOaSOQ8p35lVSmQ-1; Wed,
 04 Mar 2026 11:13:05 -0500
X-MC-Unique: RhLB3DobOaSOQ8p35lVSmQ-1
X-Mimecast-MFC-AGG-ID: RhLB3DobOaSOQ8p35lVSmQ_1772640785
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B92C1956050; Wed,  4 Mar 2026 16:13:04 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.201])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4365730002D2; Wed,  4 Mar 2026 16:13:03 +0000 (UTC)
Date: Wed, 4 Mar 2026 17:13:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] block: Introduce BDRV_O_NO_DATA_{WRITE,RESIZE}
Message-ID: <aahaDEON0LMkioKz@redhat.com>
References: <20260205144737.31131-1-hreitz@redhat.com>
 <20260205144737.31131-3-hreitz@redhat.com>
 <aaWfEfuBZGW4BHPD@redhat.com>
 <83ed45e5-b1f5-447a-8489-6f13edb2372c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83ed45e5-b1f5-447a-8489-6f13edb2372c@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 04.03.2026 um 15:20 hat Hanna Czenczek geschrieben:
> On 02.03.26 15:30, Kevin Wolf wrote:
> > Am 05.02.2026 um 15:47 hat Hanna Czenczek geschrieben:
> > > Add BDS flags that prevent taking WRITE and/or RESIZE permissions on
> > > pure data (no metadata) children.  These are going to be used by qcow2
> > > during formatting, when we need write access to format the metadata
> > > file, but no write access to an external data file.  This will allow
> > > creating a qcow2 image for a raw image while the latter is currently in
> > > use by the VM.
> > > 
> > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > ---
> > >   include/block/block-common.h | 11 +++++++++++
> > >   block.c                      | 15 +++++++++++++++
> > >   2 files changed, 26 insertions(+)
> > > 
> > > diff --git a/include/block/block-common.h b/include/block/block-common.h
> > > index c8c626daea..504f6aa113 100644
> > > --- a/include/block/block-common.h
> > > +++ b/include/block/block-common.h
> > > @@ -245,6 +245,17 @@ typedef enum {
> > >   #define BDRV_O_CBW_DISCARD_SOURCE 0x80000 /* for copy-before-write filter */
> > > +/*
> > > + * Promise not to write any data to pure (non-metadata-bearing) data storage
> > > + * children, so we don't need the WRITE permission for them.
> > > + * For image creation, formatting requires write access to the image, but not
> > > + * necessarily to its pure storage children.  This allows creating an image on
> > > + * top of an existing raw storage image that is already attached to the VM.
> > > + */
> > > +#define BDRV_O_NO_DATA_WRITE  0x100000
> > Can't we just use BDRV_O_NO_IO for this one? It is stricter because it
> > doesn't allow reading either, but I don't think image creation ever
> > requires reading from the image?
> 
> How would qcow2 set it?  It opens the qcow2 image, so it can only set the
> flag on the qcow2 BDS (via a BlockBackend), but BDRV_O_NO_IO needs to go on
> the data-file child.  Maybe we can construct the graph manually…? It would
> be quite painful, I imagine, but I haven’t tried yet.

Why should it go on the data-file child? The child permissions are
defined by the qcow2 node. If the caller promises not to do any I/O (and
I'm fairly sure that apart from preallocation, creating the image
doesn't involve any I/O on the qcow2 node, just on the primary child),
then qcow2 doesn't need any permissions on data-file.

Or am I missing a reason why BDRV_O_NO_IO can't be set for the qcow2
node?

Kevin


