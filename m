Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7091AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLeY-00040k-Ht; Tue, 20 May 2025 08:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uHLeQ-0003y6-CN
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uHLeM-0006cF-Gi
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747742446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AdoCpCiFy1o+UeljfCtf+O+yxuzvwJ4gqryxhNXyh+E=;
 b=Dt0I9wmi33KwakDVT6adiRh6HqlV/BDuFG7/Mu+CvuIxj0w/8raDmrjb83/gBgu1Uyie0N
 rJqQEJjUwuRXbF4WmRv0kda2MFIKwy97RrqiQfICbW/5EnG5vUeh6IAMjHO8oh2vSGCDGU
 hm+s21OotgOPZ2Nc/N4m77nv7oKurcg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-bSoQamAYO0yFGmIAEbcC7Q-1; Tue, 20 May 2025 08:00:45 -0400
X-MC-Unique: bSoQamAYO0yFGmIAEbcC7Q-1
X-Mimecast-MFC-AGG-ID: bSoQamAYO0yFGmIAEbcC7Q_1747742444
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a1f6c5f4f2so2126479f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 05:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747742443; x=1748347243;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AdoCpCiFy1o+UeljfCtf+O+yxuzvwJ4gqryxhNXyh+E=;
 b=CG8JaYZtYuqefQAJ+CBq27XuwrdV1Wsxf00YBLxWy5mvIxdhXIUN9MAv5bxKfV1h1b
 1gNLAuYpfbVzpZCInLy14sHq280GYYF2GgamBxkjuaUbrMoKlz4Z9bdUo4nmDcADFOvb
 0Pl/SBP4/6qHqKDKL2+F8KkFnv3EH7nthtsDAtYkKxhoJoGY3TZwGWi4HiR8cSmeZMTf
 eyt/PZDHzheoA+wSImagOHME16axMsDSxqFyc38ibVy6aj4VzZtlUHhMitqxUm1U7pXY
 Hw3i2ivWcJYjTQz5Ku9rTo5NKSU/5zj4Uyj+3lFIHa9NemwKCY84YOLNhHGQYqaz7JGc
 s8FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7GMfOXf6rOJH3B9+XfaRpJs/cOkgnBjvilOylbEMKezzorFGy8NzffpqxgTeMH5BIexmwoWTpEmnd@nongnu.org
X-Gm-Message-State: AOJu0YwJiI1vqtdCaiydhlpqDKaJzufgIwbHarmzvsqW+cLuvSr+fhS8
 JsyFQHxvwAs/2BLyx9lGv8Eo4w6moS8xaVt7tS8a3ESf4E5G88m49GV77zYyVc4Rf00WRMaQY1j
 O/vzCf4/0+sZvuh1JQtkhCJKNnqQnlARwnY+YjQyXSXz/2URbUFMXTLc4UO8TI00J
X-Gm-Gg: ASbGncuQN8gm6zI+1WiFTrKBk9YyjldNJBNuS9io7Wz1zTpxLsdTqm6RFB5fhOut8mA
 ZVTfVC+2qbELBbsqzFyd3zC79iA7C4f/yU4IK+iDPioL43nMlIw0O+KLwUopkupJaL7BkAIC68w
 4Qbfls0j4UyY7Ef9XkVL5iQFKHYjWBGdl5ESL+a86oj1ABSFRy3LHTsNHhr300GUzKtM6IuLdCt
 NRf5ciIPuwCmJFqJ4cuWSkUO+ZgdytK7HsCFbR4fbpTkJlYf5425hiP2DZB8GlIljTMx1qjfN8v
X-Received: by 2002:a05:6000:40e1:b0:3a3:71fb:791a with SMTP id
 ffacd0b85a97d-3a371fb835dmr6009547f8f.55.1747742442577; 
 Tue, 20 May 2025 05:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQxAFcyWrkPzTkUqdj4l7a6o4QOANpkCf8eQPqExEhTe0+kKswr9UG4DKWIVcVDE7dPxjkQA==
X-Received: by 2002:a05:6000:40e1:b0:3a3:71fb:791a with SMTP id
 ffacd0b85a97d-3a371fb835dmr6009483f8f.55.1747742442066; 
 Tue, 20 May 2025 05:00:42 -0700 (PDT)
Received: from redhat.com ([31.187.78.34]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d1c6sm16008526f8f.2.2025.05.20.05.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:00:41 -0700 (PDT)
Date: Tue, 20 May 2025 08:00:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Huaitong Han <oenhan@gmail.com>, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pasic@linux.ibm.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com, leiyang@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>,
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: Re: [PATCH V2] vhost: Don't set vring call if guest notifier is unused
Message-ID: <20250520080030-mutt-send-email-mst@kernel.org>
References: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
 <5cstdapha4xzmgkuja5ydxxvfgr4ux5iytex3qp65vm5hedp7s@h2mjfv72npyw>
 <CAAuJbeKtVjDzxBLkX86tHFnmXNBzTRpunAQ7WmBQXpYrSs-kig@mail.gmail.com>
 <ypbprsw5lngenryzn7txs3gpoljgxr4yso4zjqfr5467nl5bkn@k5zgrfhqagq4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ypbprsw5lngenryzn7txs3gpoljgxr4yso4zjqfr5467nl5bkn@k5zgrfhqagq4>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, May 20, 2025 at 01:04:10PM +0200, Stefano Garzarella wrote:
> On Fri, May 16, 2025 at 09:03:33PM +0800, Huaitong Han wrote:
> > Stefano Garzarella <sgarzare@redhat.com> 于2025年5月16日周五 16:19写道：
> > > 
> > > On Tue, May 13, 2025 at 07:28:25PM +0800, oenhan@gmail.com wrote:
> > > >From: Huaitong Han <hanht2@chinatelecom.cn>
> > > >
> > > >The vring call fd is set even when the guest does not use MSI-X (e.g., in the
> > > >case of virtio PMD), leading to unnecessary CPU overhead for processing
> > > >interrupts.
> > > >
> > > >The commit 96a3d98d2c("vhost: don't set vring call if no vector") optimized the
> > > >case where MSI-X is enabled but the queue vector is unset. However, there's an
> > > >additional case where the guest uses INTx and the INTx_DISABLED bit in the PCI
> > > >config is set, meaning that no interrupt notifier will actually be used.
> > > >
> > > >In such cases, the vring call fd should also be cleared to avoid redundant
> > > >interrupt handling.
> > > >
> > > >Fixes: 96a3d98d2c("vhost: don't set vring call if no vector")
> > > >Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
> > > >Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
> > > >Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
> > > >---
> > > >V2:
> > > >- Retain the name `query_guest_notifiers`
> > > >- All qtest/unit test cases pass
> > > >- Fix V1 patch style problems
> > > >
> > > > hw/pci/pci.c                   |  2 +-
> > > > hw/s390x/virtio-ccw.c          |  7 +++++--
> > > > hw/virtio/vhost.c              |  3 +--
> > > > hw/virtio/virtio-pci.c         | 10 ++++++++--
> > > > include/hw/pci/pci.h           |  1 +
> > > > include/hw/virtio/virtio-bus.h |  2 +-
> > > > 6 files changed, 17 insertions(+), 8 deletions(-)
> > > >
> > > >diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > >index 352b3d12c8..45b491412a 100644
> > > >--- a/hw/pci/pci.c
> > > >+++ b/hw/pci/pci.c
> > > >@@ -1712,7 +1712,7 @@ static void pci_update_mappings(PCIDevice *d)
> > > >     pci_update_vga(d);
> > > > }
> > > >
> > > >-static inline int pci_irq_disabled(PCIDevice *d)
> > > >+int pci_irq_disabled(PCIDevice *d)
> > > 
> > > Since it was inline, will it be better to move the whole function to
> > > include/hw/pci/pci.h and keep it inline?
> > > 
> > I did try moving the function to include/hw/pci/pci.h and marking it
> > inline, but ran into compilation issues due to the use of the incomplete
> > PCIDevice type.
> > Specifically, accessing d->config triggers the following error:
> > include/hw/pci/pci.h:674:26: error: invalid use of incomplete typedef
> > ‘PCIDevice’
> > return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
> > Including hw/pci/pci_device.h in pci.h to resolve this introduces
> > further issues, so I suggest to keep the function as a non-inline
> > helper in the .c file.
> 
> I see. If Michael is happy with that, it's fine by me!
> 
> Thanks,
> Stefano
> 

I think it's fine.

> > > Thanks,
> > > Stefano
> > > 
> > > > {
> > > >     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
> > > > }
> > > >diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > > >index d2f85b39f3..632708ba4d 100644
> > > >--- a/hw/s390x/virtio-ccw.c
> > > >+++ b/hw/s390x/virtio-ccw.c
> > > >@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
> > > >     }
> > > > }
> > > >
> > > >-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
> > > >+static bool virtio_ccw_query_guest_notifiers(DeviceState *d, int n)
> > > > {
> > > >     CcwDevice *dev = CCW_DEVICE(d);
> > > >+    VirtioCcwDevice *vdev = VIRTIO_CCW_DEVICE(d);
> > > >+    VirtIODevice *virtio_dev = virtio_bus_get_device(&vdev->bus);
> > > >
> > > >-    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA);
> > > >+    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)
> > > >+            && virtio_queue_vector(virtio_dev, n) != VIRTIO_NO_VECTOR;
> > > > }
> > > >
> > > > static int virtio_ccw_get_mappings(VirtioCcwDevice *dev)
> > > >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > >index 4cae7c1664..2a9a839763 100644
> > > >--- a/hw/virtio/vhost.c
> > > >+++ b/hw/virtio/vhost.c
> > > >@@ -1341,8 +1341,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
> > > >     }
> > > >
> > > >     if (k->query_guest_notifiers &&
> > > >-        k->query_guest_notifiers(qbus->parent) &&
> > > >-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
> > > >+        !k->query_guest_notifiers(qbus->parent, idx)) {
> > > >         file.fd = -1;
> > > >         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
> > > >         if (r) {
> > > >diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > >index 0fa8fe4955..d62e199489 100644
> > > >--- a/hw/virtio/virtio-pci.c
> > > >+++ b/hw/virtio/virtio-pci.c
> > > >@@ -1212,10 +1212,16 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
> > > >     return 0;
> > > > }
> > > >
> > > >-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
> > > >+static bool virtio_pci_query_guest_notifiers(DeviceState *d, int n)
> > > > {
> > > >     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> > > >-    return msix_enabled(&proxy->pci_dev);
> > > >+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> > > >+
> > > >+    if (msix_enabled(&proxy->pci_dev)) {
> > > >+        return virtio_queue_vector(vdev, n) != VIRTIO_NO_VECTOR;
> > > >+    } else {
> > > >+        return !pci_irq_disabled(&proxy->pci_dev);
> > > >+    }
> > > > }
> > > >
> > > > static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
> > > >diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > >index c2fe6caa2c..8c24bd97db 100644
> > > >--- a/include/hw/pci/pci.h
> > > >+++ b/include/hw/pci/pci.h
> > > >@@ -668,6 +668,7 @@ void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
> > > >
> > > > qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
> > > > void pci_set_irq(PCIDevice *pci_dev, int level);
> > > >+int pci_irq_disabled(PCIDevice *d);
> > > >
> > > > static inline void pci_irq_assert(PCIDevice *pci_dev)
> > > > {
> > > >diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
> > > >index 7ab8c9dab0..75d43b508a 100644
> > > >--- a/include/hw/virtio/virtio-bus.h
> > > >+++ b/include/hw/virtio/virtio-bus.h
> > > >@@ -48,7 +48,7 @@ struct VirtioBusClass {
> > > >     int (*load_done)(DeviceState *d, QEMUFile *f);
> > > >     int (*load_extra_state)(DeviceState *d, QEMUFile *f);
> > > >     bool (*has_extra_state)(DeviceState *d);
> > > >-    bool (*query_guest_notifiers)(DeviceState *d);
> > > >+    bool (*query_guest_notifiers)(DeviceState *d, int n);
> > > >     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
> > > >     int (*set_host_notifier_mr)(DeviceState *d, int n,
> > > >                                 MemoryRegion *mr, bool assign);
> > > >--
> > > >2.43.5
> > > >
> > > 
> > 


