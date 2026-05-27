Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A7BCD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS781-0006IS-Tw; Wed, 27 May 2026 01:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS77h-0006Fp-3Y
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:48:13 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS77e-0000cT-Qx
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779860887; x=1811396887;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SaYEI5jtpzrHueHXY2JSluk3hjuH9bSiA+4fOkitfk4=;
 b=ONsPmfnKugQOBaMj/r5vn1WrRKxiJqWxR2PkgMgYvLk48wEzDN7F39Sy
 EwdsREq79t27FUNB2G0DXEehachYtwktBksPlFdYKNQvENylb57f7qV5q
 bI0/AtUFmcLVg+Pq35+vG4O2dZ9gg7osI5ng8ykNC2UxKB5/S4TUrWbnl
 djzry8Yd0vOZSJc/VO+eNDPHv0v5qHHXCwRepdsBBmorZ9zxxnJbGxbtW
 wVtyiuLMGxTyEifzt0otVXORtZcqaPPwgdCFQGqxjLH1qCJQDxbLtnUhj
 0rYClH0v+4Fd+y5PObjg8VC4PVOls/58WggYr5zr/HYtcKs0DVxA+Hh52 Q==;
X-CSE-ConnectionGUID: U4c/1AP5QUWZzyqUYcWUJQ==
X-CSE-MsgGUID: kXNdoIcySDOm6Wywcf/UPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90988135"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="90988135"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:48:06 -0700
X-CSE-ConnectionGUID: 84dnTbrLRiS84/XKQvp1NA==
X-CSE-MsgGUID: aPUhb616TIquZMdSGhnn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="241086781"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:48:03 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 08/17] intel_iommu: Fix PASID validity check in fault
 reporting
Date: Wed, 27 May 2026 01:46:46 -0400
Message-ID: <20260527054658.1021096-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
References: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The current code incorrectly uses "pasid != PCI_NO_PASID" to determine if
PASID should be reported in fault records. However, this check happens
after the code converts PCI_NO_PASID to PASID_0 in scalable mode.

This means that for requests that originally had PCI_NO_PASID, the check
"pasid != PCI_NO_PASID" will incorrectly return true (since pasid is now
PASID_0), causing fault records to incorrectly indicate PASID validity.
According to the VT-d specification, the PASID field in fault records is
only valid for Requests-with-PASID:

  "When Set, indicates the faulted request has a PASID TLP Prefix."

Fix this by capturing the original PASID state before the PCI_NO_PASID to
PASID_0 conversion, ensuring fault records correctly reflect whether the
original request had a PASID.

Fixes: 1b2b12376c8a ("intel_iommu: process PASID-based iotlb invalidation")
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 24d0211db7..034747b0b4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2109,6 +2109,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool is_fpd_set = false;
     bool reads = true;
     bool writes = true;
+    bool is_pasid = pasid != PCI_NO_PASID;
     uint8_t access_flags, pgtt;
     VTDIOTLBEntry *iotlb_entry;
     uint64_t xlat, size;
@@ -2235,7 +2236,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     if (ret_fr) {
         if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
             vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
-                            addr, is_write, pasid != PCI_NO_PASID, pasid);
+                            addr, is_write, is_pasid, pasid);
         }
         goto error;
     }
-- 
2.47.3


