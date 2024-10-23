Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B08BCDDE70
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ZiJ-0005ei-8k; Wed, 23 Oct 2024 07:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t3ZhH-0005GA-Kj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:38:44 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t3ZhC-0003kr-2Y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:38:39 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 12C56260983;
 Wed, 23 Oct 2024 13:38:30 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id CUeNcroBrWNo; Wed, 23 Oct 2024 13:38:27 +0200 (CEST)
Received: from applejack.lan (83.11.13.124.ipv4.supernova.orange.pl
 [83.11.13.124])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 39BE326059E;
 Wed, 23 Oct 2024 13:38:27 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v2 1/1] pcie: enable Extended tag field support
Date: Wed, 23 Oct 2024 13:38:20 +0200
Message-ID: <20241023113820.486017-1-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

From what I read PCI has 32 transactions, PCI Express devices can handle
256 with Extended tag enabled (spec mentions also larger values but I
lack PCIe knowledge).

QEMU leaves 'Extended tag field' with 0 as value:

Capabilities: [e0] Express (v1) Root Complex Integrated Endpoint, IntMsgNum 0
        DevCap: MaxPayload 128 bytes, PhantFunc 0
                ExtTag- RBE+ FLReset- TEE-IO-

SBSA ACS has test 824 which checks for PCIe device capabilities. BSA
specification [1] (SBSA is on top of BSA) in section F.3.2 lists
expected values for Device Capabilities Register:

Device Capabilities Register     Requirement
Role based error reporting       RCEC and RCiEP: Hardwired to 1
Endpoint L0s acceptable latency  RCEC and RCiEP: Hardwired to 0
L1 acceptable latency            RCEC and RCiEP: Hardwired to 0
Captured slot power limit scale  RCEC and RCiEP: Hardwired to 0
Captured slot power limit value  RCEC and RCiEP: Hardwired to 0
Max payload size                 value must be compliant with PCIe spec
Phantom functions                RCEC and RCiEP: Recommendation is to
                                 hardwire this bit to 0.
Extended tag field               Hardwired to 1

1. https://developer.arm.com/documentation/den0094/c/

This change enables Extended tag field. All versioned platforms should
have it disabled for older versions (tested with Arm/virt).

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 hw/core/machine.c    | 4 +++-
 hw/pci/pci.c         | 2 ++
 hw/pci/pcie.c        | 8 +++++++-
 include/hw/pci/pci.h | 2 ++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index adaba17eba..8ccc74067a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,7 +34,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_9_1[] = {};
+GlobalProperty hw_compat_9_1[] = {
+    { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
+};
 const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
 
 GlobalProperty hw_compat_9_0[] = {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 87da35ca9b..9a3b0e4a43 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -87,6 +87,8 @@ static Property pci_props[] = {
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
     DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
                      max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
+    DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
+                    QEMU_PCIE_EXT_TAG_BITNR, true),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4b2f0805c6..9f369c2b6c 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -86,7 +86,13 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
      * Specification, Revision 1.1., or subsequent PCI Express Base
      * Specification revisions.
      */
-    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER);
+    uint32_t devcap = PCI_EXP_DEVCAP_RBER;
+
+    if (dev->cap_present & QEMU_PCIE_EXT_TAG) {
+        devcap = PCI_EXP_DEVCAP_RBER | PCI_EXP_DEVCAP_EXT_TAG;
+    }
+
+    pci_set_long(exp_cap + PCI_EXP_DEVCAP, devcap);
 
     pci_set_long(exp_cap + PCI_EXP_LNKCAP,
                  (port << PCI_EXP_LNKCAP_PN_SHIFT) |
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eb26cac810..5b14f9d375 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -213,6 +213,8 @@ enum {
     QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
 #define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
     QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
+#define QEMU_PCIE_EXT_TAG_BITNR 13
+    QEMU_PCIE_EXT_TAG = (1 << QEMU_PCIE_EXT_TAG_BITNR),
 };
 
 typedef struct PCIINTxRoute {
-- 
2.46.1


