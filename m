Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D87E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz73-00049T-Gn; Sat, 04 Jan 2025 03:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6m-0003s4-4Q
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:02:10 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6j-0006kO-Oc
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:02:07 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so15571200a91.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977724; x=1736582524;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ysOqYR5lQLZYXNjeXy0RSiaXesPdODAKqoYiZJpO200=;
 b=0RQq/heAPXtGxnNiltWQFoZXtkXfkFBWu7kkt4mkMsc70+CsE62hZaBUtHrkM2dJ+N
 dmJLKGgIZnOdm0vigbwjrEvKsu/pR3KPtFDjItnXr6fLtoENTQTsW5rvZQlU5/Cjj3lS
 frhc49jdIpktBb0i0UrJRcoBXoPLdPvJCVOwDGnC2kC+cyTts6eZWP4xZXYPw0gk2wzn
 ch18X2yIW/LHSAHfkRd/IVrpiM7AEJJAAwTgKF9IuYlGl2QKkMU80y4F3p9yR0xRmduV
 wFlGceVRal57sF2F4SyUvwbxVSfKzKAQrX+kTl7oW9nG24DIyFhLp2cD0EtSoYVH4KRA
 NCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977724; x=1736582524;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ysOqYR5lQLZYXNjeXy0RSiaXesPdODAKqoYiZJpO200=;
 b=Ow9Sorjcwo5kb10QS6PD+vHVBHBFWdSHduX84QgohUQQ/RfL6cDSzS5CiEast8teyA
 fbfdYnFrHcAk3qWpo/SEmyYh1M1/BdCRAWqPjlmzFvK52hzjbBvhurNmNBe8hMixuNb7
 Dk+CLV7UbmPCtJlebwDNIgJcpmPVD3uNrBiolkX5d+pRjcQmysyPCgM1eoo4V2T3IKT6
 znx/BHtvirO8tGavFTWnNO6HFRATQ89uDCl91Dzafq/cu82R6SC0fLQ7W44Tzc3E5plu
 ykblGh0uyY2istCGRBUGZU7NaHhHpxehjK2597C/WU/+xAGo6XfUzlghn5Sjnv2ZWPGC
 Hbow==
X-Gm-Message-State: AOJu0YxL0NOK73SwCNwe1CutgPZcATtBd5ob/9BGmGeBAUMlpxefnEQv
 DcApEqcYH/B1LhELKGBB7CiXqiCVbgBrKX4sCAX837/ZVx28D5QN0NR9OH/p7M0=
X-Gm-Gg: ASbGncuXjUVLBd9jPqrg8+zUBz2JBttVK3f3nwkTTDPmkXVWD1oX703emkuPTUXlZyl
 HaJt7OWH5mUf7+p54WMZf17bRChETOeQVIw5jR7Twsqrr6BEedhrDGW6P4cpJEBcLHZejwELzb3
 oOerTOPdjJ4XjeuZ9L3MhciVjF5UjUd1gXQ0XZ+YRKsuAioHHR9/NfPKJWnuKEauE15YyI4ev5e
 MESuAXzaqrcYHzd55bu0Wthqd7P+0z3YJZ/UB1nzwIxHp2ADnkGTDIkTDQp
X-Google-Smtp-Source: AGHT+IF129YrYoArS1xJ3aeUSbjZ57zkZJGR7G5Y9unzaUQaIUsizP2Qt6vV1oDp7Y6cLUvOqoAXtw==
X-Received: by 2002:a17:90b:5150:b0:2f2:a974:fc11 with SMTP id
 98e67ed59e1d1-2f4438e4576mr81496209a91.17.1735977724333; 
 Sat, 04 Jan 2025 00:02:04 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc972251sm257158295ad.96.2025.01.04.00.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:02:04 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 17:01:02 +0900
Subject: [PATCH v8 9/9] pcie_sriov: Make a PCI device with user-created VF
 ARI-capable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-sriov-v8-9-56144cfdc7d9@daynix.com>
References: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
In-Reply-To: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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
index 5ea8e7f6d0a8..e3ac5543195a 100644
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
2.47.1


