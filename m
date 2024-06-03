Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C3CC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0y3-0007PG-8K; Mon, 03 Jun 2024 02:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0y0-00077z-T2
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:48 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0xy-000150-Rh
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717395287; x=1748931287;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=81lbEn62SdS0xMymXpmsvHqz2eXRuM4ot4UU5tiF2us=;
 b=gMDzdCZwsqI9AQecRHeDSVx1Y48HLUIsb4pYQOc99CTtro9w8Eo0bFSG
 LStfdaCpTzcVC0UOIYxk4muVH/nSSz1tfjkCkZb3m0QbVmAbo4THd5H8T
 uAfi3n0+W9jBp95okr5pHLhGadKDpj4RREo4Ge6dGOY9Ou2wwLXPM4VGf
 hnbbfahWEHWONvsNJz3Tg4BDAg7jlw+0YtOVxwWBObhRENoTwhRGuCHYm
 uKLXy3/Fedb/FP54M28JG5+FUkXeUuQsk1JpnJmH/Ry5DvxvU+Hw6sQfu
 uMOTpBKDlrrgFJ5n2OuBB76SaseqV4IB4bZX9bDrYF4tQ/4/C7ZEi5bgW g==;
X-CSE-ConnectionGUID: kQP9QgiTQYqAMT5DxDHH2Q==
X-CSE-MsgGUID: 3y0lkIKUT4WOwvC8NU5UWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25277806"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="25277806"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:14:35 -0700
X-CSE-ConnectionGUID: 4X461FDtQ4eb5HlQBt2pMA==
X-CSE-MsgGUID: eylKjKwmSOmNeSdyyssdQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="36855993"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:14:31 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v6 19/19] intel_iommu: Check compatibility with host IOMMU
 capabilities
Date: Mon,  3 Jun 2024 14:10:23 +0800
Message-Id: <20240603061023.269738-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603061023.269738-1-zhenzhong.duan@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If check fails, host device (either VFIO or VDPA device) is not
compatible with current vIOMMU config and should not be passed to
guest.

Only aw_bits is checked for now, we don't care other capabilities
before scalable modern mode is introduced.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 747c988bc4..d8202a77dd 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3819,6 +3819,30 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static bool vtd_check_hdev(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+                           Error **errp)
+{
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    int ret;
+
+    if (!hiodc->get_cap) {
+        error_setg(errp, ".get_cap() not implemented");
+        return false;
+    }
+
+    /* Common checks */
+    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, errp);
+    if (ret < 0) {
+        return false;
+    }
+    if (s->aw_bits > ret) {
+        error_setg(errp, "aw-bits %d > host aw-bits %d", s->aw_bits, ret);
+        return false;
+    }
+
+    return true;
+}
+
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                      HostIOMMUDevice *hiod, Error **errp)
 {
@@ -3842,6 +3866,11 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return false;
     }
 
+    if (!vtd_check_hdev(s, hiod, errp)) {
+        vtd_iommu_unlock(s);
+        return false;
+    }
+
     vtd_hdev = g_malloc0(sizeof(VTDHostIOMMUDevice));
     vtd_hdev->bus = bus;
     vtd_hdev->devfn = (uint8_t)devfn;
-- 
2.34.1


