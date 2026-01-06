Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08797CDC192
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 12:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd6Na-0005KT-9y; Tue, 06 Jan 2026 07:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vd6NV-0005Gq-DD
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 07:41:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vd6NT-0001iV-87
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 07:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767703293;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2jtZLrqQ4QNSFAn6GuOeEC9yVTMIwp3/FYOJPoTM6gc=;
 b=PvfxGM26xE+8l8Rer+lDmLcRdjnkdDTerT06zZ691FeT4gKcAcGHoTZgl0aaICcqPfNHo8
 cNv46DO3KjggOjtNPR5I3jiWI3PjwiphWjp87cEUBK5HF4bqj8wwoWUJe7eeeUPLJueqI2
 p2QbWwvWtGYYLbxEw6UosmCr85N9U2Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-WNQV9t0LN3CgS4Uy8HKGPA-1; Tue,
 06 Jan 2026 07:41:29 -0500
X-MC-Unique: WNQV9t0LN3CgS4Uy8HKGPA-1
X-Mimecast-MFC-AGG-ID: WNQV9t0LN3CgS4Uy8HKGPA_1767703289
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E2441955F3F; Tue,  6 Jan 2026 12:41:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D31A919560AB; Tue,  6 Jan 2026 12:41:27 +0000 (UTC)
Date: Tue, 6 Jan 2026 12:41:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v1] io/channel-socket: abort socket reads after a
 force shutdown request
Message-ID: <aV0C9J7086dvHYoE@redhat.com>
References: <20250910085006.69790-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910085006.69790-1-d-tatianin@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, Sep 10, 2025 at 11:50:06AM +0300, Daniil Tatianin wrote:
> When a user chooses to force shutdown QEMU by pressing ^C or sending a
> SIGINT otherwise, we want to shutdown as soon as possible, and entering
> a blocking read which happens in the main thread seems like the opposite
> of that.
> 
> This may seem like a rare case, but it is actually not when using
> vhost-user devices, which usually have the control plane working via
> UNIX sockets.
> 
> The way the code is currently written, all vhost-user devices are
> serviced in the main thread and thus block each other, as well as other
> things that happen in the QEMU's main thread, including QMP, and even
> network devices that are not vhost-net.
> 
> In case the vhost-user backend servicing a device decides to hang for
> whatever reason, any control plane request in QEMU will also hang the
> main loop until the backend either dies or ends up replying.
> 
> Ideally the vhost-user handling code should be rewritten to work
> asynchronously, or to support io-threads or similar, but that seems like
> a giant undertaking and we would like to at least be able to make QEMU
> shutdown no matter if a vhost-user backend is currently able to service
> the control plane or not.

This sounds like rather a major impl flaw in the vhost-user code
IMHO. Anything that is running in the main thread needs to have
very fast execution times, without any blocking on I/O, to avoid
starving the main event loop. The event loop starvation is really
a much bigger problem than the delayed shutdown on ctrl-c.

I'm not familiar with the vhost-user code, but can you share an
example of the stack trace you see when it is blocked on an I/O
op and preventing shutdown ?

I'm very dis-inclined to special case the channel-socket.c code
to workaruond a bug in a single part of qemu, given that this
code is used universally across everything doing socket I/O.

Some of these parts of QEMU potentially want to be able to do
a clean shutdown of their I/O layer when QEMU exit, and not
restarting on EINTR might negatively impact them. IOW, this
proposed workaround may well simply move the brokness from
one place to another place and not leave us better overall.

> Luckily for us, SIGINT or similar causes the kernel to cancel (almost)
> all blocking syscalls with EINTR, which we can utilize to check whether
> a shutdown was requested while we were blocked in the syscall, which is
> what this commit does. The check is performed even on the first attempt,
> not only retries after EINTR. This is intentional to avoid race
> conditions where QEMU may decide to perform a control plane request
> before the shutdown event is checked for thus forcing the user to send
> SIGINT at least 2 times.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
> v0 -> v1:
> - Fix code alignment
> - Fix included header
> ---
>  io/channel-socket.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 3b7ca924ff..74238b511a 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -26,10 +26,20 @@
>  #include "io/channel-watch.h"
>  #include "trace.h"
>  #include "qapi/clone-visitor.h"
> +#include "system/runstate.h"
>  #ifdef CONFIG_LINUX
>  #include <linux/errqueue.h>
>  #include <sys/socket.h>
>  
> +/*
> + * This function is not available when io links against qemu-img etc.,
> + * in this case just pretend it always returns false.
> + */
> +__attribute__((weak)) bool qemu_force_shutdown_requested(void)
> +{
> +    return false;
> +}
> +
>  #if (defined(MSG_ZEROCOPY) && defined(SO_ZEROCOPY))
>  #define QEMU_MSG_ZEROCOPY
>  #endif
> @@ -541,6 +551,12 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
>      }
>  
>   retry:
> +    if (qemu_force_shutdown_requested()) {
> +        error_setg_errno(errp, ECANCELED,
> +                         "Socket read aborted due to force shutdown");
> +        return -1;
> +    }
> +
>      ret = recvmsg(sioc->fd, &msg, sflags);
>      if (ret < 0) {
>          if (errno == EAGAIN) {
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


