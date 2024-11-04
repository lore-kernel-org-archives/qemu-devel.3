Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716D6D132BF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wg4-0005xG-5h; Mon, 04 Nov 2024 07:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7wg0-0005sN-Nw
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:59:24 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7wfy-0004jb-5I
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730725162; x=1762261162;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zEkYtParbiGwLGaNyENwRj8O0Cy0KesdfabNh1cNFbQ=;
 b=VSDV4OrIJaL+x/DZlLfu544aff7mWGBazqA8gTvS7JahrRv+xQvmu3ev
 xJA7DHLEdNhTfEmj+Mp4UbmXMVT28uBrGX59dpDGZyDN8+t0e5KuFOCSw
 TZJRcz+jfpM0G8TVzxwI4TiJF5hobVJHH5uyX/l0qw2p0SpDUNAY4gvFW
 iKMVUP+4kybD1xWr8Cq96WDWUydNr2JG8Clapr1F3MAqDeSP9fk+cErPh
 t5akBRML2bX4Xfe5Y5d21xCbdC1zM3M20FFqgLnQBPKAayEsSRIwZiYgZ
 VVuzJfJo7Z33oiACAwAZ2TSos7Yi+BOagxi57gUrfJCf+jC3v0qndGylh Q==;
X-CSE-ConnectionGUID: fVDTdWPgQRStji1kALvaLg==
X-CSE-MsgGUID: cXY4rvUkQ0ejkp7wPTxOwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41524689"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="41524689"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 04:59:20 -0800
X-CSE-ConnectionGUID: iKYPSkeUSJmjv5fwq7Tj8A==
X-CSE-MsgGUID: r4RXOAtvSAGJw0h09JMIeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; d="scan'208";a="84465252"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 04:59:13 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 3/3] intel_iommu: Add missed reserved bit check for IEC
 descriptor
Date: Mon,  4 Nov 2024 20:55:36 +0800
Message-Id: <20241104125536.1236118-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

IEC descriptor is 128-bit invalidation descriptor, must be padded with
128-bits of 0s in the upper bytes to create a 256-bit descriptor when
the invalidation queue is configured for 256-bit descriptors (IQA_REG.DW=1).

Fixes: 02a2cbc872df ("x86-iommu: introduce IEC notifiers")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 3 +++
 hw/i386/intel_iommu.c          | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 75ccd501b0..4323fc5d6d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -410,6 +410,9 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0f1f0
 
+/* Masks for Interrupt Entry Invalidate Descriptor */
+#define VTD_INV_DESC_IEC_RSVD           0xffff000007fff1e0ULL
+
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2fc3866433..4c0d1d7d47 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2692,6 +2692,14 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
                                      VTDInvDesc *inv_desc)
 {
+    uint64_t mask[4] = {VTD_INV_DESC_IEC_RSVD, VTD_INV_DESC_ALL_ONE,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
+                                     __func__, "iec inv")) {
+        return false;
+    }
+
     trace_vtd_inv_desc_iec(inv_desc->iec.granularity,
                            inv_desc->iec.index,
                            inv_desc->iec.index_mask);
-- 
2.34.1


