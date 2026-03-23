Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50FCEC01A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4aoZ-0000yX-PF; Mon, 23 Mar 2026 04:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1w4aoY-0000yP-Uf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1w4aoV-000136-BH
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774255145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5F37+DvURTb3RvOIZ7aKatrgupwnvwwoUqRkLlH8Fk=;
 b=ElMCM1c7tR2J9+LpiDj5NR4/NrNAgoS01YgODvxfDT2ME1U2bsGTsBTErmiotvaD6f0+8i
 uck9lkgChiH/lYC6B5jaZ/RdkbwCFyKg4q6xgGU1Bhnw3k37bEw0BoRKqF7VaYCApDtHLZ
 rrB6nIP5H0R+BFoNSXRHo1f+/l/jxsM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-D3VaNNHcOZeendb9NUWZnQ-1; Mon, 23 Mar 2026 04:39:03 -0400
X-MC-Unique: D3VaNNHcOZeendb9NUWZnQ-1
X-Mimecast-MFC-AGG-ID: D3VaNNHcOZeendb9NUWZnQ_1774255143
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89c3f19d4faso258354566d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 01:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774255143; cv=none;
 d=google.com; s=arc-20240605;
 b=hC5szwjJxmkFbRrAJeqz2M0gwn68BRHI/3Ckceo/HfPanS5MFNrYAn5uCPqw/aNQNm
 ZFrXzhPGLVKIArHpVf91rzm11r7skpXNrQNbSo/nmAwVOq2V/sxS/pgPugixdHFdu5ml
 ApWmcTiryduyoIy0SYiLXn1WDTILeFTPOapZ70fnpuUvsULIw9ICrHZWO8MI81nJGmAP
 Ktabu2UctcF28Ag9m92e77ZNRw/RyLUrLMOT+dFCNK5gyMAtjWJJfDxeLgD9wZVgSCLC
 8R6htSqA1XFm75nxyoOQB4f46rLmNa/DHlLKryFUH2K6QUWeVMzfc5HqqoL3IRKgq231
 CX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n5F37+DvURTb3RvOIZ7aKatrgupwnvwwoUqRkLlH8Fk=;
 fh=84qF4z653R2mPeuFksuHMAOE7ajLQhz4LXkbXjKyK98=;
 b=DMOxct7YRbRSkJU1gGlkUI6xVdJTFBLGdE6sNkExbRGfe0IZgOtAEthw1ZmqJ0Up9q
 MTVe1j1ZYXRxikSnwAZlNoQxUtBKkNKKzswR/c6sItRsiBrSTmv72o2TfAGkUAJoNuoy
 4qSykfKEHVQxB3UQQJxxqv4XBsQvARG5umU2mS7ZFgUU9gU5AdnLk64b9BelWgGC6T6J
 cznSiNx8/N190iUkN+ONkOfitDVxMpQoGARrnUxCI5HblymscTLdeVFkN87tded+iYtm
 6q1sjRs2LEL0uFoQBc6BCwGN84oC4UZJHND/G3T1OdwuGCXoN9z4jRBkO25PqO73VSjD
 gHUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774255143; x=1774859943; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n5F37+DvURTb3RvOIZ7aKatrgupwnvwwoUqRkLlH8Fk=;
 b=TY+ifXqrRM9MDxFLCoRgWOwd/Sk1Q5Vs+Qsb+/wiYeDZ+HtLLX5Snn+uQa4OUx9tAx
 bsPsjnrXwlelKDOU5NWzbESlzFlZ0Pttv8N7LJr0cYVmpNXyt1JclSbyAfTxeIawxE5v
 C0WWm5lzkMC/jZeXV0tOL90svoGP/3ibLCpTbiQqFojtF8gRDM8wNfjMVTlXTbcl2BLE
 McWX1PuOsj2OKuv+BgQM4UWx/IaJx9rIX32FNH/SFMhS9zISQZbmxnxOVpQZ7NuHP5d0
 GukR/tC0xLc1bP0/e30yXwMm+MjM1PpN8mQcph4oSyhOdFbASVU25Pzh1GJdpxesxtbW
 jZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774255143; x=1774859943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5F37+DvURTb3RvOIZ7aKatrgupwnvwwoUqRkLlH8Fk=;
 b=lKNmdBWRHOY8W8JUMH0xdeBPagQZ1UJXBIRVQtCIFT2nwmTueXq4rx+rlBjHTxlKxF
 JTdJdD72T/T7eAAf2wvqcC5Jp289AU/7y3XH58AvSM0uGa1AJpMB+inizGQoJP7AjzqK
 gChX+AyLD0/IViyW9t65KpxYEmZhGxTCZFrb/D4lDv4bYshgWvqvPhr44faWP402FVwG
 ximLbvnUcVB1bFCQEDWkc/Bj19LefChZe//R2urO2Cki14zNIOx6OxSgB5DJwGDkZQ4o
 kZVkYUP7WFrLeRRDUnKN/HtfybI+mc+4bFADXT2A1IYjr5yM1Cc3AjsEc4rEjx9syEX3
 +PAw==
X-Gm-Message-State: AOJu0Yw1MZVFJPMhZtO5I1WZhedVW3H7A5lOEGBwx3wTjqWsrH9Wrqow
 TNUMUsF+biZAaEPMpCLl9+Ss1qVp92E995I4KyNtzrYpng3PorkeZctJvyAlzXzLU8wWxlW9/jQ
 WzChDw8GEH+i/LOEe5qJALu7wQo2BzTA+kBFvWuD/QrAAJGqNG2OxXffGH60FvjNT2z4/CaoYvD
 1PwE3jsb4l5m0skI/hZZJ526V084gCPiA=
X-Gm-Gg: ATEYQzxaTWke9/ErFSR8AHvrJnG2OmshIRJ9UUBEX/MnRoQRKtbYQMkjisf2780XdsT
 /R7Q1iZTkbKuG+0wbUc1KEz4f0vVUvnLg5Ne7S8BaOavf/snz600PnZQxTKFsagR0Y8pWeeIr4C
 Y7IEN5uzFXkcbseIVYk+ADjeQqjvZwbpA42C4DZJW8GXVqmmJ3GGRiQ7SOuUTOvQ108Lzt7IkCu
 IS/qnRNfJhw6I9LKDmni0DQwRrpfrw+EtyDAkd4EKwTNjLqbkZ3u4jHKRF6di/MIBeSf2Ui7yYU
 9FjqrLqodOm+NNyjpeWQKHo1JmO6QWy9Zx5s
X-Received: by 2002:a05:6214:194c:b0:89c:637a:6c8 with SMTP id
 6a1803df08f44-89c8543e0fcmr193388636d6.7.1774255142822; 
 Mon, 23 Mar 2026 01:39:02 -0700 (PDT)
X-Received: by 2002:a05:6214:194c:b0:89c:637a:6c8 with SMTP id
 6a1803df08f44-89c8543e0fcmr193388466d6.7.1774255142338; Mon, 23 Mar 2026
 01:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260311132801.292173-1-kdutta@redhat.com>
 <CAJaqyWfHQ-6S1jNnnv0TrTmP5r-GQWdP+PeLtziuUikyg+TFYA@mail.gmail.com>
In-Reply-To: <CAJaqyWfHQ-6S1jNnnv0TrTmP5r-GQWdP+PeLtziuUikyg+TFYA@mail.gmail.com>
From: Koushik Dutta <kdutta@redhat.com>
Date: Mon, 23 Mar 2026 14:08:51 +0530
X-Gm-Features: AQROBzCdtLfcewbh8MSBp7cEe3DVQIiKJw3a6Ytm7gyQQLXF5hvBnd7D7uB-utg
Message-ID: <CALseRdf-2dUhKk51hKn8Kb=GiXA8QqbQG+n+txy6S-B+OJ3mMg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net/virtio-net: add support for notification
 coalescing
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008010d8064dacf7d2"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000008010d8064dacf7d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eugenio,
Regarding the point about not enabling VIRTIO_NET_F_NOTF_COAL
unconditionally: since feature negotiation happens during VM bootup and
coalescing is configured via ethtool after the VM has already booted, how
would we handle this under a conditional property?

If the feature isn't negotiated at the start, we wouldn't be able to enable
it dynamically later. Could you clarify how you'd like the command-line
regulation to interact with the guest's ability to enable it later?
------------------------------------------------------------

> @@ -37,6 +37,7 @@ bool vhost_svq_valid_features(uint64_t features, Error
**errp)
>          case VIRTIO_RING_F_INDIRECT_DESC:
>              continue;
>
> +        case VIRTIO_F_RING_RESET:

This patch does not handle VIRTIO_F_RING_RESET, so this should not be
enabled.

=3D> I included VIRTIO_F_RING_RESET in the valid features list because the
vDPA host device offers it by default; without it, SVQ fails the feature
negotiation check during initialization.
qemu-system-x86_64: -netdev
type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0,x-svq=3Don:=
 SVQ
Invalid device feature flags, offer: 0x1e0010330bfffa7, ok:
0x1e0000330bfffa7

Regards,
Koushik Dutta

On Thu, Mar 12, 2026 at 3:47=E2=80=AFPM Eugenio Perez Martin <eperezma@redh=
at.com>
wrote:

> On Wed, Mar 11, 2026 at 2:28=E2=80=AFPM Koushik Dutta <kdutta@redhat.com>=
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
> > This reduces interrupt overhead by batching notifications based on
> > either a packet count or a time-based threshold.
> >
> > Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> > ---
> >  hw/net/virtio-net.c                | 114 ++++++++++++++++++++++++-----
> >  hw/virtio/vhost-shadow-virtqueue.c |   1 +
> >  hw/virtio/vhost-vdpa.c             |   3 +
> >  include/hw/virtio/virtio-net.h     |   8 ++
> >  net/vhost-vdpa.c                   |  10 +++
> >  5 files changed, 119 insertions(+), 17 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index eccb48ad42..96aa70aea8 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -157,6 +157,15 @@ static void
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
> > +}
> > +
> >  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> >  {
> >      VirtIONet *n =3D VIRTIO_NET(vdev);
> > @@ -1081,6 +1090,29 @@ static int virtio_net_handle_offloads(VirtIONet
> *n, uint8_t cmd,
> >      }
> >  }
> >
> > +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
> > +                                  struct iovec *iov, unsigned int
> iov_cnt)
> > +{
> > +    struct virtio_net_ctrl_coal coal;
> > +    size_t s;
> > +
> > +    s =3D iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
> > +    if (s !=3D sizeof(coal)) {
> > +        return VIRTIO_NET_ERR;
> > +    }
> > +
> > +    if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
> > +        n->rx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> > +        n->rx_coal_packets =3D le32_to_cpu(coal.max_packets);
> > +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> > +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> > +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> > +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
> > +    }
> > +
> > +    return VIRTIO_NET_OK;
> > +}
> > +
> >  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
> >                                   struct iovec *iov, unsigned int
> iov_cnt)
> >  {
> > @@ -1582,6 +1614,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice
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
> > @@ -2041,7 +2075,18 @@ static ssize_t
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
> > +        timer_del(n->rx_index_timer);
> > +        virtio_net_rx_notify(n);
> > +    } else {
> > +        if (n->rx_pkt_cnt =3D=3D i) {
>
> Maybe it's better to check if !timer_pending? It wasn't immediately
> clear to me that `n->rx_pkt_cnt =3D=3D i` until I realized that
> `n->rx_pkt_cnt` is 0 at the beginning of the function for that
> condition to be true.
>
> > +            timer_mod(n->rx_index_timer,
> > +                      qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) +
> n->rx_coal_usecs);
> > +        }
> > +    }
> >
> >      return size;
> >
> > @@ -2900,6 +2945,7 @@ static void virtio_net_tx_timer(void *opaque)
> >      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
> >          return;
> >      }
> > +    n->tx_pkt_cnt -=3D ret;
> >      /*
> >       * If we flush a full burst of packets, assume there are
> >       * more coming and immediately rearm
> > @@ -2919,6 +2965,7 @@ static void virtio_net_tx_timer(void *opaque)
> >      ret =3D virtio_net_flush_tx(q);
> >      if (ret > 0) {
> >          virtio_queue_set_notification(q->tx_vq, 0);
> > +        n->tx_pkt_cnt -=3D ret;
>
> If we got his way, we must control for underflow here.
>
> But I think it should be n->pt_pkt_cnt =3D 0, isn't it?
>
> >          q->tx_waiting =3D 1;
> >          timer_mod(q->tx_timer,
> >                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> n->tx_timeout);
> > @@ -2974,27 +3021,45 @@ static void virtio_net_tx_bh(void *opaque)
> >      }
> >  }
> >
> > -static void virtio_net_add_queue(VirtIONet *n, int index)
> > +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueu=
e
> *vq)
> >  {
> > -    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> > +    VirtIONet *n =3D VIRTIO_NET(vdev);
> >
> > -    n->vqs[index].rx_vq =3D virtio_add_queue(vdev,
> n->net_conf.rx_queue_size,
> > -                                           virtio_net_handle_rx);
> > +    n->tx_pkt_cnt++;
> > +    bool use_timer =3D n->tx_timer_activate || n->tx_coal_usecs > 0 ||
> > +                     n->tx_coal_packets > 0;
>
> No declarations in the middle of the function.
>
> Also, why use_timer =3D true as long as n->tx_coal_packets > 0?
>
> >
> > -    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
> > -        n->vqs[index].tx_vq =3D
> > -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> > -                             virtio_net_handle_tx_timer);
> > -        n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > -                                              virtio_net_tx_timer,
> > -                                              &n->vqs[index]);
> > +    if (use_timer && n->tx_pkt_cnt < n->tx_coal_packets) {
> > +        virtio_net_handle_tx_timer(vdev, vq);
> >      } else {
> > -        n->vqs[index].tx_vq =3D
> > -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> > -                             virtio_net_handle_tx_bh);
> > -        n->vqs[index].tx_bh =3D qemu_bh_new_guarded(virtio_net_tx_bh,
> &n->vqs[index],
> > -
> &DEVICE(vdev)->mem_reentrancy_guard);
> > +        n->tx_pkt_cnt =3D 0;
> > +        virtio_net_handle_tx_bh(vdev, vq);
> >      }
> > +}
> > +
> > +static void virtio_net_add_queue(VirtIONet *n, int index)
> > +{
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> > +
> > +    n->vqs[index].rx_vq =3D
> > +        virtio_add_queue(vdev,
> > +                         n->net_conf.rx_queue_size,
> > +                         virtio_net_handle_rx);
> > +
> > +    n->vqs[index].tx_vq =3D
> > +        virtio_add_queue(vdev,
> > +                         n->net_conf.tx_queue_size,
> > +                         virtio_net_handle_tx_dispatch);
> > +
> > +    n->vqs[index].tx_timer =3D
> > +        timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                     virtio_net_tx_timer,
> > +                     &n->vqs[index]);
>
> We should avoid creating a new timer if it will not be used by
> default. Create it only if cmdline enables it or the guest enable it
> via control vq.
>
> > +
> > +    n->vqs[index].tx_bh =3D
> > +        qemu_bh_new_guarded(virtio_net_tx_bh,
> > +                            &n->vqs[index],
> > +                            &DEVICE(vdev)->mem_reentrancy_guard);
> >
> >      n->vqs[index].tx_waiting =3D 0;
> >      n->vqs[index].n =3D n;
> > @@ -3089,6 +3154,7 @@ static void virtio_net_get_features(VirtIODevice
> *vdev, uint64_t *features,
> >      virtio_features_or(features, features, n->host_features_ex);
> >
> >      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> > +    virtio_add_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
>
> We shouldn't enable VIRTIO_NET_F_NOTF_COAL unconditionally, it should
> be regulated by the cmdline property.
>
> >
> >      if (!peer_has_vnet_hdr(n)) {
> >          virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> > @@ -3972,6 +4038,10 @@ static void virtio_net_device_realize(DeviceStat=
e
> *dev, Error **errp)
> >          error_printf("Defaulting to \"bh\"");
> >      }
> >
> > +    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")) {
> > +        n->tx_timer_activate =3D true;
> > +    }
> > +
> >      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
> >                                      n->net_conf.tx_queue_size);
> >
> > @@ -4048,6 +4118,14 @@ static void virtio_net_device_realize(DeviceStat=
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
> > +    n->rx_index_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> > +                                     virtio_net_rx_notify, n);
>
> Same as the tx timer. Is it worth creating a new timer even if it will
> not be used by default?
>
> >  }
> >
> >  static void virtio_net_device_unrealize(DeviceState *dev)
> > @@ -4262,6 +4340,8 @@ static const Property virtio_net_properties[] =3D=
 {
> >                        VIRTIO_NET_F_GUEST_USO6, true),
> >      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> >                        VIRTIO_NET_F_HOST_USO, true),
> > +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
> > +                      VIRTIO_NET_F_NOTF_COAL, true),
> >      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
> >                                    rss_data.specified_hash_types,
> >                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c
> b/hw/virtio/vhost-shadow-virtqueue.c
> > index 6242aeb69c..104ed0ce8f 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -37,6 +37,7 @@ bool vhost_svq_valid_features(uint64_t features, Erro=
r
> **errp)
> >          case VIRTIO_RING_F_INDIRECT_DESC:
> >              continue;
> >
> > +        case VIRTIO_F_RING_RESET:
>
> This patch does not handle VIRTIO_F_RING_RESET, so this should not be
> enabled.
>
> >          case VIRTIO_F_ACCESS_PLATFORM:
> >              /* SVQ trust in the host's IOMMU to translate addresses */
> >          case VIRTIO_F_VERSION_1:
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index 2f8f11df86..8eb9bdb961 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -1541,6 +1541,9 @@ static int vhost_vdpa_get_features(struct
> vhost_dev *dev,
> >      if (ret =3D=3D 0) {
> >          /* Add SVQ logging capabilities */
> >          *features |=3D BIT_ULL(VHOST_F_LOG_ALL);
> > +
> > +        /* Add notification coalescing features */
> > +        *features |=3D BIT_ULL(VIRTIO_NET_F_NOTF_COAL);
> >      }
> >
> >      return ret;
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
> > index 3df6091274..6a5d0f4cae 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -61,6 +61,7 @@ static const int vdpa_feature_bits[] =3D {
> >      VIRTIO_F_NOTIFY_ON_EMPTY,
> >      VIRTIO_F_RING_PACKED,
> >      VIRTIO_F_RING_RESET,
> > +    VIRTIO_F_ORDER_PLATFORM,
> >      VIRTIO_F_VERSION_1,
> >      VIRTIO_F_IN_ORDER,
> >      VIRTIO_F_NOTIFICATION_DATA,
> > @@ -70,6 +71,8 @@ static const int vdpa_feature_bits[] =3D {
> >      VIRTIO_NET_F_CTRL_RX,
> >      VIRTIO_NET_F_CTRL_RX_EXTRA,
> >      VIRTIO_NET_F_CTRL_VLAN,
> > +    VIRTIO_NET_F_GUEST_ANNOUNCE,
> > +    VIRTIO_NET_F_NOTF_COAL,
>
> Only this feature can be added to vdpa_feature_bits. The rest of them
> must not be added to any other array.
>
> >      VIRTIO_NET_F_CTRL_VQ,
> >      VIRTIO_NET_F_GSO,
> >      VIRTIO_NET_F_GUEST_CSUM,
> > @@ -115,6 +118,13 @@ static const uint64_t vdpa_svq_device_features =3D
> >      BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
> >      BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
> >      BIT_ULL(VIRTIO_NET_F_STATUS) |
> > +    BIT_ULL(VIRTIO_F_RING_RESET) |
> > +    BIT_ULL(VIRTIO_F_ORDER_PLATFORM) |
> > +    BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
> > +    BIT_ULL(VIRTIO_NET_F_GUEST_USO6) |
> > +    BIT_ULL(VIRTIO_NET_F_HOST_USO) |
> > +    BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) |
> > +    BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |
> >      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
> >      BIT_ULL(VIRTIO_NET_F_GSO) |
> >      BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
> > --
> > 2.53.0
> >
>
>

--0000000000008010d8064dacf7d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Eugenio,<br>Regarding the point about not ena=
bling VIRTIO_NET_F_NOTF_COAL unconditionally: since feature negotiation hap=
pens during VM bootup and coalescing is configured via ethtool after the VM=
 has already booted, how would we handle this under a conditional property?=
</div><div><br></div><div>If the feature isn&#39;t negotiated at the start,=
 we wouldn&#39;t be able to enable it dynamically later. Could you clarify =
how you&#39;d like the command-line regulation to interact with the guest&#=
39;s ability to enable it later?<br>---------------------------------------=
---------------------<span class=3D"gmail-im" style=3D"color:inherit"><br><=
br>&gt; @@ -37,6 +37,7 @@ bool vhost_svq_valid_features(uint64_t features, =
Error **errp)<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case VIRTIO_RING_F_=
INDIRECT_DESC:<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cont=
inue;<br>&gt;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case VIRTIO_F_RING_RESET=
:<br><br>This patch does not handle VIRTIO_F_RING_RESET, so this should not=
 be enabled.<br><br></span>=3D&gt; I included=C2=A0<code>VIRTIO_F_RING_RESE=
T</code>=C2=A0in the valid features list because the vDPA host device offer=
s it by default; without it, SVQ fails the feature negotiation check during=
 initialization.=C2=A0</div><div>qemu-system-x86_64: -netdev type=3Dvhost-v=
dpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0,x-svq=3Don: SVQ Invalid d=
evice feature flags, offer: 0x1e0010330bfffa7, ok: 0x1e0000330bfffa7</div><=
div><br></div><div>Regards,</div><div>Koushik Dutta</div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, Mar 12, 2026 at 3:47=E2=80=AFPM Eugenio Perez Martin &lt;<a hre=
f=3D"mailto:eperezma@redhat.com">eperezma@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Mar 11, 2026 at=
 2:28=E2=80=AFPM Koushik Dutta &lt;<a href=3D"mailto:kdutta@redhat.com" tar=
get=3D"_blank">kdutta@redhat.com</a>&gt; wrote:<br>
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
&gt; This reduces interrupt overhead by batching notifications based on<br>
&gt; either a packet count or a time-based threshold.<br>
&gt;<br>
&gt; Signed-off-by: Koushik Dutta &lt;<a href=3D"mailto:kdutta@redhat.com" =
target=3D"_blank">kdutta@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 114 ++++++++++++++++++++++++-----<br>
&gt;=C2=A0 hw/virtio/vhost-shadow-virtqueue.c |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/virtio/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 include/hw/virtio/virtio-net.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
8 ++<br>
&gt;=C2=A0 net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +++<br>
&gt;=C2=A0 5 files changed, 119 insertions(+), 17 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index eccb48ad42..96aa70aea8 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -157,6 +157,15 @@ static void flush_or_purge_queued_packets(NetClie=
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
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *c=
onfig)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(vdev);<br>
&gt; @@ -1081,6 +1090,29 @@ static int virtio_net_handle_offloads(VirtIONet=
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
&gt; +=C2=A0 =C2=A0 size_t s;<br>
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
&gt; +=C2=A0 =C2=A0 } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_coal_usecs =3D le32_to_cpu(coal.=
max_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_coal_packets =3D le32_to_cpu(coa=
l.max_packets);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_timeout =3D n-&gt;tx_coal_usecs =
* 1000;<br>
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
&gt; @@ -1582,6 +1614,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *=
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
&gt; @@ -2041,7 +2075,18 @@ static ssize_t virtio_net_receive_rcu(NetClient=
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(n-&gt;rx_index_timer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_rx_notify(n);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;rx_pkt_cnt =3D=3D i) {<br>
<br>
Maybe it&#39;s better to check if !timer_pending? It wasn&#39;t immediately=
<br>
clear to me that `n-&gt;rx_pkt_cnt =3D=3D i` until I realized that<br>
`n-&gt;rx_pkt_cnt` is 0 at the beginning of the function for that<br>
condition to be true.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(n-&gt;rx_index_ti=
mer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n-&gt;rx_coal_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return size;<br>
&gt;<br>
&gt; @@ -2900,6 +2945,7 @@ static void virtio_net_tx_timer(void *opaque)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 n-&gt;tx_pkt_cnt -=3D ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* If we flush a full burst of packets, assum=
e there are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* more coming and immediately rearm<br>
&gt; @@ -2919,6 +2965,7 @@ static void virtio_net_tx_timer(void *opaque)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D virtio_net_flush_tx(q);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_set_notification(q-&gt;=
tx_vq, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt -=3D ret;<br>
<br>
If we got his way, we must control for underflow here.<br>
<br>
But I think it should be n-&gt;pt_pkt_cnt =3D 0, isn&#39;t it?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_waiting =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(q-&gt;tx_timer,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q=
emu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n-&gt;tx_timeout);<br>
&gt; @@ -2974,27 +3021,45 @@ static void virtio_net_tx_bh(void *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static void virtio_net_add_queue(VirtIONet *n, int index)<br>
&gt; +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQue=
ue *vq)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<br>
&gt; +=C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(vdev);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 n-&gt;vqs[index].rx_vq =3D virtio_add_queue(vdev, n-&gt=
;net_conf.rx_queue_size,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0virtio_net_handle_rx);<br>
&gt; +=C2=A0 =C2=A0 n-&gt;tx_pkt_cnt++;<br>
&gt; +=C2=A0 =C2=A0 bool use_timer =3D n-&gt;tx_timer_activate || n-&gt;tx_=
coal_usecs &gt; 0 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0n-&gt;tx_coal_packets &gt; 0;<br>
<br>
No declarations in the middle of the function.<br>
<br>
Also, why use_timer =3D true as long as n-&gt;tx_coal_packets &gt; 0?<br>
<br>
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
&gt; +=C2=A0 =C2=A0 if (use_timer &amp;&amp; n-&gt;tx_pkt_cnt &lt; n-&gt;tx=
_coal_packets) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_timer(vdev, vq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_bh(vdev, vq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void virtio_net_add_queue(VirtIONet *n, int index)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].rx_vq =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_add_queue(vdev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0n-&gt;net_conf.rx_queue_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0virtio_net_handle_rx);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_vq =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_add_queue(vdev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0n-&gt;net_conf.tx_queue_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0virtio_net_handle_tx_dispatch);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_timer =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0virtio_net_tx_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;n-&gt;vqs[index]);<br>
<br>
We should avoid creating a new timer if it will not be used by<br>
default. Create it only if cmdline enables it or the guest enable it<br>
via control vq.<br>
<br>
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
&gt; @@ -3089,6 +3154,7 @@ static void virtio_net_get_features(VirtIODevice=
 *vdev, uint64_t *features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_features_or(features, features, n-&gt;host_=
features_ex);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);=
<br>
&gt; +=C2=A0 =C2=A0 virtio_add_feature_ex(features, VIRTIO_NET_F_NOTF_COAL)=
;<br>
<br>
We shouldn&#39;t enable VIRTIO_NET_F_NOTF_COAL unconditionally, it should<b=
r>
be regulated by the cmdline property.<br>
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!peer_has_vnet_hdr(n)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_clear_feature_ex(features, VI=
RTIO_NET_F_CSUM);<br>
&gt; @@ -3972,6 +4038,10 @@ static void virtio_net_device_realize(DeviceSta=
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
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;net_conf.tx_queue_size =3D MIN(virtio_net_ma=
x_tx_queue_size(n),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;net_co=
nf.tx_queue_size);<br>
&gt;<br>
&gt; @@ -4048,6 +4118,14 @@ static void virtio_net_device_realize(DeviceSta=
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
&gt; +=C2=A0 =C2=A0 n-&gt;rx_index_timer =3D timer_new_us(QEMU_CLOCK_VIRTUA=
L,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_r=
x_notify, n);<br>
<br>
Same as the tx timer. Is it worth creating a new timer even if it will<br>
not be used by default?<br>
<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static void virtio_net_device_unrealize(DeviceState *dev)<br>
&gt; @@ -4262,6 +4340,8 @@ static const Property virtio_net_properties[] =
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
&gt; diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shad=
ow-virtqueue.c<br>
&gt; index 6242aeb69c..104ed0ce8f 100644<br>
&gt; --- a/hw/virtio/vhost-shadow-virtqueue.c<br>
&gt; +++ b/hw/virtio/vhost-shadow-virtqueue.c<br>
&gt; @@ -37,6 +37,7 @@ bool vhost_svq_valid_features(uint64_t features, Err=
or **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case VIRTIO_RING_F_INDIRECT_DESC:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case VIRTIO_F_RING_RESET:<br>
<br>
This patch does not handle VIRTIO_F_RING_RESET, so this should not be enabl=
ed.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case VIRTIO_F_ACCESS_PLATFORM:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* SVQ trust in the ho=
st&#39;s IOMMU to translate addresses */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case VIRTIO_F_VERSION_1:<br>
&gt; diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c<br>
&gt; index 2f8f11df86..8eb9bdb961 100644<br>
&gt; --- a/hw/virtio/vhost-vdpa.c<br>
&gt; +++ b/hw/virtio/vhost-vdpa.c<br>
&gt; @@ -1541,6 +1541,9 @@ static int vhost_vdpa_get_features(struct vhost_=
dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add SVQ logging capabilities */<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *features |=3D BIT_ULL(VHOST_F_LOG_A=
LL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add notification coalescing features *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *features |=3D BIT_ULL(VIRTIO_NET_F_NOTF_=
COAL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return ret;<br>
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
&gt; index 3df6091274..6a5d0f4cae 100644<br>
&gt; --- a/net/vhost-vdpa.c<br>
&gt; +++ b/net/vhost-vdpa.c<br>
&gt; @@ -61,6 +61,7 @@ static const int vdpa_feature_bits[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_F_NOTIFY_ON_EMPTY,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_F_RING_PACKED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_F_RING_RESET,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_F_ORDER_PLATFORM,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_F_VERSION_1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_F_IN_ORDER,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_F_NOTIFICATION_DATA,<br>
&gt; @@ -70,6 +71,8 @@ static const int vdpa_feature_bits[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_RX,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_RX_EXTRA,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_VLAN,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_ANNOUNCE,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_NOTF_COAL,<br>
<br>
Only this feature can be added to vdpa_feature_bits. The rest of them<br>
must not be added to any other array.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_VQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GSO,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_CSUM,<br>
&gt; @@ -115,6 +118,13 @@ static const uint64_t vdpa_svq_device_features =
=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_HOST_UFO) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_STATUS) |<br>
&gt; +=C2=A0 =C2=A0 BIT_ULL(VIRTIO_F_RING_RESET) |<br>
&gt; +=C2=A0 =C2=A0 BIT_ULL(VIRTIO_F_ORDER_PLATFORM) |<br>
&gt; +=C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |<br>
&gt; +=C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_GUEST_USO6) |<br>
&gt; +=C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_HOST_USO) |<br>
&gt; +=C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) |<br>
&gt; +=C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_GSO) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_CTRL_RX) |<br>
&gt; --<br>
&gt; 2.53.0<br>
&gt;<br>
<br>
</blockquote></div>

--0000000000008010d8064dacf7d2--


