Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420C6CCD184
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFH-00022Z-Vk; Sun, 05 Oct 2025 15:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEp-0000LZ-CI
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEm-0006Xt-JT
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaVeE+H2gjZ5lunVQFTjUNgGLQ7U1xMjHlxoCmjXBr8=;
 b=BplfwDRQB+sLGuAyqIBQ/KL1wGNJ064W1jxQkx6nrG+9ukJpoQzb0KisBk5U6Pvrzzctyi
 GzPbsTuslBG7C42dD3cKTH96OHxU5rdBNLbdVV5WyXpdxOvXuxLu4icfVJWdjqilagLSdg
 pjylNM5PU8aZElW45c4tqiZN5pKlRCE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-NuEW08BlNcWkYCrqENgFPg-1; Sun, 05 Oct 2025 15:17:38 -0400
X-MC-Unique: NuEW08BlNcWkYCrqENgFPg-1
X-Mimecast-MFC-AGG-ID: NuEW08BlNcWkYCrqENgFPg_1759691857
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f42b54d159so3228724f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691857; x=1760296657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaVeE+H2gjZ5lunVQFTjUNgGLQ7U1xMjHlxoCmjXBr8=;
 b=mr1AwNE/jhKSfCxa11HDvE88u5R8pa40yMPT0dGN+2Ejswq+WVgsfThQI9Fv93JgM2
 +BkkyW7eOr2ywd1X0yDBrYk58ZrEM5v5k6rw7FBCCrLrrgM75HHdWDaW0lwMqNpO+iqb
 scJ07BcY7DirgVDY3bXOxhlrEodq2cOj30COsy4MyD0At7thXvhy51yVQ9LErTo1nqGL
 baprtDA2fr3SCtNxEcSYuuIPC9okcI939ogz/4jCzKnum8mBTl+tQ95Li2ZlrHvURrkY
 Il5JzURkNDgd5TKke7U2XrX2RtBh6xtY4UF1ZlD77JknAadUNpM4EgWPlcm77/1lvb4F
 t7lQ==
X-Gm-Message-State: AOJu0Yy3bJo0uW8etMSEIceUlW4vET5k6eiqjzelB77p2irVmzXFS6SM
 wA3XoEl1R0cEubPG8ce4PCWRTCmg/PuNrST0dBUA4FPYJZmp8e58muZzVAhkONNe2Jh59nzGfCS
 8zXT/wm9GkRe4Pr4oBqZx9m+iUTp+JxmG4Uq8FpSyPXuLDIHBa92ZIePajXmQhVv0K17u5JqOvX
 UuFrPxGaanqr0PDfmJmwbP1NM+jtbF4p2P1g==
X-Gm-Gg: ASbGnct3gYgqOwhDIH0bxrVYKG5pSB9Hhj5z+P5ElzJmSezatUeo1PqkK1VBoX6At7V
 uOjQYPgTvA7xr0+szUsN9hfV5UGUDmvi8fyZHCFREFRJIcdxJ4srZolJ/buh2fYvzwObyX+U8ce
 qsnEzFxUNyTkGiqC56+8WzX9sfwINmZoIZ/4YB5UfM3BJ/DO9RX8Xx04Cpv+gQZjAp4IhmL1avb
 CPE7Blt8I82cpV/CjxGytwXF2ihXEwe+md65LqUwSbHzNeuMNI1gEBEs9A0tlyAGslIP92ihqle
 6btPm80DaCNlDv7HQ+yUEb6+6AVYCFDkT+fwm5M=
X-Received: by 2002:a05:6000:2dc3:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-425671ab145mr6411799f8f.43.1759691856975; 
 Sun, 05 Oct 2025 12:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqaLcGTgF4a02BvwinOgfJSNm12BUm9WGaJlFkanVLsWoC5nLphzKyPtft8DODYbQ13SgPlA==
X-Received: by 2002:a05:6000:2dc3:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-425671ab145mr6411778f8f.43.1759691856266; 
 Sun, 05 Oct 2025 12:17:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b5csm17507541f8f.5.2025.10.05.12.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:35 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 41/75] intel_iommu: Add PRI operations support
Message-ID: <676757e50ce0ce206969b02dc2433c9e825e55f5.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Implement the PRI callbacks in vtd_iommu_ops.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250901111630.1018573-6-clement.mathieu--drif@eviden.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h |   2 +
 include/hw/i386/intel_iommu.h  |   1 +
 hw/i386/intel_iommu.c          | 274 +++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 04a8d4c769..0d0069a612 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -315,6 +315,8 @@ typedef enum VTDFaultReason {
                                   * request while disabled */
     VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
 
+    VTD_FR_SM_PRE_ABS = 0x47,   /* SCT.8 : PRE bit in a present SM CE is 0 */
+
     /* PASID directory entry access failure */
     VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
     /* The Present(P) field of pasid directory entry is 0 */
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index e95477e855..47730ac3c7 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -110,6 +110,7 @@ struct VTDAddressSpace {
     QLIST_ENTRY(VTDAddressSpace) next;
     /* Superset of notifier flags that this address space has */
     IOMMUNotifierFlag notifier_flags;
+    IOMMUPRINotifier *pri_notifier;
     /*
      * @iova_tree traces mapped IOVA ranges.
      *
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d952ec1428..2cc9bd5e45 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -45,6 +45,8 @@
     ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
 #define VTD_CE_GET_PASID_DIR_TABLE(ce) \
     ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
+#define VTD_CE_GET_PRE(ce) \
+    ((ce)->val[0] & VTD_SM_CONTEXT_ENTRY_PRE)
 
 /* pe operations */
 #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
@@ -1838,6 +1840,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_FS_NON_CANONICAL] = true,
     [VTD_FR_FS_PAGING_ENTRY_US] = true,
     [VTD_FR_SM_WRITE] = true,
+    [VTD_FR_SM_PRE_ABS] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
     [VTD_FR_FS_BIT_UPDATE_FAILED] = true,
     [VTD_FR_MAX] = false,
@@ -3152,6 +3155,59 @@ static bool vtd_process_device_piotlb_desc(IntelIOMMUState *s,
     return true;
 }
 
+static bool vtd_process_page_group_response_desc(IntelIOMMUState *s,
+                                                 VTDInvDesc *inv_desc)
+{
+    VTDAddressSpace *vtd_dev_as;
+    bool pasid_present;
+    uint8_t response_code;
+    uint16_t rid;
+    uint32_t pasid;
+    uint16_t prgi;
+    IOMMUPRIResponse response;
+
+    if ((inv_desc->lo & VTD_INV_DESC_PGRESP_RSVD_LO) ||
+        (inv_desc->hi & VTD_INV_DESC_PGRESP_RSVD_HI)) {
+        error_report_once("%s: invalid page group response desc: hi=%"PRIx64
+                            ", lo=%"PRIx64" (reserved nonzero)", __func__,
+                            inv_desc->hi, inv_desc->lo);
+        return false;
+    }
+
+    pasid_present = VTD_INV_DESC_PGRESP_PP(inv_desc->lo);
+    response_code = VTD_INV_DESC_PGRESP_RC(inv_desc->lo);
+    rid = VTD_INV_DESC_PGRESP_RID(inv_desc->lo);
+    pasid = VTD_INV_DESC_PGRESP_PASID(inv_desc->lo);
+    prgi = VTD_INV_DESC_PGRESP_PRGI(inv_desc->hi);
+
+    if (!pasid_present) {
+        error_report_once("Page group response without PASID is"
+                          "not supported yet");
+        return false;
+    }
+
+    vtd_dev_as = vtd_get_as_by_sid_and_pasid(s, rid, pasid);
+    if (!vtd_dev_as) {
+        return true;
+    }
+
+    response.prgi = prgi;
+
+    if (response_code == 0x0u) {
+        response.response_code = IOMMU_PRI_RESP_SUCCESS;
+    } else if (response_code == 0x1u) {
+        response.response_code = IOMMU_PRI_RESP_INVALID_REQUEST;
+    } else {
+        response.response_code = IOMMU_PRI_RESP_FAILURE;
+    }
+
+    if (vtd_dev_as->pri_notifier) {
+        vtd_dev_as->pri_notifier->notify(vtd_dev_as->pri_notifier, &response);
+    }
+
+    return true;
+}
+
 static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
                                           VTDInvDesc *inv_desc)
 {
@@ -3252,6 +3308,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    case VTD_INV_DESC_PGRESP:
+        trace_vtd_inv_desc("page group response", inv_desc.hi, inv_desc.lo);
+        if (!vtd_process_page_group_response_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     /*
      * TODO: the entity of below two cases will be implemented in future series.
      * To make guest (which integrates scalable mode support patch set in
@@ -4864,6 +4927,194 @@ static ssize_t vtd_ats_request_translation(PCIBus *bus, void *opaque,
     return res_index;
 }
 
+/* 11.4.11.3 : The number of entries in the page request queue is 2^(PQS + 7) */
+static inline uint64_t vtd_prq_size(IntelIOMMUState *s)
+{
+    return 1ULL << ((vtd_get_quad(s, DMAR_PQA_REG) & VTD_PQA_SIZE) + 7);
+}
+
+/**
+ * Return true if the bit is accessible and correctly set, false otherwise
+ */
+static bool vtd_check_pre_bit(VTDAddressSpace *vtd_as, hwaddr addr,
+                              uint16_t sid, bool is_write)
+{
+    int ret;
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    uint8_t bus_n = pci_bus_num(vtd_as->bus);
+    VTDContextEntry ce;
+    bool is_fpd_set = false;
+
+    ret = vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce);
+
+    if (ret) {
+        goto error_report;
+    }
+
+    if (!VTD_CE_GET_PRE(&ce)) {
+        ret = -VTD_FR_SM_PRE_ABS;
+        goto error_get_fpd_and_report;
+    }
+
+    return true;
+
+error_get_fpd_and_report:
+    /* Try to get fpd (may not work but we are already on an error path) */
+    is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
+    vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
+error_report:
+    vtd_report_fault(s, -ret, is_fpd_set, sid, addr, is_write,
+                     vtd_as->pasid != PCI_NO_PASID, vtd_as->pasid);
+    return false;
+}
+
+/* Logic described in section 7.5 */
+static void vtd_generate_page_request_event(IntelIOMMUState *s,
+                                            uint32_t old_pr_status)
+{
+    uint32_t current_pectl = vtd_get_long(s, DMAR_PECTL_REG);
+    /*
+     * Hardware evaluates PPR and PRO fields in the Page Request Status Register
+     * and if any of them is set, Page Request Event is not generated
+     */
+    if (old_pr_status & (VTD_PR_STATUS_PRO | VTD_PR_STATUS_PPR)) {
+        return;
+    }
+
+    vtd_set_clear_mask_long(s, DMAR_PECTL_REG, 0, VTD_PR_PECTL_IP);
+    if (!(current_pectl & VTD_PR_PECTL_IM)) {
+        vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
+        vtd_generate_interrupt(s, DMAR_PEADDR_REG, DMAR_PEDATA_REG);
+    }
+}
+
+/* When calling this function, we known that we are in scalable mode */
+static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
+                                                 hwaddr addr)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDContextEntry ce;
+    VTDPASIDEntry pe;
+    uint16_t pgtt;
+    uint16_t domain_id;
+    int ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                       vtd_as->devfn, &ce);
+    if (ret) {
+        return -EINVAL;
+    }
+    ret = vtd_ce_get_rid2pasid_entry(s, &ce, &pe, vtd_as->pasid);
+    if (ret) {
+        return -EINVAL;
+    }
+    pgtt = VTD_PE_GET_TYPE(&pe);
+    domain_id = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+    ret = 0;
+    switch (pgtt) {
+    case VTD_SM_PASID_ENTRY_FLT:
+        vtd_piotlb_page_invalidate(s, domain_id, vtd_as->pasid, addr, 0);
+        break;
+    /* Room for other pgtt values */
+    default:
+        error_report_once("Translation type not supported yet : %d", pgtt);
+        ret = -EINVAL;
+        break;
+    }
+
+    return ret;
+}
+
+/* Page Request Descriptor : 7.4.1.1 */
+static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
+                                uint32_t pasid, bool priv_req, bool exec_req,
+                                hwaddr addr, bool lpig, uint16_t prgi,
+                                bool is_read, bool is_write)
+{
+    IntelIOMMUState *s = opaque;
+    VTDAddressSpace *vtd_as;
+
+    vtd_as = vtd_find_add_as(s, bus, devfn, pasid);
+
+    uint64_t queue_addr_reg = vtd_get_quad(s, DMAR_PQA_REG);
+    uint64_t queue_tail_offset_reg = vtd_get_quad(s, DMAR_PQT_REG);
+    uint64_t new_queue_tail_offset = (
+                                (queue_tail_offset_reg + VTD_PQA_ENTRY_SIZE) %
+                                (vtd_prq_size(s) * VTD_PQA_ENTRY_SIZE));
+    uint64_t queue_head_offset_reg = vtd_get_quad(s, DMAR_PQH_REG);
+    hwaddr queue_tail = (queue_addr_reg & VTD_PQA_ADDR) + queue_tail_offset_reg;
+    uint32_t old_pr_status = vtd_get_long(s, DMAR_PRS_REG);
+    uint16_t sid = PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn);
+    VTDPRDesc desc;
+
+    if (!(s->ecap & VTD_ECAP_PRS)) {
+        return -EPERM;
+    }
+
+    /*
+     * No need to check if scalable mode is enabled as we already known that
+     * VTD_ECAP_PRS is set (see vtd_decide_config)
+     */
+
+    /* We do not support PRI without PASID */
+    if (vtd_as->pasid == PCI_NO_PASID) {
+        return -EPERM;
+    }
+    if (exec_req && !is_read) {
+        return -EINVAL;
+    }
+
+    /* Check PRE bit in the scalable mode context entry */
+    if (!vtd_check_pre_bit(vtd_as, addr, sid, is_write)) {
+        return -EPERM;
+    }
+
+    if (old_pr_status & VTD_PR_STATUS_PRO) {
+        /*
+         * No action is taken by hardware to report a fault
+         * or generate an event
+         */
+        return -ENOSPC;
+    }
+
+    /* Check for overflow */
+    if (new_queue_tail_offset == queue_head_offset_reg) {
+        vtd_set_clear_mask_long(s, DMAR_PRS_REG, 0, VTD_PR_STATUS_PRO);
+        vtd_generate_page_request_event(s, old_pr_status);
+        return -ENOSPC;
+    }
+
+    if (vtd_pri_perform_implicit_invalidation(vtd_as, addr)) {
+        return -EINVAL;
+    }
+
+    desc.lo = VTD_PRD_TYPE | VTD_PRD_PP(true) | VTD_PRD_RID(sid) |
+              VTD_PRD_PASID(vtd_as->pasid) | VTD_PRD_PMR(priv_req);
+    desc.hi = VTD_PRD_RDR(is_read) | VTD_PRD_WRR(is_write) |
+              VTD_PRD_LPIG(lpig) | VTD_PRD_PRGI(prgi) | VTD_PRD_ADDR(addr);
+
+    desc.lo = cpu_to_le64(desc.lo);
+    desc.hi = cpu_to_le64(desc.hi);
+    if (dma_memory_write(&address_space_memory, queue_tail, &desc, sizeof(desc),
+                         MEMTXATTRS_UNSPECIFIED)) {
+        error_report_once("IO error, the PQ tail cannot be updated");
+        return -EIO;
+    }
+
+    /* increment the tail register and set the pending request bit */
+    vtd_set_quad(s, DMAR_PQT_REG, new_queue_tail_offset);
+    /*
+     * read status again so that the kernel does not miss a request.
+     * in some cases, we can trigger an unecessary interrupt but this strategy
+     * drastically improves performance as we don't need to take a lock.
+     */
+    old_pr_status = vtd_get_long(s, DMAR_PRS_REG);
+    if (!(old_pr_status & VTD_PR_STATUS_PPR)) {
+        vtd_set_clear_mask_long(s, DMAR_PRS_REG, 0, VTD_PR_STATUS_PPR);
+        vtd_generate_page_request_event(s, old_pr_status);
+    }
+
+    return 0;
+}
+
 static void vtd_init_iotlb_notifier(PCIBus *bus, void *opaque, int devfn,
                                     IOMMUNotifier *n, IOMMUNotify fn,
                                     void *user_opaque)
@@ -4905,6 +5156,26 @@ static void vtd_unregister_iotlb_notifier(PCIBus *bus, void *opaque,
     memory_region_unregister_iommu_notifier(MEMORY_REGION(&vtd_as->iommu), n);
 }
 
+static void vtd_pri_register_notifier(PCIBus *bus, void *opaque, int devfn,
+                               uint32_t pasid, IOMMUPRINotifier *notifier)
+{
+    IntelIOMMUState *s = opaque;
+    VTDAddressSpace *vtd_as;
+
+    vtd_as = vtd_find_add_as(s, bus, devfn, pasid);
+    vtd_as->pri_notifier = notifier;
+}
+
+static void vtd_pri_unregister_notifier(PCIBus *bus, void *opaque,
+                                        int devfn, uint32_t pasid)
+{
+    IntelIOMMUState *s = opaque;
+    VTDAddressSpace *vtd_as;
+
+    vtd_as = vtd_find_add_as(s, bus, devfn, pasid);
+    vtd_as->pri_notifier = NULL;
+}
+
 static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
     .set_iommu_device = vtd_dev_set_iommu_device,
@@ -4914,6 +5185,9 @@ static PCIIOMMUOps vtd_iommu_ops = {
     .register_iotlb_notifier = vtd_register_iotlb_notifier,
     .unregister_iotlb_notifier = vtd_unregister_iotlb_notifier,
     .ats_request_translation = vtd_ats_request_translation,
+    .pri_register_notifier = vtd_pri_register_notifier,
+    .pri_unregister_notifier = vtd_pri_unregister_notifier,
+    .pri_request_page = vtd_pri_request_page,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
MST


