Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DC3CA0FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHia-0005Sd-Ln; Wed, 27 Aug 2025 11:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHiA-00056H-Vu; Wed, 27 Aug 2025 11:05:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHi8-0004yc-QU; Wed, 27 Aug 2025 11:05:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0229114C53F;
 Wed, 27 Aug 2025 18:02:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E3A2C269847;
 Wed, 27 Aug 2025 18:03:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Corentin BAYET <corentin.bayet@reversetactics.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 23/59] pcie_sriov: Fix configuration and state
 synchronization
Date: Wed, 27 Aug 2025 18:02:28 +0300
Message-ID: <20250827150323.2694101-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Fix issues in PCIe SR-IOV configuration register handling that caused
inconsistent internal state due to improper write mask handling and
incorrect migration behavior.

Two main problems were identified:

1. VF Enable bit write mask handling:
   pcie_sriov_config_write() incorrectly assumed that its val parameter
   was already masked, causing it to ignore the actual write mask.
   This led to the VF Enable bit being processed even when masked,
   resulting in incorrect VF registration/unregistration. It is
   identified as CVE-2025-54567.

2. Migration state inconsistency:
   pcie_sriov_pf_post_load() unconditionally called register_vfs()
   regardless of the VF Enable bit state, creating inconsistent
   internal state when VFs should not be enabled. Additionally,
   it failed to properly update the NumVFs write mask based on
   the current configuration. It is identified as CVE-2025-54566.

Root cause analysis revealed that both functions relied on incorrect
special-case assumptions instead of properly reading and consuming
the actual configuration values. This change introduces a unified
consume_config() function that reads actual configuration values and
synchronize the internal state without special-case assumptions.

The solution only adds register read overhead in non-hot-path code
while ensuring correct SR-IOV state management across configuration
writes and migration scenarios.

Fixes: 5e7dd17e4348 ("pcie_sriov: Remove num_vfs from PCIESriovPF")
Fixes: f9efcd47110d ("pcie_sriov: Register VFs after migration")
Fixes: CVE-2025-54566
Fixes: CVE-2025-54567
Cc: qemu-stable@nongnu.org
Reported-by: Corentin BAYET <corentin.bayet@reversetactics.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-Id: <20250727-wmask-v2-1-394910b1c0b6@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit cad9aa6fbdccd95e56e10cfa57c354a20a333717)
(Mjt: context fix)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 1eb4358256..dd4fbaea46 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -211,6 +211,27 @@ static void unregister_vfs(PCIDevice *dev)
     pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
 }
 
+static void consume_config(PCIDevice *dev)
+{
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+
+    if (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) {
+        register_vfs(dev);
+    } else {
+        uint8_t *wmask = dev->wmask + dev->exp.sriov_cap;
+        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
+        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
+
+        unregister_vfs(dev);
+
+        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
+            wmask_val |= PCI_SRIOV_CTRL_VFE;
+        }
+
+        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
+    }
+}
+
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              uint32_t val, int len)
 {
@@ -228,30 +249,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
     trace_sriov_config_write(dev->name, PCI_SLOT(dev->devfn),
                              PCI_FUNC(dev->devfn), off, val, len);
 
-    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
-        if (val & PCI_SRIOV_CTRL_VFE) {
-            register_vfs(dev);
-        } else {
-            unregister_vfs(dev);
-        }
-    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
-        uint8_t *cfg = dev->config + sriov_cap;
-        uint8_t *wmask = dev->wmask + sriov_cap;
-        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
-        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
-
-        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
-            wmask_val |= PCI_SRIOV_CTRL_VFE;
-        }
-
-        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
-    }
+    consume_config(dev);
 }
 
 void pcie_sriov_pf_post_load(PCIDevice *dev)
 {
     if (dev->exp.sriov_cap) {
-        register_vfs(dev);
+        consume_config(dev);
     }
 }
 
-- 
2.47.2


