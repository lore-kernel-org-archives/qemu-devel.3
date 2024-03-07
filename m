Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DECC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riImA-00009c-IW; Thu, 07 Mar 2024 13:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1riIlz-00009C-Vp
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:47:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1riIll-0006QB-AI
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709837219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MYyijcAL9CcydVCUK1c8IV7uW8HhtncdigbsWgKmzL4=;
 b=AEocW2nr9nxae6vAAEVnAkOljvd9hVgUqA/p+NvoAuucA8ngG5Fric22FA3BCDmms6Hn7+
 j4jRpsfNE1c4gq4SRM7HkaDWqt0KJxehieWrEEalQqcWKd+f39fFf5BGjpmjyAtCNQPrGZ
 K/qeAyFXjkqJl7cQzAMDhEPAUZ3sjT0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-HEuH7plxMAay-fcsbZsT8Q-1; Thu, 07 Mar 2024 13:46:57 -0500
X-MC-Unique: HEuH7plxMAay-fcsbZsT8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5464185A786;
 Thu,  7 Mar 2024 18:46:57 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.8.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C71DF17475;
 Thu,  7 Mar 2024 18:46:56 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 clg@redhat.com
Subject: [PATCH] pci: Add option to disable device level INTx masking
Date: Thu,  7 Mar 2024 11:46:42 -0700
Message-ID: <20240307184645.104349-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The PCI 2.3 spec added definitions of the INTx disable and status bits,
in the command and status registers respectively.  The command register
bit, commonly known as DisINTx in lspci, controls whether the device
can assert the INTx signal.

Operating systems will often write to this bit to test whether a device
supports this style of legacy interrupt masking.  When using device
assignment, such as with vfio-pci, the result of this test dictates
whether the device can use a shared or exclusive interrupt (ie. generic
INTx masking at the device via DisINTx or IRQ controller level INTx
masking).

Add an experimental option to the base set of properties for PCI
devices which allows the DisINTx bit to be excluded from wmask, making
it read-only to the guest for testing purposes related to INTx masking.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci/pci.c         | 14 ++++++++++----
 include/hw/pci/pci.h |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6496d027ca61..8c78326ad67f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -85,6 +85,8 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    DEFINE_PROP_BIT("x-pci-disintx", PCIDevice, cap_present,
+                    QEMU_PCI_DISINTX_BITNR, true),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -861,13 +863,17 @@ static void pci_init_cmask(PCIDevice *dev)
 static void pci_init_wmask(PCIDevice *dev)
 {
     int config_size = pci_config_size(dev);
+    uint16_t cmd_wmask = PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+                         PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 
     dev->wmask[PCI_CACHE_LINE_SIZE] = 0xff;
     dev->wmask[PCI_INTERRUPT_LINE] = 0xff;
-    pci_set_word(dev->wmask + PCI_COMMAND,
-                 PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
-                 PCI_COMMAND_INTX_DISABLE);
-    pci_word_test_and_set_mask(dev->wmask + PCI_COMMAND, PCI_COMMAND_SERR);
+
+    if (dev->cap_present & QEMU_PCI_DISINTX) {
+        cmd_wmask |= PCI_COMMAND_INTX_DISABLE;
+    }
+
+    pci_set_word(dev->wmask + PCI_COMMAND, cmd_wmask);
 
     memset(dev->wmask + PCI_CONFIG_HEADER_SIZE, 0xff,
            config_size - PCI_CONFIG_HEADER_SIZE);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eaa3fc99d884..45f0fac435cc 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -212,6 +212,8 @@ enum {
     QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
 #define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
     QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
+#define QEMU_PCI_DISINTX_BITNR 13
+    QEMU_PCI_DISINTX = (1 << QEMU_PCI_DISINTX_BITNR),
 };
 
 typedef struct PCIINTxRoute {
-- 
2.44.0


