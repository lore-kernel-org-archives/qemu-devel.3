Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8835AC87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 06:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufvDW-0002nE-8v; Sun, 27 Jul 2025 02:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ufvDS-0002hI-FZ; Sun, 27 Jul 2025 02:50:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ufvDP-0001S9-BA; Sun, 27 Jul 2025 02:50:38 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56R6oEKn000426
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 27 Jul 2025 15:50:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Wq8xAuAt6EaJ8TlVNBeYq7edJc2plyaZgbm0lUivRpg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1753599024; v=1;
 b=mxzTZ3rteQpW1HB9BkSstv/98iHBwWfPgsds0qCUEnQ4V1bexXRGG9SX9hoST0+/
 UDoaWaLp7/6PIpNsGH8aJzdppiwrJl+YBr2maE1ml1SnS8TL/N81SI66etd4JMIq
 xp+ZOBNtKYn3Izk91AOQoebOWlmIujDIOfOAo0C0jLqgkAdT/bmyCdZm7YsmFU6q
 qUl9A0w+4ek0phtXVVCLhHCxDKInUG6s3dyKuWszmkGvGpZiqZeb76+lMg0sAzMu
 itS40acELkd+ueVhfuinlImU7KHNR/NQp5G84PKfuFWOpCZn81F/d2JWAeaM0s84
 5vy0hTf8hVBjgCS9loRs6g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 27 Jul 2025 15:50:08 +0900
Subject: [PATCH v2] pcie_sriov: Fix configuration and state synchronization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-wmask-v2-1-394910b1c0b6@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIACDMhWgC/y2OwY7CIBRFf6V5ayFAYUBX/sfEBby+KpqKQu1oT
 P9dbGd5bm5OzhsK5UgFds0bMk2xxHStoDYN4Mlfj8RiVxmUUEZYsWV/gy8XprbaGsQutN0P1O8
 tUx+fi+f3sHKm+6PqxnWE4AsxTMMQx13TC9taaVzQriVLqIIyUkltPPngnAuuymVv4es6xTKm/
 FoSJ7nI1hrZ/tdMkkmm0Wr9LVIo9rkcOUYe+YON6fJK3CM/3+Awz/MH9ahy7PMAAAA=
X-Change-ID: 20250709-wmask-29475ccdb3d6
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-stable@nongnu.org,
 Corentin BAYET <corentin.bayet@reversetactics.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
---
Changes in v2:
- Changed to perform the VFEnable write mask update only when the bit is
  cleared. It clarifies the intention is to prevent setting the bit
  (i.e., the bit is currently cleared) when the NumVF holds an invalid
  value. The code execution when the bit is set will be also a bit
  shorter.
- Added references to the relevant CVEs.
- Link to v1: https://lore.kernel.org/qemu-devel/20250713-wmask-v1-1-4c744cdb32c0@rsg.ci.i.u-tokyo.ac.jp
---
 hw/pci/pcie_sriov.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 3ad18744f4a8ed2b35144fafcdc8e7e00fec3672..8a4bf0d6f7c0c6e9ec30df2e9bc55967e48cf6c3 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -64,6 +64,27 @@ static void unregister_vfs(PCIDevice *dev)
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


