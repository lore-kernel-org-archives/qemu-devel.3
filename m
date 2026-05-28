Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E174CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbQW-0008FA-PN; Thu, 28 May 2026 10:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wSbQU-0008Eq-UE
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wSbQR-0003xx-NS
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779977369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czO1FNtDYR1JWTCdeuaPGDchD9+lnzFtDunWuEKW3M4=;
 b=IvmRFXygrBX0x+//Fa01rMfYBzKx48/uVFFduDfBlapxyKs37WeOcF1sW6mpKTPhHjrvaI
 AAIcR3RSUkYiRig7DRGFiiqnQsKqtwSWVRbCjkw2JoCi1GtZA96TmAq7OUPJkLoyRB8zlA
 vXJrsSnESQW2M4wFf1S/bBB8uTpFfQs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-wcxZVtJnOmuykT47LAScdA-1; Thu, 28 May 2026 10:09:26 -0400
X-MC-Unique: wcxZVtJnOmuykT47LAScdA-1
X-Mimecast-MFC-AGG-ID: wcxZVtJnOmuykT47LAScdA_1779977366
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7bd6f72e5aeso213825557b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779977366; cv=none;
 d=google.com; s=arc-20240605;
 b=D+EqJOijuybDQltE7nNCNRdpQq4+LfaRRQBdGcUjIvjQxjBxJcHDLsliAI66SjAej2
 y5ysr89MyNPkat6NgxJ80QOMSsZgQe3cf5EnhRdZapPr6Brk9aJ+BEo9LtsKwJStyj/f
 9VgWKbYJFk6zPRr3bjH5cvvujVy3wfe1A9WeO9/xkSG80vaMMaeiNh40cKcIVo6uXjXI
 1zTyjD5J159GdyLBx/PatGLtoJ6wslvTbUlrwg5oIXoMpO0dKIb5vrsNl0vLGb3w9rrA
 AvcLJlumpR3cAQwYGfX+g37hkZxc2Le2XOKWhEiVj4+KJnZwluElGS7JnoLTObkJGpsE
 Haxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=czO1FNtDYR1JWTCdeuaPGDchD9+lnzFtDunWuEKW3M4=;
 fh=6/ouGYbjHnSFSJHFY+pVvzIaqAKSYTuICFj9DWSg2PA=;
 b=MHhJXmD89082hpNtZAXUXFHyJidgQ3Qqh7XvewZhXp3aVQKpMCinJGa6Th26VT8Nbc
 iNisGbYwrQdd0pnUEzevhOrCGbMT0ozrbBQ1CkrF1ALwH6w7jPw+ephF55tI7nhZgt1Q
 4Qu/bDQMhiaJpiq5F6i/nsgdYKhcvHJszYosDfpPQ3fOLOF86cpOZNu26mFDoiIG/Mb1
 YQdcglrAt4mxeHCQgRxKYE2PMxHSNvhlAgrqmNvLuRq672wr+Z0mUyx6OsgeTYYAAN6t
 YZd21uJUulKa6x764sIhg9mq34Tkc9zEqQIQo7t3pUfHoCR5bHc9ShwAOCVDsWOd85IK
 LLig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779977366; x=1780582166; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czO1FNtDYR1JWTCdeuaPGDchD9+lnzFtDunWuEKW3M4=;
 b=pUv19L2+rmCyn0ytpCUPc5IYTeVtmm6rUPRaFm8QFKlxKAGa9OZFHEjZ4aqYIlYYTn
 EtTuvJ0wi+vIf/envcZ6MZlt8Kzkw5UnWZD5HIjTENg/8MRquFHScKv6yBJYFi/jrp8N
 8vo2Tkzs8tJs2+BlpCsIBWVMCdkVpJ4GmSql9CWNJhnocj5XGKxuDMEMJI7rCVQwDY0D
 CNHhMh0QaQgvGirdhPBEJaBnflcgS2oE+FU0Xzqnyfxn/xx6CI4ZSycmNzDfg22Jnd/N
 94rRWO7f/r2YKtiVhO1ifYZVaV8XJN8heRqDM/5W0TxG5guWShiCeD0hRycwkzs7BAat
 v0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779977366; x=1780582166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=czO1FNtDYR1JWTCdeuaPGDchD9+lnzFtDunWuEKW3M4=;
 b=EvkjD6qUUP1uN2XMY+Q/94vNIfG8aQdfAHB43uAV9JqszXKtRvtS0L2LglcsCLHB9v
 /vF0iwBKB8pDEL5sOe8TcjUiNZ/jWFwKSS7qsScHA9+ZRtorYYDu6P7MKDqxeaApe6tI
 SHayTr6XWv4RmOkow4eFDoRGoEmdw//JGm9ywEm7JeyuZ1KnZD6EPOCDl5DwKRziOLq1
 8lvn+rU3CFsMOueHWWp+dngfJz+IO8mCspluO7a0QLx7YIOBLLd+CFiFxOj5vvPp5DWL
 T4XamydtZRRLQQfIBpQ062Pbt87zxaZcyo3rkZw0rO3QZdN5rpEu216URHSvJNvph/gE
 oxvw==
X-Gm-Message-State: AOJu0Yyw4sLxYAyweKCXZTl5pRH4/UyR/V8ExqJSGZAyFH+TczDsBeSE
 IljN5eQQddHurMgEm0cC+kiWdO4Oss1+NAWF7WH9fXsTfpNn9PcKJNCbLd/si8oEcDT7hpMhb6s
 LRqhMuZMVrfcEd+InYoIVM25k9JuPm5l0HSBdSRji35NRquDdnIFTMfeGgHjscrDA1Q4RrgLRFS
 ZhYY/BhlMk81or3LdYaFGobu3tZQt1ufM=
X-Gm-Gg: Acq92OFWyruUdF4bBXNDlil2YW5TmdICIAKl+aiYEKgKFGv0DcSuS/V0EewKBWw6cMN
 5dTaCVbto81fJZHiRQCeG0+zvjf/b+OQ2whNpyPqmJCVb2i5P1WtlxQ1SmyONtEgQ6woNgbnNCm
 wpZKQacaTFFzYRlY400u/TVlqLMIbN2rdNG6LiLXfcs0+qo1p3MDsn+mHeBMVxk9Ewz0OCZY13V
 AR3Zd2+3OCuD1RPvg==
X-Received: by 2002:a05:690c:c222:b0:7dd:3f36:59e3 with SMTP id
 00721157ae682-7dd3f365d6emr10121827b3.36.1779977365909; 
 Thu, 28 May 2026 07:09:25 -0700 (PDT)
X-Received: by 2002:a05:690c:c222:b0:7dd:3f36:59e3 with SMTP id
 00721157ae682-7dd3f365d6emr10121077b3.36.1779977365286; Thu, 28 May 2026
 07:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260515181620.1774378-1-kdutta@redhat.com>
In-Reply-To: <20260515181620.1774378-1-kdutta@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 28 May 2026 16:08:47 +0200
X-Gm-Features: AVHnY4LxoXz2Y9ihwy-y5gfXuUbacHoISfgT0mfpq1scgw9g3wWz7oMN7JKUlns
Message-ID: <CAJaqyWeEqmQVZsOEMi+r7AEpRVDVpSRe-59gJgCzKqQ3rHPsZA@mail.gmail.com>
Subject: Re: [PATCH v7] hw/net/virtio-net: add support for notification
 coalescing
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 15, 2026 at 8:16=E2=80=AFPM Koushik Dutta <kdutta@redhat.com> w=
rote:
>
> Implement VirtIO Network Notification Coalescing (Bit 53).
> This allows the guest to manage interrupt frequency using ethtool
> -C for both RX and TX paths.
>
> - Added VIRTIO_NET_F_NOTF_COAL to host features.
> - Implemented VIRTIO_NET_CTRL_NOTF_COAL class handling in
>   virtio_net_handle_ctrl_iov.
> - Added logic to store and apply rx/tx usecs and max_packets.
> - Added packet counters and threshold logic for both RX and TX data paths=
.
> - Dynamic Dispatcher: Implemented a dispatcher mechanism that
>   dynamically switches/activates the notification callback logic
>   only after the guest enables TX coalescing via ethtool.
> - After VM LM coalescing parameters persist in the destination VM.
>
> This reduces interrupt overhead by batching notifications based on
> either a packet count or a time-based threshold.
>
> Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> ---
> v7 changes:
>  - Fixed time unit consistency: TX path now uses microseconds matching RX
>  - Changed timer_new_ns to timer_new_us for TX timers
>  - Changed qemu_clock_get_ns to qemu_clock_get_us in TX path
>  - Convert txtimer from nanoseconds to microseconds (txtimer / 1000)
>  - Removed unused rx_index_timer variable from struct and initialization
>  - Fixed feature flag handling: removed conditional check in ctrl handler
> ---
>  hw/net/virtio-net.c            | 193 +++++++++++++++++++++++++++++----
>  include/hw/virtio/virtio-net.h |   9 +-
>  net/passt.c                    |   1 +
>  net/tap.c                      |   1 +
>  net/vhost-user.c               |   1 +
>  net/vhost-vdpa.c               |   1 +
>  6 files changed, 183 insertions(+), 23 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2a5d642a64..5a98b52ded 100644
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
> @@ -435,7 +445,7 @@ static int virtio_net_set_status(struct VirtIODevice =
*vdev, uint8_t status)
>          if (queue_started) {
>              if (q->tx_timer) {
>                  timer_mod(q->tx_timer,
> -                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n=
->tx_timeout);
> +                               qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n=
->tx_coal_usecs);
>              } else {
>                  replay_bh_schedule_event(q->tx_bh);
>              }
> @@ -1080,6 +1090,52 @@ static int virtio_net_handle_offloads(VirtIONet *n=
, uint8_t cmd,
>      }
>  }
>
> +static void virtio_net_tx_timer(void *opaque);
> +
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
> +        if (n->rx_coal_usecs > 0) {
> +            for (i =3D 0; i < n->max_queue_pairs; i++) {
> +                q =3D &n->vqs[i];
> +                if (!q->rx_timer) {
> +                    q->rx_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                               virtio_net_rx_notify,
> +                                               q);
> +                }
> +            }
> +        }

Should we remove the timer if n->rx_coal_usecs =3D=3D 0? Same for tx.

> +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> +        if (n->tx_coal_usecs > 0) {
> +            for (i =3D 0; i < n->max_queue_pairs; i++) {
> +                q =3D &n->vqs[i];
> +                if (!q->tx_timer && n->tx_coal_usecs > 0) {
> +                    q->tx_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                               virtio_net_tx_timer,
> +                                               q);
> +                }
> +            }
> +        }
> +    }
> +
> +    return VIRTIO_NET_OK;
> +}
> +
>  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
>                                   struct iovec *iov, unsigned int iov_cnt=
)
>  {
> @@ -1581,6 +1637,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vde=
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
> @@ -2040,7 +2098,22 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
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
> +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_=
coal_usecs);
> +            }
> +        }
> +    }
>
>      return size;
>
> @@ -2708,7 +2781,7 @@ static void virtio_net_tx_complete(NetClientState *=
nc, ssize_t len)
>              replay_bh_schedule_event(q->tx_bh);
>          } else {
>              timer_mod(q->tx_timer,
> -                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_time=
out);
> +                      qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->tx_coal=
_usecs);
>          }
>          q->tx_waiting =3D 1;
>      }
> @@ -2817,7 +2890,6 @@ detach:
>      return -EINVAL;
>  }
>
> -static void virtio_net_tx_timer(void *opaque);
>
>  static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq=
)
>  {
> @@ -2842,7 +2914,7 @@ static void virtio_net_handle_tx_timer(VirtIODevice=
 *vdev, VirtQueue *vq)
>      } else {
>          /* re-arm timer to flush it (and more) on next tick */
>          timer_mod(q->tx_timer,
> -                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> +                  qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->tx_coal_use=
cs);
>          q->tx_waiting =3D 1;
>          virtio_queue_set_notification(vq, 0);
>      }
> @@ -2899,6 +2971,12 @@ static void virtio_net_tx_timer(void *opaque)
>      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
>          return;
>      }
> +    if (n->tx_pkt_cnt < ret) {
> +        n->tx_pkt_cnt =3D 0;
> +    } else {
> +        n->tx_pkt_cnt -=3D ret;
> +    }
> +
>      /*
>       * If we flush a full burst of packets, assume there are
>       * more coming and immediately rearm
> @@ -2906,7 +2984,7 @@ static void virtio_net_tx_timer(void *opaque)
>      if (ret >=3D n->tx_burst) {
>          q->tx_waiting =3D 1;
>          timer_mod(q->tx_timer,
> -                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> +                  qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->tx_coal_use=
cs);
>          return;
>      }
>      /*
> @@ -2918,9 +2996,10 @@ static void virtio_net_tx_timer(void *opaque)
>      ret =3D virtio_net_flush_tx(q);
>      if (ret > 0) {
>          virtio_queue_set_notification(q->tx_vq, 0);
> +        n->tx_pkt_cnt -=3D ret;
>          q->tx_waiting =3D 1;
>          timer_mod(q->tx_timer,
> -                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> +                  qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->tx_coal_use=
cs);
>      }
>  }
>
> @@ -2973,6 +3052,32 @@ static void virtio_net_tx_bh(void *opaque)
>      }
>  }
>
> +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue =
*vq)
> +{
> +    VirtIONet *n =3D VIRTIO_NET(vdev);
> +    VirtIONetQueue *q =3D &n->vqs[vq2q(virtio_get_queue_index(vq))];
> +    bool use_timer =3D n->tx_timer_activate || n->tx_coal_usecs > 0 ||
> +                     n->tx_coal_packets > 0;

This is from V2, but why use_timer is true as long as tx_coal_packets
> 0? It should be renamed or handled independently.

I'd expect something like:

if (coal_pkts_reached) {
  clear timer if needed()
  notify()
} else if(timer is enabled) {
  do nothing, wait for the timer
}

> +    bool pkt_limit =3D (n->tx_coal_packets > 0);
> +
> +    if (use_timer) {
> +        n->tx_pkt_cnt++;
> +        if (!pkt_limit || n->tx_pkt_cnt < n->tx_coal_packets) {
> +            if (q->tx_timer) {
> +                virtio_net_handle_tx_timer(vdev, vq);
> +                return;
> +            }
> +        }
> +        n->tx_pkt_cnt =3D 0;
> +        if (q->tx_timer) {
> +            timer_del(q->tx_timer);
> +        }
> +        virtio_net_handle_tx_bh(vdev, vq);
> +    } else {
> +        virtio_net_handle_tx_bh(vdev, vq);
> +    }
> +}
> +
>  static void virtio_net_add_queue(VirtIONet *n, int index)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> @@ -2980,20 +3085,15 @@ static void virtio_net_add_queue(VirtIONet *n, in=
t index)
>      n->vqs[index].rx_vq =3D virtio_add_queue(vdev, n->net_conf.rx_queue_=
size,
>                                             virtio_net_handle_rx);
>
> -    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_timer);
> -        n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                              virtio_net_tx_timer,
> -                                              &n->vqs[index]);
> -    } else {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_bh);
> -        n->vqs[index].tx_bh =3D qemu_bh_new_guarded(virtio_net_tx_bh, &n=
->vqs[index],
> -                                                  &DEVICE(vdev)->mem_ree=
ntrancy_guard);
> -    }
> +    n->vqs[index].tx_vq =3D
> +        virtio_add_queue(vdev,
> +                         n->net_conf.tx_queue_size,
> +                         virtio_net_handle_tx_dispatch);
> +
> +    n->vqs[index].tx_bh =3D
> +        qemu_bh_new_guarded(virtio_net_tx_bh,
> +                            &n->vqs[index],
> +                            &DEVICE(vdev)->mem_reentrancy_guard);
>
>      n->vqs[index].tx_waiting =3D 0;
>      n->vqs[index].n =3D n;
> @@ -3088,6 +3188,9 @@ static void virtio_net_get_features(VirtIODevice *v=
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
> @@ -3242,6 +3345,35 @@ static int virtio_net_post_load_device(void *opaqu=
e, int version_id)
>      }
>
>      virtio_net_commit_rss_config(n);
> +    if (n->tx_coal_usecs > 0 || n->rx_coal_usecs > 0) {
> +
> +        for (i =3D 0; i < n->max_queue_pairs; i++) {
> +            VirtIONetQueue *q =3D &n->vqs[i];
> +            if (!q->rx_timer && n->rx_coal_usecs > 0) {
> +                q->rx_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                           virtio_net_rx_notify,
> +                                           q);
> +            }
> +
> +            if (!q->tx_timer && n->tx_coal_usecs > 0) {
> +                q->tx_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                           virtio_net_tx_timer,
> +                                           q);
> +            }
> +
> +            if (n->tx_coal_usecs > 0 && q->tx_timer) {
> +                n->tx_pkt_cnt =3D 0;
> +                timer_mod(q->tx_timer,
> +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->tx_=
coal_usecs);

Why not do these two steps in the previous if (!q->rx_timer &&
n->rx_coal_usecs > 0) block?

But also, what is the reason to call timer_mod here? The guest will
kick QEMU at the first tx packet, isn't it? Same in rx path.

> +            }
> +
> +            if (n->rx_coal_usecs > 0 && q->rx_timer) {
> +                timer_mod(q->rx_timer,
> +                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_=
coal_usecs);
> +            }
> +        }
> +    }
> +
>      return 0;
>  }
>
> @@ -3617,6 +3749,10 @@ static const VMStateDescription vmstate_virtio_net=
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
> @@ -3960,7 +4096,6 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>      }
>      n->vqs =3D g_new0(VirtIONetQueue, n->max_queue_pairs);
>      n->curr_queue_pairs =3D 1;
> -    n->tx_timeout =3D n->net_conf.txtimer;
>
>      if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")
>                         && strcmp(n->net_conf.tx, "bh")) {
> @@ -3970,6 +4105,13 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>          error_printf("Defaulting to \"bh\"");
>      }
>
> +    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") =3D=3D 0) {
> +        n->tx_coal_usecs =3D n->net_conf.txtimer / 1000;
> +        n->tx_timer_activate =3D true;
> +    } else {
> +        n->tx_coal_usecs =3D 0;
> +    }
> +
>      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
>                                      n->net_conf.tx_queue_size);
>
> @@ -4046,6 +4188,11 @@ static void virtio_net_device_realize(DeviceState =
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
> @@ -4258,6 +4405,8 @@ static const Property virtio_net_properties[] =3D {
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
> index 371e376428..b3a7df5ad8 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -158,6 +158,7 @@ typedef struct VirtioNetRssData {
>  typedef struct VirtIONetQueue {
>      VirtQueue *rx_vq;
>      VirtQueue *tx_vq;
> +    QEMUTimer *rx_timer;
>      QEMUTimer *tx_timer;
>      QEMUBH *tx_bh;
>      uint32_t tx_waiting;
> @@ -177,7 +178,6 @@ struct VirtIONet {
>      /* RSC Chains - temporary storage of coalesced data,
>         all these data are lost in case of migration */
>      QTAILQ_HEAD(, VirtioNetRscChain) rsc_chains;
> -    uint32_t tx_timeout;
>      int32_t tx_burst;
>      uint32_t has_vnet_hdr;
>      size_t host_hdr_len;
> @@ -230,6 +230,13 @@ struct VirtIONet {
>      struct EBPFRSSContext ebpf_rss;
>      uint32_t nr_ebpf_rss_fds;
>      char **ebpf_rss_fds;
> +    uint32_t rx_coal_usecs;
> +    uint32_t rx_coal_packets;
> +    uint32_t rx_pkt_cnt;
> +    uint32_t tx_coal_usecs;
> +    uint32_t tx_coal_packets;
> +    uint32_t tx_pkt_cnt;
> +    bool tx_timer_activate;
>  };
>
>  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
> diff --git a/net/passt.c b/net/passt.c
> index 4ff94ee509..0b0d9e222a 100644
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
> index 8d7ab6ba6f..ea5987a3dc 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -62,6 +62,7 @@ static const int kernel_feature_bits[] =3D {
>      VIRTIO_F_NOTIFICATION_DATA,
>      VIRTIO_NET_F_RSC_EXT,
>      VIRTIO_NET_F_HASH_REPORT,
> +    VIRTIO_NET_F_NOTF_COAL,
>      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
>      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
>      VHOST_INVALID_FEATURE_BIT
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index a4bb49bbcf..f0b3752d7c 100644
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
> index 3df6091274..4ab8f26ceb 100644
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


