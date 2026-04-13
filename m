Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644C5F34C5C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCIQP-0006QH-Ns; Mon, 13 Apr 2026 10:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wCIQO-0006Q9-T2
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 10:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wCIQL-0006nP-FQ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 10:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776091077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ijvxb1Ec2VXKzrc3iCCp4Wm84IXXHXRHMnW1BmI6Xo=;
 b=DrRDBI4xucl+Fiq8EqW58uUAXug3GkWY/W6WW6918mE49e+sNAQ6FoPrcMkRg94swtM1el
 u0yvN4GUmroU6Yf1apYQ7hvfZ8xVKYaUCs8SnU6lqzb9p1CkMH1QZuia1jVvDwCPiU0fgj
 oanIxw5vLc8bsDJ45/9xaVaH4wormB4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-9LYSSfTVNkeEJO9lL2c-TQ-1; Mon, 13 Apr 2026 10:37:51 -0400
X-MC-Unique: 9LYSSfTVNkeEJO9lL2c-TQ-1
X-Mimecast-MFC-AGG-ID: 9LYSSfTVNkeEJO9lL2c-TQ_1776091071
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-79a51ba2bf9so130766697b3.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 07:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776091071; cv=none;
 d=google.com; s=arc-20240605;
 b=QzKoJDr7OKFq3EPKpEENywpNWFQYJIc/PtbLrpo3TCnSg2F28TC3W32ttG8TKT16tE
 MK5svGAAvgGplTN9psFtu6O5bE2zG7GLQrfatQvdna/tCWn7NWVkm4QLLn2h4CtP3deF
 JwZwdhhSqJmA+51O+nNjc+qwCDv6sDWX8I7g3/5Z7IQE6EYStmn5k8WVdvI7CVtgR5eW
 cXB+1zPtewchvMT4nM/Rquvb869N1WRBABPkByZtj/bQnFOEp4FcpFDZAFKJt/ZopBPk
 NURszYBbl6qN5oAm51ULcVSsPhK31KB2DE8i3RDKJUBZq7kilLU/8p0QfEGW5Cd8CB89
 v+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2ijvxb1Ec2VXKzrc3iCCp4Wm84IXXHXRHMnW1BmI6Xo=;
 fh=2j1OPIc+H3IgInHX+gBxX5VNmvDfIM4Z/c1hsqkYxuE=;
 b=fTl3hwYNSGJXZMQn8csMgi9WHIlz4BwmnAURFfgULWguANl5mlB5VPZNw+QQH5+SwS
 8VBuvvbMEdgVZHXauFSonEyDhfYRix1pN3OX+G1zh4f4S0L40UYTlQShlp7o71/Y1Nnr
 panXiFu1Cb73L2Xw+5fXaMzxorgNKBBRdDhNabfH7Q3llmi7hOPLiDFp1lAGGshXLqwK
 8C7LFZ848DQqmjUGE+w07b39HF0BcJYphh6+AC6QAZ7NDcNd2QGGGmu6CK0iNY/0N/+4
 gbxvPFbxiWerRQawfMLVeNDCwXeB9Tcg1pXkRi8A1+VdWAY2SE0BGOP3wMhok1YGG0oL
 2q/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776091071; x=1776695871; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ijvxb1Ec2VXKzrc3iCCp4Wm84IXXHXRHMnW1BmI6Xo=;
 b=Mg9vs6tFTaoY92SEFR1LvKvwNbUH5DUJQ7/zPZgzB7APgOtqJy5P/JWz9N8rZLQs2T
 rj1iKJywh511U/mwF2yspBdzbOKPFdJ1R+srtXKbel8sUpwLww03KppnJyds4uDfCJhZ
 L991f8KLhb2yN8lIdATXpDQUAGGH9Ls2UqAy0VTmP+jJ4xGjShA2uCKeMvUtd4BzZAI5
 3Y0t3L9P2uu08IPMQXVoddLrkZc/oUKY98q6b4wCnTGdaB7/DALcDPaH9RnbDtkmhNAL
 QT7lgyCKHRjRJ3X0mcC12pRmIDZZezaz+nymmB/JUEiNtbiy5MrHh0GeUA03OeeE33EZ
 33gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776091071; x=1776695871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ijvxb1Ec2VXKzrc3iCCp4Wm84IXXHXRHMnW1BmI6Xo=;
 b=TlQSNrsm11oMVVx7yoZ2k8CpeCGiDV3D+lIQkcKsfCTI/ATmdAQwSQdToUmVFSGaly
 B5jB1iEdq5lCsyKOo+9OqvcD6uqeBV100qiXaVK1ga4jzvLqHEngrLui9kNvi+xYaPCS
 oPHmzi8KLh1/REQPERfIQEpFGfM1g1R4/Afa/zShebAVXn/Cn0zb/npwOO6CObIzh3oR
 +/MqWROpmSI9M4DNLq00/L6aW4mPspQAkVc0sDxyhQO5vtWA+wAS6L0Tc5ND/QGM2axs
 SjUxWjgu7LvDPEs9wpZnEuBt95MWYwA+4O8ZH83kXA8b5Q1/dZv+r3dhIMyS+dfFBYLs
 bB+Q==
X-Gm-Message-State: AOJu0YzyGR7HopiEe5nXPkqg8PNzqyR4AM76kdmwS+iLCcSOkQCiHr6u
 fF52jlE/63KRuwqoLi07YC7DXUHtkelV6LOq64UwiTmQPN3OyFfo92IBhlV13w/413tyuN3bA8M
 W91/kzfAiNMUAK5xESegx08OGkkpuj6GKNXvtYmaxRR+2XsxdRYmw1pp0kg0fGCx4p86NJETcIB
 nAU3AtleWdhjwyxyUUCrERpQl/lDEvjlk=
X-Gm-Gg: AeBDiesOD1PcIbWVFAygIlO8iiCs+E/LVS985Vqfl7pBsE8zaSVFtWKw8CGAoRNOIfc
 iWaM6F6U1qHndpEK5KUf3pCSZxwd4YRFU0YqExhYpJ4ld88qltG2IOSYNpiEIikEx6tSvevOHoe
 kp4ghyK/bFVO/5LFjQNj9hISLME0eoo3mLqsZgdQLnU9ydCGY0dU/GNoBgH7bMMmfjzebrFB2xI
 jU=
X-Received: by 2002:a05:690c:386:b0:79c:3750:4894 with SMTP id
 00721157ae682-7af7282a9bamr153778807b3.51.1776091071017; 
 Mon, 13 Apr 2026 07:37:51 -0700 (PDT)
X-Received: by 2002:a05:690c:386:b0:79c:3750:4894 with SMTP id
 00721157ae682-7af7282a9bamr153778377b3.51.1776091070382; Mon, 13 Apr 2026
 07:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260330122917.468225-1-kdutta@redhat.com>
 <CAJaqyWd3CqDQXizLxNcMYM9CA=K1LfR_XDaO6ksrnw6StWDBKg@mail.gmail.com>
 <CALseRdeOWhdDszbqm=9kkuj1oUKfn_nF37+vGqEdmTAa86wkkg@mail.gmail.com>
In-Reply-To: <CALseRdeOWhdDszbqm=9kkuj1oUKfn_nF37+vGqEdmTAa86wkkg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 13 Apr 2026 16:37:13 +0200
X-Gm-Features: AQROBzDWMhigWY-jWe2DMRKuGYxEJ0IwL8x6_kBo83bea7ubCRDU7wCSpzVW-2w
Message-ID: <CAJaqyWdoa+kVem6gRd0P1H4dOeMmYmbvobTvxmzO9XYEYN0zrw@mail.gmail.com>
Subject: Re: [PATCH v4] hw/net/virtio-net: add support for notification
 coalescing
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
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

On Mon, Apr 13, 2026 at 3:40=E2=80=AFPM Koushik Dutta <kdutta@redhat.com> w=
rote:
>
>
>
> On Tue, Mar 31, 2026 at 4:42=E2=80=AFPM Eugenio Perez Martin <eperezma@re=
dhat.com> wrote:
>>
>> On Mon, Mar 30, 2026 at 2:29=E2=80=AFPM Koushik Dutta <kdutta@redhat.com=
> wrote:
>> >
>> > Implement VirtIO Network Notification Coalescing (Bit 53).
>> > This allows the guest to manage interrupt frequency using ethtool
>> > -C for both RX and TX paths.
>> >
>> > - Added VIRTIO_NET_F_NOTF_COAL to host features.
>> > - Implemented VIRTIO_NET_CTRL_NOTF_COAL class handling in
>> >   virtio_net_handle_ctrl_iov.
>> > - Added logic to store and apply rx/tx usecs and max_packets.
>> > - Added packet counters and threshold logic for both RX and TX data pa=
ths.
>> > - Dynamic Dispatcher: Implemented a dispatcher mechanism that
>> >   dynamically switches/activates the notification callback logic
>> >   only after the guest enables TX coalescing via ethtool.
>> >
>> > vhost-vdpa: add support for SVQ interrupt coalescing.
>> >
>>
>> This patch still does not add vhost-vdpa support.
>>
>>
>> > This reduces interrupt overhead by batching notifications based on
>> > either a packet count or a time-based threshold.
>> >
>> > Signed-off-by: Koushik Dutta <kdutta@redhat.com>
>> > ---
>> >  hw/net/virtio-net.c            | 137 +++++++++++++++++++++++++++++---=
-
>> >  include/hw/virtio/virtio-net.h |   8 ++
>> >  net/vhost-vdpa.c               |   2 +
>> >  3 files changed, 131 insertions(+), 16 deletions(-)
>> >
>> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> > index eccb48ad42..16f197cbdb 100644
>> > --- a/hw/net/virtio-net.c
>> > +++ b/hw/net/virtio-net.c
>> > @@ -131,6 +131,8 @@ static const VirtIOConfigSizeParams cfg_size_param=
s =3D {
>> >      .feature_sizes =3D feature_sizes
>> >  };
>> >
>> > +static void virtio_net_tx_timer(void *opaque);
>> > +
>>
>> Nit: I think it's better to move yhis declaration just before the
>> function that uses it.
>
> Resolved in V5 patch set.
>>
>>
>> >  static VirtIONetQueue *virtio_net_get_subqueue(NetClientState *nc)
>> >  {
>> >      VirtIONet *n =3D qemu_get_nic_opaque(nc);
>> > @@ -157,6 +159,15 @@ static void flush_or_purge_queued_packets(NetClie=
ntState *nc)
>> >   * - we could suppress RX interrupt if we were so inclined.
>> >   */
>> >
>> > +static void virtio_net_rx_notify(void *opaque)
>> > +{
>> > +    VirtIONet *n =3D opaque;
>> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>> > +
>> > +    n->rx_pkt_cnt =3D 0;
>> > +    virtio_notify(vdev, n->vqs[0].rx_vq);
>>
>> If we keep the code this way, this function should iterate through all
>> the rx queues.
>>
>> I'm ok with this version, but it feels more natural to me if each RX
>> VQ has its own RX timer. This paves the way for per-vq coalescing and
>> aligns with the tx code. This version has fewer timers and simplifies
>> some things, so I think it is ok for the moment.
>>
> Resolved in V5 patch set.
>
>>
>> > +}
>> > +
>> >  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config=
)
>> >  {
>> >      VirtIONet *n =3D VIRTIO_NET(vdev);
>> > @@ -1081,6 +1092,43 @@ static int virtio_net_handle_offloads(VirtIONet=
 *n, uint8_t cmd,
>> >      }
>> >  }
>> >
>> > +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
>> > +                                  struct iovec *iov, unsigned int iov=
_cnt)
>> > +{
>> > +    struct virtio_net_ctrl_coal coal;
>> > +    VirtIONetQueue *q;
>> > +    size_t s;
>> > +    int i;
>> > +
>> > +    s =3D iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
>> > +    if (s !=3D sizeof(coal)) {
>> > +        return VIRTIO_NET_ERR;
>> > +    }
>> > +
>> > +    if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
>> > +        n->rx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
>> > +        n->rx_coal_packets =3D le32_to_cpu(coal.max_packets);
>> > +        if (!n->rx_index_timer) {
>>
>> n->rx_index_timer && n->rx_coal_usecs > 0 ? Also delete it if
>> rx_coal_usecs =3D=3D 0?
>>
>> > +            n->rx_index_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
>> > +                                             virtio_net_rx_notify, n)=
;
>> > +        }
>> > +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
>> > +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
>> > +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
>> > +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
>>
>> If n->tx_timeout is only used to convert us to ms, we should not
>> allocate a variable for this and just multiply by 1000 at the timer
>> creation time.
>
>
> The `tx_timeout` variable is already present in the source code. I have u=
sed the tx_timeout variable to hold the user-given tx coal value in us to n=
s.

So can we just remove tx_timeout and use tx_coal_usecs instead?

>>
>>
>> > +        for (i =3D 0; i < n->max_queue_pairs; i++) {
>> > +            q =3D &n->vqs[i];
>> > +            if (!q->tx_timer) {
>> > +                q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>> > +                                           virtio_net_tx_timer,
>> > +                                           q);
>> > +            }
>> > +        }
>> > +    }
>> > +
>> > +    return VIRTIO_NET_OK;
>> > +}
>> > +
>> >  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
>> >                                   struct iovec *iov, unsigned int iov_=
cnt)
>> >  {
>> > @@ -1582,6 +1630,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *=
vdev,
>> >          status =3D virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
>> >      } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
>> >          status =3D virtio_net_handle_offloads(n, ctrl.cmd, iov, out_n=
um);
>> > +    } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_NOTF_COAL) {
>> > +        status =3D virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
>> >      }
>> >
>> >      s =3D iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
>> > @@ -2041,7 +2091,22 @@ static ssize_t virtio_net_receive_rcu(NetClient=
State *nc, const uint8_t *buf,
>> >      }
>> >
>> >      virtqueue_flush(q->rx_vq, i);
>> > -    virtio_notify(vdev, q->rx_vq);
>> > +
>> > +    /* rx coalescing */
>> > +    n->rx_pkt_cnt +=3D i;
>> > +    if (n->rx_coal_usecs =3D=3D 0 || n->rx_pkt_cnt >=3D n->rx_coal_pa=
ckets) {
>> > +        if (n->rx_index_timer) {
>> > +            timer_del(n->rx_index_timer);
>> > +        }
>>
>> How does the next tick occurs if we delete the timer here?
>
> timer_del only stops the "alarm" from ringing, and ``timer_mod'' restarts=
 the timer.

Ouch, my bad! I thought timer_del totally cleaned the timer.

>>
>>
>> > +        virtio_net_rx_notify(n);
>> > +    } else {
>> > +        if (n->rx_index_timer) {
>> > +            if (!timer_pending(n->rx_index_timer)) {
>> > +                timer_mod(n->rx_index_timer,
>> > +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->=
rx_coal_usecs);
>> > +            }
>> > +        }
>> > +    }
>> >
>> >      return size;
>> >
>> > @@ -2818,7 +2883,6 @@ detach:
>> >      return -EINVAL;
>> >  }
>> >
>> > -static void virtio_net_tx_timer(void *opaque);
>> >
>> >  static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue =
*vq)
>> >  {
>> > @@ -2900,6 +2964,12 @@ static void virtio_net_tx_timer(void *opaque)
>> >      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
>> >          return;
>> >      }
>> > +    if (n->tx_pkt_cnt < ret) {
>> > +        n->tx_pkt_cnt =3D 0;
>> > +    } else {
>> > +        n->tx_pkt_cnt -=3D ret;
>> > +    }
>> > +
>> >      /*
>> >       * If we flush a full burst of packets, assume there are
>> >       * more coming and immediately rearm
>> > @@ -2919,6 +2989,7 @@ static void virtio_net_tx_timer(void *opaque)
>> >      ret =3D virtio_net_flush_tx(q);
>> >      if (ret > 0) {
>> >          virtio_queue_set_notification(q->tx_vq, 0);
>> > +        n->tx_pkt_cnt -=3D ret;
>> >          q->tx_waiting =3D 1;
>> >          timer_mod(q->tx_timer,
>> >                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeo=
ut);
>> > @@ -2974,6 +3045,32 @@ static void virtio_net_tx_bh(void *opaque)
>> >      }
>> >  }
>> >
>> > +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQue=
ue *vq)
>> > +{
>> > +    VirtIONet *n =3D VIRTIO_NET(vdev);
>> > +    VirtIONetQueue *q =3D &n->vqs[vq2q(virtio_get_queue_index(vq))];
>> > +    bool use_timer =3D n->tx_timer_activate || n->tx_coal_usecs > 0 |=
|
>> > +                     n->tx_coal_packets > 0;
>> > +    bool pkt_limit =3D (n->tx_coal_packets > 0);
>> > +
>> > +    if (use_timer) {
>> > +        n->tx_pkt_cnt++;
>> > +        if (!pkt_limit || n->tx_pkt_cnt < n->tx_coal_packets) {
>> > +            if (q->tx_timer) {
>> > +                virtio_net_handle_tx_timer(vdev, vq);
>> > +                return;
>> > +            }
>> > +        }
>> > +        n->tx_pkt_cnt =3D 0;
>> > +        if (q->tx_timer) {
>> > +            timer_del(q->tx_timer);
>> > +        }
>> > +        virtio_net_handle_tx_bh(vdev, vq);
>> > +    } else {
>> > +        virtio_net_handle_tx_bh(vdev, vq);
>> > +    }
>> > +}
>> > +
>> >  static void virtio_net_add_queue(VirtIONet *n, int index)
>> >  {
>> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>> > @@ -2981,20 +3078,15 @@ static void virtio_net_add_queue(VirtIONet *n,=
 int index)
>> >      n->vqs[index].rx_vq =3D virtio_add_queue(vdev, n->net_conf.rx_que=
ue_size,
>> >                                             virtio_net_handle_rx);
>> >
>> > -    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
>> > -        n->vqs[index].tx_vq =3D
>> > -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
>> > -                             virtio_net_handle_tx_timer);
>> > -        n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>> > -                                              virtio_net_tx_timer,
>> > -                                              &n->vqs[index]);
>> > -    } else {
>> > -        n->vqs[index].tx_vq =3D
>> > -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
>> > -                             virtio_net_handle_tx_bh);
>> > -        n->vqs[index].tx_bh =3D qemu_bh_new_guarded(virtio_net_tx_bh,=
 &n->vqs[index],
>> > -                                                  &DEVICE(vdev)->mem_=
reentrancy_guard);
>> > -    }
>> > +    n->vqs[index].tx_vq =3D
>> > +        virtio_add_queue(vdev,
>> > +                         n->net_conf.tx_queue_size,
>> > +                         virtio_net_handle_tx_dispatch);
>> > +
>> > +    n->vqs[index].tx_bh =3D
>> > +        qemu_bh_new_guarded(virtio_net_tx_bh,
>> > +                            &n->vqs[index],
>> > +                            &DEVICE(vdev)->mem_reentrancy_guard);
>> >
>> >      n->vqs[index].tx_waiting =3D 0;
>> >      n->vqs[index].n =3D n;
>> > @@ -3972,6 +4064,10 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)
>> >          error_printf("Defaulting to \"bh\"");
>> >      }
>> >
>> > +    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")) {
>> > +        n->tx_timer_activate =3D true;
>> > +    }
>> > +
>>
>> I keep thinking it would be easier if we accepted either the timer
>> cmdline or vq_notif_coal, but never both simultaneously. This way we
>> can reuse the exact same logic for both of them.
>>
>> >      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n)=
,
>> >                                      n->net_conf.tx_queue_size);
>> >
>> > @@ -4048,6 +4144,13 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)
>> >              n->rss_data.specified_hash_types.on_bits |
>> >              n->rss_data.specified_hash_types.auto_bits;
>> >      }
>> > +    n->rx_pkt_cnt =3D 0;
>> > +    n->tx_pkt_cnt =3D 0;
>> > +    n->rx_coal_usecs =3D 0;
>> > +    n->tx_coal_usecs =3D 0;
>> > +    n->rx_coal_packets =3D 0;
>> > +    n->tx_coal_packets =3D 0;
>> > +    n->rx_index_timer =3D NULL;
>> >  }
>> >
>> >  static void virtio_net_device_unrealize(DeviceState *dev)
>> > @@ -4262,6 +4365,8 @@ static const Property virtio_net_properties[] =
=3D {
>> >                        VIRTIO_NET_F_GUEST_USO6, true),
>> >      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>> >                        VIRTIO_NET_F_HOST_USO, true),
>> > +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
>> > +                      VIRTIO_NET_F_NOTF_COAL, true),
>> >      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
>> >                                    rss_data.specified_hash_types,
>> >                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
>> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio=
-net.h
>> > index 5b8ab7bda7..024501ed37 100644
>> > --- a/include/hw/virtio/virtio-net.h
>> > +++ b/include/hw/virtio/virtio-net.h
>> > @@ -231,6 +231,14 @@ struct VirtIONet {
>> >      struct EBPFRSSContext ebpf_rss;
>> >      uint32_t nr_ebpf_rss_fds;
>> >      char **ebpf_rss_fds;
>> > +    QEMUTimer *rx_index_timer;
>> > +    uint32_t rx_coal_usecs;
>> > +    uint32_t rx_coal_packets;
>> > +    uint32_t rx_pkt_cnt;
>> > +    uint32_t tx_coal_usecs;
>> > +    uint32_t tx_coal_packets;
>> > +    uint32_t tx_pkt_cnt;
>> > +    bool tx_timer_activate;
>> >  };
>> >
>> >  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
>> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> > index 3df6091274..a20db78b81 100644
>> > --- a/net/vhost-vdpa.c
>> > +++ b/net/vhost-vdpa.c
>> > @@ -70,6 +70,7 @@ static const int vdpa_feature_bits[] =3D {
>> >      VIRTIO_NET_F_CTRL_RX,
>> >      VIRTIO_NET_F_CTRL_RX_EXTRA,
>> >      VIRTIO_NET_F_CTRL_VLAN,
>> > +    VIRTIO_NET_F_NOTF_COAL,
>> >      VIRTIO_NET_F_CTRL_VQ,
>> >      VIRTIO_NET_F_GSO,
>> >      VIRTIO_NET_F_GUEST_CSUM,
>> > @@ -115,6 +116,7 @@ static const uint64_t vdpa_svq_device_features =3D
>> >      BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
>> >      BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
>> >      BIT_ULL(VIRTIO_NET_F_STATUS) |
>> > +    BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |
>>
>> This needs to be deleted, SVQ still does not support VIRTIO_NET_F_NOTF_C=
OAL.
>>
>> >      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
>> >      BIT_ULL(VIRTIO_NET_F_GSO) |
>> >      BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
>> > --
>> > 2.53.0
>> >
>>
>> Also, VMSTATE_ must be added to vmstate_virtio_net_device to migrate
>> these fields. This can be tested by migrating a device with an
>> emulated device with no vdpa too.
>
>    >> Done in V5 patch set.
>>
>>
>> The process of migration is described here but feel free to ping me
>> for help: https://www.linux-kvm.org/page/Migration .
>>


