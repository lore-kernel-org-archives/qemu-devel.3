Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7930C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC0i-0007Rb-MO; Thu, 06 Mar 2025 09:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0E-000744-V6
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0C-0001mB-OV
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWRgq8lQFjl5YTPNjjtxvseUG3VlTRuWZlzIlG7saZ4=;
 b=Q6C/DfdqLwbMl/q+WMZUgTKfkx2Iqiwr4TadXPZ9AisCPcc+sLmTAvxufkLJwN/D+lr7i0
 2beu92Cu64X0Y5I8lj+v5q9euqS6nfpJruqx3jiFHxeaHBafixhYhsogYK9NLrdS71O1bJ
 lweHVVvQGXvjR8Czt9Ue5V6JsamZL9M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-ZY6_RaIMN6uhBnTQ9n42sA-1; Thu,
 06 Mar 2025 09:14:51 -0500
X-MC-Unique: ZY6_RaIMN6uhBnTQ9n42sA-1
X-Mimecast-MFC-AGG-ID: ZY6_RaIMN6uhBnTQ9n42sA_1741270490
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60A0519560B3; Thu,  6 Mar 2025 14:14:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 024FA180174D; Thu,  6 Mar 2025 14:14:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/42] pcie, virtio: Remove redundant pm_cap
Date: Thu,  6 Mar 2025 15:13:42 +0100
Message-ID: <20250306141419.2015340-7-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Alex Williamson <alex.williamson@redhat.com>

The pm_cap on the PCIExpressDevice object can be distilled down
to the new instance on the PCIDevice object.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250225215237.3314011-5-alex.williamson@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci/pcie.h           | 2 --
 hw/pci-bridge/pcie_pci_bridge.c | 1 -
 hw/virtio/virtio-pci.c          | 8 +++-----
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index b8d59732bc636971b0640e63f036c994a65db932..70a5de09de3952feb4488f8eebe78f4dbf8d930d 100644
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
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 9fa656b43b42624fd597ec6df5d986e71e5f06f0..2429503cfbbf5aaa8977c053226dc436d3f3dded 100644
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
index afe8b5551c5cc5d33a184f25ac05efa2c126e796..3ca3f849d39157b39a09f4174db22487f627c709 100644
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
-- 
2.48.1


