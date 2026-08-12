Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70E1C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAJy-0006O3-PI; Wed, 12 Aug 2026 10:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIT-0004VX-M1; Wed, 12 Aug 2026 10:51:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIR-0006l7-Ji; Wed, 12 Aug 2026 10:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546230; bh=00hPX+P5jEouzXIl4mplysW3PYWS2MMYDONGqPZW+8E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=geTuOrhvfGqHpFSlEFQ9woQMuPIBpCpB9xeynu88nD6bwESBas5iGpM/HzpEDBIvw
 vtAncr2VG8kuKl6sIxxoDvhQcxjSET9K+9+Rgz0HFUFro9T8IvUiDQm7R5HJizLNES
 YD7yg3rIDpfDEzEuEMzM8fjrSf4wOlgsMLZuJPCnMP+OdoZL657pAWcZEgzg61Zaua
 HqEyZpQ6yNubq6PSKcuWZOSMzRx5ZtNjS/T5ZfwlqX1w4uYV6NebQjnfgy2N2xJcr9
 FK0ybG5KzfG82UvE61zi5l2mEwzywOw6AQBf/N4yCskuW5NlzUHsh33Xp6XDMo+PVo
 2/+RFUbxe5R7Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F05D81CA60F;
 Wed, 12 Aug 2026 17:50:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 569BA409D4B;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B26AE2F979; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 011/120] vfio/pci: don't narrow a failed config read
 to a plausible value
Date: Wed, 12 Aug 2026 17:47:54 +0300
Message-ID: <20260812144955.649205-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(cherry picked from commit dff528657fc114119ece1478ad845b0292a87683)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 10b21b1863c..b24c3b35113 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -331,10 +331,16 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
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
@@ -2681,6 +2687,7 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint32_t val;
     uint16_t cmd;
 
     vfio_disable_interrupts(vdev);
@@ -2689,23 +2696,34 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
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
2.47.3


