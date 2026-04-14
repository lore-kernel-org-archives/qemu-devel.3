Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701B1F9D0D3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 14:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCeiG-0002pq-3u; Tue, 14 Apr 2026 10:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wCeiF-0002pi-2o
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 10:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wCeiB-0007rH-Vg
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 10:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776176754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0tedh0ex/YXOWLzTGig5NTFylSbjMJGnZxG8WHADgs=;
 b=HvzhJXAY1RdokeKydSWLGg7G64wXrqqoRZLNI2dSUpcCr/NIucSH3JsAkH+9ksSIANHVB7
 y6U2PuopzR1W8VtlHVJivcgBNJ2dEz6j+dcAXqFr4G3hpYKrqa0Bsi7J+4kAoMGH0Gw4zG
 NnAdiXoflDbXsCVLLJ3It92UpOit5V4=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-yCIy6VZuN_Ou0Rljg4olzQ-1; Tue, 14 Apr 2026 10:25:53 -0400
X-MC-Unique: yCIy6VZuN_Ou0Rljg4olzQ-1
X-Mimecast-MFC-AGG-ID: yCIy6VZuN_Ou0Rljg4olzQ_1776176752
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-651c4c4df1aso4748393d50.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 07:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776176752; cv=none;
 d=google.com; s=arc-20240605;
 b=hHk1D/YURXKn+TQkP2FU4w/QWOjYeaVql51tVb28SET5Qdgq6dtBUb+Qle/B/Gw9ZB
 MpGkNor7ujejk3Tu2GBuojksmKpGZLtHneHGLp1iiF8ERjJT3P2+uK5bGZqh98KiYPn0
 6ZTKDozsMAFn6LnxjKOOhPwWC0ZyFCstsox3rz3RItpzD63MYO5RRjudsDLHID3TyxKk
 ZvJM1ucyc/nC54bXGvaQftY9sFpl2cTBC7FljJV2U7K0aXtZDZkcKgUQ6nR/jPMhj06h
 RLX/K8DL2ZMmF/cvl0rnnLizxAlSNIeL/rBvYW7bRKQ5+hHVmcmajMm0/mly9xJGff8B
 l7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I0tedh0ex/YXOWLzTGig5NTFylSbjMJGnZxG8WHADgs=;
 fh=zgGnWcT/ulYH8APAM2M9+s2IND3POZMAbr8rRTECX3M=;
 b=I/97+KLD3q2xruSQZFfzXyP4nuKzKI5tpHBFXyCSWNucKH16Peq/QZJYh0dRsTPEBy
 ZO5+DRYczkEsrGxgtxyRo6W5G5XqQLKJXe9yKSifjYwUJvh1sUqUCh1wJAc7ttNUnp2l
 G6DkTNWzm02OD1XHiVfGXDJpVvhdaZS1tj2Srv7OgNbCxpoUwMT4LQXTY+IOeQkd5o0H
 H8yASB2WFM3Tw+mLlyE03JFZqZlcMWIugpdJLkoEAihKD3nWZcsyTocIr3xaU5FUNLa0
 R8cqIb0FOztuq+CsLc5qWi+ldajyHtw0NSehtuJNW8h4uK2ExnU40nSsyAYyx876rh/3
 IYAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776176752; x=1776781552; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0tedh0ex/YXOWLzTGig5NTFylSbjMJGnZxG8WHADgs=;
 b=puiR6CaB9ayiajAuQ2kYwDd/e9qQ1LEtYTfZlRNAQMTehO3OVHRqXD1TH09A45reoV
 wlMfwSsncFo2Hvh73AqN/FwiNzQtjEYtkRVZMN7iKCAEEFAiIYfFaWV1+uMe7hyON2Uo
 EWCz+gSgMwRW8T2xiVhuEIVy/yzKyOs/52k7q2cVZAgIbj7b1XGfzpojrwhXtk5UJK9P
 SCZviLlPMbYlpY4EO1pUddbT+tZCRpiCmD58SzZiMH3G+HgJUiTRwY7B6XwoFccYYJUL
 Xk6Jvb0NElF0fgccGZQcbUC0AuxSA03ZrluIzUEM3niaJsPvr27MiPfJfIQ8zqgioqLC
 /6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776176752; x=1776781552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I0tedh0ex/YXOWLzTGig5NTFylSbjMJGnZxG8WHADgs=;
 b=ceE6xQmpOsmRVSwmZCocVEh+6iVBWeHmZNEgezAqUxmL7TUMTZLITDBT+ADIpnkww/
 lxK5ZdUVE4om6hiOOzyC5YhR3Lz/CoTMrb5TejlJpBJ1Yfo2OB54wvjSF1MZJVIl4Y4l
 ORclvUYnszx4O4oOIngY5BXq8W+lVyRECe1Ird64eU2+j2MhLtb9bOymKS8IxF7w5XSA
 AV1m1CVGnm2+1KC2JQgRZ+ljvYCaZqEehPprbxZhsd3hioUmJH2ky+3RWswNXK9nWNnq
 af1Po5DDJHYBeXQzNDMipax9W0b1fhA/61Ws8QsIaarqDhAUKRKei+h/vXYeuaDIQhke
 tRbQ==
X-Gm-Message-State: AOJu0YxS8DEbQaWVlvmQpZJDKNYGM+B1wtUHzQ3wD2xb/2N5EohmtjEN
 JKPyRdHkKtJvjMhyh4ddupNDTv0tcYxpAl6IlxAsPqcuj73Lbo39tF97YhbfghUwL4J3OZExTt8
 d04ct3JqXMOGEfDTU+y18FC6qF0eSdw760AxeWih1nNNL41cgORgvuBL//grKsVlYRB3EKI8aj0
 4Z8sQU801X2kS3MD07HvqiWkhjiMY8iig=
X-Gm-Gg: AeBDiesdsUcDKxhbwKwKljzfADbKWTh51d2EkZiK0VUWCFTBw3QZWxhaEWfD9RkMa/1
 uecDV5Oe0SjcFpI1R9C1xd+xerDccQBwDGEYpkPAHIKjZqPAKtwmy4vKne3HOF8ytJSg147JP2m
 nLoKRvPQxWiITkU+giNaBOBrm0llvO/12Aa1X6+Eeaa/1lUljX3G7bZq24IEHMZ5YxyZ48hv10w
 /Y=
X-Received: by 2002:a53:d110:0:b0:651:9286:578a with SMTP id
 956f58d0204a3-65198a8aa06mr12515463d50.25.1776176752311; 
 Tue, 14 Apr 2026 07:25:52 -0700 (PDT)
X-Received: by 2002:a53:d110:0:b0:651:9286:578a with SMTP id
 956f58d0204a3-65198a8aa06mr12515434d50.25.1776176751690; Tue, 14 Apr 2026
 07:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260413121348.655887-1-kdutta@redhat.com>
In-Reply-To: <20260413121348.655887-1-kdutta@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 14 Apr 2026 16:25:15 +0200
X-Gm-Features: AQROBzA4bevkuCxlb9_0d9VGUZA_gxXIWvA26cW02_j2CBq0DVt4BzFyqq0mw9w
Message-ID: <CAJaqyWekxXAqacufabHeuhSnSf4veSoQ4nZ73XKnSgvMyjD7kw@mail.gmail.com>
Subject: Re: [PATCH v5] hw/net/virtio-net: add support for notification
 coalescing
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Apr 13, 2026 at 2:13=E2=80=AFPM Koushik Dutta <kdutta@redhat.com> w=
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
> - After VM LM coalescing parameters persist in the destination VM.
>
> This reduces interrupt overhead by batching notifications based on
> either a packet count or a time-based threshold.
>
> Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> ---
>  hw/net/virtio-net.c            | 180 ++++++++++++++++++++++++++++++---
>  include/hw/virtio/virtio-net.h |   9 ++
>  net/passt.c                    |   1 +
>  net/tap.c                      |   1 +
>  net/vhost-user.c               |   1 +
>  net/vhost-vdpa.c               |   2 +
>  6 files changed, 178 insertions(+), 16 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2a5d642a64..a15e9d17bd 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -157,6 +157,16 @@ static void flush_or_purge_queued_packets(NetClientS=
tate *nc)
>   * - we could suppress RX interrupt if we were so inclined.
>   */
>
> +static void virtio_net_rx_notify(void *opaque)
> +{
> +    VirtIONetQueue *q =3D opaque;
> +    VirtIONet *n =3D q->n;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    n->rx_pkt_cnt =3D 0;
> +    virtio_notify(vdev, q->rx_vq);
> +}
> +
>  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
>      VirtIONet *n =3D VIRTIO_NET(vdev);
> @@ -1080,6 +1090,53 @@ static int virtio_net_handle_offloads(VirtIONet *n=
, uint8_t cmd,
>      }
>  }
>
> +static void virtio_net_tx_timer(void *opaque);
> +
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
> +        if (n->rx_coal_usecs > 0) {
> +            for (i =3D 0; i < n->max_queue_pairs; i++) {
> +                q =3D &n->vqs[i];
> +                if (!q->rx_timer) {
> +                    q->rx_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                               virtio_net_rx_notify,
> +                                               q);
> +                }
> +            }
> +        }

If we allocate the timer timer if rx_coal_usecs > 0, should we also
timer_free it if rx_coal_usecs =3D=3D 0? The same question goes to
tx_timer actually.

Also, virtio_net_del_queue should free rx_timer should be freed the
same way as q->tx_timer.


> +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
> +        if (n->tx_coal_usecs > 0) {
> +            for (i =3D 0; i < n->max_queue_pairs; i++) {
> +                q =3D &n->vqs[i];
> +                if (!q->tx_timer && n->tx_coal_usecs > 0) {
> +                    q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                               virtio_net_tx_timer,
> +                                               q);
> +                }
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
> @@ -1581,6 +1638,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vde=
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
> @@ -2040,7 +2099,22 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
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
> +        if (q->rx_timer) {
> +            timer_del(q->rx_timer);
> +        }
> +        virtio_net_rx_notify(q);
> +    } else {
> +        if (q->rx_timer) {
> +            if (!timer_pending(q->rx_timer)) {
> +                timer_mod(q->rx_timer,
> +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_=
coal_usecs);
> +            }
> +        }
> +    }
>
>      return size;
>
> @@ -2817,7 +2891,6 @@ detach:
>      return -EINVAL;
>  }
>
> -static void virtio_net_tx_timer(void *opaque);
>
>  static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq=
)
>  {
> @@ -2899,6 +2972,12 @@ static void virtio_net_tx_timer(void *opaque)
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
> @@ -2918,6 +2997,7 @@ static void virtio_net_tx_timer(void *opaque)
>      ret =3D virtio_net_flush_tx(q);
>      if (ret > 0) {
>          virtio_queue_set_notification(q->tx_vq, 0);
> +        n->tx_pkt_cnt -=3D ret;
>          q->tx_waiting =3D 1;
>          timer_mod(q->tx_timer,
>                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> @@ -2973,6 +3053,32 @@ static void virtio_net_tx_bh(void *opaque)
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
> @@ -2980,20 +3086,15 @@ static void virtio_net_add_queue(VirtIONet *n, in=
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
> @@ -3242,6 +3343,36 @@ static int virtio_net_post_load_device(void *opaqu=
e, int version_id)
>      }
>
>      virtio_net_commit_rss_config(n);
> +    if (n->tx_coal_usecs > 0 || n->rx_coal_usecs > 0) {
> +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
> +
> +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> +            VirtIONetQueue *q =3D &n->vqs[i];
> +            if (!q->rx_timer && n->rx_coal_usecs > 0) {
> +                q->rx_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                           virtio_net_rx_notify,
> +                                           q);
> +            }
> +
> +            if (!q->tx_timer && n->tx_coal_usecs > 0) {
> +                q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                           virtio_net_tx_timer,
> +                                           q);
> +            }
> +
> +            if (n->tx_coal_usecs > 0 && q->tx_timer) {
> +                n->tx_pkt_cnt =3D 0;
> +                timer_mod(q->tx_timer,
> +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_=
timeout);
> +            }
> +
> +            if (n->rx_coal_usecs > 0 && q->rx_timer) {
> +                timer_mod(q->rx_timer,
> +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_=
coal_usecs);
> +            }
> +        }
> +    }
> +
>      return 0;
>  }
>
> @@ -3617,6 +3748,10 @@ static const VMStateDescription vmstate_virtio_net=
_device =3D {
>                           vmstate_virtio_net_tx_waiting),
>          VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
>                              has_ctrl_guest_offloads),
> +        VMSTATE_UINT32(rx_coal_usecs, VirtIONet),
> +        VMSTATE_UINT32(tx_coal_usecs, VirtIONet),
> +        VMSTATE_UINT32(rx_coal_packets, VirtIONet),
> +        VMSTATE_UINT32(tx_coal_packets, VirtIONet),
>          VMSTATE_END_OF_LIST()
>      },
>      .subsections =3D (const VMStateDescription * const []) {
> @@ -3970,6 +4105,10 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>          error_printf("Defaulting to \"bh\"");
>      }
>
> +    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")) {
> +        n->tx_timer_activate =3D true;
> +    }
> +

I still think we should disable the coalescing feature if the "timer"
command line is enabled. Otherwise the guest can override the
parameter, which is technically doable but I think it's not a desired
behavior. MST, what do you think?

>      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
>                                      n->net_conf.tx_queue_size);
>
> @@ -4046,6 +4185,13 @@ static void virtio_net_device_realize(DeviceState =
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
> @@ -4258,6 +4404,8 @@ static const Property virtio_net_properties[] =3D {
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
> index 371e376428..d88f8aef87 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -158,6 +158,7 @@ typedef struct VirtioNetRssData {
>  typedef struct VirtIONetQueue {
>      VirtQueue *rx_vq;
>      VirtQueue *tx_vq;
> +    QEMUTimer *rx_timer;
>      QEMUTimer *tx_timer;
>      QEMUBH *tx_bh;
>      uint32_t tx_waiting;
> @@ -230,6 +231,14 @@ struct VirtIONet {
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
> diff --git a/net/passt.c b/net/passt.c
> index 4ff94ee509..0b0d9e222a 100644
> --- a/net/passt.c
> +++ b/net/passt.c
> @@ -52,6 +52,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_NET_F_GUEST_USO4,
>      VIRTIO_NET_F_GUEST_USO6,
>      VIRTIO_NET_F_HOST_USO,
> +    VIRTIO_NET_F_NOTF_COAL,
>
>      /* This bit implies RARP isn't sent by QEMU out of band */
>      VIRTIO_NET_F_GUEST_ANNOUNCE,
> diff --git a/net/tap.c b/net/tap.c
> index 8d7ab6ba6f..ea5987a3dc 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -62,6 +62,7 @@ static const int kernel_feature_bits[] =3D {
>      VIRTIO_F_NOTIFICATION_DATA,
>      VIRTIO_NET_F_RSC_EXT,
>      VIRTIO_NET_F_HASH_REPORT,
> +    VIRTIO_NET_F_NOTF_COAL,
>      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
>      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
>      VHOST_INVALID_FEATURE_BIT
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index a4bb49bbcf..f0b3752d7c 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -54,6 +54,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_NET_F_GUEST_USO4,
>      VIRTIO_NET_F_GUEST_USO6,
>      VIRTIO_NET_F_HOST_USO,
> +    VIRTIO_NET_F_NOTF_COAL,
>
>      /* This bit implies RARP isn't sent by QEMU out of band */
>      VIRTIO_NET_F_GUEST_ANNOUNCE,
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

This patch does not enable SVQ to handle NOTF_COAL, so this addition is inv=
alid.

>      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
>      BIT_ULL(VIRTIO_NET_F_GSO) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
> --
> 2.53.0
>


