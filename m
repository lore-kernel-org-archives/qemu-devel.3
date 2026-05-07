Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA3DCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 11:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKwnc-0000bn-KL; Thu, 07 May 2026 07:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wKwna-0000bW-0R
 for qemu-devel@nongnu.org; Thu, 07 May 2026 07:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wKwnW-0008QE-NU
 for qemu-devel@nongnu.org; Thu, 07 May 2026 07:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778152900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTU7tUGIlYbT4OyZMjhU/0KnQj19aY1ei48bc6uJJJw=;
 b=OxslMeD7Gi/2/DBbR9wYTuTcrWfXcdwH9JmNVlBhYNfZ0sF7ZsAqS05vV8QGNPfCwLqASA
 dupQiSlnzUHz5xiqUtjIWfpNT2cCYFBqsm6dKqQ4F027qu5jbQdKs9RUdEtu5hEgfQMBty
 NetbqNDdDEGhZPYRweQL9TUT9wrbfjs=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637--1kxDuuMOEeEOEZ6XsDLHg-1; Thu, 07 May 2026 07:21:38 -0400
X-MC-Unique: -1kxDuuMOEeEOEZ6XsDLHg-1
X-Mimecast-MFC-AGG-ID: -1kxDuuMOEeEOEZ6XsDLHg_1778152898
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-65c7306e432so1198838d50.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 04:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778152898; cv=none;
 d=google.com; s=arc-20240605;
 b=hfEUsNYKv0bPDDkCFUwjp8DF0Qc4dzLiR637TBLelduFfqjd97I2BA+cuqDP80K31K
 QYFQ9CbN/jh+K/7jEuGh1CSC/+uyieJ/XOIipMk9sdrdxPVsvrGoxJvrqAGDTczn0rMw
 OLZn7Qg35KO3ampUeP6QNOiIDg4lHQ3npN2YeMtrxTE8uR0/eW7QJMGcv/S/PsbTpl+V
 JqgkDL0SLUn8OkS2NEQ8x46ezJAKQcrEayBOiW4mGWVPYOUIxjn8OhPCOungxQvB6EHZ
 kedUMiccHL7Db+ZZ/RYxpp9SNn0tUh2EIzeTC/vQf93ozzQH6IWMWTbw0yc6kNG+Iire
 jmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aTU7tUGIlYbT4OyZMjhU/0KnQj19aY1ei48bc6uJJJw=;
 fh=2j1OPIc+H3IgInHX+gBxX5VNmvDfIM4Z/c1hsqkYxuE=;
 b=bAbYFEHKe9Ikc4ac6fvhvvStP+yMy/aTPhFoy6tu0yTNV79iykD45XwXT6pwrt9RB6
 QvrhvRf3eUIpfDYyOotWb0+RMn4+/+4r3/DpGaLMgwAdnN6dHee3Qf7QQJMHY1RTgzo8
 Oy2yunBkjrhWb0Omfzdf6Pu7M1O9w5/TB6glNjMvudaYmPow40IMTlhjxUJA/EE8tMER
 qKfzG1sY/I+gAam7Piu2vRv3XkDp4vvPpsnwUQJds+EjqOlP47M1llFeaoJdno6MwHbI
 neocIf75VWs4oMS+cOpGtccM0e50JBWJpuYF1x6wfr8ylxVwF58jQ7a8ToMWFtOaekOI
 WusQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778152898; x=1778757698; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTU7tUGIlYbT4OyZMjhU/0KnQj19aY1ei48bc6uJJJw=;
 b=Vq5ayXkvm1Utek1+Hlsj1I9PWMWjbY9Vnfllr8N6AK+4F3yIGuxWXvA+WB7y+g+mhD
 Rvk2JIPPC4KNA8BH7p4kHHfXfBDlIk3H+OdNmPgQIW6G7JCtcazniveutPJGJ6n2+v4U
 ie9yGwWIznhep1hhvwsLZC/G0izvh39hc1904gI8kfJlYYjehx0q1MSzdkykRiIgs5fN
 jvqSfZEV1LrfUR2joThuV8wg/kIbo/PZVBl59N1e0dpCo1ak6Uz0qZHFA3TPFSeRXksM
 KqUGEboIQNL89FzbanvhzDgfcSunTBv6u8kJURcNjjJPCM31l1r6QiflAOo7+o2XZ32I
 DqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778152898; x=1778757698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aTU7tUGIlYbT4OyZMjhU/0KnQj19aY1ei48bc6uJJJw=;
 b=eqkYCtszSk49Sp7zeh0GUIzlDJJSL7lmfwN8s88HGAeI42XAIEJ3+Hwe0K3sjWr3At
 HC+jZcJC/9QkzKUpJdR23Jy0AznACe5WIOh/8Kp7YPcFU7gCiuRjpbp0ncO6zj4++upN
 FDXY+1gMbLyQNw2akA9PpgmLdCsLGTkbNr6U851N1xrxqPMhNARQekYAwpRwjC5Ky5eT
 TAiq+BG+eyHRycyHIHZQj6tSgXQzO8SCPKbdrxZU1C6mI4Tp5que8WQIO+WBYZ9Fs+nu
 7rKlBALOIs3+3nSVVR48VyKOqxXwRatAbYzv3Lx8CbzQ0Pl+BgwjnBfBlxz5WGiNkMWw
 yllQ==
X-Gm-Message-State: AOJu0YzwwmjZpQhDNsl0qKqUjXG/AHLM9JRoXMOelMe2M4n7m6aZBHJW
 qid1WD9AYOSLsGukt7rOoFEVFZPvNIEz/VBVoAMRLuxI75tQ25iu6yAql8U5TuqgZ2UAfJjXwpE
 0497uBKYyWQROkViAeAwKOtjmNiFQQKEUfEI7B3tfVn+7IKnJ1Qmsc7L+s6h2nOzivAzwSqpYV5
 dSWqwTDd5zDfqxgz1CktmTVKYVcaTC4eU=
X-Gm-Gg: Acq92OHTTufIFa/3oN+TEiadgWi2pdq2uRB/C/RZ1jbF/4/olHUTpNteOICV9IQGf3E
 taXtDaKP/53e0ut6gKqdW97pj86RmHpz4hggVkumvzXxisR+AfCF1gJwfh92LxCTDaIcxkxidSs
 R7gLPoOrCbg7s42fcX3CAAM3nOSRa+DHR7UCbAcO8e+rRfDj9a8FpF7Or986kiJDsb2PGDJ+QrA
 sMjB6+a2ahN9n0NDaJIi7RbKuF4DcyRM91fbYerqLaNng0sBKA=
X-Received: by 2002:a05:690e:120b:b0:64e:f106:60ee with SMTP id
 956f58d0204a3-65c799d57c0mr7364731d50.55.1778152897960; 
 Thu, 07 May 2026 04:21:37 -0700 (PDT)
X-Received: by 2002:a05:690e:120b:b0:64e:f106:60ee with SMTP id
 956f58d0204a3-65c799d57c0mr7364685d50.55.1778152897292; Thu, 07 May 2026
 04:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260504091842.1406602-1-kdutta@redhat.com>
In-Reply-To: <20260504091842.1406602-1-kdutta@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 7 May 2026 13:21:00 +0200
X-Gm-Features: AVHnY4KOeaG2qy6c3xjiOdtm7JF5kBztuj-xIeFCtJGBcRT0ZqWSzIyS2pYFkew
Message-ID: <CAJaqyWeGJdn76XTH-Z+hwVgQEsbYnaCEAeq=vy=p869MNsiBHA@mail.gmail.com>
Subject: Re: [PATCH v6] hw/net/virtio-net: add support for notification
 coalescing
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, May 4, 2026 at 11:18=E2=80=AFAM Koushik Dutta <kdutta@redhat.com> w=
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

Please include a changelog across the different versions of the series.

> ---
>  hw/net/virtio-net.c            | 193 +++++++++++++++++++++++++++++----
>  include/hw/virtio/virtio-net.h |  10 +-
>  net/passt.c                    |   1 +
>  net/tap.c                      |   1 +
>  net/vhost-user.c               |   1 +
>  net/vhost-vdpa.c               |   1 +
>  6 files changed, 184 insertions(+), 23 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2a5d642a64..aabba6a4be 100644
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
> @@ -435,7 +445,7 @@ static int virtio_net_set_status(struct VirtIODevice =
*vdev, uint8_t status)
>          if (queue_started) {
>              if (q->tx_timer) {
>                  timer_mod(q->tx_timer,
> -                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n=
->tx_timeout);
> +                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n=
->tx_coal_usecs);

This is adding up ns + us, different units. We need to stick with us,
as the command-line parameter was already in us.

>              } else {
>                  replay_bh_schedule_event(q->tx_bh);
>              }
> @@ -1080,6 +1090,52 @@ static int virtio_net_handle_offloads(VirtIONet *n=
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
> +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs) * 1000;
> +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
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
> @@ -1581,6 +1637,10 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vd=
ev,
>          status =3D virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
>      } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
>          status =3D virtio_net_handle_offloads(n, ctrl.cmd, iov, out_num)=
;
> +    } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_NOTF_COAL) {
> +        if (!n->tx_timer_activate) {

Even if the feature is best effort I think it is better not to forward
the feature flag either.

> +            status =3D virtio_net_handle_coal(n, ctrl.cmd, iov, out_num)=
;
> +        }
>      }
>
>      s =3D iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
> @@ -2040,7 +2100,22 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
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
> @@ -2708,7 +2783,7 @@ static void virtio_net_tx_complete(NetClientState *=
nc, ssize_t len)
>              replay_bh_schedule_event(q->tx_bh);
>          } else {
>              timer_mod(q->tx_timer,
> -                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_time=
out);
> +                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_coal=
_usecs);
>          }
>          q->tx_waiting =3D 1;
>      }
> @@ -2817,7 +2892,6 @@ detach:
>      return -EINVAL;
>  }
>
> -static void virtio_net_tx_timer(void *opaque);
>
>  static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq=
)
>  {
> @@ -2842,7 +2916,7 @@ static void virtio_net_handle_tx_timer(VirtIODevice=
 *vdev, VirtQueue *vq)
>      } else {
>          /* re-arm timer to flush it (and more) on next tick */
>          timer_mod(q->tx_timer,
> -                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_coal_use=
cs);
>          q->tx_waiting =3D 1;
>          virtio_queue_set_notification(vq, 0);
>      }
> @@ -2899,6 +2973,12 @@ static void virtio_net_tx_timer(void *opaque)
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
> @@ -2906,7 +2986,7 @@ static void virtio_net_tx_timer(void *opaque)
>      if (ret >=3D n->tx_burst) {
>          q->tx_waiting =3D 1;
>          timer_mod(q->tx_timer,
> -                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_coal_use=
cs);
>          return;
>      }
>      /*
> @@ -2918,9 +2998,10 @@ static void virtio_net_tx_timer(void *opaque)
>      ret =3D virtio_net_flush_tx(q);
>      if (ret > 0) {
>          virtio_queue_set_notification(q->tx_vq, 0);
> +        n->tx_pkt_cnt -=3D ret;
>          q->tx_waiting =3D 1;
>          timer_mod(q->tx_timer,
> -                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_coal_use=
cs);
>      }
>  }
>
> @@ -2973,6 +3054,32 @@ static void virtio_net_tx_bh(void *opaque)
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
> @@ -2980,20 +3087,15 @@ static void virtio_net_add_queue(VirtIONet *n, in=
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
> @@ -3242,6 +3344,35 @@ static int virtio_net_post_load_device(void *opaqu=
e, int version_id)
>      }
>
>      virtio_net_commit_rss_config(n);
> +    if (n->tx_coal_usecs > 0 || n->rx_coal_usecs > 0) {
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
coal_usecs);
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
> @@ -3960,7 +4095,6 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>      }
>      n->vqs =3D g_new0(VirtIONetQueue, n->max_queue_pairs);
>      n->curr_queue_pairs =3D 1;
> -    n->tx_timeout =3D n->net_conf.txtimer;
>
>      if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")
>                         && strcmp(n->net_conf.tx, "bh")) {
> @@ -3970,6 +4104,13 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>          error_printf("Defaulting to \"bh\"");
>      }
>
> +    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") =3D=3D 0) {
> +        n->tx_coal_usecs =3D n->net_conf.txtimer;
> +        n->tx_timer_activate =3D true;
> +    } else {
> +        n->tx_coal_usecs =3D 0;
> +    }
> +
>      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
>                                      n->net_conf.tx_queue_size);
>
> @@ -4046,6 +4187,12 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>              n->rss_data.specified_hash_types.on_bits |
>              n->rss_data.specified_hash_types.auto_bits;
>      }
> +    n->rx_pkt_cnt =3D 0;
> +    n->tx_pkt_cnt =3D 0;
> +    n->rx_coal_usecs =3D 0;
> +    n->rx_coal_packets =3D 0;
> +    n->tx_coal_packets =3D 0;
> +    n->rx_index_timer =3D NULL;

n->rx_index_timer is added to the struct but it is not used in the ret
of the patch, isn't it?

>  }
>
>  static void virtio_net_device_unrealize(DeviceState *dev)
> @@ -4258,6 +4405,8 @@ static const Property virtio_net_properties[] =3D {
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
> index 371e376428..a76d271096 100644
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
> @@ -177,7 +178,6 @@ struct VirtIONet {
>      /* RSC Chains - temporary storage of coalesced data,
>         all these data are lost in case of migration */
>      QTAILQ_HEAD(, VirtioNetRscChain) rsc_chains;
> -    uint32_t tx_timeout;
>      int32_t tx_burst;
>      uint32_t has_vnet_hdr;
>      size_t host_hdr_len;
> @@ -230,6 +230,14 @@ struct VirtIONet {
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
> index 3df6091274..4ab8f26ceb 100644
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
> --
> 2.53.0
>


