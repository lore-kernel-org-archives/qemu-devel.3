Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF460A2607
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UQmx0Zwr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRWcO-0007eV-RF; Thu, 12 Nov 2026 10:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRWcL-0007YV-AG
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:21:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRWcI-0002r6-5u
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794496892;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xL27Qnh1LeoJesx+xJ40+T5UAhU6f/u8TDIewYDYa3U=;
 b=UQmx0ZwrlbY4fXD0l8HNvBISnNMXmKPkvsoLAZIAPD24nfXRIEXfSMQP0AR0D7P/yUhOjS
 Ea1e7WXSrQoptXS/LBU+diT6e6r9mEbI0w7P54zOs176gBV4rVYrnRdgiV35oOqGAxULGl
 HoLe5Ztrf8zwMRNKbaBhNDAZui3fRGA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-62LQV_KrPgSyvAAQDm4fJQ-1; Thu,
 12 Nov 2026 10:21:27 -0500
X-MC-Unique: 62LQV_KrPgSyvAAQDm4fJQ-1
X-Mimecast-MFC-AGG-ID: 62LQV_KrPgSyvAAQDm4fJQ_1794496885
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BAA8180061F; Thu, 12 Nov 2026 15:21:25 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AD431800495; Thu, 12 Nov 2026 15:21:22 +0000 (UTC)
Date: Thu, 12 Nov 2026 15:21:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gavin Li <gavin.li@samsara.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v1] net: add per-connection guestfwd unix support
Message-ID: <avXZcIP3t8DExhse@redhat.com>
References: <20261107044225.2786-1-gavin.li@samsara.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261107044225.2786-1-gavin.li@samsara.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 11:42:25PM -0500, Gavin Li wrote:
> For -netdev user,guestfwd=..., add support for unix-per-connection: in
> addition to the currently supported tcp: and cmd:. With
> unix-per-connection:, a new connection is opened to the given unix
> socket.  This is an improvement over the current unix: support, which
> does not support 1:1 guest:host connections.

I'm not familiar with guestfwd, but from the manpage, I would
rather assume that it always opens a new connection to the host
socket for each guest connection. What are its current semantics
when two guest connections are initiated on the same port, if
that's not happening ? 

> 
> Also update the minimum libslirp version to 4.2.0 (released in 2020) as
> it adds support for the slirp_add_unix() function.
> 
> Signed-off-by: Gavin Li <gavin.li@samsara.com>
> ---
>  meson.build     | 2 +-
>  net/slirp.c     | 6 ++++++
>  qemu-options.hx | 9 +++++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index d7bcb581c1..6567ede5d9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1289,7 +1289,7 @@ endif
>  slirp = not_found
>  if not get_option('slirp').auto() or have_system
>    slirp = dependency('slirp', required: get_option('slirp'),
> -                     method: 'pkg-config')
> +                     method: 'pkg-config', version: '>=4.2.0')
>    # slirp < 4.7 is incompatible with CFI support in QEMU.  This is because
>    # it passes function pointers within libslirp as callbacks for timers.
>    # When using a system-wide shared libslirp, the type information for the
> diff --git a/net/slirp.c b/net/slirp.c
> index 451c0fd1ba..b0b03b2bf5 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -1159,6 +1159,12 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp)
>                         "forwarding rule '%s'", config_str);
>              return -1;
>          }
> +    } else if (g_str_has_prefix(p, "unix-per-connection:")) {

This is rather a mouthful as a parameter name, and including '-'
in the name is undesirable, since we're already using '-' as a
general separator. Could it be just 'unix' to match the use
of 'unix' in hostfwd ?



> +        if (slirp_add_unix(s->slirp, &p[20], &server, port) < 0) {
> +            error_setg(errp, "Conflicting/invalid host:port in guest "
> +                       "forwarding rule '%s'", config_str);
> +            return -1;
> +        }
>      } else {
>          Error *err = NULL;
>          /*
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5fe9d73eaa..062cd39aa3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3553,6 +3553,15 @@ SRST
>              # and connect the TCP stream to its stdin/stdout
>              |qemu_system| -nic  'user,id=n1,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321'
>  
> +    ``guestfwd=[tcp]:server:port-unix-per-connection:path``
> +        With ``unix-per-connection:``, a new connection is opened to the
> +        given unix socket per TCP connection made by the guest. The unix socket
> +        need not exist at startup time.

I think the existing docs probably benefit from an update to
better show how the new parmeter is different from what I
would think was already the semantics.

> +
> +        .. parsed-literal::
> +
> +            |qemu_system| -nic user,guestfwd=tcp:10.0.2.100:1234-unix-per-connection:/tmp/socket
> +
>  ``-netdev tap,id=id[,fd=h][,ifname=name][,script=file][,downscript=dfile][,br=bridge][,helper=helper]``
>      Configure a host TAP network backend with ID id.
>  
> 
> base-commit: 71f25c75417d31c214ba2cd26b273c114fc99987
> -- 
> 2.55.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


