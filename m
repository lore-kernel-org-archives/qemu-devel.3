Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECCEF34C52
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHXC-0004LE-78; Mon, 13 Apr 2026 09:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wCHXA-0004L3-OR
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wCHX7-0001Yj-ET
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776087653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiF/7exK/PL0EkPL4+wcmD8KYDjuPylI0W6CzfWXyHM=;
 b=KiAc9K9FKO3n8q5CUtyZraxF0+aaU07cMj7v8OF7y/fA5LjdOzglr7xQIvQA1plOdR6FDA
 l5Lx8V3Q/Y8g3cAZ9lNB/RVm7ATt+YuzpVl6I7M9f7ck2jaLgqd3A5uj5XVa1XFnbajta/
 oE221UK5CJNRhk8dXiroHHy60P62qHw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-50DIyhoDMDWw_lBytBcjZw-1; Mon, 13 Apr 2026 09:40:51 -0400
X-MC-Unique: 50DIyhoDMDWw_lBytBcjZw-1
X-Mimecast-MFC-AGG-ID: 50DIyhoDMDWw_lBytBcjZw_1776087651
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d826ed6f9so94850581cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 06:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776087651; cv=none;
 d=google.com; s=arc-20240605;
 b=CDWW+eW8eZ4xc6SpaZrWbqzQqB1mPK2c9J+UpK/PmtFanCQhRXo+T8j9lbNUnZhpp+
 fLQ4ZvCcrHkl29ZB9zPMYj2ywEt7lqnkK+KLcwim/hpKcRHMxLVufqqGniXFH9KEbbRT
 M4E8n88PD7bjTPF9ILUjsoiUuncATThQE17MPoFospCVIWzFlFS6dGReCiIyKGBYqut0
 Z2XxWSA9sDrhk7mvC2zC0jfh2aYihOvRZ9Mt0ohLeQLjtvWAEbw2YQLDROZbkEVjdIaI
 ti9YrXJXg0NOZnU4MJiQYa+8RvqgVs9KjWRg74S7ypEICxdd3o8SKHjam0hHABftXKKs
 PHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GiF/7exK/PL0EkPL4+wcmD8KYDjuPylI0W6CzfWXyHM=;
 fh=OhcEJMJzWxw61cwDz9/W7tQ8QALc0RptFomKlOuZt8Q=;
 b=bBetHqXMjPdqu3d9kH7tN47a77tkn7LauPjv4nqFgITZwtdE45URONYoDXPEE16u90
 k81KB/edd57xQYw6PV/3eqNqbHGBpQpuq8tyrAfAKPledFoQHpzxFeZHc7mZSIdPhKdd
 pQpnutoKYHsdoA7KQyjjTzMUKzsmECFoVp6J6almSEYk0eJz0/TU5gMXxKb9edIPuH7d
 GYtX48/HOTNdiabfnSL3OBMHOkEJv5m+ZCuCZO4O+J7DroLUlt0SOEHkpPEbQSHQ59uF
 xrpaPFjRSRFspoNsec0pzpAMC+u1JdSmwryEBjgDJtewEsOM+gUq0N/XVLVirLaChyW4
 BNSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776087651; x=1776692451; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GiF/7exK/PL0EkPL4+wcmD8KYDjuPylI0W6CzfWXyHM=;
 b=s24hKVzjnKmy2vKenAlCueGAPL3KWiDALnxyuBHqSF8M2NxbXpaSp5TM7uYtqQZhqR
 zBs3uJn87Hu2P2momHcd9dzFF4txd+SjOu8kpnURd7YfqtezFYBqJbWk2GUvfBx3/cVB
 7reHQ82w8qR4ri9Q8SAq7SKPPfMcn4q2YCI+l2I0FM+t3FoqheREobddm8CkpRLnv+CN
 rbebVuQ9Ck7oQRxQg47pP7mvopKgxk9i+f825AiFRF3cr+bdOVxEWJaACJn1TWWo0O32
 3vv98FoZ+FQ7S8TT7C2P8RwLKVeGIeLmlgTKCjtgfu75ry638btUB6RND1bUH8mDSEku
 d+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776087651; x=1776692451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GiF/7exK/PL0EkPL4+wcmD8KYDjuPylI0W6CzfWXyHM=;
 b=cfPkwleRJQpMtF7gbF/Aj2bnbRLpu5QEitsXii6MSUORQAQShIbI+lLVYpcESPOnGB
 NQRU5hY5zly1eI4j7ZzRQhLVsQ9HED+D6/8ivJ0SjQp2eaNNINioJFKAL5ZFPXYmGgmw
 OfGV0XpRrmLvoasWgRmVScjrYlpY8v2oa6wyCA9HHFftPrLPboFNcdlRSk2RdUgsKlrz
 vGGC6pPKzBBzzNuyaa6gSPH8LWKU3NXrdcxqiCA3uHnaHeACLd1kbvH0+SgF2G2IyJGL
 deILouhGyFFaX2ejOi/BJeV1K1e4VcJRD1mW0R2laL0BkczTrREj/p5qPCj58zwA70dv
 Vs/w==
X-Gm-Message-State: AOJu0YyJLaKegdiqQNHUIH9iCBg6kQZzInSCHUcQhKEstfnXkCneOqIV
 VaXt6YRuH63+I56AVq0+pyMHPSsxdB0zAzOoQB6+CqGsEHhkcTFeFYW7NhJRA/NlRVpgPTNRd6O
 zfGounBiRBpVKZib+qwAFeoE6vW93Sr1DHig+E8esIGz9n7aAe4VE0PNdLnmTcb72MwdhMicUD8
 YFH7OjOuI92Zt/StxaMGka7rn/KAX5bro=
X-Gm-Gg: AeBDiethj26ruCv/92YrRuNK9GvhOe1Pe4YwVTuPuXK2zSIXmIcHjlDBrORqfh4rhqq
 UhXoS0y1jievucWl7DRjf2C7jKfo+ludIDFPXampfu/hmD09/2g9mMMtJqVWa9kiXEeZL6rQRIM
 OmKgc80IEHdNrTS4w1B82qkQt8yLW6/wnwDRpaopwUFcZZxblf8YgUTeY/HH5TPSFYleBnqa/kJ
 Iog8nVQY+Zd+amx3x70EEwQoYd7fc6xmIPnc16TUEkFPy0ECn0TH42gBBWJ6ZMwuSMx56Ykf/Lm
 F9D1zEeSQfYBeBe/Fer9AosFzjbFihM598+zIQ==
X-Received: by 2002:ac8:5955:0:b0:50d:84ce:e339 with SMTP id
 d75a77b69052e-50dc1acd899mr250757661cf.19.1776087650691; 
 Mon, 13 Apr 2026 06:40:50 -0700 (PDT)
X-Received: by 2002:ac8:5955:0:b0:50d:84ce:e339 with SMTP id
 d75a77b69052e-50dc1acd899mr250756761cf.19.1776087649909; Mon, 13 Apr 2026
 06:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260330122917.468225-1-kdutta@redhat.com>
 <CAJaqyWd3CqDQXizLxNcMYM9CA=K1LfR_XDaO6ksrnw6StWDBKg@mail.gmail.com>
In-Reply-To: <CAJaqyWd3CqDQXizLxNcMYM9CA=K1LfR_XDaO6ksrnw6StWDBKg@mail.gmail.com>
From: Koushik Dutta <kdutta@redhat.com>
Date: Mon, 13 Apr 2026 19:10:37 +0530
X-Gm-Features: AQROBzBvYK8yId0edIJmoxlYyxzXvpBK2UDc-BjvwKGRt-bWPVooBsxKGsE6r9k
Message-ID: <CALseRdeOWhdDszbqm=9kkuj1oUKfn_nF37+vGqEdmTAa86wkkg@mail.gmail.com>
Subject: Re: [PATCH v4] hw/net/virtio-net: add support for notification
 coalescing
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000768d7b064f57a1ae"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000768d7b064f57a1ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 4:42=E2=80=AFPM Eugenio Perez Martin <eperezma@redh=
at.com>
wrote:

> On Mon, Mar 30, 2026 at 2:29=E2=80=AFPM Koushik Dutta <kdutta@redhat.com>=
 wrote:
> >
> > Implement VirtIO Network Notification Coalescing (Bit 53).
> > This allows the guest to manage interrupt frequency using ethtool
> > -C for both RX and TX paths.
> >
> > - Added VIRTIO_NET_F_NOTF_COAL to host features.
> > - Implemented VIRTIO_NET_CTRL_NOTF_COAL class handling in
> >   virtio_net_handle_ctrl_iov.
> > - Added logic to store and apply rx/tx usecs and max_packets.
> > - Added packet counters and threshold logic for both RX and TX data
> paths.
> > - Dynamic Dispatcher: Implemented a dispatcher mechanism that
> >   dynamically switches/activates the notification callback logic
> >   only after the guest enables TX coalescing via ethtool.
> >
> > vhost-vdpa: add support for SVQ interrupt coalescing.
> >
>
> This patch still does not add vhost-vdpa support.


> > This reduces interrupt overhead by batching notifications based on
> > either a packet count or a time-based threshold.
> >
> > Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> > ---
> >  hw/net/virtio-net.c            | 137 +++++++++++++++++++++++++++++----
> >  include/hw/virtio/virtio-net.h |   8 ++
> >  net/vhost-vdpa.c               |   2 +
> >  3 files changed, 131 insertions(+), 16 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index eccb48ad42..16f197cbdb 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -131,6 +131,8 @@ static const VirtIOConfigSizeParams cfg_size_params
> =3D {
> >      .feature_sizes =3D feature_sizes
> >  };
> >
> > +static void virtio_net_tx_timer(void *opaque);
> > +
>
> Nit: I think it's better to move yhis declaration just before the
> function that uses it.
>
   >>  Resolved in V5 patch set.

>
> >  static VirtIONetQueue *virtio_net_get_subqueue(NetClientState *nc)
> >  {
> >      VirtIONet *n =3D qemu_get_nic_opaque(nc);
> > @@ -157,6 +159,15 @@ static void
> flush_or_purge_queued_packets(NetClientState *nc)
> >   * - we could suppress RX interrupt if we were so inclined.
> >   */
> >
> > +static void virtio_net_rx_notify(void *opaque)
> > +{
> > +    VirtIONet *n =3D opaque;
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> > +
> > +    n->rx_pkt_cnt =3D 0;
> > +    virtio_notify(vdev, n->vqs[0].rx_vq);
>
> If we keep the code this way, this function should iterate through all
> the rx queues.
>
> I'm ok with this version, but it feels more natural to me if each RX
> VQ has its own RX timer. This paves the way for per-vq coalescing and
> aligns with the tx code. This version has fewer timers and simplifies
> some things, so I think it is ok for the moment.
>
>     >> Resolved in V5 patch set.


> > +}
> > +
> >  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> >  {
> >      VirtIONet *n =3D VIRTIO_NET(vdev);
> > @@ -1081,6 +1092,43 @@ static int virtio_net_handle_offloads(VirtIONet
> *n, uint8_t cmd,
> >      }
> >  }
> >
> > +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
> > +                                  struct iovec *iov, unsigned int
> iov_cnt)
> > +{
> > +    struct virtio_net_ctrl_coal coal;
> > +    VirtIONetQueue *q;
> > +    size_t s;
> > +    int i;
> > +
> > +    s =3D iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
> > +    if (s !=3D sizeof(coal)) {
> > +        return VIRTIO_NET_ERR;
> > +    }
> > +
> > +    if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
> > +        n->rx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> > +        n->rx_coal_packets =3D le32_to_cpu(coal.max_packets);
> > +        if (!n->rx_index_timer) {
>
> n->rx_index_timer && n->rx_coal_usecs > 0 ? Also delete it if
> rx_coal_usecs =3D=3D 0?
>
> > +            n->rx_index_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> > +                                             virtio_net_rx_notify, n);
> > +        }
> > +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> > +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> > +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> > +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
>
> If n->tx_timeout is only used to convert us to ms, we should not
> allocate a variable for this and just multiply by 1000 at the timer
> creation time.
>

   >> The `tx_timeout` variable is already present in the source code. I
have used the tx_timeout variable to hold the user-given tx coal value in
us to ns.

>
> > +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +            q =3D &n->vqs[i];
> > +            if (!q->tx_timer) {
> > +                q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                           virtio_net_tx_timer,
> > +                                           q);
> > +            }
> > +        }
> > +    }
> > +
> > +    return VIRTIO_NET_OK;
> > +}
> > +
> >  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
> >                                   struct iovec *iov, unsigned int
> iov_cnt)
> >  {
> > @@ -1582,6 +1630,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice
> *vdev,
> >          status =3D virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
> >      } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
> >          status =3D virtio_net_handle_offloads(n, ctrl.cmd, iov, out_nu=
m);
> > +    } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_NOTF_COAL) {
> > +        status =3D virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
> >      }
> >
> >      s =3D iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
> > @@ -2041,7 +2091,22 @@ static ssize_t
> virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
> >      }
> >
> >      virtqueue_flush(q->rx_vq, i);
> > -    virtio_notify(vdev, q->rx_vq);
> > +
> > +    /* rx coalescing */
> > +    n->rx_pkt_cnt +=3D i;
> > +    if (n->rx_coal_usecs =3D=3D 0 || n->rx_pkt_cnt >=3D n->rx_coal_pac=
kets) {
> > +        if (n->rx_index_timer) {
> > +            timer_del(n->rx_index_timer);
> > +        }
>
> How does the next tick occurs if we delete the timer here?
>
    >>  timer_del only stops the "alarm" from ringing, and ``timer_mod''
restarts the timer.

>
> > +        virtio_net_rx_notify(n);
> > +    } else {
> > +        if (n->rx_index_timer) {
> > +            if (!timer_pending(n->rx_index_timer)) {
> > +                timer_mod(n->rx_index_timer,
> > +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) +
> n->rx_coal_usecs);
> > +            }
> > +        }
> > +    }
> >
> >      return size;
> >
> > @@ -2818,7 +2883,6 @@ detach:
> >      return -EINVAL;
> >  }
> >
> > -static void virtio_net_tx_timer(void *opaque);
> >
> >  static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue
> *vq)
> >  {
> > @@ -2900,6 +2964,12 @@ static void virtio_net_tx_timer(void *opaque)
> >      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
> >          return;
> >      }
> > +    if (n->tx_pkt_cnt < ret) {
> > +        n->tx_pkt_cnt =3D 0;
> > +    } else {
> > +        n->tx_pkt_cnt -=3D ret;
> > +    }
> > +
> >      /*
> >       * If we flush a full burst of packets, assume there are
> >       * more coming and immediately rearm
> > @@ -2919,6 +2989,7 @@ static void virtio_net_tx_timer(void *opaque)
> >      ret =3D virtio_net_flush_tx(q);
> >      if (ret > 0) {
> >          virtio_queue_set_notification(q->tx_vq, 0);
> > +        n->tx_pkt_cnt -=3D ret;
> >          q->tx_waiting =3D 1;
> >          timer_mod(q->tx_timer,
> >                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> n->tx_timeout);
> > @@ -2974,6 +3045,32 @@ static void virtio_net_tx_bh(void *opaque)
> >      }
> >  }
> >
> > +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueu=
e
> *vq)
> > +{
> > +    VirtIONet *n =3D VIRTIO_NET(vdev);
> > +    VirtIONetQueue *q =3D &n->vqs[vq2q(virtio_get_queue_index(vq))];
> > +    bool use_timer =3D n->tx_timer_activate || n->tx_coal_usecs > 0 ||
> > +                     n->tx_coal_packets > 0;
> > +    bool pkt_limit =3D (n->tx_coal_packets > 0);
> > +
> > +    if (use_timer) {
> > +        n->tx_pkt_cnt++;
> > +        if (!pkt_limit || n->tx_pkt_cnt < n->tx_coal_packets) {
> > +            if (q->tx_timer) {
> > +                virtio_net_handle_tx_timer(vdev, vq);
> > +                return;
> > +            }
> > +        }
> > +        n->tx_pkt_cnt =3D 0;
> > +        if (q->tx_timer) {
> > +            timer_del(q->tx_timer);
> > +        }
> > +        virtio_net_handle_tx_bh(vdev, vq);
> > +    } else {
> > +        virtio_net_handle_tx_bh(vdev, vq);
> > +    }
> > +}
> > +
> >  static void virtio_net_add_queue(VirtIONet *n, int index)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> > @@ -2981,20 +3078,15 @@ static void virtio_net_add_queue(VirtIONet *n,
> int index)
> >      n->vqs[index].rx_vq =3D virtio_add_queue(vdev,
> n->net_conf.rx_queue_size,
> >                                             virtio_net_handle_rx);
> >
> > -    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
> > -        n->vqs[index].tx_vq =3D
> > -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> > -                             virtio_net_handle_tx_timer);
> > -        n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > -                                              virtio_net_tx_timer,
> > -                                              &n->vqs[index]);
> > -    } else {
> > -        n->vqs[index].tx_vq =3D
> > -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> > -                             virtio_net_handle_tx_bh);
> > -        n->vqs[index].tx_bh =3D qemu_bh_new_guarded(virtio_net_tx_bh,
> &n->vqs[index],
> > -
> &DEVICE(vdev)->mem_reentrancy_guard);
> > -    }
> > +    n->vqs[index].tx_vq =3D
> > +        virtio_add_queue(vdev,
> > +                         n->net_conf.tx_queue_size,
> > +                         virtio_net_handle_tx_dispatch);
> > +
> > +    n->vqs[index].tx_bh =3D
> > +        qemu_bh_new_guarded(virtio_net_tx_bh,
> > +                            &n->vqs[index],
> > +                            &DEVICE(vdev)->mem_reentrancy_guard);
> >
> >      n->vqs[index].tx_waiting =3D 0;
> >      n->vqs[index].n =3D n;
> > @@ -3972,6 +4064,10 @@ static void virtio_net_device_realize(DeviceStat=
e
> *dev, Error **errp)
> >          error_printf("Defaulting to \"bh\"");
> >      }
> >
> > +    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")) {
> > +        n->tx_timer_activate =3D true;
> > +    }
> > +
>
> I keep thinking it would be easier if we accepted either the timer
> cmdline or vq_notif_coal, but never both simultaneously. This way we
> can reuse the exact same logic for both of them.
>
> >      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
> >                                      n->net_conf.tx_queue_size);
> >
> > @@ -4048,6 +4144,13 @@ static void virtio_net_device_realize(DeviceStat=
e
> *dev, Error **errp)
> >              n->rss_data.specified_hash_types.on_bits |
> >              n->rss_data.specified_hash_types.auto_bits;
> >      }
> > +    n->rx_pkt_cnt =3D 0;
> > +    n->tx_pkt_cnt =3D 0;
> > +    n->rx_coal_usecs =3D 0;
> > +    n->tx_coal_usecs =3D 0;
> > +    n->rx_coal_packets =3D 0;
> > +    n->tx_coal_packets =3D 0;
> > +    n->rx_index_timer =3D NULL;
> >  }
> >
> >  static void virtio_net_device_unrealize(DeviceState *dev)
> > @@ -4262,6 +4365,8 @@ static const Property virtio_net_properties[] =3D=
 {
> >                        VIRTIO_NET_F_GUEST_USO6, true),
> >      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> >                        VIRTIO_NET_F_HOST_USO, true),
> > +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
> > +                      VIRTIO_NET_F_NOTF_COAL, true),
> >      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
> >                                    rss_data.specified_hash_types,
> >                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> > diff --git a/include/hw/virtio/virtio-net.h
> b/include/hw/virtio/virtio-net.h
> > index 5b8ab7bda7..024501ed37 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -231,6 +231,14 @@ struct VirtIONet {
> >      struct EBPFRSSContext ebpf_rss;
> >      uint32_t nr_ebpf_rss_fds;
> >      char **ebpf_rss_fds;
> > +    QEMUTimer *rx_index_timer;
> > +    uint32_t rx_coal_usecs;
> > +    uint32_t rx_coal_packets;
> > +    uint32_t rx_pkt_cnt;
> > +    uint32_t tx_coal_usecs;
> > +    uint32_t tx_coal_packets;
> > +    uint32_t tx_pkt_cnt;
> > +    bool tx_timer_activate;
> >  };
> >
> >  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 3df6091274..a20db78b81 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -70,6 +70,7 @@ static const int vdpa_feature_bits[] =3D {
> >      VIRTIO_NET_F_CTRL_RX,
> >      VIRTIO_NET_F_CTRL_RX_EXTRA,
> >      VIRTIO_NET_F_CTRL_VLAN,
> > +    VIRTIO_NET_F_NOTF_COAL,
> >      VIRTIO_NET_F_CTRL_VQ,
> >      VIRTIO_NET_F_GSO,
> >      VIRTIO_NET_F_GUEST_CSUM,
> > @@ -115,6 +116,7 @@ static const uint64_t vdpa_svq_device_features =3D
> >      BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
> >      BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
> >      BIT_ULL(VIRTIO_NET_F_STATUS) |
> > +    BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |
>
> This needs to be deleted, SVQ still does not support
> VIRTIO_NET_F_NOTF_COAL.
>
> >      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
> >      BIT_ULL(VIRTIO_NET_F_GSO) |
> >      BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
> > --
> > 2.53.0
> >
>
> Also, VMSTATE_ must be added to vmstate_virtio_net_device to migrate
> these fields. This can be tested by migrating a device with an
> emulated device with no vdpa too.
>
   >> Done in V5 patch set.

>
> The process of migration is described here but feel free to ping me
> for help: https://www.linux-kvm.org/page/Migration .
>
>

--000000000000768d7b064f57a1ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 31,=
 2026 at 4:42=E2=80=AFPM Eugenio Perez Martin &lt;<a href=3D"mailto:eperezm=
a@redhat.com">eperezma@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Mon, Mar 30, 2026 at 2:29=E2=80=AFPM Ko=
ushik Dutta &lt;<a href=3D"mailto:kdutta@redhat.com" target=3D"_blank">kdut=
ta@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Implement VirtIO Network Notification Coalescing (Bit 53).<br>
&gt; This allows the guest to manage interrupt frequency using ethtool<br>
&gt; -C for both RX and TX paths.<br>
&gt;<br>
&gt; - Added VIRTIO_NET_F_NOTF_COAL to host features.<br>
&gt; - Implemented VIRTIO_NET_CTRL_NOTF_COAL class handling in<br>
&gt;=C2=A0 =C2=A0virtio_net_handle_ctrl_iov.<br>
&gt; - Added logic to store and apply rx/tx usecs and max_packets.<br>
&gt; - Added packet counters and threshold logic for both RX and TX data pa=
ths.<br>
&gt; - Dynamic Dispatcher: Implemented a dispatcher mechanism that<br>
&gt;=C2=A0 =C2=A0dynamically switches/activates the notification callback l=
ogic<br>
&gt;=C2=A0 =C2=A0only after the guest enables TX coalescing via ethtool.<br=
>
&gt;<br>
&gt; vhost-vdpa: add support for SVQ interrupt coalescing.<br>
&gt;<br>
<br>
This patch still does not add vhost-vdpa support.=C2=A0</blockquote><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; This reduces interrupt overhead by batching notifications based on<br>
&gt; either a packet count or a time-based threshold.<br>
&gt;<br>
&gt; Signed-off-by: Koushik Dutta &lt;<a href=3D"mailto:kdutta@redhat.com" =
target=3D"_blank">kdutta@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1=
37 +++++++++++++++++++++++++++++----<br>
&gt;=C2=A0 include/hw/virtio/virtio-net.h |=C2=A0 =C2=A08 ++<br>
&gt;=C2=A0 net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 3 files changed, 131 insertions(+), 16 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index eccb48ad42..16f197cbdb 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -131,6 +131,8 @@ static const VirtIOConfigSizeParams cfg_size_param=
s =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .feature_sizes =3D feature_sizes<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; +static void virtio_net_tx_timer(void *opaque);<br>
&gt; +<br>
<br>
Nit: I think it&#39;s better to move yhis declaration just before the<br>
function that uses it.<br></blockquote><div>=C2=A0 =C2=A0&gt;&gt;=C2=A0 Res=
olved in V5 patch set.=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt;=C2=A0 static VirtIONetQueue *virtio_net_get_subqueue(NetClientState *n=
c)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIONet *n =3D qemu_get_nic_opaque(nc);<br>
&gt; @@ -157,6 +159,15 @@ static void flush_or_purge_queued_packets(NetClie=
ntState *nc)<br>
&gt;=C2=A0 =C2=A0* - we could suppress RX interrupt if we were so inclined.=
<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;<br>
&gt; +static void virtio_net_rx_notify(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIONet *n =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 virtio_notify(vdev, n-&gt;vqs[0].rx_vq);<br>
<br>
If we keep the code this way, this function should iterate through all<br>
the rx queues.<br>
<br>
I&#39;m ok with this version, but it feels more natural to me if each RX<br=
>
VQ has its own RX timer. This paves the way for per-vq coalescing and<br>
aligns with the tx code. This version has fewer timers and simplifies<br>
some things, so I think it is ok for the moment.<br>
<br></blockquote><div>=C2=A0 =C2=A0 &gt;&gt; Resolved in V5 patch set.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *c=
onfig)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(vdev);<br>
&gt; @@ -1081,6 +1092,43 @@ static int virtio_net_handle_offloads(VirtIONet=
 *n, uint8_t cmd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iovec *iov, unsign=
ed int iov_cnt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct virtio_net_ctrl_coal coal;<br>
&gt; +=C2=A0 =C2=A0 VirtIONetQueue *q;<br>
&gt; +=C2=A0 =C2=A0 size_t s;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s =3D iov_to_buf(iov, iov_cnt, 0, &amp;coal, sizeof(coa=
l));<br>
&gt; +=C2=A0 =C2=A0 if (s !=3D sizeof(coal)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return VIRTIO_NET_ERR;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rx_coal_usecs =3D le32_to_cpu(coal.=
max_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rx_coal_packets =3D le32_to_cpu(coa=
l.max_packets);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!n-&gt;rx_index_timer) {<br>
<br>
n-&gt;rx_index_timer &amp;&amp; n-&gt;rx_coal_usecs &gt; 0 ? Also delete it=
 if<br>
rx_coal_usecs =3D=3D 0?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rx_index_timer =3D ti=
mer_new_us(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0virtio_net_rx_notify, n);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_coal_usecs =3D le32_to_cpu(coal.=
max_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_coal_packets =3D le32_to_cpu(coa=
l.max_packets);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_timeout =3D n-&gt;tx_coal_usecs =
* 1000;<br>
<br>
If n-&gt;tx_timeout is only used to convert us to ms, we should not<br>
allocate a variable for this and just multiply by 1000 at the timer<br>
creation time.<br></blockquote><div><br>=C2=A0 =C2=A0&gt;&gt; The `tx_timeo=
ut` variable is already present in the source code. I have used the tx_time=
out variable to hold the user-given tx coal value in us to ns.=C2=A0=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_queue_pair=
s; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D &amp;n-&gt;vqs[i];<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;tx_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_time=
r =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0virtio_net_tx_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return VIRTIO_NET_OK;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iovec *iov, u=
nsigned int iov_cnt)<br>
&gt;=C2=A0 {<br>
&gt; @@ -1582,6 +1630,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *=
vdev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D virtio_net_handle_mq(n, c=
trl.cmd, iov, out_num);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_GUEST=
_OFFLOADS) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D virtio_net_handle_offload=
s(n, ctrl.cmd, iov, out_num);<br>
&gt; +=C2=A0 =C2=A0 } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_NOTF_COAL)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D virtio_net_handle_coal(n, ctrl=
.cmd, iov, out_num);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 s =3D iov_from_buf(in_sg, in_num, 0, &amp;status, =
sizeof(status));<br>
&gt; @@ -2041,7 +2091,22 @@ static ssize_t virtio_net_receive_rcu(NetClient=
State *nc, const uint8_t *buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtqueue_flush(q-&gt;rx_vq, i);<br>
&gt; -=C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;rx_vq);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* rx coalescing */<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rx_pkt_cnt +=3D i;<br>
&gt; +=C2=A0 =C2=A0 if (n-&gt;rx_coal_usecs =3D=3D 0 || n-&gt;rx_pkt_cnt &g=
t;=3D n-&gt;rx_coal_packets) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;rx_index_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(n-&gt;rx_index_ti=
mer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
How does the next tick occurs if we delete the timer here?<br></blockquote>=
<div>=C2=A0 =C2=A0 &gt;&gt;=C2=A0 timer_del=C2=A0only stops the &quot;alarm=
&quot; from ringing, and ``timer_mod&#39;&#39; restarts the timer.=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_rx_notify(n);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;rx_index_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!timer_pending(n-&gt;rx=
_index_timer)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(n-&=
gt;rx_index_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n-&gt;rx_coal=
_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return size;<br>
&gt;<br>
&gt; @@ -2818,7 +2883,6 @@ detach:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static void virtio_net_tx_timer(void *opaque);<br>
&gt;<br>
&gt;=C2=A0 static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQ=
ueue *vq)<br>
&gt;=C2=A0 {<br>
&gt; @@ -2900,6 +2964,12 @@ static void virtio_net_tx_timer(void *opaque)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (n-&gt;tx_pkt_cnt &lt; ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt -=3D ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* If we flush a full burst of packets, assum=
e there are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* more coming and immediately rearm<br>
&gt; @@ -2919,6 +2989,7 @@ static void virtio_net_tx_timer(void *opaque)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D virtio_net_flush_tx(q);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_set_notification(q-&gt;=
tx_vq, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt -=3D ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_waiting =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(q-&gt;tx_timer,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q=
emu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n-&gt;tx_timeout);<br>
&gt; @@ -2974,6 +3045,32 @@ static void virtio_net_tx_bh(void *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQue=
ue *vq)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(vdev);<br>
&gt; +=C2=A0 =C2=A0 VirtIONetQueue *q =3D &amp;n-&gt;vqs[vq2q(virtio_get_qu=
eue_index(vq))];<br>
&gt; +=C2=A0 =C2=A0 bool use_timer =3D n-&gt;tx_timer_activate || n-&gt;tx_=
coal_usecs &gt; 0 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0n-&gt;tx_coal_packets &gt; 0;<br>
&gt; +=C2=A0 =C2=A0 bool pkt_limit =3D (n-&gt;tx_coal_packets &gt; 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (use_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pkt_limit || n-&gt;tx_pkt_cnt &lt; n=
-&gt;tx_coal_packets) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_ha=
ndle_tx_timer(vdev, vq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(q-&gt;tx_timer);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_bh(vdev, vq);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_bh(vdev, vq);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void virtio_net_add_queue(VirtIONet *n, int index)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<br>
&gt; @@ -2981,20 +3078,15 @@ static void virtio_net_add_queue(VirtIONet *n,=
 int index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].rx_vq =3D virtio_add_queue(vdev, =
n-&gt;net_conf.rx_queue_size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0virtio_net_handle_rx);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if (n-&gt;net_conf.tx &amp;&amp; !strcmp(n-&gt;net_conf=
.tx, &quot;timer&quot;)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_vq =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_add_queue(vdev, n-&g=
t;net_conf.tx_queue_size,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_handle_tx_timer);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_timer =3D timer_new_n=
s(QEMU_CLOCK_VIRTUAL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 virtio_net_tx_timer,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;n-&gt;vqs[index]);<br>
&gt; -=C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_vq =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_add_queue(vdev, n-&g=
t;net_conf.tx_queue_size,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_handle_tx_bh);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_bh =3D qemu_bh_new_gu=
arded(virtio_net_tx_bh, &amp;n-&gt;vqs[index],<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;DEVICE(vdev)-&gt;mem_reentrancy_guard)=
;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_vq =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_add_queue(vdev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0n-&gt;net_conf.tx_queue_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0virtio_net_handle_tx_dispatch);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_bh =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_bh_new_guarded(virtio_net_tx_bh,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;n-&gt;vqs[index],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;DEVICE(vdev)-&gt;mem_reentrancy_guard);<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_waiting =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].n =3D n;<br>
&gt; @@ -3972,6 +4064,10 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_printf(&quot;Defaulting to \&q=
uot;bh\&quot;&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if (n-&gt;net_conf.tx &amp;&amp; strcmp(n-&gt;net_conf.=
tx, &quot;timer&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_timer_activate =3D true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
I keep thinking it would be easier if we accepted either the timer<br>
cmdline or vq_notif_coal, but never both simultaneously. This way we<br>
can reuse the exact same logic for both of them.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;net_conf.tx_queue_size =3D MIN(virtio_net_ma=
x_tx_queue_size(n),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;net_co=
nf.tx_queue_size);<br>
&gt;<br>
&gt; @@ -4048,6 +4144,13 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.specifi=
ed_hash_types.on_bits |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.specifi=
ed_hash_types.auto_bits;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;tx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rx_coal_usecs =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;tx_coal_usecs =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rx_coal_packets =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;tx_coal_packets =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rx_index_timer =3D NULL;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static void virtio_net_device_unrealize(DeviceState *dev)<br>
&gt; @@ -4262,6 +4365,8 @@ static const Property virtio_net_properties[] =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_USO6, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BIT64(&quot;host_uso&quot;, VirtIONet,=
 host_features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 VIRTIO_NET_F_HOST_USO, true),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BIT64(&quot;vq_notf_coal&quot;, VirtIONet, =
host_features,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 VIRTIO_NET_F_NOTF_COAL, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_ON_OFF_AUTO_BIT64(&quot;hash-ipv4&quot=
;, VirtIONet,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rss_data.specified_=
hash_types,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_HASH_REP=
ORT_IPv4 - 1,<br>
&gt; diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio=
-net.h<br>
&gt; index 5b8ab7bda7..024501ed37 100644<br>
&gt; --- a/include/hw/virtio/virtio-net.h<br>
&gt; +++ b/include/hw/virtio/virtio-net.h<br>
&gt; @@ -231,6 +231,14 @@ struct VirtIONet {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct EBPFRSSContext ebpf_rss;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t nr_ebpf_rss_fds;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char **ebpf_rss_fds;<br>
&gt; +=C2=A0 =C2=A0 QEMUTimer *rx_index_timer;<br>
&gt; +=C2=A0 =C2=A0 uint32_t rx_coal_usecs;<br>
&gt; +=C2=A0 =C2=A0 uint32_t rx_coal_packets;<br>
&gt; +=C2=A0 =C2=A0 uint32_t rx_pkt_cnt;<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_coal_usecs;<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_coal_packets;<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_pkt_cnt;<br>
&gt; +=C2=A0 =C2=A0 bool tx_timer_activate;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,<br>
&gt; diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c<br>
&gt; index 3df6091274..a20db78b81 100644<br>
&gt; --- a/net/vhost-vdpa.c<br>
&gt; +++ b/net/vhost-vdpa.c<br>
&gt; @@ -70,6 +70,7 @@ static const int vdpa_feature_bits[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_RX,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_RX_EXTRA,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_VLAN,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_NOTF_COAL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_VQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GSO,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_CSUM,<br>
&gt; @@ -115,6 +116,7 @@ static const uint64_t vdpa_svq_device_features =3D=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_HOST_UFO) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_STATUS) |<br>
&gt; +=C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |<br>
<br>
This needs to be deleted, SVQ still does not support VIRTIO_NET_F_NOTF_COAL=
.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_GSO) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_CTRL_RX) |<br>
&gt; --<br>
&gt; 2.53.0<br>
&gt;<br>
<br>
Also, VMSTATE_ must be added to vmstate_virtio_net_device to migrate<br>
these fields. This can be tested by migrating a device with an<br>
emulated device with no vdpa too.<br></blockquote><div>=C2=A0 =C2=A0&gt;&gt=
; Done in V5 patch set.=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
The process of migration is described here but feel free to ping me<br>
for help: <a href=3D"https://www.linux-kvm.org/page/Migration" rel=3D"noref=
errer" target=3D"_blank">https://www.linux-kvm.org/page/Migration</a> .<br>
<br>
</blockquote></div></div>

--000000000000768d7b064f57a1ae--


