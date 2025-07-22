Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574C5C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 03:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue41s-0005k5-3b; Mon, 21 Jul 2025 23:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ue41W-0005V7-6b
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 23:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ue41T-0006Rh-Mm
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 23:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753156232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYGXIGLC2KVsPIV3olzaU+YXxh3WemHM/ehhzq71XN4=;
 b=by5y4FhqM/zvtaTeqfciqn6YoY59mOBOoL8aTTbndzai/G7tWzHB77gUOq2w0XXjtCxvAF
 uwukVP9EOORBRUQ53Rxe5fU4REXSnC56Iu6Ol95BWdsX8UE2GkxFQlWiwsXbum6Ys2COdV
 QMK981UELUuP/uwyqRbrK6QU8HLm3pw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-wVgvGaHUMM2wHkNZcpMBAw-1; Mon, 21 Jul 2025 23:50:30 -0400
X-MC-Unique: wVgvGaHUMM2wHkNZcpMBAw-1
X-Mimecast-MFC-AGG-ID: wVgvGaHUMM2wHkNZcpMBAw_1753156229
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-74d15d90cdbso4315188b3a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 20:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753156229; x=1753761029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYGXIGLC2KVsPIV3olzaU+YXxh3WemHM/ehhzq71XN4=;
 b=n6QBhqzDIB777BN0pR6jOzqMrQ9Yz8cbcslJ7P0Q3SilBCkBthnV7BsZ6rpY7kUar1
 iAFlsKh0c4XDKjjm9APrgpHSp/nLoD362znO97kb++MEk62GadUyXG4Sel64PSpByZ1u
 hCPwPPdQBqBtFGCvC0AptVA6h76kMmgwJZGUAlyUevNlo8FPmAAsSVU3F6CYH0X4k2s4
 T84DLVndDkUYOPVXWZ7JwvOzaX1cvhAs+mKPb4vHqcyiRcJm0973pT81Qqj/jS2C7/Q+
 jYdU4f5dFaPX8NyMqtGGPPDyIUuDJJ80wbo0+rPOoFK8EdCxkOFB8srQyFjm0T5wvGTa
 oesQ==
X-Gm-Message-State: AOJu0Yz+rgcA3hIkPcC9ANh8CUYE5p4Yu2/6lPQOIz1pMHjjFo98Qkzt
 /X2IGrIoqN/XkxkyAN6DZ79bxAl7od4ycAMNHPyaz4D5C6iiXwVgndlyFstr4siqoeFay8vkqWq
 RyNnNJQ/XHvKXYwWqW5+yo6fzay0rghnEfEm0R3x54xkxFqerxW/3aNlIdH8iv7wgxqJXhjkz5E
 6X8WlAjllhHbPxeRgIYEn29uCOC5okfe0=
X-Gm-Gg: ASbGncvPOS2oOkQWAGuwxdywr2YtQxF3v9ZvzcEUj9BQYMVpJfV0BQ26etPe/5sKMb5
 BeVwtFJhomZYQqMPlrkkzbsVa8yL0n7KQ1o9bF64n10iIE0GmYn7lSv2i/Ra2e63OQzzqsEZfdV
 2GnEjxUgZFUQanjIttlctlZg==
X-Received: by 2002:a05:6a21:6197:b0:235:e7b6:6a04 with SMTP id
 adf61e73a8af0-23813c6d6abmr36225673637.24.1753156229266; 
 Mon, 21 Jul 2025 20:50:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvIvNw+PGfGuS0rOB5qEwgnShqN8DZnCWHT0ruKwCb1B9svUQu3PvlsE8o7AfxEGnTgyVK+eKJBrNhHZNunIM=
X-Received: by 2002:a05:6a21:6197:b0:235:e7b6:6a04 with SMTP id
 adf61e73a8af0-23813c6d6abmr36225628637.24.1753156228835; Mon, 21 Jul 2025
 20:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1752828082.git.pabeni@redhat.com>
 <6ec36a1cc2497f827b9e024acc6adb2515dd9335.1752828082.git.pabeni@redhat.com>
In-Reply-To: <6ec36a1cc2497f827b9e024acc6adb2515dd9335.1752828082.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Jul 2025 11:50:17 +0800
X-Gm-Features: Ac12FXwvNw9RK62hdQ8CK2RhAXaqlR3YsssW7zN7Ocn8zEvPQo8MYdydJqPMdAk
Message-ID: <CACGkMEunxuooL+z=Oz1FsNabNuh=QwfMbzG0k0S+avL3LxEV7w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 12/13] net: implement tunnel probing
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 18, 2025 at 4:54=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
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
>   - use bool type for tap_probe_has_tunnel()
>   - rebased on top of 2deec9ab7d ("virtio-net: Move
>         virtio_net_get_features() down")
>   - _array -> _ex
>
> v1 -> v2:
>   - peer_has_tunnel return a bool
>   - move TUN_F definition in net/tun-linux.h
> ---
>  hw/net/virtio-net.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/net/net.h   |  3 +++
>  net/net.c           |  9 +++++++++
>  net/tap-bsd.c       |  5 +++++
>  net/tap-linux.c     | 11 +++++++++++
>  net/tap-linux.h     |  9 +++++++++
>  net/tap-solaris.c   |  5 +++++
>  net/tap-stub.c      |  5 +++++
>  net/tap.c           | 11 +++++++++++
>  net/tap_int.h       |  1 +
>  10 files changed, 96 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 53413ec4d5..70c85f7f77 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -649,6 +649,15 @@ static int peer_has_uso(VirtIONet *n)
>      return qemu_has_uso(qemu_get_queue(n->nic)->peer);
>  }
>
> +static bool peer_has_tunnel(VirtIONet *n)

Nit: it looks better to use peer_has_udp_gso_tunnel().

> +{
> +    if (!peer_has_vnet_hdr(n)) {
> +        return false;
> +    }
> +
> +    return qemu_has_tunnel(qemu_get_queue(n->nic)->peer);
> +}
> +
>  static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bu=
fs,
>                                         int version_1, int hash_report)
>  {
> @@ -3070,6 +3079,13 @@ static void virtio_net_get_features(VirtIODevice *=
vdev, uint64_t *features,
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
>
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_=
GSO);
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_G=
SO);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> +
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
>      }
>
> @@ -3083,6 +3099,15 @@ static void virtio_net_get_features(VirtIODevice *=
vdev, uint64_t *features,
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
>      }
>
> +    if (!peer_has_tunnel(n)) {
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_=
GSO);
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_G=
SO);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> +        virtio_clear_feature_ex(features,
> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> +    }
> +
>      if (!get_vhost_net(nc->peer)) {
>          if (!use_own_hash) {
>              virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> @@ -4137,6 +4162,10 @@ static const VMStateDescription vmstate_virtio_net=
 =3D {
>      .dev_unplug_pending =3D dev_unplug_pending,
>  };
>
> +#define DEFINE_PROP_FEATURE(_name, _state, _field, _bit, _defval)   \
> +    DEFINE_PROP_BIT64(_name, _state, _field[VIRTIO_DWORD(_bit)],    \
> +                      (_bit) % 64, _defval)
> +
>  static const Property virtio_net_properties[] =3D {
>      DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
>                      VIRTIO_NET_F_CSUM, true),
> @@ -4245,6 +4274,14 @@ static const Property virtio_net_properties[] =3D =
{
>                                    rss_data.specified_hash_types,
>                                    VIRTIO_NET_HASH_REPORT_UDPv6_EX - 1,
>                                    ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_FEATURE("host_tunnel", VirtIONet, host_features_ex,
> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, true),
> +    DEFINE_PROP_FEATURE("host_tunnel_csum", VirtIONet, host_features_ex,
> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, true),
> +    DEFINE_PROP_FEATURE("guest_tunnel", VirtIONet, host_features_ex,
> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, true),
> +    DEFINE_PROP_FEATURE("guest_tunnel_csum", VirtIONet, host_features_ex=
,
> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, true),
>  };

Need compatibility work like:

d83f46d189 ("virtio-pci: compat page aligned ATS")

Thanks


