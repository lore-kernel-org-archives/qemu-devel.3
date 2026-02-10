Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B214AEA3F0F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vphlT-0004zF-0W; Tue, 10 Feb 2026 02:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vphlR-0004yb-On
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:02:25 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vphlP-0004p7-2x
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770706943; x=1802242943;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vLJ04mRE3eaGEiRhVGrnFwJ/UmQVbHxQHcqyM8xjArE=;
 b=KfteSpD8xW4YpB3Yaf1PnlYMF34fcgwTKk07abnSUMvJHoFPyMccnrf0
 t2D/k3GVQLJRe4bhCzOYaF6E3JsrUum7ubR/Kup0HKYfx9ox5Luhxj37B
 vJ0xl4Z9XBOHM0YvWWd6AMQ1znP/tAzU/8rvrSUJsuO+dVOfOoYDf1RIz
 hhxGk+d9lZ2zY3e3eDvht2P1jI0PbYI9mtSKOPHrcWZXzjKPzMIivvlVp
 pMNhlWsDcK5K4Wtx0OKWn+SlW8iolJ862PyvXc/hLFw4iI9f1wL8iJeH6
 RWQ3L7uHsa8mV+PS9ggdZyBav/FI9xmOpx11ddIFLFstqB9ryWExexJQA A==;
X-CSE-ConnectionGUID: vQYmOREFRwGGluTsiiG0LQ==
X-CSE-MsgGUID: XGpVyCSxR/O9COznWSa8rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="72012175"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="72012175"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:02:14 -0800
X-CSE-ConnectionGUID: 2XenC3MfQ5+bD6UCTJsb2g==
X-CSE-MsgGUID: Wto7QiFkT5C26FQDMpf+FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="210920550"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:02:14 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v6 07/11] vfio: Document vfio_device_get_region_info()
Date: Mon,  9 Feb 2026 22:59:47 -0800
Message-ID: <20260210070155.1176081-8-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
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

Add documentation for vfio_device_get_region_info() and clarify the
expectations around its usage.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/hw/vfio/vfio-device.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 35a5ec6d92..828a31c006 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -275,6 +275,19 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
 int vfio_device_get_feature(VFIODevice *vbasedev,
                             struct vfio_device_feature *feature);
 
+/**
+ * Return the region info for a given region index. The region info includes
+ * details such as size, offset, and capabilities. Note that the returned
+ * info pointer is either a cached copy or newly allocated by
+ * vfio_device_get_region_info(), so the caller is not expected to allocate
+ * or free it.
+ *
+ * @vbasedev: #VFIODevice to use
+ * @index: region index
+ * @info: pointer to store the region info
+ *
+ * Returns 0 on success or a negative value on error.
+ */
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
-- 
2.50.1


