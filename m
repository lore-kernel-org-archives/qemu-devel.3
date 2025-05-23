Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D852C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 08:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uINaI-0005rp-BF; Fri, 23 May 2025 04:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uINaE-0005rX-IM
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:16:50 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uINaB-0003K7-8F
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:16:50 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22c33677183so71324595ad.2
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 01:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747988202; x=1748593002;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u3kW/H+0xDPjF44tWdaeTIDGemdKZNfbT5qa8KZspzY=;
 b=yq7x9ARGyc2k/OcHqKBeAQZMuZtUx6X5Boq49FlKtL10lvXRHX3RIvkmL6E8uTwRfU
 /aUdqJgWKM74FhfTnNls6Z3PajBxVVf4EjoMRf+HMlFrprbE4tb1VjSrLRq53GT/p4Yp
 OX9kLVvrzQJKThku5qOlngJldjUMrXV1qkAuWq1lyHVQyR7qlGlfR3+Qk0TXPJPi1ZG4
 oI8ZbIXqKzcfn7PSZi3jYHFQ0TqWJ/x7Ah8634UQft2B0kqYx8zgVyCejTapZzjtWBSj
 DqdvCSKBbpc+kAxgA+uXDN97bBztuFTY9GDE0zDj0SN1tPxsQ+urlik3ZLZvFcRgsIUQ
 FCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747988202; x=1748593002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u3kW/H+0xDPjF44tWdaeTIDGemdKZNfbT5qa8KZspzY=;
 b=QPbKEEUfibk/NOdnfqTTn9sm5c75cFjWeRlhAR/taQiAw5hee2srIzUE3xYlSy6+kv
 CkdTv7Zr4ndL1yW7b7fYMp25TyIDNVbMyGp0LsBpgpgHD7/sGA+kMsJMVi+V6l3YsiHn
 6/ho42gjozIVu7lnGlTuCm7NuiJaLRwXZBjloVFHJAEf3oKFSDNRTQJR8aKOtGkfd6g1
 1Y3OTcuMJJaElJEZYXsthhXJ7OqCLyaVkW6w0o3S+iaSXDK1Z5ii9K4Ge6JhxiFkoprP
 rZd7smWgiKon/QoAcbBfipFWXqGh9LoXLb1EpS1/FRUYip+FdFtfW84r6vUPXseJzjfB
 ld0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFf6EmSok+ooGoAZvX4WfSQh2iKOT5JdaMSwdpMU6et9RRBFQbg6d/FmZ5BUAU0fqnNFqdtAWVb2aM@nongnu.org
X-Gm-Message-State: AOJu0Yw75nfHTXC+hp40hdKTdlMNZpZekRw/Yi+fheLhZWWAUfDT6hFp
 m4Qb+acxAuoj0EehOu1+sO6Y7TfUp7P/d5BegZH/SU4scegdq6lhUbat4KRvMhEJRWU=
X-Gm-Gg: ASbGncsMuwbN0l/MFg5Lr0KnyRHnl0G8Oal6LczjpsuJqMVjl5a//x5LlERxN/f201G
 3euKnKdhoIHHjCoUeQfg6/EE0U8YfacVJzG5PI1V9Iobzh4vQWrnqnlZRxCWwjJODp0lGfFDuTd
 kwYNy+LFizvSa7QslAKUHLHhjGjxyWch2p1EHHYksFu4Z2/Up9exZU5a3BYohrK2ZNfzYvs4isQ
 FgHYHv1TEWhLXItpAVabZnMP21HDRevSY11SuGrmyKzZpHHxSEskv7nJwGVpmsfgudb7QWGQFiY
 GQA7G+ezQ9/ezblXgDlaQRG6uc3SQHj9XiMHOJKhoDrU2wSQlnfsfBq5sOT0yXJAyf5MG6wa
X-Google-Smtp-Source: AGHT+IESDDZjWTapufdTaXhM5i8a7xgR1iJVRanoGR2WxVk9svKgEd/uQZA8nkCYIw+zxiDxoE3TGw==
X-Received: by 2002:a17:902:ce10:b0:21f:988d:5756 with SMTP id
 d9443c01a7336-231de3acebfmr329208925ad.42.1747988202610; 
 Fri, 23 May 2025 01:16:42 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ac948asm119047805ad.22.2025.05.23.01.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 01:16:42 -0700 (PDT)
Message-ID: <0aba4f0d-f6e8-4c46-a183-eebb401c13a2@daynix.com>
Date: Fri, 23 May 2025 17:16:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/16] net: implement tnl feature offloading
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <3ee26dacd91d6c12ae4fc64bc42890553739a2fe.1747825544.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <3ee26dacd91d6c12ae4fc64bc42890553739a2fe.1747825544.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2025/05/21 20:34, Paolo Abeni wrote:
> When any host or guest GSO over UDP tunnel offload is enabled the
> virtio net header includes the additional tunnel-related fields,
> update the size accordingly.
> 
> Push the GSO over UDP tunnel offloads all the way down to the tap
> device extending the newly introduced NetFeatures struct, and
> eventually enable the associated features.
> 
> As per virtio specification, to convert features bit to offload bit,
> map the extended features into the reserved range.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   hw/net/virtio-net.c | 48 ++++++++++++++++++++++++++++++++++++++++-----
>   include/net/net.h   |  2 ++
>   net/net.c           |  7 ++++++-
>   net/tap-linux.c     |  6 ++++++
>   4 files changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 881877086e..758ceaffba 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -101,6 +101,27 @@
>   #define VIRTIO_FEATURE_TO_OFFLOAD(fbit)  (fbit >= 64 ? \
>                                             fbit - VIRTIO_O2F_DELTA : fbit)
>   
> +#ifdef CONFIG_INT128
> +#define VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO \
> +    VIRTIO_FEATURE_TO_OFFLOAD(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO)
> +#define VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO_CSUM \
> +    VIRTIO_FEATURE_TO_OFFLOAD(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM)
> +
> +static bool virtio_has_tnl_hdr(virtio_features_t features)

"tnl" looks a bit cryptic to me and also inconsistent with everywhere 
else, which just calls it "tunnel".

> +{
> +    return virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
> +           virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> +}
> +
> +#else
> +
> +static bool virtio_has_tnl_hdr(virtio_features_t features)
> +{
> +    return false;
> +}
> +
> +#endif
> +
>   static const VirtIOFeature feature_sizes[] = {
>       {.flags = 1ULL << VIRTIO_NET_F_MAC,
>        .end = endof(struct virtio_net_config, mac)},
> @@ -656,7 +677,8 @@ static int peer_has_tunnel(VirtIONet *n)
>   }
>   
>   static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
> -                                       int version_1, int hash_report)
> +                                       int version_1, int hash_report,
> +                                       int tnl)
>   {
>       int i;
>       NetClientState *nc;
> @@ -674,6 +696,9 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>               sizeof(struct virtio_net_hdr);
>           n->rss_data.populate_hash = false;
>       }
> +    if (tnl) {
> +        n->guest_hdr_len += sizeof(struct virtio_net_hdr_tunnel);
> +    }
>   
>       for (i = 0; i < n->max_queue_pairs; i++) {
>           nc = qemu_get_subqueue(n->nic, i);
> @@ -890,6 +915,12 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>          .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
>          .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
>          .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
> +#ifdef CONFIG_INT128
> +       .tnl  = !!(n->curr_guest_offloads &
> +                  (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO)),
> +       .tnl_csum = !!(n->curr_guest_offloads &
> +                      (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO_CSUM)),

"[PATCH RFC 14/16] net: bundle all offloads in a single struct" added a 
struct for offloading, but how about passing n->curr_guest_offloads as 
is instead?

It loses some type safety and makes it prone to have unknown bits, but 
omitting duplicate these bit operations may outweigh the downside.

> +#endif
>       };
>   
>       qemu_set_offload(qemu_get_queue(n->nic)->peer, &ol);
> @@ -911,7 +942,12 @@ virtio_net_guest_offloads_by_features(virtio_features_t features)
>           (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
>           (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
>           (1ULL << VIRTIO_NET_F_GUEST_USO4) |
> -        (1ULL << VIRTIO_NET_F_GUEST_USO6);
> +        (1ULL << VIRTIO_NET_F_GUEST_USO6)
> +#ifdef CONFIG_INT128
> +        | (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO)
> +        | (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO_CSUM)
> +#endif
> +        ;
>   
>       return guest_offloads_mask & virtio_net_features_to_offload(features);
>   }
> @@ -1020,7 +1056,8 @@ static void virtio_net_set_features(VirtIODevice *vdev,
>                                  virtio_has_feature(features,
>                                                     VIRTIO_F_VERSION_1),
>                                  virtio_has_feature(features,
> -                                                  VIRTIO_NET_F_HASH_REPORT));
> +                                                  VIRTIO_NET_F_HASH_REPORT),
> +                               virtio_has_tnl_hdr(features));
>   
>       n->rsc4_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
>           virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO4);
> @@ -3139,7 +3176,8 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
>                                  virtio_vdev_has_feature(vdev,
>                                                          VIRTIO_F_VERSION_1),
>                                  virtio_vdev_has_feature(vdev,
> -                                                       VIRTIO_NET_F_HASH_REPORT));
> +                                                       VIRTIO_NET_F_HASH_REPORT),
> +                               virtio_has_tnl_hdr(vdev->guest_features));
>   
>       /* MAC_TABLE_ENTRIES may be different from the saved image */
>       if (n->mac_table.in_use > MAC_TABLE_ENTRIES) {
> @@ -3946,7 +3984,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>   
>       n->vqs[0].tx_waiting = 0;
>       n->tx_burst = n->net_conf.txburst;
> -    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0);
> +    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0, 0);
>       n->promisc = 1; /* for compatibility */
>   
>       n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
> diff --git a/include/net/net.h b/include/net/net.h
> index c71d7c6074..5049d293f2 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -43,6 +43,8 @@ typedef struct NetOffloads {
>       bool ufo;
>       bool uso4;
>       bool uso6;
> +    bool tnl;
> +    bool tnl_csum;
>   } NetOffloads;
>   
>   #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
> diff --git a/net/net.c b/net/net.c
> index 5a2f00c108..bd41229407 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -569,13 +569,18 @@ int qemu_get_vnet_hdr_len(NetClientState *nc)
>   
>   void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
>   {
> +    int len_tnl = len - sizeof(struct virtio_net_hdr_tunnel);
> +
>       if (!nc || !nc->info->set_vnet_hdr_len) {
>           return;
>       }
>   
>       assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
> +           len_tnl == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
>              len == sizeof(struct virtio_net_hdr) ||
> -           len == sizeof(struct virtio_net_hdr_v1_hash));
> +           len_tnl == sizeof(struct virtio_net_hdr) ||
> +           len == sizeof(struct virtio_net_hdr_v1_hash) ||
> +           len_tnl == sizeof(struct virtio_net_hdr_v1_hash));
>   
>       nc->vnet_hdr_len = len;
>       nc->info->set_vnet_hdr_len(nc, len);
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index aa5f3a6e22..b7662ece63 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -287,6 +287,12 @@ void tap_fd_set_offload(int fd, const NetOffloads *ol)
>           if (ol->uso6) {
>               offload |= TUN_F_USO6;
>           }
> +        if ((ol->tso4 || ol->tso6 || ol->uso4 || ol->uso6) && ol->tnl) {

Is it possible to have ol->tnl without TSO or USO? If so, is ignoring 
ol->tnl really what you want?

> +            offload |= TUN_F_UDP_TUNNEL_GSO;
> +        }
> +        if ((offload & TUN_F_UDP_TUNNEL_GSO) && ol->tnl_csum) {
> +            offload |= TUN_F_UDP_TUNNEL_GSO_CSUM;
> +        }
>       }
>   
>       if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {


