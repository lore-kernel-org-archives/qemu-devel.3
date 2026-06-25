Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5ECCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wchhP-0007TC-6g; Thu, 25 Jun 2026 06:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wchhN-0007Sl-Mp
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wchhL-0000P5-Dy
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782384760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1D3OFeoLOfMnD47LoNMa4wdJK5aXvREbwV8nNHByWQ=;
 b=G4SwxNx9l8nsSaF1MgueOX3VQ3H9WdnGKR05+fw6bOD9DkXm5lgAN/tCs8BOXGANgqrGEo
 F60AnX44BbprSlZb02ersJSEIyIIQHyKdwOwzrTgC8SwklSKtshCKqB9HINnznwcsIZlqr
 qQCNS8aWUVjIhaenG+6ydO5W/VNSGps=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-sJ6LQtffPJW5He9I8fJdPQ-1; Thu, 25 Jun 2026 06:52:39 -0400
X-MC-Unique: sJ6LQtffPJW5He9I8fJdPQ-1
X-Mimecast-MFC-AGG-ID: sJ6LQtffPJW5He9I8fJdPQ_1782384759
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7fefbbeed32so42397627b3.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 03:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782384759; cv=none;
 d=google.com; s=arc-20260327;
 b=YcQIfcB5r9fR6vyjR13hjOe3dsPABNfUL5BF2RsM+K+nv+GM58YFe2yCNgEP76mt3G
 f1iMbdCMT6AFsjoPcaJi1e8zNfTHSRKfohjbjXVaqQ9jkVltrZOZZtW1XBCwTjvCbiUk
 70OJGcuhDWfksoeSnASQv7oz11clv8HJPP55SFQPPAT1OrIL5NNqgbbWq+ZyamJLZxqv
 9i0UsYxjIwaJMbXIxPIY8VB1USN4F2mHXUfX7+CQLjbqMIbm0wdySpYjUwBaQ00wCH5R
 9GrFLaiDkAX3lyrQCFkKFM2s7MEd+/ww2hwIppfJ/triLJw+4PZS84NvErXsyKLaPETn
 DPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J1D3OFeoLOfMnD47LoNMa4wdJK5aXvREbwV8nNHByWQ=;
 fh=6/ouGYbjHnSFSJHFY+pVvzIaqAKSYTuICFj9DWSg2PA=;
 b=lw3KZznRptLrT9GOguDL/N9C3zj92eMANg0YtYPts5qz42OaoUBGzQ38y6bzNZvNe8
 xPOUE+wUOQNdeTDYn4EqbRfG91Qka7GTDf5EQACP8ZoBVhShhuZ4gbF9pYIb67wOfhVv
 WkmoHuaabWn1byZ4piqZC2SFNC4Ck3Oy02RsSJUrL2IWj6nydKt53bHYOsazVQ2UiLjb
 K+ncTvBhwvgT9gz2a3Iwvfw8ouxpJWULpEUZlADj4FUoLZB1vg/4VUsTIpALF9PazK79
 aMgCxTEa48joiz3Etc/cb0KvQ2dgctThYEXYazo+U5b/Lu1bcKtb1gCytelSmX27AzSm
 VoQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782384759; x=1782989559; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1D3OFeoLOfMnD47LoNMa4wdJK5aXvREbwV8nNHByWQ=;
 b=C3h0Ja/hXIFwKqPS77LFrQiSpRFbhb3sjfFcGlXWCI6T5AIdPdkcBOf+d5ZzlbUQyr
 Yh9OY1LKD3OgYpvxdbV7oBMOlxeCOtnmUFVTTM3xZUNGkrDiwpGgkMfpo/0vq9haekzW
 3x2/EuX1+yyJRmJrVfDmW5PcJz8VdHVXJ185eSXt59GP9ifTwqwImuLc6B/aOSk/7sjX
 WC6VUxN4uYUtzb/vFmwWRV/FL/JhU7LL7CCa0TY7ngJEwLN/tMH6rocYVuPYiXblZGq+
 5kkAYqdX2M1Pg/5t5so/CREZbEO9ucQNZ3PC6bk6lJp7VPpXP7VmuR/7NGK+wnwrCHnm
 7j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782384759; x=1782989559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J1D3OFeoLOfMnD47LoNMa4wdJK5aXvREbwV8nNHByWQ=;
 b=iAG/G+koWnXNqPtLxkfmc0EeEixjlmFb0SEll7JRTMOq9fMHjIe5+FqdTI4WyQZruE
 VgX62a3vwnjpePE9kAGPx2tU4bQ1j1/LsV08QGLo+plZ2jI8LS09r0GEidXo6cuEuxlL
 cd3ap6YZWy8hFQPOzf/nQpWJTgcXNhsUsB+aTe4g7cDKRI91ZZC0jLWWKtflx7kF24aP
 GrOTfYky69cf/ap0HezeuVDFWW+K97AlfLkXmF0YSyhLyxKk/QKGF38BV0EfI7Vq/IrX
 tCCYvDjLn1RXxNNm44k8wG6l209/+skWbT48LFlMTIrG7H1mHWfNHpSOMzwb/OdXPfDb
 jjCg==
X-Gm-Message-State: AOJu0Yze0rB3KtDBuLzDpyd890u/djPM49RBhUKJ85UW0wlALBJHAk3x
 Q4OWJ7usButZ7LkZYhzYmPhEq1//DI8nbhIfCEY8/HVyrCQuKHHAFCb0sgcX6HwiDbpnsx55iv2
 dXzILqzdNLvgDd5cwY7Sov1d6n5ne+kKD/iMAvKBUGI4V4JVLbm9bfjv6r8xeL0Rr+NXazBncGT
 MglHmdD85O41QRd9ZU1QCqjUuMOzlJm+U=
X-Gm-Gg: AfdE7cmCDliU6TvGLpelHuuxpd/f9eXQV+JvHpLuIiFunsOBrycNcchsJikoeIzZMHo
 NHsNOeVU/tQ9NyEKYXlQoYsk3U46xzheg0zjpQHwrgvrBSAL5H06bz0ysAj+wq1dXaN38Pc5qxz
 sQng6wBT24BCVEgoVaGQD/SEf5g8NlTCXN2+G6XUnP0mSlv8YjQSrtHgBxVr33zlr1nFM=
X-Received: by 2002:a05:690e:d44:b0:663:15ba:cdb5 with SMTP id
 956f58d0204a3-66487edfd8cmr1281923d50.64.1782384758456; 
 Thu, 25 Jun 2026 03:52:38 -0700 (PDT)
X-Received: by 2002:a05:690e:d44:b0:663:15ba:cdb5 with SMTP id
 956f58d0204a3-66487edfd8cmr1281887d50.64.1782384757949; Thu, 25 Jun 2026
 03:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260613223513.865744-1-kdutta@redhat.com>
 <20260613223513.865744-3-kdutta@redhat.com>
In-Reply-To: <20260613223513.865744-3-kdutta@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Jun 2026 12:52:00 +0200
X-Gm-Features: AVVi8CeE6vAoIceFPl5_UFxrfKNWZXifMtpy6cH53GanFsSweFsRn-yiURqnwOY
Message-ID: <CAJaqyWe83xdea8nKL+3ScbFgQ9WFpETJ+gR1UBx4mbnyi=n=nw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] [PATCH 2/2] Implement VirtIO Network Notification
 Coalescing (VIRTIO_NET_F_NOTF_COAL). This allows guests to reduce
 interrupt
 overhead by configuring coalescing parameters via ethtool -C for both RX and
 TX paths.
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jun 14, 2026 at 12:35=E2=80=AFAM Koushik Dutta <kdutta@redhat.com> =
wrote:
>
> The feature supports two coalescing modes:
> - Time-based: delay notifications up to N microseconds
> - Count-based: delay until N packets are processed
>
> Implementation details:
> - Added VIRTIO_NET_CTRL_NOTF_COAL class handling in control virtqueue
> - RX path: batches notifications based on packet count or timeout
> - TX path: leverages the unified dispatcher to dynamically enable
>   timer-based coalescing when guest configures it via ethtool
> - Coalescing parameters persist across live migration
>
> Note: During VM launch if we provide tx=3Dtimer, then coalescing feature
> will not be active. As, user already introduce delay 150ms.

^ Incomplete sentence?

>
> Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> ---
>  hw/net/virtio-net.c            | 144 ++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-net.h |   7 ++
>  net/passt.c                    |   1 +
>  net/tap.c                      |   1 +
>  net/vhost-user.c               |   1 +
>  net/vhost-vdpa.c               |   1 +
>  6 files changed, 154 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 319842cf28..3dbd2f4c11 100644
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
> @@ -1004,6 +1014,62 @@ static void virtio_net_set_features(VirtIODevice *=
vdev,
>
>  static void virtio_net_tx_timer(void *opaque);
>
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
> +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> +            q =3D &n->vqs[i];
> +            if (n->rx_coal_usecs > 0) {
> +                if (!q->rx_timer) {
> +                    q->rx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                               virtio_net_rx_notify,
> +                                               q);
> +                }
> +            } else {
> +                if (q->rx_timer) {
> +                    timer_free(q->rx_timer);
> +                    q->rx_timer =3D NULL;

Nit: you can use g_clear_pointer here.

Also, virtio_net_del_queue should also remove the timers.

> +                }
> +            }
> +        }
> +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> +        /* Converted us to ns */
> +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
> +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> +            q =3D &n->vqs[i];
> +            if (n->tx_coal_usecs > 0) {
> +                if (!q->tx_timer) {
> +                    q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                               virtio_net_tx_timer,
> +                                               q);
> +                }
> +            } else {
> +                if (q->tx_timer) {
> +                    timer_free(q->tx_timer);
> +                    q->tx_timer =3D NULL;
> +                }
> +           }
> +        }
> +    }
> +
> +    return VIRTIO_NET_OK;
> +}
> +
>  static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
>                                       struct iovec *iov, unsigned int iov=
_cnt)
>  {
> @@ -1583,6 +1649,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vde=
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
> @@ -2042,7 +2110,23 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
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
> +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                          n->rx_coal_usecs * 1000);
> +            }
> +        }
> +    }
>
>      return size;
>
> @@ -2900,6 +2984,12 @@ static void virtio_net_tx_timer(void *opaque)
>      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
>          return;
>      }
> +    if (n->tx_pkt_cnt < ret) {
> +        n->tx_pkt_cnt =3D 0;
> +    } else {
> +        n->tx_pkt_cnt -=3D ret;
> +    }
> +

I didn't detect this in previous series, but the coalescing parameters
are per vq, not per device. So the counters and timers should move to
the vq:

"If coalescing parameters are being set, the device applies the last
coalescing parameters set for a virtqueue, regardless of the command
used to set the parameters"


>      /*
>       * If we flush a full burst of packets, assume there are
>       * more coming and immediately rearm
> @@ -2919,6 +3009,7 @@ static void virtio_net_tx_timer(void *opaque)
>      ret =3D virtio_net_flush_tx(q);
>      if (ret > 0) {
>          virtio_queue_set_notification(q->tx_vq, 0);
> +        n->tx_pkt_cnt -=3D ret;
>          q->tx_waiting =3D 1;
>          timer_mod(q->tx_timer,
>                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> @@ -2985,6 +3076,20 @@ static void virtio_net_handle_tx_dispatch(VirtIODe=
vice *vdev, VirtQueue *vq)
>                                         virtio_net_tx_timer, q);
>          }
>          virtio_net_handle_tx_timer(vdev, vq);
> +    } else if (n->tx_coal_usecs > 0) {
> +        n->tx_pkt_cnt++;
> +        if (n->tx_pkt_cnt < n->tx_coal_packets) {
> +            if (q->tx_timer) {
> +                virtio_net_handle_tx_timer(vdev, vq);
> +                return;
> +            }
> +        } else {
> +            n->tx_pkt_cnt =3D 0;
> +            if (q->tx_timer) {
> +                timer_del(q->tx_timer);
> +            }
> +            virtio_net_handle_tx_bh(vdev, vq);
> +        }
>      } else {
>          virtio_net_handle_tx_bh(vdev, vq);
>      }
> @@ -3098,6 +3203,9 @@ static void virtio_net_get_features(VirtIODevice *v=
dev, uint64_t *features,
>      virtio_features_or(features, features, n->host_features_ex);
>
>      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> +    if (n->tx_timer_activate) {
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
> +    }
>
>      if (!peer_has_vnet_hdr(n)) {
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> @@ -3252,6 +3360,29 @@ static int virtio_net_post_load_device(void *opaqu=
e, int version_id)
>      }
>
>      virtio_net_commit_rss_config(n);
> +    if (n->tx_coal_usecs > 0 || n->rx_coal_usecs > 0) {
> +
> +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> +            VirtIONetQueue *q =3D &n->vqs[i];
> +            if (n->rx_coal_usecs > 0) {
> +                if (!q->rx_timer) {
> +                    q->rx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                               virtio_net_rx_notify,
> +                                               q);
> +                }
> +            }
> +
> +            if (n->tx_coal_usecs > 0) {
> +                n->tx_timeout =3D n->tx_coal_usecs * 1000;
> +                if (!q->tx_timer) {
> +                    q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                               virtio_net_tx_timer,
> +                                               q);
> +                }
> +            }
> +        }
> +    }
> +
>      return 0;
>  }
>
> @@ -3627,6 +3758,10 @@ static const VMStateDescription vmstate_virtio_net=
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
> @@ -4060,6 +4195,11 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>              n->rss_data.specified_hash_types.on_bits |
>              n->rss_data.specified_hash_types.auto_bits;
>      }
> +    n->rx_pkt_cnt =3D 0;
> +    n->tx_pkt_cnt =3D 0;
> +    n->rx_coal_usecs =3D 0;
> +    n->rx_coal_packets =3D 0;
> +    n->tx_coal_packets =3D 0;
>  }
>
>  static void virtio_net_device_unrealize(DeviceState *dev)
> @@ -4272,6 +4412,8 @@ static const Property virtio_net_properties[] =3D {
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
> index a4eb3f407e..9612416622 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -159,6 +159,7 @@ typedef struct VirtIONetQueue {
>      VirtQueue *rx_vq;
>      VirtQueue *tx_vq;
>      QEMUTimer *tx_timer;
> +    QEMUTimer *rx_timer;
>      QEMUBH *tx_bh;
>      uint32_t tx_waiting;
>      struct {
> @@ -230,6 +231,12 @@ struct VirtIONet {
>      struct EBPFRSSContext ebpf_rss;
>      uint32_t nr_ebpf_rss_fds;
>      char **ebpf_rss_fds;
> +    uint32_t rx_coal_usecs; /* RX interrupt coalescing timeout (microsec=
onds) */
> +    uint32_t rx_coal_packets; /* RX packet count threshold for coalescin=
g */
> +    uint32_t rx_pkt_cnt; /* Current RX packet count since last notificat=
ion */
> +    uint32_t tx_coal_usecs; /* TX interrupt coalescing timeout (microsec=
onds) */
> +    uint32_t tx_coal_packets; /* TX packet count threshold for coalescin=
g */
> +    uint32_t tx_pkt_cnt; /* Current TX packet count since last notificat=
ion */
>      bool tx_timer_activate;
>  };
>
> diff --git a/net/passt.c b/net/passt.c
> index 45440c399b..43b36ed8c5 100644
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
> index 57ffb09885..e6ddbc1eb1 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -63,6 +63,7 @@ static const int kernel_feature_bits[] =3D {
>      VIRTIO_F_NOTIFICATION_DATA,
>      VIRTIO_NET_F_RSC_EXT,
>      VIRTIO_NET_F_HASH_REPORT,
> +    VIRTIO_NET_F_NOTF_COAL,
>      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
>      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
>      VHOST_INVALID_FEATURE_BIT
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 2d0fc49b4d..f1e9b7a038 100644
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
> index f1523697e2..0dcd6fb9f1 100644
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


