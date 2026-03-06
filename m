Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF93F513EE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyM7n-0004in-6Z; Thu, 05 Mar 2026 22:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM7l-0004dP-2H
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:45:13 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM7h-00068f-3b
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772768709; x=1804304709;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b91JdyM3r/MB3Pt3bkvQ/9SxtTmgr/eLQVr5X5DOaXU=;
 b=D9DPaXmY7cbF1cNi7vtqUcomcxLSZy0+NxshH2nyHor4nmzLj0nfPkxk
 9I3bGSOmTqS7lODZW4iO8iB6V3Mvmt5FREwVYbGIBtKhsOrThX+tehrMM
 LpRMdVfAOOc0e75GKg63DQNwkjbnjIDIPASNGJrlXMZXvpCyMGwsoAD3W
 +H94v87Snr84i/fXjG19NTD2dNTfEWdMMAzRj4CqCL1SmWtPAjBgsen2Q
 DJFCM4SVkAAxLpkaABUBkREkXkD3e9BH64vLTPRdFZAcKD7B+bs4jXmBe
 fMEVYS+MaGRpa3TokFYd7wi6ZVhiz7XgSr0wK0GVi25qOJ44yXFfjRkQ+ Q==;
X-CSE-ConnectionGUID: atKsW3Z8S3ytXR8uM3FqIQ==
X-CSE-MsgGUID: DZJQtT2yRniul/HU2A9biw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91448343"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="91448343"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:45:02 -0800
X-CSE-ConnectionGUID: DNBX2CNzQiaFPYy1vJik6Q==
X-CSE-MsgGUID: WYycjowlRsqNj+OEtUFvow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215613452"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:44:59 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 12/13] intel_iommu_accel: Add pasid bits size check
Date: Thu,  5 Mar 2026 22:44:06 -0500
Message-ID: <20260306034409.184873-13-zhenzhong.duan@intel.com>
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

If pasid bits size is bigger than host side, host could fail to emulate
all bindings in guest. Add a check to fail device plug early.

Pasid bits size should also be no more than 20 bits according to PCI spec.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 1 +
 hw/i386/intel_iommu.c          | 5 +++++
 hw/i386/intel_iommu_accel.c    | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index ede4db6d2d..d6674861fd 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -196,6 +196,7 @@
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
 #define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))
+#define VTD_ECAP_PSS(ecap)          extract64(ecap, 35, 5)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3ea5b92b34..e99a9cf9c6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5559,6 +5559,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         error_setg(errp, "Need to set scalable mode for PASID");
         return false;
     }
+    if (s->pasid > PCI_EXT_CAP_PASID_MAX_WIDTH) {
+        error_setg(errp, "PASID width %d, exceed Max PASID Width %d allowed "
+                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);
+        return false;
+    }
 
     if (s->svm) {
         if (!x86_iommu->dt_supported) {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index acb1b1e238..15412123d5 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
     HostIOMMUDevice *hiod = vtd_hiod->hiod;
     struct HostIOMMUDeviceCaps *caps = &hiod->caps;
     struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
+    uint8_t hpasid = VTD_ECAP_PSS(vtd->ecap_reg) + 1;
     PCIBus *bus = vtd_hiod->bus;
     PCIDevice *pdev = bus->devices[vtd_hiod->devfn];
 
@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
         return false;
     }
 
+    /* Only do the check when host device support PASIDs */
+    if (caps->max_pasid_log2 && s->pasid > hpasid) {
+        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size %d",
+                   s->pasid, hpasid);
+        return false;
+    }
+
     if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
         error_setg(errp, "Host device downstream to a PCI bridge is "
                    "unsupported when x-flts=on");
-- 
2.47.3


