Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7163AC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 11:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twfjo-0003gp-FH; Mon, 24 Mar 2025 07:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1twfjf-0003fx-LO
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 07:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1twfjd-0005Yu-Oa
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 07:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742814768;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VcMp7KU3MSHhDSHelKyxU7vhra4GM5mZNULnXhUYeIU=;
 b=N8jd8U4kYfIf42m4giG/1NfHSIocotSWPv/X67Yt84Mnu941TNYgz9b8os0S+FEYoJvepl
 XQompqg1WkJIDBjNNDJCcKM5DrHpQRbD83giF9Yd4pdMaGpI8qAwyTXqr17CjhdAItz/88
 rc1/xMXciA8zGBN5q8HL6IZx1yZbySg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-76jrBr_3M02874OCpZLpBA-1; Mon,
 24 Mar 2025 07:12:45 -0400
X-MC-Unique: 76jrBr_3M02874OCpZLpBA-1
X-Mimecast-MFC-AGG-ID: 76jrBr_3M02874OCpZLpBA_1742814764
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5CB118EBE8F; Mon, 24 Mar 2025 11:12:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BA2F1800268; Mon, 24 Mar 2025 11:12:39 +0000 (UTC)
Date: Mon, 24 Mar 2025 11:12:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/2] utils/qemu-sockets: Introduce
 keep-alive-idle-period inet socket option
Message-ID: <Z-E-JNWlGYuTTK8t@redhat.com>
References: <20250319163638.456417-1-jmarcin@redhat.com>
 <20250319163638.456417-3-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319163638.456417-3-jmarcin@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Wed, Mar 19, 2025 at 05:36:20PM +0100, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> The default idle period for TCP connection could be even 2 hours.
> However, in some cases, the application needs to be aware of a
> connection issue much sooner.
> 
> This is the case, for example, for postcopy live migration. If there is
> no traffic from the migration destination guest (server-side) to the
> migration source guest (client-side), the destination keeps waiting for
> pages indefinitely and does not switch to the postcopy-paused state.
> This can happen, for example, if the destination QEMU instance is
> started with '-S' command line option and the machine is not started yet
> or if the machine is idle and produces no new page faults for
> not-yet-migrated pages.
> 
> This patch introduces a new inet socket parameter on platforms where
> TCP_KEEPIDLE is defined and passes the configured value to the
> TCP_KEEPIDLE socket option when a client-side or server-side socket is
> created.
> 
> The default value is 0, which means system configuration is used, and no
> custom value is set.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  io/dns-resolver.c   |  4 ++++
>  meson.build         |  2 ++
>  qapi/sockets.json   |  5 +++++
>  util/qemu-sockets.c | 29 +++++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+)
> 
> diff --git a/io/dns-resolver.c b/io/dns-resolver.c
> index ee7403b65b..03c59673f0 100644
> --- a/io/dns-resolver.c
> +++ b/io/dns-resolver.c
> @@ -128,6 +128,10 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
>  #endif
>              .has_keep_alive = iaddr->has_keep_alive,
>              .keep_alive = iaddr->keep_alive,
> +#ifdef HAVE_TCP_KEEPIDLE
> +            .has_keep_alive_idle_period = iaddr->has_keep_alive_idle_period,
> +            .keep_alive_idle_period = iaddr->keep_alive_idle_period,
> +#endif
>          };
>  
>          (*addrs)[i] = newaddr;

I feel like this code is somewhat fragile. It is probably best to add a
commit that refactors it to do a struct copy, and then override the few
fields that need to be different.

     newaddr->u.inet = iaddr;
     newaddr->u.inet.host = g_strdup(uaddr);
     ...

that way we don't risk forgetting to copy fields as fixed in the previous
commit

> diff --git a/meson.build b/meson.build
> index 41f68d3806..e3440b09c8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2734,6 +2734,8 @@ if linux_io_uring.found()
>    config_host_data.set('HAVE_IO_URING_PREP_WRITEV2',
>                         cc.has_header_symbol('liburing.h', 'io_uring_prep_writev2'))
>  endif
> +config_host_data.set('HAVE_TCP_KEEPIDLE',
> +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPIDLE'))
>  
>  # has_member
>  config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index eb50f64e3a..ddd82b1e66 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -59,6 +59,10 @@
>  # @keep-alive: enable keep-alive when connecting to/listening on this socket.
>  #     (Since 4.2, not supported for listening sockets until 10.0)
>  #
> +# @keep-alive-idle-period: time in seconds the connection needs to be idle
> +#     before sending a keepalive packet.  Only supported for TCP sockets on
> +#     systems where TCP_KEEPIDLE socket option is defined.  (Since 10.0)

There are three tunables for keepalive on TCP sockets:

   TCP_KEEPCNT (since Linux 2.4)
       The maximum number of keepalive probes TCP should send before
       dropping the connection.  This option should not be used in
       code intended to be portable.

   TCP_KEEPIDLE (since Linux 2.4)
       The time (in seconds) the connection needs to remain idle
       before TCP starts sending keepalive probes, if the socket
       option SO_KEEPALIVE has  been  set  on  this socket.  This
       option should not be used in code intended to be portable.

   TCP_KEEPINTVL (since Linux 2.4)
       The time (in seconds) between individual keepalive probes.
       This option should not be used in code intended to be portable.

Shouldn't we be supporting all of these, rather than just a subset ?

> +#
>  # @mptcp: enable multi-path TCP.  (Since 6.1)
>  #
>  # Since: 1.3
> @@ -71,6 +75,7 @@
>      '*ipv4': 'bool',
>      '*ipv6': 'bool',
>      '*keep-alive': 'bool',
> +    '*keep-alive-idle-period': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPIDLE' },
>      '*mptcp': { 'type': 'bool', 'if': 'HAVE_IPPROTO_MPTCP' } } }
>  
>  ##

> @@ -697,6 +710,22 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
>          }
>          addr->has_keep_alive = true;
>      }
> +#ifdef HAVE_TCP_KEEPIDLE
> +    begin = strstr(optstr, ",keep-alive-idle-period=");

A bit too verbose - make it just 'keep-alive-idle='

> +    if (begin) {
> +        begin += strlen(",keep-alive-idle-period=");
> +        if (sscanf(begin, "%" PRIu32 "%n", &addr->keep_alive_idle_period, &pos) != 1 ||
> +            (begin[pos] != '\0' && begin[pos] != ',')) {
> +            error_setg(errp, "error parsing keep-alive-idle-period argument");
> +            return -1;
> +        }
> +        if (addr->keep_alive_idle_period > INT_MAX) {
> +            error_setg(errp, "keep-alive-idle-period value is too large");
> +            return -1;
> +        }
> +        addr->has_keep_alive_idle_period = true;
> +    }
> +#endif
>  #ifdef HAVE_IPPROTO_MPTCP
>      begin = strstr(optstr, ",mptcp");
>      if (begin) {
> -- 
> 2.48.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


