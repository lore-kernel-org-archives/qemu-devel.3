Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFC5C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dHV-00015S-Q3; Wed, 08 May 2024 05:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dHG-0000E4-AO
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:55 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dH9-0005UG-0E
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715159267; x=1746695267;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r2PRuTeAulGK2h55QuvDIkzfGoc3c4Qtcfz0sVeJKh4=;
 b=AZkQb6VIkbbH9UD0vS/pOo1Iw43u+r4EFDk5P8U3rJO9TUDmGidKFhnT
 GoWRkmH+Eon335ABHeDwk+XdpIr91VJiK43dlYfu972ZLr3eIMlUCdkGn
 uUPQaBZjyIa9LM4cAZNQ2+Wesy7P98ErIaKqp0sKkEB/9ugWOCoHS5LEY
 bh14EOUPe+0YjyY4SnelecbsDVcXPBbXI6nALIDcNTDOly1WZz2yBSd9G
 2kGvZRVzRYq0cotXECB1azs4YtB3NtuqXJdJJ64zJXDpRYOm2uplaATNi
 9Y84DGHawY37Oim78nAk8gmQ0Q9uWJC1gzKuhGbIZZL6G5EDaoDhCXn/3 Q==;
X-CSE-ConnectionGUID: 44I1UvvKQcCUKFBqy0mlVA==
X-CSE-MsgGUID: +w7OUugQR7KSowsLeuiEbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11161013"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="11161013"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:41 -0700
X-CSE-ConnectionGUID: fhqq7hh7R12gTwX2q3wFYQ==
X-CSE-MsgGUID: uo8h+1FkRLKEJw/D8GobHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="29226545"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:37 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 10/19] vfio/container: Implement
 HostIOMMUDeviceClass::get_cap() handler
Date: Wed,  8 May 2024 17:03:45 +0800
Message-Id: <20240508090354.1815561-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index b872f6f201..c9c5347da9 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1152,11 +1152,26 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     return true;
 }
 
+static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
+                                    Error **errp)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    switch (cap) {
+    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
+        return caps->aw_bits;
+    default:
+        error_setg(errp, "Not support get cap %x", cap);
+        return -EINVAL;
+    }
+}
+
 static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
 {
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hioc->realize = hiod_legacy_vfio_realize;
+    hioc->get_cap = hiod_legacy_vfio_get_cap;
 };
 
 static const TypeInfo types[] = {
-- 
2.34.1


