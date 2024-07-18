Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BECAC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMNN-0001IV-LX; Thu, 18 Jul 2024 04:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMNL-0000vH-30
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:31 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMNJ-000083-An
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721290829; x=1752826829;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iYPP71c4U2gJ0eTAvL01niOiqrSLIGzpyXppg4sxyTU=;
 b=C/lZGOdFGAMXw5PJn72lE/VudAOFnpK1yXujPXHri0Iss7WVU1WXgpna
 PofhxH0o2Q6L7WsF2E9fqpB8ZfWct9wnHlnqiVRA/lYlJ/w+MOOCI2i/e
 ivatts0DCgFqcoRyTM7VmkQXQUNrzuIPpcEqgO7/30m7aP2tkQCoqj9/Y
 EYa5HcqbCscyuk1jmwfHoq06yok2jC2Zq8/L/qjqHm+6WNSkAgQRXE8X0
 ShftnZocblF3v2Gi2U676yrZ/lLSnwsf+Wlj8nGyxgynKGGRY2x2zo0mD
 p6nuftotB4p93M/pAihzC05R/yvpruqf/OqgjLcH99BW9MYyVUzt+UuSb Q==;
X-CSE-ConnectionGUID: QpBDSyvRR/uD8ehePXpbFw==
X-CSE-MsgGUID: CXHW6FMZR6Gd3cQ7/acrXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29996408"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="29996408"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:20:27 -0700
X-CSE-ConnectionGUID: +JAKjvN4SJW1kbaGJ5zlyA==
X-CSE-MsgGUID: wXDASGxoTSq5U7qpeTKrVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="81717547"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:20:22 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v1 15/17] intel_iommu: Set default aw_bits to 48 in scalable
 modren mode
Date: Thu, 18 Jul 2024 16:16:34 +0800
Message-Id: <20240718081636.879544-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718081636.879544-1-zhenzhong.duan@intel.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

According to VTD spec, stage-1 page table could support 4-level and
5-level paging.

However, 5-level paging translation emulation is unsupported yet.
That means the only supported value for aw_bits is 48.

So default aw_bits to 48 in scalable modern mode. In other cases,
it is still default to 39 for compatibility.

Add a check to ensure user specified value is 48 in modern mode
for now.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  2 +-
 hw/i386/intel_iommu.c         | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index b843d069cc..48134bda11 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
 #define DMAR_REG_SIZE               0x230
 #define VTD_HOST_AW_39BIT           39
 #define VTD_HOST_AW_48BIT           48
-#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
+#define VTD_HOST_AW_AUTO            0xff
 #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
 
 #define DMAR_REPORT_F_INTR          (1)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c0116497b1..2804c3628a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3768,7 +3768,7 @@ static Property vtd_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
-                      VTD_HOST_ADDRESS_WIDTH),
+                      VTD_HOST_AW_AUTO),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
@@ -4686,6 +4686,14 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
+    if (s->aw_bits == VTD_HOST_AW_AUTO) {
+        if (s->scalable_modern) {
+            s->aw_bits = VTD_HOST_AW_48BIT;
+        } else {
+            s->aw_bits = VTD_HOST_AW_39BIT;
+        }
+    }
+
     if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
         (s->aw_bits != VTD_HOST_AW_48BIT) &&
         !s->scalable_modern) {
@@ -4694,6 +4702,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         return false;
     }
 
+    if ((s->aw_bits != VTD_HOST_AW_48BIT) && s->scalable_modern) {
+        error_setg(errp, "Supported values for aw-bits are: %d",
+                   VTD_HOST_AW_48BIT);
+        return false;
+    }
+
     if (s->scalable_mode && !s->dma_drain) {
         error_setg(errp, "Need to set dma_drain for scalable mode");
         return false;
-- 
2.34.1


