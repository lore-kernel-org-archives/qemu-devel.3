Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64D8E8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAu4-0007N0-VQ; Tue, 03 Feb 2026 02:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAu0-0007Eo-OM
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:49 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAtx-00067a-2C
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770103965; x=1801639965;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vLJ04mRE3eaGEiRhVGrnFwJ/UmQVbHxQHcqyM8xjArE=;
 b=Bg4bvUpuCOhoe1Iw085t2BPT35QzYaAeQGDBgYDd9lSaT10z60RotGE1
 NnoSR+3o82K+/X2WhcPy93lfkSoVGWNSRpWjZbuZ+A8qSoutZBseKpCVe
 S/2UixW42VpV2XCWSffX7+f55GXbQexxa019w77aG5cShh20ukKy1D9NI
 HSdHgEPCt0KXsjHmLXxWvMCA2EcBOsozxWq3WA226hUMrbxidITK3kffk
 KYPrAE5bsBniYbiGmUnuDIn+5X7xdQTY0rddMZwqO0vxDkwkXt5qddHdL
 45yXg0kQDqYxRMipsUwLOM8gzZ9baKM+/YONk0kmKx/w2zpPIbKfDHs5s A==;
X-CSE-ConnectionGUID: 94DCVQo+Q063JSBoD/N/8A==
X-CSE-MsgGUID: 2yBdS4rATKasqif0V6b1qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82640910"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="82640910"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 23:32:36 -0800
X-CSE-ConnectionGUID: Dp2X0oMYS9qOiE4wKVfl4g==
X-CSE-MsgGUID: Qxozh33DRWaJa4g+WNK8qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="247373105"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 23:32:36 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 07/12] vfio: Document vfio_device_get_region_info()
Date: Mon,  2 Feb 2026 23:30:14 -0800
Message-ID: <20260203073200.848183-8-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203073200.848183-1-vivek.kasireddy@intel.com>
References: <20260203073200.848183-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
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


