Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE31D29DF7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfarX-0004KT-4e; Tue, 13 Jan 2026 04:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfar0-0003Ck-L9
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqz-0003U4-0c
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0UF7ynqYRkpmQCabpzEd+x3V7/Hjn5OOWN/GopW2PE=;
 b=KSO1qANdr8Ef47cTgDwi2AlId/SiZdCA4zqW+qwx70MakrEUgyl1yyobHxSvYjXFyAFZHL
 8pOkbi6Z9YrPbYNN3G764aRUoWH/Z5SP2E8MegcwJ3TQ4Eh1eh+IVzGJGHF8/7Qg+w89Fn
 Dy4NzynGKtU6y87dZ+AMDdsizZdd4v0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-9j9WU-usNH2VbzMjBU6Bkw-1; Tue,
 13 Jan 2026 04:38:16 -0500
X-MC-Unique: 9j9WU-usNH2VbzMjBU6Bkw-1
X-Mimecast-MFC-AGG-ID: 9j9WU-usNH2VbzMjBU6Bkw_1768297095
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4880F1956088; Tue, 13 Jan 2026 09:38:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52C2A30001A2; Tue, 13 Jan 2026 09:38:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 32/41] intel_iommu_accel: Implement get_host_iommu_quirks()
 callback
Date: Tue, 13 Jan 2026 10:36:28 +0100
Message-ID: <20260113093637.1549214-33-clg@redhat.com>
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

Implement get_host_iommu_quirks() callback to retrieve the vendor specific
hardware information data and convert it into bitmaps defined with enum
host_iommu_quirks. It will be used by VFIO in subsequent patch.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20260106062808.316574-3-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i386/intel_iommu_accel.h |  5 +++++
 hw/i386/intel_iommu.c       |  2 ++
 hw/i386/intel_iommu_accel.c | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 6dec8788f18d0196550b3d0047dc5a5b29ed2c6b..e5f0b077b4b9ab7a58796107e78ab8a7d0a0bd20 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -20,6 +20,7 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
 void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
+void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
                                         VTDHostIOMMUDevice *vtd_hiod,
@@ -47,5 +48,9 @@ static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
                                                     uint64_t npages, bool ih)
 {
 }
+
+static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
+{
+}
 #endif
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bb21ae1743d2bf0dc91c4fc18026f449a290814b..e8a6f50a5a03e71b5f6025dce5f9510e0a31f020 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5590,6 +5590,8 @@ static void vtd_class_init(ObjectClass *klass, const void *data)
     x86_class->int_remap = vtd_int_remap;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
+
+    vtd_iommu_ops_update_accel(&vtd_iommu_ops);
 }
 
 static const TypeInfo vtd_info = {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 250232b5a979e9b34d161fde554fd0c64b0cd3d9..67d54849f2f08187629fca5e2c081f8dd003b6b2 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -12,6 +12,7 @@
 #include "system/iommufd.h"
 #include "intel_iommu_internal.h"
 #include "intel_iommu_accel.h"
+#include "hw/core/iommu.h"
 #include "hw/pci/pci_bus.h"
 #include "trace.h"
 
@@ -249,3 +250,23 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
     g_hash_table_foreach(s->vtd_address_spaces,
                          vtd_flush_host_piotlb_locked, &piotlb_info);
 }
+
+static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
+                                          void *caps, uint32_t size)
+{
+    struct iommu_hw_info_vtd *vtd = caps;
+    uint64_t quirks = 0;
+
+    if (type == IOMMU_HW_INFO_TYPE_INTEL_VTD &&
+        sizeof(struct iommu_hw_info_vtd) <= size &&
+        vtd->flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
+        quirks |= HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO;
+    }
+
+    return quirks;
+}
+
+void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
+{
+    ops->get_host_iommu_quirks = vtd_get_host_iommu_quirks;
+}
-- 
2.52.0


