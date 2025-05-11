Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF5FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 16:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE9It-0001aH-Mv; Sun, 11 May 2025 12:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE9Iq-0001Zj-2F
 for qemu-devel@nongnu.org; Sun, 11 May 2025 12:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE9In-0007Tb-K1
 for qemu-devel@nongnu.org; Sun, 11 May 2025 12:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746980000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8tAdELh0T/zSbeHd7+8bc0dRTH9dy+3avvPw3zGnF8I=;
 b=Kz5VdcNnXQqILpr0x/Fw+fEfRdKUAEWAvRoDjU2tkDuybFcdWIAQGab8upoiaFbwsKgeHZ
 6j3fju0vhLY9JIuEjY4pQN2PnJ2P9yDYzyNhumMHZDSfY1krKbFbwyuRITKwcxrBWxuPBB
 Y11rFV8wrms89In+bgEKWFSlxCfnBwU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-OZu4X42fOJiwwe-JztKaSQ-1; Sun, 11 May 2025 12:13:19 -0400
X-MC-Unique: OZu4X42fOJiwwe-JztKaSQ-1
X-Mimecast-MFC-AGG-ID: OZu4X42fOJiwwe-JztKaSQ_1746979998
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b662be0cso2305538f8f.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 09:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746979996; x=1747584796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tAdELh0T/zSbeHd7+8bc0dRTH9dy+3avvPw3zGnF8I=;
 b=M53ksHMd5JRcrLgHgmY+YgUwDc71Q3NlyXUtKQKs4kS8zUkoIyzS4G0NeL0Dqm2v6L
 0d6StmCas65OlxnosecaNBDgj9wHVXV/Asa6idXfPDZi5AmTd8k9HPcFQCwsLRfSO5Gm
 RpdmPrlJE8Me80SmlZVmfGeUL4hZ1O7mnJ61Zd1hBPfK0NVc+bd6s72cYNAXdV1mb37C
 bMLJhNp2c2oHDqBTjqdViVLSFwiDGf4IZivQJ2mYdruFd2ATiMGhgHp81nXve024TfEq
 W3b3sbcoU7zzByu5cEr/x3+7xq/Vhnr4SVA9BPNzBCNzS+6SSFLTxVomMm1uPbvyno3b
 DG9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuMkt/vnCOSpQNcJgmQPgzh05X2upZI62ffdU42RL9QjL80R340MjQX0QtWwHL4LBKfW4T3d0IXqdQ@nongnu.org
X-Gm-Message-State: AOJu0YzQHj1PyClC2ofD38qMMlXWfPjxg3gr7pgqIPkCYhqRNs96jzkn
 9jOSbXZuqrzkB321PGKjeo4y63ma6c0ZZvHDbXbMGtjJj6kOxFwezni6R94nBsr2USK59IS0nNm
 bN+D5nVXwrhkGinpzcEPU052CHO3i+9P8iEnclVErxBqOlg7olmGC
X-Gm-Gg: ASbGncvnUozFdh65OYBXnyj6oAQPgocjvd4D9OwvIzveebNqU23FQ4Ru+ZUOspTCp36
 0FGERRI2F+WaCqI/qG6EPiF3ifRr8z8g8EBVjdBTNQ2dYAvst6Zk8owEz+BDx5BDRiI6r7DjKLn
 RHaYn0KVmu0guWZvh2JpVXxDpoEJqmCXYvNGBaisaPEERFxeKuYXZuuT97A+hqQXebfutIdgdNM
 YjqWGB7dIXkNIT4BFdIwcVQjr3PzvTwRatrYUkUSekFDqCxD5AAd90p05FLXB7dkKGT1n0iB8Jt
 wjZ8Iw==
X-Received: by 2002:a05:6000:420f:b0:39e:e438:8e4b with SMTP id
 ffacd0b85a97d-3a1f64ae792mr8136640f8f.50.1746979995900; 
 Sun, 11 May 2025 09:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXe3nv0scuUJFYsYr9uAEyTUNuR2G1BtHE4a2EynRqEsQnNhRnjvT9uyop0DwxA7kHva51OQ==
X-Received: by 2002:a05:6000:420f:b0:39e:e438:8e4b with SMTP id
 ffacd0b85a97d-3a1f64ae792mr8136622f8f.50.1746979995444; 
 Sun, 11 May 2025 09:13:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c583sm9480955f8f.84.2025.05.11.09.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 09:13:14 -0700 (PDT)
Date: Sun, 11 May 2025 12:13:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: oenhan@gmail.com
Cc: sgarzare@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com,
 pasic@linux.ibm.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com, leiyang@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>,
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: Re: [PATCH] vhost: Don't set vring call if guest notifier is unused
Message-ID: <20250511121034-mutt-send-email-mst@kernel.org>
References: <20250326082537.379977-1-hanht2@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326082537.379977-1-hanht2@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Thanks for the patch!
I an waiting for Stefan's comments to be addressed.
Additionally, something to improve:

On Wed, Mar 26, 2025 at 04:25:37PM +0800, oenhan@gmail.com wrote:
> From: Huaitong Han <hanht2@chinatelecom.cn>
> 
> The vring call fd is set even when the guest does not use msix (e.g., in the
> case of virtio pmd), leading to unnecessary CPU overhead for processing
> interrupts. The previous patch optimized the condition where msix is enabled
> but the queue vector is unset. However, there is a additional case where the
> guest interrupt notifier is effectively unused and the vring call fd should
> also be cleared: the guest does not use msix and the INTX_DISABLED bit in the PCI
> config is set.
> 
> Fixes: 96a3d98d2c ("vhost: don't set vring call if no vector")

this must be with no empty lines adjacent to the rest of trailers.

> Test result:
> https://raw.githubusercontent.com/oenhan/build_log/refs/heads/main/qemu/2503261015/build/meson-logs/testlog.txt

just include the summary here inline.

> Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
> Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
> Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
> ---
>  hw/pci/pci.c                   |  2 +-
>  hw/s390x/virtio-ccw.c          |  9 ++++++---
>  hw/virtio/vhost.c              |  5 ++---
>  hw/virtio/virtio-pci.c         | 15 ++++++++++-----
>  include/hw/pci/pci.h           |  1 +
>  include/hw/virtio/virtio-bus.h |  2 +-
>  6 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 2844ec5556..503a897528 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1719,7 +1719,7 @@ static void pci_update_mappings(PCIDevice *d)
>      pci_update_vga(d);
>  }
>  
> -static inline int pci_irq_disabled(PCIDevice *d)
> +int pci_irq_disabled(PCIDevice *d)
>  {
>      return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
>  }
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 43f3b162c8..af482a22cd 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
>      }
>  }
>  
> -static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
> +static bool virtio_ccw_query_guest_notifiers_used(DeviceState *d, int n)
>  {
>      CcwDevice *dev = CCW_DEVICE(d);
> +    VirtioCcwDevice *vdev = VIRTIO_CCW_DEVICE(d);
> +    VirtIODevice *virtio_dev = virtio_bus_get_device(&vdev->bus);
>  
> -    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA);
> +    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)
> +            && virtio_queue_vector(virtio_dev, n) != VIRTIO_NO_VECTOR;
>  }
>  
>  static int virtio_ccw_get_mappings(VirtioCcwDevice *dev)
> @@ -1270,7 +1273,7 @@ static void virtio_ccw_bus_class_init(ObjectClass *klass, void *data)
>      bus_class->max_dev = 1;
>      k->notify = virtio_ccw_notify;
>      k->vmstate_change = virtio_ccw_vmstate_change;
> -    k->query_guest_notifiers = virtio_ccw_query_guest_notifiers;
> +    k->query_guest_notifiers_used = virtio_ccw_query_guest_notifiers_used;
>      k->set_guest_notifiers = virtio_ccw_set_guest_notifiers;
>      k->save_queue = virtio_ccw_save_queue;
>      k->load_queue = virtio_ccw_load_queue;
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6aa72fd434..32634da836 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1341,9 +1341,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          vhost_virtqueue_mask(dev, vdev, idx, false);
>      }
>  
> -    if (k->query_guest_notifiers &&
> -        k->query_guest_notifiers(qbus->parent) &&
> -        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
> +    if (k->query_guest_notifiers_used &&
> +        !k->query_guest_notifiers_used(qbus->parent, idx)) {
>          file.fd = -1;
>          r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
>          if (r) {
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 3ca3f849d3..25ff869618 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -30,6 +30,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "hw/pci/pci.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  #include "hw/loader.h"
> @@ -1031,7 +1032,7 @@ static void virtio_pci_one_vector_mask(VirtIOPCIProxy *proxy,
>  
>      /* If guest supports masking, keep irqfd but mask it.
>       * Otherwise, clean it up now.
> -     */ 
> +     */
>      if (vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
>          k->guest_notifier_mask(vdev, queue_no, true);
>      } else {
> @@ -1212,10 +1213,15 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
>      return 0;
>  }
>  
> -static bool virtio_pci_query_guest_notifiers(DeviceState *d)
> +static bool virtio_pci_query_guest_notifiers_used(DeviceState *d, int n)
>  {
>      VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> -    return msix_enabled(&proxy->pci_dev);
> +    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> +
> +    if (msix_enabled(&proxy->pci_dev))
> +        return virtio_queue_vector(vdev, n) != VIRTIO_NO_VECTOR;
> +    else
> +        return !pci_irq_disabled(&proxy->pci_dev);
>  }
>  
>  static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
> @@ -2599,7 +2605,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
>      k->save_extra_state = virtio_pci_save_extra_state;
>      k->load_extra_state = virtio_pci_load_extra_state;
>      k->has_extra_state = virtio_pci_has_extra_state;
> -    k->query_guest_notifiers = virtio_pci_query_guest_notifiers;
> +    k->query_guest_notifiers_used = virtio_pci_query_guest_notifiers_used;
>      k->set_guest_notifiers = virtio_pci_set_guest_notifiers;
>      k->set_host_notifier_mr = virtio_pci_set_host_notifier_mr;
>      k->vmstate_change = virtio_pci_vmstate_change;
> @@ -2630,4 +2636,3 @@ static void virtio_pci_register_types(void)
>  }
>  
>  type_init(virtio_pci_register_types)
> -
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 822fbacdf0..de4ab28046 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -256,6 +256,7 @@ void pci_del_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
>  
>  uint8_t pci_find_capability(PCIDevice *pci_dev, uint8_t cap_id);
>  
> +int pci_irq_disabled(PCIDevice *d);
>  
>  uint32_t pci_default_read_config(PCIDevice *d,
>                                   uint32_t address, int len);
> diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
> index 7ab8c9dab0..de75a44895 100644
> --- a/include/hw/virtio/virtio-bus.h
> +++ b/include/hw/virtio/virtio-bus.h
> @@ -48,7 +48,7 @@ struct VirtioBusClass {
>      int (*load_done)(DeviceState *d, QEMUFile *f);
>      int (*load_extra_state)(DeviceState *d, QEMUFile *f);
>      bool (*has_extra_state)(DeviceState *d);
> -    bool (*query_guest_notifiers)(DeviceState *d);
> +    bool (*query_guest_notifiers_used)(DeviceState *d, int n);


I don't see why we need to change the name, and you don't explain
in the commit log. The new name isn't really clear, either.


>      int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
>      int (*set_host_notifier_mr)(DeviceState *d, int n,
>                                  MemoryRegion *mr, bool assign);
> -- 
> 2.43.5


