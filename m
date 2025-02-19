Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591C4C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfQK-0005p5-8k; Wed, 19 Feb 2025 03:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQ9-0005YI-4D
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:07 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQ7-0004bS-4r
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953623; x=1771489623;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/zNkhlxkZ6uSup+2lkPM6XBkJH2cf5Y2mFnuhAqoLwo=;
 b=eE3hwck3rzNuafdqGDMlcMeUeUq6MZZvplDRDtT2l3frZ2m/PXqXnq/d
 HpI8f18OBXv7JfR1pLpUhfPaVVhkDNEfgPYJ8UmbdfZEvKgQe5XVMXqUj
 JZozWz1K2MUKzjGJJFmQYyJXOFGq1jXLU+zhFENaT359Kz94fE3SV9mcf
 BQ+BwvidBweLdboKeHW/U31lOTKLVgwb2a4W2ZdVzaqOhFIldw5QH7gpP
 IQKi1AYKdJmwfUiyrZH+mpT7DIWpctQAmSDXQHi28BDTy85a5FweiE/4w
 CUHwo3MjyueYyo2JIAZqjGLJnSK5yyDd/bSVQ87/xhK4cN+ckBFSfm0tY w==;
X-CSE-ConnectionGUID: VjVOKjHbTM+paTXydiInPg==
X-CSE-MsgGUID: 605OAERhRgWArYDo/gqQIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544193"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544193"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:02 -0800
X-CSE-ConnectionGUID: Ks7ePFmqQsCp7tne/7dLgA==
X-CSE-MsgGUID: 1cHVgyvfTvOyJ4Z5dxNU7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851224"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:57 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv2 12/20] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Date: Wed, 19 Feb 2025 16:22:20 +0800
Message-Id: <20250219082228.3303163-13-zhenzhong.duan@intel.com>
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

Introduce a new structure VTDHostIOMMUDevice which replaces
HostIOMMUDevice to be stored in hash table.

It includes a reference to HostIOMMUDevice and IntelIOMMUState,
also includes BDF information which will be used in future
patches.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  7 +++++++
 include/hw/i386/intel_iommu.h  |  2 +-
 hw/i386/intel_iommu.c          | 14 ++++++++++++--
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 2cda744786..18bc22fc72 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -28,6 +28,7 @@
 #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
 #define HW_I386_INTEL_IOMMU_INTERNAL_H
 #include "hw/i386/intel_iommu.h"
+#include "system/host_iommu_device.h"
 
 /*
  * Intel IOMMU register specification
@@ -608,4 +609,10 @@ typedef struct VTDRootEntry VTDRootEntry;
 /* Bits to decide the offset for each level */
 #define VTD_LEVEL_BITS           9
 
+typedef struct VTDHostIOMMUDevice {
+    IntelIOMMUState *iommu_state;
+    PCIBus *bus;
+    uint8_t devfn;
+    HostIOMMUDevice *hiod;
+} VTDHostIOMMUDevice;
 #endif
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index e95477e855..50f9b27a45 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -295,7 +295,7 @@ struct IntelIOMMUState {
     /* list of registered notifiers */
     QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
 
-    GHashTable *vtd_host_iommu_dev;             /* HostIOMMUDevice */
+    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice */
 
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9de60e607d..fafa199f52 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -281,7 +281,10 @@ static gboolean vtd_hiod_equal(gconstpointer v1, gconstpointer v2)
 
 static void vtd_hiod_destroy(gpointer v)
 {
-    object_unref(v);
+    VTDHostIOMMUDevice *vtd_hiod = v;
+
+    object_unref(vtd_hiod->hiod);
+    g_free(vtd_hiod);
 }
 
 static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
@@ -4388,6 +4391,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                      HostIOMMUDevice *hiod, Error **errp)
 {
     IntelIOMMUState *s = opaque;
+    VTDHostIOMMUDevice *vtd_hiod;
     struct vtd_as_key key = {
         .bus = bus,
         .devfn = devfn,
@@ -4404,6 +4408,12 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return false;
     }
 
+    vtd_hiod = g_malloc0(sizeof(VTDHostIOMMUDevice));
+    vtd_hiod->bus = bus;
+    vtd_hiod->devfn = (uint8_t)devfn;
+    vtd_hiod->iommu_state = s;
+    vtd_hiod->hiod = hiod;
+
     if (!vtd_check_hiod(s, hiod, errp)) {
         vtd_iommu_unlock(s);
         return false;
@@ -4414,7 +4424,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     new_key->devfn = devfn;
 
     object_ref(hiod);
-    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, hiod);
+    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hiod);
 
     vtd_iommu_unlock(s);
 
-- 
2.34.1


