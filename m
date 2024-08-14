Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5A7C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 07:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8Ev-0005xy-Lx; Wed, 14 Aug 2024 03:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1se8Eu-0005uO-JB
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 03:16:12 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1se8Er-0001Ca-Q4
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 03:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723619770; x=1755155770;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Wko75MRX3IHdnDzyADvbJ/ahhC9dRD+bEy03LAGV6q8=;
 b=ZLpna5a1MKX6K7HYwKbf+G2ZapETgFkjbWty5DddL7lK7WL8/e7nISlD
 ADJVQRngStCFgESNrt/RDMaOy2GnEOrGghmNWOnouXlmeUGNp+lb/Aona
 7920eGiPga1RFIGofyJ6AtO37es+1KyxmgIfBSpZL/pTZHmf+0HLVab3N
 KXCRespjzbETSRIN3LM3u9SHekaJp/lTkeyMR9db5HeyppZcSxywWuUvj
 d5ekyZxc4eLY345c3rviJrIIi9vnE7dISM9p2UVmn2A6w/z3H02BdCPQe
 DjB8OqJVaA+Zp5sV9QL6/Vmb8ldwFYFXw0pfEijyNfWt8WHPVUBon0lHP w==;
X-CSE-ConnectionGUID: ny2cChBUTkSjFocUORWQiw==
X-CSE-MsgGUID: Uwfyb1OuTMygnee3nUvZNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32443651"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="32443651"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 00:16:08 -0700
X-CSE-ConnectionGUID: uL7zcx0+Rm2LOv9AhuePhw==
X-CSE-MsgGUID: 6wYhvqK9SH63Wjx3edNCGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="63326664"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 00:16:06 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 2/2] intel_iommu: Make PASID-cache and PIOTLB type invalid
 in legacy mode
Date: Wed, 14 Aug 2024 15:13:20 +0800
Message-Id: <20240814071321.2621384-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814071321.2621384-1-zhenzhong.duan@intel.com>
References: <20240814071321.2621384-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fixes: 4a4f219e8a10 ("intel_iommu: add scalable-mode option to make scalable mode work")
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
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


