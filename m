Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311E5C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 09:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uggXk-0006zq-DS; Tue, 29 Jul 2025 05:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggXL-0005e6-G2
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:22:20 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggXE-0002ht-Q8
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753780933; x=1785316933;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FlImJH6dGvK7D/htR7NMlyNpAmi2q1y4plaA7B11fR0=;
 b=CfA7uC+wkj1m6HMVA+9ynOMlBUIQWcf4/d1NEsJKVgB38G/jFU4yMxde
 Idtsmgg6JjAmSVYG/j6xDdFp4bjmmMMiHGjLUpD/VNmtsNviLSflNIdbX
 nnIp9Sq4wAwMwQXcGXzgVVCmRDh2tRf5FiVnWyWCDLeaNBVzhnUFYzx5h
 q5/wG1cAsf0xSbXIAvqKzSTVfq8zwkz62ypAEYJAagK3XcL4+QvWnXTz2
 k81NheJZKFtmaX/AknkxH1iJLd5jRWS6a5/9dKba57PqBZkj9QRVApzIl
 NIK3rpr0MiDF8I3P3PztT46Y6L32w8funanP1pdSvGvnqCNfTCSNpJLkQ Q==;
X-CSE-ConnectionGUID: DUqrFQ9QRMOBKRYCcsAN/A==
X-CSE-MsgGUID: 1KkJi0bMTKOJrLJAQTKsSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55981962"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55981962"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:22:08 -0700
X-CSE-ConnectionGUID: NFWFGEx2RayJtpwWhb6kGg==
X-CSE-MsgGUID: o7ulHm4FRS+VlXT6aDpBTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162691426"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:53 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 13/20] intel_iommu: Stick to system MR for IOMMUFD backed
 host device when x-fls=on
Date: Tue, 29 Jul 2025 05:20:35 -0400
Message-ID: <20250729092043.785836-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250729092043.785836-1-zhenzhong.duan@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
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

When guest in scalable mode and x-flts=on, we stick to system MR for IOMMUFD
backed host device. Then its default hwpt contains GPA->HPA mappings which is
used directly if PGTT=PT and used as nested parent if PGTT=FLT. Otherwise
fallback to original processing.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2d8588d9fe..7c41fd76a8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1773,6 +1773,28 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
 
 }
 
+static VTDHostIOMMUDevice *vtd_find_hiod_iommufd(IntelIOMMUState *s,
+                                                 VTDAddressSpace *as)
+{
+    struct vtd_as_key key = {
+        .bus = as->bus,
+        .devfn = as->devfn,
+    };
+    VTDHostIOMMUDevice *vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev,
+                                                       &key);
+
+    if (vtd_hiod && vtd_hiod->hiod &&
+        object_dynamic_cast(OBJECT(vtd_hiod->hiod),
+                            TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+        return vtd_hiod;
+    }
+    return NULL;
+}
+
+/*
+ * vtd_switch_address_space() calls vtd_as_pt_enabled() to determine which
+ * MR to switch to. Switch to system MR if return true, iommu MR otherwise.
+ */
 static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 {
     IntelIOMMUState *s;
@@ -1781,6 +1803,18 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
     assert(as);
 
     s = as->iommu_state;
+
+    /*
+     * When guest in scalable mode and x-flts=on, we stick to system MR
+     * for IOMMUFD backed host device. Then its default hwpt contains
+     * GPA->HPA mappings which is used directly if PGTT=PT and used as
+     * nested parent if PGTT=FLT. Otherwise fallback to original
+     * processing.
+     */
+    if (s->root_scalable && s->flts && vtd_find_hiod_iommufd(s, as)) {
+        return true;
+    }
+
     if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
                                  &ce)) {
         /*
-- 
2.47.1


