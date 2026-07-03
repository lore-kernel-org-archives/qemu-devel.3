Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FF1C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfWFT-0003tm-KB; Fri, 03 Jul 2026 01:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wfWFS-0003ta-3s
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 01:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wfWFO-00030b-CM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 01:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783055728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BFQ3TyZsiXKhMnnpCQHzKDYof6lMYChcTI/WHOb3XWI=;
 b=CfH8dy09V+q/Px1X6PBlmfwsYIGelelELN2evq2FHaRadGhAAMqHkcK+B8KC0MTJ2efyR6
 IvHXpogAJSMkBdf2DXdISvkfiOPlJ5jybeQxxBGKRT/t8gxol9lMh8myJxaQ38nj/CjQG3
 F2pRZqz6GeO3s+C1YzP/XepUopML890=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-WLd5zDjnPbKtSFPPLMBoqg-1; Fri, 03 Jul 2026 01:15:24 -0400
X-MC-Unique: WLd5zDjnPbKtSFPPLMBoqg-1
X-Mimecast-MFC-AGG-ID: WLd5zDjnPbKtSFPPLMBoqg_1783055724
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1ada6c43so3225811cf.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 22:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783055724; cv=none;
 d=google.com; s=arc-20260327;
 b=IWWDtktvvUKCRELtZtd0nclyWBCJ7/8yxUWJK22Kt//dx4M7TAO3+TAcd5+/16i0KG
 K2LddbrQe33Izqe6g3uCN1CB5E+vSeGA5PcheILoQ3HqFVXWjXcOPY9z/wQIQLWZj/Im
 eKcqMbdl417jsapfE3duugK5ziVXDMKW1ekx6tvPqRJK0x6NZc2jEPAb6W+FlZDwGEwr
 PoqD5c97o3cnaGw04v1ZvrXdFlkF2PiylG/uIWLFyful3SV4DvFPyO6bWnGpWgBAoFT1
 U2QomYdgMYzbIgtj81ejN+grfXIsAdJ8R151eWlLPBL1AF58mHm8saAm4NtR55b4R23V
 pGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BFQ3TyZsiXKhMnnpCQHzKDYof6lMYChcTI/WHOb3XWI=;
 fh=puIT2cFa8D3FepR2+Cvgz3OlserRdg7xY4QFFAUkGBI=;
 b=ToMPaA4ep3sHkjjDSYCEYF2W/fAHq/V4OrIbf28prScCt/Q+9/mjUT2LkLfajNo8Yp
 wJYZeAOUoz9auOf7wpjvhn6VSD9eXxjAgZkkNJW1V277lx+aGTkzgu4s+WDISGVkaYfc
 d8fj3iM32wFpTLEmxB9tYzBzEaaU6Xt+EZ0+Ni3nCat1GRF2fuyylathdHXsTVeTATVt
 DRoLuB2zKtfehkZfxevlGzLnJFQkZGVuZHP7fyY9zuy1DMmIfB8Q87gyZF7sB93gaXd6
 CkxtZrx0tKL/Y7GBsTWLlci7nhJKpReToRZkCvMeNaCpdMLUpJwbAA8UkP9ucyg4EJtg
 Vtqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783055724; x=1783660524; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BFQ3TyZsiXKhMnnpCQHzKDYof6lMYChcTI/WHOb3XWI=;
 b=tJDownJVWbFifvT5pxTRlIoUsMxrMDvZcmQg+yqtAgUq33N81h6BmEyK/E1ToyYbrS
 wbziBs6W7FeiexN9ZQeMoJALh5hnpxbVrQqXhNsgl72jox5XE/XCLy2xzoufl/QXq/re
 54kZSY3OhbJbiZDoMFEvY+EgIA6khntDLDPBwgGtPTh6xMQIvkYIzFJRHnTuqcDQwp1q
 Rz1ys+tZxwkaQPXGevTB1gw8LgDP9wUGmv0VIILBmWMxi0hG0K5CbufZjxrLytKXEhRw
 ox+0j7crig0yy6FesvwXrqe5ILFDdhiHZdFtTXWPGBLByB33ztWOf3Vu6vQBEte42KG1
 xCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783055724; x=1783660524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFQ3TyZsiXKhMnnpCQHzKDYof6lMYChcTI/WHOb3XWI=;
 b=QeNhWd8KkyZ0CfrZbYFhqgreLZ0bYwuKN8yiWpmztG9IlQvKHuCXLunt+F1rZ/Y4YC
 g3xuaXuM0jwHQSCcbVQdApFu5NYwJFUjXexJZnqN0WJdPKGKb3gMXsgsrtOXUI84ufly
 J/8L+t5VIHaFewdyXmyUnZlfG9SnwL/u3yV39fPQNhSqEwXz/CBCUrHtvUScxhMLAf1w
 2XRBybbB9T73grDKT+ewcIj25J2PyRsFdyJVSPbCH8QF5Qlcq59w5k8Y/md5Ys+2m2A9
 ZVhW5qQYFwIK3nyOwmUUH4dm60//+uik2LRT9Pz+nu24U9JyRpvP8+hgGpETfqfeAQWW
 R5aw==
X-Gm-Message-State: AOJu0YwS5cbQ0r8ohT/2gH381gzaTe7CupJ4GSqMMZ2HOkBS5BfDVDDu
 ijL5WCLZ135a8mUp8dLJHq+ewx1XijKe75s6we71uQSKXHiPyeOc+yXXEYshjJZTj64B0XTljZ8
 hSE6o+Eg11B7rtxLwTUiYKpo2lb5g/0IkRk32ZItccmS5Bv6sWgxBMH5yYfooGODpYGcyOmRxah
 BzM+OSWoCCiyAJ79iCLFyxiGRxwAhtpDE=
X-Gm-Gg: AfdE7cksRfCvGkvSBSnAiBg4Bw1asAYUBf2w/iSV0Tm3F+sHIyvMmdAW2Q4tdEZiR6+
 Ttd0HjhV7gnDaTVINvHIVindg1zR85s7Q8Nryc5TRbjnN874B8GboEVg6G8igKEiotFp8qIbk/A
 GBudteuHVhuGbH4CwQe9dqKb5I5nocpgYos4nTJHRUR9G5WgxmJZqCAlCxLeGXBkyYumCWThWuD
 5nHEXwVG9SZcXTCcMv+frOXjJilfNGeXPZTsYZWvOy02Z/aFzQeLIxh0BrUbj6UXrX386QNIZUN
 rnZOc8Iqx5II1jOmUrRrjYIlp/0=
X-Received: by 2002:a05:622a:1143:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-51c26a62c87mr122913381cf.24.1783055723916; 
 Thu, 02 Jul 2026 22:15:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1143:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-51c26a62c87mr122913201cf.24.1783055723452; Thu, 02 Jul 2026
 22:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260613223513.865744-1-kdutta@redhat.com>
 <20260613223513.865744-3-kdutta@redhat.com>
 <CAJaqyWe83xdea8nKL+3ScbFgQ9WFpETJ+gR1UBx4mbnyi=n=nw@mail.gmail.com>
In-Reply-To: <CAJaqyWe83xdea8nKL+3ScbFgQ9WFpETJ+gR1UBx4mbnyi=n=nw@mail.gmail.com>
From: Koushik Dutta <kdutta@redhat.com>
Date: Fri, 3 Jul 2026 10:45:12 +0530
X-Gm-Features: AVVi8Ccj-D-WqWoBrXlW_OCwScjw7wqRKaT4qBogcft6hiSTBnSPEaI2Iq9pWX0
Message-ID: <CALseRdc8vWzN_-3LpFYG=F-35zyQ8WVrG9=mdP7Cn5X=4FGYGw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] [PATCH 2/2] Implement VirtIO Network Notification
 Coalescing (VIRTIO_NET_F_NOTF_COAL). This allows guests to reduce
 interrupt
 overhead by configuring coalescing parameters via ethtool -C for both RX and
 TX paths.
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000002e9670655ae0356"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--00000000000002e9670655ae0356
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 4:22=E2=80=AFPM Eugenio Perez Martin <eperezma@redh=
at.com>
wrote:

> On Sun, Jun 14, 2026 at 12:35=E2=80=AFAM Koushik Dutta <kdutta@redhat.com=
> wrote:
> >
> > The feature supports two coalescing modes:
> > - Time-based: delay notifications up to N microseconds
> > - Count-based: delay until N packets are processed
> >
> > Implementation details:
> > - Added VIRTIO_NET_CTRL_NOTF_COAL class handling in control virtqueue
> > - RX path: batches notifications based on packet count or timeout
> > - TX path: leverages the unified dispatcher to dynamically enable
> >   timer-based coalescing when guest configures it via ethtool
> > - Coalescing parameters persist across live migration
> >
> > Note: During VM launch if we provide tx=3Dtimer, then coalescing featur=
e
> > will not be active. As, user already introduce delay 150ms.
>


>
> ^ Incomplete sentence?
>
Addressed in v9 patch series:
https://patchew.org/QEMU/20260702131632.1180309-1-kdutta@redhat.com/2026070=
2131632.1180309-3-kdutta@redhat.com/


>
> >
> > Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> > ---
> >  hw/net/virtio-net.c            | 144 ++++++++++++++++++++++++++++++++-
> >  include/hw/virtio/virtio-net.h |   7 ++
> >  net/passt.c                    |   1 +
> >  net/tap.c                      |   1 +
> >  net/vhost-user.c               |   1 +
> >  net/vhost-vdpa.c               |   1 +
> >  6 files changed, 154 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 319842cf28..3dbd2f4c11 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -157,6 +157,16 @@ static void
> flush_or_purge_queued_packets(NetClientState *nc)
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
> > @@ -1004,6 +1014,62 @@ static void virtio_net_set_features(VirtIODevice
> *vdev,
> >
> >  static void virtio_net_tx_timer(void *opaque);
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
> > +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +            q =3D &n->vqs[i];
> > +            if (n->rx_coal_usecs > 0) {
> > +                if (!q->rx_timer) {
> > +                    q->rx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                               virtio_net_rx_notify,
> > +                                               q);
> > +                }
> > +            } else {
> > +                if (q->rx_timer) {
> > +                    timer_free(q->rx_timer);
> > +                    q->rx_timer =3D NULL;
>
> Nit: you can use g_clear_pointer here.
>
> Also, virtio_net_del_queue should also remove the timers.
>
Addressed in v9 patch series:
https://patchew.org/QEMU/20260702131632.1180309-1-kdutta@redhat.com/2026070=
2131632.1180309-3-kdutta@redhat.com/


>
> > +                }
> > +            }
> > +        }
> > +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> > +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> > +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> > +        /* Converted us to ns */
> > +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
> > +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +            q =3D &n->vqs[i];
> > +            if (n->tx_coal_usecs > 0) {
> > +                if (!q->tx_timer) {
> > +                    q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                               virtio_net_tx_timer,
> > +                                               q);
> > +                }
> > +            } else {
> > +                if (q->tx_timer) {
> > +                    timer_free(q->tx_timer);
> > +                    q->tx_timer =3D NULL;
> > +                }
> > +           }
> > +        }
> > +    }
> > +
> > +    return VIRTIO_NET_OK;
> > +}
> > +
> >  static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
> >                                       struct iovec *iov, unsigned int
> iov_cnt)
> >  {
> > @@ -1583,6 +1649,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice
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
> > @@ -2042,7 +2110,23 @@ static ssize_t
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
> > +        if (q->rx_timer) {
> > +            timer_del(q->rx_timer);
> > +        }
> > +        virtio_net_rx_notify(q);
> > +    } else {
> > +        if (q->rx_timer) {
> > +            if (!timer_pending(q->rx_timer)) {
> > +                timer_mod(q->rx_timer,
> > +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> > +                          n->rx_coal_usecs * 1000);
> > +            }
> > +        }
> > +    }
> >
> >      return size;
> >
> > @@ -2900,6 +2984,12 @@ static void virtio_net_tx_timer(void *opaque)
> >      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
> >          return;
> >      }
> > +    if (n->tx_pkt_cnt < ret) {
> > +        n->tx_pkt_cnt =3D 0;
> > +    } else {
> > +        n->tx_pkt_cnt -=3D ret;
> > +    }
> > +
>
> I didn't detect this in previous series, but the coalescing parameters
> are per vq, not per device. So the counters and timers should move to
> the vq:
>
> Addressed in v9 patch series:
https://patchew.org/QEMU/20260702131632.1180309-1-kdutta@redhat.com/2026070=
2131632.1180309-3-kdutta@redhat.com/


> "If coalescing parameters are being set, the device applies the last
> coalescing parameters set for a virtqueue, regardless of the command
> used to set the parameters"
>
>
> >      /*
> >       * If we flush a full burst of packets, assume there are
> >       * more coming and immediately rearm
> > @@ -2919,6 +3009,7 @@ static void virtio_net_tx_timer(void *opaque)
> >      ret =3D virtio_net_flush_tx(q);
> >      if (ret > 0) {
> >          virtio_queue_set_notification(q->tx_vq, 0);
> > +        n->tx_pkt_cnt -=3D ret;
> >          q->tx_waiting =3D 1;
> >          timer_mod(q->tx_timer,
> >                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> n->tx_timeout);
> > @@ -2985,6 +3076,20 @@ static void
> virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue *vq)
> >                                         virtio_net_tx_timer, q);
> >          }
> >          virtio_net_handle_tx_timer(vdev, vq);
> > +    } else if (n->tx_coal_usecs > 0) {
> > +        n->tx_pkt_cnt++;
> > +        if (n->tx_pkt_cnt < n->tx_coal_packets) {
> > +            if (q->tx_timer) {
> > +                virtio_net_handle_tx_timer(vdev, vq);
> > +                return;
> > +            }
> > +        } else {
> > +            n->tx_pkt_cnt =3D 0;
> > +            if (q->tx_timer) {
> > +                timer_del(q->tx_timer);
> > +            }
> > +            virtio_net_handle_tx_bh(vdev, vq);
> > +        }
> >      } else {
> >          virtio_net_handle_tx_bh(vdev, vq);
> >      }
> > @@ -3098,6 +3203,9 @@ static void virtio_net_get_features(VirtIODevice
> *vdev, uint64_t *features,
> >      virtio_features_or(features, features, n->host_features_ex);
> >
> >      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> > +    if (n->tx_timer_activate) {
> > +        virtio_clear_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
> > +    }
> >
> >      if (!peer_has_vnet_hdr(n)) {
> >          virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> > @@ -3252,6 +3360,29 @@ static int virtio_net_post_load_device(void
> *opaque, int version_id)
> >      }
> >
> >      virtio_net_commit_rss_config(n);
> > +    if (n->tx_coal_usecs > 0 || n->rx_coal_usecs > 0) {
> > +
> > +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +            VirtIONetQueue *q =3D &n->vqs[i];
> > +            if (n->rx_coal_usecs > 0) {
> > +                if (!q->rx_timer) {
> > +                    q->rx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                               virtio_net_rx_notify,
> > +                                               q);
> > +                }
> > +            }
> > +
> > +            if (n->tx_coal_usecs > 0) {
> > +                n->tx_timeout =3D n->tx_coal_usecs * 1000;
> > +                if (!q->tx_timer) {
> > +                    q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                               virtio_net_tx_timer,
> > +                                               q);
> > +                }
> > +            }
> > +        }
> > +    }
> > +
> >      return 0;
> >  }
> >
> > @@ -3627,6 +3758,10 @@ static const VMStateDescription
> vmstate_virtio_net_device =3D {
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
> > @@ -4060,6 +4195,11 @@ static void virtio_net_device_realize(DeviceStat=
e
> *dev, Error **errp)
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
> > @@ -4272,6 +4412,8 @@ static const Property virtio_net_properties[] =3D=
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
> > index a4eb3f407e..9612416622 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -159,6 +159,7 @@ typedef struct VirtIONetQueue {
> >      VirtQueue *rx_vq;
> >      VirtQueue *tx_vq;
> >      QEMUTimer *tx_timer;
> > +    QEMUTimer *rx_timer;
> >      QEMUBH *tx_bh;
> >      uint32_t tx_waiting;
> >      struct {
> > @@ -230,6 +231,12 @@ struct VirtIONet {
> >      struct EBPFRSSContext ebpf_rss;
> >      uint32_t nr_ebpf_rss_fds;
> >      char **ebpf_rss_fds;
> > +    uint32_t rx_coal_usecs; /* RX interrupt coalescing timeout
> (microseconds) */
> > +    uint32_t rx_coal_packets; /* RX packet count threshold for
> coalescing */
> > +    uint32_t rx_pkt_cnt; /* Current RX packet count since last
> notification */
> > +    uint32_t tx_coal_usecs; /* TX interrupt coalescing timeout
> (microseconds) */
> > +    uint32_t tx_coal_packets; /* TX packet count threshold for
> coalescing */
> > +    uint32_t tx_pkt_cnt; /* Current TX packet count since last
> notification */
> >      bool tx_timer_activate;
> >  };
> >
> > diff --git a/net/passt.c b/net/passt.c
> > index 45440c399b..43b36ed8c5 100644
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
> > index 57ffb09885..e6ddbc1eb1 100644
> > --- a/net/tap.c
> > +++ b/net/tap.c
> > @@ -63,6 +63,7 @@ static const int kernel_feature_bits[] =3D {
> >      VIRTIO_F_NOTIFICATION_DATA,
> >      VIRTIO_NET_F_RSC_EXT,
> >      VIRTIO_NET_F_HASH_REPORT,
> > +    VIRTIO_NET_F_NOTF_COAL,
> >      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
> >      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
> >      VHOST_INVALID_FEATURE_BIT
> > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > index 2d0fc49b4d..f1e9b7a038 100644
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
> > index f1523697e2..0dcd6fb9f1 100644
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
> >
>
>

--00000000000002e9670655ae0356
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 25,=
 2026 at 4:22=E2=80=AFPM Eugenio Perez Martin &lt;<a href=3D"mailto:eperezm=
a@redhat.com">eperezma@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Sun, Jun 14, 2026 at 12:35=E2=80=AFAM K=
oushik Dutta &lt;<a href=3D"mailto:kdutta@redhat.com" target=3D"_blank">kdu=
tta@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The feature supports two coalescing modes:<br>
&gt; - Time-based: delay notifications up to N microseconds<br>
&gt; - Count-based: delay until N packets are processed<br>
&gt;<br>
&gt; Implementation details:<br>
&gt; - Added VIRTIO_NET_CTRL_NOTF_COAL class handling in control virtqueue<=
br>
&gt; - RX path: batches notifications based on packet count or timeout<br>
&gt; - TX path: leverages the unified dispatcher to dynamically enable<br>
&gt;=C2=A0 =C2=A0timer-based coalescing when guest configures it via ethtoo=
l<br>
&gt; - Coalescing parameters persist across live migration<br>
&gt;<br>
&gt; Note: During VM launch if we provide tx=3Dtimer, then coalescing featu=
re<br>
&gt; will not be active. As, user already introduce delay 150ms.<br></block=
quote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
^ Incomplete sentence?<br></blockquote><div><span style=3D"background-color=
:transparent">Addressed in v9 patch series:=C2=A0<a href=3D"https://patchew=
.org/QEMU/20260702131632.1180309-1-kdutta@redhat.com/20260702131632.1180309=
-3-kdutta@redhat.com/">https://patchew.org/QEMU/20260702131632.1180309-1-kd=
utta@redhat.com/20260702131632.1180309-3-kdutta@redhat.com/</a></span>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Signed-off-by: Koushik Dutta &lt;<a href=3D"mailto:kdutta@redhat.com" =
target=3D"_blank">kdutta@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1=
44 ++++++++++++++++++++++++++++++++-<br>
&gt;=C2=A0 include/hw/virtio/virtio-net.h |=C2=A0 =C2=A07 ++<br>
&gt;=C2=A0 net/passt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 6 files changed, 154 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index 319842cf28..3dbd2f4c11 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -157,6 +157,16 @@ static void flush_or_purge_queued_packets(NetClie=
ntState *nc)<br>
&gt;=C2=A0 =C2=A0* - we could suppress RX interrupt if we were so inclined.=
<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;<br>
&gt; +static void virtio_net_rx_notify(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIONetQueue *q =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 VirtIONet *n =3D q-&gt;n;<br>
&gt; +=C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;rx_vq);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *c=
onfig)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(vdev);<br>
&gt; @@ -1004,6 +1014,62 @@ static void virtio_net_set_features(VirtIODevic=
e *vdev,<br>
&gt;<br>
&gt;=C2=A0 static void virtio_net_tx_timer(void *opaque);<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_queue_pair=
s; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D &amp;n-&gt;vqs[i];<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;rx_coal_usecs &gt=
; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;rx=
_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 q-&gt;rx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_rx_notify,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;rx_=
timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 timer_free(q-&gt;rx_timer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 q-&gt;rx_timer =3D NULL;<br>
<br>
Nit: you can use g_clear_pointer here.<br>
<br>
Also, virtio_net_del_queue should also remove the timers.<br></blockquote><=
div><span style=3D"background-color:transparent">Addressed in v9 patch seri=
es:=C2=A0<a href=3D"https://patchew.org/QEMU/20260702131632.1180309-1-kdutt=
a@redhat.com/20260702131632.1180309-3-kdutta@redhat.com/">https://patchew.o=
rg/QEMU/20260702131632.1180309-1-kdutta@redhat.com/20260702131632.1180309-3=
-kdutta@redhat.com/</a></span>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_coal_usecs =3D le32_to_cpu(coal.=
max_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_coal_packets =3D le32_to_cpu(coa=
l.max_packets);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Converted us to ns */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_timeout =3D n-&gt;tx_coal_usecs =
* 1000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_queue_pair=
s; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D &amp;n-&gt;vqs[i];<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;tx_coal_usecs &gt=
; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;tx=
_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 q-&gt;tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_tx_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_=
timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 timer_free(q-&gt;tx_timer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 q-&gt;tx_timer =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return VIRTIO_NET_OK;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 iovec *iov, unsigned int iov_cnt)<br>
&gt;=C2=A0 {<br>
&gt; @@ -1583,6 +1649,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *=
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
&gt; @@ -2042,7 +2110,23 @@ static ssize_t virtio_net_receive_rcu(NetClient=
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;rx_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(q-&gt;rx_timer);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_rx_notify(q);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;rx_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!timer_pending(q-&gt;rx=
_timer)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(q-&=
gt;rx_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 n-&gt;rx_coal_usecs * 1000);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return size;<br>
&gt;<br>
&gt; @@ -2900,6 +2984,12 @@ static void virtio_net_tx_timer(void *opaque)<b=
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
<br>
I didn&#39;t detect this in previous series, but the coalescing parameters<=
br>
are per vq, not per device. So the counters and timers should move to<br>
the vq:<br>
<br></blockquote><div>Addressed in v9 patch series:=C2=A0<a href=3D"https:/=
/patchew.org/QEMU/20260702131632.1180309-1-kdutta@redhat.com/20260702131632=
.1180309-3-kdutta@redhat.com/">https://patchew.org/QEMU/20260702131632.1180=
309-1-kdutta@redhat.com/20260702131632.1180309-3-kdutta@redhat.com/</a><br>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&quot;If coalescing parameters are being set, the device applies the last<b=
r>
coalescing parameters set for a virtqueue, regardless of the command<br>
used to set the parameters&quot;<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* If we flush a full burst of packets, assum=
e there are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* more coming and immediately rearm<br>
&gt; @@ -2919,6 +3009,7 @@ static void virtio_net_tx_timer(void *opaque)<br=
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
&gt; @@ -2985,6 +3076,20 @@ static void virtio_net_handle_tx_dispatch(VirtI=
ODevice *vdev, VirtQueue *vq)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0virtio_net_tx_timer, q);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_timer(vdev, vq)=
;<br>
&gt; +=C2=A0 =C2=A0 } else if (n-&gt;tx_coal_usecs &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;tx_pkt_cnt &lt; n-&gt;tx_coal_p=
ackets) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_ha=
ndle_tx_timer(vdev, vq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(q-&=
gt;tx_timer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_bh(vde=
v, vq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_bh(vdev, vq);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -3098,6 +3203,9 @@ static void virtio_net_get_features(VirtIODevice=
 *vdev, uint64_t *features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_features_or(features, features, n-&gt;host_=
features_ex);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);=
<br>
&gt; +=C2=A0 =C2=A0 if (n-&gt;tx_timer_activate) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_clear_feature_ex(features, VIRTIO_=
NET_F_NOTF_COAL);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!peer_has_vnet_hdr(n)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_clear_feature_ex(features, VI=
RTIO_NET_F_CSUM);<br>
&gt; @@ -3252,6 +3360,29 @@ static int virtio_net_post_load_device(void *op=
aque, int version_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_net_commit_rss_config(n);<br>
&gt; +=C2=A0 =C2=A0 if (n-&gt;tx_coal_usecs &gt; 0 || n-&gt;rx_coal_usecs &=
gt; 0) {<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_queue_pair=
s; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VirtIONetQueue *q =3D &amp;=
n-&gt;vqs[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;rx_coal_usecs &gt=
; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;rx=
_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 q-&gt;rx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_rx_notify,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;tx_coal_usecs &gt=
; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_time=
out =3D n-&gt;tx_coal_usecs * 1000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;tx=
_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 q-&gt;tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_tx_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; @@ -3627,6 +3758,10 @@ static const VMStateDescription vmstate_virtio_=
net_device =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_virtio_net_tx_waiting),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64_TEST(curr_guest_offlo=
ads, VirtIONet,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 has_ctrl_guest_offloads),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_coal_usecs, VirtIONet),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_coal_usecs, VirtIONet),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_coal_packets, VirtIONet=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_coal_packets, VirtIONet=
),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .subsections =3D (const VMStateDescription * const=
 []) {<br>
&gt; @@ -4060,6 +4195,11 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.specifi=
ed_hash_types.on_bits |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.specifi=
ed_hash_types.auto_bits;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;tx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rx_coal_usecs =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rx_coal_packets =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;tx_coal_packets =3D 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static void virtio_net_device_unrealize(DeviceState *dev)<br>
&gt; @@ -4272,6 +4412,8 @@ static const Property virtio_net_properties[] =
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
&gt; index a4eb3f407e..9612416622 100644<br>
&gt; --- a/include/hw/virtio/virtio-net.h<br>
&gt; +++ b/include/hw/virtio/virtio-net.h<br>
&gt; @@ -159,6 +159,7 @@ typedef struct VirtIONetQueue {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtQueue *rx_vq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtQueue *tx_vq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QEMUTimer *tx_timer;<br>
&gt; +=C2=A0 =C2=A0 QEMUTimer *rx_timer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QEMUBH *tx_bh;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t tx_waiting;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct {<br>
&gt; @@ -230,6 +231,12 @@ struct VirtIONet {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct EBPFRSSContext ebpf_rss;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t nr_ebpf_rss_fds;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char **ebpf_rss_fds;<br>
&gt; +=C2=A0 =C2=A0 uint32_t rx_coal_usecs; /* RX interrupt coalescing time=
out (microseconds) */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rx_coal_packets; /* RX packet count threshold =
for coalescing */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rx_pkt_cnt; /* Current RX packet count since l=
ast notification */<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_coal_usecs; /* TX interrupt coalescing time=
out (microseconds) */<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_coal_packets; /* TX packet count threshold =
for coalescing */<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_pkt_cnt; /* Current TX packet count since l=
ast notification */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool tx_timer_activate;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; diff --git a/net/passt.c b/net/passt.c<br>
&gt; index 45440c399b..43b36ed8c5 100644<br>
&gt; --- a/net/passt.c<br>
&gt; +++ b/net/passt.c<br>
&gt; @@ -52,6 +52,7 @@ static const int user_feature_bits[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_USO4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_USO6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_HOST_USO,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_NOTF_COAL,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* This bit implies RARP isn&#39;t sent by QEMU ou=
t of band */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_ANNOUNCE,<br>
&gt; diff --git a/net/tap.c b/net/tap.c<br>
&gt; index 57ffb09885..e6ddbc1eb1 100644<br>
&gt; --- a/net/tap.c<br>
&gt; +++ b/net/tap.c<br>
&gt; @@ -63,6 +63,7 @@ static const int kernel_feature_bits[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_F_NOTIFICATION_DATA,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_RSC_EXT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_HASH_REPORT,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_NOTF_COAL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_INVALID_FEATURE_BIT<br>
&gt; diff --git a/net/vhost-user.c b/net/vhost-user.c<br>
&gt; index 2d0fc49b4d..f1e9b7a038 100644<br>
&gt; --- a/net/vhost-user.c<br>
&gt; +++ b/net/vhost-user.c<br>
&gt; @@ -54,6 +54,7 @@ static const int user_feature_bits[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_USO4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_USO6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_HOST_USO,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_NOTF_COAL,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* This bit implies RARP isn&#39;t sent by QEMU ou=
t of band */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_ANNOUNCE,<br>
&gt; diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c<br>
&gt; index f1523697e2..0dcd6fb9f1 100644<br>
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
&gt; --<br>
&gt; 2.53.0<br>
&gt;<br>
<br>
</blockquote></div></div>

--00000000000002e9670655ae0356--


