Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DCBC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEnox-0000BJ-VH; Tue, 13 May 2025 07:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uEnow-0000AP-81; Tue, 13 May 2025 07:29:14 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uEnou-0008K4-B1; Tue, 13 May 2025 07:29:13 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30c54b40112so2544004a91.2; 
 Tue, 13 May 2025 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747135749; x=1747740549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xhmxb4a6WZjdZz3HEKgEU9W5XYrpcopDPVVKtj10jFo=;
 b=At8+QkrSURvNMZIOi07KzU9ilqjDeOcn0yjJxthonOvuXc4xsq1u75fNkzIZY75Wt4
 AhvvijFQrPSWQCAYmaBEit52aK7gH9gsHCB1evH+XsRnHdL1Y0Qxc2mTI6gMUsfpMdBO
 zDOY8Hscr6MBvIjTQh4GHiz63Y1x0Vi4GgSmHzh3LpAg8jJvC+reMttP6lcoHBbxnPHp
 e6fPLvIskAHZ2BRsLKwgNCRq2m+esn+YWtyJg88shc8fDx3M0/8NCvVbLDl6YkV6VGE0
 qLANwRNO0j0dnfPpNEPgUgzTlnOcQ3Zg2CnIXabS/e3+FyMFvkyDqeLrORj03FiI0+jX
 Qfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747135749; x=1747740549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xhmxb4a6WZjdZz3HEKgEU9W5XYrpcopDPVVKtj10jFo=;
 b=cxEmW7ZDvfdxCkVj0uUsQm7OXOjvdJtapp7FiIHfvsM86ZFypUbuGtm9V7VA+g8oCy
 g0qkLqiXKiksYwbdjGmNrpds2URY20e2ina0LntozCsrRtR9Xcp9z5U2TPK7e6njPxNt
 35YJOBXh/gOkIMdpxHXf6N6yO8gF7Xvos1hZP/akF61G9LbEhtEn9im2N7kO/eCxIEQv
 lGDeqEmc1trICXe/KZfLAQQZjLNfzbEVKfkEtPSWTDTl0F4F3e3SaHFzI6s927+rShPC
 IlS8dI2OEqWdK3E80hGilKLpI0ewrLa7dHxv1gr+nVWJbaaD4vDJ/lp/Sg8cHpcbVH3f
 pJxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGC5a7kDK0P/yDcGWOx8tH8tyWzIQlRtwKSvBX/3aSaQFb6fEK+MUtxOaDISvmAA5qe1VGfrGoUZEJVw==@nongnu.org
X-Gm-Message-State: AOJu0YyxO+7EA473GtMg4fbksSyXcabrVY4f842Yh/PwfuXVaeC/o2Tp
 F6DIfGepzHIpLxVxtTavy7PPt0ytKb+dCBSOLEkYmfPYRJ1CrnKhIBa8d0VT
X-Gm-Gg: ASbGnct7g/o3GRQ4u6AWGj/lN+GMNWtvrKckp3yN6IwXo6ccgaD9Kcfl3ts7yDYhGq0
 dfkf38ih8b8dXIVMw24LbO6sGrb0pCa7y4KMJYFwkyAK8ZIuYIvJT+UIN7kHyms1m3zGju/AI6w
 Fjr9lBCTgXIclLa7vkTDWle49rThTPmTu5HZX/1BQbJ+BvTdJ3C1Fbz3ql80/TJYgD0G8uYv5LT
 XMUvn4rHHWpwZ37d0m31TKea394QHa3pRKGQJ9GP/bUBtPi40Wqyx/U9C7LwHPtbSNNQmjQ2rAA
 OzyhEO3tRjxJyHZ7BHjFco2jmRR6N+815YkjOq4wU+zi8nc1F3s/kQSJvTaUFk2wvc5kJZFw/eW
 DkxHMim5iKSp7XVKyNfpZBIF3DomFNkEDEA==
X-Google-Smtp-Source: AGHT+IHUcIXsNN686+xZzXo4DXzzchFLYn0+OEXKusmx/4NG6kCVWWJV49gsYYenpp+bYSfxRiRz1Q==
X-Received: by 2002:a17:90b:3b91:b0:2ff:7ad4:77af with SMTP id
 98e67ed59e1d1-30c3d2e52femr22553654a91.20.1747135749382; 
 Tue, 13 May 2025 04:29:09 -0700 (PDT)
Received: from localhost.localdomain (172-234-80-15.ip.linodeusercontent.com.
 [172.234.80.15]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2349ec816esm7102821a12.22.2025.05.13.04.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 04:29:08 -0700 (PDT)
From: oenhan@gmail.com
X-Google-Original-From: hanht2@chinatelecom.cn
To: mst@redhat.com, sgarzare@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pasic@linux.ibm.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com, leiyang@redhat.com
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>,
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: [PATCH V2] vhost: Don't set vring call if guest notifier is unused
Date: Tue, 13 May 2025 19:28:25 +0800
Message-ID: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=oenhan@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Huaitong Han <hanht2@chinatelecom.cn>

The vring call fd is set even when the guest does not use MSI-X (e.g., in the
case of virtio PMD), leading to unnecessary CPU overhead for processing
interrupts.

The commit 96a3d98d2c("vhost: don't set vring call if no vector") optimized the
case where MSI-X is enabled but the queue vector is unset. However, there's an
additional case where the guest uses INTx and the INTx_DISABLED bit in the PCI
config is set, meaning that no interrupt notifier will actually be used.

In such cases, the vring call fd should also be cleared to avoid redundant
interrupt handling.

Fixes: 96a3d98d2c("vhost: don't set vring call if no vector")
Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
---
V2:
- Retain the name `query_guest_notifiers`
- All qtest/unit test cases pass
- Fix V1 patch style problems

 hw/pci/pci.c                   |  2 +-
 hw/s390x/virtio-ccw.c          |  7 +++++--
 hw/virtio/vhost.c              |  3 +--
 hw/virtio/virtio-pci.c         | 10 ++++++++--
 include/hw/pci/pci.h           |  1 +
 include/hw/virtio/virtio-bus.h |  2 +-
 6 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 352b3d12c8..45b491412a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1712,7 +1712,7 @@ static void pci_update_mappings(PCIDevice *d)
     pci_update_vga(d);
 }
 
-static inline int pci_irq_disabled(PCIDevice *d)
+int pci_irq_disabled(PCIDevice *d)
 {
     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
 }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index d2f85b39f3..632708ba4d 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
     }
 }
 
-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
+static bool virtio_ccw_query_guest_notifiers(DeviceState *d, int n)
 {
     CcwDevice *dev = CCW_DEVICE(d);
+    VirtioCcwDevice *vdev = VIRTIO_CCW_DEVICE(d);
+    VirtIODevice *virtio_dev = virtio_bus_get_device(&vdev->bus);
 
-    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA);
+    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)
+            && virtio_queue_vector(virtio_dev, n) != VIRTIO_NO_VECTOR;
 }
 
 static int virtio_ccw_get_mappings(VirtioCcwDevice *dev)
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4cae7c1664..2a9a839763 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1341,8 +1341,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     }
 
     if (k->query_guest_notifiers &&
-        k->query_guest_notifiers(qbus->parent) &&
-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
+        !k->query_guest_notifiers(qbus->parent, idx)) {
         file.fd = -1;
         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
         if (r) {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 0fa8fe4955..d62e199489 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1212,10 +1212,16 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
     return 0;
 }
 
-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
+static bool virtio_pci_query_guest_notifiers(DeviceState *d, int n)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-    return msix_enabled(&proxy->pci_dev);
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
+    if (msix_enabled(&proxy->pci_dev)) {
+        return virtio_queue_vector(vdev, n) != VIRTIO_NO_VECTOR;
+    } else {
+        return !pci_irq_disabled(&proxy->pci_dev);
+    }
 }
 
 static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c2fe6caa2c..8c24bd97db 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -668,6 +668,7 @@ void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
 
 qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
 void pci_set_irq(PCIDevice *pci_dev, int level);
+int pci_irq_disabled(PCIDevice *d);
 
 static inline void pci_irq_assert(PCIDevice *pci_dev)
 {
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 7ab8c9dab0..75d43b508a 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -48,7 +48,7 @@ struct VirtioBusClass {
     int (*load_done)(DeviceState *d, QEMUFile *f);
     int (*load_extra_state)(DeviceState *d, QEMUFile *f);
     bool (*has_extra_state)(DeviceState *d);
-    bool (*query_guest_notifiers)(DeviceState *d);
+    bool (*query_guest_notifiers)(DeviceState *d, int n);
     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
     int (*set_host_notifier_mr)(DeviceState *d, int n,
                                 MemoryRegion *mr, bool assign);
-- 
2.43.5


