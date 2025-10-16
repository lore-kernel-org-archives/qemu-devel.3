Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B67ECCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Maq-0005Fw-2Q; Thu, 16 Oct 2025 07:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9Man-0005Fo-Gp
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 07:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9Maf-0005UA-7n
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 07:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760615773;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1I4drb4XtdowEVqLW7tOZ+H/OOR4BufV3ep4aM8imYQ=;
 b=PII4u0H2dW4+xJqDb5QYbOk665cuTAhjbn4KlE/W78ou6sA1rTRFHRXGC2PFy9t3OfYpkN
 GzkVsuDXykxFwT51gqQ8yS+lX8xfknIMcXJEK5NE72sD7ZboIeG7bN2ciTCwhk9URQi1hy
 BDom+myuufQ9oFvE/cA+kKQhD7ds69s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-YlDhIn6wOZ-QDjXS6S5TGw-1; Thu,
 16 Oct 2025 07:56:10 -0400
X-MC-Unique: YlDhIn6wOZ-QDjXS6S5TGw-1
X-Mimecast-MFC-AGG-ID: YlDhIn6wOZ-QDjXS6S5TGw_1760615769
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F8BB180035D; Thu, 16 Oct 2025 11:56:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EDB5195419F; Thu, 16 Oct 2025 11:56:02 +0000 (UTC)
Date: Thu, 16 Oct 2025 12:55:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de,
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: Re: [PATCH v2 18/25] chardev: introduce backend-transfer vmstate for
 chardev
Message-ID: <aPDdThfXS4lOB8nV@redhat.com>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-19-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016114104.1384675-19-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Oct 16, 2025 at 02:40:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> We'll need to transfer the chardev attached to vhost-user-blk, to
> support backend-transfer migration for vhost-user-blk. So, prepare
> chardev vmsd now.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  chardev/char-backend-transfer.c         | 52 +++++++++++++++++++++++++
>  chardev/meson.build                     |  1 +
>  include/chardev/char-backend-transfer.h | 17 ++++++++
>  3 files changed, 70 insertions(+)
>  create mode 100644 chardev/char-backend-transfer.c
>  create mode 100644 include/chardev/char-backend-transfer.h
> 
> diff --git a/chardev/char-backend-transfer.c b/chardev/char-backend-transfer.c
> new file mode 100644
> index 0000000000..f1a399c7fa
> --- /dev/null
> +++ b/chardev/char-backend-transfer.c
> @@ -0,0 +1,52 @@
> +/*
> + * Event notifier migration support
> + * Copyright (c) Yandex Technologies LLC, 2025
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "chardev/char-fe.h"
> +#include "migration/vmstate.h"
> +
> +typedef struct CharBackendTransferTmp {
> +    CharBackend *parent;
> +    int fd;
> +} CharBackendTransferTmp;
> +
> +static int char_backend_transfer_pre_save(void *opaque)
> +{
> +    CharBackendTransferTmp *tmp = opaque;
> +
> +    tmp->fd = qemu_chr_get_client(tmp->parent->chr);
> +    if (tmp->fd < 0) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int char_backend_transfer_post_load(void *opaque, int version_id)
> +{
> +    CharBackendTransferTmp *tmp = opaque;
> +
> +    return qemu_chr_add_client(tmp->parent->chr, tmp->fd);
> +}
> +
> +const VMStateDescription vmstate_backend_transfer_char_tmp = {
> +    .name = "backend-transfer-char-tmp",
> +    .pre_save = char_backend_transfer_pre_save,
> +    .post_load = char_backend_transfer_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_FD(fd, CharBackendTransferTmp),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +const VMStateDescription vmstate_backend_transfer_char = {
> +    .name = "backend-transfer-char",
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_WITH_TMP(CharBackend, CharBackendTransferTmp,
> +                         vmstate_backend_transfer_char_tmp),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};

On the one hand this code is positioned as if it were a generic
mechanism for transferring chardev vmstate, but on the oother
hand it is hardcoded to only work with the socket chardev and
is only able to transfer an FD, no other state.

Socket chardevs can involve telnet, tls or websocket protocol
layering all of which have considerable state that is being
ignored by this.

IMHO each chardev backend needs to be directly responsible
for handling vmstate, and it needs to be able to raise an
error if there is state which cannot be transferred. This
would avoid creatin of the undesirable qemu_chr_get_client
method as public API.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


