Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89CD1061B2B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 11:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7X14-0006XK-D5; Tue, 31 Mar 2026 07:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w7X0z-0006X7-7Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 07:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w7X0w-0002LR-Rc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 07:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774955525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eoW9LC+oDQA04drjFpoWj7eIotgjGn//y509tcmXMz4=;
 b=HKzLr1uPz2Jcfvxn4OzZ1joyKJXL3A1Tt+XhlIULfjmFU9OnRQ142F/FVY7HGQNMKqWqJw
 ACBr666JTTzTwp76HHcsRMM97qRyIFSr/VF6pB8+pdfabtfWn0t7r903yM4oU1FiYxUxaH
 IdUm4re5//7U7KmX+QEEz63w0gm5+ys=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-l7MgOoC3NV24enSp8a1ssg-1; Tue, 31 Mar 2026 07:12:03 -0400
X-MC-Unique: l7MgOoC3NV24enSp8a1ssg-1
X-Mimecast-MFC-AGG-ID: l7MgOoC3NV24enSp8a1ssg_1774955523
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-64ffe451e14so6442884d50.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 04:12:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774955523; cv=none;
 d=google.com; s=arc-20240605;
 b=eof8peBuwu6TD8ZgfG83kZHvco5WheHHs02XicqSnPb9E/uAtE9h1sq5aFIkLgpMgd
 W720ZF+gR8ujIUI+OlbW+n9DU64vetlRtROB24bpx3QOCOhADJka5jFXNmfTdeHl6v4S
 wngvQYMYKojnpb2l8s0t8j2fSQzrzRlmkpCGPWgP3ZxQMaX156h8oDHWR10ksJhPhe51
 zJWPPxBewRBdEbeULu6oyzOuYlJCnQJsEHIFJlR+rY/Mt8A6cq18D5EXKq/pE8JnpNTc
 SEtQo8X8QVbCj+FP0M/jXlHrawaNqufRdrz00kPLlmn5fAP5l+4kD3eFj+ig003gca93
 CNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eoW9LC+oDQA04drjFpoWj7eIotgjGn//y509tcmXMz4=;
 fh=2j1OPIc+H3IgInHX+gBxX5VNmvDfIM4Z/c1hsqkYxuE=;
 b=GIZ9y5qdkb4MdwTDuIz3szNizeYGrztxyyrk6TCAUW9L93Sk7nHTuOxJOKH9RO10sx
 nePxWKYIimMvaQ/GVGQkzeMy613H3JJPLH+N55Ndr5LS4vq6li9ZKhwFWmI8py+h4QGf
 mNa3OagrkPL0823FuS6QmJdA9jDjRXMy0dxcZCLKXnIIkMW9JCe2Xv7dFA7SbyDDf8Bb
 2ctN3d/ucKId6hBrDHEMTfKS3NDQir8dGBRT6LDVoXW13EElAqAQUqA4RXutn16Di/VK
 yT0IJDmvW11NIfjvH2kCxxLiVLoEucgt8GmFo7R4Ujfeplh9T6U2c0bwYZs4TC6rkxte
 J5CA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774955523; x=1775560323; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoW9LC+oDQA04drjFpoWj7eIotgjGn//y509tcmXMz4=;
 b=qMdtLruf28isqcGd0j39yaFE0oaut6JSzmfAk7jeLpN8NwsF3rdnmj1OU5C+C9XP09
 o9ko5740cKl1aAG9ujqUR658OuizCoaCYnMNnfBMrUOW0PO6rwB8uM9kfCCjr8zZd+td
 a4EJ3NCpPTh8V9C1nI+NKXJ3hPDLYKEWpUPyA3ILV5WAmygkACYy9L04lUE3GZ4Z7iOu
 X3t2ugZvjLkaiKlerKRlN7YDTip3U3DRkcOmiEfj7+0N5EsfCSKuCONQLse2WWtSBuq+
 PZ1M8WIzZocnWuJGHK+Pl307kg2UU/0lFxzG8HmyFp7ldnRKei8ZuIu6ohZKCnyTNyBh
 w+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774955523; x=1775560323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eoW9LC+oDQA04drjFpoWj7eIotgjGn//y509tcmXMz4=;
 b=crjGdOjEKjLS+Ka5OT3N7xCeZWXYGW5os3rA3krA352MT7YpHyZO2NU+rr7RluNgri
 uxTOHl4KPiToi7rZ4uURt9qePDh3w6vQgrn3AKb7+RIpMUO8YpSSHfsgyIJ74UKNEaox
 P2iOAHvBMtSUoAw23T59DRAWTzxZ+Hy46mHWDPMBiXt3+/MdBrMiukhjdNrIdwlP5RyH
 ir2vkaJPh4OqGS6zWuGcKacw0ASWBBc34UQr7kGeyH2P7Y10HiTrmJV3ZlabQdqthu2r
 AoDxYXzTUnBWQleuu3d5MfhCKCIo4LOpi/RHqPkL7ZZH4c0hP271rTrkGalu8DpjNJ9r
 qsVg==
X-Gm-Message-State: AOJu0YycaicHfbi2J3KaHkuxm389x/jxU52HeKyDIlMx/7qhi1PP36wh
 DlcCSZnfMVoasixCgFQgnpYgD3ZYeCaAWmoayY661Vaqk6cXTdikD1FmQIJkwOqtV6Kytb8PLje
 WPxZSKR4eOd6dBst5gfifqqhbPO7RMD7pb6q+9NQbvb2APIg7fyAkHUF7LDW4bWYLZKcqQJAL3a
 03NdsJ9R/QO5NyVt6+0u1dXxnlEkI5RpE=
X-Gm-Gg: ATEYQzw2exz2MVW4AZWcWVosxWQhSV75FeIuzLvOgmXyqVNLzvQoj2NtekD4sx/ITL9
 F8tPXuYoWUw22405OaOxdMV39QbormQFlzVrD2XNmdMYd6KLK48nxC9z8rFF2IOQUDjhV19R/2I
 ZoU/E/lt2k657AR9w8rVJP3XF6FCw3DxFohZEl6psuoPTZyT5NutbEURxDI+HrXf5bNNrU6l385
 ETYNiFu67A3JQat7OSvtrUxdeXWBuzcQyHDdX6Z
X-Received: by 2002:a05:690c:e3ee:b0:79d:4f01:5bb7 with SMTP id
 00721157ae682-79d4f0160d6mr109121727b3.58.1774955523037; 
 Tue, 31 Mar 2026 04:12:03 -0700 (PDT)
X-Received: by 2002:a05:690c:e3ee:b0:79d:4f01:5bb7 with SMTP id
 00721157ae682-79d4f0160d6mr109121357b3.58.1774955522512; Tue, 31 Mar 2026
 04:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260330122917.468225-1-kdutta@redhat.com>
In-Reply-To: <20260330122917.468225-1-kdutta@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 31 Mar 2026 13:11:25 +0200
X-Gm-Features: AQROBzBcPGiKV1i_n1hk97pF8CgBAlTuZ3fQnbbO1xOIFO8Q_voOe3NloeH-Swg
Message-ID: <CAJaqyWd3CqDQXizLxNcMYM9CA=K1LfR_XDaO6ksrnw6StWDBKg@mail.gmail.com>
Subject: Re: [PATCH v4] hw/net/virtio-net: add support for notification
 coalescing
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 30, 2026 at 2:29=E2=80=AFPM Koushik Dutta <kdutta@redhat.com> w=
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
> vhost-vdpa: add support for SVQ interrupt coalescing.
>

This patch still does not add vhost-vdpa support.

> This reduces interrupt overhead by batching notifications based on
> either a packet count or a time-based threshold.
>
> Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> ---
>  hw/net/virtio-net.c            | 137 +++++++++++++++++++++++++++++----
>  include/hw/virtio/virtio-net.h |   8 ++
>  net/vhost-vdpa.c               |   2 +
>  3 files changed, 131 insertions(+), 16 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index eccb48ad42..16f197cbdb 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -131,6 +131,8 @@ static const VirtIOConfigSizeParams cfg_size_params =
=3D {
>      .feature_sizes =3D feature_sizes
>  };
>
> +static void virtio_net_tx_timer(void *opaque);
> +

Nit: I think it's better to move yhis declaration just before the
function that uses it.

>  static VirtIONetQueue *virtio_net_get_subqueue(NetClientState *nc)
>  {
>      VirtIONet *n =3D qemu_get_nic_opaque(nc);
> @@ -157,6 +159,15 @@ static void flush_or_purge_queued_packets(NetClientS=
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

If we keep the code this way, this function should iterate through all
the rx queues.

I'm ok with this version, but it feels more natural to me if each RX
VQ has its own RX timer. This paves the way for per-vq coalescing and
aligns with the tx code. This version has fewer timers and simplifies
some things, so I think it is ok for the moment.

> +}
> +
>  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
>      VirtIONet *n =3D VIRTIO_NET(vdev);
> @@ -1081,6 +1092,43 @@ static int virtio_net_handle_offloads(VirtIONet *n=
, uint8_t cmd,
>      }
>  }
>
> +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
> +                                  struct iovec *iov, unsigned int iov_cn=
t)
> +{
> +    struct virtio_net_ctrl_coal coal;
> +    VirtIONetQueue *q;
> +    size_t s;
> +    int i;
> +
> +    s =3D iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
> +    if (s !=3D sizeof(coal)) {
> +        return VIRTIO_NET_ERR;
> +    }
> +
> +    if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
> +        n->rx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> +        n->rx_coal_packets =3D le32_to_cpu(coal.max_packets);
> +        if (!n->rx_index_timer) {

n->rx_index_timer && n->rx_coal_usecs > 0 ? Also delete it if
rx_coal_usecs =3D=3D 0?

> +            n->rx_index_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                             virtio_net_rx_notify, n);
> +        }
> +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> +        n->tx_timeout =3D n->tx_coal_usecs * 1000;

If n->tx_timeout is only used to convert us to ms, we should not
allocate a variable for this and just multiply by 1000 at the timer
creation time.

> +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> +            q =3D &n->vqs[i];
> +            if (!q->tx_timer) {
> +                q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                           virtio_net_tx_timer,
> +                                           q);
> +            }
> +        }
> +    }
> +
> +    return VIRTIO_NET_OK;
> +}
> +
>  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
>                                   struct iovec *iov, unsigned int iov_cnt=
)
>  {
> @@ -1582,6 +1630,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vde=
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
> @@ -2041,7 +2091,22 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
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
> +        if (n->rx_index_timer) {
> +            timer_del(n->rx_index_timer);
> +        }

How does the next tick occurs if we delete the timer here?

> +        virtio_net_rx_notify(n);
> +    } else {
> +        if (n->rx_index_timer) {
> +            if (!timer_pending(n->rx_index_timer)) {
> +                timer_mod(n->rx_index_timer,
> +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_=
coal_usecs);
> +            }
> +        }
> +    }
>
>      return size;
>
> @@ -2818,7 +2883,6 @@ detach:
>      return -EINVAL;
>  }
>
> -static void virtio_net_tx_timer(void *opaque);
>
>  static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq=
)
>  {
> @@ -2900,6 +2964,12 @@ static void virtio_net_tx_timer(void *opaque)
>      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
>          return;
>      }
> +    if (n->tx_pkt_cnt < ret) {
> +        n->tx_pkt_cnt =3D 0;
> +    } else {
> +        n->tx_pkt_cnt -=3D ret;
> +    }
> +
>      /*
>       * If we flush a full burst of packets, assume there are
>       * more coming and immediately rearm
> @@ -2919,6 +2989,7 @@ static void virtio_net_tx_timer(void *opaque)
>      ret =3D virtio_net_flush_tx(q);
>      if (ret > 0) {
>          virtio_queue_set_notification(q->tx_vq, 0);
> +        n->tx_pkt_cnt -=3D ret;
>          q->tx_waiting =3D 1;
>          timer_mod(q->tx_timer,
>                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> @@ -2974,6 +3045,32 @@ static void virtio_net_tx_bh(void *opaque)
>      }
>  }
>
> +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue =
*vq)
> +{
> +    VirtIONet *n =3D VIRTIO_NET(vdev);
> +    VirtIONetQueue *q =3D &n->vqs[vq2q(virtio_get_queue_index(vq))];
> +    bool use_timer =3D n->tx_timer_activate || n->tx_coal_usecs > 0 ||
> +                     n->tx_coal_packets > 0;
> +    bool pkt_limit =3D (n->tx_coal_packets > 0);
> +
> +    if (use_timer) {
> +        n->tx_pkt_cnt++;
> +        if (!pkt_limit || n->tx_pkt_cnt < n->tx_coal_packets) {
> +            if (q->tx_timer) {
> +                virtio_net_handle_tx_timer(vdev, vq);
> +                return;
> +            }
> +        }
> +        n->tx_pkt_cnt =3D 0;
> +        if (q->tx_timer) {
> +            timer_del(q->tx_timer);
> +        }
> +        virtio_net_handle_tx_bh(vdev, vq);
> +    } else {
> +        virtio_net_handle_tx_bh(vdev, vq);
> +    }
> +}
> +
>  static void virtio_net_add_queue(VirtIONet *n, int index)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> @@ -2981,20 +3078,15 @@ static void virtio_net_add_queue(VirtIONet *n, in=
t index)
>      n->vqs[index].rx_vq =3D virtio_add_queue(vdev, n->net_conf.rx_queue_=
size,
>                                             virtio_net_handle_rx);
>
> -    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_timer);
> -        n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                              virtio_net_tx_timer,
> -                                              &n->vqs[index]);
> -    } else {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_bh);
> -        n->vqs[index].tx_bh =3D qemu_bh_new_guarded(virtio_net_tx_bh, &n=
->vqs[index],
> -                                                  &DEVICE(vdev)->mem_ree=
ntrancy_guard);
> -    }
> +    n->vqs[index].tx_vq =3D
> +        virtio_add_queue(vdev,
> +                         n->net_conf.tx_queue_size,
> +                         virtio_net_handle_tx_dispatch);
> +
> +    n->vqs[index].tx_bh =3D
> +        qemu_bh_new_guarded(virtio_net_tx_bh,
> +                            &n->vqs[index],
> +                            &DEVICE(vdev)->mem_reentrancy_guard);
>
>      n->vqs[index].tx_waiting =3D 0;
>      n->vqs[index].n =3D n;
> @@ -3972,6 +4064,10 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>          error_printf("Defaulting to \"bh\"");
>      }
>
> +    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")) {
> +        n->tx_timer_activate =3D true;
> +    }
> +

I keep thinking it would be easier if we accepted either the timer
cmdline or vq_notif_coal, but never both simultaneously. This way we
can reuse the exact same logic for both of them.

>      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
>                                      n->net_conf.tx_queue_size);
>
> @@ -4048,6 +4144,13 @@ static void virtio_net_device_realize(DeviceState =
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
> +    n->rx_index_timer =3D NULL;
>  }
>
>  static void virtio_net_device_unrealize(DeviceState *dev)
> @@ -4262,6 +4365,8 @@ static const Property virtio_net_properties[] =3D {
>                        VIRTIO_NET_F_GUEST_USO6, true),
>      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                        VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
> +                      VIRTIO_NET_F_NOTF_COAL, true),
>      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
>                                    rss_data.specified_hash_types,
>                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
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
> index 3df6091274..a20db78b81 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -70,6 +70,7 @@ static const int vdpa_feature_bits[] =3D {
>      VIRTIO_NET_F_CTRL_RX,
>      VIRTIO_NET_F_CTRL_RX_EXTRA,
>      VIRTIO_NET_F_CTRL_VLAN,
> +    VIRTIO_NET_F_NOTF_COAL,
>      VIRTIO_NET_F_CTRL_VQ,
>      VIRTIO_NET_F_GSO,
>      VIRTIO_NET_F_GUEST_CSUM,
> @@ -115,6 +116,7 @@ static const uint64_t vdpa_svq_device_features =3D
>      BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
>      BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
>      BIT_ULL(VIRTIO_NET_F_STATUS) |
> +    BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |

This needs to be deleted, SVQ still does not support VIRTIO_NET_F_NOTF_COAL=
.

>      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
>      BIT_ULL(VIRTIO_NET_F_GSO) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
> --
> 2.53.0
>

Also, VMSTATE_ must be added to vmstate_virtio_net_device to migrate
these fields. This can be tested by migrating a device with an
emulated device with no vdpa too.

The process of migration is described here but feel free to ping me
for help: https://www.linux-kvm.org/page/Migration .


