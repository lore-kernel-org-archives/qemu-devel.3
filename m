Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08ADC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 07:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZhF-0004YZ-2a; Tue, 15 Jul 2025 03:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubZgK-0004EU-30
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:02:29 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubZgG-0003sC-K7
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752562945; x=1784098945;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Saka9Cr5kzDb8mC8vLQ5SgfLXOaJtfsuZhBxhriw/Co=;
 b=KoKxOtWsHTO55W2b84rSM8BVYZx0x9b4bZNPjFEKyHD/MSIo6l2G6iRI
 IozRPnlthdy0aJHgpa/6notwZT5rzCaqYh2Iz9I5y33OMQQhDqnAX1+px
 Vd+jXvtrs7MiVIy1K/5IYKuAWRCIPBx73iQWf1A7pCp9vpSbSjokzFtdl
 rz4G3PctESziI5oKW1zjn2VZ3ksb7djTSH8QnQ3iKU46IeDzxT5aZ2hsw
 9cIr8cAjLJS4DC+7DoqsMABbmP+h9aRrvJWUomWcbDSFN7rC1iwwbQAVi
 WCMfQ0LU/oaeRw6ZrRhTOIf9y3CcXPvH/Ci4IEuVm6NCEzpZYMrIfUJ35 g==;
X-CSE-ConnectionGUID: b8xSwgEHSvWb1X+N4XaZcw==
X-CSE-MsgGUID: kWnPEQgATWCnoYpyN5d6WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65031387"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="65031387"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 00:02:20 -0700
X-CSE-ConnectionGUID: a0VNe0GnSqq5Jr6X5sbNaQ==
X-CSE-MsgGUID: m3+yE2+WS12PmM4IP4ei7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="161455040"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 00:02:18 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio/pci: Recover sub-page BAR size when base address is not
 aligned
Date: Tue, 15 Jul 2025 02:59:52 -0400
Message-ID: <20250715065952.213057-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Currently region_mr and mmap_mr size are recovered to original size when
base address is updated to non-PAGE_SIZE aligned, but still leave base_mr
with PAGE_SIZE size. This is harmless as base_mr is a only container but
still a bit confusing when executing hmp command mtree.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1093b28df7..0455e6ce30 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1348,9 +1348,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 
     memory_region_transaction_begin();
 
-    if (vdev->bars[bar].size < size) {
-        memory_region_set_size(base_mr, size);
-    }
+    memory_region_set_size(base_mr, size);
     memory_region_set_size(region_mr, size);
     memory_region_set_size(mmap_mr, size);
     if (size != vdev->bars[bar].size && memory_region_is_mapped(base_mr)) {
-- 
2.47.1


