Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20D8CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 14:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIpbd-0001Uo-GF; Tue, 11 Nov 2025 09:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIpbP-00019v-5j
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 09:44:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIpbN-0008NH-7T
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 09:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762872248;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=j0wk79UsHz/IJDUf5gskm4DKSevwBbYUsj1pw5vLEg4=;
 b=UCVLhcWjAeRnu8hK3P+GJnI36tbL0t41fzHgEViF+PRBpglbBxO3mFbNY0MMQN6+BL0r1H
 0YNCNwD/isJkSpqgib1jy/KQrzzDSSXLHkBQ+G2OSZ2uVn30q1Ucp6z+dNpuD0iOkeWnE0
 sid7x2uiVWeUPhtTPtpH3/KyNU5mG/E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-lqODnNx0MzuoLnBRbBfiFQ-1; Tue,
 11 Nov 2025 09:44:05 -0500
X-MC-Unique: lqODnNx0MzuoLnBRbBfiFQ-1
X-Mimecast-MFC-AGG-ID: lqODnNx0MzuoLnBRbBfiFQ_1762872244
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D99FF1800D9A; Tue, 11 Nov 2025 14:43:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.84])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37446180094D; Tue, 11 Nov 2025 14:43:55 +0000 (UTC)
Date: Tue, 11 Nov 2025 14:43:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH v2 07/12] qio: Hoist ref of listener outside loop
Message-ID: <aRNLqCliIPyiyHpG@redhat.com>
References: <20251108230525.3169174-14-eblake@redhat.com>
 <20251108230525.3169174-21-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251108230525.3169174-21-eblake@redhat.com>
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

On Sat, Nov 08, 2025 at 04:59:28PM -0600, Eric Blake wrote:
> The point of QIONetListener is to allow a server to listen to more
> than one socket address at a time, and respond to clients in a
> first-come-first-serve order across any of those addresses.  While
> some servers (like NBD) really do want to serve multiple simultaneous
> clients, others only care about the first client to connect, and will
> immediately deregister the callback, possibly by dropping their
> reference to the QIONetListener.  The existing code ensures that the
> reference count on the listener will not drop to zero while there are
> any pending GSource (since each GSource will not call the notify of
> object_unref() until it is no longer servicing a callback); however,
> it is also possible to guarantee the same setup by merely holding an
> overall reference to the listener as long as there is at least one
> GSource, as well as also holding a local reference around any callback
> function that has not yet run to completion.
> 
> Hoisting the reference like this will make it easier for an upcoming
> patch to still ensure the listener cannot be prematurely finalized
> during the user's callback, even when using AioContext (where we have
> not plumbed in support for a notify function) rather than GSource.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: also grab reference around callback execution

Still not comfortable with this. I've sent a reply to your v1
patch though, so we keep the analysis in one thread.

> ---
>  io/net-listener.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/io/net-listener.c b/io/net-listener.c
> index ad097175eba..dd3522c9b3c 100644
> --- a/io/net-listener.c
> +++ b/io/net-listener.c
> @@ -54,7 +54,9 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
>      trace_qio_net_listener_callback(listener, listener->io_func,
>                                      listener->context);
>      if (listener->io_func) {
> +        object_ref(OBJECT(listener));
>          listener->io_func(listener, sioc, listener->io_data);
> +        object_unref(OBJECT(listener));
>      }
> 
>      object_unref(OBJECT(sioc));
> @@ -120,12 +122,14 @@ qio_net_listener_watch(QIONetListener *listener, size_t i, const char *caller)
> 
>      trace_qio_net_listener_watch(listener, listener->io_func,
>                                   listener->context, caller);
> -    for ( ; i < listener->nsioc; i++) {
> +    if (i == 0) {
>          object_ref(OBJECT(listener));
> +    }
> +    for ( ; i < listener->nsioc; i++) {
>          listener->io_source[i] = qio_channel_add_watch_source(
>              QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
>              qio_net_listener_channel_func,
> -            listener, (GDestroyNotify)object_unref, listener->context);
> +            listener, NULL, listener->context);
>      }
>  }
> 
> @@ -147,6 +151,7 @@ qio_net_listener_unwatch(QIONetListener *listener, const char *caller)
>              listener->io_source[i] = NULL;
>          }
>      }
> +    object_unref(OBJECT(listener));
>  }
> 
>  void qio_net_listener_add(QIONetListener *listener,
> -- 
> 2.51.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


