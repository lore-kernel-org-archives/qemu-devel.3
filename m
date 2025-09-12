Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05B5CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 16:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux77V-00052z-6H; Fri, 12 Sep 2025 12:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux77S-00050z-4X
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux77Q-0001kV-1L
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757696366;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pf5/T0ARiNUPdJ59xTBo8/mDJiwTUWmKn3hvbUsiJkc=;
 b=FDbiA5iJqcw7JZbmUwyxF6iXQoxtm81KH8w1YNfYEUx66CFfQArQwGoAZnJhO1DgeQNwRY
 u4Iso9M39ETReP/Es9p7qLqui4FmaMIBOqLEUgRDV0RK7NJ3jOy5S+RhrxW5nJy8bzZYMJ
 MwLx/O+CptWR00u8FJCpi9ST4HFqGvA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-JQmXmKNPM2ms3dUyMxAPAw-1; Fri,
 12 Sep 2025 12:59:24 -0400
X-MC-Unique: JQmXmKNPM2ms3dUyMxAPAw-1
X-Mimecast-MFC-AGG-ID: JQmXmKNPM2ms3dUyMxAPAw_1757696363
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F95619560A0; Fri, 12 Sep 2025 16:59:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9985218003FC; Fri, 12 Sep 2025 16:59:18 +0000 (UTC)
Date: Fri, 12 Sep 2025 17:59:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Coiby Xu <Coiby.Xu@gmail.com>
Subject: Re: [PATCH v2 4/8] util: drop qemu_socket_set_nonblock()
Message-ID: <aMRRYhbRAnTu4Sew@redhat.com>
References: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
 <20250911092007.1370002-5-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911092007.1370002-5-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Thu, Sep 11, 2025 at 12:20:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Use common qemu_set_blocking() instead.
> 
> Note that pre-patch the behavior of Win32 and Linux realizations
> are inconsistent: we ignore failure for Win32, and assert success
> for Linux.
> 
> How do we convert the callers?

> 3. io/channel-socket.c: here we convert both old calls to
> qemu_socket_set_nonblock() and qemu_socket_set_block() to
> one new call. Pre-patch we assert success for Linux in
> qemu_socket_set_nonblock(), and ignore all other errors here.
> Still, all callers pass errp=NULL to qio_channel_set_blocking(),
> so after patch we ignore all errors. Switching from assertion
> to ignoring may be not very good, but still acceptable, keeping
> in mind that all callers of qio_channel_set_blocking() do
> explicitly ignore the error.

This is a bit questionable. IMHO the reason why nearly all
callers pass errp=NULL is laziness based on the assumption
that the code actually asserts, and no one thinking to check
the win impl which didn't asset.

IOW, I think we need a prior patch that sets the 'errp'
in all these callers, either to &error_abort, or to
propage the error if practical.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  contrib/ivshmem-server/ivshmem-server.c |  6 +++++-
>  hw/hyperv/syndbg.c                      |  4 +++-
>  hw/virtio/vhost-user.c                  |  5 ++++-
>  include/qemu/sockets.h                  |  1 -
>  io/channel-socket.c                     |  7 +++----
>  net/dgram.c                             | 16 +++++++++++++---
>  net/l2tpv3.c                            |  5 +++--
>  net/socket.c                            | 20 ++++++++++++++++----
>  qga/channel-posix.c                     |  7 ++++++-
>  tests/unit/socket-helpers.c             |  5 ++++-
>  tests/unit/test-crypto-tlssession.c     |  8 ++++----
>  util/oslib-posix.c                      |  7 -------
>  util/oslib-win32.c                      |  5 -----
>  util/vhost-user-server.c                |  4 ++--
>  14 files changed, 63 insertions(+), 37 deletions(-)
> 
> diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-server/ivshmem-server.c
> index 2f3c7320a6..a65943d0b8 100644
> --- a/contrib/ivshmem-server/ivshmem-server.c
> +++ b/contrib/ivshmem-server/ivshmem-server.c
> @@ -146,9 +146,13 @@ ivshmem_server_handle_new_conn(IvshmemServer *server)
>          return -1;
>      }
>  
> -    qemu_socket_set_nonblock(newfd);
>      IVSHMEM_SERVER_DEBUG(server, "accept()=%d\n", newfd);
>  
> +    if (!qemu_set_blocking(newfd, false, NULL)) {

&error_warn here so we diagnose the reason we're returning -1
to the caller ?

> +        close(newfd);
> +        return -1;
> +    }
> +
>      /* allocate new structure for this peer */
>      peer = g_malloc0(sizeof(*peer));
>      peer->sock_fd = newfd;

> diff --git a/tests/unit/socket-helpers.c b/tests/unit/socket-helpers.c
> index 37db24f72a..1b7e283f24 100644
> --- a/tests/unit/socket-helpers.c
> +++ b/tests/unit/socket-helpers.c
> @@ -88,7 +88,10 @@ static int socket_can_bind_connect(const char *hostname, int family)
>          goto cleanup;
>      }
>  
> -    qemu_socket_set_nonblock(cfd);
> +    if (!qemu_set_blocking(cfd, false, NULL)) {

&error_abort here.

> +        goto cleanup;
> +    }
> +
>      if (connect(cfd, (struct sockaddr *)&ss, sslen) < 0) {
>          if (errno == EINPROGRESS) {
>              check_soerr = true;
 
With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


