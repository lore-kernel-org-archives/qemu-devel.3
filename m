Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D86CD2E9C2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPwY-0004uc-QY; Mon, 11 Nov 2024 03:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPwD-0004rC-Up
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:21 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPwA-0003Ti-7n
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314298; x=1762850298;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MOa8d+ZTab9kO7H0Fv5Pl2cDsaYrayGN1vt43IDtJ4E=;
 b=YJclkUdnkz8TvNkp+JydxtHa/f+JAdAsCivDD+Wh2j2uqyp4ezn+86jU
 41yP2zMQIf14d8r0lNjXbR8cnyencdADm2BmxmwHPZuAQOVHJfud47MTr
 ulrmS738ShGZoFNqXfj+fHKdeQEaiHZzMkMb7z1GKpEuw4wbBZkOxrUkk
 8WKRWJu3B6SEnRLJy3how58qW95iLxCYFzqQjX49/cWS2aV+tG+G5uM8W
 ntMcpXfTM01QcmKks2tokl8U8KAG2DAhUPFEgWtYujXppamxYZb9iiitI
 ShJnR87HRtAVEk3OtlIBtPtBb1Utrl9s1LVF/hjFU0zUKfpR2JcYOO8VF g==;
X-CSE-ConnectionGUID: 2jwcAfPIQj6nzKAQ8p76WA==
X-CSE-MsgGUID: gHneuQHmQ02vKhxyJkf+5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334349"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334349"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:17 -0800
X-CSE-ConnectionGUID: eeSzH7jbStGwCe56fKJATg==
X-CSE-MsgGUID: dbmmTXGFQCqJBGrtCcKiIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608252"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:13 -0800
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
Subject: [PATCH v5 03/20] intel_iommu: Add a placeholder variable for scalable
 modern mode
Date: Mon, 11 Nov 2024 16:34:40 +0800
Message-Id: <20241111083457.2090664-4-zhenzhong.duan@intel.com>
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

Add an new element scalable_mode in IntelIOMMUState to mark scalable
modern mode, this element will be exposed as an intel_iommu property
finally.

For now, it's only a placehholder and used for address width
compatibility check and block host device passthrough until nesting
is supported.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/i386/intel_iommu.c         | 23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index d372cd396b..3d65bbbd56 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -262,6 +262,7 @@ struct IntelIOMMUState {
 
     bool caching_mode;              /* RO - is cap CM enabled? */
     bool scalable_mode;             /* RO - is Scalable Mode supported? */
+    bool scalable_modern;           /* RO - is modern SM supported? */
     bool snoop_control;             /* RO - is SNP filed supported? */
 
     dma_addr_t root;                /* Current root table pointer */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 10b8425a6c..1d13916a98 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3918,7 +3918,13 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return false;
     }
 
-    return true;
+    if (!s->scalable_modern) {
+        /* All checks requested by VTD non-modern mode pass */
+        return true;
+    }
+
+    error_setg(errp, "host device is unsupported in scalable modern mode yet");
+    return false;
 }
 
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
@@ -4308,14 +4314,21 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
-    /* Currently only address widths supported are 39 and 48 bits */
-    if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
-        (s->aw_bits != VTD_HOST_AW_48BIT)) {
-        error_setg(errp, "Supported values for aw-bits are: %d, %d",
+    if (!s->scalable_modern && s->aw_bits != VTD_HOST_AW_39BIT &&
+        s->aw_bits != VTD_HOST_AW_48BIT) {
+        error_setg(errp, "%s mode: supported values for aw-bits are: %d, %d",
+                   s->scalable_mode ? "Scalable" : "Legacy",
                    VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
         return false;
     }
 
+    if (s->scalable_modern && s->aw_bits != VTD_HOST_AW_48BIT) {
+        error_setg(errp,
+                   "Scalable modern mode: supported values for aw-bits is: %d",
+                   VTD_HOST_AW_48BIT);
+        return false;
+    }
+
     if (s->scalable_mode && !s->dma_drain) {
         error_setg(errp, "Need to set dma_drain for scalable mode");
         return false;
-- 
2.34.1


