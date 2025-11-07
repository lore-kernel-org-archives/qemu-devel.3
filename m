Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277EFCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 08:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHIAx-0006bK-Uy; Fri, 07 Nov 2025 03:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vHIAw-0006Xi-1H
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 03:50:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vHIAs-00058l-Vi
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 03:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762505426;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Jc5QGftbuj3pl2b+IaGJdSnE9KQbW8hggB8lMTPBZ+E=;
 b=bCxYeaASGX/X2ZZK0mCQvp/KxHzJ3O/pM3TxlrxdPXf7O37l6UQqVCvEGM4nm1WWQA1Ih9
 ofHd6s9WMOlmAP4JYviKMLk/wteqMBDU+Y8xXvozEVlHNq2AEsAY8xLAwymd5lcxzBhOsZ
 ht5p0m24JZR5Es02rK+gFjyPdMw4Sbw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-JzBjvQeuP1e1qmIDy_-qXA-1; Fri,
 07 Nov 2025 03:50:22 -0500
X-MC-Unique: JzBjvQeuP1e1qmIDy_-qXA-1
X-Mimecast-MFC-AGG-ID: JzBjvQeuP1e1qmIDy_-qXA_1762505421
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FD6818002C2; Fri,  7 Nov 2025 08:50:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08D521945110; Fri,  7 Nov 2025 08:50:19 +0000 (UTC)
Date: Fri, 7 Nov 2025 08:50:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH 5/8] qio: Let listening sockets remember their owning
 QIONetListener
Message-ID: <aQ2r_Qx67zt8MMwg@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-15-eblake@redhat.com>
 <3nyd5oqiiy5egwfuup4ibnw5kgb555ijshpiafax3xdjgvcy6b@a7qwjdlkpuwi>
 <tbqcxj4r75324cdzbqrtvpxmaciydtwdg2gflmbtvgvt33ur55@nrrnhgg3ztjk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tbqcxj4r75324cdzbqrtvpxmaciydtwdg2gflmbtvgvt33ur55@nrrnhgg3ztjk>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Nov 06, 2025 at 12:35:05PM -0600, Eric Blake wrote:
> On Wed, Nov 05, 2025 at 02:06:06PM -0600, Eric Blake wrote:
> > On Mon, Nov 03, 2025 at 02:10:56PM -0600, Eric Blake wrote:
> > > Make it easier to get from the sioc listening to a single address on
> > > behalf of a NetListener back to its owning object, which will be
> > > beneficial in an upcoming patch that teaches NetListener how to
> > > interact with AioContext.
> > > 
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > ---
> > >  include/io/channel-socket.h | 1 +
> > >  io/channel-socket.c         | 1 +
> > >  io/net-listener.c           | 1 +
> > >  3 files changed, 3 insertions(+)
> > > 
> > > diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> > > index a88cf8b3a9f..eee686f3b4d 100644
> > > --- a/include/io/channel-socket.h
> > > +++ b/include/io/channel-socket.h
> > > @@ -49,6 +49,7 @@ struct QIOChannelSocket {
> > >      socklen_t remoteAddrLen;
> > >      ssize_t zero_copy_queued;
> > >      ssize_t zero_copy_sent;
> > > +    struct QIONetListener *listener;
> > 
> > Commenting on my own patch:
> > 
> > After re-reading docs/devel/style.rst, I can see that this particular
> > forward declaration of QIONetListener is not consistent with the
> > guidelines.  I have to have a forward reference, since the style guide
> > also forbids circular inclusion (net-listener.h already includes
> > channel-socket.h, so channel-socket.h cannot include net-listener.h);
> > but it may be better for me to move the forward reference into
> > include/qemu/typedefs.h rather than inlining it how I did here.
> 
> Then again, include/qemu/typedefs.h states "For struct types used in
> only a few headers, judicious use of the struct tag instead of the
> typedef name is commonly preferable."
> 
> So, to keep it simpler, I'll just justify my choice in the commit message.

I would really rather we avoided the bi-directional pointer linkage
entirely. AFAICT, this is only required because the later patch is
passing a QIOChannelSocket as the opaque data parametr for a callback.

It would be preferrable if we would instead pass a standalonme data
struct containing the QIOChannelSocket + QIONetListener, and then
avoid this back-linkage.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


