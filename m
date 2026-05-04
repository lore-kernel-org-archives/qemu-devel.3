Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84920FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 09:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJptw-0005hL-Hb; Mon, 04 May 2026 05:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wJptv-0005hC-NO
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:47:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wJpts-0001jq-1K
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777888059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CxxEHWqx6weqPmldRhhQgLnGLEK8051btlO8uiBn5/s=;
 b=XgHu/mYh56J9Lbch1UusxiiOpetoPWUdL12k/t6jIw0fqALeXV5Ya4P3wML2MnfKn0TIMq
 gSKsI4EjaniP4CKJ643kCYksAGy73TKUKetQpPv5+4l/N0sg1L8v91y4k3YcAaAy5y/pLk
 M085D08pjNqmUzR8EStjhiI1u1PSjNk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-je-4MY5XOoO70Q69_d6Rlw-1; Mon, 04 May 2026 05:47:37 -0400
X-MC-Unique: je-4MY5XOoO70Q69_d6Rlw-1
X-Mimecast-MFC-AGG-ID: je-4MY5XOoO70Q69_d6Rlw_1777888057
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b597b14a22so82337416d6.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 02:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777888057; cv=none;
 d=google.com; s=arc-20240605;
 b=e+MhOllk5n2ZVzWNACohO7LhtoHI4slkFikCy4k75L+F+oPfOMAOBJidThNwicpbob
 cUNzeCh6n26+Pefs/HAHf3IK6oE0m8I35CDllrOfVaz+jOb/SN+bFgt6j/KVSLVFx6Dt
 /WFzu54zlf7V0OFisGbmvXQ8jYW1rrWNvq6sLgeilFxIYveKDUuCPtAn1OxQ4K36SHut
 6guapCZDNFB8mgRaC3JYebtwBqCaHDlXgY2B4rcu/yT+hIfP6CYt42hb9FpOyDt1Zpi5
 jHIjzJagYoW1z0uqO3lr8YxsbjGUR/ytw2BgKyVWT1Rb+wRD6FR55UAvX0UeZCMgWO2E
 KZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CxxEHWqx6weqPmldRhhQgLnGLEK8051btlO8uiBn5/s=;
 fh=OhcEJMJzWxw61cwDz9/W7tQ8QALc0RptFomKlOuZt8Q=;
 b=SqFHb4yELbaNbhomTdOwmumNUgPvAnMgzFU3zTkrtLwLufXqGEYB1dBYg/8id1nkIl
 h/ZF7A/qXAzsZzn7kRF/PwZV+cIfnMJYxE4K2OLWlEY1at16zi0MGE20RRDQwJvXRQPP
 rbYf+CkcTR/IA1YCf6uRERbGVQN+9tiZD0DQqvrr5TQtySVrD6Wnzuha1lL1phKrO8yY
 BkwMJBpvvn5waQggRQeNagbfQmOkyu7GpARxojPmGk4IYo5F46UO2cnP6BddlBu5xFPw
 AUIHd2gzBclJGjWqpACvjIWEwcMbGWmvQaDPIuncilaEyxw6ID6BckdE0uGlBmqS7DGa
 6dOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777888057; x=1778492857; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CxxEHWqx6weqPmldRhhQgLnGLEK8051btlO8uiBn5/s=;
 b=PIs/zAIjzKAxYPevSQgFInh6EEbuanwaojRfUpTqZ1ohPpLi1svQDNGILHQPdBCKbP
 cOoXWUP7GFicU2F4rV1KvXWsEzyKcNogbUSdTMWHtSYtq4YcPByrbwgelYXPtZH5LfgC
 y/tzNoyeSAQAwzKlbKWmNSKQnVFVneCeXRSDN/0xpMnT/vgI51wS1XQvcu+5Z3KOn3h1
 kt+ITB3T7v3xa4lF47PpPa+iNtfP/GLxyAaUm9EUr18CCPv2PlGm0H36v5hPdqx/2o3N
 izRQWg+G6cvt1zQRhGCsF+xT4cQW5ykI249IZZF7lu21FtwLxX7fKZHz7bvSHiV1uhY0
 Q+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777888057; x=1778492857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxxEHWqx6weqPmldRhhQgLnGLEK8051btlO8uiBn5/s=;
 b=OURKxHWOxCcgm36k3+6t7g2wL73KpnL1W7Iu8c/tKE++jY5to1pSCm2tu7C7wRLo4F
 oasfRfMgFJ8DJ/RzGDE2nnuvSY6YHg8uPs/IiivJknFiJiO2Sd1vC++yOU8lrWZJuWhj
 la+cCKFsE8odtdcbQagrBDCJBEnS/MPv+FAjc+U7tBNlnsRNo6KBK+OmdrYOPEicjofU
 /Q1hM7+j/lE45o/h+SayORWRCHM7h1S9SKwmuwmobxQFx2cxypNqSVCUx4vEer6I9hgp
 443c+yMbYAjgla3ScclfRWjx5DImYjpBfZez09fw72zbkkjVqpf8glDosvqbXA/mVaaV
 ibDg==
X-Gm-Message-State: AOJu0Ywdx5sTyHFX/7yjz+hOFCiE68xWaYJMNBBi9ne8k1WgobV9h9/9
 OgkHZujytb461r/s41MA9LmZ13lHaMnGjGHn7JbJCLV+R/Gy8FFiMn3za3WeKHfHPv/JqwEJEZJ
 /OaZ1nJDIVFYXx3BelqnvVG+pwLAgcZf75qseq22CDC9rv7ffKsTJR8zoJe7rwfUyZFjIMQujuQ
 FUm0fEJWIXdFTPmeUm6XZc2cjt4mI0wZ8=
X-Gm-Gg: AeBDietR149fSK0c1F98+WXGgrskTkQBnEjdSOPbO+51ApEgp6zatNj5cOykpBwFMzi
 gdVgDc8hVMyw58eM6w1N90s59LLlY47w/6se3gIkmeizwAL4IlmfW5SgefsSmvYaPtq1U29p+03
 yDmlz740tdcfiOaU6eP2lIvEcD3zE48mS8RsGCqJy+JkDcu/tRRPS2oTQ9MDzVKOYyo5I8hxL3B
 9NpIRoD7rXltDv+e3IYBb4xUuk4Fnz7vsyFmfDqW727K3+uk8yOidpZCFM8bj5BL+3x5p4iB22L
 w2rOuOVWnI2WNct4rhBviSli3ZOtVGN3AhiPX3CD9UAWJ1Fg
X-Received: by 2002:a05:6214:808c:b0:8ae:63a4:8271 with SMTP id
 6a1803df08f44-8b6662fe69fmr113514516d6.9.1777888056595; 
 Mon, 04 May 2026 02:47:36 -0700 (PDT)
X-Received: by 2002:a05:6214:808c:b0:8ae:63a4:8271 with SMTP id
 6a1803df08f44-8b6662fe69fmr113514326d6.9.1777888056042; Mon, 04 May 2026
 02:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260330122917.468225-1-kdutta@redhat.com>
 <CAJaqyWd3CqDQXizLxNcMYM9CA=K1LfR_XDaO6ksrnw6StWDBKg@mail.gmail.com>
 <CALseRdeOWhdDszbqm=9kkuj1oUKfn_nF37+vGqEdmTAa86wkkg@mail.gmail.com>
 <CAJaqyWdoa+kVem6gRd0P1H4dOeMmYmbvobTvxmzO9XYEYN0zrw@mail.gmail.com>
In-Reply-To: <CAJaqyWdoa+kVem6gRd0P1H4dOeMmYmbvobTvxmzO9XYEYN0zrw@mail.gmail.com>
From: Koushik Dutta <kdutta@redhat.com>
Date: Mon, 4 May 2026 15:17:24 +0530
X-Gm-Features: AVHnY4KyhgLrRRFhbGnJjEGWuToLTJL6v94v-SRJcMDKyHzYROAElq2xd9A7ksk
Message-ID: <CALseRdehJMV=FmUeMkkp6C_bUj1AD1Ks=ucOVA=NCprQfPSavQ@mail.gmail.com>
Subject: Re: [PATCH v4] hw/net/virtio-net: add support for notification
 coalescing
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000007f7b70650fad2db"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000007f7b70650fad2db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So can we just remove tx_timeout and use tx_coal_usecs instead?
Address in the V6 patch set.

On Mon, Apr 13, 2026 at 8:08=E2=80=AFPM Eugenio Perez Martin <eperezma@redh=
at.com>
wrote:

> On Mon, Apr 13, 2026 at 3:40=E2=80=AFPM Koushik Dutta <kdutta@redhat.com>=
 wrote:
> >
> >
> >
> > On Tue, Mar 31, 2026 at 4:42=E2=80=AFPM Eugenio Perez Martin <
> eperezma@redhat.com> wrote:
> >>
> >> On Mon, Mar 30, 2026 at 2:29=E2=80=AFPM Koushik Dutta <kdutta@redhat.c=
om>
> wrote:
> >> >
> >> > Implement VirtIO Network Notification Coalescing (Bit 53).
> >> > This allows the guest to manage interrupt frequency using ethtool
> >> > -C for both RX and TX paths.
> >> >
> >> > - Added VIRTIO_NET_F_NOTF_COAL to host features.
> >> > - Implemented VIRTIO_NET_CTRL_NOTF_COAL class handling in
> >> >   virtio_net_handle_ctrl_iov.
> >> > - Added logic to store and apply rx/tx usecs and max_packets.
> >> > - Added packet counters and threshold logic for both RX and TX data
> paths.
> >> > - Dynamic Dispatcher: Implemented a dispatcher mechanism that
> >> >   dynamically switches/activates the notification callback logic
> >> >   only after the guest enables TX coalescing via ethtool.
> >> >
> >> > vhost-vdpa: add support for SVQ interrupt coalescing.
> >> >
> >>
> >> This patch still does not add vhost-vdpa support.
> >>
> >>
> >> > This reduces interrupt overhead by batching notifications based on
> >> > either a packet count or a time-based threshold.
> >> >
> >> > Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> >> > ---
> >> >  hw/net/virtio-net.c            | 137
> +++++++++++++++++++++++++++++----
> >> >  include/hw/virtio/virtio-net.h |   8 ++
> >> >  net/vhost-vdpa.c               |   2 +
> >> >  3 files changed, 131 insertions(+), 16 deletions(-)
> >> >
> >> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> > index eccb48ad42..16f197cbdb 100644
> >> > --- a/hw/net/virtio-net.c
> >> > +++ b/hw/net/virtio-net.c
> >> > @@ -131,6 +131,8 @@ static const VirtIOConfigSizeParams
> cfg_size_params =3D {
> >> >      .feature_sizes =3D feature_sizes
> >> >  };
> >> >
> >> > +static void virtio_net_tx_timer(void *opaque);
> >> > +
> >>
> >> Nit: I think it's better to move yhis declaration just before the
> >> function that uses it.
> >
> > Resolved in V5 patch set.
> >>
> >>
> >> >  static VirtIONetQueue *virtio_net_get_subqueue(NetClientState *nc)
> >> >  {
> >> >      VirtIONet *n =3D qemu_get_nic_opaque(nc);
> >> > @@ -157,6 +159,15 @@ static void
> flush_or_purge_queued_packets(NetClientState *nc)
> >> >   * - we could suppress RX interrupt if we were so inclined.
> >> >   */
> >> >
> >> > +static void virtio_net_rx_notify(void *opaque)
> >> > +{
> >> > +    VirtIONet *n =3D opaque;
> >> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >> > +
> >> > +    n->rx_pkt_cnt =3D 0;
> >> > +    virtio_notify(vdev, n->vqs[0].rx_vq);
> >>
> >> If we keep the code this way, this function should iterate through all
> >> the rx queues.
> >>
> >> I'm ok with this version, but it feels more natural to me if each RX
> >> VQ has its own RX timer. This paves the way for per-vq coalescing and
> >> aligns with the tx code. This version has fewer timers and simplifies
> >> some things, so I think it is ok for the moment.
> >>
> > Resolved in V5 patch set.
> >
> >>
> >> > +}
> >> > +
> >> >  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t
> *config)
> >> >  {
> >> >      VirtIONet *n =3D VIRTIO_NET(vdev);
> >> > @@ -1081,6 +1092,43 @@ static int
> virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
> >> >      }
> >> >  }
> >> >
> >> > +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
> >> > +                                  struct iovec *iov, unsigned int
> iov_cnt)
> >> > +{
> >> > +    struct virtio_net_ctrl_coal coal;
> >> > +    VirtIONetQueue *q;
> >> > +    size_t s;
> >> > +    int i;
> >> > +
> >> > +    s =3D iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
> >> > +    if (s !=3D sizeof(coal)) {
> >> > +        return VIRTIO_NET_ERR;
> >> > +    }
> >> > +
> >> > +    if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
> >> > +        n->rx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> >> > +        n->rx_coal_packets =3D le32_to_cpu(coal.max_packets);
> >> > +        if (!n->rx_index_timer) {
> >>
> >> n->rx_index_timer && n->rx_coal_usecs > 0 ? Also delete it if
> >> rx_coal_usecs =3D=3D 0?
> >>
> >> > +            n->rx_index_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> >> > +                                             virtio_net_rx_notify,
> n);
> >> > +        }
> >> > +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> >> > +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> >> > +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> >> > +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
> >>
> >> If n->tx_timeout is only used to convert us to ms, we should not
> >> allocate a variable for this and just multiply by 1000 at the timer
> >> creation time.
> >
> >
> > The `tx_timeout` variable is already present in the source code. I have
> used the tx_timeout variable to hold the user-given tx coal value in us t=
o
> ns.
>
> So can we just remove tx_timeout and use tx_coal_usecs instead?
>
> >>
> >>
> >> > +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> >> > +            q =3D &n->vqs[i];
> >> > +            if (!q->tx_timer) {
> >> > +                q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> >> > +                                           virtio_net_tx_timer,
> >> > +                                           q);
> >> > +            }
> >> > +        }
> >> > +    }
> >> > +
> >> > +    return VIRTIO_NET_OK;
> >> > +}
> >> > +
> >> >  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
> >> >                                   struct iovec *iov, unsigned int
> iov_cnt)
> >> >  {
> >> > @@ -1582,6 +1630,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice
> *vdev,
> >> >          status =3D virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
> >> >      } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
> >> >          status =3D virtio_net_handle_offloads(n, ctrl.cmd, iov,
> out_num);
> >> > +    } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_NOTF_COAL) {
> >> > +        status =3D virtio_net_handle_coal(n, ctrl.cmd, iov, out_num=
);
> >> >      }
> >> >
> >> >      s =3D iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
> >> > @@ -2041,7 +2091,22 @@ static ssize_t
> virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
> >> >      }
> >> >
> >> >      virtqueue_flush(q->rx_vq, i);
> >> > -    virtio_notify(vdev, q->rx_vq);
> >> > +
> >> > +    /* rx coalescing */
> >> > +    n->rx_pkt_cnt +=3D i;
> >> > +    if (n->rx_coal_usecs =3D=3D 0 || n->rx_pkt_cnt >=3D
> n->rx_coal_packets) {
> >> > +        if (n->rx_index_timer) {
> >> > +            timer_del(n->rx_index_timer);
> >> > +        }
> >>
> >> How does the next tick occurs if we delete the timer here?
> >
> > timer_del only stops the "alarm" from ringing, and ``timer_mod''
> restarts the timer.
>
> Ouch, my bad! I thought timer_del totally cleaned the timer.
>
> >>
> >>
> >> > +        virtio_net_rx_notify(n);
> >> > +    } else {
> >> > +        if (n->rx_index_timer) {
> >> > +            if (!timer_pending(n->rx_index_timer)) {
> >> > +                timer_mod(n->rx_index_timer,
> >> > +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) +
> n->rx_coal_usecs);
> >> > +            }
> >> > +        }
> >> > +    }
> >> >
> >> >      return size;
> >> >
> >> > @@ -2818,7 +2883,6 @@ detach:
> >> >      return -EINVAL;
> >> >  }
> >> >
> >> > -static void virtio_net_tx_timer(void *opaque);
> >> >
> >> >  static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueu=
e
> *vq)
> >> >  {
> >> > @@ -2900,6 +2964,12 @@ static void virtio_net_tx_timer(void *opaque)
> >> >      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
> >> >          return;
> >> >      }
> >> > +    if (n->tx_pkt_cnt < ret) {
> >> > +        n->tx_pkt_cnt =3D 0;
> >> > +    } else {
> >> > +        n->tx_pkt_cnt -=3D ret;
> >> > +    }
> >> > +
> >> >      /*
> >> >       * If we flush a full burst of packets, assume there are
> >> >       * more coming and immediately rearm
> >> > @@ -2919,6 +2989,7 @@ static void virtio_net_tx_timer(void *opaque)
> >> >      ret =3D virtio_net_flush_tx(q);
> >> >      if (ret > 0) {
> >> >          virtio_queue_set_notification(q->tx_vq, 0);
> >> > +        n->tx_pkt_cnt -=3D ret;
> >> >          q->tx_waiting =3D 1;
> >> >          timer_mod(q->tx_timer,
> >> >                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> n->tx_timeout);
> >> > @@ -2974,6 +3045,32 @@ static void virtio_net_tx_bh(void *opaque)
> >> >      }
> >> >  }
> >> >
> >> > +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev,
> VirtQueue *vq)
> >> > +{
> >> > +    VirtIONet *n =3D VIRTIO_NET(vdev);
> >> > +    VirtIONetQueue *q =3D &n->vqs[vq2q(virtio_get_queue_index(vq))]=
;
> >> > +    bool use_timer =3D n->tx_timer_activate || n->tx_coal_usecs > 0=
 ||
> >> > +                     n->tx_coal_packets > 0;
> >> > +    bool pkt_limit =3D (n->tx_coal_packets > 0);
> >> > +
> >> > +    if (use_timer) {
> >> > +        n->tx_pkt_cnt++;
> >> > +        if (!pkt_limit || n->tx_pkt_cnt < n->tx_coal_packets) {
> >> > +            if (q->tx_timer) {
> >> > +                virtio_net_handle_tx_timer(vdev, vq);
> >> > +                return;
> >> > +            }
> >> > +        }
> >> > +        n->tx_pkt_cnt =3D 0;
> >> > +        if (q->tx_timer) {
> >> > +            timer_del(q->tx_timer);
> >> > +        }
> >> > +        virtio_net_handle_tx_bh(vdev, vq);
> >> > +    } else {
> >> > +        virtio_net_handle_tx_bh(vdev, vq);
> >> > +    }
> >> > +}
> >> > +
> >> >  static void virtio_net_add_queue(VirtIONet *n, int index)
> >> >  {
> >> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >> > @@ -2981,20 +3078,15 @@ static void virtio_net_add_queue(VirtIONet
> *n, int index)
> >> >      n->vqs[index].rx_vq =3D virtio_add_queue(vdev,
> n->net_conf.rx_queue_size,
> >> >                                             virtio_net_handle_rx);
> >> >
> >> > -    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
> >> > -        n->vqs[index].tx_vq =3D
> >> > -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> >> > -                             virtio_net_handle_tx_timer);
> >> > -        n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> >> > -                                              virtio_net_tx_timer,
> >> > -                                              &n->vqs[index]);
> >> > -    } else {
> >> > -        n->vqs[index].tx_vq =3D
> >> > -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> >> > -                             virtio_net_handle_tx_bh);
> >> > -        n->vqs[index].tx_bh =3D qemu_bh_new_guarded(virtio_net_tx_b=
h,
> &n->vqs[index],
> >> > -
> &DEVICE(vdev)->mem_reentrancy_guard);
> >> > -    }
> >> > +    n->vqs[index].tx_vq =3D
> >> > +        virtio_add_queue(vdev,
> >> > +                         n->net_conf.tx_queue_size,
> >> > +                         virtio_net_handle_tx_dispatch);
> >> > +
> >> > +    n->vqs[index].tx_bh =3D
> >> > +        qemu_bh_new_guarded(virtio_net_tx_bh,
> >> > +                            &n->vqs[index],
> >> > +                            &DEVICE(vdev)->mem_reentrancy_guard);
> >> >
> >> >      n->vqs[index].tx_waiting =3D 0;
> >> >      n->vqs[index].n =3D n;
> >> > @@ -3972,6 +4064,10 @@ static void
> virtio_net_device_realize(DeviceState *dev, Error **errp)
> >> >          error_printf("Defaulting to \"bh\"");
> >> >      }
> >> >
> >> > +    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")) {
> >> > +        n->tx_timer_activate =3D true;
> >> > +    }
> >> > +
> >>
> >> I keep thinking it would be easier if we accepted either the timer
> >> cmdline or vq_notif_coal, but never both simultaneously. This way we
> >> can reuse the exact same logic for both of them.
> >>
> >> >      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(=
n),
> >> >                                      n->net_conf.tx_queue_size);
> >> >
> >> > @@ -4048,6 +4144,13 @@ static void
> virtio_net_device_realize(DeviceState *dev, Error **errp)
> >> >              n->rss_data.specified_hash_types.on_bits |
> >> >              n->rss_data.specified_hash_types.auto_bits;
> >> >      }
> >> > +    n->rx_pkt_cnt =3D 0;
> >> > +    n->tx_pkt_cnt =3D 0;
> >> > +    n->rx_coal_usecs =3D 0;
> >> > +    n->tx_coal_usecs =3D 0;
> >> > +    n->rx_coal_packets =3D 0;
> >> > +    n->tx_coal_packets =3D 0;
> >> > +    n->rx_index_timer =3D NULL;
> >> >  }
> >> >
> >> >  static void virtio_net_device_unrealize(DeviceState *dev)
> >> > @@ -4262,6 +4365,8 @@ static const Property virtio_net_properties[] =
=3D
> {
> >> >                        VIRTIO_NET_F_GUEST_USO6, true),
> >> >      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> >> >                        VIRTIO_NET_F_HOST_USO, true),
> >> > +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
> >> > +                      VIRTIO_NET_F_NOTF_COAL, true),
> >> >      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
> >> >                                    rss_data.specified_hash_types,
> >> >                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> >> > diff --git a/include/hw/virtio/virtio-net.h
> b/include/hw/virtio/virtio-net.h
> >> > index 5b8ab7bda7..024501ed37 100644
> >> > --- a/include/hw/virtio/virtio-net.h
> >> > +++ b/include/hw/virtio/virtio-net.h
> >> > @@ -231,6 +231,14 @@ struct VirtIONet {
> >> >      struct EBPFRSSContext ebpf_rss;
> >> >      uint32_t nr_ebpf_rss_fds;
> >> >      char **ebpf_rss_fds;
> >> > +    QEMUTimer *rx_index_timer;
> >> > +    uint32_t rx_coal_usecs;
> >> > +    uint32_t rx_coal_packets;
> >> > +    uint32_t rx_pkt_cnt;
> >> > +    uint32_t tx_coal_usecs;
> >> > +    uint32_t tx_coal_packets;
> >> > +    uint32_t tx_pkt_cnt;
> >> > +    bool tx_timer_activate;
> >> >  };
> >> >
> >> >  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
> >> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >> > index 3df6091274..a20db78b81 100644
> >> > --- a/net/vhost-vdpa.c
> >> > +++ b/net/vhost-vdpa.c
> >> > @@ -70,6 +70,7 @@ static const int vdpa_feature_bits[] =3D {
> >> >      VIRTIO_NET_F_CTRL_RX,
> >> >      VIRTIO_NET_F_CTRL_RX_EXTRA,
> >> >      VIRTIO_NET_F_CTRL_VLAN,
> >> > +    VIRTIO_NET_F_NOTF_COAL,
> >> >      VIRTIO_NET_F_CTRL_VQ,
> >> >      VIRTIO_NET_F_GSO,
> >> >      VIRTIO_NET_F_GUEST_CSUM,
> >> > @@ -115,6 +116,7 @@ static const uint64_t vdpa_svq_device_features =
=3D
> >> >      BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
> >> >      BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
> >> >      BIT_ULL(VIRTIO_NET_F_STATUS) |
> >> > +    BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |
> >>
> >> This needs to be deleted, SVQ still does not support
> VIRTIO_NET_F_NOTF_COAL.
> >>
> >> >      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
> >> >      BIT_ULL(VIRTIO_NET_F_GSO) |
> >> >      BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
> >> > --
> >> > 2.53.0
> >> >
> >>
> >> Also, VMSTATE_ must be added to vmstate_virtio_net_device to migrate
> >> these fields. This can be tested by migrating a device with an
> >> emulated device with no vdpa too.
> >
> >    >> Done in V5 patch set.
> >>
> >>
> >> The process of migration is described here but feel free to ping me
> >> for help: https://www.linux-kvm.org/page/Migration .
> >>
>
>

--00000000000007f7b70650fad2db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So can we just remove tx_timeout and use tx_coal_usecs ins=
tead?<br>Address in the V6 patch set.</div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 13, =
2026 at 8:08=E2=80=AFPM Eugenio Perez Martin &lt;<a href=3D"mailto:eperezma=
@redhat.com">eperezma@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Mon, Apr 13, 2026 at 3:40=E2=80=AFPM Ko=
ushik Dutta &lt;<a href=3D"mailto:kdutta@redhat.com" target=3D"_blank">kdut=
ta@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Mar 31, 2026 at 4:42=E2=80=AFPM Eugenio Perez Martin &lt;<a hr=
ef=3D"mailto:eperezma@redhat.com" target=3D"_blank">eperezma@redhat.com</a>=
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Mar 30, 2026 at 2:29=E2=80=AFPM Koushik Dutta &lt;<a href=
=3D"mailto:kdutta@redhat.com" target=3D"_blank">kdutta@redhat.com</a>&gt; w=
rote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Implement VirtIO Network Notification Coalescing (Bit 53).<br=
>
&gt;&gt; &gt; This allows the guest to manage interrupt frequency using eth=
tool<br>
&gt;&gt; &gt; -C for both RX and TX paths.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - Added VIRTIO_NET_F_NOTF_COAL to host features.<br>
&gt;&gt; &gt; - Implemented VIRTIO_NET_CTRL_NOTF_COAL class handling in<br>
&gt;&gt; &gt;=C2=A0 =C2=A0virtio_net_handle_ctrl_iov.<br>
&gt;&gt; &gt; - Added logic to store and apply rx/tx usecs and max_packets.=
<br>
&gt;&gt; &gt; - Added packet counters and threshold logic for both RX and T=
X data paths.<br>
&gt;&gt; &gt; - Dynamic Dispatcher: Implemented a dispatcher mechanism that=
<br>
&gt;&gt; &gt;=C2=A0 =C2=A0dynamically switches/activates the notification c=
allback logic<br>
&gt;&gt; &gt;=C2=A0 =C2=A0only after the guest enables TX coalescing via et=
htool.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; vhost-vdpa: add support for SVQ interrupt coalescing.<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt; This patch still does not add vhost-vdpa support.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; This reduces interrupt overhead by batching notifications bas=
ed on<br>
&gt;&gt; &gt; either a packet count or a time-based threshold.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Koushik Dutta &lt;<a href=3D"mailto:kdutta@red=
hat.com" target=3D"_blank">kdutta@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 137 +++++++++++++++++++++++++++++----<br>
&gt;&gt; &gt;=C2=A0 include/hw/virtio/virtio-net.h |=C2=A0 =C2=A08 ++<br>
&gt;&gt; &gt;=C2=A0 net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;&gt; &gt;=C2=A0 3 files changed, 131 insertions(+), 16 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt;&gt; &gt; index eccb48ad42..16f197cbdb 100644<br>
&gt;&gt; &gt; --- a/hw/net/virtio-net.c<br>
&gt;&gt; &gt; +++ b/hw/net/virtio-net.c<br>
&gt;&gt; &gt; @@ -131,6 +131,8 @@ static const VirtIOConfigSizeParams cfg_s=
ize_params =3D {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 .feature_sizes =3D feature_sizes<br>
&gt;&gt; &gt;=C2=A0 };<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +static void virtio_net_tx_timer(void *opaque);<br>
&gt;&gt; &gt; +<br>
&gt;&gt;<br>
&gt;&gt; Nit: I think it&#39;s better to move yhis declaration just before =
the<br>
&gt;&gt; function that uses it.<br>
&gt;<br>
&gt; Resolved in V5 patch set.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 static VirtIONetQueue *virtio_net_get_subqueue(NetClien=
tState *nc)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VirtIONet *n =3D qemu_get_nic_opaque(nc);=
<br>
&gt;&gt; &gt; @@ -157,6 +159,15 @@ static void flush_or_purge_queued_packet=
s(NetClientState *nc)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0* - we could suppress RX interrupt if we were so =
inclined.<br>
&gt;&gt; &gt;=C2=A0 =C2=A0*/<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +static void virtio_net_rx_notify(void *opaque)<br>
&gt;&gt; &gt; +{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 VirtIONet *n =3D opaque;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 n-&gt;rx_pkt_cnt =3D 0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 virtio_notify(vdev, n-&gt;vqs[0].rx_vq);<br>
&gt;&gt;<br>
&gt;&gt; If we keep the code this way, this function should iterate through=
 all<br>
&gt;&gt; the rx queues.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m ok with this version, but it feels more natural to me if e=
ach RX<br>
&gt;&gt; VQ has its own RX timer. This paves the way for per-vq coalescing =
and<br>
&gt;&gt; aligns with the tx code. This version has fewer timers and simplif=
ies<br>
&gt;&gt; some things, so I think it is ok for the moment.<br>
&gt;&gt;<br>
&gt; Resolved in V5 patch set.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; +}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 static void virtio_net_get_config(VirtIODevice *vdev, u=
int8_t *config)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(vdev);<br>
&gt;&gt; &gt; @@ -1081,6 +1092,43 @@ static int virtio_net_handle_offloads(=
VirtIONet *n, uint8_t cmd,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;=C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,=
<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iovec *i=
ov, unsigned int iov_cnt)<br>
&gt;&gt; &gt; +{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 struct virtio_net_ctrl_coal coal;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 VirtIONetQueue *q;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 size_t s;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 int i;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 s =3D iov_to_buf(iov, iov_cnt, 0, &amp;coal, s=
izeof(coal));<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if (s !=3D sizeof(coal)) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return VIRTIO_NET_ERR;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_RX_SE=
T) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rx_coal_usecs =3D le32_to_=
cpu(coal.max_usecs);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rx_coal_packets =3D le32_t=
o_cpu(coal.max_packets);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!n-&gt;rx_index_timer) {<br>
&gt;&gt;<br>
&gt;&gt; n-&gt;rx_index_timer &amp;&amp; n-&gt;rx_coal_usecs &gt; 0 ? Also =
delete it if<br>
&gt;&gt; rx_coal_usecs =3D=3D 0?<br>
&gt;&gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rx_index_tim=
er =3D timer_new_us(QEMU_CLOCK_VIRTUAL,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_rx_notify, n);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COA=
L_TX_SET) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_coal_usecs =3D le32_to_=
cpu(coal.max_usecs);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_coal_packets =3D le32_t=
o_cpu(coal.max_packets);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_timeout =3D n-&gt;tx_co=
al_usecs * 1000;<br>
&gt;&gt;<br>
&gt;&gt; If n-&gt;tx_timeout is only used to convert us to ms, we should no=
t<br>
&gt;&gt; allocate a variable for this and just multiply by 1000 at the time=
r<br>
&gt;&gt; creation time.<br>
&gt;<br>
&gt;<br>
&gt; The `tx_timeout` variable is already present in the source code. I hav=
e used the tx_timeout variable to hold the user-given tx coal value in us t=
o ns.<br>
<br>
So can we just remove tx_timeout and use tx_coal_usecs instead?<br>
<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_q=
ueue_pairs; i++) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D &amp;n-&gt;v=
qs[i];<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;tx_time=
r) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&g=
t;tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0virtio_net_tx_timer,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0q);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 return VIRTIO_NET_OK;<br>
&gt;&gt; &gt; +}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 static int virtio_net_handle_mac(VirtIONet *n, uint8_t =
cmd,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iovec=
 *iov, unsigned int iov_cnt)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt; @@ -1582,6 +1630,8 @@ size_t virtio_net_handle_ctrl_iov(VirtI=
ODevice *vdev,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D virtio_net_handl=
e_mq(n, ctrl.cmd, iov, out_num);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 } else if (ctrl.class =3D=3D VIRTIO_NET_C=
TRL_GUEST_OFFLOADS) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D virtio_net_handl=
e_offloads(n, ctrl.cmd, iov, out_num);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_N=
OTF_COAL) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D virtio_net_handle_coa=
l(n, ctrl.cmd, iov, out_num);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 s =3D iov_from_buf(in_sg, in_num, 0, &amp=
;status, sizeof(status));<br>
&gt;&gt; &gt; @@ -2041,7 +2091,22 @@ static ssize_t virtio_net_receive_rcu(=
NetClientState *nc, const uint8_t *buf,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 virtqueue_flush(q-&gt;rx_vq, i);<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;rx_vq);<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 /* rx coalescing */<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 n-&gt;rx_pkt_cnt +=3D i;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if (n-&gt;rx_coal_usecs =3D=3D 0 || n-&gt;rx_p=
kt_cnt &gt;=3D n-&gt;rx_coal_packets) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;rx_index_timer) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(n-&gt;rx=
_index_timer);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; How does the next tick occurs if we delete the timer here?<br>
&gt;<br>
&gt; timer_del only stops the &quot;alarm&quot; from ringing, and ``timer_m=
od&#39;&#39; restarts the timer.<br>
<br>
Ouch, my bad! I thought timer_del totally cleaned the timer.<br>
<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_rx_notify(n);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;rx_index_timer) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!timer_pending=
(n-&gt;rx_index_timer)) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time=
r_mod(n-&gt;rx_index_timer,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n-&=
gt;rx_coal_usecs);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return size;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; @@ -2818,7 +2883,6 @@ detach:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;&gt; &gt;=C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -static void virtio_net_tx_timer(void *opaque);<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 static void virtio_net_handle_tx_timer(VirtIODevice *vd=
ev, VirtQueue *vq)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt; @@ -2900,6 +2964,12 @@ static void virtio_net_tx_timer(void *=
opaque)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -EBUSY || ret =3D=3D -EINV=
AL) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if (n-&gt;tx_pkt_cnt &lt; ret) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt =3D 0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt -=3D ret;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* If we flush a full burst of packe=
ts, assume there are<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* more coming and immediately rearm=
<br>
&gt;&gt; &gt; @@ -2919,6 +2989,7 @@ static void virtio_net_tx_timer(void *o=
paque)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 ret =3D virtio_net_flush_tx(q);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (ret &gt; 0) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_set_notificati=
on(q-&gt;tx_vq, 0);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt -=3D ret;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_waiting =3D 1;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(q-&gt;tx_timer,<b=
r>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n-&gt;tx_timeout);<br>
&gt;&gt; &gt; @@ -2974,6 +3045,32 @@ static void virtio_net_tx_bh(void *opa=
que)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;=C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev=
, VirtQueue *vq)<br>
&gt;&gt; &gt; +{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(vdev);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 VirtIONetQueue *q =3D &amp;n-&gt;vqs[vq2q(virt=
io_get_queue_index(vq))];<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 bool use_timer =3D n-&gt;tx_timer_activate || =
n-&gt;tx_coal_usecs &gt; 0 ||<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0n-&gt;tx_coal_packets &gt; 0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 bool pkt_limit =3D (n-&gt;tx_coal_packets &gt;=
 0);<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if (use_timer) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt++;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pkt_limit || n-&gt;tx_pkt_c=
nt &lt; n-&gt;tx_coal_packets) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_timer=
) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virt=
io_net_handle_tx_timer(vdev, vq);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt =3D 0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_timer) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(q-&gt;tx=
_timer);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_bh(vdev, vq=
);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_bh(vdev, vq=
);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 static void virtio_net_add_queue(VirtIONet *n, int inde=
x)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<=
br>
&gt;&gt; &gt; @@ -2981,20 +3078,15 @@ static void virtio_net_add_queue(Virt=
IONet *n, int index)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].rx_vq =3D virtio_add_que=
ue(vdev, n-&gt;net_conf.rx_queue_size,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_handle_rx);<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 if (n-&gt;net_conf.tx &amp;&amp; !strcmp(n-&gt=
;net_conf.tx, &quot;timer&quot;)) {<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_vq =3D<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_add_queue(v=
dev, n-&gt;net_conf.tx_queue_size,<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_handle_tx_timer);<b=
r>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_timer =3D ti=
mer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_tx_timer,<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;n-&gt;vqs[index]);<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 } else {<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_vq =3D<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_add_queue(v=
dev, n-&gt;net_conf.tx_queue_size,<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_handle_tx_bh);<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_bh =3D qemu_=
bh_new_guarded(virtio_net_tx_bh, &amp;n-&gt;vqs[index],<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;DEVICE(vdev)-&gt;mem_reentra=
ncy_guard);<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_vq =3D<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_add_queue(vdev,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;net_conf.tx_queue_size,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_handle_tx_dispatch);<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_bh =3D<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_bh_new_guarded(virtio_net_t=
x_bh,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;n-&gt;vqs[index],<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;DEVICE(vdev)-&gt;mem_reentrancy=
_guard);<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_waiting =3D 0;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].n =3D n;<br>
&gt;&gt; &gt; @@ -3972,6 +4064,10 @@ static void virtio_net_device_realize(=
DeviceState *dev, Error **errp)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_printf(&quot;Defaulti=
ng to \&quot;bh\&quot;&quot;);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if (n-&gt;net_conf.tx &amp;&amp; strcmp(n-&gt;=
net_conf.tx, &quot;timer&quot;)) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_timer_activate =3D true=
;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +<br>
&gt;&gt;<br>
&gt;&gt; I keep thinking it would be easier if we accepted either the timer=
<br>
&gt;&gt; cmdline or vq_notif_coal, but never both simultaneously. This way =
we<br>
&gt;&gt; can reuse the exact same logic for both of them.<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;net_conf.tx_queue_size =3D MIN(virt=
io_net_max_tx_queue_size(n),<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&g=
t;net_conf.tx_queue_size);<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; @@ -4048,6 +4144,13 @@ static void virtio_net_device_realize(=
DeviceState *dev, Error **errp)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_dat=
a.specified_hash_types.on_bits |<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_dat=
a.specified_hash_types.auto_bits;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 n-&gt;rx_pkt_cnt =3D 0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 n-&gt;tx_pkt_cnt =3D 0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 n-&gt;rx_coal_usecs =3D 0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 n-&gt;tx_coal_usecs =3D 0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 n-&gt;rx_coal_packets =3D 0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 n-&gt;tx_coal_packets =3D 0;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 n-&gt;rx_index_timer =3D NULL;<br>
&gt;&gt; &gt;=C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 static void virtio_net_device_unrealize(DeviceState *de=
v)<br>
&gt;&gt; &gt; @@ -4262,6 +4365,8 @@ static const Property virtio_net_proper=
ties[] =3D {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_USO6, true),<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BIT64(&quot;host_uso&quot;, V=
irtIONet, host_features,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_HOST_USO, true),<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 DEFINE_PROP_BIT64(&quot;vq_notf_coal&quot;, Vi=
rtIONet, host_features,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_NOTF_COAL, true),<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_ON_OFF_AUTO_BIT64(&quot;hash-=
ipv4&quot;, VirtIONet,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rss_data.sp=
ecified_hash_types,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_=
HASH_REPORT_IPv4 - 1,<br>
&gt;&gt; &gt; diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virt=
io/virtio-net.h<br>
&gt;&gt; &gt; index 5b8ab7bda7..024501ed37 100644<br>
&gt;&gt; &gt; --- a/include/hw/virtio/virtio-net.h<br>
&gt;&gt; &gt; +++ b/include/hw/virtio/virtio-net.h<br>
&gt;&gt; &gt; @@ -231,6 +231,14 @@ struct VirtIONet {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 struct EBPFRSSContext ebpf_rss;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t nr_ebpf_rss_fds;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 char **ebpf_rss_fds;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 QEMUTimer *rx_index_timer;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 uint32_t rx_coal_usecs;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 uint32_t rx_coal_packets;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 uint32_t rx_pkt_cnt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 uint32_t tx_coal_usecs;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 uint32_t tx_coal_packets;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 uint32_t tx_pkt_cnt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 bool tx_timer_activate;<br>
&gt;&gt; &gt;=C2=A0 };<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,<b=
r>
&gt;&gt; &gt; diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c<br>
&gt;&gt; &gt; index 3df6091274..a20db78b81 100644<br>
&gt;&gt; &gt; --- a/net/vhost-vdpa.c<br>
&gt;&gt; &gt; +++ b/net/vhost-vdpa.c<br>
&gt;&gt; &gt; @@ -70,6 +70,7 @@ static const int vdpa_feature_bits[] =3D {<=
br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_RX,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_RX_EXTRA,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_VLAN,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_NOTF_COAL,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_VQ,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GSO,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_CSUM,<br>
&gt;&gt; &gt; @@ -115,6 +116,7 @@ static const uint64_t vdpa_svq_device_fea=
tures =3D<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_HOST_UFO) |<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_STATUS) |<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |<br>
&gt;&gt;<br>
&gt;&gt; This needs to be deleted, SVQ still does not support VIRTIO_NET_F_=
NOTF_COAL.<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_GSO) |<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_CTRL_RX) |<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; 2.53.0<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt; Also, VMSTATE_ must be added to vmstate_virtio_net_device to migra=
te<br>
&gt;&gt; these fields. This can be tested by migrating a device with an<br>
&gt;&gt; emulated device with no vdpa too.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 &gt;&gt; Done in V5 patch set.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; The process of migration is described here but feel free to ping m=
e<br>
&gt;&gt; for help: <a href=3D"https://www.linux-kvm.org/page/Migration" rel=
=3D"noreferrer" target=3D"_blank">https://www.linux-kvm.org/page/Migration<=
/a> .<br>
&gt;&gt;<br>
<br>
</blockquote></div>

--00000000000007f7b70650fad2db--


