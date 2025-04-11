Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C5EC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3EqJ-0002AM-FZ; Fri, 11 Apr 2025 09:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3EqA-00029d-Es
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3Eq7-0003Zf-Cz
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744379678;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XMq+3XtJUiNnp3ekwHQ8SyTRNOsfYl+zThPB+vaXiZU=;
 b=PEtZVTiIquVVvfo7oyiG51vLovlB5nPDSc8xuYPe4a6lRW5pMZcttRiaOUFyyMHwGWXlM3
 eTP227Llm7Npna17aeZXLwpk2PLApsjzvxksZaQt4JGKEyKCkhT5YQda8IfSaubcSVixOi
 /Kkn7i5ZxOo8ASULb//33lIGBAak4dI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-h6qa1rDcPWaqx7r7bgc6cg-1; Fri,
 11 Apr 2025 09:54:35 -0400
X-MC-Unique: h6qa1rDcPWaqx7r7bgc6cg-1
X-Mimecast-MFC-AGG-ID: h6qa1rDcPWaqx7r7bgc6cg_1744379674
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 597C9180899B; Fri, 11 Apr 2025 13:54:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94B663001D15; Fri, 11 Apr 2025 13:54:32 +0000 (UTC)
Date: Fri, 11 Apr 2025 14:54:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 5/5] utils/qemu-sockets: Introduce inet socket options
 controlling TCP keep-alive
Message-ID: <Z_kfFTiGkK0dC73f@redhat.com>
References: <20250408112508.1638722-1-jmarcin@redhat.com>
 <20250408112508.1638722-6-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408112508.1638722-6-jmarcin@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 08, 2025 at 01:25:04PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> With the default TCP stack configuration, it could be even 2 hours
> before the connection times out due to the other side not being
> reachable. However, in some cases, the application needs to be aware of
> a connection issue much sooner.
> 
> This is the case, for example, for postcopy live migration. If there is
> no traffic from the migration destination guest (server-side) to the
> migration source guest (client-side), the destination keeps waiting for
> pages indefinitely and does not switch to the postcopy-paused state.
> This can happen, for example, if the destination QEMU instance is
> started with the '-S' command line option and the machine is not started
> yet, or if the machine is idle and produces no new page faults for
> not-yet-migrated pages.
> 
> This patch introduces new inet socket parameters that control count,
> idle period, and interval of TCP keep-alive packets before the
> connection is considered broken. These parameters are available on
> systems where the respective TCP socket options are defined
> (TCP_KEEPCNT, TCP_KEEPIDLE, TCP_KEEPINTVL).
> 
> The default value for all is 0, which means the system configuration is
> used.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  meson.build         |  6 ++++
>  qapi/sockets.json   | 15 ++++++++
>  util/qemu-sockets.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 41f68d3806..680f47cf42 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2734,6 +2734,12 @@ if linux_io_uring.found()
>    config_host_data.set('HAVE_IO_URING_PREP_WRITEV2',
>                         cc.has_header_symbol('liburing.h', 'io_uring_prep_writev2'))
>  endif
> +config_host_data.set('HAVE_TCP_KEEPCNT',
> +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPCN'T))
> +config_host_data.set('HAVE_TCP_KEEPIDLE',
> +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPIDLE'))
> +config_host_data.set('HAVE_TCP_KEEPINTVL',
> +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPINTVL'))

What platforms are you aware of that do NOT have these
settings available ? I'm wondering if we can just assume
they always exist.

>  
>  # has_member
>  config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index 62797cd027..bb9d298635 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -59,6 +59,18 @@
>  # @keep-alive: enable keep-alive when connecting to/listening on this socket.
>  #     (Since 4.2, not supported for listening sockets until 10.1)
>  #
> +# @keep-alive-count: number of keep-alive packets sent before the connection is
> +#     closed.  Only supported for TCP sockets on systems where TCP_KEEPCNT
> +#     socket option is defined.  (Since 10.1)
> +#
> +# @keep-alive-idle: time in seconds the connection needs to be idle before
> +#     sending a keepalive packet.  Only supported for TCP sockets on systems
> +#     where TCP_KEEPIDLE socket option is defined.  (Since 10.1)
> +#
> +# @keep-alive-interval: time in secods between keep-alive packets.  Only

Trivial typo s/secods/seconds/

> +#     supported for TCP sockets on systems where TCP_KEEPINTVL is defined.
> +#     (Since 10.1)
> +#
>  # @mptcp: enable multi-path TCP.  (Since 6.1)
>  #
>  # Since: 1.3
> @@ -71,6 +83,9 @@
>      '*ipv4': 'bool',
>      '*ipv6': 'bool',
>      '*keep-alive': 'bool',
> +    '*keep-alive-count': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPCNT' },
> +    '*keep-alive-idle': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPIDLE' },
> +    '*keep-alive-interval': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPINTVL' },
>      '*mptcp': { 'type': 'bool', 'if': 'HAVE_IPPROTO_MPTCP' } } }
>  
>  ##

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


