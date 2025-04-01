Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EDCC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 10:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzZBc-0003dM-Px; Tue, 01 Apr 2025 06:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tzZBL-0003bT-1L
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 06:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tzZBH-00067v-La
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 06:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743504557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sw2toYEwlZpJRKO0e+Cf2aDAvTiJI909oZbTAdo38Hc=;
 b=CZsPpRjUPfa2GunSiNvfbMWaIGbV9Jwe7wTecTNRlkzVY+iARjvPhUFgizG+x2nLcolCGk
 IaXiDA9g+UBZ85mhFjA2vWokSyGc2pCIEKRMMU3O3KwNiwohZ5j12mfmfCNhBwM7AYsGoV
 gujo1QkrPvY3nATkM4vr594vXuxlHNU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-q9qV8DoENSaPMeeCz6YuFQ-1; Tue, 01 Apr 2025 06:49:16 -0400
X-MC-Unique: q9qV8DoENSaPMeeCz6YuFQ-1
X-Mimecast-MFC-AGG-ID: q9qV8DoENSaPMeeCz6YuFQ_1743504555
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39131f2bbe5so2150943f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 03:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743504554; x=1744109354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sw2toYEwlZpJRKO0e+Cf2aDAvTiJI909oZbTAdo38Hc=;
 b=g6DIwxQnOD9K0jN4mudMmAuT8OPzGHgF3wtBrUCAMD5t303GViJJAVSP4KPRdmfzX8
 c/qtvczUde+NIPeuncfajB7nmdhHZZuKf6xJBQ/0hDC5rDK/9vCJ9adJrYgGPinFYAZi
 y+ouyq16EWOqizWsr+dIf6e8DoHNmC0rjjUuKG0GARdWVHuYyoK7NxDAoOgFp5BAnAFa
 3+16Nwcq9Irm6gQMFjucutX2nxoWNvUXPHBwf1FaFdwnICiI+5Q97Qc3Uec8U4R6KEBt
 IIJ15teHLzXr0l3YdJAHRU50szCkP0EM/tB3gg/kJjFklqDN6XsxgBiZKgg3jcp61GMg
 UR5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAOtrF1+5W6aPIycHclzYkj9iTYNJvnCMgwITyeRiXp1mlL09EZ7J7AOHXH68gLpH1hRfE3qFhPW9A@nongnu.org
X-Gm-Message-State: AOJu0YwWwyXWn2CtZPHNMjL4qnTHtQu2UWV4vWHonNJTb+NZMsrBud5X
 Toj5Vz5m10lIPWR1dhTvquV+75kbCTJ1N/HrYKnsp6UTzug4FvkNn6/26jSKQzG3yRDZNCKlbfd
 xzOJdoupvUrJwUTVM5++0PSLhX87qhV3zfpxc2m7LAmtg0iXmdsP6
X-Gm-Gg: ASbGncsByx3+9ynpZbHH4JSUQjRdY8bAhIW3+r4TOwg0E05d4l7pTZ4fo/+mm3TriGy
 1Yqx3PuSzkiwg2PHUJLiPVDERdlmyLrzUJ5cKbBq2rGXZh30tXllNos9qz6RHjMT9JanfT11WGr
 YVtTQ4auNMqpQ1/u2ZAUcXRa4uY1gmfk0VLIGexK6sf2g7yeskFtuAHJYlNjKJMtFcwd2YQ6k46
 2vRu0xzFl7qblsNNIwAZGOOavgIdLK782w2qpISnAUVxHsyekbW/1mDgcQxJmS6WBqn5v73g6BN
 rTl0yS4yzYTUevcTlVOlk1fbgJKHFY+J5w5rYkm/G3+syYv3O1ElAKPyU38=
X-Received: by 2002:a05:6000:1a85:b0:391:40b8:e890 with SMTP id
 ffacd0b85a97d-39c120dd0d3mr7864549f8f.22.1743504554062; 
 Tue, 01 Apr 2025 03:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOIQCpR0FWPwUhMWEPllvx/Shqg0EJLeIv+/u9YOZ+7pCB5GSDRnj3ZKvFxRFEiVJQvXyOnA==
X-Received: by 2002:a05:6000:1a85:b0:391:40b8:e890 with SMTP id
 ffacd0b85a97d-39c120dd0d3mr7864519f8f.22.1743504553524; 
 Tue, 01 Apr 2025 03:49:13 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it.
 [87.11.6.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66a8c9sm13618325f8f.47.2025.04.01.03.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 03:49:12 -0700 (PDT)
Date: Tue, 1 Apr 2025 12:49:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: oenhan@gmail.com
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, 
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com, 
 leiyang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>, 
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: Re: [PATCH] vhost: Don't set vring call if guest notifier is unused
Message-ID: <rqx2ixzzd3vnxirsyone67udq6xjztpp2jihwa7r44ffmdtjol@lpao7euzvcvj>
References: <20250326082537.379977-1-hanht2@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250326082537.379977-1-hanht2@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 26, 2025 at 04:25:37PM +0800, oenhan@gmail.com wrote:
>From: Huaitong Han <hanht2@chinatelecom.cn>
>
>The vring call fd is set even when the guest does not use msix (e.g., in the
>case of virtio pmd), leading to unnecessary CPU overhead for processing
>interrupts. The previous patch optimized the condition where msix is 

What would be the previous patch?

If you're referencing a patch already merged, please add them in the 
same form you used in Fixes, for example:
Commit XXXXX ("vhost: ...") optimized the condition ...

>enabled
>but the queue vector is unset. However, there is a additional case where the
>guest interrupt notifier is effectively unused and the vring call fd should
>also be cleared: the guest does not use msix and the INTX_DISABLED bit in the PCI
>config is set.

I don't know this code very well, can you explain better what you are 
changing with this patch and why change the name of 
query_guest_notifiers?

>
>Fixes: 96a3d98d2c ("vhost: don't set vring call if no vector")
>
>Test result:
>https://raw.githubusercontent.com/oenhan/build_log/refs/heads/main/qemu/2503261015/build/meson-logs/testlog.txt

Does it make sense to have this link in the commit, will it always be 
accessible?

>
>Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
>Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
>Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
>---
> hw/pci/pci.c                   |  2 +-
> hw/s390x/virtio-ccw.c          |  9 ++++++---
> hw/virtio/vhost.c              |  5 ++---
> hw/virtio/virtio-pci.c         | 15 ++++++++++-----
> include/hw/pci/pci.h           |  1 +
> include/hw/virtio/virtio-bus.h |  2 +-
> 6 files changed, 21 insertions(+), 13 deletions(-)
>
>diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>index 2844ec5556..503a897528 100644
>--- a/hw/pci/pci.c
>+++ b/hw/pci/pci.c
>@@ -1719,7 +1719,7 @@ static void pci_update_mappings(PCIDevice *d)
>     pci_update_vga(d);
> }
>
>-static inline int pci_irq_disabled(PCIDevice *d)
>+int pci_irq_disabled(PCIDevice *d)
> {
>     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
> }
>diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>index 43f3b162c8..af482a22cd 100644
>--- a/hw/s390x/virtio-ccw.c
>+++ b/hw/s390x/virtio-ccw.c
>@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
>     }
> }
>
>-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
>+static bool virtio_ccw_query_guest_notifiers_used(DeviceState *d, int n)
> {
>     CcwDevice *dev = CCW_DEVICE(d);
>+    VirtioCcwDevice *vdev = VIRTIO_CCW_DEVICE(d);
>+    VirtIODevice *virtio_dev = virtio_bus_get_device(&vdev->bus);
>
>-    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA);
>+    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)
>+            && virtio_queue_vector(virtio_dev, n) != VIRTIO_NO_VECTOR;
> }
>
> static int virtio_ccw_get_mappings(VirtioCcwDevice *dev)
>@@ -1270,7 +1273,7 @@ static void virtio_ccw_bus_class_init(ObjectClass *klass, void *data)
>     bus_class->max_dev = 1;
>     k->notify = virtio_ccw_notify;
>     k->vmstate_change = virtio_ccw_vmstate_change;
>-    k->query_guest_notifiers = virtio_ccw_query_guest_notifiers;
>+    k->query_guest_notifiers_used = virtio_ccw_query_guest_notifiers_used;
>     k->set_guest_notifiers = virtio_ccw_set_guest_notifiers;
>     k->save_queue = virtio_ccw_save_queue;
>     k->load_queue = virtio_ccw_load_queue;
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 6aa72fd434..32634da836 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1341,9 +1341,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>         vhost_virtqueue_mask(dev, vdev, idx, false);
>     }
>
>-    if (k->query_guest_notifiers &&
>-        k->query_guest_notifiers(qbus->parent) &&
>-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
>+    if (k->query_guest_notifiers_used &&
>+        !k->query_guest_notifiers_used(qbus->parent, idx)) {
>         file.fd = -1;
>         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
>         if (r) {
>diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>index 3ca3f849d3..25ff869618 100644
>--- a/hw/virtio/virtio-pci.c
>+++ b/hw/virtio/virtio-pci.c
>@@ -30,6 +30,7 @@
> #include "qemu/error-report.h"
> #include "qemu/log.h"
> #include "qemu/module.h"
>+#include "hw/pci/pci.h"
> #include "hw/pci/msi.h"
> #include "hw/pci/msix.h"
> #include "hw/loader.h"
>@@ -1031,7 +1032,7 @@ static void virtio_pci_one_vector_mask(VirtIOPCIProxy *proxy,
>
>     /* If guest supports masking, keep irqfd but mask it.
>      * Otherwise, clean it up now.
>-     */
>+     */

Unrelated change.

>     if (vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
>         k->guest_notifier_mask(vdev, queue_no, true);
>     } else {
>@@ -1212,10 +1213,15 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
>     return 0;
> }
>
>-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
>+static bool virtio_pci_query_guest_notifiers_used(DeviceState *d, int n)
> {
>     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>-    return msix_enabled(&proxy->pci_dev);
>+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>+
>+    if (msix_enabled(&proxy->pci_dev))
>+        return virtio_queue_vector(vdev, n) != VIRTIO_NO_VECTOR;
>+    else
>+        return !pci_irq_disabled(&proxy->pci_dev);
> }
>
> static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
>@@ -2599,7 +2605,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
>     k->save_extra_state = virtio_pci_save_extra_state;
>     k->load_extra_state = virtio_pci_load_extra_state;
>     k->has_extra_state = virtio_pci_has_extra_state;
>-    k->query_guest_notifiers = virtio_pci_query_guest_notifiers;
>+    k->query_guest_notifiers_used = virtio_pci_query_guest_notifiers_used;
>     k->set_guest_notifiers = virtio_pci_set_guest_notifiers;
>     k->set_host_notifier_mr = virtio_pci_set_host_notifier_mr;
>     k->vmstate_change = virtio_pci_vmstate_change;
>@@ -2630,4 +2636,3 @@ static void virtio_pci_register_types(void)
> }
>
> type_init(virtio_pci_register_types)
>-
>diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>index 822fbacdf0..de4ab28046 100644
>--- a/include/hw/pci/pci.h
>+++ b/include/hw/pci/pci.h
>@@ -256,6 +256,7 @@ void pci_del_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
>
> uint8_t pci_find_capability(PCIDevice *pci_dev, uint8_t cap_id);
>
>+int pci_irq_disabled(PCIDevice *d);
>
> uint32_t pci_default_read_config(PCIDevice *d,
>                                  uint32_t address, int len);
>diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
>index 7ab8c9dab0..de75a44895 100644
>--- a/include/hw/virtio/virtio-bus.h
>+++ b/include/hw/virtio/virtio-bus.h
>@@ -48,7 +48,7 @@ struct VirtioBusClass {
>     int (*load_done)(DeviceState *d, QEMUFile *f);
>     int (*load_extra_state)(DeviceState *d, QEMUFile *f);
>     bool (*has_extra_state)(DeviceState *d);
>-    bool (*query_guest_notifiers)(DeviceState *d);
>+    bool (*query_guest_notifiers_used)(DeviceState *d, int n);
>     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
>     int (*set_host_notifier_mr)(DeviceState *d, int n,
>                                 MemoryRegion *mr, bool assign);
>-- 
>2.43.5
>


