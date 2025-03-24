Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B928C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twf55-0003wI-5X; Mon, 24 Mar 2025 06:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1twf53-0003u7-Cb
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1twf4z-0008M6-E9
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742812246;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VrAxGYxmhYNSAwuo6/Z/a5BTLXqTOQa5SWGf9wocxAc=;
 b=bKpUg7wSosKPkdcwknCmrzo+sm5l0p2mBGJo6EOQc+rTTnVk0F5za7l1Ts5+OZz9bGw2JK
 9kHcOPyfgwhNlLmJcuhKiPQjNSrr6roMbcVr5BhzkKXViggQGzSwDHUhTrgIRmLMHbZD0f
 7xXGTDa7p+0p5bWRGaUgAZa07BImXrg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-dd_ES3hGN1iC8kg5oHfxnA-1; Mon,
 24 Mar 2025 06:30:44 -0400
X-MC-Unique: dd_ES3hGN1iC8kg5oHfxnA-1
X-Mimecast-MFC-AGG-ID: dd_ES3hGN1iC8kg5oHfxnA_1742812243
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F0BE196D2EE; Mon, 24 Mar 2025 10:30:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71AAC18009BC; Mon, 24 Mar 2025 10:30:40 +0000 (UTC)
Date: Mon, 24 Mar 2025 10:30:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/2] util/qemu-sockets: Add support for keep-alive
 flag to passive sockets
Message-ID: <Z-E0Te99X7LOeLj6@redhat.com>
References: <20250319163638.456417-1-jmarcin@redhat.com>
 <20250319163638.456417-2-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319163638.456417-2-jmarcin@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 19, 2025 at 05:36:19PM +0100, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Commit aec21d3175 (qapi: Add InetSocketAddress member keep-alive)
> introduces the keep-alive flag, which enables the SO_KEEPALIVE socket
> option, but only on client-side sockets. However, this option is also
> useful for server-side sockets, so they can check if a client is still
> reachable or drop the connection otherwise.
> 
> This patch enables the SO_KEEPALIVE socket option on passive server-side
> sockets if the keep-alive flag is enabled. This socket option is then
> inherited by active server-side sockets communicating with connected
> clients.
> 
> This patch also fixes an issue in 'qio_dns_resolver_lookup_sync_inet()'
> where the keep-alive flag is not copied together with other attributes.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  io/dns-resolver.c   |  2 ++
>  qapi/sockets.json   |  4 ++--
>  util/qemu-sockets.c | 52 +++++++++++++++++++++++++--------------------
>  3 files changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/io/dns-resolver.c b/io/dns-resolver.c
> index 53b0e8407a..ee7403b65b 100644
> --- a/io/dns-resolver.c
> +++ b/io/dns-resolver.c
> @@ -126,6 +126,8 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
>              .has_mptcp = iaddr->has_mptcp,
>              .mptcp = iaddr->mptcp,
>  #endif
> +            .has_keep_alive = iaddr->has_keep_alive,
> +            .keep_alive = iaddr->keep_alive,
>          };
>  
>          (*addrs)[i] = newaddr;

This is a bugfix, so should be a separate commit to facilitate cherry
picking back to stable branches.

> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index 6a95023315..eb50f64e3a 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -56,8 +56,8 @@
>  # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and
>  #     IPv6
>  #
> -# @keep-alive: enable keep-alive when connecting to this socket.  Not
> -#     supported for passive sockets.  (Since 4.2)
> +# @keep-alive: enable keep-alive when connecting to/listening on this socket.
> +#     (Since 4.2, not supported for listening sockets until 10.0)

This needs to be '10.1', since we're past feature freeze for '10.0'

>  #
>  # @mptcp: enable multi-path TCP.  (Since 6.1)
>  #
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 77477c1cd5..99357a4435 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -205,6 +205,22 @@ static int try_bind(int socket, InetSocketAddress *saddr, struct addrinfo *e)
>  #endif
>  }
>  
> +static int inet_set_sockopts(int sock, InetSocketAddress *saddr, Error **errp)
> +{
> +    if (saddr->keep_alive) {
> +        int keep_alive = 1;
> +        int ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
> +                             &keep_alive, sizeof(keep_alive));
> +
> +        if (ret < 0) {
> +            error_setg_errno(errp, errno,
> +                             "Unable to set keep-alive option on socket");
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
>  static int inet_listen_saddr(InetSocketAddress *saddr,
>                               int port_offset,
>                               int num,
> @@ -220,12 +236,6 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
>      int saved_errno = 0;
>      bool socket_created = false;
>  
> -    if (saddr->keep_alive) {
> -        error_setg(errp, "keep-alive option is not supported for passive "
> -                   "sockets");
> -        return -1;
> -    }
> -
>      memset(&ai,0, sizeof(ai));
>      ai.ai_flags = AI_PASSIVE;
>      if (saddr->has_numeric && saddr->numeric) {
> @@ -313,13 +323,18 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
>                      goto listen_failed;
>                  }
>              } else {
> -                if (!listen(slisten, num)) {
> +                if (listen(slisten, num)) {
> +                    if (errno != EADDRINUSE) {
> +                        error_setg_errno(errp, errno,
> +                                         "Failed to listen on socket");
> +                        goto listen_failed;
> +                    }

The implicit '} else {' fallthough is a success code path,
but you're failing to set socket opts in that case. We
accept that the socket might already be listening, but
we must still ensure the keepalives are set.

> +                } else {
> +                    if (inet_set_sockopts(slisten, saddr, errp)) {
> +                        goto listen_failed;
> +                    }
>                      goto listen_ok;
>                  }

Stylewise, don't nest the success codepath - this also would
fix the comment above.

> -                if (errno != EADDRINUSE) {
> -                    error_setg_errno(errp, errno, "Failed to listen on socket");
> -                    goto listen_failed;
> -                }
>              }
>              /* Someone else managed to bind to the same port and beat us
>               * to listen on it! Socket semantics does not allow us to
> @@ -474,19 +489,10 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
>          error_propagate(errp, local_err);
>          return sock;
>      }
> -
> -    if (saddr->keep_alive) {
> -        int val = 1;
> -        int ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
> -                             &val, sizeof(val));
> -
> -        if (ret < 0) {
> -            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
> -            close(sock);
> -            return -1;
> -        }
> +    if (inet_set_sockopts(sock, saddr, errp)) {
> +        close(sock);
> +        return -1;
>      }

This is the refactoring of existing code into a separate function. This
can be done in a separate commit, then the new feature of adding it to
the listener socket codepath  can be a followon commit.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


