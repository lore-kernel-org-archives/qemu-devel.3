Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401AEC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMN9-0008US-Lk; Thu, 18 Jul 2024 04:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMN5-0008AG-EX
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:16 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMN2-0008CX-Cd
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721290812; x=1752826812;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qRAdTmyScpl5VcqJj2d/dw/vJTmhAuAiH9g50qjU5XA=;
 b=V6jqdLF1/nN3NnJQhjfEeVB83EK/vlGxkWXavBCkIZJnGJhB6AU1oQZ7
 ocqVsZ7KrrsOG68kB+b+5TOwXLZ7vz98CtyTPiSoiwp5gPD+MVTyhg1Zf
 aUc0hwvr+OlTq5gtANLuCCRWgfNrG3OYmL1PRM/hwPoZ50M9cpZDZf3kr
 Qt8psLX0U13AO0RlXyPCyWbByazg0z84/mT6kgIPvcLSGzVxuaFgbJwOX
 HLOxqMksCX8encH/31myv2QeDjK1y7n9YH+ZVBA9o7teKoyD6s7Wp1M+c
 talPEls+Y17BFqnZ1FggjFBt3QbrZXUl9UdYjxzmhR8bMhMJoiIJiIcLJ w==;
X-CSE-ConnectionGUID: KPbFQV/VTmeooYZc33YISg==
X-CSE-MsgGUID: vDIVXzi0S8OtKKgT/fRwLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29996348"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="29996348"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:20:10 -0700
X-CSE-ConnectionGUID: h+KDg8LFQnyOCWs4bTTNyQ==
X-CSE-MsgGUID: P8+khh/SR5m4omxyJtxAVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="81717438"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:20:05 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v1 11/17] intel_iommu: Extract device IOTLB invalidation logic
Date: Thu, 18 Jul 2024 16:16:30 +0800
Message-Id: <20240718081636.879544-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718081636.879544-1-zhenzhong.duan@intel.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

This piece of code can be shared by both IOTLB invalidation and
PASID-based IOTLB invalidation

No functional changes intended.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 57 +++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8ebb6dbd7d..4d5a457f92 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2975,13 +2975,43 @@ static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
     return true;
 }
 
+static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
+                                     bool size, hwaddr addr)
+{
+    /*
+     * According to ATS spec table 2.4:
+     * S = 0, bits 15:12 = xxxx     range size: 4K
+     * S = 1, bits 15:12 = xxx0     range size: 8K
+     * S = 1, bits 15:12 = xx01     range size: 16K
+     * S = 1, bits 15:12 = x011     range size: 32K
+     * S = 1, bits 15:12 = 0111     range size: 64K
+     * ...
+     */
+
+    IOMMUTLBEvent event;
+    uint64_t sz;
+
+    if (size) {
+        sz = (VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT);
+        addr &= ~(sz - 1);
+    } else {
+        sz = VTD_PAGE_SIZE;
+    }
+
+    event.type = IOMMU_NOTIFIER_DEVIOTLB_UNMAP;
+    event.entry.target_as = &vtd_dev_as->as;
+    event.entry.addr_mask = sz - 1;
+    event.entry.iova = addr;
+    event.entry.perm = IOMMU_NONE;
+    event.entry.translated_addr = 0;
+    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
+}
+
 static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
                                           VTDInvDesc *inv_desc)
 {
     VTDAddressSpace *vtd_dev_as;
-    IOMMUTLBEvent event;
     hwaddr addr;
-    uint64_t sz;
     uint16_t sid;
     bool size;
 
@@ -3006,28 +3036,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
         goto done;
     }
 
-    /* According to ATS spec table 2.4:
-     * S = 0, bits 15:12 = xxxx     range size: 4K
-     * S = 1, bits 15:12 = xxx0     range size: 8K
-     * S = 1, bits 15:12 = xx01     range size: 16K
-     * S = 1, bits 15:12 = x011     range size: 32K
-     * S = 1, bits 15:12 = 0111     range size: 64K
-     * ...
-     */
-    if (size) {
-        sz = (VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT);
-        addr &= ~(sz - 1);
-    } else {
-        sz = VTD_PAGE_SIZE;
-    }
-
-    event.type = IOMMU_NOTIFIER_DEVIOTLB_UNMAP;
-    event.entry.target_as = &vtd_dev_as->as;
-    event.entry.addr_mask = sz - 1;
-    event.entry.iova = addr;
-    event.entry.perm = IOMMU_NONE;
-    event.entry.translated_addr = 0;
-    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
+    do_invalidate_device_tlb(vtd_dev_as, size, addr);
 
 done:
     return true;
-- 
2.34.1


