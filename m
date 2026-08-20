Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34617C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0Ik-00084e-1N; Thu, 20 Aug 2026 06:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wx0Ij-00084J-00
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wx0Ih-0005cB-CJ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787222829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M+U6qaYNydOPxWrJ6wsFwZFbNXGWnhTqQborUxUW6D8=;
 b=idjDSKh6Sq6Kyx31yltl2jXtfpgaXfzJKFIyjfu4Lmn91dCONLcHz78uoYZTg7zY6P5RZ3
 Sf7S78wYmhbRvHkXOBY/bujDUUmLf0MGQ1w63v2JY88GhbRk9mjiI8aCwd1ZmaxR5JwFC0
 8cBvLwumfQkuFcwO4E96vE77tYdx3pc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-GDcNL4IkNVSkY-7dIHEGpQ-1; Thu,
 20 Aug 2026 06:47:05 -0400
X-MC-Unique: GDcNL4IkNVSkY-7dIHEGpQ-1
X-Mimecast-MFC-AGG-ID: GDcNL4IkNVSkY-7dIHEGpQ_1787222824
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF5B31956046; Thu, 20 Aug 2026 10:47:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 469D31955F04; Thu, 20 Aug 2026 10:47:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB21821E6920; Thu, 20 Aug 2026 12:47:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Rohitashv Kumar <rohit.kuma1313@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,  qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,  Eric Blake <eblake@redhat.com>,  Rohitashv
 Kumar <roohiit@amazon.de>
Subject: Re: [PATCH] qapi/net: gate user/vde/netmap netdev backends behind
 their CONFIG symbols
In-Reply-To: <20260728144303.223207-1-rohit.kuma1313@gmail.com> (Rohitashv
 Kumar's message of "Tue, 28 Jul 2026 14:43:03 +0000")
References: <20260728144303.223207-1-rohit.kuma1313@gmail.com>
Date: Thu, 20 Aug 2026 12:47:00 +0200
Message-ID: <87mruh3w7v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Rohitashv Kumar <rohit.kuma1313@gmail.com> writes:

> From: Rohitashv Kumar <roohiit@amazon.de>
>
> Their NetClientDriver enum members and Netdev union branches were
> unconditional, so query-qmp-schema advertised them even when built without
> CONFIG_SLIRP/CONFIG_VDE/CONFIG_NETMAP. Gate them, and guard the matching
> NET_CLIENT_DRIVER_USER/_VDE case labels in net/hub.c.
>
> Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
> ---
>  net/hub.c     |  4 ++++
>  qapi/net.json | 19 +++++++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/net/hub.c b/net/hub.c
> index ee5881f6d5..2a7c2bc6d7 100644
> --- a/net/hub.c
> +++ b/net/hub.c
> @@ -294,12 +294,16 @@ void net_hub_check_clients(void)
>  #ifdef CONFIG_PASST
>              case NET_CLIENT_DRIVER_PASST:
>  #endif
> +#ifdef CONFIG_SLIRP
>              case NET_CLIENT_DRIVER_USER:
> +#endif
>              case NET_CLIENT_DRIVER_TAP:
>              case NET_CLIENT_DRIVER_SOCKET:
>              case NET_CLIENT_DRIVER_STREAM:
>              case NET_CLIENT_DRIVER_DGRAM:
> +#ifdef CONFIG_VDE
>              case NET_CLIENT_DRIVER_VDE:
> +#endif
>              case NET_CLIENT_DRIVER_VHOST_USER:
>                  has_host_dev = 1;
>                  break;
> diff --git a/qapi/net.json b/qapi/net.json
> index 1a6382825c..e9f1300629 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -922,9 +922,13 @@
>  # Since: 2.7
>  ##
>  { 'enum': 'NetClientDriver',
> -  'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'stream',
> -            'dgram', 'vde', 'bridge', 'hubport', 'netmap', 'vhost-user',
> -            'vhost-vdpa',
> +  'data': [ 'none', 'nic',
> +            { 'name': 'user', 'if': 'CONFIG_SLIRP' },
> +            'tap', 'l2tpv3', 'socket', 'stream', 'dgram',
> +            { 'name': 'vde', 'if': 'CONFIG_VDE' },
> +            'bridge', 'hubport',
> +            { 'name': 'netmap', 'if': 'CONFIG_NETMAP' },
> +            'vhost-user', 'vhost-vdpa',
>              { 'name': 'passt', 'if': 'CONFIG_PASST' },
>              { 'name': 'af-xdp', 'if': 'CONFIG_AF_XDP' },
>              { 'name': 'vmnet-host', 'if': 'CONFIG_VMNET' },
> @@ -949,16 +953,19 @@
>      'nic':      'NetLegacyNicOptions',
>      'passt':    { 'type': 'NetdevPasstOptions',
>                    'if': 'CONFIG_PASST' },
> -    'user':     'NetdevUserOptions',
> +    'user':     { 'type': 'NetdevUserOptions',
> +                  'if': 'CONFIG_SLIRP' },
>      'tap':      'NetdevTapOptions',
>      'l2tpv3':   'NetdevL2TPv3Options',
>      'socket':   'NetdevSocketOptions',
>      'stream':   'NetdevStreamOptions',
>      'dgram':    'NetdevDgramOptions',
> -    'vde':      'NetdevVdeOptions',
> +    'vde':      { 'type': 'NetdevVdeOptions',
> +                  'if': 'CONFIG_VDE' },
>      'bridge':   'NetdevBridgeOptions',
>      'hubport':  'NetdevHubPortOptions',
> -    'netmap':   'NetdevNetmapOptions',
> +    'netmap':   { 'type': 'NetdevNetmapOptions',
> +                  'if': 'CONFIG_NETMAP' },
>      'af-xdp':   { 'type': 'NetdevAFXDPOptions',
>                    'if': 'CONFIG_AF_XDP' },
>      'vhost-user': 'NetdevVhostUserOptions',

Any occurence of NET_CLIENT_DRIVER_USER, NET_CLIENT_DRIVER_VDE,
NET_CLIENT_DRIVER_NETMAP must now be properly guarded the same way.

The patch fixes up the ones in net/hub.c.

Checking the other ones:

* all three in net/net.c: already guarded by the same #ifdef

* _USER in net/slirp.c: net/meson.build compiles it only when: slirp

* _VDE in net/vde.c: net/meson.build compiles it only when: vde

* _NETMAP in net/netmap.c: net/meson.build compiles it only
  if have_netmap

Good.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


