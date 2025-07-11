Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AA6C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua96E-0002eH-6q; Fri, 11 Jul 2025 04:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8y2-0005VC-2H; Fri, 11 Jul 2025 04:18:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xy-00042m-IE; Fri, 11 Jul 2025 04:18:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E37C81356D7;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D7A4323FA4C;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>,
 Jidong Xia <xiajd@chinatelecom.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 12/39] vhost: Don't set vring call if guest notifier
 is unused
Date: Fri, 11 Jul 2025 11:16:08 +0300
Message-ID: <20250711081745.1785806-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Message-Id: <20250522100548.212740-1-hanht2@chinatelecom.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit a9403bfcd93025df7b1924d0cf34fbc408955b33)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2844ec5556..503a897528 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1719,7 +1719,7 @@ static void pci_update_mappings(PCIDevice *d)
     pci_update_vga(d);
 }
 
-static inline int pci_irq_disabled(PCIDevice *d)
+int pci_irq_disabled(PCIDevice *d)
 {
     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
 }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3ca3f849d3..e60ad843fc 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1215,7 +1215,12 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
 static bool virtio_pci_query_guest_notifiers(DeviceState *d)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-    return msix_enabled(&proxy->pci_dev);
+
+    if (msix_enabled(&proxy->pci_dev)) {
+        return true;
+    } else {
+        return pci_irq_disabled(&proxy->pci_dev);
+    }
 }
 
 static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 822fbacdf0..7e382552b9 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -668,6 +668,7 @@ void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
 
 qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
 void pci_set_irq(PCIDevice *pci_dev, int level);
+int pci_irq_disabled(PCIDevice *d);
 
 static inline void pci_irq_assert(PCIDevice *pci_dev)
 {
-- 
2.47.2


