Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E05C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Is0-0004RU-5C; Mon, 28 Apr 2025 03:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u9Irw-0004R3-1O
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u9Irs-00089E-Cn
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KobEfUsHHEtMqjUXk1oyO2ds49+bCrUjoPMTRddnpz4=;
 b=SW22C1XskN+mJtowShwfEIny69aGw/M/QzBgF229TF4mKxA5DBL/R45mu+x7DwOTfhYa3F
 Ny9LxX9jr1QP/A8waDOuklN1Pk51HyNTa/HgcVOpYQa+jRgNe2Ql5XaEgOQWQ6j6S226OG
 VJQodlJokwmfa1IfnwXbFeGvC2MvRkQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-Yb40RC9IM4OPaPbaX1znaQ-1; Mon, 28 Apr 2025 03:25:18 -0400
X-MC-Unique: Yb40RC9IM4OPaPbaX1znaQ-1
X-Mimecast-MFC-AGG-ID: Yb40RC9IM4OPaPbaX1znaQ_1745825117
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-440a4e2bad7so10314285e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825117; x=1746429917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KobEfUsHHEtMqjUXk1oyO2ds49+bCrUjoPMTRddnpz4=;
 b=gg+RQ5BHuLfv7OyjnQ961dFlSyy1GY0wTPtx6NxkOUSE0jjne+X2ra6PKfQ6UxPwEu
 gVI8MMAYv90CRQ9Qweby673FDzyfRX2RZLFmj0BfzdXg40BH4Mjw3Fzj9/+doEKprWMh
 bVgah/JpgQlyNqMhAd1iBBj8OKSVjmeU1orecgxPINCBB9Yx95ZRLDq1Xg2YZ7Paq67x
 cPS6G2TwiAo9t/f0PtQtvRxcy9+lcz0mGlfxOFYyQXovM1Iv0mbsR/6/38YsFGmj7XvF
 L4Q55d2ZwkrZuxj5/8lEgrvNAJjRu7S1dMUv/wQ4CEjvcBngwaHkbk0BtAkdV3Z/my1j
 nW0A==
X-Gm-Message-State: AOJu0YwgEY8LKzyHaWVbnYg9BPPcsPguIjbk5bLnW2B0DUuEcJGXLSPU
 d78+h5g0dFTk6CARUNPALvLAEvUoaYtVFTjWBP+qWNon/ayO+qenqhmdB5fQo6Z2Xi/7wNa18lG
 nItOY22U0VsigS5oVEccc85Oc64x0TdZw4xXjhvCHDOQ9kyBJ76n4KEjreeBD
X-Gm-Gg: ASbGncu1OjxRXulsB0WGBbxUXMavqhcb/NpAjd5ZmI5B33FZb2TT/sXp6+NqyhpPrXI
 qEfTX4EQlzNOQH7h9dfJPwD9RrYNNtCz49o0sMO5A6E4aXiz+nUfdAAEfQVhAauP2AMMOoCXspI
 sQPjpSm4NnJdwobgBi9JXDKICfnK/sbdn1cxasPSuDHKeNCm6lCDYUVF2ggWIjw5u2LnH5usipg
 NGKhAfJEs5ESUaV4+tiQpT1iOiWbPdnyBvvTInH0b1LHMSfyfwTLFzd5FSZMPBYby57k/FY2Xke
 1/7k8g==
X-Received: by 2002:a7b:c384:0:b0:43c:f3e1:a729 with SMTP id
 5b1f17b1804b1-4409c4dfb60mr103497825e9.12.1745825116810; 
 Mon, 28 Apr 2025 00:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXh94iKJobZp7+bWQZVOiKDdsvZNB9PBsipBg3fwSOqclgT8zaGQZ5tzRIDMSLmibe9sR7Yw==
X-Received: by 2002:a7b:c384:0:b0:43c:f3e1:a729 with SMTP id
 5b1f17b1804b1-4409c4dfb60mr103497525e9.12.1745825116160; 
 Mon, 28 Apr 2025 00:25:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac26dsm147417505e9.21.2025.04.28.00.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:25:15 -0700 (PDT)
Date: Mon, 28 Apr 2025 03:25:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weimin Xiong <xiongweimin@kylinos.cn>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/rdma: Add initial Support for Vhost-User-Rdma Device
Message-ID: <20250428032132-mutt-send-email-mst@kernel.org>
References: <20250428021216.144387-1-xiongweimin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428021216.144387-1-xiongweimin@kylinos.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 28, 2025 at 10:12:16AM +0800, Weimin Xiong wrote:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> Add initial support for vhost-user-rdma device model for qemu,
> this includes the interaction(e.g feature negotiation, setting
> vring baseaddr, setting device status) between guest kernel and
> host vhost-user-rdma backend device
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>

Thank you!
Some notes/questions:
- a spec patch will also be necessary, documenting this all,
  and submitted to the virtio tc
- can you detail the motivation for the work a bit please?
  do you have an open source implementation? how well does it work?
- what about the guest drivers, for which OSes do you have them?


> ---
>  hw/rdma/vhost-user-rdma.c                   | 466 ++++++++++++++++++++
>  hw/virtio/meson.build                       |   1 +
>  hw/virtio/vhost-user-rdma-pci.c             | 102 +++++
>  hw/virtio/virtio.c                          |   1 +
>  include/hw/pci/pci.h                        |   1 +
>  include/hw/virtio/vhost-user-rdma.h         |  45 ++
>  include/standard-headers/linux/virtio_ids.h |   1 +
>  include/standard-headers/rdma/virtio_rdma.h |  60 +++
>  8 files changed, 677 insertions(+)
>  create mode 100644 hw/rdma/vhost-user-rdma.c
>  create mode 100644 hw/virtio/vhost-user-rdma-pci.c
>  create mode 100644 include/hw/virtio/vhost-user-rdma.h
>  create mode 100644 include/standard-headers/rdma/virtio_rdma.h
> 
> diff --git a/hw/rdma/vhost-user-rdma.c b/hw/rdma/vhost-user-rdma.c
> new file mode 100644
> index 000000000..b87ba6941
> --- /dev/null
> +++ b/hw/rdma/vhost-user-rdma.c
> @@ -0,0 +1,466 @@
> +/*
> + * vhost-user-rdma.c
> + *
> + * Copyright (c) 2025 Weimin Xiong <xiongweimin@kylinos.cn>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/cutils.h"
> +#include "hw/qdev-core.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user-rdma.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-bus.h"
> +#include "hw/virtio/virtio-access.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/runstate.h"
> +
> +#define VHOST_USER_RDMA_NUM_QUEUES 256
> +#define VHOST_USER_RDMA_QUEUE_SIZE 512
> +
> +static const int user_feature_bits[] = {
> +    VIRTIO_F_VERSION_1,
> +    VIRTIO_RING_F_INDIRECT_DESC,
> +    VIRTIO_RING_F_EVENT_IDX,
> +    VIRTIO_F_NOTIFY_ON_EMPTY,
> +    VHOST_INVALID_FEATURE_BIT
> +};
> +
> +static int vhost_user_rdma_start(VirtIODevice *vdev)
> +{
> +    VhostUserRdma *r = VHOST_USER_RDMA(vdev);
> +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> +    int i, ret;
> +
> +    if (!k->set_guest_notifiers) {
> +        error_report("binding does not support guest notifiers");
> +        return -ENOSYS;
> +    }
> +
> +    ret = vhost_dev_enable_notifiers(&r->dev, vdev);
> +    if (ret < 0) {
> +        error_report("Error enabling host notifiers: %d", -ret);
> +        return ret;
> +    }
> +
> +    ret = k->set_guest_notifiers(qbus->parent, r->dev.nvqs, true);
> +    if (ret < 0) {
> +        error_report("Error binding guest notifier: %d", -ret);
> +        goto err_host_notifiers;
> +    }
> +
> +    r->dev.acked_features = vdev->guest_features;
> +
> +    ret = vhost_dev_start(&r->dev, vdev, true);
> +    if (ret < 0) {
> +        error_report("Error starting vhost: %d", -ret);
> +        goto err_guest_notifiers;
> +    }
> +    r->started_vu = true;
> +
> +    for (i = 0; i < r->dev.nvqs; i++) {
> +        vhost_virtqueue_mask(&r->dev, vdev, i, false);
> +    }
> +
> +    return ret;
> +
> +err_guest_notifiers:
> +    k->set_guest_notifiers(qbus->parent, r->dev.nvqs, false);
> +err_host_notifiers:
> +    vhost_dev_disable_notifiers(&r->dev, vdev);
> +    return ret;
> +}
> +
> +static void vhost_user_rdma_stop(VirtIODevice *vdev)
> +{
> +    VhostUserRdma *r = VHOST_USER_RDMA(vdev);
> +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> +    int ret;
> +
> +    if (!r->started_vu) {
> +        return;
> +    }
> +    r->started_vu = false;
> +
> +    if (!k->set_guest_notifiers) {
> +        return;
> +    }
> +
> +    vhost_dev_stop(&r->dev, vdev, true);
> +
> +    ret = k->set_guest_notifiers(qbus->parent, r->dev.nvqs, false);
> +    if (ret < 0) {
> +        error_report("vhost guest notifier cleanup failed: %d", ret);
> +        return;
> +    }
> +
> +    vhost_dev_disable_notifiers(&r->dev, vdev);
> +}
> +
> +static int vhost_user_rdma_handle_config_change(struct vhost_dev *dev)
> +{
> +    int ret;
> +    VhostUserRdma *r = VHOST_USER_RDMA(dev->vdev);
> +    Error *local_err = NULL;
> +
> +    ret = vhost_dev_get_config(dev, (uint8_t *)&r->rdma_backend_cfg,
> +                               sizeof(struct virtio_rdma_config), &local_err);
> +    if (ret < 0) {
> +        error_report("get config space failed");
> +        return -1;
> +    }
> +
> +    virtio_notify_config(dev->vdev);
> +    return 0;
> +}
> +
> +const VhostDevConfigOps rdma_ops = {
> +    .vhost_dev_config_notifier = vhost_user_rdma_handle_config_change,
> +};
> +
> +static int vhost_user_rdma_connect(DeviceState *dev)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VhostUserRdma *r = VHOST_USER_RDMA(vdev);
> +    int ret = 0;
> +    Error *local_err = NULL;
> +
> +    if (r->connected) {
> +        return 0;
> +    }
> +    r->connected = true;
> +
> +    r->dev.nvqs = r->num_queues;
> +    r->dev.vqs = r->vhost_vqs;
> +    r->dev.vq_index = 0;
> +    r->dev.backend_features = 0;
> +
> +    vhost_dev_set_config_notifier(&r->dev, &rdma_ops);
> +
> +    ret = vhost_dev_init(&r->dev, &r->vu_state,
> +                         VHOST_BACKEND_TYPE_USER, 0, &local_err);
> +    if (ret < 0) {
> +        error_report("vhost-user-rdma: vhost initialization failed: %s",
> +                     strerror(-ret));
> +        return ret;
> +    }
> +
> +    /* restore vhost state */
> +    if (virtio_device_started(vdev, vdev->status)) {
> +        info_report("vhost_user_rdma: vhost ss?");
> +        ret = vhost_user_rdma_start(vdev);
> +        if (ret < 0) {
> +            error_report("vhost-user-rdma: vhost start failed: %s",
> +                         strerror(-ret));
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static void vhost_user_rdma_disconnect(DeviceState *dev)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VhostUserRdma *s = VHOST_USER_RDMA(vdev);
> +
> +    if (!s->connected) {
> +        return;
> +    }
> +    s->connected = false;
> +
> +    vhost_user_rdma_stop(vdev);
> +
> +    vhost_dev_cleanup(&s->dev);
> +}
> +
> +static void vhost_user_rdma_event(void *opaque, QEMUChrEvent event);
> +
> +static void vhost_user_rdma_chr_closed_bh(void *opaque)
> +{
> +    DeviceState *dev = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VhostUserRdma *r = VHOST_USER_RDMA(vdev);
> +
> +    vhost_user_rdma_disconnect(dev);
> +    qemu_chr_fe_set_handlers(&r->chardev, NULL, NULL, vhost_user_rdma_event,
> +            NULL, opaque, NULL, true);
> +}
> +
> +static void vhost_user_rdma_event(void *opaque, QEMUChrEvent event)
> +{
> +    DeviceState *dev = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VhostUserRdma *r = VHOST_USER_RDMA(vdev);
> +
> +    switch (event) {
> +    case CHR_EVENT_OPENED:
> +        if (vhost_user_rdma_connect(dev) < 0) {
> +            qemu_chr_fe_disconnect(&r->chardev);
> +            return;
> +        }
> +        break;
> +    case CHR_EVENT_CLOSED:
> +        if (runstate_is_running()) {
> +            AioContext *ctx = qemu_get_current_aio_context();
> +
> +            qemu_chr_fe_set_handlers(&r->chardev, NULL, NULL, NULL, NULL,
> +                    NULL, NULL, false);
> +            aio_bh_schedule_oneshot(ctx, vhost_user_rdma_chr_closed_bh, opaque);
> +        }
> +
> +        r->dev.started = false;
> +        break;
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_MUX_IN:
> +    case CHR_EVENT_MUX_OUT:
> +        /* Ignore */
> +        break;
> +    }
> +}
> +
> +static void vhost_user_rdma_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VhostUserRdma *r = VHOST_USER_RDMA(vdev);
> +    int i, ret;
> +
> +    if (!vdev->start_on_kick) {
> +        return;
> +    }
> +
> +    if (!r->connected) {
> +        return;
> +    }
> +
> +    if (r->dev.started) {
> +        return;
> +    }
> +
> +    ret = vhost_user_rdma_start(vdev);
> +    if (ret < 0) {
> +        error_report("vhost-user-rdma: vhost start failed: %s",
> +                     strerror(-ret));
> +        qemu_chr_fe_disconnect(&r->chardev);
> +        return;
> +    }
> +
> +    for (i = 0; i < r->dev.nvqs; i++) {
> +        VirtQueue *kick_vq = virtio_get_queue(vdev, i);
> +
> +        if (!virtio_queue_get_desc_addr(vdev, i)) {
> +            continue;
> +        }
> +        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
> +    }
> +}
> +
> +static void vhost_user_rdma_update_config(VirtIODevice *vdev, uint8_t *config)
> +{
> +    VhostUserRdma *r = VHOST_USER_RDMA(vdev);
> +
> +    memcpy(config, &r->rdma_backend_cfg, sizeof(struct virtio_rdma_config));
> +}
> +
> +static uint64_t vhost_user_rdma_get_features(VirtIODevice *vdev,
> +                                            uint64_t features,
> +                                            Error **errp)
> +{
> +    VhostUserRdma *s = VHOST_USER_RDMA(vdev);
> +
> +    return vhost_get_features(&s->dev, user_feature_bits, features);
> +}
> +
> +static void vhost_user_rdma_set_status(VirtIODevice *vdev, uint8_t status)
> +{
> +    VhostUserRdma *r = VHOST_USER_RDMA(vdev);
> +    bool should_start = virtio_device_started(vdev, status);
> +    int ret;
> +
> +    if (!vdev->vm_running) {
> +        should_start = false;
> +    }
> +
> +    if (!r->connected) {
> +        return;
> +    }
> +
> +    if (r->dev.started == should_start) {
> +        return;
> +    }
> +
> +    if (should_start) {
> +        ret = vhost_user_rdma_start(vdev);
> +        if (ret < 0) {
> +            error_report("vhost-user-rdma: vhost start failed: %s",
> +                         strerror(-ret));
> +            qemu_chr_fe_disconnect(&r->chardev);
> +        }
> +    } else {
> +        vhost_user_rdma_stop(vdev);
> +    }
> +}
> +
> +static void vhost_user_rdma_device_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VhostUserRdma *r = VHOST_USER_RDMA(vdev);
> +    Error *err = NULL;
> +    int i, ret;
> +
> +    if (!r->chardev.chr) {
> +        error_setg(errp, "vhost-user-rdma: chardev is mandatory");
> +        return;
> +    }
> +
> +    r->num_queues = VHOST_USER_RDMA_NUM_QUEUES;
> +
> +    if (r->num_queues > VIRTIO_QUEUE_MAX) {
> +        error_setg(errp, "vhost-user-rdma: invalid number of IO queues");
> +        return;
> +    }
> +
> +    if (!vhost_user_init(&r->vu_state, &r->chardev, errp)) {
> +        return;
> +    }
> +
> +    virtio_init(vdev, VIRTIO_ID_RDMA, sizeof(struct virtio_rdma_config));
> +
> +    r->virtqs = g_new(VirtQueue *, r->num_queues);
> +
> +    for (i = 0; i < r->num_queues; i++) {
> +        r->virtqs[i] = virtio_add_queue(vdev, VHOST_USER_RDMA_QUEUE_SIZE,
> +                                        vhost_user_rdma_handle_output);
> +    }
> +
> +    r->vhost_vqs = g_new0(struct vhost_virtqueue, r->num_queues);
> +    r->connected = false;
> +
> +    qemu_chr_fe_set_handlers(&r->chardev,  NULL, NULL, vhost_user_rdma_event,
> +                             NULL, (void *)dev, NULL, true);
> +
> +reconnect:
> +    if (qemu_chr_fe_wait_connected(&r->chardev, &err) < 0) {
> +        error_report_err(err);
> +        goto virtio_err;
> +    }
> +
> +    /* check whether vhost_user_rdma_connect() failed or not */
> +    if (!r->connected) {
> +        goto reconnect;
> +    }
> +
> +    ret = vhost_dev_get_config(&r->dev, (uint8_t *)&r->rdma_backend_cfg,
> +                               sizeof(struct virtio_rdma_config), &err);
> +    if (ret < 0) {
> +        error_report("vhost-user-rdma: get rdma config failed");
> +        goto reconnect;
> +    }
> +
> +    return;
> +
> +virtio_err:
> +    g_free(r->vhost_vqs);
> +    r->vhost_vqs = NULL;
> +    for (i = 0; i < r->num_queues; i++) {
> +        virtio_delete_queue(r->virtqs[i]);
> +    }
> +    g_free(r->virtqs);
> +    virtio_cleanup(vdev);
> +    vhost_user_cleanup(&r->vu_state);
> +}
> +
> +static void vhost_user_rdma_device_unrealize(DeviceState *dev)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VhostUserRdma *r = VHOST_USER_RDMA(dev);
> +    int i;
> +
> +    virtio_set_status(vdev, 0);
> +    qemu_chr_fe_set_handlers(&r->chardev,  NULL, NULL, NULL,
> +                             NULL, NULL, NULL, false);
> +    vhost_dev_cleanup(&r->dev);
> +    g_free(r->vhost_vqs);
> +    r->vhost_vqs = NULL;
> +    for (i = 0; i < r->num_queues; i++) {
> +        virtio_delete_queue(r->virtqs[i]);
> +    }
> +    g_free(r->virtqs);
> +    virtio_cleanup(vdev);
> +    vhost_user_cleanup(&r->vu_state);
> +}
> +
> +static void vhost_user_rdma_instance_init(Object *obj)
> +{
> +    VhostUserRdma *r = VHOST_USER_RDMA(obj);
> +
> +    device_add_bootindex_property(obj, &r->bootindex, "bootindex",
> +                                  "bootindex", DEVICE(obj));
> +}
> +
> +static const VMStateDescription vmstate_vhost_user_rdma = {
> +    .name = "vhost-user-rdma",
> +    .minimum_version_id = 1,
> +    .version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_VIRTIO_DEVICE,
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static Property vhost_user_rdma_properties[] = {
> +    DEFINE_PROP_CHR("chardev", VhostUserRdma, chardev),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vhost_user_rdma_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, vhost_user_rdma_properties);
> +    dc->vmsd = &vmstate_vhost_user_rdma;
> +    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> +
> +    vdc->realize = vhost_user_rdma_device_realize;
> +    vdc->unrealize = vhost_user_rdma_device_unrealize;
> +    vdc->get_config = vhost_user_rdma_update_config;
> +    vdc->set_config = NULL;
> +    vdc->get_features = vhost_user_rdma_get_features;
> +    vdc->set_status = vhost_user_rdma_set_status;
> +}
> +
> +static const TypeInfo vhost_user_rdma_info = {
> +    .name = TYPE_VHOST_USER_RDMA,
> +    .parent = TYPE_VIRTIO_DEVICE,
> +    .instance_size = sizeof(VhostUserRdma),
> +    .instance_init = vhost_user_rdma_instance_init,
> +    .class_init = vhost_user_rdma_class_init,
> +};
> +
> +static void virtio_register_types(void)
> +{
> +    type_register_static(&vhost_user_rdma_info);
> +}
> +
> +type_init(virtio_register_types)
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 164f6fd99..84603ac12 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -65,6 +65,7 @@ virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'
>  virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi-pci.c'))
> +virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_RDMA', if_true: files('vhost-user-rdma-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-pci.c'))
>  
> diff --git a/hw/virtio/vhost-user-rdma-pci.c b/hw/virtio/vhost-user-rdma-pci.c
> new file mode 100644
> index 000000000..bbfa2d357
> --- /dev/null
> +++ b/hw/virtio/vhost-user-rdma-pci.c
> @@ -0,0 +1,102 @@
> +/*
> + * Vhost user rdma PCI Bindings
> + *
> + * Copyright(C) 2025 KylinSoft Inc. All rights reserved.
> + *
> + * Authors:
> + *  Weimin Xiong <xiongweimin@kylinos.cn>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "standard-headers/rdma/virtio_rdma.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/vhost-user-rdma.h"
> +#include "hw/pci/pci.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/module.h"
> +#include "hw/virtio/virtio-pci.h"
> +#include "qom/object.h"
> +
> +typedef struct VhostUserRdmaPCI VhostUserRdmaPCI;
> +
> +#define TYPE_VHOST_USER_RDMA_PCI "vhost-user-rdma-pci"
> +DECLARE_INSTANCE_CHECKER(VhostUserRdmaPCI, VHOST_USER_RDMA_PCI,
> +                         TYPE_VHOST_USER_RDMA_PCI)
> +
> +struct VhostUserRdmaPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VhostUserRdma vdev;
> +};
> +
> +static Property vhost_user_rdma_pci_properties[] = {
> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vhost_user_rdma_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VhostUserRdmaPCI *dev = VHOST_USER_RDMA_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +
> +    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors = dev->vdev.num_queues + 1;
> +    }
> +
> +    virtio_pci_force_virtio_1(vpci_dev);
> +
> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +}
> +
> +static void vhost_user_rdma_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *k_pcidev = PCI_DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> +    device_class_set_props(dc, vhost_user_rdma_pci_properties);
> +    k->realize = vhost_user_rdma_pci_realize;
> +    k_pcidev->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    k_pcidev->device_id = PCI_DEVICE_ID_VIRTIO_RDMA;
> +    k_pcidev->revision = VIRTIO_PCI_ABI_VERSION;
> +    k_pcidev->class_id = PCI_CLASS_NETWORK_OTHER;
> +}
> +
> +static void vhost_user_rdma_pci_instance_init(Object *obj)
> +{
> +    VhostUserRdmaPCI *dev = VHOST_USER_RDMA_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VHOST_USER_RDMA);
> +
> +    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
> +                              "bootindex");
> +}
> +
> +static const VirtioPCIDeviceTypeInfo vhost_user_rdma_pci_info = {
> +    .base_name               = TYPE_VHOST_USER_RDMA_PCI,
> +    .generic_name            = "vhost-user-rdma-pci",
> +    .transitional_name       = "vhost-user-rdma-pci-transitional",
> +    .non_transitional_name   = "vhost-user-rdma-pci-non-transitional",
> +    .instance_size  = sizeof(VhostUserRdmaPCI),
> +    .instance_init  = vhost_user_rdma_pci_instance_init,
> +    .class_init     = vhost_user_rdma_pci_class_init,
> +};
> +
> +static void vhost_user_rdma_pci_register(void)
> +{
> +    virtio_pci_types_register(&vhost_user_rdma_pci_info);
> +}
> +
> +type_init(vhost_user_rdma_pci_register)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce3..277fc9637 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -182,6 +182,7 @@ const char *virtio_device_names[] = {
>      [VIRTIO_ID_FS] = "virtio-user-fs",
>      [VIRTIO_ID_PMEM] = "virtio-pmem",
>      [VIRTIO_ID_RPMB] = "virtio-rpmb",
> +    [VIRTIO_ID_RDMA] = "virtio-rdma",
>      [VIRTIO_ID_MAC80211_HWSIM] = "virtio-mac-hwsim",
>      [VIRTIO_ID_VIDEO_ENCODER] = "virtio-vid-encoder",
>      [VIRTIO_ID_VIDEO_DECODER] = "virtio-vid-decoder",
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 822fbacdf..776fccb65 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -90,6 +90,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
> +#define PCI_DEVICE_ID_VIRTIO_RDMA        0x1016
>  
>  /*
>   * modern virtio-pci devices get their id assigned automatically,
> diff --git a/include/hw/virtio/vhost-user-rdma.h b/include/hw/virtio/vhost-user-rdma.h
> new file mode 100644
> index 000000000..89a9dddae
> --- /dev/null
> +++ b/include/hw/virtio/vhost-user-rdma.h
> @@ -0,0 +1,45 @@
> +/*
> + * vhost-user-rdma host device
> + * Copyright(C) 2025 KylinSoft Inc. All rights reserved.
> + *
> + * Authors:
> + *  Weimin Xiong <xiongweimin@kylinos.cn>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#ifndef VHOST_USER_RDMA_H
> +#define VHOST_USER_RDMA_H
> +
> +#include "standard-headers/rdma/virtio_rdma.h"
> +#include "chardev/char-fe.h"
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user.h"
> +#include "qom/object.h"
> +
> +#define TYPE_VHOST_USER_RDMA "vhost-user-rdma"
> +OBJECT_DECLARE_SIMPLE_TYPE(VhostUserRdma, VHOST_USER_RDMA)
> +
> +struct VhostUserRdma {
> +    VirtIODevice parent_obj;
> +    CharBackend chardev;
> +    int32_t bootindex;
> +    struct virtio_rdma_config rdma_backend_cfg;
> +    struct vhost_dev dev;
> +    VhostUserState vu_state;
> +    struct vhost_virtqueue *vhost_vqs;
> +    VirtQueue **virtqs;
> +
> +    int num_queues;
> +
> +    /* vhost_user_rdma_connect/vhost_user_rdma_disconnect */
> +    bool connected;
> +    /* vhost_user_rdma_start/vhost_user_rdma_stop */
> +    bool started_vu;
> +};
> +
> +#endif
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index 7aa2eb766..ff2d0b01b 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
>  #define VIRTIO_ID_BT			40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
> +#define VIRTIO_ID_RDMA          42 /* virtio rdma */
>  
>  /*
>   * Virtio Transitional IDs
> diff --git a/include/standard-headers/rdma/virtio_rdma.h b/include/standard-headers/rdma/virtio_rdma.h
> new file mode 100644
> index 000000000..01823bfa9
> --- /dev/null
> +++ b/include/standard-headers/rdma/virtio_rdma.h
> @@ -0,0 +1,60 @@
> +/*
> + * Virtio RDMA Device
> + *
> + * Copyright (C) 2025 KylinSoft Inc.
> + *
> + * Authors:
> + *  Weimin Xiong <xiongweimin@kylinos.cn>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See


not a good license for guest/host interface.

> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef _LINUX_VIRTIO_RDMA_H
> +#define _LINUX_VIRTIO_RDMA_H
> +
> +#include <linux/types.h>
> +#include <infiniband/verbs.h>
> +
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "standard-headers/linux/virtio_config.h"
> +#include "standard-headers/linux/virtio_types.h"
> +
> +struct virtio_rdma_config {
> +    __le32         phys_port_cnt;
> +
> +    __le64         sys_image_guid;

bad alignment here.

> +    __le32         vendor_id;
> +    __le32         vendor_part_id;
> +    __le32         hw_ver;
> +    __le64         max_mr_size;
> +    __le64         page_size_cap;
> +    __le32         max_qp;
> +    __le32         max_qp_wr;
> +    __le64         device_cap_flags;
> +    __le32         max_send_sge;
> +    __le32         max_recv_sge;
> +    __le32         max_sge_rd;
> +    __le32         max_cq;
> +    __le32         max_cqe;
> +    __le32         max_mr;
> +    __le32         max_pd;
> +    __le32         max_qp_rd_atom;
> +    __le32         max_res_rd_atom;
> +    __le32         max_qp_init_rd_atom;
> +    __le32         atomic_cap;
> +    __le32         max_mw;
> +    __le32         max_mcast_grp;
> +    __le32         max_mcast_qp_attach;
> +    __le32         max_total_mcast_qp_attach;
> +    __le32         max_ah;
> +    __le32         max_fast_reg_page_list_len;
> +    __le32         max_pi_fast_reg_page_list_len;
> +    __le16         max_pkeys;
> +    uint8_t        local_ca_ack_delay;
> +
> +    uint8_t           reserved[64];

should not be necessary.

> +} QEMU_PACKED;

avoid packed, align fields naturally instead.


> +
> +#endif
> -- 
> 2.41.0


