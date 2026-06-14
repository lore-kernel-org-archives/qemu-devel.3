Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9C1CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAB-0007WH-JU; Sun, 14 Jun 2026 15:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqA9-0007TA-8D
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqA5-0001hq-NU
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7Dz+1RYpvjMPt0hJU20VgQJ+AEbkgW1f6Id13UARIM=;
 b=elGod5PHmKd7Jj/x6F2YpHIN0IeyWGvrHm4n/n6ayyI1HyRj9oVEMkhGo6IefjmgcdNEtO
 T87MVTDcIlZknMWQd8yrrrQ1GlDA8HVtD9+LnpDeOSRyR4+LlKNvh1qoZGa56BpY9hwmEo
 w5GttPZb7D9IBPZ5J0Af03uZnDUCRK4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-pxQpIRb9NNqRrKUVMBZY6g-1; Sun, 14 Jun 2026 15:06:23 -0400
X-MC-Unique: pxQpIRb9NNqRrKUVMBZY6g-1
X-Mimecast-MFC-AGG-ID: pxQpIRb9NNqRrKUVMBZY6g_1781463983
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef616db45so1969987f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463982; x=1782068782; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L7Dz+1RYpvjMPt0hJU20VgQJ+AEbkgW1f6Id13UARIM=;
 b=LShw74lB8yRl5SijULW1qXw0y9lJsRkd8BhgbM2HUoK047qd5PoVWFCD8TM6sHvL3P
 6s9fQMYZdtsmd8hv4l7QaMtZ47Sw98RDI5OA/IQEGmTMm1QCRjxp1NOJ/H3kMor2GbrX
 E3f4Zmk5Jm/N0TiKb+5DNzjtVk23oTtu3y6M9lS2LYDvMgxTKhBlgcWcwMpIzA7G+pPy
 /veuniOgEHbRDS33s/U97Am/DeYfCbbAmtKjjq7yN5uSrtznG+3eVf1E3bmlB0EIiy1u
 uyR+vt/1Hw9YDe6gFauTLNvxxC1kHs0JZtQL3ncat3q9SGfmzsUGTfWBmsO6ZPFZr8wM
 Aelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463982; x=1782068782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7Dz+1RYpvjMPt0hJU20VgQJ+AEbkgW1f6Id13UARIM=;
 b=c5kI+geczzj+oGHHsgJAsGrJ2dz//TU1dxfyH3Vmc0VbbD1XKRXOoBFipOjepJzSpt
 CQTwxYCyj+QDI9M120A5yhkdOaccebgxwHlDY58EMx6aL8uSoVWjm6Dm+3WJC3TNsR1x
 OLTm8rPR2UrvSIOJrD3EaLBQBImY5/VCni61J5vdVhGWSk39/uozg9Y59Rxw2GdAQp62
 1eq/JIVveGyxGXnoFBAPt6It2E09Y0jtsaoRsoi0NvxCPZmzGpqsKcXpPV2Deh5NV+DR
 vOVUbHK14Nbn1g2XhTweuSAPqUxu8SrfiR/RB5+1qHPV+2p4qXIROgobESjG5MSx+Cm1
 3/vQ==
X-Gm-Message-State: AOJu0Yy5a7nKiJCNL22LwBCYgD+yH2BkJxSJ87kQZYylOhiS3z1LRXI3
 py0DPstBnyFwP2QOsA7ehbzC0O6eTbF9omJolsPXyQBGp2R8z61L576Ad7ggIneLLiQUNBckQGz
 Os2bmojRrP//aMAQrLIb4oWmSqJgv3RsVkqxaGihhAaLGFSkmCu57PQmGK7uvqEIv11bberF512
 02FDmVTxDxXp8EbYfsmcHb8UrxtNMAjoHy5w==
X-Gm-Gg: Acq92OFNuQOuMTPOGjWJD4DUGQ5qDIcRjvWtNmQRFgbSHCxeqynes4RIep7VBX267oC
 FBbcL/uBRNNWv7YBZLWe6+skhNdUTh/fsY/3VhuLB9YX5bElxHDMgEdRi3yLyw1Ld2VHPN2piLA
 laj7mnOfJPHvKmDyVXILa/ZGPoL5D5FrmZQAC77zj3xfH9AxzQnNS54UASTccb8luA42+/YJfBf
 epMI26UKXlOb2W8k9ywNJfxtKpnlIbOl830M5fJrxwRDpB6MstushB1m1rarQJLHyJ5SGYzraau
 mdRY6aFpl1YuXp8+imIfddueS0dm2bNgS9HE5HPNo1gCPag9wkTauoLcBCRepfjlVV0GLZIXmVP
 7W9FTR3e9HztXhDyuwO5lYoMFRvrsz6zT0tWMDIMHT0U=
X-Received: by 2002:a5d:5d13:0:b0:460:e2e:6e2b with SMTP id
 ffacd0b85a97d-46074a8a1b7mr10614378f8f.20.1781463982319; 
 Sun, 14 Jun 2026 12:06:22 -0700 (PDT)
X-Received: by 2002:a5d:5d13:0:b0:460:e2e:6e2b with SMTP id
 ffacd0b85a97d-46074a8a1b7mr10614301f8f.20.1781463981619; 
 Sun, 14 Jun 2026 12:06:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3782sm23697486f8f.25.2026.06.14.12.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:21 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 015/106] intel_iommu: Refactor PASID processing to use
 IOMMU_NO_PASID internally
Message-ID: <c579197d6be77be90607d5d59e8e7f68696dfa26.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The PCI subsystem uses PCI_NO_PASID for requests-without-PASID, but VT-d
emulation uses IOMMU_NO_PASID internally (ecap.RPS==0). This leads to
conversion and checking code between PCI_NO_PASID and IOMMU_NO_PASID
throughout the implementation.

Refactor to use IOMMU PASID consistently within Intel IOMMU by storing
IOMMU PASID value in vtd_as->pasid. After this change, PCI_NO_PASID is
only used at three boundary points:

1. PCI_NO_PASID -> IOMMU_NO_PASID: Convert PCI PASID to IOMMU PASID in
   vtd_find_add_as() and cache in vtd_as->pasid.
2. IOMMU_NO_PASID -> PCI_NO_PASID: Convert when notifying UNMAP events
   via memory_region_notify_iommu() and returning IOMMUTLBEntry in
   vtd_iommu_translate().

This eliminates conversion/checks in PASID table lookups, simplifies
invalidation logic with consistent PASID values, and improves code
readability. The PCI subsystem interface remains unchanged to maintain
compatibility with other IOMMU implementations that may not use PASID 0
for requests-without-PASID.

Suggested-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-11-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c       | 166 +++++++++++++++++-------------------
 hw/i386/intel_iommu_accel.c |   2 +-
 include/system/memory.h     |   2 +-
 3 files changed, 81 insertions(+), 89 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3784910ce0..88e0c58c08 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -938,12 +938,8 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
 static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
                                   VTDPASIDEntry *pe, uint32_t pasid)
 {
-    dma_addr_t pasid_dir_base;
+    dma_addr_t pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
 
-    if (pasid == PCI_NO_PASID) {
-        pasid = IOMMU_NO_PASID;
-    }
-    pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
     return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
 }
 
@@ -953,15 +949,10 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
                                 uint32_t pasid)
 {
     int ret;
-    dma_addr_t pasid_dir_base;
+    dma_addr_t pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
     VTDPASIDDirEntry pdire;
     VTDPASIDEntry pe;
 
-    if (pasid == PCI_NO_PASID) {
-        pasid = IOMMU_NO_PASID;
-    }
-    pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
-
     /*
      * No present bit check since fpd is meaningful even
      * if the present bit is clear.
@@ -1750,7 +1741,7 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
          *
          * Need to disable ir for as with PASID.
          */
-        if (as->pasid != PCI_NO_PASID) {
+        if (as->pasid != IOMMU_NO_PASID) {
             memory_region_set_enabled(&as->iommu_ir, false);
         } else {
             memory_region_set_enabled(&as->iommu_ir, true);
@@ -1780,7 +1771,7 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
      * We enable per as memory region (iommu_ir_fault) for catching
      * the translation for interrupt range through PASID + PT.
      */
-    if (pt && as->pasid != PCI_NO_PASID) {
+    if (pt && as->pasid != IOMMU_NO_PASID) {
         memory_region_set_enabled(&as->iommu_ir_fault, true);
     } else {
         memory_region_set_enabled(&as->iommu_ir_fault, false);
@@ -1892,7 +1883,7 @@ static VTDAddressSpace *vtd_get_as_by_sid_and_pasid(IntelIOMMUState *s,
 
 VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
 {
-    return vtd_get_as_by_sid_and_pasid(s, sid, PCI_NO_PASID);
+    return vtd_get_as_by_sid_and_pasid(s, sid, IOMMU_NO_PASID);
 }
 
 static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
@@ -2109,7 +2100,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool is_fpd_set = false;
     bool reads = true;
     bool writes = true;
-    bool is_pasid = pasid != PCI_NO_PASID;
+    bool is_pasid = pasid != IOMMU_NO_PASID;
     uint8_t access_flags, pgtt;
     VTDIOTLBEntry *iotlb_entry;
     uint64_t xlat, size;
@@ -2122,10 +2113,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 
     vtd_iommu_lock(s);
 
-    if (pasid == PCI_NO_PASID && s->root_scalable) {
-        pasid = IOMMU_NO_PASID;
-    }
-
     /* Try to fetch pte from IOTLB */
     iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
     if (iotlb_entry) {
@@ -2490,7 +2477,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 /*
  * There is no pasid field in iotlb invalidation descriptor, so IOMMU_NO_PASID
  * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
- * descriptor is passed which should not be PCI_NO_PASID.
+ * descriptor is passed.
  */
 static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                              uint16_t domain_id, hwaddr addr,
@@ -2504,48 +2491,41 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
     QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                        vtd_as->devfn, &ce);
-        if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
-            /*
-             * In legacy mode, vtd_as->pasid == pasid is always true.
-             * In scalable mode, for vtd address space backing a PCI
-             * device without pasid, needs to compare pasid with
-             * IOMMU_NO_PASID of this device.
-             */
-            if (!(vtd_as->pasid == pasid ||
-                  (vtd_as->pasid == PCI_NO_PASID && pasid == IOMMU_NO_PASID))) {
-                continue;
-            }
+        if (ret || vtd_as->pasid != pasid ||
+            domain_id != vtd_get_domain_id(s, &ce, pasid)) {
+            continue;
+        }
 
-            if (vtd_as_has_map_notifier(vtd_as)) {
-                /*
-                 * When first stage translation is off, as long as we have MAP
-                 * notifications registered in any of our IOMMU notifiers,
-                 * we need to sync the shadow page table. Otherwise VFIO
-                 * device attaches to nested page table instead of shadow
-                 * page table, so no need to sync.
-                 */
-                if (!s->fsts || !s->root_scalable) {
-                    vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
-                }
-            } else {
-                /*
-                 * For UNMAP-only notifiers, we don't need to walk the
-                 * page tables.  We just deliver the PSI down to
-                 * invalidate caches.
-                 */
-                const IOMMUTLBEvent event = {
-                    .type = IOMMU_NOTIFIER_UNMAP,
-                    .entry = {
-                        .target_as = &address_space_memory,
-                        .iova = addr,
-                        .translated_addr = 0,
-                        .addr_mask = size - 1,
-                        .perm = IOMMU_NONE,
-                        .pasid = vtd_as->pasid,
-                    },
-                };
-                memory_region_notify_iommu(&vtd_as->iommu, 0, event);
+        if (vtd_as_has_map_notifier(vtd_as)) {
+            /*
+             * When first stage translation is off, as long as we have MAP
+             * notifications registered in any of our IOMMU notifiers,
+             * we need to sync the shadow page table. Otherwise VFIO
+             * device attaches to nested page table instead of shadow
+             * page table, so no need to sync.
+             */
+            if (!s->fsts || !s->root_scalable) {
+                vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
             }
+        } else {
+            /*
+             * For UNMAP-only notifiers, we don't need to walk the
+             * page tables.  We just deliver the PSI down to
+             * invalidate caches.
+             */
+            const IOMMUTLBEvent event = {
+                .type = IOMMU_NOTIFIER_UNMAP,
+                .entry = {
+                    .target_as = &address_space_memory,
+                    .iova = addr,
+                    .translated_addr = 0,
+                    .addr_mask = size - 1,
+                    .perm = IOMMU_NONE,
+                     /* Other sub-systems use PCI pasid */
+                    .pasid = pasid == IOMMU_NO_PASID ? PCI_NO_PASID : pasid,
+                },
+            };
+            memory_region_notify_iommu(&vtd_as->iommu, 0, event);
         }
     }
 }
@@ -3008,6 +2988,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     VTDIOTLBPageInvInfo info;
     VTDAddressSpace *vtd_as;
     VTDContextEntry ce;
+    int ret;
 
     info.domain_id = domain_id;
     info.pasid = pasid;
@@ -3020,17 +3001,15 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
-        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                      vtd_as->devfn, &ce) &&
-            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
-            if ((vtd_as->pasid != PCI_NO_PASID || pasid != IOMMU_NO_PASID) &&
-                vtd_as->pasid != pasid) {
-                continue;
-            }
+        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                       vtd_as->devfn, &ce);
+        if (ret || vtd_as->pasid != pasid ||
+            domain_id != vtd_get_domain_id(s, &ce, pasid)) {
+            continue;
+        }
 
-            if (!s->fsts || !vtd_as_has_map_notifier(vtd_as)) {
-                vtd_address_space_sync(vtd_as);
-            }
+        if (!s->fsts || !vtd_as_has_map_notifier(vtd_as)) {
+            vtd_address_space_sync(vtd_as);
         }
     }
 }
@@ -3239,7 +3218,7 @@ static bool vtd_process_pasid_desc(IntelIOMMUState *s,
         /* PASID selective implies a DID selective */
         trace_vtd_inv_desc_pasid_cache_psi(did, pasid);
         pc_info.did = did;
-        pc_info.pasid = pasid ?: PCI_NO_PASID;
+        pc_info.pasid = pasid;
         break;
 
     case VTD_INV_DESC_PASIDC_G_GLOBAL:
@@ -3291,6 +3270,7 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
      * ...
      */
 
+    uint32_t pasid = vtd_dev_as->pasid;
     IOMMUTLBEvent event;
     uint64_t sz;
 
@@ -3307,7 +3287,8 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
     event.entry.iova = addr;
     event.entry.perm = IOMMU_NONE;
     event.entry.translated_addr = 0;
-    event.entry.pasid = vtd_dev_as->pasid;
+    /* Other sub-systems use PCI pasid */
+    event.entry.pasid = pasid == IOMMU_NO_PASID ? PCI_NO_PASID : pasid;
     memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
 }
 
@@ -3335,7 +3316,7 @@ static bool vtd_process_device_piotlb_desc(IntelIOMMUState *s,
     sid = VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(inv_desc->lo);
     if (global) {
         QLIST_FOREACH(vtd_dev_as, &s->vtd_as_with_notifiers, next) {
-            if ((vtd_dev_as->pasid != PCI_NO_PASID) &&
+            if ((vtd_dev_as->pasid != IOMMU_NO_PASID) &&
                 (PCI_BUILD_BDF(pci_bus_num(vtd_dev_as->bus),
                                            vtd_dev_as->devfn) == sid)) {
                 do_invalidate_device_tlb(vtd_dev_as, size, addr);
@@ -3983,13 +3964,12 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 }
 
 static void vtd_prepare_identity_entry(hwaddr addr, IOMMUAccessFlags perm,
-                                         uint32_t pasid, IOMMUTLBEntry *iotlb)
+                                       IOMMUTLBEntry *iotlb)
 {
     iotlb->iova = addr & VTD_PAGE_MASK_4K;
     iotlb->translated_addr = addr & VTD_PAGE_MASK_4K;
     iotlb->addr_mask = ~VTD_PAGE_MASK_4K;
     iotlb->perm = perm;
-    iotlb->pasid = pasid;
 }
 
 static inline void vtd_prepare_error_entry(IOMMUTLBEntry *entry)
@@ -4001,6 +3981,10 @@ static inline void vtd_prepare_error_entry(IOMMUTLBEntry *entry)
     entry->pasid = PCI_NO_PASID;
 }
 
+/*
+ * This function returns translation result to other sub-system such as PCI,
+ * so iommu pasid is converted to PCI pasid and returned in IOMMUTLBEntry.
+ */
 static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
                                          IOMMUAccessFlags flag, int iommu_idx)
 {
@@ -4009,7 +3993,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     IOMMUTLBEntry iotlb = {
         /* We'll fill in the rest later. */
         .target_as = &address_space_memory,
-        .pasid = vtd_as->pasid,
+        .pasid = vtd_as->pasid == IOMMU_NO_PASID ? PCI_NO_PASID : vtd_as->pasid,
     };
     bool success;
     bool is_write = flag & IOMMU_WO;
@@ -4017,9 +4001,8 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     if (likely(s->dmar_enabled)) {
         /* Only support translated requests in scalable mode */
         if (iommu_idx == VTD_IDX_TRANSLATED && s->root_scalable) {
-            if (vtd_as->pasid == PCI_NO_PASID) {
-                vtd_prepare_identity_entry(addr, IOMMU_RW, PCI_NO_PASID,
-                                           &iotlb);
+            if (vtd_as->pasid == IOMMU_NO_PASID) {
+                vtd_prepare_identity_entry(addr, IOMMU_RW, &iotlb);
                 success = true;
             } else {
                 vtd_prepare_error_entry(&iotlb);
@@ -4034,7 +4017,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
         }
     } else {
         /* DMAR disabled, passthrough, use 4k-page*/
-        vtd_prepare_identity_entry(addr, IOMMU_RW, vtd_as->pasid, &iotlb);
+        vtd_prepare_identity_entry(addr, IOMMU_RW, &iotlb);
         success = true;
     }
 
@@ -4460,7 +4443,7 @@ static void vtd_report_sid_ir_illegal_access(IntelIOMMUState *s, uint16_t sid,
     }
 
     vtd_report_fault(s, VTD_FR_SM_INTERRUPT_ADDR, is_fpd_set, sid, addr,
-                     is_write, pasid != PCI_NO_PASID, pasid);
+                     is_write, pasid != IOMMU_NO_PASID, pasid);
 }
 
 static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
@@ -4488,7 +4471,6 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
     int ret = 0;
     MSIMessage from = {}, to = {};
     uint16_t sid = X86_IOMMU_SID_INVALID;
-    uint32_t pasid;
 
     from.address = (uint64_t) addr + VTD_INTERRUPT_ADDR_FIRST;
     from.data = (uint32_t) value;
@@ -4496,11 +4478,11 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
     if (!attrs.unspecified) {
         /* We have explicit Source ID */
         sid = attrs.requester_id;
-        pasid = attrs.pid != 0 ? attrs.pid : PCI_NO_PASID;
 
         if (attrs.address_type == PCI_AT_TRANSLATED &&
             sid != X86_IOMMU_SID_INVALID) {
-            vtd_report_sid_ir_illegal_access(s, sid, pasid, from.address, true);
+            vtd_report_sid_ir_illegal_access(s, sid, attrs.pid, from.address,
+                                             true);
             return MEMTX_ERROR;
         }
     }
@@ -4562,9 +4544,19 @@ static const MemoryRegionOps vtd_mem_ir_fault_ops = {
     },
 };
 
+/*
+ * This function is called by many PCIIOMMUOps callbacks to get
+ * VTDAddressSpace or create one if non-exist. Those callbacks are
+ * used by PCI sub-system and are passed in a PCI pasid value.
+ *
+ * VTD honors iommu pasid, so the first thing is to convert PCI
+ * pasid to iommu pasid.
+ */
 VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
                                  int devfn, unsigned int pasid)
 {
+    pasid = pasid == PCI_NO_PASID ? IOMMU_NO_PASID : pasid;
+
     /*
      * We can't simply use sid here since the bus number might not be
      * initialized by the guest.
@@ -4606,7 +4598,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
         new_key->devfn = devfn;
         new_key->pasid = pasid;
 
-        if (pasid == PCI_NO_PASID) {
+        if (pasid == IOMMU_NO_PASID) {
             snprintf(name, sizeof(name), "vtd-%02x.%x", PCI_SLOT(devfn),
                      PCI_FUNC(devfn));
         } else {
@@ -5290,7 +5282,7 @@ error_get_fpd_and_report:
     vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
 error_report:
     vtd_report_fault(s, -ret, is_fpd_set, sid, addr, is_write,
-                     vtd_as->pasid != PCI_NO_PASID, vtd_as->pasid);
+                     vtd_as->pasid != IOMMU_NO_PASID, vtd_as->pasid);
     return false;
 }
 
@@ -5381,7 +5373,7 @@ static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
      */
 
     /* We do not support PRI without PASID */
-    if (vtd_as->pasid == PCI_NO_PASID) {
+    if (vtd_as->pasid == IOMMU_NO_PASID) {
         return -EPERM;
     }
     if (exec_req && !is_read) {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 14180f61cd..05b927f303 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -207,7 +207,7 @@ static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
         return;
     }
 
-    assert(vtd_as->pasid == PCI_NO_PASID);
+    assert(vtd_as->pasid == IOMMU_NO_PASID);
 
     /* Nothing to do if there is no first stage HWPT attached */
     if (!pc_entry->valid ||
diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..1edb38b07d 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -150,7 +150,7 @@ struct IOMMUTLBEntry {
     hwaddr           translated_addr;
     hwaddr           addr_mask;  /* 0xfff = 4k translation */
     IOMMUAccessFlags perm;
-    uint32_t         pasid;
+    uint32_t         pasid; /* PCI pasid */
 };
 
 /*
-- 
MST


