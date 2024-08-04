Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE901C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 09:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saX8F-0001LD-8t; Sun, 04 Aug 2024 05:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX82-0001HL-AW
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:15 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX7z-0001BW-Pl
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:14 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7106cf5771bso2141149b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 02:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722762130; x=1723366930;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jSFqxrJ6ZrVEUioZYkidDSjHzn1N+FgpqRFAmRsnAyg=;
 b=Joh1+cZWD5/Y6ZCKcKgVAZoNZ8MPUtmcyhgds9nKhjs+x0rcHLxAx9b9s1u744Ge6U
 fjM5XQQ4sU1jtPFUtSbiForwPUitKv9reuEYonA5pjPCOF8cqk74Ctaj6jOsMALqWjw7
 N4NF6odX9rJi1c3eGJsdhjewDpR/S2+eC1UIZC5Z7NTUx5M2PHQu+R+gi3wgYfct1Z8q
 n0eRFYWPYQIHA+c3JsMgMgREhTfkMM9c29r5bf0sMQBk7vhB6AmlzM5jhd2kRu8i1FKY
 wakTpxNUJJYFrShXlp0pD69C2kvZjRPDde6y69Us7HUPEMO36JoCuJLL2y2lmAMtUwwr
 psoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722762130; x=1723366930;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSFqxrJ6ZrVEUioZYkidDSjHzn1N+FgpqRFAmRsnAyg=;
 b=nRbHsCXtyCaeytKLVhfK/yONnco0Q+KrTDnHLqSK83OsYg+fHgqAXYSfi0+C+E/u6m
 xQ+GLRjAQfUvA/3i7RmKp0/uzBfnUdNdMydPjwAVasvUJ6G4JZt817aG/1p+Wg2FHJSN
 9VIwAkdKIeHw1GNGlT+H1ZNen5eurlmdfdXAW5yONVG/p30rGTvIAOcwG8hSg/loZ5ay
 07DlnbvzZUIqNT8+wtLfrW8HVKwlx3Jc6UjNH1XbhqfHA1tMEA0BBCUWSjmINHT9vI5e
 UU6yneLG7H6mnO8onMuJQ7EYtwnFbe30IbLT2dqZBKbGbYr8s3zX3bpP0NQ5/Ml0nqlB
 ziqg==
X-Gm-Message-State: AOJu0YxxwIjoNQ1lKw0SoMXF6OmjTUJZ1yhQAOfQRb+ABX6ItXQB2U4s
 TdZ6UTWlYrENvcUKMcLKk34Bj99TKK/Z6Q/155K6ZdLbnwxzYDfkGt+yWgvLYAI=
X-Google-Smtp-Source: AGHT+IHphh4eLVzK4SItirRvhsRqvgnTYB4YqMgNI56ILLHymB4LMbAZkGU+DEIY0HdI+LJytuNJcQ==
X-Received: by 2002:a17:902:db11:b0:1fd:d807:b29e with SMTP id
 d9443c01a7336-1ff5730a2e8mr94041515ad.35.1722762130284; 
 Sun, 04 Aug 2024 02:02:10 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff5927f40dsm45999995ad.229.2024.08.04.02.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 02:02:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 04 Aug 2024 18:01:41 +0900
Subject: [PATCH for-9.2 v12 05/11] pcie_sriov: Ensure VF function number
 does not overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-reuse-v12-5-d3930c4111b2@daynix.com>
References: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
In-Reply-To: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
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
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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

pci_new() aborts when creating a VF with a function number equals to or
is greater than PCI_DEVFN_MAX.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/pcie_sriov.txt         |  8 +++++---
 include/hw/pci/pcie_sriov.h |  5 +++--
 hw/net/igb.c                | 13 ++++++++++---
 hw/nvme/ctrl.c              | 24 ++++++++++++++++--------
 hw/pci/pcie_sriov.c         | 19 +++++++++++++++++--
 5 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index a47aad0bfab0..ab2142807f79 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -52,9 +52,11 @@ setting up a BAR for a VF.
       ...
 
       /* Add and initialize the SR/IOV capability */
-      pcie_sriov_pf_init(d, 0x200, "your_virtual_dev",
-                       vf_devid, initial_vfs, total_vfs,
-                       fun_offset, stride);
+      if (!pcie_sriov_pf_init(d, 0x200, "your_virtual_dev",
+                              vf_devid, initial_vfs, total_vfs,
+                              fun_offset, stride, errp)) {
+         return;
+      }
 
       /* Set up individual VF BARs (parameters as for normal BARs) */
       pcie_sriov_pf_init_vf_bar( ... )
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 450cbef6c201..aa704e8f9d9f 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -27,10 +27,11 @@ typedef struct PCIESriovVF {
     uint16_t vf_number; /* Logical VF number of this function */
 } PCIESriovVF;
 
-void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
                         uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride);
+                        uint16_t vf_offset, uint16_t vf_stride,
+                        Error **errp);
 void pcie_sriov_pf_exit(PCIDevice *dev);
 
 /* Set up a VF bar in the SR/IOV bar area */
diff --git a/hw/net/igb.c b/hw/net/igb.c
index b92bba402e0d..b6ca2f1b8aee 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -446,9 +446,16 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_ari_init(pci_dev, 0x150);
 
-    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
-        IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
-        IGB_VF_OFFSET, IGB_VF_STRIDE);
+    if (!pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET,
+                            TYPE_IGBVF, IGB_82576_VF_DEV_ID,
+                            IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
+                            IGB_VF_OFFSET, IGB_VF_STRIDE,
+                            errp)) {
+        pcie_cap_exit(pci_dev);
+        igb_cleanup_msix(s);
+        msi_uninit(pci_dev);
+        return;
+    }
 
     pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MMIO_BAR_IDX,
         PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c6d4f61a47f9..e86ea2e7ce57 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8271,7 +8271,8 @@ out:
     return pow2ceil(bar_size);
 }
 
-static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
+static bool nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset,
+                            Error **errp)
 {
     uint16_t vf_dev_id = n->params.use_intel_id ?
                          PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
@@ -8280,12 +8281,17 @@ static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
                                       le16_to_cpu(cap->vifrsm),
                                       NULL, NULL);
 
-    pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
-                       n->params.sriov_max_vfs, n->params.sriov_max_vfs,
-                       NVME_VF_OFFSET, NVME_VF_STRIDE);
+    if (!pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
+                            n->params.sriov_max_vfs, n->params.sriov_max_vfs,
+                            NVME_VF_OFFSET, NVME_VF_STRIDE,
+                            errp)) {
+        return false;
+    }
 
     pcie_sriov_pf_init_vf_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                               PCI_BASE_ADDRESS_MEM_TYPE_64, bar_size);
+
+    return true;
 }
 
 static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
@@ -8410,6 +8416,12 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         return false;
     }
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs &&
+        !nvme_init_sriov(n, pci_dev, 0x120, errp)) {
+        msix_uninit(pci_dev, &n->bar0, &n->bar0);
+        return false;
+    }
+
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
 
     pcie_cap_deverr_init(pci_dev);
@@ -8439,10 +8451,6 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         nvme_init_pmr(n, pci_dev);
     }
 
-    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
-        nvme_init_sriov(n, pci_dev, 0x120);
-    }
-
     return true;
 }
 
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 499becd5273f..f0bde0d3fc79 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -24,14 +24,27 @@ static PCIDevice *register_vf(PCIDevice *pf, int devfn,
                               const char *name, uint16_t vf_num);
 static void unregister_vfs(PCIDevice *dev);
 
-void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
                         uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride)
+                        uint16_t vf_offset, uint16_t vf_stride,
+                        Error **errp)
 {
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (total_vfs) {
+        uint16_t ari_cap = pcie_find_capability(dev, PCI_EXT_CAP_ID_ARI);
+        uint16_t first_vf_devfn = dev->devfn + vf_offset;
+        uint16_t last_vf_devfn = first_vf_devfn + vf_stride * (total_vfs - 1);
+
+        if ((!ari_cap && PCI_SLOT(dev->devfn) != PCI_SLOT(last_vf_devfn)) ||
+            last_vf_devfn >= PCI_DEVFN_MAX) {
+            error_setg(errp, "VF function number overflows");
+            return false;
+        }
+    }
+
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
@@ -69,6 +82,8 @@ void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     pci_set_word(wmask + PCI_SRIOV_SYS_PGSIZE, 0x553);
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
+
+    return true;
 }
 
 void pcie_sriov_pf_exit(PCIDevice *dev)

-- 
2.45.2


