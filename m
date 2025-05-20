Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2164EC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKlv-0005pf-VQ; Tue, 20 May 2025 07:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uHKln-0005oy-T4
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uHKlj-0002ef-De
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOIZxwKbx/nM4dr/0oTTSQzM9/oZm8GOD1BZZFq4vME=;
 b=KNoDZEzd2MpwwHlC3nEcqTPlM6BKYs1sXjkuj6y0IlamoisA8QKkhhBeXOIOOZYHTa3VV5
 OMn2qAcWHuoIaUfRd57rbw96wTBvsNA87aGasWADs3GfzDmABlrycZqppvsgzFNDPFoCWT
 m4iaWA0tIDByxB8Ux2M8RDwpg3E8pfw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-cEzPkzY-POWnIsoF20dDCw-1; Tue, 20 May 2025 07:04:17 -0400
X-MC-Unique: cEzPkzY-POWnIsoF20dDCw-1
X-Mimecast-MFC-AGG-ID: cEzPkzY-POWnIsoF20dDCw_1747739057
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad53aaae592so422315266b.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739056; x=1748343856;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yOIZxwKbx/nM4dr/0oTTSQzM9/oZm8GOD1BZZFq4vME=;
 b=jrrV7clXxV0o2TIpgS5wYvkkd0bHCKcxWJQYajMCbgvBtCh7jzgGUEb69QeqeVruXT
 t1cesPxK2e2Ccp5QLTa3aPdjoSOymk5UISafwvm5RUU75Cxhmc/H8oM3NJ/fHgb4RfTX
 VIltMrscCChKCMpJBLfmcNcjBC/lkUWg06cKSwPl2l1MUnit/sHws51I5Ch73FbXB6im
 meWRZbtbYQKpElxrF2rTs2v/GlxOa7Q3nbmvmFauIaMHCtA+HDj+ZTK07J9dV/DEFExw
 D7F96J8CwWQKGqbTZqptLvBmicazkPU36PcQ0+54PLZh4JmibGi8/CQ2zZK3I7FLh6hj
 QsNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyj2dg4TXI7oCUU3pd7EwDYq/ECuUQJw6IEB64L2F7nnmdcw057niyMh469JI8ddI3U4C0qu3/r/JJ@nongnu.org
X-Gm-Message-State: AOJu0YwfaFuB5HGbsrwWZttFc81oXvfJIG7Gw/jbZAabWu0QCi4nYoNx
 tf3RWZNNdgEqybkyLYN6qcG2ZeCgellK/5MM12N6IbGKul/97Y8bkTVUdP+o3B8FYWElwGBvz+4
 +U3viOwRYr4m+kLbjAkc8AwQhYm1lpEXuTg+lDd2UnAUZm++yAfDcpUgI
X-Gm-Gg: ASbGncsddoTKsI2HPqb+XTdeQQPO4lZLj4sC37YCwDI4TELji+33IPM/X9eelbRf7/5
 DFt+qepNBEWjBG7R+pJelL5PmAe0PgFnFI+1uuo76YFkU7o2WAwe1DZGztHGAxsQ3k3O5swdTAg
 jaUKTDxRfo/nEd3Ga62sxgrw6E4w/IK1Tgi6PmwIdEmxUlztBDcwAt8rwfxQs5R8caG7YT0aSMx
 SqBmRew9l5QGOL5jRwXsz/iUJ3/0a79QCjDQFJ2+GUo/2cUIrPPJbBwG5HtujZQoei9t8VdgIu1
 Mr9WlpVmv/+GtBN5cui9tez3afWMHJsYlDE16lXFWJkKnhpnQvyRQRWFMTrH
X-Received: by 2002:a17:906:c147:b0:ad5:75da:540d with SMTP id
 a640c23a62f3a-ad575da5630mr614782666b.32.1747739056490; 
 Tue, 20 May 2025 04:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/JvXlRCW8ocdtcuV9ggEx7O8WIDXDYJ6/WpaOkKi+YElcKMLZ/V1vNTjX2fn/m5O753wleQ==
X-Received: by 2002:a17:906:c147:b0:ad5:75da:540d with SMTP id
 a640c23a62f3a-ad575da5630mr614776666b.32.1747739055828; 
 Tue, 20 May 2025 04:04:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it.
 [82.53.134.35]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d498737sm712100566b.138.2025.05.20.04.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:04:15 -0700 (PDT)
Date: Tue, 20 May 2025 13:04:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Huaitong Han <oenhan@gmail.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, 
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com, 
 leiyang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>, 
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: Re: [PATCH V2] vhost: Don't set vring call if guest notifier is unused
Message-ID: <ypbprsw5lngenryzn7txs3gpoljgxr4yso4zjqfr5467nl5bkn@k5zgrfhqagq4>
References: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
 <5cstdapha4xzmgkuja5ydxxvfgr4ux5iytex3qp65vm5hedp7s@h2mjfv72npyw>
 <CAAuJbeKtVjDzxBLkX86tHFnmXNBzTRpunAQ7WmBQXpYrSs-kig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAuJbeKtVjDzxBLkX86tHFnmXNBzTRpunAQ7WmBQXpYrSs-kig@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On Fri, May 16, 2025 at 09:03:33PM +0800, Huaitong Han wrote:
>Stefano Garzarella <sgarzare@redhat.com> 于2025年5月16日周五 16:19写道：
>>
>> On Tue, May 13, 2025 at 07:28:25PM +0800, oenhan@gmail.com wrote:
>> >From: Huaitong Han <hanht2@chinatelecom.cn>
>> >
>> >The vring call fd is set even when the guest does not use MSI-X (e.g., in the
>> >case of virtio PMD), leading to unnecessary CPU overhead for processing
>> >interrupts.
>> >
>> >The commit 96a3d98d2c("vhost: don't set vring call if no vector") optimized the
>> >case where MSI-X is enabled but the queue vector is unset. However, there's an
>> >additional case where the guest uses INTx and the INTx_DISABLED bit in the PCI
>> >config is set, meaning that no interrupt notifier will actually be used.
>> >
>> >In such cases, the vring call fd should also be cleared to avoid redundant
>> >interrupt handling.
>> >
>> >Fixes: 96a3d98d2c("vhost: don't set vring call if no vector")
>> >Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
>> >Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
>> >Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
>> >---
>> >V2:
>> >- Retain the name `query_guest_notifiers`
>> >- All qtest/unit test cases pass
>> >- Fix V1 patch style problems
>> >
>> > hw/pci/pci.c                   |  2 +-
>> > hw/s390x/virtio-ccw.c          |  7 +++++--
>> > hw/virtio/vhost.c              |  3 +--
>> > hw/virtio/virtio-pci.c         | 10 ++++++++--
>> > include/hw/pci/pci.h           |  1 +
>> > include/hw/virtio/virtio-bus.h |  2 +-
>> > 6 files changed, 17 insertions(+), 8 deletions(-)
>> >
>> >diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> >index 352b3d12c8..45b491412a 100644
>> >--- a/hw/pci/pci.c
>> >+++ b/hw/pci/pci.c
>> >@@ -1712,7 +1712,7 @@ static void pci_update_mappings(PCIDevice *d)
>> >     pci_update_vga(d);
>> > }
>> >
>> >-static inline int pci_irq_disabled(PCIDevice *d)
>> >+int pci_irq_disabled(PCIDevice *d)
>>
>> Since it was inline, will it be better to move the whole function to
>> include/hw/pci/pci.h and keep it inline?
>>
>I did try moving the function to include/hw/pci/pci.h and marking it
>inline, but ran into compilation issues due to the use of the incomplete
>PCIDevice type.
>Specifically, accessing d->config triggers the following error:
>include/hw/pci/pci.h:674:26: error: invalid use of incomplete typedef
>‘PCIDevice’
>return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
>Including hw/pci/pci_device.h in pci.h to resolve this introduces
>further issues, so I suggest to keep the function as a non-inline
>helper in the .c file.

I see. If Michael is happy with that, it's fine by me!

Thanks,
Stefano

>
>> Thanks,
>> Stefano
>>
>> > {
>> >     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
>> > }
>> >diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> >index d2f85b39f3..632708ba4d 100644
>> >--- a/hw/s390x/virtio-ccw.c
>> >+++ b/hw/s390x/virtio-ccw.c
>> >@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
>> >     }
>> > }
>> >
>> >-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
>> >+static bool virtio_ccw_query_guest_notifiers(DeviceState *d, int n)
>> > {
>> >     CcwDevice *dev = CCW_DEVICE(d);
>> >+    VirtioCcwDevice *vdev = VIRTIO_CCW_DEVICE(d);
>> >+    VirtIODevice *virtio_dev = virtio_bus_get_device(&vdev->bus);
>> >
>> >-    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA);
>> >+    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)
>> >+            && virtio_queue_vector(virtio_dev, n) != VIRTIO_NO_VECTOR;
>> > }
>> >
>> > static int virtio_ccw_get_mappings(VirtioCcwDevice *dev)
>> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> >index 4cae7c1664..2a9a839763 100644
>> >--- a/hw/virtio/vhost.c
>> >+++ b/hw/virtio/vhost.c
>> >@@ -1341,8 +1341,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>> >     }
>> >
>> >     if (k->query_guest_notifiers &&
>> >-        k->query_guest_notifiers(qbus->parent) &&
>> >-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
>> >+        !k->query_guest_notifiers(qbus->parent, idx)) {
>> >         file.fd = -1;
>> >         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
>> >         if (r) {
>> >diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> >index 0fa8fe4955..d62e199489 100644
>> >--- a/hw/virtio/virtio-pci.c
>> >+++ b/hw/virtio/virtio-pci.c
>> >@@ -1212,10 +1212,16 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
>> >     return 0;
>> > }
>> >
>> >-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
>> >+static bool virtio_pci_query_guest_notifiers(DeviceState *d, int n)
>> > {
>> >     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>> >-    return msix_enabled(&proxy->pci_dev);
>> >+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>> >+
>> >+    if (msix_enabled(&proxy->pci_dev)) {
>> >+        return virtio_queue_vector(vdev, n) != VIRTIO_NO_VECTOR;
>> >+    } else {
>> >+        return !pci_irq_disabled(&proxy->pci_dev);
>> >+    }
>> > }
>> >
>> > static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
>> >diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> >index c2fe6caa2c..8c24bd97db 100644
>> >--- a/include/hw/pci/pci.h
>> >+++ b/include/hw/pci/pci.h
>> >@@ -668,6 +668,7 @@ void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
>> >
>> > qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
>> > void pci_set_irq(PCIDevice *pci_dev, int level);
>> >+int pci_irq_disabled(PCIDevice *d);
>> >
>> > static inline void pci_irq_assert(PCIDevice *pci_dev)
>> > {
>> >diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
>> >index 7ab8c9dab0..75d43b508a 100644
>> >--- a/include/hw/virtio/virtio-bus.h
>> >+++ b/include/hw/virtio/virtio-bus.h
>> >@@ -48,7 +48,7 @@ struct VirtioBusClass {
>> >     int (*load_done)(DeviceState *d, QEMUFile *f);
>> >     int (*load_extra_state)(DeviceState *d, QEMUFile *f);
>> >     bool (*has_extra_state)(DeviceState *d);
>> >-    bool (*query_guest_notifiers)(DeviceState *d);
>> >+    bool (*query_guest_notifiers)(DeviceState *d, int n);
>> >     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
>> >     int (*set_host_notifier_mr)(DeviceState *d, int n,
>> >                                 MemoryRegion *mr, bool assign);
>> >--
>> >2.43.5
>> >
>>
>


