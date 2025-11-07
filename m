Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BD0CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHM6L-000405-Rk; Fri, 07 Nov 2025 08:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vHM68-0003xH-Pm
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:01:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vHM64-0002LD-VZ
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762520502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0NPa8AeCKzcNk7W9w/n1HOcD73tlh6arHvZj/XWMRjo=;
 b=SbG7NHY+sL+OLyQn5iqSNbVKSTF2pasVsJpLiZCEQuuo8lsktzAjBStOnYHafi9Q4CA2uC
 KwU5/n/hWcxpeHm+Ts00wESDfPd7+3NOdi0AwU1dYikgYr6bXUeg7UYqe1cnNenBRTrJct
 FvOMYtx+Ehi5UJWcxW0G7AiCrXRtkL8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-2Lf1Agx8OFGWlQcqwaLHcQ-1; Fri, 07 Nov 2025 08:01:41 -0500
X-MC-Unique: 2Lf1Agx8OFGWlQcqwaLHcQ-1
X-Mimecast-MFC-AGG-ID: 2Lf1Agx8OFGWlQcqwaLHcQ_1762520500
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-428567f67c5so507510f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 05:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762520500; x=1763125300; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0NPa8AeCKzcNk7W9w/n1HOcD73tlh6arHvZj/XWMRjo=;
 b=AOao3w2+XmF6Pk/oc0IzXFI9WzoCuN7Dj66WVwGv+3BfsuFe3mSckcPSzG+iYEHcJz
 OqkatUa9nSyqFq1EQo+QAi4nd+FOIMO/GfXc2tnp+mXxIs2ZPXbBPQDCsdr2q6xAGLtj
 AqHPa1h+87sub1ZnlI9NcqA0D8Ve73zALQnkQFU7xBZxRpVkS+jEBxJIotUmbyI92iCS
 cOlxc2npHfCWmbpIyLHQKy6z7onyMzmIIRx6wMh2yCTuQ8Rd6Z34URuJkH1N8tXCgUgF
 pa7mquzpvj0o0yy/cMHQyAeHcaqPMJfeTLouPwkH6iOMrZrZzvl/tmY9MO95NjVYh/MA
 GwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762520500; x=1763125300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NPa8AeCKzcNk7W9w/n1HOcD73tlh6arHvZj/XWMRjo=;
 b=AO22tJ15aNXqGCuRpmuZzEE8KuIEOV1M0Msni1+lmoFJVVoybn/PY1trOhPqbW4RUP
 tUBEIjMOjOn+AoeUwnP7/bkjzzCcLV71bcxVTIGu/63QxhzykhlwlJnHVhG8c+8THORd
 fzwhLK0nINRzjQPSlAWjD8unrrqJ3KPOJ7+F8s7iiHkzXJNe/Bar92lq1GMYM5ZgR1fY
 f3Qi7lMA1d9KazC3edSk5ty9aAtQ9pDiyziOY3J1Yf9bvdKWSxpcl3j+vB3+POIEAH9T
 VTF2YUjEdB2kWSZG47e3rUuKTJytG4Hua6zHWlDYoL/Qj8TaNW6h41TifSgHz3/TTtGY
 LO4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZJyV/rRE8vKq3V/D2UMdViWzL0aYGUjLw4/f0FSzuZ2gfrACCId5W/1/qiHnuCO4kGf/wvA3s5IR1@nongnu.org
X-Gm-Message-State: AOJu0YyFR9q9oXEtyIUVc9Q5pe3CGxOeBZfBRoNFFdlpgxWQ67s0tLNZ
 fV84wcpFaFmscLW9/RfKpR7/uK1KdvyF5bygUvlrlnIwW5GGSnRav0b7jn/24nWTVPZCC0H0vZV
 ut7NaKXejL+vnYzRfzpxBwgUiJ3SzM1S8KwqA7NpQr1abcW0uZIIRi/Jb
X-Gm-Gg: ASbGnctuqKaBw3zTaScHbyGn/eC6qXbRJBKz5lE9s9z/ZQCXOd2yN20UTSTdx9fN9TJ
 bTcn4my/5Y2uMNmOeu4inaM25csCULephqxlCbmdxTASFw29L147q1P7ip0USw9y27JKJsIJsgL
 9NFsNkIy5NZ9DrTEyHn9EvaMJpRhNof+5AbkSPbMbCDM5behshhmpeD2KnEjQAZi34TTa62mDrW
 Z1aLVyH2Gg9dU4IiMSd7SfgWPS5Fa3LB74+1pzSrYQSjzFYXllUgniL7FtMCgXpfR+Lzl1NWNpQ
 +38Jb3Lw3uEB/CkYTQEobHOlk3kATH/qPpEEKN1R0NjkL0jIeyTBKfV3mlV2hm/AbsA=
X-Received: by 2002:a05:6000:310d:b0:429:89ff:c25d with SMTP id
 ffacd0b85a97d-42ae5ac2092mr2325695f8f.40.1762520499667; 
 Fri, 07 Nov 2025 05:01:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVbJ7Y1GTK35PbIBPskIrAIfpKEa1zBtTrcZHXMRshgCx8MFloNVw9KBWc3Nq2DlNgEdQK8Q==
X-Received: by 2002:a05:6000:310d:b0:429:89ff:c25d with SMTP id
 ffacd0b85a97d-42ae5ac2092mr2325639f8f.40.1762520498952; 
 Fri, 07 Nov 2025 05:01:38 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe62bfa0sm5473357f8f.5.2025.11.07.05.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 05:01:38 -0800 (PST)
Date: Fri, 7 Nov 2025 08:01:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: Re: [PATCH v3 07/23] virtio: move common part of _set_guest_notifier
 to generic code
Message-ID: <20251107075743-mutt-send-email-mst@kernel.org>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
 <20251015145808.1112843-8-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015145808.1112843-8-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 05:57:51PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> virtio-pci and virtio-mmio handle config notifier equally but
> with different code (mmio adds a separate function, when pci
> use common function). Let's chose the more compact way (pci)
> and reuse it for mmio.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>


Breaks virtio-ccw which also uses this.

> ---
>  hw/virtio/virtio-mmio.c        | 41 +++++------------------------
>  hw/virtio/virtio-pci.c         | 34 +++---------------------
>  hw/virtio/virtio.c             | 48 +++++++++++++++++++++++++++++++---
>  include/hw/virtio/virtio-pci.h |  3 ---
>  include/hw/virtio/virtio.h     | 16 +++++++++---
>  5 files changed, 67 insertions(+), 75 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index fb58c36452..1f1d96129b 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -659,18 +659,11 @@ static int virtio_mmio_set_guest_notifier(DeviceState *d, int n, bool assign,
>      VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
>      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>      VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> -    VirtQueue *vq = virtio_get_queue(vdev, n);
> -    EventNotifier *notifier = virtio_queue_get_guest_notifier(vq);
> +    int r;
>  
> -    if (assign) {
> -        int r = event_notifier_init(notifier, 0);
> -        if (r < 0) {
> -            return r;
> -        }
> -        virtio_queue_set_guest_notifier_fd_handler(vq, true, with_irqfd);
> -    } else {
> -        virtio_queue_set_guest_notifier_fd_handler(vq, false, with_irqfd);
> -        event_notifier_cleanup(notifier);
> +    r = virtio_queue_set_guest_notifier(vdev, n, assign, with_irqfd);
> +    if (r < 0) {
> +        return r;
>      }
>  
>      if (vdc->guest_notifier_mask && vdev->use_guest_notifier_mask) {
> @@ -679,30 +672,7 @@ static int virtio_mmio_set_guest_notifier(DeviceState *d, int n, bool assign,
>  
>      return 0;
>  }
> -static int virtio_mmio_set_config_guest_notifier(DeviceState *d, bool assign,
> -                                                 bool with_irqfd)
> -{
> -    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
> -    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> -    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> -    EventNotifier *notifier = virtio_config_get_guest_notifier(vdev);
> -    int r = 0;
>  
> -    if (assign) {
> -        r = event_notifier_init(notifier, 0);
> -        if (r < 0) {
> -            return r;
> -        }
> -        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
> -    } else {
> -        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
> -        event_notifier_cleanup(notifier);
> -    }
> -    if (vdc->guest_notifier_mask && vdev->use_guest_notifier_mask) {
> -        vdc->guest_notifier_mask(vdev, VIRTIO_CONFIG_IRQ_IDX, !assign);
> -    }
> -    return r;
> -}
>  static int virtio_mmio_set_guest_notifiers(DeviceState *d, int nvqs,
>                                             bool assign)
>  {
> @@ -724,7 +694,8 @@ static int virtio_mmio_set_guest_notifiers(DeviceState *d, int nvqs,
>              goto assign_error;
>          }
>      }
> -    r = virtio_mmio_set_config_guest_notifier(d, assign, with_irqfd);
> +    r = virtio_mmio_set_guest_notifier(d, VIRTIO_CONFIG_IRQ_IDX, assign,
> +                                       with_irqfd);
>      if (r < 0) {
>          goto assign_error;
>      }
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 937e22f08a..6c4576a17f 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1197,43 +1197,17 @@ static void virtio_pci_vector_poll(PCIDevice *dev,
>      }
>  }
>  
> -void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev, VirtQueue *vq,
> -                                              int n, bool assign,
> -                                              bool with_irqfd)
> -{
> -    if (n == VIRTIO_CONFIG_IRQ_IDX) {
> -        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
> -    } else {
> -        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
> -    }
> -}
> -
>  static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
>                                           bool with_irqfd)
>  {
>      VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>      VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> -    VirtQueue *vq = NULL;
> -    EventNotifier *notifier = NULL;
> +    int r;
>  
> -    if (n == VIRTIO_CONFIG_IRQ_IDX) {
> -        notifier = virtio_config_get_guest_notifier(vdev);
> -    } else {
> -        vq = virtio_get_queue(vdev, n);
> -        notifier = virtio_queue_get_guest_notifier(vq);
> -    }
> -
> -    if (assign) {
> -        int r = event_notifier_init(notifier, 0);
> -        if (r < 0) {
> -            return r;
> -        }
> -        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, true, with_irqfd);
> -    } else {
> -        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, false,
> -                                                 with_irqfd);
> -        event_notifier_cleanup(notifier);
> +    r = virtio_queue_set_guest_notifier(vdev, n, assign, with_irqfd);
> +    if (r < 0) {
> +        return r;
>      }
>  
>      if (!msix_enabled(&proxy->pci_dev) &&
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 153ee0a0cf..704bc7943f 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3803,8 +3803,10 @@ static void virtio_config_guest_notifier_read(EventNotifier *n)
>          virtio_notify_config(vdev);
>      }
>  }
> -void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
> -                                                bool with_irqfd)
> +
> +static void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq,
> +                                                       bool assign,
> +                                                       bool with_irqfd)
>  {
>      if (assign && !with_irqfd) {
>          event_notifier_set_handler(&vq->guest_notifier,
> @@ -3819,7 +3821,7 @@ void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
>      }
>  }
>  
> -void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
> +static void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
>                                                   bool assign, bool with_irqfd)
>  {
>      EventNotifier *n;
> @@ -3836,6 +3838,46 @@ void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
>      }
>  }
>  
> +static void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev,
> +                                                     VirtQueue *vq,
> +                                                     int n, bool assign,
> +                                                     bool with_irqfd)
> +{
> +    if (n == VIRTIO_CONFIG_IRQ_IDX) {
> +        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
> +    } else {
> +        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
> +    }
> +}
> +
> +int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
> +                                    bool with_irqfd)
> +{
> +    VirtQueue *vq = NULL;
> +    EventNotifier *notifier = NULL;
> +
> +    if (n == VIRTIO_CONFIG_IRQ_IDX) {
> +        notifier = virtio_config_get_guest_notifier(vdev);
> +    } else {
> +        vq = virtio_get_queue(vdev, n);
> +        notifier = virtio_queue_get_guest_notifier(vq);
> +    }
> +
> +    if (assign) {
> +        int r = event_notifier_init(notifier, 0);
> +        if (r < 0) {
> +            return r;
> +        }
> +        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, true, with_irqfd);
> +    } else {
> +        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, false,
> +                                                 with_irqfd);
> +        event_notifier_cleanup(notifier);
> +    }
> +
> +    return 0;
> +}
> +
>  EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq)
>  {
>      return &vq->guest_notifier;
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index 639752977e..2a5b65f374 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -263,9 +263,6 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t);
>   * @fixed_queues.
>   */
>  unsigned virtio_pci_optimal_num_queues(unsigned fixed_queues);
> -void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev, VirtQueue *vq,
> -                                              int n, bool assign,
> -                                              bool with_irqfd);
>  
>  int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy, uint8_t bar, uint64_t offset,
>                             uint64_t length, uint8_t id);
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index d97529c3f1..7db8046766 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -420,8 +420,6 @@ void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
>  VirtQueue *virtio_get_queue(VirtIODevice *vdev, int n);
>  uint16_t virtio_get_queue_index(VirtQueue *vq);
>  EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq);
> -void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
> -                                                bool with_irqfd);
>  int virtio_device_start_ioeventfd(VirtIODevice *vdev);
>  int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
>  void virtio_device_release_ioeventfd(VirtIODevice *vdev);
> @@ -435,8 +433,18 @@ void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ctx);
>  VirtQueue *virtio_vector_first_queue(VirtIODevice *vdev, uint16_t vector);
>  VirtQueue *virtio_vector_next_queue(VirtQueue *vq);
>  EventNotifier *virtio_config_get_guest_notifier(VirtIODevice *vdev);
> -void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
> -                                                 bool assign, bool with_irqfd);
> +
> +/**
> + * virtio_queue_set_guest_notifier - set/unset queue or config guest
> + *     notifier
> + *
> + * @vdev: the VirtIO device
> + * @n: queue number, or VIRTIO_CONFIG_IRQ_IDX to set config notifer
> + * @assign: true to set notifier, false to unset
> + * @with_irqfd: irqfd enabled
> + */
> +int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
> +                                    bool with_irqfd);
>  
>  static inline void virtio_add_feature(uint64_t *features, unsigned int fbit)
>  {
> -- 
> 2.48.1


