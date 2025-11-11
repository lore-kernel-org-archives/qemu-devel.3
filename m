Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503D4CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 19:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vItlB-000223-UP; Tue, 11 Nov 2025 14:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vItkO-000166-BV
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 14:09:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vItkH-0005Iq-NS
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 14:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762888177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3UsL0H1kyXSw6Xzhv6XxuKj6niP5blI0HQABW2/V/Hk=;
 b=fFx05gS17jz0uHbjpKXV9JcNh8AcIvHr48oBpgVbkNf13FqRd+d/r3OAPqTRNwW+XJ64Sg
 yvjguosrPOHm+NcBu4FYuLmu/72G+0M3tTUANA5rjBQjJeovFw9mTqM6T+cGsboTFkOuDW
 sM3Q4ZGKJiQ7BkAmLvPuj5LFylZdCNo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-H9qGKzN9PQm8paY7x0P64g-1; Tue,
 11 Nov 2025 14:09:30 -0500
X-MC-Unique: H9qGKzN9PQm8paY7x0P64g-1
X-Mimecast-MFC-AGG-ID: H9qGKzN9PQm8paY7x0P64g_1762888169
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30A57195606C; Tue, 11 Nov 2025 19:09:29 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38AEB1800576; Tue, 11 Nov 2025 19:09:27 +0000 (UTC)
Date: Tue, 11 Nov 2025 13:09:24 -0600
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH 6/8] qio: Hoist ref of listener outside loop
Message-ID: <adhktitqm6c2xcfjbduexpe4kltzactcyaz4cwzjks64jekqbu@jx7txlcer7do>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-16-eblake@redhat.com>
 <aQnf7AVY17zEKl84@redhat.com>
 <wscvm5qo2muser5hiwwl5wrvesuzacifdpgkh33shodxvltdas@lidjzqixmqpv>
 <aRNLhP_FdMtPfzvG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRNLhP_FdMtPfzvG@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 11, 2025 at 02:43:16PM +0000, Daniel P. Berrangé wrote:
> > > > Hoisting the reference like this will make it easier for an upcoming
> > > > patch to still ensure the listener cannot be prematurely garbage
> > > > collected during the user's callback, even when the callback no longer
> > > > uses a per-sioc GSource.
> > > 
> > > It isn't quite this simple. Glib reference counts the callback
> > > func / data, holding a reference when dispatching the callback.
> > > 
> > > IOW, even if the GSource is unrefed, the callback 'notify'
> > > function won't be called if the main loop is in the process
> > > of dispatching.
> > 
> > I'm not sure I follow your argument.  Glib holds a reference on the
> > GSource object, not on the opaque data that is handed to the GSource.
> > It is possible to use g_source_set_callback_indirect() where GSource
> > can learn how to use the same reference counting on data as external
> > code, by the use of function pointers for ref and unref, but QIO uses
> > merely g_source_set_callback().
> > https://gitlab.gnome.org/GNOME/glib/-/blob/main/glib/gmain.c#L1844
> > shows that glib then wraps that opaque pointer into an internal
> > GSourceCallback object which itself is reference counted, so that the
> > notify function is not called until the GSource is finalized, but that
> > is reference counting on the container, not on the opaque object
> > itself (which in this patch is the QIONetListener).
> > 
> > > 
> > > With this change, the reference on 'listener' can now be
> > > released even if the callback is currently dispatching.
> > 
> > So if I'm understanding your concern, you're worried that the unwatch
> > code can finish looping through the g_source_destroy and then reach
> > the point where it unrefs listener, but that a late-breaking client
> > connection can trigger a callback that can still be executing in
> > another thread/coroutine after the listener is unref'ed but before the
> > GSource has been finalized?  If so, would squashing this in fix the
> > problem you are seeing?
> 
> Consider the following scenario, where we have two threads, one
> is calling QIONetListener APIs, and one is the event thread.
> 
> In the current code, when we unref() the GSource for the socket
> watch, the destroy-notify does not get called, because the
> event thread is in the middle of a dispatch callback for the
> I/O event.  When the dispatch callback returns control to the
> event loop, the GSourceCallback is unrefed, and this triggers
> the destroy-notify call, which unrefs the listener.
> 
> The flow looks like this:
> 
>   Thread 1:
>        qio_net_listener_set_client_func(lstnr, f, ...);
>            => foreach sock: socket
>                => object_ref(lstnr)
>                => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, object_unref);
> 
>   Thread 2:
>        poll()
>           => event POLLIN on socket
>                => ref(GSourceCallback)
>                => call dispatch(sock)
>                     ...do stuff..
> 
>   Thread 1:
>        qio_net_listener_set_client_func(lstnr, NULL, ...);
>           => foreach sock: socket
>                => g_source_unref(sock_src)
>        unref(lstnr)  (the final reference)
>           => finalize(lstnr)

If I understand correctly, _this_ unref(lstnr) is NOT the final
reference, because of the additional reference still owned by the
GSource that is still dispatching, so finalize(lstnr) is not reached
here...

> 
>   Thread 2:
>               => return dispatch(sock)
>               => unref(GSourceCallback)
>                   => destroy-notify
>                      => object_unref

...but instead here.  And that is the desirable property of the
pre-patch behavior with a per-GSource reference on the listsner object
- we are guaranteed that listener can't be finalized while there are
any pending dispatch in flight, even if the caller has unref'd their
last mention of lstnr, and therefore the dispatch never has a
use-after-free.

> 
> 
> 
> > diff --git i/io/net-listener.c w/io/net-listener.c
> > index 9f4e3c0be0c..1fcbbeb7a76 100644
> > --- i/io/net-listener.c
> > +++ w/io/net-listener.c
> > @@ -67,8 +67,10 @@ static void qio_net_listener_aio_func(void *opaque)
> >  {
> >      QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(opaque);
> > 
> > +    object_ref(OBJECT(sioc->listener));
> >      qio_net_listener_channel_func(QIO_CHANNEL(sioc), G_IO_IN,
> >                                    sioc->listener);
> > +    object_unref(OBJECT(sioc->listener));
> >  }
> 
> Now consider this patch, plus this extra hunk...
> 
>   Thread 1:
>        qio_net_listener_set_client_func(lstnr, f, ...);
>            => object_ref(listener)
>            => foreach sock: socket
>                => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, NULL);
> 
>   Thread 2:
>        poll()
>           => event POLLIN on socket
>                => call dispatch(sock)
>                     => ref(lstnr)
>                     ...do stuff..
> 
>   Thread 1:
>        qio_net_listener_set_client_func(lstnr, NULL, ...);
>           => foreach sock: socket
>                => g_source_unref(sock_src)
>           => object_unref(listener)
>        unref(lstnr)  (still 1 reference left)
> 
>   Thread 2:
>                     => unref(lstnr)    (the final reference)
>                         => finalize(lstnr)
>               => return dispatch(sock)
>               => unref(GSourceCallback)
>

Yes, that's the race I plugged between v1 and v2 by adding the
referencing around the client callback.

> 
> That appears to work ok, however, there's still a race window that is
> not solved. Between the time thread 2 sees POLLIN, and when it calls
> the dispatch(sock) function, it is possible that thread 1 will drop
> the last reference:
> 
> 
> 
>   Thread 1:
>        qio_net_listener_set_client_func(lstnr, f, ...);
>            => object_ref(listener)
>            => foreach sock: socket
>                => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, NULL);
> 
>   Thread 2:
>        poll()
>           => event POLLIN on socket
> 
>   Thread 1:
>        qio_net_listener_set_client_func(lstnr, NULL, ...);
>           => foreach sock: socket
>                => g_source_unref(sock_src)
>           => object_unref(listener)
>        unref(lstnr)  (still 1 reference left)

Another copy-paste problem?  I think your argument is that if we lose
this race, this particular unref() drops the count to 0 triggering
finalize() early...

> 
>   Thread 2:
>                => call dispatch(sock)
>                     => ref(lstnr)

...before this one can compensate, and thus having a UAF for a
finalized lstnr passed to the callback.  Yes, I can see the race now;
thanks for persisting with the explanation.

>                     ...do stuff..
>                     => unref(lstnr)    (the final reference)
>                         => finalize(lstnr)
>               => return dispatch(sock)
>               => unref(GSourceCallback)
> 
> 
> I don't see a way to solve this without synchronization with the event
> loop for releasing the reference on the opaque data for the dispatcher
> callback.  That's what the current code does, but I'm seeing no way for
> the AioContext event loop callbacks to have anything equivalent. This
> feels like a gap in the AioContext design.

Yes, that was one thing I was frustrated with while writing v2 - the
AioContext code simply lacks a notify hook, even though it is
demonstrably useful with GSource.  But plumbing in a notify hook is
more invasive, and puts the series at risk of missing 10.2.  Still,
it's something worth getting right, so I'll try a v3.

> 
> This is admittedly an incredibly hard to trigger race condition. It would
> need a client to be calling a QMP command that tears down the NBD server,
> at the exact same time as a new NBD client was incoming. Or the same kind
> of scenario for other pieces of QEMU code using QIONetListener. This still
> makes me worried though, as rare races have a habit of hitting QEMU
> eventually.

Indeed.  And a hard-to-trigger race is, in some regards, worse than a
deadlock because it's harder to reproduce and prove whether it is
fixed.

I'm thinking about whether any of the GSourceCallback solution (using
a reference-counter wrapper around the user's original opaque data to
prove how many in-flight callbacks are still being dispatched) may be
usable with AioContext.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


