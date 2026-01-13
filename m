Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D803AD29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfar7-0003V4-Bp; Tue, 13 Jan 2026 04:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqx-00039l-7Z
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqv-0003Tg-Im
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=acIPCCq6BYTz03H6ermtQrrs5LawRKp9JbbGzGgjjWw=;
 b=ieI1+M2Kcxbm4nCsWFafy2SZBBf1GwGmpba3pCYT7bKgA7FiKl6gJHNkVcYI0EUy5NjPOR
 NX7h3CDbd8h71TjBRgu5YoDWZcvQN4ORIzw59YjvQFvHUPGG/6yvS2jZScElGLYp3cjw0G
 2irMIgjJDVM6F4iLtV7qoc/LQgYEuJ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-DO_1QOLMOdu8MFh9GVKpUQ-1; Tue,
 13 Jan 2026 04:38:14 -0500
X-MC-Unique: DO_1QOLMOdu8MFh9GVKpUQ-1
X-Mimecast-MFC-AGG-ID: DO_1QOLMOdu8MFh9GVKpUQ_1768297093
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED06618005AD; Tue, 13 Jan 2026 09:38:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C437B30001A2; Tue, 13 Jan 2026 09:38:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 31/41] hw/pci: Introduce pci_device_get_host_iommu_quirks()
Date: Tue, 13 Jan 2026 10:36:27 +0100
Message-ID: <20260113093637.1549214-32-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

In VFIO core, we call iommufd_backend_get_device_info() to return vendor
specific hardware information data, but it's not good to retrieve this raw
data in VFIO core.

Introduce a new PCIIOMMUOps optional callback, get_host_iommu_quirk() which
allows to retrieve the vendor specific hardware information data and convert
it into bitmaps defined with enum host_iommu_quirks.

pci_device_get_host_iommu_quirks() is a wrapper that can be called on a PCI
device potentially protected by a vIOMMU.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20260106062808.316574-2-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/core/iommu.h |  5 +++++
 include/hw/pci/pci.h    | 31 +++++++++++++++++++++++++++++++
 hw/pci/pci.c            | 12 ++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index fcbbcd10150e6e675fb68c817e786bf23b301892..d5401a397b2a47d0cf78246232828c93b6392b71 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -22,4 +22,9 @@ enum viommu_flags {
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
 };
 
+/* Host IOMMU quirks. Extracted from host IOMMU capabilities */
+enum host_iommu_quirks {
+    HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
+};
+
 #endif /* HW_IOMMU_H */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 868817cc05ae26832246269eb4a1637c8e6ae64b..6fd8984c99088906fcac73c1f95d2c7f84380c4e 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -474,6 +474,23 @@ typedef struct PCIIOMMUOps {
      * enum viommu_flags.
      */
     uint64_t (*get_viommu_flags)(void *opaque);
+    /**
+     * @get_host_iommu_quirks: get host IOMMU quirks
+     *
+     * Optional callback, if not implemented, then vIOMMU doesn't support
+     * converting @type specific hardware information data into a standard
+     * bitmap format.
+     *
+     * @type: IOMMU hardware info type
+     *
+     * @caps: IOMMU @type specific hardware information data
+     *
+     * @size: size of @caps
+     *
+     * Returns: bitmap with each bit representing a host IOMMU quirk defined in
+     * enum host_iommu_quirks
+     */
+    uint64_t (*get_host_iommu_quirks)(uint32_t type, void *caps, uint32_t size);
     /**
      * @get_iotlb_info: get properties required to initialize a device IOTLB.
      *
@@ -666,6 +683,20 @@ void pci_device_unset_iommu_device(PCIDevice *dev);
  */
 uint64_t pci_device_get_viommu_flags(PCIDevice *dev);
 
+/**
+ * pci_device_get_host_iommu_quirks: get host IOMMU quirks.
+ *
+ * Returns: bitmap with each bit representing a host IOMMU quirk defined in
+ * enum host_iommu_quirks. Or 0 if vIOMMU doesn't convert any.
+ *
+ * @dev: PCI device pointer.
+ * @type: IOMMU hardware info type
+ * @caps: IOMMU @type specific hardware information data
+ * @size: size of @caps
+ */
+uint64_t pci_device_get_host_iommu_quirks(PCIDevice *dev, uint32_t type,
+                                          void *caps, uint32_t size);
+
 /**
  * pci_iommu_get_iotlb_info: get properties required to initialize a
  * device IOTLB.
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index a136e772a39fd3fb1b3631351dbea710227bedfe..8cbf5f5d703847166c94aaae4d1d5f33c3dc1def 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -3032,6 +3032,18 @@ uint64_t pci_device_get_viommu_flags(PCIDevice *dev)
     return 0;
 }
 
+uint64_t pci_device_get_host_iommu_quirks(PCIDevice *dev, uint32_t type,
+                                          void *caps, uint32_t size)
+{
+    PCIBus *iommu_bus;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    if (iommu_bus && iommu_bus->iommu_ops->get_host_iommu_quirks) {
+        return iommu_bus->iommu_ops->get_host_iommu_quirks(type, caps, size);
+    }
+    return 0;
+}
+
 int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
                          bool exec_req, hwaddr addr, bool lpig,
                          uint16_t prgi, bool is_read, bool is_write)
-- 
2.52.0


