Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B46AD29DF7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaqH-00086d-R4; Tue, 13 Jan 2026 04:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqF-0007qB-EO
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqD-0003Ll-Pr
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rh+r0MErbom7aUEI17w5YTrlgY2yEdWfy4ic/bfvkHA=;
 b=aolIsNMukIKl6TCuLf2VCWXieTfgepMDCKg07PztnVr5rOiDtwSna/iGYHIbZp2A5SnyLJ
 3ItU6R5xrF/H2vZ2okcUMUGzOhSFk4LQGEqJXuEQEIDmImmaSyl6aHq+V2dTVC06FiM0Ug
 2F5MBF/uCUlBAqLwYG8qys2U0OPZuJo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-8ThEKYj_Omeyx51BNMarqQ-1; Tue,
 13 Jan 2026 04:37:25 -0500
X-MC-Unique: 8ThEKYj_Omeyx51BNMarqQ-1
X-Mimecast-MFC-AGG-ID: 8ThEKYj_Omeyx51BNMarqQ_1768297044
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57FA6195605B; Tue, 13 Jan 2026 09:37:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25D0630001A2; Tue, 13 Jan 2026 09:37:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/41] intel_iommu_accel: Stick to system MR for IOMMUFD backed
 host device when x-flts=on
Date: Tue, 13 Jan 2026 10:36:09 +0100
Message-ID: <20260113093637.1549214-14-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When guest enables scalable mode and setup first stage page table, we don't
want to use IOMMU MR but rather continue using the system MR for IOMMUFD
backed host device.

Then default HWPT in VFIO contains GPA->HPA mappings which could be reused
as nesting parent HWPT to construct nested HWPT in vIOMMU.

Move vtd_as_key into intel_iommu_internal.h as it's also used by accel code.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260106061304.314546-12-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i386/intel_iommu_accel.h    |  6 ++++++
 hw/i386/intel_iommu_internal.h | 11 +++++++++++
 hw/i386/intel_iommu.c          | 28 +++++++++++++++-------------
 hw/i386/intel_iommu_accel.c    | 18 ++++++++++++++++++
 4 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 1d1fffb731a0daaf81f283e996707b25738eb5b6..9558148c517bd9c46e95e49c1884152f6c370799 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -15,6 +15,7 @@
 #ifdef CONFIG_VTD_ACCEL
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
+VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
                                         VTDHostIOMMUDevice *vtd_hiod,
@@ -24,5 +25,10 @@ static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
     error_append_hint(errp, "CONFIG_VTD_ACCEL is not enabled");
     return false;
 }
+
+static inline VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
+{
+    return NULL;
+}
 #endif
 #endif
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 02522f64e0796dfcb40945e62961d60be24a98ae..d8dad183043798d7c052a5b0767ab662ef3e9960 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -685,4 +685,15 @@ typedef struct VTDHostIOMMUDevice {
     uint8_t devfn;
     HostIOMMUDevice *hiod;
 } VTDHostIOMMUDevice;
+
+/*
+ * PCI bus number (or SID) is not reliable since the device is usaully
+ * initialized before guest can configure the PCI bridge
+ * (SECONDARY_BUS_NUMBER).
+ */
+struct vtd_as_key {
+    PCIBus *bus;
+    uint8_t devfn;
+    uint32_t pasid;
+};
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0817b1777220072f6b10e13af73b1c6434447d1a..d5a4e02fa1138e0195b6ac225512dafe041e0605 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -55,17 +55,6 @@
 #define VTD_PE_GET_SS_LEVEL(pe) \
     (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
 
-/*
- * PCI bus number (or SID) is not reliable since the device is usaully
- * initialized before guest can configure the PCI bridge
- * (SECONDARY_BUS_NUMBER).
- */
-struct vtd_as_key {
-    PCIBus *bus;
-    uint8_t devfn;
-    uint32_t pasid;
-};
-
 /* bus/devfn is PCI device's real BDF not the aliased one */
 struct vtd_hiod_key {
     PCIBus *bus;
@@ -1730,12 +1719,25 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 /* Return whether the device is using IOMMU translation. */
 static bool vtd_switch_address_space(VTDAddressSpace *as)
 {
+    IntelIOMMUState *s;
     bool use_iommu, pt;
 
     assert(as);
 
-    use_iommu = as->iommu_state->dmar_enabled && !vtd_as_pt_enabled(as);
-    pt = as->iommu_state->dmar_enabled && vtd_as_pt_enabled(as);
+    s = as->iommu_state;
+    use_iommu = s->dmar_enabled && !vtd_as_pt_enabled(as);
+    pt = s->dmar_enabled && vtd_as_pt_enabled(as);
+
+    /*
+     * When guest enables scalable mode and sets up first stage page table,
+     * we stick to system MR for IOMMUFD backed host device. Then its
+     * default hwpt contains GPA->HPA mappings which is used directly if
+     * PGTT=PT and used as nesting parent if PGTT=FST. Otherwise fall back
+     * to original processing.
+     */
+    if (s->root_scalable && s->fsts && vtd_find_hiod_iommufd(as)) {
+        use_iommu = false;
+    }
 
     trace_vtd_switch_address_space(pci_bus_num(as->bus),
                                    VTD_PCI_SLOT(as->devfn),
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 99f173b2486c4bd05d6cfeed56d03c3efc6a658d..acc9cad959ef2e00f5b2783ea3975a91493d0521 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -50,3 +50,21 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                "host IOMMU is incompatible with guest first stage translation");
     return false;
 }
+
+VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
+{
+    IntelIOMMUState *s = as->iommu_state;
+    struct vtd_as_key key = {
+        .bus = as->bus,
+        .devfn = as->devfn,
+    };
+    VTDHostIOMMUDevice *vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev,
+                                                       &key);
+
+    if (vtd_hiod && vtd_hiod->hiod &&
+        object_dynamic_cast(OBJECT(vtd_hiod->hiod),
+                            TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+        return vtd_hiod;
+    }
+    return NULL;
+}
-- 
2.52.0


