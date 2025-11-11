Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3EFCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 16:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIquP-0004rp-0F; Tue, 11 Nov 2025 11:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIqu4-0004XT-Ja
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 11:07:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIqu3-000682-3f
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 11:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762877247;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZ0aCg9lmgUFNLUpQ+riSAh9HFossYbNse6oA8/jLd0=;
 b=ENHWWgFLRzM7AFnH2O0teUR97rt2/KmLDlg/R2LCMX5C8VkdiIpBS+Uz0HU77AkWn8XSdH
 F99kir6XkgYr1LJSxnz5stkDW9zgzphkdd7x2iRAasIKPYp/s1cXpXVo8AxgtDOWanohoc
 RvOq4jaTnpCt6gfZDfHOq8oa1C5umPo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-DZa0J09sNDmbE2U-bICgiQ-1; Tue,
 11 Nov 2025 11:07:25 -0500
X-MC-Unique: DZa0J09sNDmbE2U-bICgiQ-1
X-Mimecast-MFC-AGG-ID: DZa0J09sNDmbE2U-bICgiQ_1762877244
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05FF819560AE; Tue, 11 Nov 2025 16:07:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33130195608E; Tue, 11 Nov 2025 16:07:18 +0000 (UTC)
Date: Tue, 11 Nov 2025 16:07:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, stefanha@redhat.com
Subject: Re: [PATCH 6/8] qio: Hoist ref of listener outside loop
Message-ID: <aRNfMNc-XJfCl_4E@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-16-eblake@redhat.com>
 <aQnf7AVY17zEKl84@redhat.com>
 <wscvm5qo2muser5hiwwl5wrvesuzacifdpgkh33shodxvltdas@lidjzqixmqpv>
 <aRNLhP_FdMtPfzvG@redhat.com> <aRNatBbLB29clhPk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRNatBbLB29clhPk@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 11, 2025 at 04:48:04PM +0100, Kevin Wolf wrote:
> Am 11.11.2025 um 15:43 hat Daniel P. Berrangé geschrieben:
> > On Wed, Nov 05, 2025 at 03:57:29PM -0600, Eric Blake wrote:
> > > On Tue, Nov 04, 2025 at 11:13:48AM +0000, Daniel P. Berrangé wrote:
> > > > On Mon, Nov 03, 2025 at 02:10:57PM -0600, Eric Blake wrote:
> > > > > The point of QIONetListener is to allow a server to listen to more
> > > > > than one socket address at a time, and respond to clients in a
> > > > > first-come-first-serve order across any of those addresses.  While
> > > > > some servers (like NBD) really do want to serve multiple simultaneous
> > > > > clients, many other servers only care about the first client to
> > > > > connect, and will immediately deregister the callback, possibly by
> > > > > dropping their reference to the QIONetListener.  The existing code
> > > > > ensures that all other pending callbacks remain safe once the first
> > > > > callback drops the listener, by adding an extra reference to the
> > > > > listener for each GSource created, where those references pair to the
> > > > > eventual teardown of each GSource after a given callbacks has been
> > > > > serviced or aborted.  But it is equally acceptable to hoist the
> > > > > reference to the listener outside the loop - as long as there is a
> > > > > callback function registered, it is sufficient to have a single
> > > > > reference live for the entire array of sioc, rather than one reference
> > > > > per sioc in the array.
> > > > > 
> > > > > Hoisting the reference like this will make it easier for an upcoming
> > > > > patch to still ensure the listener cannot be prematurely garbage
> > > > > collected during the user's callback, even when the callback no longer
> > > > > uses a per-sioc GSource.
> > > > 
> > > > It isn't quite this simple. Glib reference counts the callback
> > > > func / data, holding a reference when dispatching the callback.
> > > > 
> > > > IOW, even if the GSource is unrefed, the callback 'notify'
> > > > function won't be called if the main loop is in the process
> > > > of dispatching.

snip

> > That appears to work ok, however, there's still a race window that is
> > not solved. Between the time thread 2 sees POLLIN, and when it calls
> > the dispatch(sock) function, it is possible that thread 1 will drop
> > the last reference:
> > 
> > 
> > 
> >   Thread 1:
> >        qio_net_listener_set_client_func(lstnr, f, ...);
> >            => object_ref(listener)
> >            => foreach sock: socket
> >                => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, NULL);
> > 
> >   Thread 2:
> >        poll()
> >           => event POLLIN on socket
> > 
> >   Thread 1:
> >        qio_net_listener_set_client_func(lstnr, NULL, ...);
> >           => foreach sock: socket
> >                => g_source_unref(sock_src)
> >           => object_unref(listener)
> >        unref(lstnr)  (still 1 reference left)
> 
> Is what you're worried about that there is still a reference left in
> the opaque pointer of an fd handler, but it's not in the refcount and
> therefore this already frees the listener while thread 2 will still
> access it?

Yes, exactly.

> 
> > 
> >   Thread 2:
> >                => call dispatch(sock)
> >                     => ref(lstnr)
> >                     ...do stuff..
> >                     => unref(lstnr)    (the final reference)
> >                         => finalize(lstnr)
> >               => return dispatch(sock)
> >               => unref(GSourceCallback)
> > 
> > 
> > I don't see a way to solve this without synchronization with the event
> > loop for releasing the reference on the opaque data for the dispatcher
> > callback.  That's what the current code does, but I'm seeing no way for
> > the AioContext event loop callbacks to have anything equivalent. This
> > feels like a gap in the AioContext design.
> 
> I think the way you would normally do this is schedule a BH in thread 2
> to do the critical work. If you delete the fd handler and unref the
> listener in thread 2, then there is no race.

Yes, using a BH would be safe, provided you put the BH in the right
loop, given that we have choice of the main event loop, or a non-default
GMainContext, or the special  AioContext that NBD is relying on.

> But maybe adding a callback for node deletion in AioHandler wouldn't
> hurt because the opaque pointer pretty much always references something
> and doing an unref when deleting the AioHandler should be a pretty
> common pattern.

That would likely make the scenario less error-prone, compared to
remembering to use a BH to synchronize.

> > This is admittedly an incredibly hard to trigger race condition. It would
> > need a client to be calling a QMP command that tears down the NBD server,
> > at the exact same time as a new NBD client was incoming. Or the same kind
> > of scenario for other pieces of QEMU code using QIONetListener. This still
> > makes me worried though, as rare races have a habit of hitting QEMU
> > eventually.
> 
> Aren't both QMP and incoming NBD connections always handled in the main
> thread? I'm not sure if I know a case where we would actually get this
> pattern with two different threads today. Of course, that doesn't mean
> that we couldn't get it in the future.

Yeah, I believe we're probably safe in todays usage. My concern was
primarily about any surprises in the conceptual design that might
impact us in future.

I guess if NBD is the only thing using AioContext for QIONetListener
today, we could hoist the ref/unref only when using a AioContext,
and keep the GDestroyNotify usage for the GMainContext code path
to significantly limit the exposure. Avoid needing to do anything
extra for AioHandlers right before release.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


