Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52F6CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAVm-00059u-8H; Thu, 18 Sep 2025 05:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAVC-0004pM-03
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:00:39 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUz-0004rh-Ra
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758186018; x=1789722018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5aArkkeQfXXiaOg1+MuqtlNaHWQhDbD4d91svuiT+64=;
 b=kFXb1VuMANLJMaCL/yMno6ROgAzbyG04OOz7ncBChimLV4vYJO0UiDLD
 1p6uzQkX1r2Sga1zf7r4GiNvGm6jJ5CNtUmflYl2CZOrBT7JK8tuKMoEh
 W2Af7fM0ztzvheySDlUA1WAFvYOl9Rh/yzNkEOvzzs9LoMfqvfA45umgd
 uuVkcBzJ3aA8Nbo4MCqmJjzvqwXhhTRl2pDtMpz6aCWfSlEQ41X+y+Veh
 NeHdYPvSFnMvAjL82+k7v+GAkWoHWozxH6vS6jl69Elia0BlAo7H21iBX
 WBmYAjoaOZ+7KLxS8RoNrJM9NBKy6Dr854XP8uHMWDa9Sce/z4puja9VG A==;
X-CSE-ConnectionGUID: eIYt+28NQMuhPvqf0sO1bQ==
X-CSE-MsgGUID: m3/DDQutTMi6L8AnVTStAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109615"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109615"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 02:00:00 -0700
X-CSE-ConnectionGUID: MLyoMeKsRR++2mwBufE5lA==
X-CSE-MsgGUID: +t3Ipgc1TV6xnAbjYJoqeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930638"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:57 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 22/22] docs/devel: Add IOMMUFD nesting documentation
Date: Thu, 18 Sep 2025 04:58:01 -0400
Message-ID: <20250918085803.796942-23-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add documentation about using IOMMUFD backed VFIO device with intel_iommu with
x-flts=on.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 docs/devel/vfio-iommufd.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 3d1c11f175..d9cb9e7f5e 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -164,3 +164,27 @@ RAM discarding for mdev.
 
 ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
 devices are always mdev and RAM discarding is force enabled.
+
+Usage with intel_iommu with x-flts=on
+-------------------------------------
+
+Only IOMMUFD backed VFIO device is supported when intel_iommu is configured
+with x-flts=on, for legacy container backed VFIO device, below error shows:
+
+.. code-block:: none
+
+    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when x-flts=on
+
+VFIO device under PCI bridge is unsupported, use PCIE bridge if necessary,
+or else below error shows:
+
+.. code-block:: none
+
+    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device under PCI bridge is unsupported when x-flts=on
+
+If host IOMMU has ERRATA_772415_SPR17, kexec or reboot from "intel_iommu=on,sm_on"
+to "intel_iommu=on,sm_off" in guest is also unsupported. Configure scalable mode
+off as below if it's not needed by guest.
+
+.. code-block:: bash
+    -device intel-iommu,x-scalable-mode=off
-- 
2.47.1


