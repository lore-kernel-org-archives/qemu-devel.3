Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049DACA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 09:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwHVF-0007ec-68; Wed, 10 Sep 2025 05:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwHVC-0007eA-KH
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwHV6-0001so-79
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757497946;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8fLJbdO00lLI549XPHcd6xRlf+AvlREeZe/eBwMqraQ=;
 b=d8/HkO1TNQMPwsaLzDB9lIdzTpJqozRv/Gelj/AAtIFf8X9SvRbxTSvoA932wK4vllvJuh
 nuFrSZgmydsEzrU6VCQmZvjsqK3bnKkLYnyBHMSXfy21GqJ8sEZG7DZ5QW6oWYjZ0hK4ZC
 8/ShmYN1xCLP2DTRVfKxTAVxueX8cP4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-iq74S4fzNz-iV46KJu9QRA-1; Wed,
 10 Sep 2025 05:52:23 -0400
X-MC-Unique: iq74S4fzNz-iV46KJu9QRA-1
X-Mimecast-MFC-AGG-ID: iq74S4fzNz-iV46KJu9QRA_1757497942
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5520195608F; Wed, 10 Sep 2025 09:52:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA65D300018D; Wed, 10 Sep 2025 09:52:20 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:52:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 08/10] oslib-posix: add qemu_fds_set_blocking() helper
Message-ID: <aMFKUcHVxB9q3of6@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-9-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903094411.1029449-9-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 03, 2025 at 12:44:08PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> And use it in io/channel-socket.c. This simplifies the following
> commit, which will move this functionality from io/channel-socket.c
> to the callers.

Looking at how many callers will still want the current
functionality, I'm inclined to add a flag for QIOChannel

  QIO_CHANNEL_READ_FLAG_PRESERVE_BLOCKING

which migration can pass to qio_channel_readv_full and
thus avoid adding this method and duplicated calls to
it in (almost) every caller.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/qemu/osdep.h |  7 +++++++
>  io/channel-socket.c  | 24 +++++++++++++-----------
>  util/oslib-posix.c   | 12 ++++++++++++
>  3 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 1b38cb7e45..dde98d588c 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -689,6 +689,13 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
>  void qemu_set_cloexec(int fd);
>  bool qemu_set_blocking(int fd, bool block, Error **errp);
>  
> +/*
> + * qemu_fds_set_blockinging:
> + * Call qemu_socket_set_block() on several fds.
> + * When @nfds = 0, does nothing, @fds is not touched.
> + */
> +bool qemu_fds_set_blockinging(int *fds, int nfds, bool block, Error **errp);
> +
>  /* Return a dynamically allocated directory path that is appropriate for storing
>   * local state.
>   *
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 4f7e86f72f..96098b5bcc 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -472,8 +472,11 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
>      *fds = NULL;
>  
>      for (cmsg = CMSG_FIRSTHDR(msg); cmsg; cmsg = CMSG_NXTHDR(msg, cmsg)) {
> -        int fd_size, i;
> +        int fd_size;
>          int gotfds;
> +#ifndef MSG_CMSG_CLOEXEC
> +        int i;
> +#endif
>  
>          if (cmsg->cmsg_len < CMSG_LEN(sizeof(int)) ||
>              cmsg->cmsg_level != SOL_SOCKET ||
> @@ -491,20 +494,19 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
>          *fds = g_renew(int, *fds, *nfds + gotfds);
>          memcpy(*fds + *nfds, CMSG_DATA(cmsg), fd_size);
>  
> +        /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> +        /* TODO: don't crash on error, just handle it! */
> +        qemu_fds_set_blockinging(*fds + *nfds, gotfds, true, &error_abort);
> +
> +#ifndef MSG_CMSG_CLOEXEC
>          for (i = 0; i < gotfds; i++) {
>              int fd = (*fds)[*nfds + i];
> -            if (fd < 0) {
> -                continue;
> +            if (fd >= 0) {
> +                qemu_set_cloexec(fd);
>              }
> -
> -            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> -            /* TODO: don't crash on error, just handle it! */
> -            qemu_set_blocking(fd, true, &error_abort);
> -
> -#ifndef MSG_CMSG_CLOEXEC
> -            qemu_set_cloexec(fd);
> -#endif
>          }
> +#endif
> +
>          *nfds += gotfds;
>      }
>  }
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 8891d82db0..8589ff21ec 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -262,6 +262,18 @@ bool qemu_set_blocking(int fd, bool block, Error **errp)
>      return true;
>  }
>  
> +bool qemu_fds_set_blockinging(int *fds, int nfds, bool block, Error **errp)
> +{
> +    int i;
> +    for (i = 0; i < nfds; i++) {
> +        if (fds[i] >= 0 && !qemu_set_blocking(fds[i], block, errp)) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  int socket_set_fast_reuse(int fd)
>  {
>      int val = 1, ret;
> -- 
> 2.48.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


