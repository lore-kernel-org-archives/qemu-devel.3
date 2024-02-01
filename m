Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECD6C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRWq-0005Dj-GN; Thu, 01 Feb 2024 02:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRWo-0005Cw-NB
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:31 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRWh-0001Up-Fh
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772623; x=1738308623;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Lhqz2iRToADp66tcHjAaagZoKGFICWwlIhQ9qtn5y64=;
 b=gt6gb1x4LBgYXrwMXz22NDrugrqP7U9FBNj6Cj4cbiq3PYxaCaPn3GCh
 15RkxdDskKmd/CykYAkOj4dL6O6+emRsYOdM+WwqBta5KvWdNScz+KB31
 EbvJbUC6FeOnbjFwB1FeON3pvIOlHHSo3jNc1VzpI4fVB3si6I1dJHR2O
 kgAg9986uJ6q3Ih9v2GrDOgptyT3zOYWBgcqGsn5PUO55zRHR9b/66ANO
 ouB4AULwWyuIxcfWjD6QwpiGwHorldD2DHR4Cc6zr4bxwxEaAtE1PjTZA
 HfTnRoiqMqTUMgdB9VDhWJgv3C0hdTmXcK+dIsiGpFDRgpdNvDqnBgRTu A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676610"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676610"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443140"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:18 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 01/18] Introduce a common abstract struct HostIOMMUDevice
Date: Thu,  1 Feb 2024 15:28:01 +0800
Message-Id: <20240201072818.327930-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201072818.327930-1-zhenzhong.duan@intel.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

HostIOMMUDevice will be inherited by two sub classes,
legacy and iommufd currently.

Introduce a helper function host_iommu_base_device_init to initialize it.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/host_iommu_device.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 include/sysemu/host_iommu_device.h

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
new file mode 100644
index 0000000000..fe80ab25fb
--- /dev/null
+++ b/include/sysemu/host_iommu_device.h
@@ -0,0 +1,22 @@
+#ifndef HOST_IOMMU_DEVICE_H
+#define HOST_IOMMU_DEVICE_H
+
+typedef enum HostIOMMUDevice_Type {
+    HID_LEGACY,
+    HID_IOMMUFD,
+    HID_MAX,
+} HostIOMMUDevice_Type;
+
+typedef struct HostIOMMUDevice {
+    HostIOMMUDevice_Type type;
+    size_t size;
+} HostIOMMUDevice;
+
+static inline void host_iommu_base_device_init(HostIOMMUDevice *dev,
+                                               HostIOMMUDevice_Type type,
+                                               size_t size)
+{
+    dev->type = type;
+    dev->size = size;
+}
+#endif
-- 
2.34.1


