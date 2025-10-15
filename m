Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EFFCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 10:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8yci-0002gB-0N; Wed, 15 Oct 2025 06:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8ych-0002g2-1q
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:20:47 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8ycZ-0007a7-Ur
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760523640; x=1792059640;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tLjir8vU57Lzmr5NMkWaD9W1iZ++DZy9QytNLzENMWk=;
 b=MQGmAngwxy8B6UPrN1w90mRN/0cMNd9+oZlaQW8v5RiAOID8i+cJWSKi
 uw9/l0aUAAIOxY1Y+I4j1FeBIU5rd6dX733uKRngucNbk2dxxi1ZKKsnq
 lzbrIkKTNFrREejutpPtJJ7iOg/doNfq7IYaiCN5lNeZ3lF7aFcNOt49U
 jTKa1vU/NTGnfJ4SClnCinmnlghwMwNgs/ZFmC5KXhR/TxcKBlDsD/KqJ
 3EU14omGahm9EUwiRMbhZXXt1c79a0MQms9aqkEetzf6xxTEuv2ijn2T8
 FgODxPfJcD73QJzCWjW8XL6LYgLiy427KJcMk+RSdGhWTwxPWWy75mAdy Q==;
X-CSE-ConnectionGUID: 6AIzfi7AQbuY7q6rP9tIOA==
X-CSE-MsgGUID: d8EtkCqrQAe7HMRl75WV8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66556799"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="66556799"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:20:29 -0700
X-CSE-ConnectionGUID: EtGi7LU6Q5+Ox8/Y2zfVQg==
X-CSE-MsgGUID: ZLcRI8CsSMGdlHVOnmTmuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="182082698"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:20:27 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 3/3] intel_iommu: Fix DMA failure when guest switches IOMMU
 domain
Date: Wed, 15 Oct 2025 06:20:02 -0400
Message-ID: <20251015102003.279239-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251015102003.279239-1-zhenzhong.duan@intel.com>
References: <20251015102003.279239-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
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
 hw/i386/intel_iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d656e9c256..30275a4f23 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3104,7 +3104,7 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
          * reset where the whole guest memory is treated as zeroed.
          */
         pc_entry->valid = false;
-        return;
+        goto switch_as;
     }
 
     /*
@@ -3134,6 +3134,10 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
 
     pc_entry->pasid_entry = pe;
     pc_entry->valid = true;
+
+switch_as:
+    vtd_switch_address_space(vtd_as);
+    vtd_address_space_sync(vtd_as);
 }
 
 static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
-- 
2.47.1


