Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C149C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 07:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdmFB-0002GI-EM; Tue, 13 Aug 2024 03:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdmF9-00029G-Jb
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:46:59 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdmF7-0008Ji-VI
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723535218; x=1755071218;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wMuL4g2fNmVvaGBHutmv6NRnZdq4nZCfiAWrtag3mTg=;
 b=lIuuHiYUmtqq1XpMvW/NihfUCgrKMHkLeiciVL3GRCFGmekYjqPVlH0R
 7SBCqufdcbZF8nclcolaKD/c7e4+qU3OX7stlweq02YFPwFg5jrNbVMDI
 ZucPx3Q+SmCe3YCXk/yPPgYLo2QZv9Erl8W8elBGbw5k8GpUwzjSUjTd+
 SvM0OrZGhpKn0efgjwNx7kZqcWX6tH953ejh8dxfq6Iy3pbjLOnrBWDjH
 jPlpt2TQq6nP14XDV2SHMChuaZlFopWcZuc9NWPc8YzpoUp3I+yoHgIIP
 MhhITrv8X+ORFaERqfucQAVERS6MXaMgwzMECPsDqtVzwifaP67ib690/ g==;
X-CSE-ConnectionGUID: Gz/Z2QVKQ52ITZqRpwUn8w==
X-CSE-MsgGUID: VCRW6YYcS3qcEV2T/yCD6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="12980994"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="12980994"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 00:46:57 -0700
X-CSE-ConnectionGUID: Si97eZ8rRfakxducwdSlgQ==
X-CSE-MsgGUID: D3RoCx+bQPGlS6PKOUgELA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="59146277"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 00:46:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 2/2] intel_iommu: Make PASID-cache and PIOTLB type invalid
 in legacy mode
Date: Tue, 13 Aug 2024 15:44:10 +0800
Message-Id: <20240813074410.2571369-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813074410.2571369-1-zhenzhong.duan@intel.com>
References: <20240813074410.2571369-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In vtd_process_inv_desc(), VTD_INV_DESC_PC and VTD_INV_DESC_PIOTLB are
bypassed without scalable mode check. These two types are not valid
in legacy mode and we should report error.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 68cb72a481..90cd4e5044 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2763,17 +2763,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
-    /*
-     * TODO: the entity of below two cases will be implemented in future series.
-     * To make guest (which integrates scalable mode support patch set in
-     * iommu driver) work, just return true is enough so far.
-     */
-    case VTD_INV_DESC_PC:
-        break;
-
-    case VTD_INV_DESC_PIOTLB:
-        break;
-
     case VTD_INV_DESC_WAIT:
         trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_wait_desc(s, &inv_desc)) {
@@ -2795,6 +2784,17 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    /*
+     * TODO: the entity of below two cases will be implemented in future series.
+     * To make guest (which integrates scalable mode support patch set in
+     * iommu driver) work, just return true is enough so far.
+     */
+    case VTD_INV_DESC_PC:
+    case VTD_INV_DESC_PIOTLB:
+        if (s->scalable_mode) {
+            break;
+        }
+    /* fallthrough */
     default:
         error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
                           " (unknown type)", __func__, inv_desc.hi,
-- 
2.34.1


