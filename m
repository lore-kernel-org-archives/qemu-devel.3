Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32950C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBA-000742-21; Fri, 11 Sep 2026 05:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAc-0004SB-DP
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAa-0008L3-IA
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEQqbP05s+OSlyzjNTsgrx4dobovQAA0LQxrJHMbWCc=;
 b=i5npJEVJghjF09AWm7AHDypW+EVCze+Oemlse54K/hMW5Y5FzRI3pfT3HNpSsTyXl2FqNI
 9HJJVbxVJtpEEmgS/PyX7SsNqYLwCEPggQhLT6Yj3VmCl6YkxocQNT2fEltm9StvPch/xz
 3ipcy/gRTdLMziV5W3/3Mn8Sk/GdttU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77--r4YUZxUNiq-DeoDgvb2VA-1; Fri, 11 Sep 2026 05:03:37 -0400
X-MC-Unique: -r4YUZxUNiq-DeoDgvb2VA-1
X-Mimecast-MFC-AGG-ID: -r4YUZxUNiq-DeoDgvb2VA_1789117416
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49b8c651ac0so9067165e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117416; x=1789722216; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qEQqbP05s+OSlyzjNTsgrx4dobovQAA0LQxrJHMbWCc=;
 b=FbkGF9kqoCzRV8meIXHInXeoKbz5gRr56NJJ4kHMAAoySJ1vagpPafGFtcINdc5w4K
 voNp/GhpZADyklfCSO9+Bs0CsobRRdTyUQIQUB9PyjDoNdJX70JLDCy0g4J5Q1ZlqN38
 J7MLmO8UyfIti1N3DF8JPVVqeYvqFXBYC6GOEqBmwPf3gcq4Le3eH1UMF5V0yXDUlMFy
 06kJXnXJSOEEPpTsyOx8H9frplNefwMLYhcenYrWm9VQaUhHlPaH9DHYim7OatLmAYwv
 b3URyy16sYx3DNxSH0yD9bUfp++/QrJM8XIKN1SK44WZC5Yoz6fyP27EpbXV1Ua3O0Q2
 mxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117416; x=1789722216;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qEQqbP05s+OSlyzjNTsgrx4dobovQAA0LQxrJHMbWCc=;
 b=CRU+QzC7jrrNQD8jlR3W2VjeUXw28ZYOlLwBRtwpJyWoundPgGlxjsYnN2mwYmd991
 RbS7mjZMNfDIfiJQOFCaU64lfLkX9+W7qE5ytCQkNVzgIELxO7ULuoDpzAalakJiDw6V
 dsUxWDB4ik0sZGanYRb+wH1wC44TCjAYaY6V/AZ1oTS5iiS7vAkHCoGSgJf48N52tUVO
 AeYVV1xBnRuKp2aFvGgagCBW08i5twWRo4AGpFrDBe83cq7Umf2IxA94fyq3ozlxnbZB
 +bcI/WgS2/vd+9NkSghGNb4OLMQq4iE8+eGe0TqEwbMx+kvcV3l1Xyo92IESzKdt569u
 u/pw==
X-Gm-Message-State: AFuF++lb1ua5zonjstvzOh8dAdEiZhkeMaXSjZ6BaCWvp4mw2BCyZYIT
 jXuWrc6Hh96oI7b1ukTDVaoXndn6Ub6p+UMKGeAs9KoywixZpDp1JplLoLxE7oP0mF3aNR0Y60+
 HLDbDkQNWqX5t46WLobiNg68QyXw7ZfLth2dNTYTnENXidwrLDY9ptETT4IGlgHLgWVKca3tOa4
 JwUaChOlfHrSKhTPr+l0jJ0P2+H9cgPD82tw==
X-Gm-Gg: AYBFou09ug4tq72x8NwW8vB5+rYuUqZWO2LzIwpv9Z/+VRdincNyilfeN/kZzmmL7Ik
 NIdD26DKgK4S3vYDv/A4fPIdPmVdUwbgthY1HFs3OsOr8/1R9sklA+D5H0y8PS7iPYorkkdtMLh
 StEEE3klyXeTUTuUjBVYPXx559TQCs6RGxqDD4/Q/BU5/51+nPhb5v2oU+RhuYLWt2WMoKlaVMt
 eBHO4QmI60stvkMUpg6rgadxmUR7L4v4zxoCSHlvO/HHv6kKfQZNKScmjE21H2oZYu7t3ThWgVs
 ybxOBWpLQjybFLmTvtSxzqL2qtK0ioSRNkZEykxCOWxtAqxOtCx/jrRKUORpv5sMzg8CCgt+mww
 wZ8XTbCtlzLSddNkZlradx78=
X-Received: by 2002:a05:600c:3b90:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49e619805f1mr34637905e9.4.1789117415567; 
 Fri, 11 Sep 2026 02:03:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3b90:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49e619805f1mr34636975e9.4.1789117414728; 
 Fri, 11 Sep 2026 02:03:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm4714981f8f.27.2026.09.11.02.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:34 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 Jason Wang <jasowangio@gmail.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 57/75] intel_iommu: Support concurrent page fault handling
 with PRI
Message-ID: <f19df1b13d1a0b5601b4b58067b8c2e91ae76ef3.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Clément MATHIEU--DRIF <clement.mathieu--drif@bull.com>

PRQ slot allocation must be thread safe to avoid posting multiple
commands in the same slot so we take a lock in vtd_pri_request_page.

This allows multiple devices to call the page request interface
of the same iommu instance.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260903145044.2245609-1-clement.mathieu--drif@bull.com>
---
 hw/i386/intel_iommu.c | 103 ++++++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 40 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 82c3c3b2c3..7c442a86ca 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3627,15 +3627,26 @@ static void vtd_handle_iectl_write(IntelIOMMUState *s)
 
 static void vtd_handle_prs_write(IntelIOMMUState *s)
 {
-    uint32_t prs = vtd_get_long_raw(s, DMAR_PRS_REG);
+    uint32_t prs;
+
+    vtd_iommu_lock(s);
+
+    prs = vtd_get_long_raw(s, DMAR_PRS_REG);
     if (!(prs & VTD_PR_STATUS_PPR) && !(prs & VTD_PR_STATUS_PRO)) {
         vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
     }
+
+    vtd_iommu_unlock(s);
 }
 
 static void vtd_handle_pectl_write(IntelIOMMUState *s)
 {
-    uint32_t pectl = vtd_get_long_raw(s, DMAR_PECTL_REG);
+    uint32_t pectl;
+
+    vtd_iommu_lock(s);
+
+    pectl = vtd_get_long_raw(s, DMAR_PECTL_REG);
+
     if ((pectl & VTD_PR_PECTL_IP) && !(pectl & VTD_PR_PECTL_IM)) {
         /*
          * If IP field was 1 when software clears the IM field,
@@ -3644,6 +3655,8 @@ static void vtd_handle_pectl_write(IntelIOMMUState *s)
         vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
         vtd_generate_interrupt(s, DMAR_PEADDR_REG, DMAR_PEDATA_REG);
     }
+
+    vtd_iommu_unlock(s);
 }
 
 static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
@@ -5377,19 +5390,18 @@ static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
 {
     IntelIOMMUState *s = opaque;
     VTDAddressSpace *vtd_as;
+    uint64_t queue_addr_reg;
+    uint64_t queue_tail_offset_reg;
+    uint64_t new_queue_tail_offset;
+    uint64_t queue_head_offset_reg;
+    hwaddr queue_tail;
+    uint32_t old_pr_status;
+    uint16_t sid;
+    VTDPRDesc desc;
+    int ret = 0;
 
     vtd_as = vtd_find_add_as(s, bus, devfn, pasid);
-
-    uint64_t queue_addr_reg = vtd_get_quad(s, DMAR_PQA_REG);
-    uint64_t queue_tail_offset_reg = vtd_get_quad(s, DMAR_PQT_REG);
-    uint64_t new_queue_tail_offset = (
-                                (queue_tail_offset_reg + VTD_PQA_ENTRY_SIZE) %
-                                (vtd_prq_size(s) * VTD_PQA_ENTRY_SIZE));
-    uint64_t queue_head_offset_reg = vtd_get_quad(s, DMAR_PQH_REG);
-    hwaddr queue_tail = (queue_addr_reg & VTD_PQA_ADDR) + queue_tail_offset_reg;
-    uint32_t old_pr_status = vtd_get_long(s, DMAR_PRS_REG);
-    uint16_t sid = PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn);
-    VTDPRDesc desc;
+    sid = PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn);
 
     if (!(s->ecap & VTD_ECAP_PRS)) {
         return -EPERM;
@@ -5413,25 +5425,7 @@ static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
         return -EPERM;
     }
 
-    if (old_pr_status & VTD_PR_STATUS_PRO) {
-        /*
-         * No action is taken by hardware to report a fault
-         * or generate an event
-         */
-        return -ENOSPC;
-    }
-
-    /* Check for overflow */
-    if (new_queue_tail_offset == queue_head_offset_reg) {
-        vtd_set_clear_mask_long(s, DMAR_PRS_REG, 0, VTD_PR_STATUS_PRO);
-        vtd_generate_page_request_event(s, old_pr_status);
-        return -ENOSPC;
-    }
-
-    if (vtd_pri_perform_implicit_invalidation(vtd_as, addr)) {
-        return -EINVAL;
-    }
-
+    /* Prepare the descriptor */
     desc.lo = VTD_PRD_TYPE | VTD_PRD_PP(true) | VTD_PRD_RID(sid) |
               VTD_PRD_PASID(vtd_as->pasid) | VTD_PRD_PMR(priv_req);
     desc.hi = VTD_PRD_RDR(is_read) | VTD_PRD_WRR(is_write) |
@@ -5439,26 +5433,55 @@ static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
 
     desc.lo = cpu_to_le64(desc.lo);
     desc.hi = cpu_to_le64(desc.hi);
+
+    if (vtd_pri_perform_implicit_invalidation(vtd_as, addr)) {
+        return -EINVAL;
+    }
+
+    vtd_iommu_lock(s);
+
+    queue_addr_reg = vtd_get_quad(s, DMAR_PQA_REG);
+    queue_tail_offset_reg = vtd_get_quad(s, DMAR_PQT_REG);
+    new_queue_tail_offset = ((queue_tail_offset_reg + VTD_PQA_ENTRY_SIZE) %
+                            (vtd_prq_size(s) * VTD_PQA_ENTRY_SIZE));
+    queue_head_offset_reg = vtd_get_quad(s, DMAR_PQH_REG);
+    queue_tail = (queue_addr_reg & VTD_PQA_ADDR) + queue_tail_offset_reg;
+    old_pr_status = vtd_get_long(s, DMAR_PRS_REG);
+
+    if (old_pr_status & VTD_PR_STATUS_PRO) {
+        /*
+         * No action is taken by hardware to report a fault
+         * or generate an event
+         */
+        ret = -ENOSPC;
+        goto out;
+    }
+
+    /* Check for overflow */
+    if (new_queue_tail_offset == queue_head_offset_reg) {
+        vtd_set_clear_mask_long(s, DMAR_PRS_REG, 0, VTD_PR_STATUS_PRO);
+        vtd_generate_page_request_event(s, old_pr_status);
+        ret = -ENOSPC;
+        goto out;
+    }
+
     if (dma_memory_write(&address_space_memory, queue_tail, &desc, sizeof(desc),
                          MEMTXATTRS_UNSPECIFIED)) {
         error_report_once("IO error, the PQ tail cannot be updated");
-        return -EIO;
+        ret = -EIO;
+        goto out;
     }
 
     /* increment the tail register and set the pending request bit */
     vtd_set_quad(s, DMAR_PQT_REG, new_queue_tail_offset);
-    /*
-     * read status again so that the kernel does not miss a request.
-     * in some cases, we can trigger an unecessary interrupt but this strategy
-     * drastically improves performance as we don't need to take a lock.
-     */
-    old_pr_status = vtd_get_long(s, DMAR_PRS_REG);
     if (!(old_pr_status & VTD_PR_STATUS_PPR)) {
         vtd_set_clear_mask_long(s, DMAR_PRS_REG, 0, VTD_PR_STATUS_PPR);
         vtd_generate_page_request_event(s, old_pr_status);
     }
 
-    return 0;
+out:
+    vtd_iommu_unlock(s);
+    return ret;
 }
 
 static void vtd_init_iotlb_notifier(PCIBus *bus, void *opaque, int devfn,
-- 
MST


