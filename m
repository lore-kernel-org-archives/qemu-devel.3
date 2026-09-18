Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD7EC88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7SCn-0003Sl-2i; Fri, 18 Sep 2026 02:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=md1715FC36BB=lirongqing@baidu.com>)
 id 1x7SCN-0003Rf-Pe
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 02:35:52 -0400
Received: from mx15.baidu.com ([111.202.115.100] helo=outbound.baidu.com)
 by eggs.gnu.org with smtp (Exim 4.90_1)
 (envelope-from <prvs=md1715FC36BB=lirongqing@baidu.com>)
 id 1x7SCG-0000gE-Q1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 02:35:51 -0400
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v2] pcie_sriov: fix wrong write width and off-by-one in
 pf_reset
Date: Fri, 18 Sep 2026 14:35:26 +0800
Message-ID: <20260918063526.2191-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjkjy-exc9.internal.baidu.com (172.31.50.19) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1789713335;
 bh=d5FC4Yg0oTjZ0sBoNRxonYn9axtEGnVf6xF5hHBqw/I=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=Cvx4KaDkyBI7PYRsvF2KjZjR7ltnpUNFE9WBtSWH4A/y4+ls9Id3SC+wmugVoGeUU
 4SCArp2hjKBQoxI+IRwBn+yOCUCduU969lnWRRug7UH/J9ouhU4gv3/LOynuEavJA+
 AWadc9LHluQXua3+KwM41AOZsxnJcS6ndwUfC8ZgM+sPS5hRKyOzPTMbY2NHXfliGI
 a3lYv6ACHbVCWGpH5eVGl4Tpl2kTZyJDeIP2EZGHF6Lc4nJ5DRh27TNqn7faY2tSGm
 tLEY1TwmSrNVv+0Nff9175wzAg+9EGcwNYKgiEH5Vq/1P0JDOkqDZ12hO+tsc3mlRo
 k2dgrWI2VUt+Q==
Received-SPF: pass client-ip=111.202.115.100;
 envelope-from=prvs=md1715FC36BB=lirongqing@baidu.com; helo=outbound.baidu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Li RongQing <lirongqing@baidu.com>

pcie_sriov_pf_reset() restores the VF BAR type registers using
pci_set_quad() with a 4-byte stride. Since each VF BAR register is
4 bytes wide, the 8-byte write also covers the following BAR
register. Although subsequent iterations overwrite most of the
unintended writes, the access is incorrect and the final iteration
can write beyond the VF BAR registers.

SR-IOV defines six VF BAR registers and does not provide a VF ROM BAR.
However, several SR-IOV code paths use PCI_NUM_REGIONS, which includes
the ROM slot and therefore has a value of seven.

In particular, the final iteration in pcie_sriov_pf_reset() currently
writes a quadword at the offset of the seventh region. This starts at
the byte immediately following the six VF BAR registers and can
overwrite subsequent fields in the SR-IOV capability.

Use pci_set_long() to match the 4-byte VF BAR register width, and use
PCI_SRIOV_NUM_BARS when iterating over SR-IOV VF BARs. This also makes
the BAR count consistent with the assertion in
pcie_sriov_pf_init_vf_bar().

Fixes: 19e55471d4e8a4 ("pcie_sriov: Allow user to create SR-IOV device")
Fixes: c8bc4db403e176 ("pcie_sriov: Reset SR-IOV extended capability")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: fix the Fixes tag, it should be 19e55471d4e8a4

 hw/pci/pcie_sriov.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index c41ac95..6122a26 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -229,7 +229,7 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
 
     assert(sriov_cap > 0);
     assert(region_num >= 0);
-    assert(region_num < PCI_NUM_REGIONS);
+    assert(region_num < PCI_SRIOV_NUM_BARS);
     assert(region_num != PCI_ROM_SLOT);
 
     wmask = ~(size - 1);
@@ -308,7 +308,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
             return -1;
         }
 
-        for (size_t j = 0; j < PCI_NUM_REGIONS; j++) {
+        for (size_t j = 0; j < PCI_SRIOV_NUM_BARS; j++) {
             if (vfs[i]->io_regions[j].size != vfs[0]->io_regions[j].size ||
                 vfs[i]->io_regions[j].type != vfs[0]->io_regions[j].type) {
                 error_setg(errp, "inconsistent SR-IOV BARs");
@@ -344,7 +344,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
     dev->exp.sriov_pf.vf = vfs;
     dev->exp.sriov_pf.vf_user_created = true;
 
-    for (i = 0; i < PCI_NUM_REGIONS; i++) {
+    for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
         PCIIORegion *region = &vfs[0]->io_regions[i];
 
         if (region->size) {
@@ -463,8 +463,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
      */
     pci_set_word(dev->config + sriov_cap + PCI_SRIOV_SYS_PGSIZE, 0x1);
 
-    for (uint16_t i = 0; i < PCI_NUM_REGIONS; i++) {
-        pci_set_quad(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
+    for (uint16_t i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+        pci_set_long(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
                      dev->exp.sriov_pf.vf_bar_type[i]);
     }
 }
-- 
2.9.4


