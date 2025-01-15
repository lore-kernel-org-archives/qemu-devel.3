Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6A3C02187
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7pE-0006Ql-Rw; Wed, 15 Jan 2025 13:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pC-0006QG-E1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pA-0006XU-LV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mAoiUmsYN9Y3NroFhTF2ZOwH0Iq7c411sIjbila1LWg=;
 b=JVCMDpA4J/vgyQDEtJIW9vIjxdsk3CRBn8pzp38WqMIu8lQs6OSI54tFYVcQt7EEnSiHd+
 fRh8yLYhnik0kcuamRkpeEcbJ5GpxcEn9tLEtjuNil+G2DrHfYudvvczSREW3iPo4v5ufV
 cbD+YpccRyiUpxZHz5VMdFMAzoRp718=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-ghybGsBwPRGOhaYWD-OGcw-1; Wed, 15 Jan 2025 13:08:59 -0500
X-MC-Unique: ghybGsBwPRGOhaYWD-OGcw-1
X-Mimecast-MFC-AGG-ID: ghybGsBwPRGOhaYWD-OGcw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38a684a0971so42307f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964537; x=1737569337;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mAoiUmsYN9Y3NroFhTF2ZOwH0Iq7c411sIjbila1LWg=;
 b=u0wO3z21lhnu4zlRX51kRdf2FYQ80yW+Z/9U/W6FNiOEhAc2inF8geSAcRwaXIQ+nU
 5SLXB6jtHoF+9HtBk+fdsF0BCCoOAbYwfw7R55Jm9IVogvWmejYM6Iqh4ClUO7/7KaYV
 +VqpS3LIbdTpx3bXcstgQa3n2f1PzF4k4cNOr2PNZCWFxuLI50iju068jYP8LL2pGTxs
 FAWa7oxbWlzSbmr+qgHBHUM0X6Hc4E2DeqrmzEXmsMZT1JJhDPf/mSYHcIdn39fmHZb0
 1AldodkKqgRU3/Ha0RALFdDxFvV8YMhhTsIiUXQy8mCU7oFBrjfrU1XZSW8nOSdl/oO+
 VPxg==
X-Gm-Message-State: AOJu0Yyi96o4eEpgkVzR3tssbeFBJuAJGer6+FEQFM7bp8JIEKaqZ/k0
 Vopva1Gs2ydnCsy943mAtyXzTu0FDH0OH7sc0p1N1CuFLZiBc2KEOBXCOeLQoz0JPP6+WLXX4dE
 eeQ4q+xXce8ipKyDdYWCSfWjLkdCyUuerOZDOtRjWkqibipc7d0NCcB4KrDzL5ghwjUkGC18VeM
 2gO/XUKJRcUVu6PBA+4g3XQRN8k+CuLA==
X-Gm-Gg: ASbGncsQOBG0OiJXn4s/8yfpmzmlYK73e8XjbIrR4k0okeUkuIf1LgaBbYY2xXwdE2K
 XC8ZldnLjjckjsv30zVw+oVBkWNo1qFvlDJR05/eaZlt23qSIu5SWnp8SzuxBDSF/hv4sAgiWO2
 BVxVYRdu5hKbAWrizevCeMJPRdgZVGjgkBTHuWJHb+5mAlgjYS5zDFbAFnH+TVN3SRVYia1m0uJ
 4RTenYqD4VBdw4wBlDpn+h3T/1+xogzLr8skEx/IoJnmeZy4IDX
X-Received: by 2002:a05:6000:1446:b0:385:fc97:9c76 with SMTP id
 ffacd0b85a97d-38a872f7fd9mr27082249f8f.3.1736964537483; 
 Wed, 15 Jan 2025 10:08:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWqqvsWIxG+EfDPXt5YY5Dv1FgQHYVYH5ep2U7s9WbPOtNlOSqi7l8j36ZLj8grpo++jfmSA==
X-Received: by 2002:a05:6000:1446:b0:385:fc97:9c76 with SMTP id
 ffacd0b85a97d-38a872f7fd9mr27082213f8f.3.1736964537040; 
 Wed, 15 Jan 2025 10:08:57 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c6a2sm18336847f8f.54.2025.01.15.10.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:08:56 -0800 (PST)
Date: Wed, 15 Jan 2025 13:08:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 09/48] intel_iommu: Flush stage-2 cache in PASID-selective
 PASID-based iotlb invalidation
Message-ID: <ad0a7f1e1edbe841d4285a6b56f071eb3de9c86c.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Per VT-d spec 4.1, 6.5.2.4, "Table 21. PASID-based-IOTLB Invalidation",
PADID-selective PASID-based iotlb invalidation will flush stage-2 iotlb
entries with matching domain id and pasid.

With stage-1 translation introduced, guest could send PASID-selective
PASID-based iotlb invalidation to flush either stage-1 or stage-2 entries.

By this chance, remove old IOTLB related definitions which were unused.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20241212083757.605022-5-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 14 ++++--
 hw/i386/intel_iommu.c          | 85 +++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index a987023692..48019e2005 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -404,11 +404,6 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
 #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000f100ULL
 #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
-#define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
-#define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
-#define VTD_INV_DESC_IOTLB_PASID(val)   (((val) >> 32) & VTD_PASID_ID_MASK)
-#define VTD_INV_DESC_IOTLB_PASID_RSVD_LO      0xfff00000000001c0ULL
-#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI      0xf80ULL
 
 /* Mask for Device IOTLB Invalidate Descriptor */
 #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) & 0xfffffffffffff000ULL)
@@ -443,6 +438,15 @@ typedef union VTDInvDesc VTDInvDesc;
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
+/* Masks for PIOTLB Invalidate Descriptor */
+#define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
+#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
+#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
+#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
+#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
+#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d0c1d73974..bb1f43c4b3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2692,6 +2692,83 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
     return true;
 }
 
+static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
+    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
+
+    return ((entry->domain_id == info->domain_id) &&
+            (entry->pasid == info->pasid));
+}
+
+static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
+                                        uint16_t domain_id, uint32_t pasid)
+{
+    VTDIOTLBPageInvInfo info;
+    VTDAddressSpace *vtd_as;
+    VTDContextEntry ce;
+
+    info.domain_id = domain_id;
+    info.pasid = pasid;
+
+    vtd_iommu_lock(s);
+    g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
+                                &info);
+    vtd_iommu_unlock(s);
+
+    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
+        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                      vtd_as->devfn, &ce) &&
+            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
+            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
+
+            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
+                vtd_as->pasid != pasid) {
+                continue;
+            }
+
+            if (!s->flts) {
+                vtd_address_space_sync(vtd_as);
+            }
+        }
+    }
+}
+
+static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
+                                    VTDInvDesc *inv_desc)
+{
+    uint16_t domain_id;
+    uint32_t pasid;
+    uint64_t mask[4] = {VTD_INV_DESC_PIOTLB_RSVD_VAL0,
+                        VTD_INV_DESC_PIOTLB_RSVD_VAL1,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, true,
+                                     __func__, "piotlb inv")) {
+        return false;
+    }
+
+    domain_id = VTD_INV_DESC_PIOTLB_DID(inv_desc->val[0]);
+    pasid = VTD_INV_DESC_PIOTLB_PASID(inv_desc->val[0]);
+    switch (inv_desc->val[0] & VTD_INV_DESC_PIOTLB_G) {
+    case VTD_INV_DESC_PIOTLB_ALL_IN_PASID:
+        vtd_piotlb_pasid_invalidate(s, domain_id, pasid);
+        break;
+
+    case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
+        break;
+
+    default:
+        error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
+                          ", lo=0x%"PRIx64" (type mismatch: 0x%llx)",
+                          __func__, inv_desc->val[1], inv_desc->val[0],
+                          inv_desc->val[0] & VTD_INV_DESC_IOTLB_G);
+        return false;
+    }
+    return true;
+}
+
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
                                      VTDInvDesc *inv_desc)
 {
@@ -2810,6 +2887,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    case VTD_INV_DESC_PIOTLB:
+        trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
+        if (!vtd_process_piotlb_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     case VTD_INV_DESC_WAIT:
         trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_wait_desc(s, &inv_desc)) {
@@ -2837,7 +2921,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
      * iommu driver) work, just return true is enough so far.
      */
     case VTD_INV_DESC_PC:
-    case VTD_INV_DESC_PIOTLB:
         if (s->scalable_mode) {
             break;
         }
-- 
MST


