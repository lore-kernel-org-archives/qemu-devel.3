Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECE2CA1011
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 14:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utoZ7-00034p-La; Wed, 03 Sep 2025 10:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1utoZ5-00034M-RF
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1utoZ1-0002CH-U8
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756910057;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZlAFyy6ZIihUUvF0GI7a2InbM1f/HqAqAfTY+yypcAU=;
 b=Lbp03NYOH9lsT4H0u0/AYf9d0uaNIEnuexgY3q4XAeQn/EOmAHcF/K8bWSHkb280kKwy56
 R7vkKFNXTL8+btLzxvlRyZcY341Erq8VX995vYXIWhrG4Iaavo2aWUZOnr8QZszPZiB0t5
 c4M2LXgJuAZAwxBgTieNIaCEUpjYin4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-KLT6GGXuNE-q59erfqRrag-1; Wed,
 03 Sep 2025 10:34:14 -0400
X-MC-Unique: KLT6GGXuNE-q59erfqRrag-1
X-Mimecast-MFC-AGG-ID: KLT6GGXuNE-q59erfqRrag_1756910053
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E2361956078; Wed,  3 Sep 2025 14:34:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.63])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D3CC180057E; Wed,  3 Sep 2025 14:34:06 +0000 (UTC)
Date: Wed, 3 Sep 2025 16:34:02 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 peterx@redhat.com, mst@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2 5/8] net/tap: implement interfaces for local migration
Message-ID: <aLhR2unpr2xg2MYl@redhat.com>
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
 <20250903133706.1177633-6-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903133706.1177633-6-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 03, 2025 at 04:37:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Handle local-incoming option:
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/net/tap.h |   4 ++
>  net/tap.c         | 136 +++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 119 insertions(+), 21 deletions(-)
> 
> diff --git a/include/net/tap.h b/include/net/tap.h
> index 6f34f13eae..3ef2e2dbae 100644
> --- a/include/net/tap.h
> +++ b/include/net/tap.h
> @@ -30,7 +30,11 @@
>  
>  int tap_enable(NetClientState *nc);
>  int tap_disable(NetClientState *nc);
> +bool tap_local_incoming(NetClientState *nc);
>  
>  int tap_get_fd(NetClientState *nc);
>  
> +int tap_load(NetClientState *nc, QEMUFile *f);
> +int tap_save(NetClientState *nc, QEMUFile *f);
> +
>  #endif /* QEMU_NET_TAP_H */
> diff --git a/net/tap.c b/net/tap.c
> index a9d955ac5f..499db756ea 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -35,6 +35,8 @@
>  #include "net/eth.h"
>  #include "net/net.h"
>  #include "clients.h"
> +#include "migration/migration.h"
> +#include "migration/qemu-file.h"
>  #include "monitor/monitor.h"
>  #include "system/system.h"
>  #include "qapi/error.h"
> @@ -82,6 +84,7 @@ typedef struct TAPState {
>      VHostNetState *vhost_net;
>      unsigned host_vnet_hdr_len;
>      Notifier exit;
> +    bool local_incoming;
>  } TAPState;
>  
>  static void launch_script(const char *setup_script, const char *ifname,
> @@ -803,6 +806,40 @@ static int net_tap_init_vhost(TAPState *s, Error **errp) {
>      return 0;
>  }
>  
> +int tap_save(NetClientState *nc, QEMUFile *f)
> +{
> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> +
> +    qemu_file_put_fd(f, s->fd);
> +    qemu_put_byte(f, s->using_vnet_hdr);
> +    qemu_put_byte(f, s->has_ufo);
> +    qemu_put_byte(f, s->has_uso);
> +    qemu_put_byte(f, s->enabled);
> +    qemu_put_be32(f, s->host_vnet_hdr_len);


Is it neccessary to transfer that metadata, or is there perhaps a way
for the other side to query the TAP FD configuration from the kernel
to detect this ?

I'm concerned that this code / wire format is not extensible if we ever
add another similar field to TAPState in the future.

> +
> +    return 0;
> +}
> +
> +int tap_load(NetClientState *nc, QEMUFile *f)
> +{
> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> +
> +    s->fd = qemu_file_get_fd(f);
> +    if (s->fd < 0) {
> +        return -1;
> +    }
> +
> +    s->using_vnet_hdr = qemu_get_byte(f);
> +    s->has_ufo = qemu_get_byte(f);
> +    s->has_uso = qemu_get_byte(f);
> +    s->enabled = qemu_get_byte(f);
> +    qemu_get_be32s(f, &s->host_vnet_hdr_len);
> +
> +    tap_read_poll(s, true);
> +
> +    return net_tap_init_vhost(s, NULL);
> +}
> +
>  static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
>                                    const char *model, const char *name,
>                                    const char *ifname, const char *script,

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


