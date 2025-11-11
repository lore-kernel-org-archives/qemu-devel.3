Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2862CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 14:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIpbB-0000s9-Vd; Tue, 11 Nov 2025 09:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIpai-0000ic-1h
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 09:43:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIpag-0008GJ-7N
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 09:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762872205;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7YRNtScUq4C0XKttWrVUKYQE3YZaIxw8cRM8wZUyxqE=;
 b=KmSgldHA8MwY2/rAx8/lT2OY029DPVh0HbabruEY6Wfw/R4j08rN1X4LKXggO5klPDb4Az
 x3PuKN75iOM3AOGDUJFrlL3C9rC3jTHlrwlzavt+vDCRd1jtJ7prvHVisluf0kCJti+Ux+
 0Lsv3g47ZEuLqaDZWitXYTmDP+pGlhY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-ZvG4TJaqPMqJ-oHkNAsnaQ-1; Tue,
 11 Nov 2025 09:43:22 -0500
X-MC-Unique: ZvG4TJaqPMqJ-oHkNAsnaQ-1
X-Mimecast-MFC-AGG-ID: ZvG4TJaqPMqJ-oHkNAsnaQ_1762872201
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80A2E180057A; Tue, 11 Nov 2025 14:43:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.84])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2095F1800451; Tue, 11 Nov 2025 14:43:19 +0000 (UTC)
Date: Tue, 11 Nov 2025 14:43:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH 6/8] qio: Hoist ref of listener outside loop
Message-ID: <aRNLhP_FdMtPfzvG@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-16-eblake@redhat.com>
 <aQnf7AVY17zEKl84@redhat.com>
 <wscvm5qo2muser5hiwwl5wrvesuzacifdpgkh33shodxvltdas@lidjzqixmqpv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wscvm5qo2muser5hiwwl5wrvesuzacifdpgkh33shodxvltdas@lidjzqixmqpv>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Nov 05, 2025 at 03:57:29PM -0600, Eric Blake wrote:
> On Tue, Nov 04, 2025 at 11:13:48AM +0000, Daniel P. Berrangé wrote:
> > On Mon, Nov 03, 2025 at 02:10:57PM -0600, Eric Blake wrote:
> > > The point of QIONetListener is to allow a server to listen to more
> > > than one socket address at a time, and respond to clients in a
> > > first-come-first-serve order across any of those addresses.  While
> > > some servers (like NBD) really do want to serve multiple simultaneous
> > > clients, many other servers only care about the first client to
> > > connect, and will immediately deregister the callback, possibly by
> > > dropping their reference to the QIONetListener.  The existing code
> > > ensures that all other pending callbacks remain safe once the first
> > > callback drops the listener, by adding an extra reference to the
> > > listener for each GSource created, where those references pair to the
> > > eventual teardown of each GSource after a given callbacks has been
> > > serviced or aborted.  But it is equally acceptable to hoist the
> > > reference to the listener outside the loop - as long as there is a
> > > callback function registered, it is sufficient to have a single
> > > reference live for the entire array of sioc, rather than one reference
> > > per sioc in the array.
> > > 
> > > Hoisting the reference like this will make it easier for an upcoming
> > > patch to still ensure the listener cannot be prematurely garbage
> > > collected during the user's callback, even when the callback no longer
> > > uses a per-sioc GSource.
> > 
> > It isn't quite this simple. Glib reference counts the callback
> > func / data, holding a reference when dispatching the callback.
> > 
> > IOW, even if the GSource is unrefed, the callback 'notify'
> > function won't be called if the main loop is in the process
> > of dispatching.
> 
> I'm not sure I follow your argument.  Glib holds a reference on the
> GSource object, not on the opaque data that is handed to the GSource.
> It is possible to use g_source_set_callback_indirect() where GSource
> can learn how to use the same reference counting on data as external
> code, by the use of function pointers for ref and unref, but QIO uses
> merely g_source_set_callback().
> https://gitlab.gnome.org/GNOME/glib/-/blob/main/glib/gmain.c#L1844
> shows that glib then wraps that opaque pointer into an internal
> GSourceCallback object which itself is reference counted, so that the
> notify function is not called until the GSource is finalized, but that
> is reference counting on the container, not on the opaque object
> itself (which in this patch is the QIONetListener).
> 
> > 
> > With this change, the reference on 'listener' can now be
> > released even if the callback is currently dispatching.
> 
> So if I'm understanding your concern, you're worried that the unwatch
> code can finish looping through the g_source_destroy and then reach
> the point where it unrefs listener, but that a late-breaking client
> connection can trigger a callback that can still be executing in
> another thread/coroutine after the listener is unref'ed but before the
> GSource has been finalized?  If so, would squashing this in fix the
> problem you are seeing?

Consider the following scenario, where we have two threads, one
is calling QIONetListener APIs, and one is the event thread.

In the current code, when we unref() the GSource for the socket
watch, the destroy-notify does not get called, because the
event thread is in the middle of a dispatch callback for the
I/O event.  When the dispatch callback returns control to the
event loop, the GSourceCallback is unrefed, and this triggers
the destroy-notify call, which unrefs the listener.

The flow looks like this:

  Thread 1:
       qio_net_listener_set_client_func(lstnr, f, ...);
           => foreach sock: socket
               => object_ref(lstnr)
               => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, object_unref);

  Thread 2:
       poll()
          => event POLLIN on socket
               => ref(GSourceCallback)
               => call dispatch(sock)
                    ...do stuff..

  Thread 1:
       qio_net_listener_set_client_func(lstnr, NULL, ...);
          => foreach sock: socket
               => g_source_unref(sock_src)
       unref(lstnr)  (the final reference)
          => finalize(lstnr)

  Thread 2:
              => return dispatch(sock)
              => unref(GSourceCallback)
                  => destroy-notify
                     => object_unref



> diff --git i/io/net-listener.c w/io/net-listener.c
> index 9f4e3c0be0c..1fcbbeb7a76 100644
> --- i/io/net-listener.c
> +++ w/io/net-listener.c
> @@ -67,8 +67,10 @@ static void qio_net_listener_aio_func(void *opaque)
>  {
>      QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(opaque);
> 
> +    object_ref(OBJECT(sioc->listener));
>      qio_net_listener_channel_func(QIO_CHANNEL(sioc), G_IO_IN,
>                                    sioc->listener);
> +    object_unref(OBJECT(sioc->listener));
>  }

Now consider this patch, plus this extra hunk...

  Thread 1:
       qio_net_listener_set_client_func(lstnr, f, ...);
           => object_ref(listener)
           => foreach sock: socket
               => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, NULL);

  Thread 2:
       poll()
          => event POLLIN on socket
               => call dispatch(sock)
                    => ref(lstnr)
                    ...do stuff..

  Thread 1:
       qio_net_listener_set_client_func(lstnr, NULL, ...);
          => foreach sock: socket
               => g_source_unref(sock_src)
          => object_unref(listener)
       unref(lstnr)  (still 1 reference left)

  Thread 2:
                    => unref(lstnr)    (the final reference)
                        => finalize(lstnr)
              => return dispatch(sock)
              => unref(GSourceCallback)


That appears to work ok, however, there's still a race window that is
not solved. Between the time thread 2 sees POLLIN, and when it calls
the dispatch(sock) function, it is possible that thread 1 will drop
the last reference:



  Thread 1:
       qio_net_listener_set_client_func(lstnr, f, ...);
           => object_ref(listener)
           => foreach sock: socket
               => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, NULL);

  Thread 2:
       poll()
          => event POLLIN on socket

  Thread 1:
       qio_net_listener_set_client_func(lstnr, NULL, ...);
          => foreach sock: socket
               => g_source_unref(sock_src)
          => object_unref(listener)
       unref(lstnr)  (still 1 reference left)

  Thread 2:
               => call dispatch(sock)
                    => ref(lstnr)
                    ...do stuff..
                    => unref(lstnr)    (the final reference)
                        => finalize(lstnr)
              => return dispatch(sock)
              => unref(GSourceCallback)


I don't see a way to solve this without synchronization with the event
loop for releasing the reference on the opaque data for the dispatcher
callback.  That's what the current code does, but I'm seeing no way for
the AioContext event loop callbacks to have anything equivalent. This
feels like a gap in the AioContext design.

This is admittedly an incredibly hard to trigger race condition. It would
need a client to be calling a QMP command that tears down the NBD server,
at the exact same time as a new NBD client was incoming. Or the same kind
of scenario for other pieces of QEMU code using QIONetListener. This still
makes me worried though, as rare races have a habit of hitting QEMU
eventually.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


