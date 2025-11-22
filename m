Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5E2CFC50C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 07:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMiKl-0008Fw-RB; Sat, 22 Nov 2025 02:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vMhTk-0000gN-R0
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 01:52:23 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vMhTN-0000qe-LE
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 01:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763794313; x=1795330313;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Upq2JY7yf0Ys2TZJHDdbUd1IroM2T22AHjG73dw2axg=;
 b=hTvILl+OcEQmMgPbob8C7E9jzu9uKCTL171OhUf4igCDqUMNrjoAKPrv
 oNrqKi5BH5ooJvaZDNi8348JUBXx0dOCURKOIkbNSyyGmlqjbZY9XNIoZ
 fiOHIineYnw5nxBf9sCNO+MAkUOBPFTZfYo7hBa5I/9s1rbFKo6uwBlRX
 MEFCBSrVeVeCAuQKMwbbM98p5jsUzCy0cKoL/kXu1OIs3aqoE5rvnP4Ek
 NeK/3Q7d0kvgZS4Budh4ny8xT8KaD03mZIgzDVe8dnFVgnmFZv0Bt8lG3
 q994GVkmg834bYy9CuqwFIcv3z9LK7eyjD+q9ccj8PPGNVQfg3nyNIYCF w==;
X-CSE-ConnectionGUID: /APFKRm+T4+SGcnMeRRlew==
X-CSE-MsgGUID: ZuzzI3T9Rce2jXkIurom/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65924069"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; d="scan'208";a="65924069"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 22:50:22 -0800
X-CSE-ConnectionGUID: Ml6EIHS3R2e/NRoXnyyfgQ==
X-CSE-MsgGUID: bSPxbtQ2QLSZDAups5WFxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; d="scan'208";a="191064608"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 22:50:22 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 3/9] vfio: Document vfio_device_get_region_info()
Date: Fri, 21 Nov 2025 22:46:24 -0800
Message-ID: <20251122064936.2948632-4-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
References: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Add documentation for vfio_device_get_region_info() and clarify the
expectations around its usage.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/hw/vfio/vfio-device.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 0fe6c60ba2..bb28123faf 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -257,6 +257,19 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
 
 void vfio_device_unprepare(VFIODevice *vbasedev);
 
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


