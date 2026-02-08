Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAC8EF06E2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 08:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp07H-0000ky-Q6; Sun, 08 Feb 2026 03:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vp07G-0000kp-SI
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 03:26:02 -0500
Received: from smtppost.atos.net ([193.56.114.177] helo=smarthost4.atos.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vp07C-0003zm-N9
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 03:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1770539158; x=1802075158;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=C5hjxpopGC8KhVf5BeBDT3IdeMMhGZqqRh9FeUo9hBA=;
 b=Rftj/wntkVVu15vIPERJPmpV4sr2crnXDDX7N+yT7sExW9TO3eESDbd8
 G3ODvzK5ebfh25yWkA7LIHcb7ixNqZGJoe8wtPRewn7/LQFA50zwOIj5z
 pKvD8JFWHvqFqGSQbyWFnyqwWvT8aZnk93Xih4apdLQVXehqdmfncypd3
 euUcqleE+ihc+93EPJQi8utAPAYc21vm6dnYl0/gqNXVLxpVzOgFB4Yyf
 76jEqJiRgxd5rMezwlV3JDLHErK6RRMj58gZNUQTn8D8pdCB4rDs/aJ3k
 zT/EE9gmTsY2AuNoUXFnZCSC/hor1swgCER4EbTXAms3yX6d3dlsZwOeu g==;
X-CSE-ConnectionGUID: AJX8+2OOSDC5kbzRIu7laQ==
X-CSE-MsgGUID: EK2SX1IlSYWbAlN+xNPbhQ==
X-IronPort-AV: E=Sophos;i="6.21,279,1763420400"; d="scan'208";a="824682994"
X-MGA-submission: =?us-ascii?q?MDHWJ/EG4BFs71hpbiILMefWnWs77FPrQWkCGM?=
 =?us-ascii?q?xDrwjF6AAhB0QtRtKJsmSyRXjQXtalWqpB3afNumnk3XCQqv7dVtbGbc?=
 =?us-ascii?q?RBKtEv+LwfgSc3Dhxw/J9N5QxJkwJfR8qLwlX7egv4925zfSNzBmWk+m?=
 =?us-ascii?q?kk?=
Received: from smtp0.atos-infogerance.fr ([193.56.241.18])
 by smarthost4.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 08 Feb 2026 09:25:54 +0100
Received: from smtp-hub.atos-infogerance.fr (smtp-hub.atos-infogerance.fr
 [193.56.47.18])
 by smtp0.atos-infogerance.fr (8.15.2/8.15.2) with ESMTPS id 6188PrKL044134
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Sun, 8 Feb 2026 09:25:53 +0100
Received: from rocky.hd2c.dom ([129.181.244.14])
 by smtp-hub.atos-infogerance.fr (envelope-from
 clement.mathieu--drif@eviden.com) (8.15.2/8.15.2) with ESMTP id
 6188Prfv035233; Sun, 8 Feb 2026 09:25:53 +0100
Received: from openbmc (unknown [10.22.85.22])
 by rocky.hd2c.dom (Postfix) with ESMTP id 0A8BA256CA5;
 Sun,  8 Feb 2026 09:25:53 +0100 (CET)
Received: by openbmc (Postfix, from userid 0)
 id 05EE9812AF4D; Sun, 08 Feb 2026 08:25:53 +0000 (UTC)
From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, mst@redhat.com, 
 jasowang@redhat.com, zhenzhong.duan@intel.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, joao.m.martins@oracle.com,
 Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Subject: [PATCH] intel_iommu: Do not report recoverable faults to host
Date: Sun,  8 Feb 2026 08:22:52 +0000
Message-ID: <20260208082252.288-1-clement.mathieu--drif@eviden.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.56.114.177;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.atos.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dd00079a40..0735b24ac0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1857,6 +1857,21 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_MAX] = false,
 };
 
+static const bool vtd_recoverable_faults[] = {
+    [VTD_FR_WRITE] = true,
+    [VTD_FR_READ] = true,
+    [VTD_FR_PASID_DIR_ENTRY_P] = true,
+    [VTD_FR_PASID_ENTRY_P] = true,
+    [VTD_FR_FS_PAGING_ENTRY_INV] = true,
+    [VTD_FR_FS_PAGING_ENTRY_P] = true,
+    [VTD_FR_FS_PAGING_ENTRY_RSVD] = true,
+    [VTD_FR_PASID_ENTRY_FSPTPTR_INV] = true,
+    [VTD_FR_FS_NON_CANONICAL] = true,
+    [VTD_FR_FS_PAGING_ENTRY_US] = true,
+    [VTD_FR_SM_WRITE] = true,
+    [VTD_FR_MAX] = false,
+};
+
 /* To see if a fault condition is "qualified", which is reported to software
  * only if the FPD field in the context-entry used to process the faulting
  * request is 0.
@@ -1866,6 +1881,11 @@ static inline bool vtd_is_qualified_fault(VTDFaultReason fault)
     return vtd_qualified_faults[fault];
 }
 
+static inline bool vtd_is_recoverable_fault(VTDFaultReason fault, int iommu_idx)
+{
+    return iommu_idx == VTD_IDX_ATS && vtd_recoverable_faults[fault];
+}
+
 static inline bool vtd_is_interrupt_addr(hwaddr addr)
 {
     return VTD_INTERRUPT_ADDR_FIRST <= addr && addr <= VTD_INTERRUPT_ADDR_LAST;
@@ -2237,8 +2257,10 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     }
 
     if (ret_fr) {
-        vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
-                         addr, is_write, pasid != PCI_NO_PASID, pasid);
+        if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
+            vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
+                            addr, is_write, pasid != PCI_NO_PASID, pasid);
+        }
         goto error;
     }
 
-- 
2.53.0


