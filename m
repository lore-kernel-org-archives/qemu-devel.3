Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E10CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 09:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwHNt-0005PC-04; Wed, 10 Sep 2025 05:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwHNp-0005Oh-Cs
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwHNi-0000W6-Sb
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757497486;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WnkBAvPYevptaZKOuDTtielinG2cvbneWcxv0V5CUrM=;
 b=bbiQsSqsWh4X6yS8zcZQgv+UOeKsjwFrwJJw0iqRy8p5qwNx/O0XR33O8tb5m67FFjz9U1
 iZ4HH+/8C60v3UJfnCONkQw9X+CJJ7NKHyJyiV4vuXZEzK7/DMIdYOuiEtJ42mNSgeCT1m
 h+DJ6Vk/21pl8HvxjYq3jVu3/ncYwG8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-8hpeyQOlOOeV8Vq77hzj3A-1; Wed,
 10 Sep 2025 05:44:45 -0400
X-MC-Unique: 8hpeyQOlOOeV8Vq77hzj3A-1
X-Mimecast-MFC-AGG-ID: 8hpeyQOlOOeV8Vq77hzj3A_1757497484
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A82F91800378; Wed, 10 Sep 2025 09:44:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B52F21956095; Wed, 10 Sep 2025 09:44:39 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:44:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Coiby Xu <Coiby.Xu@gmail.com>
Subject: Re: [PATCH 04/10] util: drop qemu_socket_set_nonblock()
Message-ID: <aMFIhJp-GfOhv3AV@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-5-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903094411.1029449-5-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 03, 2025 at 12:44:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Use common qemu_set_blocking() instead.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  contrib/ivshmem-server/ivshmem-server.c |  5 ++++-
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
>  14 files changed, 62 insertions(+), 37 deletions(-)
> 

> diff --git a/qga/channel-posix.c b/qga/channel-posix.c
> index 465d688ecb..ddf8ebdc5e 100644
> --- a/qga/channel-posix.c
> +++ b/qga/channel-posix.c
> @@ -28,6 +28,7 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
>      GAChannel *c = data;
>      int ret, client_fd;
>      bool accepted = false;
> +    Error *err = NULL;
>  
>      g_assert(channel != NULL);
>  
> @@ -36,7 +37,11 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
>          g_warning("error converting fd to gsocket: %s", strerror(errno));
>          goto out;
>      }
> -    qemu_socket_set_nonblock(client_fd);
> +    if (!qemu_set_blocking(client_fd, false, &err)) {
> +        g_warning("errer: %s", error_get_pretty(err));

s/errer/error/


This is a pre-existing problem, but none of this code should be using
g_warning. g_printerr() should have been used for printing error
messages. I'm not expecting you to fix that, just an observation.

> +        error_free(err);
> +        goto out;
> +    }
>      ret = ga_channel_client_add(c, client_fd);
>      if (ret) {
>          g_warning("error setting up connection");


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


