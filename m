Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD63D29DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfapi-0006RU-6X; Tue, 13 Jan 2026 04:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapg-0006GE-09
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfape-0003GV-0v
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhaoZh7qcv3Y69IN8LKpRllqRNpal1FHLT/cDourskM=;
 b=F7Gmsw4ASI0EMdBQ1rdDRbgOhxVSl3OlvZ6ngwdLOskZcQx4swSuJTc2X8ud8XE4AMLqLu
 v79OtaqzUGVEWgG7JqLS+0xC6Uz7NQ+vwBhVsL7yo6UQcsKMzwZ5UwLrFqE3/DZ3lre1AF
 NGpNe+H+FY97Val7v5UYRYRpSvriu1Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-qgoY8Eh2PF2HmoOh_JOnkw-1; Tue,
 13 Jan 2026 04:36:54 -0500
X-MC-Unique: qgoY8Eh2PF2HmoOh_JOnkw-1
X-Mimecast-MFC-AGG-ID: qgoY8Eh2PF2HmoOh_JOnkw_1768297013
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E7A61955F34; Tue, 13 Jan 2026 09:36:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D317530001A2; Tue, 13 Jan 2026 09:36:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/41] intel_iommu: Delete RPS capability related supporting
 code
Date: Tue, 13 Jan 2026 10:36:00 +0100
Message-ID: <20260113093637.1549214-5-clg@redhat.com>
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

RID-PASID Support(RPS) is not set in vIOMMU ECAP register, the supporting
code is there but never takes effect.

Meanwhile, according to VTD spec section 3.4.3:
"Implementations not supporting RID_PASID capability (ECAP_REG.RPS is 0b),
use a PASID value of 0 to perform address translation for requests without
PASID."

We should delete the supporting code which fetches RID_PASID field from
scalable context entry and use 0 as RID_PASID directly, because RID_PASID
field is ignored if no RPS support according to spec.

This simplifies the code and doesn't bring any penalty.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260106061304.314546-3-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  2 +-
 hw/i386/intel_iommu.c          | 89 +++++++++++-----------------------
 2 files changed, 28 insertions(+), 63 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 75bafdf0cde663e06a2fba0cd0cf80188c461d4c..36d04427dd7a8c0e8ebe6ebc3c5f742eefa7ce9b 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -609,7 +609,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CTX_ENTRY_LEGACY_SIZE     16
 #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
 
-#define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
+#define PASID_0                             0
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 436a30288b7b79e0d886447ddf7eddab489f2e63..2d3673db3737ce1ad7dbd5ccfd06019ae1782ce0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -41,8 +41,6 @@
 #include "trace.h"
 
 /* context entry operations */
-#define VTD_CE_GET_RID2PASID(ce) \
-    ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
 #define VTD_CE_GET_PASID_DIR_TABLE(ce) \
     ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
 #define VTD_CE_GET_PRE(ce) \
@@ -958,15 +956,12 @@ static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
                                   VTDPASIDEntry *pe, uint32_t pasid)
 {
     dma_addr_t pasid_dir_base;
-    int ret = 0;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = VTD_CE_GET_RID2PASID(ce);
+        pasid = PASID_0;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
-    ret = vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
-
-    return ret;
+    return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
 }
 
 static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
@@ -980,7 +975,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = VTD_CE_GET_RID2PASID(ce);
+        pasid = PASID_0;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
 
@@ -1520,17 +1515,15 @@ static inline int vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
     return 0;
 }
 
-static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
-                                  VTDContextEntry *ce)
+static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
 {
     VTDPASIDEntry pe;
 
     /*
      * Make sure in Scalable Mode, a present context entry
-     * has valid rid2pasid setting, which includes valid
-     * rid2pasid field and corresponding pasid entry setting
+     * has valid pasid entry setting at PASID_0.
      */
-    return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
+    return vtd_ce_get_pasid_entry(s, ce, &pe, PASID_0);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1591,15 +1584,11 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         }
     } else {
         /*
-         * Check if the programming of context-entry.rid2pasid
-         * and corresponding pasid setting is valid, and thus
-         * avoids to check pasid entry fetching result in future
-         * helper function calling.
+         * Check if the programming of pasid setting of PASID_0
+         * is valid, and thus avoids to check pasid entry fetching
+         * result in future helper function calling.
          */
-        ret_fr = vtd_ce_rid2pasid_check(s, ce);
-        if (ret_fr) {
-            return ret_fr;
-        }
+        return vtd_ce_pasid_0_check(s, ce);
     }
 
     return 0;
@@ -2108,7 +2097,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool reads = true;
     bool writes = true;
     uint8_t access_flags, pgtt;
-    bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
     VTDIOTLBEntry *iotlb_entry;
     uint64_t xlat, size;
 
@@ -2120,21 +2108,23 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 
     vtd_iommu_lock(s);
 
-    cc_entry = &vtd_as->context_cache_entry;
+    if (pasid == PCI_NO_PASID && s->root_scalable) {
+        pasid = PASID_0;
+    }
 
-    /* Try to fetch pte from IOTLB, we don't need RID2PASID logic */
-    if (!rid2pasid) {
-        iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
-        if (iotlb_entry) {
-            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
-                                     iotlb_entry->domain_id);
-            pte = iotlb_entry->pte;
-            access_flags = iotlb_entry->access_flags;
-            page_mask = iotlb_entry->mask;
-            goto out;
-        }
+    /* Try to fetch pte from IOTLB */
+    iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
+    if (iotlb_entry) {
+        trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
+                                 iotlb_entry->domain_id);
+        pte = iotlb_entry->pte;
+        access_flags = iotlb_entry->access_flags;
+        page_mask = iotlb_entry->mask;
+        goto out;
     }
 
+    cc_entry = &vtd_as->context_cache_entry;
+
     /* Try to fetch context-entry from cache first */
     if (cc_entry->context_cache_gen == s->context_cache_gen) {
         trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.hi,
@@ -2171,10 +2161,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         cc_entry->context_cache_gen = s->context_cache_gen;
     }
 
-    if (rid2pasid) {
-        pasid = VTD_CE_GET_RID2PASID(&ce);
-    }
-
     /*
      * We don't need to translate for pass-through context entries.
      * Also, let's ignore IOTLB caching as well for PT devices.
@@ -2200,19 +2186,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         return true;
     }
 
-    /* Try to fetch pte from IOTLB for RID2PASID slow path */
-    if (rid2pasid) {
-        iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
-        if (iotlb_entry) {
-            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
-                                     iotlb_entry->domain_id);
-            pte = iotlb_entry->pte;
-            access_flags = iotlb_entry->access_flags;
-            page_mask = iotlb_entry->mask;
-            goto out;
-        }
-    }
-
     if (s->flts && s->root_scalable) {
         ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
                                    &reads, &writes, s->aw_bits, pasid);
@@ -2475,20 +2448,14 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                        vtd_as->devfn, &ce);
         if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
-            uint32_t rid2pasid = PCI_NO_PASID;
-
-            if (s->root_scalable) {
-                rid2pasid = VTD_CE_GET_RID2PASID(&ce);
-            }
-
             /*
              * In legacy mode, vtd_as->pasid == pasid is always true.
              * In scalable mode, for vtd address space backing a PCI
              * device without pasid, needs to compare pasid with
-             * rid2pasid of this device.
+             * PASID_0 of this device.
              */
             if (!(vtd_as->pasid == pasid ||
-                  (vtd_as->pasid == PCI_NO_PASID && pasid == rid2pasid))) {
+                  (vtd_as->pasid == PCI_NO_PASID && pasid == PASID_0))) {
                 continue;
             }
 
@@ -2993,9 +2960,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                       vtd_as->devfn, &ce) &&
             domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
-            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
-
-            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
+            if ((vtd_as->pasid != PCI_NO_PASID || pasid != PASID_0) &&
                 vtd_as->pasid != pasid) {
                 continue;
             }
-- 
2.52.0


