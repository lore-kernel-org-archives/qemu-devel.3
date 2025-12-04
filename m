Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A217D24458
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDcX-0004Uz-FO; Thu, 04 Dec 2025 13:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vRDcW-0004UX-2h
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:00:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vRDcU-0003Yz-4l
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764871196;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=F8WUVNCFku1FbIcPsCqaRKkEXdIfHlbxFQYvg33BHkg=;
 b=CTOJl/jAwearAHsbfzschHr2bsdSFfxUKzVTlDAAFv70mPS1mjCDKMNjbN5gBYvpXpz/MP
 pNfOFlnFVpIScWf/y14Vgh4tZmKRD7Q84ppEalJV4h4j92bzCokJ5LfGjS1VBHJyAhn4C3
 vEAafFivzITmvQwJ87xVc/npXwksaCw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-HXFH91L0MH2Gbm8QvsedEQ-1; Thu,
 04 Dec 2025 12:59:53 -0500
X-MC-Unique: HXFH91L0MH2Gbm8QvsedEQ-1
X-Mimecast-MFC-AGG-ID: HXFH91L0MH2Gbm8QvsedEQ_1764871191
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D20631800358; Thu,  4 Dec 2025 17:59:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F1661953986; Thu,  4 Dec 2025 17:59:44 +0000 (UTC)
Date: Thu, 4 Dec 2025 17:59:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ben Chaney <bchaney@akamai.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v3 8/8] tap: cpr fixes
Message-ID: <aTHMDQihX3ywKdlH@redhat.com>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
 <20251203-cpr-tap-v3-8-3c12e0a61f8e@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251203-cpr-tap-v3-8-3c12e0a61f8e@akamai.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 03, 2025 at 01:51:25PM -0500, Ben Chaney wrote:
> From: Steve Sistare <steven.sistare@oracle.com>
> 
> Fix "virtio_net_set_queue_pairs: Assertion `!r' failed."
> Fix "virtio-net: saved image requires vnet_hdr=on"
> Do not change blocking mode of incoming cpr fd's.
> 
> Reported-by: Ben Chaney <bchaney@akamai.com>
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Ben Chaney <bchaney@akamai.com>
> ---
>  hw/net/virtio-net.c | 6 ++++++
>  io/channel-socket.c | 4 +++-
>  net/tap.c           | 2 ++
>  stubs/cpr.c         | 8 ++++++++
>  stubs/meson.build   | 1 +
>  5 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 38ec7ac109..fd6b30b296 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -37,6 +37,7 @@
>  #include "qapi/qapi-types-migration.h"
>  #include "qapi/qapi-events-migration.h"
>  #include "hw/virtio/virtio-access.h"
> +#include "migration/cpr.h"
>  #include "migration/misc.h"
>  #include "standard-headers/linux/ethtool.h"
>  #include "system/system.h"
> @@ -789,6 +790,11 @@ static void virtio_net_set_queue_pairs(VirtIONet *n)
>      int i;
>      int r;
>  
> +    if (cpr_is_incoming()) {
> +        /* peers are already attached, do nothing */
> +        return;
> +    }
> +
>      if (n->nic->peer_deleted) {
>          return;
>      }
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 3053b35ad8..443ca8cb7c 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -24,6 +24,7 @@
>  #include "io/channel-socket.h"
>  #include "io/channel-util.h"
>  #include "io/channel-watch.h"
> +#include "migration/cpr.h"
>  #include "trace.h"
>  #include "qapi/clone-visitor.h"
>  #ifdef CONFIG_LINUX
> @@ -521,7 +522,8 @@ static bool qio_channel_handle_fds(int *fds, size_t nfds,
>  
>          if (!preserve_blocking) {
>              /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> -            if (!qemu_set_blocking(*fd, true, errp)) {
> +              if (!cpr_is_incoming() &&
> +                  qemu_set_blocking(*fd, true, errp)) {
>                  return false;
>              }
>          }

This is wrong - we added the QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING
flag precisely so that we don't need to add CPR hacks into QIOChannelSocket
code.

Whatever cares about this blocking state being preserved needs to pass
that QIO_CHANNEL flag when reading from the channel.

> diff --git a/net/tap.c b/net/tap.c
> index 5acda81146..5e04099c87 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -1050,6 +1050,8 @@ free_fail:
>                  if (cpr && fd >= 0) {
>                      cpr_save_fd(name, TAP_FD_INDEX(i), fd);
>                  }
> +            } else {
> +                vnet_hdr = tap->has_vnet_hdr ? tap->vnet_hdr : 1;
>              }
>              if (fd == -1) {
>                  ret = -1;
> diff --git a/stubs/cpr.c b/stubs/cpr.c
> new file mode 100644
> index 0000000000..1a4dbbb2d7
> --- /dev/null
> +++ b/stubs/cpr.c
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include "qemu/osdep.h"
> +#include "migration/cpr.h"
> +
> +bool cpr_is_incoming(void)
> +{
> +    return false;
> +}
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 0b2778c568..87af733528 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -10,6 +10,7 @@ stub_ss.add(files('is-daemonized.c'))
>  stub_ss.add(files('monitor-core.c'))
>  stub_ss.add(files('replay-mode.c'))
>  stub_ss.add(files('trace-control.c'))
> +stub_ss.add(files('cpr.c'))
>  
>  if have_block
>    stub_ss.add(files('bdrv-next-monitor-owned.c'))
> 
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


