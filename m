Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C78D2E9C4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPxh-0006iK-0M; Mon, 11 Nov 2024 03:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPxC-0005lS-WD
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:23 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPx9-0003Y3-AB
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314359; x=1762850359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K5VQK9DXit/Q2BgeJNvVZGy9EWoDq9oAnvGuNS/lNRU=;
 b=jFughkIOm1oFUWMHKbVwGV3dzMTqTjRFIl8NtzKOGaNwcNjjk4wP8OKp
 h//kr1pHCzzoHTxdXh9egkH56E1U+ihOFx2NWaQ33r2oteriRHUtnInFg
 MufEsu18nqxvotc+gutbiXtOlbNCYlMXHrdHT0Vnda/Onc2ER7GEk1gcN
 q52gJnqKp5+uCiUACMQwwtufnXecPgDIYyMiRov5hRdHSH6CKGSXYniF8
 texxWwedkGcKe69MlB38X2Z+5AOh/UNQqVALME+pmaffw5H/Dqtw2C0mJ
 J03/M3IwV4FTYoLa8HmM/PvxiNh2rNZQ9DRKBuD1Kaayq6s8uEW6EoEss Q==;
X-CSE-ConnectionGUID: xyd+ZVkwTE2qBx/O9AkBhA==
X-CSE-MsgGUID: foxPx15CQXG2vh2RzGaOQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334555"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334555"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:39:18 -0800
X-CSE-ConnectionGUID: HLHUSSsRQhu2ycw/w8O+/Q==
X-CSE-MsgGUID: c3h90MKGTra3DXFwdjBm2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608412"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:39:14 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 16/20] intel_iommu: Set default aw_bits to 48 starting from
 QEMU 9.2
Date: Mon, 11 Nov 2024 16:34:53 +0800
Message-Id: <20241111083457.2090664-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

According to VTD spec, stage-1 page table could support 4-level and
5-level paging.

However, 5-level paging translation emulation is unsupported yet.
That means the only supported value for aw_bits is 48. So default
aw_bits to 48 in scalable modern mode.

For legacy and scalable legacy modes, 48 is the default choice for
modern OS when both 48 and 39 are supported. So it makes sense to
set default to 48 for these two modes too starting from QEMU 9.2.
Use pc_compat_9_1 to handle the compatibility for machines before
9.2.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 include/hw/i386/intel_iommu.h | 2 +-
 hw/i386/pc.c                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 13e8680b87..09ce707930 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
 #define DMAR_REG_SIZE               0x230
 #define VTD_HOST_AW_39BIT           39
 #define VTD_HOST_AW_48BIT           48
-#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
+#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_48BIT
 #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
 
 #define DMAR_REPORT_F_INTR          (1)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 830614d930..bdb67f1fd4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -83,6 +83,7 @@ GlobalProperty pc_compat_9_1[] = {
     { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
     { "ICH9-LPC", "x-smi-periodic-timer", "off" },
     { TYPE_INTEL_IOMMU_DEVICE, "stale-tm", "on" },
+    { TYPE_INTEL_IOMMU_DEVICE, "aw-bits", "39" },
 };
 const size_t pc_compat_9_1_len = G_N_ELEMENTS(pc_compat_9_1);
 
-- 
2.34.1


