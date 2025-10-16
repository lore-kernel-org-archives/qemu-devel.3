Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF871CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 08:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9JHD-0002ph-6g; Thu, 16 Oct 2025 04:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9JHB-0002pZ-UH
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9JH6-0001Wx-QS
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760603030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BrfVu+P/L+IZnvNxlGPBlmTbe6SqMAQh9HcCFs1g53Y=;
 b=SrYL7ZyOVBioqwtqQhXf0FI9aR059Y85Pu8gfZdBqMTDY5zBQQn7EbJFXLjyCPMC6jsO3k
 pqbNHR0ScyMhGh+C7Pa4hGbhpALKmOupG4Xoc6aazijUfqTKCrsbMraWRvJtDhvivISuhN
 AyMHztefBbGiQJEgoWUrVFi+cIwL7Gg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-LW2IqKI-NFaxaTMdxsUK4Q-1; Thu,
 16 Oct 2025 04:23:48 -0400
X-MC-Unique: LW2IqKI-NFaxaTMdxsUK4Q-1
X-Mimecast-MFC-AGG-ID: LW2IqKI-NFaxaTMdxsUK4Q_1760603026
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0858D18002F5; Thu, 16 Oct 2025 08:23:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44FCA1954126; Thu, 16 Oct 2025 08:23:39 +0000 (UTC)
Date: Thu, 16 Oct 2025 09:23:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, farosas@suse.de,
 sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 17/19] virtio-net: support backend-transfer migration
 for virtio-net/tap
Message-ID: <aPCriMKg_UolIrHK@redhat.com>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
 <20251015132136.1083972-18-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015132136.1083972-18-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 15, 2025 at 04:21:33PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add virtio-net option backend-transfer, which is true by default,
> but false for older machine types, which doesn't support the feature.
> 
> For backend-transfer migration, both global migration parameter
> backend-transfer and virtio-net backend-transfer option should be
> set to true.
> 
> With the parameters enabled (both on source and target) of-course, and
> with unix-socket used as migration-channel, we do "migrate" the
> virtio-net backend - TAP device, with all its fds.
> 
> This way management tool should not care about creating new TAP, and
> should not handle switching to it. Migration downtime become shorter.
> 
> How it works:
> 
> 1. For incoming migration, we postpone TAP initialization up to
>    pre-incoming point.
> 
> 2. At pre-incoming point we see that "virtio-net-tap" is set for
>    backend-transfer, so we postpone TAP initialization up to
>    post-load
> 
> 3. During virtio-load, we get TAP state (and fds) as part of
>    virtio-net state
> 
> 4. In post-load we finalize TAP initialization
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/core/machine.c              |  1 +
>  hw/net/virtio-net.c            | 75 +++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-net.h |  1 +
>  include/net/tap.h              |  2 +
>  net/tap.c                      | 45 +++++++++++++++++++-
>  5 files changed, 122 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 681adbb7ac..a3d77f5604 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -40,6 +40,7 @@
>  
>  GlobalProperty hw_compat_10_1[] = {
>      { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> +    { TYPE_VIRTIO_NET, "backend-transfer", "false" },
>  };
>  const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
>  
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 661413c72f..5f9711dee7 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -38,6 +38,7 @@
>  #include "qapi/qapi-events-migration.h"
>  #include "hw/virtio/virtio-access.h"
>  #include "migration/misc.h"
> +#include "migration/options.h"
>  #include "standard-headers/linux/ethtool.h"
>  #include "system/system.h"
>  #include "system/replay.h"
> @@ -3358,6 +3359,9 @@ struct VirtIONetMigTmp {
>      uint16_t        curr_queue_pairs_1;
>      uint8_t         has_ufo;
>      uint32_t        has_vnet_hdr;
> +
> +    NetClientState *ncs;
> +    uint32_t max_queue_pairs;
>  };
>  
>  /* The 2nd and subsequent tx_waiting flags are loaded later than
> @@ -3627,6 +3631,71 @@ static const VMStateDescription vhost_user_net_backend_state = {
>      }
>  };
>  
> +static bool virtio_net_is_tap_mig(void *opaque, int version_id)
> +{
> +    VirtIONet *n = opaque;
> +    NetClientState *nc;
> +
> +    nc = qemu_get_queue(n->nic);
> +
> +    return migrate_backend_transfer() && n->backend_transfer && nc->peer &&
> +        nc->peer->info->type == NET_CLIENT_DRIVER_TAP;
> +}
> +
> +static int virtio_net_nic_pre_save(void *opaque)
> +{
> +    struct VirtIONetMigTmp *tmp = opaque;
> +
> +    tmp->ncs = tmp->parent->nic->ncs;
> +    tmp->max_queue_pairs = tmp->parent->max_queue_pairs;
> +
> +    return 0;
> +}
> +
> +static int virtio_net_nic_pre_load(void *opaque)
> +{
> +    /* Reuse the pointer setup from save */
> +    virtio_net_nic_pre_save(opaque);
> +
> +    return 0;
> +}
> +
> +static int virtio_net_nic_post_load(void *opaque, int version_id)
> +{
> +    struct VirtIONetMigTmp *tmp = opaque;
> +    Error *local_err = NULL;
> +
> +    if (!virtio_net_update_host_features(tmp->parent, &local_err)) {
> +        error_report_err(local_err);
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_virtio_net_nic_nc = {
> +    .name = "virtio-net-nic-nc",
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT_POINTER(peer, NetClientState, vmstate_tap,
> +                               NetClientState),
> +        VMSTATE_END_OF_LIST()
> +   },
> +};
> +
> +static const VMStateDescription vmstate_virtio_net_nic = {
> +    .name      = "virtio-net-nic",
> +    .pre_load  = virtio_net_nic_pre_load,
> +    .pre_save  = virtio_net_nic_pre_save,
> +    .post_load  = virtio_net_nic_post_load,
> +    .fields    = (const VMStateField[]) {
> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(ncs, struct VirtIONetMigTmp,
> +                                             max_queue_pairs,
> +                                             vmstate_virtio_net_nic_nc,
> +                                             struct NetClientState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_virtio_net_device = {
>      .name = "virtio-net-device",
>      .version_id = VIRTIO_NET_VM_VERSION,
> @@ -3658,6 +3727,9 @@ static const VMStateDescription vmstate_virtio_net_device = {
>           * but based on the uint.
>           */
>          VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
> +        VMSTATE_WITH_TMP_TEST(VirtIONet, virtio_net_is_tap_mig,
> +                              struct VirtIONetMigTmp,
> +                              vmstate_virtio_net_nic),
>          VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
>                           vmstate_virtio_net_has_vnet),
>          VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
> @@ -4239,7 +4311,7 @@ static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
>      VirtIONet *n = opaque;
>      int i;
>  
> -    if (peer_wait_incoming(n)) {
> +    if (!virtio_net_is_tap_mig(opaque, 0) && peer_wait_incoming(n)) {
>          for (i = 0; i < n->max_queue_pairs; i++) {
>              if (!peer_postponed_init(n, i, errp)) {
>                  return false;
> @@ -4389,6 +4461,7 @@ static const Property virtio_net_properties[] = {
>                                 host_features_ex,
>                                 VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
>                                 false),
> +    DEFINE_PROP_BOOL("backend-transfer", VirtIONet, backend_transfer, true),
>  };
>  
>  static void virtio_net_class_init(ObjectClass *klass, const void *data)

I really don't like this approach, because it is requiring the frontend
device to know about every different backend implementation that is able
to do state transfer. This really violates the separation from the
frontend and backend. The choice of specific backend should generally
be opaque to the frontend.

This really ought to be redesigned to work in terms of an formal API
exposed by the backend, not poking at TAP backend specific details.
eg an API that operates on NetClientState, for which each backend
can provide an optional implementation. 


> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index 5b8ab7bda7..bf07f8a4cb 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -231,6 +231,7 @@ struct VirtIONet {
>      struct EBPFRSSContext ebpf_rss;
>      uint32_t nr_ebpf_rss_fds;
>      char **ebpf_rss_fds;
> +    bool backend_transfer;
>  };
>  
>  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
> diff --git a/include/net/tap.h b/include/net/tap.h
> index 5a926ba513..506f7ab719 100644
> --- a/include/net/tap.h
> +++ b/include/net/tap.h
> @@ -36,4 +36,6 @@ int tap_get_fd(NetClientState *nc);
>  bool tap_wait_incoming(NetClientState *nc);
>  bool tap_postponed_init(NetClientState *nc, Error **errp);
>  
> +extern const VMStateDescription vmstate_tap;
> +
>  #endif /* QEMU_NET_TAP_H */
> diff --git a/net/tap.c b/net/tap.c
> index 8afbf3b407..b9c12dd64c 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -819,7 +819,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>  
>  static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp)
>  {
> -    if (!net_tap_set_fd(s, fd, vnet_hdr, errp)) {
> +    if (fd != -1 && !net_tap_set_fd(s, fd, vnet_hdr, errp)) {
>          return false;
>      }
>  
> @@ -1225,6 +1225,49 @@ int tap_disable(NetClientState *nc)
>      }
>  }
>  
> +static int tap_pre_load(void *opaque)
> +{
> +    TAPState *s = opaque;
> +
> +    if (s->fd != -1) {
> +        error_report(
> +            "TAP is already initialized and cannot receive incoming fd");
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int tap_post_load(void *opaque, int version_id)
> +{
> +    TAPState *s = opaque;
> +    Error *local_err = NULL;
> +
> +    if (!net_tap_setup(s, -1, -1, &local_err)) {
> +        error_report_err(local_err);
> +        qemu_del_net_client(&s->nc);
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_tap = {
> +    .name = "net-tap",
> +    .pre_load = tap_pre_load,
> +    .post_load = tap_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_FD(fd, TAPState),
> +        VMSTATE_BOOL(using_vnet_hdr, TAPState),
> +        VMSTATE_BOOL(has_ufo, TAPState),
> +        VMSTATE_BOOL(has_uso, TAPState),
> +        VMSTATE_BOOL(has_tunnel, TAPState),
> +        VMSTATE_BOOL(enabled, TAPState),
> +        VMSTATE_UINT32(host_vnet_hdr_len, TAPState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  bool tap_wait_incoming(NetClientState *nc)
>  {
>      TAPState *s = DO_UPCAST(TAPState, nc, nc);

IMHO implementing state transfer in the backends ought to be separate
commit from adding support for using that in the frontend.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


