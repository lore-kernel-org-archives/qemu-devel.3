Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DBBCCF2E9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xInzO-0000XH-Nv; Mon, 19 Oct 2026 10:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1xInzJ-0000Wv-I1
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1xInzE-0004Nx-5k
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792418709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezLVa3rWho9Rbal6fLJpyTJwZQH685ODKK/oPSJ4Nos=;
 b=BUZeFIPyGSg4Sx9FacAJWYzCZca3qKi6m5QXnft3F4IFk+CGo0JAD2bhs619tHjpUQLaJT
 lATdHV3BbHMvpOKTM9sYUqWbFclUXx3hGgTHHIRH7RMamZnz4ESAgAf1bkEV468AbDjhyY
 JHe05PF/nFFlIpdIvXpdfcoHfy5cqOY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-AvizOl-qOSm3wa2yE7LnOw-1; Mon, 19 Oct 2026 14:05:08 +0000
X-MC-Unique: AvizOl-qOSm3wa2yE7LnOw-1
X-Mimecast-MFC-AGG-ID: AvizOl-qOSm3wa2yE7LnOw_1792418707
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-917a510b22fso46915306d6.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 07:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792418707; cv=none;
 d=google.com; s=arc-20260327;
 b=lf+iCeuH7uW3mBAL/SQvwmT0fq6NCrMWvK8RWhWoiGNWSG6uWUfJhYvDs6cz7iGGT1
 oqUVjkaVi8neXJJuugHhqygIKo1MBwoEYkANNvouM/Exq5fNShOs9yHRtf/VItvg0Mz0
 j+VxQ+cEhJdrm53CHg9GlvDOql1hK9/xpraxxvHF3Ykv14hVullgZDvV5q+QomDiP28j
 xMBzjwyHiYIUTwM19TYE7h5kZJJGNh2xALDyGee43x79ghW+4sI4RIRJhP02NWYrbhiL
 zi5miN+1P8CTCnBqmqxX/xe7w7MvjKBkqfGhrJjvNcC+JhqTRRyIDyHrf35jmM8k/5ah
 TAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ezLVa3rWho9Rbal6fLJpyTJwZQH685ODKK/oPSJ4Nos=;
 fh=1kCIcbQqg3Bnj7TFGXrqwJRJGO0v7P4JTX6th4zcClU=;
 b=GrrvVV/hkZqLEKQjepZ85a8TkHp54J+5lPtXjjuqief43rsWgTthxkgA2ASvKkggQv
 7m6iljxJ6LN5j/eZe9mgi9S+qzGadF/2lSK0OCLmv1FYnC+hp0nRuC8LPpNLJDFqhdXH
 Vr1Ts48XZMSsfrr8CXbnm76GN9n/XAGVujUrkWqA1P1deeYoZFeqZBN225V/EDIunfaH
 /g9//hba6kRjPrAS/RXl/1gkKI9sXYxGKCc0WqpW2/kqRiTluj88MAsDB3LMnAZNqQ/P
 Mchnt76L08zTqtlSQg0rOT6ievZcJKHZWJlB7UqdfqzRAol0m+6E/gk/oxSWpzFz+hjs
 Jh5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792418707; x=1793023507; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ezLVa3rWho9Rbal6fLJpyTJwZQH685ODKK/oPSJ4Nos=;
 b=V+Q9gamvmAfDKzn9gj01pSBjZVtiQXQhPxJZRW+LbRN8XECfKWNZE3hEZZxjk3xyA8
 LLr/KOLWdyWuAz/UKtr1fZ1EYUUHOlNVLGY90zxzQ8lMYTUOpQgjzHyncqv4P+wnXur3
 AqRDoKgfcqmJXI8KpNJU5nTgQisfC58xzespBKFa156aJwJK2JMU+3mqp4pLhMHNfCir
 c71UsbOHHYpTqqQbJz5poDGCcORqiSFX3qdAPSeDWaWvHhY5DPeoB4WMIPq/DjIM3bzO
 CjACcavJzkJ6rwjY3bhFN2UQNqa1jHXrE/RpwtEMKQZC7qzeR11mzPM+eXlDO7vtio3b
 Kn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792418707; x=1793023507;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ezLVa3rWho9Rbal6fLJpyTJwZQH685ODKK/oPSJ4Nos=;
 b=zbBox3tGJNP7SXqvkG7VA+yTpR7XOlzpv/vt2FtSY87Cc/e4wGOvL5FG98Z/Cp2f+K
 J8uKsmLMqpvSMjB7/5kJWPkBPsKYtwjfYfU0J9xPz4XYHD8iXJHFfYOh7ZlTKgzoXfNd
 e3sOOmWRJ3ydr4sZpr1jYfqRa2g+DQvR1k+yES+OfClp7OxEWukI5GCdtXlkewq7I02F
 zA4lM9zVUBEX+lJTfAF7ZfrOeW9Ip/GLk/wmuIzQXoAkz7naZkeNYWTAj0HPcotiTpRs
 Z3SXFuJjkBwdzAmenmyr7AkeOOIMmFyOCQUErk6iwe1cs/CQeMTJ3eW5CWKZLlcwe/eR
 b3Zg==
X-Gm-Message-State: AFq9FYKMUWtAV00ANbIvQ5r/DRAec1Z6obBuNHDEYQGQJyRemU2QM7LI
 Hk7tcEH1UwENKER4v1crgLLcrTUNHWVNzVANracPoAfHxitlQx93XD4lifcSLotCRTG7qcfjbTr
 6JwDDRtQn8aw+AUYcmZlOChz2tTrqvQlC0kEqjjOpHlErGrr0Odb7lERIfRrTTDzPWbvOXxGyW6
 Hyuh78oa0exxx6VymiO6zb9m9NVge9wfQ=
X-Gm-Gg: AYBFou2RgsiBnwveBTbhZ76agsuzWgOXAnml6yHpmG/L6yiPhrvZlkLO3xJR2HUuiAx
 IplnQ7L4k4w8YvAOJyhri5ASuSfcALp1j4TeosAYcg7HyDr3AA6kq30nXiGF+knCKuJv7QhBWXV
 qetOiAXWTRDahNbYUi67YYcv8hbHZgM5vnUte6YwIev1+/PekZDKqfmuzrgPylwoxCt3fvuIktl
 /FKN6Nu7JUpj/y1jIdvW+aYfsZywyB7tOhswQCk/JrzSe4UfQSukukux9au
X-Received: by 2002:a05:6214:8401:b0:91b:e1a4:cfcc with SMTP id
 6a1803df08f44-91be1a4d0b4mr69389596d6.45.1792418707337; 
 Mon, 19 Oct 2026 07:05:07 -0700 (PDT)
X-Received: by 2002:a05:6214:8401:b0:91b:e1a4:cfcc with SMTP id
 6a1803df08f44-91be1a4d0b4mr69387946d6.45.1792418705014; Mon, 19 Oct 2026
 07:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260716134421.3765533-1-kdutta@redhat.com>
 <20260716134421.3765533-3-kdutta@redhat.com>
 <CAJaqyWeTCoTv-aRaZ_wLR9kujADAYM+sDz8dAsOw6sdWX2LmGQ@mail.gmail.com>
In-Reply-To: <CAJaqyWeTCoTv-aRaZ_wLR9kujADAYM+sDz8dAsOw6sdWX2LmGQ@mail.gmail.com>
From: Koushik Dutta <kdutta@redhat.com>
Date: Mon, 19 Oct 2026 19:34:54 +0530
X-Gm-Features: AclHuK870vAu3mAPvV-2DRIUnA4Ezdw2A-6Zqp-xGF9la8YXGsDiuT16QTue7CA
Message-ID: <CALseRdcUJn8rk+cs54EmZLV4T8GbPePj=5-+Pq282S3vY+vPkg@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] [PATCH 2/2] Implement VirtIO Network Notification
 Coalescing (VIRTIO_NET_F_NOTF_COAL). This allows guests to reduce
 interrupt
 overhead by configuring coalescing parameters via ethtool -C for both RX and
 TX paths.
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000033a24e065e320050"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--00000000000033a24e065e320050
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 7:51=E2=80=AFPM Eugenio Perez Martin <eperezma@redh=
at.com>
wrote:

> On Thu, Jul 16, 2026 at 3:44=E2=80=AFPM Koushik Dutta <kdutta@redhat.com>=
 wrote:
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
> > Note: When tx=3Dtimer is configured at VM launch, the coalescing featur=
e
> > is automatically disabled because tx=3Dtimer already introduces a fixed
> > 150=C2=B5s delay for packet batching, making notification coalescing
> redundant.
> >
>
> Where does this 150=C2=B5s value come from? The actual value is specified
> in the cmdline in ns.
>
> And that's not what I meant back then. I think the best action is to
> forbid the guest from changing the coalescing settings because it's
> hard to determine which setting should take precedence, even if the
> VirtIO specifies it is best effort. Let me know if I misunderstood
> your sentence so we can make it more accurate.
>
> > Adds the `x-vq_notf_coal=3Don` device parameter to dynamically enable
> > virtqueue notification coalescing at VM startup.
> >
> > Performance metrics (Moderate Coalescing vs Without Coalescing):
> > - RX parameters: 1000=C2=B5s, 10 frames
> > - TX parameters: 2000=C2=B5s, 20 frames
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
> > +    q->rx_coal.pkt_cnt =3D 0;
> > +    virtio_notify(vdev, q->rx_vq);
> > +}
> > +
> >  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> >  {
> >      VirtIONet *n =3D VIRTIO_NET(vdev);
> > @@ -1002,6 +1012,87 @@ static void virtio_net_set_features(VirtIODevice
> *vdev,
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
>
> Aren't these two conditions redundant?
>
Yes, the address is in the v11 patchset.

>
> > +        return true;
> > +    }
> > +
> > +    q->tx_coal.pkt_cnt++;
> > +
> > +    if (q->tx_coal.packets > 0 && q->tx_coal.pkt_cnt >=3D
> q->tx_coal.packets) {
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
> > +            q->rx_coal.usecs =3D le32_to_cpu(coal.max_usecs);
> > +            q->rx_coal.packets =3D le32_to_cpu(coal.max_packets);
> > +            q->rx_coal.pkt_cnt =3D 0;
> > +            if (q->rx_coal.usecs > 0) {
> > +                /* Delete old timer if exists, then create new one */
>
> Nit, I'd delete that comment as it is obvious from the code.
>
Yes, the address is in the v11 patchset.

>
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
> > +
> virtio_net_tx_notification_timer,
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
> >                                       struct iovec *iov, unsigned int
> iov_cnt)
> >  {
> > @@ -1581,6 +1672,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice
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
> > @@ -2040,7 +2133,23 @@ static ssize_t
> virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
> >      }
> >
> >      virtqueue_flush(q->rx_vq, i);
> > -    virtio_notify(vdev, q->rx_vq);
> > +
> > +    /* rx coalescing */
> > +    q->rx_coal.pkt_cnt +=3D i;
> > +    if (q->rx_coal.usecs =3D=3D 0 || q->rx_coal.pkt_cnt >=3D
> q->rx_coal.packets) {
> > +        if (q->rx_coal.timer) {
> > +            timer_del(q->rx_coal.timer);
>
> Doesn't it need to reset q->rx_coal.pkt_cnt too?
>
Yes, resetting the packet count is required. Doing that in below line
inside virtio_net_rx_notify function.

>
> > +        }
> > +        virtio_net_rx_notify(q);
> > +    } else {
> > +        if (q->rx_coal.timer) {
> > +            if (!timer_pending(q->rx_coal.timer)) {
> > +                timer_mod(q->rx_coal.timer,
> > +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> > +                          q->rx_coal.usecs * 1000); /* Converted to ns
> */
> > +            }
> > +        }
> > +    }
> >
> >      return size;
> >
> > @@ -2690,7 +2799,9 @@ static void virtio_net_tx_complete(NetClientState
> *nc, ssize_t len)
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
e
> *q)
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
>
> Useless blank change, let's remove it.
>
 Yes, the address is in the v11 patchset.

>
> >      /*
> >       * If we flush a full burst of packets, assume there are
> >       * more coming and immediately rearm
> > @@ -3005,6 +3120,12 @@ static void virtio_net_add_queue(VirtIONet *n,
> int index)
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
> > @@ -3017,6 +3138,11 @@ static void virtio_net_del_queue(VirtIONet *n,
> int index)
> >      qemu_purge_queued_packets(nc);
> >
> >      virtio_del_queue(vdev, index * 2);
> > +
> > +    /* Cleanup coalescing timers */
>
> Remove this comment as it is obvious from the code.
>
Yes, the address is in the v11 patchset.

>
> > +    g_clear_pointer(&q->rx_coal.timer, timer_free);
> > +    g_clear_pointer(&q->tx_coal.timer, timer_free);
> > +
> >      if (q->tx_timer) {
> >          timer_free(q->tx_timer);
> >          q->tx_timer =3D NULL;
> > @@ -3097,6 +3223,13 @@ static void virtio_net_get_features(VirtIODevice
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
> > @@ -3251,6 +3384,26 @@ static int virtio_net_post_load_device(void
> *opaque, int version_id)
> >      }
> >
> >      virtio_net_commit_rss_config(n);
> > +
> > +    for (i =3D 0; i < n->max_queue_pairs; i++) {
> > +        VirtIONetQueue *q =3D &n->vqs[i];
> > +        if (q->rx_coal.usecs > 0) {
> > +            if (!q->rx_coal.timer) {
>
> Let's save one indentation by using if (q->rx_coal.usecs > 0 &&
> !q->rx_coal.timer). Same for tx.
>
Yes, the address is in the v11 patchset.

>
> > +                q->rx_coal.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                                virtio_net_rx_notify,
> > +                                                q);
> > +            }
> > +        }
> > +
> > +        if (q->tx_coal.usecs > 0) {
> > +            if (!q->tx_coal.timer) {
> > +                q->tx_coal.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +
> virtio_net_tx_notification_timer,
> > +                                                q);
> > +            }
> > +        }
> > +    }
> > +
> >      return 0;
> >  }
> >
> > @@ -3270,13 +3423,49 @@ static int
> virtio_net_post_load_virtio(VirtIODevice *vdev)
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
> > diff --git a/include/hw/virtio/virtio-net.h
> b/include/hw/virtio/virtio-net.h
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
> > +    uint32_t pkt_cnt;  /* Current packet count since last notification
> */
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
> >
>
>

--00000000000033a24e065e320050
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 16,=
 2026 at 7:51=E2=80=AFPM Eugenio Perez Martin &lt;<a href=3D"mailto:eperezm=
a@redhat.com">eperezma@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Thu, Jul 16, 2026 at 3:44=E2=80=AFPM Ko=
ushik Dutta &lt;<a href=3D"mailto:kdutta@redhat.com" target=3D"_blank">kdut=
ta@redhat.com</a>&gt; wrote:<br>
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
&gt; Note: When tx=3Dtimer is configured at VM launch, the coalescing featu=
re<br>
&gt; is automatically disabled because tx=3Dtimer already introduces a fixe=
d<br>
&gt; 150=C2=B5s delay for packet batching, making notification coalescing r=
edundant.<br>
&gt;<br>
<br>
Where does this 150=C2=B5s value come from? The actual value is specified<b=
r>
in the cmdline in ns.<br>
<br>
And that&#39;s not what I meant back then. I think the best action is to<br=
>
forbid the guest from changing the coalescing settings because it&#39;s<br>
hard to determine which setting should take precedence, even if the<br>
VirtIO specifies it is best effort. Let me know if I misunderstood<br>
your sentence so we can make it more accurate.<br>
<br>
&gt; Adds the `x-vq_notf_coal=3Don` device parameter to dynamically enable<=
br>
&gt; virtqueue notification coalescing at VM startup.<br>
&gt;<br>
&gt; Performance metrics (Moderate Coalescing vs Without Coalescing):<br>
&gt; - RX parameters: 1000=C2=B5s, 10 frames<br>
&gt; - TX parameters: 2000=C2=B5s, 20 frames<br>
&gt; - Results: 20% drop in CPU overhead and a 30% reduction in interrupts.=
<br>
&gt;<br>
&gt; Signed-off-by: Koushik Dutta &lt;<a href=3D"mailto:kdutta@redhat.com" =
target=3D"_blank">kdutta@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2=
03 ++++++++++++++++++++++++++++++++-<br>
&gt;=C2=A0 include/hw/virtio/virtio-net.h |=C2=A0 10 ++<br>
&gt;=C2=A0 net/passt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 net/vhost-vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 6 files changed, 213 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index e7f05956a5..fac1013d47 100644<br>
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
&gt; +=C2=A0 =C2=A0 q-&gt;rx_coal.pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;rx_vq);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *c=
onfig)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(vdev);<br>
&gt; @@ -1002,6 +1012,87 @@ static void virtio_net_set_features(VirtIODevic=
e *vdev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static void virtio_net_tx_notification_timer(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIONetQueue *q =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 VirtIONet *n =3D q-&gt;n;<br>
&gt; +=C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 q-&gt;tx_coal.pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;tx_vq);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool virtio_net_tx_should_notify(VirtIONetQueue *q)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (q-&gt;tx_coal.usecs =3D=3D 0 || !q-&gt;tx_coal.time=
r) {<br>
<br>
Aren&#39;t these two conditions redundant?<br></blockquote><div>Yes, the ad=
dress is in the v11 patchset.=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 q-&gt;tx_coal.pkt_cnt++;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (q-&gt;tx_coal.packets &gt; 0 &amp;&amp; q-&gt;tx_co=
al.pkt_cnt &gt;=3D q-&gt;tx_coal.packets) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_coal.pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(q-&gt;tx_coal.timer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!timer_pending(q-&gt;tx_coal.timer)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(q-&gt;tx_coal.timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_c=
lock_get_ns(QEMU_CLOCK_VIRTUAL) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;=
tx_coal.usecs * 1000); /* Converted to ns */<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_queue_pair=
s; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D &amp;n-&gt;vqs[i];<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;rx_coal.usecs =3D le3=
2_to_cpu(coal.max_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;rx_coal.packets =3D l=
e32_to_cpu(coal.max_packets);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;rx_coal.pkt_cnt =3D 0=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;rx_coal.usecs &gt=
; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Delete old=
 timer if exists, then create new one */<br>
<br>
Nit, I&#39;d delete that comment as it is obvious from the code.<br></block=
quote><div><span style=3D"background-color:transparent">Yes, the address is=
 in the v11 patchset.=C2=A0</span>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_clear_point=
er(&amp;q-&gt;rx_coal.timer, timer_free);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;rx_coal=
.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_rx_notify,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_clear_point=
er(&amp;q-&gt;rx_coal.timer, timer_free);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_queue_pair=
s; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D &amp;n-&gt;vqs[i];<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_coal.usecs =3D le3=
2_to_cpu(coal.max_usecs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_coal.packets =3D l=
e32_to_cpu(coal.max_packets);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_coal.pkt_cnt =3D 0=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_coal.usecs &gt=
; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_clear_point=
er(&amp;q-&gt;tx_coal.timer, timer_free);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_coal=
.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_tx_notification_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_clear_point=
er(&amp;q-&gt;tx_coal.timer, timer_free);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return VIRTIO_NET_OK;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 iovec *iov, unsigned int iov_cnt)<br>
&gt;=C2=A0 {<br>
&gt; @@ -1581,6 +1672,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *=
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
&gt; @@ -2040,7 +2133,23 @@ static ssize_t virtio_net_receive_rcu(NetClient=
State *nc, const uint8_t *buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtqueue_flush(q-&gt;rx_vq, i);<br>
&gt; -=C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;rx_vq);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* rx coalescing */<br>
&gt; +=C2=A0 =C2=A0 q-&gt;rx_coal.pkt_cnt +=3D i;<br>
&gt; +=C2=A0 =C2=A0 if (q-&gt;rx_coal.usecs =3D=3D 0 || q-&gt;rx_coal.pkt_c=
nt &gt;=3D q-&gt;rx_coal.packets) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;rx_coal.timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(q-&gt;rx_coal.tim=
er);<br>
<br>
Doesn&#39;t it need to reset q-&gt;rx_coal.pkt_cnt too?<br></blockquote><di=
v>Yes, resetting the packet count is required. Doing that in below line ins=
ide virtio_net_rx_notify function.=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_rx_notify(q);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;rx_coal.timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!timer_pending(q-&gt;rx=
_coal.timer)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(q-&=
gt;rx_coal.timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 q-&gt;rx_coal.usecs * 1000); /* Converted to ns */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return size;<br>
&gt;<br>
&gt; @@ -2690,7 +2799,9 @@ static void virtio_net_tx_complete(NetClientStat=
e *nc, ssize_t len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtqueue_push(q-&gt;tx_vq, q-&gt;async_tx.elem, 0=
);<br>
&gt; -=C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;tx_vq);<br>
&gt; +=C2=A0 =C2=A0 if (virtio_net_tx_should_notify(q)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;tx_vq);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(q-&gt;async_tx.elem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 q-&gt;async_tx.elem =3D NULL;<br>
&gt; @@ -2802,7 +2913,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQue=
ue *q)<br>
&gt;<br>
&gt;=C2=A0 drop:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtqueue_push(q-&gt;tx_vq, elem, 0)=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;tx_vq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (virtio_net_tx_should_notify(q)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_notify(vdev, q-&gt;t=
x_vq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(elem);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (++num_packets &gt;=3D n-&gt;tx_b=
urst) {<br>
&gt; @@ -2899,6 +3013,7 @@ static void virtio_net_tx_timer(void *opaque)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
Useless blank change, let&#39;s remove it.<br></blockquote><div>=C2=A0<span=
 style=3D"background-color:transparent">Yes, the address is in the v11 patc=
hset.</span></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* If we flush a full burst of packets, assum=
e there are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* more coming and immediately rearm<br>
&gt; @@ -3005,6 +3120,12 @@ static void virtio_net_add_queue(VirtIONet *n, =
int index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;DEVICE(vdev)-&gt;mem_reentrancy_gua=
rd);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].tx_waiting =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].rx_coal.pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_coal.pkt_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].rx_coal.usecs =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_coal.usecs =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].rx_coal.packets =3D 0;<br>
&gt; +=C2=A0 =C2=A0 n-&gt;vqs[index].tx_coal.packets =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;vqs[index].n =3D n;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; @@ -3017,6 +3138,11 @@ static void virtio_net_del_queue(VirtIONet *n, =
int index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_purge_queued_packets(nc);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_del_queue(vdev, index * 2);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Cleanup coalescing timers */<br>
<br>
Remove this comment as it is obvious from the code.<br></blockquote><div><s=
pan style=3D"background-color:transparent">Yes, the address is in the v11 p=
atchset.</span>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
&gt; +=C2=A0 =C2=A0 g_clear_pointer(&amp;q-&gt;rx_coal.timer, timer_free);<=
br>
&gt; +=C2=A0 =C2=A0 g_clear_pointer(&amp;q-&gt;tx_coal.timer, timer_free);<=
br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_timer) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_free(q-&gt;tx_timer);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_timer =3D NULL;<br>
&gt; @@ -3097,6 +3223,13 @@ static void virtio_net_get_features(VirtIODevic=
e *vdev, uint64_t *features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_features_or(features, features, n-&gt;host_=
features_ex);<br>
&gt;<br>
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
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!peer_has_vnet_hdr(n)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_clear_feature_ex(features, VI=
RTIO_NET_F_CSUM);<br>
&gt; @@ -3251,6 +3384,26 @@ static int virtio_net_post_load_device(void *op=
aque, int version_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio_net_commit_rss_config(n);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;max_queue_pairs; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VirtIONetQueue *q =3D &amp;n-&gt;vqs[i];<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;rx_coal.usecs &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;rx_coal.timer) {=
<br>
<br>
Let&#39;s save one indentation by using if (q-&gt;rx_coal.usecs &gt; 0 &amp=
;&amp;<br>
!q-&gt;rx_coal.timer). Same for tx.<br></blockquote><div><span style=3D"bac=
kground-color:transparent">Yes, the address is in the v11 patchset.</span>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;rx_coal=
.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_rx_notify,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q-&gt;tx_coal.usecs &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!q-&gt;tx_coal.timer) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q-&gt;tx_coal=
.timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_tx_notification_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; @@ -3270,13 +3423,49 @@ static int virtio_net_post_load_virtio(VirtIOD=
evice *vdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static const VMStateDescription vmstate_virtio_net_coal =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;virtio-net-coal&quot;,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (const VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(usecs, VirtIONetCoal),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(packets, VirtIONetCoal),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(pkt_cnt, VirtIONetCoal),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static bool virtio_net_queue_notf_coal_needed(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIONetQueue *q =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 return q-&gt;rx_coal.usecs &gt; 0 || q-&gt;tx_coal.usec=
s &gt; 0;<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_STRUCT(rx_coal, VirtIONetQueue, 0=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0vmstate_virtio_net_coal, VirtIONetCoal),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_STRUCT(tx_coal, VirtIONetQueue, 0=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0vmstate_virtio_net_coal, VirtIONetCoal),<br>
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
&gt;<br>
&gt;=C2=A0 static bool max_queue_pairs_gt_1(void *opaque, int version_id)<b=
r>
&gt; @@ -3981,6 +4170,10 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)<br>
&gt;<br>
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
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;net_conf.tx_queue_size =3D MIN(virtio_net_ma=
x_tx_queue_size(n),<br>
&gt; @@ -4271,6 +4464,8 @@ static const Property virtio_net_properties[] =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_USO6, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BIT64(&quot;host_uso&quot;, VirtIONet,=
 host_features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 VIRTIO_NET_F_HOST_USO, true),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BIT64(&quot;x-vq_notf_coal&quot;, VirtIONet=
, host_features,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 VIRTIO_NET_F_NOTF_COAL, false),<br>
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
&gt; index a4eb3f407e..244c8a0224 100644<br>
&gt; --- a/include/hw/virtio/virtio-net.h<br>
&gt; +++ b/include/hw/virtio/virtio-net.h<br>
&gt; @@ -155,6 +155,14 @@ typedef struct VirtioNetRssData {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t default_queue;<br>
&gt;=C2=A0 } VirtioNetRssData;<br>
&gt;<br>
&gt; +/* Interrupt notification coalescing parameters */<br>
&gt; +typedef struct VirtIONetCoal {<br>
&gt; +=C2=A0 =C2=A0 uint32_t usecs;=C2=A0 =C2=A0 /* Timeout in microseconds=
 */<br>
&gt; +=C2=A0 =C2=A0 uint32_t packets;=C2=A0 /* Packet count threshold */<br=
>
&gt; +=C2=A0 =C2=A0 uint32_t pkt_cnt;=C2=A0 /* Current packet count since l=
ast notification */<br>
&gt; +=C2=A0 =C2=A0 QEMUTimer *timer;=C2=A0 /* Coalescing timer */<br>
&gt; +} VirtIONetCoal;<br>
&gt; +<br>
&gt;=C2=A0 typedef struct VirtIONetQueue {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtQueue *rx_vq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtQueue *tx_vq;<br>
&gt; @@ -165,6 +173,8 @@ typedef struct VirtIONetQueue {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VirtQueueElement *elem;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } async_tx;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct VirtIONet *n;<br>
&gt; +=C2=A0 =C2=A0 VirtIONetCoal rx_coal;<br>
&gt; +=C2=A0 =C2=A0 VirtIONetCoal tx_coal;<br>
&gt;=C2=A0 } VirtIONetQueue;<br>
&gt;<br>
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

--00000000000033a24e065e320050--


