Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7384C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDuU-0004nF-BX; Tue, 21 Jul 2026 13:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuS-0004mg-Lh
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuQ-00073T-St
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784653534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4AlBhhCQddSb59LxPp1ggPvA1JZHINheOT6h06v9+KI=;
 b=bAtVHNgHPGM3ACEq6Fx5q/EWHe2dmlzPs64UB0Pkc/p7Xoevki2Avz2PrNL3hXEihimZZH
 +1UVUvJxCRCWG8xGDME2S17cEB6GFpibvtlGPYDHfEZ+RU6FEWjn+tju7tUgBTRTQ41nkw
 OOiIh7/bf34IYOtOVxr5Qj22jriZxZk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-d30PyiLhMPySIuWqsQKwJA-1; Tue,
 21 Jul 2026 13:05:30 -0400
X-MC-Unique: d30PyiLhMPySIuWqsQKwJA-1
X-Mimecast-MFC-AGG-ID: d30PyiLhMPySIuWqsQKwJA_1784653529
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5F42180AA93; Tue, 21 Jul 2026 17:05:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2998E1598; Tue, 21 Jul 2026 17:05:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/13] vfio/pci: don't narrow a failed config read to a
 plausible value
Date: Tue, 21 Jul 2026 19:05:08 +0200
Message-ID: <20260721170518.4160785-4-clg@redhat.com>
In-Reply-To: <20260721170518.4160785-1-clg@redhat.com>
References: <20260721170518.4160785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Denis V. Lunev" <den@openvz.org>

vfio_pci_read_config() signals a failed host-side read by returning
(uint32_t)-1, regardless of the requested length. vfio_intx_enable()
and vfio_pci_pre_reset() both narrowed that return value straight
into a uint8_t/uint16_t local before checking anything, which
truncates -1 into 0xff or 0xffff - values a real 1- or 2-byte
register read can legitimately produce. From that point on, a
failed read and real all-ones content are indistinguishable.

Keep the full uint32_t result and check it against (uint32_t)-1
before narrowing. In vfio_pci_pre_reset(), skip the corresponding
write-back on a failed read instead of writing back constructed
garbage to the device.

Resolves: Coverity CID 1663684
Resolves: Coverity CID 1663688
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Alex Williamson <alex@shazbot.org>
CC: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260717122232.468955-2-den@openvz.org
[ clg: Added Coverity IDs ]
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index dcfc92aae1c78d3a803665bcaea1e83f66a6d030..b8c937d4be50091691875f2253c4d03ba83df704 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -323,10 +323,16 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
 static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
-    uint8_t pin = vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1);
+    uint32_t val = vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1);
+    uint8_t pin;
     Error *err = NULL;
     int32_t fd;
 
+    if (val == (uint32_t)-1) {
+        error_setg(errp, "failed to read PCI_INTERRUPT_PIN");
+        return false;
+    }
+    pin = val;
 
     if (!pin) {
         return true;
@@ -2766,6 +2772,7 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint32_t val;
     uint16_t cmd;
 
     vfio_disable_interrupts(vdev);
@@ -2774,23 +2781,34 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
      * Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master.
      * Also put INTx Disable in known state.
      */
-    cmd = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
-    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
-             PCI_COMMAND_INTX_DISABLE);
-    vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
+    val = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
+    if (val != (uint32_t)-1) {
+        cmd = val;
+        cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
+                 PCI_COMMAND_INTX_DISABLE);
+        vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
+    }
 
     /* Make sure the device is in D0 */
     if (pdev->pm_cap) {
         uint16_t pmcsr;
         uint8_t state;
 
-        pmcsr = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
+        val = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
+        if (val == (uint32_t)-1) {
+            return;
+        }
+        pmcsr = val;
         state = pmcsr & PCI_PM_CTRL_STATE_MASK;
         if (state) {
             pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
             vfio_pci_write_config(pdev, pdev->pm_cap + PCI_PM_CTRL, pmcsr, 2);
             /* vfio handles the necessary delay here */
-            pmcsr = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
+            val = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
+            if (val == (uint32_t)-1) {
+                return;
+            }
+            pmcsr = val;
             state = pmcsr & PCI_PM_CTRL_STATE_MASK;
             if (state) {
                 error_report("vfio: Unable to power on device, stuck in D%d",
-- 
2.55.0


