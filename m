Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F6AEA795B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpn7-00053Q-Ft; Wed, 04 Feb 2026 22:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpn5-00053A-Pg
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:12:23 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpn4-0001ug-1S
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770261142; x=1801797142;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kQwPUXHBESbKgby107KY4wXFzIf0n4iCnj9Jt6Vi3kk=;
 b=AeX1qOgVAxrzCgFGQkGNBiztmqgjEqoawL0p50sBQUFWl65xGqlE9Xxx
 zcka3GZPgtDm+jwLGrGyi7fOD86RWZP7IBG6+GdB7Vq1KowaAN3fM3cz1
 qB4D1peM3FDtskztBvrkVbQ3vJU/11zEzhKELD2d/bQBEv63TwKH9v0Sl
 nZLM21Wz7gTnK0QsYmRXqOz/wku3vNcOu4dKVIL3Bg8tGcofgELLEC/qS
 /rrS6EY6rggbKVBnqTHldtTJqzbZKl2D4zPMNiFjaPs6MbVqXzcAM0e0h
 Qt5d43Jvcg5MyEgIwZ86GAz1WLPrDE4WpvuuroKNJ0XfiJSyTfr6NUzQ+ g==;
X-CSE-ConnectionGUID: 5Hc0vUHsQj6dDuSvTZ7L5A==
X-CSE-MsgGUID: sNwBFHv7QJyim6ORFDtupQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96910419"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="96910419"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:12:20 -0800
X-CSE-ConnectionGUID: 7Nt1QztHSUu1NgRVH/rHmg==
X-CSE-MsgGUID: aQi5WADhSX2k/UlspblVug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="209651972"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:12:16 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach callbacks
Date: Wed,  4 Feb 2026 22:11:19 -0500
Message-ID: <20260205031133.74357-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205031133.74357-1-zhenzhong.duan@intel.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
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

Add two wrappers host_iommu_device_iommufd_pasid_[at|de]tach_hwpt to
wrap the two callbacks.

Use assert to ensure the corresponding callbacks exist.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/iommufd.h | 40 ++++++++++++++++++++++++++++++++++++++++
 backends/iommufd.c       | 23 +++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 80d72469a9..615be10aed 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -145,10 +145,50 @@ struct HostIOMMUDeviceIOMMUFDClass {
      * Returns: true on success, false on failure.
      */
     bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
+    /**
+     * @attach_hwpt: attach host IOMMU device's pasid to IOMMUFD hardware page
+     * table. VFIO and VDPA device can have different implementation.
+     *
+     * Mandatory callback.
+     *
+     * @idev: host IOMMU device backed by IOMMUFD backend.
+     *
+     * @pasid: pasid of host IOMMU device.
+     *
+     * @hwpt_id: ID of IOMMUFD hardware page table.
+     *
+     * @errp: pass an Error out when attachment fails.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*pasid_attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t pasid,
+                              uint32_t hwpt_id, Error **errp);
+    /**
+     * @detach_hwpt: detach host IOMMU device's from IOMMUFD hardware page
+     * table. VFIO and VDPA device can have different implementation.
+     *
+     * Mandatory callback.
+     *
+     * @idev: host IOMMU device backed by IOMMUFD backend.
+     *
+     * @pasid: pasid of host IOMMU device.
+     *
+     * @errp: pass an Error out when attachment fails.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*pasid_detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t pasid,
+                              Error **errp);
 };
 
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp);
 bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            Error **errp);
+bool host_iommu_device_iommufd_pasid_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                                 uint32_t pasid,
+                                                 uint32_t hwpt_id,
+                                                 Error **errp);
+bool host_iommu_device_iommufd_pasid_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                                 uint32_t pasid, Error **errp);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 13822df82f..93d3612471 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -539,6 +539,29 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     }
 }
 
+bool host_iommu_device_iommufd_pasid_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                                 uint32_t pasid,
+                                                 uint32_t hwpt_id,
+                                                 Error **errp)
+{
+    HostIOMMUDeviceIOMMUFDClass *idevc =
+        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
+
+    g_assert(idevc->pasid_attach_hwpt);
+    return idevc->pasid_attach_hwpt(idev, pasid, hwpt_id, errp);
+}
+
+bool host_iommu_device_iommufd_pasid_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                                 uint32_t pasid,
+                                                 Error **errp)
+{
+    HostIOMMUDeviceIOMMUFDClass *idevc =
+        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
+
+    g_assert(idevc->pasid_detach_hwpt);
+    return idevc->pasid_detach_hwpt(idev, pasid, errp);
+}
+
 static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
                                         PasidInfo *pasid_info)
 {
-- 
2.47.3


