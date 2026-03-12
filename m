Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E565FED2FC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0d74-0005Kt-P8; Thu, 12 Mar 2026 06:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w0d73-0005Ki-83
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w0d70-0004Zk-Dl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773310668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8Lg0G+XKUrr7n71pzTNzBx06TyFgg9hhfCDuQ2jI3I=;
 b=SvqzshSsr3X0ao/omLtr98HEztg/5Nlc5Xvau/kQq6WYAv/OZOma2PPMVUbIHlRwtSh1Wt
 TVjITQa+XRdFZOGYmR3iDm1c6QqLD1SKLxXtgybk/ZShXsT0T32JSZKKxXaH5qVThy+sjL
 xIFzJjvVVs+9E6QSl7GTTPC/pMLDPGo=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-3a_NJnJHOk6gRC-eEdIJ5Q-1; Thu, 12 Mar 2026 06:17:46 -0400
X-MC-Unique: 3a_NJnJHOk6gRC-eEdIJ5Q-1
X-Mimecast-MFC-AGG-ID: 3a_NJnJHOk6gRC-eEdIJ5Q_1773310666
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-64ca2fce827so2243803d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 03:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773310666; cv=none;
 d=google.com; s=arc-20240605;
 b=lh7fw/sS8HjjL3OccViW+PtHMwbKnTcG61ca9wrY5boCMYBr5aJWldbswXe+CEpefp
 n+ugVuP8z1YZgUeinBTFGeky3Etyl39pRfYsGVmCOa6k0w+ScCD9iOuYM2LoGO8tmvjF
 z2Vo4qpLOu6dCJAeJYuj6fkQpOHh7GU9BvB7nbHjeV2NI3K/svtgJu0zkVXQXavzMtcY
 MKL+vqVqO00faOafz9blUfsxnnCyMWNnOOxNENXiH2qf/Z5/l/1iPClOFXuycfnyK6eL
 1fFYsV97oEofKAJnzIsnyOmKbS12dZfgVOeTmnFlAWcCfRGnwWcahkIiUK4KZUxqmikv
 YCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n8Lg0G+XKUrr7n71pzTNzBx06TyFgg9hhfCDuQ2jI3I=;
 fh=YWd1Q3HWQm37cadwbuH1smAtl/9JiSgdWcRaZLT5vrE=;
 b=TrhnLZ02jxq9BM66qs+vXDYVhvotn/s3B1yWmHZ20PoGZfY8wQvXxe2zPhMy678B17
 NwAD1S0d4GdsyqgJe8DcYiBSuLTcfy9L/f56ur9EVnqACiC5AtGT1Z3pYK/9WJ3gOH9X
 niW+/eay28rbOGmN9Mm+U5kqjx+fmXeV5JNmCHnLZS0G6XkUiBLvOuwnSiDqZbv+5M3X
 CJ3Qb1DvuFySeiAyrHx/WmkpBc2zb3E4J95UPvKXUD2xgnXW8uvUKSpADQh7ALsqOrSo
 lB3cO9161D8MXI4ry3Pta3O4kvoJb5Y9IIefaAhRH1jkCHIMnKKvV1Obt76zK2IkuLq8
 PEoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773310666; x=1773915466; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8Lg0G+XKUrr7n71pzTNzBx06TyFgg9hhfCDuQ2jI3I=;
 b=KeWPvJXy+7v7jm0LfMjwChXBIa2U39F4RZb7iTEAm56iuurUSvUYdP5wwcrxoG5puI
 djR5yLsXcjG2rAfUpXdnSulCp7g1Yzjvm9K2oCtLoq+fcz84QsoddqKdIviqMxe1QJdp
 5XeL0ODVIJURxIh6g54RWRdwUjrSdBdO9s8tgg/hjsy0EosBSQ0Z6ZKiROPSx72NZXkl
 QBYoAcvunzjxjEEbyE1Q+V0L0YbElazqKMPg3MaPjqxYnJ8X/qYMR2BUIOKIKPyqO8Po
 6zesxX88NKneQ9swqQpJcYTTW7mrw7V2PupfzdGPTfXUiz3UClIOeJadu2VemNol93KF
 V8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773310666; x=1773915466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n8Lg0G+XKUrr7n71pzTNzBx06TyFgg9hhfCDuQ2jI3I=;
 b=FIyBwjuMl7mVTFRDOUWg52yWcZB/tTDezWQ022CixRjyee369Uzk6G5211zX1Ib2AJ
 PFoh3q2NqXae0GmDGdFTuPnX13TeTO5h6iQB9qz2ntifBzv47XP+GtNPVPCul3VYCaEE
 R+6O0jS8rtl4nU1snOHUfkkr9XJ2leuiPWe/B/5/bBUNV4L4IaF2XAvGvNjFITzp5FLW
 oQ1BVhPTVXnJkU/6QT4rdPZVQroWLW3kyCGwU2+1mhyR0Qh6JhwuvF8XUTW6/ehNI1NY
 dCHtfcrIxLng/w3j4DmqzbaEJFcFvqidTHUeCpMOY6rK7ZkrmE+Zmf2viunRrhZHUWQY
 S8PA==
X-Gm-Message-State: AOJu0YzLgEiaejvCxxIwnnpYOyFptlYLl9SqncrJTokxeEqCRNhNYjgB
 JWChm1UayS4ZzopBr7e+vYIXP2pf1qjQ5BjJH0d2b79FFlXywnCt+l8AFElJUasJt6J8dpYa0my
 9Wugb/y1x5j41XKen4mUw+Zw9vcyIPVujTtw3bwGrnrW2UBlNqgjHMmu3vD8FPpuXpnBpqrd9C3
 VjsKWkYzj204HOA20HvYxCznU04ZqnAnY=
X-Gm-Gg: ATEYQzxf2n27EN1sP3TxNo7n4Vp7/Oik3W+2LguIyS3qpK5M3f/PzMK5f95cIr000T5
 1Pei6d6MgKVXjkdhNdaaCBArPuXA7YK/kisoIkRIMSshuWjJKlLc33G332ntY8tq4Cx53WYl9zc
 sptCuj5g0nBlIjI2F+GY4Wx/LIgQCVFQAxXY3/NEEONjpWVqq5SElm0yW1rvAqFD8PBLyndC6Y9
 XcP7w==
X-Received: by 2002:a05:690e:1a83:b0:64c:acdd:f165 with SMTP id
 956f58d0204a3-64dc7168fd5mr1850268d50.25.1773310665796; 
 Thu, 12 Mar 2026 03:17:45 -0700 (PDT)
X-Received: by 2002:a05:690e:1a83:b0:64c:acdd:f165 with SMTP id
 956f58d0204a3-64dc7168fd5mr1850250d50.25.1773310665255; Thu, 12 Mar 2026
 03:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260311132801.292173-1-kdutta@redhat.com>
In-Reply-To: <20260311132801.292173-1-kdutta@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 12 Mar 2026 11:17:09 +0100
X-Gm-Features: AaiRm52L5oxTQRK45KnhS7M5pBZdR6aBiNAufd7FVw2386WGT0435pV9kryPUMo
Message-ID: <CAJaqyWfHQ-6S1jNnnv0TrTmP5r-GQWdP+PeLtziuUikyg+TFYA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net/virtio-net: add support for notification
 coalescing
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 2:28=E2=80=AFPM Koushik Dutta <kdutta@redhat.com> w=
rote:
>
> Implement VirtIO Network Notification Coalescing (Bit 53).
> This allows the guest to manage interrupt frequency using ethtool
> -C for both RX and TX paths.
>
> - Added VIRTIO_NET_F_NOTF_COAL to host features.
> - Implemented VIRTIO_NET_CTRL_NOTF_COAL class handling in
>   virtio_net_handle_ctrl_iov.
> - Added logic to store and apply rx/tx usecs and max_packets.
> - Added packet counters and threshold logic for both RX and TX data paths=
.
> - Dynamic Dispatcher: Implemented a dispatcher mechanism that
>   dynamically switches/activates the notification callback logic
>   only after the guest enables TX coalescing via ethtool.
>
> This reduces interrupt overhead by batching notifications based on
> either a packet count or a time-based threshold.
>
> Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> ---
>  hw/net/virtio-net.c                | 114 ++++++++++++++++++++++++-----
>  hw/virtio/vhost-shadow-virtqueue.c |   1 +
>  hw/virtio/vhost-vdpa.c             |   3 +
>  include/hw/virtio/virtio-net.h     |   8 ++
>  net/vhost-vdpa.c                   |  10 +++
>  5 files changed, 119 insertions(+), 17 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index eccb48ad42..96aa70aea8 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -157,6 +157,15 @@ static void flush_or_purge_queued_packets(NetClientS=
tate *nc)
>   * - we could suppress RX interrupt if we were so inclined.
>   */
>
> +static void virtio_net_rx_notify(void *opaque)
> +{
> +    VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    n->rx_pkt_cnt =3D 0;
> +    virtio_notify(vdev, n->vqs[0].rx_vq);
> +}
> +
>  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
>      VirtIONet *n =3D VIRTIO_NET(vdev);
> @@ -1081,6 +1090,29 @@ static int virtio_net_handle_offloads(VirtIONet *n=
, uint8_t cmd,
>      }
>  }
>
> +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
> +                                  struct iovec *iov, unsigned int iov_cn=
t)
> +{
> +    struct virtio_net_ctrl_coal coal;
> +    size_t s;
> +
> +    s =3D iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
> +    if (s !=3D sizeof(coal)) {
> +        return VIRTIO_NET_ERR;
> +    }
> +
> +    if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
> +        n->rx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> +        n->rx_coal_packets =3D le32_to_cpu(coal.max_packets);
> +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
> +    }
> +
> +    return VIRTIO_NET_OK;
> +}
> +
>  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
>                                   struct iovec *iov, unsigned int iov_cnt=
)
>  {
> @@ -1582,6 +1614,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vde=
v,
>          status =3D virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
>      } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
>          status =3D virtio_net_handle_offloads(n, ctrl.cmd, iov, out_num)=
;
> +    } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_NOTF_COAL) {
> +        status =3D virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
>      }
>
>      s =3D iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
> @@ -2041,7 +2075,18 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
te *nc, const uint8_t *buf,
>      }
>
>      virtqueue_flush(q->rx_vq, i);
> -    virtio_notify(vdev, q->rx_vq);
> +
> +    /* rx coalescing */
> +    n->rx_pkt_cnt +=3D i;
> +    if (n->rx_coal_usecs =3D=3D 0 || n->rx_pkt_cnt >=3D n->rx_coal_packe=
ts) {
> +        timer_del(n->rx_index_timer);
> +        virtio_net_rx_notify(n);
> +    } else {
> +        if (n->rx_pkt_cnt =3D=3D i) {

Maybe it's better to check if !timer_pending? It wasn't immediately
clear to me that `n->rx_pkt_cnt =3D=3D i` until I realized that
`n->rx_pkt_cnt` is 0 at the beginning of the function for that
condition to be true.

> +            timer_mod(n->rx_index_timer,
> +                      qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_coal=
_usecs);
> +        }
> +    }
>
>      return size;
>
> @@ -2900,6 +2945,7 @@ static void virtio_net_tx_timer(void *opaque)
>      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
>          return;
>      }
> +    n->tx_pkt_cnt -=3D ret;
>      /*
>       * If we flush a full burst of packets, assume there are
>       * more coming and immediately rearm
> @@ -2919,6 +2965,7 @@ static void virtio_net_tx_timer(void *opaque)
>      ret =3D virtio_net_flush_tx(q);
>      if (ret > 0) {
>          virtio_queue_set_notification(q->tx_vq, 0);
> +        n->tx_pkt_cnt -=3D ret;

If we got his way, we must control for underflow here.

But I think it should be n->pt_pkt_cnt =3D 0, isn't it?

>          q->tx_waiting =3D 1;
>          timer_mod(q->tx_timer,
>                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> @@ -2974,27 +3021,45 @@ static void virtio_net_tx_bh(void *opaque)
>      }
>  }
>
> -static void virtio_net_add_queue(VirtIONet *n, int index)
> +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue =
*vq)
>  {
> -    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    VirtIONet *n =3D VIRTIO_NET(vdev);
>
> -    n->vqs[index].rx_vq =3D virtio_add_queue(vdev, n->net_conf.rx_queue_=
size,
> -                                           virtio_net_handle_rx);
> +    n->tx_pkt_cnt++;
> +    bool use_timer =3D n->tx_timer_activate || n->tx_coal_usecs > 0 ||
> +                     n->tx_coal_packets > 0;

No declarations in the middle of the function.

Also, why use_timer =3D true as long as n->tx_coal_packets > 0?

>
> -    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_timer);
> -        n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                              virtio_net_tx_timer,
> -                                              &n->vqs[index]);
> +    if (use_timer && n->tx_pkt_cnt < n->tx_coal_packets) {
> +        virtio_net_handle_tx_timer(vdev, vq);
>      } else {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_bh);
> -        n->vqs[index].tx_bh =3D qemu_bh_new_guarded(virtio_net_tx_bh, &n=
->vqs[index],
> -                                                  &DEVICE(vdev)->mem_ree=
ntrancy_guard);
> +        n->tx_pkt_cnt =3D 0;
> +        virtio_net_handle_tx_bh(vdev, vq);
>      }
> +}
> +
> +static void virtio_net_add_queue(VirtIONet *n, int index)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    n->vqs[index].rx_vq =3D
> +        virtio_add_queue(vdev,
> +                         n->net_conf.rx_queue_size,
> +                         virtio_net_handle_rx);
> +
> +    n->vqs[index].tx_vq =3D
> +        virtio_add_queue(vdev,
> +                         n->net_conf.tx_queue_size,
> +                         virtio_net_handle_tx_dispatch);
> +
> +    n->vqs[index].tx_timer =3D
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                     virtio_net_tx_timer,
> +                     &n->vqs[index]);

We should avoid creating a new timer if it will not be used by
default. Create it only if cmdline enables it or the guest enable it
via control vq.

> +
> +    n->vqs[index].tx_bh =3D
> +        qemu_bh_new_guarded(virtio_net_tx_bh,
> +                            &n->vqs[index],
> +                            &DEVICE(vdev)->mem_reentrancy_guard);
>
>      n->vqs[index].tx_waiting =3D 0;
>      n->vqs[index].n =3D n;
> @@ -3089,6 +3154,7 @@ static void virtio_net_get_features(VirtIODevice *v=
dev, uint64_t *features,
>      virtio_features_or(features, features, n->host_features_ex);
>
>      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> +    virtio_add_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);

We shouldn't enable VIRTIO_NET_F_NOTF_COAL unconditionally, it should
be regulated by the cmdline property.

>
>      if (!peer_has_vnet_hdr(n)) {
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> @@ -3972,6 +4038,10 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>          error_printf("Defaulting to \"bh\"");
>      }
>
> +    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")) {
> +        n->tx_timer_activate =3D true;
> +    }
> +
>      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
>                                      n->net_conf.tx_queue_size);
>
> @@ -4048,6 +4118,14 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>              n->rss_data.specified_hash_types.on_bits |
>              n->rss_data.specified_hash_types.auto_bits;
>      }
> +    n->rx_pkt_cnt =3D 0;
> +    n->tx_pkt_cnt =3D 0;
> +    n->rx_coal_usecs =3D 0;
> +    n->tx_coal_usecs =3D 0;
> +    n->rx_coal_packets =3D 0;
> +    n->tx_coal_packets =3D 0;
> +    n->rx_index_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                     virtio_net_rx_notify, n);

Same as the tx timer. Is it worth creating a new timer even if it will
not be used by default?

>  }
>
>  static void virtio_net_device_unrealize(DeviceState *dev)
> @@ -4262,6 +4340,8 @@ static const Property virtio_net_properties[] =3D {
>                        VIRTIO_NET_F_GUEST_USO6, true),
>      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                        VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
> +                      VIRTIO_NET_F_NOTF_COAL, true),
>      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
>                                    rss_data.specified_hash_types,
>                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 6242aeb69c..104ed0ce8f 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -37,6 +37,7 @@ bool vhost_svq_valid_features(uint64_t features, Error =
**errp)
>          case VIRTIO_RING_F_INDIRECT_DESC:
>              continue;
>
> +        case VIRTIO_F_RING_RESET:

This patch does not handle VIRTIO_F_RING_RESET, so this should not be enabl=
ed.

>          case VIRTIO_F_ACCESS_PLATFORM:
>              /* SVQ trust in the host's IOMMU to translate addresses */
>          case VIRTIO_F_VERSION_1:
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 2f8f11df86..8eb9bdb961 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1541,6 +1541,9 @@ static int vhost_vdpa_get_features(struct vhost_dev=
 *dev,
>      if (ret =3D=3D 0) {
>          /* Add SVQ logging capabilities */
>          *features |=3D BIT_ULL(VHOST_F_LOG_ALL);
> +
> +        /* Add notification coalescing features */
> +        *features |=3D BIT_ULL(VIRTIO_NET_F_NOTF_COAL);
>      }
>
>      return ret;
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index 5b8ab7bda7..024501ed37 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -231,6 +231,14 @@ struct VirtIONet {
>      struct EBPFRSSContext ebpf_rss;
>      uint32_t nr_ebpf_rss_fds;
>      char **ebpf_rss_fds;
> +    QEMUTimer *rx_index_timer;
> +    uint32_t rx_coal_usecs;
> +    uint32_t rx_coal_packets;
> +    uint32_t rx_pkt_cnt;
> +    uint32_t tx_coal_usecs;
> +    uint32_t tx_coal_packets;
> +    uint32_t tx_pkt_cnt;
> +    bool tx_timer_activate;
>  };
>
>  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 3df6091274..6a5d0f4cae 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -61,6 +61,7 @@ static const int vdpa_feature_bits[] =3D {
>      VIRTIO_F_NOTIFY_ON_EMPTY,
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_ORDER_PLATFORM,
>      VIRTIO_F_VERSION_1,
>      VIRTIO_F_IN_ORDER,
>      VIRTIO_F_NOTIFICATION_DATA,
> @@ -70,6 +71,8 @@ static const int vdpa_feature_bits[] =3D {
>      VIRTIO_NET_F_CTRL_RX,
>      VIRTIO_NET_F_CTRL_RX_EXTRA,
>      VIRTIO_NET_F_CTRL_VLAN,
> +    VIRTIO_NET_F_GUEST_ANNOUNCE,
> +    VIRTIO_NET_F_NOTF_COAL,

Only this feature can be added to vdpa_feature_bits. The rest of them
must not be added to any other array.

>      VIRTIO_NET_F_CTRL_VQ,
>      VIRTIO_NET_F_GSO,
>      VIRTIO_NET_F_GUEST_CSUM,
> @@ -115,6 +118,13 @@ static const uint64_t vdpa_svq_device_features =3D
>      BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
>      BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
>      BIT_ULL(VIRTIO_NET_F_STATUS) |
> +    BIT_ULL(VIRTIO_F_RING_RESET) |
> +    BIT_ULL(VIRTIO_F_ORDER_PLATFORM) |
> +    BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
> +    BIT_ULL(VIRTIO_NET_F_GUEST_USO6) |
> +    BIT_ULL(VIRTIO_NET_F_HOST_USO) |
> +    BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) |
> +    BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
>      BIT_ULL(VIRTIO_NET_F_GSO) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
> --
> 2.53.0
>


