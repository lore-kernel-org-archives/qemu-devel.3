Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDD0CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 05:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPDTI-0000xC-Tp; Tue, 19 May 2026 01:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wPDT7-0000w5-MP
 for qemu-devel@nongnu.org; Tue, 19 May 2026 01:58:18 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wPDT4-0004b7-8h
 for qemu-devel@nongnu.org; Tue, 19 May 2026 01:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779170294; x=1810706294;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=arMHSpgD6z3rmrF/uW2QlMBEG+7ES+RRnwrv+atwzeE=;
 b=PFRtZP0X0RjxtVSaWB2mVIxEhA3f3tu+SAzETYom1jZdBr8uuTajot8L
 WHlfzio1ec37G20/1m3DZZZIsBfFeN4yJxdiWredtsk7MoyHBVKh9N70S
 n1jpCmKecxONGL7zIMbP2MGLnGG0N39U6c+zVPgTzbi8Pm9zleD9PGlwS
 eaNx0bWYhwgNiWTuvZ4DaVXCs2ppHleysjhrtEp010TuAkGLOuzB8gCYa
 Bd0DXEp1V/tubeJ9zfh+Njb/9rgHFOUfavqkMc6Lo7ME+D7VaLD8L0LdT
 YN27bvHQpUB+dCYQcSizf0LDMci983po/oa0fdHNTP35I7iQ3d7HjEejh w==;
X-CSE-ConnectionGUID: YOIqn3MMSieBgM1bFyXIjw==
X-CSE-MsgGUID: uiGhcRCnTVyGfOPwI9JH3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79937718"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="79937718"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 22:58:08 -0700
X-CSE-ConnectionGUID: 2jdv8tLpRY6vlznAJmnsww==
X-CSE-MsgGUID: Bj5cj15jTTOQJrMa03AmbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="243645429"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 22:58:06 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: qemu-devel@nongnu.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Farrah Chen <farrah.chen@intel.com>
Subject: [PATCH] vfio/container: Restrict dma_map_file() to shared RAM
Date: Tue, 19 May 2026 13:57:50 +0800
Message-ID: <20260519055756.70575-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
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

vfio_container_dma_map() uses dma_map_file() whenever a RAMBlock has an
fd and the VFIO IOMMU backend supports file-based DMA mapping. That is
not correct for private file-backed RAM.

dma_map_file() resolves PFNs from the backing file, but private
mappings can run on different PFNs than the file itself. As a result,
using dma_map_file() on a private RAMBlock can program DMA against pages
that do not back QEMU's actual guest memory.

This was observed with hugetlbfs-backed guest memory and iommufd/VFIO:
share=on works, while share=off can fault because the file-backed PFNs
can diverge from the PFNs backing QEMU's private mapping.

Fix this by using dma_map_file() only for shared RAMBlocks.

Fixes: fb32965b6dd8 ("vfio/iommufd: use IOMMU_IOAS_MAP_FILE")
Reported-by: Farrah Chen <farrah.chen@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220776
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 hw/vfio/container.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4c2816b574..c5a3c60a27 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -82,7 +82,7 @@ int vfio_container_dma_map(VFIOContainer *bcontainer,
     RAMBlock *rb = mr->ram_block;
     int mfd = rb ? qemu_ram_get_fd(rb) : -1;
 
-    if (mfd >= 0 && vioc->dma_map_file) {
+    if (mfd >= 0 && vioc->dma_map_file && qemu_ram_is_shared(rb)) {
         unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
         unsigned long offset = qemu_ram_get_fd_offset(rb);
 
-- 
2.43.5


