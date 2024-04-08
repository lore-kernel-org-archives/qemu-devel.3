Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F32CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkeE-0001YY-6p; Mon, 08 Apr 2024 04:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkeA-0001Uy-Fq
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:46:34 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtke8-0004JU-TR
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712565993; x=1744101993;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SVOOQW/4iGS4YIpTJ1tFxJpcyDFp/sXYdGw0LoN+Ndo=;
 b=G70fuCULs6YUM0W/E8R8YoEabNAme7nFdNiCHA3iKLWcj6vbc+ETDmc/
 lzwWxYMYCImYbk/HMOsvdhoFu1F/y7F+lxOnigtSG4+3NZAvnNAAtyqkP
 DM8IPSWcXbu3VQpK0aAKYFmesTZFJ0vx06I5hZHnYBBmiAgVaF0MBE1mq
 WPkGDgn6ZjQIerVFt1yK3kJ4Zq6PPliki/F2ZSYWskbwhaGwWcH08oejy
 /qtY33hZiuDesmQMvyBk0H+LICZd+qiB9Nx6Y3EoB8pQfqGA3ZRhjMpAC
 r62img1DSws68nGTNjIGku9LKXyacXfCCy+QCZlJ6W4Lgrsg0F+ESIdl/ A==;
X-CSE-ConnectionGUID: lJ0xyy9oTTyBnjW8gmk7ag==
X-CSE-MsgGUID: +oG4b3dDQ5yq8eBmSuvZkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19269461"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19269461"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:46:31 -0700
X-CSE-ConnectionGUID: 8MCdx/4ORGyyOwAGg0pKQQ==
X-CSE-MsgGUID: hVOcZct4SM2LGxFoF5nOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="42985891"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:46:26 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility check
 with host IOMMU cap/ecap
Date: Mon,  8 Apr 2024 16:44:02 +0800
Message-Id: <20240408084404.1111628-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
References: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

If check fails, the host side device(either vfio or vdpa device) should not
be passed to guest.

Implementation details for different backends will be in following patches.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4f84e2e801..a49b587c73 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/iommufd.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
@@ -3819,6 +3820,32 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static int vtd_check_legacy_hdev(IntelIOMMUState *s,
+                                 HostIOMMUDevice *hiod,
+                                 Error **errp)
+{
+    return 0;
+}
+
+static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
+                                  HostIOMMUDevice *hiod,
+                                  Error **errp)
+{
+    return 0;
+}
+
+static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
+                          Error **errp)
+{
+    HostIOMMUDevice *hiod = vtd_hdev->dev;
+
+    if (object_dynamic_cast(OBJECT(hiod), TYPE_HIOD_IOMMUFD)) {
+        return vtd_check_iommufd_hdev(s, hiod, errp);
+    }
+
+    return vtd_check_legacy_hdev(s, hiod, errp);
+}
+
 static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                     HostIOMMUDevice *hiod, Error **errp)
 {
@@ -3829,6 +3856,7 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         .devfn = devfn,
     };
     struct vtd_as_key *new_key;
+    int ret;
 
     assert(hiod);
 
@@ -3848,6 +3876,13 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hdev->iommu_state = s;
     vtd_hdev->dev = hiod;
 
+    ret = vtd_check_hdev(s, vtd_hdev, errp);
+    if (ret) {
+        g_free(vtd_hdev);
+        vtd_iommu_unlock(s);
+        return ret;
+    }
+
     new_key = g_malloc(sizeof(*new_key));
     new_key->bus = bus;
     new_key->devfn = devfn;
-- 
2.34.1


