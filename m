Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98878D3748A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 13:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Qdo-0000As-Vv; Thu, 17 Oct 2024 09:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t1Qdn-0000AX-Sn
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 09:34:11 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t1Qdm-0005Ui-5W
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 09:34:11 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id D582B260980;
 Thu, 17 Oct 2024 15:34:05 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 8O7mZLcE8ySs; Thu, 17 Oct 2024 15:34:03 +0200 (CEST)
Received: from applejack.lan (83.11.13.124.ipv4.supernova.orange.pl
 [83.11.13.124])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 88AB0260670;
 Thu, 17 Oct 2024 15:34:02 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Date: Thu, 17 Oct 2024 15:33:44 +0200
Subject: [PATCH] pcie: enable Extended tag field capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-pcie-extend-v1-1-03eb1029f4ca@linaro.org>
X-B4-Tracking: v=1; b=H4sIADcSEWcC/x3MQQqAIBBG4avIrBM0pKirRAtr/mo2FhohhHdPW
 n6L915KiIJEo3op4pEkZ6iwjaL18GGHFq6m1rTOGtvraxVo5BuBte/8wOgdL2yoFlfEJvm/TXM
 pH9vkW+ldAAAA
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: b4 0.14.1
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

PCI has 32 transactions, PCI Express devices can handle 256.

SBSA ACS checks for this capability to be enabled on Arm server systems.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
SBSA Reference Platform work goes on so I am looking at PCIe related tests.

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

QEMU leaves 'Extended tag field' with 0 as value:

Capabilities: [e0] Express (v1) Root Complex Integrated Endpoint, IntMsgNum 0
        DevCap: MaxPayload 128 bytes, PhantFunc 0
                ExtTag- RBE+ FLReset- TEE-IO-

From what I read PCI has 32 transactions, PCI Express devices can handle
256 with Extended tag enabled (spec mentions also larger values but I
lack PCIe knowledge).
---
 hw/pci/pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4b2f0805c6..54c0f1ec67 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -86,7 +86,8 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
      * Specification, Revision 1.1., or subsequent PCI Express Base
      * Specification revisions.
      */
-    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER);
+    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER |
+                 PCI_EXP_DEVCAP_EXT_TAG);
 
     pci_set_long(exp_cap + PCI_EXP_LNKCAP,
                  (port << PCI_EXP_LNKCAP_PN_SHIFT) |

---
base-commit: f774a677507966222624a9b2859f06ede7608100
change-id: 20241017-pcie-extend-a6a9de74dbd0

Best regards,
-- 
Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>


