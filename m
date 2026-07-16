Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128C4C44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOs2-0002Kw-G1; Thu, 16 Jul 2026 12:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wkOrt-0002KZ-8l
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 12:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wkOro-0000SH-Vt
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 12:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784218999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WnqRUYYeYtPp+uB0kFpl+UgRWjvQolJjJHiluB/EToM=;
 b=P9iI2t11wbUKS0sBiOEXTmU/XSh7itGZyCHiqibISXvujKDzUwFpvrsxupoid3cJycjQCb
 DlUGToznQNsPIYOVniRmeWscM5SNuTrTgNBs5ztoZIzBFMMdjCzYlUbNp6GWEKOn5Csqid
 fwfKF8PXx8ZqTJyzyqFfgM8b0PIvm6w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-ES4IqclZNXasHgov9e4lWQ-1; Thu, 16 Jul 2026 12:23:17 -0400
X-MC-Unique: ES4IqclZNXasHgov9e4lWQ-1
X-Mimecast-MFC-AGG-ID: ES4IqclZNXasHgov9e4lWQ_1784218997
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c20762d21so47549271cf.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 09:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784218997; cv=none;
 d=google.com; s=arc-20260327;
 b=niYiyyAgulH5Nk1YSLp/yjEfz5npgw+XxWXwHoqT8jK9+oYR7gO+3UOU+bFeVSQ5OL
 vi4eU5ILD9rVXI4QV7PpbC6sKzJwS9bFNelDXlQtE0Fn9rQpzesrRxw8CtaJtSFmHPz5
 MJX4LeTOe0YVO5qaKenqgriw1P9h5a7XeNuUunTjFtOg3TbWa0md4F3oSkDWPZiXDX6b
 udFwmK8EPFgdMHgCZBqD8Ws5uvZgdjfko/Xr809yEHp+jLDOMp2M2MgdciNUXzxYpeOG
 zOjlTBnOZ3TZCENsaqz7GDijXedK/pIsVrJwD3LnwjjEZ20pyMuS2JrLNJOtOofCaVoP
 Pxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WnqRUYYeYtPp+uB0kFpl+UgRWjvQolJjJHiluB/EToM=;
 fh=Xc5bWEvrjN/gnnFWa09QTX1IF9NeFfpZm10mxQeEhCg=;
 b=GZp9zijrIEfdNiBBkdk8zVjSHmKGOLLG130kvOXH99wh1m5gRYwP4Ad9OUUyw7aQcg
 mTCZMFy3ZU8WQ/2CgRDfsh8p+4MCYcbQAMrWq3qgUBTpTnjxMEf/uIJt5+FXox3VwZy1
 8GNqYbcg5XWF0QI7msGBH4+pUCfLxh0skIjEwJNC++HvOTuwFTcFG/ZkXEHMoF44yFF8
 XzhXihrk3QGBrMZCpbhOiNELwqslVR6Le0PbRQnWTQjHGWMoGXo+SzrmvskKuK0LJjks
 ag3AFruLvc1COzYZxHZcu4C6xHHfw2G1TG+0xYHX8Vy6DyPYZD/3PStRlPv6oMb4Z7gI
 9/zw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784218997; x=1784823797; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WnqRUYYeYtPp+uB0kFpl+UgRWjvQolJjJHiluB/EToM=;
 b=QiYFrYpjkJiXrMCqFLu9eS0KP1IfjFapQg+Ewso+hgbbaN2zV8uJNOB0Cc+x+jadjL
 RK/j8J/beXvZuedzUYLUWEuP9WGrlBDuNBI9UNQylRsiMyV6efmB/0GBUKfMyG7mBFJI
 GEh1JOp7e0UyjSW+r3qJtMoCwR4rJWIwi/a5Z5rN4POpBt+CprTeRLIHsSPLySzZvjHb
 yfA/HliFsHYAGzQMcU+ythQetas9Ny+IBoomjHQP33BGRtqzapOA/M2wafoq/HCjbykQ
 DPBMExNox9MdvRHy/ST2zPAOxuUkgXLd1TJhq7wZr8Qoo0/ncBaKuTjpgGKGR98Ocvx4
 7DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784218997; x=1784823797;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WnqRUYYeYtPp+uB0kFpl+UgRWjvQolJjJHiluB/EToM=;
 b=dtxaYJv+Iu0hrq/2gaTfGKlj5eXd+fNlHxGJjTzWoPOVOBDR2EjIpZgsF5mrusj8od
 kD2w9iBjkDxlDpucLLu8w3/NYnZm8r26E4zmxODkga/5Yn/GcVEcNiC4IgllWVXiz0FL
 ZVlHTmVwok6EezL7NmI4IaMITjkPUgtVo6REe0T6ZBghi6yfS8H85krwSr+JlfqCTww8
 fM6AS/Fiuwgpkc1W8dxklH6O3CdpbMr/4E/qcRyJbd+gV9y4fZeOXcrJxg63XhTiPHNK
 RgTL+vvc6IBawxEs3Xv/4RmBG2K7zjBXFiP3tEKvo88iQ7wY/UxyVMjB7cQAqMA93x6n
 MgIg==
X-Gm-Message-State: AOJu0Yw7NSgx4NBMuDcGEYXGw1Kd9qcrG5AcAuRbBGLhq7Dzal93BpkA
 FK7O92mirpO4setsIc23BNMIk0V+wXGRxs5MuXpAuTNdjV3SQpwG8RYezS6I/tG/FNUaoII6f1i
 gIQBOsfkWVuAkthgOfBTxlxPdPCWS4M4B6h3AtyU0OtTA0GtyZOwufq92o4AknYoeJDcNxxfb6D
 RgjHOs9mcDEgCeeh0GVm68z37/sCSuXAc=
X-Gm-Gg: AfdE7cnF7nJdOVflBzz+d/Mym5EZZ6ld4lChSEtreIPjZyzfCgANA6vZn+foeaDbmmC
 UHBQImbXZdALCXNbQtTs+s23fxQT5M6uNCHKOedvi98+p9N7V4l/ZXzyujhWnxx13n8SD3fQ46u
 uCAwkCFu32ExXpA0on/P9nA/yQ/CGBnaaBlptZBqhOb5ZoShIDn7fd27dXQWtcsLDHvBjPbQXZD
 FJM0LUyvdfReJV0csx7jFhruZVCR0R7N4n/bnnEOa7PDDWa2qhh7KK9s5fTr1GBn5JcvJPFwSEZ
 7Gb02dqChsK7+yTC
X-Received: by 2002:a05:622a:353:b0:51a:86f1:5352 with SMTP id
 d75a77b69052e-520bb761b3fmr2800051cf.6.1784218996582; 
 Thu, 16 Jul 2026 09:23:16 -0700 (PDT)
X-Received: by 2002:a05:622a:353:b0:51a:86f1:5352 with SMTP id
 d75a77b69052e-520bb761b3fmr2798991cf.6.1784218995373; Thu, 16 Jul 2026
 09:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260702131632.1180309-1-kdutta@redhat.com>
 <20260702131632.1180309-3-kdutta@redhat.com>
 <20260704060831-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260704060831-mutt-send-email-mst@kernel.org>
From: Koushik Dutta <kdutta@redhat.com>
Date: Thu, 16 Jul 2026 21:53:03 +0530
X-Gm-Features: AUfX_mxX1D9_3YKVIc_dwgamUBXJlUGnekLv0Ft4_laDxm2YNu3PhxB8-0IuaHA
Message-ID: <CALseRdd0pufkxQnPAx0D+vsfTNfXtYkEOtq0Fs55JpziMcxfdA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] [PATCH 2/2] Implement VirtIO Network Notification
 Coalescing (VIRTIO_NET_F_NOTF_COAL). This allows guests to reduce
 interrupt
 overhead by configuring coalescing parameters via ethtool -C for both RX and
 TX paths.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006bd85e0656bcdb3a"
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=kdutta@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000006bd85e0656bcdb3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 3:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:

> Thanks for the patch! Yet something to improve:
>
> On Thu, Jul 02, 2026 at 06:46:32PM +0530, Koushik Dutta wrote:
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
> > Note: When tx=3Dtimer is configured at VM launch, the coalescing featur=
e
> > is automatically disabled because tx=3Dtimer already introduces a fixed
> > 150=E7=9B=9C delay for packet batching, making notification coalescing =
redundant.
> >
> > Signed-off-by: Koushik Dutta <kdutta@redhat.com>
>
> What is the benefit of the feature for the users?
> E.g. do you see a perf gain sometimes?
>
We observed the same throughput with less CPU usage after enabling
coalescing.
Moderate Coalescing(RX: 1000=C2=B5s, 10 frames, TX: 2000=C2=B5s, 20 frames)=
 vs
Without Coalescing
CPU Usage Reduction:  20.0%
Interrupt Reduction:  30.0%

>
> > ---
> >  hw/core/machine.c              |   1 +
> >  hw/net/virtio-net.c            | 176 +++++++++++++++++++++++++++++++--
> >  include/hw/virtio/virtio-net.h |   7 ++
> >  net/passt.c                    |   1 +
> >  net/tap.c                      |   1 +
> >  net/vhost-user.c               |   1 +
> >  net/vhost-vdpa.c               |   1 +
> >  7 files changed, 182 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 4d8b15d99e..55ee886f41 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] =3D {
> >      { "chardev-vc", "encoding", "cp437" },
> >      { "tpm-crb", "cap-chunk", "off" },
> >      { "tpm-crb", "x-allow-chunk-migration", "off" },
> > +    { TYPE_VIRTIO_NET, "vq_notf_coal", "off" },
> >  };
> >  const size_t hw_compat_11_0_len =3D G_N_ELEMENTS(hw_compat_11_0);
>
> it is off by default, right? why do we need compat?
>
Resolved in v10

>
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 319842cf28..4de6aa3b23 100644
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
> > +    q->rx_pkt_cnt =3D 0;
> > +    virtio_notify(vdev, q->rx_vq);
> > +}
> > +
> >  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> >  {
> >      VirtIONet *n =3D VIRTIO_NET(vdev);
> > @@ -1004,6 +1014,56 @@ static void virtio_net_set_features(VirtIODevice
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
> > +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +            q =3D &n->vqs[i];
> > +            q->rx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> > +            q->rx_coal_packets =3D le32_to_cpu(coal.max_packets);
> > +            if (q->rx_coal_usecs > 0) {
> > +                if (!q->rx_timer) {
> > +                    q->rx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                               virtio_net_rx_notify,
> > +                                               q);
> > +                }
> > +            } else {
> > +                g_clear_pointer(&q->rx_timer, timer_free);
> > +            }
> > +        }
> > +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> > +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +            q =3D &n->vqs[i];
> > +            q->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> > +            q->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> > +            /* Converted us to ns */
> > +            n->tx_timeout =3D q->tx_coal_usecs * 1000;
> > +            if (q->tx_coal_usecs > 0) {
> > +                if (!q->tx_timer) {
> > +                    q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                               virtio_net_tx_timer,
> > +                                               q);
> > +                }
> > +            } else {
> > +                g_clear_pointer(&q->tx_timer, timer_free);
> > +            }
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
> > @@ -1583,6 +1643,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice
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
> > @@ -2042,7 +2104,23 @@ static ssize_t
> virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
> >      }
> >
> >      virtqueue_flush(q->rx_vq, i);
> > -    virtio_notify(vdev, q->rx_vq);
> > +
> > +    /* rx coalescing */
> > +    q->rx_pkt_cnt +=3D i;
> > +    if (q->rx_coal_usecs =3D=3D 0 || q->rx_pkt_cnt >=3D q->rx_coal_pac=
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
> > +                          q->rx_coal_usecs * 1000);
> > +            }
> > +        }
> > +    }
> >
> >      return size;
> >
> > @@ -2900,6 +2978,12 @@ static void virtio_net_tx_timer(void *opaque)
> >      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
> >          return;
> >      }
> > +    if (q->tx_pkt_cnt < ret) {
> > +        q->tx_pkt_cnt =3D 0;
> > +    } else {
> > +        q->tx_pkt_cnt -=3D ret;
> > +    }
> > +
>
> q->tx_pkt_cnt -=3D MIN(q->tx_pkt_cnt, ret);
>
> ?
>
> >      /*
> >       * If we flush a full burst of packets, assume there are
> >       * more coming and immediately rearm
> > @@ -2919,6 +3003,7 @@ static void virtio_net_tx_timer(void *opaque)
> >      ret =3D virtio_net_flush_tx(q);
> >      if (ret > 0) {
> >          virtio_queue_set_notification(q->tx_vq, 0);
> > +        q->tx_pkt_cnt -=3D ret;
> >          q->tx_waiting =3D 1;
> >          timer_mod(q->tx_timer,
> >                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> n->tx_timeout);
> > @@ -2985,6 +3070,15 @@ static void
> virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue *vq)
> >                                         virtio_net_tx_timer, q);
> >          }
> >          virtio_net_handle_tx_timer(vdev, vq);
> > +    } else if (q->tx_coal_usecs > 0 && q->tx_timer) {
> > +        q->tx_pkt_cnt++;
> > +        if (q->tx_pkt_cnt < q->tx_coal_packets) {
> > +            virtio_net_handle_tx_timer(vdev, vq);
> > +        } else {
> > +            q->tx_pkt_cnt =3D 0;
> > +            timer_del(q->tx_timer);
> > +            virtio_net_handle_tx_bh(vdev, vq);
> > +        }
> >      } else {
> >          virtio_net_handle_tx_bh(vdev, vq);
> >      }
> > @@ -3006,6 +3100,12 @@ static void virtio_net_add_queue(VirtIONet *n,
> int index)
> >                              &DEVICE(vdev)->mem_reentrancy_guard);
> >
> >      n->vqs[index].tx_waiting =3D 0;
> > +    n->vqs[index].rx_pkt_cnt =3D 0;
> > +    n->vqs[index].tx_pkt_cnt =3D 0;
> > +    n->vqs[index].rx_coal_usecs =3D 0;
> > +    n->vqs[index].tx_coal_usecs =3D 0;
> > +    n->vqs[index].rx_coal_packets =3D 0;
> > +    n->vqs[index].tx_coal_packets =3D 0;
> >      n->vqs[index].n =3D n;
> >  }
> >
> > @@ -3018,10 +3118,12 @@ static void virtio_net_del_queue(VirtIONet *n,
> int index)
> >      qemu_purge_queued_packets(nc);
> >
> >      virtio_del_queue(vdev, index * 2);
> > -    if (q->tx_timer) {
> > -        timer_free(q->tx_timer);
> > -        q->tx_timer =3D NULL;
> > -    } else {
> > +
> > +    /* Cleanup coalescing timers */
> > +    g_clear_pointer(&q->rx_timer, timer_free);
> > +    g_clear_pointer(&q->tx_timer, timer_free);
> > +
> > +    if (q->tx_bh) {
> >          qemu_bh_delete(q->tx_bh);
> >          q->tx_bh =3D NULL;
> >      }
> > @@ -3098,6 +3200,13 @@ static void virtio_net_get_features(VirtIODevice
> *vdev, uint64_t *features,
> >      virtio_features_or(features, features, n->host_features_ex);
> >
> >      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> > +    if (n->tx_timer_activate) {
> > +        virtio_clear_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
> > +    } else {
> > +        if (!virtio_has_feature(*features, VIRTIO_NET_F_NOTF_COAL)) {
> > +            *features &=3D ~(1ULL << VIRTIO_NET_F_NOTF_COAL);
> > +        }
> > +    }
> >
> >      if (!peer_has_vnet_hdr(n)) {
> >          virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> > @@ -3252,6 +3361,27 @@ static int virtio_net_post_load_device(void
> *opaque, int version_id)
> >      }
> >
> >      virtio_net_commit_rss_config(n);
> > +
> > +    for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +        VirtIONetQueue *q =3D &n->vqs[i];
> > +        if (q->rx_coal_usecs > 0) {
> > +            if (!q->rx_timer) {
> > +                q->rx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                           virtio_net_rx_notify,
> > +                                           q);
> > +            }
> > +        }
> > +
> > +        if (q->tx_coal_usecs > 0) {
> > +            n->tx_timeout =3D q->tx_coal_usecs * 1000;
> > +            if (!q->tx_timer) {
> > +                q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                           virtio_net_tx_timer,
> > +                                           q);
> > +            }
> > +        }
> > +    }
> > +
> >      return 0;
> >  }
> >
> > @@ -3271,13 +3401,41 @@ static int
> virtio_net_post_load_virtio(VirtIODevice *vdev)
> >      return 0;
> >  }
> >
> > +static bool virtio_net_queue_notf_coal_needed(void *opaque)
> > +{
> > +    VirtIONetQueue *q =3D opaque;
> > +    VirtIONet *n =3D q->n;
> > +
> > +    return virtio_vdev_has_feature(VIRTIO_DEVICE(n),
> VIRTIO_NET_F_NOTF_COAL);
> > +}
> > +
> > +static const VMStateDescription vmstate_virtio_net_queue_notf_coal =3D=
 {
> > +    .name =3D "virtio-net-queue-tx_waiting/notf-coal",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D virtio_net_queue_notf_coal_needed,
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_UINT32(rx_coal_usecs, VirtIONetQueue),
> > +        VMSTATE_UINT32(tx_coal_usecs, VirtIONetQueue),
> > +        VMSTATE_UINT32(rx_coal_packets, VirtIONetQueue),
> > +        VMSTATE_UINT32(tx_coal_packets, VirtIONetQueue),
> > +        VMSTATE_UINT32(rx_pkt_cnt, VirtIONetQueue),
> > +        VMSTATE_UINT32(tx_pkt_cnt, VirtIONetQueue),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> >  /* tx_waiting field of a VirtIONetQueue */
> >  static const VMStateDescription vmstate_virtio_net_queue_tx_waiting =
=3D {
> >      .name =3D "virtio-net-queue-tx_waiting",
> >      .fields =3D (const VMStateField[]) {
> >          VMSTATE_UINT32(tx_waiting, VirtIONetQueue),
> >          VMSTATE_END_OF_LIST()
> > -   },
> > +    },
> > +    .subsections =3D (const VMStateDescription * const []) {
> > +        &vmstate_virtio_net_queue_notf_coal,
> > +        NULL
> > +    }
> >  };
> >
> >  static bool max_queue_pairs_gt_1(void *opaque, int version_id)
> > @@ -3982,6 +4140,10 @@ static void virtio_net_device_realize(DeviceStat=
e
> *dev, Error **errp)
> >
> >      if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") =3D=3D 0) {
> >          n->tx_timer_activate =3D true;
> > +        if (n->host_features & (1ULL << VIRTIO_NET_F_NOTF_COAL)) {
> > +            warn_report("virtio-net: 'vq_notf_coal' is incompatible
> with 'tx=3Dtimer',"
> > +                        "disabling notification coalescing");
> > +        }
> >      }
> >
> >      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
> > @@ -4272,6 +4434,8 @@ static const Property virtio_net_properties[] =3D=
 {
> >                        VIRTIO_NET_F_GUEST_USO6, true),
> >      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> >                        VIRTIO_NET_F_HOST_USO, true),
> > +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
> > +                      VIRTIO_NET_F_NOTF_COAL, false),
>
> So when do you expect users to enable this?
>
Adds the `x-vq_notf_coal=3Don` device parameter to dynamically enable
virtqueue notification coalescing at VM startup.

> If this is experimental, let's make it unstable (start with "x-").
>
Resolved in V10

>
>
> >      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
> >                                    rss_data.specified_hash_types,
> >                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> > diff --git a/include/hw/virtio/virtio-net.h
> b/include/hw/virtio/virtio-net.h
> > index a4eb3f407e..550aaea2be 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -159,12 +159,19 @@ typedef struct VirtIONetQueue {
> >      VirtQueue *rx_vq;
> >      VirtQueue *tx_vq;
> >      QEMUTimer *tx_timer;
> > +    QEMUTimer *rx_timer;
> >      QEMUBH *tx_bh;
> >      uint32_t tx_waiting;
> >      struct {
> >          VirtQueueElement *elem;
> >      } async_tx;
> >      struct VirtIONet *n;
> > +    uint32_t rx_coal_usecs;   /* RX interrupt coalescing timeout
> (microseconds) */
> > +    uint32_t rx_coal_packets; /* RX packet count threshold for
> coalescing */
> > +    uint32_t rx_pkt_cnt;      /* Current RX packet count since last
> notification */
> > +    uint32_t tx_coal_usecs;   /* TX interrupt coalescing timeout
> (microseconds) */
> > +    uint32_t tx_coal_packets; /* TX packet count threshold for
> coalescing */
> > +    uint32_t tx_pkt_cnt;      /* Current TX packet count since last
> notification */
>
> Please organize this in some kind of structure.
> This way no need to repeat "coalescing" each time.
>
> Resolved in V10

>
> >  } VirtIONetQueue;
> >
> >  struct VirtIONet {
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
>
>
> So the point of the whitelists is not to make people blindly
> copy-paste them everywhere, but instead to make a plan how this will work=
.
>
> For example, we need to send the control to backend I presume?
>
>
> Similar for other backends.
>
>
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
>
>
Regards,
Koushik

--0000000000006bd85e0656bcdb3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jul 4, =
2026 at 3:51=E2=80=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat=
.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Thanks for the patch! Yet something to improve:<br>
<br>
On Thu, Jul 02, 2026 at 06:46:32PM +0530, Koushik Dutta wrote:<br>
&gt; The feature supports two coalescing modes:<br>
&gt; - Time-based: delay notifications up to N microseconds<br>
&gt; - Count-based: delay until N packets are processed<br>
&gt; <br>
&gt; Implementation details:<br>
&gt; - Added VIRTIO_NET_CTRL_NOTF_COAL class handling in control virtqueue<=
br>
&gt; - RX path: batches notifications based on packet count or timeout<br>
&gt; - TX path: leverages the unified dispatcher to dynamically enable<br>
&gt;=C2=A0 =C2=A0timer-based coalescing when guest configures it via ethtoo=
l<br>
&gt; - Coalescing parameters persist across live migration<br>
&gt; <br>
&gt; Note: When tx=3Dtimer is configured at VM launch, the coalescing featu=
re<br>
&gt; is automatically disabled because tx=3Dtimer already introduces a fixe=
d<br>
&gt; 150=E7=9B=9C delay for packet batching, making notification coalescing=
 redundant.<br>
&gt; <br>
&gt; Signed-off-by: Koushik Dutta &lt;<a href=3D"mailto:kdutta@redhat.com" =
target=3D"_blank">kdutta@redhat.com</a>&gt;<br>
<br>
What is the benefit of the feature for the users?<br>
E.g. do you see a perf gain sometimes?<br></blockquote><div>We observed the=
 same throughput with less CPU usage after enabling coalescing.<br>Moderate=
 Coalescing(RX: 1000=C2=B5s, 10 frames, TX: 2000=C2=B5s, 20 frames) vs With=
out Coalescing<br>CPU Usage Reduction: =C2=A020.0%<br>Interrupt Reduction: =
=C2=A030.0%</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 hw/core/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1=
76 +++++++++++++++++++++++++++++++--<br>
&gt;=C2=A0 include/hw/virtio/virtio-net.h |=C2=A0 =C2=A07 ++<br>
&gt;=C2=A0 net/passt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 7 files changed, 182 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/core/machine.c b/hw/core/machine.c<br>
&gt; index 4d8b15d99e..55ee886f41 100644<br>
&gt; --- a/hw/core/machine.c<br>
&gt; +++ b/hw/core/machine.c<br>
&gt; @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;chardev-vc&quot;, &quot;encoding&quot;, &q=
uot;cp437&quot; },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;tpm-crb&quot;, &quot;cap-chunk&quot;, &quo=
t;off&quot; },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;tpm-crb&quot;, &quot;x-allow-chunk-migrati=
on&quot;, &quot;off&quot; },<br>
&gt; +=C2=A0 =C2=A0 { TYPE_VIRTIO_NET, &quot;vq_notf_coal&quot;, &quot;off&=
quot; },<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 const size_t hw_compat_11_0_len =3D G_N_ELEMENTS(hw_compat_11_0)=
;<br>
<br>
it is off by default, right? why do we need compat?<br></blockquote>Resolve=
d in v10<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index 319842cf28..4de6aa3b23 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -157,6 +157,16 @@ static void flush_or_purge_queued_packets(NetClie=
ntState *nc)<br>
&gt;=C2=A0 =C2=A0* - we could suppress RX interrupt if we were so inclined.=
<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt; +static void virtio_net_rx_notify(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIONetQueue *q =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 VirtIONet *n =3D q-&gt;n;<br>
&gt; +=C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 q-&gt;rx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;rx_vq);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *c=
onfig)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(vdev);<br>
&gt; @@ -1004,6 +1014,56 @@ static void virtio_net_set_features(VirtIODevic=
e *vdev,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void virtio_net_tx_timer(void *opaque);<br>
&gt;=C2=A0 <br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_queue_pair=
s; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D &amp;n-&gt;vqs[i];<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;rx_coal_usecs =3D le3=
2_to_cpu(coal.max_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;rx_coal_packets =3D l=
e32_to_cpu(coal.max_packets);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;rx_coal_usecs &gt=
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_clear_point=
er(&amp;q-&gt;rx_timer, timer_free);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_queue_pair=
s; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D &amp;n-&gt;vqs[i];<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_coal_usecs =3D le3=
2_to_cpu(coal.max_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_coal_packets =3D l=
e32_to_cpu(coal.max_packets);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Converted us to ns */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_timeout =3D q-&gt;=
tx_coal_usecs * 1000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_coal_usecs &gt=
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_clear_point=
er(&amp;q-&gt;tx_timer, timer_free);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
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
&gt; @@ -1583,6 +1643,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *=
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
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 s =3D iov_from_buf(in_sg, in_num, 0, &amp;status, =
sizeof(status));<br>
&gt; @@ -2042,7 +2104,23 @@ static ssize_t virtio_net_receive_rcu(NetClient=
State *nc, const uint8_t *buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtqueue_flush(q-&gt;rx_vq, i);<br>
&gt; -=C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;rx_vq);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* rx coalescing */<br>
&gt; +=C2=A0 =C2=A0 q-&gt;rx_pkt_cnt +=3D i;<br>
&gt; +=C2=A0 =C2=A0 if (q-&gt;rx_coal_usecs =3D=3D 0 || q-&gt;rx_pkt_cnt &g=
t;=3D q-&gt;rx_coal_packets) {<br>
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
 =C2=A0 =C2=A0 =C2=A0 q-&gt;rx_coal_usecs * 1000);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return size;<br>
&gt;=C2=A0 <br>
&gt; @@ -2900,6 +2978,12 @@ static void virtio_net_tx_timer(void *opaque)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (q-&gt;tx_pkt_cnt &lt; ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_pkt_cnt -=3D ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
q-&gt;tx_pkt_cnt -=3D MIN(q-&gt;tx_pkt_cnt, ret);<br>
<br>
?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* If we flush a full burst of packets, assum=
e there are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* more coming and immediately rearm<br>
&gt; @@ -2919,6 +3003,7 @@ static void virtio_net_tx_timer(void *opaque)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D virtio_net_flush_tx(q);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_set_notification(q-&gt;=
tx_vq, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_pkt_cnt -=3D ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_waiting =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(q-&gt;tx_timer,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q=
emu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n-&gt;tx_timeout);<br>
&gt; @@ -2985,6 +3070,15 @@ static void virtio_net_handle_tx_dispatch(VirtI=
ODevice *vdev, VirtQueue *vq)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0virtio_net_tx_timer, q);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_timer(vdev, vq)=
;<br>
&gt; +=C2=A0 =C2=A0 } else if (q-&gt;tx_coal_usecs &gt; 0 &amp;&amp; q-&gt;=
tx_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_pkt_cnt++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_pkt_cnt &lt; q-&gt;tx_coal_p=
ackets) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_timer(=
vdev, vq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(q-&gt;tx_timer);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_bh(vde=
v, vq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_handle_tx_bh(vdev, vq);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -3006,6 +3100,12 @@ static void virtio_net_add_queue(VirtIONet *n, =
int index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;DEVICE(vdev)-&gt;mem_reentrancy_gua=
rd);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_waiting =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].rx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].rx_coal_usecs =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_coal_usecs =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].rx_coal_packets =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_coal_packets =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].n =3D n;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -3018,10 +3118,12 @@ static void virtio_net_del_queue(VirtIONet *n,=
 int index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_purge_queued_packets(nc);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_del_queue(vdev, index * 2);<br>
&gt; -=C2=A0 =C2=A0 if (q-&gt;tx_timer) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_free(q-&gt;tx_timer);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_timer =3D NULL;<br>
&gt; -=C2=A0 =C2=A0 } else {<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Cleanup coalescing timers */<br>
&gt; +=C2=A0 =C2=A0 g_clear_pointer(&amp;q-&gt;rx_timer, timer_free);<br>
&gt; +=C2=A0 =C2=A0 g_clear_pointer(&amp;q-&gt;tx_timer, timer_free);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (q-&gt;tx_bh) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_bh_delete(q-&gt;tx_bh);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_bh =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -3098,6 +3200,13 @@ static void virtio_net_get_features(VirtIODevic=
e *vdev, uint64_t *features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_features_or(features, features, n-&gt;host_=
features_ex);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);=
<br>
&gt; +=C2=A0 =C2=A0 if (n-&gt;tx_timer_activate) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_clear_feature_ex(features, VIRTIO_=
NET_F_NOTF_COAL);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virtio_has_feature(*features, VIRTIO=
_NET_F_NOTF_COAL)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *features &amp;=3D ~(1ULL &=
lt;&lt; VIRTIO_NET_F_NOTF_COAL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!peer_has_vnet_hdr(n)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_clear_feature_ex(features, VI=
RTIO_NET_F_CSUM);<br>
&gt; @@ -3252,6 +3361,27 @@ static int virtio_net_post_load_device(void *op=
aque, int version_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_net_commit_rss_config(n);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_queue_pairs; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VirtIONetQueue *q =3D &amp;n-&gt;vqs[i];<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;rx_coal_usecs &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;rx_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;rx_time=
r =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0virtio_net_rx_notify,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_coal_usecs &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_timeout =3D q-&gt;=
tx_coal_usecs * 1000;<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -3271,13 +3401,41 @@ static int virtio_net_post_load_virtio(VirtIOD=
evice *vdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static bool virtio_net_queue_notf_coal_needed(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIONetQueue *q =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 VirtIONet *n =3D q-&gt;n;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return virtio_vdev_has_feature(VIRTIO_DEVICE(n), VIRTIO=
_NET_F_NOTF_COAL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateDescription vmstate_virtio_net_queue_notf_coal =
=3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;virtio-net-queue-tx_waiting/notf-coal&q=
uot;,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .needed =3D virtio_net_queue_notf_coal_needed,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (const VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_coal_usecs, VirtIONetQu=
eue),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_coal_usecs, VirtIONetQu=
eue),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_coal_packets, VirtIONet=
Queue),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_coal_packets, VirtIONet=
Queue),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_pkt_cnt, VirtIONetQueue=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_pkt_cnt, VirtIONetQueue=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 /* tx_waiting field of a VirtIONetQueue */<br>
&gt;=C2=A0 static const VMStateDescription vmstate_virtio_net_queue_tx_wait=
ing =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .name =3D &quot;virtio-net-queue-tx_waiting&quot;,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .fields =3D (const VMStateField[]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_waiting, VirtIONet=
Queue),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; -=C2=A0 =C2=A0},<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .subsections =3D (const VMStateDescription * const []) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;vmstate_virtio_net_queue_notf_coal,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static bool max_queue_pairs_gt_1(void *opaque, int version_id)<b=
r>
&gt; @@ -3982,6 +4140,10 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (n-&gt;net_conf.tx &amp;&amp; strcmp(n-&gt;net_=
conf.tx, &quot;timer&quot;) =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;tx_timer_activate =3D true;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n-&gt;host_features &amp; (1ULL &lt;&=
lt; VIRTIO_NET_F_NOTF_COAL)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;virtio-ne=
t: &#39;vq_notf_coal&#39; is incompatible with &#39;tx=3Dtimer&#39;,&quot;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;disabling notification coalescing&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;net_conf.tx_queue_size =3D MIN(virtio_net_ma=
x_tx_queue_size(n),<br>
&gt; @@ -4272,6 +4434,8 @@ static const Property virtio_net_properties[] =
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
 =C2=A0 VIRTIO_NET_F_NOTF_COAL, false),<br>
<br>
So when do you expect users to enable this?<br></blockquote><div>Adds the `=
x-vq_notf_coal=3Don` device parameter to dynamically enable virtqueue notif=
ication coalescing at VM startup.=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
If this is experimental, let&#39;s make it unstable (start with &quot;x-&qu=
ot;).<br></blockquote><div>Resolved in V10=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
<br>
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
&gt; index a4eb3f407e..550aaea2be 100644<br>
&gt; --- a/include/hw/virtio/virtio-net.h<br>
&gt; +++ b/include/hw/virtio/virtio-net.h<br>
&gt; @@ -159,12 +159,19 @@ typedef struct VirtIONetQueue {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtQueue *rx_vq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtQueue *tx_vq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QEMUTimer *tx_timer;<br>
&gt; +=C2=A0 =C2=A0 QEMUTimer *rx_timer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QEMUBH *tx_bh;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t tx_waiting;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VirtQueueElement *elem;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } async_tx;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct VirtIONet *n;<br>
&gt; +=C2=A0 =C2=A0 uint32_t rx_coal_usecs;=C2=A0 =C2=A0/* RX interrupt coa=
lescing timeout (microseconds) */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rx_coal_packets; /* RX packet count threshold =
for coalescing */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rx_pkt_cnt;=C2=A0 =C2=A0 =C2=A0 /* Current RX =
packet count since last notification */<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_coal_usecs;=C2=A0 =C2=A0/* TX interrupt coa=
lescing timeout (microseconds) */<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_coal_packets; /* TX packet count threshold =
for coalescing */<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_pkt_cnt;=C2=A0 =C2=A0 =C2=A0 /* Current TX =
packet count since last notification */<br>
<br>
Please organize this in some kind of structure.<br>
This way no need to repeat &quot;coalescing&quot; each time.<br>
<br></blockquote><div>Resolved in V10=C2=A0=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 } VirtIONetQueue;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct VirtIONet {<br>
&gt; diff --git a/net/passt.c b/net/passt.c<br>
&gt; index 45440c399b..43b36ed8c5 100644<br>
&gt; --- a/net/passt.c<br>
&gt; +++ b/net/passt.c<br>
&gt; @@ -52,6 +52,7 @@ static const int user_feature_bits[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_USO4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_USO6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_HOST_USO,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_NET_F_NOTF_COAL,<br>
&gt;=C2=A0 <br>
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
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* This bit implies RARP isn&#39;t sent by QEMU ou=
t of band */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_ANNOUNCE,<br>
<br>
<br>
So the point of the whitelists is not to make people blindly<br>
copy-paste them everywhere, but instead to make a plan how this will work.<=
br>
<br>
For example, we need to send the control to backend I presume?<br>
<br>
<br>
Similar for other backends.<br>
<br>
<br>
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
&gt; -- <br>
&gt; 2.53.0<br>
<br></blockquote><div><br>Regards,<br>Koushik=C2=A0</div></div></div>

--0000000000006bd85e0656bcdb3a--


