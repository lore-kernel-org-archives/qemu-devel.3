Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CCFCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbkU-0004ge-Ll; Thu, 28 May 2026 10:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wSbkT-0004gN-A2
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wSbkP-0000dY-DA
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779978606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZswMw/gjQSZEu4yowJKknRDxlV5LTqNULUcKjstZxc=;
 b=J03HFiKxy1XIRaQMDUb6y/VKdiRz+p5BmLN3416JAIyCdCFygd7dabD+Ad4P6Q490hu5ba
 pa24j8MO/a+JcKZ6ggXtujTH1QG8wZniEnIWqdnnG7n40Ws/ccXe25Q2lcR3Sg0BkKpgl4
 jCjst4/vjB2GVJ1FHgtHgAvdyUPB1DM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-KNPZcZ8YPSOVIUzQK4wmFg-1; Thu, 28 May 2026 10:30:04 -0400
X-MC-Unique: KNPZcZ8YPSOVIUzQK4wmFg-1
X-Mimecast-MFC-AGG-ID: KNPZcZ8YPSOVIUzQK4wmFg_1779978603
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7bd6fc10a42so109720457b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779978603; cv=none;
 d=google.com; s=arc-20240605;
 b=DR7Cg7J4vc2qJpdP59b6NLbpSb2StsVBlkxeHM2gRTR1RCaSvwyrvyMKYFoMW4eMox
 hy3zbyy1X5m9q0QNRv0zifuksVcIHjeyPHywW8iu33bOCYbvTzU0HXNc3pR8SfK0ahsX
 uBbouEqCa4X4pBuCoeICm3eGgqZ3DrBebsMBuNhV/OZBDhAcjFWuiVEz7hy27pg7aUHk
 USolstpC6HlYLY6cWnbtWo/ztIFjlFQsxfE/wGjbTHdI/rPbgQ54CP3i964QEe1tTmJK
 MceUCWunjZ/7JGvVIv1WHHUDyc7B13WUG+8h9mvrAm/++IVVygHlrF0b8IXOELMSfHf/
 CNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1ZswMw/gjQSZEu4yowJKknRDxlV5LTqNULUcKjstZxc=;
 fh=6/ouGYbjHnSFSJHFY+pVvzIaqAKSYTuICFj9DWSg2PA=;
 b=QI5+eJZ+m2OmkxY/nMwlc7l2iGbVKPF+ewV8kzeEA3ulILrFJ/qqknivlLkXRIZcIY
 RnLPlxcSPtEMDCC0gyLOOihZ6XNZFTy3BH+U3k61QJ9OKLOafudMJDoNrIkuTaxOvB0B
 mr5YrPiTKZvPt9Tp/flggyIkpzrg+zbBnQyqsgDXWmO6fLCrQV/7RMSJ0pcRTFFD8y3j
 iCDD2/5L67EKtYc8U0ztbBysla3wEbI7PvQ0NeNdyzcQ0QDnIb08L7atwCFf71UuM8S8
 bai+Dth6wCeHCpkFTHts7nE6NOiFT0wraBpP8UulRtdg5USTtYPAUsesPRqT1cLPwJsu
 3PCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779978603; x=1780583403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZswMw/gjQSZEu4yowJKknRDxlV5LTqNULUcKjstZxc=;
 b=boNQSR4PT6eG+r/HhQeEw2O601I1b1D73dUBRFrh5eGq+9THzaSRv/bTzku89i+8JL
 30Cy4ImH0REBA14fw+/a3+uEPTg0XvPgHomnrh8ofA7Gca5jBDKZg55ptduFX6AdIWpq
 +OUPk9gtBMC1kkQPlF0Rt3H46Xvde3nB+TpHbze4oKMu0RF2Eu+8JXhW56oLtPUyrQ8w
 NZEYwnKdJnU7scGAYmF9C3YD//mpAceP/CIAIT8CWyLGniLQhxPeQU5FSYDaGTI2jGBK
 jNtCPBivZB0HYoU0PC4WcdO2MIHPfPvlCtr+oxOmVN2dZAtquo5HfdoWq9Q32QpWW81s
 KhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779978603; x=1780583403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ZswMw/gjQSZEu4yowJKknRDxlV5LTqNULUcKjstZxc=;
 b=hDel6WAygqJxTRArgy9ub5XyGvAQEJK7i1k8xV/dB1wQUdhKSY91ieqB/Ncu1/echA
 BsJsbnV2+u23/gJT9IDzIfB9TV5RcjH/T5e4a+E2Oh5PWlJD9cnMPB0o99m5jbEQqi1f
 JiT48XIMEQpCJhrWRUH7UYl3duWOdAOl0pru0EfVRRYexbcL3xmukIvOmF5vFyOJQpfB
 DUdaQ6sCsnAJL5NMCrhREYEv1rTdbgQeg2OCZROqcTdKGEPqucPa6MbRKykK+8mfZ/ts
 JR2j4xBEOlYvTH/T8gL7a9s7Pf2iMEBHOM0Hmn0SfSw7Q0gN62kUVJX6P4cFRPI6k9nT
 7NNQ==
X-Gm-Message-State: AOJu0Yxq7atdvJweWflHSWn1975DQKea/8Piivk/IGRj12j+b57Kd2zw
 FdjpAzeHtZtchUERSbj1yr/zC5wKz8cq7hrFIUJwfKudMWl9Pmx/UZm20nrgzdVgLx49fjyoDVe
 5mc9swczkW0YvZ7QHJsZaAhHY/ZeC8manX0t7Xg2C4uVUDepj6vCxyDni1WF0hdaJzoX4jYfbdv
 lBP++M8FQ1f7yiapum3SXwpYBDtNrC3zM=
X-Gm-Gg: Acq92OFvPG4SsmN5nPBv0jMEK8+BkwP8f354rg5d2+u0FoT7iuSUwtaJd9iOLSrHQdm
 +fXM0EkxpX91UyCVSyQkAMt/nqYjL7zWXfnww82N4bUrDK+eu1meafc2nfVL/6WO1Yplbb+ruYG
 gjVQXP4atS3ISNcXkaY4WXgdOl8OBhy7fUwFkxYcX2VMsLe4wCPaPqUpRmx6WDCX15822tdojID
 HyKdsTf3pSALOJeTA==
X-Received: by 2002:a05:690c:b11:b0:7cf:d242:d966 with SMTP id
 00721157ae682-7d3341d4f85mr285403847b3.15.1779978602586; 
 Thu, 28 May 2026 07:30:02 -0700 (PDT)
X-Received: by 2002:a05:690c:b11:b0:7cf:d242:d966 with SMTP id
 00721157ae682-7d3341d4f85mr285403357b3.15.1779978601520; Thu, 28 May 2026
 07:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260515181620.1774378-1-kdutta@redhat.com>
 <20260524123115-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260524123115-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 28 May 2026 16:29:25 +0200
X-Gm-Features: AVHnY4Jk0JFYgEhPJ033nKuA-nibHLnP5wqSX6xE12hImCGgPBcIqPbbCXlx0uk
Message-ID: <CAJaqyWeykF0Su8JMS=nToBuooqwiDkFTEvP3u4QUaWmndzwHQA@mail.gmail.com>
Subject: Re: [PATCH v7] hw/net/virtio-net: add support for notification
 coalescing
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, May 24, 2026 at 6:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, May 15, 2026 at 11:46:20PM +0530, Koushik Dutta wrote:
> > Implement VirtIO Network Notification Coalescing (Bit 53).
> > This allows the guest to manage interrupt frequency using ethtool
> > -C for both RX and TX paths.
> >
> > - Added VIRTIO_NET_F_NOTF_COAL to host features.
> > - Implemented VIRTIO_NET_CTRL_NOTF_COAL class handling in
> >   virtio_net_handle_ctrl_iov.
> > - Added logic to store and apply rx/tx usecs and max_packets.
> > - Added packet counters and threshold logic for both RX and TX data pat=
hs.
> > - Dynamic Dispatcher: Implemented a dispatcher mechanism that
> >   dynamically switches/activates the notification callback logic
> >   only after the guest enables TX coalescing via ethtool.
> > - After VM LM coalescing parameters persist in the destination VM.
> >
> > This reduces interrupt overhead by batching notifications based on
> > either a packet count or a time-based threshold.
> >
> > Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> > ---
> > v7 changes:
> >  - Fixed time unit consistency: TX path now uses microseconds matching =
RX
> >  - Changed timer_new_ns to timer_new_us for TX timers
> >  - Changed qemu_clock_get_ns to qemu_clock_get_us in TX path
> >  - Convert txtimer from nanoseconds to microseconds (txtimer / 1000)
> >  - Removed unused rx_index_timer variable from struct and initializatio=
n
> >  - Fixed feature flag handling: removed conditional check in ctrl handl=
er
>
> Thanks!
> Yet something to improve:
>
> > ---
> >  hw/net/virtio-net.c            | 193 +++++++++++++++++++++++++++++----
> >  include/hw/virtio/virtio-net.h |   9 +-
> >  net/passt.c                    |   1 +
> >  net/tap.c                      |   1 +
> >  net/vhost-user.c               |   1 +
> >  net/vhost-vdpa.c               |   1 +
> >  6 files changed, 183 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 2a5d642a64..5a98b52ded 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -157,6 +157,16 @@ static void flush_or_purge_queued_packets(NetClien=
tState *nc)
> >   * - we could suppress RX interrupt if we were so inclined.
> >   */
> >
> > +static void virtio_net_rx_notify(void *opaque)
> > +{
> > +    VirtIONetQueue *q =3D opaque;
> > +    VirtIONet *n =3D q->n;
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> > +
> > +    n->rx_pkt_cnt =3D 0;
> > +    virtio_notify(vdev, q->rx_vq);
> > +}
> > +
> >  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> >  {
> >      VirtIONet *n =3D VIRTIO_NET(vdev);
> > @@ -435,7 +445,7 @@ static int virtio_net_set_status(struct VirtIODevic=
e *vdev, uint8_t status)
> >          if (queue_started) {
> >              if (q->tx_timer) {
> >                  timer_mod(q->tx_timer,
> > -                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=
 n->tx_timeout);
> > +                               qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) +=
 n->tx_coal_usecs);
> >              } else {
> >                  replay_bh_schedule_event(q->tx_bh);
> >              }
> > @@ -1080,6 +1090,52 @@ static int virtio_net_handle_offloads(VirtIONet =
*n, uint8_t cmd,
> >      }
> >  }
> >
> > +static void virtio_net_tx_timer(void *opaque);
> > +
>
>
> I do not like forward declarations like this - pls just order
> the code sensibly.
>
> If you need to move some code, it can be a separate preparatory patch.
>
> > +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
> > +                                  struct iovec *iov, unsigned int iov_=
cnt)
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
> > +        if (n->rx_coal_usecs > 0) {
> > +            for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +                q =3D &n->vqs[i];
> > +                if (!q->rx_timer) {
> > +                    q->rx_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> > +                                               virtio_net_rx_notify,
> > +                                               q);
> > +                }
> > +            }
> > +        }
> > +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> > +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> > +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> > +        if (n->tx_coal_usecs > 0) {
> > +            for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +                q =3D &n->vqs[i];
> > +                if (!q->tx_timer && n->tx_coal_usecs > 0) {
> > +                    q->tx_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> > +                                               virtio_net_tx_timer,
> > +                                               q);
> > +                }
> > +            }
> > +        }
> > +    }
>
> So, the value is never propagated to any of vhost/vhost-user/vdpa.
>
> Thus if they decide to implement and advertise it,
> They will not get the value and will not coalesce appropriately.
> Makes this of a rather limited use - most deployments use some kind
> of offload.
>

Vhost-vdpa devices should support this feature with this patch as long
as they advertise it. Migration with this feature using a vhost-vdpa
backend is not supported though because the shadow control virtqueue
doesn't support it yet. Support for SVQ is planned for a subsequent
patch. It's easy, in the line of loading the rest of the features at
the destination QEMU. Koushik please add it to the patch message for
the next version.

However, there is no vhost-kernel ioctl or vhost-user message, so they
should not offer the feature until it's supported by them. Or should
we also block them someway else?

Now that we are here, maybe the timers should not be allocated as long
as there is a vhost (nc->peer). But their lifecycle gets more
complicated. MST, what do you think?

>
> > +
> > +    return VIRTIO_NET_OK;
> > +}
> > +
> >  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
> >                                   struct iovec *iov, unsigned int iov_c=
nt)
> >  {
> > @@ -1581,6 +1637,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *v=
dev,
> >          status =3D virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
> >      } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
> >          status =3D virtio_net_handle_offloads(n, ctrl.cmd, iov, out_nu=
m);
> > +    } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_NOTF_COAL) {
> > +        status =3D virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
> >      }
> >
> >      s =3D iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
> > @@ -2040,7 +2098,22 @@ static ssize_t virtio_net_receive_rcu(NetClientS=
tate *nc, const uint8_t *buf,
> >      }
> >
> >      virtqueue_flush(q->rx_vq, i);
> > -    virtio_notify(vdev, q->rx_vq);
> > +
> > +    /* rx coalescing */
> > +    n->rx_pkt_cnt +=3D i;
> > +    if (n->rx_coal_usecs =3D=3D 0 || n->rx_pkt_cnt >=3D n->rx_coal_pac=
kets) {
> > +        if (q->rx_timer) {
> > +            timer_del(q->rx_timer);
> > +        }
> > +        virtio_net_rx_notify(q);
> > +    } else {
> > +        if (q->rx_timer) {
> > +            if (!timer_pending(q->rx_timer)) {
> > +                timer_mod(q->rx_timer,
> > +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->r=
x_coal_usecs);
> > +            }
> > +        }
> > +    }
> >
> >      return size;
> >
> > @@ -2708,7 +2781,7 @@ static void virtio_net_tx_complete(NetClientState=
 *nc, ssize_t len)
> >              replay_bh_schedule_event(q->tx_bh);
> >          } else {
> >              timer_mod(q->tx_timer,
> > -                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_ti=
meout);
> > +                      qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->tx_co=
al_usecs);
> >          }
> >          q->tx_waiting =3D 1;
> >      }
> > @@ -2817,7 +2890,6 @@ detach:
> >      return -EINVAL;
> >  }
> >
> > -static void virtio_net_tx_timer(void *opaque);
> >
> >  static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *=
vq)
> >  {
> > @@ -2842,7 +2914,7 @@ static void virtio_net_handle_tx_timer(VirtIODevi=
ce *vdev, VirtQueue *vq)
> >      } else {
> >          /* re-arm timer to flush it (and more) on next tick */
> >          timer_mod(q->tx_timer,
> > -                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeou=
t);
> > +                  qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->tx_coal_u=
secs);
> >          q->tx_waiting =3D 1;
> >          virtio_queue_set_notification(vq, 0);
> >      }
> > @@ -2899,6 +2971,12 @@ static void virtio_net_tx_timer(void *opaque)
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
> > @@ -2906,7 +2984,7 @@ static void virtio_net_tx_timer(void *opaque)
> >      if (ret >=3D n->tx_burst) {
> >          q->tx_waiting =3D 1;
> >          timer_mod(q->tx_timer,
> > -                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeou=
t);
> > +                  qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->tx_coal_u=
secs);
> >          return;
> >      }
> >      /*
> > @@ -2918,9 +2996,10 @@ static void virtio_net_tx_timer(void *opaque)
> >      ret =3D virtio_net_flush_tx(q);
> >      if (ret > 0) {
> >          virtio_queue_set_notification(q->tx_vq, 0);
> > +        n->tx_pkt_cnt -=3D ret;
> >          q->tx_waiting =3D 1;
> >          timer_mod(q->tx_timer,
> > -                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeou=
t);
> > +                  qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->tx_coal_u=
secs);
> >      }
> >  }
> >
> > @@ -2973,6 +3052,32 @@ static void virtio_net_tx_bh(void *opaque)
> >      }
> >  }
> >
> > +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueu=
e *vq)
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
>
>
> It seems coalescing is exclusive with bh use?
>
>
>
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
>
> So, you unified tx handling in one place?
> this is better done in a preparatory patch.
>
> >  static void virtio_net_add_queue(VirtIONet *n, int index)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> > @@ -2980,20 +3085,15 @@ static void virtio_net_add_queue(VirtIONet *n, =
int index)
> >      n->vqs[index].rx_vq =3D virtio_add_queue(vdev, n->net_conf.rx_queu=
e_size,
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
> > -        n->vqs[index].tx_bh =3D qemu_bh_new_guarded(virtio_net_tx_bh, =
&n->vqs[index],
> > -                                                  &DEVICE(vdev)->mem_r=
eentrancy_guard);
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
> > @@ -3088,6 +3188,9 @@ static void virtio_net_get_features(VirtIODevice =
*vdev, uint64_t *features,
> >      virtio_features_or(features, features, n->host_features_ex);
> >
> >      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> > +    if (n->tx_timer_activate) {
> > +        virtio_clear_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
> > +    }
> >
> >      if (!peer_has_vnet_hdr(n)) {
> >          virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> > @@ -3242,6 +3345,35 @@ static int virtio_net_post_load_device(void *opa=
que, int version_id)
> >      }
> >
> >      virtio_net_commit_rss_config(n);
> > +    if (n->tx_coal_usecs > 0 || n->rx_coal_usecs > 0) {
> > +
> > +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +            VirtIONetQueue *q =3D &n->vqs[i];
> > +            if (!q->rx_timer && n->rx_coal_usecs > 0) {
> > +                q->rx_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> > +                                           virtio_net_rx_notify,
> > +                                           q);
> > +            }
> > +
> > +            if (!q->tx_timer && n->tx_coal_usecs > 0) {
> > +                q->tx_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> > +                                           virtio_net_tx_timer,
> > +                                           q);
> > +            }
> > +
> > +            if (n->tx_coal_usecs > 0 && q->tx_timer) {
> > +                n->tx_pkt_cnt =3D 0;
> > +                timer_mod(q->tx_timer,
> > +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->t=
x_coal_usecs);
> > +            }
> > +
> > +            if (n->rx_coal_usecs > 0 && q->rx_timer) {
> > +                timer_mod(q->rx_timer,
> > +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->r=
x_coal_usecs);
> > +            }
> > +        }
> > +    }
> > +
> >      return 0;
> >  }
> >
> > @@ -3617,6 +3749,10 @@ static const VMStateDescription vmstate_virtio_n=
et_device =3D {
> >                           vmstate_virtio_net_tx_waiting),
> >          VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
> >                              has_ctrl_guest_offloads),
> > +        VMSTATE_UINT32(rx_coal_usecs, VirtIONet),
> > +        VMSTATE_UINT32(tx_coal_usecs, VirtIONet),
> > +        VMSTATE_UINT32(rx_coal_packets, VirtIONet),
> > +        VMSTATE_UINT32(tx_coal_packets, VirtIONet),
> >          VMSTATE_END_OF_LIST()
> >      },
> >      .subsections =3D (const VMStateDescription * const []) {
> > @@ -3960,7 +4096,6 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
> >      }
> >      n->vqs =3D g_new0(VirtIONetQueue, n->max_queue_pairs);
> >      n->curr_queue_pairs =3D 1;
> > -    n->tx_timeout =3D n->net_conf.txtimer;
> >
> >      if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")
> >                         && strcmp(n->net_conf.tx, "bh")) {
> > @@ -3970,6 +4105,13 @@ static void virtio_net_device_realize(DeviceStat=
e *dev, Error **errp)
> >          error_printf("Defaulting to \"bh\"");
> >      }
> >
> > +    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") =3D=3D 0) {
> > +        n->tx_coal_usecs =3D n->net_conf.txtimer / 1000;
>
> add a code comment explaining what is going on. why is losing
> precision not a concern? maybe we should do the reverse and multiply?
>
>
> > +        n->tx_timer_activate =3D true;
> > +    } else {
> > +        n->tx_coal_usecs =3D 0;
> > +    }
> > +
> >      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
> >                                      n->net_conf.tx_queue_size);
> >
> > @@ -4046,6 +4188,11 @@ static void virtio_net_device_realize(DeviceStat=
e *dev, Error **errp)
> >              n->rss_data.specified_hash_types.on_bits |
> >              n->rss_data.specified_hash_types.auto_bits;
> >      }
> > +    n->rx_pkt_cnt =3D 0;
> > +    n->tx_pkt_cnt =3D 0;
> > +    n->rx_coal_usecs =3D 0;
> > +    n->rx_coal_packets =3D 0;
> > +    n->tx_coal_packets =3D 0;
> >  }
> >
> >  static void virtio_net_device_unrealize(DeviceState *dev)
> > @@ -4258,6 +4405,8 @@ static const Property virtio_net_properties[] =3D=
 {
> >                        VIRTIO_NET_F_GUEST_USO6, true),
> >      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> >                        VIRTIO_NET_F_HOST_USO, true),
> > +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
> > +                      VIRTIO_NET_F_NOTF_COAL, true),
>
>
> We can't change host features like this without compat machinery.
>

Koushik: To do it, please replicate the changes of hw/core/machine.c
of the commit 1c79ab6937ae938d3dfd4da1c01afc7eb599857e ("virtio-net:
Advertise UDP tunnel GSO support by default"). Afterwards, try
migrating from a QEMU stable version like 11.0 to a QEMU with your
changes.


>
>
> >      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
> >                                    rss_data.specified_hash_types,
> >                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> > index 371e376428..b3a7df5ad8 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -158,6 +158,7 @@ typedef struct VirtioNetRssData {
> >  typedef struct VirtIONetQueue {
> >      VirtQueue *rx_vq;
> >      VirtQueue *tx_vq;
> > +    QEMUTimer *rx_timer;
> >      QEMUTimer *tx_timer;
> >      QEMUBH *tx_bh;
> >      uint32_t tx_waiting;
> > @@ -177,7 +178,6 @@ struct VirtIONet {
> >      /* RSC Chains - temporary storage of coalesced data,
> >         all these data are lost in case of migration */
> >      QTAILQ_HEAD(, VirtioNetRscChain) rsc_chains;
> > -    uint32_t tx_timeout;
> >      int32_t tx_burst;
> >      uint32_t has_vnet_hdr;
> >      size_t host_hdr_len;
> > @@ -230,6 +230,13 @@ struct VirtIONet {
> >      struct EBPFRSSContext ebpf_rss;
> >      uint32_t nr_ebpf_rss_fds;
> >      char **ebpf_rss_fds;
> > +    uint32_t rx_coal_usecs;
> > +    uint32_t rx_coal_packets;
> > +    uint32_t rx_pkt_cnt;
> > +    uint32_t tx_coal_usecs;
> > +    uint32_t tx_coal_packets;
> > +    uint32_t tx_pkt_cnt;
> > +    bool tx_timer_activate;
> >  };
>
> Can we get some documentation on what each of these is?
>
>
> >
> >  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
> > diff --git a/net/passt.c b/net/passt.c
> > index 4ff94ee509..0b0d9e222a 100644
> > --- a/net/passt.c
> > +++ b/net/passt.c
> > @@ -52,6 +52,7 @@ static const int user_feature_bits[] =3D {
> >      VIRTIO_NET_F_GUEST_USO4,
> >      VIRTIO_NET_F_GUEST_USO6,
> >      VIRTIO_NET_F_HOST_USO,
> > +    VIRTIO_NET_F_NOTF_COAL,
> >
> >      /* This bit implies RARP isn't sent by QEMU out of band */
> >      VIRTIO_NET_F_GUEST_ANNOUNCE,
> > diff --git a/net/tap.c b/net/tap.c
> > index 8d7ab6ba6f..ea5987a3dc 100644
> > --- a/net/tap.c
> > +++ b/net/tap.c
> > @@ -62,6 +62,7 @@ static const int kernel_feature_bits[] =3D {
> >      VIRTIO_F_NOTIFICATION_DATA,
> >      VIRTIO_NET_F_RSC_EXT,
> >      VIRTIO_NET_F_HASH_REPORT,
> > +    VIRTIO_NET_F_NOTF_COAL,
> >      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
> >      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
> >      VHOST_INVALID_FEATURE_BIT
> > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > index a4bb49bbcf..f0b3752d7c 100644
> > --- a/net/vhost-user.c
> > +++ b/net/vhost-user.c
> > @@ -54,6 +54,7 @@ static const int user_feature_bits[] =3D {
> >      VIRTIO_NET_F_GUEST_USO4,
> >      VIRTIO_NET_F_GUEST_USO6,
> >      VIRTIO_NET_F_HOST_USO,
> > +    VIRTIO_NET_F_NOTF_COAL,
> >
> >      /* This bit implies RARP isn't sent by QEMU out of band */
> >      VIRTIO_NET_F_GUEST_ANNOUNCE,
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 3df6091274..4ab8f26ceb 100644
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
> > --
> > 2.53.0
>


