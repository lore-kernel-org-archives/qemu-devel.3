Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94702C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfICA-0000he-7K; Wed, 28 Feb 2024 06:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfIC4-0000d2-Tx
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:33:51 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfIC2-000758-In
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:33:48 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29a858a0981so3565837a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120024; x=1709724824;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CWn2MCi797aQrb9iMuPcNohCGcLthp8Y3kdNV7UN6ps=;
 b=1aX+GV9jaPStVC6hHP1JJBGsGkzYASSnedunJI9qctj1YVoEWZuTKl/YLhm0fsrVch
 /SxGAqB4RaoVHZrKjcPtPd7KkOqEcKUATiTzmrykwOV2nf0gieSnxS+yxaCOZAr4vJ+g
 kQlP7gKnOwvzbj6gUCo8oa/w++RFV+rvoQs31FWK91rfWwQ3UFdeHPq4TOYKOh6w7fLh
 cBH3ahEQP0Haf8G9/ZGEyo+8M8/QiN+Fk5kUNeO4myjsPbaXP6VppGOdmn0eVzeW6xM9
 ytec0HWOKmjDo5frx6hwOkP5IwBtLzRaQf9AGs6S6dKnmcDF6Hii6jghDVHwDLq0ri9T
 kjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120024; x=1709724824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWn2MCi797aQrb9iMuPcNohCGcLthp8Y3kdNV7UN6ps=;
 b=kwgT6nL4driz4gJfJfdzTsSRsHMbiVdctGoKSqYdWcU03LihNqV0UxLnrgTlufvO4J
 N3sl8IQz0uJa7WCT2815BMzwylCfcxCj1qPkpzYFDN6BcsFdWMNpU5AcUj5RQwBTbNCH
 rBTvkuYqcnfbA9VwsMrHxNvvf0l5Wuh5Rhz/mTDkhzbE7cC9ernAbdB4sCsk2wvtKeh7
 OAQb8Ry39HE6cvSIFVHVGLSbGX9wX9NKQeJZQ9jqqg1aR0mcTbac3kUhxBOLLAJJSUML
 CuMQMVU47e1mH9r5QN5J3+zFpv6hDA5C1RHNuM2RhSIhd/2S1x/oZR03dqFpWdphLFsR
 qEmA==
X-Gm-Message-State: AOJu0YwquV6CGXd0Ew/L/n/i2iHgr5fSXNTAhF0ssqtS3KqbyJXYbkqB
 U4KbZb5tzONChuuhAT7uFs5zw36vu4X+77/7cOIwwFAhD11CJ/veps5HDpZ48ys=
X-Google-Smtp-Source: AGHT+IHwgwi26XEQx6gP5z79C8pLaugSOP1j+hBDSgmWxfW4foRaSMSHNVoKmB1Wi0QD/m3c2/uUFA==
X-Received: by 2002:a17:90a:fd8c:b0:299:d17:a558 with SMTP id
 cx12-20020a17090afd8c00b002990d17a558mr11286386pjb.21.1709120024046; 
 Wed, 28 Feb 2024 03:33:44 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 y33-20020a17090a53a400b0029ab5abcbe1sm1479420pjh.20.2024.02.28.03.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:33:43 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:14 +0900
Subject: [PATCH v8 03/15] pcie_sriov: Reset SR-IOV extended capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-reuse-v8-3-282660281e60@daynix.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

pcie_sriov_pf_disable_vfs() is called when resetting the PF, but it only
disables VFs and does not reset SR-IOV extended capability, leaking the
state and making the VF Enable register inconsistent with the actual
state.

Replace pcie_sriov_pf_disable_vfs() with pcie_sriov_pf_reset(), which
does not only disable VFs but also resets the capability.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie_sriov.h |  4 ++--
 hw/net/igb.c                |  2 +-
 hw/nvme/ctrl.c              |  2 +-
 hw/pci/pcie_sriov.c         | 26 ++++++++++++++++++--------
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 095fb0c9edf9..b77eb7bf58ac 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -58,8 +58,8 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize);
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              uint32_t val, int len);
 
-/* Reset SR/IOV VF Enable bit to unregister all VFs */
-void pcie_sriov_pf_disable_vfs(PCIDevice *dev);
+/* Reset SR/IOV */
+void pcie_sriov_pf_reset(PCIDevice *dev);
 
 /* Get logical VF number of a VF - only valid for VFs */
 uint16_t pcie_sriov_vf_number(PCIDevice *dev);
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 0b5c31a58bba..9345506f81ec 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -493,7 +493,7 @@ static void igb_qdev_reset_hold(Object *obj)
 
     trace_e1000e_cb_qdev_reset_hold();
 
-    pcie_sriov_pf_disable_vfs(d);
+    pcie_sriov_pf_reset(d);
     igb_core_reset(&s->core);
 }
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7a56e7b79b4d..7c0d3f108724 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7116,7 +7116,7 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
             }
 
             if (rst != NVME_RESET_CONTROLLER) {
-                pcie_sriov_pf_disable_vfs(pci_dev);
+                pcie_sriov_pf_reset(pci_dev);
             }
         }
 
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index da209b7f47fd..51b66d1bb342 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -249,16 +249,26 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
 }
 
 
-/* Reset SR/IOV VF Enable bit to trigger an unregister of all VFs */
-void pcie_sriov_pf_disable_vfs(PCIDevice *dev)
+/* Reset SR/IOV */
+void pcie_sriov_pf_reset(PCIDevice *dev)
 {
     uint16_t sriov_cap = dev->exp.sriov_cap;
-    if (sriov_cap) {
-        uint32_t val = pci_get_byte(dev->config + sriov_cap + PCI_SRIOV_CTRL);
-        if (val & PCI_SRIOV_CTRL_VFE) {
-            val &= ~PCI_SRIOV_CTRL_VFE;
-            pcie_sriov_config_write(dev, sriov_cap + PCI_SRIOV_CTRL, val, 1);
-        }
+    if (!sriov_cap) {
+        return;
+    }
+
+    pci_set_word(dev->config + sriov_cap + PCI_SRIOV_CTRL, 0);
+    unregister_vfs(dev);
+
+    /*
+     * Default is to use 4K pages, software can modify it
+     * to any of the supported bits
+     */
+    pci_set_word(dev->config + sriov_cap + PCI_SRIOV_SYS_PGSIZE, 0x1);
+
+    for (uint16_t i = 0; i < PCI_NUM_REGIONS; i++) {
+        pci_set_quad(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
+                     dev->exp.sriov_pf.vf_bar_type[i]);
     }
 }
 

-- 
2.43.2


