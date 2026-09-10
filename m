Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8ADC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4bpS-0005zm-Rl; Thu, 10 Sep 2026 06:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1x4bpR-0005zb-IS
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1x4bpO-0002B3-AF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789035380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmyw4vOhsUCDg9QpnLP7xItMQNGL07PaVfBjoTB1eKI=;
 b=AZxH7SSTmBL/57NtbHw/McC2oNVqpEWKpfZdFaS37x0gwv8DbCpHbs9gZYWg8uWrlBfOY3
 YFUZa8yppCrN2Lr47XPHGyqxrmFelqFUnpk/yp9PLsk6WRF37JQfA7K5M0lidYbxkTIWI0
 +uN7OMPF3BhURn4xyt9wWvlyNFl76Kc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-GbHlt8mANOKCtdQH5WDcbQ-1; Thu, 10 Sep 2026 06:16:18 -0400
X-MC-Unique: GbHlt8mANOKCtdQH5WDcbQ-1
X-Mimecast-MFC-AGG-ID: GbHlt8mANOKCtdQH5WDcbQ_1789035378
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-836cfb589a3so132127167b3.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 03:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789035378; cv=none;
 d=google.com; s=arc-20260327;
 b=tDVIS5fJ7oFViKIBf27xfemxYH86Gu/4eZ5Qr/fDVRyFjas/9qDnpk7R7DBBGmtRQZ
 CEvRHDN79167Of578sOnG9PlILYZ0INrQRwJ6Ak6gMtcni/wQSfSr9ElARTCvg2likWC
 SAK/iy8lAb/PeNvPa8Qp7riUGmR8gCmDcsp4Omr42nO4a2W5ZyyefSmO3U2mLf4lEtI0
 Mq/4Fxk7swnw57297xKL+GFKCYOXQjZWNY3SiYd5YTisBX+hFdnfo1v5L8MCKjouat+K
 ofLcJAbMcWVHkCRajpleuAXUjeJKe6SH2iaKb36ub2dyCvBRS2f/d+7C153B3udgkwHH
 M6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hmyw4vOhsUCDg9QpnLP7xItMQNGL07PaVfBjoTB1eKI=;
 fh=RDYgKVmhpeeeWFaDEIxNf+zd9KhuLddsy1pIv/K03X8=;
 b=hoqPsgU19V5AIDpeBs5mAiSxanwQBv1WjYv5TeD4xk7abH0KPqJG2ENkb1dy7yMlc6
 SaCJQpkxGFzly/QC+iAnXJuxDyfsuUHK0ilBw0DiNZ3iMJIWc5PGRhpBvyxDxehA44Ki
 /wZxXmn3T+5fwWE2WzM+WaxqnIpNM9bqttn8QeNs8DtjVMYj8YyzrbNVksqasSfiazD/
 JYLQ1G1VPmm2DaAGRLZ6hiu2lR4biw85S52zxOoFECIgMrLa6+8JOzVqEWuHqoavT/8v
 33OLzJC72WzeKOS+dkDdo1o3xPsandFzUQl/A+VlYCfjOGfsPgq0dPN+dxFsqQ4tSOdL
 RjBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789035378; x=1789640178; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hmyw4vOhsUCDg9QpnLP7xItMQNGL07PaVfBjoTB1eKI=;
 b=OwHJkqLCQ0HRqVAyDpByp327o0RT4cb8+0CPo+QT4QDOEq6CzpnMWotVUxybQkfaqv
 yjflw5OhXjBboVogJDD5B8BTHTaD7DHKAkXF1dFiB/ZMM5ppexkK3AUUYGM5HaQ9as85
 0juc+6WAEKr5kELEWcOYPdl0U1ytlVQ4xvozSuvHW+9ErJowxU1ZBF5J1ocSazhuq12U
 AjP6J6S+tLQXIF062xPipNV2OHq8XVQDpbTGy0FAHv+m4XnTJNostRW3sshogzyQXzEA
 r/RciF7IOD+1OStjCxJHxEr4dy9/xHKeVj0NNF8f0EKyiZw9VVh7qJjXbwOemnd2tDJ6
 pZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789035378; x=1789640178;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hmyw4vOhsUCDg9QpnLP7xItMQNGL07PaVfBjoTB1eKI=;
 b=J3NDYETRdfq0tKirzsGj7+ZERPlHdqskSm1c0tS8H34bmLVF0zoRqeI3iLqT9fBiyT
 933gmmaK01PRlTCClyZp148vJcfS5CvZxqVUlldAM7/bYK3RaGyhndkDxA53FAKDv0Jr
 7c+wB4m0je34o63lG4FFI8FQk1U0xUhSGIlxIhAr9B1IyJlSZRegZJypWRJeg+XISC3d
 RPA8jGfwNNOrni7GNBRrL6ViAmoxqo1KBN1sTST+ND8gTv5o6Uya5jf9z15WeAzEJeSM
 +liZGgKAp8PLhsVlYfXg+suvrslLuQuT2M72qlONfvc3+A+1UhbEOLLFcwkTTqybC9Lk
 pVgA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQTQ1FJG9HT/BO0kIDkVcGWF0x7XtxEMtB2Smb6s2dj6yJJOde9Xccb0cZqw/KB9EJTLu72j9n8m3M@nongnu.org
X-Gm-Message-State: AFuF++lnxh/1Y6AI1kbxrAL1Kmcf1QT/wfRb8kvCW8fCnSvNZd7o56TG
 LvIq+JWJFLf3j2V4EKCEl2jXefO5csUD1SvwxxZ8gPQuSNn0Gpsvh1wQhp4AThf0HPwLkpd8flx
 hkD57RoJUmDvu7q2bafd4cXOFexXZD+fWJNpZ9Ovkm1Nlb2d8GWx+dP2Cz/vVGc7ZdvByAImuMN
 N+CKQl41kd8JxcWDkWFPsiyolaysaY2XM=
X-Gm-Gg: AYBFou0VbM4d+pULkY+SBcF6mvcWp9nV+d8QGQd5uoaJ75K6r6QfXmprj+0SgBIR3bR
 +dYPtz5l7ZnZyNUT6HYESmePbjtnePcn3ebqO0TQBQE1wAR+fkjzMn4aY57mI+99rK7dUykmskL
 SS6fB8YTJdLGsay0JDQsewfN2my1kVMAcJ8W3HLPxL42lpqrpvwOg5Jjv1H5oa1ShEwrtAYx5m8
 bRJXiXZx72QPAhd/QXIQhYrR1KAgbwNMyedtgHXUlGQ2G3Y4dk2dgO6bhk=
X-Received: by 2002:a05:690c:f06:b0:87f:244c:7aaf with SMTP id
 00721157ae682-88157cc1356mr30512437b3.47.1789035378120; 
 Thu, 10 Sep 2026 03:16:18 -0700 (PDT)
X-Received: by 2002:a05:690c:f06:b0:87f:244c:7aaf with SMTP id
 00721157ae682-88157cc1356mr30512277b3.47.1789035377551; Thu, 10 Sep 2026
 03:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260716134421.3765533-1-kdutta@redhat.com>
 <20260716134421.3765533-3-kdutta@redhat.com>
 <20260910034751-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260910034751-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 10 Sep 2026 12:15:40 +0200
X-Gm-Features: AcwNN1VIZUXTZtsFido9-NAf7kfmLa-eF8Cj9Wo6piBL_ZfUsEEiRG1TF6PFURk
Message-ID: <CAJaqyWdX5pTvW+-FFjLJmjNz6QFaPQHsbFh_vQ-=GK6UmWGJiA@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] [PATCH 2/2] Implement VirtIO Network Notification
 Coalescing (VIRTIO_NET_F_NOTF_COAL). This allows guests to reduce
 interrupt
 overhead by configuring coalescing parameters via ethtool -C for both RX and
 TX paths.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Koushik Dutta <kdutta@redhat.com>, qemu-devel@nongnu.org, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 10, 2026 at 9:52=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> subject is unreasonably long here
>
>
> On Thu, Jul 16, 2026 at 07:14:21PM +0530, Koushik Dutta wrote:
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
> > Adds the `x-vq_notf_coal=3Don` device parameter to dynamically enable
> > virtqueue notification coalescing at VM startup.
>
>
> we really do not want to train users to use x- properties.
>
> > Performance metrics (Moderate Coalescing vs Without Coalescing):
> > - RX parameters: 1000=E7=9B=9C, 10 frames
> > - TX parameters: 2000=E7=9B=9C, 20 frames
> > - Results: 20% drop in CPU overhead and a 30% reduction in interrupts.
> >
> > Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> > ---
> >  hw/net/virtio-net.c            | 203 ++++++++++++++++++++++++++++++++-
> >  include/hw/virtio/virtio-net.h |  10 ++
> >  net/passt.c                    |   1 +
> >  net/tap.c                      |   1 +
> >  net/vhost-user.c               |   1 +
> >  net/vhost-vdpa.c               |   1 +
> >  6 files changed, 213 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index e7f05956a5..fac1013d47 100644
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
> > +    q->rx_coal.pkt_cnt =3D 0;
> > +    virtio_notify(vdev, q->rx_vq);
> > +}
> > +
> >  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> >  {
> >      VirtIONet *n =3D VIRTIO_NET(vdev);
> > @@ -1002,6 +1012,87 @@ static void virtio_net_set_features(VirtIODevice=
 *vdev,
> >      }
> >  }
> >
> > +static void virtio_net_tx_notification_timer(void *opaque)
> > +{
> > +    VirtIONetQueue *q =3D opaque;
> > +    VirtIONet *n =3D q->n;
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> > +
> > +    q->tx_coal.pkt_cnt =3D 0;
> > +    virtio_notify(vdev, q->tx_vq);
> > +}
> > +
> > +static bool virtio_net_tx_should_notify(VirtIONetQueue *q)
> > +{
> > +    if (q->tx_coal.usecs =3D=3D 0 || !q->tx_coal.timer) {
> > +        return true;
> > +    }
> > +
> > +    q->tx_coal.pkt_cnt++;
> > +
> > +    if (q->tx_coal.packets > 0 && q->tx_coal.pkt_cnt >=3D q->tx_coal.p=
ackets) {
> > +        q->tx_coal.pkt_cnt =3D 0;
> > +        timer_del(q->tx_coal.timer);
> > +        return true;
> > +    }
> > +
> > +    if (!timer_pending(q->tx_coal.timer)) {
> > +        timer_mod(q->tx_coal.timer,
> > +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> > +                  q->tx_coal.usecs * 1000); /* Converted to ns */
> > +    }
> > +
> > +    return false;
> > +}
> > +
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
> > +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +            q =3D &n->vqs[i];
> > +            q->rx_coal.usecs =3D le32_to_cpu(coal.max_usecs);
> > +            q->rx_coal.packets =3D le32_to_cpu(coal.max_packets);
> > +            q->rx_coal.pkt_cnt =3D 0;
> > +            if (q->rx_coal.usecs > 0) {
> > +                /* Delete old timer if exists, then create new one */
> > +                g_clear_pointer(&q->rx_coal.timer, timer_free);
> > +                q->rx_coal.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                                virtio_net_rx_notify,
> > +                                                q);
> > +            } else {
> > +                g_clear_pointer(&q->rx_coal.timer, timer_free);
> > +            }
> > +        }
> > +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> > +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +            q =3D &n->vqs[i];
> > +            q->tx_coal.usecs =3D le32_to_cpu(coal.max_usecs);
> > +            q->tx_coal.packets =3D le32_to_cpu(coal.max_packets);
> > +            q->tx_coal.pkt_cnt =3D 0;
> > +            if (q->tx_coal.usecs > 0) {
> > +                g_clear_pointer(&q->tx_coal.timer, timer_free);
> > +                q->tx_coal.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                                virtio_net_tx_notifica=
tion_timer,
> > +                                                q);
> > +            } else {
> > +                g_clear_pointer(&q->tx_coal.timer, timer_free);
> > +            }
> > +        }
> > +    }
> > +    return VIRTIO_NET_OK;
> > +}
> > +
> >  static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
> >                                       struct iovec *iov, unsigned int i=
ov_cnt)
> >  {
> > @@ -1581,6 +1672,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *v=
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
> > @@ -2040,7 +2133,23 @@ static ssize_t virtio_net_receive_rcu(NetClientS=
tate *nc, const uint8_t *buf,
> >      }
> >
> >      virtqueue_flush(q->rx_vq, i);
> > -    virtio_notify(vdev, q->rx_vq);
> > +
> > +    /* rx coalescing */
> > +    q->rx_coal.pkt_cnt +=3D i;
> > +    if (q->rx_coal.usecs =3D=3D 0 || q->rx_coal.pkt_cnt >=3D q->rx_coa=
l.packets) {
> > +        if (q->rx_coal.timer) {
> > +            timer_del(q->rx_coal.timer);
> > +        }
> > +        virtio_net_rx_notify(q);
> > +    } else {
> > +        if (q->rx_coal.timer) {
> > +            if (!timer_pending(q->rx_coal.timer)) {
> > +                timer_mod(q->rx_coal.timer,
> > +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> > +                          q->rx_coal.usecs * 1000); /* Converted to ns=
 */
> > +            }
> > +        }
> > +    }
> >
> >      return size;
> >
> > @@ -2690,7 +2799,9 @@ static void virtio_net_tx_complete(NetClientState=
 *nc, ssize_t len)
> >      int ret;
> >
> >      virtqueue_push(q->tx_vq, q->async_tx.elem, 0);
> > -    virtio_notify(vdev, q->tx_vq);
> > +    if (virtio_net_tx_should_notify(q)) {
> > +        virtio_notify(vdev, q->tx_vq);
> > +    }
> >
> >      g_free(q->async_tx.elem);
> >      q->async_tx.elem =3D NULL;
> > @@ -2802,7 +2913,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueu=
e *q)
> >
> >  drop:
> >          virtqueue_push(q->tx_vq, elem, 0);
> > -        virtio_notify(vdev, q->tx_vq);
> > +        if (virtio_net_tx_should_notify(q)) {
> > +            virtio_notify(vdev, q->tx_vq);
> > +        }
> > +
> >          g_free(elem);
> >
> >          if (++num_packets >=3D n->tx_burst) {
> > @@ -2899,6 +3013,7 @@ static void virtio_net_tx_timer(void *opaque)
> >      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
> >          return;
> >      }
> > +
> >      /*
> >       * If we flush a full burst of packets, assume there are
> >       * more coming and immediately rearm
> > @@ -3005,6 +3120,12 @@ static void virtio_net_add_queue(VirtIONet *n, i=
nt index)
> >                              &DEVICE(vdev)->mem_reentrancy_guard);
> >
> >      n->vqs[index].tx_waiting =3D 0;
> > +    n->vqs[index].rx_coal.pkt_cnt =3D 0;
> > +    n->vqs[index].tx_coal.pkt_cnt =3D 0;
> > +    n->vqs[index].rx_coal.usecs =3D 0;
> > +    n->vqs[index].tx_coal.usecs =3D 0;
> > +    n->vqs[index].rx_coal.packets =3D 0;
> > +    n->vqs[index].tx_coal.packets =3D 0;
> >      n->vqs[index].n =3D n;
> >  }
> >
> > @@ -3017,6 +3138,11 @@ static void virtio_net_del_queue(VirtIONet *n, i=
nt index)
> >      qemu_purge_queued_packets(nc);
> >
> >      virtio_del_queue(vdev, index * 2);
> > +
> > +    /* Cleanup coalescing timers */
> > +    g_clear_pointer(&q->rx_coal.timer, timer_free);
> > +    g_clear_pointer(&q->tx_coal.timer, timer_free);
> > +
> >      if (q->tx_timer) {
> >          timer_free(q->tx_timer);
> >          q->tx_timer =3D NULL;
> > @@ -3097,6 +3223,13 @@ static void virtio_net_get_features(VirtIODevice=
 *vdev, uint64_t *features,
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
> > @@ -3251,6 +3384,26 @@ static int virtio_net_post_load_device(void *opa=
que, int version_id)
> >      }
> >
> >      virtio_net_commit_rss_config(n);
> > +
> > +    for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +        VirtIONetQueue *q =3D &n->vqs[i];
> > +        if (q->rx_coal.usecs > 0) {
> > +            if (!q->rx_coal.timer) {
> > +                q->rx_coal.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                                virtio_net_rx_notify,
> > +                                                q);
> > +            }
> > +        }
> > +
> > +        if (q->tx_coal.usecs > 0) {
> > +            if (!q->tx_coal.timer) {
> > +                q->tx_coal.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                                virtio_net_tx_notifica=
tion_timer,
> > +                                                q);
> > +            }
> > +        }
> > +    }
> > +
>
>
> Not QEMU_CLOCK_VIRTUAL_RT?
>
> >      return 0;
> >  }
> >
> > @@ -3270,13 +3423,49 @@ static int virtio_net_post_load_virtio(VirtIODe=
vice *vdev)
> >      return 0;
> >  }
> >
> > +static const VMStateDescription vmstate_virtio_net_coal =3D {
> > +    .name =3D "virtio-net-coal",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_UINT32(usecs, VirtIONetCoal),
> > +        VMSTATE_UINT32(packets, VirtIONetCoal),
> > +        VMSTATE_UINT32(pkt_cnt, VirtIONetCoal),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> > +static bool virtio_net_queue_notf_coal_needed(void *opaque)
> > +{
> > +    VirtIONetQueue *q =3D opaque;
> > +    return q->rx_coal.usecs > 0 || q->tx_coal.usecs > 0;
> > +}
> > +
> > +static const VMStateDescription vmstate_virtio_net_queue_notf_coal =3D=
 {
> > +    .name =3D "virtio-net-queue-tx_waiting/notf-coal",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D virtio_net_queue_notf_coal_needed,
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_STRUCT(rx_coal, VirtIONetQueue, 0,
> > +                       vmstate_virtio_net_coal, VirtIONetCoal),
> > +        VMSTATE_STRUCT(tx_coal, VirtIONetQueue, 0,
> > +                       vmstate_virtio_net_coal, VirtIONetCoal),
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
> > @@ -3981,6 +4170,10 @@ static void virtio_net_device_realize(DeviceStat=
e *dev, Error **errp)
> >
> >      if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") =3D=3D 0) {
> >          n->tx_timer_activate =3D true;
> > +        if (n->host_features & (1ULL << VIRTIO_NET_F_NOTF_COAL)) {
> > +            warn_report("virtio-net: 'vq_notf_coal' is incompatible wi=
th 'tx=3Dtimer',"
> > +                        "disabling notification coalescing");
> > +        }
> >      }
> >
> >      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
> > @@ -4271,6 +4464,8 @@ static const Property virtio_net_properties[] =3D=
 {
> >                        VIRTIO_NET_F_GUEST_USO6, true),
> >      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> >                        VIRTIO_NET_F_HOST_USO, true),
> > +    DEFINE_PROP_BIT64("x-vq_notf_coal", VirtIONet, host_features,
> > +                      VIRTIO_NET_F_NOTF_COAL, false),
> >      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
> >                                    rss_data.specified_hash_types,
> >                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> > index a4eb3f407e..244c8a0224 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -155,6 +155,14 @@ typedef struct VirtioNetRssData {
> >      uint16_t default_queue;
> >  } VirtioNetRssData;
> >
> > +/* Interrupt notification coalescing parameters */
> > +typedef struct VirtIONetCoal {
> > +    uint32_t usecs;    /* Timeout in microseconds */
> > +    uint32_t packets;  /* Packet count threshold */
> > +    uint32_t pkt_cnt;  /* Current packet count since last notification=
 */
> > +    QEMUTimer *timer;  /* Coalescing timer */
> > +} VirtIONetCoal;
> > +
> >  typedef struct VirtIONetQueue {
> >      VirtQueue *rx_vq;
> >      VirtQueue *tx_vq;
> > @@ -165,6 +173,8 @@ typedef struct VirtIONetQueue {
> >          VirtQueueElement *elem;
> >      } async_tx;
> >      struct VirtIONet *n;
> > +    VirtIONetCoal rx_coal;
> > +    VirtIONetCoal tx_coal;
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
>
> please do not add these bits until someone actually implements this.
>

If we don't add them to this list, QEMU enables the feature bit for
the device even if the backend doesn't offer it. This enables the
guest to send the CVQ command and the device will receive it without
knowing how to process it.

This can be tested with nested virtualization, by wrapping an emulated
virtio-net device in vp_vdpa and then connecting it through vhost_vdpa
to a nested QEMU. I didn't test it by myself though, so I may be
missing something.


