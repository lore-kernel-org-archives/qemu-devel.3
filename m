Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA17CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 18:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH4pK-0007nC-6S; Thu, 06 Nov 2025 13:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vH4pI-0007mf-OE
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 13:35:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vH4pH-00013H-0d
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 13:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762454113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g2zBJp/fB3N8DCuOWoc3J0wwS3YBR5cPjlcdvfe9Xxs=;
 b=LfsF7JoR8sxiZ+lweQ2jgrY2Gbq4SOuVFD3DMgBJv3eEEDC87KbKjduuslALTKkKszIC/L
 QUcUaC83JGZTSsadloBMc2cr2LmMjf8vHB822nCupjnZ7XLIdz5GRUUpFblKfQIm14ZyZ+
 TK15M6JDqaXl4QOO9gvud7Eg2bdQa4o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-PL1wDoq2MriTTsYpEeOoMQ-1; Thu,
 06 Nov 2025 13:35:10 -0500
X-MC-Unique: PL1wDoq2MriTTsYpEeOoMQ-1
X-Mimecast-MFC-AGG-ID: PL1wDoq2MriTTsYpEeOoMQ_1762454109
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7187B195605C; Thu,  6 Nov 2025 18:35:09 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.91])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D89C43001E83; Thu,  6 Nov 2025 18:35:07 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:35:05 -0600
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berrange@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 5/8] qio: Let listening sockets remember their owning
 QIONetListener
Message-ID: <tbqcxj4r75324cdzbqrtvpxmaciydtwdg2gflmbtvgvt33ur55@nrrnhgg3ztjk>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-15-eblake@redhat.com>
 <3nyd5oqiiy5egwfuup4ibnw5kgb555ijshpiafax3xdjgvcy6b@a7qwjdlkpuwi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3nyd5oqiiy5egwfuup4ibnw5kgb555ijshpiafax3xdjgvcy6b@a7qwjdlkpuwi>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 05, 2025 at 02:06:06PM -0600, Eric Blake wrote:
> On Mon, Nov 03, 2025 at 02:10:56PM -0600, Eric Blake wrote:
> > Make it easier to get from the sioc listening to a single address on
> > behalf of a NetListener back to its owning object, which will be
> > beneficial in an upcoming patch that teaches NetListener how to
> > interact with AioContext.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  include/io/channel-socket.h | 1 +
> >  io/channel-socket.c         | 1 +
> >  io/net-listener.c           | 1 +
> >  3 files changed, 3 insertions(+)
> > 
> > diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> > index a88cf8b3a9f..eee686f3b4d 100644
> > --- a/include/io/channel-socket.h
> > +++ b/include/io/channel-socket.h
> > @@ -49,6 +49,7 @@ struct QIOChannelSocket {
> >      socklen_t remoteAddrLen;
> >      ssize_t zero_copy_queued;
> >      ssize_t zero_copy_sent;
> > +    struct QIONetListener *listener;
> 
> Commenting on my own patch:
> 
> After re-reading docs/devel/style.rst, I can see that this particular
> forward declaration of QIONetListener is not consistent with the
> guidelines.  I have to have a forward reference, since the style guide
> also forbids circular inclusion (net-listener.h already includes
> channel-socket.h, so channel-socket.h cannot include net-listener.h);
> but it may be better for me to move the forward reference into
> include/qemu/typedefs.h rather than inlining it how I did here.

Then again, include/qemu/typedefs.h states "For struct types used in
only a few headers, judicious use of the struct tag instead of the
typedef name is commonly preferable."

So, to keep it simpler, I'll just justify my choice in the commit message.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


