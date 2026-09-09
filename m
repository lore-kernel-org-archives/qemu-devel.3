Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D32AC79FAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Cjv-0004Hw-5y; Wed, 09 Sep 2026 03:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x4Cjt-0004HY-GI
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:29:01 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x4Cjs-0003gs-0N
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788938940; x=1820474940;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f12rT1oVsQxui4wfBXUQ2DFK71TtMXEqUn4sY43FYLI=;
 b=Bpr+7GKDoiTqT3+t0IJNMhY5fg5cM1pYeZvI3okTNFQnjtmg3Q9cHT/7
 SwokyoCtIHEf+SnB4tqdBQBrIWMpvnUl4VA58nqhuobS/BOVlVzfiNcEG
 HmZoWIOLXhdsh0+AnagAu2D8Nq4icITh7fCCoEbaYyzll6ApqgLjtQYXm
 1NkhTz4Ud7lawhCaoIF5Ddk5RBo9yXHA3yW46lD8P2F5MXz4lbBRbY24B
 wK7JKHlZS08MWG9Qe0c+vtHmPsNTFHZqnJ6W/ji0XuaR+V9CSBkIrHpeh
 jXIr29xY/dehZgv/VfqJmVBeMf23C0ETd/mwoAqiHu9oUq/1ISeTGFWWq A==;
X-CSE-ConnectionGUID: o/dbMQJzSuesWhKJgSPYxw==
X-CSE-MsgGUID: hXbTNufyQIO9FPld3JuhOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106723277"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="106723277"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 00:28:58 -0700
X-CSE-ConnectionGUID: 1RgFKynDTJCgMKXNUb0XDw==
X-CSE-MsgGUID: ocDLavK+S96jUIh87Z2ygg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="267982387"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 00:28:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 1/6] intel_iommu_accel: Guard VTDAccelPASIDCacheEntry
 definition
Date: Wed,  9 Sep 2026 15:28:32 +0800
Message-ID: <20260909072837.3183154-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260909072837.3183154-1-zhenzhong.duan@intel.com>
References: <20260909072837.3183154-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
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


