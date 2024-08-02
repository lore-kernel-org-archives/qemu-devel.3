Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6585BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm83-00041s-Hz; Fri, 02 Aug 2024 02:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm81-0003o3-GM
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:51:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7y-00010d-M5
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:51:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fc6ee64512so60482365ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722581461; x=1723186261;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=04oTSlM6/qEgQv6cXgurvQT4fTrVXkJlhpZElpuiYcs=;
 b=JmMbPOYoSKfoX3boinkABZmvXaxue1Xz/eR48iPkx9BOn4gyqENvM4dZjLlfupchSi
 EhxU/Prmn4cJIl3aQnQv/0g1LKryJSz/TB2qnwkECMcGPpHpF3NXSKN8wKEOduCnjYVZ
 1rjJTG99Q0DY1aor2wPxci65Io4tjRZXoF/ax0kxLqsBt/osqq8+i0SfX4Hdb800wHqa
 yWchjXe2axFHKEFfOPPM9fKSqtg63SGZT2TCcePMh5doWtL1s+iGeqjb12ja1HUdescc
 GoA0/2l3IytfUcAhwtMfgA/mFwJWjPFxTtxf4NvybMw6eYZ9aYXsK2b90QGf3Tw2G+Wu
 B+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581461; x=1723186261;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04oTSlM6/qEgQv6cXgurvQT4fTrVXkJlhpZElpuiYcs=;
 b=MA5MZ1PCWY5SW5Lriz5IMFckqWJeHR47j59GpZiEzruX03VHgDg6YzHIKconNKXqLc
 83m/cZYZgwfXuDNpt9+F/GR6ymV17BZ1ZXyozU+8Cz30Yr6Lj0WvUsUdlz/9Kdk1UQmi
 GVB2YfgYFzOrXBxlM1yczZj44YNzLGAnX2GKVR2s09qo8kGpgshDQvv82vyWtA4VCsQL
 sfkxzqfJHTCyTpyOtjPbL6e0dC73WJ/gbKLk068FiUG7VlHaSULB849wa6Ca5FFdrzwY
 AlV/pFqR8jUtlrLaJpAnZAkOYk702qgZtzUGUQ+j3bp3+R+qTTMS2FcNmMcuRWA4+avo
 tAsA==
X-Gm-Message-State: AOJu0YxDG7iVIwJgRKN9w2NE5mdzM2wZ8+tK12ZllHtNIdJO6Vtf0KcZ
 UiAtzxh3HGAy46ZY/fR4ewcLcTaf452wrAOE/+I/0ejEMFzOr0zykgCQoQ2TScw=
X-Google-Smtp-Source: AGHT+IExEk7nXbgT7/gjlTCKUgUTTzyPjiURhgMzHPaOUZaB8djl4uttlE++4fo+dgJNilA2hAoEUw==
X-Received: by 2002:a17:902:e892:b0:1fc:327a:1f48 with SMTP id
 d9443c01a7336-1ff57258160mr28754585ad.12.1722581461245; 
 Thu, 01 Aug 2024 23:51:01 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff592b5434sm9682025ad.298.2024.08.01.23.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:51:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 15:49:53 +0900
Subject: [PATCH for-9.2 v6 9/9] pcie_sriov: Make a PCI device with
 user-created VF ARI-capable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-sriov-v6-9-0c8ff49c4276@daynix.com>
References: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
In-Reply-To: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/system/sriov.rst       |  3 ++-
 include/hw/pci/pcie_sriov.h |  7 +++++--
 hw/pci/pcie_sriov.c         | 12 ++++++++----
 hw/virtio/virtio-pci.c      | 16 ++++++++++------
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/docs/system/sriov.rst b/docs/system/sriov.rst
index a851a66a4b8b..d12178f3c319 100644
--- a/docs/system/sriov.rst
+++ b/docs/system/sriov.rst
@@ -28,7 +28,8 @@ virtio-net-pci functions to a bus. Below is a command line example:
 The VFs specify the paired PF with ``sriov-pf`` property. The PF must be
 added after all VFs. It is the user's responsibility to ensure that VFs have
 function numbers larger than one of the PF, and that the function numbers
-have a consistent stride.
+have a consistent stride. Both the PF and VFs are ARI-capable so you can have
+255 VFs at maximum.
 
 You may also need to perform additional steps to activate the SR-IOV feature on
 your guest. For Linux, refer to [1]_.
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index f75b8f22ee92..aeaa38cf3456 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -43,12 +43,15 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
 
 /**
  * pcie_sriov_pf_init_from_user_created_vfs() - Initialize PF with user-created
- *                                              VFs.
+ *                                              VFs, adding ARI to PF
  * @dev: A PCIe device being realized.
  * @offset: The offset of the SR-IOV capability.
  * @errp: pointer to Error*, to store an error if it happens.
  *
- * Return: The size of added capability. 0 if the user did not create VFs.
+ * Initializes a PF with user-created VFs, adding the ARI extended capability to
+ * the PF. The VFs should call pcie_ari_init() to form an ARI device.
+ *
+ * Return: The size of added capabilities. 0 if the user did not create VFs.
  *         -1 if failed.
  */
 int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 0c875e61fe96..64c655db29c4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -90,12 +90,10 @@ static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
     }
 
     if (total_vfs) {
-        uint16_t ari_cap = pcie_find_capability(dev, PCI_EXT_CAP_ID_ARI);
         uint16_t first_vf_devfn = dev->devfn + vf_offset;
         uint16_t last_vf_devfn = first_vf_devfn + vf_stride * (total_vfs - 1);
 
-        if ((!ari_cap && PCI_SLOT(dev->devfn) != PCI_SLOT(last_vf_devfn)) ||
-            last_vf_devfn >= PCI_DEVFN_MAX) {
+        if (last_vf_devfn >= PCI_DEVFN_MAX) {
             error_setg(errp, "VF function number overflows");
             return false;
         }
@@ -257,6 +255,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
     PCIDevice **vfs;
     BusState *bus = qdev_get_parent_bus(DEVICE(dev));
     uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
+    uint16_t size = PCI_EXT_CAP_SRIOV_SIZEOF;
     uint16_t vf_dev_id;
     uint16_t vf_offset;
     uint16_t vf_stride;
@@ -323,6 +322,11 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
         return -1;
     }
 
+    if (!pcie_find_capability(dev, PCI_EXT_CAP_ID_ARI)) {
+        pcie_ari_init(dev, offset + size);
+        size += PCI_ARI_SIZEOF;
+    }
+
     for (i = 0; i < pf->len; i++) {
         vfs[i]->exp.sriov_vf.pf = dev;
         vfs[i]->exp.sriov_vf.vf_number = i;
@@ -343,7 +347,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
         }
     }
 
-    return PCI_EXT_CAP_SRIOV_SIZEOF;
+    return size;
 }
 
 bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 0c8fcc5627d5..b19e2983ee22 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2102,12 +2102,16 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
                          PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
     }
 
-    res = pcie_sriov_pf_init_from_user_created_vfs(&proxy->pci_dev,
-                                                   proxy->last_pcie_cap_offset,
-                                                   errp);
-    if (res > 0) {
-        proxy->last_pcie_cap_offset += res;
-        virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+    if (pci_is_vf(&proxy->pci_dev)) {
+        pcie_ari_init(&proxy->pci_dev, proxy->last_pcie_cap_offset);
+        proxy->last_pcie_cap_offset += PCI_ARI_SIZEOF;
+    } else {
+        res = pcie_sriov_pf_init_from_user_created_vfs(
+            &proxy->pci_dev, proxy->last_pcie_cap_offset, errp);
+        if (res > 0) {
+            proxy->last_pcie_cap_offset += res;
+            virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+        }
     }
 }
 

-- 
2.45.2


