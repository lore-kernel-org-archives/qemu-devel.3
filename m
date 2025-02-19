Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4C4C021AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfPi-0005UU-7V; Wed, 19 Feb 2025 03:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPe-0005TY-5K
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:34 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPc-0004Za-43
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953592; x=1771489592;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yY0Gz0Q42ysq6vk2ZY5+LCBjvrX+hXo/OD6lHeKpxl0=;
 b=VZJ9YCfes6WCyzx2CIQ9AwzZhTULfIqEod3wzorwVfz05B5kVyDgt3BK
 /ioJZju35XK3MiJA/+ll7ZB14IL/Ebt9ftF+PV/WuP0JCBswPTsnJI/im
 2pnrGBdnHFZuCE96JYZyv4y41caTbrtPuITwFFRu6xND4oUN+uCKRxB3s
 oDhu99/q8PVrxyhkrLkxQR56eIKkD1O9jUfv6E/S8vEjtfGbos7QEiCs5
 BJNJVONl5l9kwJTFe7Bpd1qr3Ze2hW7qywxy2xYeVE0u6Ket4qjBvXQKH
 u7T3Ye1XHrIEgvJVHA1DHZwrvSLPZ/Bu4azA3tcV8738wx3AeTNRRU+Gl g==;
X-CSE-ConnectionGUID: hOMrjjKoSPKnJqht6Q969w==
X-CSE-MsgGUID: mLepFD5XS+26L6AZGEq/4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544110"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544110"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:32 -0800
X-CSE-ConnectionGUID: CwNuqpgnRyms8A2SBZhgyg==
X-CSE-MsgGUID: eKpwg1SZSeuGEnW4klmXKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851049"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:27 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 06/20] host_iommu_device: Define two new capabilities
 HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Date: Wed, 19 Feb 2025 16:22:14 +0800
Message-Id: <20250219082228.3303163-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/host_iommu_device.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index df782598f2..18f8b5e5cf 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -22,10 +22,16 @@
  *
  * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
  *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
+ *
+ * @nesting: nesting page table support.
+ *
+ * @fs1gp: first stage(a.k.a, Stage-1) 1GB huge page support.
  */
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint64_t hw_caps;
+    bool nesting;
+    bool fs1gp;
 } HostIOMMUDeviceCaps;
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
@@ -122,6 +128,8 @@ struct HostIOMMUDeviceClass {
  */
 #define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE        0
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
+#define HOST_IOMMU_DEVICE_CAP_NESTING           2
+#define HOST_IOMMU_DEVICE_CAP_FS1GP             3
 
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
 #endif
-- 
2.34.1


