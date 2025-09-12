Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF2BCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 17:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux7E0-0007vJ-U9; Fri, 12 Sep 2025 13:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux7Dy-0007ky-CJ
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 13:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux7Du-0002dt-Bp
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 13:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757696769;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PVmQnrtFEc7GX3mV8mVfYuYR/OSRs7RshL/e+MNZ360=;
 b=IBwGCKN4ES8VhMHzWolQXZsgKsiEaUhsZCFlZzYpdClxncAAq5k3y0plf0LgcGY2BS17ZL
 3WKhoVEQcFt/X2TRqOdlf8ihsN9T3te2pA5kBUg+Bpb9/yt6uCK3V5UYpyl8Yuh6D/AC8/
 scvrVbhq1NSI+3FTndHlqHQiqpB/91w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554--a2jInKwNSGI9Ru-p1Bsuw-1; Fri,
 12 Sep 2025 13:06:06 -0400
X-MC-Unique: -a2jInKwNSGI9Ru-p1Bsuw-1
X-Mimecast-MFC-AGG-ID: -a2jInKwNSGI9Ru-p1Bsuw_1757696765
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E51401955EA8; Fri, 12 Sep 2025 17:06:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F01618004D8; Fri, 12 Sep 2025 17:06:02 +0000 (UTC)
Date: Fri, 12 Sep 2025 18:05:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com
Subject: Re: [PATCH v2 6/8] io/channel-socket: rework
 qio_channel_socket_copy_fds()
Message-ID: <aMRS9kVQg70m_JWX@redhat.com>
References: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
 <20250911092007.1370002-7-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911092007.1370002-7-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Sep 11, 2025 at 12:20:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> We want to switch from qemu_socket_set_block() to newer
> qemu_set_blocking(), which provides return status of operation,
> to handle errors.
> 
> Still, we want to keep qio_channel_socket_readv() interface clean,
> as currently it set @fds and @nfds only on success.
> 
> So, in case of error, we should to close all incoming fds and don't
> touch user's @fds and @nfds.
> 
> Let's make separate functions qio_channel_handle_fds() and
> qio_channel_cleanup_fds(), to achieve what we want.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  io/channel-socket.c | 73 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 57 insertions(+), 16 deletions(-)
> 
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index f7e3cb9742..afae97b2ef 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -464,8 +464,7 @@ static void qio_channel_socket_finalize(Object *obj)
>  
>  #ifndef WIN32
>  static void qio_channel_socket_copy_fds(struct msghdr *msg,
> -                                        int **fds, size_t *nfds,
> -                                        bool preserve_blocking)
> +                                        int **fds, size_t *nfds)
>  {
>      struct cmsghdr *cmsg;
>  
> @@ -473,7 +472,7 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
>      *fds = NULL;
>  
>      for (cmsg = CMSG_FIRSTHDR(msg); cmsg; cmsg = CMSG_NXTHDR(msg, cmsg)) {
> -        int fd_size, i;
> +        int fd_size;
>          int gotfds;
>  
>          if (cmsg->cmsg_len < CMSG_LEN(sizeof(int)) ||
> @@ -491,24 +490,54 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
>          gotfds = fd_size / sizeof(int);
>          *fds = g_renew(int, *fds, *nfds + gotfds);
>          memcpy(*fds + *nfds, CMSG_DATA(cmsg), fd_size);
> +        *nfds += gotfds;
> +    }
> +}
>  
> -        for (i = 0; i < gotfds; i++) {
> -            int fd = (*fds)[*nfds + i];
> -            if (fd < 0) {
> -                continue;
> -            }
> +static bool qio_channel_handle_fds(int *fds, size_t nfds,
> +                                   bool preserve_blocking, Error **errp)
> +{
> +    int *end = fds + nfds, *fd;
> +
> +#ifdef MSG_CMSG_CLOEXEC
> +    if (preserve_blocking) {
> +        /* Nothing to do */
> +        return true;
> +    }
> +#endif
>  
> -            if (!preserve_blocking) {
> -                /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> -                qemu_socket_set_block(fd);
> +    for (fd = fds; fd != end; fd++) {
> +        if (*fd < 0) {
> +            continue;
> +        }
> +
> +        if (!preserve_blocking) {
> +            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> +            if (!qemu_set_blocking(*fd, true, errp)) {
> +                return false;
>              }
> +        }
>  
>  #ifndef MSG_CMSG_CLOEXEC
> -            qemu_set_cloexec(fd);
> +        qemu_set_cloexec(*fd);
>  #endif
> +    }
> +
> +    return true;
> +}
> +
> +static void qio_channel_cleanup_fds(int *fds, size_t nfds)

Suggest we change this to

 ...  qio_channel_cleanup_fds(int **fds, size_t *nfds)

> +{
> +    int *end = fds + nfds, *fd;
> +
> +    for (fd = fds; fd != end; fd++) {

I can't help feeling this would be clearer as

  for (size_t i = 0; i < nfds; i++) {

> +        if (*fd < 0) {
> +            continue;
>          }
> -        *nfds += gotfds;
> +        close(*fd);
>      }
> +
> +    g_free(fds);

Then here we can use:

   g_clear_poointer(fds, g_free);
   *nfds = 0;

>  }
>  
>  
> @@ -559,9 +588,21 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
>      }
>  
>      if (fds && nfds) {
> -        qio_channel_socket_copy_fds(
> -            &msg, fds, nfds,
> -            flags & QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING);
> +        int *local_fds;
> +        size_t local_nfds;
> +        bool preserve_blocking =
> +            flags & QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING;
> +
> +        qio_channel_socket_copy_fds(&msg, &local_fds, &local_nfds);
> +
> +        if (!qio_channel_handle_fds(local_fds, local_nfds,
> +                                    preserve_blocking, errp)) {
> +            qio_channel_cleanup_fds(local_fds, local_nfds);
> +            return -1;
> +        }
> +
> +        *fds = local_fds;
> +        *nfds = local_nfds;

We could eliminate the 'local_fds' / 'local_nfds' here and directly use
'fds' and 'nfds' when we make qio_channel_cleanup_fds responsible for
clearing the pointers it receives.

>      }
>  
>      return ret;
> -- 
> 2.48.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


