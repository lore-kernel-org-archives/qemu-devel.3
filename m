Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DC0C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 08:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYhc0-0002b1-Q8; Mon, 07 Jul 2025 04:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uYhby-0002ZT-UH
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uYhbu-0006ES-Ra
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751878439;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HNzoGI/WOxah9EAQFYzMlrTefBr6Kjsui/DwKQBT9ag=;
 b=BrYGzM2FXtXezqvUplL+xHzExwU6n+B/ZpY1Fkvm6PJq3BVWKEukiw5MBHQZlbPDPrdV2m
 nQ5oLTMsiJE6rlX+06fIjYzh1KWxnQeswTxUQ4RncxWurhDRaS2KBTjhDoIxWzJGDEbseO
 i2QtaB+BGkyoq6EhxZpOQ1V1qwQvCLQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-FqrJghShP6-zGow3wPhTJA-1; Mon,
 07 Jul 2025 04:53:57 -0400
X-MC-Unique: FqrJghShP6-zGow3wPhTJA-1
X-Mimecast-MFC-AGG-ID: FqrJghShP6-zGow3wPhTJA_1751878436
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8984018DA5C0; Mon,  7 Jul 2025 08:53:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EE1230001BC; Mon,  7 Jul 2025 08:53:50 +0000 (UTC)
Date: Mon, 7 Jul 2025 09:53:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 10/11] net: Add passt network backend
Message-ID: <aGuLGfZMMcFz6Pfe@redhat.com>
References: <20250707081505.127519-1-lvivier@redhat.com>
 <20250707081505.127519-11-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250707081505.127519-11-lvivier@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jul 07, 2025 at 10:15:04AM +0200, Laurent Vivier wrote:
> This commit introduces support for passt as a new network backend.
> passt is an unprivileged, user-mode networking solution that provides
> connectivity for virtual machines by launching an external helper process.
> 
> The implementation reuses the generic stream data handling logic. It
> launches the passt binary using GSubprocess, passing it a file
> descriptor from a socketpair() for communication. QEMU connects to
> the other end of the socket pair to establish the network data stream.
> 
> The PID of the passt daemon is tracked via a temporary file to
> ensure it is terminated when QEMU exits.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  docs/system/devices/net.rst   |  40 +++++-
>  hmp-commands.hx               |   3 +
>  meson.build                   |   6 +
>  meson_options.txt             |   2 +
>  net/clients.h                 |   4 +
>  net/hub.c                     |   3 +
>  net/meson.build               |   3 +
>  net/net.c                     |   4 +
>  net/passt.c                   | 241 ++++++++++++++++++++++++++++++++++
>  qapi/net.json                 |  25 ++++
>  qemu-options.hx               |  44 ++++++-
>  scripts/meson-buildoptions.sh |   3 +
>  12 files changed, 374 insertions(+), 4 deletions(-)
>  create mode 100644 net/passt.c

snip

> +There is no need to start the daemon as QEMU will do it for you.
> +
> +passt is started in the socket-based mode.
> +
> +.. parsed-literal::
> +   |qemu_system| [...OPTIONS...] -nic passt
> +
> +   (qemu) info network
> +   e1000e.0: index=0,type=nic,model=e1000e,macaddr=52:54:00:12:34:56
> +    \ #net071: index=0,type=passt,stream,connected to pid 24846
> +
> +.. parsed-literal::
> +   |qemu_system| [...OPTIONS...] -net nic -net passt,param=--tcp-ports=10001,param=udp-ports=10001

Missing '--' before 'udp-ports=', but ...


> diff --git a/qapi/net.json b/qapi/net.json
> index 97ea1839813b..8a8528ba1f47 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -112,6 +112,26 @@
>    'data': {
>      'str': 'str' } }
>  
> +##
> +# @NetDevPasstOptions:
> +#
> +# Unprivileged user-mode network connectivity using passt
> +#
> +# @path: Filename of the passt program to run (by default 'passt', and use PATH)
> +#
> +# @quiet: don't print informational messages (default, passed as '--quiet')
> +#
> +# @param: parameter to pass to passt command
> +#
> +# Since: 10.1
> +##
> +{ 'struct': 'NetDevPasstOptions',
> +  'data': {
> +    '*path':               'str',
> +    '*quiet':              'bool',
> +    '*param':             ['String'] },
> +    'if': 'CONFIG_PASST' }

.... IMHO this is a really horrible way to wire this up into QEMU,
which largely defeats the benefit of having a passt network backend.

It throws away all type validation of passt parameters at the QEMU
level, which is one of the more compelling aspects of using QAPI/QMP,
especially on the JSON side. One the CLI side, the argv is really
horrible to read, even by QEMU's low-standards.

I'd much rather see v2 of this patchset. If users need to have
full control over every conceivable passt option at all times,
then the existing way passt is used with QEMU continues to exist
and isn't significantly more complicated than this v3 series.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


