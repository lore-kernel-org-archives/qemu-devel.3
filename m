Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231DECCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 14:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIpAZ-0004mH-NP; Tue, 11 Nov 2025 09:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIpAL-0004iH-CI
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 09:16:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIpAG-0002ZN-6n
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 09:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762870566;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vW3hXGdqkk06W2oFnLkcVaDLOW+My5zxy7jfKflmTXI=;
 b=ab4iumYSUyBEaB/6WLd2/C61tphySjhyCkptccBBy91A/C/925rKr2dn1SXZUF9YnNqHU9
 c5qX0OSrtVW14GdQNK2KwFYHFFofp2Ut0vYCfMgveuops5iCRSmWPpdokyl+1K3ZSTeGJe
 lKUmeFQOXTfm7Phuny2Xohh12qFRzbw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-Ng7w2C0FP5uT05S6SY0-_w-1; Tue,
 11 Nov 2025 09:16:04 -0500
X-MC-Unique: Ng7w2C0FP5uT05S6SY0-_w-1
X-Mimecast-MFC-AGG-ID: Ng7w2C0FP5uT05S6SY0-_w_1762870563
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C6531800371; Tue, 11 Nov 2025 14:16:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.84])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F56F19560A2; Tue, 11 Nov 2025 14:15:59 +0000 (UTC)
Date: Tue, 11 Nov 2025 14:15:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 08/12] qio: Provide accessor around QIONetListener->sioc
Message-ID: <aRNFHAvkloB41tPr@redhat.com>
References: <20251108230525.3169174-14-eblake@redhat.com>
 <20251108230525.3169174-22-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251108230525.3169174-22-eblake@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Sat, Nov 08, 2025 at 04:59:29PM -0600, Eric Blake wrote:
> An upcoming patch needs to pass more than just sioc as the opaque
> pointer to an AioContext; but since our AioContext code in general
> (and its QIO Channel wrapper code) lacks a notify callback present
> with GSource, we do not have the trivial option of just g_malloc'ing a
> small struct to hold all that data coupled with a notify of g_free.
> Instead, the data pointer must outlive the registered handler; in
> fact, having the data pointer have the same lifetime as QIONetListener
> is adequate.
> 
> But the cleanest way to stick such a helper struct in QIONetListener
> will be to rearrange internal struct members.  And that in turn means
> that all existing code that currently directly accesses
> listener->nsioc and listener->sioc[] should instead go through
> accessor functions, to be immune to the upcoming struct layout
> changes.  So this patch adds accessor methods qio_net_listener_nsioc()
> and qio_net_listener_sioc(), and puts them to use.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: new patch
> ---
>  include/io/net-listener.h | 24 ++++++++++++++++++++++++
>  chardev/char-socket.c     |  3 ++-
>  io/net-listener.c         | 12 ++++++++++++
>  migration/socket.c        |  5 +++--
>  ui/vnc.c                  | 36 +++++++++++++++++++++++-------------
>  5 files changed, 64 insertions(+), 16 deletions(-)
> 
> diff --git a/include/io/net-listener.h b/include/io/net-listener.h
> index 42fbfab5467..2605d6aae1e 100644
> --- a/include/io/net-listener.h
> +++ b/include/io/net-listener.h
> @@ -184,4 +184,28 @@ void qio_net_listener_disconnect(QIONetListener *listener);
>   */
>  bool qio_net_listener_is_connected(QIONetListener *listener);
> 
> +
> +/**
> + * qio_net_listener_nsioc:
> + * @listener: the network listener object
> + *
> + * Determine the number of listener channels currently owned by the
> + * given listener.
> + *
> + * Returns: number of channels, or 0 if not listening
> + */
> +size_t qio_net_listener_nsioc(QIONetListener *listener);
> +
> +
> +/**
> + * qio_net_listener_sioc:
> + * @listener: the network listener object
> + * @n: index of the sioc to grab
> + *
> + * Accessor for the nth sioc owned by the listener.
> + *
> + * Returns: the requested listener, or #NULL if not in bounds
> + */
> +QIOChannelSocket *qio_net_listener_sioc(QIONetListener *listener, size_t n);
> +
>  #endif /* QIO_NET_LISTENER_H */
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 62852e3caf5..022ae47d726 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1255,7 +1255,8 @@ static int qmp_chardev_open_socket_server(Chardev *chr,
>      }
> 
>      qapi_free_SocketAddress(s->addr);
> -    s->addr = socket_local_address(s->listener->sioc[0]->fd, errp);
> +    s->addr = socket_local_address(qio_net_listener_sioc(s->listener, 0)->fd,
> +                                   errp);

Oh pre-existing bug / undesirable code pattern. This should be calling
qio_channel_socket_get_local_address, which avoids the needs to re-call
getsockname() as QIOChanelSocket has cached the local address.

Once we do that, then we would have 4 cases in this patch doing

            qio_channel_socket_get_local_address(
                qio_net_listener_sioc(listener, i), errp);

which would suggest adding a helper we could call as

      qio_net_listener_get_local_address(listener, i, errp)



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


