Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED95CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 04:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUH8y-00008Y-55; Tue, 02 Jun 2026 00:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUH8u-00007j-Ab
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 00:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUH8s-0001RD-2x
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 00:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780376056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ygYoqFHcospyqBOi/iJELgsJMGA+Dql+S93uYrPF/cc=;
 b=BeAHp7e8d7GwE/orNYq6dpeadh1R1nZTXyD6+0RjvgWOk0UkWuYslW0JZqiZZ7IqDLpzDP
 xlptTFIy0K6iTW2x74WA/qcWoH9UYAtFb3E1CbAhGbRFyRa9Fkce2dX+XrQLpyQAjWMY1p
 ZXAFXJtDquPlhHj84gih4XTTfeIVhDo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-IVxeFcnpOIOhd3I5cRs8aA-1; Tue,
 02 Jun 2026 00:54:14 -0400
X-MC-Unique: IVxeFcnpOIOhd3I5cRs8aA-1
X-Mimecast-MFC-AGG-ID: IVxeFcnpOIOhd3I5cRs8aA_1780376053
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0313619560AA; Tue,  2 Jun 2026 04:54:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1379C1800465; Tue,  2 Jun 2026 04:54:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 556A221E6A01; Tue, 02 Jun 2026 06:54:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 4/5] util/qemu-sockets: add TCP_USER_TIMEOUT support
In-Reply-To: <20260524073442.435408-5-Mitsuru.Kariya@oss.nttdata.com> (Mitsuru
 Kariya's message of "Sun, 24 May 2026 16:34:41 +0900")
References: <20260524073442.435408-1-Mitsuru.Kariya@oss.nttdata.com>
 <20260524073442.435408-5-Mitsuru.Kariya@oss.nttdata.com>
Date: Tue, 02 Jun 2026 06:54:09 +0200
Message-ID: <87se758rv2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com> writes:

> The TCP_USER_TIMEOUT socket option (Linux-only) specifies the maximum
> amount of time in milliseconds that transmitted data may remain
> unacknowledged, or buffered data may remain untransmitted, before TCP
> forcibly closes the connection and returns ETIMEDOUT to the
> application.  Without it, a peer that becomes silently unreachable can
> take well over an hour to be noticed (the kernel default), which is
> particularly painful for use cases like QEMU live migration.
>
> Expose user-timeout as a new optional InetSocketAddress member, gated
> on a new HAVE_TCP_USER_TIMEOUT meson check, and apply it in
> inet_set_sockopts() alongside the existing keep-alive options.  Plumb
> the same option through the legacy QemuOpts-based inet_parse() path so
> that URI-style users (-incoming tcp:, migrate tcp:, HMP
> nbd_server_start, ...) can set it too.
>
> Update the documentation for -netdev stream (addr.user-timeout=N) and
> -incoming tcp: (user-timeout=N, flat key as for the other inet_opts
> entries), and extend test_inet_parse_all_options_good accordingly.
>
> Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
> ---
>  meson.build                    |  2 ++
>  qapi/sockets.json              |  7 +++++++
>  qemu-options.hx                | 13 +++++++++----
>  tests/unit/test-util-sockets.c | 13 +++++++++++++
>  util/qemu-sockets.c            | 24 ++++++++++++++++++++++++
>  5 files changed, 55 insertions(+), 4 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index eb07491819..c5afe8754d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2726,6 +2726,8 @@ config_host_data.set('HAVE_TCP_KEEPINTVL',
>                       #endif
>                       int main(void) { return 0; }''',
>                       name: 'Win32 TCP_KEEPINTVL'))
> +config_host_data.set('HAVE_TCP_USER_TIMEOUT',
> +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_USER_TIMEOUT'))
>  
>  # has_member
>  config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index 473be2ac58..543689a2c7 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -79,6 +79,12 @@
>  #     defined (this includes Linux, Windows, macOS, FreeBSD, but not
>  #     OpenBSD).  When set to 0, system setting is used.  (Since 10.1)
>  #
> +# @user-timeout: time in milliseconds that transmitted data may remain
> +#     unacknowledged before the connection is closed.  Only supported
> +#     for TCP sockets on systems where TCP_USER_TIMEOUT socket option
> +#     is defined (Linux only).  When set to 0, system setting is used.
> +#     (Since 11.1)
> +#

Actually, it's "transmitted data may remain unacknowledged, or buffered
data may remain untransmitted".  Moreover, the interaction with
@keep-alive is not mentioned.  We want to keep the description
reasonably short, though.  Have it point to tcp(7) for details?

Perhaps something like

  # @user-timeout: time in milliseconds that transmitted data may remain
  #     unacknowledged, or buffered data may remain untransmitted before
  #     the connection is closed.  See tcp(7) for details.  Only
  #     supported when the host provides socket option TCP_USER_TIMEOUT
  #     (Linux).  0 means system default.  (default 0) (since 11.1)

What do you think?

>  # @mptcp: enable multi-path TCP.  (Since 6.1)
>  #
>  # Since: 1.3
> @@ -94,6 +100,7 @@
>      '*keep-alive-count': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPCNT' },
>      '*keep-alive-idle': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPIDLE' },
>      '*keep-alive-interval': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPINTVL' },
> +    '*user-timeout': { 'type': 'uint32', 'if': 'HAVE_TCP_USER_TIMEOUT' },
>      '*mptcp': { 'type': 'bool', 'if': 'HAVE_IPPROTO_MPTCP' } } }
>  
>  ##
> diff --git a/qemu-options.hx b/qemu-options.hx
> index d2b816e16f..63587cccd3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3034,7 +3034,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>      "-netdev socket,id=str[,fd=h][,udp=host:port][,localaddr=host:port]\n"
>      "                configure a network backend to connect to another network\n"
>      "                using an UDP tunnel\n"
> -    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]\n"
> +    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.user-timeout=timeout][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]\n"
>      "-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,addr.abstract=on|off][,addr.tight=on|off][,reconnect-ms=milliseconds]\n"
>      "-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect-ms=milliseconds]\n"
>      "                configure a network backend to connect to another network\n"
> @@ -3640,7 +3640,7 @@ SRST
>                           -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
>                           -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
>  
> -``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]``
> +``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.user-timeout=timeout][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]``
>      Configure a network backend to connect to another QEMU virtual machine or a proxy using a TCP/IP socket.
>  
>      ``server=on|off``
> @@ -3670,6 +3670,11 @@ SRST
>          time in seconds between individual keep-alive packets.
>          Set to 0 to use the system default.  (default: 0)
>  
> +    ``addr.user-timeout=timeout``
> +        time in milliseconds that transmitted data may remain unacknowledged
> +        before the connection is forcibly closed.
> +        Set to 0 to use the system default.  (default: 0)
> +

If you improve the description in net.json, update this one to match it.

>      ``addr.mptcp=on|off``
>          enable multipath TCP
>  
> @@ -5365,7 +5370,7 @@ SRST
>  ERST
>  
>  DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
> -    "-incoming tcp:[host]:port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,keep-alive-count=count][,keep-alive-idle=idle][,keep-alive-interval=interval][,mptcp=on|off][,ipv4=on|off][,ipv6=on|off]\n" \
> +    "-incoming tcp:[host]:port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,keep-alive-count=count][,keep-alive-idle=idle][,keep-alive-interval=interval][,user-timeout=timeout][,mptcp=on|off][,ipv4=on|off][,ipv6=on|off]\n" \
>      "-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]\n" \
>      "-incoming unix:socketpath\n" \
>      "                prepare for incoming migration, listen on\n" \
> @@ -5387,7 +5392,7 @@ migration channel types.  The channel type is specified in <channel>,
>  or is 'main' for all other forms of -incoming.  If multiple -incoming
>  options are specified for a channel type, the last one takes precedence.
>  
> -``-incoming tcp:[host]:port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,keep-alive-count=count][,keep-alive-idle=idle][,keep-alive-interval=interval][,mptcp=on|off][,ipv4=on|off][,ipv6=on|off]``
> +``-incoming tcp:[host]:port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,keep-alive-count=count][,keep-alive-idle=idle][,keep-alive-interval=interval][,user-timeout=timeout][,mptcp=on|off][,ipv4=on|off][,ipv6=on|off]``
>    \ 
>  ``-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]``
>      Prepare for incoming migration, listen on a given tcp port.

[...]


