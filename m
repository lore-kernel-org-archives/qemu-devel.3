Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E9DC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLLo-0008O3-HX; Tue, 20 May 2025 07:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uHLLZ-0008MX-Ih
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uHLLT-00033q-44
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747741276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5i4Y7k2uui7OdsUwBkGkkZIH49rdaSoxdr+eV+BNJY4=;
 b=T2fO/+7FemUCT4D7/Us3ztgxX27yTENwkRG2Gnu3rEYbHqYMMJ7+j+r3rSc1yrbdLX88zH
 HKbUlkMGfFuPRb0xxiKeoeUdATjKw07FcWK7xbzMERYKi2W8YZxzfeJj2YNeLo1HE0l19x
 4y0S0O8vwEkwCHIoXAQCTtOAUH/ftjM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-gqXn_FHBNk2DQC4FCoG_DA-1; Tue, 20 May 2025 07:41:14 -0400
X-MC-Unique: gqXn_FHBNk2DQC4FCoG_DA-1
X-Mimecast-MFC-AGG-ID: gqXn_FHBNk2DQC4FCoG_DA_1747741274
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-601c0493731so1299294a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747741273; x=1748346073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5i4Y7k2uui7OdsUwBkGkkZIH49rdaSoxdr+eV+BNJY4=;
 b=poLKyGKvbRDLtlInaCwIPSAo65jdZLL/1NGU6r0fplPj3VOGViUpNWMv5fd+HfSUnT
 qmAg9c6EASJE2zpC605f+YqVEKhbuYzkVrr6ekXj3QOmL1aIPvkUySM8S1emDYQFOhEK
 STUgRi0uUr2k7qapwVLQGNOBkxiEixDAcM4OWlBgWV9Wzydgkm95X+9O+qmRsgvv8KBn
 NNqZ1U6XuCcO2PpGekSe7ionVm1m7kULtI7NBED0TsvRRdSMKytaThvNaTFpPk3vt0Ij
 GcoKlqHBUfG9GHV/H4U0tlKsTSgFgBv2AOcQ7dzVH630893nodiJyh28AgF/ZBmhap3s
 oFIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbDVlGPuuOcBjCx3T5xpnpZNAgO5uoc5atL7MGcD2pteQ/iEeLDIwnLNgeivxsouTWTiLxay3Ar9zS@nongnu.org
X-Gm-Message-State: AOJu0Yz8M32FPXJLUa/wUHSTjUEYP+TZTMwSJnI0bTpn7mKL93sFepLm
 gXXd8g+qGlUuNRo3Q2Q786kttZc3bhPwFCq8i9mWSfIT7I5v6njRBhJ3FwtEebobQ4Zc+bLDhAj
 QZY3FYEvm01j1pcyWeDEqa2/vBhaNjl6MGNvf8ZwyJDmxleSrsHZprreV
X-Gm-Gg: ASbGncsJdzxul8fSglx7UEhXqkQG9lmxLizkAExw+iYdb1mkK7wGSbr050rPsZlu+eE
 RDZq0fA76XdMPkSI2pQCLZxFKa0Dpgxi1xLK5hqVW1TkvyVe1Y1rmhgRS/VzRPbQ7zLx25turty
 y4x7OamAqmu5LjEz8SxdpQ0IBRfDZuYJeOTqkl9NxxEydBbqiERg3X8GJeekQQgep5+GdCdBGVL
 9z/1R8rQ4cgbh6j0YxP0zECiIYMJiWP6IYIOL9wQb2XurdKr1dzu5JhA/UC1SHhPYzbA9zi1SaC
 nRT7J+MRsPskNDx1+UXJuUpHEEiVAZq+tUHncicT8lGOeFzYkxmpewJutLJ7
X-Received: by 2002:a05:6402:13cf:b0:601:fd36:6ee1 with SMTP id
 4fb4d7f45d1cf-601fd367865mr4721683a12.0.1747741273542; 
 Tue, 20 May 2025 04:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnZwAioUqzoVdZhAjrcTnSCzlu7P7QmebOT2m8uY8E9zPW4ItyiNRKXpb7R8Ma/73iHDSWZA==
X-Received: by 2002:a05:6402:13cf:b0:601:fd36:6ee1 with SMTP id
 4fb4d7f45d1cf-601fd367865mr4721641a12.0.1747741272919; 
 Tue, 20 May 2025 04:41:12 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it.
 [82.53.134.35]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ac33757sm7035640a12.59.2025.05.20.04.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:41:12 -0700 (PDT)
Date: Tue, 20 May 2025 13:41:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: oenhan@gmail.com
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, 
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com, 
 leiyang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>, 
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: Re: [PATCH V2] vhost: Don't set vring call if guest notifier is unused
Message-ID: <dmtvkhqkwdv7rzum6c4gs3uiekwckou3yp7w2ql6tijxshoiju@w4rplxvassk6>
References: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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
                   ^
nit: there should be a space here.

If you need to resend, I think you can fix also the one in the 
description.

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

Why are we moving this check in every callback, can't we leave it as 
before in vhost.c and here return true?

I mean here:
     if (msix_enabled(&proxy->pci_dev)) {
         return true;
     } else {
         return !pci_irq_disabled(&proxy->pci_dev);
     }

and leave vhost.c untouched.

Thanks,
Stefano

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


