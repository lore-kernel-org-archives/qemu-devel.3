Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8706CC61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymMw-0001ks-5d; Tue, 25 Aug 2026 04:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wymMu-0001kG-73
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:18:52 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wymMs-0002Qo-Dr
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787645930; x=1819181930;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PV4ntmjn2kuXPjfRYqbyIsNTDoaH6VY2OCIQhHzmeM0=;
 b=aEgAYV+GJ9vugOkyeX5U9ZTqFG7/TPhApz7SXCJfjxT0xQ+C9TgUtlmP
 HeFuryJ5IyfrC88Z12mDQMLCS9w0ftk6AsA8bQlftHSncTXXMTyH/KM6M
 Ar9jctJHkNzE5dH2yqU1Cg5uEaq2ot5q4EMFzZqIf7RVVoZBVbKmS/Vmj
 prCtsx+Qje6vW2m4O5+k99fYYq/G0oPrEFWPjQt2mfU23Zw3lEggzh5rU
 YSHXNgaRZWuwPlEOH6isYmiPQKB5imx+P4UfNWrEGvcuKXZvNQqBN1IM/
 hhGiUaGe47QVsdZi75y46ZTLpGce1xTV7tbbvfO4AmHPKur44mifAzBCl Q==;
X-CSE-ConnectionGUID: RdlbbkHDQAqxUGUhgb0rOQ==
X-CSE-MsgGUID: LfoZp+/jRRyt/+dRpByhhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87967063"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="87967063"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 01:18:46 -0700
X-CSE-ConnectionGUID: CQPl3Pq/QYiPEgyH/UjY6g==
X-CSE-MsgGUID: MalD89JXRfunOttCH7XD1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="265905296"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 01:18:43 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 1/6] intel_iommu_accel: Guard VTDAccelPASIDCacheEntry
 definition
Date: Tue, 25 Aug 2026 16:18:08 +0800
Message-ID: <20260825081814.138140-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260825081814.138140-1-zhenzhong.duan@intel.com>
References: <20260825081814.138140-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
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


