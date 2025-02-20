Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9B4C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 22:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlFMq-0000Yy-WB; Thu, 20 Feb 2025 17:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tlFMm-0000XY-RS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:50:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tlFMh-0007hu-5P
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740091791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdW+F9nLbuh43lolz8i1mClmo2y6BBEvnDC5JPHDA3M=;
 b=aO47mdnHLJZrdv9JvltKIzflh1WTSQcCMly6uO+awdwKGMAtsXrD3dp+P/6f+kWO8UQrb8
 CEfD+XRzPi+u5fq9hLwIy5fGtbswsKoXmUlol4jSYohci1H4fuo05EWGK+IL+2GhtmUbSx
 Rg9/Zv69RSTHy2KUMMAAAbod9zc4CCA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-22JjGaJ4ObSKS6_Eq7GFZg-1; Thu,
 20 Feb 2025 17:49:48 -0500
X-MC-Unique: 22JjGaJ4ObSKS6_Eq7GFZg-1
X-Mimecast-MFC-AGG-ID: 22JjGaJ4ObSKS6_Eq7GFZg_1740091787
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E81BA1955F28; Thu, 20 Feb 2025 22:49:46 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.77])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39F321955BCB; Thu, 20 Feb 2025 22:49:44 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, clg@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: [PATCH 4/5] pcie, virtio: Remove redundant pm_cap
Date: Thu, 20 Feb 2025 15:48:57 -0700
Message-ID: <20250220224918.2520417-5-alex.williamson@redhat.com>
In-Reply-To: <20250220224918.2520417-1-alex.williamson@redhat.com>
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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

The pm_cap on the PCIExpressDevice object can be distilled down
to the new instance on the PCIDevice object.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci-bridge/pcie_pci_bridge.c | 1 -
 hw/virtio/virtio-pci.c          | 8 +++-----
 include/hw/pci/pcie.h           | 2 --
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 9fa656b43b42..2429503cfbbf 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -56,7 +56,6 @@ static void pcie_pci_bridge_realize(PCIDevice *d, Error **errp)
     if (pos < 0) {
         goto pm_error;
     }
-    d->exp.pm_cap = pos;
     pci_set_word(d->config + pos + PCI_PM_PMC, 0x3);
 
     pcie_cap_arifwd_init(d);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index afe8b5551c5c..3ca3f849d391 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2209,8 +2209,6 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
             return;
         }
 
-        pci_dev->exp.pm_cap = pos;
-
         /*
          * Indicates that this function complies with revision 1.2 of the
          * PCI Power Management Interface Specification.
@@ -2309,11 +2307,11 @@ static bool virtio_pci_no_soft_reset(PCIDevice *dev)
 {
     uint16_t pmcsr;
 
-    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
+    if (!pci_is_express(dev) || !(dev->cap_present & QEMU_PCI_CAP_PM)) {
         return false;
     }
 
-    pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
+    pmcsr = pci_get_word(dev->config + dev->pm_cap + PCI_PM_CTRL);
 
     /*
      * When No_Soft_Reset bit is set and the device
@@ -2342,7 +2340,7 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
             pci_word_test_and_clear_mask(
-                dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
+                dev->config + dev->pm_cap + PCI_PM_CTRL,
                 PCI_PM_CTRL_STATE_MASK);
         }
     }
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index b8d59732bc63..70a5de09de39 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -58,8 +58,6 @@ typedef enum {
 struct PCIExpressDevice {
     /* Offset of express capability in config space */
     uint8_t exp_cap;
-    /* Offset of Power Management capability in config space */
-    uint8_t pm_cap;
 
     /* SLOT */
     bool hpev_notified; /* Logical AND of conditions for hot plug event.
-- 
2.48.1


