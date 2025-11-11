Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C216DCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 20:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIuez-00081q-M6; Tue, 11 Nov 2025 15:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vIuew-000814-PX
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 15:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vIuem-0006TU-Hg
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 15:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762891679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+2ZvRyMgN1HwhFRZAG4n/1VnaOgEP+281A++5L1cLA=;
 b=hbqS26gdwS5wJXtOlb6GLIAzhDjimpy8vdOe2ziqSi6k3ZOQoeeAgDgo/5OEn2UP7DyGI0
 KQJcGOW1yVEU33Jcju1uEefSDSfJSvJoojgYhIR646sXi7ctb1WDbsEP26zcKSy+bxczN7
 jsVhQ//Msr0rusOMSWU8gVMLAR6d2ho=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-T6JW8UksNZSQSMggbs4SBA-1; Tue,
 11 Nov 2025 15:07:55 -0500
X-MC-Unique: T6JW8UksNZSQSMggbs4SBA-1
X-Mimecast-MFC-AGG-ID: T6JW8UksNZSQSMggbs4SBA_1762891674
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 481E0195605F; Tue, 11 Nov 2025 20:07:54 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.44])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09F7330044E0; Tue, 11 Nov 2025 20:07:52 +0000 (UTC)
Date: Tue, 11 Nov 2025 14:07:50 -0600
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH 6/8] qio: Hoist ref of listener outside loop
Message-ID: <elpit3ypz2vysuvwiodd742i5js2konefudavrdzbvywczzlg6@jf4ebybiqcvb>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-16-eblake@redhat.com>
 <aQnf7AVY17zEKl84@redhat.com>
 <wscvm5qo2muser5hiwwl5wrvesuzacifdpgkh33shodxvltdas@lidjzqixmqpv>
 <aRNLhP_FdMtPfzvG@redhat.com>
 <adhktitqm6c2xcfjbduexpe4kltzactcyaz4cwzjks64jekqbu@jx7txlcer7do>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adhktitqm6c2xcfjbduexpe4kltzactcyaz4cwzjks64jekqbu@jx7txlcer7do>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Tue, Nov 11, 2025 at 01:09:24PM -0600, Eric Blake wrote:
> > In the current code, when we unref() the GSource for the socket
> > watch, the destroy-notify does not get called, because the
> > event thread is in the middle of a dispatch callback for the
> > I/O event.  When the dispatch callback returns control to the
> > event loop, the GSourceCallback is unrefed, and this triggers
> > the destroy-notify call, which unrefs the listener.
> > 
> > The flow looks like this:
> > 
> >   Thread 1:
> >        qio_net_listener_set_client_func(lstnr, f, ...);
> >            => foreach sock: socket
> >                => object_ref(lstnr)
> >                => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, object_unref);
> > 
> >   Thread 2:
> >        poll()
> >           => event POLLIN on socket
> >                => ref(GSourceCallback)
> >                => call dispatch(sock)
> >                     ...do stuff..
> > 
> >   Thread 1:
> >        qio_net_listener_set_client_func(lstnr, NULL, ...);
> >           => foreach sock: socket
> >                => g_source_unref(sock_src)
> >        unref(lstnr)  (the final reference)
> >           => finalize(lstnr)
> 
> If I understand correctly, _this_ unref(lstnr) is NOT the final
> reference, because of the additional reference still owned by the
> GSource that is still dispatching, so finalize(lstnr) is not reached
> here...
> 
> > 
> >   Thread 2:
> >               => return dispatch(sock)
> >               => unref(GSourceCallback)
> >                   => destroy-notify
> >                      => object_unref
> 
> ...but instead here.  And that is the desirable property of the
> pre-patch behavior with a per-GSource reference on the listsner object
> - we are guaranteed that listener can't be finalized while there are
> any pending dispatch in flight, even if the caller has unref'd their
> last mention of lstnr, and therefore the dispatch never has a
> use-after-free.

But thinking further, even if it is not an object_unref, but merely a
change of the async callback function, is this the sort of thing where
a mutex is needed to make things safer?

Even without my patch series, we have this scenario:

  Thread 1:
       qio_net_listener_set_client_func(lstnr, f1, ...);
           => foreach sock: socket
               => object_ref(lstnr)
               => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, object_unref);

  Thread 2:
       poll()
          => event POLLIN on socket
               => ref(GSourceCallback) // while lstnr->io_func is f1
                    ...do stuff..

  Thread 1:
       qio_net_listener_set_client_func(lstnr, f2, ...);
          => foreach sock: socket
               => g_source_unref(sock_src)
          => foreach sock: socket
               => object_ref(lstnr)
               => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, object_unref);

  Thread 2:
               => access lstnr->io_func // now sees f2
               => call f2(sock)
               => return dispatch(sock)
               => unref(GSourceCallback)
                  => destroy-notify
                     => object_unref

So even though thread 2 noticed a client while f1 was registered,
because we lack a mutex and are not using atomic access primitives,
there is nothing preventing thread 1 from changing the io_func from f1
to f2 before thread 2 finally calls the callback.  And if f2 is NULL
(because the caller is deregistering the callback), I could see the
race resulting in qio_net_listener_channel_func() with its pre-patch
code of:

    if (listener->io_func) {
        listener->io_func(listener, sioc, listener->io_data);
    }

resulting in a NULL-pointer deref if thread 1 changed out
listener->io_func after the if but before the dispatch.

Adding a mutex might make QIONetListener slower in the time to grab
the mutex (even if it is uncontended most of the time), but if we have
a proper mutex in place, we could at least guarantee that
listener->io_func, listener->io_data, and listener->io_notify are
changed as a group, rather than sharded if the polling thread is
managing a dispatch with listener as its opaque data at the same time
the user's thread is trying to change the registered callback.

By itself, GSource DOES have a mutex lock around the GMainContext it
is attached to; but our particular use of GSource is operating outside
that locking scheme, so it looks like I've uncovered another latent
problem.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


