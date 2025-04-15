Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8350C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 10:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4dQO-0001AC-4j; Tue, 15 Apr 2025 06:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4dQL-00019f-7F
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4dQI-0000Mb-6M
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744712504;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VKz5OPnmfbm6rsGrDguBLC1DxQ0Sz4er20nZdgQFiug=;
 b=IQN5ls/+4T+ZLtmYm/L+5/2KvRjGWXDq6h3l7uossX4N2CpEQhzhWlSbFitIiefpb4etHI
 uxz+7u2ui3LCM/C+QxsxwqyZAqhCspgNQdHgrYFUe0RyFz4tlEy83ell+Uyb5eI5qEgpT0
 ZJ7GEShMdF1r8WUqRZ2L88LtkvdGw4g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-udFXNEH0Ovupu7XXIPgAGg-1; Tue,
 15 Apr 2025 06:21:42 -0400
X-MC-Unique: udFXNEH0Ovupu7XXIPgAGg-1
X-Mimecast-MFC-AGG-ID: udFXNEH0Ovupu7XXIPgAGg_1744712501
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EF651954B33; Tue, 15 Apr 2025 10:21:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E518519560AD; Tue, 15 Apr 2025 10:21:38 +0000 (UTC)
Date: Tue, 15 Apr 2025 11:21:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Marco Cavenati <Marco.Cavenati@eurecom.fr>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
Message-ID: <Z_4zL4y0UbmLJTsP@redhat.com>
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 04, 2025 at 01:49:44PM +0530, Prasad Pandit wrote:
> On Thu, 27 Mar 2025 at 20:03, Marco Cavenati <Marco.Cavenati@eurecom.fr> wrote:
> > Enable the use of the mapped-ram migration feature with savevm/loadvm
> > snapshots by adding the QIO_CHANNEL_FEATURE_SEEKABLE feature to
> > QIOChannelBlock. Implement io_preadv and io_pwritev methods to provide
> > positioned I/O capabilities that don't modify the channel's position
> > pointer.
> >
> >  migration/channel-block.c | 48 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > +++ b/migration/channel-block.c
> > @@ -30,6 +30,7 @@ qio_channel_block_new(BlockDriverState *bs)
> >      QIOChannelBlock *ioc;
> >
> >      ioc = QIO_CHANNEL_BLOCK(object_new(TYPE_QIO_CHANNEL_BLOCK));
> > +    qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SEEKABLE);
> >
> 
> * IIUC, when _FEATURE_SEEKABLE is set, the channel I/O sequence
> eventually makes underlying preadv(2)/pwritev(2) calls, which use
> lseek(2) to adjust the stream r/w pointer with the given offset,
> before doing the r/w operation.
> 
> * QIOChannelBlock has '.io_seek' routine corresponding to the lseek(2)
> call. It is not clear how setting QIO_CHANNEL_FEATURE_SEEKABLE helps
> for QIOChannelBlock streams.

In QIOChanel API specification, having QIO_CHANNEL_FEATURE_SEEKABLE
set is a pre-requisite for use of qio_channel_{pread,preadv,pwrite,pwritev}.

It is actually NOT really connected to lseek, and as such
QIO_CHANNEL_FEATURE_SEEKABLE is probably a bad choice of name
in retrospect.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


