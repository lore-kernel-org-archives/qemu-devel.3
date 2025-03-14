Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE58C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 06:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsyL5-00054m-Ca; Fri, 14 Mar 2025 02:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKp-0004eR-Sj
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:16:00 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKn-0005RS-6h
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:55 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3014678689aso1495508a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 23:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741932951; x=1742537751;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aDmNiobrgHSYmMXzr2eeE+YlrOKJQMXJ7JvFhGvAhTY=;
 b=Xu0Cm+JV1yds4kCxkScNfYR0ZltVDsdvWdwVEjoUdpA8bZbH9jwX84HRfpkIeBAboJ
 2ItJvzD3sYZRyo63kQQpt89nzhrY2F2giIt8RQZ+bLzDhV69ylNMwHYaV/2bk4Imt0YX
 LZQrF48Gv0bqDgP4xJTx70UAfk/eVUhmPp7qxbPqJMQ7Dami7xYZQjVKNattmCd0Z56Y
 9Ms7lTSRDu26/YSgsryIkGzuLrA1Fn2lTcJh0Fz93OBDxTN61C++c9VQOCceG1yy4h/B
 8cBLHOFl/hWlsFEPqGD0P0ydGd95VmulRmuHyPJUUt37PdaLKT2NI0zk4lSKK0Nn6v9q
 nIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741932951; x=1742537751;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aDmNiobrgHSYmMXzr2eeE+YlrOKJQMXJ7JvFhGvAhTY=;
 b=VSNlwmU69A8ZFgXzehP37yijUHbMATo9msXk/ZUWni9hvKgcJsc512zw8uLlVU3EMP
 thSm4I50RM8yRHR2S05bSquec/6yuCGEAqJr7H2Qh402e8Y6bVEgJZsUgp9mHTvqs001
 wJU9GiTpAE08Ftp6bK5jvJ4IVd4OEfjcObJBS1Fqtz3y/plhNi1uGj0+ZUSisoyoVrZk
 Ztg2+PxavWv59CkcuWiT2gZFjVrVlNRYtlTktLJG7xW913xVFJH1AU9yYDNClh+/p3Pa
 Big1ScH7Tgbn1kMCCJ/AwOXjYLywXtZWNI7pzdiRvMfmcYt6Tau0J33UyDLKEwoT0A3c
 SL4Q==
X-Gm-Message-State: AOJu0YyM+I0wb3OWSmMcMoOlsHcTdCDHrgDllGF7W+i2IDWv0HtWD/+D
 BIYdKgp4oLIKmpwSMA7q9ARy5xZCb00DspHsgEG2l0cU58kFnqUW2a2CQp3tqUc=
X-Gm-Gg: ASbGncsflbfXe2gZG9JLxI/xGPXF7Kg5Rcr1GRi7Y7zwjQn5/fZAqR5x/KZiOv2oFTm
 7wxoPlQgxQ3xbLVYECxVe/x0JPN5WdGcY8Z39a4VQHoDi3ITrGnvvw+CXZc3XI+mO9Su7DdEW42
 YIQ5u4nYniQZLSYEikb6Zm5qksF8Vwf6pyfgDJVs0YC3gnHv9Iv5kPmg5/LKyPHto8wGSMtdmWd
 c4jXjpwPUKiX386qseIH38J5daW4MTza8O1HiuviDQ3JrTyN0KAkT/2bBZEF/Tr80vv+K2EbBh+
 gEqaeE9yTfOQIYn0ol4OkuvMVijgzLuH3HS//Ly914WpWGjd
X-Google-Smtp-Source: AGHT+IHN/A1L3pK5BOJ7R40Ifrc6ai1arICxo/VWDe0ogICHPUxULNY5mucYKrRTB4VkzSyPuBGTag==
X-Received: by 2002:a17:90b:3d50:b0:2fa:13d9:39c with SMTP id
 98e67ed59e1d1-30151ce324fmr2304218a91.14.1741932951419; 
 Thu, 13 Mar 2025 23:15:51 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-225c6ba6f38sm23155685ad.129.2025.03.13.23.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 23:15:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 14 Mar 2025 15:14:58 +0900
Subject: [PATCH for-10.1 v9 9/9] pcie_sriov: Make a PCI device with
 user-created VF ARI-capable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sriov-v9-9-57dae8ae3ab5@daynix.com>
References: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
In-Reply-To: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/system/sriov.rst       |  3 ++-
 include/hw/pci/pcie_sriov.h |  7 +++++--
 hw/pci/pcie_sriov.c         |  8 +++++++-
 hw/virtio/virtio-pci.c      | 16 ++++++++++------
 4 files changed, 24 insertions(+), 10 deletions(-)

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
index 08f707e847fd..3ad18744f4a8 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -245,6 +245,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
     PCIDevice **vfs;
     BusState *bus = qdev_get_parent_bus(DEVICE(dev));
     uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
+    uint16_t size = PCI_EXT_CAP_SRIOV_SIZEOF;
     uint16_t vf_dev_id;
     uint16_t vf_offset;
     uint16_t vf_stride;
@@ -311,6 +312,11 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
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
@@ -331,7 +337,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
         }
     }
 
-    return PCI_EXT_CAP_SRIOV_SIZEOF;
+    return size;
 }
 
 bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 2463bff2ea5b..58abdda04bc3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2111,12 +2111,16 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
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
2.48.1


