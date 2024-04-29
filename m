Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15FFC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Kte-0001gY-Ml; Mon, 29 Apr 2024 02:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ktb-0001dI-Eu
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:51 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KtZ-0007m1-O1
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373630; x=1745909630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NFWgWR9YnAEFIvmqqZLW+W43YEg9BvLa/GWEg1Hyw6s=;
 b=ORbQ5TIdq/8u3P3enpSf8OWuPezNJvQ6SqIsTue2o59w1l/AT2LEyeXm
 ICdfE/S/Qh63vsnuW6dLJrN04QJiHBxlwssQf9YoBCRIRlzATJLCl/dyX
 Uf1eaft2v1fcB+/IGjSnZojF2UHdEUfmTxP6sW5vXQ7KaDDQYVKi69agK
 2UILPiED04nEgq3iRxSuT4ypyjp+b6tadZimqahVHx1KJClNvri6rVXDp
 McHNxbUK7LlzRlGdD8UKFAP2qj2eVY7XRCNArci8h+Vri6rfD08A1EnG9
 o7xViejybYA1RH98i2PXkjVPUrs+JYL/4yL1BgYDvLSzG7rMjvCogOHxt w==;
X-CSE-ConnectionGUID: gEZrxkBbSS+Rz0LtVk4cEQ==
X-CSE-MsgGUID: HlU9Xy3JQDu3y/nfszYW8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560700"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:49 -0700
X-CSE-ConnectionGUID: fgFjUV+qRLCaazhJcqB/eQ==
X-CSE-MsgGUID: Yvcyv6HLSUamb+rjbDI8hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488034"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:46 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Date: Mon, 29 Apr 2024 14:50:34 +0800
Message-Id: <20240429065046.3688701-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
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
package it in HostIOMMUDeviceCaps for query with .check_cap().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3b6826996a..863eec3943 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1143,6 +1143,34 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
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
+    HOST_IOMMU_DEVICE_IOMMUFD_VFIO(hiod)->vdev = vdev;
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
@@ -1152,6 +1180,7 @@ static const TypeInfo types[] = {
         .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
         .parent = TYPE_HOST_IOMMU_DEVICE,
         .instance_size = sizeof(HostIOMMUDeviceLegacyVFIO),
+        .class_init = hiod_legacy_vfio_class_init,
     }
 };
 
-- 
2.34.1


