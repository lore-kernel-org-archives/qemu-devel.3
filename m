Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17E5CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 06:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPEGj-0004gN-5a; Tue, 19 May 2026 02:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wPEGX-0004e0-Qg
 for qemu-devel@nongnu.org; Tue, 19 May 2026 02:49:27 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wPEGS-0007LF-5H
 for qemu-devel@nongnu.org; Tue, 19 May 2026 02:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779173356; x=1810709356;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hdnlfIlhAbY08Cuup1HuZBd0OKB0di35DH4Xdr/D3yg=;
 b=nwrqE0Cza1AIwH7lCgDeVlbvu6znitVThexKlyZuKnKFyx+3ajJJO3cp
 NXR95e6AHByg+fR++/AbMQeuzrn3busjExtTaP2+Xf04q1sNIZfnbypea
 nSs3x13LBxhZQeavnIL6bHstHlUVDnUwk51jGk0FzBuPbR7tjfmJGtzJ0
 0Pk4Z6M+fRlh9MPryDfgiRbWnCTZBGCkBy3Q1Fa3EzNeDtCu1In2hZ2Fs
 fF7oSDS/71DQCiBfXrn3/L6Uk234Niyd6MjnOoLtk0OrElLIXIdrhuivN
 QhCBkbirsTOEF3i3owgu3xHvykZM01gTbLOy/wF2DyV+wcwQ78DktVLLz g==;
X-CSE-ConnectionGUID: bVwTQKuvRvOw/12WFKTrHQ==
X-CSE-MsgGUID: li7QKLU6SgqguejKDC12Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79942075"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="79942075"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 23:49:10 -0700
X-CSE-ConnectionGUID: p8ugzGpxSCmNgL84LuqDNQ==
X-CSE-MsgGUID: EVDuSiBMQfu8/nwySVPGgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="233288695"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by fmviesa009.fm.intel.com with ESMTP; 18 May 2026 23:49:08 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: xiaoyao.li@intel.com,
	qemu-devel@nongnu.org
Subject: [PATCH] vfio: Clean up vfio_region_unmap()
Date: Tue, 19 May 2026 14:35:40 +0800
Message-ID: <20260519063540.1117808-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Since commit 7429aebe1cff ("vfio/migration: Remove VFIO migration
protocol v1"), vfio_region_unmap() lost all its callers.

Remove unused vfio_region_unmap().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/vfio/region.c      | 15 ---------------
 hw/vfio/vfio-region.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 0342ca712acd..dbde33918026 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -468,21 +468,6 @@ no_mmap:
     return ret;
 }
 
-void vfio_region_unmap(VFIORegion *region)
-{
-    int i;
-
-    if (!region->mem) {
-        return;
-    }
-
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            vfio_subregion_unmap(region, i);
-        }
-    }
-}
-
 void vfio_region_exit(VFIORegion *region)
 {
     int i;
diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 9b21d4ee5ba1..58b236f1133e 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -41,7 +41,6 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name, Error **errp);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
-void vfio_region_unmap(VFIORegion *region);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 
-- 
2.43.0


