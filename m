Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B31E9A744
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4xs6-0002nV-9Q; Tue, 24 Mar 2026 05:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4xs1-0002lb-Vp
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4xrz-0001Vg-JN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774343774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ifbEUdQKkyeOEeDTOmyPLT4aw2OdtyibIiU0ksqYJs=;
 b=CrLQTySX5QCNQEQ1fQQ7mJAOh8MvNNACbLUSxK5oo9aGVs/YYAmPTEkpfZ9DztA86EnydR
 1zrTFrnBRA14Lm6B9L1DDewkjL2brgAznDgzQD9N45n2DaSkZWJQx8Hf7JArwwMCpqVcHD
 Jzb23xMoiNfFIIaqTRooDsPiVexCIKA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-AJkTxxWxPZ63ZMeTyo63Mw-1; Tue, 24 Mar 2026 05:16:13 -0400
X-MC-Unique: AJkTxxWxPZ63ZMeTyo63Mw-1
X-Mimecast-MFC-AGG-ID: AJkTxxWxPZ63ZMeTyo63Mw_1774343773
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-79ac1a4fac7so17619357b3.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 02:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774343772; cv=none;
 d=google.com; s=arc-20240605;
 b=bvBfYGBCb4dyYQMSSvQMc4KcqlR+pE8vXazbMrQD+Ih/PgSOORdwlvOevCwEWaZN21
 JfvxUtFfU5hHBVC7mLl7kaE4DNeDFo1KllaDqa/YdbWW3TxMgbp9f9KmkTRb6nnXvOTl
 ACnv1w5eyjfx5xRtr3MzqoQEzczkBCeFpc7VLHUeuQLpNdHCtYtMvRmeNz4mrb9hBKhO
 XkIBE1uAWygHpYrqteeF7wKpsLXV43rljnbltxBR8keTEQGFxWRbl/ENnCDedowR+4/G
 mvk3FW0/aWAXyTMdKrqdegdlQCdqsXcQ8UIoYWr/TSQdNSVgpSxbedEFA0Y5/h/6iwiB
 +Z8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5ifbEUdQKkyeOEeDTOmyPLT4aw2OdtyibIiU0ksqYJs=;
 fh=MOh7kRP1KX0eTM3fzbwY/EAeiCJv1UAt0/pYCkGu3uI=;
 b=exP8WNDFiqkDp3W9fskp5CE1Tc6l+06U90iEu4amRmIxsEyeQ0bbf6I/62JdHfA4eZ
 WHO1nfOV1nYpM+Rt4q9172/BVaVr/cA2I608IGMDJP+BvgXEDjgioT93grHqw6ry1G1m
 OiY0mZ8wH+d392KXCgjqirzpsCk+13Ro/+mCQefyGPeOTlzIAEHZdQ+TCXdSvfDTHsTI
 /m5kKzfdHe5vY8sp/lWCKykz8jG3QZsXJhzOSOZol9iLGgt9yTSV6ttmJpUXO6DFEBvY
 pdbYbvpwF+wSPso8METT7/Z5ccp5SUicBgk4Mh5SnoifUVVzKNYO8Q5PCz31mqG35Awi
 9vWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774343772; x=1774948572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ifbEUdQKkyeOEeDTOmyPLT4aw2OdtyibIiU0ksqYJs=;
 b=NTvIcTDl+NBuPupL+fUPtyjowu63ssTzv+g3XIlmVSNy6d06ogrWvZ5dkuVctQJ4Bn
 HL+VNxXVy60OZpCq72a2HSN+spRLljQtThITcM465Yx9ioHIQTsFWClDeqVtwbsXCYTT
 5BauFh/G8mFHJX4kd4lB+5zF4Avf8BONyez/LUJDzP8azUlSLp9A3ky+3OFj1Fyo+iyC
 29aK+bSuH2J+YWAmkBQPCS9KbYEH6f8wV/ilTBBfDvBIizTz46fIy7IjVAeowxhn7W17
 qwwc55TH9BvOKkVAtYcj+Fsap5sggq0U1MQvpC7oB/LJR42LfbWeuIyW4O3FtcWWWmX/
 L5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774343772; x=1774948572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ifbEUdQKkyeOEeDTOmyPLT4aw2OdtyibIiU0ksqYJs=;
 b=AbhksQbCn3m7o3/CGMJix18YzhZzZW8fNOfxbTj6F6PFRdQ+gkGyDVf77uepEhfFDp
 wTivmsPTHD0OFrXcbgsG3CCRS6AQEVRPTXZ55LWk/jFM0zIBa1hfICxBq9Md0qwzE6xo
 sjv1DTeQ4IEcBmV3Sd77sf2KFpHIFQKENlp/Qzv1+t2l4is2u1mA97b0P6dAqfbVLlkl
 XiZkIvrYMnpoOwWq1rMlCIsQCI4yN7RyB7OCkZ/ZzlDsLPVBPJNxGHPZQX0hgJpBBvjV
 gCKNfgqBkS7yV+cQ+xR0ykMtv8eT1jcDKBxDS7iD8x76mCdxHRClVWErIfYuv4UJA2cb
 ZeDA==
X-Gm-Message-State: AOJu0Yxz1kb2tplzx7AL/NOIk2buVvME9NsE/stKAI8xBySy9b4c+ZrM
 S90TiIhY1LsISLREIdgLn2aAXGjMP59C+xmLdsC9zeuUNskjcHaLgue6/iCm1dkpSnfqs7LyMtZ
 pz7lM3j8ZF+WQ3/tV9wGjwUQUgrcWR1BLFPZFz3nw3HF3WZb4C+BJA0TDsLo+sHxKHe6BnASPYy
 DcCtaoCM189zG6pVzEcsvLh4twC9EKw/E=
X-Gm-Gg: ATEYQzzhAXEvtLAqBwsOVAtZplJ1fsU/cPn6my7rsvxBPcEqzwu48lhOeyVmxfelAOn
 IYSIxTtn5rE6h3dCEXQhZRI+uWeKQiHpuvvCeKYq/kYGtNtV3makk2dIM5x0a43A8SFUCDU1iMc
 2YOrRl10Eo66yP+v0lVBsU3wWv40BJrTJBBvMHMsn+bpvfV0xJknLR4lq9Q3nhu6Se9ARzHW4yw
 KvNaA==
X-Received: by 2002:a05:690c:89:b0:79a:b49a:cb14 with SMTP id
 00721157ae682-79ab49ad764mr70825727b3.24.1774343772304; 
 Tue, 24 Mar 2026 02:16:12 -0700 (PDT)
X-Received: by 2002:a05:690c:89:b0:79a:b49a:cb14 with SMTP id
 00721157ae682-79ab49ad764mr70825397b3.24.1774343771762; Tue, 24 Mar 2026
 02:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260322195624.381837-1-kdutta@redhat.com>
In-Reply-To: <20260322195624.381837-1-kdutta@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 24 Mar 2026 10:15:34 +0100
X-Gm-Features: AaiRm52QIZRgq6BzloD65KFqBDJQ6Vmka1FYDpr-6Zq_48w8sEshxYI9L9tTKgw
Message-ID: <CAJaqyWfgQVJF3tmXDQ2vjgth1X6P3rVPn0f+LygJERqWb733NA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/net/virtio-net: add support for notification
 coalescing
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Mar 22, 2026 at 8:56=E2=80=AFPM Koushik Dutta <kdutta@redhat.com> w=
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
> This reduces interrupt overhead by batching notifications based on
> either a packet count or a time-based threshold.
>
> Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> ---
>  hw/net/virtio-net.c                | 133 +++++++++++++++++++++++++----
>  hw/virtio/vhost-shadow-virtqueue.c |   1 +
>  hw/virtio/vhost-vdpa.c             |   3 +
>  include/hw/virtio/virtio-net.h     |   8 ++
>  net/vhost-vdpa.c                   |   7 ++
>  5 files changed, 135 insertions(+), 17 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index eccb48ad42..5fb61944f1 100644
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
> @@ -1081,6 +1090,33 @@ static int virtio_net_handle_offloads(VirtIONet *n=
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
> +        if (!n->rx_index_timer) {
> +            n->rx_index_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                             virtio_net_rx_notify, n);
> +        }
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
> @@ -1582,6 +1618,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vde=
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
> @@ -2041,7 +2079,24 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
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
> +        virtio_net_rx_notify(n);
> +    } else {
> +        if (!n->rx_index_timer) {
> +            n->rx_index_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                             virtio_net_rx_notify, n);

Let's move the creation of the timer to the CVQ handling, so the
malloc is out of the datapath.

> +        }
> +        if (!timer_pending(n->rx_index_timer)) {
> +            timer_mod(n->rx_index_timer,
> +                      qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_coal=
_usecs);
> +        }
> +    }
>
>      return size;
>
> @@ -2900,6 +2955,12 @@ static void virtio_net_tx_timer(void *opaque)
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
> @@ -2919,6 +2980,7 @@ static void virtio_net_tx_timer(void *opaque)
>      ret =3D virtio_net_flush_tx(q);
>      if (ret > 0) {
>          virtio_queue_set_notification(q->tx_vq, 0);
> +        n->tx_pkt_cnt -=3D ret;
>          q->tx_waiting =3D 1;
>          timer_mod(q->tx_timer,
>                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> @@ -2974,27 +3036,50 @@ static void virtio_net_tx_bh(void *opaque)
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
> +    n->tx_pkt_cnt++;
> +    if (use_timer) {
> +        if (!pkt_limit || n->tx_pkt_cnt < n->tx_coal_packets) {
> +            if (!q->tx_timer) {
> +                q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                           virtio_net_tx_timer,
> +                                           q);

Same here, let's create in either CVQ handling or the queue creation.

Combining the "tx_timer" command-line argument and the guest's
handling of coalescing is difficult. Maybe we should forbid enabling
both of them simultaneously? Jason, MST, what do you think?

In my opinion it would be:
* By default, the virtio feature is enabled and the tx_timer is false.
* If you want to enable only host side coalescing with tx_timer, you
must explicitly set vq_notf_coal feature to off.

But this causes you to need to change the command line if you spawn a
new QEMU instance with the old cmdline parameters if you have
tx_timer=3DN. Live migration should be ok since `vq_notf_coal` is set to
off from the previous machine type.

That's something that needs to be added in this patch.
hw/core/machine.c changes to know that old machines have that off,
like the commit 1c79ab6937ae938d3dfd4da1c01afc7eb599857e ("virtio-net:
Advertise UDP tunnel GSO support by default") for example.

> +            }
> +            virtio_net_handle_tx_timer(vdev, vq);
> +        } else {
> +            n->tx_pkt_cnt =3D 0;
> +            virtio_net_handle_tx_bh(vdev, vq);
> +        }
> +    } else {
> +        virtio_net_handle_tx_bh(vdev, vq);
> +    }
> +}
> +
>  static void virtio_net_add_queue(VirtIONet *n, int index)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>
> -    n->vqs[index].rx_vq =3D virtio_add_queue(vdev, n->net_conf.rx_queue_=
size,
> -                                           virtio_net_handle_rx);
> +    n->vqs[index].rx_vq =3D
> +        virtio_add_queue(vdev,
> +                         n->net_conf.rx_queue_size,
> +                         virtio_net_handle_rx);

This is just a formatting change, let's omit it so the patch contains
the fewest lines changed possible.

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
> @@ -3089,6 +3174,7 @@ static void virtio_net_get_features(VirtIODevice *v=
dev, uint64_t *features,
>      virtio_features_or(features, features, n->host_features_ex);
>
>      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> +    virtio_add_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);

This adds the feature unconditionally even if "vq_notf_coal" is set to
off. This change needs to be removed.

>
>      if (!peer_has_vnet_hdr(n)) {
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> @@ -3972,6 +4058,10 @@ static void virtio_net_device_realize(DeviceState =
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
> @@ -4048,6 +4138,13 @@ static void virtio_net_device_realize(DeviceState =
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
> @@ -4262,6 +4359,8 @@ static const Property virtio_net_properties[] =3D {
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

This patch does not implement the reset feature in SVQ, so this change
needs to be removed.

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

Same here, this change does not add the notif_coal features to all
existing vdpa devices. So this change needs to be removed.

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
> index 3df6091274..3fef894d8d 100644
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
> @@ -115,6 +116,12 @@ static const uint64_t vdpa_svq_device_features =3D
>      BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
>      BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
>      BIT_ULL(VIRTIO_NET_F_STATUS) |
> +    BIT_ULL(VIRTIO_F_RING_RESET) |
> +    BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
> +    BIT_ULL(VIRTIO_NET_F_GUEST_USO6) |
> +    BIT_ULL(VIRTIO_NET_F_HOST_USO) |
> +    BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) |
> +    BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |

The same applies to all these features.

>      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
>      BIT_ULL(VIRTIO_NET_F_GSO) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
> --
> 2.53.0
>


