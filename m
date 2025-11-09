Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2CACCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6Vs-0002Az-EH; Sun, 09 Nov 2025 09:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vq-0002AC-RA
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vo-0001n6-T6
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=neawIxqIKpZCZv4T6g2O2IpqcqSPVDqavtFhhFYVqyc=;
 b=LEoRTnlmCUA+HTR9v+8TdgClPfmb9jOzUA2GjlqnfLxdCFxXNN9dwKqTVATk9oaesjQLUs
 yQb9pdutmRUGjtFCfT9AizFXw4GRDMiUON6597TpPU41PfKNc9WDcsUq3TOpk+HPXQAuoC
 K2FN3cSmFOr0kQmPp76ZZS43cJ/gIns=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-FIEDj8mFP2SpXgSvWMXJTw-1; Sun, 09 Nov 2025 09:35:22 -0500
X-MC-Unique: FIEDj8mFP2SpXgSvWMXJTw-1
X-Mimecast-MFC-AGG-ID: FIEDj8mFP2SpXgSvWMXJTw_1762698921
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso16572395e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698921; x=1763303721; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=neawIxqIKpZCZv4T6g2O2IpqcqSPVDqavtFhhFYVqyc=;
 b=MTvgCOkJUfjhkcg1vFWfPRXWNcKcS+oCg8gHWLLyReD8J3VvHn1gYgYYVBjMoI/vMW
 7UEp4zM2TrCr7AxPsM647VqvhlyjHjNecl1lyBCFsPj2w02xi4RztpWD8CY1CKPAVYqg
 srDb3pA4jUXVqhAmrzCNbemTm/jGSadgbqNhSl1fKisezIwBY0sZXDwPLp+wZ7TYzkkj
 VtxDoBJwe5oR/DIYeYosMX83nXfiaYPSc6i0KKdlHX/NAORp/c6fBJYn9HN1gR64QdXk
 nXsoB/PoYb/SMefHIdux7HyNF6QnT6h8a8khVP/Z65N2lb2kB+teDYu3q1SSufuJhVhD
 5D7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698921; x=1763303721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=neawIxqIKpZCZv4T6g2O2IpqcqSPVDqavtFhhFYVqyc=;
 b=jmC6jMXT64spqHBIxRnJeM1yrTphCjbmFA+Qh5U6CDEwr7w2sePf9Q1eTZ5XqmwtxA
 Pl+N7JKUaN9ajz1xFGeNP85hZUoR585kX1jW1CJd07WXkzVNUktOHLF1Va+umF9rOjR6
 RtmW5ESrJx54709NFbDOUiTfNazTzlJMv+CyuZ5JQYc8Ek1VbR0NWck304qgGg+MueMN
 WmKHiH1bWras/UCs+/1ZOwBdjx97b8WCV2dqcxVtt2XZIYKDH4df/fJKEIkCynAYh0+d
 YO/KDprDxOjtyJzh4obORVxJxw/Sq/Pdm+99GgDEkeQ9BjVFkgjiFDy8M94l6RSeepcI
 JNDA==
X-Gm-Message-State: AOJu0Yw3U2MsfUxGZ5xnIryMGrZlHVOlP9XNRs677aO96NmbX868XeVw
 a2hslz6THrQElaiJKCdA8ZMywk3hxBhE1orYF4vfQg+xOwOxqFRvF4bRFr3KaLhUbrCy8G5nEEA
 XsUYEh8tJ4jJaEzF5AIy9vopo6teEJUZQO0U0Sx8UoIV70kaUTyHVJa5c1qdQUXs3YON111/O23
 WTE7F8aZYQjgDF8Wu5j1pJzpMcqIFfMdRqcQ==
X-Gm-Gg: ASbGncu59p/OwwmH/G8eH0QQs8DqlyMLcoYgYEva7jEhgL2xmwvs2u61N7VGMSjxS4S
 /VEFiTYzY0AdhJHuyUenU1+XICe8ePcBVO6I52goArYl2+M4U1FtTOCfrEQYawwwzwxBN5khXga
 cADGfJMARqtg6i8/XlTurM9r4mhW/YztJ3YlrYCtAWCX5gy/TLjhcTR8k5Ovl4826+8pUPA70Qi
 YBxHoIik2M0Fc6l0qE2tz1++XC72vdm8JTtZEz1OHzSIpPzit+YDr5ThUTJm9H2blSNPP8dYymw
 Pe7+RAE3xgTVuIJOQ2ZyXumz32rVq9h3dHWN/A3R9nH93bC8Cm3vB5QQbWNesmGZx8U=
X-Received: by 2002:a05:600c:4f94:b0:475:df09:c253 with SMTP id
 5b1f17b1804b1-47773288f90mr44101955e9.38.1762698921110; 
 Sun, 09 Nov 2025 06:35:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhpywO/HYewXtqgXyaRCEk5w8awAay0sJMHsVAgpxwREAHRbSdNt6JknID3L7S4/1zQ4RNkQ==
X-Received: by 2002:a05:600c:4f94:b0:475:df09:c253 with SMTP id
 5b1f17b1804b1-47773288f90mr44101675e9.38.1762698920551; 
 Sun, 09 Nov 2025 06:35:20 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47763eb362bsm92032695e9.4.2025.11.09.06.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:20 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 05/14] intel_iommu: Handle PASID cache invalidation
Message-ID: <43b8c4339709efef153cb2cf21d23d1791890d60.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

Adds a new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the pasid
entry and track PASID usage and future PASID tagged DMA address translation
support in vIOMMU.

When guest triggers pasid cache invalidation, QEMU will capture it and
update or invalidate pasid cache.

vIOMMU emulator could figure out the reason by fetching latest guest pasid
entry in memory and compare it with cached PASID entry if it's valid.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251017093602.525338-2-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  17 ++++
 include/hw/i386/intel_iommu.h  |   6 ++
 hw/i386/intel_iommu.c          | 141 ++++++++++++++++++++++++++++++---
 hw/i386/trace-events           |   3 +
 4 files changed, 157 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 0f6a1237e4..75bafdf0cd 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -316,6 +316,8 @@ typedef enum VTDFaultReason {
                                   * request while disabled */
     VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
 
+    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
+
     VTD_FR_SM_PRE_ABS = 0x47,   /* SCT.8 : PRE bit in a present SM CE is 0 */
 
     /* PASID directory entry access failure */
@@ -517,6 +519,15 @@ typedef union VTDPRDesc VTDPRDesc;
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
 
+/* PASID-cache Invalidate Descriptor (pc_inv_dsc) fields */
+#define VTD_INV_DESC_PASIDC_G(x)        extract64((x)->val[0], 4, 2)
+#define VTD_INV_DESC_PASIDC_G_DSI       0
+#define VTD_INV_DESC_PASIDC_G_PASID_SI  1
+#define VTD_INV_DESC_PASIDC_G_GLOBAL    3
+#define VTD_INV_DESC_PASIDC_DID(x)      extract64((x)->val[0], 16, 16)
+#define VTD_INV_DESC_PASIDC_PASID(x)    extract64((x)->val[0], 32, 20)
+#define VTD_INV_DESC_PASIDC_RSVD_VAL0   0xfff000000000f1c0ULL
+
 /* Page Request Descriptor */
 /* For the low 64-bit of 128-bit */
 #define VTD_PRD_TYPE            (1ULL)
@@ -603,6 +614,12 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
 
+typedef struct VTDPASIDCacheInfo {
+    uint8_t type;
+    uint16_t did;
+    uint32_t pasid;
+} VTDPASIDCacheInfo;
+
 /* PASID Table Related Definitions */
 #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
 #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index b2f1ef9595..ca7f7bb661 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -95,6 +95,11 @@ struct VTDPASIDEntry {
     uint64_t val[8];
 };
 
+typedef struct VTDPASIDCacheEntry {
+    struct VTDPASIDEntry pasid_entry;
+    bool valid;
+} VTDPASIDCacheEntry;
+
 struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
@@ -107,6 +112,7 @@ struct VTDAddressSpace {
     MemoryRegion iommu_ir_fault; /* Interrupt region for catching fault */
     IntelIOMMUState *iommu_state;
     VTDContextCacheEntry context_cache_entry;
+    VTDPASIDCacheEntry pasid_cache_entry;
     QLIST_ENTRY(VTDAddressSpace) next;
     /* Superset of notifier flags that this address space has */
     IOMMUNotifierFlag notifier_flags;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6a168d5107..c47f13b659 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3051,6 +3051,130 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     return true;
 }
 
+static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
+                                            VTDPASIDEntry *pe)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDContextEntry ce;
+    int ret;
+
+    if (!s->root_scalable) {
+        return -VTD_FR_RTADDR_INV_TTM;
+    }
+
+    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
+                                   &ce);
+    if (ret) {
+        return ret;
+    }
+
+    return vtd_ce_get_rid2pasid_entry(s, &ce, pe, vtd_as->pasid);
+}
+
+/* Update or invalidate pasid cache based on the pasid entry in guest memory. */
+static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
+                                        gpointer user_data)
+{
+    VTDPASIDCacheInfo *pc_info = user_data;
+    VTDAddressSpace *vtd_as = value;
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    VTDPASIDEntry pe;
+    uint16_t did;
+
+    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
+        /*
+         * No valid pasid entry in guest memory. e.g. pasid entry was modified
+         * to be either all-zero or non-present. Either case means existing
+         * pasid cache should be invalidated.
+         */
+        pc_entry->valid = false;
+        return;
+    }
+
+    /*
+     * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI require
+     * DID check. If DID doesn't match the value in cache or memory, then
+     * it's not a pasid entry we want to invalidate.
+     */
+    switch (pc_info->type) {
+    case VTD_INV_DESC_PASIDC_G_PASID_SI:
+        if (pc_info->pasid != vtd_as->pasid) {
+            return;
+        }
+        /* Fall through */
+    case VTD_INV_DESC_PASIDC_G_DSI:
+        if (pc_entry->valid) {
+            did = VTD_SM_PASID_ENTRY_DID(pc_entry->pasid_entry.val[1]);
+        } else {
+            did = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+        }
+        if (pc_info->did != did) {
+            return;
+        }
+    }
+
+    pc_entry->pasid_entry = pe;
+    pc_entry->valid = true;
+}
+
+static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
+{
+    if (!s->root_scalable || !s->dmar_enabled) {
+        return;
+    }
+
+    vtd_iommu_lock(s);
+    g_hash_table_foreach(s->vtd_address_spaces, vtd_pasid_cache_sync_locked,
+                         pc_info);
+    vtd_iommu_unlock(s);
+}
+
+static bool vtd_process_pasid_desc(IntelIOMMUState *s,
+                                   VTDInvDesc *inv_desc)
+{
+    uint16_t did;
+    uint32_t pasid;
+    VTDPASIDCacheInfo pc_info = {};
+    uint64_t mask[4] = {VTD_INV_DESC_PASIDC_RSVD_VAL0, VTD_INV_DESC_ALL_ONE,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, true,
+                                     __func__, "pasid cache inv")) {
+        return false;
+    }
+
+    did = VTD_INV_DESC_PASIDC_DID(inv_desc);
+    pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc);
+    pc_info.type = VTD_INV_DESC_PASIDC_G(inv_desc);
+
+    switch (pc_info.type) {
+    case VTD_INV_DESC_PASIDC_G_DSI:
+        trace_vtd_inv_desc_pasid_cache_dsi(did);
+        pc_info.did = did;
+        break;
+
+    case VTD_INV_DESC_PASIDC_G_PASID_SI:
+        /* PASID selective implies a DID selective */
+        trace_vtd_inv_desc_pasid_cache_psi(did, pasid);
+        pc_info.did = did;
+        pc_info.pasid = pasid ?: PCI_NO_PASID;
+        break;
+
+    case VTD_INV_DESC_PASIDC_G_GLOBAL:
+        trace_vtd_inv_desc_pasid_cache_gsi();
+        break;
+
+    default:
+        error_report_once("invalid granularity field in PASID-cache invalidate "
+                          "descriptor, hi: 0x%"PRIx64" lo: 0x%" PRIx64,
+                           inv_desc->val[1], inv_desc->val[0]);
+        return false;
+    }
+
+    vtd_pasid_cache_sync(s, &pc_info);
+    return true;
+}
+
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
                                      VTDInvDesc *inv_desc)
 {
@@ -3266,6 +3390,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    case VTD_INV_DESC_PC:
+        trace_vtd_inv_desc("pasid-cache", inv_desc.val[1], inv_desc.val[0]);
+        if (!vtd_process_pasid_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     case VTD_INV_DESC_PIOTLB:
         trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
         if (!vtd_process_piotlb_desc(s, &inv_desc)) {
@@ -3308,16 +3439,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
-    /*
-     * TODO: the entity of below two cases will be implemented in future series.
-     * To make guest (which integrates scalable mode support patch set in
-     * iommu driver) work, just return true is enough so far.
-     */
-    case VTD_INV_DESC_PC:
-        if (s->scalable_mode) {
-            break;
-        }
-    /* fallthrough */
     default:
         error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
                           " (unknown type)", __func__, inv_desc.hi,
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index ac9e1a10aa..298addb24d 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -24,6 +24,9 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
+vtd_inv_desc_pasid_cache_gsi(void) ""
+vtd_inv_desc_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
+vtd_inv_desc_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
-- 
MST


