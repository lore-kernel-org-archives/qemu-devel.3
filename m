Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1151ACD5BA2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 08:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJT8O-0004cS-Mn; Thu, 13 Nov 2025 03:56:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJT89-0004Sl-Nj
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJT83-0002F9-9I
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763024188;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czolCu1rTBBLtCLe92zG257pGtJwA3hzlnuGosqd/4E=;
 b=MncNleEKSxlubOCW/cH6yeE2zSBprYOUR2SfSTauyyyJvR7B/P3fwD+iW2JdAUsZNB0Tbf
 nO83wfOx/Wp8Y8GodSSRxSbaPTwsxTZpdW7fDENk4eFuoB2gf9jnT8BxeJz4Y71TzXe/BB
 xU77xzxRigWjXroE4cVfH6lT5dM1m48=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-Kl3Ls2ZVNaGVED6gzU2iNQ-1; Thu,
 13 Nov 2025 03:56:25 -0500
X-MC-Unique: Kl3Ls2ZVNaGVED6gzU2iNQ-1
X-Mimecast-MFC-AGG-ID: Kl3Ls2ZVNaGVED6gzU2iNQ_1763024184
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0247918005B0; Thu, 13 Nov 2025 08:56:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F28F0180094B; Thu, 13 Nov 2025 08:56:20 +0000 (UTC)
Date: Thu, 13 Nov 2025 08:56:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3 05/13] qio: Protect NetListener callback with mutex
Message-ID: <aRWdMXPSXk76LGt3@redhat.com>
References: <20251112224032.864420-15-eblake@redhat.com>
 <20251112224032.864420-20-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112224032.864420-20-eblake@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Nov 12, 2025 at 04:31:05PM -0600, Eric Blake wrote:
> Without a mutex, NetListener can run into this data race between a
> thread changing the async callback callback function to use when a
> client connects, and the thread servicing polling of the listening
> sockets:
> 
>  Thread 1:
>        qio_net_listener_set_client_func(lstnr, f1, ...);
>            => foreach sock: socket
>                => object_ref(lstnr)
>                => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, object_unref);
> 
>   Thread 2:
>        poll()
>           => event POLLIN on socket
>                => ref(GSourceCallback)
>                => if (lstnr->io_func) // while lstnr->io_func is f1
>                     ...interrupt..
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
>                => call lstnr->io_func(lstnr->io_data) // now sees f2
>                => return dispatch(sock)
>                => unref(GSourceCallback)
>                   => destroy-notify
>                      => object_unref
> 
> Found by inspection.  This is a SEGFAULT waiting to happen if f2 can
> become NULL because thread 1 deregisters the user's callback while
> thread 2 is trying to service the callback.  Other messes are also
> theoretically possible, such as running callback f1 with an opaque
> pointer that should only be passed to f2 (if the client code were to
> use more than just a binary choice between a single async function or
> NULL).
> 
> Mitigating factor: if the code that modifies the QIONetListener can
> only be reached by the same thread that is executing the polling and
> async callbacks, then we are not in a two-thread race documented above
> (even though poll can see two clients trying to connect in the same
> window of time, any changes made to the listener by the first async
> callback will be completed before the thread moves on to the second
> client).  However, QEMU is complex enough that I was unable to state
> with certainty whether a QMP command (such as nbd-server-stop, which
> does modify the net listener) can ever be serviced in a thread
> distinct from the one trying to do the async callbacks.  Similarly, I
> did not spend the time trying to add sleeps or execute under gdb to
> try and actually trigger the race in practice.
> 
> At any rate, it is worth having the API be robust.  To ensure that
> modifying a NetListener can be safely done from any thread, add a
> mutex that guarantees atomicity to all members of a listener object
> related to callbacks.  This problem has been present since
> QIONetListener was introduced.
> 
> Note that this does NOT prevent the case of a second round of the
> user's old async callback being invoked with the old opaque data, even
> when the user has already tried to change the async callback during
> the first async callback; it is only about ensuring that there is no
> sharding (the eventual io_func(io_data) call that does get made will
> correspond to a particular combination that the user had requested at
> some point in time, and not be sharded to a combination that never
> existed in practice).  In other words, this patch maintains the status
> quo that a user's async callback function already needs to be robust
> to parallel clients landing in the same window of poll servicing, even
> when only one client is desired.
> 
> CC: qemu-stable@nongnu.org
> Fixes: 53047392 ("io: introduce a network socket listener API", v2.12.0)
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v3: new patch
> ---
>  include/io/net-listener.h |  1 +
>  io/net-listener.c         | 58 +++++++++++++++++++++++++++++----------
>  2 files changed, 44 insertions(+), 15 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


