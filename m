Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD96CAC587
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvuDw-0005J8-OA; Tue, 09 Sep 2025 05:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvuDt-0005DF-Df
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvuDj-0005Wo-RC
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757408449;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=O77ovE+0Pj/iB8Z2FvRlmYVn/hXmwxr7bQ+4Px21+Uc=;
 b=iWEXvLKuIjW80BK9GuVvbQHp13bClL1Y4IDBuuAL2uDjaYhr9Jc8acKwqxc+i9t5sOIaZY
 2Csxc1nm0G5n8m2muWvh5GiM2zWRlTI01iDwH3IIclQXSHnivE7pFnFamkUHYSVRkj9Y4s
 e9oNIQZmH9v6GQLFQ2eECaIdwOLdJZ8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-L7g1L3ELMmKts7DOUn-sOg-1; Tue,
 09 Sep 2025 05:00:46 -0400
X-MC-Unique: L7g1L3ELMmKts7DOUn-sOg-1
X-Mimecast-MFC-AGG-ID: L7g1L3ELMmKts7DOUn-sOg_1757408444
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D112B180028C; Tue,  9 Sep 2025 09:00:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9872300018D; Tue,  9 Sep 2025 09:00:37 +0000 (UTC)
Date: Tue, 9 Sep 2025 10:00:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 07/10] use qemu_set_blocking instead of
 g_unix_set_fd_nonblocking
Message-ID: <aL_ssg0m_4FOfpHo@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-8-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903094411.1029449-8-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, Sep 03, 2025 at 12:44:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Instead of open-coded g_unix_set_fd_nonblocking() calls, use
> QEMU wrapper qemu_socket_set_nonblock().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  chardev/char-fd.c                  |  4 ++--
>  chardev/char-pty.c                 |  3 +--
>  chardev/char-serial.c              |  3 +--
>  chardev/char-stdio.c               |  3 +--
>  hw/input/virtio-input-host.c       |  3 +--
>  hw/misc/ivshmem-flat.c             |  4 +++-
>  hw/misc/ivshmem-pci.c              |  8 +++++++-
>  hw/virtio/vhost-vsock.c            |  8 ++------
>  io/channel-command.c               |  9 ++++++---
>  io/channel-file.c                  |  3 +--
>  net/tap-bsd.c                      | 12 ++++++++++--
>  net/tap-linux.c                    |  8 +++++++-
>  net/tap-solaris.c                  |  7 ++++++-
>  net/tap.c                          | 21 ++++++---------------
>  qga/commands-posix.c               |  3 +--
>  tests/qtest/fuzz/virtio_net_fuzz.c |  2 +-
>  tests/qtest/vhost-user-test.c      |  3 +--
>  tests/unit/test-iov.c              |  5 +++--
>  ui/input-linux.c                   |  3 +--
>  util/event_notifier-posix.c        |  5 +++--
>  util/main-loop.c                   |  6 +++++-
>  21 files changed, 69 insertions(+), 54 deletions(-)

> diff --git a/io/channel-command.c b/io/channel-command.c
> index 8966dd3a2b..8ae9a026b3 100644
> --- a/io/channel-command.c
> +++ b/io/channel-command.c
> @@ -277,9 +277,12 @@ static int qio_channel_command_set_blocking(QIOChannel *ioc,
>      cioc->blocking = enabled;
>  #else
>  
> -    if ((cioc->writefd >= 0 && !g_unix_set_fd_nonblocking(cioc->writefd, !enabled, NULL)) ||
> -        (cioc->readfd >= 0 && !g_unix_set_fd_nonblocking(cioc->readfd, !enabled, NULL))) {
> -        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
> +    if (cioc->writefd >= 0 &&
> +        !qemu_set_blocking(cioc->writefd, enabled, errp)) {
> +        return -1;
> +    }
> +    if (cioc->readfd >= 0 &&
> +        !qemu_set_blocking(cioc->readfd, enabled, errp)) {
>          return -1;
>      }
>  #endif
> diff --git a/io/channel-file.c b/io/channel-file.c
> index ca3f180cc2..5cef75a67c 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -223,8 +223,7 @@ static int qio_channel_file_set_blocking(QIOChannel *ioc,
>  #else
>      QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
>  
> -    if (!g_unix_set_fd_nonblocking(fioc->fd, !enabled, NULL)) {
> -        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
> +    if (!qemu_set_blocking(fioc->fd, enabled, errp)) {
>          return -1;
>      }
>      return 0;

This is wrong for Windows. fioc->fd is not a socket, but this is passing
it to an API whose impl assume it is receiving a socket.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


