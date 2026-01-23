Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62246D6CFDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAYk-0003AG-QB; Fri, 23 Jan 2026 01:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYi-000397-V1
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:16 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYh-0000rq-5X
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769149335; x=1800685335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=euo1uQzGYAUaN3wijSuUW/9xkovcGHGFmf0Ishxos5A=;
 b=IYkwDtfjyS0dszTdNZSUOa5hex5InaSMuxd3KygNcvbB/e73NwD/oo2j
 z6iKgogJ6C5OZ/IaJdqPILmNcOQDIc91B4H1ukVmUq0Dsf8wmugCKVmhm
 IH9TylQG47zEyNcJugJSG62WVBmcX192Agyy8qYNj9rnpc2M237sKpfff
 hQhdhB3u/BsDnqGkmAumGYtWZNf7wfZvgWCdLm8cZMVzEW+VwMUEsHqxp
 pEMDA7Fw/xOTNNFxuMQP8iuo779zb/DCHE9lrBbbpAciv7LIRgO7LlRyL
 8S8K0NvGhwj3Ti5ahTsNjTOr4pU3ctxlwYxySisZe1B8lI+mho8I2ymHA A==;
X-CSE-ConnectionGUID: YhhtwwHmQHOjnivZmy3Mxg==
X-CSE-MsgGUID: UjC0aWzUTDmTmDb75WR4OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74254194"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="74254194"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:06 -0800
X-CSE-ConnectionGUID: ovjVwv9cQS6fQ83seOwfoA==
X-CSE-MsgGUID: uy27e5PISHSqvZ0wKDP1Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="207287406"
Received: from unknown (HELO vkasired-desk2.fm.intel.com) ([10.105.128.132])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:04 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 3/8] vfio: Document vfio_device_get_region_info()
Date: Thu, 22 Jan 2026 22:17:42 -0800
Message-ID: <20260123062042.568703-4-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260123062042.568703-1-vivek.kasireddy@intel.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


