Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31024CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCgzK-0004qb-U4; Sat, 25 Oct 2025 12:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgzI-0004pl-35
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:28 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgzG-0004DD-A6
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:27 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D9F1450C3;
 Sat, 25 Oct 2025 16:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87577C4CEFB;
 Sat, 25 Oct 2025 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761409165;
 bh=WKC2XoP7ogNZ0Xk0ShR67ol5blZ/s4E7oRn62NrbB+A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nLdE1X4jC/mvdvGZeKh4zPCgYHndGcytzbLRO1T9fLAjMFT04Sbn9r8/DNrTclPtB
 uYKBmYf3uPzbVRzjmcVfScqu5s39hiDn1gjw4QYNRaHWHjZC+tfY47dFjsJtSnFJEo
 JIOyoPAbxnrEEdV8pQTtQTV8vUkC3VglIe+knFkshxFEgx0kvFrJ21VQcLE1ms+tHa
 sHgN1vD23iaFNyJKdqYMSpiCqAl0IZYsaox3t7pR36U3fGAeZnm4HEMqadgjGlZhZf
 CkX9LPCXnBQIa0Ut0aoNLNDyHlOyN8harVi4NKC7odngnFQHWyxZWvziY0yETIgLbd
 C/X7KqWJn5E9A==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 09/11] hw/hppa: PCI devices depend on availability of PCI
 bus
Date: Sat, 25 Oct 2025 18:18:59 +0200
Message-ID: <20251025161901.32710-10-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025161901.32710-1-deller@kernel.org>
References: <20251025161901.32710-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

Only create the PCI serial ports (DIVA) and PCI network cards when there is
actually a PCI bus. The shortly added 715 machine will not have a PCI bus, so
avoid creating further PCI devices.

v2:
Clean up sequential testing of NULL pointers - as suggested by Richard

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index bec5a86f24..31eeba72b4 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -387,20 +387,22 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                         enable_lasi_lan());
     }
 
-    pci_init_nic_devices(pci_bus, mc->default_nic);
-
-    /* BMC board: HP Diva GSP */
-    dev = qdev_new("diva-gsp");
-    if (!object_property_get_bool(OBJECT(dev), "disable", NULL)) {
-        pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
-        if (!lasi_dev) {
-            /* bind default keyboard/serial to Diva card */
-            qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
-            qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
-            qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
-            qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
+    if (pci_bus) {
+        pci_init_nic_devices(pci_bus, mc->default_nic);
+
+        /* BMC board: HP Diva GSP PCI card */
+        dev = qdev_new("diva-gsp");
+        if (dev && !object_property_get_bool(OBJECT(dev), "disable", NULL)) {
+            pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
+            if (!lasi_dev) {
+                /* bind default keyboard/serial to Diva card */
+                qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
+                qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
+                qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
+                qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
+            }
+            pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
         }
-        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
     }
 
     /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
-- 
2.51.0


