Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12675C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkeJ-0001mi-L4; Mon, 08 Apr 2024 04:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkeI-0001mO-AC
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:46:42 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkeG-0004Mu-Gp
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712566000; x=1744102000;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aw0GBkJphOyAFSOv9qlsnjCA08x/RejUduRb0dkrZGs=;
 b=gSFlQh92f9lzL42e8lw7n8gWLj6kGtGjGf2gbGAABRs4rIZHCdIwafR8
 NzPNEUi2JyHna0lFNmn+SV8n0rlTGbuuNZM02fMzKMSO+qLvgdwiQV+Sz
 4hAVKTV/dXwxYf03wgEFgl0Wa1YY3+O8dc2jYqtvAiJidkWeLSrgNq4Kw
 R4J81C1+t1FEMFxCKkpe3/06qkTVw19a5TAIXb29AMdy/KnLDpOpMcJ1f
 evsPk/TsWi55XJyQt7PfrBkX65d7qOaKYGv+QP1BZ55CbHb7ZEMr0rFaM
 08WZ5kloZzw8fZoRFtmmHVsdkKJgm6b4/AcJGrqwgjKEl3FFDlGpzzJm7 A==;
X-CSE-ConnectionGUID: rLhl1475QCCnYnrWDoO3Zg==
X-CSE-MsgGUID: uJskxyaLRReVvKKarkumpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19269481"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19269481"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:46:39 -0700
X-CSE-ConnectionGUID: Qtls9I3LQyCPkvskx4I48A==
X-CSE-MsgGUID: EVP2VpNIQ3mU7E3L7eGz9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="42985904"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:46:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 5/5] intel_iommu: Check for compatibility with iommufd
 backed device
Date: Mon,  8 Apr 2024 16:44:04 +0800
Message-Id: <20240408084404.1111628-6-zhenzhong.duan@intel.com>
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

Currently only stage-2 translation is supported which is backed by
shadow page table on host side. So we don't need exact matching of
each bit of cap/ecap between vIOMMU and host. However, we can still
ensure compatibility of host and vIOMMU's address width at least,
i.e., vIOMMU's aw-bits <= host IOMMU aw-bits, which is missed before.

When stage-1 translation is supported in future, a.k.a. scalable
modern mode, this mechanism will be further extended to check more
bits.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/i386/intel_iommu.c         | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index bbc7b96add..2bbde41e45 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -47,6 +47,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
 #define VTD_HOST_AW_48BIT           48
 #define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
 #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
+#define VTD_MGAW_FROM_CAP(cap)      ((cap >> 16) & 0x3fULL)
 
 #define DMAR_REPORT_F_INTR          (1)
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d2cd186df0..d8fac9ef9f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3846,6 +3846,29 @@ static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
                                   HostIOMMUDevice *hiod,
                                   Error **errp)
 {
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    struct iommu_hw_info_vtd *vtd;
+    HIOD_IOMMUFD_INFO info;
+    int host_aw_bits, ret;
+
+    ret = hiodc->get_host_iommu_info(hiod, &info, sizeof(info), errp);
+    if (ret) {
+        return ret;
+    }
+
+    if (info.type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
+        error_setg(errp, "IOMMU hardware is not compatible");
+        return -EINVAL;
+    }
+
+    vtd = &info.data.vtd;
+    host_aw_bits = VTD_MGAW_FROM_CAP(vtd->cap_reg) + 1;
+    if (s->aw_bits > host_aw_bits) {
+        error_setg(errp, "aw-bits %d > host aw-bits %d",
+                   s->aw_bits, host_aw_bits);
+        return -EINVAL;
+    }
+
     return 0;
 }
 
-- 
2.34.1


