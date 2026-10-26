Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845B60A260E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KFLAmSe8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLIuD-000842-Ke; Mon, 26 Oct 2026 07:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLIuA-00083N-Sf
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLIu8-0001IP-3U
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793014214;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xBec8mRSRg053NN56cKqOhLcYou/rJlajMQ/Zuc+KxU=;
 b=KFLAmSe8XAA1qaSL4CTBBPrje3IPtDFfr1MvX2iQKNj/UblonitVQ9yKmeM0jPGysRzBrx
 9TwAoQbdbpYCYMPoeBsPNnng/2kHDDzFSVtsEcicTAxGvVL2+6rSapE0sdBskcJyxg/awg
 dOEDIFlQdfGMUkupJRumyyweZiGULj8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-A_XJTYmtO_WvYyQYVMq3Eg-1; Mon,
 26 Oct 2026 07:30:04 -0400
X-MC-Unique: A_XJTYmtO_WvYyQYVMq3Eg-1
X-Mimecast-MFC-AGG-ID: A_XJTYmtO_WvYyQYVMq3Eg_1793014203
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3122419560BD; Mon, 26 Oct 2026 11:30:03 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EC6A18004D2; Mon, 26 Oct 2026 11:29:59 +0000 (UTC)
Date: Mon, 26 Oct 2026 11:29:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tim Pambor <timpambor@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-block@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>,
 Brad Smith <brad@comstyle.com>
Subject: Re: [PATCH 3/8] io/channel-socket: only clear O_NONBLOCK on received
 fds if set
Message-ID: <at85tCIzl2Buw6Yy@redhat.com>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
 <20261022-vhost-user-posix-v1-3-0bd4d450d23c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261022-vhost-user-posix-v1-3-0bd4d450d23c@gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 03:47:24PM +0200, Tim Pambor wrote:
> After receiving descriptors with SCM_RIGHTS the socket channel resets
> O_NONBLOCK on each of them with fcntl(F_SETFL).  macOS rejects F_SETFL
> on POSIX shared memory descriptors, so every message carrying such a
> descriptor caused the connection to drop.  Those descriptors are passed
> in blocking mode anyway, so there is nothing to change on them.  Query
> the flags with F_GETFL first and only issue F_SETFL when O_NONBLOCK is
> actually set.
> 
> Signed-off-by: Tim Pambor <timpambor@gmail.com>
> ---
>  io/channel-socket.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 7920cee639..1785fd5bfe 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -520,8 +520,23 @@ static bool qio_channel_handle_fds(int *fds, size_t nfds,
>          }
>  
>          if (!preserve_blocking) {
> -            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> -            if (!qemu_set_blocking(*fd, true, errp)) {
> +            /*
> +             * O_NONBLOCK is preserved across SCM_RIGHTS so reset it.
> +             *
> +             * Some descriptors reject F_SETFL outright, e.g. POSIX
> +             * shared memory on macOS.  They are passed in blocking
> +             * mode anyway, so only touch descriptors that have it set.
> +             */
> +            int flags = fcntl(*fd, F_GETFL);
> +
> +            if (flags < 0) {
> +                error_setg_errno(errp, errno,
> +                                 "Can't get file descriptor %d flags", *fd);
> +                return false;
> +            }
> +
> +            if ((flags & O_NONBLOCK) &&
> +                !qemu_set_blocking(*fd, true, errp)) {

I'd be inclined to put this logic in qemu_set_blocking itself
so that it does the right thing for all possible callers.

At that point we might as well get rid of the use of
g_unix_set_fd_nonblocking in that function and directly call
fcntl so we avoid the duplicate F_GETFL calls, eg something more
like:

  int flags, newflags;
  flag = fcntl(fd, F_GETFL);
  if (flags < 0) {
     error_setg_errno(....)
     return -1;
  }

  if (nonblock)
    newflags = flags | O_NONBLOCK;
  else
    newflags = flags & ~O_NONBLOCK;

  if (newflags != flags &&
      fcntl(fd, F_SETFL, newflags) < 0) {
     error_setg_errno(...);
     return -1;
  }

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


