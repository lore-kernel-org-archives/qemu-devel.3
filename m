Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121BEC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mVo-0002pU-25; Thu, 10 Sep 2026 17:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lKB-0002RI-M1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJz-0008Ek-Vu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEQqbP05s+OSlyzjNTsgrx4dobovQAA0LQxrJHMbWCc=;
 b=dCFFFjlPU7moV9julJ40XkIao+mIpHiTn+ENrAT7W2oCnmlRdUo1DiEVMPLIehkk0HwEy5
 BbT2CTjWCOPQHfhYZYat7p4JI7hB5Qkrsd+NK5lRcv5WwTz+wIzcRedy0h+EDyTcCrIvzw
 2b5dCQAF0FDVf+aNSDEj1iWGmC5+L1k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-x72-GnfyP5GPTHlJztLtGg-1; Thu, 10 Sep 2026 16:14:31 -0400
X-MC-Unique: x72-GnfyP5GPTHlJztLtGg-1
X-Mimecast-MFC-AGG-ID: x72-GnfyP5GPTHlJztLtGg_1789071270
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so2236565e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071270; x=1789676070; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qEQqbP05s+OSlyzjNTsgrx4dobovQAA0LQxrJHMbWCc=;
 b=sC6xDDYkaJULit/SusMrX+goF1Z5rhUk5jYPsLIYl98kKKSY3fs6dcr/nZzaTnhVzr
 7SWAAlarNCFaq8Jd6R2/JEl4NirzS5qgEx0R1W6DJQ2Ev6strlL3f386etuKZvtIHRjP
 SiFjnqhgx3F6gCHK1A9c4R+c8/m2HML19kRc9VNcWUiqLFBMmTq6l2mfnsrTefWOccC5
 YWPuZmcEvr5iYTyGWAAOqLZsy6CApK/CCmvLGPwbky24jeGshYXfAYTFAoH3lKaHHcbq
 Atkb68bwdWLGgHbklLGGU5aHuUk4wmEWsjH2lXX6+F7tBqT7KTIMLJ6mohfAqa4zqqUN
 X13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071270; x=1789676070;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qEQqbP05s+OSlyzjNTsgrx4dobovQAA0LQxrJHMbWCc=;
 b=sqfxpUmplICP8Z41h1PNdQXWQwoQ6nKLVUo85I9suhu+czOzRDwcxH7NHMh6zR2fqP
 wn3FW08yJug151VpDpNGlBnIniuwg1+lFprrIJ1AvHK3zrLOjL49d60kojXuu6VlKWan
 GPgS5XhJQo0Aknrh5DDaB8zQfpKLpxIN3zRxg9vXot9MTZmNUEeY/+QxfvU9TK1z0rcF
 jADaiTMETLa7VayZyOJ/6M/3DqP10to6sO+aJExpCm+liAHkO5CGBiEJt0Lf/5kYBZS7
 9iHxnwmRuEVR0HPBm/N/iTB5/Decw/RVuNSfiCTR5DfinGxA2Z/f4dmzd74YT3mY2rOB
 8Law==
X-Gm-Message-State: AFuF++lqmgosm6QIXC1SOLOMoSX3NoXqfKS1TSuT4AdVsh1IgjycqbzQ
 E4sezvIhMfKpE9VOEu/xT/mynCGARly8s8KPMGyhgV1N0uFfNKw6VVlKnetGlDIBPErjPOi4ZXX
 0K9rMmFPLKmAcZuEXWi6y2b372fHx7PoOs4j/SaZPCOrylEeQ+sP6bvnBMhNp8rJPZxxKsPCuN0
 I6R09dXh05jvPaSTqKB/YAz6Ksrf7NyusOsw==
X-Gm-Gg: AYBFou0m0NEv8bPv21YvFrmfbM1Ex8Gx2BtISav3twxaNUnbL1JkSfsoJ83AKgSnQ6K
 gIeyI2g2x/LgaDc13CTfzgRtxjUijcN2i18YIZoedJO8hanLktpqMuWKhw6pr1Vq4O0ExWmngfF
 tAMtA+++LmHtV/qa+dSEoYWwYJYad+XfGN67Uo9oUQ1x8YqRtxzBrPgQbilqUeg2nH7EalciBRg
 DDFiUPkz8/9r+2ICZ/h9qhJyxfZxNJWQfdwc/BvrSkr8J7O3cW4QZ5vWoOqjRC/MlbBjq8Mz9Yw
 2g1UHSlX9zAfqeDOtZLTdt0oYMzY/6gayfsKtAonAF3JJaeswNtIFPSBxL4ti/hqoalKxSQozur
 XwZ5tuBZIBLPHl5TFWdcIxKg=
X-Received: by 2002:a05:600c:b99:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49e619a1c6amr16333035e9.3.1789071270187; 
 Thu, 10 Sep 2026 13:14:30 -0700 (PDT)
X-Received: by 2002:a05:600c:b99:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49e619a1c6amr16332145e9.3.1789071269627; 
 Thu, 10 Sep 2026 13:14:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35bed0sm740246f8f.32.2026.09.10.13.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:29 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 Jason Wang <jasowangio@gmail.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 72/90] intel_iommu: Support concurrent page fault handling
 with PRI
Message-ID: <0597be6f01e3c23263233f57e36cb02be55d0556.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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


