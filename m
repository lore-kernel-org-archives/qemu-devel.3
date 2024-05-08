Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED9CC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dHR-0000HW-1V; Wed, 08 May 2024 05:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dGz-0000An-3F
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:39 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dGx-0005S1-HG
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715159256; x=1746695256;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SFnso2XJZnjcpe6vQEbV6q0DMy+GxluEI4QwMoNhpTQ=;
 b=IZsTp8sgX/BIMlUn64Cp5OMruTnxTxud/0TCkAe+UwFUYxNao6OfeqLG
 YBvxmizA7sRjgaS63HL4gZ3cfVgCvsAzIuFVaqHHddpg3+4kl4TNAUAH5
 AwS+PTbo3c5GD2Ylv4FsxmZRwfdb+0m3FBaSkhxONG5LgjaSi2P4viQqZ
 zsjZol1xNo0SY1Im7m29al/mrgpYdag/oQ9PACiihZJP8e+XJ3/9fTv7l
 XwxvdGfLZtN26wjbfBmif+bWLiEjsN9hSefzuMM4leB0QKPmJmSQC06QN
 XJXaKSY750tIIlptYhvp5UMwl2EbGErlnIL0v8+ItLblnwKDYbaejnF1v g==;
X-CSE-ConnectionGUID: 2tQwEplhQt68MwlgOu1Eew==
X-CSE-MsgGUID: P7uH08dJRcqbQnKeKkI6gA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11160987"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="11160987"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:33 -0700
X-CSE-ConnectionGUID: Y6wEunqPR629wRriQzOtGg==
X-CSE-MsgGUID: /wpUKT9ZR525r6xNLULxFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="29226507"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:28 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v5 08/19] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
Date: Wed,  8 May 2024 17:03:43 +0800
Message-Id: <20240508090354.1815561-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Introduce a helper function iommufd_backend_get_device_info() to get
host IOMMU related information through iommufd uAPI.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h |  3 +++
 backends/iommufd.c       | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index f6e6d6e1f9..9edfec6045 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -47,6 +47,9 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size);
+bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
+                                     uint32_t *type, void *data, uint32_t len,
+                                     Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 012f18d8d8..c7e969d6f7 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -208,6 +208,28 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
     return ret;
 }
 
+bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
+                                     uint32_t *type, void *data, uint32_t len,
+                                     Error **errp)
+{
+    struct iommu_hw_info info = {
+        .size = sizeof(info),
+        .dev_id = devid,
+        .data_len = len,
+        .data_uptr = (uintptr_t)data,
+    };
+
+    if (ioctl(be->fd, IOMMU_GET_HW_INFO, &info)) {
+        error_setg_errno(errp, errno, "Failed to get hardware info");
+        return false;
+    }
+
+    g_assert(type);
+    *type = info.out_data_type;
+
+    return true;
+}
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_IOMMUFD_BACKEND,
-- 
2.34.1


