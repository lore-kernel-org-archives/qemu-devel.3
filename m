Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F4ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 07:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Igs-00023K-1Z; Thu, 16 Oct 2025 03:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9Igl-00020H-09
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 03:46:20 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9Igc-0005Qi-Ts
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 03:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760600771; x=1792136771;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bA8t54hmyOaKWvPIa5ryAAWfrj0DtTxYHS6rZ6SFEnw=;
 b=RIJbLvgiWQ9Of1v3nU/jFoganZVP9O8gmAfDw8DD8fQT5mXg8bFDeIM7
 AJpgWonrrO0MfvI2QQOLD91LAsdbgRvoIq7p3zlieqTe0czEPDG6byfEv
 WNyfvttHqaQcdEahPJnV3AgEenkoMDAflNp+K6v3EweZhPZM9KNV1ILy2
 Jq+1ib8mK/ZiNp3FGL+qgVmv4t50sET0m/ZH2QXYtNjgK0JLkZ/ROXBTA
 G15iZNW6LJ7GNMNXOwOc8qTzNvFx9iW325rBiVeizuYeNZtYo1IfjjFLB
 Za4Zk/JItMzWlIPHJyacZ01GRU4ogTLzymupmQtAt0wSDvuHcmZTBD+fT A==;
X-CSE-ConnectionGUID: iPqYgKroTq6GO6sfSg34yw==
X-CSE-MsgGUID: ZbY+CNtIReu62G+5Nlqo3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62879152"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="62879152"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 00:46:05 -0700
X-CSE-ConnectionGUID: LiZ2U3TQTfG6ohL21oy59A==
X-CSE-MsgGUID: gmT3B6k7Sl2w4HoahjA9qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="182177529"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 00:46:03 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 3/3] intel_iommu: Fix DMA failure when guest switches IOMMU
 domain
Date: Thu, 16 Oct 2025 03:45:44 -0400
Message-ID: <20251016074544.377637-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251016074544.377637-1-zhenzhong.duan@intel.com>
References: <20251016074544.377637-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Kernel allows user to switch IOMMU domain, e.g., switch between DMA
and identity domain. When this happen in IOMMU scalable mode, a pasid
cache invalidation request is sent, this request is ignored by vIOMMU
which leads to device binding to wrong address space, then DMA fails.

This issue exists in scalable mode with both first stage and second
stage translations, both emulated and passthrough devices.

Take network device for example, below sequence trigger issue:

1. start a guest with iommu=pt
2. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/unbind
3. echo DMA > /sys/kernel/iommu_groups/6/type
4. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/bind
5. Ping test

Fix it by switching address space in invalidation handler.

Fixes: 4a4f219e8a10 ("intel_iommu: add scalable-mode option to make scalable mode work")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 07bc0a749c..aca51cbd8e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3095,15 +3095,28 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     VTDAddressSpace *vtd_as = value;
     VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
     VTDPASIDEntry pe;
+    IOMMUNotifier *n;
     uint16_t did;
 
     if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
+        if (!pc_entry->valid) {
+            return;
+        }
         /*
          * No valid pasid entry in guest memory. e.g. pasid entry was modified
          * to be either all-zero or non-present. Either case means existing
          * pasid cache should be invalidated.
          */
         pc_entry->valid = false;
+
+        /*
+         * When a pasid entry isn't valid any more, we should unmap all
+         * mappings in shadow pages instantly to ensure DMA security.
+         */
+        IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
+            vtd_address_space_unmap(vtd_as, n);
+        }
+        vtd_switch_address_space(vtd_as);
         return;
     }
 
@@ -3131,6 +3144,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
 
     pc_entry->pasid_entry = pe;
     pc_entry->valid = true;
+
+    vtd_switch_address_space(vtd_as);
+    vtd_address_space_sync(vtd_as);
 }
 
 static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
-- 
2.47.1


