Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A97DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 22:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGlea-0004xc-EL; Wed, 05 Nov 2025 17:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGleZ-0004xP-Do
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 17:06:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGleX-00029s-JF
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 17:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762380412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEknK60kWuIToVr5a/bhtVHLWh19eGPX/zwfkZSvRFo=;
 b=CJsNAAgNj6rXWehTbGDCXraQ7zphpNQMnFdrHu2v8DQB/l6sX817aQqyGQEfYBFUrLdRU6
 JCah0DxxC1Q8Q/xKjRIbnhsIa1aw1NXBBHgq8QJHUVD/4fgkj98jOEy52yXWflXAcE1DrF
 YaAq1i8h21ADoLQhesG5u5RHmzhGXlk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-0ZCmevIWMsKmEm8dG0toXw-1; Wed,
 05 Nov 2025 17:06:51 -0500
X-MC-Unique: 0ZCmevIWMsKmEm8dG0toXw-1
X-Mimecast-MFC-AGG-ID: 0ZCmevIWMsKmEm8dG0toXw_1762380410
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BAA5195608A; Wed,  5 Nov 2025 22:06:50 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.131])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65B5419560B2; Wed,  5 Nov 2025 22:06:48 +0000 (UTC)
Date: Wed, 5 Nov 2025 16:06:45 -0600
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH 7/8] qio: Use AioContext for default-context QIONetListener
Message-ID: <3gbdsutrugfyt4llt2f24kw36kogfj532qtxhapj2pglulnubs@ia5k2lidbsm7>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-17-eblake@redhat.com>
 <aQnlcVBqlfVMHE8I@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQnlcVBqlfVMHE8I@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

On Tue, Nov 04, 2025 at 11:37:21AM +0000, Daniel P. Berrangé wrote:
> On Mon, Nov 03, 2025 at 02:10:58PM -0600, Eric Blake wrote:
> >      for ( ; i < listener->nsioc; i++) {
> > -        listener->io_source[i] = qio_channel_add_watch_source(
> > -            QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
> > -            qio_net_listener_channel_func,
> > -            listener, NULL, listener->context);
> > +        if (listener->context) {
> > +            /*
> > +             * The user passed a GMainContext with the async callback;
> > +             * they plan on running their own g_main_loop.
> > +             */
> > +            listener->io_source[i] = qio_channel_add_watch_source(
> > +                QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
> > +                qio_net_listener_channel_func,
> > +                listener, NULL, listener->context);
> > +        } else {
> > +            /*
> > +             * The user is fine with the default context. But by doing
> > +             * it in the main thread's AioContext rather than
> > +             * specifically in a GMainContext, we can remain
> > +             * responsive even if another AioContext depends on
> > +             * connecting to this server.
> > +             */
> > +            aio_set_fd_handler(qemu_get_aio_context(), listener->sioc[i]->fd,
> > +                               qio_net_listener_aio_func, NULL, NULL, NULL,
> > +                               listener->sioc[i]);
> > +        }
> 
> I'm not really happy with the listener directly accessing the 'fd'
> fields in the QIOSocketChannel, as compared to the GSource approach
> where the underlying transport is not exposed to the caller.
> 
> If we want to use an AioContext instead of a GSource, then I think
> we need to add a method to either QIOChannelSocket, or QIOChannel
> base, as an alternative to the GSource watches, and then have the
> listener conditionally use the AioContext APIs.
> 
> 
> Also in QIOChannel base, we have a io_set_aio_fd_handler() method
> that we use elsewhere. Can we perhaps leverage that in some way.

I will explore that idea for v2.

> 
> eg, instead of taking the AioContext code path based off
> "if (listener->context)", take the code path based on whether
> the QIOChannel has had a call qio_channel_set_aio_fd_handler
> to register AIO handlers ? Maybe that method doesn't quite fit,
> but conceptually I would be more comfortable with an approach
> that explicitly associates an AioContext with either the
> channel or the listener object, rather than this heuristic
> of "if (listener->context)".

I wonder if qio_channel_set_follow_coroutine_ctx() might be the
trigger point you are thinking of. NBD code already calls this, but
only AFTER the client has connected.  Would having
ioc->follow_coroutine_ctx is a better witness that the caller
specifically wants the channel behind NetListener to run in an
AioContext, rather than blindly declaring that all NetListeners get
AioContext unless they use qio_net_listener_set_client_func_full(),
and where I change the NBD code to call follow_coroutine_ctx() sooner?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


