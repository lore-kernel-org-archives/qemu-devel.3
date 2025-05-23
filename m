Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A29C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 08:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uINTa-0001hR-7T; Fri, 23 May 2025 04:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uINTS-0001gk-Pa
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:09:51 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uINTN-0002Ga-IX
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:09:50 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af523f4511fso6642319a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 01:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747987783; x=1748592583;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=akhvn3Q2qLGxjvbKASz1j1GRfR5912bFSU6LtTygVQ8=;
 b=OQpl1nyA67B9JCnb9TmN1l1Up9kuplNhENhoShEBMsl8YkAazAOpPIG3ixLSue/FAa
 GxSXNSMuazETdFf5Qe2n6uinWxLGoekhffxigMTwUWg5vz6/Uy5FFpLweWb/bgdmuPYt
 p51qLQHWmkWeN+pQVucElaKRoRzxPkn6lWa6TjYtP0PKf+g0DJkInEZhqeHwBIYiANqu
 U/2s867Voyo96k5WBcz6l/aaPyPgQ/EE6GA7yMidmWDixh6g0pa+RGJtCEwogYvxijiA
 zSfwP8Q4IeiU0yXMMtcONXKzfcof/bhDAw/g+hHqjEvTp7AJsdpLxVsKlJhZso/8CS5w
 PIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747987783; x=1748592583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=akhvn3Q2qLGxjvbKASz1j1GRfR5912bFSU6LtTygVQ8=;
 b=I50t4LAZGvbKecMOeojteCQJtfLGu+dTsIr+SjRXZhf0KVA9uBHaL6AUTc7Ps4avgl
 fzWQD5DS53G0gVSWGg+dhh1IeaHYcwS1fmSvPUGD+YIdfigUXOm+P74XCZI7ffTZ3GoD
 iiPrwuoj3PJ7EA/eRUo428e1r49Z57at4V/oRMCj4mx8sXMZ5dqwKW1y4UX9JpBcPQTn
 yGZBx3j8OGVa70PYqWCzfy5QgeMbWAlPe1RVRl5QYZX4txOClVOZ1hrU1giYGeFPj13Q
 A2cf5RExOIN9xz85FSEeMuvIECtWKBZUd17km6D7WbrQb0THvzW6bUMXch6AFDgBckkq
 FYag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS3pcRe0k8sHg3N58scLFLd19nd4L4QMv8xjnUVaXPtI/nJMjsavFyE+bxOx/Y9tXOOkmo+yOTPPQ8@nongnu.org
X-Gm-Message-State: AOJu0YxXgrjaNXFmU2V5bTFLqTWrDpH5wXPfErH7P0CSm2JeRQ/WHLIt
 jm/CEOuzDDyj0BW2XnhE2XufQVezSijnnTbv3UJFI4LADcFmx4+Tb9NgPfK1+guibkM=
X-Gm-Gg: ASbGncsSgUXcAW67jT2aKznCUeqCTc6kaeSCTlhMB8FUxT3D2WsQrd23qAyVhxpE9wX
 qVWCIW+XaWV2xwVy7yoHrfH9YX5neiqPkXJjdu76/gTvkmdDiCXUK8Z9LqLsgGLLn8/vjhvEBNU
 zY7zWPH6yrz7ApbLXleTWjSsHlHCWO+cHLuYm15jjT0hnDkkl3kYZ89lWXxtWIc/KW6YBGVIMsp
 mNH9Ab8IRopeJVP9xDvHBw/fVyr/yNRVEbctf0rl8NjnuZuO6ThimzZC9UVo7QP+iiGE2xqjg0q
 Eo3lETRkjauEmechVlPhezmevlbG3nxhX6P0OM5BmdjdpgZWNc8ibBWAbx9owQ==
X-Google-Smtp-Source: AGHT+IFAHsl0STSBSI7tCRSzCaV1AYmYh0cUEm13Efq3eDeg3GnS+HsxIkwK87u9K5UwB6edukkAcQ==
X-Received: by 2002:a17:902:cf42:b0:232:2af:8569 with SMTP id
 d9443c01a7336-233f219a498mr26971255ad.18.1747987783514; 
 Fri, 23 May 2025 01:09:43 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e975f3sm119124135ad.117.2025.05.23.01.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 01:09:43 -0700 (PDT)
Message-ID: <f598f776-e852-442c-a7c7-077d74b33503@daynix.com>
Date: Fri, 23 May 2025 17:09:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/16] virtio-net: implement extended features support.
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
 <8fb9f142e25a0f1b01e8cf54a6c2a0971db00d83.1747825544.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8fb9f142e25a0f1b01e8cf54a6c2a0971db00d83.1747825544.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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
> Use the extended types and helpers to manipulate the virtio_net
> features.
> 
> Note that offloads are still 64bits wide, as per specification,
> and extended offloads will be mapped into such range.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   hw/net/virtio-net.c            | 87 +++++++++++++++++++++-------------
>   include/hw/virtio/virtio-net.h |  2 +-
>   2 files changed, 55 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9f500c64e7..193469fc27 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -90,6 +90,17 @@
>                                            VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
>                                            VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)
>   
> +#define VIRTIO_OFFLOAD_MAP_MIN    46
> +#define VIRTIO_OFFLOAD_MAP_LENGTH 4
> +#define VIRTIO_OFFLOAD_MAP        MAKE_64BIT_MASK(VIRTIO_OFFLOAD_MAP_MIN, \
> +                                                VIRTIO_OFFLOAD_MAP_LENGTH)
> +#define VIRTIO_FEATURES_MAP_MIN   65
> +#define VIRTIO_O2F_DELTA          (VIRTIO_FEATURES_MAP_MIN - \
> +                                   VIRTIO_OFFLOAD_MAP_MIN)
> +
> +#define VIRTIO_FEATURE_TO_OFFLOAD(fbit)  (fbit >= 64 ? \
> +                                          fbit - VIRTIO_O2F_DELTA : fbit)
> +

These are specific to virtio-net but look like they are common for 
virtio as the names don't contain "NET".

VIRTIO_FEATURES_MAP_MIN is also a bit confusing. It points to the least 
significant bit that refers to an offloading feature in the upper-half 
of the feature bits, but the name lacks the context.

>   static const VirtIOFeature feature_sizes[] = {
>       {.flags = 1ULL << VIRTIO_NET_F_MAC,
>        .end = endof(struct virtio_net_config, mac)},
> @@ -751,44 +762,45 @@ static void virtio_net_set_queue_pairs(VirtIONet *n)
>   
>   static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
>   
> -static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
> -                                        Error **errp)
> +static virtio_features_t virtio_net_get_features(VirtIODevice *vdev,
> +                                                 virtio_features_t features,
> +                                                 Error **errp)
>   {
>       VirtIONet *n = VIRTIO_NET(vdev);
>       NetClientState *nc = qemu_get_queue(n->nic);
>   
>       /* Firstly sync all virtio-net possible supported features */
> -    features |= n->host_features;
> +    features |= n->host_features_ex;
>   
> -    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
> +    virtio_add_feature_ex(&features, VIRTIO_NET_F_MAC);
>   
>       if (!peer_has_vnet_hdr(n)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_CSUM);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_TSO4);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_TSO6);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_ECN);
>   
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_CSUM);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_TSO4);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_TSO6);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_ECN);
>   
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_USO);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO4);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO6);
>   
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HASH_REPORT);
>       }
>   
>       if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_UFO);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_UFO);
>       }
>   
>       if (!peer_has_uso(n)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_USO);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO4);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO6);
>       }
>   
>       if (!get_vhost_net(nc->peer)) {
> @@ -796,7 +808,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
>       }
>   
>       if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_RSS);
>       }
>       features = vhost_net_get_features(get_vhost_net(nc->peer), features);
>       vdev->backend_features_ex = features;
> @@ -818,7 +830,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
>        * support it.
>        */
>       if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_CTRL_VQ)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
>       }
>   
>       return features;
> @@ -851,9 +863,16 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>               !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)));
>   }
>   
> -static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
> +static uint64_t virtio_net_features_to_offload(virtio_features_t features)
 > +{> +    return (features & ~VIRTIO_OFFLOAD_MAP) |
> +           ((features >> VIRTIO_O2F_DELTA) & VIRTIO_OFFLOAD_MAP);
> +}
> +
> +static uint64_t
> +virtio_net_guest_offloads_by_features(virtio_features_t features)
>   {
> -    static const uint64_t guest_offloads_mask =
> +    static const virtio_features_t guest_offloads_mask =
>           (1ULL << VIRTIO_NET_F_GUEST_CSUM) |
>           (1ULL << VIRTIO_NET_F_GUEST_TSO4) |
>           (1ULL << VIRTIO_NET_F_GUEST_TSO6) |
> @@ -862,13 +881,13 @@ static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
>           (1ULL << VIRTIO_NET_F_GUEST_USO4) |
>           (1ULL << VIRTIO_NET_F_GUEST_USO6);
>   
> -    return guest_offloads_mask & features;
> +    return guest_offloads_mask & virtio_net_features_to_offload(features);


How about:

static const virtio_features_t guest_offload_features_mask = ...
virtio_features_t masked_features = guest_offload_features_mask & features;

return masked_features | ((masked_features >> VIRTIO_FEATURES_MAP_MIN) 
<< VIRTIO_OFFLOAD_MAP_MIN);

This makes virtio_net_features_to_offload() unnecessary.

>   }
>   
>   uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
>   {
>       VirtIODevice *vdev = VIRTIO_DEVICE(n);
> -    return virtio_net_guest_offloads_by_features(vdev->guest_features);
> +    return virtio_net_guest_offloads_by_features(vdev->guest_features_ex);
>   }
>   
>   typedef struct {
> @@ -947,7 +966,8 @@ static void failover_add_primary(VirtIONet *n, Error **errp)
>       error_propagate(errp, err);
>   }
>   
> -static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
> +static void virtio_net_set_features(VirtIODevice *vdev,
> +                                    virtio_features_t features)
>   {
>       VirtIONet *n = VIRTIO_NET(vdev);
>       Error *err = NULL;
> @@ -955,7 +975,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
>   
>       if (n->mtu_bypass_backend &&
>               !virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU)) {
> -        features &= ~(1ULL << VIRTIO_NET_F_MTU);
> +        features &= ~VIRTIO_BIT(VIRTIO_NET_F_MTU);
>       }
>   
>       virtio_net_set_multiqueue(n,
> @@ -1962,10 +1982,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>                   virtio_error(vdev, "virtio-net unexpected empty queue: "
>                                "i %zd mergeable %d offset %zd, size %zd, "
>                                "guest hdr len %zd, host hdr len %zd "
> -                             "guest features 0x%" PRIx64,
> +                             "guest features 0x" VIRTIO_FEATURES_FMT,
>                                i, n->mergeable_rx_bufs, offset, size,
>                                n->guest_hdr_len, n->host_hdr_len,
> -                             vdev->guest_features);
> +                             VIRTIO_FEATURES_HI(vdev->guest_features_ex),
> +                             VIRTIO_FEATURES_LOW(vdev->guest_features_ex));
>               }
>               err = -1;
>               goto err;
> @@ -4146,8 +4167,8 @@ static void virtio_net_class_init(ObjectClass *klass, const void *data)
>       vdc->unrealize = virtio_net_device_unrealize;
>       vdc->get_config = virtio_net_get_config;
>       vdc->set_config = virtio_net_set_config;
> -    vdc->get_features = virtio_net_get_features;
> -    vdc->set_features = virtio_net_set_features;
> +    vdc->get_features_ex = virtio_net_get_features;
> +    vdc->set_features_ex = virtio_net_set_features;
>       vdc->bad_features = virtio_net_bad_features;
>       vdc->reset = virtio_net_reset;
>       vdc->queue_reset = virtio_net_queue_reset;
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index b9ea9e824e..5ccdbeb253 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -178,7 +178,7 @@ struct VirtIONet {
>       uint32_t has_vnet_hdr;
>       size_t host_hdr_len;
>       size_t guest_hdr_len;
> -    uint64_t host_features;
> +    DECLARE_FEATURES(host_features);
>       uint32_t rsc_timeout;
>       uint8_t rsc4_enabled;
>       uint8_t rsc6_enabled;


