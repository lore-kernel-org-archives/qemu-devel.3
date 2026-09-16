Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AB9C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mWA-0004dg-Dt; Wed, 16 Sep 2026 06:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x6mW6-0004bs-1W
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:05:26 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x6mW3-0005ug-42
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789553123; x=1821089123;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f12rT1oVsQxui4wfBXUQ2DFK71TtMXEqUn4sY43FYLI=;
 b=dk7oYVC1J+5+PgBt+EKJy+6DP+igoUVCNYd5/m8mhjBtX3J10uhM1qlU
 zO3uv0PqcV/WEatm0Ig1jRffDlkHxY/4N4hiyw055aLaPqMMNRIKZui68
 E19Rdmkg0lW9JAGp8xeWD0u/CbVvZSDZBpAkoLYab5S+VkDNhfa2fKtJQ
 bC2rJgsUpdY9P0lAbAZ4oX4nfY9jJ5hn44c6UEz5tLs+dvGTzrU03dAZu
 moeB1sgNqTruE0vafKUolZVLYJPvqOu/KEEymX7h3SHwHbMblcr3PS4Wr
 5ljDC5Nj9q0T1DTFUd4WH+b4pizCpSCQR0K753Yjh7KB2xPK8qYM/h3Lt A==;
X-CSE-ConnectionGUID: CdjQd4a4Tm2fzBACRzQINg==
X-CSE-MsgGUID: PZDOo0uNQNG5Fyu6WUBPyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93797280"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93797280"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:05:22 -0700
X-CSE-ConnectionGUID: sx62xvKqSRSKgi2jqwvZLA==
X-CSE-MsgGUID: UV80oR3NQLeGn0SR42Hxfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="269600204"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:05:18 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 1/6] intel_iommu_accel: Guard VTDAccelPASIDCacheEntry
 definition
Date: Wed, 16 Sep 2026 18:04:36 +0800
Message-ID: <20260916100442.1034043-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260916100442.1034043-1-zhenzhong.duan@intel.com>
References: <20260916100442.1034043-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Move the VTDAccelPASIDCacheEntry typedef structure inside the
CONFIG_VTD_ACCEL ifdef block.

When CONFIG_VTD_ACCEL is disabled, this structure is entirely unused
throughout the code. Moving the layout under the existing preprocessor
guard prevents exposing dead type definitions and ensures the header
remains clean when building without VTD acceleration support.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu_accel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 4a9003c92d..46c1a29409 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -12,6 +12,7 @@
 #define HW_I386_INTEL_IOMMU_ACCEL_H
 #include CONFIG_DEVICES
 
+#ifdef CONFIG_VTD_ACCEL
 typedef struct VTDAccelPASIDCacheEntry {
     VTDHostIOMMUDevice *vtd_hiod;
     VTDPASIDEntry pasid_entry;
@@ -20,7 +21,6 @@ typedef struct VTDAccelPASIDCacheEntry {
     QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
 } VTDAccelPASIDCacheEntry;
 
-#ifdef CONFIG_VTD_ACCEL
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
 VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
-- 
2.52.0


