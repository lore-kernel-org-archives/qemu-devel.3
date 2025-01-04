Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC71E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyyb-00029f-Up; Sat, 04 Jan 2025 02:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyR-0001sB-Eq
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:35 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyN-000364-EL
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:30 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216426b0865so177646095ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977204; x=1736582004;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xwODeiAmUKin1dC/nSDAdnrtbdfpKWFdm1CDRITC1UE=;
 b=Yq5E2LUrD0wx0AsupB2GmNySNnRNjL+ks0+TbcRyqNwJXeuFBdgC2sBpBEim5Ps4sx
 cpL3pnjy3ooUIIFF172v12wkTZ7D6zN3ZxC7boM2FXNYa5DdWip1cjWrnzU4qZbk1v/s
 8FwF3C2NjmlBnZ49uUQRffgIAzEzZvnmYUzhwsXXRfLwtGb/dTTvEKmeCpSnKNDP55Hf
 pFF4iDR88SAW2iUb+69+s5ZPd/TiHxAqb02fw7+4/UdNoKPLR9ahtHvey4BXaMoq6ZCH
 2359wUxH6iDGbC6DDh708+l5ZS3ERGv10WxNMSUdV2Cz7p89pK05chfAI5mhI/V3x+EM
 VrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977204; x=1736582004;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwODeiAmUKin1dC/nSDAdnrtbdfpKWFdm1CDRITC1UE=;
 b=NWA5Fenf6d3Ij5LRS6Pkig0fQsRke4dwVbGMyzE3YGCORl9TJz1bxSqD+aN4vrH2r7
 NFrV/jnkKP2uWwLYKeijbZXmnn3Aiogb1q1FyQ1zVu/ObfVA+cew1RkOwArt31vYZ4kr
 /ibOIh+7LmbzSV2gKbnYaSlIbI4okE3XrvvWb+H+FVM+8hsWFB74tZYNgcELOgog3yH6
 ahCejaSDEAfj0w8w8Uw8fqEbZLvqDtxsGtaYqpSlqk4D93zO4pSNR3MwJRaz+ZcDDNIR
 XH/2SteDY43uNH1fCPi+tkYpfrHtni2jAzKZVz7nvsExu/pHnuCsXp7p0Ack1oPn8/YZ
 0cLQ==
X-Gm-Message-State: AOJu0YzDpLN2zF1GH6jxPOlJSzWFeT5Hv6VhKH8mZ2uRayi7vmJjQPk0
 gDAFGf7CuOgO5RgIh+ROK9IFchF2nTzHNl1NIbx4fBmsS0JmLvcTpEGOhdO/iWQ=
X-Gm-Gg: ASbGncv0d+WLph0y/IwhHPGK7K8Cpj6LJ9i2C0STcgrP7ma+vL1PJRS5BxG7hlOef0O
 kJYjb7Z5pd44Y/a+O/4szBVBQsCNmp4w3fux2Qlnt5mWMlWT85SnYnJsv24OdwZOYbvQSKbTCt5
 svF3UXdf+P30+mc2JA8lPFBRlX8hGq0RGucx3VBUy+tMpVWs4fAqDH2jJdfslqEh2tSmHXplRUj
 J7Vt71U50vtVhUWW2RHjhxajHUvVOqY0AbSe9giCFlk915X01AURse81EHK
X-Google-Smtp-Source: AGHT+IGOieOECPlYxJnB1vFEmdsQSupu2cPD80tNgz8Fub0I5WdeNt/0GSDeeDe86TV7iXSK51nx+Q==
X-Received: by 2002:a17:902:d48c:b0:216:5b8b:232c with SMTP id
 d9443c01a7336-219e6f284efmr709998305ad.54.1735977204442; 
 Fri, 03 Jan 2025 23:53:24 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc96e883sm256319135ad.72.2025.01.03.23.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:53:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:28 +0900
Subject: [PATCH v18 08/14] pcie_sriov: Ensure VF addr does not overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-8-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

pci_new() aborts when creating a VF with addr >= PCI_DEVFN_MAX.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/pcie_sriov.txt         |  8 +++++---
 include/hw/pci/pcie_sriov.h |  5 +++--
 hw/net/igb.c                | 10 +++++++---
 hw/nvme/ctrl.c              | 22 ++++++++++++++--------
 hw/pci/pcie_sriov.c         | 14 ++++++++++++--
 5 files changed, 41 insertions(+), 18 deletions(-)

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
index 4d93ce629f95..c965fc2fb68a 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -446,9 +446,13 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_ari_init(pci_dev, 0x150);
 
-    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
-        IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
-        IGB_VF_OFFSET, IGB_VF_STRIDE);
+    if (!pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
+                            IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS,
+                            IGB_MAX_VF_FUNCTIONS, IGB_VF_OFFSET, IGB_VF_STRIDE,
+                            errp)) {
+        igb_cleanup_msix(s);
+        return;
+    }
 
     pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MMIO_BAR_IDX,
         PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 68903d1d7067..8175751518f8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8481,7 +8481,8 @@ out:
     return pow2ceil(bar_size);
 }
 
-static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
+static bool nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset,
+                            Error **errp)
 {
     uint16_t vf_dev_id = n->params.use_intel_id ?
                          PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
@@ -8490,12 +8491,16 @@ static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
                                       le16_to_cpu(cap->vifrsm),
                                       NULL, NULL);
 
-    pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
-                       n->params.sriov_max_vfs, n->params.sriov_max_vfs,
-                       NVME_VF_OFFSET, NVME_VF_STRIDE);
+    if (!pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
+                            n->params.sriov_max_vfs, n->params.sriov_max_vfs,
+                            NVME_VF_OFFSET, NVME_VF_STRIDE, errp)) {
+        return false;
+    }
 
     pcie_sriov_pf_init_vf_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                               PCI_BASE_ADDRESS_MEM_TYPE_64, bar_size);
+
+    return true;
 }
 
 static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
@@ -8620,6 +8625,11 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         return false;
     }
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs &&
+        !nvme_init_sriov(n, pci_dev, 0x120, errp)) {
+        return false;
+    }
+
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
 
     pcie_cap_deverr_init(pci_dev);
@@ -8649,10 +8659,6 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         nvme_init_pmr(n, pci_dev);
     }
 
-    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
-        nvme_init_sriov(n, pci_dev, 0x120);
-    }
-
     return true;
 }
 
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 499becd5273f..91c64c988eb4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -24,14 +24,22 @@ static PCIDevice *register_vf(PCIDevice *pf, int devfn,
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
+    int32_t devfn = dev->devfn + vf_offset;
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (total_vfs &&
+        (uint32_t)devfn + (uint32_t)(total_vfs - 1) * vf_stride >= PCI_DEVFN_MAX) {
+        error_setg(errp, "VF addr overflows");
+        return false;
+    }
+
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
@@ -69,6 +77,8 @@ void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     pci_set_word(wmask + PCI_SRIOV_SYS_PGSIZE, 0x553);
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
+
+    return true;
 }
 
 void pcie_sriov_pf_exit(PCIDevice *dev)

-- 
2.47.1


