Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1B7C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Za3-00083v-VT; Thu, 10 Sep 2026 03:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4Za1-00083J-Os
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 03:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4ZZz-0000MA-Db
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 03:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789026737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5O6/V284zdhFV6//l+Sd3JXaF6Uxzfh7nqtv/gOEVzQ=;
 b=DEDR+a8JE9RKZ5G5bTaWzQRaB78vvsWt2nHeexep/JDN6GomHSP7nCFj8h9bNhBiWFyfF/
 bg3qOoIh1oRG6NnTPBsEJckAB2U8lCpJHCzmo8JFYKgcjEWpCtp8dHZ9dxV/sLKgIxqlAm
 eNb0Jd663gu3tvMeVSBitHx1cAaUKJo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-rhfOr05ZOwWu3L4i3YuK6Q-1; Thu, 10 Sep 2026 03:52:15 -0400
X-MC-Unique: rhfOr05ZOwWu3L4i3YuK6Q-1
X-Mimecast-MFC-AGG-ID: rhfOr05ZOwWu3L4i3YuK6Q_1789026735
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a987d64482so2164140a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789026734; x=1789631534; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5O6/V284zdhFV6//l+Sd3JXaF6Uxzfh7nqtv/gOEVzQ=;
 b=ja7TpGDGLvcKJ+HunZotIt9fFmxdDEOMb1eh11rDtTNNE1Be4JFtYhaA5qfO8GEK8P
 JG8CawaNAxofp6tJo2MqBZPcu3oJPmQIuXHOaklptWfkE08Yz4dMjqInTEZW4emuG/xv
 5MURo22yRxFA8tVtY3d+jfUA19B1h39qGqXYVuCnlM/CzKa7+bed+iuw3O0kd2RKRKFg
 LjsGe7gqiddE4BUyt52El2pCpqNmOA/a4ceSpmIukBDWK6HOO+//xNVmq4TtmT0ux7cW
 hbBniyYtgaoFtKbmi7An+BNJMBSuFMFL1lgxj6oGZCWpIRlvYBsroBb5bkfLE/j1d+1Y
 RAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789026734; x=1789631534;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5O6/V284zdhFV6//l+Sd3JXaF6Uxzfh7nqtv/gOEVzQ=;
 b=YBvE96jLHH2AXY9LQ9ss6kutPiIFTtuumH1ApdjQ3lWOIgYfayluFluIT93V2vg073
 AtkjqAWs5FYQWjSUWwqbntEtWZ5f/3v+CcBHlYX/ezcd96DbzoSXBCN23walqraJMEU8
 rBXXhCILK2kFjqWGqyjoWYTAt2t2sCN+qFB9UYi2N4wxac/0LsYlygmnUMNbRw/G/czu
 x36378r/zY25woSZwhsJ40UpsP1y206Z1rTTRIkngsYFsPEfz3v25hh9g9LCFWIcODKY
 X0IfhAkkF3N8MPcNpPOWjl6YxwI8aBRTpa49pEYnVpxxdaijFeyJmH5GiJHbRFjfHbzf
 Iv1w==
X-Gm-Message-State: AFuF++m0lzggF0HtdUeM3ZMp9pwqTtgiLe93FHM58u5D3fCavcCktE5E
 /u50kGWwLdVm+XtNJ4YhG1uDx9mYLywP+KUCC+QGZfr/wEc/9dBQi02IYJozwvPVm93BAKLdkax
 P1x+zgnCU+wUAKAVEiTKZeJJC4J32XQvmPr0Gxo7CvNnWxafU74fIXGMD
X-Gm-Gg: AYBFou1AgbTBvrmEDqbdU2W7heJuhtkfJdw41nT6hmAOmB1tvnfidygbjJOlkWrh1Kl
 1X2AjKm8KLjRmkgBU0NEZz71eggOJ98/tDB6KS0qaVG4TgbXVtv5cdmdGShhVAKDlwUzGwiH3Qp
 p70cGJw8ZmnE5aRVvggfE7HEWRPbxUm7tkiJ9qw/T1gAjvkGsYWQil9B7d1+StKdpC4FxNt73yz
 2HFyzsTxImvI1Jqk55EvDJYHxUfaOuqPr8rBx3XnC8Z0bXsJIo7PiwNL+EPxXyJGHMoAX6G92NA
 Ke8ZdLUXwPKbbBMn74ZkEraBmDvKYXVs/u9owkk5+QUV2+U7E95BLF7cx+YV6iaPUDPHfxrN6yp
 CGiygUxKJOycJYgoWYwFr63I=
X-Received: by 2002:a05:6402:24d5:b0:6a7:ee54:f896 with SMTP id
 4fb4d7f45d1cf-6a7ee550033mr10684746a12.26.1789026734451; 
 Thu, 10 Sep 2026 00:52:14 -0700 (PDT)
X-Received: by 2002:a05:6402:24d5:b0:6a7:ee54:f896 with SMTP id
 4fb4d7f45d1cf-6a7ee550033mr10684726a12.26.1789026733787; 
 Thu, 10 Sep 2026 00:52:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9882a8510sm2255625a12.21.2026.09.10.00.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 00:52:13 -0700 (PDT)
Date: Thu, 10 Sep 2026 03:52:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v10 2/2] [PATCH 2/2] Implement VirtIO Network
 Notification Coalescing (VIRTIO_NET_F_NOTF_COAL). This allows guests to
 reduce interrupt overhead by configuring coalescing parameters via ethtool
 -C for both RX and TX paths.
Message-ID: <20260910034751-mutt-send-email-mst@kernel.org>
References: <20260716134421.3765533-1-kdutta@redhat.com>
 <20260716134421.3765533-3-kdutta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716134421.3765533-3-kdutta@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

subject is unreasonably long here


On Thu, Jul 16, 2026 at 07:14:21PM +0530, Koushik Dutta wrote:
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
> Note: When tx=timer is configured at VM launch, the coalescing feature
> is automatically disabled because tx=timer already introduces a fixed
> 150µs delay for packet batching, making notification coalescing redundant.
> 
> Adds the `x-vq_notf_coal=on` device parameter to dynamically enable
> virtqueue notification coalescing at VM startup.


we really do not want to train users to use x- properties.

> Performance metrics (Moderate Coalescing vs Without Coalescing):
> - RX parameters: 1000µs, 10 frames
> - TX parameters: 2000µs, 20 frames
> - Results: 20% drop in CPU overhead and a 30% reduction in interrupts.
> 
> Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> ---
>  hw/net/virtio-net.c            | 203 ++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-net.h |  10 ++
>  net/passt.c                    |   1 +
>  net/tap.c                      |   1 +
>  net/vhost-user.c               |   1 +
>  net/vhost-vdpa.c               |   1 +
>  6 files changed, 213 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index e7f05956a5..fac1013d47 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -157,6 +157,16 @@ static void flush_or_purge_queued_packets(NetClientState *nc)
>   * - we could suppress RX interrupt if we were so inclined.
>   */
>  
> +static void virtio_net_rx_notify(void *opaque)
> +{
> +    VirtIONetQueue *q = opaque;
> +    VirtIONet *n = q->n;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
> +
> +    q->rx_coal.pkt_cnt = 0;
> +    virtio_notify(vdev, q->rx_vq);
> +}
> +
>  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
>      VirtIONet *n = VIRTIO_NET(vdev);
> @@ -1002,6 +1012,87 @@ static void virtio_net_set_features(VirtIODevice *vdev,
>      }
>  }
>  
> +static void virtio_net_tx_notification_timer(void *opaque)
> +{
> +    VirtIONetQueue *q = opaque;
> +    VirtIONet *n = q->n;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
> +
> +    q->tx_coal.pkt_cnt = 0;
> +    virtio_notify(vdev, q->tx_vq);
> +}
> +
> +static bool virtio_net_tx_should_notify(VirtIONetQueue *q)
> +{
> +    if (q->tx_coal.usecs == 0 || !q->tx_coal.timer) {
> +        return true;
> +    }
> +
> +    q->tx_coal.pkt_cnt++;
> +
> +    if (q->tx_coal.packets > 0 && q->tx_coal.pkt_cnt >= q->tx_coal.packets) {
> +        q->tx_coal.pkt_cnt = 0;
> +        timer_del(q->tx_coal.timer);
> +        return true;
> +    }
> +
> +    if (!timer_pending(q->tx_coal.timer)) {
> +        timer_mod(q->tx_coal.timer,
> +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                  q->tx_coal.usecs * 1000); /* Converted to ns */
> +    }
> +
> +    return false;
> +}
> +
> +static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
> +                                  struct iovec *iov, unsigned int iov_cnt)
> +{
> +    struct virtio_net_ctrl_coal coal;
> +    VirtIONetQueue *q;
> +    size_t s;
> +    int i;
> +
> +    s = iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
> +    if (s != sizeof(coal)) {
> +        return VIRTIO_NET_ERR;
> +    }
> +
> +    if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
> +        for (i = 0; i < n->max_queue_pairs; i++) {
> +            q = &n->vqs[i];
> +            q->rx_coal.usecs = le32_to_cpu(coal.max_usecs);
> +            q->rx_coal.packets = le32_to_cpu(coal.max_packets);
> +            q->rx_coal.pkt_cnt = 0;
> +            if (q->rx_coal.usecs > 0) {
> +                /* Delete old timer if exists, then create new one */
> +                g_clear_pointer(&q->rx_coal.timer, timer_free);
> +                q->rx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                                virtio_net_rx_notify,
> +                                                q);
> +            } else {
> +                g_clear_pointer(&q->rx_coal.timer, timer_free);
> +            }
> +        }
> +    } else if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
> +        for (i = 0; i < n->max_queue_pairs; i++) {
> +            q = &n->vqs[i];
> +            q->tx_coal.usecs = le32_to_cpu(coal.max_usecs);
> +            q->tx_coal.packets = le32_to_cpu(coal.max_packets);
> +            q->tx_coal.pkt_cnt = 0;
> +            if (q->tx_coal.usecs > 0) {
> +                g_clear_pointer(&q->tx_coal.timer, timer_free);
> +                q->tx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                                virtio_net_tx_notification_timer,
> +                                                q);
> +            } else {
> +                g_clear_pointer(&q->tx_coal.timer, timer_free);
> +            }
> +        }
> +    }
> +    return VIRTIO_NET_OK;
> +}
> +
>  static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
>                                       struct iovec *iov, unsigned int iov_cnt)
>  {
> @@ -1581,6 +1672,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
>          status = virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
>      } else if (ctrl.class == VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
>          status = virtio_net_handle_offloads(n, ctrl.cmd, iov, out_num);
> +    } else if (ctrl.class == VIRTIO_NET_CTRL_NOTF_COAL) {
> +        status = virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
>      }
>  
>      s = iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
> @@ -2040,7 +2133,23 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>      }
>  
>      virtqueue_flush(q->rx_vq, i);
> -    virtio_notify(vdev, q->rx_vq);
> +
> +    /* rx coalescing */
> +    q->rx_coal.pkt_cnt += i;
> +    if (q->rx_coal.usecs == 0 || q->rx_coal.pkt_cnt >= q->rx_coal.packets) {
> +        if (q->rx_coal.timer) {
> +            timer_del(q->rx_coal.timer);
> +        }
> +        virtio_net_rx_notify(q);
> +    } else {
> +        if (q->rx_coal.timer) {
> +            if (!timer_pending(q->rx_coal.timer)) {
> +                timer_mod(q->rx_coal.timer,
> +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                          q->rx_coal.usecs * 1000); /* Converted to ns */
> +            }
> +        }
> +    }
>  
>      return size;
>  
> @@ -2690,7 +2799,9 @@ static void virtio_net_tx_complete(NetClientState *nc, ssize_t len)
>      int ret;
>  
>      virtqueue_push(q->tx_vq, q->async_tx.elem, 0);
> -    virtio_notify(vdev, q->tx_vq);
> +    if (virtio_net_tx_should_notify(q)) {
> +        virtio_notify(vdev, q->tx_vq);
> +    }
>  
>      g_free(q->async_tx.elem);
>      q->async_tx.elem = NULL;
> @@ -2802,7 +2913,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>  
>  drop:
>          virtqueue_push(q->tx_vq, elem, 0);
> -        virtio_notify(vdev, q->tx_vq);
> +        if (virtio_net_tx_should_notify(q)) {
> +            virtio_notify(vdev, q->tx_vq);
> +        }
> +
>          g_free(elem);
>  
>          if (++num_packets >= n->tx_burst) {
> @@ -2899,6 +3013,7 @@ static void virtio_net_tx_timer(void *opaque)
>      if (ret == -EBUSY || ret == -EINVAL) {
>          return;
>      }
> +
>      /*
>       * If we flush a full burst of packets, assume there are
>       * more coming and immediately rearm
> @@ -3005,6 +3120,12 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
>                              &DEVICE(vdev)->mem_reentrancy_guard);
>  
>      n->vqs[index].tx_waiting = 0;
> +    n->vqs[index].rx_coal.pkt_cnt = 0;
> +    n->vqs[index].tx_coal.pkt_cnt = 0;
> +    n->vqs[index].rx_coal.usecs = 0;
> +    n->vqs[index].tx_coal.usecs = 0;
> +    n->vqs[index].rx_coal.packets = 0;
> +    n->vqs[index].tx_coal.packets = 0;
>      n->vqs[index].n = n;
>  }
>  
> @@ -3017,6 +3138,11 @@ static void virtio_net_del_queue(VirtIONet *n, int index)
>      qemu_purge_queued_packets(nc);
>  
>      virtio_del_queue(vdev, index * 2);
> +
> +    /* Cleanup coalescing timers */
> +    g_clear_pointer(&q->rx_coal.timer, timer_free);
> +    g_clear_pointer(&q->tx_coal.timer, timer_free);
> +
>      if (q->tx_timer) {
>          timer_free(q->tx_timer);
>          q->tx_timer = NULL;
> @@ -3097,6 +3223,13 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>      virtio_features_or(features, features, n->host_features_ex);
>  
>      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> +    if (n->tx_timer_activate) {
> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
> +    } else {
> +        if (!virtio_has_feature(*features, VIRTIO_NET_F_NOTF_COAL)) {
> +            *features &= ~(1ULL << VIRTIO_NET_F_NOTF_COAL);
> +        }
> +    }
>  
>      if (!peer_has_vnet_hdr(n)) {
>          virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> @@ -3251,6 +3384,26 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
>      }
>  
>      virtio_net_commit_rss_config(n);
> +
> +    for (i = 0; i < n->max_queue_pairs; i++) {
> +        VirtIONetQueue *q = &n->vqs[i];
> +        if (q->rx_coal.usecs > 0) {
> +            if (!q->rx_coal.timer) {
> +                q->rx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                                virtio_net_rx_notify,
> +                                                q);
> +            }
> +        }
> +
> +        if (q->tx_coal.usecs > 0) {
> +            if (!q->tx_coal.timer) {
> +                q->tx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                                virtio_net_tx_notification_timer,
> +                                                q);
> +            }
> +        }
> +    }
> +


Not QEMU_CLOCK_VIRTUAL_RT?

>      return 0;
>  }
>  
> @@ -3270,13 +3423,49 @@ static int virtio_net_post_load_virtio(VirtIODevice *vdev)
>      return 0;
>  }
>  
> +static const VMStateDescription vmstate_virtio_net_coal = {
> +    .name = "virtio-net-coal",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(usecs, VirtIONetCoal),
> +        VMSTATE_UINT32(packets, VirtIONetCoal),
> +        VMSTATE_UINT32(pkt_cnt, VirtIONetCoal),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static bool virtio_net_queue_notf_coal_needed(void *opaque)
> +{
> +    VirtIONetQueue *q = opaque;
> +    return q->rx_coal.usecs > 0 || q->tx_coal.usecs > 0;
> +}
> +
> +static const VMStateDescription vmstate_virtio_net_queue_notf_coal = {
> +    .name = "virtio-net-queue-tx_waiting/notf-coal",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = virtio_net_queue_notf_coal_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT(rx_coal, VirtIONetQueue, 0,
> +                       vmstate_virtio_net_coal, VirtIONetCoal),
> +        VMSTATE_STRUCT(tx_coal, VirtIONetQueue, 0,
> +                       vmstate_virtio_net_coal, VirtIONetCoal),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  /* tx_waiting field of a VirtIONetQueue */
>  static const VMStateDescription vmstate_virtio_net_queue_tx_waiting = {
>      .name = "virtio-net-queue-tx_waiting",
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(tx_waiting, VirtIONetQueue),
>          VMSTATE_END_OF_LIST()
> -   },
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_virtio_net_queue_notf_coal,
> +        NULL
> +    }
>  };
>  
>  static bool max_queue_pairs_gt_1(void *opaque, int version_id)
> @@ -3981,6 +4170,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  
>      if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") == 0) {
>          n->tx_timer_activate = true;
> +        if (n->host_features & (1ULL << VIRTIO_NET_F_NOTF_COAL)) {
> +            warn_report("virtio-net: 'vq_notf_coal' is incompatible with 'tx=timer',"
> +                        "disabling notification coalescing");
> +        }
>      }
>  
>      n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
> @@ -4271,6 +4464,8 @@ static const Property virtio_net_properties[] = {
>                        VIRTIO_NET_F_GUEST_USO6, true),
>      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                        VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_BIT64("x-vq_notf_coal", VirtIONet, host_features,
> +                      VIRTIO_NET_F_NOTF_COAL, false),
>      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
>                                    rss_data.specified_hash_types,
>                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index a4eb3f407e..244c8a0224 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -155,6 +155,14 @@ typedef struct VirtioNetRssData {
>      uint16_t default_queue;
>  } VirtioNetRssData;
>  
> +/* Interrupt notification coalescing parameters */
> +typedef struct VirtIONetCoal {
> +    uint32_t usecs;    /* Timeout in microseconds */
> +    uint32_t packets;  /* Packet count threshold */
> +    uint32_t pkt_cnt;  /* Current packet count since last notification */
> +    QEMUTimer *timer;  /* Coalescing timer */
> +} VirtIONetCoal;
> +
>  typedef struct VirtIONetQueue {
>      VirtQueue *rx_vq;
>      VirtQueue *tx_vq;
> @@ -165,6 +173,8 @@ typedef struct VirtIONetQueue {
>          VirtQueueElement *elem;
>      } async_tx;
>      struct VirtIONet *n;
> +    VirtIONetCoal rx_coal;
> +    VirtIONetCoal tx_coal;
>  } VirtIONetQueue;
>  
>  struct VirtIONet {
> diff --git a/net/passt.c b/net/passt.c
> index 45440c399b..43b36ed8c5 100644
> --- a/net/passt.c
> +++ b/net/passt.c
> @@ -52,6 +52,7 @@ static const int user_feature_bits[] = {
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
> @@ -63,6 +63,7 @@ static const int kernel_feature_bits[] = {
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
> @@ -54,6 +54,7 @@ static const int user_feature_bits[] = {
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
> @@ -70,6 +70,7 @@ static const int vdpa_feature_bits[] = {
>      VIRTIO_NET_F_CTRL_RX,
>      VIRTIO_NET_F_CTRL_RX_EXTRA,
>      VIRTIO_NET_F_CTRL_VLAN,
> +    VIRTIO_NET_F_NOTF_COAL,
>      VIRTIO_NET_F_CTRL_VQ,
>      VIRTIO_NET_F_GSO,
>      VIRTIO_NET_F_GUEST_CSUM,
> -- 
> 2.53.0



please do not add these bits until someone actually implements this.

-- 
MST


