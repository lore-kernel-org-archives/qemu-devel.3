Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCAAC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 04:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue4jb-0001fw-Sr; Tue, 22 Jul 2025 00:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ue4Pf-00059o-9D
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:15:35 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ue4PZ-0006aV-6q
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:15:34 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56M4F42X014293
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 22 Jul 2025 13:15:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=QECXGxkjREu4c5L8Ye+cy1cRm/QqXyaiUBzQ6sLE15g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753157704; v=1;
 b=YmS/8S7cv7WHouiDTfXoR3JlkNX9yjCLEGPabmLnotIbDtX5b4HR2EbjiRwOSU5o
 I+WEnzcU0DmXpULtR1ZISJ1cI/vQz6/aPqbaKiXs7NTMyC8z8rVIKH5a78zyjz95
 wsuYcZ0rjQMOUD9Hy2N0g9bXT/2jaHKPAu/OcfsSdF29W6K9Ub6UC1SIZoTVZVvx
 7iZUXbVQfflJD2RoKNCX53iXapIPnd7PNdHQdo73AjbalXB+fd4ZIRY5jzp1Gxxw
 wDR46gE8QrXZxrDpJ+PVGiA/IbTlNF8vtp4NdPJcmTiZeKYuyqQyxiv2nC3vn9sE
 0MHCMtlvV+K/4fej5C8FHg==
Message-ID: <a4d95ebc-6076-4140-b412-281eb49cf756@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 22 Jul 2025 13:15:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 12/13] net: implement tunnel probing
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <6ec36a1cc2497f827b9e024acc6adb2515dd9335.1752828082.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <6ec36a1cc2497f827b9e024acc6adb2515dd9335.1752828082.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/07/18 17:52, Paolo Abeni wrote:
> Tap devices support GSO over UDP tunnel offload. Probe for such
> feature in a similar manner to other offloads.
> 
> GSO over UDP tunnel needs to be enabled in addition to a "plain"
> offload (TSO or USO).
> 
> No need to check separately for the outer header checksum offload:
> the kernel is going to support both of them or none.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>    - use bool type for tap_probe_has_tunnel()
>    - rebased on top of 2deec9ab7d ("virtio-net: Move
>          virtio_net_get_features() down")
>    - _array -> _ex
> 
> v1 -> v2:
>    - peer_has_tunnel return a bool
>    - move TUN_F definition in net/tun-linux.h
> ---
>   hw/net/virtio-net.c | 37 +++++++++++++++++++++++++++++++++++++
>   include/net/net.h   |  3 +++
>   net/net.c           |  9 +++++++++
>   net/tap-bsd.c       |  5 +++++
>   net/tap-linux.c     | 11 +++++++++++
>   net/tap-linux.h     |  9 +++++++++
>   net/tap-solaris.c   |  5 +++++
>   net/tap-stub.c      |  5 +++++
>   net/tap.c           | 11 +++++++++++
>   net/tap_int.h       |  1 +
>   10 files changed, 96 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 53413ec4d5..70c85f7f77 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -649,6 +649,15 @@ static int peer_has_uso(VirtIONet *n)
>       return qemu_has_uso(qemu_get_queue(n->nic)->peer);
>   }
>   
> +static bool peer_has_tunnel(VirtIONet *n)
> +{
> +    if (!peer_has_vnet_hdr(n)) {
> +        return false;
> +    }
> +
> +    return qemu_has_tunnel(qemu_get_queue(n->nic)->peer);
> +}
> +
>   static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>                                          int version_1, int hash_report)
>   {
> @@ -3070,6 +3079,13 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>           virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
>           virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
>   
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> +
>           virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
>       }
>   
> @@ -3083,6 +3099,15 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>           virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
>       }
>   
> +    if (!peer_has_tunnel(n)) {
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> +    }
> +
>       if (!get_vhost_net(nc->peer)) {
>           if (!use_own_hash) {
>               virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> @@ -4137,6 +4162,10 @@ static const VMStateDescription vmstate_virtio_net = {
>       .dev_unplug_pending = dev_unplug_pending,
>   };
>   
> +#define DEFINE_PROP_FEATURE(_name, _state, _field, _bit, _defval)   \
> +    DEFINE_PROP_BIT64(_name, _state, _field[VIRTIO_DWORD(_bit)],    \
> +                      (_bit) % 64, _defval)

I suggest moving this to: include/hw/virtio/virtio-features.h

> +
>   static const Property virtio_net_properties[] = {
>       DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
>                       VIRTIO_NET_F_CSUM, true),
> @@ -4245,6 +4274,14 @@ static const Property virtio_net_properties[] = {
>                                     rss_data.specified_hash_types,
>                                     VIRTIO_NET_HASH_REPORT_UDPv6_EX - 1,
>                                     ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_FEATURE("host_tunnel", VirtIONet, host_features_ex,
> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, true),
> +    DEFINE_PROP_FEATURE("host_tunnel_csum", VirtIONet, host_features_ex,
> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, true),
> +    DEFINE_PROP_FEATURE("guest_tunnel", VirtIONet, host_features_ex,
> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, true),
> +    DEFINE_PROP_FEATURE("guest_tunnel_csum", VirtIONet, host_features_ex,
> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, true),
>   };
>   
>   static void virtio_net_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/net/net.h b/include/net/net.h
> index 48ba333d02..9a9084690d 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -65,6 +65,7 @@ typedef void (NetClientDestructor)(NetClientState *);
>   typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
>   typedef bool (HasUfo)(NetClientState *);
>   typedef bool (HasUso)(NetClientState *);
> +typedef bool (HasTunnel)(NetClientState *);
>   typedef bool (HasVnetHdr)(NetClientState *);
>   typedef bool (HasVnetHdrLen)(NetClientState *, int);
>   typedef void (SetOffload)(NetClientState *, const NetOffloads *);
> @@ -95,6 +96,7 @@ typedef struct NetClientInfo {
>       NetPoll *poll;
>       HasUfo *has_ufo;
>       HasUso *has_uso;
> +    HasTunnel *has_tunnel;
>       HasVnetHdr *has_vnet_hdr;
>       HasVnetHdrLen *has_vnet_hdr_len;
>       SetOffload *set_offload;
> @@ -197,6 +199,7 @@ void qemu_set_info_str(NetClientState *nc,
>   void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
>   bool qemu_has_ufo(NetClientState *nc);
>   bool qemu_has_uso(NetClientState *nc);
> +bool qemu_has_tunnel(NetClientState *nc);
>   bool qemu_has_vnet_hdr(NetClientState *nc);
>   bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
>   void qemu_set_offload(NetClientState *nc, const NetOffloads *ol);
> diff --git a/net/net.c b/net/net.c
> index 63872b6855..9536184a0c 100644
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
> index 86b6edee94..751d4c819c 100644
> --- a/net/tap-bsd.c
> +++ b/net/tap-bsd.c
> @@ -217,6 +217,11 @@ int tap_probe_has_uso(int fd)
>       return 0;
>   }
>   
> +bool tap_probe_has_tunnel(int fd)
> +{
> +    return false;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>   }
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index a1c58f74f5..e2628be798 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -196,6 +196,17 @@ int tap_probe_has_uso(int fd)
>       return 1;
>   }
>   
> +bool tap_probe_has_tunnel(int fd)
> +{
> +    unsigned offload;
> +
> +    offload = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_UDP_TUNNEL_GSO;
> +    if (ioctl(fd, TUNSETOFFLOAD, offload) < 0) {
> +        return false;
> +    }
> +    return true;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>       if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
> diff --git a/net/tap-linux.h b/net/tap-linux.h
> index 9a58cecb7f..8cd6b5874b 100644
> --- a/net/tap-linux.h
> +++ b/net/tap-linux.h
> @@ -53,4 +53,13 @@
>   #define TUN_F_USO4    0x20    /* I can handle USO for IPv4 packets */
>   #define TUN_F_USO6    0x40    /* I can handle USO for IPv6 packets */
>   
> +/* I can handle TSO/USO for UDP tunneled packets */
> +#define TUN_F_UDP_TUNNEL_GSO       0x080
> +
> +/*
> + * I can handle TSO/USO for UDP tunneled packets requiring csum offload for
> + * the outer header
> + */
> +#define TUN_F_UDP_TUNNEL_GSO_CSUM  0x100
> +
>   #endif /* QEMU_TAP_LINUX_H */
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index 833c066bee..ac1ae25761 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -222,6 +222,11 @@ int tap_probe_has_uso(int fd)
>       return 0;
>   }
>   
> +bool tap_probe_has_tunnel(int fd)
> +{
> +    return false;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>   }
> diff --git a/net/tap-stub.c b/net/tap-stub.c
> index 67d14ad4d5..f7a5e0c163 100644
> --- a/net/tap-stub.c
> +++ b/net/tap-stub.c
> @@ -52,6 +52,11 @@ int tap_probe_has_uso(int fd)
>       return 0;
>   }
>   
> +bool tap_probe_has_tunnel(int fd)
> +{
> +    return false;
> +}
> +
>   void tap_fd_set_vnet_hdr_len(int fd, int len)
>   {
>   }
> diff --git a/net/tap.c b/net/tap.c
> index b49db19f83..23c6c118e7 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -76,6 +76,7 @@ typedef struct TAPState {
>       bool using_vnet_hdr;
>       bool has_ufo;
>       bool has_uso;
> +    bool has_tunnel;
>       bool enabled;
>       VHostNetState *vhost_net;
>       unsigned host_vnet_hdr_len;
> @@ -241,6 +242,14 @@ static bool tap_has_uso(NetClientState *nc)
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
> @@ -369,6 +378,7 @@ static NetClientInfo net_tap_info = {
>       .cleanup = tap_cleanup,
>       .has_ufo = tap_has_ufo,
>       .has_uso = tap_has_uso,
> +    .has_tunnel = tap_has_tunnel,
>       .has_vnet_hdr = tap_has_vnet_hdr,
>       .has_vnet_hdr_len = tap_has_vnet_hdr_len,
>       .set_offload = tap_set_offload,
> @@ -398,6 +408,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>       s->using_vnet_hdr = false;
>       s->has_ufo = tap_probe_has_ufo(s->fd);
>       s->has_uso = tap_probe_has_uso(s->fd);
> +    s->has_tunnel = tap_probe_has_tunnel(s->fd);
>       s->enabled = true;
>       tap_set_offload(&s->nc, &ol);
>       /*
> diff --git a/net/tap_int.h b/net/tap_int.h
> index f8bbe1cb0c..b76a05044b 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -38,6 +38,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
>   int tap_probe_vnet_hdr(int fd, Error **errp);
>   int tap_probe_has_ufo(int fd);
>   int tap_probe_has_uso(int fd);
> +bool tap_probe_has_tunnel(int fd);
>   void tap_fd_set_offload(int fd, const NetOffloads *ol);
>   void tap_fd_set_vnet_hdr_len(int fd, int len);
>   int tap_fd_set_vnet_le(int fd, int vnet_is_le);


