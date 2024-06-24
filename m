Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B10C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCA-0003BP-40; Mon, 24 Jun 2024 17:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrC7-00037u-8a
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrC5-0006fe-Im
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUUSa56WAHiJyp4eWKtrCbT2qKWYQky99b2hnWFqiHg=;
 b=Dto1SMgAD0jVsFHOiMHH5Y++Y1Uq9Vtawti4AIrt0rQv9bRAMtsRFS/tcL+7KIELMrFM6H
 AsYTkAWOmAKxjb1zj7+nDnWEimv/4s0jjpX7NTEj5x/eIw8YxazSCeaiyzW+HrFA7Vi0wH
 Pec20hKAyuM6IeUFzGz/g7LNkIeAVuU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-GEHSD8iPMkm-iQpsWaYgXg-1; Mon,
 24 Jun 2024 17:25:42 -0400
X-MC-Unique: GEHSD8iPMkm-iQpsWaYgXg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1210E1956095; Mon, 24 Jun 2024 21:25:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 442731956051; Mon, 24 Jun 2024 21:25:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 15/42] intel_iommu: Extract out vtd_cap_init() to initialize
 cap/ecap
Date: Mon, 24 Jun 2024 23:24:29 +0200
Message-ID: <20240624212456.350919-16-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Extract cap/ecap initialization in vtd_cap_init() to make code
cleaner.

No functional change intended.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 93 ++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c4350e0ff0eaff7a2eaa8dc88582ce6e2f0368b0..c69c0d285b1fa85da22440934178243942fe42ab 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3934,30 +3934,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     return;
 }
 
-/* Do the initialization. It will also be called when reset, so pay
- * attention when adding new initialization stuff.
- */
-static void vtd_init(IntelIOMMUState *s)
+static void vtd_cap_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    memset(s->csr, 0, DMAR_REG_SIZE);
-    memset(s->wmask, 0, DMAR_REG_SIZE);
-    memset(s->w1cmask, 0, DMAR_REG_SIZE);
-    memset(s->womask, 0, DMAR_REG_SIZE);
-
-    s->root = 0;
-    s->root_scalable = false;
-    s->dmar_enabled = false;
-    s->intr_enabled = false;
-    s->iq_head = 0;
-    s->iq_tail = 0;
-    s->iq = 0;
-    s->iq_size = 0;
-    s->qi_enabled = false;
-    s->iq_last_desc_type = VTD_INV_DESC_NONE;
-    s->iq_dw = false;
-    s->next_frcd_reg = 0;
     s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
              VTD_CAP_MGAW(s->aw_bits);
@@ -3974,27 +3954,6 @@ static void vtd_init(IntelIOMMUState *s)
     }
     s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
 
-    /*
-     * Rsvd field masks for spte
-     */
-    vtd_spte_rsvd[0] = ~0ULL;
-    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
-                                                  x86_iommu->dt_supported);
-    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
-    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
-    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
-
-    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
-                                                         x86_iommu->dt_supported);
-    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
-                                                         x86_iommu->dt_supported);
-
-    if (s->scalable_mode || s->snoop_control) {
-        vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
-        vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;
-        vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
-    }
-
     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
         if (s->intr_eim == ON_OFF_AUTO_ON) {
@@ -4027,6 +3986,56 @@ static void vtd_init(IntelIOMMUState *s)
     if (s->pasid) {
         s->ecap |= VTD_ECAP_PASID;
     }
+}
+
+/*
+ * Do the initialization. It will also be called when reset, so pay
+ * attention when adding new initialization stuff.
+ */
+static void vtd_init(IntelIOMMUState *s)
+{
+    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
+
+    memset(s->csr, 0, DMAR_REG_SIZE);
+    memset(s->wmask, 0, DMAR_REG_SIZE);
+    memset(s->w1cmask, 0, DMAR_REG_SIZE);
+    memset(s->womask, 0, DMAR_REG_SIZE);
+
+    s->root = 0;
+    s->root_scalable = false;
+    s->dmar_enabled = false;
+    s->intr_enabled = false;
+    s->iq_head = 0;
+    s->iq_tail = 0;
+    s->iq = 0;
+    s->iq_size = 0;
+    s->qi_enabled = false;
+    s->iq_last_desc_type = VTD_INV_DESC_NONE;
+    s->iq_dw = false;
+    s->next_frcd_reg = 0;
+
+    vtd_cap_init(s);
+
+    /*
+     * Rsvd field masks for spte
+     */
+    vtd_spte_rsvd[0] = ~0ULL;
+    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
+                                                  x86_iommu->dt_supported);
+    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
+
+    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
+                                                    x86_iommu->dt_supported);
+    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
+                                                    x86_iommu->dt_supported);
+
+    if (s->scalable_mode || s->snoop_control) {
+        vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
+        vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;
+        vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
+    }
 
     vtd_reset_caches(s);
 
-- 
2.45.2


