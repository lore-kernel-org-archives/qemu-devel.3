Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEF3C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 07:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIN6c-0005d9-Ox; Fri, 23 May 2025 03:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIN6W-0005cZ-K8
 for qemu-devel@nongnu.org; Fri, 23 May 2025 03:46:13 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIN6T-0008AJ-Pq
 for qemu-devel@nongnu.org; Fri, 23 May 2025 03:46:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so4987992b3a.3
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747986361; x=1748591161;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nugH1eybCEgTWVqTqZ7tW0cL+VVJMXaX0Db1RBQpPYE=;
 b=oOxoaM7bbE+f/Hi3FWTk/Buyj6PmcuQyFtep127cqaE1xDIgKk3QBlU3ac3roBVT+V
 JorBXRphwf6I2h5slkz+KzJb77AnxFbUyPYCZBENed7VGOOR3WIwgkOylYk05ZFaHMqX
 stZyqc3MXPQhc9v3Cf8fM+xv8fgqjCmDZX6TioNki1zbltmDFtPAdWv0zEmZvTqG/wgH
 rS5NjQPWCRmOTJJZPzDLVSi5qLmfeOky8iJDBgo2h71oCaVvcQsGXCkw3ZSMMZY+w7um
 YCJ0AG4wYJ9mHwS8naIl9nWOI7EZrQTnTiVmNssli2/V+86ujzn6f4YYwzUHFc6zMMNh
 txCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747986361; x=1748591161;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nugH1eybCEgTWVqTqZ7tW0cL+VVJMXaX0Db1RBQpPYE=;
 b=NHyv/WEKasKMRCZLyQ4dUf5+2ypyhFqIVhcpmU2mabPy2nkmnBtplfKj6Tt5rpBrSR
 Y5UvmUCudbuE9vMra1hzFQRJkI6TOn4vXDHTu8frKkLPHvkvt4fzkE0ULSun9k+ZIECB
 Ek0S78FW366NMj9cusEY3t8NhSbc7iEyFAKVihS2deDzR77AMuAwh1X6/sqYHKGegh/Q
 h0ctIWwrctPjkacwk7TulnuVa6LBHDxLLYtgr+Ev18k+77/XJpmJKd2zrstMCW2+RKnG
 zQjOQBzc4PBAcQTx3s124AhqVLCQ6LH4HtBHXRyEWCtqQEgyZ2HAjAJGEVvub61kQtZD
 Kc9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIpoYw5ewy0O5ir0wZJCjFV3jGXkFrSWAfyISwxmWlnMMhAISAyC0dUo90ebPWPvStht275drqyIzD@nongnu.org
X-Gm-Message-State: AOJu0YyJMKJjRt8PTuRxZdcCx8xkoLUSsBNr7AqyoU4bRahrlYWthT1z
 lo9KQKznoHjJL4H8PFP2woPsKOahuCPrZXv8UWjv+4GC2gNB3NDJU4MYolc4V3K14vU=
X-Gm-Gg: ASbGncsX4bqNuE5GnQOXsLGVGH1fDdF5ru6FfkeYWjiY4cbxt2sRzFRD/A5CpCNuo48
 ZDqiis3QL5bJHaekAQhk8CwL6f9OjfiJFSuZ8W/eW9aYY1JVArzvGJCadSUMEerWIEKe7eph7c0
 uoLv9EmxZut0LwZssHiUOUGhrHLeZ+P+1Dam+rIGZ55YRxYxCF5nNMjVEz+AlWmuzLB/GkDFauL
 D4gi6utwC4Yejld5Ef2j0wrjeOiMczSRaNkO5rOQLThRtJfGY6N7ybrbbz+Bzfu0kk2pByBeAq+
 47vdbtIz2AGr6zjA/+ZM62qKg06G/UESaD9jIjudM//8N+WvGpL0DmNbY6rd9JmFou7SrRtE
X-Google-Smtp-Source: AGHT+IEEx+Trt04eXOxfCsARma+1K+bMpREeyfEhdS8jaPj3jmxtj6uDqRVEcSmQyHMUYpIrPkr3TA==
X-Received: by 2002:a05:6a00:6f27:b0:740:6630:633f with SMTP id
 d2e1a72fcca58-742accc555bmr40448922b3a.8.1747986360567; 
 Fri, 23 May 2025 00:46:00 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a987150bsm12665281b3a.136.2025.05.23.00.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 00:46:00 -0700 (PDT)
Message-ID: <4ac72409-0b3e-4827-8685-955c2af4ba87@daynix.com>
Date: Fri, 23 May 2025 16:45:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 14/16] net: bundle all offloads in a single struct
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
 <828ccacae4b84313327242cd716f46f711d5849b.1747825544.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <828ccacae4b84313327242cd716f46f711d5849b.1747825544.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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
> The set_offload() argument list is already pretty long and
> we are going to introduce soon a bunch of additional offloads.

I sugguest posting this patch separately so that it can be merged 
ealier. This series can refer to it using Based-on: tag, which is 
explained with: docs/devel/submitting-a-patch.rst

> 
> Replace the offload arguments with a single struct and update
> all the relevant call-sites.
> 
> No functional changes intended.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   hw/net/e1000e_core.c |  5 +++--
>   hw/net/igb_core.c    |  5 +++--
>   hw/net/virtio-net.c  | 19 +++++++++++--------
>   hw/net/vmxnet3.c     | 13 +++++--------
>   include/net/net.h    | 15 ++++++++++++---
>   net/net.c            |  5 ++---
>   net/netmap.c         |  3 +--
>   net/tap-bsd.c        |  3 +--
>   net/tap-linux.c      | 21 ++++++++++++---------
>   net/tap-solaris.c    |  4 ++--
>   net/tap-stub.c       |  3 +--
>   net/tap.c            |  8 ++++----
>   net/tap_int.h        |  4 ++--
>   13 files changed, 59 insertions(+), 49 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 2413858790..ec90869e56 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2827,8 +2827,9 @@ e1000e_update_rx_offloads(E1000ECore *core)
>       trace_e1000e_rx_set_cso(cso_state);
>   
>       if (core->has_vnet) {
> -        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
> -                         cso_state, 0, 0, 0, 0, 0, 0);
> +        struct NetOffloads ol = {.csum = cso_state };

Please omit "struct".

> +
> +        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer, &ol);
>       }
>   }
>   
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 39e3ce1c8f..e940d3a8e2 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -3058,8 +3058,9 @@ igb_update_rx_offloads(IGBCore *core)
>       trace_e1000e_rx_set_cso(cso_state);
>   
>       if (core->has_vnet) {
> -        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
> -                         cso_state, 0, 0, 0, 0, 0, 0);
> +        struct NetOffloads ol = {.csum = cso_state };
> +
> +        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer, &ol);
>       }
>   }
>   
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 05cf23700f..881877086e 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -882,14 +882,17 @@ static uint64_t virtio_net_bad_features(VirtIODevice *vdev)
>   
>   static void virtio_net_apply_guest_offloads(VirtIONet *n)
>   {
> -    qemu_set_offload(qemu_get_queue(n->nic)->peer,
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_CSUM)),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO4)),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO6)),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_ECN)),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)));
> +    NetOffloads ol = {
> +       .csum = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_CSUM)),
> +       .tso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO4)),
> +       .tso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO6)),
> +       .ecn  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_ECN)),
> +       .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
> +       .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
> +       .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
> +    };
> +
> +    qemu_set_offload(qemu_get_queue(n->nic)->peer, &ol);
>   }
>   
>   static uint64_t virtio_net_features_to_offload(virtio_features_t features)
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 83d942af17..dbacb4aa18 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -1334,14 +1334,11 @@ static void vmxnet3_update_features(VMXNET3State *s)
>                 s->lro_supported, rxcso_supported,
>                 s->rx_vlan_stripping);
>       if (s->peer_has_vhdr) {
> -        qemu_set_offload(qemu_get_queue(s->nic)->peer,
> -                         rxcso_supported,
> -                         s->lro_supported,
> -                         s->lro_supported,
> -                         0,
> -                         0,
> -                         0,
> -                         0);
> +        struct NetOffloads ol = { .csum = rxcso_supported,
> +                                  .tso4 = s->lro_supported,
> +                                  .tso6 = s->lro_supported };
> +
> +        qemu_set_offload(qemu_get_queue(s->nic)->peer, &ol);
>       }
>   }
>   
> diff --git a/include/net/net.h b/include/net/net.h
> index 391d983e49..c71d7c6074 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -35,6 +35,16 @@ typedef struct NICConf {
>       int32_t bootindex;
>   } NICConf;
>   
> +typedef struct NetOffloads {
> +    bool csum;
> +    bool tso4;
> +    bool tso6;
> +    bool ecn;
> +    bool ufo;
> +    bool uso4;
> +    bool uso6;
> +} NetOffloads;
> +
>   #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
>       DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                \
>       DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)
> @@ -58,7 +68,7 @@ typedef bool (HasUso)(NetClientState *);
>   typedef bool (HasTunnel)(NetClientState *);
>   typedef bool (HasVnetHdr)(NetClientState *);
>   typedef bool (HasVnetHdrLen)(NetClientState *, int);
> -typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
> +typedef void (SetOffload)(NetClientState *, const NetOffloads *);
>   typedef int (GetVnetHdrLen)(NetClientState *);
>   typedef void (SetVnetHdrLen)(NetClientState *, int);
>   typedef int (SetVnetLE)(NetClientState *, bool);
> @@ -188,8 +198,7 @@ bool qemu_has_uso(NetClientState *nc);
>   bool qemu_has_tunnel(NetClientState *nc);
>   bool qemu_has_vnet_hdr(NetClientState *nc);
>   bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
> -void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
> -                      int ecn, int ufo, int uso4, int uso6);
> +void qemu_set_offload(NetClientState *nc, const NetOffloads *ol);
>   int qemu_get_vnet_hdr_len(NetClientState *nc);
>   void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
>   int qemu_set_vnet_le(NetClientState *nc, bool is_le);
> diff --git a/net/net.c b/net/net.c
> index 9c83d3b137..5a2f00c108 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -549,14 +549,13 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int len)
>       return nc->info->has_vnet_hdr_len(nc, len);
>   }
>   
> -void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
> -                          int ecn, int ufo, int uso4, int uso6)
> +void qemu_set_offload(NetClientState *nc, const NetOffloads *ol)
>   {
>       if (!nc || !nc->info->set_offload) {
>           return;
>       }
>   
> -    nc->info->set_offload(nc, csum, tso4, tso6, ecn, ufo, uso4, uso6);
> +    nc->info->set_offload(nc, ol);
>   }
>   
>   int qemu_get_vnet_hdr_len(NetClientState *nc)
> diff --git a/net/netmap.c b/net/netmap.c
> index 297510e190..6cd8f2bdc5 100644
> --- a/net/netmap.c
> +++ b/net/netmap.c
> @@ -366,8 +366,7 @@ static void netmap_set_vnet_hdr_len(NetClientState *nc, int len)
>       }
>   }
>   
> -static void netmap_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
> -                               int ecn, int ufo, int uso4, int uso6)
> +static void netmap_set_offload(NetClientState *nc, const NetOffloads *ol)
>   {
>       NetmapState *s = DO_UPCAST(NetmapState, nc, nc);
>   
> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> index 3f01c8921e..e7de0672f4 100644
> --- a/net/tap-bsd.c
> +++ b/net/tap-bsd.c
> @@ -236,8 +236,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>       return -EINVAL;
>   }
>   
> -void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo, int uso4, int uso6)
> +void tap_fd_set_offload(int fd, const NetOffloads *ol)
>   {
>   }
>   
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index 2df601551e..aa5f3a6e22 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -258,8 +258,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>       abort();
>   }
>   
> -void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo, int uso4, int uso6)
> +void tap_fd_set_offload(int fd, const NetOffloads *ol)
>   {
>       unsigned int offload = 0;
>   
> @@ -268,20 +267,24 @@ void tap_fd_set_offload(int fd, int csum, int tso4,
>           return;
>       }
>   
> -    if (csum) {
> +    if (ol->csum) {
>           offload |= TUN_F_CSUM;
> -        if (tso4)
> +        if (ol->tso4) {
>               offload |= TUN_F_TSO4;
> -        if (tso6)
> +        }
> +        if (ol->tso6) {
>               offload |= TUN_F_TSO6;
> -        if ((tso4 || tso6) && ecn)
> +        }
> +        if ((ol->tso4 || ol->tso6) && ol->ecn) {
>               offload |= TUN_F_TSO_ECN;
> -        if (ufo)
> +        }
> +        if (ol->ufo) {
>               offload |= TUN_F_UFO;
> -        if (uso4) {
> +        }
> +        if (ol->uso4) {
>               offload |= TUN_F_USO4;
>           }
> -        if (uso6) {
> +        if (ol->uso6) {
>               offload |= TUN_F_USO6;
>           }
>       }
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index b1aa40d46b..ac09ae03c0 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -27,6 +27,7 @@
>   #include "tap_int.h"
>   #include "qemu/ctype.h"
>   #include "qemu/cutils.h"
> +#include "net/net.h"
>   
>   #include <sys/ethernet.h>
>   #include <sys/sockio.h>
> @@ -240,8 +241,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>       return -EINVAL;
>   }
>   
> -void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo, int uso4, int uso6)
> +void tap_fd_set_offload(int fd, const NetOffloads *ol)
>   {
>   }
>   
> diff --git a/net/tap-stub.c b/net/tap-stub.c
> index 5f57d6baac..66abbbc392 100644
> --- a/net/tap-stub.c
> +++ b/net/tap-stub.c
> @@ -71,8 +71,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>       return -EINVAL;
>   }
>   
> -void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo, int uso4, int uso6)
> +void tap_fd_set_offload(int fd, const NetOffloads *ol)
>   {
>   }
>   
> diff --git a/net/tap.c b/net/tap.c
> index f6e8cd5f1c..c7612fb91b 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -271,15 +271,14 @@ static int tap_set_vnet_be(NetClientState *nc, bool is_be)
>       return tap_fd_set_vnet_be(s->fd, is_be);
>   }
>   
> -static void tap_set_offload(NetClientState *nc, int csum, int tso4,
> -                     int tso6, int ecn, int ufo, int uso4, int uso6)
> +static void tap_set_offload(NetClientState *nc, const NetOffloads *ol)
>   {
>       TAPState *s = DO_UPCAST(TAPState, nc, nc);
>       if (s->fd < 0) {
>           return;
>       }
>   
> -    tap_fd_set_offload(s->fd, csum, tso4, tso6, ecn, ufo, uso4, uso6);
> +    tap_fd_set_offload(s->fd, ol);
>   }
>   
>   static void tap_exit_notify(Notifier *notifier, void *data)
> @@ -365,6 +364,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>                                    int fd,
>                                    int vnet_hdr)
>   {
> +    NetOffloads ol = {};
>       NetClientState *nc;
>       TAPState *s;
>   
> @@ -379,7 +379,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>       s->has_uso = tap_probe_has_uso(s->fd);
>       s->has_tunnel = tap_probe_has_tunnel(s->fd);
>       s->enabled = true;
> -    tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
> +    tap_set_offload(&s->nc, &ol);
>       /*
>        * Make sure host header length is set correctly in tap:
>        * it might have been modified by another instance of qemu.
> diff --git a/net/tap_int.h b/net/tap_int.h
> index 2a8aa3632f..327d10f68b 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -27,6 +27,7 @@
>   #define NET_TAP_INT_H
>   
>   #include "qapi/qapi-types-net.h"
> +#include "net/net.h"
>   
>   int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
>                int vnet_hdr_required, int mq_required, Error **errp);
> @@ -38,8 +39,7 @@ int tap_probe_vnet_hdr(int fd, Error **errp);
>   int tap_probe_has_ufo(int fd);
>   int tap_probe_has_uso(int fd);
>   int tap_probe_has_tunnel(int fd);
> -void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
> -                        int uso4, int uso6);
> +void tap_fd_set_offload(int fd, const NetOffloads *ol);
>   void tap_fd_set_vnet_hdr_len(int fd, int len);
>   int tap_fd_set_vnet_le(int fd, int vnet_is_le);
>   int tap_fd_set_vnet_be(int fd, int vnet_is_be);


