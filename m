Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C790E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 07:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUhK1-0006Gi-OK; Mon, 06 Jan 2025 02:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tUhJz-0006Fk-Ot
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 02:14:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tUhJw-0002La-ME
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 02:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736147678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWtq5r4IcGlN8hhXlIUf6Ho8zFJiZerFk0QHb46hOOo=;
 b=WJgLCQ8X/D0eGkmATQiGEBMGp+1Xm4Ot8BxJGIiVl8k79h4TKICPvtJ491BlpQqW3NYaYR
 Q36s5vFv5d3jE0phEg0+gDQwyj3JpZ15AU8lxh9c2RN5Hg8AlqdAwfedzCDJY2kyzGYCI8
 xRA+3fFojtBvTIrIOl12xk2u6m2meNI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-2zAo9HmpNgma3F7-TwjsSA-1; Mon, 06 Jan 2025 02:14:36 -0500
X-MC-Unique: 2zAo9HmpNgma3F7-TwjsSA-1
X-Mimecast-MFC-AGG-ID: 2zAo9HmpNgma3F7-TwjsSA
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d40db3d084so13035654a12.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 23:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736147674; x=1736752474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWtq5r4IcGlN8hhXlIUf6Ho8zFJiZerFk0QHb46hOOo=;
 b=wm0XJ1YoytJO9HVrriQnYTzWZqX3Q19SINc2ELYWiB3ysZS/X/+dpNK2kV/oIR8ZpV
 eC2SVnyUxzBKRWOw0CgbF9JETMmIY2aoS2nlFzvvrV3fQ3qnptyQuTDjg3bFS/eNLavL
 wPBXrbZ4rmiGYUnRMK4H4hlsYC0IGaCs+ifufrz+qMaRPKxebGZ6CXQLai0kmeG9hqSO
 eneg93bmKTS1vtoMi2XRZ24Qpnynh40k/RJKt94/7sRkHSKkehhVkxGMvXy6pC0rEQ9x
 zzWz4CBMKcW3tpS2NZaM+SzwYtrGbPRiC0RaeVW3HAXbI1HoS6IFGhp9Cf/F09sclHaE
 86Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/PKLPzaQRKVah54SsKCpVORMKy4t/pfrMQUW6lcqbUfnIRP5IfrgpWiI67cvkfee1G0byHQRDYma0@nongnu.org
X-Gm-Message-State: AOJu0YxhNXDcbwxP4PL7OotL9UNGIcGbysVRLa6SyHISAU7arpAlQ0yH
 l0Em7xhcDCeVdV9ZOBblla5ahASWbHe53+cmSAiDk1KuPe5tTveT9t0KZVtXEuPrOIOZQ+00it4
 pDy21udRYKJwA2ub2Fp0h2ILjY8gHeM45nBJdPeRuYjYR4luzb2bUzQ9KhQQ4E32d0daCd5Ab60
 T1k+XpyVxrpX8zWHZqyUUi4gN1Gsic4HCf0b7BVg==
X-Gm-Gg: ASbGnctSKcuFJdZefoVAwuHT/NcdFa/5DpxkH5PQx9OH/BvDdIEz7HieD+QwychYsZ1
 kp9jDTeuHQLdIR7JHgD8sHVjPLcSze+T1WhYpfkw=
X-Received: by 2002:a05:6402:540b:b0:5d6:48ef:c19f with SMTP id
 4fb4d7f45d1cf-5d81de1c28fmr137697624a12.29.1736147673973; 
 Sun, 05 Jan 2025 23:14:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT2/pkSXLpyY4A1/7uyMRaPcuDaA12FfT5EuElrmBvqls0EiiC7z3MgcVQk9W20JAyDoqJawM38ywO1BNOJOc=
X-Received: by 2002:a05:6402:348d:b0:5d4:55e:f99e with SMTP id
 4fb4d7f45d1cf-5d81ddc09abmr143481636a12.18.1736147663392; Sun, 05 Jan 2025
 23:14:23 -0800 (PST)
MIME-Version: 1.0
References: <20250104-auto-v4-0-972461ee87fd@daynix.com>
 <20250104-auto-v4-1-972461ee87fd@daynix.com>
In-Reply-To: <20250104-auto-v4-1-972461ee87fd@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 6 Jan 2025 15:13:45 +0800
Message-ID: <CAPpAL=y2FsZHNwfQhFXBk6dPKfHyex5uQ6tzCnJibBiwjsVLMQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] virtio-net: Convert feature properties to OnOffAuto
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Sat, Jan 4, 2025 at 3:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> Some features are not always available, and virtio-net used to disable
> them when not available even if the corresponding properties were
> explicitly set to "on".
>
> Convert feature properties to OnOffAuto so that the user can explicitly
> tell QEMU to automatically select the value by setting them "auto".
> QEMU will give an error if they are set "on".
>
> Convert "on" to "auto" when using an old machine for compatbility.
> VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_RSS are exceptional and not
> converted to "auto" if the peer is not vhost because they were
> previously forcibly enabled even if they were not supported by the
> peer and required the in-QEMU implementation, which incurred overhead.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/virtio/virtio-net.h |   3 +-
>  hw/core/machine.c              |   1 +
>  hw/net/virtio-net.c            | 261 ++++++++++++++++++++++++++---------=
------
>  3 files changed, 169 insertions(+), 96 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index b9ea9e824e3c..d41f042d4e2f 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -178,7 +178,7 @@ struct VirtIONet {
>      uint32_t has_vnet_hdr;
>      size_t host_hdr_len;
>      size_t guest_hdr_len;
> -    uint64_t host_features;
> +    OnOffAutoBit64 host_features;
>      uint32_t rsc_timeout;
>      uint8_t rsc4_enabled;
>      uint8_t rsc6_enabled;
> @@ -218,6 +218,7 @@ struct VirtIONet {
>      /* primary failover device is hidden*/
>      bool failover_primary_hidden;
>      bool failover;
> +    bool force_features_auto;
>      DeviceListener primary_listener;
>      QDict *primary_opts;
>      bool primary_opts_from_json;

Hi Akihiko

> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index bff26b95dd74..1b4435fc1a64 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,6 +38,7 @@
>
>  GlobalProperty hw_compat_9_2[] =3D {
>      { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },

It looks like you forgot to remove this line you added in v3 when
sending v4: "{ TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" } .
Please feel free to correct me if I'm wrong.

Thanks


> +    { TYPE_VIRTIO_NET, "x-force-virtio-net-features-auto", "on" },
>  };
>  const size_t hw_compat_9_2_len =3D G_N_ELEMENTS(hw_compat_9_2);
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 06f096abf678..6b2104c6b68d 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -751,58 +751,110 @@ static void virtio_net_set_queue_pairs(VirtIONet *=
n)
>
>  static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
>
> +static bool virtio_net_clear_features(OnOffAutoBit64 *features,
> +                                      uint64_t clear_bits,
> +                                      const char *reason, Error **errp)
> +{
> +    if (features->on_bits & clear_bits) {
> +        error_setg(errp, "%s", reason);
> +        return false;
> +    }
> +
> +    features->auto_bits &=3D ~clear_bits;
> +
> +    return true;
> +}
> +
>  static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t fea=
tures,
>                                          Error **errp)
>  {
>      VirtIONet *n =3D VIRTIO_NET(vdev);
>      NetClientState *nc =3D qemu_get_queue(n->nic);
> -
> -    /* Firstly sync all virtio-net possible supported features */
> -    features |=3D n->host_features;
> -
> -    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
> -
> -    if (!peer_has_vnet_hdr(n)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
> -
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
> -
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> -
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
> +    OnOffAutoBit64 on_off_auto_features =3D n->host_features;
> +
> +    if (n->force_features_auto) {
> +        on_off_auto_features.auto_bits |=3D on_off_auto_features.on_bits=
;
> +        on_off_auto_features.on_bits =3D
> +            get_vhost_net(nc->peer) ?
> +            0 :
> +            on_off_auto_features.on_bits &
> +            (BIT_ULL(VIRTIO_NET_F_HASH_REPORT) | BIT_ULL(VIRTIO_NET_F_RS=
S));
> +    }
> +
> +    on_off_auto_features.auto_bits |=3D features;
> +    virtio_add_feature(&on_off_auto_features.auto_bits, VIRTIO_NET_F_MAC=
);
> +
> +    if (!((peer_has_vnet_hdr(n) ||
> +           virtio_net_clear_features(&on_off_auto_features,
> +                                     BIT_ULL(VIRTIO_NET_F_CSUM) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_ECN) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_USO) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO6) |
> +                                     BIT_ULL(VIRTIO_NET_F_HASH_REPORT),
> +                                     "A requested feature requires the p=
eer to support virtio-net headers.",
> +                                     errp)) &&
> +          (peer_has_ufo(n) ||
> +           virtio_net_clear_features(&on_off_auto_features,
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_UFO),
> +                                     "UFO is on but the peer does not su=
pport it.",
> +                                     errp)) &&
> +          (peer_has_uso(n) ||
> +           virtio_net_clear_features(&on_off_auto_features,
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_USO) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO6),
> +                                     "USO is on but the peer does not su=
pport it.",
> +                                     errp)) &&
> +          (virtio_has_feature(on_off_auto_features.on_bits |
> +                              on_off_auto_features.auto_bits,
> +                              VIRTIO_NET_F_CTRL_VQ) ||
> +           virtio_net_clear_features(&on_off_auto_features,
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE=
),
> +                                     "guest_announce is on but ctrl_vq i=
s off.",
> +                                     errp)))) {
> +        return 0;
>      }
>
> -    if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
> -    }
> +    if (!get_vhost_net(nc->peer)) {
> +        if (virtio_has_feature(on_off_auto_features.on_bits, VIRTIO_NET_=
F_HASH_REPORT) ||
> +            (virtio_has_feature(on_off_auto_features.on_bits, VIRTIO_NET=
_F_RSS) &&
> +             !ebpf_rss_is_loaded(&n->ebpf_rss))) {
> +            virtio_clear_feature(&on_off_auto_features.auto_bits,
> +                                 VIRTIO_NET_F_RSS);
> +        }
>
> -    if (!peer_has_uso(n)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> -    }
> +        virtio_clear_feature(&on_off_auto_features.auto_bits,
> +                             VIRTIO_NET_F_HASH_REPORT);
>
> -    if (!get_vhost_net(nc->peer)) {
> -        return features;
> +        return on_off_auto_features.on_bits | on_off_auto_features.auto_=
bits;
>      }
>
> -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> +    if (!ebpf_rss_is_loaded(&n->ebpf_rss) &&
> +        !virtio_net_clear_features(&on_off_auto_features,
> +                                   BIT_ULL(VIRTIO_NET_F_RSS),
> +                                   "Both RSS and vhost are on but eBPF i=
s unavailable; fix eBPF or disable RSS.",
> +                                   errp)) {
> +        return 0;
>      }
> -    features =3D vhost_net_get_features(get_vhost_net(nc->peer), feature=
s);
> +    features =3D vhost_net_get_features(get_vhost_net(nc->peer),
> +                                      on_off_auto_features.on_bits |
> +                                      on_off_auto_features.auto_bits);
>      vdev->backend_features =3D features;
>
>      if (n->mtu_bypass_backend &&
> -            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
> +        virtio_has_feature(on_off_auto_features.on_bits |
> +                           on_off_auto_features.auto_bits,
> +                           VIRTIO_NET_F_MTU)) {
>          features |=3D (1ULL << VIRTIO_NET_F_MTU);
>      }
>
> @@ -821,6 +873,12 @@ static uint64_t virtio_net_get_features(VirtIODevice=
 *vdev, uint64_t features,
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
>      }
>
> +    if ((features & on_off_auto_features.on_bits) !=3D
> +        on_off_auto_features.on_bits) {
> +        error_setg(errp, "A requested feature is incompatible with vhost=
.");
> +        return 0;
> +    }
> +
>      return features;
>  }
>
> @@ -3639,7 +3697,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>      int i;
>
>      if (n->net_conf.mtu) {
> -        n->host_features |=3D (1ULL << VIRTIO_NET_F_MTU);
> +        n->host_features.on_bits |=3D (1ULL << VIRTIO_NET_F_MTU);
>      }
>
>      if (n->net_conf.duplex_str) {
> @@ -3651,7 +3709,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>              error_setg(errp, "'duplex' must be 'half' or 'full'");
>              return;
>          }
> -        n->host_features |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
> +        n->host_features.on_bits |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX=
);
>      } else {
>          n->net_conf.duplex =3D DUPLEX_UNKNOWN;
>      }
> @@ -3661,7 +3719,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>          return;
>      }
>      if (n->net_conf.speed >=3D 0) {
> -        n->host_features |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
> +        n->host_features.on_bits |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX=
);
>      }
>
>      if (n->failover) {
> @@ -3670,10 +3728,12 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>          device_listener_register(&n->primary_listener);
>          migration_add_notifier(&n->migration_state,
>                                 virtio_net_migration_state_notifier);
> -        n->host_features |=3D (1ULL << VIRTIO_NET_F_STANDBY);
> +        n->host_features.on_bits |=3D (1ULL << VIRTIO_NET_F_STANDBY);
>      }
>
> -    virtio_net_set_config_size(n, n->host_features);
> +    virtio_net_set_config_size(n,
> +                               n->host_features.on_bits |
> +                               n->host_features.auto_bits);
>      virtio_init(vdev, VIRTIO_ID_NET, n->config_size);
>
>      /*
> @@ -3800,7 +3860,9 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>
>      net_rx_pkt_init(&n->rx_pkt);
>
> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> +    if (virtio_has_feature(n->host_features.on_bits |
> +                           n->host_features.auto_bits,
> +                           VIRTIO_NET_F_RSS)) {
>          Error *err =3D NULL;
>          if (!virtio_net_load_ebpf(n, &err)) {
>              /*
> @@ -3827,7 +3889,9 @@ static void virtio_net_device_unrealize(DeviceState=
 *dev)
>      VirtIONet *n =3D VIRTIO_NET(dev);
>      int i, max_queue_pairs;
>
> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> +    if (virtio_has_feature(n->host_features.on_bits |
> +                           n->host_features.auto_bits,
> +                           VIRTIO_NET_F_RSS)) {
>          virtio_net_unload_ebpf(n);
>      }
>
> @@ -3986,53 +4050,58 @@ static const VMStateDescription vmstate_virtio_ne=
t =3D {
>  };
>
>  static const Property virtio_net_properties[] =3D {
> -    DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CSUM, true),
> -    DEFINE_PROP_BIT64("guest_csum", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_CSUM, true),
> -    DEFINE_PROP_BIT64("gso", VirtIONet, host_features, VIRTIO_NET_F_GSO,=
 true),
> -    DEFINE_PROP_BIT64("guest_tso4", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_TSO4, true),
> -    DEFINE_PROP_BIT64("guest_tso6", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_TSO6, true),
> -    DEFINE_PROP_BIT64("guest_ecn", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_ECN, true),
> -    DEFINE_PROP_BIT64("guest_ufo", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_UFO, true),
> -    DEFINE_PROP_BIT64("guest_announce", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_ANNOUNCE, true),
> -    DEFINE_PROP_BIT64("host_tso4", VirtIONet, host_features,
> -                    VIRTIO_NET_F_HOST_TSO4, true),
> -    DEFINE_PROP_BIT64("host_tso6", VirtIONet, host_features,
> -                    VIRTIO_NET_F_HOST_TSO6, true),
> -    DEFINE_PROP_BIT64("host_ecn", VirtIONet, host_features,
> -                    VIRTIO_NET_F_HOST_ECN, true),
> -    DEFINE_PROP_BIT64("host_ufo", VirtIONet, host_features,
> -                    VIRTIO_NET_F_HOST_UFO, true),
> -    DEFINE_PROP_BIT64("mrg_rxbuf", VirtIONet, host_features,
> -                    VIRTIO_NET_F_MRG_RXBUF, true),
> -    DEFINE_PROP_BIT64("status", VirtIONet, host_features,
> -                    VIRTIO_NET_F_STATUS, true),
> -    DEFINE_PROP_BIT64("ctrl_vq", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_VQ, true),
> -    DEFINE_PROP_BIT64("ctrl_rx", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_RX, true),
> -    DEFINE_PROP_BIT64("ctrl_vlan", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_VLAN, true),
> -    DEFINE_PROP_BIT64("ctrl_rx_extra", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_RX_EXTRA, true),
> -    DEFINE_PROP_BIT64("ctrl_mac_addr", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_MAC_ADDR, true),
> -    DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
> -    DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, f=
alse),
> -    DEFINE_PROP_BIT64("rss", VirtIONet, host_features,
> -                    VIRTIO_NET_F_RSS, false),
> -    DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
> -                    VIRTIO_NET_F_HASH_REPORT, false),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("csum", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_CSUM, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_csum", VirtIONet, host_features=
,
> +                                  VIRTIO_NET_F_GUEST_CSUM, ON_OFF_AUTO_A=
UTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("gso", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_GSO, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_tso4", VirtIONet, host_features=
,
> +                                  VIRTIO_NET_F_GUEST_TSO4, ON_OFF_AUTO_A=
UTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_tso6", VirtIONet, host_features=
,
> +                                  VIRTIO_NET_F_GUEST_TSO6, ON_OFF_AUTO_A=
UTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_ecn", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_GUEST_ECN, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_ufo", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_GUEST_UFO, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_announce", VirtIONet, host_feat=
ures,
> +                                  VIRTIO_NET_F_GUEST_ANNOUNCE,
> +                                  ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_tso4", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HOST_TSO4, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_tso6", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HOST_TSO6, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_ecn", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HOST_ECN, ON_OFF_AUTO_AUT=
O),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_ufo", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HOST_UFO, ON_OFF_AUTO_AUT=
O),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("mrg_rxbuf", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_MRG_RXBUF, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("status", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_STATUS, ON_OFF_AUTO_AUTO)=
,
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_vq", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_CTRL_VQ, ON_OFF_AUTO_AUTO=
),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_rx", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_CTRL_RX, ON_OFF_AUTO_AUTO=
),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_vlan", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_CTRL_VLAN, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_rx_extra", VirtIONet, host_featu=
res,
> +                                  VIRTIO_NET_F_CTRL_RX_EXTRA, ON_OFF_AUT=
O_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_mac_addr", VirtIONet, host_featu=
res,
> +                                  VIRTIO_NET_F_CTRL_MAC_ADDR, ON_OFF_AUT=
O_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_guest_offloads", VirtIONet,
> +                                  host_features,
> +                                  VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
> +                                  ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("mq", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_MQ, ON_OFF_AUTO_OFF),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("rss", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_RSS, ON_OFF_AUTO_OFF),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HASH_REPORT, ON_OFF_AUTO_=
OFF),
>      DEFINE_PROP_ARRAY("ebpf-rss-fds", VirtIONet, nr_ebpf_rss_fds,
>                        ebpf_rss_fds, qdev_prop_string, char*),
> -    DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
> +    DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features.on_bits,
>                      VIRTIO_NET_F_RSC_EXT, false),
>      DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
>                         VIRTIO_NET_RSC_DEFAULT_INTERVAL),
> @@ -4051,12 +4120,14 @@ static const Property virtio_net_properties[] =3D=
 {
>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN)=
,
>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>      DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
> -    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
> -                      VIRTIO_NET_F_GUEST_USO4, true),
> -    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
> -                      VIRTIO_NET_F_GUEST_USO6, true),
> -    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> -                      VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_BOOL("x-force-virtio-net-features-auto", VirtIONet,
> +                     force_features_auto, false),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_uso4", VirtIONet, host_features=
,
> +                                  VIRTIO_NET_F_GUEST_USO4, ON_OFF_AUTO_A=
UTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_uso6", VirtIONet, host_features=
,
> +                                  VIRTIO_NET_F_GUEST_USO6, ON_OFF_AUTO_A=
UTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_uso", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HOST_USO, ON_OFF_AUTO_AUT=
O),
>  };
>
>  static void virtio_net_class_init(ObjectClass *klass, void *data)
>
> --
> 2.47.1
>
>


