Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77A5EDEC1D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxgNL-0001r8-CE; Wed, 04 Mar 2026 02:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgNJ-0001qe-Sl
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:10:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgNH-00017p-M6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772608226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drdGS2Gs6IfnJMxASEiR3IZCY2Tzj5FC8u7f0jjJs8Q=;
 b=QcKmimt3v0w9eCoZvZrsAT4K4i3ateCQsDZPgHLZnd3ZQ8cU+p0UXF+4JwFZMSU1/kO8/2
 cPjDT/c0o/lY7/FF34QOldJu0+ew/J7vz3gsxQpdx8zzqwIUzu8tScvQ3NJaxYxb8bHe+U
 owW/MwH1uxqVXkW8fO+NBLa0j/bAzq0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-nTw97DkTPd2cpF9KvU1Qlw-1; Wed, 04 Mar 2026 02:10:25 -0500
X-MC-Unique: nTw97DkTPd2cpF9KvU1Qlw-1
X-Mimecast-MFC-AGG-ID: nTw97DkTPd2cpF9KvU1Qlw_1772608224
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-359887aece0so3553385a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 23:10:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772608224; cv=none;
 d=google.com; s=arc-20240605;
 b=Kfsn08vmmibRcZ5np71TGjr2wFQQB0Ef8Oe/4WYmbaQMayhkNatIdPFcfhnbv20YKv
 aJMXn3QaOOPdVwVLQUIDY8TQZKJrBaYqlV2VvkRdvss5z2H3vvCPclaBccumiJfvlz3k
 57sgCmqhxy/XH90wdzhjsJpOLZXru2lf/PGlGmUFVDsOg8wz+tXliKrLCXKGjZcbGmTw
 JhRx9KqmeDCMTARGFW8Y3WFjRvtKR3VuiHwWe7qPSIKJVHIOv0U0s0+MK+i5cGUnHFOt
 d9Qk80h0sbnFP7HQFVLsFFvZn1z/rGBBHoCm5SpIAyXc+yuwk6pbBYS+pQ/tT7kmTtzz
 jPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=drdGS2Gs6IfnJMxASEiR3IZCY2Tzj5FC8u7f0jjJs8Q=;
 fh=oGrUa+3+zZJlwX9g6i0Sv0qHBgVtqlDxZdsNKzb+sks=;
 b=RXatFC9qGyGVxF1mMkL10vRv/E3STlVuR/VeM2GxTo/Z9PdKbGwnJp7qjy1081t5/+
 51vDSJvFyQTroPKv4PczZXX/6a8ojP7l9UH1BsQu9rnaijaOafHUXKY6g3b+UKlVoPlq
 eonJkGCftdJZ22mM3mskEa+qlt+I0A5OJcHW5SHy6YKA67kSDGCP/s7nhktneRakU5re
 +x20TS8vRjSSRRs6v1AK0+Tr4KqeimcJ3RQsxVLQgw2xfzMl+h4UWSQbLkz/eMpOhG/N
 iYxw7FTfYySxfvqkYtaD/cqgPO433rC0K09eRfl/8fXxNmjdJ4dBFCFBb7KlV1APcFuF
 27ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772608224; x=1773213024; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drdGS2Gs6IfnJMxASEiR3IZCY2Tzj5FC8u7f0jjJs8Q=;
 b=CfmTyeoh5/C7YqqRCkURG54CewbLQhH0ho1IUdB9XddEb4C19ZFrTHs+2s/bRr5o0S
 klIapg8c7rfZl+0dOCSo0JzlVO+G3ZAPrAgfKN2/mponNaq68IiFL2dVW4Hsr2P+kvqx
 PK7e+jA8WF/5bM/CgQxvLB12nRnFOUhrmUrv6uX84bM7gcyac0HVICHBMYaQjLc9Fr2z
 B8uUoAvHkl+45xAsWLDQEFfQpBkGKH9xfevefDI/Ndyhjd4XPIuGL+CVmR60oxG+dGgL
 fLVpsPw02tK7QYwi2Ft2ENTeGlVhx2SbG78lHnWNThQGO5VWgS7e5WLlXHU5WdKBVfiO
 Q5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772608224; x=1773213024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=drdGS2Gs6IfnJMxASEiR3IZCY2Tzj5FC8u7f0jjJs8Q=;
 b=czSYCmeQve5iey6nLT2hPMUhfsUrkM0U+W+XsSCuM2A41Zd0f5km9UqI8RJ0baSt+M
 HqPHbTypeV3DGLTrqn4EGhFWvFGSjbWxfKeICnPzmsV9frwOH7v8WzoQFODphWUhvspV
 OcSpxBweU5RCNdzYViXA7BpAzN2PF/LXXbe7fRzz+Qh10wCuUHaBU30/ILnCJzNRCoQN
 hG3XkKNZTy/mGBJVo833gmRwzPjDwwC21C8xH5VhIIIFSXJugJMzmy9TviHrUgYTPM2q
 cCL4SBoJifu4eyAnawUds8PmzHWnUrXYndYKzGHheYZaYhOn2q1dzfgA4sKqlwtFENkA
 1cxg==
X-Gm-Message-State: AOJu0Ywpm21309Zt/5F2TZPlX9dBDoNC0vAjaH1R9tS6XWVBqqh2D8pv
 WdbybxXDXCo3b4qtDR0jTCUT8Em1feaedr1WdVcZ6cK7MCAuG3sdDAgophR0F/PHwH8aEqPm7ri
 hRL7ZWbNmrXCrryQ43iFt7dbum3WDuuy2IwXrl8DyU+t2cwZDIYXv+MeIwi37Mf2/xhltUH32OL
 EpV7POx2eN9ux+7eLcIkF8TYyp0RJBhxg=
X-Gm-Gg: ATEYQzzh88aSqFsY/cUszwkhmP9IXHCqf2CU0GI2uYBLRgbn8XkVJU9a0oZVUjVAe/H
 Xvemm0mva8fc0h7572RGBlIcq6jRehBw70c6vuc2x3Kl1tupmmE998Fy78WL+F79o5ulplfcf4G
 Y5Ej50++PxTjE0nazAcHKdb6z4llwSbjvpb/wa4B9Qxzv2UaYkqmypnyATc1D3ErJbWFMfj6bh5
 rb7Wbw=
X-Received: by 2002:a17:90b:1fc5:b0:359:8c9a:fdf6 with SMTP id
 98e67ed59e1d1-359a69ae8d6mr1051423a91.6.1772608224128; 
 Tue, 03 Mar 2026 23:10:24 -0800 (PST)
X-Received: by 2002:a17:90b:1fc5:b0:359:8c9a:fdf6 with SMTP id
 98e67ed59e1d1-359a69ae8d6mr1051393a91.6.1772608223203; Tue, 03 Mar 2026
 23:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20260223203454.347800-1-kdutta@redhat.com>
In-Reply-To: <20260223203454.347800-1-kdutta@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Mar 2026 15:10:11 +0800
X-Gm-Features: AaiRm501q8wCv1VHiJVteYN11In5mRDJZfuRbUjN4QigaSqQ9LuqxXrOfniETMw
Message-ID: <CACGkMEu7XhQ147s1VBo-wALFLXvPuv8m6ORJgm_STXYX3WvZUA@mail.gmail.com>
Subject: Re: [PATCH] hw/net/virtio-net: add support for notification coalescing
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 24, 2026 at 4:35=E2=80=AFAM Koushik Dutta <kdutta@redhat.com> w=
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
>
> This reduces interrupt overhead by batching notifications based on
> either a packet count or a time-based threshold.
>
> Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> ---
>  hw/net/virtio-net.c            | 110 ++++++++++++++++++++++++++++-----
>  include/hw/virtio/virtio-net.h |   7 +++
>  2 files changed, 100 insertions(+), 17 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index eccb48ad42..e30aa198f3 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -157,6 +157,15 @@ static void flush_or_purge_queued_packets(NetClientS=
tate *nc)
>   * - we could suppress RX interrupt if we were so inclined.
>   */
>
> +static void virtio_net_rx_timer_cb(void *opaque)
> +{
> +    VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    n->rx_pkt_cnt =3D 0;
> +    virtio_notify(vdev, n->vqs[0].rx_vq);
> +}
> +
>  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
>      VirtIONet *n =3D VIRTIO_NET(vdev);
> @@ -1081,6 +1090,29 @@ static int virtio_net_handle_offloads(VirtIONet *n=
, uint8_t cmd,
>      }
>  }
>
> +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
> +                                  struct iovec *iov, unsigned int iov_cn=
t)
> +{
> +    struct virtio_net_ctrl_coal coal;
> +    size_t s;
> +
> +    s =3D iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
> +    if (s !=3D sizeof(coal)) {
> +        return VIRTIO_NET_ERR;
> +    }
> +
> +    if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
> +        n->rx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> +        n->rx_coal_packets =3D le32_to_cpu(coal.max_packets);
> +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> +        n->tx_coal_usecs =3D le32_to_cpu(coal.max_usecs);
> +        n->tx_coal_packets =3D le32_to_cpu(coal.max_packets);
> +        n->tx_timeout =3D n->tx_coal_usecs * 1000;
> +    }
> +
> +    return VIRTIO_NET_OK;
> +}
> +
>  static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
>                                   struct iovec *iov, unsigned int iov_cnt=
)
>  {
> @@ -1582,6 +1614,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vde=
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
> @@ -2041,7 +2075,18 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
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
> +        timer_del(n->rx_index_timer);
> +        virtio_net_rx_timer_cb(n);
> +    } else {
> +        if (n->rx_pkt_cnt =3D=3D i) {
> +            timer_mod(n->rx_index_timer,
> +                      qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_coal=
_usecs);
> +        }
> +    }
>
>      return size;
>
> @@ -2900,6 +2945,7 @@ static void virtio_net_tx_timer(void *opaque)
>      if (ret =3D=3D -EBUSY || ret =3D=3D -EINVAL) {
>          return;
>      }
> +    n->tx_pkt_cnt -=3D ret;
>      /*
>       * If we flush a full burst of packets, assume there are
>       * more coming and immediately rearm
> @@ -2919,6 +2965,7 @@ static void virtio_net_tx_timer(void *opaque)
>      ret =3D virtio_net_flush_tx(q);
>      if (ret > 0) {
>          virtio_queue_set_notification(q->tx_vq, 0);
> +        n->tx_pkt_cnt -=3D ret;
>          q->tx_waiting =3D 1;
>          timer_mod(q->tx_timer,
>                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout)=
;
> @@ -2974,27 +3021,45 @@ static void virtio_net_tx_bh(void *opaque)
>      }
>  }
>
> -static void virtio_net_add_queue(VirtIONet *n, int index)
> +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue =
*vq)
>  {
> -    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    VirtIONet *n =3D VIRTIO_NET(vdev);
>
> -    n->vqs[index].rx_vq =3D virtio_add_queue(vdev, n->net_conf.rx_queue_=
size,
> -                                           virtio_net_handle_rx);
> +    n->tx_pkt_cnt++;
> +    bool use_timer =3D (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer=
")) ||
> +                     (n->tx_coal_usecs > 0) || (n->tx_coal_packets > 0);
>
> -    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_timer);
> -        n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                              virtio_net_tx_timer,
> -                                              &n->vqs[index]);
> +    if (use_timer && n->tx_pkt_cnt < n->tx_coal_packets) {
> +        virtio_net_handle_tx_timer(vdev, vq);
>      } else {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_bh);
> -        n->vqs[index].tx_bh =3D qemu_bh_new_guarded(virtio_net_tx_bh, &n=
->vqs[index],
> -                                                  &DEVICE(vdev)->mem_ree=
ntrancy_guard);
> +        n->tx_pkt_cnt =3D 0;
> +        virtio_net_handle_tx_bh(vdev, vq);
>      }
> +}
> +
> +static void virtio_net_add_queue(VirtIONet *n, int index)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    n->vqs[index].rx_vq =3D
> +        virtio_add_queue(vdev,
> +                         n->net_conf.rx_queue_size,
> +                         virtio_net_handle_rx);
> +
> +    n->vqs[index].tx_vq =3D
> +        virtio_add_queue(vdev,
> +                         n->net_conf.tx_queue_size,
> +                         virtio_net_handle_tx_dispatch);
> +
> +    n->vqs[index].tx_timer =3D
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                     virtio_net_tx_timer,
> +                     &n->vqs[index]);
> +
> +    n->vqs[index].tx_bh =3D
> +        qemu_bh_new_guarded(virtio_net_tx_bh,
> +                            &n->vqs[index],
> +                            &DEVICE(vdev)->mem_reentrancy_guard);
>
>      n->vqs[index].tx_waiting =3D 0;
>      n->vqs[index].n =3D n;
> @@ -3089,6 +3154,7 @@ static void virtio_net_get_features(VirtIODevice *v=
dev, uint64_t *features,
>      virtio_features_or(features, features, n->host_features_ex);
>
>      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> +    virtio_add_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
>
>      if (!peer_has_vnet_hdr(n)) {
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> @@ -4048,6 +4114,14 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>              n->rss_data.specified_hash_types.on_bits |
>              n->rss_data.specified_hash_types.auto_bits;
>      }
> +    n->rx_pkt_cnt =3D 0;
> +    n->tx_pkt_cnt =3D 0;
> +    n->rx_coal_usecs =3D 0;
> +    n->tx_coal_usecs =3D 0;
> +    n->rx_coal_packets =3D 1;
> +    n->tx_coal_packets =3D 0;
> +    n->rx_index_timer =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> +                                     virtio_net_rx_timer_cb, n);
>  }
>
>  static void virtio_net_device_unrealize(DeviceState *dev)
> @@ -4262,6 +4336,8 @@ static const Property virtio_net_properties[] =3D {
>                        VIRTIO_NET_F_GUEST_USO6, true),
>      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                        VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
> +                      VIRTIO_NET_F_NOTF_COAL, true),

If we start as "true," we need to deal with migration compatibility,
which is known to be hard even when using machine types.

So I'd suggest starting with "false"

Thanks

>      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
>                                    rss_data.specified_hash_types,
>                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index 5b8ab7bda7..33d01d080b 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -231,6 +231,13 @@ struct VirtIONet {
>      struct EBPFRSSContext ebpf_rss;
>      uint32_t nr_ebpf_rss_fds;
>      char **ebpf_rss_fds;
> +    QEMUTimer *rx_index_timer;
> +    uint32_t rx_coal_usecs;
> +    uint32_t rx_coal_packets;
> +    uint32_t rx_pkt_cnt;
> +    uint32_t tx_coal_usecs;
> +    uint32_t tx_coal_packets;
> +    uint32_t tx_pkt_cnt;
>  };
>
>  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
> --
> 2.53.0
>


