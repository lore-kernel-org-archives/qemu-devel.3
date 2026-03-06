Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50251F513E9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyM7F-0004MD-E6; Thu, 05 Mar 2026 22:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM7D-0004LY-B3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:44:39 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM7B-00066q-O8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772768677; x=1804304677;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dLwKjHysMyWUSXi/3JataqskFEyXcx5vPfq/HPK+gnI=;
 b=UWEuSRgLxW508FpsiM6QeEkPv8yYS5jNFUiSZCUWJddn2CZ982nCmn+f
 OWp8fpioxl62wYYIcydFzwCcDArz3Ma0zqlLWIoacxl9ovPemC3SxhEFw
 XWsC2FQ40XMI2I3OQxcDE3GuOIG+HBuG0FZBi+rGhx9rEtCOMNI5fdGy1
 08XPxVrLbOI7nxTlK+IBbS5Cz2lJfH/65Ad4+j9qFo2IGdH7kzfz9k7IN
 2vj7pA6w5DXOLjKWpERIUBWii5/rwMqSnyFOBptOXH9FfjZzAzhR9d1UC
 2EkOotXXGNcCd4uYo9L5zQ3PncYB0r0O/hlpKE8RlJdrdAouHg8Nk9OjC Q==;
X-CSE-ConnectionGUID: O+U0GVvBS3W5vkGblZ4PNA==
X-CSE-MsgGUID: 7169VqdEQWiwOSXb44jUmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91448280"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="91448280"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:44:37 -0800
X-CSE-ConnectionGUID: 6PQHxinISeKA/GJlv9Oflw==
X-CSE-MsgGUID: Ve0C4ycoQkC9XKok/1oMqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215613355"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:44:34 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 05/13] intel_iommu: Change pasid property from bool to uint8
Date: Thu,  5 Mar 2026 22:43:59 -0500
Message-ID: <20260306034409.184873-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306034409.184873-1-zhenzhong.duan@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
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

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 2 +-
 include/hw/i386/intel_iommu.h  | 2 +-
 hw/i386/intel_iommu.c          | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

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
index 54c2b6b77a..bb957b93e0 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -315,7 +315,7 @@ struct IntelIOMMUState {
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
-    bool pasid;                     /* Whether to support PASID */
+    uint8_t pasid;                  /* PASID supported in bits, 0 if not */
     bool fs1gp;                     /* First Stage 1-GByte Page Support */
 
     /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d24ba989bf..e5b9689fae 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4203,7 +4203,7 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
     DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
-    DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
+    DEFINE_PROP_UINT8("pasid", IntelIOMMUState, pasid, 0),
     DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
@@ -5046,7 +5046,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
 
     if (s->pasid) {
-        s->ecap |= VTD_ECAP_PASID | VTD_ECAP_PSS;
+        VTD_ECAP_SET_PSS(s, s->pasid - 1);
+        s->ecap |= VTD_ECAP_PASID;
     }
 }
 
-- 
2.47.3


