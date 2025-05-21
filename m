Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD45C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 10:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHgTr-0006Ms-To; Wed, 21 May 2025 06:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHgTo-0006Mb-DE
 for qemu-devel@nongnu.org; Wed, 21 May 2025 06:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHgTk-0004rV-Bw
 for qemu-devel@nongnu.org; Wed, 21 May 2025 06:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747822513;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fr6SEJ1Ly1zMHnme1QOSkwrsV3V43Xb63nbrZJuh4Y0=;
 b=NBXJfE2FZj9R9mzCGXI0shYQ6Xot8yJIwIfV9AeoNg34jhEdeJvZL2AIAVOVaASAh9qSXF
 s17CVdVSvtHqeCZHyCvwMu5Hamvmf2ahihA9sF4KkEBkCKPjb2izv8PcDUxNtFcq7M5Opw
 oOswbG1GC9WPcOQw/LrPn1l2Dqb7VNw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-athXJvH9NZ6WEpEB9YyAiw-1; Wed,
 21 May 2025 06:15:10 -0400
X-MC-Unique: athXJvH9NZ6WEpEB9YyAiw-1
X-Mimecast-MFC-AGG-ID: athXJvH9NZ6WEpEB9YyAiw_1747822509
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C4BE1954235; Wed, 21 May 2025 10:15:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BAB519560AE; Wed, 21 May 2025 10:15:04 +0000 (UTC)
Date: Wed, 21 May 2025 11:15:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [RFC PATCH] util: split unix socket functions out of qemu-sockets
Message-ID: <aC2npW8LB347lwr3@redhat.com>
References: <20250520165706.3976971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250520165706.3976971-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 20, 2025 at 05:57:06PM +0100, Alex Bennée wrote:
> Since fccb744f41 (gdbstub: Try unlinking the unix socket before
> binding) we use the unix_listen() function from linux-user which
> causes complications when trying to build statically.
> 
> Fix this by splitting the unix functions into its own file and doing
> the appropriate tweaks to the headers.

I think I'd be more inclined to just revert the original problem
patch. The original stated problem only seems to need a single
'unlink' call being added in the gdb stub, avoiding the whole
problem with linking.  I'm not really a fan of arbitrarily
splitting the up the source files as a workaround.



> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  include/qemu/sockets.h |   1 +
>  util/socket-helpers.h  |  17 ++++
>  util/qemu-sockets.c    | 199 +--------------------------------------
>  util/unix-sockets.c    | 207 +++++++++++++++++++++++++++++++++++++++++
>  util/meson.build       |   5 +-
>  5 files changed, 231 insertions(+), 198 deletions(-)
>  create mode 100644 util/socket-helpers.h
>  create mode 100644 util/unix-sockets.c
> 
> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
> index c562690d89..578aef13cf 100644
> --- a/include/qemu/sockets.h
> +++ b/include/qemu/sockets.h
> @@ -65,6 +65,7 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp);
>  
>  NetworkAddressFamily inet_netfamily(int family);
>  
> +/* part of unix-sockets.c */
>  int unix_listen(const char *path, Error **errp);
>  int unix_connect(const char *path, Error **errp);
>  
> diff --git a/util/socket-helpers.h b/util/socket-helpers.h
> new file mode 100644
> index 0000000000..f72925148a
> --- /dev/null
> +++ b/util/socket-helpers.h
> @@ -0,0 +1,17 @@
> +/*
> + * Common helper functions for unix and qemu sockets
> + *
> + * (c) 2008 Gerd Hoffmann <kraxel@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef _SOCKET_HELPERS_H_
> +#define _SOCKET_HELPERS_H_
> +
> +#include "qapi/qapi-visit-sockets.h"
> +
> +int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp);
> +int unix_listen_saddr(UnixSocketAddress *saddr, int num, Error **errp);
> +
> +#endif /* _SOCKET_HELPERS_H_ */
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 77477c1cd5..a5c3515082 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1,5 +1,5 @@
>  /*
> - *  inet and unix socket functions for qemu
> + *  inet socket functions for qemu
>   *
>   *  (c) 2008 Gerd Hoffmann <kraxel@redhat.com>
>   *
> @@ -30,6 +30,7 @@
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/qobject-output-visitor.h"
>  #include "qemu/cutils.h"
> +#include "socket-helpers.h"
>  #include "trace.h"
>  
>  #ifndef AI_ADDRCONFIG
> @@ -853,202 +854,6 @@ static int vsock_parse(VsockSocketAddress *addr, const char *str,
>  }
>  #endif /* CONFIG_AF_VSOCK */
>  
> -static bool saddr_is_abstract(UnixSocketAddress *saddr)
> -{
> -#ifdef CONFIG_LINUX
> -    return saddr->abstract;
> -#else
> -    return false;
> -#endif
> -}
> -
> -static bool saddr_is_tight(UnixSocketAddress *saddr)
> -{
> -#ifdef CONFIG_LINUX
> -    return !saddr->has_tight || saddr->tight;
> -#else
> -    return false;
> -#endif
> -}
> -
> -static int unix_listen_saddr(UnixSocketAddress *saddr,
> -                             int num,
> -                             Error **errp)
> -{
> -    bool abstract = saddr_is_abstract(saddr);
> -    struct sockaddr_un un;
> -    int sock, fd;
> -    char *pathbuf = NULL;
> -    const char *path;
> -    size_t pathlen;
> -    size_t addrlen;
> -
> -    sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
> -    if (sock < 0) {
> -        error_setg_errno(errp, errno, "Failed to create Unix socket");
> -        return -1;
> -    }
> -
> -    if (saddr->path[0] || abstract) {
> -        path = saddr->path;
> -    } else {
> -        path = pathbuf = g_strdup_printf("%s/qemu-socket-XXXXXX",
> -                                         g_get_tmp_dir());
> -    }
> -
> -    pathlen = strlen(path);
> -    if (pathlen > sizeof(un.sun_path) ||
> -        (abstract && pathlen > (sizeof(un.sun_path) - 1))) {
> -        error_setg(errp, "UNIX socket path '%s' is too long", path);
> -        error_append_hint(errp, "Path must be less than %zu bytes\n",
> -                          abstract ? sizeof(un.sun_path) - 1 :
> -                          sizeof(un.sun_path));
> -        goto err;
> -    }
> -
> -    if (pathbuf != NULL) {
> -        /*
> -         * This dummy fd usage silences the mktemp() insecure warning.
> -         * Using mkstemp() doesn't make things more secure here
> -         * though.  bind() complains about existing files, so we have
> -         * to unlink first and thus re-open the race window.  The
> -         * worst case possible is bind() failing, i.e. a DoS attack.
> -         */
> -        fd = mkstemp(pathbuf);
> -        if (fd < 0) {
> -            error_setg_errno(errp, errno,
> -                             "Failed to make a temporary socket %s", pathbuf);
> -            goto err;
> -        }
> -        close(fd);
> -    }
> -
> -    if (!abstract && unlink(path) < 0 && errno != ENOENT) {
> -        error_setg_errno(errp, errno,
> -                         "Failed to unlink socket %s", path);
> -        goto err;
> -    }
> -
> -    memset(&un, 0, sizeof(un));
> -    un.sun_family = AF_UNIX;
> -    addrlen = sizeof(un);
> -
> -    if (abstract) {
> -        un.sun_path[0] = '\0';
> -        memcpy(&un.sun_path[1], path, pathlen);
> -        if (saddr_is_tight(saddr)) {
> -            addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
> -        }
> -    } else {
> -        memcpy(un.sun_path, path, pathlen);
> -    }
> -
> -    if (bind(sock, (struct sockaddr *) &un, addrlen) < 0) {
> -        error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
> -        goto err;
> -    }
> -    if (listen(sock, num) < 0) {
> -        error_setg_errno(errp, errno, "Failed to listen on socket");
> -        goto err;
> -    }
> -
> -    g_free(pathbuf);
> -    return sock;
> -
> -err:
> -    g_free(pathbuf);
> -    close(sock);
> -    return -1;
> -}
> -
> -static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
> -{
> -    bool abstract = saddr_is_abstract(saddr);
> -    struct sockaddr_un un;
> -    int sock, rc;
> -    size_t pathlen;
> -    size_t addrlen;
> -
> -    if (saddr->path == NULL) {
> -        error_setg(errp, "unix connect: no path specified");
> -        return -1;
> -    }
> -
> -    sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
> -    if (sock < 0) {
> -        error_setg_errno(errp, errno, "Failed to create socket");
> -        return -1;
> -    }
> -
> -    pathlen = strlen(saddr->path);
> -    if (pathlen > sizeof(un.sun_path) ||
> -        (abstract && pathlen > (sizeof(un.sun_path) - 1))) {
> -        error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
> -        error_append_hint(errp, "Path must be less than %zu bytes\n",
> -                          abstract ? sizeof(un.sun_path) - 1 :
> -                          sizeof(un.sun_path));
> -        goto err;
> -    }
> -
> -    memset(&un, 0, sizeof(un));
> -    un.sun_family = AF_UNIX;
> -    addrlen = sizeof(un);
> -
> -    if (abstract) {
> -        un.sun_path[0] = '\0';
> -        memcpy(&un.sun_path[1], saddr->path, pathlen);
> -        if (saddr_is_tight(saddr)) {
> -            addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
> -        }
> -    } else {
> -        memcpy(un.sun_path, saddr->path, pathlen);
> -    }
> -    /* connect to peer */
> -    do {
> -        rc = 0;
> -        if (connect(sock, (struct sockaddr *) &un, addrlen) < 0) {
> -            rc = -errno;
> -        }
> -    } while (rc == -EINTR);
> -
> -    if (rc < 0) {
> -        error_setg_errno(errp, -rc, "Failed to connect to '%s'",
> -                         saddr->path);
> -        goto err;
> -    }
> -
> -    return sock;
> -
> - err:
> -    close(sock);
> -    return -1;
> -}
> -
> -/* compatibility wrapper */
> -int unix_listen(const char *str, Error **errp)
> -{
> -    UnixSocketAddress *saddr;
> -    int sock;
> -
> -    saddr = g_new0(UnixSocketAddress, 1);
> -    saddr->path = g_strdup(str);
> -    sock = unix_listen_saddr(saddr, 1, errp);
> -    qapi_free_UnixSocketAddress(saddr);
> -    return sock;
> -}
> -
> -int unix_connect(const char *path, Error **errp)
> -{
> -    UnixSocketAddress *saddr;
> -    int sock;
> -
> -    saddr = g_new0(UnixSocketAddress, 1);
> -    saddr->path = g_strdup(path);
> -    sock = unix_connect_saddr(saddr, errp);
> -    qapi_free_UnixSocketAddress(saddr);
> -    return sock;
> -}
> -
>  char *socket_uri(SocketAddress *addr)
>  {
>      switch (addr->type) {
> diff --git a/util/unix-sockets.c b/util/unix-sockets.c
> new file mode 100644
> index 0000000000..e271dd3e09
> --- /dev/null
> +++ b/util/unix-sockets.c
> @@ -0,0 +1,207 @@
> +/*
> + * unix socket functions for qemu
> + *
> + * (c) 2008 Gerd Hoffmann <kraxel@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/sockets.h"
> +#include "qapi/error.h"
> +
> +#include "socket-helpers.h"
> +
> +static bool saddr_is_abstract(UnixSocketAddress *saddr)
> +{
> +#ifdef CONFIG_LINUX
> +    return saddr->abstract;
> +#else
> +    return false;
> +#endif
> +}
> +
> +static bool saddr_is_tight(UnixSocketAddress *saddr)
> +{
> +#ifdef CONFIG_LINUX
> +    return !saddr->has_tight || saddr->tight;
> +#else
> +    return false;
> +#endif
> +}
> +
> +int unix_listen_saddr(UnixSocketAddress *saddr, int num, Error **errp)
> +{
> +    bool abstract = saddr_is_abstract(saddr);
> +    struct sockaddr_un un;
> +    int sock, fd;
> +    char *pathbuf = NULL;
> +    const char *path;
> +    size_t pathlen;
> +    size_t addrlen;
> +
> +    sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
> +    if (sock < 0) {
> +        error_setg_errno(errp, errno, "Failed to create Unix socket");
> +        return -1;
> +    }
> +
> +    if (saddr->path[0] || abstract) {
> +        path = saddr->path;
> +    } else {
> +        path = pathbuf = g_strdup_printf("%s/qemu-socket-XXXXXX",
> +                                         g_get_tmp_dir());
> +    }
> +
> +    pathlen = strlen(path);
> +    if (pathlen > sizeof(un.sun_path) ||
> +        (abstract && pathlen > (sizeof(un.sun_path) - 1))) {
> +        error_setg(errp, "UNIX socket path '%s' is too long", path);
> +        error_append_hint(errp, "Path must be less than %zu bytes\n",
> +                          abstract ? sizeof(un.sun_path) - 1 :
> +                          sizeof(un.sun_path));
> +        goto err;
> +    }
> +
> +    if (pathbuf != NULL) {
> +        /*
> +         * This dummy fd usage silences the mktemp() insecure warning.
> +         * Using mkstemp() doesn't make things more secure here
> +         * though.  bind() complains about existing files, so we have
> +         * to unlink first and thus re-open the race window.  The
> +         * worst case possible is bind() failing, i.e. a DoS attack.
> +         */
> +        fd = mkstemp(pathbuf);
> +        if (fd < 0) {
> +            error_setg_errno(errp, errno,
> +                             "Failed to make a temporary socket %s", pathbuf);
> +            goto err;
> +        }
> +        close(fd);
> +    }
> +
> +    if (!abstract && unlink(path) < 0 && errno != ENOENT) {
> +        error_setg_errno(errp, errno,
> +                         "Failed to unlink socket %s", path);
> +        goto err;
> +    }
> +
> +    memset(&un, 0, sizeof(un));
> +    un.sun_family = AF_UNIX;
> +    addrlen = sizeof(un);
> +
> +    if (abstract) {
> +        un.sun_path[0] = '\0';
> +        memcpy(&un.sun_path[1], path, pathlen);
> +        if (saddr_is_tight(saddr)) {
> +            addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
> +        }
> +    } else {
> +        memcpy(un.sun_path, path, pathlen);
> +    }
> +
> +    if (bind(sock, (struct sockaddr *) &un, addrlen) < 0) {
> +        error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
> +        goto err;
> +    }
> +    if (listen(sock, num) < 0) {
> +        error_setg_errno(errp, errno, "Failed to listen on socket");
> +        goto err;
> +    }
> +
> +    g_free(pathbuf);
> +    return sock;
> +
> +err:
> +    g_free(pathbuf);
> +    close(sock);
> +    return -1;
> +}
> +
> +int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
> +{
> +    bool abstract = saddr_is_abstract(saddr);
> +    struct sockaddr_un un;
> +    int sock, rc;
> +    size_t pathlen;
> +    size_t addrlen;
> +
> +    if (saddr->path == NULL) {
> +        error_setg(errp, "unix connect: no path specified");
> +        return -1;
> +    }
> +
> +    sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
> +    if (sock < 0) {
> +        error_setg_errno(errp, errno, "Failed to create socket");
> +        return -1;
> +    }
> +
> +    pathlen = strlen(saddr->path);
> +    if (pathlen > sizeof(un.sun_path) ||
> +        (abstract && pathlen > (sizeof(un.sun_path) - 1))) {
> +        error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
> +        error_append_hint(errp, "Path must be less than %zu bytes\n",
> +                          abstract ? sizeof(un.sun_path) - 1 :
> +                          sizeof(un.sun_path));
> +        goto err;
> +    }
> +
> +    memset(&un, 0, sizeof(un));
> +    un.sun_family = AF_UNIX;
> +    addrlen = sizeof(un);
> +
> +    if (abstract) {
> +        un.sun_path[0] = '\0';
> +        memcpy(&un.sun_path[1], saddr->path, pathlen);
> +        if (saddr_is_tight(saddr)) {
> +            addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
> +        }
> +    } else {
> +        memcpy(un.sun_path, saddr->path, pathlen);
> +    }
> +    /* connect to peer */
> +    do {
> +        rc = 0;
> +        if (connect(sock, (struct sockaddr *) &un, addrlen) < 0) {
> +            rc = -errno;
> +        }
> +    } while (rc == -EINTR);
> +
> +    if (rc < 0) {
> +        error_setg_errno(errp, -rc, "Failed to connect to '%s'",
> +                         saddr->path);
> +        goto err;
> +    }
> +
> +    return sock;
> +
> + err:
> +    close(sock);
> +    return -1;
> +}
> +
> +/* compatibility wrapper */
> +int unix_listen(const char *str, Error **errp)
> +{
> +    UnixSocketAddress *saddr;
> +    int sock;
> +
> +    saddr = g_new0(UnixSocketAddress, 1);
> +    saddr->path = g_strdup(str);
> +    sock = unix_listen_saddr(saddr, 1, errp);
> +    qapi_free_UnixSocketAddress(saddr);
> +    return sock;
> +}
> +
> +int unix_connect(const char *path, Error **errp)
> +{
> +    UnixSocketAddress *saddr;
> +    int sock;
> +
> +    saddr = g_new0(UnixSocketAddress, 1);
> +    saddr->path = g_strdup(path);
> +    sock = unix_connect_saddr(saddr, errp);
> +    qapi_free_UnixSocketAddress(saddr);
> +    return sock;
> +}
> diff --git a/util/meson.build b/util/meson.build
> index 1adff96ebd..dbcfbc6542 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -87,7 +87,10 @@ if have_block or have_ga
>    util_ss.add(files(f'coroutine-@coroutine_backend@.c'))
>    util_ss.add(files('thread-pool.c', 'qemu-timer.c'))
>  endif
> -if have_block or have_ga or have_user
> +if have_user
> +  util_ss.add(files('unix-sockets.c'))
> +endif
> +if have_block or have_ga
>    util_ss.add(files('qemu-sockets.c'))
>  endif
>  if have_block
> -- 
> 2.39.5
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


