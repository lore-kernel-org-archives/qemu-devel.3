Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64F6D2E9C2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPyA-0007sg-FM; Mon, 11 Nov 2024 03:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPxO-0006Y7-Pd
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:35 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPxM-0003ZP-VF
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314373; x=1762850373;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7EyDkCz8S2Yku1Eky+Q6KJyQ6NS4KYFCOcTwMC8ebyw=;
 b=Y0tfaIJR2oucE0lZVIyUEw3TC3cwsedPv26LTj4z/bCFVVvLoIVNiyPb
 z45OSIRiFDltmY4UOs4eTPWJZnQEBrlDHqJHabCd4PIiGCvsQSCb19dVt
 evDD5L4joKXoQxRWEhP0diBQK8yJylesWMGN2ljOp5jR+Q/zhA0irTHlA
 dsrZmCRU6VusGLjsbRs+dMSlR5fp/zviRJmpZQ+8XZqDhFpmBycEHzRNM
 TdazqsgK+jQRKWO4sYGEjGOJYArtBAI7MUr2MLYFdHiIJ6iWbG3V0Fua0
 jEnH44VdPMk+NG93jxHAl0lY9CPlT74IiS0l1s3daRfDjTT92vgHxV6ub g==;
X-CSE-ConnectionGUID: BKw8kr6/SKScRfEarJN8Lg==
X-CSE-MsgGUID: 84MdD0pAQSSNSO8xMeYo9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334604"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334604"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:39:31 -0800
X-CSE-ConnectionGUID: zORfAzxiQnekTfLStd4NfA==
X-CSE-MsgGUID: OzWq31/hQ0Ocy4m7sfGd8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608472"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:39:28 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 19/20] intel_iommu: Introduce a property to control FS1GP
 cap bit setting
Date: Mon, 11 Nov 2024 16:34:56 +0800
Message-Id: <20241111083457.2090664-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This gives user flexibility to turn off FS1GP for debug purpose.

It is also useful for future nesting feature. When host IOMMU doesn't
support FS1GP but vIOMMU does, nested page table on host side works
after turning FS1GP off in vIOMMU.

This property has no effect when vIOMMU isn't in scalable modern
mode.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/i386/intel_iommu.h | 1 +
 hw/i386/intel_iommu.c         | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 09ce707930..fa787d5b0d 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -307,6 +307,7 @@ struct IntelIOMMUState {
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
     bool dma_translation;           /* Whether DMA translation supported */
     bool pasid;                     /* Whether to support PASID */
+    bool fs1gp;                     /* First Stage 1-GByte Page Support */
 
     /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
     bool stale_tm;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a7a81aebee..043426032c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3834,6 +3834,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
+    DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -4562,7 +4563,9 @@ static void vtd_cap_init(IntelIOMMUState *s)
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
     if (s->scalable_modern) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
-        s->cap |= VTD_CAP_FS1GP;
+        if (s->fs1gp) {
+            s->cap |= VTD_CAP_FS1GP;
+        }
     } else if (s->scalable_mode) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
     }
-- 
2.34.1


