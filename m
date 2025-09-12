Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C94CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 17:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux7KC-0002Vh-UE; Fri, 12 Sep 2025 13:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux7K7-0002UP-1Y
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 13:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux7K4-0003Jl-19
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 13:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757697148;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=svQd9fAU/5eWhlHyLeHgk2OzkCkf2lBtFyUZJ6b0/KU=;
 b=gVIppz6AhXylma/AGD3TnuKOfL2C63bD1QR/Bn9slTB4AE7IaeQpIKvNaYLu9/iw9O3nhR
 Yuus0h0Fqv4y/4cNbeOHZDojbb9v0Uu1m9ZQDrpoO9VzfNUlkMhGTUw8SiQfJ++HHC+USz
 JTFztC6cc6o9cULjFBj476f2Pxscs80=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-eUm6ChXROU6geDR27EmK_A-1; Fri,
 12 Sep 2025 13:12:25 -0400
X-MC-Unique: eUm6ChXROU6geDR27EmK_A-1
X-Mimecast-MFC-AGG-ID: eUm6ChXROU6geDR27EmK_A_1757697143
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 487BD18005B7; Fri, 12 Sep 2025 17:12:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E9431800446; Fri, 12 Sep 2025 17:11:56 +0000 (UTC)
Date: Fri, 12 Sep 2025 18:11:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 8/8] use qemu_set_blocking instead of
 g_unix_set_fd_nonblocking
Message-ID: <aMRUWCLd_U6FRLM9@redhat.com>
References: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
 <20250911092007.1370002-9-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911092007.1370002-9-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Sep 11, 2025 at 12:20:06PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Instead of open-coded g_unix_set_fd_nonblocking() calls, use
> QEMU wrapper qemu_set_blocking().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  chardev/char-fd.c                  |  4 ++--
>  chardev/char-pty.c                 |  3 +--
>  chardev/char-serial.c              |  3 +--
>  chardev/char-stdio.c               |  3 +--
>  hw/input/virtio-input-host.c       |  3 +--
>  hw/misc/ivshmem-flat.c             |  3 ++-
>  hw/misc/ivshmem-pci.c              |  7 ++++++-
>  hw/virtio/vhost-vsock.c            |  8 ++------
>  io/channel-command.c               |  9 ++++++---
>  io/channel-file.c                  |  3 +--
>  net/tap-bsd.c                      | 12 ++++++++++--
>  net/tap-linux.c                    |  7 ++++++-
>  net/tap-solaris.c                  |  7 ++++++-
>  net/tap.c                          | 21 ++++++---------------
>  qga/commands-posix.c               |  3 +--
>  tests/qtest/fuzz/virtio_net_fuzz.c |  2 +-
>  tests/qtest/vhost-user-test.c      |  3 +--
>  tests/unit/test-iov.c              |  5 +++--
>  ui/input-linux.c                   |  3 +--
>  util/event_notifier-posix.c        |  4 ++--
>  util/main-loop.c                   |  5 ++++-
>  21 files changed, 64 insertions(+), 54 deletions(-)
> 
> diff --git a/chardev/char-fd.c b/chardev/char-fd.c
> index 6f03adf872..739dc68c36 100644
> --- a/chardev/char-fd.c
> +++ b/chardev/char-fd.c
> @@ -212,8 +212,8 @@ void qemu_chr_open_fd(Chardev *chr,
>      FDChardev *s = FD_CHARDEV(chr);
>      g_autofree char *name = NULL;
>  
> -    if (fd_out >= 0 && !g_unix_set_fd_nonblocking(fd_out, true, NULL)) {
> -        assert(!"Failed to set FD nonblocking");
> +    if (fd_out >= 0) {
> +        qemu_set_blocking(fd_out, false, &error_abort);

Every caller of this method has an 'errp' available that we
can plumb into qemu_chr_open_fd().

>      }
>  
>      if (fd_out == fd_in && fd_in >= 0) {


> diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
> index fe4be6be17..89495f6a11 100644
> --- a/hw/misc/ivshmem-flat.c
> +++ b/hw/misc/ivshmem-flat.c
> @@ -154,7 +154,8 @@ static void ivshmem_flat_add_vector(IvshmemFTState *s, IvshmemPeer *peer,
>       * peer.
>       */
>      peer->vector[peer->vector_counter].id = peer->vector_counter;
> -    g_unix_set_fd_nonblocking(vector_fd, true, NULL);
> +    /* WARNING: qemu_socket_set_nonblock() return code ignored */
> +    qemu_set_blocking(vector_fd, false, NULL);

Perhaps &warn_report so we at least diagnose this awkward situation ?

>      event_notifier_init_fd(&peer->vector[peer->vector_counter].event_notifier,
>                             vector_fd);
>  





With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


