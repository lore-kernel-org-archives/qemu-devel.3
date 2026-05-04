Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF8DFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 09:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJprk-0005Ak-Ft; Mon, 04 May 2026 05:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wJpri-0005AV-Fj
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wJpre-0001KN-Oh
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777887920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vH5/5oCtFn8Gg+3MfHp5OJhkqmai4h+7QpqOkcEATg8=;
 b=jEGs3fZ/+JdT5JXhzqDhyn7g8u+Wkeh998CWps9fdr8zWJPbfaitrOfd0Ll9++AGC2aGHx
 3VTmj58t8FVdPrIkDvcwCxuOw3/vOAZTJR9t/+QrGVNFw5MDW+nRddbPDTm/dxGiaDlEVB
 Pl2kdXRsKCz/MDXgGd6y+xZT+oGwPdM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-528iNxCLMlGfbhb57D5DHQ-1; Mon, 04 May 2026 05:45:19 -0400
X-MC-Unique: 528iNxCLMlGfbhb57D5DHQ-1
X-Mimecast-MFC-AGG-ID: 528iNxCLMlGfbhb57D5DHQ_1777887919
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89502dfd7b4so71441966d6.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 02:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777887919; cv=none;
 d=google.com; s=arc-20240605;
 b=l254ubH9eBvdmQ0shI/gB4lUongmrkqbxh4u0/8YDTVJw1b1q5novqJrkzdclZKQFk
 IutwnXuHjhUgRWhnQ20YrkbvwfKHgjGg75h+vvBSxgEcmdW1Y+mXdoqam6ttLmzPk0D8
 0wX1EZC/Fgp47gQ1k+AxM6ABnRkDLM2g+rlUkAVeVFV9rDBc8KaGVCnyrQk8mIBE0l7u
 KpgfJabLbC8hWr+2OOMkyCxqswh3htUMd+86q0hSaUvGuG8sOSoUSnMQ5tuy8Lnn14bY
 LRSSDQKj/T75ntlFJrW02l5fygEcQSAvE5jWeT8Pmj19jSrzoFPRu8SAjXPylj1TbJv9
 PLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vH5/5oCtFn8Gg+3MfHp5OJhkqmai4h+7QpqOkcEATg8=;
 fh=CzNuaiBsYX1c4IFhsROm+UUqGz7Npn4APkAxGNleGhQ=;
 b=HWkt8zjGXKLXImMuUwg2UTAl+fylMsFCEdGjGaaHQRym/sH1a1UJEFfk4a0BSZ9Lyo
 4oxtMPtcXwzb3qYungQXzZdrPrCF0+jSYkbqmqTb73FKx7E34UkIf3aBvRfKq2Qm9CHD
 urCknAw7hmJkvuWRnS4ff6KLMMQ35nFDb1oOmT7vXPg7YliHJcTc+ru8EO3sx/sBecoL
 IJbFD6uxn/P0FXlnqM4FxNHXlBnpwNuxYuhcfRuN9TPK+K99+qOf+V7tEVbeFWSJ5MPR
 A7R9ZVG0UTMP9pz4P2QUKbGaAtYNOBybrU73klWAwYTWemCORiC9ljE9vA37tYcbzWJh
 O6/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777887919; x=1778492719; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vH5/5oCtFn8Gg+3MfHp5OJhkqmai4h+7QpqOkcEATg8=;
 b=mCZi2/yyGsPhdBy4Wd1xjIJDInKOuLSMp9l5jrBGxJGppbafJqEFbFBWQp8x09l6jD
 WcYXAmb/JzjhEdLhP81YyyeTEPbLGp9XYS2DnVyUvAgnx/ID9fExur0cv/sm59umKVz2
 l0mtO+WoTd+SCcemqeiyn8l5LgZwEWww/Cn1QCBPbuUkMDpSMEuAeinne0qmt2vnwRz0
 m0zLS6H4BbkYnwO/UGsVQVrCC84zqs+xQUo7XCZtakeLDOObUMQs58efbm7PvltV4mxA
 6z/KyFl7TFhPCQIbH86m7GJA99xOkcQFqNsmJBbJVPKXTF9sRnj7U64v2e7Bds2LQXGw
 vBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777887919; x=1778492719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vH5/5oCtFn8Gg+3MfHp5OJhkqmai4h+7QpqOkcEATg8=;
 b=NHgbT4MZT3DJSSXTlZ1ATZr1YJeN81Ro4MnwPw1aQGb7luViZ33KklFXNz/abUoWCn
 6eeFqUxaiMJiSNNCUX4XPuZr6NjalOMIB5mmhYaZVbvBYRvum1DcQZYCaErBs9qUqigN
 3M2Xs0WHYKDN6lKsbRw4t6hd69kMe6tRpC+myfxaAtO1zO3SfuLz2D9SnbEj2ZHTvhuE
 dbJF+yaBPGODtRw1pWcn1VOIHYtlRgpXj+ROaMvYDCO4j0+UerqOVykGj2LwAqdqYH4d
 z4VOANMCqJ7OrsUPkKFfapi4p6t6UEswahITy5d4HPd4HjTZgLkAvvdCigkEduTYW9bd
 IQ7Q==
X-Gm-Message-State: AOJu0YwsKwvcYRCWOWHXjjHMOT193tMaAPaRtkjeqYA/iJf1JwtzpNFs
 JF25yZPBFToZjSP5NgZarbVTeqh1e2MpDEFAriPNsD2VzpF5vElQBZ0xODNZLTclOcDS7NkaDCr
 dyeiCvwfuqUnhlKfZMFo+6xgp/6hK8PdNwveTvdGxc7zSOsuKNfbe2PsG7ZaoL0eSA/6/GOaRTd
 WqFiZiVV2jTatnTwH/9eNJVU38n9uaMoY=
X-Gm-Gg: AeBDiesUdTP4ehUPIQv3meHBwiB2IwmziClYrrhLsP4neXAagL4fe+gZexcXu1Vs7Qp
 VdxqCFdvcgJXbX5pvxwYb2Ej7urwWPM+Qg4xtQ8Zr7EQW6Kykpx8fxxUtumnqsPvWi/JExiNp3K
 y8NXNra6d9d+sLcnkdcpaKB2WEB+0SzQp4t1QE9Li9S6Mmco4I5Gae94wDVC3l/GTB1hEJ9TsTr
 r+xzkyHQUpZ/0TJwXZCRfIX15CdH7t//MvKfJ5crxyxcqsxwB5yE9kVPYjAYrqH6ed/qsiLz1zV
 xswpYrFqwztvnrhrLjAkkLWQ5pMxf2u+FQok0Nce7Y5ocY/Z
X-Received: by 2002:a05:6214:5294:b0:8ac:a689:34ca with SMTP id
 6a1803df08f44-8b6698cf18amr147683056d6.44.1777887918589; 
 Mon, 04 May 2026 02:45:18 -0700 (PDT)
X-Received: by 2002:a05:6214:5294:b0:8ac:a689:34ca with SMTP id
 6a1803df08f44-8b6698cf18amr147682716d6.44.1777887918039; Mon, 04 May 2026
 02:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260413121348.655887-1-kdutta@redhat.com>
 <CAJaqyWekxXAqacufabHeuhSnSf4veSoQ4nZ73XKnSgvMyjD7kw@mail.gmail.com>
In-Reply-To: <CAJaqyWekxXAqacufabHeuhSnSf4veSoQ4nZ73XKnSgvMyjD7kw@mail.gmail.com>
From: Koushik Dutta <kdutta@redhat.com>
Date: Mon, 4 May 2026 15:15:06 +0530
X-Gm-Features: AVHnY4KwlZ4OdzIVPGVfnOgNzol5_0Vdik2QZ2c3CJhSlWSs0sgTPdg0FF2wGDA
Message-ID: <CALseRdcE9CHq46Apo6A69xZrtdRC7uG0QEqpJxqNuQPb1xEzgA@mail.gmail.com>
Subject: Re: [PATCH v5] hw/net/virtio-net: add support for notification
 coalescing
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ce385c0650fac9a2"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
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

--000000000000ce385c0650fac9a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 7:55=E2=80=AFPM Eugenio Perez Martin <eperezma@redh=
at.com>
wrote:

> On Mon, Apr 13, 2026 at 2:13=E2=80=AFPM Koushik Dutta <kdutta@redhat.com>=
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
> > - After VM LM coalescing parameters persist in the destination VM.
> >
> > This reduces interrupt overhead by batching notifications based on
> > either a packet count or a time-based threshold.
> >
> > Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> > ---
> >  hw/net/virtio-net.c            | 180 ++++++++++++++++++++++++++++++---
> >  include/hw/virtio/virtio-net.h |   9 ++
> >  net/passt.c                    |   1 +
> >  net/tap.c                      |   1 +
> >  net/vhost-user.c               |   1 +
> >  net/vhost-vdpa.c               |   2 +
> >  6 files changed, 178 insertions(+), 16 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 2a5d642a64..a15e9d17bd 100644
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
> > @@ -1080,6 +1090,53 @@ static int virtio_net_handle_offloads(VirtIONet
> *n, uint8_t cmd,
> >      }
> >  }
> >
> > +static void virtio_net_tx_timer(void *opaque);
> > +
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
>
> If we allocate the timer timer if rx_coal_usecs > 0, should we also
> timer_free it if rx_coal_usecs =3D=3D 0? The same question goes to
> tx_timer actually.


>
Also, virtio_net_del_queue should free rx_timer should be freed the
> same way as q->tx_timer.
>
>
> > +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> > +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> > +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> > +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
> > +        if (n->tx_coal_usecs > 0) {
> > +            for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +                q =3D &n->vqs[i];
> > +                if (!q->tx_timer && n->tx_coal_usecs > 0) {
> > +                    q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                               virtio_net_tx_timer,
> > +                                               q);
> > +                }
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
> > @@ -1581,6 +1638,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice
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
> > @@ -2040,7 +2099,22 @@ static ssize_t
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
> > +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) +
> n->rx_coal_usecs);
> > +            }
> > +        }
> > +    }
> >
> >      return size;
> >
> > @@ -2817,7 +2891,6 @@ detach:
> >      return -EINVAL;
> >  }
> >
> > -static void virtio_net_tx_timer(void *opaque);
> >
> >  static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue
> *vq)
> >  {
> > @@ -2899,6 +2972,12 @@ static void virtio_net_tx_timer(void *opaque)
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
> > @@ -2918,6 +2997,7 @@ static void virtio_net_tx_timer(void *opaque)
> >      ret =3D virtio_net_flush_tx(q);
> >      if (ret > 0) {
> >          virtio_queue_set_notification(q->tx_vq, 0);
> > +        n->tx_pkt_cnt -=3D ret;
> >          q->tx_waiting =3D 1;
> >          timer_mod(q->tx_timer,
> >                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> n->tx_timeout);
> > @@ -2973,6 +3053,32 @@ static void virtio_net_tx_bh(void *opaque)
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
> > @@ -2980,20 +3086,15 @@ static void virtio_net_add_queue(VirtIONet *n,
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
> > @@ -3242,6 +3343,36 @@ static int virtio_net_post_load_device(void
> *opaque, int version_id)
> >      }
> >
> >      virtio_net_commit_rss_config(n);
> > +    if (n->tx_coal_usecs > 0 || n->rx_coal_usecs > 0) {
> > +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
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
> > +                q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                           virtio_net_tx_timer,
> > +                                           q);
> > +            }
> > +
> > +            if (n->tx_coal_usecs > 0 && q->tx_timer) {
> > +                n->tx_pkt_cnt =3D 0;
> > +                timer_mod(q->tx_timer,
> > +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> n->tx_timeout);
> > +            }
> > +
> > +            if (n->rx_coal_usecs > 0 && q->rx_timer) {
> > +                timer_mod(q->rx_timer,
> > +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) +
> n->rx_coal_usecs);
> > +            }
> > +        }
> > +    }
> > +
> >      return 0;
> >  }
> >
> > @@ -3617,6 +3748,10 @@ static const VMStateDescription
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
> > @@ -3970,6 +4105,10 @@ static void virtio_net_device_realize(DeviceStat=
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
> I still think we should disable the coalescing feature if the "timer"
> command line is enabled. Otherwise the guest can override the
> parameter, which is technically doable but I think it's not a desired
> behavior. MST, what do you think?
>

Made changes. If the txtimer property is specified during VM launch, it
takes precedence over any notification coalescing parameters set by the
guest.

>
> >      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
> >                                      n->net_conf.tx_queue_size);
> >
> > @@ -4046,6 +4185,13 @@ static void virtio_net_device_realize(DeviceStat=
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
> > @@ -4258,6 +4404,8 @@ static const Property virtio_net_properties[] =3D=
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
> > index 371e376428..d88f8aef87 100644
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
> > @@ -230,6 +231,14 @@ struct VirtIONet {
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
> This patch does not enable SVQ to handle NOTF_COAL, so this addition is
> invalid.
>
Resolved in V6 patch.

>
> >      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
> >      BIT_ULL(VIRTIO_NET_F_GSO) |
> >      BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
> > --
> > 2.53.0
> >
>
>

--000000000000ce385c0650fac9a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 14,=
 2026 at 7:55=E2=80=AFPM Eugenio Perez Martin &lt;<a href=3D"mailto:eperezm=
a@redhat.com">eperezma@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Mon, Apr 13, 2026 at 2:13=E2=80=AFPM Ko=
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
&gt; - After VM LM coalescing parameters persist in the destination VM.<br>
&gt;<br>
&gt; This reduces interrupt overhead by batching notifications based on<br>
&gt; either a packet count or a time-based threshold.<br>
&gt;<br>
&gt; Signed-off-by: Koushik Dutta &lt;<a href=3D"mailto:kdutta@redhat.com" =
target=3D"_blank">kdutta@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1=
80 ++++++++++++++++++++++++++++++---<br>
&gt;=C2=A0 include/hw/virtio/virtio-net.h |=C2=A0 =C2=A09 ++<br>
&gt;=C2=A0 net/passt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 6 files changed, 178 insertions(+), 16 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index 2a5d642a64..a15e9d17bd 100644<br>
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
&gt; @@ -1080,6 +1090,53 @@ static int virtio_net_handle_offloads(VirtIONet=
 *n, uint8_t cmd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static void virtio_net_tx_timer(void *opaque);<br>
&gt; +<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;rx_coal_usecs &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;=
max_queue_pairs; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D &amp;n-=
&gt;vqs[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;rx=
_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 q-&gt;rx_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_rx_notify,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
If we allocate the timer timer if rx_coal_usecs &gt; 0, should we also<br>
timer_free it if rx_coal_usecs =3D=3D 0? The same question goes to<br>
tx_timer actually.</blockquote><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">=C2=A0<br></blockquote><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
Also, virtio_net_del_queue should free rx_timer should be freed the<br>
same way as q-&gt;tx_timer.<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_coal_usecs =3D le32_to_cpu(coal.=
max_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_coal_packets =3D le32_to_cpu(coa=
l.max_packets);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_timeout =3D n-&gt;tx_coal_usecs =
* 1000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;tx_coal_usecs &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;=
max_queue_pairs; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D &amp;n-=
&gt;vqs[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;tx=
_timer &amp;&amp; n-&gt;tx_coal_usecs &gt; 0) {<br>
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
&gt; +=C2=A0 =C2=A0 return VIRTIO_NET_OK;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iovec *iov, u=
nsigned int iov_cnt)<br>
&gt;=C2=A0 {<br>
&gt; @@ -1581,6 +1638,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *=
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
&gt; @@ -2040,7 +2099,22 @@ static ssize_t virtio_net_receive_rcu(NetClient=
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
 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n-&gt;rx_coal=
_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return size;<br>
&gt;<br>
&gt; @@ -2817,7 +2891,6 @@ detach:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static void virtio_net_tx_timer(void *opaque);<br>
&gt;<br>
&gt;=C2=A0 static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQ=
ueue *vq)<br>
&gt;=C2=A0 {<br>
&gt; @@ -2899,6 +2972,12 @@ static void virtio_net_tx_timer(void *opaque)<b=
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
&gt; @@ -2918,6 +2997,7 @@ static void virtio_net_tx_timer(void *opaque)<br=
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
&gt; @@ -2973,6 +3053,32 @@ static void virtio_net_tx_bh(void *opaque)<br>
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
&gt; @@ -2980,20 +3086,15 @@ static void virtio_net_add_queue(VirtIONet *n,=
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
&gt; @@ -3242,6 +3343,36 @@ static int virtio_net_post_load_device(void *op=
aque, int version_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_net_commit_rss_config(n);<br>
&gt; +=C2=A0 =C2=A0 if (n-&gt;tx_coal_usecs &gt; 0 || n-&gt;rx_coal_usecs &=
gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_timeout =3D n-&gt;tx_coal_usecs =
* 1000;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_queue_pair=
s; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VirtIONetQueue *q =3D &amp;=
n-&gt;vqs[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;rx_timer &amp;&a=
mp; n-&gt;rx_coal_usecs &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;rx_time=
r =3D timer_new_us(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0virtio_net_rx_notify,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;tx_timer &amp;&a=
mp; n-&gt;tx_coal_usecs &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_time=
r =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0virtio_net_tx_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;tx_coal_usecs &gt=
; 0 &amp;&amp; q-&gt;tx_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_pkt_=
cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(q-&=
gt;tx_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n-&gt;tx_time=
out);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;rx_coal_usecs &gt=
; 0 &amp;&amp; q-&gt;rx_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(q-&=
gt;rx_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n-&gt;rx_coal=
_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; @@ -3617,6 +3748,10 @@ static const VMStateDescription vmstate_virtio_=
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
&gt; @@ -3970,6 +4105,10 @@ static void virtio_net_device_realize(DeviceSta=
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
I still think we should disable the coalescing feature if the &quot;timer&q=
uot;<br>
command line is enabled. Otherwise the guest can override the<br>
parameter, which is technically doable but I think it&#39;s not a desired<b=
r>
behavior. MST, what do you think?<br></blockquote><div><br>Made changes. If=
 the txtimer property is specified during VM launch, it takes precedence ov=
er any notification coalescing parameters set by the guest.=C2=A0=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;net_conf.tx_queue_size =3D MIN(virtio_net_ma=
x_tx_queue_size(n),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;net_co=
nf.tx_queue_size);<br>
&gt;<br>
&gt; @@ -4046,6 +4185,13 @@ static void virtio_net_device_realize(DeviceSta=
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
&gt; @@ -4258,6 +4404,8 @@ static const Property virtio_net_properties[] =
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
&gt; index 371e376428..d88f8aef87 100644<br>
&gt; --- a/include/hw/virtio/virtio-net.h<br>
&gt; +++ b/include/hw/virtio/virtio-net.h<br>
&gt; @@ -158,6 +158,7 @@ typedef struct VirtioNetRssData {<br>
&gt;=C2=A0 typedef struct VirtIONetQueue {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtQueue *rx_vq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtQueue *tx_vq;<br>
&gt; +=C2=A0 =C2=A0 QEMUTimer *rx_timer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QEMUTimer *tx_timer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QEMUBH *tx_bh;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t tx_waiting;<br>
&gt; @@ -230,6 +231,14 @@ struct VirtIONet {<br>
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
&gt; diff --git a/net/passt.c b/net/passt.c<br>
&gt; index 4ff94ee509..0b0d9e222a 100644<br>
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
&gt; index 8d7ab6ba6f..ea5987a3dc 100644<br>
&gt; --- a/net/tap.c<br>
&gt; +++ b/net/tap.c<br>
&gt; @@ -62,6 +62,7 @@ static const int kernel_feature_bits[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_F_NOTIFICATION_DATA,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_RSC_EXT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_HASH_REPORT,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_NOTF_COAL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_INVALID_FEATURE_BIT<br>
&gt; diff --git a/net/vhost-user.c b/net/vhost-user.c<br>
&gt; index a4bb49bbcf..f0b3752d7c 100644<br>
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
This patch does not enable SVQ to handle NOTF_COAL, so this addition is inv=
alid.<br></blockquote><div>Resolved in V6 patch.=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_GSO) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BIT_ULL(VIRTIO_NET_F_CTRL_RX) |<br>
&gt; --<br>
&gt; 2.53.0<br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000ce385c0650fac9a2--


