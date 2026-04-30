Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D41FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILbS-0005TD-Ss; Thu, 30 Apr 2026 03:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILav-00059Y-3y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:14:00 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILaq-0008OM-NM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777533232; x=1809069232;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/fC8XQk85iHmQCX9DcJIIJqvK6Yi4PUzajnId/1UAKs=;
 b=mMvt3v9icgPiUhemnxDQ1WcByq5JfjW7gkCjGSzFXC+HgG65eNYWcn39
 JL6uqieljButBdM8/nidisyY1LihALid9ZVYENQbwf0vMZ8vmUefM6BYv
 YMjn/ZBewhIvJTeZEGN+qXhFM0eFdpTcajn+/Fsko+T4lpKLWlznBIQmQ
 j4v2bJom+H7pvosE59tLcvsnwCvshpdmoy99TyEcwMiv2p6zyYbd17YKz
 R+MsXyPl9w5eO8x1i2vswll/LS6XlqrD9ClcOvDyoR1lq0UHr7LX2rePu
 oDSx+6bNTozBPVB13Q1QjTWpbPIggpNCYaQtBSDf6lWzJPxhxdpTyFJpM g==;
X-CSE-ConnectionGUID: ZoRyM+tOTKW8hhPwOyLJcQ==
X-CSE-MsgGUID: KFvZoOvkTPSXV7Ok5ReYgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="81051604"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="81051604"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:13:50 -0700
X-CSE-ConnectionGUID: DDt/SqrfTgO2ejkRiDIC8Q==
X-CSE-MsgGUID: 3ZK4pXCURm6SZEAvjVeVhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234771489"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:13:47 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 05/15] intel_iommu: Change pasid property from bool to uint8
Date: Thu, 30 Apr 2026 03:13:01 -0400
Message-ID: <20260430071315.354333-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430071315.354333-1-zhenzhong.duan@intel.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
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

'x-pasid-mode' is a bool property, we need an extra 'pss' property to
represent PASID size supported. Because there is no any device in QEMU
supporting pasid capability yet, no guest could use the pasid feature
until now, 'x-pasid-mode' takes no effect.

So instead of an extra 'pss' property we can use a single 'pasid'
property of uint8 type to represent if pasid is supported and the PASID
bits size. A value of N > 0 means pasid is supported and N - 1 is the
value in PSS field in ECAP register.

PASID bits size should also be no more than 20 bits according to PCI spec.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_internal.h |  2 +-
 include/hw/i386/intel_iommu.h  |  2 +-
 hw/i386/intel_iommu.c          | 11 +++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 11a53aa369..db4f186a3e 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,7 +195,7 @@
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
-#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
+#define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index e44ce31841..95c76015e4 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -314,7 +314,7 @@ struct IntelIOMMUState {
     bool intr_eime;                 /* Extended interrupt mode enabled */
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
-    bool pasid;                     /* Whether to support PASID */
+    uint8_t pasid;                  /* PASID supported in bits, 0 if not */
     bool fs1gp;                     /* First Stage 1-GByte Page Support */
 
     /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b784c5f10a..d1946e3a59 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4203,7 +4203,7 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
     DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
-    DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
+    DEFINE_PROP_UINT8("pasid", IntelIOMMUState, pasid, 0),
     DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
     DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
@@ -5045,7 +5045,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
 
     if (s->pasid) {
-        s->ecap |= VTD_ECAP_PASID | VTD_ECAP_PSS;
+        VTD_ECAP_SET_PSS(s, s->pasid - 1);
+        s->ecap |= VTD_ECAP_PASID;
     }
 }
 
@@ -5586,6 +5587,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         return false;
     }
 
+    if (s->pasid > PCI_EXT_CAP_PASID_MAX_WIDTH) {
+        error_setg(errp, "PASID width %d exceeds Max PASID Width %d allowed "
+                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);
+        return false;
+    }
+
     if (s->svm) {
         if (!x86_iommu->dt_supported) {
             error_setg(errp, "Need to set device IOTLB for svm");
-- 
2.47.3


