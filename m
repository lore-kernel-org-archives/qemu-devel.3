Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6A6C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H3H-0000Zo-1r; Tue, 07 May 2024 05:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2s-0000Nd-De
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:34 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2p-0000Bi-RN
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073811; x=1746609811;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oPF9tpE8nLZWTDT2z2eErDfE+ZYa4wqHG4lFnjm7wjk=;
 b=IjVGIKY5rtEOoO57w43xAqb78CYGans/7OpR2nzfth94137LnGrpoimA
 7ru8RQxKHsbenPYUTqXrdFR3P53ePC33NfoP15ojkyatwBsXk7IfmaKeK
 f5MMiARrrOVvWqc32Bl8+dtU2fGxCzTcf657IPcBwxNJhQ7ISeeIp3PtV
 gTH7NdIa95GnGZ6289DfQiVl+s26rUi9EHLgWQun2GqHjURSMq2KouvmM
 4sR5QBNUj1jZ4mBvbm7rfIv9/vt3w3Kow50j50KcNC/QcqsBF2GvtjJdv
 ObtgZOUiFCbaKBClSfuwIfC3agLEr9cwc1hkebWqhMwa6oXHpysLTmZMK w==;
X-CSE-ConnectionGUID: Fx8hay5pS3u+F+goZ7cZZQ==
X-CSE-MsgGUID: UMynPG11Q+qO0D6AO7LEGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785232"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785232"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:29 -0700
X-CSE-ConnectionGUID: XNeCBLOYRZCA3Ird0HGYfQ==
X-CSE-MsgGUID: Dd4s3J5aSt+3NZLrXCLJWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553330"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:26 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Date: Tue,  7 May 2024 17:20:31 +0800
Message-Id: <20240507092043.1172717-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
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

Utilize range_get_last_bit() to get host IOMMU address width and
package it in HostIOMMUDeviceCaps for query with .get_cap().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 1b4fc2f3e8..8ce38a4a01 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1134,6 +1134,33 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
 };
 
+static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
+                                     Error **errp)
+{
+    VFIODevice *vdev = opaque;
+    /* iova_ranges is a sorted list */
+    GList *l = g_list_last(vdev->bcontainer->iova_ranges);
+
+    /* There is no VFIO uAPI to query host platform IOMMU type */
+    hiod->caps.type = IOMMU_HW_INFO_TYPE_NONE;
+
+    if (l) {
+        Range *range = l->data;
+        hiod->caps.aw_bits = range_get_last_bit(range) + 1;
+    } else {
+        hiod->caps.aw_bits = 0xff;
+    }
+
+    return true;
+}
+
+static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
+{
+    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
+
+    hioc->realize = hiod_legacy_vfio_realize;
+};
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_LEGACY,
@@ -1142,6 +1169,7 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
         .parent = TYPE_HOST_IOMMU_DEVICE,
+        .class_init = hiod_legacy_vfio_class_init,
     }
 };
 
-- 
2.34.1


