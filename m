Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633FEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZv2R-0005uW-C9; Fri, 02 Aug 2024 12:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZv2P-0005s5-7z
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZv2M-0004pX-TV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722615708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sNOljK0okF7uSxHuQ1zXWhuuviWxCBy/uyg6qnt6+dw=;
 b=RxdIEClSWaHYGvQn6oiAvmvw82hVpxGx+eV6tHzVIW+zvH4MMEgRsB1j7Oi/5mKu6rlZYq
 Wc/44GEOMB5vvstyTxfT6q7aLT/Zu7x7hnl4z3fFpSdocLFo0SwcxiV1MZOYBH9iTXVx/T
 y8IWyIXgHL1v4yELLtNoGL3elYrSV3A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-JPBjtOM5MNWAsNrLjEvAJw-1; Fri,
 02 Aug 2024 12:21:43 -0400
X-MC-Unique: JPBjtOM5MNWAsNrLjEvAJw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AFA7196E020; Fri,  2 Aug 2024 16:21:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B797819560AA; Fri,  2 Aug 2024 16:21:38 +0000 (UTC)
Date: Fri, 2 Aug 2024 11:21:35 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com, 
 andrey.drobyshev@virtuozzo.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: Re: [PATCH v2 1/3] nbd: CVE-XXX: Use cookie to track generation of
 nbd-server
Message-ID: <pttia6mzcrnzq6w7o67v2xdufbhtz67kyfmms4kfidvybj4kw2@xtedyj52jfrl>
References: <20240802014824.1906798-5-eblake@redhat.com>
 <20240802014824.1906798-6-eblake@redhat.com>
 <b91052fc-0286-4161-8a3b-10bd45c3485a@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b91052fc-0286-4161-8a3b-10bd45c3485a@yandex-team.ru>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 02, 2024 at 06:00:32PM GMT, Vladimir Sementsov-Ogievskiy wrote:
> On 02.08.24 04:32, Eric Blake wrote:

> [..]
> 
> > -static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
> > +static void nbd_blockdev_client_closed(NBDClient *client, uint32_t cookie,
> > +                                       bool ignored)
> >   {
> >       nbd_client_put(client);
> > -    assert(nbd_server->connections > 0);
> > -    nbd_server->connections--;
> > -    nbd_update_server_watch(nbd_server);
> > +    /* Ignore any (late) connection made under a previous server */
> > +    if (cookie == nbd_cookie) {
> 
> creating a getter nbd_client_get_cookie(client), and use it instead of passing together with client, will simplify the patch a lot. [*]

I may be able to avoid the cookie altogether if I can add an
AIO_WAIT_WHILE(, nbd_server->connections > 0) after forcefully closing
all of the client sockets (nbd_client_new _should_ progress pretty
rapidly towards eventually calling nbd_blockdev_client_closed once the
socket is closed) - but that still requires patch 2 to keep a list of
open clients.

> 
> Hmm.. don't we need some atomic accessors for nbd_cookie? and for nbs_server->connections.. The function is called from client, which live in coroutine and maybe in another thread? At least client code do atomic accesses of client->refcount..
> 
> > +        assert(nbd_server->connections > 0);
> > +        nbd_server->connections--;
> > +        nbd_update_server_watch(nbd_server);
> > +    }
> >   }
> > 
> 
> [..]
> 
> > @@ -1621,7 +1622,7 @@ static void client_close(NBDClient *client, bool negotiated)
> > 
> >       /* Also tell the client, so that they release their reference.  */
> >       if (client->close_fn) {
> > -        client->close_fn(client, negotiated);
> > +        client->close_fn(client, client->close_cookie, negotiated);
> 
> [*] passing client->close_cokkie together with client itself looks like we lack a getter for .close_cookie

Whether the cookie be a uint32_t or the void* server object itself, it
is opaque to the client, but the server needs to track something.


> 
> >       }
> >   }
> > 
> 
> [..]
> 
> 
> Hmm, instead of cookies and additional NBDConn objects in the next patch, could we simply have a list of connected NBDClient objects in NBDServer and link to NBDServer in NBDClient? (Ok we actually don't have NBDServer, but NBDServerData in qemu, and several global variables in qemu-nbd, so some refactoring is needed, to put common state to NBDServer, and add clients list to it)
> 
> This way, in nbd_server_free we'll just call client_close() in a loop. And in client_close we'll have nbd_server_client_detach(client->server, client), instead of client->close_fn(...). And server is freed only after all clients are closed. And client never try to detach from another server.
> 
> This way, we also may implement several NBD servers working simultaneously if we want.

Yes, we do eventually want to get to the point of being able to open
parallel NBD servers on different ports simultaneously, at which point
having a client remember which server it is associated makes sense (so
at a bare minimum, pass in a void* instead of a uint32_t to
nbd_client_new).  And given that we can have an NBD server with more
than one export, and with exports running in different threads (if
multithread io is enabled), I probably also need to add missing
locking to protect nbd_server (whether or not it stays global or we
eventually reach the point of having parallel servers on separate
ports).

Looks like I have work cut out for me before posting a v3.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


