Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C03C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 07:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIN0S-0004Np-6b; Fri, 23 May 2025 03:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIN0Q-0004Nc-AM
 for qemu-devel@nongnu.org; Fri, 23 May 2025 03:39:50 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIN0L-0007DF-Ng
 for qemu-devel@nongnu.org; Fri, 23 May 2025 03:39:49 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-30ea7770bd2so7552803a91.0
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 00:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747985983; x=1748590783;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JKHWWO7aapi477O7hMShj6fG37GeMNoGCu0jSffQBFk=;
 b=RU+sl+5slV4Xq57Me6nnKHnNiS6lU/CLa33R/25Vmf/32mGQnLtZmJQfk7EyDwcVkB
 XJqWTRl6i9COu+uIXMndoXf4+1H6Kux7SLU2RcLL8us1ETYPswgvnr2hetJoZ6LdNNRk
 X2zvDmiwOMjZFOYwPHaomThuNLuQleNWFG6WYAoWxzIWA7MvzEYAKjpnTXqdo89YLSYr
 o/HKk687djLkc8FrqxjrjaqewzbNr6vRssQ3aHw8N8aayAC+t3ytgTXIiMcLElZqVNWr
 UCCvL1HUrI6STJhFgppWWAyB5pf1b01ofTqj9ZE1c0qW8JtLeK4owr+0hpwvCNj0f3Tk
 iWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747985983; x=1748590783;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JKHWWO7aapi477O7hMShj6fG37GeMNoGCu0jSffQBFk=;
 b=OSQhRRiMaa+nTGgS/a/HP9wYdwVNlOw6pfGw6DDYMC6RunkQNCI8OmbZUTRRWLTHwx
 dzTTT2Ww1/Zh1eMWwpPNWdPaux8B/VeIQ73UWLu+tC+dU4jb2HQ/jJ0jCABLQrOy5fGA
 e2t0sQyobgF6JVjchVCWRpOdc6MmX8LaxLIcGkI1McyNqK+qzORIP4QX2LZpFpUMNOxm
 EL4bbIakZ+RA4Pxt+lRQiDSwkWbtbzaEpGWbOq2ln5Lx9DBTWcraGY+apLnFkCwiDHhM
 aG04smquwzODXgq3HsAWZQmk56PvZOWW9VEGp2CfEFLJ5nGvVxzxxssuPPwr+Sc2yRp6
 0zMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvNxIzZX2y2zRSBcEuBWmKgsaKdHlS23VPNIPvGJPdM64bq01/nQgejACksKiyVzxVJqaJz+T/egIF@nongnu.org
X-Gm-Message-State: AOJu0Yxr7YoPmoPfinnPDV8L+zLX5vyRXOqUArnYAw/s34LmJHbZgyC3
 QstWMMR8slEG5XZNYykzhDoPSM2Equt0asDVdmGcxkmVxu3Auxye/1pS4il7wme1wwU=
X-Gm-Gg: ASbGnctPCRNCxRFhhQrHek7mC/n+eAFfEtvntJ94KM2q6jN1bhVJB98dOxIxH6tMKby
 L+s2/yejJC+REicGzPkvxO+LY2CIP9sOrfTxKhcZah6uPPsSXmyF92mOz/rQLVjiVkPdFbBF9dk
 n0EWTDu0XWm0dH79VTlKnUDNd2N3ka1C+yb02a++YLGSkOSenaVlI/RyrJuL+D2fn8jkXHznE64
 j+RATHulqxbIwaUWEz5KX/GidiU+2oZGuHMrZYa1MWZsHKKu0hG/LPFr/xx8UvMyRNTfu2wGTaS
 ZHfPGWmpUksQkxsZJWWfhFFFoyy9Sf+lVzzGQD6GbXnYpfqx/5p2ZEIwOfJLjA==
X-Google-Smtp-Source: AGHT+IEFup+z6pnPso8Ew6poVz9B2y3hnBNQvrZnfaPoBV57ues1I8i/p7RG/xnd9h4pNV6Xsy83Pw==
X-Received: by 2002:a17:90b:3b46:b0:30a:204e:3271 with SMTP id
 98e67ed59e1d1-30e7d5564e7mr49323526a91.17.1747985983421; 
 Fri, 23 May 2025 00:39:43 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f365c4f9csm6700451a91.20.2025.05.23.00.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 00:39:43 -0700 (PDT)
Message-ID: <6c48edb8-082c-4474-8815-36ab4c64a228@daynix.com>
Date: Fri, 23 May 2025 16:39:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/16] net: implement tunnel probing
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
 <b0e5839ab3e723247b12ddecf36c75c51c5a0b83.1747825544.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <b0e5839ab3e723247b12ddecf36c75c51c5a0b83.1747825544.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
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
> Tap devices support GSO over UDP tunnel offload. Probe for such
> feature in a similar manner to other offloads.
> 
> GSO over UDP tunnel needs to be enabled in addition to  a "plain"
> offload (TSO or USO).
> 
> No need to check separately for the outer header checksum offload:
> the kernel is going to support both of them or none.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   hw/net/virtio-net.c | 39 +++++++++++++++++++++++++++++++++++++++
>   include/net/net.h   |  3 +++
>   net/net.c           |  9 +++++++++
>   net/tap-bsd.c       |  5 +++++
>   net/tap-linux.c     | 19 +++++++++++++++++++
>   net/tap-solaris.c   |  5 +++++
>   net/tap-stub.c      |  5 +++++
>   net/tap.c           | 11 +++++++++++
>   net/tap_int.h       |  1 +
>   9 files changed, 97 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 193469fc27..05cf23700f 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -646,6 +646,15 @@ static int peer_has_uso(VirtIONet *n)
>       return qemu_has_uso(qemu_get_queue(n->nic)->peer);
>   }
>   
> +static int peer_has_tunnel(VirtIONet *n)

Let's make this return a bool. Preceding functions like 
peer_has_vnet_hdr() returns int, but I think it's better to follow the 
convention more common across the codebase.

> +{
> +    if (!peer_has_vnet_hdr(n)) {
> +        return 0;
> +    }
> +
> +    return qemu_has_tunnel(qemu_get_queue(n->nic)->peer);
> +}
> +
>   static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>                                          int version_1, int hash_report)
>   {
> @@ -789,6 +798,15 @@ static virtio_features_t virtio_net_get_features(VirtIODevice *vdev,
>           virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO4);
>           virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO6);
>   
> +#ifdef CONFIG_INT128
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(&features,
> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> +        virtio_clear_feature_ex(&features,
> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> +#endif
> +
>           virtio_clear_feature_ex(&features, VIRTIO_NET_F_HASH_REPORT);
>       }
>   
> @@ -803,6 +821,17 @@ static virtio_features_t virtio_net_get_features(VirtIODevice *vdev,
>           virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_USO6);
>       }
>   
> +#ifdef CONFIG_INT128
> +    if (!peer_has_tunnel(n)) {
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(&features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(&features,
> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> +        virtio_clear_feature_ex(&features,
> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> +    }
> +#endif
> +
>       if (!get_vhost_net(nc->peer)) {
>           return features;
>       }
> @@ -4153,6 +4182,16 @@ static const Property virtio_net_properties[] = {
>                         VIRTIO_NET_F_GUEST_USO6, true),
>       DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                         VIRTIO_NET_F_HOST_USO, true),
> +#ifdef CONFIG_INT128
> +    DEFINE_PROP_BITVF("host_tunnel", VirtIONet, host_features_ex,
> +                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, true),
> +    DEFINE_PROP_BITVF("host_tunnel_csum", VirtIONet, host_features_ex,
> +                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, true),
> +    DEFINE_PROP_BITVF("guest_tunnel", VirtIONet, host_features_ex,
> +                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, true),
> +    DEFINE_PROP_BITVF("guest_tunnel_csum", VirtIONet, host_features_ex,
> +                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, true),
> +#endif
>   };
>   
>   static void virtio_net_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/net/net.h b/include/net/net.h
> index cdd5b109b0..391d983e49 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -55,6 +55,7 @@ typedef void (NetClientDestructor)(NetClientState *);
>   typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
>   typedef bool (HasUfo)(NetClientState *);
>   typedef bool (HasUso)(NetClientState *);
> +typedef bool (HasTunnel)(NetClientState *);
>   typedef bool (HasVnetHdr)(NetClientState *);
>   typedef bool (HasVnetHdrLen)(NetClientState *, int);
>   typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
> @@ -83,6 +84,7 @@ typedef struct NetClientInfo {
>       NetPoll *poll;
>       HasUfo *has_ufo;
>       HasUso *has_uso;
> +    HasTunnel *has_tunnel;
>       HasVnetHdr *has_vnet_hdr;
>       HasVnetHdrLen *has_vnet_hdr_len;
>       SetOffload *set_offload;
> @@ -183,6 +185,7 @@ void qemu_set_info_str(NetClientState *nc,
>   void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
>   bool qemu_has_ufo(NetClientState *nc);
>   bool qemu_has_uso(NetClientState *nc);
> +bool qemu_has_tunnel(NetClientState *nc);
>   bool qemu_has_vnet_hdr(NetClientState *nc);
>   bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
>   void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
> diff --git a/net/net.c b/net/net.c
> index 39d6f28158..9c83d3b137 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -522,6 +522,15 @@ bool qemu_has_uso(NetClientState *nc)
>       return nc->info->has_uso(nc);
>   }
>   
> +bool qemu_has_tunnel(NetClientState *nc)
> +{
> +    if (!nc || !nc->info->has_tunnel) {
> +        return false;
> +    }
> +
> +    return nc->info->has_tunnel(nc);
> +}
> +
>   bool qemu_has_vnet_hdr(NetClientState *nc)
>   {
>       if (!nc || !nc->info->has_vnet_hdr) {
> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> index b4c84441ba..3f01c8921e 100644
> --- a/net/tap-bsd.c
> +++ b/net/tap-bsd.c
> @@ -217,6 +217,11 @@ int tap_probe_has_uso(int fd)
>       return 0;
>   }
>   
> +int tap_probe_has_tunnel(int fd)
> +{
> +    return 0;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>   }
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index 22ec2f45d2..2df601551e 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -37,6 +37,14 @@
>   
>   #define PATH_NET_TUN "/dev/net/tun"
>   
> +#ifndef TUN_F_UDP_TUNNEL_GSO
> +#define TUN_F_UDP_TUNNEL_GSO       0x080
> +#endif
> +
> +#ifndef TUN_F_UDP_TUNNEL_GSO_CSUM
> +#define TUN_F_UDP_TUNNEL_GSO_CSUM  0x100
> +#endif
> +

These should be added to net/tap-linux.h, which contains other UAPI 
definitions.

But perhaps it may be better to refactor it to add the real header file 
using scripts/update-linux-headers.sh. Such a refactoring can be done 
before this series gets ready to merge and will make this series a bit 
smaller.

>   int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
>                int vnet_hdr_required, int mq_required, Error **errp)
>   {
> @@ -196,6 +204,17 @@ int tap_probe_has_uso(int fd)
>       return 1;
>   }
>   
> +int tap_probe_has_tunnel(int fd)
> +{
> +    unsigned offload;
> +
> +    offload = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_UDP_TUNNEL_GSO;
> +    if (ioctl(fd, TUNSETOFFLOAD, offload) < 0) {
> +        return 0;
> +    }
> +    return 1;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>       if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index 51b7830bef..b1aa40d46b 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -221,6 +221,11 @@ int tap_probe_has_uso(int fd)
>       return 0;
>   }
>   
> +int tap_probe_has_tunnel(int fd)
> +{
> +    return 0;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>   }
> diff --git a/net/tap-stub.c b/net/tap-stub.c
> index 38673434cb..5f57d6baac 100644
> --- a/net/tap-stub.c
> +++ b/net/tap-stub.c
> @@ -52,6 +52,11 @@ int tap_probe_has_uso(int fd)
>       return 0;
>   }
>   
> +int tap_probe_has_tunnel(int fd)
> +{
> +    return 0;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>   }
> diff --git a/net/tap.c b/net/tap.c
> index ae1c7e3983..f6e8cd5f1c 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -58,6 +58,7 @@ typedef struct TAPState {
>       bool using_vnet_hdr;
>       bool has_ufo;
>       bool has_uso;
> +    bool has_tunnel;
>       bool enabled;
>       VHostNetState *vhost_net;
>       unsigned host_vnet_hdr_len;
> @@ -223,6 +224,14 @@ static bool tap_has_uso(NetClientState *nc)
>       return s->has_uso;
>   }
>   
> +static bool tap_has_tunnel(NetClientState *nc)
> +{
> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> +
> +    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
> +    return s->has_tunnel;
> +}
> +
>   static bool tap_has_vnet_hdr(NetClientState *nc)
>   {
>       TAPState *s = DO_UPCAST(TAPState, nc, nc);
> @@ -340,6 +349,7 @@ static NetClientInfo net_tap_info = {
>       .cleanup = tap_cleanup,
>       .has_ufo = tap_has_ufo,
>       .has_uso = tap_has_uso,
> +    .has_tunnel = tap_has_tunnel,
>       .has_vnet_hdr = tap_has_vnet_hdr,
>       .has_vnet_hdr_len = tap_has_vnet_hdr_len,
>       .set_offload = tap_set_offload,
> @@ -367,6 +377,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>       s->using_vnet_hdr = false;
>       s->has_ufo = tap_probe_has_ufo(s->fd);
>       s->has_uso = tap_probe_has_uso(s->fd);
> +    s->has_tunnel = tap_probe_has_tunnel(s->fd);
>       s->enabled = true;
>       tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
>       /*
> diff --git a/net/tap_int.h b/net/tap_int.h
> index 8857ff299d..2a8aa3632f 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -37,6 +37,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
>   int tap_probe_vnet_hdr(int fd, Error **errp);
>   int tap_probe_has_ufo(int fd);
>   int tap_probe_has_uso(int fd);
> +int tap_probe_has_tunnel(int fd);
>   void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
>                           int uso4, int uso6);
>   void tap_fd_set_vnet_hdr_len(int fd, int len);


