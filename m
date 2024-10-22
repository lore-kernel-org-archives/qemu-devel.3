Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DED9D1CDB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3AP4-0003oq-Nb; Tue, 22 Oct 2024 04:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AP1-0003fp-GM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:38:07 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOy-0001Zc-QS
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:38:06 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c9978a221so61084465ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729586283; x=1730191083;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pNee5FE0+70OZlVEsoP8yUDph/emHBLuZjC/iOT6fd4=;
 b=Jr4n/xALT1966AWNjS9Avpn1mvs6VF3KvXqOdCWKKN3+tVlFzmbH7PnwX3QvXDFbg1
 +j5KguEDYyhaubyglokyuCJXqYFd3R5UW1Bq2BKNT25WxJGhtsKtSTDPonyuqMP4Eh2d
 PG1HOkgiPQzbjtsoMtD+uLgSXhsa2g9PcCtUv0TXaX16L0fQGbg6/DAT2v8ahHcmqQLA
 HgMhy0aN5xvnyNphbcl1Sms5uI5D6sxJ0sewj4HTW8lofFJd1BoGXCC4Y3AtFTprEyyp
 eRQJpmnnJMpFAVs0cZjrxa9ku021g000T14Ry38T2FcIUM8cpscK8A6sFHYY6xNwaCF2
 gjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586283; x=1730191083;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNee5FE0+70OZlVEsoP8yUDph/emHBLuZjC/iOT6fd4=;
 b=kSgGfOvqSRyc1CFhClKLZowMN1jmRcMsbS+igXsN95YC3AxX4GVGY/6nRSU3dw1PKr
 33jUjTaADyaowb7gzN97U2qr7gth6Y+7/DD5HxxJJHjWs3IhbyL868a59VVrx+bOAu6P
 /D0d32Dqus7XbhPBeFNEevtnC0PUdih44yNpY7hsqius0O19x6wqC99mNFIEyNFcGsB8
 nVd1yjxB+NVzNCSYRdK23p1asELLFKTtwcULnWZiP4VKUOAcMBHi6uea1JM4M6lQ0qOE
 aq3yewTBZru5jl4Ee6IxhsUNm4eheQiMgWL+L9sbADklVbleS4QnZieav4t/hQPZ8R4N
 M1iQ==
X-Gm-Message-State: AOJu0Yz6LYaXlVsgaQEACLOzokuYLiw7m9lRE5ea90yUKSfz197qLlGU
 N+0ngc6PotJzxB0tYTsixY6mMugDyrMhxf1oHYGCn1sqUNflg7bfzLy/nfrhAjk=
X-Google-Smtp-Source: AGHT+IGwHi3EIjPtd09Jwmy03p4e/DG3nfc1sQ55yE8ESjPH7G5jzBXB4T7UtxFofO7CS51dDXGLHw==
X-Received: by 2002:a17:902:ce06:b0:20c:f27f:fbf with SMTP id
 d9443c01a7336-20e5a78dff2mr235089615ad.25.1729586283518; 
 Tue, 22 Oct 2024 01:38:03 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-20e7f0bd376sm37901015ad.132.2024.10.22.01.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 01:38:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 17:36:48 +0900
Subject: [PATCH v17 11/14] pcie_sriov: Remove num_vfs from PCIESriovPF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-reuse-v17-11-bd7c133237e4@daynix.com>
References: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
In-Reply-To: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

num_vfs is not migrated so use PCI_SRIOV_CTRL_VFE and PCI_SRIOV_NUM_VF
instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie_sriov.h |  1 -
 hw/pci/pcie_sriov.c         | 38 +++++++++++++++++++++++++++-----------
 hw/pci/trace-events         |  2 +-
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 70649236c18a..5148c5b77dd1 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -16,7 +16,6 @@
 #include "hw/pci/pci.h"
 
 typedef struct PCIESriovPF {
-    uint16_t num_vfs;   /* Number of virtual functions created */
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
 } PCIESriovPF;
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index db087bb9330c..69609c112e31 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -51,7 +51,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
-    dev->exp.sriov_pf.num_vfs = 0;
     dev->exp.sriov_pf.vf = NULL;
 
     pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
@@ -188,29 +187,28 @@ static void register_vfs(PCIDevice *dev)
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
-    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
-        return;
-    }
 
     trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
                              PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
         pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
     }
-    dev->exp.sriov_pf.num_vfs = num_vfs;
+
+    pci_set_word(dev->wmask + sriov_cap + PCI_SRIOV_NUM_VF, 0);
 }
 
 static void unregister_vfs(PCIDevice *dev)
 {
-    uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
     uint16_t i;
 
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
-                               PCI_FUNC(dev->devfn), num_vfs);
-    for (i = 0; i < num_vfs; i++) {
+                               PCI_FUNC(dev->devfn));
+    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
         pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
     }
-    dev->exp.sriov_pf.num_vfs = 0;
+
+    pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
@@ -236,6 +234,17 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
         } else {
             unregister_vfs(dev);
         }
+    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
+        uint8_t *cfg = dev->config + sriov_cap;
+        uint8_t *wmask = dev->wmask + sriov_cap;
+        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
+        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
+
+        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
+            wmask_val |= PCI_SRIOV_CTRL_VFE;
+        }
+
+        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
     }
 }
 
@@ -252,6 +261,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
     unregister_vfs(dev);
 
     pci_set_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF, 0);
+    pci_set_word(dev->wmask + sriov_cap + PCI_SRIOV_CTRL,
+                 PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI);
 
     /*
      * Default is to use 4K pages, software can modify it
@@ -298,7 +309,7 @@ PCIDevice *pcie_sriov_get_pf(PCIDevice *dev)
 PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
 {
     assert(!pci_is_vf(dev));
-    if (n < dev->exp.sriov_pf.num_vfs) {
+    if (n < pcie_sriov_num_vfs(dev)) {
         return dev->exp.sriov_pf.vf[n];
     }
     return NULL;
@@ -306,5 +317,10 @@ PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
 
 uint16_t pcie_sriov_num_vfs(PCIDevice *dev)
 {
-    return dev->exp.sriov_pf.num_vfs;
+    uint16_t sriov_cap = dev->exp.sriov_cap;
+    uint8_t *cfg = dev->config + sriov_cap;
+
+    return sriov_cap &&
+           (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) ?
+           pci_get_word(cfg + PCI_SRIOV_NUM_VF) : 0;
 }
diff --git a/hw/pci/trace-events b/hw/pci/trace-events
index 19643aa8c6b0..e98f575a9d19 100644
--- a/hw/pci/trace-events
+++ b/hw/pci/trace-events
@@ -14,7 +14,7 @@ msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d mask
 
 # hw/pci/pcie_sriov.c
 sriov_register_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: creating %d vf devs"
-sriov_unregister_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: Unregistering %d vf devs"
+sriov_unregister_vfs(const char *name, int slot, int function) "%s %02x:%x: Unregistering vf devs"
 sriov_config_write(const char *name, int slot, int fun, uint32_t offset, uint32_t val, uint32_t len) "%s %02x:%x: sriov offset 0x%x val 0x%x len %d"
 
 # pcie.c

-- 
2.47.0


