Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7511AC7EE39
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 06:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV2iS-0003zy-7A; Fri, 27 Jun 2025 02:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uV2iO-0003zi-IS
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 02:37:36 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uV2iL-0004JQ-Pf
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 02:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751006254; x=1782542254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HiBSo6MbVN1I5cxIGDOO4hgPnPzUGXHZ/UZ2bB0sRu4=;
 b=En/YdiFmiodLmYuPc53DqlqJvx7XiHLtyCn1FnQbVKlqCzT5a3KEPvLx
 LFVfUXBnc/TBXs1vlAqYKYpte3B9MahdZr7g5CLmHhPdJgGbL8SN8eZoe
 b7xy8HdcRjRROmo5aONtYaQBS4AWyfOkTVFLcWbqGAql5Uy8V+VVJH6Dc
 Jp/UzsG+5Uh9MHCu7wQywdrQznhchU1HG8wey9BkobPo7Q1QCDDT7zVa4
 53SZHWMHB9RIU2JcMHzug4a8qDms9EFkLxTcaUpTKpS+8IrgQznGSO6h4
 GKews/5hqO2+xv8nYA1w+xtarc7AIiXkXHj0T12WM34tlNXVnJ7JYVqPH w==;
X-CSE-ConnectionGUID: 1rXkFwPQTISaISTbQGAXXQ==
X-CSE-MsgGUID: 6gUOomE3TJilxzo+gdQDRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="40931460"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="40931460"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 23:37:28 -0700
X-CSE-ConnectionGUID: +ZQQsXCFSUWjJZNb04u5KA==
X-CSE-MsgGUID: DQmbOECoSTuCkFQLFMIVeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="153438106"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 23:37:26 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 1/2] vfio/container: Fix potential SIGSEGV when recover
 from unmap-all-vaddr failure
Date: Fri, 27 Jun 2025 14:33:31 +0800
Message-Id: <20250627063332.5173-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627063332.5173-1-zhenzhong.duan@intel.com>
References: <20250627063332.5173-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

CPR overrides then restores dma_map in both outgoing and incoming QEMU, for
different reasons. But it only sets saved_dma_map in the target.

Fix it by always setting saved_dma_map.

Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
Suggested-by: Steven Sistare <steven.sistare@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/cpr-legacy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index a84c3247b7..0a5d1bd480 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -180,9 +180,9 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
     /* During incoming CPR, divert calls to dma_map. */
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    container->cpr.saved_dma_map = vioc->dma_map;
     if (cpr_is_incoming()) {
-        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
-        container->cpr.saved_dma_map = vioc->dma_map;
         vioc->dma_map = vfio_legacy_cpr_dma_map;
     }
 
-- 
2.34.1


