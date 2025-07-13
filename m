Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1920FC83F17
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 09:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uat0M-0004bG-8X; Sun, 13 Jul 2025 05:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uat0J-0004Yw-Qw
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 05:28:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uat0G-0002aQ-OH
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 05:28:15 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56D9RfVa069508
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 13 Jul 2025 18:28:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=S/p7QBdkvRmIIojY3XXbpLybJ9xTsehXwJLMjWJyQz8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1752398880; v=1;
 b=Jkp7yiVxCeJEIzpFHXOyVNnf0BvNvM5jlKWYPJ3W7xwl+Dep9TKu8BAc95da4CAc
 HWP79FHOcMldbcyZF4VD5FhWCtJ0WzQrsrzKS9FcnPtc+49uLuYjxYHxXmT7VaCc
 BGnfMZzkX195Yv/ymByg+jqewSWOf1z0pIOxbl2+S70HFIc1sZAFxeQjCMGSux8j
 2jIc5/fx6JoEl17nTQRktybd8avb7RkooaQysN2Rjoo8T1SrCKvuRjwFRNQTdO/+
 wsfDozof0jyCIbCCzgWggHk2gU/cwHqrxwCbi++AGddOs39GLhgrJJjAF4iXGyUl
 4DrGrFjMg82Ts7AnZ14e9A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 13 Jul 2025 18:27:24 +0900
Subject: [PATCH] pcie_sriov: Fix configuration and state synchronization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-wmask-v1-1-4c744cdb32c0@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAPt7c2gC/yXMSwrDIBSF4a3IHVfwWU22UjLwcW2lmLSaPiBk7
 5Vm+B8O3wYNa8YGI9mg4ju3vMw9+IlAuLn5ijTH3iCY0MywgX6Ka3cqBmV0CNHLeIb+fVRM+ft
 3LtPRFZ+vzq3HCN41pGEpJa8jScxIw7X1yko0GIQXmguutEPnrbXedpwnA9O+/wBmhzJ8owAAA
 A==
X-Change-ID: 20250709-wmask-29475ccdb3d6
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Corentin BAYET <corentin.bayet@reversetactics.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fix issues in PCIe SR-IOV configuration register handling that caused
inconsistent internal state due to improper write mask handling and
incorrect migration behavior.

Two main problems were identified:

1. VF Enable bit write mask handling:
   pcie_sriov_config_write() incorrectly assumed that its val parameter
   was already masked, causing it to ignore the actual write mask.
   This led to the VF Enable bit being processed even when masked,
   resulting in incorrect VF registration/unregistration.

2. Migration state inconsistency:
   pcie_sriov_pf_post_load() unconditionally called register_vfs()
   regardless of the VF Enable bit state, creating inconsistent
   internal state when VFs should not be enabled. Additionally,
   it failed to properly update the NumVFs write mask based on
   the current configuration.

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
Reported-by: Corentin BAYET <corentin.bayet@reversetactics.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/pci/pcie_sriov.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 3ad18744f4a8ed2b35144fafcdc8e7e00fec3672..a08b5258275f51876c18d8a3f5787c5e351c38f6 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -64,6 +64,27 @@ static void unregister_vfs(PCIDevice *dev)
     pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
 }
 
+static void consume_config(PCIDevice *dev)
+{
+    uint16_t sriov_cap = dev->exp.sriov_cap;
+    uint8_t *cfg = dev->config + sriov_cap;
+    uint8_t *wmask = dev->wmask + sriov_cap;
+    uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
+    uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
+
+    if (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) {
+        register_vfs(dev);
+    } else {
+        unregister_vfs(dev);
+    }
+
+    if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
+        wmask_val |= PCI_SRIOV_CTRL_VFE;
+    }
+
+    pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
+}
+
 static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
                                       uint16_t vf_dev_id, uint16_t init_vfs,
                                       uint16_t total_vfs, uint16_t vf_offset,
@@ -416,30 +437,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
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
 

---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20250709-wmask-29475ccdb3d6

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


