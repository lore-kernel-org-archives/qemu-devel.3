Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E281C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ03-0003le-OT; Mon, 27 Jan 2025 09:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPzv-0003Lr-CE; Mon, 27 Jan 2025 09:21:55 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPzs-0002pp-Dn; Mon, 27 Jan 2025 09:21:55 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 36A99E0F48;
 Mon, 27 Jan 2025 17:21:25 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id AB10851DA7; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sebastian Ott <sebott@redhat.com>,
 Zhenyu Zhang <zhenyzha@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 33/41] pci: ensure valid link status bits for
 downstream ports
Date: Mon, 27 Jan 2025 17:17:47 +0300
Message-Id: <20250127141803.3514882-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sebastian Ott <sebott@redhat.com>

PCI hotplug for downstream endpoints on arm fails because Linux'
PCIe hotplug driver doesn't like the QEMU provided LNKSTA:

  pcieport 0000:08:01.0: pciehp: Slot(2): Card present
  pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
  pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000

There's 2 cases where LNKSTA isn't setup properly:
* the downstream device has no express capability
* max link width of the bridge is 0

Move the sanity checks added via 88c869198aa63
("pci: Sanity test minimum downstream LNKSTA") outside of the
branch to make sure downstream ports always have a valid LNKSTA.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
Message-Id: <20241203121928.14861-1-sebott@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 694632fd44987cc4618612a38ad151047524a590)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 0b455c8654..1b12db6fa2 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1113,18 +1113,22 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
         if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
             lnksta &= ~PCI_EXP_LNKSTA_NLW;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
-        } else if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
         }
 
         if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
             lnksta &= ~PCI_EXP_LNKSTA_CLS;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
-        } else if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
         }
     }
 
+    if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
+    }
+
+    if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
+    }
+
     pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
                                  PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
     pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA, lnksta &
-- 
2.39.5


