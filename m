Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BAFCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvjR-0006zH-J5; Mon, 17 Nov 2025 04:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvig-0005o0-44
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:40:24 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvie-0006Kp-7i
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763372420; x=1794908420;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s8x4SQJsqM3hIZ73DiLwWQChJ2mlRt/MJGgdnOThySk=;
 b=PNHtgrgyWanr8skw3YaU40LSDOINyJLkChmTG095PclTw9y38cIU2Xtz
 JnYKrQ3Vyp34UlgQ3+EzpzjHXjdnzYU4EbJReWXBXQvpO2Bs+lC/qzA6J
 iYcRh2GOvWVcT/1U7ZkZ2f/9kJ8B36O7y84smaC/zIWR/KYpHN4lPKxm4
 9eWKDzvfc2/CxGlVlJRWPGzQ9tc/vcdtUNq/pkJzC5FsK2urnXhEpcca6
 op6JQyAHM9B2q/GiIFye71LKnwruhFFuohZ/moULjiVgNxsp8Wqh8yfc/
 J0eS9ZKkspiqBn6luvRMrvtbgtg6iFkyDfUisvcFhRLXpN6Xd1d08p9BZ Q==;
X-CSE-ConnectionGUID: ZcR/AkDmSa2sIY3iqm4lFQ==
X-CSE-MsgGUID: J95K7EoiT4G435SEltmNVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76046121"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="76046121"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:40:03 -0800
X-CSE-ConnectionGUID: D2ghcJ9iQnaxSeUxm0hfuQ==
X-CSE-MsgGUID: u3tAczwUTdC1t6TTk9eR/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190071021"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:59 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v8 23/23] docs/devel: Add IOMMUFD nesting documentation
Date: Mon, 17 Nov 2025 04:37:26 -0500
Message-ID: <20251117093729.1121324-24-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add documentation about using IOMMUFD backed VFIO device with intel_iommu with
x-flts=on.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 docs/devel/vfio-iommufd.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 3d1c11f175..474549903e 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -164,3 +164,28 @@ RAM discarding for mdev.
 
 ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
 devices are always mdev and RAM discarding is force enabled.
+
+Usage with intel_iommu featuring x-flts=on
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
+otherwise below error shows:
+
+.. code-block:: none
+
+    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when x-flts=on
+
+If host IOMMU has ERRATA_772415_SPR17, kexec or reboot from "intel_iommu=on,sm_on"
+to "intel_iommu=on,sm_off" in guest is also unsupported. Configure scalable mode
+off as below if it's not needed by guest.
+
+.. code-block:: bash
+
+    -device intel-iommu,x-scalable-mode=off
-- 
2.47.1


