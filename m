Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFE2CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 10:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ89E-0004Ui-4S; Wed, 12 Nov 2025 05:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJ896-0004Ii-JG
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 05:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJ894-0003qs-Sc
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 05:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762943529;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Y9knfadgqWCJPBaNyQeh5WFej7M+iO8t4KL268PHasE=;
 b=MQu4pNMSY2i3HsfS8wSjPxrncMYMZi9a1bMSScGpx0+B2D1MZGZLtA5ulGWLx6XbkbMe4x
 sIE/olTfCO3Nb0FWpjLPdo+Lrugv32++7IgfSRs6Ha0vRASgVS/7+2iW2eaA4uK0xjdOrK
 1JJL6NqetwPHSjMiBYjDfkHTwsr0KAo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-uhhIFI0nN628Sac492Jh-w-1; Wed,
 12 Nov 2025 05:32:06 -0500
X-MC-Unique: uhhIFI0nN628Sac492Jh-w-1
X-Mimecast-MFC-AGG-ID: uhhIFI0nN628Sac492Jh-w_1762943525
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 675641801233; Wed, 12 Nov 2025 10:32:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFAC41800872; Wed, 12 Nov 2025 10:32:02 +0000 (UTC)
Date: Wed, 12 Nov 2025 10:31:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH 6/8] qio: Hoist ref of listener outside loop
Message-ID: <aRRiHfgK24xcD72y@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-16-eblake@redhat.com>
 <aQnf7AVY17zEKl84@redhat.com>
 <wscvm5qo2muser5hiwwl5wrvesuzacifdpgkh33shodxvltdas@lidjzqixmqpv>
 <aRNLhP_FdMtPfzvG@redhat.com>
 <adhktitqm6c2xcfjbduexpe4kltzactcyaz4cwzjks64jekqbu@jx7txlcer7do>
 <elpit3ypz2vysuvwiodd742i5js2konefudavrdzbvywczzlg6@jf4ebybiqcvb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <elpit3ypz2vysuvwiodd742i5js2konefudavrdzbvywczzlg6@jf4ebybiqcvb>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 11, 2025 at 02:07:50PM -0600, Eric Blake wrote:
> On Tue, Nov 11, 2025 at 01:09:24PM -0600, Eric Blake wrote:
> > > In the current code, when we unref() the GSource for the socket
> > > watch, the destroy-notify does not get called, because the
> > > event thread is in the middle of a dispatch callback for the
> > > I/O event.  When the dispatch callback returns control to the
> > > event loop, the GSourceCallback is unrefed, and this triggers
> > > the destroy-notify call, which unrefs the listener.
> > > 
> > > The flow looks like this:
> > > 
> > >   Thread 1:
> > >        qio_net_listener_set_client_func(lstnr, f, ...);
> > >            => foreach sock: socket
> > >                => object_ref(lstnr)
> > >                => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, object_unref);
> > > 
> > >   Thread 2:
> > >        poll()
> > >           => event POLLIN on socket
> > >                => ref(GSourceCallback)
> > >                => call dispatch(sock)
> > >                     ...do stuff..
> > > 
> > >   Thread 1:
> > >        qio_net_listener_set_client_func(lstnr, NULL, ...);
> > >           => foreach sock: socket
> > >                => g_source_unref(sock_src)
> > >        unref(lstnr)  (the final reference)
> > >           => finalize(lstnr)
> > 
> > If I understand correctly, _this_ unref(lstnr) is NOT the final
> > reference, because of the additional reference still owned by the
> > GSource that is still dispatching, so finalize(lstnr) is not reached
> > here...
> > 
> > > 
> > >   Thread 2:
> > >               => return dispatch(sock)
> > >               => unref(GSourceCallback)
> > >                   => destroy-notify
> > >                      => object_unref
> > 
> > ...but instead here.  And that is the desirable property of the
> > pre-patch behavior with a per-GSource reference on the listsner object
> > - we are guaranteed that listener can't be finalized while there are
> > any pending dispatch in flight, even if the caller has unref'd their
> > last mention of lstnr, and therefore the dispatch never has a
> > use-after-free.
> 
> But thinking further, even if it is not an object_unref, but merely a
> change of the async callback function, is this the sort of thing where
> a mutex is needed to make things safer?
> 
> Even without my patch series, we have this scenario:
> 
>   Thread 1:
>        qio_net_listener_set_client_func(lstnr, f1, ...);
>            => foreach sock: socket
>                => object_ref(lstnr)
>                => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, object_unref);
> 
>   Thread 2:
>        poll()
>           => event POLLIN on socket
>                => ref(GSourceCallback) // while lstnr->io_func is f1
>                     ...do stuff..
> 
>   Thread 1:
>        qio_net_listener_set_client_func(lstnr, f2, ...);
>           => foreach sock: socket
>                => g_source_unref(sock_src)
>           => foreach sock: socket
>                => object_ref(lstnr)
>                => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, object_unref);
> 
>   Thread 2:
>                => access lstnr->io_func // now sees f2
>                => call f2(sock)
>                => return dispatch(sock)
>                => unref(GSourceCallback)
>                   => destroy-notify
>                      => object_unref
> 
> So even though thread 2 noticed a client while f1 was registered,
> because we lack a mutex and are not using atomic access primitives,
> there is nothing preventing thread 1 from changing the io_func from f1
> to f2 before thread 2 finally calls the callback.  And if f2 is NULL
> (because the caller is deregistering the callback), I could see the
> race resulting in qio_net_listener_channel_func() with its pre-patch
> code of:
> 
>     if (listener->io_func) {
>         listener->io_func(listener, sioc, listener->io_data);
>     }
> 
> resulting in a NULL-pointer deref if thread 1 changed out
> listener->io_func after the if but before the dispatch.

Hmm, yes, that is a risk I hadn't thought of before.

> Adding a mutex might make QIONetListener slower in the time to grab
> the mutex (even if it is uncontended most of the time), but if we have
> a proper mutex in place, we could at least guarantee that
> listener->io_func, listener->io_data, and listener->io_notify are
> changed as a group, rather than sharded if the polling thread is
> managing a dispatch with listener as its opaque data at the same time
> the user's thread is trying to change the registered callback.

Yeah, a mutex should be ok, as it will be uncontended 99.999% of
the time.

> By itself, GSource DOES have a mutex lock around the GMainContext it
> is attached to; but our particular use of GSource is operating outside
> that locking scheme, so it looks like I've uncovered another latent
> problem.

Agreed.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


