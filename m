Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A98CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYIw-0004uS-27; Fri, 19 Sep 2025 06:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzYIu-0004tz-94
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzYIh-0006Oq-F3
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758277505;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hpBR85bVv9czaBLBSvKaKCv8jqJeFL32RVMrrAcHFVw=;
 b=POAiC6IMhiUqc8YkT0eFsBNp4y/zvA803T5+Lpg3uAGGnHfQeVONnSybaYmbfvdqFqtbFZ
 Z1WvsQpLQvXEYjvlyPXg6rikjg4JQicxGKwXC3Y2R265IejXuFhQzX6WUX3zq169X/I0FM
 53I9Juve6zhef49U3QLZ+/NxaGHKr1c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-VrPHByeAPwiQq48yGV0XYw-1; Fri,
 19 Sep 2025 06:25:01 -0400
X-MC-Unique: VrPHByeAPwiQq48yGV0XYw-1
X-Mimecast-MFC-AGG-ID: VrPHByeAPwiQq48yGV0XYw_1758277500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE8171800451; Fri, 19 Sep 2025 10:24:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 417741800452; Fri, 19 Sep 2025 10:24:50 +0000 (UTC)
Date: Fri, 19 Sep 2025 11:24:47 +0100
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
Subject: Re: [PATCH v5 10/13] use qemu_set_blocking instead of
 g_unix_set_fd_nonblocking
Message-ID: <aM0vbzOBdmV3Fq3M@redhat.com>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
 <20250916131403.368343-11-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916131403.368343-11-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Sep 16, 2025 at 04:13:59PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Instead of open-coded g_unix_set_fd_nonblocking() calls, use
> QEMU wrapper qemu_set_blocking().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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
>  util/event_notifier-posix.c        |  7 +++++--
>  util/main-loop.c                   |  5 ++++-
>  21 files changed, 67 insertions(+), 54 deletions(-)
> 

> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> index b4c84441ba..2e444e59b5 100644
> --- a/net/tap-bsd.c
> +++ b/net/tap-bsd.c
> @@ -98,7 +98,12 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
>              return -1;
>          }
>      }
> -    g_unix_set_fd_nonblocking(fd, true, NULL);
> +
> +    if (!qemu_set_blocking(fd, false, errp) {

Missing trailing ')' here

> +        close(fd);
> +        return -1;
> +    }
> +
>      return fd;
>  }
>  
> @@ -189,7 +194,10 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
>          goto error;
>      }
>  
> -    g_unix_set_fd_nonblocking(fd, true, NULL);
> +    if (!qemu_set_blocking(fd, false, errp) {

and here

> +        goto error;
> +    }
> +
>      return fd;
>  
>  error:

> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index 56472ca709..e39d6e7787 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -471,8 +471,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
>           * The receive function forces it to be blocking,
>           * so revert it back to non-blocking.
>           */
> -        g_unix_set_fd_nonblocking(fd, true, &err);
> -        g_assert_no_error(err);
> +        qemu_set_blocking(fd, false, &error_abort);
>          break;

This removed the only use 'err' causing a warning in tsan builds.

>  
>      case VHOST_USER_SET_LOG_BASE:

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


