Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E092AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarFw-00053A-Na; Mon, 05 Aug 2024 02:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarFY-0003XM-SI
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:31:21 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarFU-0002DM-Oy
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722839476; x=1754375476;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GFvOFa9P+mYkjosgDpkYes8UGBsmHawsSqhMW/hkTRs=;
 b=AnzDJfX/pRxevqhBSXTOuHm3H/xe7I1ibRMX/QSOuUsQQwiM+Z7qWYMC
 Gz1Pc1qwx+hvfTsu3hi00ZSZWnFDROAbMuzHFAFzMUAfXjckRik/8YJc0
 79Ii9pt8ItGY/3w4ACvIc/TThPZkQ2mSLFVYmLK9a7ZDCro+f9LfKbREc
 sv4UYzoDXs3WLMY6UB/VvTnEVw21XnNX/zz/tY6Xosg8OaAHPsU+cckAR
 kWK4vwdqMHw9m9+fEHaecQeseJ0RpIOW9ubNNEoK9FC/I9bL+YwHhofVW
 uCY6NvsIjRiUcbyG5Yp/vN5uol5v+le7x7uENbw+DygpBKd82gWu/DDQx A==;
X-CSE-ConnectionGUID: rGouqvh7T6qrP5Ol4t18Qw==
X-CSE-MsgGUID: JfmfLLysRomire3QgKL62Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38282879"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="38282879"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:31:13 -0700
X-CSE-ConnectionGUID: c/I1cMjFSq2yMGtwbjl+fQ==
X-CSE-MsgGUID: JYtLWmxRQcqWf6wsUYVyag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="56787061"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:31:09 -0700
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
Subject: [PATCH v2 14/17] intel_iommu: Set default aw_bits to 48 in scalable
 modren mode
Date: Mon,  5 Aug 2024 14:27:24 +0800
Message-Id: <20240805062727.2307552-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
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
index 317e630e08..5469ab4f9b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3770,7 +3770,7 @@ static Property vtd_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
-                      VTD_HOST_ADDRESS_WIDTH),
+                      VTD_HOST_AW_AUTO),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
@@ -4685,6 +4685,14 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
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
@@ -4693,6 +4701,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
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


