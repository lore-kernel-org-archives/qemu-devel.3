Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57839CD4F54
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 09:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR4ph-0004wb-VR; Sun, 24 May 2026 05:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR4pf-0004wH-Vk
 for qemu-devel@nongnu.org; Sun, 24 May 2026 05:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR4pd-0008Gf-5R
 for qemu-devel@nongnu.org; Sun, 24 May 2026 05:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779613751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T85q0HhZTfEcSs0tDpaSLgkfK1vYVp551yL3CUZAAc4=;
 b=eL9U/ZNx+rHtmtwFAEHe5Wi92wKsV9atman68ckkH6jNFdTF6qUCXzME1Z8i45+Kyc6pHR
 l4rOt5uI6A+mYlzAwfyS7fYf2TR0QuUI/ChtXLoZETCtrTK8X0MRT2CIHODTypS82uS0Fc
 Cnj0q2gC/UFFOuMLDuJ64toTe3DHgdg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-A1dUgogVOOmMfGXnWWQQWQ-1; Sun, 24 May 2026 05:09:08 -0400
X-MC-Unique: A1dUgogVOOmMfGXnWWQQWQ-1
X-Mimecast-MFC-AGG-ID: A1dUgogVOOmMfGXnWWQQWQ_1779613747
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49048bcbeb8so19436245e9.2
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779613747; x=1780218547; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T85q0HhZTfEcSs0tDpaSLgkfK1vYVp551yL3CUZAAc4=;
 b=AUxuqbAKypQmR4B79inwd7p1sPPnSAeiBzGvxaI7d0Rdkf9Fy/mZ3INdtYhAV1UXr1
 S27SozMjcHxjdb8yEUnQoIxXGRUiU0LNw9ukpm2pC/mKVE8vyuCZD6bxAf4qmqC1i8ng
 TngRzo8n1P+cMadka/yvSq5yCpodW1ypeWEZapy04Sn5IitKA0IxhLVi6XRT83+VkjME
 UEY/zZyGHIT65qlMCiRUrZ7A3MSABvLgZpG5dAzc0Qtn94dur7LSv7kOp3+YBRTbrJ+/
 sa+TbBArkRiBmO9JULl7DUfGDyVH9hhj0xTY8pPAPMIfRP4NRmXzvKjhLoyGRSuE58oE
 i+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779613747; x=1780218547;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T85q0HhZTfEcSs0tDpaSLgkfK1vYVp551yL3CUZAAc4=;
 b=HUwsHMd/0elHVYQokGM60qzMHoJyIzc6RR8fqCMmBRfy0H74vqwePNvt2HmkrNmGXN
 4b4gM35yb2KrNCGQ+jKE/jJ7vYpzwSHvcKnZUppX0HlmRxI/85acY/WmOx+jnTYBOudl
 pXLJRpXlbfaDswaIYvTdvA7CfaDyED2hSH32WL+DZN0GnvC5cJO5u+XvPrdWofTAg3Qt
 dpV/To2qwnx9i90wH/+/eTkVXhXChIzRdgI/NVQvTsIxlLZJ8TxydXgjLnSl1CGD5u5l
 84u/mvO47pwwyWLRe+VLcR2POSypPYhu0UYYpexBaEy2kjC5sMHyVQNupgMvKoPDSJxA
 w3xA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Tpxh2dTrixN4kZtWO4Q0maFH+MTg4uHd6QqoY5rhj4LBiXiGacDLz2h3pfDZkbPs9kpgLE+yaU59T@nongnu.org
X-Gm-Message-State: AOJu0YxT3yVxJoQVqMFVaCN7HSBqc6Byg3iEhOfRQ6g+cD5lF0kUD6vs
 Oot1Z9t6Tv8ObkPbXbjqd+Qd3+A3mgUDPVHXX6rcAbu8mzoRJEmk5AmvlyASAeJ/Ssocjl3mgQj
 frygO3SUje3v1Nn+5wruB5kFMnbQq7UCzSzOw6SvumX2VmU6A3Lyb8xTI
X-Gm-Gg: Acq92OHKoNyMvZRCKIavkyM+1lV18qPCUU+QlcP6pLS8SPSjquY1pHyWVp2uQkZimYC
 fmurW133eOZOD9cOLyjJ3q8d+mS+UaijjHRgZhIuKCx+Z+bLMk9Kg2OeR97h6BFxgTRNM49HlNv
 WwAUxJ5rA9S21LPL2drV3BGr97qKC1kIy9AQ5bsv2anIFPVqXl7Y4JLr5XTwL//HxlE+QILtUVr
 wuWHRcNP7tpD085o5g4i7TthnVhnw4HATa5zV2hatSxKRuUXvgn+w4QrHdYfkjMRJfHeEpNy8Ng
 1nZKbPqxNk2i0WsgDwkKdvhcD5vv3FvkGhAJbWFgO2afTC+2KwJTb0QVOhQorLmsmdSLzx6Wlog
 Mdvi6LQLUk5yVYOcZWcVjRplyAqIKQFjOQPLvf7hl/zE=
X-Received: by 2002:a05:600c:3b0a:b0:490:60cb:560b with SMTP id
 5b1f17b1804b1-49060cb57b1mr17700435e9.28.1779613746918; 
 Sun, 24 May 2026 02:09:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0a:b0:490:60cb:560b with SMTP id
 5b1f17b1804b1-49060cb57b1mr17699835e9.28.1779613746308; 
 Sun, 24 May 2026 02:09:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490452580dfsm81802635e9.1.2026.05.24.02.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 02:09:05 -0700 (PDT)
Date: Sun, 24 May 2026 05:09:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, armbru@redhat.com, peterx@redhat.com,
 farosas@suse.de, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v16 5/8] virtio-net: support local migration of backend
Message-ID: <20260524050632-mutt-send-email-mst@kernel.org>
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
 <20260522120534.77653-6-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522120534.77653-6-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 22, 2026 at 03:05:30PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add virtio-net option local-migration, which is true by default,
> but false for older machine types, which doesn't support the feature.
> 
> When both global migration parameter "local" and new virtio-net
> parameter "local-migration" are true, virtio-net transfer the whole
> net backend to the destination, including open file descriptors.
> Of-course, its only for local migration and the channel must be
> UNIX domain socket.
> 
> This way management tool should not care about creating new TAP, and
> should not handle switching to it. Migration downtime become shorter.
> 
> Support for TAP will come in the next commit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Ben Chaney <bchaney@akamai.com>

I don't get why is this a device property?
It's clearly a backend thing?



> ---
>  hw/core/machine.c              |   1 +
>  hw/i386/pc_q35.c               |   1 +
>  hw/net/virtio-net.c            | 137 ++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-net.h |   2 +
>  include/net/net.h              |   2 +
>  5 files changed, 142 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 63baff859f3..619e80c1cb3 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,7 @@
>  
>  GlobalProperty hw_compat_11_0[] = {
>      { "chardev-vc", "encoding", "cp437" },
> +    { TYPE_VIRTIO_NET, "local-migration", "false" },
>  };
>  const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>  
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d8fed698c72..b5c0e302d59 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -368,6 +368,7 @@ static void pc_q35_machine_options(MachineClass *m)
>  static void pc_q35_machine_11_1_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
> +    compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>  }
>  
>  DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2a5d642a647..158b9247a58 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -38,8 +38,10 @@
>  #include "qapi/qapi-events-migration.h"
>  #include "hw/virtio/virtio-access.h"
>  #include "migration/misc.h"
> +#include "migration/options.h"
>  #include "standard-headers/linux/ethtool.h"
>  #include "system/system.h"
> +#include "system/runstate.h"
>  #include "system/replay.h"
>  #include "trace.h"
>  #include "monitor/qdev.h"
> @@ -3060,7 +3062,17 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
>      n->multiqueue = multiqueue;
>      virtio_net_change_num_queues(n, max * 2 + 1);
>  
> -    virtio_net_set_queue_pairs(n);
> +    /*
> +     * virtio_net_set_multiqueue() called from set_features(0) on early
> +     * reset, when peer may wait for incoming (and is not initialized
> +     * yet).
> +     * Don't worry about it: virtio_net_set_queue_pairs() will be called
> +     * later form virtio_net_post_load_device(), and anyway will be
> +     * noop for local incoming migration with live backend passing.
> +     */
> +    if (!n->peers_wait_incoming) {
> +        virtio_net_set_queue_pairs(n);
> +    }
>  }
>  
>  static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
> @@ -3089,6 +3101,17 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>  
>      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
>  
> +    if (n->peers_wait_incoming) {
> +        /*
> +         * Excessive feature set is OK for early initialization when
> +         * we wait for local incoming migration: actual guest-negotiated
> +         * features will come with migration stream anyway. And we are sure
> +         * that we support same host-features as source, because the backend
> +         * is the same (the same TAP device, for example).
> +         */
> +        return;
> +    }
> +
>      if (!peer_has_vnet_hdr(n)) {
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
> @@ -3179,6 +3202,18 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>      }
>  }
>  
> +static bool virtio_net_update_host_features(VirtIONet *n, Error **errp)
> +{
> +    ERRP_GUARD();
> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
> +
> +    peer_test_vnet_hdr(n);
> +
> +    virtio_net_get_features(vdev, &vdev->host_features, errp);
> +
> +    return !*errp;
> +}
> +
>  static int virtio_net_post_load_device(void *opaque, int version_id)
>  {
>      VirtIONet *n = opaque;
> @@ -3300,6 +3335,9 @@ struct VirtIONetMigTmp {
>      uint16_t        curr_queue_pairs_1;
>      uint8_t         has_ufo;
>      uint32_t        has_vnet_hdr;
> +
> +    NetClientState *ncs;
> +    uint32_t max_queue_pairs;
>  };
>  
>  /* The 2nd and subsequent tx_waiting flags are loaded later than
> @@ -3569,6 +3607,57 @@ static const VMStateDescription vhost_user_net_backend_state = {
>      }
>  };
>  
> +static bool virtio_net_migrate_local(void *opaque, int version_id)
> +{
> +    VirtIONet *n = opaque;
> +
> +    return migrate_local() && n->local_migration;
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
> +static const VMStateDescription vmstate_virtio_net_nic = {
> +    .name      = "virtio-net-nic",
> +    .pre_load  = virtio_net_nic_pre_load,
> +    .pre_save  = virtio_net_nic_pre_save,
> +    .post_load  = virtio_net_nic_post_load,
> +    .fields    = (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(ncs, struct VirtIONetMigTmp,
> +                              max_queue_pairs, 0, vmstate_net_peer_backend,
> +                              NetClientState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_virtio_net_device = {
>      .name = "virtio-net-device",
>      .version_id = VIRTIO_NET_VM_VERSION,
> @@ -3600,6 +3689,9 @@ static const VMStateDescription vmstate_virtio_net_device = {
>           * but based on the uint.
>           */
>          VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
> +        VMSTATE_WITH_TMP_TEST(VirtIONet, virtio_net_migrate_local,
> +                              struct VirtIONetMigTmp,
> +                              vmstate_virtio_net_nic),
>          VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
>                           vmstate_virtio_net_has_vnet),
>          VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
> @@ -3864,6 +3956,42 @@ static bool failover_hide_primary_device(DeviceListener *listener,
>      return qatomic_read(&n->failover_primary_hidden);
>  }
>  
> +static bool virtio_net_check_peers_wait_incoming(VirtIONet *n, bool *waiting,
> +                                                 Error **errp)
> +{
> +    bool has_waiting = false;
> +    bool has_not_waiting = false;
> +
> +    for (int i = 0; i < n->max_queue_pairs; i++) {
> +        NetClientState *peer = n->nic->ncs[i].peer;
> +        if (!peer) {
> +            continue;
> +        }
> +
> +        if (peer->info->is_wait_incoming &&
> +            peer->info->is_wait_incoming(peer)) {
> +            has_waiting = true;
> +        } else {
> +            has_not_waiting = true;
> +        }
> +
> +        if (has_waiting && has_not_waiting) {
> +            error_setg(errp, "Mixed peer states: some peers wait for incoming "
> +                       "migration while others don't");
> +            return false;
> +        }
> +    }
> +
> +    if (has_waiting && !runstate_check(RUN_STATE_INMIGRATE)) {
> +        error_setg(errp, "Peers wait for incoming, but it's not an incoming "
> +                   "migration.");
> +        return false;
> +    }
> +
> +    *waiting = has_waiting;
> +    return true;
> +}
> +
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -4001,6 +4129,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>          n->nic->ncs[i].do_not_pad = true;
>      }
>  
> +    if (!virtio_net_check_peers_wait_incoming(n, &n->peers_wait_incoming,
> +                                              errp)) {
> +        virtio_cleanup(vdev);
> +        return;
> +    }
> +
>      peer_test_vnet_hdr(n);
>      if (peer_has_vnet_hdr(n)) {
>          n->host_hdr_len = sizeof(struct virtio_net_hdr);
> @@ -4310,6 +4444,7 @@ static const Property virtio_net_properties[] = {
>                                 host_features_ex,
>                                 VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
>                                 true),
> +    DEFINE_PROP_BOOL("local-migration", VirtIONet, local_migration, true),
>  };
>  
>  static void virtio_net_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index 371e3764282..0c14e314409 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -230,6 +230,8 @@ struct VirtIONet {
>      struct EBPFRSSContext ebpf_rss;
>      uint32_t nr_ebpf_rss_fds;
>      char **ebpf_rss_fds;
> +    bool peers_wait_incoming;
> +    bool local_migration;
>  };
>  
>  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
> diff --git a/include/net/net.h b/include/net/net.h
> index aa34043b1ac..d4cf399d4a8 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -82,6 +82,7 @@ typedef void (SocketReadStateFinalize)(SocketReadState *rs);
>  typedef void (NetAnnounce)(NetClientState *);
>  typedef bool (SetSteeringEBPF)(NetClientState *, int);
>  typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
> +typedef bool (IsWaitIncoming)(NetClientState *);
>  typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
>  
>  typedef struct NetClientInfo {
> @@ -110,6 +111,7 @@ typedef struct NetClientInfo {
>      NetAnnounce *announce;
>      SetSteeringEBPF *set_steering_ebpf;
>      NetCheckPeerType *check_peer_type;
> +    IsWaitIncoming *is_wait_incoming;
>      GetVHostNet *get_vhost_net;
>      const VMStateDescription *backend_vmsd;
>  } NetClientInfo;
> -- 
> 2.52.0


