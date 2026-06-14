Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C922CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqA9-0007V0-Sg; Sun, 14 Jun 2026 15:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqA6-0007T2-Ka
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqA4-0001ha-Mo
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AahjjTLQOyTNWb1UvcaPKOl496wgFN55dOSBC6NQswI=;
 b=eoYFEqsj6NpPKfEu9fNA4D1Nkewjn3s4Q+z0z5Gr6E1hcnqPQxNEnfffSyAsPrKrb/dXR2
 BA1Q2NiYDiHOuxs/XrjH16ZgPWI5fexpf1wkSI/Of/JovK+njC2n5OVh2Q6oq4DlDVtpyg
 xV8Xt4OfAcFU1dCcBpxxSDTQbnNUqpE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-jmbeTpTpPGqh-UQ04r1CcQ-1; Sun, 14 Jun 2026 15:06:20 -0400
X-MC-Unique: jmbeTpTpPGqh-UQ04r1CcQ-1
X-Mimecast-MFC-AGG-ID: jmbeTpTpPGqh-UQ04r1CcQ_1781463980
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b8adf8b8so22501015e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463979; x=1782068779; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AahjjTLQOyTNWb1UvcaPKOl496wgFN55dOSBC6NQswI=;
 b=TnWV2DAygcH8i0uTXrdSZjNpgNtTKw4ncpLXYt+wW0nSCVq1b3PqE1b8Ht/DkFSrp6
 ZhWeILOFTpNOfqiwo/zGqn0wr3eMa5c5wBFzMOAFU2ME1yhLu5fHVl8ujLZ/xdtifQs5
 OPL+UyZWtQ3zpuQla1Co7AB4EzcyLLUp6RdsoCqbNgQnyInkvXnyVFWn6qVueedNjI6n
 2YW+QIuF6Qs0vsOZ+hn9qVcl6kMfgsFg91p7qAtNgMlk6ivTGwgH0ywswKqO1stCNF9k
 6xpE8thh6lRa8ZDNfnLKeZJPJuuNpiDPu+1SO2M0ZESchpXuS8gYiBoR34JxoHMjzrcI
 GW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463979; x=1782068779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AahjjTLQOyTNWb1UvcaPKOl496wgFN55dOSBC6NQswI=;
 b=nHe3cQgB4M9ygjT30oY6WON9f6gfyyVTCTJZOuJEzFby0TU2WGssi/8sguY1KM+8A4
 8UrN0nc2D0rsLuwwF3wwbd4td+lL7euKQezihKLevcxjDIyYx0guxxRg99bj9+fObs8X
 taM3qF04Vi7d9xX1qA4B++ngi4b6zb4NhJbT+12LVGsVX9JGZhHQd1kOUAezxru/C2NO
 5UqLOZacUFzr+UJ1UrVCF8+4i5CjuxpF6GkOfRN/WTTN8REEAhkS9AqO/XTP9xdPrTTC
 jN9NvmSxdlARCsPGUPMfWxFNkbndKtT67NFlLmIgHa9K5wwAyJ5tLy4Cj4ZKmfl6Iyro
 b6Rg==
X-Gm-Message-State: AOJu0Yz2E5nSZzHE06BboWHkDMFiD8leUVKSWue4i20GiqKJl/a8+ZLc
 tIxWd6Vik8nqSgGNsnwmlFUEF/7jkKDfEVMHCkVcRAL3ClKuZxVv+BYR0lYwG0Rz1CIv7MQR/0w
 fsfEzc7PuFN34z6ahuTIeBu5RElZNNpBDuSP8WdKrUZ7JpihRYzykwY0ovIzZT7VbpF1NkXdUE0
 YCx3lH771CubqJPpzIOkGaM+JakWGc1SEJQw==
X-Gm-Gg: Acq92OF3Hr28DDgKzDIUs8t8wmg+OgqfpwDdO6pZiheTZEA5+2OL7pIQJ9488jcUiya
 dE6dJKtsVyZH+MIUG+ntOl6VaQQ1EGVKEUGHzq7qxtXjMDITWlwunAq5oUDlEKYhhlenjIqH6hB
 +JxXiUB1Uv09P7fIuZ4DS8p7c81GLNQirYiWkT4Z6VM0QyR3xa2iWwxVvEwHfW5+b43cZaqnfek
 0vvt/Moz4XuEMl2XTyKnW6QjhmJ8ShbFrQo6dpthzS6I28QAMYCeIUkGz0WnyxCmVlXG3g5Fb7C
 gM+8Z1AgY8CnUJ8rU8JXFnau6qOTZcbO/r7nDp6SZCA48DyqHA9Btgri9v7KdkB8yoJ1nffQBsC
 k9lpGHMCBe1MxBJ7GDK/HvNHpdMzHm6ftVROz6ucua1Y=
X-Received: by 2002:a05:600c:468d:b0:490:9588:bdae with SMTP id
 5b1f17b1804b1-490ec4ee664mr165207535e9.18.1781463979547; 
 Sun, 14 Jun 2026 12:06:19 -0700 (PDT)
X-Received: by 2002:a05:600c:468d:b0:490:9588:bdae with SMTP id
 5b1f17b1804b1-490ec4ee664mr165207045e9.18.1781463978993; 
 Sun, 14 Jun 2026 12:06:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220304180sm179880865e9.4.2026.06.14.12.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:18 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Xudong Hao <xudong.hao@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 014/106] intel_iommu: Use IOMMU_NO_PASID and delete PASID_0
Message-ID: <6c4467745c27676e8bda6d9eb0bb2a70d2a7bca6.1781463125.git.mst@redhat.com>
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

In previous patch we introduced a global macro IOMMU_NO_PASID(0) for
the RID attachment, this makes the local macro PASID_0 redundant.
Delete it and use IOMMU_NO_PASID instead.

No functional changes intended.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-10-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c          | 22 +++++++++++-----------
 hw/i386/intel_iommu_accel.c    |  2 +-
 hw/i386/intel_iommu_internal.h |  1 -
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 539e8f5763..3784910ce0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -941,7 +941,7 @@ static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
     dma_addr_t pasid_dir_base;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = PASID_0;
+        pasid = IOMMU_NO_PASID;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
     return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
@@ -958,7 +958,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = PASID_0;
+        pasid = IOMMU_NO_PASID;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
 
@@ -1501,9 +1501,9 @@ static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
 
     /*
      * Make sure in Scalable Mode, a present context entry
-     * has valid pasid entry setting at PASID_0.
+     * has valid pasid entry setting at IOMMU_NO_PASID.
      */
-    return vtd_ce_get_pasid_entry(s, ce, &pe, PASID_0);
+    return vtd_ce_get_pasid_entry(s, ce, &pe, IOMMU_NO_PASID);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1564,7 +1564,7 @@ int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         }
     } else {
         /*
-         * Check if the programming of pasid setting of PASID_0
+         * Check if the programming of pasid setting of IOMMU_NO_PASID
          * is valid, and thus avoids to check pasid entry fetching
          * result in future helper function calling.
          */
@@ -2123,7 +2123,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     vtd_iommu_lock(s);
 
     if (pasid == PCI_NO_PASID && s->root_scalable) {
-        pasid = PASID_0;
+        pasid = IOMMU_NO_PASID;
     }
 
     /* Try to fetch pte from IOTLB */
@@ -2488,7 +2488,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 }
 
 /*
- * There is no pasid field in iotlb invalidation descriptor, so PCI_NO_PASID
+ * There is no pasid field in iotlb invalidation descriptor, so IOMMU_NO_PASID
  * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
  * descriptor is passed which should not be PCI_NO_PASID.
  */
@@ -2509,10 +2509,10 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
              * In legacy mode, vtd_as->pasid == pasid is always true.
              * In scalable mode, for vtd address space backing a PCI
              * device without pasid, needs to compare pasid with
-             * PASID_0 of this device.
+             * IOMMU_NO_PASID of this device.
              */
             if (!(vtd_as->pasid == pasid ||
-                  (vtd_as->pasid == PCI_NO_PASID && pasid == PASID_0))) {
+                  (vtd_as->pasid == PCI_NO_PASID && pasid == IOMMU_NO_PASID))) {
                 continue;
             }
 
@@ -2564,7 +2564,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
     vtd_iommu_unlock(s);
-    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, PCI_NO_PASID);
+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, IOMMU_NO_PASID);
 }
 
 /* Flush IOTLB
@@ -3023,7 +3023,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                       vtd_as->devfn, &ce) &&
             domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
-            if ((vtd_as->pasid != PCI_NO_PASID || pasid != PASID_0) &&
+            if ((vtd_as->pasid != PCI_NO_PASID || pasid != IOMMU_NO_PASID) &&
                 vtd_as->pasid != pasid) {
                 continue;
             }
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 6a12cdac10..14180f61cd 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -217,7 +217,7 @@ static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
 
     did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
 
-    if (piotlb_info->domain_id == did && piotlb_info->pasid == PASID_0) {
+    if (piotlb_info->domain_id == did && piotlb_info->pasid == IOMMU_NO_PASID) {
         HostIOMMUDeviceIOMMUFD *hiodi =
             HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
         uint32_t entry_num = 1; /* Only implement one request for simplicity */
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index d738ef1803..ee59df09f8 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -615,7 +615,6 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CTX_ENTRY_LEGACY_SIZE     16
 #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
 
-#define PASID_0                             0
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
-- 
MST


