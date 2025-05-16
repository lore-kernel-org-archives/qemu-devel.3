Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168A8C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqIQ-0005HQ-L2; Fri, 16 May 2025 04:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uFqIP-0005Et-0v
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uFqIN-0003vN-1u
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747383593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5tvqr2imsN4syoq3Q6UclwhXS7dtpzq8TVYqwd30QpA=;
 b=e0X3moPQTe0p/2Ulh9VZhUnG6mqJsVFrW9FRzBiLGVvi50V1sW3HxYUsQW3+i/D+szDAPT
 2Ba861XDon3PELebh7PmSzxTbIsI2CF7yYZBajfWNS3eko5lgvNKahXhEdKa2YT0Gysztn
 ojJXxbhF9//6DcQyPff2hCNKiUGf6j8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-GoIY1il1OHSnGtrOJ0-9uQ-1; Fri, 16 May 2025 04:19:52 -0400
X-MC-Unique: GoIY1il1OHSnGtrOJ0-9uQ-1
X-Mimecast-MFC-AGG-ID: GoIY1il1OHSnGtrOJ0-9uQ_1747383591
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a362939f61so120012f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 01:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383591; x=1747988391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5tvqr2imsN4syoq3Q6UclwhXS7dtpzq8TVYqwd30QpA=;
 b=ecU3Jb9om5IYpRPAFtDXym0Am8JZ/2eNCZajzqgKChsoKW/bVhY1c/wwt5DW6SMhwD
 +WEScfOHbsd2zPfZZrKEu60C1Ie/jgpzXI4eBEvBNmQtwkg2rj8lxmKshgBjA3EqXcfG
 5b4puNVvwNxQO3nhsOt501iXK2YqQ8osGQoM2/djAISZc5CANQ+WzztxWHknbBR/puHJ
 QeDkC7u6swrKlPkDDj7JYN1xBKipEvybYJPqRjGY1tosSOeX6oZClhVZGnZmOsDn6sx4
 SDLF9qRIzkzjrC/pXRJv5P/bAn2qkCYDZDSG4aFi48+V+koRRr4XgaEs3DDLLQr3IL5q
 Bf0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8/u8JZToMIyPMb7Lo7dlat530LrzhYmpPOEhabUlmkLfU9DoPNBadrn+7XrFvN/3dhJbaKvfM/wfN@nongnu.org
X-Gm-Message-State: AOJu0YyDIaeJoFeDwgAkNpk+QFkX7GPA/BisXVf4db9ZJplW6t6TchlG
 jtwXF9ihXu2PmVBbj/78zsxkOgv9xXlWlQnJSEyxyEC2Af0cBMaK6ruhyhWlM4J/IwyFcVx3Rqi
 1S6MOClk14nJRq0w1/kkM7ZDiXq7HYH8cUFIKAvY5OwO9agMWmkWMGkyw
X-Gm-Gg: ASbGncsMte1lolQChxeIQKHXXiic+TX+omwN1NKeQitq/BifD+TqccXdwZYsvSIyA7Y
 SrkXzHIRryNdk2QfZ6dAbFzRKxK15UyYNpPkehsY+C78Qk4gpRr+a44fV+b5Gld40KsZHMS+Xgt
 PuIMIAuKLdi8E5wRLsvQkwHftzUajMe+fWe8q7lzw4p6YHn1wrPhVBpMDawfsHbzvVAlmNVscNP
 ALLmvyvNW1nje6rb9ebh4+clq3wk5WDK7htmQOvMsNeQR9MZG5vf5c6VsffPs2pK3BKGxjFnV4K
 gm4/X5ZEfD4W85XjbQ==
X-Received: by 2002:a05:6000:2902:b0:3a2:35c:4471 with SMTP id
 ffacd0b85a97d-3a3601dc079mr1474984f8f.56.1747383590834; 
 Fri, 16 May 2025 01:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiZTSoo4/+61Q+ULhgSOGzZmomKT+SASsN/0vYn6s7SHv2Wa+nuWRVIoa7szb65uGm+x0KaA==
X-Received: by 2002:a05:6000:2902:b0:3a2:35c:4471 with SMTP id
 ffacd0b85a97d-3a3601dc079mr1474943f8f.56.1747383590290; 
 Fri, 16 May 2025 01:19:50 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.220.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889d9sm2045368f8f.77.2025.05.16.01.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:19:48 -0700 (PDT)
Date: Fri, 16 May 2025 10:19:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: oenhan@gmail.com
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, 
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com, 
 leiyang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>, 
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: Re: [PATCH V2] vhost: Don't set vring call if guest notifier is unused
Message-ID: <5cstdapha4xzmgkuja5ydxxvfgr4ux5iytex3qp65vm5hedp7s@h2mjfv72npyw>
References: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Tue, May 13, 2025 at 07:28:25PM +0800, oenhan@gmail.com wrote:
>From: Huaitong Han <hanht2@chinatelecom.cn>
>
>The vring call fd is set even when the guest does not use MSI-X (e.g., in the
>case of virtio PMD), leading to unnecessary CPU overhead for processing
>interrupts.
>
>The commit 96a3d98d2c("vhost: don't set vring call if no vector") optimized the
>case where MSI-X is enabled but the queue vector is unset. However, there's an
>additional case where the guest uses INTx and the INTx_DISABLED bit in the PCI
>config is set, meaning that no interrupt notifier will actually be used.
>
>In such cases, the vring call fd should also be cleared to avoid redundant
>interrupt handling.
>
>Fixes: 96a3d98d2c("vhost: don't set vring call if no vector")
>Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
>Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
>Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
>---
>V2:
>- Retain the name `query_guest_notifiers`
>- All qtest/unit test cases pass
>- Fix V1 patch style problems
>
> hw/pci/pci.c                   |  2 +-
> hw/s390x/virtio-ccw.c          |  7 +++++--
> hw/virtio/vhost.c              |  3 +--
> hw/virtio/virtio-pci.c         | 10 ++++++++--
> include/hw/pci/pci.h           |  1 +
> include/hw/virtio/virtio-bus.h |  2 +-
> 6 files changed, 17 insertions(+), 8 deletions(-)
>
>diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>index 352b3d12c8..45b491412a 100644
>--- a/hw/pci/pci.c
>+++ b/hw/pci/pci.c
>@@ -1712,7 +1712,7 @@ static void pci_update_mappings(PCIDevice *d)
>     pci_update_vga(d);
> }
>
>-static inline int pci_irq_disabled(PCIDevice *d)
>+int pci_irq_disabled(PCIDevice *d)

Since it was inline, will it be better to move the whole function to 
include/hw/pci/pci.h and keep it inline?

Thanks,
Stefano

> {
>     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
> }
>diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>index d2f85b39f3..632708ba4d 100644
>--- a/hw/s390x/virtio-ccw.c
>+++ b/hw/s390x/virtio-ccw.c
>@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
>     }
> }
>
>-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
>+static bool virtio_ccw_query_guest_notifiers(DeviceState *d, int n)
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
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 4cae7c1664..2a9a839763 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1341,8 +1341,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>     }
>
>     if (k->query_guest_notifiers &&
>-        k->query_guest_notifiers(qbus->parent) &&
>-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
>+        !k->query_guest_notifiers(qbus->parent, idx)) {
>         file.fd = -1;
>         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
>         if (r) {
>diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>index 0fa8fe4955..d62e199489 100644
>--- a/hw/virtio/virtio-pci.c
>+++ b/hw/virtio/virtio-pci.c
>@@ -1212,10 +1212,16 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
>     return 0;
> }
>
>-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
>+static bool virtio_pci_query_guest_notifiers(DeviceState *d, int n)
> {
>     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>-    return msix_enabled(&proxy->pci_dev);
>+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>+
>+    if (msix_enabled(&proxy->pci_dev)) {
>+        return virtio_queue_vector(vdev, n) != VIRTIO_NO_VECTOR;
>+    } else {
>+        return !pci_irq_disabled(&proxy->pci_dev);
>+    }
> }
>
> static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
>diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>index c2fe6caa2c..8c24bd97db 100644
>--- a/include/hw/pci/pci.h
>+++ b/include/hw/pci/pci.h
>@@ -668,6 +668,7 @@ void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
>
> qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
> void pci_set_irq(PCIDevice *pci_dev, int level);
>+int pci_irq_disabled(PCIDevice *d);
>
> static inline void pci_irq_assert(PCIDevice *pci_dev)
> {
>diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
>index 7ab8c9dab0..75d43b508a 100644
>--- a/include/hw/virtio/virtio-bus.h
>+++ b/include/hw/virtio/virtio-bus.h
>@@ -48,7 +48,7 @@ struct VirtioBusClass {
>     int (*load_done)(DeviceState *d, QEMUFile *f);
>     int (*load_extra_state)(DeviceState *d, QEMUFile *f);
>     bool (*has_extra_state)(DeviceState *d);
>-    bool (*query_guest_notifiers)(DeviceState *d);
>+    bool (*query_guest_notifiers)(DeviceState *d, int n);
>     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
>     int (*set_host_notifier_mr)(DeviceState *d, int n,
>                                 MemoryRegion *mr, bool assign);
>-- 
>2.43.5
>


